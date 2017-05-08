#該程式未解開Section, 採用最新樣板產出!
{<section id="asrt350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2014-06-29 10:54:22), PR版次:0013(2016-12-19 14:58:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000246
#+ Filename...: asrt350
#+ Description: 重覆性生產盤點分攤維護作業
#+ Creator....: 02587(2014-04-04 10:32:09)
#+ Modifier...: 01258 -SD/PR- 01996
 
{</section>}
 
{<section id="asrt350.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00001#4   2015/11/25   By 06948   增加作廢時詢問「是否作廢」
#151224-00025#4   2015/12/28   By yihsuan 手動輸入特徵碼同步新增inam_t[料件產品特徵明細檔]
#160314-00009#14  2016/03/29   By xujing  产品特征自动开窗增加参数判断
#160318-00025#22  2016/04/21   BY 07900   校验代码重复错误讯息的修改
#160512-00016#14  2016/05/27   By ming    s_asft300_02_bom增加參數 
#160512-00016#27  2016/05/31   By 02295  保税否栏位給值N
#160613-00038#1   2016/06/14   By 06821   s_aooi200_chk_slip傳入值(原寫死程式代號)，改用g_prog處理
#160809-00004#1   2016/08/09   By xianghui BPM按钮和一般的审核按钮不需同时显示
#160816-00068#3   2016/08/17   By earl     調整transaction
#161124-00048#12 2016/12/13 By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
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
PRIVATE type type_g_srba_m        RECORD
       srbasite LIKE srba_t.srbasite, 
   srbadocno LIKE srba_t.srbadocno, 
   oobxl003 LIKE type_t.chr80, 
   srbadocdt LIKE srba_t.srbadocdt, 
   srba001 LIKE srba_t.srba001, 
   srba002 LIKE srba_t.srba002, 
   srba003 LIKE srba_t.srba003, 
   srba003_desc LIKE type_t.chr80, 
   srba004 LIKE srba_t.srba004, 
   srba005 LIKE srba_t.srba005, 
   srba005_desc LIKE type_t.chr80, 
   srba006 LIKE srba_t.srba006, 
   srba006_desc LIKE type_t.chr80, 
   srbastus LIKE srba_t.srbastus, 
   srbaownid LIKE srba_t.srbaownid, 
   srbaownid_desc LIKE type_t.chr80, 
   srbaowndp LIKE srba_t.srbaowndp, 
   srbaowndp_desc LIKE type_t.chr80, 
   srbacrtid LIKE srba_t.srbacrtid, 
   srbacrtid_desc LIKE type_t.chr80, 
   srbacrtdp LIKE srba_t.srbacrtdp, 
   srbacrtdp_desc LIKE type_t.chr80, 
   srbacrtdt LIKE srba_t.srbacrtdt, 
   srbamodid LIKE srba_t.srbamodid, 
   srbamodid_desc LIKE type_t.chr80, 
   srbamoddt LIKE srba_t.srbamoddt, 
   srbacnfid LIKE srba_t.srbacnfid, 
   srbacnfid_desc LIKE type_t.chr80, 
   srbacnfdt LIKE srba_t.srbacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_srbb_d        RECORD
       srbbseq LIKE srbb_t.srbbseq, 
   srbb001 LIKE srbb_t.srbb001, 
   srbb001_desc LIKE type_t.chr500, 
   srbb001_desc_1 LIKE type_t.chr500, 
   srbb002 LIKE srbb_t.srbb002, 
   srbb005 LIKE srbb_t.srbb005, 
   srbb006 LIKE srbb_t.srbb006, 
   srbb007 LIKE srbb_t.srbb007, 
   srbb007_desc LIKE type_t.chr500, 
   srbb008 LIKE srbb_t.srbb008, 
   srbb009 LIKE srbb_t.srbb009, 
   l_num LIKE type_t.num20_6, 
   l_num1 LIKE type_t.num20_6, 
   srbb010 LIKE srbb_t.srbb010, 
   srbb010_desc LIKE type_t.chr500, 
   srbb011 LIKE srbb_t.srbb011, 
   srbb012 LIKE srbb_t.srbb012, 
   l_num2 LIKE type_t.num20_6, 
   l_num3 LIKE type_t.num20_6, 
   srbbsite LIKE srbb_t.srbbsite, 
   srbb003 LIKE srbb_t.srbb003, 
   srbb004 LIKE srbb_t.srbb004
       END RECORD
PRIVATE TYPE type_g_srbb3_d RECORD
       srbcseq LIKE srbc_t.srbcseq, 
   srbcseq1 LIKE srbc_t.srbcseq1, 
   l_srbb001 LIKE type_t.chr500, 
   l_srbb001_desc LIKE type_t.chr500, 
   l_srbb001_desc_1 LIKE type_t.chr500, 
   l_srbb002 LIKE type_t.chr500, 
   l_srbb005 LIKE type_t.chr30, 
   l_srbb006 LIKE type_t.chr500, 
   srbc001 LIKE srbc_t.srbc001, 
   srbc001_desc LIKE type_t.chr500, 
   srbc001_desc_1 LIKE type_t.chr500, 
   srbc002 LIKE srbc_t.srbc002, 
   srbc003 LIKE srbc_t.srbc003, 
   srbc007 LIKE srbc_t.srbc007, 
   srbc004 LIKE srbc_t.srbc004, 
   srbc005 LIKE srbc_t.srbc005, 
   srbc006 LIKE srbc_t.srbc006, 
   srbcsite LIKE srbc_t.srbcsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_srbadocno LIKE srba_t.srbadocno,
      b_srbadocdt LIKE srba_t.srbadocdt,
      b_srba001 LIKE srba_t.srba001,
      b_srba002 LIKE srba_t.srba002,
      b_srba003 LIKE srba_t.srba003,
   b_srba003_desc LIKE type_t.chr80,
      b_srba004 LIKE srba_t.srba004,
      b_srba005 LIKE srba_t.srba005,
   b_srba005_desc LIKE type_t.chr80,
      b_srba006 LIKE srba_t.srba006,
   b_srba006_desc LIKE type_t.chr80,
      b_srbasite LIKE srba_t.srbasite
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_srbb2_d RECORD
        inaoseq  LIKE inao_t.inaoseq,
        inaoseq1 LIKE inao_t.inaoseq1,
        inaoseq2 LIKE inao_t.inaoseq2,
        inao001  LIKE inao_t.inao001,
        inao001_desc LIKE imaal_t.imaal003,
        inao001_desc_1  LIKE imaal_t.imaal004,
        inao008  LIKE inao_t.inao008,
        inao009  LIKE inao_t.inao009,
        inao010  LIKE inao_t.inao010,
        inao012  LIKE inao_t.inao012
        END RECORD
TYPE type_g_srbb4_d RECORD
        inaoseq_4  LIKE inao_t.inaoseq,
        inaoseq1_4 LIKE inao_t.inaoseq1,
        inaoseq2_4 LIKE inao_t.inaoseq2,
        inao001_4  LIKE inao_t.inao001,
        inao001_4_desc LIKE imaal_t.imaal003,
        inao001_4_desc_1  LIKE imaal_t.imaal004,
        inao008_4  LIKE inao_t.inao008,
        inao009_4  LIKE inao_t.inao009,
        inao010_4  LIKE inao_t.inao010,
        inao012_4  LIKE inao_t.inao012
        END RECORD

DEFINE g_srbb2_d             DYNAMIC ARRAY OF type_g_srbb2_d
DEFINE g_srbb2_d_t           type_g_srbb2_d
DEFINE g_srbb4_d             DYNAMIC ARRAY OF type_g_srbb4_d
DEFINE g_srbb4_d_t           type_g_srbb4_d
DEFINE g_wc2_table3          STRING
DEFINE g_wc2_table4          STRING

DEFINE g_flag1               LIKE type_t.chr1
DEFINE g_flag2               LIKE type_t.chr1
DEFINE g_flag3               LIKE type_t.chr1
DEFINE g_flag4               LIKE type_t.chr1
DEFINE g_flag5               LIKE type_t.chr1
DEFINE g_srab000             LIKE srab_t.srab000
DEFINE g_srab002             LIKE srab_t.srab002
DEFINE g_srab003             LIKE srab_t.srab003


#end add-point
       
#模組變數(Module Variables)
DEFINE g_srba_m          type_g_srba_m
DEFINE g_srba_m_t        type_g_srba_m
DEFINE g_srba_m_o        type_g_srba_m
DEFINE g_srba_m_mask_o   type_g_srba_m #轉換遮罩前資料
DEFINE g_srba_m_mask_n   type_g_srba_m #轉換遮罩後資料
 
   DEFINE g_srbadocno_t LIKE srba_t.srbadocno
 
 
DEFINE g_srbb_d          DYNAMIC ARRAY OF type_g_srbb_d
DEFINE g_srbb_d_t        type_g_srbb_d
DEFINE g_srbb_d_o        type_g_srbb_d
DEFINE g_srbb_d_mask_o   DYNAMIC ARRAY OF type_g_srbb_d #轉換遮罩前資料
DEFINE g_srbb_d_mask_n   DYNAMIC ARRAY OF type_g_srbb_d #轉換遮罩後資料
DEFINE g_srbb3_d          DYNAMIC ARRAY OF type_g_srbb3_d
DEFINE g_srbb3_d_t        type_g_srbb3_d
DEFINE g_srbb3_d_o        type_g_srbb3_d
DEFINE g_srbb3_d_mask_o   DYNAMIC ARRAY OF type_g_srbb3_d #轉換遮罩前資料
DEFINE g_srbb3_d_mask_n   DYNAMIC ARRAY OF type_g_srbb3_d #轉換遮罩後資料
 
 
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
 
{<section id="asrt350.main" >}
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
   CALL cl_ap_init("asr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT srbasite,srbadocno,'',srbadocdt,srba001,srba002,srba003,'',srba004,srba005, 
       '',srba006,'',srbastus,srbaownid,'',srbaowndp,'',srbacrtid,'',srbacrtdp,'',srbacrtdt,srbamodid, 
       '',srbamoddt,srbacnfid,'',srbacnfdt", 
                      " FROM srba_t",
                      " WHERE srbaent= ? AND srbadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt350_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.srbasite,t0.srbadocno,t0.srbadocdt,t0.srba001,t0.srba002,t0.srba003, 
       t0.srba004,t0.srba005,t0.srba006,t0.srbastus,t0.srbaownid,t0.srbaowndp,t0.srbacrtid,t0.srbacrtdp, 
       t0.srbacrtdt,t0.srbamodid,t0.srbamoddt,t0.srbacnfid,t0.srbacnfdt,t1.srza002 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM srba_t t0",
                              " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srbasite AND t1.srza001=t0.srba003  ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.srbaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.srbaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.srbacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.srbacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.srbamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.srbacnfid  ",
 
               " WHERE t0.srbaent = " ||g_enterprise|| " AND t0.srbadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asrt350_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asrt350 WITH FORM cl_ap_formpath("asr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asrt350_init()   
 
      #進入選單 Menu (="N")
      CALL asrt350_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asrt350
      
   END IF 
   
   CLOSE asrt350_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asrt350.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asrt350_init()
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
      CALL cl_set_combo_scc_part('srbastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('srba004','5401') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_srba004','5401') 
   LET g_flag5 = 'N'
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028')  = 'N' THEN
      CALL cl_set_comp_visible("srbb010,srbb010_desc,srbb011,srbb012,l_num2,l_num3,srbc005",FALSE)
   END IF
   #end add-point
   
   #初始化搜尋條件
   CALL asrt350_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="asrt350.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION asrt350_ui_dialog()
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
            CALL asrt350_insert()
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
         INITIALIZE g_srba_m.* TO NULL
         CALL g_srbb_d.clear()
         CALL g_srbb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asrt350_init()
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
               
               CALL asrt350_fetch('') # reload data
               LET l_ac = 1
               CALL asrt350_ui_detailshow() #Setting the current row 
         
               CALL asrt350_idx_chk()
               #NEXT FIELD srbbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_srbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt350_idx_chk()
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
               CALL asrt350_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_srbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt350_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 2
               #顯示單身筆數
               CALL asrt350_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_srbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL asrt350_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               CALL asrt350_idx_chk()
               LET g_current_page = 2

         END DISPLAY
         
         DISPLAY ARRAY g_srbb4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL asrt350_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               CALL asrt350_idx_chk()
               LET g_current_page = 4

         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL asrt350_browser_fill("")
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
               CALL asrt350_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL asrt350_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL asrt350_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL asrt350_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL asrt350_set_act_visible()   
            CALL asrt350_set_act_no_visible()
            IF NOT (g_srba_m.srbadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " srbaent = " ||g_enterprise|| " AND",
                                  " srbadocno = '", g_srba_m.srbadocno, "' "
 
               #填到對應位置
               CALL asrt350_browser_fill("")
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "srba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "srbb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "srbc_t" 
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
               CALL asrt350_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "srba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "srbb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "srbc_t" 
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
                  CALL asrt350_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL asrt350_fetch("F")
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
               CALL asrt350_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL asrt350_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt350_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL asrt350_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt350_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL asrt350_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt350_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL asrt350_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt350_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL asrt350_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt350_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_srbb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_srbb3_d)
                  LET g_export_id[2]   = "s_detail3"
 
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
               NEXT FIELD srbbseq
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
               CALL asrt350_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL asrt350_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL asrt350_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asrt350_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/asr/asrt350_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/asr/asrt350_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL asrt350_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_ft
            LET g_action_choice="gen_ft"
            IF cl_auth_chk_act("gen_ft") THEN
               
               #add-point:ON ACTION gen_ft name="menu.gen_ft"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asrt350_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_srbc
            LET g_action_choice="gen_srbc"
            IF cl_auth_chk_act("gen_srbc") THEN
               
               #add-point:ON ACTION gen_srbc name="menu.gen_srbc"
               CALL asrt350_gen_srbc()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_pd
            LET g_action_choice="gen_pd"
            IF cl_auth_chk_act("gen_pd") THEN
               
               #add-point:ON ACTION gen_pd name="menu.gen_pd"
               
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL asrt350_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asrt350_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asrt350_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_srba_m.srbadocdt)
 
 
 
         
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
 
{<section id="asrt350.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION asrt350_browser_fill(ps_page_action)
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
   CALL g_srbb2_d.clear()
   CALL g_srbb4_d.clear()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT srbadocno ",
                      " FROM srba_t ",
                      " ",
                      " LEFT JOIN srbb_t ON srbbent = srbaent AND srbadocno = srbbdocno ", "  ",
                      #add-point:browser_fill段sql(srbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN srbc_t ON srbcent = srbaent AND srbadocno = srbcdocno", "  ",
                      #add-point:browser_fill段sql(srbc_t1) name="browser_fill.cnt.join.srbc_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE srbaent = " ||g_enterprise|| " AND srbbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("srba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT srbadocno ",
                      " FROM srba_t ", 
                      "  ",
                      "  ",
                      " WHERE srbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("srba_t")
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
      INITIALIZE g_srba_m.* TO NULL
      CALL g_srbb_d.clear()        
      CALL g_srbb3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.srbadocno,t0.srbadocdt,t0.srba001,t0.srba002,t0.srba003,t0.srba004,t0.srba005,t0.srba006,t0.srbasite Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.srbastus,t0.srbadocno,t0.srbadocdt,t0.srba001,t0.srba002,t0.srba003, 
          t0.srba004,t0.srba005,t0.srba006,t0.srbasite,t1.srza002 ,t2.inaa002 ,t3.inab003 ",
                  " FROM srba_t t0",
                  "  ",
                  "  LEFT JOIN srbb_t ON srbbent = srbaent AND srbadocno = srbbdocno ", "  ", 
                  #add-point:browser_fill段sql(srbb_t1) name="browser_fill.join.srbb_t1"
                  
                  #end add-point
                  "  LEFT JOIN srbc_t ON srbcent = srbaent AND srbadocno = srbcdocno", "  ", 
                  #add-point:browser_fill段sql(srbc_t1) name="browser_fill.join.srbc_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srbasite AND t1.srza001=t0.srba003  ",
               " LEFT JOIN inaa_t t2 ON t2.inaaent="||g_enterprise||" AND t2.inaasite=t0.srbasite AND t2.inaa001=t0.srba005  ",
               " LEFT JOIN inab_t t3 ON t3.inabent="||g_enterprise||" AND t3.inabsite=t0.srbasite AND t3.inab001=t0.srba005 AND t3.inab002=t0.srba006  ",
 
                  " WHERE t0.srbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("srba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.srbastus,t0.srbadocno,t0.srbadocdt,t0.srba001,t0.srba002,t0.srba003, 
          t0.srba004,t0.srba005,t0.srba006,t0.srbasite,t1.srza002 ,t2.inaa002 ,t3.inab003 ",
                  " FROM srba_t t0",
                  "  ",
                                 " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srbasite AND t1.srza001=t0.srba003  ",
               " LEFT JOIN inaa_t t2 ON t2.inaaent="||g_enterprise||" AND t2.inaasite=t0.srbasite AND t2.inaa001=t0.srba005  ",
               " LEFT JOIN inab_t t3 ON t3.inabent="||g_enterprise||" AND t3.inabsite=t0.srbasite AND t3.inab001=t0.srba005 AND t3.inab002=t0.srba006  ",
 
                  " WHERE t0.srbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("srba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY srbadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"srba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_srbadocno,g_browser[g_cnt].b_srbadocdt, 
          g_browser[g_cnt].b_srba001,g_browser[g_cnt].b_srba002,g_browser[g_cnt].b_srba003,g_browser[g_cnt].b_srba004, 
          g_browser[g_cnt].b_srba005,g_browser[g_cnt].b_srba006,g_browser[g_cnt].b_srbasite,g_browser[g_cnt].b_srba003_desc, 
          g_browser[g_cnt].b_srba005_desc,g_browser[g_cnt].b_srba006_desc
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
         CALL asrt350_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_srbadocno) THEN
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
 
{<section id="asrt350.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION asrt350_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_srba_m.srbadocno = g_browser[g_current_idx].b_srbadocno   
 
   EXECUTE asrt350_master_referesh USING g_srba_m.srbadocno INTO g_srba_m.srbasite,g_srba_m.srbadocno, 
       g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005, 
       g_srba_m.srba006,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfdt, 
       g_srba_m.srba003_desc,g_srba_m.srbaownid_desc,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid_desc, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbamodid_desc,g_srba_m.srbacnfid_desc
   
   CALL asrt350_srba_t_mask()
   CALL asrt350_show()
      
END FUNCTION
 
{</section>}
 
{<section id="asrt350.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION asrt350_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION asrt350_ui_browser_refresh()
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
      IF g_browser[l_i].b_srbadocno = g_srba_m.srbadocno 
 
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
 
{<section id="asrt350.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION asrt350_construct()
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
   INITIALIZE g_srba_m.* TO NULL
   CALL g_srbb_d.clear()        
   CALL g_srbb3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL g_srbb2_d.clear()
   CALL g_srbb4_d.clear()
   INITIALIZE g_wc2_table3 TO NULL
   INITIALIZE g_wc2_table4 TO NULL
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON srbasite,srbadocno,oobxl003,srbadocdt,srba001,srba002,srba003,srba004, 
          srba005,srba006,srbastus,srbaownid,srbaowndp,srbacrtid,srbacrtdp,srbacrtdt,srbamodid,srbamoddt, 
          srbacnfid,srbacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<srbacrtdt>>----
         AFTER FIELD srbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<srbamoddt>>----
         AFTER FIELD srbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<srbacnfdt>>----
         AFTER FIELD srbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<srbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbasite
            #add-point:BEFORE FIELD srbasite name="construct.b.srbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbasite
            
            #add-point:AFTER FIELD srbasite name="construct.a.srbasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srbasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbasite
            #add-point:ON ACTION controlp INFIELD srbasite name="construct.c.srbasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbadocno
            #add-point:ON ACTION controlp INFIELD srbadocno name="construct.c.srbadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_srbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbadocno  #顯示到畫面上
            NEXT FIELD srbadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbadocno
            #add-point:BEFORE FIELD srbadocno name="construct.b.srbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbadocno
            
            #add-point:AFTER FIELD srbadocno name="construct.a.srbadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oobxl003
            #add-point:BEFORE FIELD oobxl003 name="construct.b.oobxl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oobxl003
            
            #add-point:AFTER FIELD oobxl003 name="construct.a.oobxl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oobxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oobxl003
            #add-point:ON ACTION controlp INFIELD oobxl003 name="construct.c.oobxl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbadocdt
            #add-point:BEFORE FIELD srbadocdt name="construct.b.srbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbadocdt
            
            #add-point:AFTER FIELD srbadocdt name="construct.a.srbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbadocdt
            #add-point:ON ACTION controlp INFIELD srbadocdt name="construct.c.srbadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba001
            #add-point:BEFORE FIELD srba001 name="construct.b.srba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba001
            
            #add-point:AFTER FIELD srba001 name="construct.a.srba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba001
            #add-point:ON ACTION controlp INFIELD srba001 name="construct.c.srba001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba002
            #add-point:BEFORE FIELD srba002 name="construct.b.srba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba002
            
            #add-point:AFTER FIELD srba002 name="construct.a.srba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba002
            #add-point:ON ACTION controlp INFIELD srba002 name="construct.c.srba002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba003
            #add-point:BEFORE FIELD srba003 name="construct.b.srba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba003
            
            #add-point:AFTER FIELD srba003 name="construct.a.srba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba003
            #add-point:ON ACTION controlp INFIELD srba003 name="construct.c.srba003"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_srza001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srba003  #顯示到畫面上
            NEXT FIELD srba003                     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba004
            #add-point:BEFORE FIELD srba004 name="construct.b.srba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba004
            
            #add-point:AFTER FIELD srba004 name="construct.a.srba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba004
            #add-point:ON ACTION controlp INFIELD srba004 name="construct.c.srba004"
            #此段落由子樣板a08產生
#返回原欄位
    


            #END add-point
 
 
         #Ctrlp:construct.c.srba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba005
            #add-point:ON ACTION controlp INFIELD srba005 name="construct.c.srba005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srba005  #顯示到畫面上
            NEXT FIELD srba005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba005
            #add-point:BEFORE FIELD srba005 name="construct.b.srba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba005
            
            #add-point:AFTER FIELD srba005 name="construct.a.srba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba006
            #add-point:ON ACTION controlp INFIELD srba006 name="construct.c.srba006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srba006  #顯示到畫面上
            NEXT FIELD srba006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba006
            #add-point:BEFORE FIELD srba006 name="construct.b.srba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba006
            
            #add-point:AFTER FIELD srba006 name="construct.a.srba006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbastus
            #add-point:BEFORE FIELD srbastus name="construct.b.srbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbastus
            
            #add-point:AFTER FIELD srbastus name="construct.a.srbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbastus
            #add-point:ON ACTION controlp INFIELD srbastus name="construct.c.srbastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbaownid
            #add-point:ON ACTION controlp INFIELD srbaownid name="construct.c.srbaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbaownid  #顯示到畫面上
            NEXT FIELD srbaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbaownid
            #add-point:BEFORE FIELD srbaownid name="construct.b.srbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbaownid
            
            #add-point:AFTER FIELD srbaownid name="construct.a.srbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbaowndp
            #add-point:ON ACTION controlp INFIELD srbaowndp name="construct.c.srbaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbaowndp  #顯示到畫面上
            NEXT FIELD srbaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbaowndp
            #add-point:BEFORE FIELD srbaowndp name="construct.b.srbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbaowndp
            
            #add-point:AFTER FIELD srbaowndp name="construct.a.srbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbacrtid
            #add-point:ON ACTION controlp INFIELD srbacrtid name="construct.c.srbacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbacrtid  #顯示到畫面上
            NEXT FIELD srbacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbacrtid
            #add-point:BEFORE FIELD srbacrtid name="construct.b.srbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbacrtid
            
            #add-point:AFTER FIELD srbacrtid name="construct.a.srbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbacrtdp
            #add-point:ON ACTION controlp INFIELD srbacrtdp name="construct.c.srbacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbacrtdp  #顯示到畫面上
            NEXT FIELD srbacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbacrtdp
            #add-point:BEFORE FIELD srbacrtdp name="construct.b.srbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbacrtdp
            
            #add-point:AFTER FIELD srbacrtdp name="construct.a.srbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbacrtdt
            #add-point:BEFORE FIELD srbacrtdt name="construct.b.srbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbamodid
            #add-point:ON ACTION controlp INFIELD srbamodid name="construct.c.srbamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbamodid  #顯示到畫面上
            NEXT FIELD srbamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbamodid
            #add-point:BEFORE FIELD srbamodid name="construct.b.srbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbamodid
            
            #add-point:AFTER FIELD srbamodid name="construct.a.srbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbamoddt
            #add-point:BEFORE FIELD srbamoddt name="construct.b.srbamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbacnfid
            #add-point:ON ACTION controlp INFIELD srbacnfid name="construct.c.srbacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbacnfid  #顯示到畫面上
            NEXT FIELD srbacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbacnfid
            #add-point:BEFORE FIELD srbacnfid name="construct.b.srbacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbacnfid
            
            #add-point:AFTER FIELD srbacnfid name="construct.a.srbacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbacnfdt
            #add-point:BEFORE FIELD srbacnfdt name="construct.b.srbacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON srbbseq,srbb001,srbb002,srbb005,srbb006,srbb007,srbb008,srbb009,srbb010, 
          srbb011,srbb012,srbbsite,srbb003,srbb004
           FROM s_detail1[1].srbbseq,s_detail1[1].srbb001,s_detail1[1].srbb002,s_detail1[1].srbb005, 
               s_detail1[1].srbb006,s_detail1[1].srbb007,s_detail1[1].srbb008,s_detail1[1].srbb009,s_detail1[1].srbb010, 
               s_detail1[1].srbb011,s_detail1[1].srbb012,s_detail1[1].srbbsite,s_detail1[1].srbb003, 
               s_detail1[1].srbb004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbbseq
            #add-point:BEFORE FIELD srbbseq name="construct.b.page1.srbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbbseq
            
            #add-point:AFTER FIELD srbbseq name="construct.a.page1.srbbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbbseq
            #add-point:ON ACTION controlp INFIELD srbbseq name="construct.c.page1.srbbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb001
            #add-point:ON ACTION controlp INFIELD srbb001 name="construct.c.page1.srbb001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbb001  #顯示到畫面上
            NEXT FIELD srbb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb001
            #add-point:BEFORE FIELD srbb001 name="construct.b.page1.srbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb001
            
            #add-point:AFTER FIELD srbb001 name="construct.a.page1.srbb001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb002
            #add-point:BEFORE FIELD srbb002 name="construct.b.page1.srbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb002
            
            #add-point:AFTER FIELD srbb002 name="construct.a.page1.srbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb002
            #add-point:ON ACTION controlp INFIELD srbb002 name="construct.c.page1.srbb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srbb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb005
            #add-point:ON ACTION controlp INFIELD srbb005 name="construct.c.page1.srbb005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbb005  #顯示到畫面上
            NEXT FIELD srbb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb005
            #add-point:BEFORE FIELD srbb005 name="construct.b.page1.srbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb005
            
            #add-point:AFTER FIELD srbb005 name="construct.a.page1.srbb005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb006
            #add-point:BEFORE FIELD srbb006 name="construct.b.page1.srbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb006
            
            #add-point:AFTER FIELD srbb006 name="construct.a.page1.srbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb006
            #add-point:ON ACTION controlp INFIELD srbb006 name="construct.c.page1.srbb006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srbb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb007
            #add-point:ON ACTION controlp INFIELD srbb007 name="construct.c.page1.srbb007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbb007  #顯示到畫面上
            NEXT FIELD srbb007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb007
            #add-point:BEFORE FIELD srbb007 name="construct.b.page1.srbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb007
            
            #add-point:AFTER FIELD srbb007 name="construct.a.page1.srbb007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb008
            #add-point:BEFORE FIELD srbb008 name="construct.b.page1.srbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb008
            
            #add-point:AFTER FIELD srbb008 name="construct.a.page1.srbb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb008
            #add-point:ON ACTION controlp INFIELD srbb008 name="construct.c.page1.srbb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb009
            #add-point:BEFORE FIELD srbb009 name="construct.b.page1.srbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb009
            
            #add-point:AFTER FIELD srbb009 name="construct.a.page1.srbb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb009
            #add-point:ON ACTION controlp INFIELD srbb009 name="construct.c.page1.srbb009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb010
            #add-point:ON ACTION controlp INFIELD srbb010 name="construct.c.page1.srbb010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbb010  #顯示到畫面上
            NEXT FIELD srbb010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb010
            #add-point:BEFORE FIELD srbb010 name="construct.b.page1.srbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb010
            
            #add-point:AFTER FIELD srbb010 name="construct.a.page1.srbb010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb011
            #add-point:BEFORE FIELD srbb011 name="construct.b.page1.srbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb011
            
            #add-point:AFTER FIELD srbb011 name="construct.a.page1.srbb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb011
            #add-point:ON ACTION controlp INFIELD srbb011 name="construct.c.page1.srbb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb012
            #add-point:BEFORE FIELD srbb012 name="construct.b.page1.srbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb012
            
            #add-point:AFTER FIELD srbb012 name="construct.a.page1.srbb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb012
            #add-point:ON ACTION controlp INFIELD srbb012 name="construct.c.page1.srbb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbbsite
            #add-point:BEFORE FIELD srbbsite name="construct.b.page1.srbbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbbsite
            
            #add-point:AFTER FIELD srbbsite name="construct.a.page1.srbbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbbsite
            #add-point:ON ACTION controlp INFIELD srbbsite name="construct.c.page1.srbbsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb003
            #add-point:BEFORE FIELD srbb003 name="construct.b.page1.srbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb003
            
            #add-point:AFTER FIELD srbb003 name="construct.a.page1.srbb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb003
            #add-point:ON ACTION controlp INFIELD srbb003 name="construct.c.page1.srbb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb004
            #add-point:BEFORE FIELD srbb004 name="construct.b.page1.srbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb004
            
            #add-point:AFTER FIELD srbb004 name="construct.a.page1.srbb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srbb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb004
            #add-point:ON ACTION controlp INFIELD srbb004 name="construct.c.page1.srbb004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON srbcseq,srbcseq1,srbc001,srbc002,srbc003,srbc007,srbc004,srbc005,srbc006, 
          srbcsite
           FROM s_detail3[1].srbcseq,s_detail3[1].srbcseq1,s_detail3[1].srbc001,s_detail3[1].srbc002, 
               s_detail3[1].srbc003,s_detail3[1].srbc007,s_detail3[1].srbc004,s_detail3[1].srbc005,s_detail3[1].srbc006, 
               s_detail3[1].srbcsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbcseq
            #add-point:BEFORE FIELD srbcseq name="construct.b.page3.srbcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbcseq
            
            #add-point:AFTER FIELD srbcseq name="construct.a.page3.srbcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbcseq
            #add-point:ON ACTION controlp INFIELD srbcseq name="construct.c.page3.srbcseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbcseq1
            #add-point:BEFORE FIELD srbcseq1 name="construct.b.page3.srbcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbcseq1
            
            #add-point:AFTER FIELD srbcseq1 name="construct.a.page3.srbcseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbcseq1
            #add-point:ON ACTION controlp INFIELD srbcseq1 name="construct.c.page3.srbcseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc001
            #add-point:BEFORE FIELD srbc001 name="construct.b.page3.srbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc001
            
            #add-point:AFTER FIELD srbc001 name="construct.a.page3.srbc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc001
            #add-point:ON ACTION controlp INFIELD srbc001 name="construct.c.page3.srbc001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.srbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc002
            #add-point:ON ACTION controlp INFIELD srbc002 name="construct.c.page3.srbc002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srbc002  #顯示到畫面上
            NEXT FIELD srbc002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc002
            #add-point:BEFORE FIELD srbc002 name="construct.b.page3.srbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc002
            
            #add-point:AFTER FIELD srbc002 name="construct.a.page3.srbc002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc003
            #add-point:BEFORE FIELD srbc003 name="construct.b.page3.srbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc003
            
            #add-point:AFTER FIELD srbc003 name="construct.a.page3.srbc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc003
            #add-point:ON ACTION controlp INFIELD srbc003 name="construct.c.page3.srbc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc007
            #add-point:BEFORE FIELD srbc007 name="construct.b.page3.srbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc007
            
            #add-point:AFTER FIELD srbc007 name="construct.a.page3.srbc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc007
            #add-point:ON ACTION controlp INFIELD srbc007 name="construct.c.page3.srbc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc004
            #add-point:BEFORE FIELD srbc004 name="construct.b.page3.srbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc004
            
            #add-point:AFTER FIELD srbc004 name="construct.a.page3.srbc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc004
            #add-point:ON ACTION controlp INFIELD srbc004 name="construct.c.page3.srbc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc005
            #add-point:BEFORE FIELD srbc005 name="construct.b.page3.srbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc005
            
            #add-point:AFTER FIELD srbc005 name="construct.a.page3.srbc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc005
            #add-point:ON ACTION controlp INFIELD srbc005 name="construct.c.page3.srbc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc006
            #add-point:BEFORE FIELD srbc006 name="construct.b.page3.srbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc006
            
            #add-point:AFTER FIELD srbc006 name="construct.a.page3.srbc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc006
            #add-point:ON ACTION controlp INFIELD srbc006 name="construct.c.page3.srbc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbcsite
            #add-point:BEFORE FIELD srbcsite name="construct.b.page3.srbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbcsite
            
            #add-point:AFTER FIELD srbcsite name="construct.a.page3.srbcsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srbcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbcsite
            #add-point:ON ACTION controlp INFIELD srbcsite name="construct.c.page3.srbcsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
    # CONSTRUCT g_wc2_table2 ON inaoseq,inaoseq1,inaoseq2,inao001,inao008,inao009,inao010,inao012 
    #
    #      FROM s_detail2[1].inaoseq,s_detail2[1].inaoseq1,s_detail2[1].inaoseq2, 
    #          s_detail2[1].inao001,s_detail2[1].inao008,s_detail2[1].inao009,s_detail2[1].inao010,s_detail2[1].inao012 
    #
    #                 
    #    BEFORE CONSTRUCT
    #       #add-point:cs段before_construct
    #
    #       #end add-point 
    #       
    #  #單身公用欄位開窗相關處理(table 2)
    #  
    #  
    #  #單身一般欄位開窗相關處理       
    #  #---------------------<  Detail: page2  >---------------------
    #    #----<<inao000>>----
    #    #此段落由子樣板a01產生
    #
    #
    #    #----<<inao009>>----
    #    #此段落由子樣板a01產生
    #    BEFORE FIELD inao009
    #       #add-point:BEFORE FIELD inao009
    #
    #       #END add-point
    #
    #    #此段落由子樣板a02產生
    #    AFTER FIELD inao009
    #       
    #       #add-point:AFTER FIELD inao009
    #
    #       #END add-point
    #       
    #
    #    #Ctrlp:construct.c.page2.inao009
    #    ON ACTION controlp INFIELD inao009
    #       #add-point:ON ACTION controlp INFIELD inao009
    #
    #       #END add-point
    #
    #
    #  
    # END CONSTRUCT
    # 
    # CONSTRUCT g_wc2_table4 ON inaoseq_4,inaoseq1_4,inaoseq2_4,inao001_4,inao008_4,inao009_4,inao010_4,inao012_4 
    #
    #      FROM s_detail2[1].inaoseq_4,s_detail2[1].inaoseq1_4,s_detail2[1].inaoseq2_4, 
    #          s_detail2[1].inao001_4,s_detail2[1].inao008_4,s_detail2[1].inao009_4,s_detail2[1].inao010_4,s_detail2[1].inao012_4 
    #
    #                 
    #    BEFORE CONSTRUCT
    #       #add-point:cs段before_construct
    #
    #       #end add-point 
    #       
    #  #單身公用欄位開窗相關處理(table 2)
    #  
    #  
    #  #單身一般欄位開窗相關處理       
    #  #---------------------<  Detail: page2  >---------------------
    #    #----<<inao000>>----
    #    #此段落由子樣板a01產生
    #
    #
    #    #----<<inao009>>----
    #    #此段落由子樣板a01產生
    #    BEFORE FIELD inao009_4
    #       #add-point:BEFORE FIELD inao009
    #
    #       #END add-point
    #
    #    #此段落由子樣板a02產生
    #    AFTER FIELD inao009_4
    #       
    #       #add-point:AFTER FIELD inao009
    #
    #       #END add-point
    #       
    #
    #    #Ctrlp:construct.c.page2.inao009
    #    ON ACTION controlp INFIELD inao009_4
    #       #add-point:ON ACTION controlp INFIELD inao009
    #
    #       #END add-point
    #
    #
    #  
    # END CONSTRUCT
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
                  WHEN la_wc[li_idx].tableid = "srba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "srbb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "srbc_t" 
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
 
{<section id="asrt350.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION asrt350_filter()
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
      CONSTRUCT g_wc_filter ON srbadocno,srbadocdt,srba001,srba002,srba003,srba004,srba005,srba006,srbasite 
 
                          FROM s_browse[1].b_srbadocno,s_browse[1].b_srbadocdt,s_browse[1].b_srba001, 
                              s_browse[1].b_srba002,s_browse[1].b_srba003,s_browse[1].b_srba004,s_browse[1].b_srba005, 
                              s_browse[1].b_srba006,s_browse[1].b_srbasite
 
         BEFORE CONSTRUCT
               DISPLAY asrt350_filter_parser('srbadocno') TO s_browse[1].b_srbadocno
            DISPLAY asrt350_filter_parser('srbadocdt') TO s_browse[1].b_srbadocdt
            DISPLAY asrt350_filter_parser('srba001') TO s_browse[1].b_srba001
            DISPLAY asrt350_filter_parser('srba002') TO s_browse[1].b_srba002
            DISPLAY asrt350_filter_parser('srba003') TO s_browse[1].b_srba003
            DISPLAY asrt350_filter_parser('srba004') TO s_browse[1].b_srba004
            DISPLAY asrt350_filter_parser('srba005') TO s_browse[1].b_srba005
            DISPLAY asrt350_filter_parser('srba006') TO s_browse[1].b_srba006
            DISPLAY asrt350_filter_parser('srbasite') TO s_browse[1].b_srbasite
      
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
 
      CALL asrt350_filter_show('srbadocno')
   CALL asrt350_filter_show('srbadocdt')
   CALL asrt350_filter_show('srba001')
   CALL asrt350_filter_show('srba002')
   CALL asrt350_filter_show('srba003')
   CALL asrt350_filter_show('srba004')
   CALL asrt350_filter_show('srba005')
   CALL asrt350_filter_show('srba006')
   CALL asrt350_filter_show('srbasite')
 
END FUNCTION
 
{</section>}
 
{<section id="asrt350.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION asrt350_filter_parser(ps_field)
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
 
{<section id="asrt350.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION asrt350_filter_show(ps_field)
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
   LET ls_condition = asrt350_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asrt350.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION asrt350_query()
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
   CALL g_srbb_d.clear()
   CALL g_srbb3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL asrt350_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL asrt350_browser_fill("")
      CALL asrt350_fetch("")
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
      CALL asrt350_filter_show('srbadocno')
   CALL asrt350_filter_show('srbadocdt')
   CALL asrt350_filter_show('srba001')
   CALL asrt350_filter_show('srba002')
   CALL asrt350_filter_show('srba003')
   CALL asrt350_filter_show('srba004')
   CALL asrt350_filter_show('srba005')
   CALL asrt350_filter_show('srba006')
   CALL asrt350_filter_show('srbasite')
   CALL asrt350_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL asrt350_fetch("F") 
      #顯示單身筆數
      CALL asrt350_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asrt350.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION asrt350_fetch(p_flag)
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
   
   LET g_srba_m.srbadocno = g_browser[g_current_idx].b_srbadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE asrt350_master_referesh USING g_srba_m.srbadocno INTO g_srba_m.srbasite,g_srba_m.srbadocno, 
       g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005, 
       g_srba_m.srba006,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfdt, 
       g_srba_m.srba003_desc,g_srba_m.srbaownid_desc,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid_desc, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbamodid_desc,g_srba_m.srbacnfid_desc
   
   #遮罩相關處理
   LET g_srba_m_mask_o.* =  g_srba_m.*
   CALL asrt350_srba_t_mask()
   LET g_srba_m_mask_n.* =  g_srba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt350_set_act_visible()   
   CALL asrt350_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_srba_m_t.* = g_srba_m.*
   LET g_srba_m_o.* = g_srba_m.*
   
   LET g_data_owner = g_srba_m.srbaownid      
   LET g_data_dept  = g_srba_m.srbaowndp
   
   #重新顯示   
   CALL asrt350_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt350.insert" >}
#+ 資料新增
PRIVATE FUNCTION asrt350_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
DEFINE l_ooef004               LIKE ooef_t.ooef004
DEFINE l_n                     LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_srbb_d.clear()   
   CALL g_srbb3_d.clear()  
 
 
   INITIALIZE g_srba_m.* TO NULL             #DEFAULT 設定
   
   LET g_srbadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_srba_m.srbaownid = g_user
      LET g_srba_m.srbaowndp = g_dept
      LET g_srba_m.srbacrtid = g_user
      LET g_srba_m.srbacrtdp = g_dept 
      LET g_srba_m.srbacrtdt = cl_get_current()
      LET g_srba_m.srbamodid = g_user
      LET g_srba_m.srbamoddt = cl_get_current()
      LET g_srba_m.srbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_srba_m.srbastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_srba_m.srbasite = g_site
      SELECT ooef004 INTO l_ooef004 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      SELECT COUNT(*) INTO l_n FROM ooba_t,oobx_t,oobl_t
       WHERE oobxent = oobaent AND oobx001 = ooba002 AND oobxent = ooblent AND oobx001 = oobl001
         AND oobaent = g_enterprise AND ooba001 = l_ooef004  AND oobl002 = 'asrt350' 
         AND oobastus = 'Y' AND oobx005 = 'Y' 
      IF l_n = 1 THEN
         SELECT ooba002 INTO g_srba_m.srbadocno FROM ooba_t,oobx_t,oobl_t
          WHERE oobxent = oobaent AND oobx001 = ooba002 AND oobxent = ooblent AND oobx001 = oobl001
            AND oobaent = g_enterprise AND ooba001 = l_ooef004  AND oobl002 = 'asrt350' 
            AND oobastus = 'Y' AND oobx005 = 'Y'
      END IF
      LET g_srba_m.srbadocdt = g_today 
      CALL s_date_get_first_date(g_today) RETURNING g_srba_m.srba001
      LET g_srba_m.srba002 = g_today
      LET g_srba_m_t.* = g_srba_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_srba_m_t.* = g_srba_m.*
      LET g_srba_m_o.* = g_srba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_srba_m.srbastus 
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
 
 
 
    
      CALL asrt350_input("a")
      
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
         INITIALIZE g_srba_m.* TO NULL
         INITIALIZE g_srbb_d TO NULL
         INITIALIZE g_srbb3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL asrt350_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_srbb_d.clear()
      #CALL g_srbb3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt350_set_act_visible()   
   CALL asrt350_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_srbadocno_t = g_srba_m.srbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " srbaent = " ||g_enterprise|| " AND",
                      " srbadocno = '", g_srba_m.srbadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asrt350_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE asrt350_cl
   
   CALL asrt350_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE asrt350_master_referesh USING g_srba_m.srbadocno INTO g_srba_m.srbasite,g_srba_m.srbadocno, 
       g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005, 
       g_srba_m.srba006,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfdt, 
       g_srba_m.srba003_desc,g_srba_m.srbaownid_desc,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid_desc, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbamodid_desc,g_srba_m.srbacnfid_desc
   
   
   #遮罩相關處理
   LET g_srba_m_mask_o.* =  g_srba_m.*
   CALL asrt350_srba_t_mask()
   LET g_srba_m_mask_n.* =  g_srba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.oobxl003,g_srba_m.srbadocdt,g_srba_m.srba001, 
       g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba003_desc,g_srba_m.srba004,g_srba_m.srba005,g_srba_m.srba005_desc, 
       g_srba_m.srba006,g_srba_m.srba006_desc,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaownid_desc, 
       g_srba_m.srbaowndp,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid,g_srba_m.srbacrtid_desc,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamodid_desc,g_srba_m.srbamoddt, 
       g_srba_m.srbacnfid,g_srba_m.srbacnfid_desc,g_srba_m.srbacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_srba_m.srbaownid      
   LET g_data_dept  = g_srba_m.srbaowndp
   
   #功能已完成,通報訊息中心
   CALL asrt350_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.modify" >}
#+ 資料修改
PRIVATE FUNCTION asrt350_modify()
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
   LET g_srba_m_t.* = g_srba_m.*
   LET g_srba_m_o.* = g_srba_m.*
   
   IF g_srba_m.srbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_srbadocno_t = g_srba_m.srbadocno
 
   CALL s_transaction_begin()
   
   OPEN asrt350_cl USING g_enterprise,g_srba_m.srbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt350_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asrt350_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asrt350_master_referesh USING g_srba_m.srbadocno INTO g_srba_m.srbasite,g_srba_m.srbadocno, 
       g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005, 
       g_srba_m.srba006,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfdt, 
       g_srba_m.srba003_desc,g_srba_m.srbaownid_desc,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid_desc, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbamodid_desc,g_srba_m.srbacnfid_desc
   
   #檢查是否允許此動作
   IF NOT asrt350_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_srba_m_mask_o.* =  g_srba_m.*
   CALL asrt350_srba_t_mask()
   LET g_srba_m_mask_n.* =  g_srba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   IF g_srba_m.srbastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00035'
      LET g_errparam.extend = g_srba_m.srbastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE asrt350_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL asrt350_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_srbadocno_t = g_srba_m.srbadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_srba_m.srbamodid = g_user 
LET g_srba_m.srbamoddt = cl_get_current()
LET g_srba_m.srbamodid_desc = cl_get_username(g_srba_m.srbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL asrt350_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE srba_t SET (srbamodid,srbamoddt) = (g_srba_m.srbamodid,g_srba_m.srbamoddt)
          WHERE srbaent = g_enterprise AND srbadocno = g_srbadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_srba_m.* = g_srba_m_t.*
            CALL asrt350_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_srba_m.srbadocno != g_srba_m_t.srbadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE srbb_t SET srbbdocno = g_srba_m.srbadocno
 
          WHERE srbbent = g_enterprise AND srbbdocno = g_srba_m_t.srbadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "srbb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srbb_t:",SQLERRMESSAGE 
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
         UPDATE inao_t
            SET inaodocno = g_srba_m.srbadocno
 
          WHERE inaoent = g_enterprise AND
                inaodocno = g_srbadocno_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inao_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "inao_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #end add-point
         
         UPDATE srbc_t
            SET srbcdocno = g_srba_m.srbadocno
 
          WHERE srbcent = g_enterprise AND
                srbcdocno = g_srbadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "srbc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srbc_t:",SQLERRMESSAGE 
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
   CALL asrt350_set_act_visible()   
   CALL asrt350_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " srbaent = " ||g_enterprise|| " AND",
                      " srbadocno = '", g_srba_m.srbadocno, "' "
 
   #填到對應位置
   CALL asrt350_browser_fill("")
 
   CLOSE asrt350_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asrt350_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="asrt350.input" >}
#+ 資料輸入
PRIVATE FUNCTION asrt350_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_close_dd            LIKE srba_t.srbadocdt
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_inam                DYNAMIC ARRAY OF RECORD   #記錄產品特徵
              inam001            LIKE inam_t.inam001,
              inam002            LIKE inam_t.inam002,
              inam004            LIKE inam_t.inam004
                                 END RECORD
#   DEFINE  l_srbb                RECORD LIKE srbb_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srbb RECORD  #重複性生產期末盤點單身檔
       srbbent LIKE srbb_t.srbbent, #企业编号
       srbbsite LIKE srbb_t.srbbsite, #营运据点
       srbbdocno LIKE srbb_t.srbbdocno, #盘点单号
       srbbseq LIKE srbb_t.srbbseq, #项次
       srbb001 LIKE srbb_t.srbb001, #料件编号
       srbb002 LIKE srbb_t.srbb002, #产品特征
       srbb003 LIKE srbb_t.srbb003, #库位
       srbb004 LIKE srbb_t.srbb004, #储位
       srbb005 LIKE srbb_t.srbb005, #批号
       srbb006 LIKE srbb_t.srbb006, #库存特征
       srbb007 LIKE srbb_t.srbb007, #单位
       srbb008 LIKE srbb_t.srbb008, #账面数量
       srbb009 LIKE srbb_t.srbb009, #盘点数量
       srbb010 LIKE srbb_t.srbb010, #参考单位
       srbb011 LIKE srbb_t.srbb011, #参考账面数量
       srbb012 LIKE srbb_t.srbb012  #参考盘点数量
END RECORD
#161124-00048#12 add(e)
   DEFINE  l_srbb012             LIKE srbb_t.srbb012
   
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
   DISPLAY BY NAME g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.oobxl003,g_srba_m.srbadocdt,g_srba_m.srba001, 
       g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba003_desc,g_srba_m.srba004,g_srba_m.srba005,g_srba_m.srba005_desc, 
       g_srba_m.srba006,g_srba_m.srba006_desc,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaownid_desc, 
       g_srba_m.srbaowndp,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid,g_srba_m.srbacrtid_desc,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamodid_desc,g_srba_m.srbamoddt, 
       g_srba_m.srbacnfid,g_srba_m.srbacnfid_desc,g_srba_m.srbacnfdt
   
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
   LET g_forupd_sql = "SELECT srbbseq,srbb001,srbb002,srbb005,srbb006,srbb007,srbb008,srbb009,srbb010, 
       srbb011,srbb012,srbbsite,srbb003,srbb004 FROM srbb_t WHERE srbbent=? AND srbbdocno=? AND srbbseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt350_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT srbcseq,srbcseq1,srbc001,srbc002,srbc003,srbc007,srbc004,srbc005,srbc006, 
       srbcsite FROM srbc_t WHERE srbcent=? AND srbcdocno=? AND srbcseq=? AND srbcseq1=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt350_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL asrt350_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL asrt350_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002, 
       g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005,g_srba_m.srba006,g_srba_m.srbastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="asrt350.input.head" >}
      #單頭段
      INPUT BY NAME g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002, 
          g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005,g_srba_m.srba006,g_srba_m.srbastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN asrt350_cl USING g_enterprise,g_srba_m.srbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt350_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt350_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL asrt350_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL cl_set_comp_entry("srba003,srba005,srba006",TRUE)
            LET g_flag5 = 'N'
            #end add-point
            CALL asrt350_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbasite
            #add-point:BEFORE FIELD srbasite name="input.b.srbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbasite
            
            #add-point:AFTER FIELD srbasite name="input.a.srbasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbasite
            #add-point:ON CHANGE srbasite name="input.g.srbasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbadocno
            #add-point:BEFORE FIELD srbadocno name="input.b.srbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbadocno
            
            #add-point:AFTER FIELD srbadocno name="input.a.srbadocno"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_srba_m.srbadocno) THEN 
               #检查单别
               #CALL s_aooi200_chk_slip(g_site,'',g_srba_m.srbadocno,'asrt350') #160613-00038#1 mark
               CALL s_aooi200_chk_slip(g_site,'',g_srba_m.srbadocno,g_prog)     #160613-00038#1 add
               RETURNING l_success
               IF NOT l_success THEN
                  LET g_srba_m.srbadocno = g_srbadocno_t
                  CALL s_aooi200_get_slip_desc(g_srba_m.srbadocno)
                  RETURNING g_srba_m.oobxl003
                  DISPLAY BY NAME g_srba_m.oobxl003
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_srba_m.srbadocno != g_srbadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srba_t WHERE "||"srbaent = '" ||g_enterprise|| "' AND "||"srbadocno = '"||g_srba_m.srbadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_aooi200_get_slip_desc(g_srba_m.srbadocno)
                 RETURNING g_srba_m.oobxl003
               DISPLAY BY NAME g_srba_m.oobxl003
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbadocno
            #add-point:ON CHANGE srbadocno name="input.g.srbadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbadocdt
            #add-point:BEFORE FIELD srbadocdt name="input.b.srbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbadocdt
            
            #add-point:AFTER FIELD srbadocdt name="input.a.srbadocdt"
            IF NOT cl_null(g_srba_m.srbadocdt) AND (cl_null(g_srba_m_t.srbadocdt) OR g_srba_m.srbadocdt != g_srba_m_t.srbadocdt) THEN 
               LET l_close_dd = cl_get_para(g_enterprise,g_site,'S-MFG-0031')
               IF g_srba_m.srbadocdt < l_close_dd THEN
                  #日期不可小于关帐日期
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00008'
                  LET g_errparam.extend = g_srba_m.srbadocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_srba_m.srbadocdt = g_srba_m_t.srbadocdt
                  DISPLAY BY NAME g_srba_m.srbadocdt
                  NEXT FIELD srbadocdt
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbadocdt
            #add-point:ON CHANGE srbadocdt name="input.g.srbadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba001
            #add-point:BEFORE FIELD srba001 name="input.b.srba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba001
            
            #add-point:AFTER FIELD srba001 name="input.a.srba001"
            IF NOT cl_null(g_srba_m.srba001) AND (cl_null(g_srba_m_t.srba001) OR g_srba_m.srba001 != g_srba_m_t.srba001) THEN 
               LET l_close_dd = cl_get_para(g_enterprise,g_site,'S-MFG-0031')
               IF g_srba_m.srba001 < l_close_dd THEN
                  #日期不可小于关帐日期
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00008'
                  LET g_errparam.extend = g_srba_m.srba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_srba_m.srba001 = g_srba_m_t.srba001
                  DISPLAY BY NAME g_srba_m.srba001
                  NEXT FIELD srba001
               END IF
               IF NOT cl_null(g_srba_m.srba002) THEN
                  IF g_srba_m.srba001 > g_srba_m.srba002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = g_srba_m.srba001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_srba_m.srba001 = g_srba_m_t.srba001
                     DISPLAY BY NAME g_srba_m.srba001
                     NEXT FIELD srba001
                  END IF
                  #分摊起讫日期不可跨月
                  IF YEAR(g_srba_m.srba001) != YEAR(g_srba_m.srba002) OR MONTH(g_srba_m.srba001) != MONTH(g_srba_m.srba002) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00277'
                     LET g_errparam.extend = g_srba_m.srba001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_srba_m.srba001 = g_srba_m_t.srba001
                     DISPLAY BY NAME g_srba_m.srba001
                     NEXT FIELD srba001
                  END IF
               END IF
               CALL asrt350_srba001()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srba001
            #add-point:ON CHANGE srba001 name="input.g.srba001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba002
            #add-point:BEFORE FIELD srba002 name="input.b.srba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba002
            
            #add-point:AFTER FIELD srba002 name="input.a.srba002"
            IF NOT cl_null(g_srba_m.srba002) AND (cl_null(g_srba_m_t.srba002) OR g_srba_m.srba002!= g_srba_m_t.srba002) THEN 
               LET l_close_dd = cl_get_para(g_enterprise,g_site,'S-MFG-0031')
               IF g_srba_m.srba002 < l_close_dd THEN
                  #日期不可小于关帐日期
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00008'
                  LET g_errparam.extend = g_srba_m.srba002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_srba_m.srba002 = g_srba_m_t.srba002
                  DISPLAY BY NAME g_srba_m.srba002
                  NEXT FIELD srba002
               END IF
               IF NOT cl_null(g_srba_m.srba001) THEN
                  IF g_srba_m.srba001 > g_srba_m.srba002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = g_srba_m.srba002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_srba_m.srba002 = g_srba_m_t.srba002
                     DISPLAY BY NAME g_srba_m.srba002
                     NEXT FIELD srba002
                  END IF
                  #分摊起讫日期不可跨月
                  IF YEAR(g_srba_m.srba001) != YEAR(g_srba_m.srba002) OR MONTH(g_srba_m.srba001) != MONTH(g_srba_m.srba002) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00277'
                     LET g_errparam.extend = g_srba_m.srba002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_srba_m.srba002 = g_srba_m_t.srba002
                     DISPLAY BY NAME g_srba_m.srba002
                     NEXT FIELD srba002
                  END IF
               END IF
               CALL asrt350_srba001()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srba002
            #add-point:ON CHANGE srba002 name="input.g.srba002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba003
            
            #add-point:AFTER FIELD srba003 name="input.a.srba003"
            IF NOT cl_null(g_srba_m.srba003) AND (cl_null(g_srba_m_t.srba003) OR g_srba_m.srba003 != g_srba_m_t.srba003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_srba_m.srba003 
               #160318-00025#22  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="asr-00014:sub-01302|asri001|",cl_get_progname("asri001",g_lang,"2"),"|:EXEPROGasri001"
              #160318-00025#22  by 07900 --add-end               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_srza001") THEN
                  #檢查成功時後續處理
                  SELECT srza011 INTO g_srba_m.srba004 FROM srza_t WHERE srzaent=g_enterprise AND srzasite=g_site AND srza001=g_srba_m.srba003
                  DISPLAY BY NAME g_srba_m.srba004
               ELSE
                  #檢查失敗時後續處理
                  LET g_srba_m.srba003 = g_srba_m_t.srba003
                  CALL asrt350_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL asrt350_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba003
            #add-point:BEFORE FIELD srba003 name="input.b.srba003"
            CALL cl_set_comp_entry('srba003',TRUE)
            SELECT COUNT(*) INTO l_n FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site AND srbbdocno=g_srba_m.srbadocno
            IF l_n > 0 THEN
               CALL cl_set_comp_entry('srba003',FALSE)
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srba003
            #add-point:ON CHANGE srba003 name="input.g.srba003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba004
            #add-point:BEFORE FIELD srba004 name="input.b.srba004"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba004
            
            #add-point:AFTER FIELD srba004 name="input.a.srba004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srba004
            #add-point:ON CHANGE srba004 name="input.g.srba004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba005
            
            #add-point:AFTER FIELD srba005 name="input.a.srba005"
            IF NOT cl_null(g_srba_m.srba005) AND (cl_null(g_srba_m_t.srba005) OR g_srba_m.srba005 != g_srba_m_t.srba005) THEN 
               IF NOT asrt350_chk_warehouses() THEN
                  LET g_srba_m.srba005 = g_srba_m_t.srba005 
                  CALL asrt350_desc()
                  NEXT FIELD CURRENT
               END IF
               #檢核輸入的倉庫儲位是否在單據別限制範圍內，若不在限制內則不允許使用此倉庫儲位
               IF g_srba_m.srba006 IS NOT NULL THEN
                  CALL s_control_chk_doc('6',g_srba_m.srbadocno,g_srba_m.srba005,g_srba_m.srba006,'','','') RETURNING l_success,l_flag
                  IF NOT l_success THEN
                     LET g_srba_m.srba005 = g_srba_m_t.srba005 
                     CALL asrt350_desc()
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT l_flag THEN
                        LET g_srba_m.srba005 = g_srba_m_t.srba005 
                        CALL asrt350_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               END IF                  
            END IF
            CALL asrt350_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba005
            #add-point:BEFORE FIELD srba005 name="input.b.srba005"
            CALL cl_set_comp_entry('srba005',TRUE)
            SELECT COUNT(*) INTO l_n FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site AND srbbdocno=g_srba_m.srbadocno
            IF l_n > 0 THEN
               CALL cl_set_comp_entry('srba005',FALSE)
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srba005
            #add-point:ON CHANGE srba005 name="input.g.srba005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srba006
            
            #add-point:AFTER FIELD srba006 name="input.a.srba006"
            IF g_srba_m.srba006 IS NOT NULL AND (g_srba_m_t.srba006 IS NULL OR g_srba_m.srba006 != g_srba_m_t.srba006) THEN 
               IF NOT asrt350_chk_warehouses() THEN
                  LET g_srba_m.srba006 = g_srba_m_t.srba006 
                  CALL asrt350_desc()
                  NEXT FIELD CURRENT
               END IF       
               #檢核輸入的倉庫儲位是否在單據別限制範圍內，若不在限制內則不允許使用此倉庫儲位
               IF g_srba_m.srba005 IS NOT NULL THEN
                  CALL s_control_chk_doc('6',g_srba_m.srbadocno,g_srba_m.srba005,g_srba_m.srba006,'','','') RETURNING l_success,l_flag
                  IF NOT l_success THEN
                     LET g_srba_m.srba006 = g_srba_m_t.srba006 
                     CALL asrt350_desc()
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT l_flag THEN
                        LET g_srba_m.srba006 = g_srba_m_t.srba006 
                        CALL asrt350_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF  
               END IF                  
            END IF
            IF g_srba_m.srba006 IS NULL THEN
               LET g_srba_m.srba006 = ' '
            END IF
            CALL asrt350_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srba006
            #add-point:BEFORE FIELD srba006 name="input.b.srba006"
            CALL cl_set_comp_entry('srba006',TRUE)
            SELECT COUNT(*) INTO l_n FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site AND srbbdocno=g_srba_m.srbadocno
            IF l_n > 0 THEN
               CALL cl_set_comp_entry('srba006',FALSE)
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srba006
            #add-point:ON CHANGE srba006 name="input.g.srba006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbastus
            #add-point:BEFORE FIELD srbastus name="input.b.srbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbastus
            
            #add-point:AFTER FIELD srbastus name="input.a.srbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbastus
            #add-point:ON CHANGE srbastus name="input.g.srbastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.srbasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbasite
            #add-point:ON ACTION controlp INFIELD srbasite name="input.c.srbasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.srbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbadocno
            #add-point:ON ACTION controlp INFIELD srbadocno name="input.c.srbadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srba_m.srbadocno             #給予default值

            #給予arg
            #单别参照表号
            SELECT ooef004 INTO l_ooef004 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            LET g_qryparam.arg1 = l_ooef004
            #LET g_qryparam.arg2 = 'asrt350'   #160705-00042#1 160711 by sakura mark       
            LET g_qryparam.arg2 = g_prog       #160705-00042#1 160711 by sakura add
            CALL q_ooba002_6()                                #呼叫開窗
            LET g_srba_m.srbadocno = g_qryparam.return1              
            DISPLAY g_srba_m.srbadocno TO srbadocno              #
            NEXT FIELD srbadocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbadocdt
            #add-point:ON ACTION controlp INFIELD srbadocdt name="input.c.srbadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.srba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba001
            #add-point:ON ACTION controlp INFIELD srba001 name="input.c.srba001"
            
            #END add-point
 
 
         #Ctrlp:input.c.srba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba002
            #add-point:ON ACTION controlp INFIELD srba002 name="input.c.srba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.srba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba003
            #add-point:ON ACTION controlp INFIELD srba003 name="input.c.srba003"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srba_m.srba003             #給予default值            
            CALL q_srza001()                                #呼叫開窗
            LET g_srba_m.srba003 = g_qryparam.return1              
            DISPLAY g_srba_m.srba003 TO srba003              #
            NEXT FIELD srba003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba004
            #add-point:ON ACTION controlp INFIELD srba004 name="input.c.srba004"
            #此段落由子樣板a07產生            
            #END add-point
 
 
         #Ctrlp:input.c.srba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba005
            #add-point:ON ACTION controlp INFIELD srba005 name="input.c.srba005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srba_m.srba005             #給予default值 
            CALL q_inaa001_2()                                #呼叫開窗
            LET g_srba_m.srba005 = g_qryparam.return1              
            DISPLAY g_srba_m.srba005 TO srba005              #
            NEXT FIELD srba005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srba006
            #add-point:ON ACTION controlp INFIELD srba006 name="input.c.srba006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srba_m.srba006             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_srba_m.srba005 #           
            CALL q_inab002_3()                                #呼叫開窗
            LET g_srba_m.srba006 = g_qryparam.return1              
            DISPLAY g_srba_m.srba006 TO srba006              #
            NEXT FIELD srba006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbastus
            #add-point:ON ACTION controlp INFIELD srbastus name="input.c.srbastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_srba_m.srbadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #自动编号
               CALL s_aooi200_gen_docno(g_site,g_srba_m.srbadocno,g_srba_m.srbadocdt,g_prog)
                    RETURNING l_success,g_srba_m.srbadocno
               IF NOT l_success THEN
                  NEXT FIELD srbadocno
               END IF
               #end add-point
               
               INSERT INTO srba_t (srbaent,srbasite,srbadocno,srbadocdt,srba001,srba002,srba003,srba004, 
                   srba005,srba006,srbastus,srbaownid,srbaowndp,srbacrtid,srbacrtdp,srbacrtdt,srbamodid, 
                   srbamoddt,srbacnfid,srbacnfdt)
               VALUES (g_enterprise,g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.srbadocdt,g_srba_m.srba001, 
                   g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005,g_srba_m.srba006, 
                   g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid,g_srba_m.srbacrtdp, 
                   g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_srba_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF cl_ask_confirm('asr-00040') THEN
                  LET g_flag2 = 'N'
                  IF NOT asrt350_gen_fill(g_srba_m.srbadocno,g_srba_m.srba005,g_srba_m.srba006) THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL asrt350_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL asrt350_b_fill()
                  CALL asrt350_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               IF g_flag5 = 'Y' THEN
                  CALL asrt350_gen_srbc()
                  LET g_flag5 = 'N'
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL asrt350_srba_t_mask_restore('restore_mask_o')
               
               UPDATE srba_t SET (srbasite,srbadocno,srbadocdt,srba001,srba002,srba003,srba004,srba005, 
                   srba006,srbastus,srbaownid,srbaowndp,srbacrtid,srbacrtdp,srbacrtdt,srbamodid,srbamoddt, 
                   srbacnfid,srbacnfdt) = (g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.srbadocdt,g_srba_m.srba001, 
                   g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005,g_srba_m.srba006, 
                   g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid,g_srba_m.srbacrtdp, 
                   g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfdt) 
 
                WHERE srbaent = g_enterprise AND srbadocno = g_srbadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "srba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL asrt350_srba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_srba_m_t)
               LET g_log2 = util.JSON.stringify(g_srba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_srbadocno_t = g_srba_m.srbadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="asrt350.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_srbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_srbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asrt350_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_srbb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            IF g_rec_b = 0 AND g_flag2 != 'N' THEN           
               IF cl_ask_confirm('asr-00040') THEN
                  CALL s_transaction_begin()
                  IF NOT asrt350_gen_fill(g_srba_m.srbadocno,g_srba_m.srba005,g_srba_m.srba006) THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
                  CALL s_transaction_end('Y','0')
                  CALL asrt350_b_fill()
                  LET g_rec_b = g_srbb_d.getLength()
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
            OPEN asrt350_cl USING g_enterprise,g_srba_m.srbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt350_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt350_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_srbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_srbb_d[l_ac].srbbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_srbb_d_t.* = g_srbb_d[l_ac].*  #BACKUP
               LET g_srbb_d_o.* = g_srbb_d[l_ac].*  #BACKUP
               CALL asrt350_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL asrt350_set_no_entry_b(l_cmd)
               IF NOT asrt350_lock_b("srbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt350_bcl INTO g_srbb_d[l_ac].srbbseq,g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002, 
                      g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007,g_srbb_d[l_ac].srbb008, 
                      g_srbb_d[l_ac].srbb009,g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb011,g_srbb_d[l_ac].srbb012, 
                      g_srbb_d[l_ac].srbbsite,g_srbb_d[l_ac].srbb003,g_srbb_d[l_ac].srbb004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_srbb_d_t.srbbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_srbb_d_mask_o[l_ac].* =  g_srbb_d[l_ac].*
                  CALL asrt350_srbb_t_mask()
                  LET g_srbb_d_mask_n[l_ac].* =  g_srbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asrt350_show()
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
            INITIALIZE g_srbb_d[l_ac].* TO NULL 
            INITIALIZE g_srbb_d_t.* TO NULL 
            INITIALIZE g_srbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_srbb_d_t.* = g_srbb_d[l_ac].*     #新輸入資料
            LET g_srbb_d_o.* = g_srbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt350_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL asrt350_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_srbb_d[li_reproduce_target].* = g_srbb_d[li_reproduce].*
 
               LET g_srbb_d[li_reproduce_target].srbbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(srbbseq) + 1 INTO g_srbb_d[l_ac].srbbseq FROM srbb_t
             WHERE srbbent = g_enterprise
               AND srbbdocno = g_srba_m.srbadocno
            IF cl_null(g_srbb_d[l_ac].srbbseq) THEN
               LET g_srbb_d[l_ac].srbbseq = 1
            END IF
            LET g_srbb_d[l_ac].srbbsite = g_site
            LET g_srbb_d[l_ac].srbb008 = 0 
            LET g_srbb_d[l_ac].srbb003 = g_srba_m.srba005
            LET g_srbb_d[l_ac].srbb004 = g_srba_m.srba006
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
            IF NOT asrt350_chk_srbb(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srba_m.srba005,g_srba_m.srba006,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007,g_srbb_d[l_ac].srbb009,g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb012) THEN
               CANCEL INSERT
            END IF
            IF cl_null(g_srbb_d[l_ac].srbb002) THEN
               LET g_srbb_d[l_ac].srbb002 = ' '
            END IF
            IF cl_null(g_srbb_d[l_ac].srbb004) THEN
               LET g_srbb_d[l_ac].srbb004 = ' '
            END IF
            IF cl_null(g_srbb_d[l_ac].srbb005) THEN
               LET g_srbb_d[l_ac].srbb005 = ' '
            END IF
            IF cl_null(g_srbb_d[l_ac].srbb006) THEN
               LET g_srbb_d[l_ac].srbb006 = ' '
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM srbb_t 
             WHERE srbbent = g_enterprise AND srbbdocno = g_srba_m.srbadocno
 
               AND srbbseq = g_srbb_d[l_ac].srbbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srba_m.srbadocno
               LET gs_keys[2] = g_srbb_d[g_detail_idx].srbbseq
               CALL asrt350_insert_b('srbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_srbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asrt350_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               IF l_inam.getLength() > 1 THEN
#                  SELECT * INTO l_srbb.* FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site  #161124-00048#12 mark
                  #161124-00048#12 add(s)
                  SELECT srbbent,srbbsite,srbbdocno,srbbseq,srbb001,srbb002,srbb003,srbb004,
                         srbb005,srbb006,srbb007,srbb008,srbb009,srbb010,srbb011,srbb012 
                    INTO l_srbb.* FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site
                  #161124-00048#12 add(e)
                     AND srbbdocno=g_srba_m.srbadocno AND srbbseq=g_srbb_d[l_ac].srbbseq
                  FOR l_i = 2 TO l_inam.getLength()
                     SELECT MAX(srbbseq) INTO l_srbb.srbbseq FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site
                        AND srbbdocno=g_srba_m.srbadocno 
                     LET l_srbb.srbb002=l_inam[l_i].inam002
                     LET l_srbb.srbb009=l_inam[l_i].inam004
#                     INSERT INTO srbb_t VALUES l_srbb.* #161124-00048#12 mark
                     #161124-00048#12 add(s)
                     INSERT INTO srbb_t(srbbent,srbbsite,srbbdocno,srbbseq,srbb001,srbb002,srbb003,srbb004,srbb005,srbb006,srbb007,srbb008,srbb009,srbb010,srbb011,srbb012) 
                                 VALUES(l_srbb.srbbent,l_srbb.srbbsite,l_srbb.srbbdocno,l_srbb.srbbseq,l_srbb.srbb001,l_srbb.srbb002,l_srbb.srbb003,l_srbb.srbb004,l_srbb.srbb005,l_srbb.srbb006,l_srbb.srbb007,l_srbb.srbb008,l_srbb.srbb009,l_srbb.srbb010,l_srbb.srbb011,l_srbb.srbb012)
                     #161124-00048#12 add(e)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "INSERT srbb_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')                    
                        CANCEL INSERT
                        EXIT FOR
                     END IF
                  END FOR
                  CALL asrt350_b_fill()
                  LET g_rec_b = g_srbb_d.getLength() - 1
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
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_srba_m.srbadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_srbb_d_t.srbbseq
 
            
               #刪除同層單身
               IF NOT asrt350_delete_b('srbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt350_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asrt350_key_delete_b(gs_keys,'srbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt350_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE asrt350_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_srbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_srbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbbseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_srbb_d[l_ac].srbbseq,"1","1","","","azz-00079",1) THEN
               NEXT FIELD srbbseq
            END IF 
 
 
 
            #add-point:AFTER FIELD srbbseq name="input.a.page1.srbbseq"
            #此段落由子樣板a05產生
            IF  g_srba_m.srbadocno IS NOT NULL AND g_srbb_d[g_detail_idx].srbbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_srba_m.srbadocno != g_srbadocno_t OR g_srbb_d[g_detail_idx].srbbseq != g_srbb_d_t.srbbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srbb_t WHERE "||"srbbent = '" ||g_enterprise|| "' AND "||"srbbdocno = '"||g_srba_m.srbadocno ||"' AND "|| "srbbseq = '"||g_srbb_d[g_detail_idx].srbbseq ||"'",'std-00004',0) THEN 
                     LET g_srbb_d[g_detail_idx].srbbseq = g_srbb_d_t.srbbseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbbseq
            #add-point:BEFORE FIELD srbbseq name="input.b.page1.srbbseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbbseq
            #add-point:ON CHANGE srbbseq name="input.g.page1.srbbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb001
            
            #add-point:AFTER FIELD srbb001 name="input.a.page1.srbb001"
            CALL asrt350_b_desc()
            IF NOT cl_null(g_srbb_d[l_ac].srbb001) AND (cl_null(g_srbb_d_t.srbb001) OR g_srbb_d[l_ac].srbb001 != g_srbb_d_t.srbb001) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_srbb_d[l_ac].srbb001
               IF cl_chk_exist("v_imaf001_1") THEN
                  #檢查成功時後續處理
                  #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許盘点此料
                  CALL s_control_chk_doc('4',g_srba_m.srbadocno,g_srbb_d[l_ac].srbb001,'','','','') RETURNING l_success,l_flag
                  IF NOT l_success THEN
                     LET g_srbb_d[l_ac].srbb001 = g_srbb_d_t.srbb001
                     CALL asrt350_b_desc()
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT l_flag THEN
                        LET g_srbb_d[l_ac].srbb001 = g_srbb_d_t.srbb001
                        CALL asrt350_b_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
         
                  #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許盘点此料
                  CALL s_control_chk_doc('5',g_srba_m.srbadocno,g_srbb_d[l_ac].srbb001,'','','','') RETURNING l_success,l_flag
                  IF NOT l_success THEN
                     LET g_srbb_d[l_ac].srbb001 = g_srbb_d_t.srbb001
                     CALL asrt350_b_desc()
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT l_flag THEN
                        LET g_srbb_d[l_ac].srbb001 = g_srbb_d_t.srbb001
                        CALL asrt350_b_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_srbb_d[l_ac].srbb001 = g_srbb_d_t.srbb001
                  CALL asrt350_b_desc()
                  NEXT FIELD CURRENT
               END IF
               
               #料号相关栏位开启关闭
               CALL asrt350_chk_srbb_entry(g_srbb_d[l_ac].srbb001)
               IF g_flag1 = 'Y' THEN
                  IF s_feature_auto_chk(g_srbb_d[l_ac].srbb001) AND cl_null(g_srbb_d[l_ac].srbb002) THEN  #160314-00009#14 add
                     IF l_cmd = 'a' THEN
                        CALL l_inam.clear()
                        CALL s_feature_multi(g_srbb_d[l_ac].srbb001,'','',g_site,g_srba_m.srbadocno) RETURNING l_success,l_inam
                        LET g_srbb_d[l_ac].srbb002 = l_inam[1].inam002
                        LET g_srbb_d[l_ac].srbb009 = l_inam[1].inam004
                        DISPLAY BY NAME g_srbb_d[l_ac].srbb002,g_srbb_d[l_ac].srbb009
                     END IF
                  END IF       #160314-00009#14 add
               END IF
               SELECT imaf053,imaf015 INTO g_srbb_d[l_ac].srbb007,g_srbb_d[l_ac].srbb010 FROM imaf_t WHERE imafent=g_enterprise AND imafsite=g_site AND imaf001=g_srbb_d[l_ac].srbb001
               IF cl_null(g_srbb_d[l_ac].srbb007) THEN
                  SELECT imaa006 INTO g_srbb_d[l_ac].srbb007 FROM imaa_t WHERE imaaent=g_enterprise AND imaa001=g_srbb_d[l_ac].srbb001
               END IF
               IF NOT cl_null(g_srbb_d[l_ac].srbb010) THEN
                  LET g_srbb_d[l_ac].srbb011 = 0 
               END IF
               CALL asrt350_def_srbb008(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srba_m.srba005,g_srba_m.srba006,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007)
               CALL asrt350_b_desc()
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb001
            #add-point:BEFORE FIELD srbb001 name="input.b.page1.srbb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb001
            #add-point:ON CHANGE srbb001 name="input.g.page1.srbb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb002
            #add-point:BEFORE FIELD srbb002 name="input.b.page1.srbb002"
            CALL asrt350_chk_srbb_entry(g_srbb_d[l_ac].srbb001) 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb002
            
            #add-point:AFTER FIELD srbb002 name="input.a.page1.srbb002"
            IF cl_null(g_srbb_d[l_ac].srbb002) THEN
               LET g_srbb_d[l_ac].srbb002 = ' '
            END IF
            IF g_srbb_d[l_ac].srbb002 IS NOT NULL AND (g_srbb_d_t.srbb002 IS NULL OR g_srbb_d[l_ac].srbb002 != g_srbb_d_t.srbb002) THEN
               CALL asrt350_def_srbb008(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srba_m.srba005,g_srba_m.srba006,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007)
               #--151224-00025#4 add start--
               IF NOT s_feature_direct_input(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srbb_d_t.srbb002,g_srba_m.srbadocno,g_srba_m.srbasite) THEN
                  NEXT FIELD CURRENT
               END IF
               #--151224-00025#4 add end-- 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb002
            #add-point:ON CHANGE srbb002 name="input.g.page1.srbb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb005
            #add-point:BEFORE FIELD srbb005 name="input.b.page1.srbb005"
            CALL asrt350_chk_srbb_entry(g_srbb_d[l_ac].srbb001)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb005
            
            #add-point:AFTER FIELD srbb005 name="input.a.page1.srbb005"
            IF cl_null(g_srbb_d[l_ac].srbb005) THEN
               LET g_srbb_d[l_ac].srbb005 = ' '
            END IF
            IF g_srbb_d[l_ac].srbb005 IS NOT NULL AND (g_srbb_d_t.srbb005 IS NULL OR g_srbb_d[l_ac].srbb005 != g_srbb_d_t.srbb005) THEN
               CALL asrt350_def_srbb008(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srba_m.srba005,g_srba_m.srba006,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb005
            #add-point:ON CHANGE srbb005 name="input.g.page1.srbb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb006
            #add-point:BEFORE FIELD srbb006 name="input.b.page1.srbb006"
            CALL asrt350_chk_srbb_entry(g_srbb_d[l_ac].srbb001)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb006
            
            #add-point:AFTER FIELD srbb006 name="input.a.page1.srbb006"
            IF cl_null(g_srbb_d[l_ac].srbb006) THEN
               LET g_srbb_d[l_ac].srbb006 = ' '
            END IF
            IF g_srbb_d[l_ac].srbb006 IS NOT NULL AND (g_srbb_d_t.srbb006 IS NULL OR g_srbb_d[l_ac].srbb006 != g_srbb_d_t.srbb006) THEN
               CALL asrt350_def_srbb008(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srba_m.srba005,g_srba_m.srba006,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb006
            #add-point:ON CHANGE srbb006 name="input.g.page1.srbb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb007
            
            #add-point:AFTER FIELD srbb007 name="input.a.page1.srbb007"
            CALL asrt350_b_desc()
            IF NOT cl_null(g_srbb_d[l_ac].srbb007) AND (cl_null(g_srbb_d_t.srbb007) OR g_srbb_d[l_ac].srbb007 != g_srbb_d_t.srbb007) THEN
               IF asrt350_chk_srbb007() THEN
                  CALL asrt350_def_srbb008(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srba_m.srba005,g_srba_m.srba006,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007)       
               ELSE
                  LET g_srbb_d[l_ac].srbb007 = g_srbb_d_t.srbb007
                  CALL asrt350_b_desc()
               END IF            
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb007
            #add-point:BEFORE FIELD srbb007 name="input.b.page1.srbb007"
            CALL asrt350_chk_srbb_entry(g_srbb_d[l_ac].srbb001)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb007
            #add-point:ON CHANGE srbb007 name="input.g.page1.srbb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb008
            #add-point:BEFORE FIELD srbb008 name="input.b.page1.srbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb008
            
            #add-point:AFTER FIELD srbb008 name="input.a.page1.srbb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb008
            #add-point:ON CHANGE srbb008 name="input.g.page1.srbb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_srbb_d[l_ac].srbb009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD srbb009
            END IF 
 
 
 
            #add-point:AFTER FIELD srbb009 name="input.a.page1.srbb009"
            IF NOT cl_null(g_srbb_d[l_ac].srbb009) THEN
               #数量进行单位取位
               CALL s_aooi250_take_decimals(g_srbb_d[l_ac].srbb007,g_srbb_d[l_ac].srbb009) RETURNING l_success,g_srbb_d[l_ac].srbb009
               IF NOT l_success THEN
                  LET g_srbb_d[l_ac].srbb009 = g_srbb_d_t.srbb009
                  NEXT FIELD srbb009
               END IF
               LET g_srbb_d[l_ac].l_num = g_srbb_d[l_ac].srbb008 - g_srbb_d[l_ac].srbb009
            ELSE
               LET g_srbb_d[l_ac].l_num = ''
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb009
            #add-point:BEFORE FIELD srbb009 name="input.b.page1.srbb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb009
            #add-point:ON CHANGE srbb009 name="input.g.page1.srbb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_num
            #add-point:BEFORE FIELD l_num name="input.b.page1.l_num"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_num
            
            #add-point:AFTER FIELD l_num name="input.a.page1.l_num"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_num
            #add-point:ON CHANGE l_num name="input.g.page1.l_num"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_num1
            #add-point:BEFORE FIELD l_num1 name="input.b.page1.l_num1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_num1
            
            #add-point:AFTER FIELD l_num1 name="input.a.page1.l_num1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_num1
            #add-point:ON CHANGE l_num1 name="input.g.page1.l_num1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb010
            
            #add-point:AFTER FIELD srbb010 name="input.a.page1.srbb010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_srbb_d[l_ac].srbb010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_srbb_d[l_ac].srbb010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_srbb_d[l_ac].srbb010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb010
            #add-point:BEFORE FIELD srbb010 name="input.b.page1.srbb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb010
            #add-point:ON CHANGE srbb010 name="input.g.page1.srbb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb011
            #add-point:BEFORE FIELD srbb011 name="input.b.page1.srbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb011
            
            #add-point:AFTER FIELD srbb011 name="input.a.page1.srbb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb011
            #add-point:ON CHANGE srbb011 name="input.g.page1.srbb011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_srbb_d[l_ac].srbb012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD srbb012
            END IF 
 
 
 
            #add-point:AFTER FIELD srbb012 name="input.a.page1.srbb012"
            IF NOT cl_null(g_srbb_d[l_ac].srbb012) THEN
               #数量进行单位取位
               CALL s_aooi250_take_decimals(g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb012) RETURNING l_success,g_srbb_d[l_ac].srbb012
               IF NOT l_success THEN
                  LET g_srbb_d[l_ac].srbb012 = g_srbb_d_t.srbb012
                  NEXT FIELD srbb012
               END IF
               LET g_srbb_d[l_ac].l_num2 = g_srbb_d[l_ac].srbb011 - g_srbb_d[l_ac].srbb012
            ELSE
               LET g_srbb_d[l_ac].l_num2 = ''
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb012
            #add-point:BEFORE FIELD srbb012 name="input.b.page1.srbb012"
            CALL cl_set_comp_entry("srbb012",TRUE)
            IF cl_null(g_srbb_d[l_ac].srbb010) THEN
               CALL cl_set_comp_entry("srbb012",FALSE)
            END IF               
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb012
            #add-point:ON CHANGE srbb012 name="input.g.page1.srbb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_num2
            #add-point:BEFORE FIELD l_num2 name="input.b.page1.l_num2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_num2
            
            #add-point:AFTER FIELD l_num2 name="input.a.page1.l_num2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_num2
            #add-point:ON CHANGE l_num2 name="input.g.page1.l_num2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_num3
            #add-point:BEFORE FIELD l_num3 name="input.b.page1.l_num3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_num3
            
            #add-point:AFTER FIELD l_num3 name="input.a.page1.l_num3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_num3
            #add-point:ON CHANGE l_num3 name="input.g.page1.l_num3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbbsite
            #add-point:BEFORE FIELD srbbsite name="input.b.page1.srbbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbbsite
            
            #add-point:AFTER FIELD srbbsite name="input.a.page1.srbbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbbsite
            #add-point:ON CHANGE srbbsite name="input.g.page1.srbbsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb003
            #add-point:BEFORE FIELD srbb003 name="input.b.page1.srbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb003
            
            #add-point:AFTER FIELD srbb003 name="input.a.page1.srbb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb003
            #add-point:ON CHANGE srbb003 name="input.g.page1.srbb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbb004
            #add-point:BEFORE FIELD srbb004 name="input.b.page1.srbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbb004
            
            #add-point:AFTER FIELD srbb004 name="input.a.page1.srbb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbb004
            #add-point:ON CHANGE srbb004 name="input.g.page1.srbb004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.srbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbbseq
            #add-point:ON ACTION controlp INFIELD srbbseq name="input.c.page1.srbbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb001
            #add-point:ON ACTION controlp INFIELD srbb001 name="input.c.page1.srbb001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srbb_d[l_ac].srbb001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001()                                #呼叫開窗

            LET g_srbb_d[l_ac].srbb001 = g_qryparam.return1              

            DISPLAY g_srbb_d[l_ac].srbb001 TO srbb001              #

            NEXT FIELD srbb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb002
            #add-point:ON ACTION controlp INFIELD srbb002 name="input.c.page1.srbb002"
            IF NOT cl_null(g_srbb_d[l_ac].srbb001) THEN
               CALL asrt350_chk_srbb_entry(g_srbb_d[l_ac].srbb001)
               IF g_flag1 = 'Y' THEN
                  IF l_cmd = 'a' THEN
                     CALL l_inam.clear()
                     CALL s_feature_multi(g_srbb_d[l_ac].srbb001,'','',g_site,g_srba_m.srbadocno) RETURNING l_success,l_inam
                     LET g_srbb_d[l_ac].srbb002 = l_inam[1].inam002
                     LET g_srbb_d[l_ac].srbb009 = l_inam[1].inam004
                     DISPLAY BY NAME g_srbb_d[l_ac].srbb002,g_srbb_d[l_ac].srbb009
                  END IF
                  IF l_cmd = 'u' THEN
                     CALL s_feature_single(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_site,g_srba_m.srbadocno)
                        RETURNING l_success,g_srbb_d[l_ac].srbb002
                     DISPLAY BY NAME g_srbb_d[l_ac].srbb002
                  END IF
               END IF
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb005
            #add-point:ON ACTION controlp INFIELD srbb005 name="input.c.page1.srbb005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srbb_d[l_ac].srbb005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inag006()                                #呼叫開窗

            LET g_srbb_d[l_ac].srbb005 = g_qryparam.return1              

            DISPLAY g_srbb_d[l_ac].srbb005 TO srbb005              #

            NEXT FIELD srbb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb006
            #add-point:ON ACTION controlp INFIELD srbb006 name="input.c.page1.srbb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb007
            #add-point:ON ACTION controlp INFIELD srbb007 name="input.c.page1.srbb007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srbb_d[l_ac].srbb007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_srbb_d[l_ac].srbb007 = g_qryparam.return1              

            DISPLAY g_srbb_d[l_ac].srbb007 TO srbb007              #

            NEXT FIELD srbb007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb008
            #add-point:ON ACTION controlp INFIELD srbb008 name="input.c.page1.srbb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb009
            #add-point:ON ACTION controlp INFIELD srbb009 name="input.c.page1.srbb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_num
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_num
            #add-point:ON ACTION controlp INFIELD l_num name="input.c.page1.l_num"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_num1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_num1
            #add-point:ON ACTION controlp INFIELD l_num1 name="input.c.page1.l_num1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb010
            #add-point:ON ACTION controlp INFIELD srbb010 name="input.c.page1.srbb010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srbb_d[l_ac].srbb010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_srbb_d[l_ac].srbb010 = g_qryparam.return1              

            DISPLAY g_srbb_d[l_ac].srbb010 TO srbb010              #

            NEXT FIELD srbb010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb011
            #add-point:ON ACTION controlp INFIELD srbb011 name="input.c.page1.srbb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb012
            #add-point:ON ACTION controlp INFIELD srbb012 name="input.c.page1.srbb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_num2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_num2
            #add-point:ON ACTION controlp INFIELD l_num2 name="input.c.page1.l_num2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_num3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_num3
            #add-point:ON ACTION controlp INFIELD l_num3 name="input.c.page1.l_num3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbbsite
            #add-point:ON ACTION controlp INFIELD srbbsite name="input.c.page1.srbbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb003
            #add-point:ON ACTION controlp INFIELD srbb003 name="input.c.page1.srbb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srbb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbb004
            #add-point:ON ACTION controlp INFIELD srbb004 name="input.c.page1.srbb004"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_srbb_d[l_ac].* = g_srbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt350_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_srbb_d[l_ac].srbbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_srbb_d[l_ac].* = g_srbb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF NOT asrt350_chk_srbb(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srba_m.srba005,g_srba_m.srba006,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007,g_srbb_d[l_ac].srbb009,g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb012) THEN
                #  LET g_srbb_d[l_ac].* = g_srbb_d_t.*
                  CLOSE asrt350_bcl
                  CALL s_transaction_end('N','0')
                  IF g_flag3 = 'Y' THEN
                     NEXT FIELD srbb001
                  END IF
                  IF g_flag4 = 'Y' THEN
                     NEXT FIELD srbb012
                  END IF
               END IF
               IF cl_null(g_srbb_d[l_ac].srbb002) THEN
                  LET g_srbb_d[l_ac].srbb002 = ' '
               END IF
               IF cl_null(g_srbb_d[l_ac].srbb004) THEN
                  LET g_srbb_d[l_ac].srbb004 = ' '
               END IF
               IF cl_null(g_srbb_d[l_ac].srbb005) THEN
                  LET g_srbb_d[l_ac].srbb005 = ' '
               END IF
               IF cl_null(g_srbb_d[l_ac].srbb006) THEN
                  LET g_srbb_d[l_ac].srbb006 = ' '
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL asrt350_srbb_t_mask_restore('restore_mask_o')
      
               UPDATE srbb_t SET (srbbdocno,srbbseq,srbb001,srbb002,srbb005,srbb006,srbb007,srbb008, 
                   srbb009,srbb010,srbb011,srbb012,srbbsite,srbb003,srbb004) = (g_srba_m.srbadocno,g_srbb_d[l_ac].srbbseq, 
                   g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb002,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006, 
                   g_srbb_d[l_ac].srbb007,g_srbb_d[l_ac].srbb008,g_srbb_d[l_ac].srbb009,g_srbb_d[l_ac].srbb010, 
                   g_srbb_d[l_ac].srbb011,g_srbb_d[l_ac].srbb012,g_srbb_d[l_ac].srbbsite,g_srbb_d[l_ac].srbb003, 
                   g_srbb_d[l_ac].srbb004)
                WHERE srbbent = g_enterprise AND srbbdocno = g_srba_m.srbadocno 
 
                  AND srbbseq = g_srbb_d_t.srbbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_srbb_d[l_ac].* = g_srbb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_srbb_d[l_ac].* = g_srbb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srba_m.srbadocno
               LET gs_keys_bak[1] = g_srbadocno_t
               LET gs_keys[2] = g_srbb_d[g_detail_idx].srbbseq
               LET gs_keys_bak[2] = g_srbb_d_t.srbbseq
               CALL asrt350_update_b('srbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL asrt350_srbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_srbb_d[g_detail_idx].srbbseq = g_srbb_d_t.srbbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_srba_m.srbadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_srbb_d_t.srbbseq
 
                  CALL asrt350_key_update_b(gs_keys,'srbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_srba_m),util.JSON.stringify(g_srbb_d_t)
               LET g_log2 = util.JSON.stringify(g_srba_m),util.JSON.stringify(g_srbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL asrt350_unlock_b("srbb_t","'1'")
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
               LET g_srbb_d[li_reproduce_target].* = g_srbb_d[li_reproduce].*
 
               LET g_srbb_d[li_reproduce_target].srbbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_srbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_srbb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_srbb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_srbb3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asrt350_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_srbb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            LET g_srab002 = YEAR(g_srba_m.srbadocdt)
            LET g_srab003 = MONTH(g_srba_m.srbadocdt)
            #取出目前"已确认"的最大版本号
            SELECT MAX(sraa000) INTO g_srab000 FROM sraa_t
             WHERE sraaent  = g_enterprise
               AND sraasite = g_site
               AND sraa001  = g_srba_m.srba003
               AND sraa002  = g_srab002
               AND sraa003  = g_srab003
               AND sraastus = 'Y'
            IF cl_null(g_srab000) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asr-00048'
               LET g_errparam.extend = g_srba_m.srba003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT DIALOG
            END IF
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_srbb3_d[l_ac].* TO NULL 
            INITIALIZE g_srbb3_d_t.* TO NULL 
            INITIALIZE g_srbb3_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_srbb3_d[l_ac].srbc007 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_srbb3_d_t.* = g_srbb3_d[l_ac].*     #新輸入資料
            LET g_srbb3_d_o.* = g_srbb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt350_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            #项次预设盘点资料中项次最小的 且存在差异数量的
            SELECT MIN(srbbseq) INTO g_srbb3_d[l_ac].srbcseq FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site
               AND srbbdocno=g_srba_m.srbadocno AND srbb008 IS NOT NULL AND srbb009 IS NOT NULL AND srbb008 != srbb009
            IF cl_null(g_srbb3_d[l_ac].srbcseq) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asr-00042'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT DIALOG
            END IF               
            SELECT MAX(srbcseq1)+1 INTO g_srbb3_d[l_ac].srbcseq1 FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site
               AND srbcdocno=g_srba_m.srbadocno AND srbcseq=g_srbb3_d[l_ac].srbcseq
            IF cl_null(g_srbb3_d[l_ac].srbcseq1) THEN
               LET g_srbb3_d[l_ac].srbcseq1 = 1
            END IF       
            LET g_srbb3_d[l_ac].srbcsite = g_site 
            CALL asrt350_b_srbc_desc()            
            #end add-point
            CALL asrt350_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_srbb3_d[li_reproduce_target].* = g_srbb3_d[li_reproduce].*
 
               LET g_srbb3_d[li_reproduce_target].srbcseq = NULL
               LET g_srbb3_d[li_reproduce_target].srbcseq1 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
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
            OPEN asrt350_cl USING g_enterprise,g_srba_m.srbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt350_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt350_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_srbb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_srbb3_d[l_ac].srbcseq IS NOT NULL
               AND g_srbb3_d[l_ac].srbcseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_srbb3_d_t.* = g_srbb3_d[l_ac].*  #BACKUP
               LET g_srbb3_d_o.* = g_srbb3_d[l_ac].*  #BACKUP
               CALL asrt350_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL asrt350_set_no_entry_b(l_cmd)
               IF NOT asrt350_lock_b("srbc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt350_bcl2 INTO g_srbb3_d[l_ac].srbcseq,g_srbb3_d[l_ac].srbcseq1,g_srbb3_d[l_ac].srbc001, 
                      g_srbb3_d[l_ac].srbc002,g_srbb3_d[l_ac].srbc003,g_srbb3_d[l_ac].srbc007,g_srbb3_d[l_ac].srbc004, 
                      g_srbb3_d[l_ac].srbc005,g_srbb3_d[l_ac].srbc006,g_srbb3_d[l_ac].srbcsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_srbb3_d_mask_o[l_ac].* =  g_srbb3_d[l_ac].*
                  CALL asrt350_srbc_t_mask()
                  LET g_srbb3_d_mask_n[l_ac].* =  g_srbb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asrt350_show()
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
               
               #add-point:單身2刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_srba_m.srbadocno
               LET gs_keys[gs_keys.getLength()+1] = g_srbb3_d_t.srbcseq
               LET gs_keys[gs_keys.getLength()+1] = g_srbb3_d_t.srbcseq1
            
               #刪除同層單身
               IF NOT asrt350_delete_b('srbc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt350_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asrt350_key_delete_b(gs_keys,'srbc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt350_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE asrt350_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_srbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_srbb3_d.getLength() + 1) THEN
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
               
            #add-point:單身2新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM srbc_t 
             WHERE srbcent = g_enterprise AND srbcdocno = g_srba_m.srbadocno
               AND srbcseq = g_srbb3_d[l_ac].srbcseq
               AND srbcseq1 = g_srbb3_d[l_ac].srbcseq1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srba_m.srbadocno
               LET gs_keys[2] = g_srbb3_d[g_detail_idx].srbcseq
               LET gs_keys[3] = g_srbb3_d[g_detail_idx].srbcseq1
               CALL asrt350_insert_b('srbc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_srbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "srbc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asrt350_b_fill()
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
               LET g_srbb3_d[l_ac].* = g_srbb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt350_bcl2
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
               LET g_srbb3_d[l_ac].* = g_srbb3_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL asrt350_srbc_t_mask_restore('restore_mask_o')
                              
               UPDATE srbc_t SET (srbcdocno,srbcseq,srbcseq1,srbc001,srbc002,srbc003,srbc007,srbc004, 
                   srbc005,srbc006,srbcsite) = (g_srba_m.srbadocno,g_srbb3_d[l_ac].srbcseq,g_srbb3_d[l_ac].srbcseq1, 
                   g_srbb3_d[l_ac].srbc001,g_srbb3_d[l_ac].srbc002,g_srbb3_d[l_ac].srbc003,g_srbb3_d[l_ac].srbc007, 
                   g_srbb3_d[l_ac].srbc004,g_srbb3_d[l_ac].srbc005,g_srbb3_d[l_ac].srbc006,g_srbb3_d[l_ac].srbcsite)  
                   #自訂欄位頁簽
                WHERE srbcent = g_enterprise AND srbcdocno = g_srba_m.srbadocno
                  AND srbcseq = g_srbb3_d_t.srbcseq #項次 
                  AND srbcseq1 = g_srbb3_d_t.srbcseq1
                  
               #add-point:單身page2修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_srbb3_d[l_ac].* = g_srbb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srbc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_srbb3_d[l_ac].* = g_srbb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srbc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srba_m.srbadocno
               LET gs_keys_bak[1] = g_srbadocno_t
               LET gs_keys[2] = g_srbb3_d[g_detail_idx].srbcseq
               LET gs_keys_bak[2] = g_srbb3_d_t.srbcseq
               LET gs_keys[3] = g_srbb3_d[g_detail_idx].srbcseq1
               LET gs_keys_bak[3] = g_srbb3_d_t.srbcseq1
               CALL asrt350_update_b('srbc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asrt350_srbc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_srbb3_d[g_detail_idx].srbcseq = g_srbb3_d_t.srbcseq 
                  AND g_srbb3_d[g_detail_idx].srbcseq1 = g_srbb3_d_t.srbcseq1 
                  ) THEN
                  LET gs_keys[01] = g_srba_m.srbadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_srbb3_d_t.srbcseq
                  LET gs_keys[gs_keys.getLength()+1] = g_srbb3_d_t.srbcseq1
                  CALL asrt350_key_update_b(gs_keys,'srbc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_srba_m),util.JSON.stringify(g_srbb3_d_t)
               LET g_log2 = util.JSON.stringify(g_srba_m),util.JSON.stringify(g_srbb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbcseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_srbb3_d[l_ac].srbcseq,"1","1","","","azz-00079",1) THEN
               NEXT FIELD srbcseq
            END IF 
 
 
 
            #add-point:AFTER FIELD srbcseq name="input.a.page3.srbcseq"
            #此段落由子樣板a05產生
            IF  g_srba_m.srbadocno IS NOT NULL AND g_srbb3_d[g_detail_idx].srbcseq IS NOT NULL AND g_srbb3_d[g_detail_idx].srbcseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_srba_m.srbadocno != g_srbadocno_t OR g_srbb3_d[g_detail_idx].srbcseq != g_srbb3_d_t.srbcseq OR g_srbb3_d[g_detail_idx].srbcseq1 != g_srbb3_d_t.srbcseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srbc_t WHERE "||"srbcent = '" ||g_enterprise|| "' AND "||"srbcdocno = '"||g_srba_m.srbadocno ||"' AND "|| "srbcseq = '"||g_srbb3_d[g_detail_idx].srbcseq ||"' AND "|| "srbcseq1 = '"||g_srbb3_d[g_detail_idx].srbcseq1 ||"'",'std-00004',0) THEN 
                     LET g_srbb3_d[g_detail_idx].srbcseq = g_srbb3_d_t.srbcseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_srbb3_d[l_ac].srbcseq) AND  (cl_null(g_srbb3_d_t.srbcseq) OR g_srbb3_d[l_ac].srbcseq != g_srbb3_d_t.srbcseq) THEN
               SELECT COUNT(*) INTO l_n FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site
                  AND srbbdocno=g_srba_m.srbadocno AND srbb008 IS NOT NULL AND srbb009 IS NOT NULL AND srbb008 != srbb009
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asr-00043'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_srbb3_d[l_ac].srbcseq = g_srbb3_d_t.srbcseq
                  NEXT FIELD CURRENT
               END IF
               CALL asrt350_srbcseq()
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbcseq
            #add-point:BEFORE FIELD srbcseq name="input.b.page3.srbcseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbcseq
            #add-point:ON CHANGE srbcseq name="input.g.page3.srbcseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbcseq1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_srbb3_d[l_ac].srbcseq1,"0","1","","","azz-00079",1) THEN
               NEXT FIELD srbcseq1
            END IF 
 
 
 
            #add-point:AFTER FIELD srbcseq1 name="input.a.page3.srbcseq1"
            #此段落由子樣板a05產生
            IF  g_srba_m.srbadocno IS NOT NULL AND g_srbb3_d[g_detail_idx].srbcseq IS NOT NULL AND g_srbb3_d[g_detail_idx].srbcseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_srba_m.srbadocno != g_srbadocno_t OR g_srbb3_d[g_detail_idx].srbcseq != g_srbb3_d_t.srbcseq OR g_srbb3_d[g_detail_idx].srbcseq1 != g_srbb3_d_t.srbcseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srbc_t WHERE "||"srbcent = '" ||g_enterprise|| "' AND "||"srbcdocno = '"||g_srba_m.srbadocno ||"' AND "|| "srbcseq = '"||g_srbb3_d[g_detail_idx].srbcseq ||"' AND "|| "srbcseq1 = '"||g_srbb3_d[g_detail_idx].srbcseq1 ||"'",'std-00004',0) THEN 
                     LET g_srbb3_d[l_ac].srbcseq1 = g_srbb3_d_t.srbcseq1
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbcseq1
            #add-point:BEFORE FIELD srbcseq1 name="input.b.page3.srbcseq1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbcseq1
            #add-point:ON CHANGE srbcseq1 name="input.g.page3.srbcseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc001
            
            #add-point:AFTER FIELD srbc001 name="input.a.page3.srbc001"
            IF NOT cl_null(g_srbb3_d[l_ac].srbc001) AND (cl_null(g_srbb3_d_t.srbc001) OR g_srbb3_d[l_ac].srbc001 != g_srbb3_d_t.srbc001) THEN
               IF NOT asrt350_chk_srbc001() THEN
                  LET g_srbb3_d[l_ac].srbc001 = g_srbb3_d_t.srbc001
                  NEXT FIELD CURRENT
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc001
            #add-point:BEFORE FIELD srbc001 name="input.b.page3.srbc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbc001
            #add-point:ON CHANGE srbc001 name="input.g.page3.srbc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc002
            #add-point:BEFORE FIELD srbc002 name="input.b.page3.srbc002"
          
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc002
            
            #add-point:AFTER FIELD srbc002 name="input.a.page3.srbc002"
            IF cl_null(g_srbb3_d[l_ac].srbc002) THEN
               LET g_srbb3_d[l_ac].srbc002 = ' '
            END IF               
            IF g_srbb3_d[l_ac].srbc002 IS NOT NULL AND (g_srbb3_d_t.srbc002 IS NULL OR g_srbb3_d[l_ac].srbc002 != g_srbb3_d_t.srbc002) THEN
               IF NOT asrt350_chk_srbc001() THEN
                  LET g_srbb3_d[l_ac].srbc002 = g_srbb3_d_t.srbc002
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbc002
            #add-point:ON CHANGE srbc002 name="input.g.page3.srbc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc003
            #add-point:BEFORE FIELD srbc003 name="input.b.page3.srbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc003
            
            #add-point:AFTER FIELD srbc003 name="input.a.page3.srbc003"
            IF cl_null(g_srbb3_d[l_ac].srbc003) THEN
               LET g_srbb3_d[l_ac].srbc003 = ' '
            END IF               
            IF g_srbb3_d[l_ac].srbc003 IS NOT NULL AND (g_srbb3_d_t.srbc003 IS NULL OR g_srbb3_d[l_ac].srbc003 != g_srbb3_d_t.srbc003) THEN
               IF NOT asrt350_chk_srbc001() THEN
                  LET g_srbb3_d[l_ac].srbc003 = g_srbb3_d_t.srbc003
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbc003
            #add-point:ON CHANGE srbc003 name="input.g.page3.srbc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc007
            #add-point:BEFORE FIELD srbc007 name="input.b.page3.srbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc007
            
            #add-point:AFTER FIELD srbc007 name="input.a.page3.srbc007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbc007
            #add-point:ON CHANGE srbc007 name="input.g.page3.srbc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc004
            #add-point:BEFORE FIELD srbc004 name="input.b.page3.srbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc004
            
            #add-point:AFTER FIELD srbc004 name="input.a.page3.srbc004"
            IF NOT cl_null(g_srbb3_d[l_ac].srbc004) AND (cl_null(g_srbb3_d_t.srbc004) OR g_srbb3_d[l_ac].srbc004 != g_srbb3_d_t.srbc004) THEN
               IF NOT asrt350_chk_srbc004() THEN
                  LET g_srbb3_d[l_ac].srbc004 = g_srbb3_d_t.srbc004
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbc004
            #add-point:ON CHANGE srbc004 name="input.g.page3.srbc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc005
            #add-point:BEFORE FIELD srbc005 name="input.b.page3.srbc005"
            CALL cl_set_comp_entry("srbc005",TRUE)
            SELECT srbb012 INTO l_srbb012 FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site
               AND srbbdocno=g_srba_m.srbadocno AND srbbseq=g_srbb3_d[l_ac].srbcseq 
            IF cl_null(l_srbb012) THEN
               CALL cl_set_comp_entry("srbc005",FALSE)
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc005
            
            #add-point:AFTER FIELD srbc005 name="input.a.page3.srbc005"
            IF NOT cl_null(g_srbb3_d[l_ac].srbc005) AND (cl_null(g_srbb3_d_t.srbc005) OR g_srbb3_d[l_ac].srbc005 != g_srbb3_d_t.srbc005) THEN
               IF NOT asrt350_chk_srbc005() THEN
                  LET g_srbb3_d[l_ac].srbc005 = g_srbb3_d_t.srbc005
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbc005
            #add-point:ON CHANGE srbc005 name="input.g.page3.srbc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbc006
            #add-point:BEFORE FIELD srbc006 name="input.b.page3.srbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbc006
            
            #add-point:AFTER FIELD srbc006 name="input.a.page3.srbc006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbc006
            #add-point:ON CHANGE srbc006 name="input.g.page3.srbc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srbcsite
            #add-point:BEFORE FIELD srbcsite name="input.b.page3.srbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srbcsite
            
            #add-point:AFTER FIELD srbcsite name="input.a.page3.srbcsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srbcsite
            #add-point:ON CHANGE srbcsite name="input.g.page3.srbcsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.srbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbcseq
            #add-point:ON ACTION controlp INFIELD srbcseq name="input.c.page3.srbcseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbcseq1
            #add-point:ON ACTION controlp INFIELD srbcseq1 name="input.c.page3.srbcseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc001
            #add-point:ON ACTION controlp INFIELD srbc001 name="input.c.page3.srbc001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srbb3_d[l_ac].srbc001             #給予default值
            #給予arg
            LET g_qryparam.where = " srab002=",g_srab002," AND srab003=",g_srab003," AND srab001='",g_srba_m.srba003,"' AND srab000=",g_srab000            
            CALL q_srab004()                                #呼叫開窗
            LET g_srbb3_d[l_ac].srbc001 = g_qryparam.return1  
            LET g_srbb3_d[l_ac].srbc002 = g_qryparam.return2
            LET g_srbb3_d[l_ac].srbc003 = g_qryparam.return3            
            DISPLAY g_srbb3_d[l_ac].srbc001 TO srbc001              #
            DISPLAY g_srbb3_d[l_ac].srbc002 TO srbc002
            DISPLAY g_srbb3_d[l_ac].srbc003 TO srbc003
            NEXT FIELD srbc001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc002
            #add-point:ON ACTION controlp INFIELD srbc002 name="input.c.page3.srbc002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srbb3_d[l_ac].srbc002             #給予default值
            #給予arg
            LET g_qryparam.where = " srab002=",g_srab002," AND srab003=",g_srab003," AND srab001='",g_srba_m.srba003,"' AND srab000=",g_srab000           
            CALL q_srab004()                                #呼叫開窗
            LET g_srbb3_d[l_ac].srbc001 = g_qryparam.return1  
            LET g_srbb3_d[l_ac].srbc002 = g_qryparam.return2
            LET g_srbb3_d[l_ac].srbc003 = g_qryparam.return3            
            DISPLAY g_srbb3_d[l_ac].srbc001 TO srbc001              #
            DISPLAY g_srbb3_d[l_ac].srbc002 TO srbc002
            DISPLAY g_srbb3_d[l_ac].srbc003 TO srbc003
            NEXT FIELD srbc002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc003
            #add-point:ON ACTION controlp INFIELD srbc003 name="input.c.page3.srbc003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srbb3_d[l_ac].srbc003             #給予default值
            #給予arg
            LET g_qryparam.where = " srab002=",g_srab002," AND srab003=",g_srab003," AND srab001='",g_srba_m.srba003,"' AND srab000=",g_srab000          
            CALL q_srab004()                                #呼叫開窗
            LET g_srbb3_d[l_ac].srbc001 = g_qryparam.return1  
            LET g_srbb3_d[l_ac].srbc002 = g_qryparam.return2
            LET g_srbb3_d[l_ac].srbc003 = g_qryparam.return3            
            DISPLAY g_srbb3_d[l_ac].srbc001 TO srbc001              #
            DISPLAY g_srbb3_d[l_ac].srbc002 TO srbc002
            DISPLAY g_srbb3_d[l_ac].srbc003 TO srbc003
            NEXT FIELD srbc003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc007
            #add-point:ON ACTION controlp INFIELD srbc007 name="input.c.page3.srbc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc004
            #add-point:ON ACTION controlp INFIELD srbc004 name="input.c.page3.srbc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc005
            #add-point:ON ACTION controlp INFIELD srbc005 name="input.c.page3.srbc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbc006
            #add-point:ON ACTION controlp INFIELD srbc006 name="input.c.page3.srbc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srbcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srbcsite
            #add-point:ON ACTION controlp INFIELD srbcsite name="input.c.page3.srbcsite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_srbb3_d[l_ac].* = g_srbb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt350_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL asrt350_unlock_b("srbc_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_srbb3_d[li_reproduce_target].* = g_srbb3_d[li_reproduce].*
 
               LET g_srbb3_d[li_reproduce_target].srbcseq = NULL
               LET g_srbb3_d[li_reproduce_target].srbcseq1 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_srbb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_srbb3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="asrt350.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         LET g_flag2 = 'Y'
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD srbadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD srbbseq
               WHEN "s_detail3"
                  NEXT FIELD srbcseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
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
 
{<section id="asrt350.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION asrt350_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success   LIKE type_t.num5                 
   DEFINE l_slip      STRING
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL asrt350_b_fill() #單身填充
      CALL asrt350_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL asrt350_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

            IF NOT cl_null(g_srba_m.srbadocno) THEN
               CALL s_aooi200_get_slip(g_srba_m.srbadocno) RETURNING l_success,l_slip
               CALL s_aooi200_get_slip_desc(l_slip) RETURNING g_srba_m.oobxl003
               DISPLAY BY NAME g_srba_m.oobxl003
            END IF
   #        INITIALIZE g_ref_fields TO NULL
   #        LET g_ref_fields[1] = g_srba_m.srbaownid
   #        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #        LET g_srba_m.srbaownid_desc = '', g_rtn_fields[1] , ''
   #        DISPLAY BY NAME g_srba_m.srbaownid_desc
   #
   #        INITIALIZE g_ref_fields TO NULL
   #        LET g_ref_fields[1] = g_srba_m.srbaowndp
   #        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #        LET g_srba_m.srbaowndp_desc = '', g_rtn_fields[1] , ''
   #        DISPLAY BY NAME g_srba_m.srbaowndp_desc
   #
   #        INITIALIZE g_ref_fields TO NULL
   #        LET g_ref_fields[1] = g_srba_m.srbacrtid
   #        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #        LET g_srba_m.srbacrtid_desc = '', g_rtn_fields[1] , ''
   #        DISPLAY BY NAME g_srba_m.srbacrtid_desc
   #
   #        INITIALIZE g_ref_fields TO NULL
   #        LET g_ref_fields[1] = g_srba_m.srbacrtdp
   #        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #        LET g_srba_m.srbacrtdp_desc = '', g_rtn_fields[1] , ''
   #        DISPLAY BY NAME g_srba_m.srbacrtdp_desc
   #
   #        INITIALIZE g_ref_fields TO NULL
   #        LET g_ref_fields[1] = g_srba_m.srbamodid
   #        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #        LET g_srba_m.srbamodid_desc = '', g_rtn_fields[1] , ''
   #        DISPLAY BY NAME g_srba_m.srbamodid_desc
   #
   #        INITIALIZE g_ref_fields TO NULL
   #        LET g_ref_fields[1] = g_srba_m.srbacnfid
   #        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   #        LET g_srba_m.srbacnfid_desc = '', g_rtn_fields[1] , ''
   #        DISPLAY BY NAME g_srba_m.srbacnfid_desc

        #   INITIALIZE g_ref_fields TO NULL
        #   LET g_ref_fields[1] = g_srba_m.srbapstid
        #   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
        #   LET g_srba_m.srbapstid_desc = '', g_rtn_fields[1] , ''
        #   DISPLAY BY NAME g_srba_m.srbapstid_desc
         
            CALL asrt350_desc()
   #end add-point
   
   #遮罩相關處理
   LET g_srba_m_mask_o.* =  g_srba_m.*
   CALL asrt350_srba_t_mask()
   LET g_srba_m_mask_n.* =  g_srba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.oobxl003,g_srba_m.srbadocdt,g_srba_m.srba001, 
       g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba003_desc,g_srba_m.srba004,g_srba_m.srba005,g_srba_m.srba005_desc, 
       g_srba_m.srba006,g_srba_m.srba006_desc,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaownid_desc, 
       g_srba_m.srbaowndp,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid,g_srba_m.srbacrtid_desc,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamodid_desc,g_srba_m.srbamoddt, 
       g_srba_m.srbacnfid,g_srba_m.srbacnfid_desc,g_srba_m.srbacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_srba_m.srbastus 
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
   FOR l_ac = 1 TO g_srbb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      IF cl_null(g_srbb_d[l_ac].srbb009) THEN
         LET g_srbb_d[l_ac].l_num = ''
         LET g_srbb_d[l_ac].l_num1 = ''
      ELSE
         LET g_srbb_d[l_ac].l_num = g_srbb_d[l_ac].srbb008 - g_srbb_d[l_ac].srbb009
         SELECT SUM(srbc004) INTO g_srbb_d[l_ac].l_num1 FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site 
            AND srbcdocno=g_srba_m.srbadocno AND srbcseq=g_srbb_d[l_ac].srbbseq
         IF cl_null(g_srbb_d[l_ac].l_num1) THEN
            LET g_srbb_d[l_ac].l_num1 = 0
         END IF
      END IF
      IF cl_null(g_srbb_d[l_ac].srbb012) THEN
         LET g_srbb_d[l_ac].l_num2 = ''
         LET g_srbb_d[l_ac].l_num3 = ''
      ELSE
         LET g_srbb_d[l_ac].l_num2 = g_srbb_d[l_ac].srbb011 - g_srbb_d[l_ac].srbb012
         SELECT SUM(srbc005) INTO g_srbb_d[l_ac].l_num3 FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site 
            AND srbcdocno=g_srba_m.srbadocno AND srbcseq=g_srbb_d[l_ac].srbbseq
         IF cl_null(g_srbb_d[l_ac].l_num3) THEN
            LET g_srbb_d[l_ac].l_num3 = 0
         END IF
      END IF
         
    #  CALL asrt350_b_desc()

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_srbb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      CALL asrt350_b_srbc_desc()
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   FOR l_ac = 1 TO g_srbb2_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
      CALL s_desc_get_item_desc(g_srbb2_d[l_ac].inao001)
           RETURNING g_srbb2_d[l_ac].inao001_desc,g_srbb2_d[l_ac].inao001_desc_1
      DISPLAY BY NAME g_srbb2_d[l_ac].inao001_desc,g_srbb2_d[l_ac].inao001_desc_1
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_srbb4_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
      CALL s_desc_get_item_desc(g_srbb4_d[l_ac].inao001_4)
           RETURNING g_srbb4_d[l_ac].inao001_4_desc,g_srbb4_d[l_ac].inao001_4_desc_1
      DISPLAY BY NAME g_srbb4_d[l_ac].inao001_4_desc,g_srbb4_d[l_ac].inao001_4_desc_1
      #end add-point
   END FOR
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL asrt350_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION asrt350_detail_show()
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
 
{<section id="asrt350.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION asrt350_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE srba_t.srbadocno 
   DEFINE l_oldno     LIKE srba_t.srbadocno 
 
   DEFINE l_master    RECORD LIKE srba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE srbb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE srbc_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_srba_m.srbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_srbadocno_t = g_srba_m.srbadocno
 
    
   LET g_srba_m.srbadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_srba_m.srbaownid = g_user
      LET g_srba_m.srbaowndp = g_dept
      LET g_srba_m.srbacrtid = g_user
      LET g_srba_m.srbacrtdp = g_dept 
      LET g_srba_m.srbacrtdt = cl_get_current()
      LET g_srba_m.srbamodid = g_user
      LET g_srba_m.srbamoddt = cl_get_current()
      LET g_srba_m.srbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_srba_m.srbastus = 'N'
   LET g_srba_m.srbacnfid = ''
   LET g_srba_m.srbacnfdt = ''
   LET g_srba_m.srbasite = g_site
   LET g_srba_m.srbadocdt = g_today 
   CALL s_date_get_first_date(g_today) RETURNING g_srba_m.srba001
   LET g_srba_m.srba002 = g_today
   
   CALL g_srbb3_d.clear()
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_srba_m.srbastus 
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
   
   
   CALL asrt350_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_srba_m.* TO NULL
      INITIALIZE g_srbb_d TO NULL
      INITIALIZE g_srbb3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL asrt350_show()
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
   CALL asrt350_set_act_visible()   
   CALL asrt350_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_srbadocno_t = g_srba_m.srbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " srbaent = " ||g_enterprise|| " AND",
                      " srbadocno = '", g_srba_m.srbadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asrt350_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL asrt350_idx_chk()
   
   LET g_data_owner = g_srba_m.srbaownid      
   LET g_data_dept  = g_srba_m.srbaowndp
   
   #功能已完成,通報訊息中心
   CALL asrt350_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="asrt350.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION asrt350_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE srbb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE srbc_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_n        LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE asrt350_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   #复制时应重新根据单头资料产生盘点资料，且分摊明细页签资料清空
   SELECT COUNT(*) INTO l_n FROM srbb_t WHERE srbbent = g_enterprise AND srbbdocno = g_srba_m.srbadocno
   IF l_n > 0 THEN
      RETURN
   END IF  
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM srbb_t
    WHERE srbbent = g_enterprise AND srbbdocno = g_srbadocno_t
 
    INTO TEMP asrt350_detail
 
   #將key修正為調整後   
   UPDATE asrt350_detail 
      #更新key欄位
      SET srbbdocno = g_srba_m.srbadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO srbb_t SELECT * FROM asrt350_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   #根据最新的srbb单身资料抓取最新的数量，并清空盘点数量
   CALL asrt350_reproduce_upd() 
   RETURN        #复制时分摊明细页签资料清空
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE asrt350_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM srbc_t 
    WHERE srbcent = g_enterprise AND srbcdocno = g_srbadocno_t
 
    INTO TEMP asrt350_detail
 
   #將key修正為調整後   
   UPDATE asrt350_detail SET srbcdocno = g_srba_m.srbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO srbc_t SELECT * FROM asrt350_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE asrt350_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_srbadocno_t = g_srba_m.srbadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asrt350_delete()
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
   
   IF g_srba_m.srbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN asrt350_cl USING g_enterprise,g_srba_m.srbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt350_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asrt350_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asrt350_master_referesh USING g_srba_m.srbadocno INTO g_srba_m.srbasite,g_srba_m.srbadocno, 
       g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005, 
       g_srba_m.srba006,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfdt, 
       g_srba_m.srba003_desc,g_srba_m.srbaownid_desc,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid_desc, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbamodid_desc,g_srba_m.srbacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT asrt350_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_srba_m_mask_o.* =  g_srba_m.*
   CALL asrt350_srba_t_mask()
   LET g_srba_m_mask_n.* =  g_srba_m.*
   
   CALL asrt350_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   IF g_srba_m.srbastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00034'
      LET g_errparam.extend = g_srba_m.srbastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE asrt350_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asrt350_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_srbadocno_t = g_srba_m.srbadocno
 
 
      DELETE FROM srba_t
       WHERE srbaent = g_enterprise AND srbadocno = g_srba_m.srbadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_srba_m.srbadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM srbb_t
       WHERE srbbent = g_enterprise AND srbbdocno = g_srba_m.srbadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srbb_t:",SQLERRMESSAGE 
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
      DELETE FROM srbc_t
       WHERE srbcent = g_enterprise AND
             srbcdocno = g_srba_m.srbadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_srba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE asrt350_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_srbb_d.clear() 
      CALL g_srbb3_d.clear()       
 
     
      CALL asrt350_ui_browser_refresh()  
      #CALL asrt350_ui_headershow()  
      #CALL asrt350_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL asrt350_browser_fill("")
         CALL asrt350_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE asrt350_cl
 
   #功能已完成,通報訊息中心
   CALL asrt350_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="asrt350.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asrt350_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_srbb_d.clear()
   CALL g_srbb3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_srbb2_d.clear()
   CALL g_srbb4_d.clear()
      #判斷是否填充
   IF asrt350_fill_chk(3) THEN
      LET g_sql = "SELECT  UNIQUE inaoseq,inaoseq1,inaoseq2,inao001,'','',inao008,inao009,inao010, 
          inao012 FROM inao_t",   
                  " INNER JOIN srba_t ON srbadocno = inaodocno ",
 
                  "",
                  
                  " WHERE inaoent=? AND inaodocno=?"   
      #add-point:b_fill段sql_before

      #end add-point
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY inao_t.inaoseq,inao_t.inaoseq1,inao_t.inaoseq2"
      
      #add-point:單身填充控制

      #end add-point
      
      PREPARE asrt350_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR asrt350_pb3
      
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_srba_m.srbadocno
 
                                               
      FOREACH b_fill_cs3 INTO g_srbb2_d[l_ac].inaoseq,g_srbb2_d[l_ac].inaoseq1, 
          g_srbb2_d[l_ac].inaoseq2,g_srbb2_d[l_ac].inao001,g_srbb2_d[l_ac].inao001_desc,g_srbb2_d[l_ac].inao001_desc_1, 
          g_srbb2_d[l_ac].inao008,g_srbb2_d[l_ac].inao009,g_srbb2_d[l_ac].inao010,g_srbb2_d[l_ac].inao012 

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
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 

   #end add-point
   
   #判斷是否填充
   IF asrt350_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT srbbseq,srbb001,srbb002,srbb005,srbb006,srbb007,srbb008,srbb009, 
             srbb010,srbb011,srbb012,srbbsite,srbb003,srbb004 ,t1.imaal003 ,t2.oocal003 ,t3.oocal003 FROM srbb_t", 
                
                     " INNER JOIN srba_t ON srbaent = " ||g_enterprise|| " AND srbadocno = srbbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=srbb001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=srbb007 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=srbb010 AND t3.oocal002='"||g_dlang||"' ",
 
                     " WHERE srbbent=? AND srbbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY srbb_t.srbbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asrt350_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR asrt350_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_srba_m.srbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_srba_m.srbadocno INTO g_srbb_d[l_ac].srbbseq,g_srbb_d[l_ac].srbb001, 
          g_srbb_d[l_ac].srbb002,g_srbb_d[l_ac].srbb005,g_srbb_d[l_ac].srbb006,g_srbb_d[l_ac].srbb007, 
          g_srbb_d[l_ac].srbb008,g_srbb_d[l_ac].srbb009,g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb011, 
          g_srbb_d[l_ac].srbb012,g_srbb_d[l_ac].srbbsite,g_srbb_d[l_ac].srbb003,g_srbb_d[l_ac].srbb004, 
          g_srbb_d[l_ac].srbb001_desc,g_srbb_d[l_ac].srbb007_desc,g_srbb_d[l_ac].srbb010_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         IF cl_null(g_srbb_d[l_ac].srbb009) THEN
            LET g_srbb_d[l_ac].l_num = ''
            LET g_srbb_d[l_ac].l_num1 = ''
         ELSE
            LET g_srbb_d[l_ac].l_num = g_srbb_d[l_ac].srbb008 - g_srbb_d[l_ac].srbb009
            SELECT SUM(srbc004) INTO g_srbb_d[l_ac].l_num1 FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site 
               AND srbcdocno=g_srba_m.srbadocno AND srbcseq=g_srbb_d[l_ac].srbbseq
            IF cl_null(g_srbb_d[l_ac].l_num1) THEN
               LET g_srbb_d[l_ac].l_num1 = 0
            END IF
         END IF
         IF cl_null(g_srbb_d[l_ac].srbb012) THEN
            LET g_srbb_d[l_ac].l_num2 = ''
            LET g_srbb_d[l_ac].l_num3 = ''
         ELSE
            LET g_srbb_d[l_ac].l_num2 = g_srbb_d[l_ac].srbb011 - g_srbb_d[l_ac].srbb012
            SELECT SUM(srbc005) INTO g_srbb_d[l_ac].l_num3 FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site 
               AND srbcdocno=g_srba_m.srbadocno AND srbcseq=g_srbb_d[l_ac].srbbseq
            IF cl_null(g_srbb_d[l_ac].l_num3) THEN
               LET g_srbb_d[l_ac].l_num3 = 0
            END IF
         END IF
         CALL asrt350_b_desc()              
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
   IF asrt350_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT srbcseq,srbcseq1,srbc001,srbc002,srbc003,srbc007,srbc004,srbc005, 
             srbc006,srbcsite ,t5.imaal003 FROM srbc_t",   
                     " INNER JOIN  srba_t ON srbaent = " ||g_enterprise|| " AND srbadocno = srbcdocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=srbc001 AND t5.imaal002='"||g_dlang||"' ",
 
                     " WHERE srbcent=? AND srbcdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY srbc_t.srbcseq,srbc_t.srbcseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asrt350_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR asrt350_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_srba_m.srbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_srba_m.srbadocno INTO g_srbb3_d[l_ac].srbcseq,g_srbb3_d[l_ac].srbcseq1, 
          g_srbb3_d[l_ac].srbc001,g_srbb3_d[l_ac].srbc002,g_srbb3_d[l_ac].srbc003,g_srbb3_d[l_ac].srbc007, 
          g_srbb3_d[l_ac].srbc004,g_srbb3_d[l_ac].srbc005,g_srbb3_d[l_ac].srbc006,g_srbb3_d[l_ac].srbcsite, 
          g_srbb3_d[l_ac].srbc001_desc   #(ver:78)
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
   
   CALL g_srbb_d.deleteElement(g_srbb_d.getLength())
   CALL g_srbb3_d.deleteElement(g_srbb3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE asrt350_pb
   FREE asrt350_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_srbb_d.getLength()
      LET g_srbb_d_mask_o[l_ac].* =  g_srbb_d[l_ac].*
      CALL asrt350_srbb_t_mask()
      LET g_srbb_d_mask_n[l_ac].* =  g_srbb_d[l_ac].*
   END FOR
   
   LET g_srbb3_d_mask_o.* =  g_srbb3_d.*
   FOR l_ac = 1 TO g_srbb3_d.getLength()
      LET g_srbb3_d_mask_o[l_ac].* =  g_srbb3_d[l_ac].*
      CALL asrt350_srbc_t_mask()
      LET g_srbb3_d_mask_n[l_ac].* =  g_srbb3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="asrt350.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asrt350_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM srbb_t
       WHERE srbbent = g_enterprise AND
         srbbdocno = ps_keys_bak[1] AND srbbseq = ps_keys_bak[2]
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
         CALL g_srbb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM srbc_t
       WHERE srbcent = g_enterprise AND
             srbcdocno = ps_keys_bak[1] AND srbcseq = ps_keys_bak[2] AND srbcseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_srbb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
      LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point    
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise AND
         inaodocno = ps_keys_bak[1] AND inaoseq = ps_keys_bak[2] AND inaoseq1 = ps_keys_bak[3] AND inaoseq2 = ps_keys_bak[4] AND inao000 = ps_keys_bak[5]
      #add-point:delete_b段刪除中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後

      #end add-point    
   END IF
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asrt350_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO srbb_t
                  (srbbent,
                   srbbdocno,
                   srbbseq
                   ,srbb001,srbb002,srbb005,srbb006,srbb007,srbb008,srbb009,srbb010,srbb011,srbb012,srbbsite,srbb003,srbb004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_srbb_d[g_detail_idx].srbb001,g_srbb_d[g_detail_idx].srbb002,g_srbb_d[g_detail_idx].srbb005, 
                       g_srbb_d[g_detail_idx].srbb006,g_srbb_d[g_detail_idx].srbb007,g_srbb_d[g_detail_idx].srbb008, 
                       g_srbb_d[g_detail_idx].srbb009,g_srbb_d[g_detail_idx].srbb010,g_srbb_d[g_detail_idx].srbb011, 
                       g_srbb_d[g_detail_idx].srbb012,g_srbb_d[g_detail_idx].srbbsite,g_srbb_d[g_detail_idx].srbb003, 
                       g_srbb_d[g_detail_idx].srbb004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_srbb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
 
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO srbc_t
                  (srbcent,
                   srbcdocno,
                   srbcseq,srbcseq1
                   ,srbc001,srbc002,srbc003,srbc007,srbc004,srbc005,srbc006,srbcsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_srbb3_d[g_detail_idx].srbc001,g_srbb3_d[g_detail_idx].srbc002,g_srbb3_d[g_detail_idx].srbc003, 
                       g_srbb3_d[g_detail_idx].srbc007,g_srbb3_d[g_detail_idx].srbc004,g_srbb3_d[g_detail_idx].srbc005, 
                       g_srbb3_d[g_detail_idx].srbc006,g_srbb3_d[g_detail_idx].srbcsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_srbb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
      LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO inao_t
                  (inaoent,
                   inaodocno,
                   inaoseq,inaoseq1,inaoseq2,inao000
                   ,inao001,inao008,inao009,inao010,inao012) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_srbb2_d[g_detail_idx].inao001,g_srbb2_d[g_detail_idx].inao008,g_srbb2_d[g_detail_idx].inao009, 
                       g_srbb2_d[g_detail_idx].inao010,g_srbb2_d[g_detail_idx].inao012)
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asrt350_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "srbb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL asrt350_srbb_t_mask_restore('restore_mask_o')
               
      UPDATE srbb_t 
         SET (srbbdocno,
              srbbseq
              ,srbb001,srbb002,srbb005,srbb006,srbb007,srbb008,srbb009,srbb010,srbb011,srbb012,srbbsite,srbb003,srbb004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_srbb_d[g_detail_idx].srbb001,g_srbb_d[g_detail_idx].srbb002,g_srbb_d[g_detail_idx].srbb005, 
                  g_srbb_d[g_detail_idx].srbb006,g_srbb_d[g_detail_idx].srbb007,g_srbb_d[g_detail_idx].srbb008, 
                  g_srbb_d[g_detail_idx].srbb009,g_srbb_d[g_detail_idx].srbb010,g_srbb_d[g_detail_idx].srbb011, 
                  g_srbb_d[g_detail_idx].srbb012,g_srbb_d[g_detail_idx].srbbsite,g_srbb_d[g_detail_idx].srbb003, 
                  g_srbb_d[g_detail_idx].srbb004) 
         WHERE srbbent = g_enterprise AND srbbdocno = ps_keys_bak[1] AND srbbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asrt350_srbb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "srbc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL asrt350_srbc_t_mask_restore('restore_mask_o')
               
      UPDATE srbc_t 
         SET (srbcdocno,
              srbcseq,srbcseq1
              ,srbc001,srbc002,srbc003,srbc007,srbc004,srbc005,srbc006,srbcsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_srbb3_d[g_detail_idx].srbc001,g_srbb3_d[g_detail_idx].srbc002,g_srbb3_d[g_detail_idx].srbc003, 
                  g_srbb3_d[g_detail_idx].srbc007,g_srbb3_d[g_detail_idx].srbc004,g_srbb3_d[g_detail_idx].srbc005, 
                  g_srbb3_d[g_detail_idx].srbc006,g_srbb3_d[g_detail_idx].srbcsite) 
         WHERE srbcent = g_enterprise AND srbcdocno = ps_keys_bak[1] AND srbcseq = ps_keys_bak[2] AND srbcseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srbc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srbc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asrt350_srbc_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inao_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE inao_t 
         SET (inaodocno,
              inaoseq,inaoseq1,inaoseq2,inao000
              ,inao001,inao008,inao009,inao010,inao012) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_srbb2_d[g_detail_idx].inao001,g_srbb2_d[g_detail_idx].inao008,g_srbb2_d[g_detail_idx].inao009, 
                  g_srbb2_d[g_detail_idx].inao010,g_srbb2_d[g_detail_idx].inao012) 
         WHERE inaoent = g_enterprise AND inaodocno = ps_keys_bak[1] AND inaoseq = ps_keys_bak[2] AND inaoseq1 = ps_keys_bak[3] AND inaoseq2 = ps_keys_bak[4] AND inao000 = ps_keys_bak[5]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "inao_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "inao_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION asrt350_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="asrt350.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION asrt350_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="asrt350.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asrt350_lock_b(ps_table,ps_page)
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
   #CALL asrt350_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "srbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN asrt350_bcl USING g_enterprise,
                                       g_srba_m.srbadocno,g_srbb_d[g_detail_idx].srbbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt350_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "srbc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asrt350_bcl2 USING g_enterprise,
                                             g_srba_m.srbadocno,g_srbb3_d[g_detail_idx].srbcseq,g_srbb3_d[g_detail_idx].srbcseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt350_bcl2:",SQLERRMESSAGE 
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
 
{<section id="asrt350.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asrt350_unlock_b(ps_table,ps_page)
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
      CLOSE asrt350_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE asrt350_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="asrt350.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION asrt350_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("srbadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("srbadocno",TRUE)
      CALL cl_set_comp_entry("srbadocdt",TRUE)
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
 
{<section id="asrt350.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION asrt350_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("srbadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("srbadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("srbadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt350.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asrt350_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("srbb002,srbb005,srbb006,srbb007,srbb012",TRUE)
   CALL cl_set_comp_entry("srbc005",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="asrt350.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asrt350_set_no_entry_b(p_cmd)
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
 
{<section id="asrt350.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION asrt350_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION asrt350_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_srba_m.srbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION asrt350_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION asrt350_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asrt350_default_search()
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
      LET ls_wc = ls_wc, " srbadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "srba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "srbb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "srbc_t" 
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
 
{<section id="asrt350.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION asrt350_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_srba_m.srbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN asrt350_cl USING g_enterprise,g_srba_m.srbadocno
   IF STATUS THEN
      CLOSE asrt350_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt350_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE asrt350_master_referesh USING g_srba_m.srbadocno INTO g_srba_m.srbasite,g_srba_m.srbadocno, 
       g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005, 
       g_srba_m.srba006,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfdt, 
       g_srba_m.srba003_desc,g_srba_m.srbaownid_desc,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid_desc, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbamodid_desc,g_srba_m.srbacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT asrt350_action_chk() THEN
      CLOSE asrt350_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.oobxl003,g_srba_m.srbadocdt,g_srba_m.srba001, 
       g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba003_desc,g_srba_m.srba004,g_srba_m.srba005,g_srba_m.srba005_desc, 
       g_srba_m.srba006,g_srba_m.srba006_desc,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaownid_desc, 
       g_srba_m.srbaowndp,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid,g_srba_m.srbacrtid_desc,g_srba_m.srbacrtdp, 
       g_srba_m.srbacrtdp_desc,g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamodid_desc,g_srba_m.srbamoddt, 
       g_srba_m.srbacnfid,g_srba_m.srbacnfid_desc,g_srba_m.srbacnfdt
 
   CASE g_srba_m.srbastus
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
         CASE g_srba_m.srbastus
            
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
         #160809-00004#1---add---s
         IF g_srba_m.srbastus = 'X' THEN
            CALL s_transaction_end('N','0')   #160816-00068#3 add
            RETURN
         END IF
         
         CALL cl_set_act_visible("signing,withdraw",FALSE)
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
         CASE g_srba_m.srbastus
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
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
           
            WHEN "Y"
               CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
            
            WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
                CALL cl_set_act_visible("withdraw",TRUE)  
                CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            
            WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
                CALL cl_set_act_visible("confirmed ",TRUE)  
                CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)             
         END CASE       
         #160809-00004#1---add---e
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT asrt350_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asrt350_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT asrt350_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asrt350_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
         CALL s_transaction_begin()
         IF NOT s_asrt350_unconfirm(g_srba_m.srbadocno) THEN
            CALL s_transaction_end('N',0)
            RETURN
         END IF
         CALL s_transaction_end('Y',0)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
         CALL s_transaction_begin()
         IF NOT s_asrt350_confirm(g_srba_m.srbadocno) THEN
            CALL s_transaction_end('N',0)
            RETURN
         END IF
         CALL s_transaction_end('Y',0)
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
            #仅当状态为 N.未审核 时,才可以切换为X.作废
            IF g_srba_m.srbastus NOT MATCHES '[N]' THEN
               CALL s_transaction_end('N','0')   #160816-00068#3 add
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
      g_srba_m.srbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE asrt350_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#4 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#4 --- add end   ---
   #end add-point
   
   LET g_srba_m.srbamodid = g_user
   LET g_srba_m.srbamoddt = cl_get_current()
   LET g_srba_m.srbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE srba_t 
      SET (srbastus,srbamodid,srbamoddt) 
        = (g_srba_m.srbastus,g_srba_m.srbamodid,g_srba_m.srbamoddt)     
    WHERE srbaent = g_enterprise AND srbadocno = g_srba_m.srbadocno
 
    
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
      EXECUTE asrt350_master_referesh USING g_srba_m.srbadocno INTO g_srba_m.srbasite,g_srba_m.srbadocno, 
          g_srba_m.srbadocdt,g_srba_m.srba001,g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba004,g_srba_m.srba005, 
          g_srba_m.srba006,g_srba_m.srbastus,g_srba_m.srbaownid,g_srba_m.srbaowndp,g_srba_m.srbacrtid, 
          g_srba_m.srbacrtdp,g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamoddt,g_srba_m.srbacnfid, 
          g_srba_m.srbacnfdt,g_srba_m.srba003_desc,g_srba_m.srbaownid_desc,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid_desc, 
          g_srba_m.srbacrtdp_desc,g_srba_m.srbamodid_desc,g_srba_m.srbacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_srba_m.srbasite,g_srba_m.srbadocno,g_srba_m.oobxl003,g_srba_m.srbadocdt,g_srba_m.srba001, 
          g_srba_m.srba002,g_srba_m.srba003,g_srba_m.srba003_desc,g_srba_m.srba004,g_srba_m.srba005, 
          g_srba_m.srba005_desc,g_srba_m.srba006,g_srba_m.srba006_desc,g_srba_m.srbastus,g_srba_m.srbaownid, 
          g_srba_m.srbaownid_desc,g_srba_m.srbaowndp,g_srba_m.srbaowndp_desc,g_srba_m.srbacrtid,g_srba_m.srbacrtid_desc, 
          g_srba_m.srbacrtdp,g_srba_m.srbacrtdp_desc,g_srba_m.srbacrtdt,g_srba_m.srbamodid,g_srba_m.srbamodid_desc, 
          g_srba_m.srbamoddt,g_srba_m.srbacnfid,g_srba_m.srbacnfid_desc,g_srba_m.srbacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE asrt350_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asrt350_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt350.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION asrt350_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_srbb_d.getLength() THEN
         LET g_detail_idx = g_srbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_srbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_srbb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_srbb3_d.getLength() THEN
         LET g_detail_idx = g_srbb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_srbb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_srbb3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_srbb2_d.getLength() THEN
         LET g_detail_idx = g_srbb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_srbb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_srbb2_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asrt350_b_fill2(pi_idx)
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
   
   CALL asrt350_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION asrt350_fill_chk(ps_idx)
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
 
{<section id="asrt350.status_show" >}
PRIVATE FUNCTION asrt350_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asrt350.mask_functions" >}
&include "erp/asr/asrt350_mask.4gl"
 
{</section>}
 
{<section id="asrt350.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION asrt350_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL asrt350_show()
   CALL asrt350_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_srba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_srbb_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_srbb3_d))
 
 
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
   #CALL asrt350_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL asrt350_ui_headershow()
   CALL asrt350_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION asrt350_draw_out()
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
   CALL asrt350_ui_headershow()  
   CALL asrt350_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="asrt350.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asrt350_set_pk_array()
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
   LET g_pk_array[1].values = g_srba_m.srbadocno
   LET g_pk_array[1].column = 'srbadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt350.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="asrt350.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION asrt350_msgcentre_notify(lc_state)
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
   CALL asrt350_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_srba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt350.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION asrt350_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt350.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 检查料號+產品特徵+庫位+儲位+批號+庫存特徵+单位在同一張盤點單不可重覆; 當盤點數量有維護，且有使用參考單位的参考数量就一定要輸入
# Memo...........:
# Usage..........: CALL asrt350_chk_srbb(p_srbb001,p_srbb002,p_srbb003,p_srbb004,p_srbb005,p_srbb006,p_srbb007)
#                  RETURNING r_success
# Input parameter: 1.p_srbb001           LIKE srbb_t.srbb001
#                : 2.p_srbb002           LIKE srbb_t.srbb002
#                : 3.p_srbb003           LIKE srbb_t.srbb003
#                : 4.p_srbb004           LIKE srbb_t.srbb004
#                : 5.p_srbb005           LIKE srbb_t.srbb005
#                : 6.p_srbb006           LIKE srbb_t.srbb006
#                : 7.p_srbb007           LIKE srbb_t.srbb007
#                : 8.p_srbb009           LIKE srbb_t.srbb009
#                : 9.p_srbb010           LIKE srbb_t.srbb010
#                : 10.p_srbb012           LIKE srbb_t.srbb012
# Return code....: 1.r_success           LIKE type_t.num5
# Date & Author..: 2014/4/9 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt350_chk_srbb(p_srbb001,p_srbb002,p_srbb003,p_srbb004,p_srbb005,p_srbb006,p_srbb007,p_srbb009,p_srbb010,p_srbb012)
DEFINE p_srbb001           LIKE srbb_t.srbb001
DEFINE p_srbb002           LIKE srbb_t.srbb002
DEFINE p_srbb003           LIKE srbb_t.srbb003
DEFINE p_srbb004           LIKE srbb_t.srbb004
DEFINE p_srbb005           LIKE srbb_t.srbb005
DEFINE p_srbb006           LIKE srbb_t.srbb006
DEFINE p_srbb007           LIKE srbb_t.srbb007
DEFINE p_srbb009           LIKE srbb_t.srbb009
DEFINE p_srbb010           LIKE srbb_t.srbb010
DEFINE p_srbb012           LIKE srbb_t.srbb012
DEFINE r_success           LIKE type_t.num5
DEFINE l_sql               STRING
DEFINE l_n                 LIKE type_t.num5

  LET r_success = FALSE
  IF cl_null(p_srbb001) OR cl_null(p_srbb003) OR cl_null(p_srbb007) THEN
     LET r_success = TRUE
     RETURN r_success
  END IF
  IF cl_null(p_srbb002) THEN
     LET p_srbb002 = ' '
  END IF
  IF cl_null(p_srbb004) THEN
     LET p_srbb002 = ' '
  END IF
  IF cl_null(p_srbb005) THEN
     LET p_srbb002 = ' '
  END IF
  IF cl_null(p_srbb006) THEN
     LET p_srbb002 = ' '
  END IF
  LET g_flag3 = 'N'
  LET g_flag4 = 'N'
  IF p_srbb001 != g_srbb_d_t.srbb001 OR p_srbb002 != g_srbb_d_t.srbb002 OR p_srbb005 != g_srbb_d_t.srbb005 OR p_srbb006 != g_srbb_d_t.srbb006 OR p_srbb007 != g_srbb_d_t.srbb007 OR cl_null(g_srbb_d_t.srbb001) THEN 
     LET l_sql = "SELECT COUNT(*) FROM srbb_t WHERE srbbent=",g_enterprise," AND srbbsite='",g_site,"' AND srbbdocno='",g_srba_m.srbadocno,"'",
                 "   AND srbb001='",p_srbb001,"' AND srbb003='",p_srbb003,"' AND srbb007='",p_srbb007,"'",
                 " AND srbb002='",p_srbb002,"' AND srbb004='",p_srbb004,"' AND srbb005='",p_srbb005,"' AND srbb006='",p_srbb006,"'"
     PREPARE asrt350_chk_srbb_pre FROM l_sql
     EXECUTE asrt350_chk_srbb_pre INTO l_n
     IF l_n > 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'asr-00046'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()

        LET g_flag3 = 'Y'
        RETURN r_success
     END IF
  END IF
  
  IF cl_get_para(g_enterprise,g_site,'S-BAS-0028')  = 'Y' THEN
     IF NOT cl_null(p_srbb010) AND NOT cl_null(p_srbb009) AND cl_null(p_srbb012) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'asr-00047'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()

        LET g_flag4 = 'Y'
        RETURN r_success
     END IF
  END IF
  LET r_success = TRUE
  RETURN r_success
END FUNCTION
#检查仓库储位
PRIVATE FUNCTION asrt350_chk_warehouses()
   DEFINE r_success      LIKE type_t.num5

   LET r_success = FALSE

   #1.检查库位基础档
   IF NOT cl_null(g_srba_m.srba005) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_srba_m.srba005
      #160318-00025#22  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
      #160318-00025#22  by 07900 --add-end 
      IF NOT cl_chk_exist("v_inaa001_2") THEN
         RETURN r_success
      END IF
   END IF

   #2.检查储位
   IF NOT cl_null(g_srba_m.srba005) AND g_srba_m.srba006 IS NOT NULL THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_srba_m.srba005
      LET g_chkparam.arg3 = g_srba_m.srba006
      #160318-00025#22  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
      #160318-00025#22  by 07900 --add-end
      IF NOT cl_chk_exist("v_inab002") THEN
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
#单身ref栏位显示
PRIVATE FUNCTION asrt350_b_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srbb_d[l_ac].srbb001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srbb_d[l_ac].srbb001_desc = '', g_rtn_fields[1] , ''
   LET g_srbb_d[l_ac].srbb001_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_srbb_d[l_ac].srbb001_desc,g_srbb_d[l_ac].srbb001_desc_1

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srbb_d[l_ac].srbb007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srbb_d[l_ac].srbb007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srbb_d[l_ac].srbb007_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srbb_d[l_ac].srbb010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srbb_d[l_ac].srbb010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srbb_d[l_ac].srbb010_desc
END FUNCTION

################################################################################
# Descriptions...: 根据料号判断产品特征，批号，库存管理特征开启关闭
# Memo...........:
# Usage..........: CALL asrt350_chk_srbb_entry(p_srbb001)
# Input parameter: 1.p_srbb001    LIKE srbb_t.srbb001
# Date & Author..: 2014/4/9 By wuxj
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt350_chk_srbb_entry(p_srbb001)
DEFINE p_srbb001      LIKE srbb_t.srbb001
DEFINE l_imaa005      LIKE imaa_t.imaa005
DEFINE l_imaf054      LIKE imaf_t.imaf054
DEFINE l_imaf055      LIKE imaf_t.imaf055
DEFINE l_imaf061      LIKE imaf_t.imaf061

   CALL cl_set_comp_entry("srbb002,srbb0005,srbb006,srbb007",TRUE)
   IF cl_null(p_srbb001) THEN
      CALL cl_set_comp_entry("srbb002,srbb0005,srbb006,srbb007",FALSE)
   END IF
   
   IF NOT cl_null(p_srbb001) THEN
      LET l_imaf054 = ''
      LET l_imaf055 = ''
      LET l_imaf061 = ''
      LET l_imaa005 = ''
      LET g_flag1 = 'Y'
      
      SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_srbb001
      IF cl_null(l_imaa005) THEN
         LET g_flag1 = 'N'
         CALL cl_set_comp_entry("srbb002",FALSE)
      END IF
      SELECT imaf054,imaf055,imaf061 INTO l_imaf054,l_imaf055,l_imaf061 FROM imaf_t
       WHERE imafent = g_enterprise AND imafsite = g_site
         AND imaf001 = p_srbb001
      IF l_imaf054 = 'N' OR cl_null(l_imaf054) THEN
         CALL cl_set_comp_entry("srbb007",FALSE)        
      END IF              
      IF l_imaf055 = '2' OR cl_null(l_imaf055) THEN
         CALL cl_set_comp_entry("srbb006",FALSE)
      END IF
      IF l_imaf061 = '2' OR cl_null(l_imaf061) THEN
         CALL cl_set_comp_entry("srbb005",FALSE)
      END IF                                
   END IF 
END FUNCTION
#单身无资料时根据单头的仓库储位整批产生库存明细资料到单身档中
PRIVATE FUNCTION asrt350_gen_fill(p_docno,p_inag004,p_inag005)
DEFINE p_inag004                  LIKE inag_t.inag004
DEFINE p_inag005                  LIKE inag_t.inag005
DEFINE p_docno                    LIKE srbb_t.srbbdocno
DEFINE r_success                  LIKE type_t.num5
DEFINE l_sql                      STRING
#DEFINE l_inag                     RECORD LIKE inag_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_inag RECORD  #庫存明細檔
       inagent LIKE inag_t.inagent, #企业编号
       inagsite LIKE inag_t.inagsite, #营运据点
       inag001 LIKE inag_t.inag001, #料件编号
       inag002 LIKE inag_t.inag002, #产品特征
       inag003 LIKE inag_t.inag003, #库存管理特征
       inag004 LIKE inag_t.inag004, #库位编号
       inag005 LIKE inag_t.inag005, #储位编号
       inag006 LIKE inag_t.inag006, #批号
       inag007 LIKE inag_t.inag007, #库存单位
       inag008 LIKE inag_t.inag008, #账面库存数量
       inag009 LIKE inag_t.inag009, #实际库存数量
       inag010 LIKE inag_t.inag010, #库存可用否
       inag011 LIKE inag_t.inag011, #MRP可用否
       inag012 LIKE inag_t.inag012, #成本库否
       inag013 LIKE inag_t.inag013, #拣货优先序
       inag014 LIKE inag_t.inag014, #最近一次盘点日期
       inag015 LIKE inag_t.inag015, #最后异动日期
       inag016 LIKE inag_t.inag016, #呆滞日期
       inag017 LIKE inag_t.inag017, #第一次入库日期
       inag018 LIKE inag_t.inag018, #No Use
       inag019 LIKE inag_t.inag019, #留置否
       inag020 LIKE inag_t.inag020, #留置原因
       inag021 LIKE inag_t.inag021, #备置数量
       inag022 LIKE inag_t.inag022, #No Use
       inag023 LIKE inag_t.inag023, #Tag二进位码
       inag024 LIKE inag_t.inag024, #参考单位
       inag025 LIKE inag_t.inag025, #参考数量
       inag026 LIKE inag_t.inag026, #最近一次检验日期
       inag027 LIKE inag_t.inag027, #下次检验日期
       inag028 LIKE inag_t.inag028, #留置日期
       inag029 LIKE inag_t.inag029, #留置人员
       inag030 LIKE inag_t.inag030, #留置部门
       inag031 LIKE inag_t.inag031, #留置单号
       inag032 LIKE inag_t.inag032, #基础单位
       inag033 LIKE inag_t.inag033  #基础单位数量
END RECORD
#161124-00048#12 add(e)
#   DEFINE  l_srbb                RECORD LIKE srbb_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srbb RECORD  #重複性生產期末盤點單身檔
       srbbent LIKE srbb_t.srbbent, #企业编号
       srbbsite LIKE srbb_t.srbbsite, #营运据点
       srbbdocno LIKE srbb_t.srbbdocno, #盘点单号
       srbbseq LIKE srbb_t.srbbseq, #项次
       srbb001 LIKE srbb_t.srbb001, #料件编号
       srbb002 LIKE srbb_t.srbb002, #产品特征
       srbb003 LIKE srbb_t.srbb003, #库位
       srbb004 LIKE srbb_t.srbb004, #储位
       srbb005 LIKE srbb_t.srbb005, #批号
       srbb006 LIKE srbb_t.srbb006, #库存特征
       srbb007 LIKE srbb_t.srbb007, #单位
       srbb008 LIKE srbb_t.srbb008, #账面数量
       srbb009 LIKE srbb_t.srbb009, #盘点数量
       srbb010 LIKE srbb_t.srbb010, #参考单位
       srbb011 LIKE srbb_t.srbb011, #参考账面数量
       srbb012 LIKE srbb_t.srbb012  #参考盘点数量
END RECORD
#161124-00048#12 add(e)
DEFINE l_i                        LIKE type_t.num5
DEFINE l_success                  LIKE type_t.num5
  
  LET r_success = FALSE
  IF cl_null(p_docno) OR cl_null(p_inag004) OR p_inag005 IS NULL THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = 'sub-00001'
     LET g_errparam.extend = ''
     LET g_errparam.popup = TRUE
     CALL cl_err()

     RETURN r_success
  END IF
     
#  LET l_sql = "SELECT * FROM inag_t WHERE inagent=",g_enterprise," AND inagsite='",g_site,"'", #161124-00048#12 mark
  #161124-00048#12 add(s)
  LET l_sql = "SELECT inagent,inagsite,inag001,inag002,inag003,inag004,inag005,",
              "       inag006,inag007,inag008,inag009,inag010,inag011,inag012,inag013,",
              "       inag014,inag015,inag016,inag017,inag018,inag019,inag020,inag021,",
              "       inag022,inag023,inag024,inag025,inag026,inag027,inag028,inag029,",
              "       inag030,inag031,inag032,inag033 ",
              "  FROM inag_t WHERE inagent=",g_enterprise," AND inagsite='",g_site,"'",
  #161124-00048#12 add(e)
              "   AND inag004='",p_inag004,"' AND inag005='",p_inag005,"' AND inag008>0"
  PREPARE asrt350_gen_pre FROM l_sql
  DECLARE asrt350_gen_cs CURSOR FOR asrt350_gen_pre
  LET l_i = 0
  FOREACH asrt350_gen_cs INTO l_inag.*
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "FOREACH:"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        RETURN r_success
     END IF
     LET l_srbb.srbbent=l_inag.inagent
     LET l_srbb.srbbsite=l_inag.inagsite
     LET l_srbb.srbb001=l_inag.inag001
     LET l_srbb.srbb002=l_inag.inag002
     LET l_srbb.srbb003=l_inag.inag004
     LET l_srbb.srbb004=l_inag.inag005
     LET l_srbb.srbb005=l_inag.inag006
     LET l_srbb.srbb006=l_inag.inag003
     LET l_srbb.srbb007=l_inag.inag007
     LET l_srbb.srbb008=l_inag.inag008
     LET l_srbb.srbb010=l_inag.inag024
     LET l_srbb.srbb011=l_inag.inag025
     LET l_srbb.srbbdocno=p_docno
     #数量进行单位取位
     IF NOT cl_null(l_srbb.srbb007) AND NOT cl_null(l_srbb.srbb008) AND l_srbb.srbb008 != 0 THEN
        CALL s_aooi250_take_decimals(l_srbb.srbb007,l_srbb.srbb008) RETURNING l_success,l_srbb.srbb008
        IF NOT l_success THEN
           RETURN r_success
        END IF
     END IF
     IF NOT cl_null(l_srbb.srbb010) AND NOT cl_null(l_srbb.srbb011) AND l_srbb.srbb011 != 0 THEN
        CALL s_aooi250_take_decimals(l_srbb.srbb010,l_srbb.srbb011) RETURNING l_success,l_srbb.srbb011
        IF NOT l_success THEN
           RETURN r_success
        END IF
     END IF
     IF cl_null(l_srbb.srbb010) THEN
        SELECT imaf015 INTO l_srbb.srbb010 FROM imaf_t WHERE imafent=g_enterprise AND imafsite=g_site AND imaf001=l_srbb.srbb001
     END IF
     IF cl_null(l_srbb.srbb011) THEN
        LET l_srbb.srbb011 = 0
     END IF
     IF cl_null(l_srbb.srbb010) THEN
        LET l_srbb.srbb011 = ''
     END IF
     LET l_srbb.srbbseq=l_i+1
#     INSERT INTO srbb_t VALUES l_srbb.* #161124-00048#12 mark
     #161124-00048#12 add(s)
     INSERT INTO srbb_t(srbbent,srbbsite,srbbdocno,srbbseq,srbb001,srbb002,srbb003,srbb004,srbb005,srbb006,srbb007,srbb008,srbb009,srbb010,srbb011,srbb012) 
                 VALUES(l_srbb.srbbent,l_srbb.srbbsite,l_srbb.srbbdocno,l_srbb.srbbseq,l_srbb.srbb001,l_srbb.srbb002,l_srbb.srbb003,l_srbb.srbb004,l_srbb.srbb005,l_srbb.srbb006,l_srbb.srbb007,l_srbb.srbb008,l_srbb.srbb009,l_srbb.srbb010,l_srbb.srbb011,l_srbb.srbb012)
     #161124-00048#12 add(e)
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "INS srbb_t"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        RETURN r_success
     END IF
     LET l_i = l_i + 1
  END FOREACH
  IF l_i = 0 THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = 'asr-00041'
     LET g_errparam.extend = ''
     LET g_errparam.popup = TRUE
     CALL cl_err()

  END IF
  LET r_success = TRUE
  RETURN r_success
  
END FUNCTION
#单头ref栏位显示
PRIVATE FUNCTION asrt350_desc()
  INITIALIZE g_ref_fields TO NULL
  LET g_ref_fields[1] = g_srba_m.srbasite
  LET g_ref_fields[2] = g_srba_m.srba003
  CALL ap_ref_array2(g_ref_fields,"SELECT srza002 FROM srza_t WHERE srzaent='"||g_enterprise||"' AND srzasite=? AND srza001=? ","") RETURNING g_rtn_fields
  LET g_srba_m.srba003_desc = '', g_rtn_fields[1] , ''
  DISPLAY BY NAME g_srba_m.srba003_desc
  
  LET g_srba_m.srba005_desc = s_desc_get_stock_desc(g_site,g_srba_m.srba005)
  DISPLAY BY NAME g_srba_m.srba005_desc
            
  LET g_srba_m.srba006_desc = s_desc_get_locator_desc(g_site,g_srba_m.srba005,g_srba_m.srba006)
  DISPLAY BY NAME g_srba_m.srba006_desc
END FUNCTION

################################################################################
# Descriptions...: 根据料号，产品特征，库位储位等带出库存明细档中资料及单身相关栏位显示
# Memo...........:
# Usage..........: CALL asrt350_def_srbb008(p_srbb001,p_srbb002,p_srbb003,p_srbb004,p_srbb005,p_srbb006,p_srbb007)
# Input parameter: 1.p_srbb001              LIKE srbb_t.srbb001
#                : 2.p_srbb002              LIKE srbb_t.srbb002
#                : 3.p_srbb003              LIKE srbb_t.srbb003
#                : 4.p_srbb004              LIKE srbb_t.srbb004
#                : 5.p_srbb005              LIKE srbb_t.srbb005
#                : 6.p_srbb006              LIKE srbb_t.srbb006
#                : 7.p_srbb007              LIKE srbb_t.srbb007
# Date & Author..: 2014/4/10 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt350_def_srbb008(p_srbb001,p_srbb002,p_srbb003,p_srbb004,p_srbb005,p_srbb006,p_srbb007)
DEFINE p_srbb001              LIKE srbb_t.srbb001
DEFINE p_srbb002              LIKE srbb_t.srbb002
DEFINE p_srbb003              LIKE srbb_t.srbb003
DEFINE p_srbb004              LIKE srbb_t.srbb004
DEFINE p_srbb005              LIKE srbb_t.srbb005
DEFINE p_srbb006              LIKE srbb_t.srbb006
DEFINE p_srbb007              LIKE srbb_t.srbb007
DEFINE l_n                    LIKE type_t.num5
DEFINE l_success              LIKE type_t.num5

   #料号、仓库、单位不可能为空或者空白
   IF cl_null(p_srbb001) OR cl_null(p_srbb003) OR cl_null(p_srbb007) THEN
      RETURN
   END IF
   IF cl_null(p_srbb002) THEN
      LET p_srbb002 = ' '
   END IF
   IF cl_null(p_srbb004) THEN
      LET p_srbb004 = ' '
   END IF
   IF cl_null(p_srbb005) THEN
      LET p_srbb005 = ' '
   END IF
   IF cl_null(p_srbb006) THEN
      LET p_srbb006 = ' '
   END IF
   SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent=g_enterprise AND inagsite=g_site 
      AND inag001=p_srbb001 AND inag002=p_srbb002 AND inag003=p_srbb006 AND inag004=p_srbb003
      AND inag005=p_srbb004 AND inag006=p_srbb005 AND inag007=p_srbb007
   IF l_n = 1 THEN
      SELECT inag008,inag024,inag025 INTO g_srbb_d[l_ac].srbb008,g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb011 FROM inag_t
       WHERE inagent=g_enterprise AND inagsite=g_site 
         AND inag001=p_srbb001 AND inag002=p_srbb002 AND inag003=p_srbb006 AND inag004=p_srbb003
         AND inag005=p_srbb004 AND inag006=p_srbb005 AND inag007=p_srbb007
      IF cl_null(g_srbb_d[l_ac].srbb008) THEN
         LET g_srbb_d[l_ac].srbb008 = 0
      END IF
      IF cl_null(g_srbb_d[l_ac].srbb010) THEN
         SELECT imaf015 INTO g_srbb_d[l_ac].srbb010 FROM imaf_t WHERE imafent=g_enterprise AND imafsite=g_site AND imaf001=p_srbb001
      END IF
      IF cl_null(g_srbb_d[l_ac].srbb011) THEN
         LET g_srbb_d[l_ac].srbb011 = 0
      END IF
      IF cl_null(g_srbb_d[l_ac].srbb010) THEN
         LET g_srbb_d[l_ac].srbb011 = ''
         CALL cl_set_comp_entry("srbb012",FALSE)
      ELSE
         CALL cl_set_comp_entry("srbb012",TRUE)
      END IF
      DISPLAY BY NAME g_srbb_d[l_ac].srbb008,g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb011
   ELSE
      LET g_srbb_d[l_ac].srbb008 = 0
      SELECT imaf015 INTO g_srbb_d[l_ac].srbb010 FROM imaf_t WHERE imafent=g_enterprise AND imafsite=g_site AND imaf001=p_srbb001
      IF cl_null(g_srbb_d[l_ac].srbb010) THEN
         LET g_srbb_d[l_ac].srbb011 = ''
         CALL cl_set_comp_entry("srbb012",FALSE)
      ELSE
         LET g_srbb_d[l_ac].srbb011 = 0
         CALL cl_set_comp_entry("srbb012",TRUE)
      END IF
   END IF 
   #数量进行单位取位
   IF NOT cl_null(g_srbb_d[l_ac].srbb007) AND NOT cl_null(g_srbb_d[l_ac].srbb008) AND g_srbb_d[l_ac].srbb008 != 0 THEN
      CALL s_aooi250_take_decimals(g_srbb_d[l_ac].srbb007,g_srbb_d[l_ac].srbb008) RETURNING l_success,g_srbb_d[l_ac].srbb008
   END IF
   IF NOT cl_null(g_srbb_d[l_ac].srbb010) AND NOT cl_null(g_srbb_d[l_ac].srbb011) AND g_srbb_d[l_ac].srbb011 != 0 THEN
      CALL s_aooi250_take_decimals(g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb011) RETURNING l_success,g_srbb_d[l_ac].srbb011
   END IF
   DISPLAY BY NAME g_srbb_d[l_ac].srbb008,g_srbb_d[l_ac].srbb010,g_srbb_d[l_ac].srbb011
END FUNCTION
#检查单位
PRIVATE FUNCTION asrt350_chk_srbb007()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_imaa006      LIKE imaa_t.imaa006
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rate         LIKE inaj_t.inaj014

   LET r_success = FALSE

   #1.检查单位资料档
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_srbb_d[l_ac].srbb007
   #160318-00025#22  by 07900 --add-str
   LET g_errshow = TRUE #是否開窗                   
   LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
   #160318-00025#22  by 07900 --add-end
   IF NOT cl_chk_exist("v_ooca001") THEN
      RETURN r_success
   END IF

   #2.检查与基础单位是否有转换率
   SELECT imaa006 INTO l_imaa006 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_srbb_d[l_ac].srbb001
   CALL s_aimi190_get_convert(g_srbb_d[l_ac].srbb001,g_srbb_d[l_ac].srbb007,l_imaa006)
        RETURNING l_success,l_rate
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
#chk分摊数量
PRIVATE FUNCTION asrt350_chk_srbc004()
DEFINE l_success             LIKE type_t.num5
DEFINE l_srbb007             LIKE srbb_t.srbb007
DEFINE l_srbb008             LIKE srbb_t.srbb008
DEFINE l_srbb009             LIKE srbb_t.srbb009
DEFINE l_srbc004             LIKE srbc_t.srbc004

   SELECT srbb007,srbb008,srbb009 INTO l_srbb007,l_srbb008,l_srbb009 FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site
      AND srbbdocno=g_srba_m.srbadocno AND srbbseq=g_srbb3_d[l_ac].srbcseq
   SELECT SUM(srbc004) INTO l_srbc004 FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site
      AND srbcdocno=g_srba_m.srbadocno AND srbcseq=g_srbb3_d[l_ac].srbcseq
   #数量进行单位取位
   IF NOT cl_null(l_srbb007) AND NOT cl_null(g_srbb3_d[l_ac].srbc004) AND g_srbb3_d[l_ac].srbc004 != 0 THEN
      CALL s_aooi250_take_decimals(l_srbb007,g_srbb3_d[l_ac].srbc004) RETURNING l_success,g_srbb3_d[l_ac].srbc004
      IF NOT l_success THEN
         RETURN FALSE
      END IF
   END IF
   IF cl_null(g_srbb3_d_t.srbc004) THEN
      LET g_srbb3_d_t.srbc004 = 0
   END IF
   IF cl_null(l_srbc004) THEN
      LET l_srbc004 = 0 
   END IF
   IF l_srbb008 - l_srbb009 < 0 THEN
      IF g_srbb3_d[l_ac].srbc004 >= 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00044'
         LET g_errparam.extend = g_srbb3_d[l_ac].srbc004
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      IF (l_srbc004 - g_srbb3_d_t.srbc004 + g_srbb3_d[l_ac].srbc004) < (l_srbb008 - l_srbb009) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00045'
         LET g_errparam.extend = g_srbb3_d[l_ac].srbc004
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF 
   ELSE
      IF g_srbb3_d[l_ac].srbc004 <= 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00044'
         LET g_errparam.extend = g_srbb3_d[l_ac].srbc004
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      IF (l_srbc004 - g_srbb3_d_t.srbc004 + g_srbb3_d[l_ac].srbc004) > (l_srbb008 - l_srbb009) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00045'
         LET g_errparam.extend = g_srbb3_d[l_ac].srbc004
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE   
   
END FUNCTION
#chk 参考数量
PRIVATE FUNCTION asrt350_chk_srbc005()
DEFINE l_success             LIKE type_t.num5
DEFINE l_srbb010             LIKE srbb_t.srbb010
DEFINE l_srbb011             LIKE srbb_t.srbb011
DEFINE l_srbb012             LIKE srbb_t.srbb012
DEFINE l_srbc005             LIKE srbc_t.srbc005

   SELECT srbb010,srbb011,srbb012 INTO l_srbb010,l_srbb011,l_srbb012 FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site
      AND srbbdocno=g_srba_m.srbadocno AND srbbseq=g_srbb3_d[l_ac].srbcseq
   #数量进行单位取位
   IF NOT cl_null(l_srbb010) AND NOT cl_null(g_srbb3_d[l_ac].srbc005) AND g_srbb3_d[l_ac].srbc005 != 0 THEN
      CALL s_aooi250_take_decimals(l_srbb010,g_srbb3_d[l_ac].srbc005) RETURNING l_success,g_srbb3_d[l_ac].srbc005
      IF NOT l_success THEN
         RETURN FALSE
      END IF
   END IF
   SELECT SUM(srbc005) INTO l_srbc005 FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site
      AND srbcdocno=g_srba_m.srbadocno AND srbcseq=g_srbb3_d[l_ac].srbcseq
   IF cl_null(g_srbb3_d_t.srbc005) THEN
      LET g_srbb3_d_t.srbc005 = 0
   END IF
   IF cl_null(l_srbc005) THEN
      LET l_srbc005 = 0 
   END IF
   IF l_srbb011 - l_srbb012 < 0 THEN
      IF g_srbb3_d[l_ac].srbc005 >= 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00044'
         LET g_errparam.extend = g_srbb3_d[l_ac].srbc005
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      IF (l_srbc005 - g_srbb3_d_t.srbc005 + g_srbb3_d[l_ac].srbc005) < (l_srbb011 - l_srbb012) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00045'
         LET g_errparam.extend = g_srbb3_d[l_ac].srbc005
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF 
   ELSE
      IF g_srbb3_d[l_ac].srbc005 <= 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00044'
         LET g_errparam.extend = g_srbb3_d[l_ac].srbc005
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      IF (l_srbc005 - g_srbb3_d_t.srbc005 + g_srbb3_d[l_ac].srbc005) > (l_srbb011 - l_srbb012) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00045'
         LET g_errparam.extend = g_srbb3_d[l_ac].srbc005
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE 
END FUNCTION

#依发料量
PRIVATE FUNCTION asrt350_gen_srbc_2(p_srbbseq)
DEFINE p_srbbseq             LIKE srbb_t.srbbseq
DEFINE r_success             LIKE type_t.num5
#   DEFINE  l_srbb                RECORD LIKE srbb_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srbb RECORD  #重複性生產期末盤點單身檔
       srbbent LIKE srbb_t.srbbent, #企业编号
       srbbsite LIKE srbb_t.srbbsite, #营运据点
       srbbdocno LIKE srbb_t.srbbdocno, #盘点单号
       srbbseq LIKE srbb_t.srbbseq, #项次
       srbb001 LIKE srbb_t.srbb001, #料件编号
       srbb002 LIKE srbb_t.srbb002, #产品特征
       srbb003 LIKE srbb_t.srbb003, #库位
       srbb004 LIKE srbb_t.srbb004, #储位
       srbb005 LIKE srbb_t.srbb005, #批号
       srbb006 LIKE srbb_t.srbb006, #库存特征
       srbb007 LIKE srbb_t.srbb007, #单位
       srbb008 LIKE srbb_t.srbb008, #账面数量
       srbb009 LIKE srbb_t.srbb009, #盘点数量
       srbb010 LIKE srbb_t.srbb010, #参考单位
       srbb011 LIKE srbb_t.srbb011, #参考账面数量
       srbb012 LIKE srbb_t.srbb012  #参考盘点数量
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srbc                RECORD LIKE srbc_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srbc RECORD  #重複性生產期末盤點分攤檔
       srbcent LIKE srbc_t.srbcent, #企业编号
       srbcsite LIKE srbc_t.srbcsite, #营运据点
       srbcdocno LIKE srbc_t.srbcdocno, #盘点单号
       srbcseq LIKE srbc_t.srbcseq, #项次
       srbcseq1 LIKE srbc_t.srbcseq1, #项序
       srbc001 LIKE srbc_t.srbc001, #生产料号
       srbc002 LIKE srbc_t.srbc002, #BOM特性
       srbc003 LIKE srbc_t.srbc003, #产品特征
       srbc004 LIKE srbc_t.srbc004, #分摊数量
       srbc005 LIKE srbc_t.srbc005, #分摊参考数量
       srbc006 LIKE srbc_t.srbc006, #领退料单号
       srbc007 LIKE srbc_t.srbc007  #分摊基数
END RECORD
#161124-00048#12 add(e)
DEFINE l_sql_0               STRING
DEFINE l_sql_1               STRING
DEFINE l_sql_where           STRING
DEFINE l_imaa006             LIKE imaa_t.imaa006
DEFINE l_sfda                DYNAMIC ARRAY OF RECORD
       sfda006               LIKE sfda_t.sfda006,
       sfda007               LIKE sfda_t.sfda007,
       sfda008               LIKE sfda_t.sfda008,
       sum1                  LIKE srbc_t.srbc005,
       sum2                  LIKE srbc_t.srbc005
                             END RECORD
DEFINE l_sfda002             LIKE sfda_t.sfda002
DEFINE l_sfdd006             LIKE sfdd_t.sfdd006
DEFINE l_sfdd007             LIKE sfdd_t.sfdd007
DEFINE l_sfdd008             LIKE sfdd_t.sfdd008
DEFINE l_sfdd009             LIKE sfdd_t.sfdd009
DEFINE l_sfdd007_1           LIKE sfdd_t.sfdd007
DEFINE l_sfdd009_1           LIKE sfdd_t.sfdd009
DEFINE l_success             LIKE type_t.num5
DEFINE l_rate                LIKE srbc_t.srbc005
DEFINE l_sum1                LIKE srbc_t.srbc005
DEFINE l_sum2                LIKE srbc_t.srbc005
DEFINE l_sum3                LIKE srbc_t.srbc005
DEFINE l_sum4                LIKE srbc_t.srbc005
DEFINE l_i                   LIKE type_t.num5
DEFINE l_j                   LIKE type_t.num5
DEFINE l_srbc004             LIKE srbc_t.srbc004
DEFINE l_srbc005             LIKE srbc_t.srbc005
DEFINE l_srbc004_max         LIKE srbc_t.srbc004
DEFINE l_srbc005_max         LIKE srbc_t.srbc005
DEFINE l_srbcseq1_min        LIKE srbc_t.srbcseq1

   LET r_success = FALSE
   
#   SELECT * INTO l_srbb.* FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site AND srbbdocno=g_srba_m.srbadocno AND srbbseq=p_srbbseq #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT srbbent,srbbsite,srbbdocno,srbbseq,srbb001,srbb002,srbb003,
          srbb004,srbb005,srbb006,srbb007,srbb008,srbb009,srbb010,srbb011,srbb012 
     INTO l_srbb.* FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site 
      AND srbbdocno=g_srba_m.srbadocno AND srbbseq=p_srbbseq
   #161124-00048#12 add(e)
   
   LET l_sql_0 = "SELECT UNIQUE sfda006,sfda007,sfda008 FROM sfda_t,sfdc_t,sfdd_t"
   LET l_sql_1 = "SELECT sfda002,sfdd006,sfdd007,sfdd008,sfdd009 FROM sfda_t,sfdc_t,sfdd_t "
   LET l_sql_where = "  WHERE sfdaent=sfdcent AND sfdadocno=sfdcdocno AND sfdcent=sfddent AND sfdcdocno=sfdddocno AND sfdcseq=sfddseq ",
                     "   AND sfdaent=",g_enterprise," and sfdasite='",g_site,"' AND sfda001>='",g_srba_m.srba001,"'",
                     "   AND sfda001<'",g_srba_m.srba002,"' AND sfda009='",g_srba_m.srba003,"' AND sfdd001='",l_srbb.srbb001,"'"
   IF cl_null(l_srbb.srbb002) THEN
      LET l_sql_0 = l_sql_0,l_sql_where," AND (sfdc005 IS NULL OR sfdc005 = ' ')"
      LET l_sql_1 = l_sql_1,l_sql_where," AND (sfdc005 IS NULL OR sfdc005 = ' ')"
   ELSE
      LET l_sql_0 = l_sql_0,l_sql_where," AND sfdc005 = '",l_srbb.srbb002,"'"
      LET l_sql_1 = l_sql_1,l_sql_where," AND sfdc005 = '",l_srbb.srbb002,"'"
   END IF
   LET l_sql_0 = l_sql_0," GROUP BY sfda006,sfda007,sfda008"
   PREPARE asrt350_gen_srbc_2_pre_0 FROM l_sql_0
   DECLARE asrt350_gen_srbc_2_cs_0 CURSOR FOR asrt350_gen_srbc_2_pre_0 
   
   LET l_sql_1 = l_sql_1," AND sfda006=? AND sfda007=? AND sfda008=? "," ORDER BY sfda002,sfdd006,sfdd007,sfdd008,sfdd009"
   PREPARE asrt350_gen_srbc_2_pre_1 FROM l_sql_1
   DECLARE asrt350_gen_srbc_2_cs_1 CURSOR FOR asrt350_gen_srbc_2_pre_1  
   
   LET l_i = 1
   FOREACH asrt350_gen_srbc_2_cs_0 INTO l_sfda[l_i].sfda006,l_sfda[l_i].sfda007,l_sfda[l_i].sfda008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      LET l_sum1 = 0    #(发料量-退料量) 之和
      LET l_sum2 = 0
      FOREACH asrt350_gen_srbc_2_cs_1 USING l_sfda[l_i].sfda006,l_sfda[l_i].sfda007,l_sfda[l_i].sfda008 INTO l_sfda002,l_sfdd006,l_sfdd007,l_sfdd008,l_sfdd009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            RETURN r_success
         END IF
         #单位转换
         CALL s_aimi190_get_convert(l_srbb.srbb001,l_sfdd006,l_srbb.srbb007) RETURNING l_success,l_rate 
         IF NOT l_success THEN
            RETURN r_success
         END IF            
         LET l_sfdd007_1 = l_sfdd007 * l_rate
         #参考单位转换
         CALL s_aimi190_get_convert(l_srbb.srbb001,l_sfdd008,l_srbb.srbb010) RETURNING l_success,l_rate 
         IF NOT l_success THEN
            RETURN r_success
         END IF            
         LET l_sfdd009_1 = l_sfdd009 * l_rate
         IF l_sfda002 = '16' THEN
            LET l_sum1 = l_sum1 + l_sfdd007_1
            LET l_sum2 = l_sum2 + l_sfdd009_1
         END IF
         IF l_sfda002 = '26' THEN
            LET l_sum1 = l_sum1 - l_sfdd007_1
            LET l_sum2 = l_sum2 - l_sfdd009_1
         END IF
      END FOREACH
      IF l_sum1 < 0 THEN
         CONTINUE FOREACH
      END IF
      LET l_sfda[l_i].sum1 = l_sum1
      LET l_sfda[l_i].sum2 = l_sum2
      
      LET l_i = l_i + 1
   END FOREACH 
   
   LET l_i = l_i - 1
   IF l_i = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00281'
      LET g_errparam.extend = p_srbbseq
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #计算总合计量
   LET l_sum3 = 0       #当前料号对应的总合计量
   LET l_sum4 = 0       #当前料号对应的总参考和计量
   FOR l_j = 1 TO l_i
      LET l_sum3 = l_sum3 + l_sfda[l_j].sum1
      LET l_sum4 = l_sum4 + l_sfda[l_j].sum2 
   END FOR
   
   #当前项次分摊insert
   FOR l_j = 1 TO l_i
      LET l_srbc.srbcent = l_srbb.srbbent
      LET l_srbc.srbcsite = l_srbb.srbbsite
      LET l_srbc.srbcdocno = l_srbb.srbbdocno
      LET l_srbc.srbcseq = l_srbb.srbbseq
      SELECT MAX(srbcseq1)+1 INTO l_srbc.srbcseq1 FROM srbc_t WHERE srbcent=l_srbc.srbcent AND srbcsite=l_srbc.srbcsite
         AND srbcdocno=l_srbc.srbcdocno AND srbcseq=l_srbc.srbcseq
      IF cl_null(l_srbc.srbcseq1) THEN
         LET l_srbc.srbcseq1 = 1 
      END IF
      LET l_srbc.srbc001 = l_sfda[l_j].sfda006
      LET l_srbc.srbc002 = l_sfda[l_j].sfda007
      LET l_srbc.srbc003 = l_sfda[l_j].sfda008
      LET l_srbc.srbc004 = (l_srbb.srbb008 - l_srbb.srbb009) * l_sfda[l_j].sum1 / l_sum3
      LET l_srbc.srbc005 = (l_srbb.srbb011 - l_srbb.srbb012) * l_sfda[l_j].sum1 / l_sum3
      #数量进行单位取位
      IF NOT cl_null(l_srbb.srbb007) AND NOT cl_null(l_srbc.srbc004) AND l_srbc.srbc004 != 0 THEN
         CALL s_aooi250_take_decimals(l_srbb.srbb007,l_srbc.srbc004) RETURNING l_success,l_srbc.srbc004
         IF NOT l_success THEN
            RETURN r_success
         END IF
      END IF
      IF NOT cl_null(l_srbb.srbb010) AND NOT cl_null(l_srbc.srbc005) AND l_srbc.srbc005 != 0 THEN
         CALL s_aooi250_take_decimals(l_srbb.srbb010,l_srbc.srbc005) RETURNING l_success,l_srbc.srbc005
         IF NOT l_success THEN
            RETURN r_success
         END IF
      END IF
      LET l_srbc.srbc007 = l_sfda[l_j].sum1
#      INSERT INTO srbc_t VALUES l_srbc.* #161124-00048#12 mark
      #161124-00048#12 add(s)
      INSERT INTO srbc_t(srbcent,srbcsite,srbcdocno,srbcseq,srbcseq1,srbc001,srbc002,srbc003,srbc004,srbc005,srbc006,srbc007) 
                  VALUES(l_srbc.srbcent,l_srbc.srbcsite,l_srbc.srbcdocno,l_srbc.srbcseq,l_srbc.srbcseq1,l_srbc.srbc001,l_srbc.srbc002,l_srbc.srbc003,l_srbc.srbc004,l_srbc.srbc005,l_srbc.srbc006,l_srbc.srbc007)
      #161124-00048#12 add(e)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INS srbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END FOR 
   
   #全部分攤完後若分攤數量合計與差異數有小數尾差，將數量最大的一筆做調整，使分攤合計數與差異數相同
   SELECT SUM(srbc004),SUM(srbc005) INTO l_srbc004,l_srbc005 FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
      AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
   IF l_srbb.srbb008 - l_srbb.srbb009 != l_srbc004 THEN
      #计算出差异数量
      LET l_srbc004 = l_srbb.srbb008 - l_srbb.srbb009 - l_srbc004
      #找出数量最大的(若为负数的时候抓最小值），可能存在数量最大的有多笔情况,若存在，则调整项序小的那笔资料
      IF l_srbb.srbb008 - l_srbb.srbb009 > 0 THEN
         SELECT MAX(srbc004) INTO l_srbc004_max FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
            AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
      ELSE
         SELECT MIN(srbc004) INTO l_srbc004_max FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
            AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
      END IF
      SELECT MIN(srbcseq1) INTO l_srbcseq1_min FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
         AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq AND srbc004=l_srbc004_max
      UPDATE srbc_t SET srbc004=srbc004+l_srbc004 WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
         AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq AND srbcseq1=l_srbcseq1_min AND srbc004=l_srbc004_max
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPD srbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END IF
   IF l_srbb.srbb011 - l_srbb.srbb012 != l_srbc005 THEN
      #计算出差异参考数量
      LET l_srbc005 = l_srbb.srbb011 - l_srbb.srbb012 - l_srbc005
      #找出数量最大的(若为负数的时候抓最小值），可能存在数量最大的有多笔情况,若存在，则调整项序小的那笔资料
      IF l_srbb.srbb011 - l_srbb.srbb012 > 0 THEN
         SELECT MAX(srbc005) INTO l_srbc005_max FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
            AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
      ELSE
         SELECT MIN(srbc005) INTO l_srbc005_max FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
            AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
      END IF
      SELECT MIN(srbcseq1) INTO l_srbcseq1_min FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
         AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq AND srbc005=l_srbc005_max
      UPDATE srbc_t SET srbc005=srbc005+l_srbc005 WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
         AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq AND srbcseq1=l_srbcseq1_min AND srbc005=l_srbc005_max
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPD srbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
#根据项次带出盘点资料相关资料
PRIVATE FUNCTION asrt350_srbcseq()
   SELECT MAX(srbcseq1)+1 INTO g_srbb3_d[l_ac].srbcseq1 FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site
      AND srbcdocno=g_srba_m.srbadocno AND srbcseq=g_srbb3_d[l_ac].srbcseq
   IF cl_null(g_srbb3_d[l_ac].srbcseq1) THEN
      LET g_srbb3_d[l_ac].srbcseq1 = 1
   END IF
   SELECT srbb001,imaal003,imaal004,srbb002,srbb005,srbb006 INTO g_srbb3_d[l_ac].l_srbb001,g_srbb3_d[l_ac].l_srbb001_desc,g_srbb3_d[l_ac].l_srbb001_desc_1,g_srbb3_d[l_ac].l_srbb002,g_srbb3_d[l_ac].l_srbb005,g_srbb3_d[l_ac].l_srbb006 FROM srbb_t LEFT OUTER JOIN imaal_t ON srbbent=imaalent AND srbb001=imaal001 AND imaal002=g_lang
    WHERE srbbent=g_enterprise AND srbbsite=g_site AND srbbdocno=g_srba_m.srbadocno AND srbbseq=g_srbb3_d[l_ac].srbcseq
  # DISPLAY BY NAME g_srbb3_d[l_ac].srbcseq1,g_srbb3_d[l_ac].l_srbb001,g_srbb3_d[l_ac].l_srbb001_desc,g_srbb3_d[l_ac].l_srbb001_desc_1,g_srbb3_d[l_ac].l_srbb002,g_srbb3_d[l_ac].l_srbb005,g_srbb3_d[l_ac].l_srbb006
END FUNCTION
#chk生产料号、BOM特性、生产特征
PRIVATE FUNCTION asrt350_chk_srbc001()
DEFINE l_sql0                STRING
DEFINE l_sql1                STRING
DEFINE l_sql                 STRING
DEFINE l_n                   LIKE type_t.num5

   IF cl_null(g_srbb3_d[l_ac].srbc001) THEN
      RETURN FALSE      
   END IF 
   
   LET l_sql0 = "SELECT COUNT(*) FROM srab_t"
   LET l_sql1 = "SELECT srab004,srab005,srab006 FROM srab_t"
   LET l_sql = " WHERE srabent=",g_enterprise," AND srabsite='",g_site,"' AND srab000=",g_srab000," AND srab001='",g_srba_m.srba003,"'",
               "   AND srab002=",g_srab002," AND srab003=",g_srab003," AND srab004='",g_srbb3_d[l_ac].srbc001,"'"
   IF g_srbb3_d[l_ac].srbc002 IS NOT NULL THEN
      LET l_sql = l_sql," AND srab005='",g_srbb3_d[l_ac].srbc002,"'"
   END IF
   IF g_srbb3_d[l_ac].srbc003 IS NOT NULL THEN
      LET l_sql = l_sql," AND srab006='",g_srbb3_d[l_ac].srbc003,"'"
   END IF
   LET l_sql0 = l_sql0,l_sql
   PREPARE asrt350_chk_srba001_pre FROM l_sql0
   EXECUTE asrt350_chk_srba001_pre INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asr-00033'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   IF l_n = 1 THEN
      LET l_sql1 = l_sql1,l_sql
      PREPARE asrt350_chk_srba001_pre1 FROM l_sql1
      EXECUTE asrt350_chk_srba001_pre1 INTO g_srbb3_d[l_ac].srbc001,g_srbb3_d[l_ac].srbc002,g_srbb3_d[l_ac].srbc003
      DISPLAY BY NAME g_srbb3_d[l_ac].srbc001,g_srbb3_d[l_ac].srbc002,g_srbb3_d[l_ac].srbc003
   END IF
   RETURN TRUE
END FUNCTION


#srbc分摊明细显示
PRIVATE FUNCTION asrt350_b_srbc_desc()
   SELECT srbb001,imaal003,imaal004,srbb002,srbb005,srbb006 INTO g_srbb3_d[l_ac].l_srbb001,g_srbb3_d[l_ac].l_srbb001_desc,g_srbb3_d[l_ac].l_srbb001_desc_1,g_srbb3_d[l_ac].l_srbb002,g_srbb3_d[l_ac].l_srbb005,g_srbb3_d[l_ac].l_srbb006 FROM srbb_t LEFT OUTER JOIN imaal_t ON srbbent=imaalent AND srbb001=imaal001 AND imaal002=g_lang
    WHERE srbbent=g_enterprise AND srbbdocno=g_srba_m.srbadocno AND srbbseq=g_srbb3_d[l_ac].srbcseq
   SELECT imaal003,imaal004 INTO g_srbb3_d[l_ac].srbc001_desc,g_srbb3_d[l_ac].srbc001_desc_1 FROM imaal_t 
    WHERE imaalent=g_enterprise AND imaal001=g_srbb3_d[l_ac].srbc001 AND imaal002=g_lang
  # DISPLAY BY NAME g_srbb3_d[l_ac].srbcseq1,g_srbb3_d[l_ac].l_srbb001,g_srbb3_d[l_ac].l_srbb001_desc,g_srbb3_d[l_ac].l_srbb001_desc_1,g_srbb3_d[l_ac].l_srbb002,g_srbb3_d[l_ac].l_srbb005,g_srbb3_d[l_ac].l_srbb006,g_srbb3_d[l_ac].srbc001_desc,g_srbb3_d[l_ac].srbc001_desc_1
END FUNCTION


#已入库量
PRIVATE FUNCTION asrt350_gen_srbc_1(p_srbbseq)
DEFINE p_srbbseq                    LIKE srbb_t.srbbseq
DEFINE r_success             LIKE type_t.num5
#   DEFINE  l_srbb                RECORD LIKE srbb_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srbb RECORD  #重複性生產期末盤點單身檔
       srbbent LIKE srbb_t.srbbent, #企业编号
       srbbsite LIKE srbb_t.srbbsite, #营运据点
       srbbdocno LIKE srbb_t.srbbdocno, #盘点单号
       srbbseq LIKE srbb_t.srbbseq, #项次
       srbb001 LIKE srbb_t.srbb001, #料件编号
       srbb002 LIKE srbb_t.srbb002, #产品特征
       srbb003 LIKE srbb_t.srbb003, #库位
       srbb004 LIKE srbb_t.srbb004, #储位
       srbb005 LIKE srbb_t.srbb005, #批号
       srbb006 LIKE srbb_t.srbb006, #库存特征
       srbb007 LIKE srbb_t.srbb007, #单位
       srbb008 LIKE srbb_t.srbb008, #账面数量
       srbb009 LIKE srbb_t.srbb009, #盘点数量
       srbb010 LIKE srbb_t.srbb010, #参考单位
       srbb011 LIKE srbb_t.srbb011, #参考账面数量
       srbb012 LIKE srbb_t.srbb012  #参考盘点数量
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srbc                RECORD LIKE srbc_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srbc RECORD  #重複性生產期末盤點分攤檔
       srbcent LIKE srbc_t.srbcent, #企业编号
       srbcsite LIKE srbc_t.srbcsite, #营运据点
       srbcdocno LIKE srbc_t.srbcdocno, #盘点单号
       srbcseq LIKE srbc_t.srbcseq, #项次
       srbcseq1 LIKE srbc_t.srbcseq1, #项序
       srbc001 LIKE srbc_t.srbc001, #生产料号
       srbc002 LIKE srbc_t.srbc002, #BOM特性
       srbc003 LIKE srbc_t.srbc003, #产品特征
       srbc004 LIKE srbc_t.srbc004, #分摊数量
       srbc005 LIKE srbc_t.srbc005, #分摊参考数量
       srbc006 LIKE srbc_t.srbc006, #领退料单号
       srbc007 LIKE srbc_t.srbc007  #分摊基数
END RECORD
#161124-00048#12 add(e)
DEFINE l_sql_0               STRING
DEFINE l_sql_1               STRING
DEFINE l_sql_where           STRING
DEFINE l_bmba                DYNAMIC ARRAY OF RECORD #回传数组
       bmba001               LIKE bmba_t.bmba001,    #bom相关资料都可以通过回传的key值抓取
       bmba002               LIKE bmba_t.bmba002,
       bmba003               LIKE bmba_t.bmba003,
       bmba004               LIKE bmba_t.bmba004,
       bmba005               DATETIME YEAR TO SECOND,
       bmba007               LIKE bmba_t.bmba007,
       bmba008               LIKE bmba_t.bmba008,
       bmba035               LIKE bmba_t.bmba035,     #保稅否   #160512-00016#27
       l_bmba011             LIKE bmba_t.bmba011,     #QPA 分子，对应于原始的主件料号
       l_bmba012             LIKE bmba_t.bmba012,     #QPA 分母，对应于原始的主件料号
       l_inam002             LIKE inam_t.inam002      #元件对应特征
                             END RECORD
DEFINE l_imaa006             LIKE imaa_t.imaa006
DEFINE l_sfec                DYNAMIC ARRAY OF RECORD
       sfec018               LIKE sfec_t.sfec018,
       sfec019               LIKE sfec_t.sfec019,
       sfec020               LIKE sfec_t.sfec020,
       sum1                  LIKE srbc_t.srbc005,
       sum2                  LIKE srbc_t.srbc005
                             END RECORD
DEFINE l_sfec008             LIKE sfec_t.sfec008
DEFINE l_sfec009             LIKE sfec_t.sfec009
DEFINE l_sfec010             LIKE sfec_t.sfec010
DEFINE l_sfec011             LIKE sfec_t.sfec011
DEFINE l_sfec009_1           LIKE sfec_t.sfec009
DEFINE l_sfec011_1           LIKE sfec_t.sfec011
DEFINE l_success             LIKE type_t.num5
DEFINE l_rate                LIKE srbc_t.srbc005
DEFINE l_sum1                LIKE srbc_t.srbc005
DEFINE l_sum2                LIKE srbc_t.srbc005
DEFINE l_sum3                LIKE srbc_t.srbc005
DEFINE l_sum4                LIKE srbc_t.srbc005
DEFINE l_i                   LIKE type_t.num5
DEFINE l_j                   LIKE type_t.num5
DEFINE l_srbc004             LIKE srbc_t.srbc004
DEFINE l_srbc005             LIKE srbc_t.srbc005
DEFINE l_srbc004_max         LIKE srbc_t.srbc004
DEFINE l_srbc005_max         LIKE srbc_t.srbc005
DEFINE l_srbcseq1_min        LIKE srbc_t.srbcseq1


   LET r_success = FALSE
   
#  SELECT * INTO l_srbb.* FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site AND srbbdocno=g_srba_m.srbadocno AND srbbseq=p_srbbseq #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT srbbent,srbbsite,srbbdocno,srbbseq,srbb001,srbb002,srbb003,
          srbb004,srbb005,srbb006,srbb007,srbb008,srbb009,srbb010,srbb011,srbb012 
     INTO l_srbb.* FROM srbb_t WHERE srbbent=g_enterprise AND srbbsite=g_site 
      AND srbbdocno=g_srba_m.srbadocno AND srbbseq=p_srbbseq
   #161124-00048#12 add(e)

   #取得基础单位
   SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent=g_enterprise AND imaa001=l_srbb.srbb001
   
   LET l_sql_0 = "SELECT UNIQUE sfec018,sfec019,sfec020 FROM sfea_t,sfec_t"
   LET l_sql_1 = "SELECT sfec008,sfec009,sfec010,sfec011 FROM sfea_t,sfec_t"
   LET l_sql_where = " WHERE sfeaent=sfecent AND sfeadocno=sfecdocno AND sfeasite=sfecsite ",
                 "   AND sfeaent=",g_enterprise," and sfeasite='",g_site,"' AND sfea001>='",g_srba_m.srba001,"'",
                 "   AND sfea001<'",g_srba_m.srba002,"' AND sfea006='",g_srba_m.srba003,"'",
                 "   AND sfeastus='S' AND (sfec004 = '1' OR sfec004 = '2') "   #一般+联产品
   LET l_sql_0 = l_sql_0,l_sql_where," GROUP BY sfec018,sfec019,sfec020"
   PREPARE asrt350_gen_srbc_1_pre_1 FROM l_sql_0
   DECLARE asrt350_gen_srbc_1_cs_1 CURSOR FOR asrt350_gen_srbc_1_pre_1  
   LET l_sql_1 = l_sql_1,l_sql_where," AND sfec018=? AND sfec019=? AND sfec020=?"," ORDER BY sfec008,sfec009,sfec010,sfec011"
   PREPARE asrt350_gen_srbc_1_pre_2 FROM l_sql_1
   DECLARE asrt350_gen_srbc_1_cs_2 CURSOR FOR asrt350_gen_srbc_1_pre_2
   
   LET l_i = 1
   FOREACH asrt350_gen_srbc_1_cs_1 INTO l_sfec[l_i].sfec018,l_sfec[l_i].sfec019,l_sfec[l_i].sfec020
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      
      #依bom找到是否用到srbb001
      LET l_sum1 = 0    
      LET l_sum2 = 0 
      #160512-00016#14 20160527 modify by ming -----(S) 
      #因為不確定此程式是否走保稅，所以不指定Y/N
      #CALL s_asft300_02_bom(0,l_sfec[l_i].sfec018,l_sfec[l_i].sfec019,l_imaa006,1,1,g_srba_m.srbadocdt,'N',l_srbb.srbb001,l_sfec[l_i].sfec020,'') RETURNING l_bmba
      CALL s_asft300_02_bom(0,l_sfec[l_i].sfec018,l_sfec[l_i].sfec019,l_imaa006,1,1,g_srba_m.srbadocdt,'N',l_srbb.srbb001,l_sfec[l_i].sfec020,'','N') RETURNING l_bmba   #160512-00016#27 保税否栏位給值N
      #160512-00016#14 20160527 modify by ming -----(E) 
      IF l_bmba.getLength() > 0 THEN
         FOREACH asrt350_gen_srbc_1_cs_2 USING l_sfec[l_i].sfec018,l_sfec[l_i].sfec019,l_sfec[l_i].sfec020 INTO l_sfec008,l_sfec009,l_sfec010,l_sfec011
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

               RETURN r_success
            END IF
            #单位转换及数量换算
            IF NOT cl_null(l_sfec008) AND NOT cl_null(l_sfec009) THEN
               CALL s_aimi190_get_convert(l_sfec[l_i].sfec018,l_sfec008,l_imaa006) RETURNING l_success,l_rate 
               IF NOT l_success THEN
                  RETURN r_success
               END IF             
               LET l_sfec009_1 = l_sfec009 * l_rate
               LET l_sum1 = l_sum1 + l_sfec009_1
            END IF
            #单位转换及数量换算
            IF NOT cl_null(l_sfec010) AND NOT cl_null(l_sfec011) THEN
               CALL s_aimi190_get_convert(l_sfec[l_i].sfec018,l_sfec010,l_imaa006) RETURNING l_success,l_rate 
               IF NOT l_success THEN
                  RETURN r_success
               END IF            
               LET l_sfec011_1 = l_sfec011 * l_rate
               LET l_sum2 = l_sum2 + l_sfec011_1
            END IF            
         END FOREACH
         LET l_sum1 = l_sum1 * l_bmba[1].l_bmba011 / l_bmba[1].l_bmba012
         LET l_sum2 = l_sum2 * l_bmba[1].l_bmba011 / l_bmba[1].l_bmba012
      ELSE
         CONTINUE FOREACH
      END IF 
      LET l_sfec[l_i].sum1 = l_sum1
      LET l_sfec[l_i].sum2 = l_sum2
      LET l_i = l_i + 1
   END FOREACH
   
   LET l_i = l_i - 1
   IF l_i = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asr-00058'
      LET g_errparam.extend = p_srbbseq
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #计算总合计量
   LET l_sum3 = 0       #当前料号对应的总合计量
   LET l_sum4 = 0       #当前料号对应的总参考和计量
   FOR l_j = 1 TO l_i
      LET l_sum3 = l_sum3 + l_sfec[l_j].sum1
      LET l_sum4 = l_sum4 + l_sfec[l_j].sum2 
   END FOR
   
   #当前项次分摊insert
   FOR l_j = 1 TO l_i
      LET l_srbc.srbcent = l_srbb.srbbent
      LET l_srbc.srbcsite = l_srbb.srbbsite
      LET l_srbc.srbcdocno = l_srbb.srbbdocno
      LET l_srbc.srbcseq = l_srbb.srbbseq
      SELECT MAX(srbcseq1)+1 INTO l_srbc.srbcseq1 FROM srbc_t WHERE srbcent=l_srbc.srbcent AND srbcsite=l_srbc.srbcsite
         AND srbcdocno=l_srbc.srbcdocno AND srbcseq=l_srbc.srbcseq
      IF cl_null(l_srbc.srbcseq1) THEN
         LET l_srbc.srbcseq1 = 1 
      END IF
      LET l_srbc.srbc001 = l_sfec[l_j].sfec018
      LET l_srbc.srbc002 = l_sfec[l_j].sfec019
      LET l_srbc.srbc003 = l_sfec[l_j].sfec020
      LET l_srbc.srbc004 = (l_srbb.srbb008 - l_srbb.srbb009) * l_sfec[l_j].sum1 / l_sum3
      LET l_srbc.srbc005 = (l_srbb.srbb011 - l_srbb.srbb012) * l_sfec[l_j].sum1 / l_sum3
      #数量进行单位取位
      IF NOT cl_null(l_srbb.srbb007) AND NOT cl_null(l_srbc.srbc004) AND l_srbc.srbc004 != 0 THEN
         CALL s_aooi250_take_decimals(l_srbb.srbb007,l_srbc.srbc004) RETURNING l_success,l_srbc.srbc004
         IF NOT l_success THEN
            RETURN r_success
         END IF
      END IF
      IF NOT cl_null(l_srbb.srbb010) AND NOT cl_null(l_srbc.srbc005) AND l_srbc.srbc005 != 0 THEN
         CALL s_aooi250_take_decimals(l_srbb.srbb010,l_srbc.srbc005) RETURNING l_success,l_srbc.srbc005
         IF NOT l_success THEN
            RETURN r_success
         END IF
      END IF
      LET l_srbc.srbc007 = l_sfec[l_j].sum1
#      INSERT INTO srbc_t VALUES l_srbc.* #161124-00048#12 mark
      #161124-00048#12 add(s)
      INSERT INTO srbc_t(srbcent,srbcsite,srbcdocno,srbcseq,srbcseq1,srbc001,srbc002,srbc003,srbc004,srbc005,srbc006,srbc007) 
                  VALUES(l_srbc.srbcent,l_srbc.srbcsite,l_srbc.srbcdocno,l_srbc.srbcseq,l_srbc.srbcseq1,l_srbc.srbc001,l_srbc.srbc002,l_srbc.srbc003,l_srbc.srbc004,l_srbc.srbc005,l_srbc.srbc006,l_srbc.srbc007)
      #161124-00048#12 add(e)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "INS srbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END FOR 
   
   #全部分攤完後若分攤數量合計與差異數有小數尾差，將數量最大的一筆做調整，使分攤合計數與差異數相同
   SELECT SUM(srbc004),SUM(srbc005) INTO l_srbc004,l_srbc005 FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
      AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
   IF l_srbb.srbb008 - l_srbb.srbb009 != l_srbc004 THEN
      #计算出差异数量
      LET l_srbc004 = l_srbb.srbb008 - l_srbb.srbb009 - l_srbc004
      #找出数量最大的(若为负数的时候抓最小值），可能存在数量最大的有多笔情况,若存在，则调整项序小的那笔资料
      IF l_srbb.srbb008 - l_srbb.srbb009 > 0 THEN
         SELECT MAX(srbc004) INTO l_srbc004_max FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
            AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
      ELSE
         SELECT MIN(srbc004) INTO l_srbc004_max FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
            AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
      END IF
      SELECT MIN(srbcseq1) INTO l_srbcseq1_min FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
         AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq AND srbc004=l_srbc004_max
      UPDATE srbc_t SET srbc004=srbc004+l_srbc004 WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
         AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq AND srbcseq1=l_srbcseq1_min AND srbc004=l_srbc004_max
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPD srbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END IF
   IF l_srbb.srbb011 - l_srbb.srbb012 != l_srbc005 THEN
      #计算出差异参考数量
      LET l_srbc005 = l_srbb.srbb011 - l_srbb.srbb012 - l_srbc005
      #找出数量最大的(若为负数的时候抓最小值），可能存在数量最大的有多笔情况,若存在，则调整项序小的那笔资料
      IF l_srbb.srbb011 - l_srbb.srbb012 > 0 THEN
         SELECT MAX(srbc005) INTO l_srbc005_max FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
            AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
      ELSE
         SELECT MIN(srbc005) INTO l_srbc005_max FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
            AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq
      END IF
      SELECT MIN(srbcseq1) INTO l_srbcseq1_min FROM srbc_t WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
         AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq AND srbc005=l_srbc005_max
      UPDATE srbc_t SET srbc005=srbc005+l_srbc005 WHERE srbcent=l_srbb.srbbent AND srbcsite=l_srbb.srbbsite
         AND srbcdocno=l_srbb.srbbdocno AND srbcseq=l_srbb.srbbseq AND srbcseq1=l_srbcseq1_min AND srbc005=l_srbc005_max
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPD srbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#产生分摊明细srbc
PRIVATE FUNCTION asrt350_gen_srbc()
DEFINE l_n               LIKE type_t.num5
DEFINE l_sql             STRING
DEFINE l_srbbseq         LIKE srbb_t.srbbseq

   IF cl_null(g_srba_m.srbadocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asr-00049'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   IF g_srba_m.srbastus != 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asr-00049'
      LET g_errparam.extend = g_srba_m.srbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   SELECT COUNT(*) INTO l_n FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site AND srbcdocno=g_srba_m.srbadocno
   IF l_n > 0 THEN
      IF g_flag5 = 'N' THEN
         IF NOT cl_ask_confirm('asr-00050') THEN
            RETURN
         END IF
      END IF
      DELETE FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site AND srbcdocno=g_srba_m.srbadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del srbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF
   
   LET l_sql = "SELECT srbbseq FROM srbb_t WHERE srbbent=",g_enterprise," AND srbbsite='",g_site,"'",
               "   AND srbbdocno='",g_srba_m.srbadocno,"' AND srbb008 IS NOT NULL AND srbb009 IS NOT NULL AND srbb008 != srbb009"
   PREPARE asrt350_gen_srbc_pre FROM l_sql
   DECLARE asrt350_gen_srbc_cs CURSOR FOR asrt350_gen_srbc_pre
   FOREACH asrt350_gen_srbc_cs INTO l_srbbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN 
      END IF
      
      IF g_srba_m.srba004 = '1' THEN
         IF NOT asrt350_gen_srbc_1(l_srbbseq) THEN
            RETURN 
         END IF
      END IF
      
      IF g_srba_m.srba004 = '2' THEN
         IF NOT asrt350_gen_srbc_2(l_srbbseq) THEN
            RETURN 
         END IF
      END IF
   END FOREACH
   
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = 'asf-00279'
   LET g_errparam.extend = ''
   LET g_errparam.popup = TRUE
   CALL cl_err()

END FUNCTION


#若存在分摊明细资料，修改分摊起讫日期时提示，选否时返回旧值，选是则在AFTER INPUT修改时重新产生分摊明细资料
PRIVATE FUNCTION asrt350_srba001()
DEFINE l_n       LIKE type_t.num5

  SELECT COUNT(*) INTO l_n FROM srbc_t WHERE srbcent=g_enterprise AND srbcsite=g_site AND srbcdocno=g_srba_m.srbadocno
  IF NOT cl_null(g_srba_m.srba001) AND g_srba_m.srba001 != g_srba_m_t.srba001 AND NOT cl_null(g_srba_m_t.srba001) THEN     
     IF l_n > 0 AND g_flag5 = 'N' THEN
        IF NOT cl_ask_confirm('asf-00289') THEN
           LET g_srba_m.srba001 = g_srba_m_t.srba001
        ELSE
           LET g_flag5 = 'Y'
        END IF
     END IF
  END IF
  IF NOT cl_null(g_srba_m.srba002) AND g_srba_m.srba002 != g_srba_m_t.srba002 AND NOT cl_null(g_srba_m_t.srba002) THEN
     IF l_n > 0 AND g_flag5 = 'N' THEN
        IF NOT cl_ask_confirm('asf-00289') THEN
           LET g_srba_m.srba002 = g_srba_m_t.srba002
        ELSE
           LET g_flag5 = 'Y'
        END IF
     END IF
  END IF
  DISPLAY BY NAME g_srba_m.srba001,g_srba_m.srba002
END FUNCTION

#根据最新的srbb单身资料抓取最新的数量，并清空盘点数量
PRIVATE FUNCTION asrt350_reproduce_upd()
DEFINE l_sql             STRING
DEFINE l_inag008         LIKE inag_t.inag008
DEFINE l_inag024         LIKE inag_t.inag024
DEFINE l_inag025         LIKE inag_t.inag025
#   DEFINE  l_srbb                RECORD LIKE srbb_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srbb RECORD  #重複性生產期末盤點單身檔
       srbbent LIKE srbb_t.srbbent, #企业编号
       srbbsite LIKE srbb_t.srbbsite, #营运据点
       srbbdocno LIKE srbb_t.srbbdocno, #盘点单号
       srbbseq LIKE srbb_t.srbbseq, #项次
       srbb001 LIKE srbb_t.srbb001, #料件编号
       srbb002 LIKE srbb_t.srbb002, #产品特征
       srbb003 LIKE srbb_t.srbb003, #库位
       srbb004 LIKE srbb_t.srbb004, #储位
       srbb005 LIKE srbb_t.srbb005, #批号
       srbb006 LIKE srbb_t.srbb006, #库存特征
       srbb007 LIKE srbb_t.srbb007, #单位
       srbb008 LIKE srbb_t.srbb008, #账面数量
       srbb009 LIKE srbb_t.srbb009, #盘点数量
       srbb010 LIKE srbb_t.srbb010, #参考单位
       srbb011 LIKE srbb_t.srbb011, #参考账面数量
       srbb012 LIKE srbb_t.srbb012  #参考盘点数量
END RECORD
#161124-00048#12 add(e)
DEFINE l_success         LIKE type_t.num5
DEFINE l_rate            LIKE srbc_t.srbc007

#   LET l_sql = "SELECT * FROM srbb_t WHERE srbbent=",g_enterprise," AND srbbdocno='",g_srba_m.srbadocno,"'" #161124-00048#12 mark
   #161124-00048#12 add(s)
   LET l_sql = "SELECT srbcent,srbcsite,srbcdocno,srbcseq,srbcseq1,srbc001,",
               "       srbc002,srbc003,srbc004,srbc005,srbc006,srbc007 ",
               " FROM srbb_t WHERE srbbent=",g_enterprise," AND srbbdocno='",g_srba_m.srbadocno,"'"
   #161124-00048#12 add(e)
   PREPARE asrt350_reproduce_upd_pre FROM l_sql
   DECLARE asrt350_reproduce_upd_cs CURSOR FOR asrt350_reproduce_upd_pre
   FOREACH asrt350_reproduce_upd_cs INTO l_srbb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN 
      END IF
      SELECT inag008,inag024,inag025 INTO l_inag008,l_inag024,l_inag025 FROM inag_t WHERE inagent = g_enterprise AND inagsite = g_site
         AND inag001 = l_srbb.srbb001 AND inag002 = l_srbb.srbb002 AND inag003 = l_srbb.srbb006 AND inag004 = l_srbb.srbb003
         AND inag005 = l_srbb.srbb004 AND inag006 = l_srbb.srbb005 AND inag007 = l_srbb.srbb007 
      IF cl_null(l_inag008) THEN
         LET l_inag008 = 0
      END IF
      IF NOT cl_null(l_inag024) AND NOT cl_null(l_srbb.srbb010) THEN
         CALL s_aimi190_get_convert(l_srbb.srbb001,l_inag024,l_srbb.srbb010) RETURNING l_success,l_rate 
         IF NOT l_success THEN
            LET l_rate = 1
         END IF             
         LET l_inag025 = l_inag025 * l_rate
      END IF
      IF cl_null(l_inag025) THEN
         LET l_inag025 = 0
      END IF
      IF cl_null(l_srbb.srbb010) THEN
         LET l_inag025 = ''
      END IF
      UPDATE srbb_t SET srbb008=l_inag008,srbb009='',srbb011=l_inag025,srbb012=''
       WHERE srbbent=g_enterprise AND srbbdocno=g_srba_m.srbadocno AND srbbseq=l_srbb.srbbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPD srbb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END FOREACH
END FUNCTION

 
{</section>}
 
