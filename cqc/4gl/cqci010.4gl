#該程式未解開Section, 採用最新樣板產出!
{<section id="cqci010.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(1900-01-01 00:00:00), PR版次:0001(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0001(2017-05-03 13:25:14), PR版次:0001(2017-05-04 14:58:13)
#+ Build......: 000000
#+ Filename...: cqci010
#+ Description: 
#+ Creator....: 00000(2017-05-02 09:58:49)
#+ Modifier...: 00000 -SD/PR- 00000
 
{</section>}
 
{<section id="cqci010.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160107-00014#1   2016/01/11  By Ann_huang 品管分群(qcamuc002)需排除ALL的部分
#160519-00045#1   2016/05/19  By lixiang 指定儀器開窗依資源類型開窗相符之mrba_t資料
#161018-00003#1   2016/10/26  By lixh    單身每次維護完後，檢驗規格頁籤的檢驗項目說明就會顯示不出來
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
PRIVATE type type_g_qcamuc_m        RECORD
       qcamuc001 LIKE qcamuc_t.qcamuc001, 
   qcamuc001_desc LIKE type_t.chr80, 
   qcamuc002 LIKE qcamuc_t.qcamuc002, 
   qcamuc002_desc LIKE type_t.chr80, 
   qcamuc003 LIKE qcamuc_t.qcamuc003, 
   qcamuc003_desc LIKE type_t.chr80, 
   qcamuc004 LIKE qcamuc_t.qcamuc004, 
   qcamucud001 LIKE qcamuc_t.qcamucud001, 
   qcamuc005 LIKE qcamuc_t.qcamuc005, 
   qcamuc005_desc LIKE type_t.chr80, 
   qcamuc006 LIKE qcamuc_t.qcamuc006, 
   qcamuc007 LIKE qcamuc_t.qcamuc007, 
   qcamuc008 LIKE qcamuc_t.qcamuc008, 
   qcamuc008_desc LIKE type_t.chr80, 
   qcamuc009 LIKE qcamuc_t.qcamuc009, 
   qcamuc010 LIKE qcamuc_t.qcamuc010, 
   qcamucstus LIKE qcamuc_t.qcamucstus, 
   qcamucownid LIKE qcamuc_t.qcamucownid, 
   qcamucownid_desc LIKE type_t.chr80, 
   qcamucowndp LIKE qcamuc_t.qcamucowndp, 
   qcamucowndp_desc LIKE type_t.chr80, 
   qcamuccrtid LIKE qcamuc_t.qcamuccrtid, 
   qcamuccrtid_desc LIKE type_t.chr80, 
   qcamuccrtdp LIKE qcamuc_t.qcamuccrtdp, 
   qcamuccrtdp_desc LIKE type_t.chr80, 
   qcamuccrtdt LIKE qcamuc_t.qcamuccrtdt, 
   qcamucmodid LIKE qcamuc_t.qcamucmodid, 
   qcamucmodid_desc LIKE type_t.chr80, 
   qcamucmoddt LIKE qcamuc_t.qcamucmoddt, 
   qcamuccnfid LIKE qcamuc_t.qcamuccnfid, 
   qcamuccnfdt LIKE qcamuc_t.qcamuccnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_qcanuc_d        RECORD
       qcanuc009 LIKE qcanuc_t.qcanuc009, 
   qcanuc010 LIKE qcanuc_t.qcanuc010, 
   qcanuc010_desc LIKE type_t.chr500, 
   qcanuc011 LIKE qcanuc_t.qcanuc011, 
   qcanuc012 LIKE qcanuc_t.qcanuc012, 
   qcanuc013 LIKE qcanuc_t.qcanuc013, 
   qcanuc014 LIKE qcanuc_t.qcanuc014, 
   qcanuc015 LIKE qcanuc_t.qcanuc015, 
   qcanuc016 LIKE qcanuc_t.qcanuc016, 
   qcanuc016_desc LIKE type_t.chr500, 
   qcanuc017 LIKE qcanuc_t.qcanuc017, 
   qcanuc018 LIKE qcanuc_t.qcanuc018
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_qcamuc001 LIKE qcamuc_t.qcamuc001,
   b_qcamuc001_desc LIKE type_t.chr80,
      b_qcamuc002 LIKE qcamuc_t.qcamuc002,
   b_qcamuc002_desc LIKE type_t.chr80,
      b_qcamuc003 LIKE qcamuc_t.qcamuc003,
   b_qcamuc003_desc LIKE type_t.chr80,
   b_qcamuc003_desc_1 LIKE type_t.chr80,
      b_qcamuc004 LIKE qcamuc_t.qcamuc004,
      b_qcamuc005 LIKE qcamuc_t.qcamuc005,
   b_qcamuc005_desc LIKE type_t.chr80,
      b_qcamuc006 LIKE qcamuc_t.qcamuc006,
      b_qcamuc007 LIKE qcamuc_t.qcamuc007,
      b_qcamuc008 LIKE qcamuc_t.qcamuc008,
   b_qcamuc008_desc LIKE type_t.chr80,
      b_qcamuc009 LIKE qcamuc_t.qcamuc009,
      b_qcamucud001 LIKE qcamuc_t.qcamucud001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_qcanuc2_d RECORD
                    qcanuc009_1   LIKE qcanuc_t.qcanuc009,
                    qcanuc010_1   LIKE qcanuc_t.qcanuc010,
                    qcanuc010_1_desc LIKE type_t.chr80,
                    qcanuc011_1   LIKE qcanuc_t.qcanuc011,
                    qcanuc013_1   LIKE qcanuc_t.qcanuc013,
                    qcanuc019   LIKE qcanuc_t.qcanuc019,
                    qcanuc020   LIKE qcanuc_t.qcanuc020,
                    qcanuc021   LIKE qcanuc_t.qcanuc021,
                    qcanuc022   LIKE qcanuc_t.qcanuc022,
                    qcanuc023   LIKE qcanuc_t.qcanuc023,
                    qcanuc024   LIKE qcanuc_t.qcanuc024,
                    qcanuc025   LIKE qcanuc_t.qcanuc025,
                    qcanuc026   LIKE qcanuc_t.qcanuc026
                          END RECORD
DEFINE g_qcanuc2_d          DYNAMIC ARRAY OF type_g_qcanuc2_d
DEFINE g_qcanuc2_d_t        type_g_qcanuc2_d
DEFINE g_wc2_table2          STRING         
DEFINE l_ac2                  LIKE type_t.num5   
DEFINE g_forupd_sql2          STRING
DEFINE g_cnt2             LIKE type_t.num5
DEFINE g_qcamuc001          LIKE qcamuc_t.qcamuc001
#end add-point
       
#模組變數(Module Variables)
DEFINE g_qcamuc_m          type_g_qcamuc_m
DEFINE g_qcamuc_m_t        type_g_qcamuc_m
DEFINE g_qcamuc_m_o        type_g_qcamuc_m
DEFINE g_qcamuc_m_mask_o   type_g_qcamuc_m #轉換遮罩前資料
DEFINE g_qcamuc_m_mask_n   type_g_qcamuc_m #轉換遮罩後資料
 
   DEFINE g_qcamuc001_t LIKE qcamuc_t.qcamuc001
DEFINE g_qcamuc002_t LIKE qcamuc_t.qcamuc002
DEFINE g_qcamuc003_t LIKE qcamuc_t.qcamuc003
DEFINE g_qcamuc004_t LIKE qcamuc_t.qcamuc004
DEFINE g_qcamucud001_t LIKE qcamuc_t.qcamucud001
DEFINE g_qcamuc005_t LIKE qcamuc_t.qcamuc005
DEFINE g_qcamuc006_t LIKE qcamuc_t.qcamuc006
DEFINE g_qcamuc008_t LIKE qcamuc_t.qcamuc008
DEFINE g_qcamuc009_t LIKE qcamuc_t.qcamuc009
 
 
DEFINE g_qcanuc_d          DYNAMIC ARRAY OF type_g_qcanuc_d
DEFINE g_qcanuc_d_t        type_g_qcanuc_d
DEFINE g_qcanuc_d_o        type_g_qcanuc_d
DEFINE g_qcanuc_d_mask_o   DYNAMIC ARRAY OF type_g_qcanuc_d #轉換遮罩前資料
DEFINE g_qcanuc_d_mask_n   DYNAMIC ARRAY OF type_g_qcanuc_d #轉換遮罩後資料
 
 
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
 
{<section id="cqci010.main" >}
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
   CALL cl_ap_init("cqc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT qcamuc001,'',qcamuc002,'',qcamuc003,'',qcamuc004,qcamucud001,qcamuc005, 
       '',qcamuc006,qcamuc007,qcamuc008,'',qcamuc009,qcamuc010,qcamucstus,qcamucownid,'',qcamucowndp, 
       '',qcamuccrtid,'',qcamuccrtdp,'',qcamuccrtdt,qcamucmodid,'',qcamucmoddt,qcamuccnfid,qcamuccnfdt", 
        
                      " FROM qcamuc_t",
                      " WHERE qcamucent= ? AND qcamuc001=? AND qcamuc002=? AND qcamuc003=? AND qcamuc004=?  
                          AND qcamuc005=? AND qcamuc006=? AND qcamuc008=? AND qcamuc009=? AND qcamucud001=?  
                          FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE cqci010_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.qcamuc001,t0.qcamuc002,t0.qcamuc003,t0.qcamuc004,t0.qcamucud001, 
       t0.qcamuc005,t0.qcamuc006,t0.qcamuc007,t0.qcamuc008,t0.qcamuc009,t0.qcamuc010,t0.qcamucstus,t0.qcamucownid, 
       t0.qcamucowndp,t0.qcamuccrtid,t0.qcamuccrtdp,t0.qcamuccrtdt,t0.qcamucmodid,t0.qcamucmoddt,t0.qcamuccnfid, 
       t0.qcamuccnfdt,t1.ooall004 ,t2.oocql004 ,t3.imaal003 ,t4.oocql004 ,t5.pmaal004 ,t6.ooag011 ,t7.ooefl003 , 
       t8.ooag011 ,t9.ooefl003 ,t10.ooag011",
               " FROM qcamuc_t t0",
                              " LEFT JOIN ooall_t t1 ON t1.ooallent="||g_enterprise||" AND t1.ooall001='5' AND t1.ooall002=t0.qcamuc001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='205' AND t2.oocql002=t0.qcamuc002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.qcamuc003 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='221' AND t4.oocql002=t0.qcamuc005 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.qcamuc008 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.qcamucownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.qcamucowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.qcamuccrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.qcamuccrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.qcamucmodid  ",
 
               " WHERE t0.qcamucent = " ||g_enterprise|| " AND t0.qcamuc001 = ? AND t0.qcamuc002 = ? AND t0.qcamuc003 = ? AND t0.qcamuc004 = ? AND t0.qcamuc005 = ? AND t0.qcamuc006 = ? AND t0.qcamuc008 = ? AND t0.qcamuc009 = ? AND t0.qcamucud001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE cqci010_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_cqci010 WITH FORM cl_ap_formpath("cqc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL cqci010_init()   
 
      #進入選單 Menu (="N")
      CALL cqci010_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_cqci010
      
   END IF 
   
   CLOSE cqci010_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="cqci010.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION cqci010_init()
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
      CALL cl_set_combo_scc_part('qcamucstus','13','Y,N')
 
      CALL cl_set_combo_scc('qcamuc007','5055') 
   CALL cl_set_combo_scc('qcamuc009','5056') 
   CALL cl_set_combo_scc('qcanuc012','5057') 
   CALL cl_set_combo_scc('qcanuc013','5058') 
   CALL cl_set_combo_scc('qcanuc015','5059') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('qcanuc013_1','5058') 
   CALL cl_set_combo_scc('b_qcamuc009','5056') 
   CALL cl_get_para(g_enterprise,g_site,'S-MFG-0046') RETURNING g_qcamuc001  #add by lixh 20150703 150702-00006#10
   #end add-point
   
   #初始化搜尋條件
   CALL cqci010_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="cqci010.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION cqci010_ui_dialog()
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
            CALL cqci010_insert()
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
         INITIALIZE g_qcamuc_m.* TO NULL
         CALL g_qcanuc_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL cqci010_init()
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
               
               CALL cqci010_fetch('') # reload data
               LET l_ac = 1
               CALL cqci010_ui_detailshow() #Setting the current row 
         
               CALL cqci010_idx_chk()
               #NEXT FIELD qcanuc009
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_qcanuc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL cqci010_idx_chk()
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
               CALL cqci010_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_qcanuc2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page2  
    
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac2
               
               #add-point:page2, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
              
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL cqci010_browser_fill("")
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
               CALL cqci010_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL cqci010_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL cqci010_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL cqci010_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL cqci010_set_act_visible()   
            CALL cqci010_set_act_no_visible()
            IF NOT (g_qcamuc_m.qcamuc001 IS NULL
              OR g_qcamuc_m.qcamuc002 IS NULL
              OR g_qcamuc_m.qcamuc003 IS NULL
              OR g_qcamuc_m.qcamuc004 IS NULL
              OR g_qcamuc_m.qcamuc005 IS NULL
              OR g_qcamuc_m.qcamuc006 IS NULL
              OR g_qcamuc_m.qcamuc008 IS NULL
              OR g_qcamuc_m.qcamuc009 IS NULL
              OR g_qcamuc_m.qcamucud001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " qcamucent = " ||g_enterprise|| " AND",
                                  " qcamuc001 = '", g_qcamuc_m.qcamuc001, "' "
                                  ," AND qcamuc002 = '", g_qcamuc_m.qcamuc002, "' "
                                  ," AND qcamuc003 = '", g_qcamuc_m.qcamuc003, "' "
                                  ," AND qcamuc004 = '", g_qcamuc_m.qcamuc004, "' "
                                  ," AND qcamuc005 = '", g_qcamuc_m.qcamuc005, "' "
                                  ," AND qcamuc006 = '", g_qcamuc_m.qcamuc006, "' "
                                  ," AND qcamuc008 = '", g_qcamuc_m.qcamuc008, "' "
                                  ," AND qcamuc009 = '", g_qcamuc_m.qcamuc009, "' "
                                  ," AND qcamucud001 = '", g_qcamuc_m.qcamucud001, "' "
 
               #填到對應位置
               CALL cqci010_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "qcamuc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "qcanuc_t" 
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
               CALL cqci010_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "qcamuc_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "qcanuc_t" 
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
                  CALL cqci010_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL cqci010_fetch("F")
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
               CALL cqci010_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL cqci010_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL cqci010_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL cqci010_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL cqci010_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL cqci010_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL cqci010_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL cqci010_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL cqci010_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL cqci010_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL cqci010_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_qcanuc_d)
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
               NEXT FIELD qcanuc009
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
               CALL cqci010_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL cqci010_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL cqci010_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL cqci010_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL cqci010_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL cqci010_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL cqci010_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL cqci010_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL cqci010_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
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
 
{<section id="cqci010.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION cqci010_browser_fill(ps_page_action)
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
   #add by lixh 20150703 150702-00006#10
   IF cl_null(g_wc) THEN
      LET g_wc = " qcamuc001 = '",g_qcamuc001,"'"
   ELSE
      LET g_wc = g_wc," AND qcamuc001 = '",g_qcamuc001,"'"  
   END IF
   #add by lixh 20150703 150702-00006#10
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
      LET l_sub_sql = " SELECT DISTINCT qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamuc005,qcamuc006, 
          qcamuc008,qcamuc009,qcamucud001 ",
                      " FROM qcamuc_t ",
                      " ",
                      " LEFT JOIN qcanuc_t ON qcanucent = qcamucent AND qcamuc001 = qcanuc001 AND qcamuc002 = qcanuc002 AND qcamuc003 = qcanuc003 AND qcamuc004 = qcanuc004 AND qcamuc005 = qcanuc005 AND qcamuc006 = qcanuc006 AND qcamuc008 = qcanuc007 AND qcamuc009 = qcanuc008 AND qcamucud001 = qcanucud001 ", "  ",
                      #add-point:browser_fill段sql(qcanuc_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE qcamucent = " ||g_enterprise|| " AND qcanucent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("qcamuc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamuc005,qcamuc006, 
          qcamuc008,qcamuc009,qcamucud001 ",
                      " FROM qcamuc_t ", 
                      "  ",
                      "  ",
                      " WHERE qcamucent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("qcamuc_t")
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
      INITIALIZE g_qcamuc_m.* TO NULL
      CALL g_qcanuc_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.qcamuc001,t0.qcamuc002,t0.qcamuc003,t0.qcamuc004,t0.qcamuc005,t0.qcamuc006,t0.qcamuc007,t0.qcamuc008,t0.qcamuc009,t0.qcamucud001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.qcamucstus,t0.qcamuc001,t0.qcamuc002,t0.qcamuc003,t0.qcamuc004, 
          t0.qcamuc005,t0.qcamuc006,t0.qcamuc007,t0.qcamuc008,t0.qcamuc009,t0.qcamucud001,t1.ooall004 , 
          t2.oocql004 ,t3.imaal003 ,t4.imaal004 ,t5.oocql004 ,t6.pmaal004 ",
                  " FROM qcamuc_t t0",
                  "  ",
                  "  LEFT JOIN qcanuc_t ON qcanucent = qcamucent AND qcamuc001 = qcanuc001 AND qcamuc002 = qcanuc002 AND qcamuc003 = qcanuc003 AND qcamuc004 = qcanuc004 AND qcamuc005 = qcanuc005 AND qcamuc006 = qcanuc006 AND qcamuc008 = qcanuc007 AND qcamuc009 = qcanuc008 AND qcamucud001 = qcanucud001 ", "  ", 
                  #add-point:browser_fill段sql(qcanuc_t1) name="browser_fill.join.qcanuc_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooall_t t1 ON t1.ooallent="||g_enterprise||" AND t1.ooall001='5' AND t1.ooall002=t0.qcamuc001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='205' AND t2.oocql002=t0.qcamuc002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.qcamuc003 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=t0.qcamuc003 AND t4.imaal001='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=t0.qcamuc005 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.qcamuc008 AND t6.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.qcamucent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("qcamuc_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.qcamucstus,t0.qcamuc001,t0.qcamuc002,t0.qcamuc003,t0.qcamuc004, 
          t0.qcamuc005,t0.qcamuc006,t0.qcamuc007,t0.qcamuc008,t0.qcamuc009,t0.qcamucud001,t1.ooall004 , 
          t2.oocql004 ,t3.imaal003 ,t4.imaal004 ,t5.oocql004 ,t6.pmaal004 ",
                  " FROM qcamuc_t t0",
                  "  ",
                                 " LEFT JOIN ooall_t t1 ON t1.ooallent="||g_enterprise||" AND t1.ooall001='5' AND t1.ooall002=t0.qcamuc001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='205' AND t2.oocql002=t0.qcamuc002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.qcamuc003 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=t0.qcamuc003 AND t4.imaal001='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=t0.qcamuc005 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.qcamuc008 AND t6.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.qcamucent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("qcamuc_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamuc005,qcamuc006,qcamuc008,qcamuc009,qcamucud001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"qcamuc_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_qcamuc001,g_browser[g_cnt].b_qcamuc002, 
          g_browser[g_cnt].b_qcamuc003,g_browser[g_cnt].b_qcamuc004,g_browser[g_cnt].b_qcamuc005,g_browser[g_cnt].b_qcamuc006, 
          g_browser[g_cnt].b_qcamuc007,g_browser[g_cnt].b_qcamuc008,g_browser[g_cnt].b_qcamuc009,g_browser[g_cnt].b_qcamucud001, 
          g_browser[g_cnt].b_qcamuc001_desc,g_browser[g_cnt].b_qcamuc002_desc,g_browser[g_cnt].b_qcamuc003_desc, 
          g_browser[g_cnt].b_qcamuc003_desc_1,g_browser[g_cnt].b_qcamuc005_desc,g_browser[g_cnt].b_qcamuc008_desc 
 
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
         CALL cqci010_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_qcamuc001) THEN
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
 
{<section id="cqci010.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION cqci010_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_qcamuc_m.qcamuc001 = g_browser[g_current_idx].b_qcamuc001   
   LET g_qcamuc_m.qcamuc002 = g_browser[g_current_idx].b_qcamuc002   
   LET g_qcamuc_m.qcamuc003 = g_browser[g_current_idx].b_qcamuc003   
   LET g_qcamuc_m.qcamuc004 = g_browser[g_current_idx].b_qcamuc004   
   LET g_qcamuc_m.qcamuc005 = g_browser[g_current_idx].b_qcamuc005   
   LET g_qcamuc_m.qcamuc006 = g_browser[g_current_idx].b_qcamuc006   
   LET g_qcamuc_m.qcamuc008 = g_browser[g_current_idx].b_qcamuc008   
   LET g_qcamuc_m.qcamuc009 = g_browser[g_current_idx].b_qcamuc009   
   LET g_qcamuc_m.qcamucud001 = g_browser[g_current_idx].b_qcamucud001   
 
   EXECUTE cqci010_master_referesh USING g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
       g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
       g_qcamuc_m.qcamucud001 INTO g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
       g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucowndp, 
       g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt, 
       g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc008_desc,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid_desc,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamucmodid_desc 
 
   
   CALL cqci010_qcamuc_t_mask()
   CALL cqci010_show()
      
END FUNCTION
 
{</section>}
 
{<section id="cqci010.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION cqci010_ui_detailshow()
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
 
{<section id="cqci010.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION cqci010_ui_browser_refresh()
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
      IF g_browser[l_i].b_qcamuc001 = g_qcamuc_m.qcamuc001 
         AND g_browser[l_i].b_qcamuc002 = g_qcamuc_m.qcamuc002 
         AND g_browser[l_i].b_qcamuc003 = g_qcamuc_m.qcamuc003 
         AND g_browser[l_i].b_qcamuc004 = g_qcamuc_m.qcamuc004 
         AND g_browser[l_i].b_qcamuc005 = g_qcamuc_m.qcamuc005 
         AND g_browser[l_i].b_qcamuc006 = g_qcamuc_m.qcamuc006 
         AND g_browser[l_i].b_qcamuc008 = g_qcamuc_m.qcamuc008 
         AND g_browser[l_i].b_qcamuc009 = g_qcamuc_m.qcamuc009 
         AND g_browser[l_i].b_qcamucud001 = g_qcamuc_m.qcamucud001 
 
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
 
{<section id="cqci010.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION cqci010_construct()
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
   INITIALIZE g_qcamuc_m.* TO NULL
   CALL g_qcanuc_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   INITIALIZE g_wc2_table2 TO NULL
   CALL g_qcanuc2_d.clear()
   #add by lixh 20150703 150702-00006#10
   LET g_qcamuc_m.qcamuc001 = g_qcamuc001
   CALL cqci010_qcamuc001_desc(g_qcamuc_m.qcamuc001)  
   DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc001_desc
   #add by lixh 20150703 150702-00006#10   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamucud001,qcamuc005,qcamuc006, 
          qcamuc007,qcamuc008,qcamuc009,qcamuc010,qcamucstus,qcamucownid,qcamucowndp,qcamuccrtid,qcamuccrtdp, 
          qcamuccrtdt,qcamucmodid,qcamucmoddt,qcamuccnfid,qcamuccnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<qcamuccrtdt>>----
         AFTER FIELD qcamuccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<qcamucmoddt>>----
         AFTER FIELD qcamucmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<qcamuccnfdt>>----
         AFTER FIELD qcamuccnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<qcamucpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.qcamuc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc001
            #add-point:ON ACTION controlp INFIELD qcamuc001 name="construct.c.qcamuc001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c' 
#            LET g_qryparam.reqry = FALSE
#            CALL q_ooal002_4()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO qcamuc001  #顯示到畫面上
#            NEXT FIELD qcamuc001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc001
            #add-point:BEFORE FIELD qcamuc001 name="construct.b.qcamuc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc001
            
            #add-point:AFTER FIELD qcamuc001 name="construct.a.qcamuc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc002
            #add-point:ON ACTION controlp INFIELD qcamuc002 name="construct.c.qcamuc002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c' 
#            LET g_qryparam.reqry = FALSE
#            CALL q_oocq002()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO qcamuc002  #顯示到畫面上
#            NEXT FIELD qcamuc002                     #返回原欄位
    
	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#150527 by whitney modify start
#            CALL q_imcg111()                           #呼叫開窗
            LET g_qryparam.arg1 = "205" 
            CALL q_oocq002()                       #呼叫開窗
#150527 by whitney modify end
            DISPLAY g_qryparam.return1 TO qcam002  #顯示到畫面上

            NEXT FIELD qcam002                     #返回原欄位




            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc002
            #add-point:BEFORE FIELD qcamuc002 name="construct.b.qcamuc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc002
            
            #add-point:AFTER FIELD qcamuc002 name="construct.a.qcamuc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc003
            #add-point:ON ACTION controlp INFIELD qcamuc003 name="construct.c.qcamuc003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamuc003  #顯示到畫面上
            NEXT FIELD qcamuc003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc003
            #add-point:BEFORE FIELD qcamuc003 name="construct.b.qcamuc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc003
            
            #add-point:AFTER FIELD qcamuc003 name="construct.a.qcamuc003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc004
            #add-point:BEFORE FIELD qcamuc004 name="construct.b.qcamuc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc004
            
            #add-point:AFTER FIELD qcamuc004 name="construct.a.qcamuc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc004
            #add-point:ON ACTION controlp INFIELD qcamuc004 name="construct.c.qcamuc004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_qcam004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamuc004  #顯示到畫面上

            NEXT FIELD qcamuc004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamucud001
            #add-point:BEFORE FIELD qcamucud001 name="construct.b.qcamucud001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamucud001
            
            #add-point:AFTER FIELD qcamucud001 name="construct.a.qcamucud001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamucud001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamucud001
            #add-point:ON ACTION controlp INFIELD qcamucud001 name="construct.c.qcamucud001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.qcamuc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc005
            #add-point:ON ACTION controlp INFIELD qcamuc005 name="construct.c.qcamuc005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamuc005  #顯示到畫面上
            NEXT FIELD qcamuc005                     #返回原欄位
    

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc005
            #add-point:BEFORE FIELD qcamuc005 name="construct.b.qcamuc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc005
            
            #add-point:AFTER FIELD qcamuc005 name="construct.a.qcamuc005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc006
            #add-point:BEFORE FIELD qcamuc006 name="construct.b.qcamuc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc006
            
            #add-point:AFTER FIELD qcamuc006 name="construct.a.qcamuc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc006
            #add-point:ON ACTION controlp INFIELD qcamuc006 name="construct.c.qcamuc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc007
            #add-point:BEFORE FIELD qcamuc007 name="construct.b.qcamuc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc007
            
            #add-point:AFTER FIELD qcamuc007 name="construct.a.qcamuc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc007
            #add-point:ON ACTION controlp INFIELD qcamuc007 name="construct.c.qcamuc007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.qcamuc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc008
            #add-point:ON ACTION controlp INFIELD qcamuc008 name="construct.c.qcamuc008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','2','3')"
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamuc008  #顯示到畫面上
            NEXT FIELD qcamuc008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc008
            #add-point:BEFORE FIELD qcamuc008 name="construct.b.qcamuc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc008
            
            #add-point:AFTER FIELD qcamuc008 name="construct.a.qcamuc008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc009
            #add-point:BEFORE FIELD qcamuc009 name="construct.b.qcamuc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc009
            
            #add-point:AFTER FIELD qcamuc009 name="construct.a.qcamuc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc009
            #add-point:ON ACTION controlp INFIELD qcamuc009 name="construct.c.qcamuc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc010
            #add-point:BEFORE FIELD qcamuc010 name="construct.b.qcamuc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc010
            
            #add-point:AFTER FIELD qcamuc010 name="construct.a.qcamuc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuc010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc010
            #add-point:ON ACTION controlp INFIELD qcamuc010 name="construct.c.qcamuc010"




            #END add-point
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamucstus
            #add-point:BEFORE FIELD qcamucstus name="construct.b.qcamucstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamucstus
            
            #add-point:AFTER FIELD qcamucstus name="construct.a.qcamucstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamucstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamucstus
            #add-point:ON ACTION controlp INFIELD qcamucstus name="construct.c.qcamucstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.qcamucownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamucownid
            #add-point:ON ACTION controlp INFIELD qcamucownid name="construct.c.qcamucownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamucownid  #顯示到畫面上
            NEXT FIELD qcamucownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamucownid
            #add-point:BEFORE FIELD qcamucownid name="construct.b.qcamucownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamucownid
            
            #add-point:AFTER FIELD qcamucownid name="construct.a.qcamucownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamucowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamucowndp
            #add-point:ON ACTION controlp INFIELD qcamucowndp name="construct.c.qcamucowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamucowndp  #顯示到畫面上
            NEXT FIELD qcamucowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamucowndp
            #add-point:BEFORE FIELD qcamucowndp name="construct.b.qcamucowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamucowndp
            
            #add-point:AFTER FIELD qcamucowndp name="construct.a.qcamucowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuccrtid
            #add-point:ON ACTION controlp INFIELD qcamuccrtid name="construct.c.qcamuccrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamuccrtid  #顯示到畫面上
            NEXT FIELD qcamuccrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuccrtid
            #add-point:BEFORE FIELD qcamuccrtid name="construct.b.qcamuccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuccrtid
            
            #add-point:AFTER FIELD qcamuccrtid name="construct.a.qcamuccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcamuccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuccrtdp
            #add-point:ON ACTION controlp INFIELD qcamuccrtdp name="construct.c.qcamuccrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamuccrtdp  #顯示到畫面上
            NEXT FIELD qcamuccrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuccrtdp
            #add-point:BEFORE FIELD qcamuccrtdp name="construct.b.qcamuccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuccrtdp
            
            #add-point:AFTER FIELD qcamuccrtdp name="construct.a.qcamuccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuccrtdt
            #add-point:BEFORE FIELD qcamuccrtdt name="construct.b.qcamuccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.qcamucmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamucmodid
            #add-point:ON ACTION controlp INFIELD qcamucmodid name="construct.c.qcamucmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamucmodid  #顯示到畫面上
            NEXT FIELD qcamucmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamucmodid
            #add-point:BEFORE FIELD qcamucmodid name="construct.b.qcamucmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamucmodid
            
            #add-point:AFTER FIELD qcamucmodid name="construct.a.qcamucmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamucmoddt
            #add-point:BEFORE FIELD qcamucmoddt name="construct.b.qcamucmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.qcamuccnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuccnfid
            #add-point:ON ACTION controlp INFIELD qcamuccnfid name="construct.c.qcamuccnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcamuccnfid  #顯示到畫面上
            NEXT FIELD qcamuccnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuccnfid
            #add-point:BEFORE FIELD qcamuccnfid name="construct.b.qcamuccnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuccnfid
            
            #add-point:AFTER FIELD qcamuccnfid name="construct.a.qcamuccnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuccnfdt
            #add-point:BEFORE FIELD qcamuccnfdt name="construct.b.qcamuccnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON qcanuc009,qcanuc010,qcanuc012,qcanuc013,qcanuc014,qcanuc015,qcanuc016, 
          qcanuc018
           FROM s_detail1[1].qcanuc009,s_detail1[1].qcanuc010,s_detail1[1].qcanuc012,s_detail1[1].qcanuc013, 
               s_detail1[1].qcanuc014,s_detail1[1].qcanuc015,s_detail1[1].qcanuc016,s_detail1[1].qcanuc018 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc009
            #add-point:BEFORE FIELD qcanuc009 name="construct.b.page1.qcanuc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc009
            
            #add-point:AFTER FIELD qcanuc009 name="construct.a.page1.qcanuc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcanuc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc009
            #add-point:ON ACTION controlp INFIELD qcanuc009 name="construct.c.page1.qcanuc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc010
            #add-point:BEFORE FIELD qcanuc010 name="construct.b.page1.qcanuc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc010
            
            #add-point:AFTER FIELD qcanuc010 name="construct.a.page1.qcanuc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcanuc010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc010
            #add-point:ON ACTION controlp INFIELD qcanuc010 name="construct.c.page1.qcanuc010"

            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1051'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcanuc010  #顯示到畫面上

            NEXT FIELD qcanuc010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc012
            #add-point:BEFORE FIELD qcanuc012 name="construct.b.page1.qcanuc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc012
            
            #add-point:AFTER FIELD qcanuc012 name="construct.a.page1.qcanuc012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcanuc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc012
            #add-point:ON ACTION controlp INFIELD qcanuc012 name="construct.c.page1.qcanuc012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc013
            #add-point:BEFORE FIELD qcanuc013 name="construct.b.page1.qcanuc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc013
            
            #add-point:AFTER FIELD qcanuc013 name="construct.a.page1.qcanuc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcanuc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc013
            #add-point:ON ACTION controlp INFIELD qcanuc013 name="construct.c.page1.qcanuc013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc014
            #add-point:BEFORE FIELD qcanuc014 name="construct.b.page1.qcanuc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc014
            
            #add-point:AFTER FIELD qcanuc014 name="construct.a.page1.qcanuc014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcanuc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc014
            #add-point:ON ACTION controlp INFIELD qcanuc014 name="construct.c.page1.qcanuc014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc015
            #add-point:BEFORE FIELD qcanuc015 name="construct.b.page1.qcanuc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc015
            
            #add-point:AFTER FIELD qcanuc015 name="construct.a.page1.qcanuc015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcanuc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc015
            #add-point:ON ACTION controlp INFIELD qcanuc015 name="construct.c.page1.qcanuc015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.qcanuc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc016
            #add-point:ON ACTION controlp INFIELD qcanuc016 name="construct.c.page1.qcanuc016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1052'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcanuc016  #顯示到畫面上
            NEXT FIELD qcanuc016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc016
            #add-point:BEFORE FIELD qcanuc016 name="construct.b.page1.qcanuc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc016
            
            #add-point:AFTER FIELD qcanuc016 name="construct.a.page1.qcanuc016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.qcanuc018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc018
            #add-point:ON ACTION controlp INFIELD qcanuc018 name="construct.c.page1.qcanuc018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcanuc018  #顯示到畫面上
            NEXT FIELD qcanuc018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc018
            #add-point:BEFORE FIELD qcanuc018 name="construct.b.page1.qcanuc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc018
            
            #add-point:AFTER FIELD qcanuc018 name="construct.a.page1.qcanuc018"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
       CONSTRUCT g_wc2_table2 ON qcanuc019,qcanuc020,qcanuc021,qcanuc022,qcanuc023,qcanuc024,qcanuc025,qcanuc026
           FROM s_detail2[1].qcanuc019,s_detail2[1].qcanuc020,s_detail2[1].qcanuc021,s_detail2[1].qcanuc022,
                s_detail2[1].qcanuc023,s_detail2[1].qcanuc024,s_detail2[1].qcanuc025,s_detail2[1].qcanuc026
                      
        
       
       END CONSTRUCT
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
                  WHEN la_wc[li_idx].tableid = "qcamuc_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "qcanuc_t" 
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
   LET g_wc2 = g_wc2_table1," AND ",g_wc2_table2
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION cqci010_filter()
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
      CONSTRUCT g_wc_filter ON qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamuc005,qcamuc006,qcamuc007, 
          qcamuc008,qcamuc009,qcamucud001
                          FROM s_browse[1].b_qcamuc001,s_browse[1].b_qcamuc002,s_browse[1].b_qcamuc003, 
                              s_browse[1].b_qcamuc004,s_browse[1].b_qcamuc005,s_browse[1].b_qcamuc006, 
                              s_browse[1].b_qcamuc007,s_browse[1].b_qcamuc008,s_browse[1].b_qcamuc009, 
                              s_browse[1].b_qcamucud001
 
         BEFORE CONSTRUCT
               DISPLAY cqci010_filter_parser('qcamuc001') TO s_browse[1].b_qcamuc001
            DISPLAY cqci010_filter_parser('qcamuc002') TO s_browse[1].b_qcamuc002
            DISPLAY cqci010_filter_parser('qcamuc003') TO s_browse[1].b_qcamuc003
            DISPLAY cqci010_filter_parser('qcamuc004') TO s_browse[1].b_qcamuc004
            DISPLAY cqci010_filter_parser('qcamuc005') TO s_browse[1].b_qcamuc005
            DISPLAY cqci010_filter_parser('qcamuc006') TO s_browse[1].b_qcamuc006
            DISPLAY cqci010_filter_parser('qcamuc007') TO s_browse[1].b_qcamuc007
            DISPLAY cqci010_filter_parser('qcamuc008') TO s_browse[1].b_qcamuc008
            DISPLAY cqci010_filter_parser('qcamuc009') TO s_browse[1].b_qcamuc009
            DISPLAY cqci010_filter_parser('qcamucud001') TO s_browse[1].b_qcamucud001
      
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
 
      CALL cqci010_filter_show('qcamuc001')
   CALL cqci010_filter_show('qcamuc002')
   CALL cqci010_filter_show('qcamuc003')
   CALL cqci010_filter_show('qcamuc004')
   CALL cqci010_filter_show('qcamuc005')
   CALL cqci010_filter_show('qcamuc006')
   CALL cqci010_filter_show('qcamuc007')
   CALL cqci010_filter_show('qcamuc008')
   CALL cqci010_filter_show('qcamuc009')
   CALL cqci010_filter_show('qcamucud001')
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION cqci010_filter_parser(ps_field)
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
 
{<section id="cqci010.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION cqci010_filter_show(ps_field)
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
   LET ls_condition = cqci010_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION cqci010_query()
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
   CALL g_qcanuc_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL cqci010_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL cqci010_browser_fill("")
      CALL cqci010_fetch("")
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
      CALL cqci010_filter_show('qcamuc001')
   CALL cqci010_filter_show('qcamuc002')
   CALL cqci010_filter_show('qcamuc003')
   CALL cqci010_filter_show('qcamuc004')
   CALL cqci010_filter_show('qcamuc005')
   CALL cqci010_filter_show('qcamuc006')
   CALL cqci010_filter_show('qcamuc007')
   CALL cqci010_filter_show('qcamuc008')
   CALL cqci010_filter_show('qcamuc009')
   CALL cqci010_filter_show('qcamucud001')
   CALL cqci010_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL cqci010_fetch("F") 
      #顯示單身筆數
      CALL cqci010_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION cqci010_fetch(p_flag)
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
   
   LET g_qcamuc_m.qcamuc001 = g_browser[g_current_idx].b_qcamuc001
   LET g_qcamuc_m.qcamuc002 = g_browser[g_current_idx].b_qcamuc002
   LET g_qcamuc_m.qcamuc003 = g_browser[g_current_idx].b_qcamuc003
   LET g_qcamuc_m.qcamuc004 = g_browser[g_current_idx].b_qcamuc004
   LET g_qcamuc_m.qcamuc005 = g_browser[g_current_idx].b_qcamuc005
   LET g_qcamuc_m.qcamuc006 = g_browser[g_current_idx].b_qcamuc006
   LET g_qcamuc_m.qcamuc008 = g_browser[g_current_idx].b_qcamuc008
   LET g_qcamuc_m.qcamuc009 = g_browser[g_current_idx].b_qcamuc009
   LET g_qcamuc_m.qcamucud001 = g_browser[g_current_idx].b_qcamucud001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE cqci010_master_referesh USING g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
       g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
       g_qcamuc_m.qcamucud001 INTO g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
       g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucowndp, 
       g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt, 
       g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc008_desc,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid_desc,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamucmodid_desc 
 
   
   #遮罩相關處理
   LET g_qcamuc_m_mask_o.* =  g_qcamuc_m.*
   CALL cqci010_qcamuc_t_mask()
   LET g_qcamuc_m_mask_n.* =  g_qcamuc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL cqci010_set_act_visible()   
   CALL cqci010_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_qcamuc_m_t.* = g_qcamuc_m.*
   LET g_qcamuc_m_o.* = g_qcamuc_m.*
   
   LET g_data_owner = g_qcamuc_m.qcamucownid      
   LET g_data_dept  = g_qcamuc_m.qcamucowndp
   
   #重新顯示   
   CALL cqci010_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.insert" >}
#+ 資料新增
PRIVATE FUNCTION cqci010_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_qcanuc_d.clear()   
 
 
   INITIALIZE g_qcamuc_m.* TO NULL             #DEFAULT 設定
   
   LET g_qcamuc001_t = NULL
   LET g_qcamuc002_t = NULL
   LET g_qcamuc003_t = NULL
   LET g_qcamuc004_t = NULL
   LET g_qcamuc005_t = NULL
   LET g_qcamuc006_t = NULL
   LET g_qcamuc008_t = NULL
   LET g_qcamuc009_t = NULL
   LET g_qcamucud001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_qcamuc_m.qcamucownid = g_user
      LET g_qcamuc_m.qcamucowndp = g_dept
      LET g_qcamuc_m.qcamuccrtid = g_user
      LET g_qcamuc_m.qcamuccrtdp = g_dept 
      LET g_qcamuc_m.qcamuccrtdt = cl_get_current()
      LET g_qcamuc_m.qcamucmodid = g_user
      LET g_qcamuc_m.qcamucmoddt = cl_get_current()
      LET g_qcamuc_m.qcamucstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_qcamuc_m.qcamuc007 = "0"
      LET g_qcamuc_m.qcamuc009 = "0"
#      LET g_qcamuc_m.qcamucstus = "Y"
      LET g_qcamuc_m.qcamuc004 = 'ALL'
      LET g_qcamuc_m.qcamuc008 = 'ALL'
      LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
      LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
      LET g_qcamuc_m.qcamuc006 = 0
      LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
      #add by lixh 20150703 150702-00006#10
      LET g_qcamuc_m.qcamuc001 = g_qcamuc001
      CALL cqci010_qcamuc001_desc(g_qcamuc_m.qcamuc001)  
      DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc001_desc
      #add by lixh 20150703 150702-00006#10      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_qcamuc_m_t.* = g_qcamuc_m.*
      LET g_qcamuc_m_o.* = g_qcamuc_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_qcamuc_m.qcamucstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         
      END CASE
 
 
 
    
      CALL cqci010_input("a")
      
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
         INITIALIZE g_qcamuc_m.* TO NULL
         INITIALIZE g_qcanuc_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL cqci010_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_qcanuc_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL cqci010_set_act_visible()   
   CALL cqci010_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_qcamuc001_t = g_qcamuc_m.qcamuc001
   LET g_qcamuc002_t = g_qcamuc_m.qcamuc002
   LET g_qcamuc003_t = g_qcamuc_m.qcamuc003
   LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
   LET g_qcamuc005_t = g_qcamuc_m.qcamuc005
   LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
   LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
   LET g_qcamuc009_t = g_qcamuc_m.qcamuc009
   LET g_qcamucud001_t = g_qcamuc_m.qcamucud001
 
   
   #組合新增資料的條件
   LET g_add_browse = " qcamucent = " ||g_enterprise|| " AND",
                      " qcamuc001 = '", g_qcamuc_m.qcamuc001, "' "
                      ," AND qcamuc002 = '", g_qcamuc_m.qcamuc002, "' "
                      ," AND qcamuc003 = '", g_qcamuc_m.qcamuc003, "' "
                      ," AND qcamuc004 = '", g_qcamuc_m.qcamuc004, "' "
                      ," AND qcamuc005 = '", g_qcamuc_m.qcamuc005, "' "
                      ," AND qcamuc006 = '", g_qcamuc_m.qcamuc006, "' "
                      ," AND qcamuc008 = '", g_qcamuc_m.qcamuc008, "' "
                      ," AND qcamuc009 = '", g_qcamuc_m.qcamuc009, "' "
                      ," AND qcamucud001 = '", g_qcamuc_m.qcamucud001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL cqci010_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE cqci010_cl
   
   CALL cqci010_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE cqci010_master_referesh USING g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
       g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
       g_qcamuc_m.qcamucud001 INTO g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
       g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucowndp, 
       g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt, 
       g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc008_desc,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid_desc,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamucmodid_desc 
 
   
   
   #遮罩相關處理
   LET g_qcamuc_m_mask_o.* =  g_qcamuc_m.*
   CALL cqci010_qcamuc_t_mask()
   LET g_qcamuc_m_mask_n.* =  g_qcamuc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005, 
       g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc008_desc, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp,g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtid_desc, 
       g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid, 
       g_qcamuc_m.qcamucmodid_desc,g_qcamuc_m.qcamucmoddt,g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_qcamuc_m.qcamucownid      
   LET g_data_dept  = g_qcamuc_m.qcamucowndp
   
   #功能已完成,通報訊息中心
   CALL cqci010_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.modify" >}
#+ 資料修改
PRIVATE FUNCTION cqci010_modify()
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
   LET g_qcamuc_m_t.* = g_qcamuc_m.*
   LET g_qcamuc_m_o.* = g_qcamuc_m.*
   
   IF g_qcamuc_m.qcamuc001 IS NULL
   OR g_qcamuc_m.qcamuc002 IS NULL
   OR g_qcamuc_m.qcamuc003 IS NULL
   OR g_qcamuc_m.qcamuc004 IS NULL
   OR g_qcamuc_m.qcamuc005 IS NULL
   OR g_qcamuc_m.qcamuc006 IS NULL
   OR g_qcamuc_m.qcamuc008 IS NULL
   OR g_qcamuc_m.qcamuc009 IS NULL
   OR g_qcamuc_m.qcamucud001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_qcamuc001_t = g_qcamuc_m.qcamuc001
   LET g_qcamuc002_t = g_qcamuc_m.qcamuc002
   LET g_qcamuc003_t = g_qcamuc_m.qcamuc003
   LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
   LET g_qcamuc005_t = g_qcamuc_m.qcamuc005
   LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
   LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
   LET g_qcamuc009_t = g_qcamuc_m.qcamuc009
   LET g_qcamucud001_t = g_qcamuc_m.qcamucud001
 
   CALL s_transaction_begin()
   
   OPEN cqci010_cl USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamucud001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN cqci010_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE cqci010_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE cqci010_master_referesh USING g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
       g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
       g_qcamuc_m.qcamucud001 INTO g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
       g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucowndp, 
       g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt, 
       g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc008_desc,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid_desc,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamucmodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT cqci010_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_qcamuc_m_mask_o.* =  g_qcamuc_m.*
   CALL cqci010_qcamuc_t_mask()
   LET g_qcamuc_m_mask_n.* =  g_qcamuc_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL cqci010_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_qcamuc001_t = g_qcamuc_m.qcamuc001
      LET g_qcamuc002_t = g_qcamuc_m.qcamuc002
      LET g_qcamuc003_t = g_qcamuc_m.qcamuc003
      LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
      LET g_qcamuc005_t = g_qcamuc_m.qcamuc005
      LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
      LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
      LET g_qcamuc009_t = g_qcamuc_m.qcamuc009
      LET g_qcamucud001_t = g_qcamuc_m.qcamucud001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_qcamuc_m.qcamucmodid = g_user 
LET g_qcamuc_m.qcamucmoddt = cl_get_current()
LET g_qcamuc_m.qcamucmodid_desc = cl_get_username(g_qcamuc_m.qcamucmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL cqci010_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE qcamuc_t SET (qcamucmodid,qcamucmoddt) = (g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt) 
 
          WHERE qcamucent = g_enterprise AND qcamuc001 = g_qcamuc001_t
            AND qcamuc002 = g_qcamuc002_t
            AND qcamuc003 = g_qcamuc003_t
            AND qcamuc004 = g_qcamuc004_t
            AND qcamuc005 = g_qcamuc005_t
            AND qcamuc006 = g_qcamuc006_t
            AND qcamuc008 = g_qcamuc008_t
            AND qcamuc009 = g_qcamuc009_t
            AND qcamucud001 = g_qcamucud001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_qcamuc_m.* = g_qcamuc_m_t.*
            CALL cqci010_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_qcamuc_m.qcamuc001 != g_qcamuc_m_t.qcamuc001
      OR g_qcamuc_m.qcamuc002 != g_qcamuc_m_t.qcamuc002
      OR g_qcamuc_m.qcamuc003 != g_qcamuc_m_t.qcamuc003
      OR g_qcamuc_m.qcamuc004 != g_qcamuc_m_t.qcamuc004
      OR g_qcamuc_m.qcamuc005 != g_qcamuc_m_t.qcamuc005
      OR g_qcamuc_m.qcamuc006 != g_qcamuc_m_t.qcamuc006
      OR g_qcamuc_m.qcamuc008 != g_qcamuc_m_t.qcamuc008
      OR g_qcamuc_m.qcamuc009 != g_qcamuc_m_t.qcamuc009
      OR g_qcamuc_m.qcamucud001 != g_qcamuc_m_t.qcamucud001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE qcanuc_t SET qcanuc001 = g_qcamuc_m.qcamuc001
                                       ,qcanuc002 = g_qcamuc_m.qcamuc002
                                       ,qcanuc003 = g_qcamuc_m.qcamuc003
                                       ,qcanuc004 = g_qcamuc_m.qcamuc004
                                       ,qcanuc005 = g_qcamuc_m.qcamuc005
                                       ,qcanuc006 = g_qcamuc_m.qcamuc006
                                       ,qcanuc007 = g_qcamuc_m.qcamuc008
                                       ,qcanuc008 = g_qcamuc_m.qcamuc009
                                       ,qcanucud001 = g_qcamuc_m.qcamucud001
 
          WHERE qcanucent = g_enterprise AND qcanuc001 = g_qcamuc_m_t.qcamuc001
            AND qcanuc002 = g_qcamuc_m_t.qcamuc002
            AND qcanuc003 = g_qcamuc_m_t.qcamuc003
            AND qcanuc004 = g_qcamuc_m_t.qcamuc004
            AND qcanuc005 = g_qcamuc_m_t.qcamuc005
            AND qcanuc006 = g_qcamuc_m_t.qcamuc006
            AND qcanuc007 = g_qcamuc_m_t.qcamuc008
            AND qcanuc008 = g_qcamuc_m_t.qcamuc009
            AND qcanucud001 = g_qcamuc_m_t.qcamucud001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "qcanuc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "qcanuc_t:",SQLERRMESSAGE 
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
   CALL cqci010_set_act_visible()   
   CALL cqci010_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " qcamucent = " ||g_enterprise|| " AND",
                      " qcamuc001 = '", g_qcamuc_m.qcamuc001, "' "
                      ," AND qcamuc002 = '", g_qcamuc_m.qcamuc002, "' "
                      ," AND qcamuc003 = '", g_qcamuc_m.qcamuc003, "' "
                      ," AND qcamuc004 = '", g_qcamuc_m.qcamuc004, "' "
                      ," AND qcamuc005 = '", g_qcamuc_m.qcamuc005, "' "
                      ," AND qcamuc006 = '", g_qcamuc_m.qcamuc006, "' "
                      ," AND qcamuc008 = '", g_qcamuc_m.qcamuc008, "' "
                      ," AND qcamuc009 = '", g_qcamuc_m.qcamuc009, "' "
                      ," AND qcamucud001 = '", g_qcamuc_m.qcamucud001, "' "
 
   #填到對應位置
   CALL cqci010_browser_fill("")
 
   CLOSE cqci010_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL cqci010_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="cqci010.input" >}
#+ 資料輸入
PRIVATE FUNCTION cqci010_input(p_cmd)
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
   DEFINE l_sql            STRING
   DEFINE l_qcamuc010      LIKE qcamuc_t.qcamuc010
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_sum            LIKE type_t.num5
   DEFINE l_sum1            LIKE type_t.num5
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
   DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005, 
       g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc008_desc, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp,g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtid_desc, 
       g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid, 
       g_qcamuc_m.qcamucmodid_desc,g_qcamuc_m.qcamucmoddt,g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt 
 
   
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
   LET g_forupd_sql = "SELECT qcanuc009,qcanuc010,qcanuc011,qcanuc012,qcanuc013,qcanuc014,qcanuc015, 
       qcanuc016,qcanuc017,qcanuc018 FROM qcanuc_t WHERE qcanucent=? AND qcanuc001=? AND qcanuc002=?  
       AND qcanuc003=? AND qcanuc004=? AND qcanuc005=? AND qcanuc006=? AND qcanuc007=? AND qcanuc008=?  
       AND qcanucud001=? AND qcanuc009=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   LET g_forupd_sql2 = "SELECT qcanuc009,qcanuc010,'',qcanuc011,qcanuc013,qcanuc019,qcanuc020,qcanuc021,qcanuc022,qcanuc023,qcanuc024,qcanuc025,qcanuc026 FROM qcanuc_t WHERE qcanucent=? AND qcanuc001=? AND qcanuc002=? AND qcanuc003=? AND qcanuc004=? AND qcanuc005=? AND qcanuc006=? AND qcanuc007=? AND qcanuc008=? AND qcanuc009=? AND qcanucud001=? FOR UPDATE"
   LET g_forupd_sql2 = cl_sql_forupd(g_forupd_sql2)
   DECLARE cqci010_bcl2 CURSOR FROM g_forupd_sql2
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE cqci010_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL cqci010_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL cqci010_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
       g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_error_show = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="cqci010.input.head" >}
      #單頭段
      INPUT BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
          g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
          g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN cqci010_cl USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamucud001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN cqci010_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE cqci010_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL cqci010_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL cqci010_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc001
            
            #add-point:AFTER FIELD qcamuc001 name="input.a.qcamuc001"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            LET g_qcamuc_m.qcamuc001_desc = ''
            DISPLAY BY NAME g_qcamuc_m.qcamuc001_desc
            
            IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
        
        IF NOT cqci010_qcamuc001_chk(g_qcamuc_m.qcamuc001) THEN
               LET g_qcamuc_m.qcamuc001 = g_qcamuc001_t
               NEXT FIELD CURRENT
            END IF
        
            CALL cqci010_qcamuc001_desc(g_qcamuc_m.qcamuc001)


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc001
            #add-point:BEFORE FIELD qcamuc001 name="input.b.qcamuc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc001
            #add-point:ON CHANGE qcamuc001 name="input.g.qcamuc001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc002
            
            #add-point:AFTER FIELD qcamuc002 name="input.a.qcamuc002"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            LET g_qcamuc_m.qcamuc002_desc = ''
            DISPLAY BY NAME g_qcamuc_m.qcamuc002_desc
            
#            IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
   IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
         IF NOT cqci010_qcamuc002_chk(g_qcamuc_m.qcamuc002) THEN
               LET g_qcamuc_m.qcamuc002 = g_qcamuc002_t   
               NEXT FIELD CURRENT               
            END IF
 
            IF cqci010_qcamuc002_qcamuc003_default(g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003) THEN
               LET g_qcamuc_m.qcamuc002 = 'ALL'          
            END IF

            IF NOT cqci010_qcamuc002_qcamuc003_chk(g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00015'
               LET g_errparam.extend = g_qcamuc_m.qcamuc002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcamuc_m.qcamuc002 = g_qcamuc002_t
               NEXT FIELD CURRENT
            END IF

            CALL cqci010_qcamuc002_desc(g_qcamuc_m.qcamuc002)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc002
            #add-point:BEFORE FIELD qcamuc002 name="input.b.qcamuc002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc002
            #add-point:ON CHANGE qcamuc002 name="input.g.qcamuc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc003
            
            #add-point:AFTER FIELD qcamuc003 name="input.a.qcamuc003"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            LET g_qcamuc_m.qcamuc003_desc = ''
            DISPLAY BY NAME g_qcamuc_m.qcamuc003_desc  
            
#           IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
   IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
         IF NOT cqci010_qcamuc003_chk(g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003) THEN
               LET g_qcamuc_m.qcamuc003 = g_qcamuc003_t
               NEXT FIELD CURRENT
            END IF

            IF cqci010_qcamuc002_qcamuc003_default(g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003) THEN
               LET g_qcamuc_m.qcamuc003 = 'ALL'          
            END IF

            IF NOT cqci010_qcamuc002_qcamuc003_chk(g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00015'
               LET g_errparam.extend = g_qcamuc_m.qcamuc003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcamuc_m.qcamuc003 = g_qcamuc003_t
               NEXT FIELD CURRENT
            END IF

            IF cqci010_qcamuc004_entry(g_qcamuc_m.qcamuc003) THEN
               LET g_qcamuc_m.qcamuc004 = 'ALL'
               DISPLAY BY NAME g_qcamuc_m.qcamuc004
            END IF

            CALL cqci010_qcamuc003_desc(g_qcamuc_m.qcamuc003)


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc003
            #add-point:BEFORE FIELD qcamuc003 name="input.b.qcamuc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc003
            #add-point:ON CHANGE qcamuc003 name="input.g.qcamuc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc004
            #add-point:BEFORE FIELD qcamuc004 name="input.b.qcamuc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc004
            
            #add-point:AFTER FIELD qcamuc004 name="input.a.qcamuc004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF

   IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc004
            #add-point:ON CHANGE qcamuc004 name="input.g.qcamuc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamucud001
            #add-point:BEFORE FIELD qcamucud001 name="input.b.qcamucud001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamucud001
            
            #add-point:AFTER FIELD qcamucud001 name="input.a.qcamucud001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t  OR g_qcamuc_m.qcamucud001 != g_qcamucud001_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND "|| "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
   IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamucud001
            #add-point:ON CHANGE qcamucud001 name="input.g.qcamucud001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc005
            
            #add-point:AFTER FIELD qcamuc005 name="input.a.qcamuc005"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            LET g_qcamuc_m.qcamuc005_desc = ''
            DISPLAY BY NAME g_qcamuc_m.qcamuc005_desc
            
#           IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
   IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

           IF NOT cqci010_qcamuc005_chk(g_qcamuc_m.qcamuc005) THEN
               LET g_qcamuc_m.qcamuc005 = g_qcamuc005_t
               NEXT FIELD CURRENT
            END IF
            
            IF cl_null(g_qcamuc_m.qcamuc005) THEN
               LET g_qcamuc_m.qcamuc005 = 'ALL'
               DISPLAY BY NAME g_qcamuc_m.qcamuc005
            END IF

            CALL cqci010_qcamuc005_desc(g_qcamuc_m.qcamuc005)


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc005
            #add-point:BEFORE FIELD qcamuc005 name="input.b.qcamuc005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc005
            #add-point:ON CHANGE qcamuc005 name="input.g.qcamuc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc006
            #add-point:BEFORE FIELD qcamuc006 name="input.b.qcamuc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc006
            
            #add-point:AFTER FIELD qcamuc006 name="input.a.qcamuc006"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
   IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


         IF cl_null(g_qcamuc_m.qcamuc006) THEN 
            LET g_qcamuc_m.qcamuc006 = 0 
         END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc006
            #add-point:ON CHANGE qcamuc006 name="input.g.qcamuc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc007
            #add-point:BEFORE FIELD qcamuc007 name="input.b.qcamuc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc007
            
            #add-point:AFTER FIELD qcamuc007 name="input.a.qcamuc007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc007
            #add-point:ON CHANGE qcamuc007 name="input.g.qcamuc007"
          IF g_qcamuc_m.qcamuc007 = '0' THEN LET g_qcamuc_m.qcamuc008 = 'ALL' END IF
            DISPLAY BY NAME g_qcamuc_m.qcamuc008
            IF NOT cqci010_qcamuc008_chk(g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008) THEN
               NEXT FIELD qcamuc008
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc008
            
            #add-point:AFTER FIELD qcamuc008 name="input.a.qcamuc008"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
   IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

          IF NOT cqci010_qcamuc008_chk(g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008) THEN
               LET g_qcamuc_m.qcamuc008 = g_qcamuc008_t
               NEXT FIELD qcamuc008
            END IF

            CALL cqci010_qcamuc008_desc(g_qcamuc_m.qcamuc008)


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc008
            #add-point:BEFORE FIELD qcamuc008 name="input.b.qcamuc008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc008
            #add-point:ON CHANGE qcamuc008 name="input.g.qcamuc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc009
            #add-point:BEFORE FIELD qcamuc009 name="input.b.qcamuc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc009
            
            #add-point:AFTER FIELD qcamuc009 name="input.a.qcamuc009"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
#            IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF

   IF  NOT cl_null(g_qcamuc_m.qcamuc001) AND NOT cl_null(g_qcamuc_m.qcamuc002) AND NOT cl_null(g_qcamuc_m.qcamuc003) AND NOT cl_null(g_qcamuc_m.qcamuc004) AND NOT cl_null(g_qcamuc_m.qcamuc005) AND NOT cl_null(g_qcamuc_m.qcamuc006) AND NOT cl_null(g_qcamuc_m.qcamuc008) AND NOT cl_null(g_qcamuc_m.qcamuc009) AND NOT cl_null(g_qcamuc_m.qcamucud001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t  OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t  OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t  OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t  OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t  OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t  OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t  OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t ))) THEN 
                  IF NOT ap_chk_notDup(g_qcamuc_m.qcamuc001,"SELECT COUNT(*) FROM qcamuc_t WHERE "||"qcamucent = " ||g_enterprise|| " AND "||"qcamuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcamuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcamuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcamuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcamuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcamuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcamuc008 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcamuc009 = '"||g_qcamuc_m.qcamuc009 ||"' AND " || "qcamucud001 = '"||g_qcamuc_m.qcamucud001 ||"'" ,'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc009
            #add-point:ON CHANGE qcamuc009 name="input.g.qcamuc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamuc010
            #add-point:BEFORE FIELD qcamuc010 name="input.b.qcamuc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamuc010
            
            #add-point:AFTER FIELD qcamuc010 name="input.a.qcamuc010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamuc010
            #add-point:ON CHANGE qcamuc010 name="input.g.qcamuc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcamucstus
            #add-point:BEFORE FIELD qcamucstus name="input.b.qcamucstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcamucstus
            
            #add-point:AFTER FIELD qcamucstus name="input.a.qcamucstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcamucstus
            #add-point:ON CHANGE qcamucstus name="input.g.qcamucstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.qcamuc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc001
            #add-point:ON ACTION controlp INFIELD qcamuc001 name="input.c.qcamuc001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_qcamuc_m.qcamuc001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooal002_4()                                #呼叫開窗
 
            LET g_qcamuc_m.qcamuc001 = g_qryparam.return1              

            DISPLAY g_qcamuc_m.qcamuc001 TO qcamuc001              #
           CALL cqci010_qcamuc001_desc(g_qcamuc_m.qcamuc001)
            NEXT FIELD qcamuc001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.qcamuc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc002
            #add-point:ON ACTION controlp INFIELD qcamuc002 name="input.c.qcamuc002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_qcamuc_m.qcamuc002             #給予default值
            LET g_qryparam.default2 = "" #g_qcamuc_m.oocql004 #說明
            #給予arg
#            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.arg1 = "205" 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_qcamuc_m.qcamuc002 = g_qryparam.return1              
            #LET g_qcamuc_m.oocql004 = g_qryparam.return2 
            DISPLAY g_qcamuc_m.qcamuc002 TO qcamuc002              #
            #DISPLAY g_qcamuc_m.oocql004 TO oocql004 #說明
             CALL cqci010_qcamuc002_desc(g_qcamuc_m.qcamuc002)
            NEXT FIELD qcamuc002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.qcamuc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc003
            #add-point:ON ACTION controlp INFIELD qcamuc003 name="input.c.qcamuc003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_qcamuc_m.qcamuc003             #給予default值

            #給予arg
            IF NOT cl_null(g_qcamuc_m.qcamuc002) AND g_qcamuc_m.qcamuc002 != 'ALL' THEN
               LET g_qryparam.where = " imae111 = '",g_qcamuc_m.qcamuc002,"'"
            END IF
            LET g_qryparam.arg1 = "" #s

 
            CALL q_imaa001_8()                                #呼叫開窗
 
            LET g_qcamuc_m.qcamuc003 = g_qryparam.return1              

            DISPLAY g_qcamuc_m.qcamuc003 TO qcamuc003              #
           CALL cqci010_qcamuc003_desc(g_qcamuc_m.qcamuc003)
            NEXT FIELD qcamuc003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.qcamuc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc004
            #add-point:ON ACTION controlp INFIELD qcamuc004 name="input.c.qcamuc004"
            IF NOT cl_null(g_qcamuc_m.qcamuc003) THEN
               CALL aimm200_02(g_qcamuc_m.qcamuc003) RETURNING g_qcamuc_m.qcamuc004
               DISPLAY g_qcamuc_m.qcamuc004 TO qcamuc004
               NEXT FIELD qcamuc004
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.qcamucud001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamucud001
            #add-point:ON ACTION controlp INFIELD qcamucud001 name="input.c.qcamucud001"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcamuc005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc005
            #add-point:ON ACTION controlp INFIELD qcamuc005 name="input.c.qcamuc005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_qcamuc_m.qcamuc005             #給予default值
            LET g_qryparam.default2 = "" #g_qcamuc_m.oocql004 #說明
            #給予arg
#            LET g_qryparam.arg1 = "" #s
             LET g_qryparam.arg1 = 221 #
            CALL q_oocq002()                                #呼叫開窗 
            LET g_qcamuc_m.qcamuc005 = g_qryparam.return1              
            #LET g_qcamuc_m.oocql004 = g_qryparam.return2 
            DISPLAY g_qcamuc_m.qcamuc005 TO qcamuc005              #
            #DISPLAY g_qcamuc_m.oocql004 TO oocql004 #說明
            CALL cqci010_qcamuc005_desc(g_qcamuc_m.qcamuc005)
            NEXT FIELD qcamuc005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.qcamuc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc006
            #add-point:ON ACTION controlp INFIELD qcamuc006 name="input.c.qcamuc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcamuc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc007
            #add-point:ON ACTION controlp INFIELD qcamuc007 name="input.c.qcamuc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcamuc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc008
            #add-point:ON ACTION controlp INFIELD qcamuc008 name="input.c.qcamuc008"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_qcamuc_m.qcamuc008             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = "" #s
             CASE 
               WHEN g_qcamuc_m.qcamuc007 = '0'
                  LET g_qryparam.arg1 = "('1','2','3')"
               WHEN g_qcamuc_m.qcamuc007 = '1'
                  LET g_qryparam.arg1 = "('2','3')"
               WHEN g_qcamuc_m.qcamuc007 = '2'
                  LET g_qryparam.arg1 = "('1','3')"
            END CASE
 
            CALL q_pmaa001_1()                                #呼叫開窗
 
            LET g_qcamuc_m.qcamuc008 = g_qryparam.return1              

            DISPLAY g_qcamuc_m.qcamuc008 TO qcamuc008              #
           CALL cqci010_qcamuc008_desc(g_qcamuc_m.qcamuc008)
            NEXT FIELD qcamuc008                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.qcamuc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc009
            #add-point:ON ACTION controlp INFIELD qcamuc009 name="input.c.qcamuc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcamuc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamuc010
            #add-point:ON ACTION controlp INFIELD qcamuc010 name="input.c.qcamuc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.qcamucstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcamucstus
            #add-point:ON ACTION controlp INFIELD qcamucstus name="input.c.qcamucstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
                g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
                g_qcamuc_m.qcamucud001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  IF NOT cqci010_imae111_chk(g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003) THEN
                     NEXT FIELD qcamuc003
                  END IF
                  
                  CALL s_aooi350_get_idno("qcamuc010","qcamuc_t","") RETURNING g_success,g_qcamuc_m.qcamuc010
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aqc-00033'
                     LET g_errparam.extend = g_qcamuc_m.qcamuc010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF
               #end add-point
               
               INSERT INTO qcamuc_t (qcamucent,qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamucud001,qcamuc005, 
                   qcamuc006,qcamuc007,qcamuc008,qcamuc009,qcamuc010,qcamucstus,qcamucownid,qcamucowndp, 
                   qcamuccrtid,qcamuccrtdp,qcamuccrtdt,qcamucmodid,qcamucmoddt,qcamuccnfid,qcamuccnfdt) 
 
               VALUES (g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
                   g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007, 
                   g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus, 
                   g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucowndp,g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp, 
                   g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt,g_qcamuc_m.qcamuccnfid, 
                   g_qcamuc_m.qcamuccnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_qcamuc_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
#                  CALL s_aooi350_get_idno('qcamuc010','qcamuc_t','') RETURNING l_success,l_qcamuc010
#                  UPDATE qcamuc_t SET qcamuc010 = l_qcamuc010
#                  WHERE qcamucent = g_enterprise 
#                  AND qcamuc001 = g_qcamuc_m.qcamuc001
#                  AND qcamuc002 = g_qcamuc_m.qcamuc002
#
#                  AND qcamuc003 = g_qcamuc_m.qcamuc003
#
#                  AND qcamuc004 = g_qcamuc_m.qcamuc004
#
#                  AND qcamuc005 = g_qcamuc_m.qcamuc005
#
#                  AND qcamuc006 = g_qcamuc_m.qcamuc006
#
#                  AND qcamuc008 = g_qcamuc_m.qcamuc008
#
#                  AND qcamuc009 = g_qcamuc_m.qcamuc009
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL cqci010_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL cqci010_b_fill()
                  CALL cqci010_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               IF NOT cqci010_imae111_chk(g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003) THEN
                  NEXT FIELD qcamuc003
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL cqci010_qcamuc_t_mask_restore('restore_mask_o')
               
               UPDATE qcamuc_t SET (qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamucud001,qcamuc005,qcamuc006, 
                   qcamuc007,qcamuc008,qcamuc009,qcamuc010,qcamucstus,qcamucownid,qcamucowndp,qcamuccrtid, 
                   qcamuccrtdp,qcamuccrtdt,qcamucmodid,qcamucmoddt,qcamuccnfid,qcamuccnfdt) = (g_qcamuc_m.qcamuc001, 
                   g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamucud001, 
                   g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
                   g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid, 
                   g_qcamuc_m.qcamucowndp,g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdt, 
                   g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt,g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt) 
 
                WHERE qcamucent = g_enterprise AND qcamuc001 = g_qcamuc001_t
                  AND qcamuc002 = g_qcamuc002_t
                  AND qcamuc003 = g_qcamuc003_t
                  AND qcamuc004 = g_qcamuc004_t
                  AND qcamuc005 = g_qcamuc005_t
                  AND qcamuc006 = g_qcamuc006_t
                  AND qcamuc008 = g_qcamuc008_t
                  AND qcamuc009 = g_qcamuc009_t
                  AND qcamucud001 = g_qcamucud001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "qcamuc_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL cqci010_qcamuc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_qcamuc_m_t)
               LET g_log2 = util.JSON.stringify(g_qcamuc_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_qcamuc001_t = g_qcamuc_m.qcamuc001
            LET g_qcamuc002_t = g_qcamuc_m.qcamuc002
            LET g_qcamuc003_t = g_qcamuc_m.qcamuc003
            LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
            LET g_qcamuc005_t = g_qcamuc_m.qcamuc005
            LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
            LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
            LET g_qcamuc009_t = g_qcamuc_m.qcamuc009
            LET g_qcamucud001_t = g_qcamuc_m.qcamucud001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="cqci010.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_qcanuc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_qcanuc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL cqci010_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_qcanuc_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
 CALL s_transaction_begin()
      
          
           SELECT COUNT(*)  INTO l_sum FROM qcanuc_t 
            WHERE qcanucent = g_enterprise 
               AND qcanuc001 = g_qcamuc_m.qcamuc001
               AND qcanuc002 = g_qcamuc_m.qcamuc002 
               AND qcanuc003 = g_qcamuc_m.qcamuc003 
               AND qcanuc004 = g_qcamuc_m.qcamuc004 
               AND qcanuc005 = g_qcamuc_m.qcamuc005 
               AND qcanuc006 = g_qcamuc_m.qcamuc006 
               AND qcanuc007 = g_qcamuc_m.qcamuc008
               AND qcanucud001 = g_qcamuc_m.qcamucud001
            SELECT COUNT(*) INTO l_sum1 FROM qcan_t 
               WHERE qcanent = g_enterprise 
                  AND qcan001 = g_qcamuc_m.qcamuc001 
                  AND qcan002 = g_qcamuc_m.qcamuc002 
                  AND qcan003 = g_qcamuc_m.qcamuc003 
                  AND qcan004 = g_qcamuc_m.qcamuc004 
                  AND qcan005 = g_qcamuc_m.qcamuc005 
                  AND qcan006 = g_qcamuc_m.qcamuc006 
                  AND qcan007 = g_qcamuc_m.qcamuc008  
                  
         IF l_sum = 0 AND l_sum1 <> 0 THEN 
          IF cl_ask_confirm('acr-00034') THEN  
           INSERT INTO qcanuc_t(qcanucent,
                   qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007,qcanuc008,qcanucud001,
                   qcanuc009
                   ,qcanuc010,qcanuc011,qcanuc012,qcanuc013,qcanuc014,qcanuc015,qcanuc016,qcanuc017,qcanuc018)  
             SELECT qcanent,
                   qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,g_qcamuc_m.qcamucud001,
                   qcan009
                   ,qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016,qcan017,qcan018 FROM qcan_t 
                WHERE qcanent = g_enterprise 
                  AND qcan001 = g_qcamuc_m.qcamuc001 
                  AND qcan002 = g_qcamuc_m.qcamuc002 
                  AND qcan003 = g_qcamuc_m.qcamuc003 
                  AND qcan004 = g_qcamuc_m.qcamuc004 
                  AND qcan005 = g_qcamuc_m.qcamuc005 
                  AND qcan006 = g_qcamuc_m.qcamuc006 
                  AND qcan007 = g_qcamuc_m.qcamuc008
                IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
#                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
#             UPDATE qcanuc_t SET  qcanucud001 = g_qcamuc_m.qcamucud001  
#                WHERE qcanucent = g_enterprise 
#                  AND qcanuc001 = g_qcamuc_m.qcamuc001 
#                  AND qcanuc002 = g_qcamuc_m.qcamuc002 
#                  AND qcanuc003 = g_qcamuc_m.qcamuc003 
#                  AND qcanuc004 = g_qcamuc_m.qcamuc004 
#                  AND qcanuc005 = g_qcamuc_m.qcamuc005 
#                  AND qcanuc006 = g_qcamuc_m.qcamuc006 
#                  AND qcanuc007 = g_qcamuc_m.qcamuc008            
#             IF SQLCA.SQLCODE THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = '' 
#                  LET g_errparam.code = SQLCA.SQLCODE 
#                  LET g_errparam.popup = TRUE 
#                  CALL s_transaction_end('N','0')
#                  CALL cl_err()
##                  CALL s_transaction_end('N','0')
#                  NEXT FIELD CURRENT
#               END IF
           CALL cqci010_b_fill() 
           CALL s_transaction_end('Y','0')               
          END IF  
   END IF  
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
            OPEN cqci010_cl USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamucud001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN cqci010_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE cqci010_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_qcanuc_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_qcanuc_d[l_ac].qcanuc009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_qcanuc_d_t.* = g_qcanuc_d[l_ac].*  #BACKUP
               LET g_qcanuc_d_o.* = g_qcanuc_d[l_ac].*  #BACKUP
               CALL cqci010_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL cqci010_set_no_entry_b(l_cmd)
               IF NOT cqci010_lock_b("qcanuc_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH cqci010_bcl INTO g_qcanuc_d[l_ac].qcanuc009,g_qcanuc_d[l_ac].qcanuc010,g_qcanuc_d[l_ac].qcanuc011, 
                      g_qcanuc_d[l_ac].qcanuc012,g_qcanuc_d[l_ac].qcanuc013,g_qcanuc_d[l_ac].qcanuc014, 
                      g_qcanuc_d[l_ac].qcanuc015,g_qcanuc_d[l_ac].qcanuc016,g_qcanuc_d[l_ac].qcanuc017, 
                      g_qcanuc_d[l_ac].qcanuc018
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_qcanuc_d_t.qcanuc009,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_qcanuc_d_mask_o[l_ac].* =  g_qcanuc_d[l_ac].*
                  CALL cqci010_qcanuc_t_mask()
                  LET g_qcanuc_d_mask_n[l_ac].* =  g_qcanuc_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL cqci010_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL cqci010_qcanuc016_required(g_qcanuc_d[l_ac].qcanuc015)
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
            INITIALIZE g_qcanuc_d[l_ac].* TO NULL 
            INITIALIZE g_qcanuc_d_t.* TO NULL 
            INITIALIZE g_qcanuc_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_qcanuc_d_t.* = g_qcanuc_d[l_ac].*     #新輸入資料
            LET g_qcanuc_d_o.* = g_qcanuc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL cqci010_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL cqci010_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_qcanuc_d[li_reproduce_target].* = g_qcanuc_d[li_reproduce].*
 
               LET g_qcanuc_d[li_reproduce_target].qcanuc009 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(qcanuc009)+1 INTO g_qcanuc_d[l_ac].qcanuc009 FROM qcanuc_t WHERE qcanuc001 = g_qcamuc_m.qcamuc001
               AND qcanuc002 = g_qcamuc_m.qcamuc002 AND qcanuc003 = g_qcamuc_m.qcamuc003 AND qcanuc004 = g_qcamuc_m.qcamuc004
               AND qcanuc005 = g_qcamuc_m.qcamuc005 AND qcanuc006 = g_qcamuc_m.qcamuc006 AND qcanuc007 = g_qcamuc_m.qcamuc008
               AND qcanuc008 = g_qcamuc_m.qcamuc009 AND qcanucent = g_enterprise AND qcanucud001 = g_qcamuc_m.qcamucud001
            IF cl_null(g_qcanuc_d[l_ac].qcanuc009) THEN LET g_qcanuc_d[l_ac].qcanuc009 = 1 END IF

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
            SELECT COUNT(1) INTO l_count FROM qcanuc_t 
             WHERE qcanucent = g_enterprise AND qcanuc001 = g_qcamuc_m.qcamuc001
               AND qcanuc002 = g_qcamuc_m.qcamuc002
               AND qcanuc003 = g_qcamuc_m.qcamuc003
               AND qcanuc004 = g_qcamuc_m.qcamuc004
               AND qcanuc005 = g_qcamuc_m.qcamuc005
               AND qcanuc006 = g_qcamuc_m.qcamuc006
               AND qcanuc007 = g_qcamuc_m.qcamuc008
               AND qcanuc008 = g_qcamuc_m.qcamuc009
               AND qcanucud001 = g_qcamuc_m.qcamucud001
 
               AND qcanuc009 = g_qcanuc_d[l_ac].qcanuc009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_qcamuc_m.qcamuc001
               LET gs_keys[2] = g_qcamuc_m.qcamuc002
               LET gs_keys[3] = g_qcamuc_m.qcamuc003
               LET gs_keys[4] = g_qcamuc_m.qcamuc004
               LET gs_keys[5] = g_qcamuc_m.qcamuc005
               LET gs_keys[6] = g_qcamuc_m.qcamuc006
               LET gs_keys[7] = g_qcamuc_m.qcamuc008
               LET gs_keys[8] = g_qcamuc_m.qcamuc009
               LET gs_keys[9] = g_qcamuc_m.qcamucud001
               LET gs_keys[10] = g_qcanuc_d[g_detail_idx].qcanuc009
               CALL cqci010_insert_b('qcanuc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_qcanuc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "qcanuc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL cqci010_b_fill()
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
               LET gs_keys[01] = g_qcamuc_m.qcamuc001
               LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc002
               LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc003
               LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc004
               LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc005
               LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc006
               LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc008
               LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc009
               LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamucud001
 
               LET gs_keys[gs_keys.getLength()+1] = g_qcanuc_d_t.qcanuc009
 
            
               #刪除同層單身
               IF NOT cqci010_delete_b('qcanuc_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE cqci010_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT cqci010_key_delete_b(gs_keys,'qcanuc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE cqci010_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE cqci010_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_qcanuc_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_qcanuc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc009
            #add-point:BEFORE FIELD qcanuc009 name="input.b.page1.qcanuc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc009
            
            #add-point:AFTER FIELD qcanuc009 name="input.a.page1.qcanuc009"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF NOT cl_ap_chk_range(g_qcanuc_d[l_ac].qcanuc009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD qcanuc009
            END IF 
            
            IF  g_qcamuc_m.qcamuc001 IS NOT NULL AND g_qcamuc_m.qcamuc002 IS NOT NULL AND g_qcamuc_m.qcamuc003 IS NOT NULL AND g_qcamuc_m.qcamuc004 IS NOT NULL AND g_qcamuc_m.qcamuc005 IS NOT NULL AND g_qcamuc_m.qcamuc006 IS NOT NULL AND g_qcamuc_m.qcamuc008 IS NOT NULL AND g_qcamuc_m.qcamuc009 IS NOT NULL AND g_qcanuc_d[g_detail_idx].qcanuc009  IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_qcamuc_m.qcamuc001 != g_qcamuc001_t OR g_qcamuc_m.qcamuc002 != g_qcamuc002_t OR g_qcamuc_m.qcamuc003 != g_qcamuc003_t OR g_qcamuc_m.qcamuc004 != g_qcamuc004_t OR g_qcamuc_m.qcamuc005 != g_qcamuc005_t OR g_qcamuc_m.qcamuc006 != g_qcamuc006_t OR g_qcamuc_m.qcamuc008 != g_qcamuc008_t OR g_qcamuc_m.qcamuc009 != g_qcamuc009_t OR g_qcanuc_d[g_detail_idx].qcanuc009 != g_qcanuc_d_t.qcanuc009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM qcanuc_t WHERE "||"qcanucent = " ||g_enterprise|| " AND "||"qcanuc001 = '"||g_qcamuc_m.qcamuc001 ||"' AND "|| "qcanuc002 = '"||g_qcamuc_m.qcamuc002 ||"' AND "|| "qcanuc003 = '"||g_qcamuc_m.qcamuc003 ||"' AND "|| "qcanuc004 = '"||g_qcamuc_m.qcamuc004 ||"' AND "|| "qcanuc005 = '"||g_qcamuc_m.qcamuc005 ||"' AND "|| "qcanuc006 = '"||g_qcamuc_m.qcamuc006 ||"' AND "|| "qcanuc007 = '"||g_qcamuc_m.qcamuc008 ||"' AND "|| "qcanuc008 = '"||g_qcamuc_m.qcamuc009 ||"' AND "|| "qcanuc009 = '"||g_qcanuc_d[g_detail_idx].qcanuc009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcanuc009
            #add-point:ON CHANGE qcanuc009 name="input.g.page1.qcanuc009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc010
            
            #add-point:AFTER FIELD qcanuc010 name="input.a.page1.qcanuc010"
            LET g_qcanuc_d[l_ac].qcanuc010_desc = ''
            DISPLAY BY NAME g_qcanuc_d[l_ac].qcanuc010_desc 
            
            IF NOT cl_null(g_qcanuc_d[l_ac].qcanuc010) THEN
               LET l_sql = "SELECT COUNT(*) FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '1051' AND oocq002 = ?"
#               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan010,l_sql,'aqc-00019',1) THEN    #160318-00005#42  mark
               IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc010,l_sql,'sub-01303','aqci008') THEN     #160318-00005#42  add
                  LET g_qcanuc_d[l_ac].qcanuc010 = g_qcanuc_d_t.qcanuc010
                  NEXT FIELD CURRENT
               END IF
               LET l_sql = l_sql," AND oocqstus = 'Y'"
#               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan010,l_sql,'aqc-00020',1) THEN     #160318-00005#42  mark
               IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc010,l_sql,'sub-01302','aqci008') THEN     #160318-00005#42  add
                  LET g_qcanuc_d[l_ac].qcanuc010 = g_qcanuc_d_t.qcanuc010
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcanuc_d[l_ac].qcanuc010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='1051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcanuc_d[l_ac].qcanuc010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcanuc_d[l_ac].qcanuc010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc010
            #add-point:BEFORE FIELD qcanuc010 name="input.b.page1.qcanuc010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcanuc010
            #add-point:ON CHANGE qcanuc010 name="input.g.page1.qcanuc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc012
            #add-point:BEFORE FIELD qcanuc012 name="input.b.page1.qcanuc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc012
            
            #add-point:AFTER FIELD qcanuc012 name="input.a.page1.qcanuc012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcanuc012
            #add-point:ON CHANGE qcanuc012 name="input.g.page1.qcanuc012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc013
            #add-point:BEFORE FIELD qcanuc013 name="input.b.page1.qcanuc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc013
            
            #add-point:AFTER FIELD qcanuc013 name="input.a.page1.qcanuc013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcanuc013
            #add-point:ON CHANGE qcanuc013 name="input.g.page1.qcanuc013"
            IF g_qcanuc_d[l_ac].qcanuc013 MATCHES '[1256]' THEN
               IF NOT cqci010_qcanuc014_chk() THEN
                  NEXT FIELD qcan014
               END IF
            END IF
            CALL cqci010_set_entry_b(l_cmd)
            CALL cqci010_set_no_entry_b(l_cmd)
            IF g_qcanuc_d[l_ac].qcanuc013 = '4' THEN
               LET g_qcanuc_d[l_ac].qcanuc015 = '3' 
               IF cl_null(g_qcanuc2_d[l_ac2].qcanuc019) THEN
                  NEXT FIELD qcanuc019
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc014
            #add-point:BEFORE FIELD qcanuc014 name="input.b.page1.qcanuc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc014
            
            #add-point:AFTER FIELD qcanuc014 name="input.a.page1.qcanuc014"


            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcan014
            #add-point:BEFORE FIELD qcan014 name="input.b.page1.qcan014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcan014
            
            #add-point:AFTER FIELD qcan014 name="input.a.page1.qcan014"
            IF NOT cqci010_qcanuc014_chk() THEN
               LET g_qcanuc_d[l_ac].qcanuc014 = g_qcanuc_d_t.qcanuc014
               NEXT FIELD CURRENT
            END IF
            #END add-point
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcanuc014
            #add-point:ON CHANGE qcanuc014 name="input.g.page1.qcanuc014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc015
            #add-point:BEFORE FIELD qcanuc015 name="input.b.page1.qcanuc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc015
            
            #add-point:AFTER FIELD qcanuc015 name="input.a.page1.qcanuc015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcanuc015
            #add-point:ON CHANGE qcanuc015 name="input.g.page1.qcanuc015"
         CALL cqci010_qcanuc016_required(g_qcanuc_d[l_ac].qcanuc015)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc016
            
            #add-point:AFTER FIELD qcanuc016 name="input.a.page1.qcanuc016"
           LET g_qcanuc_d[l_ac].qcanuc016_desc = ''
            DISPLAY BY NAME g_qcanuc_d[l_ac].qcanuc016_desc
            IF NOT cl_null(g_qcanuc_d[l_ac].qcanuc016) THEN
               LET l_sql = "SELECT COUNT(*) FROM oocq_t WHERE oocqent = ",g_enterprise," AND oocq001 = '1052' AND oocq002 = ?"
#               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan016,l_sql,'aqc-00025',1) THEN     #160318-00005#42  mark
               IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc016,l_sql,'sub-01303','aqci009') THEN
                  LET g_qcanuc_d[l_ac].qcanuc016 = g_qcanuc_d_t.qcanuc016
                  NEXT FIELD CURRENT
               END IF
               LET l_sql = l_sql," AND oocqstus = 'Y'"
#               IF NOT ap_chk_isExist(g_qcan_d[l_ac].qcan016,l_sql,'aqc-00026',1) THEN     #160318-00005#42  mark
               IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc016,l_sql,'sub-01302','aqci009') THEN     #160318-00005#42  add
                  LET g_qcanuc_d[l_ac].qcanuc016 = g_qcanuc_d_t.qcanuc016
                  NEXT FIELD CURRENT
               END IF
            END IF

           INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcanuc_d[l_ac].qcanuc016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent="||g_enterprise||" AND oocql001='1052' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcanuc_d[l_ac].qcanuc016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcanuc_d[l_ac].qcanuc016_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc016
            #add-point:BEFORE FIELD qcanuc016 name="input.b.page1.qcanuc016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcanuc016
            #add-point:ON CHANGE qcanuc016 name="input.g.page1.qcanuc016"
        
        AFTER FIELD qcan017
            
            #add-point:AFTER FIELD qcan017 name="input.a.page1.qcan017"
            #160519-00045#1--s
            IF (NOT cl_null(g_qcanuc_d[l_ac].qcanuc017)) AND (NOT cl_null(g_qcanuc_d[l_ac].qcanuc018)) THEN 
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_qcanuc_d[l_ac].qcanuc018

               LET g_chkparam.where = " mrba000 = '",g_qcanuc_d[l_ac].qcanuc017,"' "
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mrba001_5") THEN
                  LET g_qcanuc_d[l_ac].qcanuc018 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #160519-00045#1--e
            #END add-point
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcanuc018
            
            #add-point:AFTER FIELD qcanuc018 name="input.a.page1.qcanuc018"
            IF NOT cl_null(g_qcanuc_d[l_ac].qcanuc018) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_qcanuc_d[l_ac].qcanuc018
               
               IF NOT cl_null(g_qcanuc_d[l_ac].qcanuc017) THEN 
                  LET g_chkparam.where = " mrba000 = '",g_qcanuc_d[l_ac].qcanuc017,"' "
               END IF
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mrba001_5") THEN
                  LET g_qcanuc_d[l_ac].qcanuc018 = g_qcanuc_d_t.qcanuc018
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcanuc018
            #add-point:BEFORE FIELD qcanuc018 name="input.b.page1.qcanuc018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcanuc018
            #add-point:ON CHANGE qcanuc018 name="input.g.page1.qcanuc018"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.qcanuc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc009
            #add-point:ON ACTION controlp INFIELD qcanuc009 name="input.c.page1.qcanuc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcanuc010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc010
            #add-point:ON ACTION controlp INFIELD qcanuc010 name="input.c.page1.qcanuc010"
		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcanuc_d[l_ac].qcanuc010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1051" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_qcanuc_d[l_ac].qcanuc010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcanuc_d[l_ac].qcanuc010 TO qcanuc010              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcanuc_d[l_ac].qcanuc010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcanuc_d[l_ac].qcanuc010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcanuc_d[l_ac].qcanuc010_desc
            NEXT FIELD qcanuc010                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcanuc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc012
            #add-point:ON ACTION controlp INFIELD qcanuc012 name="input.c.page1.qcanuc012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcanuc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc013
            #add-point:ON ACTION controlp INFIELD qcanuc013 name="input.c.page1.qcanuc013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcanuc014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc014
            #add-point:ON ACTION controlp INFIELD qcanuc014 name="input.c.page1.qcanuc014"
          INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_qcanuc_d[l_ac].qcanuc014             #給予default值
            CASE WHEN g_qcanuc_d[l_ac].qcanuc013 = '1' 
                    CALL q_qcac002()
                 WHEN g_qcanuc_d[l_ac].qcanuc013 = '2'
                    CALL q_qcag003()
                 WHEN g_qcanuc_d[l_ac].qcanuc013 = '6'
                    LET g_qryparam.where = " qcah001 = '",g_qcamuc_m.qcamuc001,"'"
                    CALL q_qcah002()
            END CASE
      

            LET g_qcanuc_d[l_ac].qcanuc014  = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_qcanuc_d[l_ac].qcanuc014  TO qcanuc014              #顯示到畫面上

            NEXT FIELD qcanuc014                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcanuc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc015
            #add-point:ON ACTION controlp INFIELD qcanuc015 name="input.c.page1.qcanuc015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.qcanuc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc016
            #add-point:ON ACTION controlp INFIELD qcanuc016 name="input.c.page1.qcanuc016"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_qcanuc_d[l_ac].qcanuc016             #給予default值
#            LET g_qryparam.default2 = "" #g_qcanuc_d[l_ac].oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "1052" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_qcanuc_d[l_ac].qcanuc016 = g_qryparam.return1              
            #LET g_qcanuc_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY g_qcanuc_d[l_ac].qcanuc016 TO qcanuc016              #
            #DISPLAY g_qcanuc_d[l_ac].oocql004 TO oocql004 #說明
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcanuc_d[l_ac].qcanuc016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1052' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcanuc_d[l_ac].qcanuc016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcanuc_d[l_ac].qcanuc016_desc
            
            NEXT FIELD qcanuc016                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.qcanuc018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcanuc018
            #add-point:ON ACTION controlp INFIELD qcanuc018 name="input.c.page1.qcanuc018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_qcanuc_d[l_ac].qcanuc018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " mrba100 = '1' "
            
            IF NOT cl_null(g_qcanuc_d[l_ac].qcanuc017) THEN 
               LET g_qryparam.where = g_qryparam.where , " AND mrba000 = '",g_qcanuc_d[l_ac].qcanuc017,"' "
            END IF
            
            CALL q_mrba001()                                #呼叫開窗
 
            LET g_qcanuc_d[l_ac].qcanuc018 = g_qryparam.return1              

            DISPLAY g_qcanuc_d[l_ac].qcanuc018 TO qcanuc018              #

            NEXT FIELD qcanuc018                          #返回原欄位



            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_qcanuc_d[l_ac].* = g_qcanuc_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE cqci010_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_qcanuc_d[l_ac].qcanuc009 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_qcanuc_d[l_ac].* = g_qcanuc_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL cqci010_qcanuc_t_mask_restore('restore_mask_o')
      
               UPDATE qcanuc_t SET (qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007, 
                   qcanuc008,qcanucud001,qcanuc009,qcanuc010,qcanuc011,qcanuc012,qcanuc013,qcanuc014, 
                   qcanuc015,qcanuc016,qcanuc017,qcanuc018) = (g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002, 
                   g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006, 
                   g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamucud001,g_qcanuc_d[l_ac].qcanuc009, 
                   g_qcanuc_d[l_ac].qcanuc010,g_qcanuc_d[l_ac].qcanuc011,g_qcanuc_d[l_ac].qcanuc012, 
                   g_qcanuc_d[l_ac].qcanuc013,g_qcanuc_d[l_ac].qcanuc014,g_qcanuc_d[l_ac].qcanuc015, 
                   g_qcanuc_d[l_ac].qcanuc016,g_qcanuc_d[l_ac].qcanuc017,g_qcanuc_d[l_ac].qcanuc018) 
 
                WHERE qcanucent = g_enterprise AND qcanuc001 = g_qcamuc_m.qcamuc001 
                  AND qcanuc002 = g_qcamuc_m.qcamuc002 
                  AND qcanuc003 = g_qcamuc_m.qcamuc003 
                  AND qcanuc004 = g_qcamuc_m.qcamuc004 
                  AND qcanuc005 = g_qcamuc_m.qcamuc005 
                  AND qcanuc006 = g_qcamuc_m.qcamuc006 
                  AND qcanuc007 = g_qcamuc_m.qcamuc008 
                  AND qcanuc008 = g_qcamuc_m.qcamuc009 
                  AND qcanucud001 = g_qcamuc_m.qcamucud001 
 
                  AND qcanuc009 = g_qcanuc_d_t.qcanuc009 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_qcanuc_d[l_ac].* = g_qcanuc_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "qcanuc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_qcanuc_d[l_ac].* = g_qcanuc_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "qcanuc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_qcamuc_m.qcamuc001
               LET gs_keys_bak[1] = g_qcamuc001_t
               LET gs_keys[2] = g_qcamuc_m.qcamuc002
               LET gs_keys_bak[2] = g_qcamuc002_t
               LET gs_keys[3] = g_qcamuc_m.qcamuc003
               LET gs_keys_bak[3] = g_qcamuc003_t
               LET gs_keys[4] = g_qcamuc_m.qcamuc004
               LET gs_keys_bak[4] = g_qcamuc004_t
               LET gs_keys[5] = g_qcamuc_m.qcamuc005
               LET gs_keys_bak[5] = g_qcamuc005_t
               LET gs_keys[6] = g_qcamuc_m.qcamuc006
               LET gs_keys_bak[6] = g_qcamuc006_t
               LET gs_keys[7] = g_qcamuc_m.qcamuc008
               LET gs_keys_bak[7] = g_qcamuc008_t
               LET gs_keys[8] = g_qcamuc_m.qcamuc009
               LET gs_keys_bak[8] = g_qcamuc009_t
               LET gs_keys[9] = g_qcamuc_m.qcamucud001
               LET gs_keys_bak[9] = g_qcamucud001_t
               LET gs_keys[10] = g_qcanuc_d[g_detail_idx].qcanuc009
               LET gs_keys_bak[10] = g_qcanuc_d_t.qcanuc009
               CALL cqci010_update_b('qcanuc_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL cqci010_qcanuc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_qcanuc_d[g_detail_idx].qcanuc009 = g_qcanuc_d_t.qcanuc009 
 
                  ) THEN
                  LET gs_keys[01] = g_qcamuc_m.qcamuc001
                  LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc002
                  LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc003
                  LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc004
                  LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc005
                  LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc006
                  LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc008
                  LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamuc009
                  LET gs_keys[gs_keys.getLength()+1] = g_qcamuc_m.qcamucud001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_qcanuc_d_t.qcanuc009
 
                  CALL cqci010_key_update_b(gs_keys,'qcanuc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_qcamuc_m),util.JSON.stringify(g_qcanuc_d_t)
               LET g_log2 = util.JSON.stringify(g_qcamuc_m),util.JSON.stringify(g_qcanuc_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL cqci010_unlock_b("qcanuc_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL cqci010_b_fill2('0')
            DISPLAY ARRAY g_qcanuc2_d TO s_detail2.*
               BEFORE DISPLAY
                  EXIT DISPLAY
            END DISPLAY
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_qcanuc_d[li_reproduce_target].* = g_qcanuc_d[li_reproduce].*
 
               LET g_qcanuc_d[li_reproduce_target].qcanuc009 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_qcanuc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_qcanuc_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="cqci010.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_qcanuc2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
          BEFORE INPUT
           LET l_ac2 = l_ac
           CALL FGL_SET_ARR_CURR(l_ac2) 
          

            CALL cqci010_b_fill2('0')
            LET g_rec_b = g_qcanuc2_d.getLength()
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET g_detail_idx2 = l_ac2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN cqci010_cl USING g_enterprise,g_qcamuc_m.qcamuc001
                                                                ,g_qcamuc_m.qcamuc002

                                                                ,g_qcamuc_m.qcamuc003

                                                                ,g_qcamuc_m.qcamuc004

                                                                ,g_qcamuc_m.qcamuc005

                                                                ,g_qcamuc_m.qcamuc006

                                                                ,g_qcamuc_m.qcamuc008

                                                                ,g_qcamuc_m.qcamuc009
                                                                ,g_qcamuc_m.qcamucud001 


            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN cqci010_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE cqci010_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
                   
            
            LET g_rec_b = g_qcanuc2_d.getLength()
            
            IF g_rec_b >= l_ac2 
               AND NOT cl_null(g_qcanuc2_d[l_ac].qcanuc009_1) 

            THEN
               LET l_cmd='u'
               LET g_qcanuc2_d_t.* = g_qcanuc2_d[l_ac2].*  #BACKUP
               CALL cqci010_set_entry_b2(l_cmd)
               CALL cqci010_set_no_entry_b2(l_cmd)
               IF NOT cqci010_lock_b2("qcanuc_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH cqci010_bcl2 INTO g_qcanuc2_d[l_ac2].qcanuc009_1,g_qcanuc2_d[l_ac2].qcanuc010_1,g_qcanuc2_d[l_ac2].qcanuc010_1_desc,g_qcanuc2_d[l_ac2].qcanuc011_1,g_qcanuc2_d[l_ac2].qcanuc013_1,
                              g_qcanuc2_d[l_ac2].qcanuc019,g_qcanuc2_d[l_ac2].qcanuc020,g_qcanuc2_d[l_ac2].qcanuc021,g_qcanuc2_d[l_ac2].qcanuc022,g_qcanuc2_d[l_ac2].qcanuc023,
                              g_qcanuc2_d[l_ac2].qcanuc024,g_qcanuc2_d[l_ac2].qcanuc025,g_qcanuc2_d[l_ac2].qcanuc026    
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_qcanuc2_d_t.qcanuc009_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL cqci010_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            IF g_qcanuc2_d[l_ac2].qcanuc013_1 = '4' THEN
               CALL cl_set_comp_required("qcanuc019",TRUE)
            ELSE
               CALL cl_set_comp_required("qcanuc019",FALSE)
            END IF
         AFTER ROW
            #add-point:單身after_row
            IF g_qcanuc_d[l_ac].qcanuc013 = '4' THEN
               IF cl_null(g_qcanuc2_d[l_ac].qcanuc019) AND cl_null(g_qcanuc2_d[l_ac].qcanuc023) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "qcanuc_t" 
                  LET g_errparam.code   = "aqc-00106"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               IF cl_null(g_qcanuc2_d[l_ac].qcanuc020) AND cl_null(g_qcanuc2_d[l_ac].qcanuc022) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "qcanuc_t" 
                  LET g_errparam.code   = "aqc-00107"
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #end add-point
            CALL cqci010_unlock_b2("qcanuc_t","'2'")
            CALL s_transaction_end('Y','0')
         AFTER FIELD qcanuc019
            IF NOT cqci010_qcanuc019_qcanuc023_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00027'
               LET g_errparam.extend = g_qcanuc2_d[l_ac2].qcanuc019
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcanuc2_d[l_ac2].qcanuc019 = g_qcanuc2_d_t.qcanuc019
               NEXT FIELD CURRENT
            END IF
         AFTER FIELD qcanuc020
            IF NOT cqci010_qcanuc020_qcanuc022_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00028'
               LET g_errparam.extend = g_qcanuc2_d[l_ac2].qcanuc020
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcanuc2_d[l_ac2].qcanuc020 = g_qcanuc2_d_t.qcanuc020
               NEXT FIELD CURRENT
            END IF
         
         AFTER FIELD qcanuc022
            IF NOT cqci010_qcanuc020_qcanuc022_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00028'
               LET g_errparam.extend = g_qcanuc2_d[l_ac2].qcanuc022
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcanuc2_d[l_ac2].qcanuc022 = g_qcanuc2_d_t.qcanuc022
               NEXT FIELD CURRENT
            END IF
         AFTER FIELD qcanuc023
            IF NOT cqci010_qcanuc019_qcanuc023_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aqc-00027'
               LET g_errparam.extend = g_qcanuc2_d[l_ac2].qcanuc023
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcanuc2_d[l_ac2].qcanuc023 = g_qcanuc2_d_t.qcanuc023
               NEXT FIELD CURRENT
            END IF
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_qcanuc2_d[l_ac2].* = g_qcanuc2_d_t.*
               CLOSE cqci010_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_qcanuc2_d[l_ac2].qcanuc009_1
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_qcanuc2_d[l_ac2].* = g_qcanuc2_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE qcanuc_t SET (qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007,qcanuc008,qcanuc009,qcanuc019,qcanuc020,qcanuc021,qcanuc022,qcanuc023,qcanuc024,qcanuc025,qcanuc026) = 
                                 (g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcanuc2_d[l_ac2].qcanuc009_1,g_qcanuc2_d[l_ac2].qcanuc019,g_qcanuc2_d[l_ac2].qcanuc020,g_qcanuc2_d[l_ac2].qcanuc021,g_qcanuc2_d[l_ac2].qcanuc022,g_qcanuc2_d[l_ac2].qcanuc023,g_qcanuc2_d[l_ac2].qcanuc024,g_qcanuc2_d[l_ac2].qcanuc025,g_qcanuc2_d[l_ac2].qcanuc026)
                WHERE qcanucent = g_enterprise AND qcanuc001 = g_qcamuc_m.qcamuc001 
                  AND qcanuc002 = g_qcamuc_m.qcamuc002 

                  AND qcanuc003 = g_qcamuc_m.qcamuc003 

                  AND qcanuc004 = g_qcamuc_m.qcamuc004 

                  AND qcanuc005 = g_qcamuc_m.qcamuc005 

                  AND qcanuc006 = g_qcamuc_m.qcamuc006 

                  AND qcanuc007 = g_qcamuc_m.qcamuc008 

                  AND qcanuc008 = g_qcamuc_m.qcamuc009 


                  AND qcanuc009 = g_qcanuc2_d_t.qcanuc009_1 #項次   

                  AND qcanucud001 = g_qcamuc_m.qcamucud001
               #add-point:單身修改中

               #end add-point
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "qcanuc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_qcanuc2_d[l_ac].* = g_qcanuc2_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_qcamuc_m.qcamuc001
               LET gs_keys_bak[1] = g_qcamuc001_t
               LET gs_keys[2] = g_qcamuc_m.qcamuc002
               LET gs_keys_bak[2] = g_qcamuc002_t
               LET gs_keys[3] = g_qcamuc_m.qcamuc003
               LET gs_keys_bak[3] = g_qcamuc003_t
               LET gs_keys[4] = g_qcamuc_m.qcamuc004
               LET gs_keys_bak[4] = g_qcamuc004_t
               LET gs_keys[5] = g_qcamuc_m.qcamuc005
               LET gs_keys_bak[5] = g_qcamuc005_t
               LET gs_keys[6] = g_qcamuc_m.qcamuc006
               LET gs_keys_bak[6] = g_qcamuc006_t
               LET gs_keys[7] = g_qcamuc_m.qcamuc008
               LET gs_keys_bak[7] = g_qcamuc008_t
               LET gs_keys[8] = g_qcamuc_m.qcamuc009
               LET gs_keys_bak[8] = g_qcamuc009_t
               LET gs_keys[9] = g_qcanuc2_d[g_detail_idx].qcanuc009_1
               LET gs_keys_bak[9] = g_qcanuc2_d_t.qcanuc009_1
               CALL cqci010_update_b2('qcanuc_t',gs_keys,gs_keys_bak,"'2'")
                  #資料多語言用-增/改
                  
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF   
      
      END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #add by lixh 20150703 150702-00006#10
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field

            #end add-point  
            NEXT FIELD qcamuc002
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD qcanuc009
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF
         #add by lixh 20150703 150702-00006#10
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD qcamuc001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD qcanuc009
 
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
 
{<section id="cqci010.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION cqci010_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL cqci010_b_fill() #單身填充
      CALL cqci010_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL cqci010_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamuc001
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='5' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamuc001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamuc001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamuc002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='205' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamuc002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamuc002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamuc003
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamuc003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamuc003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamuc005
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamuc005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamuc005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamuc008
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamuc008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamuc008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamucownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamucownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamucownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamucowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamucowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamucowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamuccrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamuccrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamuccrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamuccrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamuccrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamuccrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcamuc_m.qcamucmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_qcamuc_m.qcamucmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcamuc_m.qcamucmodid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_qcamuc_m_mask_o.* =  g_qcamuc_m.*
   CALL cqci010_qcamuc_t_mask()
   LET g_qcamuc_m_mask_n.* =  g_qcamuc_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005, 
       g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc008_desc, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp,g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtid_desc, 
       g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid, 
       g_qcamuc_m.qcamucmodid_desc,g_qcamuc_m.qcamucmoddt,g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_qcamuc_m.qcamucstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_qcanuc_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcanuc_d[l_ac].qcanuc010
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcanuc_d[l_ac].qcanuc010_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcanuc_d[l_ac].qcanuc010_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_qcanuc_d[l_ac].qcanuc016
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1052' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_qcanuc_d[l_ac].qcanuc016_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_qcanuc_d[l_ac].qcanuc016_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_qcanuc2_d[l_ac].qcanuc010_1
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1051' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_qcanuc2_d[l_ac].qcanuc010_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_qcanuc2_d[l_ac].qcanuc010_1_desc

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL cqci010_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION cqci010_detail_show()
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
 
{<section id="cqci010.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION cqci010_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE qcamuc_t.qcamuc001 
   DEFINE l_oldno     LIKE qcamuc_t.qcamuc001 
   DEFINE l_newno02     LIKE qcamuc_t.qcamuc002 
   DEFINE l_oldno02     LIKE qcamuc_t.qcamuc002 
   DEFINE l_newno03     LIKE qcamuc_t.qcamuc003 
   DEFINE l_oldno03     LIKE qcamuc_t.qcamuc003 
   DEFINE l_newno04     LIKE qcamuc_t.qcamuc004 
   DEFINE l_oldno04     LIKE qcamuc_t.qcamuc004 
   DEFINE l_newno05     LIKE qcamuc_t.qcamuc005 
   DEFINE l_oldno05     LIKE qcamuc_t.qcamuc005 
   DEFINE l_newno06     LIKE qcamuc_t.qcamuc006 
   DEFINE l_oldno06     LIKE qcamuc_t.qcamuc006 
   DEFINE l_newno07     LIKE qcamuc_t.qcamuc008 
   DEFINE l_oldno07     LIKE qcamuc_t.qcamuc008 
   DEFINE l_newno08     LIKE qcamuc_t.qcamuc009 
   DEFINE l_oldno08     LIKE qcamuc_t.qcamuc009 
   DEFINE l_newno09     LIKE qcamuc_t.qcamucud001 
   DEFINE l_oldno09     LIKE qcamuc_t.qcamucud001 
 
   DEFINE l_master    RECORD LIKE qcamuc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE qcanuc_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_qcamuc_m.qcamuc001 IS NULL
   OR g_qcamuc_m.qcamuc002 IS NULL
   OR g_qcamuc_m.qcamuc003 IS NULL
   OR g_qcamuc_m.qcamuc004 IS NULL
   OR g_qcamuc_m.qcamuc005 IS NULL
   OR g_qcamuc_m.qcamuc006 IS NULL
   OR g_qcamuc_m.qcamuc008 IS NULL
   OR g_qcamuc_m.qcamuc009 IS NULL
   OR g_qcamuc_m.qcamucud001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_qcamuc001_t = g_qcamuc_m.qcamuc001
   LET g_qcamuc002_t = g_qcamuc_m.qcamuc002
   LET g_qcamuc003_t = g_qcamuc_m.qcamuc003
   LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
   LET g_qcamuc005_t = g_qcamuc_m.qcamuc005
   LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
   LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
   LET g_qcamuc009_t = g_qcamuc_m.qcamuc009
   LET g_qcamucud001_t = g_qcamuc_m.qcamucud001
 
    
   LET g_qcamuc_m.qcamuc001 = ""
   LET g_qcamuc_m.qcamuc002 = ""
   LET g_qcamuc_m.qcamuc003 = ""
   LET g_qcamuc_m.qcamuc004 = ""
   LET g_qcamuc_m.qcamuc005 = ""
   LET g_qcamuc_m.qcamuc006 = ""
   LET g_qcamuc_m.qcamuc008 = ""
   LET g_qcamuc_m.qcamuc009 = ""
   LET g_qcamuc_m.qcamucud001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_qcamuc_m.qcamucownid = g_user
      LET g_qcamuc_m.qcamucowndp = g_dept
      LET g_qcamuc_m.qcamuccrtid = g_user
      LET g_qcamuc_m.qcamuccrtdp = g_dept 
      LET g_qcamuc_m.qcamuccrtdt = cl_get_current()
      LET g_qcamuc_m.qcamucmodid = g_user
      LET g_qcamuc_m.qcamucmoddt = cl_get_current()
      LET g_qcamuc_m.qcamucstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_qcamuc_m.qcamucstus = "Y"
   LET g_qcamuc_m.qcamuc004 = 'ALL'
   LET g_qcamuc_m.qcamuc008 = 'ALL'
   LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
   LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
   LET g_qcamuc_m.qcamuc006 = 0
   LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
   LET g_qcamuc_m.qcamuc001 = g_qcamuc001   #add by xujing 20151022
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_qcamuc_m.qcamucstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_qcamuc_m.qcamuc001_desc = ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc001_desc
   LET g_qcamuc_m.qcamuc002_desc = ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc002_desc
   LET g_qcamuc_m.qcamuc003_desc = ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc003_desc
   LET g_qcamuc_m.qcamuc005_desc = ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc005_desc
   LET g_qcamuc_m.qcamuc008_desc = ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc008_desc
 
   
   CALL cqci010_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_qcamuc_m.* TO NULL
      INITIALIZE g_qcanuc_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL cqci010_show()
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
   CALL cqci010_set_act_visible()   
   CALL cqci010_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_qcamuc001_t = g_qcamuc_m.qcamuc001
   LET g_qcamuc002_t = g_qcamuc_m.qcamuc002
   LET g_qcamuc003_t = g_qcamuc_m.qcamuc003
   LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
   LET g_qcamuc005_t = g_qcamuc_m.qcamuc005
   LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
   LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
   LET g_qcamuc009_t = g_qcamuc_m.qcamuc009
   LET g_qcamucud001_t = g_qcamuc_m.qcamucud001
 
   
   #組合新增資料的條件
   LET g_add_browse = " qcamucent = " ||g_enterprise|| " AND",
                      " qcamuc001 = '", g_qcamuc_m.qcamuc001, "' "
                      ," AND qcamuc002 = '", g_qcamuc_m.qcamuc002, "' "
                      ," AND qcamuc003 = '", g_qcamuc_m.qcamuc003, "' "
                      ," AND qcamuc004 = '", g_qcamuc_m.qcamuc004, "' "
                      ," AND qcamuc005 = '", g_qcamuc_m.qcamuc005, "' "
                      ," AND qcamuc006 = '", g_qcamuc_m.qcamuc006, "' "
                      ," AND qcamuc008 = '", g_qcamuc_m.qcamuc008, "' "
                      ," AND qcamuc009 = '", g_qcamuc_m.qcamuc009, "' "
                      ," AND qcamucud001 = '", g_qcamuc_m.qcamucud001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL cqci010_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL cqci010_idx_chk()
   
   LET g_data_owner = g_qcamuc_m.qcamucownid      
   LET g_data_dept  = g_qcamuc_m.qcamucowndp
   
   #功能已完成,通報訊息中心
   CALL cqci010_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION cqci010_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE qcanuc_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE cqci010_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM qcanuc_t
    WHERE qcanucent = g_enterprise AND qcanuc001 = g_qcamuc001_t
     AND qcanuc002 = g_qcamuc002_t
     AND qcanuc003 = g_qcamuc003_t
     AND qcanuc004 = g_qcamuc004_t
     AND qcanuc005 = g_qcamuc005_t
     AND qcanuc006 = g_qcamuc006_t
     AND qcanuc007 = g_qcamuc008_t
     AND qcanuc008 = g_qcamuc009_t
     AND qcanucud001 = g_qcamucud001_t
 
    INTO TEMP cqci010_detail
 
   #將key修正為調整後   
   UPDATE cqci010_detail 
      #更新key欄位
      SET qcanuc001 = g_qcamuc_m.qcamuc001
          , qcanuc002 = g_qcamuc_m.qcamuc002
          , qcanuc003 = g_qcamuc_m.qcamuc003
          , qcanuc004 = g_qcamuc_m.qcamuc004
          , qcanuc005 = g_qcamuc_m.qcamuc005
          , qcanuc006 = g_qcamuc_m.qcamuc006
          , qcanuc007 = g_qcamuc_m.qcamuc008
          , qcanuc008 = g_qcamuc_m.qcamuc009
          , qcanucud001 = g_qcamuc_m.qcamucud001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO qcanuc_t SELECT * FROM cqci010_detail
   
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
   DROP TABLE cqci010_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_qcamuc001_t = g_qcamuc_m.qcamuc001
   LET g_qcamuc002_t = g_qcamuc_m.qcamuc002
   LET g_qcamuc003_t = g_qcamuc_m.qcamuc003
   LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
   LET g_qcamuc005_t = g_qcamuc_m.qcamuc005
   LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
   LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
   LET g_qcamuc009_t = g_qcamuc_m.qcamuc009
   LET g_qcamucud001_t = g_qcamuc_m.qcamucud001
 
   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.delete" >}
#+ 資料刪除
PRIVATE FUNCTION cqci010_delete()
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
   
   IF g_qcamuc_m.qcamuc001 IS NULL
   OR g_qcamuc_m.qcamuc002 IS NULL
   OR g_qcamuc_m.qcamuc003 IS NULL
   OR g_qcamuc_m.qcamuc004 IS NULL
   OR g_qcamuc_m.qcamuc005 IS NULL
   OR g_qcamuc_m.qcamuc006 IS NULL
   OR g_qcamuc_m.qcamuc008 IS NULL
   OR g_qcamuc_m.qcamuc009 IS NULL
   OR g_qcamuc_m.qcamucud001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN cqci010_cl USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamucud001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN cqci010_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE cqci010_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE cqci010_master_referesh USING g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
       g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
       g_qcamuc_m.qcamucud001 INTO g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
       g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucowndp, 
       g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt, 
       g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc008_desc,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid_desc,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamucmodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT cqci010_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_qcamuc_m_mask_o.* =  g_qcamuc_m.*
   CALL cqci010_qcamuc_t_mask()
   LET g_qcamuc_m_mask_n.* =  g_qcamuc_m.*
   
   CALL cqci010_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL cqci010_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_qcamuc001_t = g_qcamuc_m.qcamuc001
      LET g_qcamuc002_t = g_qcamuc_m.qcamuc002
      LET g_qcamuc003_t = g_qcamuc_m.qcamuc003
      LET g_qcamuc004_t = g_qcamuc_m.qcamuc004
      LET g_qcamuc005_t = g_qcamuc_m.qcamuc005
      LET g_qcamuc006_t = g_qcamuc_m.qcamuc006
      LET g_qcamuc008_t = g_qcamuc_m.qcamuc008
      LET g_qcamuc009_t = g_qcamuc_m.qcamuc009
      LET g_qcamucud001_t = g_qcamuc_m.qcamucud001
 
 
      DELETE FROM qcamuc_t
       WHERE qcamucent = g_enterprise AND qcamuc001 = g_qcamuc_m.qcamuc001
         AND qcamuc002 = g_qcamuc_m.qcamuc002
         AND qcamuc003 = g_qcamuc_m.qcamuc003
         AND qcamuc004 = g_qcamuc_m.qcamuc004
         AND qcamuc005 = g_qcamuc_m.qcamuc005
         AND qcamuc006 = g_qcamuc_m.qcamuc006
         AND qcamuc008 = g_qcamuc_m.qcamuc008
         AND qcamuc009 = g_qcamuc_m.qcamuc009
         AND qcamucud001 = g_qcamuc_m.qcamucud001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_qcamuc_m.qcamuc001,":",SQLERRMESSAGE  
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
      
      DELETE FROM qcanuc_t
       WHERE qcanucent = g_enterprise AND qcanuc001 = g_qcamuc_m.qcamuc001
         AND qcanuc002 = g_qcamuc_m.qcamuc002
         AND qcanuc003 = g_qcamuc_m.qcamuc003
         AND qcanuc004 = g_qcamuc_m.qcamuc004
         AND qcanuc005 = g_qcamuc_m.qcamuc005
         AND qcanuc006 = g_qcamuc_m.qcamuc006
         AND qcanuc007 = g_qcamuc_m.qcamuc008
         AND qcanuc008 = g_qcamuc_m.qcamuc009
         AND qcanucud001 = g_qcamuc_m.qcamucud001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "qcanuc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_qcamuc_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE cqci010_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_qcanuc_d.clear() 
 
     
      CALL cqci010_ui_browser_refresh()  
      #CALL cqci010_ui_headershow()  
      #CALL cqci010_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL cqci010_browser_fill("")
         CALL cqci010_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE cqci010_cl
 
   #功能已完成,通報訊息中心
   CALL cqci010_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="cqci010.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION cqci010_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_qcanuc_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF cqci010_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT qcanuc009,qcanuc010,qcanuc011,qcanuc012,qcanuc013,qcanuc014,qcanuc015, 
             qcanuc016,qcanuc017,qcanuc018 ,t1.oocql004 ,t2.oocql004 FROM qcanuc_t",   
                     " INNER JOIN qcamuc_t ON qcamucent = " ||g_enterprise|| " AND qcamuc001 = qcanuc001 ",
                     " AND qcamuc002 = qcanuc002 ",
                     " AND qcamuc003 = qcanuc003 ",
                     " AND qcamuc004 = qcanuc004 ",
                     " AND qcamuc005 = qcanuc005 ",
                     " AND qcamuc006 = qcanuc006 ",
                     " AND qcamuc008 = qcanuc007 ",
                     " AND qcamuc009 = qcanuc008 ",
                     " AND qcamucud001 = qcanucud001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1051' AND t1.oocql002=qcanuc010 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='1052' AND t2.oocql002=qcanuc016 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE qcanucent=? AND qcanuc001=? AND qcanuc002=? AND qcanuc003=? AND qcanuc004=? AND qcanuc005=? AND qcanuc006=? AND qcanuc007=? AND qcanuc008=? AND qcanucud001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
 
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY qcanuc_t.qcanuc009"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE cqci010_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR cqci010_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamucud001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
          g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
          g_qcamuc_m.qcamucud001 INTO g_qcanuc_d[l_ac].qcanuc009,g_qcanuc_d[l_ac].qcanuc010,g_qcanuc_d[l_ac].qcanuc011, 
          g_qcanuc_d[l_ac].qcanuc012,g_qcanuc_d[l_ac].qcanuc013,g_qcanuc_d[l_ac].qcanuc014,g_qcanuc_d[l_ac].qcanuc015, 
          g_qcanuc_d[l_ac].qcanuc016,g_qcanuc_d[l_ac].qcanuc017,g_qcanuc_d[l_ac].qcanuc018,g_qcanuc_d[l_ac].qcanuc010_desc, 
          g_qcanuc_d[l_ac].qcanuc016_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
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
   
   CALL g_qcanuc_d.deleteElement(g_qcanuc_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE cqci010_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_qcanuc_d.getLength()
      LET g_qcanuc_d_mask_o[l_ac].* =  g_qcanuc_d[l_ac].*
      CALL cqci010_qcanuc_t_mask()
      LET g_qcanuc_d_mask_n[l_ac].* =  g_qcanuc_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION cqci010_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM qcanuc_t
       WHERE qcanucent = g_enterprise AND
         qcanuc001 = ps_keys_bak[1] AND qcanuc002 = ps_keys_bak[2] AND qcanuc003 = ps_keys_bak[3] AND qcanuc004 = ps_keys_bak[4] AND qcanuc005 = ps_keys_bak[5] AND qcanuc006 = ps_keys_bak[6] AND qcanuc007 = ps_keys_bak[7] AND qcanuc008 = ps_keys_bak[8] AND qcanucud001 = ps_keys_bak[9] AND qcanuc009 = ps_keys_bak[10]
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
         CALL g_qcanuc_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION cqci010_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO qcanuc_t
                  (qcanucent,
                   qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007,qcanuc008,qcanucud001,
                   qcanuc009
                   ,qcanuc010,qcanuc011,qcanuc012,qcanuc013,qcanuc014,qcanuc015,qcanuc016,qcanuc017,qcanuc018) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
                   ,g_qcanuc_d[g_detail_idx].qcanuc010,g_qcanuc_d[g_detail_idx].qcanuc011,g_qcanuc_d[g_detail_idx].qcanuc012, 
                       g_qcanuc_d[g_detail_idx].qcanuc013,g_qcanuc_d[g_detail_idx].qcanuc014,g_qcanuc_d[g_detail_idx].qcanuc015, 
                       g_qcanuc_d[g_detail_idx].qcanuc016,g_qcanuc_d[g_detail_idx].qcanuc017,g_qcanuc_d[g_detail_idx].qcanuc018) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "qcanuc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_qcanuc_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION cqci010_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "qcanuc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL cqci010_qcanuc_t_mask_restore('restore_mask_o')
               
      UPDATE qcanuc_t 
         SET (qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007,qcanuc008,qcanucud001,
              qcanuc009
              ,qcanuc010,qcanuc011,qcanuc012,qcanuc013,qcanuc014,qcanuc015,qcanuc016,qcanuc017,qcanuc018) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
              ,g_qcanuc_d[g_detail_idx].qcanuc010,g_qcanuc_d[g_detail_idx].qcanuc011,g_qcanuc_d[g_detail_idx].qcanuc012, 
                  g_qcanuc_d[g_detail_idx].qcanuc013,g_qcanuc_d[g_detail_idx].qcanuc014,g_qcanuc_d[g_detail_idx].qcanuc015, 
                  g_qcanuc_d[g_detail_idx].qcanuc016,g_qcanuc_d[g_detail_idx].qcanuc017,g_qcanuc_d[g_detail_idx].qcanuc018)  
 
         WHERE qcanucent = g_enterprise AND qcanuc001 = ps_keys_bak[1] AND qcanuc002 = ps_keys_bak[2] AND qcanuc003 = ps_keys_bak[3] AND qcanuc004 = ps_keys_bak[4] AND qcanuc005 = ps_keys_bak[5] AND qcanuc006 = ps_keys_bak[6] AND qcanuc007 = ps_keys_bak[7] AND qcanuc008 = ps_keys_bak[8] AND qcanucud001 = ps_keys_bak[9] AND qcanuc009 = ps_keys_bak[10]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "qcanuc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "qcanuc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL cqci010_qcanuc_t_mask_restore('restore_mask_n')
               
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
 
{<section id="cqci010.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION cqci010_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="cqci010.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION cqci010_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="cqci010.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION cqci010_lock_b(ps_table,ps_page)
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
   #CALL cqci010_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "qcanuc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN cqci010_bcl USING g_enterprise,
                                       g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
                                           g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006, 
                                           g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamucud001, 
                                           g_qcanuc_d[g_detail_idx].qcanuc009     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "cqci010_bcl:",SQLERRMESSAGE 
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
 
{<section id="cqci010.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION cqci010_unlock_b(ps_table,ps_page)
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
      CLOSE cqci010_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION cqci010_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamuc005,qcamuc006,qcamuc008,qcamuc009,qcamucud001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("qcamuc007",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION cqci010_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamuc005,qcamuc006,qcamuc008,qcamuc009,qcamucud001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("qcamuc007",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_entry("qcamuc004",FALSE)
   CALL cl_set_comp_entry("qcamuc001",FALSE)   #add by lixh 20150703 150702-00006#10
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="cqci010.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION cqci010_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("qcanuc014,qcanuc015",TRUE)
#   CALL cl_set_comp_required("qcanuc019,qcanuc020,qcanuc022,qcanuc023",FALSE)
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="cqci010.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION cqci010_set_no_entry_b(p_cmd)
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
   IF g_qcanuc_d[l_ac].qcanuc013 NOT MATCHES '[1256]' THEN
      INITIALIZE g_qcanuc_d[l_ac].qcanuc014 TO NULL
      CALL cl_set_comp_entry("qcanuc014",FALSE)
   END IF
   
   IF g_qcanuc_d[l_ac].qcanuc013 = '4' THEN
#      CALL cl_set_comp_required("qcanuc019,qcanuc020,qcanuc022,qcanuc023",TRUE)
      CALL cl_set_comp_entry("qcanuc015",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="cqci010.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION cqci010_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION cqci010_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_qcamuc_m.qcamucstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION cqci010_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION cqci010_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION cqci010_default_search()
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
      LET ls_wc = ls_wc, " qcamuc001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " qcamuc002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " qcamuc003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " qcamuc004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " qcamuc005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " qcamuc006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " qcamuc008 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " qcamuc009 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET ls_wc = ls_wc, " qcamucud001 = '", g_argv[09], "' AND "
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
               WHEN la_wc[li_idx].tableid = "qcamuc_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "qcanuc_t" 
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
 
{<section id="cqci010.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION cqci010_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
DEFINE l_success  LIKE type_t.chr5
DEFINE l_sql      STRING
DEFINE l_num      LIKE type_t.num5
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_qcamuc_m.qcamuc001 IS NULL
      OR g_qcamuc_m.qcamuc002 IS NULL      OR g_qcamuc_m.qcamuc003 IS NULL      OR g_qcamuc_m.qcamuc004 IS NULL      OR g_qcamuc_m.qcamuc005 IS NULL      OR g_qcamuc_m.qcamuc006 IS NULL      OR g_qcamuc_m.qcamuc008 IS NULL      OR g_qcamuc_m.qcamuc009 IS NULL      OR g_qcamuc_m.qcamucud001 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN cqci010_cl USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamucud001
   IF STATUS THEN
      CLOSE cqci010_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN cqci010_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE cqci010_master_referesh USING g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
       g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
       g_qcamuc_m.qcamucud001 INTO g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004, 
       g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucowndp, 
       g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt, 
       g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc008_desc,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid_desc,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamucmodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT cqci010_action_chk() THEN
      CLOSE cqci010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc002_desc, 
       g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005, 
       g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc008_desc, 
       g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucownid_desc, 
       g_qcamuc_m.qcamucowndp,g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtid_desc, 
       g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid, 
       g_qcamuc_m.qcamucmodid_desc,g_qcamuc_m.qcamucmoddt,g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt 
 
 
   CASE g_qcamuc_m.qcamucstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_qcamuc_m.qcamucstus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("unconfirmed,confirmed",TRUE)
       CASE g_qcamuc_m.qcamucstus 
             WHEN "Y"
                CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
             WHEN "N"
                CALL cl_set_act_visible("unconfirmed",FALSE)
        END CASE
      #end add-point
      
      
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
    SELECT COUNT(*) INTO l_num FROM qcanuc_t WHERE qcanucent = g_enterprise AND qcanuc001 = g_qcamuc_m.qcamuc001 AND qcanuc002 = g_qcamuc_m.qcamuc002 
                                 AND qcanuc003 = g_qcamuc_m.qcamuc003 AND qcanuc004 = g_qcamuc_m.qcamuc004 AND qcanuc005 = g_qcamuc_m.qcamuc005 
                                 AND qcanuc006 = g_qcamuc_m.qcamuc006 AND qcanuc007 = g_qcamuc_m.qcamuc008 AND qcanuc008 = g_qcamuc_m.qcamuc009
                                 AND qcanucud001 = g_qcamuc_m.qcamucud001
IF l_num = 0 THEN
    INITIALIZE g_errparam TO NULL 
    LET g_errparam.extend = "" 
    LET g_errparam.code = "cqc-00001" 
    LET g_errparam.popup = TRUE 
    CALL cl_err()
ELSE
         IF s_transaction_chk("N",0) THEN
              CALL s_transaction_begin()
           END IF 
        LET l_success = TRUE
         LET g_qcamuc_m.qcamuccnfid = g_user
         LET g_qcamuc_m.qcamuccnfdt = cl_get_current()
         UPDATE qcamuc_t SET (qcamuccnfid,qcamuccnfdt) = ( g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt)
             WHERE  qcamucent = g_enterprise
                  AND qcamuc001 = g_qcamuc_m.qcamuc001
                  AND qcamuc002 = g_qcamuc_m.qcamuc002
                  AND qcamuc003 = g_qcamuc_m.qcamuc003
                  AND qcamuc004 = g_qcamuc_m.qcamuc004
                  AND qcamuc005 = g_qcamuc_m.qcamuc005
                  AND qcamuc006 = g_qcamuc_m.qcamuc006
                  AND  qcamuc008 = g_qcamuc_m.qcamuc008
                  AND  qcamuc009 = g_qcamuc_m.qcamuc009
                  AND qcamucud001 = g_qcamuc_m.qcamucud001 
             IF SQLCA.sqlcode THEN
                  LET l_success = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = ''
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF 
               
        LET l_sql =" SELECT qcament,qcam001,qcam002,qcam003,qcam004,qcamud001,qcam005, 
                         qcam006,qcam007,qcam008,qcam009,qcam010,qcamstus,qcamownid,qcamowndp, 
                         qcamcrtid,qcamcrtdp,qcamcrtdt,qcammodid,qcammoddt FROM qcam_t ",
                         " WHERE qcament = ? AND qcam001 = ? AND qcam002 = ? AND qcam003 = ? AND qcam004 = ? 
                         AND qcam005 = ? AND qcam006 = ? AND qcam008 = ? AND qcam009 = ? FOR UPDATE "
          DECLARE cqci010_qcam CURSOR FROM l_sql
          
          LET l_sql = " SELECT qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,qcan009, 
                         qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016,qcan017,qcan018  FROM qcan_t ",
                     " WHERE qcanent = ? AND qcan001 = ? AND qcan002 = ? AND qcan003 = ? AND qcan004 = ?
                     AND qcan005 = ? AND qcan006 = ? AND qcan007 = ? AND qcan008 = ?  FOR UPDATE "
          DECLARE cqci010_qcan CURSOR FROM l_sql
          
          OPEN cqci010_qcam USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,
                     g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009
                     
              LET l_sql = "MERGE INTO qcam_t ",
                     "USING (SELECT qcamucent,qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamucud001,qcamuc005, 
                         qcamuc006,qcamuc007,qcamuc008,qcamuc009,qcamuc010,qcamucstus,qcamucownid,qcamucowndp, 
                         qcamuccrtid,qcamuccrtdp,qcamuccrtdt,qcamucmodid,qcamucmoddt,qcamuccnfid,qcamuccnfdt FROM qcamuc_t ",
                         " WHERE  qcamucent = '",g_enterprise,"'",
                         "  AND qcamuc001 = '",g_qcamuc_m.qcamuc001,"'",
                         "  AND qcamuc002 = '",g_qcamuc_m.qcamuc002,"'",
                         "  AND qcamuc003 = '",g_qcamuc_m.qcamuc003,"'",
                         "  AND qcamuc004 = '",g_qcamuc_m.qcamuc004,"'",
                         "  AND qcamuc005 = '",g_qcamuc_m.qcamuc005,"'",
                          " AND qcamuc006 = '",g_qcamuc_m.qcamuc006,"'",
                         "  AND  qcamuc008 = '",g_qcamuc_m.qcamuc008,"'",
                          " AND  qcamuc009 = '",g_qcamuc_m.qcamuc009,"'",
                         " AND qcamucud001 = '",g_qcamuc_m.qcamucud001,"' )",                   
                   " ON (qcament = qcamucent   
                           AND qcam001 = qcamuc001  
                           AND qcam002 = qcamuc002 
                           AND qcam003 =qcamuc003 
                           AND qcam004 = qcamuc004 
                           AND qcam005 = qcamuc005  
                           AND qcam006 = qcamuc006  
                           AND qcam008 = qcamuc008  
                           AND qcam009 = qcamuc009 )",
                    " WHEN NOT MATCHED THEN ",
                    " INSERT (qcament,qcam001,qcam002,qcam003,qcam004,qcamud001,qcam005, 
                         qcam006,qcam007,qcam008,qcam009,qcam010,qcamstus,qcamownid,qcamowndp, 
                         qcamcrtid,qcamcrtdp,qcamcrtdt,qcammodid,qcammoddt) ",
                     "VALUES(qcamucent,qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamucud001,qcamuc005, 
                         qcamuc006,qcamuc007,qcamuc008,qcamuc009,qcamuc010,'Y',qcamucownid,qcamucowndp, 
                         qcamuccrtid,qcamuccrtdp,qcamuccrtdt,qcamucmodid,qcamucmoddt)",
                    "  WHEN MATCHED THEN ",
                    "UPDATE SET  qcamud001 = qcamucud001, 
                                 qcam007 =  qcamuc007,
                                 qcam010  = qcamuc010 "
              PREPARE ins_qcam_pre FROM l_sql
              EXECUTE ins_qcam_pre 
               IF SQLCA.sqlcode THEN
                  LET l_success = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = ''
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF 
             CLOSE cqci010_qcam
            
            OPEN cqci010_qcan USING g_enterprise,g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,
                     g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009
               
             DELETE FROM qcan_t WHERE qcanent = g_enterprise AND qcan001 = g_qcamuc_m.qcamuc001 AND qcan002 = g_qcamuc_m.qcamuc002 
                                 AND qcan003 = g_qcamuc_m.qcamuc003 AND qcan004 = g_qcamuc_m.qcamuc004 AND qcan005 = g_qcamuc_m.qcamuc005 
                                 AND qcan006 = g_qcamuc_m.qcamuc006 AND qcan007 = g_qcamuc_m.qcamuc008 
                IF SQLCA.sqlcode THEN
                  LET l_success = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = ''
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF               
             INSERT INTO qcan_t(qcanent,qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,qcan009, qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,qcan016,qcan017,qcan018,qcanud001) 
                   SELECT qcanucent,qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007,qcanuc008,qcanuc009,qcanuc010,qcanuc011,qcanuc012,qcanuc013,qcanuc014,qcanuc015,qcanuc016,qcanuc017,qcanuc018,qcanucud001 FROM qcanuc_t 
                   WHERE qcanucent = g_enterprise AND qcanuc001 = g_qcamuc_m.qcamuc001 AND qcanuc002 = g_qcamuc_m.qcamuc002 
                                 AND qcanuc003 = g_qcamuc_m.qcamuc003 AND qcanuc004 = g_qcamuc_m.qcamuc004 AND qcanuc005 = g_qcamuc_m.qcamuc005 
                                 AND qcanuc006 = g_qcamuc_m.qcamuc006 AND qcanuc007 = g_qcamuc_m.qcamuc008 AND qcanucud001 = g_qcamuc_m.qcamucud001                                 
            IF SQLCA.sqlcode THEN
                  LET l_success = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = ''
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF 
            CLOSE cqci010_qcan
            
            IF l_success = TRUE THEN
                CALL s_transaction_end('Y','0')
            ELSE
                CALL s_transaction_end('N','0')
            END IF
   END IF         
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
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      ) OR 
      g_qcamuc_m.qcamucstus = lc_state OR cl_null(lc_state) THEN
      CLOSE cqci010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_qcamuc_m.qcamucmodid = g_user
   LET g_qcamuc_m.qcamucmoddt = cl_get_current()
   LET g_qcamuc_m.qcamucstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE qcamuc_t 
      SET (qcamucstus,qcamucmodid,qcamucmoddt) 
        = (g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt)     
    WHERE qcamucent = g_enterprise AND qcamuc001 = g_qcamuc_m.qcamuc001
      AND qcamuc002 = g_qcamuc_m.qcamuc002      AND qcamuc003 = g_qcamuc_m.qcamuc003      AND qcamuc004 = g_qcamuc_m.qcamuc004      AND qcamuc005 = g_qcamuc_m.qcamuc005      AND qcamuc006 = g_qcamuc_m.qcamuc006      AND qcamuc008 = g_qcamuc_m.qcamuc008      AND qcamuc009 = g_qcamuc_m.qcamuc009      AND qcamucud001 = g_qcamuc_m.qcamucud001
    
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
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE cqci010_master_referesh USING g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
          g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009, 
          g_qcamuc_m.qcamucud001 INTO g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003, 
          g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamucud001,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007, 
          g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus,g_qcamuc_m.qcamucownid, 
          g_qcamuc_m.qcamucowndp,g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdt, 
          g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmoddt,g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt, 
          g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002_desc,g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc005_desc, 
          g_qcamuc_m.qcamuc008_desc,g_qcamuc_m.qcamucownid_desc,g_qcamuc_m.qcamucowndp_desc,g_qcamuc_m.qcamuccrtid_desc, 
          g_qcamuc_m.qcamuccrtdp_desc,g_qcamuc_m.qcamucmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc001_desc,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc002_desc, 
          g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc003_desc,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamucud001, 
          g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc005_desc,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc007,g_qcamuc_m.qcamuc008, 
          g_qcamuc_m.qcamuc008_desc,g_qcamuc_m.qcamuc009,g_qcamuc_m.qcamuc010,g_qcamuc_m.qcamucstus, 
          g_qcamuc_m.qcamucownid,g_qcamuc_m.qcamucownid_desc,g_qcamuc_m.qcamucowndp,g_qcamuc_m.qcamucowndp_desc, 
          g_qcamuc_m.qcamuccrtid,g_qcamuc_m.qcamuccrtid_desc,g_qcamuc_m.qcamuccrtdp,g_qcamuc_m.qcamuccrtdp_desc, 
          g_qcamuc_m.qcamuccrtdt,g_qcamuc_m.qcamucmodid,g_qcamuc_m.qcamucmodid_desc,g_qcamuc_m.qcamucmoddt, 
          g_qcamuc_m.qcamuccnfid,g_qcamuc_m.qcamuccnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE cqci010_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL cqci010_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="cqci010.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION cqci010_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_qcanuc_d.getLength() THEN
         LET g_detail_idx = g_qcanuc_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_qcanuc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_qcanuc_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION cqci010_b_fill2(pi_idx)
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
   CALL g_qcanuc2_d.clear()    #g_qcanuc2_d 單頭及單身 

 
   #add-point:b_fill段sql_before

   #end add-point
   
   #判斷是否填充
   IF cqci010_fill2_chk(1) THEN
   
      LET g_sql = "SELECT qcanuc009,qcanuc010,'',qcanuc011,qcanuc013,qcanuc019,qcanuc020,qcanuc021,qcanuc022,qcanuc023,qcanuc024,qcanuc025,qcanuc026",
                        " FROM qcanuc_t " ,
                  " INNER JOIN qcamuc_t ON qcamuc001 = qcanuc001 ",
                  " AND qcamuc002 = qcanuc002 ",

                  " AND qcamuc003 = qcanuc003 ",

                  " AND qcamuc004 = qcanuc004 ",

                  " AND qcamuc005 = qcanuc005 ",

                  " AND qcamuc006 = qcanuc006 ",

                  " AND qcamuc008 = qcanuc007 ",

                  " AND qcamuc009 = qcanuc008 ",
                  " AND qcamucud001 = qcanucud001 ",

                  "",
                  
                  " WHERE qcanucent=? AND qcanuc001=? AND qcanuc002=? AND qcanuc003=? AND qcanuc004=? AND qcanuc005=? AND qcanuc006=? AND qcanuc007=? AND qcanuc008=? AND qcanucud001=?"
      
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY qcanuc_t.qcanuc009"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE cqci010_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR cqci010_pb2
      
      LET g_cnt2 = l_ac2
      LET l_ac2 = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_qcamuc_m.qcamuc001
                                               ,g_qcamuc_m.qcamuc002

                                               ,g_qcamuc_m.qcamuc003

                                               ,g_qcamuc_m.qcamuc004

                                               ,g_qcamuc_m.qcamuc005

                                               ,g_qcamuc_m.qcamuc006

                                               ,g_qcamuc_m.qcamuc008

                                               ,g_qcamuc_m.qcamuc009
                                               ,g_qcamuc_m.qcamucud001

                                               
      FOREACH b_fill_cs2 INTO g_qcanuc2_d[l_ac2].qcanuc009_1,g_qcanuc2_d[l_ac2].qcanuc010_1,g_qcanuc2_d[l_ac2].qcanuc010_1_desc,g_qcanuc2_d[l_ac2].qcanuc011_1,g_qcanuc2_d[l_ac2].qcanuc013_1,
                              g_qcanuc2_d[l_ac2].qcanuc019,g_qcanuc2_d[l_ac2].qcanuc020,g_qcanuc2_d[l_ac2].qcanuc021,g_qcanuc2_d[l_ac2].qcanuc022,g_qcanuc2_d[l_ac2].qcanuc023,
                              g_qcanuc2_d[l_ac2].qcanuc024,g_qcanuc2_d[l_ac2].qcanuc025,g_qcanuc2_d[l_ac2].qcanuc026
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL s_desc_get_acc_desc('1051',g_qcanuc2_d[l_ac2].qcanuc010_1) RETURNING g_qcanuc2_d[l_ac2].qcanuc010_1_desc   #161018-00003#1
         #end add-point
      
         LET l_ac2 = l_ac2 + 1
         IF l_ac2 > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
   

   
   CALL g_qcanuc2_d.deleteElement(g_qcanuc2_d.getLength())

   

   LET l_ac2 = g_cnt2
   LET g_cnt2 = 0  
   
   FREE cqci010_pb2
   #end add-point
    
   LET l_ac = li_ac
   
   CALL cqci010_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION cqci010_fill_chk(ps_idx)
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
 
{<section id="cqci010.status_show" >}
PRIVATE FUNCTION cqci010_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="cqci010.mask_functions" >}
&include "erp/cqc/cqci010_mask.4gl"
 
{</section>}
 
{<section id="cqci010.signature" >}
   
 
{</section>}
 
{<section id="cqci010.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION cqci010_set_pk_array()
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
   LET g_pk_array[1].values = g_qcamuc_m.qcamuc001
   LET g_pk_array[1].column = 'qcamuc001'
   LET g_pk_array[2].values = g_qcamuc_m.qcamuc002
   LET g_pk_array[2].column = 'qcamuc002'
   LET g_pk_array[3].values = g_qcamuc_m.qcamuc003
   LET g_pk_array[3].column = 'qcamuc003'
   LET g_pk_array[4].values = g_qcamuc_m.qcamuc004
   LET g_pk_array[4].column = 'qcamuc004'
   LET g_pk_array[5].values = g_qcamuc_m.qcamuc005
   LET g_pk_array[5].column = 'qcamuc005'
   LET g_pk_array[6].values = g_qcamuc_m.qcamuc006
   LET g_pk_array[6].column = 'qcamuc006'
   LET g_pk_array[7].values = g_qcamuc_m.qcamuc008
   LET g_pk_array[7].column = 'qcamuc008'
   LET g_pk_array[8].values = g_qcamuc_m.qcamuc009
   LET g_pk_array[8].column = 'qcamuc009'
   LET g_pk_array[9].values = g_qcamuc_m.qcamucud001
   LET g_pk_array[9].column = 'qcamucud001'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="cqci010.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="cqci010.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION cqci010_msgcentre_notify(lc_state)
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
   CALL cqci010_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_qcamuc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="cqci010.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION cqci010_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="cqci010.other_function" readonly="Y" >}

PRIVATE FUNCTION cqci010_qcamuc001_chk(p_qcamuc001)
DEFINE p_qcamuc001  LIKE qcamuc_t.qcamuc001
DEFINE l_n        LIKE type_t.num5
   IF NOT cl_null(p_qcamuc001) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM ooal_t
       WHERE ooalent = g_enterprise
         AND ooal002 = p_qcamuc001
         AND ooal001 = 5
      IF l_n = 0 THEN
         IF cl_ask_confirm('aoo-00076') THEN
            IF NOT s_aooi070_ins(5,p_qcamuc001) THEN
               RETURN FALSE
            END IF
         ELSE
            RETURN FALSE
         END IF
      END IF
      IF NOT s_aooi070_chk_exist(5,p_qcamuc001) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc002_chk(p_qcamuc002)
DEFINE p_qcamuc002   LIKE qcamuc_t.qcamuc002
#150527 by whitney modify start
#   IF NOT cl_null(p_qcamuc002) AND p_qcamuc002 != 'ALL' THEN
#      IF NOT ap_chk_isExist(p_qcamuc002,"SELECT COUNT(*) FROM imcg_t WHERE imcgent = "||g_enterprise||" AND imcgsite = '"||g_site||"'  AND imcg111 = ?",'aim-00042',1) THEN
#         LET g_qcamuc_m.qcamuc002 = g_qcamuc002_t
#         RETURN FALSE
#      END IF
#      IF NOT ap_chk_isExist(p_qcamuc002,"SELECT COUNT(*) FROM imcg_t WHERE imcgent = "||g_enterprise||" AND imcgsite = '"||g_site||"'  AND imcg111 = ? AND imcgstus = 'Y'",'aim-00042',1) THEN
#         RETURN FALSE
#      END IF
#   END IF
    IF NOT cl_null(p_qcamuc002) AND p_qcamuc002 != 'ALL' THEN   #160107-00014#1 add
       IF NOT s_azzi650_chk_exist('205',p_qcamuc002) THEN
          RETURN FALSE
       END IF
    END IF  #160107-00014#1 add
#150527 by whitney modify end
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc002_qcamuc003_default(p_qcamuc002,p_qcamuc003)
DEFINE p_qcamuc002  LIKE qcamuc_t.qcamuc002
DEFINE p_qcamuc003  LIKE qcamuc_t.qcamuc003
   IF cl_null(p_qcamuc002) AND cl_null(p_qcamuc003) THEN
      RETURN TRUE 
   END IF
   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc002_qcamuc003_chk(p_qcamuc002,p_qcamuc003)
DEFINE p_qcamuc002  LIKE qcamuc_t.qcamuc002
DEFINE p_qcamuc003  LIKE qcamuc_t.qcamuc003
   IF p_qcamuc002 = 'ALL' AND p_qcamuc003 = 'ALL' THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc003_chk(p_qcamuc002,p_qcamuc003)
DEFINE p_qcamuc003    LIKE qcamuc_t.qcamuc003
DEFINE p_qcamuc002    LIKE qcamuc_t.qcamuc002
DEFINE l_sql        STRING
   IF NOT cl_null(p_qcamuc003) AND p_qcamuc003 != 'ALL' THEN
      LET l_sql = "SELECT COUNT(*) FROM imaa_t  WHERE imaaent=",g_enterprise," AND imaa001=?"
      IF NOT ap_chk_isExist(p_qcamuc003,l_sql,'aim-00001',1) THEN
         RETURN FALSE
      END IF
      LET l_sql = l_sql," AND imaastus = 'Y'"
#      IF NOT ap_chk_isExist(p_qcamuc003,l_sql,'aim-00002',1) THEN     #160318-00005#42  mark
      IF NOT ap_chk_isExist(p_qcamuc003,l_sql,'sub-01302','aimm200') THEN      #160318-00005#42  add
         RETURN FALSE
      END IF  
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_imae111_chk(p_qcamuc002,p_qcamuc003)
DEFINE p_qcamuc003    LIKE qcamuc_t.qcamuc003
DEFINE p_qcamuc002    LIKE qcamuc_t.qcamuc002
DEFINE l_sql        STRING
   IF NOT cl_null(p_qcamuc003) AND NOT cl_null(p_qcamuc002) AND p_qcamuc002 != 'ALL' AND p_qcamuc003 != 'ALL' THEN
      LET l_sql = "SELECT COUNT(*) FROM imaa_t LEFT JOIN imae_t ON imaaent=imaeent AND imaa001=imae001 AND imaesite='",g_site,"'", 
                  " WHERE imaaent=",g_enterprise," AND imaa001=? AND imae111='",p_qcamuc002 CLIPPED,"' AND imaastus = 'Y'"
      IF NOT ap_chk_isExist(p_qcamuc003,l_sql,'aim-00157',1) THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc004_entry(p_qcamuc003)
DEFINE l_n   LIKE type_t.num5
DEFINE p_qcamuc003 LIKE qcamuc_t.qcamuc003
   IF NOT cl_null(p_qcamuc003) AND p_qcamuc003 != 'ALL' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM imaa_t WHERE imaa001 = p_qcamuc003
         AND imaaent = g_enterprise AND imaa005 IS NOT NULL
      IF l_n = 0 THEN
         CALL cl_set_comp_entry("qcamuc004",FALSE)
         RETURN FALSE
      ELSE
         CALL cl_set_comp_entry("qcamuc004",TRUE)
         RETURN TRUE
      END IF             
   END IF
   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc005_chk(p_qcamuc005)
DEFINE l_sql    STRING
DEFINE p_qcamuc005 LIKE qcamuc_t.qcamuc005
   IF NOT cl_null(p_qcamuc005) AND p_qcamuc005 !='ALL' THEN
      LET l_sql = "SELECT COUNT(*) FROM oocq_t WHERE oocqent = ",g_enterprise,
                  " AND oocq001 = '221' AND oocq002 = ?"
#      IF NOT ap_chk_isExist(p_qcamuc005,l_sql,'aqc-00016',1) THEN      #160318-00005#42  mark
      IF NOT ap_chk_isExist(p_qcamuc005,l_sql,'sub-01303','aeci004') THEN      #160318-00005#42  add
         RETURN FALSE
      END IF
      
      LET l_sql = l_sql," AND oocqstus='Y'"
#      IF NOT ap_chk_isExist(p_qcamuc005,l_sql,'aqc-00017',1) THEN   #160318-00005#42  mark
      IF NOT ap_chk_isExist(p_qcamuc005,l_sql,'sub-01302','aeci004') THEN   #160318-00005#42  add
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc008_chk(p_qcamuc007,p_qcamuc008)
DEFINE p_qcamuc007     LIKE qcamuc_t.qcamuc007
DEFINE p_qcamuc008     LIKE qcamuc_t.qcamuc008
DEFINE l_sql         STRING
   IF NOT cl_null(p_qcamuc007) AND NOT cl_null(p_qcamuc008) THEN
      LET l_sql = "SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = ",g_enterprise,
                  " AND pmaa001 = ?"
      IF p_qcamuc007 = '0' AND p_qcamuc008 != 'ALL' THEN
         IF NOT ap_chk_isExist(p_qcamuc008,l_sql,'ais-00019',1) THEN
            RETURN FALSE
         END IF
         LET l_sql = l_sql," AND pmaastus = 'Y'"
         IF NOT ap_chk_isExist(p_qcamuc008,l_sql,'ais-00020',1) THEN
            RETURN FALSE
         END IF
      END IF
      IF p_qcamuc007 = '1' THEN
         LET l_sql = l_sql," AND pmaa002 IN ('2','3')"
         IF NOT ap_chk_isExist(p_qcamuc008,l_sql,'abm-00034',1) THEN
            RETURN FALSE
         END IF
         
         LET l_sql = l_sql," AND pmaastus = 'Y'"
#         IF NOT ap_chk_isExist(p_qcamuc008,l_sql,'abm-00035',1) THEN      #160318-00005#42  mark
         IF NOT ap_chk_isExist(p_qcamuc008,l_sql,'sub-01302','apmm100') THEN       #160318-00005#42  add
            RETURN FALSE
         END IF
      END IF
      IF p_qcamuc007 = '2' THEN
         LET l_sql = l_sql," AND pmaa002 IN ('1','3')"
         IF NOT ap_chk_isExist(p_qcamuc008,l_sql,'aqc-00018',1) THEN
            RETURN FALSE
         END IF
         
         LET l_sql = l_sql," AND pmaastus = 'Y'"
#         IF NOT ap_chk_isExist(p_qcamuc008,l_sql,'abm-00035',1) THEN     #160318-00005#42  mark
         IF NOT ap_chk_isExist(p_qcamuc008,l_sql,'sub-01302','apmm100') THEN      #160318-00005#42  add
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_qcanuc014_chk()
DEFINE l_sql      STRING
DEFINE l_n        LIKE type_t.num5
   IF NOT cl_null(g_qcanuc_d[l_ac].qcanuc013) AND NOT cl_null(g_qcanuc_d[l_ac].qcanuc014) THEN
      IF g_qcanuc_d[l_ac].qcanuc013 = '1' THEN
         LET l_sql = "SELECT COUNT(*) FROM qcac_t WHERE qcacent=",g_enterprise," AND qcac002=?"
         IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc014,l_sql,'aqc-00021',1) THEN
            RETURN FALSE
         END IF
         LET l_sql = l_sql," AND qcacstus='Y'"
#         IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc014,l_sql,'aqc-00022',1) THEN     #160318-00005#42  mark
         IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc014,l_sql,'sub-01302','aqci003') THEN     #160318-00005#42  add
            RETURN FALSE
         END IF
      END IF
      IF g_qcanuc_d[l_ac].qcanuc013 = '2' THEN
         LET l_sql = "SELECT COUNT(*) FROM qcag_t WHERE qcagent=",g_enterprise," AND qcag003=?"
         IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc014,l_sql,'aqc-00023',1) THEN
            RETURN FALSE
         END IF
         LET l_sql = l_sql," AND qcagstus='Y'"
#         IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc014,l_sql,'aqc-00024',1) THEN     #160318-00005#42  mark
         IF NOT ap_chk_isExist(g_qcanuc_d[l_ac].qcanuc014,l_sql,'sub-01302','aqci007') THEN     #160318-00005#42  add
            RETURN FALSE
         END IF
      END IF
      IF g_qcanuc_d[l_ac].qcanuc013 = '5' THEN 
         IF g_qcanuc_d[l_ac].qcanuc014 < 0 OR g_qcanuc_d[l_ac].qcanuc014 > 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aqc-00057'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF
      IF g_qcanuc_d[l_ac].qcanuc013 = '6' THEN 
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM qcah_t 
          WHERE qcahent = g_enterprise AND qcah001 = g_qcamuc_m.qcamuc001
            AND qcah002 =  g_qcanuc_d[l_ac].qcanuc014
          IF l_n = 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aqc-00058'
             LET g_errparam.extend = g_qcanuc_d[l_ac].qcanuc014
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          END IF
          
          LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM qcah_t 
          WHERE qcahent = g_enterprise AND qcah001 = g_qcamuc_m.qcamuc001
            AND qcah002 =  g_qcanuc_d[l_ac].qcanuc014 AND qcahstus = 'Y'
          IF l_n = 0 THEN
             INITIALIZE g_errparam TO NULL
#             LET g_errparam.code = 'aqc-00059'     #160318-00005#42  mark
             LET g_errparam.code = 'sub-01302'     #160318-00005#42  add
             LET g_errparam.extend = g_qcanuc_d[l_ac].qcanuc014
             #160318-00005#42 --s add
             LET g_errparam.replace[1] = 'aqci011'
             LET g_errparam.replace[2] = cl_get_progname('aqci011',g_lang,"2")
             LET g_errparam.exeprog = 'aqci011'
             #160318-00005#42 --e add
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_fill2_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充


   RETURN FALSE
END FUNCTION

PRIVATE FUNCTION cqci010_lock_b2(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL cqci010_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "qcanuc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN cqci010_bcl2 USING g_enterprise,
                                       g_qcamuc_m.qcamuc001,g_qcamuc_m.qcamuc002,g_qcamuc_m.qcamuc003,g_qcamuc_m.qcamuc004,g_qcamuc_m.qcamuc005,g_qcamuc_m.qcamuc006,g_qcamuc_m.qcamuc008,g_qcamuc_m.qcamuc009,g_qcanuc2_d[g_detail_idx2].qcanuc009_1,g_qcamuc_m.qcamucud001
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "cqci010_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   
   END IF
                                    

   

   
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_set_entry_b2(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1   

END FUNCTION

PRIVATE FUNCTION cqci010_set_no_entry_b2(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("qcanuc009_1,qcanuc010_1,qcanuc011_1,qcanuc013_1",FALSE)
   END IF
END FUNCTION

PRIVATE FUNCTION cqci010_unlock_b2(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define

   #end add-point  
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,2) THEN
      CLOSE cqci010_bcl2
   END IF
END FUNCTION

PRIVATE FUNCTION cqci010_update_b2(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define

   #end add-point     
   
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
   LET ls_group = "'2',"
   IF ls_group.getIndexOf(ps_page,2) > 0 THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE qcanuc_t 
         SET (qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007,qcanuc008,
              qcanuc009,qcanucud001
              ,qcanuc019,qcanuc020,qcanuc021,qcanuc022,qcanuc023,qcanuc024,qcanuc025,qcanuc026) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
              ,g_qcanuc2_d[g_detail_idx2].qcanuc019,g_qcanuc2_d[g_detail_idx2].qcanuc020,g_qcanuc2_d[g_detail_idx2].qcanuc021,g_qcanuc2_d[g_detail_idx2].qcanuc022,g_qcanuc2_d[g_detail_idx2].qcanuc023,g_qcanuc2_d[g_detail_idx2].qcanuc024,g_qcanuc2_d[g_detail_idx2].qcanuc025,g_qcanuc2_d[g_detail_idx2].qcanuc026) 
         WHERE qcanucent = g_enterprise AND qcanuc001 = ps_keys_bak[1] AND qcanuc002 = ps_keys_bak[2] AND qcanuc003 = ps_keys_bak[3] AND qcanuc004 = ps_keys_bak[4] AND qcanuc005 = ps_keys_bak[5] AND qcanuc006 = ps_keys_bak[6] AND qcanuc007 = ps_keys_bak[7] AND qcanuc008 = ps_keys_bak[8] AND qcanucud001 = ps_keys_bak[9] AND qcanuc009 = ps_keys_bak[10] 
      #add-point:update_b段修改中

      #end add-point   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE
         
      END IF
      #add-point:update_b段修改後

      #end add-point  
   END IF
END FUNCTION

PRIVATE FUNCTION cqci010_qcanuc019_qcanuc023_chk()
   IF NOT cl_null(g_qcanuc2_d[l_ac2].qcanuc019) AND NOT cl_null(g_qcanuc2_d[l_ac2].qcanuc023) THEN
      IF g_qcanuc2_d[l_ac2].qcanuc019 < g_qcanuc2_d[l_ac2].qcanuc023 THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_qcanuc020_qcanuc022_chk()
   IF NOT cl_null(g_qcanuc2_d[l_ac2].qcanuc020) AND NOT cl_null(g_qcanuc2_d[l_ac2].qcanuc022) THEN
      IF g_qcanuc2_d[l_ac2].qcanuc020 < g_qcanuc2_d[l_ac2].qcanuc022 THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc001_desc(p_qcamuc001)
DEFINE p_qcamuc001   LIKE qcamuc_t.qcamuc001
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcamuc001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='5' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcamuc_m.qcamuc001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc001_desc
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc002_desc(p_qcamuc002)
DEFINE p_qcamuc002   LIKE qcamuc_t.qcamuc002
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcamuc002 
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='205' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcamuc_m.qcamuc002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc002_desc
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc003_desc(p_qcamuc003)
DEFINE p_qcamuc003   LIKE qcamuc_t.qcamuc003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcamuc003
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcamuc_m.qcamuc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc003_desc
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc005_desc(p_qcamuc005)
DEFINE p_qcamuc005    LIKE qcamuc_t.qcamuc005
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcamuc005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcamuc_m.qcamuc005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc005_desc
END FUNCTION

PRIVATE FUNCTION cqci010_qcamuc008_desc(p_qcamuc008)
DEFINE p_qcamuc008 LIKE qcamuc_t.qcamuc008
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_qcamuc008
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_qcamuc_m.qcamuc008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_qcamuc_m.qcamuc008_desc
END FUNCTION

PRIVATE FUNCTION cqci010_qcanuc016_required(p_qcanuc015)
DEFINE p_qcanuc015     LIKE qcanuc_t.qcanuc015
   IF p_qcanuc015 != '1' THEN
      CALL cl_set_comp_required("qcanuc016",TRUE)
   ELSE
      CALL cl_set_comp_required("qcanuc016",FALSE)
   END IF
END FUNCTION

 
{</section>}
 
