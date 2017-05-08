#該程式未解開Section, 採用最新樣板產出!
{<section id="astt550.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-02-25 15:45:31), PR版次:0006(2016-11-21 09:13:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: astt550
#+ Description: 專櫃交款匯總單維護作業
#+ Creator....: 06189(2015-05-20 16:41:29)
#+ Modifier...: 06540 -SD/PR- 02749
 
{</section>}
 
{<section id="astt550.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
#60816-00068#17     2016/08/19  By 08209    調整transaction
#160818-00017#39    2016-08-30  By 08734    删除修改未重新判断状态码
#161111-00028#3     2016/11/16  by 02481    标准程式定义采用宣告模式,弃用.*写法
#160824-00007#192   2016/11/20  by lori     修正舊值備份寫法
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
PRIVATE type type_g_steu_m        RECORD
       steusite LIKE steu_t.steusite, 
   steusite_desc LIKE type_t.chr80, 
   steudocnt LIKE steu_t.steudocnt, 
   steudocno LIKE steu_t.steudocno, 
   steu002 LIKE steu_t.steu002, 
   steu002_desc LIKE type_t.chr80, 
   steu001 LIKE steu_t.steu001, 
   steu003 LIKE steu_t.steu003, 
   steu003_desc LIKE type_t.chr80, 
   steu004 LIKE steu_t.steu004, 
   steu005 LIKE steu_t.steu005, 
   stax004 LIKE stax_t.stax004, 
   steu006 LIKE steu_t.steu006, 
   steu007 LIKE steu_t.steu007, 
   steu010 LIKE steu_t.steu010, 
   steu000 LIKE steu_t.steu000, 
   steu008 LIKE steu_t.steu008, 
   steu009 LIKE steu_t.steu009, 
   steu011 LIKE steu_t.steu011, 
   steu012 LIKE steu_t.steu012, 
   steustus LIKE steu_t.steustus, 
   steuownid LIKE steu_t.steuownid, 
   steuownid_desc LIKE type_t.chr80, 
   steuowndp LIKE steu_t.steuowndp, 
   steuowndp_desc LIKE type_t.chr80, 
   steucrtid LIKE steu_t.steucrtid, 
   steucrtid_desc LIKE type_t.chr80, 
   steucrtdp LIKE steu_t.steucrtdp, 
   steucrtdp_desc LIKE type_t.chr80, 
   steucrtdt LIKE steu_t.steucrtdt, 
   steumodid LIKE steu_t.steumodid, 
   steumodid_desc LIKE type_t.chr80, 
   steumoddt LIKE steu_t.steumoddt, 
   steucnfid LIKE steu_t.steucnfid, 
   steucnfid_desc LIKE type_t.chr80, 
   steucnfdt LIKE steu_t.steucnfdt, 
   steupstid LIKE steu_t.steupstid, 
   steupstid_desc LIKE type_t.chr80, 
   steupstdt LIKE steu_t.steupstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_stev_d        RECORD
       stevseq LIKE stev_t.stevseq, 
   stev001 LIKE stev_t.stev001, 
   stev002 LIKE stev_t.stev002, 
   stev003 LIKE stev_t.stev003, 
   stev004 LIKE stev_t.stev004, 
   stev024 LIKE stev_t.stev024, 
   stev024_desc LIKE type_t.chr500, 
   stev005 LIKE stev_t.stev005, 
   stev005_desc LIKE type_t.chr500, 
   stev006 LIKE stev_t.stev006, 
   stev007 LIKE stev_t.stev007, 
   stev008 LIKE stev_t.stev008, 
   stev008_desc LIKE type_t.chr500, 
   stev009 LIKE stev_t.stev009, 
   stev009_desc LIKE type_t.chr500, 
   stev010 LIKE stev_t.stev010, 
   stev011 LIKE stev_t.stev011, 
   stev012 LIKE stev_t.stev012, 
   stev013 LIKE stev_t.stev013, 
   stev014 LIKE stev_t.stev014, 
   stev015 LIKE stev_t.stev015, 
   stev016 LIKE stev_t.stev016, 
   stev028 LIKE stev_t.stev028, 
   stev029 LIKE stev_t.stev029, 
   stev018 LIKE stev_t.stev018, 
   stev017 LIKE stev_t.stev017, 
   stevsite LIKE stev_t.stevsite, 
   stevsite_desc LIKE type_t.chr500, 
   stev020 LIKE stev_t.stev020, 
   stev020_desc LIKE type_t.chr500, 
   stev019 LIKE stev_t.stev019, 
   stev019_desc LIKE type_t.chr500, 
   stev025 LIKE stev_t.stev025, 
   stev030 LIKE stev_t.stev030
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_steusite LIKE steu_t.steusite,
   b_steusite_desc LIKE type_t.chr80,
      b_steudocnt LIKE steu_t.steudocnt,
      b_steudocno LIKE steu_t.steudocno,
      b_steu001 LIKE steu_t.steu001,
      b_steu002 LIKE steu_t.steu002,
   b_steu002_desc LIKE type_t.chr80,
      b_steu003 LIKE steu_t.steu003,
   b_steu003_desc LIKE type_t.chr80,
      b_steu004 LIKE steu_t.steu004,
      b_steu005 LIKE steu_t.steu005,
      b_steu006 LIKE steu_t.steu006,
      b_steu007 LIKE steu_t.steu007,
      b_steu010 LIKE steu_t.steu010,
      b_steu008 LIKE steu_t.steu008,
      b_steu009 LIKE steu_t.steu009,
      b_steu011 LIKE steu_t.steu011,
      b_steu012 LIKE steu_t.steu012
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag      LIKE type_t.num5
DEFINE g_type           LIKE type_t.chr1   #'1'時代表是 astt550 '2'時代表是 astt350
DEFINE l_delete      LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_steu_m          type_g_steu_m
DEFINE g_steu_m_t        type_g_steu_m
DEFINE g_steu_m_o        type_g_steu_m
DEFINE g_steu_m_mask_o   type_g_steu_m #轉換遮罩前資料
DEFINE g_steu_m_mask_n   type_g_steu_m #轉換遮罩後資料
 
   DEFINE g_steudocno_t LIKE steu_t.steudocno
 
 
DEFINE g_stev_d          DYNAMIC ARRAY OF type_g_stev_d
DEFINE g_stev_d_t        type_g_stev_d
DEFINE g_stev_d_o        type_g_stev_d
DEFINE g_stev_d_mask_o   DYNAMIC ARRAY OF type_g_stev_d #轉換遮罩前資料
DEFINE g_stev_d_mask_n   DYNAMIC ARRAY OF type_g_stev_d #轉換遮罩後資料
 
 
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
 
{<section id="astt550.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:作業初始化 name="main.init"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_type = g_argv[1]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT steusite,'',steudocnt,steudocno,steu002,'',steu001,steu003,'',steu004, 
       steu005,'',steu006,steu007,steu010,steu000,steu008,steu009,steu011,steu012,steustus,steuownid, 
       '',steuowndp,'',steucrtid,'',steucrtdp,'',steucrtdt,steumodid,'',steumoddt,steucnfid,'',steucnfdt, 
       steupstid,'',steupstdt", 
                      " FROM steu_t",
                      " WHERE steuent= ? AND steudocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt550_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.steusite,t0.steudocnt,t0.steudocno,t0.steu002,t0.steu001,t0.steu003, 
       t0.steu004,t0.steu005,t0.steu006,t0.steu007,t0.steu010,t0.steu000,t0.steu008,t0.steu009,t0.steu011, 
       t0.steu012,t0.steustus,t0.steuownid,t0.steuowndp,t0.steucrtid,t0.steucrtdp,t0.steucrtdt,t0.steumodid, 
       t0.steumoddt,t0.steucnfid,t0.steucnfdt,t0.steupstid,t0.steupstdt,t1.ooefl003 ,t2.mhael023 ,t3.pmaal004 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011 ,t10.ooag011",
               " FROM steu_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.steusite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhael_t t2 ON t2.mhaelent="||g_enterprise||" AND t2.mhael001=t0.steu002 AND t2.mhael022='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.steu003 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.steuownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.steuowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.steucrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.steucrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.steumodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.steucnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.steupstid  ",
 
               " WHERE t0.steuent = " ||g_enterprise|| " AND t0.steudocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
 
   #end add-point
   PREPARE astt550_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astt550 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astt550_init()   
 
      #進入選單 Menu (="N")
      CALL astt550_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astt550
      
   END IF 
   
   CLOSE astt550_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astt550.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astt550_init()
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
      CALL cl_set_combo_scc_part('steustus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('steu004','6013') 
   CALL cl_set_combo_scc('stev001','6703') 
   CALL cl_set_combo_scc('stev010','6006') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   IF g_type = '1' THEN
      CALL cl_set_combo_scc_part('steu004','6013',"3,4,5")
      CALL cl_set_combo_scc_part('b_steu004','6013',"3,4,5")
   ELSE
      CALL cl_set_combo_scc_part('steu004','6013',"1")
      CALL cl_set_combo_scc_part('b_steu004','6013',"1")
   END IF
   CALL cl_set_combo_scc('steu008','6815')
   CALL cl_set_combo_scc('b_steu008','6815')
   CALL cl_set_combo_scc('stev001','6703')
   CALL cl_set_combo_scc('stev010','6006')
   CALL s_aooi500_create_temp() RETURNING l_success
   IF g_type='1' THEN
      CALL cl_set_comp_required("steu002",TRUE)
   ELSE
      CALL cl_set_comp_required("steu002",FALSE)    
   END IF
   #end add-point
   
   #初始化搜尋條件
   CALL astt550_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="astt550.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION astt550_ui_dialog()
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
   DEFINE  l_steu009    LIKE steu_t.steu009
   DEFINE l_success LIKE type_t.num5
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
            CALL astt550_insert()
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
         INITIALIZE g_steu_m.* TO NULL
         CALL g_stev_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL astt550_init()
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
               
               CALL astt550_fetch('') # reload data
               LET l_ac = 1
               CALL astt550_ui_detailshow() #Setting the current row 
         
               CALL astt550_idx_chk()
               #NEXT FIELD stevseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_stev_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt550_idx_chk()
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
               CALL astt550_idx_chk()
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
            CALL astt550_browser_fill("")
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
               CALL astt550_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL astt550_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL astt550_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
#            #是否启用交款汇总单为N,交款汇总单只能查询
#            IF cl_get_para(g_enterprise,g_site,"S-CIR-2012") = 'N' THEN
#               CALL cl_set_act_visible("insert,modify,delete,reproduce,modify_detail", FALSE)
#            END IF 
#            #add by geza 20150812(E)
# LANJJ MARK ON 2016年1月28日  不管控，全功能开放  顾问刘鑫  151214-00017#21
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL astt550_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL astt550_set_act_visible()   
            CALL astt550_set_act_no_visible()
            IF NOT (g_steu_m.steudocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " steuent = " ||g_enterprise|| " AND",
                                  " steudocno = '", g_steu_m.steudocno, "' "
 
               #填到對應位置
               CALL astt550_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "steu_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "stev_t" 
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
               CALL astt550_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "steu_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "stev_t" 
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
                  CALL astt550_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL astt550_fetch("F")
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
               CALL astt550_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL astt550_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt550_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL astt550_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt550_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL astt550_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt550_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL astt550_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt550_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL astt550_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt550_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_stev_d)
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
               NEXT FIELD stevseq
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
               CALL astt550_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL astt550_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL astt550_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL astt550_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION Batch_import
            LET g_action_choice="Batch_import"
            IF cl_auth_chk_act("Batch_import") THEN
               
               #add-point:ON ACTION Batch_import name="menu.Batch_import"
               #LANJJ ADD START
               CALL s_transaction_begin() 
               IF g_steu_m.steustus != 'X' AND g_steu_m.steustus != 'Y' THEN 
                  CALL s_astt550_detail_open_window(g_steu_m.steudocno,g_steu_m.steusite,g_steu_m.steudocnt,g_steu_m.steu002,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004) RETURNING l_success #LANJJ add ON 2016-01-29 
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG                  
                     END IF  
                  #汇总单身本次结算金额合计
                  INITIALIZE l_steu009 TO NULL
                  SELECT SUM(stev016*stev011) INTO l_steu009
                    FROM stev_t
                   WHERE stevent = g_enterprise
                     AND stevdocno = g_steu_m.steudocno  
                  IF l_steu009 IS NOT NULL THEN  
                     UPDATE steu_t SET steu009 = l_steu009  
                      WHERE steuent = g_enterprise AND steudocno = g_steu_m.steudocno
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = g_steu_m.steudocno 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = FALSE 
                         CALL cl_err()
                         CALL s_transaction_end('N','0')
                         CONTINUE DIALOG
                      END IF
                  END IF    
                  SELECT steu009 INTO  g_steu_m.steu009
                    FROM steu_t 
                   WHERE steuent = g_enterprise
                     AND steudocno = g_steu_m.steudocno
                  DISPLAY BY NAME  g_steu_m.steu009 
                  CALL astt550_b_fill()   
                  CALL s_transaction_end('Y','0') 
               END IF 
               #LANJJ ADD END
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " steuent = '",g_enterprise,"' AND steudocno = '",g_steu_m.steudocno,"' " 
               #END add-point
               &include "erp/ast/astt550_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " steuent = '",g_enterprise,"' AND steudocno = '",g_steu_m.steudocno,"' " 
               #END add-point
               &include "erp/ast/astt550_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL astt550_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL astt550_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL astt550_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL astt550_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL astt550_set_pk_array()
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
 
{<section id="astt550.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION astt550_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'steusite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   IF g_type='1' THEN
      LET l_wc=l_wc," AND steu000='1' " 
   ELSE
      LET l_wc=l_wc," AND steu000='2' " 
   END IF
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT steudocno ",
                      " FROM steu_t ",
                      " ",
                      " LEFT JOIN stev_t ON stevent = steuent AND steudocno = stevdocno ", "  ",
                      #add-point:browser_fill段sql(stev_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE steuent = " ||g_enterprise|| " AND stevent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("steu_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT steudocno ",
                      " FROM steu_t ", 
                      "  ",
                      "  ",
                      " WHERE steuent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("steu_t")
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
      INITIALIZE g_steu_m.* TO NULL
      CALL g_stev_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.steusite,t0.steudocnt,t0.steudocno,t0.steu001,t0.steu002,t0.steu003,t0.steu004,t0.steu005,t0.steu006,t0.steu007,t0.steu010,t0.steu008,t0.steu009,t0.steu011,t0.steu012 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.steustus,t0.steusite,t0.steudocnt,t0.steudocno,t0.steu001,t0.steu002, 
          t0.steu003,t0.steu004,t0.steu005,t0.steu006,t0.steu007,t0.steu010,t0.steu008,t0.steu009,t0.steu011, 
          t0.steu012,t1.ooefl003 ,t2.mhael023 ,t3.pmaal004 ",
                  " FROM steu_t t0",
                  "  ",
                  "  LEFT JOIN stev_t ON stevent = steuent AND steudocno = stevdocno ", "  ", 
                  #add-point:browser_fill段sql(stev_t1) name="browser_fill.join.stev_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.steusite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhael_t t2 ON t2.mhaelent="||g_enterprise||" AND t2.mhael001=t0.steu002 AND t2.mhael022='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.steu003 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.steuent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("steu_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.steustus,t0.steusite,t0.steudocnt,t0.steudocno,t0.steu001,t0.steu002, 
          t0.steu003,t0.steu004,t0.steu005,t0.steu006,t0.steu007,t0.steu010,t0.steu008,t0.steu009,t0.steu011, 
          t0.steu012,t1.ooefl003 ,t2.mhael023 ,t3.pmaal004 ",
                  " FROM steu_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.steusite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhael_t t2 ON t2.mhaelent="||g_enterprise||" AND t2.mhael001=t0.steu002 AND t2.mhael022='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.steu003 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.steuent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("steu_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY steudocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"steu_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_steusite,g_browser[g_cnt].b_steudocnt, 
          g_browser[g_cnt].b_steudocno,g_browser[g_cnt].b_steu001,g_browser[g_cnt].b_steu002,g_browser[g_cnt].b_steu003, 
          g_browser[g_cnt].b_steu004,g_browser[g_cnt].b_steu005,g_browser[g_cnt].b_steu006,g_browser[g_cnt].b_steu007, 
          g_browser[g_cnt].b_steu010,g_browser[g_cnt].b_steu008,g_browser[g_cnt].b_steu009,g_browser[g_cnt].b_steu011, 
          g_browser[g_cnt].b_steu012,g_browser[g_cnt].b_steusite_desc,g_browser[g_cnt].b_steu002_desc, 
          g_browser[g_cnt].b_steu003_desc
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
         CALL astt550_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_steudocno) THEN
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
 
{<section id="astt550.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION astt550_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_steu_m.steudocno = g_browser[g_current_idx].b_steudocno   
 
   EXECUTE astt550_master_referesh USING g_steu_m.steudocno INTO g_steu_m.steusite,g_steu_m.steudocnt, 
       g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005, 
       g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
       g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp,g_steu_m.steucrtid, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt,g_steu_m.steucnfid, 
       g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt,g_steu_m.steusite_desc,g_steu_m.steu002_desc, 
       g_steu_m.steu003_desc,g_steu_m.steuownid_desc,g_steu_m.steuowndp_desc,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp_desc,g_steu_m.steumodid_desc,g_steu_m.steucnfid_desc,g_steu_m.steupstid_desc 
 
   
   CALL astt550_steu_t_mask()
   CALL astt550_show()
      
END FUNCTION
 
{</section>}
 
{<section id="astt550.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION astt550_ui_detailshow()
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
 
{<section id="astt550.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION astt550_ui_browser_refresh()
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
      IF g_browser[l_i].b_steudocno = g_steu_m.steudocno 
 
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
 
{<section id="astt550.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt550_construct()
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
   INITIALIZE g_steu_m.* TO NULL
   CALL g_stev_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON steusite,steudocnt,steudocno,steu002,steu001,steu003,steu004,steu005, 
          steu006,steu007,steu010,steu000,steu008,steu009,steu011,steu012,steustus,steuownid,steuowndp, 
          steucrtid,steucrtdp,steucrtdt,steumodid,steumoddt,steucnfid,steucnfdt,steupstid,steupstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<steucrtdt>>----
         AFTER FIELD steucrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<steumoddt>>----
         AFTER FIELD steumoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<steucnfdt>>----
         AFTER FIELD steucnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<steupstdt>>----
         AFTER FIELD steupstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.steusite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steusite
            #add-point:ON ACTION controlp INFIELD steusite name="construct.c.steusite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'steusite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steusite  #顯示到畫面上
            NEXT FIELD steusite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steusite
            #add-point:BEFORE FIELD steusite name="construct.b.steusite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steusite
            
            #add-point:AFTER FIELD steusite name="construct.a.steusite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steudocnt
            #add-point:BEFORE FIELD steudocnt name="construct.b.steudocnt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steudocnt
            
            #add-point:AFTER FIELD steudocnt name="construct.a.steudocnt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steudocnt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steudocnt
            #add-point:ON ACTION controlp INFIELD steudocnt name="construct.c.steudocnt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steudocno
            #add-point:BEFORE FIELD steudocno name="construct.b.steudocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steudocno
            
            #add-point:AFTER FIELD steudocno name="construct.a.steudocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steudocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steudocno
            #add-point:ON ACTION controlp INFIELD steudocno name="construct.c.steudocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_type = '1' THEN
               LET g_qryparam.where = " steu000 = '1' "
            ELSE
               LET g_qryparam.where = " steu000 = '2' "
            END IF
            CALL q_steudocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steudocno  #顯示到畫面上
            NEXT FIELD steudocno 
            #END add-point
 
 
         #Ctrlp:construct.c.steu002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu002
            #add-point:ON ACTION controlp INFIELD steu002 name="construct.c.steu002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steu002  #顯示到畫面上
            NEXT FIELD steu002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu002
            #add-point:BEFORE FIELD steu002 name="construct.b.steu002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu002
            
            #add-point:AFTER FIELD steu002 name="construct.a.steu002"
            #Add by liaolong  150619-00007#16 2015/07/21 -- Begin --
            CALL astt550_steu002_init()
            #Add by liaolong  150619-00007#16 2015/07/21 -- End   --
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu001
            #add-point:ON ACTION controlp INFIELD steu001 name="construct.c.steu001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF g_type='1' THEN
               CALL q_stfa001()
            ELSE
               CALL q_stan001_3()   
            END IF                          
            DISPLAY g_qryparam.return1 TO steu001  #顯示到畫面上
            NEXT FIELD steu001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu001
            #add-point:BEFORE FIELD steu001 name="construct.b.steu001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu001
            
            #add-point:AFTER FIELD steu001 name="construct.a.steu001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu003
            #add-point:ON ACTION controlp INFIELD steu003 name="construct.c.steu003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steu003  #顯示到畫面上
            NEXT FIELD steu003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu003
            #add-point:BEFORE FIELD steu003 name="construct.b.steu003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu003
            
            #add-point:AFTER FIELD steu003 name="construct.a.steu003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu004
            #add-point:BEFORE FIELD steu004 name="construct.b.steu004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu004
            
            #add-point:AFTER FIELD steu004 name="construct.a.steu004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu004
            #add-point:ON ACTION controlp INFIELD steu004 name="construct.c.steu004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.steu005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu005
            #add-point:ON ACTION controlp INFIELD steu005 name="construct.c.steu005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_steu005_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steu005  #顯示到畫面上
            NEXT FIELD steu005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu005
            #add-point:BEFORE FIELD steu005 name="construct.b.steu005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu005
            
            #add-point:AFTER FIELD steu005 name="construct.a.steu005"
            #add by liaolong 150619-00007  #16 2015/07/27  --Begin--
            SELECT stfj004,stfj002,stfj003 INTO g_steu_m.stax004,g_steu_m.steu006,g_steu_m.steu007
              FROM stfj_t,steu_t
             WHERE stfjseq = g_steu_m.steu005
               AND stfjent = g_enterprise
               AND stfj001 = g_steu_m.steu001
            DISPLAY BY NAME g_steu_m.stax004
            DISPLAY BY NAME g_steu_m.steu006
            #add by liaolong 150619-00007  #16 2015/07/27  --End--
          DISPLAY BY NAME g_steu_m.steu007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu006
            #add-point:BEFORE FIELD steu006 name="construct.b.steu006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu006
            
            #add-point:AFTER FIELD steu006 name="construct.a.steu006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu006
            #add-point:ON ACTION controlp INFIELD steu006 name="construct.c.steu006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu007
            #add-point:BEFORE FIELD steu007 name="construct.b.steu007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu007
            
            #add-point:AFTER FIELD steu007 name="construct.a.steu007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu007
            #add-point:ON ACTION controlp INFIELD steu007 name="construct.c.steu007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu010
            #add-point:BEFORE FIELD steu010 name="construct.b.steu010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu010
            
            #add-point:AFTER FIELD steu010 name="construct.a.steu010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu010
            #add-point:ON ACTION controlp INFIELD steu010 name="construct.c.steu010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu000
            #add-point:BEFORE FIELD steu000 name="construct.b.steu000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu000
            
            #add-point:AFTER FIELD steu000 name="construct.a.steu000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu000
            #add-point:ON ACTION controlp INFIELD steu000 name="construct.c.steu000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu008
            #add-point:BEFORE FIELD steu008 name="construct.b.steu008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu008
            
            #add-point:AFTER FIELD steu008 name="construct.a.steu008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu008
            #add-point:ON ACTION controlp INFIELD steu008 name="construct.c.steu008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu009
            #add-point:BEFORE FIELD steu009 name="construct.b.steu009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu009
            
            #add-point:AFTER FIELD steu009 name="construct.a.steu009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu009
            #add-point:ON ACTION controlp INFIELD steu009 name="construct.c.steu009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu011
            #add-point:BEFORE FIELD steu011 name="construct.b.steu011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu011
            
            #add-point:AFTER FIELD steu011 name="construct.a.steu011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu011
            #add-point:ON ACTION controlp INFIELD steu011 name="construct.c.steu011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu012
            #add-point:BEFORE FIELD steu012 name="construct.b.steu012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu012
            
            #add-point:AFTER FIELD steu012 name="construct.a.steu012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steu012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu012
            #add-point:ON ACTION controlp INFIELD steu012 name="construct.c.steu012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steustus
            #add-point:BEFORE FIELD steustus name="construct.b.steustus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steustus
            
            #add-point:AFTER FIELD steustus name="construct.a.steustus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steustus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steustus
            #add-point:ON ACTION controlp INFIELD steustus name="construct.c.steustus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.steuownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steuownid
            #add-point:ON ACTION controlp INFIELD steuownid name="construct.c.steuownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steuownid  #顯示到畫面上
            NEXT FIELD steuownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steuownid
            #add-point:BEFORE FIELD steuownid name="construct.b.steuownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steuownid
            
            #add-point:AFTER FIELD steuownid name="construct.a.steuownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steuowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steuowndp
            #add-point:ON ACTION controlp INFIELD steuowndp name="construct.c.steuowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steuowndp  #顯示到畫面上
            NEXT FIELD steuowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steuowndp
            #add-point:BEFORE FIELD steuowndp name="construct.b.steuowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steuowndp
            
            #add-point:AFTER FIELD steuowndp name="construct.a.steuowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steucrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steucrtid
            #add-point:ON ACTION controlp INFIELD steucrtid name="construct.c.steucrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steucrtid  #顯示到畫面上
            NEXT FIELD steucrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steucrtid
            #add-point:BEFORE FIELD steucrtid name="construct.b.steucrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steucrtid
            
            #add-point:AFTER FIELD steucrtid name="construct.a.steucrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.steucrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steucrtdp
            #add-point:ON ACTION controlp INFIELD steucrtdp name="construct.c.steucrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steucrtdp  #顯示到畫面上
            NEXT FIELD steucrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steucrtdp
            #add-point:BEFORE FIELD steucrtdp name="construct.b.steucrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steucrtdp
            
            #add-point:AFTER FIELD steucrtdp name="construct.a.steucrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steucrtdt
            #add-point:BEFORE FIELD steucrtdt name="construct.b.steucrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.steumodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steumodid
            #add-point:ON ACTION controlp INFIELD steumodid name="construct.c.steumodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steumodid  #顯示到畫面上
            NEXT FIELD steumodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steumodid
            #add-point:BEFORE FIELD steumodid name="construct.b.steumodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steumodid
            
            #add-point:AFTER FIELD steumodid name="construct.a.steumodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steumoddt
            #add-point:BEFORE FIELD steumoddt name="construct.b.steumoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.steucnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steucnfid
            #add-point:ON ACTION controlp INFIELD steucnfid name="construct.c.steucnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steucnfid  #顯示到畫面上
            NEXT FIELD steucnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steucnfid
            #add-point:BEFORE FIELD steucnfid name="construct.b.steucnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steucnfid
            
            #add-point:AFTER FIELD steucnfid name="construct.a.steucnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steucnfdt
            #add-point:BEFORE FIELD steucnfdt name="construct.b.steucnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.steupstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steupstid
            #add-point:ON ACTION controlp INFIELD steupstid name="construct.c.steupstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steupstid  #顯示到畫面上
            NEXT FIELD steupstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steupstid
            #add-point:BEFORE FIELD steupstid name="construct.b.steupstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steupstid
            
            #add-point:AFTER FIELD steupstid name="construct.a.steupstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steupstdt
            #add-point:BEFORE FIELD steupstdt name="construct.b.steupstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON stevseq,stev001,stev002,stev003,stev004,stev024,stev005,stev006,stev007, 
          stev008,stev009,stev009_desc,stev010,stev011,stev012,stev013,stev014,stev015,stev016,stev028, 
          stev029,stev018,stev017,stevsite,stev020,stev019,stev025,stev030
           FROM s_detail1[1].stevseq,s_detail1[1].stev001,s_detail1[1].stev002,s_detail1[1].stev003, 
               s_detail1[1].stev004,s_detail1[1].stev024,s_detail1[1].stev005,s_detail1[1].stev006,s_detail1[1].stev007, 
               s_detail1[1].stev008,s_detail1[1].stev009,s_detail1[1].stev009_desc,s_detail1[1].stev010, 
               s_detail1[1].stev011,s_detail1[1].stev012,s_detail1[1].stev013,s_detail1[1].stev014,s_detail1[1].stev015, 
               s_detail1[1].stev016,s_detail1[1].stev028,s_detail1[1].stev029,s_detail1[1].stev018,s_detail1[1].stev017, 
               s_detail1[1].stevsite,s_detail1[1].stev020,s_detail1[1].stev019,s_detail1[1].stev025, 
               s_detail1[1].stev030
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stevseq
            #add-point:BEFORE FIELD stevseq name="construct.b.page1.stevseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stevseq
            
            #add-point:AFTER FIELD stevseq name="construct.a.page1.stevseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stevseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stevseq
            #add-point:ON ACTION controlp INFIELD stevseq name="construct.c.page1.stevseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev001
            #add-point:BEFORE FIELD stev001 name="construct.b.page1.stev001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev001
            
            #add-point:AFTER FIELD stev001 name="construct.a.page1.stev001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev001
            #add-point:ON ACTION controlp INFIELD stev001 name="construct.c.page1.stev001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stev002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev002
            #add-point:ON ACTION controlp INFIELD stev002 name="construct.c.page1.stev002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stbc004_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev002  #顯示到畫面上
            NEXT FIELD stev002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev002
            #add-point:BEFORE FIELD stev002 name="construct.b.page1.stev002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev002
            
            #add-point:AFTER FIELD stev002 name="construct.a.page1.stev002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev003
            #add-point:BEFORE FIELD stev003 name="construct.b.page1.stev003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev003
            
            #add-point:AFTER FIELD stev003 name="construct.a.page1.stev003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev003
            #add-point:ON ACTION controlp INFIELD stev003 name="construct.c.page1.stev003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev004
            #add-point:BEFORE FIELD stev004 name="construct.b.page1.stev004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev004
            
            #add-point:AFTER FIELD stev004 name="construct.a.page1.stev004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev004
            #add-point:ON ACTION controlp INFIELD stev004 name="construct.c.page1.stev004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stev024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev024
            #add-point:ON ACTION controlp INFIELD stev024 name="construct.c.page1.stev024"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev024  #顯示到畫面上
            NEXT FIELD stev024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev024
            #add-point:BEFORE FIELD stev024 name="construct.b.page1.stev024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev024
            
            #add-point:AFTER FIELD stev024 name="construct.a.page1.stev024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev005
            #add-point:ON ACTION controlp INFIELD stev005 name="construct.c.page1.stev005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev005  #顯示到畫面上
            NEXT FIELD stev005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev005
            #add-point:BEFORE FIELD stev005 name="construct.b.page1.stev005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev005
            
            #add-point:AFTER FIELD stev005 name="construct.a.page1.stev005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev006
            #add-point:BEFORE FIELD stev006 name="construct.b.page1.stev006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev006
            
            #add-point:AFTER FIELD stev006 name="construct.a.page1.stev006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev006
            #add-point:ON ACTION controlp INFIELD stev006 name="construct.c.page1.stev006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev007
            #add-point:BEFORE FIELD stev007 name="construct.b.page1.stev007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev007
            
            #add-point:AFTER FIELD stev007 name="construct.a.page1.stev007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev007
            #add-point:ON ACTION controlp INFIELD stev007 name="construct.c.page1.stev007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stev008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev008
            #add-point:ON ACTION controlp INFIELD stev008 name="construct.c.page1.stev008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev008  #顯示到畫面上
            NEXT FIELD stev008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev008
            #add-point:BEFORE FIELD stev008 name="construct.b.page1.stev008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev008
            
            #add-point:AFTER FIELD stev008 name="construct.a.page1.stev008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev009
            #add-point:ON ACTION controlp INFIELD stev009 name="construct.c.page1.stev009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev009  #顯示到畫面上
            NEXT FIELD stev009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev009
            #add-point:BEFORE FIELD stev009 name="construct.b.page1.stev009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev009
            
            #add-point:AFTER FIELD stev009 name="construct.a.page1.stev009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev009_desc
            #add-point:BEFORE FIELD stev009_desc name="construct.b.page1.stev009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev009_desc
            
            #add-point:AFTER FIELD stev009_desc name="construct.a.page1.stev009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev009_desc
            #add-point:ON ACTION controlp INFIELD stev009_desc name="construct.c.page1.stev009_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev010
            #add-point:BEFORE FIELD stev010 name="construct.b.page1.stev010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev010
            
            #add-point:AFTER FIELD stev010 name="construct.a.page1.stev010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev010
            #add-point:ON ACTION controlp INFIELD stev010 name="construct.c.page1.stev010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev011
            #add-point:BEFORE FIELD stev011 name="construct.b.page1.stev011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev011
            
            #add-point:AFTER FIELD stev011 name="construct.a.page1.stev011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev011
            #add-point:ON ACTION controlp INFIELD stev011 name="construct.c.page1.stev011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev012
            #add-point:BEFORE FIELD stev012 name="construct.b.page1.stev012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev012
            
            #add-point:AFTER FIELD stev012 name="construct.a.page1.stev012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev012
            #add-point:ON ACTION controlp INFIELD stev012 name="construct.c.page1.stev012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev013
            #add-point:BEFORE FIELD stev013 name="construct.b.page1.stev013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev013
            
            #add-point:AFTER FIELD stev013 name="construct.a.page1.stev013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev013
            #add-point:ON ACTION controlp INFIELD stev013 name="construct.c.page1.stev013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev014
            #add-point:BEFORE FIELD stev014 name="construct.b.page1.stev014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev014
            
            #add-point:AFTER FIELD stev014 name="construct.a.page1.stev014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev014
            #add-point:ON ACTION controlp INFIELD stev014 name="construct.c.page1.stev014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev015
            #add-point:BEFORE FIELD stev015 name="construct.b.page1.stev015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev015
            
            #add-point:AFTER FIELD stev015 name="construct.a.page1.stev015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev015
            #add-point:ON ACTION controlp INFIELD stev015 name="construct.c.page1.stev015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev016
            #add-point:BEFORE FIELD stev016 name="construct.b.page1.stev016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev016
            
            #add-point:AFTER FIELD stev016 name="construct.a.page1.stev016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev016
            #add-point:ON ACTION controlp INFIELD stev016 name="construct.c.page1.stev016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev028
            #add-point:BEFORE FIELD stev028 name="construct.b.page1.stev028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev028
            
            #add-point:AFTER FIELD stev028 name="construct.a.page1.stev028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev028
            #add-point:ON ACTION controlp INFIELD stev028 name="construct.c.page1.stev028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev029
            #add-point:BEFORE FIELD stev029 name="construct.b.page1.stev029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev029
            
            #add-point:AFTER FIELD stev029 name="construct.a.page1.stev029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev029
            #add-point:ON ACTION controlp INFIELD stev029 name="construct.c.page1.stev029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stev018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev018
            #add-point:ON ACTION controlp INFIELD stev018 name="construct.c.page1.stev018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2060'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev018  #顯示到畫面上
            NEXT FIELD stev018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev018
            #add-point:BEFORE FIELD stev018 name="construct.b.page1.stev018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev018
            
            #add-point:AFTER FIELD stev018 name="construct.a.page1.stev018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev017
            #add-point:ON ACTION controlp INFIELD stev017 name="construct.c.page1.stev017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev017  #顯示到畫面上
            NEXT FIELD stev017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev017
            #add-point:BEFORE FIELD stev017 name="construct.b.page1.stev017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev017
            
            #add-point:AFTER FIELD stev017 name="construct.a.page1.stev017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stevsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stevsite
            #add-point:ON ACTION controlp INFIELD stevsite name="construct.c.page1.stevsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stevsite  #顯示到畫面上
            NEXT FIELD stevsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stevsite
            #add-point:BEFORE FIELD stevsite name="construct.b.page1.stevsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stevsite
            
            #add-point:AFTER FIELD stevsite name="construct.a.page1.stevsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev020
            #add-point:ON ACTION controlp INFIELD stev020 name="construct.c.page1.stev020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev020  #顯示到畫面上
            NEXT FIELD stev020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev020
            #add-point:BEFORE FIELD stev020 name="construct.b.page1.stev020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev020
            
            #add-point:AFTER FIELD stev020 name="construct.a.page1.stev020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev019
            #add-point:ON ACTION controlp INFIELD stev019 name="construct.c.page1.stev019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stev019  #顯示到畫面上
            NEXT FIELD stev019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev019
            #add-point:BEFORE FIELD stev019 name="construct.b.page1.stev019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev019
            
            #add-point:AFTER FIELD stev019 name="construct.a.page1.stev019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev025
            #add-point:BEFORE FIELD stev025 name="construct.b.page1.stev025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev025
            
            #add-point:AFTER FIELD stev025 name="construct.a.page1.stev025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev025
            #add-point:ON ACTION controlp INFIELD stev025 name="construct.c.page1.stev025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev030
            #add-point:BEFORE FIELD stev030 name="construct.b.page1.stev030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev030
            
            #add-point:AFTER FIELD stev030 name="construct.a.page1.stev030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stev030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev030
            #add-point:ON ACTION controlp INFIELD stev030 name="construct.c.page1.stev030"
            
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
                  WHEN la_wc[li_idx].tableid = "steu_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "stev_t" 
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
 
{<section id="astt550.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION astt550_filter()
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
      CONSTRUCT g_wc_filter ON steusite,steudocnt,steudocno,steu001,steu002,steu003,steu004,steu005, 
          steu006,steu007,steu010,steu008,steu009,steu011,steu012
                          FROM s_browse[1].b_steusite,s_browse[1].b_steudocnt,s_browse[1].b_steudocno, 
                              s_browse[1].b_steu001,s_browse[1].b_steu002,s_browse[1].b_steu003,s_browse[1].b_steu004, 
                              s_browse[1].b_steu005,s_browse[1].b_steu006,s_browse[1].b_steu007,s_browse[1].b_steu010, 
                              s_browse[1].b_steu008,s_browse[1].b_steu009,s_browse[1].b_steu011,s_browse[1].b_steu012 
 
 
         BEFORE CONSTRUCT
               DISPLAY astt550_filter_parser('steusite') TO s_browse[1].b_steusite
            DISPLAY astt550_filter_parser('steudocnt') TO s_browse[1].b_steudocnt
            DISPLAY astt550_filter_parser('steudocno') TO s_browse[1].b_steudocno
            DISPLAY astt550_filter_parser('steu001') TO s_browse[1].b_steu001
            DISPLAY astt550_filter_parser('steu002') TO s_browse[1].b_steu002
            DISPLAY astt550_filter_parser('steu003') TO s_browse[1].b_steu003
            DISPLAY astt550_filter_parser('steu004') TO s_browse[1].b_steu004
            DISPLAY astt550_filter_parser('steu005') TO s_browse[1].b_steu005
            DISPLAY astt550_filter_parser('steu006') TO s_browse[1].b_steu006
            DISPLAY astt550_filter_parser('steu007') TO s_browse[1].b_steu007
            DISPLAY astt550_filter_parser('steu010') TO s_browse[1].b_steu010
            DISPLAY astt550_filter_parser('steu008') TO s_browse[1].b_steu008
            DISPLAY astt550_filter_parser('steu009') TO s_browse[1].b_steu009
            DISPLAY astt550_filter_parser('steu011') TO s_browse[1].b_steu011
            DISPLAY astt550_filter_parser('steu012') TO s_browse[1].b_steu012
      
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
 
      CALL astt550_filter_show('steusite')
   CALL astt550_filter_show('steudocnt')
   CALL astt550_filter_show('steudocno')
   CALL astt550_filter_show('steu001')
   CALL astt550_filter_show('steu002')
   CALL astt550_filter_show('steu003')
   CALL astt550_filter_show('steu004')
   CALL astt550_filter_show('steu005')
   CALL astt550_filter_show('steu006')
   CALL astt550_filter_show('steu007')
   CALL astt550_filter_show('steu010')
   CALL astt550_filter_show('steu008')
   CALL astt550_filter_show('steu009')
   CALL astt550_filter_show('steu011')
   CALL astt550_filter_show('steu012')
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION astt550_filter_parser(ps_field)
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
 
{<section id="astt550.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION astt550_filter_show(ps_field)
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
   LET ls_condition = astt550_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION astt550_query()
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
   CALL g_stev_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL astt550_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL astt550_browser_fill("")
      CALL astt550_fetch("")
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
      CALL astt550_filter_show('steusite')
   CALL astt550_filter_show('steudocnt')
   CALL astt550_filter_show('steudocno')
   CALL astt550_filter_show('steu001')
   CALL astt550_filter_show('steu002')
   CALL astt550_filter_show('steu003')
   CALL astt550_filter_show('steu004')
   CALL astt550_filter_show('steu005')
   CALL astt550_filter_show('steu006')
   CALL astt550_filter_show('steu007')
   CALL astt550_filter_show('steu010')
   CALL astt550_filter_show('steu008')
   CALL astt550_filter_show('steu009')
   CALL astt550_filter_show('steu011')
   CALL astt550_filter_show('steu012')
   CALL astt550_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL astt550_fetch("F") 
      #顯示單身筆數
      CALL astt550_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION astt550_fetch(p_flag)
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
   
   LET g_steu_m.steudocno = g_browser[g_current_idx].b_steudocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE astt550_master_referesh USING g_steu_m.steudocno INTO g_steu_m.steusite,g_steu_m.steudocnt, 
       g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005, 
       g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
       g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp,g_steu_m.steucrtid, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt,g_steu_m.steucnfid, 
       g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt,g_steu_m.steusite_desc,g_steu_m.steu002_desc, 
       g_steu_m.steu003_desc,g_steu_m.steuownid_desc,g_steu_m.steuowndp_desc,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp_desc,g_steu_m.steumodid_desc,g_steu_m.steucnfid_desc,g_steu_m.steupstid_desc 
 
   
   #遮罩相關處理
   LET g_steu_m_mask_o.* =  g_steu_m.*
   CALL astt550_steu_t_mask()
   LET g_steu_m_mask_n.* =  g_steu_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt550_set_act_visible()   
   CALL astt550_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_steu_m_t.* = g_steu_m.*
   LET g_steu_m_o.* = g_steu_m.*
   
   LET g_data_owner = g_steu_m.steuownid      
   LET g_data_dept  = g_steu_m.steuowndp
   
   #重新顯示   
   CALL astt550_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.insert" >}
#+ 資料新增
PRIVATE FUNCTION astt550_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_insert       LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5 
   DEFINE l_success  LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_stev_d.clear()   
 
 
   INITIALIZE g_steu_m.* TO NULL             #DEFAULT 設定
   
   LET g_steudocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_steu_m.steuownid = g_user
      LET g_steu_m.steuowndp = g_dept
      LET g_steu_m.steucrtid = g_user
      LET g_steu_m.steucrtdp = g_dept 
      LET g_steu_m.steucrtdt = cl_get_current()
      LET g_steu_m.steumodid = g_user
      LET g_steu_m.steumoddt = cl_get_current()
      LET g_steu_m.steustus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_steu_m.steu010 = "Y"
      LET g_steu_m.steu008 = "1"
      LET g_steu_m.steu009 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'steusite',g_steu_m.steusite) RETURNING r_insert,g_steu_m.steusite
      IF NOT r_insert THEN
         RETURN 
      END IF
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_steu_m.steusite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_steu_m.steusite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_steu_m.steusite_desc
      LET g_steu_m.steudocnt=g_today
      #单据别
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_steu_m.steusite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_steu_m.steudocno = l_doctype
      IF g_type = '1' THEN
         LET g_steu_m.steu000= '1'
      ELSE
         LET g_steu_m.steu000= '2'
      END IF
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_steu_m_t.* = g_steu_m.*
      LET g_steu_m_o.* = g_steu_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_steu_m.steustus 
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
 
 
 
    
      CALL astt550_input("a")
      
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
         INITIALIZE g_steu_m.* TO NULL
         INITIALIZE g_stev_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL astt550_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_stev_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt550_set_act_visible()   
   CALL astt550_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_steudocno_t = g_steu_m.steudocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " steuent = " ||g_enterprise|| " AND",
                      " steudocno = '", g_steu_m.steudocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL astt550_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE astt550_cl
   
   CALL astt550_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE astt550_master_referesh USING g_steu_m.steudocno INTO g_steu_m.steusite,g_steu_m.steudocnt, 
       g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005, 
       g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
       g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp,g_steu_m.steucrtid, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt,g_steu_m.steucnfid, 
       g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt,g_steu_m.steusite_desc,g_steu_m.steu002_desc, 
       g_steu_m.steu003_desc,g_steu_m.steuownid_desc,g_steu_m.steuowndp_desc,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp_desc,g_steu_m.steumodid_desc,g_steu_m.steucnfid_desc,g_steu_m.steupstid_desc 
 
   
   
   #遮罩相關處理
   LET g_steu_m_mask_o.* =  g_steu_m.*
   CALL astt550_steu_t_mask()
   LET g_steu_m_mask_n.* =  g_steu_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_steu_m.steusite,g_steu_m.steusite_desc,g_steu_m.steudocnt,g_steu_m.steudocno,g_steu_m.steu002, 
       g_steu_m.steu002_desc,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu003_desc,g_steu_m.steu004, 
       g_steu_m.steu005,g_steu_m.stax004,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000, 
       g_steu_m.steu008,g_steu_m.steu009,g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid, 
       g_steu_m.steuownid_desc,g_steu_m.steuowndp,g_steu_m.steuowndp_desc,g_steu_m.steucrtid,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdp_desc,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumodid_desc, 
       g_steu_m.steumoddt,g_steu_m.steucnfid,g_steu_m.steucnfid_desc,g_steu_m.steucnfdt,g_steu_m.steupstid, 
       g_steu_m.steupstid_desc,g_steu_m.steupstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_steu_m.steuownid      
   LET g_data_dept  = g_steu_m.steuowndp
   
   #功能已完成,通報訊息中心
   CALL astt550_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="astt550.modify" >}
#+ 資料修改
PRIVATE FUNCTION astt550_modify()
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
   LET g_steu_m_t.* = g_steu_m.*
   LET g_steu_m_o.* = g_steu_m.*
   
   IF g_steu_m.steudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_steudocno_t = g_steu_m.steudocno
 
   CALL s_transaction_begin()
   
   OPEN astt550_cl USING g_enterprise,g_steu_m.steudocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt550_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE astt550_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE astt550_master_referesh USING g_steu_m.steudocno INTO g_steu_m.steusite,g_steu_m.steudocnt, 
       g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005, 
       g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
       g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp,g_steu_m.steucrtid, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt,g_steu_m.steucnfid, 
       g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt,g_steu_m.steusite_desc,g_steu_m.steu002_desc, 
       g_steu_m.steu003_desc,g_steu_m.steuownid_desc,g_steu_m.steuowndp_desc,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp_desc,g_steu_m.steumodid_desc,g_steu_m.steucnfid_desc,g_steu_m.steupstid_desc 
 
   
   #檢查是否允許此動作
   IF NOT astt550_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_steu_m_mask_o.* =  g_steu_m.*
   CALL astt550_steu_t_mask()
   LET g_steu_m_mask_n.* =  g_steu_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL astt550_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_steudocno_t = g_steu_m.steudocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_steu_m.steumodid = g_user 
LET g_steu_m.steumoddt = cl_get_current()
LET g_steu_m.steumodid_desc = cl_get_username(g_steu_m.steumodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL astt550_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE steu_t SET (steumodid,steumoddt) = (g_steu_m.steumodid,g_steu_m.steumoddt)
          WHERE steuent = g_enterprise AND steudocno = g_steudocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_steu_m.* = g_steu_m_t.*
            CALL astt550_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_steu_m.steudocno != g_steu_m_t.steudocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE stev_t SET stevdocno = g_steu_m.steudocno
 
          WHERE stevent = g_enterprise AND stevdocno = g_steu_m_t.steudocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "stev_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stev_t:",SQLERRMESSAGE 
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
   CALL astt550_set_act_visible()   
   CALL astt550_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " steuent = " ||g_enterprise|| " AND",
                      " steudocno = '", g_steu_m.steudocno, "' "
 
   #填到對應位置
   CALL astt550_browser_fill("")
 
   CLOSE astt550_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL astt550_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="astt550.input" >}
#+ 資料輸入
PRIVATE FUNCTION astt550_input(p_cmd)
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
   DEFINE  l_errno               STRING
   DEFINE  l_ooef004    LIKE ooef_t.ooef004
   DEFINE  l_steu009    LIKE steu_t.steu009
   DEFINE  l_steu000    LIKE steu_t.steu000
   DEFINE  p_success    LIKE type_t.num5
   DEFINE  l_stevseq    LIKE stev_t.stevseq  
   #add by geze 20150810(S)
   DEFINE l_stbc018     LIKE stbc_t.stbc018
   DEFINE l_stbc019     LIKE stbc_t.stbc019
   DEFINE l_stbcstus    LIKE stbc_t.stbcstus
   #add by geze 20150810(E)   
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
   DISPLAY BY NAME g_steu_m.steusite,g_steu_m.steusite_desc,g_steu_m.steudocnt,g_steu_m.steudocno,g_steu_m.steu002, 
       g_steu_m.steu002_desc,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu003_desc,g_steu_m.steu004, 
       g_steu_m.steu005,g_steu_m.stax004,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000, 
       g_steu_m.steu008,g_steu_m.steu009,g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid, 
       g_steu_m.steuownid_desc,g_steu_m.steuowndp,g_steu_m.steuowndp_desc,g_steu_m.steucrtid,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdp_desc,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumodid_desc, 
       g_steu_m.steumoddt,g_steu_m.steucnfid,g_steu_m.steucnfid_desc,g_steu_m.steucnfdt,g_steu_m.steupstid, 
       g_steu_m.steupstid_desc,g_steu_m.steupstdt
   
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
   LET g_forupd_sql = "SELECT stevseq,stev001,stev002,stev003,stev004,stev024,stev005,stev006,stev007, 
       stev008,stev009,stev010,stev011,stev012,stev013,stev014,stev015,stev016,stev028,stev029,stev018, 
       stev017,stevsite,stev020,stev019,stev025,stev030 FROM stev_t WHERE stevent=? AND stevdocno=?  
       AND stevseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt550_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL astt550_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL astt550_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_steu_m.steusite,g_steu_m.steudocnt,g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001, 
       g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010, 
       g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009,g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="astt550.input.head" >}
      #單頭段
      INPUT BY NAME g_steu_m.steusite,g_steu_m.steudocnt,g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001, 
          g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010, 
          g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009,g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN astt550_cl USING g_enterprise,g_steu_m.steudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt550_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt550_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL astt550_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL astt550_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steusite
            
            #add-point:AFTER FIELD steusite name="input.a.steusite"
            IF  NOT cl_null(g_steu_m.steusite) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_steu_m.steusite != g_steu_m_t.steusite )) THEN 
                  CALL s_aooi500_chk(g_prog,'steusite',g_steu_m.steusite,g_steu_m.steusite)
                   RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_steu_m.steusite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     LET g_steu_m.steusite = g_steu_m_t.steusite
                     NEXT FIELD CURRENT
                  END IF
                   LET g_site_flag = TRUE
                   CALL astt550_set_entry(p_cmd)
                   CALL astt550_set_no_entry(p_cmd)
               END IF
                IF NOT cl_null(g_steu_m.steudocnt) THEN
                     CALL s_asti206_check(g_steu_m.steusite,g_steu_m.steudocnt,g_prog) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = l_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_steu_m.steusite = g_steu_m_t.steusite
                        NEXT FIELD CURRENT
                     END IF
               END IF
               
            END IF     
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_steu_m.steusite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_steu_m.steusite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_steu_m.steusite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steusite
            #add-point:BEFORE FIELD steusite name="input.b.steusite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steusite
            #add-point:ON CHANGE steusite name="input.g.steusite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steudocnt
            #add-point:BEFORE FIELD steudocnt name="input.b.steudocnt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steudocnt
            
            #add-point:AFTER FIELD steudocnt name="input.a.steudocnt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steudocnt
            #add-point:ON CHANGE steudocnt name="input.g.steudocnt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steudocno
            #add-point:BEFORE FIELD steudocno name="input.b.steudocno"
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_steu_m.steusite
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steudocno
            
            #add-point:AFTER FIELD steudocno name="input.a.steudocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_steu_m.steudocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_steu_m.steudocno != g_steudocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM steu_t WHERE "||"steuent = '" ||g_enterprise|| "' AND "||"steudocno = '"||g_steu_m.steudocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT s_aooi200_chk_slip(g_steu_m.steusite,'',g_steu_m.steudocno,g_prog) THEN
                  LET g_steu_m.steudocno = g_steudocno_t
                  NEXT FIELD CURRENT   
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steudocno
            #add-point:ON CHANGE steudocno name="input.g.steudocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu002
            
            #add-point:AFTER FIELD steu002 name="input.a.steu002"
            #Add by liaolong  150619-00007#16 2015/07/21 -- Begin --
            #CALL astt550_steu002_init()      #mark by geza 20150810    
            #Add by liaolong  150619-00007#16 2015/07/21 -- End   --                                            
            IF NOT cl_null(g_steu_m.steu002) THEN 
               IF g_steu_m.steu002 <> g_steu_m_o.steu002 OR cl_null(g_steu_m_o.steu002) THEN   #160824-00007#192 161120 by lori add
                  #應用 a17 樣板自動產生(Version:2)
                  #欄位存在檢查
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_steu_m.steu002
                  
                  IF cl_chk_exist("v_mhae001") THEN
                     #檢查成功時後續處理
                     IF g_type = '1' THEN
                           IF NOT astt550_steu002_chk(p_cmd) THEN   #add by geza 20150605
                              LET g_steu_m.steu002 = g_steu_m_o.steu002   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu002->g_steu_m_o.steu002
                              CALL astt550_steu002_ref()
                              NEXT FIELD CURRENT
                           END IF
                     ELSE
                        IF NOT cl_null(g_steu_m.steusite) THEN
                           LET l_cnt = 0
                           SELECT COUNT(*) INTO l_cnt 
                             FROM mhae_t
                            WHERE mhae001 =  g_steu_m.steu002
                              AND mhaeent =  g_enterprise
                              AND mhaesite = g_steu_m.steusite
                           IF l_cnt = 0 THEN 
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.extend = ''
                              LET g_errparam.code   = 'amh-00065'
                              LET g_errparam.popup  = TRUE
                              CALL cl_err()
                              LET g_steu_m.steu002 = g_steu_m_o.steu002   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu002->g_steu_m_o.steu002
                              NEXT FIELD CURRENT
                           END IF
                        END IF   
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_steu_m.steu002 = g_steu_m_o.steu002   #160824-00007#192 161120 by lori add
                     DISPLAY BY NAME g_steu_m.steu002            #160824-00007#192 161120 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  CALL astt550_steu002_init()    #add by geza 20150810
                  CALL astt550_steu001_other()   #add by geza 20150810
                  #add by geza 20150810
                  IF NOT astt550_steu003_chk(p_cmd) THEN
                     LET g_steu_m.steu001 = g_steu_m_o.steu001   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu001->g_steu_m_o.steu002
                     LET g_steu_m.steu003 = g_steu_m_o.steu003   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu003->g_steu_m_o.steu002
                     CALL astt550_steu003_ref()                                                                   
                     LET g_steu_m.steu002 = g_steu_m_o.steu002   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu002->g_steu_m_o.steu002
                     CALL astt550_steu002_ref()                                                                   
                     LET g_steu_m.steu004 = g_steu_m_o.steu004   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu004->g_steu_m_o.steu002
                     LET g_steu_m.steu005 = g_steu_m_o.steu005   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu005->g_steu_m_o.steu002
                     LET g_steu_m.steu006 = g_steu_m_o.steu006   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu006->g_steu_m_o.steu002
                     LET g_steu_m.steu007 = g_steu_m_o.steu007   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu007->g_steu_m_o.steu002
                     LET g_steu_m.stax004 = g_steu_m_o.stax004   #160824-00007#192 161120 by lori mod:g_steu_m_t.stax004->g_steu_m_o.steu002
                     DISPLAY BY NAME g_steu_m.stax004
                     NEXT FIELD CURRENT
                  END IF
                  #add by geza 20150810
               END IF   #160824-00007#192 161120 by lori add   
            END IF
            
           #LET g_steu_m_t.steu002 = g_steu_m.steu002    #160824-00007#192 161120 by lori mark
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_steu_m.steu002
            CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_steu_m.steu002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_steu_m.steu002_desc

            LET g_steu_m_o.* = g_steu_m.*   #160824-00007#192 161120 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu002
            #add-point:BEFORE FIELD steu002 name="input.b.steu002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu002
            #add-point:ON CHANGE steu002 name="input.g.steu002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu001
            #add-point:BEFORE FIELD steu001 name="input.b.steu001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu001
            
            #add-point:AFTER FIELD steu001 name="input.a.steu001"
            IF  NOT cl_null(g_steu_m.steu001) THEN 
              #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_steu_m.steu001 != g_steu_m_t.steu001)) THEN    #160824-00007#192 161120 by lori mark
               IF g_steu_m.steu001 != g_steu_m_o.steu001 OR cl_null(g_steu_m_o.steu001) THEN         #160824-00007#192 161120 by lori add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_steu_m.steu001            
                  IF g_type = '1' THEN
                     IF NOT cl_chk_exist("v_stfa001") THEN
                        LET g_steu_m.steu001 = g_steu_m_o.steu001   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu001->g_steu_m_o.steu001
                        NEXT FIELD CURRENT
                     END IF 
                  ELSE
                     IF NOT cl_chk_exist("v_stan001") THEN
                        LET g_steu_m.steu001 = g_steu_m_o.steu001   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu001->g_steu_m_o.steu001             
                        NEXT FIELD CURRENT
                     END IF 
                  END IF
                  IF g_type = '1' THEN
                     LET l_steu000 = '1'
                  ELSE
                     LET l_steu000 = '2'
                  END IF

                   #是否存此合約在未確認的結算單
                  LET l_count=0 
                  SELECT COUNT(*) INTO l_count
                    FROM steu_t
                   WHERE steuent=g_enterprise
                     AND steu001=g_steu_m.steu001
                     AND steustus='N'
                     AND steu000 = l_steu000
                  IF NOT cl_null(l_count) AND l_count>0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00358"
                     LET g_errparam.extend = g_steu_m.steu001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_steu_m.steu001 = g_steu_m_o.steu001   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu001->g_steu_m_o.steu001
                     NEXT FIELD CURRENT
                  END IF  
                  IF g_type = '1' THEN
                     CALL astt550_steu001_other()
                  ELSE
                     CALL astt550_steu001_other2()
                  END IF
                  #150501-00002#2--add by dongsz--str---
                  IF NOT astt550_steu003_chk(p_cmd) THEN
                     LET g_steu_m.steu001 = g_steu_m_o.steu001   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu00->g_steu_m_o.steu001
                     LET g_steu_m.steu003 = g_steu_m_o.steu003   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu00->g_steu_m_o.steu001
                     CALL astt550_steu003_ref()                  
                     LET g_steu_m.steu002 = g_steu_m_o.steu002   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu00->g_steu_m_o.steu001
                     CALL astt550_steu002_ref()                  
                     LET g_steu_m.steu004 = g_steu_m_o.steu004   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu00->g_steu_m_o.steu001
                     LET g_steu_m.steu005 = g_steu_m_o.steu005   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu00->g_steu_m_o.steu001
                     LET g_steu_m.steu006 = g_steu_m_o.steu006   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu00->g_steu_m_o.steu001
                     LET g_steu_m.steu007 = g_steu_m_o.steu007   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu00->g_steu_m_o.steu001
                     LET g_steu_m.stax004 = g_steu_m_o.stax004   #160824-00007#192 161120 by lori mod:g_steu_m_t.stax00->g_steu_m_o.steu001
                     DISPLAY BY NAME g_steu_m.stax004
                     NEXT FIELD CURRENT
                  END IF
                  #150501-00002#2--add by dongsz--end---
               END IF
            END IF
            CALL astt550_set_entry(p_cmd)
            CALL astt550_set_no_entry(p_cmd) 
            
            LET g_steu_m_o.* = g_steu_m.*   #160824-00007#192 161120 by lori mod:g_steu_m_t.*->g_steu_m_o.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu001
            #add-point:ON CHANGE steu001 name="input.g.steu001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu003
            
            #add-point:AFTER FIELD steu003 name="input.a.steu003"
            IF NOT cl_null(g_steu_m.steu003) THEN 
               IF g_steu_m.steu003 <> g_steu_m_o.steu003 OR cl_null(g_steu_m_o.steu003) THEN   #160824-00007#192 161120 by lori add
                  IF NOT astt550_steu003_chk(p_cmd) THEN
                     LET g_steu_m.steu003 = g_steu_m_o.steu003   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu003->g_steu_m_o.steu003
                     DISPLAY BY NAME g_steu_m.steu003            #160824-00007#192 161120 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  IF cl_null(g_steu_m.steu001) THEN  
                     IF g_type = '1' THEN
                        CALL astt550_steu003_other()
                     ELSE
                        CALL astt550_steu003_other2()
                     END IF
                  END IF
               END IF   
            END IF
            
            CALL astt550_set_entry(p_cmd)
            CALL astt550_set_no_entry(p_cmd) 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_steu_m.steu003
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_steu_m.steu003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_steu_m.steu003_desc
            
            LET g_steu_m_o.* = g_steu_m.*    #160824-00007#192 161120 by lori mod:g_steu_m_t.*->g_steu_m_o.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu003
            #add-point:BEFORE FIELD steu003 name="input.b.steu003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu003
            #add-point:ON CHANGE steu003 name="input.g.steu003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu004
            #add-point:BEFORE FIELD steu004 name="input.b.steu004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu004
            
            #add-point:AFTER FIELD steu004 name="input.a.steu004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu004
            #add-point:ON CHANGE steu004 name="input.g.steu004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu005
            #add-point:BEFORE FIELD steu005 name="input.b.steu005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu005
            
            #add-point:AFTER FIELD steu005 name="input.a.steu005"
            IF g_steu_m.steu005 <> g_steu_m_o.steu005 OR cl_null(g_steu_m_o.steu005) THEN   #160824-00007#192 161120 by lori add
               #add modify by liaolong  2015/07/21  根据结算账期带出结算日期、起始日期和结束日期
               SELECT stfj004,stfj002,stfj003 INTO g_steu_m.stax004,g_steu_m.steu006,g_steu_m.steu007
                 FROM stfj_t,steu_t
                WHERE stfjseq = g_steu_m.steu005
                  AND stfjent = g_enterprise
                  AND stfj001 = g_steu_m.steu001
               DISPLAY BY NAME g_steu_m.stax004
               DISPLAY BY NAME g_steu_m.steu006
               DISPLAY BY NAME g_steu_m.steu007
            END IF   #160824-00007#192 161120 by lori add 

            #160824-00007#192 161120 by lori add---(S)
            LET g_steu_m_o.steu005 = g_steu_m.steu005
            LET g_steu_m_o.stax004 = g_steu_m.stax004
            LET g_steu_m_o.steu006 = g_steu_m.steu006
            LET g_steu_m_o.steu007 = g_steu_m.steu007
            #160824-00007#192 161120 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu005
            #add-point:ON CHANGE steu005 name="input.g.steu005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu006
            #add-point:BEFORE FIELD steu006 name="input.b.steu006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu006
            
            #add-point:AFTER FIELD steu006 name="input.a.steu006"
            IF NOT cl_null(g_steu_m.steu006) THEN 
               IF g_steu_m.steu006 <> g_steu_m_o.steu006 OR cl_null(g_steu_m_o.steu006) THEN   #160824-00007#192 161120 by lori add
                  IF g_steu_m.steu006 > g_today THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00314"
                     LET g_errparam.extend = g_steu_m.steu006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                   
                     LET g_steu_m.steu006 = g_steu_m_o.steu006   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu006->g_steu_m_o.steu006
                     DISPLAY BY NAME g_steu_m.steu006            #160824-00007#192 161120 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_steu_m.steu007) THEN 
                     IF g_steu_m.steu007 < g_steu_m.steu006 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "aap-00336"
                        LET g_errparam.extend = g_steu_m.steu006
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        LET g_steu_m.steu006 = g_steu_m_o.steu006   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu006->g_steu_m_o.steu006
                        DISPLAY BY NAME g_steu_m.steu006            #160824-00007#192 161120 by lori add
                     NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF   #160824-00007#192 161120 by lori add   
            END IF
            
            LET g_steu_m_o.steu006 = g_steu_m.steu006 #160824-00007#192 161120 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu006
            #add-point:ON CHANGE steu006 name="input.g.steu006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu007
            #add-point:BEFORE FIELD steu007 name="input.b.steu007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu007
            
            #add-point:AFTER FIELD steu007 name="input.a.steu007"
            IF NOT cl_null(g_steu_m.steu007) THEN 
               IF g_steu_m.steu007 <> g_steu_m_o.steu007 OR cl_null(g_steu_m_o.steu007) THEN   #160824-00007#192 161120 by lori add
                  IF g_steu_m.steu007 > g_today THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00314"
                     LET g_errparam.extend = g_steu_m.steu007   
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                   
                     LET g_steu_m.steu007 = g_steu_m_o.steu007   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu007->g_steu_m_o.steu007
                     DISPLAY BY NAME g_steu_m.steu007            #160824-00007#192 161120 by lori add
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_steu_m.steu006) THEN 
                     IF g_steu_m.steu007 < g_steu_m.steu006 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "aap-00336"
                        LET g_errparam.extend = g_steu_m.steu007
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        LET g_steu_m.steu007 = g_steu_m_o.steu007   #160824-00007#192 161120 by lori mod:g_steu_m_t.steu007->g_steu_m_o.steu007
                        DISPLAY BY NAME g_steu_m.steu007            #160824-00007#192 161120 by lori add
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               END IF   #160824-00007#192 161120 by lori add                  
            END IF
            
            LET g_steu_m_o.steu007 = g_steu_m.steu007   #160824-00007#192 161120 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu007
            #add-point:ON CHANGE steu007 name="input.g.steu007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu010
            #add-point:BEFORE FIELD steu010 name="input.b.steu010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu010
            
            #add-point:AFTER FIELD steu010 name="input.a.steu010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu010
            #add-point:ON CHANGE steu010 name="input.g.steu010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu000
            #add-point:BEFORE FIELD steu000 name="input.b.steu000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu000
            
            #add-point:AFTER FIELD steu000 name="input.a.steu000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu000
            #add-point:ON CHANGE steu000 name="input.g.steu000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu008
            #add-point:BEFORE FIELD steu008 name="input.b.steu008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu008
            
            #add-point:AFTER FIELD steu008 name="input.a.steu008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu008
            #add-point:ON CHANGE steu008 name="input.g.steu008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu009
            #add-point:BEFORE FIELD steu009 name="input.b.steu009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu009
            
            #add-point:AFTER FIELD steu009 name="input.a.steu009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu009
            #add-point:ON CHANGE steu009 name="input.g.steu009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu011
            #add-point:BEFORE FIELD steu011 name="input.b.steu011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu011
            
            #add-point:AFTER FIELD steu011 name="input.a.steu011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu011
            #add-point:ON CHANGE steu011 name="input.g.steu011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steu012
            #add-point:BEFORE FIELD steu012 name="input.b.steu012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steu012
            
            #add-point:AFTER FIELD steu012 name="input.a.steu012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steu012
            #add-point:ON CHANGE steu012 name="input.g.steu012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steustus
            #add-point:BEFORE FIELD steustus name="input.b.steustus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steustus
            
            #add-point:AFTER FIELD steustus name="input.a.steustus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE steustus
            #add-point:ON CHANGE steustus name="input.g.steustus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.steusite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steusite
            #add-point:ON ACTION controlp INFIELD steusite name="input.c.steusite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_steu_m.steusite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooef001_24()                                #呼叫開窗

            LET g_steu_m.steusite = g_qryparam.return1              

            DISPLAY g_steu_m.steusite TO steusite              #

            NEXT FIELD steusite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.steudocnt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steudocnt
            #add-point:ON ACTION controlp INFIELD steudocnt name="input.c.steudocnt"
            
            #END add-point
 
 
         #Ctrlp:input.c.steudocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steudocno
            #add-point:ON ACTION controlp INFIELD steudocno name="input.c.steudocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_steu_m.steudocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_steu_m.steudocno = g_qryparam.return1              

            DISPLAY g_steu_m.steudocno TO steudocno              #

            NEXT FIELD steudocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.steu002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu002
            #add-point:ON ACTION controlp INFIELD steu002 name="input.c.steu002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_steu_m.steu002             #給予default值
            LET g_qryparam.default2 = "" #g_steu_m.mhael023 #简称
            #給予arg
            LET g_qryparam.arg1 = g_steu_m.steusite


            CALL q_mhae001()                                #呼叫開窗

            LET g_steu_m.steu002 = g_qryparam.return1              
            #LET g_steu_m.mhael023 = g_qryparam.return2 
            DISPLAY g_steu_m.steu002 TO steu002              #
            #DISPLAY g_steu_m.mhael023 TO mhael023 #简称
            NEXT FIELD steu002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.steu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu001
            #add-point:ON ACTION controlp INFIELD steu001 name="input.c.steu001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_steu_m.steu001             #給予default值
            LET g_qryparam.default2 = "" #g_steu_m.stan005 #供應商編號
            #給予arg
            LET g_qryparam.arg1 = "" #s
            
            IF g_type='1' THEN
               IF NOT cl_null(g_steu_m.steu003) THEN
                  LET g_qryparam.where = " stfa010 = '",g_steu_m.steu003,"'"
               END IF
               CALL q_stfa001()
            ELSE
               IF NOT cl_null(g_steu_m.steu003) THEN
                  LET g_qryparam.where = " stan005 = '",g_steu_m.steu003,"'"
               END IF
               CALL q_stan001_2()   
            END IF                              #呼叫開窗

            LET g_steu_m.steu001 = g_qryparam.return1              
            #LET g_steu_m.stan005 = g_qryparam.return2 
            DISPLAY g_steu_m.steu001 TO steu001              #
            #DISPLAY g_steu_m.stan005 TO stan005 #供應商編號
            NEXT FIELD steu001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.steu003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu003
            #add-point:ON ACTION controlp INFIELD steu003 name="input.c.steu003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_steu_m.steu003             #給予default值
            LET g_qryparam.default2 = "" #g_steu_m.pmaal004 #交易對象簡稱
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_steu_m.steu003 = g_qryparam.return1              
            #LET g_steu_m.pmaal004 = g_qryparam.return2 
            DISPLAY g_steu_m.steu003 TO steu003              #
            #DISPLAY g_steu_m.pmaal004 TO pmaal004 #交易對象簡稱
            NEXT FIELD steu003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.steu004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu004
            #add-point:ON ACTION controlp INFIELD steu004 name="input.c.steu004"
            
            #END add-point
 
 
         #Ctrlp:input.c.steu005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu005
            #add-point:ON ACTION controlp INFIELD steu005 name="input.c.steu005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_steu_m.steu005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            IF NOT cl_null(g_steu_m.steu001) THEN #LANJJ ADD ON 2016-02-02 
               LET g_qryparam.where = " stfjseq =     '",g_steu_m.steu005,"'",
                                      " AND stfjent = '",g_enterprise,"'",
                                      " AND stfj001 = '",g_steu_m.steu001,"'"
            END IF 
            CALL q_steu005_01()                                #呼叫開窗

            LET g_steu_m.steu005 = g_qryparam.return1              

            DISPLAY g_steu_m.steu005 TO steu005              #

            NEXT FIELD steu005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.steu006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu006
            #add-point:ON ACTION controlp INFIELD steu006 name="input.c.steu006"
            
            #END add-point
 
 
         #Ctrlp:input.c.steu007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu007
            #add-point:ON ACTION controlp INFIELD steu007 name="input.c.steu007"
            
            #END add-point
 
 
         #Ctrlp:input.c.steu010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu010
            #add-point:ON ACTION controlp INFIELD steu010 name="input.c.steu010"
            
            #END add-point
 
 
         #Ctrlp:input.c.steu000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu000
            #add-point:ON ACTION controlp INFIELD steu000 name="input.c.steu000"
            
            #END add-point
 
 
         #Ctrlp:input.c.steu008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu008
            #add-point:ON ACTION controlp INFIELD steu008 name="input.c.steu008"
            
            #END add-point
 
 
         #Ctrlp:input.c.steu009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu009
            #add-point:ON ACTION controlp INFIELD steu009 name="input.c.steu009"
            
            #END add-point
 
 
         #Ctrlp:input.c.steu011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu011
            #add-point:ON ACTION controlp INFIELD steu011 name="input.c.steu011"
            
            #END add-point
 
 
         #Ctrlp:input.c.steu012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steu012
            #add-point:ON ACTION controlp INFIELD steu012 name="input.c.steu012"
            
            #END add-point
 
 
         #Ctrlp:input.c.steustus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steustus
            #add-point:ON ACTION controlp INFIELD steustus name="input.c.steustus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_steu_m.steudocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_steu_m.steusite,g_steu_m.steudocno,g_steu_m.steudocnt,g_prog)
                  RETURNING l_success,g_steu_m.steudocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_steu_m.steudocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD steudocno           
               END IF
               #end add-point
               
               INSERT INTO steu_t (steuent,steusite,steudocnt,steudocno,steu002,steu001,steu003,steu004, 
                   steu005,steu006,steu007,steu010,steu000,steu008,steu009,steu011,steu012,steustus, 
                   steuownid,steuowndp,steucrtid,steucrtdp,steucrtdt,steumodid,steumoddt,steucnfid,steucnfdt, 
                   steupstid,steupstdt)
               VALUES (g_enterprise,g_steu_m.steusite,g_steu_m.steudocnt,g_steu_m.steudocno,g_steu_m.steu002, 
                   g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005,g_steu_m.steu006, 
                   g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
                   g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp, 
                   g_steu_m.steucrtid,g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt, 
                   g_steu_m.steucnfid,g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_steu_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               #新增單頭后，自動帶出單身           
               IF l_cmd_t <>'r' AND p_cmd = 'a' THEN
#                  CALL astt550_stev_insert() RETURNING l_success #lanjj mark on 2016-01-29
#                  IF NOT l_success THEN
#                     CALL s_transaction_end('N','0')
#                     CONTINUE DIALOG                  
#                  END IF    
                  CALL s_astt550_detail_open_window(g_steu_m.steudocno,g_steu_m.steusite,g_steu_m.steudocnt,g_steu_m.steu002,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004) RETURNING l_success #LANJJ add ON 2016-01-29 
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG                  
                  END IF  
                  #汇总单身本次结算金额合计
                  INITIALIZE l_steu009 TO NULL
                  SELECT SUM(stev016*stev011) INTO l_steu009
                    FROM stev_t
                   WHERE stevent = g_enterprise
                     AND stevdocno = g_steu_m.steudocno  
                  IF l_steu009 IS NOT NULL THEN  
                     UPDATE steu_t SET steu009 = l_steu009  
                      WHERE steuent = g_enterprise AND steudocno = g_steu_m.steudocno
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = g_steu_m.steudocno 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = FALSE 
                         CALL cl_err()
                         CALL s_transaction_end('N','0')
                         CONTINUE DIALOG
                      END IF
                  END IF    
                  SELECT steu009 INTO  g_steu_m.steu009
                    FROM steu_t 
                   WHERE steuent = g_enterprise
                     AND steudocno = g_steu_m.steudocno
                  DISPLAY BY NAME  g_steu_m.steu009 
                  CALL astt550_b_fill()                  
               END IF
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL astt550_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL astt550_b_fill()
                  CALL astt550_b_fill2('0')
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
               CALL astt550_steu_t_mask_restore('restore_mask_o')
               
               UPDATE steu_t SET (steusite,steudocnt,steudocno,steu002,steu001,steu003,steu004,steu005, 
                   steu006,steu007,steu010,steu000,steu008,steu009,steu011,steu012,steustus,steuownid, 
                   steuowndp,steucrtid,steucrtdp,steucrtdt,steumodid,steumoddt,steucnfid,steucnfdt,steupstid, 
                   steupstdt) = (g_steu_m.steusite,g_steu_m.steudocnt,g_steu_m.steudocno,g_steu_m.steu002, 
                   g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005,g_steu_m.steu006, 
                   g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
                   g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp, 
                   g_steu_m.steucrtid,g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt, 
                   g_steu_m.steucnfid,g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt)
                WHERE steuent = g_enterprise AND steudocno = g_steudocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "steu_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL astt550_steu_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_steu_m_t)
               LET g_log2 = util.JSON.stringify(g_steu_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_steudocno_t = g_steu_m.steudocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="astt550.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_stev_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
           #单身没资料关闭单身
            SELECT COUNT(*) INTO l_cnt 
              FROM stev_t 
             WHERE stevent = g_enterprise 
               AND stevdocno = g_steu_m.steudocno
            IF l_cnt = 0  THEN
               EXIT DIALOG
            END IF 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stev_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt550_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_stev_d.getLength()
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
            OPEN astt550_cl USING g_enterprise,g_steu_m.steudocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt550_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt550_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_stev_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stev_d[l_ac].stevseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stev_d_t.* = g_stev_d[l_ac].*  #BACKUP
               LET g_stev_d_o.* = g_stev_d[l_ac].*  #BACKUP
               CALL astt550_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL astt550_set_no_entry_b(l_cmd)
               IF NOT astt550_lock_b("stev_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt550_bcl INTO g_stev_d[l_ac].stevseq,g_stev_d[l_ac].stev001,g_stev_d[l_ac].stev002, 
                      g_stev_d[l_ac].stev003,g_stev_d[l_ac].stev004,g_stev_d[l_ac].stev024,g_stev_d[l_ac].stev005, 
                      g_stev_d[l_ac].stev006,g_stev_d[l_ac].stev007,g_stev_d[l_ac].stev008,g_stev_d[l_ac].stev009, 
                      g_stev_d[l_ac].stev010,g_stev_d[l_ac].stev011,g_stev_d[l_ac].stev012,g_stev_d[l_ac].stev013, 
                      g_stev_d[l_ac].stev014,g_stev_d[l_ac].stev015,g_stev_d[l_ac].stev016,g_stev_d[l_ac].stev028, 
                      g_stev_d[l_ac].stev029,g_stev_d[l_ac].stev018,g_stev_d[l_ac].stev017,g_stev_d[l_ac].stevsite, 
                      g_stev_d[l_ac].stev020,g_stev_d[l_ac].stev019,g_stev_d[l_ac].stev025,g_stev_d[l_ac].stev030 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_stev_d_t.stevseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stev_d_mask_o[l_ac].* =  g_stev_d[l_ac].*
                  CALL astt550_stev_t_mask()
                  LET g_stev_d_mask_n[l_ac].* =  g_stev_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL astt550_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
#mark by liaolong  150619-00007 #16 15/07/23 --begin--
#            IF l_cmd = 'u' THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#            END IF
#            IF l_cmd = 'a' THEN
#               CALL FGL_SET_ARR_CURR(l_ac+1)
#            END IF
#mark by liaolong  150619-00007 #16 15/07/23 --end--
             
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
            INITIALIZE g_stev_d[l_ac].* TO NULL 
            INITIALIZE g_stev_d_t.* TO NULL 
            INITIALIZE g_stev_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_stev_d[l_ac].stev012 = "0"
      LET g_stev_d[l_ac].stev013 = "0"
      LET g_stev_d[l_ac].stev014 = "0"
      LET g_stev_d[l_ac].stev015 = "0"
      LET g_stev_d[l_ac].stev016 = "0"
      LET g_stev_d[l_ac].stev028 = "0"
      LET g_stev_d[l_ac].stev029 = "0"
      LET g_stev_d[l_ac].stev025 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
#add by liaolong  150619-00007 #16 15/07/23 --begin--
      SELECT MAX(stevseq) INTO g_stev_d[l_ac].stevseq
        FROM stev_t
       WHERE stevent= g_enterprise
         AND stevdocno= g_steu_m.steudocno
      #add by geza 20150812(S)
      IF cl_null(g_stev_d[l_ac].stevseq)  THEN
         LET g_stev_d[l_ac].stevseq=1
      ELSE
        LET  g_stev_d[l_ac].stevseq=g_stev_d[l_ac].stevseq+1
      END IF    
      #add by geza 20150812(E)
       #mark by geza 20150812(S)
#       IF l_delete = '1' THEN
#          LET l_cmd = 'u'
#       ELSE
#          LET l_cmd = 'a'
#       END IF      
#       LET g_stev_d[l_ac].stevseq = l_stevseq
#       IF l_cmd = 'a'  or  l_cmd = 'u'  THEN
#          IF cl_null(g_stev_d[l_ac].stevseq)  THEN
#             LET g_stev_d[l_ac].stevseq=1
#          ELSE
#            LET  g_stev_d[l_ac].stevseq=g_stev_d[l_ac].stevseq+1
#          END IF 
#       END IF
       #mark by geza 20150812(E)  
#       IF l_cmd = 'u' OR l_cmd = 'r' THEN
#          IF cl_null(g_stev_d[l_ac].stevseq)  THEN
#             LET g_stev_d[l_ac].stevseq=1
#          ELSE
#            LET  g_stev_d[l_ac].stevseq=g_stev_d[l_ac].stevseq-1
#          END IF 
#       END IF         
       
       DISPLAY g_stev_d[l_ac].stevseq TO stevseq 
#       LET l_delete = '0'                        #mark by geza 20150812(E)     
#add by liaolong  150619-00007 #16 15/07/23 --end--
            #end add-point
            LET g_stev_d_t.* = g_stev_d[l_ac].*     #新輸入資料
            LET g_stev_d_o.* = g_stev_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt550_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
#            #单身没资料关闭stev016栏位
#            SELECT COUNT(*) INTO l_cnt 
#              FROM stev_t 
#             WHERE stevent = g_enterprise 
#               AND stevdocno = g_steu_m.steudocno
#            IF cl_null(l_cnt)  OR  l_ac > l_cnt THEN
#               CALL cl_set_comp_entry("stev016",FALSE)
#            END IF 
            #end add-point
            CALL astt550_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stev_d[li_reproduce_target].* = g_stev_d[li_reproduce].*
 
               LET g_stev_d[li_reproduce_target].stevseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM stev_t 
             WHERE stevent = g_enterprise AND stevdocno = g_steu_m.steudocno
 
               AND stevseq = g_stev_d[l_ac].stevseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_steu_m.steudocno
               LET gs_keys[2] = g_stev_d[g_detail_idx].stevseq
               CALL astt550_insert_b('stev_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #add by geza 20150810(S)
               #新增之后更新结算底稿状态
               UPDATE stbc_t SET stbcstus='2'
                WHERE stbcent=g_enterprise
                  AND stbc001=g_steu_m.steusite
                  AND stbc004=g_stev_d[l_ac].stev002
                  AND stbc005=g_stev_d[l_ac].stev003        
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "update stbc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT  
               END IF  
               #add by geza 20150810(E)
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_stev_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stev_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt550_b_fill()
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
               #add by geza 20150810(S)
               #删除单身更新结算底稿状态
               SELECT stbc018,stbc019,stbcstus INTO l_stbc018,l_stbc019,l_stbcstus
                FROM stbc_t
               WHERE stbcent=g_enterprise
                 AND stbc001=g_steu_m.steusite
                 AND stbc004=g_stev_d[l_ac].stev002
                 AND stbc005=g_stev_d[l_ac].stev003               
               IF cl_null(l_stbc018) THEN
                  LET l_stbc018=0
               END IF          
               IF cl_null(l_stbc019) THEN
                  LET l_stbc019=0
               END IF                 
               IF l_stbc018=l_stbc019 THEN
                  LET l_stbcstus='1'
               END IF
               
               IF 0<l_stbc019 AND l_stbc019<l_stbc018 THEN
                  LET l_stbcstus='3'
               END IF
               UPDATE stbc_t SET stbcstus=l_stbcstus
                WHERE stbcent=g_enterprise
                  AND stbc001=g_steu_m.steusite
                  AND stbc004=g_stev_d[l_ac].stev002
                  AND stbc005=g_stev_d[l_ac].stev003
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "update stbc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CANCEL DELETE   
               END IF       
               #add by geza 20150810(E)
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_steu_m.steudocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_stev_d_t.stevseq
 
            
               #刪除同層單身
               IF NOT astt550_delete_b('stev_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt550_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT astt550_key_delete_b(gs_keys,'stev_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt550_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE astt550_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               LET l_delete = '1'
               #end add-point
               LET l_count = g_stev_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_stev_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stevseq
            #add-point:BEFORE FIELD stevseq name="input.b.page1.stevseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stevseq
            
            #add-point:AFTER FIELD stevseq name="input.a.page1.stevseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_steu_m.steudocno IS NOT NULL AND g_stev_d[g_detail_idx].stevseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_steu_m.steudocno != g_steudocno_t OR g_stev_d[g_detail_idx].stevseq != g_stev_d_t.stevseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stev_t WHERE "||"stevent = '" ||g_enterprise|| "' AND "||"stevdocno = '"||g_steu_m.steudocno ||"' AND "|| "stevseq = '"||g_stev_d[g_detail_idx].stevseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stevseq
            #add-point:ON CHANGE stevseq name="input.g.page1.stevseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev001
            #add-point:BEFORE FIELD stev001 name="input.b.page1.stev001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev001
            
            #add-point:AFTER FIELD stev001 name="input.a.page1.stev001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev001
            #add-point:ON CHANGE stev001 name="input.g.page1.stev001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev002
            #add-point:BEFORE FIELD stev002 name="input.b.page1.stev002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev002
            
            #add-point:AFTER FIELD stev002 name="input.a.page1.stev002"
            #CALL astt550_stev_insert01() RETURNING p_success #mark by geza 20150812
            #add by geza 20150812(S)
            IF NOT cl_null(g_stev_d[l_ac].stev002) AND l_cmd = 'a' THEN
               LET l_cnt = 0 
               SELECT COUNT(*) INTO l_cnt
                 FROM stbc_t
                WHERE stbcent = g_enterprise
                  AND stbc004 = g_stev_d[l_ac].stev002
               IF l_cnt < 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ast-00403"
                  LET g_errparam.extend = g_stev_d[l_ac].stev002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()              
                  LET g_stev_d[l_ac].stev002 = g_stev_d_t.stev002
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_stev_d[l_ac].stev003) THEN
                  CALL astt550_stev_insert01() RETURNING p_success   
                  IF NOT p_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00404"
                     LET g_errparam.extend = g_stev_d[l_ac].stev002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()              
                     LET g_stev_d[l_ac].stev002 = g_stev_d_t.stev002
                     NEXT FIELD CURRENT                  
                  END IF                  
               END IF            
            END IF
            #add by geza 20150812(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev002
            #add-point:ON CHANGE stev002 name="input.g.page1.stev002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev003
            #add-point:BEFORE FIELD stev003 name="input.b.page1.stev003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev003
            
            #add-point:AFTER FIELD stev003 name="input.a.page1.stev003"
            #add by geza 20150812(S)
            IF NOT cl_null(g_stev_d[l_ac].stev003) AND l_cmd = 'a' THEN
               IF NOT cl_null(g_stev_d[l_ac].stev002) THEN               
                  CALL astt550_stev_insert01() RETURNING p_success   
                  IF NOT p_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00404"
                     LET g_errparam.extend = g_stev_d[l_ac].stev003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()              
                     LET g_stev_d[l_ac].stev003 = g_stev_d_t.stev003
                     NEXT FIELD CURRENT                  
                  END IF                  
               END IF 
            END IF 
            #add by geza 20150812(E)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev003
            #add-point:ON CHANGE stev003 name="input.g.page1.stev003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev004
            #add-point:BEFORE FIELD stev004 name="input.b.page1.stev004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev004
            
            #add-point:AFTER FIELD stev004 name="input.a.page1.stev004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev004
            #add-point:ON CHANGE stev004 name="input.g.page1.stev004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev024
            
            #add-point:AFTER FIELD stev024 name="input.a.page1.stev024"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stev_d[l_ac].stev024
            CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stev_d[l_ac].stev024_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stev_d[l_ac].stev024_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev024
            #add-point:BEFORE FIELD stev024 name="input.b.page1.stev024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev024
            #add-point:ON CHANGE stev024 name="input.g.page1.stev024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev005
            
            #add-point:AFTER FIELD stev005 name="input.a.page1.stev005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stev_d[l_ac].stev005
            CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stev_d[l_ac].stev005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stev_d[l_ac].stev005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev005
            #add-point:BEFORE FIELD stev005 name="input.b.page1.stev005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev005
            #add-point:ON CHANGE stev005 name="input.g.page1.stev005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev006
            #add-point:BEFORE FIELD stev006 name="input.b.page1.stev006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev006
            
            #add-point:AFTER FIELD stev006 name="input.a.page1.stev006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev006
            #add-point:ON CHANGE stev006 name="input.g.page1.stev006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev007
            #add-point:BEFORE FIELD stev007 name="input.b.page1.stev007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev007
            
            #add-point:AFTER FIELD stev007 name="input.a.page1.stev007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev007
            #add-point:ON CHANGE stev007 name="input.g.page1.stev007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev008
            
            #add-point:AFTER FIELD stev008 name="input.a.page1.stev008"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stev_d[l_ac].stev008
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stev_d[l_ac].stev008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stev_d[l_ac].stev008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev008
            #add-point:BEFORE FIELD stev008 name="input.b.page1.stev008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev008
            #add-point:ON CHANGE stev008 name="input.g.page1.stev008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev009
            
            #add-point:AFTER FIELD stev009 name="input.a.page1.stev009"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev009
            #add-point:BEFORE FIELD stev009 name="input.b.page1.stev009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev009
            #add-point:ON CHANGE stev009 name="input.g.page1.stev009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev009_desc
            #add-point:BEFORE FIELD stev009_desc name="input.b.page1.stev009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev009_desc
            
            #add-point:AFTER FIELD stev009_desc name="input.a.page1.stev009_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev009_desc
            #add-point:ON CHANGE stev009_desc name="input.g.page1.stev009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev010
            #add-point:BEFORE FIELD stev010 name="input.b.page1.stev010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev010
            
            #add-point:AFTER FIELD stev010 name="input.a.page1.stev010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev010
            #add-point:ON CHANGE stev010 name="input.g.page1.stev010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev011
            #add-point:BEFORE FIELD stev011 name="input.b.page1.stev011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev011
            
            #add-point:AFTER FIELD stev011 name="input.a.page1.stev011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev011
            #add-point:ON CHANGE stev011 name="input.g.page1.stev011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev012
            #add-point:BEFORE FIELD stev012 name="input.b.page1.stev012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev012
            
            #add-point:AFTER FIELD stev012 name="input.a.page1.stev012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev012
            #add-point:ON CHANGE stev012 name="input.g.page1.stev012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev013
            #add-point:BEFORE FIELD stev013 name="input.b.page1.stev013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev013
            
            #add-point:AFTER FIELD stev013 name="input.a.page1.stev013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev013
            #add-point:ON CHANGE stev013 name="input.g.page1.stev013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev014
            #add-point:BEFORE FIELD stev014 name="input.b.page1.stev014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev014
            
            #add-point:AFTER FIELD stev014 name="input.a.page1.stev014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev014
            #add-point:ON CHANGE stev014 name="input.g.page1.stev014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev015
            #add-point:BEFORE FIELD stev015 name="input.b.page1.stev015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev015
            
            #add-point:AFTER FIELD stev015 name="input.a.page1.stev015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev015
            #add-point:ON CHANGE stev015 name="input.g.page1.stev015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev016
            #add-point:BEFORE FIELD stev016 name="input.b.page1.stev016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev016
            
            #add-point:AFTER FIELD stev016 name="input.a.page1.stev016"
             IF NOT cl_null(g_stev_d[l_ac].stev016) THEN 
               IF g_stev_d[l_ac].stev016>g_stev_d[l_ac].stev014 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ast-00042"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD stev016
               END IF
               #对数量进行四舍五入 add by geza 20150814
               SELECT ROUND(g_stev_d[l_ac].stev016/g_stev_d[l_ac].stev029,4) INTO  g_stev_d[l_ac].stev028 FROM dual                          
            END IF              
      
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev016
            #add-point:ON CHANGE stev016 name="input.g.page1.stev016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev028
            #add-point:BEFORE FIELD stev028 name="input.b.page1.stev028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev028
            
            #add-point:AFTER FIELD stev028 name="input.a.page1.stev028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev028
            #add-point:ON CHANGE stev028 name="input.g.page1.stev028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev029
            #add-point:BEFORE FIELD stev029 name="input.b.page1.stev029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev029
            
            #add-point:AFTER FIELD stev029 name="input.a.page1.stev029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev029
            #add-point:ON CHANGE stev029 name="input.g.page1.stev029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev018
            #add-point:BEFORE FIELD stev018 name="input.b.page1.stev018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev018
            
            #add-point:AFTER FIELD stev018 name="input.a.page1.stev018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev018
            #add-point:ON CHANGE stev018 name="input.g.page1.stev018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev017
            #add-point:BEFORE FIELD stev017 name="input.b.page1.stev017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev017
            
            #add-point:AFTER FIELD stev017 name="input.a.page1.stev017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev017
            #add-point:ON CHANGE stev017 name="input.g.page1.stev017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stevsite
            
            #add-point:AFTER FIELD stevsite name="input.a.page1.stevsite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stev_d[l_ac].stevsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stev_d[l_ac].stevsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stev_d[l_ac].stevsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stevsite
            #add-point:BEFORE FIELD stevsite name="input.b.page1.stevsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stevsite
            #add-point:ON CHANGE stevsite name="input.g.page1.stevsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev020
            
            #add-point:AFTER FIELD stev020 name="input.a.page1.stev020"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stev_d[l_ac].stev020
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stev_d[l_ac].stev020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stev_d[l_ac].stev020_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev020
            #add-point:BEFORE FIELD stev020 name="input.b.page1.stev020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev020
            #add-point:ON CHANGE stev020 name="input.g.page1.stev020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev019
            
            #add-point:AFTER FIELD stev019 name="input.a.page1.stev019"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stev_d[l_ac].stev019
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stev_d[l_ac].stev019_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stev_d[l_ac].stev019_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev019
            #add-point:BEFORE FIELD stev019 name="input.b.page1.stev019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev019
            #add-point:ON CHANGE stev019 name="input.g.page1.stev019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev025
            #add-point:BEFORE FIELD stev025 name="input.b.page1.stev025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev025
            
            #add-point:AFTER FIELD stev025 name="input.a.page1.stev025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev025
            #add-point:ON CHANGE stev025 name="input.g.page1.stev025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stev030
            #add-point:BEFORE FIELD stev030 name="input.b.page1.stev030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stev030
            
            #add-point:AFTER FIELD stev030 name="input.a.page1.stev030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stev030
            #add-point:ON CHANGE stev030 name="input.g.page1.stev030"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.stevseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stevseq
            #add-point:ON ACTION controlp INFIELD stevseq name="input.c.page1.stevseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev001
            #add-point:ON ACTION controlp INFIELD stev001 name="input.c.page1.stev001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev002
            #add-point:ON ACTION controlp INFIELD stev002 name="input.c.page1.stev002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
#add by liaolong  150619-00007 #16 15/07/23 --begin--          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stev_d[l_ac].stev002             #給予default值
            LET g_qryparam.default2 = g_stev_d[l_ac].stev003 #g_stev_d[l_ac].stbc005 #項次
            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = "   stbc033 ='",g_steu_m.steu002,"'", 
                                   "   AND stbc002<='",g_steu_m.steu007,"'", 
                                   "   AND stbc002>='",g_steu_m.steu006,"'" ,
                                   "   AND stbc037='N' ",     #add by geza 20150812
                                   "   AND (stbcstus='1' OR stbcstus='3')", #add by geza 20150812
                                   "   AND stbc003='3' "      #add by geza 20150812 
                                   
            CALL q_stbc004_01()                                #呼叫開窗

            LET g_stev_d[l_ac].stev002 = g_qryparam.return1              
            LET g_stev_d[l_ac].stev003 = g_qryparam.return2 
            DISPLAY g_stev_d[l_ac].stev002 TO stev002              #
            DISPLAY g_stev_d[l_ac].stev003 TO stev003 #項次

            NEXT FIELD stev002                          #返回原欄位

#add by liaolong  150619-00007 #16 15/07/23 --end--
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev003
            #add-point:ON ACTION controlp INFIELD stev003 name="input.c.page1.stev003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev004
            #add-point:ON ACTION controlp INFIELD stev004 name="input.c.page1.stev004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev024
            #add-point:ON ACTION controlp INFIELD stev024 name="input.c.page1.stev024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev005
            #add-point:ON ACTION controlp INFIELD stev005 name="input.c.page1.stev005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev006
            #add-point:ON ACTION controlp INFIELD stev006 name="input.c.page1.stev006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev007
            #add-point:ON ACTION controlp INFIELD stev007 name="input.c.page1.stev007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev008
            #add-point:ON ACTION controlp INFIELD stev008 name="input.c.page1.stev008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev009
            #add-point:ON ACTION controlp INFIELD stev009 name="input.c.page1.stev009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev009_desc
            #add-point:ON ACTION controlp INFIELD stev009_desc name="input.c.page1.stev009_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev010
            #add-point:ON ACTION controlp INFIELD stev010 name="input.c.page1.stev010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev011
            #add-point:ON ACTION controlp INFIELD stev011 name="input.c.page1.stev011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev012
            #add-point:ON ACTION controlp INFIELD stev012 name="input.c.page1.stev012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev013
            #add-point:ON ACTION controlp INFIELD stev013 name="input.c.page1.stev013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev014
            #add-point:ON ACTION controlp INFIELD stev014 name="input.c.page1.stev014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev015
            #add-point:ON ACTION controlp INFIELD stev015 name="input.c.page1.stev015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev016
            #add-point:ON ACTION controlp INFIELD stev016 name="input.c.page1.stev016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev028
            #add-point:ON ACTION controlp INFIELD stev028 name="input.c.page1.stev028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev029
            #add-point:ON ACTION controlp INFIELD stev029 name="input.c.page1.stev029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev018
            #add-point:ON ACTION controlp INFIELD stev018 name="input.c.page1.stev018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev017
            #add-point:ON ACTION controlp INFIELD stev017 name="input.c.page1.stev017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stevsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stevsite
            #add-point:ON ACTION controlp INFIELD stevsite name="input.c.page1.stevsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev020
            #add-point:ON ACTION controlp INFIELD stev020 name="input.c.page1.stev020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev019
            #add-point:ON ACTION controlp INFIELD stev019 name="input.c.page1.stev019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev025
            #add-point:ON ACTION controlp INFIELD stev025 name="input.c.page1.stev025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stev030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stev030
            #add-point:ON ACTION controlp INFIELD stev030 name="input.c.page1.stev030"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_stev_d[l_ac].* = g_stev_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt550_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_stev_d[l_ac].stevseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_stev_d[l_ac].* = g_stev_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL astt550_stev_t_mask_restore('restore_mask_o')
      
               UPDATE stev_t SET (stevdocno,stevseq,stev001,stev002,stev003,stev004,stev024,stev005, 
                   stev006,stev007,stev008,stev009,stev010,stev011,stev012,stev013,stev014,stev015,stev016, 
                   stev028,stev029,stev018,stev017,stevsite,stev020,stev019,stev025,stev030) = (g_steu_m.steudocno, 
                   g_stev_d[l_ac].stevseq,g_stev_d[l_ac].stev001,g_stev_d[l_ac].stev002,g_stev_d[l_ac].stev003, 
                   g_stev_d[l_ac].stev004,g_stev_d[l_ac].stev024,g_stev_d[l_ac].stev005,g_stev_d[l_ac].stev006, 
                   g_stev_d[l_ac].stev007,g_stev_d[l_ac].stev008,g_stev_d[l_ac].stev009,g_stev_d[l_ac].stev010, 
                   g_stev_d[l_ac].stev011,g_stev_d[l_ac].stev012,g_stev_d[l_ac].stev013,g_stev_d[l_ac].stev014, 
                   g_stev_d[l_ac].stev015,g_stev_d[l_ac].stev016,g_stev_d[l_ac].stev028,g_stev_d[l_ac].stev029, 
                   g_stev_d[l_ac].stev018,g_stev_d[l_ac].stev017,g_stev_d[l_ac].stevsite,g_stev_d[l_ac].stev020, 
                   g_stev_d[l_ac].stev019,g_stev_d[l_ac].stev025,g_stev_d[l_ac].stev030)
                WHERE stevent = g_enterprise AND stevdocno = g_steu_m.steudocno 
 
                  AND stevseq = g_stev_d_t.stevseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_stev_d[l_ac].* = g_stev_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stev_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_stev_d[l_ac].* = g_stev_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stev_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_steu_m.steudocno
               LET gs_keys_bak[1] = g_steudocno_t
               LET gs_keys[2] = g_stev_d[g_detail_idx].stevseq
               LET gs_keys_bak[2] = g_stev_d_t.stevseq
               CALL astt550_update_b('stev_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL astt550_stev_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_stev_d[g_detail_idx].stevseq = g_stev_d_t.stevseq 
 
                  ) THEN
                  LET gs_keys[01] = g_steu_m.steudocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_stev_d_t.stevseq
 
                  CALL astt550_key_update_b(gs_keys,'stev_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_steu_m),util.JSON.stringify(g_stev_d_t)
               LET g_log2 = util.JSON.stringify(g_steu_m),util.JSON.stringify(g_stev_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #汇总单身本次结算金额合计
            INITIALIZE l_steu009 TO NULL
            SELECT SUM(stev016*stev011) INTO l_steu009
              FROM stev_t
             WHERE stevent = g_enterprise
               AND stevdocno = g_steu_m.steudocno  
            IF l_steu009 IS NOT NULL THEN  
               UPDATE steu_t SET steu009 = l_steu009  
                WHERE steuent = g_enterprise AND steudocno = g_steu_m.steudocno
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_steu_m.steudocno 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  LET g_stev_d[l_ac].* = g_stev_d_t.* 
               END IF
            END IF    
            SELECT steu009 INTO  g_steu_m.steu009
              FROM steu_t 
             WHERE steuent = g_enterprise
               AND steudocno = g_steu_m.steudocno
            DISPLAY BY NAME  g_steu_m.steu009 
            #end add-point
            CALL astt550_unlock_b("stev_t","'1'")
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
               LET g_stev_d[li_reproduce_target].* = g_stev_d[li_reproduce].*
 
               LET g_stev_d[li_reproduce_target].stevseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_stev_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stev_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="astt550.input.other" >}
      
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
            NEXT FIELD steudocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD stevseq
 
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
 
{<section id="astt550.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION astt550_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL astt550_b_fill() #單身填充
      CALL astt550_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL astt550_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   IF g_type = '2' THEN   
      SELECT stax004 INTO g_steu_m.stax004 FROM stax_t
        WHERE staxent=g_enterprise  AND stax001=g_steu_m.steu001  AND staxseq=g_steu_m.steu005
   ELSE
      SELECT stfj004 INTO g_steu_m.stax004 FROM stfj_t
        WHERE stfjent=g_enterprise  AND stfj001=g_steu_m.steu001  AND stfjseq=g_steu_m.steu005
   END IF
   DISPLAY BY NAME g_steu_m.stax004
   #end add-point
   
   #遮罩相關處理
   LET g_steu_m_mask_o.* =  g_steu_m.*
   CALL astt550_steu_t_mask()
   LET g_steu_m_mask_n.* =  g_steu_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_steu_m.steusite,g_steu_m.steusite_desc,g_steu_m.steudocnt,g_steu_m.steudocno,g_steu_m.steu002, 
       g_steu_m.steu002_desc,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu003_desc,g_steu_m.steu004, 
       g_steu_m.steu005,g_steu_m.stax004,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000, 
       g_steu_m.steu008,g_steu_m.steu009,g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid, 
       g_steu_m.steuownid_desc,g_steu_m.steuowndp,g_steu_m.steuowndp_desc,g_steu_m.steucrtid,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdp_desc,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumodid_desc, 
       g_steu_m.steumoddt,g_steu_m.steucnfid,g_steu_m.steucnfid_desc,g_steu_m.steucnfdt,g_steu_m.steupstid, 
       g_steu_m.steupstid_desc,g_steu_m.steupstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_steu_m.steustus 
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
   FOR l_ac = 1 TO g_stev_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL astt550_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astt550.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION astt550_detail_show()
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
 
{<section id="astt550.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION astt550_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE steu_t.steudocno 
   DEFINE l_oldno     LIKE steu_t.steudocno 
 
   DEFINE l_master    RECORD LIKE steu_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE stev_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_insert       LIKE type_t.num5
   DEFINE l_doctype  LIKE rtai_t.rtai004
   DEFINE l_insert   LIKE type_t.num5
   DEFINE l_success  LIKE type_t.num5   
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
   
   IF g_steu_m.steudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_steudocno_t = g_steu_m.steudocno
 
    
   LET g_steu_m.steudocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_steu_m.steuownid = g_user
      LET g_steu_m.steuowndp = g_dept
      LET g_steu_m.steucrtid = g_user
      LET g_steu_m.steucrtdp = g_dept 
      LET g_steu_m.steucrtdt = cl_get_current()
      LET g_steu_m.steumodid = g_user
      LET g_steu_m.steumoddt = cl_get_current()
      LET g_steu_m.steustus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_site_flag = FALSE
   CALL s_aooi500_default(g_prog,'steusite',g_steu_m.steusite) RETURNING r_insert,g_steu_m.steusite
   IF NOT r_insert THEN
      RETURN 
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_steu_m.steusite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_steu_m.steusite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_steu_m.steusite_desc
   LET g_steu_m.steudocnt=g_today
   #单据别
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_steu_m.steusite,g_prog,'1')
        RETURNING l_success, l_doctype
   LET g_steu_m.steudocno = l_doctype
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_steu_m.steustus 
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
   
   
   CALL astt550_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_steu_m.* TO NULL
      INITIALIZE g_stev_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL astt550_show()
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
   CALL astt550_set_act_visible()   
   CALL astt550_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_steudocno_t = g_steu_m.steudocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " steuent = " ||g_enterprise|| " AND",
                      " steudocno = '", g_steu_m.steudocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL astt550_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL astt550_idx_chk()
   
   LET g_data_owner = g_steu_m.steuownid      
   LET g_data_dept  = g_steu_m.steuowndp
   
   #功能已完成,通報訊息中心
   CALL astt550_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION astt550_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE stev_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE astt550_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM stev_t
    WHERE stevent = g_enterprise AND stevdocno = g_steudocno_t
 
    INTO TEMP astt550_detail
 
   #將key修正為調整後   
   UPDATE astt550_detail 
      #更新key欄位
      SET stevdocno = g_steu_m.steudocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO stev_t SELECT * FROM astt550_detail
   
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
   DROP TABLE astt550_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_steudocno_t = g_steu_m.steudocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt550.delete" >}
#+ 資料刪除
PRIVATE FUNCTION astt550_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success      LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_steu_m.steudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN astt550_cl USING g_enterprise,g_steu_m.steudocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt550_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE astt550_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE astt550_master_referesh USING g_steu_m.steudocno INTO g_steu_m.steusite,g_steu_m.steudocnt, 
       g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005, 
       g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
       g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp,g_steu_m.steucrtid, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt,g_steu_m.steucnfid, 
       g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt,g_steu_m.steusite_desc,g_steu_m.steu002_desc, 
       g_steu_m.steu003_desc,g_steu_m.steuownid_desc,g_steu_m.steuowndp_desc,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp_desc,g_steu_m.steumodid_desc,g_steu_m.steucnfid_desc,g_steu_m.steupstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT astt550_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_steu_m_mask_o.* =  g_steu_m.*
   CALL astt550_steu_t_mask()
   LET g_steu_m_mask_n.* =  g_steu_m.*
   
   CALL astt550_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      CALL astt550_delete_updstbc() RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN      
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL astt550_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_steudocno_t = g_steu_m.steudocno
 
 
      DELETE FROM steu_t
       WHERE steuent = g_enterprise AND steudocno = g_steu_m.steudocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_steu_m.steudocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
#      IF NOT s_aooi200_del_docno(g_steu_m.steudocno,g_steu_m.steudocnt) THEN
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM stev_t
       WHERE stevent = g_enterprise AND stevdocno = g_steu_m.steudocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stev_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_steu_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE astt550_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_stev_d.clear() 
 
     
      CALL astt550_ui_browser_refresh()  
      #CALL astt550_ui_headershow()  
      #CALL astt550_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL astt550_browser_fill("")
         CALL astt550_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE astt550_cl
 
   #功能已完成,通報訊息中心
   CALL astt550_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="astt550.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt550_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_stev_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF astt550_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT stevseq,stev001,stev002,stev003,stev004,stev024,stev005,stev006, 
             stev007,stev008,stev009,stev010,stev011,stev012,stev013,stev014,stev015,stev016,stev028, 
             stev029,stev018,stev017,stevsite,stev020,stev019,stev025,stev030 ,t1.mhael023 ,t2.stael003 , 
             t3.ooail003 ,t4.ooefl003 ,t5.ooefl003 ,t6.rtaxl003 FROM stev_t",   
                     " INNER JOIN steu_t ON steuent = " ||g_enterprise|| " AND steudocno = stevdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN mhael_t t1 ON t1.mhaelent="||g_enterprise||" AND t1.mhael001=stev024 AND t1.mhael022='"||g_dlang||"' ",
               " LEFT JOIN stael_t t2 ON t2.staelent="||g_enterprise||" AND t2.stael001=stev005 AND t2.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=stev008 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=stevsite AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=stev020 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t6 ON t6.rtaxlent="||g_enterprise||" AND t6.rtaxl001=stev019 AND t6.rtaxl002='"||g_dlang||"' ",
 
                     " WHERE stevent=? AND stevdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY stev_t.stevseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt550_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR astt550_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_steu_m.steudocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_steu_m.steudocno INTO g_stev_d[l_ac].stevseq,g_stev_d[l_ac].stev001, 
          g_stev_d[l_ac].stev002,g_stev_d[l_ac].stev003,g_stev_d[l_ac].stev004,g_stev_d[l_ac].stev024, 
          g_stev_d[l_ac].stev005,g_stev_d[l_ac].stev006,g_stev_d[l_ac].stev007,g_stev_d[l_ac].stev008, 
          g_stev_d[l_ac].stev009,g_stev_d[l_ac].stev010,g_stev_d[l_ac].stev011,g_stev_d[l_ac].stev012, 
          g_stev_d[l_ac].stev013,g_stev_d[l_ac].stev014,g_stev_d[l_ac].stev015,g_stev_d[l_ac].stev016, 
          g_stev_d[l_ac].stev028,g_stev_d[l_ac].stev029,g_stev_d[l_ac].stev018,g_stev_d[l_ac].stev017, 
          g_stev_d[l_ac].stevsite,g_stev_d[l_ac].stev020,g_stev_d[l_ac].stev019,g_stev_d[l_ac].stev025, 
          g_stev_d[l_ac].stev030,g_stev_d[l_ac].stev024_desc,g_stev_d[l_ac].stev005_desc,g_stev_d[l_ac].stev008_desc, 
          g_stev_d[l_ac].stevsite_desc,g_stev_d[l_ac].stev020_desc,g_stev_d[l_ac].stev019_desc   #(ver:78) 
 
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
   
   CALL g_stev_d.deleteElement(g_stev_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE astt550_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_stev_d.getLength()
      LET g_stev_d_mask_o[l_ac].* =  g_stev_d[l_ac].*
      CALL astt550_stev_t_mask()
      LET g_stev_d_mask_n[l_ac].* =  g_stev_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION astt550_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM stev_t
       WHERE stevent = g_enterprise AND
         stevdocno = ps_keys_bak[1] AND stevseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
#Add by liaolong  150619-00007#16 2015/07/24 -- Begin --     
#      DELETE FROM stev_t
#       WHERE stevent = g_enterprise
#         AND stve002 = g_stev_d[l_ac].stev002
#         AND stve003 = g_stev_d[l_ac].stev003
#Add by liaolong  150619-00007#16 2015/07/21 -- End --    
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
         CALL g_stev_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="astt550.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION astt550_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO stev_t
                  (stevent,
                   stevdocno,
                   stevseq
                   ,stev001,stev002,stev003,stev004,stev024,stev005,stev006,stev007,stev008,stev009,stev010,stev011,stev012,stev013,stev014,stev015,stev016,stev028,stev029,stev018,stev017,stevsite,stev020,stev019,stev025,stev030) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stev_d[g_detail_idx].stev001,g_stev_d[g_detail_idx].stev002,g_stev_d[g_detail_idx].stev003, 
                       g_stev_d[g_detail_idx].stev004,g_stev_d[g_detail_idx].stev024,g_stev_d[g_detail_idx].stev005, 
                       g_stev_d[g_detail_idx].stev006,g_stev_d[g_detail_idx].stev007,g_stev_d[g_detail_idx].stev008, 
                       g_stev_d[g_detail_idx].stev009,g_stev_d[g_detail_idx].stev010,g_stev_d[g_detail_idx].stev011, 
                       g_stev_d[g_detail_idx].stev012,g_stev_d[g_detail_idx].stev013,g_stev_d[g_detail_idx].stev014, 
                       g_stev_d[g_detail_idx].stev015,g_stev_d[g_detail_idx].stev016,g_stev_d[g_detail_idx].stev028, 
                       g_stev_d[g_detail_idx].stev029,g_stev_d[g_detail_idx].stev018,g_stev_d[g_detail_idx].stev017, 
                       g_stev_d[g_detail_idx].stevsite,g_stev_d[g_detail_idx].stev020,g_stev_d[g_detail_idx].stev019, 
                       g_stev_d[g_detail_idx].stev025,g_stev_d[g_detail_idx].stev030)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stev_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_stev_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="astt550.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION astt550_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stev_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL astt550_stev_t_mask_restore('restore_mask_o')
               
      UPDATE stev_t 
         SET (stevdocno,
              stevseq
              ,stev001,stev002,stev003,stev004,stev024,stev005,stev006,stev007,stev008,stev009,stev010,stev011,stev012,stev013,stev014,stev015,stev016,stev028,stev029,stev018,stev017,stevsite,stev020,stev019,stev025,stev030) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stev_d[g_detail_idx].stev001,g_stev_d[g_detail_idx].stev002,g_stev_d[g_detail_idx].stev003, 
                  g_stev_d[g_detail_idx].stev004,g_stev_d[g_detail_idx].stev024,g_stev_d[g_detail_idx].stev005, 
                  g_stev_d[g_detail_idx].stev006,g_stev_d[g_detail_idx].stev007,g_stev_d[g_detail_idx].stev008, 
                  g_stev_d[g_detail_idx].stev009,g_stev_d[g_detail_idx].stev010,g_stev_d[g_detail_idx].stev011, 
                  g_stev_d[g_detail_idx].stev012,g_stev_d[g_detail_idx].stev013,g_stev_d[g_detail_idx].stev014, 
                  g_stev_d[g_detail_idx].stev015,g_stev_d[g_detail_idx].stev016,g_stev_d[g_detail_idx].stev028, 
                  g_stev_d[g_detail_idx].stev029,g_stev_d[g_detail_idx].stev018,g_stev_d[g_detail_idx].stev017, 
                  g_stev_d[g_detail_idx].stevsite,g_stev_d[g_detail_idx].stev020,g_stev_d[g_detail_idx].stev019, 
                  g_stev_d[g_detail_idx].stev025,g_stev_d[g_detail_idx].stev030) 
         WHERE stevent = g_enterprise AND stevdocno = ps_keys_bak[1] AND stevseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stev_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stev_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt550_stev_t_mask_restore('restore_mask_n')
               
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
 
{<section id="astt550.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION astt550_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="astt550.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION astt550_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="astt550.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION astt550_lock_b(ps_table,ps_page)
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
   #CALL astt550_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "stev_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN astt550_bcl USING g_enterprise,
                                       g_steu_m.steudocno,g_stev_d[g_detail_idx].stevseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt550_bcl:",SQLERRMESSAGE 
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
 
{<section id="astt550.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION astt550_unlock_b(ps_table,ps_page)
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
      CLOSE astt550_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION astt550_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("steudocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("steudocno",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("steusite",TRUE)
#   IF g_type = '1' THEN
#      CALL cl_set_comp_entry("steu002",TRUE)
#      CALL cl_set_comp_entry("steu004",TRUE)
#      CALL cl_set_comp_entry("steu005",TRUE)
#      CALL cl_set_comp_entry("steu006",TRUE)
#      CALL cl_set_comp_entry("steu007",TRUE)
#   END IF   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION astt550_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("steudocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("steudocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'steusite') OR g_site_flag THEN
      CALL cl_set_comp_entry("steusite",FALSE)
   END IF
#   IF NOT cl_null(g_steu_m.steu001) AND g_type = '1' THEN 
#      CALL cl_set_comp_entry("steu002",FALSE)
#      CALL cl_set_comp_entry("steu004",FALSE)
#      CALL cl_set_comp_entry("steu005",FALSE)
#      CALL cl_set_comp_entry("steu006",FALSE)
#      CALL cl_set_comp_entry("steu007",FALSE)
#   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt550.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION astt550_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("stev016",TRUE)
   CALL cl_set_comp_entry("stev002,stev003",TRUE)  #add by geza 20150812
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="astt550.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION astt550_set_no_entry_b(p_cmd)
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
   #add by geza 20150812(S)
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("stev002,stev003",FALSE) 
   END IF
   #add by geza 20150812(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="astt550.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION astt550_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt550.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION astt550_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_steu_m.steustus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail,reproduce", FALSE)
   END IF

#   #add by geza 20150812(S)
#   #是否启用交款汇总单为N,交款汇总单只能查询
#   IF cl_get_para(g_enterprise,g_site,"S-CIR-2012") = 'N' THEN
#      CALL cl_set_act_visible("insert,modify,delete,reproduce,modify_detail,statechange", FALSE)
#   END IF 
#   #add by geza 20150812(E)
# LANJJ MARK ON 2016年1月28日  不管控，全功能开放  顾问刘鑫  151214-00017#21
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt550.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION astt550_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt550.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION astt550_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt550.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION astt550_default_search()
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
      LET ls_wc = ls_wc, " steudocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "steu_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "stev_t" 
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
 
{<section id="astt550.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION astt550_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_errno        LIKE type_t.chr100
   DEFINE l_steucnfdt   DATETIME YEAR TO SECOND  #add by geza 20150627
   DEFINE l_steumoddt   DATETIME YEAR TO SECOND  #add by geza 20150627
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_steu_m.steudocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN astt550_cl USING g_enterprise,g_steu_m.steudocno
   IF STATUS THEN
      CLOSE astt550_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt550_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE astt550_master_referesh USING g_steu_m.steudocno INTO g_steu_m.steusite,g_steu_m.steudocnt, 
       g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005, 
       g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
       g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp,g_steu_m.steucrtid, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt,g_steu_m.steucnfid, 
       g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt,g_steu_m.steusite_desc,g_steu_m.steu002_desc, 
       g_steu_m.steu003_desc,g_steu_m.steuownid_desc,g_steu_m.steuowndp_desc,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp_desc,g_steu_m.steumodid_desc,g_steu_m.steucnfid_desc,g_steu_m.steupstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT astt550_action_chk() THEN
      CLOSE astt550_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_steu_m.steusite,g_steu_m.steusite_desc,g_steu_m.steudocnt,g_steu_m.steudocno,g_steu_m.steu002, 
       g_steu_m.steu002_desc,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu003_desc,g_steu_m.steu004, 
       g_steu_m.steu005,g_steu_m.stax004,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000, 
       g_steu_m.steu008,g_steu_m.steu009,g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid, 
       g_steu_m.steuownid_desc,g_steu_m.steuowndp,g_steu_m.steuowndp_desc,g_steu_m.steucrtid,g_steu_m.steucrtid_desc, 
       g_steu_m.steucrtdp,g_steu_m.steucrtdp_desc,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumodid_desc, 
       g_steu_m.steumoddt,g_steu_m.steucnfid,g_steu_m.steucnfid_desc,g_steu_m.steucnfdt,g_steu_m.steupstid, 
       g_steu_m.steupstid_desc,g_steu_m.steupstdt
 
   CASE g_steu_m.steustus
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
         CASE g_steu_m.steustus
            
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
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_steu_m.steustus
         WHEN "X"
            HIDE OPTION "confirmed"
            HIDE OPTION "unconfirmed"
            CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
            RETURN
         WHEN "Y"
            HIDE OPTION "invalid"
            #HIDE OPTION "unconfirmed"
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
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT astt550_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt550_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT astt550_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt550_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #add by geza 20150814(S)
            CALL s_astt550_conf_chk(g_steu_m.steudocno,lc_state) RETURNING l_success,l_errno         
            IF l_success THEN
               IF cl_ask_confirm('lib-015') THEN
                  CALL s_astt550_conf_upd(g_steu_m.steudocno,lc_state) RETURNING l_success,l_errno 
                  UPDATE steu_t SET steucnfid ='',steucnfdt=''
                    WHERE steuent = g_enterprise AND steudocno = g_steu_m.steudocno                       
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_steu_m.steudocno 
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
            
                     CALL s_transaction_end('N','0')                 
                     RETURN
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
                  RETURN            
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = l_errno
               LET g_errparam.extend = g_steu_m.steudocno 
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
               RETURN            
            END IF
            #add by geza 20150814(E)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
         CALL s_astt550_conf_chk(g_steu_m.steudocno,lc_state) RETURNING l_success,l_errno
         
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_astt550_conf_upd(g_steu_m.steudocno,lc_state) RETURNING l_success,l_errno 
               LET l_steucnfdt = cl_get_current()   #add by geza 20150627
               UPDATE steu_t SET steucnfid =g_user,steucnfdt=l_steucnfdt
                    WHERE steuent = g_enterprise AND steudocno = g_steu_m.steudocno                 
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_steu_m.steudocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')                 
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_steu_m.steudocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
            RETURN            
         END IF 
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
         CALL s_astt550_conf_chk(g_steu_m.steudocno,lc_state) RETURNING l_success,l_errno

         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_astt340_conf_upd(g_steu_m.steudocno,lc_state) RETURNING l_success,l_errno 
               LET l_steumoddt = cl_get_current()   #add by geza 20150627
               UPDATE steu_t SET steumodid =g_user,steumoddt=l_steumoddt
                    WHERE steuent = g_enterprise AND steudocno = g_steu_m.steudocno                 
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_steu_m.steudocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')                 
                  RETURN
               ELSE
#add by yangxf ---start----
                  #更新astq330中的状态
                  CALL astt550_delete_updstbc() RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN      
                  END IF
#add by yangxf ---end----
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = g_steu_m.steudocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#17 by 08209 add
            RETURN            
         END IF  
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
      g_steu_m.steustus = lc_state OR cl_null(lc_state) THEN
      CLOSE astt550_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_steu_m.steumodid = g_user
   LET g_steu_m.steumoddt = cl_get_current()
   LET g_steu_m.steustus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE steu_t 
      SET (steustus,steumodid,steumoddt) 
        = (g_steu_m.steustus,g_steu_m.steumodid,g_steu_m.steumoddt)     
    WHERE steuent = g_enterprise AND steudocno = g_steu_m.steudocno
 
    
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
      EXECUTE astt550_master_referesh USING g_steu_m.steudocno INTO g_steu_m.steusite,g_steu_m.steudocnt, 
          g_steu_m.steudocno,g_steu_m.steu002,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004,g_steu_m.steu005, 
          g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010,g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009, 
          g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus,g_steu_m.steuownid,g_steu_m.steuowndp, 
          g_steu_m.steucrtid,g_steu_m.steucrtdp,g_steu_m.steucrtdt,g_steu_m.steumodid,g_steu_m.steumoddt, 
          g_steu_m.steucnfid,g_steu_m.steucnfdt,g_steu_m.steupstid,g_steu_m.steupstdt,g_steu_m.steusite_desc, 
          g_steu_m.steu002_desc,g_steu_m.steu003_desc,g_steu_m.steuownid_desc,g_steu_m.steuowndp_desc, 
          g_steu_m.steucrtid_desc,g_steu_m.steucrtdp_desc,g_steu_m.steumodid_desc,g_steu_m.steucnfid_desc, 
          g_steu_m.steupstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_steu_m.steusite,g_steu_m.steusite_desc,g_steu_m.steudocnt,g_steu_m.steudocno, 
          g_steu_m.steu002,g_steu_m.steu002_desc,g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu003_desc, 
          g_steu_m.steu004,g_steu_m.steu005,g_steu_m.stax004,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.steu010, 
          g_steu_m.steu000,g_steu_m.steu008,g_steu_m.steu009,g_steu_m.steu011,g_steu_m.steu012,g_steu_m.steustus, 
          g_steu_m.steuownid,g_steu_m.steuownid_desc,g_steu_m.steuowndp,g_steu_m.steuowndp_desc,g_steu_m.steucrtid, 
          g_steu_m.steucrtid_desc,g_steu_m.steucrtdp,g_steu_m.steucrtdp_desc,g_steu_m.steucrtdt,g_steu_m.steumodid, 
          g_steu_m.steumodid_desc,g_steu_m.steumoddt,g_steu_m.steucnfid,g_steu_m.steucnfid_desc,g_steu_m.steucnfdt, 
          g_steu_m.steupstid,g_steu_m.steupstid_desc,g_steu_m.steupstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE astt550_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL astt550_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt550.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION astt550_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_stev_d.getLength() THEN
         LET g_detail_idx = g_stev_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stev_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stev_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt550.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astt550_b_fill2(pi_idx)
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
   
   CALL astt550_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="astt550.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION astt550_fill_chk(ps_idx)
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
 
{<section id="astt550.status_show" >}
PRIVATE FUNCTION astt550_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astt550.mask_functions" >}
&include "erp/ast/astt550_mask.4gl"
 
{</section>}
 
{<section id="astt550.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION astt550_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL astt550_show()
   CALL astt550_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_steu_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_stev_d))
 
 
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
   #CALL astt550_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL astt550_ui_headershow()
   CALL astt550_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION astt550_draw_out()
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
   CALL astt550_ui_headershow()  
   CALL astt550_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="astt550.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION astt550_set_pk_array()
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
   LET g_pk_array[1].values = g_steu_m.steudocno
   LET g_pk_array[1].column = 'steudocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt550.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="astt550.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION astt550_msgcentre_notify(lc_state)
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
   CALL astt550_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_steu_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt550.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION astt550_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#39 add-S
   SELECT steustus  INTO g_steu_m.steustus
     FROM steu_t
    WHERE steuent = g_enterprise
      AND steudocno = g_steu_m.steudocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_steu_m.steustus
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
        LET g_errparam.extend = g_steu_m.steudocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL astt550_set_act_visible()
        CALL astt550_set_act_no_visible()
        CALL astt550_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#39 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="astt550.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 根据合同编号带值
# Date & Author..: 2015/05/21 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_steu001_other()
DEFINE l_stcw004        LIKE stcw_t.stcw004  


   SELECT stfa003,stfa010,stfa005 INTO 
          g_steu_m.steu004,g_steu_m.steu003,g_steu_m.steu002
     FROM stfa_t
    WHERE stfaent=g_enterprise
      AND stfa001=g_steu_m.steu001

   DISPLAY BY NAME g_steu_m.steu004,g_steu_m.steu003,g_steu_m.steu002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_steu_m.steu002
   CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_steu_m.steu002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_steu_m.steu002_desc

   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_steu_m.steu003
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_steu_m.steu003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_steu_m.steu003_desc
   

   SELECT MIN(stfjseq) INTO g_steu_m.steu005
     FROM stfj_t
    WHERE stfjent=g_enterprise
      AND stfj001=g_steu_m.steu001
      AND stfj005='N'
   
   DISPLAY BY NAME g_steu_m.steu005

   SELECT stfj002,stfj003,stfj004 INTO g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004
     FROM stfj_t
    WHERE stfjent=g_enterprise
      AND stfj001=g_steu_m.steu001
      AND stfj005='N'
      AND stfjseq=g_steu_m.steu005

   DISPLAY BY NAME g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004
END FUNCTION

################################################################################
# Descriptions...: 供应商检查
# Date & Author..: 2015/05/21 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_steu003_chk(p_cmd)
DEFINE l_count  LIKE type_t.num5
DEFINE p_cmd    LIKE type_t.chr1
DEFINE r_success   LIKE type_t.num5           #150501-00002#2--add by dongsz
DEFINE  l_steu000    LIKE steu_t.steu000 
DEFINE  l_steu001    LIKE steu_t.steu001 
DEFINE  l_stfa010    LIKE stfa_t.stfa010 
    INITIALIZE g_chkparam.* TO NULL
      #設定g_chkparam.*的參數
    LET g_chkparam.arg1 = g_steu_m.steu003
    IF NOT cl_chk_exist("v_pmaa001_1") THEN
       RETURN FALSE
    END IF
   INITIALIZE l_steu000 TO NULL
   IF g_type = '1' THEN
      LET l_steu000 = '1'
   ELSE
      LET l_steu000 = '2'
   END IF   
   LET l_count=0
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_count FROM steu_t
       WHERE steuent=g_enterprise AND steu003=g_steu_m.steu003 AND steustus='N' AND steu000 = l_steu000
   ELSE
      SELECT COUNT(*) INTO l_count FROM steu_t
       WHERE steuent=g_enterprise AND steu003=g_steu_m.steu003 AND steustus='N' AND steudocno <> g_steu_m.steudocno AND steu000 = l_steu000  
   END IF   
   IF NOT cl_null(l_count) AND l_count>0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ast-00357"
      LET g_errparam.extend = g_steu_m.steu003
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   INITIALIZE l_steu001 TO NULL
   IF g_type = '1' THEN   
      SELECT stfa001 INTO l_steu001
        FROM stfa_t LEFT OUTER JOIN stfj_t ON stfaent = stfjent AND stfa001 = stfj001 
       WHERE stfaent=g_enterprise
         AND stfa010=g_steu_m.steu003
         AND stfastus='Y' AND stfj005 = 'N'
         #AND stfa019<=g_today #lanjj temporarily mark 2016-01-28 按道理说M档数据不用检查有效日期
         #AND stfa020>=g_today #lanjj temporarily mark 2016-01-28
         AND rownum =1
       
   ELSE 
      SELECT stan001 INTO l_steu001
        FROM stan_t LEFT OUTER JOIN stax_t ON stanent = staxent AND stan001 = stax001 
       WHERE stanent=g_enterprise
         AND stan005=g_steu_m.steu003
         AND stanstus='Y' AND stax005 = 'N'
         #AND stan017<=g_today #lanjj temporarily mark 2016-01-28 按道理说M档数据不用检查有效日期
         #AND stan018>=g_today 
         AND rownum =1

   END IF
   IF cl_null(l_steu001) THEN     
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ast-00219"
      LET g_errparam.extend =''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF
     
   IF g_type = '1' THEN   
      SELECT stfa010 INTO l_stfa010
        FROM stfa_t 
       WHERE stfaent=g_enterprise
         AND stfa001=g_steu_m.steu001
      IF l_stfa010 != g_steu_m.steu003 THEN          
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ast-00316"
         LET g_errparam.extend =''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE 
      END IF
       
   ELSE 
      SELECT stan005 INTO l_stfa010
        FROM stan_t
       WHERE stanent = g_enterprise    
         AND stan001 = g_stbd_m.stbd001
      IF l_stfa010 != g_steu_m.steu003 THEN          
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ast-00316"
         LET g_errparam.extend =''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE 
      END IF  
   END IF

#   LET g_steu_m.steu001 = l_steu001
     #150501-00002#2--add by dongsz--str---
     #检查供应商生命周期有效性
     #CALL s_life_cycle_chk(g_prog,g_steu_m.steusite,'2',g_steu_m.steu003) RETURNING r_success  #150616-00035#78-mark by dongsz
     CALL s_life_cycle_chk(g_prog,g_steu_m.steusite,'2',g_steu_m.steu003,'','') RETURNING r_success  #150616-00035#78-add by dongsz
     IF NOT r_success THEN
        RETURN FALSE
     END IF
     #150501-00002#2--add by dongsz--end---
            
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 提取單身資料
# Memo...........:
# Usage..........: CALL astt550_stev_insert()
# Date & Author..: 2015/05/21 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_stev_insert()
DEFINE r_success     LIKE type_t.num5
#161111-00028#3--modfiy--begin------------
#DEFINE l_stbc RECORD LIKE stbc_t.*
#DEFINE l_stev RECORD LIKE stev_t.*
DEFINE l_stev RECORD  #交款彙總明細資料
       stevent LIKE stev_t.stevent, #企業編號
       stevsite LIKE stev_t.stevsite, #所屬組織
       stevcomp LIKE stev_t.stevcomp, #所屬法人
       stevdocno LIKE stev_t.stevdocno, #單據編號
       stevseq LIKE stev_t.stevseq, #單據項次
       stev001 LIKE stev_t.stev001, #來源類型
       stev002 LIKE stev_t.stev002, #來源單據
       stev003 LIKE stev_t.stev003, #來源項次
       stev004 LIKE stev_t.stev004, #來源日期
       stev005 LIKE stev_t.stev005, #費用編號
       stev006 LIKE stev_t.stev006, #起始日期
       stev007 LIKE stev_t.stev007, #截止日期
       stev008 LIKE stev_t.stev008, #幣別
       stev009 LIKE stev_t.stev009, #稅別
       stev010 LIKE stev_t.stev010, #價款類型
       stev011 LIKE stev_t.stev011, #方向
       stev012 LIKE stev_t.stev012, #價外金額
       stev013 LIKE stev_t.stev013, #價內金額
       stev014 LIKE stev_t.stev014, #未結算金額
       stev015 LIKE stev_t.stev015, #已結算金額
       stev016 LIKE stev_t.stev016, #本次結算金額
       stev017 LIKE stev_t.stev017, #結算方式
       stev018 LIKE stev_t.stev018, #結算類型
       stev019 LIKE stev_t.stev019, #所屬品類
       stev020 LIKE stev_t.stev020, #所屬部門
       stev021 LIKE stev_t.stev021, #主帳套帳款金額
       stev022 LIKE stev_t.stev022, #次帳套一帳款金額
       stev023 LIKE stev_t.stev023, #次帳套二帳款金額
       stev024 LIKE stev_t.stev024, #專櫃編號
       stev025 LIKE stev_t.stev025, #已交款金額
       stev026 LIKE stev_t.stev026, #納入結算單否
       stev027 LIKE stev_t.stev027, #票扣否
       stev028 LIKE stev_t.stev028, #數量
       stev029 LIKE stev_t.stev029, #單價
       stev030 LIKE stev_t.stev030, #備註
       stev031 LIKE stev_t.stev031, #費用歸屬類型
       stev032 LIKE stev_t.stev032  #費用歸屬組織
       END RECORD

DEFINE l_stbc RECORD  #結算底稿
       stbcent LIKE stbc_t.stbcent, #企業編號
       stbcsite LIKE stbc_t.stbcsite, #營運據點
       stbc001 LIKE stbc_t.stbc001, #結算中心
       stbc002 LIKE stbc_t.stbc002, #單據日期
       stbc003 LIKE stbc_t.stbc003, #單據類別
       stbc004 LIKE stbc_t.stbc004, #單據編號
       stbc005 LIKE stbc_t.stbc005, #項次
       stbc006 LIKE stbc_t.stbc006, #業務結算期
       stbc007 LIKE stbc_t.stbc007, #財務會計年度
       stbc008 LIKE stbc_t.stbc008, #對象編號
       stbc009 LIKE stbc_t.stbc009, #經營方式
       stbc010 LIKE stbc_t.stbc010, #結算方式
       stbc011 LIKE stbc_t.stbc011, #結算類型
       stbc012 LIKE stbc_t.stbc012, #費用編號
       stbc013 LIKE stbc_t.stbc013, #幣別
       stbc014 LIKE stbc_t.stbc014, #稅別
       stbc015 LIKE stbc_t.stbc015, #價款類別
       stbc016 LIKE stbc_t.stbc016, #方向
       stbc017 LIKE stbc_t.stbc017, #價外金額
       stbc018 LIKE stbc_t.stbc018, #價內金額
       stbc019 LIKE stbc_t.stbc019, #未結算金額
       stbc020 LIKE stbc_t.stbc020, #已結算金額
       stbc021 LIKE stbc_t.stbc021, #未校驗金額
       stbc022 LIKE stbc_t.stbc022, #已收款金額
       stbc023 LIKE stbc_t.stbc023, #未立帳金額
       stbc024 LIKE stbc_t.stbc024, #已立帳金額
       stbc025 LIKE stbc_t.stbc025, #所屬品類
       stbc026 LIKE stbc_t.stbc026, #所屬部門
       stbc027 LIKE stbc_t.stbc027, #對象類別
       stbc028 LIKE stbc_t.stbc028, #財務會計期別
       stbc029 LIKE stbc_t.stbc029, #網點編號
       stbc030 LIKE stbc_t.stbc030, #結算合約編號
       stbc031 LIKE stbc_t.stbc031, #承擔對象
       stbc032 LIKE stbc_t.stbc032, #結算對象
       stbcstus LIKE stbc_t.stbcstus, #狀態碼
       stbc033 LIKE stbc_t.stbc033, #专柜编号
       stbc034 LIKE stbc_t.stbc034, #數量
       stbc035 LIKE stbc_t.stbc035, #已立帳數量
       stbc036 LIKE stbc_t.stbc036, #單價
       stbc037 LIKE stbc_t.stbc037, #納入結算單否
       stbc038 LIKE stbc_t.stbc038, #票扣否
       stbc039 LIKE stbc_t.stbc039, #結算扣率
       stbc040 LIKE stbc_t.stbc040, #結算日期
       stbc041 LIKE stbc_t.stbc041, #日結成本類型
       stbc042 LIKE stbc_t.stbc042, #銷售金額
       stbc043 LIKE stbc_t.stbc043, #商品編號
       stbc044 LIKE stbc_t.stbc044, #商品品類
       stbc045 LIKE stbc_t.stbc045, #開始日期
       stbc046 LIKE stbc_t.stbc046, #結束日期
       stbc047 LIKE stbc_t.stbc047, #已立帳金額帳套二
       stbc048 LIKE stbc_t.stbc048, #已立帳金額帳套三
       stbc049 LIKE stbc_t.stbc049, #主帳套暫估金額
       stbc050 LIKE stbc_t.stbc050, #帳套二暫估金額
       stbc051 LIKE stbc_t.stbc051, #帳套三暫估金額
       stbc052 LIKE stbc_t.stbc052, #已立帳數量帳套二
       stbc053 LIKE stbc_t.stbc053, #已立帳數量帳套三
       stbc054 LIKE stbc_t.stbc054, #主帳套暫估數量
       stbc055 LIKE stbc_t.stbc055, #帳套二暫估數量
       stbc056 LIKE stbc_t.stbc056, #帳套三暫估數量
       stbc057 LIKE stbc_t.stbc057, #已結算數量
       stbc058 LIKE stbc_t.stbc058, #含發票否
       stbc059 LIKE stbc_t.stbc059, #費用歸屬類型
       stbc060 LIKE stbc_t.stbc060, #費用歸屬組織
       stbc061 LIKE stbc_t.stbc061, #應收結算金額
       stbc062 LIKE stbc_t.stbc062, #帳套二應收結算金額
       stbc063 LIKE stbc_t.stbc063, #帳套三應收結算金額
       stbc064 LIKE stbc_t.stbc064   #收入立帳否
       END RECORD
#161111-00028#3---MODIFY----END 
DEFINE l_rtdxcrtdt   DATETIME YEAR TO SECOND  #add by geza 20150629
DEFINE l_stan030     LIKE stan_t.stan030
   LET r_success=TRUE
  

#   LET g_sql = "SELECT * FROM stbc_t",
#               " WHERE stbcent='",g_enterprise,"'",
#               "   AND stbc001='",g_steu_m.steusite,"'",
#               "   AND stbc008='",g_steu_m.steu003,"'",
#               "   AND stbc009='",g_steu_m.steu004,"'",
#               "   AND (stbcstus='1' OR stbcstus='3')",
#               "   AND stbc030 ='",g_steu_m.steu001,"'",
#               "   AND stbc002<='",g_steu_m.steu007,"'",
#               "   AND stbc003='3' ",
#               "   AND stbc037='N' "
   #add by geza 20150630(S)
   #????????
   INITIALIZE l_stan030 TO NULL
   SELECT stan030 INTO l_stan030
     FROM stan_t  
    WHERE stanent = g_enterprise   
      AND stan001 = g_steu_m.steu001
   IF cl_null(l_stan030) THEN            
      #LET g_sql = "SELECT * FROM stbc_t", #161111-00028#3--mark
      #161111-00028#3---add----begin-----------
      LET g_sql = "SELECT stbcent,stbcsite,stbc001,stbc002,stbc003,stbc004,stbc005,stbc006,stbc007,stbc008,",
                  "stbc009,stbc010,stbc011,stbc012,stbc013,stbc014,stbc015,stbc016,stbc017,stbc018,stbc019,",
                  "stbc020,stbc021,stbc022,stbc023,stbc024,stbc025,stbc026,stbc027,stbc028,stbc029,stbc030,",
                  "stbc031,stbc032,stbcstus,stbc033,stbc034,stbc035,stbc036,stbc037,stbc038,",
                  "stbc039,stbc040,stbc041,stbc042,stbc043,stbc044,stbc045,stbc046,stbc047,",
                  "stbc048,stbc049,stbc050,stbc051,stbc052,stbc053,stbc054,stbc055,stbc056,",
                  "stbc057,stbc058,stbc059,stbc060,stbc061,stbc062,stbc063,stbc064 FROM stbc_t",
     #161111-00028#3---add----end-------------
               " WHERE stbcent='",g_enterprise,"'",
               "   AND stbc001='",g_steu_m.steusite,"'",
               "   AND stbc008='",g_steu_m.steu003,"'",
               "   AND stbc009='",g_steu_m.steu004,"'",
               "   AND (stbcstus='1' OR stbcstus='3')",
               "   AND stbc030 ='",g_steu_m.steu001,"'",
               "   AND stbc002<='",g_steu_m.steu007,"'",
               "   AND stbc003='3' ",
               "   AND stbc037='N' "                    
   ELSE
      #LET g_sql = "SELECT * FROM stbc_t", #161111-00028#3--mark
      #161111-00028#3---add----begin-----------
      LET g_sql = "SELECT stbcent,stbcsite,stbc001,stbc002,stbc003,stbc004,stbc005,stbc006,stbc007,stbc008,",
                  "stbc009,stbc010,stbc011,stbc012,stbc013,stbc014,stbc015,stbc016,stbc017,stbc018,stbc019,",
                  "stbc020,stbc021,stbc022,stbc023,stbc024,stbc025,stbc026,stbc027,stbc028,stbc029,stbc030,",
                  "stbc031,stbc032,stbcstus,stbc033,stbc034,stbc035,stbc036,stbc037,stbc038,",
                  "stbc039,stbc040,stbc041,stbc042,stbc043,stbc044,stbc045,stbc046,stbc047,",
                  "stbc048,stbc049,stbc050,stbc051,stbc052,stbc053,stbc054,stbc055,stbc056,",
                  "stbc057,stbc058,stbc059,stbc060,stbc061,stbc062,stbc063,stbc064 FROM stbc_t",
      #161111-00028#3---add----end-------------
               " WHERE stbcent='",g_enterprise,"'",
               "   AND stbc001='",g_steu_m.steusite,"'",
               "   AND stbc008='",g_steu_m.steu003,"'",
               "   AND stbc009='",g_steu_m.steu004,"'",
               "   AND (stbcstus='1' OR stbcstus='3')",
               "   AND stbc030 ='",g_steu_m.steu001,"' OR stbc030 = '",l_stan030,"'",
               "   AND stbc002<='",g_steu_m.steu007,"'",
               "   AND stbc003='3' ",
               "   AND stbc037='N' "
   END IF 
   IF g_type = '1' THEN       
      LET g_sql = g_sql, "   AND stbc033='",g_steu_m.steu002,"'",
                        "   ORDER BY stbc003 ASC,stbc015 DESC"
   ELSE
      LET g_sql = g_sql, "   AND stbc033 IS NULL",
                        "   ORDER BY stbc003 ASC,stbc015 DESC"
   END IF
   
   PREPARE astt550_insert_stbc_pb FROM g_sql
   DECLARE astt550_insert_stbe_cur CURSOR FOR astt550_insert_stbc_pb
       

   INITIALIZE l_stbc.* TO NULL
   
   FOREACH astt550_insert_stbe_cur INTO l_stbc.*
     # IF l_stbc.stbc003='3' AND (l_stbc.stbc015<>'1') THEN  #mark by geza 20160609
#     IF l_stbc.stbc003='3' AND (l_stbc.stbc037 <>'N') THEN
#         INITIALIZE l_stbc.* TO NULL
#         CONTINUE FOREACH
#      END IF      
      INITIALIZE l_stev.* TO NULL
      LET l_stev.stevent=g_enterprise
      LET l_stev.stevsite=l_stbc.stbcsite
      #LET l_stbe.stbecomp=''              #150514-00018#1--mark by dongsz
      #150514-00018#1--add by dongsz--str---
      SELECT ooef017 INTO l_stev.stevcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_steu_m.steusite
      #150514-00018#1--add by dongsz--end---
      LET l_stev.stevdocno=g_steu_m.steudocno
            
      SELECT MAX(stevseq)+1 INTO l_stev.stevseq
        FROM stev_t
       WHERE stevent=g_enterprise
         AND stevdocno=g_steu_m.steudocno
      IF cl_null(l_stev.stevseq) THEN
         LET l_stev.stevseq=1
      END IF               

      LET l_stev.stev001=l_stbc.stbc003
      LET l_stev.stev002=l_stbc.stbc004
      LET l_stev.stev003=l_stbc.stbc005
      LET l_stev.stev004=l_stbc.stbc002
      LET l_stev.stev005=l_stbc.stbc012
      LET l_stev.stev006=g_steu_m.steu006
      LET l_stev.stev007=g_steu_m.steu007
      LET l_stev.stev008=l_stbc.stbc013
      LET l_stev.stev009=l_stbc.stbc014
      LET l_stev.stev010=l_stbc.stbc015
      LET l_stev.stev011=l_stbc.stbc016
      LET l_stev.stev012=l_stbc.stbc017
      LET l_stev.stev013=l_stbc.stbc018
      LET l_stev.stev014=l_stbc.stbc019
      LET l_stev.stev015=l_stbc.stbc020
      LET l_stev.stev016=l_stbc.stbc019
      LET l_stev.stev017=l_stbc.stbc010
      LET l_stev.stev018=l_stbc.stbc011
      LET l_stev.stev019=l_stbc.stbc025
      LET l_stev.stev020=l_stbc.stbc026
      LET l_stev.stev025='0'
      #add by geza 20150914(S)
      LET l_stev.stev021='0' #add  by geza 20150604
      LET l_stev.stev022='0' #add  by geza 20150604
      LET l_stev.stev023='0' #add  by geza 20150604    
      LET l_stev.stev024=l_stbc.stbc033      
      LET l_stev.stev026=l_stbc.stbc037
      LET l_stev.stev027=l_stbc.stbc038
      #??????=?????????=?????
      LET l_stev.stev028=l_stbc.stbc034                   
      LET l_stev.stev029=l_stbc.stbc036        
      #add by geza 20150914(E)
      #mark by geza 20150914(S)
#      IF g_type = '1' THEN
#         LET l_stev.stev024=l_stbc.stbc033
#      ELSE
#         LET l_stev.stev024=g_steu_m.steu002
#      END IF      
      #mark by geza 20150914(E)
      #INSERT INTO stev_t VALUES (l_stev.*)  #161111-00028#3--mark
      #161111-00028#3---add----begin---------
      INSERT INTO stev_t (stevent,stevsite,stevcomp,stevdocno,stevseq,stev001,stev002,stev003,stev004,stev005,
                          stev006,stev007,stev008,stev009,stev010,stev011,stev012,stev013,stev014,stev015,
                          stev016,stev017,stev018,stev019,stev020,stev021,stev022,stev023,stev024,stev025,
                          stev026,stev027,stev028,stev029,stev030,stev031,stev032)
       VALUES (l_stev.stevent,l_stev.stevsite,l_stev.stevcomp,l_stev.stevdocno,l_stev.stevseq,l_stev.stev001,l_stev.stev002,l_stev.stev003,l_stev.stev004,l_stev.stev005,
               l_stev.stev006,l_stev.stev007,l_stev.stev008,l_stev.stev009,l_stev.stev010,l_stev.stev011,l_stev.stev012,l_stev.stev013,l_stev.stev014,l_stev.stev015,
               l_stev.stev016,l_stev.stev017,l_stev.stev018,l_stev.stev019,l_stev.stev020,l_stev.stev021,l_stev.stev022,l_stev.stev023,l_stev.stev024,l_stev.stev025,
               l_stev.stev026,l_stev.stev027,l_stev.stev028,l_stev.stev029,l_stev.stev030,l_stev.stev031,l_stev.stev032)
      
      #161111-00028#3---add----end-----------      
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "into stev_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success=FALSE
          RETURN r_success    
       END IF
       #mark by geza 20150629(S)  
#       UPDATE stbc_t SET stbcstus='2'
#        WHERE stbcent=g_enterprise
#          AND stbc001=l_stbc.stbc001
#          AND stbc004=l_stbc.stbc004
#          AND stbc005=l_stbc.stbc005
       #mark by geza 20150629(E)  
       ########################??  
       #add by geza 20150629(S)
       LET l_rtdxcrtdt = cl_get_current()
       UPDATE stbc_t SET stbcstus='2',
                         stbcud021 = l_rtdxcrtdt
        WHERE stbcent=g_enterprise
          AND stbc001=l_stbc.stbc001
          AND stbc004=l_stbc.stbc004
          AND stbc005=l_stbc.stbc005
       #add by geza 20150629(E)
       ########################??           
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "update stbc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success=FALSE
          RETURN r_success    
       END IF       
       


   END FOREACH
   
   FREE astt550_insert_stbc_pb

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 删除结算单跟新结算底稿
# Memo...........:
# Usage..........: CALL astt550_delete_updstbc()
# Date & Author..: 20150521 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_delete_updstbc()
DEFINE r_success     LIKE type_t.num5
DEFINE l_stev002     LIKE stev_t.stev002
DEFINE l_stev003     LIKE stev_t.stev003
DEFINE l_stbc018     LIKE stbc_t.stbc018
DEFINE l_stbc019     LIKE stbc_t.stbc019
DEFINE l_stbcstus    LIKE stbc_t.stbcstus
DEFINE l_rtdxcrtdt   DATETIME YEAR TO SECOND  #add by geza 20150629

   LET r_success=TRUE
  

   LET g_sql = "SELECT stev_t.stev002,stev_t.stev003 FROM steu_t,stev_t",
               " WHERE steuent=stevent",
               "   AND steudocno=stevdocno",
               "   AND steuent='",g_enterprise,"'",
               "   AND steudocno='",g_steu_m.steudocno,"'"
      
   PREPARE astt550_update_stbc_pb FROM g_sql
   DECLARE astt550_update_stev_cur CURSOR FOR astt550_update_stbc_pb
       

   LET l_stev002=''
   LET l_stev003=''
   
   FOREACH astt550_update_stev_cur INTO l_stev002,l_stev003

      LET l_stbc018=''
      LET l_stbc019=''
      LET l_stbcstus=''
      SELECT stbc018,stbc019,l_stbcstus INTO l_stbc018,l_stbc019,l_stbcstus
        FROM stbc_t
       WHERE stbcent=g_enterprise
         AND stbc001=g_steu_m.steusite
         AND stbc004=l_stev002
         AND stbc005=l_stev003
       
       IF cl_null(l_stbc018) THEN
          LET l_stbc018=0
       END IF          

       IF cl_null(l_stbc019) THEN
          LET l_stbc019=0
       END IF  
       
       IF l_stbc018=l_stbc019 THEN
          LET l_stbcstus='1'
       END IF
       
       IF 0<l_stbc019 AND l_stbc019<l_stbc018 THEN
          LET l_stbcstus='3'
       END IF
       #mark by geza 20150629(S) 
#       UPDATE stbc_t SET stbcstus=l_stbcstus
#        WHERE stbcent=g_enterprise
#          AND stbc001=g_steu_m.steusite
#          AND stbc004=l_stev002
#          AND stbc005=l_stev003
       #mark by geza 20150629(E)            
       ########################??  
       #add by geza 20150629(S)
       LET l_rtdxcrtdt = cl_get_current()
       UPDATE stbc_t SET stbcstus=l_stbcstus,
                         stbcud021 = l_rtdxcrtdt
        WHERE stbcent=g_enterprise
          AND stbc001=g_steu_m.steusite
          AND stbc004=l_stev002
          AND stbc005=l_stev003
       #add by geza 20150629(E)
       ########################??               
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "update stbc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success=FALSE
          RETURN r_success    
       END IF       
       


   END FOREACH
   
   FREE astt550_update_stbc_pb

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 根据合同带值
# Memo...........:
# Usage..........: CALL astt550_steu001_other2()
#                  RETURNING 回传参数
# Date & Author..: 20150604 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_steu001_other2()
DEFINE l_stcw004        LIKE stcw_t.stcw004  


   SELECT stan005,stan002 INTO 
          g_steu_m.steu003,g_steu_m.steu004
     FROM stan_t
    WHERE stanent=g_enterprise
      AND stan001=g_steu_m.steu001

   DISPLAY BY NAME g_steu_m.steu003,g_steu_m.steu004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_steu_m.steu003
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_steu_m.steu003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_steu_m.steu003_desc
   

   SELECT MIN(staxseq) INTO g_steu_m.steu005
     FROM stax_t
    WHERE staxent=g_enterprise
      AND stax001=g_steu_m.steu001
      AND stax005='N'
      
   SELECT stax002,stax003,stax004 INTO g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004
     FROM stax_t
    WHERE staxent=g_enterprise
      AND stax001=g_steu_m.steu001
      AND stax005='N'
      AND staxseq=g_steu_m.steu005

   DISPLAY BY NAME g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004,g_steu_m.steu005
END FUNCTION

################################################################################
# Descriptions...: 供应商带值
# Memo...........:
# Usage..........: CALL astt550_steu002_other()
#                  RETURNING 回传参数
# Date & Author..: 20150605 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_steu003_other()


    SELECT stfa001,stfa005,stfa003 INTO g_steu_m.steu001,g_steu_m.steu002,g_steu_m.steu004
      FROM stfa_t LEFT OUTER JOIN stfj_t ON stfaent = stfjent AND stfa001 = stfj001 AND stfj005 = 'N' 
     WHERE stfaent=g_enterprise
       AND stfa010=g_steu_m.steu003
       AND stfastus='Y' 
       AND stfa019<=g_today
       AND stfa020>=g_today AND rownum =1  

   
    SELECT MIN(stfjseq) INTO g_steu_m.steu005
     FROM stfj_t
    WHERE stfjent=g_enterprise
      AND stfj001=g_steu_m.steu001
      AND stfj005='N'
      
   SELECT stfj002,stfj003,stfj004 INTO g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004
     FROM stfj_t
    WHERE stfjent=g_enterprise
      AND stfj001=g_steu_m.steu001
      AND stfj005='N'
      AND stfjseq=g_steu_m.steu005
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_steu_m.steu002
   CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_steu_m.steu002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_steu_m.steu002_desc

   


   DISPLAY BY NAME g_steu_m.steu001,g_steu_m.steu002,g_steu_m.steu004,g_steu_m.steu005,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004
END FUNCTION

################################################################################
# Descriptions...: 供应商带值
# Memo...........:
# Usage..........: CALL astt550_steu003_other2()
#                  RETURNING 回传参数
# Date & Author..: 20150605 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_steu003_other2()
   SELECT stan001,stan002 INTO g_steu_m.steu001,g_steu_m.steu004
     FROM stan_t LEFT OUTER JOIN stax_t ON stanent = staxent AND stan001 = stax001 AND stax005 = 'N' 
    WHERE stanent=g_enterprise
      AND stan005=g_steu_m.steu003
      AND stanstus='Y' 
      AND stan017<=g_today
      AND stan018>=g_today AND rownum =1  

   
   SELECT MIN(staxseq) INTO g_steu_m.steu005
     FROM stax_t
    WHERE staxent=g_enterprise
      AND stax001=g_steu_m.steu001
      AND stax005='N'
      
   SELECT stax002,stax003,stax004 INTO g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004
     FROM stax_t
    WHERE staxent=g_enterprise
      AND stax001=g_steu_m.steu001
      AND stax005='N'
      AND staxseq=g_steu_m.steu005
 

   DISPLAY BY NAME g_steu_m.steu001,g_steu_m.steu004,g_steu_m.steu005,g_steu_m.steu006,g_steu_m.steu007,g_steu_m.stax004
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_steu003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_steu_m.steu003
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_steu_m.steu003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_steu_m.steu003_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_steu002_ref()
  INITIALIZE g_ref_fields TO NULL
  LET g_ref_fields[1] = g_steu_m.steu002
  CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
  LET g_steu_m.steu002_desc = '', g_rtn_fields[1] , ''
  DISPLAY BY NAME g_steu_m.steu002_desc
END FUNCTION

################################################################################
# Descriptions...: 专柜编号检查
# Memo...........:
# Usage..........: CALL astt550_steu002_chk(p_cmd)
#                  RETURNING TRUE/FALES
# Date & Author..: 20150608 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt550_steu002_chk(p_cmd)
DEFINE p_cmd       LIKE type_t.chr1
DEFINE l_stfa005   LIKE stfa_t.stfa005
    IF p_cmd != 'a' THEN #LANJJ ADD ON 2016-01-28 
       INITIALIZE l_stfa005 TO NULL
       IF NOT cl_null(g_steu_m.steu001) THEN
         SELECT stfa005 INTO l_stfa005
           FROM stfa_t
          WHERE stfaent = g_enterprise    
            AND stfa001 = g_steu_m.steu001
         IF l_stfa005 != g_steu_m.steu002 THEN          
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ast-00322"
            LET g_errparam.extend =''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE 
         END IF  
       END IF
    END IF
    RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 根据专柜合同资料带出合同编号、供应商编号、经营方式
# Date & Author..: 2015/07/21 By 廖龙
################################################################################
PRIVATE FUNCTION astt550_steu002_init()
   
   #根据专柜合同资料带出合同编号、供应商编号、经营方式
   SELECT stfa001,stfa010,stfa003 INTO g_steu_m.steu001,g_steu_m.steu003,g_steu_m.steu004
     FROM stfa_t
    WHERE stfa005 = g_steu_m.steu002
      AND stfaent = g_enterprise
      
   DISPLAY BY NAME g_steu_m.steu001
   DISPLAY BY NAME g_steu_m.steu003
   DISPLAY BY NAME g_steu_m.steu004
END FUNCTION

################################################################################
# Descriptions...: 输入来源单据带出单身其他栏位值
# Date & Author..: 15/07/23 By liaolong
# Date & Modify..: 15/08/12 By geza
################################################################################
PRIVATE FUNCTION astt550_stev_insert01()
DEFINE p_success     LIKE type_t.num5
#161111-00028#3--modfiy--begin------------
#DEFINE p_stbc RECORD LIKE stbc_t.*
#DEFINE p_stev RECORD LIKE stev_t.*
DEFINE p_stev RECORD  #交款彙總明細資料
       stevent LIKE stev_t.stevent, #企業編號
       stevsite LIKE stev_t.stevsite, #所屬組織
       stevcomp LIKE stev_t.stevcomp, #所屬法人
       stevdocno LIKE stev_t.stevdocno, #單據編號
       stevseq LIKE stev_t.stevseq, #單據項次
       stev001 LIKE stev_t.stev001, #來源類型
       stev002 LIKE stev_t.stev002, #來源單據
       stev003 LIKE stev_t.stev003, #來源項次
       stev004 LIKE stev_t.stev004, #來源日期
       stev005 LIKE stev_t.stev005, #費用編號
       stev006 LIKE stev_t.stev006, #起始日期
       stev007 LIKE stev_t.stev007, #截止日期
       stev008 LIKE stev_t.stev008, #幣別
       stev009 LIKE stev_t.stev009, #稅別
       stev010 LIKE stev_t.stev010, #價款類型
       stev011 LIKE stev_t.stev011, #方向
       stev012 LIKE stev_t.stev012, #價外金額
       stev013 LIKE stev_t.stev013, #價內金額
       stev014 LIKE stev_t.stev014, #未結算金額
       stev015 LIKE stev_t.stev015, #已結算金額
       stev016 LIKE stev_t.stev016, #本次結算金額
       stev017 LIKE stev_t.stev017, #結算方式
       stev018 LIKE stev_t.stev018, #結算類型
       stev019 LIKE stev_t.stev019, #所屬品類
       stev020 LIKE stev_t.stev020, #所屬部門
       stev021 LIKE stev_t.stev021, #主帳套帳款金額
       stev022 LIKE stev_t.stev022, #次帳套一帳款金額
       stev023 LIKE stev_t.stev023, #次帳套二帳款金額
       stev024 LIKE stev_t.stev024, #專櫃編號
       stev025 LIKE stev_t.stev025, #已交款金額
       stev026 LIKE stev_t.stev026, #納入結算單否
       stev027 LIKE stev_t.stev027, #票扣否
       stev028 LIKE stev_t.stev028, #數量
       stev029 LIKE stev_t.stev029, #單價
       stev030 LIKE stev_t.stev030, #備註
       stev031 LIKE stev_t.stev031, #費用歸屬類型
       stev032 LIKE stev_t.stev032  #費用歸屬組織
       END RECORD

DEFINE p_stbc RECORD  #結算底稿
       stbcent LIKE stbc_t.stbcent, #企業編號
       stbcsite LIKE stbc_t.stbcsite, #營運據點
       stbc001 LIKE stbc_t.stbc001, #結算中心
       stbc002 LIKE stbc_t.stbc002, #單據日期
       stbc003 LIKE stbc_t.stbc003, #單據類別
       stbc004 LIKE stbc_t.stbc004, #單據編號
       stbc005 LIKE stbc_t.stbc005, #項次
       stbc006 LIKE stbc_t.stbc006, #業務結算期
       stbc007 LIKE stbc_t.stbc007, #財務會計年度
       stbc008 LIKE stbc_t.stbc008, #對象編號
       stbc009 LIKE stbc_t.stbc009, #經營方式
       stbc010 LIKE stbc_t.stbc010, #結算方式
       stbc011 LIKE stbc_t.stbc011, #結算類型
       stbc012 LIKE stbc_t.stbc012, #費用編號
       stbc013 LIKE stbc_t.stbc013, #幣別
       stbc014 LIKE stbc_t.stbc014, #稅別
       stbc015 LIKE stbc_t.stbc015, #價款類別
       stbc016 LIKE stbc_t.stbc016, #方向
       stbc017 LIKE stbc_t.stbc017, #價外金額
       stbc018 LIKE stbc_t.stbc018, #價內金額
       stbc019 LIKE stbc_t.stbc019, #未結算金額
       stbc020 LIKE stbc_t.stbc020, #已結算金額
       stbc021 LIKE stbc_t.stbc021, #未校驗金額
       stbc022 LIKE stbc_t.stbc022, #已收款金額
       stbc023 LIKE stbc_t.stbc023, #未立帳金額
       stbc024 LIKE stbc_t.stbc024, #已立帳金額
       stbc025 LIKE stbc_t.stbc025, #所屬品類
       stbc026 LIKE stbc_t.stbc026, #所屬部門
       stbc027 LIKE stbc_t.stbc027, #對象類別
       stbc028 LIKE stbc_t.stbc028, #財務會計期別
       stbc029 LIKE stbc_t.stbc029, #網點編號
       stbc030 LIKE stbc_t.stbc030, #結算合約編號
       stbc031 LIKE stbc_t.stbc031, #承擔對象
       stbc032 LIKE stbc_t.stbc032, #結算對象
       stbcstus LIKE stbc_t.stbcstus, #狀態碼
       stbc033 LIKE stbc_t.stbc033, #专柜编号
       stbc034 LIKE stbc_t.stbc034, #數量
       stbc035 LIKE stbc_t.stbc035, #已立帳數量
       stbc036 LIKE stbc_t.stbc036, #單價
       stbc037 LIKE stbc_t.stbc037, #納入結算單否
       stbc038 LIKE stbc_t.stbc038, #票扣否
       stbc039 LIKE stbc_t.stbc039, #結算扣率
       stbc040 LIKE stbc_t.stbc040, #結算日期
       stbc041 LIKE stbc_t.stbc041, #日結成本類型
       stbc042 LIKE stbc_t.stbc042, #銷售金額
       stbc043 LIKE stbc_t.stbc043, #商品編號
       stbc044 LIKE stbc_t.stbc044, #商品品類
       stbc045 LIKE stbc_t.stbc045, #開始日期
       stbc046 LIKE stbc_t.stbc046, #結束日期
       stbc047 LIKE stbc_t.stbc047, #已立帳金額帳套二
       stbc048 LIKE stbc_t.stbc048, #已立帳金額帳套三
       stbc049 LIKE stbc_t.stbc049, #主帳套暫估金額
       stbc050 LIKE stbc_t.stbc050, #帳套二暫估金額
       stbc051 LIKE stbc_t.stbc051, #帳套三暫估金額
       stbc052 LIKE stbc_t.stbc052, #已立帳數量帳套二
       stbc053 LIKE stbc_t.stbc053, #已立帳數量帳套三
       stbc054 LIKE stbc_t.stbc054, #主帳套暫估數量
       stbc055 LIKE stbc_t.stbc055, #帳套二暫估數量
       stbc056 LIKE stbc_t.stbc056, #帳套三暫估數量
       stbc057 LIKE stbc_t.stbc057, #已結算數量
       stbc058 LIKE stbc_t.stbc058, #含發票否
       stbc059 LIKE stbc_t.stbc059, #費用歸屬類型
       stbc060 LIKE stbc_t.stbc060, #費用歸屬組織
       stbc061 LIKE stbc_t.stbc061, #應收結算金額
       stbc062 LIKE stbc_t.stbc062, #帳套二應收結算金額
       stbc063 LIKE stbc_t.stbc063, #帳套三應收結算金額
       stbc064 LIKE stbc_t.stbc064   #收入立帳否
       END RECORD
#161111-00028#3---MODIFY----END 
DEFINE p_stan030     LIKE stan_t.stan030
DEFINE l_cnt         LIKE type_t.num10   #add by geza 20150812
   LET p_success=TRUE
   #???????????????
   LET l_cnt = 0         
   SELECT COUNT(*) INTO l_cnt 
     FROM stbc_t  
    WHERE stbcent=g_enterprise
      AND stbc001=g_steu_m.steusite
      AND (stbcstus='1' OR stbcstus='3')
      AND stbc004 =g_stev_d[l_ac].stev002
      AND stbc005 =g_stev_d[l_ac].stev003
      AND stbc003='3'
      AND stbc037='N'                    
   IF l_cnt <= 0 THEN
      LET p_success = FALSE
      RETURN p_success
   END IF          
   #LET g_sql = "SELECT * FROM stbc_t", #161111-00028#3--mark
   #161111-00028#3---add----begin-----------
   LET g_sql = "SELECT stbcent,stbcsite,stbc001,stbc002,stbc003,stbc004,stbc005,stbc006,stbc007,stbc008,",
               "stbc009,stbc010,stbc011,stbc012,stbc013,stbc014,stbc015,stbc016,stbc017,stbc018,stbc019,",
               "stbc020,stbc021,stbc022,stbc023,stbc024,stbc025,stbc026,stbc027,stbc028,stbc029,stbc030,",
               "stbc031,stbc032,stbcstus,stbc033,stbc034,stbc035,stbc036,stbc037,stbc038,",
               "stbc039,stbc040,stbc041,stbc042,stbc043,stbc044,stbc045,stbc046,stbc047,",
               "stbc048,stbc049,stbc050,stbc051,stbc052,stbc053,stbc054,stbc055,stbc056,",
               "stbc057,stbc058,stbc059,stbc060,stbc061,stbc062,stbc063,stbc064 FROM stbc_t",
    #161111-00028#3---add----end-------------
           " WHERE stbcent='",g_enterprise,"'",
           "   AND stbc001='",g_steu_m.steusite,"'",    
           "   AND (stbcstus='1' OR stbcstus='3')",
           "   AND stbc004='",g_stev_d[l_ac].stev002 ,"'", 
           "   AND stbc005='",g_stev_d[l_ac].stev003 ,"'",
           "   AND stbc003='3' ",
           "   AND stbc037='N' "                 
   LET g_sql = g_sql, "   AND stbc033='",g_steu_m.steu002,"'",
                      "   ORDER BY stbc003 ASC,stbc015 DESC"
    
   
   PREPARE astt550_insert_stbc_ot FROM g_sql
   DECLARE astt550_insert_stev1_cur CURSOR FOR astt550_insert_stbc_ot
       

   INITIALIZE p_stbc.* TO NULL
   
   FOREACH astt550_insert_stev1_cur INTO p_stbc.*   
      INITIALIZE p_stev.* TO NULL
      LET p_stev.stevent=g_enterprise
      LET p_stev.stevsite=p_stbc.stbcsite
 
      SELECT ooef017 INTO p_stev.stevcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_steu_m.steusite
      
#      LET p_stev.stevdocno=g_steu_m.steudocno               
#      SELECT MAX(stevseq) INTO p_stev.stevseq
#        FROM stev_t
#       WHERE stevent=g_enterprise
#         AND stevdocno=g_steu_m.steudocno
#     
#      IF cl_null(p_stev.stevseq) THEN
#         LET p_stev.stevseq=1
#      END IF               
      #LET g_stev_d[l_ac].stevseq = l_ac           #mark by geza 20150812
      LET g_stev_d[l_ac].stev001 = p_stbc.stbc003
#      LET g_stev_d[l_ac].stev002 = p_stbc.stbc004 #mark by geza 20150812
#      LET g_stev_d[l_ac].stev003 = p_stbc.stbc005 #mark by geza 20150812
      LET g_stev_d[l_ac].stev004 = p_stbc.stbc002
      LET g_stev_d[l_ac].stev005 = p_stbc.stbc012
      LET g_stev_d[l_ac].stev006 = g_steu_m.steu006
      LET g_stev_d[l_ac].stev007 = g_steu_m.steu007
      LET g_stev_d[l_ac].stev008 = p_stbc.stbc013
      LET g_stev_d[l_ac].stev009 = p_stbc.stbc014
      LET g_stev_d[l_ac].stev010 = p_stbc.stbc015
      LET g_stev_d[l_ac].stev011 = p_stbc.stbc016
      LET g_stev_d[l_ac].stev012 = p_stbc.stbc017
      LET g_stev_d[l_ac].stev013 = p_stbc.stbc018
      LET g_stev_d[l_ac].stev014 = p_stbc.stbc019
      LET g_stev_d[l_ac].stev015 = p_stbc.stbc020
      LET g_stev_d[l_ac].stev016 = p_stbc.stbc019
      LET g_stev_d[l_ac].stev017 = p_stbc.stbc010
      LET g_stev_d[l_ac].stev018 = p_stbc.stbc011
      LET g_stev_d[l_ac].stev019 = p_stbc.stbc025
      LET g_stev_d[l_ac].stev020 = p_stbc.stbc026
      LET g_stev_d[l_ac].stev024 = p_stbc.stbc033
      LET g_stev_d[l_ac].stevsite = p_stbc.stbcsite
      #??????=??????-????????=?????
      LET g_stev_d[l_ac].stev028 = p_stbc.stbc034-p_stbc.stbc035   #?? #add by geza 20150814
      LET g_stev_d[l_ac].stev029 = p_stbc.stbc036                  #?? #add by geza 20150814
      LET g_stev_d[l_ac].stev025 = '0'      

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stev_d[l_ac].stev005
      CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stev_d[l_ac].stev005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stev_d[l_ac].stev005_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stev_d[l_ac].stev008
      CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stev_d[l_ac].stev008_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stev_d[l_ac].stev008_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stev_d[l_ac].stevsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stev_d[l_ac].stevsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stev_d[l_ac].stevsite_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stev_d[l_ac].stev020
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stev_d[l_ac].stev020_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stev_d[l_ac].stev020_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stev_d[l_ac].stev019
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stev_d[l_ac].stev019_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stev_d[l_ac].stev019_desc
      LET p_stev.stev024=p_stbc.stbc033
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stev_d[l_ac].stev024
      CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stev_d[l_ac].stev024_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stev_d[l_ac].stev024_desc
     
    
#      INSERT INTO stev_t VALUES (p_stev.*)    
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "into stev_t"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET p_success=FALSE
#         RETURN p_success    
#      END IF     
#      
#      UPDATE stbc_t SET stbcstus='2'
#       WHERE stbcent=g_enterprise
#         AND stbc001=p_stbc.stbc001
#         AND stbc004=p_stbc.stbc004
#         AND stbc005=p_stbc.stbc005   
#        
#      IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL
#          LET g_errparam.code = SQLCA.sqlcode
#          LET g_errparam.extend = "update stbc_t"
#          LET g_errparam.popup = TRUE
#          CALL cl_err()
#          LET p_success=FALSE
#          RETURN p_success    
#       END IF             
   END FOREACH
   
   FREE astt550_insert_stbc_ot

   RETURN p_success


END FUNCTION

 
{</section>}
 
