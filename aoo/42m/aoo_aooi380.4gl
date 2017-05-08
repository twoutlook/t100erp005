#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi380.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2016-05-27 14:35:12), PR版次:0015(2016-10-24 16:51:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000330
#+ Filename...: aooi380
#+ Description: 控制組維護作業
#+ Creator....: 02298(2013-08-09 14:25:13)
#+ Modifier...: 02295 -SD/PR- 01534
 
{</section>}
 
{<section id="aooi380.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160225-00006#1   2016/03/02 By xianghui 人员编号检查管控调整
#160318-00005#31  2016/03/24 By 07900    重复错误信息修改
#160318-00025#30  2016/04/08 by 07959   將重複內容的錯誤訊息置換為公用錯誤訊息
#160503-00029#1   2016/05/27 By 02295  库位说明没有带出
#160913-00055#3   2016/09/18 By lixiang  供应商栏位开窗调整为q_pmaa001，去掉手动加的限定条件
#                                        客户栏位开窗调整为q_pmaa001_13
#160731-00647#1   2016/10/09 By wuxja    产品编号开窗有误，调整为q_imaa001_10
#161019-00017#1   2016/10/20 By lixh     组织类型调整 q_ooef001 => q_ooef001_1
#161019-00017#9   2016/10/19 By zhujing  据点组织开窗资料整批调整 q_ooef001_14-->q_ooef001_1
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
PRIVATE type type_g_ooha_m        RECORD
       ooha002 LIKE ooha_t.ooha002, 
   ooha001 LIKE ooha_t.ooha001, 
   oohal003 LIKE oohal_t.oohal003, 
   oohal005 LIKE oohal_t.oohal005, 
   oohastus LIKE ooha_t.oohastus, 
   oohaownid LIKE ooha_t.oohaownid, 
   oohaownid_desc LIKE type_t.chr80, 
   oohaowndp LIKE ooha_t.oohaowndp, 
   oohaowndp_desc LIKE type_t.chr80, 
   oohacrtid LIKE ooha_t.oohacrtid, 
   oohacrtid_desc LIKE type_t.chr80, 
   oohacrtdp LIKE ooha_t.oohacrtdp, 
   oohacrtdp_desc LIKE type_t.chr80, 
   oohacrtdt LIKE ooha_t.oohacrtdt, 
   oohamodid LIKE ooha_t.oohamodid, 
   oohamodid_desc LIKE type_t.chr80, 
   oohamoddt LIKE ooha_t.oohamoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_oohb_d        RECORD
       oohb002 LIKE oohb_t.oohb002, 
   oohb002_desc LIKE type_t.chr500, 
   oohb003 LIKE oohb_t.oohb003, 
   oohb004 LIKE oohb_t.oohb004
       END RECORD
PRIVATE TYPE type_g_oohb10_d RECORD
       oohk002 LIKE oohk_t.oohk002, 
   oohk002_desc LIKE type_t.chr500, 
   oohk003 LIKE oohk_t.oohk003, 
   oohk004 LIKE oohk_t.oohk004
       END RECORD
PRIVATE TYPE type_g_oohb11_d RECORD
       oohl002 LIKE oohl_t.oohl002, 
   oohl002_desc LIKE type_t.chr500, 
   oohl003 LIKE oohl_t.oohl003, 
   oohl003_desc LIKE type_t.chr500, 
   oohl004 LIKE oohl_t.oohl004, 
   oohl005 LIKE oohl_t.oohl005
       END RECORD
PRIVATE TYPE type_g_oohb2_d RECORD
       oohc002 LIKE oohc_t.oohc002, 
   oohc002_desc LIKE type_t.chr500, 
   oohc002_desc2 LIKE type_t.chr500, 
   oohc003 LIKE oohc_t.oohc003, 
   oohc004 LIKE oohc_t.oohc004
       END RECORD
PRIVATE TYPE type_g_oohb3_d RECORD
       oohd002 LIKE oohd_t.oohd002, 
   oohd002_desc LIKE type_t.chr500, 
   oohd003 LIKE oohd_t.oohd003, 
   oohd004 LIKE oohd_t.oohd004
       END RECORD
PRIVATE TYPE type_g_oohb4_d RECORD
       oohe002 LIKE oohe_t.oohe002, 
   oohe002_desc LIKE type_t.chr500, 
   oohe003 LIKE oohe_t.oohe003, 
   oohe004 LIKE oohe_t.oohe004
       END RECORD
PRIVATE TYPE type_g_oohb5_d RECORD
       oohf002 LIKE oohf_t.oohf002, 
   oohf002_desc LIKE type_t.chr500, 
   oohf003 LIKE oohf_t.oohf003, 
   oohf004 LIKE oohf_t.oohf004
       END RECORD
PRIVATE TYPE type_g_oohb6_d RECORD
       oohg002 LIKE oohg_t.oohg002, 
   oohg002_desc LIKE type_t.chr500, 
   oohg003 LIKE oohg_t.oohg003, 
   oohg004 LIKE oohg_t.oohg004
       END RECORD
PRIVATE TYPE type_g_oohb7_d RECORD
       oohh002 LIKE oohh_t.oohh002, 
   oohh002_desc LIKE type_t.chr500, 
   oohh003 LIKE oohh_t.oohh003, 
   oohh004 LIKE oohh_t.oohh004
       END RECORD
PRIVATE TYPE type_g_oohb8_d RECORD
       oohi002 LIKE oohi_t.oohi002, 
   oohi002_desc LIKE type_t.chr500, 
   oohi002_desc2 LIKE type_t.chr500, 
   oohi003 LIKE oohi_t.oohi003, 
   oohi004 LIKE oohi_t.oohi004
       END RECORD
PRIVATE TYPE type_g_oohb9_d RECORD
       oohj002 LIKE oohj_t.oohj002, 
   oohj002_desc LIKE type_t.chr500, 
   oohj003 LIKE oohj_t.oohj003, 
   oohj004 LIKE oohj_t.oohj004
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_ooha002 LIKE ooha_t.ooha002,
      b_ooha001 LIKE ooha_t.ooha001,
   b_ooha001_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooha002_p       LIKE ooha_t.ooha002
#end add-point
       
#模組變數(Module Variables)
DEFINE g_ooha_m          type_g_ooha_m
DEFINE g_ooha_m_t        type_g_ooha_m
DEFINE g_ooha_m_o        type_g_ooha_m
DEFINE g_ooha_m_mask_o   type_g_ooha_m #轉換遮罩前資料
DEFINE g_ooha_m_mask_n   type_g_ooha_m #轉換遮罩後資料
 
   DEFINE g_ooha001_t LIKE ooha_t.ooha001
 
 
DEFINE g_oohb_d          DYNAMIC ARRAY OF type_g_oohb_d
DEFINE g_oohb_d_t        type_g_oohb_d
DEFINE g_oohb_d_o        type_g_oohb_d
DEFINE g_oohb_d_mask_o   DYNAMIC ARRAY OF type_g_oohb_d #轉換遮罩前資料
DEFINE g_oohb_d_mask_n   DYNAMIC ARRAY OF type_g_oohb_d #轉換遮罩後資料
DEFINE g_oohb10_d          DYNAMIC ARRAY OF type_g_oohb10_d
DEFINE g_oohb10_d_t        type_g_oohb10_d
DEFINE g_oohb10_d_o        type_g_oohb10_d
DEFINE g_oohb10_d_mask_o   DYNAMIC ARRAY OF type_g_oohb10_d #轉換遮罩前資料
DEFINE g_oohb10_d_mask_n   DYNAMIC ARRAY OF type_g_oohb10_d #轉換遮罩後資料
DEFINE g_oohb11_d          DYNAMIC ARRAY OF type_g_oohb11_d
DEFINE g_oohb11_d_t        type_g_oohb11_d
DEFINE g_oohb11_d_o        type_g_oohb11_d
DEFINE g_oohb11_d_mask_o   DYNAMIC ARRAY OF type_g_oohb11_d #轉換遮罩前資料
DEFINE g_oohb11_d_mask_n   DYNAMIC ARRAY OF type_g_oohb11_d #轉換遮罩後資料
DEFINE g_oohb2_d          DYNAMIC ARRAY OF type_g_oohb2_d
DEFINE g_oohb2_d_t        type_g_oohb2_d
DEFINE g_oohb2_d_o        type_g_oohb2_d
DEFINE g_oohb2_d_mask_o   DYNAMIC ARRAY OF type_g_oohb2_d #轉換遮罩前資料
DEFINE g_oohb2_d_mask_n   DYNAMIC ARRAY OF type_g_oohb2_d #轉換遮罩後資料
DEFINE g_oohb3_d          DYNAMIC ARRAY OF type_g_oohb3_d
DEFINE g_oohb3_d_t        type_g_oohb3_d
DEFINE g_oohb3_d_o        type_g_oohb3_d
DEFINE g_oohb3_d_mask_o   DYNAMIC ARRAY OF type_g_oohb3_d #轉換遮罩前資料
DEFINE g_oohb3_d_mask_n   DYNAMIC ARRAY OF type_g_oohb3_d #轉換遮罩後資料
DEFINE g_oohb4_d          DYNAMIC ARRAY OF type_g_oohb4_d
DEFINE g_oohb4_d_t        type_g_oohb4_d
DEFINE g_oohb4_d_o        type_g_oohb4_d
DEFINE g_oohb4_d_mask_o   DYNAMIC ARRAY OF type_g_oohb4_d #轉換遮罩前資料
DEFINE g_oohb4_d_mask_n   DYNAMIC ARRAY OF type_g_oohb4_d #轉換遮罩後資料
DEFINE g_oohb5_d          DYNAMIC ARRAY OF type_g_oohb5_d
DEFINE g_oohb5_d_t        type_g_oohb5_d
DEFINE g_oohb5_d_o        type_g_oohb5_d
DEFINE g_oohb5_d_mask_o   DYNAMIC ARRAY OF type_g_oohb5_d #轉換遮罩前資料
DEFINE g_oohb5_d_mask_n   DYNAMIC ARRAY OF type_g_oohb5_d #轉換遮罩後資料
DEFINE g_oohb6_d          DYNAMIC ARRAY OF type_g_oohb6_d
DEFINE g_oohb6_d_t        type_g_oohb6_d
DEFINE g_oohb6_d_o        type_g_oohb6_d
DEFINE g_oohb6_d_mask_o   DYNAMIC ARRAY OF type_g_oohb6_d #轉換遮罩前資料
DEFINE g_oohb6_d_mask_n   DYNAMIC ARRAY OF type_g_oohb6_d #轉換遮罩後資料
DEFINE g_oohb7_d          DYNAMIC ARRAY OF type_g_oohb7_d
DEFINE g_oohb7_d_t        type_g_oohb7_d
DEFINE g_oohb7_d_o        type_g_oohb7_d
DEFINE g_oohb7_d_mask_o   DYNAMIC ARRAY OF type_g_oohb7_d #轉換遮罩前資料
DEFINE g_oohb7_d_mask_n   DYNAMIC ARRAY OF type_g_oohb7_d #轉換遮罩後資料
DEFINE g_oohb8_d          DYNAMIC ARRAY OF type_g_oohb8_d
DEFINE g_oohb8_d_t        type_g_oohb8_d
DEFINE g_oohb8_d_o        type_g_oohb8_d
DEFINE g_oohb8_d_mask_o   DYNAMIC ARRAY OF type_g_oohb8_d #轉換遮罩前資料
DEFINE g_oohb8_d_mask_n   DYNAMIC ARRAY OF type_g_oohb8_d #轉換遮罩後資料
DEFINE g_oohb9_d          DYNAMIC ARRAY OF type_g_oohb9_d
DEFINE g_oohb9_d_t        type_g_oohb9_d
DEFINE g_oohb9_d_o        type_g_oohb9_d
DEFINE g_oohb9_d_mask_o   DYNAMIC ARRAY OF type_g_oohb9_d #轉換遮罩前資料
DEFINE g_oohb9_d_mask_n   DYNAMIC ARRAY OF type_g_oohb9_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      oohal001 LIKE oohal_t.oohal001,
      oohal003 LIKE oohal_t.oohal003,
      oohal005 LIKE oohal_t.oohal005
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
DEFINE g_wc2_table5   STRING
 
DEFINE g_wc2_table6   STRING
 
DEFINE g_wc2_table7   STRING
 
DEFINE g_wc2_table8   STRING
 
DEFINE g_wc2_table9   STRING
 
DEFINE g_wc2_table10   STRING
 
DEFINE g_wc2_table11   STRING
 
 
 
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
 
{<section id="aooi380.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
   LET g_ooha002_p = ''
   LET g_ooha002_p = g_argv[1]
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT ooha002,ooha001,'','',oohastus,oohaownid,'',oohaowndp,'',oohacrtid,'', 
       oohacrtdp,'',oohacrtdt,oohamodid,'',oohamoddt", 
                      " FROM ooha_t",
                      " WHERE oohaent= ? AND ooha001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.ooha002,t0.ooha001,t0.oohastus,t0.oohaownid,t0.oohaowndp,t0.oohacrtid, 
       t0.oohacrtdp,t0.oohacrtdt,t0.oohamodid,t0.oohamoddt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011",
               " FROM ooha_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.oohaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.oohaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.oohacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.oohacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.oohamodid  ",
 
               " WHERE t0.oohaent = " ||g_enterprise|| " AND t0.ooha001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aooi380_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi380 WITH FORM cl_ap_formpath("aoo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aooi380_init()   
 
      #進入選單 Menu (="N")
      CALL aooi380_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aooi380
      
   END IF 
   
   CLOSE aooi380_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aooi380.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aooi380_init()
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
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
   LET g_detail_idx_list[7] = 1
   LET g_detail_idx_list[8] = 1
   LET g_detail_idx_list[9] = 1
   LET g_detail_idx_list[10] = 1
   LET g_detail_idx_list[11] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('oohastus','17','N,Y')
 
      CALL cl_set_combo_scc('ooha002','26') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("'5',","1")
   CALL g_idx_group.addAttribute("'6',","1")
   CALL g_idx_group.addAttribute("'7',","1")
   CALL g_idx_group.addAttribute("'8',","1")
   CALL g_idx_group.addAttribute("'9',","1")
   CALL g_idx_group.addAttribute("'10',","1")
   CALL g_idx_group.addAttribute("'11',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #當執行aooi380時，傳入參數=null
   #當執行aooi381時，傳入參數=1
   #當執行aooi382時，傳入參數=2
   #當執行aooi383時，傳入參數=3
   #當執行aooi384時，傳入參數=4
   #當執行aooi385時，傳入參數=5
   #當執行aooi389時，傳入參數=0
   #当执行aooi380时，ooha002栏位开启，否则关闭 
   IF NOT cl_null(g_ooha002_p) THEN
      CALL cl_set_comp_entry('ooha002',FALSE)   
   END IF 
   #查询方案页签下拉框
   CALL cl_set_combo_scc('b_ooha002','26')
   #依据不同的参数对page进行显示和隐藏
   CALL aooi380_ooha002(g_ooha002_p)
   #end add-point
   
   #初始化搜尋條件
   CALL aooi380_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aooi380.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aooi380_ui_dialog()
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
            CALL aooi380_insert()
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
         INITIALIZE g_ooha_m.* TO NULL
         CALL g_oohb_d.clear()
         CALL g_oohb10_d.clear()
         CALL g_oohb11_d.clear()
         CALL g_oohb2_d.clear()
         CALL g_oohb3_d.clear()
         CALL g_oohb4_d.clear()
         CALL g_oohb5_d.clear()
         CALL g_oohb6_d.clear()
         CALL g_oohb7_d.clear()
         CALL g_oohb8_d.clear()
         CALL g_oohb9_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aooi380_init()
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
               
               CALL aooi380_fetch('') # reload data
               LET l_ac = 1
               CALL aooi380_ui_detailshow() #Setting the current row 
         
               CALL aooi380_idx_chk()
               #NEXT FIELD oohb002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_oohb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
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
               CALL aooi380_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_oohb10_d TO s_detail10.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail10")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body10.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail10")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body10.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body10.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb11_d TO s_detail11.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail11")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body11.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail11")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body11.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body11.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 4
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body2.action"
      
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("'5',",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 5
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body3.action"
    
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[6] = l_ac
               CALL g_idx_group.addAttribute("'6',",l_ac)
               
               #add-point:page6, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 6
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page6自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_6)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page6_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_axmm200
                  LET g_action_choice="prog_axmm200"
                  IF cl_auth_chk_act("prog_axmm200") THEN
                     
                     #add-point:ON ACTION prog_axmm200 name="menu.detail_show.page6_sub.prog_axmm200"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'axmm200'
               LET la_param.param[1] = g_oohb4_d[l_ac].oohe002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page6.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page6自定義行為 name="ui_dialog.body4.action"
           
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[7] = l_ac
               CALL g_idx_group.addAttribute("'7',",l_ac)
               
               #add-point:page7, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'7',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 7
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page7自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_7)
            
         
            #add-point:page7自定義行為 name="ui_dialog.body5.action"
           
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[8] = l_ac
               CALL g_idx_group.addAttribute("'8',",l_ac)
               
               #add-point:page8, before row動作 name="ui_dialog.body6.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'8',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 8
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page8自定義行為 name="ui_dialog.body6.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_8)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page8_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apmm200
                  LET g_action_choice="prog_apmm200"
                  IF cl_auth_chk_act("prog_apmm200") THEN
                     
                     #add-point:ON ACTION prog_apmm200 name="menu.detail_show.page8_sub.prog_apmm200"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmm200'
               LET la_param.param[1] = g_oohb6_d[l_ac].oohg002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page8.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page8自定義行為 name="ui_dialog.body6.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb7_d TO s_detail7.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[9] = l_ac
               CALL g_idx_group.addAttribute("'9',",l_ac)
               
               #add-point:page9, before row動作 name="ui_dialog.body7.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'9',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               LET g_current_page = 9
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page9自定義行為 name="ui_dialog.body7.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_9)
            
         
            #add-point:page9自定義行為 name="ui_dialog.body7.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb8_d TO s_detail8.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail8")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[10] = l_ac
               CALL g_idx_group.addAttribute("'10',",l_ac)
               
               #add-point:page10, before row動作 name="ui_dialog.body8.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'10',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail8")
               LET g_current_page = 10
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page10自定義行為 name="ui_dialog.body8.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_10)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page10_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aimm200
                  LET g_action_choice="prog_aimm200"
                  IF cl_auth_chk_act("prog_aimm200") THEN
                     
                     #add-point:ON ACTION prog_aimm200 name="menu.detail_show.page10_sub.prog_aimm200"
               #+ 此段落由子樣板a41產生
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aimm200'
               LET la_param.param[1] = g_oohb8_d[l_ac].oohi002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page10.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page10自定義行為 name="ui_dialog.body8.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_oohb9_d TO s_detail9.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aooi380_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail9")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[11] = l_ac
               CALL g_idx_group.addAttribute("'11',",l_ac)
               
               #add-point:page11, before row動作 name="ui_dialog.body9.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'11',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail9")
               LET g_current_page = 11
               #顯示單身筆數
               CALL aooi380_idx_chk()
               #add-point:page11自定義行為 name="ui_dialog.body9.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_11)
            
         
            #add-point:page11自定義行為 name="ui_dialog.body9.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aooi380_browser_fill("")
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
               CALL aooi380_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aooi380_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aooi380_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aooi380_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aooi380_set_act_visible()   
            CALL aooi380_set_act_no_visible()
            IF NOT (g_ooha_m.ooha001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " oohaent = " ||g_enterprise|| " AND",
                                  " ooha001 = '", g_ooha_m.ooha001, "' "
 
               #填到對應位置
               CALL aooi380_browser_fill("")
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
 
               INITIALIZE g_wc2_table5 TO NULL
 
               INITIALIZE g_wc2_table6 TO NULL
 
               INITIALIZE g_wc2_table7 TO NULL
 
               INITIALIZE g_wc2_table8 TO NULL
 
               INITIALIZE g_wc2_table9 TO NULL
 
               INITIALIZE g_wc2_table10 TO NULL
 
               INITIALIZE g_wc2_table11 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "ooha_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "oohb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "oohk_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohl_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohc_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohd_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohe_t" 
                        LET g_wc2_table6 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohf_t" 
                        LET g_wc2_table7 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohg_t" 
                        LET g_wc2_table8 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohh_t" 
                        LET g_wc2_table9 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohi_t" 
                        LET g_wc2_table10 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohj_t" 
                        LET g_wc2_table11 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
                  OR NOT cl_null(g_wc2_table6)
 
                  OR NOT cl_null(g_wc2_table7)
 
                  OR NOT cl_null(g_wc2_table8)
 
                  OR NOT cl_null(g_wc2_table9)
 
                  OR NOT cl_null(g_wc2_table10)
 
                  OR NOT cl_null(g_wc2_table11)
 
 
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
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
                  IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
                  END IF
 
                  IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
                  END IF
 
                  IF g_wc2_table8 <> " 1=1" AND NOT cl_null(g_wc2_table8) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table8
                  END IF
 
                  IF g_wc2_table9 <> " 1=1" AND NOT cl_null(g_wc2_table9) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table9
                  END IF
 
                  IF g_wc2_table10 <> " 1=1" AND NOT cl_null(g_wc2_table10) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table10
                  END IF
 
                  IF g_wc2_table11 <> " 1=1" AND NOT cl_null(g_wc2_table11) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table11
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aooi380_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
               INITIALIZE g_wc2_table5 TO NULL
 
               INITIALIZE g_wc2_table6 TO NULL
 
               INITIALIZE g_wc2_table7 TO NULL
 
               INITIALIZE g_wc2_table8 TO NULL
 
               INITIALIZE g_wc2_table9 TO NULL
 
               INITIALIZE g_wc2_table10 TO NULL
 
               INITIALIZE g_wc2_table11 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "ooha_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "oohb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "oohk_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohl_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohc_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohd_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohe_t" 
                        LET g_wc2_table6 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohf_t" 
                        LET g_wc2_table7 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohg_t" 
                        LET g_wc2_table8 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohh_t" 
                        LET g_wc2_table9 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohi_t" 
                        LET g_wc2_table10 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "oohj_t" 
                        LET g_wc2_table11 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
                  OR NOT cl_null(g_wc2_table6)
 
                  OR NOT cl_null(g_wc2_table7)
 
                  OR NOT cl_null(g_wc2_table8)
 
                  OR NOT cl_null(g_wc2_table9)
 
                  OR NOT cl_null(g_wc2_table10)
 
                  OR NOT cl_null(g_wc2_table11)
 
 
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
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
                  IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
                  END IF
 
                  IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
                  END IF
 
                  IF g_wc2_table8 <> " 1=1" AND NOT cl_null(g_wc2_table8) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table8
                  END IF
 
                  IF g_wc2_table9 <> " 1=1" AND NOT cl_null(g_wc2_table9) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table9
                  END IF
 
                  IF g_wc2_table10 <> " 1=1" AND NOT cl_null(g_wc2_table10) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table10
                  END IF
 
                  IF g_wc2_table11 <> " 1=1" AND NOT cl_null(g_wc2_table11) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table11
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aooi380_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aooi380_fetch("F")
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
               CALL aooi380_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aooi380_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi380_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aooi380_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi380_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aooi380_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi380_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aooi380_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi380_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aooi380_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi380_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_oohb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_oohb10_d)
                  LET g_export_id[2]   = "s_detail10"
                  LET g_export_node[3] = base.typeInfo.create(g_oohb11_d)
                  LET g_export_id[3]   = "s_detail11"
                  LET g_export_node[4] = base.typeInfo.create(g_oohb2_d)
                  LET g_export_id[4]   = "s_detail2"
                  LET g_export_node[5] = base.typeInfo.create(g_oohb3_d)
                  LET g_export_id[5]   = "s_detail3"
                  LET g_export_node[6] = base.typeInfo.create(g_oohb4_d)
                  LET g_export_id[6]   = "s_detail4"
                  LET g_export_node[7] = base.typeInfo.create(g_oohb5_d)
                  LET g_export_id[7]   = "s_detail5"
                  LET g_export_node[8] = base.typeInfo.create(g_oohb6_d)
                  LET g_export_id[8]   = "s_detail6"
                  LET g_export_node[9] = base.typeInfo.create(g_oohb7_d)
                  LET g_export_id[9]   = "s_detail7"
                  LET g_export_node[10] = base.typeInfo.create(g_oohb8_d)
                  LET g_export_id[10]   = "s_detail8"
                  LET g_export_node[11] = base.typeInfo.create(g_oohb9_d)
                  LET g_export_id[11]   = "s_detail9"
 
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
               NEXT FIELD oohb002
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
               CALL aooi380_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aooi380_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aooi380_delete()
               #add-point:ON ACTION delete name="menu.delete"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi380_insert()
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
               CALL aooi380_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi380_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail10",1)
               CALL g_curr_diag.setCurrentRow("s_detail11",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
               CALL g_curr_diag.setCurrentRow("s_detail6",1)
               CALL g_curr_diag.setCurrentRow("s_detail7",1)
               CALL g_curr_diag.setCurrentRow("s_detail8",1)
               CALL g_curr_diag.setCurrentRow("s_detail9",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aooi380_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aooi380_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aooi380_set_pk_array()
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
 
{<section id="aooi380.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aooi380_browser_fill(ps_page_action)
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
   IF NOT cl_null(g_ooha002_p) THEN 
      LET l_wc = l_wc," AND ooha002 = '",g_ooha002_p,"'"
   END IF 
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT ooha001 ",
                      " FROM ooha_t ",
                      " ",
                      " LEFT JOIN oohb_t ON oohbent = oohaent AND ooha001 = oohb001 ", "  ",
                      #add-point:browser_fill段sql(oohb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN oohk_t ON oohkent = oohaent AND ooha001 = oohk001", "  ",
                      #add-point:browser_fill段sql(oohk_t1) name="browser_fill.cnt.join.oohk_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohl_t ON oohlent = oohaent AND ooha001 = oohl001", "  ",
                      #add-point:browser_fill段sql(oohl_t1) name="browser_fill.cnt.join.oohl_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohc_t ON oohcent = oohaent AND ooha001 = oohc001", "  ",
                      #add-point:browser_fill段sql(oohc_t1) name="browser_fill.cnt.join.oohc_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohd_t ON oohdent = oohaent AND ooha001 = oohd001", "  ",
                      #add-point:browser_fill段sql(oohd_t1) name="browser_fill.cnt.join.oohd_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohe_t ON ooheent = oohaent AND ooha001 = oohe001", "  ",
                      #add-point:browser_fill段sql(oohe_t1) name="browser_fill.cnt.join.oohe_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohf_t ON oohfent = oohaent AND ooha001 = oohf001", "  ",
                      #add-point:browser_fill段sql(oohf_t1) name="browser_fill.cnt.join.oohf_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohg_t ON oohgent = oohaent AND ooha001 = oohg001", "  ",
                      #add-point:browser_fill段sql(oohg_t1) name="browser_fill.cnt.join.oohg_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohh_t ON oohhent = oohaent AND ooha001 = oohh001", "  ",
                      #add-point:browser_fill段sql(oohh_t1) name="browser_fill.cnt.join.oohh_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohi_t ON oohient = oohaent AND ooha001 = oohi001", "  ",
                      #add-point:browser_fill段sql(oohi_t1) name="browser_fill.cnt.join.oohi_t1"
                      
                      #end add-point
 
                      " LEFT JOIN oohj_t ON oohjent = oohaent AND ooha001 = oohj001", "  ",
                      #add-point:browser_fill段sql(oohj_t1) name="browser_fill.cnt.join.oohj_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN oohal_t ON oohalent = "||g_enterprise||" AND ooha001 = oohal001 AND oohal002 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE oohaent = " ||g_enterprise|| " AND oohbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("ooha_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT ooha001 ",
                      " FROM ooha_t ", 
                      "  ",
                      "  LEFT JOIN oohal_t ON oohalent = "||g_enterprise||" AND ooha001 = oohal001 AND oohal002 = '",g_dlang,"' ",
                      " WHERE oohaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("ooha_t")
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
      INITIALIZE g_ooha_m.* TO NULL
      CALL g_oohb_d.clear()        
      CALL g_oohb10_d.clear() 
      CALL g_oohb11_d.clear() 
      CALL g_oohb2_d.clear() 
      CALL g_oohb3_d.clear() 
      CALL g_oohb4_d.clear() 
      CALL g_oohb5_d.clear() 
      CALL g_oohb6_d.clear() 
      CALL g_oohb7_d.clear() 
      CALL g_oohb8_d.clear() 
      CALL g_oohb9_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.ooha002,t0.ooha001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.oohastus,t0.ooha002,t0.ooha001,t1.oohal003 ",
                  " FROM ooha_t t0",
                  "  ",
                  "  LEFT JOIN oohb_t ON oohbent = oohaent AND ooha001 = oohb001 ", "  ", 
                  #add-point:browser_fill段sql(oohb_t1) name="browser_fill.join.oohb_t1"
                  
                  #end add-point
                  "  LEFT JOIN oohk_t ON oohkent = oohaent AND ooha001 = oohk001", "  ", 
                  #add-point:browser_fill段sql(oohk_t1) name="browser_fill.join.oohk_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohl_t ON oohlent = oohaent AND ooha001 = oohl001", "  ", 
                  #add-point:browser_fill段sql(oohl_t1) name="browser_fill.join.oohl_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohc_t ON oohcent = oohaent AND ooha001 = oohc001", "  ", 
                  #add-point:browser_fill段sql(oohc_t1) name="browser_fill.join.oohc_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohd_t ON oohdent = oohaent AND ooha001 = oohd001", "  ", 
                  #add-point:browser_fill段sql(oohd_t1) name="browser_fill.join.oohd_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohe_t ON ooheent = oohaent AND ooha001 = oohe001", "  ", 
                  #add-point:browser_fill段sql(oohe_t1) name="browser_fill.join.oohe_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohf_t ON oohfent = oohaent AND ooha001 = oohf001", "  ", 
                  #add-point:browser_fill段sql(oohf_t1) name="browser_fill.join.oohf_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohg_t ON oohgent = oohaent AND ooha001 = oohg001", "  ", 
                  #add-point:browser_fill段sql(oohg_t1) name="browser_fill.join.oohg_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohh_t ON oohhent = oohaent AND ooha001 = oohh001", "  ", 
                  #add-point:browser_fill段sql(oohh_t1) name="browser_fill.join.oohh_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohi_t ON oohient = oohaent AND ooha001 = oohi001", "  ", 
                  #add-point:browser_fill段sql(oohi_t1) name="browser_fill.join.oohi_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN oohj_t ON oohjent = oohaent AND ooha001 = oohj001", "  ", 
                  #add-point:browser_fill段sql(oohj_t1) name="browser_fill.join.oohj_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN oohal_t t1 ON t1.oohalent="||g_enterprise||" AND t1.oohal001=t0.ooha001 AND t1.oohal002='"||g_dlang||"' ",
 
                  " WHERE t0.oohaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("ooha_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.oohastus,t0.ooha002,t0.ooha001,t1.oohal003 ",
                  " FROM ooha_t t0",
                  "  ",
                                 " LEFT JOIN oohal_t t1 ON t1.oohalent="||g_enterprise||" AND t1.oohal001=t0.ooha001 AND t1.oohal002='"||g_dlang||"' ",
 
                  " WHERE t0.oohaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("ooha_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY ooha001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"ooha_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_ooha002,g_browser[g_cnt].b_ooha001, 
          g_browser[g_cnt].b_ooha001_desc
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
         CALL aooi380_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_ooha001) THEN
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
 
{<section id="aooi380.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aooi380_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_ooha_m.ooha001 = g_browser[g_current_idx].b_ooha001   
 
   EXECUTE aooi380_master_referesh USING g_ooha_m.ooha001 INTO g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdt, 
       g_ooha_m.oohamodid,g_ooha_m.oohamoddt,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid_desc, 
       g_ooha_m.oohacrtdp_desc,g_ooha_m.oohamodid_desc
   
   CALL aooi380_ooha_t_mask()
   CALL aooi380_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aooi380.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aooi380_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail10",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail11",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail6",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail7",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail8",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail9",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aooi380_ui_browser_refresh()
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
      IF g_browser[l_i].b_ooha001 = g_ooha_m.ooha001 
 
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
 
{<section id="aooi380.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aooi380_construct()
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
   INITIALIZE g_ooha_m.* TO NULL
   CALL g_oohb_d.clear()        
   CALL g_oohb10_d.clear() 
   CALL g_oohb11_d.clear() 
   CALL g_oohb2_d.clear() 
   CALL g_oohb3_d.clear() 
   CALL g_oohb4_d.clear() 
   CALL g_oohb5_d.clear() 
   CALL g_oohb6_d.clear() 
   CALL g_oohb7_d.clear() 
   CALL g_oohb8_d.clear() 
   CALL g_oohb9_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
   INITIALIZE g_wc2_table5 TO NULL
 
   INITIALIZE g_wc2_table6 TO NULL
 
   INITIALIZE g_wc2_table7 TO NULL
 
   INITIALIZE g_wc2_table8 TO NULL
 
   INITIALIZE g_wc2_table9 TO NULL
 
   INITIALIZE g_wc2_table10 TO NULL
 
   INITIALIZE g_wc2_table11 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON ooha002,ooha001,oohal003,oohal005,oohastus,oohaownid,oohaowndp,oohacrtid, 
          oohacrtdp,oohacrtdt,oohamodid,oohamoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            IF NOT cl_null(g_ooha002_p) THEN
               CALL cl_set_comp_entry("ooha002",FALSE)
               DISPLAY g_ooha002_p TO ooha002	
            END IF 
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<oohacrtdt>>----
         AFTER FIELD oohacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<oohamoddt>>----
         AFTER FIELD oohamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oohacnfdt>>----
         
         #----<<oohapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooha002
            #add-point:BEFORE FIELD ooha002 name="construct.b.ooha002"
            IF NOT cl_null(g_ooha002_p) THEN
               DISPLAY g_ooha002_p TO ooha002
               NEXT FIELD ooha001               
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooha002
            
            #add-point:AFTER FIELD ooha002 name="construct.a.ooha002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooha002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooha002
            #add-point:ON ACTION controlp INFIELD ooha002 name="construct.c.ooha002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ooha001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooha001
            #add-point:ON ACTION controlp INFIELD ooha001 name="construct.c.ooha001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_ooha002_p) THEN
               LET g_qryparam.where = "ooha002 = '",g_ooha002_p,"'"
            END IF 
            CALL q_ooha001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooha001  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD ooha001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooha001
            #add-point:BEFORE FIELD ooha001 name="construct.b.ooha001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooha001
            
            #add-point:AFTER FIELD ooha001 name="construct.a.ooha001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohal003
            #add-point:BEFORE FIELD oohal003 name="construct.b.oohal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohal003
            
            #add-point:AFTER FIELD oohal003 name="construct.a.oohal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oohal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohal003
            #add-point:ON ACTION controlp INFIELD oohal003 name="construct.c.oohal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohal005
            #add-point:BEFORE FIELD oohal005 name="construct.b.oohal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohal005
            
            #add-point:AFTER FIELD oohal005 name="construct.a.oohal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oohal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohal005
            #add-point:ON ACTION controlp INFIELD oohal005 name="construct.c.oohal005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohastus
            #add-point:BEFORE FIELD oohastus name="construct.b.oohastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohastus
            
            #add-point:AFTER FIELD oohastus name="construct.a.oohastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oohastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohastus
            #add-point:ON ACTION controlp INFIELD oohastus name="construct.c.oohastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.oohaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohaownid
            #add-point:ON ACTION controlp INFIELD oohaownid name="construct.c.oohaownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohaownid  #顯示到畫面上

            NEXT FIELD oohaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohaownid
            #add-point:BEFORE FIELD oohaownid name="construct.b.oohaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohaownid
            
            #add-point:AFTER FIELD oohaownid name="construct.a.oohaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oohaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohaowndp
            #add-point:ON ACTION controlp INFIELD oohaowndp name="construct.c.oohaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohaowndp  #顯示到畫面上

            NEXT FIELD oohaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohaowndp
            #add-point:BEFORE FIELD oohaowndp name="construct.b.oohaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohaowndp
            
            #add-point:AFTER FIELD oohaowndp name="construct.a.oohaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oohacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohacrtid
            #add-point:ON ACTION controlp INFIELD oohacrtid name="construct.c.oohacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohacrtid  #顯示到畫面上

            NEXT FIELD oohacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohacrtid
            #add-point:BEFORE FIELD oohacrtid name="construct.b.oohacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohacrtid
            
            #add-point:AFTER FIELD oohacrtid name="construct.a.oohacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oohacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohacrtdp
            #add-point:ON ACTION controlp INFIELD oohacrtdp name="construct.c.oohacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohacrtdp  #顯示到畫面上

            NEXT FIELD oohacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohacrtdp
            #add-point:BEFORE FIELD oohacrtdp name="construct.b.oohacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohacrtdp
            
            #add-point:AFTER FIELD oohacrtdp name="construct.a.oohacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohacrtdt
            #add-point:BEFORE FIELD oohacrtdt name="construct.b.oohacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.oohamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohamodid
            #add-point:ON ACTION controlp INFIELD oohamodid name="construct.c.oohamodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohamodid  #顯示到畫面上

            NEXT FIELD oohamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohamodid
            #add-point:BEFORE FIELD oohamodid name="construct.b.oohamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohamodid
            
            #add-point:AFTER FIELD oohamodid name="construct.a.oohamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohamoddt
            #add-point:BEFORE FIELD oohamoddt name="construct.b.oohamoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON oohb002,oohb003,oohb004
           FROM s_detail1[1].oohb002,s_detail1[1].oohb003,s_detail1[1].oohb004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.oohb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohb002
            #add-point:ON ACTION controlp INFIELD oohb002 name="construct.c.page1.oohb002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooea016 = 'Y'"  
            CALL q_ooea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohb002  #顯示到畫面上
            LET g_qryparam.where = ""  
            NEXT FIELD oohb002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohb002
            #add-point:BEFORE FIELD oohb002 name="construct.b.page1.oohb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohb002
            
            #add-point:AFTER FIELD oohb002 name="construct.a.page1.oohb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohb003
            #add-point:BEFORE FIELD oohb003 name="construct.b.page1.oohb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohb003
            
            #add-point:AFTER FIELD oohb003 name="construct.a.page1.oohb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oohb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohb003
            #add-point:ON ACTION controlp INFIELD oohb003 name="construct.c.page1.oohb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohb004
            #add-point:BEFORE FIELD oohb004 name="construct.b.page1.oohb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohb004
            
            #add-point:AFTER FIELD oohb004 name="construct.a.page1.oohb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.oohb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohb004
            #add-point:ON ACTION controlp INFIELD oohb004 name="construct.c.page1.oohb004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON oohk002,oohk003,oohk004
           FROM s_detail10[1].oohk002,s_detail10[1].oohk003,s_detail10[1].oohk004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page10.oohk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohk002
            #add-point:ON ACTION controlp INFIELD oohk002 name="construct.c.page10.oohk002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                 #161019-00017#1
            CALL q_ooef001_1()               #161019-00017#1
            DISPLAY g_qryparam.return1 TO oohk002  #顯示到畫面上

            NEXT FIELD oohk002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohk002
            #add-point:BEFORE FIELD oohk002 name="construct.b.page10.oohk002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohk002
            
            #add-point:AFTER FIELD oohk002 name="construct.a.page10.oohk002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohk003
            #add-point:BEFORE FIELD oohk003 name="construct.b.page10.oohk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohk003
            
            #add-point:AFTER FIELD oohk003 name="construct.a.page10.oohk003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page10.oohk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohk003
            #add-point:ON ACTION controlp INFIELD oohk003 name="construct.c.page10.oohk003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohk004
            #add-point:BEFORE FIELD oohk004 name="construct.b.page10.oohk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohk004
            
            #add-point:AFTER FIELD oohk004 name="construct.a.page10.oohk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page10.oohk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohk004
            #add-point:ON ACTION controlp INFIELD oohk004 name="construct.c.page10.oohk004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON oohl002,oohl003,oohl004,oohl005
           FROM s_detail11[1].oohl002,s_detail11[1].oohl003,s_detail11[1].oohl004,s_detail11[1].oohl005 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page11.oohl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohl002
            #add-point:ON ACTION controlp INFIELD oohl002 name="construct.c.page11.oohl002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                 #161019-00017#1
            CALL q_ooef001_1()               #161019-00017#1
            DISPLAY g_qryparam.return1 TO oohl002  #顯示到畫面上

            NEXT FIELD oohl002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohl002
            #add-point:BEFORE FIELD oohl002 name="construct.b.page11.oohl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohl002
            
            #add-point:AFTER FIELD oohl002 name="construct.a.page11.oohl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page11.oohl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohl003
            #add-point:ON ACTION controlp INFIELD oohl003 name="construct.c.page11.oohl003"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = g_oohb11_d[l_ac].oohl002 
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohl003  #顯示到畫面上
            LET g_qryparam.where = ""  
            NEXT FIELD oohl003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohl003
            #add-point:BEFORE FIELD oohl003 name="construct.b.page11.oohl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohl003
            
            #add-point:AFTER FIELD oohl003 name="construct.a.page11.oohl003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohl004
            #add-point:BEFORE FIELD oohl004 name="construct.b.page11.oohl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohl004
            
            #add-point:AFTER FIELD oohl004 name="construct.a.page11.oohl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page11.oohl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohl004
            #add-point:ON ACTION controlp INFIELD oohl004 name="construct.c.page11.oohl004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohl005
            #add-point:BEFORE FIELD oohl005 name="construct.b.page11.oohl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohl005
            
            #add-point:AFTER FIELD oohl005 name="construct.a.page11.oohl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page11.oohl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohl005
            #add-point:ON ACTION controlp INFIELD oohl005 name="construct.c.page11.oohl005"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON oohc002,oohc002_desc2,oohc003,oohc004
           FROM s_detail2[1].oohc002,s_detail2[1].oohc002_desc2,s_detail2[1].oohc003,s_detail2[1].oohc004 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.oohc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc002
            #add-point:ON ACTION controlp INFIELD oohc002 name="construct.c.page2.oohc002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohc002  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD oohc002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc002
            #add-point:BEFORE FIELD oohc002 name="construct.b.page2.oohc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc002
            
            #add-point:AFTER FIELD oohc002 name="construct.a.page2.oohc002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc002_desc
            #add-point:BEFORE FIELD oohc002_desc name="construct.b.page2.oohc002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc002_desc
            
            #add-point:AFTER FIELD oohc002_desc name="construct.a.page2.oohc002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oohc002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc002_desc
            #add-point:ON ACTION controlp INFIELD oohc002_desc name="construct.c.page2.oohc002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc002_desc2
            #add-point:BEFORE FIELD oohc002_desc2 name="construct.b.page2.oohc002_desc2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc002_desc2
            
            #add-point:AFTER FIELD oohc002_desc2 name="construct.a.page2.oohc002_desc2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oohc002_desc2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc002_desc2
            #add-point:ON ACTION controlp INFIELD oohc002_desc2 name="construct.c.page2.oohc002_desc2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc003
            #add-point:BEFORE FIELD oohc003 name="construct.b.page2.oohc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc003
            
            #add-point:AFTER FIELD oohc003 name="construct.a.page2.oohc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oohc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc003
            #add-point:ON ACTION controlp INFIELD oohc003 name="construct.c.page2.oohc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc004
            #add-point:BEFORE FIELD oohc004 name="construct.b.page2.oohc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc004
            
            #add-point:AFTER FIELD oohc004 name="construct.a.page2.oohc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.oohc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc004
            #add-point:ON ACTION controlp INFIELD oohc004 name="construct.c.page2.oohc004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table5 ON oohd002,oohd003,oohd004
           FROM s_detail3[1].oohd002,s_detail3[1].oohd003,s_detail3[1].oohd004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body5.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 5)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page3.oohd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohd002
            #add-point:ON ACTION controlp INFIELD oohd002 name="construct.c.page3.oohd002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohd002  #顯示到畫面上

            NEXT FIELD oohd002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohd002
            #add-point:BEFORE FIELD oohd002 name="construct.b.page3.oohd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohd002
            
            #add-point:AFTER FIELD oohd002 name="construct.a.page3.oohd002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohd003
            #add-point:BEFORE FIELD oohd003 name="construct.b.page3.oohd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohd003
            
            #add-point:AFTER FIELD oohd003 name="construct.a.page3.oohd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.oohd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohd003
            #add-point:ON ACTION controlp INFIELD oohd003 name="construct.c.page3.oohd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohd004
            #add-point:BEFORE FIELD oohd004 name="construct.b.page3.oohd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohd004
            
            #add-point:AFTER FIELD oohd004 name="construct.a.page3.oohd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.oohd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohd004
            #add-point:ON ACTION controlp INFIELD oohd004 name="construct.c.page3.oohd004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table6 ON oohe002,oohe003,oohe004
           FROM s_detail4[1].oohe002,s_detail4[1].oohe003,s_detail4[1].oohe004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body6.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 6)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page4.oohe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohe002
            #add-point:ON ACTION controlp INFIELD oohe002 name="construct.c.page4.oohe002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " (pmaa002 = '2' OR pmaa002 = '3') "   #160913-00055#3
            #CALL q_pmaa001()                           #呼叫開窗  #160913-00055#3 
            CALL q_pmaa001_13()        #160913-00055#3
            DISPLAY g_qryparam.return1 TO oohe002  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD oohe002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohe002
            #add-point:BEFORE FIELD oohe002 name="construct.b.page4.oohe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohe002
            
            #add-point:AFTER FIELD oohe002 name="construct.a.page4.oohe002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohe003
            #add-point:BEFORE FIELD oohe003 name="construct.b.page4.oohe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohe003
            
            #add-point:AFTER FIELD oohe003 name="construct.a.page4.oohe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.oohe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohe003
            #add-point:ON ACTION controlp INFIELD oohe003 name="construct.c.page4.oohe003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohe004
            #add-point:BEFORE FIELD oohe004 name="construct.b.page4.oohe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohe004
            
            #add-point:AFTER FIELD oohe004 name="construct.a.page4.oohe004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.oohe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohe004
            #add-point:ON ACTION controlp INFIELD oohe004 name="construct.c.page4.oohe004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table7 ON oohf002,oohf003,oohf004
           FROM s_detail5[1].oohf002,s_detail5[1].oohf003,s_detail5[1].oohf004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body7.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 7)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page5.oohf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohf002
            #add-point:ON ACTION controlp INFIELD oohf002 name="construct.c.page5.oohf002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1 ="251"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohf002  #顯示到畫面上

            NEXT FIELD oohf002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohf002
            #add-point:BEFORE FIELD oohf002 name="construct.b.page5.oohf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohf002
            
            #add-point:AFTER FIELD oohf002 name="construct.a.page5.oohf002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohf003
            #add-point:BEFORE FIELD oohf003 name="construct.b.page5.oohf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohf003
            
            #add-point:AFTER FIELD oohf003 name="construct.a.page5.oohf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.oohf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohf003
            #add-point:ON ACTION controlp INFIELD oohf003 name="construct.c.page5.oohf003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohf004
            #add-point:BEFORE FIELD oohf004 name="construct.b.page5.oohf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohf004
            
            #add-point:AFTER FIELD oohf004 name="construct.a.page5.oohf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.oohf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohf004
            #add-point:ON ACTION controlp INFIELD oohf004 name="construct.c.page5.oohf004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table8 ON oohg002,oohg003,oohg004
           FROM s_detail6[1].oohg002,s_detail6[1].oohg003,s_detail6[1].oohg004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body8.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 8)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page6.oohg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohg002
            #add-point:ON ACTION controlp INFIELD oohg002 name="construct.c.page6.oohg002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "   #160913-00055#3
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohg002  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD oohg002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohg002
            #add-point:BEFORE FIELD oohg002 name="construct.b.page6.oohg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohg002
            
            #add-point:AFTER FIELD oohg002 name="construct.a.page6.oohg002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohg003
            #add-point:BEFORE FIELD oohg003 name="construct.b.page6.oohg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohg003
            
            #add-point:AFTER FIELD oohg003 name="construct.a.page6.oohg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.oohg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohg003
            #add-point:ON ACTION controlp INFIELD oohg003 name="construct.c.page6.oohg003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohg004
            #add-point:BEFORE FIELD oohg004 name="construct.b.page6.oohg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohg004
            
            #add-point:AFTER FIELD oohg004 name="construct.a.page6.oohg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.oohg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohg004
            #add-point:ON ACTION controlp INFIELD oohg004 name="construct.c.page6.oohg004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table9 ON oohh002,oohh003,oohh004
           FROM s_detail7[1].oohh002,s_detail7[1].oohh003,s_detail7[1].oohh004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body9.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 9)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page7.oohh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohh002
            #add-point:ON ACTION controlp INFIELD oohh002 name="construct.c.page7.oohh002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oohh002  #顯示到畫面上

            NEXT FIELD oohh002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohh002
            #add-point:BEFORE FIELD oohh002 name="construct.b.page7.oohh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohh002
            
            #add-point:AFTER FIELD oohh002 name="construct.a.page7.oohh002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohh003
            #add-point:BEFORE FIELD oohh003 name="construct.b.page7.oohh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohh003
            
            #add-point:AFTER FIELD oohh003 name="construct.a.page7.oohh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.oohh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohh003
            #add-point:ON ACTION controlp INFIELD oohh003 name="construct.c.page7.oohh003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohh004
            #add-point:BEFORE FIELD oohh004 name="construct.b.page7.oohh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohh004
            
            #add-point:AFTER FIELD oohh004 name="construct.a.page7.oohh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.oohh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohh004
            #add-point:ON ACTION controlp INFIELD oohh004 name="construct.c.page7.oohh004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table10 ON oohi002,oohi002_desc2,oohi003,oohi004
           FROM s_detail8[1].oohi002,s_detail8[1].oohi002_desc2,s_detail8[1].oohi003,s_detail8[1].oohi004 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body10.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 10)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page8.oohi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi002
            #add-point:ON ACTION controlp INFIELD oohi002 name="construct.c.page8.oohi002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
           #CALL q_imaa001_1()                           #呼叫開窗  #160731-00647#1 mark
            CALL q_imaa001_10()                                    #160731-00647#1 add 
            DISPLAY g_qryparam.return1 TO oohi002  #顯示到畫面上

            NEXT FIELD oohi002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi002
            #add-point:BEFORE FIELD oohi002 name="construct.b.page8.oohi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi002
            
            #add-point:AFTER FIELD oohi002 name="construct.a.page8.oohi002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi002_desc
            #add-point:BEFORE FIELD oohi002_desc name="construct.b.page8.oohi002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi002_desc
            
            #add-point:AFTER FIELD oohi002_desc name="construct.a.page8.oohi002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.oohi002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi002_desc
            #add-point:ON ACTION controlp INFIELD oohi002_desc name="construct.c.page8.oohi002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi002_desc2
            #add-point:BEFORE FIELD oohi002_desc2 name="construct.b.page8.oohi002_desc2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi002_desc2
            
            #add-point:AFTER FIELD oohi002_desc2 name="construct.a.page8.oohi002_desc2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.oohi002_desc2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi002_desc2
            #add-point:ON ACTION controlp INFIELD oohi002_desc2 name="construct.c.page8.oohi002_desc2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi003
            #add-point:BEFORE FIELD oohi003 name="construct.b.page8.oohi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi003
            
            #add-point:AFTER FIELD oohi003 name="construct.a.page8.oohi003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.oohi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi003
            #add-point:ON ACTION controlp INFIELD oohi003 name="construct.c.page8.oohi003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi004
            #add-point:BEFORE FIELD oohi004 name="construct.b.page8.oohi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi004
            
            #add-point:AFTER FIELD oohi004 name="construct.a.page8.oohi004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page8.oohi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi004
            #add-point:ON ACTION controlp INFIELD oohi004 name="construct.c.page8.oohi004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table11 ON oohj002,oohj003,oohj004
           FROM s_detail9[1].oohj002,s_detail9[1].oohj003,s_detail9[1].oohj004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body11.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 11)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page9.oohj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohj002
            #add-point:ON ACTION controlp INFIELD oohj002 name="construct.c.page9.oohj002"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001_14()                           #呼叫開窗   #161019-00017#9 marked
            CALL q_ooef001_1()                           #呼叫開窗   #161019-00017#9 add
            DISPLAY g_qryparam.return1 TO oohj002  #顯示到畫面上

            NEXT FIELD oohj002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohj002
            #add-point:BEFORE FIELD oohj002 name="construct.b.page9.oohj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohj002
            
            #add-point:AFTER FIELD oohj002 name="construct.a.page9.oohj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohj003
            #add-point:BEFORE FIELD oohj003 name="construct.b.page9.oohj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohj003
            
            #add-point:AFTER FIELD oohj003 name="construct.a.page9.oohj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page9.oohj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohj003
            #add-point:ON ACTION controlp INFIELD oohj003 name="construct.c.page9.oohj003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohj004
            #add-point:BEFORE FIELD oohj004 name="construct.b.page9.oohj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohj004
            
            #add-point:AFTER FIELD oohj004 name="construct.a.page9.oohj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page9.oohj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohj004
            #add-point:ON ACTION controlp INFIELD oohj004 name="construct.c.page9.oohj004"
            
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
 
            INITIALIZE g_wc2_table5 TO NULL
 
            INITIALIZE g_wc2_table6 TO NULL
 
            INITIALIZE g_wc2_table7 TO NULL
 
            INITIALIZE g_wc2_table8 TO NULL
 
            INITIALIZE g_wc2_table9 TO NULL
 
            INITIALIZE g_wc2_table10 TO NULL
 
            INITIALIZE g_wc2_table11 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "ooha_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "oohb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "oohk_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohl_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohc_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohd_t" 
                     LET g_wc2_table5 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohe_t" 
                     LET g_wc2_table6 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohf_t" 
                     LET g_wc2_table7 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohg_t" 
                     LET g_wc2_table8 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohh_t" 
                     LET g_wc2_table9 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohi_t" 
                     LET g_wc2_table10 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "oohj_t" 
                     LET g_wc2_table11 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
 
   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
   END IF
 
   IF g_wc2_table7 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
   END IF
 
   IF g_wc2_table8 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table8
   END IF
 
   IF g_wc2_table9 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table9
   END IF
 
   IF g_wc2_table10 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table10
   END IF
 
   IF g_wc2_table11 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table11
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aooi380_filter()
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
      CONSTRUCT g_wc_filter ON ooha002,ooha001
                          FROM s_browse[1].b_ooha002,s_browse[1].b_ooha001
 
         BEFORE CONSTRUCT
               DISPLAY aooi380_filter_parser('ooha002') TO s_browse[1].b_ooha002
            DISPLAY aooi380_filter_parser('ooha001') TO s_browse[1].b_ooha001
      
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
 
      CALL aooi380_filter_show('ooha002')
   CALL aooi380_filter_show('ooha001')
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aooi380_filter_parser(ps_field)
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
 
{<section id="aooi380.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aooi380_filter_show(ps_field)
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
   LET ls_condition = aooi380_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aooi380_query()
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
   CALL g_oohb_d.clear()
   CALL g_oohb10_d.clear()
   CALL g_oohb11_d.clear()
   CALL g_oohb2_d.clear()
   CALL g_oohb3_d.clear()
   CALL g_oohb4_d.clear()
   CALL g_oohb5_d.clear()
   CALL g_oohb6_d.clear()
   CALL g_oohb7_d.clear()
   CALL g_oohb8_d.clear()
   CALL g_oohb9_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aooi380_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aooi380_browser_fill("")
      CALL aooi380_fetch("")
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
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
   LET g_detail_idx_list[7] = 1
   LET g_detail_idx_list[8] = 1
   LET g_detail_idx_list[9] = 1
   LET g_detail_idx_list[10] = 1
   LET g_detail_idx_list[11] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aooi380_filter_show('ooha002')
   CALL aooi380_filter_show('ooha001')
   CALL aooi380_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aooi380_fetch("F") 
      #顯示單身筆數
      CALL aooi380_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aooi380_fetch(p_flag)
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
   
   LET g_ooha_m.ooha001 = g_browser[g_current_idx].b_ooha001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aooi380_master_referesh USING g_ooha_m.ooha001 INTO g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdt, 
       g_ooha_m.oohamodid,g_ooha_m.oohamoddt,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid_desc, 
       g_ooha_m.oohacrtdp_desc,g_ooha_m.oohamodid_desc
   
   #遮罩相關處理
   LET g_ooha_m_mask_o.* =  g_ooha_m.*
   CALL aooi380_ooha_t_mask()
   LET g_ooha_m_mask_n.* =  g_ooha_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aooi380_set_act_visible()   
   CALL aooi380_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_ooha_m_t.* = g_ooha_m.*
   LET g_ooha_m_o.* = g_ooha_m.*
   
   LET g_data_owner = g_ooha_m.oohaownid      
   LET g_data_dept  = g_ooha_m.oohaowndp
   
   #重新顯示   
   CALL aooi380_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.insert" >}
#+ 資料新增
PRIVATE FUNCTION aooi380_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_oohb_d.clear()   
   CALL g_oohb10_d.clear()  
   CALL g_oohb11_d.clear()  
   CALL g_oohb2_d.clear()  
   CALL g_oohb3_d.clear()  
   CALL g_oohb4_d.clear()  
   CALL g_oohb5_d.clear()  
   CALL g_oohb6_d.clear()  
   CALL g_oohb7_d.clear()  
   CALL g_oohb8_d.clear()  
   CALL g_oohb9_d.clear()  
 
 
   INITIALIZE g_ooha_m.* TO NULL             #DEFAULT 設定
   
   LET g_ooha001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooha_m.oohaownid = g_user
      LET g_ooha_m.oohaowndp = g_dept
      LET g_ooha_m.oohacrtid = g_user
      LET g_ooha_m.oohacrtdp = g_dept 
      LET g_ooha_m.oohacrtdt = cl_get_current()
      LET g_ooha_m.oohamodid = g_user
      LET g_ooha_m.oohamoddt = cl_get_current()
      LET g_ooha_m.oohastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_ooha_m.ooha002 = g_ooha002_p
      LET g_ooha_m.oohastus = "Y"
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_ooha_m_t.* = g_ooha_m.*
      LET g_ooha_m_o.* = g_ooha_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooha_m.oohastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL aooi380_input("a")
      
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
         INITIALIZE g_ooha_m.* TO NULL
         INITIALIZE g_oohb_d TO NULL
         INITIALIZE g_oohb10_d TO NULL
         INITIALIZE g_oohb11_d TO NULL
         INITIALIZE g_oohb2_d TO NULL
         INITIALIZE g_oohb3_d TO NULL
         INITIALIZE g_oohb4_d TO NULL
         INITIALIZE g_oohb5_d TO NULL
         INITIALIZE g_oohb6_d TO NULL
         INITIALIZE g_oohb7_d TO NULL
         INITIALIZE g_oohb8_d TO NULL
         INITIALIZE g_oohb9_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aooi380_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_oohb_d.clear()
      #CALL g_oohb10_d.clear()
      #CALL g_oohb11_d.clear()
      #CALL g_oohb2_d.clear()
      #CALL g_oohb3_d.clear()
      #CALL g_oohb4_d.clear()
      #CALL g_oohb5_d.clear()
      #CALL g_oohb6_d.clear()
      #CALL g_oohb7_d.clear()
      #CALL g_oohb8_d.clear()
      #CALL g_oohb9_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aooi380_set_act_visible()   
   CALL aooi380_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_ooha001_t = g_ooha_m.ooha001
 
   
   #組合新增資料的條件
   LET g_add_browse = " oohaent = " ||g_enterprise|| " AND",
                      " ooha001 = '", g_ooha_m.ooha001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aooi380_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aooi380_cl
   
   CALL aooi380_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aooi380_master_referesh USING g_ooha_m.ooha001 INTO g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdt, 
       g_ooha_m.oohamodid,g_ooha_m.oohamoddt,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid_desc, 
       g_ooha_m.oohacrtdp_desc,g_ooha_m.oohamodid_desc
   
   
   #遮罩相關處理
   LET g_ooha_m_mask_o.* =  g_ooha_m.*
   CALL aooi380_ooha_t_mask()
   LET g_ooha_m_mask_n.* =  g_ooha_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohal003,g_ooha_m.oohal005,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid, 
       g_ooha_m.oohacrtid_desc,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdp_desc,g_ooha_m.oohacrtdt,g_ooha_m.oohamodid, 
       g_ooha_m.oohamodid_desc,g_ooha_m.oohamoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_ooha_m.oohaownid      
   LET g_data_dept  = g_ooha_m.oohaowndp
   
   #功能已完成,通報訊息中心
   CALL aooi380_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.modify" >}
#+ 資料修改
PRIVATE FUNCTION aooi380_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
   DEFINE l_wc2_table5   STRING
 
   DEFINE l_wc2_table6   STRING
 
   DEFINE l_wc2_table7   STRING
 
   DEFINE l_wc2_table8   STRING
 
   DEFINE l_wc2_table9   STRING
 
   DEFINE l_wc2_table10   STRING
 
   DEFINE l_wc2_table11   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_ooha_m_t.* = g_ooha_m.*
   LET g_ooha_m_o.* = g_ooha_m.*
   
   IF g_ooha_m.ooha001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_ooha001_t = g_ooha_m.ooha001
 
   CALL s_transaction_begin()
   
   OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aooi380_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi380_master_referesh USING g_ooha_m.ooha001 INTO g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdt, 
       g_ooha_m.oohamodid,g_ooha_m.oohamoddt,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid_desc, 
       g_ooha_m.oohacrtdp_desc,g_ooha_m.oohamodid_desc
   
   #檢查是否允許此動作
   IF NOT aooi380_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_ooha_m_mask_o.* =  g_ooha_m.*
   CALL aooi380_ooha_t_mask()
   LET g_ooha_m_mask_n.* =  g_ooha_m.*
   
   
   
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
 
   #LET l_wc2_table5 = g_wc2_table5
   #LET l_wc2_table5 = " 1=1"
 
   #LET l_wc2_table6 = g_wc2_table6
   #LET l_wc2_table6 = " 1=1"
 
   #LET l_wc2_table7 = g_wc2_table7
   #LET l_wc2_table7 = " 1=1"
 
   #LET l_wc2_table8 = g_wc2_table8
   #LET l_wc2_table8 = " 1=1"
 
   #LET l_wc2_table9 = g_wc2_table9
   #LET l_wc2_table9 = " 1=1"
 
   #LET l_wc2_table10 = g_wc2_table10
   #LET l_wc2_table10 = " 1=1"
 
   #LET l_wc2_table11 = g_wc2_table11
   #LET l_wc2_table11 = " 1=1"
 
 
 
   
   CALL aooi380_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
   #LET  g_wc2_table5 = l_wc2_table5 
 
   #LET  g_wc2_table6 = l_wc2_table6 
 
   #LET  g_wc2_table7 = l_wc2_table7 
 
   #LET  g_wc2_table8 = l_wc2_table8 
 
   #LET  g_wc2_table9 = l_wc2_table9 
 
   #LET  g_wc2_table10 = l_wc2_table10 
 
   #LET  g_wc2_table11 = l_wc2_table11 
 
 
 
    
   WHILE TRUE
      LET g_ooha001_t = g_ooha_m.ooha001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_ooha_m.oohamodid = g_user 
LET g_ooha_m.oohamoddt = cl_get_current()
LET g_ooha_m.oohamodid_desc = cl_get_username(g_ooha_m.oohamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aooi380_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE ooha_t SET (oohamodid,oohamoddt) = (g_ooha_m.oohamodid,g_ooha_m.oohamoddt)
          WHERE oohaent = g_enterprise AND ooha001 = g_ooha001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_ooha_m.* = g_ooha_m_t.*
            CALL aooi380_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_ooha_m.ooha001 != g_ooha_m_t.ooha001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE oohb_t SET oohb001 = g_ooha_m.ooha001
 
          WHERE oohbent = g_enterprise AND oohb001 = g_ooha_m_t.ooha001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohb_t:",SQLERRMESSAGE 
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
         
         UPDATE oohk_t
            SET oohk001 = g_ooha_m.ooha001
 
          WHERE oohkent = g_enterprise AND
                oohk001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohk_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohk_t:",SQLERRMESSAGE 
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
         
         UPDATE oohl_t
            SET oohl001 = g_ooha_m.ooha001
 
          WHERE oohlent = g_enterprise AND
                oohl001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohl_t:",SQLERRMESSAGE 
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
         
         UPDATE oohc_t
            SET oohc001 = g_ooha_m.ooha001
 
          WHERE oohcent = g_enterprise AND
                oohc001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update5"
         
         #end add-point
         
         UPDATE oohd_t
            SET oohd001 = g_ooha_m.ooha001
 
          WHERE oohdent = g_enterprise AND
                oohd001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update5"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update5"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update6"
         
         #end add-point
         
         UPDATE oohe_t
            SET oohe001 = g_ooha_m.ooha001
 
          WHERE ooheent = g_enterprise AND
                oohe001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update6"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohe_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update6"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update7"
         
         #end add-point
         
         UPDATE oohf_t
            SET oohf001 = g_ooha_m.ooha001
 
          WHERE oohfent = g_enterprise AND
                oohf001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update7"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohf_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update7"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update8"
         
         #end add-point
         
         UPDATE oohg_t
            SET oohg001 = g_ooha_m.ooha001
 
          WHERE oohgent = g_enterprise AND
                oohg001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update8"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update8"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update9"
         
         #end add-point
         
         UPDATE oohh_t
            SET oohh001 = g_ooha_m.ooha001
 
          WHERE oohhent = g_enterprise AND
                oohh001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update9"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update9"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update10"
         
         #end add-point
         
         UPDATE oohi_t
            SET oohi001 = g_ooha_m.ooha001
 
          WHERE oohient = g_enterprise AND
                oohi001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update10"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohi_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update10"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update11"
         
         #end add-point
         
         UPDATE oohj_t
            SET oohj001 = g_ooha_m.ooha001
 
          WHERE oohjent = g_enterprise AND
                oohj001 = g_ooha001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update11"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "oohj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update11"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
         
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aooi380_set_act_visible()   
   CALL aooi380_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " oohaent = " ||g_enterprise|| " AND",
                      " ooha001 = '", g_ooha_m.ooha001, "' "
 
   #填到對應位置
   CALL aooi380_browser_fill("")
 
   CLOSE aooi380_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi380_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aooi380.input" >}
#+ 資料輸入
PRIVATE FUNCTION aooi380_input(p_cmd)
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
   DISPLAY BY NAME g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohal003,g_ooha_m.oohal005,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid, 
       g_ooha_m.oohacrtid_desc,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdp_desc,g_ooha_m.oohacrtdt,g_ooha_m.oohamodid, 
       g_ooha_m.oohamodid_desc,g_ooha_m.oohamoddt
   
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
   LET g_forupd_sql = "SELECT oohb002,oohb003,oohb004 FROM oohb_t WHERE oohbent=? AND oohb001=? AND  
       oohb002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohk002,oohk003,oohk004 FROM oohk_t WHERE oohkent=? AND oohk001=? AND  
       oohk002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohl002,oohl003,oohl004,oohl005 FROM oohl_t WHERE oohlent=? AND oohl001=?  
       AND oohl002=? AND oohl003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohc002,oohc003,oohc004 FROM oohc_t WHERE oohcent=? AND oohc001=? AND  
       oohc002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl4 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql5"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohd002,oohd003,oohd004 FROM oohd_t WHERE oohdent=? AND oohd001=? AND  
       oohd002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql5"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl5 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql6"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohe002,oohe003,oohe004 FROM oohe_t WHERE ooheent=? AND oohe001=? AND  
       oohe002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql6"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl6 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql7"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohf002,oohf003,oohf004 FROM oohf_t WHERE oohfent=? AND oohf001=? AND  
       oohf002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql7"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl7 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql8"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohg002,oohg003,oohg004 FROM oohg_t WHERE oohgent=? AND oohg001=? AND  
       oohg002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql8"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl8 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql9"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohh002,oohh003,oohh004 FROM oohh_t WHERE oohhent=? AND oohh001=? AND  
       oohh002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql9"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl9 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql10"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohi002,oohi003,oohi004 FROM oohi_t WHERE oohient=? AND oohi001=? AND  
       oohi002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql10"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl10 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql11"
   
   #end add-point    
   LET g_forupd_sql = "SELECT oohj002,oohj003,oohj004 FROM oohj_t WHERE oohjent=? AND oohj001=? AND  
       oohj002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql11"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aooi380_bcl11 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aooi380_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aooi380_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohal003,g_ooha_m.oohal005,g_ooha_m.oohastus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   IF NOT cl_null(g_ooha002_p) THEN
      CALL cl_set_comp_entry('ooha002',FALSE)  
   END IF

   IF l_cmd_t = 'r' THEN
      LET g_ooha_m.oohastus = 'Y'
   END IF 
   LET g_errshow = '1'    #160225-00006#1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aooi380.input.head" >}
      #單頭段
      INPUT BY NAME g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohal003,g_ooha_m.oohal005,g_ooha_m.oohastus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_ooha_m.ooha001)  THEN
                  CALL n_oohal(g_ooha_m.ooha001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooha_m.ooha001
                  CALL ap_ref_array2(g_ref_fields," SELECT oohal003,oohal005 FROM oohal_t WHERE oohalent = '"
                      ||g_enterprise||"' AND oohal001 = ?  AND oohal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_ooha_m.oohal003 = g_rtn_fields[1]
                  LET g_ooha_m.oohal005 = g_rtn_fields[2]
                  DISPLAY BY NAME g_ooha_m.oohal003
                  DISPLAY BY NAME g_ooha_m.oohal005
               END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.oohal001 = g_ooha_m.ooha001
LET g_master_multi_table_t.oohal003 = g_ooha_m.oohal003
LET g_master_multi_table_t.oohal005 = g_ooha_m.oohal005
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.oohal001 = ''
LET g_master_multi_table_t.oohal003 = ''
LET g_master_multi_table_t.oohal005 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aooi380_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aooi380_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooha002
            #add-point:BEFORE FIELD ooha002 name="input.b.ooha002"
            IF NOT cl_null(g_ooha002_p) THEN
               DISPLAY g_ooha002_p TO ooha002	
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooha002
            
            #add-point:AFTER FIELD ooha002 name="input.a.ooha002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooha002
            #add-point:ON CHANGE ooha002 name="input.g.ooha002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooha001
            #add-point:BEFORE FIELD ooha001 name="input.b.ooha001"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooha001
            
            #add-point:AFTER FIELD ooha001 name="input.a.ooha001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooha_m.ooha001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t ))) THEN 
                  IF NOT ap_chk_notDup(g_ooha_m.ooha001,"SELECT COUNT(*) FROM ooha_t WHERE "||"oohaent = '" ||g_enterprise|| "' AND "||"ooha001 = '"||g_ooha_m.ooha001 ||"'",'std-00004',0) THEN 
                     LET g_ooha_m.ooha001 = g_ooha001_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooha001
            #add-point:ON CHANGE ooha001 name="input.g.ooha001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohal003
            #add-point:BEFORE FIELD oohal003 name="input.b.oohal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohal003
            
            #add-point:AFTER FIELD oohal003 name="input.a.oohal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohal003
            #add-point:ON CHANGE oohal003 name="input.g.oohal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohal005
            #add-point:BEFORE FIELD oohal005 name="input.b.oohal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohal005
            
            #add-point:AFTER FIELD oohal005 name="input.a.oohal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohal005
            #add-point:ON CHANGE oohal005 name="input.g.oohal005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohastus
            #add-point:BEFORE FIELD oohastus name="input.b.oohastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohastus
            
            #add-point:AFTER FIELD oohastus name="input.a.oohastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohastus
            #add-point:ON CHANGE oohastus name="input.g.oohastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooha002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooha002
            #add-point:ON ACTION controlp INFIELD ooha002 name="input.c.ooha002"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooha001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooha001
            #add-point:ON ACTION controlp INFIELD ooha001 name="input.c.ooha001"
            
            #END add-point
 
 
         #Ctrlp:input.c.oohal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohal003
            #add-point:ON ACTION controlp INFIELD oohal003 name="input.c.oohal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.oohal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohal005
            #add-point:ON ACTION controlp INFIELD oohal005 name="input.c.oohal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.oohastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohastus
            #add-point:ON ACTION controlp INFIELD oohastus name="input.c.oohastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_ooha_m.ooha001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO ooha_t (oohaent,ooha002,ooha001,oohastus,oohaownid,oohaowndp,oohacrtid,oohacrtdp, 
                   oohacrtdt,oohamodid,oohamoddt)
               VALUES (g_enterprise,g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohastus,g_ooha_m.oohaownid, 
                   g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdt,g_ooha_m.oohamodid, 
                   g_ooha_m.oohamoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_ooha_m:",SQLERRMESSAGE 
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
         IF g_ooha_m.ooha001 = g_master_multi_table_t.oohal001 AND
         g_ooha_m.oohal003 = g_master_multi_table_t.oohal003 AND 
         g_ooha_m.oohal005 = g_master_multi_table_t.oohal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oohalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_ooha_m.ooha001
            LET l_field_keys[02] = 'oohal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oohal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'oohal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_ooha_m.oohal003
            LET l_fields[01] = 'oohal003'
            LET l_vars[02] = g_ooha_m.oohal005
            LET l_fields[02] = 'oohal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oohal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aooi380_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aooi380_b_fill()
                  CALL aooi380_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               CALL s_transaction_begin()
               #end add-point
               
               #將遮罩欄位還原
               CALL aooi380_ooha_t_mask_restore('restore_mask_o')
               
               UPDATE ooha_t SET (ooha002,ooha001,oohastus,oohaownid,oohaowndp,oohacrtid,oohacrtdp,oohacrtdt, 
                   oohamodid,oohamoddt) = (g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohastus,g_ooha_m.oohaownid, 
                   g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdt,g_ooha_m.oohamodid, 
                   g_ooha_m.oohamoddt)
                WHERE oohaent = g_enterprise AND ooha001 = g_ooha001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ooha_t:",SQLERRMESSAGE 
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
         IF g_ooha_m.ooha001 = g_master_multi_table_t.oohal001 AND
         g_ooha_m.oohal003 = g_master_multi_table_t.oohal003 AND 
         g_ooha_m.oohal005 = g_master_multi_table_t.oohal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oohalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_ooha_m.ooha001
            LET l_field_keys[02] = 'oohal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oohal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'oohal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_ooha_m.oohal003
            LET l_fields[01] = 'oohal003'
            LET l_vars[02] = g_ooha_m.oohal005
            LET l_fields[02] = 'oohal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oohal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_ooha_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_ooha001_t = g_ooha_m.ooha001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aooi380.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_oohb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_oohb_d.getLength()
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
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb_d[l_ac].oohb002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_oohb_d_t.* = g_oohb_d[l_ac].*  #BACKUP
               LET g_oohb_d_o.* = g_oohb_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl INTO g_oohb_d[l_ac].oohb002,g_oohb_d[l_ac].oohb003,g_oohb_d[l_ac].oohb004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_oohb_d_t.oohb002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb_d_mask_o[l_ac].* =  g_oohb_d[l_ac].*
                  CALL aooi380_oohb_t_mask()
                  LET g_oohb_d_mask_n[l_ac].* =  g_oohb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
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
            INITIALIZE g_oohb_d[l_ac].* TO NULL 
            INITIALIZE g_oohb_d_t.* TO NULL 
            INITIALIZE g_oohb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_oohb_d_t.* = g_oohb_d[l_ac].*     #新輸入資料
            LET g_oohb_d_o.* = g_oohb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb_d[li_reproduce_target].* = g_oohb_d[li_reproduce].*
 
               LET g_oohb_d[li_reproduce_target].oohb002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
             LET g_oohb_d[l_ac].oohb003 = g_today
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
            SELECT COUNT(1) INTO l_count FROM oohb_t 
             WHERE oohbent = g_enterprise AND oohb001 = g_ooha_m.ooha001
 
               AND oohb002 = g_oohb_d[l_ac].oohb002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb_d[g_detail_idx].oohb002
               CALL aooi380_insert_b('oohb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_oohb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "oohb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
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
               LET gs_keys[01] = g_ooha_m.ooha001
 
               LET gs_keys[gs_keys.getLength()+1] = g_oohb_d_t.oohb002
 
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohb002
            
            #add-point:AFTER FIELD oohb002 name="input.a.page1.oohb002"
            #检查资料的存在及有效性
            LET g_oohb_d[l_ac].oohb002_desc = ''
            DISPLAY g_oohb_d[l_ac].oohb002_desc TO s_detail1[l_ac].oohb002_desc
            IF NOT cl_null(g_oohb_d[l_ac].oohb002) THEN
               #此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL               
               LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_oohb_d[l_ac].oohb002
               LET g_chkparam.arg2 = g_today         
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補 #160318-00025#30  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               ELSE
                  #檢查失敗時後續處理
                  LET g_oohb_d[l_ac].oohb002 = g_oohb_d_t.oohb002
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            #此段落由子樣板a05產生
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb_d[l_ac].oohb002) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb_d[l_ac].oohb002 != g_oohb_d_t.oohb002)) THEN 
                  IF NOT ap_chk_notDup(g_oohb_d[l_ac].oohb002,"SELECT COUNT(*) FROM oohb_t WHERE "||"oohbent = '" ||g_enterprise|| "' AND "||"oohb001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohb002 = '"||g_oohb_d[l_ac].oohb002 ||"'",'std-00004',0) THEN 
                     LET g_oohb_d[l_ac].oohb002 = g_oohb_d_t.oohb002
                  END IF
               END IF
            END IF            
            CALL aooi380_oohb002_desc(g_oohb_d[l_ac].oohb002) RETURNING g_oohb_d[l_ac].oohb002_desc
            DISPLAY BY NAME g_oohb_d[l_ac].oohb002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohb002
            #add-point:BEFORE FIELD oohb002 name="input.b.page1.oohb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohb002
            #add-point:ON CHANGE oohb002 name="input.g.page1.oohb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohb003
            #add-point:BEFORE FIELD oohb003 name="input.b.page1.oohb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohb003
            
            #add-point:AFTER FIELD oohb003 name="input.a.page1.oohb003"
            IF NOT cl_null(g_oohb_d[l_ac].oohb004) THEN
               IF g_oohb_d[l_ac].oohb003 > g_oohb_d[l_ac].oohb004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb_d[l_ac].oohb003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb_d[l_ac].oohb003 = g_oohb_d_t.oohb003
                  NEXT FIELD oohb003
               END IF
             END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohb003
            #add-point:ON CHANGE oohb003 name="input.g.page1.oohb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohb004
            #add-point:BEFORE FIELD oohb004 name="input.b.page1.oohb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohb004
            
            #add-point:AFTER FIELD oohb004 name="input.a.page1.oohb004"
            IF NOT cl_null(g_oohb_d[l_ac].oohb004) THEN
               IF g_oohb_d[l_ac].oohb003 > g_oohb_d[l_ac].oohb004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb_d[l_ac].oohb003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb_d[l_ac].oohb004 = g_oohb_d_t.oohb004
                  NEXT FIELD oohb004
               END IF
            END IF                 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohb004
            #add-point:ON CHANGE oohb004 name="input.g.page1.oohb004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.oohb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohb002
            #add-point:ON ACTION controlp INFIELD oohb002 name="input.c.page1.oohb002"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb_d[l_ac].oohb002  #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                  #呼叫開窗
            LET g_oohb_d[l_ac].oohb002 = g_qryparam.return1   #將開窗取得的值回傳到變數            
            DISPLAY g_oohb_d[l_ac].oohb002 TO oohb002         #顯示到畫面上
            NEXT FIELD oohb002                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.oohb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohb003
            #add-point:ON ACTION controlp INFIELD oohb003 name="input.c.page1.oohb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.oohb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohb004
            #add-point:ON ACTION controlp INFIELD oohb004 name="input.c.page1.oohb004"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb_d[l_ac].* = g_oohb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_oohb_d[l_ac].oohb002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_oohb_d[l_ac].* = g_oohb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aooi380_oohb_t_mask_restore('restore_mask_o')
      
               UPDATE oohb_t SET (oohb001,oohb002,oohb003,oohb004) = (g_ooha_m.ooha001,g_oohb_d[l_ac].oohb002, 
                   g_oohb_d[l_ac].oohb003,g_oohb_d[l_ac].oohb004)
                WHERE oohbent = g_enterprise AND oohb001 = g_ooha_m.ooha001 
 
                  AND oohb002 = g_oohb_d_t.oohb002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb_d[l_ac].* = g_oohb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb_d[l_ac].* = g_oohb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb_d[g_detail_idx].oohb002
               LET gs_keys_bak[2] = g_oohb_d_t.oohb002
               CALL aooi380_update_b('oohb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_oohb_d[g_detail_idx].oohb002 = g_oohb_d_t.oohb002 
 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb_d_t.oohb002
 
                  CALL aooi380_key_update_b(gs_keys,'oohb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aooi380_unlock_b("oohb_t","'1'")
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
               LET g_oohb_d[li_reproduce_target].* = g_oohb_d[li_reproduce].*
 
               LET g_oohb_d[li_reproduce_target].oohb002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_oohb10_d FROM s_detail10.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body10.before_input2"
            IF g_ooha_m.ooha002 = '0' THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb10_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb10_d.getLength()
            #add-point:資料輸入前 name="input.body10.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb10_d[l_ac].* TO NULL 
            INITIALIZE g_oohb10_d_t.* TO NULL 
            INITIALIZE g_oohb10_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body10.insert.before_bak"
            
            #end add-point
            LET g_oohb10_d_t.* = g_oohb10_d[l_ac].*     #新輸入資料
            LET g_oohb10_d_o.* = g_oohb10_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body10.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb10_d[li_reproduce_target].* = g_oohb10_d[li_reproduce].*
 
               LET g_oohb10_d[li_reproduce_target].oohk002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body10.before_insert"
             INITIALIZE g_oohb10_d_t.* TO NULL 
             LET g_oohb10_d[l_ac].oohk003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body10.before_row2"
            
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
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb10_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb10_d[l_ac].oohk002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb10_d_t.* = g_oohb10_d[l_ac].*  #BACKUP
               LET g_oohb10_d_o.* = g_oohb10_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body10.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohk_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl2 INTO g_oohb10_d[l_ac].oohk002,g_oohb10_d[l_ac].oohk003,g_oohb10_d[l_ac].oohk004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb10_d_mask_o[l_ac].* =  g_oohb10_d[l_ac].*
                  CALL aooi380_oohk_t_mask()
                  LET g_oohb10_d_mask_n[l_ac].* =  g_oohb10_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body10.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body10.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body10.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body10.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb10_d_t.oohk002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohk_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohk_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body10.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body10.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body10.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb10_d.getLength() + 1) THEN
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
               
            #add-point:單身2新增前 name="input.body10.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohk_t 
             WHERE oohkent = g_enterprise AND oohk001 = g_ooha_m.ooha001
               AND oohk002 = g_oohb10_d[l_ac].oohk002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body10.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb10_d[g_detail_idx].oohk002
               CALL aooi380_insert_b('oohk_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body10.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohk_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body10.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb10_d[l_ac].* = g_oohb10_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl2
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
               LET g_oohb10_d[l_ac].* = g_oohb10_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body10.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohk_t_mask_restore('restore_mask_o')
                              
               UPDATE oohk_t SET (oohk001,oohk002,oohk003,oohk004) = (g_ooha_m.ooha001,g_oohb10_d[l_ac].oohk002, 
                   g_oohb10_d[l_ac].oohk003,g_oohb10_d[l_ac].oohk004) #自訂欄位頁簽
                WHERE oohkent = g_enterprise AND oohk001 = g_ooha_m.ooha001
                  AND oohk002 = g_oohb10_d_t.oohk002 #項次 
                  
               #add-point:單身page2修改中 name="input.body10.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb10_d[l_ac].* = g_oohb10_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohk_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb10_d[l_ac].* = g_oohb10_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohk_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb10_d[g_detail_idx].oohk002
               LET gs_keys_bak[2] = g_oohb10_d_t.oohk002
               CALL aooi380_update_b('oohk_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohk_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb10_d[g_detail_idx].oohk002 = g_oohb10_d_t.oohk002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb10_d_t.oohk002
                  CALL aooi380_key_update_b(gs_keys,'oohk_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb10_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb10_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body10.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohk002
            
            #add-point:AFTER FIELD oohk002 name="input.a.page10.oohk002"
            DISPLAY '' TO s_detail10[l_ac].oohk002_desc
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb10_d[l_ac].oohk002) THEN
               #營運據點資料檢查
               CALL aooi380_ooef001_chk(g_oohb10_d[l_ac].oohk002)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_oohb10_d[l_ac].oohk002
                  #160318-00005#31  By 07900 --add-str
                  LET g_errparam.replace[1] ='aooi100'
                  LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                  LET g_errparam.exeprog ='aooi100'
                  #160318-00005#31  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb10_d[l_ac].oohk002 = g_oohb10_d_t.oohk002
                  CALL aooi380_ooef001_desc(g_oohb10_d[l_ac].oohk002) RETURNING g_oohb10_d[l_ac].oohk002_desc
                  DISPLAY BY NAME g_oohb10_d[l_ac].oohk002_desc
                  NEXT FIELD oohk002_desc 
               END IF 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb10_d[l_ac].oohk002 != g_oohb10_d_t.oohk002))) THEN 
                  IF NOT ap_chk_notDup(g_oohb10_d[l_ac].oohk002,"SELECT COUNT(*) FROM oohk_t WHERE "||"oohkent = '" ||g_enterprise|| "' AND "||"oohk001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohk002 = '"||g_oohb10_d[l_ac].oohk002 ||"'",'std-00004',0) THEN 
                     LET g_oohb10_d[l_ac].oohk002 = g_oohb10_d_t.oohk002
                     CALL aooi380_ooef001_desc(g_oohb10_d[l_ac].oohk002) RETURNING g_oohb10_d[l_ac].oohk002_desc
                     DISPLAY BY NAME g_oohb10_d[l_ac].oohk002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #據點名稱
            CALL aooi380_ooef001_desc(g_oohb10_d[l_ac].oohk002) RETURNING g_oohb10_d[l_ac].oohk002_desc
            DISPLAY BY NAME g_oohb10_d[l_ac].oohk002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohk002
            #add-point:BEFORE FIELD oohk002 name="input.b.page10.oohk002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohk002
            #add-point:ON CHANGE oohk002 name="input.g.page10.oohk002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohk003
            #add-point:BEFORE FIELD oohk003 name="input.b.page10.oohk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohk003
            
            #add-point:AFTER FIELD oohk003 name="input.a.page10.oohk003"
            IF NOT cl_null(g_oohb10_d[l_ac].oohk004) THEN
               IF g_oohb10_d[l_ac].oohk003 > g_oohb10_d[l_ac].oohk004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb10_d[l_ac].oohk003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb10_d[l_ac].oohk003 = g_oohb10_d_t.oohk004
                  NEXT FIELD oohk003
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohk003
            #add-point:ON CHANGE oohk003 name="input.g.page10.oohk003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohk004
            #add-point:BEFORE FIELD oohk004 name="input.b.page10.oohk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohk004
            
            #add-point:AFTER FIELD oohk004 name="input.a.page10.oohk004"
            IF NOT cl_null(g_oohb10_d[l_ac].oohk004) THEN
               IF g_oohb10_d[l_ac].oohk003 > g_oohb10_d[l_ac].oohk004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb10_d[l_ac].oohk004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb10_d[l_ac].oohk004 = g_oohb10_d_t.oohk004
                  NEXT FIELD oohk004
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohk004
            #add-point:ON CHANGE oohk004 name="input.g.page10.oohk004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page10.oohk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohk002
            #add-point:ON ACTION controlp INFIELD oohk002 name="input.c.page10.oohk002"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb10_d[l_ac].oohk002  #給予default值
            #CALL q_ooef001()                 #161019-00017#1
            CALL q_ooef001_1()               #161019-00017#1
            LET g_oohb10_d[l_ac].oohk002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_oohb10_d[l_ac].oohk002 TO oohk002         #顯示到畫面上
            NEXT FIELD oohk002                                  #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page10.oohk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohk003
            #add-point:ON ACTION controlp INFIELD oohk003 name="input.c.page10.oohk003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page10.oohk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohk004
            #add-point:ON ACTION controlp INFIELD oohk004 name="input.c.page10.oohk004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body10.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb10_d[l_ac].* = g_oohb10_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohk_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body10.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body10.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb10_d[li_reproduce_target].* = g_oohb10_d[li_reproduce].*
 
               LET g_oohb10_d[li_reproduce_target].oohk002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb10_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb10_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb11_d FROM s_detail11.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body11.before_input2"
            IF g_ooha_m.ooha002 MATCHES "[01234]" THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb11_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb11_d.getLength()
            #add-point:資料輸入前 name="input.body11.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb11_d[l_ac].* TO NULL 
            INITIALIZE g_oohb11_d_t.* TO NULL 
            INITIALIZE g_oohb11_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body11.insert.before_bak"
            
            #end add-point
            LET g_oohb11_d_t.* = g_oohb11_d[l_ac].*     #新輸入資料
            LET g_oohb11_d_o.* = g_oohb11_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body11.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb11_d[li_reproduce_target].* = g_oohb11_d[li_reproduce].*
 
               LET g_oohb11_d[li_reproduce_target].oohl002 = NULL
               LET g_oohb11_d[li_reproduce_target].oohl003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body11.before_insert"
             INITIALIZE g_oohb11_d_t.* TO NULL 
             LET g_oohb11_d[l_ac].oohl004 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body11.before_row2"
            
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
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb11_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb11_d[l_ac].oohl002 IS NOT NULL
               AND g_oohb11_d[l_ac].oohl003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb11_d_t.* = g_oohb11_d[l_ac].*  #BACKUP
               LET g_oohb11_d_o.* = g_oohb11_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body11.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohl_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl3 INTO g_oohb11_d[l_ac].oohl002,g_oohb11_d[l_ac].oohl003,g_oohb11_d[l_ac].oohl004, 
                      g_oohb11_d[l_ac].oohl005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb11_d_mask_o[l_ac].* =  g_oohb11_d[l_ac].*
                  CALL aooi380_oohl_t_mask()
                  LET g_oohb11_d_mask_n[l_ac].* =  g_oohb11_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body11.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body11.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body11.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body11.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb11_d_t.oohl002
               LET gs_keys[gs_keys.getLength()+1] = g_oohb11_d_t.oohl003
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohl_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohl_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body11.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body11.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body11.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb11_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body11.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohl_t 
             WHERE oohlent = g_enterprise AND oohl001 = g_ooha_m.ooha001
               AND oohl002 = g_oohb11_d[l_ac].oohl002
               AND oohl003 = g_oohb11_d[l_ac].oohl003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body11.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb11_d[g_detail_idx].oohl002
               LET gs_keys[3] = g_oohb11_d[g_detail_idx].oohl003
               CALL aooi380_insert_b('oohl_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body11.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body11.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb11_d[l_ac].* = g_oohb11_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl3
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
               LET g_oohb11_d[l_ac].* = g_oohb11_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body11.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohl_t_mask_restore('restore_mask_o')
                              
               UPDATE oohl_t SET (oohl001,oohl002,oohl003,oohl004,oohl005) = (g_ooha_m.ooha001,g_oohb11_d[l_ac].oohl002, 
                   g_oohb11_d[l_ac].oohl003,g_oohb11_d[l_ac].oohl004,g_oohb11_d[l_ac].oohl005) #自訂欄位頁簽 
 
                WHERE oohlent = g_enterprise AND oohl001 = g_ooha_m.ooha001
                  AND oohl002 = g_oohb11_d_t.oohl002 #項次 
                  AND oohl003 = g_oohb11_d_t.oohl003
                  
               #add-point:單身page3修改中 name="input.body11.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb11_d[l_ac].* = g_oohb11_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb11_d[l_ac].* = g_oohb11_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb11_d[g_detail_idx].oohl002
               LET gs_keys_bak[2] = g_oohb11_d_t.oohl002
               LET gs_keys[3] = g_oohb11_d[g_detail_idx].oohl003
               LET gs_keys_bak[3] = g_oohb11_d_t.oohl003
               CALL aooi380_update_b('oohl_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohl_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb11_d[g_detail_idx].oohl002 = g_oohb11_d_t.oohl002 
                  AND g_oohb11_d[g_detail_idx].oohl003 = g_oohb11_d_t.oohl003 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb11_d_t.oohl002
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb11_d_t.oohl003
                  CALL aooi380_key_update_b(gs_keys,'oohl_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb11_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb11_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body11.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohl002
            
            #add-point:AFTER FIELD oohl002 name="input.a.page11.oohl002"
            DISPLAY '' TO s_detail11[l_ac].oohl002_desc
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb11_d[l_ac].oohl002) THEN
               #營運據點資料檢查
               CALL aooi380_ooef001_chk(g_oohb11_d[l_ac].oohl002)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_oohb11_d[l_ac].oohl002
                  #160318-00005#31  By 07900 --add-str
                  LET g_errparam.replace[1] ='aooi100'
                  LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                  LET g_errparam.exeprog ='aooi100'
                  #160318-00005#31  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb11_d[l_ac].oohl002 = g_oohb11_d_t.oohl002
                  CALL aooi380_ooef001_desc(g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl002_desc
                  DISPLAY BY NAME g_oohb11_d[l_ac].oohl002_desc
                  NEXT FIELD oohl002
               END IF 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb11_d[l_ac].oohl002 != g_oohb11_d_t.oohl002))) THEN 
               IF l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb11_d[l_ac].oohl002 != g_oohb11_d_t.oohl002) THEN 
                  IF NOT ap_chk_notDup(g_oohb11_d[l_ac].oohl002,"SELECT COUNT(*) FROM oohl_t WHERE "||"oohlent = '" ||g_enterprise|| "' AND "||"oohl001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohl002 = '"||g_oohb11_d[l_ac].oohl002 ||"'",'std-00004',0) THEN 
                     LET g_oohb11_d[l_ac].oohl002 = g_oohb11_d_t.oohl002
                     CALL aooi380_ooef001_desc(g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl002_desc
                     DISPLAY BY NAME g_oohb11_d[l_ac].oohl002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #據點名稱
            CALL aooi380_ooef001_desc(g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl002_desc
            DISPLAY BY NAME g_oohb11_d[l_ac].oohl002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohl002
            #add-point:BEFORE FIELD oohl002 name="input.b.page11.oohl002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohl002
            #add-point:ON CHANGE oohl002 name="input.g.page11.oohl002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohl003
            
            #add-point:AFTER FIELD oohl003 name="input.a.page11.oohl003"
            #此段落由子樣板a05產生
            DISPLAY '' TO s_detail7[l_ac].oohl003_desc
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb11_d[l_ac].oohl002) AND NOT cl_null(g_oohb11_d[l_ac].oohl003) THEN 
               #庫位資料檢查
               CALL aooi380_oohl003_chk(g_oohb11_d[l_ac].oohl002,g_oohb11_d[l_ac].oohl003)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_oohb11_d[l_ac].oohl003
                  #160318-00005#31  By 07900 --add-str
                  LET g_errparam.replace[1] ='aini001'
                  LET g_errparam.replace[2] = cl_get_progname("aini001",g_lang,"2")
                  LET g_errparam.exeprog ='aini001'
                  #160318-00005#31  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb11_d[l_ac].oohl003 = g_oohb11_d_t.oohl003
                  CALL aooi380_oohl003_desc(g_oohb11_d[l_ac].oohl003,g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl003_desc
                  DISPLAY BY NAME g_oohb11_d[l_ac].oohl003_desc
                  NEXT FIELD oohl003
               END IF                   
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb11_d[l_ac].oohl002 != g_oohb11_d_t.oohl002 OR g_oohb11_d[l_ac].oohl003 != g_oohb11_d_t.oohl003)) THEN 
                  IF NOT ap_chk_notDup(g_oohb11_d[l_ac].oohl003,"SELECT COUNT(*) FROM oohl_t WHERE "||"oohlent = '" ||g_enterprise|| "' AND "||"oohl001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohl002 = '"||g_oohb11_d[l_ac].oohl002 ||"' AND "|| "oohl003 = '"||g_oohb11_d[l_ac].oohl003 ||"'",'std-00004',0) THEN 
                     LET g_oohb11_d[l_ac].oohl003 = g_oohb11_d_t.oohl003
                     CALL aooi380_oohl003_desc(g_oohb11_d[l_ac].oohl003,g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl003_desc
                     DISPLAY BY NAME g_oohb11_d[l_ac].oohl003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aooi380_oohl003_desc(g_oohb11_d[l_ac].oohl003,g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl003_desc
            DISPLAY BY NAME g_oohb11_d[l_ac].oohl003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohl003
            #add-point:BEFORE FIELD oohl003 name="input.b.page11.oohl003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohl003
            #add-point:ON CHANGE oohl003 name="input.g.page11.oohl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohl004
            #add-point:BEFORE FIELD oohl004 name="input.b.page11.oohl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohl004
            
            #add-point:AFTER FIELD oohl004 name="input.a.page11.oohl004"
            IF NOT cl_null(g_oohb11_d[l_ac].oohl005) THEN
               IF g_oohb11_d[l_ac].oohl004 > g_oohb11_d[l_ac].oohl005 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb11_d[l_ac].oohl004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb11_d[l_ac].oohl004  = g_oohb11_d_t.oohl004
                  NEXT FIELD oohl004
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohl004
            #add-point:ON CHANGE oohl004 name="input.g.page11.oohl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohl005
            #add-point:BEFORE FIELD oohl005 name="input.b.page11.oohl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohl005
            
            #add-point:AFTER FIELD oohl005 name="input.a.page11.oohl005"
            IF NOT cl_null(g_oohb11_d[l_ac].oohl005) THEN
               IF g_oohb11_d[l_ac].oohl004 > g_oohb11_d[l_ac].oohl005 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb11_d[l_ac].oohl005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb11_d[l_ac].oohl005  = g_oohb11_d_t.oohl005
                  NEXT FIELD oohl005
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohl005
            #add-point:ON CHANGE oohl005 name="input.g.page11.oohl005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page11.oohl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohl002
            #add-point:ON ACTION controlp INFIELD oohl002 name="input.c.page11.oohl002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb11_d[l_ac].oohl002   #給予default值
            #CALL q_ooef001()                  #161019-00017#1
            CALL q_ooef001_1()               #161019-00017#1
            LET g_oohb11_d[l_ac].oohl002 = g_qryparam.return1    #將開窗取得的值回傳到變數
            DISPLAY g_oohb11_d[l_ac].oohl002 TO oohl002          #顯示到畫面上
            NEXT FIELD oohl002                                   #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page11.oohl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohl003
            #add-point:ON ACTION controlp INFIELD oohl003 name="input.c.page11.oohl003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb11_d[l_ac].oohl003   #給予default值
            LET g_qryparam.arg1 = g_oohb11_d[l_ac].oohl002
            CALL q_inaa001_6()                                   #呼叫開窗
            LET g_oohb11_d[l_ac].oohl003 = g_qryparam.return1    #將開窗取得的值回傳到變數
            DISPLAY g_oohb11_d[l_ac].oohl003 TO oohl003          #顯示到畫面上            
            CALL aooi380_oohl003_desc(g_oohb11_d[l_ac].oohl003,g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl003_desc
            DISPLAY BY NAME g_oohb11_d[l_ac].oohl003_desc
            NEXT FIELD oohl003                                   #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page11.oohl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohl004
            #add-point:ON ACTION controlp INFIELD oohl004 name="input.c.page11.oohl004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page11.oohl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohl005
            #add-point:ON ACTION controlp INFIELD oohl005 name="input.c.page11.oohl005"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body11.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb11_d[l_ac].* = g_oohb11_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohl_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body11.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body11.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb11_d[li_reproduce_target].* = g_oohb11_d[li_reproduce].*
 
               LET g_oohb11_d[li_reproduce_target].oohl002 = NULL
               LET g_oohb11_d[li_reproduce_target].oohl003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb11_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb11_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb2_d[l_ac].* TO NULL 
            INITIALIZE g_oohb2_d_t.* TO NULL 
            INITIALIZE g_oohb2_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_oohb2_d_t.* = g_oohb2_d[l_ac].*     #新輸入資料
            LET g_oohb2_d_o.* = g_oohb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb2_d[li_reproduce_target].* = g_oohb2_d[li_reproduce].*
 
               LET g_oohb2_d[li_reproduce_target].oohc002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
             INITIALIZE g_oohb2_d_t.* TO NULL 
             LET g_oohb2_d[l_ac].oohc003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
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
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb2_d[l_ac].oohc002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb2_d_t.* = g_oohb2_d[l_ac].*  #BACKUP
               LET g_oohb2_d_o.* = g_oohb2_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohc_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl4 INTO g_oohb2_d[l_ac].oohc002,g_oohb2_d[l_ac].oohc003,g_oohb2_d[l_ac].oohc004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb2_d_mask_o[l_ac].* =  g_oohb2_d[l_ac].*
                  CALL aooi380_oohc_t_mask()
                  LET g_oohb2_d_mask_n[l_ac].* =  g_oohb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
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
               
               #add-point:單身4刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb2_d_t.oohc002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohc_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb2_d.getLength() + 1) THEN
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
               
            #add-point:單身4新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohc_t 
             WHERE oohcent = g_enterprise AND oohc001 = g_ooha_m.ooha001
               AND oohc002 = g_oohb2_d[l_ac].oohc002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb2_d[g_detail_idx].oohc002
               CALL aooi380_insert_b('oohc_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
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
               LET g_oohb2_d[l_ac].* = g_oohb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl4
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
               LET g_oohb2_d[l_ac].* = g_oohb2_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohc_t_mask_restore('restore_mask_o')
                              
               UPDATE oohc_t SET (oohc001,oohc002,oohc003,oohc004) = (g_ooha_m.ooha001,g_oohb2_d[l_ac].oohc002, 
                   g_oohb2_d[l_ac].oohc003,g_oohb2_d[l_ac].oohc004) #自訂欄位頁簽
                WHERE oohcent = g_enterprise AND oohc001 = g_ooha_m.ooha001
                  AND oohc002 = g_oohb2_d_t.oohc002 #項次 
                  
               #add-point:單身page4修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb2_d[l_ac].* = g_oohb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb2_d[l_ac].* = g_oohb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb2_d[g_detail_idx].oohc002
               LET gs_keys_bak[2] = g_oohb2_d_t.oohc002
               CALL aooi380_update_b('oohc_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb2_d[g_detail_idx].oohc002 = g_oohb2_d_t.oohc002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb2_d_t.oohc002
                  CALL aooi380_key_update_b(gs_keys,'oohc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb2_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc002
            
            #add-point:AFTER FIELD oohc002 name="input.a.page2.oohc002"
           #此段落由子樣板a05產生
            LET g_oohb2_d[l_ac].oohc002_desc = ''
            DISPLAY  g_oohb2_d[l_ac].oohc002_desc TO s_detail2[l_ac].oohc002_desc            
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb2_d[l_ac].oohc002) THEN 
               #栏位检查
               #160225-00006#1--mod--b
#              CALL aooi380_oohc002_chk(g_oohb2_d[l_ac].oohc002)   
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_oohb2_d[l_ac].oohc002
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_oohb2_d[l_ac].oohc002 = g_oohb2_d_t.oohc002
#                  CALL aooi380_oohc002_desc(g_oohb2_d[l_ac].oohc002) RETURNING g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
#                  DISPLAY BY NAME g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
#                  NEXT FIELD CURRENT
#               END IF
               INITIALIZE g_chkparam.* TO NULL               
               LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_oohb2_d[l_ac].oohc002
               LET g_chkparam.arg2 = g_site        
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#30  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001_6") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               ELSE
                  #檢查失敗時後續處理
                  LET g_oohb2_d[l_ac].oohc002 = g_oohb2_d_t.oohc002
                  CALL aooi380_oohc002_desc(g_oohb2_d[l_ac].oohc002) RETURNING g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
                  DISPLAY BY NAME g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
                  NEXT FIELD CURRENT
               END IF
               #160225-00006#1--mod--e               
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb2_d[l_ac].oohc002 != g_oohb2_d_t.oohc002)) THEN 
                  IF NOT ap_chk_notDup(g_oohb2_d[l_ac].oohc002,"SELECT COUNT(*) FROM oohc_t WHERE "||"oohcent = '" ||g_enterprise|| "' AND "||"oohc001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohc002 = '"||g_oohb2_d[l_ac].oohc002 ||"'",'std-00004',0) THEN 
                     LET g_oohb2_d[l_ac].oohc002 = g_oohb2_d_t.oohc002
                     CALL aooi380_oohc002_desc(g_oohb2_d[l_ac].oohc002) RETURNING g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
                     DISPLAY BY NAME g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF            
            CALL aooi380_oohc002_desc(g_oohb2_d[l_ac].oohc002) RETURNING g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
            DISPLAY BY NAME g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc002
            #add-point:BEFORE FIELD oohc002 name="input.b.page2.oohc002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohc002
            #add-point:ON CHANGE oohc002 name="input.g.page2.oohc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc002_desc
            #add-point:BEFORE FIELD oohc002_desc name="input.b.page2.oohc002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc002_desc
            
            #add-point:AFTER FIELD oohc002_desc name="input.a.page2.oohc002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohc002_desc
            #add-point:ON CHANGE oohc002_desc name="input.g.page2.oohc002_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc002_desc2
            #add-point:BEFORE FIELD oohc002_desc2 name="input.b.page2.oohc002_desc2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc002_desc2
            
            #add-point:AFTER FIELD oohc002_desc2 name="input.a.page2.oohc002_desc2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohc002_desc2
            #add-point:ON CHANGE oohc002_desc2 name="input.g.page2.oohc002_desc2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc003
            #add-point:BEFORE FIELD oohc003 name="input.b.page2.oohc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc003
            
            #add-point:AFTER FIELD oohc003 name="input.a.page2.oohc003"
             IF NOT cl_null(g_oohb2_d[l_ac].oohc003) THEN 
               IF g_oohb2_d[l_ac].oohc003 > g_oohb2_d[l_ac].oohc004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb2_d[l_ac].oohc003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb2_d[l_ac].oohc003 = g_oohb2_d_t.oohc003
                  NEXT FIELD oohc003
               END IF  
             END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohc003
            #add-point:ON CHANGE oohc003 name="input.g.page2.oohc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohc004
            #add-point:BEFORE FIELD oohc004 name="input.b.page2.oohc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohc004
            
            #add-point:AFTER FIELD oohc004 name="input.a.page2.oohc004"
            IF NOT cl_null(g_oohb2_d[l_ac].oohc004) THEN 
               IF g_oohb2_d[l_ac].oohc003 > g_oohb2_d[l_ac].oohc004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb2_d[l_ac].oohc004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb2_d[l_ac].oohc004 = g_oohb2_d_t.oohc004
                  NEXT FIELD oohc004
               END IF  
             END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohc004
            #add-point:ON CHANGE oohc004 name="input.g.page2.oohc004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.oohc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc002
            #add-point:ON ACTION controlp INFIELD oohc002 name="input.c.page2.oohc002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb2_d[l_ac].oohc002  #給予default值
            LET g_qryparam.default2 = ""
            CALL q_ooag001_2()                                 #呼叫開窗
            LET g_oohb2_d[l_ac].oohc002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_oohb2_d[l_ac].oohc002 TO oohc002         #顯示到畫面上
            NEXT FIELD oohc002                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.oohc002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc002_desc
            #add-point:ON ACTION controlp INFIELD oohc002_desc name="input.c.page2.oohc002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.oohc002_desc2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc002_desc2
            #add-point:ON ACTION controlp INFIELD oohc002_desc2 name="input.c.page2.oohc002_desc2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.oohc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc003
            #add-point:ON ACTION controlp INFIELD oohc003 name="input.c.page2.oohc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.oohc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohc004
            #add-point:ON ACTION controlp INFIELD oohc004 name="input.c.page2.oohc004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb2_d[l_ac].* = g_oohb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohc_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb2_d[li_reproduce_target].* = g_oohb2_d[li_reproduce].*
 
               LET g_oohb2_d[li_reproduce_target].oohc002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            IF g_ooha_m.ooha002 MATCHES "[013456]" THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb3_d[l_ac].* TO NULL 
            INITIALIZE g_oohb3_d_t.* TO NULL 
            INITIALIZE g_oohb3_d_o.* TO NULL 
            #公用欄位給值(單身5)
            
            #自定義預設值(單身5)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_oohb3_d_t.* = g_oohb3_d[l_ac].*     #新輸入資料
            LET g_oohb3_d_o.* = g_oohb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb3_d[li_reproduce_target].* = g_oohb3_d[li_reproduce].*
 
               LET g_oohb3_d[li_reproduce_target].oohd002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            INITIALIZE g_oohb3_d_t.* TO NULL
            LET g_oohb3_d[l_ac].oohd003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[5] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb3_d[l_ac].oohd002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb3_d_t.* = g_oohb3_d[l_ac].*  #BACKUP
               LET g_oohb3_d_o.* = g_oohb3_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohd_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl5 INTO g_oohb3_d[l_ac].oohd002,g_oohb3_d[l_ac].oohd003,g_oohb3_d[l_ac].oohd004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb3_d_mask_o[l_ac].* =  g_oohb3_d[l_ac].*
                  CALL aooi380_oohd_t_mask()
                  LET g_oohb3_d_mask_n[l_ac].* =  g_oohb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
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
               
               #add-point:單身5刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb3_d_t.oohd002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohd_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身5刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身5刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb3_d.getLength() + 1) THEN
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
               
            #add-point:單身5新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohd_t 
             WHERE oohdent = g_enterprise AND oohd001 = g_ooha_m.ooha001
               AND oohd002 = g_oohb3_d[l_ac].oohd002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb3_d[g_detail_idx].oohd002
               CALL aooi380_insert_b('oohd_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
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
               LET g_oohb3_d[l_ac].* = g_oohb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl5
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
               LET g_oohb3_d[l_ac].* = g_oohb3_d_t.*
            ELSE
               #add-point:單身page5修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身5)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohd_t_mask_restore('restore_mask_o')
                              
               UPDATE oohd_t SET (oohd001,oohd002,oohd003,oohd004) = (g_ooha_m.ooha001,g_oohb3_d[l_ac].oohd002, 
                   g_oohb3_d[l_ac].oohd003,g_oohb3_d[l_ac].oohd004) #自訂欄位頁簽
                WHERE oohdent = g_enterprise AND oohd001 = g_ooha_m.ooha001
                  AND oohd002 = g_oohb3_d_t.oohd002 #項次 
                  
               #add-point:單身page5修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb3_d[l_ac].* = g_oohb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb3_d[l_ac].* = g_oohb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb3_d[g_detail_idx].oohd002
               LET gs_keys_bak[2] = g_oohb3_d_t.oohd002
               CALL aooi380_update_b('oohd_t',gs_keys,gs_keys_bak,"'5'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb3_d[g_detail_idx].oohd002 = g_oohb3_d_t.oohd002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb3_d_t.oohd002
                  CALL aooi380_key_update_b(gs_keys,'oohd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb3_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page5修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohd002
            
            #add-point:AFTER FIELD oohd002 name="input.a.page3.oohd002"
             DISPLAY '' TO s_detail3[l_ac].oohd002_desc
            #此段落由子樣板a05產生
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb3_d[l_ac].oohd002) THEN
               #栏位检查
               CALL aooi380_oohd002_chk(281,g_oohb3_d[l_ac].oohd002)   
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_oohb3_d[l_ac].oohD002
                  #160318-00005#31  By 07900 --add-str                 
                  LET g_errparam.replace[1] ='axmi021'
                  LET g_errparam.replace[2] = cl_get_progname("axmi021",g_lang,"2")
                  LET g_errparam.exeprog ='axmi021'                
                  #160318-00005#31  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   LET g_oohb3_d[l_ac].oohd002 = g_oohb3_d_t.oohd002
                   CALL aooi380_oohd002_desc(281,g_oohb3_d[l_ac].oohd002) RETURNING g_oohb3_d[l_ac].oohd002_desc
                   DISPLAY BY NAME g_oohb3_d[l_ac].oohd002_desc
                   NEXT FIELD CURRENT                  
               END IF                   
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb3_d[l_ac].oohd002 != g_oohb3_d_t.oohd002))) THEN 
                  IF NOT ap_chk_notDup(g_oohb3_d[l_ac].oohd002,"SELECT COUNT(*) FROM oohd_t WHERE "||"oohdent = '" ||g_enterprise|| "' AND "||"oohd001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohd002 = '"||g_oohb3_d[l_ac].oohd002 ||"'",'std-00004',0) THEN 
                     LET g_oohb3_d[l_ac].oohd002 = g_oohb3_d_t.oohd002
                     CALL aooi380_oohd002_desc(281,g_oohb3_d[l_ac].oohd002) RETURNING g_oohb3_d[l_ac].oohd002_desc
                     DISPLAY BY NAME g_oohb3_d[l_ac].oohd002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #客户分类说明
            CALL aooi380_oohd002_desc(281,g_oohb3_d[l_ac].oohd002) RETURNING g_oohb3_d[l_ac].oohd002_desc
            DISPLAY BY NAME g_oohb3_d[l_ac].oohd002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohd002
            #add-point:BEFORE FIELD oohd002 name="input.b.page3.oohd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohd002
            #add-point:ON CHANGE oohd002 name="input.g.page3.oohd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohd003
            #add-point:BEFORE FIELD oohd003 name="input.b.page3.oohd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohd003
            
            #add-point:AFTER FIELD oohd003 name="input.a.page3.oohd003"
             IF NOT cl_null(g_oohb3_d[l_ac].oohd004) THEN
               IF g_oohb3_d[l_ac].oohd003 > g_oohb3_d[l_ac].oohd004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb3_d[l_ac].oohd003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb3_d[l_ac].oohd003 = g_oohb3_d_t.oohd003
                  NEXT FIELD oohd003
               END IF 
            END IF     
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohd003
            #add-point:ON CHANGE oohd003 name="input.g.page3.oohd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohd004
            #add-point:BEFORE FIELD oohd004 name="input.b.page3.oohd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohd004
            
            #add-point:AFTER FIELD oohd004 name="input.a.page3.oohd004"
            IF NOT cl_null(g_oohb3_d[l_ac].oohd004) THEN
               IF g_oohb3_d[l_ac].oohd003 > g_oohb3_d[l_ac].oohd004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb3_d[l_ac].oohd004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb3_d[l_ac].oohd004 = g_oohb3_d_t.oohd004
                  NEXT FIELD oohd004
               END IF
            END IF                 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohd004
            #add-point:ON CHANGE oohd004 name="input.g.page3.oohd004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.oohd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohd002
            #add-point:ON ACTION controlp INFIELD oohd002 name="input.c.page3.oohd002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb3_d[l_ac].oohd002   #給予default值
            #給予arg
            LET g_qryparam.arg1 = "281"                         #應用分類
            CALL q_oocq002()                                    #呼叫開窗
            LET g_oohb3_d[l_ac].oohd002 = g_qryparam.return1    #將開窗取得的值回傳到變數
            DISPLAY g_oohb3_d[l_ac].oohd002 TO oohd002          #顯示到畫面上
            NEXT FIELD oohd002                                  #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.oohd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohd003
            #add-point:ON ACTION controlp INFIELD oohd003 name="input.c.page3.oohd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.oohd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohd004
            #add-point:ON ACTION controlp INFIELD oohd004 name="input.c.page3.oohd004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page5 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb3_d[l_ac].* = g_oohb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl5
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohd_t","'5'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page5 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb3_d[li_reproduce_target].* = g_oohb3_d[li_reproduce].*
 
               LET g_oohb3_d[li_reproduce_target].oohd002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_6)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            IF g_ooha_m.ooha002 MATCHES "[013456]" THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb4_d[l_ac].* TO NULL 
            INITIALIZE g_oohb4_d_t.* TO NULL 
            INITIALIZE g_oohb4_d_o.* TO NULL 
            #公用欄位給值(單身6)
            
            #自定義預設值(單身6)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_oohb4_d_t.* = g_oohb4_d[l_ac].*     #新輸入資料
            LET g_oohb4_d_o.* = g_oohb4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb4_d[li_reproduce_target].* = g_oohb4_d[li_reproduce].*
 
               LET g_oohb4_d[li_reproduce_target].oohe002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            INITIALIZE g_oohb4_d_t.* TO NULL           
            LET g_oohb4_d[l_ac].oohe003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[6] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 6
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb4_d[l_ac].oohe002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb4_d_t.* = g_oohb4_d[l_ac].*  #BACKUP
               LET g_oohb4_d_o.* = g_oohb4_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohe_t","'6'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl6 INTO g_oohb4_d[l_ac].oohe002,g_oohb4_d[l_ac].oohe003,g_oohb4_d[l_ac].oohe004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb4_d_mask_o[l_ac].* =  g_oohb4_d[l_ac].*
                  CALL aooi380_oohe_t_mask()
                  LET g_oohb4_d_mask_n[l_ac].* =  g_oohb4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
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
               
               #add-point:單身6刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb4_d_t.oohe002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohe_t',gs_keys,"'6'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohe_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身6刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身6刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb4_d.getLength() + 1) THEN
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
               
            #add-point:單身6新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohe_t 
             WHERE ooheent = g_enterprise AND oohe001 = g_ooha_m.ooha001
               AND oohe002 = g_oohb4_d[l_ac].oohe002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身6新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb4_d[g_detail_idx].oohe002
               CALL aooi380_insert_b('oohe_t',gs_keys,"'6'")
                           
               #add-point:單身新增後6 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb4_d[l_ac].* = g_oohb4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl6
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
               LET g_oohb4_d[l_ac].* = g_oohb4_d_t.*
            ELSE
               #add-point:單身page6修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身6)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohe_t_mask_restore('restore_mask_o')
                              
               UPDATE oohe_t SET (oohe001,oohe002,oohe003,oohe004) = (g_ooha_m.ooha001,g_oohb4_d[l_ac].oohe002, 
                   g_oohb4_d[l_ac].oohe003,g_oohb4_d[l_ac].oohe004) #自訂欄位頁簽
                WHERE ooheent = g_enterprise AND oohe001 = g_ooha_m.ooha001
                  AND oohe002 = g_oohb4_d_t.oohe002 #項次 
                  
               #add-point:單身page6修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb4_d[l_ac].* = g_oohb4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohe_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb4_d[l_ac].* = g_oohb4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb4_d[g_detail_idx].oohe002
               LET gs_keys_bak[2] = g_oohb4_d_t.oohe002
               CALL aooi380_update_b('oohe_t',gs_keys,gs_keys_bak,"'6'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohe_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb4_d[g_detail_idx].oohe002 = g_oohb4_d_t.oohe002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb4_d_t.oohe002
                  CALL aooi380_key_update_b(gs_keys,'oohe_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb4_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page6修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohe002
            
            #add-point:AFTER FIELD oohe002 name="input.a.page4.oohe002"
            #此段落由子樣板a05產生
            DISPLAY '' TO  s_detail4[l_ac].oohe002_desc
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb4_d[l_ac].oohe002) THEN 
               #客户资料检查
               IF NOT cl_null(g_oohb4_d[l_ac].oohe002) THEN
                  CALL aooi380_oohe002_chk('2',g_oohb4_d[l_ac].oohe002)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_oohb4_d[l_ac].oohe002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_oohb4_d[l_ac].oohe002 = g_oohb4_d_t.oohe002
                     CALL aooi380_oohe002_desc(g_oohb4_d[l_ac].oohe002) RETURNING g_oohb4_d[l_ac].oohe002_desc
                     DISPLAY BY NAME g_oohb4_d[l_ac].oohe002_desc
                     NEXT FIELD CURRENT
                  END IF    
               END IF 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb4_d[l_ac].oohe002 != g_oohb4_d_t.oohe002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oohe_t WHERE "||"ooheent = '" ||g_enterprise|| "' AND "||"oohe001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohe002 = '"||g_oohb4_d[l_ac].oohe002 ||"'",'std-00004',0) THEN 
                     LET g_oohb4_d[l_ac].oohe002 = g_oohb4_d_t.oohe002
                     CALL aooi380_oohe002_desc(g_oohb4_d[l_ac].oohe002) RETURNING g_oohb4_d[l_ac].oohe002_desc
                     DISPLAY BY NAME g_oohb4_d[l_ac].oohe002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            CALL aooi380_oohe002_desc(g_oohb4_d[l_ac].oohe002) RETURNING g_oohb4_d[l_ac].oohe002_desc
            DISPLAY BY NAME g_oohb4_d[l_ac].oohe002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohe002
            #add-point:BEFORE FIELD oohe002 name="input.b.page4.oohe002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohe002
            #add-point:ON CHANGE oohe002 name="input.g.page4.oohe002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohe003
            #add-point:BEFORE FIELD oohe003 name="input.b.page4.oohe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohe003
            
            #add-point:AFTER FIELD oohe003 name="input.a.page4.oohe003"
            IF NOT cl_null(g_oohb4_d[l_ac].oohe004) THEN
               IF g_oohb4_d[l_ac].oohe003 > g_oohb4_d[l_ac].oohe004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb4_d[l_ac].oohe003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb4_d[l_ac].oohe003 = g_oohb4_d_t.oohe003
                  NEXT FIELD oohe003
               END IF
            END IF                 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohe003
            #add-point:ON CHANGE oohe003 name="input.g.page4.oohe003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohe004
            #add-point:BEFORE FIELD oohe004 name="input.b.page4.oohe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohe004
            
            #add-point:AFTER FIELD oohe004 name="input.a.page4.oohe004"
            IF NOT cl_null(g_oohb4_d[l_ac].oohe004) THEN
               IF g_oohb4_d[l_ac].oohe003 > g_oohb4_d[l_ac].oohe004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb4_d[l_ac].oohe004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb4_d[l_ac].oohe004 = g_oohb4_d_t.oohe004
                  NEXT FIELD oohe004
               END IF 
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohe004
            #add-point:ON CHANGE oohe004 name="input.g.page4.oohe004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.oohe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohe002
            #add-point:ON ACTION controlp INFIELD oohe002 name="input.c.page4.oohe002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb4_d[l_ac].oohe002  #給予default值
            #LET g_qryparam.where = " (pmaa002 = '2' OR pmaa002 = '3') "   #160913-00055#3
            #CALL q_pmaa001()                                   #呼叫開窗   #160913-00055#3 
            CALL q_pmaa001_13()        #160913-00055#3
            LET g_oohb4_d[l_ac].oohe002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_oohb4_d[l_ac].oohe002 TO oohe002         #顯示到畫面上
            NEXT FIELD oohe002                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page4.oohe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohe003
            #add-point:ON ACTION controlp INFIELD oohe003 name="input.c.page4.oohe003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.oohe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohe004
            #add-point:ON ACTION controlp INFIELD oohe004 name="input.c.page4.oohe004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page6 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb4_d[l_ac].* = g_oohb4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl6
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohe_t","'6'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page6 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb4_d[li_reproduce_target].* = g_oohb4_d[li_reproduce].*
 
               LET g_oohb4_d[li_reproduce_target].oohe002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_7)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            IF g_ooha_m.ooha002 MATCHES "[0125]" THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'7',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb5_d[l_ac].* TO NULL 
            INITIALIZE g_oohb5_d_t.* TO NULL 
            INITIALIZE g_oohb5_d_o.* TO NULL 
            #公用欄位給值(單身7)
            
            #自定義預設值(單身7)
            
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            
            #end add-point
            LET g_oohb5_d_t.* = g_oohb5_d[l_ac].*     #新輸入資料
            LET g_oohb5_d_o.* = g_oohb5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb5_d[li_reproduce_target].* = g_oohb5_d[li_reproduce].*
 
               LET g_oohb5_d[li_reproduce_target].oohf002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body5.before_insert"
            INITIALIZE g_oohb5_d_t.* TO NULL 
            LET g_oohb5_d[l_ac].oohf003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[7] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 7
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb5_d[l_ac].oohf002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb5_d_t.* = g_oohb5_d[l_ac].*  #BACKUP
               LET g_oohb5_d_o.* = g_oohb5_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohf_t","'7'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl7 INTO g_oohb5_d[l_ac].oohf002,g_oohb5_d[l_ac].oohf003,g_oohb5_d[l_ac].oohf004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb5_d_mask_o[l_ac].* =  g_oohb5_d[l_ac].*
                  CALL aooi380_oohf_t_mask()
                  LET g_oohb5_d_mask_n[l_ac].* =  g_oohb5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
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
               
               #add-point:單身7刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb5_d_t.oohf002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohf_t',gs_keys,"'7'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohf_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身7刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身7刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb5_d.getLength() + 1) THEN
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
               
            #add-point:單身7新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohf_t 
             WHERE oohfent = g_enterprise AND oohf001 = g_ooha_m.ooha001
               AND oohf002 = g_oohb5_d[l_ac].oohf002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身7新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb5_d[g_detail_idx].oohf002
               CALL aooi380_insert_b('oohf_t',gs_keys,"'7'")
                           
               #add-point:單身新增後7 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb5_d[l_ac].* = g_oohb5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl7
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
               LET g_oohb5_d[l_ac].* = g_oohb5_d_t.*
            ELSE
               #add-point:單身page7修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身7)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohf_t_mask_restore('restore_mask_o')
                              
               UPDATE oohf_t SET (oohf001,oohf002,oohf003,oohf004) = (g_ooha_m.ooha001,g_oohb5_d[l_ac].oohf002, 
                   g_oohb5_d[l_ac].oohf003,g_oohb5_d[l_ac].oohf004) #自訂欄位頁簽
                WHERE oohfent = g_enterprise AND oohf001 = g_ooha_m.ooha001
                  AND oohf002 = g_oohb5_d_t.oohf002 #項次 
                  
               #add-point:單身page7修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb5_d[l_ac].* = g_oohb5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb5_d[l_ac].* = g_oohb5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb5_d[g_detail_idx].oohf002
               LET gs_keys_bak[2] = g_oohb5_d_t.oohf002
               CALL aooi380_update_b('oohf_t',gs_keys,gs_keys_bak,"'7'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohf_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb5_d[g_detail_idx].oohf002 = g_oohb5_d_t.oohf002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb5_d_t.oohf002
                  CALL aooi380_key_update_b(gs_keys,'oohf_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb5_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page7修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohf002
            
            #add-point:AFTER FIELD oohf002 name="input.a.page5.oohf002"
            DISPLAY '' TO s_detail5[l_ac].oohf002_desc                     
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb5_d[l_ac].oohf002) THEN
               #栏位检查
               CALL aooi380_oohd002_chk(251,g_oohb5_d[l_ac].oohf002)   
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_oohb5_d[l_ac].oohf002
                  #160318-00005#31  By 07900 --add-str
                  LET g_errparam.replace[1] ='apmi024'
                  LET g_errparam.replace[2] = cl_get_progname("apmi024",g_lang,"2")
                  LET g_errparam.exeprog ='apmi024'
                  #160318-00005#31  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   LET g_oohb5_d[l_ac].oohf002 = g_oohb5_d_t.oohf002
                   CALL aooi380_oohd002_desc(251,g_oohb5_d[l_ac].oohf002) RETURNING  g_oohb5_d[l_ac].oohf002_desc
                   DISPLAY BY NAME g_oohb5_d[l_ac].oohf002_desc
                   NEXT FIELD CURRENT                  
               END IF                               
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb5_d[l_ac].oohf002 != g_oohb5_d_t.oohf002))) THEN 
                  IF NOT ap_chk_notDup(g_oohb5_d[l_ac].oohf002,"SELECT COUNT(*) FROM oohf_t WHERE "||"oohfent = '" ||g_enterprise|| "' AND "||"oohf001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohf002 = '"||g_oohb5_d[l_ac].oohf002 ||"'",'std-00004',0) THEN 
                     LET g_oohb5_d[l_ac].oohf002 = g_oohb5_d_t.oohf002
                     CALL aooi380_oohd002_desc(251,g_oohb5_d[l_ac].oohf002) RETURNING  g_oohb5_d[l_ac].oohf002_desc
                     DISPLAY BY NAME g_oohb5_d[l_ac].oohf002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aooi380_oohd002_desc(251,g_oohb5_d[l_ac].oohf002) RETURNING  g_oohb5_d[l_ac].oohf002_desc
            DISPLAY BY NAME g_oohb5_d[l_ac].oohf002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohf002
            #add-point:BEFORE FIELD oohf002 name="input.b.page5.oohf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohf002
            #add-point:ON CHANGE oohf002 name="input.g.page5.oohf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohf003
            #add-point:BEFORE FIELD oohf003 name="input.b.page5.oohf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohf003
            
            #add-point:AFTER FIELD oohf003 name="input.a.page5.oohf003"
            IF NOT cl_null(g_oohb5_d[l_ac].oohf004) THEN
               IF g_oohb5_d[l_ac].oohf003 > g_oohb5_d[l_ac].oohf004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb5_d[l_ac].oohf003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb5_d[l_ac].oohf003 = g_oohb5_d[l_ac].oohf003
                  NEXT FIELD oohf003
               END IF 
            END IF     
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohf003
            #add-point:ON CHANGE oohf003 name="input.g.page5.oohf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohf004
            #add-point:BEFORE FIELD oohf004 name="input.b.page5.oohf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohf004
            
            #add-point:AFTER FIELD oohf004 name="input.a.page5.oohf004"
            IF NOT cl_null(g_oohb5_d[l_ac].oohf004) THEN
               IF g_oohb5_d[l_ac].oohf003 > g_oohb5_d[l_ac].oohf004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb5_d[l_ac].oohf004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb5_d[l_ac].oohf004 = g_oohb5_d[l_ac].oohf004
                  NEXT FIELD oohf004
               END IF
            END IF                 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohf004
            #add-point:ON CHANGE oohf004 name="input.g.page5.oohf004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.oohf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohf002
            #add-point:ON ACTION controlp INFIELD oohf002 name="input.c.page5.oohf002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb5_d[l_ac].oohf002  #給予default值
            #給予arg
            LET g_qryparam.arg1 = "251"                        #應用分類
            CALL q_oocq002()                                   #呼叫開窗
            LET g_oohb5_d[l_ac].oohf002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_oohb5_d[l_ac].oohf002 TO oohf002         #顯示到畫面上
            NEXT FIELD oohf002                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page5.oohf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohf003
            #add-point:ON ACTION controlp INFIELD oohf003 name="input.c.page5.oohf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.oohf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohf004
            #add-point:ON ACTION controlp INFIELD oohf004 name="input.c.page5.oohf004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page7 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb5_d[l_ac].* = g_oohb5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl7
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohf_t","'7'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page7 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb5_d[li_reproduce_target].* = g_oohb5_d[li_reproduce].*
 
               LET g_oohb5_d[li_reproduce_target].oohf002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb5_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_8)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body6.before_input2"
            IF g_ooha_m.ooha002 MATCHES "[0125]" THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb6_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'8',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb6_d.getLength()
            #add-point:資料輸入前 name="input.body6.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb6_d[l_ac].* TO NULL 
            INITIALIZE g_oohb6_d_t.* TO NULL 
            INITIALIZE g_oohb6_d_o.* TO NULL 
            #公用欄位給值(單身8)
            
            #自定義預設值(單身8)
            
            #add-point:modify段before備份 name="input.body6.insert.before_bak"
            
            #end add-point
            LET g_oohb6_d_t.* = g_oohb6_d[l_ac].*     #新輸入資料
            LET g_oohb6_d_o.* = g_oohb6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body6.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb6_d[li_reproduce_target].* = g_oohb6_d[li_reproduce].*
 
               LET g_oohb6_d[li_reproduce_target].oohg002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body6.before_insert"
            INITIALIZE g_oohb6_d_t.* TO NULL
            LET g_oohb6_d[l_ac].oohg003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body6.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[8] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 8
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb6_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb6_d[l_ac].oohg002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb6_d_t.* = g_oohb6_d[l_ac].*  #BACKUP
               LET g_oohb6_d_o.* = g_oohb6_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body6.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohg_t","'8'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl8 INTO g_oohb6_d[l_ac].oohg002,g_oohb6_d[l_ac].oohg003,g_oohb6_d[l_ac].oohg004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb6_d_mask_o[l_ac].* =  g_oohb6_d[l_ac].*
                  CALL aooi380_oohg_t_mask()
                  LET g_oohb6_d_mask_n[l_ac].* =  g_oohb6_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body6.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body6.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body6.b_delete_ask"
               
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
               
               #add-point:單身8刪除前 name="input.body6.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb6_d_t.oohg002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohg_t',gs_keys,"'8'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身8刪除中 name="input.body6.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身8刪除後 name="input.body6.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body6.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb6_d.getLength() + 1) THEN
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
               
            #add-point:單身8新增前 name="input.body6.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohg_t 
             WHERE oohgent = g_enterprise AND oohg001 = g_ooha_m.ooha001
               AND oohg002 = g_oohb6_d[l_ac].oohg002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身8新增前 name="input.body6.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb6_d[g_detail_idx].oohg002
               CALL aooi380_insert_b('oohg_t',gs_keys,"'8'")
                           
               #add-point:單身新增後8 name="input.body6.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body6.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb6_d[l_ac].* = g_oohb6_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl8
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
               LET g_oohb6_d[l_ac].* = g_oohb6_d_t.*
            ELSE
               #add-point:單身page8修改前 name="input.body6.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身8)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohg_t_mask_restore('restore_mask_o')
                              
               UPDATE oohg_t SET (oohg001,oohg002,oohg003,oohg004) = (g_ooha_m.ooha001,g_oohb6_d[l_ac].oohg002, 
                   g_oohb6_d[l_ac].oohg003,g_oohb6_d[l_ac].oohg004) #自訂欄位頁簽
                WHERE oohgent = g_enterprise AND oohg001 = g_ooha_m.ooha001
                  AND oohg002 = g_oohb6_d_t.oohg002 #項次 
                  
               #add-point:單身page8修改中 name="input.body6.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb6_d[l_ac].* = g_oohb6_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb6_d[l_ac].* = g_oohb6_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb6_d[g_detail_idx].oohg002
               LET gs_keys_bak[2] = g_oohb6_d_t.oohg002
               CALL aooi380_update_b('oohg_t',gs_keys,gs_keys_bak,"'8'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb6_d[g_detail_idx].oohg002 = g_oohb6_d_t.oohg002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb6_d_t.oohg002
                  CALL aooi380_key_update_b(gs_keys,'oohg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb6_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb6_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page8修改後 name="input.body6.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohg002
            
            #add-point:AFTER FIELD oohg002 name="input.a.page6.oohg002"
            #此段落由子樣板a05產生
            DISPLAY '' TO s_detail6[l_ac].oohg002_desc
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb6_d[l_ac].oohg002) THEN 
               #厂商资料检查
               CALL aooi380_oohe002_chk('1',g_oohb6_d[l_ac].oohg002)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_oohb6_d[l_ac].oohg002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb6_d[l_ac].oohg002 = g_oohb6_d_t.oohg002                  
                  CALL aooi380_oohe002_desc(g_oohb6_d[l_ac].oohg002) RETURNING g_oohb6_d[l_ac].oohg002_desc
                  DISPLAY BY NAME g_oohb6_d[l_ac].oohg002_desc
                  NEXT FIELD CURRENT
               END IF 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb6_d[l_ac].oohg002 != g_oohb6_d_t.oohg002))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oohg_t WHERE "||"oohgent = '" ||g_enterprise|| "' AND "||"oohg001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohg002 = '"||g_oohb6_d[l_ac].oohg002 ||"'",'std-00004',0) THEN 
                     LET g_oohb6_d[l_ac].oohg002 = g_oohb6_d_t.oohg002                  
                     CALL aooi380_oohe002_desc(g_oohb6_d[l_ac].oohg002) RETURNING g_oohb6_d[l_ac].oohg002_desc
                     DISPLAY BY NAME g_oohb6_d[l_ac].oohg002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aooi380_oohe002_desc(g_oohb6_d[l_ac].oohg002) RETURNING g_oohb6_d[l_ac].oohg002_desc
            DISPLAY BY NAME g_oohb6_d[l_ac].oohg002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohg002
            #add-point:BEFORE FIELD oohg002 name="input.b.page6.oohg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohg002
            #add-point:ON CHANGE oohg002 name="input.g.page6.oohg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohg003
            #add-point:BEFORE FIELD oohg003 name="input.b.page6.oohg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohg003
            
            #add-point:AFTER FIELD oohg003 name="input.a.page6.oohg003"
            IF NOT cl_null(g_oohb6_d[l_ac].oohg004) THEN
               IF g_oohb6_d[l_ac].oohg003 > g_oohb6_d[l_ac].oohg004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb6_d[l_ac].oohg003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb6_d[l_ac].oohg003 = g_oohb6_d_t.oohg003
                  NEXT FIELD oohg003
               END IF 
            END IF     
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohg003
            #add-point:ON CHANGE oohg003 name="input.g.page6.oohg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohg004
            #add-point:BEFORE FIELD oohg004 name="input.b.page6.oohg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohg004
            
            #add-point:AFTER FIELD oohg004 name="input.a.page6.oohg004"
            IF NOT cl_null(g_oohb6_d[l_ac].oohg004) THEN
               IF g_oohb6_d[l_ac].oohg003 > g_oohb6_d[l_ac].oohg004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb6_d[l_ac].oohg004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb6_d[l_ac].oohg004 = g_oohb6_d_t.oohg004
                  NEXT FIELD oohg004
               END IF 
            END IF     
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohg004
            #add-point:ON CHANGE oohg004 name="input.g.page6.oohg004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page6.oohg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohg002
            #add-point:ON ACTION controlp INFIELD oohg002 name="input.c.page6.oohg002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb6_d[l_ac].oohg002  #給予default值
            #LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "    #160913-00055#3
            CALL q_pmaa001()                                   #呼叫開窗
            LET g_oohb6_d[l_ac].oohg002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_oohb6_d[l_ac].oohg002 TO oohg002         #顯示到畫面上
            NEXT FIELD oohg002                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page6.oohg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohg003
            #add-point:ON ACTION controlp INFIELD oohg003 name="input.c.page6.oohg003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.oohg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohg004
            #add-point:ON ACTION controlp INFIELD oohg004 name="input.c.page6.oohg004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page8 after_row name="input.body6.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb6_d[l_ac].* = g_oohb6_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl8
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohg_t","'8'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page8 after_row2 name="input.body6.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body6.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb6_d[li_reproduce_target].* = g_oohb6_d[li_reproduce].*
 
               LET g_oohb6_d[li_reproduce_target].oohg002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb6_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb6_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb7_d FROM s_detail7.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_9)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body7.before_input2"
            IF g_ooha_m.ooha002 = '0' THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb7_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'9',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb7_d.getLength()
            #add-point:資料輸入前 name="input.body7.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb7_d[l_ac].* TO NULL 
            INITIALIZE g_oohb7_d_t.* TO NULL 
            INITIALIZE g_oohb7_d_o.* TO NULL 
            #公用欄位給值(單身9)
            
            #自定義預設值(單身9)
            
            #add-point:modify段before備份 name="input.body7.insert.before_bak"
            
            #end add-point
            LET g_oohb7_d_t.* = g_oohb7_d[l_ac].*     #新輸入資料
            LET g_oohb7_d_o.* = g_oohb7_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body7.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb7_d[li_reproduce_target].* = g_oohb7_d[li_reproduce].*
 
               LET g_oohb7_d[li_reproduce_target].oohh002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body7.before_insert"
            INITIALIZE g_oohb7_d_t.* TO NULL
            LET g_oohb7_d[l_ac].oohh003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body7.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[9] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 9
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb7_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb7_d[l_ac].oohh002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb7_d_t.* = g_oohb7_d[l_ac].*  #BACKUP
               LET g_oohb7_d_o.* = g_oohb7_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body7.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohh_t","'9'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl9 INTO g_oohb7_d[l_ac].oohh002,g_oohb7_d[l_ac].oohh003,g_oohb7_d[l_ac].oohh004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb7_d_mask_o[l_ac].* =  g_oohb7_d[l_ac].*
                  CALL aooi380_oohh_t_mask()
                  LET g_oohb7_d_mask_n[l_ac].* =  g_oohb7_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body7.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body7.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body7.b_delete_ask"
               
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
               
               #add-point:單身9刪除前 name="input.body7.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb7_d_t.oohh002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohh_t',gs_keys,"'9'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身9刪除中 name="input.body7.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身9刪除後 name="input.body7.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body7.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb7_d.getLength() + 1) THEN
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
               
            #add-point:單身9新增前 name="input.body7.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohh_t 
             WHERE oohhent = g_enterprise AND oohh001 = g_ooha_m.ooha001
               AND oohh002 = g_oohb7_d[l_ac].oohh002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身9新增前 name="input.body7.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb7_d[g_detail_idx].oohh002
               CALL aooi380_insert_b('oohh_t',gs_keys,"'9'")
                           
               #add-point:單身新增後9 name="input.body7.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body7.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb7_d[l_ac].* = g_oohb7_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl9
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
               LET g_oohb7_d[l_ac].* = g_oohb7_d_t.*
            ELSE
               #add-point:單身page9修改前 name="input.body7.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身9)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohh_t_mask_restore('restore_mask_o')
                              
               UPDATE oohh_t SET (oohh001,oohh002,oohh003,oohh004) = (g_ooha_m.ooha001,g_oohb7_d[l_ac].oohh002, 
                   g_oohb7_d[l_ac].oohh003,g_oohb7_d[l_ac].oohh004) #自訂欄位頁簽
                WHERE oohhent = g_enterprise AND oohh001 = g_ooha_m.ooha001
                  AND oohh002 = g_oohb7_d_t.oohh002 #項次 
                  
               #add-point:單身page9修改中 name="input.body7.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb7_d[l_ac].* = g_oohb7_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb7_d[l_ac].* = g_oohb7_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb7_d[g_detail_idx].oohh002
               LET gs_keys_bak[2] = g_oohb7_d_t.oohh002
               CALL aooi380_update_b('oohh_t',gs_keys,gs_keys_bak,"'9'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb7_d[g_detail_idx].oohh002 = g_oohb7_d_t.oohh002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb7_d_t.oohh002
                  CALL aooi380_key_update_b(gs_keys,'oohh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb7_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb7_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page9修改後 name="input.body7.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohh002
            
            #add-point:AFTER FIELD oohh002 name="input.a.page7.oohh002"
            #此段落由子樣板a05產生
            DISPLAY '' TO s_detail7[l_ac].oohh002_desc
            IF  NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb7_d[l_ac].oohh002) THEN 
               #資料檢查
               CALL aooi380_oohh002_chk(g_oohb7_d[l_ac].oohh002) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_oohb7_d[l_ac].oohh002
                  #160318-00005#31  By 07900 --add-str
                  LET g_errparam.replace[1] ='arti202'
                  LET g_errparam.replace[2] = cl_get_progname("arti202",g_lang,"2")
                  LET g_errparam.exeprog ='arti202'
                 #160318-00005#31  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb7_d[l_ac].oohh002 = g_oohb7_d_t.oohh002
                  CALL aooi380_oohh002_desc(g_oohb7_d[l_ac].oohh002) RETURNING g_oohb7_d[l_ac].oohh002_desc
                  DISPLAY BY NAME g_oohb7_d[l_ac].oohh002_desc
                  NEXT FIELD oohh002
               END IF 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb7_d[l_ac].oohh002 != g_oohb7_d_t.oohh002))) THEN 
                  IF NOT ap_chk_notDup(g_oohb7_d[l_ac].oohh002,"SELECT COUNT(*) FROM oohh_t WHERE "||"oohhent = '" ||g_enterprise|| "' AND "||"oohh001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohh002 = '"||g_oohb7_d[l_ac].oohh002 ||"'",'std-00004',0) THEN 
                     LET g_oohb7_d[l_ac].oohh002 = g_oohb7_d_t.oohh002
                     CALL aooi380_oohh002_desc(g_oohb7_d[l_ac].oohh002) RETURNING g_oohb7_d[l_ac].oohh002_desc
                     DISPLAY BY NAME g_oohb7_d[l_ac].oohh002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aooi380_oohh002_desc(g_oohb7_d[l_ac].oohh002) RETURNING g_oohb7_d[l_ac].oohh002_desc
            DISPLAY BY NAME g_oohb7_d[l_ac].oohh002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohh002
            #add-point:BEFORE FIELD oohh002 name="input.b.page7.oohh002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohh002
            #add-point:ON CHANGE oohh002 name="input.g.page7.oohh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohh003
            #add-point:BEFORE FIELD oohh003 name="input.b.page7.oohh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohh003
            
            #add-point:AFTER FIELD oohh003 name="input.a.page7.oohh003"
             IF NOT cl_null(g_oohb7_d[l_ac].oohh004) THEN
               IF g_oohb7_d[l_ac].oohh003 > g_oohb7_d[l_ac].oohh004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb7_d[l_ac].oohh003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb7_d[l_ac].oohh003 = g_oohb7_d_t.oohh003
                  NEXT FIELD oohh003
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohh003
            #add-point:ON CHANGE oohh003 name="input.g.page7.oohh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohh004
            #add-point:BEFORE FIELD oohh004 name="input.b.page7.oohh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohh004
            
            #add-point:AFTER FIELD oohh004 name="input.a.page7.oohh004"
            IF NOT cl_null(g_oohb7_d[l_ac].oohh004) THEN
               IF g_oohb7_d[l_ac].oohh003 > g_oohb7_d[l_ac].oohh004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb7_d[l_ac].oohh004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb7_d[l_ac].oohh004 = g_oohb7_d_t.oohh004
                  NEXT FIELD oohh004
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohh004
            #add-point:ON CHANGE oohh004 name="input.g.page7.oohh004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page7.oohh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohh002
            #add-point:ON ACTION controlp INFIELD oohh002 name="input.c.page7.oohh002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb7_d[l_ac].oohh002  #給予default值
            CALL q_rtax001_1()                                 #呼叫開窗
            LET g_oohb7_d[l_ac].oohh002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_oohb7_d[l_ac].oohh002 TO oohh002         #顯示到畫面上
            NEXT FIELD oohh002                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page7.oohh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohh003
            #add-point:ON ACTION controlp INFIELD oohh003 name="input.c.page7.oohh003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.oohh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohh004
            #add-point:ON ACTION controlp INFIELD oohh004 name="input.c.page7.oohh004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page9 after_row name="input.body7.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb7_d[l_ac].* = g_oohb7_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl9
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohh_t","'9'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page9 after_row2 name="input.body7.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body7.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb7_d[li_reproduce_target].* = g_oohb7_d[li_reproduce].*
 
               LET g_oohb7_d[li_reproduce_target].oohh002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb7_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb7_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb8_d FROM s_detail8.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_10)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body8.before_input2"
            IF g_ooha_m.ooha002 = '0' THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb8_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'10',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb8_d.getLength()
            #add-point:資料輸入前 name="input.body8.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb8_d[l_ac].* TO NULL 
            INITIALIZE g_oohb8_d_t.* TO NULL 
            INITIALIZE g_oohb8_d_o.* TO NULL 
            #公用欄位給值(單身10)
            
            #自定義預設值(單身10)
            
            #add-point:modify段before備份 name="input.body8.insert.before_bak"
            
            #end add-point
            LET g_oohb8_d_t.* = g_oohb8_d[l_ac].*     #新輸入資料
            LET g_oohb8_d_o.* = g_oohb8_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body8.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb8_d[li_reproduce_target].* = g_oohb8_d[li_reproduce].*
 
               LET g_oohb8_d[li_reproduce_target].oohi002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body8.before_insert"
            INITIALIZE g_oohb8_d_t.* TO NULL             
            LET g_oohb8_d[l_ac].oohi003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body8.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[10] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 10
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb8_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb8_d[l_ac].oohi002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb8_d_t.* = g_oohb8_d[l_ac].*  #BACKUP
               LET g_oohb8_d_o.* = g_oohb8_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body8.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohi_t","'10'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl10 INTO g_oohb8_d[l_ac].oohi002,g_oohb8_d[l_ac].oohi003,g_oohb8_d[l_ac].oohi004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb8_d_mask_o[l_ac].* =  g_oohb8_d[l_ac].*
                  CALL aooi380_oohi_t_mask()
                  LET g_oohb8_d_mask_n[l_ac].* =  g_oohb8_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body8.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body8.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body8.b_delete_ask"
               
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
               
               #add-point:單身10刪除前 name="input.body8.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb8_d_t.oohi002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohi_t',gs_keys,"'10'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohi_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身10刪除中 name="input.body8.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身10刪除後 name="input.body8.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body8.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb8_d.getLength() + 1) THEN
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
               
            #add-point:單身10新增前 name="input.body8.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohi_t 
             WHERE oohient = g_enterprise AND oohi001 = g_ooha_m.ooha001
               AND oohi002 = g_oohb8_d[l_ac].oohi002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身10新增前 name="input.body8.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb8_d[g_detail_idx].oohi002
               CALL aooi380_insert_b('oohi_t',gs_keys,"'10'")
                           
               #add-point:單身新增後10 name="input.body8.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohi_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body8.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb8_d[l_ac].* = g_oohb8_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl10
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
               LET g_oohb8_d[l_ac].* = g_oohb8_d_t.*
            ELSE
               #add-point:單身page10修改前 name="input.body8.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身10)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohi_t_mask_restore('restore_mask_o')
                              
               UPDATE oohi_t SET (oohi001,oohi002,oohi003,oohi004) = (g_ooha_m.ooha001,g_oohb8_d[l_ac].oohi002, 
                   g_oohb8_d[l_ac].oohi003,g_oohb8_d[l_ac].oohi004) #自訂欄位頁簽
                WHERE oohient = g_enterprise AND oohi001 = g_ooha_m.ooha001
                  AND oohi002 = g_oohb8_d_t.oohi002 #項次 
                  
               #add-point:單身page10修改中 name="input.body8.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb8_d[l_ac].* = g_oohb8_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohi_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb8_d[l_ac].* = g_oohb8_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohi_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb8_d[g_detail_idx].oohi002
               LET gs_keys_bak[2] = g_oohb8_d_t.oohi002
               CALL aooi380_update_b('oohi_t',gs_keys,gs_keys_bak,"'10'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohi_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb8_d[g_detail_idx].oohi002 = g_oohb8_d_t.oohi002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb8_d_t.oohi002
                  CALL aooi380_key_update_b(gs_keys,'oohi_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb8_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb8_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page10修改後 name="input.body8.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi002
            
            #add-point:AFTER FIELD oohi002 name="input.a.page8.oohi002"
            #此段落由子樣板a05產生
            DISPLAY '' TO s_detail8[l_ac].oohi002_desc
            IF  NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb8_d[l_ac].oohi002) THEN
               #檢查產品資料的存在及有效性
               CALL aooi380_oohi002_chk(g_oohb8_d[l_ac].oohi002)
                IF NOT cl_null(g_errno) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = g_oohb8_d[l_ac].oohi002
                   #160318-00005#31  By 07900 --add-str
                   LET g_errparam.replace[1] ='aimm200'
                   LET g_errparam.replace[2] = cl_get_progname("aimm200",g_lang,"2")
                   LET g_errparam.exeprog ='aimm200'
                   #160318-00005#31  By 07900 --add-end
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   LET g_oohb8_d[l_ac].oohi002 = g_oohb8_d_t.oohi002
                   CALL aooi380_oohi002_desc(g_oohb8_d[l_ac].oohi002) RETURNING g_oohb8_d[l_ac].oohi002_desc,g_oohb8_d[l_ac].oohi002_desc2
                   DISPLAY BY NAME g_oohb8_d[l_ac].oohi002_desc
                   DISPLAY BY NAME g_oohb8_d[l_ac].oohi002_desc2
                   NEXT FIELD oohi002
               END IF                   
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb8_d[l_ac].oohi002 != g_oohb8_d_t.oohi002))) THEN 
                  IF NOT ap_chk_notDup(g_oohb8_d[l_ac].oohi002,"SELECT COUNT(*) FROM oohi_t WHERE "||"oohient = '" ||g_enterprise|| "' AND "||"oohi001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohi002 = '"||g_oohb8_d[l_ac].oohi002 ||"'",'std-00004',0) THEN 
                     LET g_oohb8_d[l_ac].oohi002 = g_oohb8_d_t.oohi002
                     CALL aooi380_oohi002_desc(g_oohb8_d[l_ac].oohi002) RETURNING g_oohb8_d[l_ac].oohi002_desc,g_oohb8_d[l_ac].oohi002_desc2
                     DISPLAY BY NAME g_oohb8_d[l_ac].oohi002_desc
                     DISPLAY BY NAME g_oohb8_d[l_ac].oohi002_desc2                    
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aooi380_oohi002_desc(g_oohb8_d[l_ac].oohi002) RETURNING g_oohb8_d[l_ac].oohi002_desc,g_oohb8_d[l_ac].oohi002_desc2
            DISPLAY BY NAME g_oohb8_d[l_ac].oohi002_desc
            DISPLAY BY NAME g_oohb8_d[l_ac].oohi002_desc2    

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi002
            #add-point:BEFORE FIELD oohi002 name="input.b.page8.oohi002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohi002
            #add-point:ON CHANGE oohi002 name="input.g.page8.oohi002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi002_desc
            #add-point:BEFORE FIELD oohi002_desc name="input.b.page8.oohi002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi002_desc
            
            #add-point:AFTER FIELD oohi002_desc name="input.a.page8.oohi002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohi002_desc
            #add-point:ON CHANGE oohi002_desc name="input.g.page8.oohi002_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi002_desc2
            #add-point:BEFORE FIELD oohi002_desc2 name="input.b.page8.oohi002_desc2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi002_desc2
            
            #add-point:AFTER FIELD oohi002_desc2 name="input.a.page8.oohi002_desc2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohi002_desc2
            #add-point:ON CHANGE oohi002_desc2 name="input.g.page8.oohi002_desc2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi003
            #add-point:BEFORE FIELD oohi003 name="input.b.page8.oohi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi003
            
            #add-point:AFTER FIELD oohi003 name="input.a.page8.oohi003"
            IF NOT cl_null(g_oohb8_d[l_ac].oohi004) THEN
               IF g_oohb8_d[l_ac].oohi003 > g_oohb8_d[l_ac].oohi004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb8_d[l_ac].oohi003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb8_d[l_ac].oohi003 = g_oohb8_d[l_ac].oohi003
                  NEXT FIELD oohi003
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohi003
            #add-point:ON CHANGE oohi003 name="input.g.page8.oohi003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohi004
            #add-point:BEFORE FIELD oohi004 name="input.b.page8.oohi004"
          
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohi004
            
            #add-point:AFTER FIELD oohi004 name="input.a.page8.oohi004"
            IF NOT cl_null(g_oohb8_d[l_ac].oohi004) THEN
               IF g_oohb8_d[l_ac].oohi003 > g_oohb8_d[l_ac].oohi004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb8_d[l_ac].oohi004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb8_d[l_ac].oohi004 = g_oohb8_d[l_ac].oohi004
                  NEXT FIELD oohi004
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohi004
            #add-point:ON CHANGE oohi004 name="input.g.page8.oohi004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page8.oohi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi002
            #add-point:ON ACTION controlp INFIELD oohi002 name="input.c.page8.oohi002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb8_d[l_ac].oohi002  #給予default值
           #CALL q_imaa001_1()                           #呼叫開窗  #160731-00647#1 mark
            CALL q_imaa001_10()                                    #160731-00647#1 add
            LET g_oohb8_d[l_ac].oohi002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_oohb8_d[l_ac].oohi002 TO oohi002         #顯示到畫面上
            NEXT FIELD oohi002                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page8.oohi002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi002_desc
            #add-point:ON ACTION controlp INFIELD oohi002_desc name="input.c.page8.oohi002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.oohi002_desc2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi002_desc2
            #add-point:ON ACTION controlp INFIELD oohi002_desc2 name="input.c.page8.oohi002_desc2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.oohi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi003
            #add-point:ON ACTION controlp INFIELD oohi003 name="input.c.page8.oohi003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page8.oohi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohi004
            #add-point:ON ACTION controlp INFIELD oohi004 name="input.c.page8.oohi004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page10 after_row name="input.body8.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb8_d[l_ac].* = g_oohb8_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl10
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohi_t","'10'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page10 after_row2 name="input.body8.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body8.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb8_d[li_reproduce_target].* = g_oohb8_d[li_reproduce].*
 
               LET g_oohb8_d[li_reproduce_target].oohi002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb8_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb8_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_oohb9_d FROM s_detail9.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_11)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body9.before_input2"
            IF g_ooha_m.ooha002 MATCHES "[0156]" THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_oohb9_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi380_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'11',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_oohb9_d.getLength()
            #add-point:資料輸入前 name="input.body9.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oohb9_d[l_ac].* TO NULL 
            INITIALIZE g_oohb9_d_t.* TO NULL 
            INITIALIZE g_oohb9_d_o.* TO NULL 
            #公用欄位給值(單身11)
            
            #自定義預設值(單身11)
            
            #add-point:modify段before備份 name="input.body9.insert.before_bak"
            
            #end add-point
            LET g_oohb9_d_t.* = g_oohb9_d[l_ac].*     #新輸入資料
            LET g_oohb9_d_o.* = g_oohb9_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi380_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body9.insert.after_set_entry_b"
            
            #end add-point
            CALL aooi380_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_oohb9_d[li_reproduce_target].* = g_oohb9_d[li_reproduce].*
 
               LET g_oohb9_d[li_reproduce_target].oohj002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body9.before_insert"
            INITIALIZE g_oohb9_d_t.* TO NULL            
            LET g_oohb9_d[l_ac].oohj003 = g_today
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body9.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[11] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 11
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aooi380_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_oohb9_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_oohb9_d[l_ac].oohj002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_oohb9_d_t.* = g_oohb9_d[l_ac].*  #BACKUP
               LET g_oohb9_d_o.* = g_oohb9_d[l_ac].*  #BACKUP
               CALL aooi380_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body9.after_set_entry_b"
               
               #end add-point  
               CALL aooi380_set_no_entry_b(l_cmd)
               IF NOT aooi380_lock_b("oohj_t","'11'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi380_bcl11 INTO g_oohb9_d[l_ac].oohj002,g_oohb9_d[l_ac].oohj003,g_oohb9_d[l_ac].oohj004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_oohb9_d_mask_o[l_ac].* =  g_oohb9_d[l_ac].*
                  CALL aooi380_oohj_t_mask()
                  LET g_oohb9_d_mask_n[l_ac].* =  g_oohb9_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aooi380_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body9.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body9.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body9.b_delete_ask"
               
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
               
               #add-point:單身11刪除前 name="input.body9.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_ooha_m.ooha001
               LET gs_keys[gs_keys.getLength()+1] = g_oohb9_d_t.oohj002
            
               #刪除同層單身
               IF NOT aooi380_delete_b('oohj_t',gs_keys,"'11'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aooi380_key_delete_b(gs_keys,'oohj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aooi380_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身11刪除中 name="input.body9.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aooi380_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身11刪除後 name="input.body9.a_delete"
               
               #end add-point
               LET l_count = g_oohb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body9.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_oohb9_d.getLength() + 1) THEN
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
               
            #add-point:單身11新增前 name="input.body9.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM oohj_t 
             WHERE oohjent = g_enterprise AND oohj001 = g_ooha_m.ooha001
               AND oohj002 = g_oohb9_d[l_ac].oohj002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身11新增前 name="input.body9.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys[2] = g_oohb9_d[g_detail_idx].oohj002
               CALL aooi380_insert_b('oohj_t',gs_keys,"'11'")
                           
               #add-point:單身新增後11 name="input.body9.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_oohb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "oohj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi380_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body9.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oohb9_d[l_ac].* = g_oohb9_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl11
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
               LET g_oohb9_d[l_ac].* = g_oohb9_d_t.*
            ELSE
               #add-point:單身page11修改前 name="input.body9.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身11)
               
               
               #將遮罩欄位還原
               CALL aooi380_oohj_t_mask_restore('restore_mask_o')
                              
               UPDATE oohj_t SET (oohj001,oohj002,oohj003,oohj004) = (g_ooha_m.ooha001,g_oohb9_d[l_ac].oohj002, 
                   g_oohb9_d[l_ac].oohj003,g_oohb9_d[l_ac].oohj004) #自訂欄位頁簽
                WHERE oohjent = g_enterprise AND oohj001 = g_ooha_m.ooha001
                  AND oohj002 = g_oohb9_d_t.oohj002 #項次 
                  
               #add-point:單身page11修改中 name="input.body9.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_oohb9_d[l_ac].* = g_oohb9_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_oohb9_d[l_ac].* = g_oohb9_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "oohj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooha_m.ooha001
               LET gs_keys_bak[1] = g_ooha001_t
               LET gs_keys[2] = g_oohb9_d[g_detail_idx].oohj002
               LET gs_keys_bak[2] = g_oohb9_d_t.oohj002
               CALL aooi380_update_b('oohj_t',gs_keys,gs_keys_bak,"'11'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aooi380_oohj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_oohb9_d[g_detail_idx].oohj002 = g_oohb9_d_t.oohj002 
                  ) THEN
                  LET gs_keys[01] = g_ooha_m.ooha001
                  LET gs_keys[gs_keys.getLength()+1] = g_oohb9_d_t.oohj002
                  CALL aooi380_key_update_b(gs_keys,'oohj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb9_d_t)
               LET g_log2 = util.JSON.stringify(g_ooha_m),util.JSON.stringify(g_oohb9_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page11修改後 name="input.body9.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohj002
            
            #add-point:AFTER FIELD oohj002 name="input.a.page9.oohj002"
            #此段落由子樣板a05產生
            DISPLAY '' TO s_detail9[l_ac].oohj002_desc
            IF NOT cl_null(g_ooha_m.ooha001) AND NOT cl_null(g_oohb9_d[l_ac].oohj002) THEN
               #渠道資料檢查
               CALL aooi380_ooef001_chk(g_oohb9_d[l_ac].oohj002)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_oohb9_d[l_ac].oohj002
                  #160318-00005#31  By 07900 --add-str
                  LET g_errparam.replace[1] ='aooi100'
                  LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                  LET g_errparam.exeprog ='aooi100'
                  #160318-00005#31  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb9_d[l_ac].oohj002 = g_oohb9_d_t.oohj002
                  CALL aooi380_ooef001_desc(g_oohb9_d[l_ac].oohj002) RETURNING g_oohb9_d[l_ac].oohj002_desc
                  DISPLAY BY NAME g_oohb9_d[l_ac].oohj002_desc
                  NEXT FIELD oohj002_desc 
               END IF 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooha_m.ooha001 != g_ooha001_t OR g_oohb9_d[l_ac].oohj002 != g_oohb9_d_t.oohj002))) THEN 
                  IF NOT ap_chk_notDup(g_oohb9_d[l_ac].oohj002,"SELECT COUNT(*) FROM oohj_t WHERE "||"oohjent = '" ||g_enterprise|| "' AND "||"oohj001 = '"||g_ooha_m.ooha001 ||"' AND "|| "oohj002 = '"||g_oohb9_d[l_ac].oohj002 ||"'",'std-00004',0) THEN 
                     LET g_oohb9_d[l_ac].oohj002 = g_oohb9_d_t.oohj002
                     CALL aooi380_ooef001_desc(g_oohb9_d[l_ac].oohj002) RETURNING g_oohb9_d[l_ac].oohj002_desc
                     DISPLAY BY NAME g_oohb9_d[l_ac].oohj002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL aooi380_ooef001_desc(g_oohb9_d[l_ac].oohj002) RETURNING g_oohb9_d[l_ac].oohj002_desc
            DISPLAY BY NAME g_oohb9_d[l_ac].oohj002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohj002
            #add-point:BEFORE FIELD oohj002 name="input.b.page9.oohj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohj002
            #add-point:ON CHANGE oohj002 name="input.g.page9.oohj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohj003
            #add-point:BEFORE FIELD oohj003 name="input.b.page9.oohj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohj003
            
            #add-point:AFTER FIELD oohj003 name="input.a.page9.oohj003"
            IF NOT cl_null(g_oohb9_d[l_ac].oohj004) THEN
               IF g_oohb9_d[l_ac].oohj003 > g_oohb9_d[l_ac].oohj004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb9_d[l_ac].oohj003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb9_d[l_ac].oohj003 = g_oohb9_d_t.oohj003
                  NEXT FIELD oohj003
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohj003
            #add-point:ON CHANGE oohj003 name="input.g.page9.oohj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oohj004
            #add-point:BEFORE FIELD oohj004 name="input.b.page9.oohj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oohj004
            
            #add-point:AFTER FIELD oohj004 name="input.a.page9.oohj004"
            IF NOT cl_null(g_oohb9_d[l_ac].oohj004) THEN
               IF g_oohb9_d[l_ac].oohj003 > g_oohb9_d[l_ac].oohj004 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '-9913'
                  LET g_errparam.extend = g_oohb9_d[l_ac].oohj004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oohb9_d[l_ac].oohj004 = g_oohb9_d_t.oohj004
                  NEXT FIELD oohj004
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oohj004
            #add-point:ON CHANGE oohj004 name="input.g.page9.oohj004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page9.oohj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohj002
            #add-point:ON ACTION controlp INFIELD oohj002 name="input.c.page9.oohj002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oohb9_d[l_ac].oohj002  #給予default值
#            CALL q_ooef001_14()                                   #呼叫開窗 #161019-00017#9 marked
            CALL q_ooef001_1()                                   #呼叫開窗 #161019-00017#9 add
            LET g_oohb9_d[l_ac].oohj002 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_oohb9_d[l_ac].oohj002 TO oohj002         #顯示到畫面上
            CALL aooi380_ooef001_desc(g_oohb9_d[l_ac].oohj002) RETURNING g_oohb9_d[l_ac].oohj002_desc
            DISPLAY BY NAME g_oohb9_d[l_ac].oohj002_desc
            NEXT FIELD oohj002                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page9.oohj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohj003
            #add-point:ON ACTION controlp INFIELD oohj003 name="input.c.page9.oohj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page9.oohj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oohj004
            #add-point:ON ACTION controlp INFIELD oohj004 name="input.c.page9.oohj004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page11 after_row name="input.body9.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oohb9_d[l_ac].* = g_oohb9_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aooi380_bcl11
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aooi380_unlock_b("oohj_t","'11'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page11 after_row2 name="input.body9.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body9.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_oohb9_d[li_reproduce_target].* = g_oohb9_d[li_reproduce].*
 
               LET g_oohb9_d[li_reproduce_target].oohj002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_oohb9_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_oohb9_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aooi380.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' AND cl_null(g_ooha002_p) THEN
            NEXT FIELD ooha002
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail10",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail11",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'4',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'5',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'6',"))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'7',"))
         CALL DIALOG.setCurrentRow("s_detail6",g_idx_group.getValue("'8',"))
         CALL DIALOG.setCurrentRow("s_detail7",g_idx_group.getValue("'9',"))
         CALL DIALOG.setCurrentRow("s_detail8",g_idx_group.getValue("'10',"))
         CALL DIALOG.setCurrentRow("s_detail9",g_idx_group.getValue("'11',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD ooha001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD oohb002
               WHEN "s_detail10"
                  NEXT FIELD oohk002
               WHEN "s_detail11"
                  NEXT FIELD oohl002
               WHEN "s_detail2"
                  NEXT FIELD oohc002
               WHEN "s_detail3"
                  NEXT FIELD oohd002
               WHEN "s_detail4"
                  NEXT FIELD oohe002
               WHEN "s_detail5"
                  NEXT FIELD oohf002
               WHEN "s_detail6"
                  NEXT FIELD oohg002
               WHEN "s_detail7"
                  NEXT FIELD oohh002
               WHEN "s_detail8"
                  NEXT FIELD oohi002
               WHEN "s_detail9"
                  NEXT FIELD oohj002
 
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
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
         LET g_detail_idx_list[7] = 1
         LET g_detail_idx_list[8] = 1
         LET g_detail_idx_list[9] = 1
         LET g_detail_idx_list[10] = 1
         LET g_detail_idx_list[11] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail10",1)
         CALL g_curr_diag.setCurrentRow("s_detail11",1)
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
         CALL g_curr_diag.setCurrentRow("s_detail7",1)
         CALL g_curr_diag.setCurrentRow("s_detail8",1)
         CALL g_curr_diag.setCurrentRow("s_detail9",1)
 
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
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
         LET g_detail_idx_list[7] = 1
         LET g_detail_idx_list[8] = 1
         LET g_detail_idx_list[9] = 1
         LET g_detail_idx_list[10] = 1
         LET g_detail_idx_list[11] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail10",1)
         CALL g_curr_diag.setCurrentRow("s_detail11",1)
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
         CALL g_curr_diag.setCurrentRow("s_detail7",1)
         CALL g_curr_diag.setCurrentRow("s_detail8",1)
         CALL g_curr_diag.setCurrentRow("s_detail9",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aooi380_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aooi380_b_fill() #單身填充
      CALL aooi380_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aooi380_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
  INITIALIZE g_ref_fields TO NULL
  LET g_ref_fields[1] = g_ooha_m.ooha001
  CALL ap_ref_array2(g_ref_fields," SELECT oohal003,oohal005 FROM oohal_t WHERE oohalent = '"||g_enterprise||"' AND oohal001 = ? AND oohal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
  LET g_ooha_m.oohal003 = g_rtn_fields[1] 
  LET g_ooha_m.oohal005 = g_rtn_fields[2] 
  DISPLAY BY NAME g_ooha_m.oohal003
  DISPLAY BY NAME g_ooha_m.oohal005
#  
#  INITIALIZE g_ref_fields TO NULL
#  LET g_ref_fields[1] = g_ooha_m.oohaownid
#  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#  LET g_ooha_m.oohaownid_desc =  g_rtn_fields[1] 
#  DISPLAY BY NAME g_ooha_m.oohaownid_desc
#
#  INITIALIZE g_ref_fields TO NULL
#  LET g_ref_fields[1] = g_ooha_m.oohaowndp
#  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#  LET g_ooha_m.oohaowndp_desc =  g_rtn_fields[1]
#  DISPLAY BY NAME g_ooha_m.oohaowndp_desc
#
#  INITIALIZE g_ref_fields TO NULL
#  LET g_ref_fields[1] = g_ooha_m.oohacrtid
#  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#  LET g_ooha_m.oohacrtid_desc = g_rtn_fields[1] 
#  DISPLAY BY NAME g_ooha_m.oohacrtid_desc
#
#  INITIALIZE g_ref_fields TO NULL
#  LET g_ref_fields[1] = g_ooha_m.oohacrtdp
#  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#  LET g_ooha_m.oohacrtdp_desc = g_rtn_fields[1] 
#  DISPLAY BY NAME g_ooha_m.oohacrtdp_desc
#
#  INITIALIZE g_ref_fields TO NULL
#  LET g_ref_fields[1] = g_ooha_m.oohamodid
#  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#  LET g_ooha_m.oohamodid_desc = g_rtn_fields[1] 
#  DISPLAY BY NAME g_ooha_m.oohamodid_desc
   #end add-point
   
   #遮罩相關處理
   LET g_ooha_m_mask_o.* =  g_ooha_m.*
   CALL aooi380_ooha_t_mask()
   LET g_ooha_m_mask_n.* =  g_ooha_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohal003,g_ooha_m.oohal005,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid, 
       g_ooha_m.oohacrtid_desc,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdp_desc,g_ooha_m.oohacrtdt,g_ooha_m.oohamodid, 
       g_ooha_m.oohamodid_desc,g_ooha_m.oohamoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooha_m.oohastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_oohb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#      CALL aooi380_oohb002_desc(g_oohb_d[l_ac].oohb002) RETURNING g_oohb_d[l_ac].oohb002_desc
#      DISPLAY BY NAME g_oohb_d[l_ac].oohb002
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_oohb10_d.getLength()
      #add-point:show段單身reference name="show.body10.reference"
#     #據點名稱
#     CALL aooi380_ooef001_desc(g_oohb10_d[l_ac].oohk002) RETURNING g_oohb10_d[l_ac].oohk002_desc
#     DISPLAY BY NAME g_oohb10_d[l_ac].oohk002_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb11_d.getLength()
      #add-point:show段單身reference name="show.body11.reference"
#     CALL aooi380_ooef001_desc(g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl002_desc
#     DISPLAY BY NAME g_oohb11_d[l_ac].oohl002_desc
#     CALL aooi380_oohl003_desc(g_oohb11_d[l_ac].oohl003,g_oohb11_d[l_ac].oohl002) RETURNING g_oohb11_d[l_ac].oohl003_desc
#     DISPLAY BY NAME g_oohb11_d[l_ac].oohl003_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      CALL aooi380_oohc002_desc(g_oohb2_d[l_ac].oohc002) RETURNING g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
      DISPLAY BY NAME g_oohb2_d[l_ac].oohc002_desc,g_oohb2_d[l_ac].oohc002_desc2
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
#     #客户分类说明
#      CALL aooi380_oohd002_desc(281,g_oohb3_d[l_ac].oohd002) RETURNING g_oohb3_d[l_ac].oohd002_desc
#      DISPLAY BY NAME g_oohb3_d[l_ac].oohd002_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
#     CALL aooi380_oohe002_desc(g_oohb4_d[l_ac].oohe002) RETURNING g_oohb4_d[l_ac].oohe002_desc
#     DISPLAY BY NAME g_oohb4_d[l_ac].oohe002_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
#     CALL aooi380_oohd002_desc(251,g_oohb5_d[l_ac].oohf002) RETURNING  g_oohb5_d[l_ac].oohf002_desc
#     DISPLAY BY NAME g_oohb5_d[l_ac].oohf002_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb6_d.getLength()
      #add-point:show段單身reference name="show.body6.reference"
#     CALL aooi380_oohe002_desc(g_oohb6_d[l_ac].oohg002) RETURNING g_oohb6_d[l_ac].oohg002_desc
#     DISPLAY BY NAME g_oohb6_d[l_ac].oohg002_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb7_d.getLength()
      #add-point:show段單身reference name="show.body7.reference"
#     CALL aooi380_oohh002_desc(g_oohb7_d[l_ac].oohh002) RETURNING g_oohb7_d[l_ac].oohh002_desc
#     DISPLAY BY NAME g_oohb7_d[l_ac].oohh002_desc        {#ADP版次:1#}  
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb8_d.getLength()
      #add-point:show段單身reference name="show.body8.reference"
#     CALL aooi380_oohi002_desc(g_oohb8_d[l_ac].oohi002) RETURNING g_oohb8_d[l_ac].oohi002_desc,g_oohb8_d[l_ac].oohi002_desc2
#     DISPLAY BY NAME g_oohb8_d[l_ac].oohi002_desc
#     DISPLAY BY NAME g_oohb8_d[l_ac].oohi002_desc2 
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_oohb9_d.getLength()
      #add-point:show段單身reference name="show.body9.reference"
#     CALL aooi380_ooef001_desc(g_oohb9_d[l_ac].oohj002) RETURNING g_oohb9_d[l_ac].oohj002_desc
#     DISPLAY BY NAME g_oohb9_d[l_ac].oohj002_desc    
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aooi380_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aooi380_detail_show()
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
 
{<section id="aooi380.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aooi380_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE ooha_t.ooha001 
   DEFINE l_oldno     LIKE ooha_t.ooha001 
 
   DEFINE l_master    RECORD LIKE ooha_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE oohb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE oohk_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE oohl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE oohc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE oohd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail6    RECORD LIKE oohe_t.* #此變數樣板目前無使用
 
   DEFINE l_detail7    RECORD LIKE oohf_t.* #此變數樣板目前無使用
 
   DEFINE l_detail8    RECORD LIKE oohg_t.* #此變數樣板目前無使用
 
   DEFINE l_detail9    RECORD LIKE oohh_t.* #此變數樣板目前無使用
 
   DEFINE l_detail10    RECORD LIKE oohi_t.* #此變數樣板目前無使用
 
   DEFINE l_detail11    RECORD LIKE oohj_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_sql      STRING
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
   
   IF g_ooha_m.ooha001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_ooha001_t = g_ooha_m.ooha001
 
    
   LET g_ooha_m.ooha001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_ooha_m.oohaownid = g_user
      LET g_ooha_m.oohaowndp = g_dept
      LET g_ooha_m.oohacrtid = g_user
      LET g_ooha_m.oohacrtdp = g_dept 
      LET g_ooha_m.oohacrtdt = cl_get_current()
      LET g_ooha_m.oohamodid = g_user
      LET g_ooha_m.oohamoddt = cl_get_current()
      LET g_ooha_m.oohastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_ooha_m.oohastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aooi380_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_ooha_m.* TO NULL
      INITIALIZE g_oohb_d TO NULL
      INITIALIZE g_oohb10_d TO NULL
      INITIALIZE g_oohb11_d TO NULL
      INITIALIZE g_oohb2_d TO NULL
      INITIALIZE g_oohb3_d TO NULL
      INITIALIZE g_oohb4_d TO NULL
      INITIALIZE g_oohb5_d TO NULL
      INITIALIZE g_oohb6_d TO NULL
      INITIALIZE g_oohb7_d TO NULL
      INITIALIZE g_oohb8_d TO NULL
      INITIALIZE g_oohb9_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aooi380_show()
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
   CALL aooi380_set_act_visible()   
   CALL aooi380_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_ooha001_t = g_ooha_m.ooha001
 
   
   #組合新增資料的條件
   LET g_add_browse = " oohaent = " ||g_enterprise|| " AND",
                      " ooha001 = '", g_ooha_m.ooha001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aooi380_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aooi380_idx_chk()
   
   LET g_data_owner = g_ooha_m.oohaownid      
   LET g_data_dept  = g_ooha_m.oohaowndp
   
   #功能已完成,通報訊息中心
   CALL aooi380_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aooi380_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE oohb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE oohk_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE oohl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE oohc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE oohd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail6    RECORD LIKE oohe_t.* #此變數樣板目前無使用
 
   DEFINE l_detail7    RECORD LIKE oohf_t.* #此變數樣板目前無使用
 
   DEFINE l_detail8    RECORD LIKE oohg_t.* #此變數樣板目前無使用
 
   DEFINE l_detail9    RECORD LIKE oohh_t.* #此變數樣板目前無使用
 
   DEFINE l_detail10    RECORD LIKE oohi_t.* #此變數樣板目前無使用
 
   DEFINE l_detail11    RECORD LIKE oohj_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aooi380_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohb_t
    WHERE oohbent = g_enterprise AND oohb001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail 
      #更新key欄位
      SET oohb001 = g_ooha_m.ooha001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO oohb_t SELECT * FROM aooi380_detail
   
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
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohk_t 
    WHERE oohkent = g_enterprise AND oohk001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohk001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohk_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohl_t 
    WHERE oohlent = g_enterprise AND oohl001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohl001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohl_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohc_t 
    WHERE oohcent = g_enterprise AND oohc001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohc001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohc_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table5.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohd_t 
    WHERE oohdent = g_enterprise AND oohd001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohd001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table5.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohd_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table5.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table5.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table6.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohe_t 
    WHERE ooheent = g_enterprise AND oohe001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohe001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table6.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohe_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table6.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table6.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table7.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohf_t 
    WHERE oohfent = g_enterprise AND oohf001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohf001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table7.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohf_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table7.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table7.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table8.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohg_t 
    WHERE oohgent = g_enterprise AND oohg001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohg001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table8.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohg_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table8.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table8.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table9.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohh_t 
    WHERE oohhent = g_enterprise AND oohh001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohh001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table9.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohh_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table9.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table9.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table10.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohi_t 
    WHERE oohient = g_enterprise AND oohi001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohi001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table10.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohi_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table10.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table10.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table11.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM oohj_t 
    WHERE oohjent = g_enterprise AND oohj001 = g_ooha001_t
 
    INTO TEMP aooi380_detail
 
   #將key修正為調整後   
   UPDATE aooi380_detail SET oohj001 = g_ooha_m.ooha001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table11.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO oohj_t SELECT * FROM aooi380_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table11.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aooi380_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table11.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_ooha001_t = g_ooha_m.ooha001
 
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aooi380_delete()
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
   
   IF g_ooha_m.ooha001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.oohal001 = g_ooha_m.ooha001
LET g_master_multi_table_t.oohal003 = g_ooha_m.oohal003
LET g_master_multi_table_t.oohal005 = g_ooha_m.oohal005
 
   
   CALL s_transaction_begin()
 
   OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi380_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aooi380_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aooi380_master_referesh USING g_ooha_m.ooha001 INTO g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdt, 
       g_ooha_m.oohamodid,g_ooha_m.oohamoddt,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid_desc, 
       g_ooha_m.oohacrtdp_desc,g_ooha_m.oohamodid_desc
   
   
   #檢查是否允許此動作
   IF NOT aooi380_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_ooha_m_mask_o.* =  g_ooha_m.*
   CALL aooi380_ooha_t_mask()
   LET g_ooha_m_mask_n.* =  g_ooha_m.*
   
   CALL aooi380_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aooi380_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_ooha001_t = g_ooha_m.ooha001
 
 
      DELETE FROM ooha_t
       WHERE oohaent = g_enterprise AND ooha001 = g_ooha_m.ooha001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_ooha_m.ooha001,":",SQLERRMESSAGE  
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
      
      DELETE FROM oohb_t
       WHERE oohbent = g_enterprise AND oohb001 = g_ooha_m.ooha001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohb_t:",SQLERRMESSAGE 
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
      DELETE FROM oohk_t
       WHERE oohkent = g_enterprise AND
             oohk001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohk_t:",SQLERRMESSAGE 
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
      DELETE FROM oohl_t
       WHERE oohlent = g_enterprise AND
             oohl001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohl_t:",SQLERRMESSAGE 
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
      DELETE FROM oohc_t
       WHERE oohcent = g_enterprise AND
             oohc001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete5"
      
      #end add-point
      DELETE FROM oohd_t
       WHERE oohdent = g_enterprise AND
             oohd001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete5"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete6"
      
      #end add-point
      DELETE FROM oohe_t
       WHERE ooheent = g_enterprise AND
             oohe001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete6"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete6"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete7"
      
      #end add-point
      DELETE FROM oohf_t
       WHERE oohfent = g_enterprise AND
             oohf001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete7"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete7"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete8"
      
      #end add-point
      DELETE FROM oohg_t
       WHERE oohgent = g_enterprise AND
             oohg001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete8"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete8"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete9"
      
      #end add-point
      DELETE FROM oohh_t
       WHERE oohhent = g_enterprise AND
             oohh001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete9"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete9"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete10"
      
      #end add-point
      DELETE FROM oohi_t
       WHERE oohient = g_enterprise AND
             oohi001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete10"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete10"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete11"
      
      #end add-point
      DELETE FROM oohj_t
       WHERE oohjent = g_enterprise AND
             oohj001 = g_ooha_m.ooha001
      #add-point:單身刪除中 name="delete.body.m_delete11"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete11"
 
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_ooha_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aooi380_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_oohb_d.clear() 
      CALL g_oohb10_d.clear()       
      CALL g_oohb11_d.clear()       
      CALL g_oohb2_d.clear()       
      CALL g_oohb3_d.clear()       
      CALL g_oohb4_d.clear()       
      CALL g_oohb5_d.clear()       
      CALL g_oohb6_d.clear()       
      CALL g_oohb7_d.clear()       
      CALL g_oohb8_d.clear()       
      CALL g_oohb9_d.clear()       
 
     
      CALL aooi380_ui_browser_refresh()  
      #CALL aooi380_ui_headershow()  
      #CALL aooi380_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'oohalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.oohal001
   LET l_field_keys[02] = 'oohal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oohal_t')
 
      
      #單身多語言刪除
      
      
      
      
      
      
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aooi380_browser_fill("")
         CALL aooi380_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aooi380_cl
 
   #功能已完成,通報訊息中心
   CALL aooi380_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aooi380.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aooi380_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_oohb_d.clear()
   CALL g_oohb10_d.clear()
   CALL g_oohb11_d.clear()
   CALL g_oohb2_d.clear()
   CALL g_oohb3_d.clear()
   CALL g_oohb4_d.clear()
   CALL g_oohb5_d.clear()
   CALL g_oohb6_d.clear()
   CALL g_oohb7_d.clear()
   CALL g_oohb8_d.clear()
   CALL g_oohb9_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aooi380_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohb002,oohb003,oohb004 ,t1.ooefl003 FROM oohb_t",   
                     " INNER JOIN ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohb001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=oohb002 AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE oohbent=? AND oohb001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohb_t.oohb002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aooi380_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb_d[l_ac].oohb002,g_oohb_d[l_ac].oohb003, 
          g_oohb_d[l_ac].oohb004,g_oohb_d[l_ac].oohb002_desc   #(ver:78)
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
   IF aooi380_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohk002,oohk003,oohk004 ,t2.ooefl003 FROM oohk_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohk001 ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=oohk002 AND t2.ooefl002='"||g_dlang||"' ",
 
                     " WHERE oohkent=? AND oohk001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohk_t.oohk002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aooi380_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb10_d[l_ac].oohk002,g_oohb10_d[l_ac].oohk003, 
          g_oohb10_d[l_ac].oohk004,g_oohb10_d[l_ac].oohk002_desc   #(ver:78)
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
   IF aooi380_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohl002,oohl003,oohl004,oohl005 ,t3.ooefl003 ,t4.inayl003 FROM oohl_t", 
                
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohl001 ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=oohl002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent="||g_enterprise||" AND t4.inayl001=oohl003 AND t4.inayl002='"||g_dlang||"' ",
 
                     " WHERE oohlent=? AND oohl001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohl_t.oohl002,oohl_t.oohl003"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aooi380_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb11_d[l_ac].oohl002,g_oohb11_d[l_ac].oohl003, 
          g_oohb11_d[l_ac].oohl004,g_oohb11_d[l_ac].oohl005,g_oohb11_d[l_ac].oohl002_desc,g_oohb11_d[l_ac].oohl003_desc  
            #(ver:78)
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
   IF aooi380_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohc002,oohc003,oohc004 ,t5.ooag011 FROM oohc_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohc001 ",
 
                     "",
                     
                                    " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=oohc002  ",
 
                     " WHERE oohcent=? AND oohc001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohc_t.oohc002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR aooi380_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb2_d[l_ac].oohc002,g_oohb2_d[l_ac].oohc003, 
          g_oohb2_d[l_ac].oohc004,g_oohb2_d[l_ac].oohc002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         
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
   IF aooi380_fill_chk(5) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body5.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohd002,oohd003,oohd004 ,t6.oocql004 FROM oohd_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohd001 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='281' AND t6.oocql002=oohd002 AND t6.oocql003='"||g_dlang||"' ",
 
                     " WHERE oohdent=? AND oohd001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body5.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohd_t.oohd002"
         
         #add-point:單身填充控制 name="b_fill.sql5"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR aooi380_pb5
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs5 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs5 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb3_d[l_ac].oohd002,g_oohb3_d[l_ac].oohd003, 
          g_oohb3_d[l_ac].oohd004,g_oohb3_d[l_ac].oohd002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill5.fill"
         
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
   IF aooi380_fill_chk(6) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body6.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohe002,oohe003,oohe004 ,t7.pmaal004 FROM oohe_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohe001 ",
 
                     "",
                     
                                    " LEFT JOIN pmaal_t t7 ON t7.pmaalent="||g_enterprise||" AND t7.pmaal001=oohe002 AND t7.pmaal002='"||g_dlang||"' ",
 
                     " WHERE ooheent=? AND oohe001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body6.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table6) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohe_t.oohe002"
         
         #add-point:單身填充控制 name="b_fill.sql6"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb6 FROM g_sql
         DECLARE b_fill_cs6 CURSOR FOR aooi380_pb6
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs6 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs6 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb4_d[l_ac].oohe002,g_oohb4_d[l_ac].oohe003, 
          g_oohb4_d[l_ac].oohe004,g_oohb4_d[l_ac].oohe002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill6.fill"
         
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
   IF aooi380_fill_chk(7) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body7.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohf002,oohf003,oohf004 ,t8.oocql004 FROM oohf_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohf001 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='251' AND t8.oocql002=oohf002 AND t8.oocql003='"||g_dlang||"' ",
 
                     " WHERE oohfent=? AND oohf001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body7.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table7) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table7 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohf_t.oohf002"
         
         #add-point:單身填充控制 name="b_fill.sql7"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb7 FROM g_sql
         DECLARE b_fill_cs7 CURSOR FOR aooi380_pb7
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs7 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs7 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb5_d[l_ac].oohf002,g_oohb5_d[l_ac].oohf003, 
          g_oohb5_d[l_ac].oohf004,g_oohb5_d[l_ac].oohf002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill7.fill"
         
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
   IF aooi380_fill_chk(8) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body8.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohg002,oohg003,oohg004 ,t9.pmaal004 FROM oohg_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohg001 ",
 
                     "",
                     
                                    " LEFT JOIN pmaal_t t9 ON t9.pmaalent="||g_enterprise||" AND t9.pmaal001=oohg002 AND t9.pmaal002='"||g_dlang||"' ",
 
                     " WHERE oohgent=? AND oohg001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body8.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table8) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table8 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohg_t.oohg002"
         
         #add-point:單身填充控制 name="b_fill.sql8"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb8 FROM g_sql
         DECLARE b_fill_cs8 CURSOR FOR aooi380_pb8
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs8 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs8 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb6_d[l_ac].oohg002,g_oohb6_d[l_ac].oohg003, 
          g_oohb6_d[l_ac].oohg004,g_oohb6_d[l_ac].oohg002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill8.fill"
         
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
   IF aooi380_fill_chk(9) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body9.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohh002,oohh003,oohh004 ,t10.rtaxl003 FROM oohh_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohh001 ",
 
                     "",
                     
                                    " LEFT JOIN rtaxl_t t10 ON t10.rtaxlent="||g_enterprise||" AND t10.rtaxl001=oohh002 AND t10.rtaxl002='"||g_dlang||"' ",
 
                     " WHERE oohhent=? AND oohh001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body9.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table9) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table9 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohh_t.oohh002"
         
         #add-point:單身填充控制 name="b_fill.sql9"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb9 FROM g_sql
         DECLARE b_fill_cs9 CURSOR FOR aooi380_pb9
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs9 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs9 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb7_d[l_ac].oohh002,g_oohb7_d[l_ac].oohh003, 
          g_oohb7_d[l_ac].oohh004,g_oohb7_d[l_ac].oohh002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill9.fill"
         
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
   IF aooi380_fill_chk(10) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body10.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohi002,oohi003,oohi004 ,t11.imaal003 FROM oohi_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohi001 ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t11 ON t11.imaalent="||g_enterprise||" AND t11.imaal001=oohi002 AND t11.imaal002='"||g_dlang||"' ",
 
                     " WHERE oohient=? AND oohi001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body10.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table10) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table10 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohi_t.oohi002"
         
         #add-point:單身填充控制 name="b_fill.sql10"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb10 FROM g_sql
         DECLARE b_fill_cs10 CURSOR FOR aooi380_pb10
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs10 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs10 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb8_d[l_ac].oohi002,g_oohb8_d[l_ac].oohi003, 
          g_oohb8_d[l_ac].oohi004,g_oohb8_d[l_ac].oohi002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill10.fill"
         
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
   IF aooi380_fill_chk(11) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body11.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT oohj002,oohj003,oohj004 ,t12.ooefl003 FROM oohj_t",   
                     " INNER JOIN  ooha_t ON oohaent = " ||g_enterprise|| " AND ooha001 = oohj001 ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=oohj002 AND t12.ooefl002='"||g_dlang||"' ",
 
                     " WHERE oohjent=? AND oohj001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body11.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table11) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table11 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY oohj_t.oohj002"
         
         #add-point:單身填充控制 name="b_fill.sql11"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aooi380_pb11 FROM g_sql
         DECLARE b_fill_cs11 CURSOR FOR aooi380_pb11
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs11 USING g_enterprise,g_ooha_m.ooha001   #(ver:78)
                                               
      FOREACH b_fill_cs11 USING g_enterprise,g_ooha_m.ooha001 INTO g_oohb9_d[l_ac].oohj002,g_oohb9_d[l_ac].oohj003, 
          g_oohb9_d[l_ac].oohj004,g_oohb9_d[l_ac].oohj002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill11.fill"
         
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
   
   CALL g_oohb_d.deleteElement(g_oohb_d.getLength())
   CALL g_oohb10_d.deleteElement(g_oohb10_d.getLength())
   CALL g_oohb11_d.deleteElement(g_oohb11_d.getLength())
   CALL g_oohb2_d.deleteElement(g_oohb2_d.getLength())
   CALL g_oohb3_d.deleteElement(g_oohb3_d.getLength())
   CALL g_oohb4_d.deleteElement(g_oohb4_d.getLength())
   CALL g_oohb5_d.deleteElement(g_oohb5_d.getLength())
   CALL g_oohb6_d.deleteElement(g_oohb6_d.getLength())
   CALL g_oohb7_d.deleteElement(g_oohb7_d.getLength())
   CALL g_oohb8_d.deleteElement(g_oohb8_d.getLength())
   CALL g_oohb9_d.deleteElement(g_oohb9_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aooi380_pb
   FREE aooi380_pb2
 
   FREE aooi380_pb3
 
   FREE aooi380_pb4
 
   FREE aooi380_pb5
 
   FREE aooi380_pb6
 
   FREE aooi380_pb7
 
   FREE aooi380_pb8
 
   FREE aooi380_pb9
 
   FREE aooi380_pb10
 
   FREE aooi380_pb11
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_oohb_d.getLength()
      LET g_oohb_d_mask_o[l_ac].* =  g_oohb_d[l_ac].*
      CALL aooi380_oohb_t_mask()
      LET g_oohb_d_mask_n[l_ac].* =  g_oohb_d[l_ac].*
   END FOR
   
   LET g_oohb10_d_mask_o.* =  g_oohb10_d.*
   FOR l_ac = 1 TO g_oohb10_d.getLength()
      LET g_oohb10_d_mask_o[l_ac].* =  g_oohb10_d[l_ac].*
      CALL aooi380_oohk_t_mask()
      LET g_oohb10_d_mask_n[l_ac].* =  g_oohb10_d[l_ac].*
   END FOR
   LET g_oohb11_d_mask_o.* =  g_oohb11_d.*
   FOR l_ac = 1 TO g_oohb11_d.getLength()
      LET g_oohb11_d_mask_o[l_ac].* =  g_oohb11_d[l_ac].*
      CALL aooi380_oohl_t_mask()
      LET g_oohb11_d_mask_n[l_ac].* =  g_oohb11_d[l_ac].*
   END FOR
   LET g_oohb2_d_mask_o.* =  g_oohb2_d.*
   FOR l_ac = 1 TO g_oohb2_d.getLength()
      LET g_oohb2_d_mask_o[l_ac].* =  g_oohb2_d[l_ac].*
      CALL aooi380_oohc_t_mask()
      LET g_oohb2_d_mask_n[l_ac].* =  g_oohb2_d[l_ac].*
   END FOR
   LET g_oohb3_d_mask_o.* =  g_oohb3_d.*
   FOR l_ac = 1 TO g_oohb3_d.getLength()
      LET g_oohb3_d_mask_o[l_ac].* =  g_oohb3_d[l_ac].*
      CALL aooi380_oohd_t_mask()
      LET g_oohb3_d_mask_n[l_ac].* =  g_oohb3_d[l_ac].*
   END FOR
   LET g_oohb4_d_mask_o.* =  g_oohb4_d.*
   FOR l_ac = 1 TO g_oohb4_d.getLength()
      LET g_oohb4_d_mask_o[l_ac].* =  g_oohb4_d[l_ac].*
      CALL aooi380_oohe_t_mask()
      LET g_oohb4_d_mask_n[l_ac].* =  g_oohb4_d[l_ac].*
   END FOR
   LET g_oohb5_d_mask_o.* =  g_oohb5_d.*
   FOR l_ac = 1 TO g_oohb5_d.getLength()
      LET g_oohb5_d_mask_o[l_ac].* =  g_oohb5_d[l_ac].*
      CALL aooi380_oohf_t_mask()
      LET g_oohb5_d_mask_n[l_ac].* =  g_oohb5_d[l_ac].*
   END FOR
   LET g_oohb6_d_mask_o.* =  g_oohb6_d.*
   FOR l_ac = 1 TO g_oohb6_d.getLength()
      LET g_oohb6_d_mask_o[l_ac].* =  g_oohb6_d[l_ac].*
      CALL aooi380_oohg_t_mask()
      LET g_oohb6_d_mask_n[l_ac].* =  g_oohb6_d[l_ac].*
   END FOR
   LET g_oohb7_d_mask_o.* =  g_oohb7_d.*
   FOR l_ac = 1 TO g_oohb7_d.getLength()
      LET g_oohb7_d_mask_o[l_ac].* =  g_oohb7_d[l_ac].*
      CALL aooi380_oohh_t_mask()
      LET g_oohb7_d_mask_n[l_ac].* =  g_oohb7_d[l_ac].*
   END FOR
   LET g_oohb8_d_mask_o.* =  g_oohb8_d.*
   FOR l_ac = 1 TO g_oohb8_d.getLength()
      LET g_oohb8_d_mask_o[l_ac].* =  g_oohb8_d[l_ac].*
      CALL aooi380_oohi_t_mask()
      LET g_oohb8_d_mask_n[l_ac].* =  g_oohb8_d[l_ac].*
   END FOR
   LET g_oohb9_d_mask_o.* =  g_oohb9_d.*
   FOR l_ac = 1 TO g_oohb9_d.getLength()
      LET g_oohb9_d_mask_o[l_ac].* =  g_oohb9_d[l_ac].*
      CALL aooi380_oohj_t_mask()
      LET g_oohb9_d_mask_n[l_ac].* =  g_oohb9_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aooi380_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM oohb_t
       WHERE oohbent = g_enterprise AND
         oohb001 = ps_keys_bak[1] AND oohb002 = ps_keys_bak[2]
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
         CALL g_oohb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM oohk_t
       WHERE oohkent = g_enterprise AND
             oohk001 = ps_keys_bak[1] AND oohk002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_oohb10_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM oohl_t
       WHERE oohlent = g_enterprise AND
             oohl001 = ps_keys_bak[1] AND oohl002 = ps_keys_bak[2] AND oohl003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_oohb11_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM oohc_t
       WHERE oohcent = g_enterprise AND
             oohc001 = ps_keys_bak[1] AND oohc002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_oohb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete5"
      
      #end add-point    
      DELETE FROM oohd_t
       WHERE oohdent = g_enterprise AND
             oohd001 = ps_keys_bak[1] AND oohd002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete5"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_oohb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete5"
      
      #end add-point    
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete6"
      
      #end add-point    
      DELETE FROM oohe_t
       WHERE ooheent = g_enterprise AND
             oohe001 = ps_keys_bak[1] AND oohe002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete6"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'6'" THEN 
         CALL g_oohb4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete6"
      
      #end add-point    
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete7"
      
      #end add-point    
      DELETE FROM oohf_t
       WHERE oohfent = g_enterprise AND
             oohf001 = ps_keys_bak[1] AND oohf002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete7"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'7'" THEN 
         CALL g_oohb5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete7"
      
      #end add-point    
   END IF
 
   LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete8"
      
      #end add-point    
      DELETE FROM oohg_t
       WHERE oohgent = g_enterprise AND
             oohg001 = ps_keys_bak[1] AND oohg002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete8"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'8'" THEN 
         CALL g_oohb6_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete8"
      
      #end add-point    
   END IF
 
   LET ls_group = "'9',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete9"
      
      #end add-point    
      DELETE FROM oohh_t
       WHERE oohhent = g_enterprise AND
             oohh001 = ps_keys_bak[1] AND oohh002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete9"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'9'" THEN 
         CALL g_oohb7_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete9"
      
      #end add-point    
   END IF
 
   LET ls_group = "'10',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete10"
      
      #end add-point    
      DELETE FROM oohi_t
       WHERE oohient = g_enterprise AND
             oohi001 = ps_keys_bak[1] AND oohi002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete10"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'10'" THEN 
         CALL g_oohb8_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete10"
      
      #end add-point    
   END IF
 
   LET ls_group = "'11',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete11"
      
      #end add-point    
      DELETE FROM oohj_t
       WHERE oohjent = g_enterprise AND
             oohj001 = ps_keys_bak[1] AND oohj002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete11"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'11'" THEN 
         CALL g_oohb9_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete11"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aooi380_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO oohb_t
                  (oohbent,
                   oohb001,
                   oohb002
                   ,oohb003,oohb004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb_d[g_detail_idx].oohb003,g_oohb_d[g_detail_idx].oohb004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_oohb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO oohk_t
                  (oohkent,
                   oohk001,
                   oohk002
                   ,oohk003,oohk004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb10_d[g_detail_idx].oohk003,g_oohb10_d[g_detail_idx].oohk004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohk_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_oohb10_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO oohl_t
                  (oohlent,
                   oohl001,
                   oohl002,oohl003
                   ,oohl004,oohl005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_oohb11_d[g_detail_idx].oohl004,g_oohb11_d[g_detail_idx].oohl005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_oohb11_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO oohc_t
                  (oohcent,
                   oohc001,
                   oohc002
                   ,oohc003,oohc004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb2_d[g_detail_idx].oohc003,g_oohb2_d[g_detail_idx].oohc004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_oohb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert5"
      
      #end add-point 
      INSERT INTO oohd_t
                  (oohdent,
                   oohd001,
                   oohd002
                   ,oohd003,oohd004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb3_d[g_detail_idx].oohd003,g_oohb3_d[g_detail_idx].oohd004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_oohb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert5"
      
      #end add-point
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert6"
      
      #end add-point 
      INSERT INTO oohe_t
                  (ooheent,
                   oohe001,
                   oohe002
                   ,oohe003,oohe004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb4_d[g_detail_idx].oohe003,g_oohb4_d[g_detail_idx].oohe004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert6"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'6'" THEN 
         CALL g_oohb4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert6"
      
      #end add-point
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert7"
      
      #end add-point 
      INSERT INTO oohf_t
                  (oohfent,
                   oohf001,
                   oohf002
                   ,oohf003,oohf004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb5_d[g_detail_idx].oohf003,g_oohb5_d[g_detail_idx].oohf004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert7"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'7'" THEN 
         CALL g_oohb5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert7"
      
      #end add-point
   END IF
 
   LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert8"
      
      #end add-point 
      INSERT INTO oohg_t
                  (oohgent,
                   oohg001,
                   oohg002
                   ,oohg003,oohg004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb6_d[g_detail_idx].oohg003,g_oohb6_d[g_detail_idx].oohg004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert8"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'8'" THEN 
         CALL g_oohb6_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert8"
      
      #end add-point
   END IF
 
   LET ls_group = "'9',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert9"
      
      #end add-point 
      INSERT INTO oohh_t
                  (oohhent,
                   oohh001,
                   oohh002
                   ,oohh003,oohh004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb7_d[g_detail_idx].oohh003,g_oohb7_d[g_detail_idx].oohh004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert9"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'9'" THEN 
         CALL g_oohb7_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert9"
      
      #end add-point
   END IF
 
   LET ls_group = "'10',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert10"
      
      #end add-point 
      INSERT INTO oohi_t
                  (oohient,
                   oohi001,
                   oohi002
                   ,oohi003,oohi004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb8_d[g_detail_idx].oohi003,g_oohb8_d[g_detail_idx].oohi004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert10"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohi_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'10'" THEN 
         CALL g_oohb8_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert10"
      
      #end add-point
   END IF
 
   LET ls_group = "'11',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert11"
      
      #end add-point 
      INSERT INTO oohj_t
                  (oohjent,
                   oohj001,
                   oohj002
                   ,oohj003,oohj004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_oohb9_d[g_detail_idx].oohj003,g_oohb9_d[g_detail_idx].oohj004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert11"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "oohj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'11'" THEN 
         CALL g_oohb9_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert11"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aooi380_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aooi380_oohb_t_mask_restore('restore_mask_o')
               
      UPDATE oohb_t 
         SET (oohb001,
              oohb002
              ,oohb003,oohb004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb_d[g_detail_idx].oohb003,g_oohb_d[g_detail_idx].oohb004) 
         WHERE oohbent = g_enterprise AND oohb001 = ps_keys_bak[1] AND oohb002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohk_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohk_t_mask_restore('restore_mask_o')
               
      UPDATE oohk_t 
         SET (oohk001,
              oohk002
              ,oohk003,oohk004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb10_d[g_detail_idx].oohk003,g_oohb10_d[g_detail_idx].oohk004) 
         WHERE oohkent = g_enterprise AND oohk001 = ps_keys_bak[1] AND oohk002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohk_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohk_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohk_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohl_t_mask_restore('restore_mask_o')
               
      UPDATE oohl_t 
         SET (oohl001,
              oohl002,oohl003
              ,oohl004,oohl005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_oohb11_d[g_detail_idx].oohl004,g_oohb11_d[g_detail_idx].oohl005) 
         WHERE oohlent = g_enterprise AND oohl001 = ps_keys_bak[1] AND oohl002 = ps_keys_bak[2] AND oohl003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohl_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohc_t_mask_restore('restore_mask_o')
               
      UPDATE oohc_t 
         SET (oohc001,
              oohc002
              ,oohc003,oohc004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb2_d[g_detail_idx].oohc003,g_oohb2_d[g_detail_idx].oohc004) 
         WHERE oohcent = g_enterprise AND oohc001 = ps_keys_bak[1] AND oohc002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohc_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update5"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohd_t_mask_restore('restore_mask_o')
               
      UPDATE oohd_t 
         SET (oohd001,
              oohd002
              ,oohd003,oohd004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb3_d[g_detail_idx].oohd003,g_oohb3_d[g_detail_idx].oohd004) 
         WHERE oohdent = g_enterprise AND oohd001 = ps_keys_bak[1] AND oohd002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update5"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohd_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update5"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohe_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update6"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohe_t_mask_restore('restore_mask_o')
               
      UPDATE oohe_t 
         SET (oohe001,
              oohe002
              ,oohe003,oohe004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb4_d[g_detail_idx].oohe003,g_oohb4_d[g_detail_idx].oohe004) 
         WHERE ooheent = g_enterprise AND oohe001 = ps_keys_bak[1] AND oohe002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update6"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohe_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohe_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohe_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update6"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohf_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update7"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohf_t_mask_restore('restore_mask_o')
               
      UPDATE oohf_t 
         SET (oohf001,
              oohf002
              ,oohf003,oohf004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb5_d[g_detail_idx].oohf003,g_oohb5_d[g_detail_idx].oohf004) 
         WHERE oohfent = g_enterprise AND oohf001 = ps_keys_bak[1] AND oohf002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update7"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohf_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update7"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update8"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohg_t_mask_restore('restore_mask_o')
               
      UPDATE oohg_t 
         SET (oohg001,
              oohg002
              ,oohg003,oohg004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb6_d[g_detail_idx].oohg003,g_oohb6_d[g_detail_idx].oohg004) 
         WHERE oohgent = g_enterprise AND oohg001 = ps_keys_bak[1] AND oohg002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update8"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohg_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update8"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'9',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update9"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohh_t_mask_restore('restore_mask_o')
               
      UPDATE oohh_t 
         SET (oohh001,
              oohh002
              ,oohh003,oohh004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb7_d[g_detail_idx].oohh003,g_oohb7_d[g_detail_idx].oohh004) 
         WHERE oohhent = g_enterprise AND oohh001 = ps_keys_bak[1] AND oohh002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update9"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohh_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update9"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'10',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohi_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update10"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohi_t_mask_restore('restore_mask_o')
               
      UPDATE oohi_t 
         SET (oohi001,
              oohi002
              ,oohi003,oohi004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb8_d[g_detail_idx].oohi003,g_oohb8_d[g_detail_idx].oohi004) 
         WHERE oohient = g_enterprise AND oohi001 = ps_keys_bak[1] AND oohi002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update10"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohi_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohi_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohi_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update10"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'11',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "oohj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update11"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aooi380_oohj_t_mask_restore('restore_mask_o')
               
      UPDATE oohj_t 
         SET (oohj001,
              oohj002
              ,oohj003,oohj004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_oohb9_d[g_detail_idx].oohj003,g_oohb9_d[g_detail_idx].oohj004) 
         WHERE oohjent = g_enterprise AND oohj001 = ps_keys_bak[1] AND oohj002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update11"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "oohj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aooi380_oohj_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update11"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aooi380_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aooi380.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aooi380_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aooi380.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aooi380_lock_b(ps_table,ps_page)
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
   #CALL aooi380_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "oohb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aooi380_bcl USING g_enterprise,
                                       g_ooha_m.ooha001,g_oohb_d[g_detail_idx].oohb002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "oohk_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl2 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb10_d[g_detail_idx].oohk002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "oohl_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl3 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb11_d[g_detail_idx].oohl002,g_oohb11_d[g_detail_idx].oohl003 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "oohc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl4 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb2_d[g_detail_idx].oohc002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "oohd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl5 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb3_d[g_detail_idx].oohd002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl5:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'6',"
   #僅鎖定自身table
   LET ls_group = "oohe_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl6 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb4_d[g_detail_idx].oohe002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl6:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'7',"
   #僅鎖定自身table
   LET ls_group = "oohf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl7 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb5_d[g_detail_idx].oohf002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl7:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'8',"
   #僅鎖定自身table
   LET ls_group = "oohg_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl8 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb6_d[g_detail_idx].oohg002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl8:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'9',"
   #僅鎖定自身table
   LET ls_group = "oohh_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl9 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb7_d[g_detail_idx].oohh002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl9:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'10',"
   #僅鎖定自身table
   LET ls_group = "oohi_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl10 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb8_d[g_detail_idx].oohi002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl10:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'11',"
   #僅鎖定自身table
   LET ls_group = "oohj_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aooi380_bcl11 USING g_enterprise,
                                             g_ooha_m.ooha001,g_oohb9_d[g_detail_idx].oohj002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aooi380_bcl11:",SQLERRMESSAGE 
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
 
{<section id="aooi380.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aooi380_unlock_b(ps_table,ps_page)
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
      CLOSE aooi380_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl4
   END IF
 
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl5
   END IF
 
   LET ls_group = "'6',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl6
   END IF
 
   LET ls_group = "'7',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl7
   END IF
 
   LET ls_group = "'8',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl8
   END IF
 
   LET ls_group = "'9',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl9
   END IF
 
   LET ls_group = "'10',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl10
   END IF
 
   LET ls_group = "'11',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi380_bcl11
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aooi380_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("ooha001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      IF NOT cl_null(g_ooha002_p) THEN
         CALL cl_set_comp_entry("ooha002",FALSE)
      END IF 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aooi380_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("ooha001",FALSE)
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
 
{<section id="aooi380.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aooi380_set_entry_b(p_cmd)
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
 
{<section id="aooi380.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aooi380_set_no_entry_b(p_cmd)
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
 
{<section id="aooi380.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aooi380_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aooi380_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aooi380_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aooi380_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aooi380_default_search()
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
      LET ls_wc = ls_wc, " ooha001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " ooha001 = '", g_argv[02], "' AND "
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
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
         INITIALIZE g_wc2_table4 TO NULL
 
         INITIALIZE g_wc2_table5 TO NULL
 
         INITIALIZE g_wc2_table6 TO NULL
 
         INITIALIZE g_wc2_table7 TO NULL
 
         INITIALIZE g_wc2_table8 TO NULL
 
         INITIALIZE g_wc2_table9 TO NULL
 
         INITIALIZE g_wc2_table10 TO NULL
 
         INITIALIZE g_wc2_table11 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "ooha_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "oohb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "oohk_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohl_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohc_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohd_t" 
                  LET g_wc2_table5 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohe_t" 
                  LET g_wc2_table6 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohf_t" 
                  LET g_wc2_table7 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohg_t" 
                  LET g_wc2_table8 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohh_t" 
                  LET g_wc2_table9 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohi_t" 
                  LET g_wc2_table10 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "oohj_t" 
                  LET g_wc2_table11 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
            OR NOT cl_null(g_wc2_table5)
 
            OR NOT cl_null(g_wc2_table6)
 
            OR NOT cl_null(g_wc2_table7)
 
            OR NOT cl_null(g_wc2_table8)
 
            OR NOT cl_null(g_wc2_table9)
 
            OR NOT cl_null(g_wc2_table10)
 
            OR NOT cl_null(g_wc2_table11)
 
 
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
 
            IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
            END IF
 
            IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
            END IF
 
            IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
            END IF
 
            IF g_wc2_table8 <> " 1=1" AND NOT cl_null(g_wc2_table8) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table8
            END IF
 
            IF g_wc2_table9 <> " 1=1" AND NOT cl_null(g_wc2_table9) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table9
            END IF
 
            IF g_wc2_table10 <> " 1=1" AND NOT cl_null(g_wc2_table10) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table10
            END IF
 
            IF g_wc2_table11 <> " 1=1" AND NOT cl_null(g_wc2_table11) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table11
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
   IF NOT cl_null(g_argv[1]) THEN
      LET g_wc = g_wc," ooha002 = '", g_argv[1], "'"
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aooi380_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_ooha_m.ooha001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aooi380_cl USING g_enterprise,g_ooha_m.ooha001
   IF STATUS THEN
      CLOSE aooi380_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aooi380_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aooi380_master_referesh USING g_ooha_m.ooha001 INTO g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdt, 
       g_ooha_m.oohamodid,g_ooha_m.oohamoddt,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid_desc, 
       g_ooha_m.oohacrtdp_desc,g_ooha_m.oohamodid_desc
   
 
   #檢查是否允許此動作
   IF NOT aooi380_action_chk() THEN
      CLOSE aooi380_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohal003,g_ooha_m.oohal005,g_ooha_m.oohastus, 
       g_ooha_m.oohaownid,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid, 
       g_ooha_m.oohacrtid_desc,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdp_desc,g_ooha_m.oohacrtdt,g_ooha_m.oohamodid, 
       g_ooha_m.oohamodid_desc,g_ooha_m.oohamoddt
 
   CASE g_ooha_m.oohastus
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
         CASE g_ooha_m.oohastus
            
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
      g_ooha_m.oohastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aooi380_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_ooha_m.oohamodid = g_user
   LET g_ooha_m.oohamoddt = cl_get_current()
   LET g_ooha_m.oohastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE ooha_t 
      SET (oohastus,oohamodid,oohamoddt) 
        = (g_ooha_m.oohastus,g_ooha_m.oohamodid,g_ooha_m.oohamoddt)     
    WHERE oohaent = g_enterprise AND ooha001 = g_ooha_m.ooha001
 
    
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
      EXECUTE aooi380_master_referesh USING g_ooha_m.ooha001 INTO g_ooha_m.ooha002,g_ooha_m.ooha001, 
          g_ooha_m.oohastus,g_ooha_m.oohaownid,g_ooha_m.oohaowndp,g_ooha_m.oohacrtid,g_ooha_m.oohacrtdp, 
          g_ooha_m.oohacrtdt,g_ooha_m.oohamodid,g_ooha_m.oohamoddt,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp_desc, 
          g_ooha_m.oohacrtid_desc,g_ooha_m.oohacrtdp_desc,g_ooha_m.oohamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_ooha_m.ooha002,g_ooha_m.ooha001,g_ooha_m.oohal003,g_ooha_m.oohal005,g_ooha_m.oohastus, 
          g_ooha_m.oohaownid,g_ooha_m.oohaownid_desc,g_ooha_m.oohaowndp,g_ooha_m.oohaowndp_desc,g_ooha_m.oohacrtid, 
          g_ooha_m.oohacrtid_desc,g_ooha_m.oohacrtdp,g_ooha_m.oohacrtdp_desc,g_ooha_m.oohacrtdt,g_ooha_m.oohamodid, 
          g_ooha_m.oohamodid_desc,g_ooha_m.oohamoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aooi380_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aooi380_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi380.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aooi380_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_oohb_d.getLength() THEN
         LET g_detail_idx = g_oohb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail10")
      IF g_detail_idx > g_oohb10_d.getLength() THEN
         LET g_detail_idx = g_oohb10_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb10_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb10_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail11")
      IF g_detail_idx > g_oohb11_d.getLength() THEN
         LET g_detail_idx = g_oohb11_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb11_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb11_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_oohb2_d.getLength() THEN
         LET g_detail_idx = g_oohb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_oohb3_d.getLength() THEN
         LET g_detail_idx = g_oohb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_oohb4_d.getLength() THEN
         LET g_detail_idx = g_oohb4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 7 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_oohb5_d.getLength() THEN
         LET g_detail_idx = g_oohb5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb5_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 8 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_oohb6_d.getLength() THEN
         LET g_detail_idx = g_oohb6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb6_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 9 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail7")
      IF g_detail_idx > g_oohb7_d.getLength() THEN
         LET g_detail_idx = g_oohb7_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb7_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb7_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 10 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail8")
      IF g_detail_idx > g_oohb8_d.getLength() THEN
         LET g_detail_idx = g_oohb8_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb8_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb8_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 11 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail9")
      IF g_detail_idx > g_oohb9_d.getLength() THEN
         LET g_detail_idx = g_oohb9_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oohb9_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oohb9_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aooi380_b_fill2(pi_idx)
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
   
   CALL aooi380_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aooi380_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND 
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1')  AND 
      (cl_null(g_wc2_table6) OR g_wc2_table6.trim() = '1=1')  AND 
      (cl_null(g_wc2_table7) OR g_wc2_table7.trim() = '1=1')  AND 
      (cl_null(g_wc2_table8) OR g_wc2_table8.trim() = '1=1')  AND 
      (cl_null(g_wc2_table9) OR g_wc2_table9.trim() = '1=1')  AND 
      (cl_null(g_wc2_table10) OR g_wc2_table10.trim() = '1=1')  AND 
      (cl_null(g_wc2_table11) OR g_wc2_table11.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aooi380.status_show" >}
PRIVATE FUNCTION aooi380_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aooi380.mask_functions" >}
&include "erp/aoo/aooi380_mask.4gl"
 
{</section>}
 
{<section id="aooi380.signature" >}
   
 
{</section>}
 
{<section id="aooi380.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aooi380_set_pk_array()
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
   LET g_pk_array[1].values = g_ooha_m.ooha001
   LET g_pk_array[1].column = 'ooha001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi380.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aooi380.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aooi380_msgcentre_notify(lc_state)
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
   CALL aooi380_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_ooha_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aooi380.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aooi380_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aooi380.other_function" readonly="Y" >}
#+據點名稱
PRIVATE FUNCTION aooi380_ooef001_desc(p_ooef001)
   DEFINE p_ooef001    LIKE ooef_t.ooef001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1] 
            
END FUNCTION
#經營渠道/營運據點檢查
PRIVATE FUNCTION aooi380_ooef001_chk(p_ooef001)
  DEFINE p_ooef001   LIKE ooef_t.ooef001
  DEFINE l_ooefstus  LIKE ooef_t.ooefstus
  DEFINE l_ooef201   LIKE ooef_t.ooef201
  
  LET g_errno = ''
   SELECT ooefstus,ooef201 INTO l_ooefstus,l_ooef201 FROM ooef_t
 	WHERE ooefent  = g_enterprise
      AND ooef001 = p_ooef001
  CASE
     WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00090'
     WHEN l_ooefstus = 'N'      LET g_errno = 'sub-01302' #aoo-00091 #160318-00005#31 by 07900 --mod
     WHEN l_ooef201 = 'N'      LET g_errno = 'axc-00115'
  END CASE
END FUNCTION
#+依据不同的类型对单身page进行显示隐藏
PRIVATE FUNCTION aooi380_ooha002(p_ooha002)
  DEFINE p_ooha002    LIKE ooha_t.ooha002
  
   #當執行aooi389時，傳入參數=0(ALL)：
   #只顯示部門與參數
   IF p_ooha002 = '0' THEN
      CALL cl_set_comp_visible('page_13,page_14,page_15,page_16,page_17,page_18',FALSE)
   END IF
   
   #當執行aooi381時，傳入參數=1(研發控制組)：
   #只顯示部門與參數、產品範圍、據點範圍
   IF p_ooha002 = '1' THEN
      CALL cl_set_comp_visible('page_13,page_14,page_16,page_18',FALSE)
   END IF
   #當執行aooi382時，傳入參數=2(銷售控制組)：
   #只顯示部門與參數、客戶範圍、產品範圍、渠道範圍、據點範圍
   IF p_ooha002 = '2' THEN
      CALL cl_set_comp_visible('page_14,page_18',FALSE)
   END IF
   #當執行aooi383時，傳入參數=3(請購控制組)：
   #只顯示部門與參數、廠商範圍、產品範圍、渠道範圍、據點範圍
   IF p_ooha002 = '3' THEN
      CALL cl_set_comp_visible('page_13,page_18',FALSE)
   END IF
   #當執行aooi384時，傳入參數=4(採購控制組)：
   #只顯示部門與參數、廠商範圍、產品範圍、渠道範圍、據點範圍
   IF p_ooha002 = '4' THEN
      CALL cl_set_comp_visible('page_13,page_18',FALSE)
   END IF
   #當執行aooi385時，傳入參數=5(庫存控制組)：
   #只顯示部門與參數、產品範圍、據點範圍、據點庫位
   IF p_ooha002 = '5' THEN
      CALL cl_set_comp_visible('page_13,page_14,page_16',FALSE)
   END IF
   #當執行aooi386時，傳入參數=6(生管控制組)：
   #只顯示部門與參數、廠商範圍、產品範圍、據點範圍、據點庫位 
   IF p_ooha002 = '6' THEN
      CALL cl_set_comp_visible('page_13,page_16',FALSE)
   END IF   
END FUNCTION
#+部门名称
PRIVATE FUNCTION aooi380_oohb002_desc(p_oohb002)
    DEFINE p_oohb002  LIKE oohb_t.oohb002 
     
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = p_oohb002
     CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     RETURN g_rtn_fields[1]
END FUNCTION
#+厂商客户简称
PRIVATE FUNCTION aooi380_oohe002_desc(p_pmaa001)
   DEFINE p_pmaa001    LIKE pmaa_t.pmaa001
   
   INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_pmaa001
    CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"' ","") RETURNING g_rtn_fields
     RETURN  g_rtn_fields[1]
END FUNCTION
#厂商客户资料检查
PRIVATE FUNCTION aooi380_oohe002_chk(p_pmaa002,p_pmaa001)
   DEFINE p_pmaa002     LIKE pmaa_t.pmaa002
   DEFINE p_pmaa001     LIKE pmaa_t.pmaa001
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus
   
   LET g_errno = ''
   IF p_pmaa002 = '1'  THEN  #厂商
      SElECT pmaastus INTO l_pmaastus FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = p_pmaa001
         AND (pmaa002 = '1' OR pmaa002 = '3')
   END IF
   IF p_pmaa002 = '2'  THEN  #客户
      SElECT pmaastus INTO l_pmaastus FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = p_pmaa001
         AND (pmaa002 = '2' OR pmaa002 = '3')
   END IF   
   CASE
      WHEN SQLCA.SQLCODE = 100    
         IF p_pmaa002 = '1'  THEN  #厂商
            LET g_errno = 'apm-00024'
         ELSE
             LET g_errno = 'apm-00026'        
         END IF    
      WHEN l_pmaastus = 'N'       
         IF p_pmaa002 = '1'  THEN  #厂商
            LET g_errno = 'apm-00025'
         ELSE
             LET g_errno = 'apm-00027'        
         END IF    
   END CASE
END FUNCTION
#+ 產品分類說明
PRIVATE FUNCTION aooi380_oohh002_desc(p_oohh002)
   DEFINE p_oohh002   LIKE oohh_t.oohh002
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_oohh002
    CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1] 
END FUNCTION
#+產品分類資料檢查
PRIVATE FUNCTION aooi380_oohh002_chk(p_oohh002)
  DEFINE p_oohh002   LIKE oohh_t.oohh002
  DEFINE l_rtaxstus  LIKE rtax_t.rtaxstus
  
  LET g_errno = ''
  SELECT rtaxstus INTO l_rtaxstus FROM rtax_t
   WHERE rtaxent = g_enterprise
     AND rtax001 = p_oohh002
     
  CASE
     WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00137'
     WHEN l_rtaxstus = 'N'      LET g_errno = 'sub-01302' #aoo-00138  #160318-00005#31 by 07900 --mod
  END CASE
END FUNCTION
#+人员全称，职称
PRIVATE FUNCTION aooi380_oohc002_desc(p_oohc002)
    DEFINE p_oohc002                  LIKE oogf_t.oogf002
    DEFINE l_oohc002_desc             LIKE oofa_t.oofa011
    DEFINE l_oohc002_desc2            LIKE oofa_t.oofa011
 
    LET  l_oohc002_desc = ''
    LET  l_oohc002_desc2 = ''
    
     #1.以[C:員工編號]值到[T:員工檔]抓取[C:聯絡對象識別碼],再以[C:聯絡對象識別碼]
     # 到[T:聯絡對象檔]中抓取[C:全名]來顯示
    SELECT oofa011 INTO l_oohc002_desc FROM oofa_t
     WHERE oofaent = g_enterprise
       AND oofa001 = (SELECT ooag002 FROM ooag_t
                        WHERE ooagent = g_enterprise
                          AND ooag001 = p_oohc002)
      # 2.以[C:員工編號]值到[T:員工檔]抓取[C:職稱],再以[C:職稱]到[T:應用分類碼多語言檔]
      #   中抓取[C:說明] WHERE [C:應用分類]=5 AND [C:應用分類碼]=[C:職稱]
      SELECT oocql004  INTO l_oohc002_desc2 FROM oocql_t
       WHERE oocqlent = g_enterprise
            AND oocql001 = 5
            AND oocql002 = (SELECT ooag005 FROM ooag_t
                                            WHERE ooagent = g_enterprise
                                              AND ooag001 =  p_oohc002 )
            AND oocql003 = g_dlang                                     
                             
     RETURN l_oohc002_desc,l_oohc002_desc2   
END FUNCTION
#+人员编号资料检查存在有效
PRIVATE FUNCTION aooi380_oohc002_chk(p_oohc002)
   DEFINE p_oohc002         LIKE oohc_t.oohc002
   DEFINE  l_ooag001         LIKE ooag_t.ooag001
   DEFINE  l_ooagstus       LIKE ooag_t.ooagstus


   LET g_errno=''
   SELECT ooag001,ooagstus INTO l_ooag001,l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = p_oohc002

   CASE
      WHEN SQLCA.SQLCODE=100   LET g_errno = 'aoo-00074'
      WHEN l_ooagstus ='N'     LET g_errno = 'sub-01302' #aoo-00071  #160318-00005#31 by 07900 --mod
   END CASE   
END FUNCTION
#+客户/厂商说明
PRIVATE FUNCTION aooi380_oohd002_desc(p_oocq001,p_oocq002)
   DEFINE p_oocq001    LIKE oocq_t.oocq001
   DEFINE p_oocq002    LIKE oocq_t.oocq002  
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocq001
   LET g_ref_fields[2] = p_oocq002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION
#客户/厂商分类资料检查
PRIVATE FUNCTION aooi380_oohd002_chk(p_oocq001,p_oocq002)
DEFINE p_oocq001   LIKE oocq_t.oocq001 
DEFINE p_oocq002   LIKE oocq_t.oocq002
DEFINE l_oocqstus   LIKE oocq_t.oocqstus
 
   LET g_errno = ''
   SELECT oocqstus INTO l_oocqstus FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = p_oocq001
      AND oocq002 = p_oocq002
       
   IF p_oocq001=251 THEN    
      CASE
         WHEN SQLCA.sqlcode = 100  LET g_errno ='sub-01303' #apm-00098 #160318-00005#31 by 07900 --mod
         WHEN  l_oocqstus = 'N'    LET g_errno ='sub-01302' #apm-00099 #160318-00005#31 by 07900 --mod
      END CASE
   END IF 
   IF p_oocq001=281 THEN    
      CASE
         WHEN SQLCA.sqlcode = 100  LET g_errno ='sub-01303'  #apm-00092 #160318-00005#31 by 07900 --mod
         WHEN  l_oocqstus = 'N'    LET g_errno ='sub-01302'  #apm-00093 #160318-00005#31 by 07900 --mod
      END CASE
   END IF   
END FUNCTION
#檢查產品資料的存在有效性
PRIVATE FUNCTION aooi380_oohi002_chk(p_oohi002)
  DEFINE p_oohi002    LIKE oohi_t.oohi002
  DEFINE l_imaastus   LIKE imaa_t.imaastus
  
  LET g_errno = ''
  SELECT imaastus INTO l_imaastus FROM imaa_t
 	WHERE imaaent  = g_enterprise
      AND imaa001 = p_oohi002
  CASE
     WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aim-00001'
     WHEN l_imaastus = 'N'      LET g_errno = 'sub-01302' #aim-00002 #160318-00005#31 by 07900 --mod
  END CASE
END FUNCTION
#+ 庫位資料檢查
PRIVATE FUNCTION aooi380_oohl003_chk(p_oohl002,p_oohl003)
  	DEFINE p_oohl003   LIKE oohl_t.oohl003
   	DEFINE p_oohl002   LIKE oohl_t.oohl002
   	DEFINE l_inaastus  LIKE inaa_t.inaastus
   	
   	LET g_errno = ''
   	SELECT inaastus INTO l_inaastus FROM inaa_t
   	 WHERE inaaent = g_enterprise
   	   AND inaasite = p_oohl002
   	   AND inaa001 = p_oohl003
   	   
   	CASE
       WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aim-00064'
       WHEN l_inaastus = 'N'      LET g_errno = 'sub-01302'  #aim-00065 #160318-00005#31 by 07900 --mod
    END CASE
END FUNCTION
#產品品名規格
PRIVATE FUNCTION aooi380_oohi002_desc(p_oohi002)
 DEFINE p_oohi002   LIKE oohi_t.oohi002
 
  INITIALIZE g_ref_fields TO NULL
  LET g_ref_fields[1] = p_oohi002
  CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
  RETURN g_rtn_fields[1],g_rtn_fields[2]
 
END FUNCTION
#庫位名稱
PRIVATE FUNCTION aooi380_oohl003_desc(p_oohl003,p_oohl002)
   DEFINE p_oohl003   LIKE oohl_t.oohl003
   DEFINE p_oohl002   LIKE oohl_t.oohl002
   	
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oohl003
   LET g_ref_fields[2] = p_oohl002
   #CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? AND inaasite=? ","") RETURNING g_rtn_fields   #160503-00029#1 mark
   CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"' ","") RETURNING g_rtn_fields  #160503-00029#1
   RETURN  g_rtn_fields[1]
END FUNCTION

 
{</section>}
 
