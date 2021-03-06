#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0020(2015-04-08 16:13:39), PR版次:0020(2016-11-01 11:21:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000293
#+ Filename...: aprt200
#+ Description: 促銷活動計劃申請作業
#+ Creator....: 02482(2014-03-04 15:54:12)
#+ Modifier...: 01251 -SD/PR- 06137
 
{</section>}
 
{<section id="aprt200.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...: NO.151125-00001#3    2015/11/27   By Charles4m 增加詢問是否作廢。
#+ Modifier...: NO.160318-00005#40   2016/03/30   By 07900     重复错误讯息修改
#+ Modifier...: NO.160318-00025#32   2016/04/12   By 07959     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#+ Modifier...: NO.160503-00031#1    2016/05/04   by 08172     画面调整
#+ Modify.....: NO.160818-00017#30   2016/08/30   By 08742     删除修改未重新判断状态码
#  Modify.....: NO.160905-00007#12   2016/09/05   by 08742     调整系统中无ENT的SQL条件增加ent
#  Modify.....: NO.160824-00007#135  2016/11/01   By 06137     修正舊值備份寫法
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
PRIVATE type type_g_prca_m        RECORD
       prcasite LIKE prca_t.prcasite, 
   prcasite_desc LIKE type_t.chr80, 
   prcadocdt LIKE prca_t.prcadocdt, 
   prca098 LIKE prca_t.prca098, 
   prcaunit LIKE prca_t.prcaunit, 
   prcaunit_desc LIKE type_t.chr80, 
   prcadocno LIKE prca_t.prcadocno, 
   prca001 LIKE prca_t.prca001, 
   prca002 LIKE prca_t.prca002, 
   prca002_desc LIKE type_t.chr80, 
   prca003 LIKE prca_t.prca003, 
   prca003_desc LIKE type_t.chr80, 
   prcastus LIKE prca_t.prcastus, 
   prcacrtid LIKE prca_t.prcacrtid, 
   prcacrtid_desc LIKE type_t.chr80, 
   prcacrtdp LIKE prca_t.prcacrtdp, 
   prcacrtdp_desc LIKE type_t.chr80, 
   prcacrtdt LIKE prca_t.prcacrtdt, 
   prcaownid LIKE prca_t.prcaownid, 
   prcaownid_desc LIKE type_t.chr80, 
   prcaowndp LIKE prca_t.prcaowndp, 
   prcaowndp_desc LIKE type_t.chr80, 
   prcamodid LIKE prca_t.prcamodid, 
   prcamodid_desc LIKE type_t.chr80, 
   prcamoddt LIKE prca_t.prcamoddt, 
   prcacnfid LIKE prca_t.prcacnfid, 
   prcacnfid_desc LIKE type_t.chr80, 
   prcacnfdt LIKE prca_t.prcacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prcb_d        RECORD
       prcbseq LIKE prcb_t.prcbseq, 
   prcb001 LIKE prcb_t.prcb001, 
   prcbl002 LIKE prcbl_t.prcbl002, 
   prcbl003 LIKE prcbl_t.prcbl003, 
   prcb002 LIKE prcb_t.prcb002, 
   prcb002_desc LIKE type_t.chr500, 
   prcb003 LIKE prcb_t.prcb003, 
   prcb003_desc LIKE type_t.chr500, 
   prcb004 LIKE prcb_t.prcb004, 
   prcb005 LIKE prcb_t.prcb005, 
   prcb007 LIKE prcb_t.prcb007, 
   prcb006 LIKE prcb_t.prcb006, 
   prcbacti LIKE prcb_t.prcbacti, 
   prcbsite LIKE prcb_t.prcbsite, 
   prcbunit LIKE prcb_t.prcbunit
       END RECORD
PRIVATE TYPE type_g_prcb2_d RECORD
       prcc001 LIKE prcc_t.prcc001, 
   prcc002 LIKE prcc_t.prcc002, 
   prcc002_desc LIKE type_t.chr500, 
   prccacti LIKE prcc_t.prccacti, 
   prccsite LIKE prcc_t.prccsite, 
   prccunit LIKE prcc_t.prccunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prcadocno LIKE prca_t.prcadocno,
      b_prca001 LIKE prca_t.prca001,
      b_prca002 LIKE prca_t.prca002,
   b_prca002_desc LIKE type_t.chr80,
      b_prca003 LIKE prca_t.prca003,
   b_prca003_desc LIKE type_t.chr80,
      b_prcadocdt LIKE prca_t.prcadocdt,
      b_prcasite LIKE prca_t.prcasite,
   b_prcasite_desc LIKE type_t.chr80,
      b_prcaunit LIKE prca_t.prcaunit,
   b_prcaunit_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_success             LIKE type_t.num5
DEFINE g_site_flag           LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prca_m          type_g_prca_m
DEFINE g_prca_m_t        type_g_prca_m
DEFINE g_prca_m_o        type_g_prca_m
DEFINE g_prca_m_mask_o   type_g_prca_m #轉換遮罩前資料
DEFINE g_prca_m_mask_n   type_g_prca_m #轉換遮罩後資料
 
   DEFINE g_prcadocno_t LIKE prca_t.prcadocno
 
 
DEFINE g_prcb_d          DYNAMIC ARRAY OF type_g_prcb_d
DEFINE g_prcb_d_t        type_g_prcb_d
DEFINE g_prcb_d_o        type_g_prcb_d
DEFINE g_prcb_d_mask_o   DYNAMIC ARRAY OF type_g_prcb_d #轉換遮罩前資料
DEFINE g_prcb_d_mask_n   DYNAMIC ARRAY OF type_g_prcb_d #轉換遮罩後資料
DEFINE g_prcb2_d          DYNAMIC ARRAY OF type_g_prcb2_d
DEFINE g_prcb2_d_t        type_g_prcb2_d
DEFINE g_prcb2_d_o        type_g_prcb2_d
DEFINE g_prcb2_d_mask_o   DYNAMIC ARRAY OF type_g_prcb2_d #轉換遮罩前資料
DEFINE g_prcb2_d_mask_n   DYNAMIC ARRAY OF type_g_prcb2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_detail_multi_table_t    RECORD
      prcbldocno LIKE prcbl_t.prcbldocno,
      prcblseq LIKE prcbl_t.prcblseq,
      prcbl001 LIKE prcbl_t.prcbl001,
      prcbl002 LIKE prcbl_t.prcbl002,
      prcbl003 LIKE prcbl_t.prcbl003
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
DEFINE g_wc2_table2   STRING
 
 
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
 
{<section id="aprt200.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add                       
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/19 By shiun
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
                                             
   #end add-point
   LET g_forupd_sql = " SELECT prcasite,'',prcadocdt,prca098,prcaunit,'',prcadocno,prca001,prca002,'', 
       prca003,'',prcastus,prcacrtid,'',prcacrtdp,'',prcacrtdt,prcaownid,'',prcaowndp,'',prcamodid,'', 
       prcamoddt,prcacnfid,'',prcacnfdt", 
                      " FROM prca_t",
                      " WHERE prcaent= ? AND prcadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
                                             
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prcasite,t0.prcadocdt,t0.prca098,t0.prcaunit,t0.prcadocno,t0.prca001, 
       t0.prca002,t0.prca003,t0.prcastus,t0.prcacrtid,t0.prcacrtdp,t0.prcacrtdt,t0.prcaownid,t0.prcaowndp, 
       t0.prcamodid,t0.prcamoddt,t0.prcacnfid,t0.prcacnfdt,t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011",
               " FROM prca_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prcasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.prcaunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.prca002  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prca003 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.prcacrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.prcacrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.prcaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.prcaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.prcamodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.prcacnfid  ",
 
               " WHERE t0.prcaent = " ||g_enterprise|| " AND t0.prcadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt200_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                                                                                          
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt200 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt200_init()   
 
      #進入選單 Menu (="N")
      CALL aprt200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                                                                                          
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt200
      
   END IF 
   
   CLOSE aprt200_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add                           
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/19 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt200.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt200_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add                                          
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('prcastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prca001','32') 
   CALL cl_set_combo_scc('prcc001','6560') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add

   CALL cl_set_combo_scc('b_prca001','32')
   IF g_argv[1]='2' THEN
      CALL cl_set_comp_visible("folder_3,bpage2",false) #ken---add bpage2 需求單號：150107-00009 項次：11
      CALL cl_set_comp_visible("lbl_dbegin,lbl_dsep,lbl_dend,idx,cnt",false)
   END IF                                 
   #end add-point
   
   #初始化搜尋條件
   CALL aprt200_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt200.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt200_ui_dialog()
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
            CALL aprt200_insert()
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
         INITIALIZE g_prca_m.* TO NULL
         CALL g_prcb_d.clear()
         CALL g_prcb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt200_init()
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
               
               CALL aprt200_fetch('') # reload data
               LET l_ac = 1
               CALL aprt200_ui_detailshow() #Setting the current row 
         
               CALL aprt200_idx_chk()
               #NEXT FIELD prcbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prcb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt200_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL aprt200_b_fill2('2')
 
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
               CALL aprt200_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                                                                                                                                                                                                                                 
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                                                                                                                                                                    
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_prcb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
                                                                                                                                                                                                                                 
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aprt200_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
                                                                                                                                                                                                                                 
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                                                                                                                                                                                    
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                                                                                                                                       
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aprt200_browser_fill("")
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
               CALL aprt200_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt200_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt200_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                                                                                                                                                                                    
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt200_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt200_set_act_visible()   
            CALL aprt200_set_act_no_visible()
            IF NOT (g_prca_m.prcadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prcaent = " ||g_enterprise|| " AND",
                                  " prcadocno = '", g_prca_m.prcadocno, "' "
 
               #填到對應位置
               CALL aprt200_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prcb_t" 
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
               CALL aprt200_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prcb_t" 
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
                  CALL aprt200_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt200_fetch("F")
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
               CALL aprt200_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt200_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt200_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt200_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt200_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt200_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt200_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt200_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt200_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt200_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt200_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prcb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_prcb2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               NEXT FIELD prcbseq
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
               CALL aprt200_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                                                                                                                                                                                                                 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt200_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                                                                                                                                                                                                                 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt200_delete()
               #add-point:ON ACTION delete name="menu.delete"
                                                                                                                                                                                                                                 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt200_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                                                                                                                                                                                                 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                                                                                                                                                                                                                                 
               #END add-point
               &include "erp/apr/aprt200_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                                                                                                                                                                                                                                 
               #END add-point
               &include "erp/apr/aprt200_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt200_query()
               #add-point:ON ACTION query name="menu.query"
                                                                                                                                                                                                                                 
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt200_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt200_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prca_m.prcadocdt)
 
 
 
         
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
 
{<section id="aprt200.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt200_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING #ken---add 需求單號：141208-00001 項次：22                                         
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   CALL s_aooi500_sql_where(g_prog,'prcasite') RETURNING l_where #ken---add 需求單號：141208-00001 項次：22 
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
      LET l_sub_sql = " SELECT DISTINCT prcadocno ",
                      " FROM prca_t ",
                      " ",
                      " LEFT JOIN prcb_t ON prcbent = prcaent AND prcadocno = prcbdocno ", "  ",
                      #add-point:browser_fill段sql(prcb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN prcc_t ON prccent = prcaent AND prcbdocno = prccdocno AND prcbseq = prccseq", "  ",
                      #add-point:browser_fill段sql(prcc_t1) name="browser_fill.cnt.join.prcc_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " LEFT JOIN prcbl_t ON prcblent = "||g_enterprise||" AND prcadocno = prcbldocno AND prcbseq = prcblseq AND prcbl001 = '",g_dlang,"' ", 
 
                      " ",
 
 
                      " WHERE prcaent = " ||g_enterprise|| " AND prcbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prca_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prcadocno ",
                      " FROM prca_t ", 
                      "  ",
                      "  ",
                      " WHERE prcaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prca_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where #ken---add 需求單號：141208-00001 項次：22
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
      INITIALIZE g_prca_m.* TO NULL
      CALL g_prcb_d.clear()        
      CALL g_prcb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prcadocno,t0.prca001,t0.prca002,t0.prca003,t0.prcadocdt,t0.prcasite,t0.prcaunit Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prcastus,t0.prcadocno,t0.prca001,t0.prca002,t0.prca003,t0.prcadocdt, 
          t0.prcasite,t0.prcaunit,t1.ooag011 ,t2.ooefl003 ,t3.ooefl003 ,t4.ooefl003 ",
                  " FROM prca_t t0",
                  "  ",
                  "  LEFT JOIN prcb_t ON prcbent = prcaent AND prcadocno = prcbdocno ", "  ", 
                  #add-point:browser_fill段sql(prcb_t1) name="browser_fill.join.prcb_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN prcc_t ON prccent = prcaent AND prcbdocno = prccdocno AND prcbseq = prccseq", "  ", 
                  #add-point:browser_fill段sql(prcc_t1) name="browser_fill.join.prcc_t1"
                  
                  #end add-point
 
 
                  " LEFT JOIN prcbl_t ON prcblent = "||g_enterprise||" AND prcadocno = prcbldocno AND prcbseq = prcblseq AND prcbl001 = '",g_dlang,"' ", 
 
                  " ",
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.prca002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.prca003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.prcasite AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prcaunit AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prcaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prca_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prcastus,t0.prcadocno,t0.prca001,t0.prca002,t0.prca003,t0.prcadocdt, 
          t0.prcasite,t0.prcaunit,t1.ooag011 ,t2.ooefl003 ,t3.ooefl003 ,t4.ooefl003 ",
                  " FROM prca_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.prca002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.prca003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.prcasite AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prcaunit AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prcaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prca_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where #ken---add 需求單號：141208-00001 項次：22
   #end add-point
   LET g_sql = g_sql, " ORDER BY prcadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
                                             
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prca_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
                                             
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prcadocno,g_browser[g_cnt].b_prca001, 
          g_browser[g_cnt].b_prca002,g_browser[g_cnt].b_prca003,g_browser[g_cnt].b_prcadocdt,g_browser[g_cnt].b_prcasite, 
          g_browser[g_cnt].b_prcaunit,g_browser[g_cnt].b_prca002_desc,g_browser[g_cnt].b_prca003_desc, 
          g_browser[g_cnt].b_prcasite_desc,g_browser[g_cnt].b_prcaunit_desc
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
         CALL aprt200_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prcadocno) THEN
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
 
{<section id="aprt200.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt200_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
                                             
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prca_m.prcadocno = g_browser[g_current_idx].b_prcadocno   
 
   EXECUTE aprt200_master_referesh USING g_prca_m.prcadocno INTO g_prca_m.prcasite,g_prca_m.prcadocdt, 
       g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003, 
       g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid, 
       g_prca_m.prcaowndp,g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt, 
       g_prca_m.prcasite_desc,g_prca_m.prcaunit_desc,g_prca_m.prca002_desc,g_prca_m.prca003_desc,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp_desc,g_prca_m.prcaownid_desc,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid_desc, 
       g_prca_m.prcacnfid_desc
   
   CALL aprt200_prca_t_mask()
   CALL aprt200_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt200.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt200_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
                                             
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
                                             
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
                                             
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt200_ui_browser_refresh()
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
      IF g_browser[l_i].b_prcadocno = g_prca_m.prcadocno 
 
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
 
{<section id="aprt200.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt200_construct()
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
   INITIALIZE g_prca_m.* TO NULL
   CALL g_prcb_d.clear()        
   CALL g_prcb2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON prcasite,prcadocdt,prca098,prcaunit,prcadocno,prca001,prca002,prca003, 
          prcastus,prcacrtid,prcacrtdp,prcacrtdt,prcaownid,prcaowndp,prcamodid,prcamoddt,prcacnfid,prcacnfdt 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                                                                                                                                                    
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prcacrtdt>>----
         AFTER FIELD prcacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prcamoddt>>----
         AFTER FIELD prcamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prcacnfdt>>----
         AFTER FIELD prcacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prcapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcasite
            #add-point:ON ACTION controlp INFIELD prcasite name="construct.c.prcasite"
         #ken---add---str 需求單號：141208-00001 項次：22                                                                                                                                                                             #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
   			LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcasite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prcasite  #顯示到畫面上

            NEXT FIELD prcasite                     #返回原欄位
          #ken---add---end
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcasite
            #add-point:BEFORE FIELD prcasite name="construct.b.prcasite"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcasite
            
            #add-point:AFTER FIELD prcasite name="construct.a.prcasite"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcadocdt
            #add-point:BEFORE FIELD prcadocdt name="construct.b.prcadocdt"
                                                                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcadocdt
            
            #add-point:AFTER FIELD prcadocdt name="construct.a.prcadocdt"
                                                                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcadocdt
            #add-point:ON ACTION controlp INFIELD prcadocdt name="construct.c.prcadocdt"
                                                                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prca098
            #add-point:BEFORE FIELD prca098 name="construct.b.prca098"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prca098
            
            #add-point:AFTER FIELD prca098 name="construct.a.prca098"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prca098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prca098
            #add-point:ON ACTION controlp INFIELD prca098 name="construct.c.prca098"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prcaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcaunit
            #add-point:ON ACTION controlp INFIELD prcaunit name="construct.c.prcaunit"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcaunit',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prcaunit  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD prcaunit                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcaunit
            #add-point:BEFORE FIELD prcaunit name="construct.b.prcaunit"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcaunit
            
            #add-point:AFTER FIELD prcaunit name="construct.a.prcaunit"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcadocno
            #add-point:ON ACTION controlp INFIELD prcadocno name="construct.c.prcadocno"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "prca098='",g_argv[1],"'"
            CALL q_prcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcadocno  #顯示到畫面上

            NEXT FIELD prcadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcadocno
            #add-point:BEFORE FIELD prcadocno name="construct.b.prcadocno"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcadocno
            
            #add-point:AFTER FIELD prcadocno name="construct.a.prcadocno"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prca001
            #add-point:BEFORE FIELD prca001 name="construct.b.prca001"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prca001
            
            #add-point:AFTER FIELD prca001 name="construct.a.prca001"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prca001
            #add-point:ON ACTION controlp INFIELD prca001 name="construct.c.prca001"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prca002
            #add-point:ON ACTION controlp INFIELD prca002 name="construct.c.prca002"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prca002  #顯示到畫面上

            NEXT FIELD prca002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prca002
            #add-point:BEFORE FIELD prca002 name="construct.b.prca002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prca002
            
            #add-point:AFTER FIELD prca002 name="construct.a.prca002"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prca003
            #add-point:ON ACTION controlp INFIELD prca003 name="construct.c.prca003"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prca003  #顯示到畫面上

            NEXT FIELD prca003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prca003
            #add-point:BEFORE FIELD prca003 name="construct.b.prca003"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prca003
            
            #add-point:AFTER FIELD prca003 name="construct.a.prca003"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcastus
            #add-point:BEFORE FIELD prcastus name="construct.b.prcastus"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcastus
            
            #add-point:AFTER FIELD prcastus name="construct.a.prcastus"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcastus
            #add-point:ON ACTION controlp INFIELD prcastus name="construct.c.prcastus"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prcacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcacrtid
            #add-point:ON ACTION controlp INFIELD prcacrtid name="construct.c.prcacrtid"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcacrtid  #顯示到畫面上

            NEXT FIELD prcacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcacrtid
            #add-point:BEFORE FIELD prcacrtid name="construct.b.prcacrtid"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcacrtid
            
            #add-point:AFTER FIELD prcacrtid name="construct.a.prcacrtid"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcacrtdp
            #add-point:ON ACTION controlp INFIELD prcacrtdp name="construct.c.prcacrtdp"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcacrtdp  #顯示到畫面上

            NEXT FIELD prcacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcacrtdp
            #add-point:BEFORE FIELD prcacrtdp name="construct.b.prcacrtdp"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcacrtdp
            
            #add-point:AFTER FIELD prcacrtdp name="construct.a.prcacrtdp"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcacrtdt
            #add-point:BEFORE FIELD prcacrtdt name="construct.b.prcacrtdt"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prcaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcaownid
            #add-point:ON ACTION controlp INFIELD prcaownid name="construct.c.prcaownid"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcaownid  #顯示到畫面上

            NEXT FIELD prcaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcaownid
            #add-point:BEFORE FIELD prcaownid name="construct.b.prcaownid"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcaownid
            
            #add-point:AFTER FIELD prcaownid name="construct.a.prcaownid"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcaowndp
            #add-point:ON ACTION controlp INFIELD prcaowndp name="construct.c.prcaowndp"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcaowndp  #顯示到畫面上

            NEXT FIELD prcaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcaowndp
            #add-point:BEFORE FIELD prcaowndp name="construct.b.prcaowndp"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcaowndp
            
            #add-point:AFTER FIELD prcaowndp name="construct.a.prcaowndp"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prcamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcamodid
            #add-point:ON ACTION controlp INFIELD prcamodid name="construct.c.prcamodid"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcamodid  #顯示到畫面上

            NEXT FIELD prcamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcamodid
            #add-point:BEFORE FIELD prcamodid name="construct.b.prcamodid"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcamodid
            
            #add-point:AFTER FIELD prcamodid name="construct.a.prcamodid"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcamoddt
            #add-point:BEFORE FIELD prcamoddt name="construct.b.prcamoddt"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prcacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcacnfid
            #add-point:ON ACTION controlp INFIELD prcacnfid name="construct.c.prcacnfid"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcacnfid  #顯示到畫面上

            NEXT FIELD prcacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcacnfid
            #add-point:BEFORE FIELD prcacnfid name="construct.b.prcacnfid"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcacnfid
            
            #add-point:AFTER FIELD prcacnfid name="construct.a.prcacnfid"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcacnfdt
            #add-point:BEFORE FIELD prcacnfdt name="construct.b.prcacnfdt"
                                                                                                                                                                                    
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prcbseq,prcb001,prcbl002,prcbl003,prcb002,prcb003,prcb004,prcb005,prcb007, 
          prcb006,prcbacti,prcbsite,prcbunit
           FROM s_detail1[1].prcbseq,s_detail1[1].prcb001,s_detail1[1].prcbl002,s_detail1[1].prcbl003, 
               s_detail1[1].prcb002,s_detail1[1].prcb003,s_detail1[1].prcb004,s_detail1[1].prcb005,s_detail1[1].prcb007, 
               s_detail1[1].prcb006,s_detail1[1].prcbacti,s_detail1[1].prcbsite,s_detail1[1].prcbunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                                                                                                                                                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbseq
            #add-point:BEFORE FIELD prcbseq name="construct.b.page1.prcbseq"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbseq
            
            #add-point:AFTER FIELD prcbseq name="construct.a.page1.prcbseq"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbseq
            #add-point:ON ACTION controlp INFIELD prcbseq name="construct.c.page1.prcbseq"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prcb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb001
            #add-point:ON ACTION controlp INFIELD prcb001 name="construct.c.page1.prcb001"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "prcbdocno IN (SELECT prcadocno FROM prca_t WHERE prca098='",g_argv[1],"' )"
			   
            CALL q_prcb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcb001  #顯示到畫面上

            NEXT FIELD prcb001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb001
            #add-point:BEFORE FIELD prcb001 name="construct.b.page1.prcb001"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb001
            
            #add-point:AFTER FIELD prcb001 name="construct.a.page1.prcb001"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbl002
            #add-point:BEFORE FIELD prcbl002 name="construct.b.page1.prcbl002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbl002
            
            #add-point:AFTER FIELD prcbl002 name="construct.a.page1.prcbl002"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcbl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbl002
            #add-point:ON ACTION controlp INFIELD prcbl002 name="construct.c.page1.prcbl002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbl003
            #add-point:BEFORE FIELD prcbl003 name="construct.b.page1.prcbl003"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbl003
            
            #add-point:AFTER FIELD prcbl003 name="construct.a.page1.prcbl003"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcbl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbl003
            #add-point:ON ACTION controlp INFIELD prcbl003 name="construct.c.page1.prcbl003"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prcb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb002
            #add-point:ON ACTION controlp INFIELD prcb002 name="construct.c.page1.prcb002"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "2100"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcb002  #顯示到畫面上

            NEXT FIELD prcb002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb002
            #add-point:BEFORE FIELD prcb002 name="construct.b.page1.prcb002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb002
            
            #add-point:AFTER FIELD prcb002 name="construct.a.page1.prcb002"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb003
            #add-point:ON ACTION controlp INFIELD prcb003 name="construct.c.page1.prcb003"
                                                                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "2101"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcb003  #顯示到畫面上

            NEXT FIELD prcb003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb003
            #add-point:BEFORE FIELD prcb003 name="construct.b.page1.prcb003"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb003
            
            #add-point:AFTER FIELD prcb003 name="construct.a.page1.prcb003"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb004
            #add-point:BEFORE FIELD prcb004 name="construct.b.page1.prcb004"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb004
            
            #add-point:AFTER FIELD prcb004 name="construct.a.page1.prcb004"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb004
            #add-point:ON ACTION controlp INFIELD prcb004 name="construct.c.page1.prcb004"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb005
            #add-point:BEFORE FIELD prcb005 name="construct.b.page1.prcb005"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb005
            
            #add-point:AFTER FIELD prcb005 name="construct.a.page1.prcb005"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb005
            #add-point:ON ACTION controlp INFIELD prcb005 name="construct.c.page1.prcb005"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb007
            #add-point:BEFORE FIELD prcb007 name="construct.b.page1.prcb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb007
            
            #add-point:AFTER FIELD prcb007 name="construct.a.page1.prcb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb007
            #add-point:ON ACTION controlp INFIELD prcb007 name="construct.c.page1.prcb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb006
            #add-point:BEFORE FIELD prcb006 name="construct.b.page1.prcb006"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb006
            
            #add-point:AFTER FIELD prcb006 name="construct.a.page1.prcb006"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb006
            #add-point:ON ACTION controlp INFIELD prcb006 name="construct.c.page1.prcb006"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbacti
            #add-point:BEFORE FIELD prcbacti name="construct.b.page1.prcbacti"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbacti
            
            #add-point:AFTER FIELD prcbacti name="construct.a.page1.prcbacti"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcbacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbacti
            #add-point:ON ACTION controlp INFIELD prcbacti name="construct.c.page1.prcbacti"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbsite
            #add-point:BEFORE FIELD prcbsite name="construct.b.page1.prcbsite"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbsite
            
            #add-point:AFTER FIELD prcbsite name="construct.a.page1.prcbsite"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbsite
            #add-point:ON ACTION controlp INFIELD prcbsite name="construct.c.page1.prcbsite"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbunit
            #add-point:BEFORE FIELD prcbunit name="construct.b.page1.prcbunit"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbunit
            
            #add-point:AFTER FIELD prcbunit name="construct.a.page1.prcbunit"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prcbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbunit
            #add-point:ON ACTION controlp INFIELD prcbunit name="construct.c.page1.prcbunit"
                                                                                                                                                                                    
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON prcc001,prcc002,prccacti,prccsite,prccunit
           FROM s_detail2[1].prcc001,s_detail2[1].prcc002,s_detail2[1].prccacti,s_detail2[1].prccsite, 
               s_detail2[1].prccunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
                                                                                                                                                                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcc001
            #add-point:BEFORE FIELD prcc001 name="construct.b.page2.prcc001"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcc001
            
            #add-point:AFTER FIELD prcc001 name="construct.a.page2.prcc001"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcc001
            #add-point:ON ACTION controlp INFIELD prcc001 name="construct.c.page2.prcc001"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page2.prcc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcc002
            #add-point:ON ACTION controlp INFIELD prcc002 name="construct.c.page2.prcc002"
                                                                                                                        #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "prccdocno IN (SELECT prcadocno FROM prca_t WHERE prca098='",g_argv[1],"' )"
            CALL q_prcc002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO prcc002  #顯示到畫面上

            NEXT FIELD prcc002                     #返回原欄位                                         
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcc002
            #add-point:BEFORE FIELD prcc002 name="construct.b.page2.prcc002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcc002
            
            #add-point:AFTER FIELD prcc002 name="construct.a.page2.prcc002"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prccacti
            #add-point:BEFORE FIELD prccacti name="construct.b.page2.prccacti"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prccacti
            
            #add-point:AFTER FIELD prccacti name="construct.a.page2.prccacti"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prccacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prccacti
            #add-point:ON ACTION controlp INFIELD prccacti name="construct.c.page2.prccacti"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prccsite
            #add-point:BEFORE FIELD prccsite name="construct.b.page2.prccsite"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prccsite
            
            #add-point:AFTER FIELD prccsite name="construct.a.page2.prccsite"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prccsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prccsite
            #add-point:ON ACTION controlp INFIELD prccsite name="construct.c.page2.prccsite"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prccunit
            #add-point:BEFORE FIELD prccunit name="construct.b.page2.prccunit"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prccunit
            
            #add-point:AFTER FIELD prccunit name="construct.a.page2.prccunit"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prccunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prccunit
            #add-point:ON ACTION controlp INFIELD prccunit name="construct.c.page2.prccunit"
                                                                                                                                                                                    
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
                  WHEN la_wc[li_idx].tableid = "prca_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prcb_t" 
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
 
 
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   IF cl_null(g_wc) THEN  #qiaozy
      LET g_wc =" 1=1"
   END IF   
   LET g_wc=g_wc," AND prca098='",g_argv[1],"' "
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt200_filter()
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
      CONSTRUCT g_wc_filter ON prcadocno,prca001,prca002,prca003,prcadocdt,prcasite,prcaunit
                          FROM s_browse[1].b_prcadocno,s_browse[1].b_prca001,s_browse[1].b_prca002,s_browse[1].b_prca003, 
                              s_browse[1].b_prcadocdt,s_browse[1].b_prcasite,s_browse[1].b_prcaunit
 
         BEFORE CONSTRUCT
               DISPLAY aprt200_filter_parser('prcadocno') TO s_browse[1].b_prcadocno
            DISPLAY aprt200_filter_parser('prca001') TO s_browse[1].b_prca001
            DISPLAY aprt200_filter_parser('prca002') TO s_browse[1].b_prca002
            DISPLAY aprt200_filter_parser('prca003') TO s_browse[1].b_prca003
            DISPLAY aprt200_filter_parser('prcadocdt') TO s_browse[1].b_prcadocdt
            DISPLAY aprt200_filter_parser('prcasite') TO s_browse[1].b_prcasite
            DISPLAY aprt200_filter_parser('prcaunit') TO s_browse[1].b_prcaunit
      
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
 
      CALL aprt200_filter_show('prcadocno')
   CALL aprt200_filter_show('prca001')
   CALL aprt200_filter_show('prca002')
   CALL aprt200_filter_show('prca003')
   CALL aprt200_filter_show('prcadocdt')
   CALL aprt200_filter_show('prcasite')
   CALL aprt200_filter_show('prcaunit')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt200_filter_parser(ps_field)
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
 
{<section id="aprt200.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt200_filter_show(ps_field)
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
   LET ls_condition = aprt200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt200_query()
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
   CALL g_prcb_d.clear()
   CALL g_prcb2_d.clear()
 
   
   #add-point:query段other name="query.other"
                                             
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt200_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt200_browser_fill("")
      CALL aprt200_fetch("")
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
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aprt200_filter_show('prcadocno')
   CALL aprt200_filter_show('prca001')
   CALL aprt200_filter_show('prca002')
   CALL aprt200_filter_show('prca003')
   CALL aprt200_filter_show('prcadocdt')
   CALL aprt200_filter_show('prcasite')
   CALL aprt200_filter_show('prcaunit')
   CALL aprt200_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt200_fetch("F") 
      #顯示單身筆數
      CALL aprt200_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt200_fetch(p_flag)
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
   CALL g_prcb2_d.clear()
 
   
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
   
   LET g_prca_m.prcadocno = g_browser[g_current_idx].b_prcadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt200_master_referesh USING g_prca_m.prcadocno INTO g_prca_m.prcasite,g_prca_m.prcadocdt, 
       g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003, 
       g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid, 
       g_prca_m.prcaowndp,g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt, 
       g_prca_m.prcasite_desc,g_prca_m.prcaunit_desc,g_prca_m.prca002_desc,g_prca_m.prca003_desc,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp_desc,g_prca_m.prcaownid_desc,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid_desc, 
       g_prca_m.prcacnfid_desc
   
   #遮罩相關處理
   LET g_prca_m_mask_o.* =  g_prca_m.*
   CALL aprt200_prca_t_mask()
   LET g_prca_m_mask_n.* =  g_prca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt200_set_act_visible()   
   CALL aprt200_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
            IF g_prca_m.prcastus = 'N' THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
   ELSE
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   END IF 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
                                             
   #end add-point
   
   #保存單頭舊值
   LET g_prca_m_t.* = g_prca_m.*
   LET g_prca_m_o.* = g_prca_m.*
   
   LET g_data_owner = g_prca_m.prcaownid      
   LET g_data_dept  = g_prca_m.prcaowndp
   
   #重新顯示   
   CALL aprt200_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt200_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004   
   DEFINE l_insert      LIKE type_t.num5   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prcb_d.clear()   
   CALL g_prcb2_d.clear()  
 
 
   INITIALIZE g_prca_m.* TO NULL             #DEFAULT 設定
   
   LET g_prcadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prca_m.prcaownid = g_user
      LET g_prca_m.prcaowndp = g_dept
      LET g_prca_m.prcacrtid = g_user
      LET g_prca_m.prcacrtdp = g_dept 
      LET g_prca_m.prcacrtdt = cl_get_current()
      LET g_prca_m.prcamodid = g_user
      LET g_prca_m.prcamoddt = cl_get_current()
      LET g_prca_m.prcastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prca_m.prca001 = "I"
      LET g_prca_m.prcastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
#      LET g_prca_m.prcaunit = g_site
      LET g_site_flag = FALSE
      #CALL s_aooi500_default(g_prog,'prcaunit',g_prca_m.prcasite)
      #   RETURNING l_insert,g_prca_m.prcaunit
      #IF NOT l_insert THEN
      #   RETURN
      #END IF
      #LET g_prca_m.prcasite = g_prca_m.prcaunit
      #ken---add---str 需求單號：141208-00001 項次：22
      CALL s_aooi500_default(g_prog,'prcasite',g_prca_m.prcasite)
         RETURNING l_insert,g_prca_m.prcasite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prca_m.prcaunit = g_prca_m.prcasite    
      #ken---add---end
      LET g_prca_m.prcadocdt = g_today
      LET g_prca_m.prca098 = g_argv[1]  #qiaozy
      LET g_prca_m.prca002 = g_user
      LET g_prca_m.prca003 = g_dept
      
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prca_m.prcasite,g_prog,'1') #ken---add---str
      #CALL s_arti200_get_def_doc_type(g_prca_m.prcaunit,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prca_m.prcadocno = r_doctype
      #dongsz--add--end---
      
      CALL aprt200_desc()
      LET g_site_flag = FALSE         #sakura add
      LET g_prca_m_o.* = g_prca_m.* #sakura add
      LET g_prca_m_t.* = g_prca_m.* #sakura add        
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prca_m_t.* = g_prca_m.*
      LET g_prca_m_o.* = g_prca_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prca_m.prcastus 
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
 
 
 
    
      CALL aprt200_input("a")
      
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
         INITIALIZE g_prca_m.* TO NULL
         INITIALIZE g_prcb_d TO NULL
         INITIALIZE g_prcb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt200_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prcb_d.clear()
      #CALL g_prcb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt200_set_act_visible()   
   CALL aprt200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prcadocno_t = g_prca_m.prcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prcaent = " ||g_enterprise|| " AND",
                      " prcadocno = '", g_prca_m.prcadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt200_cl
   
   CALL aprt200_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt200_master_referesh USING g_prca_m.prcadocno INTO g_prca_m.prcasite,g_prca_m.prcadocdt, 
       g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003, 
       g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid, 
       g_prca_m.prcaowndp,g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt, 
       g_prca_m.prcasite_desc,g_prca_m.prcaunit_desc,g_prca_m.prca002_desc,g_prca_m.prca003_desc,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp_desc,g_prca_m.prcaownid_desc,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid_desc, 
       g_prca_m.prcacnfid_desc
   
   
   #遮罩相關處理
   LET g_prca_m_mask_o.* =  g_prca_m.*
   CALL aprt200_prca_t_mask()
   LET g_prca_m_mask_n.* =  g_prca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit, 
       g_prca_m.prcaunit_desc,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca002_desc, 
       g_prca_m.prca003,g_prca_m.prca003_desc,g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp,g_prca_m.prcacrtdp_desc,g_prca_m.prcacrtdt,g_prca_m.prcaownid,g_prca_m.prcaownid_desc, 
       g_prca_m.prcaowndp,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid,g_prca_m.prcamodid_desc,g_prca_m.prcamoddt, 
       g_prca_m.prcacnfid,g_prca_m.prcacnfid_desc,g_prca_m.prcacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prca_m.prcaownid      
   LET g_data_dept  = g_prca_m.prcaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt200_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt200_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
   DEFINE l_wc2_table2   STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
                                             
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prca_m_t.* = g_prca_m.*
   LET g_prca_m_o.* = g_prca_m.*
   
   IF g_prca_m.prcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prcadocno_t = g_prca_m.prcadocno
 
   CALL s_transaction_begin()
   
   OPEN aprt200_cl USING g_enterprise,g_prca_m.prcadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt200_master_referesh USING g_prca_m.prcadocno INTO g_prca_m.prcasite,g_prca_m.prcadocdt, 
       g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003, 
       g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid, 
       g_prca_m.prcaowndp,g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt, 
       g_prca_m.prcasite_desc,g_prca_m.prcaunit_desc,g_prca_m.prca002_desc,g_prca_m.prca003_desc,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp_desc,g_prca_m.prcaownid_desc,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid_desc, 
       g_prca_m.prcacnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prca_m_mask_o.* =  g_prca_m.*
   CALL aprt200_prca_t_mask()
   LET g_prca_m_mask_n.* =  g_prca_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL aprt200_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_prcadocno_t = g_prca_m.prcadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prca_m.prcamodid = g_user 
LET g_prca_m.prcamoddt = cl_get_current()
LET g_prca_m.prcamodid_desc = cl_get_username(g_prca_m.prcamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_prca_m.prcastus MATCHES "[DR]" THEN
         LET g_prca_m.prcastus = "N"
      END IF                                                                                     
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt200_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                                                                                          
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prca_t SET (prcamodid,prcamoddt) = (g_prca_m.prcamodid,g_prca_m.prcamoddt)
          WHERE prcaent = g_enterprise AND prcadocno = g_prcadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prca_m.* = g_prca_m_t.*
            CALL aprt200_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prca_m.prcadocno != g_prca_m_t.prcadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                                                                                                                       
         #end add-point
         
         #更新單身key值
         UPDATE prcb_t SET prcbdocno = g_prca_m.prcadocno
 
          WHERE prcbent = g_enterprise AND prcbdocno = g_prca_m_t.prcadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                                                                                                                       
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prcb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prcb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
                                                                                                                                       
         #end add-point
         
 
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
                                                                                                                                       
         #end add-point
         UPDATE prcc_t
            SET prccdocno = g_prca_m.prcadocno
 
          WHERE prccent = g_enterprise AND
                prccdocno = g_prcadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                                                                                                                                       
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prcc_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
                                                                                                                                       
         #end add-point
 
 
         
         #UPDATE 多語言table key值
         LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'prcblent'
LET l_new_key[02] = g_prca_m.prcadocno
LET l_old_key[02] = g_prcadocno_t
LET l_field_key[02] = 'prcbldocno'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'prcbl_t')
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt200_set_act_visible()   
   CALL aprt200_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prcaent = " ||g_enterprise|| " AND",
                      " prcadocno = '", g_prca_m.prcadocno, "' "
 
   #填到對應位置
   CALL aprt200_browser_fill("")
 
   CLOSE aprt200_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt200_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt200.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt200_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_prcb001             LIKE prcb_t.prcb001
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_time                DATETIME YEAR TO SECOND
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   #150402-00005#6--add by dongsz--str---
   DEFINE  l_ooef008             LIKE ooef_t.ooef008
   DEFINE  l_ooef010             LIKE ooef_t.ooef010
   DEFINE  r_flag                LIKE type_t.chr1
   DEFINE  r_errno               LIKE type_t.chr100
   DEFINE  r_oogc015             LIKE oogc_t.oogc015
   DEFINE  r_oogc007             LIKE oogc_t.oogc007
   DEFINE  r_sdate_s             LIKE oogc_t.oogc003
   DEFINE  r_sdate_e             LIKE oogc_t.oogc003
   DEFINE  r_oogc006             LIKE oogc_t.oogc006
   DEFINE  r_pdate_s             LIKE oogc_t.oogc003
   DEFINE  r_pdate_e             LIKE oogc_t.oogc003
   DEFINE  r_oogc008             LIKE oogc_t.oogc008
   DEFINE  r_wdate_s             LIKE oogc_t.oogc003
   DEFINE  r_wdate_e             LIKE oogc_t.oogc003
   #150402-00005#6--add by dongsz--end---
   #add--2015/07/02 By shiun--(E)
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD    #15/06/09 Sarah add
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #add--2015/07/02 By shiun--(E)
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
   DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit, 
       g_prca_m.prcaunit_desc,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca002_desc, 
       g_prca_m.prca003,g_prca_m.prca003_desc,g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp,g_prca_m.prcacrtdp_desc,g_prca_m.prcacrtdt,g_prca_m.prcaownid,g_prca_m.prcaownid_desc, 
       g_prca_m.prcaowndp,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid,g_prca_m.prcamodid_desc,g_prca_m.prcamoddt, 
       g_prca_m.prcacnfid,g_prca_m.prcacnfid_desc,g_prca_m.prcacnfdt
   
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
   LET g_forupd_sql = "SELECT prcbseq,prcb001,prcb002,prcb003,prcb004,prcb005,prcb007,prcb006,prcbacti, 
       prcbsite,prcbunit FROM prcb_t WHERE prcbent=? AND prcbdocno=? AND prcbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
                                             
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt200_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
                                             
   #end add-point 
   LET g_forupd_sql = "SELECT prcc001,prcc002,prccacti,prccsite,prccunit FROM prcc_t WHERE prccent=?  
       AND prccdocno=? AND prccseq=? AND prcc001=? AND prcc002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
                                             
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt200_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
                                             
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt200_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
                                 LET g_errshow = 1             
   #end add-point
   CALL aprt200_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno, 
       g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003,g_prca_m.prcastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
                                             
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt200.input.head" >}
      #單頭段
      INPUT BY NAME g_prca_m.prcasite,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno, 
          g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003,g_prca_m.prcastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt200_cl USING g_enterprise,g_prca_m.prcadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt200_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #ken---add---str 需求單號：141208-00001 項次：22
            CALL aprt200_set_entry(p_cmd)
            CALL aprt200_set_no_entry(p_cmd)           
            #ken---add---end
            #end add-point
            CALL aprt200_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcasite
            
            #add-point:AFTER FIELD prcasite name="input.a.prcasite"
            #ken---add---str 需求單號：141208-00001 項次：22
            IF NOT cl_null(g_prca_m.prcasite) THEN
               CALL s_aooi500_chk(g_prog,'prcasite',g_prca_m.prcasite,g_prca_m.prcasite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prca_m.prcasite = g_prca_m_t.prcasite
                  CALL s_desc_get_department_desc(g_prca_m.prcasite)
                     RETURNING g_prca_m.prcasite_desc
                  DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc
                  NEXT FIELD CURRENT
               END IF
            #sakura---add---str
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()            
               
               LET g_prca_m.prcasite = g_prca_m_t.prcasite
               CALL s_desc_get_department_desc(g_prca_m.prcasite)
                  RETURNING g_prca_m.prcasite_desc
               DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc
               NEXT FIELD CURRENT            
            #sakura---add---end
            END IF              
            LET g_site_flag = TRUE           
            CALL s_desc_get_department_desc(g_prca_m.prcasite)
               RETURNING g_prca_m.prcasite_desc
            DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc               
            CALL aprt200_set_entry(p_cmd)
            CALL aprt200_set_no_entry(p_cmd)            
            #ken---add---end
            
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_prca_m.prcasite
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_prca_m.prcasite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_prca_m.prcasite_desc                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcasite
            #add-point:BEFORE FIELD prcasite name="input.b.prcasite"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcasite
            #add-point:ON CHANGE prcasite name="input.g.prcasite"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcadocdt
            #add-point:BEFORE FIELD prcadocdt name="input.b.prcadocdt"
                                                                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcadocdt
            
            #add-point:AFTER FIELD prcadocdt name="input.a.prcadocdt"
                                                                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcadocdt
            #add-point:ON CHANGE prcadocdt name="input.g.prcadocdt"
                                                                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prca098
            #add-point:BEFORE FIELD prca098 name="input.b.prca098"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prca098
            
            #add-point:AFTER FIELD prca098 name="input.a.prca098"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prca098
            #add-point:ON CHANGE prca098 name="input.g.prca098"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcaunit
            
            #add-point:AFTER FIELD prcaunit name="input.a.prcaunit"
          # IF NOT cl_null(g_prca_m.prcaunit) THEN
          #    CALL s_aooi500_chk(g_prog,'prcaunit',g_prca_m.prcaunit,g_prca_m.prcasite)
          #       RETURNING l_success,l_errno
          #    IF NOT l_success THEN
          #       INITIALIZE g_errparam TO NULL
          #       LET g_errparam.extend = ''
          #       LET g_errparam.code   = l_errno
          #       LET g_errparam.popup  = TRUE
          #       CALL cl_err()
          #
          #       LET g_prca_m.prcaunit = g_prca_m_t.prcaunit
          #       CALL s_desc_get_department_desc(g_prca_m.prcaunit)
          #          RETURNING g_prca_m.prcaunit_desc
          #       DISPLAY BY NAME g_prca_m.prcaunit,g_prca_m.prcaunit_desc
          #       NEXT FIELD CURRENT
          #    END IF
          #
          #    LET g_site_flag = TRUE
          #    CALL aprt200_set_entry(p_cmd)
          #    CALL aprt200_set_no_entry(p_cmd)
          # END IF              
          #   
          # INITIALIZE g_ref_fields TO NULL
          # LET g_ref_fields[1] = g_prca_m.prcaunit
          # CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
          # LET g_prca_m.prcaunit_desc = '', g_rtn_fields[1] , ''
          # DISPLAY BY NAME g_prca_m.prcaunit_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcaunit
            #add-point:BEFORE FIELD prcaunit name="input.b.prcaunit"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcaunit
            #add-point:ON CHANGE prcaunit name="input.g.prcaunit"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcadocno
            #add-point:BEFORE FIELD prcadocno name="input.b.prcadocno"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcadocno
            
            #add-point:AFTER FIELD prcadocno name="input.a.prcadocno"
                                                                                                                                                                                                #此段落由子樣板a05產生
            IF NOT cl_null(g_prca_m.prcadocno) THEN 
               LET l_ooef004 = ""
               SELECT ooef004 INTO l_ooef004
                 FROM ooef_t
                WHERE ooef001 = g_site
                  AND ooefent = g_enterprise
              #CALL s_aooi200_chk_docno(g_site,g_prca_m.prcadocno,g_prca_m.prcadocdt,g_prog) RETURNING l_success #sakura mark
               CALL s_aooi200_chk_docno(g_prca_m.prcasite,g_prca_m.prcadocno,g_prca_m.prcadocdt,g_prog) RETURNING l_success #sakura add
               IF NOT l_success THEN
                  LET g_prca_m.prcadocno = g_prcadocno_t
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prca_m.prcadocno != g_prcadocno_t )) THEN 
                  IF NOT ap_chk_notDup(g_prca_m.prcadocno,"SELECT COUNT(*) FROM prca_t WHERE "||"prcaent = '" ||g_enterprise|| "' AND "||"prcadocno = '"||g_prca_m.prcadocno ||"'",'std-00004',1) THEN 
                     LET g_prca_m.prcadocno = g_prcadocno_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcadocno
            #add-point:ON CHANGE prcadocno name="input.g.prcadocno"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prca001
            #add-point:BEFORE FIELD prca001 name="input.b.prca001"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prca001
            
            #add-point:AFTER FIELD prca001 name="input.a.prca001"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prca001
            #add-point:ON CHANGE prca001 name="input.g.prca001"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prca002
            
            #add-point:AFTER FIELD prca002 name="input.a.prca002"
                                                                                                                                                            CALL aprt200_desc()                    
            IF NOT cl_null(g_prca_m.prca002) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prca_m.prca002
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_prca_m.prca002 = g_prca_m_t.prca002
                  CALL aprt200_desc()
                  NEXT FIELD CURRENT
               END IF
               SELECT ooag003 INTO g_prca_m.prca003
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_prca_m.prca002
            END IF
            CALL aprt200_desc()            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prca002
            #add-point:BEFORE FIELD prca002 name="input.b.prca002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prca002
            #add-point:ON CHANGE prca002 name="input.g.prca002"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prca003
            
            #add-point:AFTER FIELD prca003 name="input.a.prca003"
                                                                                                                                                            CALL aprt200_desc()                      
            IF NOT cl_null(g_prca_m.prca003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prca_m.prca003
               LET g_chkparam.arg2 = g_prca_m.prcadocdt
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_prca_m.prca003 = g_prca_m_t.prca003
                  CALL aprt200_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prca003
            #add-point:BEFORE FIELD prca003 name="input.b.prca003"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prca003
            #add-point:ON CHANGE prca003 name="input.g.prca003"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcastus
            #add-point:BEFORE FIELD prcastus name="input.b.prcastus"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcastus
            
            #add-point:AFTER FIELD prcastus name="input.a.prcastus"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcastus
            #add-point:ON CHANGE prcastus name="input.g.prcastus"
                                                                                                                                                                                    
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcasite
            #add-point:ON ACTION controlp INFIELD prcasite name="input.c.prcasite"
            #ken---add---str 需求單號：141208-00001 項次：22
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prca_m.prcasite           #給予default值

            #給予arg

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcasite',g_prca_m.prcasite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_prca_m.prcasite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prca_m.prcasite TO prcasite              #顯示到畫面上
            
            CALL s_desc_get_department_desc(g_prca_m.prcasite)
               RETURNING g_prca_m.prcasite_desc
            DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc
            
            NEXT FIELD prcasite 
            #ken---add---end            
            #END add-point
 
 
         #Ctrlp:input.c.prcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcadocdt
            #add-point:ON ACTION controlp INFIELD prcadocdt name="input.c.prcadocdt"
                                                                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.prca098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prca098
            #add-point:ON ACTION controlp INFIELD prca098 name="input.c.prca098"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prcaunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcaunit
            #add-point:ON ACTION controlp INFIELD prcaunit name="input.c.prcaunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prca_m.prcaunit           #給予default值

            #給予arg

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcaunit',g_prca_m.prcasite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_prca_m.prcaunit = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prca_m.prcaunit TO prcaunit              #顯示到畫面上
            CALL aprt200_desc()
            NEXT FIELD prcaunit                                                                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.prcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcadocno
            #add-point:ON ACTION controlp INFIELD prcadocno name="input.c.prcadocno"
                                                                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prca_m.prcadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #參照表編號
            LET g_qryparam.arg2 = g_prog #作业代号

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prca_m.prcadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prca_m.prcadocno TO prcadocno              #顯示到畫面上

            NEXT FIELD prcadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prca001
            #add-point:ON ACTION controlp INFIELD prca001 name="input.c.prca001"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prca002
            #add-point:ON ACTION controlp INFIELD prca002 name="input.c.prca002"
                                                                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prca_m.prca002             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_prca_m.prca002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prca_m.prca002 TO prca002              #顯示到畫面上
            CALL aprt200_desc()
            NEXT FIELD prca002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prca003
            #add-point:ON ACTION controlp INFIELD prca003 name="input.c.prca003"
                                                                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prca_m.prca003             #給予default值

            #給予arg
            IF NOT cl_null(g_prca_m.prcadocdt) THEN
               LET g_qryparam.arg1 = g_prca_m.prcadocdt
            END IF

            CALL q_ooeg001()                                #呼叫開窗

            LET g_prca_m.prca003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prca_m.prca003 TO prca003              #顯示到畫面上
            CALL aprt200_desc()
            NEXT FIELD prca003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcastus
            #add-point:ON ACTION controlp INFIELD prcastus name="input.c.prcastus"
                                                                                                                                                                                    
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prca_m.prcadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
              #CALL s_aooi200_gen_docno(g_site,g_prca_m.prcadocno,g_prca_m.prcadocdt,g_prog) RETURNING l_success,g_prca_m.prcadocno #sakura mark
               CALL s_aooi200_gen_docno(g_prca_m.prcasite,g_prca_m.prcadocno,g_prca_m.prcadocdt,g_prog) RETURNING l_success,g_prca_m.prcadocno #sakura add
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_prca_m.prcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD prcadocno
               END IF    
               LET g_prca_m.prcaunit = g_prca_m.prcasite #ken---add 需求單號：141208-00001 項次：22
               #end add-point
               
               INSERT INTO prca_t (prcaent,prcasite,prcadocdt,prca098,prcaunit,prcadocno,prca001,prca002, 
                   prca003,prcastus,prcacrtid,prcacrtdp,prcacrtdt,prcaownid,prcaowndp,prcamodid,prcamoddt, 
                   prcacnfid,prcacnfdt)
               VALUES (g_enterprise,g_prca_m.prcasite,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit, 
                   g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003,g_prca_m.prcastus, 
                   g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid,g_prca_m.prcaowndp, 
                   g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prca_m:",SQLERRMESSAGE 
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
                  CALL aprt200_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt200_b_fill()
                  CALL aprt200_b_fill2('0')
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
               CALL aprt200_prca_t_mask_restore('restore_mask_o')
               
               UPDATE prca_t SET (prcasite,prcadocdt,prca098,prcaunit,prcadocno,prca001,prca002,prca003, 
                   prcastus,prcacrtid,prcacrtdp,prcacrtdt,prcaownid,prcaowndp,prcamodid,prcamoddt,prcacnfid, 
                   prcacnfdt) = (g_prca_m.prcasite,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit, 
                   g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003,g_prca_m.prcastus, 
                   g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid,g_prca_m.prcaowndp, 
                   g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt)
                WHERE prcaent = g_enterprise AND prcadocno = g_prcadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prca_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                                                                                                                                                                                                                                 
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aprt200_prca_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prca_m_t)
               LET g_log2 = util.JSON.stringify(g_prca_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                                                                                                                                                                                                 
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prcadocno_t = g_prca_m.prcadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt200.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prcb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page1.update_item"
                                                                                                            IF NOT cl_null(g_prca_m.prcadocno)  THEN
               CALL n_prcbl(g_prca_m.prcadocno,g_prcb_d[l_ac].prcbseq)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prca_m.prcadocno
               LET g_ref_fields[2] = g_prcb_d[l_ac].prcbseq
               CALL ap_ref_array2(g_ref_fields," SELECT prcbl002,prcbl003 FROM prcbl_t WHERE prcblent = '"
                   ||g_enterprise||"' AND prcbldocno = ? AND prcblseq = ? AND prcbl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prcb_d[l_ac].prcbl002 = g_rtn_fields[1]
               LET g_prcb_d[l_ac].prcbl003 = g_rtn_fields[2]
               DISPLAY BY NAME g_prcb_d[l_ac].prcbl002
               DISPLAY BY NAME g_prcb_d[l_ac].prcbl003
            END IF                                                                        
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prcb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prcb_d.getLength()
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
            CALL aprt200_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprt200_cl USING g_enterprise,g_prca_m.prcadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prcb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prcb_d[l_ac].prcbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prcb_d_t.* = g_prcb_d[l_ac].*  #BACKUP
               LET g_prcb_d_o.* = g_prcb_d[l_ac].*  #BACKUP
               CALL aprt200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                                                                                                                                                                                                                 
               #end add-point  
               CALL aprt200_set_no_entry_b(l_cmd)
               IF NOT aprt200_lock_b("prcb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt200_bcl INTO g_prcb_d[l_ac].prcbseq,g_prcb_d[l_ac].prcb001,g_prcb_d[l_ac].prcb002, 
                      g_prcb_d[l_ac].prcb003,g_prcb_d[l_ac].prcb004,g_prcb_d[l_ac].prcb005,g_prcb_d[l_ac].prcb007, 
                      g_prcb_d[l_ac].prcb006,g_prcb_d[l_ac].prcbacti,g_prcb_d[l_ac].prcbsite,g_prcb_d[l_ac].prcbunit 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prcb_d_t.prcbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prcb_d_mask_o[l_ac].* =  g_prcb_d[l_ac].*
                  CALL aprt200_prcb_t_mask()
                  LET g_prcb_d_mask_n[l_ac].* =  g_prcb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
                                                                                                                                                                                    
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
LET g_detail_multi_table_t.prcbldocno = g_prca_m.prcadocno
LET g_detail_multi_table_t.prcblseq = g_prcb_d[l_ac].prcbseq
LET g_detail_multi_table_t.prcbl001 = g_dlang
LET g_detail_multi_table_t.prcbl002 = g_prcb_d[l_ac].prcbl002
LET g_detail_multi_table_t.prcbl003 = g_prcb_d[l_ac].prcbl003
 
            #其他table進行lock
            
            INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'prcblent'
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[02] = 'prcbldocno'
            LET l_var_keys[02] = g_prca_m.prcadocno
            LET l_field_keys[03] = 'prcblseq'
            LET l_var_keys[03] = g_prcb_d[l_ac].prcbseq
            LET l_field_keys[04] = 'prcbl001'
            LET l_var_keys[04] = g_dlang
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'prcbl_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prcb_d[l_ac].* TO NULL 
            INITIALIZE g_prcb_d_t.* TO NULL 
            INITIALIZE g_prcb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prcb_d[l_ac].prcb007 = "0"
      LET g_prcb_d[l_ac].prcb006 = "N"
      LET g_prcb_d[l_ac].prcbacti = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prcb_d_t.* = g_prcb_d[l_ac].*     #新輸入資料
            LET g_prcb_d_o.* = g_prcb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                                                                    SELECT MAX(prcbseq) +1 INTO g_prcb_d[l_ac].prcbseq 
              FROM prcb_t
             WHERE prcbent = g_enterprise
               AND prcbdocno = g_prca_m.prcadocno   
            IF cl_null(g_prcb_d[l_ac].prcbseq) THEN     
               LET g_prcb_d[l_ac].prcbseq = 1
            END IF
            LET g_prcb_d[l_ac].prcbunit = g_site
            LET g_prcb_d[l_ac].prcbsite = g_site
            LET g_prcb_d[l_ac].prcb006 = "Y"
               
            #end add-point
            CALL aprt200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prcb_d[li_reproduce_target].* = g_prcb_d[li_reproduce].*
 
               LET g_prcb_d[li_reproduce_target].prcbseq = NULL
 
            END IF
            
LET g_detail_multi_table_t.prcbldocno = g_prca_m.prcadocno
LET g_detail_multi_table_t.prcblseq = g_prcb_d[l_ac].prcbseq
LET g_detail_multi_table_t.prcbl001 = g_dlang
LET g_detail_multi_table_t.prcbl002 = g_prcb_d[l_ac].prcbl002
LET g_detail_multi_table_t.prcbl003 = g_prcb_d[l_ac].prcbl003
 
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
            SELECT COUNT(1) INTO l_count FROM prcb_t 
             WHERE prcbent = g_enterprise AND prcbdocno = g_prca_m.prcadocno
 
               AND prcbseq = g_prcb_d[l_ac].prcbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                                                                                                                                                                                                                 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prca_m.prcadocno
               LET gs_keys[2] = g_prcb_d[g_detail_idx].prcbseq
               CALL aprt200_insert_b('prcb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               IF NOT aprt200_ins_prcc() THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prcb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prcb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt200_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_prca_m.prcadocno = g_detail_multi_table_t.prcbldocno AND
         g_prcb_d[l_ac].prcbseq = g_detail_multi_table_t.prcblseq AND
         g_prcb_d[l_ac].prcbl002 = g_detail_multi_table_t.prcbl002 AND
         g_prcb_d[l_ac].prcbl003 = g_detail_multi_table_t.prcbl003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prcblent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prca_m.prcadocno
            LET l_field_keys[02] = 'prcbldocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.prcbldocno
            LET l_var_keys[03] = g_prcb_d[l_ac].prcbseq
            LET l_field_keys[03] = 'prcblseq'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.prcblseq
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'prcbl001'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.prcbl001
            LET l_vars[01] = g_prcb_d[l_ac].prcbl002
            LET l_fields[01] = 'prcbl002'
            LET l_vars[02] = g_prcb_d[l_ac].prcbl003
            LET l_fields[02] = 'prcbl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prcbl_t')
         END IF 
 
               #add-point:input段-after_insert name="input.body.a_insert2"
#               LET l_time = cl_get_current()
#               UPDATE prca_t SET prcamodid = g_user,
#                                 prcamoddt = l_time
#                WHERE prcaent = g_enterprise
#                  AND prcadocno = g_prca_m.prcadocno
#               IF SQLCA.SQLcode  THEN
#                  CALL cl_err("upd prca_t",SQLCA.sqlcode,1)  
#                  CALL s_transaction_end('N','0')                    
#                  CANCEL INSERT
#               END IF                  
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
               LET gs_keys[01] = g_prca_m.prcadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prcb_d_t.prcbseq
 
            
               #刪除同層單身
               IF NOT aprt200_delete_b('prcb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt200_key_delete_b(gs_keys,'prcb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'prcblent'
                  LET l_var_keys_bak[01] = g_enterprise
                  LET l_field_keys[02] = 'prcbldocno'
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.prcbldocno
                  LET l_field_keys[03] = 'prcblseq'
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.prcblseq
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'prcbl_t')
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                                                                                                                                                                                                                 
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt200_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                                      DELETE FROM prcc_t
                   WHERE prccent = g_enterprise
                     AND prccdocno = g_prca_m.prcadocno
                     AND prccseq = g_prcb_d_t.prcbseq 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "prcc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF                      
               #end add-point
               LET l_count = g_prcb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                                                                                                                                                                    
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prcb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prcb_d[l_ac].prcbseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prcbseq
            END IF 
 
 
 
            #add-point:AFTER FIELD prcbseq name="input.a.page1.prcbseq"
                                                                                                                                                                                    
            IF NOT cl_null(g_prcb_d[l_ac].prcbseq) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF  g_prca_m.prcadocno IS NOT NULL AND g_prcb_d[g_detail_idx].prcbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prca_m.prcadocno != g_prcadocno_t OR g_prcb_d[g_detail_idx].prcbseq != g_prcb_d_t.prcbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prcb_t WHERE "||"prcbent = '" ||g_enterprise|| "' AND "||"prcbdocno = '"||g_prca_m.prcadocno ||"' AND "|| "prcbseq = '"||g_prcb_d[g_detail_idx].prcbseq ||"'",'std-00004',1) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbseq
            #add-point:BEFORE FIELD prcbseq name="input.b.page1.prcbseq"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcbseq
            #add-point:ON CHANGE prcbseq name="input.g.page1.prcbseq"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb001
            
            #add-point:AFTER FIELD prcb001 name="input.a.page1.prcb001"
                                                                                                                                                                                    
            IF NOT cl_null(g_prcb_d[l_ac].prcb001) THEN   
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_prcb_d[l_ac].prcb001 != g_prcb_d_t.prcb001) THEN    #160824-00007#135 Mark By ken 161101
               IF g_prcb_d[l_ac].prcb001 != g_prcb_d_o.prcb001 THEN    #160824-00007#135 Add By ken 161101
                  IF NOT ap_chk_notDup(g_prcb_d[l_ac].prcb001,"SELECT COUNT(*) FROM prcb_t WHERE "||"prcbent = '" ||g_enterprise|| "' AND "||"prcbdocno = '"||g_prca_m.prcadocno ||"' AND "|| "prcb001 = '"||g_prcb_d[l_ac].prcb001 ||"'",'std-00004',1) THEN 
                     #LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001   #160824-00007#135 Mark By ken 161101
                     LET g_prcb_d[l_ac].prcb001 = g_prcb_d_o.prcb001    #160824-00007#135 Add By ken 161101
                     NEXT FIELD CURRENT
                  END IF
                  IF g_prca_m.prca001 = 'I' THEN
                     IF g_argv[1]='1' THEN
                        IF NOT ap_chk_notDup(g_prcb_d[l_ac].prcb001,"SELECT COUNT(*) FROM prcb_t WHERE "||"prcbent = '" ||g_enterprise|| "' AND "|| "prcb001 = '"||g_prcb_d[l_ac].prcb001 ||"'",'apr-00048',1) THEN 
                           #LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001   #160824-00007#135 Mark By ken 161101
                           LET g_prcb_d[l_ac].prcb001 = g_prcb_d_o.prcb001    #160824-00007#135 Add By ken 161101
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF NOT ap_chk_notDup(g_prcb_d[l_ac].prcb001,"SELECT COUNT(*) FROM prcb_t WHERE "||"prcbent = '" ||g_enterprise|| "' AND "|| "prcb001 = '"||g_prcb_d[l_ac].prcb001 ||"'",'apr-00310',1) THEN 
                           #LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001   #160824-00007#135 Mark By ken 161101
                           LET g_prcb_d[l_ac].prcb001 = g_prcb_d_o.prcb001    #160824-00007#135 Add By ken 161101
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  #add--2015/07/02 By shiun--(S)
                  IF NOT s_aooi390_chk('18',g_prcb_d[l_ac].prcb001) THEN
                     #LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001   #160824-00007#135 Mark By ken 161101
                     LET g_prcb_d[l_ac].prcb001 = g_prcb_d_o.prcb001    #160824-00007#135 Add By ken 161101
                     DISPLAY BY NAME g_prcb_d[l_ac].prcb001
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/07/02 By shiun--(E)
               END IF
               IF g_prca_m.prca001 = 'U' THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prcb_d[l_ac].prcb001
                  LET g_chkparam.arg2 = g_argv[1]
                  LET g_chkparam.err_str[1] = "apr-00004:sub-01302|aprm200|",cl_get_progname("aprm200",g_lang,"2"),"|:EXEPROGaprm200"  #160318-00025#32  add
                  LET g_chkparam.err_str[2] = "apr-00003:sub-01314|aprt200|",cl_get_progname("aprt200",g_lang,"2"),"|:EXEPROGaprt200"  #160318-00025#32  add
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_prcd001_1") THEN
                     #LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001   #160824-00007#135 Mark By ken 161101
                     LET g_prcb_d[l_ac].prcb001 = g_prcb_d_o.prcb001    #160824-00007#135 Add By ken 161101
                     NEXT FIELD CURRENT
                  END IF
                  #IF l_cmd = 'a' OR (l_cmd = 'u' AND g_prcb_d[l_ac].prcb001 <> g_prcb_d_t.prcb001 ) THEN   #160824-00007#135 Mark By ken 161101
                  IF g_prcb_d[l_ac].prcb001 <> g_prcb_d_o.prcb001 THEN  #160824-00007#135 Add By ken 161101
                     CALL aprt200_prcb001_def()
                  END IF
               END IF
               IF g_prca_m.prca001 = 'I' THEN
                  CALL aprt200_chk_prcb001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prcb_d[l_ac].prcb001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001   #160824-00007#135 Mark By ken 161101
                     LET g_prcb_d[l_ac].prcb001 = g_prcb_d_o.prcb001    #160824-00007#135 Add By ken 161101
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_prcb_d_o.* = g_prcb_d[l_ac].*   #160824-00007#135 Add By ken 161101
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb001
            #add-point:BEFORE FIELD prcb001 name="input.b.page1.prcb001"
            IF g_prca_m.prca001 = 'I' AND l_cmd = 'a' THEN
               LET l_n1 = 0
               SELECT COUNT(*) INTO l_n1
                 FROM oofg_t
                WHERE oofgent = g_enterprise
                  AND oofg002 = '18'
                  AND oofgstus = 'Y'
               IF l_n1 > 0 THEN
#                  CALL s_aooi390('18') RETURNING l_success,l_prcb001   #mark--2015/07/02 By shiun
                  CALL s_aooi390_gen('18') RETURNING l_success,l_prcb001,l_oofg_return   #add--2015/07/02 By shiun
                  IF l_success THEN
                     LET g_prcb_d[l_ac].prcb001 = l_prcb001
                  END IF
                  IF NOT cl_null(g_prcb_d[l_ac].prcb001) THEN 
                     IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_prcb_d[l_ac].prcb001 != g_prcb_d_t.prcb001) THEN 
                        IF NOT ap_chk_notDup(g_prcb_d[l_ac].prcb001,"SELECT COUNT(*) FROM prcb_t WHERE "||"prcbent = '" ||g_enterprise|| "' AND "||"prcbdocno = '"||g_prca_m.prcadocno ||"' AND "|| "prcb001 = '"||g_prcb_d[l_ac].prcb001 ||"'",'std-00004',1) THEN 
                           LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001
                           NEXT FIELD prcbseq
                        ELSE
                           IF g_prca_m.prca001 = 'I' THEN
                              IF NOT ap_chk_notDup(g_prcb_d[l_ac].prcb001,"SELECT COUNT(*) FROM prcb_t WHERE "||"prcbent = '" ||g_enterprise|| "' AND "|| "prcb001 = '"||g_prcb_d[l_ac].prcb001 ||"'",'apr-00048',1) THEN 
                                 LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001
                                 NEXT FIELD prcbseq
                              END IF
                              CALL aprt200_chk_prcb001()
                              IF NOT cl_null(g_errno) THEN
                                 INITIALIZE g_errparam TO NULL
                                 LET g_errparam.code = g_errno
                                 LET g_errparam.extend = g_prcb_d[l_ac].prcb001
                                 LET g_errparam.popup = TRUE
                                 CALL cl_err()

                                 LET g_prcb_d[l_ac].prcb001 = g_prcb_d_t.prcb001
                                 NEXT FIELD prcbseq
                              ELSE
                                 CALL cl_set_comp_entry("prcb001",FALSE) 
                              END IF
                           END IF
                        END IF
                     END IF
                     CALL cl_set_comp_entry("prcb001",FALSE)
                  ELSE
                     NEXT FIELD prcbseq
                  END IF
               END IF
            END IF                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcb001
            #add-point:ON CHANGE prcb001 name="input.g.page1.prcb001"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbl002
            #add-point:BEFORE FIELD prcbl002 name="input.b.page1.prcbl002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbl002
            
            #add-point:AFTER FIELD prcbl002 name="input.a.page1.prcbl002"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcbl002
            #add-point:ON CHANGE prcbl002 name="input.g.page1.prcbl002"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbl003
            #add-point:BEFORE FIELD prcbl003 name="input.b.page1.prcbl003"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbl003
            
            #add-point:AFTER FIELD prcbl003 name="input.a.page1.prcbl003"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcbl003
            #add-point:ON CHANGE prcbl003 name="input.g.page1.prcbl003"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb002
            
            #add-point:AFTER FIELD prcb002 name="input.a.page1.prcb002"
                                                                                                                                                                                    
            CALL aprt200_prcb_desc()
            IF NOT cl_null(g_prcb_d[l_ac].prcb002) THEN
               CALL s_azzi650_chk_exist('2100',g_prcb_d[l_ac].prcb002) RETURNING l_success
               IF NOT l_success THEN
                  #LET g_prcb_d[l_ac].prcb002 = g_prcb_d_t.prcb002  #160824-00007#135 Mark By ken 161101
                  LET g_prcb_d[l_ac].prcb002 = g_prcb_d_o.prcb002   #160824-00007#135 Add By ken 161101                  
                  CALL aprt200_prcb_desc()
                  NEXT FIELD prcb002
               END IF
            END IF
            LET g_prcb_d_o.* = g_prcb_d[l_ac].*   #160824-00007#135 Add By ken 161101
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb002
            #add-point:BEFORE FIELD prcb002 name="input.b.page1.prcb002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcb002
            #add-point:ON CHANGE prcb002 name="input.g.page1.prcb002"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb003
            
            #add-point:AFTER FIELD prcb003 name="input.a.page1.prcb003"
                                                                                                                                                                                    
            CALL aprt200_prcb_desc()
            IF NOT cl_null(g_prcb_d[l_ac].prcb003) THEN
               CALL s_azzi650_chk_exist('2101',g_prcb_d[l_ac].prcb003) RETURNING l_success
               IF NOT l_success THEN
                  #LET g_prcb_d[l_ac].prcb003 = g_prcb_d_t.prcb003  #160824-00007#135 Mark By ken 161101
                  LET g_prcb_d[l_ac].prcb003 = g_prcb_d_o.prcb003   #160824-00007#135 Add By ken 161101 
                  CALL aprt200_prcb_desc()
                  NEXT FIELD prcb003
               END IF
            END IF
            LET g_prcb_d_o.* = g_prcb_d[l_ac].*   #160824-00007#135 Add By ken 161101
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb003
            #add-point:BEFORE FIELD prcb003 name="input.b.page1.prcb003"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcb003
            #add-point:ON CHANGE prcb003 name="input.g.page1.prcb003"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb004
            #add-point:BEFORE FIELD prcb004 name="input.b.page1.prcb004"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb004
            
            #add-point:AFTER FIELD prcb004 name="input.a.page1.prcb004"
            IF NOT cl_null(g_prcb_d[l_ac].prcb004) AND NOT cl_null(g_prcb_d[l_ac].prcb005) THEN
               IF g_prcb_d[l_ac].prcb004 > g_prcb_d[l_ac].prcb005 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00080'
                  LET g_errparam.extend = g_prcb_d[l_ac].prcb004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_prcb_d[l_ac].prcb004 = g_prcb_d_t.prcb004  #160824-00007#135 Mark By ken 161101
                  LET g_prcb_d[l_ac].prcb004 = g_prcb_d_o.prcb004   #160824-00007#135 Add By ken 161101
                  NEXT FIELD prcb004
               END IF
            END IF
            #150402-00005#6--add by dongsz--str---
            IF NOT cl_null(g_prcb_d[l_ac].prcb004) THEN
               SELECT ooef008,ooef010 INTO l_ooef008,l_ooef010
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_prca_m.prcasite
               CALL s_get_oogcdate(l_ooef008,l_ooef010,g_prcb_d[l_ac].prcb004,'','')
                  RETURNING r_flag,r_errno,r_oogc015,r_oogc007,r_sdate_s,r_sdate_e,r_oogc006,r_pdate_s,r_pdate_e,r_oogc008,r_wdate_s,r_wdate_e
               IF r_flag = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = r_errno
                  LET g_errparam.extend = g_prcb_d[l_ac].prcb004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_prcb_d[l_ac].prcb004 = g_prcb_d_t.prcb004  #160824-00007#135 Mark By ken 161101
                  LET g_prcb_d[l_ac].prcb004 = g_prcb_d_o.prcb004   #160824-00007#135 Add By ken 161101
                  NEXT FIELD prcb004
               END IF
               LET g_prcb_d[l_ac].prcb007 = r_oogc015
            END IF
            #150402-00005#6--add by dongsz--end---
            LET g_prcb_d_o.* = g_prcb_d[l_ac].*   #160824-00007#135 Add By ken 161101
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcb004
            #add-point:ON CHANGE prcb004 name="input.g.page1.prcb004"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb005
            #add-point:BEFORE FIELD prcb005 name="input.b.page1.prcb005"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb005
            
            #add-point:AFTER FIELD prcb005 name="input.a.page1.prcb005"
                                                                                                                                    IF NOT cl_null(g_prcb_d[l_ac].prcb004) AND NOT cl_null(g_prcb_d[l_ac].prcb005) THEN
               IF g_prcb_d[l_ac].prcb004 > g_prcb_d[l_ac].prcb005 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00081'
                  LET g_errparam.extend = g_prcb_d[l_ac].prcb004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_prcb_d[l_ac].prcb005 = g_prcb_d_t.prcb005  #160824-00007#135 Mark By ken 161101
                  LET g_prcb_d[l_ac].prcb005 = g_prcb_d_o.prcb005   #160824-00007#135 Add By ken 161101
                  NEXT FIELD prcb005
               END IF
            END IF   
            LET g_prcb_d_o.* = g_prcb_d[l_ac].*   #160824-00007#135 Add By ken 161101            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcb005
            #add-point:ON CHANGE prcb005 name="input.g.page1.prcb005"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb007
            #add-point:BEFORE FIELD prcb007 name="input.b.page1.prcb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb007
            
            #add-point:AFTER FIELD prcb007 name="input.a.page1.prcb007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcb007
            #add-point:ON CHANGE prcb007 name="input.g.page1.prcb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcb006
            #add-point:BEFORE FIELD prcb006 name="input.b.page1.prcb006"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcb006
            
            #add-point:AFTER FIELD prcb006 name="input.a.page1.prcb006"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcb006
            #add-point:ON CHANGE prcb006 name="input.g.page1.prcb006"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbacti
            #add-point:BEFORE FIELD prcbacti name="input.b.page1.prcbacti"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbacti
            
            #add-point:AFTER FIELD prcbacti name="input.a.page1.prcbacti"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcbacti
            #add-point:ON CHANGE prcbacti name="input.g.page1.prcbacti"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbsite
            #add-point:BEFORE FIELD prcbsite name="input.b.page1.prcbsite"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbsite
            
            #add-point:AFTER FIELD prcbsite name="input.a.page1.prcbsite"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcbsite
            #add-point:ON CHANGE prcbsite name="input.g.page1.prcbsite"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcbunit
            #add-point:BEFORE FIELD prcbunit name="input.b.page1.prcbunit"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcbunit
            
            #add-point:AFTER FIELD prcbunit name="input.a.page1.prcbunit"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcbunit
            #add-point:ON CHANGE prcbunit name="input.g.page1.prcbunit"
                                                                                                                                                                                    
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbseq
            #add-point:ON ACTION controlp INFIELD prcbseq name="input.c.page1.prcbseq"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb001
            #add-point:ON ACTION controlp INFIELD prcb001 name="input.c.page1.prcb001"
                                                                                                                                                                                    #此段落由子樣板a07產生            
            IF g_prca_m.prca001 = 'U' THEN
               #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   
               LET g_qryparam.default1 = g_prcb_d[l_ac].prcb001             #給予default值
			   
               #給予arg
               LET g_qryparam.arg1 = g_argv[1]
               CALL q_prcd001_1()                                #呼叫開窗
			   
               LET g_prcb_d[l_ac].prcb001 = g_qryparam.return1              #將開窗取得的值回傳到變數
			   
               DISPLAY g_prcb_d[l_ac].prcb001 TO prcb001              #顯示到畫面上
			      #IF l_cmd = 'a' OR (l_cmd = 'u' AND g_prcb_d[l_ac].prcb001 <> g_prcb_d_t.prcb001 or g_prcb_d_t.prcb001 is null) THEN   #160824-00007#135 Mark By ken 161101
			      IF g_prcb_d[l_ac].prcb001 <> g_prcb_d_o.prcb001 OR g_prcb_d_o.prcb001 IS NULL THEN   #160824-00007#135 Add By ken 161101
                  CALL aprt200_prcb001_def()
               END IF
               NEXT FIELD prcb001                          #返回原欄位
            END IF
            LET g_prcb_d_o.* = g_prcb_d[l_ac].*   #160824-00007#135 Add By ken 161101

            #END add-point
 
 
         #Ctrlp:input.c.page1.prcbl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbl002
            #add-point:ON ACTION controlp INFIELD prcbl002 name="input.c.page1.prcbl002"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcbl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbl003
            #add-point:ON ACTION controlp INFIELD prcbl003 name="input.c.page1.prcbl003"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb002
            #add-point:ON ACTION controlp INFIELD prcb002 name="input.c.page1.prcb002"
                                                                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcb_d[l_ac].prcb002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2100" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_prcb_d[l_ac].prcb002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prcb_d[l_ac].prcb002 TO prcb002              #顯示到畫面上
            CALL aprt200_prcb_desc()
            NEXT FIELD prcb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prcb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb003
            #add-point:ON ACTION controlp INFIELD prcb003 name="input.c.page1.prcb003"
                                                                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcb_d[l_ac].prcb003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2101" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_prcb_d[l_ac].prcb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prcb_d[l_ac].prcb003 TO prcb003              #顯示到畫面上
            CALL aprt200_prcb_desc()
            NEXT FIELD prcb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prcb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb004
            #add-point:ON ACTION controlp INFIELD prcb004 name="input.c.page1.prcb004"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb005
            #add-point:ON ACTION controlp INFIELD prcb005 name="input.c.page1.prcb005"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb007
            #add-point:ON ACTION controlp INFIELD prcb007 name="input.c.page1.prcb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcb006
            #add-point:ON ACTION controlp INFIELD prcb006 name="input.c.page1.prcb006"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcbacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbacti
            #add-point:ON ACTION controlp INFIELD prcbacti name="input.c.page1.prcbacti"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbsite
            #add-point:ON ACTION controlp INFIELD prcbsite name="input.c.page1.prcbsite"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prcbunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcbunit
            #add-point:ON ACTION controlp INFIELD prcbunit name="input.c.page1.prcbunit"
                                                                                                                                                                                    
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prcb_d[l_ac].* = g_prcb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prcb_d[l_ac].prcbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prcb_d[l_ac].* = g_prcb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #mark by geza 20151116(S)
               #修改状态下不重新编号
               #add--2015/07/02 By shiun--(S)
#               CALL s_aooi390_get_auto_no('18',g_prcb_d[l_ac].prcb001) RETURNING l_success,g_prcb_d[l_ac].prcb001
#               IF NOT l_success THEN
#                  CALL s_transaction_end('N','0')
#                  NEXT FIELD CURRENT
#               END IF   
#               DISPLAY BY NAME g_prcb_d[l_ac].prcb001
#               CALL s_aooi390_oofi_upd('18',g_prcb_d[l_ac].prcb001) RETURNING l_success
               #add--2015/07/02 By shiun--(E)
               #mark by geza 20151116(E)
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt200_prcb_t_mask_restore('restore_mask_o')
      
               UPDATE prcb_t SET (prcbdocno,prcbseq,prcb001,prcb002,prcb003,prcb004,prcb005,prcb007, 
                   prcb006,prcbacti,prcbsite,prcbunit) = (g_prca_m.prcadocno,g_prcb_d[l_ac].prcbseq, 
                   g_prcb_d[l_ac].prcb001,g_prcb_d[l_ac].prcb002,g_prcb_d[l_ac].prcb003,g_prcb_d[l_ac].prcb004, 
                   g_prcb_d[l_ac].prcb005,g_prcb_d[l_ac].prcb007,g_prcb_d[l_ac].prcb006,g_prcb_d[l_ac].prcbacti, 
                   g_prcb_d[l_ac].prcbsite,g_prcb_d[l_ac].prcbunit)
                WHERE prcbent = g_enterprise AND prcbdocno = g_prca_m.prcadocno 
 
                  AND prcbseq = g_prcb_d_t.prcbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                                                                                                                                                                                                                 
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prcb_d[l_ac].* = g_prcb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prcb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prcb_d[l_ac].* = g_prcb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prcb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_prca_m.prcadocno = g_detail_multi_table_t.prcbldocno AND
         g_prcb_d[l_ac].prcbseq = g_detail_multi_table_t.prcblseq AND
         g_prcb_d[l_ac].prcbl002 = g_detail_multi_table_t.prcbl002 AND
         g_prcb_d[l_ac].prcbl003 = g_detail_multi_table_t.prcbl003 THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prcblent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prca_m.prcadocno
            LET l_field_keys[02] = 'prcbldocno'
            LET l_var_keys_bak[02] = g_detail_multi_table_t.prcbldocno
            LET l_var_keys[03] = g_prcb_d[l_ac].prcbseq
            LET l_field_keys[03] = 'prcblseq'
            LET l_var_keys_bak[03] = g_detail_multi_table_t.prcblseq
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'prcbl001'
            LET l_var_keys_bak[04] = g_detail_multi_table_t.prcbl001
            LET l_vars[01] = g_prcb_d[l_ac].prcbl002
            LET l_fields[01] = 'prcbl002'
            LET l_vars[02] = g_prcb_d[l_ac].prcbl003
            LET l_fields[02] = 'prcbl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'prcbl_t')
         END IF 
 
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prca_m.prcadocno
               LET gs_keys_bak[1] = g_prcadocno_t
               LET gs_keys[2] = g_prcb_d[g_detail_idx].prcbseq
               LET gs_keys_bak[2] = g_prcb_d_t.prcbseq
               CALL aprt200_update_b('prcb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt200_prcb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prcb_d[g_detail_idx].prcbseq = g_prcb_d_t.prcbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_prca_m.prcadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prcb_d_t.prcbseq
 
                  CALL aprt200_key_update_b(gs_keys,'prcb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prca_m),util.JSON.stringify(g_prcb_d_t)
               LET g_log2 = util.JSON.stringify(g_prca_m),util.JSON.stringify(g_prcb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
#               LET l_time = cl_get_current()
#               UPDATE prca_t SET prcamodid = g_user,
#                                 prcamoddt = l_time
#                WHERE prcaent = g_enterprise
#                  AND prcadocno = g_prca_m.prcadocno
#               IF SQLCA.SQLcode  THEN
#                  CALL cl_err("upd prca_t",SQLCA.sqlcode,1)  
#                  CALL s_transaction_end('N','0')
#               END IF                 
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                                                                                                                                                                                    
            #end add-point
            CALL aprt200_unlock_b("prcb_t","'1'")
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
               LET g_prcb_d[li_reproduce_target].* = g_prcb_d[li_reproduce].*
 
               LET g_prcb_d[li_reproduce_target].prcbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prcb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prcb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_prcb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.detail_input.page2.update_item"
                                                                                                                                                                                    
               #END add-point
            END IF
 
 
 
 
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[1]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_prcb_d.getLength() = 0 THEN
               NEXT FIELD prcbseq
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_prcb_d[g_detail_idx].prcbseq) THEN
               NEXT FIELD prcbseq
            END IF
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prcb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prcb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            CALL aprt200_b_fill2('2')  
            IF l_ac = 0 OR cl_null(l_ac) THEN
               LET l_ac = 1
            END IF
            IF g_prcb_d[l_ac].prcb001 IS NULL THEN
               NEXT FIELD prcbseq	
            END IF 
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prcb2_d[l_ac].* TO NULL 
            INITIALIZE g_prcb2_d_t.* TO NULL 
            INITIALIZE g_prcb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_prcb2_d[l_ac].prccacti = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_prcb2_d_t.* = g_prcb2_d[l_ac].*     #新輸入資料
            LET g_prcb2_d_o.* = g_prcb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            LET g_prcb2_d[l_ac].prcc001 = '2'                                                                LET g_prcb2_d[l_ac].prccunit = g_site
            LET g_prcb2_d[l_ac].prccsite = g_site            
            #end add-point
            CALL aprt200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prcb2_d[li_reproduce_target].* = g_prcb2_d[li_reproduce].*
 
               LET g_prcb2_d[li_reproduce_target].prcc001 = NULL
               LET g_prcb2_d[li_reproduce_target].prcc002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
                                                                                                                                                                                    
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[2] = l_ac
            LET g_current_page = 2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprt200_cl USING g_enterprise,g_prca_m.prcadocno
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE aprt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN aprt200_bcl USING g_enterprise,g_prca_m.prcadocno,g_prcb_d[g_detail_idx].prcbseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt200_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt200_cl
               CLOSE aprt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prcb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prcb2_d[l_ac].prcc001 IS NOT NULL
               AND g_prcb2_d[l_ac].prcc002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prcb2_d_t.* = g_prcb2_d[l_ac].*  #BACKUP
               LET g_prcb2_d_o.* = g_prcb2_d[l_ac].*  #BACKUP
               CALL aprt200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
                                                                                                                                                                                                                                 
               #end add-point  
               CALL aprt200_set_no_entry_b(l_cmd)
               IF NOT aprt200_lock_b("prcc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt200_bcl2 INTO g_prcb2_d[l_ac].prcc001,g_prcb2_d[l_ac].prcc002,g_prcb2_d[l_ac].prccacti, 
                      g_prcb2_d[l_ac].prccsite,g_prcb2_d[l_ac].prccunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prcb2_d_mask_o[l_ac].* =  g_prcb2_d[l_ac].*
                  CALL aprt200_prcc_t_mask()
                  LET g_prcb2_d_mask_n[l_ac].* =  g_prcb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
                                                                                                                                                                                    
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
                                                                                                                                                                                                                                 
               #end add-point    
 
               #取得該筆資料key值
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prca_m.prcadocno
               LET gs_keys[2] = g_prcb_d[g_detail_idx].prcbseq
               LET gs_keys[3] = g_prcb2_d_t.prcc001
               LET gs_keys[4] = g_prcb2_d_t.prcc002
 
 
               #刪除同層單身
               IF NOT aprt200_delete_b('prcc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
                                                                                                                                                                                                                                 
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt200_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                                                                                                                                                                                                                                                                              
               #end add-point
 
               LET l_count = g_prcb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
                                                                                                                                                                                    
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prcb2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
         
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
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
                                                                                                                                                                                    
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM prcc_t 
             WHERE prccent = g_enterprise AND prccdocno = g_prca_m.prcadocno AND prccseq = g_prcb_d[g_detail_idx].prcbseq  
                 AND prcc001 = g_prcb2_d[g_detail_idx2].prcc001 AND prcc002 = g_prcb2_d[g_detail_idx2].prcc002 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
                                                                                                                                                                                                                                 
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prca_m.prcadocno
               LET gs_keys[2] = g_prcb_d[g_detail_idx].prcbseq
               LET gs_keys[3] = g_prcb2_d[g_detail_idx2].prcc001
               LET gs_keys[4] = g_prcb2_d[g_detail_idx2].prcc002
               CALL aprt200_insert_b('prcc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
                                                                                                                                                                                                                                 
               #end add-point
            ELSE    
               INITIALIZE g_prcb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt200_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
#               LET l_time = cl_get_current()
#               UPDATE prca_t SET prcamodid = g_user,
#                                 prcamoddt = l_time
#                WHERE prcaent = g_enterprise
#                  AND prcadocno = g_prca_m.prcadocno
#               IF SQLCA.SQLcode  THEN
#                  CALL cl_err("upd prca_t",SQLCA.sqlcode,1)  
#                  CALL s_transaction_end('N','0')
#               END IF                                                                                                                                                                                                           
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
            #還原g_detail_idx
            LET g_detail_idx = g_detail_idx_tmp
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prcb2_d[l_ac].* = g_prcb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt200_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prcb2_d[l_ac].* = g_prcb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
                                                                                                                                                                                                                                 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aprt200_prcc_t_mask_restore('restore_mask_o')
               
               UPDATE prcc_t SET (prccdocno,prccseq,prcc001,prcc002,prccacti,prccsite,prccunit) = (g_prca_m.prcadocno, 
                   g_prcb_d[g_detail_idx].prcbseq,g_prcb2_d[l_ac].prcc001,g_prcb2_d[l_ac].prcc002,g_prcb2_d[l_ac].prccacti, 
                   g_prcb2_d[l_ac].prccsite,g_prcb2_d[l_ac].prccunit) #自訂欄位頁簽
                WHERE prccent = g_enterprise AND prccdocno = g_prcadocno_t AND prccseq = g_prcb_d[g_detail_idx].prcbseq  
                    AND prcc001 = g_prcb2_d_t.prcc001 AND prcc002 = g_prcb2_d_t.prcc002
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
                                                                                                                                                                                                                                 
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prcb2_d[l_ac].* = g_prcb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prcc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prcb2_d[l_ac].* = g_prcb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prca_m.prcadocno
               LET gs_keys_bak[1] = g_prcadocno_t
               LET gs_keys[2] = g_prcb_d[g_detail_idx].prcbseq
               LET gs_keys_bak[2] = g_prcb_d[g_detail_idx].prcbseq
               LET gs_keys[3] = g_prcb2_d[g_detail_idx2].prcc001
               LET gs_keys_bak[3] = g_prcb2_d_t.prcc001
               LET gs_keys[4] = g_prcb2_d[g_detail_idx2].prcc002
               LET gs_keys_bak[4] = g_prcb2_d_t.prcc002
               CALL aprt200_update_b('prcc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprt200_prcc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prca_m),util.JSON.stringify(g_prcb2_d_t)
               LET g_log2 = util.JSON.stringify(g_prca_m),util.JSON.stringify(g_prcb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
#               LET l_time = cl_get_current()
#               UPDATE prca_t SET prcamodid = g_user,
#                                 prcamoddt = l_time
#                WHERE prcaent = g_enterprise
#                  AND prcadocno = g_prca_m.prcadocno
#               IF SQLCA.SQLcode  THEN
#                  CALL cl_err("upd prca_t",SQLCA.sqlcode,1)  
#                  CALL s_transaction_end('N','0')
#               END IF 
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcc001
            #add-point:BEFORE FIELD prcc001 name="input.b.page2.prcc001"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcc001
            
            #add-point:AFTER FIELD prcc001 name="input.a.page2.prcc001"
                                                                                    IF g_prcb2_d[g_detail_idx2].prcc001 IS NOT NULL AND g_prcb2_d[g_detail_idx2].prcc002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_prcb2_d[g_detail_idx2].prcc001 != g_prcb2_d_t.prcc001) THEN 
                  IF NOT ap_chk_notDup(g_prcb2_d[g_detail_idx2].prcc001,"SELECT COUNT(*) FROM prcc_t WHERE "||"prccent = '" ||g_enterprise|| "' AND "||"prccdocno = '"||g_prca_m.prcadocno ||"' AND "|| "prccseq = '"||g_prcb_d[g_detail_idx].prcbseq ||"' AND "|| "prcc001 = '"||g_prcb2_d[g_detail_idx2].prcc001 ||"' AND "|| "prcc002 = '"||g_prcb2_d[g_detail_idx2].prcc002 ||"'",'std-00004',1) THEN 
                     LET g_prcb2_d[g_detail_idx2].prcc001 = g_prcb2_d_t.prcc001
                     NEXT FIELD CURRENT
                  END IF
               END IF
#               IF g_prcb2_d[g_detail_idx2].prcc001 = '2' THEN
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_prcb2_d[g_detail_idx2].prcc002
#                  LET g_chkparam.arg2 = '2'
#                  LET g_chkparam.arg3 = g_site
#                  IF NOT cl_chk_exist("v_ooed004") THEN
#                     LET g_prcb2_d[g_detail_idx2].prcc001 = g_prcb2_d_t.prcc001
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               CALL aprt200_chk_prcc002()
#               IF NOT cl_null(g_errno) THEN
#                  CALL cl_err(g_prcb2_d[g_detail_idx2].prcc001,g_errno,1)
#                  LET g_prcb2_d[g_detail_idx2].prcc001 = g_prcb2_d_t.prcc001
#                  NEXT FIELD CURRENT
#               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcc001
            #add-point:ON CHANGE prcc001 name="input.g.page2.prcc001"
            LET g_prcb2_d[g_detail_idx2].prcc002 = ""
            LET g_prcb2_d[g_detail_idx2].prcc002_desc = ""
            DISPLAY BY NAME g_prcb2_d[g_detail_idx2].prcc002
            DISPLAY BY NAME g_prcb2_d[g_detail_idx2].prcc002_desc          
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcc002
            
            #add-point:AFTER FIELD prcc002 name="input.a.page2.prcc002"
                                                                                    CALL aprt200_prcc_desc()
            IF g_prcb2_d[g_detail_idx2].prcc002 IS NOT NULL THEN 
               IF g_prcb2_d[g_detail_idx2].prcc001 IS NOT NULL THEN
                  IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_prcb2_d[g_detail_idx2].prcc002 != g_prcb2_d_t.prcc002) THEN 
                     IF NOT ap_chk_notDup(g_prcb2_d[g_detail_idx2].prcc002,"SELECT COUNT(*) FROM prcc_t WHERE "||"prccent = '" ||g_enterprise|| "' AND "||"prccdocno = '"||g_prca_m.prcadocno ||"' AND "|| "prccseq = '"||g_prcb_d[g_detail_idx].prcbseq ||"' AND "|| "prcc001 = '"||g_prcb2_d[g_detail_idx2].prcc001 ||"' AND "|| "prcc002 = '"||g_prcb2_d[g_detail_idx2].prcc002 ||"'",'std-00004',1) THEN 
                        LET g_prcb2_d[g_detail_idx2].prcc002 = g_prcb2_d_t.prcc002
                        CALL aprt200_prcc_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               IF g_prcb2_d[g_detail_idx2].prcc001 = '2' THEN
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_prcb2_d[g_detail_idx2].prcc002
#                  LET g_chkparam.arg2 = '8'
#                  LET g_chkparam.arg3 = g_site
#                  IF NOT cl_chk_exist("v_ooed004") THEN
#                     LET g_prcb2_d[g_detail_idx2].prcc002 = g_prcb2_d_t.prcc002
#                     CALL aprt200_prcc_desc()
#                     NEXT FIELD CURRENT
#                  END IF
                  IF s_aooi500_setpoint(g_prog,'prcc002') THEN
                     CALL s_aooi500_chk(g_prog,'prcc002',g_prcb2_d[g_detail_idx2].prcc002,g_prca_m.prcaunit) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_prcb2_d[g_detail_idx2].prcc002
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        LET g_prcb2_d[g_detail_idx2].prcc002 = g_prcb2_d_t.prcc002
                        CALL aprt200_prcc_desc()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_prcb2_d[g_detail_idx2].prcc002
                     LET g_chkparam.arg2 = '8'
                     LET g_chkparam.arg3 = g_prca_m.prcaunit
                     IF NOT cl_chk_exist("v_ooed004") THEN
                        LET g_prcb2_d[g_detail_idx2].prcc002 = g_prcb2_d_t.prcc002
                        CALL aprt200_prcc_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               CALL aprt200_chk_prcc002()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prcb2_d[g_detail_idx2].prcc002
                  #160318-00005#40  By 07900 --add-str
                  LET g_errparam.replace[1] = 'arti201'
                  LET g_errparam.replace[2] = cl_get_progname("arti201",g_lang,"2")
                  LET g_errparam.exeprog = 'arti201'
                  #160318-00005#40  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prcb2_d[g_detail_idx2].prcc002 = g_prcb2_d_t.prcc002
                  CALL aprt200_prcc_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcc002
            #add-point:BEFORE FIELD prcc002 name="input.b.page2.prcc002"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcc002
            #add-point:ON CHANGE prcc002 name="input.g.page2.prcc002"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prccacti
            #add-point:BEFORE FIELD prccacti name="input.b.page2.prccacti"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prccacti
            
            #add-point:AFTER FIELD prccacti name="input.a.page2.prccacti"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prccacti
            #add-point:ON CHANGE prccacti name="input.g.page2.prccacti"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prccsite
            #add-point:BEFORE FIELD prccsite name="input.b.page2.prccsite"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prccsite
            
            #add-point:AFTER FIELD prccsite name="input.a.page2.prccsite"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prccsite
            #add-point:ON CHANGE prccsite name="input.g.page2.prccsite"
                                                                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prccunit
            #add-point:BEFORE FIELD prccunit name="input.b.page2.prccunit"
                                                                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prccunit
            
            #add-point:AFTER FIELD prccunit name="input.a.page2.prccunit"
                                                                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prccunit
            #add-point:ON CHANGE prccunit name="input.g.page2.prccunit"
                                                                                                                                                                                    
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.prcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcc001
            #add-point:ON ACTION controlp INFIELD prcc001 name="input.c.page2.prcc001"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page2.prcc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcc002
            #add-point:ON ACTION controlp INFIELD prcc002 name="input.c.page2.prcc002"
                                                                                                                        #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prcb2_d[l_ac].prcc002             #給予default值

            #給予arg
            IF g_prcb2_d[l_ac].prcc001 = '1' THEN
               LET g_qryparam.arg1 = '4'
               LET g_qryparam.arg2 = g_prca_m.prcaunit
               LET g_qryparam.arg3 = '8'
               CALL q_rtaa001_5() 
            ELSE
#               LET g_qryparam.arg1 = g_site
#               LET g_qryparam.arg2 = '8'
#               CALL q_ooed004()                                #呼叫開窗
               IF s_aooi500_setpoint(g_prog,'prcc002') THEN
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'prcc002',g_prca_m.prcaunit,'i')   #150308-00001#4 150309 by lori522612 add 'i'
                  CALL q_ooef001_24()
               ELSE
                  LET g_qryparam.arg1 = g_prca_m.prcaunit
                  LET g_qryparam.arg2 = '8'
                  CALL q_ooed004()    
               END IF
            END IF

            LET g_prcb2_d[l_ac].prcc002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_prcb2_d[l_ac].prcc002 TO prcc002              #顯示到畫面上
            CALL aprt200_prcc_desc()
            NEXT FIELD prcc002                          #返回原欄位                                                  
            #END add-point
 
 
         #Ctrlp:input.c.page2.prccacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prccacti
            #add-point:ON ACTION controlp INFIELD prccacti name="input.c.page2.prccacti"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page2.prccsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prccsite
            #add-point:ON ACTION controlp INFIELD prccsite name="input.c.page2.prccsite"
                                                                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page2.prccunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prccunit
            #add-point:ON ACTION controlp INFIELD prccunit name="input.c.page2.prccunit"
                                                                                                                                                                                    
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2_after_row name="input.body2.after_row"
                                                                                                                                                                                    
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prcb2_d[l_ac].* = g_prcb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt200_bcl2
               CLOSE aprt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprt200_unlock_b("prcc_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2_after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
                                                                                                                                                                                    
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prcb2_d[li_reproduce_target].* = g_prcb2_d[li_reproduce].*
 
               LET g_prcb2_d[li_reproduce_target].prcc001 = NULL
               LET g_prcb2_d[li_reproduce_target].prcc002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prcb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prcb2_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="aprt200.input.other" >}
      
      #add-point:自定義input name="input.more_input"
                                                                                          
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
                                                                                                       
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD prcasite #sakura add
            #end add-point  
            NEXT FIELD prcadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prcbseq
               WHEN "s_detail2"
                  NEXT FIELD prcc001
 
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
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
                                             
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt200_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
                                             
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
                                             
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt200_b_fill() #單身填充
      CALL aprt200_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt200_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
                                             
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prca_m.prcaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prca_m.prcaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prca_m.prcaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prca_m.prcaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prca_m.prcaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prca_m.prcaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prca_m.prcacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prca_m.prcacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prca_m.prcacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prca_m.prcacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prca_m.prcacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prca_m.prcacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prca_m.prcamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prca_m.prcamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prca_m.prcamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prca_m.prcacnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prca_m.prcacnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prca_m.prcacnfid_desc
            
            CALL aprt200_desc()
   #end add-point
   
   #遮罩相關處理
   LET g_prca_m_mask_o.* =  g_prca_m.*
   CALL aprt200_prca_t_mask()
   LET g_prca_m_mask_n.* =  g_prca_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit, 
       g_prca_m.prcaunit_desc,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca002_desc, 
       g_prca_m.prca003,g_prca_m.prca003_desc,g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp,g_prca_m.prcacrtdp_desc,g_prca_m.prcacrtdt,g_prca_m.prcaownid,g_prca_m.prcaownid_desc, 
       g_prca_m.prcaowndp,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid,g_prca_m.prcamodid_desc,g_prca_m.prcamoddt, 
       g_prca_m.prcacnfid,g_prca_m.prcacnfid_desc,g_prca_m.prcacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prca_m.prcastus 
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
   FOR l_ac = 1 TO g_prcb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
                                                                                          
            CALL aprt200_prcb_desc()
            LET g_ref_fields[1] = g_prca_m.prcadocno
            LET g_ref_fields[2] = g_prcb_d[l_ac].prcbseq
            CALL ap_ref_array2(g_ref_fields," SELECT prcbl002,prcbl003 FROM prcbl_t WHERE prcblent = '"
                ||g_enterprise||"' AND prcbldocno = ? AND prcblseq = ? AND prcbl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prcb_d[l_ac].prcbl002 = g_rtn_fields[1]
            LET g_prcb_d[l_ac].prcbl003 = g_rtn_fields[2]
            DISPLAY BY NAME g_prcb_d[l_ac].prcbl002
            DISPLAY BY NAME g_prcb_d[l_ac].prcbl003
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prcb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
                                                                                          
      CALL aprt200_prcc_desc()
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
                                             
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt200_detail_show()
 
   #add-point:show段之後 name="show.after"
                                             
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt200_detail_show()
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
 
{<section id="aprt200.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt200_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prca_t.prcadocno 
   DEFINE l_oldno     LIKE prca_t.prcadocno 
 
   DEFINE l_master    RECORD LIKE prca_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prcb_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE prcc_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004                              
   DEFINE l_insert      LIKE type_t.num5 #ken---add 需求單號：141208-00001 項次：22
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
   
   IF g_prca_m.prcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prcadocno_t = g_prca_m.prcadocno
 
    
   LET g_prca_m.prcadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prca_m.prcaownid = g_user
      LET g_prca_m.prcaowndp = g_dept
      LET g_prca_m.prcacrtid = g_user
      LET g_prca_m.prcacrtdp = g_dept 
      LET g_prca_m.prcacrtdt = cl_get_current()
      LET g_prca_m.prcamodid = g_user
      LET g_prca_m.prcamoddt = cl_get_current()
      LET g_prca_m.prcastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #ken---add---str 需求單號：141208-00001 項次：22
   CALL s_aooi500_default(g_prog,'prcasite',g_prca_m.prcasite)
      RETURNING l_insert,g_prca_m.prcasite
   IF l_insert = FALSE THEN
      RETURN
   END IF   
   #ken---add---end
   
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prca_m.prcasite,g_prog,'1') #ken---add 需求單號：141208-00001 項次：22
   #CALL s_arti200_get_def_doc_type(g_prca_m.prcaunit,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prca_m.prcadocno = r_doctype
   #dongsz--add--end---                        
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prca_m.prcastus 
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
   
   
   CALL aprt200_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prca_m.* TO NULL
      INITIALIZE g_prcb_d TO NULL
      INITIALIZE g_prcb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt200_show()
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
   CALL aprt200_set_act_visible()   
   CALL aprt200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prcadocno_t = g_prca_m.prcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prcaent = " ||g_enterprise|| " AND",
                      " prcadocno = '", g_prca_m.prcadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
                                             
   #end add-point
   
   CALL aprt200_idx_chk()
   
   LET g_data_owner = g_prca_m.prcaownid      
   LET g_data_dept  = g_prca_m.prcaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt200_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt200_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prcb_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE prcc_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
                                             
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt200_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
                                             
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prcb_t
    WHERE prcbent = g_enterprise AND prcbdocno = g_prcadocno_t
 
    INTO TEMP aprt200_detail
 
   #將key修正為調整後   
   UPDATE aprt200_detail 
      #更新key欄位
      SET prcbdocno = g_prca_m.prcadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prcb_t SELECT * FROM aprt200_detail
   
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
   DROP TABLE aprt200_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
                                             
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
                                             
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prcc_t 
    WHERE prccent = g_enterprise AND prccdocno = g_prcadocno_t
 
    INTO TEMP aprt200_detail
 
   #將key修正為調整後   
   UPDATE aprt200_detail SET prccdocno = g_prca_m.prcadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO prcc_t SELECT * FROM aprt200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
                                             
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt200_detail
   
   LET g_data_owner = g_prca_m.prcaownid      
   LET g_data_dept  = g_prca_m.prcaowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
                                             
   #end add-point
 
 
   
   #多語言複製段落
      #應用 a38 樣板自動產生(Version:6)
   #單身多語言複製
   DROP TABLE aprt200_detail_lang
   
   #add-point:單身複製前1 name="detail_reproduce.body.lang0.b_insert"
                                             
   #end add-point
   
   #CREATE TEMP TABLE & INSERT 
   SELECT * FROM prcbl_t 
    WHERE prcblent = g_enterprise AND prcbldocno = g_prcadocno_t
 
     INTO TEMP aprt200_detail_lang
 
   #將key修正為調整後   
   UPDATE aprt200_detail_lang 
      #更新key欄位
      SET prcbldocno = g_prca_m.prcadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.lang0.b_update"
   
   #end add-point   
  
   #將資料塞回原table   
   INSERT INTO prcbl_t SELECT * FROM aprt200_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.lang0.table1.m_insert"
                                             
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt200_detail_lang
   
   #add-point:單身複製後1 name="detail_reproduce.lang0.table1.a_insert"
                                             
   #end add-point
 
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prcadocno_t = g_prca_m.prcadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt200_delete()
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
   
   IF g_prca_m.prcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aprt200_cl USING g_enterprise,g_prca_m.prcadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt200_master_referesh USING g_prca_m.prcadocno INTO g_prca_m.prcasite,g_prca_m.prcadocdt, 
       g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003, 
       g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid, 
       g_prca_m.prcaowndp,g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt, 
       g_prca_m.prcasite_desc,g_prca_m.prcaunit_desc,g_prca_m.prca002_desc,g_prca_m.prca003_desc,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp_desc,g_prca_m.prcaownid_desc,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid_desc, 
       g_prca_m.prcacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prca_m_mask_o.* =  g_prca_m.*
   CALL aprt200_prca_t_mask()
   LET g_prca_m_mask_n.* =  g_prca_m.*
   
   CALL aprt200_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
                                                                                          
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt200_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prcadocno_t = g_prca_m.prcadocno
 
 
      DELETE FROM prca_t
       WHERE prcaent = g_enterprise AND prcadocno = g_prca_m.prcadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                  IF NOT s_aooi200_del_docno(g_prca_m.prcadocno,g_prca_m.prcadocdt) THEN 
         CALL s_transaction_end('N','0')
         RETURN 
      END IF                                                       
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prca_m.prcadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #ken---add---str 需求單號：141208-00001 項次：22
      IF NOT s_aooi200_del_docno(g_prca_m.prcadocno,g_prca_m.prcadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #ken---add---end
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
                                                                                          
      #end add-point
      
      DELETE FROM prcb_t
       WHERE prcbent = g_enterprise AND prcbdocno = g_prca_m.prcadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                                                                                          
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prcb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
                                                                                          
      #end add-point
      
            
                                                               
 
 
      #add-point:單身刪除前 name="delete.body.b_delete2"
                                                                                          
      #end add-point
      DELETE FROM prcc_t
       WHERE prccent = g_enterprise AND
             prccdocno = g_prca_m.prcadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
                                                                                          
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
                                                                                          
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prca_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt200_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prcb_d.clear() 
      CALL g_prcb2_d.clear()       
 
     
      CALL aprt200_ui_browser_refresh()  
      #CALL aprt200_ui_headershow()  
      #CALL aprt200_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
         INITIALIZE l_field_keys TO NULL 
         LET l_field_keys[01] = 'prcblent'
         LET l_var_keys_bak[01] = g_enterprise
         LET l_field_keys[02] = 'prcbldocno'
         LET l_var_keys_bak[02] = g_prca_m.prcadocno
         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'prcbl_t')
 
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt200_browser_fill("")
         CALL aprt200_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt200_cl
 
   #功能已完成,通報訊息中心
   CALL aprt200_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt200_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
                                             
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prcb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
                                             
   #end add-point
   
   #判斷是否填充
   IF aprt200_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prcbseq,prcb001,prcb002,prcb003,prcb004,prcb005,prcb007,prcb006, 
             prcbacti,prcbsite,prcbunit ,t1.oocql004 ,t2.oocql004 FROM prcb_t",   
                     " INNER JOIN prca_t ON prcaent = " ||g_enterprise|| " AND prcadocno = prcbdocno ",
 
                     #" LEFT JOIN prcbl_t ON prcblent = "||g_enterprise||" AND prcadocno = prcbldocno AND prcbseq = prcblseq AND prcbl001 = '",g_dlang,"'",
                     " LEFT JOIN prcc_t ON prcbent = prccent AND prcbdocno = prccdocno AND prcbseq = prccseq ",
                     " LEFT JOIN prcbl_t ON prcblent = "||g_enterprise||" AND prcadocno = prcbldocno AND prcbseq = prcblseq AND prcbl001 = '",g_dlang,"'",
                     #下層單身所需的join條件
                     " ",
 
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2100' AND t1.oocql002=prcb002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2101' AND t2.oocql002=prcb003 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE prcbent=? AND prcbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
                                                                                          
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY prcb_t.prcbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
                                   
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt200_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt200_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prca_m.prcadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prca_m.prcadocno INTO g_prcb_d[l_ac].prcbseq,g_prcb_d[l_ac].prcb001, 
          g_prcb_d[l_ac].prcb002,g_prcb_d[l_ac].prcb003,g_prcb_d[l_ac].prcb004,g_prcb_d[l_ac].prcb005, 
          g_prcb_d[l_ac].prcb007,g_prcb_d[l_ac].prcb006,g_prcb_d[l_ac].prcbacti,g_prcb_d[l_ac].prcbsite, 
          g_prcb_d[l_ac].prcbunit,g_prcb_d[l_ac].prcb002_desc,g_prcb_d[l_ac].prcb003_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
                                                                                                            CALL aprt200_prcb_desc()
         LET g_ref_fields[1] = g_prca_m.prcadocno
         LET g_ref_fields[2] = g_prcb_d[l_ac].prcbseq
         CALL ap_ref_array2(g_ref_fields," SELECT prcbl002,prcbl003 FROM prcbl_t WHERE prcblent = '"
             ||g_enterprise||"' AND prcbldocno = ? AND prcblseq = ? AND prcbl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prcb_d[l_ac].prcbl002 = g_rtn_fields[1]
         LET g_prcb_d[l_ac].prcbl003 = g_rtn_fields[2]
         DISPLAY BY NAME g_prcb_d[l_ac].prcbl002
         DISPLAY BY NAME g_prcb_d[l_ac].prcbl003                                                                                 
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
   
   CALL g_prcb_d.deleteElement(g_prcb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt200_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prcb_d.getLength()
      LET g_prcb_d_mask_o[l_ac].* =  g_prcb_d[l_ac].*
      CALL aprt200_prcb_t_mask()
      LET g_prcb_d_mask_n[l_ac].* =  g_prcb_d[l_ac].*
   END FOR
   
   LET g_prcb2_d_mask_o.* =  g_prcb2_d.*
   FOR l_ac = 1 TO g_prcb2_d.getLength()
      LET g_prcb2_d_mask_o[l_ac].* =  g_prcb2_d[l_ac].*
      CALL aprt200_prcc_t_mask()
      LET g_prcb2_d_mask_n[l_ac].* =  g_prcb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt200_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prcb_t
       WHERE prcbent = g_enterprise AND
         prcbdocno = ps_keys_bak[1] AND prcbseq = ps_keys_bak[2]
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
         CALL g_prcb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
                                                                                          
      #end add-point    
      DELETE FROM prcc_t
       WHERE prccent = g_enterprise AND
             prccdocno = ps_keys_bak[1] AND prccseq = ps_keys_bak[2] AND prcc001 = ps_keys_bak[3] AND prcc002 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
                                                                                          
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_prcb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
                                                                                          
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
                                             
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt200_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      #add--2015/07/02 By shiun--(S)
      CALL s_aooi390_get_auto_no('18',g_prcb_d[g_detail_idx].prcb001) RETURNING l_success,g_prcb_d[g_detail_idx].prcb001
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      DISPLAY BY NAME g_prcb_d[g_detail_idx].prcb001
      CALL s_aooi390_oofi_upd('18',g_prcb_d[g_detail_idx].prcb001) RETURNING l_success
      #add--2015/07/02 By shiun--(E)
      #end add-point 
      INSERT INTO prcb_t
                  (prcbent,
                   prcbdocno,
                   prcbseq
                   ,prcb001,prcb002,prcb003,prcb004,prcb005,prcb007,prcb006,prcbacti,prcbsite,prcbunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prcb_d[g_detail_idx].prcb001,g_prcb_d[g_detail_idx].prcb002,g_prcb_d[g_detail_idx].prcb003, 
                       g_prcb_d[g_detail_idx].prcb004,g_prcb_d[g_detail_idx].prcb005,g_prcb_d[g_detail_idx].prcb007, 
                       g_prcb_d[g_detail_idx].prcb006,g_prcb_d[g_detail_idx].prcbacti,g_prcb_d[g_detail_idx].prcbsite, 
                       g_prcb_d[g_detail_idx].prcbunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                                                                                          
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prcb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prcb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                                                                                          
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
                                                                                          
      #end add-point 
      INSERT INTO prcc_t
                  (prccent,
                   prccdocno,prccseq,
                   prcc001,prcc002
                   ,prccacti,prccsite,prccunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_prcb2_d[g_detail_idx2].prccacti,g_prcb2_d[g_detail_idx2].prccsite,g_prcb2_d[g_detail_idx2].prccunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
                                                                                          
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_prcb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
                                                                                          
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
                                             
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prcb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                                                                                          
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt200_prcb_t_mask_restore('restore_mask_o')
               
      UPDATE prcb_t 
         SET (prcbdocno,
              prcbseq
              ,prcb001,prcb002,prcb003,prcb004,prcb005,prcb007,prcb006,prcbacti,prcbsite,prcbunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prcb_d[g_detail_idx].prcb001,g_prcb_d[g_detail_idx].prcb002,g_prcb_d[g_detail_idx].prcb003, 
                  g_prcb_d[g_detail_idx].prcb004,g_prcb_d[g_detail_idx].prcb005,g_prcb_d[g_detail_idx].prcb007, 
                  g_prcb_d[g_detail_idx].prcb006,g_prcb_d[g_detail_idx].prcbacti,g_prcb_d[g_detail_idx].prcbsite, 
                  g_prcb_d[g_detail_idx].prcbunit) 
         WHERE prcbent = g_enterprise AND prcbdocno = ps_keys_bak[1] AND prcbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
                                                                                          
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prcb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prcb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt200_prcb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
                                                                                          
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      LET l_new_key[01] = g_enterprise
LET l_old_key[01] = g_enterprise
LET l_field_key[01] = 'prcblent'
LET l_new_key[02] = ps_keys[1] 
LET l_old_key[02] = ps_keys_bak[1] 
LET l_field_key[02] = 'prcbldocno'
LET l_new_key[03] = ps_keys[2] 
LET l_old_key[03] = ps_keys_bak[2] 
LET l_field_key[03] = 'prcblseq'
LET l_new_key[04] = g_dlang 
LET l_old_key[04] = g_dlang 
LET l_field_key[04] = 'prcbl001'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'prcbl_t')
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prcc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
                                                                                          
      #end add-point
      
      #將遮罩欄位還原
      CALL aprt200_prcc_t_mask_restore('restore_mask_o')
               
      UPDATE prcc_t 
         SET (prccdocno,prccseq,
              prcc001,prcc002
              ,prccacti,prccsite,prccunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_prcb2_d[g_detail_idx2].prccacti,g_prcb2_d[g_detail_idx2].prccsite,g_prcb2_d[g_detail_idx2].prccunit)  
 
         WHERE prccent = g_enterprise AND prccdocno = ps_keys_bak[1] AND prccseq = ps_keys_bak[2] AND prcc001 = ps_keys_bak[3] AND prcc002 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
                                                                                          
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prcc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt200_prcc_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
                                                                                          
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   #add-point:update_b段other name="update_b.other"
                                             
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt200_key_update_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行update
   IF ps_table = 'prcb_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE prcc_t 
         SET (prccdocno,prccseq) 
              = 
             (g_prca_m.prcadocno,g_prcb_d[g_detail_idx].prcbseq) 
         WHERE prccent = g_enterprise AND
               prccdocno = ps_keys_bak[1] AND prccseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update2"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt200_key_delete_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行delete
   IF ps_table = 'prcb_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM prcc_t 
            WHERE prccent = g_enterprise AND
                  prccdocno = ps_keys_bak[1] AND prccseq = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prcc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt200_lock_b(ps_table,ps_page)
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
   #CALL aprt200_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prcb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt200_bcl USING g_enterprise,
                                       g_prca_m.prcadocno,g_prcb_d[g_detail_idx].prcbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt200_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "prcc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprt200_bcl2 USING g_enterprise,
                                             g_prca_m.prcadocno,g_prcb_d[g_detail_idx].prcbseq,
                                             g_prcb2_d[g_detail_idx2].prcc001,g_prcb2_d[g_detail_idx2].prcc002 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt200_bcl2:",SQLERRMESSAGE 
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
 
{<section id="aprt200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt200_unlock_b(ps_table,ps_page)
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
      CLOSE aprt200_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt200_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
                                             
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt200_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
                                             
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prcadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prcadocno",TRUE)
      CALL cl_set_comp_entry("prcadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prcaunit",TRUE)
      CALL cl_set_comp_entry("prcadocdt",TRUE)                                                                                    
      CALL cl_set_comp_entry("prcasite",TRUE) #ken---add 需求單號：141208-00001 項次：22
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
                                             
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt200_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
                                             
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prcadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("prcadocdt",FALSE)                                                                                    
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prcadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prcadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #ken---add---str 需求單號：141208-00001 項次：22
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("prcasite",FALSE)
      CALL cl_set_comp_entry("prcadocno",FALSE)
      CALL cl_set_comp_entry("prcadocdt",FALSE)
   END IF
   
   IF NOT s_aooi500_comp_entry(g_prog,'prcasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prcasite",FALSE)
   END IF 
   #ken---add---end
   #IF NOT s_aooi500_comp_entry(g_prog,'prcaunit') OR g_site_flag THEN
   #   CALL cl_set_comp_entry("prcaunit",FALSE)
   #END IF                                     
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt200_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("prcb001",TRUE)    
   CALL cl_set_comp_entry("prcb004",TRUE)  
   CALL cl_set_comp_entry("prcb005",TRUE)  
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aprt200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt200_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
                     DEFINE l_n     LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
         IF g_prca_m.prca001 = 'I' AND p_cmd = 'u' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM oofg_t
       WHERE oofgent = g_enterprise
         AND oofg002 = '18'
         AND oofgstus = 'Y'
      IF l_n > 0 THEN
         CALL cl_set_comp_entry("prcb001",FALSE)
      END IF
   END IF              
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aprt200.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt200_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt200_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prca_m.prcastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt200_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt200_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt200_default_search()
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
   #qiaozy
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
#   IF NOT cl_null(g_argv[1]) THEN
#      LET ls_wc = ls_wc, " prca098 = '", g_argv[1], "' AND "
#   END IF
#   
# 
#   
#   IF NOT cl_null(ls_wc) THEN
#      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
#      LET g_default = TRUE
#   ELSE
#      LET g_default = FALSE
#      #預設查詢條件
#      LET g_wc = cl_qbe_get_default_qryplan()
#      IF cl_null(g_wc) THEN
#         LET g_wc = " 1=1"
#      END IF
#   END IF
#   RETURN   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " prcadocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " prcadocno = '", g_argv[02], "' AND "
   END IF
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
               WHEN la_wc[li_idx].tableid = "prca_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prcb_t" 
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
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc," AND prca098 = '", g_argv[01], "' "
   END IF                                            
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt200_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
                                             
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
            IF g_prca_m.prcastus  = 'X' OR g_prca_m.prcastus  = 'Y' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prca_m.prcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt200_cl USING g_enterprise,g_prca_m.prcadocno
   IF STATUS THEN
      CLOSE aprt200_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt200_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt200_master_referesh USING g_prca_m.prcadocno INTO g_prca_m.prcasite,g_prca_m.prcadocdt, 
       g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003, 
       g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid, 
       g_prca_m.prcaowndp,g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt, 
       g_prca_m.prcasite_desc,g_prca_m.prcaunit_desc,g_prca_m.prca002_desc,g_prca_m.prca003_desc,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp_desc,g_prca_m.prcaownid_desc,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid_desc, 
       g_prca_m.prcacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt200_action_chk() THEN
      CLOSE aprt200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit, 
       g_prca_m.prcaunit_desc,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca002_desc, 
       g_prca_m.prca003,g_prca_m.prca003_desc,g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtid_desc, 
       g_prca_m.prcacrtdp,g_prca_m.prcacrtdp_desc,g_prca_m.prcacrtdt,g_prca_m.prcaownid,g_prca_m.prcaownid_desc, 
       g_prca_m.prcaowndp,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid,g_prca_m.prcamodid_desc,g_prca_m.prcamoddt, 
       g_prca_m.prcacnfid,g_prca_m.prcacnfid_desc,g_prca_m.prcacnfdt
 
   CASE g_prca_m.prcastus
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
         CASE g_prca_m.prcastus
            
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
      IF g_prca_m.prcastus <> 'N' THEN
         CALL cl_set_act_visible("invalid", FALSE)
      END IF
      #150402-00005#6--add by dongsz--str---
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_prca_m.prcastus
         WHEN "N"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
      END CASE
      #150402-00005#6--add by dongsz--end---
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aprt200_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt200_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt200_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt200_cl
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
      g_prca_m.prcastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
                  LET l_success = TRUE
   CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
      CALL s_aprt200_conf_chk(g_prca_m.prcadocno,g_prca_m.prcastus) RETURNING l_success,g_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_prca_m.prcadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_aprt200_conf_upd(g_prca_m.prcadocno,g_prca_m.prcastus) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF   
      
   #151125-00001#3 ---add (S)---
   IF lc_state = "X" THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #151125-00001#3 ---add (E)---
   #end add-point
   
   LET g_prca_m.prcamodid = g_user
   LET g_prca_m.prcamoddt = cl_get_current()
   LET g_prca_m.prcastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prca_t 
      SET (prcastus,prcamodid,prcamoddt) 
        = (g_prca_m.prcastus,g_prca_m.prcamodid,g_prca_m.prcamoddt)     
    WHERE prcaent = g_enterprise AND prcadocno = g_prca_m.prcadocno
 
    
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
      EXECUTE aprt200_master_referesh USING g_prca_m.prcadocno INTO g_prca_m.prcasite,g_prca_m.prcadocdt, 
          g_prca_m.prca098,g_prca_m.prcaunit,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca003, 
          g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtdp,g_prca_m.prcacrtdt,g_prca_m.prcaownid, 
          g_prca_m.prcaowndp,g_prca_m.prcamodid,g_prca_m.prcamoddt,g_prca_m.prcacnfid,g_prca_m.prcacnfdt, 
          g_prca_m.prcasite_desc,g_prca_m.prcaunit_desc,g_prca_m.prca002_desc,g_prca_m.prca003_desc, 
          g_prca_m.prcacrtid_desc,g_prca_m.prcacrtdp_desc,g_prca_m.prcaownid_desc,g_prca_m.prcaowndp_desc, 
          g_prca_m.prcamodid_desc,g_prca_m.prcacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prca_m.prcasite,g_prca_m.prcasite_desc,g_prca_m.prcadocdt,g_prca_m.prca098,g_prca_m.prcaunit, 
          g_prca_m.prcaunit_desc,g_prca_m.prcadocno,g_prca_m.prca001,g_prca_m.prca002,g_prca_m.prca002_desc, 
          g_prca_m.prca003,g_prca_m.prca003_desc,g_prca_m.prcastus,g_prca_m.prcacrtid,g_prca_m.prcacrtid_desc, 
          g_prca_m.prcacrtdp,g_prca_m.prcacrtdp_desc,g_prca_m.prcacrtdt,g_prca_m.prcaownid,g_prca_m.prcaownid_desc, 
          g_prca_m.prcaowndp,g_prca_m.prcaowndp_desc,g_prca_m.prcamodid,g_prca_m.prcamodid_desc,g_prca_m.prcamoddt, 
          g_prca_m.prcacnfid,g_prca_m.prcacnfid_desc,g_prca_m.prcacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
  
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF                            
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
                                             
   #end add-point  
 
   CLOSE aprt200_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt200_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt200.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt200_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
                                             
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prcb_d.getLength() THEN
         LET g_detail_idx = g_prcb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prcb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prcb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_prcb2_d.getLength() THEN
         LET g_detail_idx2 = g_prcb2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_prcb2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_prcb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
                                             
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt200_b_fill2(pi_idx)
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
   
   IF aprt200_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_prcb_d.getLength() > 0 THEN
               CALL g_prcb2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT prcc001,prcc002,prccacti,prccsite,prccunit ,t3.ooefl003 FROM prcc_t", 
                 
                     "",
                                    " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=prcc002 AND t3.ooefl002='"||g_dlang||"' ",
 
                     " WHERE prccent=? AND prccdocno=? AND prccseq=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  prcc_t.prcc001,prcc_t.prcc002" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
                                                                                                                                       
         #end add-point
         
         #先清空資料
               CALL g_prcb2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt200_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR aprt200_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_prca_m.prcadocno,g_prcb_d[g_detail_idx].prcbseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_prca_m.prcadocno,g_prcb_d[g_detail_idx].prcbseq INTO g_prcb2_d[l_ac].prcc001, 
             g_prcb2_d[l_ac].prcc002,g_prcb2_d[l_ac].prccacti,g_prcb2_d[l_ac].prccsite,g_prcb2_d[l_ac].prccunit, 
             g_prcb2_d[l_ac].prcc002_desc   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
                                                                                                                                                CALL aprt200_prcc_desc()                               
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_prcb2_d.deleteElement(g_prcb2_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_prcb2_d_mask_o.* =  g_prcb2_d.*
   FOR l_ac = 1 TO g_prcb2_d.getLength()
      LET g_prcb2_d_mask_o[l_ac].* =  g_prcb2_d[l_ac].*
      CALL aprt200_prcc_t_mask()
      LET g_prcb2_d_mask_n[l_ac].* =  g_prcb2_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
                                             
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aprt200_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt200_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
                                                                                          
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprt200.status_show" >}
PRIVATE FUNCTION aprt200_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt200.mask_functions" >}
&include "erp/apr/aprt200_mask.4gl"
 
{</section>}
 
{<section id="aprt200.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt200_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aprt200_show()
   CALL aprt200_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt200_conf_chk(g_prca_m.prcadocno,g_prca_m.prcastus) RETURNING l_success,g_errno
   IF NOT l_success THEN
      CLOSE aprt200_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prca_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prcb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_prcb2_d))
 
 
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
   #CALL aprt200_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt200_ui_headershow()
   CALL aprt200_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt200_draw_out()
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
   CALL aprt200_ui_headershow()  
   CALL aprt200_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt200.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt200_set_pk_array()
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
   LET g_pk_array[1].values = g_prca_m.prcadocno
   LET g_pk_array[1].column = 'prcadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt200.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt200.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt200_msgcentre_notify(lc_state)
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
   CALL aprt200_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prca_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt200.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt200_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#30 add-S
   SELECT prcastus  INTO g_prca_m.prcastus
     FROM prca_t
    WHERE prcaent = g_enterprise
      AND prcadocno = g_prca_m.prcadocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prca_m.prcastus
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
        LET g_errparam.extend = g_prca_m.prcadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt200_set_act_visible()
        CALL aprt200_set_act_no_visible()
        CALL aprt200_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#30 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt200.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 活動計劃帶值
# Memo...........:
# Usage..........: CALL aprt200_prcb001_def()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/05 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt200_prcb001_def()
 
   SELECT prcd002,prcd003,prcd004,prcd005,prcd006,prcd007,prcdstus
     INTO g_prcb_d[l_ac].prcb002,g_prcb_d[l_ac].prcb003,g_prcb_d[l_ac].prcb004,g_prcb_d[l_ac].prcb005,g_prcb_d[l_ac].prcb006,g_prcb_d[l_ac].prcb007,g_prcb_d[l_ac].prcbacti
     FROM prcd_t
    WHERE prcdent = g_enterprise
      AND prcd001 = g_prcb_d[l_ac].prcb001
   SELECT prcdl003,prcdl004 INTO g_prcb_d[l_ac].prcbl002,g_prcb_d[l_ac].prcbl003
     FROM prcdl_t
    WHERE prcdlent = g_enterprise
      AND prcdl001 = g_prcb_d[l_ac].prcb001
      AND prcdl002 = g_dlang
   CALL aprt200_prcb_desc()
END FUNCTION
################################################################################
# Descriptions...: 單頭參考欄位顯示
# Memo...........:
# Usage..........: CALL aprt200_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/04 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt200_desc()
   LET g_prca_m.prca002_desc =''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prca_m.prca002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prca_m.prca002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prca_m.prca002_desc
   
   LET g_prca_m.prca003_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prca_m.prca003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
   LET g_prca_m.prca003_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prca_m.prca003_desc
   
  #LET g_prca_m.prcaunit_desc = ''
  #INITIALIZE g_ref_fields TO NULL
  #LET g_ref_fields[1] = g_prca_m.prcaunit
  #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
  #LET g_prca_m.prcaunit_desc = g_rtn_fields[1]
  #DISPLAY BY NAME g_prca_m.prcaunit_desc
   
   #ken---add---str 需求單號：141208-00001 項次：22
   LET g_prca_m.prcasite_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prca_m.prcasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
   LET g_prca_m.prcasite_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prca_m.prcasite_desc   
   #ken---add---end
END FUNCTION
################################################################################
# Descriptions...: 活動頁簽參考欄位顯示
# Memo...........:
# Usage..........: CALL aprt200_prcb_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/05 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt200_prcb_desc()
   LET g_prcb_d[l_ac].prcb002_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prcb_d[l_ac].prcb002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002 = ? AND oocql003 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
   LET g_prcb_d[l_ac].prcb002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prcb_d[l_ac].prcb002_desc
   
   LET g_prcb_d[l_ac].prcb003_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prcb_d[l_ac].prcb003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002 = ? AND oocql003 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
   LET g_prcb_d[l_ac].prcb003_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prcb_d[l_ac].prcb003_desc
END FUNCTION
################################################################################
# Descriptions...: 申請類型為新增時活動計劃檢查
# Memo...........:
# Usage..........: CALL aprt200_chk_prcb001()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/05 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt200_chk_prcb001()
DEFINE l_n       LIKE type_t.num5

   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM prcd_t
    WHERE prcdent = g_enterprise
      AND prcd001 = g_prcb_d[l_ac].prcb001
   IF l_n > 0 THEN
      LET g_errno = 'apr-00005'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 生效組織頁簽帶值
# Memo...........:
# Usage..........: CALL aprt200_prcc_desc() 
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/05 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt200_prcc_desc()
   LET g_prcb2_d[l_ac].prcc002_desc = ''
   IF g_prcb2_d[l_ac].prcc001 = '1' THEN
      SELECT rtaal003 INTO g_prcb2_d[l_ac].prcc002_desc
        FROM rtaal_t
       WHERE rtaalent = g_enterprise
         AND rtaal001 = g_prcb2_d[l_ac].prcc002
         AND rtaal002 = g_dlang
   ELSE
      SELECT ooefl003 INTO g_prcb2_d[l_ac].prcc002_desc
        FROM ooefl_t
       WHERE ooeflent = g_enterprise
         AND ooefl001 = g_prcb2_d[l_ac].prcc002
         AND ooefl002 = g_dlang
   END IF
END FUNCTION
################################################################################
# Descriptions...: 店群/門店檢查
# Memo...........:
# Usage..........: CALL aprt200_chk_prcc002()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/05 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt200_chk_prcc002()
DEFINE l_n       LIKE type_t.num5
DEFINE l_sql     STRING
DEFINE l_success LIKE type_t.num5
DEFINE l_errno   LIKE type_t.chr10

   LET g_errno = ''
   IF g_prcb2_d[l_ac].prcc001 = '1' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prcb2_d[l_ac].prcc002
      IF l_n = 0 THEN
         LET g_errno = 'apr-00006'
         RETURN
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prcb2_d[l_ac].prcc002
         AND rtaastus = 'Y'
      IF l_n = 0 THEN
         LET g_errno = 'sub-01302'   #apr-00007  #160318-00005#40 by 07900 --mod
         RETURN
      END IF
      #20150603--huangrh add--rtak-
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtaa_t,rtak_t
       WHERE rtaaent = g_enterprise
         AND rtaa001 = g_prcb2_d[l_ac].prcc002
         AND rtaastus = 'Y'
         AND rtakent=rtaaent
         AND rtak001=rtaa001
         AND rtak002='4'
         AND rtak003='Y'           
      IF l_n = 0 THEN
         LET g_errno = 'apr-00008'
         RETURN
      END IF
   
#      LET l_n = 0
#      LET l_sql = "SELECT COUNT(*) ",
#                  "  FROM rtaa_t,rtab_t",
#                  " WHERE rtaaent = '",g_enterprise,"'",
#                  "   AND rtaa001 = '",g_prcb2_d[l_ac].prcc002,"'",
#                  "   AND rtaastus = 'Y'",
#                  "   AND rtaa002 = '4'",
#                  "   AND rtaaent = rtabent",
#                  "   AND rtaa001 = rtab001",
#                  "   AND rtab002 NOT IN (SELECT ooed004 FROM ooed_t ",
#                  "                    START WITH ooed005 = '",g_site,"'",
#                  "                      AND ooed001='8'", 
#                  "                      AND ooed006<= '",g_today,"'", 
#                  "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
#                  "                    CONNECT BY  nocycle PRIOR ooed004=ooed005 ",
#                  "                      AND ooed001='8' ",
#                  "                      AND ooed006<= '",g_today,"'", 
#                  "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
#                  "                    UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = '",g_site,"' )"
#      PREPARE aprt200_sel_rtaa_pr FROM l_sql
#      EXECUTE aprt200_sel_rtaa_pr INTO l_n
#      IF l_n > 0 THEN
#         LET g_errno = 'apr-00066'
#         RETURN
#      END IF
      IF s_aooi500_setpoint(g_prog,'prcc002') THEN
         CALL s_aooi500_shop_group_chk(g_prog,'prcc002',g_prcb2_d[l_ac].prcc002,g_prca_m.prcaunit)
            RETURNING l_success,l_errno
         IF NOT l_success THEN
            LET g_errno = l_errno
            RETURN
         END IF
      ELSE
         LET l_n = 0
         #20150603--huangrh add--rtak-
         LET l_sql = "SELECT COUNT(*) ",
                     "  FROM rtaa_t,rtab_t,rtak_t",
                     " WHERE rtaaent = '",g_enterprise,"'",
                     "   AND rtaa001 = '",g_prcb2_d[l_ac].prcc002,"'",
                     "   AND rtaastus = 'Y'",
                     "   AND rtakent=rtaaent",
                     "   AND rtak001=rtaa001",
                     "   AND rtak002='4'",
                     "   AND rtak003='Y' ",  
                     "   AND rtaaent = rtabent",
                     "   AND rtaa001 = rtab001",
                     #"   AND rtab002 NOT IN (SELECT ooed004 FROM ooed_t ",   #160905-00007#12  mark
                     "   AND rtab002 IN (SELECT ooed004 FROM ooed_t WHERE ooedent=",g_enterprise,    #160905-00007#12  add
                     "                    START WITH ooed005 = '",g_site,"'",
                     "                      AND ooed001='8'", 
                     "                      AND ooed006<= '",g_today,"'", 
                     "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
                     "                    CONNECT BY  nocycle PRIOR ooed004=ooed005 ",
                     "                      AND ooed001='8' ",
                     "                      AND ooed006<= '",g_today,"'", 
                     "                      AND (ooed007>= '",g_today,"' OR ooed007 IS NULL)",
                     #"                    UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = '",g_site,"' )"  #160905-00007#12  mark
                     "                    UNION SELECT ooed004 FROM ooed_t WHERE ooedent = ",g_enterprise," AND ooed004='",g_site,"' )"      #160905-00007#12  add
         PREPARE aprt200_sel_rtaa_pr FROM l_sql
         EXECUTE aprt200_sel_rtaa_pr INTO l_n
         IF l_n > 0 THEN
            LET g_errno = 'apr-00066'
            RETURN
         END IF
      END IF
   END IF
   IF g_prcb2_d[l_ac].prcc001 = '1' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtab_t
       WHERE rtabent = g_enterprise
         AND rtab002 IN (SELECT prcc002 FROM prcc_t 
                          WHERE prccent = g_enterprise
                            AND prccdocno = g_prca_m.prcadocno
                            AND prccseq = g_prcb_d[g_detail_idx].prcbseq
                            AND prcc001 = '2')
         AND rtab001 = g_prcb2_d[l_ac].prcc002
      IF l_n > 0 THEN
         LET g_errno = 'apr-00014'
         RETURN
      END IF
   END IF
   IF g_prcb2_d[l_ac].prcc001 = '2' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prcc_t
       WHERE prccent = g_enterprise
         AND prccdocno = g_prca_m.prcadocno
         AND prccseq = g_prcb_d[g_detail_idx].prcbseq
         AND prcc002 IN (SELECT rtab001 FROM rtab_t 
                          WHERE rtabent = g_enterprise
                            AND rtab002 = g_prcb2_d[l_ac].prcc002)
         AND prcc001 = '1'
      IF l_n > 0 THEN
         LET g_errno = 'apr-00013'
         RETURN
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 帶出生效組織的內容
# Memo...........:
# Usage..........: CALL aprt200_ins_prcc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/03/05 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt200_ins_prcc()
   IF g_prca_m.prca001 = 'I' THEN
      IF g_prcb_d[l_ac].prcbseq > 1 THEN
         DELETE FROM prcc_t
          WHERE prccent = g_enterprise
            AND prccdocno = g_prca_m.prcadocno
            AND prccseq = g_prcb_d[l_ac].prcbseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'del_prcc'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
         INSERT INTO prcc_t(prccent,prccdocno,prccseq,prcc001,prcc002,prccacti,prccsite,prccunit) 
         SELECT prccent,prccdocno,g_prcb_d[l_ac].prcbseq,prcc001,prcc002,prccacti,prccsite,prccunit
           FROM prcc_t
          WHERE prccent = g_enterprise
            AND prccdocno = g_prca_m.prcadocno
            AND prccseq = g_prcb_d[l_ac].prcbseq - 1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins_prcc'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF
   ELSE
      DELETE FROM prcc_t
       WHERE prccent = g_enterprise
         AND prccdocno = g_prca_m.prcadocno
         AND prccseq = g_prcb_d[l_ac].prcbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'del_prcc'
            LET g_errparam.popup = TRUE
            CALL cl_err()

         RETURN FALSE
      END IF
      INSERT INTO prcc_t(prccent,prccdocno,prccseq,prcc001,prcc002,prccacti,prccsite,prccunit) 
      SELECT prceent,g_prca_m.prcadocno,g_prcb_d[l_ac].prcbseq,prce002,prce003,prceacti,prcesite,prceunit
        FROM prce_t
       WHERE prceent = g_enterprise
         AND prce001 = g_prcb_d[l_ac].prcb001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins_prcc'
            LET g_errparam.popup = TRUE
            CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

 
{</section>}
 
