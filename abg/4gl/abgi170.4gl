#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi170.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-12-23 16:10:17), PR版次:0006(2016-12-23 16:19:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi170
#+ Description: 預算料件組織資料維護
#+ Creator....: 06821(2016-08-10 13:49:02)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="abgi170.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#161111-00002#1  161111 By 06821     稅別開窗無資料
#161105-00004#2  161114 By Hans    1.新增或修改時, 預算細項可空白  2.增加批次更新預算細項功能
#                                  3.內採組織訊息頁籤, 據點對應交易對象編號及名稱隱藏  4.內採組織不可為單頭預算組織
#161129-00019#3  161205 By 08732   1.產品分類由abgi165 帶出顯示 2.單身對應料件:控管實體料只能對應一筆預算料, 同 abgi165管控
#161221-00034#1  161221 By 06821   畫面預算編號/組織/料件欄位寬度調為20
#161223-00027#1  161223 By 06821   單身"據點對應交易對象編號"欄位,串ooef024(aooi100) 且存在abgi150有效之預算交易對象,僅顯示不可修改
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
PRIVATE type type_g_bgea_m        RECORD
       bgea001 LIKE bgea_t.bgea001, 
   bgea001_desc LIKE type_t.chr80, 
   bgea002 LIKE bgea_t.bgea002, 
   bgea002_desc LIKE type_t.chr80, 
   bgea003 LIKE bgea_t.bgea003, 
   l_bgas005 LIKE type_t.chr10, 
   l_bgasl003 LIKE type_t.chr500, 
   l_bgasl004 LIKE type_t.chr500, 
   l_bgas009 LIKE type_t.chr10, 
   l_bgas009_desc LIKE type_t.chr80, 
   bgeastus LIKE bgea_t.bgeastus, 
   bgeaownid LIKE bgea_t.bgeaownid, 
   bgeaownid_desc LIKE type_t.chr80, 
   bgeaowndp LIKE bgea_t.bgeaowndp, 
   bgeaowndp_desc LIKE type_t.chr80, 
   bgeacrtid LIKE bgea_t.bgeacrtid, 
   bgeacrtid_desc LIKE type_t.chr80, 
   bgeacrtdp LIKE bgea_t.bgeacrtdp, 
   bgeacrtdp_desc LIKE type_t.chr80, 
   bgeacrtdt LIKE bgea_t.bgeacrtdt, 
   bgeamodid LIKE bgea_t.bgeamodid, 
   bgeamodid_desc LIKE type_t.chr80, 
   bgeamoddt LIKE bgea_t.bgeamoddt, 
   bgea009 LIKE bgea_t.bgea009, 
   bgea009_desc LIKE type_t.chr80, 
   bgea010 LIKE bgea_t.bgea010, 
   bgea010_desc LIKE type_t.chr80, 
   bgea011 LIKE bgea_t.bgea011, 
   bgea011_desc LIKE type_t.chr80, 
   bgea012 LIKE bgea_t.bgea012, 
   bgea012_desc LIKE type_t.chr80, 
   bgea013 LIKE bgea_t.bgea013, 
   bgea014 LIKE bgea_t.bgea014, 
   bgea004 LIKE bgea_t.bgea004, 
   bgea004_desc LIKE type_t.chr80, 
   bgea015 LIKE bgea_t.bgea015, 
   bgea015_desc LIKE type_t.chr80, 
   bgea016 LIKE bgea_t.bgea016, 
   bgea016_desc LIKE type_t.chr80, 
   bgea017 LIKE bgea_t.bgea017, 
   bgea017_desc LIKE type_t.chr80, 
   bgea018 LIKE bgea_t.bgea018, 
   bgea018_desc LIKE type_t.chr80, 
   bgea019 LIKE bgea_t.bgea019, 
   bgea020 LIKE bgea_t.bgea020, 
   bgea021 LIKE bgea_t.bgea021, 
   bgea022 LIKE bgea_t.bgea022, 
   bgea023 LIKE bgea_t.bgea023, 
   bgea024 LIKE bgea_t.bgea024, 
   bgea005 LIKE bgea_t.bgea005, 
   bgea005_desc LIKE type_t.chr80, 
   bgea025 LIKE bgea_t.bgea025, 
   bgea025_desc LIKE type_t.chr80, 
   bgea026 LIKE bgea_t.bgea026, 
   bgea026_desc LIKE type_t.chr80, 
   bgea027 LIKE bgea_t.bgea027, 
   bgea027_desc LIKE type_t.chr80, 
   bgea028 LIKE bgea_t.bgea028, 
   bgea029 LIKE bgea_t.bgea029, 
   bgea030 LIKE bgea_t.bgea030, 
   bgea031 LIKE bgea_t.bgea031, 
   bgea031_desc LIKE type_t.chr80, 
   bgea032 LIKE bgea_t.bgea032, 
   bgea033 LIKE bgea_t.bgea033, 
   bgea034 LIKE bgea_t.bgea034, 
   bgea035 LIKE bgea_t.bgea035, 
   bgea044 LIKE bgea_t.bgea044, 
   bgea006 LIKE bgea_t.bgea006, 
   bgea006_desc LIKE type_t.chr80, 
   bgea036 LIKE bgea_t.bgea036, 
   bgea037 LIKE bgea_t.bgea037, 
   bgea038 LIKE bgea_t.bgea038, 
   bgea039 LIKE bgea_t.bgea039, 
   bgea040 LIKE bgea_t.bgea040, 
   bgea041 LIKE bgea_t.bgea041, 
   bgea042 LIKE bgea_t.bgea042, 
   bgea043 LIKE bgea_t.bgea043
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bgeb_d        RECORD
       bgeb004 LIKE bgeb_t.bgeb004, 
   bgasl003_desc LIKE type_t.chr500, 
   bgasl004_desc LIKE type_t.chr500, 
   bgebownid LIKE bgeb_t.bgebownid, 
   bgebowndp LIKE bgeb_t.bgebowndp, 
   bgebcrtid LIKE bgeb_t.bgebcrtid, 
   bgebcrtdp LIKE bgeb_t.bgebcrtdp, 
   bgebcrtdt DATETIME YEAR TO SECOND, 
   bgebmodid LIKE bgeb_t.bgebmodid, 
   bgebmodid_desc LIKE type_t.chr500, 
   bgebmoddt DATETIME YEAR TO SECOND, 
   bgebstus LIKE bgeb_t.bgebstus
       END RECORD
PRIVATE TYPE type_g_bgeb2_d RECORD
       bgec004 LIKE bgec_t.bgec004, 
   bgec004_desc LIKE type_t.chr100, 
   l_bgec005 LIKE type_t.chr10, 
   bgec005_desc LIKE type_t.chr100, 
   bgec006 LIKE bgec_t.bgec006, 
   bgecownid LIKE bgec_t.bgecownid, 
   bgecowndp LIKE bgec_t.bgecowndp, 
   bgeccrtid LIKE bgec_t.bgeccrtid, 
   bgeccrtdp LIKE bgec_t.bgeccrtdp, 
   bgeccrtdt DATETIME YEAR TO SECOND, 
   bgecmodid LIKE bgec_t.bgecmodid, 
   bgecmodid_desc LIKE type_t.chr500, 
   bgecmoddt DATETIME YEAR TO SECOND, 
   bgecstus LIKE bgec_t.bgecstus
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_bgea001 LIKE bgea_t.bgea001,
      b_bgea002 LIKE bgea_t.bgea002,
      b_bgea003 LIKE bgea_t.bgea003
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef016    LIKE ooef_t.ooef016
DEFINE g_ooef017    LIKE ooef_t.ooef017
DEFINE g_ooef019    LIKE ooef_t.ooef019
DEFINE g_bgaa008    LIKE bgaa_t.bgaa008 
DEFINE g_wc_ooef019 LIKE ooef_t.ooef019     #查詢時g_site稅區     #161111-00002#1 add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_bgea_m          type_g_bgea_m
DEFINE g_bgea_m_t        type_g_bgea_m
DEFINE g_bgea_m_o        type_g_bgea_m
DEFINE g_bgea_m_mask_o   type_g_bgea_m #轉換遮罩前資料
DEFINE g_bgea_m_mask_n   type_g_bgea_m #轉換遮罩後資料
 
   DEFINE g_bgea001_t LIKE bgea_t.bgea001
DEFINE g_bgea002_t LIKE bgea_t.bgea002
DEFINE g_bgea003_t LIKE bgea_t.bgea003
 
 
DEFINE g_bgeb_d          DYNAMIC ARRAY OF type_g_bgeb_d
DEFINE g_bgeb_d_t        type_g_bgeb_d
DEFINE g_bgeb_d_o        type_g_bgeb_d
DEFINE g_bgeb_d_mask_o   DYNAMIC ARRAY OF type_g_bgeb_d #轉換遮罩前資料
DEFINE g_bgeb_d_mask_n   DYNAMIC ARRAY OF type_g_bgeb_d #轉換遮罩後資料
DEFINE g_bgeb2_d          DYNAMIC ARRAY OF type_g_bgeb2_d
DEFINE g_bgeb2_d_t        type_g_bgeb2_d
DEFINE g_bgeb2_d_o        type_g_bgeb2_d
DEFINE g_bgeb2_d_mask_o   DYNAMIC ARRAY OF type_g_bgeb2_d #轉換遮罩前資料
DEFINE g_bgeb2_d_mask_n   DYNAMIC ARRAY OF type_g_bgeb2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
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
 
{<section id="abgi170.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bgea001,'',bgea002,'',bgea003,'','','','','',bgeastus,bgeaownid,'',bgeaowndp, 
       '',bgeacrtid,'',bgeacrtdp,'',bgeacrtdt,bgeamodid,'',bgeamoddt,bgea009,'',bgea010,'',bgea011,'', 
       bgea012,'',bgea013,bgea014,bgea004,'',bgea015,'',bgea016,'',bgea017,'',bgea018,'',bgea019,bgea020, 
       bgea021,bgea022,bgea023,bgea024,bgea005,'',bgea025,'',bgea026,'',bgea027,'',bgea028,bgea029,bgea030, 
       bgea031,'',bgea032,bgea033,bgea034,bgea035,bgea044,bgea006,'',bgea036,bgea037,bgea038,bgea039, 
       bgea040,bgea041,bgea042,bgea043", 
                      " FROM bgea_t",
                      " WHERE bgeaent= ? AND bgea001=? AND bgea002=? AND bgea003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi170_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgea001,t0.bgea002,t0.bgea003,t0.bgeastus,t0.bgeaownid,t0.bgeaowndp, 
       t0.bgeacrtid,t0.bgeacrtdp,t0.bgeacrtdt,t0.bgeamodid,t0.bgeamoddt,t0.bgea009,t0.bgea010,t0.bgea011, 
       t0.bgea012,t0.bgea013,t0.bgea014,t0.bgea004,t0.bgea015,t0.bgea016,t0.bgea017,t0.bgea018,t0.bgea019, 
       t0.bgea020,t0.bgea021,t0.bgea022,t0.bgea023,t0.bgea024,t0.bgea005,t0.bgea025,t0.bgea026,t0.bgea027, 
       t0.bgea028,t0.bgea029,t0.bgea030,t0.bgea031,t0.bgea032,t0.bgea033,t0.bgea034,t0.bgea035,t0.bgea044, 
       t0.bgea006,t0.bgea036,t0.bgea037,t0.bgea038,t0.bgea039,t0.bgea040,t0.bgea041,t0.bgea042,t0.bgea043, 
       t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011",
               " FROM bgea_t t0",
                              " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.bgeaownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.bgeaowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.bgeacrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.bgeacrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.bgeamodid  ",
 
               " WHERE t0.bgeaent = " ||g_enterprise|| " AND t0.bgea001 = ? AND t0.bgea002 = ? AND t0.bgea003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgi170_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgi170 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgi170_init()   
 
      #進入選單 Menu (="N")
      CALL abgi170_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgi170
      
   END IF 
   
   CLOSE abgi170_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgi170.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgi170_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('bgeastus','17','Y,N')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc('l_bgas005','1001')
   #end add-point
   
   #初始化搜尋條件
   CALL abgi170_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgi170.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgi170_ui_dialog()
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
            CALL abgi170_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #幣別/取得據點所屬法人/稅區
   LET g_ooef016 = '' 
   LET g_ooef017 = '' 
   LET g_ooef019 = ''
   SELECT ooef016,ooef017,ooef019 INTO g_ooef016,g_ooef017,g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_bgea_m.bgea002
    
   #重新導向至第一頁簽欄位
   CALL gfrm_curr.ensureFieldVisible("bgea_t.bgea009")
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_bgea_m.* TO NULL
         CALL g_bgeb_d.clear()
         CALL g_bgeb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgi170_init()
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
               
               CALL abgi170_fetch('') # reload data
               LET l_ac = 1
               CALL abgi170_ui_detailshow() #Setting the current row 
         
               CALL abgi170_idx_chk()
               #NEXT FIELD bgeb004
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_bgeb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abgi170_idx_chk()
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
               CALL abgi170_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_bgeb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL abgi170_idx_chk()
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
               CALL abgi170_idx_chk()
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
            CALL abgi170_browser_fill("")
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
               CALL abgi170_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgi170_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL abgi170_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #重新導向至第一頁簽欄位
            CALL gfrm_curr.ensureFieldVisible("bgea_t.bgea009")
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL abgi170_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL abgi170_set_act_visible()   
            CALL abgi170_set_act_no_visible()
            IF NOT (g_bgea_m.bgea001 IS NULL
              OR g_bgea_m.bgea002 IS NULL
              OR g_bgea_m.bgea003 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " bgeaent = " ||g_enterprise|| " AND",
                                  " bgea001 = '", g_bgea_m.bgea001, "' "
                                  ," AND bgea002 = '", g_bgea_m.bgea002, "' "
                                  ," AND bgea003 = '", g_bgea_m.bgea003, "' "
 
               #填到對應位置
               CALL abgi170_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "bgea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bgeb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bgec_t" 
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
               CALL abgi170_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "bgea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bgeb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "bgec_t" 
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
                  CALL abgi170_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL abgi170_fetch("F")
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
               CALL abgi170_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgi170_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi170_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgi170_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi170_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgi170_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi170_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgi170_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi170_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgi170_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgi170_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_bgeb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bgeb2_d)
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
               NEXT FIELD bgeb004
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
               CALL abgi170_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgi170_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_abgi170_01
            LET g_action_choice="open_abgi170_01"
            IF cl_auth_chk_act("open_abgi170_01") THEN
               
               #add-point:ON ACTION open_abgi170_01 name="menu.open_abgi170_01"
               #161105-00004#2---s---
               CALL s_transaction_begin()
               CALL abgi170_01()RETURNING g_sub_success,g_bgea_m.bgea001,g_bgea_m.bgea002
               IF g_sub_success THEN
                  CALL s_transaction_end('Y',0)
                  LET g_wc = " 1=1 AND bgea001 = '",g_bgea_m.bgea001,"' AND bgea002 ='",g_bgea_m.bgea002,"' "
                  CALL abgi170_browser_fill("")
                  LET g_no_ask = TRUE
                  LET g_jump = 1
                  LET g_action_choice = '' #161105-00004#1
                  CALL abgi170_fetch('/')
                  CALL abgi170_idx_chk()
                  #顯示成功訊息
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'axm-00088'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  CALL s_transaction_end('N',0)
               END IF
               #161105-00004#2---e---
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgi170_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #重新導向至第一頁簽欄位
               CALL gfrm_curr.ensureFieldVisible("bgea_t.bgea009")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgi170_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL abgi170_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgi170_query()
               #add-point:ON ACTION query name="menu.query"
               #重新導向至第一頁簽欄位
               CALL gfrm_curr.ensureFieldVisible("bgea_t.bgea009")
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgi170_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgi170_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgi170_set_pk_array()
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
 
{<section id="abgi170.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgi170_browser_fill(ps_page_action)
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
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT bgea001,bgea002,bgea003 ",
                      " FROM bgea_t ",
                      " ",
                      " LEFT JOIN bgeb_t ON bgebent = bgeaent AND bgea001 = bgeb001 AND bgea002 = bgeb002 AND bgea003 = bgeb003 ", "  ",
                      #add-point:browser_fill段sql(bgeb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN bgec_t ON bgecent = bgeaent AND bgea001 = bgec001 AND bgea002 = bgec002 AND bgea003 = bgec003", "  ",
                      #add-point:browser_fill段sql(bgec_t1) name="browser_fill.cnt.join.bgec_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE bgeaent = " ||g_enterprise|| " AND bgebent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bgea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bgea001,bgea002,bgea003 ",
                      " FROM bgea_t ", 
                      "  ",
                      "  ",
                      " WHERE bgeaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bgea_t")
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
      INITIALIZE g_bgea_m.* TO NULL
      CALL g_bgeb_d.clear()        
      CALL g_bgeb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bgea001,t0.bgea002,t0.bgea003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bgeastus,t0.bgea001,t0.bgea002,t0.bgea003 ",
                  " FROM bgea_t t0",
                  "  ",
                  "  LEFT JOIN bgeb_t ON bgebent = bgeaent AND bgea001 = bgeb001 AND bgea002 = bgeb002 AND bgea003 = bgeb003 ", "  ", 
                  #add-point:browser_fill段sql(bgeb_t1) name="browser_fill.join.bgeb_t1"
                  
                  #end add-point
                  "  LEFT JOIN bgec_t ON bgecent = bgeaent AND bgea001 = bgec001 AND bgea002 = bgec002 AND bgea003 = bgec003", "  ", 
                  #add-point:browser_fill段sql(bgec_t1) name="browser_fill.join.bgec_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.bgeaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("bgea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.bgeastus,t0.bgea001,t0.bgea002,t0.bgea003 ",
                  " FROM bgea_t t0",
                  "  ",
                  
                  " WHERE t0.bgeaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("bgea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY bgea001,bgea002,bgea003 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_bgea001,g_browser[g_cnt].b_bgea002, 
          g_browser[g_cnt].b_bgea003
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
         CALL abgi170_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_bgea001) THEN
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
   #重新導向至第一頁簽欄位
   CALL gfrm_curr.ensureFieldVisible("bgea_t.bgea009")
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="abgi170.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgi170_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bgea_m.bgea001 = g_browser[g_current_idx].b_bgea001   
   LET g_bgea_m.bgea002 = g_browser[g_current_idx].b_bgea002   
   LET g_bgea_m.bgea003 = g_browser[g_current_idx].b_bgea003   
 
   EXECUTE abgi170_master_referesh USING g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgea_m.bgea001, 
       g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp,g_bgea_m.bgeacrtid, 
       g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt,g_bgea_m.bgea009, 
       g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
       g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025, 
       g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041, 
       g_bgea_m.bgea042,g_bgea_m.bgea043,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp_desc,g_bgea_m.bgeacrtid_desc, 
       g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeamodid_desc
   
   CALL abgi170_bgea_t_mask()
   CALL abgi170_show()
      
END FUNCTION
 
{</section>}
 
{<section id="abgi170.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgi170_ui_detailshow()
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
 
{<section id="abgi170.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgi170_ui_browser_refresh()
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
      IF g_browser[l_i].b_bgea001 = g_bgea_m.bgea001 
         AND g_browser[l_i].b_bgea002 = g_bgea_m.bgea002 
         AND g_browser[l_i].b_bgea003 = g_bgea_m.bgea003 
 
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
 
{<section id="abgi170.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgi170_construct()
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
   INITIALIZE g_bgea_m.* TO NULL
   CALL g_bgeb_d.clear()        
   CALL g_bgeb2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON bgea001,bgea002,bgea003,bgeastus,bgeaownid,bgeaowndp,bgeacrtid,bgeacrtdp, 
          bgeacrtdt,bgeamodid,bgeamoddt,bgea009,bgea010,bgea011,bgea012,bgea013,bgea014,bgea004,bgea015, 
          bgea016,bgea017,bgea018,bgea019,bgea020,bgea021,bgea022,bgea023,bgea024,bgea005,bgea025,bgea026, 
          bgea027,bgea028,bgea029,bgea030,bgea031,bgea032,bgea033,bgea034,bgea035,bgea044,bgea006,bgea036, 
          bgea037,bgea038,bgea039,bgea040,bgea041,bgea042,bgea043
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            #161111-00002#1 --s add
            #查詢時發票類型開窗稅區條件
            LET g_wc_ooef019 = ''
            SELECT ooef019 INTO g_wc_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            #161111-00002#1 --e add
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgeacrtdt>>----
         AFTER FIELD bgeacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgeamoddt>>----
         AFTER FIELD bgeamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgeacnfdt>>----
         
         #----<<bgeapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea001
            #add-point:BEFORE FIELD bgea001 name="construct.b.bgea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea001
            
            #add-point:AFTER FIELD bgea001 name="construct.a.bgea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea001
            #add-point:ON ACTION controlp INFIELD bgea001 name="construct.c.bgea001"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   
            LET g_qryparam.state = 'c'  
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaastus = 'Y' "
            CALL q_bgaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea001  #顯示到畫面上
            NEXT FIELD bgea001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea002
            #add-point:BEFORE FIELD bgea002 name="construct.b.bgea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea002
            
            #add-point:AFTER FIELD bgea002 name="construct.a.bgea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea002
            #add-point:ON ACTION controlp INFIELD bgea002 name="construct.c.bgea002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO bgea002
            NEXT FIELD bgea002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea003
            #add-point:BEFORE FIELD bgea003 name="construct.b.bgea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea003
            
            #add-point:AFTER FIELD bgea003 name="construct.a.bgea003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea003
            #add-point:ON ACTION controlp INFIELD bgea003 name="construct.c.bgea003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgasstus = 'Y' "
            CALL q_bgas001()
            DISPLAY g_qryparam.return1 TO bgea003
            NEXT FIELD bgea003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeastus
            #add-point:BEFORE FIELD bgeastus name="construct.b.bgeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeastus
            
            #add-point:AFTER FIELD bgeastus name="construct.a.bgeastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeastus
            #add-point:ON ACTION controlp INFIELD bgeastus name="construct.c.bgeastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgeaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeaownid
            #add-point:ON ACTION controlp INFIELD bgeaownid name="construct.c.bgeaownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeaownid  #顯示到畫面上
            NEXT FIELD bgeaownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeaownid
            #add-point:BEFORE FIELD bgeaownid name="construct.b.bgeaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeaownid
            
            #add-point:AFTER FIELD bgeaownid name="construct.a.bgeaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeaowndp
            #add-point:ON ACTION controlp INFIELD bgeaowndp name="construct.c.bgeaowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeaowndp  #顯示到畫面上
            NEXT FIELD bgeaowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeaowndp
            #add-point:BEFORE FIELD bgeaowndp name="construct.b.bgeaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeaowndp
            
            #add-point:AFTER FIELD bgeaowndp name="construct.a.bgeaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeacrtid
            #add-point:ON ACTION controlp INFIELD bgeacrtid name="construct.c.bgeacrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeacrtid  #顯示到畫面上
            NEXT FIELD bgeacrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeacrtid
            #add-point:BEFORE FIELD bgeacrtid name="construct.b.bgeacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeacrtid
            
            #add-point:AFTER FIELD bgeacrtid name="construct.a.bgeacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgeacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeacrtdp
            #add-point:ON ACTION controlp INFIELD bgeacrtdp name="construct.c.bgeacrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeacrtdp  #顯示到畫面上
            NEXT FIELD bgeacrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeacrtdp
            #add-point:BEFORE FIELD bgeacrtdp name="construct.b.bgeacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeacrtdp
            
            #add-point:AFTER FIELD bgeacrtdp name="construct.a.bgeacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeacrtdt
            #add-point:BEFORE FIELD bgeacrtdt name="construct.b.bgeacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgeamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeamodid
            #add-point:ON ACTION controlp INFIELD bgeamodid name="construct.c.bgeamodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeamodid  #顯示到畫面上
            NEXT FIELD bgeamodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeamodid
            #add-point:BEFORE FIELD bgeamodid name="construct.b.bgeamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeamodid
            
            #add-point:AFTER FIELD bgeamodid name="construct.a.bgeamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeamoddt
            #add-point:BEFORE FIELD bgeamoddt name="construct.b.bgeamoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea009
            #add-point:BEFORE FIELD bgea009 name="construct.b.bgea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea009
            
            #add-point:AFTER FIELD bgea009 name="construct.a.bgea009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea009
            #add-point:ON ACTION controlp INFIELD bgea009 name="construct.c.bgea009"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imcd111_1()   
            DISPLAY g_qryparam.return1 TO bgea009  #顯示到畫面上
            NEXT FIELD bgea009                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea010
            #add-point:BEFORE FIELD bgea010 name="construct.b.bgea010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea010
            
            #add-point:AFTER FIELD bgea010 name="construct.a.bgea010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea010
            #add-point:ON ACTION controlp INFIELD bgea010 name="construct.c.bgea010"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus = 'Y' "
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea010  #顯示到畫面上
            NEXT FIELD bgea010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea011
            #add-point:BEFORE FIELD bgea011 name="construct.b.bgea011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea011
            
            #add-point:AFTER FIELD bgea011 name="construct.a.bgea011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea011
            #add-point:ON ACTION controlp INFIELD bgea011 name="construct.c.bgea011"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus = 'Y' "
            CALL q_bgap001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea011  #顯示到畫面上
            NEXT FIELD bgea011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea012
            #add-point:BEFORE FIELD bgea012 name="construct.b.bgea012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea012
            
            #add-point:AFTER FIELD bgea012 name="construct.a.bgea012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea012
            #add-point:ON ACTION controlp INFIELD bgea012 name="construct.c.bgea012"
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
   			#LET g_qryparam.arg1 = g_ooef019   #161111-00002#1 mark
   			LET g_qryparam.arg1 = g_wc_ooef019 #161111-00002#1 add
            CALL q_oodb002_5()               
            DISPLAY g_qryparam.return1 TO bgea012  #顯示到畫面上
            NEXT FIELD bgea012   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea013
            #add-point:BEFORE FIELD bgea013 name="construct.b.bgea013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea013
            
            #add-point:AFTER FIELD bgea013 name="construct.a.bgea013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea013
            #add-point:ON ACTION controlp INFIELD bgea013 name="construct.c.bgea013"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea013  #顯示到畫面上
            NEXT FIELD bgea013                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea014
            #add-point:BEFORE FIELD bgea014 name="construct.b.bgea014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea014
            
            #add-point:AFTER FIELD bgea014 name="construct.a.bgea014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea014
            #add-point:ON ACTION controlp INFIELD bgea014 name="construct.c.bgea014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea004
            #add-point:BEFORE FIELD bgea004 name="construct.b.bgea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea004
            
            #add-point:AFTER FIELD bgea004 name="construct.a.bgea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea004
            #add-point:ON ACTION controlp INFIELD bgea004 name="construct.c.bgea004"
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " bgae007='1' AND bgae005='1' "
            CALL q_bgae001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea004  #顯示到畫面上
            NEXT FIELD bgea004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea015
            #add-point:BEFORE FIELD bgea015 name="construct.b.bgea015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea015
            
            #add-point:AFTER FIELD bgea015 name="construct.a.bgea015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea015
            #add-point:ON ACTION controlp INFIELD bgea015 name="construct.c.bgea015"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imce141_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea015  #顯示到畫面上
            NEXT FIELD bgea015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea016
            #add-point:BEFORE FIELD bgea016 name="construct.b.bgea016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea016
            
            #add-point:AFTER FIELD bgea016 name="construct.a.bgea016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea016
            #add-point:ON ACTION controlp INFIELD bgea016 name="construct.c.bgea016"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus = 'Y' "
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea016  #顯示到畫面上
            NEXT FIELD bgea016                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea017
            #add-point:BEFORE FIELD bgea017 name="construct.b.bgea017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea017
            
            #add-point:AFTER FIELD bgea017 name="construct.a.bgea017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea017
            #add-point:ON ACTION controlp INFIELD bgea017 name="construct.c.bgea017"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus = 'Y' "
            CALL q_bgap001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea017  #顯示到畫面上
            NEXT FIELD bgea017                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea018
            #add-point:BEFORE FIELD bgea018 name="construct.b.bgea018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea018
            
            #add-point:AFTER FIELD bgea018 name="construct.a.bgea018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea018
            #add-point:ON ACTION controlp INFIELD bgea018 name="construct.c.bgea018"
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
   			#LET g_qryparam.arg1 = g_ooef019   #161111-00002#1 mark
   			LET g_qryparam.arg1 = g_wc_ooef019 #161111-00002#1 add
            CALL q_oodb002_5()               
            DISPLAY g_qryparam.return1 TO bgea018  #顯示到畫面上
            NEXT FIELD bgea018  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea019
            #add-point:BEFORE FIELD bgea019 name="construct.b.bgea019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea019
            
            #add-point:AFTER FIELD bgea019 name="construct.a.bgea019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea019
            #add-point:ON ACTION controlp INFIELD bgea019 name="construct.c.bgea019"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea019  #顯示到畫面上
            NEXT FIELD bgea019                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea020
            #add-point:BEFORE FIELD bgea020 name="construct.b.bgea020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea020
            
            #add-point:AFTER FIELD bgea020 name="construct.a.bgea020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea020
            #add-point:ON ACTION controlp INFIELD bgea020 name="construct.c.bgea020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea021
            #add-point:BEFORE FIELD bgea021 name="construct.b.bgea021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea021
            
            #add-point:AFTER FIELD bgea021 name="construct.a.bgea021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea021
            #add-point:ON ACTION controlp INFIELD bgea021 name="construct.c.bgea021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea022
            #add-point:BEFORE FIELD bgea022 name="construct.b.bgea022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea022
            
            #add-point:AFTER FIELD bgea022 name="construct.a.bgea022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea022
            #add-point:ON ACTION controlp INFIELD bgea022 name="construct.c.bgea022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea023
            #add-point:BEFORE FIELD bgea023 name="construct.b.bgea023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea023
            
            #add-point:AFTER FIELD bgea023 name="construct.a.bgea023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea023
            #add-point:ON ACTION controlp INFIELD bgea023 name="construct.c.bgea023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea024
            #add-point:BEFORE FIELD bgea024 name="construct.b.bgea024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea024
            
            #add-point:AFTER FIELD bgea024 name="construct.a.bgea024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea024
            #add-point:ON ACTION controlp INFIELD bgea024 name="construct.c.bgea024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea005
            #add-point:BEFORE FIELD bgea005 name="construct.b.bgea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea005
            
            #add-point:AFTER FIELD bgea005 name="construct.a.bgea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea005
            #add-point:ON ACTION controlp INFIELD bgea005 name="construct.c.bgea005"
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " bgae007='1' AND bgae005='3' "
            CALL q_bgae001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea005  #顯示到畫面上
            NEXT FIELD bgea005                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea025
            #add-point:BEFORE FIELD bgea025 name="construct.b.bgea025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea025
            
            #add-point:AFTER FIELD bgea025 name="construct.a.bgea025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea025
            #add-point:ON ACTION controlp INFIELD bgea025 name="construct.c.bgea025"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus ='Y' "
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea025  #顯示到畫面上
            NEXT FIELD bgea025                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea026
            #add-point:BEFORE FIELD bgea026 name="construct.b.bgea026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea026
            
            #add-point:AFTER FIELD bgea026 name="construct.a.bgea026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea026
            #add-point:ON ACTION controlp INFIELD bgea026 name="construct.c.bgea026"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus = 'Y' "
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea026  #顯示到畫面上
            NEXT FIELD bgea026                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea027
            #add-point:BEFORE FIELD bgea027 name="construct.b.bgea027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea027
            
            #add-point:AFTER FIELD bgea027 name="construct.a.bgea027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea027
            #add-point:ON ACTION controlp INFIELD bgea027 name="construct.c.bgea027"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus ='Y' "
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea027  #顯示到畫面上
            NEXT FIELD bgea027                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea028
            #add-point:BEFORE FIELD bgea028 name="construct.b.bgea028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea028
            
            #add-point:AFTER FIELD bgea028 name="construct.a.bgea028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea028
            #add-point:ON ACTION controlp INFIELD bgea028 name="construct.c.bgea028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea029
            #add-point:BEFORE FIELD bgea029 name="construct.b.bgea029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea029
            
            #add-point:AFTER FIELD bgea029 name="construct.a.bgea029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea029
            #add-point:ON ACTION controlp INFIELD bgea029 name="construct.c.bgea029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea030
            #add-point:BEFORE FIELD bgea030 name="construct.b.bgea030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea030
            
            #add-point:AFTER FIELD bgea030 name="construct.a.bgea030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea030
            #add-point:ON ACTION controlp INFIELD bgea030 name="construct.c.bgea030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea031
            #add-point:BEFORE FIELD bgea031 name="construct.b.bgea031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea031
            
            #add-point:AFTER FIELD bgea031 name="construct.a.bgea031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea031
            #add-point:ON ACTION controlp INFIELD bgea031 name="construct.c.bgea031"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "206"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea031  #顯示到畫面上
            NEXT FIELD bgea031                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea032
            #add-point:BEFORE FIELD bgea032 name="construct.b.bgea032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea032
            
            #add-point:AFTER FIELD bgea032 name="construct.a.bgea032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea032
            #add-point:ON ACTION controlp INFIELD bgea032 name="construct.c.bgea032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea033
            #add-point:BEFORE FIELD bgea033 name="construct.b.bgea033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea033
            
            #add-point:AFTER FIELD bgea033 name="construct.a.bgea033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea033
            #add-point:ON ACTION controlp INFIELD bgea033 name="construct.c.bgea033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea034
            #add-point:BEFORE FIELD bgea034 name="construct.b.bgea034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea034
            
            #add-point:AFTER FIELD bgea034 name="construct.a.bgea034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea034
            #add-point:ON ACTION controlp INFIELD bgea034 name="construct.c.bgea034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea035
            #add-point:BEFORE FIELD bgea035 name="construct.b.bgea035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea035
            
            #add-point:AFTER FIELD bgea035 name="construct.a.bgea035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea035
            #add-point:ON ACTION controlp INFIELD bgea035 name="construct.c.bgea035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea044
            #add-point:BEFORE FIELD bgea044 name="construct.b.bgea044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea044
            
            #add-point:AFTER FIELD bgea044 name="construct.a.bgea044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea044
            #add-point:ON ACTION controlp INFIELD bgea044 name="construct.c.bgea044"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea044  #顯示到畫面上
            NEXT FIELD bgea044 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea006
            #add-point:BEFORE FIELD bgea006 name="construct.b.bgea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea006
            
            #add-point:AFTER FIELD bgea006 name="construct.a.bgea006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea006
            #add-point:ON ACTION controlp INFIELD bgea006 name="construct.c.bgea006"
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " bgae007='1' AND bgae005='2' "
            CALL q_bgae001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgea006  #顯示到畫面上
            NEXT FIELD bgea006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea036
            #add-point:BEFORE FIELD bgea036 name="construct.b.bgea036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea036
            
            #add-point:AFTER FIELD bgea036 name="construct.a.bgea036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea036
            #add-point:ON ACTION controlp INFIELD bgea036 name="construct.c.bgea036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea037
            #add-point:BEFORE FIELD bgea037 name="construct.b.bgea037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea037
            
            #add-point:AFTER FIELD bgea037 name="construct.a.bgea037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea037
            #add-point:ON ACTION controlp INFIELD bgea037 name="construct.c.bgea037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea038
            #add-point:BEFORE FIELD bgea038 name="construct.b.bgea038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea038
            
            #add-point:AFTER FIELD bgea038 name="construct.a.bgea038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea038
            #add-point:ON ACTION controlp INFIELD bgea038 name="construct.c.bgea038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea039
            #add-point:BEFORE FIELD bgea039 name="construct.b.bgea039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea039
            
            #add-point:AFTER FIELD bgea039 name="construct.a.bgea039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea039
            #add-point:ON ACTION controlp INFIELD bgea039 name="construct.c.bgea039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea040
            #add-point:BEFORE FIELD bgea040 name="construct.b.bgea040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea040
            
            #add-point:AFTER FIELD bgea040 name="construct.a.bgea040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea040
            #add-point:ON ACTION controlp INFIELD bgea040 name="construct.c.bgea040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea041
            #add-point:BEFORE FIELD bgea041 name="construct.b.bgea041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea041
            
            #add-point:AFTER FIELD bgea041 name="construct.a.bgea041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea041
            #add-point:ON ACTION controlp INFIELD bgea041 name="construct.c.bgea041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea042
            #add-point:BEFORE FIELD bgea042 name="construct.b.bgea042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea042
            
            #add-point:AFTER FIELD bgea042 name="construct.a.bgea042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea042
            #add-point:ON ACTION controlp INFIELD bgea042 name="construct.c.bgea042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea043
            #add-point:BEFORE FIELD bgea043 name="construct.b.bgea043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea043
            
            #add-point:AFTER FIELD bgea043 name="construct.a.bgea043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgea043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea043
            #add-point:ON ACTION controlp INFIELD bgea043 name="construct.c.bgea043"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON bgeb004
           FROM s_detail1[1].bgeb004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgebcrtdt>>----
         AFTER FIELD bgebcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgebmoddt>>----
         AFTER FIELD bgebmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgebcnfdt>>----
         
         #----<<bgebpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeb004
            #add-point:BEFORE FIELD bgeb004 name="construct.b.page1.bgeb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeb004
            
            #add-point:AFTER FIELD bgeb004 name="construct.a.page1.bgeb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeb004
            #add-point:ON ACTION controlp INFIELD bgeb004 name="construct.c.page1.bgeb004"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_7()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgeb004  #顯示到畫面上
            NEXT FIELD bgeb004                     #返回原欄位
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON bgec004,bgec006
           FROM s_detail2[1].bgec004,s_detail2[1].bgec006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgeccrtdt>>----
         AFTER FIELD bgeccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgecmoddt>>----
         AFTER FIELD bgecmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgeccnfdt>>----
         
         #----<<bgecpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgec004
            #add-point:BEFORE FIELD bgec004 name="construct.b.page2.bgec004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgec004
            
            #add-point:AFTER FIELD bgec004 name="construct.a.page2.bgec004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgec004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgec004
            #add-point:ON ACTION controlp INFIELD bgec004 name="construct.c.page2.bgec004"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO bgec004
            NEXT FIELD bgec004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgec006
            #add-point:BEFORE FIELD bgec006 name="construct.b.page2.bgec006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgec006
            
            #add-point:AFTER FIELD bgec006 name="construct.a.page2.bgec006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgec006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgec006
            #add-point:ON ACTION controlp INFIELD bgec006 name="construct.c.page2.bgec006"
            
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
                  WHEN la_wc[li_idx].tableid = "bgea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bgeb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "bgec_t" 
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
 
{<section id="abgi170.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abgi170_filter()
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
      CONSTRUCT g_wc_filter ON bgea001,bgea002,bgea003
                          FROM s_browse[1].b_bgea001,s_browse[1].b_bgea002,s_browse[1].b_bgea003
 
         BEFORE CONSTRUCT
               DISPLAY abgi170_filter_parser('bgea001') TO s_browse[1].b_bgea001
            DISPLAY abgi170_filter_parser('bgea002') TO s_browse[1].b_bgea002
            DISPLAY abgi170_filter_parser('bgea003') TO s_browse[1].b_bgea003
      
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
 
      CALL abgi170_filter_show('bgea001')
   CALL abgi170_filter_show('bgea002')
   CALL abgi170_filter_show('bgea003')
 
END FUNCTION
 
{</section>}
 
{<section id="abgi170.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abgi170_filter_parser(ps_field)
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
 
{<section id="abgi170.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abgi170_filter_show(ps_field)
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
   LET ls_condition = abgi170_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgi170.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgi170_query()
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
   CALL g_bgeb_d.clear()
   CALL g_bgeb2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL abgi170_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgi170_browser_fill("")
      CALL abgi170_fetch("")
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
      CALL abgi170_filter_show('bgea001')
   CALL abgi170_filter_show('bgea002')
   CALL abgi170_filter_show('bgea003')
   CALL abgi170_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL abgi170_fetch("F") 
      #顯示單身筆數
      CALL abgi170_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgi170.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgi170_fetch(p_flag)
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
   
   LET g_bgea_m.bgea001 = g_browser[g_current_idx].b_bgea001
   LET g_bgea_m.bgea002 = g_browser[g_current_idx].b_bgea002
   LET g_bgea_m.bgea003 = g_browser[g_current_idx].b_bgea003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgi170_master_referesh USING g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgea_m.bgea001, 
       g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp,g_bgea_m.bgeacrtid, 
       g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt,g_bgea_m.bgea009, 
       g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
       g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025, 
       g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041, 
       g_bgea_m.bgea042,g_bgea_m.bgea043,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp_desc,g_bgea_m.bgeacrtid_desc, 
       g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeamodid_desc
   
   #遮罩相關處理
   LET g_bgea_m_mask_o.* =  g_bgea_m.*
   CALL abgi170_bgea_t_mask()
   LET g_bgea_m_mask_n.* =  g_bgea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abgi170_set_act_visible()   
   CALL abgi170_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   #重新導向至第一頁簽欄位
   CALL gfrm_curr.ensureFieldVisible("bgea_t.bgea009")
   #end add-point
   
   #保存單頭舊值
   LET g_bgea_m_t.* = g_bgea_m.*
   LET g_bgea_m_o.* = g_bgea_m.*
   
   LET g_data_owner = g_bgea_m.bgeaownid      
   LET g_data_dept  = g_bgea_m.bgeaowndp
   
   #重新顯示   
   CALL abgi170_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgi170.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgi170_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_bgeb_d.clear()   
   CALL g_bgeb2_d.clear()  
 
 
   INITIALIZE g_bgea_m.* TO NULL             #DEFAULT 設定
   
   LET g_bgea001_t = NULL
   LET g_bgea002_t = NULL
   LET g_bgea003_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgea_m.bgeaownid = g_user
      LET g_bgea_m.bgeaowndp = g_dept
      LET g_bgea_m.bgeacrtid = g_user
      LET g_bgea_m.bgeacrtdp = g_dept 
      LET g_bgea_m.bgeacrtdt = cl_get_current()
      LET g_bgea_m.bgeamodid = g_user
      LET g_bgea_m.bgeamoddt = cl_get_current()
      LET g_bgea_m.bgeastus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_bgea_m.bgea014 = "0"
      LET g_bgea_m.bgea020 = "0"
      LET g_bgea_m.bgea021 = "0"
      LET g_bgea_m.bgea022 = "0"
      LET g_bgea_m.bgea023 = "0"
      LET g_bgea_m.bgea024 = "0"
      LET g_bgea_m.bgea028 = "0"
      LET g_bgea_m.bgea029 = "0"
      LET g_bgea_m.bgea030 = "0"
      LET g_bgea_m.bgea032 = "0"
      LET g_bgea_m.bgea033 = "0"
      LET g_bgea_m.bgea034 = "0"
      LET g_bgea_m.bgea035 = "0"
      LET g_bgea_m.bgea036 = "0"
      LET g_bgea_m.bgea037 = "0"
      LET g_bgea_m.bgea038 = "0"
      LET g_bgea_m.bgea039 = "0"
      LET g_bgea_m.bgea040 = "0"
      LET g_bgea_m.bgea041 = "0"
      LET g_bgea_m.bgea042 = "0"
      LET g_bgea_m.bgea043 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bgea_m_t.* = g_bgea_m.*
      LET g_bgea_m_o.* = g_bgea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bgea_m.bgeastus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         
      END CASE
 
 
 
    
      CALL abgi170_input("a")
      
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
         INITIALIZE g_bgea_m.* TO NULL
         INITIALIZE g_bgeb_d TO NULL
         INITIALIZE g_bgeb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL abgi170_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_bgeb_d.clear()
      #CALL g_bgeb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL abgi170_set_act_visible()   
   CALL abgi170_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bgea001_t = g_bgea_m.bgea001
   LET g_bgea002_t = g_bgea_m.bgea002
   LET g_bgea003_t = g_bgea_m.bgea003
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgeaent = " ||g_enterprise|| " AND",
                      " bgea001 = '", g_bgea_m.bgea001, "' "
                      ," AND bgea002 = '", g_bgea_m.bgea002, "' "
                      ," AND bgea003 = '", g_bgea_m.bgea003, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgi170_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE abgi170_cl
   
   CALL abgi170_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgi170_master_referesh USING g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgea_m.bgea001, 
       g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp,g_bgea_m.bgeacrtid, 
       g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt,g_bgea_m.bgea009, 
       g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
       g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025, 
       g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041, 
       g_bgea_m.bgea042,g_bgea_m.bgea043,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp_desc,g_bgea_m.bgeacrtid_desc, 
       g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeamodid_desc
   
   
   #遮罩相關處理
   LET g_bgea_m_mask_o.* =  g_bgea_m.*
   CALL abgi170_bgea_t_mask()
   LET g_bgea_m_mask_n.* =  g_bgea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc,g_bgea_m.bgea002,g_bgea_m.bgea002_desc,g_bgea_m.bgea003, 
       g_bgea_m.l_bgas005,g_bgea_m.l_bgasl003,g_bgea_m.l_bgasl004,g_bgea_m.l_bgas009,g_bgea_m.l_bgas009_desc, 
       g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp,g_bgea_m.bgeaowndp_desc, 
       g_bgea_m.bgeacrtid,g_bgea_m.bgeacrtid_desc,g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeacrtdt, 
       g_bgea_m.bgeamodid,g_bgea_m.bgeamodid_desc,g_bgea_m.bgeamoddt,g_bgea_m.bgea009,g_bgea_m.bgea009_desc, 
       g_bgea_m.bgea010,g_bgea_m.bgea010_desc,g_bgea_m.bgea011,g_bgea_m.bgea011_desc,g_bgea_m.bgea012, 
       g_bgea_m.bgea012_desc,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004,g_bgea_m.bgea004_desc, 
       g_bgea_m.bgea015,g_bgea_m.bgea015_desc,g_bgea_m.bgea016,g_bgea_m.bgea016_desc,g_bgea_m.bgea017, 
       g_bgea_m.bgea017_desc,g_bgea_m.bgea018,g_bgea_m.bgea018_desc,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea005_desc, 
       g_bgea_m.bgea025,g_bgea_m.bgea025_desc,g_bgea_m.bgea026,g_bgea_m.bgea026_desc,g_bgea_m.bgea027, 
       g_bgea_m.bgea027_desc,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031,g_bgea_m.bgea031_desc, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea006_desc,g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040, 
       g_bgea_m.bgea041,g_bgea_m.bgea042,g_bgea_m.bgea043
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_bgea_m.bgeaownid      
   LET g_data_dept  = g_bgea_m.bgeaowndp
   
   #功能已完成,通報訊息中心
   CALL abgi170_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgi170_modify()
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
   LET g_bgea_m_t.* = g_bgea_m.*
   LET g_bgea_m_o.* = g_bgea_m.*
   
   IF g_bgea_m.bgea001 IS NULL
   OR g_bgea_m.bgea002 IS NULL
   OR g_bgea_m.bgea003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_bgea001_t = g_bgea_m.bgea001
   LET g_bgea002_t = g_bgea_m.bgea002
   LET g_bgea003_t = g_bgea_m.bgea003
 
   CALL s_transaction_begin()
   
   OPEN abgi170_cl USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi170_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abgi170_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgi170_master_referesh USING g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgea_m.bgea001, 
       g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp,g_bgea_m.bgeacrtid, 
       g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt,g_bgea_m.bgea009, 
       g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
       g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025, 
       g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041, 
       g_bgea_m.bgea042,g_bgea_m.bgea043,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp_desc,g_bgea_m.bgeacrtid_desc, 
       g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeamodid_desc
   
   #檢查是否允許此動作
   IF NOT abgi170_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bgea_m_mask_o.* =  g_bgea_m.*
   CALL abgi170_bgea_t_mask()
   LET g_bgea_m_mask_n.* =  g_bgea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL abgi170_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_bgea001_t = g_bgea_m.bgea001
      LET g_bgea002_t = g_bgea_m.bgea002
      LET g_bgea003_t = g_bgea_m.bgea003
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_bgea_m.bgeamodid = g_user 
LET g_bgea_m.bgeamoddt = cl_get_current()
LET g_bgea_m.bgeamodid_desc = cl_get_username(g_bgea_m.bgeamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL abgi170_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE bgea_t SET (bgeamodid,bgeamoddt) = (g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt)
          WHERE bgeaent = g_enterprise AND bgea001 = g_bgea001_t
            AND bgea002 = g_bgea002_t
            AND bgea003 = g_bgea003_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_bgea_m.* = g_bgea_m_t.*
            CALL abgi170_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_bgea_m.bgea001 != g_bgea_m_t.bgea001
      OR g_bgea_m.bgea002 != g_bgea_m_t.bgea002
      OR g_bgea_m.bgea003 != g_bgea_m_t.bgea003
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE bgeb_t SET bgeb001 = g_bgea_m.bgea001
                                       ,bgeb002 = g_bgea_m.bgea002
                                       ,bgeb003 = g_bgea_m.bgea003
 
          WHERE bgebent = g_enterprise AND bgeb001 = g_bgea_m_t.bgea001
            AND bgeb002 = g_bgea_m_t.bgea002
            AND bgeb003 = g_bgea_m_t.bgea003
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bgeb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bgeb_t:",SQLERRMESSAGE 
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
         
         UPDATE bgec_t
            SET bgec001 = g_bgea_m.bgea001
               ,bgec002 = g_bgea_m.bgea002
               ,bgec003 = g_bgea_m.bgea003
 
          WHERE bgecent = g_enterprise AND
                bgec001 = g_bgea001_t
            AND bgec002 = g_bgea002_t
            AND bgec003 = g_bgea003_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "bgec_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bgec_t:",SQLERRMESSAGE 
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
   CALL abgi170_set_act_visible()   
   CALL abgi170_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgeaent = " ||g_enterprise|| " AND",
                      " bgea001 = '", g_bgea_m.bgea001, "' "
                      ," AND bgea002 = '", g_bgea_m.bgea002, "' "
                      ," AND bgea003 = '", g_bgea_m.bgea003, "' "
 
   #填到對應位置
   CALL abgi170_browser_fill("")
 
   CLOSE abgi170_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgi170_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="abgi170.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgi170_input(p_cmd)
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
   DEFINE  l_oodb004             LIKE oodb_t.oodb004 #僅承接不使用
   DEFINE  l_apca013             LIKE apca_t.apca013 #僅承接不使用
   DEFINE  l_apca012             LIKE apca_t.apca012 #僅承接不使用
   DEFINE  l_oodb011             LIKE oodb_t.oodb011 #僅承接不使用
   DEFINE  l_ooajstus            LIKE ooaj_t.ooajstus
   DEFINE  l_cnt_imaf001         LIKE type_t.num10
   DEFINE  l_sum_bgec006         LIKE type_t.num10
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
   DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc,g_bgea_m.bgea002,g_bgea_m.bgea002_desc,g_bgea_m.bgea003, 
       g_bgea_m.l_bgas005,g_bgea_m.l_bgasl003,g_bgea_m.l_bgasl004,g_bgea_m.l_bgas009,g_bgea_m.l_bgas009_desc, 
       g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp,g_bgea_m.bgeaowndp_desc, 
       g_bgea_m.bgeacrtid,g_bgea_m.bgeacrtid_desc,g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeacrtdt, 
       g_bgea_m.bgeamodid,g_bgea_m.bgeamodid_desc,g_bgea_m.bgeamoddt,g_bgea_m.bgea009,g_bgea_m.bgea009_desc, 
       g_bgea_m.bgea010,g_bgea_m.bgea010_desc,g_bgea_m.bgea011,g_bgea_m.bgea011_desc,g_bgea_m.bgea012, 
       g_bgea_m.bgea012_desc,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004,g_bgea_m.bgea004_desc, 
       g_bgea_m.bgea015,g_bgea_m.bgea015_desc,g_bgea_m.bgea016,g_bgea_m.bgea016_desc,g_bgea_m.bgea017, 
       g_bgea_m.bgea017_desc,g_bgea_m.bgea018,g_bgea_m.bgea018_desc,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea005_desc, 
       g_bgea_m.bgea025,g_bgea_m.bgea025_desc,g_bgea_m.bgea026,g_bgea_m.bgea026_desc,g_bgea_m.bgea027, 
       g_bgea_m.bgea027_desc,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031,g_bgea_m.bgea031_desc, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea006_desc,g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040, 
       g_bgea_m.bgea041,g_bgea_m.bgea042,g_bgea_m.bgea043
   
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
   LET g_forupd_sql = "SELECT bgeb004,bgebownid,bgebowndp,bgebcrtid,bgebcrtdp,bgebcrtdt,bgebmodid,bgebmoddt, 
       bgebstus FROM bgeb_t WHERE bgebent=? AND bgeb001=? AND bgeb002=? AND bgeb003=? AND bgeb004=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi170_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT bgec004,bgec006,bgecownid,bgecowndp,bgeccrtid,bgeccrtdp,bgeccrtdt,bgecmodid, 
       bgecmoddt,bgecstus FROM bgec_t WHERE bgecent=? AND bgec001=? AND bgec002=? AND bgec003=? AND  
       bgec004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgi170_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgi170_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgi170_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgea009, 
       g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
       g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025, 
       g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041, 
       g_bgea_m.bgea042,g_bgea_m.bgea043
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgi170.input.head" >}
      #單頭段
      INPUT BY NAME g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgea009, 
          g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
          g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
          g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025, 
          g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
          g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
          g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041, 
          g_bgea_m.bgea042,g_bgea_m.bgea043 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN abgi170_cl USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abgi170_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abgi170_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL abgi170_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL abgi170_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea001
            
            #add-point:AFTER FIELD bgea001 name="input.a.bgea001"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgea_m.bgea001) AND NOT cl_null(g_bgea_m.bgea002) AND NOT cl_null(g_bgea_m.bgea003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgea_m.bgea001 != g_bgea001_t  OR g_bgea_m.bgea002 != g_bgea002_t  OR g_bgea_m.bgea003 != g_bgea003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bgea_t WHERE "||"bgeaent = '" ||g_enterprise|| "' AND "||"bgea001 = '"||g_bgea_m.bgea001 ||"' AND "|| "bgea002 = '"||g_bgea_m.bgea002 ||"' AND "|| "bgea003 = '"||g_bgea_m.bgea003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_bgea_m.bgea001_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea001_desc
            IF NOT cl_null(g_bgea_m.bgea001) THEN
               IF g_bgea_m.bgea001 != g_bgea_m_o.bgea001 OR cl_null(g_bgea_m_o.bgea001) THEN  
                  CALL s_fin_budget_chk(g_bgea_m.bgea001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success  THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = 'abgi010'
                     LET g_errparam.replace[2] = cl_get_progname('abgi010',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi010'
                     CALL cl_err()
                     LET g_bgea_m.bgea001 = g_bgea_m_o.bgea001
                     CALL s_desc_get_budget_desc(g_bgea_m.bgea001) RETURNING g_bgea_m.bgea001_desc
                     DISPLAY BY NAME g_bgea_m.bgea001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #修改預算編號,清空預算組織,避免修改成不存在組織樹中的組織
                  CALL s_fin_abg_center_sons_query(g_bgea_m.bgea001,'','')
                  LET g_bgea_m.bgea002 = ''
                  LET g_bgea_m.bgea002_desc = ''
                  DISPLAY BY NAME g_bgea_m.bgea002,g_bgea_m.bgea002_desc    
               END IF
            END IF
            CALL s_desc_get_budget_desc(g_bgea_m.bgea001) RETURNING g_bgea_m.bgea001_desc
            DISPLAY BY NAME g_bgea_m.bgea001_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea001
            #add-point:BEFORE FIELD bgea001 name="input.b.bgea001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea001
            #add-point:ON CHANGE bgea001 name="input.g.bgea001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea002
            
            #add-point:AFTER FIELD bgea002 name="input.a.bgea002"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgea_m.bgea001) AND NOT cl_null(g_bgea_m.bgea002) AND NOT cl_null(g_bgea_m.bgea003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgea_m.bgea001 != g_bgea001_t  OR g_bgea_m.bgea002 != g_bgea002_t  OR g_bgea_m.bgea003 != g_bgea003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bgea_t WHERE "||"bgeaent = '" ||g_enterprise|| "' AND "||"bgea001 = '"||g_bgea_m.bgea001 ||"' AND "|| "bgea002 = '"||g_bgea_m.bgea002 ||"' AND "|| "bgea003 = '"||g_bgea_m.bgea003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            LET g_bgea_m.bgea002_desc = ' '
            DISPLAY BY NAME g_bgea_m.bgea002_desc
            IF NOT cl_null(g_bgea_m.bgea002) THEN
               IF g_bgea_m.bgea002 != g_bgea_m_o.bgea002 OR cl_null(g_bgea_m_o.bgea002) THEN  
                  CALL abgi170_bgea002_chk(g_bgea_m.bgea002)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgea_m.bgea002 = g_bgea_m_o.bgea002
                     LET g_bgea_m.bgea002_desc =s_desc_get_department_desc(g_bgea_m.bgea002)
                     DISPLAY BY NAME g_bgea_m.bgea002,g_bgea_m.bgea002_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_bgea_m.bgea001)THEN
                     CALL s_abg_site_chk(g_bgea_m.bgea002)RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgea_m.bgea002 = g_bgea_m_o.bgea002
                        LET g_bgea_m.bgea002_desc =s_desc_get_department_desc(g_bgea_m.bgea002)
                        DISPLAY BY NAME g_bgea_m.bgea002,g_bgea_m.bgea002_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF                 
               END IF
            END IF
            LET g_bgea_m.bgea002_desc =s_desc_get_department_desc(g_bgea_m.bgea002)
            DISPLAY BY NAME g_bgea_m.bgea002,g_bgea_m.bgea002_desc
            LET g_bgea_m_o.* = g_bgea_m.*


            #幣別/取得據點所屬法人/稅區
            LET g_ooef016 = '' 
            LET g_ooef017 = '' 
            LET g_ooef019 = ''
            SELECT ooef016,ooef017,ooef019 INTO g_ooef016,g_ooef017,g_ooef019
              FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_bgea_m.bgea002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea002
            #add-point:BEFORE FIELD bgea002 name="input.b.bgea002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea002
            #add-point:ON CHANGE bgea002 name="input.g.bgea002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea003
            #add-point:BEFORE FIELD bgea003 name="input.b.bgea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea003
            
            #add-point:AFTER FIELD bgea003 name="input.a.bgea003"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgea_m.bgea001) AND NOT cl_null(g_bgea_m.bgea002) AND NOT cl_null(g_bgea_m.bgea003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgea_m.bgea001 != g_bgea001_t  OR g_bgea_m.bgea002 != g_bgea002_t  OR g_bgea_m.bgea003 != g_bgea003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bgea_t WHERE "||"bgeaent = '" ||g_enterprise|| "' AND "||"bgea001 = '"||g_bgea_m.bgea001 ||"' AND "|| "bgea002 = '"||g_bgea_m.bgea002 ||"' AND "|| "bgea003 = '"||g_bgea_m.bgea003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bgea_m.bgea003) THEN
               IF g_bgea_m.bgea003 != g_bgea_m_o.bgea003 OR cl_null(g_bgea_m_o.bgea003) THEN  
                  IF NOT ap_chk_isExist(g_bgea_m.bgea003,"SELECT COUNT(1) FROM bgas_t WHERE bgasent = '" ||g_enterprise||"' AND bgas001=? ",'abg-00168',0) THEN 
                     LET g_bgea_m.bgea003 = g_bgea_m_o.bgea003
                     CALL abgi170_bgea003_ref()
                     NEXT FIELD CURRENT
                  END IF               
                  IF NOT ap_chk_isExist(g_bgea_m.bgea003,"SELECT COUNT(1) FROM bgas_t WHERE bgasent = '" ||g_enterprise||"' AND bgas001=? AND bgasstus = 'Y' ","sub-01302",'abgi165' ) THEN 
                     LET g_bgea_m.bgea003 = g_bgea_m_o.bgea003
                     CALL abgi170_bgea003_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL abgi170_bgea003_ref()
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea003
            #add-point:ON CHANGE bgea003 name="input.g.bgea003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeastus
            #add-point:BEFORE FIELD bgeastus name="input.b.bgeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeastus
            
            #add-point:AFTER FIELD bgeastus name="input.a.bgeastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeastus
            #add-point:ON CHANGE bgeastus name="input.g.bgeastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea009
            
            #add-point:AFTER FIELD bgea009 name="input.a.bgea009"
            LET g_bgea_m.bgea009_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea009_desc
            IF NOT cl_null(g_bgea_m.bgea009) THEN 
               IF g_bgea_m.bgea009 != g_bgea_m_o.bgea009 OR cl_null(g_bgea_m_o.bgea009) THEN  
                  IF g_bgea_m.bgea002 = 'ALL' THEN
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_bgea_m.bgea009
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00053:sub-01302|aimi103|",cl_get_progname("aimi103",g_lang,"2"),"|:EXEPROGaimi103"
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_imcd111") THEN
                        LET g_bgea_m.bgea009 = g_bgea_m_t.bgea009
                        LET g_bgea_m.bgea009_desc = s_desc_get_acc_desc('202',g_bgea_m.bgea009)
                        DISPLAY BY NAME g_bgea_m.bgea009,g_bgea_m.bgea009_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF NOT s_azzi650_chk_exist('202',g_bgea_m.bgea009) THEN
                        LET g_bgea_m.bgea009 = g_bgea_m_t.bgea009
                        LET g_bgea_m.bgea009_desc = s_desc_get_acc_desc('202',g_bgea_m.bgea009)
                        DISPLAY BY NAME g_bgea_m.bgea009,g_bgea_m.bgea009_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgea_m.bgea009_desc = s_desc_get_acc_desc('202',g_bgea_m.bgea009)
            DISPLAY BY NAME g_bgea_m.bgea009_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea009
            #add-point:BEFORE FIELD bgea009 name="input.b.bgea009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea009
            #add-point:ON CHANGE bgea009 name="input.g.bgea009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea010
            
            #add-point:AFTER FIELD bgea010 name="input.a.bgea010"
            LET g_bgea_m.bgea010_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea010_desc
            IF NOT cl_null(g_bgea_m.bgea010) THEN 
               IF g_bgea_m.bgea010 != g_bgea_m_o.bgea010 OR cl_null(g_bgea_m_o.bgea010) THEN  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgea_m.bgea010
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_bgea_m.bgea010 = g_bgea_m_o.bgea010 
                     LET g_bgea_m.bgea010_desc = s_desc_get_unit_desc(g_bgea_m.bgea010)
                     DISPLAY BY NAME g_bgea_m.bgea010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF           
            END IF
            LET g_bgea_m.bgea010_desc = s_desc_get_unit_desc(g_bgea_m.bgea010)
            DISPLAY BY NAME g_bgea_m.bgea010_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea010
            #add-point:BEFORE FIELD bgea010 name="input.b.bgea010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea010
            #add-point:ON CHANGE bgea010 name="input.g.bgea010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea011
            
            #add-point:AFTER FIELD bgea011 name="input.a.bgea011"
            LET g_bgea_m.bgea011_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea011_desc
            IF NOT cl_null(g_bgea_m.bgea011) THEN
               IF g_bgea_m.bgea011 != g_bgea_m_o.bgea011 OR cl_null(g_bgea_m_o.bgea011) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgea_m.bgea011
                  IF NOT cl_chk_exist("v_bgap001_1") THEN
                     LET g_bgea_m.bgea011 = g_bgea_m_o.bgea011
                     CALL abgi170_bgap001_ref(g_bgea_m.bgea011) RETURNING g_bgea_m.bgea011_desc
                     DISPLAY BY NAME g_bgea_m.bgea011,g_bgea_m.bgea011_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL abgi170_bgap001_ref(g_bgea_m.bgea011) RETURNING g_bgea_m.bgea011_desc
            DISPLAY BY NAME g_bgea_m.bgea011_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea011
            #add-point:BEFORE FIELD bgea011 name="input.b.bgea011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea011
            #add-point:ON CHANGE bgea011 name="input.g.bgea011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea012
            
            #add-point:AFTER FIELD bgea012 name="input.a.bgea012"
            LET g_bgea_m.bgea012_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea012_desc
            IF NOT cl_null(g_bgea_m.bgea012) THEN
               IF g_bgea_m.bgea012 != g_bgea_m_o.bgea012 OR cl_null(g_bgea_m_o.bgea012) THEN 
                  CALL s_tax_chk(g_bgea_m.bgea002,g_bgea_m.bgea012) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF NOT g_sub_success THEN
                     LET g_bgea_m.bgea012 = g_bgea_m_o.bgea012
                     CALL s_desc_get_tax_desc(g_ooef019,g_bgea_m.bgea012) RETURNING g_bgea_m.bgea012_desc            
                     DISPLAY BY NAME g_bgea_m.bgea012,g_bgea_m.bgea012_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_tax_desc(g_ooef019,g_bgea_m.bgea012) RETURNING g_bgea_m.bgea012_desc            
            DISPLAY BY NAME g_bgea_m.bgea012_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea012
            #add-point:BEFORE FIELD bgea012 name="input.b.bgea012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea012
            #add-point:ON CHANGE bgea012 name="input.g.bgea012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea013
            #add-point:BEFORE FIELD bgea013 name="input.b.bgea013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea013
            
            #add-point:AFTER FIELD bgea013 name="input.a.bgea013"
            IF NOT cl_null(g_bgea_m.bgea013) THEN
               IF g_bgea_m.bgea013 != g_bgea_m_o.bgea013 OR cl_null(g_bgea_m_o.bgea013) THEN 
                  LET l_ooajstus = ''
                     SELECT ooajstus INTO l_ooajstus
                       FROM ooaj_t,ooef_t
                      WHERE ooajent = ooefent
                        AND ooaj001 = ooef014
                        AND ooefent = g_enterprise
                        AND ooef001 = g_bgea_m.bgea002
                        AND ooaj002 = g_bgea_m.bgea013
                  
                  #該據點下是否可用此幣別
                  IF cl_null(l_ooajstus) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00237'
                     LET g_errparam.extend = g_bgea_m.bgea013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgea_m.bgea013 = g_bgea_m_o.bgea013
                     DISPLAY BY NAME g_bgea_m.bgea013
                     NEXT FIELD CURRENT
                  END IF
                  
                  #有效否
                  IF l_ooajstus <> 'Y' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00238'
                     LET g_errparam.extend = g_bgea_m.bgea013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgea_m.bgea013 = g_bgea_m_o.bgea013
                     DISPLAY BY NAME g_bgea_m.bgea013
                     NEXT FIELD CURRENT
                  END IF
                  
                  #若有單價,則重新取位
                  IF NOT cl_null(g_bgea_m.bgea014) THEN
                     CALL s_curr_round(g_bgea_m.bgea002,g_bgea_m.bgea013,g_bgea_m.bgea014,'1') RETURNING g_bgea_m.bgea014
                     DISPLAY BY NAME g_bgea_m.bgea014
                  END IF
               END IF
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea013
            #add-point:ON CHANGE bgea013 name="input.g.bgea013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea014
            #add-point:BEFORE FIELD bgea014 name="input.b.bgea014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea014
            
            #add-point:AFTER FIELD bgea014 name="input.a.bgea014"
            IF NOT cl_null(g_bgea_m.bgea014) THEN
               IF g_bgea_m.bgea014 != g_bgea_m_o.bgea014 OR cl_null(g_bgea_m_o.bgea014) THEN 
                  CALL s_curr_round(g_bgea_m.bgea002,g_bgea_m.bgea013,g_bgea_m.bgea014,'1') RETURNING g_bgea_m.bgea014
                  DISPLAY BY NAME g_bgea_m.bgea014
                  
                  IF g_bgea_m.bgea014 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea014 = g_bgea_m_o.bgea014
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea014 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea014
            #add-point:ON CHANGE bgea014 name="input.g.bgea014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea004
            
            #add-point:AFTER FIELD bgea004 name="input.a.bgea004"
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
              
            LET g_bgea_m.bgea004_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea004_desc
            IF NOT cl_null(g_bgea_m.bgea004) THEN
               IF g_bgea_m.bgea004 != g_bgea_m_o.bgea004 OR cl_null(g_bgea_m_o.bgea004) THEN 
                  IF NOT ap_chk_isExist(g_bgea_m.bgea004,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' ",'abg-00035',0) THEN
                     LET g_bgea_m.bgea004 = g_bgea_m_o.bgea004  
                     LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
                     NEXT FIELD CURRENT
                  END IF                 
                  IF NOT ap_chk_isExist(g_bgea_m.bgea004,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='1' ",'abg-00175',0) THEN
                     LET g_bgea_m.bgea004 = g_bgea_m_o.bgea004  
                     LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_bgea_m.bgea004,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='1' AND bgaestus='Y' ",'sub-01302','abgi040') THEN
                     LET g_bgea_m.bgea004 = g_bgea_m_o.bgea004         
                     LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
                     NEXT FIELD CURRENT
                  END IF                  
               END IF                  
            END IF
            LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
            DISPLAY BY NAME g_bgea_m.bgea004_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea004
            #add-point:BEFORE FIELD bgea004 name="input.b.bgea004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea004
            #add-point:ON CHANGE bgea004 name="input.g.bgea004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea015
            
            #add-point:AFTER FIELD bgea015 name="input.a.bgea015"
            LET g_bgea_m.bgea015_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea015_desc
            IF NOT cl_null(g_bgea_m.bgea015) THEN
               IF g_bgea_m.bgea015 != g_bgea_m_o.bgea015 OR cl_null(g_bgea_m_o.bgea015) THEN 
                  IF NOT s_azzi650_chk_exist('203',g_bgea_m.bgea015) THEN
                     LET g_bgea_m.bgea015 = g_bgea_m_o.bgea015
                     LET g_bgea_m.bgea015_desc = s_desc_get_acc_desc('203',g_bgea_m.bgea015)
                     DISPLAY BY NAME g_bgea_m.bgea015_desc
                     NEXT FIELD bgea015
                  END IF
               END IF                  
            END IF
            LET g_bgea_m.bgea015_desc = s_desc_get_acc_desc('203',g_bgea_m.bgea015)
            DISPLAY BY NAME g_bgea_m.bgea015_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea015
            #add-point:BEFORE FIELD bgea015 name="input.b.bgea015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea015
            #add-point:ON CHANGE bgea015 name="input.g.bgea015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea016
            
            #add-point:AFTER FIELD bgea016 name="input.a.bgea016"
            LET g_bgea_m.bgea016_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea016_desc
            IF NOT cl_null(g_bgea_m.bgea016) THEN 
               IF g_bgea_m.bgea016 != g_bgea_m_o.bgea016 OR cl_null(g_bgea_m_o.bgea016) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgea_m.bgea016
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_bgea_m.bgea016 = g_bgea_m_o.bgea016 
                     LET g_bgea_m.bgea016_desc = s_desc_get_unit_desc(g_bgea_m.bgea016)
                     DISPLAY BY NAME g_bgea_m.bgea016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF           
            END IF
            LET g_bgea_m.bgea016_desc = s_desc_get_unit_desc(g_bgea_m.bgea016)
            DISPLAY BY NAME g_bgea_m.bgea016_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea016
            #add-point:BEFORE FIELD bgea016 name="input.b.bgea016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea016
            #add-point:ON CHANGE bgea016 name="input.g.bgea016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea017
            
            #add-point:AFTER FIELD bgea017 name="input.a.bgea017"
            LET g_bgea_m.bgea017_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea017_desc
            IF NOT cl_null(g_bgea_m.bgea017) THEN
               IF g_bgea_m.bgea017 != g_bgea_m_o.bgea017 OR cl_null(g_bgea_m_o.bgea017) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgea_m.bgea017
                  IF NOT cl_chk_exist("v_bgap001") THEN
                     LET g_bgea_m.bgea017 = g_bgea_m_o.bgea017
                     CALL abgi170_bgap001_ref(g_bgea_m.bgea017) RETURNING g_bgea_m.bgea017_desc
                     DISPLAY BY NAME g_bgea_m.bgea017,g_bgea_m.bgea017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL abgi170_bgap001_ref(g_bgea_m.bgea017) RETURNING g_bgea_m.bgea017_desc
            DISPLAY BY NAME g_bgea_m.bgea017_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea017
            #add-point:BEFORE FIELD bgea017 name="input.b.bgea017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea017
            #add-point:ON CHANGE bgea017 name="input.g.bgea017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea018
            
            #add-point:AFTER FIELD bgea018 name="input.a.bgea018"
            LET g_bgea_m.bgea018_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea018_desc
            IF NOT cl_null(g_bgea_m.bgea018) THEN
               IF g_bgea_m.bgea018 != g_bgea_m_o.bgea018 OR cl_null(g_bgea_m_o.bgea018) THEN 
                  CALL s_tax_chk(g_bgea_m.bgea002,g_bgea_m.bgea018) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  
                  IF NOT g_sub_success THEN
                     LET g_bgea_m.bgea018 = g_bgea_m_o.bgea018
                     CALL s_desc_get_tax_desc(g_ooef019,g_bgea_m.bgea018) RETURNING g_bgea_m.bgea018_desc            
                     DISPLAY BY NAME g_bgea_m.bgea018,g_bgea_m.bgea018_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_tax_desc(g_ooef019,g_bgea_m.bgea018) RETURNING g_bgea_m.bgea018_desc            
            DISPLAY BY NAME g_bgea_m.bgea018_desc
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea018
            #add-point:BEFORE FIELD bgea018 name="input.b.bgea018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea018
            #add-point:ON CHANGE bgea018 name="input.g.bgea018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea019
            #add-point:BEFORE FIELD bgea019 name="input.b.bgea019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea019
            
            #add-point:AFTER FIELD bgea019 name="input.a.bgea019"
            IF NOT cl_null(g_bgea_m.bgea019) THEN
               IF g_bgea_m.bgea019 != g_bgea_m_o.bgea019 OR cl_null(g_bgea_m_o.bgea019) THEN 
                  LET l_ooajstus = ''
                  SELECT ooajstus INTO l_ooajstus
                    FROM ooaj_t,ooef_t
                   WHERE ooajent = ooefent
                     AND ooaj001 = ooef014
                     AND ooefent = g_enterprise
                     AND ooef001 = g_bgea_m.bgea002
                     AND ooaj002 = g_bgea_m.bgea019
                  
                  #該據點下是否可用此幣別
                  IF cl_null(l_ooajstus) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00237'
                     LET g_errparam.extend = g_bgea_m.bgea019
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgea_m.bgea019 = g_bgea_m_o.bgea019
                     DISPLAY BY NAME g_bgea_m.bgea019
                     NEXT FIELD CURRENT
                  END IF
                  
                  #有效否
                  IF l_ooajstus <> 'Y' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00238'
                     LET g_errparam.extend = g_bgea_m.bgea019
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgea_m.bgea019 = g_bgea_m_o.bgea019
                     DISPLAY BY NAME g_bgea_m.bgea019
                     NEXT FIELD CURRENT
                  END IF
                  
                  #若有單價,則重新取位
                  IF NOT cl_null(g_bgea_m.bgea020) THEN
                     CALL s_curr_round(g_bgea_m.bgea002,g_bgea_m.bgea019,g_bgea_m.bgea020,'1') RETURNING g_bgea_m.bgea020
                     DISPLAY BY NAME g_bgea_m.bgea020
                  END IF
               END IF
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea019
            #add-point:ON CHANGE bgea019 name="input.g.bgea019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea020
            #add-point:BEFORE FIELD bgea020 name="input.b.bgea020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea020
            
            #add-point:AFTER FIELD bgea020 name="input.a.bgea020"
            IF NOT cl_null(g_bgea_m.bgea020) THEN
               IF g_bgea_m.bgea020 != g_bgea_m_o.bgea020 OR cl_null(g_bgea_m_o.bgea020) THEN 
                  CALL s_curr_round(g_bgea_m.bgea002,g_bgea_m.bgea019,g_bgea_m.bgea020,'1') RETURNING g_bgea_m.bgea020
                  DISPLAY BY NAME g_bgea_m.bgea020
                  
                  IF g_bgea_m.bgea020 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea020 = g_bgea_m_o.bgea020
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea020 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea020
            #add-point:ON CHANGE bgea020 name="input.g.bgea020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea021
            #add-point:BEFORE FIELD bgea021 name="input.b.bgea021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea021
            
            #add-point:AFTER FIELD bgea021 name="input.a.bgea021"
            IF NOT cl_null(g_bgea_m.bgea021) THEN
               IF g_bgea_m.bgea021 != g_bgea_m_o.bgea021 OR cl_null(g_bgea_m_o.bgea021) THEN 
                  IF g_bgea_m.bgea021 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea021 = g_bgea_m_o.bgea021
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea021 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea021
            #add-point:ON CHANGE bgea021 name="input.g.bgea021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgea_m.bgea022,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD bgea022
            END IF 
 
 
 
            #add-point:AFTER FIELD bgea022 name="input.a.bgea022"
            IF NOT cl_null(g_bgea_m.bgea022) THEN
               IF g_bgea_m.bgea022 != g_bgea_m_o.bgea022 OR cl_null(g_bgea_m_o.bgea022) THEN 
                  IF g_bgea_m.bgea022 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea022 = g_bgea_m_o.bgea022
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea022 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea022
            #add-point:BEFORE FIELD bgea022 name="input.b.bgea022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea022
            #add-point:ON CHANGE bgea022 name="input.g.bgea022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgea_m.bgea023,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD bgea023
            END IF 
 
 
 
            #add-point:AFTER FIELD bgea023 name="input.a.bgea023"
            IF NOT cl_null(g_bgea_m.bgea023) THEN
               IF g_bgea_m.bgea023 != g_bgea_m_o.bgea023 OR cl_null(g_bgea_m_o.bgea023) THEN 
                  IF g_bgea_m.bgea023 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea023 = g_bgea_m_o.bgea023
                     NEXT FIELD CURRENT
                  END IF
                  #如內採組織訊息有採購比例，則其合計不可大於進銷存訊息的內採比例 
                  IF NOT cl_null(g_bgea_m.bgea023) OR g_bgea_m.bgea023 <> 0 THEN
                     LET l_sum_bgec006 = 0
                     SELECT SUM(bgec006) INTO l_sum_bgec006 FROM bgec_t
                      WHERE bgecent = g_enterprise AND bgec001 = g_bgea_m.bgea001 AND bgec002 = g_bgea_m.bgea002 AND bgec003 = g_bgea_m.bgea003 
                     IF cl_null(l_sum_bgec006) THEN LET l_sum_bgec006 = 0 END IF
                     IF l_sum_bgec006 > g_bgea_m.bgea023 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'abg-00176'
                        LET g_errparam.popup  = FALSE
                        CALL cl_err()
                        LET g_bgea_m.bgea023 = g_bgea_m_o.bgea023
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea023 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea023
            #add-point:BEFORE FIELD bgea023 name="input.b.bgea023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea023
            #add-point:ON CHANGE bgea023 name="input.g.bgea023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgea_m.bgea024,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD bgea024
            END IF 
 
 
 
            #add-point:AFTER FIELD bgea024 name="input.a.bgea024"
            IF NOT cl_null(g_bgea_m.bgea024) THEN
               IF g_bgea_m.bgea024 != g_bgea_m_o.bgea024 OR cl_null(g_bgea_m_o.bgea024) THEN 
                  IF g_bgea_m.bgea024 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea024 = g_bgea_m_o.bgea024
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea024 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea024
            #add-point:BEFORE FIELD bgea024 name="input.b.bgea024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea024
            #add-point:ON CHANGE bgea024 name="input.g.bgea024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea005
            
            #add-point:AFTER FIELD bgea005 name="input.a.bgea005"
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
              
            LET g_bgea_m.bgea005_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea005_desc
            IF NOT cl_null(g_bgea_m.bgea005) THEN  
               IF g_bgea_m.bgea005 != g_bgea_m_o.bgea005 OR cl_null(g_bgea_m_o.bgea005) THEN 
                  IF NOT ap_chk_isExist(g_bgea_m.bgea005,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' ",'abg-00035',0) THEN
                     LET g_bgea_m.bgea005 = g_bgea_m_o.bgea005  
                     LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
                     NEXT FIELD CURRENT
                  END IF                 
                  IF NOT ap_chk_isExist(g_bgea_m.bgea005,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='3' ",'abg-00175',0) THEN
                     LET g_bgea_m.bgea005 = g_bgea_m_o.bgea005  
                     LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_bgea_m.bgea005,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='3' AND bgaestus='Y' ",'sub-01302','abgi040') THEN
                     LET g_bgea_m.bgea005 = g_bgea_m_o.bgea005         
                     LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
                     NEXT FIELD CURRENT
                  END IF                  
               END IF 
            END IF
            LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
            DISPLAY BY NAME g_bgea_m.bgea005_desc
            LET g_bgea_m_o.* = g_bgea_m.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea005
            #add-point:BEFORE FIELD bgea005 name="input.b.bgea005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea005
            #add-point:ON CHANGE bgea005 name="input.g.bgea005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea025
            
            #add-point:AFTER FIELD bgea025 name="input.a.bgea025"
            LET g_bgea_m.bgea025_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea025_desc
            IF NOT cl_null(g_bgea_m.bgea025) THEN
               IF g_bgea_m.bgea025 != g_bgea_m_o.bgea025 OR cl_null(g_bgea_m_o.bgea025) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgea_m.bgea025
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_bgea_m.bgea025 = g_bgea_m_o.bgea025
                     LET g_bgea_m.bgea025_desc = s_desc_get_unit_desc(g_bgea_m.bgea025) 
                     DISPLAY BY NAME g_bgea_m.bgea025,g_bgea_m.bgea025_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bgea_m.bgea025_desc = s_desc_get_unit_desc(g_bgea_m.bgea025) 
            DISPLAY BY NAME g_bgea_m.bgea025_desc
            LET g_bgea_m_o.* = g_bgea_m.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea025
            #add-point:BEFORE FIELD bgea025 name="input.b.bgea025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea025
            #add-point:ON CHANGE bgea025 name="input.g.bgea025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea026
            
            #add-point:AFTER FIELD bgea026 name="input.a.bgea026"
            LET g_bgea_m.bgea026_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea026_desc
            IF NOT cl_null(g_bgea_m.bgea026) THEN
               IF g_bgea_m.bgea026 != g_bgea_m_o.bgea026 OR cl_null(g_bgea_m_o.bgea026) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgea_m.bgea026
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_bgea_m.bgea026 = g_bgea_m_o.bgea026
                     LET g_bgea_m.bgea026_desc = s_desc_get_unit_desc(g_bgea_m.bgea026)
                     DISPLAY BY NAME g_bgea_m.bgea026_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bgea_m.bgea026_desc = s_desc_get_unit_desc(g_bgea_m.bgea026)
            DISPLAY BY NAME g_bgea_m.bgea026_desc
            LET g_bgea_m_o.* = g_bgea_m.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea026
            #add-point:BEFORE FIELD bgea026 name="input.b.bgea026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea026
            #add-point:ON CHANGE bgea026 name="input.g.bgea026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea027
            
            #add-point:AFTER FIELD bgea027 name="input.a.bgea027"
            LET g_bgea_m.bgea027_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea027_desc
            IF NOT cl_null(g_bgea_m.bgea027) THEN
               IF g_bgea_m.bgea027 != g_bgea_m_o.bgea027 OR cl_null(g_bgea_m_o.bgea027) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgea_m.bgea027
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_bgea_m.bgea027 = g_bgea_m_o.bgea027
                     LET g_bgea_m.bgea027_desc = s_desc_get_unit_desc(g_bgea_m.bgea027)
                     DISPLAY BY NAME g_bgea_m.bgea027_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bgea_m.bgea027_desc = s_desc_get_unit_desc(g_bgea_m.bgea027)
            DISPLAY BY NAME g_bgea_m.bgea027_desc
            LET g_bgea_m_o.* = g_bgea_m.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea027
            #add-point:BEFORE FIELD bgea027 name="input.b.bgea027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea027
            #add-point:ON CHANGE bgea027 name="input.g.bgea027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea028
            #add-point:BEFORE FIELD bgea028 name="input.b.bgea028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea028
            
            #add-point:AFTER FIELD bgea028 name="input.a.bgea028"
            IF NOT cl_null(g_bgea_m.bgea028) THEN
               IF g_bgea_m.bgea028 != g_bgea_m_o.bgea028 OR cl_null(g_bgea_m_o.bgea028) THEN 
                  IF g_bgea_m.bgea028 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea028 = g_bgea_m_o.bgea028
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea028 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea028
            #add-point:ON CHANGE bgea028 name="input.g.bgea028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgea_m.bgea029,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD bgea029
            END IF 
 
 
 
            #add-point:AFTER FIELD bgea029 name="input.a.bgea029"
            IF NOT cl_null(g_bgea_m.bgea029) THEN
               IF g_bgea_m.bgea029 != g_bgea_m_o.bgea029 OR cl_null(g_bgea_m_o.bgea029) THEN 
                  IF g_bgea_m.bgea029 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea029 = g_bgea_m_o.bgea029
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea029 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea029
            #add-point:BEFORE FIELD bgea029 name="input.b.bgea029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea029
            #add-point:ON CHANGE bgea029 name="input.g.bgea029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgea_m.bgea030,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD bgea030
            END IF 
 
 
 
            #add-point:AFTER FIELD bgea030 name="input.a.bgea030"
            IF NOT cl_null(g_bgea_m.bgea030) THEN
               IF g_bgea_m.bgea030 != g_bgea_m_o.bgea030 OR cl_null(g_bgea_m_o.bgea030) THEN 
                  IF g_bgea_m.bgea030 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea030 = g_bgea_m_o.bgea030
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea030 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea030
            #add-point:BEFORE FIELD bgea030 name="input.b.bgea030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea030
            #add-point:ON CHANGE bgea030 name="input.g.bgea030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea031
            
            #add-point:AFTER FIELD bgea031 name="input.a.bgea031"
            LET g_bgea_m.bgea031_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea031_desc 
            IF NOT cl_null(g_bgea_m.bgea031) THEN
               IF g_bgea_m.bgea031 != g_bgea_m_o.bgea031 OR cl_null(g_bgea_m_o.bgea031) THEN 
                  IF NOT s_azzi650_chk_exist('206',g_bgea_m.bgea031) THEN
                     LET g_bgea_m.bgea031 = g_bgea_m_o.bgea031
                     LET g_bgea_m.bgea031_desc = s_desc_get_acc_desc('206',g_bgea_m.bgea031)
                     DISPLAY BY NAME g_bgea_m.bgea031_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bgea_m.bgea031_desc = s_desc_get_acc_desc('206',g_bgea_m.bgea031)
            DISPLAY BY NAME g_bgea_m.bgea031_desc 
            LET g_bgea_m_o.* = g_bgea_m.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea031
            #add-point:BEFORE FIELD bgea031 name="input.b.bgea031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea031
            #add-point:ON CHANGE bgea031 name="input.g.bgea031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea032
            #add-point:BEFORE FIELD bgea032 name="input.b.bgea032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea032
            
            #add-point:AFTER FIELD bgea032 name="input.a.bgea032"
            IF NOT cl_null(g_bgea_m.bgea032) THEN
               IF g_bgea_m.bgea032 != g_bgea_m_o.bgea032 OR cl_null(g_bgea_m_o.bgea032) THEN 
                  IF g_bgea_m.bgea032 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea032 = g_bgea_m_o.bgea032
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea032 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea032
            #add-point:ON CHANGE bgea032 name="input.g.bgea032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea033
            #add-point:BEFORE FIELD bgea033 name="input.b.bgea033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea033
            
            #add-point:AFTER FIELD bgea033 name="input.a.bgea033"
            IF NOT cl_null(g_bgea_m.bgea033) THEN
               IF g_bgea_m.bgea033 != g_bgea_m_o.bgea033 OR cl_null(g_bgea_m_o.bgea033) THEN 
                  IF g_bgea_m.bgea033 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea033 = g_bgea_m_o.bgea033
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea033 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea033
            #add-point:ON CHANGE bgea033 name="input.g.bgea033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea034
            #add-point:BEFORE FIELD bgea034 name="input.b.bgea034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea034
            
            #add-point:AFTER FIELD bgea034 name="input.a.bgea034"
            IF NOT cl_null(g_bgea_m.bgea034) THEN
               IF g_bgea_m.bgea034 != g_bgea_m_o.bgea034 OR cl_null(g_bgea_m_o.bgea034) THEN 
                  IF g_bgea_m.bgea034 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea034 = g_bgea_m_o.bgea034
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea034 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea034
            #add-point:ON CHANGE bgea034 name="input.g.bgea034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea035
            #add-point:BEFORE FIELD bgea035 name="input.b.bgea035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea035
            
            #add-point:AFTER FIELD bgea035 name="input.a.bgea035"
            IF NOT cl_null(g_bgea_m.bgea035) THEN
               IF g_bgea_m.bgea035 != g_bgea_m_o.bgea035 OR cl_null(g_bgea_m_o.bgea035) THEN 
                  IF g_bgea_m.bgea035 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea035 = g_bgea_m_o.bgea035
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea035 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea035
            #add-point:ON CHANGE bgea035 name="input.g.bgea035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea044
            #add-point:BEFORE FIELD bgea044 name="input.b.bgea044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea044
            
            #add-point:AFTER FIELD bgea044 name="input.a.bgea044"
            IF NOT cl_null(g_bgea_m.bgea044) THEN
               IF g_bgea_m.bgea044 != g_bgea_m_o.bgea044 OR cl_null(g_bgea_m_o.bgea044) THEN 
                  LET l_ooajstus = ''
                     SELECT ooajstus INTO l_ooajstus
                       FROM ooaj_t,ooef_t
                      WHERE ooajent = ooefent
                        AND ooaj001 = ooef014
                        AND ooefent = g_enterprise
                        AND ooef001 = g_bgea_m.bgea002
                        AND ooaj002 = g_bgea_m.bgea044
                  
                  #該據點下是否可用此幣別
                  IF cl_null(l_ooajstus) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00237'
                     LET g_errparam.extend = g_bgea_m.bgea044
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgea_m.bgea044 = g_bgea_m_o.bgea044
                     DISPLAY BY NAME g_bgea_m.bgea044
                     NEXT FIELD CURRENT
                  END IF
                  
                  #有效否
                  IF l_ooajstus <> 'Y' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00238'
                     LET g_errparam.extend = g_bgea_m.bgea044
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgea_m.bgea044 = g_bgea_m_o.bgea044
                     DISPLAY BY NAME g_bgea_m.bgea044
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea044
            #add-point:ON CHANGE bgea044 name="input.g.bgea044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea006
            
            #add-point:AFTER FIELD bgea006 name="input.a.bgea006"
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
              
            LET g_bgea_m.bgea006_desc = ''
            DISPLAY BY NAME g_bgea_m.bgea006_desc
            IF NOT cl_null(g_bgea_m.bgea006) THEN
               IF g_bgea_m.bgea006 != g_bgea_m_o.bgea006 OR cl_null(g_bgea_m_o.bgea006) THEN 
                  IF NOT ap_chk_isExist(g_bgea_m.bgea006,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' ",'abg-00035',0) THEN
                     LET g_bgea_m.bgea006 = g_bgea_m_o.bgea006  
                     LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
                     NEXT FIELD CURRENT
                  END IF                 
                  IF NOT ap_chk_isExist(g_bgea_m.bgea006,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='2' ",'abg-00175',0) THEN
                     LET g_bgea_m.bgea006 = g_bgea_m_o.bgea006  
                     LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_bgea_m.bgea006,"SELECT COUNT(1) FROM bgae_t WHERE bgaeent = '" ||g_enterprise||"' AND "||"bgae006 = '"||g_bgaa008||"' AND bgae001=? AND bgae007='1' AND bgae005='2' AND bgaestus='Y' ",'sub-01302','abgi040') THEN
                     LET g_bgea_m.bgea006 = g_bgea_m_o.bgea006         
                     LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
                     NEXT FIELD CURRENT
                  END IF                  
               END IF 
            END IF
            LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
            DISPLAY BY NAME g_bgea_m.bgea006_desc
            LET g_bgea_m_o.* = g_bgea_m.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea006
            #add-point:BEFORE FIELD bgea006 name="input.b.bgea006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea006
            #add-point:ON CHANGE bgea006 name="input.g.bgea006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea036
            #add-point:BEFORE FIELD bgea036 name="input.b.bgea036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea036
            
            #add-point:AFTER FIELD bgea036 name="input.a.bgea036"
            IF NOT cl_null(g_bgea_m.bgea036) THEN
               IF g_bgea_m.bgea036 != g_bgea_m_o.bgea036 OR cl_null(g_bgea_m_o.bgea036) THEN 
                  IF g_bgea_m.bgea036 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea036 = g_bgea_m_o.bgea036
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea036 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea036
            #add-point:ON CHANGE bgea036 name="input.g.bgea036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea037
            #add-point:BEFORE FIELD bgea037 name="input.b.bgea037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea037
            
            #add-point:AFTER FIELD bgea037 name="input.a.bgea037"
            IF NOT cl_null(g_bgea_m.bgea037) THEN
               IF g_bgea_m.bgea037 != g_bgea_m_o.bgea037 OR cl_null(g_bgea_m_o.bgea037) THEN 
                  IF g_bgea_m.bgea037 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea037 = g_bgea_m_o.bgea037
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea037 = 0
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea037
            #add-point:ON CHANGE bgea037 name="input.g.bgea037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea038
            #add-point:BEFORE FIELD bgea038 name="input.b.bgea038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea038
            
            #add-point:AFTER FIELD bgea038 name="input.a.bgea038"
            IF NOT cl_null(g_bgea_m.bgea038) THEN
               IF g_bgea_m.bgea038 != g_bgea_m_o.bgea038 OR cl_null(g_bgea_m_o.bgea038) THEN 
                  IF g_bgea_m.bgea038 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea038 = g_bgea_m_o.bgea038
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea038 = 0               
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea038
            #add-point:ON CHANGE bgea038 name="input.g.bgea038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea039
            #add-point:BEFORE FIELD bgea039 name="input.b.bgea039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea039
            
            #add-point:AFTER FIELD bgea039 name="input.a.bgea039"
            IF NOT cl_null(g_bgea_m.bgea039) THEN
               IF g_bgea_m.bgea039 != g_bgea_m_o.bgea039 OR cl_null(g_bgea_m_o.bgea039) THEN 
                  IF g_bgea_m.bgea039 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea039 = g_bgea_m_o.bgea039
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea039 = 0                 
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea039
            #add-point:ON CHANGE bgea039 name="input.g.bgea039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea040
            #add-point:BEFORE FIELD bgea040 name="input.b.bgea040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea040
            
            #add-point:AFTER FIELD bgea040 name="input.a.bgea040"
            IF NOT cl_null(g_bgea_m.bgea040) THEN
               IF g_bgea_m.bgea040 != g_bgea_m_o.bgea040 OR cl_null(g_bgea_m_o.bgea040) THEN 
                  IF g_bgea_m.bgea040 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea040 = g_bgea_m_o.bgea040
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea040 = 0                 
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea040
            #add-point:ON CHANGE bgea040 name="input.g.bgea040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea041
            #add-point:BEFORE FIELD bgea041 name="input.b.bgea041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea041
            
            #add-point:AFTER FIELD bgea041 name="input.a.bgea041"
            IF NOT cl_null(g_bgea_m.bgea041) THEN
               IF g_bgea_m.bgea041 != g_bgea_m_o.bgea041 OR cl_null(g_bgea_m_o.bgea041) THEN 
                  IF g_bgea_m.bgea041 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea041 = g_bgea_m_o.bgea041
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea041 = 0  
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea041
            #add-point:ON CHANGE bgea041 name="input.g.bgea041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea042
            #add-point:BEFORE FIELD bgea042 name="input.b.bgea042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea042
            
            #add-point:AFTER FIELD bgea042 name="input.a.bgea042"
            IF NOT cl_null(g_bgea_m.bgea042) THEN
               IF g_bgea_m.bgea042 != g_bgea_m_o.bgea042 OR cl_null(g_bgea_m_o.bgea042) THEN 
                  IF g_bgea_m.bgea042 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea042 = g_bgea_m_o.bgea042
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea042 = 0  
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea042
            #add-point:ON CHANGE bgea042 name="input.g.bgea042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea043
            #add-point:BEFORE FIELD bgea043 name="input.b.bgea043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea043
            
            #add-point:AFTER FIELD bgea043 name="input.a.bgea043"
            IF NOT cl_null(g_bgea_m.bgea043) THEN
               IF g_bgea_m.bgea043 != g_bgea_m_o.bgea043 OR cl_null(g_bgea_m_o.bgea043) THEN 
                  IF g_bgea_m.bgea043 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'ast-00083'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgea_m.bgea043 = g_bgea_m_o.bgea043
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgea_m.bgea043 = 0  
            END IF
            LET g_bgea_m_o.* = g_bgea_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea043
            #add-point:ON CHANGE bgea043 name="input.g.bgea043"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea001
            #add-point:ON ACTION controlp INFIELD bgea001 name="input.c.bgea001"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL   
            LET g_qryparam.state = 'i'  
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaastus = 'Y' "
            LET g_qryparam.default1 = g_bgea_m.bgea001              #給予default值
            CALL q_bgaa001()                                        #呼叫開窗
            LET g_bgea_m.bgea001 = g_qryparam.return1               #將開窗取得的值回傳到變數
            CALL s_desc_get_budget_desc(g_bgea_m.bgea001) RETURNING g_bgea_m.bgea001_desc
            DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc
            NEXT FIELD bgea001                                      #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea002
            #add-point:ON ACTION controlp INFIELD bgea002 name="input.c.bgea002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y' AND ooef001 IN (SELECT ooef001 FROM s_fin_tmp1 ) AND ooefstus = 'Y'"
            LET g_qryparam.default1 = g_bgea_m.bgea002
            CALL q_ooef001()
            LET g_bgea_m.bgea002 = g_qryparam.return1
            NEXT FIELD bgea002
            #END add-point
 
 
         #Ctrlp:input.c.bgea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea003
            #add-point:ON ACTION controlp INFIELD bgea003 name="input.c.bgea003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgasstus = 'Y' "
            LET g_qryparam.default1 = g_bgea_m.bgea003            
            CALL q_bgas001()
            LET g_bgea_m.bgea003 = g_qryparam.return1
            CALL abgi170_bgea003_ref()
            NEXT FIELD bgea003
            #END add-point
 
 
         #Ctrlp:input.c.bgeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeastus
            #add-point:ON ACTION controlp INFIELD bgeastus name="input.c.bgeastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea009
            #add-point:ON ACTION controlp INFIELD bgea009 name="input.c.bgea009"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea009       #給予default值
            CALL q_imcd111_1()                               #呼叫開窗
            LET g_bgea_m.bgea009 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea009_desc = s_desc_get_acc_desc('202',g_bgea_m.bgea009)
            DISPLAY BY NAME g_bgea_m.bgea009,g_bgea_m.bgea009_desc
            NEXT FIELD bgea009                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea010
            #add-point:ON ACTION controlp INFIELD bgea010 name="input.c.bgea010"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea010       #給予default值                
            CALL q_ooca001_1()  
            LET g_bgea_m.bgea010 = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea010_desc = s_desc_get_unit_desc(g_bgea_m.bgea010)
            DISPLAY BY NAME g_bgea_m.bgea010,g_bgea_m.bgea010_desc
            NEXT FIELD bgea010                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea011
            #add-point:ON ACTION controlp INFIELD bgea011 name="input.c.bgea011"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea011      #給予default值
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus = 'Y' "
            CALL q_bgap001()                       #呼叫開窗
            LET g_bgea_m.bgea011 = g_qryparam.return1      
            CALL abgi170_bgap001_ref(g_bgea_m.bgea011) RETURNING g_bgea_m.bgea011_desc
            DISPLAY BY NAME g_bgea_m.bgea011,g_bgea_m.bgea011_desc
            NEXT FIELD bgea011                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea012
            #add-point:ON ACTION controlp INFIELD bgea012 name="input.c.bgea012"
            #開窗i段
            #161111-00002#1 --s add
            #稅區
            LET g_ooef019 = ''
            SELECT ooef019 INTO g_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_bgea_m.bgea002
            #161111-00002#1 --e add
             
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea012
            LET g_qryparam.arg1 = g_ooef019   #稅區
            CALL q_oodb002_5()
            LET g_bgea_m.bgea012 = g_qryparam.return1
            LET g_bgea_m.bgea012_desc = s_desc_get_tax_desc(g_ooef019,g_bgea_m.bgea012)
            DISPLAY BY NAME g_bgea_m.bgea012,g_bgea_m.bgea012_desc
            NEXT FIELD bgea012
            #END add-point
 
 
         #Ctrlp:input.c.bgea013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea013
            #add-point:ON ACTION controlp INFIELD bgea013 name="input.c.bgea013"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea013       #給予default值
            LET g_qryparam.arg1 = g_bgea_m.bgea002
            CALL q_ooaj002_1()  
            LET g_bgea_m.bgea013 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_bgea_m.bgea013
            NEXT FIELD bgea013                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea014
            #add-point:ON ACTION controlp INFIELD bgea014 name="input.c.bgea014"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea004
            #add-point:ON ACTION controlp INFIELD bgea004 name="input.c.bgea004"
            #開窗i段
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
            
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea004         #給予default值
            LET g_qryparam.where = " bgae007='1' AND bgae005='1' AND bgae006='",g_bgaa008,"'"
            #給予arg
            CALL q_bgae001()                                   #呼叫開窗
            LET g_bgea_m.bgea004 = g_qryparam.return1          #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
            DISPLAY BY NAME g_bgea_m.bgea004_desc              #顯示到畫面上
            NEXT FIELD bgea004                                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea015
            #add-point:ON ACTION controlp INFIELD bgea015 name="input.c.bgea015"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea015               #給予default值
            CALL q_imce141_1()                                       #呼叫開窗
            LET g_bgea_m.bgea015 = g_qryparam.return1                #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea015_desc = s_desc_get_acc_desc('203',g_bgea_m.bgea015)
            DISPLAY BY NAME g_bgea_m.bgea015,g_bgea_m.bgea015_desc   #顯示到畫面上
            NEXT FIELD bgea015                                       #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea016
            #add-point:ON ACTION controlp INFIELD bgea016 name="input.c.bgea016"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea016             #給予default值
            CALL q_ooca001_1()  
            LET g_bgea_m.bgea016 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea016_desc = s_desc_get_unit_desc(g_bgea_m.bgea016)
            DISPLAY BY NAME g_bgea_m.bgea016,g_bgea_m.bgea016_desc
            NEXT FIELD bgea016                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea017
            #add-point:ON ACTION controlp INFIELD bgea017 name="input.c.bgea017"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea017      #給予default值
            LET g_qryparam.where = " bgap002 IN ('1','3') AND bgapstus = 'Y' "
            CALL q_bgap001()                       #呼叫開窗
            LET g_bgea_m.bgea017 = g_qryparam.return1      
            CALL abgi170_bgap001_ref(g_bgea_m.bgea017) RETURNING g_bgea_m.bgea017_desc
            DISPLAY BY NAME g_bgea_m.bgea017,g_bgea_m.bgea017_desc
            NEXT FIELD bgea017                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea018
            #add-point:ON ACTION controlp INFIELD bgea018 name="input.c.bgea018"
            #開窗i段
            #161111-00002#1 --s add
            #稅區
            LET g_ooef019 = ''
            SELECT ooef019 INTO g_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = g_bgea_m.bgea002
            #161111-00002#1 --e add
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea018
            LET g_qryparam.arg1 = g_ooef019   #稅區
            CALL q_oodb002_5()
            LET g_bgea_m.bgea018 = g_qryparam.return1
            LET g_bgea_m.bgea018_desc = s_desc_get_tax_desc(g_ooef019,g_bgea_m.bgea018)
            DISPLAY BY NAME g_bgea_m.bgea018,g_bgea_m.bgea018_desc
            NEXT FIELD bgea018
            #END add-point
 
 
         #Ctrlp:input.c.bgea019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea019
            #add-point:ON ACTION controlp INFIELD bgea019 name="input.c.bgea019"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea019       #給予default值
            LET g_qryparam.arg1 = g_bgea_m.bgea002
            CALL q_ooaj002_1()  
            LET g_bgea_m.bgea019 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_bgea_m.bgea019
            NEXT FIELD bgea019  
            #END add-point
 
 
         #Ctrlp:input.c.bgea020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea020
            #add-point:ON ACTION controlp INFIELD bgea020 name="input.c.bgea020"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea021
            #add-point:ON ACTION controlp INFIELD bgea021 name="input.c.bgea021"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea022
            #add-point:ON ACTION controlp INFIELD bgea022 name="input.c.bgea022"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea023
            #add-point:ON ACTION controlp INFIELD bgea023 name="input.c.bgea023"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea024
            #add-point:ON ACTION controlp INFIELD bgea024 name="input.c.bgea024"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea005
            #add-point:ON ACTION controlp INFIELD bgea005 name="input.c.bgea005"
            #開窗i段
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
            
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea005      #給予default值
            LET g_qryparam.where = " bgae007='1' AND bgae005='3' AND bgae006='",g_bgaa008,"'"
            #給予arg
            CALL q_bgae001()                                #呼叫開窗
            LET g_bgea_m.bgea005 = g_qryparam.return1       #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
            DISPLAY BY NAME g_bgea_m.bgea005                #顯示到畫面上
            NEXT FIELD bgea005                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea025
            #add-point:ON ACTION controlp INFIELD bgea025 name="input.c.bgea025"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea025             #給予default值
            CALL q_ooca001_1()                                       #呼叫開窗
            LET g_bgea_m.bgea025 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea025_desc = s_desc_get_unit_desc(g_bgea_m.bgea025) 
            DISPLAY BY NAME g_bgea_m.bgea025,g_bgea_m.bgea025_desc
            NEXT FIELD bgea025                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea026
            #add-point:ON ACTION controlp INFIELD bgea026 name="input.c.bgea026"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea026             #給予default值
            CALL q_ooca001_1()                                  #呼叫開窗
            LET g_bgea_m.bgea026 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea026_desc = s_desc_get_unit_desc(g_bgea_m.bgea026)
            DISPLAY BY NAME g_bgea_m.bgea026,g_bgea_m.bgea026_desc
            NEXT FIELD bgea026                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea027
            #add-point:ON ACTION controlp INFIELD bgea027 name="input.c.bgea027"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea027             #給予default值
            CALL q_ooca001_1()                                       #呼叫開窗
            LET g_bgea_m.bgea027 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea027_desc = s_desc_get_unit_desc(g_bgea_m.bgea027)
            DISPLAY BY NAME g_bgea_m.bgea027,g_bgea_m.bgea027_desc
            NEXT FIELD bgea027                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea028
            #add-point:ON ACTION controlp INFIELD bgea028 name="input.c.bgea028"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea029
            #add-point:ON ACTION controlp INFIELD bgea029 name="input.c.bgea029"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea030
            #add-point:ON ACTION controlp INFIELD bgea030 name="input.c.bgea030"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea031
            #add-point:ON ACTION controlp INFIELD bgea031 name="input.c.bgea031"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea031             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "206" 
            CALL q_oocq002()                                       #呼叫開窗
            LET g_bgea_m.bgea031 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea031_desc = s_desc_get_acc_desc('206',g_bgea_m.bgea031)
            DISPLAY BY NAME g_bgea_m.bgea031,g_bgea_m.bgea031_desc 
            NEXT FIELD bgea031                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea032
            #add-point:ON ACTION controlp INFIELD bgea032 name="input.c.bgea032"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea033
            #add-point:ON ACTION controlp INFIELD bgea033 name="input.c.bgea033"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea034
            #add-point:ON ACTION controlp INFIELD bgea034 name="input.c.bgea034"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea035
            #add-point:ON ACTION controlp INFIELD bgea035 name="input.c.bgea035"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea044
            #add-point:ON ACTION controlp INFIELD bgea044 name="input.c.bgea044"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea044       #給予default值
            LET g_qryparam.arg1 = g_bgea_m.bgea002
            CALL q_ooaj002_1()  
            LET g_bgea_m.bgea044 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_bgea_m.bgea044
            NEXT FIELD bgea044                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea006
            #add-point:ON ACTION controlp INFIELD bgea006 name="input.c.bgea006"
            #開窗i段
            #預算細項參照表號
            LET g_bgaa008 = ''
            SELECT bgaa008 INTO g_bgaa008
              FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
            
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea006      #給予default值
            LET g_qryparam.where = " bgae007='1' AND bgae005='2' AND bgae006='",g_bgaa008,"'"
            #給予arg
            CALL q_bgae001()                                #呼叫開窗
            LET g_bgea_m.bgea006 = g_qryparam.return1       #將開窗取得的值回傳到變數
            LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
            DISPLAY BY NAME g_bgea_m.bgea006                #顯示到畫面上
            NEXT FIELD bgea006                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgea036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea036
            #add-point:ON ACTION controlp INFIELD bgea036 name="input.c.bgea036"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea037
            #add-point:ON ACTION controlp INFIELD bgea037 name="input.c.bgea037"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea038
            #add-point:ON ACTION controlp INFIELD bgea038 name="input.c.bgea038"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea039
            #add-point:ON ACTION controlp INFIELD bgea039 name="input.c.bgea039"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea040
            #add-point:ON ACTION controlp INFIELD bgea040 name="input.c.bgea040"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea041
            #add-point:ON ACTION controlp INFIELD bgea041 name="input.c.bgea041"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea042
            #add-point:ON ACTION controlp INFIELD bgea042 name="input.c.bgea042"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgea043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea043
            #add-point:ON ACTION controlp INFIELD bgea043 name="input.c.bgea043"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO bgea_t (bgeaent,bgea001,bgea002,bgea003,bgeastus,bgeaownid,bgeaowndp,bgeacrtid, 
                   bgeacrtdp,bgeacrtdt,bgeamodid,bgeamoddt,bgea009,bgea010,bgea011,bgea012,bgea013,bgea014, 
                   bgea004,bgea015,bgea016,bgea017,bgea018,bgea019,bgea020,bgea021,bgea022,bgea023,bgea024, 
                   bgea005,bgea025,bgea026,bgea027,bgea028,bgea029,bgea030,bgea031,bgea032,bgea033,bgea034, 
                   bgea035,bgea044,bgea006,bgea036,bgea037,bgea038,bgea039,bgea040,bgea041,bgea042,bgea043) 
 
               VALUES (g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus, 
                   g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp,g_bgea_m.bgeacrtid,g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt, 
                   g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt,g_bgea_m.bgea009,g_bgea_m.bgea010,g_bgea_m.bgea011, 
                   g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004,g_bgea_m.bgea015, 
                   g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
                   g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005, 
                   g_bgea_m.bgea025,g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029, 
                   g_bgea_m.bgea030,g_bgea_m.bgea031,g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034, 
                   g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006,g_bgea_m.bgea036,g_bgea_m.bgea037, 
                   g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041,g_bgea_m.bgea042, 
                   g_bgea_m.bgea043) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_bgea_m:",SQLERRMESSAGE 
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
                  CALL abgi170_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL abgi170_b_fill()
                  CALL abgi170_b_fill2('0')
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
               CALL abgi170_bgea_t_mask_restore('restore_mask_o')
               
               UPDATE bgea_t SET (bgea001,bgea002,bgea003,bgeastus,bgeaownid,bgeaowndp,bgeacrtid,bgeacrtdp, 
                   bgeacrtdt,bgeamodid,bgeamoddt,bgea009,bgea010,bgea011,bgea012,bgea013,bgea014,bgea004, 
                   bgea015,bgea016,bgea017,bgea018,bgea019,bgea020,bgea021,bgea022,bgea023,bgea024,bgea005, 
                   bgea025,bgea026,bgea027,bgea028,bgea029,bgea030,bgea031,bgea032,bgea033,bgea034,bgea035, 
                   bgea044,bgea006,bgea036,bgea037,bgea038,bgea039,bgea040,bgea041,bgea042,bgea043) = (g_bgea_m.bgea001, 
                   g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp, 
                   g_bgea_m.bgeacrtid,g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt, 
                   g_bgea_m.bgea009,g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013, 
                   g_bgea_m.bgea014,g_bgea_m.bgea004,g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017, 
                   g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020,g_bgea_m.bgea021,g_bgea_m.bgea022, 
                   g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025,g_bgea_m.bgea026, 
                   g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
                   g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044, 
                   g_bgea_m.bgea006,g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039, 
                   g_bgea_m.bgea040,g_bgea_m.bgea041,g_bgea_m.bgea042,g_bgea_m.bgea043)
                WHERE bgeaent = g_enterprise AND bgea001 = g_bgea001_t
                  AND bgea002 = g_bgea002_t
                  AND bgea003 = g_bgea003_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "bgea_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL abgi170_bgea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_bgea_m_t)
               LET g_log2 = util.JSON.stringify(g_bgea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_bgea001_t = g_bgea_m.bgea001
            LET g_bgea002_t = g_bgea_m.bgea002
            LET g_bgea003_t = g_bgea_m.bgea003
 
            
      END INPUT
   
 
{</section>}
 
{<section id="abgi170.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_bgeb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgeb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgi170_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_bgeb_d.getLength()
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
            OPEN abgi170_cl USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abgi170_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abgi170_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bgeb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bgeb_d[l_ac].bgeb004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgeb_d_t.* = g_bgeb_d[l_ac].*  #BACKUP
               LET g_bgeb_d_o.* = g_bgeb_d[l_ac].*  #BACKUP
               CALL abgi170_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL abgi170_set_no_entry_b(l_cmd)
               IF NOT abgi170_lock_b("bgeb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgi170_bcl INTO g_bgeb_d[l_ac].bgeb004,g_bgeb_d[l_ac].bgebownid,g_bgeb_d[l_ac].bgebowndp, 
                      g_bgeb_d[l_ac].bgebcrtid,g_bgeb_d[l_ac].bgebcrtdp,g_bgeb_d[l_ac].bgebcrtdt,g_bgeb_d[l_ac].bgebmodid, 
                      g_bgeb_d[l_ac].bgebmoddt,g_bgeb_d[l_ac].bgebstus
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_bgeb_d_t.bgeb004,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgeb_d_mask_o[l_ac].* =  g_bgeb_d[l_ac].*
                  CALL abgi170_bgeb_t_mask()
                  LET g_bgeb_d_mask_n[l_ac].* =  g_bgeb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abgi170_show()
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
            INITIALIZE g_bgeb_d[l_ac].* TO NULL 
            INITIALIZE g_bgeb_d_t.* TO NULL 
            INITIALIZE g_bgeb_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgeb_d[l_ac].bgebownid = g_user
      LET g_bgeb_d[l_ac].bgebowndp = g_dept
      LET g_bgeb_d[l_ac].bgebcrtid = g_user
      LET g_bgeb_d[l_ac].bgebcrtdp = g_dept 
      LET g_bgeb_d[l_ac].bgebcrtdt = cl_get_current()
      LET g_bgeb_d[l_ac].bgebmodid = g_user
      LET g_bgeb_d[l_ac].bgebmoddt = cl_get_current()
      LET g_bgeb_d[l_ac].bgebstus = 'Y'
 
 
 
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_bgeb_d_t.* = g_bgeb_d[l_ac].*     #新輸入資料
            LET g_bgeb_d_o.* = g_bgeb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgi170_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL abgi170_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgeb_d[li_reproduce_target].* = g_bgeb_d[li_reproduce].*
 
               LET g_bgeb_d[li_reproduce_target].bgeb004 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bgeb_t 
             WHERE bgebent = g_enterprise AND bgeb001 = g_bgea_m.bgea001
               AND bgeb002 = g_bgea_m.bgea002
               AND bgeb003 = g_bgea_m.bgea003
 
               AND bgeb004 = g_bgeb_d[l_ac].bgeb004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgea_m.bgea001
               LET gs_keys[2] = g_bgea_m.bgea002
               LET gs_keys[3] = g_bgea_m.bgea003
               LET gs_keys[4] = g_bgeb_d[g_detail_idx].bgeb004
               CALL abgi170_insert_b('bgeb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_bgeb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "bgeb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abgi170_b_fill()
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
               LET gs_keys[01] = g_bgea_m.bgea001
               LET gs_keys[gs_keys.getLength()+1] = g_bgea_m.bgea002
               LET gs_keys[gs_keys.getLength()+1] = g_bgea_m.bgea003
 
               LET gs_keys[gs_keys.getLength()+1] = g_bgeb_d_t.bgeb004
 
            
               #刪除同層單身
               IF NOT abgi170_delete_b('bgeb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abgi170_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abgi170_key_delete_b(gs_keys,'bgeb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abgi170_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE abgi170_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_bgeb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bgeb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgeb004
            #add-point:BEFORE FIELD bgeb004 name="input.b.page1.bgeb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgeb004
            
            #add-point:AFTER FIELD bgeb004 name="input.a.page1.bgeb004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgea_m.bgea001 IS NOT NULL AND g_bgea_m.bgea002 IS NOT NULL AND g_bgea_m.bgea003 IS NOT NULL AND g_bgeb_d[g_detail_idx].bgeb004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgea_m.bgea001 != g_bgea001_t OR g_bgea_m.bgea002 != g_bgea002_t OR g_bgea_m.bgea003 != g_bgea003_t OR g_bgeb_d[g_detail_idx].bgeb004 != g_bgeb_d_t.bgeb004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bgeb_t WHERE "||"bgebent = '" ||g_enterprise|| "' AND "||"bgeb001 = '"||g_bgea_m.bgea001 ||"' AND "|| "bgeb002 = '"||g_bgea_m.bgea002 ||"' AND "|| "bgeb003 = '"||g_bgea_m.bgea003 ||"' AND "|| "bgeb004 = '"||g_bgeb_d[g_detail_idx].bgeb004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_bgeb_d[l_ac].bgasl003_desc = ''
            LET g_bgeb_d[l_ac].bgasl004_desc = ''
            DISPLAY BY NAME g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
            IF NOT cl_null(g_bgeb_d[l_ac].bgeb004) THEN 
               IF g_bgeb_d[l_ac].bgeb004 != g_bgeb_d_o.bgeb004 OR cl_null(g_bgeb_d_o.bgeb004) THEN 
                  CALL s_aimm200_chk_item(g_bgeb_d[l_ac].bgeb004) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_bgeb_d[l_ac].bgeb004 = g_bgeb_d_o.bgeb004
                     CALL s_desc_get_item_desc(g_bgeb_d[l_ac].bgeb004) RETURNING g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
                     DISPLAY BY NAME g_bgeb_d[l_ac].bgeb004,g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #若預算組織無據點料件可對應,則料件開窗使用ALL據點
                  LET l_cnt_imaf001 = 0
                  SELECT COUNT(1) INTO l_cnt_imaf001 
                    FROM imaf_t LEFT OUTER JOIN imaal_t ON imafent = imaalent AND imaf001 = imaal001 AND imaal002 = g_dlang ,imaa_t
                    WHERE imaaent = imafent AND imaa001 = imaf001 AND imaaent = g_enterprise AND imafsite = g_bgea_m.bgea002 AND imaastus = 'Y'
                  IF cl_null(l_cnt_imaf001) THEN LET l_cnt_imaf001 = 0 END IF
                  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgea_m.bgea002
                  LET g_chkparam.arg2 = g_bgeb_d[l_ac].bgeb004
                  LET g_errshow = TRUE   #161129-00019#3   add
                  IF l_cnt_imaf001 = 0 THEN
                     LET g_chkparam.arg2 = 'ALL'
                  END IF
                  IF NOT cl_chk_exist("v_imaf001_3") THEN
                     LET g_bgeb_d[l_ac].bgeb004 = g_bgeb_d_o.bgeb004
                     CALL s_desc_get_item_desc(g_bgeb_d[l_ac].bgeb004) RETURNING g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
                     DISPLAY BY NAME g_bgeb_d[l_ac].bgeb004,g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161129-00019#3   add---s
                  CALL s_abgi170_bgeb004_chk(g_bgeb_d[l_ac].bgeb004,g_bgea_m.bgea003,g_bgea_m.bgea001,g_bgea_m.bgea002) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeb_d[l_ac].bgeb004 = g_bgeb_d_o.bgeb004
                     CALL s_desc_get_item_desc(g_bgeb_d[l_ac].bgeb004) RETURNING g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
                     DISPLAY BY NAME g_bgeb_d[l_ac].bgeb004,g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161129-00019#3   add---e
               END IF
            END IF
            CALL s_desc_get_item_desc(g_bgeb_d[l_ac].bgeb004) RETURNING g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
            DISPLAY BY NAME g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
            LET g_bgeb_d_o.* = g_bgeb_d[l_ac].*

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgeb004
            #add-point:ON CHANGE bgeb004 name="input.g.page1.bgeb004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgeb004
            #add-point:ON ACTION controlp INFIELD bgeb004 name="input.c.page1.bgeb004"
            #開窗i段
            #若預算組織無據點料件可對應,則料件開窗使用ALL據點
            LET l_cnt_imaf001 = 0
            SELECT COUNT(1) INTO l_cnt_imaf001 
              FROM imaf_t LEFT OUTER JOIN imaal_t ON imafent = imaalent AND imaf001 = imaal001 AND imaal002 = g_dlang ,imaa_t
              WHERE imaaent = imafent AND imaa001 = imaf001 AND imaaent = g_enterprise AND imafsite = g_bgea_m.bgea002 AND imaastus = 'Y'
            IF cl_null(l_cnt_imaf001) THEN LET l_cnt_imaf001 = 0 END IF
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_bgea_m.bgea002
            IF l_cnt_imaf001 = 0 THEN
               LET g_qryparam.arg1 = 'ALL'
            END IF
            CALL q_imaf001_7()                                #呼叫開窗
            LET g_bgeb_d[l_ac].bgeb004 = g_qryparam.return1   #將開窗取得的值回傳到變數
            CALL s_desc_get_item_desc(g_bgeb_d[l_ac].bgeb004) RETURNING g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
            DISPLAY BY NAME g_bgeb_d[l_ac].bgeb004,g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
            NEXT FIELD bgeb004                                #返回原欄位
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgeb_d[l_ac].* = g_bgeb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abgi170_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_bgeb_d[l_ac].bgeb004 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_bgeb_d[l_ac].* = g_bgeb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               LET g_bgeb_d[l_ac].bgebmodid = g_user 
LET g_bgeb_d[l_ac].bgebmoddt = cl_get_current()
LET g_bgeb_d[l_ac].bgebmodid_desc = cl_get_username(g_bgeb_d[l_ac].bgebmodid)
      
               #將遮罩欄位還原
               CALL abgi170_bgeb_t_mask_restore('restore_mask_o')
      
               UPDATE bgeb_t SET (bgeb001,bgeb002,bgeb003,bgeb004,bgebownid,bgebowndp,bgebcrtid,bgebcrtdp, 
                   bgebcrtdt,bgebmodid,bgebmoddt,bgebstus) = (g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003, 
                   g_bgeb_d[l_ac].bgeb004,g_bgeb_d[l_ac].bgebownid,g_bgeb_d[l_ac].bgebowndp,g_bgeb_d[l_ac].bgebcrtid, 
                   g_bgeb_d[l_ac].bgebcrtdp,g_bgeb_d[l_ac].bgebcrtdt,g_bgeb_d[l_ac].bgebmodid,g_bgeb_d[l_ac].bgebmoddt, 
                   g_bgeb_d[l_ac].bgebstus)
                WHERE bgebent = g_enterprise AND bgeb001 = g_bgea_m.bgea001 
                  AND bgeb002 = g_bgea_m.bgea002 
                  AND bgeb003 = g_bgea_m.bgea003 
 
                  AND bgeb004 = g_bgeb_d_t.bgeb004 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bgeb_d[l_ac].* = g_bgeb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgeb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bgeb_d[l_ac].* = g_bgeb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgeb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgea_m.bgea001
               LET gs_keys_bak[1] = g_bgea001_t
               LET gs_keys[2] = g_bgea_m.bgea002
               LET gs_keys_bak[2] = g_bgea002_t
               LET gs_keys[3] = g_bgea_m.bgea003
               LET gs_keys_bak[3] = g_bgea003_t
               LET gs_keys[4] = g_bgeb_d[g_detail_idx].bgeb004
               LET gs_keys_bak[4] = g_bgeb_d_t.bgeb004
               CALL abgi170_update_b('bgeb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL abgi170_bgeb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_bgeb_d[g_detail_idx].bgeb004 = g_bgeb_d_t.bgeb004 
 
                  ) THEN
                  LET gs_keys[01] = g_bgea_m.bgea001
                  LET gs_keys[gs_keys.getLength()+1] = g_bgea_m.bgea002
                  LET gs_keys[gs_keys.getLength()+1] = g_bgea_m.bgea003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeb_d_t.bgeb004
 
                  CALL abgi170_key_update_b(gs_keys,'bgeb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bgea_m),util.JSON.stringify(g_bgeb_d_t)
               LET g_log2 = util.JSON.stringify(g_bgea_m),util.JSON.stringify(g_bgeb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL abgi170_unlock_b("bgeb_t","'1'")
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
               LET g_bgeb_d[li_reproduce_target].* = g_bgeb_d[li_reproduce].*
 
               LET g_bgeb_d[li_reproduce_target].bgeb004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgeb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgeb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_bgeb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgeb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgi170_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_bgeb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgeb2_d[l_ac].* TO NULL 
            INITIALIZE g_bgeb2_d_t.* TO NULL 
            INITIALIZE g_bgeb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgeb2_d[l_ac].bgecownid = g_user
      LET g_bgeb2_d[l_ac].bgecowndp = g_dept
      LET g_bgeb2_d[l_ac].bgeccrtid = g_user
      LET g_bgeb2_d[l_ac].bgeccrtdp = g_dept 
      LET g_bgeb2_d[l_ac].bgeccrtdt = cl_get_current()
      LET g_bgeb2_d[l_ac].bgecmodid = g_user
      LET g_bgeb2_d[l_ac].bgecmoddt = cl_get_current()
      LET g_bgeb2_d[l_ac].bgecstus = 'Y'
 
 
 
            #自定義預設值(單身2)
                  LET g_bgeb2_d[l_ac].bgec006 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_bgeb2_d_t.* = g_bgeb2_d[l_ac].*     #新輸入資料
            LET g_bgeb2_d_o.* = g_bgeb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgi170_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL abgi170_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgeb2_d[li_reproduce_target].* = g_bgeb2_d[li_reproduce].*
 
               LET g_bgeb2_d[li_reproduce_target].bgec004 = NULL
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
            OPEN abgi170_cl USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN abgi170_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE abgi170_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_bgeb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_bgeb2_d[l_ac].bgec004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_bgeb2_d_t.* = g_bgeb2_d[l_ac].*  #BACKUP
               LET g_bgeb2_d_o.* = g_bgeb2_d[l_ac].*  #BACKUP
               CALL abgi170_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL abgi170_set_no_entry_b(l_cmd)
               IF NOT abgi170_lock_b("bgec_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgi170_bcl2 INTO g_bgeb2_d[l_ac].bgec004,g_bgeb2_d[l_ac].bgec006,g_bgeb2_d[l_ac].bgecownid, 
                      g_bgeb2_d[l_ac].bgecowndp,g_bgeb2_d[l_ac].bgeccrtid,g_bgeb2_d[l_ac].bgeccrtdp, 
                      g_bgeb2_d[l_ac].bgeccrtdt,g_bgeb2_d[l_ac].bgecmodid,g_bgeb2_d[l_ac].bgecmoddt, 
                      g_bgeb2_d[l_ac].bgecstus
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgeb2_d_mask_o[l_ac].* =  g_bgeb2_d[l_ac].*
                  CALL abgi170_bgec_t_mask()
                  LET g_bgeb2_d_mask_n[l_ac].* =  g_bgeb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL abgi170_show()
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
               LET gs_keys[01] = g_bgea_m.bgea001
               LET gs_keys[gs_keys.getLength()+1] = g_bgea_m.bgea002
               LET gs_keys[gs_keys.getLength()+1] = g_bgea_m.bgea003
               LET gs_keys[gs_keys.getLength()+1] = g_bgeb2_d_t.bgec004
            
               #刪除同層單身
               IF NOT abgi170_delete_b('bgec_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abgi170_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT abgi170_key_delete_b(gs_keys,'bgec_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE abgi170_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE abgi170_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_bgeb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_bgeb2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM bgec_t 
             WHERE bgecent = g_enterprise AND bgec001 = g_bgea_m.bgea001
               AND bgec002 = g_bgea_m.bgea002
               AND bgec003 = g_bgea_m.bgea003
               AND bgec004 = g_bgeb2_d[l_ac].bgec004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgea_m.bgea001
               LET gs_keys[2] = g_bgea_m.bgea002
               LET gs_keys[3] = g_bgea_m.bgea003
               LET gs_keys[4] = g_bgeb2_d[g_detail_idx].bgec004
               CALL abgi170_insert_b('bgec_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_bgeb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bgec_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL abgi170_b_fill()
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
               LET g_bgeb2_d[l_ac].* = g_bgeb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abgi170_bcl2
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
               LET g_bgeb2_d[l_ac].* = g_bgeb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               LET g_bgeb2_d[l_ac].bgecmodid = g_user 
LET g_bgeb2_d[l_ac].bgecmoddt = cl_get_current()
LET g_bgeb2_d[l_ac].bgecmodid_desc = cl_get_username(g_bgeb2_d[l_ac].bgecmodid)
               
               #將遮罩欄位還原
               CALL abgi170_bgec_t_mask_restore('restore_mask_o')
                              
               UPDATE bgec_t SET (bgec001,bgec002,bgec003,bgec004,bgec006,bgecownid,bgecowndp,bgeccrtid, 
                   bgeccrtdp,bgeccrtdt,bgecmodid,bgecmoddt,bgecstus) = (g_bgea_m.bgea001,g_bgea_m.bgea002, 
                   g_bgea_m.bgea003,g_bgeb2_d[l_ac].bgec004,g_bgeb2_d[l_ac].bgec006,g_bgeb2_d[l_ac].bgecownid, 
                   g_bgeb2_d[l_ac].bgecowndp,g_bgeb2_d[l_ac].bgeccrtid,g_bgeb2_d[l_ac].bgeccrtdp,g_bgeb2_d[l_ac].bgeccrtdt, 
                   g_bgeb2_d[l_ac].bgecmodid,g_bgeb2_d[l_ac].bgecmoddt,g_bgeb2_d[l_ac].bgecstus) #自訂欄位頁簽 
 
                WHERE bgecent = g_enterprise AND bgec001 = g_bgea_m.bgea001
                  AND bgec002 = g_bgea_m.bgea002
                  AND bgec003 = g_bgea_m.bgea003
                  AND bgec004 = g_bgeb2_d_t.bgec004 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_bgeb2_d[l_ac].* = g_bgeb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgec_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_bgeb2_d[l_ac].* = g_bgeb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgec_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgea_m.bgea001
               LET gs_keys_bak[1] = g_bgea001_t
               LET gs_keys[2] = g_bgea_m.bgea002
               LET gs_keys_bak[2] = g_bgea002_t
               LET gs_keys[3] = g_bgea_m.bgea003
               LET gs_keys_bak[3] = g_bgea003_t
               LET gs_keys[4] = g_bgeb2_d[g_detail_idx].bgec004
               LET gs_keys_bak[4] = g_bgeb2_d_t.bgec004
               CALL abgi170_update_b('bgec_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgi170_bgec_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_bgeb2_d[g_detail_idx].bgec004 = g_bgeb2_d_t.bgec004 
                  ) THEN
                  LET gs_keys[01] = g_bgea_m.bgea001
                  LET gs_keys[gs_keys.getLength()+1] = g_bgea_m.bgea002
                  LET gs_keys[gs_keys.getLength()+1] = g_bgea_m.bgea003
                  LET gs_keys[gs_keys.getLength()+1] = g_bgeb2_d_t.bgec004
                  CALL abgi170_key_update_b(gs_keys,'bgec_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_bgea_m),util.JSON.stringify(g_bgeb2_d_t)
               LET g_log2 = util.JSON.stringify(g_bgea_m),util.JSON.stringify(g_bgeb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgec004
            
            #add-point:AFTER FIELD bgec004 name="input.a.page2.bgec004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bgea_m.bgea001 IS NOT NULL AND g_bgea_m.bgea002 IS NOT NULL AND g_bgea_m.bgea003 IS NOT NULL AND g_bgeb2_d[g_detail_idx].bgec004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bgea_m.bgea001 != g_bgea001_t OR g_bgea_m.bgea002 != g_bgea002_t OR g_bgea_m.bgea003 != g_bgea003_t OR g_bgeb2_d[g_detail_idx].bgec004 != g_bgeb2_d_t.bgec004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bgec_t WHERE "||"bgecent = '" ||g_enterprise|| "' AND "||"bgec001 = '"||g_bgea_m.bgea001 ||"' AND "|| "bgec002 = '"||g_bgea_m.bgea002 ||"' AND "|| "bgec003 = '"||g_bgea_m.bgea003 ||"' AND "|| "bgec004 = '"||g_bgeb2_d[g_detail_idx].bgec004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_bgeb2_d[l_ac].bgec004_desc = ' '
            DISPLAY BY NAME g_bgeb2_d[l_ac].bgec004_desc
            IF NOT cl_null(g_bgeb2_d[l_ac].bgec004) THEN
               IF g_bgeb2_d[l_ac].bgec004 != g_bgeb2_d_o.bgec004 OR cl_null(g_bgeb2_d_o.bgec004) THEN  
                  #161105-00004#2 ---s--- 不可為預算組織
                  IF g_bgeb2_d[l_ac].bgec004  = g_bgea_m.bgea002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00240'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeb2_d[l_ac].bgec004 = g_bgeb2_d_o.bgec004
                     LET g_bgeb2_d[l_ac].bgec004_desc =s_desc_get_department_desc(g_bgeb2_d[l_ac].bgec004)
                     DISPLAY BY NAME g_bgeb2_d[l_ac].bgec004,g_bgeb2_d[l_ac].bgec004_desc
                     NEXT FIELD CURRENT
                  END IF              
                  #161105-00004#2 ---e---                 
                  CALL abgi170_bgea002_chk(g_bgeb2_d[l_ac].bgec004)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgeb2_d[l_ac].bgec004 = g_bgeb2_d_o.bgec004
                     LET g_bgeb2_d[l_ac].bgec004_desc =s_desc_get_department_desc(g_bgeb2_d[l_ac].bgec004)
                     DISPLAY BY NAME g_bgeb2_d[l_ac].bgec004,g_bgeb2_d[l_ac].bgec004_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_bgea_m.bgea001)THEN
                     CALL s_abg_site_chk(g_bgeb2_d[l_ac].bgec004)RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgeb2_d[l_ac].bgec004 = g_bgeb2_d_o.bgec004
                        LET g_bgeb2_d[l_ac].bgec004_desc =s_desc_get_department_desc(g_bgeb2_d[l_ac].bgec004)
                        DISPLAY BY NAME g_bgeb2_d[l_ac].bgec004,g_bgeb2_d[l_ac].bgec004_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF    
                  #161105-00004#2  ---s---
                  #預帶ooef024到交易對象------------------------------------------------------------
                  #LET g_bgeb2_d[l_ac].bgec005 = ''
                  #SELECT ooef024 INTO g_bgeb2_d[l_ac].bgec005
                  #  FROM ooef_t 
                  # WHERE ooefent = g_enterprise AND ooef001 = g_bgeb2_d[l_ac].bgec004 AND ooefstus = 'Y'
                  ##檢核是否存在abgi150
                  #IF NOT ap_chk_isExist(g_bgeb2_d[l_ac].bgec005,"SELECT COUNT(1) FROM bgap_t WHERE "||"bgapent = '" ||g_enterprise|| "' AND "|| " bgap001 =? ",'abg-00172',0) THEN 
                  #   LET g_bgeb2_d[l_ac].bgec005 = ''
                  #END IF
                  #IF NOT ap_chk_isExist(g_bgeb2_d[l_ac].bgec005,"SELECT COUNT(1) FROM bgap_t WHERE "||"bgapent = '" ||g_enterprise|| "' AND "|| " bgap001 =? AND bgapstus='Y' ",'sub-01302','abgi150') THEN 
                  #   LET g_bgeb2_d[l_ac].bgec005 = ''
                  #END IF
                  #LET g_bgeb2_d[l_ac].bgec005_desc = abgi170_bgec005_ref(g_bgeb2_d[l_ac].bgec005)
                  #DISPLAY BY NAME g_bgeb2_d[l_ac].bgec005,g_bgeb2_d[l_ac].bgec005_desc                  
                  #--------------------------------------------------------------------------------
                  #161105-00004#2  ---e---
                  #161223-00027#1 --s add
                  #預帶ooef024
                  LET g_bgeb2_d[l_ac].l_bgec005 = ''
                  SELECT ooef024 INTO g_bgeb2_d[l_ac].l_bgec005
                    FROM ooef_t 
                   WHERE ooefent = g_enterprise AND ooef001 = g_bgeb2_d[l_ac].bgec004 AND ooefstus = 'Y'
                  LET g_bgeb2_d[l_ac].bgec005_desc = s_desc_get_trading_partner_abbr_desc(g_bgeb2_d[l_ac].l_bgec005)
                  DISPLAY BY NAME g_bgeb2_d[l_ac].l_bgec005,g_bgeb2_d[l_ac].bgec005_desc                       
                  #161223-00027#1 --e add
               END IF
            END IF
            LET g_bgeb2_d[l_ac].bgec004_desc =s_desc_get_department_desc(g_bgeb2_d[l_ac].bgec004)
            DISPLAY BY NAME g_bgeb2_d[l_ac].bgec004,g_bgeb2_d[l_ac].bgec004_desc
            LET g_bgeb2_d_o.* = g_bgeb2_d[l_ac].*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgec004
            #add-point:BEFORE FIELD bgec004 name="input.b.page2.bgec004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgec004
            #add-point:ON CHANGE bgec004 name="input.g.page2.bgec004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgec006
            #add-point:BEFORE FIELD bgec006 name="input.b.page2.bgec006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgec006
            
            #add-point:AFTER FIELD bgec006 name="input.a.page2.bgec006"
            IF NOT cl_null(g_bgeb2_d[l_ac].bgec006) THEN
               IF g_bgeb2_d[l_ac].bgec006 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ast-00083'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  LET g_bgeb2_d[l_ac].bgec006 = g_bgeb2_d_o.bgec006
                  NEXT FIELD CURRENT
               END IF
               #合計不可大於進銷存訊息的內採比例 
               IF NOT cl_null(g_bgea_m.bgea023) OR g_bgea_m.bgea023 <> 0 THEN
                  LET l_sum_bgec006 = 0
                  SELECT SUM(bgec006) INTO l_sum_bgec006 FROM bgec_t
                   WHERE bgecent = g_enterprise AND bgec001 = g_bgea_m.bgea001 AND bgec002 = g_bgea_m.bgea002 AND bgec003 = g_bgea_m.bgea003 
                  IF cl_null(l_sum_bgec006) THEN LET l_sum_bgec006 = 0 END IF
                  IF cl_null(g_bgeb2_d_o.bgec006) THEN LET g_bgeb2_d_o.bgec006 = 0 END IF
                  IF (g_bgeb2_d[l_ac].bgec006 - g_bgeb2_d_o.bgec006 + l_sum_bgec006) > g_bgea_m.bgea023 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'abg-00176'
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_bgeb2_d[l_ac].bgec006 = g_bgeb2_d_o.bgec006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgeb2_d[l_ac].bgec006 = 0
            END IF
            LET g_bgeb2_d_o.* = g_bgeb2_d[l_ac].*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgec006
            #add-point:ON CHANGE bgec006 name="input.g.page2.bgec006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.bgec004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgec004
            #add-point:ON ACTION controlp INFIELD bgec004 name="input.c.page2.bgec004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y' AND ooef001 IN (SELECT ooef001 FROM s_fin_tmp1 ) AND ooefstus = 'Y' ",
                                   "               AND ooef001 <> '",g_bgea_m.bgea002,"' " #161105-00004#2
            LET g_qryparam.default1 = g_bgeb2_d[l_ac].bgec004
            CALL q_ooef001()
            LET g_bgeb2_d[l_ac].bgec004 = g_qryparam.return1
            NEXT FIELD bgec004
            #END add-point
 
 
         #Ctrlp:input.c.page2.bgec006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgec006
            #add-point:ON ACTION controlp INFIELD bgec006 name="input.c.page2.bgec006"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgeb2_d[l_ac].* = g_bgeb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE abgi170_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL abgi170_unlock_b("bgec_t","'2'")
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
               LET g_bgeb2_d[li_reproduce_target].* = g_bgeb2_d[li_reproduce].*
 
               LET g_bgeb2_d[li_reproduce_target].bgec004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgeb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgeb2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="abgi170.input.other" >}
      
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
            
            #end add-point  
            NEXT FIELD bgea001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgeb004
               WHEN "s_detail2"
                  NEXT FIELD bgec004
 
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
         #重新導向至第一頁簽欄位
         CALL gfrm_curr.ensureFieldVisible("bgea_t.bgea009")
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         #重新導向至第一頁簽欄位
         CALL gfrm_curr.ensureFieldVisible("bgea_t.bgea009")
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
 
{<section id="abgi170.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgi170_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   #預算細項參照表號
   LET g_bgaa008 = ''
   SELECT bgaa008 INTO g_bgaa008
     FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgea_m.bgea001
     
   #161111-00002#1 --s add
   #幣別/取得據點所屬法人/稅區
   LET g_ooef019 = ''
   SELECT ooef019 INTO g_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_bgea_m.bgea002
   #161111-00002#1 --e add
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL abgi170_b_fill() #單身填充
      CALL abgi170_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgi170_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL s_desc_get_budget_desc(g_bgea_m.bgea001) RETURNING g_bgea_m.bgea001_desc
   CALL s_fin_abg_center_sons_query(g_bgea_m.bgea001,'','')
   LET g_bgea_m.bgea002_desc =s_desc_get_department_desc(g_bgea_m.bgea002)
   CALL abgi170_bgea003_ref()
   
   #進銷存資訊/成本資訊
   LET g_bgea_m.bgea009_desc = s_desc_get_acc_desc('202',g_bgea_m.bgea009)
   LET g_bgea_m.bgea010_desc = s_desc_get_unit_desc(g_bgea_m.bgea010)
   CALL abgi170_bgap001_ref(g_bgea_m.bgea011) RETURNING g_bgea_m.bgea011_desc
   LET g_bgea_m.bgea012_desc = s_desc_get_tax_desc(g_ooef019,g_bgea_m.bgea012)
   LET g_bgea_m.bgea004_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea004)
   LET g_bgea_m.bgea015_desc = s_desc_get_acc_desc('203',g_bgea_m.bgea015)
   LET g_bgea_m.bgea016_desc = s_desc_get_unit_desc(g_bgea_m.bgea016)
   CALL abgi170_bgap001_ref(g_bgea_m.bgea017) RETURNING g_bgea_m.bgea017_desc
   LET g_bgea_m.bgea005_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea005)
   LET g_bgea_m.bgea025_desc = s_desc_get_unit_desc(g_bgea_m.bgea025) 
   LET g_bgea_m.bgea026_desc = s_desc_get_unit_desc(g_bgea_m.bgea026)
   LET g_bgea_m.bgea027_desc = s_desc_get_unit_desc(g_bgea_m.bgea027)
   LET g_bgea_m.bgea031_desc = s_desc_get_acc_desc('206',g_bgea_m.bgea031)
   LET g_bgea_m.bgea006_desc = s_abg_bgae001_desc(g_bgaa008,g_bgea_m.bgea006)
   #end add-point
   
   #遮罩相關處理
   LET g_bgea_m_mask_o.* =  g_bgea_m.*
   CALL abgi170_bgea_t_mask()
   LET g_bgea_m_mask_n.* =  g_bgea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc,g_bgea_m.bgea002,g_bgea_m.bgea002_desc,g_bgea_m.bgea003, 
       g_bgea_m.l_bgas005,g_bgea_m.l_bgasl003,g_bgea_m.l_bgasl004,g_bgea_m.l_bgas009,g_bgea_m.l_bgas009_desc, 
       g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp,g_bgea_m.bgeaowndp_desc, 
       g_bgea_m.bgeacrtid,g_bgea_m.bgeacrtid_desc,g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeacrtdt, 
       g_bgea_m.bgeamodid,g_bgea_m.bgeamodid_desc,g_bgea_m.bgeamoddt,g_bgea_m.bgea009,g_bgea_m.bgea009_desc, 
       g_bgea_m.bgea010,g_bgea_m.bgea010_desc,g_bgea_m.bgea011,g_bgea_m.bgea011_desc,g_bgea_m.bgea012, 
       g_bgea_m.bgea012_desc,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004,g_bgea_m.bgea004_desc, 
       g_bgea_m.bgea015,g_bgea_m.bgea015_desc,g_bgea_m.bgea016,g_bgea_m.bgea016_desc,g_bgea_m.bgea017, 
       g_bgea_m.bgea017_desc,g_bgea_m.bgea018,g_bgea_m.bgea018_desc,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea005_desc, 
       g_bgea_m.bgea025,g_bgea_m.bgea025_desc,g_bgea_m.bgea026,g_bgea_m.bgea026_desc,g_bgea_m.bgea027, 
       g_bgea_m.bgea027_desc,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031,g_bgea_m.bgea031_desc, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea006_desc,g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040, 
       g_bgea_m.bgea041,g_bgea_m.bgea042,g_bgea_m.bgea043
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bgea_m.bgeastus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_bgeb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      CALL s_desc_get_item_desc(g_bgeb_d[l_ac].bgeb004) RETURNING g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bgeb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      LET g_bgeb2_d[l_ac].bgec004_desc = s_desc_get_department_desc(g_bgeb2_d[l_ac].bgec004)
      #161223-00027#1 --s add
      #預帶ooef024
      LET g_bgeb2_d[l_ac].l_bgec005 = ''
      SELECT ooef024 INTO g_bgeb2_d[l_ac].l_bgec005
        FROM ooef_t 
       WHERE ooefent = g_enterprise AND ooef001 = g_bgeb2_d[l_ac].bgec004 AND ooefstus = 'Y'
      LET g_bgeb2_d[l_ac].bgec005_desc = s_desc_get_trading_partner_abbr_desc(g_bgeb2_d[l_ac].l_bgec005)
      DISPLAY BY NAME g_bgeb2_d[l_ac].l_bgec005,g_bgeb2_d[l_ac].bgec005_desc                       
      #161223-00027#1 --e add       
      #LET g_bgeb2_d[l_ac].bgec005_desc = abgi170_bgec005_ref(g_bgeb2_d[l_ac].bgec005) #161223-00027#1 mark
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL abgi170_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION abgi170_detail_show()
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
 
{<section id="abgi170.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgi170_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE bgea_t.bgea001 
   DEFINE l_oldno     LIKE bgea_t.bgea001 
   DEFINE l_newno02     LIKE bgea_t.bgea002 
   DEFINE l_oldno02     LIKE bgea_t.bgea002 
   DEFINE l_newno03     LIKE bgea_t.bgea003 
   DEFINE l_oldno03     LIKE bgea_t.bgea003 
 
   DEFINE l_master    RECORD LIKE bgea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bgeb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE bgec_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_bgea_m.bgea001 IS NULL
   OR g_bgea_m.bgea002 IS NULL
   OR g_bgea_m.bgea003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_bgea001_t = g_bgea_m.bgea001
   LET g_bgea002_t = g_bgea_m.bgea002
   LET g_bgea003_t = g_bgea_m.bgea003
 
    
   LET g_bgea_m.bgea001 = ""
   LET g_bgea_m.bgea002 = ""
   LET g_bgea_m.bgea003 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgea_m.bgeaownid = g_user
      LET g_bgea_m.bgeaowndp = g_dept
      LET g_bgea_m.bgeacrtid = g_user
      LET g_bgea_m.bgeacrtdp = g_dept 
      LET g_bgea_m.bgeacrtdt = cl_get_current()
      LET g_bgea_m.bgeamodid = g_user
      LET g_bgea_m.bgeamoddt = cl_get_current()
      LET g_bgea_m.bgeastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_bgea_m.bgea004 = ''
   LET g_bgea_m.bgea005 = ''
   LET g_bgea_m.bgea006 = ''
   LET g_bgea_m.bgea004_desc = ''
   LET g_bgea_m.bgea005_desc = ''
   LET g_bgea_m.bgea006_desc = ''
   DISPLAY BY NAME g_bgea_m.bgea004_desc,g_bgea_m.bgea005_desc,g_bgea_m.bgea006_desc
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_bgea_m.bgeastus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_bgea_m.bgea001_desc = ''
   DISPLAY BY NAME g_bgea_m.bgea001_desc
   LET g_bgea_m.bgea002_desc = ''
   DISPLAY BY NAME g_bgea_m.bgea002_desc
 
   
   CALL abgi170_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_bgea_m.* TO NULL
      INITIALIZE g_bgeb_d TO NULL
      INITIALIZE g_bgeb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL abgi170_show()
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
   CALL abgi170_set_act_visible()   
   CALL abgi170_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_bgea001_t = g_bgea_m.bgea001
   LET g_bgea002_t = g_bgea_m.bgea002
   LET g_bgea003_t = g_bgea_m.bgea003
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgeaent = " ||g_enterprise|| " AND",
                      " bgea001 = '", g_bgea_m.bgea001, "' "
                      ," AND bgea002 = '", g_bgea_m.bgea002, "' "
                      ," AND bgea003 = '", g_bgea_m.bgea003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgi170_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL abgi170_idx_chk()
   
   LET g_data_owner = g_bgea_m.bgeaownid      
   LET g_data_dept  = g_bgea_m.bgeaowndp
   
   #功能已完成,通報訊息中心
   CALL abgi170_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="abgi170.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgi170_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bgeb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE bgec_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgi170_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   #CREATE TEMP TABLE
   SELECT * FROM bgeb_t
    WHERE bgebent = g_enterprise AND bgeb001 = g_bgea001_t
     AND bgeb002 = g_bgea002_t
     AND bgeb003 = g_bgea003_t

    INTO TEMP abgi170_detail
 
   #將key修正為調整後   
   UPDATE abgi170_detail 
      #更新key欄位
      SET bgeb001 = g_bgea_m.bgea001
          , bgeb002 = g_bgea_m.bgea002
          , bgeb003 = g_bgea_m.bgea003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bgebownid = g_user 
       , bgebowndp = g_dept
       , bgebcrtid = g_user
       , bgebcrtdp = g_dept 
       , bgebcrtdt = ld_date
       , bgebmodid = g_user
       , bgebmoddt = ld_date
      #, bgebstus = "Y"  
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"

   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bgeb_t SELECT * FROM abgi170_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abgi170_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"

   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"

   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgec_t 
    WHERE bgecent = g_enterprise AND bgec001 = g_bgea001_t
      AND bgec002 = g_bgea002_t   
      AND bgec003 = g_bgea003_t   
 
    INTO TEMP abgi170_detail
 
   #將key修正為調整後   
   UPDATE abgi170_detail SET bgec001 = g_bgea_m.bgea001
                                       , bgec002 = g_bgea_m.bgea002
                                       , bgec003 = g_bgea_m.bgea003
   #應用 a13 樣板自動產生(Version:4)
       , bgecownid = g_user 
       , bgecowndp = g_dept
       , bgeccrtid = g_user
       , bgeccrtdp = g_dept 
       , bgeccrtdt = ld_date
       , bgecmodid = g_user
       , bgecmoddt = ld_date
      #, bgecstus = "Y" 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"

   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO bgec_t SELECT * FROM abgi170_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abgi170_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"

   #end add-point
   
   #多語言複製段落
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgea001_t = g_bgea_m.bgea001
   LET g_bgea002_t = g_bgea_m.bgea002
   LET g_bgea003_t = g_bgea_m.bgea003
 
   RETURN
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgeb_t
    WHERE bgebent = g_enterprise AND bgeb001 = g_bgea001_t
     AND bgeb002 = g_bgea002_t
     AND bgeb003 = g_bgea003_t
 
    INTO TEMP abgi170_detail
 
   #將key修正為調整後   
   UPDATE abgi170_detail 
      #更新key欄位
      SET bgeb001 = g_bgea_m.bgea001
          , bgeb002 = g_bgea_m.bgea002
          , bgeb003 = g_bgea_m.bgea003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bgebownid = g_user 
       , bgebowndp = g_dept
       , bgebcrtid = g_user
       , bgebcrtdp = g_dept 
       , bgebcrtdt = ld_date
       , bgebmodid = g_user
       , bgebmoddt = ld_date
      #, bgebstus = "Y" 
 
 
#應用 a13 樣板自動產生(Version:4)
       , bgecownid = g_user 
       , bgecowndp = g_dept
       , bgeccrtid = g_user
       , bgeccrtdp = g_dept 
       , bgeccrtdt = ld_date
       , bgecmodid = g_user
       , bgecmoddt = ld_date
      #, bgecstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO bgeb_t SELECT * FROM abgi170_detail
   
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
   DROP TABLE abgi170_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgec_t 
    WHERE bgecent = g_enterprise AND bgec001 = g_bgea001_t
      AND bgec002 = g_bgea002_t   
      AND bgec003 = g_bgea003_t   
 
    INTO TEMP abgi170_detail
 
   #將key修正為調整後   
   UPDATE abgi170_detail SET bgec001 = g_bgea_m.bgea001
                                       , bgec002 = g_bgea_m.bgea002
                                       , bgec003 = g_bgea_m.bgea003
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO bgec_t SELECT * FROM abgi170_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE abgi170_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgea001_t = g_bgea_m.bgea001
   LET g_bgea002_t = g_bgea_m.bgea002
   LET g_bgea003_t = g_bgea_m.bgea003
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgi170_delete()
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
   
   IF g_bgea_m.bgea001 IS NULL
   OR g_bgea_m.bgea002 IS NULL
   OR g_bgea_m.bgea003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN abgi170_cl USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi170_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE abgi170_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgi170_master_referesh USING g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgea_m.bgea001, 
       g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp,g_bgea_m.bgeacrtid, 
       g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt,g_bgea_m.bgea009, 
       g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
       g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025, 
       g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041, 
       g_bgea_m.bgea042,g_bgea_m.bgea043,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp_desc,g_bgea_m.bgeacrtid_desc, 
       g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeamodid_desc
   
   
   #檢查是否允許此動作
   IF NOT abgi170_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_bgea_m_mask_o.* =  g_bgea_m.*
   CALL abgi170_bgea_t_mask()
   LET g_bgea_m_mask_n.* =  g_bgea_m.*
   
   CALL abgi170_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgi170_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_bgea001_t = g_bgea_m.bgea001
      LET g_bgea002_t = g_bgea_m.bgea002
      LET g_bgea003_t = g_bgea_m.bgea003
 
 
      DELETE FROM bgea_t
       WHERE bgeaent = g_enterprise AND bgea001 = g_bgea_m.bgea001
         AND bgea002 = g_bgea_m.bgea002
         AND bgea003 = g_bgea_m.bgea003
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_bgea_m.bgea001,":",SQLERRMESSAGE  
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
      
      DELETE FROM bgeb_t
       WHERE bgebent = g_enterprise AND bgeb001 = g_bgea_m.bgea001
         AND bgeb002 = g_bgea_m.bgea002
         AND bgeb003 = g_bgea_m.bgea003
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgeb_t:",SQLERRMESSAGE 
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
      DELETE FROM bgec_t
       WHERE bgecent = g_enterprise AND
             bgec001 = g_bgea_m.bgea001 AND bgec002 = g_bgea_m.bgea002 AND bgec003 = g_bgea_m.bgea003
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_bgea_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE abgi170_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_bgeb_d.clear() 
      CALL g_bgeb2_d.clear()       
 
     
      CALL abgi170_ui_browser_refresh()  
      #CALL abgi170_ui_headershow()  
      #CALL abgi170_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL abgi170_browser_fill("")
         CALL abgi170_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE abgi170_cl
 
   #功能已完成,通報訊息中心
   CALL abgi170_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgi170.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgi170_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_bgeb_d.clear()
   CALL g_bgeb2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF abgi170_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bgeb004,bgebownid,bgebowndp,bgebcrtid,bgebcrtdp,bgebcrtdt,bgebmodid, 
             bgebmoddt,bgebstus ,t1.ooag011 FROM bgeb_t",   
                     " INNER JOIN bgea_t ON bgeaent = " ||g_enterprise|| " AND bgea001 = bgeb001 ",
                     " AND bgea002 = bgeb002 ",
                     " AND bgea003 = bgeb003 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgebmodid  ",
 
                     " WHERE bgebent=? AND bgeb001=? AND bgeb002=? AND bgeb003=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bgeb_t.bgeb004"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgi170_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgi170_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgeb_d[l_ac].bgeb004, 
          g_bgeb_d[l_ac].bgebownid,g_bgeb_d[l_ac].bgebowndp,g_bgeb_d[l_ac].bgebcrtid,g_bgeb_d[l_ac].bgebcrtdp, 
          g_bgeb_d[l_ac].bgebcrtdt,g_bgeb_d[l_ac].bgebmodid,g_bgeb_d[l_ac].bgebmoddt,g_bgeb_d[l_ac].bgebstus, 
          g_bgeb_d[l_ac].bgebmodid_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL s_desc_get_item_desc(g_bgeb_d[l_ac].bgeb004) RETURNING g_bgeb_d[l_ac].bgasl003_desc,g_bgeb_d[l_ac].bgasl004_desc
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
   IF abgi170_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT bgec004,bgec006,bgecownid,bgecowndp,bgeccrtid,bgeccrtdp,bgeccrtdt, 
             bgecmodid,bgecmoddt,bgecstus ,t2.ooag011 FROM bgec_t",   
                     " INNER JOIN  bgea_t ON bgeaent = " ||g_enterprise|| " AND bgea001 = bgec001 ",
                     " AND bgea002 = bgec002 ",
                     " AND bgea003 = bgec003 ",
 
                     "",
                     
                                    " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=bgecmodid  ",
 
                     " WHERE bgecent=? AND bgec001=? AND bgec002=? AND bgec003=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY bgec_t.bgec004"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgi170_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR abgi170_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgeb2_d[l_ac].bgec004, 
          g_bgeb2_d[l_ac].bgec006,g_bgeb2_d[l_ac].bgecownid,g_bgeb2_d[l_ac].bgecowndp,g_bgeb2_d[l_ac].bgeccrtid, 
          g_bgeb2_d[l_ac].bgeccrtdp,g_bgeb2_d[l_ac].bgeccrtdt,g_bgeb2_d[l_ac].bgecmodid,g_bgeb2_d[l_ac].bgecmoddt, 
          g_bgeb2_d[l_ac].bgecstus,g_bgeb2_d[l_ac].bgecmodid_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         LET g_bgeb2_d[l_ac].bgec004_desc = s_desc_get_department_desc(g_bgeb2_d[l_ac].bgec004)
         #161223-00027#1 --s add
         #預帶ooef024
         LET g_bgeb2_d[l_ac].l_bgec005 = ''
         SELECT ooef024 INTO g_bgeb2_d[l_ac].l_bgec005
           FROM ooef_t 
          WHERE ooefent = g_enterprise AND ooef001 = g_bgeb2_d[l_ac].bgec004 AND ooefstus = 'Y'
         LET g_bgeb2_d[l_ac].bgec005_desc = s_desc_get_trading_partner_abbr_desc(g_bgeb2_d[l_ac].l_bgec005)
         DISPLAY BY NAME g_bgeb2_d[l_ac].l_bgec005,g_bgeb2_d[l_ac].bgec005_desc                       
         #161223-00027#1 --e add         
         #LET g_bgeb2_d[l_ac].bgec005_desc = abgi170_bgec005_ref(g_bgeb2_d[l_ac].bgec005)  #161223-00027#1 mark 取pmaal004簡稱
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
   
   CALL g_bgeb_d.deleteElement(g_bgeb_d.getLength())
   CALL g_bgeb2_d.deleteElement(g_bgeb2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE abgi170_pb
   FREE abgi170_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgeb_d.getLength()
      LET g_bgeb_d_mask_o[l_ac].* =  g_bgeb_d[l_ac].*
      CALL abgi170_bgeb_t_mask()
      LET g_bgeb_d_mask_n[l_ac].* =  g_bgeb_d[l_ac].*
   END FOR
   
   LET g_bgeb2_d_mask_o.* =  g_bgeb2_d.*
   FOR l_ac = 1 TO g_bgeb2_d.getLength()
      LET g_bgeb2_d_mask_o[l_ac].* =  g_bgeb2_d[l_ac].*
      CALL abgi170_bgec_t_mask()
      LET g_bgeb2_d_mask_n[l_ac].* =  g_bgeb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="abgi170.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgi170_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM bgeb_t
       WHERE bgebent = g_enterprise AND
         bgeb001 = ps_keys_bak[1] AND bgeb002 = ps_keys_bak[2] AND bgeb003 = ps_keys_bak[3] AND bgeb004 = ps_keys_bak[4]
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
         CALL g_bgeb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM bgec_t
       WHERE bgecent = g_enterprise AND
             bgec001 = ps_keys_bak[1] AND bgec002 = ps_keys_bak[2] AND bgec003 = ps_keys_bak[3] AND bgec004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_bgeb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgi170_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO bgeb_t
                  (bgebent,
                   bgeb001,bgeb002,bgeb003,
                   bgeb004
                   ,bgebownid,bgebowndp,bgebcrtid,bgebcrtdp,bgebcrtdt,bgebmodid,bgebmoddt,bgebstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_bgeb_d[g_detail_idx].bgebownid,g_bgeb_d[g_detail_idx].bgebowndp,g_bgeb_d[g_detail_idx].bgebcrtid, 
                       g_bgeb_d[g_detail_idx].bgebcrtdp,g_bgeb_d[g_detail_idx].bgebcrtdt,g_bgeb_d[g_detail_idx].bgebmodid, 
                       g_bgeb_d[g_detail_idx].bgebmoddt,g_bgeb_d[g_detail_idx].bgebstus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_bgeb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO bgec_t
                  (bgecent,
                   bgec001,bgec002,bgec003,
                   bgec004
                   ,bgec006,bgecownid,bgecowndp,bgeccrtid,bgeccrtdp,bgeccrtdt,bgecmodid,bgecmoddt,bgecstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_bgeb2_d[g_detail_idx].bgec006,g_bgeb2_d[g_detail_idx].bgecownid,g_bgeb2_d[g_detail_idx].bgecowndp, 
                       g_bgeb2_d[g_detail_idx].bgeccrtid,g_bgeb2_d[g_detail_idx].bgeccrtdp,g_bgeb2_d[g_detail_idx].bgeccrtdt, 
                       g_bgeb2_d[g_detail_idx].bgecmodid,g_bgeb2_d[g_detail_idx].bgecmoddt,g_bgeb2_d[g_detail_idx].bgecstus) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_bgeb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgi170_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bgeb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL abgi170_bgeb_t_mask_restore('restore_mask_o')
               
      UPDATE bgeb_t 
         SET (bgeb001,bgeb002,bgeb003,
              bgeb004
              ,bgebownid,bgebowndp,bgebcrtid,bgebcrtdp,bgebcrtdt,bgebmodid,bgebmoddt,bgebstus) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_bgeb_d[g_detail_idx].bgebownid,g_bgeb_d[g_detail_idx].bgebowndp,g_bgeb_d[g_detail_idx].bgebcrtid, 
                  g_bgeb_d[g_detail_idx].bgebcrtdp,g_bgeb_d[g_detail_idx].bgebcrtdt,g_bgeb_d[g_detail_idx].bgebmodid, 
                  g_bgeb_d[g_detail_idx].bgebmoddt,g_bgeb_d[g_detail_idx].bgebstus) 
         WHERE bgebent = g_enterprise AND bgeb001 = ps_keys_bak[1] AND bgeb002 = ps_keys_bak[2] AND bgeb003 = ps_keys_bak[3] AND bgeb004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgeb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgeb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abgi170_bgeb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "bgec_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL abgi170_bgec_t_mask_restore('restore_mask_o')
               
      UPDATE bgec_t 
         SET (bgec001,bgec002,bgec003,
              bgec004
              ,bgec006,bgecownid,bgecowndp,bgeccrtid,bgeccrtdp,bgeccrtdt,bgecmodid,bgecmoddt,bgecstus) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_bgeb2_d[g_detail_idx].bgec006,g_bgeb2_d[g_detail_idx].bgecownid,g_bgeb2_d[g_detail_idx].bgecowndp, 
                  g_bgeb2_d[g_detail_idx].bgeccrtid,g_bgeb2_d[g_detail_idx].bgeccrtdp,g_bgeb2_d[g_detail_idx].bgeccrtdt, 
                  g_bgeb2_d[g_detail_idx].bgecmodid,g_bgeb2_d[g_detail_idx].bgecmoddt,g_bgeb2_d[g_detail_idx].bgecstus)  
 
         WHERE bgecent = g_enterprise AND bgec001 = ps_keys_bak[1] AND bgec002 = ps_keys_bak[2] AND bgec003 = ps_keys_bak[3] AND bgec004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgec_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "bgec_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL abgi170_bgec_t_mask_restore('restore_mask_n')
 
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
 
{<section id="abgi170.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION abgi170_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="abgi170.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgi170_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abgi170.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgi170_lock_b(ps_table,ps_page)
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
   #CALL abgi170_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "bgeb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN abgi170_bcl USING g_enterprise,
                                       g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgeb_d[g_detail_idx].bgeb004  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abgi170_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "bgec_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN abgi170_bcl2 USING g_enterprise,
                                             g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgeb2_d[g_detail_idx].bgec004 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "abgi170_bcl2:",SQLERRMESSAGE 
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
 
{<section id="abgi170.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgi170_unlock_b(ps_table,ps_page)
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
      CLOSE abgi170_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE abgi170_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="abgi170.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgi170_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgea001,bgea002,bgea003",TRUE)
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
 
{<section id="abgi170.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgi170_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgea001,bgea002,bgea003",FALSE)
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
 
{<section id="abgi170.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgi170_set_entry_b(p_cmd)
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
 
{<section id="abgi170.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgi170_set_no_entry_b(p_cmd)
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
 
{<section id="abgi170.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgi170_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgi170_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgi170_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgi170_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgi170_default_search()
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
      LET ls_wc = ls_wc, " bgea001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bgea002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bgea003 = '", g_argv[03], "' AND "
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
               WHEN la_wc[li_idx].tableid = "bgea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bgeb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "bgec_t" 
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
 
{<section id="abgi170.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION abgi170_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bgea_m.bgea001 IS NULL
      OR g_bgea_m.bgea002 IS NULL      OR g_bgea_m.bgea003 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abgi170_cl USING g_enterprise,g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003
   IF STATUS THEN
      CLOSE abgi170_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgi170_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abgi170_master_referesh USING g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgea_m.bgea001, 
       g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp,g_bgea_m.bgeacrtid, 
       g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt,g_bgea_m.bgea009, 
       g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
       g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea025, 
       g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041, 
       g_bgea_m.bgea042,g_bgea_m.bgea043,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp_desc,g_bgea_m.bgeacrtid_desc, 
       g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeamodid_desc
   
 
   #檢查是否允許此動作
   IF NOT abgi170_action_chk() THEN
      CLOSE abgi170_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc,g_bgea_m.bgea002,g_bgea_m.bgea002_desc,g_bgea_m.bgea003, 
       g_bgea_m.l_bgas005,g_bgea_m.l_bgasl003,g_bgea_m.l_bgasl004,g_bgea_m.l_bgas009,g_bgea_m.l_bgas009_desc, 
       g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp,g_bgea_m.bgeaowndp_desc, 
       g_bgea_m.bgeacrtid,g_bgea_m.bgeacrtid_desc,g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeacrtdt, 
       g_bgea_m.bgeamodid,g_bgea_m.bgeamodid_desc,g_bgea_m.bgeamoddt,g_bgea_m.bgea009,g_bgea_m.bgea009_desc, 
       g_bgea_m.bgea010,g_bgea_m.bgea010_desc,g_bgea_m.bgea011,g_bgea_m.bgea011_desc,g_bgea_m.bgea012, 
       g_bgea_m.bgea012_desc,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004,g_bgea_m.bgea004_desc, 
       g_bgea_m.bgea015,g_bgea_m.bgea015_desc,g_bgea_m.bgea016,g_bgea_m.bgea016_desc,g_bgea_m.bgea017, 
       g_bgea_m.bgea017_desc,g_bgea_m.bgea018,g_bgea_m.bgea018_desc,g_bgea_m.bgea019,g_bgea_m.bgea020, 
       g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005,g_bgea_m.bgea005_desc, 
       g_bgea_m.bgea025,g_bgea_m.bgea025_desc,g_bgea_m.bgea026,g_bgea_m.bgea026_desc,g_bgea_m.bgea027, 
       g_bgea_m.bgea027_desc,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030,g_bgea_m.bgea031,g_bgea_m.bgea031_desc, 
       g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006, 
       g_bgea_m.bgea006_desc,g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040, 
       g_bgea_m.bgea041,g_bgea_m.bgea042,g_bgea_m.bgea043
 
   CASE g_bgea_m.bgeastus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bgea_m.bgeastus
            
            WHEN "Y"
               HIDE OPTION "active"
            WHEN "N"
               HIDE OPTION "inactive"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
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
      g_bgea_m.bgeastus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgi170_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_bgea_m.bgeamodid = g_user
   LET g_bgea_m.bgeamoddt = cl_get_current()
   LET g_bgea_m.bgeastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bgea_t 
      SET (bgeastus,bgeamodid,bgeamoddt) 
        = (g_bgea_m.bgeastus,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt)     
    WHERE bgeaent = g_enterprise AND bgea001 = g_bgea_m.bgea001
      AND bgea002 = g_bgea_m.bgea002      AND bgea003 = g_bgea_m.bgea003
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE abgi170_master_referesh USING g_bgea_m.bgea001,g_bgea_m.bgea002,g_bgea_m.bgea003 INTO g_bgea_m.bgea001, 
          g_bgea_m.bgea002,g_bgea_m.bgea003,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaowndp, 
          g_bgea_m.bgeacrtid,g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt, 
          g_bgea_m.bgea009,g_bgea_m.bgea010,g_bgea_m.bgea011,g_bgea_m.bgea012,g_bgea_m.bgea013,g_bgea_m.bgea014, 
          g_bgea_m.bgea004,g_bgea_m.bgea015,g_bgea_m.bgea016,g_bgea_m.bgea017,g_bgea_m.bgea018,g_bgea_m.bgea019, 
          g_bgea_m.bgea020,g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005, 
          g_bgea_m.bgea025,g_bgea_m.bgea026,g_bgea_m.bgea027,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030, 
          g_bgea_m.bgea031,g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034,g_bgea_m.bgea035,g_bgea_m.bgea044, 
          g_bgea_m.bgea006,g_bgea_m.bgea036,g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040, 
          g_bgea_m.bgea041,g_bgea_m.bgea042,g_bgea_m.bgea043,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp_desc, 
          g_bgea_m.bgeacrtid_desc,g_bgea_m.bgeacrtdp_desc,g_bgea_m.bgeamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc,g_bgea_m.bgea002,g_bgea_m.bgea002_desc, 
          g_bgea_m.bgea003,g_bgea_m.l_bgas005,g_bgea_m.l_bgasl003,g_bgea_m.l_bgasl004,g_bgea_m.l_bgas009, 
          g_bgea_m.l_bgas009_desc,g_bgea_m.bgeastus,g_bgea_m.bgeaownid,g_bgea_m.bgeaownid_desc,g_bgea_m.bgeaowndp, 
          g_bgea_m.bgeaowndp_desc,g_bgea_m.bgeacrtid,g_bgea_m.bgeacrtid_desc,g_bgea_m.bgeacrtdp,g_bgea_m.bgeacrtdp_desc, 
          g_bgea_m.bgeacrtdt,g_bgea_m.bgeamodid,g_bgea_m.bgeamodid_desc,g_bgea_m.bgeamoddt,g_bgea_m.bgea009, 
          g_bgea_m.bgea009_desc,g_bgea_m.bgea010,g_bgea_m.bgea010_desc,g_bgea_m.bgea011,g_bgea_m.bgea011_desc, 
          g_bgea_m.bgea012,g_bgea_m.bgea012_desc,g_bgea_m.bgea013,g_bgea_m.bgea014,g_bgea_m.bgea004, 
          g_bgea_m.bgea004_desc,g_bgea_m.bgea015,g_bgea_m.bgea015_desc,g_bgea_m.bgea016,g_bgea_m.bgea016_desc, 
          g_bgea_m.bgea017,g_bgea_m.bgea017_desc,g_bgea_m.bgea018,g_bgea_m.bgea018_desc,g_bgea_m.bgea019, 
          g_bgea_m.bgea020,g_bgea_m.bgea021,g_bgea_m.bgea022,g_bgea_m.bgea023,g_bgea_m.bgea024,g_bgea_m.bgea005, 
          g_bgea_m.bgea005_desc,g_bgea_m.bgea025,g_bgea_m.bgea025_desc,g_bgea_m.bgea026,g_bgea_m.bgea026_desc, 
          g_bgea_m.bgea027,g_bgea_m.bgea027_desc,g_bgea_m.bgea028,g_bgea_m.bgea029,g_bgea_m.bgea030, 
          g_bgea_m.bgea031,g_bgea_m.bgea031_desc,g_bgea_m.bgea032,g_bgea_m.bgea033,g_bgea_m.bgea034, 
          g_bgea_m.bgea035,g_bgea_m.bgea044,g_bgea_m.bgea006,g_bgea_m.bgea006_desc,g_bgea_m.bgea036, 
          g_bgea_m.bgea037,g_bgea_m.bgea038,g_bgea_m.bgea039,g_bgea_m.bgea040,g_bgea_m.bgea041,g_bgea_m.bgea042, 
          g_bgea_m.bgea043
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF SQLCA.sqlcode THEN
   ELSE
      #單身狀態碼更新
      #對應料號
      UPDATE bgeb_t 
         SET (bgebstus,bgebmodid,bgebmoddt) 
            = (g_bgea_m.bgeastus,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt) 
       WHERE bgebent = g_enterprise 
         AND bgeb001 = g_bgea_m.bgea001 
         AND bgeb002 = g_bgea_m.bgea002 
         AND bgeb003 = g_bgea_m.bgea003 
         
      #內採組織訊息
      UPDATE bgec_t 
         SET (bgecstus,bgecmodid,bgecmoddt)
           = (g_bgea_m.bgeastus,g_bgea_m.bgeamodid,g_bgea_m.bgeamoddt)
       WHERE bgecent = g_enterprise 
         AND bgec001 = g_bgea_m.bgea001
         AND bgec002 = g_bgea_m.bgea002
         AND bgec003 = g_bgea_m.bgea003
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abgi170_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgi170_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi170.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgi170_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_bgeb_d.getLength() THEN
         LET g_detail_idx = g_bgeb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgeb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgeb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bgeb2_d.getLength() THEN
         LET g_detail_idx = g_bgeb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgeb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgeb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgi170_b_fill2(pi_idx)
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
   
   CALL abgi170_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgi170_fill_chk(ps_idx)
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
 
{<section id="abgi170.status_show" >}
PRIVATE FUNCTION abgi170_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgi170.mask_functions" >}
&include "erp/abg/abgi170_mask.4gl"
 
{</section>}
 
{<section id="abgi170.signature" >}
   
 
{</section>}
 
{<section id="abgi170.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgi170_set_pk_array()
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
   LET g_pk_array[1].values = g_bgea_m.bgea001
   LET g_pk_array[1].column = 'bgea001'
   LET g_pk_array[2].values = g_bgea_m.bgea002
   LET g_pk_array[2].column = 'bgea002'
   LET g_pk_array[3].values = g_bgea_m.bgea003
   LET g_pk_array[3].column = 'bgea003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi170.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="abgi170.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgi170_msgcentre_notify(lc_state)
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
   CALL abgi170_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgi170.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION abgi170_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="abgi170.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL abgi170_bgea003_ref()
# Return code....: bgas005   料件類別
#                : bgasl003  品名
#                : bgasl004  規格
# Date & Author..: 161014 By 06821
# Modify.........: #161129-00019#3  產品分類說明
################################################################################
PRIVATE FUNCTION abgi170_bgea003_ref()
   
   IF cl_null(g_bgea_m.bgea003) THEN
      RETURN
   END IF
   
   LET g_bgea_m.l_bgas005  = ''
   LET g_bgea_m.l_bgasl003 = ''
   LET g_bgea_m.l_bgasl004 = ''
   LET g_bgea_m.l_bgas009 = ''   #161129-00019#3   add
   LET g_bgea_m.l_bgas009_desc = ''   #161129-00019#3   add
   
   SELECT bgas005,bgasl003,bgasl004 INTO g_bgea_m.l_bgas005,g_bgea_m.l_bgasl003,g_bgea_m.l_bgasl004
     FROM bgasl_t 
     LEFT OUTER JOIN bgas_t ON bgasent = bgaslent AND bgas001 = bgasl001
    WHERE bgaslent = g_enterprise AND bgasl001 = g_bgea_m.bgea003 AND bgasl002 = g_dlang
    
   #161129-00019#3   add---s
   SELECT DISTINCT bgas009 INTO g_bgea_m.l_bgas009
     FROM bgas_t
    WHERE bgasent = g_enterprise AND bgas001 = g_bgea_m.bgea003
      
   LET g_bgea_m.l_bgas009_desc =  s_desc_get_rtaxl003_desc(g_bgea_m.l_bgas009)
   #161129-00019#3   add---e
   
   DISPLAY BY NAME g_bgea_m.l_bgas005,g_bgea_m.l_bgasl003,g_bgea_m.l_bgasl004,
                   g_bgea_m.l_bgas009,g_bgea_m.l_bgas009_desc   #161129-00019#3   add
END FUNCTION

################################################################################
# Descriptions...: 預算組織檢核
# Memo...........:
# Usage..........: CALL abgi170_bgea002_chk(p_bgea002)
# Date & Author..: 161014 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi170_bgea002_chk(p_bgea002)
   DEFINE p_bgea002   LIKE bgea_t.bgea002
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_ooef      RECORD
                      ooef205  LIKE ooef_t.ooef205,
                      ooefstus LIKE ooef_t.ooefstus
                      END RECORD
                      
   LET r_success = TRUE
   LET r_errno   = ''
   INITIALIZE l_ooef.* TO NULL
   SELECT ooef205,ooefstus 
     INTO l_ooef.*
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_bgea002
      
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno = 'aoo-00094'
      WHEN l_ooef.ooefstus <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'apm-00249'
      WHEN l_ooef.ooef205 <> 'Y'
         LET r_success = FALSE
         LET r_errno = 'axm-00159'
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 據點對應交易對象簡稱
# Memo...........:
# Usage..........: CALL abgi170_bgec005_ref(p_bgec005)
# Date & Author..: 161019 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi170_bgec005_ref(p_bgec005)
#161223-00027#1 --s mark
DEFINE p_bgec005  LIKE bgec_t.bgec005
#DEFINE r_bgapl005 LIKE bgapl_t.bgapl005  #交易對象簡稱
#
#   LET r_bgapl005 = ''
#   IF cl_null(p_bgec005) THEN RETURN r_bgapl005 END IF   
#
#   SELECT bgapl005 INTO r_bgapl005
#     FROM bgapl_t
#    WHERE bgaplent = g_enterprise
#      AND bgapl001 = p_bgec005
#      AND bgapl002 = g_dlang
#
#   RETURN r_bgapl005
#161223-00027#1 --e mark
END FUNCTION

################################################################################
# Descriptions...: 交易對象說明
# Memo...........:
# Usage..........: CALL abgi170_bgap001_ref(p_bgapl001)
#                  RETURNING r_bgapl005
# Date & Author..: 161108 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi170_bgap001_ref(p_bgapl001)
DEFINE p_bgapl001         LIKE bgapl_t.bgapl001
DEFINE r_bgapl005         LIKE bgapl_t.bgapl005 
   
   WHENEVER ERROR CONTINUE   
   
   SELECT bgapl005 INTO r_bgapl005 FROM bgapl_t
    WHERE bgaplent = g_enterprise
      AND bgapl001 = p_bgapl001
      AND bgapl002 = g_dlang
   
   RETURN r_bgapl005
END FUNCTION

 
{</section>}
 
