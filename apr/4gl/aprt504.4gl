#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt504.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-03-09 14:07:04), PR版次:0011(2016-11-01 15:54:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000091
#+ Filename...: aprt504
#+ Description: 內部交易定價調整申請作業
#+ Creator....: ()
#+ Modifier...: 02749 -SD/PR- 06814
 
{</section>}
 
{<section id="aprt504.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
# Modify......: NO.160318-00025#15   2016/04/06   BY 07900     重复错误讯息的修改
# Modify......: NO.160816-00068#13   2016/08/17   By 08209     調整transaction
# Modify......: NO.160818-00017#31   2016/08/30   By 08742     删除修改未重新判断状态码
#161024-00025#1 2016/10/24 By dongsz   prfk002编辑开窗改为q_ooef001_24,条件：ooef201='Y'；对应栏位检查同步修改
#160824-00007#151 20161101 By 06814    新舊值相關
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
PRIVATE type type_g_prfi_m        RECORD
       prfisite LIKE prfi_t.prfisite, 
   prfisite_desc LIKE type_t.chr80, 
   prfidocdt LIKE prfi_t.prfidocdt, 
   prfidocno LIKE prfi_t.prfidocno, 
   prfi001 LIKE prfi_t.prfi001, 
   prfiunit LIKE prfi_t.prfiunit, 
   prfiunit_desc LIKE type_t.chr80, 
   prfi002 LIKE prfi_t.prfi002, 
   prfi002_desc LIKE type_t.chr80, 
   prfi003 LIKE prfi_t.prfi003, 
   prfi003_desc LIKE type_t.chr80, 
   prfi004 LIKE prfi_t.prfi004, 
   prfi005 LIKE prfi_t.prfi005, 
   prfi006 LIKE prfi_t.prfi006, 
   prfi006_desc LIKE type_t.chr80, 
   prfi007 LIKE prfi_t.prfi007, 
   prfi007_desc LIKE type_t.chr80, 
   prfistus LIKE prfi_t.prfistus, 
   prfiownid LIKE prfi_t.prfiownid, 
   prfiownid_desc LIKE type_t.chr80, 
   prfiowndp LIKE prfi_t.prfiowndp, 
   prfiowndp_desc LIKE type_t.chr80, 
   prficrtid LIKE prfi_t.prficrtid, 
   prficrtid_desc LIKE type_t.chr80, 
   prficrtdp LIKE prfi_t.prficrtdp, 
   prficrtdp_desc LIKE type_t.chr80, 
   prficrtdt LIKE prfi_t.prficrtdt, 
   prfimodid LIKE prfi_t.prfimodid, 
   prfimodid_desc LIKE type_t.chr80, 
   prfimoddt LIKE prfi_t.prfimoddt, 
   prficnfid LIKE prfi_t.prficnfid, 
   prficnfid_desc LIKE type_t.chr80, 
   prficnfdt LIKE prfi_t.prficnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prfj_d        RECORD
       prfjseq LIKE prfj_t.prfjseq, 
   prfj001 LIKE prfj_t.prfj001, 
   prfj001_desc LIKE type_t.chr500, 
   prfjsite LIKE prfj_t.prfjsite, 
   prfjunit LIKE prfj_t.prfjunit
       END RECORD
PRIVATE TYPE type_g_prfj2_d RECORD
       prfkseq LIKE prfk_t.prfkseq, 
   prfk001 LIKE prfk_t.prfk001, 
   prfk002 LIKE prfk_t.prfk002, 
   prfk002_desc LIKE type_t.chr500, 
   prfksite LIKE prfk_t.prfksite, 
   prfkunit LIKE prfk_t.prfkunit
       END RECORD
PRIVATE TYPE type_g_prfj3_d RECORD
       prflseq LIKE prfl_t.prflseq, 
   prfl014 LIKE prfl_t.prfl014, 
   prfl001 LIKE prfl_t.prfl001, 
   prfl001_desc LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   prfl002 LIKE prfl_t.prfl002, 
   prfl002_desc LIKE type_t.chr500, 
   prfl003 LIKE prfl_t.prfl003, 
   prfl003_desc LIKE type_t.chr500, 
   prfl004 LIKE prfl_t.prfl004, 
   prfl005 LIKE prfl_t.prfl005, 
   prfl006 LIKE prfl_t.prfl006, 
   prfl006_desc LIKE type_t.chr500, 
   prfl007 LIKE prfl_t.prfl007, 
   prfl008 LIKE prfl_t.prfl008, 
   prfl009 LIKE prfl_t.prfl009, 
   prfl010 LIKE prfl_t.prfl010, 
   prfl011 LIKE prfl_t.prfl011, 
   prfl012 LIKE prfl_t.prfl012, 
   prfl013 LIKE prfl_t.prfl013, 
   prflsite LIKE prfl_t.prflsite, 
   prflunit LIKE prfl_t.prflunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prfisite LIKE prfi_t.prfisite,
   b_prfisite_desc LIKE type_t.chr80,
      b_prfidocdt LIKE prfi_t.prfidocdt,
      b_prfidocno LIKE prfi_t.prfidocno,
      b_prfi001 LIKE prfi_t.prfi001,
      b_prfiunit LIKE prfi_t.prfiunit,
   b_prfiunit_desc LIKE type_t.chr80,
      b_prfi002 LIKE prfi_t.prfi002,
   b_prfi002_desc LIKE type_t.chr80,
      b_prfi003 LIKE prfi_t.prfi003,
   b_prfi003_desc LIKE type_t.chr80,
      b_prfi004 LIKE prfi_t.prfi004,
      b_prfi005 LIKE prfi_t.prfi005,
      b_prfi006 LIKE prfi_t.prfi006,
   b_prfi006_desc LIKE type_t.chr80,
      b_prfi007 LIKE prfi_t.prfi007,
   b_prfi007_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_prfj3_d_colour DYNAMIC ARRAY OF RECORD
   prflseq      STRING, 
   prfl001      STRING, 
   prfl001_desc STRING, 
   imaal004     STRING, 
   prfl002      STRING, 
   prfl002_desc STRING, 
   prfl003      STRING, 
   prfl003_desc STRING, 
   prfl004      STRING, 
   prfl005      STRING, 
   prfl006      STRING, 
   prfl006_desc STRING, 
   prfl007      STRING, 
   prfl008      STRING, 
   prfl009      STRING, 
   prfl010      STRING, 
   prfl011      STRING, 
   prfl012      STRING, 
   prfl013      STRING, 
   prflsite     STRING, 
   prflunit     STRING
       END RECORD
DEFINE g_site_flag      LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prfi_m          type_g_prfi_m
DEFINE g_prfi_m_t        type_g_prfi_m
DEFINE g_prfi_m_o        type_g_prfi_m
DEFINE g_prfi_m_mask_o   type_g_prfi_m #轉換遮罩前資料
DEFINE g_prfi_m_mask_n   type_g_prfi_m #轉換遮罩後資料
 
   DEFINE g_prfidocno_t LIKE prfi_t.prfidocno
 
 
DEFINE g_prfj_d          DYNAMIC ARRAY OF type_g_prfj_d
DEFINE g_prfj_d_t        type_g_prfj_d
DEFINE g_prfj_d_o        type_g_prfj_d
DEFINE g_prfj_d_mask_o   DYNAMIC ARRAY OF type_g_prfj_d #轉換遮罩前資料
DEFINE g_prfj_d_mask_n   DYNAMIC ARRAY OF type_g_prfj_d #轉換遮罩後資料
DEFINE g_prfj2_d          DYNAMIC ARRAY OF type_g_prfj2_d
DEFINE g_prfj2_d_t        type_g_prfj2_d
DEFINE g_prfj2_d_o        type_g_prfj2_d
DEFINE g_prfj2_d_mask_o   DYNAMIC ARRAY OF type_g_prfj2_d #轉換遮罩前資料
DEFINE g_prfj2_d_mask_n   DYNAMIC ARRAY OF type_g_prfj2_d #轉換遮罩後資料
DEFINE g_prfj3_d          DYNAMIC ARRAY OF type_g_prfj3_d
DEFINE g_prfj3_d_t        type_g_prfj3_d
DEFINE g_prfj3_d_o        type_g_prfj3_d
DEFINE g_prfj3_d_mask_o   DYNAMIC ARRAY OF type_g_prfj3_d #轉換遮罩前資料
DEFINE g_prfj3_d_mask_n   DYNAMIC ARRAY OF type_g_prfj3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
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
 
{<section id="aprt504.main" >}
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
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_site
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT prfisite,'',prfidocdt,prfidocno,prfi001,prfiunit,'',prfi002,'',prfi003, 
       '',prfi004,prfi005,prfi006,'',prfi007,'',prfistus,prfiownid,'',prfiowndp,'',prficrtid,'',prficrtdp, 
       '',prficrtdt,prfimodid,'',prfimoddt,prficnfid,'',prficnfdt", 
                      " FROM prfi_t",
                      " WHERE prfient= ? AND prfidocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt504_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prfisite,t0.prfidocdt,t0.prfidocno,t0.prfi001,t0.prfiunit,t0.prfi002, 
       t0.prfi003,t0.prfi004,t0.prfi005,t0.prfi006,t0.prfi007,t0.prfistus,t0.prfiownid,t0.prfiowndp, 
       t0.prficrtid,t0.prficrtdp,t0.prficrtdt,t0.prfimodid,t0.prfimoddt,t0.prficnfid,t0.prficnfdt,t1.ooefl003 , 
       t2.ooefl003 ,t3.ooail003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooag011",
               " FROM prfi_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfisite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.prfiunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.prfi002 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prfi006  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prfi007 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.prfiownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.prfiowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.prficrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.prficrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.prfimodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.prficnfid  ",
 
               " WHERE t0.prfient = " ||g_enterprise|| " AND t0.prfidocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt504_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt504 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt504_init()   
 
      #進入選單 Menu (="N")
      CALL aprt504_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt504
      
   END IF 
   
   CLOSE aprt504_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt504.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt504_init()
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
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('prfistus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prfi001','6042') 
   CALL cl_set_combo_scc('prfk001','6043') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   
   CALL cl_set_combo_scc_part('b_prfi001','6042','2')
   #end add-point
   
   #初始化搜尋條件
   CALL aprt504_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt504.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt504_ui_dialog()
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
            CALL aprt504_insert()
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
         INITIALIZE g_prfi_m.* TO NULL
         CALL g_prfj_d.clear()
         CALL g_prfj2_d.clear()
         CALL g_prfj3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt504_init()
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
               
               CALL aprt504_fetch('') # reload data
               LET l_ac = 1
               CALL aprt504_ui_detailshow() #Setting the current row 
         
               CALL aprt504_idx_chk()
               #NEXT FIELD prfjseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prfj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt504_idx_chk()
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
               CALL aprt504_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_prfj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt504_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aprt504_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_prfj3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt504_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aprt504_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               CALL DIALOG.setCellAttributes(g_prfj3_d_colour)    #参数：屏幕变量,属性数组 
               CALL DIALOG.setArrayAttributes("s_detail3",g_prfj3_d_colour)    #参数：屏幕变量,属性数组
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aprt504_browser_fill("")
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
               CALL aprt504_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt504_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt504_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt504_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt504_set_act_visible()   
            CALL aprt504_set_act_no_visible()
            IF NOT (g_prfi_m.prfidocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prfient = " ||g_enterprise|| " AND",
                                  " prfidocno = '", g_prfi_m.prfidocno, "' "
 
               #填到對應位置
               CALL aprt504_browser_fill("")
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
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "prfi_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prfj_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prfk_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prfl_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aprt504_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "prfi_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prfj_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prfk_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prfl_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aprt504_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt504_fetch("F")
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
               CALL aprt504_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt504_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt504_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt504_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt504_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt504_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt504_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt504_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt504_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt504_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt504_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prfj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_prfj2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_prfj3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               NEXT FIELD prfjseq
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
               CALL aprt504_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt504_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt504_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt504_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apr/aprt504_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apr/aprt504_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aprt504_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt504_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt504_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt504_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt504_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prfi_m.prfidocdt)
 
 
 
         
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
 
{<section id="aprt504.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt504_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ooef019         LIKE ooef_t.ooef019
   DEFINE l_where           STRING
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
   CALL s_aooi500_sql_where(g_prog,'prfisite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prfidocno ",
                      " FROM prfi_t ",
                      " ",
                      " LEFT JOIN prfj_t ON prfjent = prfient AND prfidocno = prfjdocno ", "  ",
                      #add-point:browser_fill段sql(prfj_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN prfk_t ON prfkent = prfient AND prfidocno = prfkdocno", "  ",
                      #add-point:browser_fill段sql(prfk_t1) name="browser_fill.cnt.join.prfk_t1"
                      
                      #end add-point
 
                      " LEFT JOIN prfl_t ON prflent = prfient AND prfidocno = prfldocno", "  ",
                      #add-point:browser_fill段sql(prfl_t1) name="browser_fill.cnt.join.prfl_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE prfient = " ||g_enterprise|| " AND prfjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prfi_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prfidocno ",
                      " FROM prfi_t ", 
                      "  ",
                      "  ",
                      " WHERE prfient = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prfi_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND prfi001 = '2' "
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
      INITIALIZE g_prfi_m.* TO NULL
      CALL g_prfj_d.clear()        
      CALL g_prfj2_d.clear() 
      CALL g_prfj3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prfisite,t0.prfidocdt,t0.prfidocno,t0.prfi001,t0.prfiunit,t0.prfi002,t0.prfi003,t0.prfi004,t0.prfi005,t0.prfi006,t0.prfi007 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prfistus,t0.prfisite,t0.prfidocdt,t0.prfidocno,t0.prfi001,t0.prfiunit, 
          t0.prfi002,t0.prfi003,t0.prfi004,t0.prfi005,t0.prfi006,t0.prfi007,t1.ooefl003 ,t2.ooefl003 , 
          t3.ooail003 ,t4.ooag011 ,t5.ooefl003 ",
                  " FROM prfi_t t0",
                  "  ",
                  "  LEFT JOIN prfj_t ON prfjent = prfient AND prfidocno = prfjdocno ", "  ", 
                  #add-point:browser_fill段sql(prfj_t1) name="browser_fill.join.prfj_t1"
                  
                  #end add-point
                  "  LEFT JOIN prfk_t ON prfkent = prfient AND prfidocno = prfkdocno", "  ", 
                  #add-point:browser_fill段sql(prfk_t1) name="browser_fill.join.prfk_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN prfl_t ON prflent = prfient AND prfidocno = prfldocno", "  ", 
                  #add-point:browser_fill段sql(prfl_t1) name="browser_fill.join.prfl_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfisite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.prfiunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.prfi002 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prfi006  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prfi007 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prfient = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prfi_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prfistus,t0.prfisite,t0.prfidocdt,t0.prfidocno,t0.prfi001,t0.prfiunit, 
          t0.prfi002,t0.prfi003,t0.prfi004,t0.prfi005,t0.prfi006,t0.prfi007,t1.ooefl003 ,t2.ooefl003 , 
          t3.ooail003 ,t4.ooag011 ,t5.ooefl003 ",
                  " FROM prfi_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prfisite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.prfiunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.prfi002 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.prfi006  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.prfi007 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prfient = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prfi_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND prfi001 = '2' "
   #end add-point
   LET g_sql = g_sql, " ORDER BY prfidocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prfi_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prfisite,g_browser[g_cnt].b_prfidocdt, 
          g_browser[g_cnt].b_prfidocno,g_browser[g_cnt].b_prfi001,g_browser[g_cnt].b_prfiunit,g_browser[g_cnt].b_prfi002, 
          g_browser[g_cnt].b_prfi003,g_browser[g_cnt].b_prfi004,g_browser[g_cnt].b_prfi005,g_browser[g_cnt].b_prfi006, 
          g_browser[g_cnt].b_prfi007,g_browser[g_cnt].b_prfisite_desc,g_browser[g_cnt].b_prfiunit_desc, 
          g_browser[g_cnt].b_prfi002_desc,g_browser[g_cnt].b_prfi006_desc,g_browser[g_cnt].b_prfi007_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_browser[g_cnt].b_prfisite 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_ooef019
      LET g_ref_fields[2] = g_browser[g_cnt].b_prfi003
      CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_prfi003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_prfi003_desc
         #end add-point
      
         #遮罩相關處理
         CALL aprt504_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_prfidocno) THEN
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
 
{<section id="aprt504.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt504_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prfi_m.prfidocno = g_browser[g_current_idx].b_prfidocno   
 
   EXECUTE aprt504_master_referesh USING g_prfi_m.prfidocno INTO g_prfi_m.prfisite,g_prfi_m.prfidocdt, 
       g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004, 
       g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiowndp, 
       g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfdt,g_prfi_m.prfisite_desc,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002_desc, 
       g_prfi_m.prfi006_desc,g_prfi_m.prfi007_desc,g_prfi_m.prfiownid_desc,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid_desc, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prfimodid_desc,g_prfi_m.prficnfid_desc
   
   CALL aprt504_prfi_t_mask()
   CALL aprt504_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt504.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt504_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt504_ui_browser_refresh()
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
      IF g_browser[l_i].b_prfidocno = g_prfi_m.prfidocno 
 
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
 
{<section id="aprt504.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt504_construct()
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
   INITIALIZE g_prfi_m.* TO NULL
   CALL g_prfj_d.clear()        
   CALL g_prfj2_d.clear() 
   CALL g_prfj3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON prfisite,prfidocdt,prfidocno,prfi001,prfiunit,prfi002,prfi003,prfi004, 
          prfi005,prfi006,prfi007,prfistus,prfiownid,prfiowndp,prficrtid,prficrtdp,prficrtdt,prfimodid, 
          prfimoddt,prficnfid,prficnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prficrtdt>>----
         AFTER FIELD prficrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prfimoddt>>----
         AFTER FIELD prfimoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prficnfdt>>----
         AFTER FIELD prficnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prfipstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prfisite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfisite
            #add-point:ON ACTION controlp INFIELD prfisite name="construct.c.prfisite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfisite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prfisite  #顯示到畫面上
            NEXT FIELD prfisite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfisite
            #add-point:BEFORE FIELD prfisite name="construct.b.prfisite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfisite
            
            #add-point:AFTER FIELD prfisite name="construct.a.prfisite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfidocdt
            #add-point:BEFORE FIELD prfidocdt name="construct.b.prfidocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfidocdt
            
            #add-point:AFTER FIELD prfidocdt name="construct.a.prfidocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfidocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfidocdt
            #add-point:ON ACTION controlp INFIELD prfidocdt name="construct.c.prfidocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfidocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfidocno
            #add-point:ON ACTION controlp INFIELD prfidocno name="construct.c.prfidocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " prfi001 = '2' "   #dongsz add
            CALL q_prfidocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfidocno  #顯示到畫面上
            NEXT FIELD prfidocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfidocno
            #add-point:BEFORE FIELD prfidocno name="construct.b.prfidocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfidocno
            
            #add-point:AFTER FIELD prfidocno name="construct.a.prfidocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi001
            #add-point:BEFORE FIELD prfi001 name="construct.b.prfi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi001
            
            #add-point:AFTER FIELD prfi001 name="construct.a.prfi001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi001
            #add-point:ON ACTION controlp INFIELD prfi001 name="construct.c.prfi001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfiunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfiunit
            #add-point:ON ACTION controlp INFIELD prfiunit name="construct.c.prfiunit"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfiunit',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prfiunit  #顯示到畫面上
            NEXT FIELD prfiunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfiunit
            #add-point:BEFORE FIELD prfiunit name="construct.b.prfiunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfiunit
            
            #add-point:AFTER FIELD prfiunit name="construct.a.prfiunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi002
            #add-point:ON ACTION controlp INFIELD prfi002 name="construct.c.prfi002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_3()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfi002  #顯示到畫面上
            NEXT FIELD prfi002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi002
            #add-point:BEFORE FIELD prfi002 name="construct.b.prfi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi002
            
            #add-point:AFTER FIELD prfi002 name="construct.a.prfi002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi003
            #add-point:ON ACTION controlp INFIELD prfi003 name="construct.c.prfi003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfi003  #顯示到畫面上
            NEXT FIELD prfi003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi003
            #add-point:BEFORE FIELD prfi003 name="construct.b.prfi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi003
            
            #add-point:AFTER FIELD prfi003 name="construct.a.prfi003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi004
            #add-point:BEFORE FIELD prfi004 name="construct.b.prfi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi004
            
            #add-point:AFTER FIELD prfi004 name="construct.a.prfi004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi004
            #add-point:ON ACTION controlp INFIELD prfi004 name="construct.c.prfi004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi005
            #add-point:BEFORE FIELD prfi005 name="construct.b.prfi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi005
            
            #add-point:AFTER FIELD prfi005 name="construct.a.prfi005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfi005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi005
            #add-point:ON ACTION controlp INFIELD prfi005 name="construct.c.prfi005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfi006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi006
            #add-point:ON ACTION controlp INFIELD prfi006 name="construct.c.prfi006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfi006  #顯示到畫面上
            NEXT FIELD prfi006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi006
            #add-point:BEFORE FIELD prfi006 name="construct.b.prfi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi006
            
            #add-point:AFTER FIELD prfi006 name="construct.a.prfi006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfi007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi007
            #add-point:ON ACTION controlp INFIELD prfi007 name="construct.c.prfi007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfi007  #顯示到畫面上
            NEXT FIELD prfi007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi007
            #add-point:BEFORE FIELD prfi007 name="construct.b.prfi007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi007
            
            #add-point:AFTER FIELD prfi007 name="construct.a.prfi007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfistus
            #add-point:BEFORE FIELD prfistus name="construct.b.prfistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfistus
            
            #add-point:AFTER FIELD prfistus name="construct.a.prfistus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfistus
            #add-point:ON ACTION controlp INFIELD prfistus name="construct.c.prfistus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfiownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfiownid
            #add-point:ON ACTION controlp INFIELD prfiownid name="construct.c.prfiownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfiownid  #顯示到畫面上
            NEXT FIELD prfiownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfiownid
            #add-point:BEFORE FIELD prfiownid name="construct.b.prfiownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfiownid
            
            #add-point:AFTER FIELD prfiownid name="construct.a.prfiownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prfiowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfiowndp
            #add-point:ON ACTION controlp INFIELD prfiowndp name="construct.c.prfiowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfiowndp  #顯示到畫面上
            NEXT FIELD prfiowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfiowndp
            #add-point:BEFORE FIELD prfiowndp name="construct.b.prfiowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfiowndp
            
            #add-point:AFTER FIELD prfiowndp name="construct.a.prfiowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prficrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prficrtid
            #add-point:ON ACTION controlp INFIELD prficrtid name="construct.c.prficrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prficrtid  #顯示到畫面上
            NEXT FIELD prficrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prficrtid
            #add-point:BEFORE FIELD prficrtid name="construct.b.prficrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prficrtid
            
            #add-point:AFTER FIELD prficrtid name="construct.a.prficrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prficrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prficrtdp
            #add-point:ON ACTION controlp INFIELD prficrtdp name="construct.c.prficrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prficrtdp  #顯示到畫面上
            NEXT FIELD prficrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prficrtdp
            #add-point:BEFORE FIELD prficrtdp name="construct.b.prficrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prficrtdp
            
            #add-point:AFTER FIELD prficrtdp name="construct.a.prficrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prficrtdt
            #add-point:BEFORE FIELD prficrtdt name="construct.b.prficrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prfimodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfimodid
            #add-point:ON ACTION controlp INFIELD prfimodid name="construct.c.prfimodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfimodid  #顯示到畫面上
            NEXT FIELD prfimodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfimodid
            #add-point:BEFORE FIELD prfimodid name="construct.b.prfimodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfimodid
            
            #add-point:AFTER FIELD prfimodid name="construct.a.prfimodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfimoddt
            #add-point:BEFORE FIELD prfimoddt name="construct.b.prfimoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prficnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prficnfid
            #add-point:ON ACTION controlp INFIELD prficnfid name="construct.c.prficnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prficnfid  #顯示到畫面上
            NEXT FIELD prficnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prficnfid
            #add-point:BEFORE FIELD prficnfid name="construct.b.prficnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prficnfid
            
            #add-point:AFTER FIELD prficnfid name="construct.a.prficnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prficnfdt
            #add-point:BEFORE FIELD prficnfdt name="construct.b.prficnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prfjseq,prfj001,prfjsite,prfjunit
           FROM s_detail1[1].prfjseq,s_detail1[1].prfj001,s_detail1[1].prfjsite,s_detail1[1].prfjunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfjseq
            #add-point:BEFORE FIELD prfjseq name="construct.b.page1.prfjseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfjseq
            
            #add-point:AFTER FIELD prfjseq name="construct.a.page1.prfjseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfjseq
            #add-point:ON ACTION controlp INFIELD prfjseq name="construct.c.page1.prfjseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prfj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfj001
            #add-point:ON ACTION controlp INFIELD prfj001 name="construct.c.page1.prfj001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prfg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfj001  #顯示到畫面上
            NEXT FIELD prfj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfj001
            #add-point:BEFORE FIELD prfj001 name="construct.b.page1.prfj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfj001
            
            #add-point:AFTER FIELD prfj001 name="construct.a.page1.prfj001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfjsite
            #add-point:BEFORE FIELD prfjsite name="construct.b.page1.prfjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfjsite
            
            #add-point:AFTER FIELD prfjsite name="construct.a.page1.prfjsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfjsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfjsite
            #add-point:ON ACTION controlp INFIELD prfjsite name="construct.c.page1.prfjsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfjunit
            #add-point:BEFORE FIELD prfjunit name="construct.b.page1.prfjunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfjunit
            
            #add-point:AFTER FIELD prfjunit name="construct.a.page1.prfjunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prfjunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfjunit
            #add-point:ON ACTION controlp INFIELD prfjunit name="construct.c.page1.prfjunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON prfkseq,prfk001,prfk002,prfksite,prfkunit
           FROM s_detail2[1].prfkseq,s_detail2[1].prfk001,s_detail2[1].prfk002,s_detail2[1].prfksite, 
               s_detail2[1].prfkunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfkseq
            #add-point:BEFORE FIELD prfkseq name="construct.b.page2.prfkseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfkseq
            
            #add-point:AFTER FIELD prfkseq name="construct.a.page2.prfkseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prfkseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfkseq
            #add-point:ON ACTION controlp INFIELD prfkseq name="construct.c.page2.prfkseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfk001
            #add-point:BEFORE FIELD prfk001 name="construct.b.page2.prfk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfk001
            
            #add-point:AFTER FIELD prfk001 name="construct.a.page2.prfk001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prfk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfk001
            #add-point:ON ACTION controlp INFIELD prfk001 name="construct.c.page2.prfk001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.prfk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfk002
            #add-point:ON ACTION controlp INFIELD prfk002 name="construct.c.page2.prfk002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'prfk002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfk002',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO prfk002  #顯示到畫面上
            NEXT FIELD prfk002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfk002
            #add-point:BEFORE FIELD prfk002 name="construct.b.page2.prfk002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfk002
            
            #add-point:AFTER FIELD prfk002 name="construct.a.page2.prfk002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfksite
            #add-point:BEFORE FIELD prfksite name="construct.b.page2.prfksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfksite
            
            #add-point:AFTER FIELD prfksite name="construct.a.page2.prfksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prfksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfksite
            #add-point:ON ACTION controlp INFIELD prfksite name="construct.c.page2.prfksite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfkunit
            #add-point:BEFORE FIELD prfkunit name="construct.b.page2.prfkunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfkunit
            
            #add-point:AFTER FIELD prfkunit name="construct.a.page2.prfkunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prfkunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfkunit
            #add-point:ON ACTION controlp INFIELD prfkunit name="construct.c.page2.prfkunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON prflseq,prfl014,prfl001,prfl002,prfl003,prfl004,prfl005,prfl006,prfl007, 
          prfl008,prfl009,prfl010,prfl011,prfl012,prfl013,prflsite,prflunit
           FROM s_detail3[1].prflseq,s_detail3[1].prfl014,s_detail3[1].prfl001,s_detail3[1].prfl002, 
               s_detail3[1].prfl003,s_detail3[1].prfl004,s_detail3[1].prfl005,s_detail3[1].prfl006,s_detail3[1].prfl007, 
               s_detail3[1].prfl008,s_detail3[1].prfl009,s_detail3[1].prfl010,s_detail3[1].prfl011,s_detail3[1].prfl012, 
               s_detail3[1].prfl013,s_detail3[1].prflsite,s_detail3[1].prflunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prflseq
            #add-point:BEFORE FIELD prflseq name="construct.b.page3.prflseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prflseq
            
            #add-point:AFTER FIELD prflseq name="construct.a.page3.prflseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prflseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prflseq
            #add-point:ON ACTION controlp INFIELD prflseq name="construct.c.page3.prflseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.prfl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl014
            #add-point:ON ACTION controlp INFIELD prfl014 name="construct.c.page3.prfl014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfl014  #顯示到畫面上
            NEXT FIELD prfl014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl014
            #add-point:BEFORE FIELD prfl014 name="construct.b.page3.prfl014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl014
            
            #add-point:AFTER FIELD prfl014 name="construct.a.page3.prfl014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl001
            #add-point:ON ACTION controlp INFIELD prfl001 name="construct.c.page3.prfl001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfl001  #顯示到畫面上
            NEXT FIELD prfl001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl001
            #add-point:BEFORE FIELD prfl001 name="construct.b.page3.prfl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl001
            
            #add-point:AFTER FIELD prfl001 name="construct.a.page3.prfl001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl002
            #add-point:ON ACTION controlp INFIELD prfl002 name="construct.c.page3.prfl002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfl002  #顯示到畫面上
            NEXT FIELD prfl002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl002
            #add-point:BEFORE FIELD prfl002 name="construct.b.page3.prfl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl002
            
            #add-point:AFTER FIELD prfl002 name="construct.a.page3.prfl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl003
            #add-point:ON ACTION controlp INFIELD prfl003 name="construct.c.page3.prfl003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfl003  #顯示到畫面上
            NEXT FIELD prfl003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl003
            #add-point:BEFORE FIELD prfl003 name="construct.b.page3.prfl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl003
            
            #add-point:AFTER FIELD prfl003 name="construct.a.page3.prfl003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl004
            #add-point:BEFORE FIELD prfl004 name="construct.b.page3.prfl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl004
            
            #add-point:AFTER FIELD prfl004 name="construct.a.page3.prfl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl004
            #add-point:ON ACTION controlp INFIELD prfl004 name="construct.c.page3.prfl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl005
            #add-point:BEFORE FIELD prfl005 name="construct.b.page3.prfl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl005
            
            #add-point:AFTER FIELD prfl005 name="construct.a.page3.prfl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl005
            #add-point:ON ACTION controlp INFIELD prfl005 name="construct.c.page3.prfl005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.prfl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl006
            #add-point:ON ACTION controlp INFIELD prfl006 name="construct.c.page3.prfl006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prfl006  #顯示到畫面上
            NEXT FIELD prfl006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl006
            #add-point:BEFORE FIELD prfl006 name="construct.b.page3.prfl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl006
            
            #add-point:AFTER FIELD prfl006 name="construct.a.page3.prfl006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl007
            #add-point:BEFORE FIELD prfl007 name="construct.b.page3.prfl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl007
            
            #add-point:AFTER FIELD prfl007 name="construct.a.page3.prfl007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl007
            #add-point:ON ACTION controlp INFIELD prfl007 name="construct.c.page3.prfl007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl008
            #add-point:BEFORE FIELD prfl008 name="construct.b.page3.prfl008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl008
            
            #add-point:AFTER FIELD prfl008 name="construct.a.page3.prfl008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl008
            #add-point:ON ACTION controlp INFIELD prfl008 name="construct.c.page3.prfl008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl009
            #add-point:BEFORE FIELD prfl009 name="construct.b.page3.prfl009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl009
            
            #add-point:AFTER FIELD prfl009 name="construct.a.page3.prfl009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl009
            #add-point:ON ACTION controlp INFIELD prfl009 name="construct.c.page3.prfl009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl010
            #add-point:BEFORE FIELD prfl010 name="construct.b.page3.prfl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl010
            
            #add-point:AFTER FIELD prfl010 name="construct.a.page3.prfl010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl010
            #add-point:ON ACTION controlp INFIELD prfl010 name="construct.c.page3.prfl010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl011
            #add-point:BEFORE FIELD prfl011 name="construct.b.page3.prfl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl011
            
            #add-point:AFTER FIELD prfl011 name="construct.a.page3.prfl011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl011
            #add-point:ON ACTION controlp INFIELD prfl011 name="construct.c.page3.prfl011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl012
            #add-point:BEFORE FIELD prfl012 name="construct.b.page3.prfl012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl012
            
            #add-point:AFTER FIELD prfl012 name="construct.a.page3.prfl012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl012
            #add-point:ON ACTION controlp INFIELD prfl012 name="construct.c.page3.prfl012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl013
            #add-point:BEFORE FIELD prfl013 name="construct.b.page3.prfl013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl013
            
            #add-point:AFTER FIELD prfl013 name="construct.a.page3.prfl013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prfl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl013
            #add-point:ON ACTION controlp INFIELD prfl013 name="construct.c.page3.prfl013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prflsite
            #add-point:BEFORE FIELD prflsite name="construct.b.page3.prflsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prflsite
            
            #add-point:AFTER FIELD prflsite name="construct.a.page3.prflsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prflsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prflsite
            #add-point:ON ACTION controlp INFIELD prflsite name="construct.c.page3.prflsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prflunit
            #add-point:BEFORE FIELD prflunit name="construct.b.page3.prflunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prflunit
            
            #add-point:AFTER FIELD prflunit name="construct.a.page3.prflunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prflunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prflunit
            #add-point:ON ACTION controlp INFIELD prflunit name="construct.c.page3.prflunit"
            
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
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "prfi_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prfj_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prfk_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "prfl_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt504_filter()
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
      CONSTRUCT g_wc_filter ON prfisite,prfidocdt,prfidocno,prfi001,prfiunit,prfi002,prfi003,prfi004, 
          prfi005,prfi006,prfi007
                          FROM s_browse[1].b_prfisite,s_browse[1].b_prfidocdt,s_browse[1].b_prfidocno, 
                              s_browse[1].b_prfi001,s_browse[1].b_prfiunit,s_browse[1].b_prfi002,s_browse[1].b_prfi003, 
                              s_browse[1].b_prfi004,s_browse[1].b_prfi005,s_browse[1].b_prfi006,s_browse[1].b_prfi007 
 
 
         BEFORE CONSTRUCT
               DISPLAY aprt504_filter_parser('prfisite') TO s_browse[1].b_prfisite
            DISPLAY aprt504_filter_parser('prfidocdt') TO s_browse[1].b_prfidocdt
            DISPLAY aprt504_filter_parser('prfidocno') TO s_browse[1].b_prfidocno
            DISPLAY aprt504_filter_parser('prfi001') TO s_browse[1].b_prfi001
            DISPLAY aprt504_filter_parser('prfiunit') TO s_browse[1].b_prfiunit
            DISPLAY aprt504_filter_parser('prfi002') TO s_browse[1].b_prfi002
            DISPLAY aprt504_filter_parser('prfi003') TO s_browse[1].b_prfi003
            DISPLAY aprt504_filter_parser('prfi004') TO s_browse[1].b_prfi004
            DISPLAY aprt504_filter_parser('prfi005') TO s_browse[1].b_prfi005
            DISPLAY aprt504_filter_parser('prfi006') TO s_browse[1].b_prfi006
            DISPLAY aprt504_filter_parser('prfi007') TO s_browse[1].b_prfi007
      
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
 
      CALL aprt504_filter_show('prfisite')
   CALL aprt504_filter_show('prfidocdt')
   CALL aprt504_filter_show('prfidocno')
   CALL aprt504_filter_show('prfi001')
   CALL aprt504_filter_show('prfiunit')
   CALL aprt504_filter_show('prfi002')
   CALL aprt504_filter_show('prfi003')
   CALL aprt504_filter_show('prfi004')
   CALL aprt504_filter_show('prfi005')
   CALL aprt504_filter_show('prfi006')
   CALL aprt504_filter_show('prfi007')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt504_filter_parser(ps_field)
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
 
{<section id="aprt504.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt504_filter_show(ps_field)
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
   LET ls_condition = aprt504_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt504_query()
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
   CALL g_prfj_d.clear()
   CALL g_prfj2_d.clear()
   CALL g_prfj3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt504_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt504_browser_fill("")
      CALL aprt504_fetch("")
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
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aprt504_filter_show('prfisite')
   CALL aprt504_filter_show('prfidocdt')
   CALL aprt504_filter_show('prfidocno')
   CALL aprt504_filter_show('prfi001')
   CALL aprt504_filter_show('prfiunit')
   CALL aprt504_filter_show('prfi002')
   CALL aprt504_filter_show('prfi003')
   CALL aprt504_filter_show('prfi004')
   CALL aprt504_filter_show('prfi005')
   CALL aprt504_filter_show('prfi006')
   CALL aprt504_filter_show('prfi007')
   CALL aprt504_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt504_fetch("F") 
      #顯示單身筆數
      CALL aprt504_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt504_fetch(p_flag)
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
   
   LET g_prfi_m.prfidocno = g_browser[g_current_idx].b_prfidocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt504_master_referesh USING g_prfi_m.prfidocno INTO g_prfi_m.prfisite,g_prfi_m.prfidocdt, 
       g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004, 
       g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiowndp, 
       g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfdt,g_prfi_m.prfisite_desc,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002_desc, 
       g_prfi_m.prfi006_desc,g_prfi_m.prfi007_desc,g_prfi_m.prfiownid_desc,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid_desc, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prfimodid_desc,g_prfi_m.prficnfid_desc
   
   #遮罩相關處理
   LET g_prfi_m_mask_o.* =  g_prfi_m.*
   CALL aprt504_prfi_t_mask()
   LET g_prfi_m_mask_n.* =  g_prfi_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt504_set_act_visible()   
   CALL aprt504_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   IF g_prfi_m.prfistus <> "N" THEN
#      CALL cl_set_act_visible("delete,modify", FALSE)
#   ELSE
#      CALL cl_set_act_visible("delete,modify", true)    
#   END IF
   IF g_prfi_m.prfistus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prfi_m_t.* = g_prfi_m.*
   LET g_prfi_m_o.* = g_prfi_m.*
   
   LET g_data_owner = g_prfi_m.prfiownid      
   LET g_data_dept  = g_prfi_m.prfiowndp
   
   #重新顯示   
   CALL aprt504_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt504_insert()
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
   CALL g_prfj_d.clear()   
   CALL g_prfj2_d.clear()  
   CALL g_prfj3_d.clear()  
 
 
   INITIALIZE g_prfi_m.* TO NULL             #DEFAULT 設定
   
   LET g_prfidocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prfi_m.prfiownid = g_user
      LET g_prfi_m.prfiowndp = g_dept
      LET g_prfi_m.prficrtid = g_user
      LET g_prfi_m.prficrtdp = g_dept 
      LET g_prfi_m.prficrtdt = cl_get_current()
      LET g_prfi_m.prfimodid = g_user
      LET g_prfi_m.prfimoddt = cl_get_current()
      LET g_prfi_m.prfistus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prfi_m.prfi001 = "2"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_prfi_m.prfistus = 'N'
      LET g_prfi_m.prfidocdt = g_today
#      LET g_prfi_m.prfisite = g_site
      LET g_prfi_m.prfiunit = g_prfi_m.prfisite
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'prfisite',g_prfi_m.prfisite)
         RETURNING l_insert,g_prfi_m.prfisite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL s_aooi500_default(g_prog,'prfiunit',g_prfi_m.prfisite)
         RETURNING l_insert,g_prfi_m.prfiunit
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prfi_m.prfi004 =g_today
      LET g_prfi_m.prfi005 =g_today
      CALL aprt504_prfisite_ref()
      CALL aprt504_prfiunit_ref()
      LET g_prfi_m.prfi006 = g_user
      CALL aprt504_prfi006_ref()
      CALL aprt504_prfi006_display()
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prfi_m.prfisite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prfi_m.prfidocno = r_doctype
      
      LET g_prfi_m_t.* = g_prfi_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prfi_m_t.* = g_prfi_m.*
      LET g_prfi_m_o.* = g_prfi_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfi_m.prfistus 
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
 
 
 
    
      CALL aprt504_input("a")
      
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
         INITIALIZE g_prfi_m.* TO NULL
         INITIALIZE g_prfj_d TO NULL
         INITIALIZE g_prfj2_d TO NULL
         INITIALIZE g_prfj3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt504_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prfj_d.clear()
      #CALL g_prfj2_d.clear()
      #CALL g_prfj3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt504_set_act_visible()   
   CALL aprt504_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prfidocno_t = g_prfi_m.prfidocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prfient = " ||g_enterprise|| " AND",
                      " prfidocno = '", g_prfi_m.prfidocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt504_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt504_cl
   
   CALL aprt504_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt504_master_referesh USING g_prfi_m.prfidocno INTO g_prfi_m.prfisite,g_prfi_m.prfidocdt, 
       g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004, 
       g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiowndp, 
       g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfdt,g_prfi_m.prfisite_desc,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002_desc, 
       g_prfi_m.prfi006_desc,g_prfi_m.prfi007_desc,g_prfi_m.prfiownid_desc,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid_desc, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prfimodid_desc,g_prfi_m.prficnfid_desc
   
   
   #遮罩相關處理
   LET g_prfi_m_mask_o.* =  g_prfi_m.*
   CALL aprt504_prfi_t_mask()
   LET g_prfi_m_mask_n.* =  g_prfi_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prfi_m.prfisite,g_prfi_m.prfisite_desc,g_prfi_m.prfidocdt,g_prfi_m.prfidocno,g_prfi_m.prfi001, 
       g_prfi_m.prfiunit,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002,g_prfi_m.prfi002_desc,g_prfi_m.prfi003, 
       g_prfi_m.prfi003_desc,g_prfi_m.prfi004,g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi006_desc, 
       g_prfi_m.prfi007,g_prfi_m.prfi007_desc,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiownid_desc, 
       g_prfi_m.prfiowndp,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid,g_prfi_m.prficrtid_desc,g_prfi_m.prficrtdp, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimodid_desc,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfid_desc,g_prfi_m.prficnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prfi_m.prfiownid      
   LET g_data_dept  = g_prfi_m.prfiowndp
   
   #功能已完成,通報訊息中心
   CALL aprt504_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt504_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_prfi_m.prfistus MATCHES "[DR]" THEN 
      LET g_prfi_m.prfistus = "N"
   END IF
   IF g_prfi_m.prfistus<>'N' THEN
      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prfi_m_t.* = g_prfi_m.*
   LET g_prfi_m_o.* = g_prfi_m.*
   
   IF g_prfi_m.prfidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prfidocno_t = g_prfi_m.prfidocno
 
   CALL s_transaction_begin()
   
   OPEN aprt504_cl USING g_enterprise,g_prfi_m.prfidocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt504_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt504_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt504_master_referesh USING g_prfi_m.prfidocno INTO g_prfi_m.prfisite,g_prfi_m.prfidocdt, 
       g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004, 
       g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiowndp, 
       g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfdt,g_prfi_m.prfisite_desc,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002_desc, 
       g_prfi_m.prfi006_desc,g_prfi_m.prfi007_desc,g_prfi_m.prfiownid_desc,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid_desc, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prfimodid_desc,g_prfi_m.prficnfid_desc
   
   #檢查是否允許此動作
   IF NOT aprt504_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prfi_m_mask_o.* =  g_prfi_m.*
   CALL aprt504_prfi_t_mask()
   LET g_prfi_m_mask_n.* =  g_prfi_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL aprt504_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_prfidocno_t = g_prfi_m.prfidocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prfi_m.prfimodid = g_user 
LET g_prfi_m.prfimoddt = cl_get_current()
LET g_prfi_m.prfimodid_desc = cl_get_username(g_prfi_m.prfimodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_prfi_m.prfistus MATCHES "[DR]" THEN 
         LET g_prfi_m.prfistus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt504_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prfi_t SET (prfimodid,prfimoddt) = (g_prfi_m.prfimodid,g_prfi_m.prfimoddt)
          WHERE prfient = g_enterprise AND prfidocno = g_prfidocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prfi_m.* = g_prfi_m_t.*
            CALL aprt504_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prfi_m.prfidocno != g_prfi_m_t.prfidocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prfj_t SET prfjdocno = g_prfi_m.prfidocno
 
          WHERE prfjent = g_enterprise AND prfjdocno = g_prfi_m_t.prfidocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prfj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prfj_t:",SQLERRMESSAGE 
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
         
         UPDATE prfk_t
            SET prfkdocno = g_prfi_m.prfidocno
 
          WHERE prfkent = g_enterprise AND
                prfkdocno = g_prfidocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prfk_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prfk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE prfl_t
            SET prfldocno = g_prfi_m.prfidocno
 
          WHERE prflent = g_enterprise AND
                prfldocno = g_prfidocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prfl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prfl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt504_set_act_visible()   
   CALL aprt504_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prfient = " ||g_enterprise|| " AND",
                      " prfidocno = '", g_prfi_m.prfidocno, "' "
 
   #填到對應位置
   CALL aprt504_browser_fill("")
 
   CLOSE aprt504_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt504_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt504.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt504_input(p_cmd)
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
   DEFINE  l_sql                 STRING
   DEFINE  l_errno               LIKE type_t.chr10
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
   DISPLAY BY NAME g_prfi_m.prfisite,g_prfi_m.prfisite_desc,g_prfi_m.prfidocdt,g_prfi_m.prfidocno,g_prfi_m.prfi001, 
       g_prfi_m.prfiunit,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002,g_prfi_m.prfi002_desc,g_prfi_m.prfi003, 
       g_prfi_m.prfi003_desc,g_prfi_m.prfi004,g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi006_desc, 
       g_prfi_m.prfi007,g_prfi_m.prfi007_desc,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiownid_desc, 
       g_prfi_m.prfiowndp,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid,g_prfi_m.prficrtid_desc,g_prfi_m.prficrtdp, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimodid_desc,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfid_desc,g_prfi_m.prficnfdt
   
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
   LET g_forupd_sql = "SELECT prfjseq,prfj001,prfjsite,prfjunit FROM prfj_t WHERE prfjent=? AND prfjdocno=?  
       AND prfjseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt504_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prfkseq,prfk001,prfk002,prfksite,prfkunit FROM prfk_t WHERE prfkent=?  
       AND prfkdocno=? AND prfkseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt504_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prflseq,prfl014,prfl001,prfl002,prfl003,prfl004,prfl005,prfl006,prfl007, 
       prfl008,prfl009,prfl010,prfl011,prfl012,prfl013,prflsite,prflunit FROM prfl_t WHERE prflent=?  
       AND prfldocno=? AND prflseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt504_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt504_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt504_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prfi_m.prfisite,g_prfi_m.prfidocdt,g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit, 
       g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004,g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007, 
       g_prfi_m.prfistus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = '1'
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001= g_prfi_m.prfisite
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt504.input.head" >}
      #單頭段
      INPUT BY NAME g_prfi_m.prfisite,g_prfi_m.prfidocdt,g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit, 
          g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004,g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007, 
          g_prfi_m.prfistus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt504_cl USING g_enterprise,g_prfi_m.prfidocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt504_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt504_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt504_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL aprt504_set_entry(p_cmd)
            CALL aprt504_set_no_entry(p_cmd)
            #end add-point
            CALL aprt504_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfisite
            
            #add-point:AFTER FIELD prfisite name="input.a.prfisite"
            IF NOT cl_null(g_prfi_m.prfisite) THEN
               CALL s_aooi500_chk(g_prog,'prfisite',g_prfi_m.prfisite,g_prfi_m.prfisite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_prfi_m.prfisite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prfi_m.prfisite = g_prfi_m_t.prfisite
                  CALL s_desc_get_department_desc(g_prfi_m.prfisite) RETURNING g_prfi_m.prfisite_desc
                  DISPLAY BY NAME g_prfi_m.prfisite,g_prfi_m.prfisite_desc
                  NEXT FIELD CURRENT
               END IF
            #sakura---add--str
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               
               LET g_prfi_m.prfisite = g_prfi_m_t.prfisite
               CALL s_desc_get_department_desc(g_prfi_m.prfisite) RETURNING g_prfi_m.prfisite_desc
               DISPLAY BY NAME g_prfi_m.prfisite,g_prfi_m.prfisite_desc
               NEXT FIELD CURRENT               
            #sakura---add--end		               
            END IF
            LET g_site_flag = TRUE
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfi_m.prfisite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfi_m.prfisite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfi_m.prfisite_desc
            CALL aprt504_set_entry(p_cmd)
            CALL aprt504_set_no_entry(p_cmd)            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfisite
            #add-point:BEFORE FIELD prfisite name="input.b.prfisite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfisite
            #add-point:ON CHANGE prfisite name="input.g.prfisite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfidocdt
            #add-point:BEFORE FIELD prfidocdt name="input.b.prfidocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfidocdt
            
            #add-point:AFTER FIELD prfidocdt name="input.a.prfidocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfidocdt
            #add-point:ON CHANGE prfidocdt name="input.g.prfidocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfidocno
            
            #add-point:AFTER FIELD prfidocno name="input.a.prfidocno"
            IF NOT cl_null(g_prfi_m.prfidocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfi_m.prfidocno != g_prfidocno_t )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_ooef004
                  LET g_chkparam.arg2 = g_prfi_m.prfidocno
                  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooba002") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfi_m.prfidocno = g_prfi_m_t.prfidocno
                     NEXT FIELD CURRENT
                  END IF
            

               END IF 
              #CALL s_aooi200_chk_slip(g_site,g_ooef004,g_prfi_m.prfidocno,g_prog) RETURNING l_success #sakura mark
               CALL s_aooi200_chk_slip(g_prfi_m.prfisite,g_ooef004,g_prfi_m.prfidocno,g_prog) RETURNING l_success #sakura add
               IF NOT l_success THEN
                  LET  g_prfi_m.prfidocno = g_prfi_m_t.prfidocno 
                  NEXT FIELD prfidocno
               END IF
               #此段落由子樣板a05產生
               IF  NOT cl_null(g_prfi_m.prfidocno) THEN 
                  IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfi_m.prfidocno != g_prfidocno_t )) THEN 
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfi_t WHERE "||"prfient = '" ||g_enterprise|| "' AND "||"prfidocno = '"||g_prfi_m.prfidocno ||"'",'std-00004',0) THEN 
                        LET g_prfi_m.prfidocno = g_prfi_m_t.prfidocno
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfidocno
            #add-point:BEFORE FIELD prfidocno name="input.b.prfidocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfidocno
            #add-point:ON CHANGE prfidocno name="input.g.prfidocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi001
            #add-point:BEFORE FIELD prfi001 name="input.b.prfi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi001
            
            #add-point:AFTER FIELD prfi001 name="input.a.prfi001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfi001
            #add-point:ON CHANGE prfi001 name="input.g.prfi001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfiunit
            
            #add-point:AFTER FIELD prfiunit name="input.a.prfiunit"
            IF NOT cl_null(g_prfi_m.prfiunit) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_prfi_m.prfiunit
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_prfi_m.prfiunit = g_prfi_m_t.prfiunit
#                  LET g_prfi_m.prfiunit_desc = ""
#                  DISPLAY BY NAME g_prfi_m.prfiunit,g_prfi_m.prfiunit_desc
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_aooi500_chk(g_prog,'prfiunit',g_prfi_m.prfiunit,g_prfi_m.prfisite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_prfi_m.prfiunit
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prfi_m.prfiunit = g_prfi_m_t.prfiunit
                  CALL s_desc_get_department_desc(g_prfi_m.prfiunit) RETURNING g_prfi_m.prfiunit_desc
                  DISPLAY BY NAME g_prfi_m.prfiunit,g_prfi_m.prfiunit_desc
                  NEXT FIELD CURRENT
               END IF
               
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfi_m.prfiunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfi_m.prfiunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfi_m.prfiunit_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfiunit
            #add-point:BEFORE FIELD prfiunit name="input.b.prfiunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfiunit
            #add-point:ON CHANGE prfiunit name="input.g.prfiunit"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi002
            
            #add-point:AFTER FIELD prfi002 name="input.a.prfi002"
            LET g_prfi_m.prfi002_desc = null
            DISPLAY BY NAME g_prfi_m.prfi002_desc
            IF NOT cl_null(g_prfi_m.prfi002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfi_m.prfi002 != g_prfi_m_t.prfi002 or g_prfi_m_t.prfi002 is null )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfi_m.prfisite
                  LET g_chkparam.arg2 = g_prfi_m.prfi002
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#15 by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooaj002") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfi_m.prfi002 = g_prfi_m_t.prfi002
                     CALL aprt504_prfi002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprt504_prfi002_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi002
            #add-point:BEFORE FIELD prfi002 name="input.b.prfi002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfi002
            #add-point:ON CHANGE prfi002 name="input.g.prfi002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi003
            
            #add-point:AFTER FIELD prfi003 name="input.a.prfi003"
            LET g_prfi_m.prfi003_desc = null
            DISPLAY BY NAME g_prfi_m.prfi003_desc
            IF NOT cl_null(g_prfi_m.prfi003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfi_m.prfi003 != g_prfi_m_t.prfi003 or g_prfi_m_t.prfi003 is null )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfi_m.prfisite
                  LET g_chkparam.arg2 = g_prfi_m.prfi003
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#15 by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oodb002") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfi_m.prfi003 = g_prfi_m_t.prfi003
                     CALL aprt504_prfi003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprt504_prfi003_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi003
            #add-point:BEFORE FIELD prfi003 name="input.b.prfi003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfi003
            #add-point:ON CHANGE prfi003 name="input.g.prfi003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi004
            #add-point:BEFORE FIELD prfi004 name="input.b.prfi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi004
            
            #add-point:AFTER FIELD prfi004 name="input.a.prfi004"
            IF NOT cl_null(g_prfi_m.prfi004)  THEN
               IF g_prfi_m.prfi004<g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axc-00066"
                  LET g_errparam.extend = g_prfi_m.prfi004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prfi_m.prfi004 = g_prfi_m_t.prfi004
                  NEXT FIELD prfi004
               END IF
               IF NOT cl_null(g_prfi_m.prfi005) THEN
                  IF g_prfi_m.prfi004>g_prfi_m.prfi005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00047"
                     LET g_errparam.extend = g_prfi_m.prfi004||'>'||g_prfi_m.prfi005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prfi_m.prfi004 = g_prfi_m_t.prfi004
                     NEXT FIELD prfi004
                  END IF
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfi004
            #add-point:ON CHANGE prfi004 name="input.g.prfi004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi005
            #add-point:BEFORE FIELD prfi005 name="input.b.prfi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi005
            
            #add-point:AFTER FIELD prfi005 name="input.a.prfi005"
            IF NOT cl_null(g_prfi_m.prfi005)  THEN
               IF g_prfi_m.prfi005<g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axc-00067"
                  LET g_errparam.extend = g_prfi_m.prfi005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prfi_m.prfi005 = g_prfi_m_t.prfi005
                  NEXT FIELD prfi005
               END IF
               IF NOT cl_null(g_prfi_m.prfi004) THEN
                  IF g_prfi_m.prfi004>g_prfi_m.prfi005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00047"
                     LET g_errparam.extend = g_prfi_m.prfi004||'>'||g_prfi_m.prfi005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prfi_m.prfi005 = g_prfi_m_t.prfi005
                     NEXT FIELD prfi005
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfi005
            #add-point:ON CHANGE prfi005 name="input.g.prfi005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi006
            
            #add-point:AFTER FIELD prfi006 name="input.a.prfi006"
            LET g_prfi_m.prfi006_desc = NULL
            DISPLAY BY NAME g_prfi_m.prfi006_desc
            IF NOT cl_null(g_prfi_m.prfi006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfi_m.prfi006 != g_prfi_m_t.prfi006 OR g_prfi_m_t.prfi006 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                   #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfi_m.prfi006
                   #160318-00025#15 by 07900 --add-str 
                   LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                   #160318-00025#15 by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfi_m.prfi006 = g_prfi_m_t.prfi006
                     CALL aprt504_prfi006_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt504_prfi006_display()
               END IF

            END IF 
            CALL aprt504_prfi006_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi006
            #add-point:BEFORE FIELD prfi006 name="input.b.prfi006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfi006
            #add-point:ON CHANGE prfi006 name="input.g.prfi006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfi007
            
            #add-point:AFTER FIELD prfi007 name="input.a.prfi007"
            LET g_prfi_m.prfi007_desc = NULL
            DISPLAY BY NAME g_prfi_m.prfi007_desc
            IF NOT cl_null(g_prfi_m.prfi007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfi_m.prfi007 != g_prfi_m_t.prfi007 OR g_prfi_m_t.prfi007 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfi_m.prfi007
                  LET g_chkparam.arg2 = g_today
                   #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#15 by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001_3") THEN

                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfi_m.prfi007 = g_prfi_m_t.prfi007
                     CALL aprt504_prfi007_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprt504_prfi007_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfi007
            #add-point:BEFORE FIELD prfi007 name="input.b.prfi007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfi007
            #add-point:ON CHANGE prfi007 name="input.g.prfi007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfistus
            #add-point:BEFORE FIELD prfistus name="input.b.prfistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfistus
            
            #add-point:AFTER FIELD prfistus name="input.a.prfistus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfistus
            #add-point:ON CHANGE prfistus name="input.g.prfistus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prfisite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfisite
            #add-point:ON ACTION controlp INFIELD prfisite name="input.c.prfisite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfi_m.prfisite             #給予default值
            LET g_qryparam.default2 = "" #g_prfi_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
#            CALL q_ooef001()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfisite',g_prfi_m.prfisite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
            CALL q_ooef001_24()

            LET g_prfi_m.prfisite = g_qryparam.return1              
            #LET g_prfi_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_prfi_m.prfisite TO prfisite              #
            #DISPLAY g_prfi_m.ooefl003 TO ooefl003 #說明(簡稱)
            CALL aprt504_prfisite_ref()
            NEXT FIELD prfisite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfidocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfidocdt
            #add-point:ON ACTION controlp INFIELD prfidocdt name="input.c.prfidocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfidocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfidocno
            #add-point:ON ACTION controlp INFIELD prfidocno name="input.c.prfidocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfi_m.prfidocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = "aprt504" #   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prfi_m.prfidocno = g_qryparam.return1              

            DISPLAY g_prfi_m.prfidocno TO prfidocno              #

            NEXT FIELD prfidocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi001
            #add-point:ON ACTION controlp INFIELD prfi001 name="input.c.prfi001"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfiunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfiunit
            #add-point:ON ACTION controlp INFIELD prfiunit name="input.c.prfiunit"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfi_m.prfiunit             #給予default值
            LET g_qryparam.default2 = g_prfi_m.prfiunit_desc #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
#            CALL q_ooef001()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfiunit',g_prfi_m.prfisite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
            CALL q_ooef001_24()

            LET g_prfi_m.prfiunit = g_qryparam.return1              
#            LET g_prfi_m.prfiunit_desc = g_qryparam.return2 
            DISPLAY g_prfi_m.prfiunit TO prfiunit              #
#            DISPLAY g_prfi_m.prfiunit_desc TO prfiunit_desc #說明(簡稱)
            CALL aprt504_prfiunit_ref()
            NEXT FIELD prfiunit                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi002
            #add-point:ON ACTION controlp INFIELD prfi002 name="input.c.prfi002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfi_m.prfi002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_prfi_m.prfisite
            CALL q_ooaj002_3()                                #呼叫開窗

            LET g_prfi_m.prfi002 = g_qryparam.return1              

            DISPLAY g_prfi_m.prfi002 TO prfi002              #
            CALL aprt504_prfi002_ref()
            NEXT FIELD prfi002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfi003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi003
            #add-point:ON ACTION controlp INFIELD prfi003 name="input.c.prfi003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfi_m.prfi003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_prfi_m.prfisite
            CALL q_oodb002_8()                                #呼叫開窗

            LET g_prfi_m.prfi003 = g_qryparam.return1              

            DISPLAY g_prfi_m.prfi003 TO prfi003              #
            CALL aprt504_prfi003_ref()
            NEXT FIELD prfi003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi004
            #add-point:ON ACTION controlp INFIELD prfi004 name="input.c.prfi004"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfi005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi005
            #add-point:ON ACTION controlp INFIELD prfi005 name="input.c.prfi005"
            
            #END add-point
 
 
         #Ctrlp:input.c.prfi006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi006
            #add-point:ON ACTION controlp INFIELD prfi006 name="input.c.prfi006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfi_m.prfi006             #給予default值

            #給予arg
          
            CALL q_ooag001()                                #呼叫開窗

            LET g_prfi_m.prfi006 = g_qryparam.return1              

            DISPLAY g_prfi_m.prfi006 TO prfi006              #
            CALL aprt504_prfi006_display()
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prfi_m.prfi006 != g_prfi_m_t.prfi006 OR g_prfi_m_t.prfi006 IS NULL )) THEN 
               CALL aprt504_prfi006_ref()
            END IF
            NEXT FIELD prfi006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfi007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfi007
            #add-point:ON ACTION controlp INFIELD prfi007 name="input.c.prfi007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfi_m.prfi007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_prfi_m.prfi007 = g_qryparam.return1              

            DISPLAY g_prfi_m.prfi007 TO prfi007              #
            CALL aprt504_prfi007_ref() 
            NEXT FIELD prfi007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prfistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfistus
            #add-point:ON ACTION controlp INFIELD prfistus name="input.c.prfistus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prfi_m.prfidocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               IF NOT cl_null(g_prfi_m.prfidocno) THEN 
               
                  CALL s_aooi200_gen_docno(g_prfi_m.prfisite,g_prfi_m.prfidocno,g_prfi_m.prfidocdt,g_prog)
                     RETURNING  g_success,g_prfi_m.prfidocno
                  IF g_success<>'1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00001"
                     LET g_errparam.extend = g_prfi_m.prfidocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD prfidocno
                  ELSE
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfi_t WHERE "||"prfient = '" ||g_enterprise|| "' AND "||"prfidocno = '"||g_prfi_m.prfidocno ||"'",'std-00004',1) THEN
                        LET g_prfi_m.prfidocno = g_prfidocno_t
                        NEXT FIELD prfidocno
                     END IF

                  END IF
                  LET g_prfi_m_t.prfidocno = g_prfi_m.prfidocno
                     
               END IF
#               LET g_prfi_m.prfiunit = g_prfi_m.prfisite #sakura add   #geza mark
               #end add-point
               
               INSERT INTO prfi_t (prfient,prfisite,prfidocdt,prfidocno,prfi001,prfiunit,prfi002,prfi003, 
                   prfi004,prfi005,prfi006,prfi007,prfistus,prfiownid,prfiowndp,prficrtid,prficrtdp, 
                   prficrtdt,prfimodid,prfimoddt,prficnfid,prficnfdt)
               VALUES (g_enterprise,g_prfi_m.prfisite,g_prfi_m.prfidocdt,g_prfi_m.prfidocno,g_prfi_m.prfi001, 
                   g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004,g_prfi_m.prfi005, 
                   g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiowndp, 
                   g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt, 
                   g_prfi_m.prficnfid,g_prfi_m.prficnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prfi_m:",SQLERRMESSAGE 
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
                  CALL aprt504_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt504_b_fill()
                  CALL aprt504_b_fill2('0')
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
               CALL aprt504_prfi_t_mask_restore('restore_mask_o')
               
               UPDATE prfi_t SET (prfisite,prfidocdt,prfidocno,prfi001,prfiunit,prfi002,prfi003,prfi004, 
                   prfi005,prfi006,prfi007,prfistus,prfiownid,prfiowndp,prficrtid,prficrtdp,prficrtdt, 
                   prfimodid,prfimoddt,prficnfid,prficnfdt) = (g_prfi_m.prfisite,g_prfi_m.prfidocdt, 
                   g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003, 
                   g_prfi_m.prfi004,g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus, 
                   g_prfi_m.prfiownid,g_prfi_m.prfiowndp,g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt, 
                   g_prfi_m.prfimodid,g_prfi_m.prfimoddt,g_prfi_m.prficnfid,g_prfi_m.prficnfdt)
                WHERE prfient = g_enterprise AND prfidocno = g_prfidocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prfi_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aprt504_prfi_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prfi_m_t)
               LET g_log2 = util.JSON.stringify(g_prfi_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prfidocno_t = g_prfi_m.prfidocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt504.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prfj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prfj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt504_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prfj_d.getLength()
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
            OPEN aprt504_cl USING g_enterprise,g_prfi_m.prfidocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt504_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt504_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prfj_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prfj_d[l_ac].prfjseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prfj_d_t.* = g_prfj_d[l_ac].*  #BACKUP
               LET g_prfj_d_o.* = g_prfj_d[l_ac].*  #BACKUP
               CALL aprt504_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprt504_set_no_entry_b(l_cmd)
               IF NOT aprt504_lock_b("prfj_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt504_bcl INTO g_prfj_d[l_ac].prfjseq,g_prfj_d[l_ac].prfj001,g_prfj_d[l_ac].prfjsite, 
                      g_prfj_d[l_ac].prfjunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prfj_d_t.prfjseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prfj_d_mask_o[l_ac].* =  g_prfj_d[l_ac].*
                  CALL aprt504_prfj_t_mask()
                  LET g_prfj_d_mask_n[l_ac].* =  g_prfj_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt504_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL aprt504_b_fill3()
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
            INITIALIZE g_prfj_d[l_ac].* TO NULL 
            INITIALIZE g_prfj_d_t.* TO NULL 
            INITIALIZE g_prfj_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prfj_d_t.* = g_prfj_d[l_ac].*     #新輸入資料
            LET g_prfj_d_o.* = g_prfj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt504_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt504_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prfj_d[li_reproduce_target].* = g_prfj_d[li_reproduce].*
 
               LET g_prfj_d[li_reproduce_target].prfjseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            CALL aprt504_create_prfjseq()
            LET g_prfj_d[l_ac].prfjsite = g_prfi_m.prfisite
            LET g_prfj_d[l_ac].prfjunit = g_prfi_m.prfiunit
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
            SELECT COUNT(1) INTO l_count FROM prfj_t 
             WHERE prfjent = g_enterprise AND prfjdocno = g_prfi_m.prfidocno
 
               AND prfjseq = g_prfj_d[l_ac].prfjseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfi_m.prfidocno
               LET gs_keys[2] = g_prfj_d[g_detail_idx].prfjseq
               CALL aprt504_insert_b('prfj_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prfj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prfj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt504_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               IF cl_ask_confirm("apr-00216") THEN
                  
                  CALL aprt504_fill() RETURNING l_sql
                  CALL aprt504_insert_prfl(l_sql) RETURNING l_success
                  IF l_success=false THEN
                     CALL s_transaction_end('N','0')                    
                     CANCEL INSERT
                  END IF
               END IF
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
               IF cl_ask_confirm("apr-00216") THEN
                  CALL aprt504_fill() RETURNING l_sql
                  CALL aprt504_delete_prfl(l_sql) RETURNING l_success
                  IF l_success=false THEN
                     CALL s_transaction_end('N','0')                    
                     CANCEL DELETE
                  END IF
               END IF
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prfi_m.prfidocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prfj_d_t.prfjseq
 
            
               #刪除同層單身
               IF NOT aprt504_delete_b('prfj_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt504_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt504_key_delete_b(gs_keys,'prfj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt504_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt504_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  
               #end add-point
               LET l_count = g_prfj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prfj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfjseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfj_d[l_ac].prfjseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prfjseq
            END IF 
 
 
 
            #add-point:AFTER FIELD prfjseq name="input.a.page1.prfjseq"
            IF NOT cl_null(g_prfj_d[l_ac].prfjseq) THEN 
            END IF 


            #此段落由子樣板a05產生
            IF  g_prfi_m.prfidocno IS NOT NULL AND g_prfj_d[g_detail_idx].prfjseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfi_m.prfidocno != g_prfidocno_t OR g_prfj_d[g_detail_idx].prfjseq != g_prfj_d_t.prfjseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfj_t WHERE "||"prfjent = '" ||g_enterprise|| "' AND "||"prfjdocno = '"||g_prfi_m.prfidocno ||"' AND "|| "prfjseq = '"||g_prfj_d[g_detail_idx].prfjseq ||"'",'std-00004',0) THEN 
                     LET g_prfj_d[l_ac].prfjseq = g_prfj_d_t.prfjseq
                     NEXT FIELD CURRENT 
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfjseq
            #add-point:BEFORE FIELD prfjseq name="input.b.page1.prfjseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfjseq
            #add-point:ON CHANGE prfjseq name="input.g.page1.prfjseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfj001
            
            #add-point:AFTER FIELD prfj001 name="input.a.page1.prfj001"
            LET g_prfj_d[l_ac].prfj001_desc = NULL
            DISPLAY  g_prfj_d[l_ac].prfj001_desc TO s_detail1[l_ac].prfj001_desc
            IF NOT cl_null(g_prfj_d[l_ac].prfj001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prfj_d[l_ac].prfj001 != g_prfj_d_t.prfj001 OR g_prfj_d_t.prfj001 IS null)) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfj_d[l_ac].prfj001
                  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_prfg001") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfj_d[l_ac].prfj001 = g_prfj_d_t.prfj001
                     CALL aprt504_prfj001_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt504_prfj001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prfj_d[l_ac].prfj001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prfj_d[l_ac].prfj001 = g_prfj_d_t.prfj001
                     CALL aprt504_prfj001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF
            CALL aprt504_prfj001_ref()            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfj001
            #add-point:BEFORE FIELD prfj001 name="input.b.page1.prfj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfj001
            #add-point:ON CHANGE prfj001 name="input.g.page1.prfj001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfjsite
            #add-point:BEFORE FIELD prfjsite name="input.b.page1.prfjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfjsite
            
            #add-point:AFTER FIELD prfjsite name="input.a.page1.prfjsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfjsite
            #add-point:ON CHANGE prfjsite name="input.g.page1.prfjsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfjunit
            #add-point:BEFORE FIELD prfjunit name="input.b.page1.prfjunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfjunit
            
            #add-point:AFTER FIELD prfjunit name="input.a.page1.prfjunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfjunit
            #add-point:ON CHANGE prfjunit name="input.g.page1.prfjunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prfjseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfjseq
            #add-point:ON ACTION controlp INFIELD prfjseq name="input.c.page1.prfjseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prfj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfj001
            #add-point:ON ACTION controlp INFIELD prfj001 name="input.c.page1.prfj001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfj_d[l_ac].prfj001             #給予default值

            #給予arg
            
            CALL q_prfg001()                                #呼叫開窗

            LET g_prfj_d[l_ac].prfj001 = g_qryparam.return1              

            DISPLAY g_prfj_d[l_ac].prfj001 TO prfj001              #
            CALL aprt504_prfj001_ref()
            NEXT FIELD prfj001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prfjsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfjsite
            #add-point:ON ACTION controlp INFIELD prfjsite name="input.c.page1.prfjsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prfjunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfjunit
            #add-point:ON ACTION controlp INFIELD prfjunit name="input.c.page1.prfjunit"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prfj_d[l_ac].* = g_prfj_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt504_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prfj_d[l_ac].prfjseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prfj_d[l_ac].* = g_prfj_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt504_prfj_t_mask_restore('restore_mask_o')
      
               UPDATE prfj_t SET (prfjdocno,prfjseq,prfj001,prfjsite,prfjunit) = (g_prfi_m.prfidocno, 
                   g_prfj_d[l_ac].prfjseq,g_prfj_d[l_ac].prfj001,g_prfj_d[l_ac].prfjsite,g_prfj_d[l_ac].prfjunit) 
 
                WHERE prfjent = g_enterprise AND prfjdocno = g_prfi_m.prfidocno 
 
                  AND prfjseq = g_prfj_d_t.prfjseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prfj_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prfj_d[l_ac].* = g_prfj_d_t.*                     
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  LET SQLCA.sqlerrd[3] = NULL
                  LET SQLCA.sqlcode = NULL                  
               END IF
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prfj_d[l_ac].prfj001 != g_prfj_d_t.prfj001 OR g_prfj_d_t.prfj001 IS null)) THEN 
               IF cl_ask_confirm("apr-00216") THEN
                  CALL aprt504_delete_insert_prfl() RETURNING l_sql
                  CALL aprt504_delete_prfl(l_sql) RETURNING l_success
                  IF l_success=false THEN
                     LET g_prfj_d[l_ac].* = g_prfj_d_t.* 
                     CALL s_transaction_end('N','0')                    
                     RETURN
                  ELSE
                     CALL aprt504_fill() RETURNING l_sql
                     CALL aprt504_insert_prfl(l_sql) RETURNING l_success
                     IF l_success=false THEN
                        LET g_prfj_d[l_ac].* = g_prfj_d_t.* 
                        CALL s_transaction_end('N','0')                    
                        RETURN
                     ELSE
                        LET SQLCA.sqlerrd[3] = NULL
                        LET SQLCA.sqlcode = NULL
                     END IF                     
                  END IF
               END IF 
               END IF
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prfj_d[l_ac].* = g_prfj_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prfj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prfj_d[l_ac].* = g_prfj_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prfj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfi_m.prfidocno
               LET gs_keys_bak[1] = g_prfidocno_t
               LET gs_keys[2] = g_prfj_d[g_detail_idx].prfjseq
               LET gs_keys_bak[2] = g_prfj_d_t.prfjseq
               CALL aprt504_update_b('prfj_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt504_prfj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prfj_d[g_detail_idx].prfjseq = g_prfj_d_t.prfjseq 
 
                  ) THEN
                  LET gs_keys[01] = g_prfi_m.prfidocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prfj_d_t.prfjseq
 
                  CALL aprt504_key_update_b(gs_keys,'prfj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prfi_m),util.JSON.stringify(g_prfj_d_t)
               LET g_log2 = util.JSON.stringify(g_prfi_m),util.JSON.stringify(g_prfj_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt504_unlock_b("prfj_t","'1'")
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
               LET g_prfj_d[li_reproduce_target].* = g_prfj_d[li_reproduce].*
 
               LET g_prfj_d[li_reproduce_target].prfjseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prfj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prfj_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_prfj2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prfj2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt504_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prfj2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prfj2_d[l_ac].* TO NULL 
            INITIALIZE g_prfj2_d_t.* TO NULL 
            INITIALIZE g_prfj2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_prfj2_d[l_ac].prfk001 = "3"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_prfj2_d_t.* = g_prfj2_d[l_ac].*     #新輸入資料
            LET g_prfj2_d_o.* = g_prfj2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt504_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt504_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prfj2_d[li_reproduce_target].* = g_prfj2_d[li_reproduce].*
 
               LET g_prfj2_d[li_reproduce_target].prfkseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            CALL aprt504_create_prfkseq()
            LET g_prfj2_d[l_ac].prfksite = g_prfi_m.prfisite
            LET g_prfj2_d[l_ac].prfkunit = g_prfi_m.prfiunit
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprt504_cl USING g_enterprise,g_prfi_m.prfidocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt504_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt504_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prfj2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prfj2_d[l_ac].prfkseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prfj2_d_t.* = g_prfj2_d[l_ac].*  #BACKUP
               LET g_prfj2_d_o.* = g_prfj2_d[l_ac].*  #BACKUP
               CALL aprt504_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aprt504_set_no_entry_b(l_cmd)
               IF NOT aprt504_lock_b("prfk_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt504_bcl2 INTO g_prfj2_d[l_ac].prfkseq,g_prfj2_d[l_ac].prfk001,g_prfj2_d[l_ac].prfk002, 
                      g_prfj2_d[l_ac].prfksite,g_prfj2_d[l_ac].prfkunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prfj2_d_mask_o[l_ac].* =  g_prfj2_d[l_ac].*
                  CALL aprt504_prfk_t_mask()
                  LET g_prfj2_d_mask_n[l_ac].* =  g_prfj2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt504_show()
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
               LET gs_keys[01] = g_prfi_m.prfidocno
               LET gs_keys[gs_keys.getLength()+1] = g_prfj2_d_t.prfkseq
            
               #刪除同層單身
               IF NOT aprt504_delete_b('prfk_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt504_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt504_key_delete_b(gs_keys,'prfk_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt504_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt504_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_prfj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prfj2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM prfk_t 
             WHERE prfkent = g_enterprise AND prfkdocno = g_prfi_m.prfidocno
               AND prfkseq = g_prfj2_d[l_ac].prfkseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfi_m.prfidocno
               LET gs_keys[2] = g_prfj2_d[g_detail_idx].prfkseq
               CALL aprt504_insert_b('prfk_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prfj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prfk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt504_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prfj2_d[l_ac].* = g_prfj2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt504_bcl2
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
               LET g_prfj2_d[l_ac].* = g_prfj2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aprt504_prfk_t_mask_restore('restore_mask_o')
                              
               UPDATE prfk_t SET (prfkdocno,prfkseq,prfk001,prfk002,prfksite,prfkunit) = (g_prfi_m.prfidocno, 
                   g_prfj2_d[l_ac].prfkseq,g_prfj2_d[l_ac].prfk001,g_prfj2_d[l_ac].prfk002,g_prfj2_d[l_ac].prfksite, 
                   g_prfj2_d[l_ac].prfkunit) #自訂欄位頁簽
                WHERE prfkent = g_enterprise AND prfkdocno = g_prfi_m.prfidocno
                  AND prfkseq = g_prfj2_d_t.prfkseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prfj2_d[l_ac].* = g_prfj2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prfk_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prfj2_d[l_ac].* = g_prfj2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prfk_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfi_m.prfidocno
               LET gs_keys_bak[1] = g_prfidocno_t
               LET gs_keys[2] = g_prfj2_d[g_detail_idx].prfkseq
               LET gs_keys_bak[2] = g_prfj2_d_t.prfkseq
               CALL aprt504_update_b('prfk_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprt504_prfk_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prfj2_d[g_detail_idx].prfkseq = g_prfj2_d_t.prfkseq 
                  ) THEN
                  LET gs_keys[01] = g_prfi_m.prfidocno
                  LET gs_keys[gs_keys.getLength()+1] = g_prfj2_d_t.prfkseq
                  CALL aprt504_key_update_b(gs_keys,'prfk_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prfi_m),util.JSON.stringify(g_prfj2_d_t)
               LET g_log2 = util.JSON.stringify(g_prfi_m),util.JSON.stringify(g_prfj2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfkseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfj2_d[l_ac].prfkseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prfkseq
            END IF 
 
 
 
            #add-point:AFTER FIELD prfkseq name="input.a.page2.prfkseq"
            IF NOT cl_null(g_prfj2_d[l_ac].prfkseq) THEN 
            END IF 


            #此段落由子樣板a05產生
            IF  g_prfi_m.prfidocno IS NOT NULL AND g_prfj2_d[g_detail_idx].prfkseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfi_m.prfidocno != g_prfidocno_t OR g_prfj2_d[g_detail_idx].prfkseq != g_prfj2_d_t.prfkseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfk_t WHERE "||"prfkent = '" ||g_enterprise|| "' AND "||"prfkdocno = '"||g_prfi_m.prfidocno ||"' AND "|| "prfkseq = '"||g_prfj2_d[g_detail_idx].prfkseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfkseq
            #add-point:BEFORE FIELD prfkseq name="input.b.page2.prfkseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfkseq
            #add-point:ON CHANGE prfkseq name="input.g.page2.prfkseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfk001
            #add-point:BEFORE FIELD prfk001 name="input.b.page2.prfk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfk001
            
            #add-point:AFTER FIELD prfk001 name="input.a.page2.prfk001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfk001
            #add-point:ON CHANGE prfk001 name="input.g.page2.prfk001"
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prfj2_d[l_ac].prfk001 != g_prfj2_d_t.prfk001 OR g_prfj2_d_t.prfk001 IS null)) THEN 
               LET g_prfj2_d[l_ac].prfk002 = NULL
               LET g_prfj2_d[l_ac].prfk002_desc = NULL
               DISPLAY g_prfj2_d[l_ac].prfk002 TO s_detail2[l_ac].prfk002
               DISPLAY g_prfj2_d[l_ac].prfk002_desc TO s_detail2[l_ac].prfk002_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfk002
            
            #add-point:AFTER FIELD prfk002 name="input.a.page2.prfk002"

            LET g_prfj2_d[l_ac].prfk002_desc = NULL
            DISPLAY g_prfj2_d[l_ac].prfk002_desc TO s_detail2[l_ac].prfk002_desc
            IF NOT cl_null(g_prfj2_d[l_ac].prfk002) THEN 
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prfj2_d[l_ac].prfk002 != g_prfj2_d_t.prfk002 OR g_prfj2_d_t.prfk002 IS null)) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_prfj2_d[l_ac].prfk002
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_prfj2_d[l_ac].prfk002 = g_prfj2_d_t.prfk002
#                  CALL aprt504_prfk002_ref()
#                  NEXT FIELD CURRENT
#               END IF
               IF s_aooi500_setpoint(g_prog,'prfk002') THEN
                  CALL s_aooi500_chk(g_prog,'prfk002',g_prfj2_d[l_ac].prfk002,g_prfi_m.prfisite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_prfj2_d[l_ac].prfk002
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     LET g_prfj2_d[l_ac].prfk002 = g_prfj2_d_t.prfk002
                     CALL aprt504_prfk002_ref()
                     DISPLAY BY NAME g_prfj2_d[l_ac].prfk002,g_prfj2_d[l_ac].prfk002_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfj2_d[l_ac].prfk002
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#15 by 07900 --add-end
                     
                  #呼叫檢查存在並帶值的library
                  #IF cl_chk_exist("v_ooef001") THEN      #161024-00025#1 mark
                  IF cl_chk_exist("v_ooef001_20") THEN      #161024-00025#1 add
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfj2_d[l_ac].prfk002 = g_prfj2_d_t.prfk002
                     CALL aprt504_prfk002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
                             
               CALL aprt504_prfk002()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prfj2_d[l_ac].prfk002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prfj2_d[l_ac].prfk002 = g_prfj2_d_t.prfk002
                  CALL aprt504_prfk002_ref()
                  NEXT FIELD prfk002
               END IF
            END IF
            END IF
            CALL aprt504_prfk002_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfk002
            #add-point:BEFORE FIELD prfk002 name="input.b.page2.prfk002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfk002
            #add-point:ON CHANGE prfk002 name="input.g.page2.prfk002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfksite
            #add-point:BEFORE FIELD prfksite name="input.b.page2.prfksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfksite
            
            #add-point:AFTER FIELD prfksite name="input.a.page2.prfksite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfksite
            #add-point:ON CHANGE prfksite name="input.g.page2.prfksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfkunit
            #add-point:BEFORE FIELD prfkunit name="input.b.page2.prfkunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfkunit
            
            #add-point:AFTER FIELD prfkunit name="input.a.page2.prfkunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfkunit
            #add-point:ON CHANGE prfkunit name="input.g.page2.prfkunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.prfkseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfkseq
            #add-point:ON ACTION controlp INFIELD prfkseq name="input.c.page2.prfkseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prfk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfk001
            #add-point:ON ACTION controlp INFIELD prfk001 name="input.c.page2.prfk001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prfk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfk002
            #add-point:ON ACTION controlp INFIELD prfk002 name="input.c.page2.prfk002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfj2_d[l_ac].prfk002             #給予default值
            LET g_qryparam.default2 = g_prfj2_d[l_ac].prfk002_desc

            #給予arg
            
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'prfk002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfk002',g_prfi_m.prfisite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
               CALL q_ooef001_24()
            ELSE
               #CALL q_ooef001()        #161024-00025#1 mark
               LET g_qryparam.where = " ooef201 = 'Y' "    #161024-00025#1 add
               CALL q_ooef001_24()      #161024-00025#1 add
            END IF
            
            LET g_prfj2_d[l_ac].prfk002 = g_qryparam.return1  
#            LET g_prfj2_d[l_ac].prfk002_desc = g_qryparam.return2             

            DISPLAY g_prfj2_d[l_ac].prfk002 TO prfk002              #
#            DISPLAY g_prfj2_d[l_ac].prfk002_desc TO prfk002_desc
            CALL aprt504_prfk002_ref()
            NEXT FIELD prfk002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.prfksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfksite
            #add-point:ON ACTION controlp INFIELD prfksite name="input.c.page2.prfksite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prfkunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfkunit
            #add-point:ON ACTION controlp INFIELD prfkunit name="input.c.page2.prfkunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prfj2_d[l_ac].* = g_prfj2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt504_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprt504_unlock_b("prfk_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prfj2_d[li_reproduce_target].* = g_prfj2_d[li_reproduce].*
 
               LET g_prfj2_d[li_reproduce_target].prfkseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prfj2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prfj2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_prfj3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prfj3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt504_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prfj3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prfj3_d[l_ac].* TO NULL 
            INITIALIZE g_prfj3_d_t.* TO NULL 
            INITIALIZE g_prfj3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_prfj3_d[l_ac].prfl007 = "0"
      LET g_prfj3_d[l_ac].prfl008 = "0"
      LET g_prfj3_d[l_ac].prfl010 = "0"
      LET g_prfj3_d[l_ac].prfl011 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_prfj3_d_t.* = g_prfj3_d[l_ac].*     #新輸入資料
            LET g_prfj3_d_o.* = g_prfj3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt504_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt504_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prfj3_d[li_reproduce_target].* = g_prfj3_d[li_reproduce].*
 
               LET g_prfj3_d[li_reproduce_target].prflseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            CALL aprt504_create_prflseq()
            LET g_prfj3_d[l_ac].prflunit = g_prfi_m.prfiunit
            LET g_prfj3_d[l_ac].prflsite = g_prfi_m.prfisite
            LET g_prfj3_d[l_ac].prfl002 = g_prfi_m.prfi002
            LET g_prfj3_d[l_ac].prfl003 = g_prfi_m.prfi003
            LET g_prfj3_d[l_ac].prfl004 = g_prfi_m.prfi004
            LET g_prfj3_d[l_ac].prfl005 = g_prfi_m.prfi005
            CALL aprt504_prfl002_ref()
            CALL aprt504_prfl003_ref()
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprt504_cl USING g_enterprise,g_prfi_m.prfidocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt504_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt504_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prfj3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prfj3_d[l_ac].prflseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prfj3_d_t.* = g_prfj3_d[l_ac].*  #BACKUP
               LET g_prfj3_d_o.* = g_prfj3_d[l_ac].*  #BACKUP
               CALL aprt504_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aprt504_set_no_entry_b(l_cmd)
               IF NOT aprt504_lock_b("prfl_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt504_bcl3 INTO g_prfj3_d[l_ac].prflseq,g_prfj3_d[l_ac].prfl014,g_prfj3_d[l_ac].prfl001, 
                      g_prfj3_d[l_ac].prfl002,g_prfj3_d[l_ac].prfl003,g_prfj3_d[l_ac].prfl004,g_prfj3_d[l_ac].prfl005, 
                      g_prfj3_d[l_ac].prfl006,g_prfj3_d[l_ac].prfl007,g_prfj3_d[l_ac].prfl008,g_prfj3_d[l_ac].prfl009, 
                      g_prfj3_d[l_ac].prfl010,g_prfj3_d[l_ac].prfl011,g_prfj3_d[l_ac].prfl012,g_prfj3_d[l_ac].prfl013, 
                      g_prfj3_d[l_ac].prflsite,g_prfj3_d[l_ac].prflunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prfj3_d_mask_o[l_ac].* =  g_prfj3_d[l_ac].*
                  CALL aprt504_prfl_t_mask()
                  LET g_prfj3_d_mask_n[l_ac].* =  g_prfj3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt504_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prfi_m.prfidocno
               LET gs_keys[gs_keys.getLength()+1] = g_prfj3_d_t.prflseq
            
               #刪除同層單身
               IF NOT aprt504_delete_b('prfl_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt504_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt504_key_delete_b(gs_keys,'prfl_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt504_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt504_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_prfj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prfj3_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM prfl_t 
             WHERE prflent = g_enterprise AND prfldocno = g_prfi_m.prfidocno
               AND prflseq = g_prfj3_d[l_ac].prflseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfi_m.prfidocno
               LET gs_keys[2] = g_prfj3_d[g_detail_idx].prflseq
               CALL aprt504_insert_b('prfl_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prfj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prfl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt504_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prfj3_d[l_ac].* = g_prfj3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt504_bcl3
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
               LET g_prfj3_d[l_ac].* = g_prfj3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aprt504_prfl_t_mask_restore('restore_mask_o')
                              
               UPDATE prfl_t SET (prfldocno,prflseq,prfl014,prfl001,prfl002,prfl003,prfl004,prfl005, 
                   prfl006,prfl007,prfl008,prfl009,prfl010,prfl011,prfl012,prfl013,prflsite,prflunit) = (g_prfi_m.prfidocno, 
                   g_prfj3_d[l_ac].prflseq,g_prfj3_d[l_ac].prfl014,g_prfj3_d[l_ac].prfl001,g_prfj3_d[l_ac].prfl002, 
                   g_prfj3_d[l_ac].prfl003,g_prfj3_d[l_ac].prfl004,g_prfj3_d[l_ac].prfl005,g_prfj3_d[l_ac].prfl006, 
                   g_prfj3_d[l_ac].prfl007,g_prfj3_d[l_ac].prfl008,g_prfj3_d[l_ac].prfl009,g_prfj3_d[l_ac].prfl010, 
                   g_prfj3_d[l_ac].prfl011,g_prfj3_d[l_ac].prfl012,g_prfj3_d[l_ac].prfl013,g_prfj3_d[l_ac].prflsite, 
                   g_prfj3_d[l_ac].prflunit) #自訂欄位頁簽
                WHERE prflent = g_enterprise AND prfldocno = g_prfi_m.prfidocno
                  AND prflseq = g_prfj3_d_t.prflseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prfj3_d[l_ac].* = g_prfj3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prfl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prfj3_d[l_ac].* = g_prfj3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prfl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prfi_m.prfidocno
               LET gs_keys_bak[1] = g_prfidocno_t
               LET gs_keys[2] = g_prfj3_d[g_detail_idx].prflseq
               LET gs_keys_bak[2] = g_prfj3_d_t.prflseq
               CALL aprt504_update_b('prfl_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprt504_prfl_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prfj3_d[g_detail_idx].prflseq = g_prfj3_d_t.prflseq 
                  ) THEN
                  LET gs_keys[01] = g_prfi_m.prfidocno
                  LET gs_keys[gs_keys.getLength()+1] = g_prfj3_d_t.prflseq
                  CALL aprt504_key_update_b(gs_keys,'prfl_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prfi_m),util.JSON.stringify(g_prfj3_d_t)
               LET g_log2 = util.JSON.stringify(g_prfi_m),util.JSON.stringify(g_prfj3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prflseq
            #add-point:BEFORE FIELD prflseq name="input.b.page3.prflseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prflseq
            
            #add-point:AFTER FIELD prflseq name="input.a.page3.prflseq"
            #此段落由子樣板a05產生
            IF  g_prfi_m.prfidocno IS NOT NULL AND g_prfj3_d[g_detail_idx].prflseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prfi_m.prfidocno != g_prfidocno_t OR g_prfj3_d[g_detail_idx].prflseq != g_prfj3_d_t.prflseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prfl_t WHERE "||"prflent = '" ||g_enterprise|| "' AND "||"prfldocno = '"||g_prfi_m.prfidocno ||"' AND "|| "prflseq = '"||g_prfj3_d[g_detail_idx].prflseq ||"'",'std-00004',0) THEN 
                     LET g_prfj3_d[l_ac].prflseq = g_prfj3_d_t.prflseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prflseq
            #add-point:ON CHANGE prflseq name="input.g.page3.prflseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl014
            
            #add-point:AFTER FIELD prfl014 name="input.a.page3.prfl014"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl014) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prfj3_d[l_ac].prfl014

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imay003_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_prfj3_d[l_ac].prfl001 = ''
                  LET g_prfj3_d[l_ac].prfl014 = g_prfj3_d_t.prfl014
                  DISPLAY BY NAME g_prfj3_d[l_ac].prfl001,g_prfj3_d[l_ac].prfl014
                  NEXT FIELD CURRENT
               END IF
            
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prfj3_d[l_ac].prfl014 != g_prfj3_d_t.prfl014 OR g_prfj3_d_t.prfl014 IS null)) THEN 
                  SELECT imay001 INTO g_prfj3_d[l_ac].prfl001
                    FROM imay_t
                   WHERE imayent = g_enterprise
                     AND imay003 = g_prfj3_d[l_ac].prfl014
                  CALL aprt504_prfl001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prfj3_d[l_ac].prfl001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     LET g_prfj3_d[l_ac].prfl001 = ''
                     LET g_prfj3_d[l_ac].prfl014 = g_prfj3_d_t.prfl014
                     DISPLAY BY NAME g_prfj3_d[l_ac].prfl001,g_prfj3_d[l_ac].prfl014
                     CALL aprt504_prfl001_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt504_prfl001_ref()
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl014
            #add-point:BEFORE FIELD prfl014 name="input.b.page3.prfl014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl014
            #add-point:ON CHANGE prfl014 name="input.g.page3.prfl014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl001
            
            #add-point:AFTER FIELD prfl001 name="input.a.page3.prfl001"
            LET g_prfj3_d[l_ac].prfl001_desc = null
            LET g_prfj3_d[l_ac].imaal004 = null
            LET g_prfj3_d[l_ac].prfl006 = null
            LET g_prfj3_d[l_ac].prfl006_desc = null
            DISPLAY  g_prfj3_d[l_ac].prfl001_desc to s_detail3[l_ac].prfl001_desc
            DISPLAY  g_prfj3_d[l_ac].imaal004 to s_detail3[l_ac].imaal004
            DISPLAY  g_prfj3_d[l_ac].prfl006 to s_detail3[l_ac].prfl006
            DISPLAY  g_prfj3_d[l_ac].prfl006_desc to s_detail3[l_ac].prfl006_desc
            IF NOT cl_null(g_prfj3_d[l_ac].prfl001) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prfj3_d[l_ac].prfl001 != g_prfj3_d_t.prfl001 OR g_prfj3_d_t.prfl001 IS null)) THEN    #160824-00007#151 20161101 mark by beckxie
               IF g_prfj3_d[l_ac].prfl001 != g_prfj3_d_o.prfl001 OR cl_null(g_prfj3_d_o.prfl001) THEN    #160824-00007#151 20161101 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                    #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfj3_d[l_ac].prfl001
                   #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
                  LET g_chkparam.err_str[2] ="aim-00121:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
                  #160318-00025#15 by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_imaa001_5") THEN
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_prfj3_d[l_ac].prfl001 = g_prfj3_d_t.prfl001   #160824-00007#151 20161101 mark by beckxie
                     #160824-00007#150 20161101 add by beckxie---S
                     LET g_prfj3_d[l_ac].prfl001 = g_prfj3_d_o.prfl001   
                     LET g_prfj3_d[l_ac].prfl014 = g_prfj3_d_o.prfl014  
                     #160824-00007#150 20161101 add by beckxie---E
                     call aprt504_prfl001_ref()
                     NEXT FIELD CURRENT
                  END IF
                  CALL aprt504_prfl001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prfj3_d[l_ac].prfl001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_prfj3_d[l_ac].prfl001 = g_prfj3_d_t.prfl001   #160824-00007#151 20161101 mark by beckxie
                     #160824-00007#150 20161101 add by beckxie---S
                     LET g_prfj3_d[l_ac].prfl001 = g_prfj3_d_o.prfl001   
                     LET g_prfj3_d[l_ac].prfl014 = g_prfj3_d_o.prfl014  
                     #160824-00007#150 20161101 add by beckxie---E
                     CALL aprt504_prfl001_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #帶出條碼
                  IF cl_null(g_prfj3_d[l_ac].prfl014) THEN
                     SELECT imaa014 INTO g_prfj3_d[l_ac].prfl014
                       FROM imaa_t
                      WHERE imaaent = g_enterprise
                        AND imaa001 = g_prfj3_d[l_ac].prfl001
                  ELSE
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n
                       FROM imay_t
                      WHERE imayent = g_enterprise
                        AND imay001 = g_prfj3_d[l_ac].prfl001
                        AND imay003 = g_prfj3_d[l_ac].prfl014
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "" 
                        LET g_errparam.code   = "art-00274" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        
                        #LET g_prfj3_d[l_ac].prfl001 = g_prfj3_d_t.prfl014   #160824-00007#151 20161101 mark by beckxie
                        #160824-00007#150 20161101 add by beckxie---S
                        LET g_prfj3_d[l_ac].prfl001 = g_prfj3_d_o.prfl001   
                        LET g_prfj3_d[l_ac].prfl014 = g_prfj3_d_o.prfl014  
                        #160824-00007#150 20161101 add by beckxie---E
                        DISPLAY BY NAME g_prfj3_d[l_ac].prfl001
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            END IF 
            CALL aprt504_prfl001_ref()
            LET  g_prfj3_d_o.* = g_prfj3_d[l_ac].*   #160824-00007#150 20161101 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl001
            #add-point:BEFORE FIELD prfl001 name="input.b.page3.prfl001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl001
            #add-point:ON CHANGE prfl001 name="input.g.page3.prfl001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl002
            
            #add-point:AFTER FIELD prfl002 name="input.a.page3.prfl002"
            LET g_prfj3_d[l_ac].prfl002_desc = NULL
            DISPLAY  g_prfj3_d[l_ac].prfl002_desc to s_detail3[l_ac].prfl002_desc
            IF NOT cl_null(g_prfj3_d[l_ac].prfl002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prfj3_d[l_ac].prfl002 != g_prfj3_d_t.prfl002 OR g_prfj3_d_t.prfl002 IS null)) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfi_m.prfisite
                  LET g_chkparam.arg2 = g_prfj3_d[l_ac].prfl002
                   #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#15 by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooaj002") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfj3_d[l_ac].prfl002 = g_prfj3_d_t.prfl002
                     CALL aprt504_prfl002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            CALL aprt504_prfl002_ref()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl002
            #add-point:BEFORE FIELD prfl002 name="input.b.page3.prfl002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl002
            #add-point:ON CHANGE prfl002 name="input.g.page3.prfl002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl003
            
            #add-point:AFTER FIELD prfl003 name="input.a.page3.prfl003"
            LET g_prfj3_d[l_ac].prfl003_desc = NULL
            DISPLAY  g_prfj3_d[l_ac].prfl003_desc TO s_detail3[l_ac].prfl003_desc
            IF NOT cl_null(g_prfj3_d[l_ac].prfl003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_prfj3_d[l_ac].prfl003 != g_prfj3_d_t.prfl003 OR g_prfj3_d_t.prfl003 IS null)) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                   #160318-00025#15 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  #160318-00025#15 by 07900 --add-end
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prfi_m.prfisite
                  LET g_chkparam.arg2 = g_prfj3_d[l_ac].prfl003
                  #160318-00025#15 by 07900 --add-str 
                  LET g_chkparam.err_str[1] ="aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#15 by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oodb002") THEN 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_prfj3_d[l_ac].prfl003 = g_prfj3_d_t.prfl003
                     CALL aprt504_prfl003_ref()
                     NEXT FIELD CURRENT
                  END IF
            
               END IF
            END IF 
            CALL aprt504_prfl003_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl003
            #add-point:BEFORE FIELD prfl003 name="input.b.page3.prfl003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl003
            #add-point:ON CHANGE prfl003 name="input.g.page3.prfl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl004
            #add-point:BEFORE FIELD prfl004 name="input.b.page3.prfl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl004
            
            #add-point:AFTER FIELD prfl004 name="input.a.page3.prfl004"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl004)  THEN
               IF g_prfj3_d[l_ac].prfl004<g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axc-00066"
                  LET g_errparam.extend = g_prfj3_d[l_ac].prfl004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prfj3_d[l_ac].prfl004 = g_prfj3_d_t.prfl004
                  NEXT FIELD prfl004
               END IF
               IF NOT cl_null(g_prfj3_d[l_ac].prfl005) THEN
                  IF g_prfj3_d[l_ac].prfl004>g_prfj3_d[l_ac].prfl005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00047"
                     LET g_errparam.extend = g_prfj3_d[l_ac].prfl004||'>'||g_prfj3_d[l_ac].prfl005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prfj3_d[l_ac].prfl004 = g_prfj3_d_t.prfl004
                     NEXT FIELD prfl004
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl004
            #add-point:ON CHANGE prfl004 name="input.g.page3.prfl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl005
            #add-point:BEFORE FIELD prfl005 name="input.b.page3.prfl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl005
            
            #add-point:AFTER FIELD prfl005 name="input.a.page3.prfl005"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl005)  THEN
               IF g_prfj3_d[l_ac].prfl005<g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "axc-00066"
                  LET g_errparam.extend = g_prfj3_d[l_ac].prfl005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prfj3_d[l_ac].prfl005 = g_prfj3_d_t.prfl005
                  NEXT FIELD prfl005
               END IF
               IF NOT cl_null(g_prfj3_d[l_ac].prfl004) THEN
                  IF g_prfj3_d[l_ac].prfl004>g_prfj3_d[l_ac].prfl005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00047"
                     LET g_errparam.extend = g_prfj3_d[l_ac].prfl004||'>'||g_prfj3_d[l_ac].prfl005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prfj3_d[l_ac].prfl005 = g_prfj3_d_t.prfl005
                     NEXT FIELD prfl005
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl005
            #add-point:ON CHANGE prfl005 name="input.g.page3.prfl005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl006
            
            #add-point:AFTER FIELD prfl006 name="input.a.page3.prfl006"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
                #160318-00025#15 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               #160318-00025#15 by 07900 --add-end
               #設定g_chkparam.*的參數

                #160318-00025#15 by 07900 --add-str 
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#15 by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl006
            #add-point:BEFORE FIELD prfl006 name="input.b.page3.prfl006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl006
            #add-point:ON CHANGE prfl006 name="input.g.page3.prfl006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfj3_d[l_ac].prfl007,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prfl007
            END IF 
 
 
 
            #add-point:AFTER FIELD prfl007 name="input.a.page3.prfl007"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl007) THEN
               CALL aprt504_count_prfl009()           
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl007
            #add-point:BEFORE FIELD prfl007 name="input.b.page3.prfl007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl007
            #add-point:ON CHANGE prfl007 name="input.g.page3.prfl007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfj3_d[l_ac].prfl008,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prfl008
            END IF 
 
 
 
            #add-point:AFTER FIELD prfl008 name="input.a.page3.prfl008"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl008) THEN
               CALL aprt504_count_prfl009()            
            END IF 
            IF cl_null(g_prfj3_d[l_ac].prfl010) or g_prfj3_d[l_ac].prfl010=0 THEN
               LET g_prfj3_d[l_ac].prfl010 = g_prfj3_d[l_ac].prfl008
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl008
            #add-point:BEFORE FIELD prfl008 name="input.b.page3.prfl008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl008
            #add-point:ON CHANGE prfl008 name="input.g.page3.prfl008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl009
            #add-point:BEFORE FIELD prfl009 name="input.b.page3.prfl009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl009
            
            #add-point:AFTER FIELD prfl009 name="input.a.page3.prfl009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl009
            #add-point:ON CHANGE prfl009 name="input.g.page3.prfl009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfj3_d[l_ac].prfl010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prfl010
            END IF 
 
 
 
            #add-point:AFTER FIELD prfl010 name="input.a.page3.prfl010"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl010) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl010
            #add-point:BEFORE FIELD prfl010 name="input.b.page3.prfl010"
            IF cl_null(g_prfj3_d[l_ac].prfl010) THEN
               LET g_prfj3_d[l_ac].prfl010 = g_prfj3_d[l_ac].prfl008
            END IF            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl010
            #add-point:ON CHANGE prfl010 name="input.g.page3.prfl010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfj3_d[l_ac].prfl011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prfl011
            END IF 
 
 
 
            #add-point:AFTER FIELD prfl011 name="input.a.page3.prfl011"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl011) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl011
            #add-point:BEFORE FIELD prfl011 name="input.b.page3.prfl011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl011
            #add-point:ON CHANGE prfl011 name="input.g.page3.prfl011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfj3_d[l_ac].prfl012,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prfl012
            END IF 
 
 
 
            #add-point:AFTER FIELD prfl012 name="input.a.page3.prfl012"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl012
            #add-point:BEFORE FIELD prfl012 name="input.b.page3.prfl012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl012
            #add-point:ON CHANGE prfl012 name="input.g.page3.prfl012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prfl013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prfj3_d[l_ac].prfl013,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD prfl013
            END IF 
 
 
 
            #add-point:AFTER FIELD prfl013 name="input.a.page3.prfl013"
            IF NOT cl_null(g_prfj3_d[l_ac].prfl013) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prfl013
            #add-point:BEFORE FIELD prfl013 name="input.b.page3.prfl013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prfl013
            #add-point:ON CHANGE prfl013 name="input.g.page3.prfl013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prflsite
            #add-point:BEFORE FIELD prflsite name="input.b.page3.prflsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prflsite
            
            #add-point:AFTER FIELD prflsite name="input.a.page3.prflsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prflsite
            #add-point:ON CHANGE prflsite name="input.g.page3.prflsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prflunit
            #add-point:BEFORE FIELD prflunit name="input.b.page3.prflunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prflunit
            
            #add-point:AFTER FIELD prflunit name="input.a.page3.prflunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prflunit
            #add-point:ON CHANGE prflunit name="input.g.page3.prflunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.prflseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prflseq
            #add-point:ON ACTION controlp INFIELD prflseq name="input.c.page3.prflseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl014
            #add-point:ON ACTION controlp INFIELD prfl014 name="input.c.page3.prfl014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfj3_d[l_ac].prfl014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            
            CALL q_imay003_2()                                #呼叫開窗

            LET g_prfj3_d[l_ac].prfl014 = g_qryparam.return1              

            DISPLAY g_prfj3_d[l_ac].prfl014 TO prfl014              #

            NEXT FIELD prfl014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl001
            #add-point:ON ACTION controlp INFIELD prfl001 name="input.c.page3.prfl001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfj3_d[l_ac].prfl001             #給予default值

            #給予arg         
            CALL q_imaa001()                                #呼叫開窗

            LET g_prfj3_d[l_ac].prfl001 = g_qryparam.return1              

            DISPLAY g_prfj3_d[l_ac].prfl001 TO prfl001              #
            CALL aprt504_prfl001_ref() 
            NEXT FIELD prfl001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl002
            #add-point:ON ACTION controlp INFIELD prfl002 name="input.c.page3.prfl002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfj3_d[l_ac].prfl002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_prfi_m.prfisite 
            CALL q_ooaj002_3()                                #呼叫開窗

            LET g_prfj3_d[l_ac].prfl002 = g_qryparam.return1              

            DISPLAY g_prfj3_d[l_ac].prfl002 TO prfl002              #
            CALL aprt504_prfl002_ref()
            NEXT FIELD prfl002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl003
            #add-point:ON ACTION controlp INFIELD prfl003 name="input.c.page3.prfl003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfj3_d[l_ac].prfl003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_prfi_m.prfisite #

            
            CALL q_oodb002_8()                                #呼叫開窗

            LET g_prfj3_d[l_ac].prfl003 = g_qryparam.return1              

            DISPLAY g_prfj3_d[l_ac].prfl003 TO prfl003              #
            CALL aprt504_prfl003_ref()
            NEXT FIELD prfl003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl004
            #add-point:ON ACTION controlp INFIELD prfl004 name="input.c.page3.prfl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl005
            #add-point:ON ACTION controlp INFIELD prfl005 name="input.c.page3.prfl005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl006
            #add-point:ON ACTION controlp INFIELD prfl006 name="input.c.page3.prfl006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prfj3_d[l_ac].prfl006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_prfj3_d[l_ac].prfl006 = g_qryparam.return1              

            DISPLAY g_prfj3_d[l_ac].prfl006 TO prfl006              #

            NEXT FIELD prfl006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl007
            #add-point:ON ACTION controlp INFIELD prfl007 name="input.c.page3.prfl007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl008
            #add-point:ON ACTION controlp INFIELD prfl008 name="input.c.page3.prfl008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl009
            #add-point:ON ACTION controlp INFIELD prfl009 name="input.c.page3.prfl009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl010
            #add-point:ON ACTION controlp INFIELD prfl010 name="input.c.page3.prfl010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl011
            #add-point:ON ACTION controlp INFIELD prfl011 name="input.c.page3.prfl011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl012
            #add-point:ON ACTION controlp INFIELD prfl012 name="input.c.page3.prfl012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prfl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prfl013
            #add-point:ON ACTION controlp INFIELD prfl013 name="input.c.page3.prfl013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prflsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prflsite
            #add-point:ON ACTION controlp INFIELD prflsite name="input.c.page3.prflsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prflunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prflunit
            #add-point:ON ACTION controlp INFIELD prflunit name="input.c.page3.prflunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prfj3_d[l_ac].* = g_prfj3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt504_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprt504_unlock_b("prfl_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prfj3_d[li_reproduce_target].* = g_prfj3_d[li_reproduce].*
 
               LET g_prfj3_d[li_reproduce_target].prflseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prfj3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prfj3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aprt504.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD prfisite #ken---add 需求單號：141208-00001 項次：29
            #end add-point  
            NEXT FIELD prfidocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prfjseq
               WHEN "s_detail2"
                  NEXT FIELD prfkseq
               WHEN "s_detail3"
                  NEXT FIELD prflseq
 
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt504_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt504_b_fill() #單身填充
      CALL aprt504_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt504_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prfiunit
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfi_m.prfiunit_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prfiunit_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prfi002
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfi_m.prfi002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prfi002_desc
#
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfi_m.prfi003
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfi_m.prfi003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfi_m.prfi003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prfi006
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfi_m.prfi006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prfi006_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prfi007
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfi_m.prfi007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prfi007_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prfiownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfi_m.prfiownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prfiownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prfiowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfi_m.prfiowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prfiowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prficrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfi_m.prficrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prficrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prficrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfi_m.prficrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prficrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prfimodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfi_m.prfimodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prfimodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfi_m.prficnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prfi_m.prficnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfi_m.prficnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_prfi_m_mask_o.* =  g_prfi_m.*
   CALL aprt504_prfi_t_mask()
   LET g_prfi_m_mask_n.* =  g_prfi_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prfi_m.prfisite,g_prfi_m.prfisite_desc,g_prfi_m.prfidocdt,g_prfi_m.prfidocno,g_prfi_m.prfi001, 
       g_prfi_m.prfiunit,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002,g_prfi_m.prfi002_desc,g_prfi_m.prfi003, 
       g_prfi_m.prfi003_desc,g_prfi_m.prfi004,g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi006_desc, 
       g_prfi_m.prfi007,g_prfi_m.prfi007_desc,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiownid_desc, 
       g_prfi_m.prfiowndp,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid,g_prfi_m.prficrtid_desc,g_prfi_m.prficrtdp, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimodid_desc,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfid_desc,g_prfi_m.prficnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfi_m.prfistus 
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
   FOR l_ac = 1 TO g_prfj_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfj_d[l_ac].prfj001
#            CALL ap_ref_array2(g_ref_fields,"SELECT prfgl003 FROM prfgl_t WHERE prfglent='"||g_enterprise||"' AND prfgl001=? AND prfgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfj_d[l_ac].prfj001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfj_d[l_ac].prfj001_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prfj2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"

            call aprt504_prfk002_ref()

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prfj3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl001
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl001_desc = '', g_rtn_fields[1] , ''
            LET g_prfj3_d[l_ac].imaal004 = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl001_desc
            DISPLAY BY NAME g_prfj3_d[l_ac].imaal004
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl002
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfj3_d[l_ac].prfl002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfj3_d[l_ac].prfl002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl003
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl003_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl006
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfj3_d[l_ac].prfl006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfj3_d[l_ac].prfl006_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt504_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt504_detail_show()
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
 
{<section id="aprt504.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt504_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prfi_t.prfidocno 
   DEFINE l_oldno     LIKE prfi_t.prfidocno 
 
   DEFINE l_master    RECORD LIKE prfi_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prfj_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prfk_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE prfl_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5
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
   
   IF g_prfi_m.prfidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prfidocno_t = g_prfi_m.prfidocno
 
    
   LET g_prfi_m.prfidocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prfi_m.prfiownid = g_user
      LET g_prfi_m.prfiowndp = g_dept
      LET g_prfi_m.prficrtid = g_user
      LET g_prfi_m.prficrtdp = g_dept 
      LET g_prfi_m.prficrtdt = cl_get_current()
      LET g_prfi_m.prfimodid = g_user
      LET g_prfi_m.prfimoddt = cl_get_current()
      LET g_prfi_m.prfistus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_prfi_m.prfi001 = "2"
   LET g_prfi_m.prficnfid = ""
   LET g_prfi_m.prficnfdt = ""
   LET g_prfi_m.prfistus = "N"
   LET g_prfi_m.prfidocdt = g_today
   CALL s_aooi500_default(g_prog,'prfisite',g_prfi_m.prfisite)
      RETURNING l_insert,g_prfi_m.prfisite
   IF NOT l_insert THEN
      RETURN
   END IF
   CALL aprt504_prfisite_ref()
   LET g_prfi_m.prfi006 = g_user
   CALL aprt504_prfi006_ref()
   CALL aprt504_prfi006_display()
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prfi_m.prfisite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prfi_m.prfidocno = r_doctype
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prfi_m.prfistus 
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
   
   
   CALL aprt504_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prfi_m.* TO NULL
      INITIALIZE g_prfj_d TO NULL
      INITIALIZE g_prfj2_d TO NULL
      INITIALIZE g_prfj3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt504_show()
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
   CALL aprt504_set_act_visible()   
   CALL aprt504_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prfidocno_t = g_prfi_m.prfidocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prfient = " ||g_enterprise|| " AND",
                      " prfidocno = '", g_prfi_m.prfidocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt504_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt504_idx_chk()
   
   LET g_data_owner = g_prfi_m.prfiownid      
   LET g_data_dept  = g_prfi_m.prfiowndp
   
   #功能已完成,通報訊息中心
   CALL aprt504_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt504_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prfj_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prfk_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE prfl_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt504_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prfj_t
    WHERE prfjent = g_enterprise AND prfjdocno = g_prfidocno_t
 
    INTO TEMP aprt504_detail
 
   #將key修正為調整後   
   UPDATE aprt504_detail 
      #更新key欄位
      SET prfjdocno = g_prfi_m.prfidocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prfj_t SELECT * FROM aprt504_detail
   
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
   DROP TABLE aprt504_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prfk_t 
    WHERE prfkent = g_enterprise AND prfkdocno = g_prfidocno_t
 
    INTO TEMP aprt504_detail
 
   #將key修正為調整後   
   UPDATE aprt504_detail SET prfkdocno = g_prfi_m.prfidocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prfk_t SELECT * FROM aprt504_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt504_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prfl_t 
    WHERE prflent = g_enterprise AND prfldocno = g_prfidocno_t
 
    INTO TEMP aprt504_detail
 
   #將key修正為調整後   
   UPDATE aprt504_detail SET prfldocno = g_prfi_m.prfidocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prfl_t SELECT * FROM aprt504_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   IF g_prfi_m.prfi004<>g_prfi_m_t.prfi004 THEN
      UPDATE prfl_t SET prfl004=g_prfi_m.prfi004
       WHERE prflent = g_enterprise AND prfldocno = g_prfi_m.prfidocno
   END IF
   IF g_prfi_m.prfi005<>g_prfi_m_t.prfi005 THEN
      UPDATE prfl_t SET prfl005=g_prfi_m.prfi005
       WHERE prflent = g_enterprise AND prfldocno = g_prfi_m.prfidocno
   END IF   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt504_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prfidocno_t = g_prfi_m.prfidocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt504_delete()
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
   
   IF g_prfi_m.prfidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aprt504_cl USING g_enterprise,g_prfi_m.prfidocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt504_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt504_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt504_master_referesh USING g_prfi_m.prfidocno INTO g_prfi_m.prfisite,g_prfi_m.prfidocdt, 
       g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004, 
       g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiowndp, 
       g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfdt,g_prfi_m.prfisite_desc,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002_desc, 
       g_prfi_m.prfi006_desc,g_prfi_m.prfi007_desc,g_prfi_m.prfiownid_desc,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid_desc, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prfimodid_desc,g_prfi_m.prficnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt504_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prfi_m_mask_o.* =  g_prfi_m.*
   CALL aprt504_prfi_t_mask()
   LET g_prfi_m_mask_n.* =  g_prfi_m.*
   
   CALL aprt504_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt504_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prfidocno_t = g_prfi_m.prfidocno
 
 
      DELETE FROM prfi_t
       WHERE prfient = g_enterprise AND prfidocno = g_prfi_m.prfidocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prfi_m.prfidocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #ken---add---s 需求單號：141208-00001 項次：29
      IF NOT s_aooi200_del_docno(g_prfi_m.prfidocno,g_prfi_m.prfidocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #ken---add---e
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM prfj_t
       WHERE prfjent = g_enterprise AND prfjdocno = g_prfi_m.prfidocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfj_t:",SQLERRMESSAGE 
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
      DELETE FROM prfk_t
       WHERE prfkent = g_enterprise AND
             prfkdocno = g_prfi_m.prfidocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM prfl_t
       WHERE prflent = g_enterprise AND
             prfldocno = g_prfi_m.prfidocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prfi_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt504_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prfj_d.clear() 
      CALL g_prfj2_d.clear()       
      CALL g_prfj3_d.clear()       
 
     
      CALL aprt504_ui_browser_refresh()  
      #CALL aprt504_ui_headershow()  
      #CALL aprt504_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt504_browser_fill("")
         CALL aprt504_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt504_cl
 
   #功能已完成,通報訊息中心
   CALL aprt504_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt504.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt504_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prfj_d.clear()
   CALL g_prfj2_d.clear()
   CALL g_prfj3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_prfj3_d_colour.clear()
   #end add-point
   
   #判斷是否填充
   IF aprt504_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prfjseq,prfj001,prfjsite,prfjunit ,t1.prfgl003 FROM prfj_t",  
               
                     " INNER JOIN prfi_t ON prfient = " ||g_enterprise|| " AND prfidocno = prfjdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN prfgl_t t1 ON t1.prfglent="||g_enterprise||" AND t1.prfgl001=prfj001 AND t1.prfgl002='"||g_dlang||"' ",
 
                     " WHERE prfjent=? AND prfjdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prfj_t.prfjseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt504_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt504_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prfi_m.prfidocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prfi_m.prfidocno INTO g_prfj_d[l_ac].prfjseq,g_prfj_d[l_ac].prfj001, 
          g_prfj_d[l_ac].prfjsite,g_prfj_d[l_ac].prfjunit,g_prfj_d[l_ac].prfj001_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_prfj_d[l_ac].prfj001
#         CALL ap_ref_array2(g_ref_fields,"SELECT prfgl003 FROM prfgl_t WHERE prfglent='"||g_enterprise||"' AND prfgl001=? AND prfgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_prfj_d[l_ac].prfj001_desc = '', g_rtn_fields[1] , ''
#         DISPLAY BY NAME g_prfj_d[l_ac].prfj001_desc
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
    
   #判斷是否填充
   IF aprt504_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prfkseq,prfk001,prfk002,prfksite,prfkunit ,t2.ooefl003 FROM prfk_t", 
                
                     " INNER JOIN  prfi_t ON prfient = " ||g_enterprise|| " AND prfidocno = prfkdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=prfk002 AND t2.ooefl002='"||g_dlang||"' ",
 
                     " WHERE prfkent=? AND prfkdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prfk_t.prfkseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt504_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aprt504_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_prfi_m.prfidocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_prfi_m.prfidocno INTO g_prfj2_d[l_ac].prfkseq,g_prfj2_d[l_ac].prfk001, 
          g_prfj2_d[l_ac].prfk002,g_prfj2_d[l_ac].prfksite,g_prfj2_d[l_ac].prfkunit,g_prfj2_d[l_ac].prfk002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF aprt504_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prflseq,prfl014,prfl001,prfl002,prfl003,prfl004,prfl005,prfl006, 
             prfl007,prfl008,prfl009,prfl010,prfl011,prfl012,prfl013,prflsite,prflunit ,t3.imaal003 , 
             t4.ooail003 ,t5.oocal003 FROM prfl_t",   
                     " INNER JOIN  prfi_t ON prfient = " ||g_enterprise|| " AND prfidocno = prfldocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=prfl001 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=prfl002 AND t4.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=prfl006 AND t5.oocal002='"||g_dlang||"' ",
 
                     " WHERE prflent=? AND prfldocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prfl_t.prflseq"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt504_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aprt504_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_prfi_m.prfidocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_prfi_m.prfidocno INTO g_prfj3_d[l_ac].prflseq,g_prfj3_d[l_ac].prfl014, 
          g_prfj3_d[l_ac].prfl001,g_prfj3_d[l_ac].prfl002,g_prfj3_d[l_ac].prfl003,g_prfj3_d[l_ac].prfl004, 
          g_prfj3_d[l_ac].prfl005,g_prfj3_d[l_ac].prfl006,g_prfj3_d[l_ac].prfl007,g_prfj3_d[l_ac].prfl008, 
          g_prfj3_d[l_ac].prfl009,g_prfj3_d[l_ac].prfl010,g_prfj3_d[l_ac].prfl011,g_prfj3_d[l_ac].prfl012, 
          g_prfj3_d[l_ac].prfl013,g_prfj3_d[l_ac].prflsite,g_prfj3_d[l_ac].prflunit,g_prfj3_d[l_ac].prfl001_desc, 
          g_prfj3_d[l_ac].prfl002_desc,g_prfj3_d[l_ac].prfl006_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl001
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl001_desc = '', g_rtn_fields[1] , ''
            LET g_prfj3_d[l_ac].imaal004 = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl001_desc
            DISPLAY BY NAME g_prfj3_d[l_ac].imaal004
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl002
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfj3_d[l_ac].prfl002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfj3_d[l_ac].prfl002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl003
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl003_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl006
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prfj3_d[l_ac].prfl006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prfj3_d[l_ac].prfl006_desc

         IF g_prfj3_d[l_ac].prfl009 < 0 THEN
            LET g_prfj3_d_colour[l_ac].prflseq = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl001 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl002 = "red reverse" 
            LET g_prfj3_d_colour[l_ac].prfl003 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl004 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl005 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl006 = "red reverse" 
            LET g_prfj3_d_colour[l_ac].prfl007 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl008 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl009 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl010 = "red reverse"            
            LET g_prfj3_d_colour[l_ac].prfl011 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl012 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl013 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prflsite = "red reverse" 
            LET g_prfj3_d_colour[l_ac].prflunit = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl001_desc = "red reverse"
            LET g_prfj3_d_colour[l_ac].imaal004 = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl002_desc = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl003_desc = "red reverse"
            LET g_prfj3_d_colour[l_ac].prfl006_desc = "red reverse"
         END IF
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_prfj_d.deleteElement(g_prfj_d.getLength())
   CALL g_prfj2_d.deleteElement(g_prfj2_d.getLength())
   CALL g_prfj3_d.deleteElement(g_prfj3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt504_pb
   FREE aprt504_pb2
 
   FREE aprt504_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prfj_d.getLength()
      LET g_prfj_d_mask_o[l_ac].* =  g_prfj_d[l_ac].*
      CALL aprt504_prfj_t_mask()
      LET g_prfj_d_mask_n[l_ac].* =  g_prfj_d[l_ac].*
   END FOR
   
   LET g_prfj2_d_mask_o.* =  g_prfj2_d.*
   FOR l_ac = 1 TO g_prfj2_d.getLength()
      LET g_prfj2_d_mask_o[l_ac].* =  g_prfj2_d[l_ac].*
      CALL aprt504_prfk_t_mask()
      LET g_prfj2_d_mask_n[l_ac].* =  g_prfj2_d[l_ac].*
   END FOR
   LET g_prfj3_d_mask_o.* =  g_prfj3_d.*
   FOR l_ac = 1 TO g_prfj3_d.getLength()
      LET g_prfj3_d_mask_o[l_ac].* =  g_prfj3_d[l_ac].*
      CALL aprt504_prfl_t_mask()
      LET g_prfj3_d_mask_n[l_ac].* =  g_prfj3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt504_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prfj_t
       WHERE prfjent = g_enterprise AND
         prfjdocno = ps_keys_bak[1] AND prfjseq = ps_keys_bak[2]
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
         CALL g_prfj_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM prfk_t
       WHERE prfkent = g_enterprise AND
             prfkdocno = ps_keys_bak[1] AND prfkseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prfj2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM prfl_t
       WHERE prflent = g_enterprise AND
             prfldocno = ps_keys_bak[1] AND prflseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prfj3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt504_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prfj_t
                  (prfjent,
                   prfjdocno,
                   prfjseq
                   ,prfj001,prfjsite,prfjunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prfj_d[g_detail_idx].prfj001,g_prfj_d[g_detail_idx].prfjsite,g_prfj_d[g_detail_idx].prfjunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prfj_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO prfk_t
                  (prfkent,
                   prfkdocno,
                   prfkseq
                   ,prfk001,prfk002,prfksite,prfkunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prfj2_d[g_detail_idx].prfk001,g_prfj2_d[g_detail_idx].prfk002,g_prfj2_d[g_detail_idx].prfksite, 
                       g_prfj2_d[g_detail_idx].prfkunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prfj2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO prfl_t
                  (prflent,
                   prfldocno,
                   prflseq
                   ,prfl014,prfl001,prfl002,prfl003,prfl004,prfl005,prfl006,prfl007,prfl008,prfl009,prfl010,prfl011,prfl012,prfl013,prflsite,prflunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prfj3_d[g_detail_idx].prfl014,g_prfj3_d[g_detail_idx].prfl001,g_prfj3_d[g_detail_idx].prfl002, 
                       g_prfj3_d[g_detail_idx].prfl003,g_prfj3_d[g_detail_idx].prfl004,g_prfj3_d[g_detail_idx].prfl005, 
                       g_prfj3_d[g_detail_idx].prfl006,g_prfj3_d[g_detail_idx].prfl007,g_prfj3_d[g_detail_idx].prfl008, 
                       g_prfj3_d[g_detail_idx].prfl009,g_prfj3_d[g_detail_idx].prfl010,g_prfj3_d[g_detail_idx].prfl011, 
                       g_prfj3_d[g_detail_idx].prfl012,g_prfj3_d[g_detail_idx].prfl013,g_prfj3_d[g_detail_idx].prflsite, 
                       g_prfj3_d[g_detail_idx].prflunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prfl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prfj3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt504_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prfj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt504_prfj_t_mask_restore('restore_mask_o')
               
      UPDATE prfj_t 
         SET (prfjdocno,
              prfjseq
              ,prfj001,prfjsite,prfjunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prfj_d[g_detail_idx].prfj001,g_prfj_d[g_detail_idx].prfjsite,g_prfj_d[g_detail_idx].prfjunit)  
 
         WHERE prfjent = g_enterprise AND prfjdocno = ps_keys_bak[1] AND prfjseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prfj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prfj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt504_prfj_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prfk_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprt504_prfk_t_mask_restore('restore_mask_o')
               
      UPDATE prfk_t 
         SET (prfkdocno,
              prfkseq
              ,prfk001,prfk002,prfksite,prfkunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prfj2_d[g_detail_idx].prfk001,g_prfj2_d[g_detail_idx].prfk002,g_prfj2_d[g_detail_idx].prfksite, 
                  g_prfj2_d[g_detail_idx].prfkunit) 
         WHERE prfkent = g_enterprise AND prfkdocno = ps_keys_bak[1] AND prfkseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prfk_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prfk_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt504_prfk_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prfl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprt504_prfl_t_mask_restore('restore_mask_o')
               
      UPDATE prfl_t 
         SET (prfldocno,
              prflseq
              ,prfl014,prfl001,prfl002,prfl003,prfl004,prfl005,prfl006,prfl007,prfl008,prfl009,prfl010,prfl011,prfl012,prfl013,prflsite,prflunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prfj3_d[g_detail_idx].prfl014,g_prfj3_d[g_detail_idx].prfl001,g_prfj3_d[g_detail_idx].prfl002, 
                  g_prfj3_d[g_detail_idx].prfl003,g_prfj3_d[g_detail_idx].prfl004,g_prfj3_d[g_detail_idx].prfl005, 
                  g_prfj3_d[g_detail_idx].prfl006,g_prfj3_d[g_detail_idx].prfl007,g_prfj3_d[g_detail_idx].prfl008, 
                  g_prfj3_d[g_detail_idx].prfl009,g_prfj3_d[g_detail_idx].prfl010,g_prfj3_d[g_detail_idx].prfl011, 
                  g_prfj3_d[g_detail_idx].prfl012,g_prfj3_d[g_detail_idx].prfl013,g_prfj3_d[g_detail_idx].prflsite, 
                  g_prfj3_d[g_detail_idx].prflunit) 
         WHERE prflent = g_enterprise AND prfldocno = ps_keys_bak[1] AND prflseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prfl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prfl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt504_prfl_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt504_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt504.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt504_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt504.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt504_lock_b(ps_table,ps_page)
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
   #CALL aprt504_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prfj_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt504_bcl USING g_enterprise,
                                       g_prfi_m.prfidocno,g_prfj_d[g_detail_idx].prfjseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt504_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "prfk_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprt504_bcl2 USING g_enterprise,
                                             g_prfi_m.prfidocno,g_prfj2_d[g_detail_idx].prfkseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt504_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "prfl_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprt504_bcl3 USING g_enterprise,
                                             g_prfi_m.prfidocno,g_prfj3_d[g_detail_idx].prflseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt504_bcl3:",SQLERRMESSAGE 
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
 
{<section id="aprt504.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt504_unlock_b(ps_table,ps_page)
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
      CLOSE aprt504_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt504_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt504_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt504_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prfidocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prfidocno",TRUE)
      CALL cl_set_comp_entry("prfidocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prfisite",TRUE)
      CALL cl_set_comp_entry("prfidocdt",TRUE) #ken---add 需求單號：141208-00001 項次：29
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt504_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prfidocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prfidocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prfidocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #ken---add---s 需求單號：141208-00001 項次：29
   IF p_cmd = 'u' THEN
     CALL cl_set_comp_entry("prfidocno",FALSE)
     CALL cl_set_comp_entry("prfisite",FALSE)
     CALL cl_set_comp_entry("prfidocdt",FALSE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'prfiunit') THEN
      CALL cl_set_comp_entry("prfiunit",FALSE)
   END IF
   #ken---add---e
   
   IF NOT s_aooi500_comp_entry(g_prog,'prfisite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prfisite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt504_set_entry_b(p_cmd)
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
 
{<section id="aprt504.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt504_set_no_entry_b(p_cmd)
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
 
{<section id="aprt504.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt504_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt504_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prfi_m.prfistus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt504_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt504_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt504_default_search()
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
      LET ls_wc = ls_wc, " prfidocno = '", g_argv[01], "' AND "
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
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "prfi_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prfj_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prfk_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "prfl_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
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
 
{<section id="aprt504.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt504_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_prfi_m.prfistus = 'X' OR g_prfi_m.prfistus = 'Y' THEN
      RETURN
   END IF
   IF g_prfi_m.prfistus = 'C' THEN  #結案狀態
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prfi_m.prfidocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt504_cl USING g_enterprise,g_prfi_m.prfidocno
   IF STATUS THEN
      CLOSE aprt504_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt504_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt504_master_referesh USING g_prfi_m.prfidocno INTO g_prfi_m.prfisite,g_prfi_m.prfidocdt, 
       g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004, 
       g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiowndp, 
       g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfdt,g_prfi_m.prfisite_desc,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002_desc, 
       g_prfi_m.prfi006_desc,g_prfi_m.prfi007_desc,g_prfi_m.prfiownid_desc,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid_desc, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prfimodid_desc,g_prfi_m.prficnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt504_action_chk() THEN
      CLOSE aprt504_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prfi_m.prfisite,g_prfi_m.prfisite_desc,g_prfi_m.prfidocdt,g_prfi_m.prfidocno,g_prfi_m.prfi001, 
       g_prfi_m.prfiunit,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002,g_prfi_m.prfi002_desc,g_prfi_m.prfi003, 
       g_prfi_m.prfi003_desc,g_prfi_m.prfi004,g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi006_desc, 
       g_prfi_m.prfi007,g_prfi_m.prfi007_desc,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiownid_desc, 
       g_prfi_m.prfiowndp,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid,g_prfi_m.prficrtid_desc,g_prfi_m.prficrtdp, 
       g_prfi_m.prficrtdp_desc,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimodid_desc,g_prfi_m.prfimoddt, 
       g_prfi_m.prficnfid,g_prfi_m.prficnfid_desc,g_prfi_m.prficnfdt
 
   CASE g_prfi_m.prfistus
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
         CASE g_prfi_m.prfistus
            
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
#      CALL cl_set_act_visible("unconfirmed", FALSE)
#      CALL cl_set_act_visible("invalid,confirmed", true)
#      IF g_prfi_m.prfistus = 'N' THEN
#         CALL cl_set_act_visible("unconfirmed", FALSE)
#         CALL cl_set_act_visible("invalid,confirmed", true)            
#      END IF
#      IF g_prfi_m.prfistus = 'Y' or g_prfi_m.prfistus = 'X' THEN
#         CALL cl_set_act_visible("confirmed,invalid", FALSE)      
#      END IF
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_prfi_m.prfistus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("invalid,confirmed,unconfirmed,hold",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unconfirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aprt504_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt504_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt504_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt504_cl
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
      g_prfi_m.prfistus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt504_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y' 
         SELECT prfistus INTO g_prfi_m.prfistus FROM prfi_t WHERE prfidocno = g_prfi_m.prfidocno
            AND prfient = g_enterprise         
         CALL s_aprt503_conf_chk(g_prfi_m.prfidocno,g_prfi_m.prfistus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_aprt503_conf_upd(g_prfi_m.prfidocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prfi_m.prfidocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')   
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF            
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN            
         END IF
                 
      WHEN 'X'
         SELECT prfistus INTO g_prfi_m.prfistus FROM prfi_t WHERE prfidocno = g_prfi_m.prfidocno
            AND prfient = g_enterprise  
         CALL s_aprt503_void_chk(g_prfi_m.prfidocno,g_prfi_m.prfistus) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_aprt503_void_upd(g_prfi_m.prfidocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prfi_m.prfidocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF
         ELSE 
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN    
         END IF        
   END CASE
   #end add-point
   
   LET g_prfi_m.prfimodid = g_user
   LET g_prfi_m.prfimoddt = cl_get_current()
   LET g_prfi_m.prfistus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prfi_t 
      SET (prfistus,prfimodid,prfimoddt) 
        = (g_prfi_m.prfistus,g_prfi_m.prfimodid,g_prfi_m.prfimoddt)     
    WHERE prfient = g_enterprise AND prfidocno = g_prfi_m.prfidocno
 
    
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
      EXECUTE aprt504_master_referesh USING g_prfi_m.prfidocno INTO g_prfi_m.prfisite,g_prfi_m.prfidocdt, 
          g_prfi_m.prfidocno,g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004, 
          g_prfi_m.prfi005,g_prfi_m.prfi006,g_prfi_m.prfi007,g_prfi_m.prfistus,g_prfi_m.prfiownid,g_prfi_m.prfiowndp, 
          g_prfi_m.prficrtid,g_prfi_m.prficrtdp,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt, 
          g_prfi_m.prficnfid,g_prfi_m.prficnfdt,g_prfi_m.prfisite_desc,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002_desc, 
          g_prfi_m.prfi006_desc,g_prfi_m.prfi007_desc,g_prfi_m.prfiownid_desc,g_prfi_m.prfiowndp_desc, 
          g_prfi_m.prficrtid_desc,g_prfi_m.prficrtdp_desc,g_prfi_m.prfimodid_desc,g_prfi_m.prficnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prfi_m.prfisite,g_prfi_m.prfisite_desc,g_prfi_m.prfidocdt,g_prfi_m.prfidocno, 
          g_prfi_m.prfi001,g_prfi_m.prfiunit,g_prfi_m.prfiunit_desc,g_prfi_m.prfi002,g_prfi_m.prfi002_desc, 
          g_prfi_m.prfi003,g_prfi_m.prfi003_desc,g_prfi_m.prfi004,g_prfi_m.prfi005,g_prfi_m.prfi006, 
          g_prfi_m.prfi006_desc,g_prfi_m.prfi007,g_prfi_m.prfi007_desc,g_prfi_m.prfistus,g_prfi_m.prfiownid, 
          g_prfi_m.prfiownid_desc,g_prfi_m.prfiowndp,g_prfi_m.prfiowndp_desc,g_prfi_m.prficrtid,g_prfi_m.prficrtid_desc, 
          g_prfi_m.prficrtdp,g_prfi_m.prficrtdp_desc,g_prfi_m.prficrtdt,g_prfi_m.prfimodid,g_prfi_m.prfimodid_desc, 
          g_prfi_m.prfimoddt,g_prfi_m.prficnfid,g_prfi_m.prficnfid_desc,g_prfi_m.prficnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT prfistus,prficnfid,prficnfdt,prfimodid,prfimoddt INTO g_prfi_m.prfistus,g_prfi_m.prficnfid,g_prfi_m.prficnfdt,
                                                                g_prfi_m.prfimodid,g_prfi_m.prfimoddt  
     FROM prfi_t
    WHERE prfient = g_enterprise AND prfidocno = g_prfi_m.prfidocno
   DISPLAY BY NAME g_prfi_m.prfistus,g_prfi_m.prficnfid,g_prfi_m.prficnfdt,g_prfi_m.prfimodid,g_prfi_m.prfimoddt
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfi_m.prficnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfi_m.prficnfid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prfi_m.prficnfid_desc   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfi_m.prfimodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfi_m.prfimodid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_prfi_m.prfimodid_desc
   IF g_prfi_m.prfistus NOT MATCHES "[DNR]" THEN
      CALL cl_set_act_visible("delete,modify", FALSE)
   ELSE
      CALL cl_set_act_visible("delete,modify", true)    
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt504_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt504_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt504.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt504_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prfj_d.getLength() THEN
         LET g_detail_idx = g_prfj_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prfj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prfj_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_prfj2_d.getLength() THEN
         LET g_detail_idx = g_prfj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prfj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prfj2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_prfj3_d.getLength() THEN
         LET g_detail_idx = g_prfj3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prfj3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prfj3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt504_b_fill2(pi_idx)
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
   
   CALL aprt504_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt504_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
#   RETURN TRUE
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprt504.status_show" >}
PRIVATE FUNCTION aprt504_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt504.mask_functions" >}
&include "erp/apr/aprt504_mask.4gl"
 
{</section>}
 
{<section id="aprt504.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt504_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   define l_success  like type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
 
 
   CALL aprt504_show()
   CALL aprt504_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt503_conf_chk(g_prfi_m.prfidocno,g_prfi_m.prfistus) RETURNING l_success
   IF l_success THEN
            
   ELSE
      CLOSE aprt504_cl
      CALL s_transaction_end('N','0')
      RETURN  FALSE          
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prfi_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prfj_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_prfj2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_prfj3_d))
 
 
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
   #CALL aprt504_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt504_ui_headershow()
   CALL aprt504_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt504_draw_out()
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
   CALL aprt504_ui_headershow()  
   CALL aprt504_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt504.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt504_set_pk_array()
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
   LET g_pk_array[1].values = g_prfi_m.prfidocno
   LET g_pk_array[1].column = 'prfidocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt504.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt504.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt504_msgcentre_notify(lc_state)
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
   CALL aprt504_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prfi_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt504.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt504_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#31 add-S
   SELECT prfistus  INTO g_prfi_m.prfistus
     FROM prfi_t
    WHERE prfient = g_enterprise
      AND prfidocno = g_prfi_m.prfidocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prfi_m.prfistus
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
        LET g_errparam.extend = g_prfi_m.prfidocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt504_set_act_visible()
        CALL aprt504_set_act_no_visible()
        CALL aprt504_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#31 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt504.other_function" readonly="Y" >}

#display prfisite
PRIVATE FUNCTION aprt504_prfisite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfi_m.prfisite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfi_m.prfisite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfi_m.prfisite_desc
END FUNCTION

#display prfi003
PRIVATE FUNCTION aprt504_prfi003_ref()
   DEFINE l_ooef019   LIKE ooef_t.ooef019
   SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_prfi_m.prfisite 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooef019
   LET g_ref_fields[2] = g_prfi_m.prfi003
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfi_m.prfi003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfi_m.prfi003_desc
END FUNCTION

#display prfi002
PRIVATE FUNCTION aprt504_prfi002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfi_m.prfi002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfi_m.prfi002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfi_m.prfi002_desc
END FUNCTION

#display prfi006
PRIVATE FUNCTION aprt504_prfi006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfi_m.prfi006
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prfi_m.prfi006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfi_m.prfi006_desc
END FUNCTION

#display prfi007
PRIVATE FUNCTION aprt504_prfi007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfi_m.prfi007
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfi_m.prfi007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfi_m.prfi007_desc
END FUNCTION

#display prfi006
PRIVATE FUNCTION aprt504_prfi006_display()
   SELECT ooag003 INTO g_prfi_m.prfi007
     FROM ooag_t
    WHERE ooagent= g_enterprise
      AND ooag001= g_prfi_m.prfi006 
   CALL aprt504_prfi007_ref()
END FUNCTION

#display prfj001
PRIVATE FUNCTION aprt504_prfj001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfj_d[l_ac].prfj001
   CALL ap_ref_array2(g_ref_fields,"SELECT prfgl003 FROM prfgl_t WHERE prfglent='"||g_enterprise||"' AND prfgl001=? AND prfgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfj_d[l_ac].prfj001_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_prfj_d[l_ac].prfj001_desc TO s_detail1[l_ac].prfj001_desc
END FUNCTION

#chk prfj001
PRIVATE FUNCTION aprt504_prfj001()
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_cnt1  LIKE type_t.num5
   
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT count(*) INTO l_cnt FROM  prfj_t WHERE prfjent = g_enterprise
      AND prfjdocno = g_prfi_m.prfidocno AND prfj001 = g_prfj_d[l_ac].prfj001
   IF l_cnt>=1 THEN
      LET g_errno = "apr-00212"
   END IF   
END FUNCTION

#create prfjseq
PRIVATE FUNCTION aprt504_create_prfjseq()
   SELECT max(prfjseq)+1 INTO g_prfj_d[l_ac].prfjseq
     FROM prfj_t WHERE prfjent = g_enterprise AND prfjdocno = g_prfi_m.prfidocno
   IF cl_null(g_prfj_d[l_ac].prfjseq) THEN
      LET g_prfj_d[l_ac].prfjseq = 1
   END IF 
END FUNCTION

#create prfkseq
PRIVATE FUNCTION aprt504_create_prfkseq()
   SELECT max(prfkseq)+1 INTO g_prfj2_d[l_ac].prfkseq
     FROM prfk_t WHERE prfkent = g_enterprise AND prfkdocno = g_prfi_m.prfidocno
   IF cl_null(g_prfj2_d[l_ac].prfkseq) THEN
      LET g_prfj2_d[l_ac].prfkseq = 1
   END IF
END FUNCTION

#chk prfk002
PRIVATE FUNCTION aprt504_prfk002()
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_cnt1    LIKE type_t.num5
   
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
#   CASE g_prfj2_d[l_ac].prfk001
#      WHEN '1'
#         SELECT count(*) INTO l_cnt FROM prfc_t WHERE prfcent = g_enterprise AND prfc001 = g_prfj2_d[l_ac].prfk002
#         IF l_cnt<=0 THEN
#            LET g_errno="apr-00153"
#         ELSE
#            SELECT count(*) INTO l_cnt1 FROM prfc_t WHERE prfcent = g_enterprise AND prfc001 = g_prfj2_d[l_ac].prfk002
#               AND prfcstus='Y'
#            IF l_cnt1<=0 THEN
#               LET g_errno="apr-00154"
#            END IF            
#         END IF
#      WHEN '2'
#         SELECT count(*) INTO l_cnt FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_prfj2_d[l_ac].prfk002
#            AND pmaa002 IN ('2','3')
#         IF l_cnt<=0 THEN
#            LET g_errno="apm-00026"
#         ELSE
#            SELECT count(*) INTO l_cnt1 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = g_prfj2_d[l_ac].prfk002
#               AND pmaa002 IN ('2','3')
#               AND pmaastus='Y'
#            IF l_cnt1<=0 THEN
#               LET g_errno="apm-00027"
#            END IF            
#         END IF
#   END CASE
   IF cl_null(g_errno) THEN
      SELECT count(*) INTO l_cnt FROM prfk_t WHERE prfkent = g_enterprise
         AND prfkdocno = g_prfi_m.prfidocno AND prfk001 = g_prfj2_d[l_ac].prfk001
         AND prfk002 = g_prfj2_d[l_ac].prfk002
      IF l_cnt>=1 THEN
         LET g_errno = "apr-00346"
      END IF      
   END IF   
END FUNCTION

#chk prfk002
PRIVATE FUNCTION aprt504_prfk002_ref()
   SELECT ooefl003 INTO g_prfj2_d[l_ac].prfk002_desc
     FROM ooefl_t
    WHERE ooeflent = g_enterprise AND ooefl001 =  g_prfj2_d[l_ac].prfk002 
      AND ooefl002 = g_dlang         
   DISPLAY g_prfj2_d[l_ac].prfk002_desc TO s_detail2[l_ac].prfk002_desc
END FUNCTION

#create prflseq
PRIVATE FUNCTION aprt504_create_prflseq()
   SELECT max(prflseq)+1 INTO g_prfj3_d[l_ac].prflseq
     FROM prfl_t WHERE prflent = g_enterprise AND prfldocno = g_prfi_m.prfidocno
   IF cl_null(g_prfj3_d[l_ac].prflseq) THEN
      LET g_prfj3_d[l_ac].prflseq = 1
   END IF
END FUNCTION

#chk prfl001
PRIVATE FUNCTION aprt504_prfl001()
   DEFINE l_cnt  LIKE type_t.num5
   LET l_cnt = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_cnt FROM prfl_t WHERE prflent = g_enterprise
      AND prfldocno = g_prfi_m.prfidocno AND prfl001 = g_prfj3_d[l_ac].prfl001
   IF l_cnt >0 THEN
      LET g_errno = "apr-00214"
   END IF   
END FUNCTION

#display prfl001
PRIVATE FUNCTION aprt504_prfl001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfj3_d[l_ac].prfl001_desc = '', g_rtn_fields[1] , ''
   LET g_prfj3_d[l_ac].imaal004 = '', g_rtn_fields[2] , ''
   DISPLAY g_prfj3_d[l_ac].prfl001_desc TO s_detail3[l_ac].prfl001_desc
   DISPLAY g_prfj3_d[l_ac].imaal004 TO s_detail3[l_ac].imaal004
   SELECT imaa106 INTO g_prfj3_d[l_ac].prfl006 FROM imaa_t
    WHERE imaaent = g_enterprise AND imaa001 =  g_prfj3_d[l_ac].prfl001
   DISPLAY g_prfj3_d[l_ac].prfl006 TO s_detail3[l_ac].prfl006
   CALL aprt504_prfl006_ref()  
END FUNCTION

#display prfl002
PRIVATE FUNCTION aprt504_prfl002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfj3_d[l_ac].prfl002_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_prfj3_d[l_ac].prfl002_desc to s_detail3[l_ac].prfl002_desc
END FUNCTION

#display prfl003
PRIVATE FUNCTION aprt504_prfl003_ref()
   DEFINE l_ooef019   LIKE ooef_t.ooef019
   SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_prfi_m.prfisite
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooef019
   LET g_ref_fields[2] = g_prfj3_d[l_ac].prfl003
   
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfj3_d[l_ac].prfl003_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_prfj3_d[l_ac].prfl003_desc  to s_detail3[l_ac].prfl003_desc
END FUNCTION

#display prfl006
PRIVATE FUNCTION aprt504_prfl006_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfj3_d[l_ac].prfl006_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_prfj3_d[l_ac].prfl006_desc TO s_detail3[l_ac].prfl006_desc
END FUNCTION

#count prfl009
PRIVATE FUNCTION aprt504_count_prfl009()
   IF cl_null(g_prfj3_d[l_ac].prfl007) OR g_prfj3_d[l_ac].prfl007=0 THEN
      LET g_prfj3_d[l_ac].prfl009 =100
   END IF
   IF cl_null(g_prfj3_d[l_ac].prfl008) OR g_prfj3_d[l_ac].prfl008=0 THEN
      LET g_prfj3_d[l_ac].prfl009 =0
   ELSE
      IF NOT cl_null(g_prfj3_d[l_ac].prfl007) AND NOT cl_null(g_prfj3_d[l_ac].prfl008) THEN
         LET g_prfj3_d[l_ac].prfl009 = (g_prfj3_d[l_ac].prfl008-g_prfj3_d[l_ac].prfl007)/g_prfj3_d[l_ac].prfl008*100
      END IF
   END IF 
   DISPLAY  g_prfj3_d[l_ac].prfl009 TO s_detail3[l_ac].prfl009   
END FUNCTION

#fill prfl_t
PRIVATE FUNCTION aprt504_fill()
   DEFINE l_sql      STRING
   DEFINE l_sql1     STRING
   DEFINE l_sql2     STRING
   DEFINE l_sql3     STRING
   DEFINE l_sql4     STRING
   DEFINE l_sql_sum     STRING
   DEFINE l_prfj001  LIKE prfj_t.prfj001
   DEFINE l_prfh002  LIKE prfh_t.prfh002
   DEFINE l_prfh003  LIKE prfh_t.prfh003
   DEFINE l_prfh004  LIKE prfh_t.prfh004
   DEFINE l_success  LIKE type_t.num5
   
   LET l_success = TRUE
   
   CALL g_prfj3_d.clear()
   LET l_sql = " SELECT DISTINCT imaa001,imaa106 ",
               "   FROM imaa_t ",
               "  WHERE imaaent=",g_enterprise," AND imaastus='Y' "
#   LET l_sql2 = " SELECT DISTINCT prfh002,prfh003,prfh004 FROM prfh_t WHERE prfhent=",g_enterprise," AND prfh001=? AND prfhstus='Y' " 
#   PREPARE l_sql2_prfh002_pre FROM l_sql2
#   DECLARE l_sql2_prfh002_cs CURSOR FOR  l_sql2_prfh002_pre
#   FOREACH  l_sql2_prfh002_cs using g_prfj_d[l_ac].prfj001 into   
   IF NOT cl_null(g_prfj_d_t.prfjseq) THEN
      LET l_sql1 = " SELECT DISTINCT prfj001 FROM prfj_t WHERE prfjent=",g_enterprise," AND prfjdocno='",g_prfi_m.prfidocno,"' ",
                   "    AND prfjseq = ",g_prfj_d_t.prfjseq
   ELSE
      LET l_sql1 = " SELECT DISTINCT prfj001 FROM prfj_t WHERE prfjent=",g_enterprise," AND prfjdocno='",g_prfi_m.prfidocno,"' ",
                   "    AND prfjseq = ",g_prfj_d[l_ac].prfjseq
   END IF   
   PREPARE l_sql1_prfj001_pre FROM l_sql1
   DECLARE l_sql1_prfj001_cs CURSOR FOR  l_sql1_prfj001_pre
   
   LET l_sql2 = " SELECT DISTINCT prfh002 FROM prfh_t WHERE prfhent=",g_enterprise," AND prfh001=? AND prfhstus='Y' " 
   PREPARE l_sql2_prfh002_pre FROM l_sql2
   DECLARE l_sql2_prfh002_cs CURSOR FOR  l_sql2_prfh002_pre
   LET l_sql3 = " SELECT DISTINCT prfh003 FROM prfh_t WHERE prfhent=",g_enterprise," AND prfh001=? AND prfhstus='Y' ", 
                "    AND prfh002=? "
   PREPARE l_sql3_prfh003_pre FROM l_sql3
   DECLARE l_sql3_prfh003_cs CURSOR FOR  l_sql3_prfh003_pre 
   LET l_sql4 = " SELECT DISTINCT prfh004 FROM prfh_t WHERE prfhent=",g_enterprise," AND prfh001=? " ,
                "    AND prfh002=? AND prfh003=? AND prfhstus='Y' " 
   PREPARE l_sql4_prfh004_pre FROM l_sql4
   DECLARE l_sql4_prfh004_cs CURSOR FOR  l_sql4_prfh004_pre
   LET l_sql4="1<>1"
   LET l_sql3="1=1"
   LET l_sql2="1<>1"
   LET l_sql1="1<>1"
   FOREACH  l_sql1_prfj001_cs INTO l_prfj001
   FOREACH  l_sql2_prfh002_cs USING l_prfj001 INTO l_prfh002
      FOREACH l_sql3_prfh003_cs USING l_prfj001,l_prfh002 INTO l_prfh003
         FOREACH l_sql4_prfh004_cs USING l_prfj001,l_prfh002,l_prfh003 INTO l_prfh004
            CASE l_prfh003
               WHEN '4'
                  LET l_sql4 = l_sql4," OR imaa001='",l_prfh004,"' " 
               WHEN '5'
                  LET l_sql4 = l_sql4," OR imaa009='",l_prfh004,"' "
               WHEN '6'
                  LET l_sql4 = l_sql4," OR imaa122='",l_prfh004,"' "
               WHEN '7'
                  LET l_sql4 = l_sql4," OR imaa131='",l_prfh004,"' "
               WHEN '8'
                  LET l_sql4 = l_sql4," OR imaa126='",l_prfh004,"' "
               WHEN '9'
                  LET l_sql4 = l_sql4," OR imaa127='",l_prfh004,"' "
               WHEN 'A'
                  LET l_sql4 = l_sql4," OR imaa128='",l_prfh004,"' "
               WHEN 'B'
                  LET l_sql4 = l_sql4," OR imaa129='",l_prfh004,"' "
               WHEN 'C'
                  LET l_sql4 = l_sql4," OR imaa132='",l_prfh004,"' "
               WHEN 'D'
                  LET l_sql4 = l_sql4," OR imaa133='",l_prfh004,"' "
               WHEN 'E'
                  LET l_sql4 = l_sql4," OR imaa134='",l_prfh004,"' "
               WHEN 'F'
                  LET l_sql4 = l_sql4," OR imaa135='",l_prfh004,"' "
               WHEN 'G'
                  LET l_sql4 = l_sql4," OR imaa136='",l_prfh004,"' "
               WHEN 'H'
                  LET l_sql4 = l_sql4," OR imaa137='",l_prfh004,"' "
               WHEN 'I'
                  LET l_sql4 = l_sql4," OR imaa138='",l_prfh004,"' "
               WHEN 'J'
                  LET l_sql4 = l_sql4," OR imaa139='",l_prfh004,"' "
               WHEN 'K'
                  LET l_sql4 = l_sql4," OR imaa140='",l_prfh004,"' "
               WHEN 'L'
                  LET l_sql4 = l_sql4," OR imaa141='",l_prfh004,"' "
         
            END CASE
            LET l_prfh004=null
         END FOREACH
         LET l_sql3 = l_sql3," AND (",l_sql4,") "
         LET l_sql4="1<>1"
         LET l_prfh003=null
      END FOREACH
      LET l_sql2 = l_sql2," OR (",l_sql3,") "
      LET l_sql3="1=1"
      LET l_prfh003=null 
   END FOREACH
      LET l_sql1 = l_sql1," OR (",l_sql2,") "
      LET l_sql2="1<>1" 
   END FOREACH   
   LET l_sql = l_sql," AND ( ",l_sql1," )" 
#   LET l_sql_sum = " INSERT INTO prfl_t(prflent,prflunit,prflsite,prfldocno,prflseq,prfl001,",
#               "  prfl002,prfl003,prfl004,prfl005,prfl006,prfl007,prfl008,prfl009,prfl010,prfl011,prfl012,prfl013) ",
#               " SELECT ",g_enterprise,",'",g_prfi_m.prfiunit,"','",g_prfi_m.prfisite,"','",g_prfi_m.prfidocno,"',",
#               "       ROWNUM,imaa001,'",g_prfi_m.prfi002,"','",g_prfi_m.prfi003,"','",g_prfi_m.prfi004,"','",g_prfi_m.prfi005,"',",
#               "       imaa106,0,0,0,0,0,0,0 ",
#               "   FROM (",l_sql,") "               
#   PREPARE l_sql_pre FROM l_sql_sum
#   EXECUTE l_sql_pre
#   IF SQLCA.sqlcode THEN
#      CALL cl_err("",SQLCA.sqlcode,1)
#      LET l_success = FALSE
#      RETURN l_success
#   END IF   
#   RETURN l_success
   RETURN l_sql
END FUNCTION

#fill prfl_t
PRIVATE FUNCTION aprt504_insert_prfl(p_sql)
   DEFINE p_sql      STRING
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_sql_sum  STRING
   DEFINE l_max      LIKE type_t.num5
   DEFINE l_prflseq  LIKE prfl_t.prflseq
   DEFINE l_prfl001  LIKE prfl_t.prfl001
   DEFINE l_prfl006  LIKE prfl_t.prfl006
   
   LET l_success = TRUE
#   LET l_sql_sum = " INSERT INTO prfl_t(prflent,prflunit,prflsite,prfldocno,prflseq,prfl001,",
#               "  prfl002,prfl003,prfl004,prfl005,prfl006,prfl007,prfl008,prfl009,prfl010,prfl011,prfl012,prfl013) ",
#               " SELECT ",g_enterprise,",'",g_prfi_m.prfiunit,"','",g_prfi_m.prfisite,"','",g_prfi_m.prfidocno,"',",
#               "       ROWNUM,imaa001,'",g_prfi_m.prfi002,"','",g_prfi_m.prfi003,"','",g_prfi_m.prfi004,"','",g_prfi_m.prfi005,"',",
#               "       imaa106,0,0,0,0,0,0,0 ",
#               "   FROM (",p_sql,") a ",
#               "  WHERE a.imaa001 NOT IN ( SELECT prfl_t.prfl001 FROM prfl_t WHERE  prflent=",g_enterprise," AND prfldocno='",g_prfi_m.prfidocno,"' ) "               
#   PREPARE l_sql_pre FROM l_sql_sum
#   EXECUTE l_sql_pre
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = ""
#      LET g_errparam.popup = TRUE
#      CALL cl_err()

#      LET l_success = FALSE
#      RETURN l_success
#   END IF
   LET l_sql_sum =  " SELECT imaa001,imaa106 ",
                    "   FROM (",p_sql,") a ",
                    "  WHERE a.imaa001 NOT IN ( SELECT prfl_t.prfl001 FROM prfl_t WHERE  prflent=",g_enterprise," AND prfldocno='",g_prfi_m.prfidocno,"' ) ",
                    "    ORDER BY imaa001 "                    
   PREPARE l_sql_pre1 FROM l_sql_sum
   DECLARE l_sql_cs1 CURSOR FOR l_sql_pre1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_success = FALSE
      RETURN l_success
   END IF
   SELECT max(prflseq) INTO l_max FROM prfl_t WHERE prflent= g_enterprise AND prfldocno=g_prfi_m.prfidocno
   IF cl_null(l_max) THEN LET l_max=0 END IF
   LET l_prflseq = l_max
   FOREACH l_sql_cs1 INTO l_prfl001,l_prfl006
      LET l_prflseq=l_prflseq+1
      INSERT INTO prfl_t(prflent,prflunit,prflsite,prfldocno,prflseq,prfl001,
              prfl002,prfl003,prfl004,prfl005,prfl006,prfl007,prfl008,prfl009,prfl010,prfl011,prfl012,prfl013)
       VALUES (g_enterprise,g_prfi_m.prfiunit,g_prfi_m.prfisite,g_prfi_m.prfidocno,l_prflseq,l_prfl001,
              g_prfi_m.prfi002,g_prfi_m.prfi003,g_prfi_m.prfi004,g_prfi_m.prfi005,l_prfl006,0,0,0,0,0,0,0)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

         LET l_success = FALSE
         RETURN l_success
      END IF     
   END FOREACH   
   CALL aprt504_b_fill3()
   RETURN l_success   
END FUNCTION

#fill
PRIVATE FUNCTION aprt504_b_fill3()
   DEFINE l_ac1  LIKE type_t.num5
   DEFINE l_ac_t LIKE type_t.num5
   LET l_ac_t = l_ac
   CALL g_prfj3_d.clear()
   IF aprt504_fill_chk(3) THEN
      LET g_sql = "SELECT  UNIQUE prflseq,prfl001,'','',prfl002,'',prfl003,'',prfl004,prfl005,prfl006,", 
          " '',prfl007,prfl008,prfl009,prfl010,prfl011,prfl012,prfl013,prflsite,prflunit FROM prfl_t", 
             
                  " INNER JOIN prfi_t ON prfidocno = prfldocno ",
 
                  "",
                  
                  " WHERE prflent=? AND prfldocno=?"   
      #add-point:b_fill段sql_before

      #end add-point
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY prfl_t.prflseq"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE aprt504_pb3_1 FROM g_sql
      DECLARE b_fill_cs3_1 CURSOR FOR aprt504_pb3_1
      
      LET l_ac1 = 1
      
      OPEN b_fill_cs3_1 USING g_enterprise,g_prfi_m.prfidocno
 
                                               
      FOREACH b_fill_cs3_1 INTO g_prfj3_d[l_ac1].prflseq,g_prfj3_d[l_ac1].prfl001,g_prfj3_d[l_ac1].prfl001_desc, 
          g_prfj3_d[l_ac1].imaal004,g_prfj3_d[l_ac1].prfl002,g_prfj3_d[l_ac1].prfl002_desc,g_prfj3_d[l_ac1].prfl003, 
          g_prfj3_d[l_ac1].prfl003_desc,g_prfj3_d[l_ac1].prfl004,g_prfj3_d[l_ac1].prfl005,g_prfj3_d[l_ac1].prfl006, 
          g_prfj3_d[l_ac1].prfl006_desc,g_prfj3_d[l_ac1].prfl007,g_prfj3_d[l_ac1].prfl008,g_prfj3_d[l_ac1].prfl009, 
          g_prfj3_d[l_ac1].prfl010,g_prfj3_d[l_ac1].prfl011,g_prfj3_d[l_ac1].prfl012,g_prfj3_d[l_ac1].prfl013, 
          g_prfj3_d[l_ac1].prflsite,g_prfj3_d[l_ac1].prflunit
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充

         #end add-point
      
         LET l_ac1 = l_ac1 + 1
         IF l_ac1 > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
   CALL g_prfj3_d.deleteElement(g_prfj3_d.getLength())
   
   FOR l_ac = 1 TO g_prfj3_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl001
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl001_desc = '', g_rtn_fields[1] , ''
            LET g_prfj3_d[l_ac].imaal004 = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl001_desc
            DISPLAY BY NAME g_prfj3_d[l_ac].imaal004
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl003
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfj3_d[l_ac].prfl006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prfj3_d[l_ac].prfl006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfj3_d[l_ac].prfl006_desc

      #end add-point
   END FOR
   LET l_ac = l_ac_t
END FUNCTION

#delete prfl_t
PRIVATE FUNCTION aprt504_delete_prfl(p_sql)
   DEFINE p_sql   string
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_sql_sum  STRING
   
   LET l_success = TRUE
   
   LET l_sql_sum = " DELETE FROM prfl_t WHERE prflent=",g_enterprise,
                   "    AND prfldocno='",g_prfi_m.prfidocno,"' ",
                   "    AND prfl001 IN ( SELECT imaa001 FROM (",p_sql,") )"                   
   PREPARE l_sql_pre_delete FROM l_sql_sum
   EXECUTE l_sql_pre_delete
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_success = FALSE
      RETURN l_success
   END IF   
   RETURN l_success
END FUNCTION

#chk
PRIVATE FUNCTION aprt504_delete_insert_prfl()
   DEFINE l_sql      STRING
   DEFINE l_sql1     STRING
   DEFINE l_sql2     STRING
   DEFINE l_sql3     STRING
   DEFINE l_sql4     STRING
   DEFINE l_sql_sum     STRING
   DEFINE l_prfj001  LIKE prfj_t.prfj001
   DEFINE l_prfh002  LIKE prfh_t.prfh002
   DEFINE l_prfh003  LIKE prfh_t.prfh003
   DEFINE l_prfh004  LIKE prfh_t.prfh004
   DEFINE l_success  LIKE type_t.num5
   
   LET l_success = TRUE
   
   CALL g_prfj3_d.clear()
   LET l_sql = " SELECT DISTINCT imaa001,imaa106 ",
               "   FROM imaa_t ",
               "  WHERE imaaent=",g_enterprise," AND imaastus='Y' "

   IF NOT cl_null(g_prfj_d_t.prfjseq) THEN
      LET l_sql1 = " SELECT DISTINCT prfj001 FROM prfj_t WHERE prfjent=",g_enterprise," AND prfjdocno='",g_prfi_m.prfidocno,"' ",
                   "    AND prfjseq = ",g_prfj_d_t.prfjseq
   ELSE
      LET l_sql1 = " SELECT DISTINCT prfj001 FROM prfj_t WHERE prfjent=",g_enterprise," AND prfjdocno='",g_prfi_m.prfidocno,"' ",
                   "    AND prfjseq = ",g_prfj_d[l_ac].prfjseq
   END IF   
   PREPARE l_sql1_prfj001_pre1 FROM l_sql1
   DECLARE l_sql1_prfj001_cs1 CURSOR FOR  l_sql1_prfj001_pre1
   
   LET l_sql2 = " SELECT DISTINCT prfh002 FROM prfh_t WHERE prfhent=",g_enterprise," AND prfh001=? AND prfhstus='Y' " 
   PREPARE l_sql2_prfh002_pre1 FROM l_sql2
   DECLARE l_sql2_prfh002_cs1 CURSOR FOR  l_sql2_prfh002_pre1
   LET l_sql3 = " SELECT DISTINCT prfh003 FROM prfh_t WHERE prfhent=",g_enterprise," AND prfh001=? AND prfhstus='Y' ", 
                "    AND prfh002=? "
   PREPARE l_sql3_prfh003_pre1 FROM l_sql3
   DECLARE l_sql3_prfh003_cs1 CURSOR FOR  l_sql3_prfh003_pre1 
   LET l_sql4 = " SELECT DISTINCT prfh004 FROM prfh_t WHERE prfhent=",g_enterprise," AND prfh001=? " ,
                "    AND prfh002=? AND prfh003=? AND prfhstus='Y' " 
   PREPARE l_sql4_prfh004_pre1 FROM l_sql4
   DECLARE l_sql4_prfh004_cs1 CURSOR FOR  l_sql4_prfh004_pre1
   LET l_sql4="1<>1"
   LET l_sql3="1=1"
   LET l_sql2="1<>1"
   LET l_sql1="1<>1"

   FOREACH  l_sql2_prfh002_cs1 USING g_prfj_d_t.prfj001 INTO l_prfh002
      FOREACH l_sql3_prfh003_cs1 USING g_prfj_d_t.prfj001,l_prfh002 INTO l_prfh003
         FOREACH l_sql4_prfh004_cs1 USING g_prfj_d_t.prfj001,l_prfh002,l_prfh003 INTO l_prfh004
            CASE l_prfh003
               WHEN '4'
                  LET l_sql4 = l_sql4," OR imaa001='",l_prfh004,"' " 
               WHEN '5'
                  LET l_sql4 = l_sql4," OR imaa009='",l_prfh004,"' "
               WHEN '6'
                  LET l_sql4 = l_sql4," OR imaa122='",l_prfh004,"' "
               WHEN '7'
                  LET l_sql4 = l_sql4," OR imaa131='",l_prfh004,"' "
               WHEN '8'
                  LET l_sql4 = l_sql4," OR imaa126='",l_prfh004,"' "
               WHEN '9'
                  LET l_sql4 = l_sql4," OR imaa127='",l_prfh004,"' "
               WHEN 'A'
                  LET l_sql4 = l_sql4," OR imaa128='",l_prfh004,"' "
               WHEN 'B'
                  LET l_sql4 = l_sql4," OR imaa129='",l_prfh004,"' "
               WHEN 'C'
                  LET l_sql4 = l_sql4," OR imaa132='",l_prfh004,"' "
               WHEN 'D'
                  LET l_sql4 = l_sql4," OR imaa133='",l_prfh004,"' "
               WHEN 'E'
                  LET l_sql4 = l_sql4," OR imaa134='",l_prfh004,"' "
               WHEN 'F'
                  LET l_sql4 = l_sql4," OR imaa135='",l_prfh004,"' "
               WHEN 'G'
                  LET l_sql4 = l_sql4," OR imaa136='",l_prfh004,"' "
               WHEN 'H'
                  LET l_sql4 = l_sql4," OR imaa137='",l_prfh004,"' "
               WHEN 'I'
                  LET l_sql4 = l_sql4," OR imaa138='",l_prfh004,"' "
               WHEN 'J'
                  LET l_sql4 = l_sql4," OR imaa139='",l_prfh004,"' "
               WHEN 'K'
                  LET l_sql4 = l_sql4," OR imaa140='",l_prfh004,"' "
               WHEN 'L'
                  LET l_sql4 = l_sql4," OR imaa141='",l_prfh004,"' "
         
            END CASE
            LET l_prfh004=null
         END FOREACH
         LET l_sql3 = l_sql3," AND (",l_sql4,") "
         LET l_sql4="1<>1"
         LET l_prfh003=null
      END FOREACH
      LET l_sql2 = l_sql2," OR (",l_sql3,") "
      LET l_sql3="1=1"
      LET l_prfh003=null 
   END FOREACH
         
   LET l_sql = l_sql," AND ( ",l_sql2," )" 

   RETURN l_sql
END FUNCTION

################################################################################
#display prfiunit
################################################################################
PRIVATE FUNCTION aprt504_prfiunit_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prfi_m.prfiunit
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prfi_m.prfiunit_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prfi_m.prfiunit_desc
END FUNCTION

 
{</section>}
 
