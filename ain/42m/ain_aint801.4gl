#該程式未解開Section, 採用最新樣板產出!
{<section id="aint801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-01-08 16:00:29), PR版次:0005(2017-02-20 17:37:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: aint801
#+ Description: 批號數量更正單
#+ Creator....: 01752(2015-06-10 11:24:25)
#+ Modifier...: 02159 -SD/PR- 01996
 
{</section>}
 
{<section id="aint801.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00007#1 2016/01/08 by sakura 增加串查
#160318-00025#29  2016/04/07 by 07959   將重複內容的錯誤訊息置換為公用錯誤訊息
#160818-00017#17  2016/08/25 by 08172   修改删除时重新检查状态
#160711-00040#15  2017/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
PRIVATE type type_g_indr_m        RECORD
       indrsite LIKE indr_t.indrsite, 
   indrsite_desc LIKE type_t.chr80, 
   indrdocdt LIKE indr_t.indrdocdt, 
   indrdocno LIKE indr_t.indrdocno, 
   indr001 LIKE indr_t.indr001, 
   indr001_desc LIKE type_t.chr80, 
   indr002 LIKE indr_t.indr002, 
   indr002_desc LIKE type_t.chr80, 
   indr004 LIKE indr_t.indr004, 
   indr003 LIKE indr_t.indr003, 
   l_cnt_err_money LIKE type_t.num20_6, 
   indrunit LIKE indr_t.indrunit, 
   indr000 LIKE indr_t.indr000, 
   indrstus LIKE indr_t.indrstus, 
   indrownid LIKE indr_t.indrownid, 
   indrownid_desc LIKE type_t.chr80, 
   indrowndp LIKE indr_t.indrowndp, 
   indrowndp_desc LIKE type_t.chr80, 
   indrcrtid LIKE indr_t.indrcrtid, 
   indrcrtid_desc LIKE type_t.chr80, 
   indrcrtdp LIKE indr_t.indrcrtdp, 
   indrcrtdp_desc LIKE type_t.chr80, 
   indrcrtdt LIKE indr_t.indrcrtdt, 
   indrmodid LIKE indr_t.indrmodid, 
   indrmodid_desc LIKE type_t.chr80, 
   indrmoddt LIKE indr_t.indrmoddt, 
   indrcnfid LIKE indr_t.indrcnfid, 
   indrcnfid_desc LIKE type_t.chr80, 
   indrcnfdt LIKE indr_t.indrcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_inds_d        RECORD
       indsunit LIKE inds_t.indsunit, 
   indsseq LIKE inds_t.indsseq, 
   indsseq1 LIKE inds_t.indsseq1, 
   inds001 LIKE inds_t.inds001, 
   indssite LIKE inds_t.indssite, 
   indssite_desc LIKE type_t.chr500, 
   inds003 LIKE inds_t.inds003, 
   inds003_desc LIKE type_t.chr500, 
   inds002 LIKE inds_t.inds002, 
   inds002_desc LIKE type_t.chr500, 
   inds021 LIKE inds_t.inds021, 
   inds005 LIKE inds_t.inds005, 
   inds004 LIKE inds_t.inds004, 
   inds004_desc LIKE type_t.chr500, 
   inds004_desc_desc LIKE type_t.chr500, 
   inds020 LIKE inds_t.inds020, 
   inds020_desc LIKE type_t.chr500, 
   inds006 LIKE inds_t.inds006, 
   inds006_desc LIKE type_t.chr500, 
   inds007 LIKE inds_t.inds007, 
   inds008 LIKE inds_t.inds008, 
   inds009 LIKE inds_t.inds009, 
   inds010 LIKE inds_t.inds010, 
   inds011 LIKE inds_t.inds011, 
   l_mistakemoney LIKE type_t.num20_6, 
   inds014 LIKE inds_t.inds014, 
   inds014_desc LIKE type_t.chr500, 
   inds015 LIKE inds_t.inds015, 
   inds016 LIKE inds_t.inds016, 
   inds017 LIKE inds_t.inds017, 
   inds018 LIKE inds_t.inds018, 
   inds019 LIKE inds_t.inds019
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_indrsite LIKE indr_t.indrsite,
   b_indrsite_desc LIKE type_t.chr80,
      b_indrdocno LIKE indr_t.indrdocno,
      b_indrdocdt LIKE indr_t.indrdocdt,
      b_indr001 LIKE indr_t.indr001,
   b_indr001_desc LIKE type_t.chr80,
      b_indr002 LIKE indr_t.indr002,
   b_indr002_desc LIKE type_t.chr80,
      b_indr003 LIKE indr_t.indr003
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5   
#end add-point
       
#模組變數(Module Variables)
DEFINE g_indr_m          type_g_indr_m
DEFINE g_indr_m_t        type_g_indr_m
DEFINE g_indr_m_o        type_g_indr_m
DEFINE g_indr_m_mask_o   type_g_indr_m #轉換遮罩前資料
DEFINE g_indr_m_mask_n   type_g_indr_m #轉換遮罩後資料
 
   DEFINE g_indrdocno_t LIKE indr_t.indrdocno
 
 
DEFINE g_inds_d          DYNAMIC ARRAY OF type_g_inds_d
DEFINE g_inds_d_t        type_g_inds_d
DEFINE g_inds_d_o        type_g_inds_d
DEFINE g_inds_d_mask_o   DYNAMIC ARRAY OF type_g_inds_d #轉換遮罩前資料
DEFINE g_inds_d_mask_n   DYNAMIC ARRAY OF type_g_inds_d #轉換遮罩後資料
 
 
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
 
{<section id="aint801.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_flag    LIKE type_t.chr1
   DEFINE l_errno   LIKE type_t.chr20
   DEFINE l_comp    LIKE glaa_t.glaacomp
   DEFINE l_ld      LIKE glaa_t.glaald
   DEFINE l_xcat005 LIKE xcat_t.xcat005
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_cost_realtime_is_real(g_site)
        RETURNING l_success,l_flag
   IF NOT l_success THEN
       CALL cl_ap_exitprogram("0")
   END IF
   IF l_flag = 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_site 
      LET g_errparam.code   = 'ain-00601' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL cl_ap_exitprogram("0")
   END IF
   
   CALL s_fin_orga_get_comp_ld(g_site) 
    RETURNING l_success,l_errno,l_comp,l_ld
   IF l_success THEN   
      SELECT xcat005 INTO l_xcat005 FROM glaa_t,xcat_t
       WHERE glaaent = xcatent AND glaaent = g_enterprise
         AND glaald  = l_ld
         AND glaa120 = xcat001
      IF l_xcat005 != '3' THEN         
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_site 
         LET g_errparam.code   = 'ain-00629' 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL cl_ap_exitprogram("0")
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_site 
      LET g_errparam.code   = l_errno
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL cl_ap_exitprogram("0")      
   END IF
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT indrsite,'',indrdocdt,indrdocno,indr001,'',indr002,'',indr004,indr003, 
       '',indrunit,indr000,indrstus,indrownid,'',indrowndp,'',indrcrtid,'',indrcrtdp,'',indrcrtdt,indrmodid, 
       '',indrmoddt,indrcnfid,'',indrcnfdt", 
                      " FROM indr_t",
                      " WHERE indrent= ? AND indrdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint801_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.indrsite,t0.indrdocdt,t0.indrdocno,t0.indr001,t0.indr002,t0.indr004, 
       t0.indr003,t0.indrunit,t0.indr000,t0.indrstus,t0.indrownid,t0.indrowndp,t0.indrcrtid,t0.indrcrtdp, 
       t0.indrcrtdt,t0.indrmodid,t0.indrmoddt,t0.indrcnfid,t0.indrcnfdt,t1.ooefl003 ,t2.ooag011 ,t3.rtaxl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM indr_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indrsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.indr001  ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.indr002 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.indrownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.indrowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.indrcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.indrcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.indrmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.indrcnfid  ",
 
               " WHERE t0.indrent = " ||g_enterprise|| " AND t0.indrdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aint801_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint801 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint801_init()   
 
      #進入選單 Menu (="N")
      CALL aint801_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint801
      
   END IF 
   
   CLOSE aint801_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint801.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint801_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('indrstus','13','Y,N,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL s_tax_recount_tmp()
   #end add-point
   
   #初始化搜尋條件
   CALL aint801_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint801.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint801_ui_dialog()
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
            CALL aint801_insert()
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
         INITIALIZE g_indr_m.* TO NULL
         CALL g_inds_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint801_init()
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
               
               CALL aint801_fetch('') # reload data
               LET l_ac = 1
               CALL aint801_ui_detailshow() #Setting the current row 
         
               CALL aint801_idx_chk()
               #NEXT FIELD indsseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_inds_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint801_idx_chk()
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
               CALL aint801_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  #151125-00007#1(S)
                  BEFORE MENU
                    IF g_detail_idx = 0 THEN
                       HIDE OPTION "prog_apmt882"
                       EXIT MENU
                    ELSE
                       IF cl_null(g_inds_d[g_detail_idx].inds016) THEN
                       HIDE OPTION "prog_apmt882"
                       EXIT MENU                       
                       END IF
                    END IF
                  #151125-00007#1(E)
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apmt882
                  LET g_action_choice="prog_apmt882"
                  IF cl_auth_chk_act("prog_apmt882") THEN
                     
                     #add-point:ON ACTION prog_apmt882 name="menu.detail_show.page1_sub.prog_apmt882"
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog = 'apmt882'
                     LET la_param.param[1] = g_inds_d[g_detail_idx].inds016
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aint801_browser_fill("")
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
               CALL aint801_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint801_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint801_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL aint801_set_act_visible()
            CALL aint801_set_act_no_visible()
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint801_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint801_set_act_visible()   
            CALL aint801_set_act_no_visible()
            IF NOT (g_indr_m.indrdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " indrent = " ||g_enterprise|| " AND",
                                  " indrdocno = '", g_indr_m.indrdocno, "' "
 
               #填到對應位置
               CALL aint801_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "indr_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inds_t" 
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
               CALL aint801_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "indr_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inds_t" 
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
                  CALL aint801_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint801_fetch("F")
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
               CALL aint801_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint801_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint801_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint801_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint801_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint801_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint801_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint801_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint801_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint801_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint801_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_inds_d)
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
               NEXT FIELD indsseq
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aint801_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#17 -s by 08172
               CALL aint801_set_act_visible()   
               CALL aint801_set_act_no_visible()
               #160818-00017#17 -e by 08172  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint801_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#17 -s by 08172
               CALL aint801_set_act_visible()   
               CALL aint801_set_act_no_visible()
               #160818-00017#17 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aint801_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#17 -s by 08172
               CALL aint801_set_act_visible()   
               CALL aint801_set_act_no_visible()
               #160818-00017#17 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aint801_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ain/aint801_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ain/aint801_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aint801_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint801_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_inds
            LET g_action_choice="gen_inds"
            IF cl_auth_chk_act("gen_inds") THEN
               
               #add-point:ON ACTION gen_inds name="menu.gen_inds"
               CALL s_transaction_begin()
                
               IF NOT aint801_01(g_indr_m.indrsite,g_indr_m.indrdocno,g_indr_m.indr002,g_indr_m.indr004) THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               CALL aint801_b_fill() #單身填充
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_inds2
            LET g_action_choice="gen_inds2"
            IF cl_auth_chk_act("gen_inds2") THEN
               
               #add-point:ON ACTION gen_inds2 name="menu.gen_inds2"
               CALL s_transaction_begin()
                
               IF NOT aint801_02(g_indr_m.indrsite,g_indr_m.indrdocno,g_indr_m.indr002,g_indr_m.indr004) THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               CALL aint801_b_fill() #單身填充
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_indr001
            LET g_action_choice="prog_indr001"
            IF cl_auth_chk_act("prog_indr001") THEN
               
               #add-point:ON ACTION prog_indr001 name="menu.prog_indr001"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_indr_m.indr001)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint801_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint801_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint801_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_indr_m.indrdocdt)
 
 
 
         
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
 
{<section id="aint801.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint801_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   LET l_where = s_aooi500_sql_where(g_prog,'indrsite')
   IF cl_null(g_wc) THEN
      LET g_wc = l_where
   ELSE
      LET g_wc = g_wc CLIPPED," AND ",l_where
   END IF
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
   LET l_wc = l_wc CLIPPED," AND indr000 = '1'"
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT indrdocno ",
                      " FROM indr_t ",
                      " ",
                      " LEFT JOIN inds_t ON indsent = indrent AND indrdocno = indsdocno ", "  ",
                      #add-point:browser_fill段sql(inds_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE indrent = " ||g_enterprise|| " AND indsent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("indr_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT indrdocno ",
                      " FROM indr_t ", 
                      "  ",
                      "  ",
                      " WHERE indrent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("indr_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
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
      INITIALIZE g_indr_m.* TO NULL
      CALL g_inds_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.indrsite,t0.indrdocno,t0.indrdocdt,t0.indr001,t0.indr002,t0.indr003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.indrstus,t0.indrsite,t0.indrdocno,t0.indrdocdt,t0.indr001,t0.indr002, 
          t0.indr003,t1.ooefl003 ,t2.ooag011 ,t3.rtaxl003 ",
                  " FROM indr_t t0",
                  "  ",
                  "  LEFT JOIN inds_t ON indsent = indrent AND indrdocno = indsdocno ", "  ", 
                  #add-point:browser_fill段sql(inds_t1) name="browser_fill.join.inds_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indrsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.indr001  ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.indr002 AND t3.rtaxl002='"||g_dlang||"' ",
 
                  " WHERE t0.indrent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("indr_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.indrstus,t0.indrsite,t0.indrdocno,t0.indrdocdt,t0.indr001,t0.indr002, 
          t0.indr003,t1.ooefl003 ,t2.ooag011 ,t3.rtaxl003 ",
                  " FROM indr_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.indrsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.indr001  ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.indr002 AND t3.rtaxl002='"||g_dlang||"' ",
 
                  " WHERE t0.indrent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("indr_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY indrdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"indr_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_indrsite,g_browser[g_cnt].b_indrdocno, 
          g_browser[g_cnt].b_indrdocdt,g_browser[g_cnt].b_indr001,g_browser[g_cnt].b_indr002,g_browser[g_cnt].b_indr003, 
          g_browser[g_cnt].b_indrsite_desc,g_browser[g_cnt].b_indr001_desc,g_browser[g_cnt].b_indr002_desc 
 
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
         CALL aint801_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_indrdocno) THEN
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
 
{<section id="aint801.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint801_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_indr_m.indrdocno = g_browser[g_current_idx].b_indrdocno   
 
   EXECUTE aint801_master_referesh USING g_indr_m.indrdocno INTO g_indr_m.indrsite,g_indr_m.indrdocdt, 
       g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit, 
       g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid,g_indr_m.indrcrtdp, 
       g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfdt, 
       g_indr_m.indrsite_desc,g_indr_m.indr001_desc,g_indr_m.indr002_desc,g_indr_m.indrownid_desc,g_indr_m.indrowndp_desc, 
       g_indr_m.indrcrtid_desc,g_indr_m.indrcrtdp_desc,g_indr_m.indrmodid_desc,g_indr_m.indrcnfid_desc 
 
   
   CALL aint801_indr_t_mask()
   CALL aint801_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint801.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint801_ui_detailshow()
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
 
{<section id="aint801.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint801_ui_browser_refresh()
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
      IF g_browser[l_i].b_indrdocno = g_indr_m.indrdocno 
 
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
 
{<section id="aint801.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint801_construct()
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
   INITIALIZE g_indr_m.* TO NULL
   CALL g_inds_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON indrsite,indrdocdt,indrdocno,indr001,indr002,indr004,indr003,indrunit, 
          indr000,indrstus,indrownid,indrowndp,indrcrtid,indrcrtdp,indrcrtdt,indrmodid,indrmoddt,indrcnfid, 
          indrcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<indrcrtdt>>----
         AFTER FIELD indrcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<indrmoddt>>----
         AFTER FIELD indrmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<indrcnfdt>>----
         AFTER FIELD indrcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<indrpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrsite
            #add-point:BEFORE FIELD indrsite name="construct.b.indrsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrsite
            
            #add-point:AFTER FIELD indrsite name="construct.a.indrsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indrsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrsite
            #add-point:ON ACTION controlp INFIELD indrsite name="construct.c.indrsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'indrsite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO indrsite  #顯示到畫面上
            NEXT FIELD indrsite                     #返回原欄位   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrdocdt
            #add-point:BEFORE FIELD indrdocdt name="construct.b.indrdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrdocdt
            
            #add-point:AFTER FIELD indrdocdt name="construct.a.indrdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indrdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrdocdt
            #add-point:ON ACTION controlp INFIELD indrdocdt name="construct.c.indrdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.indrdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrdocno
            #add-point:ON ACTION controlp INFIELD indrdocno name="construct.c.indrdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_indrdocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO indrdocno  #顯示到畫面上
            NEXT FIELD indrdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrdocno
            #add-point:BEFORE FIELD indrdocno name="construct.b.indrdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrdocno
            
            #add-point:AFTER FIELD indrdocno name="construct.a.indrdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr001
            #add-point:ON ACTION controlp INFIELD indr001 name="construct.c.indr001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooag001_8()                           #呼叫開窗   #151228-00009#1 20151230 mark by beckxie
            LET g_qryparam.arg1 = g_site                             #151228-00009#1 20151230  add by beckxie
            CALL q_ooag001_9()                           #呼叫開窗    #151228-00009#1 20151230  add by beckxie
            DISPLAY g_qryparam.return1 TO indr001  #顯示到畫面上
            NEXT FIELD indr001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr001
            #add-point:BEFORE FIELD indr001 name="construct.b.indr001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr001
            
            #add-point:AFTER FIELD indr001 name="construct.a.indr001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr002
            #add-point:ON ACTION controlp INFIELD indr002 name="construct.c.indr002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO indr002  #顯示到畫面上
            NEXT FIELD indr002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr002
            #add-point:BEFORE FIELD indr002 name="construct.b.indr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr002
            
            #add-point:AFTER FIELD indr002 name="construct.a.indr002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr004
            #add-point:BEFORE FIELD indr004 name="construct.b.indr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr004
            
            #add-point:AFTER FIELD indr004 name="construct.a.indr004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr004
            #add-point:ON ACTION controlp INFIELD indr004 name="construct.c.indr004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr003
            #add-point:BEFORE FIELD indr003 name="construct.b.indr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr003
            
            #add-point:AFTER FIELD indr003 name="construct.a.indr003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indr003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr003
            #add-point:ON ACTION controlp INFIELD indr003 name="construct.c.indr003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrunit
            #add-point:BEFORE FIELD indrunit name="construct.b.indrunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrunit
            
            #add-point:AFTER FIELD indrunit name="construct.a.indrunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indrunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrunit
            #add-point:ON ACTION controlp INFIELD indrunit name="construct.c.indrunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr000
            #add-point:BEFORE FIELD indr000 name="construct.b.indr000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr000
            
            #add-point:AFTER FIELD indr000 name="construct.a.indr000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indr000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr000
            #add-point:ON ACTION controlp INFIELD indr000 name="construct.c.indr000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrstus
            #add-point:BEFORE FIELD indrstus name="construct.b.indrstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrstus
            
            #add-point:AFTER FIELD indrstus name="construct.a.indrstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indrstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrstus
            #add-point:ON ACTION controlp INFIELD indrstus name="construct.c.indrstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.indrownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrownid
            #add-point:ON ACTION controlp INFIELD indrownid name="construct.c.indrownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indrownid  #顯示到畫面上
            NEXT FIELD indrownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrownid
            #add-point:BEFORE FIELD indrownid name="construct.b.indrownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrownid
            
            #add-point:AFTER FIELD indrownid name="construct.a.indrownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indrowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrowndp
            #add-point:ON ACTION controlp INFIELD indrowndp name="construct.c.indrowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indrowndp  #顯示到畫面上
            NEXT FIELD indrowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrowndp
            #add-point:BEFORE FIELD indrowndp name="construct.b.indrowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrowndp
            
            #add-point:AFTER FIELD indrowndp name="construct.a.indrowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indrcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrcrtid
            #add-point:ON ACTION controlp INFIELD indrcrtid name="construct.c.indrcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indrcrtid  #顯示到畫面上
            NEXT FIELD indrcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrcrtid
            #add-point:BEFORE FIELD indrcrtid name="construct.b.indrcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrcrtid
            
            #add-point:AFTER FIELD indrcrtid name="construct.a.indrcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indrcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrcrtdp
            #add-point:ON ACTION controlp INFIELD indrcrtdp name="construct.c.indrcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indrcrtdp  #顯示到畫面上
            NEXT FIELD indrcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrcrtdp
            #add-point:BEFORE FIELD indrcrtdp name="construct.b.indrcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrcrtdp
            
            #add-point:AFTER FIELD indrcrtdp name="construct.a.indrcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrcrtdt
            #add-point:BEFORE FIELD indrcrtdt name="construct.b.indrcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.indrmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrmodid
            #add-point:ON ACTION controlp INFIELD indrmodid name="construct.c.indrmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indrmodid  #顯示到畫面上
            NEXT FIELD indrmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrmodid
            #add-point:BEFORE FIELD indrmodid name="construct.b.indrmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrmodid
            
            #add-point:AFTER FIELD indrmodid name="construct.a.indrmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrmoddt
            #add-point:BEFORE FIELD indrmoddt name="construct.b.indrmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.indrcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrcnfid
            #add-point:ON ACTION controlp INFIELD indrcnfid name="construct.c.indrcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indrcnfid  #顯示到畫面上
            NEXT FIELD indrcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrcnfid
            #add-point:BEFORE FIELD indrcnfid name="construct.b.indrcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrcnfid
            
            #add-point:AFTER FIELD indrcnfid name="construct.a.indrcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrcnfdt
            #add-point:BEFORE FIELD indrcnfdt name="construct.b.indrcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON indsunit,indsseq,indsseq1,inds001,indssite,inds003,inds002,inds021,inds005, 
          inds004,inds020,inds006,inds007,inds008,inds009,inds010,inds011,inds014,inds015,inds016,inds017, 
          inds018,inds019
           FROM s_detail1[1].indsunit,s_detail1[1].indsseq,s_detail1[1].indsseq1,s_detail1[1].inds001, 
               s_detail1[1].indssite,s_detail1[1].inds003,s_detail1[1].inds002,s_detail1[1].inds021, 
               s_detail1[1].inds005,s_detail1[1].inds004,s_detail1[1].inds020,s_detail1[1].inds006,s_detail1[1].inds007, 
               s_detail1[1].inds008,s_detail1[1].inds009,s_detail1[1].inds010,s_detail1[1].inds011,s_detail1[1].inds014, 
               s_detail1[1].inds015,s_detail1[1].inds016,s_detail1[1].inds017,s_detail1[1].inds018,s_detail1[1].inds019 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            DISPLAY '' TO s_detail1[1].indsunit   #150710-00006#1 20150710 add by beckxie
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indsunit
            #add-point:BEFORE FIELD indsunit name="construct.b.page1.indsunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indsunit
            
            #add-point:AFTER FIELD indsunit name="construct.a.page1.indsunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indsunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indsunit
            #add-point:ON ACTION controlp INFIELD indsunit name="construct.c.page1.indsunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indsseq
            #add-point:BEFORE FIELD indsseq name="construct.b.page1.indsseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indsseq
            
            #add-point:AFTER FIELD indsseq name="construct.a.page1.indsseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indsseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indsseq
            #add-point:ON ACTION controlp INFIELD indsseq name="construct.c.page1.indsseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indsseq1
            #add-point:BEFORE FIELD indsseq1 name="construct.b.page1.indsseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indsseq1
            
            #add-point:AFTER FIELD indsseq1 name="construct.a.page1.indsseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indsseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indsseq1
            #add-point:ON ACTION controlp INFIELD indsseq1 name="construct.c.page1.indsseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inds001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds001
            #add-point:ON ACTION controlp INFIELD inds001 name="construct.c.page1.inds001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inds001  #顯示到畫面上
            NEXT FIELD inds001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds001
            #add-point:BEFORE FIELD inds001 name="construct.b.page1.inds001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds001
            
            #add-point:AFTER FIELD inds001 name="construct.a.page1.inds001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indssite
            #add-point:BEFORE FIELD indssite name="construct.b.page1.indssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indssite
            
            #add-point:AFTER FIELD indssite name="construct.a.page1.indssite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.indssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indssite
            #add-point:ON ACTION controlp INFIELD indssite name="construct.c.page1.indssite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inds003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds003
            #add-point:ON ACTION controlp INFIELD inds003 name="construct.c.page1.inds003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inay001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inds003  #顯示到畫面上
            NEXT FIELD inds003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds003
            #add-point:BEFORE FIELD inds003 name="construct.b.page1.inds003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds003
            
            #add-point:AFTER FIELD inds003 name="construct.a.page1.inds003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds002
            #add-point:ON ACTION controlp INFIELD inds002 name="construct.c.page1.inds002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_11()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inds002  #顯示到畫面上
            NEXT FIELD inds002                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds002
            #add-point:BEFORE FIELD inds002 name="construct.b.page1.inds002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds002
            
            #add-point:AFTER FIELD inds002 name="construct.a.page1.inds002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds021
            #add-point:BEFORE FIELD inds021 name="construct.b.page1.inds021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds021
            
            #add-point:AFTER FIELD inds021 name="construct.a.page1.inds021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds021
            #add-point:ON ACTION controlp INFIELD inds021 name="construct.c.page1.inds021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inds005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds005
            #add-point:ON ACTION controlp INFIELD inds005 name="construct.c.page1.inds005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inds005  #顯示到畫面上
            NEXT FIELD inds005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds005
            #add-point:BEFORE FIELD inds005 name="construct.b.page1.inds005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds005
            
            #add-point:AFTER FIELD inds005 name="construct.a.page1.inds005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds004
            #add-point:ON ACTION controlp INFIELD inds004 name="construct.c.page1.inds004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inds004  #顯示到畫面上
            NEXT FIELD inds004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds004
            #add-point:BEFORE FIELD inds004 name="construct.b.page1.inds004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds004
            
            #add-point:AFTER FIELD inds004 name="construct.a.page1.inds004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds020
            #add-point:BEFORE FIELD inds020 name="construct.b.page1.inds020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds020
            
            #add-point:AFTER FIELD inds020 name="construct.a.page1.inds020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds020
            #add-point:ON ACTION controlp INFIELD inds020 name="construct.c.page1.inds020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inds006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds006
            #add-point:ON ACTION controlp INFIELD inds006 name="construct.c.page1.inds006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inds006  #顯示到畫面上
            NEXT FIELD inds006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds006
            #add-point:BEFORE FIELD inds006 name="construct.b.page1.inds006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds006
            
            #add-point:AFTER FIELD inds006 name="construct.a.page1.inds006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds007
            #add-point:BEFORE FIELD inds007 name="construct.b.page1.inds007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds007
            
            #add-point:AFTER FIELD inds007 name="construct.a.page1.inds007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds007
            #add-point:ON ACTION controlp INFIELD inds007 name="construct.c.page1.inds007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds008
            #add-point:BEFORE FIELD inds008 name="construct.b.page1.inds008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds008
            
            #add-point:AFTER FIELD inds008 name="construct.a.page1.inds008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds008
            #add-point:ON ACTION controlp INFIELD inds008 name="construct.c.page1.inds008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds009
            #add-point:BEFORE FIELD inds009 name="construct.b.page1.inds009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds009
            
            #add-point:AFTER FIELD inds009 name="construct.a.page1.inds009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds009
            #add-point:ON ACTION controlp INFIELD inds009 name="construct.c.page1.inds009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds010
            #add-point:BEFORE FIELD inds010 name="construct.b.page1.inds010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds010
            
            #add-point:AFTER FIELD inds010 name="construct.a.page1.inds010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds010
            #add-point:ON ACTION controlp INFIELD inds010 name="construct.c.page1.inds010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds011
            #add-point:BEFORE FIELD inds011 name="construct.b.page1.inds011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds011
            
            #add-point:AFTER FIELD inds011 name="construct.a.page1.inds011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds011
            #add-point:ON ACTION controlp INFIELD inds011 name="construct.c.page1.inds011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inds014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds014
            #add-point:ON ACTION controlp INFIELD inds014 name="construct.c.page1.inds014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inds014  #顯示到畫面上
            NEXT FIELD inds014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds014
            #add-point:BEFORE FIELD inds014 name="construct.b.page1.inds014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds014
            
            #add-point:AFTER FIELD inds014 name="construct.a.page1.inds014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds015
            #add-point:BEFORE FIELD inds015 name="construct.b.page1.inds015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds015
            
            #add-point:AFTER FIELD inds015 name="construct.a.page1.inds015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds015
            #add-point:ON ACTION controlp INFIELD inds015 name="construct.c.page1.inds015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds016
            #add-point:BEFORE FIELD inds016 name="construct.b.page1.inds016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds016
            
            #add-point:AFTER FIELD inds016 name="construct.a.page1.inds016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds016
            #add-point:ON ACTION controlp INFIELD inds016 name="construct.c.page1.inds016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds017
            #add-point:BEFORE FIELD inds017 name="construct.b.page1.inds017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds017
            
            #add-point:AFTER FIELD inds017 name="construct.a.page1.inds017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds017
            #add-point:ON ACTION controlp INFIELD inds017 name="construct.c.page1.inds017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds018
            #add-point:BEFORE FIELD inds018 name="construct.b.page1.inds018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds018
            
            #add-point:AFTER FIELD inds018 name="construct.a.page1.inds018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds018
            #add-point:ON ACTION controlp INFIELD inds018 name="construct.c.page1.inds018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds019
            #add-point:BEFORE FIELD inds019 name="construct.b.page1.inds019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds019
            
            #add-point:AFTER FIELD inds019 name="construct.a.page1.inds019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inds019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds019
            #add-point:ON ACTION controlp INFIELD inds019 name="construct.c.page1.inds019"
            
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
                  WHEN la_wc[li_idx].tableid = "indr_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "inds_t" 
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
 
{<section id="aint801.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint801_filter()
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
      CONSTRUCT g_wc_filter ON indrsite,indrdocno,indrdocdt,indr001,indr002,indr003
                          FROM s_browse[1].b_indrsite,s_browse[1].b_indrdocno,s_browse[1].b_indrdocdt, 
                              s_browse[1].b_indr001,s_browse[1].b_indr002,s_browse[1].b_indr003
 
         BEFORE CONSTRUCT
               DISPLAY aint801_filter_parser('indrsite') TO s_browse[1].b_indrsite
            DISPLAY aint801_filter_parser('indrdocno') TO s_browse[1].b_indrdocno
            DISPLAY aint801_filter_parser('indrdocdt') TO s_browse[1].b_indrdocdt
            DISPLAY aint801_filter_parser('indr001') TO s_browse[1].b_indr001
            DISPLAY aint801_filter_parser('indr002') TO s_browse[1].b_indr002
            DISPLAY aint801_filter_parser('indr003') TO s_browse[1].b_indr003
      
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
 
      CALL aint801_filter_show('indrsite')
   CALL aint801_filter_show('indrdocno')
   CALL aint801_filter_show('indrdocdt')
   CALL aint801_filter_show('indr001')
   CALL aint801_filter_show('indr002')
   CALL aint801_filter_show('indr003')
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint801_filter_parser(ps_field)
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
 
{<section id="aint801.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint801_filter_show(ps_field)
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
   LET ls_condition = aint801_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint801_query()
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
   CALL g_inds_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint801_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint801_browser_fill("")
      CALL aint801_fetch("")
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
      CALL aint801_filter_show('indrsite')
   CALL aint801_filter_show('indrdocno')
   CALL aint801_filter_show('indrdocdt')
   CALL aint801_filter_show('indr001')
   CALL aint801_filter_show('indr002')
   CALL aint801_filter_show('indr003')
   CALL aint801_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint801_fetch("F") 
      #顯示單身筆數
      CALL aint801_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint801_fetch(p_flag)
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
   
   LET g_indr_m.indrdocno = g_browser[g_current_idx].b_indrdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint801_master_referesh USING g_indr_m.indrdocno INTO g_indr_m.indrsite,g_indr_m.indrdocdt, 
       g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit, 
       g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid,g_indr_m.indrcrtdp, 
       g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfdt, 
       g_indr_m.indrsite_desc,g_indr_m.indr001_desc,g_indr_m.indr002_desc,g_indr_m.indrownid_desc,g_indr_m.indrowndp_desc, 
       g_indr_m.indrcrtid_desc,g_indr_m.indrcrtdp_desc,g_indr_m.indrmodid_desc,g_indr_m.indrcnfid_desc 
 
   
   #遮罩相關處理
   LET g_indr_m_mask_o.* =  g_indr_m.*
   CALL aint801_indr_t_mask()
   LET g_indr_m_mask_n.* =  g_indr_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint801_set_act_visible()   
   CALL aint801_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_indr_m_t.* = g_indr_m.*
   LET g_indr_m_o.* = g_indr_m.*
   
   LET g_data_owner = g_indr_m.indrownid      
   LET g_data_dept  = g_indr_m.indrowndp
   
   #重新顯示   
   CALL aint801_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint801_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert       LIKE type_t.num5
   DEFINE l_doctype      LIKE type_t.chr10
   DEFINE l_success      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_inds_d.clear()   
 
 
   INITIALIZE g_indr_m.* TO NULL             #DEFAULT 設定
   
   LET g_indrdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_indr_m.indrownid = g_user
      LET g_indr_m.indrowndp = g_dept
      LET g_indr_m.indrcrtid = g_user
      LET g_indr_m.indrcrtdp = g_dept 
      LET g_indr_m.indrcrtdt = cl_get_current()
      LET g_indr_m.indrmodid = g_user
      LET g_indr_m.indrmoddt = cl_get_current()
      LET g_indr_m.indrstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_indr_m.indr004 = "N"
      LET g_indr_m.indr000 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_site_flag = FALSE

      CALL s_aooi500_default(g_prog,'indrsite',g_indr_m.indrsite) RETURNING l_insert,g_indr_m.indrsite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_desc_get_department_desc(g_indr_m.indrsite) RETURNING g_indr_m.indrsite_desc
      DISPLAY BY NAME g_indr_m.indrsite_desc

      CALL s_aooi500_default(g_prog,'indrunit',g_indr_m.indrsite) RETURNING l_insert,g_indr_m.indrunit
      IF NOT l_insert THEN
         RETURN
      END IF

      LET g_indr_m.indrdocdt = g_today
      LET g_indr_m.indr001 = g_user
      CALL s_desc_get_person_desc(g_indr_m.indr001) RETURNING g_indr_m.indr001_desc
      DISPLAY BY NAME g_indr_m.indr001_desc
      #預設單別
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_indr_m.indrsite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_indr_m.indrdocno = l_doctype
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_indr_m_t.* = g_indr_m.*
      LET g_indr_m_o.* = g_indr_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_indr_m.indrstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
 
 
 
    
      CALL aint801_input("a")
      
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
         INITIALIZE g_indr_m.* TO NULL
         INITIALIZE g_inds_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint801_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_inds_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint801_set_act_visible()   
   CALL aint801_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_indrdocno_t = g_indr_m.indrdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " indrent = " ||g_enterprise|| " AND",
                      " indrdocno = '", g_indr_m.indrdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint801_cl
   
   CALL aint801_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint801_master_referesh USING g_indr_m.indrdocno INTO g_indr_m.indrsite,g_indr_m.indrdocdt, 
       g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit, 
       g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid,g_indr_m.indrcrtdp, 
       g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfdt, 
       g_indr_m.indrsite_desc,g_indr_m.indr001_desc,g_indr_m.indr002_desc,g_indr_m.indrownid_desc,g_indr_m.indrowndp_desc, 
       g_indr_m.indrcrtid_desc,g_indr_m.indrcrtdp_desc,g_indr_m.indrmodid_desc,g_indr_m.indrcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_indr_m_mask_o.* =  g_indr_m.*
   CALL aint801_indr_t_mask()
   LET g_indr_m_mask_n.* =  g_indr_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_indr_m.indrsite,g_indr_m.indrsite_desc,g_indr_m.indrdocdt,g_indr_m.indrdocno,g_indr_m.indr001, 
       g_indr_m.indr001_desc,g_indr_m.indr002,g_indr_m.indr002_desc,g_indr_m.indr004,g_indr_m.indr003, 
       g_indr_m.l_cnt_err_money,g_indr_m.indrunit,g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid, 
       g_indr_m.indrownid_desc,g_indr_m.indrowndp,g_indr_m.indrowndp_desc,g_indr_m.indrcrtid,g_indr_m.indrcrtid_desc, 
       g_indr_m.indrcrtdp,g_indr_m.indrcrtdp_desc,g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmodid_desc, 
       g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfid_desc,g_indr_m.indrcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_indr_m.indrownid      
   LET g_data_dept  = g_indr_m.indrowndp
   
   #功能已完成,通報訊息中心
   CALL aint801_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint801.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint801_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE  l_chr                 LIKE type_t.chr10    #151118-00002#2 2015/12/03 By benson
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_indr_m_t.* = g_indr_m.*
   LET g_indr_m_o.* = g_indr_m.*
   
   IF g_indr_m.indrdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_indrdocno_t = g_indr_m.indrdocno
 
   CALL s_transaction_begin()
   
   OPEN aint801_cl USING g_enterprise,g_indr_m.indrdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint801_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint801_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint801_master_referesh USING g_indr_m.indrdocno INTO g_indr_m.indrsite,g_indr_m.indrdocdt, 
       g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit, 
       g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid,g_indr_m.indrcrtdp, 
       g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfdt, 
       g_indr_m.indrsite_desc,g_indr_m.indr001_desc,g_indr_m.indr002_desc,g_indr_m.indrownid_desc,g_indr_m.indrowndp_desc, 
       g_indr_m.indrcrtid_desc,g_indr_m.indrcrtdp_desc,g_indr_m.indrmodid_desc,g_indr_m.indrcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aint801_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_indr_m_mask_o.* =  g_indr_m.*
   CALL aint801_indr_t_mask()
   LET g_indr_m_mask_n.* =  g_indr_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aint801_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_indrdocno_t = g_indr_m.indrdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_indr_m.indrmodid = g_user 
LET g_indr_m.indrmoddt = cl_get_current()
LET g_indr_m.indrmodid_desc = cl_get_username(g_indr_m.indrmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint801_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE indr_t SET (indrmodid,indrmoddt) = (g_indr_m.indrmodid,g_indr_m.indrmoddt)
          WHERE indrent = g_enterprise AND indrdocno = g_indrdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_indr_m.* = g_indr_m_t.*
            CALL aint801_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_indr_m.indrdocno != g_indr_m_t.indrdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE inds_t SET indsdocno = g_indr_m.indrdocno
 
          WHERE indsent = g_enterprise AND indsdocno = g_indr_m_t.indrdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "inds_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inds_t:",SQLERRMESSAGE 
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
   CALL aint801_set_act_visible()   
   CALL aint801_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " indrent = " ||g_enterprise|| " AND",
                      " indrdocno = '", g_indr_m.indrdocno, "' "
 
   #填到對應位置
   CALL aint801_browser_fill("")
 
   CLOSE aint801_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint801_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint801.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint801_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_chr                 LIKE type_t.chr10    #151118-00002#2 2015/12/03 By benson
   DEFINE  l_sql1                STRING     #160711-00040#15 add
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
   DISPLAY BY NAME g_indr_m.indrsite,g_indr_m.indrsite_desc,g_indr_m.indrdocdt,g_indr_m.indrdocno,g_indr_m.indr001, 
       g_indr_m.indr001_desc,g_indr_m.indr002,g_indr_m.indr002_desc,g_indr_m.indr004,g_indr_m.indr003, 
       g_indr_m.l_cnt_err_money,g_indr_m.indrunit,g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid, 
       g_indr_m.indrownid_desc,g_indr_m.indrowndp,g_indr_m.indrowndp_desc,g_indr_m.indrcrtid,g_indr_m.indrcrtid_desc, 
       g_indr_m.indrcrtdp,g_indr_m.indrcrtdp_desc,g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmodid_desc, 
       g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfid_desc,g_indr_m.indrcnfdt
   
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
   LET g_forupd_sql = "SELECT indsunit,indsseq,indsseq1,inds001,indssite,inds003,inds002,inds021,inds005, 
       inds004,inds020,inds006,inds007,inds008,inds009,inds010,inds011,inds014,inds015,inds016,inds017, 
       inds018,inds019 FROM inds_t WHERE indsent=? AND indsdocno=? AND indsseq=? AND indsseq1=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint801_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint801_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aint801_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_indr_m.indrsite,g_indr_m.indrdocdt,g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002, 
       g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit,g_indr_m.indr000,g_indr_m.indrstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint801.input.head" >}
      #單頭段
      INPUT BY NAME g_indr_m.indrsite,g_indr_m.indrdocdt,g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002, 
          g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit,g_indr_m.indr000,g_indr_m.indrstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint801_cl USING g_enterprise,g_indr_m.indrdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint801_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aint801_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrsite
            
            #add-point:AFTER FIELD indrsite name="input.a.indrsite"
            LET g_indr_m.indrsite_desc = ''
            DISPLAY BY NAME g_indr_m.indrsite_desc
            IF NOT cl_null(g_indr_m.indrsite) THEN
               CALL s_aooi500_chk(g_prog,'indrsite',g_indr_m.indrsite,g_indr_m.indrsite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_indr_m.indrsite = g_indr_m_t.indrsite
                  CALL s_desc_get_department_desc(g_indr_m.indrsite) RETURNING g_indr_m.indrsite_desc
                  DISPLAY BY NAME g_indr_m.indrsite_desc
                  NEXT FIELD CURRENT
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET g_indr_m.indrsite = g_indr_m_t.indrsite
               CALL s_desc_get_department_desc(g_indr_m.indrsite) RETURNING g_indr_m.indrsite_desc
               DISPLAY BY NAME g_indr_m.indrsite_desc
               NEXT FIELD CURRENT
            END IF
            CALL s_desc_get_department_desc(g_indr_m.indrsite) RETURNING g_indr_m.indrsite_desc
            DISPLAY BY NAME g_indr_m.indrsite_desc
            LET g_site_flag = TRUE
            CALL aint801_set_entry(p_cmd)
            CALL aint801_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrsite
            #add-point:BEFORE FIELD indrsite name="input.b.indrsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indrsite
            #add-point:ON CHANGE indrsite name="input.g.indrsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrdocdt
            #add-point:BEFORE FIELD indrdocdt name="input.b.indrdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrdocdt
            
            #add-point:AFTER FIELD indrdocdt name="input.a.indrdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indrdocdt
            #add-point:ON CHANGE indrdocdt name="input.g.indrdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrdocno
            #add-point:BEFORE FIELD indrdocno name="input.b.indrdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrdocno
            
            #add-point:AFTER FIELD indrdocno name="input.a.indrdocno"
            IF NOT cl_null(g_indr_m.indrdocno) THEN
               IF NOT s_aooi200_chk_slip(g_indr_m.indrsite,'',g_indr_m.indrdocno,g_prog) THEN
                  LET g_indr_m.indrdocno = g_indr_m_t.indrdocno
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indrdocno
            #add-point:ON CHANGE indrdocno name="input.g.indrdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr001
            
            #add-point:AFTER FIELD indr001 name="input.a.indr001"
            LET g_indr_m.indr001_desc = ''
            DISPLAY BY NAME g_indr_m.indr001_desc
            IF NOT cl_null(g_indr_m.indr001) THEN
               IF g_indr_m.indr001 != g_indr_m_o.indr001 OR g_indr_m_o.indr001 IS NULL THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
                  LET g_chkparam.arg1 = g_indr_m.indr001
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#29  add
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_indr_m.indr001 = g_indr_m_o.indr001
                     CALL s_desc_get_person_desc(g_indr_m.indr001) RETURNING g_indr_m.indr001_desc
                     DISPLAY BY NAME g_indr_m.indr001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET  g_indr_m_o.indr001 = g_indr_m.indr001
            CALL s_desc_get_person_desc(g_indr_m.indr001) RETURNING g_indr_m.indr001_desc
            DISPLAY BY NAME g_indr_m.indr001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr001
            #add-point:BEFORE FIELD indr001 name="input.b.indr001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indr001
            #add-point:ON CHANGE indr001 name="input.g.indr001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr002
            
            #add-point:AFTER FIELD indr002 name="input.a.indr002"
            IF NOT cl_null(g_indr_m.indr002) THEN 
               IF g_indr_m.indr002 != 'ALL' THEN
                  IF g_indr_m.indr002 != g_indr_m_t.indr002 OR g_indr_m_t.indr002 IS NULL THEN
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
                     LET g_chkparam.arg1 = g_indr_m.indr002
                     LET g_chkparam.arg2 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
                     LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"#要執行的建議程式待補 #160318-00025#29  add
                     IF NOT cl_chk_exist("v_rtax001_3") THEN
                        LET g_indr_m.indr002 = g_indr_m_t.indr002
                        CALL s_desc_get_rtaxl003_desc(g_indr_m.indr002) RETURNING g_indr_m.indr002_desc
                        DISPLAY BY NAME g_indr_m.indr002_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF 
            CALL s_desc_get_rtaxl003_desc(g_indr_m.indr002) RETURNING g_indr_m.indr002_desc
            DISPLAY BY NAME g_indr_m.indr002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr002
            #add-point:BEFORE FIELD indr002 name="input.b.indr002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indr002
            #add-point:ON CHANGE indr002 name="input.g.indr002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr004
            #add-point:BEFORE FIELD indr004 name="input.b.indr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr004
            
            #add-point:AFTER FIELD indr004 name="input.a.indr004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indr004
            #add-point:ON CHANGE indr004 name="input.g.indr004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr003
            #add-point:BEFORE FIELD indr003 name="input.b.indr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr003
            
            #add-point:AFTER FIELD indr003 name="input.a.indr003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indr003
            #add-point:ON CHANGE indr003 name="input.g.indr003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrunit
            #add-point:BEFORE FIELD indrunit name="input.b.indrunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrunit
            
            #add-point:AFTER FIELD indrunit name="input.a.indrunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indrunit
            #add-point:ON CHANGE indrunit name="input.g.indrunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indr000
            #add-point:BEFORE FIELD indr000 name="input.b.indr000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indr000
            
            #add-point:AFTER FIELD indr000 name="input.a.indr000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indr000
            #add-point:ON CHANGE indr000 name="input.g.indr000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indrstus
            #add-point:BEFORE FIELD indrstus name="input.b.indrstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indrstus
            
            #add-point:AFTER FIELD indrstus name="input.a.indrstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indrstus
            #add-point:ON CHANGE indrstus name="input.g.indrstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.indrsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrsite
            #add-point:ON ACTION controlp INFIELD indrsite name="input.c.indrsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indr_m.indrsite          
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'indrsite',g_indr_m.indrsite,'i') 
            CALL q_ooef001_24()
            LET g_indr_m.indrsite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_indr_m.indrsite TO indrsite                   #顯示到畫面上
            CALL s_desc_get_department_desc(g_indr_m.indrsite) RETURNING g_indr_m.indrsite_desc
            DISPLAY BY NAME g_indr_m.indrsite_desc
            NEXT FIELD indrsite                                     #返回原欄位    
            #END add-point
 
 
         #Ctrlp:input.c.indrdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrdocdt
            #add-point:ON ACTION controlp INFIELD indrdocdt name="input.c.indrdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.indrdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrdocno
            #add-point:ON ACTION controlp INFIELD indrdocno name="input.c.indrdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indr_m.indrdocno       #給予default值
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_indr_m.indrsite
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            #160711-00040#15 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#15 add(e)
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_indr_m.indrdocno = g_qryparam.return1
            DISPLAY g_indr_m.indrdocno TO indrdocno
            NEXT FIELD indrdocno                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.indr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr001
            #add-point:ON ACTION controlp INFIELD indr001 name="input.c.indr001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indr_m.indr001  #給予default值
            #CALL q_ooag001_8()                           #呼叫開窗   #151228-00009#1 20151230 mark by beckxie
            LET g_qryparam.arg1 = g_site                             #151228-00009#1 20151230  add by beckxie
            CALL q_ooag001_9()                           #呼叫開窗    #151228-00009#1 20151230  add by beckxie
            LET g_indr_m.indr001 = g_qryparam.return1              
            DISPLAY g_indr_m.indr001 TO indr001        
            CALL s_desc_get_person_desc(g_indr_m.indr001) RETURNING g_indr_m.indr001_desc
            DISPLAY BY NAME g_indr_m.indr001_desc
            NEXT FIELD indr001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.indr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr002
            #add-point:ON ACTION controlp INFIELD indr002 name="input.c.indr002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_indr_m.indr002    #給予default值
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
            LET g_qryparam.where = "rtax002 = '2'"
            CALL q_rtax001_3()                            #呼叫開窗
            LET g_indr_m.indr002 = g_qryparam.return1              
            DISPLAY g_indr_m.indr002 TO indr002         
            CALL s_desc_get_rtaxl003_desc(g_indr_m.indr002) RETURNING g_indr_m.indr002_desc
            DISPLAY BY NAME g_indr_m.indr002_desc            
            NEXT FIELD indr002                            #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.indr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr004
            #add-point:ON ACTION controlp INFIELD indr004 name="input.c.indr004"
            
            #END add-point
 
 
         #Ctrlp:input.c.indr003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr003
            #add-point:ON ACTION controlp INFIELD indr003 name="input.c.indr003"
            
            #END add-point
 
 
         #Ctrlp:input.c.indrunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrunit
            #add-point:ON ACTION controlp INFIELD indrunit name="input.c.indrunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.indr000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indr000
            #add-point:ON ACTION controlp INFIELD indr000 name="input.c.indr000"
            
            #END add-point
 
 
         #Ctrlp:input.c.indrstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indrstus
            #add-point:ON ACTION controlp INFIELD indrstus name="input.c.indrstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_indr_m.indrdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               IF NOT s_aooi200_chk_slip(g_indr_m.indrsite,'',g_indr_m.indrdocno,g_prog) THEN
                  LET g_indr_m.indrdocno = ''
                  NEXT FIELD indrdocno
               END IF

               CALL s_aooi200_gen_docno(g_indr_m.indrsite,g_indr_m.indrdocno,g_indr_m.indrdocdt,g_prog) RETURNING l_flag,g_indr_m.indrdocno
               IF NOT l_flag THEN
                  NEXT FIELD indrdocno
               END IF
               
               LET g_indr_m.indrunit = g_indr_m.indrsite
               #end add-point
               
               INSERT INTO indr_t (indrent,indrsite,indrdocdt,indrdocno,indr001,indr002,indr004,indr003, 
                   indrunit,indr000,indrstus,indrownid,indrowndp,indrcrtid,indrcrtdp,indrcrtdt,indrmodid, 
                   indrmoddt,indrcnfid,indrcnfdt)
               VALUES (g_enterprise,g_indr_m.indrsite,g_indr_m.indrdocdt,g_indr_m.indrdocno,g_indr_m.indr001, 
                   g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit,g_indr_m.indr000, 
                   g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid,g_indr_m.indrcrtdp, 
                   g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_indr_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
 
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #151118-00002#1 2015/11/23 By benson --- S
               LET l_cnt = 0 
               SELECT COUNT(1) INTO l_cnt FROM inds_t 
                WHERE indsent = g_enterprise
                  AND indsdocno = g_indr_m.indrdocno
               IF l_cnt = 0 THEN
               #151118-00002#1 2015/11/23 By benson --- E
                  #151118-00002#3 2015/12/03 By benson --- S
                  CALL cl_ask_type2('(SCC)6878','ain-00692','ain-00691','R') RETURNING l_chr
                  IF l_chr = '0' THEN 
                  #151118-00002#3 2015/12/03 By benson --- E
                     IF NOT aint801_01(g_indr_m.indrsite,g_indr_m.indrdocno,g_indr_m.indr002,g_indr_m.indr004) THEN
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  #151118-00002#3 2015/12/03 By benson --- S
                  ELSE
                     IF NOT aint801_02(g_indr_m.indrsite,g_indr_m.indrdocno,g_indr_m.indr002,g_indr_m.indr004) THEN
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #151118-00002#3 2015/12/03 By benson --- E
               END IF  #151118-00002#1 2015/11/23 By benson
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aint801_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint801_b_fill()
                  CALL aint801_b_fill2('0')
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
               CALL aint801_indr_t_mask_restore('restore_mask_o')
               
               UPDATE indr_t SET (indrsite,indrdocdt,indrdocno,indr001,indr002,indr004,indr003,indrunit, 
                   indr000,indrstus,indrownid,indrowndp,indrcrtid,indrcrtdp,indrcrtdt,indrmodid,indrmoddt, 
                   indrcnfid,indrcnfdt) = (g_indr_m.indrsite,g_indr_m.indrdocdt,g_indr_m.indrdocno,g_indr_m.indr001, 
                   g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit,g_indr_m.indr000, 
                   g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid,g_indr_m.indrcrtdp, 
                   g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfdt) 
 
                WHERE indrent = g_enterprise AND indrdocno = g_indrdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "indr_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               LET l_cnt = 0 
               SELECT COUNT(1) INTO l_cnt FROM inds_t
                WHERE indsent = g_enterprise
                  AND indsdocno = g_indr_m.indrdocno
               IF l_cnt = 0 THEN
                  #151118-00002#3 2015/12/03 By benson --- S
                  CALL cl_ask_type2('(SCC)6878','ain-00692','ain-00691','R') RETURNING l_chr
                  IF l_chr = '0' THEN 
                  #151118-00002#3 2015/12/03 By benson --- E
                     IF NOT aint801_01(g_indr_m.indrsite,g_indr_m.indrdocno,g_indr_m.indr002,g_indr_m.indr004) THEN
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  #151118-00002#3 2015/12/03 By benson --- S
                  ELSE
                     IF NOT aint801_02(g_indr_m.indrsite,g_indr_m.indrdocno,g_indr_m.indr002,g_indr_m.indr004) THEN
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #151118-00002#3 2015/12/03 By benson --- E
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint801_indr_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_indr_m_t)
               LET g_log2 = util.JSON.stringify(g_indr_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
 
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_indrdocno_t = g_indr_m.indrdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint801.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_inds_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inds_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint801_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_inds_d.getLength()
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
            OPEN aint801_cl USING g_enterprise,g_indr_m.indrdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_inds_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_inds_d[l_ac].indsseq IS NOT NULL
               AND g_inds_d[l_ac].indsseq1 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inds_d_t.* = g_inds_d[l_ac].*  #BACKUP
               LET g_inds_d_o.* = g_inds_d[l_ac].*  #BACKUP
               CALL aint801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aint801_set_no_entry_b(l_cmd)
               IF NOT aint801_lock_b("inds_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint801_bcl INTO g_inds_d[l_ac].indsunit,g_inds_d[l_ac].indsseq,g_inds_d[l_ac].indsseq1, 
                      g_inds_d[l_ac].inds001,g_inds_d[l_ac].indssite,g_inds_d[l_ac].inds003,g_inds_d[l_ac].inds002, 
                      g_inds_d[l_ac].inds021,g_inds_d[l_ac].inds005,g_inds_d[l_ac].inds004,g_inds_d[l_ac].inds020, 
                      g_inds_d[l_ac].inds006,g_inds_d[l_ac].inds007,g_inds_d[l_ac].inds008,g_inds_d[l_ac].inds009, 
                      g_inds_d[l_ac].inds010,g_inds_d[l_ac].inds011,g_inds_d[l_ac].inds014,g_inds_d[l_ac].inds015, 
                      g_inds_d[l_ac].inds016,g_inds_d[l_ac].inds017,g_inds_d[l_ac].inds018,g_inds_d[l_ac].inds019 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inds_d_t.indsseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inds_d_mask_o[l_ac].* =  g_inds_d[l_ac].*
                  CALL aint801_inds_t_mask()
                  LET g_inds_d_mask_n[l_ac].* =  g_inds_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint801_show()
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
            INITIALIZE g_inds_d[l_ac].* TO NULL 
            INITIALIZE g_inds_d_t.* TO NULL 
            INITIALIZE g_inds_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_inds_d[l_ac].indsseq1 = "1"
      LET g_inds_d[l_ac].inds007 = "0"
      LET g_inds_d[l_ac].inds008 = "0"
      LET g_inds_d[l_ac].inds009 = "0"
      LET g_inds_d[l_ac].inds010 = "0"
      LET g_inds_d[l_ac].inds011 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT MAX(indsseq) + 1 INTO g_inds_d[l_ac].indsseq FROM inds_t
             WHERE indsent = g_enterprise
               AND indsdocno = g_indr_m.indrdocno               
            #end add-point
            LET g_inds_d_t.* = g_inds_d[l_ac].*     #新輸入資料
            LET g_inds_d_o.* = g_inds_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aint801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inds_d[li_reproduce_target].* = g_inds_d[li_reproduce].*
 
               LET g_inds_d[li_reproduce_target].indsseq = NULL
               LET g_inds_d[li_reproduce_target].indsseq1 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM inds_t 
             WHERE indsent = g_enterprise AND indsdocno = g_indr_m.indrdocno
 
               AND indsseq = g_inds_d[l_ac].indsseq
               AND indsseq1 = g_inds_d[l_ac].indsseq1
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indr_m.indrdocno
               LET gs_keys[2] = g_inds_d[g_detail_idx].indsseq
               LET gs_keys[3] = g_inds_d[g_detail_idx].indsseq1
               CALL aint801_insert_b('inds_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_inds_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inds_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint801_b_fill()
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
               LET gs_keys[01] = g_indr_m.indrdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_inds_d_t.indsseq
               LET gs_keys[gs_keys.getLength()+1] = g_inds_d_t.indsseq1
 
            
               #刪除同層單身
               IF NOT aint801_delete_b('inds_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint801_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint801_key_delete_b(gs_keys,'inds_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint801_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint801_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_inds_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_inds_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indsunit
            #add-point:BEFORE FIELD indsunit name="input.b.page1.indsunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indsunit
            
            #add-point:AFTER FIELD indsunit name="input.a.page1.indsunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indsunit
            #add-point:ON CHANGE indsunit name="input.g.page1.indsunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indsseq
            #add-point:BEFORE FIELD indsseq name="input.b.page1.indsseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indsseq
            
            #add-point:AFTER FIELD indsseq name="input.a.page1.indsseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_indr_m.indrdocno IS NOT NULL AND g_inds_d[g_detail_idx].indsseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_indr_m.indrdocno != g_indrdocno_t OR g_inds_d[g_detail_idx].indsseq != g_inds_d_t.indsseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inds_t WHERE "||"indsent = '" ||g_enterprise|| "' AND "||"indsdocno = '"||g_indr_m.indrdocno ||"' AND "|| "indsseq = '"||g_inds_d[g_detail_idx].indsseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indsseq
            #add-point:ON CHANGE indsseq name="input.g.page1.indsseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indsseq1
            #add-point:BEFORE FIELD indsseq1 name="input.b.page1.indsseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indsseq1
            
            #add-point:AFTER FIELD indsseq1 name="input.a.page1.indsseq1"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_indr_m.indrdocno IS NOT NULL AND g_inds_d[g_detail_idx].indsseq IS NOT NULL AND g_inds_d[g_detail_idx].indsseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_indr_m.indrdocno != g_indrdocno_t OR g_inds_d[g_detail_idx].indsseq != g_inds_d_t.indsseq OR g_inds_d[g_detail_idx].indsseq1 != g_inds_d_t.indsseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM inds_t WHERE "||"indsent = '" ||g_enterprise|| "' AND "||"indsdocno = '"||g_indr_m.indrdocno ||"' AND "|| "indsseq = '"||g_inds_d[g_detail_idx].indsseq ||"' AND "|| "indsseq1 = '"||g_inds_d[g_detail_idx].indsseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indsseq1
            #add-point:ON CHANGE indsseq1 name="input.g.page1.indsseq1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds001
            #add-point:BEFORE FIELD inds001 name="input.b.page1.inds001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds001
            
            #add-point:AFTER FIELD inds001 name="input.a.page1.inds001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds001
            #add-point:ON CHANGE inds001 name="input.g.page1.inds001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indssite
            
            #add-point:AFTER FIELD indssite name="input.a.page1.indssite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inds_d[l_ac].indssite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inds_d[l_ac].indssite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inds_d[l_ac].indssite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indssite
            #add-point:BEFORE FIELD indssite name="input.b.page1.indssite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indssite
            #add-point:ON CHANGE indssite name="input.g.page1.indssite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds003
            
            #add-point:AFTER FIELD inds003 name="input.a.page1.inds003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inds_d[l_ac].inds003
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inds_d[l_ac].inds003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inds_d[l_ac].inds003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds003
            #add-point:BEFORE FIELD inds003 name="input.b.page1.inds003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds003
            #add-point:ON CHANGE inds003 name="input.g.page1.inds003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds002
            
            #add-point:AFTER FIELD inds002 name="input.a.page1.inds002"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds002
            #add-point:BEFORE FIELD inds002 name="input.b.page1.inds002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds002
            #add-point:ON CHANGE inds002 name="input.g.page1.inds002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds021
            #add-point:BEFORE FIELD inds021 name="input.b.page1.inds021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds021
            
            #add-point:AFTER FIELD inds021 name="input.a.page1.inds021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds021
            #add-point:ON CHANGE inds021 name="input.g.page1.inds021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds005
            #add-point:BEFORE FIELD inds005 name="input.b.page1.inds005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds005
            
            #add-point:AFTER FIELD inds005 name="input.a.page1.inds005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds005
            #add-point:ON CHANGE inds005 name="input.g.page1.inds005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds004
            
            #add-point:AFTER FIELD inds004 name="input.a.page1.inds004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inds_d[l_ac].inds004
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inds_d[l_ac].inds004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inds_d[l_ac].inds004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds004
            #add-point:BEFORE FIELD inds004 name="input.b.page1.inds004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds004
            #add-point:ON CHANGE inds004 name="input.g.page1.inds004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds020
            
            #add-point:AFTER FIELD inds020 name="input.a.page1.inds020"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds020
            #add-point:BEFORE FIELD inds020 name="input.b.page1.inds020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds020
            #add-point:ON CHANGE inds020 name="input.g.page1.inds020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds006
            
            #add-point:AFTER FIELD inds006 name="input.a.page1.inds006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inds_d[l_ac].inds006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inds_d[l_ac].inds006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inds_d[l_ac].inds006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds006
            #add-point:BEFORE FIELD inds006 name="input.b.page1.inds006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds006
            #add-point:ON CHANGE inds006 name="input.g.page1.inds006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds007
            #add-point:BEFORE FIELD inds007 name="input.b.page1.inds007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds007
            
            #add-point:AFTER FIELD inds007 name="input.a.page1.inds007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds007
            #add-point:ON CHANGE inds007 name="input.g.page1.inds007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds008
            #add-point:BEFORE FIELD inds008 name="input.b.page1.inds008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds008
            
            #add-point:AFTER FIELD inds008 name="input.a.page1.inds008"
            IF NOT cl_null(g_inds_d[l_ac].inds008) THEN
               ##151118-00002#1 2015/11/23 By benson --- S
               IF g_inds_d[l_ac].inds007 >= 0 THEN
                  IF g_inds_d[l_ac].inds007 + g_inds_d[l_ac].inds008 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_site
                     LET g_errparam.code   = 'ain-00684'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()   
                     LET g_inds_d[l_ac].inds008 = g_inds_d_o.inds008                       
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF g_inds_d[l_ac].inds008 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_site
                     LET g_errparam.code   = 'ain-00685'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()        
                     LET g_inds_d[l_ac].inds008 = g_inds_d_o.inds008                    
                     NEXT FIELD CURRENT
                  END IF               
               END IF  
               #151118-00002#1 2015/11/23 By benson --- E
            
               LET g_inds_d[l_ac].inds009 = g_inds_d[l_ac].inds007 + g_inds_d[l_ac].inds008
            END IF
            
            LET g_inds_d_o.inds008 = g_inds_d[l_ac].inds008  #151118-00002#1 2015/11/23 By benson
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds008
            #add-point:ON CHANGE inds008 name="input.g.page1.inds008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds009
            #add-point:BEFORE FIELD inds009 name="input.b.page1.inds009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds009
            
            #add-point:AFTER FIELD inds009 name="input.a.page1.inds009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds009
            #add-point:ON CHANGE inds009 name="input.g.page1.inds009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds010
            #add-point:BEFORE FIELD inds010 name="input.b.page1.inds010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds010
            
            #add-point:AFTER FIELD inds010 name="input.a.page1.inds010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds010
            #add-point:ON CHANGE inds010 name="input.g.page1.inds010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds011
            #add-point:BEFORE FIELD inds011 name="input.b.page1.inds011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds011
            
            #add-point:AFTER FIELD inds011 name="input.a.page1.inds011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds011
            #add-point:ON CHANGE inds011 name="input.g.page1.inds011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds014
            
            #add-point:AFTER FIELD inds014 name="input.a.page1.inds014"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inds_d[l_ac].inds014
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inds_d[l_ac].inds014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inds_d[l_ac].inds014_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds014
            #add-point:BEFORE FIELD inds014 name="input.b.page1.inds014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds014
            #add-point:ON CHANGE inds014 name="input.g.page1.inds014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds015
            #add-point:BEFORE FIELD inds015 name="input.b.page1.inds015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds015
            
            #add-point:AFTER FIELD inds015 name="input.a.page1.inds015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds015
            #add-point:ON CHANGE inds015 name="input.g.page1.inds015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds016
            #add-point:BEFORE FIELD inds016 name="input.b.page1.inds016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds016
            
            #add-point:AFTER FIELD inds016 name="input.a.page1.inds016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds016
            #add-point:ON CHANGE inds016 name="input.g.page1.inds016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds017
            #add-point:BEFORE FIELD inds017 name="input.b.page1.inds017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds017
            
            #add-point:AFTER FIELD inds017 name="input.a.page1.inds017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds017
            #add-point:ON CHANGE inds017 name="input.g.page1.inds017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds018
            #add-point:BEFORE FIELD inds018 name="input.b.page1.inds018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds018
            
            #add-point:AFTER FIELD inds018 name="input.a.page1.inds018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds018
            #add-point:ON CHANGE inds018 name="input.g.page1.inds018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inds019
            #add-point:BEFORE FIELD inds019 name="input.b.page1.inds019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inds019
            
            #add-point:AFTER FIELD inds019 name="input.a.page1.inds019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inds019
            #add-point:ON CHANGE inds019 name="input.g.page1.inds019"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.indsunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indsunit
            #add-point:ON ACTION controlp INFIELD indsunit name="input.c.page1.indsunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indsseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indsseq
            #add-point:ON ACTION controlp INFIELD indsseq name="input.c.page1.indsseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.indsseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indsseq1
            #add-point:ON ACTION controlp INFIELD indsseq1 name="input.c.page1.indsseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds001
            #add-point:ON ACTION controlp INFIELD inds001 name="input.c.page1.inds001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inds_d[l_ac].inds001 #批號
            LET g_qryparam.default2 = g_inds_d[l_ac].inds004 #商品編號
            LET g_qryparam.default3 = g_inds_d[l_ac].inds020 #產品特徵
            LET g_qryparam.default4 = g_inds_d[l_ac].inds003 #庫位編號
            LET g_qryparam.default5 = g_inds_d[l_ac].inds021 #庫存管理特徵
            LET g_qryparam.default6 = g_inds_d[l_ac].inds006 #庫存單位
            
            CALL q_inag006_6()                                #呼叫開窗

            LET g_inds_d[l_ac].inds001 = g_qryparam.return1              
            LET g_inds_d[l_ac].inds004 = g_qryparam.return2 
            LET g_inds_d[l_ac].inds020 = g_qryparam.return3 
            LET g_inds_d[l_ac].inds003 = g_qryparam.return4 
            LET g_inds_d[l_ac].inds021 = g_qryparam.return5 
            LET g_inds_d[l_ac].inds006 = g_qryparam.return6 
            
            DISPLAY BY NAME g_inds_d[l_ac].inds001, g_inds_d[l_ac].inds004,
                            g_inds_d[l_ac].inds020, g_inds_d[l_ac].inds003,
                            g_inds_d[l_ac].inds021, g_inds_d[l_ac].inds006
            
            NEXT FIELD inds001                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.indssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indssite
            #add-point:ON ACTION controlp INFIELD indssite name="input.c.page1.indssite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds003
            #add-point:ON ACTION controlp INFIELD inds003 name="input.c.page1.inds003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds002
            #add-point:ON ACTION controlp INFIELD inds002 name="input.c.page1.inds002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds021
            #add-point:ON ACTION controlp INFIELD inds021 name="input.c.page1.inds021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds005
            #add-point:ON ACTION controlp INFIELD inds005 name="input.c.page1.inds005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds004
            #add-point:ON ACTION controlp INFIELD inds004 name="input.c.page1.inds004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds020
            #add-point:ON ACTION controlp INFIELD inds020 name="input.c.page1.inds020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds006
            #add-point:ON ACTION controlp INFIELD inds006 name="input.c.page1.inds006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds007
            #add-point:ON ACTION controlp INFIELD inds007 name="input.c.page1.inds007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds008
            #add-point:ON ACTION controlp INFIELD inds008 name="input.c.page1.inds008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds009
            #add-point:ON ACTION controlp INFIELD inds009 name="input.c.page1.inds009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds010
            #add-point:ON ACTION controlp INFIELD inds010 name="input.c.page1.inds010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds011
            #add-point:ON ACTION controlp INFIELD inds011 name="input.c.page1.inds011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds014
            #add-point:ON ACTION controlp INFIELD inds014 name="input.c.page1.inds014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds015
            #add-point:ON ACTION controlp INFIELD inds015 name="input.c.page1.inds015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds016
            #add-point:ON ACTION controlp INFIELD inds016 name="input.c.page1.inds016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds017
            #add-point:ON ACTION controlp INFIELD inds017 name="input.c.page1.inds017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds018
            #add-point:ON ACTION controlp INFIELD inds018 name="input.c.page1.inds018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inds019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inds019
            #add-point:ON ACTION controlp INFIELD inds019 name="input.c.page1.inds019"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inds_d[l_ac].* = g_inds_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint801_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inds_d[l_ac].indsseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inds_d[l_ac].* = g_inds_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint801_inds_t_mask_restore('restore_mask_o')
      
               UPDATE inds_t SET (indsdocno,indsunit,indsseq,indsseq1,inds001,indssite,inds003,inds002, 
                   inds021,inds005,inds004,inds020,inds006,inds007,inds008,inds009,inds010,inds011,inds014, 
                   inds015,inds016,inds017,inds018,inds019) = (g_indr_m.indrdocno,g_inds_d[l_ac].indsunit, 
                   g_inds_d[l_ac].indsseq,g_inds_d[l_ac].indsseq1,g_inds_d[l_ac].inds001,g_inds_d[l_ac].indssite, 
                   g_inds_d[l_ac].inds003,g_inds_d[l_ac].inds002,g_inds_d[l_ac].inds021,g_inds_d[l_ac].inds005, 
                   g_inds_d[l_ac].inds004,g_inds_d[l_ac].inds020,g_inds_d[l_ac].inds006,g_inds_d[l_ac].inds007, 
                   g_inds_d[l_ac].inds008,g_inds_d[l_ac].inds009,g_inds_d[l_ac].inds010,g_inds_d[l_ac].inds011, 
                   g_inds_d[l_ac].inds014,g_inds_d[l_ac].inds015,g_inds_d[l_ac].inds016,g_inds_d[l_ac].inds017, 
                   g_inds_d[l_ac].inds018,g_inds_d[l_ac].inds019)
                WHERE indsent = g_enterprise AND indsdocno = g_indr_m.indrdocno 
 
                  AND indsseq = g_inds_d_t.indsseq #項次   
                  AND indsseq1 = g_inds_d_t.indsseq1  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_inds_d[l_ac].* = g_inds_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inds_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inds_d[l_ac].* = g_inds_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inds_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_indr_m.indrdocno
               LET gs_keys_bak[1] = g_indrdocno_t
               LET gs_keys[2] = g_inds_d[g_detail_idx].indsseq
               LET gs_keys_bak[2] = g_inds_d_t.indsseq
               LET gs_keys[3] = g_inds_d[g_detail_idx].indsseq1
               LET gs_keys_bak[3] = g_inds_d_t.indsseq1
               CALL aint801_update_b('inds_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint801_inds_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_inds_d[g_detail_idx].indsseq = g_inds_d_t.indsseq 
                  AND g_inds_d[g_detail_idx].indsseq1 = g_inds_d_t.indsseq1 
 
                  ) THEN
                  LET gs_keys[01] = g_indr_m.indrdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_inds_d_t.indsseq
                  LET gs_keys[gs_keys.getLength()+1] = g_inds_d_t.indsseq1
 
                  CALL aint801_key_update_b(gs_keys,'inds_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_indr_m),util.JSON.stringify(g_inds_d_t)
               LET g_log2 = util.JSON.stringify(g_indr_m),util.JSON.stringify(g_inds_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL aint801_b_fill()  #150710-00006#1 20150710 add by beckxie 
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aint801_unlock_b("inds_t","'1'")
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
               LET g_inds_d[li_reproduce_target].* = g_inds_d[li_reproduce].*
 
               LET g_inds_d[li_reproduce_target].indsseq = NULL
               LET g_inds_d[li_reproduce_target].indsseq1 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inds_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inds_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aint801.input.other" >}
      
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
            NEXT FIELD indrsite
            #end add-point  
            NEXT FIELD indrdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD indsunit
 
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
 
{<section id="aint801.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint801_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint801_b_fill() #單身填充
      CALL aint801_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint801_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_indr_m_mask_o.* =  g_indr_m.*
   CALL aint801_indr_t_mask()
   LET g_indr_m_mask_n.* =  g_indr_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_indr_m.indrsite,g_indr_m.indrsite_desc,g_indr_m.indrdocdt,g_indr_m.indrdocno,g_indr_m.indr001, 
       g_indr_m.indr001_desc,g_indr_m.indr002,g_indr_m.indr002_desc,g_indr_m.indr004,g_indr_m.indr003, 
       g_indr_m.l_cnt_err_money,g_indr_m.indrunit,g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid, 
       g_indr_m.indrownid_desc,g_indr_m.indrowndp,g_indr_m.indrowndp_desc,g_indr_m.indrcrtid,g_indr_m.indrcrtid_desc, 
       g_indr_m.indrcrtdp,g_indr_m.indrcrtdp_desc,g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmodid_desc, 
       g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfid_desc,g_indr_m.indrcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_indr_m.indrstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
   FOR l_ac = 1 TO g_inds_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint801_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint801.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint801_detail_show()
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
 
{<section id="aint801.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint801_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE indr_t.indrdocno 
   DEFINE l_oldno     LIKE indr_t.indrdocno 
 
   DEFINE l_master    RECORD LIKE indr_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE inds_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_indr_m.indrdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_indrdocno_t = g_indr_m.indrdocno
 
    
   LET g_indr_m.indrdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_indr_m.indrownid = g_user
      LET g_indr_m.indrowndp = g_dept
      LET g_indr_m.indrcrtid = g_user
      LET g_indr_m.indrcrtdp = g_dept 
      LET g_indr_m.indrcrtdt = cl_get_current()
      LET g_indr_m.indrmodid = g_user
      LET g_indr_m.indrmoddt = cl_get_current()
      LET g_indr_m.indrstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_indr_m.indrstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
   
   
   CALL aint801_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_indr_m.* TO NULL
      INITIALIZE g_inds_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint801_show()
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
   CALL aint801_set_act_visible()   
   CALL aint801_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_indrdocno_t = g_indr_m.indrdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " indrent = " ||g_enterprise|| " AND",
                      " indrdocno = '", g_indr_m.indrdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aint801_idx_chk()
   
   LET g_data_owner = g_indr_m.indrownid      
   LET g_data_dept  = g_indr_m.indrowndp
   
   #功能已完成,通報訊息中心
   CALL aint801_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint801_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE inds_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint801_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inds_t
    WHERE indsent = g_enterprise AND indsdocno = g_indrdocno_t
 
    INTO TEMP aint801_detail
 
   #將key修正為調整後   
   UPDATE aint801_detail 
      #更新key欄位
      SET indsdocno = g_indr_m.indrdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO inds_t SELECT * FROM aint801_detail
   
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
   DROP TABLE aint801_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_indrdocno_t = g_indr_m.indrdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint801.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint801_delete()
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
   
   IF g_indr_m.indrdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint801_cl USING g_enterprise,g_indr_m.indrdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint801_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint801_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint801_master_referesh USING g_indr_m.indrdocno INTO g_indr_m.indrsite,g_indr_m.indrdocdt, 
       g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit, 
       g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid,g_indr_m.indrcrtdp, 
       g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfdt, 
       g_indr_m.indrsite_desc,g_indr_m.indr001_desc,g_indr_m.indr002_desc,g_indr_m.indrownid_desc,g_indr_m.indrowndp_desc, 
       g_indr_m.indrcrtid_desc,g_indr_m.indrcrtdp_desc,g_indr_m.indrmodid_desc,g_indr_m.indrcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aint801_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_indr_m_mask_o.* =  g_indr_m.*
   CALL aint801_indr_t_mask()
   LET g_indr_m_mask_n.* =  g_indr_m.*
   
   CALL aint801_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   IF NOT s_aooi200_del_docno(g_indr_m.indrdocno,g_indr_m.indrdocdt) THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint801_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_indrdocno_t = g_indr_m.indrdocno
 
 
      DELETE FROM indr_t
       WHERE indrent = g_enterprise AND indrdocno = g_indr_m.indrdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_indr_m.indrdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
 
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM inds_t
       WHERE indsent = g_enterprise AND indsdocno = g_indr_m.indrdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inds_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_indr_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint801_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_inds_d.clear() 
 
     
      CALL aint801_ui_browser_refresh()  
      #CALL aint801_ui_headershow()  
      #CALL aint801_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint801_browser_fill("")
         CALL aint801_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint801_cl
 
   #功能已完成,通報訊息中心
   CALL aint801_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint801.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint801_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_inds_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aint801_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT indsunit,indsseq,indsseq1,inds001,indssite,inds003,inds002,inds021, 
             inds005,inds004,inds020,inds006,inds007,inds008,inds009,inds010,inds011,inds014,inds015, 
             inds016,inds017,inds018,inds019 ,t1.ooefl003 ,t2.inayl003 ,t3.inab003 ,t4.imaal003 ,t5.imaal004 , 
             t6.oocal003 ,t7.pmaal004 FROM inds_t",   
                     " INNER JOIN indr_t ON indrent = " ||g_enterprise|| " AND indrdocno = indsdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=indssite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=inds003 AND t2.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t3 ON t3.inabent="||g_enterprise||" AND t3.inabsite=indssite AND t3.inab001=inds003 AND t3.inab002=inds002  ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=inds004 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=inds004 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=inds006 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t7 ON t7.pmaalent="||g_enterprise||" AND t7.pmaal001=inds014 AND t7.pmaal002='"||g_dlang||"' ",
 
                     " WHERE indsent=? AND indsdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY inds_t.indsseq,inds_t.indsseq1"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint801_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint801_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_indr_m.indrdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_indr_m.indrdocno INTO g_inds_d[l_ac].indsunit,g_inds_d[l_ac].indsseq, 
          g_inds_d[l_ac].indsseq1,g_inds_d[l_ac].inds001,g_inds_d[l_ac].indssite,g_inds_d[l_ac].inds003, 
          g_inds_d[l_ac].inds002,g_inds_d[l_ac].inds021,g_inds_d[l_ac].inds005,g_inds_d[l_ac].inds004, 
          g_inds_d[l_ac].inds020,g_inds_d[l_ac].inds006,g_inds_d[l_ac].inds007,g_inds_d[l_ac].inds008, 
          g_inds_d[l_ac].inds009,g_inds_d[l_ac].inds010,g_inds_d[l_ac].inds011,g_inds_d[l_ac].inds014, 
          g_inds_d[l_ac].inds015,g_inds_d[l_ac].inds016,g_inds_d[l_ac].inds017,g_inds_d[l_ac].inds018, 
          g_inds_d[l_ac].inds019,g_inds_d[l_ac].indssite_desc,g_inds_d[l_ac].inds003_desc,g_inds_d[l_ac].inds002_desc, 
          g_inds_d[l_ac].inds004_desc,g_inds_d[l_ac].inds004_desc_desc,g_inds_d[l_ac].inds006_desc,g_inds_d[l_ac].inds014_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL s_desc_get_department_desc(g_inds_d[l_ac].indssite) RETURNING g_inds_d[l_ac].indssite_desc
         
         #產品特徵
         CALL s_feature_description( g_inds_d[l_ac].inds004, g_inds_d[l_ac].inds020)
          RETURNING l_success,g_inds_d[l_ac].inds020_desc
         #150710-00006#1 20150710 add by beckxie---S
         #差異金額(增減數量*批號原進價)
         LET g_inds_d[l_ac].l_mistakemoney=g_inds_d[l_ac].inds008*g_inds_d[l_ac].inds010
         #150710-00006#1 20150710 add by beckxie---E
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
   #150710-00006#1 20150710 add by beckxie---S
   LET g_indr_m.l_cnt_err_money=0
   SELECT  SUM(COALESCE(inds008,0)*COALESCE(inds010,0)) INTO g_indr_m.l_cnt_err_money
     FROM indr_t,inds_t
    WHERE indrent=indsent
      AND indrdocno=indsdocno
      AND indrdocno=g_indr_m.indrdocno
   DISPLAY BY NAME g_indr_m.l_cnt_err_money
   #150710-00006#1 20150710 add by beckxie---E
   #end add-point
   
   CALL g_inds_d.deleteElement(g_inds_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint801_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_inds_d.getLength()
      LET g_inds_d_mask_o[l_ac].* =  g_inds_d[l_ac].*
      CALL aint801_inds_t_mask()
      LET g_inds_d_mask_n[l_ac].* =  g_inds_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint801_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM inds_t
       WHERE indsent = g_enterprise AND
         indsdocno = ps_keys_bak[1] AND indsseq = ps_keys_bak[2] AND indsseq1 = ps_keys_bak[3]
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
         CALL g_inds_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   CALL aint801_b_fill()  #150710-00006#1 20150710 add by beckxie
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint801.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint801_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO inds_t
                  (indsent,
                   indsdocno,
                   indsseq,indsseq1
                   ,indsunit,inds001,indssite,inds003,inds002,inds021,inds005,inds004,inds020,inds006,inds007,inds008,inds009,inds010,inds011,inds014,inds015,inds016,inds017,inds018,inds019) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_inds_d[g_detail_idx].indsunit,g_inds_d[g_detail_idx].inds001,g_inds_d[g_detail_idx].indssite, 
                       g_inds_d[g_detail_idx].inds003,g_inds_d[g_detail_idx].inds002,g_inds_d[g_detail_idx].inds021, 
                       g_inds_d[g_detail_idx].inds005,g_inds_d[g_detail_idx].inds004,g_inds_d[g_detail_idx].inds020, 
                       g_inds_d[g_detail_idx].inds006,g_inds_d[g_detail_idx].inds007,g_inds_d[g_detail_idx].inds008, 
                       g_inds_d[g_detail_idx].inds009,g_inds_d[g_detail_idx].inds010,g_inds_d[g_detail_idx].inds011, 
                       g_inds_d[g_detail_idx].inds014,g_inds_d[g_detail_idx].inds015,g_inds_d[g_detail_idx].inds016, 
                       g_inds_d[g_detail_idx].inds017,g_inds_d[g_detail_idx].inds018,g_inds_d[g_detail_idx].inds019) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inds_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_inds_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint801.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint801_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inds_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint801_inds_t_mask_restore('restore_mask_o')
               
      UPDATE inds_t 
         SET (indsdocno,
              indsseq,indsseq1
              ,indsunit,inds001,indssite,inds003,inds002,inds021,inds005,inds004,inds020,inds006,inds007,inds008,inds009,inds010,inds011,inds014,inds015,inds016,inds017,inds018,inds019) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_inds_d[g_detail_idx].indsunit,g_inds_d[g_detail_idx].inds001,g_inds_d[g_detail_idx].indssite, 
                  g_inds_d[g_detail_idx].inds003,g_inds_d[g_detail_idx].inds002,g_inds_d[g_detail_idx].inds021, 
                  g_inds_d[g_detail_idx].inds005,g_inds_d[g_detail_idx].inds004,g_inds_d[g_detail_idx].inds020, 
                  g_inds_d[g_detail_idx].inds006,g_inds_d[g_detail_idx].inds007,g_inds_d[g_detail_idx].inds008, 
                  g_inds_d[g_detail_idx].inds009,g_inds_d[g_detail_idx].inds010,g_inds_d[g_detail_idx].inds011, 
                  g_inds_d[g_detail_idx].inds014,g_inds_d[g_detail_idx].inds015,g_inds_d[g_detail_idx].inds016, 
                  g_inds_d[g_detail_idx].inds017,g_inds_d[g_detail_idx].inds018,g_inds_d[g_detail_idx].inds019)  
 
         WHERE indsent = g_enterprise AND indsdocno = ps_keys_bak[1] AND indsseq = ps_keys_bak[2] AND indsseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inds_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inds_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint801_inds_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aint801.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint801_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aint801.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint801_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aint801.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint801_lock_b(ps_table,ps_page)
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
   #CALL aint801_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "inds_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint801_bcl USING g_enterprise,
                                       g_indr_m.indrdocno,g_inds_d[g_detail_idx].indsseq,g_inds_d[g_detail_idx].indsseq1  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint801_bcl:",SQLERRMESSAGE 
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
 
{<section id="aint801.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint801_unlock_b(ps_table,ps_page)
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
      CLOSE aint801_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint801_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("indrdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("indrdocno",TRUE)
      CALL cl_set_comp_entry("indrdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("indrsite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("indr002,indr004",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint801_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("indrdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("indrdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("indrdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("indrsite",FALSE)
   END IF 
   
   IF NOT s_aooi500_comp_entry(g_prog,'indrsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("indrsite",FALSE)
   END IF
   
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM inds_t
    WHERE indsent = g_enterprise
      AND indrdocno = g_indr_m.indrdocno
   IF l_cnt > 0 THEN
      CALL cl_set_comp_entry("indr002,indr004",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint801.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint801_set_entry_b(p_cmd)
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
 
{<section id="aint801.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint801_set_no_entry_b(p_cmd)
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
 
{<section id="aint801.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint801_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail,gen_inds,gen_inds2",TRUE)
   CALL cl_set_act_visible("signing,withdraw,confirmed,unconfirmed,invalid",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint801.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint801_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_indr_m.indrstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail,gen_inds,gen_inds2", FALSE)
   END IF
   
   IF cl_null(g_indr_m.indrstus) THEN
      CALL cl_set_act_visible("gen_inds,gen_inds2", FALSE)
   END IF

   #提交和抽單一開始先無條件關   
   CALL cl_set_act_visible("signing,withdraw",FALSE)
   CASE g_indr_m.indrstus
      WHEN 'N'   #未確認
         CALL cl_set_act_visible("unconfirmed",FALSE)
         #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
         IF cl_bpm_chk() THEN
            CALL cl_set_act_visible("signing",TRUE)
            CALL cl_set_act_visible("confirmed",FALSE)
         END IF
      WHEN 'Y'   #已確認
         CALL cl_set_act_visible("confirmed,invalid",FALSE)

      WHEN 'X'   #作廢
         CALL cl_set_act_visible("confirmed,unconfirmed,invalid",FALSE)

      WHEN 'D'   #抽單  #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
         CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

      WHEN 'R'   #已拒絕  #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
         CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

      WHEN 'A'   #已核准  #只能顯示確認; 其餘應用功能皆隱藏
         CALL cl_set_act_visible("confirmed ",TRUE)
         CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      WHEN 'W'   #送簽中  #只能顯示送簽中;其餘應用功能皆隱藏 
         CALL cl_set_act_visible("withdraw",TRUE)
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
   END CASE
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint801.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint801_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint801.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint801_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint801.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint801_default_search()
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
      LET ls_wc = ls_wc, " indrdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "indr_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "inds_t" 
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
 
{<section id="aint801.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint801_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_indr_m.indrstus != 'N' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_indr_m.indrdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint801_cl USING g_enterprise,g_indr_m.indrdocno
   IF STATUS THEN
      CLOSE aint801_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint801_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint801_master_referesh USING g_indr_m.indrdocno INTO g_indr_m.indrsite,g_indr_m.indrdocdt, 
       g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit, 
       g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid,g_indr_m.indrcrtdp, 
       g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfdt, 
       g_indr_m.indrsite_desc,g_indr_m.indr001_desc,g_indr_m.indr002_desc,g_indr_m.indrownid_desc,g_indr_m.indrowndp_desc, 
       g_indr_m.indrcrtid_desc,g_indr_m.indrcrtdp_desc,g_indr_m.indrmodid_desc,g_indr_m.indrcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aint801_action_chk() THEN
      CLOSE aint801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_indr_m.indrsite,g_indr_m.indrsite_desc,g_indr_m.indrdocdt,g_indr_m.indrdocno,g_indr_m.indr001, 
       g_indr_m.indr001_desc,g_indr_m.indr002,g_indr_m.indr002_desc,g_indr_m.indr004,g_indr_m.indr003, 
       g_indr_m.l_cnt_err_money,g_indr_m.indrunit,g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid, 
       g_indr_m.indrownid_desc,g_indr_m.indrowndp,g_indr_m.indrowndp_desc,g_indr_m.indrcrtid,g_indr_m.indrcrtid_desc, 
       g_indr_m.indrcrtdp,g_indr_m.indrcrtdp_desc,g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmodid_desc, 
       g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfid_desc,g_indr_m.indrcnfdt
 
   CASE g_indr_m.indrstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
         CASE g_indr_m.indrstus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
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
      CALL aint801_set_act_visible()
      CALL aint801_set_act_no_visible()
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aint801_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint801_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aint801_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aint801_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
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
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_indr_m.indrstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_init()
   IF lc_state = 'Y' THEN
      CALL s_aint801_conf_chk(g_indr_m.indrdocno,g_indr_m.indrstus) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aint801_conf_upd(g_indr_m.indrdocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL cl_err_collect_show()
               CALL s_transaction_end('Y','0')
               CALL aint801_b_fill()
            END IF
         END IF
      END IF
   END IF
   
   
   IF lc_state = 'X' THEN
      CALL s_aint801_invalid_chk(g_indr_m.indrdocno,g_indr_m.indrstus) RETURNING l_success
      IF NOT l_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aint801_invalid_upd(g_indr_m.indrdocno) RETURNING l_success
            IF NOT l_success THEN
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
   #end add-point
   
   LET g_indr_m.indrmodid = g_user
   LET g_indr_m.indrmoddt = cl_get_current()
   LET g_indr_m.indrstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE indr_t 
      SET (indrstus,indrmodid,indrmoddt) 
        = (g_indr_m.indrstus,g_indr_m.indrmodid,g_indr_m.indrmoddt)     
    WHERE indrent = g_enterprise AND indrdocno = g_indr_m.indrdocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
      EXECUTE aint801_master_referesh USING g_indr_m.indrdocno INTO g_indr_m.indrsite,g_indr_m.indrdocdt, 
          g_indr_m.indrdocno,g_indr_m.indr001,g_indr_m.indr002,g_indr_m.indr004,g_indr_m.indr003,g_indr_m.indrunit, 
          g_indr_m.indr000,g_indr_m.indrstus,g_indr_m.indrownid,g_indr_m.indrowndp,g_indr_m.indrcrtid, 
          g_indr_m.indrcrtdp,g_indr_m.indrcrtdt,g_indr_m.indrmodid,g_indr_m.indrmoddt,g_indr_m.indrcnfid, 
          g_indr_m.indrcnfdt,g_indr_m.indrsite_desc,g_indr_m.indr001_desc,g_indr_m.indr002_desc,g_indr_m.indrownid_desc, 
          g_indr_m.indrowndp_desc,g_indr_m.indrcrtid_desc,g_indr_m.indrcrtdp_desc,g_indr_m.indrmodid_desc, 
          g_indr_m.indrcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_indr_m.indrsite,g_indr_m.indrsite_desc,g_indr_m.indrdocdt,g_indr_m.indrdocno, 
          g_indr_m.indr001,g_indr_m.indr001_desc,g_indr_m.indr002,g_indr_m.indr002_desc,g_indr_m.indr004, 
          g_indr_m.indr003,g_indr_m.l_cnt_err_money,g_indr_m.indrunit,g_indr_m.indr000,g_indr_m.indrstus, 
          g_indr_m.indrownid,g_indr_m.indrownid_desc,g_indr_m.indrowndp,g_indr_m.indrowndp_desc,g_indr_m.indrcrtid, 
          g_indr_m.indrcrtid_desc,g_indr_m.indrcrtdp,g_indr_m.indrcrtdp_desc,g_indr_m.indrcrtdt,g_indr_m.indrmodid, 
          g_indr_m.indrmodid_desc,g_indr_m.indrmoddt,g_indr_m.indrcnfid,g_indr_m.indrcnfid_desc,g_indr_m.indrcnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint801_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint801_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint801.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint801_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_inds_d.getLength() THEN
         LET g_detail_idx = g_inds_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inds_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inds_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint801.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint801_b_fill2(pi_idx)
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
   
   CALL aint801_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint801.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint801_fill_chk(ps_idx)
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
 
{<section id="aint801.status_show" >}
PRIVATE FUNCTION aint801_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint801.mask_functions" >}
&include "erp/ain/aint801_mask.4gl"
 
{</section>}
 
{<section id="aint801.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aint801_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aint801_show()
   CALL aint801_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_indr_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_inds_d))
 
 
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
   #CALL aint801_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aint801_ui_headershow()
   CALL aint801_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aint801_draw_out()
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
   CALL aint801_ui_headershow()  
   CALL aint801_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aint801.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint801_set_pk_array()
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
   LET g_pk_array[1].values = g_indr_m.indrdocno
   LET g_pk_array[1].column = 'indrdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint801.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint801.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint801_msgcentre_notify(lc_state)
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
   CALL aint801_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_indr_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint801.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint801_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#17 -s by 08172
   SELECT indrstus  INTO g_indr_m.indrstus
     FROM indr_t
    WHERE indrent = g_enterprise
      AND indrdocno = g_indr_m.indrdocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_indr_m.indrstus
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
        LET g_errparam.extend = g_indr_m.indrdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aint801_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#17 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint801.other_function" readonly="Y" >}

 
{</section>}
 
