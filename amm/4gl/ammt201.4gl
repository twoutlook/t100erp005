#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt201.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2014-12-29 09:51:16), PR版次:0014(2016-11-21 15:35:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000373
#+ Filename...: ammt201
#+ Description: 會員等級升降策略申請作業
#+ Creator....: 01533(2013-11-28 16:27:55)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="ammt201.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
#160816-00068#4   2016/08/16 By earl    調整transaction
#160818-00017#21  2016/08/26 By 08742   删除修改未重新判断状态码
#160905-00007#6   2016/09/05 By 02599   SQL条件增加ent
#160824-00007#107 2016/11/17 By sakura  新舊值備份處理
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
PRIVATE type type_g_mmcr_m        RECORD
       mmcrsite LIKE mmcr_t.mmcrsite, 
   mmcrsite_desc LIKE type_t.chr80, 
   mmcrdocdt LIKE mmcr_t.mmcrdocdt, 
   mmcrdocno LIKE mmcr_t.mmcrdocno, 
   mmcr000 LIKE mmcr_t.mmcr000, 
   mmcrunit LIKE mmcr_t.mmcrunit, 
   mmcr001 LIKE mmcr_t.mmcr001, 
   mmcr002 LIKE mmcr_t.mmcr002, 
   mmcrl002 LIKE type_t.chr500, 
   mmcrl003 LIKE type_t.chr500, 
   mmcr004 LIKE mmcr_t.mmcr004, 
   mmcr005 LIKE mmcr_t.mmcr005, 
   mmcracti LIKE mmcr_t.mmcracti, 
   mmcrstus LIKE mmcr_t.mmcrstus, 
   mmcrownid LIKE mmcr_t.mmcrownid, 
   mmcrownid_desc LIKE type_t.chr80, 
   mmcrowndp LIKE mmcr_t.mmcrowndp, 
   mmcrowndp_desc LIKE type_t.chr80, 
   mmcrcrtid LIKE mmcr_t.mmcrcrtid, 
   mmcrcrtid_desc LIKE type_t.chr80, 
   mmcrcrtdp LIKE mmcr_t.mmcrcrtdp, 
   mmcrcrtdp_desc LIKE type_t.chr80, 
   mmcrcrtdt LIKE mmcr_t.mmcrcrtdt, 
   mmcrmodid LIKE mmcr_t.mmcrmodid, 
   mmcrmodid_desc LIKE type_t.chr80, 
   mmcrmoddt LIKE mmcr_t.mmcrmoddt, 
   mmcrcnfid LIKE mmcr_t.mmcrcnfid, 
   mmcrcnfid_desc LIKE type_t.chr80, 
   mmcrcnfdt LIKE mmcr_t.mmcrcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmcs_d        RECORD
       mmcs001 LIKE mmcs_t.mmcs001, 
   mmcs002 LIKE mmcs_t.mmcs002, 
   mmcs002_desc LIKE type_t.chr500, 
   mmcs003 LIKE mmcs_t.mmcs003, 
   mmcs004 LIKE mmcs_t.mmcs004, 
   mmcs005 LIKE mmcs_t.mmcs005, 
   mmcs006 LIKE mmcs_t.mmcs006, 
   mmcs007 LIKE mmcs_t.mmcs007, 
   mmcs008 LIKE mmcs_t.mmcs008, 
   mmcsacti LIKE mmcs_t.mmcsacti, 
   mmcsunit LIKE mmcs_t.mmcsunit, 
   mmcssite LIKE mmcs_t.mmcssite
       END RECORD
PRIVATE TYPE type_g_mmcs2_d RECORD
       mmct001 LIKE mmct_t.mmct001, 
   mmct002 LIKE mmct_t.mmct002, 
   mmct002_desc LIKE type_t.chr500, 
   mmctacti LIKE mmct_t.mmctacti, 
   mmctunit LIKE mmct_t.mmctunit, 
   mmctsite LIKE mmct_t.mmctsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mmcrsite LIKE mmcr_t.mmcrsite,
   b_mmcrsite_desc LIKE type_t.chr80,
      b_mmcrdocdt LIKE mmcr_t.mmcrdocdt,
      b_mmcrdocno LIKE mmcr_t.mmcrdocno,
      b_mmcr000 LIKE mmcr_t.mmcr000,
      b_mmcr001 LIKE mmcr_t.mmcr001,
      b_mmcr002 LIKE mmcr_t.mmcr002,
   b_mmcr001_desc LIKE type_t.chr80,
      b_mmcr004 LIKE mmcr_t.mmcr004,
      b_mmcr005 LIKE mmcr_t.mmcr005,
      b_mmcracti LIKE mmcr_t.mmcracti,
      b_mmcrunit LIKE mmcr_t.mmcrunit
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wcb                 STRING
DEFINE g_tree      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       #外顯欄位
       b_show          LIKE type_t.chr100,
       #父節點id
       b_pid           LIKE type_t.chr100,
       #本身節點id
       b_id            LIKE type_t.chr100,
       #是否展開
       b_exp           LIKE type_t.chr100,
       #是否有子節點
       b_hasC          LIKE type_t.num5,
       #是否已展開
       b_isExp         LIKE type_t.num5,
       #展開值
       b_expcode       LIKE type_t.num5

       END RECORD 
DEFINE l_show_t   DYNAMIC ARRAY OF RECORD
      show   LIKE  type_t.chr100,
      seq    LIKE  type_t.num5
     END RECORD
DEFINE g_ooef004      LIKE ooef_t.ooef004
DEFINE g_ooef005      LIKE ooef_t.ooef005
DEFINE g_assign_no    LIKE type_t.chr1
DEFINE t_mmcr001      LIKE mmcr_t.mmcr001
DEFINE g_flag         LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mmcr_m          type_g_mmcr_m
DEFINE g_mmcr_m_t        type_g_mmcr_m
DEFINE g_mmcr_m_o        type_g_mmcr_m
DEFINE g_mmcr_m_mask_o   type_g_mmcr_m #轉換遮罩前資料
DEFINE g_mmcr_m_mask_n   type_g_mmcr_m #轉換遮罩後資料
 
   DEFINE g_mmcrdocno_t LIKE mmcr_t.mmcrdocno
 
 
DEFINE g_mmcs_d          DYNAMIC ARRAY OF type_g_mmcs_d
DEFINE g_mmcs_d_t        type_g_mmcs_d
DEFINE g_mmcs_d_o        type_g_mmcs_d
DEFINE g_mmcs_d_mask_o   DYNAMIC ARRAY OF type_g_mmcs_d #轉換遮罩前資料
DEFINE g_mmcs_d_mask_n   DYNAMIC ARRAY OF type_g_mmcs_d #轉換遮罩後資料
DEFINE g_mmcs2_d          DYNAMIC ARRAY OF type_g_mmcs2_d
DEFINE g_mmcs2_d_t        type_g_mmcs2_d
DEFINE g_mmcs2_d_o        type_g_mmcs2_d
DEFINE g_mmcs2_d_mask_o   DYNAMIC ARRAY OF type_g_mmcs2_d #轉換遮罩前資料
DEFINE g_mmcs2_d_mask_n   DYNAMIC ARRAY OF type_g_mmcs2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      mmcrldocno LIKE mmcrl_t.mmcrldocno,
      mmcrl002 LIKE mmcrl_t.mmcrl002,
      mmcrl003 LIKE mmcrl_t.mmcrl003
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
DEFINE g_site_flag   LIKE type_t.num5 #sakura add
#end add-point
 
{</section>}
 
{<section id="ammt201.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5    #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
   #150424-00018#1 150528 add by beckxie---S
   IF cl_get_para(g_enterprise,g_site,'E-CIR-0034')='N' THEN
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00453'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      CALL cl_ap_exitprogram("0")
   END IF
   #150424-00018#1 150528 add by beckxie---E
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mmcrsite,'',mmcrdocdt,mmcrdocno,mmcr000,mmcrunit,mmcr001,mmcr002,'','', 
       mmcr004,mmcr005,mmcracti,mmcrstus,mmcrownid,'',mmcrowndp,'',mmcrcrtid,'',mmcrcrtdp,'',mmcrcrtdt, 
       mmcrmodid,'',mmcrmoddt,mmcrcnfid,'',mmcrcnfdt", 
                      " FROM mmcr_t",
                      " WHERE mmcrent= ? AND mmcrdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt201_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mmcrsite,t0.mmcrdocdt,t0.mmcrdocno,t0.mmcr000,t0.mmcrunit,t0.mmcr001, 
       t0.mmcr002,t0.mmcr004,t0.mmcr005,t0.mmcracti,t0.mmcrstus,t0.mmcrownid,t0.mmcrowndp,t0.mmcrcrtid, 
       t0.mmcrcrtdp,t0.mmcrcrtdt,t0.mmcrmodid,t0.mmcrmoddt,t0.mmcrcnfid,t0.mmcrcnfdt,t1.ooefl003 ,t2.ooag011 , 
       t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011",
               " FROM mmcr_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmcrsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.mmcrownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmcrowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mmcrcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.mmcrcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mmcrmodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mmcrcnfid  ",
 
               " WHERE t0.mmcrent = " ||g_enterprise|| " AND t0.mmcrdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ammt201_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammt201 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammt201_init()   
 
      #進入選單 Menu (="N")
      CALL ammt201_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammt201
      
   END IF 
   
   CLOSE ammt201_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammt201.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt201_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
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
      CALL cl_set_combo_scc_part('mmcrstus','13','N,Y,X')
 
      CALL cl_set_combo_scc('mmcr000','32') 
   CALL cl_set_combo_scc('mmcs005','6532') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_mmcr000','32') 
   
   LET g_ooef004 = ''
   LET g_ooef005 = ''
   SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   IF cl_null(g_ooef005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00008'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF  
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
   
   #初始化搜尋條件
   CALL ammt201_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="ammt201.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION ammt201_ui_dialog()
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
            CALL ammt201_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL ammt201_tree_fill()
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_mmcr_m.* TO NULL
         CALL g_mmcs_d.clear()
         CALL g_mmcs2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ammt201_init()
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
               
               CALL ammt201_fetch('') # reload data
               LET l_ac = 1
               CALL ammt201_ui_detailshow() #Setting the current row 
         
               CALL ammt201_idx_chk()
               #NEXT FIELD mmcs002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mmcs_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt201_idx_chk()
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
               CALL ammt201_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_mmcs2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt201_idx_chk()
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
               CALL ammt201_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_tree TO s_tree.*



         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL ammt201_browser_fill("")
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
               CALL ammt201_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL ammt201_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL ammt201_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL ammt201_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL ammt201_set_act_visible()   
            CALL ammt201_set_act_no_visible()
            IF NOT (g_mmcr_m.mmcrdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mmcrent = " ||g_enterprise|| " AND",
                                  " mmcrdocno = '", g_mmcr_m.mmcrdocno, "' "
 
               #填到對應位置
               CALL ammt201_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mmcr_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmcs_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmct_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL ammt201_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mmcr_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmcs_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmct_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL ammt201_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt201_fetch("F")
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
               CALL ammt201_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL ammt201_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt201_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL ammt201_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt201_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL ammt201_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt201_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL ammt201_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt201_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL ammt201_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt201_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmcs_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mmcs2_d)
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
               NEXT FIELD mmcs002
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
               CALL ammt201_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL ammt201_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt201_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt201_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amm/ammt201_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amm/ammt201_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL ammt201_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt201_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt201_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt201_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt201_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mmcr_m.mmcrdocdt)
 
 
 
         
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
 
{<section id="ammt201.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION ammt201_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING #sakura add
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   CALL s_aooi500_sql_where(g_prog,'mmcrsite') RETURNING l_where #sakura add
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
      LET l_sub_sql = " SELECT DISTINCT mmcrdocno ",
                      " FROM mmcr_t ",
                      " ",
                      " LEFT JOIN mmcs_t ON mmcsent = mmcrent AND mmcrdocno = mmcsdocno ", "  ",
                      #add-point:browser_fill段sql(mmcs_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN mmct_t ON mmctent = mmcrent AND mmcrdocno = mmctdocno", "  ",
                      #add-point:browser_fill段sql(mmct_t1) name="browser_fill.cnt.join.mmct_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN mmcrl_t ON mmcrlent = "||g_enterprise||" AND mmcrdocno = mmcrldocno AND mmcrl001 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE mmcrent = " ||g_enterprise|| " AND mmcsent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mmcr_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mmcrdocno ",
                      " FROM mmcr_t ", 
                      "  ",
                      "  LEFT JOIN mmcrl_t ON mmcrlent = "||g_enterprise||" AND mmcrdocno = mmcrldocno AND mmcrl001 = '",g_dlang,"' ",
                      " WHERE mmcrent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mmcr_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where #sakura add
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
      INITIALIZE g_mmcr_m.* TO NULL
      CALL g_mmcs_d.clear()        
      CALL g_mmcs2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mmcrsite,t0.mmcrdocdt,t0.mmcrdocno,t0.mmcr000,t0.mmcr001,t0.mmcr002,t0.mmcr004,t0.mmcr005,t0.mmcracti,t0.mmcrunit Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmcrstus,t0.mmcrsite,t0.mmcrdocdt,t0.mmcrdocno,t0.mmcr000,t0.mmcr001, 
          t0.mmcr002,t0.mmcr004,t0.mmcr005,t0.mmcracti,t0.mmcrunit,t1.ooefl003 ,t2.mmcrl002 ",
                  " FROM mmcr_t t0",
                  "  ",
                  "  LEFT JOIN mmcs_t ON mmcsent = mmcrent AND mmcrdocno = mmcsdocno ", "  ", 
                  #add-point:browser_fill段sql(mmcs_t1) name="browser_fill.join.mmcs_t1"
                  
                  #end add-point
                  "  LEFT JOIN mmct_t ON mmctent = mmcrent AND mmcrdocno = mmctdocno", "  ", 
                  #add-point:browser_fill段sql(mmct_t1) name="browser_fill.join.mmct_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmcrsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mmcrl_t t2 ON t2.mmcrlent="||g_enterprise||" AND t2.mmcrldocno=t0.mmcr001 AND t2.mmcrl001='"||g_dlang||"' ",
 
                  " WHERE t0.mmcrent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mmcr_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmcrstus,t0.mmcrsite,t0.mmcrdocdt,t0.mmcrdocno,t0.mmcr000,t0.mmcr001, 
          t0.mmcr002,t0.mmcr004,t0.mmcr005,t0.mmcracti,t0.mmcrunit,t1.ooefl003 ,t2.mmcrl002 ",
                  " FROM mmcr_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmcrsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mmcrl_t t2 ON t2.mmcrlent="||g_enterprise||" AND t2.mmcrldocno=t0.mmcr001 AND t2.mmcrl001='"||g_dlang||"' ",
 
                  " WHERE t0.mmcrent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mmcr_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where #sakura add
   #end add-point
   LET g_sql = g_sql, " ORDER BY mmcrdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmcr_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmcrsite,g_browser[g_cnt].b_mmcrdocdt, 
          g_browser[g_cnt].b_mmcrdocno,g_browser[g_cnt].b_mmcr000,g_browser[g_cnt].b_mmcr001,g_browser[g_cnt].b_mmcr002, 
          g_browser[g_cnt].b_mmcr004,g_browser[g_cnt].b_mmcr005,g_browser[g_cnt].b_mmcracti,g_browser[g_cnt].b_mmcrunit, 
          g_browser[g_cnt].b_mmcrsite_desc,g_browser[g_cnt].b_mmcr001_desc
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
         CALL ammt201_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_mmcrdocno) THEN
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
 
{<section id="ammt201.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION ammt201_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mmcr_m.mmcrdocno = g_browser[g_current_idx].b_mmcrdocno   
 
   EXECUTE ammt201_master_referesh USING g_mmcr_m.mmcrdocno INTO g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt, 
       g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrcrtid, 
       g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt,g_mmcr_m.mmcrcnfid, 
       g_mmcr_m.mmcrcnfdt,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrownid_desc,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid_desc, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrcnfid_desc
   
   CALL ammt201_mmcr_t_mask()
   CALL ammt201_show()
      
END FUNCTION
 
{</section>}
 
{<section id="ammt201.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION ammt201_ui_detailshow()
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
 
{<section id="ammt201.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt201_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmcrdocno = g_mmcr_m.mmcrdocno 
 
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
 
{<section id="ammt201.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt201_construct()
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
   INITIALIZE g_mmcr_m.* TO NULL
   CALL g_mmcs_d.clear()        
   CALL g_mmcs2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON mmcrsite,mmcrdocdt,mmcrdocno,mmcr000,mmcrunit,mmcr001,mmcr002,mmcrl002, 
          mmcrl003,mmcr004,mmcr005,mmcracti,mmcrstus,mmcrownid,mmcrowndp,mmcrcrtid,mmcrcrtdp,mmcrcrtdt, 
          mmcrmodid,mmcrmoddt,mmcrcnfid,mmcrcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmcrcrtdt>>----
         AFTER FIELD mmcrcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmcrmoddt>>----
         AFTER FIELD mmcrmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmcrcnfdt>>----
         AFTER FIELD mmcrcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmcrpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mmcrsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrsite
            #add-point:ON ACTION controlp INFIELD mmcrsite name="construct.c.mmcrsite"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			  #LET g_qryparam.arg1 = '2'
			  #LET g_qryparam.where = "ooef201 = 'Y'"           #sakura mark
           #CALL q_ooef001()                        #呼叫開窗 #sakura mark
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmcrsite',g_site,'c') #sakura add  #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                     #呼叫開窗                   #sakura add
            DISPLAY g_qryparam.return1 TO mmcrsite  #顯示到畫面上
            NEXT FIELD mmcrsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrsite
            #add-point:BEFORE FIELD mmcrsite name="construct.b.mmcrsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrsite
            
            #add-point:AFTER FIELD mmcrsite name="construct.a.mmcrsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrdocdt
            #add-point:BEFORE FIELD mmcrdocdt name="construct.b.mmcrdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrdocdt
            
            #add-point:AFTER FIELD mmcrdocdt name="construct.a.mmcrdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcrdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrdocdt
            #add-point:ON ACTION controlp INFIELD mmcrdocdt name="construct.c.mmcrdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmcrdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrdocno
            #add-point:ON ACTION controlp INFIELD mmcrdocno name="construct.c.mmcrdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmcrdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcrdocno  #顯示到畫面上

            NEXT FIELD mmcrdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrdocno
            #add-point:BEFORE FIELD mmcrdocno name="construct.b.mmcrdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrdocno
            
            #add-point:AFTER FIELD mmcrdocno name="construct.a.mmcrdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr000
            #add-point:BEFORE FIELD mmcr000 name="construct.b.mmcr000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr000
            
            #add-point:AFTER FIELD mmcr000 name="construct.a.mmcr000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcr000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr000
            #add-point:ON ACTION controlp INFIELD mmcr000 name="construct.c.mmcr000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrunit
            #add-point:BEFORE FIELD mmcrunit name="construct.b.mmcrunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrunit
            
            #add-point:AFTER FIELD mmcrunit name="construct.a.mmcrunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcrunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrunit
            #add-point:ON ACTION controlp INFIELD mmcrunit name="construct.c.mmcrunit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmcr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr001
            #add-point:ON ACTION controlp INFIELD mmcr001 name="construct.c.mmcr001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmcu001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcr001  #顯示到畫面上

            NEXT FIELD mmcr001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr001
            #add-point:BEFORE FIELD mmcr001 name="construct.b.mmcr001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr001
            
            #add-point:AFTER FIELD mmcr001 name="construct.a.mmcr001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr002
            #add-point:BEFORE FIELD mmcr002 name="construct.b.mmcr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr002
            
            #add-point:AFTER FIELD mmcr002 name="construct.a.mmcr002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcr002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr002
            #add-point:ON ACTION controlp INFIELD mmcr002 name="construct.c.mmcr002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrl002
            #add-point:BEFORE FIELD mmcrl002 name="construct.b.mmcrl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrl002
            
            #add-point:AFTER FIELD mmcrl002 name="construct.a.mmcrl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcrl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrl002
            #add-point:ON ACTION controlp INFIELD mmcrl002 name="construct.c.mmcrl002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrl003
            #add-point:BEFORE FIELD mmcrl003 name="construct.b.mmcrl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrl003
            
            #add-point:AFTER FIELD mmcrl003 name="construct.a.mmcrl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcrl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrl003
            #add-point:ON ACTION controlp INFIELD mmcrl003 name="construct.c.mmcrl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr004
            #add-point:BEFORE FIELD mmcr004 name="construct.b.mmcr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr004
            
            #add-point:AFTER FIELD mmcr004 name="construct.a.mmcr004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr004
            #add-point:ON ACTION controlp INFIELD mmcr004 name="construct.c.mmcr004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr005
            #add-point:BEFORE FIELD mmcr005 name="construct.b.mmcr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr005
            
            #add-point:AFTER FIELD mmcr005 name="construct.a.mmcr005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcr005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr005
            #add-point:ON ACTION controlp INFIELD mmcr005 name="construct.c.mmcr005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcracti
            #add-point:BEFORE FIELD mmcracti name="construct.b.mmcracti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcracti
            
            #add-point:AFTER FIELD mmcracti name="construct.a.mmcracti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcracti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcracti
            #add-point:ON ACTION controlp INFIELD mmcracti name="construct.c.mmcracti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrstus
            #add-point:BEFORE FIELD mmcrstus name="construct.b.mmcrstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrstus
            
            #add-point:AFTER FIELD mmcrstus name="construct.a.mmcrstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcrstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrstus
            #add-point:ON ACTION controlp INFIELD mmcrstus name="construct.c.mmcrstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmcrownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrownid
            #add-point:ON ACTION controlp INFIELD mmcrownid name="construct.c.mmcrownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcrownid  #顯示到畫面上

            NEXT FIELD mmcrownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrownid
            #add-point:BEFORE FIELD mmcrownid name="construct.b.mmcrownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrownid
            
            #add-point:AFTER FIELD mmcrownid name="construct.a.mmcrownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcrowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrowndp
            #add-point:ON ACTION controlp INFIELD mmcrowndp name="construct.c.mmcrowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcrowndp  #顯示到畫面上

            NEXT FIELD mmcrowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrowndp
            #add-point:BEFORE FIELD mmcrowndp name="construct.b.mmcrowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrowndp
            
            #add-point:AFTER FIELD mmcrowndp name="construct.a.mmcrowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcrcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrcrtid
            #add-point:ON ACTION controlp INFIELD mmcrcrtid name="construct.c.mmcrcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcrcrtid  #顯示到畫面上

            NEXT FIELD mmcrcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrcrtid
            #add-point:BEFORE FIELD mmcrcrtid name="construct.b.mmcrcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrcrtid
            
            #add-point:AFTER FIELD mmcrcrtid name="construct.a.mmcrcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmcrcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrcrtdp
            #add-point:ON ACTION controlp INFIELD mmcrcrtdp name="construct.c.mmcrcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcrcrtdp  #顯示到畫面上

            NEXT FIELD mmcrcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrcrtdp
            #add-point:BEFORE FIELD mmcrcrtdp name="construct.b.mmcrcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrcrtdp
            
            #add-point:AFTER FIELD mmcrcrtdp name="construct.a.mmcrcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrcrtdt
            #add-point:BEFORE FIELD mmcrcrtdt name="construct.b.mmcrcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmcrmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrmodid
            #add-point:ON ACTION controlp INFIELD mmcrmodid name="construct.c.mmcrmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcrmodid  #顯示到畫面上

            NEXT FIELD mmcrmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrmodid
            #add-point:BEFORE FIELD mmcrmodid name="construct.b.mmcrmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrmodid
            
            #add-point:AFTER FIELD mmcrmodid name="construct.a.mmcrmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrmoddt
            #add-point:BEFORE FIELD mmcrmoddt name="construct.b.mmcrmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmcrcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrcnfid
            #add-point:ON ACTION controlp INFIELD mmcrcnfid name="construct.c.mmcrcnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcrcnfid  #顯示到畫面上

            NEXT FIELD mmcrcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrcnfid
            #add-point:BEFORE FIELD mmcrcnfid name="construct.b.mmcrcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrcnfid
            
            #add-point:AFTER FIELD mmcrcnfid name="construct.a.mmcrcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrcnfdt
            #add-point:BEFORE FIELD mmcrcnfdt name="construct.b.mmcrcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmcs001,mmcs002,mmcs003,mmcs004,mmcs005,mmcs006,mmcs007,mmcs008,mmcsacti 
 
           FROM s_detail1[1].mmcs001,s_detail1[1].mmcs002,s_detail1[1].mmcs003,s_detail1[1].mmcs004, 
               s_detail1[1].mmcs005,s_detail1[1].mmcs006,s_detail1[1].mmcs007,s_detail1[1].mmcs008,s_detail1[1].mmcsacti 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs001
            #add-point:BEFORE FIELD mmcs001 name="construct.b.page1.mmcs001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs001
            
            #add-point:AFTER FIELD mmcs001 name="construct.a.page1.mmcs001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcs001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs001
            #add-point:ON ACTION controlp INFIELD mmcs001 name="construct.c.page1.mmcs001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmcs002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs002
            #add-point:ON ACTION controlp INFIELD mmcs002 name="construct.c.page1.mmcs002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "2024"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcs002  #顯示到畫面上

            NEXT FIELD mmcs002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs002
            #add-point:BEFORE FIELD mmcs002 name="construct.b.page1.mmcs002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs002
            
            #add-point:AFTER FIELD mmcs002 name="construct.a.page1.mmcs002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs003
            #add-point:BEFORE FIELD mmcs003 name="construct.b.page1.mmcs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs003
            
            #add-point:AFTER FIELD mmcs003 name="construct.a.page1.mmcs003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcs003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs003
            #add-point:ON ACTION controlp INFIELD mmcs003 name="construct.c.page1.mmcs003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs004
            #add-point:BEFORE FIELD mmcs004 name="construct.b.page1.mmcs004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs004
            
            #add-point:AFTER FIELD mmcs004 name="construct.a.page1.mmcs004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcs004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs004
            #add-point:ON ACTION controlp INFIELD mmcs004 name="construct.c.page1.mmcs004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs005
            #add-point:BEFORE FIELD mmcs005 name="construct.b.page1.mmcs005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs005
            
            #add-point:AFTER FIELD mmcs005 name="construct.a.page1.mmcs005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcs005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs005
            #add-point:ON ACTION controlp INFIELD mmcs005 name="construct.c.page1.mmcs005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs006
            #add-point:BEFORE FIELD mmcs006 name="construct.b.page1.mmcs006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs006
            
            #add-point:AFTER FIELD mmcs006 name="construct.a.page1.mmcs006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcs006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs006
            #add-point:ON ACTION controlp INFIELD mmcs006 name="construct.c.page1.mmcs006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs007
            #add-point:BEFORE FIELD mmcs007 name="construct.b.page1.mmcs007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs007
            
            #add-point:AFTER FIELD mmcs007 name="construct.a.page1.mmcs007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcs007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs007
            #add-point:ON ACTION controlp INFIELD mmcs007 name="construct.c.page1.mmcs007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs008
            #add-point:BEFORE FIELD mmcs008 name="construct.b.page1.mmcs008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs008
            
            #add-point:AFTER FIELD mmcs008 name="construct.a.page1.mmcs008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcs008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs008
            #add-point:ON ACTION controlp INFIELD mmcs008 name="construct.c.page1.mmcs008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcsacti
            #add-point:BEFORE FIELD mmcsacti name="construct.b.page1.mmcsacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcsacti
            
            #add-point:AFTER FIELD mmcsacti name="construct.a.page1.mmcsacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcsacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcsacti
            #add-point:ON ACTION controlp INFIELD mmcsacti name="construct.c.page1.mmcsacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON mmct001,mmct002,mmctacti,mmctunit
           FROM s_detail2[1].mmct001,s_detail2[1].mmct002,s_detail2[1].mmctacti,s_detail2[1].mmctunit 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmct001
            #add-point:BEFORE FIELD mmct001 name="construct.b.page2.mmct001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmct001
            
            #add-point:AFTER FIELD mmct001 name="construct.a.page2.mmct001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmct001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmct001
            #add-point:ON ACTION controlp INFIELD mmct001 name="construct.c.page2.mmct001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mmct002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmct002
            #add-point:ON ACTION controlp INFIELD mmct002 name="construct.c.page2.mmct002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmct002  #顯示到畫面上

            NEXT FIELD mmct002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmct002
            #add-point:BEFORE FIELD mmct002 name="construct.b.page2.mmct002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmct002
            
            #add-point:AFTER FIELD mmct002 name="construct.a.page2.mmct002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmctacti
            #add-point:BEFORE FIELD mmctacti name="construct.b.page2.mmctacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmctacti
            
            #add-point:AFTER FIELD mmctacti name="construct.a.page2.mmctacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmctacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmctacti
            #add-point:ON ACTION controlp INFIELD mmctacti name="construct.c.page2.mmctacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmctunit
            #add-point:BEFORE FIELD mmctunit name="construct.b.page2.mmctunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmctunit
            
            #add-point:AFTER FIELD mmctunit name="construct.a.page2.mmctunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmctunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmctunit
            #add-point:ON ACTION controlp INFIELD mmctunit name="construct.c.page2.mmctunit"
            
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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "mmcr_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmcs_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmct_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
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
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION ammt201_filter()
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
      CONSTRUCT g_wc_filter ON mmcrsite,mmcrdocdt,mmcrdocno,mmcr000,mmcr001,mmcr002,mmcr004,mmcr005, 
          mmcracti,mmcrunit
                          FROM s_browse[1].b_mmcrsite,s_browse[1].b_mmcrdocdt,s_browse[1].b_mmcrdocno, 
                              s_browse[1].b_mmcr000,s_browse[1].b_mmcr001,s_browse[1].b_mmcr002,s_browse[1].b_mmcr004, 
                              s_browse[1].b_mmcr005,s_browse[1].b_mmcracti,s_browse[1].b_mmcrunit
 
         BEFORE CONSTRUCT
               DISPLAY ammt201_filter_parser('mmcrsite') TO s_browse[1].b_mmcrsite
            DISPLAY ammt201_filter_parser('mmcrdocdt') TO s_browse[1].b_mmcrdocdt
            DISPLAY ammt201_filter_parser('mmcrdocno') TO s_browse[1].b_mmcrdocno
            DISPLAY ammt201_filter_parser('mmcr000') TO s_browse[1].b_mmcr000
            DISPLAY ammt201_filter_parser('mmcr001') TO s_browse[1].b_mmcr001
            DISPLAY ammt201_filter_parser('mmcr002') TO s_browse[1].b_mmcr002
            DISPLAY ammt201_filter_parser('mmcr004') TO s_browse[1].b_mmcr004
            DISPLAY ammt201_filter_parser('mmcr005') TO s_browse[1].b_mmcr005
            DISPLAY ammt201_filter_parser('mmcracti') TO s_browse[1].b_mmcracti
            DISPLAY ammt201_filter_parser('mmcrunit') TO s_browse[1].b_mmcrunit
      
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
 
      CALL ammt201_filter_show('mmcrsite')
   CALL ammt201_filter_show('mmcrdocdt')
   CALL ammt201_filter_show('mmcrdocno')
   CALL ammt201_filter_show('mmcr000')
   CALL ammt201_filter_show('mmcr001')
   CALL ammt201_filter_show('mmcr002')
   CALL ammt201_filter_show('mmcr004')
   CALL ammt201_filter_show('mmcr005')
   CALL ammt201_filter_show('mmcracti')
   CALL ammt201_filter_show('mmcrunit')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION ammt201_filter_parser(ps_field)
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
 
{<section id="ammt201.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION ammt201_filter_show(ps_field)
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
   LET ls_condition = ammt201_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt201_query()
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
   CALL g_mmcs_d.clear()
   CALL g_mmcs2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL ammt201_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammt201_browser_fill("")
      CALL ammt201_fetch("")
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
      CALL ammt201_filter_show('mmcrsite')
   CALL ammt201_filter_show('mmcrdocdt')
   CALL ammt201_filter_show('mmcrdocno')
   CALL ammt201_filter_show('mmcr000')
   CALL ammt201_filter_show('mmcr001')
   CALL ammt201_filter_show('mmcr002')
   CALL ammt201_filter_show('mmcr004')
   CALL ammt201_filter_show('mmcr005')
   CALL ammt201_filter_show('mmcracti')
   CALL ammt201_filter_show('mmcrunit')
   CALL ammt201_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL ammt201_fetch("F") 
      #顯示單身筆數
      CALL ammt201_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt201_fetch(p_flag)
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
   
   LET g_mmcr_m.mmcrdocno = g_browser[g_current_idx].b_mmcrdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE ammt201_master_referesh USING g_mmcr_m.mmcrdocno INTO g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt, 
       g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrcrtid, 
       g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt,g_mmcr_m.mmcrcnfid, 
       g_mmcr_m.mmcrcnfdt,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrownid_desc,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid_desc, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrcnfid_desc
   
   #遮罩相關處理
   LET g_mmcr_m_mask_o.* =  g_mmcr_m.*
   CALL ammt201_mmcr_t_mask()
   LET g_mmcr_m_mask_n.* =  g_mmcr_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt201_set_act_visible()   
   CALL ammt201_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_mmcr_m.mmcrstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete",FALSE)
   END IF
   CALL cl_set_act_visible("reproduce",FALSE)
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmcr_m_t.* = g_mmcr_m.*
   LET g_mmcr_m_o.* = g_mmcr_m.*
   
   LET g_data_owner = g_mmcr_m.mmcrownid      
   LET g_data_dept  = g_mmcr_m.mmcrowndp
   
   #重新顯示   
   CALL ammt201_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt201_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004 
   #ken---add---e
   DEFINE l_insert      LIKE type_t.num5 #sakura add
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmcs_d.clear()   
   CALL g_mmcs2_d.clear()  
 
 
   INITIALIZE g_mmcr_m.* TO NULL             #DEFAULT 設定
   
   LET g_mmcrdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmcr_m.mmcrownid = g_user
      LET g_mmcr_m.mmcrowndp = g_dept
      LET g_mmcr_m.mmcrcrtid = g_user
      LET g_mmcr_m.mmcrcrtdp = g_dept 
      LET g_mmcr_m.mmcrcrtdt = cl_get_current()
      LET g_mmcr_m.mmcrmodid = g_user
      LET g_mmcr_m.mmcrmoddt = cl_get_current()
      LET g_mmcr_m.mmcrstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmcr_m.mmcr000 = "I"
      LET g_mmcr_m.mmcr002 = "0"
      LET g_mmcr_m.mmcr004 = "N"
      LET g_mmcr_m.mmcr005 = "N"
      LET g_mmcr_m.mmcracti = "Y"
      LET g_mmcr_m.mmcrstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      #sakura---add---str
      CALL s_aooi500_default(g_prog,'mmcrsite',g_mmcr_m.mmcrsite)
         RETURNING l_insert,g_mmcr_m.mmcrsite
      IF l_insert = FALSE THEN
         RETURN
      END IF      
      #sakura---add---end
      LET g_mmcr_m.mmcr000 = 'I'
     #LET g_mmcr_m.mmcr002 = 1 #sakura mark
      LET g_mmcr_m.mmcrdocdt = g_today
      LET g_mmcr_m.mmcr004 = 'N'
      LET g_mmcr_m.mmcr005 = 'N'
     
     #LET g_mmcr_m.mmcrsite = g_site #sakura mark
     #LET g_mmcr_m.mmcrunit = g_site #sakura mark
      CALL ammt201_mmcrsite_ref()
      
      #ken---add---s 需求單號：141125-00002 項次：4
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mmcr_m.mmcrsite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_mmcr_m.mmcrdocno = l_doctype      
      #ken---add---e
      LET g_site_flag = FALSE         #sakura add
      INITIALIZE g_mmcr_m_t.* TO NULL #sakura add    
      LET g_mmcr_m_t.* =  g_mmcr_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mmcr_m_t.* = g_mmcr_m.*
      LET g_mmcr_m_o.* = g_mmcr_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmcr_m.mmcrstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL ammt201_input("a")
      
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
         INITIALIZE g_mmcr_m.* TO NULL
         INITIALIZE g_mmcs_d TO NULL
         INITIALIZE g_mmcs2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL ammt201_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mmcs_d.clear()
      #CALL g_mmcs2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt201_set_act_visible()   
   CALL ammt201_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmcrdocno_t = g_mmcr_m.mmcrdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmcrent = " ||g_enterprise|| " AND",
                      " mmcrdocno = '", g_mmcr_m.mmcrdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt201_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE ammt201_cl
   
   CALL ammt201_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammt201_master_referesh USING g_mmcr_m.mmcrdocno INTO g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt, 
       g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrcrtid, 
       g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt,g_mmcr_m.mmcrcnfid, 
       g_mmcr_m.mmcrcnfdt,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrownid_desc,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid_desc, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrcnfid_desc
   
   
   #遮罩相關處理
   LET g_mmcr_m_mask_o.* =  g_mmcr_m.*
   CALL ammt201_mmcr_t_mask()
   LET g_mmcr_m_mask_n.* =  g_mmcr_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmcr_m.mmcrsite,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000, 
       g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrownid_desc, 
       g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid,g_mmcr_m.mmcrcrtid_desc,g_mmcr_m.mmcrcrtdp, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrmoddt, 
       g_mmcr_m.mmcrcnfid,g_mmcr_m.mmcrcnfid_desc,g_mmcr_m.mmcrcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mmcr_m.mmcrownid      
   LET g_data_dept  = g_mmcr_m.mmcrowndp
   
   #功能已完成,通報訊息中心
   CALL ammt201_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt201_modify()
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
   LET g_mmcr_m_t.* = g_mmcr_m.*
   LET g_mmcr_m_o.* = g_mmcr_m.*
   
   IF g_mmcr_m.mmcrdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mmcrdocno_t = g_mmcr_m.mmcrdocno
 
   CALL s_transaction_begin()
   
   OPEN ammt201_cl USING g_enterprise,g_mmcr_m.mmcrdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt201_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt201_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt201_master_referesh USING g_mmcr_m.mmcrdocno INTO g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt, 
       g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrcrtid, 
       g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt,g_mmcr_m.mmcrcnfid, 
       g_mmcr_m.mmcrcnfdt,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrownid_desc,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid_desc, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrcnfid_desc
   
   #檢查是否允許此動作
   IF NOT ammt201_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmcr_m_mask_o.* =  g_mmcr_m.*
   CALL ammt201_mmcr_t_mask()
   LET g_mmcr_m_mask_n.* =  g_mmcr_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL ammt201_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_mmcrdocno_t = g_mmcr_m.mmcrdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mmcr_m.mmcrmodid = g_user 
LET g_mmcr_m.mmcrmoddt = cl_get_current()
LET g_mmcr_m.mmcrmodid_desc = cl_get_username(g_mmcr_m.mmcrmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET t_mmcr001 = g_mmcr_m.mmcr001
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_mmcr_m.mmcrstus MATCHES "[DR]" THEN
         LET g_mmcr_m.mmcrstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL ammt201_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mmcr_t SET (mmcrmodid,mmcrmoddt) = (g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt)
          WHERE mmcrent = g_enterprise AND mmcrdocno = g_mmcrdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mmcr_m.* = g_mmcr_m_t.*
            CALL ammt201_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mmcr_m.mmcrdocno != g_mmcr_m_t.mmcrdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mmcs_t SET mmcsdocno = g_mmcr_m.mmcrdocno
 
          WHERE mmcsent = g_enterprise AND mmcsdocno = g_mmcr_m_t.mmcrdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmcs_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmcs_t:",SQLERRMESSAGE 
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
         
         UPDATE mmct_t
            SET mmctdocno = g_mmcr_m.mmcrdocno
 
          WHERE mmctent = g_enterprise AND
                mmctdocno = g_mmcrdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmct_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmct_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt201_set_act_visible()   
   CALL ammt201_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmcrent = " ||g_enterprise|| " AND",
                      " mmcrdocno = '", g_mmcr_m.mmcrdocno, "' "
 
   #填到對應位置
   CALL ammt201_browser_fill("")
 
   CLOSE ammt201_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt201_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="ammt201.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt201_input(p_cmd)
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
   #DEFINE  l_flag                LIKE type_t.num5 #sakura mark
   DEFINE  l_success             LIKE type_t.num5  #sakura add
   DEFINE  l_errno               LIKE type_t.chr10 #sakura add
   DEFINE  l_where               STRING            #sakura add   
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
   DISPLAY BY NAME g_mmcr_m.mmcrsite,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000, 
       g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrownid_desc, 
       g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid,g_mmcr_m.mmcrcrtid_desc,g_mmcr_m.mmcrcrtdp, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrmoddt, 
       g_mmcr_m.mmcrcnfid,g_mmcr_m.mmcrcnfid_desc,g_mmcr_m.mmcrcnfdt
   
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
   LET g_errshow = 1
   #end add-point 
   LET g_forupd_sql = "SELECT mmcs001,mmcs002,mmcs003,mmcs004,mmcs005,mmcs006,mmcs007,mmcs008,mmcsacti, 
       mmcsunit,mmcssite FROM mmcs_t WHERE mmcsent=? AND mmcsdocno=? AND mmcs002=? AND mmcs003=? AND  
       mmcs004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt201_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmct001,mmct002,mmctacti,mmctunit,mmctsite FROM mmct_t WHERE mmctent=?  
       AND mmctdocno=? AND mmct002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt201_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL ammt201_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL ammt201_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit, 
       g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003,g_mmcr_m.mmcr004,g_mmcr_m.mmcr005, 
       g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_flag = FALSE
   CALL ammt201_set_entry(p_cmd)
   CALL ammt201_set_no_entry(p_cmd)
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="ammt201.input.head" >}
      #單頭段
      INPUT BY NAME g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit, 
          g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003,g_mmcr_m.mmcr004,g_mmcr_m.mmcr005, 
          g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
             IF NOT cl_null(g_mmcr_m.mmcrdocno) THEN
                  CALL n_mmcrl(g_mmcr_m.mmcrdocno)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mmcr_m.mmcrdocno
#                  CALL ap_ref_array2(g_ref_fields," SELECT mmcrl002,mmcrl003 FROM mmcrl_t WHERE mmcrldocno = ? AND mmcrl001 = '"||g_lang||"'","") RETURNING g_rtn_fields #160905-00007#6 mark
                  CALL ap_ref_array2(g_ref_fields," SELECT mmcrl002,mmcrl003 FROM mmcrl_t WHERE mmcrlent="||g_enterprise||" AND mmcrldocno = ? AND mmcrl001 = '"||g_lang||"'","") RETURNING g_rtn_fields #160905-00007#6 add
                  LET g_mmcr_m.mmcrl002 = g_rtn_fields[1]
                  LET g_mmcr_m.mmcrl003 = g_rtn_fields[2]
                  DISPLAY BY NAME g_mmcr_m.mmcrl002
                  DISPLAY BY NAME g_mmcr_m.mmcrl003
              END IF 
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN ammt201_cl USING g_enterprise,g_mmcr_m.mmcrdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt201_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt201_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.mmcrldocno = g_mmcr_m.mmcrdocno
LET g_master_multi_table_t.mmcrl002 = g_mmcr_m.mmcrl002
LET g_master_multi_table_t.mmcrl003 = g_mmcr_m.mmcrl003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.mmcrldocno = ''
LET g_master_multi_table_t.mmcrl002 = ''
LET g_master_multi_table_t.mmcrl003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL ammt201_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL ammt201_set_entry(p_cmd)
            CALL ammt201_set_no_entry(p_cmd) 
            #end add-point
            CALL ammt201_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrsite
            
            #add-point:AFTER FIELD mmcrsite name="input.a.mmcrsite"
            LET g_mmcr_m.mmcrsite_desc = ''
            DISPLAY BY NAME g_mmcr_m.mmcrsite_desc
           #sakura---mark---str
           #IF NOT cl_null(g_mmcr_m.mmcrsite) THEN
           #   IF NOT ammt201_mmcrsite_chk(g_mmcr_m.mmcrsite) THEN
           #      LET g_mmcr_m.mmcrsite = g_mmcr_m_t.mmcrsite
           #      CALL ammt201_mmcrsite_ref()
           #      NEXT FIELD mmcrsite 
           #   END IF
           #END IF
           #CALL ammt201_mmcrsite_ref()
           #sakura---mark---str
           
           #sakura---add---str
            IF NOT cl_null(g_mmcr_m.mmcrsite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmcr_m.mmcrsite != g_mmcr_m_t.mmcrsite OR g_mmcr_m_t.mmcrsite IS NULL )) THEN #160824-00007#107 by sakura mark
               IF g_mmcr_m.mmcrsite != g_mmcr_m_o.mmcrsite OR cl_null(g_mmcr_m_o.mmcrsite) THEN #160824-00007#107 by sakura add
                  CALL s_aooi500_chk(g_prog,'mmcrsite',g_mmcr_m.mmcrsite,g_mmcr_m.mmcrsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_mmcr_m.mmcrsite = g_mmcr_m_t.mmcrsite #160824-00007#107 by sakura mark
                     LET g_mmcr_m.mmcrsite = g_mmcr_m_o.mmcrsite  #160824-00007#107 by sakura add
                     CALL s_desc_get_department_desc(g_mmcr_m.mmcrsite) RETURNING g_mmcr_m.mmcrsite_desc
                     DISPLAY BY NAME g_mmcr_m.mmcrsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               
               #LET g_mmcr_m.mmcrsite = g_mmcr_m_t.mmcrsite #160824-00007#107 by sakura mark
               LET g_mmcr_m.mmcrsite = g_mmcr_m_o.mmcrsite  #160824-00007#107 by sakura add
               CALL s_desc_get_department_desc(g_mmcr_m.mmcrsite) RETURNING g_mmcr_m.mmcrsite_desc
               DISPLAY BY NAME g_mmcr_m.mmcrsite_desc
               NEXT FIELD CURRENT               
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_mmcr_m.mmcrsite) RETURNING g_mmcr_m.mmcrsite_desc
            DISPLAY BY NAME g_mmcr_m.mmcrsite_desc
            CALL ammt201_set_entry(p_cmd)
            CALL ammt201_set_no_entry(p_cmd)
           #sakura---add---end
            LET g_mmcr_m_o.* = g_mmcr_m.*  #160824-00007#107 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrsite
            #add-point:BEFORE FIELD mmcrsite name="input.b.mmcrsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcrsite
            #add-point:ON CHANGE mmcrsite name="input.g.mmcrsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrdocdt
            #add-point:BEFORE FIELD mmcrdocdt name="input.b.mmcrdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrdocdt
            
            #add-point:AFTER FIELD mmcrdocdt name="input.a.mmcrdocdt"
            IF cl_null(g_mmcr_m.mmcrdocdt) THEN  
               NEXT FIELD mmcrdocdt
            END IF
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcrdocdt
            #add-point:ON CHANGE mmcrdocdt name="input.g.mmcrdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrdocno
            #add-point:BEFORE FIELD mmcrdocno name="input.b.mmcrdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrdocno
            
            #add-point:AFTER FIELD mmcrdocno name="input.a.mmcrdocno"
            IF NOT cl_null(g_mmcr_m.mmcrdocno)  THEN
               IF NOT ammt201_chk_mmcrdocno() AND p_cmd = 'a' THEN
                  LET g_mmcr_m.mmcrdocno = g_mmcr_m_t.mmcrdocno
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmcr_m.mmcrdocno != g_mmcrdocno_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmcr_t WHERE "||"mmcrent = '" ||g_enterprise|| "' AND "||"mmcrdocno = '"||g_mmcr_m.mmcrdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
              #sakura---mark---str
              #CALL s_aooi200_gen_docno(g_site,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcrdocdt,g_prog) RETURNING l_flag,g_mmcr_m.mmcrdocno
              #IF NOT l_flag THEN
              #   INITIALIZE g_errparam TO NULL
              #   LET g_errparam.code = 'apm-00003'
              #   LET g_errparam.extend = g_mmcr_m.mmcrdocno
              #   LET g_errparam.popup = TRUE
              #   CALL cl_err()
              #
              #   LET g_mmcr_m.mmcrdocno = g_mmcr_m_t.mmcrdocno
              #   DISPLAY g_mmcr_m.mmcrdocno TO mmcrdocno
              #   NEXT FIELD CURRENT           
              #END IF
              #sakura---mark---end
               LET g_flag = TRUE 
            END IF
            #成功自动编号，关闭单据编号，日期栏位
            #CALL ammt201_set_entry(p_cmd)     #sakura mark
            #CALL ammt201_set_no_entry(p_cmd)  #sakura mark
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcrdocno
            #add-point:ON CHANGE mmcrdocno name="input.g.mmcrdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr000
            #add-point:BEFORE FIELD mmcr000 name="input.b.mmcr000"
         
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr000
            
            #add-point:AFTER FIELD mmcr000 name="input.a.mmcr000"
            IF g_mmcr_m.mmcr000 = 'U' THEN
               CALL cl_set_comp_entry('mmcracti',TRUE)
            ELSE
               LET g_mmcr_m.mmcracti = 'Y'
               CALL cl_set_comp_entry('mmcracti',FALSE)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcr000
            #add-point:ON CHANGE mmcr000 name="input.g.mmcr000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrunit
            #add-point:BEFORE FIELD mmcrunit name="input.b.mmcrunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrunit
            
            #add-point:AFTER FIELD mmcrunit name="input.a.mmcrunit"
         

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcrunit
            #add-point:ON CHANGE mmcrunit name="input.g.mmcrunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr001
            #add-point:BEFORE FIELD mmcr001 name="input.b.mmcr001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr001
            
            #add-point:AFTER FIELD mmcr001 name="input.a.mmcr001"
            IF NOT cl_null(g_mmcr_m.mmcr001) THEN
               IF NOT ammt201_mmcr001_chk(p_cmd,g_mmcr_m.mmcr001) THEN
                  LET g_mmcr_m.mmcr001 = g_mmcr_m_t.mmcr001
                  NEXT FIELD mmcr001
               END IF
               #IF (p_cmd = 'u' AND g_mmcr_m.mmcr001 <> g_mmcr_m_t.mmcr001 ) AND g_mmcr_m.mmcr000 = 'U' THEN #160824-00007#107 by sakura mark
               IF g_mmcr_m.mmcr001 != g_mmcr_m_o.mmcr001 OR cl_null(g_mmcr_m_o.mmcr001) THEN #160824-00007#107 by sakura add
                  IF cl_ask_confirm('amm-00182') THEN     
                     DELETE FROM mmcs_t WHERE mmcsent = g_enterprise AND mmcsdocno = g_mmcr_m.mmcrdocno
                     DELETE FROM mmct_t WHERE mmctent = g_enterprise AND mmctdocno = g_mmcr_m.mmcrdocno
                     CALL g_mmcs_d.clear()
                     CALL g_mmcs2_d.clear()
                  ELSE
                     #LET g_mmcr_m.mmcr001 = g_mmcr_m_t.mmcr001 #160824-00007#107 by sakura mark
                     LET g_mmcr_m.mmcr001 = g_mmcr_m_o.mmcr001  #160824-00007#107 by sakura add
                     NEXT FIELD mmcr001
                  END IF
               END IF
               IF g_mmcr_m.mmcr000 = 'U' THEN
                  CALL ammt201_mmcr001_other()
               ELSE
                 #LET g_mmcr_m.mmcr002 = 1 #sakura mark
                  LET g_mmcr_m.mmcr002 = 0 #sakura add
               END IF 
               CALL cl_set_comp_entry("mmcr000",FALSE)
            ELSE
               CALL cl_set_comp_entry("mmcr000",TRUE)
            END IF
            LET g_mmcr_m_o.* = g_mmcr_m.*  #160824-00007#107 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcr001
            #add-point:ON CHANGE mmcr001 name="input.g.mmcr001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr002
            #add-point:BEFORE FIELD mmcr002 name="input.b.mmcr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr002
            
            #add-point:AFTER FIELD mmcr002 name="input.a.mmcr002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcr002
            #add-point:ON CHANGE mmcr002 name="input.g.mmcr002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrl002
            #add-point:BEFORE FIELD mmcrl002 name="input.b.mmcrl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrl002
            
            #add-point:AFTER FIELD mmcrl002 name="input.a.mmcrl002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcrl002
            #add-point:ON CHANGE mmcrl002 name="input.g.mmcrl002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrl003
            #add-point:BEFORE FIELD mmcrl003 name="input.b.mmcrl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrl003
            
            #add-point:AFTER FIELD mmcrl003 name="input.a.mmcrl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcrl003
            #add-point:ON CHANGE mmcrl003 name="input.g.mmcrl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr004
            #add-point:BEFORE FIELD mmcr004 name="input.b.mmcr004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr004
            
            #add-point:AFTER FIELD mmcr004 name="input.a.mmcr004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcr004
            #add-point:ON CHANGE mmcr004 name="input.g.mmcr004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcr005
            #add-point:BEFORE FIELD mmcr005 name="input.b.mmcr005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcr005
            
            #add-point:AFTER FIELD mmcr005 name="input.a.mmcr005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcr005
            #add-point:ON CHANGE mmcr005 name="input.g.mmcr005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcracti
            #add-point:BEFORE FIELD mmcracti name="input.b.mmcracti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcracti
            
            #add-point:AFTER FIELD mmcracti name="input.a.mmcracti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcracti
            #add-point:ON CHANGE mmcracti name="input.g.mmcracti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcrstus
            #add-point:BEFORE FIELD mmcrstus name="input.b.mmcrstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcrstus
            
            #add-point:AFTER FIELD mmcrstus name="input.a.mmcrstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcrstus
            #add-point:ON CHANGE mmcrstus name="input.g.mmcrstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmcrsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrsite
            #add-point:ON ACTION controlp INFIELD mmcrsite name="input.c.mmcrsite"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mmcr_m.mmcrsite             #給予default值
           #sakura---add---str
            CALL s_aooi500_q_where(g_prog,'mmcrsite',g_mmcr_m.mmcrsite,'i') RETURNING l_where  #150308-00001#3 150309 pomelo add 'i'
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()
            LET g_mmcr_m.mmcrsite = g_qryparam.return1
            DISPLAY g_mmcr_m.mmcrsite TO mmcrsite
            CALL s_desc_get_department_desc(g_mmcr_m.mmcrsite) RETURNING g_mmcr_m.mmcrsite_desc
            DISPLAY BY NAME g_mmcr_m.mmcrsite_desc
            NEXT FIELD mmcrsite                          #返回原欄位              
           #sakura---add---end

            #END add-point
 
 
         #Ctrlp:input.c.mmcrdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrdocdt
            #add-point:ON ACTION controlp INFIELD mmcrdocdt name="input.c.mmcrdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcrdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrdocno
            #add-point:ON ACTION controlp INFIELD mmcrdocno name="input.c.mmcrdocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmcr_m.mmcrdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = "ammt201" #   #160705-00042#3 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#3 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_mmcr_m.mmcrdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmcr_m.mmcrdocno TO mmcrdocno              #顯示到畫面上

            NEXT FIELD mmcrdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmcr000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr000
            #add-point:ON ACTION controlp INFIELD mmcr000 name="input.c.mmcr000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcrunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrunit
            #add-point:ON ACTION controlp INFIELD mmcrunit name="input.c.mmcrunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcr001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr001
            #add-point:ON ACTION controlp INFIELD mmcr001 name="input.c.mmcr001"
#此段落由子樣板a07產生            
            #開窗i段
            IF g_mmcr_m.mmcr000 = 'U' THEN
			  INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
			  LET g_qryparam.reqry = FALSE

              LET g_qryparam.default1 = g_mmcr_m.mmcr001             #給予default值
    
              #給予arg
    
              CALL q_mmcu001_1()                                #呼叫開窗
    
              LET g_mmcr_m.mmcr001 = g_qryparam.return1              #將開窗取得的值回傳到變數
    
              DISPLAY g_mmcr_m.mmcr001 TO mmcr001              #顯示到畫面上
    
              NEXT FIELD mmcr001                          #返回原欄位
    
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.mmcr002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr002
            #add-point:ON ACTION controlp INFIELD mmcr002 name="input.c.mmcr002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcrl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrl002
            #add-point:ON ACTION controlp INFIELD mmcrl002 name="input.c.mmcrl002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcrl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrl003
            #add-point:ON ACTION controlp INFIELD mmcrl003 name="input.c.mmcrl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcr004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr004
            #add-point:ON ACTION controlp INFIELD mmcr004 name="input.c.mmcr004"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcr005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcr005
            #add-point:ON ACTION controlp INFIELD mmcr005 name="input.c.mmcr005"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcracti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcracti
            #add-point:ON ACTION controlp INFIELD mmcracti name="input.c.mmcracti"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmcrstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcrstus
            #add-point:ON ACTION controlp INFIELD mmcrstus name="input.c.mmcrstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mmcr_m.mmcrdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #sakura---add---str
               #單號自動編碼
               CALL s_aooi200_gen_docno(g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcrdocdt,g_prog) 
                  RETURNING l_success,g_mmcr_m.mmcrdocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_mmcr_m.mmcrdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mmcrdocno
               END IF
               DISPLAY BY NAME g_mmcr_m.mmcrdocno               
               LET g_mmcr_m.mmcrunit = g_mmcr_m.mmcrsite
               #sakura---add---end
               #end add-point
               
               INSERT INTO mmcr_t (mmcrent,mmcrsite,mmcrdocdt,mmcrdocno,mmcr000,mmcrunit,mmcr001,mmcr002, 
                   mmcr004,mmcr005,mmcracti,mmcrstus,mmcrownid,mmcrowndp,mmcrcrtid,mmcrcrtdp,mmcrcrtdt, 
                   mmcrmodid,mmcrmoddt,mmcrcnfid,mmcrcnfdt)
               VALUES (g_enterprise,g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000, 
                   g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004,g_mmcr_m.mmcr005, 
                   g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrcrtid, 
                   g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt,g_mmcr_m.mmcrcnfid, 
                   g_mmcr_m.mmcrcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mmcr_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mmcr_m.mmcrdocno = g_master_multi_table_t.mmcrldocno AND
         g_mmcr_m.mmcrl002 = g_master_multi_table_t.mmcrl002 AND 
         g_mmcr_m.mmcrl003 = g_master_multi_table_t.mmcrl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mmcrlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mmcr_m.mmcrdocno
            LET l_field_keys[02] = 'mmcrldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmcrldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmcrl001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmcr_m.mmcrl002
            LET l_fields[01] = 'mmcrl002'
            LET l_vars[02] = g_mmcr_m.mmcrl003
            LET l_fields[02] = 'mmcrl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmcrl_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
                  IF NOT cl_null(g_mmcr_m.mmcr001) AND g_mmcr_m.mmcr000 = 'U' THEN
                     CALL ammt201_mmcr001_genb()
                     CALL ammt201_b_fill()
                  END IF     
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL ammt201_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL ammt201_b_fill()
                  CALL ammt201_b_fill2('0')
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
               CALL ammt201_mmcr_t_mask_restore('restore_mask_o')
               
               UPDATE mmcr_t SET (mmcrsite,mmcrdocdt,mmcrdocno,mmcr000,mmcrunit,mmcr001,mmcr002,mmcr004, 
                   mmcr005,mmcracti,mmcrstus,mmcrownid,mmcrowndp,mmcrcrtid,mmcrcrtdp,mmcrcrtdt,mmcrmodid, 
                   mmcrmoddt,mmcrcnfid,mmcrcnfdt) = (g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno, 
                   g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004, 
                   g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp, 
                   g_mmcr_m.mmcrcrtid,g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt, 
                   g_mmcr_m.mmcrcnfid,g_mmcr_m.mmcrcnfdt)
                WHERE mmcrent = g_enterprise AND mmcrdocno = g_mmcrdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmcr_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mmcr_m.mmcrdocno = g_master_multi_table_t.mmcrldocno AND
         g_mmcr_m.mmcrl002 = g_master_multi_table_t.mmcrl002 AND 
         g_mmcr_m.mmcrl003 = g_master_multi_table_t.mmcrl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mmcrlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mmcr_m.mmcrdocno
            LET l_field_keys[02] = 'mmcrldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmcrldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmcrl001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmcr_m.mmcrl002
            LET l_fields[01] = 'mmcrl002'
            LET l_vars[02] = g_mmcr_m.mmcrl003
            LET l_fields[02] = 'mmcrl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmcrl_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL ammt201_mmcr_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mmcr_m_t)
               LET g_log2 = util.JSON.stringify(g_mmcr_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                    IF NOT cl_null(g_mmcr_m.mmcr001) AND g_mmcr_m.mmcr000 = 'U' THEN
                       CALL ammt201_mmcr001_genb()
                       CALL ammt201_b_fill()
                    END IF    
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mmcrdocno_t = g_mmcr_m.mmcrdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="ammt201.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmcs_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmcs_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt201_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mmcs_d.getLength()
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
            OPEN ammt201_cl USING g_enterprise,g_mmcr_m.mmcrdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt201_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt201_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmcs_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmcs_d[l_ac].mmcs002 IS NOT NULL
               AND g_mmcs_d[l_ac].mmcs003 IS NOT NULL
               AND g_mmcs_d[l_ac].mmcs004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmcs_d_t.* = g_mmcs_d[l_ac].*  #BACKUP
               LET g_mmcs_d_o.* = g_mmcs_d[l_ac].*  #BACKUP
               CALL ammt201_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL ammt201_set_no_entry_b(l_cmd)
               IF NOT ammt201_lock_b("mmcs_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt201_bcl INTO g_mmcs_d[l_ac].mmcs001,g_mmcs_d[l_ac].mmcs002,g_mmcs_d[l_ac].mmcs003, 
                      g_mmcs_d[l_ac].mmcs004,g_mmcs_d[l_ac].mmcs005,g_mmcs_d[l_ac].mmcs006,g_mmcs_d[l_ac].mmcs007, 
                      g_mmcs_d[l_ac].mmcs008,g_mmcs_d[l_ac].mmcsacti,g_mmcs_d[l_ac].mmcsunit,g_mmcs_d[l_ac].mmcssite 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmcs_d_t.mmcs002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmcs_d_mask_o[l_ac].* =  g_mmcs_d[l_ac].*
                  CALL ammt201_mmcs_t_mask()
                  LET g_mmcs_d_mask_n[l_ac].* =  g_mmcs_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt201_show()
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
            INITIALIZE g_mmcs_d[l_ac].* TO NULL 
            INITIALIZE g_mmcs_d_t.* TO NULL 
            INITIALIZE g_mmcs_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_mmcs_d[l_ac].mmcs005 = "1"
      LET g_mmcs_d[l_ac].mmcs007 = "0"
      LET g_mmcs_d[l_ac].mmcs008 = "0"
      LET g_mmcs_d[l_ac].mmcsacti = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_mmcs_d_t.* = g_mmcs_d[l_ac].*     #新輸入資料
            LET g_mmcs_d_o.* = g_mmcs_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt201_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt201_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmcs_d[li_reproduce_target].* = g_mmcs_d[li_reproduce].*
 
               LET g_mmcs_d[li_reproduce_target].mmcs002 = NULL
               LET g_mmcs_d[li_reproduce_target].mmcs003 = NULL
               LET g_mmcs_d[li_reproduce_target].mmcs004 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_mmcs_d[l_ac].mmcs001 = g_mmcr_m.mmcr001
          
            LET g_mmcs_d[l_ac].mmcsunit = g_mmcr_m.mmcrunit
            LET g_mmcs_d[l_ac].mmcssite = g_mmcr_m.mmcrsite
            LET g_mmcs_d_t.* = g_mmcs_d[l_ac].*     #新輸入資料 
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
            SELECT COUNT(1) INTO l_count FROM mmcs_t 
             WHERE mmcsent = g_enterprise AND mmcsdocno = g_mmcr_m.mmcrdocno
 
               AND mmcs002 = g_mmcs_d[l_ac].mmcs002
               AND mmcs003 = g_mmcs_d[l_ac].mmcs003
               AND mmcs004 = g_mmcs_d[l_ac].mmcs004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmcr_m.mmcrdocno
               LET gs_keys[2] = g_mmcs_d[g_detail_idx].mmcs002
               LET gs_keys[3] = g_mmcs_d[g_detail_idx].mmcs003
               LET gs_keys[4] = g_mmcs_d[g_detail_idx].mmcs004
               CALL ammt201_insert_b('mmcs_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mmcs_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmcs_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt201_b_fill()
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
               LET gs_keys[01] = g_mmcr_m.mmcrdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mmcs_d_t.mmcs002
               LET gs_keys[gs_keys.getLength()+1] = g_mmcs_d_t.mmcs003
               LET gs_keys[gs_keys.getLength()+1] = g_mmcs_d_t.mmcs004
 
            
               #刪除同層單身
               IF NOT ammt201_delete_b('mmcs_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt201_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt201_key_delete_b(gs_keys,'mmcs_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt201_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt201_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mmcs_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmcs_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs001
            #add-point:BEFORE FIELD mmcs001 name="input.b.page1.mmcs001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs001
            
            #add-point:AFTER FIELD mmcs001 name="input.a.page1.mmcs001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcs001
            #add-point:ON CHANGE mmcs001 name="input.g.page1.mmcs001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs002
            
            #add-point:AFTER FIELD mmcs002 name="input.a.page1.mmcs002"
            #此段落由子樣板a05產生
            LET g_mmcs_d[l_ac].mmcs002_desc = ''
            IF NOT cl_null(g_mmcs_d[l_ac].mmcs002) THEN
               IF NOT s_azzi650_chk_exist('2024',g_mmcs_d[l_ac].mmcs002) THEN
                  #LET g_mmcs_d[l_ac].mmcs002 = g_mmcs_d_t.mmcs002 #160824-00007#107 by sakura mark
                  LET g_mmcs_d[l_ac].mmcs002 = g_mmcs_d_o.mmcs002  #160824-00007#107 by sakura add
                  LET g_mmcs_d[l_ac].mmcs002_desc = ammt201_mmcs002_ref(g_mmcs_d[l_ac].mmcs002)
                  NEXT FIELD CURRENT 
               ELSE
                  LET g_mmcs_d[l_ac].mmcs002_desc = ammt201_mmcs002_ref(g_mmcs_d[l_ac].mmcs002)
               END IF
            END IF   
            IF g_mmcr_m.mmcrdocno IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs002 IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs003 IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs004 IS NOT NULL THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmcr_m.mmcrdocno != g_mmcrdocno_t OR g_mmcs_d[g_detail_idx].mmcs002 != g_mmcs_d_t.mmcs002 OR g_mmcs_d[g_detail_idx].mmcs003 != g_mmcs_d_t.mmcs003 OR g_mmcs_d[g_detail_idx].mmcs004 != g_mmcs_d_t.mmcs004)) THEN #160824-00007#107 by sakura mark
               IF g_mmcs_d[l_ac].mmcs002 != g_mmcs_d_o.mmcs002 OR cl_null(g_mmcs_d_o.mmcs002) THEN #160824-00007#107 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmcs_t WHERE "||"mmcsent = '" ||g_enterprise|| "' AND "||"mmcsdocno = '"||g_mmcr_m.mmcrdocno ||"' AND "|| "mmcs002 = '"||g_mmcs_d[g_detail_idx].mmcs002 ||"' AND "|| "mmcs003 = '"||g_mmcs_d[g_detail_idx].mmcs003 ||"' AND "|| "mmcs004 = '"||g_mmcs_d[g_detail_idx].mmcs004 ||"'",'std-00004',0) THEN 
                     #LET g_mmcs_d[l_ac].mmcs002 = g_mmcs_d_t.mmcs002 #160824-00007#107 by sakura mark
                     LET g_mmcs_d[l_ac].mmcs002 = g_mmcs_d_o.mmcs002  #160824-00007#107 by sakura add
                     LET g_mmcs_d[l_ac].mmcs002_desc = ammt201_mmcs002_ref(g_mmcs_d[l_ac].mmcs002)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_mmcs_d[l_ac].mmcs002) AND NOT cl_null(g_mmcs_d[l_ac].mmcs003) THEN
              SELECT MAX(mmcs004)+1 INTO g_mmcs_d[l_ac].mmcs004 FROM mmcs_t 
               WHERE mmcsent = g_enterprise AND mmcsdocno = g_mmcr_m.mmcrdocno 
                 AND mmcs002 = g_mmcs_d[l_ac].mmcs002 AND mmcs003 =  g_mmcs_d[l_ac].mmcs003
              IF cl_null(g_mmcs_d[l_ac].mmcs004 ) THEN
                LET g_mmcs_d[l_ac].mmcs004  = 1
              END IF
            END IF

            LET g_mmcs_d_o.* = g_mmcs_d[l_ac].*  #160824-00007#107 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs002
            #add-point:BEFORE FIELD mmcs002 name="input.b.page1.mmcs002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcs002
            #add-point:ON CHANGE mmcs002 name="input.g.page1.mmcs002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs003
            #add-point:BEFORE FIELD mmcs003 name="input.b.page1.mmcs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs003
            
            #add-point:AFTER FIELD mmcs003 name="input.a.page1.mmcs003"
           IF NOT cl_null(g_mmcs_d[l_ac].mmcs003) THEN
               IF g_mmcs_d[l_ac].mmcs003 <=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_mmcs_d[l_ac].mmcs003 = g_mmcs_d_t.mmcs003 #160824-00007#107 by sakura mark
                  LET g_mmcs_d[l_ac].mmcs003 = g_mmcs_d_o.mmcs003  #160824-00007#107 by sakura add
                  NEXT FIELD mmcs003
               END IF
            END IF

           #此段落由子樣板a05產生
            IF g_mmcr_m.mmcrdocno IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs002 IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs003 IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs004 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmcr_m.mmcrdocno != g_mmcrdocno_t OR g_mmcs_d[g_detail_idx].mmcs002 != g_mmcs_d_t.mmcs002 OR g_mmcs_d[g_detail_idx].mmcs003 != g_mmcs_d_t.mmcs003 OR g_mmcs_d[g_detail_idx].mmcs004 != g_mmcs_d_t.mmcs004)) THEN  #160824-00007#107 by sakura mark
               IF g_mmcs_d[l_ac].mmcs003 != g_mmcs_d_o.mmcs003 OR cl_null(g_mmcs_d_o.mmcs003) THEN #160824-00007#107 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmcs_t WHERE "||"mmcsent = '" ||g_enterprise|| "' AND "||"mmcsdocno = '"||g_mmcr_m.mmcrdocno ||"' AND "|| "mmcs002 = '"||g_mmcs_d[g_detail_idx].mmcs002 ||"' AND "|| "mmcs003 = '"||g_mmcs_d[g_detail_idx].mmcs003 ||"' AND "|| "mmcs004 = '"||g_mmcs_d[g_detail_idx].mmcs004 ||"'",'std-00004',0) THEN 
                     #LET g_mmcs_d[l_ac].mmcs003 = g_mmcs_d_t.mmcs003 #160824-00007#107 by sakura mark
                     LET g_mmcs_d[l_ac].mmcs003 = g_mmcs_d_o.mmcs003  #160824-00007#107 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_mmcs_d[l_ac].mmcs002) AND NOT cl_null(g_mmcs_d[l_ac].mmcs003) THEN
              SELECT MAX(mmcs004)+1 INTO g_mmcs_d[l_ac].mmcs004 FROM mmcs_t 
               WHERE mmcsent = g_enterprise AND mmcsdocno = g_mmcr_m.mmcrdocno 
                 AND mmcs002 = g_mmcs_d[l_ac].mmcs002 AND mmcs003 =  g_mmcs_d[l_ac].mmcs003
              IF cl_null(g_mmcs_d[l_ac].mmcs004 ) THEN
                LET g_mmcs_d[l_ac].mmcs004  = 1
              END IF
            END IF

            LET g_mmcs_d_o.* = g_mmcs_d[l_ac].*  #160824-00007#107 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcs003
            #add-point:ON CHANGE mmcs003 name="input.g.page1.mmcs003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs004
            #add-point:BEFORE FIELD mmcs004 name="input.b.page1.mmcs004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs004
            
            #add-point:AFTER FIELD mmcs004 name="input.a.page1.mmcs004"
            #此段落由子樣板a05產生
            IF  g_mmcr_m.mmcrdocno IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs002 IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs003 IS NOT NULL AND g_mmcs_d[g_detail_idx].mmcs004 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmcr_m.mmcrdocno != g_mmcrdocno_t OR g_mmcs_d[g_detail_idx].mmcs002 != g_mmcs_d_t.mmcs002 OR g_mmcs_d[g_detail_idx].mmcs003 != g_mmcs_d_t.mmcs003 OR g_mmcs_d[g_detail_idx].mmcs004 != g_mmcs_d_t.mmcs004)) THEN  #160824-00007#107 by sakura mark
               IF g_mmcs_d[l_ac].mmcs004 != g_mmcs_d_o.mmcs004 OR cl_null(g_mmcs_d_o.mmcs004) THEN #160824-00007#107 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmcs_t WHERE "||"mmcsent = '" ||g_enterprise|| "' AND "||"mmcsdocno = '"||g_mmcr_m.mmcrdocno ||"' AND "|| "mmcs002 = '"||g_mmcs_d[g_detail_idx].mmcs002 ||"' AND "|| "mmcs003 = '"||g_mmcs_d[g_detail_idx].mmcs003 ||"' AND "|| "mmcs004 = '"||g_mmcs_d[g_detail_idx].mmcs004 ||"'",'std-00004',0) THEN 
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_mmcs_d_o.* = g_mmcs_d[l_ac].*  #160824-00007#107 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcs004
            #add-point:ON CHANGE mmcs004 name="input.g.page1.mmcs004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs005
            #add-point:BEFORE FIELD mmcs005 name="input.b.page1.mmcs005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs005
            
            #add-point:AFTER FIELD mmcs005 name="input.a.page1.mmcs005"
           CALL ammt201_set_entry_b(l_cmd)
           CALL ammt201_set_no_entry_b(l_cmd)
           IF NOT cl_null(g_mmcs_d[l_ac].mmcs005) THEN
               IF g_mmcs_d[l_ac].mmcs005 NOT MATCHES "[456]" THEN
                   LET g_mmcs_d[l_ac].mmcs006 =''
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcs005
            #add-point:ON CHANGE mmcs005 name="input.g.page1.mmcs005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs006
            #add-point:BEFORE FIELD mmcs006 name="input.b.page1.mmcs006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs006
            
            #add-point:AFTER FIELD mmcs006 name="input.a.page1.mmcs006"
            IF NOT cl_null(g_mmcs_d[l_ac].mmcs006) THEN
               IF g_mmcs_d[l_ac].mmcs006 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-32406'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmcs_d[l_ac].mmcs006 = g_mmcs_d_t.mmcs006
                  NEXT FIELD mmcs006
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcs006
            #add-point:ON CHANGE mmcs006 name="input.g.page1.mmcs006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs007
            #add-point:BEFORE FIELD mmcs007 name="input.b.page1.mmcs007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs007
            
            #add-point:AFTER FIELD mmcs007 name="input.a.page1.mmcs007"
            IF NOT cl_null(g_mmcs_d[l_ac].mmcs007) THEN
               IF g_mmcs_d[l_ac].mmcs007 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00004'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmcs_d[l_ac].mmcs007 = g_mmcs_d_t.mmcs007
                  NEXT FIELD mmcs007
               END IF
               IF NOT cl_null(g_mmcs_d[l_ac].mmcs008) THEN
                  IF g_mmcs_d[l_ac].mmcs007> g_mmcs_d[l_ac].mmcs008 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00142'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmcs_d[l_ac].mmcs007 = g_mmcs_d_t.mmcs007
                     NEXT FIELD mmcs007
                  END IF
               END IF
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcs007
            #add-point:ON CHANGE mmcs007 name="input.g.page1.mmcs007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcs008
            #add-point:BEFORE FIELD mmcs008 name="input.b.page1.mmcs008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcs008
            
            #add-point:AFTER FIELD mmcs008 name="input.a.page1.mmcs008"
            IF NOT cl_null(g_mmcs_d[l_ac].mmcs008) THEN
               IF g_mmcs_d[l_ac].mmcs008 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aqc-00004'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmcs_d[l_ac].mmcs008 = g_mmcs_d_t.mmcs008
                  NEXT FIELD mmcs008
               END IF
               IF NOT cl_null(g_mmcs_d[l_ac].mmcs007) THEN
                  IF g_mmcs_d[l_ac].mmcs007> g_mmcs_d[l_ac].mmcs008 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00142'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmcs_d[l_ac].mmcs008 = g_mmcs_d_t.mmcs008
                     NEXT FIELD mmcs008
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcs008
            #add-point:ON CHANGE mmcs008 name="input.g.page1.mmcs008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcsacti
            #add-point:BEFORE FIELD mmcsacti name="input.b.page1.mmcsacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcsacti
            
            #add-point:AFTER FIELD mmcsacti name="input.a.page1.mmcsacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcsacti
            #add-point:ON CHANGE mmcsacti name="input.g.page1.mmcsacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmcs001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs001
            #add-point:ON ACTION controlp INFIELD mmcs001 name="input.c.page1.mmcs001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcs002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs002
            #add-point:ON ACTION controlp INFIELD mmcs002 name="input.c.page1.mmcs002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmcs_d[l_ac].mmcs002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2024" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mmcs_d[l_ac].mmcs002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmcs_d[l_ac].mmcs002 TO mmcs002              #顯示到畫面上

            NEXT FIELD mmcs002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcs003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs003
            #add-point:ON ACTION controlp INFIELD mmcs003 name="input.c.page1.mmcs003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcs004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs004
            #add-point:ON ACTION controlp INFIELD mmcs004 name="input.c.page1.mmcs004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcs005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs005
            #add-point:ON ACTION controlp INFIELD mmcs005 name="input.c.page1.mmcs005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcs006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs006
            #add-point:ON ACTION controlp INFIELD mmcs006 name="input.c.page1.mmcs006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcs007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs007
            #add-point:ON ACTION controlp INFIELD mmcs007 name="input.c.page1.mmcs007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcs008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcs008
            #add-point:ON ACTION controlp INFIELD mmcs008 name="input.c.page1.mmcs008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcsacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcsacti
            #add-point:ON ACTION controlp INFIELD mmcsacti name="input.c.page1.mmcsacti"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmcs_d[l_ac].* = g_mmcs_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt201_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmcs_d[l_ac].mmcs002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmcs_d[l_ac].* = g_mmcs_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL ammt201_mmcs_t_mask_restore('restore_mask_o')
      
               UPDATE mmcs_t SET (mmcsdocno,mmcs001,mmcs002,mmcs003,mmcs004,mmcs005,mmcs006,mmcs007, 
                   mmcs008,mmcsacti,mmcsunit,mmcssite) = (g_mmcr_m.mmcrdocno,g_mmcs_d[l_ac].mmcs001, 
                   g_mmcs_d[l_ac].mmcs002,g_mmcs_d[l_ac].mmcs003,g_mmcs_d[l_ac].mmcs004,g_mmcs_d[l_ac].mmcs005, 
                   g_mmcs_d[l_ac].mmcs006,g_mmcs_d[l_ac].mmcs007,g_mmcs_d[l_ac].mmcs008,g_mmcs_d[l_ac].mmcsacti, 
                   g_mmcs_d[l_ac].mmcsunit,g_mmcs_d[l_ac].mmcssite)
                WHERE mmcsent = g_enterprise AND mmcsdocno = g_mmcr_m.mmcrdocno 
 
                  AND mmcs002 = g_mmcs_d_t.mmcs002 #項次   
                  AND mmcs003 = g_mmcs_d_t.mmcs003  
                  AND mmcs004 = g_mmcs_d_t.mmcs004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmcs_d[l_ac].* = g_mmcs_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmcs_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmcs_d[l_ac].* = g_mmcs_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmcs_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmcr_m.mmcrdocno
               LET gs_keys_bak[1] = g_mmcrdocno_t
               LET gs_keys[2] = g_mmcs_d[g_detail_idx].mmcs002
               LET gs_keys_bak[2] = g_mmcs_d_t.mmcs002
               LET gs_keys[3] = g_mmcs_d[g_detail_idx].mmcs003
               LET gs_keys_bak[3] = g_mmcs_d_t.mmcs003
               LET gs_keys[4] = g_mmcs_d[g_detail_idx].mmcs004
               LET gs_keys_bak[4] = g_mmcs_d_t.mmcs004
               CALL ammt201_update_b('mmcs_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL ammt201_mmcs_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mmcs_d[g_detail_idx].mmcs002 = g_mmcs_d_t.mmcs002 
                  AND g_mmcs_d[g_detail_idx].mmcs003 = g_mmcs_d_t.mmcs003 
                  AND g_mmcs_d[g_detail_idx].mmcs004 = g_mmcs_d_t.mmcs004 
 
                  ) THEN
                  LET gs_keys[01] = g_mmcr_m.mmcrdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcs_d_t.mmcs002
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcs_d_t.mmcs003
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcs_d_t.mmcs004
 
                  CALL ammt201_key_update_b(gs_keys,'mmcs_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmcr_m),util.JSON.stringify(g_mmcs_d_t)
               LET g_log2 = util.JSON.stringify(g_mmcr_m),util.JSON.stringify(g_mmcs_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL ammt201_unlock_b("mmcs_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            LET g_current_page =2 
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmcs_d[li_reproduce_target].* = g_mmcs_d[li_reproduce].*
 
               LET g_mmcs_d[li_reproduce_target].mmcs002 = NULL
               LET g_mmcs_d[li_reproduce_target].mmcs003 = NULL
               LET g_mmcs_d[li_reproduce_target].mmcs004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmcs_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmcs_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_mmcs2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmcs2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt201_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmcs2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmcs2_d[l_ac].* TO NULL 
            INITIALIZE g_mmcs2_d_t.* TO NULL 
            INITIALIZE g_mmcs2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_mmcs2_d[l_ac].mmctacti = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_mmcs2_d_t.* = g_mmcs2_d[l_ac].*     #新輸入資料
            LET g_mmcs2_d_o.* = g_mmcs2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt201_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt201_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmcs2_d[li_reproduce_target].* = g_mmcs2_d[li_reproduce].*
 
               LET g_mmcs2_d[li_reproduce_target].mmct002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET g_mmcs2_d[l_ac].mmct001 = g_mmcr_m.mmcr001
            LET g_mmcs2_d[l_ac].mmctunit = g_mmcr_m.mmcrunit
            LET g_mmcs2_d[l_ac].mmctsite = g_mmcr_m.mmcrsite
            LET g_mmcs2_d_t.* = g_mmcs2_d[l_ac].*
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
            OPEN ammt201_cl USING g_enterprise,g_mmcr_m.mmcrdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt201_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt201_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmcs2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmcs2_d[l_ac].mmct002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmcs2_d_t.* = g_mmcs2_d[l_ac].*  #BACKUP
               LET g_mmcs2_d_o.* = g_mmcs2_d[l_ac].*  #BACKUP
               CALL ammt201_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL ammt201_set_no_entry_b(l_cmd)
               IF NOT ammt201_lock_b("mmct_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt201_bcl2 INTO g_mmcs2_d[l_ac].mmct001,g_mmcs2_d[l_ac].mmct002,g_mmcs2_d[l_ac].mmctacti, 
                      g_mmcs2_d[l_ac].mmctunit,g_mmcs2_d[l_ac].mmctsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmcs2_d_mask_o[l_ac].* =  g_mmcs2_d[l_ac].*
                  CALL ammt201_mmct_t_mask()
                  LET g_mmcs2_d_mask_n[l_ac].* =  g_mmcs2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt201_show()
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
               LET gs_keys[01] = g_mmcr_m.mmcrdocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmcs2_d_t.mmct002
            
               #刪除同層單身
               IF NOT ammt201_delete_b('mmct_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt201_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt201_key_delete_b(gs_keys,'mmct_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt201_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt201_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_mmcs_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmcs2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mmct_t 
             WHERE mmctent = g_enterprise AND mmctdocno = g_mmcr_m.mmcrdocno
               AND mmct002 = g_mmcs2_d[l_ac].mmct002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmcr_m.mmcrdocno
               LET gs_keys[2] = g_mmcs2_d[g_detail_idx].mmct002
               CALL ammt201_insert_b('mmct_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmcs_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mmct_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt201_b_fill()
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
               LET g_mmcs2_d[l_ac].* = g_mmcs2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt201_bcl2
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
               LET g_mmcs2_d[l_ac].* = g_mmcs2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL ammt201_mmct_t_mask_restore('restore_mask_o')
                              
               UPDATE mmct_t SET (mmctdocno,mmct001,mmct002,mmctacti,mmctunit,mmctsite) = (g_mmcr_m.mmcrdocno, 
                   g_mmcs2_d[l_ac].mmct001,g_mmcs2_d[l_ac].mmct002,g_mmcs2_d[l_ac].mmctacti,g_mmcs2_d[l_ac].mmctunit, 
                   g_mmcs2_d[l_ac].mmctsite) #自訂欄位頁簽
                WHERE mmctent = g_enterprise AND mmctdocno = g_mmcr_m.mmcrdocno
                  AND mmct002 = g_mmcs2_d_t.mmct002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmcs2_d[l_ac].* = g_mmcs2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmct_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmcs2_d[l_ac].* = g_mmcs2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmct_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmcr_m.mmcrdocno
               LET gs_keys_bak[1] = g_mmcrdocno_t
               LET gs_keys[2] = g_mmcs2_d[g_detail_idx].mmct002
               LET gs_keys_bak[2] = g_mmcs2_d_t.mmct002
               CALL ammt201_update_b('mmct_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammt201_mmct_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmcs2_d[g_detail_idx].mmct002 = g_mmcs2_d_t.mmct002 
                  ) THEN
                  LET gs_keys[01] = g_mmcr_m.mmcrdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcs2_d_t.mmct002
                  CALL ammt201_key_update_b(gs_keys,'mmct_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmcr_m),util.JSON.stringify(g_mmcs2_d_t)
               LET g_log2 = util.JSON.stringify(g_mmcr_m),util.JSON.stringify(g_mmcs2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmct001
            #add-point:BEFORE FIELD mmct001 name="input.b.page2.mmct001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmct001
            
            #add-point:AFTER FIELD mmct001 name="input.a.page2.mmct001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmct001
            #add-point:ON CHANGE mmct001 name="input.g.page2.mmct001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmct002
            
            #add-point:AFTER FIELD mmct002 name="input.a.page2.mmct002"
            #此段落由子樣板a05產生
             LET g_mmcs2_d[l_ac].mmct002_desc = ''
             INITIALIZE g_chkparam.* TO NULL
            IF NOT cl_null( g_mmcs2_d[l_ac].mmct002) THEN
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mmcs2_d[l_ac].mmct002
               LET g_errshow = 1
                #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mman001_1") THEN
                  LET g_mmcs2_d[l_ac].mmct002_desc= ammt201_mmct002_ref(g_mmcs2_d[l_ac].mmct002)
               ELSE
                  LET g_mmcs2_d[l_ac].mmct002 = g_mmcs2_d_t.mmct002
                  LET g_mmcs2_d[l_ac].mmct002_desc= ammt201_mmct002_ref(g_mmcs2_d[l_ac].mmct002)
                #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF   
            END IF
            IF  g_mmcr_m.mmcrdocno IS NOT NULL AND g_mmcs2_d[g_detail_idx].mmct002 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmcr_m.mmcrdocno != g_mmcrdocno_t OR g_mmcs2_d[g_detail_idx].mmct002 != g_mmcs2_d_t.mmct002)) THEN  #160824-00007#107 by sakura mark
               IF g_mmcs2_d[l_ac].mmct002 != g_mmcs2_d_o.mmct002 OR cl_null(g_mmcs2_d_o.mmct002) THEN #160824-00007#107 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmct_t WHERE "||"mmctent = '" ||g_enterprise|| "' AND "||"mmctdocno = '"||g_mmcr_m.mmcrdocno ||"' AND "|| "mmct002 = '"||g_mmcs2_d[g_detail_idx].mmct002 ||"'",'std-00004',0) THEN 
                    #LET g_mmcs2_d[l_ac].mmct002 = g_mmcs2_d_t.mmct002 #160824-00007#107 by sakura mark
                    LET g_mmcs2_d[l_ac].mmct002 = g_mmcs2_d_o.mmct002  #160824-00007#107 by sakura mark
                    LET g_mmcs2_d[l_ac].mmct002_desc= ammt201_mmct002_ref(g_mmcs2_d[l_ac].mmct002) 
                    NEXT FIELD CURRENT
                  END IF 
               END IF
            END IF
            
            LET g_mmcs2_d_o.* = g_mmcs2_d[l_ac].*  #160824-00007#107 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmct002
            #add-point:BEFORE FIELD mmct002 name="input.b.page2.mmct002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmct002
            #add-point:ON CHANGE mmct002 name="input.g.page2.mmct002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmctacti
            #add-point:BEFORE FIELD mmctacti name="input.b.page2.mmctacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmctacti
            
            #add-point:AFTER FIELD mmctacti name="input.a.page2.mmctacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmctacti
            #add-point:ON CHANGE mmctacti name="input.g.page2.mmctacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmctunit
            #add-point:BEFORE FIELD mmctunit name="input.b.page2.mmctunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmctunit
            
            #add-point:AFTER FIELD mmctunit name="input.a.page2.mmctunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmctunit
            #add-point:ON CHANGE mmctunit name="input.g.page2.mmctunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mmct001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmct001
            #add-point:ON ACTION controlp INFIELD mmct001 name="input.c.page2.mmct001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmct002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmct002
            #add-point:ON ACTION controlp INFIELD mmct002 name="input.c.page2.mmct002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmcs2_d[l_ac].mmct002             #給予default值

            #給予arg

            CALL q_mman001()                                #呼叫開窗

            LET g_mmcs2_d[l_ac].mmct002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmcs2_d[l_ac].mmct002 TO mmct002              #顯示到畫面上

            NEXT FIELD mmct002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.mmctacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmctacti
            #add-point:ON ACTION controlp INFIELD mmctacti name="input.c.page2.mmctacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmctunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmctunit
            #add-point:ON ACTION controlp INFIELD mmctunit name="input.c.page2.mmctunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmcs2_d[l_ac].* = g_mmcs2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt201_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt201_unlock_b("mmct_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            LET g_current_page =1
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmcs2_d[li_reproduce_target].* = g_mmcs2_d[li_reproduce].*
 
               LET g_mmcs2_d[li_reproduce_target].mmct002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmcs2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmcs2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="ammt201.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_tree TO s_tree.*



      END DISPLAY 
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
            NEXT FIELD mmcrsite #sakura add
            #end add-point  
            NEXT FIELD mmcrdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmcs001
               WHEN "s_detail2"
                  NEXT FIELD mmct001
 
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
 
{<section id="ammt201.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION ammt201_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL ammt201_b_fill() #單身填充
      CALL ammt201_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL ammt201_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
          
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_mmcr_m.mmcrdocno
           CALL ap_ref_array2(g_ref_fields," SELECT mmcrl002 FROM mmcrl_t WHERE mmcrlent = '"||g_enterprise||"' AND mmcrldocno = ? AND mmcrl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
           LET g_mmcr_m.mmcrl002 = g_rtn_fields[1] 
           DISPLAY BY NAME g_mmcr_m.mmcrl002
           
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = g_mmcr_m.mmcrdocno
           CALL ap_ref_array2(g_ref_fields," SELECT mmcrl003 FROM mmcrl_t WHERE mmcrlent = '"||g_enterprise||"' AND mmcrldocno = ? AND mmcrl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
           LET g_mmcr_m.mmcrl003 = g_rtn_fields[1] 
           DISPLAY BY NAME g_mmcr_m.mmcrl003
           
         # CALL ammt201_mmcrsite_ref()
         #
         #  INITIALIZE g_ref_fields TO NULL
         #  LET g_ref_fields[1] = g_mmcr_m.mmcrownid
         #  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         #  LET g_mmcr_m.mmcrownid_desc = '', g_rtn_fields[1] , ''
         #  DISPLAY BY NAME g_mmcr_m.mmcrownid_desc
         #
         #  INITIALIZE g_ref_fields TO NULL
         #  LET g_ref_fields[1] = g_mmcr_m.mmcrowndp
         #  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #  LET g_mmcr_m.mmcrowndp_desc = '', g_rtn_fields[1] , ''
         #  DISPLAY BY NAME g_mmcr_m.mmcrowndp_desc
         #
         #  INITIALIZE g_ref_fields TO NULL
         #  LET g_ref_fields[1] = g_mmcr_m.mmcrcrtid
         #  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         #  LET g_mmcr_m.mmcrcrtid_desc = '', g_rtn_fields[1] , ''
         #  DISPLAY BY NAME g_mmcr_m.mmcrcrtid_desc
         #
         #  INITIALIZE g_ref_fields TO NULL
         #  LET g_ref_fields[1] = g_mmcr_m.mmcrcrtdp
         #  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         #  LET g_mmcr_m.mmcrcrtdp_desc = '', g_rtn_fields[1] , ''
         #  DISPLAY BY NAME g_mmcr_m.mmcrcrtdp_desc
         #
         #  INITIALIZE g_ref_fields TO NULL
         #  LET g_ref_fields[1] = g_mmcr_m.mmcrmodid
         #  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         #  LET g_mmcr_m.mmcrmodid_desc = '', g_rtn_fields[1] , ''
         #  DISPLAY BY NAME g_mmcr_m.mmcrmodid_desc
         #
         #  INITIALIZE g_ref_fields TO NULL
         #  LET g_ref_fields[1] = g_mmcr_m.mmcrcnfid
         #  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
         #  LET g_mmcr_m.mmcrcnfid_desc = '', g_rtn_fields[1] , ''
         #  DISPLAY BY NAME g_mmcr_m.mmcrcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mmcr_m_mask_o.* =  g_mmcr_m.*
   CALL ammt201_mmcr_t_mask()
   LET g_mmcr_m_mask_n.* =  g_mmcr_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmcr_m.mmcrsite,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000, 
       g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrownid_desc, 
       g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid,g_mmcr_m.mmcrcrtid_desc,g_mmcr_m.mmcrcrtdp, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrmoddt, 
       g_mmcr_m.mmcrcnfid,g_mmcr_m.mmcrcnfid_desc,g_mmcr_m.mmcrcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmcr_m.mmcrstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mmcs_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mmcs2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
     
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL ammt201_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION ammt201_detail_show()
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
 
{<section id="ammt201.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt201_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mmcr_t.mmcrdocno 
   DEFINE l_oldno     LIKE mmcr_t.mmcrdocno 
 
   DEFINE l_master    RECORD LIKE mmcr_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mmcs_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mmct_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004 
   #ken---add---e
   DEFINE l_insert      LIKE type_t.num5 #sakura add
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
   
   IF g_mmcr_m.mmcrdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mmcrdocno_t = g_mmcr_m.mmcrdocno
 
    
   LET g_mmcr_m.mmcrdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmcr_m.mmcrownid = g_user
      LET g_mmcr_m.mmcrowndp = g_dept
      LET g_mmcr_m.mmcrcrtid = g_user
      LET g_mmcr_m.mmcrcrtdp = g_dept 
      LET g_mmcr_m.mmcrcrtdt = cl_get_current()
      LET g_mmcr_m.mmcrmodid = g_user
      LET g_mmcr_m.mmcrmoddt = cl_get_current()
      LET g_mmcr_m.mmcrstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #sakura---add---str   
   CALL s_aooi500_default(g_prog,'mmcrsite',g_mmcr_m.mmcrsite)
      RETURNING l_insert,g_mmcr_m.mmcrsite
   IF l_insert = FALSE THEN
      RETURN
   END IF      
   #sakura---add---end   
   #ken---add---s 需求單號：141125-00002 項次：4
   #預設單據的單別 
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_mmcr_m.mmcrsite,g_prog,'1')
        RETURNING l_success, l_doctype
   LET g_mmcr_m.mmcrdocno = l_doctype      
   #ken---add---e 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmcr_m.mmcrstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL ammt201_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mmcr_m.* TO NULL
      INITIALIZE g_mmcs_d TO NULL
      INITIALIZE g_mmcs2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL ammt201_show()
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
   CALL ammt201_set_act_visible()   
   CALL ammt201_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmcrdocno_t = g_mmcr_m.mmcrdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmcrent = " ||g_enterprise|| " AND",
                      " mmcrdocno = '", g_mmcr_m.mmcrdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt201_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL ammt201_idx_chk()
   
   LET g_data_owner = g_mmcr_m.mmcrownid      
   LET g_data_dept  = g_mmcr_m.mmcrowndp
   
   #功能已完成,通報訊息中心
   CALL ammt201_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION ammt201_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmcs_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mmct_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE ammt201_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmcs_t
    WHERE mmcsent = g_enterprise AND mmcsdocno = g_mmcrdocno_t
 
    INTO TEMP ammt201_detail
 
   #將key修正為調整後   
   UPDATE ammt201_detail 
      #更新key欄位
      SET mmcsdocno = g_mmcr_m.mmcrdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mmcs_t SELECT * FROM ammt201_detail
   
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
   DROP TABLE ammt201_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmct_t 
    WHERE mmctent = g_enterprise AND mmctdocno = g_mmcrdocno_t
 
    INTO TEMP ammt201_detail
 
   #將key修正為調整後   
   UPDATE ammt201_detail SET mmctdocno = g_mmcr_m.mmcrdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmct_t SELECT * FROM ammt201_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt201_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mmcrdocno_t = g_mmcr_m.mmcrdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammt201_delete()
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
   
   IF g_mmcr_m.mmcrdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.mmcrldocno = g_mmcr_m.mmcrdocno
LET g_master_multi_table_t.mmcrl002 = g_mmcr_m.mmcrl002
LET g_master_multi_table_t.mmcrl003 = g_mmcr_m.mmcrl003
 
   
   CALL s_transaction_begin()
 
   OPEN ammt201_cl USING g_enterprise,g_mmcr_m.mmcrdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt201_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt201_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt201_master_referesh USING g_mmcr_m.mmcrdocno INTO g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt, 
       g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrcrtid, 
       g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt,g_mmcr_m.mmcrcnfid, 
       g_mmcr_m.mmcrcnfdt,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrownid_desc,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid_desc, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT ammt201_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmcr_m_mask_o.* =  g_mmcr_m.*
   CALL ammt201_mmcr_t_mask()
   LET g_mmcr_m_mask_n.* =  g_mmcr_m.*
   
   CALL ammt201_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammt201_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mmcrdocno_t = g_mmcr_m.mmcrdocno
 
 
      DELETE FROM mmcr_t
       WHERE mmcrent = g_enterprise AND mmcrdocno = g_mmcr_m.mmcrdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mmcr_m.mmcrdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      DELETE FROM mmcrl_t 
       WHERE mmcrlent =g_enterprise 
         AND mmcrldocno = g_mmcr_m.mmcrdocno 
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del mmcrl_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #sakura---add---str
      IF NOT s_aooi200_del_docno(g_mmcr_m.mmcrdocno,g_mmcr_m.mmcrdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #sakura---add---end
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mmcs_t
       WHERE mmcsent = g_enterprise AND mmcsdocno = g_mmcr_m.mmcrdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmcs_t:",SQLERRMESSAGE 
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
      DELETE FROM mmct_t
       WHERE mmctent = g_enterprise AND
             mmctdocno = g_mmcr_m.mmcrdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmct_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmcr_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE ammt201_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mmcs_d.clear() 
      CALL g_mmcs2_d.clear()       
 
     
      CALL ammt201_ui_browser_refresh()  
      #CALL ammt201_ui_headershow()  
      #CALL ammt201_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'mmcrlent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.mmcrldocno
   LET l_field_keys[02] = 'mmcrldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mmcrl_t')
 
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL ammt201_browser_fill("")
         CALL ammt201_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammt201_cl
 
   #功能已完成,通報訊息中心
   CALL ammt201_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="ammt201.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammt201_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mmcs_d.clear()
   CALL g_mmcs2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF ammt201_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmcs001,mmcs002,mmcs003,mmcs004,mmcs005,mmcs006,mmcs007,mmcs008, 
             mmcsacti,mmcsunit,mmcssite ,t1.oocql004 FROM mmcs_t",   
                     " INNER JOIN mmcr_t ON mmcrent = " ||g_enterprise|| " AND mmcrdocno = mmcsdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='2024' AND t1.oocql002=mmcs002 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE mmcsent=? AND mmcsdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmcs_t.mmcs002,mmcs_t.mmcs003,mmcs_t.mmcs004"
         
         #add-point:單身填充控制 name="b_fill.sql"
      LET g_sql = "SELECT mmcs001,mmcs002,mmcs003,mmcs004,mmcs005,mmcs006,mmcs007,mmcs008,", 
                  "               mmcsacti, mmcsunit,mmcssite ,t1.oocql004 FROM mmcs_t",    
                  " INNER JOIN mmcr_t ON mmcrdocno = mmcsdocno ",
                  " INNER JOIN oocq_t ON oocqent = mmcsent AND oocq001 = '2024' AND oocq002 = mmcs002",
                    " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='2024' AND t1.oocql002=mmcs002 AND t1.oocql003='"||g_dlang||"' ",
                  " WHERE mmcsent=? AND mmcsdocno=?"
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      LET g_sql = g_sql, " ORDER BY  CAST(oocq009 AS NUMBER(5,0)) DESC,mmcs_t.mmcs003,mmcs_t.mmcs004"
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt201_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR ammt201_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mmcr_m.mmcrdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mmcr_m.mmcrdocno INTO g_mmcs_d[l_ac].mmcs001,g_mmcs_d[l_ac].mmcs002, 
          g_mmcs_d[l_ac].mmcs003,g_mmcs_d[l_ac].mmcs004,g_mmcs_d[l_ac].mmcs005,g_mmcs_d[l_ac].mmcs006, 
          g_mmcs_d[l_ac].mmcs007,g_mmcs_d[l_ac].mmcs008,g_mmcs_d[l_ac].mmcsacti,g_mmcs_d[l_ac].mmcsunit, 
          g_mmcs_d[l_ac].mmcssite,g_mmcs_d[l_ac].mmcs002_desc   #(ver:78)
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
    
   #判斷是否填充
   IF ammt201_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmct001,mmct002,mmctacti,mmctunit,mmctsite ,t2.mmanl003 FROM mmct_t", 
                
                     " INNER JOIN  mmcr_t ON mmcrent = " ||g_enterprise|| " AND mmcrdocno = mmctdocno ",
 
                     "",
                     
                                    " LEFT JOIN mmanl_t t2 ON t2.mmanlent="||g_enterprise||" AND t2.mmanl001=mmct002 AND t2.mmanl002='"||g_dlang||"' ",
 
                     " WHERE mmctent=? AND mmctdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmct_t.mmct002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt201_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR ammt201_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_mmcr_m.mmcrdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_mmcr_m.mmcrdocno INTO g_mmcs2_d[l_ac].mmct001,g_mmcs2_d[l_ac].mmct002, 
          g_mmcs2_d[l_ac].mmctacti,g_mmcs2_d[l_ac].mmctunit,g_mmcs2_d[l_ac].mmctsite,g_mmcs2_d[l_ac].mmct002_desc  
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
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_mmcs_d.deleteElement(g_mmcs_d.getLength())
   CALL g_mmcs2_d.deleteElement(g_mmcs2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammt201_pb
   FREE ammt201_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmcs_d.getLength()
      LET g_mmcs_d_mask_o[l_ac].* =  g_mmcs_d[l_ac].*
      CALL ammt201_mmcs_t_mask()
      LET g_mmcs_d_mask_n[l_ac].* =  g_mmcs_d[l_ac].*
   END FOR
   
   LET g_mmcs2_d_mask_o.* =  g_mmcs2_d.*
   FOR l_ac = 1 TO g_mmcs2_d.getLength()
      LET g_mmcs2_d_mask_o[l_ac].* =  g_mmcs2_d[l_ac].*
      CALL ammt201_mmct_t_mask()
      LET g_mmcs2_d_mask_n[l_ac].* =  g_mmcs2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammt201_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mmcs_t
       WHERE mmcsent = g_enterprise AND
         mmcsdocno = ps_keys_bak[1] AND mmcs002 = ps_keys_bak[2] AND mmcs003 = ps_keys_bak[3] AND mmcs004 = ps_keys_bak[4]
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
         CALL g_mmcs_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM mmct_t
       WHERE mmctent = g_enterprise AND
             mmctdocno = ps_keys_bak[1] AND mmct002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmct_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmcs2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammt201_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mmcs_t
                  (mmcsent,
                   mmcsdocno,
                   mmcs002,mmcs003,mmcs004
                   ,mmcs001,mmcs005,mmcs006,mmcs007,mmcs008,mmcsacti,mmcsunit,mmcssite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_mmcs_d[g_detail_idx].mmcs001,g_mmcs_d[g_detail_idx].mmcs005,g_mmcs_d[g_detail_idx].mmcs006, 
                       g_mmcs_d[g_detail_idx].mmcs007,g_mmcs_d[g_detail_idx].mmcs008,g_mmcs_d[g_detail_idx].mmcsacti, 
                       g_mmcs_d[g_detail_idx].mmcsunit,g_mmcs_d[g_detail_idx].mmcssite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmcs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmcs_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO mmct_t
                  (mmctent,
                   mmctdocno,
                   mmct002
                   ,mmct001,mmctacti,mmctunit,mmctsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmcs2_d[g_detail_idx].mmct001,g_mmcs2_d[g_detail_idx].mmctacti,g_mmcs2_d[g_detail_idx].mmctunit, 
                       g_mmcs2_d[g_detail_idx].mmctsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmct_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmcs2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammt201_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmcs_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL ammt201_mmcs_t_mask_restore('restore_mask_o')
               
      UPDATE mmcs_t 
         SET (mmcsdocno,
              mmcs002,mmcs003,mmcs004
              ,mmcs001,mmcs005,mmcs006,mmcs007,mmcs008,mmcsacti,mmcsunit,mmcssite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_mmcs_d[g_detail_idx].mmcs001,g_mmcs_d[g_detail_idx].mmcs005,g_mmcs_d[g_detail_idx].mmcs006, 
                  g_mmcs_d[g_detail_idx].mmcs007,g_mmcs_d[g_detail_idx].mmcs008,g_mmcs_d[g_detail_idx].mmcsacti, 
                  g_mmcs_d[g_detail_idx].mmcsunit,g_mmcs_d[g_detail_idx].mmcssite) 
         WHERE mmcsent = g_enterprise AND mmcsdocno = ps_keys_bak[1] AND mmcs002 = ps_keys_bak[2] AND mmcs003 = ps_keys_bak[3] AND mmcs004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmcs_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmcs_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt201_mmcs_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmct_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammt201_mmct_t_mask_restore('restore_mask_o')
               
      UPDATE mmct_t 
         SET (mmctdocno,
              mmct002
              ,mmct001,mmctacti,mmctunit,mmctsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmcs2_d[g_detail_idx].mmct001,g_mmcs2_d[g_detail_idx].mmctacti,g_mmcs2_d[g_detail_idx].mmctunit, 
                  g_mmcs2_d[g_detail_idx].mmctsite) 
         WHERE mmctent = g_enterprise AND mmctdocno = ps_keys_bak[1] AND mmct002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmct_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmct_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt201_mmct_t_mask_restore('restore_mask_n')
 
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
 
{<section id="ammt201.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION ammt201_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt201.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION ammt201_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt201.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammt201_lock_b(ps_table,ps_page)
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
   #CALL ammt201_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmcs_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammt201_bcl USING g_enterprise,
                                       g_mmcr_m.mmcrdocno,g_mmcs_d[g_detail_idx].mmcs002,g_mmcs_d[g_detail_idx].mmcs003, 
                                           g_mmcs_d[g_detail_idx].mmcs004     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt201_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "mmct_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt201_bcl2 USING g_enterprise,
                                             g_mmcr_m.mmcrdocno,g_mmcs2_d[g_detail_idx].mmct002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt201_bcl2:",SQLERRMESSAGE 
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
 
{<section id="ammt201.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammt201_unlock_b(ps_table,ps_page)
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
      CLOSE ammt201_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt201_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt201_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mmcrdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmcrdocno",TRUE)
      CALL cl_set_comp_entry("mmcrdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mmcrdocdt,mmcr000,mmcrsite",TRUE) #sakura add mmcrsite
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF g_mmcr_m.mmcr000 = 'U' THEN
      CALL cl_set_comp_entry("mmcracti",TRUE) 
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt201_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmcrdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mmcrdocdt,mmcr000",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mmcrdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mmcrdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #sakura---add---str
    IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("mmcrsite,mmcrdocdt,mmcrdocno",FALSE)
   END IF   
   #sakura---add---end
   IF g_mmcr_m.mmcr000 = 'I' THEN
      CALL cl_set_comp_entry("mmcracti",FALSE) 
   END IF

   IF g_flag THEN
      CALL cl_set_comp_entry("mmcrdocno,mmcrdocdt",FALSE)
   END IF
   #sakura---add---str
   #aooi500設定的欄位控卡   
   IF NOT s_aooi500_comp_entry(g_prog,'mmcrsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("mmcrsite",FALSE)
   END IF   
   #sakura---add---end
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt201.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammt201_set_entry_b(p_cmd)
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
   IF g_current_page = 1 THEN
     IF g_mmcs_d[l_ac].mmcs005 MATCHES "[456]" THEN
        CALL cl_set_comp_entry("mmcs006",TRUE)
     END IF
   END IF
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="ammt201.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammt201_set_no_entry_b(p_cmd)
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
    IF g_current_page = 1 THEN
      IF g_mmcs_d[l_ac].mmcs005 NOT MATCHES "[456]" THEN
         CALL cl_set_comp_entry("mmcs006",FALSE)
      END IF
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="ammt201.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammt201_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammt201_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_mmcr_m.mmcrstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION ammt201_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION ammt201_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt201_default_search()
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
      LET ls_wc = ls_wc, " mmcrdocno = '", g_argv[01], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "mmcr_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmcs_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmct_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
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
 
{<section id="ammt201.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION ammt201_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.chr5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmcr_m.mmcrdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN ammt201_cl USING g_enterprise,g_mmcr_m.mmcrdocno
   IF STATUS THEN
      CLOSE ammt201_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt201_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE ammt201_master_referesh USING g_mmcr_m.mmcrdocno INTO g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt, 
       g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrcrtid, 
       g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt,g_mmcr_m.mmcrcnfid, 
       g_mmcr_m.mmcrcnfdt,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrownid_desc,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid_desc, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT ammt201_action_chk() THEN
      CLOSE ammt201_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmcr_m.mmcrsite,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000, 
       g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003,g_mmcr_m.mmcr004, 
       g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrownid_desc, 
       g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid,g_mmcr_m.mmcrcrtid_desc,g_mmcr_m.mmcrcrtdp, 
       g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrmoddt, 
       g_mmcr_m.mmcrcnfid,g_mmcr_m.mmcrcnfid_desc,g_mmcr_m.mmcrcnfdt
 
   CASE g_mmcr_m.mmcrstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mmcr_m.mmcrstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_mmcr_m.mmcrstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
            
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
            
         WHEN "Y"
            HIDE OPTION "open"
            HIDE OPTION "invalid"
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN 
            
         WHEN "X"
            HIDE OPTION "open"
            HIDE OPTION "confirmed"
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN 
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
      END CASE
      #end add-point
      
      
	  
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
      AND lc_state <> "X"
      ) OR 
      g_mmcr_m.mmcrstus = lc_state OR cl_null(lc_state) THEN
      CLOSE ammt201_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
 LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y'       
         CALL s_ammt201_conf_chk(g_mmcr_m.mmcrdocno) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_ammt201_conf_upd(g_mmcr_m.mmcrdocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmcr_m.mmcrdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                   CALL s_transaction_end('Y','1')
               
               END IF
            ELSE
               CALL s_transaction_end('N','0')  #160816-00068#4 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmcr_m.mmcrdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN            
         END IF         
      WHEN 'X'
         CALL s_ammt201_void_chk(g_mmcr_m.mmcrdocno) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_ammt201_void_upd(g_mmcr_m.mmcrdocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmcr_m.mmcrdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')  #160816-00068#4 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmcr_m.mmcrdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')  #160816-00068#4 add
            RETURN    
         END IF
   END CASE
   #end add-point
   
   LET g_mmcr_m.mmcrmodid = g_user
   LET g_mmcr_m.mmcrmoddt = cl_get_current()
   LET g_mmcr_m.mmcrstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mmcr_t 
      SET (mmcrstus,mmcrmodid,mmcrmoddt) 
        = (g_mmcr_m.mmcrstus,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt)     
    WHERE mmcrent = g_enterprise AND mmcrdocno = g_mmcr_m.mmcrdocno
 
    
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE ammt201_master_referesh USING g_mmcr_m.mmcrdocno INTO g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocdt, 
          g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcr004, 
          g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrowndp, 
          g_mmcr_m.mmcrcrtid,g_mmcr_m.mmcrcrtdp,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmoddt, 
          g_mmcr_m.mmcrcnfid,g_mmcr_m.mmcrcnfdt,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrownid_desc,g_mmcr_m.mmcrowndp_desc, 
          g_mmcr_m.mmcrcrtid_desc,g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mmcr_m.mmcrsite,g_mmcr_m.mmcrsite_desc,g_mmcr_m.mmcrdocdt,g_mmcr_m.mmcrdocno, 
          g_mmcr_m.mmcr000,g_mmcr_m.mmcrunit,g_mmcr_m.mmcr001,g_mmcr_m.mmcr002,g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003, 
          g_mmcr_m.mmcr004,g_mmcr_m.mmcr005,g_mmcr_m.mmcracti,g_mmcr_m.mmcrstus,g_mmcr_m.mmcrownid,g_mmcr_m.mmcrownid_desc, 
          g_mmcr_m.mmcrowndp,g_mmcr_m.mmcrowndp_desc,g_mmcr_m.mmcrcrtid,g_mmcr_m.mmcrcrtid_desc,g_mmcr_m.mmcrcrtdp, 
          g_mmcr_m.mmcrcrtdp_desc,g_mmcr_m.mmcrcrtdt,g_mmcr_m.mmcrmodid,g_mmcr_m.mmcrmodid_desc,g_mmcr_m.mmcrmoddt, 
          g_mmcr_m.mmcrcnfid,g_mmcr_m.mmcrcnfid_desc,g_mmcr_m.mmcrcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE ammt201_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt201_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt201.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION ammt201_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmcs_d.getLength() THEN
         LET g_detail_idx = g_mmcs_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmcs_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmcs_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmcs2_d.getLength() THEN
         LET g_detail_idx = g_mmcs2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmcs2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmcs2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammt201_b_fill2(pi_idx)
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
   
   CALL ammt201_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION ammt201_fill_chk(ps_idx)
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
 
{<section id="ammt201.status_show" >}
PRIVATE FUNCTION ammt201_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt201.mask_functions" >}
&include "erp/amm/ammt201_mask.4gl"
 
{</section>}
 
{<section id="ammt201.signature" >}
   
 
{</section>}
 
{<section id="ammt201.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammt201_set_pk_array()
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
   LET g_pk_array[1].values = g_mmcr_m.mmcrdocno
   LET g_pk_array[1].column = 'mmcrdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt201.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="ammt201.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammt201_msgcentre_notify(lc_state)
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
   CALL ammt201_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmcr_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt201.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammt201_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#21 add-S
   SELECT mmcrstus  INTO g_mmcr_m.mmcrstus
     FROM mmcr_t
    WHERE mmcrent = g_enterprise
      AND mmcrdocno = g_mmcr_m.mmcrdocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mmcr_m.mmcrstus
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
        LET g_errparam.extend = g_mmcr_m.mmcrdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL ammt201_set_act_visible()
        CALL ammt201_set_act_no_visible()
        CALL ammt201_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#21 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt201.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_tree_fill()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_tree_fill()
DEFINE l_n        LIKE type_t.num5
DEFINE l_pid      LIKE type_t.chr50   #用於樹的第一層
DEFINE ls_msg     STRING
DEFINE l_n2       LIKE type_t.num5
DEFINE l_sql      LIKE type_t.chr500
DEFINE l_show     LIKE type_t.chr100
DEFINE l_seq      LIKE type_t.num5

   LET l_sql = "SELECT oocq002,oocq009 FROM (SELECT * FROM oocq_t WHERE oocqent = '",g_enterprise,"' AND oocq001 = '2024' AND oocqstus = 'Y' ORDER BY CAST(oocq009 AS NUMBER(5,0)) DESC) WHERE rownum = 1"
   PREPARE tree_fill FROM l_sql
   DECLARE tree_fill_cur CURSOR FOR tree_fill

 

   CALL g_tree.clear()
   LET g_cnt = 0
   LET l_n = 1
   
   FOREACH tree_fill_cur INTO l_show,l_seq
      LET g_cnt = g_cnt + 1 
      LET g_tree[g_cnt].b_pid = '0' CLIPPED
      LET g_tree[g_cnt].b_id = g_cnt USING "<<<"
      
      LET g_ref_fields[1] = l_show 
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_show
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql003='"||g_lang||"' AND oocql002= ? ","") RETURNING g_rtn_fields     
      LET g_tree[g_cnt].b_show = l_show ,"(",g_rtn_fields[1],")"
      LET g_tree[g_cnt].b_exp = TRUE
      LET g_tree[g_cnt].b_hasC = TRUE
      LET g_tree[g_cnt].b_isExp = TRUE
      LET l_pid = g_tree[g_cnt].b_id CLIPPED
      LET l_n = g_cnt
   
      LET g_tree[g_cnt].b_hasC = ammt201_chk_hasC(l_show,l_seq)
      IF g_tree[g_cnt].b_hasC = 1 THEN
        CALL l_show_t.clear()
        CALL ammt201_tree_fill_1(g_tree[g_cnt].b_id,l_show,0,l_seq)
       
      END IF
   END FOREACH
   FREE tree_fill_cur
   


END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_mmcrsite_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_mmcrsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmcr_m.mmcrsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmcr_m.mmcrsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmcr_m.mmcrsite_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_mmcrsite_chk(p_mmcrsite)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_mmcrsite_chk(p_mmcrsite)
DEFINE l_cnt    LIKE type_t.num5
DEFINE l_cnt1    LIKE type_t.num5
DEFINE p_mmcrsite LIKE mmcr_t.mmcrsite
DEFINE l_sql     STRING

   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = '1'
   LET g_chkparam.arg1 = p_mmcrsite
   LET g_chkparam.arg2 = '8'
   LET g_chkparam.arg3 = g_site
   IF NOT cl_chk_exist("v_ooed004") THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_chk_mmcrdocno()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_chk_mmcrdocno()
   IF NOT s_aooi200_chk_slip(g_mmcr_m.mmcrsite,'',g_mmcr_m.mmcrdocno,g_prog) THEN
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_mmcr001_chk(p_mmcr001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_mmcr001_chk(p_cmd,p_mmcr001)
DEFINE p_cmd       LIKE type_t.chr1
DEFINE p_mmcr001   LIKE mmcr_t.mmcr001
DEFINE l_mmcustus  LIKE mmcu_t.mmcustus
DEFINE l_n         LIKE type_t.num5

   #新增
   IF g_mmcr_m.mmcr000 = 'I' THEN
      SELECT COUNT(*) INTO l_n FROM mmcu_t WHERE mmcuent = g_enterprise AND mmcu001 = p_mmcr001
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00171'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF     
   END IF
   #更改
   IF g_mmcr_m.mmcr000 = 'U' THEN
      SELECT mmcustus INTO l_mmcustus FROM mmcu_t WHERE mmcuent = g_enterprise AND mmcu001 = p_mmcr001
      IF STATUS = 100 OR cl_null(l_mmcustus) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amm-00172'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   IF p_cmd = 'a' THEN
     SELECT COUNT(*) INTO l_n FROM mmcr_t WHERE mmcrent = g_enterprise 
      AND mmcr001 = p_mmcr001 AND mmcrstus = 'N' 
   ELSE
     SELECT COUNT(*) INTO l_n FROM mmcr_t WHERE mmcrent = g_enterprise 
      AND mmcr001 = p_mmcr001 AND mmcrstus = 'N' AND mmcrdocno <> g_mmcr_m.mmcrdocno
      
   END IF
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00177'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_mmcr001_other()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_mmcr001_other()
   SELECT mmcul003,mmcul004 INTO g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003
    FROM mmcul_t WHERE mmculent =g_enterprise AND mmcul001 =  g_mmcr_m.mmcr001 AND mmcul002 = g_dlang
   
   SELECT mmcu002+1,mmcuunit ,mmcu004,mmcu005   
     INTO g_mmcr_m.mmcr002,g_mmcr_m.mmcrsite,g_mmcr_m.mmcr004,g_mmcr_m.mmcr005   
     FROM mmcu_t
    WHERE mmcuent = g_enterprise AND mmcu001 = g_mmcr_m.mmcr001
    
   IF cl_null(g_mmcr_m.mmcr002) THEN
      LET g_mmcr_m.mmcr002 = 2
   END IF
   
   LET  g_mmcr_m.mmcr002 = g_mmcr_m.mmcr002 USING "<<<<<<<<<#" 
   
   LET g_mmcr_m_t.* = g_mmcr_m.*
   DISPLAY BY NAME g_mmcr_m.mmcrsite,g_mmcr_m.mmcr004,g_mmcr_m.mmcr005 ,g_mmcr_m.mmcrl002,g_mmcr_m.mmcrl003
   CALL ammt201_mmcrsite_ref()
   
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_mmcr001_genb()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_mmcr001_genb()
   INSERT INTO mmcs_t
    SELECT g_enterprise,g_site,g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr001,mmcv002,mmcv003,mmcv004,mmcv005,mmcv006,mmcv007,mmcv008,mmcvstus FROM mmcv_t
     WHERE mmcvent = g_enterprise AND mmcv001 = g_mmcr_m.mmcr001
     
   INSERT INTO mmct_t
     SELECT g_enterprise,g_site,g_mmcr_m.mmcrsite,g_mmcr_m.mmcrdocno,g_mmcr_m.mmcr001,mmcw002,mmcwstus FROM mmcw_t
      WHERE mmcwent = g_enterprise AND mmcw001 = g_mmcr_m.mmcr001
     
     
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_mmcs002_ref(p_mmcs002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_mmcs002_ref(p_mmcs002)
DEFINE p_mmcs002  LIKE mmcs_t.mmcs002
DEFINE l_desc     LIKE type_t.chr80

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mmcs002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc = '', g_rtn_fields[1] , ''
   RETURN l_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_mmct002_ref(p_mmct002)
#                  RETURNING l_desc
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_mmct002_ref(p_mmct002)
DEFINE p_mmct002  LIKE mmct_t.mmct002
DEFINE l_desc     LIKE type_t.chr80

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mmct002
   CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_desc = '', g_rtn_fields[1] , ''
   RETURN l_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_chk_hasC(pi_id,pi_seq)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_chk_hasC(pi_id,pi_seq)
DEFINE pi_id    LIKE type_t.chr50
DEFINE pi_seq   LIKE type_t.num5
DEFINE li_cnt   INTEGER
 
  LET g_sql = "SELECT COUNT(*) FROM  oocq_t WHERE oocqent = ? AND oocq001 = '2024' AND oocqstus = 'Y' AND CAST(oocq009 AS NUMBER(5,0)) <'",pi_seq,"'"
   PREPARE ammt201_master_chk FROM g_sql
   EXECUTE ammt201_master_chk USING g_enterprise INTO li_cnt
   FREE ammt201_master_chk
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF

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
PUBLIC FUNCTION ammt201_docno_chk()
   IF cl_null(g_mmcr_m.mmcrdocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00324'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt201_tree_fill_1(p_id,p_show,p_i,p_seq)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt201_tree_fill_1(p_id,p_show,p_i,p_seq)
DEFINE p_id       LIKE type_t.chr100
DEFINE p_show     LIKE type_t.chr50
DEFINE p_i        LIKE type_t.num5
DEFINE l_sql      LIKE type_t.chr500
DEFINE l_show     LIKE type_t.chr100
DEFINE l_i        LIKE type_t.num5
DEFINE l_n        LIKE type_t.num5
DEFINE l_j        LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5
DEFINE p_seq      LIKE type_t.num5

   LET l_sql =  " SELECT oocq002,oocq009 FROM ( SELECT * FROM oocq_t WHERE oocq001 = '2024' AND oocqstus = 'Y' AND oocqent ='",g_enterprise,"' ",
                " AND CAST(oocq009 AS NUMBER(5,0))  < '",p_seq,"' ORDER BY CAST(oocq009 AS NUMBER(5,0))  DESC) WHERE rownum =1"
   PREPARE tree_fill_1 FROM l_sql
   DECLARE tree_fill_cur_1 CURSOR FOR tree_fill_1  
  
   LET l_i = p_i+1
   FOREACH tree_fill_cur_1 INTO l_show_t[l_i].show,l_show_t[l_i].seq
      LET l_i = l_i+1 
   END FOREACH 
   CALL l_show_t.deleteelement(l_i)  #刪除FOREACH最後新增的空白列
   LET l_i = l_i - 1
   LET l_cnt = l_i
   FREE tree_fill_cur_1
   IF l_i >0 THEN
      FOR l_i=p_i+1 TO l_cnt  
         LET l_show = l_show_t[l_i].show
         LET g_cnt = g_cnt + 1
         LET g_tree[g_cnt].b_pid = p_id
         LET g_tree[g_cnt].b_id = p_id,".",g_cnt USING "<<<"
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = l_show
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql003='"||g_lang||"' AND oocql002= ? ","") RETURNING g_rtn_fields     
         LET g_tree[g_cnt].b_show = l_show ,"(",g_rtn_fields[1],")"
         LET g_tree[g_cnt].b_exp = TRUE
       
         LET g_tree[g_cnt].b_hasC = ammt201_chk_hasC(l_show,l_show_t[l_i].seq)
         IF g_tree[g_cnt].b_hasC = 1 THEN
            LET l_j = l_i
            CALL ammt201_tree_fill_1(g_tree[g_cnt].b_id,l_show,l_cnt,l_show_t[l_i].seq)
            LET l_i =l_j
            LET g_cnt = g_tree.getLength()  
         END IF
         
         LET l_n = g_tree.getLength()  
           
       END FOR
    END IF  
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
PUBLIC FUNCTION ammt201_docdt_chk()
   IF cl_null(g_mmcr_m.mmcrdocdt) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00092'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

 
{</section>}
 
