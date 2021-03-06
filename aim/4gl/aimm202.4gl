#該程式未解開Section, 採用最新樣板產出!
{<section id="aimm202.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0025(2017-01-18 10:35:40), PR版次:0025(2017-03-06 17:44:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000419
#+ Filename...: aimm202
#+ Description: 集團預設料件據點庫存資料維護作業
#+ Creator....: 02482(2013-07-16 14:05:23)
#+ Modifier...: 04543 -SD/PR- 09276
 
{</section>}
 
{<section id="aimm202.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160107-00003#10   2016/01/29   By fionchen  成本據點數據沒有反應
#160318-00005#20   2016/03/30   by 07675     將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#17   2016/04/11   By 07900     校验代码的重复错误讯息修改 
#160511-00040#2    2016/05/25   BY ming      分銷與製造料件合併處理，imaf053回寫imaa104
#160617-00004#2    2016/07/05   By lixiang   #1.「是否產生條碼」、「條碼編碼方式」、「條碼包裝數量」由aimm201移到aimm202的相關資料「箱盒號條碼管理」
                                             #2.「是否產生條碼」更名為「箱盒號條碼管理」，原「箱盒號條碼管理」從畫面拿掉，並把欄位名稱改為no use
#160705-00042#11   2016/07/14   By sakura    程式中寫死g_prog部分改寫MATCHES方式 
#161124-00048#2    2016/12/07   By 08734     星号整批调整
#161219-00027#1    2016/12/20   By ywtsai    倉管員全名直接取員工資料檔的全名(ooag011)
#161215-00006#6    2017/01/18   By earl      條碼規則邏輯修改
#170301-00017#8    2017/03/06   By 09276     修改g_prog的判斷
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
PRIVATE TYPE type_g_imaf_m RECORD
       imaf001 LIKE imaf_t.imaf001, 
   imaa002 LIKE imaa_t.imaa002, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   imaal005 LIKE imaal_t.imaal005, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr80, 
   imaa003 LIKE imaa_t.imaa003, 
   imaa003_desc LIKE type_t.chr80, 
   imaa004 LIKE imaa_t.imaa004, 
   imaa005 LIKE imaa_t.imaa005, 
   imaa005_desc LIKE type_t.chr80, 
   imaa006 LIKE imaa_t.imaa006, 
   imaa006_desc LIKE type_t.chr80, 
   imaa010 LIKE imaa_t.imaa010, 
   imaa010_desc LIKE type_t.chr80, 
   s1 LIKE type_t.chr500, 
   imaf051 LIKE imaf_t.imaf051, 
   imaf051_desc LIKE type_t.chr80, 
   imaf052 LIKE imaf_t.imaf052, 
   imaf052_desc LIKE type_t.chr80, 
   imaf053 LIKE imaf_t.imaf053, 
   imaf053_desc LIKE type_t.chr80, 
   imaf054 LIKE imaf_t.imaf054, 
   imaf055 LIKE imaf_t.imaf055, 
   imaf057 LIKE imaf_t.imaf057, 
   imaf058 LIKE imaf_t.imaf058, 
   imaf059 LIKE imaf_t.imaf059, 
   imafownid LIKE imaf_t.imafownid, 
   imafownid_desc LIKE type_t.chr80, 
   imafowndp LIKE imaf_t.imafowndp, 
   imafowndp_desc LIKE type_t.chr80, 
   imafcrtid LIKE imaf_t.imafcrtid, 
   imafcrtid_desc LIKE type_t.chr80, 
   imafcrtdp LIKE imaf_t.imafcrtdp, 
   imafcrtdp_desc LIKE type_t.chr80, 
   imafcrtdt LIKE imaf_t.imafcrtdt, 
   imafmodid LIKE imaf_t.imafmodid, 
   imafmodid_desc LIKE type_t.chr80, 
   imafmoddt LIKE imaf_t.imafmoddt, 
   imafcnfid LIKE imaf_t.imafcnfid, 
   imafcnfid_desc LIKE type_t.chr80, 
   imafcnfdt LIKE imaf_t.imafcnfdt, 
   imaf061 LIKE imaf_t.imaf061, 
   imaf062 LIKE imaf_t.imaf062, 
   imaf063 LIKE imaf_t.imaf063, 
   imaf063_desc LIKE type_t.chr80, 
   imaf064 LIKE imaf_t.imaf064, 
   imaf071 LIKE imaf_t.imaf071, 
   imaf072 LIKE imaf_t.imaf072, 
   imaf073 LIKE imaf_t.imaf073, 
   imaf073_desc LIKE type_t.chr80, 
   imaf074 LIKE imaf_t.imaf074, 
   imaf081 LIKE imaf_t.imaf081, 
   imaf082 LIKE imaf_t.imaf082, 
   imaf083 LIKE imaf_t.imaf083, 
   imaf083_desc LIKE type_t.chr80, 
   imaf084 LIKE imaf_t.imaf084, 
   imaf091 LIKE imaf_t.imaf091, 
   imaf091_desc LIKE type_t.chr80, 
   imaf092 LIKE imaf_t.imaf092, 
   imaf092_desc LIKE type_t.chr80, 
   imaf177 LIKE imaf_t.imaf177, 
   imaf178 LIKE imaf_t.imaf178, 
   imaf178_desc LIKE type_t.chr80, 
   imaf179 LIKE imaf_t.imaf179, 
   imaf101 LIKE imaf_t.imaf101, 
   imaf102 LIKE imaf_t.imaf102, 
   imaf094 LIKE imaf_t.imaf094, 
   imaf095 LIKE imaf_t.imaf095, 
   imai031 LIKE imai_t.imai031, 
   imai032 LIKE imai_t.imai032, 
   imai033 LIKE imai_t.imai033, 
   imai034 LIKE imai_t.imai034, 
   imai035 LIKE imai_t.imai035, 
   imai036 LIKE imai_t.imai036, 
   imai037 LIKE imai_t.imai037, 
   imaf096 LIKE imaf_t.imaf096
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_imaf001 LIKE imaf_t.imaf001,
   b_imaal003 LIKE imaal_t.imaal003,
   b_imaal004 LIKE imaal_t.imaal004,
   b_imaa009 LIKE imaa_t.imaa009,
   b_imaa009_desc LIKE type_t.chr80,
   b_imaa003 LIKE imaa_t.imaa003,
   b_imaa003_desc LIKE type_t.chr80,
      b_imaf051 LIKE imaf_t.imaf051,
   b_oocql004 LIKE oocql_t.oocql004
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_ooag002             LIKE ooag_t.ooag002
DEFINE l_success             LIKE type_t.num5
DEFINE g_site1               LIKE type_t.chr80
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imaf_m        type_g_imaf_m  #單頭變數宣告
DEFINE g_imaf_m_t      type_g_imaf_m  #單頭舊值宣告(系統還原用)
DEFINE g_imaf_m_o      type_g_imaf_m  #單頭舊值宣告(其他用途)
DEFINE g_imaf_m_mask_o type_g_imaf_m  #轉換遮罩前資料
DEFINE g_imaf_m_mask_n type_g_imaf_m  #轉換遮罩後資料
 
   DEFINE g_imaf001_t LIKE imaf_t.imaf001
 
   
 
   
DEFINE g_master_multi_table_t    RECORD
      imaal001 LIKE imaal_t.imaal001,
      imaal003 LIKE imaal_t.imaal003,
      imaal004 LIKE imaal_t.imaal004,
      imaal005 LIKE imaal_t.imaal005
      END RECORD
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization" 

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aimm202.main" >}
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
   CALL cl_ap_init("aim","")
 
   #add-point:作業初始化 name="main.init"
   LET g_site1 = g_site
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_imaf_m.imaf001 = g_argv[02]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imaf001,'','','','','','','','','','','','','','','','',imaf051,'',imaf052, 
       '',imaf053,'',imaf054,imaf055,imaf057,imaf058,imaf059,imafownid,'',imafowndp,'',imafcrtid,'', 
       imafcrtdp,'',imafcrtdt,imafmodid,'',imafmoddt,imafcnfid,'',imafcnfdt,imaf061,imaf062,imaf063, 
       '',imaf064,imaf071,imaf072,imaf073,'',imaf074,imaf081,imaf082,imaf083,'',imaf084,imaf091,'',imaf092, 
       '',imaf177,imaf178,'',imaf179,imaf101,imaf102,imaf094,imaf095,'','','','','','','',imaf096",  
 
                      " FROM imaf_t",
                      " WHERE imafent= ? AND imafsite= ? AND imaf001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimm202_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imaf001,t0.imaf051,t0.imaf052,t0.imaf053,t0.imaf054,t0.imaf055,t0.imaf057, 
       t0.imaf058,t0.imaf059,t0.imafownid,t0.imafowndp,t0.imafcrtid,t0.imafcrtdp,t0.imafcrtdt,t0.imafmodid, 
       t0.imafmoddt,t0.imafcnfid,t0.imafcnfdt,t0.imaf061,t0.imaf062,t0.imaf063,t0.imaf064,t0.imaf071, 
       t0.imaf072,t0.imaf073,t0.imaf074,t0.imaf081,t0.imaf082,t0.imaf083,t0.imaf084,t0.imaf091,t0.imaf092, 
       t0.imaf177,t0.imaf178,t0.imaf179,t0.imaf101,t0.imaf102,t0.imaf094,t0.imaf095,t0.imaf096,t1.oocql004 , 
       t2.ooag011 ,t3.oocal003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011 , 
       t10.oofgl004",
               " FROM imaf_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='201' AND t1.oocql002=t0.imaf051 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.imaf052  ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imaf053 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.imafownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.imafowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.imafcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.imafcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.imafmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.imafcnfid  ",
               " LEFT JOIN oofgl_t t10 ON t10.oofglent="||g_enterprise||" AND t10.oofgl001=' ' AND t10.oofgl002=t0.imaf178 AND t10.oofgl003='"||g_dlang||"' ",
 
               " WHERE t0.imafent = " ||g_enterprise|| " AND t0.imafsite = ? AND t0.imaf001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimm202_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimm202 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimm202_init()   
 
      #進入選單 Menu (="N")
      CALL aimm202_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimm202
      
   END IF 
   
   CLOSE aimm202_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimm202.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimm202_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
      CALL cl_set_combo_scc('imaa004','1001') 
   CALL cl_set_combo_scc('imaf055','1019') 
   CALL cl_set_combo_scc('imaf057','36') 
   CALL cl_set_combo_scc('imaf058','1010') 
   CALL cl_set_combo_scc('imaf059','1011') 
   CALL cl_set_combo_scc('imaf061','1012') 
   CALL cl_set_combo_scc('imaf064','1014') 
   CALL cl_set_combo_scc('imaf071','1012') 
   CALL cl_set_combo_scc('imaf074','1014') 
   CALL cl_set_combo_scc('imaf081','1013') 
   CALL cl_set_combo_scc('imaf084','1014') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_combo_scc("imaa004",1001)
   CALL cl_set_combo_scc("s1",13)
   #CALL cl_set_combo_scc("imaf055",1019)
   #CALL cl_set_combo_scc("imaf057",36)
   #CALL cl_set_combo_scc("imaf058",1010)
   #CALL cl_set_combo_scc("imaf059",1011)
   #CALL cl_set_combo_scc("imaf061",1012)
   #CALL cl_set_combo_scc("imaf064",1014)
   #CALL cl_set_combo_scc("imaf071",1012)
   #CALL cl_set_combo_scc("imaf074",1014)
   #CALL cl_set_combo_scc("imaf081",1013)
   #CALL cl_set_combo_scc("imaf084",1014)
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aimm202_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimm202_ui_dialog() 
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_ooef017  LIKE ooef_t.ooef017 #160107-00003#10 add
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   #若有外部參數查詢, 則直接顯示資料(隱藏查詢方案)
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
   
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_imaf_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aimm202_init()
      END IF
      
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL aimm202_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimm202_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimm202' THEN        #160705-00042#11 160714 by sakura mark    
               #IF g_prog MATCHES 'aimm202' THEN  #160705-00042#11 160714 by sakura add #170301-00017#8 mark
               IF g_prog MATCHES 'aimm202*' THEN  #170301-00017#8  09276 add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL aimm202_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimm202_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aimm202_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aimm202_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aimm202_fetch("L")  
               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
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
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
            
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
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aimm202_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimm202_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimm202_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimm202_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm207
            LET g_action_choice="open_aimm207"
            IF cl_auth_chk_act("open_aimm207") THEN
               
               #add-point:ON ACTION open_aimm207 name="menu2.open_aimm207"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  CALL cl_cmdrun(" aimm207 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm200
            LET g_action_choice="open_aimm200"
            IF cl_auth_chk_act("open_aimm200") THEN
               
               #add-point:ON ACTION open_aimm200 name="menu2.open_aimm200"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  CALL cl_cmdrun(" aimm200 '"||g_imaf_m.imaf001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm206
            LET g_action_choice="open_aimm206"
            IF cl_auth_chk_act("open_aimm206") THEN
               
               #add-point:ON ACTION open_aimm206 name="menu2.open_aimm206"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm206 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm216 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm204
            LET g_action_choice="open_aimm204"
            IF cl_auth_chk_act("open_aimm204") THEN
               
               #add-point:ON ACTION open_aimm204 name="menu2.open_aimm204"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm204 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm214 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm210
            LET g_action_choice="open_aimm210"
            IF cl_auth_chk_act("open_aimm210") THEN
               
               #add-point:ON ACTION open_aimm210 name="menu2.open_aimm210"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm210 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm220 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION aimm201_01
            LET g_action_choice="aimm201_01"
            IF cl_auth_chk_act("aimm201_01") THEN
               
               #add-point:ON ACTION aimm201_01 name="menu2.aimm201_01"
               CALL aimm201_01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimm202_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm201
            LET g_action_choice="open_aimm201"
            IF cl_auth_chk_act("open_aimm201") THEN
               
               #add-point:ON ACTION open_aimm201 name="menu2.open_aimm201"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm201 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm211 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm203
            LET g_action_choice="open_aimm203"
            IF cl_auth_chk_act("open_aimm203") THEN
               
               #add-point:ON ACTION open_aimm203 name="menu2.open_aimm203"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm203 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm213 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm205
            LET g_action_choice="open_aimm205"
            IF cl_auth_chk_act("open_aimm205") THEN
               
               #add-point:ON ACTION open_aimm205 name="menu2.open_aimm205"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm205 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm215 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm208
            LET g_action_choice="open_aimm208"
            IF cl_auth_chk_act("open_aimm208") THEN
               
               #add-point:ON ACTION open_aimm208 name="menu2.open_aimm208"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  CALL cl_cmdrun(" aimm208 '"||g_imaf_m.imaf001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa009
            LET g_action_choice="prog_imaa009"
            IF cl_auth_chk_act("prog_imaa009") THEN
               
               #add-point:ON ACTION prog_imaa009 name="menu2.prog_imaa009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imaf_m.imaa009)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa003
            LET g_action_choice="prog_imaa003"
            IF cl_auth_chk_act("prog_imaa003") THEN
               
               #add-point:ON ACTION prog_imaa003 name="menu2.prog_imaa003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imaf_m.imaa003)


               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimm202_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimm202_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimm202_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL aimm202_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
            #查詢方案用
            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
            SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL aimm202_browser_fill(g_wc,"")
               END IF
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #還原為原本指定筆數
               IF g_current_row > 1 THEN
                  #當刪除最後一筆資料時可能產生錯誤, 進行額外判斷
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  LET g_current_idx = g_current_row
                  CALL DIALOG.setCurrentRow("s_browse",g_current_idx)
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimm202_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimm202' THEN        #160705-00042#11 160714 by sakura mark
               #IF g_prog MATCHES 'aimm202' THEN  #160705-00042#11 160714 by sakura add #170301-00017#8 mark
               IF g_prog MATCHES 'aimm202*' THEN  #170301-00017#8  09276 add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
 
 
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aimm202_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aimm202_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimm202_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aimm202_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aimm202_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aimm202_fetch("L")  
               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
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
               #EXIT DIALOG
               
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
               #EXIT DIALOG
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
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
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL aimm202_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimm202_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimm202_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimm202_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm207
            LET g_action_choice="open_aimm207"
            IF cl_auth_chk_act("open_aimm207") THEN
               
               #add-point:ON ACTION open_aimm207 name="menu.open_aimm207"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  CALL cl_cmdrun(" aimm207 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm200
            LET g_action_choice="open_aimm200"
            IF cl_auth_chk_act("open_aimm200") THEN
               
               #add-point:ON ACTION open_aimm200 name="menu.open_aimm200"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  CALL cl_cmdrun(" aimm200 '"||g_imaf_m.imaf001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm206
            LET g_action_choice="open_aimm206"
            IF cl_auth_chk_act("open_aimm206") THEN
               
               #add-point:ON ACTION open_aimm206 name="menu.open_aimm206"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm206 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm216 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm204
            LET g_action_choice="open_aimm204"
            IF cl_auth_chk_act("open_aimm204") THEN
               
               #add-point:ON ACTION open_aimm204 name="menu.open_aimm204"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm204 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm214 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm210
            LET g_action_choice="open_aimm210"
            IF cl_auth_chk_act("open_aimm210") THEN
               
               #add-point:ON ACTION open_aimm210 name="menu.open_aimm210"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm210 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm220 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
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
         ON ACTION aimm201_01
            LET g_action_choice="aimm201_01"
            IF cl_auth_chk_act("aimm201_01") THEN
               
               #add-point:ON ACTION aimm201_01 name="menu.aimm201_01"
               CALL aimm201_01()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimm202_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm201
            LET g_action_choice="open_aimm201"
            IF cl_auth_chk_act("open_aimm201") THEN
               
               #add-point:ON ACTION open_aimm201 name="menu.open_aimm201"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm201 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm211 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm203
            LET g_action_choice="open_aimm203"
            IF cl_auth_chk_act("open_aimm203") THEN
               
               #add-point:ON ACTION open_aimm203 name="menu.open_aimm203"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm203 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm213 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm205
            LET g_action_choice="open_aimm205"
            IF cl_auth_chk_act("open_aimm205") THEN
               
               #add-point:ON ACTION open_aimm205 name="menu.open_aimm205"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm205 '"||g_imaf_m.imaf001||"'")
                  ELSE
                     CALL cl_cmdrun(" aimm215 '"||g_site||"' '"||g_imaf_m.imaf001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm208
            LET g_action_choice="open_aimm208"
            IF cl_auth_chk_act("open_aimm208") THEN
               
               #add-point:ON ACTION open_aimm208 name="menu.open_aimm208"
               IF NOT cl_null(g_imaf_m.imaf001) THEN
                  CALL cl_cmdrun(" aimm208 '"||g_imaf_m.imaf001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa009
            LET g_action_choice="prog_imaa009"
            IF cl_auth_chk_act("prog_imaa009") THEN
               
               #add-point:ON ACTION prog_imaa009 name="menu.prog_imaa009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imaf_m.imaa009)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa003
            LET g_action_choice="prog_imaa003"
            IF cl_auth_chk_act("prog_imaa003") THEN
               
               #add-point:ON ACTION prog_imaa003 name="menu.prog_imaa003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imaf_m.imaa003)


               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimm202_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimm202_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimm202_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      
      #(ver:50) ---start---
      IF li_exit THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      #(ver:50) --- end ---
 
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aimm202_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "imaf001"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM imaf_t ",
               "  ",
               "  LEFT JOIN imaal_t ON imaalent = "||g_enterprise||" AND imaf001 = imaal001 AND imaal002 = '",g_dlang,"' ",
               " WHERE imafent = " ||g_enterprise|| " AND imafsite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("imaf_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   LET g_sql = "SELECT COUNT(*) FROM imaf_t ",
               "  LEFT JOIN imaal_t ON imafent = imaalent AND imaf001 = imaal001 AND imaal002 = '",g_lang,"' ",
               "  LEFT JOIN imai_t ON imafent = imaient AND imaf001 = imai001 AND imafsite=imaisite ",
               " , imaa_t ",
               " WHERE imafent = imaaent AND imaf001 = imaa001 ",
               "   AND imafent = '" ||g_enterprise|| "' AND imafsite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED
   #end add-point
                
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt
      FREE header_cnt_pre 
   END IF
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   LET g_error_show = 0
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_imaf_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.imafstus,t0.imaf001,t0.imaf051",
               " FROM imaf_t t0 ",
               "  ",
               
               " LEFT JOIN imaal_t ON imaalent = "||g_enterprise||" AND imaf001 = imaal001 AND imaal002 = '",g_dlang,"' ",
               " WHERE t0.imafent = " ||g_enterprise|| " AND t0.imafsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imaf_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
#   LET l_sql_rank = "SELECT imafstus,imaf001,'','','','','','',imaf051,'',RANK() OVER(ORDER BY imaf001 ", 
#                    g_order,
#                    ") AS RANK ",
#                    " FROM imaf_t,imaa_t ",
#                    "  LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_lang,"' ",
#                    " WHERE imafent = imaaent AND imaf001 = imaa001 ",
#                    "   AND imafent = '" ||g_enterprise|| "' AND imafsite = '" ||g_site|| "' AND ",g_wc 

   LET g_sql = " SELECT t0.imafstus,t0.imaf001,t0.imaf051",
               " FROM imaf_t t0 ",
               "  ",
               
               " LEFT JOIN imaal_t ON imaalent = '"||g_enterprise||"' AND imaf001 = imaal001 AND imaal002 = '",g_dlang,"' ",
               " LEFT JOIN imai_t ON imaient = imafent AND imaisite = imafsite AND imai001=t0.imaf001 ",
               " ,imaa_t  ",
 
               " WHERE t0.imafent = imaaent AND t0.imaf001 = imaa001 ",
               "   AND t0.imafent = '" ||g_enterprise|| "' AND t0.imafsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imaf_t")
               
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order             
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"imaf_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imaf001,g_browser[g_cnt].b_imaf051 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      SELECT imaal003,imaal004
        INTO g_browser[g_cnt].b_imaal003,g_browser[g_cnt].b_imaal004
        FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_browser[g_cnt].b_imaf001
         AND imaal002 = g_dlang

      SELECT imaa009,imaa003
        INTO g_browser[g_cnt].b_imaa009,g_browser[g_cnt].b_imaa003
        FROM imaa_t
       WHERE imaa001 = g_browser[g_cnt].b_imaf001
         AND imaaent = g_enterprise

      SELECT rtaxl003 INTO g_browser[g_cnt].b_imaa009_desc
        FROM rtaxl_t
       WHERE rtaxl001 = g_browser[g_cnt].b_imaa009
         AND rtaxl002 = g_dlang
         AND rtaxlent = g_enterprise

      SELECT oocql004 INTO g_browser[g_cnt].b_imaa003_desc
        FROM oocql_t
       WHERE oocql001 = '200'
         AND oocql002 = g_browser[g_cnt].b_imaa003
         AND oocql003 = g_dlang
         AND oocqlent = g_enterprise

      SELECT oocql004 INTO g_browser[g_cnt].b_oocql004
        FROM oocql_t
       WHERE oocql001 = '201'
         AND oocql002 = g_browser[g_cnt].b_imaf051
         AND oocql003 = g_dlang
         AND oocqlent = g_enterprise
         #end add-point
         
         #遮罩相關處理
         CALL aimm202_browser_mask()
         
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
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
   
   IF cl_null(g_browser[g_cnt].b_imaf001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimm202.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimm202_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_imaf_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON imaf001,imaa002,imaal003,imaal004,imaal005,imaa009,imaa003,imaa004,imaa005, 
          imaa006,imaa010,imaf051,imaf052,imaf053,imaf054,imaf055,imaf057,imaf058,imaf059,imafownid, 
          imafowndp,imafcrtid,imafcrtdp,imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt,imaf061,imaf062, 
          imaf063,imaf064,imaf071,imaf072,imaf073,imaf074,imaf081,imaf082,imaf083,imaf084,imaf091,imaf092, 
          imaf177,imaf178,imaf179,imaf101,imaf102,imaf094,imaf095,imai031,imai032,imai033,imai034,imai035, 
          imai036,imai037,imaf096
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imafcrtdt>>----
         AFTER FIELD imafcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imafmoddt>>----
         AFTER FIELD imafmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imafcnfdt>>----
         AFTER FIELD imafcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imafpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.imaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf001
            #add-point:ON ACTION controlp INFIELD imaf001 name="construct.c.imaf001"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf001  #顯示到畫面上

            NEXT FIELD imaf001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf001
            #add-point:BEFORE FIELD imaf001 name="construct.b.imaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf001
            
            #add-point:AFTER FIELD imaf001 name="construct.a.imaf001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa002
            #add-point:BEFORE FIELD imaa002 name="construct.b.imaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa002
            
            #add-point:AFTER FIELD imaa002 name="construct.a.imaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa002
            #add-point:ON ACTION controlp INFIELD imaa002 name="construct.c.imaa002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal003
            #add-point:BEFORE FIELD imaal003 name="construct.b.imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal003
            
            #add-point:AFTER FIELD imaal003 name="construct.a.imaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal003
            #add-point:ON ACTION controlp INFIELD imaal003 name="construct.c.imaal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004
            #add-point:BEFORE FIELD imaal004 name="construct.b.imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004
            
            #add-point:AFTER FIELD imaal004 name="construct.a.imaal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004
            #add-point:ON ACTION controlp INFIELD imaal004 name="construct.c.imaal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal005
            #add-point:BEFORE FIELD imaal005 name="construct.b.imaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal005
            
            #add-point:AFTER FIELD imaal005 name="construct.a.imaal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal005
            #add-point:ON ACTION controlp INFIELD imaal005 name="construct.c.imaal005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="construct.c.imaa003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imck001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上

            NEXT FIELD imaa003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="construct.b.imaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="construct.a.imaa003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa004
            #add-point:BEFORE FIELD imaa004 name="construct.b.imaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa004
            
            #add-point:AFTER FIELD imaa004 name="construct.a.imaa004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa004
            #add-point:ON ACTION controlp INFIELD imaa004 name="construct.c.imaa004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa005
            #add-point:ON ACTION controlp INFIELD imaa005 name="construct.c.imaa005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa005  #顯示到畫面上

            NEXT FIELD imaa005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa005
            #add-point:BEFORE FIELD imaa005 name="construct.b.imaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa005
            
            #add-point:AFTER FIELD imaa005 name="construct.a.imaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa006
            #add-point:ON ACTION controlp INFIELD imaa006 name="construct.c.imaa006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa006  #顯示到畫面上

            NEXT FIELD imaa006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa006
            #add-point:BEFORE FIELD imaa006 name="construct.b.imaa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa006
            
            #add-point:AFTER FIELD imaa006 name="construct.a.imaa006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa010
            #add-point:ON ACTION controlp INFIELD imaa010 name="construct.c.imaa010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "210" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa010  #顯示到畫面上

            NEXT FIELD imaa010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa010
            #add-point:BEFORE FIELD imaa010 name="construct.b.imaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa010
            
            #add-point:AFTER FIELD imaa010 name="construct.a.imaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf051
            #add-point:ON ACTION controlp INFIELD imaf051 name="construct.c.imaf051"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #CALL q_imcc051()                           #呼叫開窗
            IF g_site = 'ALL' THEN
               CALL q_imcc051()
            ELSE
               LET g_qryparam.arg1 = '201'
               CALL q_oocq002()
            END IF
            DISPLAY g_qryparam.return1 TO imaf051  #顯示到畫面上

            NEXT FIELD imaf051                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf051
            #add-point:BEFORE FIELD imaf051 name="construct.b.imaf051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf051
            
            #add-point:AFTER FIELD imaf051 name="construct.a.imaf051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf052
            #add-point:ON ACTION controlp INFIELD imaf052 name="construct.c.imaf052"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf052  #顯示到畫面上

            NEXT FIELD imaf052                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf052
            #add-point:BEFORE FIELD imaf052 name="construct.b.imaf052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf052
            
            #add-point:AFTER FIELD imaf052 name="construct.a.imaf052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf053
            #add-point:ON ACTION controlp INFIELD imaf053 name="construct.c.imaf053"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf053  #顯示到畫面上

            NEXT FIELD imaf053                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf053
            #add-point:BEFORE FIELD imaf053 name="construct.b.imaf053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf053
            
            #add-point:AFTER FIELD imaf053 name="construct.a.imaf053"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf054
            #add-point:BEFORE FIELD imaf054 name="construct.b.imaf054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf054
            
            #add-point:AFTER FIELD imaf054 name="construct.a.imaf054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf054
            #add-point:ON ACTION controlp INFIELD imaf054 name="construct.c.imaf054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf055
            #add-point:BEFORE FIELD imaf055 name="construct.b.imaf055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf055
            
            #add-point:AFTER FIELD imaf055 name="construct.a.imaf055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf055
            #add-point:ON ACTION controlp INFIELD imaf055 name="construct.c.imaf055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf057
            #add-point:BEFORE FIELD imaf057 name="construct.b.imaf057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf057
            
            #add-point:AFTER FIELD imaf057 name="construct.a.imaf057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf057
            #add-point:ON ACTION controlp INFIELD imaf057 name="construct.c.imaf057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf058
            #add-point:BEFORE FIELD imaf058 name="construct.b.imaf058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf058
            
            #add-point:AFTER FIELD imaf058 name="construct.a.imaf058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf058
            #add-point:ON ACTION controlp INFIELD imaf058 name="construct.c.imaf058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf059
            #add-point:BEFORE FIELD imaf059 name="construct.b.imaf059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf059
            
            #add-point:AFTER FIELD imaf059 name="construct.a.imaf059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf059
            #add-point:ON ACTION controlp INFIELD imaf059 name="construct.c.imaf059"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imafownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafownid
            #add-point:ON ACTION controlp INFIELD imafownid name="construct.c.imafownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafownid  #顯示到畫面上

            NEXT FIELD imafownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafownid
            #add-point:BEFORE FIELD imafownid name="construct.b.imafownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafownid
            
            #add-point:AFTER FIELD imafownid name="construct.a.imafownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imafowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafowndp
            #add-point:ON ACTION controlp INFIELD imafowndp name="construct.c.imafowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafowndp  #顯示到畫面上

            NEXT FIELD imafowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafowndp
            #add-point:BEFORE FIELD imafowndp name="construct.b.imafowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafowndp
            
            #add-point:AFTER FIELD imafowndp name="construct.a.imafowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imafcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafcrtid
            #add-point:ON ACTION controlp INFIELD imafcrtid name="construct.c.imafcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafcrtid  #顯示到畫面上

            NEXT FIELD imafcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcrtid
            #add-point:BEFORE FIELD imafcrtid name="construct.b.imafcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafcrtid
            
            #add-point:AFTER FIELD imafcrtid name="construct.a.imafcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imafcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafcrtdp
            #add-point:ON ACTION controlp INFIELD imafcrtdp name="construct.c.imafcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafcrtdp  #顯示到畫面上

            NEXT FIELD imafcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcrtdp
            #add-point:BEFORE FIELD imafcrtdp name="construct.b.imafcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafcrtdp
            
            #add-point:AFTER FIELD imafcrtdp name="construct.a.imafcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcrtdt
            #add-point:BEFORE FIELD imafcrtdt name="construct.b.imafcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imafmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafmodid
            #add-point:ON ACTION controlp INFIELD imafmodid name="construct.c.imafmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafmodid  #顯示到畫面上

            NEXT FIELD imafmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafmodid
            #add-point:BEFORE FIELD imafmodid name="construct.b.imafmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafmodid
            
            #add-point:AFTER FIELD imafmodid name="construct.a.imafmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafmoddt
            #add-point:BEFORE FIELD imafmoddt name="construct.b.imafmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imafcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imafcnfid
            #add-point:ON ACTION controlp INFIELD imafcnfid name="construct.c.imafcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imafcnfid  #顯示到畫面上

            NEXT FIELD imafcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcnfid
            #add-point:BEFORE FIELD imafcnfid name="construct.b.imafcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imafcnfid
            
            #add-point:AFTER FIELD imafcnfid name="construct.a.imafcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imafcnfdt
            #add-point:BEFORE FIELD imafcnfdt name="construct.b.imafcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf061
            #add-point:BEFORE FIELD imaf061 name="construct.b.imaf061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf061
            
            #add-point:AFTER FIELD imaf061 name="construct.a.imaf061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf061
            #add-point:ON ACTION controlp INFIELD imaf061 name="construct.c.imaf061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf062
            #add-point:BEFORE FIELD imaf062 name="construct.b.imaf062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf062
            
            #add-point:AFTER FIELD imaf062 name="construct.a.imaf062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf062
            #add-point:ON ACTION controlp INFIELD imaf062 name="construct.c.imaf062"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaf063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf063
            #add-point:ON ACTION controlp INFIELD imaf063 name="construct.c.imaf063"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1  = '6'     #6.庫存批號
            CALL q_oofg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf063  #顯示到畫面上
            NEXT FIELD imaf063                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf063
            #add-point:BEFORE FIELD imaf063 name="construct.b.imaf063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf063
            
            #add-point:AFTER FIELD imaf063 name="construct.a.imaf063"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf064
            #add-point:BEFORE FIELD imaf064 name="construct.b.imaf064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf064
            
            #add-point:AFTER FIELD imaf064 name="construct.a.imaf064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf064
            #add-point:ON ACTION controlp INFIELD imaf064 name="construct.c.imaf064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf071
            #add-point:BEFORE FIELD imaf071 name="construct.b.imaf071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf071
            
            #add-point:AFTER FIELD imaf071 name="construct.a.imaf071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf071
            #add-point:ON ACTION controlp INFIELD imaf071 name="construct.c.imaf071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf072
            #add-point:BEFORE FIELD imaf072 name="construct.b.imaf072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf072
            
            #add-point:AFTER FIELD imaf072 name="construct.a.imaf072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf072
            #add-point:ON ACTION controlp INFIELD imaf072 name="construct.c.imaf072"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaf073
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf073
            #add-point:ON ACTION controlp INFIELD imaf073 name="construct.c.imaf073"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1  = '7'     #製造批號 
            CALL q_oofg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf073  #顯示到畫面上
            NEXT FIELD imaf073                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf073
            #add-point:BEFORE FIELD imaf073 name="construct.b.imaf073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf073
            
            #add-point:AFTER FIELD imaf073 name="construct.a.imaf073"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf074
            #add-point:BEFORE FIELD imaf074 name="construct.b.imaf074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf074
            
            #add-point:AFTER FIELD imaf074 name="construct.a.imaf074"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf074
            #add-point:ON ACTION controlp INFIELD imaf074 name="construct.c.imaf074"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf081
            #add-point:BEFORE FIELD imaf081 name="construct.b.imaf081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf081
            
            #add-point:AFTER FIELD imaf081 name="construct.a.imaf081"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf081
            #add-point:ON ACTION controlp INFIELD imaf081 name="construct.c.imaf081"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf082
            #add-point:BEFORE FIELD imaf082 name="construct.b.imaf082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf082
            
            #add-point:AFTER FIELD imaf082 name="construct.a.imaf082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf082
            #add-point:ON ACTION controlp INFIELD imaf082 name="construct.c.imaf082"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaf083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf083
            #add-point:ON ACTION controlp INFIELD imaf083 name="construct.c.imaf083"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1  = '8'     #製造序號 
            CALL q_oofg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf083  #顯示到畫面上
            NEXT FIELD imaf083                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf083
            #add-point:BEFORE FIELD imaf083 name="construct.b.imaf083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf083
            
            #add-point:AFTER FIELD imaf083 name="construct.a.imaf083"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf084
            #add-point:BEFORE FIELD imaf084 name="construct.b.imaf084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf084
            
            #add-point:AFTER FIELD imaf084 name="construct.a.imaf084"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf084
            #add-point:ON ACTION controlp INFIELD imaf084 name="construct.c.imaf084"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaf091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf091
            #add-point:ON ACTION controlp INFIELD imaf091 name="construct.c.imaf091"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
			      LET g_qryparam.arg1 = g_site1
			   ELSE
               LET g_qryparam.arg1 = g_site                     #呼叫開窗
            END IF
            CALL q_inaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf091  #顯示到畫面上

            NEXT FIELD imaf091                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf091
            #add-point:BEFORE FIELD imaf091 name="construct.b.imaf091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf091
            
            #add-point:AFTER FIELD imaf091 name="construct.a.imaf091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf092
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf092
            #add-point:ON ACTION controlp INFIELD imaf092 name="construct.c.imaf092"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
			      LET g_qryparam.arg1 = g_site1
			   ELSE
               LET g_qryparam.arg1 = g_site                     #呼叫開窗
            END IF
            CALL q_inab002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf092  #顯示到畫面上

            NEXT FIELD imaf092                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf092
            #add-point:BEFORE FIELD imaf092 name="construct.b.imaf092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf092
            
            #add-point:AFTER FIELD imaf092 name="construct.a.imaf092"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf177
            #add-point:BEFORE FIELD imaf177 name="construct.b.imaf177"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf177
            
            #add-point:AFTER FIELD imaf177 name="construct.a.imaf177"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf177
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf177
            #add-point:ON ACTION controlp INFIELD imaf177 name="construct.c.imaf177"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaf178
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf178
            #add-point:ON ACTION controlp INFIELD imaf178 name="construct.c.imaf178"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160617-00004#2--s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            #161215-00006#6 mod s
#            LET g_qryparam.arg1 = '30'
#            CALL q_oofg001_3()                           #呼叫開窗
            CALL q_bcba001()
            #161215-00006#6 mod e
            
            DISPLAY g_qryparam.return1 TO imaf178  #顯示到畫面上
            NEXT FIELD imaf178                     #返回原欄位
            #160617-00004#2--e---

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf178
            #add-point:BEFORE FIELD imaf178 name="construct.b.imaf178"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf178
            
            #add-point:AFTER FIELD imaf178 name="construct.a.imaf178"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf179
            #add-point:BEFORE FIELD imaf179 name="construct.b.imaf179"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf179
            
            #add-point:AFTER FIELD imaf179 name="construct.a.imaf179"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf179
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf179
            #add-point:ON ACTION controlp INFIELD imaf179 name="construct.c.imaf179"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf101
            #add-point:BEFORE FIELD imaf101 name="construct.b.imaf101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf101
            
            #add-point:AFTER FIELD imaf101 name="construct.a.imaf101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf101
            #add-point:ON ACTION controlp INFIELD imaf101 name="construct.c.imaf101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf102
            #add-point:BEFORE FIELD imaf102 name="construct.b.imaf102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf102
            
            #add-point:AFTER FIELD imaf102 name="construct.a.imaf102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf102
            #add-point:ON ACTION controlp INFIELD imaf102 name="construct.c.imaf102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf094
            #add-point:BEFORE FIELD imaf094 name="construct.b.imaf094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf094
            
            #add-point:AFTER FIELD imaf094 name="construct.a.imaf094"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf094
            #add-point:ON ACTION controlp INFIELD imaf094 name="construct.c.imaf094"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf095
            #add-point:BEFORE FIELD imaf095 name="construct.b.imaf095"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf095
            
            #add-point:AFTER FIELD imaf095 name="construct.a.imaf095"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf095
            #add-point:ON ACTION controlp INFIELD imaf095 name="construct.c.imaf095"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai031
            #add-point:BEFORE FIELD imai031 name="construct.b.imai031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai031
            
            #add-point:AFTER FIELD imai031 name="construct.a.imai031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imai031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai031
            #add-point:ON ACTION controlp INFIELD imai031 name="construct.c.imai031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai032
            #add-point:BEFORE FIELD imai032 name="construct.b.imai032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai032
            
            #add-point:AFTER FIELD imai032 name="construct.a.imai032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imai032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai032
            #add-point:ON ACTION controlp INFIELD imai032 name="construct.c.imai032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai033
            #add-point:BEFORE FIELD imai033 name="construct.b.imai033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai033
            
            #add-point:AFTER FIELD imai033 name="construct.a.imai033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imai033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai033
            #add-point:ON ACTION controlp INFIELD imai033 name="construct.c.imai033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai034
            #add-point:BEFORE FIELD imai034 name="construct.b.imai034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai034
            
            #add-point:AFTER FIELD imai034 name="construct.a.imai034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imai034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai034
            #add-point:ON ACTION controlp INFIELD imai034 name="construct.c.imai034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai035
            #add-point:BEFORE FIELD imai035 name="construct.b.imai035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai035
            
            #add-point:AFTER FIELD imai035 name="construct.a.imai035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imai035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai035
            #add-point:ON ACTION controlp INFIELD imai035 name="construct.c.imai035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai036
            #add-point:BEFORE FIELD imai036 name="construct.b.imai036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai036
            
            #add-point:AFTER FIELD imai036 name="construct.a.imai036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imai036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai036
            #add-point:ON ACTION controlp INFIELD imai036 name="construct.c.imai036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai037
            #add-point:BEFORE FIELD imai037 name="construct.b.imai037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai037
            
            #add-point:AFTER FIELD imai037 name="construct.a.imai037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imai037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai037
            #add-point:ON ACTION controlp INFIELD imai037 name="construct.c.imai037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf096
            #add-point:BEFORE FIELD imaf096 name="construct.b.imaf096"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf096
            
            #add-point:AFTER FIELD imaf096 name="construct.a.imaf096"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf096
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf096
            #add-point:ON ACTION controlp INFIELD imaf096 name="construct.c.imaf096"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="aimm202.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimm202_filter()
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
      CONSTRUCT g_wc_filter ON imaf001,imaf051
                          FROM s_browse[1].b_imaf001,s_browse[1].b_imaf051
 
         BEFORE CONSTRUCT
               DISPLAY aimm202_filter_parser('imaf001') TO s_browse[1].b_imaf001
            DISPLAY aimm202_filter_parser('imaf051') TO s_browse[1].b_imaf051
      
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
 
      CALL aimm202_filter_show('imaf001')
   CALL aimm202_filter_show('imaf051')
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimm202_filter_parser(ps_field)
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
 
{<section id="aimm202.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimm202_filter_show(ps_field)
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
   LET ls_condition = aimm202_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimm202_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_imaf_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aimm202_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimm202_browser_fill(g_wc,"F")
      CALL aimm202_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aimm202_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL aimm202_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aimm202.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimm202_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_s1       LIKE imaa_t.imaastus
   #end add-point  
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength() 
   END IF
   
   # 設定browse索引
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_imaf_m.imaf001 = g_browser[g_current_idx].b_imaf001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aimm202_master_referesh USING g_site,g_imaf_m.imaf001 INTO g_imaf_m.imaf001,g_imaf_m.imaf051, 
       g_imaf_m.imaf052,g_imaf_m.imaf053,g_imaf_m.imaf054,g_imaf_m.imaf055,g_imaf_m.imaf057,g_imaf_m.imaf058, 
       g_imaf_m.imaf059,g_imaf_m.imafownid,g_imaf_m.imafowndp,g_imaf_m.imafcrtid,g_imaf_m.imafcrtdp, 
       g_imaf_m.imafcrtdt,g_imaf_m.imafmodid,g_imaf_m.imafmoddt,g_imaf_m.imafcnfid,g_imaf_m.imafcnfdt, 
       g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063,g_imaf_m.imaf064,g_imaf_m.imaf071,g_imaf_m.imaf072, 
       g_imaf_m.imaf073,g_imaf_m.imaf074,g_imaf_m.imaf081,g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf084, 
       g_imaf_m.imaf091,g_imaf_m.imaf092,g_imaf_m.imaf177,g_imaf_m.imaf178,g_imaf_m.imaf179,g_imaf_m.imaf101, 
       g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095,g_imaf_m.imaf096,g_imaf_m.imaf051_desc,g_imaf_m.imaf052_desc, 
       g_imaf_m.imaf053_desc,g_imaf_m.imafownid_desc,g_imaf_m.imafowndp_desc,g_imaf_m.imafcrtid_desc, 
       g_imaf_m.imafcrtdp_desc,g_imaf_m.imafmodid_desc,g_imaf_m.imafcnfid_desc,g_imaf_m.imaf178_desc 
 
   
   #遮罩相關處理
   LET g_imaf_m_mask_o.* =  g_imaf_m.*
   CALL aimm202_imaf_t_mask()
   LET g_imaf_m_mask_n.* =  g_imaf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimm202_set_act_visible()
   CALL aimm202_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   LET l_s1 = ""
   SELECT imaastus INTO l_s1 
     FROM imaa_t
    WHERE imaa001 = g_imaf_m.imaf001
      AND imaaent = g_enterprise
   IF l_s1 = 'X' THEN
      CALL cl_set_act_visible("modify",FALSE)
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      CALL cl_set_act_visible("query", FALSE)
   END IF
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_imaf_m_t.* = g_imaf_m.*
   LET g_imaf_m_o.* = g_imaf_m.*
   
   LET g_data_owner = g_imaf_m.imafownid      
   LET g_data_dept  = g_imaf_m.imafowndp
   
   #重新顯示
   CALL aimm202_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimm202_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_imaf_m.* TO NULL             #DEFAULT 設定
   LET g_imaf001_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaf_m.imafownid = g_user
      LET g_imaf_m.imafowndp = g_dept
      LET g_imaf_m.imafcrtid = g_user
      LET g_imaf_m.imafcrtdp = g_dept 
      LET g_imaf_m.imafcrtdt = cl_get_current()
      LET g_imaf_m.imafmodid = g_user
      LET g_imaf_m.imafmoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imaf_m.imaf054 = "N"
      LET g_imaf_m.imaf055 = "3"
      LET g_imaf_m.imaf057 = "A"
      LET g_imaf_m.imaf058 = "0"
      LET g_imaf_m.imaf059 = "1"
      LET g_imaf_m.imaf061 = "3"
      LET g_imaf_m.imaf062 = "N"
      LET g_imaf_m.imaf064 = "3"
      LET g_imaf_m.imaf071 = "1"
      LET g_imaf_m.imaf072 = "Y"
      LET g_imaf_m.imaf074 = "2"
      LET g_imaf_m.imaf081 = "1"
      LET g_imaf_m.imaf082 = "Y"
      LET g_imaf_m.imaf084 = "2"
      LET g_imaf_m.imaf177 = "N"
      LET g_imaf_m.imaf101 = "0"
      LET g_imaf_m.imaf102 = "0"
      LET g_imaf_m.imaf094 = "0"
      LET g_imaf_m.imaf095 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL aimm202_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_imaf_m.* TO NULL
         CALL aimm202_show()
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimm202_set_act_visible()
   CALL aimm202_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imaf001_t = g_imaf_m.imaf001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imafent = " ||g_enterprise|| " AND imafsite = '" ||g_site|| "' AND",
                      " imaf001 = '", g_imaf_m.imaf001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimm202_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimm202_master_referesh USING g_site,g_imaf_m.imaf001 INTO g_imaf_m.imaf001,g_imaf_m.imaf051, 
       g_imaf_m.imaf052,g_imaf_m.imaf053,g_imaf_m.imaf054,g_imaf_m.imaf055,g_imaf_m.imaf057,g_imaf_m.imaf058, 
       g_imaf_m.imaf059,g_imaf_m.imafownid,g_imaf_m.imafowndp,g_imaf_m.imafcrtid,g_imaf_m.imafcrtdp, 
       g_imaf_m.imafcrtdt,g_imaf_m.imafmodid,g_imaf_m.imafmoddt,g_imaf_m.imafcnfid,g_imaf_m.imafcnfdt, 
       g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063,g_imaf_m.imaf064,g_imaf_m.imaf071,g_imaf_m.imaf072, 
       g_imaf_m.imaf073,g_imaf_m.imaf074,g_imaf_m.imaf081,g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf084, 
       g_imaf_m.imaf091,g_imaf_m.imaf092,g_imaf_m.imaf177,g_imaf_m.imaf178,g_imaf_m.imaf179,g_imaf_m.imaf101, 
       g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095,g_imaf_m.imaf096,g_imaf_m.imaf051_desc,g_imaf_m.imaf052_desc, 
       g_imaf_m.imaf053_desc,g_imaf_m.imafownid_desc,g_imaf_m.imafowndp_desc,g_imaf_m.imafcrtid_desc, 
       g_imaf_m.imafcrtdp_desc,g_imaf_m.imafmodid_desc,g_imaf_m.imafcnfid_desc,g_imaf_m.imaf178_desc 
 
   
   
   #遮罩相關處理
   LET g_imaf_m_mask_o.* =  g_imaf_m.*
   CALL aimm202_imaf_t_mask()
   LET g_imaf_m_mask_n.* =  g_imaf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imaf_m.imaf001,g_imaf_m.imaa002,g_imaf_m.imaal003,g_imaf_m.imaal004,g_imaf_m.imaal005, 
       g_imaf_m.imaa009,g_imaf_m.imaa009_desc,g_imaf_m.imaa003,g_imaf_m.imaa003_desc,g_imaf_m.imaa004, 
       g_imaf_m.imaa005,g_imaf_m.imaa005_desc,g_imaf_m.imaa006,g_imaf_m.imaa006_desc,g_imaf_m.imaa010, 
       g_imaf_m.imaa010_desc,g_imaf_m.s1,g_imaf_m.imaf051,g_imaf_m.imaf051_desc,g_imaf_m.imaf052,g_imaf_m.imaf052_desc, 
       g_imaf_m.imaf053,g_imaf_m.imaf053_desc,g_imaf_m.imaf054,g_imaf_m.imaf055,g_imaf_m.imaf057,g_imaf_m.imaf058, 
       g_imaf_m.imaf059,g_imaf_m.imafownid,g_imaf_m.imafownid_desc,g_imaf_m.imafowndp,g_imaf_m.imafowndp_desc, 
       g_imaf_m.imafcrtid,g_imaf_m.imafcrtid_desc,g_imaf_m.imafcrtdp,g_imaf_m.imafcrtdp_desc,g_imaf_m.imafcrtdt, 
       g_imaf_m.imafmodid,g_imaf_m.imafmodid_desc,g_imaf_m.imafmoddt,g_imaf_m.imafcnfid,g_imaf_m.imafcnfid_desc, 
       g_imaf_m.imafcnfdt,g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063,g_imaf_m.imaf063_desc,g_imaf_m.imaf064, 
       g_imaf_m.imaf071,g_imaf_m.imaf072,g_imaf_m.imaf073,g_imaf_m.imaf073_desc,g_imaf_m.imaf074,g_imaf_m.imaf081, 
       g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf083_desc,g_imaf_m.imaf084,g_imaf_m.imaf091,g_imaf_m.imaf091_desc, 
       g_imaf_m.imaf092,g_imaf_m.imaf092_desc,g_imaf_m.imaf177,g_imaf_m.imaf178,g_imaf_m.imaf178_desc, 
       g_imaf_m.imaf179,g_imaf_m.imaf101,g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095,g_imaf_m.imai031, 
       g_imaf_m.imai032,g_imaf_m.imai033,g_imaf_m.imai034,g_imaf_m.imai035,g_imaf_m.imai036,g_imaf_m.imai037, 
       g_imaf_m.imaf096
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_imaf_m.imafownid      
   LET g_data_dept  = g_imaf_m.imafowndp
 
   #功能已完成,通報訊息中心
   CALL aimm202_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimm202.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimm202_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imaf_m.imaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_imaf001_t = g_imaf_m.imaf001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aimm202_cl USING g_enterprise, g_site,g_imaf_m.imaf001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimm202_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimm202_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimm202_master_referesh USING g_site,g_imaf_m.imaf001 INTO g_imaf_m.imaf001,g_imaf_m.imaf051, 
       g_imaf_m.imaf052,g_imaf_m.imaf053,g_imaf_m.imaf054,g_imaf_m.imaf055,g_imaf_m.imaf057,g_imaf_m.imaf058, 
       g_imaf_m.imaf059,g_imaf_m.imafownid,g_imaf_m.imafowndp,g_imaf_m.imafcrtid,g_imaf_m.imafcrtdp, 
       g_imaf_m.imafcrtdt,g_imaf_m.imafmodid,g_imaf_m.imafmoddt,g_imaf_m.imafcnfid,g_imaf_m.imafcnfdt, 
       g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063,g_imaf_m.imaf064,g_imaf_m.imaf071,g_imaf_m.imaf072, 
       g_imaf_m.imaf073,g_imaf_m.imaf074,g_imaf_m.imaf081,g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf084, 
       g_imaf_m.imaf091,g_imaf_m.imaf092,g_imaf_m.imaf177,g_imaf_m.imaf178,g_imaf_m.imaf179,g_imaf_m.imaf101, 
       g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095,g_imaf_m.imaf096,g_imaf_m.imaf051_desc,g_imaf_m.imaf052_desc, 
       g_imaf_m.imaf053_desc,g_imaf_m.imafownid_desc,g_imaf_m.imafowndp_desc,g_imaf_m.imafcrtid_desc, 
       g_imaf_m.imafcrtdp_desc,g_imaf_m.imafmodid_desc,g_imaf_m.imafcnfid_desc,g_imaf_m.imaf178_desc 
 
 
   #檢查是否允許此動作
   IF NOT aimm202_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_imaf_m_mask_o.* =  g_imaf_m.*
   CALL aimm202_imaf_t_mask()
   LET g_imaf_m_mask_n.* =  g_imaf_m.*
   
   
 
   #顯示資料
   CALL aimm202_show()
   
   WHILE TRUE
      LET g_imaf_m.imaf001 = g_imaf001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_imaf_m.imafmodid = g_user 
LET g_imaf_m.imafmoddt = cl_get_current()
LET g_imaf_m.imafmodid_desc = cl_get_username(g_imaf_m.imafmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF cl_null(g_imaf_m.imaf054) THEN
         LET g_imaf_m.imaf054 = "N"
      END IF
      IF cl_null(g_imaf_m.imaf055) THEN
         LET g_imaf_m.imaf055 = "3"
      END IF
      IF cl_null(g_imaf_m.imaf057) THEN
         LET g_imaf_m.imaf057 = "A"
      END IF
      IF cl_null(g_imaf_m.imaf058) THEN
         LET g_imaf_m.imaf058 = "0"
      END IF
      IF cl_null(g_imaf_m.imaf059) THEN
         LET g_imaf_m.imaf059 = "1"
      END IF
      IF cl_null(g_imaf_m.imaf061) THEN
         LET g_imaf_m.imaf061 = "3"
      END IF
      IF cl_null(g_imaf_m.imaf062) THEN
         LET g_imaf_m.imaf062 = "N"
      END IF
      IF cl_null(g_imaf_m.imaf064) THEN
         LET g_imaf_m.imaf064 = "3"
      END IF
      IF cl_null(g_imaf_m.imaf071) THEN
         LET g_imaf_m.imaf071 = "1"
      END IF
      IF cl_null(g_imaf_m.imaf072) THEN
         LET g_imaf_m.imaf072 = "Y"
      END IF
      IF cl_null(g_imaf_m.imaf074) THEN
         LET g_imaf_m.imaf074 = "2"
      END IF
      IF cl_null(g_imaf_m.imaf081) THEN
         LET g_imaf_m.imaf081 = "1"
      END IF
      IF cl_null(g_imaf_m.imaf082) THEN
         LET g_imaf_m.imaf082 = "Y"
      END IF
      IF cl_null(g_imaf_m.imaf084) THEN
         LET g_imaf_m.imaf084 = "2"
      END IF
      
      #160617-00004#2--s
      #IF cl_null(g_imaf_m.imaf093) THEN
      #   LET g_imaf_m.imaf093 = "N"
      #END IF
      #160617-00004#2--e
      IF cl_null(g_imaf_m.imaf094) THEN
         LET g_imaf_m.imaf094 = "0"
      END IF
      IF cl_null(g_imaf_m.imaf095) THEN
         LET g_imaf_m.imaf095 = "0"
      END IF
      IF cl_null(g_imaf_m.imaf101) THEN
         LET g_imaf_m.imaf101 = "0"
      END IF
      IF cl_null(g_imaf_m.imaf102) THEN
         LET g_imaf_m.imaf102 = "0"
      END IF
      IF cl_null(g_imaf_m.imaf053) THEN
         LET g_imaf_m.imaf053 = g_imaf_m.imaa006
         IF cl_null(g_imaf_m.imaf053) THEN
            LET g_imaf_m.imaf053_desc = ""
         ELSE   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_m.imaf053
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaf_m.imaf053_desc = g_rtn_fields[1] 
         END IF   
         DISPLAY BY NAME g_imaf_m.imaf053_desc
      END IF
      #end add-point
 
      #資料輸入
      CALL aimm202_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_imaf_m.* = g_imaf_m_t.*
         CALL aimm202_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE imaf_t SET (imafmodid,imafmoddt) = (g_imaf_m.imafmodid,g_imaf_m.imafmoddt)
       WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_imaf001_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimm202_set_act_visible()
   CALL aimm202_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imafent = " ||g_enterprise|| " AND imafsite = '" ||g_site|| "' AND",
                      " imaf001 = '", g_imaf_m.imaf001, "' "
 
   #填到對應位置
   CALL aimm202_browser_fill(g_wc,"")
 
   CLOSE aimm202_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimm202_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aimm202.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimm202_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_time          LIKE imai_t.imai056
   DEFINE l_rate          LIKE type_t.num26_10 
   #160511-00040#2 20160525 add by ming -----(S) 
   DEFINE l_imaamoddt     LIKE imaa_t.imaamoddt 
   #160511-00040#2 20160525 add by ming -----(E) 
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imaf_m.imaf001,g_imaf_m.imaa002,g_imaf_m.imaal003,g_imaf_m.imaal004,g_imaf_m.imaal005, 
       g_imaf_m.imaa009,g_imaf_m.imaa009_desc,g_imaf_m.imaa003,g_imaf_m.imaa003_desc,g_imaf_m.imaa004, 
       g_imaf_m.imaa005,g_imaf_m.imaa005_desc,g_imaf_m.imaa006,g_imaf_m.imaa006_desc,g_imaf_m.imaa010, 
       g_imaf_m.imaa010_desc,g_imaf_m.s1,g_imaf_m.imaf051,g_imaf_m.imaf051_desc,g_imaf_m.imaf052,g_imaf_m.imaf052_desc, 
       g_imaf_m.imaf053,g_imaf_m.imaf053_desc,g_imaf_m.imaf054,g_imaf_m.imaf055,g_imaf_m.imaf057,g_imaf_m.imaf058, 
       g_imaf_m.imaf059,g_imaf_m.imafownid,g_imaf_m.imafownid_desc,g_imaf_m.imafowndp,g_imaf_m.imafowndp_desc, 
       g_imaf_m.imafcrtid,g_imaf_m.imafcrtid_desc,g_imaf_m.imafcrtdp,g_imaf_m.imafcrtdp_desc,g_imaf_m.imafcrtdt, 
       g_imaf_m.imafmodid,g_imaf_m.imafmodid_desc,g_imaf_m.imafmoddt,g_imaf_m.imafcnfid,g_imaf_m.imafcnfid_desc, 
       g_imaf_m.imafcnfdt,g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063,g_imaf_m.imaf063_desc,g_imaf_m.imaf064, 
       g_imaf_m.imaf071,g_imaf_m.imaf072,g_imaf_m.imaf073,g_imaf_m.imaf073_desc,g_imaf_m.imaf074,g_imaf_m.imaf081, 
       g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf083_desc,g_imaf_m.imaf084,g_imaf_m.imaf091,g_imaf_m.imaf091_desc, 
       g_imaf_m.imaf092,g_imaf_m.imaf092_desc,g_imaf_m.imaf177,g_imaf_m.imaf178,g_imaf_m.imaf178_desc, 
       g_imaf_m.imaf179,g_imaf_m.imaf101,g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095,g_imaf_m.imai031, 
       g_imaf_m.imai032,g_imaf_m.imai033,g_imaf_m.imai034,g_imaf_m.imai035,g_imaf_m.imai036,g_imaf_m.imai037, 
       g_imaf_m.imaf096
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL aimm202_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #ming 20151006 add -----(S) 
   CALL aimm202_set_no_required()
   CALL aimm202_set_required()
   #ming 20151006 add -----(E) 
   LET g_errshow = 1
   #end add-point
   CALL aimm202_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_imaf_m.imaf001,g_imaf_m.imaa002,g_imaf_m.imaal003,g_imaf_m.imaal004,g_imaf_m.imaal005, 
          g_imaf_m.imaa009,g_imaf_m.imaa003,g_imaf_m.imaa004,g_imaf_m.imaa005,g_imaf_m.imaa006,g_imaf_m.imaa010, 
          g_imaf_m.s1,g_imaf_m.imaf051,g_imaf_m.imaf052,g_imaf_m.imaf053,g_imaf_m.imaf054,g_imaf_m.imaf055, 
          g_imaf_m.imaf057,g_imaf_m.imaf058,g_imaf_m.imaf059,g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063, 
          g_imaf_m.imaf064,g_imaf_m.imaf071,g_imaf_m.imaf072,g_imaf_m.imaf073,g_imaf_m.imaf074,g_imaf_m.imaf081, 
          g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf084,g_imaf_m.imaf091,g_imaf_m.imaf092,g_imaf_m.imaf177, 
          g_imaf_m.imaf178,g_imaf_m.imaf179,g_imaf_m.imaf101,g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095, 
          g_imaf_m.imai031,g_imaf_m.imai032,g_imaf_m.imai033,g_imaf_m.imai034,g_imaf_m.imai035,g_imaf_m.imai036, 
          g_imaf_m.imai037,g_imaf_m.imaf096 
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
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.imaal001 = g_imaf_m.imaf001
LET g_master_multi_table_t.imaal003 = g_imaf_m.imaal003
LET g_master_multi_table_t.imaal004 = g_imaf_m.imaal004
LET g_master_multi_table_t.imaal005 = g_imaf_m.imaal005
 
            #add-point:input開始前 name="input.before.input"
            #150518 by whitney add start
            LET g_imaf_m_t.* = g_imaf_m.*
            LET g_imaf_m_o.* = g_imaf_m.*
            #150518 by whitney add end

            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf001
            #add-point:BEFORE FIELD imaf001 name="input.b.imaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf001
            
            #add-point:AFTER FIELD imaf001 name="input.a.imaf001"
            #此段落由子樣板a05產生
            CALL aimm202_imaa_desc1()
            IF  NOT cl_null(g_imaf_m.imaf001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imaf_m.imaf001 != g_imaf001_t ))) THEN 
                  IF NOT ap_chk_notDup(g_imaf_m.imaf001,"SELECT COUNT(*) FROM imaf_t WHERE "||"imafent = '" ||g_enterprise|| "' AND imafsite = '" ||g_site|| "' AND "||"imaf001 = '"||g_imaf_m.imaf001 ||"'",'std-00004',0) THEN 
                     LET g_imaf_m.imaf001 = g_imaf001_t
                     IF cl_null(g_imaf_m.imaf001) THEN
                        CALL aimm202_imaa_desc1()
                     ELSE
                        CALL aimm202_imaa_desc()                  
                     END IF
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF cl_null(g_imaf_m.imaf001) THEN
               CALL aimm202_imaa_desc1()
            ELSE
               CALL aimm202_imaa_desc()                  
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf001
            #add-point:ON CHANGE imaf001 name="input.g.imaf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa002
            #add-point:BEFORE FIELD imaa002 name="input.b.imaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa002
            
            #add-point:AFTER FIELD imaa002 name="input.a.imaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa002
            #add-point:ON CHANGE imaa002 name="input.g.imaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal003
            #add-point:BEFORE FIELD imaal003 name="input.b.imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal003
            
            #add-point:AFTER FIELD imaal003 name="input.a.imaal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal003
            #add-point:ON CHANGE imaal003 name="input.g.imaal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal004
            #add-point:BEFORE FIELD imaal004 name="input.b.imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal004
            
            #add-point:AFTER FIELD imaal004 name="input.a.imaal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal004
            #add-point:ON CHANGE imaal004 name="input.g.imaal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaal005
            #add-point:BEFORE FIELD imaal005 name="input.b.imaal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaal005
            
            #add-point:AFTER FIELD imaal005 name="input.a.imaal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaal005
            #add-point:ON CHANGE imaal005 name="input.g.imaal005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="input.a.imaa009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_m.imaa009
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaf_m.imaa009_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imaf_m.imaa009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="input.b.imaa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa009
            #add-point:ON CHANGE imaa009 name="input.g.imaa009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="input.a.imaa003"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="input.b.imaa003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa003
            #add-point:ON CHANGE imaa003 name="input.g.imaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa004
            #add-point:BEFORE FIELD imaa004 name="input.b.imaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa004
            
            #add-point:AFTER FIELD imaa004 name="input.a.imaa004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa004
            #add-point:ON CHANGE imaa004 name="input.g.imaa004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa005
            
            #add-point:AFTER FIELD imaa005 name="input.a.imaa005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa005
            #add-point:BEFORE FIELD imaa005 name="input.b.imaa005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa005
            #add-point:ON CHANGE imaa005 name="input.g.imaa005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa006
            
            #add-point:AFTER FIELD imaa006 name="input.a.imaa006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_m.imaa006
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa001=? ","") RETURNING g_rtn_fields
            LET g_imaf_m.imaa006_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imaf_m.imaa006_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa006
            #add-point:BEFORE FIELD imaa006 name="input.b.imaa006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa006
            #add-point:ON CHANGE imaa006 name="input.g.imaa006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa010
            
            #add-point:AFTER FIELD imaa010 name="input.a.imaa010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imaf_m.imaa010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imaf_m.imaa010_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imaf_m.imaa010_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa010
            #add-point:BEFORE FIELD imaa010 name="input.b.imaa010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa010
            #add-point:ON CHANGE imaa010 name="input.g.imaa010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD s1
            #add-point:BEFORE FIELD s1 name="input.b.s1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD s1
            
            #add-point:AFTER FIELD s1 name="input.a.s1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE s1
            #add-point:ON CHANGE s1 name="input.g.s1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf051
            
            #add-point:AFTER FIELD imaf051 name="input.a.imaf051"
            #150518 by whitney modify start
            DISPLAY "" TO imaf051_desc
            IF NOT cl_null(g_imaf_m.imaf051) THEN
               IF g_imaf_m.imaf051 <> g_imaf_m_o.imaf051 OR cl_null(g_imaf_m_o.imaf051) THEN
                  IF g_site = 'ALL' THEN
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_imaf_m.imaf051
                     #160318-00025#17  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00045:sub-01302|aimi102|",cl_get_progname("aimi102",g_lang,"2"),"|:EXEPROGaimi102"
                     #160318-00025#17  by 07900 --add-end 
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_imcc051") THEN
                        LET g_imaf_m.imaf051 = g_imaf_m_t.imaf051
                        CALL aimm202_desc()
                        NEXT FIELD imaf051
                     END IF
                  ELSE
                     IF NOT s_azzi650_chk_exist('201',g_imaf_m.imaf051) THEN
                        LET g_imaf_m.imaf051 = g_imaf_m_t.imaf051
                        CALL aimm202_desc()
                        NEXT FIELD imaf051
                     END IF
                  END IF
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM imcc_t
                   WHERE imcc051 = g_imaf_m.imaf051
                     AND imccent = g_enterprise
                     AND imccsite = g_site
                     AND imccstus = 'Y'
                  IF l_cnt > 0 THEN
                     IF cl_ask_confirm('aim-00120') THEN
                        CALL aimm202_get_imcc()
                     END IF
                  END IF
               END IF
            END IF
            #150518 by whitney modify end
            CALL aimm202_desc()
            LET g_imaf_m_o.imaf051 = g_imaf_m.imaf051
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf051
            #add-point:BEFORE FIELD imaf051 name="input.b.imaf051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf051
            #add-point:ON CHANGE imaf051 name="input.g.imaf051"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf052
            
            #add-point:AFTER FIELD imaf052 name="input.a.imaf052"
            DISPLAY "" TO imaf052_desc
            IF NOT cl_null(g_imaf_m.imaf052) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaf_m.imaf052
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_imaf_m.imaf052 = g_imaf_m_t.imaf052
                  CALL aimm202_desc()
                  NEXT FIELD imaf052
               END IF
            END IF
            CALL aimm202_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf052
            #add-point:BEFORE FIELD imaf052 name="input.b.imaf052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf052
            #add-point:ON CHANGE imaf052 name="input.g.imaf052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf053
            
            #add-point:AFTER FIELD imaf053 name="input.a.imaf053"
            DISPLAY "" TO imaf053_desc
            IF NOT cl_null(g_imaf_m.imaf053) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaf_m.imaf001
               LET g_chkparam.arg2 = g_imaf_m.imaf053

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imao002") THEN
                  LET g_imaf_m.imaf053 = g_imaf_m_t.imaf053
                  CALL aimm202_desc()
                  NEXT FIELD imaf053
               END IF
               CALL s_aimi190_get_convert(g_imaf_m.imaf001,g_imaf_m.imaf053,g_imaf_m.imaa006) RETURNING l_success,l_rate
               IF NOT l_success THEN
                  LET g_imaf_m.imaf053 = g_imaf_m_t.imaf053
                  CALL aimm202_desc()
                  NEXT FIELD imaf053
               END IF
            END IF
            CALL aimm202_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf053
            #add-point:BEFORE FIELD imaf053 name="input.b.imaf053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf053
            #add-point:ON CHANGE imaf053 name="input.g.imaf053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf054
            #add-point:BEFORE FIELD imaf054 name="input.b.imaf054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf054
            
            #add-point:AFTER FIELD imaf054 name="input.a.imaf054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf054
            #add-point:ON CHANGE imaf054 name="input.g.imaf054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf055
            #add-point:BEFORE FIELD imaf055 name="input.b.imaf055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf055
            
            #add-point:AFTER FIELD imaf055 name="input.a.imaf055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf055
            #add-point:ON CHANGE imaf055 name="input.g.imaf055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf057
            #add-point:BEFORE FIELD imaf057 name="input.b.imaf057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf057
            
            #add-point:AFTER FIELD imaf057 name="input.a.imaf057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf057
            #add-point:ON CHANGE imaf057 name="input.g.imaf057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf058
            #add-point:BEFORE FIELD imaf058 name="input.b.imaf058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf058
            
            #add-point:AFTER FIELD imaf058 name="input.a.imaf058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf058
            #add-point:ON CHANGE imaf058 name="input.g.imaf058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf059
            #add-point:BEFORE FIELD imaf059 name="input.b.imaf059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf059
            
            #add-point:AFTER FIELD imaf059 name="input.a.imaf059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf059
            #add-point:ON CHANGE imaf059 name="input.g.imaf059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf061
            #add-point:BEFORE FIELD imaf061 name="input.b.imaf061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf061
            
            #add-point:AFTER FIELD imaf061 name="input.a.imaf061"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf061
            #add-point:ON CHANGE imaf061 name="input.g.imaf061"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf062
            #add-point:BEFORE FIELD imaf062 name="input.b.imaf062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf062
            
            #add-point:AFTER FIELD imaf062 name="input.a.imaf062"
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf062
            #add-point:ON CHANGE imaf062 name="input.g.imaf062"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf063
            
            #add-point:AFTER FIELD imaf063 name="input.a.imaf063"
            CALL aimm202_get_oofg001_ref(g_imaf_m.imaf063)
                 RETURNING g_imaf_m.imaf063_desc
            DISPLAY BY NAME g_imaf_m.imaf063_desc
            IF NOT cl_null(g_imaf_m.imaf063) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaf_m.imaf063
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oofg001_1") THEN
                  LET g_imaf_m.imaf063 = g_imaf_m_t.imaf063
                  CALL aimm202_get_oofg001_ref(g_imaf_m.imaf063)
                       RETURNING g_imaf_m.imaf063_desc
                  DISPLAY BY NAME g_imaf_m.imaf063_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf063
            #add-point:BEFORE FIELD imaf063 name="input.b.imaf063"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf063
            #add-point:ON CHANGE imaf063 name="input.g.imaf063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf064
            #add-point:BEFORE FIELD imaf064 name="input.b.imaf064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf064
            
            #add-point:AFTER FIELD imaf064 name="input.a.imaf064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf064
            #add-point:ON CHANGE imaf064 name="input.g.imaf064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf071
            #add-point:BEFORE FIELD imaf071 name="input.b.imaf071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf071
            
            #add-point:AFTER FIELD imaf071 name="input.a.imaf071"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf071
            #add-point:ON CHANGE imaf071 name="input.g.imaf071"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf072
            #add-point:BEFORE FIELD imaf072 name="input.b.imaf072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf072
            
            #add-point:AFTER FIELD imaf072 name="input.a.imaf072"
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf072
            #add-point:ON CHANGE imaf072 name="input.g.imaf072"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf073
            
            #add-point:AFTER FIELD imaf073 name="input.a.imaf073"
            CALL aimm202_get_oofg001_ref(g_imaf_m.imaf073)
                 RETURNING g_imaf_m.imaf073_desc
            DISPLAY BY NAME g_imaf_m.imaf073_desc
            IF NOT cl_null(g_imaf_m.imaf073) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaf_m.imaf073
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oofg001_3") THEN
                  LET g_imaf_m.imaf073 = g_imaf_m_t.imaf073
                  CALL aimm202_get_oofg001_ref(g_imaf_m.imaf073)
                       RETURNING g_imaf_m.imaf073_desc
                  DISPLAY BY NAME g_imaf_m.imaf073_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf073
            #add-point:BEFORE FIELD imaf073 name="input.b.imaf073"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf073
            #add-point:ON CHANGE imaf073 name="input.g.imaf073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf074
            #add-point:BEFORE FIELD imaf074 name="input.b.imaf074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf074
            
            #add-point:AFTER FIELD imaf074 name="input.a.imaf074"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf074
            #add-point:ON CHANGE imaf074 name="input.g.imaf074"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf081
            #add-point:BEFORE FIELD imaf081 name="input.b.imaf081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf081
            
            #add-point:AFTER FIELD imaf081 name="input.a.imaf081"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf081
            #add-point:ON CHANGE imaf081 name="input.g.imaf081"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf082
            #add-point:BEFORE FIELD imaf082 name="input.b.imaf082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf082
            
            #add-point:AFTER FIELD imaf082 name="input.a.imaf082"
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf082
            #add-point:ON CHANGE imaf082 name="input.g.imaf082"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf083
            
            #add-point:AFTER FIELD imaf083 name="input.a.imaf083"
            CALL aimm202_get_oofg001_ref(g_imaf_m.imaf083)
                 RETURNING g_imaf_m.imaf083_desc
            DISPLAY BY NAME g_imaf_m.imaf083_desc
            IF NOT cl_null(g_imaf_m.imaf083) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imaf_m.imaf083
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
               #160318-00025#17  by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oofg001_4") THEN
                  LET g_imaf_m.imaf083 = g_imaf_m_t.imaf083
                  CALL aimm202_get_oofg001_ref(g_imaf_m.imaf083)
                       RETURNING g_imaf_m.imaf083_desc
                  DISPLAY BY NAME g_imaf_m.imaf083_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf083
            #add-point:BEFORE FIELD imaf083 name="input.b.imaf083"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf083
            #add-point:ON CHANGE imaf083 name="input.g.imaf083"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf084
            #add-point:BEFORE FIELD imaf084 name="input.b.imaf084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf084
            
            #add-point:AFTER FIELD imaf084 name="input.a.imaf084"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf084
            #add-point:ON CHANGE imaf084 name="input.g.imaf084"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf091
            
            #add-point:AFTER FIELD imaf091 name="input.a.imaf091"
            DISPLAY "" TO imaf091_desc
            IF NOT cl_null(g_imaf_m.imaf092) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
      
               #設定g_chkparam.*的參數
               IF g_site = 'ALL' THEN
			         LET g_chkparam.arg1 = g_site1
			      ELSE
                  LET g_chkparam.arg1 = g_site                     #呼叫開窗
               END IF
               LET g_chkparam.arg2 = g_imaf_m.imaf091
               LET g_chkparam.arg3 = g_imaf_m.imaf092
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               #160318-00025#17  by 07900 --add-end  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inab002") THEN
                  LET g_imaf_m.imaf091 = g_imaf_m_t.imaf091
                  CALL aimm202_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF NOT cl_null(g_imaf_m.imaf091)THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
   
               #設定g_chkparam.*的參數
               IF g_site = 'ALL' THEN
			         LET g_chkparam.arg1 = g_site1
			      ELSE
                  LET g_chkparam.arg1 = g_site                     #呼叫開窗
               END IF
               LET g_chkparam.arg2 = g_imaf_m.imaf091
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inaa001") THEN
                  LET g_imaf_m.imaf091 = g_imaf_m_t.imaf091
                  CALL aimm202_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aimm202_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf091
            #add-point:BEFORE FIELD imaf091 name="input.b.imaf091"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf091
            #add-point:ON CHANGE imaf091 name="input.g.imaf091"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf092
            
            #add-point:AFTER FIELD imaf092 name="input.a.imaf092"
            DISPLAY "" TO imaf092_desc
            IF NOT cl_null(g_imaf_m.imaf092) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
   
               #設定g_chkparam.*的參數
               IF g_site = 'ALL' THEN
			         LET g_chkparam.arg1 = g_site1
			      ELSE
                  LET g_chkparam.arg1 = g_site                     #呼叫開窗
               END IF
               LET g_chkparam.arg2 = g_imaf_m.imaf091
               LET g_chkparam.arg3 = g_imaf_m.imaf092
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inab002") THEN
                  LET g_imaf_m.imaf092 = g_imaf_m_t.imaf092
                  CALL aimm202_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aimm202_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf092
            #add-point:BEFORE FIELD imaf092 name="input.b.imaf092"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf092
            #add-point:ON CHANGE imaf092 name="input.g.imaf092"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf177
            #add-point:BEFORE FIELD imaf177 name="input.b.imaf177"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf177
            
            #add-point:AFTER FIELD imaf177 name="input.a.imaf177"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf177
            #add-point:ON CHANGE imaf177 name="input.g.imaf177"
            #160617-00004#2--s--
            CALL aimm202_set_entry(p_cmd)
            CALL aimm202_set_no_entry(p_cmd)
            #160617-00004#2---e
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf178
            
            #add-point:AFTER FIELD imaf178 name="input.a.imaf178"
            #160617-00004#2--s--
            CALL aimm202_imaf178_ref(g_imaf_m.imaf178) RETURNING g_imaf_m.imaf178_desc
            DISPLAY BY NAME g_imaf_m.imaf178_desc
            IF NOT cl_null(g_imaf_m.imaf178) THEN 
               
               #161215-00006#6 mod s
               IF g_imaf_m.imaf178 <> g_imaf_m_o.imaf178 OR cl_null(g_imaf_m_o.imaf178) THEN
                  IF NOT aimm202_imaf178_chk() THEN
                     LET g_imaf_m.imaf178 = g_imaf_m_o.imaf178
                     CALL aimm202_imaf178_ref(g_imaf_m.imaf178) RETURNING g_imaf_m.imaf178_desc
                     DISPLAY BY NAME g_imaf_m.imaf178_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imaf_m.imaf178 != g_imaf_m_t.imaf178 OR cl_null(g_imaf_m_t.imaf178))) THEN  
#                  #應用 a17 樣板自動產生(Version:2)
#                  #欄位存在檢查
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#                  
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_imaf_m.imaf178
#                  #160318-00025#43  2016/04/25  by pengxin  add(S)
#                  LET g_errshow = TRUE #是否開窗 
#                  LET g_chkparam.err_str[1] = "apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
#                  #160318-00025#43  2016/04/25  by pengxin  add(E)
#                  #呼叫檢查存在並帶值的library
#                  IF NOT cl_chk_exist("v_oofg001_2") THEN
#                     LET g_imaf_m.imaf178 = g_imaf_m_t.imaf178
#                     CALL aimm202_imaf178_ref(g_imaf_m.imaf178) RETURNING g_imaf_m.imaf178_desc
#                     DISPLAY BY NAME g_imaf_m.imaf178_desc
#                     NEXT FIELD CURRENT
#                  END IF 
#                  
#               END IF
               #161215-00006#6 mod e
               
            END IF 
            #160617-00004#2--e
            
            #161215-00006#6 add s
            LET g_imaf_m_o.imaf178 = g_imaf_m.imaf178
            
            CALL aimm202_set_entry(p_cmd)
            CALL aimm202_set_no_entry(p_cmd)
            #161215-00006#6 add e
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf178
            #add-point:BEFORE FIELD imaf178 name="input.b.imaf178"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf178
            #add-point:ON CHANGE imaf178 name="input.g.imaf178"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf179
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_m.imaf179,"1","1","","","azz-00079",1) THEN
               NEXT FIELD imaf179
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf179 name="input.a.imaf179"
            IF NOT cl_null(g_imaf_m.imaf179) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf179
            #add-point:BEFORE FIELD imaf179 name="input.b.imaf179"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf179
            #add-point:ON CHANGE imaf179 name="input.g.imaf179"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf101
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_m.imaf101,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf101
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf101 name="input.a.imaf101"
            IF NOT cl_null(g_imaf_m.imaf101) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf101
            #add-point:BEFORE FIELD imaf101 name="input.b.imaf101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf101
            #add-point:ON CHANGE imaf101 name="input.g.imaf101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf102
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_m.imaf102,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf102
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf102 name="input.a.imaf102"
            IF NOT cl_null(g_imaf_m.imaf102) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf102
            #add-point:BEFORE FIELD imaf102 name="input.b.imaf102"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf102
            #add-point:ON CHANGE imaf102 name="input.g.imaf102"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf094
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_m.imaf094,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imaf094
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf094 name="input.a.imaf094"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf094
            #add-point:BEFORE FIELD imaf094 name="input.b.imaf094"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf094
            #add-point:ON CHANGE imaf094 name="input.g.imaf094"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf095
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imaf_m.imaf095,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imaf095
            END IF 
 
 
 
            #add-point:AFTER FIELD imaf095 name="input.a.imaf095"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf095
            #add-point:BEFORE FIELD imaf095 name="input.b.imaf095"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf095
            #add-point:ON CHANGE imaf095 name="input.g.imaf095"
            CALL aimm202_set_entry(p_cmd) 
            #ming 20151006 add -----(S) 
            CALL aimm202_set_no_required()
            CALL aimm202_set_required()
            #ming 20151006 add -----(E) 
            CALL aimm202_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai031
            #add-point:BEFORE FIELD imai031 name="input.b.imai031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai031
            
            #add-point:AFTER FIELD imai031 name="input.a.imai031"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imai031
            #add-point:ON CHANGE imai031 name="input.g.imai031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai032
            #add-point:BEFORE FIELD imai032 name="input.b.imai032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai032
            
            #add-point:AFTER FIELD imai032 name="input.a.imai032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imai032
            #add-point:ON CHANGE imai032 name="input.g.imai032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai033
            #add-point:BEFORE FIELD imai033 name="input.b.imai033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai033
            
            #add-point:AFTER FIELD imai033 name="input.a.imai033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imai033
            #add-point:ON CHANGE imai033 name="input.g.imai033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai034
            #add-point:BEFORE FIELD imai034 name="input.b.imai034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai034
            
            #add-point:AFTER FIELD imai034 name="input.a.imai034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imai034
            #add-point:ON CHANGE imai034 name="input.g.imai034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai035
            #add-point:BEFORE FIELD imai035 name="input.b.imai035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai035
            
            #add-point:AFTER FIELD imai035 name="input.a.imai035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imai035
            #add-point:ON CHANGE imai035 name="input.g.imai035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai036
            #add-point:BEFORE FIELD imai036 name="input.b.imai036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai036
            
            #add-point:AFTER FIELD imai036 name="input.a.imai036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imai036
            #add-point:ON CHANGE imai036 name="input.g.imai036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imai037
            #add-point:BEFORE FIELD imai037 name="input.b.imai037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imai037
            
            #add-point:AFTER FIELD imai037 name="input.a.imai037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imai037
            #add-point:ON CHANGE imai037 name="input.g.imai037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf096
            #add-point:BEFORE FIELD imaf096 name="input.b.imaf096"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf096
            
            #add-point:AFTER FIELD imaf096 name="input.a.imaf096"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf096
            #add-point:ON CHANGE imaf096 name="input.g.imaf096"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf001
            #add-point:ON ACTION controlp INFIELD imaf001 name="input.c.imaf001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf001             #給予default值

            #給予arg

            CALL q_imaa001()                                #呼叫開窗

            LET g_imaf_m.imaf001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaf001 TO imaf001              #顯示到畫面上

            NEXT FIELD imaf001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa002
            #add-point:ON ACTION controlp INFIELD imaa002 name="input.c.imaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal003
            #add-point:ON ACTION controlp INFIELD imaal003 name="input.c.imaal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal004
            #add-point:ON ACTION controlp INFIELD imaal004 name="input.c.imaal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaal005
            #add-point:ON ACTION controlp INFIELD imaal005 name="input.c.imaal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="input.c.imaa009"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaa009             #給予default值

            #給予arg

            CALL q_rtax001()                                #呼叫開窗

            LET g_imaf_m.imaa009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaa009 TO imaa009              #顯示到畫面上

            NEXT FIELD imaa009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="input.c.imaa003"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaa003             #給予default值

            #給予arg

            CALL q_imck001()                                #呼叫開窗

            LET g_imaf_m.imaa003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaa003 TO imaa003              #顯示到畫面上

            NEXT FIELD imaa003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa004
            #add-point:ON ACTION controlp INFIELD imaa004 name="input.c.imaa004"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa005
            #add-point:ON ACTION controlp INFIELD imaa005 name="input.c.imaa005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaa005             #給予default值

            #給予arg

            CALL q_imea001()                                #呼叫開窗

            LET g_imaf_m.imaa005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaa005 TO imaa005              #顯示到畫面上

            NEXT FIELD imaa005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa006
            #add-point:ON ACTION controlp INFIELD imaa006 name="input.c.imaa006"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaa006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imaf_m.imaa006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaa006 TO imaa006              #顯示到畫面上

            NEXT FIELD imaa006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa010
            #add-point:ON ACTION controlp INFIELD imaa010 name="input.c.imaa010"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaa010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "210" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imaf_m.imaa010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaa010 TO imaa010              #顯示到畫面上

            NEXT FIELD imaa010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.s1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD s1
            #add-point:ON ACTION controlp INFIELD s1 name="input.c.s1"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf051
            #add-point:ON ACTION controlp INFIELD imaf051 name="input.c.imaf051"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf051             #給予default值

            #給予arg
            #CALL q_imcc051()                                #呼叫開窗
            IF g_site = 'ALL' THEN
               CALL q_imcc051()
            ELSE
               LET g_qryparam.arg1 = '201'
               CALL q_oocq002()
            END IF

            LET g_imaf_m.imaf051 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaf051 TO imaf051              #顯示到畫面上
            CALL aimm202_desc()
            NEXT FIELD imaf051                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf052
            #add-point:ON ACTION controlp INFIELD imaf052 name="input.c.imaf052"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf052             #給予default值

            #給予arg

            CALL q_ooag001_2()                                #呼叫開窗

            LET g_imaf_m.imaf052 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaf052 TO imaf052              #顯示到畫面上
            CALL aimm202_desc()
            NEXT FIELD imaf052                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf053
            #add-point:ON ACTION controlp INFIELD imaf053 name="input.c.imaf053"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf053             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_imaf_m.imaf001

            CALL q_imao002()                                  #呼叫開窗

            LET g_imaf_m.imaf053 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaf053 TO imaf053              #顯示到畫面上
            CALL aimm202_desc()
            NEXT FIELD imaf053                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf054
            #add-point:ON ACTION controlp INFIELD imaf054 name="input.c.imaf054"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf055
            #add-point:ON ACTION controlp INFIELD imaf055 name="input.c.imaf055"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf057
            #add-point:ON ACTION controlp INFIELD imaf057 name="input.c.imaf057"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf058
            #add-point:ON ACTION controlp INFIELD imaf058 name="input.c.imaf058"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf059
            #add-point:ON ACTION controlp INFIELD imaf059 name="input.c.imaf059"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf061
            #add-point:ON ACTION controlp INFIELD imaf061 name="input.c.imaf061"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf062
            #add-point:ON ACTION controlp INFIELD imaf062 name="input.c.imaf062"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf063
            #add-point:ON ACTION controlp INFIELD imaf063 name="input.c.imaf063"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf063             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "6"     #庫存批號 

            CALL q_oofg001_3()                                #呼叫開窗

            LET g_imaf_m.imaf063 = g_qryparam.return1              

            DISPLAY g_imaf_m.imaf063 TO imaf063              #

            NEXT FIELD imaf063                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf064
            #add-point:ON ACTION controlp INFIELD imaf064 name="input.c.imaf064"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf071
            #add-point:ON ACTION controlp INFIELD imaf071 name="input.c.imaf071"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf072
            #add-point:ON ACTION controlp INFIELD imaf072 name="input.c.imaf072"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf073
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf073
            #add-point:ON ACTION controlp INFIELD imaf073 name="input.c.imaf073"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf073             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "7"     #製造批號 

            CALL q_oofg001_3()                                #呼叫開窗

            LET g_imaf_m.imaf073 = g_qryparam.return1              

            DISPLAY g_imaf_m.imaf073 TO imaf073              #

            NEXT FIELD imaf073                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf074
            #add-point:ON ACTION controlp INFIELD imaf074 name="input.c.imaf074"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf081
            #add-point:ON ACTION controlp INFIELD imaf081 name="input.c.imaf081"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf082
            #add-point:ON ACTION controlp INFIELD imaf082 name="input.c.imaf082"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf083
            #add-point:ON ACTION controlp INFIELD imaf083 name="input.c.imaf083"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf083             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8"     #製造序號 


            CALL q_oofg001_3()                                #呼叫開窗

            LET g_imaf_m.imaf083 = g_qryparam.return1              

            DISPLAY g_imaf_m.imaf083 TO imaf083              #

            NEXT FIELD imaf083                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf084
            #add-point:ON ACTION controlp INFIELD imaf084 name="input.c.imaf084"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf091
            #add-point:ON ACTION controlp INFIELD imaf091 name="input.c.imaf091"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf091             #給予default值

            #給予arg
            IF g_site = 'ALL' THEN
			      LET g_qryparam.arg1 = g_site1
			   ELSE
               LET g_qryparam.arg1 = g_site                     #呼叫開窗
            END IF
            CALL q_inaa001_4()                                #呼叫開窗

            LET g_imaf_m.imaf091 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaf091 TO imaf091              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimm202_desc()
            NEXT FIELD imaf091                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf092
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf092
            #add-point:ON ACTION controlp INFIELD imaf092 name="input.c.imaf092"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imaf_m.imaf092             #給予default值

            #給予arg
            IF g_site = 'ALL' THEN
			      LET g_qryparam.arg1 = g_site1
			   ELSE
               LET g_qryparam.arg1 = g_site                     #呼叫開窗
            END IF
            LET g_qryparam.arg2 = g_imaf_m.imaf091
            CALL q_inab002_8()                                #呼叫開窗

            LET g_imaf_m.imaf092 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imaf_m.imaf092 TO imaf092              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimm202_desc()
            NEXT FIELD imaf092                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf177
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf177
            #add-point:ON ACTION controlp INFIELD imaf177 name="input.c.imaf177"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf178
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf178
            #add-point:ON ACTION controlp INFIELD imaf178 name="input.c.imaf178"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160617-00004#2--s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imaf_m.imaf178             #給予default值

            #161215-00006#6 mod s
#            #給予arg
#            LET g_qryparam.arg1 = "30" #s
#            CALL q_oofg001_3()                                #呼叫開窗
            CALL q_bcba001()
            #161215-00006#6 mod e
 
            LET g_imaf_m.imaf178 = g_qryparam.return1              

            DISPLAY g_imaf_m.imaf178 TO imaf178              #
            CALL aimm202_imaf178_ref(g_imaf_m.imaf178) RETURNING g_imaf_m.imaf178_desc
            DISPLAY BY NAME g_imaf_m.imaf178_desc

            NEXT FIELD imaf178                          #返回原欄位

            #160617-00004#2--e---

            #END add-point
 
 
         #Ctrlp:input.c.imaf179
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf179
            #add-point:ON ACTION controlp INFIELD imaf179 name="input.c.imaf179"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf101
            #add-point:ON ACTION controlp INFIELD imaf101 name="input.c.imaf101"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf102
            #add-point:ON ACTION controlp INFIELD imaf102 name="input.c.imaf102"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf094
            #add-point:ON ACTION controlp INFIELD imaf094 name="input.c.imaf094"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf095
            #add-point:ON ACTION controlp INFIELD imaf095 name="input.c.imaf095"
            
            #END add-point
 
 
         #Ctrlp:input.c.imai031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai031
            #add-point:ON ACTION controlp INFIELD imai031 name="input.c.imai031"
            
            #END add-point
 
 
         #Ctrlp:input.c.imai032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai032
            #add-point:ON ACTION controlp INFIELD imai032 name="input.c.imai032"
            
            #END add-point
 
 
         #Ctrlp:input.c.imai033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai033
            #add-point:ON ACTION controlp INFIELD imai033 name="input.c.imai033"
            
            #END add-point
 
 
         #Ctrlp:input.c.imai034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai034
            #add-point:ON ACTION controlp INFIELD imai034 name="input.c.imai034"
            
            #END add-point
 
 
         #Ctrlp:input.c.imai035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai035
            #add-point:ON ACTION controlp INFIELD imai035 name="input.c.imai035"
            
            #END add-point
 
 
         #Ctrlp:input.c.imai036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai036
            #add-point:ON ACTION controlp INFIELD imai036 name="input.c.imai036"
            
            #END add-point
 
 
         #Ctrlp:input.c.imai037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imai037
            #add-point:ON ACTION controlp INFIELD imai037 name="input.c.imai037"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaf096
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf096
            #add-point:ON ACTION controlp INFIELD imaf096 name="input.c.imaf096"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(1) INTO l_count FROM imaf_t
                WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_imaf_m.imaf001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  IF (cl_null(g_imaf_m.imaf094) AND cl_null(g_imaf_m.imaf095)) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00071'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD imaf094
                  END IF 
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO imaf_t (imafent, imafsite,imaf001,imaf051,imaf052,imaf053,imaf054,imaf055, 
                      imaf057,imaf058,imaf059,imafownid,imafowndp,imafcrtid,imafcrtdp,imafcrtdt,imafmodid, 
                      imafmoddt,imafcnfid,imafcnfdt,imaf061,imaf062,imaf063,imaf064,imaf071,imaf072, 
                      imaf073,imaf074,imaf081,imaf082,imaf083,imaf084,imaf091,imaf092,imaf177,imaf178, 
                      imaf179,imaf101,imaf102,imaf094,imaf095,imaf096)
                  VALUES (g_enterprise, g_site,g_imaf_m.imaf001,g_imaf_m.imaf051,g_imaf_m.imaf052,g_imaf_m.imaf053, 
                      g_imaf_m.imaf054,g_imaf_m.imaf055,g_imaf_m.imaf057,g_imaf_m.imaf058,g_imaf_m.imaf059, 
                      g_imaf_m.imafownid,g_imaf_m.imafowndp,g_imaf_m.imafcrtid,g_imaf_m.imafcrtdp,g_imaf_m.imafcrtdt, 
                      g_imaf_m.imafmodid,g_imaf_m.imafmoddt,g_imaf_m.imafcnfid,g_imaf_m.imafcnfdt,g_imaf_m.imaf061, 
                      g_imaf_m.imaf062,g_imaf_m.imaf063,g_imaf_m.imaf064,g_imaf_m.imaf071,g_imaf_m.imaf072, 
                      g_imaf_m.imaf073,g_imaf_m.imaf074,g_imaf_m.imaf081,g_imaf_m.imaf082,g_imaf_m.imaf083, 
                      g_imaf_m.imaf084,g_imaf_m.imaf091,g_imaf_m.imaf092,g_imaf_m.imaf177,g_imaf_m.imaf178, 
                      g_imaf_m.imaf179,g_imaf_m.imaf101,g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095, 
                      g_imaf_m.imaf096) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                           INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imaf_m.imaf001 = g_master_multi_table_t.imaal001 AND
         g_imaf_m.imaal003 = g_master_multi_table_t.imaal003 AND 
         g_imaf_m.imaal004 = g_master_multi_table_t.imaal004 AND 
         g_imaf_m.imaal005 = g_master_multi_table_t.imaal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imaf_m.imaf001
            LET l_field_keys[02] = 'imaal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imaal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imaf_m.imaal003
            LET l_fields[01] = 'imaal003'
            LET l_vars[02] = g_imaf_m.imaal004
            LET l_fields[02] = 'imaal004'
            LET l_vars[03] = g_imaf_m.imaal005
            LET l_fields[03] = 'imaal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imaal_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
           
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_imaf_m.imaf001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               IF (cl_null(g_imaf_m.imaf094) AND cl_null(g_imaf_m.imaf095)) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00071'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD imaf094
               END IF 
               #end add-point
               
               #將遮罩欄位還原
               CALL aimm202_imaf_t_mask_restore('restore_mask_o')
               
               UPDATE imaf_t SET (imaf001,imaf051,imaf052,imaf053,imaf054,imaf055,imaf057,imaf058,imaf059, 
                   imafownid,imafowndp,imafcrtid,imafcrtdp,imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt, 
                   imaf061,imaf062,imaf063,imaf064,imaf071,imaf072,imaf073,imaf074,imaf081,imaf082,imaf083, 
                   imaf084,imaf091,imaf092,imaf177,imaf178,imaf179,imaf101,imaf102,imaf094,imaf095,imaf096) = (g_imaf_m.imaf001, 
                   g_imaf_m.imaf051,g_imaf_m.imaf052,g_imaf_m.imaf053,g_imaf_m.imaf054,g_imaf_m.imaf055, 
                   g_imaf_m.imaf057,g_imaf_m.imaf058,g_imaf_m.imaf059,g_imaf_m.imafownid,g_imaf_m.imafowndp, 
                   g_imaf_m.imafcrtid,g_imaf_m.imafcrtdp,g_imaf_m.imafcrtdt,g_imaf_m.imafmodid,g_imaf_m.imafmoddt, 
                   g_imaf_m.imafcnfid,g_imaf_m.imafcnfdt,g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063, 
                   g_imaf_m.imaf064,g_imaf_m.imaf071,g_imaf_m.imaf072,g_imaf_m.imaf073,g_imaf_m.imaf074, 
                   g_imaf_m.imaf081,g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf084,g_imaf_m.imaf091, 
                   g_imaf_m.imaf092,g_imaf_m.imaf177,g_imaf_m.imaf178,g_imaf_m.imaf179,g_imaf_m.imaf101, 
                   g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095,g_imaf_m.imaf096)
                WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_imaf001_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imaf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imaf_m.imaf001 = g_master_multi_table_t.imaal001 AND
         g_imaf_m.imaal003 = g_master_multi_table_t.imaal003 AND 
         g_imaf_m.imaal004 = g_master_multi_table_t.imaal004 AND 
         g_imaf_m.imaal005 = g_master_multi_table_t.imaal005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imaf_m.imaf001
            LET l_field_keys[02] = 'imaal001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imaal001
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imaal002'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imaf_m.imaal003
            LET l_fields[01] = 'imaal003'
            LET l_vars[02] = g_imaf_m.imaal004
            LET l_fields[02] = 'imaal004'
            LET l_vars[03] = g_imaf_m.imaal005
            LET l_fields[03] = 'imaal005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imaal_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL aimm202_imaf_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     #160511-00040#2 20160525 add by ming -----(S) 
                     #如果g_site = 'ALL'，imaf053 要回寫 imaa104 
                     IF g_site = 'ALL' THEN 
                        LET l_imaamoddt = cl_get_current() 
                        UPDATE imaa_t SET imaa104   = g_imaf_m.imaf053, 
                                          imaamoddt = l_imaamoddt, 
                                          imaamodid = g_user 
                         WHERE imaaent = g_enterprise 
                           AND imaa001 = g_imaf001_t 
                           
                        IF SQLCA.sqlcode THEN 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = 'imaa_t' 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err() 
                           
                           CALL s_transaction_end('N','0') 
                           NEXT FIELD CURRENT 
                        END IF 
                     END IF 
                     #160511-00040#2 20160525 add by ming -----(E) 
                  
                  LET l_time = cl_get_current()
                  UPDATE imai_t SET (imai054,imai055,imai056) = ('1',g_user,l_time)
                   WHERE imaient = g_enterprise 
                     AND imaisite = g_site 
                     AND imai001 = g_imaf001_t
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "imaf_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  END IF
                  IF g_site = 'ALL' THEN
                     CALL s_aooi090_upd_fields('1',g_imaf_m.imaf001) RETURNING l_success
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF
                  IF NOT s_aimm200_upd_item_site_stus(g_imaf_m.imaf001,g_site) THEN
                     CALL s_transaction_end('N','0')
                  END IF
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_imaf_m_t)
                     LET g_log2 = util.JSON.stringify(g_imaf_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
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
         ACCEPT DIALOG
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimm202_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE imaf_t.imaf001 
   DEFINE l_oldno     LIKE imaf_t.imaf001 
 
   DEFINE l_master    RECORD LIKE imaf_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   #先確定key值無遺漏
   IF g_imaf_m.imaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_imaf001_t = g_imaf_m.imaf001
 
   
   #清空key值
   LET g_imaf_m.imaf001 = ""
 
    
   CALL aimm202_set_entry("a")
   CALL aimm202_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imaf_m.imafownid = g_user
      LET g_imaf_m.imafowndp = g_dept
      LET g_imaf_m.imafcrtid = g_user
      LET g_imaf_m.imafcrtdp = g_dept 
      LET g_imaf_m.imafcrtdt = cl_get_current()
      LET g_imaf_m.imafmodid = g_user
      LET g_imaf_m.imafmoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aimm202_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_imaf_m.* TO NULL
      CALL aimm202_show()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前 name="reproduce.head.b_insert"
   
   #end add-point
   
   #add-point:單頭複製中 name="reproduce.head.m_insert"
   
   #end add-point
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後 name="reproduce.head.a_insert"
   
   #end add-point
   
   CALL s_transaction_end('Y','0')
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimm202_set_act_visible()
   CALL aimm202_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imaf001_t = g_imaf_m.imaf001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imafent = " ||g_enterprise|| " AND imafsite = '" ||g_site|| "' AND",
                      " imaf001 = '", g_imaf_m.imaf001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimm202_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_imaf_m.imafownid      
   LET g_data_dept  = g_imaf_m.imafowndp
              
   #功能已完成,通報訊息中心
   CALL aimm202_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aimm202_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimm202_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaf_m.imafownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imaf_m.imafownid_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_imaf_m.imafownid_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaf_m.imafowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaf_m.imafowndp_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_imaf_m.imafowndp_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaf_m.imafcrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imaf_m.imafcrtid_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaf_m.imafcrtid_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaf_m.imafcrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imaf_m.imafcrtdp_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_imaf_m.imafcrtdp_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaf_m.imafmodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imaf_m.imafmodid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imaf_m.imafmodid_desc
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imaf_m.imafcnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imaf_m.imafcnfid_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imaf_m.imafcnfid_desc
   
   IF cl_null(g_imaf_m.imaf091) THEN
      LET g_imaf_m.imaf091_desc = ""
   ELSE   
      IF g_site = 'ALL' THEN
	      CALL s_desc_get_stock_desc(g_site1,g_imaf_m.imaf091) RETURNING g_imaf_m.imaf091_desc
	   ELSE
         CALL s_desc_get_stock_desc(g_site,g_imaf_m.imaf091) RETURNING g_imaf_m.imaf091_desc        #呼叫開窗
      END IF
   END IF   
   DISPLAY BY NAME g_imaf_m.imaf091_desc
      
   IF cl_null(g_imaf_m.imaf092) THEN
      LET g_imaf_m.imaf092_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaf_m.imaf091
      LET g_ref_fields[2] = g_imaf_m.imaf092 
      
      IF g_site = 'ALL' THEN
	      CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site1||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
	   ELSE
         CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
      END IF
      LET g_imaf_m.imaf092_desc =  g_rtn_fields[1]
   END IF   
   DISPLAY BY NAME g_imaf_m.imaf092_desc
   
   CALL aimm202_imai_desc()
   
   CALL aimm202_get_oofg001_ref(g_imaf_m.imaf063)
        RETURNING g_imaf_m.imaf063_desc
   CALL aimm202_get_oofg001_ref(g_imaf_m.imaf073)
        RETURNING g_imaf_m.imaf073_desc
   CALL aimm202_get_oofg001_ref(g_imaf_m.imaf083)
        RETURNING g_imaf_m.imaf083_desc
        
   
   #161215-00006#6 add s
   CALL aimm202_imaf178_ref(g_imaf_m.imaf178)
   RETURNING g_imaf_m.imaf178_desc
   #161215-00006#6 add e
        
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imaf_m.imaf001,g_imaf_m.imaa002,g_imaf_m.imaal003,g_imaf_m.imaal004,g_imaf_m.imaal005, 
       g_imaf_m.imaa009,g_imaf_m.imaa009_desc,g_imaf_m.imaa003,g_imaf_m.imaa003_desc,g_imaf_m.imaa004, 
       g_imaf_m.imaa005,g_imaf_m.imaa005_desc,g_imaf_m.imaa006,g_imaf_m.imaa006_desc,g_imaf_m.imaa010, 
       g_imaf_m.imaa010_desc,g_imaf_m.s1,g_imaf_m.imaf051,g_imaf_m.imaf051_desc,g_imaf_m.imaf052,g_imaf_m.imaf052_desc, 
       g_imaf_m.imaf053,g_imaf_m.imaf053_desc,g_imaf_m.imaf054,g_imaf_m.imaf055,g_imaf_m.imaf057,g_imaf_m.imaf058, 
       g_imaf_m.imaf059,g_imaf_m.imafownid,g_imaf_m.imafownid_desc,g_imaf_m.imafowndp,g_imaf_m.imafowndp_desc, 
       g_imaf_m.imafcrtid,g_imaf_m.imafcrtid_desc,g_imaf_m.imafcrtdp,g_imaf_m.imafcrtdp_desc,g_imaf_m.imafcrtdt, 
       g_imaf_m.imafmodid,g_imaf_m.imafmodid_desc,g_imaf_m.imafmoddt,g_imaf_m.imafcnfid,g_imaf_m.imafcnfid_desc, 
       g_imaf_m.imafcnfdt,g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063,g_imaf_m.imaf063_desc,g_imaf_m.imaf064, 
       g_imaf_m.imaf071,g_imaf_m.imaf072,g_imaf_m.imaf073,g_imaf_m.imaf073_desc,g_imaf_m.imaf074,g_imaf_m.imaf081, 
       g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf083_desc,g_imaf_m.imaf084,g_imaf_m.imaf091,g_imaf_m.imaf091_desc, 
       g_imaf_m.imaf092,g_imaf_m.imaf092_desc,g_imaf_m.imaf177,g_imaf_m.imaf178,g_imaf_m.imaf178_desc, 
       g_imaf_m.imaf179,g_imaf_m.imaf101,g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095,g_imaf_m.imai031, 
       g_imaf_m.imai032,g_imaf_m.imai033,g_imaf_m.imai034,g_imaf_m.imai035,g_imaf_m.imai036,g_imaf_m.imai037, 
       g_imaf_m.imaf096
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aimm202_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   IF cl_null(g_imaf_m.imaf001) THEN
      CALL aimm202_imaa_desc1()
   ELSE
      CALL aimm202_imaa_desc()
   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aimm202_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imaf_m.imaf001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_imaf001_t = g_imaf_m.imaf001
 
   
   LET g_master_multi_table_t.imaal001 = g_imaf_m.imaf001
LET g_master_multi_table_t.imaal003 = g_imaf_m.imaal003
LET g_master_multi_table_t.imaal004 = g_imaf_m.imaal004
LET g_master_multi_table_t.imaal005 = g_imaf_m.imaal005
 
 
   OPEN aimm202_cl USING g_enterprise, g_site,g_imaf_m.imaf001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimm202_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimm202_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimm202_master_referesh USING g_site,g_imaf_m.imaf001 INTO g_imaf_m.imaf001,g_imaf_m.imaf051, 
       g_imaf_m.imaf052,g_imaf_m.imaf053,g_imaf_m.imaf054,g_imaf_m.imaf055,g_imaf_m.imaf057,g_imaf_m.imaf058, 
       g_imaf_m.imaf059,g_imaf_m.imafownid,g_imaf_m.imafowndp,g_imaf_m.imafcrtid,g_imaf_m.imafcrtdp, 
       g_imaf_m.imafcrtdt,g_imaf_m.imafmodid,g_imaf_m.imafmoddt,g_imaf_m.imafcnfid,g_imaf_m.imafcnfdt, 
       g_imaf_m.imaf061,g_imaf_m.imaf062,g_imaf_m.imaf063,g_imaf_m.imaf064,g_imaf_m.imaf071,g_imaf_m.imaf072, 
       g_imaf_m.imaf073,g_imaf_m.imaf074,g_imaf_m.imaf081,g_imaf_m.imaf082,g_imaf_m.imaf083,g_imaf_m.imaf084, 
       g_imaf_m.imaf091,g_imaf_m.imaf092,g_imaf_m.imaf177,g_imaf_m.imaf178,g_imaf_m.imaf179,g_imaf_m.imaf101, 
       g_imaf_m.imaf102,g_imaf_m.imaf094,g_imaf_m.imaf095,g_imaf_m.imaf096,g_imaf_m.imaf051_desc,g_imaf_m.imaf052_desc, 
       g_imaf_m.imaf053_desc,g_imaf_m.imafownid_desc,g_imaf_m.imafowndp_desc,g_imaf_m.imafcrtid_desc, 
       g_imaf_m.imafcrtdp_desc,g_imaf_m.imafmodid_desc,g_imaf_m.imafcnfid_desc,g_imaf_m.imaf178_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aimm202_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imaf_m_mask_o.* =  g_imaf_m.*
   CALL aimm202_imaf_t_mask()
   LET g_imaf_m_mask_n.* =  g_imaf_m.*
   
   #將最新資料顯示到畫面上
   CALL aimm202_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimm202_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM imaf_t 
       WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_imaf_m.imaf001 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imaf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'imaalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.imaal001
   LET l_field_keys[02] = 'imaal001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imaal_t')
 
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imaf_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aimm202_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aimm202_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aimm202_browser_fill(g_wc,"")
         CALL aimm202_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimm202_cl
 
   #功能已完成,通報訊息中心
   CALL aimm202_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimm202_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_imaf001 = g_imaf_m.imaf001
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="aimm202.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimm202_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("imaf001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("imaf094",TRUE)
   CALL cl_set_comp_entry("imaf095",TRUE)
   CALL cl_set_comp_entry("imaf062",TRUE)
   CALL cl_set_comp_entry("imaf063",TRUE)
   CALL cl_set_comp_entry("imaf064",TRUE)
   CALL cl_set_comp_entry("imaf072",TRUE)
   CALL cl_set_comp_entry("imaf073",TRUE)
   CALL cl_set_comp_entry("imaf074",TRUE)
   CALL cl_set_comp_entry("imaf082",TRUE)
   CALL cl_set_comp_entry("imaf083",TRUE)
   CALL cl_set_comp_entry("imaf084",TRUE)
   
   CALL cl_set_comp_entry("imaf178,imaf179",TRUE)  #160617-00004#2
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimm202_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_bcba002  LIKE bcba_t.bcba002   #161215-00006#6 add
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imaf001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_imaf_m.imaf095) AND g_imaf_m.imaf095 > 0 THEN
      CALL cl_set_comp_entry("imaf094",FALSE)
   END IF
   IF NOT cl_null(g_imaf_m.imaf094) AND g_imaf_m.imaf094 > 0  THEN
      CALL cl_set_comp_entry("imaf095",FALSE)
   END IF
   IF g_site <> 'ALL' THEN
      CALL s_aooi090_set_no_entry('1')
   END IF
   IF g_imaf_m.imaf061 = '2' THEN
      CALL cl_set_comp_entry("imaf062",FALSE)
      CALL cl_set_comp_entry("imaf063",FALSE)
      CALL cl_set_comp_entry("imaf064",FALSE)
      LET g_imaf_m.imaf062 = 'N'
      LET g_imaf_m.imaf063 = ''
      LET g_imaf_m.imaf064 = '1'
   END IF
   IF g_imaf_m.imaf071 = '2' THEN
      CALL cl_set_comp_entry("imaf072",FALSE)
      CALL cl_set_comp_entry("imaf073",FALSE)
      CALL cl_set_comp_entry("imaf074",FALSE)
      LET g_imaf_m.imaf072 = 'N'
      LET g_imaf_m.imaf073 = ''
      LET g_imaf_m.imaf074 = '1'
   END IF
   IF g_imaf_m.imaf081 = '2' THEN
      CALL cl_set_comp_entry("imaf082",FALSE)
      CALL cl_set_comp_entry("imaf083",FALSE)
      CALL cl_set_comp_entry("imaf084",FALSE)
      LET g_imaf_m.imaf082 = 'N'
      LET g_imaf_m.imaf083 = ''
      LET g_imaf_m.imaf084 = '1'
   END IF
   
   #160617-00004#2--s--
   IF cl_null(g_imaf_m.imaf177) OR g_imaf_m.imaf177 = 'N' THEN
      CALL cl_set_comp_entry("imaf178,imaf179",FALSE)
      LET g_imaf_m.imaf178 = ''
      LET g_imaf_m_o.imaf178 = '' #161215-00006#6 add
      LET g_imaf_m.imaf178_desc = ''
      LET g_imaf_m.imaf179 = ''
      DISPLAY BY NAME g_imaf_m.imaf178,g_imaf_m.imaf178_desc,g_imaf_m.imaf179
   END IF
   #160617-00004#2---e
   
   #161215-00006#6 add s
   IF NOT cl_null(g_imaf_m.imaf178) THEN
      SELECT bcba002
        INTO l_bcba002
        FROM bcba_t
       WHERE bcbaent = g_enterprise
         AND bcba001 = g_imaf_m.imaf178
      
      #物料條碼
      IF l_bcba002 = '3' THEN
         CALL cl_set_comp_entry("imaf179",FALSE)
      END IF
   END IF
   #161215-00006#6 add e
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimm202_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimm202.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimm202_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimm202.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimm202_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   DEFINE l_wc    STRING
   DEFINE l_wc1   STRING
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " imaf001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " imaf001 = '", g_argv[02], "' AND "
   END IF
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc , " AND imafsite = '", g_argv[01], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimm202.mask_functions" >}
&include "erp/aim/aimm202_mask.4gl"
 
{</section>}
 
{<section id="aimm202.state_change" >}
   
 
{</section>}
 
{<section id="aimm202.signature" >}
   
 
{</section>}
 
{<section id="aimm202.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimm202_set_pk_array()
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
   LET g_pk_array[1].values = g_imaf_m.imaf001
   LET g_pk_array[1].column = 'imaf001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimm202.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aimm202.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimm202_msgcentre_notify(lc_state)
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
   CALL aimm202_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imaf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimm202.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimm202_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimm202.other_function" readonly="Y" >}
# 庫存分群碼檢查
PRIVATE FUNCTION aimm202_chk_imcc()
DEFINE l_n       LIKE type_t.num5

    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM imcc_t
     WHERE imcc051 = g_imaf_m.imaf051
       AND imccent = g_enterprise
       AND imccsite = g_site
    IF l_n = 0 THEN
       #IF g_prog = 'aimm202' THEN        #160705-00042#11 160714 by sakura mark
       #IF g_prog MATCHES 'aimm202' THEN  #160705-00042#11 160714 by sakura add #170301-00017#8 mark
       IF g_prog MATCHES 'aimm202*' THEN  #170301-00017#8  09276 add
          LET g_errno = 'aim-00044'
       ELSE
          LET g_errno = 'aim-00137'
       END IF
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM imcc_t
        WHERE imcc051 = g_imaf_m.imaf051
          AND imccent = g_enterprise
          AND imccsite = g_site
          AND imccstus = 'Y'
       IF l_n = 0 THEN
          #IF g_prog = 'aimm202' THEN        #160705-00042#11 160714 by sakura mark
          #IF g_prog MATCHES 'aimm202' THEN  #160705-00042#11 160714 by sakura add #170301-00017#8 mark
          IF g_prog MATCHES 'aimm202*' THEN  #170301-00017#8  09276 add
             LET g_errno = 'sub-01302'  #160318-00005#20 mod #'aim-00045'
          ELSE
             LET g_errno = 'sub-01302'  #160318-00005#20 mod 'aim-00138'
          END IF
       END IF
    END IF
END FUNCTION
#參考欄位賦值
PRIVATE FUNCTION aimm202_desc()
   IF cl_null(g_imaf_m.imaf051) THEN
      LET g_imaf_m.imaf051_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaf_m.imaf051
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='201' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaf_m.imaf051_desc =  g_rtn_fields[1]
   END IF
   DISPLAY BY NAME g_imaf_m.imaf051_desc
            
   IF cl_null(g_imaf_m.imaf052) THEN
      LET g_imaf_m.imaf052_desc = ""
   ELSE
      #161219-00027#1 mark---start---   
      #SELECT ooag002 INTO l_ooag002 
      #  FROM ooag_t
      # WHERE ooagent = g_enterprise
      #   AND ooag001 = g_imaf_m.imaf052
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = l_ooag002
      #CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa001=? ","") RETURNING g_rtn_fields
      #LET g_imaf_m.imaf052_desc = g_rtn_fields[1] 
      #161219-00027#1 mark---end---
      #161219-00027#1 add---start---
      SELECT ooag011 INTO g_imaf_m.imaf052_desc
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_imaf_m.imaf052
      #161219-00027#1 add---end---
   END IF
   DISPLAY BY NAME g_imaf_m.imaf052_desc
   
   IF cl_null(g_imaf_m.imaf053) THEN
      LET g_imaf_m.imaf053_desc = ""
   ELSE   
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaf_m.imaf053
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_imaf_m.imaf053_desc = g_rtn_fields[1] 
   END IF   
   DISPLAY BY NAME g_imaf_m.imaf053_desc
   
   IF cl_null(g_imaf_m.imaf091) THEN
      LET g_imaf_m.imaf091_desc = ""
   ELSE   
      IF g_site = 'ALL' THEN
		   CALL s_desc_get_stock_desc(g_site1,g_imaf_m.imaf091) RETURNING g_imaf_m.imaf091_desc
		ELSE
         CALL s_desc_get_stock_desc(g_site,g_imaf_m.imaf091) RETURNING g_imaf_m.imaf091_desc        #呼叫開窗
      END IF
   END IF   
   DISPLAY BY NAME g_imaf_m.imaf091_desc
      
   IF cl_null(g_imaf_m.imaf092) THEN
      LET g_imaf_m.imaf092_desc = ""
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_imaf_m.imaf091
      LET g_ref_fields[2] = g_imaf_m.imaf092 
      IF g_site = 'ALL' THEN
		   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site1||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
		ELSE
         CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
      END IF
      LET g_imaf_m.imaf092_desc =  g_rtn_fields[1]
   END IF   
   DISPLAY BY NAME g_imaf_m.imaf092_desc
   
   #160617-00004#2--s--
   CALL aimm202_imaf178_ref(g_imaf_m.imaf178) RETURNING g_imaf_m.imaf178_desc
   DISPLAY BY NAME g_imaf_m.imaf178_desc
   #160617-00004#2--e--
END FUNCTION
# 單位檢查
PRIVATE FUNCTION aimm202_chk_ooca()
 DEFINE l_n            LIKE type_t.num5

    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM ooca_t
     WHERE ooca001 = g_imaf_m.imaf053
       AND oocaent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aim-00004'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM ooca_t
        WHERE ooca001 = g_imaf_m.imaf053
          AND oocaent = g_enterprise
          AND oocastus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#20 mod  #'aim-00005'
       END IF
    END IF
END FUNCTION
# 員工編號檢查
PRIVATE FUNCTION aimm202_chk_ooag()
DEFINE l_n       LIKE type_t.num5

    LET g_errno = ""
    LET l_n = 0
    SELECT COUNT(*) INTO l_n
      FROM ooag_t
     WHERE ooag001 = g_imaf_m.imaf052
       AND ooagent = g_enterprise
    IF l_n = 0 THEN
       LET g_errno = 'aoo-00074'
    ELSE
       LET l_n =0
       SELECT COUNT(*) INTO l_n
         FROM ooag_t
        WHERE ooag001 = g_imaf_m.imaf052
          AND ooagent = g_enterprise
          AND ooagstus = 'Y'
       IF l_n = 0 THEN
          LET g_errno =  'sub-01302'  #160318-00005#20 mod 'aoo-00071'
       END IF
    END IF
END FUNCTION
# 不可錄字段顯示
PRIVATE FUNCTION aimm202_imaa_desc()
   SELECT imaa002,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010,imaastus
     INTO g_imaf_m.imaa002,g_imaf_m.imaa009,g_imaf_m.imaa003,
          g_imaf_m.imaa004,g_imaf_m.imaa005,g_imaf_m.imaa006,
          g_imaf_m.imaa010,g_imaf_m.s1
     FROM imaa_t
    WHERE imaa001 = g_imaf_m.imaf001
      AND imaaent = g_enterprise
   DISPLAY BY NAME g_imaf_m.imaa002,g_imaf_m.imaa009,g_imaf_m.imaa003,g_imaf_m.imaa004,
                   g_imaf_m.imaa005,g_imaf_m.imaa006,g_imaf_m.imaa010,g_imaf_m.s1
    
   SELECT imaal003,imaal004,imaal005
     INTO g_imaf_m.imaal003,g_imaf_m.imaal004,g_imaf_m.imaal005
     FROM imaal_t
    WHERE imaalent = g_enterprise
      AND imaal001 = g_imaf_m.imaf001
      AND imaal002 = g_dlang
   DISPLAY BY NAME g_imaf_m.imaal003,g_imaf_m.imaal004,g_imaf_m.imaal005
   
   SELECT rtaxl003  INTO g_imaf_m.imaa009_desc
     FROM rtaxl_t
    WHERE rtaxl001 = g_imaf_m.imaa009
      AND rtaxl002 = g_dlang
      AND rtaxlent = g_enterprise
   DISPLAY BY NAME g_imaf_m.imaa009_desc
   
   
   SELECT oocql004 INTO g_imaf_m.imaa003_desc
     FROM oocql_t
    WHERE oocql001 = '200'
      AND oocql002 = g_imaf_m.imaa003
      AND oocql003 = g_dlang
      AND oocqlent = g_enterprise
   DISPLAY BY NAME g_imaf_m.imaa003_desc
   
   LET g_imaf_m.imaa005_desc = ""
   SELECT imeal003 INTO g_imaf_m.imaa005_desc
     FROM imeal_t
    WHERE imeal001 = g_imaf_m.imaa005
      AND imeal002 = g_dlang
      AND imealent = g_enterprise
   DISPLAY BY NAME g_imaf_m.imaa005_desc
   
   SELECT oocal003 INTO g_imaf_m.imaa006_desc
     FROM oocal_t
    WHERE oocal001 = g_imaf_m.imaa006
      AND oocal002 = g_dlang
      AND oocalent = g_enterprise
   DISPLAY BY NAME g_imaf_m.imaa006_desc
   
   SELECT oocql004  INTO g_imaf_m.imaa010_desc
     FROM oocql_t
    WHERE oocql001 = '210'
      AND oocql002 = g_imaf_m.imaa010
      AND oocql003 = g_dlang
      AND oocqlent = g_enterprise
   DISPLAY BY NAME g_imaf_m.imaa010_desc
END FUNCTION
#參考欄位清空
PRIVATE FUNCTION aimm202_imaa_desc1()
   LET g_imaf_m.imaa002 = ""  
   LET g_imaf_m.imaa003 = ""
   LET g_imaf_m.imaa004 = ""
   LET g_imaf_m.imaa005 = ""
   LET g_imaf_m.imaa006 = ""
   LET g_imaf_m.imaa009 = ""
   LET g_imaf_m.imaa010 = ""
   LET g_imaf_m.imaa003_desc = ""
   LET g_imaf_m.imaa005_desc = ""
   LET g_imaf_m.imaa006_desc = ""
   LET g_imaf_m.imaa009_desc = ""
   LET g_imaf_m.imaa010_desc = ""
   LET g_imaf_m.s1 = ""
   LET g_imaf_m.imaal003 = ""
   LET g_imaf_m.imaal004 = ""
   LET g_imaf_m.imaal005 = ""
   DISPLAY BY NAME g_imaf_m.imaa002,g_imaf_m.imaa009,g_imaf_m.imaa003,g_imaf_m.imaa004,
                   g_imaf_m.imaa005,g_imaf_m.imaa006,g_imaf_m.imaa010,g_imaf_m.s1
   DISPLAY BY NAME g_imaf_m.imaal003,g_imaf_m.imaal004,g_imaf_m.imaal005,
                   g_imaf_m.imaa009_desc,g_imaf_m.imaa003_desc,g_imaf_m.imaa005_desc,g_imaf_m.imaa006_desc,g_imaf_m.imaa010_desc

END FUNCTION
################################################################################
# Descriptions...: 檢查aooi090是否設置對應欄位
# Memo...........:
# Usage..........: CALL aimm202_chk_ooeh(p_ooeh002)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm202_chk_ooeh(p_ooeh002)
DEFINE p_ooeh002        LIKE ooeh_t.ooeh002
DEFINE l_n              LIKE type_t.num5

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ooeh_t
    WHERE ooehent = g_enterprise
      AND ooeh001 = '1'   
      AND ooeh002 = p_ooeh002
   IF l_n = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 重新带料件分群资料
# Memo...........:
# Usage..........: CALL aimm202_get_imcc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/14 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm202_get_imcc()
#DEFINE l_imcc            RECORD LIKE imcc_t.*  #161124-00048#2   2016/12/07 By 08734 mark
#161124-00048#2   2016/12/07 By 08734 add(S)
DEFINE l_imcc RECORD  #料件據點庫存分群檔
       imccent LIKE imcc_t.imccent, #企业编号
       imccownid LIKE imcc_t.imccownid, #资料所有者
       imccowndp LIKE imcc_t.imccowndp, #资料所有部门
       imcccrtid LIKE imcc_t.imcccrtid, #资料录入者
       imcccrtdp LIKE imcc_t.imcccrtdp, #资料录入部门
       imcccrtdt LIKE imcc_t.imcccrtdt, #资料创建日
       imccmodid LIKE imcc_t.imccmodid, #资料更改者
       imccmoddt LIKE imcc_t.imccmoddt, #最近更改日
       imccstus LIKE imcc_t.imccstus, #状态码
       imcc051 LIKE imcc_t.imcc051, #库存分群
       imcc052 LIKE imcc_t.imcc052, #仓管员
       imcc053 LIKE imcc_t.imcc053, #据点库存单位
       imcc054 LIKE imcc_t.imcc054, #库存多单位
       imcc055 LIKE imcc_t.imcc055, #库存管理特微
       imcc056 LIKE imcc_t.imcc056, #库存管理特征可空白
       imcc057 LIKE imcc_t.imcc057, #ABC码
       imcc058 LIKE imcc_t.imcc058, #存货备置策略
       imcc059 LIKE imcc_t.imcc059, #捡货策略
       imcc061 LIKE imcc_t.imcc061, #库存批号控管方式
       imcc062 LIKE imcc_t.imcc062, #库存批号自动编码否
       imcc063 LIKE imcc_t.imcc063, #库存批号编码方式
       imcc064 LIKE imcc_t.imcc064, #库存批号唯一性检查控管
       imcc071 LIKE imcc_t.imcc071, #制造批号控管方式
       imcc072 LIKE imcc_t.imcc072, #制造批号自动编码否
       imcc073 LIKE imcc_t.imcc073, #制造批号编码方式
       imcc074 LIKE imcc_t.imcc074, #制造批号唯一性检查控管
       imcc081 LIKE imcc_t.imcc081, #序号控管方式
       imcc082 LIKE imcc_t.imcc082, #序号自动编码否
       imcc083 LIKE imcc_t.imcc083, #序号编码方式
       imcc084 LIKE imcc_t.imcc084, #序号唯一性检查控管
       imcc091 LIKE imcc_t.imcc091, #默认库位
       imcc092 LIKE imcc_t.imcc092, #默认储位
       imcc093 LIKE imcc_t.imcc093, #箱盒号条码管理
       imcc094 LIKE imcc_t.imcc094, #盘点容差数
       imcc095 LIKE imcc_t.imcc095, #盘点容差率
       imccsite LIKE imcc_t.imccsite, #营运据点
       imcc097 LIKE imcc_t.imcc097, #no use
       imcc101 LIKE imcc_t.imcc101, #调拨批量
       imcc102 LIKE imcc_t.imcc102, #调拨最小数量
       imcc096 LIKE imcc_t.imcc096, #呆滞日期开账
       imcc103 LIKE imcc_t.imcc103, #箱盒号条码管理
       imcc104 LIKE imcc_t.imcc104, #条码编码方式
       imcc105 LIKE imcc_t.imcc105 #条码包装数量
END RECORD
#161124-00048#2   2016/12/07 By 08734 add(E)

   #SELECT * INTO l_imcc.*  #161124-00048#2   2016/12/07 By 08734 mark
   SELECT imccent,imccownid,imccowndp,imcccrtid,imcccrtdp,imcccrtdt,imccmodid,imccmoddt,imccstus,imcc051,imcc052,imcc053,imcc054,imcc055,imcc056,imcc057,imcc058,imcc059,imcc061,imcc062,imcc063,imcc064,imcc071,imcc072,imcc073,imcc074,imcc081,imcc082,imcc083,imcc084,imcc091,imcc092,imcc093,imcc094,imcc095,imccsite,imcc097,imcc101,imcc102,imcc096,imcc103,imcc104,imcc105  #161124-00048#2   2016/12/07 By 08734 add
     INTO l_imcc.*
     FROM imcc_t
    WHERE imccent = g_enterprise
      AND imccsite = g_site
      AND imcc051 = g_imaf_m.imaf051
   #IF g_prog = 'aimm212' THEN        #160705-00042#11 160714 by sakura mark
   #IF g_prog MATCHES 'aimm212' THEN  #160705-00042#11 160714 by sakura add #170301-00017#8 mark
   IF g_prog MATCHES 'aimm212*' THEN  #170301-00017#8  09276 add
      IF NOT aimm202_chk_ooeh('imaf052') THEN
         LET g_imaf_m.imaf052 = l_imcc.imcc052
      END IF
      IF NOT aimm202_chk_ooeh('imaf053') THEN
         LET g_imaf_m.imaf053 = l_imcc.imcc053
      END IF
      IF NOT aimm202_chk_ooeh('imaf054') THEN
         LET g_imaf_m.imaf054 = l_imcc.imcc054
      END IF
      IF NOT aimm202_chk_ooeh('imaf055') THEN
         LET g_imaf_m.imaf055 = l_imcc.imcc055
      END IF
      IF NOT aimm202_chk_ooeh('imaf057') THEN
         LET g_imaf_m.imaf057 = l_imcc.imcc057
      END IF
      IF NOT aimm202_chk_ooeh('imaf058') THEN
         LET g_imaf_m.imaf058 = l_imcc.imcc058
      END IF
      IF NOT aimm202_chk_ooeh('imaf059') THEN
         LET g_imaf_m.imaf059 = l_imcc.imcc059
      END IF
      IF NOT aimm202_chk_ooeh('imaf061') THEN
         LET g_imaf_m.imaf061 = l_imcc.imcc061
      END IF
      IF NOT aimm202_chk_ooeh('imaf062') THEN
         LET g_imaf_m.imaf062 = l_imcc.imcc062
      END IF
      IF NOT aimm202_chk_ooeh('imaf063') THEN
         LET g_imaf_m.imaf063 = l_imcc.imcc063
      END IF
      IF NOT aimm202_chk_ooeh('imaf064') THEN
         LET g_imaf_m.imaf064 = l_imcc.imcc064
      END IF
      IF NOT aimm202_chk_ooeh('imaf071') THEN
         LET g_imaf_m.imaf071 = l_imcc.imcc071
      END IF
      IF NOT aimm202_chk_ooeh('imaf072') THEN
         LET g_imaf_m.imaf072 = l_imcc.imcc072
      END IF
      IF NOT aimm202_chk_ooeh('imaf073') THEN
         LET g_imaf_m.imaf073 = l_imcc.imcc073
      END IF
      IF NOT aimm202_chk_ooeh('imaf074') THEN
         LET g_imaf_m.imaf074 = l_imcc.imcc074
      END IF
      IF NOT aimm202_chk_ooeh('imaf081') THEN
         LET g_imaf_m.imaf081 = l_imcc.imcc081
      END IF
      IF NOT aimm202_chk_ooeh('imaf082') THEN
         LET g_imaf_m.imaf082 = l_imcc.imcc082
      END IF
      IF NOT aimm202_chk_ooeh('imaf083') THEN
         LET g_imaf_m.imaf083 = l_imcc.imcc083
      END IF
      IF NOT aimm202_chk_ooeh('imaf084') THEN
      LET g_imaf_m.imaf084 = l_imcc.imcc084
      END IF
      IF NOT aimm202_chk_ooeh('imaf091') THEN
      LET g_imaf_m.imaf091 = l_imcc.imcc091
      END IF
      IF NOT aimm202_chk_ooeh('imaf092') THEN
         LET g_imaf_m.imaf092 = l_imcc.imcc092
      END IF
      #160617-00004#2--s
      #IF NOT aimm202_chk_ooeh('imaf093') THEN
      #   LET g_imaf_m.imaf093 = l_imcc.imcc093
      #END IF
      #160617-00004#2--e
      IF NOT aimm202_chk_ooeh('imaf094') THEN
         LET g_imaf_m.imaf094 = l_imcc.imcc094
      END IF
      IF NOT aimm202_chk_ooeh('imaf095') THEN
         LET g_imaf_m.imaf095 = l_imcc.imcc095
      END IF
      IF NOT aimm202_chk_ooeh('imaf096') THEN
         LET g_imaf_m.imaf096 = l_imcc.imcc096
      END IF

      IF NOT aimm202_chk_ooeh('imaf101') THEN
         LET g_imaf_m.imaf101 = l_imcc.imcc101
      END IF
      IF NOT aimm202_chk_ooeh('imaf102') THEN
         LET g_imaf_m.imaf102 = l_imcc.imcc102
      END IF
      #160617-00004#2--s
      IF NOT aimm202_chk_ooeh('imaf177') THEN
         LET g_imaf_m.imaf177 = l_imcc.imcc103
      END IF
      IF NOT aimm202_chk_ooeh('imaf178') THEN
         LET g_imaf_m.imaf178 = l_imcc.imcc104
      END IF
      IF NOT aimm202_chk_ooeh('imaf179') THEN
         LET g_imaf_m.imaf179 = l_imcc.imcc105
      END IF
      #160617-00004#2--e
   ELSE
      LET g_imaf_m.imaf052 = l_imcc.imcc052
      LET g_imaf_m.imaf053 = l_imcc.imcc053
      LET g_imaf_m.imaf054 = l_imcc.imcc054
      LET g_imaf_m.imaf055 = l_imcc.imcc055
      LET g_imaf_m.imaf057 = l_imcc.imcc057
      LET g_imaf_m.imaf058 = l_imcc.imcc058
      LET g_imaf_m.imaf059 = l_imcc.imcc059
      LET g_imaf_m.imaf061 = l_imcc.imcc061
      LET g_imaf_m.imaf062 = l_imcc.imcc062
      LET g_imaf_m.imaf063 = l_imcc.imcc063
      LET g_imaf_m.imaf064 = l_imcc.imcc064
      LET g_imaf_m.imaf071 = l_imcc.imcc071
      LET g_imaf_m.imaf072 = l_imcc.imcc072
      LET g_imaf_m.imaf073 = l_imcc.imcc073
      LET g_imaf_m.imaf074 = l_imcc.imcc074
      LET g_imaf_m.imaf081 = l_imcc.imcc081
      LET g_imaf_m.imaf082 = l_imcc.imcc082
      LET g_imaf_m.imaf083 = l_imcc.imcc083
      LET g_imaf_m.imaf084 = l_imcc.imcc084
      LET g_imaf_m.imaf091 = l_imcc.imcc091
      LET g_imaf_m.imaf092 = l_imcc.imcc092
      #LET g_imaf_m.imaf093 = l_imcc.imcc093  #160617-00004#2
      LET g_imaf_m.imaf094 = l_imcc.imcc094
      LET g_imaf_m.imaf095 = l_imcc.imcc095
      LET g_imaf_m.imaf096 = l_imcc.imcc096
      LET g_imaf_m.imaf101 = l_imcc.imcc101
      LET g_imaf_m.imaf102 = l_imcc.imcc102
      #160617-00004#2--s
      LET g_imaf_m.imaf177 = l_imcc.imcc103
      LET g_imaf_m.imaf178 = l_imcc.imcc104
      LET g_imaf_m.imaf179 = l_imcc.imcc105
      #160617-00004#2--e
   END IF
   IF cl_null(g_imaf_m.imaf054) THEN
      LET g_imaf_m.imaf054 = "N"
   END IF
   IF cl_null(g_imaf_m.imaf055) THEN
      LET g_imaf_m.imaf055 = "3"
   END IF
   IF cl_null(g_imaf_m.imaf057) THEN
      LET g_imaf_m.imaf057 = "A"
   END IF
   IF cl_null(g_imaf_m.imaf058) THEN
      LET g_imaf_m.imaf058 = "0"
   END IF
   IF cl_null(g_imaf_m.imaf059) THEN
      LET g_imaf_m.imaf059 = "1"
   END IF
   IF cl_null(g_imaf_m.imaf061) THEN
      LET g_imaf_m.imaf061 = "3"
   END IF
   IF cl_null(g_imaf_m.imaf062) THEN
      LET g_imaf_m.imaf062 = "N"
   END IF
   IF cl_null(g_imaf_m.imaf064) THEN
      LET g_imaf_m.imaf064 = "3"
   END IF
   IF cl_null(g_imaf_m.imaf071) THEN
      LET g_imaf_m.imaf071 = "1"
   END IF
   IF cl_null(g_imaf_m.imaf072) THEN
      LET g_imaf_m.imaf072 = "Y"
   END IF
   IF cl_null(g_imaf_m.imaf074) THEN
      LET g_imaf_m.imaf074 = "2"
   END IF
   IF cl_null(g_imaf_m.imaf081) THEN
      LET g_imaf_m.imaf081 = "1"
   END IF
   IF cl_null(g_imaf_m.imaf082) THEN
      LET g_imaf_m.imaf082 = "Y"
   END IF
   IF cl_null(g_imaf_m.imaf084) THEN
      LET g_imaf_m.imaf084 = "2"
   END IF
   #160617-00004#2--s
   #IF cl_null(g_imaf_m.imaf093) THEN
   #   LET g_imaf_m.imaf093 = "N"
   #END IF
   #160617-00004#2--e
   IF cl_null(g_imaf_m.imaf094) THEN
      LET g_imaf_m.imaf094 = "0"
   END IF
   IF cl_null(g_imaf_m.imaf095) THEN
      LET g_imaf_m.imaf095 = "0"
   END IF
   IF cl_null(g_imaf_m.imaf101) THEN
      LET g_imaf_m.imaf101 = "0"
   END IF
   IF cl_null(g_imaf_m.imaf102) THEN
      LET g_imaf_m.imaf102 = "0"
   END IF
   IF cl_null(g_imaf_m.imaf053) THEN
      LET g_imaf_m.imaf053 = g_imaf_m.imaa006
      IF cl_null(g_imaf_m.imaf053) THEN
         LET g_imaf_m.imaf053_desc = ""
      ELSE   
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_imaf_m.imaf053
         CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_imaf_m.imaf053_desc = g_rtn_fields[1] 
      END IF   
      DISPLAY BY NAME g_imaf_m.imaf053_desc
   END IF
   
   #160617-00004#2--s
   IF cl_null(g_imaf_m.imaf177) THEN
      LET g_imaf_m.imaf177 = "N"
   END IF
   #160617-00004#2--e
      
END FUNCTION

PRIVATE FUNCTION aimm202_imai_desc()

   SELECT imai031,imai032,imai033,imai034,imai035,imai036,imai037 INTO g_imaf_m.imai031,g_imaf_m.imai032,g_imaf_m.imai033,g_imaf_m.imai034,g_imaf_m.imai035,g_imaf_m.imai036,g_imaf_m.imai037
     FROM imai_t WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = g_imaf_m.imaf001
   
   DISPLAY BY NAME g_imaf_m.imai031,g_imaf_m.imai032,g_imaf_m.imai033,g_imaf_m.imai034,g_imaf_m.imai035,g_imaf_m.imai036,g_imaf_m.imai037
   
END FUNCTION

################################################################################
# Descriptions...: 取得自動編碼的說明
# Memo...........:
# Usage..........: CALL aimm202_get_oofg001_ref(p_oofgl001)
#                  RETURNING r_oofgl004
# Input parameter: p_oofgl001：編碼分類
# Return code....: r_oofgl004：說明
# Date & Author..: 2015/10/06 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm202_get_oofg001_ref(p_oofgl001)
   DEFINE p_oofgl001     LIKE oofgl_t.oofgl001     #編碼分類 
   DEFINE r_oofgl004     LIKE oofgl_t.oofgl004     #說明 

   LET r_oofgl004 = ''

   IF cl_null(p_oofgl001) THEN
      RETURN r_oofgl004
   END IF

   SELECT oofgl004 INTO r_oofgl004
     FROM oofgl_t
    WHERE oofglent = g_enterprise
      AND oofgl001 = p_oofgl001
      AND oofgl002 = ' '
      AND oofgl003 = g_dlang

   RETURN r_oofgl004
END FUNCTION

################################################################################
# Descriptions...: 設定欄位是否必要輸入
# Memo...........:
# Usage..........: CALL aimm202_set_no_required()
# Date & Author..: 2015/10/06 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm202_set_no_required()
   CALL cl_set_comp_required("imaf063,imaf073,imaf083",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 設定欄位是否必要輸入
# Memo...........:
# Usage..........: CALL aimm202_set_required()
# Date & Author..: 2015/10/06 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm202_set_required()
   IF g_imaf_m.imaf062 = 'Y' THEN
      CALL cl_set_comp_required("imaf063",TRUE)
   END IF
   IF g_imaf_m.imaf072 = 'Y' THEN
      CALL cl_set_comp_required("imaf073",TRUE)
   END IF
   IF g_imaf_m.imaf082 = 'Y' THEN
      CALL cl_set_comp_required("imaf083",TRUE)
   END IF
END FUNCTION

#160617-00004#2
PRIVATE FUNCTION aimm202_imaf178_ref(p_imaf178)
DEFINE p_imaf178      LIKE imaf_t.imaf178
DEFINE r_imaf178_desc LIKE oofgl_t.oofgl004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_imaf178
   
   #161215-00006#6 mod s
#   CALL ap_ref_array2(g_ref_fields,"SELECT oofgl004 FROM oofgl_t WHERE oofglent='"||g_enterprise||"' AND oofgl001=? AND oofgl002=' ' AND oofgl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   CALL ap_ref_array2(g_ref_fields,"SELECT bcbal003 FROM bcbal_t WHERE bcbalent='"||g_enterprise||"' AND bcbal001=? AND bcbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #161215-00006#6 mod e
   
   LET r_imaf178_desc =  g_rtn_fields[1]
   RETURN r_imaf178_desc
   
END FUNCTION

################################################################################
# Descriptions...: 條碼編號檢查
# Memo...........:
# Usage..........: CALL aimm202_imaf178_chk()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 
# Modify.........: #161215-00006#6    2017/01/18   By earl
################################################################################
PRIVATE FUNCTION aimm202_imaf178_chk()
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   
   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   INITIALIZE g_chkparam.* TO NULL
   
   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_imaf_m.imaf178
   LET g_errshow = TRUE #是否開窗 
   
   IF NOT cl_chk_exist("v_bcba001") THEN
      LET r_success = FALSE
   ELSE
      SELECT bcba003
        INTO g_imaf_m.imaf179
        FROM bcba_t
       WHERE bcbaent = g_enterprise
         AND bcba001 = g_imaf_m.imaf178
      
      DISPLAY BY NAME g_imaf_m.imaf179
   END IF

   RETURN r_success
END FUNCTION

 
{</section>}
 
