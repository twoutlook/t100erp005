#該程式未解開Section, 採用最新樣板產出!
{<section id="ammm356.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-06-15 11:29:15), PR版次:0011(2016-08-19 15:47:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000175
#+ Filename...: ammm356
#+ Description: 會員卡折扣規則設定維護作業
#+ Creator....: 03247(2014-04-02 00:00:00)
#+ Modifier...: 06137 -SD/PR- 06814
 
{</section>}
 
{<section id="ammm356.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#23  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160816-00068#5   2016/08/17 By earl    調整transaction
#160729-00077#7   2016/08/17 by 06814   新增規則對象 :調整規則對象編號開窗&校驗&帶值的部份
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
PRIVATE type type_g_mmbt_m        RECORD
       mmbt004 LIKE mmbt_t.mmbt004, 
   mmbtunit LIKE mmbt_t.mmbtunit, 
   mmbtunit_desc LIKE type_t.chr80, 
   mmbt001 LIKE mmbt_t.mmbt001, 
   mmbt002 LIKE mmbt_t.mmbt002, 
   mmbtl003 LIKE mmbtl_t.mmbtl003, 
   mmbtl004 LIKE mmbtl_t.mmbtl004, 
   mmbt019 LIKE mmbt_t.mmbt019, 
   mmbt005 LIKE mmbt_t.mmbt005, 
   mmbt005_desc LIKE type_t.chr80, 
   mmbt006 LIKE mmbt_t.mmbt006, 
   mmbt003 LIKE mmbt_t.mmbt003, 
   mmbt007 LIKE mmbt_t.mmbt007, 
   mmbt008 LIKE mmbt_t.mmbt008, 
   mmbt014 LIKE mmbt_t.mmbt014, 
   mmbt015 LIKE mmbt_t.mmbt015, 
   mmbt016 LIKE mmbt_t.mmbt016, 
   mmbt017 LIKE mmbt_t.mmbt017, 
   mmbtstus LIKE mmbt_t.mmbtstus, 
   mmbtownid LIKE mmbt_t.mmbtownid, 
   mmbtownid_desc LIKE type_t.chr80, 
   mmbtowndp LIKE mmbt_t.mmbtowndp, 
   mmbtowndp_desc LIKE type_t.chr80, 
   mmbtcrtid LIKE mmbt_t.mmbtcrtid, 
   mmbtcrtid_desc LIKE type_t.chr80, 
   mmbtcrtdp LIKE mmbt_t.mmbtcrtdp, 
   mmbtcrtdp_desc LIKE type_t.chr80, 
   mmbtcrtdt LIKE mmbt_t.mmbtcrtdt, 
   mmbtmodid LIKE mmbt_t.mmbtmodid, 
   mmbtmodid_desc LIKE type_t.chr80, 
   mmbtmoddt LIKE mmbt_t.mmbtmoddt, 
   mmbtcnfid LIKE mmbt_t.mmbtcnfid, 
   mmbtcnfid_desc LIKE type_t.chr80, 
   mmbtcnfdt LIKE mmbt_t.mmbtcnfdt, 
   mmch004_1 LIKE type_t.chr500, 
   mmch011_1 LIKE type_t.chr500, 
   mmch013_1 LIKE type_t.chr500, 
   mmch015_1 LIKE type_t.chr500, 
   mmch004_desc_1 LIKE type_t.chr500, 
   mmch012_1 LIKE type_t.chr500, 
   mmch014_1 LIKE type_t.chr500, 
   mmch016_1 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmcg_d        RECORD
       mmcg003 LIKE mmcg_t.mmcg003, 
   mmcg004 LIKE mmcg_t.mmcg004, 
   mmcg004_desc LIKE type_t.chr500, 
   mmcg005 LIKE mmcg_t.mmcg005, 
   mmcgstus LIKE mmcg_t.mmcgstus
       END RECORD
PRIVATE TYPE type_g_mmcg2_d RECORD
       mmbx004 LIKE mmbx_t.mmbx004, 
   mmbx004_desc LIKE type_t.chr500, 
   mmbx005 LIKE mmbx_t.mmbx005, 
   mmbxstus LIKE mmbx_t.mmbxstus
       END RECORD
PRIVATE TYPE type_g_mmcg3_d RECORD
       mmch003 LIKE mmch_t.mmch003, 
   mmch004 LIKE mmch_t.mmch004, 
   mmch004_desc LIKE type_t.chr500, 
   mmch005 LIKE mmch_t.mmch005, 
   mmch006 LIKE mmch_t.mmch006, 
   mmch007 LIKE mmch_t.mmch007, 
   mmch008 LIKE mmch_t.mmch008, 
   mmch009 LIKE mmch_t.mmch009, 
   mmch010 LIKE mmch_t.mmch010, 
   mmch011 LIKE mmch_t.mmch011, 
   mmch012 LIKE mmch_t.mmch012, 
   mmch013 LIKE mmch_t.mmch013, 
   mmch014 LIKE mmch_t.mmch014, 
   mmch015 LIKE mmch_t.mmch015, 
   mmch016 LIKE mmch_t.mmch016, 
   mmchstus LIKE mmch_t.mmchstus
       END RECORD
PRIVATE TYPE type_g_mmcg4_d RECORD
       mmdk005 LIKE mmdk_t.mmdk005, 
   mmdk006 LIKE mmdk_t.mmdk006, 
   mmdk007 LIKE mmdk_t.mmdk007, 
   mmdk008 LIKE mmdk_t.mmdk008, 
   mmdk009 LIKE mmdk_t.mmdk009, 
   mmdk010 LIKE mmdk_t.mmdk010, 
   mmdk011 LIKE mmdk_t.mmdk011, 
   mmdkacti LIKE mmdk_t.mmdkacti
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mmbt001 LIKE mmbt_t.mmbt001,
   b_mmbt001_desc LIKE type_t.chr80,
      b_mmbt002 LIKE mmbt_t.mmbt002,
      b_mmbt004 LIKE mmbt_t.mmbt004,
      b_mmbt005 LIKE mmbt_t.mmbt005,
      b_mmbt006 LIKE mmbt_t.mmbt006,
      b_mmbt007 LIKE mmbt_t.mmbt007,
      b_mmbt008 LIKE mmbt_t.mmbt008,
      b_mmbt015 LIKE mmbt_t.mmbt015,
      b_mmbt016 LIKE mmbt_t.mmbt016,
      b_mmbt017 LIKE mmbt_t.mmbt017
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_mmbt_m          type_g_mmbt_m
DEFINE g_mmbt_m_t        type_g_mmbt_m
DEFINE g_mmbt_m_o        type_g_mmbt_m
DEFINE g_mmbt_m_mask_o   type_g_mmbt_m #轉換遮罩前資料
DEFINE g_mmbt_m_mask_n   type_g_mmbt_m #轉換遮罩後資料
 
   DEFINE g_mmbt001_t LIKE mmbt_t.mmbt001
 
 
DEFINE g_mmcg_d          DYNAMIC ARRAY OF type_g_mmcg_d
DEFINE g_mmcg_d_t        type_g_mmcg_d
DEFINE g_mmcg_d_o        type_g_mmcg_d
DEFINE g_mmcg_d_mask_o   DYNAMIC ARRAY OF type_g_mmcg_d #轉換遮罩前資料
DEFINE g_mmcg_d_mask_n   DYNAMIC ARRAY OF type_g_mmcg_d #轉換遮罩後資料
DEFINE g_mmcg2_d          DYNAMIC ARRAY OF type_g_mmcg2_d
DEFINE g_mmcg2_d_t        type_g_mmcg2_d
DEFINE g_mmcg2_d_o        type_g_mmcg2_d
DEFINE g_mmcg2_d_mask_o   DYNAMIC ARRAY OF type_g_mmcg2_d #轉換遮罩前資料
DEFINE g_mmcg2_d_mask_n   DYNAMIC ARRAY OF type_g_mmcg2_d #轉換遮罩後資料
DEFINE g_mmcg3_d          DYNAMIC ARRAY OF type_g_mmcg3_d
DEFINE g_mmcg3_d_t        type_g_mmcg3_d
DEFINE g_mmcg3_d_o        type_g_mmcg3_d
DEFINE g_mmcg3_d_mask_o   DYNAMIC ARRAY OF type_g_mmcg3_d #轉換遮罩前資料
DEFINE g_mmcg3_d_mask_n   DYNAMIC ARRAY OF type_g_mmcg3_d #轉換遮罩後資料
DEFINE g_mmcg4_d          DYNAMIC ARRAY OF type_g_mmcg4_d
DEFINE g_mmcg4_d_t        type_g_mmcg4_d
DEFINE g_mmcg4_d_o        type_g_mmcg4_d
DEFINE g_mmcg4_d_mask_o   DYNAMIC ARRAY OF type_g_mmcg4_d #轉換遮罩前資料
DEFINE g_mmcg4_d_mask_n   DYNAMIC ARRAY OF type_g_mmcg4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      mmbtl001 LIKE mmbtl_t.mmbtl001,
      mmbtl003 LIKE mmbtl_t.mmbtl003,
      mmbtl004 LIKE mmbtl_t.mmbtl004
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
DEFINE g_wc2_table4   STRING
 
 
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
 
{<section id="ammm356.main" >}
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
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
    
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mmbt004,mmbtunit,'',mmbt001,mmbt002,'','',mmbt019,mmbt005,'',mmbt006, 
       mmbt003,mmbt007,mmbt008,mmbt014,mmbt015,mmbt016,mmbt017,mmbtstus,mmbtownid,'',mmbtowndp,'',mmbtcrtid, 
       '',mmbtcrtdp,'',mmbtcrtdt,mmbtmodid,'',mmbtmoddt,mmbtcnfid,'',mmbtcnfdt,'','','','','','','', 
       ''", 
                      " FROM mmbt_t",
                      " WHERE mmbtent= ? AND mmbt001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammm356_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mmbt004,t0.mmbtunit,t0.mmbt001,t0.mmbt002,t0.mmbt019,t0.mmbt005, 
       t0.mmbt006,t0.mmbt003,t0.mmbt007,t0.mmbt008,t0.mmbt014,t0.mmbt015,t0.mmbt016,t0.mmbt017,t0.mmbtstus, 
       t0.mmbtownid,t0.mmbtowndp,t0.mmbtcrtid,t0.mmbtcrtdp,t0.mmbtcrtdt,t0.mmbtmodid,t0.mmbtmoddt,t0.mmbtcnfid, 
       t0.mmbtcnfdt,t1.ooefl003 ,t2.mmanl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 , 
       t8.ooag011",
               " FROM mmbt_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbtunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mmanl_t t2 ON t2.mmanlent="||g_enterprise||" AND t2.mmanl001=t0.mmbt005 AND t2.mmanl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mmbtownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.mmbtowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.mmbtcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.mmbtcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mmbtmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mmbtcnfid  ",
 
               " WHERE t0.mmbtent = " ||g_enterprise|| " AND t0.mmbt001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ammm356_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammm356 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammm356_init()   
 
      #進入選單 Menu (="N")
      CALL ammm356_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammm356
      
   END IF 
   
   CLOSE ammm356_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammm356.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammm356_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
   DEFINE comb_value     STRING,
          comb_item      STRING 
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
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('mmbtstus','50','N,Y,X')
 
      CALL cl_set_combo_scc('mmbt004','6516') 
   CALL cl_set_combo_scc('mmbt019','6856') 
   CALL cl_set_combo_scc('mmbt007','6517') 
   CALL cl_set_combo_scc('mmbt008','6517') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   CALL cl_set_combo_scc('mmbt003','6046')
   CALL cl_set_combo_scc('b_mmbt004','6516')
   CALL cl_set_combo_scc_part('b_mmbt007','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V")
   CALL cl_set_combo_scc_part('b_mmbt008','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V")
   
   CALL cl_set_combo_scc_part('mmbt007','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V")
   CALL cl_set_combo_scc_part('mmbt008','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V")
   CALL cl_set_combo_scc_part('mmch003','6517',"1,2,3,Q,T,U,V")
   CALL cl_set_combo_scc('mmch007','6518')
   CALL cl_set_combo_scc('mmch015','6520')
   CALL cl_set_combo_scc('mmch016','30')
   CALL cl_set_combo_scc('mmch015_1','6520')
   CALL cl_set_combo_scc('mmch016_1','30')
   #160613-00031#5 Add By Ken 160615(S)
   CALL cl_set_combo_scc('mmdk010','6520')
   CALL cl_set_combo_scc('mmdk011','30')
   #160613-00031#5 Add By Ken 160615(E)
   #end add-point
   
   #初始化搜尋條件
   CALL ammm356_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="ammm356.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION ammm356_ui_dialog()
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
   DEFINE l_success like type_t.num5
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_mmbt_m.* TO NULL
         CALL g_mmcg_d.clear()
         CALL g_mmcg2_d.clear()
         CALL g_mmcg3_d.clear()
         CALL g_mmcg4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ammm356_init()
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
               
               CALL ammm356_fetch('') # reload data
               LET l_ac = 1
               CALL ammm356_ui_detailshow() #Setting the current row 
         
               CALL ammm356_idx_chk()
               #NEXT FIELD mmcg003
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mmcg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammm356_idx_chk()
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
               CALL ammm356_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_mmcg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammm356_idx_chk()
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
               CALL ammm356_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mmcg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammm356_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               CALL ammm356_b_fill2('4')
 
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
            IF cl_null(l_ac) OR l_ac <= 0 THEN LET l_ac = 1 END IF
            IF l_ac>0 THEN
               LET g_mmbt_m.mmch004_1 = g_mmcg3_d[l_ac].mmch004
               LET g_mmbt_m.mmch004_desc_1 = g_mmcg3_d[l_ac].mmch004_desc 
               LET g_mmbt_m.mmch011_1 = g_mmcg3_d[l_ac].mmch011 
               LET g_mmbt_m.mmch012_1 = g_mmcg3_d[l_ac].mmch012 
               LET g_mmbt_m.mmch013_1 = g_mmcg3_d[l_ac].mmch013 
               LET g_mmbt_m.mmch014_1 = g_mmcg3_d[l_ac].mmch014 
               LET g_mmbt_m.mmch015_1 = g_mmcg3_d[l_ac].mmch015 
               LET g_mmbt_m.mmch016_1 = g_mmcg3_d[l_ac].mmch016 
               CALL ammm356_show()
            END IF
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
               CALL ammm356_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #第二階單身段落
         DISPLAY ARRAY g_mmcg4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammm356_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL ammm356_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL ammm356_browser_fill("")
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
               CALL ammm356_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL ammm356_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL ammm356_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL ammm356_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL ammm356_set_act_visible()   
            CALL ammm356_set_act_no_visible()
            IF NOT (g_mmbt_m.mmbt001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mmbtent = " ||g_enterprise|| " AND",
                                  " mmbt001 = '", g_mmbt_m.mmbt001, "' "
 
               #填到對應位置
               CALL ammm356_browser_fill("")
            END IF
         
          
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
                     WHEN la_wc[li_idx].tableid = "mmbt_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmcg_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmbx_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmch_t" 
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
               CALL ammm356_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "mmbt_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmcg_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmbx_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmch_t" 
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
                  CALL ammm356_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammm356_fetch("F")
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
               CALL ammm356_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL ammm356_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammm356_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL ammm356_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammm356_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL ammm356_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammm356_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL ammm356_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammm356_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL ammm356_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammm356_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmcg_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mmcg2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_mmcg3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_mmcg4_d)
                  LET g_export_id[4]   = "s_detail4"
 
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
               NEXT FIELD mmcg003
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
         ON ACTION remarks
            LET g_action_choice="remarks"
            IF cl_auth_chk_act("remarks") THEN
               
               #add-point:ON ACTION remarks name="menu.remarks"
               CALL aooi360_02('99','ammm356',g_mmbt_m.mmbt001,'','','','','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION issue
            LET g_action_choice="issue"
            IF cl_auth_chk_act("issue") THEN
               
               #add-point:ON ACTION issue name="menu.issue"
               CALL s_ammm356_issue_chk(g_mmbt_m.mmbt001) RETURNING l_success,g_errno
               IF l_success THEN
                  IF cl_ask_confirm('lib-018') THEN
                     CALL s_transaction_begin()
                     CALL s_ammm356_issue_upd(g_mmbt_m.mmbt001) RETURNING l_success
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','1')
                     END IF     
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmbt_m.mmbt001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammm356_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exclude
            LET g_action_choice="exclude"
            IF cl_auth_chk_act("exclude") THEN
               
               #add-point:ON ACTION exclude name="menu.exclude"
      
               CALL ammm350_01(g_mmbt_m.mmbt001)   
            
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammm356_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammm356_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammm356_set_pk_array()
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
 
{<section id="ammm356.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION ammm356_browser_fill(ps_page_action)
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
   LET l_wc = l_wc CLIPPED," AND mmbt004 = '3' "
   LET g_wc = g_wc CLIPPED," AND mmbt004 = '3' "
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mmbt001 ",
                      " FROM mmbt_t ",
                      " ",
                      " LEFT JOIN mmcg_t ON mmcgent = mmbtent AND mmbt001 = mmcg001 ", "  ",
                      #add-point:browser_fill段sql(mmcg_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN mmbx_t ON mmbxent = mmbtent AND mmbt001 = mmbx001", "  ",
                      #add-point:browser_fill段sql(mmbx_t1) name="browser_fill.cnt.join.mmbx_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mmch_t ON mmchent = mmbtent AND mmbt001 = mmch001", "  ",
                      #add-point:browser_fill段sql(mmch_t1) name="browser_fill.cnt.join.mmch_t1"
                      
                      #end add-point
 
 
                      " LEFT JOIN mmdk_t ON mmdkent = mmbtent AND mmch001 = mmdk001 AND mmch003 = mmdk003 AND mmch004 = mmdk004", "  ",
                      #add-point:browser_fill段sql(mmdk_t1) name="browser_fill.cnt.join.mmdk_t1"
                      
                      #end add-point
 
 
                      " LEFT JOIN mmbtl_t ON mmbtlent = "||g_enterprise||" AND mmbt001 = mmbtl001 AND mmbtl002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
                      " ",
 
 
                      " WHERE mmbtent = " ||g_enterprise|| " AND mmcgent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mmbt_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mmbt001 ",
                      " FROM mmbt_t ", 
                      "  ",
                      "  LEFT JOIN mmbtl_t ON mmbtlent = "||g_enterprise||" AND mmbt001 = mmbtl001 AND mmbtl002 = '",g_dlang,"' ",
                      " WHERE mmbtent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mmbt_t")
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
      INITIALIZE g_mmbt_m.* TO NULL
      CALL g_mmcg_d.clear()        
      CALL g_mmcg2_d.clear() 
      CALL g_mmcg3_d.clear() 
      CALL g_mmcg4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mmbt001,t0.mmbt002,t0.mmbt004,t0.mmbt005,t0.mmbt006,t0.mmbt007,t0.mmbt008,t0.mmbt015,t0.mmbt016,t0.mmbt017 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmbtstus,t0.mmbt001,t0.mmbt002,t0.mmbt004,t0.mmbt005,t0.mmbt006, 
          t0.mmbt007,t0.mmbt008,t0.mmbt015,t0.mmbt016,t0.mmbt017,t1.mmbtl003 ",
                  " FROM mmbt_t t0",
                  "  ",
                  "  LEFT JOIN mmcg_t ON mmcgent = mmbtent AND mmbt001 = mmcg001 ", "  ", 
                  #add-point:browser_fill段sql(mmcg_t1) name="browser_fill.join.mmcg_t1"
                  
                  #end add-point
                  "  LEFT JOIN mmbx_t ON mmbxent = mmbtent AND mmbt001 = mmbx001", "  ", 
                  #add-point:browser_fill段sql(mmbx_t1) name="browser_fill.join.mmbx_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mmch_t ON mmchent = mmbtent AND mmbt001 = mmch001", "  ", 
                  #add-point:browser_fill段sql(mmch_t1) name="browser_fill.join.mmch_t1"
                  
                  #end add-point
 
 
                  "  LEFT JOIN mmdk_t ON mmdkent = mmbtent AND mmch001 = mmdk001 AND mmch003 = mmdk003 AND mmch004 = mmdk004", "  ", 
                  #add-point:browser_fill段sql(mmdk_t1) name="browser_fill.join.mmdk_t1"
                  
                  #end add-point
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
                  " ",
 
 
                                 " LEFT JOIN mmbtl_t t1 ON t1.mmbtlent="||g_enterprise||" AND t1.mmbtl001=t0.mmbt001 AND t1.mmbtl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmbtent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mmbt_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmbtstus,t0.mmbt001,t0.mmbt002,t0.mmbt004,t0.mmbt005,t0.mmbt006, 
          t0.mmbt007,t0.mmbt008,t0.mmbt015,t0.mmbt016,t0.mmbt017,t1.mmbtl003 ",
                  " FROM mmbt_t t0",
                  "  ",
                                 " LEFT JOIN mmbtl_t t1 ON t1.mmbtlent="||g_enterprise||" AND t1.mmbtl001=t0.mmbt001 AND t1.mmbtl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmbtent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mmbt_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mmbt001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmbt_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmbt001,g_browser[g_cnt].b_mmbt002, 
          g_browser[g_cnt].b_mmbt004,g_browser[g_cnt].b_mmbt005,g_browser[g_cnt].b_mmbt006,g_browser[g_cnt].b_mmbt007, 
          g_browser[g_cnt].b_mmbt008,g_browser[g_cnt].b_mmbt015,g_browser[g_cnt].b_mmbt016,g_browser[g_cnt].b_mmbt017, 
          g_browser[g_cnt].b_mmbt001_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      IF g_browser[g_cnt].b_mmbt004 <> '3' THEN
         CONTINUE FOREACH
      END IF
         #end add-point
      
         #遮罩相關處理
         CALL ammm356_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_mmbt001) THEN
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
 
{<section id="ammm356.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION ammm356_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mmbt_m.mmbt001 = g_browser[g_current_idx].b_mmbt001   
 
   EXECUTE ammm356_master_referesh USING g_mmbt_m.mmbt001 INTO g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001, 
       g_mmbt_m.mmbt002,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
       g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus, 
       g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdt, 
       g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmbtunit_desc, 
       g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid_desc, 
       g_mmbt_m.mmbtcrtdp_desc,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtcnfid_desc
   
   CALL ammm356_mmbt_t_mask()
   CALL ammm356_show()
      
END FUNCTION
 
{</section>}
 
{<section id="ammm356.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION ammm356_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammm356_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmbt001 = g_mmbt_m.mmbt001 
 
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
 
{<section id="ammm356.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammm356_construct()
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
   INITIALIZE g_mmbt_m.* TO NULL
   CALL g_mmcg_d.clear()        
   CALL g_mmcg2_d.clear() 
   CALL g_mmcg3_d.clear() 
   CALL g_mmcg4_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON mmbt004,mmbtunit,mmbt001,mmbt002,mmbtl003,mmbtl004,mmbt019,mmbt005,mmbt006, 
          mmbt003,mmbt007,mmbt008,mmbt014,mmbt015,mmbt016,mmbt017,mmbtstus,mmbtownid,mmbtowndp,mmbtcrtid, 
          mmbtcrtdp,mmbtcrtdt,mmbtmodid,mmbtmoddt,mmbtcnfid,mmbtcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            DISPLAY '3' TO mmbt004
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmbtcrtdt>>----
         AFTER FIELD mmbtcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmbtmoddt>>----
         AFTER FIELD mmbtmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmbtcnfdt>>----
         AFTER FIELD mmbtcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmbtpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt004
            #add-point:BEFORE FIELD mmbt004 name="construct.b.mmbt004"
            DISPLAY '3' TO mmbt004
            NEXT FIELD mmbt001
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt004
            
            #add-point:AFTER FIELD mmbt004 name="construct.a.mmbt004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt004
            #add-point:ON ACTION controlp INFIELD mmbt004 name="construct.c.mmbt004"
 
            #END add-point
 
 
         #Ctrlp:construct.c.mmbtunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtunit
            #add-point:ON ACTION controlp INFIELD mmbtunit name="construct.c.mmbtunit"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#			LET g_qryparam.where = " ooef201 = 'Y' "
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbtunit',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO mmbtunit  #顯示到畫面上

            NEXT FIELD mmbtunit                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtunit
            #add-point:BEFORE FIELD mmbtunit name="construct.b.mmbtunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtunit
            
            #add-point:AFTER FIELD mmbtunit name="construct.a.mmbtunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt001
            #add-point:ON ACTION controlp INFIELD mmbt001 name="construct.c.mmbt001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3'
            CALL q_mmbt001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbt001  #顯示到畫面上

            NEXT FIELD mmbt001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt001
            #add-point:BEFORE FIELD mmbt001 name="construct.b.mmbt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt001
            
            #add-point:AFTER FIELD mmbt001 name="construct.a.mmbt001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt002
            #add-point:BEFORE FIELD mmbt002 name="construct.b.mmbt002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt002
            
            #add-point:AFTER FIELD mmbt002 name="construct.a.mmbt002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt002
            #add-point:ON ACTION controlp INFIELD mmbt002 name="construct.c.mmbt002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtl003
            #add-point:BEFORE FIELD mmbtl003 name="construct.b.mmbtl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtl003
            
            #add-point:AFTER FIELD mmbtl003 name="construct.a.mmbtl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbtl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtl003
            #add-point:ON ACTION controlp INFIELD mmbtl003 name="construct.c.mmbtl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtl004
            #add-point:BEFORE FIELD mmbtl004 name="construct.b.mmbtl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtl004
            
            #add-point:AFTER FIELD mmbtl004 name="construct.a.mmbtl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbtl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtl004
            #add-point:ON ACTION controlp INFIELD mmbtl004 name="construct.c.mmbtl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt019
            #add-point:BEFORE FIELD mmbt019 name="construct.b.mmbt019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt019
            
            #add-point:AFTER FIELD mmbt019 name="construct.a.mmbt019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt019
            #add-point:ON ACTION controlp INFIELD mmbt019 name="construct.c.mmbt019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbt005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt005
            #add-point:ON ACTION controlp INFIELD mmbt005 name="construct.c.mmbt005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 ='3'
            #CALL q_mmbo005()   #160729-00077#7 20160819 mark by beckxie 
            CALL q_mmbt005()   #160729-00077#7 20160819 add by beckxie 
            DISPLAY g_qryparam.return1 TO mmbt005  #顯示到畫面上

            NEXT FIELD mmbt005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt005
            #add-point:BEFORE FIELD mmbt005 name="construct.b.mmbt005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt005
            
            #add-point:AFTER FIELD mmbt005 name="construct.a.mmbt005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt006
            #add-point:BEFORE FIELD mmbt006 name="construct.b.mmbt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt006
            
            #add-point:AFTER FIELD mmbt006 name="construct.a.mmbt006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt006
            #add-point:ON ACTION controlp INFIELD mmbt006 name="construct.c.mmbt006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt003
            #add-point:BEFORE FIELD mmbt003 name="construct.b.mmbt003"
         
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt003
            
            #add-point:AFTER FIELD mmbt003 name="construct.a.mmbt003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt003
            #add-point:ON ACTION controlp INFIELD mmbt003 name="construct.c.mmbt003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt007
            #add-point:BEFORE FIELD mmbt007 name="construct.b.mmbt007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt007
            
            #add-point:AFTER FIELD mmbt007 name="construct.a.mmbt007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt007
            #add-point:ON ACTION controlp INFIELD mmbt007 name="construct.c.mmbt007"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbt007  #顯示到畫面上

            NEXT FIELD mmbt007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt008
            #add-point:BEFORE FIELD mmbt008 name="construct.b.mmbt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt008
            
            #add-point:AFTER FIELD mmbt008 name="construct.a.mmbt008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt008
            #add-point:ON ACTION controlp INFIELD mmbt008 name="construct.c.mmbt008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt014
            #add-point:BEFORE FIELD mmbt014 name="construct.b.mmbt014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt014
            
            #add-point:AFTER FIELD mmbt014 name="construct.a.mmbt014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt014
            #add-point:ON ACTION controlp INFIELD mmbt014 name="construct.c.mmbt014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt015
            #add-point:BEFORE FIELD mmbt015 name="construct.b.mmbt015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt015
            
            #add-point:AFTER FIELD mmbt015 name="construct.a.mmbt015"
         
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt015
            #add-point:ON ACTION controlp INFIELD mmbt015 name="construct.c.mmbt015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt016
            #add-point:BEFORE FIELD mmbt016 name="construct.b.mmbt016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt016
            
            #add-point:AFTER FIELD mmbt016 name="construct.a.mmbt016"
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt016
            #add-point:ON ACTION controlp INFIELD mmbt016 name="construct.c.mmbt016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt017
            #add-point:BEFORE FIELD mmbt017 name="construct.b.mmbt017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt017
            
            #add-point:AFTER FIELD mmbt017 name="construct.a.mmbt017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbt017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt017
            #add-point:ON ACTION controlp INFIELD mmbt017 name="construct.c.mmbt017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtstus
            #add-point:BEFORE FIELD mmbtstus name="construct.b.mmbtstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtstus
            
            #add-point:AFTER FIELD mmbtstus name="construct.a.mmbtstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbtstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtstus
            #add-point:ON ACTION controlp INFIELD mmbtstus name="construct.c.mmbtstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbtownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtownid
            #add-point:ON ACTION controlp INFIELD mmbtownid name="construct.c.mmbtownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbtownid  #顯示到畫面上

            NEXT FIELD mmbtownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtownid
            #add-point:BEFORE FIELD mmbtownid name="construct.b.mmbtownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtownid
            
            #add-point:AFTER FIELD mmbtownid name="construct.a.mmbtownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbtowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtowndp
            #add-point:ON ACTION controlp INFIELD mmbtowndp name="construct.c.mmbtowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbtowndp  #顯示到畫面上

            NEXT FIELD mmbtowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtowndp
            #add-point:BEFORE FIELD mmbtowndp name="construct.b.mmbtowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtowndp
            
            #add-point:AFTER FIELD mmbtowndp name="construct.a.mmbtowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbtcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtcrtid
            #add-point:ON ACTION controlp INFIELD mmbtcrtid name="construct.c.mmbtcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbtcrtid  #顯示到畫面上

            NEXT FIELD mmbtcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtcrtid
            #add-point:BEFORE FIELD mmbtcrtid name="construct.b.mmbtcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtcrtid
            
            #add-point:AFTER FIELD mmbtcrtid name="construct.a.mmbtcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbtcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtcrtdp
            #add-point:ON ACTION controlp INFIELD mmbtcrtdp name="construct.c.mmbtcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbtcrtdp  #顯示到畫面上

            NEXT FIELD mmbtcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtcrtdp
            #add-point:BEFORE FIELD mmbtcrtdp name="construct.b.mmbtcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtcrtdp
            
            #add-point:AFTER FIELD mmbtcrtdp name="construct.a.mmbtcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtcrtdt
            #add-point:BEFORE FIELD mmbtcrtdt name="construct.b.mmbtcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbtmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtmodid
            #add-point:ON ACTION controlp INFIELD mmbtmodid name="construct.c.mmbtmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbtmodid  #顯示到畫面上

            NEXT FIELD mmbtmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtmodid
            #add-point:BEFORE FIELD mmbtmodid name="construct.b.mmbtmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtmodid
            
            #add-point:AFTER FIELD mmbtmodid name="construct.a.mmbtmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtmoddt
            #add-point:BEFORE FIELD mmbtmoddt name="construct.b.mmbtmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbtcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtcnfid
            #add-point:ON ACTION controlp INFIELD mmbtcnfid name="construct.c.mmbtcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbtcnfid  #顯示到畫面上

            NEXT FIELD mmbtcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtcnfid
            #add-point:BEFORE FIELD mmbtcnfid name="construct.b.mmbtcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtcnfid
            
            #add-point:AFTER FIELD mmbtcnfid name="construct.a.mmbtcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtcnfdt
            #add-point:BEFORE FIELD mmbtcnfdt name="construct.b.mmbtcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmcg003,mmcg004,mmcg005,mmcgstus
           FROM s_detail1[1].mmcg003,s_detail1[1].mmcg004,s_detail1[1].mmcg005,s_detail1[1].mmcgstus
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmcgcrtdt>>----
 
         #----<<mmcgmoddt>>----
         
         #----<<mmcgcnfdt>>----
         
         #----<<mmcgpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcg003
            #add-point:BEFORE FIELD mmcg003 name="construct.b.page1.mmcg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcg003
            
            #add-point:AFTER FIELD mmcg003 name="construct.a.page1.mmcg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcg003
            #add-point:ON ACTION controlp INFIELD mmcg003 name="construct.c.page1.mmcg003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmcg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcg004
            #add-point:ON ACTION controlp INFIELD mmcg004 name="construct.c.page1.mmcg004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmcg004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmcg004  #顯示到畫面上

            NEXT FIELD mmcg004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcg004
            #add-point:BEFORE FIELD mmcg004 name="construct.b.page1.mmcg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcg004
            
            #add-point:AFTER FIELD mmcg004 name="construct.a.page1.mmcg004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcg005
            #add-point:BEFORE FIELD mmcg005 name="construct.b.page1.mmcg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcg005
            
            #add-point:AFTER FIELD mmcg005 name="construct.a.page1.mmcg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcg005
            #add-point:ON ACTION controlp INFIELD mmcg005 name="construct.c.page1.mmcg005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcgstus
            #add-point:BEFORE FIELD mmcgstus name="construct.b.page1.mmcgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcgstus
            
            #add-point:AFTER FIELD mmcgstus name="construct.a.page1.mmcgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmcgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcgstus
            #add-point:ON ACTION controlp INFIELD mmcgstus name="construct.c.page1.mmcgstus"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON mmbx004,mmbx005,mmbxstus
           FROM s_detail2[1].mmbx004,s_detail2[1].mmbx005,s_detail2[1].mmbxstus
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmbxcrtdt>>----
 
         #----<<mmbxmoddt>>----
         
         #----<<mmbxcnfdt>>----
         
         #----<<mmbxpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.mmbx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbx004
            #add-point:ON ACTION controlp INFIELD mmbx004 name="construct.c.page2.mmbx004"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef201 = 'Y' "
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmbx004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbx004',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO mmbx004  #顯示到畫面上

            NEXT FIELD mmbx004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbx004
            #add-point:BEFORE FIELD mmbx004 name="construct.b.page2.mmbx004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbx004
            
            #add-point:AFTER FIELD mmbx004 name="construct.a.page2.mmbx004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbx005
            #add-point:BEFORE FIELD mmbx005 name="construct.b.page2.mmbx005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbx005
            
            #add-point:AFTER FIELD mmbx005 name="construct.a.page2.mmbx005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbx005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbx005
            #add-point:ON ACTION controlp INFIELD mmbx005 name="construct.c.page2.mmbx005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbxstus
            #add-point:BEFORE FIELD mmbxstus name="construct.b.page2.mmbxstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbxstus
            
            #add-point:AFTER FIELD mmbxstus name="construct.a.page2.mmbxstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbxstus
            #add-point:ON ACTION controlp INFIELD mmbxstus name="construct.c.page2.mmbxstus"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON mmch003,mmch004,mmch005,mmch006,mmch007,mmch008,mmch009,mmch010,mmch011, 
          mmch012,mmch013,mmch014,mmch015,mmch016,mmchstus
           FROM s_detail3[1].mmch003,s_detail3[1].mmch004,s_detail3[1].mmch005,s_detail3[1].mmch006, 
               s_detail3[1].mmch007,s_detail3[1].mmch008,s_detail3[1].mmch009,s_detail3[1].mmch010,s_detail3[1].mmch011, 
               s_detail3[1].mmch012,s_detail3[1].mmch013,s_detail3[1].mmch014,s_detail3[1].mmch015,s_detail3[1].mmch016, 
               s_detail3[1].mmchstus
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmchcrtdt>>----
 
         #----<<mmchmoddt>>----
         
         #----<<mmchcnfdt>>----
         
         #----<<mmchpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch003
            #add-point:BEFORE FIELD mmch003 name="construct.b.page3.mmch003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch003
            
            #add-point:AFTER FIELD mmch003 name="construct.a.page3.mmch003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch003
            #add-point:ON ACTION controlp INFIELD mmch003 name="construct.c.page3.mmch003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.mmch004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch004
            #add-point:ON ACTION controlp INFIELD mmch004 name="construct.c.page3.mmch004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmch004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmch004  #顯示到畫面上

            NEXT FIELD mmch004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch004
            #add-point:BEFORE FIELD mmch004 name="construct.b.page3.mmch004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch004
            
            #add-point:AFTER FIELD mmch004 name="construct.a.page3.mmch004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch005
            #add-point:BEFORE FIELD mmch005 name="construct.b.page3.mmch005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch005
            
            #add-point:AFTER FIELD mmch005 name="construct.a.page3.mmch005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch005
            #add-point:ON ACTION controlp INFIELD mmch005 name="construct.c.page3.mmch005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch006
            #add-point:BEFORE FIELD mmch006 name="construct.b.page3.mmch006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch006
            
            #add-point:AFTER FIELD mmch006 name="construct.a.page3.mmch006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch006
            #add-point:ON ACTION controlp INFIELD mmch006 name="construct.c.page3.mmch006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch007
            #add-point:BEFORE FIELD mmch007 name="construct.b.page3.mmch007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch007
            
            #add-point:AFTER FIELD mmch007 name="construct.a.page3.mmch007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch007
            #add-point:ON ACTION controlp INFIELD mmch007 name="construct.c.page3.mmch007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch008
            #add-point:BEFORE FIELD mmch008 name="construct.b.page3.mmch008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch008
            
            #add-point:AFTER FIELD mmch008 name="construct.a.page3.mmch008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch008
            #add-point:ON ACTION controlp INFIELD mmch008 name="construct.c.page3.mmch008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch009
            #add-point:BEFORE FIELD mmch009 name="construct.b.page3.mmch009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch009
            
            #add-point:AFTER FIELD mmch009 name="construct.a.page3.mmch009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch009
            #add-point:ON ACTION controlp INFIELD mmch009 name="construct.c.page3.mmch009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch010
            #add-point:BEFORE FIELD mmch010 name="construct.b.page3.mmch010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch010
            
            #add-point:AFTER FIELD mmch010 name="construct.a.page3.mmch010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch010
            #add-point:ON ACTION controlp INFIELD mmch010 name="construct.c.page3.mmch010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch011
            #add-point:BEFORE FIELD mmch011 name="construct.b.page3.mmch011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch011
            
            #add-point:AFTER FIELD mmch011 name="construct.a.page3.mmch011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch011
            #add-point:ON ACTION controlp INFIELD mmch011 name="construct.c.page3.mmch011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch012
            #add-point:BEFORE FIELD mmch012 name="construct.b.page3.mmch012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch012
            
            #add-point:AFTER FIELD mmch012 name="construct.a.page3.mmch012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch012
            #add-point:ON ACTION controlp INFIELD mmch012 name="construct.c.page3.mmch012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch013
            #add-point:BEFORE FIELD mmch013 name="construct.b.page3.mmch013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch013
            
            #add-point:AFTER FIELD mmch013 name="construct.a.page3.mmch013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch013
            #add-point:ON ACTION controlp INFIELD mmch013 name="construct.c.page3.mmch013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch014
            #add-point:BEFORE FIELD mmch014 name="construct.b.page3.mmch014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch014
            
            #add-point:AFTER FIELD mmch014 name="construct.a.page3.mmch014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch014
            #add-point:ON ACTION controlp INFIELD mmch014 name="construct.c.page3.mmch014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch015
            #add-point:BEFORE FIELD mmch015 name="construct.b.page3.mmch015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch015
            
            #add-point:AFTER FIELD mmch015 name="construct.a.page3.mmch015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch015
            #add-point:ON ACTION controlp INFIELD mmch015 name="construct.c.page3.mmch015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch016
            #add-point:BEFORE FIELD mmch016 name="construct.b.page3.mmch016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch016
            
            #add-point:AFTER FIELD mmch016 name="construct.a.page3.mmch016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmch016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch016
            #add-point:ON ACTION controlp INFIELD mmch016 name="construct.c.page3.mmch016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmchstus
            #add-point:BEFORE FIELD mmchstus name="construct.b.page3.mmchstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmchstus
            
            #add-point:AFTER FIELD mmchstus name="construct.a.page3.mmchstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmchstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmchstus
            #add-point:ON ACTION controlp INFIELD mmchstus name="construct.c.page3.mmchstus"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
      CONSTRUCT g_wc2_table4 ON mmdk005,mmdk006,mmdk007,mmdk008,mmdk009,mmdk010,mmdk011,mmdkacti
           FROM s_detail4[1].mmdk005,s_detail4[1].mmdk006,s_detail4[1].mmdk007,s_detail4[1].mmdk008, 
               s_detail4[1].mmdk009,s_detail4[1].mmdk010,s_detail4[1].mmdk011,s_detail4[1].mmdkacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk005
            #add-point:BEFORE FIELD mmdk005 name="construct.b.page4.mmdk005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk005
            
            #add-point:AFTER FIELD mmdk005 name="construct.a.page4.mmdk005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdk005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk005
            #add-point:ON ACTION controlp INFIELD mmdk005 name="construct.c.page4.mmdk005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk006
            #add-point:BEFORE FIELD mmdk006 name="construct.b.page4.mmdk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk006
            
            #add-point:AFTER FIELD mmdk006 name="construct.a.page4.mmdk006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk006
            #add-point:ON ACTION controlp INFIELD mmdk006 name="construct.c.page4.mmdk006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk007
            #add-point:BEFORE FIELD mmdk007 name="construct.b.page4.mmdk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk007
            
            #add-point:AFTER FIELD mmdk007 name="construct.a.page4.mmdk007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk007
            #add-point:ON ACTION controlp INFIELD mmdk007 name="construct.c.page4.mmdk007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk008
            #add-point:BEFORE FIELD mmdk008 name="construct.b.page4.mmdk008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk008
            
            #add-point:AFTER FIELD mmdk008 name="construct.a.page4.mmdk008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk008
            #add-point:ON ACTION controlp INFIELD mmdk008 name="construct.c.page4.mmdk008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk009
            #add-point:BEFORE FIELD mmdk009 name="construct.b.page4.mmdk009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk009
            
            #add-point:AFTER FIELD mmdk009 name="construct.a.page4.mmdk009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk009
            #add-point:ON ACTION controlp INFIELD mmdk009 name="construct.c.page4.mmdk009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk010
            #add-point:BEFORE FIELD mmdk010 name="construct.b.page4.mmdk010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk010
            
            #add-point:AFTER FIELD mmdk010 name="construct.a.page4.mmdk010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdk010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk010
            #add-point:ON ACTION controlp INFIELD mmdk010 name="construct.c.page4.mmdk010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk011
            #add-point:BEFORE FIELD mmdk011 name="construct.b.page4.mmdk011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk011
            
            #add-point:AFTER FIELD mmdk011 name="construct.a.page4.mmdk011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdk011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk011
            #add-point:ON ACTION controlp INFIELD mmdk011 name="construct.c.page4.mmdk011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdkacti
            #add-point:BEFORE FIELD mmdkacti name="construct.b.page4.mmdkacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdkacti
            
            #add-point:AFTER FIELD mmdkacti name="construct.a.page4.mmdkacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdkacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdkacti
            #add-point:ON ACTION controlp INFIELD mmdkacti name="construct.c.page4.mmdkacti"
            
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
                  WHEN la_wc[li_idx].tableid = "mmbt_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmcg_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmbx_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mmch_t" 
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
 
 
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION ammm356_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"

   DEFINE ls_result   STRING 
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
      CONSTRUCT g_wc_filter ON mmbt001,mmbt002,mmbt004,mmbt005,mmbt006,mmbt007,mmbt008,mmbt015,mmbt016, 
          mmbt017
                          FROM s_browse[1].b_mmbt001,s_browse[1].b_mmbt002,s_browse[1].b_mmbt004,s_browse[1].b_mmbt005, 
                              s_browse[1].b_mmbt006,s_browse[1].b_mmbt007,s_browse[1].b_mmbt008,s_browse[1].b_mmbt015, 
                              s_browse[1].b_mmbt016,s_browse[1].b_mmbt017
 
         BEFORE CONSTRUCT
               DISPLAY ammm356_filter_parser('mmbt001') TO s_browse[1].b_mmbt001
            DISPLAY ammm356_filter_parser('mmbt002') TO s_browse[1].b_mmbt002
            DISPLAY ammm356_filter_parser('mmbt004') TO s_browse[1].b_mmbt004
            DISPLAY ammm356_filter_parser('mmbt005') TO s_browse[1].b_mmbt005
            DISPLAY ammm356_filter_parser('mmbt006') TO s_browse[1].b_mmbt006
            DISPLAY ammm356_filter_parser('mmbt007') TO s_browse[1].b_mmbt007
            DISPLAY ammm356_filter_parser('mmbt008') TO s_browse[1].b_mmbt008
            DISPLAY ammm356_filter_parser('mmbt015') TO s_browse[1].b_mmbt015
            DISPLAY ammm356_filter_parser('mmbt016') TO s_browse[1].b_mmbt016
            DISPLAY ammm356_filter_parser('mmbt017') TO s_browse[1].b_mmbt017
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         DISPLAY '3' TO b_mmbt004
         BEFORE FIELD b_mmbt004
            NEXT FIELD b_mmbt005 
            
            AFTER FIELD b_mmbt016
                 CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
                 IF NOT cl_null(ls_result) THEN
                   IF NOT cl_chk_date_symbol(ls_result) THEN
                      LET ls_result = cl_add_date_extra_cond(ls_result)
                   END IF
                 END IF
                 CALL FGL_DIALOG_SETBUFFER(ls_result)
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
 
      CALL ammm356_filter_show('mmbt001')
   CALL ammm356_filter_show('mmbt002')
   CALL ammm356_filter_show('mmbt004')
   CALL ammm356_filter_show('mmbt005')
   CALL ammm356_filter_show('mmbt006')
   CALL ammm356_filter_show('mmbt007')
   CALL ammm356_filter_show('mmbt008')
   CALL ammm356_filter_show('mmbt015')
   CALL ammm356_filter_show('mmbt016')
   CALL ammm356_filter_show('mmbt017')
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION ammm356_filter_parser(ps_field)
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
 
{<section id="ammm356.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION ammm356_filter_show(ps_field)
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
   LET ls_condition = ammm356_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammm356_query()
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
   CALL g_mmcg_d.clear()
   CALL g_mmcg2_d.clear()
   CALL g_mmcg3_d.clear()
   CALL g_mmcg4_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL ammm356_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammm356_browser_fill("")
      CALL ammm356_fetch("")
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
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL ammm356_filter_show('mmbt001')
   CALL ammm356_filter_show('mmbt002')
   CALL ammm356_filter_show('mmbt004')
   CALL ammm356_filter_show('mmbt005')
   CALL ammm356_filter_show('mmbt006')
   CALL ammm356_filter_show('mmbt007')
   CALL ammm356_filter_show('mmbt008')
   CALL ammm356_filter_show('mmbt015')
   CALL ammm356_filter_show('mmbt016')
   CALL ammm356_filter_show('mmbt017')
   CALL ammm356_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL ammm356_fetch("F") 
      #顯示單身筆數
      CALL ammm356_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammm356_fetch(p_flag)
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
   CALL g_mmcg4_d.clear()
 
   
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
   
   LET g_mmbt_m.mmbt001 = g_browser[g_current_idx].b_mmbt001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE ammm356_master_referesh USING g_mmbt_m.mmbt001 INTO g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001, 
       g_mmbt_m.mmbt002,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
       g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus, 
       g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdt, 
       g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmbtunit_desc, 
       g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid_desc, 
       g_mmbt_m.mmbtcrtdp_desc,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtcnfid_desc
   
   #遮罩相關處理
   LET g_mmbt_m_mask_o.* =  g_mmbt_m.*
   CALL ammm356_mmbt_t_mask()
   LET g_mmbt_m_mask_n.* =  g_mmbt_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammm356_set_act_visible()   
   CALL ammm356_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
  
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmbt_m_t.* = g_mmbt_m.*
   LET g_mmbt_m_o.* = g_mmbt_m.*
   
   LET g_data_owner = g_mmbt_m.mmbtownid      
   LET g_data_dept  = g_mmbt_m.mmbtowndp
   
   #重新顯示   
   CALL ammm356_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammm356_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmcg_d.clear()   
   CALL g_mmcg2_d.clear()  
   CALL g_mmcg3_d.clear()  
   CALL g_mmcg4_d.clear()  
 
 
   INITIALIZE g_mmbt_m.* TO NULL             #DEFAULT 設定
   
   LET g_mmbt001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmbt_m.mmbtownid = g_user
      LET g_mmbt_m.mmbtowndp = g_dept
      LET g_mmbt_m.mmbtcrtid = g_user
      LET g_mmbt_m.mmbtcrtdp = g_dept 
      LET g_mmbt_m.mmbtcrtdt = cl_get_current()
      LET g_mmbt_m.mmbtmodid = g_user
      LET g_mmbt_m.mmbtmoddt = cl_get_current()
      LET g_mmbt_m.mmbtstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmbt_m.mmbt004 = "2"
      LET g_mmbt_m.mmbt002 = "1"
      LET g_mmbt_m.mmbt019 = "0"
      LET g_mmbt_m.mmbt003 = "1"
      LET g_mmbt_m.mmbt007 = "0"
      LET g_mmbt_m.mmbt008 = "0"
      LET g_mmbt_m.mmbtstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_mmbt_m.mmbt004 = '3'
      LET g_mmbt_m.mmbt002 = 0
      LET g_mmbt_m.mmbt007 = '0'
      LET g_mmbt_m.mmbt008 = '0'
      LET g_mmbt_m.mmbtstus = 'N'
      LET g_mmbt_m.mmbtunit = g_site
      LET g_mmbt_m.mmbt017 = 'N'
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mmbt_m_t.* = g_mmbt_m.*
      LET g_mmbt_m_o.* = g_mmbt_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbt_m.mmbtstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL ammm356_input("a")
      
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
         INITIALIZE g_mmbt_m.* TO NULL
         INITIALIZE g_mmcg_d TO NULL
         INITIALIZE g_mmcg2_d TO NULL
         INITIALIZE g_mmcg3_d TO NULL
         INITIALIZE g_mmcg4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL ammm356_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mmcg_d.clear()
      #CALL g_mmcg2_d.clear()
      #CALL g_mmcg3_d.clear()
      #CALL g_mmcg4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammm356_set_act_visible()   
   CALL ammm356_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmbt001_t = g_mmbt_m.mmbt001
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmbtent = " ||g_enterprise|| " AND",
                      " mmbt001 = '", g_mmbt_m.mmbt001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammm356_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE ammm356_cl
   
   CALL ammm356_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammm356_master_referesh USING g_mmbt_m.mmbt001 INTO g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001, 
       g_mmbt_m.mmbt002,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
       g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus, 
       g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdt, 
       g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmbtunit_desc, 
       g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid_desc, 
       g_mmbt_m.mmbtcrtdp_desc,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtcnfid_desc
   
   
   #遮罩相關處理
   LET g_mmbt_m_mask_o.* =  g_mmbt_m.*
   CALL ammm356_mmbt_t_mask()
   LET g_mmbt_m_mask_n.* =  g_mmbt_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbtunit_desc,g_mmbt_m.mmbt001,g_mmbt_m.mmbt002, 
       g_mmbt_m.mmbtl003,g_mmbt_m.mmbtl004,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbt006, 
       g_mmbt_m.mmbt003,g_mmbt_m.mmbt007,g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016, 
       g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus,g_mmbt_m.mmbtownid,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp, 
       g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtid_desc,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdp_desc, 
       g_mmbt_m.mmbtcrtdt,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid, 
       g_mmbt_m.mmbtcnfid_desc,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmch004_1,g_mmbt_m.mmch011_1,g_mmbt_m.mmch013_1, 
       g_mmbt_m.mmch015_1,g_mmbt_m.mmch004_desc_1,g_mmbt_m.mmch012_1,g_mmbt_m.mmch014_1,g_mmbt_m.mmch016_1 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mmbt_m.mmbtownid      
   LET g_data_dept  = g_mmbt_m.mmbtowndp
   
   #功能已完成,通報訊息中心
   CALL ammm356_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammm356_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
   DEFINE l_wc2_table4   STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmbt_m_t.* = g_mmbt_m.*
   LET g_mmbt_m_o.* = g_mmbt_m.*
   
   IF g_mmbt_m.mmbt001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mmbt001_t = g_mmbt_m.mmbt001
 
   CALL s_transaction_begin()
   
   OPEN ammm356_cl USING g_enterprise,g_mmbt_m.mmbt001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammm356_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammm356_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammm356_master_referesh USING g_mmbt_m.mmbt001 INTO g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001, 
       g_mmbt_m.mmbt002,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
       g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus, 
       g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdt, 
       g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmbtunit_desc, 
       g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid_desc, 
       g_mmbt_m.mmbtcrtdp_desc,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtcnfid_desc
   
   #檢查是否允許此動作
   IF NOT ammm356_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmbt_m_mask_o.* =  g_mmbt_m.*
   CALL ammm356_mmbt_t_mask()
   LET g_mmbt_m_mask_n.* =  g_mmbt_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
 
   
   CALL ammm356_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
    
   WHILE TRUE
      LET g_mmbt001_t = g_mmbt_m.mmbt001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mmbt_m.mmbtmodid = g_user 
LET g_mmbt_m.mmbtmoddt = cl_get_current()
LET g_mmbt_m.mmbtmodid_desc = cl_get_username(g_mmbt_m.mmbtmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL ammm356_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mmbt_t SET (mmbtmodid,mmbtmoddt) = (g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt)
          WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbt001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mmbt_m.* = g_mmbt_m_t.*
            CALL ammm356_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mmbt_m.mmbt001 != g_mmbt_m_t.mmbt001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mmcg_t SET mmcg001 = g_mmbt_m.mmbt001
 
          WHERE mmcgent = g_enterprise AND mmcg001 = g_mmbt_m_t.mmbt001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmcg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmcg_t:",SQLERRMESSAGE 
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
         
         UPDATE mmbx_t
            SET mmbx001 = g_mmbt_m.mmbt001
 
          WHERE mmbxent = g_enterprise AND
                mmbx001 = g_mmbt001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmbx_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmbx_t:",SQLERRMESSAGE 
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
         
         UPDATE mmch_t
            SET mmch001 = g_mmbt_m.mmbt001
 
          WHERE mmchent = g_enterprise AND
                mmch001 = g_mmbt001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmch_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmch_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
         
         #end add-point
         UPDATE mmdk_t
            SET mmdk001 = g_mmbt_m.mmbt001
 
          WHERE mmdkent = g_enterprise AND
                mmdk001 = g_mmbt001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmdk_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammm356_set_act_visible()   
   CALL ammm356_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmbtent = " ||g_enterprise|| " AND",
                      " mmbt001 = '", g_mmbt_m.mmbt001, "' "
 
   #填到對應位置
   CALL ammm356_browser_fill("")
 
   CLOSE ammm356_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammm356_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="ammm356.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammm356_input(p_cmd)
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
   DISPLAY BY NAME g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbtunit_desc,g_mmbt_m.mmbt001,g_mmbt_m.mmbt002, 
       g_mmbt_m.mmbtl003,g_mmbt_m.mmbtl004,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbt006, 
       g_mmbt_m.mmbt003,g_mmbt_m.mmbt007,g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016, 
       g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus,g_mmbt_m.mmbtownid,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp, 
       g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtid_desc,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdp_desc, 
       g_mmbt_m.mmbtcrtdt,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid, 
       g_mmbt_m.mmbtcnfid_desc,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmch004_1,g_mmbt_m.mmch011_1,g_mmbt_m.mmch013_1, 
       g_mmbt_m.mmch015_1,g_mmbt_m.mmch004_desc_1,g_mmbt_m.mmch012_1,g_mmbt_m.mmch014_1,g_mmbt_m.mmch016_1 
 
   
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
   LET g_forupd_sql = "SELECT mmcg003,mmcg004,mmcg005,mmcgstus FROM mmcg_t WHERE mmcgent=? AND mmcg001=?  
       AND mmcg003=? AND mmcg004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammm356_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmbx004,mmbx005,mmbxstus FROM mmbx_t WHERE mmbxent=? AND mmbx001=? AND  
       mmbx004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammm356_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmch003,mmch004,mmch005,mmch006,mmch007,mmch008,mmch009,mmch010,mmch011, 
       mmch012,mmch013,mmch014,mmch015,mmch016,mmchstus FROM mmch_t WHERE mmchent=? AND mmch001=? AND  
       mmch003=? AND mmch004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammm356_bcl3 CURSOR FROM g_forupd_sql
 
 
   
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mmdk005,mmdk006,mmdk007,mmdk008,mmdk009,mmdk010,mmdk011,mmdkacti FROM  
       mmdk_t WHERE mmdkent=? AND mmdk001=? AND mmdk003=? AND mmdk004=? AND mmdk005=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammm356_bcl4 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL ammm356_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL ammm356_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001,g_mmbt_m.mmbt002,g_mmbt_m.mmbtl003, 
       g_mmbt_m.mmbtl004,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
       g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
  
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="ammm356.input.head" >}
      #單頭段
      INPUT BY NAME g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001,g_mmbt_m.mmbt002,g_mmbt_m.mmbtl003, 
          g_mmbt_m.mmbtl004,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
          g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN ammm356_cl USING g_enterprise,g_mmbt_m.mmbt001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammm356_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammm356_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.mmbtl001 = g_mmbt_m.mmbt001
LET g_master_multi_table_t.mmbtl003 = g_mmbt_m.mmbtl003
LET g_master_multi_table_t.mmbtl004 = g_mmbt_m.mmbtl004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.mmbtl001 = ''
LET g_master_multi_table_t.mmbtl003 = ''
LET g_master_multi_table_t.mmbtl004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL ammm356_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL ammm356_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt004
            #add-point:BEFORE FIELD mmbt004 name="input.b.mmbt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt004
            
            #add-point:AFTER FIELD mmbt004 name="input.a.mmbt004"
           

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt004
            #add-point:ON CHANGE mmbt004 name="input.g.mmbt004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtunit
            
            #add-point:AFTER FIELD mmbtunit name="input.a.mmbtunit"
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtunit
            #add-point:BEFORE FIELD mmbtunit name="input.b.mmbtunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbtunit
            #add-point:ON CHANGE mmbtunit name="input.g.mmbtunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt001
            #add-point:BEFORE FIELD mmbt001 name="input.b.mmbt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt001
            
            #add-point:AFTER FIELD mmbt001 name="input.a.mmbt001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbt_m.mmbt001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmbt_m.mmbt001 != g_mmbt001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbt_t WHERE "||"mmbtent = '" ||g_enterprise|| "' AND "||"mmbt001 = '"||g_mmbt_m.mmbt001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt001
            #add-point:ON CHANGE mmbt001 name="input.g.mmbt001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt002
            #add-point:BEFORE FIELD mmbt002 name="input.b.mmbt002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt002
            
            #add-point:AFTER FIELD mmbt002 name="input.a.mmbt002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt002
            #add-point:ON CHANGE mmbt002 name="input.g.mmbt002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtl003
            #add-point:BEFORE FIELD mmbtl003 name="input.b.mmbtl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtl003
            
            #add-point:AFTER FIELD mmbtl003 name="input.a.mmbtl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbtl003
            #add-point:ON CHANGE mmbtl003 name="input.g.mmbtl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtl004
            #add-point:BEFORE FIELD mmbtl004 name="input.b.mmbtl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtl004
            
            #add-point:AFTER FIELD mmbtl004 name="input.a.mmbtl004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbtl004
            #add-point:ON CHANGE mmbtl004 name="input.g.mmbtl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt019
            #add-point:BEFORE FIELD mmbt019 name="input.b.mmbt019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt019
            
            #add-point:AFTER FIELD mmbt019 name="input.a.mmbt019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt019
            #add-point:ON CHANGE mmbt019 name="input.g.mmbt019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt005
            
            #add-point:AFTER FIELD mmbt005 name="input.a.mmbt005"
            IF NOT cl_null(g_mmbt_m.mmbt005) THEN
              IF NOT ammm356_mmbt005_chk(g_enterprise,g_mmbt_m.mmbt005) THEN
                 LET g_mmbt_m.mmbt005 = g_mmbt_m_t.mmbt005
                 NEXT FIELD mmbt005
              END IF
            END IF
            CALL ammm356_mmbt005_ref()   #160729-00077#7 20160817 add by beckxie
            #160729-00077#7 20160817 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_mmbt_m.mmbt005
            #CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_mmbt_m.mmbt005_desc
            #160729-00077#7 20160817 mark by beckxie---S
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt005
            #add-point:BEFORE FIELD mmbt005 name="input.b.mmbt005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt005
            #add-point:ON CHANGE mmbt005 name="input.g.mmbt005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt006
            #add-point:BEFORE FIELD mmbt006 name="input.b.mmbt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt006
            
            #add-point:AFTER FIELD mmbt006 name="input.a.mmbt006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt006
            #add-point:ON CHANGE mmbt006 name="input.g.mmbt006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt003
            #add-point:BEFORE FIELD mmbt003 name="input.b.mmbt003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt003
            
            #add-point:AFTER FIELD mmbt003 name="input.a.mmbt003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt003
            #add-point:ON CHANGE mmbt003 name="input.g.mmbt003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt007
            #add-point:BEFORE FIELD mmbt007 name="input.b.mmbt007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt007
            
            #add-point:AFTER FIELD mmbt007 name="input.a.mmbt007"
     
           

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt007
            #add-point:ON CHANGE mmbt007 name="input.g.mmbt007"
            IF NOT cl_null(g_mmbt_m.mmbt007) THEN
               IF p_cmd = 'u' AND g_mmbt_m.mmbt007 <> g_mmbt_m_t.mmbt007 THEN
                  IF g_rec_b > 0 THEN 
                     IF cl_ask_confirm('amm-00064') THEN
                        CALL g_mmcg_d.clear()
                        LET g_rec_b = 0
                        DELETE FROM mmcg_t WHERE mmcgent = g_enterprise AND mmcg001 = g_mmbt_m.mmbt001
                     ELSE
                        LET g_mmbt_m.mmbt007 = g_mmbt_m_t.mmbt007
                     END IF
                  END IF
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt008
            #add-point:BEFORE FIELD mmbt008 name="input.b.mmbt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt008
            
            #add-point:AFTER FIELD mmbt008 name="input.a.mmbt008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt008
            #add-point:ON CHANGE mmbt008 name="input.g.mmbt008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt014
            #add-point:BEFORE FIELD mmbt014 name="input.b.mmbt014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt014
            
            #add-point:AFTER FIELD mmbt014 name="input.a.mmbt014"
            IF NOT cl_null(g_mmbt_m.mmbt014) THEN
               IF g_mmbt_m.mmbt015 <  g_mmbt_m.mmbt014 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00020'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmbt014
               END IF
               SELECT COUNT(*) INTO l_n FROM mmch_t
                WHERE mmch011 >g_mmbt_m.mmbt014 AND mmchent = g_enterprise 
                  AND mmch001 = g_mmbt_m.mmbt001
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00065'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmbt014
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt014
            #add-point:ON CHANGE mmbt014 name="input.g.mmbt014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt015
            #add-point:BEFORE FIELD mmbt015 name="input.b.mmbt015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt015
            
            #add-point:AFTER FIELD mmbt015 name="input.a.mmbt015"
            IF NOT cl_null(g_mmbt_m.mmbt015) THEN
               IF g_mmbt_m.mmbt015 <  g_mmbt_m.mmbt014 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00020'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmbt015
               END IF
               SELECT COUNT(*) INTO l_n FROM mmch_t
                WHERE mmch012 <g_mmbt_m.mmbt015 AND mmchent = g_enterprise 
                  AND mmch001 = g_mmbt_m.mmbt001
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00066'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmbt015
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt015
            #add-point:ON CHANGE mmbt015 name="input.g.mmbt015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt016
            #add-point:BEFORE FIELD mmbt016 name="input.b.mmbt016"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt016
            
            #add-point:AFTER FIELD mmbt016 name="input.a.mmbt016"
            IF NOT cl_null(g_mmbt_m.mmbt015) THEN
               IF g_mmbt_m.mmbt016 <  g_mmbt_m.mmbt015 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00020'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmbt016
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt016
            #add-point:ON CHANGE mmbt016 name="input.g.mmbt016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbt017
            #add-point:BEFORE FIELD mmbt017 name="input.b.mmbt017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbt017
            
            #add-point:AFTER FIELD mmbt017 name="input.a.mmbt017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbt017
            #add-point:ON CHANGE mmbt017 name="input.g.mmbt017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbtstus
            #add-point:BEFORE FIELD mmbtstus name="input.b.mmbtstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbtstus
            
            #add-point:AFTER FIELD mmbtstus name="input.a.mmbtstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbtstus
            #add-point:ON CHANGE mmbtstus name="input.g.mmbtstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmbt004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt004
            #add-point:ON ACTION controlp INFIELD mmbt004 name="input.c.mmbt004"
#此段落由子樣板a07產生            
          


            #END add-point
 
 
         #Ctrlp:input.c.mmbtunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtunit
            #add-point:ON ACTION controlp INFIELD mmbtunit name="input.c.mmbtunit"
 
            #END add-point
 
 
         #Ctrlp:input.c.mmbt001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt001
            #add-point:ON ACTION controlp INFIELD mmbt001 name="input.c.mmbt001"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt002
            #add-point:ON ACTION controlp INFIELD mmbt002 name="input.c.mmbt002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbtl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtl003
            #add-point:ON ACTION controlp INFIELD mmbtl003 name="input.c.mmbtl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbtl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtl004
            #add-point:ON ACTION controlp INFIELD mmbtl004 name="input.c.mmbtl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt019
            #add-point:ON ACTION controlp INFIELD mmbt019 name="input.c.mmbt019"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt005
            #add-point:ON ACTION controlp INFIELD mmbt005 name="input.c.mmbt005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbt_m.mmbt005             #給予default值

            #給予arg

            CALL q_mman001()                                #呼叫開窗

            LET g_mmbt_m.mmbt005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbt_m.mmbt005 TO mmbt005              #顯示到畫面上

            NEXT FIELD mmbt005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt006
            #add-point:ON ACTION controlp INFIELD mmbt006 name="input.c.mmbt006"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt003
            #add-point:ON ACTION controlp INFIELD mmbt003 name="input.c.mmbt003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt007
            #add-point:ON ACTION controlp INFIELD mmbt007 name="input.c.mmbt007"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbt_m.mmbt007             #給予default值

            #給予arg

            CALL q_mman001()                                #呼叫開窗

            LET g_mmbt_m.mmbt007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbt_m.mmbt007 TO mmbt007              #顯示到畫面上

            NEXT FIELD mmbt007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt008
            #add-point:ON ACTION controlp INFIELD mmbt008 name="input.c.mmbt008"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt014
            #add-point:ON ACTION controlp INFIELD mmbt014 name="input.c.mmbt014"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt015
            #add-point:ON ACTION controlp INFIELD mmbt015 name="input.c.mmbt015"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt016
            #add-point:ON ACTION controlp INFIELD mmbt016 name="input.c.mmbt016"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbt017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbt017
            #add-point:ON ACTION controlp INFIELD mmbt017 name="input.c.mmbt017"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbtstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbtstus
            #add-point:ON ACTION controlp INFIELD mmbtstus name="input.c.mmbtstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mmbt_m.mmbt001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO mmbt_t (mmbtent,mmbt004,mmbtunit,mmbt001,mmbt002,mmbt019,mmbt005,mmbt006, 
                   mmbt003,mmbt007,mmbt008,mmbt014,mmbt015,mmbt016,mmbt017,mmbtstus,mmbtownid,mmbtowndp, 
                   mmbtcrtid,mmbtcrtdp,mmbtcrtdt,mmbtmodid,mmbtmoddt,mmbtcnfid,mmbtcnfdt)
               VALUES (g_enterprise,g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001,g_mmbt_m.mmbt002, 
                   g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
                   g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017, 
                   g_mmbt_m.mmbtstus,g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp, 
                   g_mmbt_m.mmbtcrtdt,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mmbt_m:",SQLERRMESSAGE 
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
         IF g_mmbt_m.mmbt001 = g_master_multi_table_t.mmbtl001 AND
         g_mmbt_m.mmbtl003 = g_master_multi_table_t.mmbtl003 AND 
         g_mmbt_m.mmbtl004 = g_master_multi_table_t.mmbtl004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mmbtlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mmbt_m.mmbt001
            LET l_field_keys[02] = 'mmbtl001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmbtl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmbtl002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmbt_m.mmbtl003
            LET l_fields[01] = 'mmbtl003'
            LET l_vars[02] = g_mmbt_m.mmbtl004
            LET l_fields[02] = 'mmbtl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmbtl_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL ammm356_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL ammm356_b_fill()
                  CALL ammm356_b_fill2('0')
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
               CALL ammm356_mmbt_t_mask_restore('restore_mask_o')
               
               UPDATE mmbt_t SET (mmbt004,mmbtunit,mmbt001,mmbt002,mmbt019,mmbt005,mmbt006,mmbt003,mmbt007, 
                   mmbt008,mmbt014,mmbt015,mmbt016,mmbt017,mmbtstus,mmbtownid,mmbtowndp,mmbtcrtid,mmbtcrtdp, 
                   mmbtcrtdt,mmbtmodid,mmbtmoddt,mmbtcnfid,mmbtcnfdt) = (g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit, 
                   g_mmbt_m.mmbt001,g_mmbt_m.mmbt002,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006, 
                   g_mmbt_m.mmbt003,g_mmbt_m.mmbt007,g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015, 
                   g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus,g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp, 
                   g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdt,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt, 
                   g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt)
                WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbt001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmbt_t:",SQLERRMESSAGE 
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
         IF g_mmbt_m.mmbt001 = g_master_multi_table_t.mmbtl001 AND
         g_mmbt_m.mmbtl003 = g_master_multi_table_t.mmbtl003 AND 
         g_mmbt_m.mmbtl004 = g_master_multi_table_t.mmbtl004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mmbtlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mmbt_m.mmbt001
            LET l_field_keys[02] = 'mmbtl001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmbtl001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmbtl002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmbt_m.mmbtl003
            LET l_fields[01] = 'mmbtl003'
            LET l_vars[02] = g_mmbt_m.mmbtl004
            LET l_fields[02] = 'mmbtl004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmbtl_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL ammm356_mmbt_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mmbt_m_t)
               LET g_log2 = util.JSON.stringify(g_mmbt_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mmbt001_t = g_mmbt_m.mmbt001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="ammm356.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmcg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmcg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammm356_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mmcg_d.getLength()
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
            OPEN ammm356_cl USING g_enterprise,g_mmbt_m.mmbt001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammm356_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammm356_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmcg_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmcg_d[l_ac].mmcg003 IS NOT NULL
               AND g_mmcg_d[l_ac].mmcg004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmcg_d_t.* = g_mmcg_d[l_ac].*  #BACKUP
               LET g_mmcg_d_o.* = g_mmcg_d[l_ac].*  #BACKUP
               CALL ammm356_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL ammm356_set_no_entry_b(l_cmd)
               IF NOT ammm356_lock_b("mmcg_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammm356_bcl INTO g_mmcg_d[l_ac].mmcg003,g_mmcg_d[l_ac].mmcg004,g_mmcg_d[l_ac].mmcg005, 
                      g_mmcg_d[l_ac].mmcgstus
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmcg_d_t.mmcg003,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmcg_d_mask_o[l_ac].* =  g_mmcg_d[l_ac].*
                  CALL ammm356_mmcg_t_mask()
                  LET g_mmcg_d_mask_n[l_ac].* =  g_mmcg_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammm356_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL ammm356_set_entry_b(l_cmd)
             CALL ammm356_set_no_required_b(l_cmd)
             CALL ammm356_set_required_b(l_cmd)
             CALL ammm356_set_no_entry_b(l_cmd)
             LET g_mmcg_d_t.* = g_mmcg_d[l_ac].*
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
            INITIALIZE g_mmcg_d[l_ac].* TO NULL 
            INITIALIZE g_mmcg_d_t.* TO NULL 
            INITIALIZE g_mmcg_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmcg_d[l_ac].mmcgstus = 'N'
 
 
 
            #自定義預設值
                  LET g_mmcg_d[l_ac].mmcg005 = "100"
      LET g_mmcg_d[l_ac].mmcgstus = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_mmcg_d_t.* = g_mmcg_d[l_ac].*     #新輸入資料
            LET g_mmcg_d_o.* = g_mmcg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammm356_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL ammm356_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmcg_d[li_reproduce_target].* = g_mmcg_d[li_reproduce].*
 
               LET g_mmcg_d[li_reproduce_target].mmcg003 = NULL
               LET g_mmcg_d[li_reproduce_target].mmcg004 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET  g_mmcg_d[l_ac].mmcg003 = g_mmbt_m.mmbt008
            LET  g_mmcg_d[l_ac].mmcgstus = 'Y'
            LET g_mmcg_d_t.* = g_mmcg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammm356_set_entry_b(l_cmd)
            CALL ammm356_set_no_required_b(l_cmd)
            CALL ammm356_set_required_b(l_cmd)
            CALL ammm356_set_no_entry_b(l_cmd)
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
            SELECT COUNT(1) INTO l_count FROM mmcg_t 
             WHERE mmcgent = g_enterprise AND mmcg001 = g_mmbt_m.mmbt001
 
               AND mmcg003 = g_mmcg_d[l_ac].mmcg003
               AND mmcg004 = g_mmcg_d[l_ac].mmcg004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys[2] = g_mmcg_d[g_detail_idx].mmcg003
               LET gs_keys[3] = g_mmcg_d[g_detail_idx].mmcg004
               CALL ammm356_insert_b('mmcg_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mmcg_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmcg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammm356_b_fill()
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
               LET gs_keys[01] = g_mmbt_m.mmbt001
 
               LET gs_keys[gs_keys.getLength()+1] = g_mmcg_d_t.mmcg003
               LET gs_keys[gs_keys.getLength()+1] = g_mmcg_d_t.mmcg004
 
            
               #刪除同層單身
               IF NOT ammm356_delete_b('mmcg_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammm356_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammm356_key_delete_b(gs_keys,'mmcg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammm356_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE ammm356_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mmcg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmcg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcg003
            #add-point:BEFORE FIELD mmcg003 name="input.b.page1.mmcg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcg003
            
            #add-point:AFTER FIELD mmcg003 name="input.a.page1.mmcg003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbt_m.mmbt001) AND NOT cl_null(g_mmcg_d[l_ac].mmcg003) AND NOT cl_null(g_mmcg_d[l_ac].mmcg004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbt_m.mmbt001 != g_mmbt001_t OR g_mmcg_d[l_ac].mmcg003 != g_mmcg_d_t.mmcg003 OR g_mmcg_d[l_ac].mmcg004 != g_mmcg_d_t.mmcg004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmcg_t WHERE "||"mmcgent = '" ||g_enterprise|| "' AND "||"mmcg001 = '"||g_mmbt_m.mmbt001 ||"' AND "|| "mmcg003 = '"||g_mmcg_d[l_ac].mmcg003 ||"' AND "|| "mmcg004 = '"||g_mmcg_d[l_ac].mmcg004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcg003
            #add-point:ON CHANGE mmcg003 name="input.g.page1.mmcg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcg004
            
            #add-point:AFTER FIELD mmcg004 name="input.a.page1.mmcg004"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbt_m.mmbt001) AND NOT cl_null(g_mmcg_d[l_ac].mmcg003) AND NOT cl_null(g_mmcg_d[l_ac].mmcg004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbt_m.mmbt001 != g_mmbt001_t OR g_mmcg_d[l_ac].mmcg003 != g_mmcg_d_t.mmcg003 OR g_mmcg_d[l_ac].mmcg004 != g_mmcg_d_t.mmcg004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmcg_t WHERE "||"mmcgent = '" ||g_enterprise|| "' AND "||"mmcg001 = '"||g_mmbt_m.mmbt001 ||"' AND "|| "mmcg003 = '"||g_mmcg_d[l_ac].mmcg003 ||"' AND "|| "mmcg004 = '"||g_mmcg_d[l_ac].mmcg004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD mmcg004
                  END IF
               END IF
              
               LET g_mmcg_d[l_ac].mmcg004_desc = ''
               IF NOT ammm356_mmcg004_chk(g_mmcg_d[l_ac].mmcg004) THEN
                  LET g_mmcg_d[l_ac].mmcg004 = g_mmcg_d_t.mmcg004
                  LET g_mmcg_d[l_ac].mmcg004_desc= ammm356_mmcg004_ref(g_mmbt_m.mmbt007,g_mmcg_d[l_ac].mmcg004)
                  NEXT FIELD mmcg004
               END IF
               LET g_mmcg_d[l_ac].mmcg004_desc= ammm356_mmcg004_ref(g_mmbt_m.mmbt007,g_mmcg_d[l_ac].mmcg004)              
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcg004
            #add-point:BEFORE FIELD mmcg004 name="input.b.page1.mmcg004"
           
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcg004
            #add-point:ON CHANGE mmcg004 name="input.g.page1.mmcg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcg005
            #add-point:BEFORE FIELD mmcg005 name="input.b.page1.mmcg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcg005
            
            #add-point:AFTER FIELD mmcg005 name="input.a.page1.mmcg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcg005
            #add-point:ON CHANGE mmcg005 name="input.g.page1.mmcg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcgstus
            #add-point:BEFORE FIELD mmcgstus name="input.b.page1.mmcgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcgstus
            
            #add-point:AFTER FIELD mmcgstus name="input.a.page1.mmcgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcgstus
            #add-point:ON CHANGE mmcgstus name="input.g.page1.mmcgstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmcg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcg003
            #add-point:ON ACTION controlp INFIELD mmcg003 name="input.c.page1.mmcg003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcg004
            #add-point:ON ACTION controlp INFIELD mmcg004 name="input.c.page1.mmcg004"
            LET g_qryparam.reqry = FALSE
            CASE g_mmbt_m.mmbt007
                WHEN '1'
                   LET g_qryparam.arg1 = '2024'
                   CALL q_oocq002()
                WHEN '2'
                   LET g_qryparam.arg1 = '2025'
                   CALL q_oocq002()  
                WHEN '3'
                   #CALL q_ooia()
                WHEN '4'
                   #CALL q_imaa()
                WHEN '5'
                   CALL q_rtax001()
                WHEN '6'
                   LET g_qryparam.arg1 = '2000'
                   CALL q_oocq002() 
                WHEN '7'
                   LET g_qryparam.arg1 = '2001'
                   CALL q_oocq002() 
                WHEN '8'
                   LET g_qryparam.arg1 = '2002'
                   CALL q_oocq002() 
                WHEN '9'
                   LET g_qryparam.arg1 = '2003'
                   CALL q_oocq002() 
                WHEN 'A'
                   LET g_qryparam.arg1 = '2004'
                   CALL q_oocq002() 
                WHEN 'B'
                   LET g_qryparam.arg1 = '2005'
                   CALL q_oocq002() 
                WHEN 'C'
                   LET g_qryparam.arg1 = '2006'
                   CALL q_oocq002() 
                WHEN 'D'
                   LET g_qryparam.arg1 = '2007'
                   CALL q_oocq002() 
                WHEN 'E'
                   LET g_qryparam.arg1 = '2008'
                   CALL q_oocq002() 
                WHEN 'F'
                   LET g_qryparam.arg1 = '2009'
                   CALL q_oocq002() 
                WHEN 'G'
                   LET g_qryparam.arg1 = '2010'
                   CALL q_oocq002() 
                WHEN 'H'
                   LET g_qryparam.arg1 = '2011'
                    CALL q_oocq002() 
                WHEN 'I'
                   LET g_qryparam.arg1 = '2012'
                   CALL q_oocq002() 
                WHEN 'J'
                   LET g_qryparam.arg1 = '2013'
                   CALL q_oocq002() 
                WHEN 'K'
                   LET g_qryparam.arg1 = '2014'
                   CALL q_oocq002() 
                WHEN 'L'
                   LET g_qryparam.arg1 = '2015'
                   CALL q_oocq002() 
                WHEN 'U'
                   
                WHEN 'V'
                  
            END CASE
            LET g_mmcg_d[l_ac].mmcg004 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO  mmcg004     #顯示到畫面上
            NEXT FIELD mmcg004                     #返回原欄位




            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcg005
            #add-point:ON ACTION controlp INFIELD mmcg005 name="input.c.page1.mmcg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmcgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcgstus
            #add-point:ON ACTION controlp INFIELD mmcgstus name="input.c.page1.mmcgstus"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmcg_d[l_ac].* = g_mmcg_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammm356_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmcg_d[l_ac].mmcg003 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmcg_d[l_ac].* = g_mmcg_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
      
               #將遮罩欄位還原
               CALL ammm356_mmcg_t_mask_restore('restore_mask_o')
      
               UPDATE mmcg_t SET (mmcg001,mmcg003,mmcg004,mmcg005,mmcgstus) = (g_mmbt_m.mmbt001,g_mmcg_d[l_ac].mmcg003, 
                   g_mmcg_d[l_ac].mmcg004,g_mmcg_d[l_ac].mmcg005,g_mmcg_d[l_ac].mmcgstus)
                WHERE mmcgent = g_enterprise AND mmcg001 = g_mmbt_m.mmbt001 
 
                  AND mmcg003 = g_mmcg_d_t.mmcg003 #項次   
                  AND mmcg004 = g_mmcg_d_t.mmcg004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmcg_d[l_ac].* = g_mmcg_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmcg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmcg_d[l_ac].* = g_mmcg_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmcg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys_bak[1] = g_mmbt001_t
               LET gs_keys[2] = g_mmcg_d[g_detail_idx].mmcg003
               LET gs_keys_bak[2] = g_mmcg_d_t.mmcg003
               LET gs_keys[3] = g_mmcg_d[g_detail_idx].mmcg004
               LET gs_keys_bak[3] = g_mmcg_d_t.mmcg004
               CALL ammm356_update_b('mmcg_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL ammm356_mmcg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mmcg_d[g_detail_idx].mmcg003 = g_mmcg_d_t.mmcg003 
                  AND g_mmcg_d[g_detail_idx].mmcg004 = g_mmcg_d_t.mmcg004 
 
                  ) THEN
                  LET gs_keys[01] = g_mmbt_m.mmbt001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcg_d_t.mmcg003
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcg_d_t.mmcg004
 
                  CALL ammm356_key_update_b(gs_keys,'mmcg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbt_m),util.JSON.stringify(g_mmcg_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbt_m),util.JSON.stringify(g_mmcg_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL ammm356_unlock_b("mmcg_t","'1'")
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
               LET g_mmcg_d[li_reproduce_target].* = g_mmcg_d[li_reproduce].*
 
               LET g_mmcg_d[li_reproduce_target].mmcg003 = NULL
               LET g_mmcg_d[li_reproduce_target].mmcg004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmcg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmcg_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_mmcg2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmcg2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammm356_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmcg2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmcg2_d[l_ac].* TO NULL 
            INITIALIZE g_mmcg2_d_t.* TO NULL 
            INITIALIZE g_mmcg2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmcg2_d[l_ac].mmbxstus = 'N'
 
 
 
            #自定義預設值(單身2)
                  LET g_mmcg2_d[l_ac].mmbx005 = "N"
      LET g_mmcg2_d[l_ac].mmbxstus = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_mmcg2_d_t.* = g_mmcg2_d[l_ac].*     #新輸入資料
            LET g_mmcg2_d_o.* = g_mmcg2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammm356_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL ammm356_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmcg2_d[li_reproduce_target].* = g_mmcg2_d[li_reproduce].*
 
               LET g_mmcg2_d[li_reproduce_target].mmbx004 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
      
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
            OPEN ammm356_cl USING g_enterprise,g_mmbt_m.mmbt001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammm356_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammm356_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmcg2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmcg2_d[l_ac].mmbx004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmcg2_d_t.* = g_mmcg2_d[l_ac].*  #BACKUP
               LET g_mmcg2_d_o.* = g_mmcg2_d[l_ac].*  #BACKUP
               CALL ammm356_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL ammm356_set_no_entry_b(l_cmd)
               IF NOT ammm356_lock_b("mmbx_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammm356_bcl2 INTO g_mmcg2_d[l_ac].mmbx004,g_mmcg2_d[l_ac].mmbx005,g_mmcg2_d[l_ac].mmbxstus 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmcg2_d_mask_o[l_ac].* =  g_mmcg2_d[l_ac].*
                  CALL ammm356_mmbx_t_mask()
                  LET g_mmcg2_d_mask_n[l_ac].* =  g_mmcg2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammm356_show()
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
               LET gs_keys[01] = g_mmbt_m.mmbt001
               LET gs_keys[gs_keys.getLength()+1] = g_mmcg2_d_t.mmbx004
            
               #刪除同層單身
               IF NOT ammm356_delete_b('mmbx_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammm356_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammm356_key_delete_b(gs_keys,'mmbx_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammm356_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammm356_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_mmcg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmcg2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mmbx_t 
             WHERE mmbxent = g_enterprise AND mmbx001 = g_mmbt_m.mmbt001
               AND mmbx004 = g_mmcg2_d[l_ac].mmbx004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys[2] = g_mmcg2_d[g_detail_idx].mmbx004
               CALL ammm356_insert_b('mmbx_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmcg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mmbx_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammm356_b_fill()
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
               LET g_mmcg2_d[l_ac].* = g_mmcg2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammm356_bcl2
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
               LET g_mmcg2_d[l_ac].* = g_mmcg2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               #將遮罩欄位還原
               CALL ammm356_mmbx_t_mask_restore('restore_mask_o')
                              
               UPDATE mmbx_t SET (mmbx001,mmbx004,mmbx005,mmbxstus) = (g_mmbt_m.mmbt001,g_mmcg2_d[l_ac].mmbx004, 
                   g_mmcg2_d[l_ac].mmbx005,g_mmcg2_d[l_ac].mmbxstus) #自訂欄位頁簽
                WHERE mmbxent = g_enterprise AND mmbx001 = g_mmbt_m.mmbt001
                  AND mmbx004 = g_mmcg2_d_t.mmbx004 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmcg2_d[l_ac].* = g_mmcg2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmbx_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmcg2_d[l_ac].* = g_mmcg2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmbx_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys_bak[1] = g_mmbt001_t
               LET gs_keys[2] = g_mmcg2_d[g_detail_idx].mmbx004
               LET gs_keys_bak[2] = g_mmcg2_d_t.mmbx004
               CALL ammm356_update_b('mmbx_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammm356_mmbx_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmcg2_d[g_detail_idx].mmbx004 = g_mmcg2_d_t.mmbx004 
                  ) THEN
                  LET gs_keys[01] = g_mmbt_m.mmbt001
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcg2_d_t.mmbx004
                  CALL ammm356_key_update_b(gs_keys,'mmbx_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbt_m),util.JSON.stringify(g_mmcg2_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbt_m),util.JSON.stringify(g_mmcg2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbx004
            
            #add-point:AFTER FIELD mmbx004 name="input.a.page2.mmbx004"
            IF NOT cl_null(g_mmcg2_d[l_ac].mmbx004) THEN
               IF NOT ammm356_mmbx004_chk(g_enterprise,g_mmcg2_d[l_ac].mmbx004) THEN
                  LET g_mmcg2_d[l_ac].mmbx004 = g_mmcg2_d_t.mmbx004
                  NEXT FIELD mmbx004
               END IF
            END IF
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbt_m.mmbt001) AND NOT cl_null(g_mmcg2_d[l_ac].mmbx004)  THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbt_m.mmbt001 != g_mmbt001_t OR g_mmcg2_d[l_ac].mmbx004 != g_mmcg2_d_t.mmbx004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbx_t WHERE "||"mmbxent = '" ||g_enterprise|| "' AND "||"mmbx001 = '"||g_mmbt_m.mmbt001 ||"' AND "|| "mmbx004 = '"||g_mmcg2_d[l_ac].mmbx004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbx004
            #add-point:BEFORE FIELD mmbx004 name="input.b.page2.mmbx004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbx004
            #add-point:ON CHANGE mmbx004 name="input.g.page2.mmbx004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbx005
            #add-point:BEFORE FIELD mmbx005 name="input.b.page2.mmbx005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbx005
            
            #add-point:AFTER FIELD mmbx005 name="input.a.page2.mmbx005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbx005
            #add-point:ON CHANGE mmbx005 name="input.g.page2.mmbx005"
            IF NOT cl_null(g_mmcg2_d[l_ac].mmbx005) THEN
             
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbxstus
            #add-point:BEFORE FIELD mmbxstus name="input.b.page2.mmbxstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbxstus
            
            #add-point:AFTER FIELD mmbxstus name="input.a.page2.mmbxstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbxstus
            #add-point:ON CHANGE mmbxstus name="input.g.page2.mmbxstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mmbx004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbx004
            #add-point:ON ACTION controlp INFIELD mmbx004 name="input.c.page2.mmbx004"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbx005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbx005
            #add-point:ON ACTION controlp INFIELD mmbx005 name="input.c.page2.mmbx005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbxstus
            #add-point:ON ACTION controlp INFIELD mmbxstus name="input.c.page2.mmbxstus"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmcg2_d[l_ac].* = g_mmcg2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammm356_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammm356_unlock_b("mmbx_t","'2'")
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
               LET g_mmcg2_d[li_reproduce_target].* = g_mmcg2_d[li_reproduce].*
 
               LET g_mmcg2_d[li_reproduce_target].mmbx004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmcg2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmcg2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mmcg3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmcg3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammm356_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmcg3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmcg3_d[l_ac].* TO NULL 
            INITIALIZE g_mmcg3_d_t.* TO NULL 
            INITIALIZE g_mmcg3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmcg3_d[l_ac].mmchstus = 'N'
 
 
 
            #自定義預設值(單身3)
                  LET g_mmcg3_d[l_ac].mmch003 = "Q"
      LET g_mmcg3_d[l_ac].mmch005 = "Y"
      LET g_mmcg3_d[l_ac].mmch007 = "1"
      LET g_mmcg3_d[l_ac].mmch010 = "0"
      LET g_mmcg3_d[l_ac].mmchstus = "Y"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_mmcg3_d_t.* = g_mmcg3_d[l_ac].*     #新輸入資料
            LET g_mmcg3_d_o.* = g_mmcg3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammm356_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL ammm356_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmcg3_d[li_reproduce_target].* = g_mmcg3_d[li_reproduce].*
 
               LET g_mmcg3_d[li_reproduce_target].mmch003 = NULL
               LET g_mmcg3_d[li_reproduce_target].mmch004 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            LET g_mmcg3_d[l_ac].mmch003 = 'Q'
            LET g_mmcg3_d[l_ac].mmch005 = 'Y'
            LET g_mmcg3_d[l_ac].mmchstus = 'Y'
            LET g_mmcg3_d_t.* = g_mmcg3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammm356_set_entry_b(l_cmd)
            CALL ammm356_set_no_required_b(l_cmd)
            CALL ammm356_set_required_b(l_cmd)
            CALL ammm356_set_no_entry_b(l_cmd)
            
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
            CALL ammm356_b_fill2('4')
  
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammm356_cl USING g_enterprise,g_mmbt_m.mmbt001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammm356_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammm356_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmcg3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmcg3_d[l_ac].mmch003 IS NOT NULL
               AND g_mmcg3_d[l_ac].mmch004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmcg3_d_t.* = g_mmcg3_d[l_ac].*  #BACKUP
               LET g_mmcg3_d_o.* = g_mmcg3_d[l_ac].*  #BACKUP
               CALL ammm356_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL ammm356_set_no_entry_b(l_cmd)
               IF NOT ammm356_lock_b("mmch_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammm356_bcl3 INTO g_mmcg3_d[l_ac].mmch003,g_mmcg3_d[l_ac].mmch004,g_mmcg3_d[l_ac].mmch005, 
                      g_mmcg3_d[l_ac].mmch006,g_mmcg3_d[l_ac].mmch007,g_mmcg3_d[l_ac].mmch008,g_mmcg3_d[l_ac].mmch009, 
                      g_mmcg3_d[l_ac].mmch010,g_mmcg3_d[l_ac].mmch011,g_mmcg3_d[l_ac].mmch012,g_mmcg3_d[l_ac].mmch013, 
                      g_mmcg3_d[l_ac].mmch014,g_mmcg3_d[l_ac].mmch015,g_mmcg3_d[l_ac].mmch016,g_mmcg3_d[l_ac].mmchstus 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmcg3_d_mask_o[l_ac].* =  g_mmcg3_d[l_ac].*
                  CALL ammm356_mmch_t_mask()
                  LET g_mmcg3_d_mask_n[l_ac].* =  g_mmcg3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammm356_show()
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
               LET gs_keys[01] = g_mmbt_m.mmbt001
               LET gs_keys[gs_keys.getLength()+1] = g_mmcg3_d_t.mmch003
               LET gs_keys[gs_keys.getLength()+1] = g_mmcg3_d_t.mmch004
            
               #刪除同層單身
               IF NOT ammm356_delete_b('mmch_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammm356_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammm356_key_delete_b(gs_keys,'mmch_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammm356_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE ammm356_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_mmcg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmcg3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mmch_t 
             WHERE mmchent = g_enterprise AND mmch001 = g_mmbt_m.mmbt001
               AND mmch003 = g_mmcg3_d[l_ac].mmch003
               AND mmch004 = g_mmcg3_d[l_ac].mmch004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys[2] = g_mmcg3_d[g_detail_idx].mmch003
               LET gs_keys[3] = g_mmcg3_d[g_detail_idx].mmch004
               CALL ammm356_insert_b('mmch_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmcg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mmch_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammm356_b_fill()
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
               LET g_mmcg3_d[l_ac].* = g_mmcg3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammm356_bcl3
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
               LET g_mmcg3_d[l_ac].* = g_mmcg3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               #將遮罩欄位還原
               CALL ammm356_mmch_t_mask_restore('restore_mask_o')
                              
               UPDATE mmch_t SET (mmch001,mmch003,mmch004,mmch005,mmch006,mmch007,mmch008,mmch009,mmch010, 
                   mmch011,mmch012,mmch013,mmch014,mmch015,mmch016,mmchstus) = (g_mmbt_m.mmbt001,g_mmcg3_d[l_ac].mmch003, 
                   g_mmcg3_d[l_ac].mmch004,g_mmcg3_d[l_ac].mmch005,g_mmcg3_d[l_ac].mmch006,g_mmcg3_d[l_ac].mmch007, 
                   g_mmcg3_d[l_ac].mmch008,g_mmcg3_d[l_ac].mmch009,g_mmcg3_d[l_ac].mmch010,g_mmcg3_d[l_ac].mmch011, 
                   g_mmcg3_d[l_ac].mmch012,g_mmcg3_d[l_ac].mmch013,g_mmcg3_d[l_ac].mmch014,g_mmcg3_d[l_ac].mmch015, 
                   g_mmcg3_d[l_ac].mmch016,g_mmcg3_d[l_ac].mmchstus) #自訂欄位頁簽
                WHERE mmchent = g_enterprise AND mmch001 = g_mmbt_m.mmbt001
                  AND mmch003 = g_mmcg3_d_t.mmch003 #項次 
                  AND mmch004 = g_mmcg3_d_t.mmch004
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmcg3_d[l_ac].* = g_mmcg3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmch_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmcg3_d[l_ac].* = g_mmcg3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmch_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys_bak[1] = g_mmbt001_t
               LET gs_keys[2] = g_mmcg3_d[g_detail_idx].mmch003
               LET gs_keys_bak[2] = g_mmcg3_d_t.mmch003
               LET gs_keys[3] = g_mmcg3_d[g_detail_idx].mmch004
               LET gs_keys_bak[3] = g_mmcg3_d_t.mmch004
               CALL ammm356_update_b('mmch_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammm356_mmch_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmcg3_d[g_detail_idx].mmch003 = g_mmcg3_d_t.mmch003 
                  AND g_mmcg3_d[g_detail_idx].mmch004 = g_mmcg3_d_t.mmch004 
                  ) THEN
                  LET gs_keys[01] = g_mmbt_m.mmbt001
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcg3_d_t.mmch003
                  LET gs_keys[gs_keys.getLength()+1] = g_mmcg3_d_t.mmch004
                  CALL ammm356_key_update_b(gs_keys,'mmch_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbt_m),util.JSON.stringify(g_mmcg3_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbt_m),util.JSON.stringify(g_mmcg3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch003
            #add-point:BEFORE FIELD mmch003 name="input.b.page3.mmch003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch003
            
            #add-point:AFTER FIELD mmch003 name="input.a.page3.mmch003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbt_m.mmbt001) AND NOT cl_null(g_mmcg3_d[l_ac].mmch003) AND NOT cl_null(g_mmcg3_d[l_ac].mmch004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbt_m.mmbt001 != g_mmbt001_t OR g_mmcg3_d[l_ac].mmch003 != g_mmcg3_d_t.mmch003 OR g_mmcg3_d[l_ac].mmch004 != g_mmcg3_d_t.mmch004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmch_t WHERE "||"mmchent = '" ||g_enterprise|| "' AND "||"mmch001 = '"||g_mmbt_m.mmbt001 ||"' AND "|| "mmch003 = '"||g_mmcg3_d[l_ac].mmch003 ||"' AND "|| "mmch004 = '"||g_mmcg3_d[l_ac].mmch004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch003
            #add-point:ON CHANGE mmch003 name="input.g.page3.mmch003"
            IF NOT cl_null(g_mmcg3_d[l_ac].mmch004) THEN
               LET g_mmcg3_d[l_ac].mmch004 = ''
               LET g_mmcg3_d[l_ac].mmch004_desc = ''
            END IF  
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch004
            
            #add-point:AFTER FIELD mmch004 name="input.a.page3.mmch004"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbt_m.mmbt001) AND NOT cl_null(g_mmcg3_d[l_ac].mmch003) AND NOT cl_null(g_mmcg3_d[l_ac].mmch004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbt_m.mmbt001 != g_mmbt001_t OR g_mmcg3_d[l_ac].mmch003 != g_mmcg3_d_t.mmch003 OR g_mmcg3_d[l_ac].mmch004 != g_mmcg3_d_t.mmch004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmch_t WHERE "||"mmchent = '" ||g_enterprise|| "' AND "||"mmch001 = '"||g_mmbt_m.mmbt001 ||"' AND "|| "mmch003 = '"||g_mmcg3_d[l_ac].mmch003 ||"' AND "|| "mmch004 = '"||g_mmcg3_d[l_ac].mmch004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               LET g_mmcg3_d[l_ac].mmch004_desc = ''
               IF NOT ammm356_mmch004_chk(g_mmcg3_d[l_ac].mmch004) THEN
                  LET g_mmcg3_d[l_ac].mmch004 = g_mmcg3_d_t.mmch004
                  LET g_mmcg3_d[l_ac].mmch004_desc = ammm356_mmch004_ref(g_mmcg3_d[l_ac].mmch003,g_mmcg3_d[l_ac].mmch004)
                  NEXT FIELD mmch004
               END IF
               LET g_mmcg3_d[l_ac].mmch004_desc = ammm356_mmch004_ref(g_mmcg3_d[l_ac].mmch003,g_mmcg3_d[l_ac].mmch004) 
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch004
            #add-point:BEFORE FIELD mmch004 name="input.b.page3.mmch004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch004
            #add-point:ON CHANGE mmch004 name="input.g.page3.mmch004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch005
            #add-point:BEFORE FIELD mmch005 name="input.b.page3.mmch005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch005
            
            #add-point:AFTER FIELD mmch005 name="input.a.page3.mmch005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch005
            #add-point:ON CHANGE mmch005 name="input.g.page3.mmch005"
            IF g_mmcg3_d[l_ac].mmch005 = 'N' THEN
               CALL cl_set_comp_entry("mmch006",FALSE)
               LET  g_mmcg3_d[l_ac].mmch006 =''
            ELSE
               CALL cl_set_comp_entry("mmch006",TRUE)
               CALL cl_set_comp_required("mmch006",TRUE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch006
            #add-point:BEFORE FIELD mmch006 name="input.b.page3.mmch006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch006
            
            #add-point:AFTER FIELD mmch006 name="input.a.page3.mmch006"
            IF NOT cl_null(g_mmcg3_d[l_ac].mmch006) THEN
               IF g_mmcg3_d[l_ac].mmch006 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_mmcg3_d[l_ac].mmch006 = g_mmcg3_d_t.mmch006
                  NEXT FIELD mmch006
               END IF
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmch_t WHERE "||"mmchent = '" ||g_enterprise|| "' AND "||"mmch001 = '"||g_mmbt_m.mmbt001 ||"' AND "|| "mmch006 = '"||g_mmcg3_d[l_ac].mmch006 ||"'",'std-00004',0) THEN 
                   NEXT FIELD CURRENT
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch006
            #add-point:ON CHANGE mmch006 name="input.g.page3.mmch006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch007
            #add-point:BEFORE FIELD mmch007 name="input.b.page3.mmch007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch007
            
            #add-point:AFTER FIELD mmch007 name="input.a.page3.mmch007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch007
            #add-point:ON CHANGE mmch007 name="input.g.page3.mmch007"
             IF g_mmcg3_d[l_ac].mmch007 = '3' THEN
                CALL cl_set_comp_entry("mmch008,mmch009",TRUE)
                CALL cl_set_comp_required("mmch008,mmch009",TRUE)
             ELSE
                CALL cl_set_comp_entry("mmch008,mmch009",FALSE)
                LET g_mmcg3_d[l_ac].mmch008 = ''
                LET g_mmcg3_d[l_ac].mmch009 = ''
             END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch008
            #add-point:BEFORE FIELD mmch008 name="input.b.page3.mmch008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch008
            
            #add-point:AFTER FIELD mmch008 name="input.a.page3.mmch008"
            IF NOT cl_null(g_mmcg3_d[l_ac].mmch008) THEN 
               IF g_mmcg3_d[l_ac].mmch008 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00005'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_mmcg3_d[l_ac].mmch008 = g_mmcg3_d_t.mmch008
                  NEXT FIELD mmch008
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch008
            #add-point:ON CHANGE mmch008 name="input.g.page3.mmch008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch009
            #add-point:BEFORE FIELD mmch009 name="input.b.page3.mmch009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch009
            
            #add-point:AFTER FIELD mmch009 name="input.a.page3.mmch009"
             IF NOT cl_null(g_mmcg3_d[l_ac].mmch009) THEN 
               IF g_mmcg3_d[l_ac].mmch009 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00005'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_mmcg3_d[l_ac].mmch009 = g_mmcg3_d_t.mmch009
                  NEXT FIELD mmch009
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch009
            #add-point:ON CHANGE mmch009 name="input.g.page3.mmch009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch010
            #add-point:BEFORE FIELD mmch010 name="input.b.page3.mmch010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch010
            
            #add-point:AFTER FIELD mmch010 name="input.a.page3.mmch010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch010
            #add-point:ON CHANGE mmch010 name="input.g.page3.mmch010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch011
            #add-point:BEFORE FIELD mmch011 name="input.b.page3.mmch011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch011
            
            #add-point:AFTER FIELD mmch011 name="input.a.page3.mmch011"
            IF NOT cl_null(g_mmcg3_d[l_ac].mmch011)  THEN
              IF g_mmcg3_d[l_ac].mmch011 < g_mmbt_m.mmbt014 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'amm-00065'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
 
                 NEXT FIELD mmch011
              END IF
              IF NOT cl_null(g_mmcg3_d[l_ac].mmch012) THEN
                 IF g_mmcg3_d[l_ac].mmch011 > g_mmcg3_d[l_ac].mmch012 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'art-00020'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = FALSE
                    CALL cl_err()

                    NEXT FIELD mmch011
                 END IF
              END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch011
            #add-point:ON CHANGE mmch011 name="input.g.page3.mmch011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch012
            #add-point:BEFORE FIELD mmch012 name="input.b.page3.mmch012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch012
            
            #add-point:AFTER FIELD mmch012 name="input.a.page3.mmch012"
            IF NOT cl_null(g_mmcg3_d[l_ac].mmch012)  THEN
              IF g_mmcg3_d[l_ac].mmch012 > g_mmbt_m.mmbt015 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'amm-00066'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
 
                 NEXT FIELD mmch012
              END IF
              IF NOT cl_null(g_mmcg3_d[l_ac].mmch012) THEN
                 IF g_mmcg3_d[l_ac].mmch011 > g_mmcg3_d[l_ac].mmch012 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'art-00020'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = FALSE
                    CALL cl_err()

                    NEXT FIELD mmch012
                 END IF
              END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch012
            #add-point:ON CHANGE mmch012 name="input.g.page3.mmch012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch013
            #add-point:BEFORE FIELD mmch013 name="input.b.page3.mmch013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch013
            
            #add-point:AFTER FIELD mmch013 name="input.a.page3.mmch013"
            IF NOT cl_null(g_mmcg3_d[l_ac].mmch013) AND NOT cl_null(g_mmcg3_d[l_ac].mmch014) THEN
               IF g_mmcg3_d[l_ac].mmch013 > g_mmcg3_d[l_ac].mmch014 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmch013
               END IF               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch013
            #add-point:ON CHANGE mmch013 name="input.g.page3.mmch013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch014
            #add-point:BEFORE FIELD mmch014 name="input.b.page3.mmch014"
          
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch014
            
            #add-point:AFTER FIELD mmch014 name="input.a.page3.mmch014"
            IF NOT cl_null(g_mmcg3_d[l_ac].mmch013) AND NOT cl_null(g_mmcg3_d[l_ac].mmch014) THEN
               IF g_mmcg3_d[l_ac].mmch013 > g_mmcg3_d[l_ac].mmch014 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmch014
               END IF               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch014
            #add-point:ON CHANGE mmch014 name="input.g.page3.mmch014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch015
            #add-point:BEFORE FIELD mmch015 name="input.b.page3.mmch015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch015
            
            #add-point:AFTER FIELD mmch015 name="input.a.page3.mmch015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch015
            #add-point:ON CHANGE mmch015 name="input.g.page3.mmch015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmch016
            #add-point:BEFORE FIELD mmch016 name="input.b.page3.mmch016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmch016
            
            #add-point:AFTER FIELD mmch016 name="input.a.page3.mmch016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmch016
            #add-point:ON CHANGE mmch016 name="input.g.page3.mmch016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmchstus
            #add-point:BEFORE FIELD mmchstus name="input.b.page3.mmchstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmchstus
            
            #add-point:AFTER FIELD mmchstus name="input.a.page3.mmchstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmchstus
            #add-point:ON CHANGE mmchstus name="input.g.page3.mmchstus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.mmch003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch003
            #add-point:ON ACTION controlp INFIELD mmch003 name="input.c.page3.mmch003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch004
            #add-point:ON ACTION controlp INFIELD mmch004 name="input.c.page3.mmch004"
            LET g_qryparam.reqry = FALSE
            CASE g_mmcg3_d[l_ac].mmch003
                WHEN '1'
                   LET g_qryparam.arg1 = '2024'
                   CALL q_oocq002()
                WHEN '2'
                   LET g_qryparam.arg1 = '2025'
                   CALL q_oocq002()  
                WHEN '3'
                   #CALL q_ooia()
                WHEN '4'
                   #CALL q_imaa()
                WHEN '5'
                   CALL q_rtax001()
                WHEN '6'
                   LET g_qryparam.arg1 = '2000'
                   CALL q_oocq002() 
                WHEN '7'
                   LET g_qryparam.arg1 = '2001'
                   CALL q_oocq002() 
                WHEN '8'
                   LET g_qryparam.arg1 = '2002'
                   CALL q_oocq002() 
                WHEN '9'
                   LET g_qryparam.arg1 = '2003'
                   CALL q_oocq002() 
                WHEN 'A'
                   LET g_qryparam.arg1 = '2004'
                   CALL q_oocq002() 
                WHEN 'B'
                   LET g_qryparam.arg1 = '2005'
                   CALL q_oocq002() 
                WHEN 'C'
                   LET g_qryparam.arg1 = '2006'
                   CALL q_oocq002() 
                WHEN 'D'
                   LET g_qryparam.arg1 = '2007'
                   CALL q_oocq002() 
                WHEN 'E'
                   LET g_qryparam.arg1 = '2008'
                   CALL q_oocq002() 
                WHEN 'F'
                   LET g_qryparam.arg1 = '2009'
                   CALL q_oocq002() 
                WHEN 'G'
                   LET g_qryparam.arg1 = '2010'
                   CALL q_oocq002() 
                WHEN 'H'
                   LET g_qryparam.arg1 = '2011'
                    CALL q_oocq002() 
                WHEN 'I'
                   LET g_qryparam.arg1 = '2012'
                   CALL q_oocq002() 
                WHEN 'J'
                   LET g_qryparam.arg1 = '2013'
                   CALL q_oocq002() 
                WHEN 'K'
                   LET g_qryparam.arg1 = '2014'
                   CALL q_oocq002() 
                WHEN 'L'
                   LET g_qryparam.arg1 = '2015'
                   CALL q_oocq002() 
                WHEN 'Q'
                   LET g_qryparam.arg1 = '2050'
                   CALL q_oocq002() 
                WHEN 'U'
                   LET g_qryparam.arg1 = '6200'
                   CALL q_gzcb001()
                WHEN 'V'
                   CALL q_rtax001()
                WHEN 'R'
                   
                WHEN 'S'
#                   LET g_qryparam.where = " ooef201 = 'Y' "
#                   CALL q_ooef001()
                    IF s_aooi500_setpoint(g_prog,'mmch004') THEN
                       LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmch004',g_site,'i')  #150308-00001#4 150309 by lori522612 add 'i'
                       CALL q_ooef001_24()
                    ELSE
                       LET g_qryparam.where = " ooef201 = 'Y' "
                       CALL q_ooef001() 
                    END IF
                WHEN 'T'
                   CALL q_inaa001_1()
            END CASE
            LET g_mmcg3_d[l_ac].mmch004 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO  mmch004     #顯示到畫面上
            NEXT FIELD mmch004                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch005
            #add-point:ON ACTION controlp INFIELD mmch005 name="input.c.page3.mmch005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch006
            #add-point:ON ACTION controlp INFIELD mmch006 name="input.c.page3.mmch006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch007
            #add-point:ON ACTION controlp INFIELD mmch007 name="input.c.page3.mmch007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch008
            #add-point:ON ACTION controlp INFIELD mmch008 name="input.c.page3.mmch008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch009
            #add-point:ON ACTION controlp INFIELD mmch009 name="input.c.page3.mmch009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch010
            #add-point:ON ACTION controlp INFIELD mmch010 name="input.c.page3.mmch010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch011
            #add-point:ON ACTION controlp INFIELD mmch011 name="input.c.page3.mmch011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch012
            #add-point:ON ACTION controlp INFIELD mmch012 name="input.c.page3.mmch012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch013
            #add-point:ON ACTION controlp INFIELD mmch013 name="input.c.page3.mmch013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch014
            #add-point:ON ACTION controlp INFIELD mmch014 name="input.c.page3.mmch014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch015
            #add-point:ON ACTION controlp INFIELD mmch015 name="input.c.page3.mmch015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmch016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmch016
            #add-point:ON ACTION controlp INFIELD mmch016 name="input.c.page3.mmch016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmchstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmchstus
            #add-point:ON ACTION controlp INFIELD mmchstus name="input.c.page3.mmchstus"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmcg3_d[l_ac].* = g_mmcg3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammm356_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammm356_unlock_b("mmch_t","'3'")
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
               LET g_mmcg3_d[li_reproduce_target].* = g_mmcg3_d[li_reproduce].*
 
               LET g_mmcg3_d[li_reproduce_target].mmch003 = NULL
               LET g_mmcg3_d[li_reproduce_target].mmch004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmcg3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmcg3_d.getLength()+1
            END IF
            
      END INPUT
 
      
      INPUT ARRAY g_mmcg4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[3]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_mmcg3_d.getLength() = 0 THEN
               NEXT FIELD mmch003
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_mmcg3_d[g_detail_idx].mmch003) THEN
               NEXT FIELD mmch003
            END IF
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmcg4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmcg4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmcg4_d[l_ac].* TO NULL 
            INITIALIZE g_mmcg4_d_t.* TO NULL 
            INITIALIZE g_mmcg4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_mmcg4_d_t.* = g_mmcg4_d[l_ac].*     #新輸入資料
            LET g_mmcg4_d_o.* = g_mmcg4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammm356_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL ammm356_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmcg4_d[li_reproduce_target].* = g_mmcg4_d[li_reproduce].*
 
               LET g_mmcg4_d[li_reproduce_target].mmdk005 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[4] = l_ac
            LET g_current_page = 4
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammm356_cl USING g_enterprise,g_mmbt_m.mmbt001
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammm356_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE ammm356_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN ammm356_bcl3 USING g_enterprise,g_mmbt_m.mmbt001,g_mmcg3_d[g_detail_idx].mmch003,g_mmcg3_d[g_detail_idx].mmch004 
 
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammm356_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammm356_cl
               CLOSE ammm356_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmcg4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmcg4_d[l_ac].mmdk005 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmcg4_d_t.* = g_mmcg4_d[l_ac].*  #BACKUP
               LET g_mmcg4_d_o.* = g_mmcg4_d[l_ac].*  #BACKUP
               CALL ammm356_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL ammm356_set_no_entry_b(l_cmd)
               IF NOT ammm356_lock_b("mmdk_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammm356_bcl4 INTO g_mmcg4_d[l_ac].mmdk005,g_mmcg4_d[l_ac].mmdk006,g_mmcg4_d[l_ac].mmdk007, 
                      g_mmcg4_d[l_ac].mmdk008,g_mmcg4_d[l_ac].mmdk009,g_mmcg4_d[l_ac].mmdk010,g_mmcg4_d[l_ac].mmdk011, 
                      g_mmcg4_d[l_ac].mmdkacti
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmcg4_d_mask_o[l_ac].* =  g_mmcg4_d[l_ac].*
                  CALL ammm356_mmdk_t_mask()
                  LET g_mmcg4_d_mask_n[l_ac].* =  g_mmcg4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammm356_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
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
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point    
 
               #取得該筆資料key值
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys[2] = g_mmcg3_d[g_detail_idx].mmch003
               LET gs_keys[3] = g_mmcg3_d[g_detail_idx].mmch004
               LET gs_keys[4] = g_mmcg4_d_t.mmdk005
 
 
               #刪除同層單身
               IF NOT ammm356_delete_b('mmdk_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammm356_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE ammm356_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
 
               LET l_count = g_mmcg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmcg4_d.getLength() + 1) THEN
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
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
            
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mmdk_t 
             WHERE mmdkent = g_enterprise AND mmdk001 = g_mmbt_m.mmbt001 AND mmdk003 = g_mmcg3_d[g_detail_idx].mmch003  
                 AND mmdk004 = g_mmcg3_d[g_detail_idx].mmch004 AND mmdk005 = g_mmcg4_d[g_detail_idx2].mmdk005 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys[2] = g_mmcg3_d[g_detail_idx].mmch003
               LET gs_keys[3] = g_mmcg3_d[g_detail_idx].mmch004
               LET gs_keys[4] = g_mmcg4_d[g_detail_idx2].mmdk005
               CALL ammm356_insert_b('mmdk_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmcg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammm356_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
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
               LET g_mmcg4_d[l_ac].* = g_mmcg4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammm356_bcl4
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
               LET g_mmcg4_d[l_ac].* = g_mmcg4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL ammm356_mmdk_t_mask_restore('restore_mask_o')
               
               UPDATE mmdk_t SET (mmdk001,mmdk003,mmdk004,mmdk005,mmdk006,mmdk007,mmdk008,mmdk009,mmdk010, 
                   mmdk011,mmdkacti) = (g_mmbt_m.mmbt001,g_mmcg3_d[g_detail_idx].mmch003,g_mmcg3_d[g_detail_idx].mmch004, 
                   g_mmcg4_d[l_ac].mmdk005,g_mmcg4_d[l_ac].mmdk006,g_mmcg4_d[l_ac].mmdk007,g_mmcg4_d[l_ac].mmdk008, 
                   g_mmcg4_d[l_ac].mmdk009,g_mmcg4_d[l_ac].mmdk010,g_mmcg4_d[l_ac].mmdk011,g_mmcg4_d[l_ac].mmdkacti)  
                   #自訂欄位頁簽
                WHERE mmdkent = g_enterprise AND mmdk001 = g_mmbt001_t AND mmdk003 = g_mmcg3_d[g_detail_idx].mmch003  
                    AND mmdk004 = g_mmcg3_d[g_detail_idx].mmch004 AND mmdk005 = g_mmcg4_d_t.mmdk005
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmcg4_d[l_ac].* = g_mmcg4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdk_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmcg4_d[l_ac].* = g_mmcg4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbt_m.mmbt001
               LET gs_keys_bak[1] = g_mmbt001_t
               LET gs_keys[2] = g_mmcg3_d[g_detail_idx].mmch003
               LET gs_keys_bak[2] = g_mmcg3_d[g_detail_idx].mmch003
               LET gs_keys[3] = g_mmcg3_d[g_detail_idx].mmch004
               LET gs_keys_bak[3] = g_mmcg3_d[g_detail_idx].mmch004
               LET gs_keys[4] = g_mmcg4_d[g_detail_idx2].mmdk005
               LET gs_keys_bak[4] = g_mmcg4_d_t.mmdk005
               CALL ammm356_update_b('mmdk_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL ammm356_mmdk_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbt_m),util.JSON.stringify(g_mmcg4_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbt_m),util.JSON.stringify(g_mmcg4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk005
            #add-point:BEFORE FIELD mmdk005 name="input.b.page4.mmdk005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk005
            
            #add-point:AFTER FIELD mmdk005 name="input.a.page4.mmdk005"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_mmbt_m.mmbt001 IS NOT NULL AND g_mmcg3_d[g_detail_idx].mmch003 IS NOT NULL AND g_mmcg3_d[g_detail_idx].mmch004 IS NOT NULL AND g_mmcg4_d[g_detail_idx2].mmdk005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbt_m.mmbt001 != g_mmbt001_t OR g_mmcg3_d[g_detail_idx].mmch003 != g_mmcg3_d[g_detail_idx].mmch003 OR g_mmcg3_d[g_detail_idx].mmch004 != g_mmcg3_d[g_detail_idx].mmch004 OR g_mmcg4_d[g_detail_idx2].mmdk005 != g_mmcg4_d_t.mmdk005)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdk_t WHERE "||"mmdkent = '" ||g_enterprise|| "' AND "||"mmdk001 = '"||g_mmbt_m.mmbt001 ||"' AND "|| "mmdk003 = '"||g_mmcg3_d[g_detail_idx].mmch003 ||"' AND "|| "mmdk004 = '"||g_mmcg3_d[g_detail_idx].mmch004 ||"' AND "|| "mmdk005 = '"||g_mmcg4_d[g_detail_idx2].mmdk005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdk005
            #add-point:ON CHANGE mmdk005 name="input.g.page4.mmdk005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk006
            #add-point:BEFORE FIELD mmdk006 name="input.b.page4.mmdk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk006
            
            #add-point:AFTER FIELD mmdk006 name="input.a.page4.mmdk006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdk006
            #add-point:ON CHANGE mmdk006 name="input.g.page4.mmdk006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk007
            #add-point:BEFORE FIELD mmdk007 name="input.b.page4.mmdk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk007
            
            #add-point:AFTER FIELD mmdk007 name="input.a.page4.mmdk007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdk007
            #add-point:ON CHANGE mmdk007 name="input.g.page4.mmdk007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk008
            #add-point:BEFORE FIELD mmdk008 name="input.b.page4.mmdk008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk008
            
            #add-point:AFTER FIELD mmdk008 name="input.a.page4.mmdk008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdk008
            #add-point:ON CHANGE mmdk008 name="input.g.page4.mmdk008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk009
            #add-point:BEFORE FIELD mmdk009 name="input.b.page4.mmdk009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk009
            
            #add-point:AFTER FIELD mmdk009 name="input.a.page4.mmdk009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdk009
            #add-point:ON CHANGE mmdk009 name="input.g.page4.mmdk009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk010
            #add-point:BEFORE FIELD mmdk010 name="input.b.page4.mmdk010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk010
            
            #add-point:AFTER FIELD mmdk010 name="input.a.page4.mmdk010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdk010
            #add-point:ON CHANGE mmdk010 name="input.g.page4.mmdk010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdk011
            #add-point:BEFORE FIELD mmdk011 name="input.b.page4.mmdk011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdk011
            
            #add-point:AFTER FIELD mmdk011 name="input.a.page4.mmdk011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdk011
            #add-point:ON CHANGE mmdk011 name="input.g.page4.mmdk011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdkacti
            #add-point:BEFORE FIELD mmdkacti name="input.b.page4.mmdkacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdkacti
            
            #add-point:AFTER FIELD mmdkacti name="input.a.page4.mmdkacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdkacti
            #add-point:ON CHANGE mmdkacti name="input.g.page4.mmdkacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.mmdk005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk005
            #add-point:ON ACTION controlp INFIELD mmdk005 name="input.c.page4.mmdk005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk006
            #add-point:ON ACTION controlp INFIELD mmdk006 name="input.c.page4.mmdk006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk007
            #add-point:ON ACTION controlp INFIELD mmdk007 name="input.c.page4.mmdk007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk008
            #add-point:ON ACTION controlp INFIELD mmdk008 name="input.c.page4.mmdk008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk009
            #add-point:ON ACTION controlp INFIELD mmdk009 name="input.c.page4.mmdk009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdk010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk010
            #add-point:ON ACTION controlp INFIELD mmdk010 name="input.c.page4.mmdk010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdk011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdk011
            #add-point:ON ACTION controlp INFIELD mmdk011 name="input.c.page4.mmdk011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdkacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdkacti
            #add-point:ON ACTION controlp INFIELD mmdkacti name="input.c.page4.mmdkacti"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4_after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmcg4_d[l_ac].* = g_mmcg4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammm356_bcl4
               CLOSE ammm356_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammm356_unlock_b("mmdk_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4_after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmcg4_d[li_reproduce_target].* = g_mmcg4_d[li_reproduce].*
 
               LET g_mmcg4_d[li_reproduce_target].mmdk005 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmcg4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmcg4_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="ammm356.input.other" >}
      
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
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD mmbt001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmcg003
               WHEN "s_detail2"
                  NEXT FIELD mmbx004
               WHEN "s_detail3"
                  NEXT FIELD mmch003
               WHEN "s_detail4"
                  NEXT FIELD mmdk005
 
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
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
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
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION ammm356_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_flag    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL ammm356_b_fill() #單身填充
      CALL ammm356_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL ammm356_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = g_mmbt_m.mmbt001
          CALL ap_ref_array2(g_ref_fields," SELECT mmbtl003,mmbtl004 FROM mmbtl_t WHERE mmbtlent = '"||g_enterprise||"' AND mmbtl001 = ? AND mmbtl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
          LET g_mmbt_m.mmbtl003 = g_rtn_fields[1] 
          LET g_mmbt_m.mmbtl004 = g_rtn_fields[2] 
          DISPLAY g_mmbt_m.mmbtl003 TO mmbtl002
          DISPLAY g_mmbt_m.mmbtl004 TO mmbtl003
          CALL ammm356_mmbt005_ref()   #160729-00077#7 20160817 add by beckxie
          #160729-00077#7 20160817 mark by beckxie---S
          #IF g_mmbt_m.mmbt019='1' THEN #卡种
          #   INITIALIZE g_ref_fields TO NULL
          #   LET g_ref_fields[1] = g_mmbt_m.mmbt005
          #   CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
          #   LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
          #   DISPLAY BY NAME g_mmbt_m.mmbt005_desc
          #END IF
          #IF g_mmbt_m.mmbt019='1' THEN #会员等级
          #   INITIALIZE g_ref_fields TO NULL
          #   LET g_ref_fields[1] = g_mmbt_m.mmbt005
          #   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
          #   LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
          #   DISPLAY BY NAME g_mmbt_m.mmbt005_desc
          #END IF
          #160729-00077#7 20160817 mark by beckxie---E

#           CALL  ammm356_mmbtunit_ref()  
#            
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbt_m.mmbt005
#            CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbt_m.mmbt005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbt_m.mmbtownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbt_m.mmbtownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbt_m.mmbtownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbt_m.mmbtowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbt_m.mmbtowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbt_m.mmbtowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbt_m.mmbtcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbt_m.mmbtcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbt_m.mmbtcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbt_m.mmbtcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbt_m.mmbtcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbt_m.mmbtcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbt_m.mmbtmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbt_m.mmbtmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbt_m.mmbtmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbt_m.mmbtcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbt_m.mmbtcnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbt_m.mmbtcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mmbt_m_mask_o.* =  g_mmbt_m.*
   CALL ammm356_mmbt_t_mask()
   LET g_mmbt_m_mask_n.* =  g_mmbt_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbtunit_desc,g_mmbt_m.mmbt001,g_mmbt_m.mmbt002, 
       g_mmbt_m.mmbtl003,g_mmbt_m.mmbtl004,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbt006, 
       g_mmbt_m.mmbt003,g_mmbt_m.mmbt007,g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016, 
       g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus,g_mmbt_m.mmbtownid,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp, 
       g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtid_desc,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdp_desc, 
       g_mmbt_m.mmbtcrtdt,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid, 
       g_mmbt_m.mmbtcnfid_desc,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmch004_1,g_mmbt_m.mmch011_1,g_mmbt_m.mmch013_1, 
       g_mmbt_m.mmch015_1,g_mmbt_m.mmch004_desc_1,g_mmbt_m.mmch012_1,g_mmbt_m.mmch014_1,g_mmbt_m.mmch016_1 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbt_m.mmbtstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mmcg_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #LET  g_mmcg_d[l_ac].mmcg004_desc = ammm356_mmcg004_ref(g_mmbt_m.mmbt007,g_mmcg_d[l_ac].mmcg004) 
       CALL s_aint800_01_show(g_mmbt_m.mmbt007,g_mmcg_d[l_ac].mmcg004,'',g_mmbt_m.mmbtunit,'')  RETURNING l_flag,g_mmcg_d[l_ac].mmcg004_desc
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mmcg2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
#       CALL ammm356_mmbx004_ref()

       

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmcg3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
       LET  g_mmcg3_d[l_ac].mmch004_desc = ammm356_mmch004_ref(g_mmcg3_d[l_ac].mmch003,g_mmcg3_d[l_ac].mmch004) 
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmcg4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL ammm356_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION ammm356_detail_show()
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
 
{<section id="ammm356.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammm356_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mmbt_t.mmbt001 
   DEFINE l_oldno     LIKE mmbt_t.mmbt001 
 
   DEFINE l_master    RECORD LIKE mmbt_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mmcg_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mmbx_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mmch_t.* #此變數樣板目前無使用
 
 
   DEFINE l_detail4    RECORD LIKE mmdk_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_mmbt_m.mmbt001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mmbt001_t = g_mmbt_m.mmbt001
 
    
   LET g_mmbt_m.mmbt001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmbt_m.mmbtownid = g_user
      LET g_mmbt_m.mmbtowndp = g_dept
      LET g_mmbt_m.mmbtcrtid = g_user
      LET g_mmbt_m.mmbtcrtdp = g_dept 
      LET g_mmbt_m.mmbtcrtdt = cl_get_current()
      LET g_mmbt_m.mmbtmodid = g_user
      LET g_mmbt_m.mmbtmoddt = cl_get_current()
      LET g_mmbt_m.mmbtstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbt_m.mmbtstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL ammm356_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mmbt_m.* TO NULL
      INITIALIZE g_mmcg_d TO NULL
      INITIALIZE g_mmcg2_d TO NULL
      INITIALIZE g_mmcg3_d TO NULL
      INITIALIZE g_mmcg4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL ammm356_show()
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
   CALL ammm356_set_act_visible()   
   CALL ammm356_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmbt001_t = g_mmbt_m.mmbt001
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmbtent = " ||g_enterprise|| " AND",
                      " mmbt001 = '", g_mmbt_m.mmbt001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammm356_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL ammm356_idx_chk()
   
   LET g_data_owner = g_mmbt_m.mmbtownid      
   LET g_data_dept  = g_mmbt_m.mmbtowndp
   
   #功能已完成,通報訊息中心
   CALL ammm356_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION ammm356_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmcg_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mmbx_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mmch_t.* #此變數樣板目前無使用
 
 
   DEFINE l_detail4    RECORD LIKE mmdk_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE ammm356_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmcg_t
    WHERE mmcgent = g_enterprise AND mmcg001 = g_mmbt001_t
 
    INTO TEMP ammm356_detail
 
   #將key修正為調整後   
   UPDATE ammm356_detail 
      #更新key欄位
      SET mmcg001 = g_mmbt_m.mmbt001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, mmcgstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, mmbxstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
      #, mmchstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mmcg_t SELECT * FROM ammm356_detail
   
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
   DROP TABLE ammm356_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmbx_t 
    WHERE mmbxent = g_enterprise AND mmbx001 = g_mmbt001_t
 
    INTO TEMP ammm356_detail
 
   #將key修正為調整後   
   UPDATE ammm356_detail SET mmbx001 = g_mmbt_m.mmbt001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmbx_t SELECT * FROM ammm356_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammm356_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmch_t 
    WHERE mmchent = g_enterprise AND mmch001 = g_mmbt001_t
 
    INTO TEMP ammm356_detail
 
   #將key修正為調整後   
   UPDATE ammm356_detail SET mmch001 = g_mmbt_m.mmbt001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmch_t SELECT * FROM ammm356_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammm356_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmdk_t 
    WHERE mmdkent = g_enterprise AND mmdk001 = g_mmbt001_t
 
    INTO TEMP ammm356_detail
 
   #將key修正為調整後   
   UPDATE ammm356_detail SET mmdk001 = g_mmbt_m.mmbt001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO mmdk_t SELECT * FROM ammm356_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammm356_detail
   
   LET g_data_owner = g_mmbt_m.mmbtownid      
   LET g_data_dept  = g_mmbt_m.mmbtowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mmbt001_t = g_mmbt_m.mmbt001
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammm356_delete()
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
   
   IF g_mmbt_m.mmbt001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.mmbtl001 = g_mmbt_m.mmbt001
LET g_master_multi_table_t.mmbtl003 = g_mmbt_m.mmbtl003
LET g_master_multi_table_t.mmbtl004 = g_mmbt_m.mmbtl004
 
   
   CALL s_transaction_begin()
 
   OPEN ammm356_cl USING g_enterprise,g_mmbt_m.mmbt001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammm356_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammm356_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammm356_master_referesh USING g_mmbt_m.mmbt001 INTO g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001, 
       g_mmbt_m.mmbt002,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
       g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus, 
       g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdt, 
       g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmbtunit_desc, 
       g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid_desc, 
       g_mmbt_m.mmbtcrtdp_desc,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT ammm356_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmbt_m_mask_o.* =  g_mmbt_m.*
   CALL ammm356_mmbt_t_mask()
   LET g_mmbt_m_mask_n.* =  g_mmbt_m.*
   
   CALL ammm356_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammm356_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mmbt001_t = g_mmbt_m.mmbt001
 
 
      DELETE FROM mmbt_t
       WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbt_m.mmbt001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mmbt_m.mmbt001,":",SQLERRMESSAGE  
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
      
      DELETE FROM mmcg_t
       WHERE mmcgent = g_enterprise AND mmcg001 = g_mmbt_m.mmbt001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmcg_t:",SQLERRMESSAGE 
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
      DELETE FROM mmbx_t
       WHERE mmbxent = g_enterprise AND
             mmbx001 = g_mmbt_m.mmbt001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbx_t:",SQLERRMESSAGE 
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
      DELETE FROM mmch_t
       WHERE mmchent = g_enterprise AND
             mmch001 = g_mmbt_m.mmbt001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmch_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM mmdk_t
       WHERE mmdkent = g_enterprise AND
             mmdk001 = g_mmbt_m.mmbt001
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmbt_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE ammm356_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mmcg_d.clear() 
      CALL g_mmcg2_d.clear()       
      CALL g_mmcg3_d.clear()       
      CALL g_mmcg4_d.clear()       
 
     
      CALL ammm356_ui_browser_refresh()  
      #CALL ammm356_ui_headershow()  
      #CALL ammm356_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'mmbtlent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.mmbtl001
   LET l_field_keys[02] = 'mmbtl001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mmbtl_t')
 
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL ammm356_browser_fill("")
         CALL ammm356_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammm356_cl
 
   #功能已完成,通報訊息中心
   CALL ammm356_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="ammm356.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammm356_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_flag    LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mmcg_d.clear()
   CALL g_mmcg2_d.clear()
   CALL g_mmcg3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF ammm356_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmcg003,mmcg004,mmcg005,mmcgstus  FROM mmcg_t",   
                     " INNER JOIN mmbt_t ON mmbtent = " ||g_enterprise|| " AND mmbt001 = mmcg001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                     
                     " WHERE mmcgent=? AND mmcg001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmcg_t.mmcg003,mmcg_t.mmcg004"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammm356_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR ammm356_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mmbt_m.mmbt001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mmbt_m.mmbt001 INTO g_mmcg_d[l_ac].mmcg003,g_mmcg_d[l_ac].mmcg004, 
          g_mmcg_d[l_ac].mmcg005,g_mmcg_d[l_ac].mmcgstus   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
        #LET g_mmcg_d[l_ac].mmcg004_desc = ammm356_mmcg004_ref(g_mmbt_m.mmbt007,g_mmcg_d[l_ac].mmcg004)
        CALL s_aint800_01_show(g_mmbt_m.mmbt007,g_mmcg_d[l_ac].mmcg004,'',g_mmbt_m.mmbtunit,'')  RETURNING l_flag,g_mmcg_d[l_ac].mmcg004_desc
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
   IF ammm356_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmbx004,mmbx005,mmbxstus ,t1.ooefl003 FROM mmbx_t",   
                     " INNER JOIN  mmbt_t ON mmbtent = " ||g_enterprise|| " AND mmbt001 = mmbx001 ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=mmbx004 AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE mmbxent=? AND mmbx001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmbx_t.mmbx004"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammm356_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR ammm356_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_mmbt_m.mmbt001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_mmbt_m.mmbt001 INTO g_mmcg2_d[l_ac].mmbx004,g_mmcg2_d[l_ac].mmbx005, 
          g_mmcg2_d[l_ac].mmbxstus,g_mmcg2_d[l_ac].mmbx004_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL ammm356_mmbx004_ref()
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
   IF ammm356_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmch003,mmch004,mmch005,mmch006,mmch007,mmch008,mmch009,mmch010, 
             mmch011,mmch012,mmch013,mmch014,mmch015,mmch016,mmchstus  FROM mmch_t",   
                     " INNER JOIN  mmbt_t ON mmbtent = " ||g_enterprise|| " AND mmbt001 = mmch001 ",
 
                     "",
                     " LEFT JOIN mmdk_t ON mmchent = mmdkent AND mmch001 = mmdk001 AND mmch003 = mmdk003 AND mmch004 = mmdk004 ",
                     
                     " WHERE mmchent=? AND mmch001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table4) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table4 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY mmch_t.mmch003,mmch_t.mmch004"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammm356_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR ammm356_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_mmbt_m.mmbt001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_mmbt_m.mmbt001 INTO g_mmcg3_d[l_ac].mmch003,g_mmcg3_d[l_ac].mmch004, 
          g_mmcg3_d[l_ac].mmch005,g_mmcg3_d[l_ac].mmch006,g_mmcg3_d[l_ac].mmch007,g_mmcg3_d[l_ac].mmch008, 
          g_mmcg3_d[l_ac].mmch009,g_mmcg3_d[l_ac].mmch010,g_mmcg3_d[l_ac].mmch011,g_mmcg3_d[l_ac].mmch012, 
          g_mmcg3_d[l_ac].mmch013,g_mmcg3_d[l_ac].mmch014,g_mmcg3_d[l_ac].mmch015,g_mmcg3_d[l_ac].mmch016, 
          g_mmcg3_d[l_ac].mmchstus   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         LET g_mmcg3_d[l_ac].mmch004_desc = ammm356_mmch004_ref(g_mmcg3_d[l_ac].mmch003,g_mmcg3_d[l_ac].mmch004)
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
   
   CALL g_mmcg_d.deleteElement(g_mmcg_d.getLength())
   CALL g_mmcg2_d.deleteElement(g_mmcg2_d.getLength())
   CALL g_mmcg3_d.deleteElement(g_mmcg3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammm356_pb
   FREE ammm356_pb2
 
   FREE ammm356_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmcg_d.getLength()
      LET g_mmcg_d_mask_o[l_ac].* =  g_mmcg_d[l_ac].*
      CALL ammm356_mmcg_t_mask()
      LET g_mmcg_d_mask_n[l_ac].* =  g_mmcg_d[l_ac].*
   END FOR
   
   LET g_mmcg2_d_mask_o.* =  g_mmcg2_d.*
   FOR l_ac = 1 TO g_mmcg2_d.getLength()
      LET g_mmcg2_d_mask_o[l_ac].* =  g_mmcg2_d[l_ac].*
      CALL ammm356_mmbx_t_mask()
      LET g_mmcg2_d_mask_n[l_ac].* =  g_mmcg2_d[l_ac].*
   END FOR
   LET g_mmcg3_d_mask_o.* =  g_mmcg3_d.*
   FOR l_ac = 1 TO g_mmcg3_d.getLength()
      LET g_mmcg3_d_mask_o[l_ac].* =  g_mmcg3_d[l_ac].*
      CALL ammm356_mmch_t_mask()
      LET g_mmcg3_d_mask_n[l_ac].* =  g_mmcg3_d[l_ac].*
   END FOR
   LET g_mmcg4_d_mask_o.* =  g_mmcg4_d.*
   FOR l_ac = 1 TO g_mmcg4_d.getLength()
      LET g_mmcg4_d_mask_o[l_ac].* =  g_mmcg4_d[l_ac].*
      CALL ammm356_mmdk_t_mask()
      LET g_mmcg4_d_mask_n[l_ac].* =  g_mmcg4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammm356_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mmcg_t
       WHERE mmcgent = g_enterprise AND
         mmcg001 = ps_keys_bak[1] AND mmcg003 = ps_keys_bak[2] AND mmcg004 = ps_keys_bak[3]
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
         CALL g_mmcg_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM mmbx_t
       WHERE mmbxent = g_enterprise AND
             mmbx001 = ps_keys_bak[1] AND mmbx004 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbx_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmcg2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM mmch_t
       WHERE mmchent = g_enterprise AND
             mmch001 = ps_keys_bak[1] AND mmch003 = ps_keys_bak[2] AND mmch004 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmch_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mmcg3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
   LET ls_group = "'4',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM mmdk_t
       WHERE mmdkent = g_enterprise AND
             mmdk001 = ps_keys_bak[1] AND mmdk003 = ps_keys_bak[2] AND mmdk004 = ps_keys_bak[3] AND mmdk005 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'4'" THEN 
         CALL g_mmcg4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammm356_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mmcg_t
                  (mmcgent,
                   mmcg001,
                   mmcg003,mmcg004
                   ,mmcg005,mmcgstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mmcg_d[g_detail_idx].mmcg005,g_mmcg_d[g_detail_idx].mmcgstus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmcg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmcg_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO mmbx_t
                  (mmbxent,
                   mmbx001,
                   mmbx004
                   ,mmbx005,mmbxstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmcg2_d[g_detail_idx].mmbx005,g_mmcg2_d[g_detail_idx].mmbxstus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbx_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmcg2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO mmch_t
                  (mmchent,
                   mmch001,
                   mmch003,mmch004
                   ,mmch005,mmch006,mmch007,mmch008,mmch009,mmch010,mmch011,mmch012,mmch013,mmch014,mmch015,mmch016,mmchstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mmcg3_d[g_detail_idx].mmch005,g_mmcg3_d[g_detail_idx].mmch006,g_mmcg3_d[g_detail_idx].mmch007, 
                       g_mmcg3_d[g_detail_idx].mmch008,g_mmcg3_d[g_detail_idx].mmch009,g_mmcg3_d[g_detail_idx].mmch010, 
                       g_mmcg3_d[g_detail_idx].mmch011,g_mmcg3_d[g_detail_idx].mmch012,g_mmcg3_d[g_detail_idx].mmch013, 
                       g_mmcg3_d[g_detail_idx].mmch014,g_mmcg3_d[g_detail_idx].mmch015,g_mmcg3_d[g_detail_idx].mmch016, 
                       g_mmcg3_d[g_detail_idx].mmchstus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmch_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mmcg3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO mmdk_t
                  (mmdkent,
                   mmdk001,mmdk003,mmdk004,
                   mmdk005
                   ,mmdk006,mmdk007,mmdk008,mmdk009,mmdk010,mmdk011,mmdkacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_mmcg4_d[g_detail_idx2].mmdk006,g_mmcg4_d[g_detail_idx2].mmdk007,g_mmcg4_d[g_detail_idx2].mmdk008, 
                       g_mmcg4_d[g_detail_idx2].mmdk009,g_mmcg4_d[g_detail_idx2].mmdk010,g_mmcg4_d[g_detail_idx2].mmdk011, 
                       g_mmcg4_d[g_detail_idx2].mmdkacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'4'" THEN 
         CALL g_mmcg4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammm356_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmcg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL ammm356_mmcg_t_mask_restore('restore_mask_o')
               
      UPDATE mmcg_t 
         SET (mmcg001,
              mmcg003,mmcg004
              ,mmcg005,mmcgstus) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mmcg_d[g_detail_idx].mmcg005,g_mmcg_d[g_detail_idx].mmcgstus) 
         WHERE mmcgent = g_enterprise AND mmcg001 = ps_keys_bak[1] AND mmcg003 = ps_keys_bak[2] AND mmcg004 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmcg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmcg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammm356_mmcg_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmbx_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammm356_mmbx_t_mask_restore('restore_mask_o')
               
      UPDATE mmbx_t 
         SET (mmbx001,
              mmbx004
              ,mmbx005,mmbxstus) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmcg2_d[g_detail_idx].mmbx005,g_mmcg2_d[g_detail_idx].mmbxstus) 
         WHERE mmbxent = g_enterprise AND mmbx001 = ps_keys_bak[1] AND mmbx004 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmbx_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmbx_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammm356_mmbx_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmch_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL ammm356_mmch_t_mask_restore('restore_mask_o')
               
      UPDATE mmch_t 
         SET (mmch001,
              mmch003,mmch004
              ,mmch005,mmch006,mmch007,mmch008,mmch009,mmch010,mmch011,mmch012,mmch013,mmch014,mmch015,mmch016,mmchstus) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mmcg3_d[g_detail_idx].mmch005,g_mmcg3_d[g_detail_idx].mmch006,g_mmcg3_d[g_detail_idx].mmch007, 
                  g_mmcg3_d[g_detail_idx].mmch008,g_mmcg3_d[g_detail_idx].mmch009,g_mmcg3_d[g_detail_idx].mmch010, 
                  g_mmcg3_d[g_detail_idx].mmch011,g_mmcg3_d[g_detail_idx].mmch012,g_mmcg3_d[g_detail_idx].mmch013, 
                  g_mmcg3_d[g_detail_idx].mmch014,g_mmcg3_d[g_detail_idx].mmch015,g_mmcg3_d[g_detail_idx].mmch016, 
                  g_mmcg3_d[g_detail_idx].mmchstus) 
         WHERE mmchent = g_enterprise AND mmch001 = ps_keys_bak[1] AND mmch003 = ps_keys_bak[2] AND mmch004 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmch_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmch_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammm356_mmch_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmdk_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL ammm356_mmdk_t_mask_restore('restore_mask_o')
               
      UPDATE mmdk_t 
         SET (mmdk001,mmdk003,mmdk004,
              mmdk005
              ,mmdk006,mmdk007,mmdk008,mmdk009,mmdk010,mmdk011,mmdkacti) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_mmcg4_d[g_detail_idx2].mmdk006,g_mmcg4_d[g_detail_idx2].mmdk007,g_mmcg4_d[g_detail_idx2].mmdk008, 
                  g_mmcg4_d[g_detail_idx2].mmdk009,g_mmcg4_d[g_detail_idx2].mmdk010,g_mmcg4_d[g_detail_idx2].mmdk011, 
                  g_mmcg4_d[g_detail_idx2].mmdkacti) 
         WHERE mmdkent = g_enterprise AND mmdk001 = ps_keys_bak[1] AND mmdk003 = ps_keys_bak[2] AND mmdk004 = ps_keys_bak[3] AND mmdk005 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdk_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammm356_mmdk_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION ammm356_key_update_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'mmch_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update4"
      
      #end add-point
      
      UPDATE mmdk_t 
         SET (mmdk001,mmdk003,mmdk004) 
              = 
             (g_mmbt_m.mmbt001,g_mmcg3_d[g_detail_idx].mmch003,g_mmcg3_d[g_detail_idx].mmch004) 
         WHERE mmdkent = g_enterprise AND
               mmdk001 = ps_keys_bak[1] AND mmdk003 = ps_keys_bak[2] AND mmdk004 = ps_keys_bak[3]
 
      #add-point:update_b段修改中 name="key_update_b.m_update4"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update4"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION ammm356_key_delete_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'mmch_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete4"
      
      #end add-point
      
      DELETE FROM mmdk_t 
            WHERE mmdkent = g_enterprise AND
                  mmdk001 = ps_keys_bak[1] AND mmdk003 = ps_keys_bak[2] AND mmdk004 = ps_keys_bak[3]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete4"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdk_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete4"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammm356_lock_b(ps_table,ps_page)
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
   #CALL ammm356_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmcg_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammm356_bcl USING g_enterprise,
                                       g_mmbt_m.mmbt001,g_mmcg_d[g_detail_idx].mmcg003,g_mmcg_d[g_detail_idx].mmcg004  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammm356_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "mmbx_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammm356_bcl2 USING g_enterprise,
                                             g_mmbt_m.mmbt001,g_mmcg2_d[g_detail_idx].mmbx004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammm356_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "mmch_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammm356_bcl3 USING g_enterprise,
                                             g_mmbt_m.mmbt001,g_mmcg3_d[g_detail_idx].mmch003,g_mmcg3_d[g_detail_idx].mmch004 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammm356_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "mmdk_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammm356_bcl4 USING g_enterprise,
                                             g_mmbt_m.mmbt001,g_mmcg3_d[g_detail_idx].mmch003,g_mmcg3_d[g_detail_idx].mmch004, 
 
                                             g_mmcg4_d[g_detail_idx2].mmdk005
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammm356_bcl4:",SQLERRMESSAGE 
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
 
{<section id="ammm356.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammm356_unlock_b(ps_table,ps_page)
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
      CLOSE ammm356_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammm356_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammm356_bcl3
   END IF
 
 
   
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammm356_bcl4
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammm356_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmbt001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammm356_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmbt001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
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
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammm356_set_entry_b(p_cmd)
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
   
   IF g_mmbt_m.mmbt007 <> '0' THEN
      CALL cl_set_comp_entry('mmcg004',TRUE)
   END IF

   IF g_mmcg3_d[l_ac].mmch005 = 'Y' THEN
      CALL cl_set_comp_entry("mmch006",TRUE)
   END IF
   IF g_mmcg3_d[l_ac].mmch007 = '3' THEN
      CALL cl_set_comp_entry("mmch008,mmch009",TRUE)
   END IF
 
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="ammm356.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammm356_set_no_entry_b(p_cmd)
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
   IF g_mmcg3_d[l_ac].mmch005 = 'N' THEN
      CALL cl_set_comp_entry("mmch006",FALSE)
      LET  g_mmcg3_d[l_ac].mmch006 =''
   END IF
   IF g_mmcg3_d[l_ac].mmch007 <> '3' THEN
      CALL cl_set_comp_entry("mmch008,mmch009",FALSE)
      LET g_mmcg3_d[l_ac].mmch008 = ''
      LET g_mmcg3_d[l_ac].mmch009 = ''
   END IF

   
   IF g_mmbt_m.mmbt007 = '0' THEN
      LET g_mmcg_d[l_ac].mmcg004 = 'ALL'
      CALL cl_set_comp_entry('mmcg004',FALSE)
   END IF

 
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="ammm356.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammm356_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammm356_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION ammm356_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION ammm356_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammm356_default_search()
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
      LET ls_wc = ls_wc, " mmbt001 = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mmbt_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmcg_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmbx_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mmch_t" 
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
 
{<section id="ammm356.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION ammm356_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5 
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_mmbt_m.mmbtstus <> 'N' THEN RETURN END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmbt_m.mmbt001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN ammm356_cl USING g_enterprise,g_mmbt_m.mmbt001
   IF STATUS THEN
      CLOSE ammm356_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammm356_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE ammm356_master_referesh USING g_mmbt_m.mmbt001 INTO g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbt001, 
       g_mmbt_m.mmbt002,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007, 
       g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus, 
       g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdt, 
       g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmbtunit_desc, 
       g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid_desc, 
       g_mmbt_m.mmbtcrtdp_desc,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT ammm356_action_chk() THEN
      CLOSE ammm356_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbtunit_desc,g_mmbt_m.mmbt001,g_mmbt_m.mmbt002, 
       g_mmbt_m.mmbtl003,g_mmbt_m.mmbtl004,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbt006, 
       g_mmbt_m.mmbt003,g_mmbt_m.mmbt007,g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016, 
       g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus,g_mmbt_m.mmbtownid,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp, 
       g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtid_desc,g_mmbt_m.mmbtcrtdp,g_mmbt_m.mmbtcrtdp_desc, 
       g_mmbt_m.mmbtcrtdt,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid, 
       g_mmbt_m.mmbtcnfid_desc,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmch004_1,g_mmbt_m.mmch011_1,g_mmbt_m.mmch013_1, 
       g_mmbt_m.mmch015_1,g_mmbt_m.mmch004_desc_1,g_mmbt_m.mmch012_1,g_mmbt_m.mmch014_1,g_mmbt_m.mmch016_1 
 
 
   CASE g_mmbt_m.mmbtstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mmbt_m.mmbtstus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
            
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
      g_mmbt_m.mmbtstus = lc_state OR cl_null(lc_state) THEN
      CLOSE ammm356_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state
      WHEN 'Y'
         CALL s_ammm356_conf_chk(g_mmbt_m.mmbt001) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_ammm356_conf_upd(g_mmbt_m.mmbt001) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#5 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmbt_m.mmbt001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#5 add
            RETURN
         END IF
      WHEN 'X'
         CALL s_ammm356_invalid_chk(g_mmbt_m.mmbt001) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_ammm356_invalid_upd(g_mmbt_m.mmbt001) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#5 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmbt_m.mmbt001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#5 add
            RETURN
         END IF   
       WHEN 'N'
         CALL s_ammm356_unconf_chk(g_mmbt_m.mmbt001) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_ammm356_unconf_upd(g_mmbt_m.mmbt001) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#5 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmbt_m.mmbt001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#5 add
            RETURN
         END IF   
          
     END CASE     
   #end add-point
   
   LET g_mmbt_m.mmbtmodid = g_user
   LET g_mmbt_m.mmbtmoddt = cl_get_current()
   LET g_mmbt_m.mmbtstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mmbt_t 
      SET (mmbtstus,mmbtmodid,mmbtmoddt) 
        = (g_mmbt_m.mmbtstus,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt)     
    WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbt_m.mmbt001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE ammm356_master_referesh USING g_mmbt_m.mmbt001 INTO g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit, 
          g_mmbt_m.mmbt001,g_mmbt_m.mmbt002,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt006,g_mmbt_m.mmbt003, 
          g_mmbt_m.mmbt007,g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015,g_mmbt_m.mmbt016,g_mmbt_m.mmbt017, 
          g_mmbt_m.mmbtstus,g_mmbt_m.mmbtownid,g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtdp, 
          g_mmbt_m.mmbtcrtdt,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmoddt,g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfdt, 
          g_mmbt_m.mmbtunit_desc,g_mmbt_m.mmbt005_desc,g_mmbt_m.mmbtownid_desc,g_mmbt_m.mmbtowndp_desc, 
          g_mmbt_m.mmbtcrtid_desc,g_mmbt_m.mmbtcrtdp_desc,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mmbt_m.mmbt004,g_mmbt_m.mmbtunit,g_mmbt_m.mmbtunit_desc,g_mmbt_m.mmbt001,g_mmbt_m.mmbt002, 
          g_mmbt_m.mmbtl003,g_mmbt_m.mmbtl004,g_mmbt_m.mmbt019,g_mmbt_m.mmbt005,g_mmbt_m.mmbt005_desc, 
          g_mmbt_m.mmbt006,g_mmbt_m.mmbt003,g_mmbt_m.mmbt007,g_mmbt_m.mmbt008,g_mmbt_m.mmbt014,g_mmbt_m.mmbt015, 
          g_mmbt_m.mmbt016,g_mmbt_m.mmbt017,g_mmbt_m.mmbtstus,g_mmbt_m.mmbtownid,g_mmbt_m.mmbtownid_desc, 
          g_mmbt_m.mmbtowndp,g_mmbt_m.mmbtowndp_desc,g_mmbt_m.mmbtcrtid,g_mmbt_m.mmbtcrtid_desc,g_mmbt_m.mmbtcrtdp, 
          g_mmbt_m.mmbtcrtdp_desc,g_mmbt_m.mmbtcrtdt,g_mmbt_m.mmbtmodid,g_mmbt_m.mmbtmodid_desc,g_mmbt_m.mmbtmoddt, 
          g_mmbt_m.mmbtcnfid,g_mmbt_m.mmbtcnfid_desc,g_mmbt_m.mmbtcnfdt,g_mmbt_m.mmch004_1,g_mmbt_m.mmch011_1, 
          g_mmbt_m.mmch013_1,g_mmbt_m.mmch015_1,g_mmbt_m.mmch004_desc_1,g_mmbt_m.mmch012_1,g_mmbt_m.mmch014_1, 
          g_mmbt_m.mmch016_1
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE ammm356_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammm356_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammm356.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION ammm356_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmcg_d.getLength() THEN
         LET g_detail_idx = g_mmcg_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmcg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmcg_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmcg2_d.getLength() THEN
         LET g_detail_idx = g_mmcg2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmcg2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmcg2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_mmcg3_d.getLength() THEN
         LET g_detail_idx = g_mmcg3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmcg3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmcg3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx2 > g_mmcg4_d.getLength() THEN
         LET g_detail_idx2 = g_mmcg4_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_mmcg4_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_mmcg4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammm356_b_fill2(pi_idx)
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
   
   IF ammm356_fill_chk(4) THEN
      IF (pi_idx = 4 OR pi_idx = 0 ) AND g_mmcg3_d.getLength() > 0 THEN
               CALL g_mmcg4_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[3]
         
         LET g_sql = "SELECT  DISTINCT mmdk005,mmdk006,mmdk007,mmdk008,mmdk009,mmdk010,mmdk011,mmdkacti  FROM mmdk_t", 
                 
                     "",
                     
                     " WHERE mmdkent=? AND mmdk001=? AND mmdk003=? AND mmdk004=?"
         
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  mmdk_t.mmdk005" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill4"
         
         #end add-point
         
         #先清空資料
               CALL g_mmcg4_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammm356_pb4 FROM g_sql
         DECLARE b_fill_curs4 CURSOR FOR ammm356_pb4
         
      #  OPEN b_fill_curs4 USING g_enterprise,g_mmbt_m.mmbt001,g_mmcg3_d[g_detail_idx].mmch003,g_mmcg3_d[g_detail_idx].mmch004  
      #      #(ver:78)
         LET l_ac = 1
         FOREACH b_fill_curs4 USING g_enterprise,g_mmbt_m.mmbt001,g_mmcg3_d[g_detail_idx].mmch003,g_mmcg3_d[g_detail_idx].mmch004 INTO g_mmcg4_d[l_ac].mmdk005, 
             g_mmcg4_d[l_ac].mmdk006,g_mmcg4_d[l_ac].mmdk007,g_mmcg4_d[l_ac].mmdk008,g_mmcg4_d[l_ac].mmdk009, 
             g_mmcg4_d[l_ac].mmdk010,g_mmcg4_d[l_ac].mmdk011,g_mmcg4_d[l_ac].mmdkacti   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill4"
            
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
               CALL g_mmcg4_d.deleteElement(g_mmcg4_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_mmcg4_d_mask_o.* =  g_mmcg4_d.*
   FOR l_ac = 1 TO g_mmcg4_d.getLength()
      LET g_mmcg4_d_mask_o[l_ac].* =  g_mmcg4_d[l_ac].*
      CALL ammm356_mmdk_t_mask()
      LET g_mmcg4_d_mask_n[l_ac].* =  g_mmcg4_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL ammm356_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION ammm356_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="ammm356.status_show" >}
PRIVATE FUNCTION ammm356_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammm356.mask_functions" >}
&include "erp/amm/ammm356_mask.4gl"
 
{</section>}
 
{<section id="ammm356.signature" >}
   
 
{</section>}
 
{<section id="ammm356.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammm356_set_pk_array()
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
   LET g_pk_array[1].values = g_mmbt_m.mmbt001
   LET g_pk_array[1].column = 'mmbt001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammm356.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="ammm356.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammm356_msgcentre_notify(lc_state)
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
   CALL ammm356_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmbt_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammm356.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammm356_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammm356.other_function" readonly="Y" >}
#+ 營運據點檢查
PUBLIC FUNCTION ammm356_mmbx004_chk(p_ooeaent,p_ooea001)
   DEFINE p_ooeaent   LIKE ooea_t.ooeaent
   DEFINE p_ooea001   LIKE ooea_t.ooea001
   DEFINE l_ooeastus  LIKE ooea_t.ooeastus
   
   SELECT ooeastus INTO l_ooeastus FROM ooea_t 
    WHERE ooeaent = p_ooeaent AND ooea001 = p_ooea001  AND ooea004 = 'Y'
    
   IF status = 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00163'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF  
   IF l_ooeastus = 'N' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00012'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE    
END FUNCTION
#+ 卡種檢查
PUBLIC FUNCTION ammm356_mmbt005_chk(p_mmanent,p_mman001)
   DEFINE  p_mmanent  LIKE mman_t.mmanent  #企业编号
   DEFINE  p_mman001  LIKE mman_t.mman001  #卡种
   DEFINE  l_mmanstus LIKE mman_t.mmanstus #有效码
   DEFINE  l_errmsg   STRING               #报错

   SELECT mmanstus INTO l_mmanstus FROM mman_t 
    WHERE mmanent = p_mmanent AND mman001 = p_mman001

   IF status = 100 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00003'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF 
   IF l_mmanstus = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00004'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ chk 規則編號
PUBLIC FUNCTION ammm356_mmcg004_chk(p_mmcg004)
DEFINE p_mmcg004  LIKE mmcg_t.mmcg004
DEFINE l_oocqstus LIKE oocq_t.oocqstus
DEFINE l_ooiastus LIKE ooia_t.ooiastus
DEFINE l_imaastus LIKE imaa_t.imaastus
DEFINE l_rtaxstus LIKE rtax_t.rtaxstus
DEFINE l_rtax005  LIKE rtax_t.rtax005
DEFINE l_n        LIKE type_t.num5

    CASE g_mmbt_m.mmbt007
       WHEN  '1'
          #會員等級
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2024' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00076'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00077'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  '2' 
          #會員類型
          
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2025' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00074'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00075'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '3'
          #款別類型
          
          SELECT ooiastus INTO l_ooiastus FROM ooia_t WHERE ooiaent = g_enterprise AND ooia001 = p_mmcg004
          IF STATUS = 100 OR cl_null(l_ooiastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aoo-00195'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_ooiastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod 'aoo-00196'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aooi713'
                LET g_errparam.replace[2] = cl_get_progname('aooi713',g_lang,"2")
                LET g_errparam.exeprog    ='aooi713'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '4'
          #商品編號
          SELECT imaastus INTO l_imaastus FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_mmcg004
           IF STATUS = 100 OR cl_null(l_imaastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00016'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_imaastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  'sub-01302'  #160318-00005#23 mod'art-00050'
                LET g_errparam.extend = ''
                 #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aimm200'
                LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                LET g_errparam.exeprog    ='aimm200'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '5'
          #商品分類
           SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmcg004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '6'
          #商品屬性-產地分類
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2000' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00077'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00078'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
          
       WHEN  '7'
          #商品屬性-價格帶
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2001' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00079'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00080'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '8'
          #商品屬性-品牌
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2002' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00081'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00082'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '9'
          #商品屬性-系列
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2003' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00083'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00084'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'A'
          #商品屬性-型別
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2004' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00085'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00086'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'B'
          #商品屬性-功能
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2005' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00087'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00088'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'C'
          #商品屬性-其它屬性一
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2006' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00089'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00090'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'D'
          #商品屬性-其它屬性二
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2007' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00091'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00092'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'E'
          #商品屬性-其它屬性三
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2008' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00093'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00094'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'F'
          #商品屬性-其它屬性四
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2009' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00095'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00096'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'G'
          #商品屬性-其它屬性五
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2010' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00097'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00098'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'H'
          #商品屬性-其它屬性六
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2011' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00099'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00100'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'I'
          #商品屬性-其它屬性七
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2012' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00101'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00102'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'J'
          #商品屬性-其它屬性八
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2013' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00103'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00104'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'K'
          #商品屬性-其它屬性九
            SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2014' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00105'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00106'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'L'
          #商品屬性-其它屬性十
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2015' AND oocq002 = p_mmcg004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00107'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00108'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN 'U'
         #庫區類別
         SELECT COUNT(*) INTO l_n FROM gzcb_t WHERE gzcb001 = '6200' AND gzcb002 = p_mmcg004
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00114'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
         RETURN TRUE
       WHEN 'V' 
         #庫區品類(层级未添加）
          SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmcg004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
         
         
    END CASE
    RETURN TRUE
END FUNCTION
#
PUBLIC FUNCTION ammm356_mmcg004_ref(p_mmbt007,p_mmcg004)
DEFINE p_mmbt007       LIKE mmbt_t.mmbt007
DEFINE p_mmcg004       LIKE mmcg_t.mmcg004
DEFINE l_mmcg004_desc  LIKE type_t.chr80

    CASE p_mmbt007
       WHEN  '1' #會員等級
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2024' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang
           
        
       WHEN  '2' #會員類型
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2025' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang
       
       WHEN  '3' #款別類型
          SELECT ooial003 INTO l_mmcg004_desc FROM ooial_t
           WHERE ooialent = g_enterprise AND ooial001 =  p_mmcg004 AND ooial002 = g_dlang
       
       WHEN '4' #商品編號
          SELECT imaal003 INTO l_mmcg004_desc FROM imaal_t
           WHERE imaalent = g_enterprise AND imaal001 = p_mmcg004 AND imaal002 = g_dlang
           
       WHEN '5' #商品分類
           SELECT rtaxl003 INTO l_mmcg004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = p_mmcg004 AND rtaxl002 = g_dlang 

       WHEN '6' #商品屬性-產地分類
           SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2000' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang
           
       WHEN '7' #商品屬性-價格帶
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2001' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang
           
       WHEN '8' #商品屬性-品牌
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2002' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang  

       WHEN '9' #商品屬性-系列
           SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2003' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang   

       WHEN 'A' #商品屬性-型別
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2004' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang 

       WHEN 'B' #商品屬性-功能
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2005' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang 
       
       WHEN 'C' #商品屬性-其它屬性一
         SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2006' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang  

       WHEN 'D' #商品屬性-其它屬性二
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2007' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang  
   
       WHEN 'E' #商品屬性-其它屬性三
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2008' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang  
       WHEN 'F' #商品屬性-其它屬性四
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2009' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang  
       WHEN 'G' #商品屬性-其它屬性五
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2010' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang  
        
       WHEN 'H' #商品屬性-其它屬性六
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2011' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang  
           
       WHEN 'I' #商品屬性-其它屬性七
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2012' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang   
       WHEN 'J' #商品屬性-其它屬性八
           SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2013' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang           
      
       WHEN 'K' #商品屬性-其它屬性九
           SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang   

       WHEN 'L' #商品屬性-其它屬性十
          SELECT oocql004 INTO l_mmcg004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = p_mmcg004 AND oocql003 = g_dlang 
           
       WHEN 'U'
         #庫區類別
           SELECT gzcbl004 INTO l_mmcg004_desc FROM gzcbl_t 
            WHERE gzcbl001 = '6200' AND gzcbl002 = p_mmcg004 AND gzcbl003 =  g_dlang 
       WHEN 'V' 
         #庫區品類 
           SELECT rtaxl003 INTO l_mmcg004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = p_mmcg004 AND rtaxl002 = g_dlang 
    END CASE 
    RETURN  l_mmcg004_desc   
END FUNCTION
#+
PUBLIC FUNCTION ammm356_set_required_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1

   IF g_mmcg3_d[l_ac].mmch005 = 'Y' THEN
      CALL cl_set_comp_required("mmch006",TRUE)
   END IF
   IF g_mmcg3_d[l_ac].mmch007 = '3' THEN
      CALL cl_set_comp_required("mmch008,mmch009",TRUE)
   END IF
END FUNCTION
#+
PUBLIC FUNCTION ammm356_set_no_required_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1

END FUNCTION
#+
PUBLIC FUNCTION ammm356_mmch004_chk(p_mmch004)
DEFINE p_mmch004   LIKE mmch_t.mmch004

DEFINE l_oocqstus LIKE oocq_t.oocqstus
DEFINE l_ooiastus LIKE ooia_t.ooiastus
DEFINE l_imaastus LIKE imaa_t.imaastus
DEFINE l_rtaxstus LIKE rtax_t.rtaxstus
DEFINE l_rtax005  LIKE rtax_t.rtax005
DEFINE l_n        LIKE type_t.num5
DEFINE l_ooeastus LIKE ooea_t.ooeastus
DEFINE l_inaastus LIKE inaa_t.inaastus

    CASE g_mmcg3_d[l_ac].mmch003
       WHEN  '1'
          #會員等級
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2024' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00076'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00077'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  '2' 
          #會員類型
          
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2025' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00074'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00075'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '3'
          #款別類型
          
          SELECT ooiastus INTO l_ooiastus FROM ooia_t WHERE ooiaent = g_enterprise AND ooia001 = p_mmch004
          IF STATUS = 100 OR cl_null(l_ooiastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aoo-00195'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_ooiastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod 'aoo-00196'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aooi713'
                LET g_errparam.replace[2] = cl_get_progname('aooi713',g_lang,"2")
                LET g_errparam.exeprog    ='aooi713'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '4'
          #商品編號
          SELECT imaastus INTO l_imaastus FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_mmch004
           IF STATUS = 100 OR cl_null(l_imaastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00016'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_imaastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod 'art-00050'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aimm200'
                LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                LET g_errparam.exeprog    ='aimm200'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '5'
          #商品分類
           SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmch004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '6'
          #商品屬性-產地分類
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2000' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00077'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00078'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
          
       WHEN  '7'
          #商品屬性-價格帶
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2001' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00079'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00080'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '8'
          #商品屬性-品牌
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2002' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00081'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00082'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '9'
          #商品屬性-系列
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2003' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00083'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00084'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'A'
          #商品屬性-型別
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2004' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00085'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00086'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'B'
          #商品屬性-功能
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2005' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00087'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00088'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'C'
          #商品屬性-其它屬性一
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2006' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00089'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00090'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'D'
          #商品屬性-其它屬性二
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2007' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00091'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00092'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'E'
          #商品屬性-其它屬性三
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2008' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00093'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00094'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'F'
          #商品屬性-其它屬性四
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2009' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00095'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00096'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'G'
          #商品屬性-其它屬性五
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2010' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00097'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00098'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'H'
          #商品屬性-其它屬性六
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2011' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00099'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00100'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'I'
          #商品屬性-其它屬性七
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2012' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00101'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00102'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'J'
          #商品屬性-其它屬性八
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2013' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00103'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00104'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'K'
          #商品屬性-其它屬性九
            SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2014' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00105'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00106'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'L'
          #商品屬性-其它屬性十
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2015' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00107'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00108'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN 'Q'
         #紀念日
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2050' AND oocq002 = p_mmch004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00121'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = '2050'
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00117'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN 'R'
         #促銷活動檔期
       WHEN 'S'
         #營運據點
         SELECT ooeastus INTO l_ooeastus FROM ooea_t 
          WHERE ooeaent = g_enterprise AND ooea001 =p_mmch004   AND ooea004 = 'Y'
         IF status = 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aoo-00163'
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            RETURN FALSE
         END IF  
         IF l_ooeastus = 'N' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aoo-00012'
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            RETURN FALSE
         END IF
         RETURN TRUE    
         
       WHEN 'T'
         #庫位編號
         SELECT inaastus INTO l_inaastus FROM inaa_t
          WHERE inaaent = g_enterprise AND inaa001 = p_mmch004 AND inaasite = g_site
         IF status = 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00087'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         ELSE
            IF l_inaastus = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00088'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN FALSE
            END IF
         END IF
         RETURN TRUE
       WHEN 'U'
         #庫區類別
         SELECT COUNT(*) INTO l_n FROM gzcb_t WHERE gzcb001 = '6200' AND gzcb002 = p_mmch004
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00114'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
         RETURN TRUE
       WHEN 'V' 
         #庫區品類(层级未添加）
          SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmch004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
         
         
    END CASE
    RETURN TRUE
END FUNCTION
#+
PUBLIC FUNCTION ammm356_mmch004_ref(p_mmch003,p_mmch004)
DEFINE p_mmch003  LIKE mmch_t.mmch003
DEFINE p_mmch004  LIKE mmch_t.mmch004
DEFINE l_mmch004_desc LIKE type_t.chr80

   CASE p_mmch003
       WHEN  '1' #會員等級
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2024' AND oocql002 = p_mmch004 AND oocql003 = g_dlang
            
       WHEN  '2' #會員類型
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2025' AND oocql002 = p_mmch004 AND oocql003 = g_dlang
       
       WHEN  '3' #款別類型
          SELECT ooial003 INTO l_mmch004_desc FROM ooial_t
           WHERE ooialent = g_enterprise AND ooial001 =  p_mmch004 AND ooial002 = g_dlang
       
       WHEN '4' #商品編號
          SELECT imaal003 INTO l_mmch004_desc FROM imaal_t
           WHERE imaalent = g_enterprise AND imaal001 = p_mmch004 AND imaal002 = g_dlang
           
       WHEN '5' #商品分類
           SELECT rtaxl003 INTO l_mmch004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = p_mmch004 AND rtaxl002 = g_dlang 

       WHEN '6' #商品屬性-產地分類
           SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2000' AND oocql002 = p_mmch004 AND oocql003 = g_dlang
           
       WHEN '7' #商品屬性-價格帶
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2001' AND oocql002 = p_mmch004 AND oocql003 = g_dlang
           
       WHEN '8' #商品屬性-品牌
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2002' AND oocql002 = p_mmch004 AND oocql003 = g_dlang  

       WHEN '9' #商品屬性-系列
           SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2003' AND oocql002 = p_mmch004 AND oocql003 = g_dlang   

       WHEN 'A' #商品屬性-型別
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2004' AND oocql002 = p_mmch004 AND oocql003 = g_dlang 

       WHEN 'B' #商品屬性-功能
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2005' AND oocql002 = p_mmch004 AND oocql003 = g_dlang 
       
       WHEN 'C' #商品屬性-其它屬性一
         SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2006' AND oocql002 = p_mmch004 AND oocql003 = g_dlang  

       WHEN 'D' #商品屬性-其它屬性二
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2007' AND oocql002 = p_mmch004 AND oocql003 = g_dlang  
   
       WHEN 'E' #商品屬性-其它屬性三
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2008' AND oocql002 = p_mmch004 AND oocql003 = g_dlang  
       WHEN 'F' #商品屬性-其它屬性四
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2009' AND oocql002 = p_mmch004 AND oocql003 = g_dlang  
       WHEN 'G' #商品屬性-其它屬性五
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2010' AND oocql002 = p_mmch004 AND oocql003 = g_dlang  
        
       WHEN 'H' #商品屬性-其它屬性六
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2011' AND oocql002 = p_mmch004 AND oocql003 = g_dlang  
           
       WHEN 'I' #商品屬性-其它屬性七
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2012' AND oocql002 = p_mmch004 AND oocql003 = g_dlang   
       WHEN 'J' #商品屬性-其它屬性八
           SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2013' AND oocql002 = p_mmch004 AND oocql003 = g_dlang           
      
       WHEN 'K' #商品屬性-其它屬性九
           SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = p_mmch004 AND oocql003 = g_dlang   

       WHEN 'L' #商品屬性-其它屬性十
          SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = p_mmch004 AND oocql003 = g_dlang 
       
       WHEN 'Q' #紀念日
           SELECT oocql004 INTO l_mmch004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2050' AND oocql002 = p_mmch004 AND oocql003 = g_dlang 
           
       WHEN 'R' #促銷活動檔期
       
       WHEN 'S' #營運據點
           SELECT ooefl003 INTO l_mmch004_desc FROM ooefl_t
            WHERE ooeflent = g_enterprise AND ooefl001 = p_mmch004 AND ooefl002 = g_dlang
        
       WHEN 'T' #庫位編號
           SELECT inaa003 INTO l_mmch004_desc FROM inaa_t
            WHERE inaaent = g_enterprise AND inaa001 = p_mmch004 AND inaasite = g_site
       WHEN 'U'
         #庫區類別
           SELECT gzcbl004 INTO  l_mmch004_desc FROM gzcbl_t 
            WHERE gzcbl001 = '6200' AND gzcbl002 = p_mmch004 AND gzcbl003 =  g_dlang 
       WHEN 'V' 
         #庫區品類 
           SELECT rtaxl003 INTO l_mmch004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = p_mmch004 AND rtaxl002 = g_dlang 
    END CASE
    RETURN  l_mmch004_desc   
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
PUBLIC FUNCTION ammm356_mmbtunit_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbt_m.mmbtunit
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbt_m.mmbtunit_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmbt_m.mmbtunit_desc
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
PUBLIC FUNCTION ammm356_mmbx004_ref()
   LET g_mmcg2_d_t.mmbx004 = g_mmcg2_d[l_ac].mmbx004
   LET g_ref_fields[1] = g_mmcg2_d[l_ac].mmbx004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmcg2_d[l_ac].mmbx004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmcg2_d[l_ac].mmbx004_desc
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
PRIVATE FUNCTION ammm356_mmbt005_ref()
   #160729-00077#6 20160817 add by beckxie---S
   LET g_mmbt_m.mmbt005_desc = ''
   
   IF g_mmbt_m.mmbt019='1' THEN #卡种
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbt_m.mmbt005
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbt_m.mmbt005_desc
   END IF
   IF g_mmbt_m.mmbt019='2' THEN #会员等级
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbt_m.mmbt005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbt_m.mmbt005_desc
   END IF
   IF g_mmbt_m.mmbt019='11' THEN #其他類型一
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbt_m.mmbt005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2026' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbt_m.mmbt005_desc
   END IF
   IF g_mmbt_m.mmbt019='12' THEN #其他類型二
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbt_m.mmbt005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2027' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbt_m.mmbt005_desc
   END IF
   IF g_mmbt_m.mmbt019='13' THEN #其他類型三
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbt_m.mmbt005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2028' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbt_m.mmbt005_desc
   END IF
   IF g_mmbt_m.mmbt019='14' THEN #其他類型四
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbt_m.mmbt005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2029' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbt_m.mmbt005_desc
   END IF
   IF g_mmbt_m.mmbt019='15' THEN #其他類型五
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbt_m.mmbt005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2030' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbt_m.mmbt005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbt_m.mmbt005_desc
   END IF
   #160729-00077#6 20160817 add by beckxie---E
END FUNCTION

 
{</section>}
 
