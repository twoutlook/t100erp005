#該程式未解開Section, 採用最新樣板產出!
{<section id="amrt200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-07-11 09:40:52), PR版次:0014(2016-11-29 14:44:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000207
#+ Filename...: amrt200
#+ Description: 資源領用維護作業
#+ Creator....: 04226(2014-05-07 15:30:47)
#+ Modifier...: 05384 -SD/PR- 06814
 
{</section>}
 
{<section id="amrt200.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#23  2016/04/22  BY 07900     校验代码重复错误讯息的修改
#160524-00044#2   2016/06/03  By shiun     領用目的只有生产、借出两种类型可选，其他类型隐藏
#160728-00015#1   2016/07/28  By 06948     計算領用量時加上領用單為條件
#160818-00017#23  2016/08/25  By 08742     删除修改未重新判断状态码
#160909-00080#1   2016/09/13  By 02097     修改開窗
#161013-00051#1   2016/10/18  By shiun     整批調整據點組織開窗
#160824-00007#218 2016/11/29  By 06814     新舊值相關調整
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

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_mrdc_m        RECORD
       mrdcdocno LIKE mrdc_t.mrdcdocno, 
   mrdcdocno_desc LIKE type_t.chr80, 
   mrdcdocdt LIKE mrdc_t.mrdcdocdt, 
   mrdc001 LIKE mrdc_t.mrdc001, 
   mrdc002 LIKE mrdc_t.mrdc002, 
   mrdc003 LIKE mrdc_t.mrdc003, 
   mrdc003_desc LIKE type_t.chr80, 
   mrdc004 LIKE mrdc_t.mrdc004, 
   mrdc004_desc LIKE type_t.chr80, 
   mrdcsite LIKE mrdc_t.mrdcsite, 
   mrdcstus LIKE mrdc_t.mrdcstus, 
   mrdc005 LIKE mrdc_t.mrdc005, 
   mrdc006 LIKE mrdc_t.mrdc006, 
   mrdc006_desc LIKE type_t.chr80, 
   mrdc007 LIKE mrdc_t.mrdc007, 
   mrdc008 LIKE mrdc_t.mrdc008, 
   mrdcownid LIKE mrdc_t.mrdcownid, 
   mrdcownid_desc LIKE type_t.chr80, 
   mrdcowndp LIKE mrdc_t.mrdcowndp, 
   mrdcowndp_desc LIKE type_t.chr80, 
   mrdccrtid LIKE mrdc_t.mrdccrtid, 
   mrdccrtid_desc LIKE type_t.chr80, 
   mrdccrtdp LIKE mrdc_t.mrdccrtdp, 
   mrdccrtdp_desc LIKE type_t.chr80, 
   mrdccrtdt LIKE mrdc_t.mrdccrtdt, 
   mrdcmodid LIKE mrdc_t.mrdcmodid, 
   mrdcmodid_desc LIKE type_t.chr80, 
   mrdcmoddt LIKE mrdc_t.mrdcmoddt, 
   mrdccnfid LIKE mrdc_t.mrdccnfid, 
   mrdccnfid_desc LIKE type_t.chr80, 
   mrdccnfdt LIKE mrdc_t.mrdccnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mrdd_d        RECORD
       mrddsite LIKE mrdd_t.mrddsite, 
   mrddseq LIKE mrdd_t.mrddseq, 
   mrdd001 LIKE mrdd_t.mrdd001, 
   mrba004 LIKE type_t.chr500, 
   mrba008 LIKE type_t.chr500, 
   mrba009 LIKE type_t.chr500, 
   mrdd002 LIKE mrdd_t.mrdd002, 
   mrdd003 LIKE mrdd_t.mrdd003, 
   mrdd004 LIKE mrdd_t.mrdd004, 
   mrdd004_desc LIKE type_t.chr500, 
   mrdd005 LIKE mrdd_t.mrdd005, 
   mrdd005_desc LIKE type_t.chr500, 
   mrdd009 LIKE mrdd_t.mrdd009, 
   mrdd006 LIKE mrdd_t.mrdd006, 
   mrdd007 LIKE mrdd_t.mrdd007, 
   mrdd008 LIKE mrdd_t.mrdd008
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mrdcdocno LIKE mrdc_t.mrdcdocno,
      b_mrdcdocdt LIKE mrdc_t.mrdcdocdt,
      b_mrdc001 LIKE mrdc_t.mrdc001,
      b_mrdc003 LIKE mrdc_t.mrdc003,
   b_mrdc003_desc LIKE type_t.chr80,
      b_mrdc004 LIKE mrdc_t.mrdc004,
   b_mrdc004_desc LIKE type_t.chr80,
      b_mrdc005 LIKE mrdc_t.mrdc005,
      b_mrdccrtid LIKE mrdc_t.mrdccrtid,
   b_mrdccrtid_desc LIKE type_t.chr80,
      b_mrdccrtdt LIKE mrdc_t.mrdccrtdt,
      b_mrdcmodid LIKE mrdc_t.mrdcmodid,
   b_mrdcmodid_desc LIKE type_t.chr80,
      b_mrdcmoddt LIKE mrdc_t.mrdcmoddt
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mrdc_m          type_g_mrdc_m
DEFINE g_mrdc_m_t        type_g_mrdc_m
DEFINE g_mrdc_m_o        type_g_mrdc_m
DEFINE g_mrdc_m_mask_o   type_g_mrdc_m #轉換遮罩前資料
DEFINE g_mrdc_m_mask_n   type_g_mrdc_m #轉換遮罩後資料
 
   DEFINE g_mrdcdocno_t LIKE mrdc_t.mrdcdocno
 
 
DEFINE g_mrdd_d          DYNAMIC ARRAY OF type_g_mrdd_d
DEFINE g_mrdd_d_t        type_g_mrdd_d
DEFINE g_mrdd_d_o        type_g_mrdd_d
DEFINE g_mrdd_d_mask_o   DYNAMIC ARRAY OF type_g_mrdd_d #轉換遮罩前資料
DEFINE g_mrdd_d_mask_n   DYNAMIC ARRAY OF type_g_mrdd_d #轉換遮罩後資料
 
 
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
 
{<section id="amrt200.main" >}
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
   CALL cl_ap_init("amr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mrdcdocno,'',mrdcdocdt,mrdc001,mrdc002,mrdc003,'',mrdc004,'',mrdcsite, 
       mrdcstus,mrdc005,mrdc006,'',mrdc007,mrdc008,mrdcownid,'',mrdcowndp,'',mrdccrtid,'',mrdccrtdp, 
       '',mrdccrtdt,mrdcmodid,'',mrdcmoddt,mrdccnfid,'',mrdccnfdt", 
                      " FROM mrdc_t",
                      " WHERE mrdcent= ? AND mrdcdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mrdcdocno,t0.mrdcdocdt,t0.mrdc001,t0.mrdc002,t0.mrdc003,t0.mrdc004, 
       t0.mrdcsite,t0.mrdcstus,t0.mrdc005,t0.mrdc006,t0.mrdc007,t0.mrdc008,t0.mrdcownid,t0.mrdcowndp, 
       t0.mrdccrtid,t0.mrdccrtdp,t0.mrdccrtdt,t0.mrdcmodid,t0.mrdcmoddt,t0.mrdccnfid,t0.mrdccnfdt,t1.ooag011 , 
       t2.ooefl003 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011", 
 
               " FROM mrdc_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdc003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdc004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mrdc006 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdcownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.mrdcowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mrdccrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.mrdccrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mrdcmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.mrdccnfid  ",
 
               " WHERE t0.mrdcent = " ||g_enterprise|| " AND t0.mrdcdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amrt200_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amrt200 WITH FORM cl_ap_formpath("amr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amrt200_init()   
 
      #進入選單 Menu (="N")
      CALL amrt200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amrt200
      
   END IF 
   
   CLOSE amrt200_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amrt200.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amrt200_init()
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
      CALL cl_set_combo_scc_part('mrdcstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mrdc001','5211') 
   CALL cl_set_combo_scc('mrdc005','5212') 
   CALL cl_set_combo_scc('mrdd007','5442') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('mrdc001','5211','1,5')   #add--160524-00044#2 By shiun
   CALL cl_set_combo_scc('b_mrdc001','5211') 
   CALL cl_set_combo_scc('b_mrdc005','5212') 
   LET g_ooef004 = ''
   SELECT ooef004
     INTO g_ooef004
     FROM ooef_t
    WHERE ooef001 = g_site
      AND ooefent = g_enterprise
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   LET g_errshow = 1
   #end add-point
   
   #初始化搜尋條件
   CALL amrt200_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amrt200.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amrt200_ui_dialog()
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
            CALL amrt200_insert()
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
         INITIALIZE g_mrdc_m.* TO NULL
         CALL g_mrdd_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amrt200_init()
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
               
               CALL amrt200_fetch('') # reload data
               LET l_ac = 1
               CALL amrt200_ui_detailshow() #Setting the current row 
         
               CALL amrt200_idx_chk()
               #NEXT FIELD mrddseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mrdd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrt200_idx_chk()
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
               CALL amrt200_idx_chk()
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
            CALL amrt200_browser_fill("")
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
               CALL amrt200_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amrt200_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amrt200_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amrt200_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amrt200_set_act_visible()   
            CALL amrt200_set_act_no_visible()
            IF NOT (g_mrdc_m.mrdcdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mrdcent = " ||g_enterprise|| " AND",
                                  " mrdcdocno = '", g_mrdc_m.mrdcdocno, "' "
 
               #填到對應位置
               CALL amrt200_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "mrdc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdd_t" 
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
               CALL amrt200_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mrdc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrdd_t" 
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
                  CALL amrt200_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amrt200_fetch("F")
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
               CALL amrt200_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amrt200_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt200_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amrt200_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt200_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amrt200_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt200_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amrt200_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt200_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amrt200_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrt200_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mrdd_d)
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
               NEXT FIELD mrddseq
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
               CALL amrt200_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amrt200_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amrt200_query()
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
               &include "erp/amr/amrt200_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amr/amrt200_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL amrt200_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL amrt200_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amrt200_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amrt200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amrt200_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amrt200_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mrdc_m.mrdcdocdt)
 
 
 
         
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
 
{<section id="amrt200.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amrt200_browser_fill(ps_page_action)
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
   LET l_wc = l_wc," AND mrdcsite = '",g_site,"'"
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mrdcdocno ",
                      " FROM mrdc_t ",
                      " ",
                      " LEFT JOIN mrdd_t ON mrddent = mrdcent AND mrdcdocno = mrdddocno ", "  ",
                      #add-point:browser_fill段sql(mrdd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE mrdcent = " ||g_enterprise|| " AND mrddent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrdc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mrdcdocno ",
                      " FROM mrdc_t ", 
                      "  ",
                      "  ",
                      " WHERE mrdcent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mrdc_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   LET g_wc = g_wc," AND mrdcsite = '",g_site,"'"
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
      INITIALIZE g_mrdc_m.* TO NULL
      CALL g_mrdd_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mrdcdocno,t0.mrdcdocdt,t0.mrdc001,t0.mrdc003,t0.mrdc004,t0.mrdc005,t0.mrdccrtid,t0.mrdccrtdt,t0.mrdcmodid,t0.mrdcmoddt Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdcstus,t0.mrdcdocno,t0.mrdcdocdt,t0.mrdc001,t0.mrdc003,t0.mrdc004, 
          t0.mrdc005,t0.mrdccrtid,t0.mrdccrtdt,t0.mrdcmodid,t0.mrdcmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
          t4.ooag011 ",
                  " FROM mrdc_t t0",
                  "  ",
                  "  LEFT JOIN mrdd_t ON mrddent = mrdcent AND mrdcdocno = mrdddocno ", "  ", 
                  #add-point:browser_fill段sql(mrdd_t1) name="browser_fill.join.mrdd_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdc003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdc004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mrdccrtid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdcmodid  ",
 
                  " WHERE t0.mrdcent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mrdc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrdcstus,t0.mrdcdocno,t0.mrdcdocdt,t0.mrdc001,t0.mrdc003,t0.mrdc004, 
          t0.mrdc005,t0.mrdccrtid,t0.mrdccrtdt,t0.mrdcmodid,t0.mrdcmoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 , 
          t4.ooag011 ",
                  " FROM mrdc_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.mrdc003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mrdc004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mrdccrtid  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mrdcmodid  ",
 
                  " WHERE t0.mrdcent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mrdc_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mrdcdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mrdc_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mrdcdocno,g_browser[g_cnt].b_mrdcdocdt, 
          g_browser[g_cnt].b_mrdc001,g_browser[g_cnt].b_mrdc003,g_browser[g_cnt].b_mrdc004,g_browser[g_cnt].b_mrdc005, 
          g_browser[g_cnt].b_mrdccrtid,g_browser[g_cnt].b_mrdccrtdt,g_browser[g_cnt].b_mrdcmodid,g_browser[g_cnt].b_mrdcmoddt, 
          g_browser[g_cnt].b_mrdc003_desc,g_browser[g_cnt].b_mrdc004_desc,g_browser[g_cnt].b_mrdccrtid_desc, 
          g_browser[g_cnt].b_mrdcmodid_desc
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
         CALL amrt200_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_mrdcdocno) THEN
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
 
{<section id="amrt200.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amrt200_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mrdc_m.mrdcdocno = g_browser[g_current_idx].b_mrdcdocno   
 
   EXECUTE amrt200_master_referesh USING g_mrdc_m.mrdcdocno INTO g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt, 
       g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus, 
       g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp, 
       g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt, 
       g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdc006_desc, 
       g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp_desc, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdccnfid_desc
   
   CALL amrt200_mrdc_t_mask()
   CALL amrt200_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amrt200.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amrt200_ui_detailshow()
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
 
{<section id="amrt200.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amrt200_ui_browser_refresh()
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
      IF g_browser[l_i].b_mrdcdocno = g_mrdc_m.mrdcdocno 
 
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
 
{<section id="amrt200.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amrt200_construct()
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
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_mrdc_m.* TO NULL
   CALL g_mrdd_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON mrdcdocno,mrdcdocdt,mrdc001,mrdc002,mrdc003,mrdc004,mrdcsite,mrdcstus, 
          mrdc005,mrdc006,mrdc007,mrdc008,mrdcownid,mrdcowndp,mrdccrtid,mrdccrtdp,mrdccrtdt,mrdcmodid, 
          mrdcmoddt,mrdccnfid,mrdccnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrdccrtdt>>----
         AFTER FIELD mrdccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mrdcmoddt>>----
         AFTER FIELD mrdcmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdccnfdt>>----
         AFTER FIELD mrdccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrdcpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mrdcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcdocno
            #add-point:ON ACTION controlp INFIELD mrdcdocno name="construct.c.mrdcdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrdcdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdcdocno  #顯示到畫面上
            NEXT FIELD mrdcdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcdocno
            #add-point:BEFORE FIELD mrdcdocno name="construct.b.mrdcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcdocno
            
            #add-point:AFTER FIELD mrdcdocno name="construct.a.mrdcdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcdocdt
            #add-point:BEFORE FIELD mrdcdocdt name="construct.b.mrdcdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcdocdt
            
            #add-point:AFTER FIELD mrdcdocdt name="construct.a.mrdcdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcdocdt
            #add-point:ON ACTION controlp INFIELD mrdcdocdt name="construct.c.mrdcdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc001
            #add-point:BEFORE FIELD mrdc001 name="construct.b.mrdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc001
            
            #add-point:AFTER FIELD mrdc001 name="construct.a.mrdc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc001
            #add-point:ON ACTION controlp INFIELD mrdc001 name="construct.c.mrdc001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc002
            #add-point:BEFORE FIELD mrdc002 name="construct.b.mrdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc002
            
            #add-point:AFTER FIELD mrdc002 name="construct.a.mrdc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc002
            #add-point:ON ACTION controlp INFIELD mrdc002 name="construct.c.mrdc002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc003
            #add-point:ON ACTION controlp INFIELD mrdc003 name="construct.c.mrdc003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdc003  #顯示到畫面上
            NEXT FIELD mrdc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc003
            #add-point:BEFORE FIELD mrdc003 name="construct.b.mrdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc003
            
            #add-point:AFTER FIELD mrdc003 name="construct.a.mrdc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc004
            #add-point:ON ACTION controlp INFIELD mrdc004 name="construct.c.mrdc004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdc004  #顯示到畫面上
            NEXT FIELD mrdc004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc004
            #add-point:BEFORE FIELD mrdc004 name="construct.b.mrdc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc004
            
            #add-point:AFTER FIELD mrdc004 name="construct.a.mrdc004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcsite
            #add-point:BEFORE FIELD mrdcsite name="construct.b.mrdcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcsite
            
            #add-point:AFTER FIELD mrdcsite name="construct.a.mrdcsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcsite
            #add-point:ON ACTION controlp INFIELD mrdcsite name="construct.c.mrdcsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcstus
            #add-point:BEFORE FIELD mrdcstus name="construct.b.mrdcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcstus
            
            #add-point:AFTER FIELD mrdcstus name="construct.a.mrdcstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcstus
            #add-point:ON ACTION controlp INFIELD mrdcstus name="construct.c.mrdcstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc005
            #add-point:BEFORE FIELD mrdc005 name="construct.b.mrdc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc005
            
            #add-point:AFTER FIELD mrdc005 name="construct.a.mrdc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc005
            #add-point:ON ACTION controlp INFIELD mrdc005 name="construct.c.mrdc005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc006
            #add-point:ON ACTION controlp INFIELD mrdc006 name="construct.c.mrdc006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrdc006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdc006  #顯示到畫面上
            NEXT FIELD mrdc006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc006
            #add-point:BEFORE FIELD mrdc006 name="construct.b.mrdc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc006
            
            #add-point:AFTER FIELD mrdc006 name="construct.a.mrdc006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc007
            #add-point:BEFORE FIELD mrdc007 name="construct.b.mrdc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc007
            
            #add-point:AFTER FIELD mrdc007 name="construct.a.mrdc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc007
            #add-point:ON ACTION controlp INFIELD mrdc007 name="construct.c.mrdc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc008
            #add-point:BEFORE FIELD mrdc008 name="construct.b.mrdc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc008
            
            #add-point:AFTER FIELD mrdc008 name="construct.a.mrdc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc008
            #add-point:ON ACTION controlp INFIELD mrdc008 name="construct.c.mrdc008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdcownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcownid
            #add-point:ON ACTION controlp INFIELD mrdcownid name="construct.c.mrdcownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdcownid  #顯示到畫面上
            NEXT FIELD mrdcownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcownid
            #add-point:BEFORE FIELD mrdcownid name="construct.b.mrdcownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcownid
            
            #add-point:AFTER FIELD mrdcownid name="construct.a.mrdcownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdcowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcowndp
            #add-point:ON ACTION controlp INFIELD mrdcowndp name="construct.c.mrdcowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdcowndp  #顯示到畫面上
            NEXT FIELD mrdcowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcowndp
            #add-point:BEFORE FIELD mrdcowndp name="construct.b.mrdcowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcowndp
            
            #add-point:AFTER FIELD mrdcowndp name="construct.a.mrdcowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdccrtid
            #add-point:ON ACTION controlp INFIELD mrdccrtid name="construct.c.mrdccrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdccrtid  #顯示到畫面上
            NEXT FIELD mrdccrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdccrtid
            #add-point:BEFORE FIELD mrdccrtid name="construct.b.mrdccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdccrtid
            
            #add-point:AFTER FIELD mrdccrtid name="construct.a.mrdccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrdccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdccrtdp
            #add-point:ON ACTION controlp INFIELD mrdccrtdp name="construct.c.mrdccrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdccrtdp  #顯示到畫面上
            NEXT FIELD mrdccrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdccrtdp
            #add-point:BEFORE FIELD mrdccrtdp name="construct.b.mrdccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdccrtdp
            
            #add-point:AFTER FIELD mrdccrtdp name="construct.a.mrdccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdccrtdt
            #add-point:BEFORE FIELD mrdccrtdt name="construct.b.mrdccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdcmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcmodid
            #add-point:ON ACTION controlp INFIELD mrdcmodid name="construct.c.mrdcmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdcmodid  #顯示到畫面上
            NEXT FIELD mrdcmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcmodid
            #add-point:BEFORE FIELD mrdcmodid name="construct.b.mrdcmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcmodid
            
            #add-point:AFTER FIELD mrdcmodid name="construct.a.mrdcmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcmoddt
            #add-point:BEFORE FIELD mrdcmoddt name="construct.b.mrdcmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrdccnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdccnfid
            #add-point:ON ACTION controlp INFIELD mrdccnfid name="construct.c.mrdccnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdccnfid  #顯示到畫面上
            NEXT FIELD mrdccnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdccnfid
            #add-point:BEFORE FIELD mrdccnfid name="construct.b.mrdccnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdccnfid
            
            #add-point:AFTER FIELD mrdccnfid name="construct.a.mrdccnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdccnfdt
            #add-point:BEFORE FIELD mrdccnfdt name="construct.b.mrdccnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mrddsite,mrddseq,mrdd001,mrdd002,mrdd003,mrdd004,mrdd005,mrdd009,mrdd006, 
          mrdd007,mrdd008
           FROM s_detail1[1].mrddsite,s_detail1[1].mrddseq,s_detail1[1].mrdd001,s_detail1[1].mrdd002, 
               s_detail1[1].mrdd003,s_detail1[1].mrdd004,s_detail1[1].mrdd005,s_detail1[1].mrdd009,s_detail1[1].mrdd006, 
               s_detail1[1].mrdd007,s_detail1[1].mrdd008
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrddsite
            #add-point:BEFORE FIELD mrddsite name="construct.b.page1.mrddsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrddsite
            
            #add-point:AFTER FIELD mrddsite name="construct.a.page1.mrddsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrddsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrddsite
            #add-point:ON ACTION controlp INFIELD mrddsite name="construct.c.page1.mrddsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrddseq
            #add-point:BEFORE FIELD mrddseq name="construct.b.page1.mrddseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrddseq
            
            #add-point:AFTER FIELD mrddseq name="construct.a.page1.mrddseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrddseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrddseq
            #add-point:ON ACTION controlp INFIELD mrddseq name="construct.c.page1.mrddseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd001
            #add-point:ON ACTION controlp INFIELD mrdd001 name="construct.c.page1.mrdd001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdd001  #顯示到畫面上
            NEXT FIELD mrdd001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd001
            #add-point:BEFORE FIELD mrdd001 name="construct.b.page1.mrdd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd001
            
            #add-point:AFTER FIELD mrdd001 name="construct.a.page1.mrdd001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd002
            #add-point:BEFORE FIELD mrdd002 name="construct.b.page1.mrdd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd002
            
            #add-point:AFTER FIELD mrdd002 name="construct.a.page1.mrdd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd002
            #add-point:ON ACTION controlp INFIELD mrdd002 name="construct.c.page1.mrdd002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd003
            #add-point:BEFORE FIELD mrdd003 name="construct.b.page1.mrdd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd003
            
            #add-point:AFTER FIELD mrdd003 name="construct.a.page1.mrdd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd003
            #add-point:ON ACTION controlp INFIELD mrdd003 name="construct.c.page1.mrdd003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrdd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd004
            #add-point:ON ACTION controlp INFIELD mrdd004 name="construct.c.page1.mrdd004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdd004  #顯示到畫面上
            NEXT FIELD mrdd004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd004
            #add-point:BEFORE FIELD mrdd004 name="construct.b.page1.mrdd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd004
            
            #add-point:AFTER FIELD mrdd004 name="construct.a.page1.mrdd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd005
            #add-point:ON ACTION controlp INFIELD mrdd005 name="construct.c.page1.mrdd005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrdd005  #顯示到畫面上
            NEXT FIELD mrdd005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd005
            #add-point:BEFORE FIELD mrdd005 name="construct.b.page1.mrdd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd005
            
            #add-point:AFTER FIELD mrdd005 name="construct.a.page1.mrdd005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd009
            #add-point:BEFORE FIELD mrdd009 name="construct.b.page1.mrdd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd009
            
            #add-point:AFTER FIELD mrdd009 name="construct.a.page1.mrdd009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd009
            #add-point:ON ACTION controlp INFIELD mrdd009 name="construct.c.page1.mrdd009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd006
            #add-point:BEFORE FIELD mrdd006 name="construct.b.page1.mrdd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd006
            
            #add-point:AFTER FIELD mrdd006 name="construct.a.page1.mrdd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd006
            #add-point:ON ACTION controlp INFIELD mrdd006 name="construct.c.page1.mrdd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd007
            #add-point:BEFORE FIELD mrdd007 name="construct.b.page1.mrdd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd007
            
            #add-point:AFTER FIELD mrdd007 name="construct.a.page1.mrdd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd007
            #add-point:ON ACTION controlp INFIELD mrdd007 name="construct.c.page1.mrdd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd008
            #add-point:BEFORE FIELD mrdd008 name="construct.b.page1.mrdd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd008
            
            #add-point:AFTER FIELD mrdd008 name="construct.a.page1.mrdd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrdd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd008
            #add-point:ON ACTION controlp INFIELD mrdd008 name="construct.c.page1.mrdd008"
            
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
                  WHEN la_wc[li_idx].tableid = "mrdc_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mrdd_t" 
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
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amrt200_filter()
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
      CONSTRUCT g_wc_filter ON mrdcdocno,mrdcdocdt,mrdc001,mrdc003,mrdc004,mrdc005,mrdccrtid,mrdccrtdt, 
          mrdcmodid,mrdcmoddt
                          FROM s_browse[1].b_mrdcdocno,s_browse[1].b_mrdcdocdt,s_browse[1].b_mrdc001, 
                              s_browse[1].b_mrdc003,s_browse[1].b_mrdc004,s_browse[1].b_mrdc005,s_browse[1].b_mrdccrtid, 
                              s_browse[1].b_mrdccrtdt,s_browse[1].b_mrdcmodid,s_browse[1].b_mrdcmoddt 
 
 
         BEFORE CONSTRUCT
               DISPLAY amrt200_filter_parser('mrdcdocno') TO s_browse[1].b_mrdcdocno
            DISPLAY amrt200_filter_parser('mrdcdocdt') TO s_browse[1].b_mrdcdocdt
            DISPLAY amrt200_filter_parser('mrdc001') TO s_browse[1].b_mrdc001
            DISPLAY amrt200_filter_parser('mrdc003') TO s_browse[1].b_mrdc003
            DISPLAY amrt200_filter_parser('mrdc004') TO s_browse[1].b_mrdc004
            DISPLAY amrt200_filter_parser('mrdc005') TO s_browse[1].b_mrdc005
            DISPLAY amrt200_filter_parser('mrdccrtid') TO s_browse[1].b_mrdccrtid
            DISPLAY amrt200_filter_parser('mrdccrtdt') TO s_browse[1].b_mrdccrtdt
            DISPLAY amrt200_filter_parser('mrdcmodid') TO s_browse[1].b_mrdcmodid
            DISPLAY amrt200_filter_parser('mrdcmoddt') TO s_browse[1].b_mrdcmoddt
      
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
 
      CALL amrt200_filter_show('mrdcdocno')
   CALL amrt200_filter_show('mrdcdocdt')
   CALL amrt200_filter_show('mrdc001')
   CALL amrt200_filter_show('mrdc003')
   CALL amrt200_filter_show('mrdc004')
   CALL amrt200_filter_show('mrdc005')
   CALL amrt200_filter_show('mrdccrtid')
   CALL amrt200_filter_show('mrdccrtdt')
   CALL amrt200_filter_show('mrdcmodid')
   CALL amrt200_filter_show('mrdcmoddt')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amrt200_filter_parser(ps_field)
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
 
{<section id="amrt200.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amrt200_filter_show(ps_field)
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
   LET ls_condition = amrt200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amrt200_query()
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
   CALL g_mrdd_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amrt200_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amrt200_browser_fill("")
      CALL amrt200_fetch("")
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
      CALL amrt200_filter_show('mrdcdocno')
   CALL amrt200_filter_show('mrdcdocdt')
   CALL amrt200_filter_show('mrdc001')
   CALL amrt200_filter_show('mrdc003')
   CALL amrt200_filter_show('mrdc004')
   CALL amrt200_filter_show('mrdc005')
   CALL amrt200_filter_show('mrdccrtid')
   CALL amrt200_filter_show('mrdccrtdt')
   CALL amrt200_filter_show('mrdcmodid')
   CALL amrt200_filter_show('mrdcmoddt')
   CALL amrt200_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amrt200_fetch("F") 
      #顯示單身筆數
      CALL amrt200_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amrt200_fetch(p_flag)
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
   
   LET g_mrdc_m.mrdcdocno = g_browser[g_current_idx].b_mrdcdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amrt200_master_referesh USING g_mrdc_m.mrdcdocno INTO g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt, 
       g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus, 
       g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp, 
       g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt, 
       g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdc006_desc, 
       g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp_desc, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdccnfid_desc
   
   #遮罩相關處理
   LET g_mrdc_m_mask_o.* =  g_mrdc_m.*
   CALL amrt200_mrdc_t_mask()
   LET g_mrdc_m_mask_n.* =  g_mrdc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt200_set_act_visible()   
   CALL amrt200_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #2014/12/02 by stellar mark ----- (S)
   #改移到set_act_visible內
#   CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)
#   
#   IF g_mrdc_m.mrdcstus NOT MATCHES '[NDR]' THEN  # N未確認/D抽單/R已拒絕允許修改
#      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
#   END IF
#   
#   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
#       CALL cl_set_act_visible("bpm_status",FALSE)
#   END IF
   #2014/12/02 by stellar mrkd ----- (E)
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrdc_m_t.* = g_mrdc_m.*
   LET g_mrdc_m_o.* = g_mrdc_m.*
   
   LET g_data_owner = g_mrdc_m.mrdcownid      
   LET g_data_dept  = g_mrdc_m.mrdcowndp
   
   #重新顯示   
   CALL amrt200_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.insert" >}
#+ 資料新增
PRIVATE FUNCTION amrt200_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_doctype       LIKE rtai_t.rtai004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mrdd_d.clear()   
 
 
   INITIALIZE g_mrdc_m.* TO NULL             #DEFAULT 設定
   
   LET g_mrdcdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrdc_m.mrdcownid = g_user
      LET g_mrdc_m.mrdcowndp = g_dept
      LET g_mrdc_m.mrdccrtid = g_user
      LET g_mrdc_m.mrdccrtdp = g_dept 
      LET g_mrdc_m.mrdccrtdt = cl_get_current()
      LET g_mrdc_m.mrdcmodid = g_user
      LET g_mrdc_m.mrdcmoddt = cl_get_current()
      LET g_mrdc_m.mrdcstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mrdc_m.mrdc001 = "5"
      LET g_mrdc_m.mrdcstus = "N"
      LET g_mrdc_m.mrdc005 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_mrdc_m.mrdcsite = g_site
      LET g_mrdc_m.mrdcdocdt = g_today
      LET g_mrdc_m.mrdc003 = g_user
      LET g_mrdc_m.mrdc004 = g_dept
      CALL amrt200_mrdc003_ref()
      CALL amrt200_mrdc004_ref()
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mrdc_m.mrdcsite,g_prog,'1')
         RETURNING r_success,r_doctype
      LET g_mrdc_m.mrdcdocno = r_doctype
      CALL s_aooi200_get_slip_desc(g_mrdc_m.mrdcdocno) RETURNING g_mrdc_m.mrdcdocno_desc
      DISPLAY BY NAME g_mrdc_m.mrdcdocno_desc
      LET g_mrdc_m_t.* = g_mrdc_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mrdc_m_t.* = g_mrdc_m.*
      LET g_mrdc_m_o.* = g_mrdc_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdc_m.mrdcstus 
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
 
 
 
    
      CALL amrt200_input("a")
      
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
         INITIALIZE g_mrdc_m.* TO NULL
         INITIALIZE g_mrdd_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amrt200_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mrdd_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrt200_set_act_visible()   
   CALL amrt200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdcdocno_t = g_mrdc_m.mrdcdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdcent = " ||g_enterprise|| " AND",
                      " mrdcdocno = '", g_mrdc_m.mrdcdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amrt200_cl
   
   CALL amrt200_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amrt200_master_referesh USING g_mrdc_m.mrdcdocno INTO g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt, 
       g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus, 
       g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp, 
       g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt, 
       g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdc006_desc, 
       g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp_desc, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdccnfid_desc
   
   
   #遮罩相關處理
   LET g_mrdc_m_mask_o.* =  g_mrdc_m.*
   CALL amrt200_mrdc_t_mask()
   LET g_mrdc_m_mask_n.* =  g_mrdc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocno_desc,g_mrdc_m.mrdcdocdt,g_mrdc_m.mrdc001,g_mrdc_m.mrdc002, 
       g_mrdc_m.mrdc003,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdcsite, 
       g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc006_desc,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008, 
       g_mrdc_m.mrdcownid,g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid, 
       g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdp_desc,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdcmoddt,g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfid_desc,g_mrdc_m.mrdccnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mrdc_m.mrdcownid      
   LET g_data_dept  = g_mrdc_m.mrdcowndp
   
   #功能已完成,通報訊息中心
   CALL amrt200_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.modify" >}
#+ 資料修改
PRIVATE FUNCTION amrt200_modify()
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
   LET g_mrdc_m_t.* = g_mrdc_m.*
   LET g_mrdc_m_o.* = g_mrdc_m.*
   
   IF g_mrdc_m.mrdcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mrdcdocno_t = g_mrdc_m.mrdcdocno
 
   CALL s_transaction_begin()
   
   OPEN amrt200_cl USING g_enterprise,g_mrdc_m.mrdcdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt200_master_referesh USING g_mrdc_m.mrdcdocno INTO g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt, 
       g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus, 
       g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp, 
       g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt, 
       g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdc006_desc, 
       g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp_desc, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdccnfid_desc
   
   #檢查是否允許此動作
   IF NOT amrt200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrdc_m_mask_o.* =  g_mrdc_m.*
   CALL amrt200_mrdc_t_mask()
   LET g_mrdc_m_mask_n.* =  g_mrdc_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL amrt200_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mrdcdocno_t = g_mrdc_m.mrdcdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mrdc_m.mrdcmodid = g_user 
LET g_mrdc_m.mrdcmoddt = cl_get_current()
LET g_mrdc_m.mrdcmodid_desc = cl_get_username(g_mrdc_m.mrdcmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_mrdc_m.mrdcstus MATCHES "[DR]" THEN 
         LET g_mrdc_m.mrdcstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amrt200_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mrdc_t SET (mrdcmodid,mrdcmoddt) = (g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt)
          WHERE mrdcent = g_enterprise AND mrdcdocno = g_mrdcdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mrdc_m.* = g_mrdc_m_t.*
            CALL amrt200_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mrdc_m.mrdcdocno != g_mrdc_m_t.mrdcdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mrdd_t SET mrdddocno = g_mrdc_m.mrdcdocno
 
          WHERE mrddent = g_enterprise AND mrdddocno = g_mrdc_m_t.mrdcdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrdd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdd_t:",SQLERRMESSAGE 
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
   CALL amrt200_set_act_visible()   
   CALL amrt200_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mrdcent = " ||g_enterprise|| " AND",
                      " mrdcdocno = '", g_mrdc_m.mrdcdocno, "' "
 
   #填到對應位置
   CALL amrt200_browser_fill("")
 
   CLOSE amrt200_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt200_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amrt200.input" >}
#+ 資料輸入
PRIVATE FUNCTION amrt200_input(p_cmd)
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
   DEFINE l_flag           LIKE type_t.num5
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
   DISPLAY BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocno_desc,g_mrdc_m.mrdcdocdt,g_mrdc_m.mrdc001,g_mrdc_m.mrdc002, 
       g_mrdc_m.mrdc003,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdcsite, 
       g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc006_desc,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008, 
       g_mrdc_m.mrdcownid,g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid, 
       g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdp_desc,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdcmoddt,g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfid_desc,g_mrdc_m.mrdccnfdt 
 
   
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
   LET g_forupd_sql = "SELECT mrddsite,mrddseq,mrdd001,mrdd002,mrdd003,mrdd004,mrdd005,mrdd009,mrdd006, 
       mrdd007,mrdd008 FROM mrdd_t WHERE mrddent=? AND mrdddocno=? AND mrddseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrt200_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amrt200_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL amrt200_set_no_required()
   CALL amrt200_set_required()
   #end add-point
   CALL amrt200_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt,g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003, 
       g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007, 
       g_mrdc_m.mrdc008
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amrt200.input.head" >}
      #單頭段
      INPUT BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt,g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003, 
          g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007, 
          g_mrdc_m.mrdc008 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amrt200_cl USING g_enterprise,g_mrdc_m.mrdcdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amrt200_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL cl_showmsg_init()
            #end add-point
            CALL amrt200_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcdocno
            
            #add-point:AFTER FIELD mrdcdocno name="input.a.mrdcdocno"
            CALL s_aooi200_get_slip_desc(g_mrdc_m.mrdcdocno) RETURNING g_mrdc_m.mrdcdocno_desc
            DISPLAY BY NAME g_mrdc_m.mrdcdocno_desc
            IF  NOT cl_null(g_mrdc_m.mrdcdocno) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrdc_m.mrdcdocno != g_mrdcdocno_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdc_t WHERE "||"mrdcent = '" ||g_enterprise|| "' AND "||"mrdcdocno = '"||g_mrdc_m.mrdcdocno ||"'",'std-00004',0) THEN 
                     LET g_mrdc_m.mrdcdocno = g_mrdcdocno_t
                     CALL s_aooi200_get_slip_desc(g_mrdc_m.mrdcdocno) RETURNING g_mrdc_m.mrdcdocno_desc
                     DISPLAY BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_mrdc_m.mrdcdocno,g_prog) THEN
                     LET g_mrdc_m.mrdcdocno = g_mrdcdocno_t
                     CALL s_aooi200_get_slip_desc(g_mrdc_m.mrdcdocno) RETURNING g_mrdc_m.mrdcdocno_desc
                     DISPLAY BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_get_slip_desc(g_mrdc_m.mrdcdocno) RETURNING g_mrdc_m.mrdcdocno_desc
                  DISPLAY BY NAME g_mrdc_m.mrdcdocno_desc
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcdocno
            #add-point:BEFORE FIELD mrdcdocno name="input.b.mrdcdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdcdocno
            #add-point:ON CHANGE mrdcdocno name="input.g.mrdcdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcdocdt
            #add-point:BEFORE FIELD mrdcdocdt name="input.b.mrdcdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcdocdt
            
            #add-point:AFTER FIELD mrdcdocdt name="input.a.mrdcdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdcdocdt
            #add-point:ON CHANGE mrdcdocdt name="input.g.mrdcdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc001
            #add-point:BEFORE FIELD mrdc001 name="input.b.mrdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc001
            
            #add-point:AFTER FIELD mrdc001 name="input.a.mrdc001"
            CALL amrt200_set_no_required()
            CALL amrt200_set_required()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdc001
            #add-point:ON CHANGE mrdc001 name="input.g.mrdc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc002
            #add-point:BEFORE FIELD mrdc002 name="input.b.mrdc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc002
            
            #add-point:AFTER FIELD mrdc002 name="input.a.mrdc002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdc002
            #add-point:ON CHANGE mrdc002 name="input.g.mrdc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc003
            
            #add-point:AFTER FIELD mrdc003 name="input.a.mrdc003"
            LET g_mrdc_m.mrdc003_desc = ' '
            DISPLAY BY NAME g_mrdc_m.mrdc003_desc
            IF NOT cl_null(g_mrdc_m.mrdc003) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdc_m.mrdc003 != g_mrdc_m_t.mrdc003 OR g_mrdc_m_t.mrdc003 IS NULL )) THEN   #160824-00007#218 20161129 mark by beckxie
               IF g_mrdc_m.mrdc003 != g_mrdc_m_o.mrdc003 OR cl_null(g_mrdc_m_o.mrdc003) THEN   #160824-00007#218 20161129 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdc_m.mrdc003
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#23  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     #LET g_mrdc_m.mrdc003 = g_mrdc_m_t.mrdc003   #160824-00007#218 20161129 mark by beckxie
                     #160824-00007#218 20161129 add by beckxie---S
                     LET g_mrdc_m.mrdc003 = g_mrdc_m_o.mrdc003   
                     LET g_mrdc_m.mrdc004 = g_mrdc_m_o.mrdc004   
                     LET g_mrdc_m.mrdc004_desc = g_mrdc_m_o.mrdc004_desc   
                     #160824-00007#218 20161129 add by beckxie---E
                     CALL amrt200_mrdc003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF cl_null(g_mrdc_m.mrdc004) THEN
               CALL amrt200_mrdc003_values()
               CALL amrt200_mrdc004_ref()
            END IF
            CALL amrt200_mrdc003_ref()
            
            LET g_mrdc_m_o.* = g_mrdc_m.*   #160824-00007#218 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc003
            #add-point:BEFORE FIELD mrdc003 name="input.b.mrdc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdc003
            #add-point:ON CHANGE mrdc003 name="input.g.mrdc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc004
            
            #add-point:AFTER FIELD mrdc004 name="input.a.mrdc004"
            LET g_mrdc_m.mrdc004_desc = ' '
            DISPLAY BY NAME g_mrdc_m.mrdc004_desc
            IF NOT cl_null(g_mrdc_m.mrdc001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdc_m.mrdc004 != g_mrdc_m_t.mrdc004 OR g_mrdc_m_t.mrdc004 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdc_m.mrdc004
                  LET g_chkparam.arg2 = g_mrdc_m.mrdcdocdt
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#23  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_mrdc_m.mrdc004 = g_mrdc_m_t.mrdc004
                     CALL amrt200_mrdc004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL amrt200_mrdc004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc004
            #add-point:BEFORE FIELD mrdc004 name="input.b.mrdc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdc004
            #add-point:ON CHANGE mrdc004 name="input.g.mrdc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcsite
            #add-point:BEFORE FIELD mrdcsite name="input.b.mrdcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcsite
            
            #add-point:AFTER FIELD mrdcsite name="input.a.mrdcsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdcsite
            #add-point:ON CHANGE mrdcsite name="input.g.mrdcsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdcstus
            #add-point:BEFORE FIELD mrdcstus name="input.b.mrdcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdcstus
            
            #add-point:AFTER FIELD mrdcstus name="input.a.mrdcstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdcstus
            #add-point:ON CHANGE mrdcstus name="input.g.mrdcstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc005
            #add-point:BEFORE FIELD mrdc005 name="input.b.mrdc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc005
            
            #add-point:AFTER FIELD mrdc005 name="input.a.mrdc005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdc005
            #add-point:ON CHANGE mrdc005 name="input.g.mrdc005"
            LET g_mrdc_m.mrdc006 = ''
            LET g_mrdc_m.mrdc006_desc = ''
            DISPLAY BY NAME g_mrdc_m.mrdc006,g_mrdc_m.mrdc006_desc
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc006
            
            #add-point:AFTER FIELD mrdc006 name="input.a.mrdc006"
            LET g_mrdc_m.mrdc006_desc = ''
            DISPLAY BY NAME g_mrdc_m.mrdc006_desc
            IF NOT cl_null(g_mrdc_m.mrdc006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdc_m.mrdc006 != g_mrdc_m_t.mrdc006 OR g_mrdc_m_t.mrdc006 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  CASE g_mrdc_m.mrdc005
                     WHEN '1'    #部門
                        LET g_chkparam.arg1 = g_mrdc_m.mrdc006
                        LET g_chkparam.arg2 = g_mrdc_m.mrdcdocdt
                        #160318-00025#23  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                        #160318-00025#23  by 07900 --add-end 
                        IF NOT cl_chk_exist("v_ooeg001") THEN
                           IF g_mrdc_m.mrdc005 = g_mrdc_m_t.mrdc005 THEN
                              LET g_mrdc_m.mrdc006 = g_mrdc_m_t.mrdc006
                           ELSE
                              LET g_mrdc_m.mrdc006 = ''
                           END IF
                           CALL amrt200_mrdc006_ref()
                           NEXT FIELD CURRENT
                        END IF
                     WHEN '2'    #據點
                        LET g_chkparam.arg1 = g_mrdc_m.mrdc006
                        #160318-00025#23  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                         #160318-00025#23  by 07900 --add-end
                        IF NOT cl_chk_exist("v_ooef001") THEN
                           IF g_mrdc_m.mrdc005 = g_mrdc_m_t.mrdc005 THEN
                              LET g_mrdc_m.mrdc006 = g_mrdc_m_t.mrdc006
                           ELSE
                              LET g_mrdc_m.mrdc006 = ''
                           END IF
                           CALL amrt200_mrdc006_ref()
                           NEXT FIELD CURRENT
                        END IF
                     WHEN '3'    #廠商
                        LET g_chkparam.arg1 = g_mrdc_m.mrdc006
                        IF NOT cl_chk_exist("v_pmaa001_1") THEN
                           IF g_mrdc_m.mrdc005 = g_mrdc_m_t.mrdc005 THEN
                              LET g_mrdc_m.mrdc006 = g_mrdc_m_t.mrdc006
                           ELSE
                              LET g_mrdc_m.mrdc006 = ''
                           END IF
                           CALL amrt200_mrdc006_ref()
                           NEXT FIELD CURRENT
                        END IF
                     WHEN '4'    #客戶
                        LET g_chkparam.arg1 = g_mrdc_m.mrdc006
                        LET g_chkparam.arg2 = g_site
                        #160318-00025#23  by 07900 --add-str
                        LET g_errshow = TRUE #是否開窗                   
                        LET g_chkparam.err_str[1] ="apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                        #160318-00025#23  by 07900 --add-end
                        IF NOT cl_chk_exist("v_pmaa001_3") THEN
                           IF g_mrdc_m.mrdc005 = g_mrdc_m_t.mrdc005 THEN
                              LET g_mrdc_m.mrdc006 = g_mrdc_m_t.mrdc006
                           ELSE
                              LET g_mrdc_m.mrdc006 = ''
                           END IF
                           CALL amrt200_mrdc006_ref()
                           NEXT FIELD CURRENT
                        END IF
                  END CASE
               END IF
            END IF
            CALL amrt200_mrdc006_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc006
            #add-point:BEFORE FIELD mrdc006 name="input.b.mrdc006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdc006
            #add-point:ON CHANGE mrdc006 name="input.g.mrdc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc007
            #add-point:BEFORE FIELD mrdc007 name="input.b.mrdc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc007
            
            #add-point:AFTER FIELD mrdc007 name="input.a.mrdc007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdc007
            #add-point:ON CHANGE mrdc007 name="input.g.mrdc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdc008
            #add-point:BEFORE FIELD mrdc008 name="input.b.mrdc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdc008
            
            #add-point:AFTER FIELD mrdc008 name="input.a.mrdc008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdc008
            #add-point:ON CHANGE mrdc008 name="input.g.mrdc008"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mrdcdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcdocno
            #add-point:ON ACTION controlp INFIELD mrdcdocno name="input.c.mrdcdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdc_m.mrdcdocno             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_ooef004
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_mrdc_m.mrdcdocno = g_qryparam.return1   
            DISPLAY g_mrdc_m.mrdcdocno TO mrdcdocno
            CALL s_aooi200_get_slip_desc(g_mrdc_m.mrdcdocno) RETURNING g_mrdc_m.mrdcdocno_desc
            NEXT FIELD mrdcdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrdcdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcdocdt
            #add-point:ON ACTION controlp INFIELD mrdcdocdt name="input.c.mrdcdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc001
            #add-point:ON ACTION controlp INFIELD mrdc001 name="input.c.mrdc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc002
            #add-point:ON ACTION controlp INFIELD mrdc002 name="input.c.mrdc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc003
            #add-point:ON ACTION controlp INFIELD mrdc003 name="input.c.mrdc003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdc_m.mrdc003             #給予default值

            #給予arg
            CALL q_ooag001()                                #呼叫開窗
            LET g_mrdc_m.mrdc003 = g_qryparam.return1    
            DISPLAY g_mrdc_m.mrdc003 TO mrdc003
            CALL amrt200_mrdc003_ref()
            NEXT FIELD mrdc003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrdc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc004
            #add-point:ON ACTION controlp INFIELD mrdc004 name="input.c.mrdc004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdc_m.mrdc004             #給予default值
            LET g_qryparam.default2 = "" #g_mrdc_m.ooeg001 #部門編號
            
            #給予arg
            LET g_qryparam.arg1 = g_mrdc_m.mrdcdocdt
            CALL q_ooeg001()                                #呼叫開窗
            LET g_mrdc_m.mrdc004 = g_qryparam.return1              
            #LET g_mrdc_m.ooeg001 = g_qryparam.return2 
            DISPLAY g_mrdc_m.mrdc004 TO mrdc004              #
            #DISPLAY g_mrdc_m.ooeg001 TO ooeg001 #部門編號
            CALL amrt200_mrdc004_ref()
            NEXT FIELD mrdc004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrdcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcsite
            #add-point:ON ACTION controlp INFIELD mrdcsite name="input.c.mrdcsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdcstus
            #add-point:ON ACTION controlp INFIELD mrdcstus name="input.c.mrdcstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc005
            #add-point:ON ACTION controlp INFIELD mrdc005 name="input.c.mrdc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc006
            #add-point:ON ACTION controlp INFIELD mrdc006 name="input.c.mrdc006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdc_m.mrdc006             #給予default值
            
            CASE g_mrdc_m.mrdc005
               WHEN '1'    #部門
                  LET g_qryparam.arg1 = g_mrdc_m.mrdcdocdt
                  CALL q_ooeg001()
               WHEN '2'    #據點
                  #mod--161013-00051#1 By shiun--(S)
#                  CALL q_ooef001()
                  CALL q_ooef001_1()
                  #mod--161013-00051#1 By shiun--(E)
               WHEN '3'    #廠商
                 #LET g_qryparam.where = " (pmaa002='1' OR pmaa002 = '3')" #160909-00080#1 mark
                 #CALL q_pmaa001_8()         #160909-00080#1 mark
                 CALL q_pmaa001_10()         #160909-00080#1
               WHEN '4'    #客戶
                 #LET g_qryparam.where = " (pmaa002='2' OR pmaa002 = '3')" #160909-00080#1 mark
                 #CALL q_pmaa001_8()         #160909-00080#1 mark
                 CALL q_pmaa001_13()         #160909-00080#1
            END CASE
            LET g_mrdc_m.mrdc006 = g_qryparam.return1    
            DISPLAY g_mrdc_m.mrdc006 TO mrdc006
            CALL amrt200_mrdc006_ref()
            NEXT FIELD mrdc006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrdc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc007
            #add-point:ON ACTION controlp INFIELD mrdc007 name="input.c.mrdc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrdc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdc008
            #add-point:ON ACTION controlp INFIELD mrdc008 name="input.c.mrdc008"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mrdc_m.mrdcdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                IF NOT s_aooi200_chk_slip(g_site,'',g_mrdc_m.mrdcdocno,g_prog) THEN
                  LET g_mrdc_m.mrdcdocno = ''
                  NEXT FIELD mrdcdocno
               END IF

               CALL s_aooi200_gen_docno(g_site,g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt,g_prog) RETURNING l_flag,g_mrdc_m.mrdcdocno
               IF NOT l_flag THEN
                  NEXT FIELD mrdcdocno
               END IF
               #end add-point
               
               INSERT INTO mrdc_t (mrdcent,mrdcdocno,mrdcdocdt,mrdc001,mrdc002,mrdc003,mrdc004,mrdcsite, 
                   mrdcstus,mrdc005,mrdc006,mrdc007,mrdc008,mrdcownid,mrdcowndp,mrdccrtid,mrdccrtdp, 
                   mrdccrtdt,mrdcmodid,mrdcmoddt,mrdccnfid,mrdccnfdt)
               VALUES (g_enterprise,g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt,g_mrdc_m.mrdc001,g_mrdc_m.mrdc002, 
                   g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005, 
                   g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp, 
                   g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt, 
                   g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mrdc_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
 
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amrt200_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amrt200_b_fill()
                  CALL amrt200_b_fill2('0')
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
               CALL amrt200_mrdc_t_mask_restore('restore_mask_o')
               
               UPDATE mrdc_t SET (mrdcdocno,mrdcdocdt,mrdc001,mrdc002,mrdc003,mrdc004,mrdcsite,mrdcstus, 
                   mrdc005,mrdc006,mrdc007,mrdc008,mrdcownid,mrdcowndp,mrdccrtid,mrdccrtdp,mrdccrtdt, 
                   mrdcmodid,mrdcmoddt,mrdccnfid,mrdccnfdt) = (g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt, 
                   g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite, 
                   g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008, 
                   g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp,g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt, 
                   g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt,g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt)
                WHERE mrdcent = g_enterprise AND mrdcdocno = g_mrdcdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mrdc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL amrt200_mrdc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mrdc_m_t)
               LET g_log2 = util.JSON.stringify(g_mrdc_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mrdcdocno_t = g_mrdc_m.mrdcdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amrt200.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mrdd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrdd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrt200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mrdd_d.getLength()
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
            OPEN amrt200_cl USING g_enterprise,g_mrdc_m.mrdcdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrdd_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrdd_d[l_ac].mrddseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mrdd_d_t.* = g_mrdd_d[l_ac].*  #BACKUP
               LET g_mrdd_d_o.* = g_mrdd_d[l_ac].*  #BACKUP
               CALL amrt200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL amrt200_set_no_entry_b(l_cmd)
               IF NOT amrt200_lock_b("mrdd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrt200_bcl INTO g_mrdd_d[l_ac].mrddsite,g_mrdd_d[l_ac].mrddseq,g_mrdd_d[l_ac].mrdd001, 
                      g_mrdd_d[l_ac].mrdd002,g_mrdd_d[l_ac].mrdd003,g_mrdd_d[l_ac].mrdd004,g_mrdd_d[l_ac].mrdd005, 
                      g_mrdd_d[l_ac].mrdd009,g_mrdd_d[l_ac].mrdd006,g_mrdd_d[l_ac].mrdd007,g_mrdd_d[l_ac].mrdd008 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mrdd_d_t.mrddseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrdd_d_mask_o[l_ac].* =  g_mrdd_d[l_ac].*
                  CALL amrt200_mrdd_t_mask()
                  LET g_mrdd_d_mask_n[l_ac].* =  g_mrdd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrt200_show()
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
            INITIALIZE g_mrdd_d[l_ac].* TO NULL 
            INITIALIZE g_mrdd_d_t.* TO NULL 
            INITIALIZE g_mrdd_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_mrdd_d[l_ac].mrddsite = g_mrdc_m.mrdcsite
            #end add-point
            LET g_mrdd_d_t.* = g_mrdd_d[l_ac].*     #新輸入資料
            LET g_mrdd_d_o.* = g_mrdd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrt200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL amrt200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrdd_d[li_reproduce_target].* = g_mrdd_d[li_reproduce].*
 
               LET g_mrdd_d[li_reproduce_target].mrddseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(mrddseq)+1 INTO g_mrdd_d[l_ac].mrddseq
              FROM mrdd_t
             WHERE mrddent = g_enterprise
               AND mrdddocno = g_mrdc_m.mrdcdocno
            IF cl_null(g_mrdd_d[l_ac].mrddseq) THEN
               LET g_mrdd_d[l_ac].mrddseq = 1
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
            SELECT COUNT(1) INTO l_count FROM mrdd_t 
             WHERE mrddent = g_enterprise AND mrdddocno = g_mrdc_m.mrdcdocno
 
               AND mrddseq = g_mrdd_d[l_ac].mrddseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdc_m.mrdcdocno
               LET gs_keys[2] = g_mrdd_d[g_detail_idx].mrddseq
               CALL amrt200_insert_b('mrdd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mrdd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrdd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrt200_b_fill()
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
               LET gs_keys[01] = g_mrdc_m.mrdcdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mrdd_d_t.mrddseq
 
            
               #刪除同層單身
               IF NOT amrt200_delete_b('mrdd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrt200_key_delete_b(gs_keys,'mrdd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrt200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amrt200_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mrdd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrdd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrddsite
            #add-point:BEFORE FIELD mrddsite name="input.b.page1.mrddsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrddsite
            
            #add-point:AFTER FIELD mrddsite name="input.a.page1.mrddsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrddsite
            #add-point:ON CHANGE mrddsite name="input.g.page1.mrddsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrddseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdd_d[l_ac].mrddseq,"1","1","","","azz-00079",1) THEN
               NEXT FIELD mrddseq
            END IF 
 
 
 
            #add-point:AFTER FIELD mrddseq name="input.a.page1.mrddseq"
            IF NOT cl_ap_chk_Range(g_mrdd_d[l_ac].mrddseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mrddseq
            END IF
            #此段落由子樣板a05產生
            IF  g_mrdc_m.mrdcdocno IS NOT NULL AND g_mrdd_d[g_detail_idx].mrddseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrdc_m.mrdcdocno != g_mrdcdocno_t OR g_mrdd_d[g_detail_idx].mrddseq != g_mrdd_d_t.mrddseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrdd_t WHERE "||"mrddent = '" ||g_enterprise|| "' AND mrddsite = '" ||g_site|| "' AND "||"mrdddocno = '"||g_mrdc_m.mrdcdocno ||"' AND "|| "mrddseq = '"||g_mrdd_d[g_detail_idx].mrddseq ||"'",'std-00004',0) THEN 
                     LET g_mrdd_d[g_detail_idx].mrddseq = g_mrdd_d_t.mrddseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrddseq
            #add-point:BEFORE FIELD mrddseq name="input.b.page1.mrddseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrddseq
            #add-point:ON CHANGE mrddseq name="input.g.page1.mrddseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd001
            
            #add-point:AFTER FIELD mrdd001 name="input.a.page1.mrdd001"
            LET g_mrdd_d[l_ac].mrba004 = ' '
            LET g_mrdd_d[l_ac].mrba008 = ' '
            LET g_mrdd_d[l_ac].mrba009 = ' '
            DISPLAY BY NAME g_mrdd_d[l_ac].mrba004,g_mrdd_d[l_ac].mrba008,g_mrdd_d[l_ac].mrba009
            IF NOT cl_null(g_mrdd_d[l_ac].mrdd001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdd_d[l_ac].mrdd001 != g_mrdd_d_t.mrdd001 OR g_mrdd_d_t.mrdd001 IS NULL )) THEN   #160824-00007#218 20161129 mark by beckxie
               IF g_mrdd_d[l_ac].mrdd001 != g_mrdd_d_o.mrdd001 OR cl_null(g_mrdd_d_o.mrdd001) THEN   #160824-00007#218 20161129 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdd_d[l_ac].mrdd001
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#23  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_mrba001_5") THEN
                     #LET g_mrdd_d[l_ac].mrdd001 = g_mrdd_d_t.mrdd001   #160824-00007#218 20161129 mark by beckxie
                     #160824-00007#218 20161129 add by beckxie---S
                     LET g_mrdd_d[l_ac].mrdd001 = g_mrdd_d_o.mrdd001
                     LET g_mrdd_d[l_ac].mrdd004 = g_mrdd_d_o.mrdd004
                     LET g_mrdd_d[l_ac].mrdd008 = g_mrdd_d_o.mrdd008
                     LET g_mrdd_d[l_ac].mrdd009 = g_mrdd_d_o.mrdd009
                     #160824-00007#218 20161129 add by beckxie---E
                     CALL amrt200_mrdd001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               
               #ming 20140903 add ---------------------------------------------------(S)  
               IF NOT cl_null(g_mrdd_d[l_ac].mrdd002) THEN
                  #檢查是否超出可借出數量 
                  CALL amrt200_chk_mrdd002(g_mrdd_d_t.mrddseq,
                                           g_mrdd_d[l_ac].mrdd001,
                                           g_mrdd_d[l_ac].mrdd002)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #160824-00007#218 20161129 add by beckxie---S
                     LET g_mrdd_d[l_ac].mrdd001 = g_mrdd_d_o.mrdd001
                     LET g_mrdd_d[l_ac].mrdd004 = g_mrdd_d_o.mrdd004
                     LET g_mrdd_d[l_ac].mrdd008 = g_mrdd_d_o.mrdd008
                     LET g_mrdd_d[l_ac].mrdd009 = g_mrdd_d_o.mrdd009
                     #160824-00007#218 20161129 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #ming 20140903 add ---------------------------------------------------(E)  
            END IF
            CALL amrt200_mrdd001_ref()
            LET g_mrdd_d_o.* = g_mrdd_d[l_ac].* #160824-00007#218 20161129 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd001
            #add-point:BEFORE FIELD mrdd001 name="input.b.page1.mrdd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd001
            #add-point:ON CHANGE mrdd001 name="input.g.page1.mrdd001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrdd_d[l_ac].mrdd002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrdd002
            END IF 
 
 
 
            #add-point:AFTER FIELD mrdd002 name="input.a.page1.mrdd002"
            IF NOT cl_null(g_mrdd_d[l_ac].mrdd002) THEN 
               #且<="目前可借出數量"  
               
               #ming 20140903 add -------------------------------------------(S) 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_mrdd_d[l_ac].mrdd002 != g_mrdd_d_o.mrdd002 OR
                                                   g_mrdd_d_o.mrdd002 IS NULL)) THEN
                  IF NOT cl_null(g_mrdd_d[l_ac].mrdd001) THEN
                     #檢查是否超出可借出數量 
                     CALL amrt200_chk_mrdd002(g_mrdd_d_t.mrddseq,
                                              g_mrdd_d[l_ac].mrdd001,
                                              g_mrdd_d[l_ac].mrdd002)
                     IF NOT cl_null(g_errno) THEN
                        LET g_mrdd_d[l_ac].mrdd002 = g_mrdd_d_o.mrdd002

                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #ming 20140903 add -------------------------------------------(E) 
            END IF  
            
            #ming 20140903 add ------------------------------------------(S) 
            LET g_mrdd_d_o.mrdd002 = g_mrdd_d[l_ac].mrdd002
            #ming 20140903 add ------------------------------------------(E) 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd002
            #add-point:BEFORE FIELD mrdd002 name="input.b.page1.mrdd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd002
            #add-point:ON CHANGE mrdd002 name="input.g.page1.mrdd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd003
            #add-point:BEFORE FIELD mrdd003 name="input.b.page1.mrdd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd003
            
            #add-point:AFTER FIELD mrdd003 name="input.a.page1.mrdd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd003
            #add-point:ON CHANGE mrdd003 name="input.g.page1.mrdd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd004
            
            #add-point:AFTER FIELD mrdd004 name="input.a.page1.mrdd004"
            LET g_mrdd_d[l_ac].mrdd004_desc = ' '
            DISPLAY BY NAME g_mrdd_d[l_ac].mrdd004_desc
            IF NOT cl_null(g_mrdd_d[l_ac].mrdd004) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdd_d[l_ac].mrdd004 != g_mrdd_d_t.mrdd004 OR g_mrdd_d_t.mrdd004 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('221',g_mrdd_d[l_ac].mrdd004) THEN
                     LET g_mrdd_d[l_ac].mrdd004 = g_mrdd_d_t.mrdd004
                     CALL amrt200_mrdd004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL amrt200_mrdd004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd004
            #add-point:BEFORE FIELD mrdd004 name="input.b.page1.mrdd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd004
            #add-point:ON CHANGE mrdd004 name="input.g.page1.mrdd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd005
            
            #add-point:AFTER FIELD mrdd005 name="input.a.page1.mrdd005"
            IF NOT cl_null(g_mrdd_d[l_ac].mrdd005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdd_d[l_ac].mrdd005 != g_mrdd_d_t.mrdd005 OR g_mrdd_d_t.mrdd005 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mrdd_d[l_ac].mrdd005
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
                  #160318-00025#23  by 07900 --add-end
                  IF NOT cl_chk_exist("v_mrba001_7") THEN
                     LET g_mrdd_d[l_ac].mrdd005 = g_mrdd_d_t.mrdd005
                     CALL amrt200_mrdd005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
			   CALL amrt200_mrdd005_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd005
            #add-point:BEFORE FIELD mrdd005 name="input.b.page1.mrdd005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd005
            #add-point:ON CHANGE mrdd005 name="input.g.page1.mrdd005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd009
            #add-point:BEFORE FIELD mrdd009 name="input.b.page1.mrdd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd009
            
            #add-point:AFTER FIELD mrdd009 name="input.a.page1.mrdd009"
            IF NOT cl_null(g_mrdd_d[l_ac].mrdd009) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mrdd_d[l_ac].mrdd009 != g_mrdd_d_t.mrdd009 OR g_mrdd_d_t.mrdd009 IS NULL )) THEN
                  IF NOT cl_null(g_mrdc_m.mrdcdocdt) AND g_mrdd_d[l_ac].mrdd009 < g_mrdc_m.mrdcdocdt THEN
                     #預計歸還日 不可以小於 單頭領用日期！
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amr-00059'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mrdd_d[l_ac].mrdd009 = g_mrdd_d_t.mrdd009
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd009
            #add-point:ON CHANGE mrdd009 name="input.g.page1.mrdd009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd006
            #add-point:BEFORE FIELD mrdd006 name="input.b.page1.mrdd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd006
            
            #add-point:AFTER FIELD mrdd006 name="input.a.page1.mrdd006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd006
            #add-point:ON CHANGE mrdd006 name="input.g.page1.mrdd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd007
            #add-point:BEFORE FIELD mrdd007 name="input.b.page1.mrdd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd007
            
            #add-point:AFTER FIELD mrdd007 name="input.a.page1.mrdd007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd007
            #add-point:ON CHANGE mrdd007 name="input.g.page1.mrdd007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrdd008
            #add-point:BEFORE FIELD mrdd008 name="input.b.page1.mrdd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrdd008
            
            #add-point:AFTER FIELD mrdd008 name="input.a.page1.mrdd008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrdd008
            #add-point:ON CHANGE mrdd008 name="input.g.page1.mrdd008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrddsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrddsite
            #add-point:ON ACTION controlp INFIELD mrddsite name="input.c.page1.mrddsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrddseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrddseq
            #add-point:ON ACTION controlp INFIELD mrddseq name="input.c.page1.mrddseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd001
            #add-point:ON ACTION controlp INFIELD mrdd001 name="input.c.page1.mrdd001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdd_d[l_ac].mrdd001             #給予default值

            #給予arg
            CALL q_mrba001_4()                                #呼叫開窗
            LET g_mrdd_d[l_ac].mrdd001 = g_qryparam.return1    
            DISPLAY g_mrdd_d[l_ac].mrdd001 TO mrdd001
            CALL amrt200_mrdd001_ref()
            NEXT FIELD mrdd001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd002
            #add-point:ON ACTION controlp INFIELD mrdd002 name="input.c.page1.mrdd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd003
            #add-point:ON ACTION controlp INFIELD mrdd003 name="input.c.page1.mrdd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd004
            #add-point:ON ACTION controlp INFIELD mrdd004 name="input.c.page1.mrdd004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdd_d[l_ac].mrdd004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "221"
            CALL q_oocq002()                                #呼叫開窗
            LET g_mrdd_d[l_ac].mrdd004 = g_qryparam.return1   
            DISPLAY g_mrdd_d[l_ac].mrdd004 TO mrdd004
            CALL amrt200_mrdd004_ref()
            NEXT FIELD mrdd004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd005
            #add-point:ON ACTION controlp INFIELD mrdd005 name="input.c.page1.mrdd005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrdd_d[l_ac].mrdd005             #給予default值

            #給予arg
            CALL q_mrba001_6()                                #呼叫開窗
            LET g_mrdd_d[l_ac].mrdd005 = g_qryparam.return1  
            DISPLAY g_mrdd_d[l_ac].mrdd005 TO mrdd005 
            CALL amrt200_mrdd005_ref()
            NEXT FIELD mrdd005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd009
            #add-point:ON ACTION controlp INFIELD mrdd009 name="input.c.page1.mrdd009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd006
            #add-point:ON ACTION controlp INFIELD mrdd006 name="input.c.page1.mrdd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd007
            #add-point:ON ACTION controlp INFIELD mrdd007 name="input.c.page1.mrdd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrdd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrdd008
            #add-point:ON ACTION controlp INFIELD mrdd008 name="input.c.page1.mrdd008"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrdd_d[l_ac].* = g_mrdd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mrdd_d[l_ac].mrddseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mrdd_d[l_ac].* = g_mrdd_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL amrt200_mrdd_t_mask_restore('restore_mask_o')
      
               UPDATE mrdd_t SET (mrdddocno,mrddsite,mrddseq,mrdd001,mrdd002,mrdd003,mrdd004,mrdd005, 
                   mrdd009,mrdd006,mrdd007,mrdd008) = (g_mrdc_m.mrdcdocno,g_mrdd_d[l_ac].mrddsite,g_mrdd_d[l_ac].mrddseq, 
                   g_mrdd_d[l_ac].mrdd001,g_mrdd_d[l_ac].mrdd002,g_mrdd_d[l_ac].mrdd003,g_mrdd_d[l_ac].mrdd004, 
                   g_mrdd_d[l_ac].mrdd005,g_mrdd_d[l_ac].mrdd009,g_mrdd_d[l_ac].mrdd006,g_mrdd_d[l_ac].mrdd007, 
                   g_mrdd_d[l_ac].mrdd008)
                WHERE mrddent = g_enterprise AND mrdddocno = g_mrdc_m.mrdcdocno 
 
                  AND mrddseq = g_mrdd_d_t.mrddseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrdd_d[l_ac].* = g_mrdd_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrdd_d[l_ac].* = g_mrdd_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrdd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrdc_m.mrdcdocno
               LET gs_keys_bak[1] = g_mrdcdocno_t
               LET gs_keys[2] = g_mrdd_d[g_detail_idx].mrddseq
               LET gs_keys_bak[2] = g_mrdd_d_t.mrddseq
               CALL amrt200_update_b('mrdd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amrt200_mrdd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mrdd_d[g_detail_idx].mrddseq = g_mrdd_d_t.mrddseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mrdc_m.mrdcdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mrdd_d_t.mrddseq
 
                  CALL amrt200_key_update_b(gs_keys,'mrdd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrdc_m),util.JSON.stringify(g_mrdd_d_t)
               LET g_log2 = util.JSON.stringify(g_mrdc_m),util.JSON.stringify(g_mrdd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amrt200_unlock_b("mrdd_t","'1'")
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
               LET g_mrdd_d[li_reproduce_target].* = g_mrdd_d[li_reproduce].*
 
               LET g_mrdd_d[li_reproduce_target].mrddseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrdd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrdd_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="amrt200.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD mrdcdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrddsite
 
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
 
{<section id="amrt200.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amrt200_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amrt200_b_fill() #單身填充
      CALL amrt200_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amrt200_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_aooi200_get_slip_desc(g_mrdc_m.mrdcdocno) RETURNING g_mrdc_m.mrdcdocno_desc
   CALL amrt200_mrdc003_ref()
   CALL amrt200_mrdc004_ref()
   CALL amrt200_mrdc006_ref()
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdc_m.mrdcownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mrdc_m.mrdcownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdc_m.mrdcownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdc_m.mrdcowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mrdc_m.mrdcowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdc_m.mrdcowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdc_m.mrdccrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mrdc_m.mrdccrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdc_m.mrdccrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdc_m.mrdccrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mrdc_m.mrdccrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdc_m.mrdccrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdc_m.mrdcmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mrdc_m.mrdcmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdc_m.mrdcmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mrdc_m.mrdccnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mrdc_m.mrdccnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mrdc_m.mrdccnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mrdc_m_mask_o.* =  g_mrdc_m.*
   CALL amrt200_mrdc_t_mask()
   LET g_mrdc_m_mask_n.* =  g_mrdc_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocno_desc,g_mrdc_m.mrdcdocdt,g_mrdc_m.mrdc001,g_mrdc_m.mrdc002, 
       g_mrdc_m.mrdc003,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdcsite, 
       g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc006_desc,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008, 
       g_mrdc_m.mrdcownid,g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid, 
       g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdp_desc,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdcmoddt,g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfid_desc,g_mrdc_m.mrdccnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdc_m.mrdcstus 
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
   FOR l_ac = 1 TO g_mrdd_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL amrt200_mrdd001_ref()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amrt200_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amrt200_detail_show()
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
 
{<section id="amrt200.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amrt200_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mrdc_t.mrdcdocno 
   DEFINE l_oldno     LIKE mrdc_t.mrdcdocno 
 
   DEFINE l_master    RECORD LIKE mrdc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mrdd_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_doctype       LIKE rtai_t.rtai004
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
   
   IF g_mrdc_m.mrdcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mrdcdocno_t = g_mrdc_m.mrdcdocno
 
    
   LET g_mrdc_m.mrdcdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrdc_m.mrdcownid = g_user
      LET g_mrdc_m.mrdcowndp = g_dept
      LET g_mrdc_m.mrdccrtid = g_user
      LET g_mrdc_m.mrdccrtdp = g_dept 
      LET g_mrdc_m.mrdccrtdt = cl_get_current()
      LET g_mrdc_m.mrdcmodid = g_user
      LET g_mrdc_m.mrdcmoddt = cl_get_current()
      LET g_mrdc_m.mrdcstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mrdc_m.mrdccnfid = ""
   LET g_mrdc_m.mrdccnfdt = ""
   LET g_mrdc_m.mrdcsite = g_site
   LET g_mrdc_m.mrdcdocdt = g_today
   LET g_mrdc_m.mrdc003 = g_user
   LET g_mrdc_m.mrdc004 = g_dept
   CALL amrt200_mrdc003_ref()
   CALL amrt200_mrdc004_ref()
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_mrdc_m.mrdcsite,g_prog,'1')
      RETURNING r_success,r_doctype
   LET g_mrdc_m.mrdcdocno = r_doctype
   CALL s_aooi200_get_slip_desc(g_mrdc_m.mrdcdocno) RETURNING g_mrdc_m.mrdcdocno_desc
   DISPLAY BY NAME g_mrdc_m.mrdcdocno_desc
   LET g_mrdc_m_t.* = g_mrdc_m.*
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrdc_m.mrdcstus 
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
      LET g_mrdc_m.mrdcdocno_desc = ''
   DISPLAY BY NAME g_mrdc_m.mrdcdocno_desc
 
   
   CALL amrt200_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mrdc_m.* TO NULL
      INITIALIZE g_mrdd_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amrt200_show()
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
   CALL amrt200_set_act_visible()   
   CALL amrt200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrdcdocno_t = g_mrdc_m.mrdcdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrdcent = " ||g_enterprise|| " AND",
                      " mrdcdocno = '", g_mrdc_m.mrdcdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrt200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL amrt200_idx_chk()
   
   LET g_data_owner = g_mrdc_m.mrdcownid      
   LET g_data_dept  = g_mrdc_m.mrdcowndp
   
   #功能已完成,通報訊息中心
   CALL amrt200_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amrt200_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mrdd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amrt200_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrdd_t
    WHERE mrddent = g_enterprise AND mrdddocno = g_mrdcdocno_t
 
    INTO TEMP amrt200_detail
 
   #將key修正為調整後   
   UPDATE amrt200_detail 
      #更新key欄位
      SET mrdddocno = g_mrdc_m.mrdcdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mrdd_t SELECT * FROM amrt200_detail
   
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
   DROP TABLE amrt200_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mrdcdocno_t = g_mrdc_m.mrdcdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amrt200_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_mrdc_m.mrdcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN amrt200_cl USING g_enterprise,g_mrdc_m.mrdcdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrt200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrt200_master_referesh USING g_mrdc_m.mrdcdocno INTO g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt, 
       g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus, 
       g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp, 
       g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt, 
       g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdc006_desc, 
       g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp_desc, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdccnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT amrt200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrdc_m_mask_o.* =  g_mrdc_m.*
   CALL amrt200_mrdc_t_mask()
   LET g_mrdc_m_mask_n.* =  g_mrdc_m.*
   
   CALL amrt200_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amrt200_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mrdcdocno_t = g_mrdc_m.mrdcdocno
 
 
      DELETE FROM mrdc_t
       WHERE mrdcent = g_enterprise AND mrdcdocno = g_mrdc_m.mrdcdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mrdc_m.mrdcdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mrdd_t
       WHERE mrddent = g_enterprise AND mrdddocno = g_mrdc_m.mrdcdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mrdc_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amrt200_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mrdd_d.clear() 
 
     
      CALL amrt200_ui_browser_refresh()  
      #CALL amrt200_ui_headershow()  
      #CALL amrt200_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amrt200_browser_fill("")
         CALL amrt200_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amrt200_cl
 
   #功能已完成,通報訊息中心
   CALL amrt200_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amrt200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amrt200_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mrdd_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amrt200_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrddsite,mrddseq,mrdd001,mrdd002,mrdd003,mrdd004,mrdd005,mrdd009, 
             mrdd006,mrdd007,mrdd008 ,t1.oocql004 ,t2.mrba004 FROM mrdd_t",   
                     " INNER JOIN mrdc_t ON mrdcent = " ||g_enterprise|| " AND mrdcdocno = mrdddocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='221' AND t1.oocql002=mrdd004 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN mrba_t t2 ON t2.mrbaent="||g_enterprise||" AND t2.mrba001=mrdd005  ",
 
                     " WHERE mrddent=? AND mrdddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrdd_t.mrddseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrt200_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amrt200_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mrdc_m.mrdcdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mrdc_m.mrdcdocno INTO g_mrdd_d[l_ac].mrddsite,g_mrdd_d[l_ac].mrddseq, 
          g_mrdd_d[l_ac].mrdd001,g_mrdd_d[l_ac].mrdd002,g_mrdd_d[l_ac].mrdd003,g_mrdd_d[l_ac].mrdd004, 
          g_mrdd_d[l_ac].mrdd005,g_mrdd_d[l_ac].mrdd009,g_mrdd_d[l_ac].mrdd006,g_mrdd_d[l_ac].mrdd007, 
          g_mrdd_d[l_ac].mrdd008,g_mrdd_d[l_ac].mrdd004_desc,g_mrdd_d[l_ac].mrdd005_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL amrt200_mrdd001_ref()
         CALL amrt200_mrdd004_ref()
         CALL amrt200_mrdd005_ref()
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
   
   CALL g_mrdd_d.deleteElement(g_mrdd_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amrt200_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mrdd_d.getLength()
      LET g_mrdd_d_mask_o[l_ac].* =  g_mrdd_d[l_ac].*
      CALL amrt200_mrdd_t_mask()
      LET g_mrdd_d_mask_n[l_ac].* =  g_mrdd_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amrt200_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mrdd_t
       WHERE mrddent = g_enterprise AND
         mrdddocno = ps_keys_bak[1] AND mrddseq = ps_keys_bak[2]
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
         CALL g_mrdd_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amrt200_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mrdd_t
                  (mrddent,
                   mrdddocno,
                   mrddseq
                   ,mrddsite,mrdd001,mrdd002,mrdd003,mrdd004,mrdd005,mrdd009,mrdd006,mrdd007,mrdd008) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mrdd_d[g_detail_idx].mrddsite,g_mrdd_d[g_detail_idx].mrdd001,g_mrdd_d[g_detail_idx].mrdd002, 
                       g_mrdd_d[g_detail_idx].mrdd003,g_mrdd_d[g_detail_idx].mrdd004,g_mrdd_d[g_detail_idx].mrdd005, 
                       g_mrdd_d[g_detail_idx].mrdd009,g_mrdd_d[g_detail_idx].mrdd006,g_mrdd_d[g_detail_idx].mrdd007, 
                       g_mrdd_d[g_detail_idx].mrdd008)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrdd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mrdd_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amrt200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrdd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amrt200_mrdd_t_mask_restore('restore_mask_o')
               
      UPDATE mrdd_t 
         SET (mrdddocno,
              mrddseq
              ,mrddsite,mrdd001,mrdd002,mrdd003,mrdd004,mrdd005,mrdd009,mrdd006,mrdd007,mrdd008) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrdd_d[g_detail_idx].mrddsite,g_mrdd_d[g_detail_idx].mrdd001,g_mrdd_d[g_detail_idx].mrdd002, 
                  g_mrdd_d[g_detail_idx].mrdd003,g_mrdd_d[g_detail_idx].mrdd004,g_mrdd_d[g_detail_idx].mrdd005, 
                  g_mrdd_d[g_detail_idx].mrdd009,g_mrdd_d[g_detail_idx].mrdd006,g_mrdd_d[g_detail_idx].mrdd007, 
                  g_mrdd_d[g_detail_idx].mrdd008) 
         WHERE mrddent = g_enterprise AND mrdddocno = ps_keys_bak[1] AND mrddseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrdd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrt200_mrdd_t_mask_restore('restore_mask_n')
               
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
 
{<section id="amrt200.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amrt200_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="amrt200.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amrt200_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amrt200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amrt200_lock_b(ps_table,ps_page)
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
   #CALL amrt200_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mrdd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amrt200_bcl USING g_enterprise,
                                       g_mrdc_m.mrdcdocno,g_mrdd_d[g_detail_idx].mrddseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrt200_bcl:",SQLERRMESSAGE 
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
 
{<section id="amrt200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amrt200_unlock_b(ps_table,ps_page)
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
      CLOSE amrt200_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amrt200_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mrdcdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mrdcdocno",TRUE)
      CALL cl_set_comp_entry("mrdcdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mrdcdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amrt200_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mrdcdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mrdcdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mrdcdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mrdcdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrt200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amrt200_set_entry_b(p_cmd)
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
 
{<section id="amrt200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amrt200_set_no_entry_b(p_cmd)
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
 
{<section id="amrt200.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amrt200_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   CALL cl_set_act_visible("modify,modify_detail,delete",TRUE)   #2014/12/02 by stellar add

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amrt200_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #2014/12/02 by stellar add ----- (S)
   IF g_mrdc_m.mrdcstus NOT MATCHES '[NDR]' THEN  # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   
   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
       CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
   #2014/12/02 by stellar add ----- (E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amrt200_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amrt200_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amrt200_default_search()
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
      LET ls_wc = ls_wc, " mrdcdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mrdc_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mrdd_t" 
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
 
{<section id="amrt200.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amrt200_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_mrdc_m.mrdcstus = '[XCH]' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mrdc_m.mrdcdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amrt200_cl USING g_enterprise,g_mrdc_m.mrdcdocno
   IF STATUS THEN
      CLOSE amrt200_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrt200_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amrt200_master_referesh USING g_mrdc_m.mrdcdocno INTO g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt, 
       g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus, 
       g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp, 
       g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt, 
       g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdc006_desc, 
       g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp_desc, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdccnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT amrt200_action_chk() THEN
      CLOSE amrt200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocno_desc,g_mrdc_m.mrdcdocdt,g_mrdc_m.mrdc001,g_mrdc_m.mrdc002, 
       g_mrdc_m.mrdc003,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdcsite, 
       g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc006_desc,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008, 
       g_mrdc_m.mrdcownid,g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid, 
       g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdp_desc,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid, 
       g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdcmoddt,g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfid_desc,g_mrdc_m.mrdccnfdt 
 
 
   CASE g_mrdc_m.mrdcstus
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
         CASE g_mrdc_m.mrdcstus
            
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)      
      CASE g_mrdc_m.mrdcstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,confirmed,invalid",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
            
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE

      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT amrt200_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amrt200_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT amrt200_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE amrt200_cl
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
      g_mrdc_m.mrdcstus = lc_state OR cl_null(lc_state) THEN
      CLOSE amrt200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   OPEN amrt200_cl USING g_enterprise,g_mrdc_m.mrdcdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN amrt200_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE amrt200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   CALL cl_showmsg_init()
   
   #未確認改確認(N->Y)
   IF lc_state = 'Y' AND g_mrdc_m.mrdcstus = 'N' THEN
      CALL s_amrt200_conf_chk(g_mrdc_m.mrdcdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00108') THEN
            CALL s_amrt200_conf_upd(g_mrdc_m.mrdcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_showmsg()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_showmsg()
            RETURN
         END IF
      END IF
   END IF
   #確認改未確認(Y->N)
   IF lc_state = 'N' AND g_mrdc_m.mrdcstus = 'Y' THEN
      CALL s_amrt200_unconf_chk(g_mrdc_m.mrdcdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00110') THEN
            CALL s_amrt200_unconf_upd(g_mrdc_m.mrdcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_showmsg()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_showmsg()
            RETURN
         END IF
      END IF
   END IF
   #未確認改作廢(N->X)
   IF lc_state = 'X' AND g_mrdc_m.mrdcstus = 'N' THEN
      CALL s_amrt200_invalid_chk(g_mrdc_m.mrdcdocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_showmsg()
         RETURN
      ELSE
         IF cl_ask_confirm('aim-00109') THEN
            CALL s_amrt200_invalid_upd(g_mrdc_m.mrdcdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_showmsg()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_showmsg()
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_showmsg()
            RETURN
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_mrdc_m.mrdcmodid = g_user
   LET g_mrdc_m.mrdcmoddt = cl_get_current()
   LET g_mrdc_m.mrdcstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mrdc_t 
      SET (mrdcstus,mrdcmodid,mrdcmoddt) 
        = (g_mrdc_m.mrdcstus,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt)     
    WHERE mrdcent = g_enterprise AND mrdcdocno = g_mrdc_m.mrdcdocno
 
    
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
      EXECUTE amrt200_master_referesh USING g_mrdc_m.mrdcdocno INTO g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocdt, 
          g_mrdc_m.mrdc001,g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc004,g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus, 
          g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcowndp, 
          g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmoddt, 
          g_mrdc_m.mrdccnfid,g_mrdc_m.mrdccnfdt,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004_desc,g_mrdc_m.mrdc006_desc, 
          g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp_desc, 
          g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdccnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mrdc_m.mrdcdocno,g_mrdc_m.mrdcdocno_desc,g_mrdc_m.mrdcdocdt,g_mrdc_m.mrdc001, 
          g_mrdc_m.mrdc002,g_mrdc_m.mrdc003,g_mrdc_m.mrdc003_desc,g_mrdc_m.mrdc004,g_mrdc_m.mrdc004_desc, 
          g_mrdc_m.mrdcsite,g_mrdc_m.mrdcstus,g_mrdc_m.mrdc005,g_mrdc_m.mrdc006,g_mrdc_m.mrdc006_desc, 
          g_mrdc_m.mrdc007,g_mrdc_m.mrdc008,g_mrdc_m.mrdcownid,g_mrdc_m.mrdcownid_desc,g_mrdc_m.mrdcowndp, 
          g_mrdc_m.mrdcowndp_desc,g_mrdc_m.mrdccrtid,g_mrdc_m.mrdccrtid_desc,g_mrdc_m.mrdccrtdp,g_mrdc_m.mrdccrtdp_desc, 
          g_mrdc_m.mrdccrtdt,g_mrdc_m.mrdcmodid,g_mrdc_m.mrdcmodid_desc,g_mrdc_m.mrdcmoddt,g_mrdc_m.mrdccnfid, 
          g_mrdc_m.mrdccnfid_desc,g_mrdc_m.mrdccnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amrt200_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrt200_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt200.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amrt200_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mrdd_d.getLength() THEN
         LET g_detail_idx = g_mrdd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrdd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrdd_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amrt200_b_fill2(pi_idx)
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
   
   CALL amrt200_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amrt200_fill_chk(ps_idx)
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
 
{<section id="amrt200.status_show" >}
PRIVATE FUNCTION amrt200_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amrt200.mask_functions" >}
&include "erp/amr/amrt200_mask.4gl"
 
{</section>}
 
{<section id="amrt200.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION amrt200_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL amrt200_show()
   CALL amrt200_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #確認前檢核段
   IF NOT s_amrt200_conf_chk(g_mrdc_m.mrdcdocno) THEN
      CLOSE amrt200_cl
      CALL s_transaction_end('N','0')
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mrdc_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mrdd_d))
 
 
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
   #CALL amrt200_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL amrt200_ui_headershow()
   CALL amrt200_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION amrt200_draw_out()
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
   CALL amrt200_ui_headershow()  
   CALL amrt200_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="amrt200.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amrt200_set_pk_array()
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
   LET g_pk_array[1].values = g_mrdc_m.mrdcdocno
   LET g_pk_array[1].column = 'mrdcdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt200.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amrt200.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amrt200_msgcentre_notify(lc_state)
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
   CALL amrt200_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mrdc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrt200.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amrt200_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#23 add-S
   SELECT mrdcstus  INTO g_mrdc_m.mrdcstus
     FROM mrdc_t
    WHERE mrdcent = g_enterprise
      AND mrdcdocno = g_mrdc_m.mrdcdocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mrdc_m.mrdcstus
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
        LET g_errparam.extend = g_mrdc_m.mrdcdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amrt200_set_act_visible()
        CALL amrt200_set_act_no_visible()
        CALL amrt200_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#23 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrt200.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 領用人員
# Memo...........:
# Usage..........: CALL amrt200_mrdc003_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/08 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_mrdc003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdc_m.mrdc003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ", 
       "") RETURNING g_rtn_fields
   LET g_mrdc_m.mrdc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdc_m.mrdc003_desc
END FUNCTION

################################################################################
# Descriptions...: 領用部門
# Memo...........:
# Usage..........: CALL amrt200_mrdc004_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/08 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_mrdc004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdc_m.mrdc004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'", 
       "") RETURNING g_rtn_fields
   LET g_mrdc_m.mrdc004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrdc_m.mrdc004_desc
END FUNCTION

################################################################################
# Descriptions...: 使用對象
# Memo...........:
# Usage..........: CALL amrt200_mrdc006_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/08 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_mrdc006_ref()

   CASE g_mrdc_m.mrdc005
      WHEN "1"   #1.部門
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mrdc_m.mrdc006
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mrdc_m.mrdc006_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mrdc_m.mrdc006_desc
      WHEN "2"   #2.據點
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mrdc_m.mrdc006
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mrdc_m.mrdc006_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mrdc_m.mrdc006_desc
      WHEN "3"   #3.廠商
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mrdc_m.mrdc006
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mrdc_m.mrdc006_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mrdc_m.mrdc006_desc
      WHEN "4"   #4.客戶
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_mrdc_m.mrdc006
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_mrdc_m.mrdc006_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_mrdc_m.mrdc006_desc
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 資源編號
# Memo...........:
# Usage..........: CALL amrt200_mrdd001_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/09 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_mrdd001_ref()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_mrdc_m.mrdcsite
   LET g_ref_fields[2] = g_mrdd_d[l_ac].mrdd001
   CALL ap_ref_array2(g_ref_fields," SELECT mrba004,mrba008,mrba009 FROM mrba_t WHERE mrbaent = '"||g_enterprise||"' AND mrbasite = ? AND mrba001 = ? ","") RETURNING g_rtn_fields 
   LET g_mrdd_d[l_ac].mrba004 = g_rtn_fields[1] 
   LET g_mrdd_d[l_ac].mrba008 = g_rtn_fields[2] 
   LET g_mrdd_d[l_ac].mrba009 = g_rtn_fields[3] 
   DISPLAY BY NAME g_mrdd_d[l_ac].mrba004,g_mrdd_d[l_ac].mrba008,g_mrdd_d[l_ac].mrba009
END FUNCTION

################################################################################
# Descriptions...: 領用人員帶出隸屬部門
# Memo...........:
# Usage..........: CALL amrt200_mrdc003_values()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/09 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_mrdc003_values()
   SELECT ooag003 INTO g_mrdc_m.mrdc004
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_mrdc_m.mrdc003
END FUNCTION

################################################################################
# Descriptions...: 欄位必要輸入控卡
# Memo...........:
# Usage..........: CALL amrt200_set_no_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/09 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_set_no_required()
   CALL cl_set_comp_required("mrdc002",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 欄位必要輸入控卡
# Memo...........:
# Usage..........: CALL amrt200_set_required()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/09 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_set_required()
   IF g_mrdc_m.mrdc001 = "6" THEN
      CALL cl_set_comp_required("mrdc002",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 參考作業編號
# Memo...........:
# Usage..........: CALL amrt200_mrdd004_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/09 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_mrdd004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrdd_d[l_ac].mrdd004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrdd_d[l_ac].mrdd004_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_mrdd_d[l_ac].mrdd004_desc
END FUNCTION

################################################################################
# Descriptions...: 參考機器編號
# Memo...........:
# Usage..........: CALL amrt200_mrdd005_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/05/10 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION amrt200_mrdd005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_site
   LET g_ref_fields[2] = g_mrdd_d[l_ac].mrdd005
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbasite=? AND mrba001=? ","") RETURNING g_rtn_fields
   LET g_mrdd_d[l_ac].mrdd005_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_mrdd_d[l_ac].mrdd004_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查是否超出可借出數量
# Memo...........:
# Usage..........: CALL amrt200_chk_mrdd002(p_mrddseq,p_mrdd001,p_mrdd002)
# Input parameter: p_mrddseq 舊項次
#                : p_mrdd001
#                : p_mrdd002
# Date & Author..: 2014/09/03 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION amrt200_chk_mrdd002(p_mrddseq,p_mrdd001,p_mrdd002)
   DEFINE p_mrddseq     LIKE mrdd_t.mrddseq
   DEFINE p_mrdd001     LIKE mrdd_t.mrdd001
   DEFINE p_mrdd002     LIKE mrdd_t.mrdd002
   DEFINE l_mrba006     LIKE mrba_t.mrba006
   DEFINE l_mrba104     LIKE mrba_t.mrba104
   DEFINE l_qty         LIKE mrba_t.mrba006 
   DEFINE l_mrdd002     LIKE mrdd_t.mrdd002

   LET g_errno = ''
   IF cl_null(p_mrdd001) THEN
      RETURN
   END IF
   IF cl_null(p_mrdd002) THEN
      RETURN
   END IF 
   
   LET l_mrdd002 = 0
   SELECT SUM(mrdd002) INTO l_mrdd002
     FROM mrdd_t
    WHERE mrddent  = g_enterprise
      AND mrddsite = g_site
      AND mrddseq  <> NVL(p_mrddseq,'-1') 
      AND mrdd001  = p_mrdd001
      AND mrdddocno = g_mrdc_m.mrdcdocno   #160728-00015#1 add
      
   IF cl_null(l_mrdd002) THEN
      LET l_mrdd002 = 0
   END IF

   LET l_mrba006 = 0
   LET l_mrba104 = 0
   SELECT mrba006,mrba104 INTO l_mrba006,l_mrba104
     FROM mrba_t
    WHERE mrbaent  = g_enterprise
      AND mrbasite = g_site
      AND mrba001  = p_mrdd001

   IF cl_null(l_mrba006) THEN
      LET l_mrba006 = 0
   END IF

   IF cl_null(l_mrba104) THEN
      LET l_mrba104 = 0
   END IF 
   
   #資源數量-已借出數量=可借用的數量 
   LET l_qty = l_mrba006 - l_mrba104

   IF (p_mrdd002 + l_mrdd002) > l_qty THEN
      LET g_errno = 'amr-00081'
   END IF
END FUNCTION

 
{</section>}
 
