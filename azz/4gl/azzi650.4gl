#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi650.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-05-25 15:27:43), PR版次:0011(2016-03-31 14:16:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000574
#+ Filename...: azzi650
#+ Description: 應用分類碼維護作業(ACC)
#+ Creator....: 00845(2013-06-01 00:00:00)
#+ Modifier...: 01856 -SD/PR- 07959
 
{</section>}
 
{<section id="azzi650.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...: No.160318-00005#55  2016/3/31   pengxin  修正azzi902重复定义之错误讯息
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
PRIVATE type type_g_gzaa_m        RECORD
       gzaa004 LIKE gzaa_t.gzaa004, 
   gzaa001 LIKE gzaa_t.gzaa001, 
   gzaal003 LIKE gzaal_t.gzaal003, 
   gzaal004 LIKE gzaal_t.gzaal004, 
   gzaa002 LIKE gzaa_t.gzaa002, 
   gzaa003 LIKE gzaa_t.gzaa003, 
   gzaa005 LIKE gzaa_t.gzaa005, 
   gzzz001 LIKE gzzz_t.gzzz001, 
   gzzal003 LIKE gzzal_t.gzzal003, 
   gzaastus LIKE gzaa_t.gzaastus, 
   gzaaownid LIKE gzaa_t.gzaaownid, 
   gzaaownid_desc LIKE type_t.chr80, 
   gzaaowndp LIKE gzaa_t.gzaaowndp, 
   gzaaowndp_desc LIKE type_t.chr80, 
   gzaacrtid LIKE gzaa_t.gzaacrtid, 
   gzaacrtid_desc LIKE type_t.chr80, 
   gzaacrtdp LIKE gzaa_t.gzaacrtdp, 
   gzaacrtdp_desc LIKE type_t.chr80, 
   gzaacrtdt LIKE gzaa_t.gzaacrtdt, 
   gzaamodid LIKE gzaa_t.gzaamodid, 
   gzaamodid_desc LIKE type_t.chr80, 
   gzaamoddt LIKE gzaa_t.gzaamoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzac_d        RECORD
       gzac002 LIKE gzac_t.gzac002, 
   gzac023 LIKE gzac_t.gzac023, 
   gzac024 LIKE gzac_t.gzac024, 
   gzac003 LIKE gzac_t.gzac003, 
   gzac004 LIKE gzac_t.gzac004, 
   gzac005 LIKE gzac_t.gzac005, 
   gzac006 LIKE gzac_t.gzac006, 
   gzac007 LIKE gzac_t.gzac007, 
   gzac008 LIKE gzac_t.gzac008, 
   gzac009 LIKE gzac_t.gzac009, 
   gzac010 LIKE gzac_t.gzac010, 
   gzac011 LIKE gzac_t.gzac011, 
   gzac012 LIKE gzac_t.gzac012, 
   gzac013 LIKE gzac_t.gzac013, 
   gzac014 LIKE gzac_t.gzac014, 
   gzac015 LIKE gzac_t.gzac015, 
   gzac016 LIKE gzac_t.gzac016, 
   gzac017 LIKE gzac_t.gzac017, 
   gzac018 LIKE gzac_t.gzac018, 
   gzac019 LIKE gzac_t.gzac019, 
   gzac020 LIKE gzac_t.gzac020, 
   gzac021 LIKE gzac_t.gzac021, 
   gzac022 LIKE gzac_t.gzac022
       END RECORD
PRIVATE TYPE type_g_gzac2_d RECORD
       gzad002 LIKE gzad_t.gzad002, 
   gzad002_desc LIKE type_t.chr500, 
   l_ref_style LIKE type_t.chr500, 
   gzad003 LIKE gzad_t.gzad003, 
   gzad004 LIKE gzad_t.gzad004, 
   gzad005 LIKE gzad_t.gzad005, 
   gzad006 LIKE gzad_t.gzad006, 
   gzad006_desc LIKE type_t.chr500, 
   gzad007 LIKE gzad_t.gzad007, 
   gzad008 LIKE gzad_t.gzad008, 
   gzad015 LIKE gzad_t.gzad015, 
   gzad016 LIKE gzad_t.gzad016, 
   gzad017 LIKE gzad_t.gzad017, 
   gzad009 LIKE gzad_t.gzad009, 
   gzad014 LIKE gzad_t.gzad014, 
   gzad010 LIKE gzad_t.gzad010, 
   gzad011 LIKE gzad_t.gzad011, 
   gzad012 LIKE gzad_t.gzad012, 
   gzad013 LIKE gzad_t.gzad013
       END RECORD
PRIVATE TYPE type_g_gzac3_d RECORD
       gzai002 LIKE gzai_t.gzai002, 
   gzai003 LIKE gzai_t.gzai003, 
   gzai004 LIKE gzai_t.gzai004, 
   gzai005 LIKE gzai_t.gzai005, 
   gzai006 LIKE gzai_t.gzai006, 
   gzai007 LIKE gzai_t.gzai007, 
   gzai008 LIKE gzai_t.gzai008, 
   gzai009 LIKE gzai_t.gzai009, 
   gzai010 LIKE gzai_t.gzai010, 
   gzai011 LIKE gzai_t.gzai011, 
   gzai012 LIKE gzai_t.gzai012, 
   gzai013 LIKE gzai_t.gzai013, 
   gzai014 LIKE gzai_t.gzai014, 
   gzai015 LIKE gzai_t.gzai015, 
   gzai016 LIKE gzai_t.gzai016, 
   gzai017 LIKE gzai_t.gzai017, 
   gzai018 LIKE gzai_t.gzai018, 
   gzai019 LIKE gzai_t.gzai019, 
   gzai020 LIKE gzai_t.gzai020, 
   gzai021 LIKE gzai_t.gzai021, 
   gzai022 LIKE gzai_t.gzai022
       END RECORD
PRIVATE TYPE type_g_gzac4_d RECORD
       gzaj002 LIKE gzaj_t.gzaj002, 
   gzaj002_desc LIKE type_t.chr500, 
   l_cref_style LIKE type_t.chr500, 
   gzaj003 LIKE gzaj_t.gzaj003, 
   gzaj004 LIKE gzaj_t.gzaj004, 
   gzaj005 LIKE gzaj_t.gzaj005, 
   gzaj006 LIKE gzaj_t.gzaj006, 
   gzaj006_desc LIKE type_t.chr500, 
   gzaj007 LIKE gzaj_t.gzaj007, 
   gzaj008 LIKE gzaj_t.gzaj008, 
   gzaj015 LIKE gzaj_t.gzaj015, 
   gzaj016 LIKE gzaj_t.gzaj016, 
   gzaj017 LIKE gzaj_t.gzaj017, 
   gzaj009 LIKE gzaj_t.gzaj009, 
   gzaj014 LIKE gzaj_t.gzaj014, 
   gzaj010 LIKE gzaj_t.gzaj010, 
   gzaj011 LIKE gzaj_t.gzaj011, 
   gzaj012 LIKE gzaj_t.gzaj012, 
   gzaj013 LIKE gzaj_t.gzaj013
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_gzaa001 LIKE gzaa_t.gzaa001,
   b_gzaa001_desc LIKE type_t.chr80,
      b_gzaa002 LIKE gzaa_t.gzaa002,
      b_gzaa003 LIKE gzaa_t.gzaa003,
   b_gzzz001 LIKE gzzz_t.gzzz001,
   b_gzzz001_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_dgenv               LIKE type_t.chr1              #客製標示:s-標準, c-客製
DEFINE g_chk_azzi650         LIKE type_t.chr5              #判斷gzad單身有沒有異動
#end add-point
       
#模組變數(Module Variables)
DEFINE g_gzaa_m          type_g_gzaa_m
DEFINE g_gzaa_m_t        type_g_gzaa_m
DEFINE g_gzaa_m_o        type_g_gzaa_m
DEFINE g_gzaa_m_mask_o   type_g_gzaa_m #轉換遮罩前資料
DEFINE g_gzaa_m_mask_n   type_g_gzaa_m #轉換遮罩後資料
 
   DEFINE g_gzaa001_t LIKE gzaa_t.gzaa001
 
 
DEFINE g_gzac_d          DYNAMIC ARRAY OF type_g_gzac_d
DEFINE g_gzac_d_t        type_g_gzac_d
DEFINE g_gzac_d_o        type_g_gzac_d
DEFINE g_gzac_d_mask_o   DYNAMIC ARRAY OF type_g_gzac_d #轉換遮罩前資料
DEFINE g_gzac_d_mask_n   DYNAMIC ARRAY OF type_g_gzac_d #轉換遮罩後資料
DEFINE g_gzac2_d          DYNAMIC ARRAY OF type_g_gzac2_d
DEFINE g_gzac2_d_t        type_g_gzac2_d
DEFINE g_gzac2_d_o        type_g_gzac2_d
DEFINE g_gzac2_d_mask_o   DYNAMIC ARRAY OF type_g_gzac2_d #轉換遮罩前資料
DEFINE g_gzac2_d_mask_n   DYNAMIC ARRAY OF type_g_gzac2_d #轉換遮罩後資料
DEFINE g_gzac3_d          DYNAMIC ARRAY OF type_g_gzac3_d
DEFINE g_gzac3_d_t        type_g_gzac3_d
DEFINE g_gzac3_d_o        type_g_gzac3_d
DEFINE g_gzac3_d_mask_o   DYNAMIC ARRAY OF type_g_gzac3_d #轉換遮罩前資料
DEFINE g_gzac3_d_mask_n   DYNAMIC ARRAY OF type_g_gzac3_d #轉換遮罩後資料
DEFINE g_gzac4_d          DYNAMIC ARRAY OF type_g_gzac4_d
DEFINE g_gzac4_d_t        type_g_gzac4_d
DEFINE g_gzac4_d_o        type_g_gzac4_d
DEFINE g_gzac4_d_mask_o   DYNAMIC ARRAY OF type_g_gzac4_d #轉換遮罩前資料
DEFINE g_gzac4_d_mask_n   DYNAMIC ARRAY OF type_g_gzac4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      gzaal001 LIKE gzaal_t.gzaal001,
      gzaal003 LIKE gzaal_t.gzaal003,
      gzaal004 LIKE gzaal_t.gzaal004
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
 
{<section id="azzi650.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT gzaa004,gzaa001,'','',gzaa002,gzaa003,gzaa005,'','',gzaastus,gzaaownid, 
       '',gzaaowndp,'',gzaacrtid,'',gzaacrtdp,'',gzaacrtdt,gzaamodid,'',gzaamoddt", 
                      " FROM gzaa_t",
                      " WHERE gzaa001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi650_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gzaa004,t0.gzaa001,t0.gzaa002,t0.gzaa003,t0.gzaa005,t0.gzaastus, 
       t0.gzaaownid,t0.gzaaowndp,t0.gzaacrtid,t0.gzaacrtdp,t0.gzaacrtdt,t0.gzaamodid,t0.gzaamoddt,t1.ooag011 , 
       t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011",
               " FROM gzaa_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.gzaaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.gzaaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gzaacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.gzaacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.gzaamodid  ",
 
               " WHERE  t0.gzaa001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzi650_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi650 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi650_init()   
 
      #進入選單 Menu (="N")
      CALL azzi650_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi650
      
   END IF 
   
   CLOSE azzi650_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi650.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi650_init()
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('gzaastus','17','N,Y')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   IF cl_null(g_dgenv) THEN
      LET g_dgenv = FGL_GETENV("DGENV")     #"s":標準; "c":客製
   END IF
   IF g_dgenv = 's' THEN 
      CALL cl_set_comp_visible("page_4,page_5",FALSE) 
   END IF
   CALL azzi650_gzac002_comb() 
   CALL cl_set_combo_scc('gzaa004','18')
   
   LET g_chk_azzi650 = FALSE
   #end add-point
   
   #初始化搜尋條件
   CALL azzi650_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi650.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi650_ui_dialog()
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
            CALL azzi650_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL cl_set_combo_scc('gzad005','33')
   CALL cl_set_combo_scc('gzad009','34')
   CALL cl_set_combo_scc_part("gzad012",35,"<,<=")
   CALL cl_set_combo_scc_part("gzad010",35,">,>=")
   CALL cl_set_combo_scc('gzaj005','33')
   CALL cl_set_combo_scc('gzaj009','34')
   CALL cl_set_combo_scc_part("gzaj012",35,"<,<=")
   CALL cl_set_combo_scc_part("gzaj010",35,">,>=")   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gzaa_m.* TO NULL
         CALL g_gzac_d.clear()
         CALL g_gzac2_d.clear()
         CALL g_gzac3_d.clear()
         CALL g_gzac4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL azzi650_init()
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
               
               CALL azzi650_fetch('') # reload data
               LET l_ac = 1
               CALL azzi650_ui_detailshow() #Setting the current row 
         
               CALL azzi650_idx_chk()
               #NEXT FIELD gzac002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_gzac_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi650_idx_chk()
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
               CALL azzi650_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_gzac2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi650_idx_chk()
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
               CALL azzi650_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_gzac3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi650_idx_chk()
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
               CALL azzi650_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_gzac4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi650_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL azzi650_idx_chk()
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
            CALL azzi650_browser_fill("")
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
               CALL azzi650_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi650_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL azzi650_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL azzi650_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL azzi650_set_act_visible()   
            CALL azzi650_set_act_no_visible()
            IF NOT (g_gzaa_m.gzaa001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " ",
                                  " gzaa001 = '", g_gzaa_m.gzaa001, "' "
 
               #填到對應位置
               CALL azzi650_browser_fill("")
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
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "gzaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzac_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzad_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gzai_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gzaj_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
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
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL azzi650_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "gzaa_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzac_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzad_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gzai_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "gzaj_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
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
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL azzi650_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL azzi650_fetch("F")
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
               CALL azzi650_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL azzi650_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi650_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL azzi650_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi650_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL azzi650_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi650_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL azzi650_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi650_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL azzi650_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi650_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gzac_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_gzac2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_gzac3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_gzac4_d)
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
               NEXT FIELD gzac002
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
               CALL azzi650_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi650_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi650_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #每次異動都要重新產生q_azzi650.4gl 動態開窗
               CALL azzi650_gen_q_azzi650()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi650_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_azzi910
            LET g_action_choice="open_azzi910"
            IF cl_auth_chk_act("open_azzi910") THEN
               
               #add-point:ON ACTION open_azzi910 name="menu.open_azzi910"
               CALL azzi650_open_azzi910()
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
               CALL azzi650_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi650_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION app_cc
            LET g_action_choice="app_cc"
            IF cl_auth_chk_act("app_cc") THEN
               
               #add-point:ON ACTION app_cc name="menu.app_cc"
               CALL azzi650_app_cc()
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL azzi650_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi650_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi650_set_pk_array()
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
 
{<section id="azzi650.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi650_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE lc_gzzz004        LIKE gzzz_t.gzzz004

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
      LET l_sub_sql = " SELECT DISTINCT gzaa001 ",
                      " FROM gzaa_t ",
                      " ",
                      " LEFT JOIN gzac_t ON gzaa001 = gzac001 ", "  ",
                      #add-point:browser_fill段sql(gzac_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN gzad_t ON gzaa001 = gzad001", "  ",
                      #add-point:browser_fill段sql(gzad_t1) name="browser_fill.cnt.join.gzad_t1"
                      
                      #end add-point
 
                      " LEFT JOIN gzai_t ON gzaa001 = gzai001", "  ",
                      #add-point:browser_fill段sql(gzai_t1) name="browser_fill.cnt.join.gzai_t1"
                      
                      #end add-point
 
                      " LEFT JOIN gzaj_t ON gzaa001 = gzaj001", "  ",
                      #add-point:browser_fill段sql(gzaj_t1) name="browser_fill.cnt.join.gzaj_t1"
                     #160217-00004#1 add str 
                      " LEFT JOIN gzzz_t ON (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')",
                      "                 AND gzzz004='\"'||gzaa001||'\"'",
                      " LEFT JOIN gzzal_t ON gzzz001=gzzal001 AND gzzal002='",g_dlang,"'",
                     #160217-00004#1 add end
                      #end add-point
 
 
 
                      " LEFT JOIN gzaal_t ON gzaa001 = gzaal001 AND gzaal002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE   ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzaa_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gzaa001 ",
                      " FROM gzaa_t ", 
                      "  ",
                      "  LEFT JOIN gzaal_t ON gzaa001 = gzaal001 AND gzaal002 = '",g_dlang,"' ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzaa_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
  #160217-00004#1 add str 
   IF g_wc2 = " 1=1" THEN
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gzaa001 ",
                      " FROM gzaa_t ", 
                      "  ",
                      " LEFT JOIN gzzz_t ON (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')",
                      "                 AND gzzz004='\"'||gzaa001||'\"'",
                      " LEFT JOIN gzzal_t ON gzzz001=gzzal001 AND gzzal002='",g_dlang,"'",
                      "  LEFT JOIN gzaal_t ON gzaa001 = gzaal001 AND gzaal002 = '",g_dlang,"' ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzaa_t")
   END IF
  #160217-00004#1 add end
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
      INITIALIZE g_gzaa_m.* TO NULL
      CALL g_gzac_d.clear()        
      CALL g_gzac2_d.clear() 
      CALL g_gzac3_d.clear() 
      CALL g_gzac4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gzaa001,t0.gzaa002,t0.gzaa003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gzaastus,t0.gzaa001,t0.gzaa002,t0.gzaa003,t1.gzaal003 ",
                  " FROM gzaa_t t0",
                  "  ",
                  "  LEFT JOIN gzac_t ON gzaa001 = gzac001 ", "  ", 
                  #add-point:browser_fill段sql(gzac_t1) name="browser_fill.join.gzac_t1"
                  
                  #end add-point
                  "  LEFT JOIN gzad_t ON gzaa001 = gzad001", "  ", 
                  #add-point:browser_fill段sql(gzad_t1) name="browser_fill.join.gzad_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN gzai_t ON gzaa001 = gzai001", "  ", 
                  #add-point:browser_fill段sql(gzai_t1) name="browser_fill.join.gzai_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN gzaj_t ON gzaa001 = gzaj001", "  ", 
                  #add-point:browser_fill段sql(gzaj_t1) name="browser_fill.join.gzaj_t1"
                 #160217-00004#1 add str 
                  " LEFT JOIN gzzz_t ON (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')",
                  "                 AND gzzz004='\"'||gzaa001||'\"'",
                  " LEFT JOIN gzzal_t ON gzzz001=gzzal001 AND gzzal002='",g_dlang,"'",
                 #160217-00004#1 add end
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN gzaal_t t1 ON t1.gzaal001=t0.gzaa001 AND t1.gzaal002='"||g_lang||"' ",
 
                  " WHERE  ",l_wc," AND ",l_wc2, cl_sql_add_filter("gzaa_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gzaastus,t0.gzaa001,t0.gzaa002,t0.gzaa003,t1.gzaal003 ",
                  " FROM gzaa_t t0",
                  "  ",
                                 " LEFT JOIN gzaal_t t1 ON t1.gzaal001=t0.gzaa001 AND t1.gzaal002='"||g_lang||"' ",
 
                  " WHERE  ",l_wc, cl_sql_add_filter("gzaa_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
  #160217-00004#1 add str 
   IF g_wc2 = " 1=1" THEN
      #單身未輸入搜尋條件
      LET g_sql = " SELECT DISTINCT t0.gzaastus,t0.gzaa001,t0.gzaa002,t0.gzaa003,t1.gzaal003 ",
                  " FROM gzaa_t t0",
                  "  ",
                  " LEFT JOIN gzzz_t ON (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')",
                  "                 AND gzzz004='\"'||gzaa001||'\"'",
                  " LEFT JOIN gzzal_t ON gzzz001=gzzal001 AND gzzal002='",g_dlang,"'",
                                 " LEFT JOIN gzaal_t t1 ON t1.gzaal001=t0.gzaa001 AND t1.gzaal002='"||g_lang||"' ",
 
                  " WHERE  ",l_wc, cl_sql_add_filter("gzaa_t")
   END IF
  #160217-00004#1 add end
   #end add-point
   LET g_sql = g_sql, " ORDER BY gzaa001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzaa_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzaa001,g_browser[g_cnt].b_gzaa002, 
          g_browser[g_cnt].b_gzaa003,g_browser[g_cnt].b_gzaa001_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
     #LET lc_gzzz004 = g_browser[g_cnt].b_gzaa001 
      CALL s_chr_add_quotes(g_browser[g_cnt].b_gzaa001) RETURNING lc_gzzz004
      SELECT gzzz001 INTO g_browser[g_cnt].b_gzzz001
        FROM gzzz_t
       WHERE (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')
         AND gzzz004=lc_gzzz004
      DISPLAY BY NAME g_browser[g_cnt].b_gzzz001
      SELECT gzzal003 INTO g_browser[g_cnt].b_gzzz001_desc
        FROM gzzal_t
       WHERE gzzal001=g_browser[g_cnt].b_gzzz001
         AND gzzal002=g_dlang 
      DISPLAY BY NAME g_browser[g_cnt].b_gzzz001_desc
         #end add-point
      
         #遮罩相關處理
         CALL azzi650_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_gzaa001) THEN
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
 
{<section id="azzi650.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi650_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gzaa_m.gzaa001 = g_browser[g_current_idx].b_gzaa001   
 
   EXECUTE azzi650_master_referesh USING g_gzaa_m.gzaa001 INTO g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaacrtid, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt,g_gzaa_m.gzaaownid_desc, 
       g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid_desc,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaamodid_desc 
 
   
   CALL azzi650_gzaa_t_mask()
   CALL azzi650_show()
      
END FUNCTION
 
{</section>}
 
{<section id="azzi650.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi650_ui_detailshow()
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
 
{<section id="azzi650.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi650_ui_browser_refresh()
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
      IF g_browser[l_i].b_gzaa001 = g_gzaa_m.gzaa001 
 
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
 
{<section id="azzi650.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi650_construct()
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
   INITIALIZE g_gzaa_m.* TO NULL
   CALL g_gzac_d.clear()        
   CALL g_gzac2_d.clear() 
   CALL g_gzac3_d.clear() 
   CALL g_gzac4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON gzaa004,gzaa001,gzaal003,gzaal004,gzaa002,gzaa003,gzaa005,gzzz001,gzzal003, 
          gzaastus,gzaaownid,gzaaowndp,gzaacrtid,gzaacrtdp,gzaacrtdt,gzaamodid,gzaamoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzaacrtdt>>----
         AFTER FIELD gzaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzaamoddt>>----
         AFTER FIELD gzaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzaacnfdt>>----
         
         #----<<gzaapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa004
            #add-point:BEFORE FIELD gzaa004 name="construct.b.gzaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa004
            
            #add-point:AFTER FIELD gzaa004 name="construct.a.gzaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa004
            #add-point:ON ACTION controlp INFIELD gzaa004 name="construct.c.gzaa004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa001
            #add-point:ON ACTION controlp INFIELD gzaa001 name="construct.c.gzaa001"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_gzaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaa001  #顯示到畫面上

            NEXT FIELD gzaa001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa001
            #add-point:BEFORE FIELD gzaa001 name="construct.b.gzaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa001
            
            #add-point:AFTER FIELD gzaa001 name="construct.a.gzaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaal003
            #add-point:BEFORE FIELD gzaal003 name="construct.b.gzaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaal003
            
            #add-point:AFTER FIELD gzaal003 name="construct.a.gzaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaal003
            #add-point:ON ACTION controlp INFIELD gzaal003 name="construct.c.gzaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaal004
            #add-point:BEFORE FIELD gzaal004 name="construct.b.gzaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaal004
            
            #add-point:AFTER FIELD gzaal004 name="construct.a.gzaal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaal004
            #add-point:ON ACTION controlp INFIELD gzaal004 name="construct.c.gzaal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa002
            #add-point:BEFORE FIELD gzaa002 name="construct.b.gzaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa002
            
            #add-point:AFTER FIELD gzaa002 name="construct.a.gzaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa002
            #add-point:ON ACTION controlp INFIELD gzaa002 name="construct.c.gzaa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa003
            #add-point:BEFORE FIELD gzaa003 name="construct.b.gzaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa003
            
            #add-point:AFTER FIELD gzaa003 name="construct.a.gzaa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa003
            #add-point:ON ACTION controlp INFIELD gzaa003 name="construct.c.gzaa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa005
            #add-point:BEFORE FIELD gzaa005 name="construct.b.gzaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa005
            
            #add-point:AFTER FIELD gzaa005 name="construct.a.gzaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa005
            #add-point:ON ACTION controlp INFIELD gzaa005 name="construct.c.gzaa005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzz001
            #add-point:BEFORE FIELD gzzz001 name="construct.b.gzzz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzz001
            
            #add-point:AFTER FIELD gzzz001 name="construct.a.gzzz001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzzz001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzz001
            #add-point:ON ACTION controlp INFIELD gzzz001 name="construct.c.gzzz001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzal003
            #add-point:BEFORE FIELD gzzal003 name="construct.b.gzzal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzal003
            
            #add-point:AFTER FIELD gzzal003 name="construct.a.gzzal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzzal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzal003
            #add-point:ON ACTION controlp INFIELD gzzal003 name="construct.c.gzzal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaastus
            #add-point:BEFORE FIELD gzaastus name="construct.b.gzaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaastus
            
            #add-point:AFTER FIELD gzaastus name="construct.a.gzaastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaastus
            #add-point:ON ACTION controlp INFIELD gzaastus name="construct.c.gzaastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaaownid
            #add-point:ON ACTION controlp INFIELD gzaaownid name="construct.c.gzaaownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaaownid  #顯示到畫面上

            NEXT FIELD gzaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaaownid
            #add-point:BEFORE FIELD gzaaownid name="construct.b.gzaaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaaownid
            
            #add-point:AFTER FIELD gzaaownid name="construct.a.gzaaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaaowndp
            #add-point:ON ACTION controlp INFIELD gzaaowndp name="construct.c.gzaaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaaowndp  #顯示到畫面上

            NEXT FIELD gzaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaaowndp
            #add-point:BEFORE FIELD gzaaowndp name="construct.b.gzaaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaaowndp
            
            #add-point:AFTER FIELD gzaaowndp name="construct.a.gzaaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaacrtid
            #add-point:ON ACTION controlp INFIELD gzaacrtid name="construct.c.gzaacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaacrtid  #顯示到畫面上

            NEXT FIELD gzaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaacrtid
            #add-point:BEFORE FIELD gzaacrtid name="construct.b.gzaacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaacrtid
            
            #add-point:AFTER FIELD gzaacrtid name="construct.a.gzaacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaacrtdp
            #add-point:ON ACTION controlp INFIELD gzaacrtdp name="construct.c.gzaacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaacrtdp  #顯示到畫面上

            NEXT FIELD gzaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaacrtdp
            #add-point:BEFORE FIELD gzaacrtdp name="construct.b.gzaacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaacrtdp
            
            #add-point:AFTER FIELD gzaacrtdp name="construct.a.gzaacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaacrtdt
            #add-point:BEFORE FIELD gzaacrtdt name="construct.b.gzaacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaamodid
            #add-point:ON ACTION controlp INFIELD gzaamodid name="construct.c.gzaamodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaamodid  #顯示到畫面上

            NEXT FIELD gzaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaamodid
            #add-point:BEFORE FIELD gzaamodid name="construct.b.gzaamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaamodid
            
            #add-point:AFTER FIELD gzaamodid name="construct.a.gzaamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaamoddt
            #add-point:BEFORE FIELD gzaamoddt name="construct.b.gzaamoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gzac002,gzac023,gzac024,gzac003,gzac004,gzac005,gzac006,gzac007,gzac008, 
          gzac009,gzac010,gzac011,gzac012,gzac013,gzac014,gzac015,gzac016,gzac017,gzac018,gzac019,gzac020, 
          gzac021,gzac022
           FROM s_detail1[1].gzac002,s_detail1[1].gzac023,s_detail1[1].gzac024,s_detail1[1].gzac003, 
               s_detail1[1].gzac004,s_detail1[1].gzac005,s_detail1[1].gzac006,s_detail1[1].gzac007,s_detail1[1].gzac008, 
               s_detail1[1].gzac009,s_detail1[1].gzac010,s_detail1[1].gzac011,s_detail1[1].gzac012,s_detail1[1].gzac013, 
               s_detail1[1].gzac014,s_detail1[1].gzac015,s_detail1[1].gzac016,s_detail1[1].gzac017,s_detail1[1].gzac018, 
               s_detail1[1].gzac019,s_detail1[1].gzac020,s_detail1[1].gzac021,s_detail1[1].gzac022
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac002
            #add-point:BEFORE FIELD gzac002 name="construct.b.page1.gzac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac002
            
            #add-point:AFTER FIELD gzac002 name="construct.a.page1.gzac002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac002
            #add-point:ON ACTION controlp INFIELD gzac002 name="construct.c.page1.gzac002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac023
            #add-point:BEFORE FIELD gzac023 name="construct.b.page1.gzac023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac023
            
            #add-point:AFTER FIELD gzac023 name="construct.a.page1.gzac023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac023
            #add-point:ON ACTION controlp INFIELD gzac023 name="construct.c.page1.gzac023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac024
            #add-point:BEFORE FIELD gzac024 name="construct.b.page1.gzac024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac024
            
            #add-point:AFTER FIELD gzac024 name="construct.a.page1.gzac024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac024
            #add-point:ON ACTION controlp INFIELD gzac024 name="construct.c.page1.gzac024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac003
            #add-point:BEFORE FIELD gzac003 name="construct.b.page1.gzac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac003
            
            #add-point:AFTER FIELD gzac003 name="construct.a.page1.gzac003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac003
            #add-point:ON ACTION controlp INFIELD gzac003 name="construct.c.page1.gzac003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac004
            #add-point:BEFORE FIELD gzac004 name="construct.b.page1.gzac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac004
            
            #add-point:AFTER FIELD gzac004 name="construct.a.page1.gzac004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac004
            #add-point:ON ACTION controlp INFIELD gzac004 name="construct.c.page1.gzac004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac005
            #add-point:BEFORE FIELD gzac005 name="construct.b.page1.gzac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac005
            
            #add-point:AFTER FIELD gzac005 name="construct.a.page1.gzac005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac005
            #add-point:ON ACTION controlp INFIELD gzac005 name="construct.c.page1.gzac005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac006
            #add-point:BEFORE FIELD gzac006 name="construct.b.page1.gzac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac006
            
            #add-point:AFTER FIELD gzac006 name="construct.a.page1.gzac006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac006
            #add-point:ON ACTION controlp INFIELD gzac006 name="construct.c.page1.gzac006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac007
            #add-point:BEFORE FIELD gzac007 name="construct.b.page1.gzac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac007
            
            #add-point:AFTER FIELD gzac007 name="construct.a.page1.gzac007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac007
            #add-point:ON ACTION controlp INFIELD gzac007 name="construct.c.page1.gzac007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac008
            #add-point:BEFORE FIELD gzac008 name="construct.b.page1.gzac008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac008
            
            #add-point:AFTER FIELD gzac008 name="construct.a.page1.gzac008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac008
            #add-point:ON ACTION controlp INFIELD gzac008 name="construct.c.page1.gzac008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac009
            #add-point:BEFORE FIELD gzac009 name="construct.b.page1.gzac009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac009
            
            #add-point:AFTER FIELD gzac009 name="construct.a.page1.gzac009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac009
            #add-point:ON ACTION controlp INFIELD gzac009 name="construct.c.page1.gzac009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac010
            #add-point:BEFORE FIELD gzac010 name="construct.b.page1.gzac010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac010
            
            #add-point:AFTER FIELD gzac010 name="construct.a.page1.gzac010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac010
            #add-point:ON ACTION controlp INFIELD gzac010 name="construct.c.page1.gzac010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac011
            #add-point:BEFORE FIELD gzac011 name="construct.b.page1.gzac011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac011
            
            #add-point:AFTER FIELD gzac011 name="construct.a.page1.gzac011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac011
            #add-point:ON ACTION controlp INFIELD gzac011 name="construct.c.page1.gzac011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac012
            #add-point:BEFORE FIELD gzac012 name="construct.b.page1.gzac012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac012
            
            #add-point:AFTER FIELD gzac012 name="construct.a.page1.gzac012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac012
            #add-point:ON ACTION controlp INFIELD gzac012 name="construct.c.page1.gzac012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac013
            #add-point:BEFORE FIELD gzac013 name="construct.b.page1.gzac013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac013
            
            #add-point:AFTER FIELD gzac013 name="construct.a.page1.gzac013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac013
            #add-point:ON ACTION controlp INFIELD gzac013 name="construct.c.page1.gzac013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac014
            #add-point:BEFORE FIELD gzac014 name="construct.b.page1.gzac014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac014
            
            #add-point:AFTER FIELD gzac014 name="construct.a.page1.gzac014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac014
            #add-point:ON ACTION controlp INFIELD gzac014 name="construct.c.page1.gzac014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac015
            #add-point:BEFORE FIELD gzac015 name="construct.b.page1.gzac015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac015
            
            #add-point:AFTER FIELD gzac015 name="construct.a.page1.gzac015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac015
            #add-point:ON ACTION controlp INFIELD gzac015 name="construct.c.page1.gzac015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac016
            #add-point:BEFORE FIELD gzac016 name="construct.b.page1.gzac016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac016
            
            #add-point:AFTER FIELD gzac016 name="construct.a.page1.gzac016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac016
            #add-point:ON ACTION controlp INFIELD gzac016 name="construct.c.page1.gzac016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac017
            #add-point:BEFORE FIELD gzac017 name="construct.b.page1.gzac017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac017
            
            #add-point:AFTER FIELD gzac017 name="construct.a.page1.gzac017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac017
            #add-point:ON ACTION controlp INFIELD gzac017 name="construct.c.page1.gzac017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac018
            #add-point:BEFORE FIELD gzac018 name="construct.b.page1.gzac018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac018
            
            #add-point:AFTER FIELD gzac018 name="construct.a.page1.gzac018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac018
            #add-point:ON ACTION controlp INFIELD gzac018 name="construct.c.page1.gzac018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac019
            #add-point:BEFORE FIELD gzac019 name="construct.b.page1.gzac019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac019
            
            #add-point:AFTER FIELD gzac019 name="construct.a.page1.gzac019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac019
            #add-point:ON ACTION controlp INFIELD gzac019 name="construct.c.page1.gzac019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac020
            #add-point:BEFORE FIELD gzac020 name="construct.b.page1.gzac020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac020
            
            #add-point:AFTER FIELD gzac020 name="construct.a.page1.gzac020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac020
            #add-point:ON ACTION controlp INFIELD gzac020 name="construct.c.page1.gzac020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac021
            #add-point:BEFORE FIELD gzac021 name="construct.b.page1.gzac021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac021
            
            #add-point:AFTER FIELD gzac021 name="construct.a.page1.gzac021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac021
            #add-point:ON ACTION controlp INFIELD gzac021 name="construct.c.page1.gzac021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac022
            #add-point:BEFORE FIELD gzac022 name="construct.b.page1.gzac022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac022
            
            #add-point:AFTER FIELD gzac022 name="construct.a.page1.gzac022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzac022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac022
            #add-point:ON ACTION controlp INFIELD gzac022 name="construct.c.page1.gzac022"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON gzad002,l_ref_style,gzad003,gzad004,gzad005,gzad006,gzad007,gzad008, 
          gzad015,gzad016,gzad017,gzad009,gzad014,gzad010,gzad011,gzad012,gzad013
           FROM s_detail2[1].gzad002,s_detail2[1].l_ref_style,s_detail2[1].gzad003,s_detail2[1].gzad004, 
               s_detail2[1].gzad005,s_detail2[1].gzad006,s_detail2[1].gzad007,s_detail2[1].gzad008,s_detail2[1].gzad015, 
               s_detail2[1].gzad016,s_detail2[1].gzad017,s_detail2[1].gzad009,s_detail2[1].gzad014,s_detail2[1].gzad010, 
               s_detail2[1].gzad011,s_detail2[1].gzad012,s_detail2[1].gzad013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad002
            #add-point:BEFORE FIELD gzad002 name="construct.b.page2.gzad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad002
            
            #add-point:AFTER FIELD gzad002 name="construct.a.page2.gzad002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad002
            #add-point:ON ACTION controlp INFIELD gzad002 name="construct.c.page2.gzad002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_ref_style
            #add-point:BEFORE FIELD l_ref_style name="construct.b.page2.l_ref_style"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_ref_style
            
            #add-point:AFTER FIELD l_ref_style name="construct.a.page2.l_ref_style"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_ref_style
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_ref_style
            #add-point:ON ACTION controlp INFIELD l_ref_style name="construct.c.page2.l_ref_style"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad003
            #add-point:BEFORE FIELD gzad003 name="construct.b.page2.gzad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad003
            
            #add-point:AFTER FIELD gzad003 name="construct.a.page2.gzad003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad003
            #add-point:ON ACTION controlp INFIELD gzad003 name="construct.c.page2.gzad003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad004
            #add-point:BEFORE FIELD gzad004 name="construct.b.page2.gzad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad004
            
            #add-point:AFTER FIELD gzad004 name="construct.a.page2.gzad004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad004
            #add-point:ON ACTION controlp INFIELD gzad004 name="construct.c.page2.gzad004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad005
            #add-point:BEFORE FIELD gzad005 name="construct.b.page2.gzad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad005
            
            #add-point:AFTER FIELD gzad005 name="construct.a.page2.gzad005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad005
            #add-point:ON ACTION controlp INFIELD gzad005 name="construct.c.page2.gzad005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.gzad006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad006
            #add-point:ON ACTION controlp INFIELD gzad006 name="construct.c.page2.gzad006"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_gzad006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzad006  #顯示到畫面上

            NEXT FIELD gzad006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad006
            #add-point:BEFORE FIELD gzad006 name="construct.b.page2.gzad006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad006
            
            #add-point:AFTER FIELD gzad006 name="construct.a.page2.gzad006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad007
            #add-point:ON ACTION controlp INFIELD gzad007 name="construct.c.page2.gzad007"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_dzca001_02()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzad007  #顯示到畫面上

            NEXT FIELD gzad007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad007
            #add-point:BEFORE FIELD gzad007 name="construct.b.page2.gzad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad007
            
            #add-point:AFTER FIELD gzad007 name="construct.a.page2.gzad007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad008
            #add-point:ON ACTION controlp INFIELD gzad008 name="construct.c.page2.gzad008"
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_dzcd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzad008  #顯示到畫面上

            NEXT FIELD gzad008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad008
            #add-point:BEFORE FIELD gzad008 name="construct.b.page2.gzad008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad008
            
            #add-point:AFTER FIELD gzad008 name="construct.a.page2.gzad008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad015
            #add-point:ON ACTION controlp INFIELD gzad015 name="construct.c.page2.gzad015"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_dzea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzad015  #顯示到畫面上

            NEXT FIELD gzad015                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad015
            #add-point:BEFORE FIELD gzad015 name="construct.b.page2.gzad015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad015
            
            #add-point:AFTER FIELD gzad015 name="construct.a.page2.gzad015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad016
            #add-point:ON ACTION controlp INFIELD gzad016 name="construct.c.page2.gzad016"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_dzeb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzad016  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO dzeb003 #欄位名稱 

            NEXT FIELD gzad016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad016
            #add-point:BEFORE FIELD gzad016 name="construct.b.page2.gzad016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad016
            
            #add-point:AFTER FIELD gzad016 name="construct.a.page2.gzad016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad017
            #add-point:ON ACTION controlp INFIELD gzad017 name="construct.c.page2.gzad017"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_dzeb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzad017  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO dzeb003 #欄位名稱 

            NEXT FIELD gzad017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad017
            #add-point:BEFORE FIELD gzad017 name="construct.b.page2.gzad017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad017
            
            #add-point:AFTER FIELD gzad017 name="construct.a.page2.gzad017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad009
            #add-point:BEFORE FIELD gzad009 name="construct.b.page2.gzad009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad009
            
            #add-point:AFTER FIELD gzad009 name="construct.a.page2.gzad009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad009
            #add-point:ON ACTION controlp INFIELD gzad009 name="construct.c.page2.gzad009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad014
            #add-point:BEFORE FIELD gzad014 name="construct.b.page2.gzad014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad014
            
            #add-point:AFTER FIELD gzad014 name="construct.a.page2.gzad014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad014
            #add-point:ON ACTION controlp INFIELD gzad014 name="construct.c.page2.gzad014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad010
            #add-point:BEFORE FIELD gzad010 name="construct.b.page2.gzad010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad010
            
            #add-point:AFTER FIELD gzad010 name="construct.a.page2.gzad010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad010
            #add-point:ON ACTION controlp INFIELD gzad010 name="construct.c.page2.gzad010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad011
            #add-point:BEFORE FIELD gzad011 name="construct.b.page2.gzad011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad011
            
            #add-point:AFTER FIELD gzad011 name="construct.a.page2.gzad011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad011
            #add-point:ON ACTION controlp INFIELD gzad011 name="construct.c.page2.gzad011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad012
            #add-point:BEFORE FIELD gzad012 name="construct.b.page2.gzad012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad012
            
            #add-point:AFTER FIELD gzad012 name="construct.a.page2.gzad012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad012
            #add-point:ON ACTION controlp INFIELD gzad012 name="construct.c.page2.gzad012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad013
            #add-point:BEFORE FIELD gzad013 name="construct.b.page2.gzad013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad013
            
            #add-point:AFTER FIELD gzad013 name="construct.a.page2.gzad013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.gzad013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad013
            #add-point:ON ACTION controlp INFIELD gzad013 name="construct.c.page2.gzad013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON gzai002,gzai003,gzai004,gzai005,gzai006,gzai007,gzai008,gzai009,gzai010, 
          gzai011,gzai012,gzai013,gzai014,gzai015,gzai016,gzai017,gzai018,gzai019,gzai020,gzai021,gzai022 
 
           FROM s_detail3[1].gzai002,s_detail3[1].gzai003,s_detail3[1].gzai004,s_detail3[1].gzai005, 
               s_detail3[1].gzai006,s_detail3[1].gzai007,s_detail3[1].gzai008,s_detail3[1].gzai009,s_detail3[1].gzai010, 
               s_detail3[1].gzai011,s_detail3[1].gzai012,s_detail3[1].gzai013,s_detail3[1].gzai014,s_detail3[1].gzai015, 
               s_detail3[1].gzai016,s_detail3[1].gzai017,s_detail3[1].gzai018,s_detail3[1].gzai019,s_detail3[1].gzai020, 
               s_detail3[1].gzai021,s_detail3[1].gzai022
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai002
            #add-point:BEFORE FIELD gzai002 name="construct.b.page3.gzai002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai002
            
            #add-point:AFTER FIELD gzai002 name="construct.a.page3.gzai002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai002
            #add-point:ON ACTION controlp INFIELD gzai002 name="construct.c.page3.gzai002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai003
            #add-point:BEFORE FIELD gzai003 name="construct.b.page3.gzai003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai003
            
            #add-point:AFTER FIELD gzai003 name="construct.a.page3.gzai003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai003
            #add-point:ON ACTION controlp INFIELD gzai003 name="construct.c.page3.gzai003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai004
            #add-point:BEFORE FIELD gzai004 name="construct.b.page3.gzai004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai004
            
            #add-point:AFTER FIELD gzai004 name="construct.a.page3.gzai004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai004
            #add-point:ON ACTION controlp INFIELD gzai004 name="construct.c.page3.gzai004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai005
            #add-point:BEFORE FIELD gzai005 name="construct.b.page3.gzai005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai005
            
            #add-point:AFTER FIELD gzai005 name="construct.a.page3.gzai005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai005
            #add-point:ON ACTION controlp INFIELD gzai005 name="construct.c.page3.gzai005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai006
            #add-point:BEFORE FIELD gzai006 name="construct.b.page3.gzai006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai006
            
            #add-point:AFTER FIELD gzai006 name="construct.a.page3.gzai006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai006
            #add-point:ON ACTION controlp INFIELD gzai006 name="construct.c.page3.gzai006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai007
            #add-point:BEFORE FIELD gzai007 name="construct.b.page3.gzai007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai007
            
            #add-point:AFTER FIELD gzai007 name="construct.a.page3.gzai007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai007
            #add-point:ON ACTION controlp INFIELD gzai007 name="construct.c.page3.gzai007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai008
            #add-point:BEFORE FIELD gzai008 name="construct.b.page3.gzai008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai008
            
            #add-point:AFTER FIELD gzai008 name="construct.a.page3.gzai008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai008
            #add-point:ON ACTION controlp INFIELD gzai008 name="construct.c.page3.gzai008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai009
            #add-point:BEFORE FIELD gzai009 name="construct.b.page3.gzai009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai009
            
            #add-point:AFTER FIELD gzai009 name="construct.a.page3.gzai009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai009
            #add-point:ON ACTION controlp INFIELD gzai009 name="construct.c.page3.gzai009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai010
            #add-point:BEFORE FIELD gzai010 name="construct.b.page3.gzai010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai010
            
            #add-point:AFTER FIELD gzai010 name="construct.a.page3.gzai010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai010
            #add-point:ON ACTION controlp INFIELD gzai010 name="construct.c.page3.gzai010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai011
            #add-point:BEFORE FIELD gzai011 name="construct.b.page3.gzai011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai011
            
            #add-point:AFTER FIELD gzai011 name="construct.a.page3.gzai011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai011
            #add-point:ON ACTION controlp INFIELD gzai011 name="construct.c.page3.gzai011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai012
            #add-point:BEFORE FIELD gzai012 name="construct.b.page3.gzai012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai012
            
            #add-point:AFTER FIELD gzai012 name="construct.a.page3.gzai012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai012
            #add-point:ON ACTION controlp INFIELD gzai012 name="construct.c.page3.gzai012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai013
            #add-point:BEFORE FIELD gzai013 name="construct.b.page3.gzai013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai013
            
            #add-point:AFTER FIELD gzai013 name="construct.a.page3.gzai013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai013
            #add-point:ON ACTION controlp INFIELD gzai013 name="construct.c.page3.gzai013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai014
            #add-point:BEFORE FIELD gzai014 name="construct.b.page3.gzai014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai014
            
            #add-point:AFTER FIELD gzai014 name="construct.a.page3.gzai014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai014
            #add-point:ON ACTION controlp INFIELD gzai014 name="construct.c.page3.gzai014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai015
            #add-point:BEFORE FIELD gzai015 name="construct.b.page3.gzai015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai015
            
            #add-point:AFTER FIELD gzai015 name="construct.a.page3.gzai015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai015
            #add-point:ON ACTION controlp INFIELD gzai015 name="construct.c.page3.gzai015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai016
            #add-point:BEFORE FIELD gzai016 name="construct.b.page3.gzai016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai016
            
            #add-point:AFTER FIELD gzai016 name="construct.a.page3.gzai016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai016
            #add-point:ON ACTION controlp INFIELD gzai016 name="construct.c.page3.gzai016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai017
            #add-point:BEFORE FIELD gzai017 name="construct.b.page3.gzai017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai017
            
            #add-point:AFTER FIELD gzai017 name="construct.a.page3.gzai017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai017
            #add-point:ON ACTION controlp INFIELD gzai017 name="construct.c.page3.gzai017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai018
            #add-point:BEFORE FIELD gzai018 name="construct.b.page3.gzai018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai018
            
            #add-point:AFTER FIELD gzai018 name="construct.a.page3.gzai018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai018
            #add-point:ON ACTION controlp INFIELD gzai018 name="construct.c.page3.gzai018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai019
            #add-point:BEFORE FIELD gzai019 name="construct.b.page3.gzai019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai019
            
            #add-point:AFTER FIELD gzai019 name="construct.a.page3.gzai019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai019
            #add-point:ON ACTION controlp INFIELD gzai019 name="construct.c.page3.gzai019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai020
            #add-point:BEFORE FIELD gzai020 name="construct.b.page3.gzai020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai020
            
            #add-point:AFTER FIELD gzai020 name="construct.a.page3.gzai020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai020
            #add-point:ON ACTION controlp INFIELD gzai020 name="construct.c.page3.gzai020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai021
            #add-point:BEFORE FIELD gzai021 name="construct.b.page3.gzai021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai021
            
            #add-point:AFTER FIELD gzai021 name="construct.a.page3.gzai021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai021
            #add-point:ON ACTION controlp INFIELD gzai021 name="construct.c.page3.gzai021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai022
            #add-point:BEFORE FIELD gzai022 name="construct.b.page3.gzai022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai022
            
            #add-point:AFTER FIELD gzai022 name="construct.a.page3.gzai022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.gzai022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai022
            #add-point:ON ACTION controlp INFIELD gzai022 name="construct.c.page3.gzai022"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON gzaj002,l_cref_style,gzaj003,gzaj004,gzaj005,gzaj006,gzaj007,gzaj008, 
          gzaj015,gzaj016,gzaj017,gzaj009,gzaj014,gzaj010,gzaj011,gzaj012,gzaj013
           FROM s_detail4[1].gzaj002,s_detail4[1].l_cref_style,s_detail4[1].gzaj003,s_detail4[1].gzaj004, 
               s_detail4[1].gzaj005,s_detail4[1].gzaj006,s_detail4[1].gzaj007,s_detail4[1].gzaj008,s_detail4[1].gzaj015, 
               s_detail4[1].gzaj016,s_detail4[1].gzaj017,s_detail4[1].gzaj009,s_detail4[1].gzaj014,s_detail4[1].gzaj010, 
               s_detail4[1].gzaj011,s_detail4[1].gzaj012,s_detail4[1].gzaj013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj002
            #add-point:BEFORE FIELD gzaj002 name="construct.b.page4.gzaj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj002
            
            #add-point:AFTER FIELD gzaj002 name="construct.a.page4.gzaj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj002
            #add-point:ON ACTION controlp INFIELD gzaj002 name="construct.c.page4.gzaj002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cref_style
            #add-point:BEFORE FIELD l_cref_style name="construct.b.page4.l_cref_style"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cref_style
            
            #add-point:AFTER FIELD l_cref_style name="construct.a.page4.l_cref_style"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.l_cref_style
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cref_style
            #add-point:ON ACTION controlp INFIELD l_cref_style name="construct.c.page4.l_cref_style"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj003
            #add-point:BEFORE FIELD gzaj003 name="construct.b.page4.gzaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj003
            
            #add-point:AFTER FIELD gzaj003 name="construct.a.page4.gzaj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj003
            #add-point:ON ACTION controlp INFIELD gzaj003 name="construct.c.page4.gzaj003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj004
            #add-point:BEFORE FIELD gzaj004 name="construct.b.page4.gzaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj004
            
            #add-point:AFTER FIELD gzaj004 name="construct.a.page4.gzaj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj004
            #add-point:ON ACTION controlp INFIELD gzaj004 name="construct.c.page4.gzaj004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj005
            #add-point:BEFORE FIELD gzaj005 name="construct.b.page4.gzaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj005
            
            #add-point:AFTER FIELD gzaj005 name="construct.a.page4.gzaj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj005
            #add-point:ON ACTION controlp INFIELD gzaj005 name="construct.c.page4.gzaj005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.gzaj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj006
            #add-point:ON ACTION controlp INFIELD gzaj006 name="construct.c.page4.gzaj006"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaj006  #顯示到畫面上
            NEXT FIELD gzaj006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj006
            #add-point:BEFORE FIELD gzaj006 name="construct.b.page4.gzaj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj006
            
            #add-point:AFTER FIELD gzaj006 name="construct.a.page4.gzaj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj007
            #add-point:ON ACTION controlp INFIELD gzaj007 name="construct.c.page4.gzaj007"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dzca001_02()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaj007  #顯示到畫面上
            NEXT FIELD gzaj007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj007
            #add-point:BEFORE FIELD gzaj007 name="construct.b.page4.gzaj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj007
            
            #add-point:AFTER FIELD gzaj007 name="construct.a.page4.gzaj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj008
            #add-point:ON ACTION controlp INFIELD gzaj008 name="construct.c.page4.gzaj008"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dzcd001_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaj008  #顯示到畫面上
            NEXT FIELD gzaj008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj008
            #add-point:BEFORE FIELD gzaj008 name="construct.b.page4.gzaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj008
            
            #add-point:AFTER FIELD gzaj008 name="construct.a.page4.gzaj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj015
            #add-point:ON ACTION controlp INFIELD gzaj015 name="construct.c.page4.gzaj015"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dzea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaj015  #顯示到畫面上
            NEXT FIELD gzaj015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj015
            #add-point:BEFORE FIELD gzaj015 name="construct.b.page4.gzaj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj015
            
            #add-point:AFTER FIELD gzaj015 name="construct.a.page4.gzaj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj016
            #add-point:ON ACTION controlp INFIELD gzaj016 name="construct.c.page4.gzaj016"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dzeb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaj016  #顯示到畫面上
            NEXT FIELD gzaj016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj016
            #add-point:BEFORE FIELD gzaj016 name="construct.b.page4.gzaj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj016
            
            #add-point:AFTER FIELD gzaj016 name="construct.a.page4.gzaj016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj017
            #add-point:ON ACTION controlp INFIELD gzaj017 name="construct.c.page4.gzaj017"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dzeb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzaj017  #顯示到畫面上
            NEXT FIELD gzaj017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj017
            #add-point:BEFORE FIELD gzaj017 name="construct.b.page4.gzaj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj017
            
            #add-point:AFTER FIELD gzaj017 name="construct.a.page4.gzaj017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj009
            #add-point:BEFORE FIELD gzaj009 name="construct.b.page4.gzaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj009
            
            #add-point:AFTER FIELD gzaj009 name="construct.a.page4.gzaj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj009
            #add-point:ON ACTION controlp INFIELD gzaj009 name="construct.c.page4.gzaj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj014
            #add-point:BEFORE FIELD gzaj014 name="construct.b.page4.gzaj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj014
            
            #add-point:AFTER FIELD gzaj014 name="construct.a.page4.gzaj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj014
            #add-point:ON ACTION controlp INFIELD gzaj014 name="construct.c.page4.gzaj014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj010
            #add-point:BEFORE FIELD gzaj010 name="construct.b.page4.gzaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj010
            
            #add-point:AFTER FIELD gzaj010 name="construct.a.page4.gzaj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj010
            #add-point:ON ACTION controlp INFIELD gzaj010 name="construct.c.page4.gzaj010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj011
            #add-point:BEFORE FIELD gzaj011 name="construct.b.page4.gzaj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj011
            
            #add-point:AFTER FIELD gzaj011 name="construct.a.page4.gzaj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj011
            #add-point:ON ACTION controlp INFIELD gzaj011 name="construct.c.page4.gzaj011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj012
            #add-point:BEFORE FIELD gzaj012 name="construct.b.page4.gzaj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj012
            
            #add-point:AFTER FIELD gzaj012 name="construct.a.page4.gzaj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj012
            #add-point:ON ACTION controlp INFIELD gzaj012 name="construct.c.page4.gzaj012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj013
            #add-point:BEFORE FIELD gzaj013 name="construct.b.page4.gzaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj013
            
            #add-point:AFTER FIELD gzaj013 name="construct.a.page4.gzaj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.gzaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj013
            #add-point:ON ACTION controlp INFIELD gzaj013 name="construct.c.page4.gzaj013"
            
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
 
            INITIALIZE g_wc2_table4 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "gzaa_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gzac_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gzad_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "gzai_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "gzaj_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
 
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
 
{<section id="azzi650.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION azzi650_filter()
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
      CONSTRUCT g_wc_filter ON gzaa001,gzaa002,gzaa003
                          FROM s_browse[1].b_gzaa001,s_browse[1].b_gzaa002,s_browse[1].b_gzaa003
 
         BEFORE CONSTRUCT
               DISPLAY azzi650_filter_parser('gzaa001') TO s_browse[1].b_gzaa001
            DISPLAY azzi650_filter_parser('gzaa002') TO s_browse[1].b_gzaa002
            DISPLAY azzi650_filter_parser('gzaa003') TO s_browse[1].b_gzaa003
      
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
 
      CALL azzi650_filter_show('gzaa001')
   CALL azzi650_filter_show('gzaa002')
   CALL azzi650_filter_show('gzaa003')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION azzi650_filter_parser(ps_field)
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
 
{<section id="azzi650.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION azzi650_filter_show(ps_field)
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
   LET ls_condition = azzi650_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi650_query()
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
   CALL g_gzac_d.clear()
   CALL g_gzac2_d.clear()
   CALL g_gzac3_d.clear()
   CALL g_gzac4_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL azzi650_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL azzi650_browser_fill("")
      CALL azzi650_fetch("")
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
      CALL azzi650_filter_show('gzaa001')
   CALL azzi650_filter_show('gzaa002')
   CALL azzi650_filter_show('gzaa003')
   CALL azzi650_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL azzi650_fetch("F") 
      #顯示單身筆數
      CALL azzi650_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi650_fetch(p_flag)
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
   
   LET g_gzaa_m.gzaa001 = g_browser[g_current_idx].b_gzaa001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzi650_master_referesh USING g_gzaa_m.gzaa001 INTO g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaacrtid, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt,g_gzaa_m.gzaaownid_desc, 
       g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid_desc,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaamodid_desc 
 
   
   #遮罩相關處理
   LET g_gzaa_m_mask_o.* =  g_gzaa_m.*
   CALL azzi650_gzaa_t_mask()
   LET g_gzaa_m_mask_n.* =  g_gzaa_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi650_set_act_visible()   
   CALL azzi650_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gzaa_m_t.* = g_gzaa_m.*
   LET g_gzaa_m_o.* = g_gzaa_m.*
   
   LET g_data_owner = g_gzaa_m.gzaaownid      
   LET g_data_dept  = g_gzaa_m.gzaaowndp
   
   #重新顯示   
   CALL azzi650_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi650_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gzac_d.clear()   
   CALL g_gzac2_d.clear()  
   CALL g_gzac3_d.clear()  
   CALL g_gzac4_d.clear()  
 
 
   INITIALIZE g_gzaa_m.* TO NULL             #DEFAULT 設定
   
   LET g_gzaa001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzaa_m.gzaaownid = g_user
      LET g_gzaa_m.gzaaowndp = g_dept
      LET g_gzaa_m.gzaacrtid = g_user
      LET g_gzaa_m.gzaacrtdp = g_dept 
      LET g_gzaa_m.gzaacrtdt = cl_get_current()
      LET g_gzaa_m.gzaamodid = g_user
      LET g_gzaa_m.gzaamoddt = cl_get_current()
      LET g_gzaa_m.gzaastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_gzaa_m.gzaa002 = "Y"
      LET g_gzaa_m.gzaa003 = "Y"
      LET g_gzaa_m.gzaa005 = "N"
      LET g_gzaa_m.gzaastus = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_gzaa_m.gzaastus = "Y" 
      IF g_dgenv ='s' THEN
         LET g_gzaa_m.gzaa002 = 'Y' 
      ELSE
         LET g_gzaa_m.gzaa002 = 'N'
         LET g_gzaa_m.gzaa004 = '6'
      END IF
      LET g_gzaa_m.gzaa003 = "N"
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gzaa_m_t.* = g_gzaa_m.*
      LET g_gzaa_m_o.* = g_gzaa_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzaa_m.gzaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL azzi650_input("a")
      
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
         INITIALIZE g_gzaa_m.* TO NULL
         INITIALIZE g_gzac_d TO NULL
         INITIALIZE g_gzac2_d TO NULL
         INITIALIZE g_gzac3_d TO NULL
         INITIALIZE g_gzac4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL azzi650_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gzac_d.clear()
      #CALL g_gzac2_d.clear()
      #CALL g_gzac3_d.clear()
      #CALL g_gzac4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi650_set_act_visible()   
   CALL azzi650_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gzaa001_t = g_gzaa_m.gzaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzaa001 = '", g_gzaa_m.gzaa001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi650_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE azzi650_cl
   
   CALL azzi650_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi650_master_referesh USING g_gzaa_m.gzaa001 INTO g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaacrtid, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt,g_gzaa_m.gzaaownid_desc, 
       g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid_desc,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaamodid_desc 
 
   
   
   #遮罩相關處理
   LET g_gzaa_m_mask_o.* =  g_gzaa_m.*
   CALL azzi650_gzaa_t_mask()
   LET g_gzaa_m_mask_n.* =  g_gzaa_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaal003,g_gzaa_m.gzaal004,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzzz001,g_gzaa_m.gzzal003,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid, 
       g_gzaa_m.gzaaownid_desc,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid,g_gzaa_m.gzaacrtid_desc, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamodid_desc, 
       g_gzaa_m.gzaamoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_gzaa_m.gzaaownid      
   LET g_data_dept  = g_gzaa_m.gzaaowndp
   
   #功能已完成,通報訊息中心
   CALL azzi650_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi650_modify()
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
   DEFINE l_count_oocq LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gzaa_m_t.* = g_gzaa_m.*
   LET g_gzaa_m_o.* = g_gzaa_m.*
   
   IF g_gzaa_m.gzaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gzaa001_t = g_gzaa_m.gzaa001
 
   CALL s_transaction_begin()
   
   OPEN azzi650_cl USING g_gzaa_m.gzaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi650_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE azzi650_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi650_master_referesh USING g_gzaa_m.gzaa001 INTO g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaacrtid, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt,g_gzaa_m.gzaaownid_desc, 
       g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid_desc,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaamodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT azzi650_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzaa_m_mask_o.* =  g_gzaa_m.*
   CALL azzi650_gzaa_t_mask()
   LET g_gzaa_m_mask_n.* =  g_gzaa_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
#   IF g_dgenv = 'c' AND (g_gzaa_m.gzaa002 = 'Y' OR g_gzaa_m.gzaa004 <>'6') THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = g_gzaa_m.gzaa001
#      LET g_errparam.code = "azz-00049"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      
#      RETURN
#   END IF
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
 
 
   
   CALL azzi650_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_gzaa001_t = g_gzaa_m.gzaa001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gzaa_m.gzaamodid = g_user 
LET g_gzaa_m.gzaamoddt = cl_get_current()
LET g_gzaa_m.gzaamodid_desc = cl_get_username(g_gzaa_m.gzaamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
#      IF g_dgenv ='c' THEN
#         IF g_gzaa_m.gzaa002 = 'Y' THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'azz-00029'
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            RETURN 
#         END IF
#      END IF 
      LET l_count_oocq = 0 
      SELECT COUNT(*) INTO l_count_oocq FROM oocq_t WHERE oocq001 = g_gzaa_m.gzaa001 
      IF l_count_oocq>0 AND g_gzaa_m.gzaa003 = 'Y' THEN 
         CALL cl_set_comp_entry('gzaa003',FALSE)
      ELSE
         CALL cl_set_comp_entry('gzaa003',TRUE) 
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL azzi650_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gzaa_t SET (gzaamodid,gzaamoddt) = (g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt)
          WHERE  gzaa001 = g_gzaa001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_gzaa_m.* = g_gzaa_m_t.*
            CALL azzi650_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gzaa_m.gzaa001 != g_gzaa_m_t.gzaa001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE gzac_t SET gzac001 = g_gzaa_m.gzaa001
 
          WHERE  gzac001 = g_gzaa_m_t.gzaa001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gzac_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzac_t:",SQLERRMESSAGE 
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
         
         UPDATE gzad_t
            SET gzad001 = g_gzaa_m.gzaa001
 
          WHERE 
                gzad001 = g_gzaa001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gzad_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzad_t:",SQLERRMESSAGE 
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
         
         UPDATE gzai_t
            SET gzai001 = g_gzaa_m.gzaa001
 
          WHERE 
                gzai001 = g_gzaa001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gzai_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzai_t:",SQLERRMESSAGE 
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
         
         UPDATE gzaj_t
            SET gzaj001 = g_gzaa_m.gzaa001
 
          WHERE 
                gzaj001 = g_gzaa001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gzaj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzaj_t:",SQLERRMESSAGE 
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
   CALL azzi650_set_act_visible()   
   CALL azzi650_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzaa001 = '", g_gzaa_m.gzaa001, "' "
 
   #填到對應位置
   CALL azzi650_browser_fill("")
 
   CLOSE azzi650_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi650_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="azzi650.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi650_input(p_cmd)
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
   DEFINE  l_result              LIKE type_t.chr1
   DEFINE  li_count              LIKE type_t.num5
   DEFINE  lc_gzzz004            LIKE gzzz_t.gzzz004
   DEFINE  lc_count              LIKE type_t.num5
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
   DISPLAY BY NAME g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaal003,g_gzaa_m.gzaal004,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzzz001,g_gzaa_m.gzzal003,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid, 
       g_gzaa_m.gzaaownid_desc,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid,g_gzaa_m.gzaacrtid_desc, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamodid_desc, 
       g_gzaa_m.gzaamoddt
   
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
   LET g_forupd_sql = "SELECT gzac002,gzac023,gzac024,gzac003,gzac004,gzac005,gzac006,gzac007,gzac008, 
       gzac009,gzac010,gzac011,gzac012,gzac013,gzac014,gzac015,gzac016,gzac017,gzac018,gzac019,gzac020, 
       gzac021,gzac022 FROM gzac_t WHERE gzac001=? AND gzac002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi650_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT gzad002,gzad003,gzad004,gzad005,gzad006,gzad007,gzad008,gzad015,gzad016, 
       gzad017,gzad009,gzad014,gzad010,gzad011,gzad012,gzad013 FROM gzad_t WHERE gzad001=? AND gzad002=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi650_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT gzai002,gzai003,gzai004,gzai005,gzai006,gzai007,gzai008,gzai009,gzai010, 
       gzai011,gzai012,gzai013,gzai014,gzai015,gzai016,gzai017,gzai018,gzai019,gzai020,gzai021,gzai022  
       FROM gzai_t WHERE gzai001=? AND gzai002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi650_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT gzaj002,gzaj003,gzaj004,gzaj005,gzaj006,gzaj007,gzaj008,gzaj015,gzaj016, 
       gzaj017,gzaj009,gzaj014,gzaj010,gzaj011,gzaj012,gzaj013 FROM gzaj_t WHERE gzaj001=? AND gzaj002=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi650_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi650_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL azzi650_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaal003,g_gzaa_m.gzaal004,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="azzi650.input.head" >}
      #單頭段
      INPUT BY NAME g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaal003,g_gzaa_m.gzaal004,g_gzaa_m.gzaa002, 
          g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_gzaa_m.gzaa001)  THEN
                  CALL n_gzaal(g_gzaa_m.gzaa001)    # n_glacl:對應多語言表格 。 g_glac_m.glac002: 對應值
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_gzaa_m.gzaa001                  
                  CALL ap_ref_array2(g_ref_fields," SELECT gzaal003,gzaal004 FROM gzaal_t WHERE gzaal001 = ? AND gzaal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_gzaa_m.gzaal003 = g_rtn_fields[1]
                  LET g_gzaa_m.gzaal004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_gzaa_m.gzaal003 
                  DISPLAY BY NAME g_gzaa_m.gzaal004 
               END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN azzi650_cl USING g_gzaa_m.gzaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi650_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi650_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.gzaal001 = g_gzaa_m.gzaa001
LET g_master_multi_table_t.gzaal003 = g_gzaa_m.gzaal003
LET g_master_multi_table_t.gzaal004 = g_gzaa_m.gzaal004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.gzaal001 = ''
LET g_master_multi_table_t.gzaal003 = ''
LET g_master_multi_table_t.gzaal004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL azzi650_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            NEXT FIELD gzaa004
            #end add-point
            CALL azzi650_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa004
            #add-point:BEFORE FIELD gzaa004 name="input.b.gzaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa004
            
            #add-point:AFTER FIELD gzaa004 name="input.a.gzaa004"
            IF p_cmd = 'a'  THEN
               IF g_dgenv = 's' AND g_gzaa_m.gzaa004 = '6' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "azz-00253"   #標準情況下不可以新增User自定的應用分類碼！
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  NEXT FIELD gzaa004
               END IF
               
               CALL azzi650_gzaa004_def_gzaa001(g_gzaa_m.gzaa004)
                  RETURNING g_gzaa_m.gzaa001 
               DISPLAY BY NAME g_gzaa_m.gzaa001
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaa004
            #add-point:ON CHANGE gzaa004 name="input.g.gzaa004"
            IF p_cmd = 'a' THEN
               CALL azzi650_gzaa004_def_gzaa001(g_gzaa_m.gzaa004)
                  RETURNING g_gzaa_m.gzaa001 
               DISPLAY BY NAME g_gzaa_m.gzaa001
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa001
            #add-point:BEFORE FIELD gzaa001 name="input.b.gzaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa001
            
            #add-point:AFTER FIELD gzaa001 name="input.a.gzaa001"
            CALL azzi650_gzaa001_chk(p_cmd) RETURNING l_result
            IF l_result = '1' THEN 
               IF p_cmd = 'a' THEN 
                  LET g_gzaa_m.gzaa001 = ''
               ELSE
                  LET g_gzaa_m.gzaa001 = g_gzaa_m_t.gzaa001
               END IF 
               NEXT FIELD gzaa001
            END IF
            CALL azzi650_gzaa001_ref(p_cmd)
            CALL azzi650_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaa001
            #add-point:ON CHANGE gzaa001 name="input.g.gzaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaal003
            #add-point:BEFORE FIELD gzaal003 name="input.b.gzaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaal003
            
            #add-point:AFTER FIELD gzaal003 name="input.a.gzaal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaal003
            #add-point:ON CHANGE gzaal003 name="input.g.gzaal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaal004
            #add-point:BEFORE FIELD gzaal004 name="input.b.gzaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaal004
            
            #add-point:AFTER FIELD gzaal004 name="input.a.gzaal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaal004
            #add-point:ON CHANGE gzaal004 name="input.g.gzaal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa002
            #add-point:BEFORE FIELD gzaa002 name="input.b.gzaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa002
            
            #add-point:AFTER FIELD gzaa002 name="input.a.gzaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaa002
            #add-point:ON CHANGE gzaa002 name="input.g.gzaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa003
            #add-point:BEFORE FIELD gzaa003 name="input.b.gzaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa003
            
            #add-point:AFTER FIELD gzaa003 name="input.a.gzaa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaa003
            #add-point:ON CHANGE gzaa003 name="input.g.gzaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaa005
            #add-point:BEFORE FIELD gzaa005 name="input.b.gzaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaa005
            
            #add-point:AFTER FIELD gzaa005 name="input.a.gzaa005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaa005
            #add-point:ON CHANGE gzaa005 name="input.g.gzaa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaastus
            #add-point:BEFORE FIELD gzaastus name="input.b.gzaastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaastus
            
            #add-point:AFTER FIELD gzaastus name="input.a.gzaastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaastus
            #add-point:ON CHANGE gzaastus name="input.g.gzaastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gzaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa004
            #add-point:ON ACTION controlp INFIELD gzaa004 name="input.c.gzaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa001
            #add-point:ON ACTION controlp INFIELD gzaa001 name="input.c.gzaa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaal003
            #add-point:ON ACTION controlp INFIELD gzaal003 name="input.c.gzaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaal004
            #add-point:ON ACTION controlp INFIELD gzaal004 name="input.c.gzaal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa002
            #add-point:ON ACTION controlp INFIELD gzaa002 name="input.c.gzaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa003
            #add-point:ON ACTION controlp INFIELD gzaa003 name="input.c.gzaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaa005
            #add-point:ON ACTION controlp INFIELD gzaa005 name="input.c.gzaa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaastus
            #add-point:ON ACTION controlp INFIELD gzaastus name="input.c.gzaastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gzaa_m.gzaa001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL azzi650_ins_gzad()
               CALL azzi650_ins_gzaj()
               #end add-point
               
               INSERT INTO gzaa_t (gzaa004,gzaa001,gzaa002,gzaa003,gzaa005,gzaastus,gzaaownid,gzaaowndp, 
                   gzaacrtid,gzaacrtdp,gzaacrtdt,gzaamodid,gzaamoddt)
               VALUES (g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaa002,g_gzaa_m.gzaa003,g_gzaa_m.gzaa005, 
                   g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaacrtid,g_gzaa_m.gzaacrtdp, 
                   g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gzaa_m:",SQLERRMESSAGE 
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
         IF g_gzaa_m.gzaa001 = g_master_multi_table_t.gzaal001 AND
         g_gzaa_m.gzaal003 = g_master_multi_table_t.gzaal003 AND 
         g_gzaa_m.gzaal004 = g_master_multi_table_t.gzaal004  THEN
         ELSE 
            LET l_var_keys[01] = g_gzaa_m.gzaa001
            LET l_field_keys[01] = 'gzaal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzaal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzaal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzaa_m.gzaal003
            LET l_fields[01] = 'gzaal003'
            LET l_vars[02] = g_gzaa_m.gzaal004
            LET l_fields[02] = 'gzaal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzaal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
                  LET g_gzaa_m_t.* = g_gzaa_m.*
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL azzi650_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL azzi650_b_fill()
                  CALL azzi650_b_fill2('0')
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
               CALL azzi650_gzaa_t_mask_restore('restore_mask_o')
               
               UPDATE gzaa_t SET (gzaa004,gzaa001,gzaa002,gzaa003,gzaa005,gzaastus,gzaaownid,gzaaowndp, 
                   gzaacrtid,gzaacrtdp,gzaacrtdt,gzaamodid,gzaamoddt) = (g_gzaa_m.gzaa004,g_gzaa_m.gzaa001, 
                   g_gzaa_m.gzaa002,g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid, 
                   g_gzaa_m.gzaaowndp,g_gzaa_m.gzaacrtid,g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid, 
                   g_gzaa_m.gzaamoddt)
                WHERE  gzaa001 = g_gzaa001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzaa_t:",SQLERRMESSAGE 
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
         IF g_gzaa_m.gzaa001 = g_master_multi_table_t.gzaal001 AND
         g_gzaa_m.gzaal003 = g_master_multi_table_t.gzaal003 AND 
         g_gzaa_m.gzaal004 = g_master_multi_table_t.gzaal004  THEN
         ELSE 
            LET l_var_keys[01] = g_gzaa_m.gzaa001
            LET l_field_keys[01] = 'gzaal001'
            LET l_var_keys_bak[01] = g_master_multi_table_t.gzaal001
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'gzaal002'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_gzaa_m.gzaal003
            LET l_fields[01] = 'gzaal003'
            LET l_vars[02] = g_gzaa_m.gzaal004
            LET l_fields[02] = 'gzaal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'gzaal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL azzi650_gzaa_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gzaa_m_t)
               LET g_log2 = util.JSON.stringify(g_gzaa_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_gzaa001_t = g_gzaa_m.gzaa001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="azzi650.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzac_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzac_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi650_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gzac_d.getLength()
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
            OPEN azzi650_cl USING g_gzaa_m.gzaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi650_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi650_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gzac_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzac_d[l_ac].gzac002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzac_d_t.* = g_gzac_d[l_ac].*  #BACKUP
               LET g_gzac_d_o.* = g_gzac_d[l_ac].*  #BACKUP
               CALL azzi650_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL azzi650_set_no_entry_b(l_cmd)
               IF NOT azzi650_lock_b("gzac_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi650_bcl INTO g_gzac_d[l_ac].gzac002,g_gzac_d[l_ac].gzac023,g_gzac_d[l_ac].gzac024, 
                      g_gzac_d[l_ac].gzac003,g_gzac_d[l_ac].gzac004,g_gzac_d[l_ac].gzac005,g_gzac_d[l_ac].gzac006, 
                      g_gzac_d[l_ac].gzac007,g_gzac_d[l_ac].gzac008,g_gzac_d[l_ac].gzac009,g_gzac_d[l_ac].gzac010, 
                      g_gzac_d[l_ac].gzac011,g_gzac_d[l_ac].gzac012,g_gzac_d[l_ac].gzac013,g_gzac_d[l_ac].gzac014, 
                      g_gzac_d[l_ac].gzac015,g_gzac_d[l_ac].gzac016,g_gzac_d[l_ac].gzac017,g_gzac_d[l_ac].gzac018, 
                      g_gzac_d[l_ac].gzac019,g_gzac_d[l_ac].gzac020,g_gzac_d[l_ac].gzac021,g_gzac_d[l_ac].gzac022 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzac_d_t.gzac002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzac_d_mask_o[l_ac].* =  g_gzac_d[l_ac].*
                  CALL azzi650_gzac_t_mask()
                  LET g_gzac_d_mask_n[l_ac].* =  g_gzac_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi650_show()
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
            INITIALIZE g_gzac_d[l_ac].* TO NULL 
            INITIALIZE g_gzac_d_t.* TO NULL 
            INITIALIZE g_gzac_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_gzac_d_t.* = g_gzac_d[l_ac].*     #新輸入資料
            LET g_gzac_d_o.* = g_gzac_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi650_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL azzi650_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzac_d[li_reproduce_target].* = g_gzac_d[li_reproduce].*
 
               LET g_gzac_d[li_reproduce_target].gzac002 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM gzac_t 
             WHERE  gzac001 = g_gzaa_m.gzaa001
 
               AND gzac002 = g_gzac_d[l_ac].gzac002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzaa_m.gzaa001
               LET gs_keys[2] = g_gzac_d[g_detail_idx].gzac002
               CALL azzi650_insert_b('gzac_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_gzac_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzac_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi650_b_fill()
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
               LET gs_keys[01] = g_gzaa_m.gzaa001
 
               LET gs_keys[gs_keys.getLength()+1] = g_gzac_d_t.gzac002
 
            
               #刪除同層單身
               IF NOT azzi650_delete_b('gzac_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi650_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi650_key_delete_b(gs_keys,'gzac_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi650_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi650_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
 
               #end add-point
               LET l_count = g_gzac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzac_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac002
            #add-point:BEFORE FIELD gzac002 name="input.b.page1.gzac002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac002
            
            #add-point:AFTER FIELD gzac002 name="input.a.page1.gzac002"
#此段落由子樣板a05產生
            IF  NOT cl_null(g_gzaa_m.gzaa001) AND NOT cl_null(g_gzac_d[l_ac].gzac002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_gzaa_m.gzaa001 != g_gzaa_m_t.gzaa001 OR g_gzac_d[l_ac].gzac002 != g_gzac_d_t.gzac002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzac_t WHERE "||"gzac001 = '"||g_gzaa_m.gzaa001 ||"' AND "|| "gzac002 = '"||g_gzac_d[l_ac].gzac002 ||"'",'std-00004',0) THEN 
                     IF l_cmd = 'a' THEN 
                        LET g_gzac_d[l_ac].gzac002 = ''
                     ELSE
                        LET g_gzac_d[l_ac].gzac002 =  g_gzac_d_t.gzac002 
                     END IF 
                     NEXT FIELD gzac002
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac002
            #add-point:ON CHANGE gzac002 name="input.g.page1.gzac002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac023
            #add-point:BEFORE FIELD gzac023 name="input.b.page1.gzac023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac023
            
            #add-point:AFTER FIELD gzac023 name="input.a.page1.gzac023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac023
            #add-point:ON CHANGE gzac023 name="input.g.page1.gzac023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac024
            #add-point:BEFORE FIELD gzac024 name="input.b.page1.gzac024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac024
            
            #add-point:AFTER FIELD gzac024 name="input.a.page1.gzac024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac024
            #add-point:ON CHANGE gzac024 name="input.g.page1.gzac024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac003
            #add-point:BEFORE FIELD gzac003 name="input.b.page1.gzac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac003
            
            #add-point:AFTER FIELD gzac003 name="input.a.page1.gzac003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac003
            #add-point:ON CHANGE gzac003 name="input.g.page1.gzac003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac004
            #add-point:BEFORE FIELD gzac004 name="input.b.page1.gzac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac004
            
            #add-point:AFTER FIELD gzac004 name="input.a.page1.gzac004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac004
            #add-point:ON CHANGE gzac004 name="input.g.page1.gzac004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac005
            #add-point:BEFORE FIELD gzac005 name="input.b.page1.gzac005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac005
            
            #add-point:AFTER FIELD gzac005 name="input.a.page1.gzac005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac005
            #add-point:ON CHANGE gzac005 name="input.g.page1.gzac005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac006
            #add-point:BEFORE FIELD gzac006 name="input.b.page1.gzac006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac006
            
            #add-point:AFTER FIELD gzac006 name="input.a.page1.gzac006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac006
            #add-point:ON CHANGE gzac006 name="input.g.page1.gzac006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac007
            #add-point:BEFORE FIELD gzac007 name="input.b.page1.gzac007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac007
            
            #add-point:AFTER FIELD gzac007 name="input.a.page1.gzac007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac007
            #add-point:ON CHANGE gzac007 name="input.g.page1.gzac007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac008
            #add-point:BEFORE FIELD gzac008 name="input.b.page1.gzac008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac008
            
            #add-point:AFTER FIELD gzac008 name="input.a.page1.gzac008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac008
            #add-point:ON CHANGE gzac008 name="input.g.page1.gzac008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac009
            #add-point:BEFORE FIELD gzac009 name="input.b.page1.gzac009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac009
            
            #add-point:AFTER FIELD gzac009 name="input.a.page1.gzac009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac009
            #add-point:ON CHANGE gzac009 name="input.g.page1.gzac009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac010
            #add-point:BEFORE FIELD gzac010 name="input.b.page1.gzac010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac010
            
            #add-point:AFTER FIELD gzac010 name="input.a.page1.gzac010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac010
            #add-point:ON CHANGE gzac010 name="input.g.page1.gzac010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac011
            #add-point:BEFORE FIELD gzac011 name="input.b.page1.gzac011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac011
            
            #add-point:AFTER FIELD gzac011 name="input.a.page1.gzac011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac011
            #add-point:ON CHANGE gzac011 name="input.g.page1.gzac011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac012
            #add-point:BEFORE FIELD gzac012 name="input.b.page1.gzac012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac012
            
            #add-point:AFTER FIELD gzac012 name="input.a.page1.gzac012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac012
            #add-point:ON CHANGE gzac012 name="input.g.page1.gzac012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac013
            #add-point:BEFORE FIELD gzac013 name="input.b.page1.gzac013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac013
            
            #add-point:AFTER FIELD gzac013 name="input.a.page1.gzac013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac013
            #add-point:ON CHANGE gzac013 name="input.g.page1.gzac013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac014
            #add-point:BEFORE FIELD gzac014 name="input.b.page1.gzac014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac014
            
            #add-point:AFTER FIELD gzac014 name="input.a.page1.gzac014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac014
            #add-point:ON CHANGE gzac014 name="input.g.page1.gzac014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac015
            #add-point:BEFORE FIELD gzac015 name="input.b.page1.gzac015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac015
            
            #add-point:AFTER FIELD gzac015 name="input.a.page1.gzac015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac015
            #add-point:ON CHANGE gzac015 name="input.g.page1.gzac015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac016
            #add-point:BEFORE FIELD gzac016 name="input.b.page1.gzac016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac016
            
            #add-point:AFTER FIELD gzac016 name="input.a.page1.gzac016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac016
            #add-point:ON CHANGE gzac016 name="input.g.page1.gzac016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac017
            #add-point:BEFORE FIELD gzac017 name="input.b.page1.gzac017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac017
            
            #add-point:AFTER FIELD gzac017 name="input.a.page1.gzac017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac017
            #add-point:ON CHANGE gzac017 name="input.g.page1.gzac017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac018
            #add-point:BEFORE FIELD gzac018 name="input.b.page1.gzac018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac018
            
            #add-point:AFTER FIELD gzac018 name="input.a.page1.gzac018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac018
            #add-point:ON CHANGE gzac018 name="input.g.page1.gzac018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac019
            #add-point:BEFORE FIELD gzac019 name="input.b.page1.gzac019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac019
            
            #add-point:AFTER FIELD gzac019 name="input.a.page1.gzac019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac019
            #add-point:ON CHANGE gzac019 name="input.g.page1.gzac019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac020
            #add-point:BEFORE FIELD gzac020 name="input.b.page1.gzac020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac020
            
            #add-point:AFTER FIELD gzac020 name="input.a.page1.gzac020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac020
            #add-point:ON CHANGE gzac020 name="input.g.page1.gzac020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac021
            #add-point:BEFORE FIELD gzac021 name="input.b.page1.gzac021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac021
            
            #add-point:AFTER FIELD gzac021 name="input.a.page1.gzac021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac021
            #add-point:ON CHANGE gzac021 name="input.g.page1.gzac021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzac022
            #add-point:BEFORE FIELD gzac022 name="input.b.page1.gzac022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzac022
            
            #add-point:AFTER FIELD gzac022 name="input.a.page1.gzac022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzac022
            #add-point:ON CHANGE gzac022 name="input.g.page1.gzac022"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzac002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac002
            #add-point:ON ACTION controlp INFIELD gzac002 name="input.c.page1.gzac002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac023
            #add-point:ON ACTION controlp INFIELD gzac023 name="input.c.page1.gzac023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac024
            #add-point:ON ACTION controlp INFIELD gzac024 name="input.c.page1.gzac024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac003
            #add-point:ON ACTION controlp INFIELD gzac003 name="input.c.page1.gzac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac004
            #add-point:ON ACTION controlp INFIELD gzac004 name="input.c.page1.gzac004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac005
            #add-point:ON ACTION controlp INFIELD gzac005 name="input.c.page1.gzac005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac006
            #add-point:ON ACTION controlp INFIELD gzac006 name="input.c.page1.gzac006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac007
            #add-point:ON ACTION controlp INFIELD gzac007 name="input.c.page1.gzac007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac008
            #add-point:ON ACTION controlp INFIELD gzac008 name="input.c.page1.gzac008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac009
            #add-point:ON ACTION controlp INFIELD gzac009 name="input.c.page1.gzac009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac010
            #add-point:ON ACTION controlp INFIELD gzac010 name="input.c.page1.gzac010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac011
            #add-point:ON ACTION controlp INFIELD gzac011 name="input.c.page1.gzac011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac012
            #add-point:ON ACTION controlp INFIELD gzac012 name="input.c.page1.gzac012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac013
            #add-point:ON ACTION controlp INFIELD gzac013 name="input.c.page1.gzac013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac014
            #add-point:ON ACTION controlp INFIELD gzac014 name="input.c.page1.gzac014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac015
            #add-point:ON ACTION controlp INFIELD gzac015 name="input.c.page1.gzac015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac016
            #add-point:ON ACTION controlp INFIELD gzac016 name="input.c.page1.gzac016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac017
            #add-point:ON ACTION controlp INFIELD gzac017 name="input.c.page1.gzac017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac018
            #add-point:ON ACTION controlp INFIELD gzac018 name="input.c.page1.gzac018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac019
            #add-point:ON ACTION controlp INFIELD gzac019 name="input.c.page1.gzac019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac020
            #add-point:ON ACTION controlp INFIELD gzac020 name="input.c.page1.gzac020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac021
            #add-point:ON ACTION controlp INFIELD gzac021 name="input.c.page1.gzac021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzac022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzac022
            #add-point:ON ACTION controlp INFIELD gzac022 name="input.c.page1.gzac022"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzac_d[l_ac].* = g_gzac_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi650_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gzac_d[l_ac].gzac002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gzac_d[l_ac].* = g_gzac_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL azzi650_gzac_t_mask_restore('restore_mask_o')
      
               UPDATE gzac_t SET (gzac001,gzac002,gzac023,gzac024,gzac003,gzac004,gzac005,gzac006,gzac007, 
                   gzac008,gzac009,gzac010,gzac011,gzac012,gzac013,gzac014,gzac015,gzac016,gzac017,gzac018, 
                   gzac019,gzac020,gzac021,gzac022) = (g_gzaa_m.gzaa001,g_gzac_d[l_ac].gzac002,g_gzac_d[l_ac].gzac023, 
                   g_gzac_d[l_ac].gzac024,g_gzac_d[l_ac].gzac003,g_gzac_d[l_ac].gzac004,g_gzac_d[l_ac].gzac005, 
                   g_gzac_d[l_ac].gzac006,g_gzac_d[l_ac].gzac007,g_gzac_d[l_ac].gzac008,g_gzac_d[l_ac].gzac009, 
                   g_gzac_d[l_ac].gzac010,g_gzac_d[l_ac].gzac011,g_gzac_d[l_ac].gzac012,g_gzac_d[l_ac].gzac013, 
                   g_gzac_d[l_ac].gzac014,g_gzac_d[l_ac].gzac015,g_gzac_d[l_ac].gzac016,g_gzac_d[l_ac].gzac017, 
                   g_gzac_d[l_ac].gzac018,g_gzac_d[l_ac].gzac019,g_gzac_d[l_ac].gzac020,g_gzac_d[l_ac].gzac021, 
                   g_gzac_d[l_ac].gzac022)
                WHERE  gzac001 = g_gzaa_m.gzaa001 
 
                  AND gzac002 = g_gzac_d_t.gzac002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gzac_d[l_ac].* = g_gzac_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzac_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gzac_d[l_ac].* = g_gzac_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzac_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzaa_m.gzaa001
               LET gs_keys_bak[1] = g_gzaa001_t
               LET gs_keys[2] = g_gzac_d[g_detail_idx].gzac002
               LET gs_keys_bak[2] = g_gzac_d_t.gzac002
               CALL azzi650_update_b('gzac_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL azzi650_gzac_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gzac_d[g_detail_idx].gzac002 = g_gzac_d_t.gzac002 
 
                  ) THEN
                  LET gs_keys[01] = g_gzaa_m.gzaa001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gzac_d_t.gzac002
 
                  CALL azzi650_key_update_b(gs_keys,'gzac_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzaa_m),util.JSON.stringify(g_gzac_d_t)
               LET g_log2 = util.JSON.stringify(g_gzaa_m),util.JSON.stringify(g_gzac_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
 
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL azzi650_unlock_b("gzac_t","'1'")
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
               LET g_gzac_d[li_reproduce_target].* = g_gzac_d[li_reproduce].*
 
               LET g_gzac_d[li_reproduce_target].gzac002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzac_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzac_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_gzac2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzac2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi650_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_gzac2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            #2015/01/23 by stellar add ----- (S)
            #若是客製，則該單身的欄位都不可輸入
            IF g_dgenv = 'c' THEN
               NEXT FIELD gzaal003
            END IF
            #2015/01/23 by stellar add ----- (E)
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzac2_d[l_ac].* TO NULL 
            INITIALIZE g_gzac2_d_t.* TO NULL 
            INITIALIZE g_gzac2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_gzac2_d[l_ac].gzad003 = "N"
      LET g_gzac2_d[l_ac].gzad004 = "Y"
      LET g_gzac2_d[l_ac].gzad005 = "2"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_gzac2_d_t.* = g_gzac2_d[l_ac].*     #新輸入資料
            LET g_gzac2_d_o.* = g_gzac2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi650_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL azzi650_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzac2_d[li_reproduce_target].* = g_gzac2_d[li_reproduce].*
 
               LET g_gzac2_d[li_reproduce_target].gzad002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            CALL azzi650_gzad_entry_set()
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            IF g_gzac2_d[l_ac].gzad002 >0 AND g_gzac2_d[l_ac].gzad002 <= 5 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '1'
            END IF 
            IF g_gzac2_d[l_ac].gzad002 >5 AND g_gzac2_d[l_ac].gzad002 <= 10 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '2'
            END IF
            IF g_gzac2_d[l_ac].gzad002 >10 AND g_gzac2_d[l_ac].gzad002 <= 15 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '3'
            END IF
            IF g_gzac2_d[l_ac].gzad002 >15 AND g_gzac2_d[l_ac].gzad002 <= 18 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '4'
            END IF
            IF g_gzac2_d[l_ac].gzad002 >18 AND g_gzac2_d[l_ac].gzad002 <= 20 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '5'
            END IF
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
            OPEN azzi650_cl USING g_gzaa_m.gzaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi650_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi650_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gzac2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzac2_d[l_ac].gzad002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gzac2_d_t.* = g_gzac2_d[l_ac].*  #BACKUP
               LET g_gzac2_d_o.* = g_gzac2_d[l_ac].*  #BACKUP
               CALL azzi650_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL azzi650_set_no_entry_b(l_cmd)
               IF NOT azzi650_lock_b("gzad_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi650_bcl2 INTO g_gzac2_d[l_ac].gzad002,g_gzac2_d[l_ac].gzad003,g_gzac2_d[l_ac].gzad004, 
                      g_gzac2_d[l_ac].gzad005,g_gzac2_d[l_ac].gzad006,g_gzac2_d[l_ac].gzad007,g_gzac2_d[l_ac].gzad008, 
                      g_gzac2_d[l_ac].gzad015,g_gzac2_d[l_ac].gzad016,g_gzac2_d[l_ac].gzad017,g_gzac2_d[l_ac].gzad009, 
                      g_gzac2_d[l_ac].gzad014,g_gzac2_d[l_ac].gzad010,g_gzac2_d[l_ac].gzad011,g_gzac2_d[l_ac].gzad012, 
                      g_gzac2_d[l_ac].gzad013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzac2_d_mask_o[l_ac].* =  g_gzac2_d[l_ac].*
                  CALL azzi650_gzad_t_mask()
                  LET g_gzac2_d_mask_n[l_ac].* =  g_gzac2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi650_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            CALL azzi650_gzad_entry_set()
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            IF g_gzac2_d[l_ac].gzad002 >0 AND g_gzac2_d[l_ac].gzad002 <= 5 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '1'
            END IF 
            IF g_gzac2_d[l_ac].gzad002 >5 AND g_gzac2_d[l_ac].gzad002 <= 10 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '2'
            END IF
            IF g_gzac2_d[l_ac].gzad002 >10 AND g_gzac2_d[l_ac].gzad002 <= 15 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '3'
            END IF
            IF g_gzac2_d[l_ac].gzad002 >15 AND g_gzac2_d[l_ac].gzad002 <= 18 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '4'
            END IF
            IF g_gzac2_d[l_ac].gzad002 >18 AND g_gzac2_d[l_ac].gzad002 <= 20 THEN
               LET g_gzac2_d[l_ac].l_ref_style = '5'
            END IF
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
               LET gs_keys[01] = g_gzaa_m.gzaa001
               LET gs_keys[gs_keys.getLength()+1] = g_gzac2_d_t.gzad002
            
               #刪除同層單身
               IF NOT azzi650_delete_b('gzad_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi650_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi650_key_delete_b(gs_keys,'gzad_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi650_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi650_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               LET g_chk_azzi650 = TRUE
               #end add-point
               LET l_count = g_gzac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzac2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM gzad_t 
             WHERE  gzad001 = g_gzaa_m.gzaa001
               AND gzad002 = g_gzac2_d[l_ac].gzad002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzaa_m.gzaa001
               LET gs_keys[2] = g_gzac2_d[g_detail_idx].gzad002
               CALL azzi650_insert_b('gzad_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gzac_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzad_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi650_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               LET g_chk_azzi650 = TRUE
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzac2_d[l_ac].* = g_gzac2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi650_bcl2
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
               LET g_gzac2_d[l_ac].* = g_gzac2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL azzi650_gzad_t_mask_restore('restore_mask_o')
                              
               UPDATE gzad_t SET (gzad001,gzad002,gzad003,gzad004,gzad005,gzad006,gzad007,gzad008,gzad015, 
                   gzad016,gzad017,gzad009,gzad014,gzad010,gzad011,gzad012,gzad013) = (g_gzaa_m.gzaa001, 
                   g_gzac2_d[l_ac].gzad002,g_gzac2_d[l_ac].gzad003,g_gzac2_d[l_ac].gzad004,g_gzac2_d[l_ac].gzad005, 
                   g_gzac2_d[l_ac].gzad006,g_gzac2_d[l_ac].gzad007,g_gzac2_d[l_ac].gzad008,g_gzac2_d[l_ac].gzad015, 
                   g_gzac2_d[l_ac].gzad016,g_gzac2_d[l_ac].gzad017,g_gzac2_d[l_ac].gzad009,g_gzac2_d[l_ac].gzad014, 
                   g_gzac2_d[l_ac].gzad010,g_gzac2_d[l_ac].gzad011,g_gzac2_d[l_ac].gzad012,g_gzac2_d[l_ac].gzad013)  
                   #自訂欄位頁簽
                WHERE  gzad001 = g_gzaa_m.gzaa001
                  AND gzad002 = g_gzac2_d_t.gzad002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gzac2_d[l_ac].* = g_gzac2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzad_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gzac2_d[l_ac].* = g_gzac2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzad_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzaa_m.gzaa001
               LET gs_keys_bak[1] = g_gzaa001_t
               LET gs_keys[2] = g_gzac2_d[g_detail_idx].gzad002
               LET gs_keys_bak[2] = g_gzac2_d_t.gzad002
               CALL azzi650_update_b('gzad_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi650_gzad_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_gzac2_d[g_detail_idx].gzad002 = g_gzac2_d_t.gzad002 
                  ) THEN
                  LET gs_keys[01] = g_gzaa_m.gzaa001
                  LET gs_keys[gs_keys.getLength()+1] = g_gzac2_d_t.gzad002
                  CALL azzi650_key_update_b(gs_keys,'gzad_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzaa_m),util.JSON.stringify(g_gzac2_d_t)
               LET g_log2 = util.JSON.stringify(g_gzaa_m),util.JSON.stringify(g_gzac2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               #還在Transaction中表示AFTER ROW那邊會做s_transaction_end('Y','0')
               IF s_transaction_chk('Y',0) THEN
                  LET g_chk_azzi650 = TRUE
               END IF
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad002
            
            #add-point:AFTER FIELD gzad002 name="input.a.page2.gzad002"
#此段落由子樣板a05產生
            IF  NOT cl_null(g_gzaa_m.gzaa001) AND NOT cl_null(g_gzac2_d[l_ac].gzad002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_gzaa_m.gzaa001 != g_gzaa001_t OR g_gzac2_d[l_ac].gzad002 != g_gzac2_d_t.gzad002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzad_t WHERE "||"gzad001 = '"||g_gzaa_m.gzaa001 ||"' AND "|| "gzad002 = '"||g_gzac2_d[l_ac].gzad002 ||"'",'std-00004',0) THEN 
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad002
            #add-point:BEFORE FIELD gzad002 name="input.b.page2.gzad002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad002
            #add-point:ON CHANGE gzad002 name="input.g.page2.gzad002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_ref_style
            #add-point:BEFORE FIELD l_ref_style name="input.b.page2.l_ref_style"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_ref_style
            
            #add-point:AFTER FIELD l_ref_style name="input.a.page2.l_ref_style"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_ref_style
            #add-point:ON CHANGE l_ref_style name="input.g.page2.l_ref_style"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad003
            #add-point:BEFORE FIELD gzad003 name="input.b.page2.gzad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad003
            
            #add-point:AFTER FIELD gzad003 name="input.a.page2.gzad003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad003
            #add-point:ON CHANGE gzad003 name="input.g.page2.gzad003"
            IF g_gzac2_d[l_ac].gzad002 <= 10 AND g_gzac2_d[l_ac].gzad003 = 'Y' THEN
               IF g_gzac2_d[l_ac].gzad002 >5 THEN
                  LET g_gzac2_d[l_ac].gzad005 = '3'
               ELSE
                  LET g_gzac2_d[l_ac].gzad005 = '2'
               END IF 
            END IF 
            IF g_gzac2_d[l_ac].gzad002 > 10 AND g_gzac2_d[l_ac].gzad003 = 'Y' THEN
               CALL cl_set_comp_entry('gzad005',FALSE)
               IF g_gzac2_d[l_ac].gzad002 <=15 then
                  LET g_gzac2_d[l_ac].gzad005 = '3'
               ELSE
                  IF g_gzac2_d[l_ac].gzad002 <=18 THEN
                     LET g_gzac2_d[l_ac].gzad005 = '1'
                  ELSE
                     LET g_gzac2_d[l_ac].gzad005 = '3'
                  END IF 
               END IF 
            END IF
            CALL azzi650_gzad_entry_set()
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad004
            #add-point:BEFORE FIELD gzad004 name="input.b.page2.gzad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad004
            
            #add-point:AFTER FIELD gzad004 name="input.a.page2.gzad004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad004
            #add-point:ON CHANGE gzad004 name="input.g.page2.gzad004"
            CALL azzi650_gzad_entry_set()
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad005
            #add-point:BEFORE FIELD gzad005 name="input.b.page2.gzad005"
         
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad005
            
            #add-point:AFTER FIELD gzad005 name="input.a.page2.gzad005"
            CALL azzi650_gzad005_bak_old()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad005
            #add-point:ON CHANGE gzad005 name="input.g.page2.gzad005"
            CALL azzi650_gzad_entry_set()
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad006
            
            #add-point:AFTER FIELD gzad006 name="input.a.page2.gzad006"
            DISPLAY ' ' TO g_gzac2_d[l_ac].gzad006_desc
            
            #150415 by whitney modify start 優化錯誤訊息
            #CALL azzi650_gzad006_chk() RETURNING l_result
            CALL azzi650_acc_chk(g_gzac2_d[l_ac].gzad005,g_gzac2_d[l_ac].gzad006) RETURNING l_result
            #150415 by whitney modify end
            IF NOT l_result THEN 
               LET g_gzac2_d[l_ac].gzad006 = g_gzac2_d_t.gzad006
               CALL azzi650_gzad006_ref()
               NEXT FIELD gzad006
            END IF

            CALL azzi650_gzad006_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad006
            #add-point:BEFORE FIELD gzad006 name="input.b.page2.gzad006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad006
            #add-point:ON CHANGE gzad006 name="input.g.page2.gzad006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad007
            
            #add-point:AFTER FIELD gzad007 name="input.a.page2.gzad007"
            IF g_gzac2_d[l_ac].gzad005 != '1' AND g_gzac2_d[l_ac].gzad005 != '4' AND  NOT cl_null(g_gzac2_d[l_ac].gzad007) THEN
               CALL azzi650_gzad007_chk() RETURNING l_result
            END IF 
            IF l_result = '1' THEN 
               LET g_gzac2_d[l_ac].gzad007 = g_gzac2_d_t.gzad007
               NEXT FIELD gzad007
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad007
            #add-point:BEFORE FIELD gzad007 name="input.b.page2.gzad007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad007
            #add-point:ON CHANGE gzad007 name="input.g.page2.gzad007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad008
            
            #add-point:AFTER FIELD gzad008 name="input.a.page2.gzad008"
            LET l_result = '0' 
            IF g_gzac2_d[l_ac].gzad005 != '1' AND g_gzac2_d[l_ac].gzad005 != '4' AND  NOT cl_null(g_gzac2_d[l_ac].gzad008) THEN
               CALL azzi650_gzad008_chk() RETURNING l_result
            END IF 
            IF l_result = '1' THEN 
               LET g_gzac2_d[l_ac].gzad008 = g_gzac2_d_t.gzad008
               NEXT FIELD gzad008
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad008
            #add-point:BEFORE FIELD gzad008 name="input.b.page2.gzad008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad008
            #add-point:ON CHANGE gzad008 name="input.g.page2.gzad008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad015
            #add-point:BEFORE FIELD gzad015 name="input.b.page2.gzad015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad015
            
            #add-point:AFTER FIELD gzad015 name="input.a.page2.gzad015"
            IF NOT cl_null(g_gzac2_d[l_ac].gzad015) THEN 
               LET li_count = 0
               SELECT COUNT(*) INTO li_count FROM dzea_t WHERE
                ((dzea001 IN (SELECT dzeb001 from
                (SELECT dzeb001,count(*) as count_key from dzeb_t  WHERE dzeb004 = 'Y' GROUP BY dzeb001) a
                 WHERE count_key = 2)  AND dzea004 !='L' AND dzea003 !='ADZ')
                OR ( dzea001 IN (SELECT dzeb001 from
                (SELECT dzeb001,count(*) as count_key from dzeb_t  WHERE dzeb004 = 'Y' GROUP BY dzeb001) b 
                 WHERE  count_key = 3)  AND dzea004 ='L')
                 OR ( dzea001 IN (SELECT dzeb001 from
                (SELECT dzeb001,count(*) as count_key from dzeb_t  WHERE dzeb004 = 'Y' GROUP BY dzeb001) c 
                 WHERE  count_key = 2)  AND dzea004 ='L' AND dzea003 = 'ADZ'))
                  AND dzea001 = g_gzac2_d[l_ac].gzad015
               IF li_count = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00062"
                  LET g_errparam.extend = g_gzac2_d[l_ac].gzad015
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  IF p_cmd = 'a' THEN 
                     LET g_gzac2_d[l_ac].gzad015 =''
                  ELSE
                     LET g_gzac2_d[l_ac].gzad015 =g_gzac2_d_t.gzad015
                  END IF 
                  NEXT FIELD gzad015
               END IF 
               IF NOT cl_null(g_gzac2_d[l_ac].gzad016) THEN 
                  LET li_count = 0
                  SELECT COUNT(*) INTO li_count FROM dzeb_t WHERE
                   dzeb004 = 'N' AND dzeb001 = g_gzac2_d[l_ac].gzad015 AND dzeb002 = g_gzac2_d[l_ac].gzad016
                  IF li_count = 0 THEN 
                     LET g_gzac2_d[l_ac].gzad016 = ''
                     NEXT FIELD gzad016
                  END IF 
               END IF
               IF NOT cl_null(g_gzac2_d[l_ac].gzad017) THEN 
                  LET li_count = 0
                  SELECT COUNT(*) INTO li_count FROM dzeb_t WHERE
                   dzeb004 = 'Y' AND dzeb006 != 'C800' AND dzeb002 NOT LIKE '%ent' AND dzeb001 = g_gzac2_d[l_ac].gzad015 
                   AND dzeb002 = g_gzac2_d[l_ac].gzad017
                   IF li_count = 0 THEN 
                      LET g_gzac2_d[l_ac].gzad017 = ''
                      NEXT FIELD gzad017
                  END IF 
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad015
            #add-point:ON CHANGE gzad015 name="input.g.page2.gzad015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad016
            #add-point:BEFORE FIELD gzad016 name="input.b.page2.gzad016"
            IF cl_null(g_gzac2_d[l_ac].gzad015) THEN
               NEXT FIELD gzad015
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad016
            
            #add-point:AFTER FIELD gzad016 name="input.a.page2.gzad016"
            IF NOT cl_null(g_gzac2_d[l_ac].gzad016) THEN 
               LET li_count = 0
               SELECT COUNT(*) INTO li_count FROM dzeb_t WHERE
                dzeb004 = 'N' AND dzeb001 = g_gzac2_d[l_ac].gzad015 AND dzeb002 = g_gzac2_d[l_ac].gzad016
               IF li_count = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00063"
                  LET g_errparam.extend = g_gzac2_d[l_ac].gzad016
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_gzac2_d[l_ac].gzad016 = ''
                  NEXT FIELD gzad016
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad016
            #add-point:ON CHANGE gzad016 name="input.g.page2.gzad016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad017
            #add-point:BEFORE FIELD gzad017 name="input.b.page2.gzad017"
            IF cl_null(g_gzac2_d[l_ac].gzad015) THEN
               NEXT FIELD gzad015
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad017
            
            #add-point:AFTER FIELD gzad017 name="input.a.page2.gzad017"
            IF NOT cl_null(g_gzac2_d[l_ac].gzad017) THEN 
               LET li_count = 0
               SELECT COUNT(*) INTO li_count FROM dzeb_t WHERE
                dzeb004 = 'Y' AND dzeb006 != 'C800' AND dzeb002 NOT LIKE '%ent' AND dzeb001 = g_gzac2_d[l_ac].gzad015 
                AND dzeb002 = g_gzac2_d[l_ac].gzad017
               IF li_count = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00064"
                  LET g_errparam.extend = g_gzac2_d[l_ac].gzad017
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_gzac2_d[l_ac].gzad017 = ''
                  NEXT FIELD gzad017
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad017
            #add-point:ON CHANGE gzad017 name="input.g.page2.gzad017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad009
            #add-point:BEFORE FIELD gzad009 name="input.b.page2.gzad009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad009
            
            #add-point:AFTER FIELD gzad009 name="input.a.page2.gzad009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad009
            #add-point:ON CHANGE gzad009 name="input.g.page2.gzad009"
            CALL azzi650_gzad_entry_set()
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            CALL azzi650_gzad009_bak_old()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad014
            #add-point:BEFORE FIELD gzad014 name="input.b.page2.gzad014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad014
            
            #add-point:AFTER FIELD gzad014 name="input.a.page2.gzad014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad014
            #add-point:ON CHANGE gzad014 name="input.g.page2.gzad014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad010
            #add-point:BEFORE FIELD gzad010 name="input.b.page2.gzad010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad010
            
            #add-point:AFTER FIELD gzad010 name="input.a.page2.gzad010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad010
            #add-point:ON CHANGE gzad010 name="input.g.page2.gzad010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad011
            #add-point:BEFORE FIELD gzad011 name="input.b.page2.gzad011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad011
            
            #add-point:AFTER FIELD gzad011 name="input.a.page2.gzad011"
            CALL azzi650_gzad011_chk() RETURNING l_result
            IF l_result = '1' THEN 
               LET g_gzac2_d[l_ac].gzad011 = g_gzac2_d_t.gzad011
               NEXT FIELD gzad011
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad011
            #add-point:ON CHANGE gzad011 name="input.g.page2.gzad011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad012
            #add-point:BEFORE FIELD gzad012 name="input.b.page2.gzad012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad012
            
            #add-point:AFTER FIELD gzad012 name="input.a.page2.gzad012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad012
            #add-point:ON CHANGE gzad012 name="input.g.page2.gzad012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzad013
            #add-point:BEFORE FIELD gzad013 name="input.b.page2.gzad013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzad013
            
            #add-point:AFTER FIELD gzad013 name="input.a.page2.gzad013"
            CALL azzi650_gzad013_chk() RETURNING l_result
            IF l_result = '1' THEN 
               LET g_gzac2_d[l_ac].gzad013 = g_gzac2_d_t.gzad013
               NEXT FIELD gzad013
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzad013
            #add-point:ON CHANGE gzad013 name="input.g.page2.gzad013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.gzad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad002
            #add-point:ON ACTION controlp INFIELD gzad002 name="input.c.page2.gzad002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_ref_style
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_ref_style
            #add-point:ON ACTION controlp INFIELD l_ref_style name="input.c.page2.l_ref_style"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad003
            #add-point:ON ACTION controlp INFIELD gzad003 name="input.c.page2.gzad003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad004
            #add-point:ON ACTION controlp INFIELD gzad004 name="input.c.page2.gzad004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad005
            #add-point:ON ACTION controlp INFIELD gzad005 name="input.c.page2.gzad005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad006
            #add-point:ON ACTION controlp INFIELD gzad006 name="input.c.page2.gzad006"
#此段落由子樣板a07產生            
            #開窗i段
            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac2_d[l_ac].gzad006             #給予default值
            IF g_gzac2_d[l_ac].gzad005 = '1' THEN
               #給予arg
               LET g_qryparam.where = " gzcastus = 'Y' "
               CALL q_gzca001()                                #呼叫開窗
            ELSE 
               #給予arg
               LET g_qryparam.where = " gzaastus = 'Y' "
               CALL q_gzaa001()                                
            END IF 
            LET g_gzac2_d[l_ac].gzad006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ""
            DISPLAY g_gzac2_d[l_ac].gzad006 TO gzad006              #顯示到畫面上

            NEXT FIELD gzad006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad007
            #add-point:ON ACTION controlp INFIELD gzad007 name="input.c.page2.gzad007"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac2_d[l_ac].gzad007             #給予default值
            
            #給予arg

            CALL q_dzca001_02()                                #呼叫開窗

            LET g_gzac2_d[l_ac].gzad007 = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            DISPLAY g_gzac2_d[l_ac].gzad007 TO gzad007              #顯示到畫面上

            NEXT FIELD gzad007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad008
            #add-point:ON ACTION controlp INFIELD gzad008 name="input.c.page2.gzad008"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac2_d[l_ac].gzad008             #給予default值
            LET g_qryparam.default2 = "" #g_gzac2_d[l_ac].dzcd001 #校驗帶值識別碼
            #給予arg
            
            CALL q_dzcd001_01()                                #呼叫開窗

            LET g_gzac2_d[l_ac].gzad008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_gzac2_d[l_ac].dzcd001 = g_qryparam.return2 #校驗帶值識別碼
            DISPLAY g_gzac2_d[l_ac].gzad008 TO gzad008              #顯示到畫面上
            #DISPLAY g_gzac2_d[l_ac].dzcd001 TO dzcd001 #校驗帶值識別碼

            NEXT FIELD gzad008                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad015
            #add-point:ON ACTION controlp INFIELD gzad015 name="input.c.page2.gzad015"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac2_d[l_ac].gzad015             #給予default值

            #給予arg
            
            CALL q_dzea001_1()                                #呼叫開窗

            LET g_gzac2_d[l_ac].gzad015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gzac2_d[l_ac].gzad015 TO gzad015              #顯示到畫面上

            NEXT FIELD gzad015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad016
            #add-point:ON ACTION controlp INFIELD gzad016 name="input.c.page2.gzad016"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac2_d[l_ac].gzad016             #給予default值
            LET g_qryparam.default2 = "" #g_gzac2_d[l_ac].dzeb003 #欄位名稱

            #給予arg
            LET g_qryparam.where = " dzeb004 = 'N' AND dzeb001 = '",g_gzac2_d[l_ac].gzad015,"'"
            CALL q_dzeb001()                                #呼叫開窗

            LET g_gzac2_d[l_ac].gzad016 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_gzac2_d[l_ac].dzeb003 = g_qryparam.return2 #欄位名稱
            LET g_qryparam.where = ""
            DISPLAY g_gzac2_d[l_ac].gzad016 TO gzad016              #顯示到畫面上
            #DISPLAY g_gzac2_d[l_ac].dzeb003 TO dzeb003 #欄位名稱

            NEXT FIELD gzad016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad017
            #add-point:ON ACTION controlp INFIELD gzad017 name="input.c.page2.gzad017"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac2_d[l_ac].gzad017             #給予default值
            LET g_qryparam.default2 = "" #g_gzac2_d[l_ac].dzeb003 #欄位名稱
            LET g_qryparam.where = " dzeb004 = 'Y' AND dzeb006 != 'C800' AND dzeb002 NOT LIKE '%ent' AND dzeb001 = '",g_gzac2_d[l_ac].gzad015,"'"
            
            #給予arg

            CALL q_dzeb001()                                #呼叫開窗

            LET g_gzac2_d[l_ac].gzad017 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_gzac2_d[l_ac].dzeb003 = g_qryparam.return2 #欄位名稱
            LET g_qryparam.where = ""
            DISPLAY g_gzac2_d[l_ac].gzad017 TO gzad017              #顯示到畫面上
            #DISPLAY g_gzac2_d[l_ac].dzeb003 TO dzeb003 #欄位名稱

            NEXT FIELD gzad017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad009
            #add-point:ON ACTION controlp INFIELD gzad009 name="input.c.page2.gzad009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad014
            #add-point:ON ACTION controlp INFIELD gzad014 name="input.c.page2.gzad014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad010
            #add-point:ON ACTION controlp INFIELD gzad010 name="input.c.page2.gzad010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad011
            #add-point:ON ACTION controlp INFIELD gzad011 name="input.c.page2.gzad011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad012
            #add-point:ON ACTION controlp INFIELD gzad012 name="input.c.page2.gzad012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.gzad013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzad013
            #add-point:ON ACTION controlp INFIELD gzad013 name="input.c.page2.gzad013"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzac2_d[l_ac].* = g_gzac2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi650_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL azzi650_unlock_b("gzad_t","'2'")
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
               LET g_gzac2_d[li_reproduce_target].* = g_gzac2_d[li_reproduce].*
 
               LET g_gzac2_d[li_reproduce_target].gzad002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzac2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzac2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_gzac3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzac3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi650_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_gzac3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzac3_d[l_ac].* TO NULL 
            INITIALIZE g_gzac3_d_t.* TO NULL 
            INITIALIZE g_gzac3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_gzac3_d_t.* = g_gzac3_d[l_ac].*     #新輸入資料
            LET g_gzac3_d_o.* = g_gzac3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi650_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL azzi650_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzac3_d[li_reproduce_target].* = g_gzac3_d[li_reproduce].*
 
               LET g_gzac3_d[li_reproduce_target].gzai002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
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
            OPEN azzi650_cl USING g_gzaa_m.gzaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi650_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi650_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gzac3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzac3_d[l_ac].gzai002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gzac3_d_t.* = g_gzac3_d[l_ac].*  #BACKUP
               LET g_gzac3_d_o.* = g_gzac3_d[l_ac].*  #BACKUP
               CALL azzi650_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL azzi650_set_no_entry_b(l_cmd)
               IF NOT azzi650_lock_b("gzai_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi650_bcl3 INTO g_gzac3_d[l_ac].gzai002,g_gzac3_d[l_ac].gzai003,g_gzac3_d[l_ac].gzai004, 
                      g_gzac3_d[l_ac].gzai005,g_gzac3_d[l_ac].gzai006,g_gzac3_d[l_ac].gzai007,g_gzac3_d[l_ac].gzai008, 
                      g_gzac3_d[l_ac].gzai009,g_gzac3_d[l_ac].gzai010,g_gzac3_d[l_ac].gzai011,g_gzac3_d[l_ac].gzai012, 
                      g_gzac3_d[l_ac].gzai013,g_gzac3_d[l_ac].gzai014,g_gzac3_d[l_ac].gzai015,g_gzac3_d[l_ac].gzai016, 
                      g_gzac3_d[l_ac].gzai017,g_gzac3_d[l_ac].gzai018,g_gzac3_d[l_ac].gzai019,g_gzac3_d[l_ac].gzai020, 
                      g_gzac3_d[l_ac].gzai021,g_gzac3_d[l_ac].gzai022
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzac3_d_mask_o[l_ac].* =  g_gzac3_d[l_ac].*
                  CALL azzi650_gzai_t_mask()
                  LET g_gzac3_d_mask_n[l_ac].* =  g_gzac3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi650_show()
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
               LET gs_keys[01] = g_gzaa_m.gzaa001
               LET gs_keys[gs_keys.getLength()+1] = g_gzac3_d_t.gzai002
            
               #刪除同層單身
               IF NOT azzi650_delete_b('gzai_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi650_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi650_key_delete_b(gs_keys,'gzai_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi650_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi650_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_gzac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzac3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM gzai_t 
             WHERE  gzai001 = g_gzaa_m.gzaa001
               AND gzai002 = g_gzac3_d[l_ac].gzai002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzaa_m.gzaa001
               LET gs_keys[2] = g_gzac3_d[g_detail_idx].gzai002
               CALL azzi650_insert_b('gzai_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gzac_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzai_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi650_b_fill()
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
               LET g_gzac3_d[l_ac].* = g_gzac3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi650_bcl3
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
               LET g_gzac3_d[l_ac].* = g_gzac3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL azzi650_gzai_t_mask_restore('restore_mask_o')
                              
               UPDATE gzai_t SET (gzai001,gzai002,gzai003,gzai004,gzai005,gzai006,gzai007,gzai008,gzai009, 
                   gzai010,gzai011,gzai012,gzai013,gzai014,gzai015,gzai016,gzai017,gzai018,gzai019,gzai020, 
                   gzai021,gzai022) = (g_gzaa_m.gzaa001,g_gzac3_d[l_ac].gzai002,g_gzac3_d[l_ac].gzai003, 
                   g_gzac3_d[l_ac].gzai004,g_gzac3_d[l_ac].gzai005,g_gzac3_d[l_ac].gzai006,g_gzac3_d[l_ac].gzai007, 
                   g_gzac3_d[l_ac].gzai008,g_gzac3_d[l_ac].gzai009,g_gzac3_d[l_ac].gzai010,g_gzac3_d[l_ac].gzai011, 
                   g_gzac3_d[l_ac].gzai012,g_gzac3_d[l_ac].gzai013,g_gzac3_d[l_ac].gzai014,g_gzac3_d[l_ac].gzai015, 
                   g_gzac3_d[l_ac].gzai016,g_gzac3_d[l_ac].gzai017,g_gzac3_d[l_ac].gzai018,g_gzac3_d[l_ac].gzai019, 
                   g_gzac3_d[l_ac].gzai020,g_gzac3_d[l_ac].gzai021,g_gzac3_d[l_ac].gzai022) #自訂欄位頁簽 
 
                WHERE  gzai001 = g_gzaa_m.gzaa001
                  AND gzai002 = g_gzac3_d_t.gzai002 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gzac3_d[l_ac].* = g_gzac3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzai_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gzac3_d[l_ac].* = g_gzac3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzai_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzaa_m.gzaa001
               LET gs_keys_bak[1] = g_gzaa001_t
               LET gs_keys[2] = g_gzac3_d[g_detail_idx].gzai002
               LET gs_keys_bak[2] = g_gzac3_d_t.gzai002
               CALL azzi650_update_b('gzai_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi650_gzai_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_gzac3_d[g_detail_idx].gzai002 = g_gzac3_d_t.gzai002 
                  ) THEN
                  LET gs_keys[01] = g_gzaa_m.gzaa001
                  LET gs_keys[gs_keys.getLength()+1] = g_gzac3_d_t.gzai002
                  CALL azzi650_key_update_b(gs_keys,'gzai_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzaa_m),util.JSON.stringify(g_gzac3_d_t)
               LET g_log2 = util.JSON.stringify(g_gzaa_m),util.JSON.stringify(g_gzac3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai002
            #add-point:BEFORE FIELD gzai002 name="input.b.page3.gzai002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai002
            
            #add-point:AFTER FIELD gzai002 name="input.a.page3.gzai002"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_gzaa_m.gzaa001 IS NOT NULL AND g_gzac3_d[g_detail_idx].gzai002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzaa_m.gzaa001 != g_gzaa001_t OR g_gzac3_d[g_detail_idx].gzai002 != g_gzac3_d_t.gzai002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzai_t WHERE "||"gzai001 = '"||g_gzaa_m.gzaa001 ||"' AND "|| "gzai002 = '"||g_gzac3_d[g_detail_idx].gzai002 ||"'",'std-00004',0) THEN 
                     LET g_gzac_d[l_ac].gzac002 =  g_gzac_d_t.gzac002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai002
            #add-point:ON CHANGE gzai002 name="input.g.page3.gzai002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai003
            #add-point:BEFORE FIELD gzai003 name="input.b.page3.gzai003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai003
            
            #add-point:AFTER FIELD gzai003 name="input.a.page3.gzai003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai003
            #add-point:ON CHANGE gzai003 name="input.g.page3.gzai003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai004
            #add-point:BEFORE FIELD gzai004 name="input.b.page3.gzai004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai004
            
            #add-point:AFTER FIELD gzai004 name="input.a.page3.gzai004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai004
            #add-point:ON CHANGE gzai004 name="input.g.page3.gzai004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai005
            #add-point:BEFORE FIELD gzai005 name="input.b.page3.gzai005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai005
            
            #add-point:AFTER FIELD gzai005 name="input.a.page3.gzai005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai005
            #add-point:ON CHANGE gzai005 name="input.g.page3.gzai005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai006
            #add-point:BEFORE FIELD gzai006 name="input.b.page3.gzai006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai006
            
            #add-point:AFTER FIELD gzai006 name="input.a.page3.gzai006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai006
            #add-point:ON CHANGE gzai006 name="input.g.page3.gzai006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai007
            #add-point:BEFORE FIELD gzai007 name="input.b.page3.gzai007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai007
            
            #add-point:AFTER FIELD gzai007 name="input.a.page3.gzai007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai007
            #add-point:ON CHANGE gzai007 name="input.g.page3.gzai007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai008
            #add-point:BEFORE FIELD gzai008 name="input.b.page3.gzai008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai008
            
            #add-point:AFTER FIELD gzai008 name="input.a.page3.gzai008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai008
            #add-point:ON CHANGE gzai008 name="input.g.page3.gzai008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai009
            #add-point:BEFORE FIELD gzai009 name="input.b.page3.gzai009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai009
            
            #add-point:AFTER FIELD gzai009 name="input.a.page3.gzai009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai009
            #add-point:ON CHANGE gzai009 name="input.g.page3.gzai009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai010
            #add-point:BEFORE FIELD gzai010 name="input.b.page3.gzai010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai010
            
            #add-point:AFTER FIELD gzai010 name="input.a.page3.gzai010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai010
            #add-point:ON CHANGE gzai010 name="input.g.page3.gzai010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai011
            #add-point:BEFORE FIELD gzai011 name="input.b.page3.gzai011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai011
            
            #add-point:AFTER FIELD gzai011 name="input.a.page3.gzai011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai011
            #add-point:ON CHANGE gzai011 name="input.g.page3.gzai011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai012
            #add-point:BEFORE FIELD gzai012 name="input.b.page3.gzai012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai012
            
            #add-point:AFTER FIELD gzai012 name="input.a.page3.gzai012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai012
            #add-point:ON CHANGE gzai012 name="input.g.page3.gzai012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai013
            #add-point:BEFORE FIELD gzai013 name="input.b.page3.gzai013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai013
            
            #add-point:AFTER FIELD gzai013 name="input.a.page3.gzai013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai013
            #add-point:ON CHANGE gzai013 name="input.g.page3.gzai013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai014
            #add-point:BEFORE FIELD gzai014 name="input.b.page3.gzai014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai014
            
            #add-point:AFTER FIELD gzai014 name="input.a.page3.gzai014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai014
            #add-point:ON CHANGE gzai014 name="input.g.page3.gzai014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai015
            #add-point:BEFORE FIELD gzai015 name="input.b.page3.gzai015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai015
            
            #add-point:AFTER FIELD gzai015 name="input.a.page3.gzai015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai015
            #add-point:ON CHANGE gzai015 name="input.g.page3.gzai015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai016
            #add-point:BEFORE FIELD gzai016 name="input.b.page3.gzai016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai016
            
            #add-point:AFTER FIELD gzai016 name="input.a.page3.gzai016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai016
            #add-point:ON CHANGE gzai016 name="input.g.page3.gzai016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai017
            #add-point:BEFORE FIELD gzai017 name="input.b.page3.gzai017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai017
            
            #add-point:AFTER FIELD gzai017 name="input.a.page3.gzai017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai017
            #add-point:ON CHANGE gzai017 name="input.g.page3.gzai017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai018
            #add-point:BEFORE FIELD gzai018 name="input.b.page3.gzai018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai018
            
            #add-point:AFTER FIELD gzai018 name="input.a.page3.gzai018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai018
            #add-point:ON CHANGE gzai018 name="input.g.page3.gzai018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai019
            #add-point:BEFORE FIELD gzai019 name="input.b.page3.gzai019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai019
            
            #add-point:AFTER FIELD gzai019 name="input.a.page3.gzai019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai019
            #add-point:ON CHANGE gzai019 name="input.g.page3.gzai019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai020
            #add-point:BEFORE FIELD gzai020 name="input.b.page3.gzai020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai020
            
            #add-point:AFTER FIELD gzai020 name="input.a.page3.gzai020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai020
            #add-point:ON CHANGE gzai020 name="input.g.page3.gzai020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai021
            #add-point:BEFORE FIELD gzai021 name="input.b.page3.gzai021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai021
            
            #add-point:AFTER FIELD gzai021 name="input.a.page3.gzai021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai021
            #add-point:ON CHANGE gzai021 name="input.g.page3.gzai021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzai022
            #add-point:BEFORE FIELD gzai022 name="input.b.page3.gzai022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzai022
            
            #add-point:AFTER FIELD gzai022 name="input.a.page3.gzai022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzai022
            #add-point:ON CHANGE gzai022 name="input.g.page3.gzai022"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.gzai002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai002
            #add-point:ON ACTION controlp INFIELD gzai002 name="input.c.page3.gzai002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai003
            #add-point:ON ACTION controlp INFIELD gzai003 name="input.c.page3.gzai003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai004
            #add-point:ON ACTION controlp INFIELD gzai004 name="input.c.page3.gzai004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai005
            #add-point:ON ACTION controlp INFIELD gzai005 name="input.c.page3.gzai005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai006
            #add-point:ON ACTION controlp INFIELD gzai006 name="input.c.page3.gzai006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai007
            #add-point:ON ACTION controlp INFIELD gzai007 name="input.c.page3.gzai007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai008
            #add-point:ON ACTION controlp INFIELD gzai008 name="input.c.page3.gzai008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai009
            #add-point:ON ACTION controlp INFIELD gzai009 name="input.c.page3.gzai009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai010
            #add-point:ON ACTION controlp INFIELD gzai010 name="input.c.page3.gzai010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai011
            #add-point:ON ACTION controlp INFIELD gzai011 name="input.c.page3.gzai011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai012
            #add-point:ON ACTION controlp INFIELD gzai012 name="input.c.page3.gzai012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai013
            #add-point:ON ACTION controlp INFIELD gzai013 name="input.c.page3.gzai013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai014
            #add-point:ON ACTION controlp INFIELD gzai014 name="input.c.page3.gzai014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai015
            #add-point:ON ACTION controlp INFIELD gzai015 name="input.c.page3.gzai015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai016
            #add-point:ON ACTION controlp INFIELD gzai016 name="input.c.page3.gzai016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai017
            #add-point:ON ACTION controlp INFIELD gzai017 name="input.c.page3.gzai017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai018
            #add-point:ON ACTION controlp INFIELD gzai018 name="input.c.page3.gzai018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai019
            #add-point:ON ACTION controlp INFIELD gzai019 name="input.c.page3.gzai019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai020
            #add-point:ON ACTION controlp INFIELD gzai020 name="input.c.page3.gzai020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai021
            #add-point:ON ACTION controlp INFIELD gzai021 name="input.c.page3.gzai021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.gzai022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzai022
            #add-point:ON ACTION controlp INFIELD gzai022 name="input.c.page3.gzai022"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzac3_d[l_ac].* = g_gzac3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi650_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL azzi650_unlock_b("gzai_t","'3'")
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
               LET g_gzac3_d[li_reproduce_target].* = g_gzac3_d[li_reproduce].*
 
               LET g_gzac3_d[li_reproduce_target].gzai002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzac3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzac3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_gzac4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzac4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi650_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_gzac4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_gzac4_d[l_ac].* TO NULL 
            INITIALIZE g_gzac4_d_t.* TO NULL 
            INITIALIZE g_gzac4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
                  LET g_gzac4_d[l_ac].gzaj003 = "N"
      LET g_gzac4_d[l_ac].gzaj004 = "Y"
      LET g_gzac4_d[l_ac].gzaj005 = "2"
 
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_gzac4_d_t.* = g_gzac4_d[l_ac].*     #新輸入資料
            LET g_gzac4_d_o.* = g_gzac4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi650_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL azzi650_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzac4_d[li_reproduce_target].* = g_gzac4_d[li_reproduce].*
 
               LET g_gzac4_d[li_reproduce_target].gzaj002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            IF g_gzac4_d[l_ac].gzaj002 >0 AND g_gzac4_d[l_ac].gzaj002 <= 5 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '1'
            END IF 
            IF g_gzac4_d[l_ac].gzaj002 >5 AND g_gzac4_d[l_ac].gzaj002 <= 10 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '2'
            END IF
            IF g_gzac4_d[l_ac].gzaj002 >10 AND g_gzac4_d[l_ac].gzaj002 <= 15 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '3'
            END IF
            IF g_gzac4_d[l_ac].gzaj002 >15 AND g_gzac4_d[l_ac].gzaj002 <= 18 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '4'
            END IF
            IF g_gzac4_d[l_ac].gzaj002 >18 AND g_gzac4_d[l_ac].gzaj002 <= 20 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '5'
            END IF
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN azzi650_cl USING g_gzaa_m.gzaa001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi650_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi650_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gzac4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzac4_d[l_ac].gzaj002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_gzac4_d_t.* = g_gzac4_d[l_ac].*  #BACKUP
               LET g_gzac4_d_o.* = g_gzac4_d[l_ac].*  #BACKUP
               CALL azzi650_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL azzi650_set_no_entry_b(l_cmd)
               IF NOT azzi650_lock_b("gzaj_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi650_bcl4 INTO g_gzac4_d[l_ac].gzaj002,g_gzac4_d[l_ac].gzaj003,g_gzac4_d[l_ac].gzaj004, 
                      g_gzac4_d[l_ac].gzaj005,g_gzac4_d[l_ac].gzaj006,g_gzac4_d[l_ac].gzaj007,g_gzac4_d[l_ac].gzaj008, 
                      g_gzac4_d[l_ac].gzaj015,g_gzac4_d[l_ac].gzaj016,g_gzac4_d[l_ac].gzaj017,g_gzac4_d[l_ac].gzaj009, 
                      g_gzac4_d[l_ac].gzaj014,g_gzac4_d[l_ac].gzaj010,g_gzac4_d[l_ac].gzaj011,g_gzac4_d[l_ac].gzaj012, 
                      g_gzac4_d[l_ac].gzaj013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzac4_d_mask_o[l_ac].* =  g_gzac4_d[l_ac].*
                  CALL azzi650_gzaj_t_mask()
                  LET g_gzac4_d_mask_n[l_ac].* =  g_gzac4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi650_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            IF g_gzac4_d[l_ac].gzaj002 >0 AND g_gzac4_d[l_ac].gzaj002 <= 5 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '1'
            END IF 
            IF g_gzac4_d[l_ac].gzaj002 >5 AND g_gzac4_d[l_ac].gzaj002 <= 10 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '2'
            END IF
            IF g_gzac4_d[l_ac].gzaj002 >10 AND g_gzac4_d[l_ac].gzaj002 <= 15 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '3'
            END IF
            IF g_gzac4_d[l_ac].gzaj002 >15 AND g_gzac4_d[l_ac].gzaj002 <= 18 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '4'
            END IF
            IF g_gzac4_d[l_ac].gzaj002 >18 AND g_gzac4_d[l_ac].gzaj002 <= 20 THEN
               LET g_gzac4_d[l_ac].l_cref_style = '5'
            END IF
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
               LET gs_keys[01] = g_gzaa_m.gzaa001
               LET gs_keys[gs_keys.getLength()+1] = g_gzac4_d_t.gzaj002
            
               #刪除同層單身
               IF NOT azzi650_delete_b('gzaj_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi650_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi650_key_delete_b(gs_keys,'gzaj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi650_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi650_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               LET g_chk_azzi650 = TRUE   #2015/01/23 by stellar add
               #end add-point
               LET l_count = g_gzac_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzac4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM gzaj_t 
             WHERE  gzaj001 = g_gzaa_m.gzaa001
               AND gzaj002 = g_gzac4_d[l_ac].gzaj002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzaa_m.gzaa001
               LET gs_keys[2] = g_gzac4_d[g_detail_idx].gzaj002
               CALL azzi650_insert_b('gzaj_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_gzac_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "gzaj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi650_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               LET g_chk_azzi650 = TRUE   #2015/01/23 by stellar add
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzac4_d[l_ac].* = g_gzac4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi650_bcl4
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
               LET g_gzac4_d[l_ac].* = g_gzac4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL azzi650_gzaj_t_mask_restore('restore_mask_o')
                              
               UPDATE gzaj_t SET (gzaj001,gzaj002,gzaj003,gzaj004,gzaj005,gzaj006,gzaj007,gzaj008,gzaj015, 
                   gzaj016,gzaj017,gzaj009,gzaj014,gzaj010,gzaj011,gzaj012,gzaj013) = (g_gzaa_m.gzaa001, 
                   g_gzac4_d[l_ac].gzaj002,g_gzac4_d[l_ac].gzaj003,g_gzac4_d[l_ac].gzaj004,g_gzac4_d[l_ac].gzaj005, 
                   g_gzac4_d[l_ac].gzaj006,g_gzac4_d[l_ac].gzaj007,g_gzac4_d[l_ac].gzaj008,g_gzac4_d[l_ac].gzaj015, 
                   g_gzac4_d[l_ac].gzaj016,g_gzac4_d[l_ac].gzaj017,g_gzac4_d[l_ac].gzaj009,g_gzac4_d[l_ac].gzaj014, 
                   g_gzac4_d[l_ac].gzaj010,g_gzac4_d[l_ac].gzaj011,g_gzac4_d[l_ac].gzaj012,g_gzac4_d[l_ac].gzaj013)  
                   #自訂欄位頁簽
                WHERE  gzaj001 = g_gzaa_m.gzaa001
                  AND gzaj002 = g_gzac4_d_t.gzaj002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gzac4_d[l_ac].* = g_gzac4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzaj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gzac4_d[l_ac].* = g_gzac4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzaj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzaa_m.gzaa001
               LET gs_keys_bak[1] = g_gzaa001_t
               LET gs_keys[2] = g_gzac4_d[g_detail_idx].gzaj002
               LET gs_keys_bak[2] = g_gzac4_d_t.gzaj002
               CALL azzi650_update_b('gzaj_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL azzi650_gzaj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_gzac4_d[g_detail_idx].gzaj002 = g_gzac4_d_t.gzaj002 
                  ) THEN
                  LET gs_keys[01] = g_gzaa_m.gzaa001
                  LET gs_keys[gs_keys.getLength()+1] = g_gzac4_d_t.gzaj002
                  CALL azzi650_key_update_b(gs_keys,'gzaj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzaa_m),util.JSON.stringify(g_gzac4_d_t)
               LET g_log2 = util.JSON.stringify(g_gzaa_m),util.JSON.stringify(g_gzac4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               #2015/01/23 by stellar add ----- (S)
               IF s_transaction_chk('Y',0) THEN
                  LET g_chk_azzi650 = TRUE
               END IF
               #2015/01/23 by stellar add ----- (E)
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj002
            
            #add-point:AFTER FIELD gzaj002 name="input.a.page4.gzaj002"
            #應用 a05 樣板自動產生(Version:1)
            #確認資料無重複
            IF  g_gzaa_m.gzaa001 IS NOT NULL AND g_gzac4_d[g_detail_idx].gzaj002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzaa_m.gzaa001 != g_gzaa001_t OR g_gzac4_d[g_detail_idx].gzaj002 != g_gzac4_d_t.gzaj002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzaj_t WHERE "||"gzaj001 = '"||g_gzaa_m.gzaa001 ||"' AND "|| "gzaj002 = '"||g_gzac4_d[g_detail_idx].gzaj002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzac4_d[l_ac].gzaj002
            CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='990' AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzac4_d[l_ac].gzaj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzac4_d[l_ac].gzaj002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj002
            #add-point:BEFORE FIELD gzaj002 name="input.b.page4.gzaj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj002
            #add-point:ON CHANGE gzaj002 name="input.g.page4.gzaj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cref_style
            #add-point:BEFORE FIELD l_cref_style name="input.b.page4.l_cref_style"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cref_style
            
            #add-point:AFTER FIELD l_cref_style name="input.a.page4.l_cref_style"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_cref_style
            #add-point:ON CHANGE l_cref_style name="input.g.page4.l_cref_style"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj003
            #add-point:BEFORE FIELD gzaj003 name="input.b.page4.gzaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj003
            
            #add-point:AFTER FIELD gzaj003 name="input.a.page4.gzaj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj003
            #add-point:ON CHANGE gzaj003 name="input.g.page4.gzaj003"
            IF g_gzac4_d[l_ac].gzaj002 <= 10 AND g_gzac4_d[l_ac].gzaj003 = 'Y' THEN
               IF g_gzac4_d[l_ac].gzaj002 >5 THEN
                  LET g_gzac4_d[l_ac].gzaj005 = '3'
               ELSE
                  LET g_gzac4_d[l_ac].gzaj005 = '2'
               END IF 
            END IF 
            IF g_gzac4_d[l_ac].gzaj002 > 10 AND g_gzac4_d[l_ac].gzaj003 = 'Y' THEN
               CALL cl_set_comp_entry('gzaj005',FALSE)
               IF g_gzac4_d[l_ac].gzaj002 <=15 then
                  LET g_gzac4_d[l_ac].gzaj005 = '3'
               ELSE
                  IF g_gzac4_d[l_ac].gzaj002 <=18 THEN
                     LET g_gzac4_d[l_ac].gzaj005 = '1'
                  ELSE
                     LET g_gzac4_d[l_ac].gzaj005 = '3'
                  END IF 
               END IF 
            END IF
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj004
            #add-point:BEFORE FIELD gzaj004 name="input.b.page4.gzaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj004
            
            #add-point:AFTER FIELD gzaj004 name="input.a.page4.gzaj004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj004
            #add-point:ON CHANGE gzaj004 name="input.g.page4.gzaj004"
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj005
            #add-point:BEFORE FIELD gzaj005 name="input.b.page4.gzaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj005
            
            #add-point:AFTER FIELD gzaj005 name="input.a.page4.gzaj005"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj005
            #add-point:ON CHANGE gzaj005 name="input.g.page4.gzaj005"
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj006
            
            #add-point:AFTER FIELD gzaj006 name="input.a.page4.gzaj006"
            DISPLAY ' ' TO g_gzac4_d[l_ac].gzaj006_desc
            
            #150415 by whitney modify start 優化錯誤訊息
            #CALL azzi650_gzaj006_chk() RETURNING l_result
            CALL azzi650_acc_chk(g_gzac4_d[l_ac].gzaj005,g_gzac4_d[l_ac].gzaj006) RETURNING l_result
            #150415 by whitney modify end
            IF  NOT l_result THEN 
               LET g_gzac4_d[l_ac].gzaj006 = g_gzac4_d_t.gzaj006
               CALL azzi650_gzaj006_desc()   
               NEXT FIELD CURRENT
            END IF
            CALL azzi650_gzaj006_desc()   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj006
            #add-point:BEFORE FIELD gzaj006 name="input.b.page4.gzaj006"
            CALL azzi650_gzaj006_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj006
            #add-point:ON CHANGE gzaj006 name="input.g.page4.gzaj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj007
            #add-point:BEFORE FIELD gzaj007 name="input.b.page4.gzaj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj007
            
            #add-point:AFTER FIELD gzaj007 name="input.a.page4.gzaj007"
            IF g_gzac4_d[l_ac].gzaj005 != '1' AND g_gzac4_d[l_ac].gzaj005 != '4' AND NOT cl_null(g_gzac4_d[l_ac].gzaj007) THEN
               CALL azzi650_gzaj007_chk() RETURNING l_result
            END IF 
            IF l_result = '1' THEN 
               LET g_gzac4_d[l_ac].gzaj007 = g_gzac4_d_t.gzaj007
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj007
            #add-point:ON CHANGE gzaj007 name="input.g.page4.gzaj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj008
            #add-point:BEFORE FIELD gzaj008 name="input.b.page4.gzaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj008
            
            #add-point:AFTER FIELD gzaj008 name="input.a.page4.gzaj008"
            LET l_result = '0' 
            IF g_gzac4_d[l_ac].gzaj005 != '1' AND g_gzac4_d[l_ac].gzaj005 != '4' AND NOT cl_null(g_gzac4_d[l_ac].gzaj008) THEN
               CALL azzi650_gzaj008_chk() RETURNING l_result
            END IF 
            IF l_result = '1' THEN 
               LET g_gzac4_d[l_ac].gzaj008 = g_gzac4_d_t.gzaj008
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj008
            #add-point:ON CHANGE gzaj008 name="input.g.page4.gzaj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj015
            #add-point:BEFORE FIELD gzaj015 name="input.b.page4.gzaj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj015
            
            #add-point:AFTER FIELD gzaj015 name="input.a.page4.gzaj015"
            IF NOT cl_null(g_gzac4_d[l_ac].gzaj015) THEN 
               LET li_count = 0
               SELECT COUNT(*) INTO li_count FROM dzea_t WHERE
                ((dzea001 IN (SELECT dzeb001 from
                (SELECT dzeb001,count(*) as count_key from dzeb_t  WHERE dzeb004 = 'Y' GROUP BY dzeb001) a
                 WHERE count_key = 2)  AND dzea004 !='L' AND dzea003 !='ADZ')
                OR ( dzea001 IN (SELECT dzeb001 from
                (SELECT dzeb001,count(*) as count_key from dzeb_t  WHERE dzeb004 = 'Y' GROUP BY dzeb001) b 
                 WHERE  count_key = 3)  AND dzea004 ='L')
                 OR ( dzea001 IN (SELECT dzeb001 from
                (SELECT dzeb001,count(*) as count_key from dzeb_t  WHERE dzeb004 = 'Y' GROUP BY dzeb001) c 
                 WHERE  count_key = 2)  AND dzea004 ='L' AND dzea003 = 'ADZ'))
                  AND dzea001 = g_gzac4_d[l_ac].gzaj015
               IF li_count = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00062"
                  LET g_errparam.extend = g_gzac4_d[l_ac].gzaj015
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  IF p_cmd = 'a' THEN 
                     LET g_gzac4_d[l_ac].gzaj015 =''
                  ELSE
                     LET g_gzac4_d[l_ac].gzaj015 =g_gzac4_d_t.gzaj015
                  END IF 
                  NEXT FIELD gzaj015
               END IF 
               IF NOT cl_null(g_gzac4_d[l_ac].gzaj016) THEN 
                  LET li_count = 0
                  SELECT COUNT(*) INTO li_count FROM dzeb_t WHERE
                   dzeb004 = 'N' AND dzeb001 = g_gzac4_d[l_ac].gzaj015 AND dzeb002 = g_gzac4_d[l_ac].gzaj016
                  IF li_count = 0 THEN 
                     LET g_gzac4_d[l_ac].gzaj016 = ''
                     NEXT FIELD gzaj016
                  END IF 
               END IF
               IF NOT cl_null(g_gzac4_d[l_ac].gzaj017) THEN 
                  LET li_count = 0
                  SELECT COUNT(*) INTO li_count FROM dzeb_t WHERE
                   dzeb004 = 'Y' AND dzeb006 != 'C800' AND dzeb002 NOT LIKE '%ent' AND dzeb001 = g_gzac4_d[l_ac].gzaj015 
                   AND dzeb002 = g_gzac4_d[l_ac].gzaj017
                   IF li_count = 0 THEN 
                      LET g_gzac4_d[l_ac].gzaj017 = ''
                      NEXT FIELD gzaj017
                  END IF 
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj015
            #add-point:ON CHANGE gzaj015 name="input.g.page4.gzaj015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj016
            #add-point:BEFORE FIELD gzaj016 name="input.b.page4.gzaj016"
            IF cl_null(g_gzac4_d[l_ac].gzaj015) THEN
               NEXT FIELD gzaj015
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj016
            
            #add-point:AFTER FIELD gzaj016 name="input.a.page4.gzaj016"
            IF NOT cl_null(g_gzac4_d[l_ac].gzaj016) THEN 
               LET li_count = 0
               SELECT COUNT(*) INTO li_count FROM dzeb_t WHERE
                dzeb004 = 'N' AND dzeb001 = g_gzac4_d[l_ac].gzaj015 AND dzeb002 = g_gzac4_d[l_ac].gzaj016
               IF li_count = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00063"
                  LET g_errparam.extend = g_gzac4_d[l_ac].gzaj016
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_gzac4_d[l_ac].gzaj016 = ''
                  NEXT FIELD gzaj016
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj016
            #add-point:ON CHANGE gzaj016 name="input.g.page4.gzaj016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj017
            #add-point:BEFORE FIELD gzaj017 name="input.b.page4.gzaj017"
            IF cl_null(g_gzac4_d[l_ac].gzaj015) THEN
               NEXT FIELD gzaj015
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj017
            
            #add-point:AFTER FIELD gzaj017 name="input.a.page4.gzaj017"
            IF NOT cl_null(g_gzac4_d[l_ac].gzaj017) THEN 
               LET li_count = 0
               SELECT COUNT(*) INTO li_count FROM dzeb_t WHERE
                dzeb004 = 'Y' AND dzeb006 != 'C800' AND dzeb002 NOT LIKE '%ent' AND dzeb001 = g_gzac4_d[l_ac].gzaj015 
                AND dzeb002 = g_gzac4_d[l_ac].gzaj017
               IF li_count = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00064"
                  LET g_errparam.extend = g_gzac4_d[l_ac].gzaj017
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_gzac4_d[l_ac].gzaj017 = ''
                  NEXT FIELD gzaj017
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj017
            #add-point:ON CHANGE gzaj017 name="input.g.page4.gzaj017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj009
            #add-point:BEFORE FIELD gzaj009 name="input.b.page4.gzaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj009
            
            #add-point:AFTER FIELD gzaj009 name="input.a.page4.gzaj009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj009
            #add-point:ON CHANGE gzaj009 name="input.g.page4.gzaj009"
            CALL azzi650_set_entry_b(l_cmd)
            CALL azzi650_set_no_entry_b(l_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj014
            #add-point:BEFORE FIELD gzaj014 name="input.b.page4.gzaj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj014
            
            #add-point:AFTER FIELD gzaj014 name="input.a.page4.gzaj014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj014
            #add-point:ON CHANGE gzaj014 name="input.g.page4.gzaj014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj010
            #add-point:BEFORE FIELD gzaj010 name="input.b.page4.gzaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj010
            
            #add-point:AFTER FIELD gzaj010 name="input.a.page4.gzaj010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj010
            #add-point:ON CHANGE gzaj010 name="input.g.page4.gzaj010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj011
            #add-point:BEFORE FIELD gzaj011 name="input.b.page4.gzaj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj011
            
            #add-point:AFTER FIELD gzaj011 name="input.a.page4.gzaj011"
            CALL azzi650_gzaj011_chk() RETURNING l_result
            IF l_result = '1' THEN 
               LET g_gzac4_d[l_ac].gzaj011 = g_gzac4_d_t.gzaj011
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj011
            #add-point:ON CHANGE gzaj011 name="input.g.page4.gzaj011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj012
            #add-point:BEFORE FIELD gzaj012 name="input.b.page4.gzaj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj012
            
            #add-point:AFTER FIELD gzaj012 name="input.a.page4.gzaj012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj012
            #add-point:ON CHANGE gzaj012 name="input.g.page4.gzaj012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzaj013
            #add-point:BEFORE FIELD gzaj013 name="input.b.page4.gzaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzaj013
            
            #add-point:AFTER FIELD gzaj013 name="input.a.page4.gzaj013"
            CALL azzi650_gzaj013_chk() RETURNING l_result
            IF l_result = '1' THEN 
               LET g_gzac4_d[l_ac].gzaj013 = g_gzac4_d_t.gzaj013
               NEXT FIELD gzaj013
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzaj013
            #add-point:ON CHANGE gzaj013 name="input.g.page4.gzaj013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.gzaj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj002
            #add-point:ON ACTION controlp INFIELD gzaj002 name="input.c.page4.gzaj002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.l_cref_style
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cref_style
            #add-point:ON ACTION controlp INFIELD l_cref_style name="input.c.page4.l_cref_style"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj003
            #add-point:ON ACTION controlp INFIELD gzaj003 name="input.c.page4.gzaj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj004
            #add-point:ON ACTION controlp INFIELD gzaj004 name="input.c.page4.gzaj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj005
            #add-point:ON ACTION controlp INFIELD gzaj005 name="input.c.page4.gzaj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj006
            #add-point:ON ACTION controlp INFIELD gzaj006 name="input.c.page4.gzaj006"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac4_d[l_ac].gzaj006             #給予default值
            IF g_gzac4_d[l_ac].gzaj005 = '1' THEN
               #給予arg
               LET g_qryparam.where = " gzcastus = 'Y' "
               CALL q_gzca001()                                #呼叫開窗
            ELSE 
               #給予arg
               LET g_qryparam.where = " gzaastus = 'Y' "
               CALL q_gzaa001()                                
            END IF 
            LET g_gzac4_d[l_ac].gzaj006 = g_qryparam.return1              

            DISPLAY g_gzac4_d[l_ac].gzaj006 TO gzaj006              #

            NEXT FIELD gzaj006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj007
            #add-point:ON ACTION controlp INFIELD gzaj007 name="input.c.page4.gzaj007"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac4_d[l_ac].gzaj007             #給予default值
            LET g_qryparam.default2 = "" #g_gzac4_d[l_ac].dzca001 #開窗識別碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dzca001_02()                                #呼叫開窗

            LET g_gzac4_d[l_ac].gzaj007 = g_qryparam.return1              
            #LET g_gzac4_d[l_ac].dzca001 = g_qryparam.return2 
            DISPLAY g_gzac4_d[l_ac].gzaj007 TO gzaj007              #
            #DISPLAY g_gzac4_d[l_ac].dzca001 TO dzca001 #開窗識別碼
            NEXT FIELD gzaj007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj008
            #add-point:ON ACTION controlp INFIELD gzaj008 name="input.c.page4.gzaj008"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac4_d[l_ac].gzaj008             #給予default值
            LET g_qryparam.default2 = "" #g_gzac4_d[l_ac].dzcd001 #校驗帶值識別碼
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dzcd001_01()                                #呼叫開窗

            LET g_gzac4_d[l_ac].gzaj008 = g_qryparam.return1              
            #LET g_gzac4_d[l_ac].dzcd001 = g_qryparam.return2 
            DISPLAY g_gzac4_d[l_ac].gzaj008 TO gzaj008              #
            #DISPLAY g_gzac4_d[l_ac].dzcd001 TO dzcd001 #校驗帶值識別碼
            NEXT FIELD gzaj008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj015
            #add-point:ON ACTION controlp INFIELD gzaj015 name="input.c.page4.gzaj015"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac4_d[l_ac].gzaj015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_dzea001_1()                                #呼叫開窗

            LET g_gzac4_d[l_ac].gzaj015 = g_qryparam.return1              

            DISPLAY g_gzac4_d[l_ac].gzaj015 TO gzaj015              #

            NEXT FIELD gzaj015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj016
            #add-point:ON ACTION controlp INFIELD gzaj016 name="input.c.page4.gzaj016"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac4_d[l_ac].gzaj016             #給予default值
            LET g_qryparam.default2 = "" #g_gzac4_d[l_ac].dzeb003 #欄位名稱
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " dzeb004 = 'N' AND dzeb001 = '",g_gzac4_d[l_ac].gzaj015,"'"
            
            CALL q_dzeb001()                                #呼叫開窗

            LET g_gzac4_d[l_ac].gzaj016 = g_qryparam.return1              
            #LET g_gzac4_d[l_ac].dzeb003 = g_qryparam.return2 
            DISPLAY g_gzac4_d[l_ac].gzaj016 TO gzaj016              #
            #DISPLAY g_gzac4_d[l_ac].dzeb003 TO dzeb003 #欄位名稱
            NEXT FIELD gzaj016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj017
            #add-point:ON ACTION controlp INFIELD gzaj017 name="input.c.page4.gzaj017"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzac4_d[l_ac].gzaj017             #給予default值
            LET g_qryparam.default2 = "" #g_gzac4_d[l_ac].dzeb003 #欄位名稱
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " dzeb004 = 'Y' AND dzeb006 != 'C800' AND dzeb002 NOT LIKE '%ent' AND dzeb001 = '",g_gzac4_d[l_ac].gzaj015,"'"
            
            CALL q_dzeb001()                                #呼叫開窗

            LET g_gzac4_d[l_ac].gzaj017 = g_qryparam.return1              
            #LET g_gzac4_d[l_ac].dzeb003 = g_qryparam.return2 
            DISPLAY g_gzac4_d[l_ac].gzaj017 TO gzaj017              #
            #DISPLAY g_gzac4_d[l_ac].dzeb003 TO dzeb003 #欄位名稱
            NEXT FIELD gzaj017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj009
            #add-point:ON ACTION controlp INFIELD gzaj009 name="input.c.page4.gzaj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj014
            #add-point:ON ACTION controlp INFIELD gzaj014 name="input.c.page4.gzaj014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj010
            #add-point:ON ACTION controlp INFIELD gzaj010 name="input.c.page4.gzaj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj011
            #add-point:ON ACTION controlp INFIELD gzaj011 name="input.c.page4.gzaj011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj012
            #add-point:ON ACTION controlp INFIELD gzaj012 name="input.c.page4.gzaj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.gzaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzaj013
            #add-point:ON ACTION controlp INFIELD gzaj013 name="input.c.page4.gzaj013"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_gzac4_d[l_ac].* = g_gzac4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi650_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL azzi650_unlock_b("gzaj_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_gzac4_d[li_reproduce_target].* = g_gzac4_d[li_reproduce].*
 
               LET g_gzac4_d[li_reproduce_target].gzaj002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzac4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzac4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="azzi650.input.other" >}
      
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
            NEXT FIELD gzaa001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzac002
               WHEN "s_detail2"
                  NEXT FIELD gzad002
               WHEN "s_detail3"
                  NEXT FIELD gzai002
               WHEN "s_detail4"
                  NEXT FIELD gzaj002
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         IF NOT azzi650_next_field(g_gzaa_m.gzaa001) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-00070'
            LET g_errparam.extend = g_gzaa_m.gzaa001
            LET g_errparam.popup = FALSE
            CALL cl_err()

            NEXT FIELD gzad003
         END IF
         IF NOT azzi650_next_field2(g_gzaa_m.gzaa001) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-00070'
            LET g_errparam.extend = g_gzaa_m.gzaa001
            LET g_errparam.popup = FALSE
            CALL cl_err()

            NEXT FIELD gzaj003
         END IF 
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
   IF g_chk_azzi650 THEN
      #每次異動都要重新產生q_azzi650.4gl 動態開窗
      CALL azzi650_gen_q_azzi650()
      LET g_chk_azzi650 = FALSE
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi650_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE lc_gzzz004        LIKE gzzz_t.gzzz004 
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL azzi650_b_fill() #單身填充
      CALL azzi650_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL azzi650_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_gzaa_m.gzzz001 = ''
   LET g_gzaa_m.gzzal003 = '' 
  #LET lc_gzzz004 = g_gzaa_m.gzaa001 
   CALL s_chr_add_quotes(g_gzaa_m.gzaa001) RETURNING lc_gzzz004
   SELECT gzzz001 INTO g_gzaa_m.gzzz001
     FROM gzzz_t
    WHERE (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')
      AND gzzz004= lc_gzzz004
   DISPLAY BY NAME g_gzaa_m.gzzz001
   SELECT gzzal003 INTO g_gzaa_m.gzzal003
     FROM gzzal_t
    WHERE gzzal001=g_gzaa_m.gzzz001 AND gzzal002=g_lang 
   DISPLAY BY NAME g_gzaa_m.gzzal003 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzaa_m.gzaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT gzaal003,gzaal004 FROM gzaal_t WHERE gzaal001=? AND gzaal002='"
        ||g_lang||"'","") RETURNING g_rtn_fields
   LET g_gzaa_m.gzaal003 = g_rtn_fields[1]
   LET g_gzaa_m.gzaal004 = g_rtn_fields[2]
   DISPLAY BY NAME g_gzaa_m.gzaal003
   DISPLAY BY NAME g_gzaa_m.gzaal004

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzaa_m.gzaamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzaa_m.gzaamodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gzaa_m.gzaamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzaa_m.gzaaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzaa_m.gzaaownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gzaa_m.gzaaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzaa_m.gzaaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzaa_m.gzaaowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gzaa_m.gzaaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzaa_m.gzaacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzaa_m.gzaacrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gzaa_m.gzaacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzaa_m.gzaacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzaa_m.gzaacrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gzaa_m.gzaacrtid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_gzaa_m_mask_o.* =  g_gzaa_m.*
   CALL azzi650_gzaa_t_mask()
   LET g_gzaa_m_mask_n.* =  g_gzaa_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaal003,g_gzaa_m.gzaal004,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzzz001,g_gzaa_m.gzzal003,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid, 
       g_gzaa_m.gzaaownid_desc,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid,g_gzaa_m.gzaacrtid_desc, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamodid_desc, 
       g_gzaa_m.gzaamoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzaa_m.gzaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzac_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_gzac2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gzac2_d[l_ac].gzad002
#            CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='990' AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING g_rtn_fields
#            LET g_gzac2_d[l_ac].gzad002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gzac2_d[l_ac].gzad002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gzac2_d[l_ac].gzad006
#            CALL ap_ref_array2(g_ref_fields,"SELECT gzcal003 FROM gzcal_t WHERE gzcal001=? AND gzcal002='"||g_lang||"'","") RETURNING g_rtn_fields
#            LET g_gzac2_d[l_ac].gzad006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gzac2_d[l_ac].gzad006_desc

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gzac3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_gzac4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL azzi650_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION azzi650_detail_show()
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
 
{<section id="azzi650.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi650_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE gzaa_t.gzaa001 
   DEFINE l_oldno     LIKE gzaa_t.gzaa001 
 
   DEFINE l_master    RECORD LIKE gzaa_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gzac_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE gzad_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE gzai_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE gzaj_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_result    LIKE type_t.chr1
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
   
   IF g_gzaa_m.gzaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gzaa001_t = g_gzaa_m.gzaa001
 
    
   LET g_gzaa_m.gzaa001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzaa_m.gzaaownid = g_user
      LET g_gzaa_m.gzaaowndp = g_dept
      LET g_gzaa_m.gzaacrtid = g_user
      LET g_gzaa_m.gzaacrtdp = g_dept 
      LET g_gzaa_m.gzaacrtdt = cl_get_current()
      LET g_gzaa_m.gzaamodid = g_user
      LET g_gzaa_m.gzaamoddt = cl_get_current()
      LET g_gzaa_m.gzaastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_gzaa_m.gzaastus = "Y"
   IF g_dgenv ='s' THEN
      LET g_gzaa_m.gzaa002 = 'Y'
   ELSE
      LET g_gzaa_m.gzaa002 = 'N'
      LET g_gzaa_m.gzaa004 = '6'   #6.User自定
   END IF
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzaa_m.gzaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL azzi650_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gzaa_m.* TO NULL
      INITIALIZE g_gzac_d TO NULL
      INITIALIZE g_gzac2_d TO NULL
      INITIALIZE g_gzac3_d TO NULL
      INITIALIZE g_gzac4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL azzi650_show()
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
   CALL azzi650_set_act_visible()   
   CALL azzi650_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gzaa001_t = g_gzaa_m.gzaa001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzaa001 = '", g_gzaa_m.gzaa001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi650_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL azzi650_idx_chk()
   
   LET g_data_owner = g_gzaa_m.gzaaownid      
   LET g_data_dept  = g_gzaa_m.gzaaowndp
   
   #功能已完成,通報訊息中心
   CALL azzi650_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi650_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzac_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE gzad_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE gzai_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE gzaj_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi650_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzac_t
    WHERE  gzac001 = g_gzaa001_t
 
    INTO TEMP azzi650_detail
 
   #將key修正為調整後   
   UPDATE azzi650_detail 
      #更新key欄位
      SET gzac001 = g_gzaa_m.gzaa001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gzac_t SELECT * FROM azzi650_detail
   
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
   DROP TABLE azzi650_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzad_t 
    WHERE  gzad001 = g_gzaa001_t
 
    INTO TEMP azzi650_detail
 
   #將key修正為調整後   
   UPDATE azzi650_detail SET gzad001 = g_gzaa_m.gzaa001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO gzad_t SELECT * FROM azzi650_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi650_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzai_t 
    WHERE  gzai001 = g_gzaa001_t
 
    INTO TEMP azzi650_detail
 
   #將key修正為調整後   
   UPDATE azzi650_detail SET gzai001 = g_gzaa_m.gzaa001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO gzai_t SELECT * FROM azzi650_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi650_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzaj_t 
    WHERE  gzaj001 = g_gzaa001_t
 
    INTO TEMP azzi650_detail
 
   #將key修正為調整後   
   UPDATE azzi650_detail SET gzaj001 = g_gzaa_m.gzaa001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO gzaj_t SELECT * FROM azzi650_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE azzi650_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzaa001_t = g_gzaa_m.gzaa001
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi650_delete()
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
   
   IF g_gzaa_m.gzaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.gzaal001 = g_gzaa_m.gzaa001
LET g_master_multi_table_t.gzaal003 = g_gzaa_m.gzaal003
LET g_master_multi_table_t.gzaal004 = g_gzaa_m.gzaal004
 
   
   CALL s_transaction_begin()
 
   OPEN azzi650_cl USING g_gzaa_m.gzaa001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi650_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE azzi650_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi650_master_referesh USING g_gzaa_m.gzaa001 INTO g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaacrtid, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt,g_gzaa_m.gzaaownid_desc, 
       g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid_desc,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaamodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT azzi650_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzaa_m_mask_o.* =  g_gzaa_m.*
   CALL azzi650_gzaa_t_mask()
   LET g_gzaa_m_mask_n.* =  g_gzaa_m.*
   
   CALL azzi650_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #上面的FETCH會把g_gzaa_m.gzzz001清掉,造成後面刪除azzi910資料失敗,所以這邊重CALL一次show()
   CALL azzi650_show()
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      IF g_dgenv ='c' THEN
         IF g_gzaa_m.gzaa002 = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-00030'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN 
         END IF
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi650_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_gzaa001_t = g_gzaa_m.gzaa001
 
 
      DELETE FROM gzaa_t
       WHERE  gzaa001 = g_gzaa_m.gzaa001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gzaa_m.gzaa001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      DELETE FROM gzzz_t
       WHERE gzzz001 = g_gzaa_m.gzzz001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_gzaa_m.gzzz001
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM gzzal_t
       WHERE gzzal001 = g_gzaa_m.gzzz001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_gzaa_m.gzzz001
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM gzac_t
       WHERE  gzac001 = g_gzaa_m.gzaa001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzac_t:",SQLERRMESSAGE 
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
      DELETE FROM gzad_t
       WHERE 
             gzad001 = g_gzaa_m.gzaa001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzad_t:",SQLERRMESSAGE 
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
      DELETE FROM gzai_t
       WHERE 
             gzai001 = g_gzaa_m.gzaa001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzai_t:",SQLERRMESSAGE 
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
      DELETE FROM gzaj_t
       WHERE 
             gzaj001 = g_gzaa_m.gzaa001
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_gzaa_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE azzi650_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gzac_d.clear() 
      CALL g_gzac2_d.clear()       
      CALL g_gzac3_d.clear()       
      CALL g_gzac4_d.clear()       
 
     
      CALL azzi650_ui_browser_refresh()  
      #CALL azzi650_ui_headershow()  
      #CALL azzi650_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.gzaal001
   LET l_field_keys[01] = 'gzaal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'gzaal_t')
 
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL azzi650_browser_fill("")
         CALL azzi650_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE azzi650_cl
 
   #功能已完成,通報訊息中心
   CALL azzi650_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi650.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi650_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_gzac_d.clear()
   CALL g_gzac2_d.clear()
   CALL g_gzac3_d.clear()
   CALL g_gzac4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF azzi650_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gzac002,gzac023,gzac024,gzac003,gzac004,gzac005,gzac006,gzac007, 
             gzac008,gzac009,gzac010,gzac011,gzac012,gzac013,gzac014,gzac015,gzac016,gzac017,gzac018, 
             gzac019,gzac020,gzac021,gzac022  FROM gzac_t",   
                     " INNER JOIN gzaa_t ON  gzaa001 = gzac001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE gzac001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gzac_t.gzac002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi650_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR azzi650_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_gzaa_m.gzaa001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_gzaa_m.gzaa001 INTO g_gzac_d[l_ac].gzac002,g_gzac_d[l_ac].gzac023,g_gzac_d[l_ac].gzac024, 
          g_gzac_d[l_ac].gzac003,g_gzac_d[l_ac].gzac004,g_gzac_d[l_ac].gzac005,g_gzac_d[l_ac].gzac006, 
          g_gzac_d[l_ac].gzac007,g_gzac_d[l_ac].gzac008,g_gzac_d[l_ac].gzac009,g_gzac_d[l_ac].gzac010, 
          g_gzac_d[l_ac].gzac011,g_gzac_d[l_ac].gzac012,g_gzac_d[l_ac].gzac013,g_gzac_d[l_ac].gzac014, 
          g_gzac_d[l_ac].gzac015,g_gzac_d[l_ac].gzac016,g_gzac_d[l_ac].gzac017,g_gzac_d[l_ac].gzac018, 
          g_gzac_d[l_ac].gzac019,g_gzac_d[l_ac].gzac020,g_gzac_d[l_ac].gzac021,g_gzac_d[l_ac].gzac022  
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
   IF azzi650_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gzad002,gzad003,gzad004,gzad005,gzad006,gzad007,gzad008,gzad015, 
             gzad016,gzad017,gzad009,gzad014,gzad010,gzad011,gzad012,gzad013 ,t1.gzcbl004 ,t2.gzcal003 FROM gzad_t", 
                
                     " INNER JOIN  gzaa_t ON  gzaa001 = gzad001 ",
 
                     "",
                     
                                    " LEFT JOIN gzcbl_t t1 ON t1.gzcbl001='990' AND t1.gzcbl002=gzad002 AND t1.gzcbl003='"||g_lang||"' ",
               " LEFT JOIN gzcal_t t2 ON t2.gzcal001=gzad006 AND t2.gzcal002='"||g_lang||"' ",
 
                     " WHERE gzad001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gzad_t.gzad002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi650_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR azzi650_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_gzaa_m.gzaa001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_gzaa_m.gzaa001 INTO g_gzac2_d[l_ac].gzad002,g_gzac2_d[l_ac].gzad003, 
          g_gzac2_d[l_ac].gzad004,g_gzac2_d[l_ac].gzad005,g_gzac2_d[l_ac].gzad006,g_gzac2_d[l_ac].gzad007, 
          g_gzac2_d[l_ac].gzad008,g_gzac2_d[l_ac].gzad015,g_gzac2_d[l_ac].gzad016,g_gzac2_d[l_ac].gzad017, 
          g_gzac2_d[l_ac].gzad009,g_gzac2_d[l_ac].gzad014,g_gzac2_d[l_ac].gzad010,g_gzac2_d[l_ac].gzad011, 
          g_gzac2_d[l_ac].gzad012,g_gzac2_d[l_ac].gzad013,g_gzac2_d[l_ac].gzad002_desc,g_gzac2_d[l_ac].gzad006_desc  
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
      CALL azzi650_gzad002_ref()
      CALL azzi650_gzad006_ref()
      IF g_gzac2_d[l_ac].gzad002 >0 AND g_gzac2_d[l_ac].gzad002 <= 5 THEN
         LET g_gzac2_d[l_ac].l_ref_style = '1'
      END IF 
      IF g_gzac2_d[l_ac].gzad002 >5 AND g_gzac2_d[l_ac].gzad002 <= 10 THEN
         LET g_gzac2_d[l_ac].l_ref_style = '2'
      END IF
      IF g_gzac2_d[l_ac].gzad002 >10 AND g_gzac2_d[l_ac].gzad002 <= 15 THEN
         LET g_gzac2_d[l_ac].l_ref_style = '3'
      END IF
      IF g_gzac2_d[l_ac].gzad002 >15 AND g_gzac2_d[l_ac].gzad002 <= 18 THEN
         LET g_gzac2_d[l_ac].l_ref_style = '4'
      END IF
      IF g_gzac2_d[l_ac].gzad002 >18 AND g_gzac2_d[l_ac].gzad002 <= 20 THEN
         LET g_gzac2_d[l_ac].l_ref_style = '5'
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
 
   #判斷是否填充
   IF azzi650_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gzai002,gzai003,gzai004,gzai005,gzai006,gzai007,gzai008,gzai009, 
             gzai010,gzai011,gzai012,gzai013,gzai014,gzai015,gzai016,gzai017,gzai018,gzai019,gzai020, 
             gzai021,gzai022  FROM gzai_t",   
                     " INNER JOIN  gzaa_t ON  gzaa001 = gzai001 ",
 
                     "",
                     
                     
                     " WHERE gzai001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gzai_t.gzai002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi650_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR azzi650_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_gzaa_m.gzaa001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_gzaa_m.gzaa001 INTO g_gzac3_d[l_ac].gzai002,g_gzac3_d[l_ac].gzai003, 
          g_gzac3_d[l_ac].gzai004,g_gzac3_d[l_ac].gzai005,g_gzac3_d[l_ac].gzai006,g_gzac3_d[l_ac].gzai007, 
          g_gzac3_d[l_ac].gzai008,g_gzac3_d[l_ac].gzai009,g_gzac3_d[l_ac].gzai010,g_gzac3_d[l_ac].gzai011, 
          g_gzac3_d[l_ac].gzai012,g_gzac3_d[l_ac].gzai013,g_gzac3_d[l_ac].gzai014,g_gzac3_d[l_ac].gzai015, 
          g_gzac3_d[l_ac].gzai016,g_gzac3_d[l_ac].gzai017,g_gzac3_d[l_ac].gzai018,g_gzac3_d[l_ac].gzai019, 
          g_gzac3_d[l_ac].gzai020,g_gzac3_d[l_ac].gzai021,g_gzac3_d[l_ac].gzai022   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         
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
   IF azzi650_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gzaj002,gzaj003,gzaj004,gzaj005,gzaj006,gzaj007,gzaj008,gzaj015, 
             gzaj016,gzaj017,gzaj009,gzaj014,gzaj010,gzaj011,gzaj012,gzaj013 ,t3.gzcbl004 ,t4.gzcal003 FROM gzaj_t", 
                
                     " INNER JOIN  gzaa_t ON  gzaa001 = gzaj001 ",
 
                     "",
                     
                                    " LEFT JOIN gzcbl_t t3 ON t3.gzcbl001='990' AND t3.gzcbl002=gzaj002 AND t3.gzcbl003='"||g_lang||"' ",
               " LEFT JOIN gzcal_t t4 ON t4.gzcal001=gzaj006 AND t4.gzcal002='"||g_lang||"' ",
 
                     " WHERE gzaj001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gzaj_t.gzaj002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi650_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR azzi650_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_gzaa_m.gzaa001   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_gzaa_m.gzaa001 INTO g_gzac4_d[l_ac].gzaj002,g_gzac4_d[l_ac].gzaj003, 
          g_gzac4_d[l_ac].gzaj004,g_gzac4_d[l_ac].gzaj005,g_gzac4_d[l_ac].gzaj006,g_gzac4_d[l_ac].gzaj007, 
          g_gzac4_d[l_ac].gzaj008,g_gzac4_d[l_ac].gzaj015,g_gzac4_d[l_ac].gzaj016,g_gzac4_d[l_ac].gzaj017, 
          g_gzac4_d[l_ac].gzaj009,g_gzac4_d[l_ac].gzaj014,g_gzac4_d[l_ac].gzaj010,g_gzac4_d[l_ac].gzaj011, 
          g_gzac4_d[l_ac].gzaj012,g_gzac4_d[l_ac].gzaj013,g_gzac4_d[l_ac].gzaj002_desc,g_gzac4_d[l_ac].gzaj006_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         CALL azzi650_gzaj002_desc()
         CALL azzi650_gzaj006_desc()
         IF g_gzac4_d[l_ac].gzaj002 >0 AND g_gzac4_d[l_ac].gzaj002 <= 5 THEN
            LET g_gzac4_d[l_ac].l_cref_style = '1'
         END IF 
         IF g_gzac4_d[l_ac].gzaj002 >5 AND g_gzac4_d[l_ac].gzaj002 <= 10 THEN
            LET g_gzac4_d[l_ac].l_cref_style = '2'
         END IF
         IF g_gzac4_d[l_ac].gzaj002 >10 AND g_gzac4_d[l_ac].gzaj002 <= 15 THEN
            LET g_gzac4_d[l_ac].l_cref_style = '3'
         END IF
         IF g_gzac4_d[l_ac].gzaj002 >15 AND g_gzac4_d[l_ac].gzaj002 <= 18 THEN
            LET g_gzac4_d[l_ac].l_cref_style = '4'
         END IF
         IF g_gzac4_d[l_ac].gzaj002 >18 AND g_gzac4_d[l_ac].gzaj002 <= 20 THEN
            LET g_gzac4_d[l_ac].l_cref_style = '5'
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
   
   CALL g_gzac_d.deleteElement(g_gzac_d.getLength())
   CALL g_gzac2_d.deleteElement(g_gzac2_d.getLength())
   CALL g_gzac3_d.deleteElement(g_gzac3_d.getLength())
   CALL g_gzac4_d.deleteElement(g_gzac4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE azzi650_pb
   FREE azzi650_pb2
 
   FREE azzi650_pb3
 
   FREE azzi650_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzac_d.getLength()
      LET g_gzac_d_mask_o[l_ac].* =  g_gzac_d[l_ac].*
      CALL azzi650_gzac_t_mask()
      LET g_gzac_d_mask_n[l_ac].* =  g_gzac_d[l_ac].*
   END FOR
   
   LET g_gzac2_d_mask_o.* =  g_gzac2_d.*
   FOR l_ac = 1 TO g_gzac2_d.getLength()
      LET g_gzac2_d_mask_o[l_ac].* =  g_gzac2_d[l_ac].*
      CALL azzi650_gzad_t_mask()
      LET g_gzac2_d_mask_n[l_ac].* =  g_gzac2_d[l_ac].*
   END FOR
   LET g_gzac3_d_mask_o.* =  g_gzac3_d.*
   FOR l_ac = 1 TO g_gzac3_d.getLength()
      LET g_gzac3_d_mask_o[l_ac].* =  g_gzac3_d[l_ac].*
      CALL azzi650_gzai_t_mask()
      LET g_gzac3_d_mask_n[l_ac].* =  g_gzac3_d[l_ac].*
   END FOR
   LET g_gzac4_d_mask_o.* =  g_gzac4_d.*
   FOR l_ac = 1 TO g_gzac4_d.getLength()
      LET g_gzac4_d_mask_o[l_ac].* =  g_gzac4_d[l_ac].*
      CALL azzi650_gzaj_t_mask()
      LET g_gzac4_d_mask_n[l_ac].* =  g_gzac4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi650_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM gzac_t
       WHERE 
         gzac001 = ps_keys_bak[1] AND gzac002 = ps_keys_bak[2]
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
         CALL g_gzac_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM gzad_t
       WHERE 
             gzad001 = ps_keys_bak[1] AND gzad002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_gzac2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM gzai_t
       WHERE 
             gzai001 = ps_keys_bak[1] AND gzai002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_gzac3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM gzaj_t
       WHERE 
             gzaj001 = ps_keys_bak[1] AND gzaj002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_gzac4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi650_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO gzac_t
                  (
                   gzac001,
                   gzac002
                   ,gzac023,gzac024,gzac003,gzac004,gzac005,gzac006,gzac007,gzac008,gzac009,gzac010,gzac011,gzac012,gzac013,gzac014,gzac015,gzac016,gzac017,gzac018,gzac019,gzac020,gzac021,gzac022) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzac_d[g_detail_idx].gzac023,g_gzac_d[g_detail_idx].gzac024,g_gzac_d[g_detail_idx].gzac003, 
                       g_gzac_d[g_detail_idx].gzac004,g_gzac_d[g_detail_idx].gzac005,g_gzac_d[g_detail_idx].gzac006, 
                       g_gzac_d[g_detail_idx].gzac007,g_gzac_d[g_detail_idx].gzac008,g_gzac_d[g_detail_idx].gzac009, 
                       g_gzac_d[g_detail_idx].gzac010,g_gzac_d[g_detail_idx].gzac011,g_gzac_d[g_detail_idx].gzac012, 
                       g_gzac_d[g_detail_idx].gzac013,g_gzac_d[g_detail_idx].gzac014,g_gzac_d[g_detail_idx].gzac015, 
                       g_gzac_d[g_detail_idx].gzac016,g_gzac_d[g_detail_idx].gzac017,g_gzac_d[g_detail_idx].gzac018, 
                       g_gzac_d[g_detail_idx].gzac019,g_gzac_d[g_detail_idx].gzac020,g_gzac_d[g_detail_idx].gzac021, 
                       g_gzac_d[g_detail_idx].gzac022)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzac_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gzac_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO gzad_t
                  (
                   gzad001,
                   gzad002
                   ,gzad003,gzad004,gzad005,gzad006,gzad007,gzad008,gzad015,gzad016,gzad017,gzad009,gzad014,gzad010,gzad011,gzad012,gzad013) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzac2_d[g_detail_idx].gzad003,g_gzac2_d[g_detail_idx].gzad004,g_gzac2_d[g_detail_idx].gzad005, 
                       g_gzac2_d[g_detail_idx].gzad006,g_gzac2_d[g_detail_idx].gzad007,g_gzac2_d[g_detail_idx].gzad008, 
                       g_gzac2_d[g_detail_idx].gzad015,g_gzac2_d[g_detail_idx].gzad016,g_gzac2_d[g_detail_idx].gzad017, 
                       g_gzac2_d[g_detail_idx].gzad009,g_gzac2_d[g_detail_idx].gzad014,g_gzac2_d[g_detail_idx].gzad010, 
                       g_gzac2_d[g_detail_idx].gzad011,g_gzac2_d[g_detail_idx].gzad012,g_gzac2_d[g_detail_idx].gzad013) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzad_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_gzac2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO gzai_t
                  (
                   gzai001,
                   gzai002
                   ,gzai003,gzai004,gzai005,gzai006,gzai007,gzai008,gzai009,gzai010,gzai011,gzai012,gzai013,gzai014,gzai015,gzai016,gzai017,gzai018,gzai019,gzai020,gzai021,gzai022) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzac3_d[g_detail_idx].gzai003,g_gzac3_d[g_detail_idx].gzai004,g_gzac3_d[g_detail_idx].gzai005, 
                       g_gzac3_d[g_detail_idx].gzai006,g_gzac3_d[g_detail_idx].gzai007,g_gzac3_d[g_detail_idx].gzai008, 
                       g_gzac3_d[g_detail_idx].gzai009,g_gzac3_d[g_detail_idx].gzai010,g_gzac3_d[g_detail_idx].gzai011, 
                       g_gzac3_d[g_detail_idx].gzai012,g_gzac3_d[g_detail_idx].gzai013,g_gzac3_d[g_detail_idx].gzai014, 
                       g_gzac3_d[g_detail_idx].gzai015,g_gzac3_d[g_detail_idx].gzai016,g_gzac3_d[g_detail_idx].gzai017, 
                       g_gzac3_d[g_detail_idx].gzai018,g_gzac3_d[g_detail_idx].gzai019,g_gzac3_d[g_detail_idx].gzai020, 
                       g_gzac3_d[g_detail_idx].gzai021,g_gzac3_d[g_detail_idx].gzai022)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzai_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_gzac3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO gzaj_t
                  (
                   gzaj001,
                   gzaj002
                   ,gzaj003,gzaj004,gzaj005,gzaj006,gzaj007,gzaj008,gzaj015,gzaj016,gzaj017,gzaj009,gzaj014,gzaj010,gzaj011,gzaj012,gzaj013) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzac4_d[g_detail_idx].gzaj003,g_gzac4_d[g_detail_idx].gzaj004,g_gzac4_d[g_detail_idx].gzaj005, 
                       g_gzac4_d[g_detail_idx].gzaj006,g_gzac4_d[g_detail_idx].gzaj007,g_gzac4_d[g_detail_idx].gzaj008, 
                       g_gzac4_d[g_detail_idx].gzaj015,g_gzac4_d[g_detail_idx].gzaj016,g_gzac4_d[g_detail_idx].gzaj017, 
                       g_gzac4_d[g_detail_idx].gzaj009,g_gzac4_d[g_detail_idx].gzaj014,g_gzac4_d[g_detail_idx].gzaj010, 
                       g_gzac4_d[g_detail_idx].gzaj011,g_gzac4_d[g_detail_idx].gzaj012,g_gzac4_d[g_detail_idx].gzaj013) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzaj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_gzac4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi650_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzac_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL azzi650_gzac_t_mask_restore('restore_mask_o')
               
      UPDATE gzac_t 
         SET (gzac001,
              gzac002
              ,gzac023,gzac024,gzac003,gzac004,gzac005,gzac006,gzac007,gzac008,gzac009,gzac010,gzac011,gzac012,gzac013,gzac014,gzac015,gzac016,gzac017,gzac018,gzac019,gzac020,gzac021,gzac022) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzac_d[g_detail_idx].gzac023,g_gzac_d[g_detail_idx].gzac024,g_gzac_d[g_detail_idx].gzac003, 
                  g_gzac_d[g_detail_idx].gzac004,g_gzac_d[g_detail_idx].gzac005,g_gzac_d[g_detail_idx].gzac006, 
                  g_gzac_d[g_detail_idx].gzac007,g_gzac_d[g_detail_idx].gzac008,g_gzac_d[g_detail_idx].gzac009, 
                  g_gzac_d[g_detail_idx].gzac010,g_gzac_d[g_detail_idx].gzac011,g_gzac_d[g_detail_idx].gzac012, 
                  g_gzac_d[g_detail_idx].gzac013,g_gzac_d[g_detail_idx].gzac014,g_gzac_d[g_detail_idx].gzac015, 
                  g_gzac_d[g_detail_idx].gzac016,g_gzac_d[g_detail_idx].gzac017,g_gzac_d[g_detail_idx].gzac018, 
                  g_gzac_d[g_detail_idx].gzac019,g_gzac_d[g_detail_idx].gzac020,g_gzac_d[g_detail_idx].gzac021, 
                  g_gzac_d[g_detail_idx].gzac022) 
         WHERE  gzac001 = ps_keys_bak[1] AND gzac002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzac_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzac_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi650_gzac_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzad_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL azzi650_gzad_t_mask_restore('restore_mask_o')
               
      UPDATE gzad_t 
         SET (gzad001,
              gzad002
              ,gzad003,gzad004,gzad005,gzad006,gzad007,gzad008,gzad015,gzad016,gzad017,gzad009,gzad014,gzad010,gzad011,gzad012,gzad013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzac2_d[g_detail_idx].gzad003,g_gzac2_d[g_detail_idx].gzad004,g_gzac2_d[g_detail_idx].gzad005, 
                  g_gzac2_d[g_detail_idx].gzad006,g_gzac2_d[g_detail_idx].gzad007,g_gzac2_d[g_detail_idx].gzad008, 
                  g_gzac2_d[g_detail_idx].gzad015,g_gzac2_d[g_detail_idx].gzad016,g_gzac2_d[g_detail_idx].gzad017, 
                  g_gzac2_d[g_detail_idx].gzad009,g_gzac2_d[g_detail_idx].gzad014,g_gzac2_d[g_detail_idx].gzad010, 
                  g_gzac2_d[g_detail_idx].gzad011,g_gzac2_d[g_detail_idx].gzad012,g_gzac2_d[g_detail_idx].gzad013)  
 
         WHERE  gzad001 = ps_keys_bak[1] AND gzad002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzad_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzad_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi650_gzad_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzai_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL azzi650_gzai_t_mask_restore('restore_mask_o')
               
      UPDATE gzai_t 
         SET (gzai001,
              gzai002
              ,gzai003,gzai004,gzai005,gzai006,gzai007,gzai008,gzai009,gzai010,gzai011,gzai012,gzai013,gzai014,gzai015,gzai016,gzai017,gzai018,gzai019,gzai020,gzai021,gzai022) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzac3_d[g_detail_idx].gzai003,g_gzac3_d[g_detail_idx].gzai004,g_gzac3_d[g_detail_idx].gzai005, 
                  g_gzac3_d[g_detail_idx].gzai006,g_gzac3_d[g_detail_idx].gzai007,g_gzac3_d[g_detail_idx].gzai008, 
                  g_gzac3_d[g_detail_idx].gzai009,g_gzac3_d[g_detail_idx].gzai010,g_gzac3_d[g_detail_idx].gzai011, 
                  g_gzac3_d[g_detail_idx].gzai012,g_gzac3_d[g_detail_idx].gzai013,g_gzac3_d[g_detail_idx].gzai014, 
                  g_gzac3_d[g_detail_idx].gzai015,g_gzac3_d[g_detail_idx].gzai016,g_gzac3_d[g_detail_idx].gzai017, 
                  g_gzac3_d[g_detail_idx].gzai018,g_gzac3_d[g_detail_idx].gzai019,g_gzac3_d[g_detail_idx].gzai020, 
                  g_gzac3_d[g_detail_idx].gzai021,g_gzac3_d[g_detail_idx].gzai022) 
         WHERE  gzai001 = ps_keys_bak[1] AND gzai002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzai_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzai_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi650_gzai_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzaj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL azzi650_gzaj_t_mask_restore('restore_mask_o')
               
      UPDATE gzaj_t 
         SET (gzaj001,
              gzaj002
              ,gzaj003,gzaj004,gzaj005,gzaj006,gzaj007,gzaj008,gzaj015,gzaj016,gzaj017,gzaj009,gzaj014,gzaj010,gzaj011,gzaj012,gzaj013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzac4_d[g_detail_idx].gzaj003,g_gzac4_d[g_detail_idx].gzaj004,g_gzac4_d[g_detail_idx].gzaj005, 
                  g_gzac4_d[g_detail_idx].gzaj006,g_gzac4_d[g_detail_idx].gzaj007,g_gzac4_d[g_detail_idx].gzaj008, 
                  g_gzac4_d[g_detail_idx].gzaj015,g_gzac4_d[g_detail_idx].gzaj016,g_gzac4_d[g_detail_idx].gzaj017, 
                  g_gzac4_d[g_detail_idx].gzaj009,g_gzac4_d[g_detail_idx].gzaj014,g_gzac4_d[g_detail_idx].gzaj010, 
                  g_gzac4_d[g_detail_idx].gzaj011,g_gzac4_d[g_detail_idx].gzaj012,g_gzac4_d[g_detail_idx].gzaj013)  
 
         WHERE  gzaj001 = ps_keys_bak[1] AND gzaj002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzaj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzaj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi650_gzaj_t_mask_restore('restore_mask_n')
 
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
 
{<section id="azzi650.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION azzi650_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi650.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION azzi650_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi650.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi650_lock_b(ps_table,ps_page)
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
   #CALL azzi650_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gzac_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN azzi650_bcl USING 
                                       g_gzaa_m.gzaa001,g_gzac_d[g_detail_idx].gzac002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi650_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "gzad_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi650_bcl2 USING 
                                             g_gzaa_m.gzaa001,g_gzac2_d[g_detail_idx].gzad002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi650_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "gzai_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi650_bcl3 USING 
                                             g_gzaa_m.gzaa001,g_gzac3_d[g_detail_idx].gzai002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi650_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "gzaj_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN azzi650_bcl4 USING 
                                             g_gzaa_m.gzaa001,g_gzac4_d[g_detail_idx].gzaj002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi650_bcl4:",SQLERRMESSAGE 
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
 
{<section id="azzi650.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi650_unlock_b(ps_table,ps_page)
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
      CLOSE azzi650_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE azzi650_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE azzi650_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE azzi650_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi650_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzaa001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry('gzzz001',TRUE)
      CALL cl_set_comp_entry('gzzal003',TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("gzaa001",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi650_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE lc_gzzz004 LIKE gzzz_t.gzzz004	
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzaa001",FALSE)
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
   IF g_dgenv ='c' THEN
      IF g_gzaa_m.gzaa004 <> '6' THEN
         CALL cl_set_comp_entry("gzaa001",FALSE)
      END IF
      CALL cl_set_comp_entry("gzaa002,gzaa004",FALSE)
   END IF

   CALL s_chr_add_quotes(g_gzaa_m.gzaa001) RETURNING lc_gzzz004
   SELECT gzzz001 INTO g_gzaa_m.gzzz001
     FROM gzzz_t
    WHERE (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')
      AND gzzz004= lc_gzzz004
   DISPLAY  BY NAME g_gzaa_m.gzzz001
   SELECT gzzal003 INTO g_gzaa_m.gzzal003
     FROM gzzal_t WHERE gzzal001=g_gzaa_m.gzzz001  AND gzzal002=g_lang 
   DISPLAY  BY NAME g_gzaa_m.gzzal003
   IF cl_null(g_gzaa_m.gzzz001) THEN
      CALL cl_set_comp_entry('gzzz001',TRUE)
      CALL cl_set_comp_entry('gzzal003',TRUE)
   ELSE
      CALL cl_set_comp_entry('gzzz001',FALSE)
      CALL cl_set_comp_entry('gzzal003',FALSE)
   END IF
   CALL cl_set_comp_required('gzzz001,gzzal003',FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi650.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi650_set_entry_b(p_cmd)
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
   IF g_gzac2_d[l_ac].gzad002 <=  10 AND g_gzac2_d[l_ac].gzad003 = 'Y' THEN
      CALL cl_set_comp_entry('gzad005',TRUE)
   END IF
   
   CALL cl_set_comp_entry("gzac003,gzac004,gzac005,gzac006,gzac007",TRUE)
   CALL cl_set_comp_entry("gzac008,gzac009,gzac010,gzac011,gzac012",TRUE)
   CALL cl_set_comp_entry("gzac013,gzac014,gzac015,gzac016,gzac017",TRUE)
   CALL cl_set_comp_entry("gzac018,gzac019,gzac020,gzac021,gzac022",TRUE)
      
   CALL cl_set_comp_entry('gzaj002',FALSE)
   CALL cl_set_comp_entry('gzaj004,gzaj005,gzaj006,gzaj007,gzaj008',FALSE)
   CALL cl_set_comp_entry('gzaj009,gzaj010,gzaj011,gzaj012,gzaj013,gzaj014',FALSE)
   CALL cl_set_comp_entry('gzaj015,gzaj016,gzaj017',FALSE)
   CALL cl_set_comp_required('gzaj006',FALSE)  
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="azzi650.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi650_set_no_entry_b(p_cmd)
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
   #當DGENV = 'c'時,不可修改標準資料
   IF g_dgenv = 'c' THEN
      CALL cl_set_comp_entry("gzac003,gzac004,gzac005,gzac006,gzac007",FALSE)
      CALL cl_set_comp_entry("gzac008,gzac009,gzac010,gzac011,gzac012",FALSE)
      CALL cl_set_comp_entry("gzac013,gzac014,gzac015,gzac016,gzac017",FALSE)
      CALL cl_set_comp_entry("gzac018,gzac019,gzac020,gzac021,gzac022",FALSE)
   END IF
   #當gzaj003 = 'N'時將gzaj004 修改為Y，同時清空gzaj005 ---gzaj013內容
   IF g_gzac4_d[l_ac].gzaj003 = 'N' THEN
     #gzaj004 修改為Y
      LET g_gzac4_d[l_ac].gzaj004 = 'Y'
     #清空gzaj005 ---gzaj017內容
      LET g_gzac4_d[l_ac].gzaj005 = ''
      LET g_gzac4_d[l_ac].gzaj006 = ''
      LET g_gzac4_d[l_ac].gzaj007 = ''
      LET g_gzac4_d[l_ac].gzaj008 = ''
      LET g_gzac4_d[l_ac].gzaj009 = ''
      LET g_gzac4_d[l_ac].gzaj010 = ''
      LET g_gzac4_d[l_ac].gzaj011 = ''
      LET g_gzac4_d[l_ac].gzaj012 = ''
      LET g_gzac4_d[l_ac].gzaj013 = '' 
      LET g_gzac4_d[l_ac].gzaj014 = ''
      LET g_gzac4_d[l_ac].gzaj015 = ''
      LET g_gzac4_d[l_ac].gzaj016 = '' 
      LET g_gzac4_d[l_ac].gzaj017 = ''
      LET g_gzac4_d[l_ac].gzaj006_desc = ''
   ELSE
  #當gzaj003 = 'Y'時，開發gzaj004，gzaj005欄位
      CALL cl_set_comp_entry('gzaj004,gzaj005,gzaj014',TRUE)
     #根據gzaj005欄位的值來判斷後續欄位的開放否
     #gzaj005 = 1 系統分類碼時，開放gzaj006，清空gzaj009---gzaj013內容
     #將gazd007 = 'q_gzca001'，gzaj008 = 'v_gzca001'
      IF g_gzac4_d[l_ac].gzaj005 = '1' OR g_gzac4_d[l_ac].gzaj005 = '4' THEN
        #開放gzaj006
         CALL cl_set_comp_entry('gzaj006',TRUE)
         IF g_gzac4_d[l_ac].gzaj005 = '1'  THEN
        #將gazd007 = 'q_gzcb001'，gzaj008 = 'v_gzcb002' 
            LET g_gzac4_d[l_ac].gzaj007 = 'q_gzcb001'
            LET g_gzac4_d[l_ac].gzaj008 = 'v_gzcb002' 
         END IF 
         IF g_gzac4_d[l_ac].gzaj005 = '4'  THEN
        #將gazd007 = 'q_oocq002'，gzaj008 = 'v_oocq002' 
            LET g_gzac4_d[l_ac].gzaj007 = 'q_oocq002'
            LET g_gzac4_d[l_ac].gzaj008 = 'v_oocq002' 
         END IF
        #清空gzaj009 ---gzaj013,gzaj015----gzaj017內容
        
         LET g_gzac4_d[l_ac].gzaj009 = ''
         LET g_gzac4_d[l_ac].gzaj010 = ''
         LET g_gzac4_d[l_ac].gzaj011 = ''
         LET g_gzac4_d[l_ac].gzaj012 = ''
         LET g_gzac4_d[l_ac].gzaj013 = '' 
         LET g_gzac4_d[l_ac].gzaj015 = ''
         LET g_gzac4_d[l_ac].gzaj016 = '' 
         LET g_gzac4_d[l_ac].gzaj017 = ''
         CALL cl_set_comp_required('gzaj006',TRUE)
      END IF 
     #gzaj005 = 2建檔開窗時，開放gzaj007，gzaj008欄位，清空gzaj006，gzaj009--gzaj013內容
      IF g_gzac4_d[l_ac].gzaj005 = '2' THEN 
        #開放gzaj007，gzaj008,gzaj017,gzaj016,gzaj015欄位
         CALL cl_set_comp_entry('gzaj007,gzaj008',TRUE)
         CALL cl_set_comp_entry('gzaj017,gzaj016,gzaj015',TRUE)
        #清空gzaj006，gzaj009---gzaj013欄位
         LET g_gzac4_d[l_ac].gzaj006 = ''
         LET g_gzac4_d[l_ac].gzaj006_desc = ''
         #LET g_gzac4_d[l_ac].gzaj007 = ''
         #LET g_gzac4_d[l_ac].gzaj008 = ''
         LET g_gzac4_d[l_ac].gzaj009 = ''
         LET g_gzac4_d[l_ac].gzaj010 = ''
         LET g_gzac4_d[l_ac].gzaj011 = ''
         LET g_gzac4_d[l_ac].gzaj012 = ''
         LET g_gzac4_d[l_ac].gzaj013 = ''
      END IF 
     #gzaj005 = 3自行輸入時，開放gzaj009欄位，清空gzaj006---gzaj008欄位
      IF g_gzac4_d[l_ac].gzaj005 = '3' THEN
        #開放gzaj009欄位
         CALL cl_set_comp_entry('gzaj009',TRUE)
        #清空gzaj006---gzaj008,gzaj015----gzaj017欄位
         LET g_gzac4_d[l_ac].gzaj006 = ''
         LET g_gzac4_d[l_ac].gzaj006_desc = ''
         LET g_gzac4_d[l_ac].gzaj007 = ''
         LET g_gzac4_d[l_ac].gzaj008 = ''
         LET g_gzac4_d[l_ac].gzaj015 = ''
         LET g_gzac4_d[l_ac].gzaj016 = '' 
         LET g_gzac4_d[l_ac].gzaj017 = ''
        #根據gzaj009欄位的值來判斷後續欄位的開放否
        #gzaj009 = 1文字時，因為在一開始有關閉欄位所以這邊不需要重新關閉欄位
        #清空gzaj010--gzaj013內容
         IF g_gzac4_d[l_ac].gzaj009 = '1' THEN 
           #清空gzaj010--gzaj013內容
            LET g_gzac4_d[l_ac].gzaj010 = ''
            LET g_gzac4_d[l_ac].gzaj011 = ''
            LET g_gzac4_d[l_ac].gzaj012 = ''
            LET g_gzac4_d[l_ac].gzaj013 = ''
         END IF 
        #gzaj009 = 2數值
         IF g_gzac4_d[l_ac].gzaj009 = '2' THEN 
            CALL cl_set_comp_entry('gzaj010,gzaj011,gzaj012,gzaj013',TRUE)
         END IF 
      END IF 
   END IF    
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="azzi650.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi650_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi650_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION azzi650_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION azzi650_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi650_default_search()
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
      LET ls_wc = ls_wc, " gzaa001 = '", g_argv[01], "' AND "
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
 
         INITIALIZE g_wc2_table4 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "gzaa_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gzac_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gzad_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "gzai_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "gzaj_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
 
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
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
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
 
{<section id="azzi650.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION azzi650_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gzaa_m.gzaa001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN azzi650_cl USING g_gzaa_m.gzaa001
   IF STATUS THEN
      CLOSE azzi650_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi650_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE azzi650_master_referesh USING g_gzaa_m.gzaa001 INTO g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaacrtid, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt,g_gzaa_m.gzaaownid_desc, 
       g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid_desc,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaamodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT azzi650_action_chk() THEN
      CLOSE azzi650_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaal003,g_gzaa_m.gzaal004,g_gzaa_m.gzaa002, 
       g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzzz001,g_gzaa_m.gzzal003,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid, 
       g_gzaa_m.gzaaownid_desc,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid,g_gzaa_m.gzaacrtid_desc, 
       g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamodid_desc, 
       g_gzaa_m.gzaamoddt
 
   CASE g_gzaa_m.gzaastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_gzaa_m.gzaastus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_gzaa_m.gzaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE azzi650_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_gzaa_m.gzaamodid = g_user
   LET g_gzaa_m.gzaamoddt = cl_get_current()
   LET g_gzaa_m.gzaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gzaa_t 
      SET (gzaastus,gzaamodid,gzaamoddt) 
        = (g_gzaa_m.gzaastus,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt)     
    WHERE  gzaa001 = g_gzaa_m.gzaa001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE azzi650_master_referesh USING g_gzaa_m.gzaa001 INTO g_gzaa_m.gzaa004,g_gzaa_m.gzaa001, 
          g_gzaa_m.gzaa002,g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid,g_gzaa_m.gzaaowndp, 
          g_gzaa_m.gzaacrtid,g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamoddt, 
          g_gzaa_m.gzaaownid_desc,g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid_desc,g_gzaa_m.gzaacrtdp_desc, 
          g_gzaa_m.gzaamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gzaa_m.gzaa004,g_gzaa_m.gzaa001,g_gzaa_m.gzaal003,g_gzaa_m.gzaal004,g_gzaa_m.gzaa002, 
          g_gzaa_m.gzaa003,g_gzaa_m.gzaa005,g_gzaa_m.gzzz001,g_gzaa_m.gzzal003,g_gzaa_m.gzaastus,g_gzaa_m.gzaaownid, 
          g_gzaa_m.gzaaownid_desc,g_gzaa_m.gzaaowndp,g_gzaa_m.gzaaowndp_desc,g_gzaa_m.gzaacrtid,g_gzaa_m.gzaacrtid_desc, 
          g_gzaa_m.gzaacrtdp,g_gzaa_m.gzaacrtdp_desc,g_gzaa_m.gzaacrtdt,g_gzaa_m.gzaamodid,g_gzaa_m.gzaamodid_desc, 
          g_gzaa_m.gzaamoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   UPDATE gzzz_t SET gzzzstus = lc_state
   WHERE gzzz001 = g_gzaa_m.gzzz001
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE azzi650_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi650_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi650.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION azzi650_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gzac_d.getLength() THEN
         LET g_detail_idx = g_gzac_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzac_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzac_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_gzac2_d.getLength() THEN
         LET g_detail_idx = g_gzac2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzac2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzac2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_gzac3_d.getLength() THEN
         LET g_detail_idx = g_gzac3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzac3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzac3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_gzac4_d.getLength() THEN
         LET g_detail_idx = g_gzac4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzac4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzac4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi650_b_fill2(pi_idx)
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
   
   CALL azzi650_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi650_fill_chk(ps_idx)
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
 
{<section id="azzi650.status_show" >}
PRIVATE FUNCTION azzi650_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi650.mask_functions" >}
&include "erp/azz/azzi650_mask.4gl"
 
{</section>}
 
{<section id="azzi650.signature" >}
   
 
{</section>}
 
{<section id="azzi650.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi650_set_pk_array()
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
   LET g_pk_array[1].values = g_gzaa_m.gzaa001
   LET g_pk_array[1].column = 'gzaa001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi650.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="azzi650.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION azzi650_msgcentre_notify(lc_state)
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
   CALL azzi650_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi650.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION azzi650_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi650.other_function" readonly="Y" >}
# 調用aooi300，需要傳入應用分類碼gzaa001
PRIVATE FUNCTION azzi650_app_cc()
   DEFINE l_param     LIKE gzzz_t.gzzz004
   DEFINE ls_js       STRING
   DEFINE la_param    RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                  END RECORD

   IF cl_null(g_gzaa_m.gzaa001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-400'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   ELSE
     #IF g_gzaa_m.gzaa003 = 'Y' THEN
     #   CALL cl_cmdrun(" aooi300 '"||l_param||"'") 
     #ELSE 
     #   CALL cl_cmdrun(" aooi301 '"||l_param||"'") 
     #END IF 
      IF g_gzaa_m.gzaa003 = 'Y' THEN
         LET la_param.prog = 'aooi300'
      ELSE
         LET la_param.prog = 'aooi301'
      END IF
      CALL s_chr_add_quotes(g_gzaa_m.gzaa001) RETURNING l_param
      LET la_param.param[1] = l_param
      LET ls_js = util.JSON.stringify( la_param )
      CALL cl_cmdrun(ls_js)
   END IF
END FUNCTION
# 檢查gzaa001是否重複
PRIVATE FUNCTION azzi650_gzaa001_chk(p_cmd)
DEFINE p_cmd LIKE type_t.chr1
   
   IF NOT cl_null(g_gzaa_m.gzaa001) THEN
      IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_gzaa_m.gzaa001 != g_gzaa_m_t.gzaa001 ))) THEN
         IF NOT ap_chk_notDup(g_gzaa_m.gzaa001,"SELECT COUNT(*) FROM gzaa_t WHERE "||"gzaa001 = '"||g_gzaa_m.gzaa001 ||"'",'std-00004',0) THEN
            RETURN '1'
         END IF
         IF g_dgenv !='s' THEN
            IF g_gzaa_m.gzaa001 <9000 OR g_gzaa_m.gzaa001 >9999  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'azz-00031'
               LET g_errparam.extend = g_gzaa_m.gzaa001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN '1'
            END IF
         END IF 
         IF g_gzaa_m.gzaa001 >30000 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'azz-00033'
            LET g_errparam.extend = g_gzaa_m.gzaa001
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN '1'
         END IF
         IF g_gzaa_m.gzaa001 <= 0 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aqc-00011'
            LET g_errparam.extend = g_gzaa_m.gzaa001
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN '1'
         END IF
      END IF
   END IF
   return '0'
END FUNCTION
# copy chk gzaa001
PRIVATE FUNCTION azzi650_gzaa001_chk_1(p_gzaa001)
DEFINE p_gzaa001 LIKE gzaa_t.gzaa001
   IF NOT ap_chk_notDup(p_gzaa001 ,"SELECT COUNT(*) FROM gzaa_t WHERE "||"gzaa001 = '"||p_gzaa001||"'",'std-00004',0) THEN
      RETURN '1'
   END IF
   IF g_dgenv !='s' THEN
      IF p_gzaa001 <9000 OR p_gzaa001 >9999  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'azz-00031'
         LET g_errparam.extend = p_gzaa001 
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN '1'
      END IF
   END IF 
   IF g_gzaa_m.gzaa001 >30000 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00033'
      LET g_errparam.extend = p_gzaa001 
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN '1'
   END IF
   return '0'
END FUNCTION
# 新增時候根據gzaa001的值對gzaa002給默認值
PRIVATE FUNCTION azzi650_gzaa001_ref(p_cmd)
DEFINE p_cmd LIKE type_t.chr1
DEFINE lc_gzzz004 LIKE gzzz_t.gzzz004
   IF p_cmd = 'a' THEN
      IF g_gzaa_m.gzaa001 >=9000 AND g_gzaa_m.gzaa001 <= 9999 THEN
         LET g_gzaa_m.gzaa002 = 'N'
      ELSE
         LET g_gzaa_m.gzaa002 = 'Y'
      END IF 
   END IF
   LET g_gzaa_m.gzzz001=''
   LET g_gzaa_m.gzzal003 = ''
  #LET lc_gzzz004 = g_gzaa_m.gzaa001 
   CALL s_chr_add_quotes(g_gzaa_m.gzaa001) RETURNING lc_gzzz004
   SELECT gzzz001 INTO g_gzaa_m.gzzz001
     FROM gzzz_t
    WHERE (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')
      AND gzzz004= lc_gzzz004
   DISPLAY BY NAME g_gzaa_m.gzzz001
   SELECT gzzal003 INTO g_gzaa_m.gzzal003
     FROM gzzal_t WHERE gzzal001=g_gzaa_m.gzzz001 AND gzzal002=g_lang 
   DISPLAY BY NAME g_gzaa_m.gzzal003
END FUNCTION
################################################################################
# Descriptions...: 根據模組來給出ACC的默認值
# Memo...........:
# Usage..........: azzi650_gzaa004_def_gzaa001(p_gzaa004)
#                  RETURNING r_gzaa001
# Input parameter: p_gzaa004
# Return code....: r_gzaa001
# Date & Author..: 2013/11/19 By xuxz
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi650_gzaa004_def_gzaa001(p_gzaa004)
   DEFINE p_gzaa004 LIKE gzaa_t.gzaa004
   DEFINE r_gzaa001 LIKE gzaa_t.gzaa001
   
   LET r_gzaa001  = 0
   IF p_gzaa004 = 1 THEN
      SELECT max(gzaa001) INTO r_gzaa001 FROM gzaa_t
       WHERE gzaa004 = 1
      IF cl_null(r_gzaa001) THEN
         LET r_gzaa001 = 1
      ELSE
         LET r_gzaa001 = r_gzaa001 +1
      END IF 
      IF r_gzaa001 >999 THEN
         SELECT min(gzaa001+1) INTO r_gzaa001 FROM gzaa_t 
          WHERE gzaa001 <1000 AND gzaa001+1 NOT IN (select gzaa001 FROM gzaa_t)
         IF r_gzaa001 >=1000 THEN
            LET r_gzaa001 = "1"
         END IF
      END IF 
   END IF 
   IF p_gzaa004 = 2 THEN
      SELECT max(gzaa001) INTO r_gzaa001 FROM gzaa_t
       WHERE gzaa004 = 2
      IF cl_null(r_gzaa001) THEN
         LET r_gzaa001 = 1000
      ELSE
         LET r_gzaa001 = r_gzaa001 +1
      END IF 
      IF r_gzaa001 >1999 THEN
         SELECT min(gzaa001+1) INTO r_gzaa001 FROM gzaa_t 
          WHERE gzaa001 <2000 AND gzaa001 >=1000 AND gzaa001+1 NOT IN (select gzaa001 FROM gzaa_t)
         IF r_gzaa001 >=2000 THEN
            LET r_gzaa001 = "1000"
         END IF
      END IF 
   END IF 
   IF p_gzaa004 = 3 THEN
      SELECT max(gzaa001) INTO r_gzaa001 FROM gzaa_t
       WHERE gzaa004 = 3
      IF cl_null(r_gzaa001) THEN
         LET r_gzaa001 = "2000"
      ELSE
         LET r_gzaa001 = r_gzaa001 +1
      END IF
      IF r_gzaa001 >2999 THEN
         SELECT min(gzaa001+1) INTO r_gzaa001 FROM gzaa_t 
          WHERE gzaa001 <3000 AND gzaa001 >=2000 AND gzaa001+1 NOT IN (select gzaa001 FROM gzaa_t)
         IF r_gzaa001 >=3000 THEN
            LET r_gzaa001 = "2000"
         END IF
      END IF
   END IF
   IF p_gzaa004 = "4" THEN
      SELECT max(gzaa001) INTO r_gzaa001 FROM gzaa_t
       WHERE gzaa004 = '4'
      IF cl_null(r_gzaa001) THEN
         LET r_gzaa001 = "3000"
      ELSE
         LET r_gzaa001 = r_gzaa001 +1
      END IF
      IF r_gzaa001 >3999 THEN
         SELECT min(gzaa001+1) INTO r_gzaa001 FROM gzaa_t 
          WHERE gzaa001 <4000 AND gzaa001 >=3000 AND gzaa001+1 NOT IN (select gzaa001 FROM gzaa_t)
         IF r_gzaa001 >=4000 THEN
            LET r_gzaa001 = "3000"
         END IF
      END IF
   END IF 
   IF p_gzaa004 = "5" THEN
      SELECT max(gzaa001) INTO r_gzaa001 FROM gzaa_t
       WHERE gzaa004 = '5'
      IF cl_null(r_gzaa001) THEN
         LET r_gzaa001 = "8000"
      ELSE
         LET r_gzaa001 = r_gzaa001 +1
      END IF
      IF r_gzaa001 >8999 THEN
         SELECT min(gzaa001+1) INTO r_gzaa001 FROM gzaa_t 
          WHERE gzaa001 <9000 AND gzaa001 >=8000 AND gzaa001+1 NOT IN (select gzaa001 FROM gzaa_t)
         IF r_gzaa001 >=9000 THEN
            LET r_gzaa001 = "8000"
         END IF
      END IF
   END IF 
   IF p_gzaa004 = "6" THEN
      SELECT max(gzaa001) INTO r_gzaa001 FROM gzaa_t
       WHERE gzaa004 = '6'
      IF cl_null(r_gzaa001) THEN
         LET r_gzaa001 = "9000"
      ELSE
         LET r_gzaa001 = r_gzaa001 +1
      END IF
      IF r_gzaa001 >9999 THEN
         SELECT min(gzaa001+1) INTO r_gzaa001 FROM gzaa_t 
          WHERE gzaa001 <10000 AND gzaa001 >=9000 AND gzaa001+1 NOT IN (select gzaa001 FROM gzaa_t)
         IF r_gzaa001 >=10000 THEN
            LET r_gzaa001 = "9000"
         END IF
      END IF
   END IF 
   IF p_gzaa004 = "7" THEN
      SELECT max(gzaa001) INTO r_gzaa001 FROM gzaa_t
       WHERE gzaa004 = '7'
      IF cl_null(r_gzaa001) THEN
         LET r_gzaa001 = "10000"
      ELSE
         LET r_gzaa001 = r_gzaa001 +1
      END IF
      IF r_gzaa001 >30000 THEN
         SELECT min(gzaa001+1) INTO r_gzaa001 FROM gzaa_t 
          WHERE gzaa001 >=10000 AND gzaa001 <= 30000 AND gzaa001+1 NOT IN (select gzaa001 FROM gzaa_t)
         IF r_gzaa001 >=30000 THEN
            LET r_gzaa001 = "10000"
         END IF
      END IF
   END IF 
   
   RETURN r_gzaa001
END FUNCTION
# gzac002欄位設置comb內容
PRIVATE FUNCTION azzi650_gzac002_comb()
DEFINE ls_values       STRING             #ComboBox values
   DEFINE ls_items     STRING             #ComboBox items
   DEFINE l_gzzy001    LIKE type_t.chr5
   DEFINE l_gzzy002    LIKE gzzy_t.gzzy002

   LET ls_values = NULL
   LET ls_items = NULL
   LET l_gzzy001 = NULL
   LET l_gzzy002 = NULL
   DECLARE gzzy_001_cs CURSOR FOR
    SELECT gzzy001,gzzy002
      FROM gzzy_t
     ORDER BY gzzy001
   FOREACH gzzy_001_cs INTO l_gzzy001,l_gzzy002
      LET ls_values = ls_values CLIPPED,',',l_gzzy001 CLIPPED
      LET ls_items = ls_items CLIPPED,',',l_gzzy001 CLIPPED,':',l_gzzy002 CLIPPED
   END FOREACH
   CALL cl_set_combo_items("gzac_t.gzac002",ls_values,ls_items)
   CALL cl_set_combo_items("gzai_t.gzai002",ls_values,ls_items)
END FUNCTION

PRIVATE FUNCTION azzi650_gzad002_ref()
DEFINE l_sql STRING
   DEFINE l_str_field_bef STRING
   LET l_str_field_bef = (g_gzac2_d[l_ac].gzad002 +2 )USING '&&'
   LET l_sql = " SELECT gzac0",l_str_field_bef ," FROM gzac_t",
               "  WHERE gzac001 = '",g_gzaa_m.gzaa001,"'",
               "    AND gzac002 = '",g_dlang,"'"
   PREPARE azzi650_cklw_pre FROM l_sql
   EXECUTE azzi650_cklw_pre INTO g_gzac2_d[l_ac].gzad002_desc
   IF cl_null(g_gzac2_d[l_ac].gzad002_desc) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_gzac2_d[l_ac].gzad002
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='990' AND gzcbl002 = ? AND gzcbl003 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
      LET g_gzac2_d[l_ac].gzad002_desc = g_rtn_fields[1]
   END IF 
   DISPLAY BY NAME g_gzac2_d[l_ac].gzad002_desc
END FUNCTION
# 修改gzad005后如果修改回舊值需將後續內容恢復
PRIVATE FUNCTION azzi650_gzad005_bak_old()
   IF g_gzac2_d[l_ac].gzad005 = g_gzac2_d_t.gzad005 AND NOT cl_null(g_gzac2_d[l_ac].gzad005)THEN 
      LET g_gzac2_d[l_ac].* = g_gzac2_d_t.*
      CALL azzi650_gzad006_ref()
   END IF
END FUNCTION
# 檢查gzad006
PRIVATE FUNCTION azzi650_gzad006_chk()
  DISPLAY ' ' TO s_detail2[l_ac].gzad006_desc
  IF g_gzac2_d[l_ac].gzad005 = '1' THEN
      IF NOT ap_chk_isExist(g_gzac2_d[l_ac].gzad006,"SELECT COUNT(*) FROM gzca_t WHERE  "
         ||" gzca001 = ? ","azz-00023",0 ) THEN
         RETURN '1'
      END IF
      IF NOT ap_chk_isExist(g_gzac2_d[l_ac].gzad006,"SELECT COUNT(*) FROM gzca_t WHERE gzcastus = 'Y' "
#          ||" AND gzca001 = ? ","azz-00024",0 ) THEN    #160318-00005#55  mark
          ||" AND gzca001 = ? ","sub-01302",'azzi600' ) THEN     #160318-00005#55  add
         RETURN '1'
      END IF    
   END IF 
   IF g_gzac2_d[l_ac].gzad005 = '4' THEN
      IF NOT ap_chk_isExist(g_gzac2_d[l_ac].gzad006,"SELECT COUNT(*) FROM gzaa_t WHERE  "
         ||" gzaa001 = ? ","azz-00057",0 ) THEN
         RETURN '1'
      END IF
      IF NOT ap_chk_isExist(g_gzac2_d[l_ac].gzad006,"SELECT COUNT(*) FROM gzaa_t WHERE gzaastus = 'Y' "
#          ||" AND gzaa001 = ? ","azz-00058",0 ) THEN     #160318-00005#55  mark
          ||" AND gzaa001 = ? ","sub-01302",'azzi650' ) THEN      #160318-00005#55  add
         RETURN '1'
      END IF    
   END IF
   RETURN '0'
END FUNCTION
# gzad006帶值
#
PRIVATE FUNCTION azzi650_gzad006_ref()
  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzac2_d[l_ac].gzad006
   IF g_gzac2_d[l_ac].gzad005 = '1' THEN 
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcal003 FROM gzcal_t WHERE gzcal001=? AND gzcal002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
   ELSE
      CALL ap_ref_array2(g_ref_fields,"SELECT gzaal003 FROM gzaal_t WHERE gzaal001=? AND gzaal002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
   END IF 
   LET g_gzac2_d[l_ac].gzad006_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_gzac2_d[l_ac].gzad006_desc
END FUNCTION
# 檢查gzad007
PRIVATE FUNCTION azzi650_gzad007_chk()
   IF NOT ap_chk_isExist(g_gzac2_d[l_ac].gzad007,"SELECT COUNT(*) FROM dzca_t WHERE  "
      ||" dzca001 = ? ","azz-00025",0 ) THEN
      RETURN '1'
   END IF
   IF NOT ap_chk_isExist(g_gzac2_d[l_ac].gzad007,"SELECT COUNT(*) FROM dzca_t WHERE  "
      ||" dzca001 = ? AND dzca001 NOT IN (SELECT dzcb001 FROM dzcb_t) ","azz-00096",0 ) THEN
      RETURN '1'
   END IF
   RETURN '0'
END FUNCTION
# 檢查gzad008
PRIVATE FUNCTION azzi650_gzad008_chk()
   IF NOT ap_chk_isExist(g_gzac2_d[l_ac].gzad008,"SELECT COUNT(*) FROM dzcd_t WHERE  "
      ||" dzcd001 = ? ","azz-00027",0 ) THEN
      RETURN '1'
   END IF
   IF NOT ap_chk_isExist(g_gzac2_d[l_ac].gzad008,"SELECT COUNT(*) FROM dzcd_t WHERE  "
      ||" dzcd001 = ? AND dzcd005='1' AND dzcd001 IN (SELECT dzce001 FROM dzce_t GROUP BY dzce001 HAVING COUNT(dzce001)=1) ","azz-00097",0 ) THEN
      RETURN '1'
   END IF
   RETURN '0'
END FUNCTION
# gzad010--gzad013恢復舊值
PRIVATE FUNCTION azzi650_gzad009_bak_old()
IF g_gzac2_d[l_ac].gzad009 = g_gzac2_d_t.gzad009 AND NOT cl_null(g_gzac2_d[l_ac].gzad009)THEN 
      LET g_gzac2_d[l_ac].gzad010 = g_gzac2_d_t.gzad010
      LET g_gzac2_d[l_ac].gzad011 = g_gzac2_d_t.gzad011
      LET g_gzac2_d[l_ac].gzad012 = g_gzac2_d_t.gzad012
      LET g_gzac2_d[l_ac].gzad013 = g_gzac2_d_t.gzad013
   END IF
END FUNCTION

PRIVATE FUNCTION azzi650_gzad011_chk()
IF  cl_null(g_gzac2_d[l_ac].gzad011) OR cl_null(g_gzac2_d[l_ac].gzad013) THEN
      RETURN 0
   END IF 
   IF g_gzac2_d[l_ac].gzad011 > g_gzac2_d[l_ac].gzad013 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00032'
      LET g_errparam.extend = g_gzac2_d[l_ac].gzad011 
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN '1'
   END IF 
   RETURN '0'
END FUNCTION

PRIVATE FUNCTION azzi650_gzad013_chk()
IF  cl_null(g_gzac2_d[l_ac].gzad011) OR cl_null(g_gzac2_d[l_ac].gzad013) THEN
      RETURN 0
   END IF 
   IF g_gzac2_d[l_ac].gzad011 > g_gzac2_d[l_ac].gzad013 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00032'
      LET g_errparam.extend = g_gzac2_d[l_ac].gzad013 
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN '1'
   END IF 
   RETURN '0'
END FUNCTION
# 控制gzad栏位的entry否
PRIVATE FUNCTION azzi650_gzad_entry_set()
#首先將gzad002，gzad003以外的欄位全部關閉
   CALL cl_set_comp_entry('gzad002',FALSE)
   CALL cl_set_comp_entry('gzad004,gzad005,gzad006,gzad007,gzad008',FALSE)
   CALL cl_set_comp_entry('gzad009,gzad010,gzad011,gzad012,gzad013,gzad014',FALSE)
   CALL cl_set_comp_entry('gzad015,gzad016,gzad017',FALSE)
   CALL azzi650_gzad006_ref()
   CALL azzi650_gzad002_ref()
   CALL cl_set_comp_required('gzad006',FALSE)
  #當gzad003 = 'N'時將gzad004 修改為Y，同時清空gzad005 ---gzad013內容
   IF g_gzac2_d[l_ac].gzad003 = 'N' THEN
     #gzad004 修改為Y
      LET g_gzac2_d[l_ac].gzad004 = 'Y'
     #清空gzad005 ---gzad017內容
      LET g_gzac2_d[l_ac].gzad005 = ''
      LET g_gzac2_d[l_ac].gzad006 = ''
      LET g_gzac2_d[l_ac].gzad007 = ''
      LET g_gzac2_d[l_ac].gzad008 = ''
      LET g_gzac2_d[l_ac].gzad009 = ''
      LET g_gzac2_d[l_ac].gzad010 = ''
      LET g_gzac2_d[l_ac].gzad011 = ''
      LET g_gzac2_d[l_ac].gzad012 = ''
      LET g_gzac2_d[l_ac].gzad013 = '' 
      LET g_gzac2_d[l_ac].gzad014 = ''
      LET g_gzac2_d[l_ac].gzad015 = ''
      LET g_gzac2_d[l_ac].gzad016 = '' 
      LET g_gzac2_d[l_ac].gzad017 = ''
      LET g_gzac2_d[l_ac].gzad006_desc = ''
   ELSE
  #當gzad003 = 'Y'時，開發gzad004，gzad005欄位
      CALL cl_set_comp_entry('gzad004,gzad005,gzad014',TRUE)
     #根據gzad005欄位的值來判斷後續欄位的開放否
     #gzad005 = 1 系統分類碼時，開放gzad006，清空gzad009---gzad013內容
     #將gazd007 = 'q_gzca001'，gzad008 = 'v_gzca001'
      IF g_gzac2_d[l_ac].gzad005 = '1' OR g_gzac2_d[l_ac].gzad005 = '4' THEN
        #開放gzad006
         CALL cl_set_comp_entry('gzad006',TRUE)
         IF g_gzac2_d[l_ac].gzad005 = '1'  THEN
        #將gazd007 = 'q_gzcb001'，gzad008 = 'v_gzcb002' 
            LET g_gzac2_d[l_ac].gzad007 = 'q_gzcb001'
            LET g_gzac2_d[l_ac].gzad008 = 'v_gzcb002' 
         END IF 
         IF g_gzac2_d[l_ac].gzad005 = '4'  THEN
        #將gazd007 = 'q_oocq002'，gzad008 = 'v_oocq002' 
            LET g_gzac2_d[l_ac].gzad007 = 'q_oocq002'
            LET g_gzac2_d[l_ac].gzad008 = 'v_oocq002' 
         END IF
        #清空gzad009 ---gzad013,gzad015----gzad017內容
        
         LET g_gzac2_d[l_ac].gzad009 = ''
         LET g_gzac2_d[l_ac].gzad010 = ''
         LET g_gzac2_d[l_ac].gzad011 = ''
         LET g_gzac2_d[l_ac].gzad012 = ''
         LET g_gzac2_d[l_ac].gzad013 = '' 
         LET g_gzac2_d[l_ac].gzad015 = ''
         LET g_gzac2_d[l_ac].gzad016 = '' 
         LET g_gzac2_d[l_ac].gzad017 = ''
         CALL cl_set_comp_required('gzad006',TRUE)
      END IF 
     #gzad005 = 2建檔開窗時，開放gzad007，gzad008欄位，清空gzad006，gzad009--gzad013內容
      IF g_gzac2_d[l_ac].gzad005 = '2' THEN 
        #開放gzad007，gzad008,gzad017,gzad016,gzad015欄位
         CALL cl_set_comp_entry('gzad007,gzad008',TRUE)
         CALL cl_set_comp_entry('gzad017,gzad016,gzad015',TRUE)
        #清空gzad006，gzad009---gzad013欄位
         LET g_gzac2_d[l_ac].gzad006 = ''
         LET g_gzac2_d[l_ac].gzad006_desc = ''
         #LET g_gzac2_d[l_ac].gzad007 = ''
         #LET g_gzac2_d[l_ac].gzad008 = ''
         LET g_gzac2_d[l_ac].gzad009 = ''
         LET g_gzac2_d[l_ac].gzad010 = ''
         LET g_gzac2_d[l_ac].gzad011 = ''
         LET g_gzac2_d[l_ac].gzad012 = ''
         LET g_gzac2_d[l_ac].gzad013 = ''
      END IF 
     #gzad005 = 3自行輸入時，開放gzad009欄位，清空gzad006---gzad008欄位
      IF g_gzac2_d[l_ac].gzad005 = '3' THEN
        #開放gzad009欄位
         CALL cl_set_comp_entry('gzad009',TRUE)
        #清空gzad006---gzad008,gzad015----gzad017欄位
         LET g_gzac2_d[l_ac].gzad006 = ''
         LET g_gzac2_d[l_ac].gzad006_desc = ''
         LET g_gzac2_d[l_ac].gzad007 = ''
         LET g_gzac2_d[l_ac].gzad008 = ''
         LET g_gzac2_d[l_ac].gzad015 = ''
         LET g_gzac2_d[l_ac].gzad016 = '' 
         LET g_gzac2_d[l_ac].gzad017 = ''
        #根據gzad009欄位的值來判斷後續欄位的開放否
        #gzad009 = 1文字時，因為在一開始有關閉欄位所以這邊不需要重新關閉欄位
        #清空gzad010--gzad013內容
         IF g_gzac2_d[l_ac].gzad009 = '1' THEN 
           #清空gzad010--gzad013內容
            LET g_gzac2_d[l_ac].gzad010 = ''
            LET g_gzac2_d[l_ac].gzad011 = ''
            LET g_gzac2_d[l_ac].gzad012 = ''
            LET g_gzac2_d[l_ac].gzad013 = ''
         END IF 
        #gzad009 = 2數值
         IF g_gzac2_d[l_ac].gzad009 = '2' THEN 
            CALL cl_set_comp_entry('gzad010,gzad011,gzad012,gzad013',TRUE)
         END IF 
      END IF 
   END IF

END FUNCTION
# 當單頭錄入完成后再gzad_t 中產生20筆資料
PRIVATE FUNCTION azzi650_ins_gzad()
DEFINE l_gzad002 LIKE gzad_t.gzad002
   
   FOR l_gzad002 = 1 TO 20
      INSERT INTO gzad_t(gzad001,gzad002,gzad003,gzad004) VALUES (g_gzaa_m.gzaa001,l_gzad002,'N','Y')
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 執行azzi910(系統可執行作業設定)
# Memo...........:
# Usage..........: CALL azzi650_open_azzi910()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 14/04/21 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi650_open_azzi910()
   DEFINE l_gzzz004   LIKE gzzz_t.gzzz004
   DEFINE l_gzzz001   LIKE gzzz_t.gzzz001
   DEFINE l_prog      LIKE gzzz_t.gzzz001
   DEFINE l_msg       STRING
   DEFINE l_msg1      STRING
   DEFINE l_msg2      STRING
   DEFINE l_msg3      STRING
   DEFINE l_msg4      STRING
   DEFINE l_msg5      STRING
   DEFINE ls_js       STRING
   DEFINE la_param    RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                  END RECORD

   IF cl_null(g_gzaa_m.gzaa001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-400'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   ELSE
      CALL s_chr_add_quotes(g_gzaa_m.gzaa001) RETURNING l_gzzz004
      SELECT gzzz001 INTO l_gzzz001
        FROM gzzz_t
       WHERE (gzzz002='aooi300' OR gzzz002='aooi301' OR gzzz002='aooi310')
         AND gzzz004= l_gzzz004
      IF NOT cl_null(l_gzzz001) THEN  #這筆ACC已經建立過作業編號,直接帶出那一筆
         LET la_param.prog = 'azzi910'
         LET la_param.param[1] = l_gzzz001
         LET ls_js = util.JSON.stringify( la_param )
         CALL cl_cmdrun(ls_js)
      ELSE
         IF g_gzaa_m.gzaa003='N' THEN
            LET l_prog='aooi301'
         ELSE
            LET l_prog='aooi300'
         END IF
#        LET l_msg ="請到azzi910(系統可執行作業設定)手動新增作業資料。",
#                   "程式編號:",l_prog CLIPPED,
#                   "程式名稱:",g_gzaa_m.gzaal003 CLIPPED,"維護作業",
#                   "額外參數:",g_gzaa_m.gzaa001
#        CALL cl_err_msg(NULL, "azz-00651", l_prog || "|" || g_gzaa_m.gzaal003 || "|" || g_gzaa_m.gzaa001, 10)
         CALL cl_getmsg('azz-00652',g_dlang) RETURNING l_msg1
#         CALL cl_getmsg('azz-00653',g_dlang) RETURNING l_msg2    #160318-00005#55  mark
         CALL cl_getmsg('sub-01335',g_dlang) RETURNING l_msg2     #160318-00005#55  add
#         CALL cl_getmsg('azz-00654',g_dlang) RETURNING l_msg3    #160318-00005#55  mark
         CALL cl_getmsg('sub-01335',g_dlang) RETURNING l_msg3     #160318-00005#55  add
         CALL cl_getmsg('azz-00655',g_dlang) RETURNING l_msg4
         CALL cl_getmsg('azz-00657',g_dlang) RETURNING l_msg5
         LET l_msg = l_msg1,"\n",
                     l_msg2,l_prog CLIPPED,"\n",
                     l_msg3,g_gzaa_m.gzaal003 CLIPPED,l_msg5,"\n",
                     l_msg4,g_gzaa_m.gzaa001
         CALL azzi650_show_msg(l_msg)
         LET la_param.prog = 'azzi910'
         LET la_param.param[1] = g_gzaa_m.gzaa001
         LET ls_js = util.JSON.stringify( la_param )
         CALL cl_cmdrun(ls_js)
      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION azzi650_next_field(p_gzaa001)
   DEFINE p_gzaa001 LIKE gzaa_t.gzaa001
   DEFINE l_gzac003 LIKE gzac_t.gzac003
   DEFINE l_gzac004 LIKE gzac_t.gzac004
   DEFINE l_gzac005 LIKE gzac_t.gzac005
   DEFINE l_gzac006 LIKE gzac_t.gzac006
   DEFINE l_gzac007 LIKE gzac_t.gzac007
   DEFINE l_gzac008 LIKE gzac_t.gzac008
   DEFINE l_gzac009 LIKE gzac_t.gzac009
   DEFINE l_gzac010 LIKE gzac_t.gzac010
   DEFINE l_gzac011 LIKE gzac_t.gzac011
   DEFINE l_gzac012 LIKE gzac_t.gzac012
   DEFINE l_gzac013 LIKE gzac_t.gzac013
   DEFINE l_gzac014 LIKE gzac_t.gzac014
   DEFINE l_gzac015 LIKE gzac_t.gzac015
   DEFINE l_gzac016 LIKE gzac_t.gzac016
   DEFINE l_gzac017 LIKE gzac_t.gzac017
   DEFINE l_gzac018 LIKE gzac_t.gzac018
   DEFINE l_gzac019 LIKE gzac_t.gzac019
   DEFINE l_gzac020 LIKE gzac_t.gzac020
   DEFINE l_gzac021 LIKE gzac_t.gzac021
   DEFINE l_gzac022 LIKE gzac_t.gzac022
   DEFINE l_count   LIKE type_t.num5
   DEFINE l_gzad003 LIKE gzad_t.gzad003
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   SELECT gzac003,gzac004,gzac005,gzac006,gzac007,gzac008,gzac009,gzac010,
          gzac011,gzac012,gzac013,gzac014,gzac015,gzac016,gzac017,gzac018,
          gzac019,gzac020,gzac021,gzac022 
     INTO l_gzac003,l_gzac004,l_gzac005,l_gzac006,l_gzac007,l_gzac008,l_gzac009,l_gzac010,
          l_gzac011,l_gzac012,l_gzac013,l_gzac014,l_gzac015,l_gzac016,l_gzac017,l_gzac018,
          l_gzac019,l_gzac020,l_gzac021,l_gzac022
     FROM gzac_t
    WHERE gzac001 = p_gzaa001
      AND gzac002 = g_lang
   IF NOT cl_null(l_gzac003) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '1'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF 
   IF NOT cl_null(l_gzac004) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '2'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF   
   IF NOT cl_null(l_gzac005) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '3'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac006) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '4'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac007) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '5'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac008) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '6'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac009) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '7'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac010) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '8'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac011) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '9'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac012) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '10'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac013) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '11'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac014) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '12'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac015) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '13'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac016) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '14'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac017) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '15'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac018) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '16'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac019) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '17'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac020) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '18'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac021) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '19'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzac022) THEN 
      LET l_count = 0 
      SELECT gzad003 INTO l_gzad003 FROM gzad_t
       WHERE gzad001 = p_gzaa001 AND gzad002 = '20'
      IF l_gzad003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 顯示多行提示訊息
# Memo...........:
# Usage..........: CALL azzi650_show_msg(p_msg)
# Input parameter: p_msg   要顯示的訊息
# Return code....: 無
# Date & Author..: 14/04/28 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi650_show_msg(p_msg)
   DEFINE p_msg   STRING

   OPEN WINDOW azzi650_s01_w WITH FORM cl_ap_formpath("azz","azzi650_s01")
       ATTRIBUTE (STYLE="functionwin")
   CALL cl_ui_init()

   DISPLAY p_msg TO FORMONLY.s01
   MENU
      ON ACTION exit
         EXIT MENU
      ON ACTION close
         EXIT MENU
   END MENU

   CLOSE WINDOW azzi650_s01_w
END FUNCTION

PRIVATE FUNCTION azzi650_gzaj006_desc()
  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gzac4_d[l_ac].gzaj006
   IF g_gzac4_d[l_ac].gzaj005 = '1' THEN 
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcal003 FROM gzcal_t WHERE gzcal001=? AND gzcal002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
   ELSE
      CALL ap_ref_array2(g_ref_fields,"SELECT gzaal003 FROM gzaal_t WHERE gzaal001=? AND gzaal002 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
   END IF 
   LET g_gzac4_d[l_ac].gzaj006_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_gzac4_d[l_ac].gzaj006_desc
END FUNCTION

PRIVATE FUNCTION azzi650_gzaj006_chk()

  IF g_gzac4_d[l_ac].gzaj005 = '1' THEN
      IF NOT ap_chk_isExist(g_gzac4_d[l_ac].gzaj006,"SELECT COUNT(*) FROM gzca_t WHERE  "
         ||" gzca001 = ? ","azz-00023",0 ) THEN
         RETURN '1'
      END IF
      IF NOT ap_chk_isExist(g_gzac4_d[l_ac].gzaj006,"SELECT COUNT(*) FROM gzca_t WHERE gzcastus = 'Y' "
#          ||" AND gzca001 = ? ","azz-00024",0 ) THEN          #160318-00005#55  mark
          ||" AND gzca001 = ? ","sub-01302",'azzi600') THEN    #160318-00005#55  add
         RETURN '1'
      END IF    
   END IF 
   IF g_gzac4_d[l_ac].gzaj005 = '4' THEN
      IF NOT ap_chk_isExist(g_gzac4_d[l_ac].gzaj006,"SELECT COUNT(*) FROM gzaa_t WHERE  "
         ||" gzaa001 = ? ","azz-00057",0 ) THEN
         RETURN '1'
      END IF
      IF NOT ap_chk_isExist(g_gzac4_d[l_ac].gzaj006,"SELECT COUNT(*) FROM gzaa_t WHERE gzaastus = 'Y' "
#          ||" AND gzaa001 = ? ","azz-00058",0 ) THEN          #160318-00005#55  mark
          ||" AND gzaa001 = ? ","sub-01302",'azzi650' ) THEN   #160318-00005#55  add
         RETURN '1'
      END IF    
   END IF
   RETURN '0'
END FUNCTION

PRIVATE FUNCTION azzi650_gzaj007_chk()
   IF NOT ap_chk_isExist(g_gzac4_d[l_ac].gzaj007,"SELECT COUNT(*) FROM dzca_t WHERE  "
      ||" dzca001 = ? ","azz-00025",0 ) THEN
      RETURN '1'
   END IF
   IF NOT ap_chk_isExist(g_gzac4_d[l_ac].gzaj007,"SELECT COUNT(*) FROM dzca_t WHERE  "
      ||" dzca001 = ? AND dzca001 NOT IN (SELECT dzcb001 FROM dzcb_t) ","azz-00096",0 ) THEN
      RETURN '1'
   END IF
   RETURN '0'
END FUNCTION

PRIVATE FUNCTION azzi650_gzaj008_chk()
   IF NOT ap_chk_isExist(g_gzac4_d[l_ac].gzaj008,"SELECT COUNT(*) FROM dzcd_t WHERE  "
      ||" dzcd001 = ? ","azz-00027",0 ) THEN
      RETURN '1'
   END IF
   IF NOT ap_chk_isExist(g_gzac4_d[l_ac].gzaj008,"SELECT COUNT(*) FROM dzcd_t WHERE  "
      ||" dzcd001 = ? AND dzcd005='1' AND dzcd001 IN (SELECT dzce001 FROM dzce_t GROUP BY dzce001 HAVING COUNT(dzce001)=1) ","azz-00097",0 ) THEN
      RETURN '1'
   END IF
   RETURN '0'
END FUNCTION

PRIVATE FUNCTION azzi650_gzaj011_chk()
   IF  cl_null(g_gzac4_d[l_ac].gzaj011) OR cl_null(g_gzac4_d[l_ac].gzaj013) THEN
      RETURN 0
   END IF 
   IF g_gzac4_d[l_ac].gzaj011 > g_gzac4_d[l_ac].gzaj013 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00032'
      LET g_errparam.extend = g_gzac4_d[l_ac].gzaj011 
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN '1'
   END IF 
   RETURN '0'
END FUNCTION

PRIVATE FUNCTION azzi650_gzaj013_chk()
   IF  cl_null(g_gzac4_d[l_ac].gzaj011) OR cl_null(g_gzac4_d[l_ac].gzaj013) THEN
      RETURN 0
   END IF 
   IF g_gzac4_d[l_ac].gzaj011 > g_gzac4_d[l_ac].gzaj013 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'azz-00032'
      LET g_errparam.extend = g_gzac4_d[l_ac].gzaj013 
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN '1'
   END IF 
   RETURN '0'
END FUNCTION

PRIVATE FUNCTION azzi650_gzaj002_desc()
DEFINE l_sql STRING
DEFINE l_str_field_bef STRING


   LET l_str_field_bef = (g_gzac4_d[l_ac].gzaj002 +2 )USING '&&'
   LET l_sql = " SELECT gzai0",l_str_field_bef ," FROM gzai_t",
               "  WHERE gzai001 = '",g_gzaa_m.gzaa001,"'",
               "    AND gzai002 = '",g_dlang,"'"
   PREPARE azzi650_cklw_pre2 FROM l_sql
   EXECUTE azzi650_cklw_pre2 INTO g_gzac4_d[l_ac].gzaj002_desc
   IF cl_null(g_gzac4_d[l_ac].gzaj002_desc) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_gzac4_d[l_ac].gzaj002
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='990' AND gzcbl002 = ? AND gzcbl003 = '"||g_dlang||"' ","") RETURNING g_rtn_fields
      LET g_gzac4_d[l_ac].gzaj002_desc = g_rtn_fields[1]
   END IF 
   DISPLAY BY NAME g_gzac4_d[l_ac].gzaj002_desc
END FUNCTION

PRIVATE FUNCTION azzi650_ins_gzaj()
DEFINE l_gzaj002 LIKE gzaj_t.gzaj002
   
   FOR l_gzaj002 = 1 TO 20
      INSERT INTO gzaj_t(gzaj001,gzaj002,gzaj003,gzaj004) VALUES (g_gzaa_m.gzaa001,l_gzaj002,'N','Y')
   END FOR
END FUNCTION

PRIVATE FUNCTION azzi650_next_field2(p_gzaa001)
   DEFINE p_gzaa001 LIKE gzaa_t.gzaa001
   DEFINE l_gzai003 LIKE gzai_t.gzai003
   DEFINE l_gzai004 LIKE gzai_t.gzai004
   DEFINE l_gzai005 LIKE gzai_t.gzai005
   DEFINE l_gzai006 LIKE gzai_t.gzai006
   DEFINE l_gzai007 LIKE gzai_t.gzai007
   DEFINE l_gzai008 LIKE gzai_t.gzai008
   DEFINE l_gzai009 LIKE gzai_t.gzai009
   DEFINE l_gzai010 LIKE gzai_t.gzai010
   DEFINE l_gzai011 LIKE gzai_t.gzai011
   DEFINE l_gzai012 LIKE gzai_t.gzai012
   DEFINE l_gzai013 LIKE gzai_t.gzai013
   DEFINE l_gzai014 LIKE gzai_t.gzai014
   DEFINE l_gzai015 LIKE gzai_t.gzai015
   DEFINE l_gzai016 LIKE gzai_t.gzai016
   DEFINE l_gzai017 LIKE gzai_t.gzai017
   DEFINE l_gzai018 LIKE gzai_t.gzai018
   DEFINE l_gzai019 LIKE gzai_t.gzai019
   DEFINE l_gzai020 LIKE gzai_t.gzai020
   DEFINE l_gzai021 LIKE gzai_t.gzai021
   DEFINE l_gzai022 LIKE gzai_t.gzai022  
   DEFINE l_count   LIKE type_t.num5
   DEFINE l_gzaj003 LIKE gzaj_t.gzaj003
   DEFINE r_success LIKE type_t.num5
   
   
   LET r_success = TRUE
   
   SELECT gzai003,gzai004,gzai005,gzai006,gzai007,gzai008,gzai009,gzai010,
          gzai011,gzai012,gzai013,gzai014,gzai015,gzai016,gzai017,gzai018,
          gzai019,gzai020,gzai021,gzai022 
     INTO l_gzai003,l_gzai004,l_gzai005,l_gzai006,l_gzai007,l_gzai008,l_gzai009,l_gzai010,
          l_gzai011,l_gzai012,l_gzai013,l_gzai014,l_gzai015,l_gzai016,l_gzai017,l_gzai018,
          l_gzai019,l_gzai020,l_gzai021,l_gzai022
     FROM gzai_t
    WHERE gzai001 = p_gzaa001
      AND gzai002 = g_lang
   IF NOT cl_null(l_gzai003) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '1'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF 
   IF NOT cl_null(l_gzai004) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '2'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF   
   IF NOT cl_null(l_gzai005) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '3'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai006) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '4'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai007) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '5'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai008) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '6'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai009) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '7'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai010) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '8'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai011) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '9'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai012) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '10'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai013) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '11'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai014) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '12'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai015) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '13'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai016) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '14'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai017) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '15'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai018) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '16'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai019) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '17'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai020) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '18'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai021) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '19'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF
   IF NOT cl_null(l_gzai022) THEN 
      LET l_count = 0 
      SELECT gzaj003 INTO l_gzaj003 FROM gzaj_t
       WHERE gzaj001 = p_gzaa001 AND gzaj002 = '20'
      IF l_gzaj003 = 'N' THEN
         LET r_success = FALSE
      END IF 
   END IF   
   
   
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 動態產生 q_azzi650.4gl
# Memo...........:
# Usage..........: CALL azzi650_gen_q_azzi650()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/01/15 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi650_gen_q_azzi650()
   
   RUN "$FGLRUN $AZZ/42r/azzp071 2"
   #要切開q_total 把要產生q_total 的開窗id 另外 產生到 q_azzi650.4gl 獨立使用，避免q_total 過大。
   
END FUNCTION

################################################################################
# Descriptions...: 系統分類碼檢核
# Memo...........:
# Usage..........: CALL azzi650_acc_chk(p_gzaj005,p_gzaj006)
#                  RETURNING r_success
# Input parameter: p_gzaj005   資料來源
#                : p_gzaj006   系統分類碼
# Return code....: r_success   檢核結果
# Date & Author..: 150415 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi650_acc_chk(p_gzaj005,p_gzaj006)
DEFINE p_gzaj005    LIKE gzaj_t.gzaj005
DEFINE p_gzaj006    LIKE gzaj_t.gzaj006
DEFINE r_success    LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_str        STRING

   LET r_success = TRUE

   IF p_gzaj005 = '1' THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM gzca_t
       WHERE gzca001 = p_gzaj006
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         CALL s_azzi902_get_gzzd('azzi600',"lbl_gzca001") RETURNING l_str,l_str
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00023"
         LET g_errparam.extend = l_str," = ",p_gzaj006
         LET g_errparam.replace[1] = p_gzaj006
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF NOT ap_chk_isExist(p_gzaj006,"SELECT COUNT(*) FROM gzca_t WHERE gzcastus = 'Y' "
#          ||" AND gzca001 = ? ","azz-00024",0 ) THEN    #160318-00005#55  mark
          ||" AND gzca001 = ? ","sub-01302",'azzi600') THEN     #160318-00005#55  add
         LET r_success = FALSE
      END IF
   END IF
   IF p_gzaj005 = '4' THEN
      IF NOT ap_chk_isExist(p_gzaj006,"SELECT COUNT(*) FROM gzaa_t WHERE  "
         ||" gzaa001 = ? ","azz-00057",0 ) THEN
         LET r_success = FALSE
      END IF
      IF NOT ap_chk_isExist(p_gzaj006,"SELECT COUNT(*) FROM gzaa_t WHERE gzaastus = 'Y' "
#          ||" AND gzaa001 = ? ","azz-00058",0 ) THEN           #160318-00005#55  mark
          ||" AND gzaa001 = ? ","sub-01302",'azzi650' ) THEN    #160318-00005#55  add
         LET r_success = FALSE
      END IF
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 
