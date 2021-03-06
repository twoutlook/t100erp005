#該程式未解開Section, 採用最新樣板產出!
{<section id="aimm205.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0027(2016-10-27 14:26:46), PR版次:0027(2017-02-21 09:47:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000368
#+ Filename...: aimm205
#+ Description: 集團預設料件據點生管資料維護作業
#+ Creator....: 02294(2013-08-05 15:29:08)
#+ Modifier...: 08734 -SD/PR- 08993
 
{</section>}
 
{<section id="aimm205.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#20  2016/03/30 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#2   2016/04/07 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160623-00014#1   2016/06/27 By 07024   為應應行業別，修改g_prog。
#                                                    原：g_prog='程式代碼'→改成：g_prog MATCHES '程式代碼*
#160705-00042#9   2016/07/13 By sakura  #160623-00014#1,g_prog MATCHES '程式代碼*'→g_prog MATCHES '程式代碼'
#160727-00018#1   2016/08/02 By fengmy aimm205作业上，生管员栏位不应该设置成必填,集团料件一般不可能指定生管员，要据点料件才有
#160729-00020#1   2016/08/02 By lixiang  仓管员集团应该要可以开到据点的人员资料
#160913-00055#1   2016/09/18  By lixiang  供应商栏位开窗调整为q_pmaa001，去掉手动加的限定条件
#161015-00001#3   2016/10/19 By 08734   新建imae086栏位并在修改生管分群时带出aimi105中资料
#161122-00017#1   2016/11/23 By ywtsai  製程料號輸入後僅需檢查存在料件檔理即可，不需檢查aecm200，故加入v_imaa001校驗值判斷
#161124-00023#1   2016/12/05 By lixiang 生管分群、计划员栏位校验时，需关联当前据点
#161124-00048#2   2016/12/07 By 08734   星号整批调整
#170203-00002#10  2017/02/07 By 06814   新舊值寫法調整
#160711-00040#14  2017/02/16 By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                      CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#170217-00068#2   2017/02/21 By 08993   g_prog MATCHES '程式編號*'，修正漏寫*的問題
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
PRIVATE TYPE type_g_imae_m RECORD
       imae001 LIKE imae_t.imae001, 
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
   status1 LIKE type_t.chr500, 
   imaf012 LIKE imaf_t.imaf012, 
   imaf013 LIKE imaf_t.imaf013, 
   imaf014 LIKE imaf_t.imaf014, 
   imae011 LIKE imae_t.imae011, 
   imae011_desc LIKE type_t.chr80, 
   imae012 LIKE imae_t.imae012, 
   imae012_desc LIKE type_t.chr80, 
   imaeownid LIKE imae_t.imaeownid, 
   imaeownid_desc LIKE type_t.chr80, 
   imaeowndp LIKE imae_t.imaeowndp, 
   imaeowndp_desc LIKE type_t.chr80, 
   imaecrtid LIKE imae_t.imaecrtid, 
   imaecrtid_desc LIKE type_t.chr80, 
   imaecrtdp LIKE imae_t.imaecrtdp, 
   imaecrtdp_desc LIKE type_t.chr80, 
   imaecrtdt LIKE imae_t.imaecrtdt, 
   imaemodid LIKE imae_t.imaemodid, 
   imaemodid_desc LIKE type_t.chr80, 
   imaemoddt LIKE imae_t.imaemoddt, 
   imae013 LIKE imae_t.imae013, 
   imae014 LIKE imae_t.imae014, 
   imae015 LIKE imae_t.imae015, 
   imae023 LIKE imae_t.imae023, 
   imae016 LIKE imae_t.imae016, 
   imae016_desc LIKE type_t.chr80, 
   imae017 LIKE imae_t.imae017, 
   imae018 LIKE imae_t.imae018, 
   imae019 LIKE imae_t.imae019, 
   imae020 LIKE imae_t.imae020, 
   imae021 LIKE imae_t.imae021, 
   imae031 LIKE imae_t.imae031, 
   imae031_desc LIKE type_t.chr80, 
   imae037 LIKE imae_t.imae037, 
   imae032 LIKE imae_t.imae032, 
   imae032_desc LIKE type_t.chr80, 
   imae033 LIKE imae_t.imae033, 
   imae033_desc LIKE type_t.chr80, 
   imae034 LIKE imae_t.imae034, 
   imae034_desc LIKE type_t.chr80, 
   imae035 LIKE imae_t.imae035, 
   imae035_desc LIKE type_t.chr80, 
   imae022 LIKE imae_t.imae022, 
   imae036 LIKE imae_t.imae036, 
   imae041 LIKE imae_t.imae041, 
   imae041_desc LIKE type_t.chr80, 
   imae042 LIKE imae_t.imae042, 
   imae042_desc LIKE type_t.chr80, 
   imae051 LIKE imae_t.imae051, 
   imae052 LIKE imae_t.imae052, 
   imae062 LIKE imae_t.imae062, 
   imae064 LIKE imae_t.imae064, 
   imae077 LIKE imae_t.imae077, 
   imae078 LIKE imae_t.imae078, 
   imae079 LIKE imae_t.imae079, 
   imae080 LIKE imae_t.imae080, 
   imae086 LIKE imae_t.imae086, 
   imae071 LIKE imae_t.imae071, 
   imae072 LIKE imae_t.imae072, 
   imae073 LIKE imae_t.imae073, 
   imae074 LIKE imae_t.imae074, 
   imae075 LIKE imae_t.imae075, 
   imae081 LIKE imae_t.imae081, 
   imae081_desc LIKE type_t.chr80, 
   imae082 LIKE imae_t.imae082, 
   imae083 LIKE imae_t.imae083, 
   imae084 LIKE imae_t.imae084, 
   imae085 LIKE imae_t.imae085, 
   imae091 LIKE imae_t.imae091, 
   imae092 LIKE imae_t.imae092, 
   imae101 LIKE imae_t.imae101, 
   imae101_desc LIKE type_t.chr80, 
   imae102 LIKE imae_t.imae102, 
   imae102_desc LIKE type_t.chr80, 
   imae103 LIKE imae_t.imae103, 
   imae103_desc LIKE type_t.chr80, 
   imae104 LIKE imae_t.imae104, 
   imae104_desc LIKE type_t.chr80
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_imae001 LIKE imae_t.imae001,
   b_imae001_desc LIKE type_t.chr80,
   b_imaal004 LIKE imaal_t.imaal004,
   b_imaa009 LIKE imaa_t.imaa009,
   b_imaa009_desc LIKE type_t.chr80,
   b_imaa003 LIKE imaa_t.imaa003,
   b_imaa003_desc LIKE type_t.chr80,
      b_imae011 LIKE imae_t.imae011,
   b_imae011_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_t     LIKE ooef_t.ooef001
DEFINE g_ooef004             LIKE ooef_t.ooef004
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imae_m        type_g_imae_m  #單頭變數宣告
DEFINE g_imae_m_t      type_g_imae_m  #單頭舊值宣告(系統還原用)
DEFINE g_imae_m_o      type_g_imae_m  #單頭舊值宣告(其他用途)
DEFINE g_imae_m_mask_o type_g_imae_m  #轉換遮罩前資料
DEFINE g_imae_m_mask_n type_g_imae_m  #轉換遮罩後資料
 
   DEFINE g_imae001_t LIKE imae_t.imae001
 
   
 
   
 
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
 
{<section id="aimm205.main" >}
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
   LET g_site_t = g_site
   
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_imae_m.imae001 = g_argv[02]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imae001,'','','','','','','','','','','','','','','','','','','',imae011, 
       '',imae012,'',imaeownid,'',imaeowndp,'',imaecrtid,'',imaecrtdp,'',imaecrtdt,imaemodid,'',imaemoddt, 
       imae013,imae014,imae015,imae023,imae016,'',imae017,imae018,imae019,imae020,imae021,imae031,'', 
       imae037,imae032,'',imae033,'',imae034,'',imae035,'',imae022,imae036,imae041,'',imae042,'',imae051, 
       imae052,imae062,imae064,imae077,imae078,imae079,imae080,imae086,imae071,imae072,imae073,imae074, 
       imae075,imae081,'',imae082,imae083,imae084,imae085,imae091,imae092,imae101,'',imae102,'',imae103, 
       '',imae104,''", 
                      " FROM imae_t",
                      " WHERE imaeent= ? AND imaesite= ? AND imae001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimm205_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imae001,t0.imae011,t0.imae012,t0.imaeownid,t0.imaeowndp,t0.imaecrtid, 
       t0.imaecrtdp,t0.imaecrtdt,t0.imaemodid,t0.imaemoddt,t0.imae013,t0.imae014,t0.imae015,t0.imae023, 
       t0.imae016,t0.imae017,t0.imae018,t0.imae019,t0.imae020,t0.imae021,t0.imae031,t0.imae037,t0.imae032, 
       t0.imae033,t0.imae034,t0.imae035,t0.imae022,t0.imae036,t0.imae041,t0.imae042,t0.imae051,t0.imae052, 
       t0.imae062,t0.imae064,t0.imae077,t0.imae078,t0.imae079,t0.imae080,t0.imae086,t0.imae071,t0.imae072, 
       t0.imae073,t0.imae074,t0.imae075,t0.imae081,t0.imae082,t0.imae083,t0.imae084,t0.imae085,t0.imae091, 
       t0.imae092,t0.imae101,t0.imae102,t0.imae103,t0.imae104,t1.oocql004 ,t2.ooag011 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.oocal003 ,t9.imaal003 ,t10.ecba003 ,t11.ooefl003 ,t12.oocal003", 
 
               " FROM imae_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='204' AND t1.oocql002=t0.imae011 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.imae012  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.imaeownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.imaeowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.imaecrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.imaecrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.imaemodid  ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=t0.imae016 AND t8.oocal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t9 ON t9.imaalent="||g_enterprise||" AND t9.imaal001=t0.imae032 AND t9.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ecba_t t10 ON t10.ecbaent="||g_enterprise||" AND t10.ecba001=t0.imae032 AND t10.ecba002=t0.imae033  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.imae035 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t12 ON t12.oocalent="||g_enterprise||" AND t12.oocal001=t0.imae081 AND t12.oocal002='"||g_dlang||"' ",
 
               " WHERE t0.imaeent = " ||g_enterprise|| " AND t0.imaesite = ? AND t0.imae001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimm205_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimm205 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimm205_init()   
 
      #進入選單 Menu (="N")
      CALL aimm205_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimm205
      
   END IF 
   
   CLOSE aimm205_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimm205.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimm205_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
      CALL cl_set_combo_scc('imaa004','1001') 
   CALL cl_set_combo_scc('imaf012','2021') 
   CALL cl_set_combo_scc('imaf013','2022') 
   CALL cl_set_combo_scc('imaf014','2023') 
   CALL cl_set_combo_scc('imae013','4001') 
   CALL cl_set_combo_scc('imae014','4002') 
   CALL cl_set_combo_scc('imae023','1101') 
   CALL cl_set_combo_scc('imae019','2025') 
   CALL cl_set_combo_scc('imae021','4003') 
   CALL cl_set_combo_scc('imae084','2025') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('status1','50')
   CALL cl_set_combo_scc('imaf012','2021') 
   CALL cl_set_combo_scc('imaf013','2022') 
   CALL cl_set_combo_scc('imaf014','2023')
      
   #imae031,利用營運據點到aooi100中抓取單據別參照表號
   SELECT ooef004 INTO g_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_site
   #160727-00018#1 -----begin
   IF g_site = 'ALL' THEN
      CALL cl_set_comp_required("imae012",FALSE)
   ELSE
      CALL cl_set_comp_required("imae012",TRUE)
   END IF  
   #160727-00018#1 -----end       
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aimm205_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimm205_ui_dialog() 
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
         INITIALIZE g_imae_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aimm205_init()
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
               CALL aimm205_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimm205_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #160623-00014#1-mod-(S)
#               IF g_prog = 'aimm205' THEN      
#                  CALL cl_set_act_visible("logistics", FALSE)
#               ELSE
#                  CALL cl_set_act_visible("logistics", TRUE)
#               END IF
#               IF g_prog MATCHES 'aimm205' THEN    #170217-00068#2 mark     
               IF g_prog MATCHES 'aimm205*' THEN    #170217-00068#2 mod
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #160623-00014#1-mod-(E)
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL aimm205_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimm205_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aimm205_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aimm205_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aimm205_fetch("L")  
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
                  CALL aimm205_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimm205_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimm205_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimm205_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm202
            LET g_action_choice="open_aimm202"
            IF cl_auth_chk_act("open_aimm202") THEN
               
               #add-point:ON ACTION open_aimm202 name="menu2.open_aimm202"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm202 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm212 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm207
            LET g_action_choice="open_aimm207"
            IF cl_auth_chk_act("open_aimm207") THEN
               
               #add-point:ON ACTION open_aimm207 name="menu2.open_aimm207"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  CALL cl_cmdrun(" aimm207 '"||g_site||"' '"||g_imae_m.imae001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm200
            LET g_action_choice="open_aimm200"
            IF cl_auth_chk_act("open_aimm200") THEN
               
               #add-point:ON ACTION open_aimm200 name="menu2.open_aimm200"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  CALL cl_cmdrun("aimm200 '"||g_imae_m.imae001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm206
            LET g_action_choice="open_aimm206"
            IF cl_auth_chk_act("open_aimm206") THEN
               
               #add-point:ON ACTION open_aimm206 name="menu2.open_aimm206"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm206 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm216 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm204
            LET g_action_choice="open_aimm204"
            IF cl_auth_chk_act("open_aimm204") THEN
               
               #add-point:ON ACTION open_aimm204 name="menu2.open_aimm204"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm204 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm214 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm210
            LET g_action_choice="open_aimm210"
            IF cl_auth_chk_act("open_aimm210") THEN
               
               #add-point:ON ACTION open_aimm210 name="menu2.open_aimm210"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm210 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm220 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_ooeg
            LET g_action_choice="open_ooeg"
            IF cl_auth_chk_act("open_ooeg") THEN
               
               #add-point:ON ACTION open_ooeg name="menu2.open_ooeg"
               
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
               CALL aimm205_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm201
            LET g_action_choice="open_aimm201"
            IF cl_auth_chk_act("open_aimm201") THEN
               
               #add-point:ON ACTION open_aimm201 name="menu2.open_aimm201"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm201 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm211 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm203
            LET g_action_choice="open_aimm203"
            IF cl_auth_chk_act("open_aimm203") THEN
               
               #add-point:ON ACTION open_aimm203 name="menu2.open_aimm203"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm203 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm213 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm208
            LET g_action_choice="open_aimm208"
            IF cl_auth_chk_act("open_aimm208") THEN
               
               #add-point:ON ACTION open_aimm208 name="menu2.open_aimm208"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  CALL cl_cmdrun(" aimm208 '"||g_imae_m.imae001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pmaa
            LET g_action_choice="open_pmaa"
            IF cl_auth_chk_act("open_pmaa") THEN
               
               #add-point:ON ACTION open_pmaa name="menu2.open_pmaa"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa009
            LET g_action_choice="prog_imaa009"
            IF cl_auth_chk_act("prog_imaa009") THEN
               
               #add-point:ON ACTION prog_imaa009 name="menu2.prog_imaa009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imae_m.imaa009)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa003
            LET g_action_choice="prog_imaa003"
            IF cl_auth_chk_act("prog_imaa003") THEN
               
               #add-point:ON ACTION prog_imaa003 name="menu2.prog_imaa003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imae_m.imaa003)


               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimm205_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimm205_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimm205_set_pk_array()
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
                  CALL aimm205_fetch("")
 
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
                  CALL aimm205_browser_fill(g_wc,"")
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
                  CALL aimm205_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #160623-00014#1-mod-(S)
#               IF g_prog = 'aimm205' THEN      
#                  CALL cl_set_act_visible("logistics", FALSE)
#               ELSE
#                  CALL cl_set_act_visible("logistics", TRUE)
#               END IF   
#               IF g_prog MATCHES 'aimm205' THEN    #170217-00068#2 mark     
               IF g_prog MATCHES 'aimm205*' THEN    #170217-00068#2 mod               
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #160623-00014#1-mod-(E)
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
               CALL aimm205_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aimm205_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimm205_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aimm205_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aimm205_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aimm205_fetch("L")  
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
                  CALL aimm205_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimm205_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimm205_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimm205_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm202
            LET g_action_choice="open_aimm202"
            IF cl_auth_chk_act("open_aimm202") THEN
               
               #add-point:ON ACTION open_aimm202 name="menu.open_aimm202"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm202 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm212 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm207
            LET g_action_choice="open_aimm207"
            IF cl_auth_chk_act("open_aimm207") THEN
               
               #add-point:ON ACTION open_aimm207 name="menu.open_aimm207"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  CALL cl_cmdrun(" aimm207 '"||g_site||"' '"||g_imae_m.imae001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm200
            LET g_action_choice="open_aimm200"
            IF cl_auth_chk_act("open_aimm200") THEN
               
               #add-point:ON ACTION open_aimm200 name="menu.open_aimm200"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  CALL cl_cmdrun("aimm200 '"||g_imae_m.imae001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm206
            LET g_action_choice="open_aimm206"
            IF cl_auth_chk_act("open_aimm206") THEN
               
               #add-point:ON ACTION open_aimm206 name="menu.open_aimm206"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm206 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm216 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm204
            LET g_action_choice="open_aimm204"
            IF cl_auth_chk_act("open_aimm204") THEN
               
               #add-point:ON ACTION open_aimm204 name="menu.open_aimm204"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm204 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm214 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm210
            LET g_action_choice="open_aimm210"
            IF cl_auth_chk_act("open_aimm210") THEN
               
               #add-point:ON ACTION open_aimm210 name="menu.open_aimm210"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm210 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm220 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_ooeg
            LET g_action_choice="open_ooeg"
            IF cl_auth_chk_act("open_ooeg") THEN
               
               #add-point:ON ACTION open_ooeg name="menu.open_ooeg"
               
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
               CALL aimm205_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm201
            LET g_action_choice="open_aimm201"
            IF cl_auth_chk_act("open_aimm201") THEN
               
               #add-point:ON ACTION open_aimm201 name="menu.open_aimm201"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm201 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm211 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm203
            LET g_action_choice="open_aimm203"
            IF cl_auth_chk_act("open_aimm203") THEN
               
               #add-point:ON ACTION open_aimm203 name="menu.open_aimm203"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  IF g_site = 'ALL' THEN
                     CALL cl_cmdrun(" aimm203 '"||g_imae_m.imae001||"'")
                  ELSE                     
                     CALL cl_cmdrun(" aimm213 '"||g_site||"' '"||g_imae_m.imae001||"'")
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimm208
            LET g_action_choice="open_aimm208"
            IF cl_auth_chk_act("open_aimm208") THEN
               
               #add-point:ON ACTION open_aimm208 name="menu.open_aimm208"
               IF NOT cl_null(g_imae_m.imae001) THEN
                  CALL cl_cmdrun(" aimm208 '"||g_imae_m.imae001||"'")
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pmaa
            LET g_action_choice="open_pmaa"
            IF cl_auth_chk_act("open_pmaa") THEN
               
               #add-point:ON ACTION open_pmaa name="menu.open_pmaa"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa009
            LET g_action_choice="prog_imaa009"
            IF cl_auth_chk_act("prog_imaa009") THEN
               
               #add-point:ON ACTION prog_imaa009 name="menu.prog_imaa009"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi010", "rtax_t", "rtax001", "rtax001",g_imae_m.imaa009)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imaa003
            LET g_action_choice="prog_imaa003"
            IF cl_auth_chk_act("prog_imaa003") THEN
               
               #add-point:ON ACTION prog_imaa003 name="menu.prog_imaa003"
               #+ 此段落由子樣板a45產生
               CALL cl_user_contact("aimi100", "imca_t", "imca001", "imca001",g_imae_m.imaa003)


               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimm205_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimm205_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimm205_set_pk_array()
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
 
{<section id="aimm205.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aimm205_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "imae001"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM imae_t ",
               "  ",
               "  ",
               " WHERE imaeent = " ||g_enterprise|| " AND imaesite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("imae_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   LET g_sql = " SELECT COUNT(*) FROM imae_t ",
               " LEFT JOIN imaf_t ON imaeent = imafent AND imaesite = imafsite AND imae001 = imaf001 ",
               " LEFT JOIN imaal_t ON imaeent = imaalent AND imae001 = imaal001 AND imaal002 = '",g_lang,"' ",
               " , imaa_t ",
               " WHERE imaeent = imaaent AND imae001 = imaa001 ",
               "   AND imaeent = '" ||g_enterprise|| "' AND imaesite = '" ||g_site|| "' AND ", 
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
      INITIALIZE g_imae_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.imaestus,t0.imae001,t0.imae011,t1.imaal003 ,t2.oocql004",
               " FROM imae_t t0 ",
               "  ",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=t0.imae001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='204' AND t2.oocql002=t0.imae011 AND t2.oocql003='"||g_dlang||"' ",
 
               " WHERE t0.imaeent = " ||g_enterprise|| " AND t0.imaesite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imae_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   #2015/07/07 by stellar add ----- (S)
   #當存貨管制方法、補貨策略、需求計算方法下查詢條件(imaf_t)時，讓它一樣可以抓的到資料
   LET g_sql = " SELECT t0.imaestus,t0.imae001,t0.imae011,t1.imaal003 ,t2.oocql004",
               " FROM imae_t t0 ",
               "  ",
               " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.imae001 AND t1.imaal002='"||g_lang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='204' AND t2.oocql002=t0.imae011 AND t2.oocql003='"||g_lang||"' ",
               " LEFT JOIN imaf_t t3 ON t3.imafent='"||g_enterprise||"' AND t3.imafsite=t0.imaesite AND t3.imaf001=t0.imae001 ",
               " , imaa_t ",
               " WHERE t0.imaeent = imaaent AND t0.imae001= imaa001 ",
               "   AND t0.imaeent = '" ||g_enterprise|| "' AND t0.imaesite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imae_t")
   #2015/07/07 by stellar add ----- (E)
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
#    LET l_sql_rank = "SELECT imaestus,imae001,'','','','','','',imae011,'',RANK() OVER(ORDER BY imae001 ",
#
#                    g_order,
#                    ") AS RANK ",
#                    " FROM imae_t ",
#                    " LEFT JOIN imaf_t ON imaeent = imafent AND imaesite = imafsite AND imae001 = imaf001 ,",
#                    " imaa_t ",
#                    " LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_lang,"' ",
#                    " WHERE imaeent = imaaent AND imae001 = imaa001 ",
#                    "   AND imaeent = '" ||g_enterprise|| "' AND imaesite = '" ||g_site|| "' AND ", g_wc
#
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"imae_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imae001,g_browser[g_cnt].b_imae011, 
          g_browser[g_cnt].b_imae001_desc,g_browser[g_cnt].b_imae011_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
      CALL aimm205_b_imae001_ref(g_browser[g_cnt].b_imae001) RETURNING g_browser[g_cnt].b_imae001_desc,g_browser[g_cnt].b_imaal004,g_browser[g_cnt].b_imaa009,g_browser[g_cnt].b_imaa003
      DISPLAY BY NAME g_browser[g_cnt].b_imae001_desc,g_browser[g_cnt].b_imaal004,g_browser[g_cnt].b_imaa009,g_browser[g_cnt].b_imaa003
      
      CALL aimm205_b_imaa009_ref(g_browser[g_cnt].b_imaa009) RETURNING g_browser[g_cnt].b_imaa009_desc
      DISPLAY BY NAME g_browser[g_cnt].b_imaa009_desc
      
      CALL aimm205_b_imaa003_ref(g_browser[g_cnt].b_imaa003) RETURNING g_browser[g_cnt].b_imaa003_desc
      DISPLAY BY NAME g_browser[g_cnt].b_imaa003_desc
      
         #end add-point
         
         #遮罩相關處理
         CALL aimm205_browser_mask()
         
         
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
   
   IF cl_null(g_browser[g_cnt].b_imae001) THEN
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
 
{<section id="aimm205.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimm205_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_sql1         STRING       #160711-00040#14 add
   DEFINE l_success LIKE type_t.num5  #160711-00040#14 add
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_imae_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON imae001,imaa002,imaal003,imaal004,imaal005,imaa009,imaa003,imaa004,imaa005, 
          imaa006,imaa010,imaf012,imaf013,imaf014,imae011,imae012,imaeownid,imaeowndp,imaecrtid,imaecrtdp, 
          imaecrtdt,imaemodid,imaemoddt,imae013,imae014,imae015,imae023,imae016,imae017,imae018,imae019, 
          imae020,imae021,imae031,imae037,imae032,imae033,imae034,imae035,imae022,imae036,imae041,imae042, 
          imae051,imae052,imae062,imae064,imae077,imae078,imae079,imae080,imae086,imae071,imae072,imae073, 
          imae074,imae075,imae081,imae082,imae083,imae084,imae085,imae091,imae092,imae101,imae102,imae103, 
          imae104
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imaecrtdt>>----
         AFTER FIELD imaecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imaemoddt>>----
         AFTER FIELD imaemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imaecnfdt>>----
         
         #----<<imaepstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.imae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae001
            #add-point:ON ACTION controlp INFIELD imae001 name="construct.c.imae001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae001  #顯示到畫面上

            NEXT FIELD imae001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae001
            #add-point:BEFORE FIELD imae001 name="construct.b.imae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae001
            
            #add-point:AFTER FIELD imae001 name="construct.a.imae001"
            
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
            CALL q_imca001_1()                           #呼叫開窗
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
			LET g_qryparam.arg1 = "210"
            CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = ""
            DISPLAY g_qryparam.return1 TO imaa010  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oocq010 #參考欄位七 

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
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf012
            #add-point:BEFORE FIELD imaf012 name="construct.b.imaf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf012
            
            #add-point:AFTER FIELD imaf012 name="construct.a.imaf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf012
            #add-point:ON ACTION controlp INFIELD imaf012 name="construct.c.imaf012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf013
            #add-point:BEFORE FIELD imaf013 name="construct.b.imaf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf013
            
            #add-point:AFTER FIELD imaf013 name="construct.a.imaf013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf013
            #add-point:ON ACTION controlp INFIELD imaf013 name="construct.c.imaf013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf014
            #add-point:BEFORE FIELD imaf014 name="construct.b.imaf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf014
            
            #add-point:AFTER FIELD imaf014 name="construct.a.imaf014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf014
            #add-point:ON ACTION controlp INFIELD imaf014 name="construct.c.imaf014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imae011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae011
            #add-point:ON ACTION controlp INFIELD imae011 name="construct.c.imae011"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imcf011()  
            DISPLAY g_qryparam.return1 TO imae011  #顯示到畫面上

            NEXT FIELD imae011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae011
            #add-point:BEFORE FIELD imae011 name="construct.b.imae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae011
            
            #add-point:AFTER FIELD imae011 name="construct.a.imae011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae012
            #add-point:ON ACTION controlp INFIELD imae012 name="construct.c.imae012"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooagstus ='Y' "
            #160729-00020--s                                                                                    
            IF g_site='ALL' THEN
               CALL q_ooag001()  
            ELSE
               CALL q_ooag001_2()  
            END IF
            #CALL q_ooag001_2()                           #呼叫開窗
            #160729-00020---e                         #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO imae012  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD imae012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae012
            #add-point:BEFORE FIELD imae012 name="construct.b.imae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae012
            
            #add-point:AFTER FIELD imae012 name="construct.a.imae012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaeownid
            #add-point:ON ACTION controlp INFIELD imaeownid name="construct.c.imaeownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaeownid  #顯示到畫面上

            NEXT FIELD imaeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaeownid
            #add-point:BEFORE FIELD imaeownid name="construct.b.imaeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaeownid
            
            #add-point:AFTER FIELD imaeownid name="construct.a.imaeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaeowndp
            #add-point:ON ACTION controlp INFIELD imaeowndp name="construct.c.imaeowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaeowndp  #顯示到畫面上

            NEXT FIELD imaeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaeowndp
            #add-point:BEFORE FIELD imaeowndp name="construct.b.imaeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaeowndp
            
            #add-point:AFTER FIELD imaeowndp name="construct.a.imaeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaecrtid
            #add-point:ON ACTION controlp INFIELD imaecrtid name="construct.c.imaecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaecrtid  #顯示到畫面上

            NEXT FIELD imaecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaecrtid
            #add-point:BEFORE FIELD imaecrtid name="construct.b.imaecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaecrtid
            
            #add-point:AFTER FIELD imaecrtid name="construct.a.imaecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaecrtdp
            #add-point:ON ACTION controlp INFIELD imaecrtdp name="construct.c.imaecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaecrtdp  #顯示到畫面上

            NEXT FIELD imaecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaecrtdp
            #add-point:BEFORE FIELD imaecrtdp name="construct.b.imaecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaecrtdp
            
            #add-point:AFTER FIELD imaecrtdp name="construct.a.imaecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaecrtdt
            #add-point:BEFORE FIELD imaecrtdt name="construct.b.imaecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaemodid
            #add-point:ON ACTION controlp INFIELD imaemodid name="construct.c.imaemodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaemodid  #顯示到畫面上

            NEXT FIELD imaemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaemodid
            #add-point:BEFORE FIELD imaemodid name="construct.b.imaemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaemodid
            
            #add-point:AFTER FIELD imaemodid name="construct.a.imaemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaemoddt
            #add-point:BEFORE FIELD imaemoddt name="construct.b.imaemoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae013
            #add-point:BEFORE FIELD imae013 name="construct.b.imae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae013
            
            #add-point:AFTER FIELD imae013 name="construct.a.imae013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae013
            #add-point:ON ACTION controlp INFIELD imae013 name="construct.c.imae013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae014
            #add-point:BEFORE FIELD imae014 name="construct.b.imae014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae014
            
            #add-point:AFTER FIELD imae014 name="construct.a.imae014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae014
            #add-point:ON ACTION controlp INFIELD imae014 name="construct.c.imae014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae015
            #add-point:BEFORE FIELD imae015 name="construct.b.imae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae015
            
            #add-point:AFTER FIELD imae015 name="construct.a.imae015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae015
            #add-point:ON ACTION controlp INFIELD imae015 name="construct.c.imae015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae023
            #add-point:BEFORE FIELD imae023 name="construct.b.imae023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae023
            
            #add-point:AFTER FIELD imae023 name="construct.a.imae023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae023
            #add-point:ON ACTION controlp INFIELD imae023 name="construct.c.imae023"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imae016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae016
            #add-point:ON ACTION controlp INFIELD imae016 name="construct.c.imae016"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus ='Y' "
            CALL q_ooca001_1()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO imae016  #顯示到畫面上

            NEXT FIELD imae016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae016
            #add-point:BEFORE FIELD imae016 name="construct.b.imae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae016
            
            #add-point:AFTER FIELD imae016 name="construct.a.imae016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae017
            #add-point:BEFORE FIELD imae017 name="construct.b.imae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae017
            
            #add-point:AFTER FIELD imae017 name="construct.a.imae017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae017
            #add-point:ON ACTION controlp INFIELD imae017 name="construct.c.imae017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae018
            #add-point:BEFORE FIELD imae018 name="construct.b.imae018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae018
            
            #add-point:AFTER FIELD imae018 name="construct.a.imae018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae018
            #add-point:ON ACTION controlp INFIELD imae018 name="construct.c.imae018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae019
            #add-point:BEFORE FIELD imae019 name="construct.b.imae019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae019
            
            #add-point:AFTER FIELD imae019 name="construct.a.imae019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae019
            #add-point:ON ACTION controlp INFIELD imae019 name="construct.c.imae019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae020
            #add-point:BEFORE FIELD imae020 name="construct.b.imae020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae020
            
            #add-point:AFTER FIELD imae020 name="construct.a.imae020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae020
            #add-point:ON ACTION controlp INFIELD imae020 name="construct.c.imae020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae021
            #add-point:BEFORE FIELD imae021 name="construct.b.imae021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae021
            
            #add-point:AFTER FIELD imae021 name="construct.a.imae021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae021
            #add-point:ON ACTION controlp INFIELD imae021 name="construct.c.imae021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imae031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae031
            #add-point:ON ACTION controlp INFIELD imae031 name="construct.c.imae031"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oobastus = 'Y' "
            #160711-00040#14 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#14 add(e)
            CALL q_ooba002_1()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO imae031  #顯示到畫面上

            NEXT FIELD imae031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae031
            #add-point:BEFORE FIELD imae031 name="construct.b.imae031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae031
            
            #add-point:AFTER FIELD imae031 name="construct.a.imae031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae037
            #add-point:ON ACTION controlp INFIELD imae037 name="construct.c.imae037"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_bmaa002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae037  #顯示到畫面上

            NEXT FIELD imae037                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae037
            #add-point:BEFORE FIELD imae037 name="construct.b.imae037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae037
            
            #add-point:AFTER FIELD imae037 name="construct.a.imae037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae032
            #add-point:ON ACTION controlp INFIELD imae032 name="construct.c.imae032"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            
           # CALL q_ecba001()                           #呼叫開窗
            CALL q_imaf001_15()
            
            DISPLAY g_qryparam.return1 TO imae032  #顯示到畫面上

            NEXT FIELD imae032                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae032
            #add-point:BEFORE FIELD imae032 name="construct.b.imae032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae032
            
            #add-point:AFTER FIELD imae032 name="construct.a.imae032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae033
            #add-point:ON ACTION controlp INFIELD imae033 name="construct.c.imae033"
            LET g_qryparam.reqry = FALSE
            
            CALL q_ecba002_1()                           #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO imae033  #顯示到畫面上

            NEXT FIELD imae033                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae033
            #add-point:BEFORE FIELD imae033 name="construct.b.imae033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae033
            
            #add-point:AFTER FIELD imae033 name="construct.a.imae033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae034
            #add-point:ON ACTION controlp INFIELD imae034 name="construct.c.imae034"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_1()                           #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO imae034  #顯示到畫面上

            NEXT FIELD imae034                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae034
            #add-point:BEFORE FIELD imae034 name="construct.b.imae034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae034
            
            #add-point:AFTER FIELD imae034 name="construct.a.imae034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae035
            #add-point:ON ACTION controlp INFIELD imae035 name="construct.c.imae035"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO imae035  #顯示到畫面上

            NEXT FIELD imae035                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae035
            #add-point:BEFORE FIELD imae035 name="construct.b.imae035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae035
            
            #add-point:AFTER FIELD imae035 name="construct.a.imae035"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae022
            #add-point:BEFORE FIELD imae022 name="construct.b.imae022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae022
            
            #add-point:AFTER FIELD imae022 name="construct.a.imae022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae022
            #add-point:ON ACTION controlp INFIELD imae022 name="construct.c.imae022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae036
            #add-point:BEFORE FIELD imae036 name="construct.b.imae036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae036
            
            #add-point:AFTER FIELD imae036 name="construct.a.imae036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae036
            #add-point:ON ACTION controlp INFIELD imae036 name="construct.c.imae036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imae041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae041
            #add-point:ON ACTION controlp INFIELD imae041 name="construct.c.imae041"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inaa001_4()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            DISPLAY g_qryparam.return1 TO imae041  #顯示到畫面上

            NEXT FIELD imae041                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae041
            #add-point:BEFORE FIELD imae041 name="construct.b.imae041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae041
            
            #add-point:AFTER FIELD imae041 name="construct.a.imae041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae042
            #add-point:ON ACTION controlp INFIELD imae042 name="construct.c.imae042"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inab002_8()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            DISPLAY g_qryparam.return1 TO imae042  #顯示到畫面上

            NEXT FIELD imae042                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae042
            #add-point:BEFORE FIELD imae042 name="construct.b.imae042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae042
            
            #add-point:AFTER FIELD imae042 name="construct.a.imae042"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae051
            #add-point:BEFORE FIELD imae051 name="construct.b.imae051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae051
            
            #add-point:AFTER FIELD imae051 name="construct.a.imae051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae051
            #add-point:ON ACTION controlp INFIELD imae051 name="construct.c.imae051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae052
            #add-point:BEFORE FIELD imae052 name="construct.b.imae052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae052
            
            #add-point:AFTER FIELD imae052 name="construct.a.imae052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae052
            #add-point:ON ACTION controlp INFIELD imae052 name="construct.c.imae052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae062
            #add-point:BEFORE FIELD imae062 name="construct.b.imae062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae062
            
            #add-point:AFTER FIELD imae062 name="construct.a.imae062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae062
            #add-point:ON ACTION controlp INFIELD imae062 name="construct.c.imae062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae064
            #add-point:BEFORE FIELD imae064 name="construct.b.imae064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae064
            
            #add-point:AFTER FIELD imae064 name="construct.a.imae064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae064
            #add-point:ON ACTION controlp INFIELD imae064 name="construct.c.imae064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae077
            #add-point:BEFORE FIELD imae077 name="construct.b.imae077"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae077
            
            #add-point:AFTER FIELD imae077 name="construct.a.imae077"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae077
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae077
            #add-point:ON ACTION controlp INFIELD imae077 name="construct.c.imae077"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae078
            #add-point:BEFORE FIELD imae078 name="construct.b.imae078"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae078
            
            #add-point:AFTER FIELD imae078 name="construct.a.imae078"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae078
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae078
            #add-point:ON ACTION controlp INFIELD imae078 name="construct.c.imae078"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae079
            #add-point:BEFORE FIELD imae079 name="construct.b.imae079"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae079
            
            #add-point:AFTER FIELD imae079 name="construct.a.imae079"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae079
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae079
            #add-point:ON ACTION controlp INFIELD imae079 name="construct.c.imae079"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae080
            #add-point:BEFORE FIELD imae080 name="construct.b.imae080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae080
            
            #add-point:AFTER FIELD imae080 name="construct.a.imae080"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae080
            #add-point:ON ACTION controlp INFIELD imae080 name="construct.c.imae080"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae086
            #add-point:BEFORE FIELD imae086 name="construct.b.imae086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae086
            
            #add-point:AFTER FIELD imae086 name="construct.a.imae086"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae086
            #add-point:ON ACTION controlp INFIELD imae086 name="construct.c.imae086"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae071
            #add-point:BEFORE FIELD imae071 name="construct.b.imae071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae071
            
            #add-point:AFTER FIELD imae071 name="construct.a.imae071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae071
            #add-point:ON ACTION controlp INFIELD imae071 name="construct.c.imae071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae072
            #add-point:BEFORE FIELD imae072 name="construct.b.imae072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae072
            
            #add-point:AFTER FIELD imae072 name="construct.a.imae072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae072
            #add-point:ON ACTION controlp INFIELD imae072 name="construct.c.imae072"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae073
            #add-point:BEFORE FIELD imae073 name="construct.b.imae073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae073
            
            #add-point:AFTER FIELD imae073 name="construct.a.imae073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae073
            #add-point:ON ACTION controlp INFIELD imae073 name="construct.c.imae073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae074
            #add-point:BEFORE FIELD imae074 name="construct.b.imae074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae074
            
            #add-point:AFTER FIELD imae074 name="construct.a.imae074"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae074
            #add-point:ON ACTION controlp INFIELD imae074 name="construct.c.imae074"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae075
            #add-point:BEFORE FIELD imae075 name="construct.b.imae075"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae075
            
            #add-point:AFTER FIELD imae075 name="construct.a.imae075"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae075
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae075
            #add-point:ON ACTION controlp INFIELD imae075 name="construct.c.imae075"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imae081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae081
            #add-point:ON ACTION controlp INFIELD imae081 name="construct.c.imae081"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oocastus ='Y' "
            CALL q_ooca001_1()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO imae081  #顯示到畫面上

            NEXT FIELD imae081                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae081
            #add-point:BEFORE FIELD imae081 name="construct.b.imae081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae081
            
            #add-point:AFTER FIELD imae081 name="construct.a.imae081"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae082
            #add-point:BEFORE FIELD imae082 name="construct.b.imae082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae082
            
            #add-point:AFTER FIELD imae082 name="construct.a.imae082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae082
            #add-point:ON ACTION controlp INFIELD imae082 name="construct.c.imae082"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae083
            #add-point:BEFORE FIELD imae083 name="construct.b.imae083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae083
            
            #add-point:AFTER FIELD imae083 name="construct.a.imae083"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae083
            #add-point:ON ACTION controlp INFIELD imae083 name="construct.c.imae083"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae084
            #add-point:BEFORE FIELD imae084 name="construct.b.imae084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae084
            
            #add-point:AFTER FIELD imae084 name="construct.a.imae084"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae084
            #add-point:ON ACTION controlp INFIELD imae084 name="construct.c.imae084"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae085
            #add-point:BEFORE FIELD imae085 name="construct.b.imae085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae085
            
            #add-point:AFTER FIELD imae085 name="construct.a.imae085"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae085
            #add-point:ON ACTION controlp INFIELD imae085 name="construct.c.imae085"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae091
            #add-point:BEFORE FIELD imae091 name="construct.b.imae091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae091
            
            #add-point:AFTER FIELD imae091 name="construct.a.imae091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae091
            #add-point:ON ACTION controlp INFIELD imae091 name="construct.c.imae091"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae092
            #add-point:BEFORE FIELD imae092 name="construct.b.imae092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae092
            
            #add-point:AFTER FIELD imae092 name="construct.a.imae092"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae092
            #add-point:ON ACTION controlp INFIELD imae092 name="construct.c.imae092"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imae101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae101
            #add-point:ON ACTION controlp INFIELD imae101 name="construct.c.imae101"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inaa001_4()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            DISPLAY g_qryparam.return1 TO imae101  #顯示到畫面上

            NEXT FIELD imae101                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae101
            #add-point:BEFORE FIELD imae101 name="construct.b.imae101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae101
            
            #add-point:AFTER FIELD imae101 name="construct.a.imae101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae102
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae102
            #add-point:ON ACTION controlp INFIELD imae102 name="construct.c.imae102"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inab002_8()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            DISPLAY g_qryparam.return1 TO imae102  #顯示到畫面上

            NEXT FIELD imae102                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae102
            #add-point:BEFORE FIELD imae102 name="construct.b.imae102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae102
            
            #add-point:AFTER FIELD imae102 name="construct.a.imae102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae103
            #add-point:ON ACTION controlp INFIELD imae103 name="construct.c.imae103"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inaa001_4()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            DISPLAY g_qryparam.return1 TO imae103  #顯示到畫面上

            NEXT FIELD imae103                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae103
            #add-point:BEFORE FIELD imae103 name="construct.b.imae103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae103
            
            #add-point:AFTER FIELD imae103 name="construct.a.imae103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae104
            #add-point:ON ACTION controlp INFIELD imae104 name="construct.c.imae104"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inab002_8()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            DISPLAY g_qryparam.return1 TO imae104  #顯示到畫面上

            NEXT FIELD imae104                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae104
            #add-point:BEFORE FIELD imae104 name="construct.b.imae104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae104
            
            #add-point:AFTER FIELD imae104 name="construct.a.imae104"
            
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
 
{<section id="aimm205.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimm205_filter()
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
      CONSTRUCT g_wc_filter ON imae001,imae011
                          FROM s_browse[1].b_imae001,s_browse[1].b_imae011
 
         BEFORE CONSTRUCT
               DISPLAY aimm205_filter_parser('imae001') TO s_browse[1].b_imae001
            DISPLAY aimm205_filter_parser('imae011') TO s_browse[1].b_imae011
      
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
 
      CALL aimm205_filter_show('imae001')
   CALL aimm205_filter_show('imae011')
 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimm205_filter_parser(ps_field)
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
 
{<section id="aimm205.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimm205_filter_show(ps_field)
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
   LET ls_condition = aimm205_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimm205_query()
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
 
   INITIALIZE g_imae_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aimm205_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimm205_browser_fill(g_wc,"F")
      CALL aimm205_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aimm205_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aimm205_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aimm205.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimm205_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_imaastus   LIKE imaa_t.imaastus
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
   LET g_imae_m.imae001 = g_browser[g_current_idx].b_imae001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aimm205_master_referesh USING g_site,g_imae_m.imae001 INTO g_imae_m.imae001,g_imae_m.imae011, 
       g_imae_m.imae012,g_imae_m.imaeownid,g_imae_m.imaeowndp,g_imae_m.imaecrtid,g_imae_m.imaecrtdp, 
       g_imae_m.imaecrtdt,g_imae_m.imaemodid,g_imae_m.imaemoddt,g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015, 
       g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020, 
       g_imae_m.imae021,g_imae_m.imae031,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae033,g_imae_m.imae034, 
       g_imae_m.imae035,g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae042,g_imae_m.imae051, 
       g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078,g_imae_m.imae079, 
       g_imae_m.imae080,g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073,g_imae_m.imae074, 
       g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae082,g_imae_m.imae083,g_imae_m.imae084,g_imae_m.imae085, 
       g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae102,g_imae_m.imae103,g_imae_m.imae104, 
       g_imae_m.imae011_desc,g_imae_m.imae012_desc,g_imae_m.imaeownid_desc,g_imae_m.imaeowndp_desc,g_imae_m.imaecrtid_desc, 
       g_imae_m.imaecrtdp_desc,g_imae_m.imaemodid_desc,g_imae_m.imae016_desc,g_imae_m.imae032_desc,g_imae_m.imae033_desc, 
       g_imae_m.imae035_desc,g_imae_m.imae081_desc
   
   #遮罩相關處理
   LET g_imae_m_mask_o.* =  g_imae_m.*
   CALL aimm205_imae_t_mask()
   LET g_imae_m_mask_n.* =  g_imae_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimm205_set_act_visible()
   CALL aimm205_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,query",TRUE)
   LET l_imaastus = NULL
   SELECT imaastus INTO l_imaastus FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_imae_m.imae001
   IF l_imaastus = 'X' THEN
      CALL cl_set_act_visible("modify",FALSE)
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      CALL cl_set_act_visible("query",FALSE)
   END IF
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_imae_m_t.* = g_imae_m.*
   LET g_imae_m_o.* = g_imae_m.*
   
   LET g_data_owner = g_imae_m.imaeownid      
   LET g_data_dept  = g_imae_m.imaeowndp
   
   #重新顯示
   CALL aimm205_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimm205_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_imae_m.* TO NULL             #DEFAULT 設定
   LET g_imae001_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imae_m.imaeownid = g_user
      LET g_imae_m.imaeowndp = g_dept
      LET g_imae_m.imaecrtid = g_user
      LET g_imae_m.imaecrtdp = g_dept 
      LET g_imae_m.imaecrtdt = cl_get_current()
      LET g_imae_m.imaemodid = g_user
      LET g_imae_m.imaemoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imae_m.imae013 = "0"
      LET g_imae_m.imae014 = "0"
      LET g_imae_m.imae015 = "0"
      LET g_imae_m.imae023 = "1"
      LET g_imae_m.imae017 = "0"
      LET g_imae_m.imae018 = "0"
      LET g_imae_m.imae019 = "1"
      LET g_imae_m.imae020 = "0"
      LET g_imae_m.imae021 = "1"
      LET g_imae_m.imae022 = "0"
      LET g_imae_m.imae036 = "Y"
      LET g_imae_m.imae051 = "0"
      LET g_imae_m.imae052 = "0"
      LET g_imae_m.imae064 = "0"
      LET g_imae_m.imae077 = "0"
      LET g_imae_m.imae078 = "0"
      LET g_imae_m.imae079 = "0"
      LET g_imae_m.imae080 = "N"
      LET g_imae_m.imae086 = "Y"
      LET g_imae_m.imae071 = "0"
      LET g_imae_m.imae072 = "0"
      LET g_imae_m.imae073 = "0"
      LET g_imae_m.imae074 = "0"
      LET g_imae_m.imae075 = "0"
      LET g_imae_m.imae082 = "0"
      LET g_imae_m.imae083 = "0"
      LET g_imae_m.imae084 = "1"
      LET g_imae_m.imae091 = "N"
      LET g_imae_m.imae092 = "N"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL aimm205_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_imae_m.* TO NULL
         CALL aimm205_show()
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
   CALL aimm205_set_act_visible()
   CALL aimm205_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imae001_t = g_imae_m.imae001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imaeent = " ||g_enterprise|| " AND imaesite = '" ||g_site|| "' AND",
                      " imae001 = '", g_imae_m.imae001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimm205_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimm205_master_referesh USING g_site,g_imae_m.imae001 INTO g_imae_m.imae001,g_imae_m.imae011, 
       g_imae_m.imae012,g_imae_m.imaeownid,g_imae_m.imaeowndp,g_imae_m.imaecrtid,g_imae_m.imaecrtdp, 
       g_imae_m.imaecrtdt,g_imae_m.imaemodid,g_imae_m.imaemoddt,g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015, 
       g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020, 
       g_imae_m.imae021,g_imae_m.imae031,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae033,g_imae_m.imae034, 
       g_imae_m.imae035,g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae042,g_imae_m.imae051, 
       g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078,g_imae_m.imae079, 
       g_imae_m.imae080,g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073,g_imae_m.imae074, 
       g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae082,g_imae_m.imae083,g_imae_m.imae084,g_imae_m.imae085, 
       g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae102,g_imae_m.imae103,g_imae_m.imae104, 
       g_imae_m.imae011_desc,g_imae_m.imae012_desc,g_imae_m.imaeownid_desc,g_imae_m.imaeowndp_desc,g_imae_m.imaecrtid_desc, 
       g_imae_m.imaecrtdp_desc,g_imae_m.imaemodid_desc,g_imae_m.imae016_desc,g_imae_m.imae032_desc,g_imae_m.imae033_desc, 
       g_imae_m.imae035_desc,g_imae_m.imae081_desc
   
   
   #遮罩相關處理
   LET g_imae_m_mask_o.* =  g_imae_m.*
   CALL aimm205_imae_t_mask()
   LET g_imae_m_mask_n.* =  g_imae_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imae_m.imae001,g_imae_m.imaa002,g_imae_m.imaal003,g_imae_m.imaal004,g_imae_m.imaal005, 
       g_imae_m.imaa009,g_imae_m.imaa009_desc,g_imae_m.imaa003,g_imae_m.imaa003_desc,g_imae_m.imaa004, 
       g_imae_m.imaa005,g_imae_m.imaa005_desc,g_imae_m.imaa006,g_imae_m.imaa006_desc,g_imae_m.imaa010, 
       g_imae_m.imaa010_desc,g_imae_m.status1,g_imae_m.imaf012,g_imae_m.imaf013,g_imae_m.imaf014,g_imae_m.imae011, 
       g_imae_m.imae011_desc,g_imae_m.imae012,g_imae_m.imae012_desc,g_imae_m.imaeownid,g_imae_m.imaeownid_desc, 
       g_imae_m.imaeowndp,g_imae_m.imaeowndp_desc,g_imae_m.imaecrtid,g_imae_m.imaecrtid_desc,g_imae_m.imaecrtdp, 
       g_imae_m.imaecrtdp_desc,g_imae_m.imaecrtdt,g_imae_m.imaemodid,g_imae_m.imaemodid_desc,g_imae_m.imaemoddt, 
       g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015,g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae016_desc, 
       g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020,g_imae_m.imae021,g_imae_m.imae031, 
       g_imae_m.imae031_desc,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae032_desc,g_imae_m.imae033, 
       g_imae_m.imae033_desc,g_imae_m.imae034,g_imae_m.imae034_desc,g_imae_m.imae035,g_imae_m.imae035_desc, 
       g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae041_desc,g_imae_m.imae042,g_imae_m.imae042_desc, 
       g_imae_m.imae051,g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078, 
       g_imae_m.imae079,g_imae_m.imae080,g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073, 
       g_imae_m.imae074,g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae081_desc,g_imae_m.imae082,g_imae_m.imae083, 
       g_imae_m.imae084,g_imae_m.imae085,g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae101_desc, 
       g_imae_m.imae102,g_imae_m.imae102_desc,g_imae_m.imae103,g_imae_m.imae103_desc,g_imae_m.imae104, 
       g_imae_m.imae104_desc
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_imae_m.imaeownid      
   LET g_data_dept  = g_imae_m.imaeowndp
 
   #功能已完成,通報訊息中心
   CALL aimm205_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimm205.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimm205_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
 
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imae_m.imae001 IS NULL
 
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
   LET g_imae001_t = g_imae_m.imae001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aimm205_cl USING g_enterprise, g_site,g_imae_m.imae001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimm205_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimm205_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimm205_master_referesh USING g_site,g_imae_m.imae001 INTO g_imae_m.imae001,g_imae_m.imae011, 
       g_imae_m.imae012,g_imae_m.imaeownid,g_imae_m.imaeowndp,g_imae_m.imaecrtid,g_imae_m.imaecrtdp, 
       g_imae_m.imaecrtdt,g_imae_m.imaemodid,g_imae_m.imaemoddt,g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015, 
       g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020, 
       g_imae_m.imae021,g_imae_m.imae031,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae033,g_imae_m.imae034, 
       g_imae_m.imae035,g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae042,g_imae_m.imae051, 
       g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078,g_imae_m.imae079, 
       g_imae_m.imae080,g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073,g_imae_m.imae074, 
       g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae082,g_imae_m.imae083,g_imae_m.imae084,g_imae_m.imae085, 
       g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae102,g_imae_m.imae103,g_imae_m.imae104, 
       g_imae_m.imae011_desc,g_imae_m.imae012_desc,g_imae_m.imaeownid_desc,g_imae_m.imaeowndp_desc,g_imae_m.imaecrtid_desc, 
       g_imae_m.imaecrtdp_desc,g_imae_m.imaemodid_desc,g_imae_m.imae016_desc,g_imae_m.imae032_desc,g_imae_m.imae033_desc, 
       g_imae_m.imae035_desc,g_imae_m.imae081_desc
 
   #檢查是否允許此動作
   IF NOT aimm205_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_imae_m_mask_o.* =  g_imae_m.*
   CALL aimm205_imae_t_mask()
   LET g_imae_m_mask_n.* =  g_imae_m.*
   
   
 
   #顯示資料
   CALL aimm205_show()
   
   WHILE TRUE
      LET g_imae_m.imae001 = g_imae001_t
 
      
      #寫入修改者/修改日期資訊
      LET g_imae_m.imaemodid = g_user 
LET g_imae_m.imaemoddt = cl_get_current()
LET g_imae_m.imaemodid_desc = cl_get_username(g_imae_m.imaemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
 
      #end add-point
 
      #資料輸入
      CALL aimm205_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_imae_m.* = g_imae_m_t.*
         CALL aimm205_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE imae_t SET (imaemodid,imaemoddt) = (g_imae_m.imaemodid,g_imae_m.imaemoddt)
       WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_imae001_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimm205_set_act_visible()
   CALL aimm205_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imaeent = " ||g_enterprise|| " AND imaesite = '" ||g_site|| "' AND",
                      " imae001 = '", g_imae_m.imae001, "' "
 
   #填到對應位置
   CALL aimm205_browser_fill(g_wc,"")
 
   CLOSE aimm205_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimm205_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aimm205.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimm205_input(p_cmd)
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
   DEFINE l_imai065       LIKE imai_t.imai065
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_errno         STRING
   DEFINE l_rate          LIKE inaj_t.inaj014
   DEFINE l_sql1         STRING       #160711-00040#14 add
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
   DISPLAY BY NAME g_imae_m.imae001,g_imae_m.imaa002,g_imae_m.imaal003,g_imae_m.imaal004,g_imae_m.imaal005, 
       g_imae_m.imaa009,g_imae_m.imaa009_desc,g_imae_m.imaa003,g_imae_m.imaa003_desc,g_imae_m.imaa004, 
       g_imae_m.imaa005,g_imae_m.imaa005_desc,g_imae_m.imaa006,g_imae_m.imaa006_desc,g_imae_m.imaa010, 
       g_imae_m.imaa010_desc,g_imae_m.status1,g_imae_m.imaf012,g_imae_m.imaf013,g_imae_m.imaf014,g_imae_m.imae011, 
       g_imae_m.imae011_desc,g_imae_m.imae012,g_imae_m.imae012_desc,g_imae_m.imaeownid,g_imae_m.imaeownid_desc, 
       g_imae_m.imaeowndp,g_imae_m.imaeowndp_desc,g_imae_m.imaecrtid,g_imae_m.imaecrtid_desc,g_imae_m.imaecrtdp, 
       g_imae_m.imaecrtdp_desc,g_imae_m.imaecrtdt,g_imae_m.imaemodid,g_imae_m.imaemodid_desc,g_imae_m.imaemoddt, 
       g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015,g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae016_desc, 
       g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020,g_imae_m.imae021,g_imae_m.imae031, 
       g_imae_m.imae031_desc,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae032_desc,g_imae_m.imae033, 
       g_imae_m.imae033_desc,g_imae_m.imae034,g_imae_m.imae034_desc,g_imae_m.imae035,g_imae_m.imae035_desc, 
       g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae041_desc,g_imae_m.imae042,g_imae_m.imae042_desc, 
       g_imae_m.imae051,g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078, 
       g_imae_m.imae079,g_imae_m.imae080,g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073, 
       g_imae_m.imae074,g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae081_desc,g_imae_m.imae082,g_imae_m.imae083, 
       g_imae_m.imae084,g_imae_m.imae085,g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae101_desc, 
       g_imae_m.imae102,g_imae_m.imae102_desc,g_imae_m.imae103,g_imae_m.imae103_desc,g_imae_m.imae104, 
       g_imae_m.imae104_desc
   
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
   CALL aimm205_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimm205_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_imae_m.imae001,g_imae_m.imae011,g_imae_m.imae012,g_imae_m.imae013,g_imae_m.imae014, 
          g_imae_m.imae015,g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019, 
          g_imae_m.imae020,g_imae_m.imae021,g_imae_m.imae031,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae033, 
          g_imae_m.imae034,g_imae_m.imae035,g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae042, 
          g_imae_m.imae051,g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078, 
          g_imae_m.imae079,g_imae_m.imae080,g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073, 
          g_imae_m.imae074,g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae082,g_imae_m.imae083,g_imae_m.imae084, 
          g_imae_m.imae085,g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae102,g_imae_m.imae103, 
          g_imae_m.imae104 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            #150518 by whitney add start
            LET g_imae_m_t.* = g_imae_m.*
            LET g_imae_m_o.* = g_imae_m.*
            #150518 by whitney add end

            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae001
            #add-point:BEFORE FIELD imae001 name="input.b.imae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae001
            
            #add-point:AFTER FIELD imae001 name="input.a.imae001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_imae_m.imae001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imae_m.imae001 != g_imae001_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imae_t WHERE "||"imaeent = '" ||g_enterprise|| "' AND imaesite = '" ||g_site|| "' AND "||"imae001 = '"||g_imae_m.imae001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae001
            #add-point:ON CHANGE imae001 name="input.g.imae001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae011
            
            #add-point:AFTER FIELD imae011 name="input.a.imae011"
            #150518 by whitney modify start
            DISPLAY "" TO imae011_desc
            IF NOT cl_null(g_imae_m.imae011) THEN
               IF g_imae_m.imae011 != g_imae_m_o.imae011 OR cl_null(g_imae_m_o.imae011) THEN
                  IF g_site = 'ALL' THEN
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     #設定g_chkparam.*的參數
                     #LET g_chkparam.arg1 = g_site
                     LET g_chkparam.arg1 = g_imae_m.imae011
                     #160318-00025#2--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "aim-00051:sub-01302|aimi105|",cl_get_progname("aimi105",g_lang,"2"),"|:EXEPROGaimi105"
                     #160318-00025#2--add--end
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_imcf011") THEN
                        LET g_imae_m.imae011 = g_imae_m_o.imae011
                        CALL aimm205_imae011_ref(g_imae_m.imae011) RETURNING g_imae_m.imae011_desc
                        DISPLAY BY NAME g_imae_m.imae011_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #161124-00023#1--s
                     #IF NOT s_azzi650_chk_exist('204',g_imae_m.imae011) THEN
                     INITIALIZE g_chkparam.* TO NULL
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_imae_m.imae011
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_imcf011_1") THEN
                     #161124-00023#1---e
                        LET g_imae_m.imae011 = g_imae_m_o.imae011
                        CALL aimm205_imae011_ref(g_imae_m.imae011) RETURNING g_imae_m.imae011_desc
                        DISPLAY BY NAME g_imae_m.imae011_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM imcf_t
                   WHERE imcf011 = g_imae_m.imae011
                     AND imcfent = g_enterprise
                     AND imcfsite = g_site
                     AND imcfstus = 'Y'
                  IF l_cnt > 0 THEN
                     IF cl_ask_confirm('aim-00120') THEN
                        CALL aimm205_get_imcf()
                     END IF
                  END IF
                  #製程料號帶自己本身的料號
                  IF cl_null(g_imae_m.imae032) THEN
                     LET g_imae_m.imae032 = g_imae_m.imae001
                     CALL aimm205_imae032_ref(g_imae_m.imae032) RETURNING g_imae_m.imae032_desc
                     DISPLAY BY NAME g_imae_m.imae032_desc
                  END IF
                  #關鍵物料帶預設值
                  IF cl_null(g_imae_m.imae080) THEN
                     LET g_imae_m.imae080 = 'N'
                     DISPLAY BY NAME g_imae_m.imae080
                  END IF
               END IF
            END IF
            CALL aimm205_imae011_ref(g_imae_m.imae011) RETURNING g_imae_m.imae011_desc
            DISPLAY BY NAME g_imae_m.imae011_desc
            LET g_imae_m_o.imae011 = g_imae_m.imae011
            #150518 by whitney modify end

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae011
            #add-point:BEFORE FIELD imae011 name="input.b.imae011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae011
            #add-point:ON CHANGE imae011 name="input.g.imae011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae012
            
            #add-point:AFTER FIELD imae012 name="input.a.imae012"
            CALL aimm205_imae012_ref(g_imae_m.imae012) RETURNING g_imae_m.imae012_desc
            DISPLAY BY NAME g_imae_m.imae012_desc
            IF NOT cl_null(g_imae_m.imae012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae012 != g_imae_m_t.imae012 OR cl_null(g_imae_m_t.imae012))) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imae_m.imae012
                  LET g_chkparam.arg2 = g_site_t       #161124-00023#1 add
                  #160318-00025#2--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#2--add--end
                  #呼叫檢查存在並帶值的library
                  #IF NOT cl_chk_exist("v_ooag001") THEN   #161124-00023#1 mark
                  IF NOT cl_chk_exist("v_ooag001_6") THEN  #161124-00023#1 add
                     LET g_imae_m.imae012 = g_imae_m_t.imae012
                     CALL aimm205_imae012_ref(g_imae_m.imae012) RETURNING g_imae_m.imae012_desc
                     DISPLAY BY NAME g_imae_m.imae012_desc
                     NEXT FIELD CURRENT
                  END IF 
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae012
            #add-point:BEFORE FIELD imae012 name="input.b.imae012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae012
            #add-point:ON CHANGE imae012 name="input.g.imae012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae013
            #add-point:BEFORE FIELD imae013 name="input.b.imae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae013
            
            #add-point:AFTER FIELD imae013 name="input.a.imae013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae013
            #add-point:ON CHANGE imae013 name="input.g.imae013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae014
            #add-point:BEFORE FIELD imae014 name="input.b.imae014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae014
            
            #add-point:AFTER FIELD imae014 name="input.a.imae014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae014
            #add-point:ON CHANGE imae014 name="input.g.imae014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae015,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imae015
            END IF 
 
 
 
            #add-point:AFTER FIELD imae015 name="input.a.imae015"
            IF NOT cl_null(g_imae_m.imae015) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae015
            #add-point:BEFORE FIELD imae015 name="input.b.imae015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae015
            #add-point:ON CHANGE imae015 name="input.g.imae015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae023
            #add-point:BEFORE FIELD imae023 name="input.b.imae023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae023
            
            #add-point:AFTER FIELD imae023 name="input.a.imae023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae023
            #add-point:ON CHANGE imae023 name="input.g.imae023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae016
            
            #add-point:AFTER FIELD imae016 name="input.a.imae016"
            CALL aimm205_imae016_ref(g_imae_m.imae016) RETURNING g_imae_m.imae016_desc
            DISPLAY BY NAME g_imae_m.imae016_desc
            IF NOT cl_null(g_imae_m.imae016) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae016 != g_imae_m_t.imae016 OR cl_null(g_imae_m_t.imae016))) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imae_m.imae001
                  LET g_chkparam.arg2 = g_imae_m.imae016

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_imae_m.imae016 = g_imae_m_t.imae016
                     CALL aimm205_imae016_ref(g_imae_m.imae016) RETURNING g_imae_m.imae016_desc
                     DISPLAY BY NAME g_imae_m.imae016_desc
                     NEXT FIELD CURRENT
                  END IF                 
                  CALL s_aimi190_get_convert(g_imae_m.imae001,g_imae_m.imae016,g_imae_m.imaa006) RETURNING l_success,l_rate
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae016
            #add-point:BEFORE FIELD imae016 name="input.b.imae016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae016
            #add-point:ON CHANGE imae016 name="input.g.imae016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae017,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae017
            END IF 
 
 
 
            #add-point:AFTER FIELD imae017 name="input.a.imae017"
            IF NOT cl_null(g_imae_m.imae017) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae017
            #add-point:BEFORE FIELD imae017 name="input.b.imae017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae017
            #add-point:ON CHANGE imae017 name="input.g.imae017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae018,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae018
            END IF 
 
 
 
            #add-point:AFTER FIELD imae018 name="input.a.imae018"
            IF NOT cl_null(g_imae_m.imae018) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae018
            #add-point:BEFORE FIELD imae018 name="input.b.imae018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae018
            #add-point:ON CHANGE imae018 name="input.g.imae018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae019
            #add-point:BEFORE FIELD imae019 name="input.b.imae019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae019
            
            #add-point:AFTER FIELD imae019 name="input.a.imae019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae019
            #add-point:ON CHANGE imae019 name="input.g.imae019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae020,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imae020
            END IF 
 
 
 
            #add-point:AFTER FIELD imae020 name="input.a.imae020"
            IF NOT cl_null(g_imae_m.imae020) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae020
            #add-point:BEFORE FIELD imae020 name="input.b.imae020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae020
            #add-point:ON CHANGE imae020 name="input.g.imae020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae021
            #add-point:BEFORE FIELD imae021 name="input.b.imae021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae021
            
            #add-point:AFTER FIELD imae021 name="input.a.imae021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae021
            #add-point:ON CHANGE imae021 name="input.g.imae021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae031
            
            #add-point:AFTER FIELD imae031 name="input.a.imae031"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae031
            #add-point:BEFORE FIELD imae031 name="input.b.imae031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae031
            #add-point:ON CHANGE imae031 name="input.g.imae031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae037
            
            #add-point:AFTER FIELD imae037 name="input.a.imae037"
            #IF NOT cl_null(g_imae_m.imae037) THEN 
            #   #此段落由子樣板a19產生
            #   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            #   INITIALIZE g_chkparam.* TO NULL
            #   
            #   #設定g_chkparam.*的參數
            #   LET g_chkparam.arg1 = g_imae_m.imae001
            #   LET g_chkparam.arg2 = g_imae_m.imae037
            #
            #      
            #   #呼叫檢查存在並帶值的library
            #   IF cl_chk_exist("v_bmaa002") THEN
            #      #檢查成功時後續處理
            #      #LET  = g_chkparam.return1
            #      #DISPLAY BY NAME 
            #
            #   ELSE
            #      #檢查失敗時後續處理
            #      LET g_imae_m.imae037 = g_imae_m_t.imae037
            #      NEXT FIELD CURRENT
            #   END IF
            #ELSE
            #   LET g_imae_m.imae037 = ' '
            #END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae037
            #add-point:BEFORE FIELD imae037 name="input.b.imae037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae037
            #add-point:ON CHANGE imae037 name="input.g.imae037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae032
            
            #add-point:AFTER FIELD imae032 name="input.a.imae032"
            CALL aimm205_imae032_ref(g_imae_m.imae032) RETURNING g_imae_m.imae032_desc
            DISPLAY BY NAME g_imae_m.imae032_desc
            IF (NOT cl_null(g_imae_m.imae032)) AND g_imae_m.imae032 != g_imae_m.imae001 THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae032 != g_imae_m_t.imae032 OR cl_null(g_imae_m_t.imae032))) THEN   #170203-00002#10 20170207 mark by beckxie
               IF g_imae_m.imae032 != g_imae_m_o.imae032 OR cl_null(g_imae_m_o.imae032) THEN   #170203-00002#10 20170207 add by beckxie
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #161122-00017#1 mark---start---
                  ##設定g_chkparam.*的參數
                  #LET g_chkparam.arg1 = g_site
                  #LET g_chkparam.arg2 = g_imae_m.imae032
                  ##160318-00025#2--add--str
                  #LET g_errshow = TRUE 
                  #LET g_chkparam.err_str[1] = "aec-00012:sub-01302|aecm200|",cl_get_progname("aecm200",g_lang,"2"),"|:EXEPROGaecm200"
                  ##160318-00025#2--add--end
                  ##呼叫檢查存在並帶值的library
                  #IF NOT cl_chk_exist("v_ecba001") THEN
                  #   LET g_imae_m.imae032 = g_imae_m_t.imae032
                  #   CALL aimm205_imae032_ref(g_imae_m.imae032) RETURNING g_imae_m.imae032_desc
                  #   DISPLAY BY NAME g_imae_m.imae032_desc
                  #   NEXT FIELD CURRENT
                  #END IF
                  #161122-00017#1 mark---end---
                  #161122-00017#1 add---start---
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imae_m.imae032
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_imaa001") THEN
                     #LET g_imae_m.imae032 = g_imae_m_t.imae032   #170203-00002#10 20170207 mark by beckxie
                     #170203-00002#10 20170207 add by beckxie---S
                     LET g_imae_m.imae032 = g_imae_m_o.imae032
                     LET g_imae_m.imae033 = g_imae_m_o.imae033
                     CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
                     #170203-00002#10 20170207 add by beckxie---E
                     CALL aimm205_imae032_ref(g_imae_m.imae032) RETURNING g_imae_m.imae032_desc
                     DISPLAY BY NAME g_imae_m.imae032_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161122-00017#1 add---end---
                  
                  IF NOT cl_null(g_imae_m.imae033) THEN 
                     IF NOT aimm205_imae032_chk(g_imae_m.imae032,g_imae_m.imae033) THEN
                        #LET g_imae_m.imae033 = g_imae_m_t.imae033   #170203-00002#10 20170207 mark by beckxie
                        #170203-00002#10 20170207 add by beckxie---S
                        LET g_imae_m.imae032 = g_imae_m_o.imae032
                        CALL aimm205_imae032_ref(g_imae_m.imae032) RETURNING g_imae_m.imae032_desc
                        LET g_imae_m.imae033 = g_imae_m_o.imae033
                        #170203-00002#10 20170207 add by beckxie---E
                        CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
                        DISPLAY BY NAME g_imae_m.imae033_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               END IF
            END IF   
            LET g_imae_m_o.* = g_imae_m.*   #170203-00002#10 20170207 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae032
            #add-point:BEFORE FIELD imae032 name="input.b.imae032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae032
            #add-point:ON CHANGE imae032 name="input.g.imae032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae033
            
            #add-point:AFTER FIELD imae033 name="input.a.imae033"
           # CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
           # DISPLAY BY NAME g_imae_m.imae033_desc
           # IF NOT cl_null(g_imae_m.imae033) THEN 
           #    IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae033 != g_imae_m_t.imae033 OR cl_null(g_imae_m_t.imae033))) THEN
           #       ##設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
           #       #INITIALIZE g_chkparam.* TO NULL
           #       #
           #       ##設定g_chkparam.*的參數
           #       #LET g_chkparam.arg1 = g_site
           #       #LET g_chkparam.arg2 = g_imae_m.imae033
           #       #
           #       ##呼叫檢查存在並帶值的library
           #       #IF NOT cl_chk_exist("v_ecba002") THEN
           #       #   LET g_imae_m.imae033 = g_imae_m_t.imae033
           #       #   CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
           #       #   DISPLAY BY NAME g_imae_m.imae033_desc
           #       #   NEXT FIELD CURRENT
           #       #END IF
           #       #
           #       #IF NOT cl_null(g_imae_m.imae032) THEN 
           #          IF NOT aimm205_imae032_chk(g_imae_m.imae032,g_imae_m.imae033) THEN
           #             LET g_imae_m.imae033 = g_imae_m_t.imae033
           #             CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
           #             DISPLAY BY NAME g_imae_m.imae033_desc
           #             NEXT FIELD CURRENT
           #          END IF
           #       #END IF 
           #    END IF
           # END IF 
           LET g_imae_m_o.* = g_imae_m.*   #170203-00002#10 20170207 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae033
            #add-point:BEFORE FIELD imae033 name="input.b.imae033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae033
            #add-point:ON CHANGE imae033 name="input.g.imae033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae034
            
            #add-point:AFTER FIELD imae034 name="input.a.imae034"
            CALL aimm205_imae034_ref(g_imae_m.imae034) RETURNING g_imae_m.imae034_desc
            DISPLAY BY NAME g_imae_m.imae034_desc
            IF NOT cl_null(g_imae_m.imae034) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae034 != g_imae_m_t.imae034 OR cl_null(g_imae_m_t.imae034))) THEN
                  IF NOT aimm205_imae034_chk(g_imae_m.imae034) THEN
                     LET g_imae_m.imae034 = g_imae_m_t.imae034
                     CALL aimm205_imae034_ref(g_imae_m.imae034) RETURNING g_imae_m.imae034_desc
                     DISPLAY BY NAME g_imae_m.imae034_desc
                     NEXT FIELD imae034
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae034
            #add-point:BEFORE FIELD imae034 name="input.b.imae034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae034
            #add-point:ON CHANGE imae034 name="input.g.imae034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae035
            
            #add-point:AFTER FIELD imae035 name="input.a.imae035"
            CALL aimm205_imae035_ref(g_imae_m.imae035) RETURNING g_imae_m.imae035_desc
            DISPLAY BY NAME g_imae_m.imae035_desc
            IF NOT cl_null(g_imae_m.imae035) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae035 != g_imae_m_t.imae035 OR cl_null(g_imae_m_t.imae035))) THEN
               #   IF NOT ap_chk_isExist(g_imae_m.imae035,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? ","abm-00006",1 ) THEN
               #      LET g_imae_m.imae035 = g_imae_m_t.imae035
               #      CALL aimm205_imae035_ref(g_imae_m.imae035) RETURNING g_imae_m.imae035_desc
               #      DISPLAY BY NAME g_imae_m.imae035_desc
               #      NEXT FIELD imae035
               #   END IF
               #   IF NOT ap_chk_isExist(g_imae_m.imae035,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","abm-00007",1 ) THEN
               #      LET g_imae_m.imae035 = g_imae_m_t.imae035
               #      CALL aimm205_imae035_ref(g_imae_m.imae035) RETURNING g_imae_m.imae035_desc
               #      DISPLAY BY NAME g_imae_m.imae035_desc
               #      NEXT FIELD imae035
               #   END IF
               #  IF NOT ap_chk_isExist(g_imae_m.imae035,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '" ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' AND (ooeg006 <= '" ||g_today||"' AND (ooeg007 IS NULL OR ooeg007 > '" ||g_today||"' )) ","aoo-00201",0 ) THEN
               #     LET g_imae_m.imae035 = g_imae_m_t.imae035
               #     CALL aimm205_imae035_ref(g_imae_m.imae035) RETURNING g_imae_m.imae035_desc
               #     DISPLAY BY NAME g_imae_m.imae035_desc
               #     NEXT FIELD imae035
               #  END IF
                  CALL s_aooi125_chk_center('3',g_imae_m.imae035) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_imae_m.imae035 = g_imae_m_t.imae035
                     CALL aimm205_imae035_ref(g_imae_m.imae035) RETURNING g_imae_m.imae035_desc
                     DISPLAY BY NAME g_imae_m.imae035_desc
                     NEXT FIELD imae035 
                  END IF                     
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae035
            #add-point:BEFORE FIELD imae035 name="input.b.imae035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae035
            #add-point:ON CHANGE imae035 name="input.g.imae035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae022,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae022
            END IF 
 
 
 
            #add-point:AFTER FIELD imae022 name="input.a.imae022"
            IF NOT cl_null(g_imae_m.imae022) AND g_imae_m.imae022 > 0 THEN
               #當輸入值大於0時，檢查輸入值須大於[C:生產單位批量]及[C:最小生產數量]
               IF NOT cl_null(g_imae_m.imae017) THEN
                  IF g_imae_m.imae022 <= g_imae_m.imae017 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00195'
                     LET g_errparam.extend = g_imae_m.imae022
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imae_m.imae022 = g_imae_m_t.imae022
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_imae_m.imae018) THEN
                  IF g_imae_m.imae022 <= g_imae_m.imae018 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00196'
                     LET g_errparam.extend = g_imae_m.imae022
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_imae_m.imae022 = g_imae_m_t.imae022
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF  

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae022
            #add-point:BEFORE FIELD imae022 name="input.b.imae022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae022
            #add-point:ON CHANGE imae022 name="input.g.imae022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae036
            #add-point:BEFORE FIELD imae036 name="input.b.imae036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae036
            
            #add-point:AFTER FIELD imae036 name="input.a.imae036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae036
            #add-point:ON CHANGE imae036 name="input.g.imae036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae041
            
            #add-point:AFTER FIELD imae041 name="input.a.imae041"
            CALL aimm205_imae041_ref(g_imae_m.imae041) RETURNING g_imae_m.imae041_desc
            DISPLAY BY NAME g_imae_m.imae041_desc
            IF NOT cl_null(g_imae_m.imae041) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae041 != g_imae_m_t.imae041 OR cl_null(g_imae_m_t.imae041))) THEN
                  IF NOT aimm205_imae041_chk(g_imae_m.imae041) THEN
                     LET g_imae_m.imae041 = g_imae_m_t.imae041
                     CALL aimm205_imae041_ref(g_imae_m.imae041) RETURNING g_imae_m.imae041_desc
                     DISPLAY BY NAME g_imae_m.imae041_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae041
            #add-point:BEFORE FIELD imae041 name="input.b.imae041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae041
            #add-point:ON CHANGE imae041 name="input.g.imae041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae042
            
            #add-point:AFTER FIELD imae042 name="input.a.imae042"
            IF cl_null(g_imae_m.imae042) THEN
               LET g_imae_m.imae042 = ' '
            END IF
            CALL aimm205_imae042_ref(g_imae_m.imae041,g_imae_m.imae042) RETURNING g_imae_m.imae042_desc
            DISPLAY BY NAME g_imae_m.imae042_desc
            #IF (NOT cl_null(g_imae_m.imae041)) AND (NOT cl_null(g_imae_m.imae042)) THEN   
            IF (NOT cl_null(g_imae_m.imae042))THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae042 != g_imae_m_t.imae042 OR cl_null(g_imae_m_t.imae042))) THEN
                  IF NOT aimm205_imae042_chk(g_imae_m.imae041,g_imae_m.imae042) THEN
                     LET g_imae_m.imae042 = g_imae_m_t.imae042
                     CALL aimm205_imae042_ref(g_imae_m.imae041,g_imae_m.imae042) RETURNING g_imae_m.imae042_desc
                     DISPLAY BY NAME g_imae_m.imae042_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae042
            #add-point:BEFORE FIELD imae042 name="input.b.imae042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae042
            #add-point:ON CHANGE imae042 name="input.g.imae042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae051
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae051,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae051
            END IF 
 
 
 
            #add-point:AFTER FIELD imae051 name="input.a.imae051"
            IF NOT cl_null(g_imae_m.imae051) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae051
            #add-point:BEFORE FIELD imae051 name="input.b.imae051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae051
            #add-point:ON CHANGE imae051 name="input.g.imae051"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae052
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae052,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae052
            END IF 
 
 
 
            #add-point:AFTER FIELD imae052 name="input.a.imae052"
            IF NOT cl_null(g_imae_m.imae052) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae052
            #add-point:BEFORE FIELD imae052 name="input.b.imae052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae052
            #add-point:ON CHANGE imae052 name="input.g.imae052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae062
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae062,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae062
            END IF 
 
 
 
            #add-point:AFTER FIELD imae062 name="input.a.imae062"
            IF NOT cl_null(g_imae_m.imae062) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae062
            #add-point:BEFORE FIELD imae062 name="input.b.imae062"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae062
            #add-point:ON CHANGE imae062 name="input.g.imae062"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae064
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae064,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae064
            END IF 
 
 
 
            #add-point:AFTER FIELD imae064 name="input.a.imae064"
            IF NOT cl_null(g_imae_m.imae064) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae064
            #add-point:BEFORE FIELD imae064 name="input.b.imae064"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae064
            #add-point:ON CHANGE imae064 name="input.g.imae064"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae077
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae077,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae077
            END IF 
 
 
 
            #add-point:AFTER FIELD imae077 name="input.a.imae077"
            IF NOT cl_null(g_imae_m.imae077) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae077
            #add-point:BEFORE FIELD imae077 name="input.b.imae077"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae077
            #add-point:ON CHANGE imae077 name="input.g.imae077"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae078
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae078,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae078
            END IF 
 
 
 
            #add-point:AFTER FIELD imae078 name="input.a.imae078"
            IF NOT cl_null(g_imae_m.imae078) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae078
            #add-point:BEFORE FIELD imae078 name="input.b.imae078"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae078
            #add-point:ON CHANGE imae078 name="input.g.imae078"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae079
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae079,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae079
            END IF 
 
 
 
            #add-point:AFTER FIELD imae079 name="input.a.imae079"
            IF NOT cl_null(g_imae_m.imae079) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae079
            #add-point:BEFORE FIELD imae079 name="input.b.imae079"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae079
            #add-point:ON CHANGE imae079 name="input.g.imae079"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae080
            #add-point:BEFORE FIELD imae080 name="input.b.imae080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae080
            
            #add-point:AFTER FIELD imae080 name="input.a.imae080"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae080
            #add-point:ON CHANGE imae080 name="input.g.imae080"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae086
            #add-point:BEFORE FIELD imae086 name="input.b.imae086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae086
            
            #add-point:AFTER FIELD imae086 name="input.a.imae086"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae086
            #add-point:ON CHANGE imae086 name="input.g.imae086"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae071
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae071,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae071
            END IF 
 
 
 
            #add-point:AFTER FIELD imae071 name="input.a.imae071"
            IF NOT cl_null(g_imae_m.imae071) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae071
            #add-point:BEFORE FIELD imae071 name="input.b.imae071"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae071
            #add-point:ON CHANGE imae071 name="input.g.imae071"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae072
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae072,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae072
            END IF 
 
 
 
            #add-point:AFTER FIELD imae072 name="input.a.imae072"
            IF NOT cl_null(g_imae_m.imae072) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae072
            #add-point:BEFORE FIELD imae072 name="input.b.imae072"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae072
            #add-point:ON CHANGE imae072 name="input.g.imae072"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae073
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae073,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae073
            END IF 
 
 
 
            #add-point:AFTER FIELD imae073 name="input.a.imae073"
            IF NOT cl_null(g_imae_m.imae073) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae073
            #add-point:BEFORE FIELD imae073 name="input.b.imae073"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae073
            #add-point:ON CHANGE imae073 name="input.g.imae073"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae074
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae074,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae074
            END IF 
 
 
 
            #add-point:AFTER FIELD imae074 name="input.a.imae074"
            IF NOT cl_null(g_imae_m.imae074) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae074
            #add-point:BEFORE FIELD imae074 name="input.b.imae074"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae074
            #add-point:ON CHANGE imae074 name="input.g.imae074"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae075
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae075,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae075
            END IF 
 
 
 
            #add-point:AFTER FIELD imae075 name="input.a.imae075"
            IF NOT cl_null(g_imae_m.imae075) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae075
            #add-point:BEFORE FIELD imae075 name="input.b.imae075"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae075
            #add-point:ON CHANGE imae075 name="input.g.imae075"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae081
            
            #add-point:AFTER FIELD imae081 name="input.a.imae081"
            CALL aimm205_imae081_ref(g_imae_m.imae081) RETURNING g_imae_m.imae081_desc
            DISPLAY BY NAME g_imae_m.imae081_desc
            IF NOT cl_null(g_imae_m.imae081) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae081 != g_imae_m_t.imae081 OR cl_null(g_imae_m_t.imae081))) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_imae_m.imae001
                  LET g_chkparam.arg2 = g_imae_m.imae081

                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_imae_m.imae081 = g_imae_m_t.imae081
                     CALL aimm205_imae081_ref(g_imae_m.imae081) RETURNING g_imae_m.imae081_desc
                     DISPLAY BY NAME g_imae_m.imae081_desc
                     NEXT FIELD CURRENT
                  END IF
                 
                  CALL s_aimi190_get_convert(g_imae_m.imae001,g_imae_m.imae081,g_imae_m.imaa006) RETURNING l_success,l_rate
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae081
            #add-point:BEFORE FIELD imae081 name="input.b.imae081"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae081
            #add-point:ON CHANGE imae081 name="input.g.imae081"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae082
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae082,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae082
            END IF 
 
 
 
            #add-point:AFTER FIELD imae082 name="input.a.imae082"
            IF NOT cl_null(g_imae_m.imae082) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae082
            #add-point:BEFORE FIELD imae082 name="input.b.imae082"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae082
            #add-point:ON CHANGE imae082 name="input.g.imae082"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae083
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae083,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae083
            END IF 
 
 
 
            #add-point:AFTER FIELD imae083 name="input.a.imae083"
            IF NOT cl_null(g_imae_m.imae083) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae083
            #add-point:BEFORE FIELD imae083 name="input.b.imae083"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae083
            #add-point:ON CHANGE imae083 name="input.g.imae083"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae084
            #add-point:BEFORE FIELD imae084 name="input.b.imae084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae084
            
            #add-point:AFTER FIELD imae084 name="input.a.imae084"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae084
            #add-point:ON CHANGE imae084 name="input.g.imae084"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae085
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imae_m.imae085,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imae085
            END IF 
 
 
 
            #add-point:AFTER FIELD imae085 name="input.a.imae085"
            IF NOT cl_null(g_imae_m.imae085) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae085
            #add-point:BEFORE FIELD imae085 name="input.b.imae085"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae085
            #add-point:ON CHANGE imae085 name="input.g.imae085"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae091
            #add-point:BEFORE FIELD imae091 name="input.b.imae091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae091
            
            #add-point:AFTER FIELD imae091 name="input.a.imae091"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae091
            #add-point:ON CHANGE imae091 name="input.g.imae091"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae092
            #add-point:BEFORE FIELD imae092 name="input.b.imae092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae092
            
            #add-point:AFTER FIELD imae092 name="input.a.imae092"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae092
            #add-point:ON CHANGE imae092 name="input.g.imae092"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae101
            
            #add-point:AFTER FIELD imae101 name="input.a.imae101"
            CALL aimm205_imae041_ref(g_imae_m.imae101) RETURNING g_imae_m.imae101_desc
            DISPLAY BY NAME g_imae_m.imae101_desc
            IF NOT cl_null(g_imae_m.imae101) THEN   
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae101 != g_imae_m_t.imae101 OR cl_null(g_imae_m_t.imae101))) THEN
                  IF NOT aimm205_imae041_chk(g_imae_m.imae101) THEN
                     LET g_imae_m.imae101 = g_imae_m_t.imae101
                     CALL aimm205_imae041_ref(g_imae_m.imae101) RETURNING g_imae_m.imae101_desc
                     DISPLAY BY NAME g_imae_m.imae101_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae101
            #add-point:BEFORE FIELD imae101 name="input.b.imae101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae101
            #add-point:ON CHANGE imae101 name="input.g.imae101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae102
            
            #add-point:AFTER FIELD imae102 name="input.a.imae102"
            IF cl_null(g_imae_m.imae102) THEN
               LET g_imae_m.imae102 = ' '
            END IF
            CALL aimm205_imae042_ref(g_imae_m.imae101,g_imae_m.imae102) RETURNING g_imae_m.imae102_desc
            DISPLAY BY NAME g_imae_m.imae102_desc
            #IF (NOT cl_null(g_imae_m.imae101)) AND (NOT cl_null(g_imae_m.imae102)) THEN
            IF (NOT cl_null(g_imae_m.imae102)) THEN            
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae102 != g_imae_m_t.imae102 OR cl_null(g_imae_m_t.imae102))) THEN
                  IF NOT aimm205_imae042_chk(g_imae_m.imae101,g_imae_m.imae102) THEN
                     LET g_imae_m.imae102 = g_imae_m_t.imae102
                     CALL aimm205_imae042_ref(g_imae_m.imae101,g_imae_m.imae102) RETURNING g_imae_m.imae102_desc
                     DISPLAY BY NAME g_imae_m.imae102_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae102
            #add-point:BEFORE FIELD imae102 name="input.b.imae102"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae102
            #add-point:ON CHANGE imae102 name="input.g.imae102"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae103
            
            #add-point:AFTER FIELD imae103 name="input.a.imae103"
            CALL aimm205_imae041_ref(g_imae_m.imae103) RETURNING g_imae_m.imae103_desc
            DISPLAY BY NAME g_imae_m.imae103_desc
            IF NOT cl_null(g_imae_m.imae103) THEN   
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae103 != g_imae_m_t.imae103 OR cl_null(g_imae_m_t.imae103))) THEN
                  IF NOT aimm205_imae041_chk(g_imae_m.imae103) THEN
                     LET g_imae_m.imae103 = g_imae_m_t.imae103
                     CALL aimm205_imae041_ref(g_imae_m.imae103) RETURNING g_imae_m.imae103_desc
                     DISPLAY BY NAME g_imae_m.imae103_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae103
            #add-point:BEFORE FIELD imae103 name="input.b.imae103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae103
            #add-point:ON CHANGE imae103 name="input.g.imae103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae104
            
            #add-point:AFTER FIELD imae104 name="input.a.imae104"
            IF cl_null(g_imae_m.imae104) THEN
               LET g_imae_m.imae104 = ' '
            END IF
            CALL aimm205_imae042_ref(g_imae_m.imae103,g_imae_m.imae104) RETURNING g_imae_m.imae104_desc
            DISPLAY BY NAME g_imae_m.imae104_desc
            #IF (NOT cl_null(g_imae_m.imae103)) AND (NOT cl_null(g_imae_m.imae104)) THEN  
            IF (NOT cl_null(g_imae_m.imae104)) THEN            
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_imae_m.imae104 != g_imae_m_t.imae104 OR cl_null(g_imae_m_t.imae104))) THEN
                  IF NOT aimm205_imae042_chk(g_imae_m.imae103,g_imae_m.imae104) THEN
                     LET g_imae_m.imae104 = g_imae_m_t.imae104
                     CALL aimm205_imae042_ref(g_imae_m.imae103,g_imae_m.imae104) RETURNING g_imae_m.imae104_desc
                     DISPLAY BY NAME g_imae_m.imae104_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae104
            #add-point:BEFORE FIELD imae104 name="input.b.imae104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imae104
            #add-point:ON CHANGE imae104 name="input.g.imae104"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imae001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae001
            #add-point:ON ACTION controlp INFIELD imae001 name="input.c.imae001"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae011
            #add-point:ON ACTION controlp INFIELD imae011 name="input.c.imae011"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae011             #給予default值

            CALL q_imcf011()                               #呼叫開窗

            LET g_imae_m.imae011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae011 TO imae011              #顯示到畫面上
            CALL aimm205_imae011_ref(g_imae_m.imae011) RETURNING g_imae_m.imae011_desc
            DISPLAY g_imae_m.imae011_desc TO imae011_desc
     
            NEXT FIELD imae011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae012
            #add-point:ON ACTION controlp INFIELD imae012 name="input.c.imae012"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae012             #給予default值
            LET g_qryparam.default2 = "" #g_imae_m.oofa011 #全名

            #給予arg
            #160729-00020--s                                                                                    
            IF g_site='ALL' THEN
               CALL q_ooag001()  
            ELSE
               CALL q_ooag001_2()  
            END IF
            #CALL q_ooag001_2()                           #呼叫開窗
            #160729-00020---e
            LET g_imae_m.imae012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_imae_m.oofa011 = g_qryparam.return2 #全名

            DISPLAY g_imae_m.imae012 TO imae012              #顯示到畫面上
            #DISPLAY g_imae_m.oofa011 TO oofa011 #全名
            CALL aimm205_imae012_ref(g_imae_m.imae012) RETURNING g_imae_m.imae012_desc
            DISPLAY g_imae_m.imae012_desc TO imae012_desc

            NEXT FIELD imae012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae013
            #add-point:ON ACTION controlp INFIELD imae013 name="input.c.imae013"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae014
            #add-point:ON ACTION controlp INFIELD imae014 name="input.c.imae014"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae015
            #add-point:ON ACTION controlp INFIELD imae015 name="input.c.imae015"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae023
            #add-point:ON ACTION controlp INFIELD imae023 name="input.c.imae023"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae016
            #add-point:ON ACTION controlp INFIELD imae016 name="input.c.imae016"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae016             #給予default值

            #給予arg
            LET g_qryparam.arg1 =  g_imae_m.imae001

            CALL q_imao002()                                 #呼叫開窗

            LET g_imae_m.imae016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae016 TO imae016              #顯示到畫面上
            CALL aimm205_imae016_ref(g_imae_m.imae016) RETURNING g_imae_m.imae016_desc
            DISPLAY g_imae_m.imae016_desc TO imae016_desc

            NEXT FIELD imae016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae017
            #add-point:ON ACTION controlp INFIELD imae017 name="input.c.imae017"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae018
            #add-point:ON ACTION controlp INFIELD imae018 name="input.c.imae018"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae019
            #add-point:ON ACTION controlp INFIELD imae019 name="input.c.imae019"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae020
            #add-point:ON ACTION controlp INFIELD imae020 name="input.c.imae020"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae021
            #add-point:ON ACTION controlp INFIELD imae021 name="input.c.imae021"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae031
            #add-point:ON ACTION controlp INFIELD imae031 name="input.c.imae031"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #參照表編號
            LET g_qryparam.arg2 = "asft300" #對應程式代號
            #160711-00040#14 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#14 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_imae_m.imae031 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae031 TO imae031              #顯示到畫面上
            CALL aimm205_imae031_ref(g_imae_m.imae031) RETURNING g_imae_m.imae031_desc
            DISPLAY g_imae_m.imae031_desc TO imae031_desc

            NEXT FIELD imae031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae037
            #add-point:ON ACTION controlp INFIELD imae037 name="input.c.imae037"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae037             #給予default值
            LET g_qryparam.where = " bmaa001 = '",g_imae_m.imae001,"' "
            #給予arg

            CALL q_bmaa002()                                #呼叫開窗
            LET g_qryparam.where = " "

            LET g_imae_m.imae037 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae037 TO imae037              #顯示到畫面上

            NEXT FIELD imae037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae032
            #add-point:ON ACTION controlp INFIELD imae032 name="input.c.imae032"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae032             #給予default值

            #給予arg

            #CALL q_ecba001()                                #呼叫開窗
            CALL q_imaf001_15()

            LET g_imae_m.imae032 = g_qryparam.return1              #將開窗取得的值回傳到變數
           #LET g_imae_m.imae033 = g_qryparam.return2              #將開窗取得的值回傳到變數
           #DISPLAY g_imae_m.imae033 TO imae033   
            
            CALL aimm205_imae032_ref(g_imae_m.imae032) RETURNING g_imae_m.imae032_desc
            DISPLAY g_imae_m.imae032_desc TO imae032_desc
                      
           #CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
           #DISPLAY g_imae_m.imae033_desc TO imae033_desc

            NEXT FIELD imae032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae033
            #add-point:ON ACTION controlp INFIELD imae033 name="input.c.imae033"
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_imae_m.imae032

            CALL q_ecba002_1()                                #呼叫開窗
            LET g_qryparam.arg1 = ' '

            LET g_imae_m.imae033 = g_qryparam.return1    

            DISPLAY g_imae_m.imae033 TO imae033              #顯示到畫面上
            CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
            DISPLAY g_imae_m.imae033_desc TO imae033_desc
            
            NEXT FIELD imae033                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.imae034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae034
            #add-point:ON ACTION controlp INFIELD imae034 name="input.c.imae034"
#此段落由子樣板a07產生            
            MENU "" ATTRIBUTE (STYLE="popup", IMAGE="question")
               ON ACTION open_ooeg
                  LET g_bgjob = '1'
                  EXIT MENU
    
               ON ACTION open_pmaa
                  LET g_bgjob = '2'
                  EXIT MENU
            END MENU
            IF g_bgjob = '1' THEN
               INITIALIZE g_qryparam.* TO NULL
               #開窗i段
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
    
               LET g_qryparam.default1 = g_imae_m.imae034              #給予default值
    
               #給予arg
               LET g_qryparam.arg1 = g_today           
               CALL q_ooeg001()                                #呼叫開窗
               LET g_qryparam.arg1 = " "
               LET g_imae_m.imae034 = g_qryparam.return1              #將開窗取得的值回傳到變數
    
               DISPLAY g_imae_m.imae034 TO imae034              #顯示到畫面上
               CALL aimm205_imae034_ref(g_imae_m.imae034) RETURNING g_imae_m.imae034_desc
               DISPLAY g_imae_m.imae034_desc TO imae034_desc
            ELSE
               INITIALIZE g_qryparam.* TO NULL
               #開窗i段
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
    
               LET g_qryparam.default1 = g_imae_m.imae034              #給予default值
    
               #LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "   #160913-00055#1
               CALL q_pmaa001()
               LET g_imae_m.imae034 = g_qryparam.return1
               LET g_qryparam.where = " "
               
               DISPLAY g_imae_m.imae034 TO imae034              #顯示到畫面上
               CALL aimm205_imae034_ref(g_imae_m.imae034) RETURNING g_imae_m.imae034_desc
               DISPLAY g_imae_m.imae034_desc TO imae034_desc
            END IF
         
            #LET g_qryparam.reqry = FALSE

            #LET g_qryparam.default1 = g_imae_m.imae034             #給予default值
            #LET g_qryparam.arg1 = g_today
#           
            #CALL q_ooeg001()                                #呼叫開窗
            #LET g_qryparam.arg1 = " "
#
            #LET g_imae_m.imae034 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #IF cl_null(g_imae_m.imae034) THEN
            #   LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
            #   CALL q_pmaa001()
            #   LET g_imae_m.imae034 = g_qryparam.return1
            #   LET g_qryparam.where = " "
            #END IF

            #DISPLAY g_imae_m.imae034 TO imae034              #顯示到畫面上
            #CALL aimm205_imae034_ref(g_imae_m.imae034) RETURNING g_imae_m.imae034_desc
            #DISPLAY g_imae_m.imae034_desc TO imae034_desc

            NEXT FIELD imae034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae035
            #add-point:ON ACTION controlp INFIELD imae035 name="input.c.imae035"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae035             #給予default值
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg003 = '3'"
            #給予arg

            CALL q_ooeg001()                                #呼叫開窗
            LET g_qryparam.arg1 = ""
            LET g_qryparam.where = ""

            LET g_imae_m.imae035 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae035 TO imae035              #顯示到畫面上
            CALL aimm205_imae035_ref(g_imae_m.imae035) RETURNING g_imae_m.imae035_desc
            DISPLAY g_imae_m.imae035_desc TO imae035_desc

            NEXT FIELD imae035                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae022
            #add-point:ON ACTION controlp INFIELD imae022 name="input.c.imae022"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae036
            #add-point:ON ACTION controlp INFIELD imae036 name="input.c.imae036"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae041
            #add-point:ON ACTION controlp INFIELD imae041 name="input.c.imae041"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae041             #給予default值

            #給予arg

            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inaa001_4()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            
            LET g_imae_m.imae041 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae041 TO imae041              #顯示到畫面上
            CALL aimm205_imae041_ref(g_imae_m.imae041) RETURNING g_imae_m.imae041_desc
            DISPLAY g_imae_m.imae041_desc TO imae041_desc

            NEXT FIELD imae041                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae042
            #add-point:ON ACTION controlp INFIELD imae042 name="input.c.imae042"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae042             #給予default值
            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            LET g_qryparam.arg2 = g_imae_m.imae041
            
            CALL q_inab002_8()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            LET g_qryparam.arg2 = " "

            LET g_imae_m.imae042 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae042 TO imae042              #顯示到畫面上
            CALL aimm205_imae042_ref(g_imae_m.imae041,g_imae_m.imae042) RETURNING g_imae_m.imae042_desc
            DISPLAY g_imae_m.imae042_desc TO imae042_desc

            NEXT FIELD imae042                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae051
            #add-point:ON ACTION controlp INFIELD imae051 name="input.c.imae051"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae052
            #add-point:ON ACTION controlp INFIELD imae052 name="input.c.imae052"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae062
            #add-point:ON ACTION controlp INFIELD imae062 name="input.c.imae062"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae064
            #add-point:ON ACTION controlp INFIELD imae064 name="input.c.imae064"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae077
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae077
            #add-point:ON ACTION controlp INFIELD imae077 name="input.c.imae077"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae078
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae078
            #add-point:ON ACTION controlp INFIELD imae078 name="input.c.imae078"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae079
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae079
            #add-point:ON ACTION controlp INFIELD imae079 name="input.c.imae079"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae080
            #add-point:ON ACTION controlp INFIELD imae080 name="input.c.imae080"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae086
            #add-point:ON ACTION controlp INFIELD imae086 name="input.c.imae086"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae071
            #add-point:ON ACTION controlp INFIELD imae071 name="input.c.imae071"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae072
            #add-point:ON ACTION controlp INFIELD imae072 name="input.c.imae072"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae073
            #add-point:ON ACTION controlp INFIELD imae073 name="input.c.imae073"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae074
            #add-point:ON ACTION controlp INFIELD imae074 name="input.c.imae074"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae075
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae075
            #add-point:ON ACTION controlp INFIELD imae075 name="input.c.imae075"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae081
            #add-point:ON ACTION controlp INFIELD imae081 name="input.c.imae081"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae081             #給予default值

            #給予arg
            LET g_qryparam.arg1 =  g_imae_m.imae001

            CALL q_imao002()                                    #呼叫開窗

            LET g_imae_m.imae081 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae081 TO imae081              #顯示到畫面上
            CALL aimm205_imae081_ref(g_imae_m.imae081) RETURNING g_imae_m.imae081_desc
            DISPLAY g_imae_m.imae081_desc TO imae081_desc

            NEXT FIELD imae081                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae082
            #add-point:ON ACTION controlp INFIELD imae082 name="input.c.imae082"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae083
            #add-point:ON ACTION controlp INFIELD imae083 name="input.c.imae083"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae084
            #add-point:ON ACTION controlp INFIELD imae084 name="input.c.imae084"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae085
            #add-point:ON ACTION controlp INFIELD imae085 name="input.c.imae085"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae091
            #add-point:ON ACTION controlp INFIELD imae091 name="input.c.imae091"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae092
            #add-point:ON ACTION controlp INFIELD imae092 name="input.c.imae092"
            
            #END add-point
 
 
         #Ctrlp:input.c.imae101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae101
            #add-point:ON ACTION controlp INFIELD imae101 name="input.c.imae101"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae101             #給予default值

            #給予arg

            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inaa001_4()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            
            LET g_imae_m.imae101 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae101 TO imae101              #顯示到畫面上
            CALL aimm205_imae041_ref(g_imae_m.imae101) RETURNING g_imae_m.imae101_desc
            DISPLAY g_imae_m.imae101_desc TO imae101_desc

            NEXT FIELD imae101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae102
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae102
            #add-point:ON ACTION controlp INFIELD imae102 name="input.c.imae102"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae102             #給予default值
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            LET g_qryparam.arg2 = g_imae_m.imae101
            
            CALL q_inab002_8()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            LET g_qryparam.arg2 = " "

            LET g_imae_m.imae102 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae102 TO imae102              #顯示到畫面上
            CALL aimm205_imae042_ref(g_imae_m.imae101,g_imae_m.imae102) RETURNING g_imae_m.imae102_desc
            DISPLAY g_imae_m.imae102_desc TO imae102_desc

            NEXT FIELD imae102                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae103
            #add-point:ON ACTION controlp INFIELD imae103 name="input.c.imae103"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae103             #給予default值

            #給予arg

            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            CALL q_inaa001_4()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            
            LET g_imae_m.imae103 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae103 TO imae103              #顯示到畫面上
            CALL aimm205_imae041_ref(g_imae_m.imae103) RETURNING g_imae_m.imae103_desc
            DISPLAY g_imae_m.imae103_desc TO imae103_desc

            NEXT FIELD imae103                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imae104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae104
            #add-point:ON ACTION controlp INFIELD imae104 name="input.c.imae104"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imae_m.imae104             #給予default值

            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t
            ELSE
               LET g_qryparam.arg1 = g_site
            END IF
            LET g_qryparam.arg2 = g_imae_m.imae103
            
            CALL q_inab002_8()                           #呼叫開窗
            LET g_qryparam.arg1 = " "
            LET g_qryparam.arg2 = " "
            LET g_imae_m.imae104 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imae_m.imae104 TO imae104              #顯示到畫面上
            CALL aimm205_imae042_ref(g_imae_m.imae103,g_imae_m.imae104) RETURNING g_imae_m.imae104_desc
            DISPLAY g_imae_m.imae104_desc TO imae104_desc

            NEXT FIELD imae104                          #返回原欄位


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
               SELECT COUNT(1) INTO l_count FROM imae_t
                WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_imae_m.imae001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO imae_t (imaeent, imaesite,imae001,imae011,imae012,imaeownid,imaeowndp, 
                      imaecrtid,imaecrtdp,imaecrtdt,imaemodid,imaemoddt,imae013,imae014,imae015,imae023, 
                      imae016,imae017,imae018,imae019,imae020,imae021,imae031,imae037,imae032,imae033, 
                      imae034,imae035,imae022,imae036,imae041,imae042,imae051,imae052,imae062,imae064, 
                      imae077,imae078,imae079,imae080,imae086,imae071,imae072,imae073,imae074,imae075, 
                      imae081,imae082,imae083,imae084,imae085,imae091,imae092,imae101,imae102,imae103, 
                      imae104)
                  VALUES (g_enterprise, g_site,g_imae_m.imae001,g_imae_m.imae011,g_imae_m.imae012,g_imae_m.imaeownid, 
                      g_imae_m.imaeowndp,g_imae_m.imaecrtid,g_imae_m.imaecrtdp,g_imae_m.imaecrtdt,g_imae_m.imaemodid, 
                      g_imae_m.imaemoddt,g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015,g_imae_m.imae023, 
                      g_imae_m.imae016,g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020, 
                      g_imae_m.imae021,g_imae_m.imae031,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae033, 
                      g_imae_m.imae034,g_imae_m.imae035,g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041, 
                      g_imae_m.imae042,g_imae_m.imae051,g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064, 
                      g_imae_m.imae077,g_imae_m.imae078,g_imae_m.imae079,g_imae_m.imae080,g_imae_m.imae086, 
                      g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073,g_imae_m.imae074,g_imae_m.imae075, 
                      g_imae_m.imae081,g_imae_m.imae082,g_imae_m.imae083,g_imae_m.imae084,g_imae_m.imae085, 
                      g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae102,g_imae_m.imae103, 
                      g_imae_m.imae104) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_imae_m.imae001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aimm205_imae_t_mask_restore('restore_mask_o')
               
               UPDATE imae_t SET (imae001,imae011,imae012,imaeownid,imaeowndp,imaecrtid,imaecrtdp,imaecrtdt, 
                   imaemodid,imaemoddt,imae013,imae014,imae015,imae023,imae016,imae017,imae018,imae019, 
                   imae020,imae021,imae031,imae037,imae032,imae033,imae034,imae035,imae022,imae036,imae041, 
                   imae042,imae051,imae052,imae062,imae064,imae077,imae078,imae079,imae080,imae086,imae071, 
                   imae072,imae073,imae074,imae075,imae081,imae082,imae083,imae084,imae085,imae091,imae092, 
                   imae101,imae102,imae103,imae104) = (g_imae_m.imae001,g_imae_m.imae011,g_imae_m.imae012, 
                   g_imae_m.imaeownid,g_imae_m.imaeowndp,g_imae_m.imaecrtid,g_imae_m.imaecrtdp,g_imae_m.imaecrtdt, 
                   g_imae_m.imaemodid,g_imae_m.imaemoddt,g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015, 
                   g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019, 
                   g_imae_m.imae020,g_imae_m.imae021,g_imae_m.imae031,g_imae_m.imae037,g_imae_m.imae032, 
                   g_imae_m.imae033,g_imae_m.imae034,g_imae_m.imae035,g_imae_m.imae022,g_imae_m.imae036, 
                   g_imae_m.imae041,g_imae_m.imae042,g_imae_m.imae051,g_imae_m.imae052,g_imae_m.imae062, 
                   g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078,g_imae_m.imae079,g_imae_m.imae080, 
                   g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073,g_imae_m.imae074, 
                   g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae082,g_imae_m.imae083,g_imae_m.imae084, 
                   g_imae_m.imae085,g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae102, 
                   g_imae_m.imae103,g_imae_m.imae104)
                WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_imae001_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imae_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL aimm205_imae_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                  #若g_site='ALL'，則呼叫s_aooi090_upd_fields，將有設定為集團一致的欄位資料一併更新
                  IF g_site = 'ALL' THEN
                     IF NOT s_aooi090_upd_fields('2',g_imae001_t) THEN #'2' 據點製造資料
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "imae_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0')
                     END IF 
                  END IF 
                   
                   LET l_imai065 = cl_get_current()
                   UPDATE imai_t SET (imai063,imai064,imai065) = ('1',g_user,l_imai065)
                    WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = g_imae001_t
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "imai_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
  
                      CALL s_transaction_end('N','0')
                   END IF
                   IF NOT s_aimm200_upd_item_site_stus(g_imae_m.imae001,g_site) THEN
                     CALL s_transaction_end('N','0')
                  END IF
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_imae_m_t)
                     LET g_log2 = util.JSON.stringify(g_imae_m)
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
 
{<section id="aimm205.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimm205_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE imae_t.imae001 
   DEFINE l_oldno     LIKE imae_t.imae001 
 
   DEFINE l_master    RECORD LIKE imae_t.* #此變數樣板目前無使用
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
   IF g_imae_m.imae001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_imae001_t = g_imae_m.imae001
 
   
   #清空key值
   LET g_imae_m.imae001 = ""
 
    
   CALL aimm205_set_entry("a")
   CALL aimm205_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imae_m.imaeownid = g_user
      LET g_imae_m.imaeowndp = g_dept
      LET g_imae_m.imaecrtid = g_user
      LET g_imae_m.imaecrtdp = g_dept 
      LET g_imae_m.imaecrtdt = cl_get_current()
      LET g_imae_m.imaemodid = g_user
      LET g_imae_m.imaemoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aimm205_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_imae_m.* TO NULL
      CALL aimm205_show()
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
      LET g_errparam.extend = "imae_t:",SQLERRMESSAGE 
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
   CALL aimm205_set_act_visible()
   CALL aimm205_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imae001_t = g_imae_m.imae001
 
   
   #組合新增資料的條件
   LET g_add_browse = " imaeent = " ||g_enterprise|| " AND imaesite = '" ||g_site|| "' AND",
                      " imae001 = '", g_imae_m.imae001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimm205_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_imae_m.imaeownid      
   LET g_data_dept  = g_imae_m.imaeowndp
              
   #功能已完成,通報訊息中心
   CALL aimm205_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aimm205_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   INITIALIZE g_imae_m_o.* TO NULL
   LET g_imae_m_o.* = g_imae_m.*   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimm205_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            CALL aimm205_imae001_ref(g_imae_m.imae001) RETURNING g_imae_m.imaal003,g_imae_m.imaal004,g_imae_m.imaal005,
                          g_imae_m.imaa002,g_imae_m.imaa009,g_imae_m.imaa003,g_imae_m.imaa004,g_imae_m.imaa005,g_imae_m.imaa006,
                          g_imae_m.imaa010,g_imae_m.status1,g_imae_m.imaf012,g_imae_m.imaf013,g_imae_m.imaf014
            DISPLAY BY NAME g_imae_m.imaal003,g_imae_m.imaal004,g_imae_m.imaal005,g_imae_m.imaa009,g_imae_m.imaa003,g_imae_m.imaa004,g_imae_m.imaa005,g_imae_m.imaa006,g_imae_m.imaa010
            
            DISPLAY BY NAME g_imae_m.status1
            DISPLAY BY NAME g_imae_m.imaf012,g_imae_m.imaf013,g_imae_m.imaf014
            
            CALL aimm205_imaa009_ref(g_imae_m.imaa009) RETURNING g_imae_m.imaa009_desc
            DISPLAY BY NAME g_imae_m.imaa009_desc

            CALL aimm205_imaa003_ref(g_imae_m.imaa003) RETURNING g_imae_m.imaa003_desc
            DISPLAY BY NAME g_imae_m.imaa003_desc
            
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imae_m.imaa005
            CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imae_m.imaa005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_imae_m.imaa005_desc

            
            CALL aimm205_imaa006_ref(g_imae_m.imaa006) RETURNING g_imae_m.imaa006_desc
            DISPLAY BY NAME g_imae_m.imaa006_desc
            
            CALL aimm205_imaa010_ref(g_imae_m.imaa010) RETURNING g_imae_m.imaa010_desc
            DISPLAY BY NAME g_imae_m.imaa010_desc  

            #CALL aimm205_imae011_ref(g_imae_m.imae011) RETURNING g_imae_m.imae011_desc
            #DISPLAY BY NAME g_imae_m.imae011_desc
            #
            #CALL aimm205_imae012_ref(g_imae_m.imae012) RETURNING g_imae_m.imae012_desc
            #DISPLAY BY NAME g_imae_m.imae012_desc
            

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imae_m.imaeownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imae_m.imaeownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imae_m.imaeownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imae_m.imaeowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imae_m.imaeowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imae_m.imaeowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imae_m.imaecrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imae_m.imaecrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imae_m.imaecrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imae_m.imaecrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imae_m.imaecrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imae_m.imaecrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imae_m.imaemodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imae_m.imaemodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imae_m.imaemodid_desc

            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_imae_m.imaecnfid
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            #LET g_imae_m.imaecnfid_desc = g_rtn_fields[1]
            #DISPLAY BY NAME g_imae_m.imaecnfid_desc

            #CALL aimm205_imae016_ref(g_imae_m.imae016) RETURNING g_imae_m.imae016_desc
            #DISPLAY BY NAME g_imae_m.imae016_desc
            
            CALL aimm205_imae031_ref(g_imae_m.imae031) RETURNING g_imae_m.imae031_desc
            DISPLAY BY NAME g_imae_m.imae031_desc
            
            #CALL aimm205_imae032_ref(g_imae_m.imae032) RETURNING g_imae_m.imae032_desc
            #DISPLAY BY NAME g_imae_m.imae032_desc
            #
            #CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
            #DISPLAY g_imae_m.imae033_desc TO imae033_desc
            
            CALL aimm205_imae034_ref(g_imae_m.imae034) RETURNING g_imae_m.imae034_desc
            DISPLAY BY NAME g_imae_m.imae034_desc
            
            #CALL aimm205_imae035_ref(g_imae_m.imae035) RETURNING g_imae_m.imae035_desc
            #DISPLAY BY NAME g_imae_m.imae035_desc
            
            CALL aimm205_imae041_ref(g_imae_m.imae041) RETURNING g_imae_m.imae041_desc
            DISPLAY BY NAME g_imae_m.imae041_desc
            
            CALL aimm205_imae042_ref(g_imae_m.imae041,g_imae_m.imae042) RETURNING g_imae_m.imae042_desc
            DISPLAY BY NAME g_imae_m.imae042_desc
            
            #CALL aimm205_imae081_ref(g_imae_m.imae081) RETURNING g_imae_m.imae081_desc
            #DISPLAY BY NAME g_imae_m.imae081_desc
            
            CALL aimm205_imae041_ref(g_imae_m.imae101) RETURNING g_imae_m.imae101_desc
            DISPLAY BY NAME g_imae_m.imae101_desc
            
            CALL aimm205_imae042_ref(g_imae_m.imae101,g_imae_m.imae102) RETURNING g_imae_m.imae102_desc
            DISPLAY BY NAME g_imae_m.imae102_desc
            
            CALL aimm205_imae041_ref(g_imae_m.imae103) RETURNING g_imae_m.imae103_desc
            DISPLAY BY NAME g_imae_m.imae103_desc
            
            CALL aimm205_imae042_ref(g_imae_m.imae103,g_imae_m.imae104) RETURNING g_imae_m.imae104_desc
            DISPLAY BY NAME g_imae_m.imae104_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imae_m.imae001,g_imae_m.imaa002,g_imae_m.imaal003,g_imae_m.imaal004,g_imae_m.imaal005, 
       g_imae_m.imaa009,g_imae_m.imaa009_desc,g_imae_m.imaa003,g_imae_m.imaa003_desc,g_imae_m.imaa004, 
       g_imae_m.imaa005,g_imae_m.imaa005_desc,g_imae_m.imaa006,g_imae_m.imaa006_desc,g_imae_m.imaa010, 
       g_imae_m.imaa010_desc,g_imae_m.status1,g_imae_m.imaf012,g_imae_m.imaf013,g_imae_m.imaf014,g_imae_m.imae011, 
       g_imae_m.imae011_desc,g_imae_m.imae012,g_imae_m.imae012_desc,g_imae_m.imaeownid,g_imae_m.imaeownid_desc, 
       g_imae_m.imaeowndp,g_imae_m.imaeowndp_desc,g_imae_m.imaecrtid,g_imae_m.imaecrtid_desc,g_imae_m.imaecrtdp, 
       g_imae_m.imaecrtdp_desc,g_imae_m.imaecrtdt,g_imae_m.imaemodid,g_imae_m.imaemodid_desc,g_imae_m.imaemoddt, 
       g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015,g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae016_desc, 
       g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020,g_imae_m.imae021,g_imae_m.imae031, 
       g_imae_m.imae031_desc,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae032_desc,g_imae_m.imae033, 
       g_imae_m.imae033_desc,g_imae_m.imae034,g_imae_m.imae034_desc,g_imae_m.imae035,g_imae_m.imae035_desc, 
       g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae041_desc,g_imae_m.imae042,g_imae_m.imae042_desc, 
       g_imae_m.imae051,g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078, 
       g_imae_m.imae079,g_imae_m.imae080,g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073, 
       g_imae_m.imae074,g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae081_desc,g_imae_m.imae082,g_imae_m.imae083, 
       g_imae_m.imae084,g_imae_m.imae085,g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae101_desc, 
       g_imae_m.imae102,g_imae_m.imae102_desc,g_imae_m.imae103,g_imae_m.imae103_desc,g_imae_m.imae104, 
       g_imae_m.imae104_desc
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aimm205_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aimm205_delete()
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
   IF g_imae_m.imae001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_imae001_t = g_imae_m.imae001
 
   
   
 
   OPEN aimm205_cl USING g_enterprise, g_site,g_imae_m.imae001
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimm205_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimm205_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimm205_master_referesh USING g_site,g_imae_m.imae001 INTO g_imae_m.imae001,g_imae_m.imae011, 
       g_imae_m.imae012,g_imae_m.imaeownid,g_imae_m.imaeowndp,g_imae_m.imaecrtid,g_imae_m.imaecrtdp, 
       g_imae_m.imaecrtdt,g_imae_m.imaemodid,g_imae_m.imaemoddt,g_imae_m.imae013,g_imae_m.imae014,g_imae_m.imae015, 
       g_imae_m.imae023,g_imae_m.imae016,g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020, 
       g_imae_m.imae021,g_imae_m.imae031,g_imae_m.imae037,g_imae_m.imae032,g_imae_m.imae033,g_imae_m.imae034, 
       g_imae_m.imae035,g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae042,g_imae_m.imae051, 
       g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078,g_imae_m.imae079, 
       g_imae_m.imae080,g_imae_m.imae086,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073,g_imae_m.imae074, 
       g_imae_m.imae075,g_imae_m.imae081,g_imae_m.imae082,g_imae_m.imae083,g_imae_m.imae084,g_imae_m.imae085, 
       g_imae_m.imae091,g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae102,g_imae_m.imae103,g_imae_m.imae104, 
       g_imae_m.imae011_desc,g_imae_m.imae012_desc,g_imae_m.imaeownid_desc,g_imae_m.imaeowndp_desc,g_imae_m.imaecrtid_desc, 
       g_imae_m.imaecrtdp_desc,g_imae_m.imaemodid_desc,g_imae_m.imae016_desc,g_imae_m.imae032_desc,g_imae_m.imae033_desc, 
       g_imae_m.imae035_desc,g_imae_m.imae081_desc
   
   
   #檢查是否允許此動作
   IF NOT aimm205_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imae_m_mask_o.* =  g_imae_m.*
   CALL aimm205_imae_t_mask()
   LET g_imae_m_mask_n.* =  g_imae_m.*
   
   #將最新資料顯示到畫面上
   CALL aimm205_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimm205_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM imae_t 
       WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_imae_m.imae001 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imae_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aimm205_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aimm205_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aimm205_browser_fill(g_wc,"")
         CALL aimm205_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimm205_cl
 
   #功能已完成,通報訊息中心
   CALL aimm205_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimm205_ui_browser_refresh()
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
      IF g_browser[l_i].b_imae001 = g_imae_m.imae001
 
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
 
{<section id="aimm205.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimm205_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("imae001",TRUE)
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
 
{<section id="aimm205.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimm205_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imae001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #若g_site<>'ALL'，則呼叫s_aooi090_set_no_entry，設定為集團一致的欄位不可輸入
   IF g_site <> 'ALL' THEN
      CALL s_aooi090_set_no_entry('2')  #'1' 據點製造資料
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimm205_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimm205.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimm205_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimm205.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimm205_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization" 
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
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
      LET ls_wc = ls_wc, " imae001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " imae001 = '", g_argv[02], "' AND "
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
      LET g_wc = g_wc , " AND imaesite = '",g_argv[01],"' "
   END IF  
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimm205.mask_functions" >}
&include "erp/aim/aimm205_mask.4gl"
 
{</section>}
 
{<section id="aimm205.state_change" >}
   
 
{</section>}
 
{<section id="aimm205.signature" >}
   
 
{</section>}
 
{<section id="aimm205.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimm205_set_pk_array()
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
   LET g_pk_array[1].values = g_imae_m.imae001
   LET g_pk_array[1].column = 'imae001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimm205.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aimm205.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimm205_msgcentre_notify(lc_state)
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
   CALL aimm205_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imae_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimm205.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimm205_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimm205.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION aimm205_b_imaa009_ref(p_imaa009)
DEFINE p_imaa009      LIKE imaa_t.imaa009
DEFINE r_imaa009_desc LIKE rtaxl_t.rtaxl003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imaa009
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_lang||"'","") RETURNING g_rtn_fields
      LET r_imaa009_desc = '',g_rtn_fields[1],''
      RETURN r_imaa009_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aimm205_b_imae001_ref(p_imae001)
DEFINE p_imae001   LIKE imae_t.imae001
DEFINE r_imaal003  LIKE imaal_t.imaal003
DEFINE r_imaal004  LIKE imaal_t.imaal004
DEFINE r_imaa009   LIKE imaa_t.imaa009
DEFINE r_imaa003   LIKE imaa_t.imaa003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imae001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imaal003 = '',g_rtn_fields[1],''
      LET r_imaal004 = '',g_rtn_fields[2],''
      
      LET r_imaa009 = NULL
      LET r_imaa003 = NULL
      SELECT imaa009,imaa003 INTO r_imaa009,r_imaa003
        FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_imae001
      RETURN r_imaal003,r_imaal004,r_imaa009,r_imaa003
      
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imaa003_ref(p_imaa003)
DEFINE p_imaa003       LIKE imaa_t.imaa003
DEFINE r_imaa003_desc  LIKE imckl_t.imckl003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imaa003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imaa003_desc = g_rtn_fields[1]
      RETURN r_imaa003_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_b_imaa003_ref(p_imaa003)
DEFINE p_imaa003      LIKE imaa_t.imaa003
DEFINE r_imaa003_desc LIKE imckl_t.imckl003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imaa003
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='200' AND oocql002=? AND oocql003='"||g_lang||"'","") RETURNING g_rtn_fields
      LET r_imaa003_desc = '',g_rtn_fields[1],''
      RETURN r_imaa003_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imaa006_ref(p_imaa006)
DEFINE p_imaa006      LIKE imaa_t.imaa006
DEFINE r_imaa006_desc LIKE oocal_t.oocal003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imaa006
      CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imaa006_desc = g_rtn_fields[1]
      RETURN r_imaa006_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae081_ref(p_imae081)
DEFINE p_imae081      LIKE imae_t.imae081
DEFINE r_imae081_desc LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imae081
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imae081_desc = g_rtn_fields[1]
       RETURN r_imae081_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae042_ref(p_imae041,p_imae042)
DEFINE p_imae041      LIKE imae_t.imae041
DEFINE p_imae042      LIKE imae_t.imae042
DEFINE r_imae042_desc LIKE inab_t.inab003

       IF cl_null(p_imae042) THEN
          LET p_imae042 = ' '
       END IF
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imae042
       IF g_site = 'ALL' THEN
          CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site_t||"' AND inab001='" ||p_imae041||"' AND inab002=? ","") RETURNING g_rtn_fields
       ELSE
          CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site||"' AND inab001='" ||p_imae041||"' AND inab002=? ","") RETURNING g_rtn_fields
       END IF
       LET r_imae042_desc = g_rtn_fields[1] 
       RETURN r_imae042_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae011_ref(p_imae011)
DEFINE p_imae011      LIKE imae_t.imae011
DEFINE r_imae011_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imae011
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='204' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imae011_desc = g_rtn_fields[1]
      RETURN r_imae011_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae012_ref(p_imae012)
DEFINE p_imae012      LIKE imae_t.imae012
DEFINE r_imae012_desc LIKE oofa_t.oofa011

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imae012
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET r_imae012_desc =  g_rtn_fields[1]
      RETURN r_imae012_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae016_ref(p_imae016)
DEFINE p_imae016      LIKE imae_t.imae016
DEFINE r_imae016_desc LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imae016
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imae016_desc = g_rtn_fields[1]
       RETURN r_imae016_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_imaa009_ref(p_imaa009)
DEFINE p_imaa009       LIKE imaa_t.imaa009
DEFINE r_imaa009_desc  LIKE rtaxl_t.rtaxl003

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imaa009
      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imaa009_desc = g_rtn_fields[1]
      RETURN r_imaa009_desc
      
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imaa010_ref(p_imaa010)
DEFINE p_imaa010      LIKE imaa_t.imaa010
DEFINE r_imaa010_desc LIKE oocql_t.oocql004

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imaa010
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imaa010_desc= g_rtn_fields[1]
      RETURN r_imaa010_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae001_ref(p_imae001)
DEFINE p_imae001   LIKE imae_t.imae001
DEFINE r_imaal003  LIKE imaal_t.imaal003
DEFINE r_imaal004  LIKE imaal_t.imaal004
DEFINE r_imaal005  LIKE imaal_t.imaal005
DEFINE r_imaa009   LIKE imaa_t.imaa009
DEFINE r_imaa003   LIKE imaa_t.imaa003
DEFINE r_imaa004   LIKE imaa_t.imaa004
DEFINE r_imaa005   LIKE imaa_t.imaa005
DEFINE r_imaa006   LIKE imaa_t.imaa006
DEFINE r_imaa010   LIKE imaa_t.imaa010
DEFINE r_imaastus  LIKE imaa_t.imaastus
DEFINE r_imaf012   LIKE imaf_t.imaf012
DEFINE r_imaf013   LIKE imaf_t.imaf013
DEFINE r_imaf014   LIKE imaf_t.imaf014
DEFINE r_imaa002   LIKE imaa_t.imaa002

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_imae001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004,imaal005 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET r_imaal003 =  g_rtn_fields[1]
      LET r_imaal004 =  g_rtn_fields[2]
      LET r_imaal005 =  g_rtn_fields[3]
      
      LET r_imaa002 = NULL
      LET r_imaa009 = NULL
      LET r_imaa003 = NULL
      LET r_imaa004 = NULL
      LET r_imaa005 = NULL
      LET r_imaa006 = NULL
      LET r_imaa010 = NULL
      LET r_imaastus = NULL
      SELECT imaa002,imaa009,imaa003,imaa004,imaa005,imaa006,imaa010,imaastus INTO r_imaa002,r_imaa009,r_imaa003,r_imaa004,r_imaa005,r_imaa006,r_imaa010,r_imaastus
        FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_imae001
        
      LET r_imaf012 = NULL
      LET r_imaf013 = NULL
      LET r_imaf014 = NULL
      SELECT imaf012,imaf013,imaf014 INTO r_imaf012,r_imaf013,r_imaf014 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = p_imae001
      
      RETURN r_imaal003,r_imaal004,r_imaal005,r_imaa002,r_imaa009,r_imaa003,r_imaa004,r_imaa005,r_imaa006,r_imaa010,
             r_imaastus,r_imaf012,r_imaf013,r_imaf014
      
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae031_ref(p_imae031)
DEFINE p_imae031      LIKE imae_t.imae031
DEFINE r_imae031_desc LIKE oobxl_t.oobxl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imae031
       CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imae031_desc = g_rtn_fields[1]
       RETURN r_imae031_desc
       
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae041_chk(p_imae041)
DEFINE p_imae041      LIKE imae_t.imae041
DEFINE r_success      LIKE type_t.num5

       LET r_success = TRUE
       IF NOT cl_null(p_imae041) THEN
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
 
          #設定g_chkparam.*的參數
          IF g_site = 'ALL' THEN
             LET g_chkparam.where = " inaasite = '",g_site_t,"' "
          ELSE
             LET g_chkparam.where = " inaasite = '",g_site,"' "
          END IF
          LET g_chkparam.arg1 = p_imae041
          #160318-00025#2--add--str
          LET g_errshow = TRUE 
          LET g_chkparam.err_str[1] = "aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
          #160318-00025#2--add--end
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_inaa001_3") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          
       END IF
       RETURN r_success

       
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae041_ref(p_imae041)
DEFINE p_imae041      LIKE imae_t.imae041
DEFINE r_imae041_desc LIKE inayl_t.inayl003

       IF g_site = 'ALL' THEN
          CALL s_desc_get_stock_desc(g_site_t,p_imae041) RETURNING r_imae041_desc
       ELSE
          CALL s_desc_get_stock_desc(g_site,p_imae041) RETURNING r_imae041_desc
       END IF
       
       RETURN r_imae041_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae042_chk(p_imae041,p_imae042)
DEFINE p_imae041      LIKE imae_t.imae041
DEFINE p_imae042      LIKE imae_t.imae042
DEFINE r_success      LIKE type_t.num5

       LET r_success = TRUE
       IF cl_null(p_imae042) THEN
          LET p_imae042 = ' '
       END IF
       IF NOT cl_null(p_imae041) THEN
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
 
          IF g_site = 'ALL' THEN
             LET g_chkparam.where = " inabsite = '",g_site_t,"' "
          ELSE   
             LET g_chkparam.where = " inabsite = '",g_site,"' "
          END IF
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_imae041
          LET g_chkparam.arg2 = p_imae042
          #160318-00025#2--add--str
          LET g_errshow = TRUE 
          LET g_chkparam.err_str[1] = "aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
          #160318-00025#2--add--end
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_inab002_2") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success
       
END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae032_ref(p_imae032)
DEFINE p_imae032      LIKE imae_t.imae032
DEFINE r_imae032_desc LIKE imaal_t.imaal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imae032
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imae032_desc = g_rtn_fields[1]
       RETURN r_imae032_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae034_ref(p_imae034)
DEFINE p_imae034      LIKE imae_t.imae034
DEFINE l_n            LIKE type_t.num5
DEFINE r_imae034_desc LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imae034
       LET l_n = 0
       SELECT COUNT(*) INTO l_n FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = p_imae034 AND ooegstus = 'Y' AND (ooeg006 <= g_today AND (ooeg007 IS NULL OR ooeg007 > g_today))
       IF l_n = 0 THEN
          CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       ELSE
          CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       END IF
       LET r_imae034_desc = g_rtn_fields[1]
       RETURN r_imae034_desc

END FUNCTION
#+
PRIVATE FUNCTION aimm205_imae035_ref(p_imae035)
DEFINE p_imae035      LIKE imae_t.imae035
DEFINE r_imae035_desc LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imae035
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imae035_desc = g_rtn_fields[1]
       RETURN r_imae035_desc

END FUNCTION

PRIVATE FUNCTION aimm205_imae034_chk(p_imae034)
DEFINE p_imae034      LIKE imae_t.imae034   
DEFINE l_n            LIKE type_t.num5
DEFINE l_errno        STRING
DEFINE l_errno1       STRING
DEFINE l_errno2       STRING
DEFINE l_pmaastus     LIKE pmaa_t.pmaastus
DEFINE l_ooeg006      LIKE ooeg_t.ooeg006
DEFINE l_ooeg007      LIKE ooeg_t.ooeg007
DEFINE r_success      LIKE type_t.num5

       LET l_n = 0
       LET l_errno = ''
       LET l_errno1 = ''
       LET l_errno2 = ''
       LET r_success = TRUE
       
       #1.輸入值須存在[T:部門資料檔].[C:部門編號] 且為有效資料
       #2.若值不存在，則繼續檢查須存在[T:交易對象主檔].[C:交易對象編號]且[C:交易對象類型]='1' or '3'的有效資料
       #SELECT COUNT(*) INTO l_n FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = p_imae034 AND ooegstus = 'Y' AND (ooeg006 <= g_today AND (ooeg007 IS NULL OR ooeg007 > g_today))
       #IF l_n = 0 THEN
       #   SELECT COUNT(*) INTO l_n FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = p_imae034 AND pmaastus = 'Y' AND (pmaa002 = '1' OR pmaa002 = '3')
       #   IF l_n = 0 THEN   
       #      LET r_success = FALSE
       #      CALL cl_err(p_imae034,'aim-00148',1)
       #      RETURN r_success
       #   END IF
       #END IF
       
       #先判斷是否存在部門資料檔中
       LET l_pmaastus = ''
       LET l_ooeg006 = ''
       LET l_ooeg007 = ''
       SELECT ooegstus,ooeg006,ooeg007 INTO l_pmaastus,l_ooeg006,l_ooeg007 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = p_imae034   #AND (ooeg006 <= g_today AND (ooeg007 IS NULL OR ooeg007 > g_today))
       CASE
           WHEN SQLCA.SQLCODE=100   LET l_errno1='aoo-00201'
           WHEN l_pmaastus !='Y'    LET l_errno1='abm-00007'
           WHEN l_ooeg006 > g_today LET l_errno1='aim-00191'
           WHEN l_ooeg007 <= g_today LET l_errno1='aim-00191'
       END CASE
       
       ##如果l_errno為空，說明已存在部門資料檔中，不繼續檢查是否存在供應商資料檔裏面
       IF NOT cl_null(l_errno1) THEN
          LET l_pmaastus = ''
          SELECT pmaastus INTO l_pmaastus FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = p_imae034 AND (pmaa002 = '1' OR pmaa002 = '3')
          CASE
              WHEN SQLCA.SQLCODE=100  LET l_errno2='apm-00024'
              WHEN l_pmaastus !='Y'   LET l_errno2='apm-00200'
          END CASE
          
          #輸入的資料既不存在於 部門資料檔 也不存在於交易對象資料檔 中！
          IF l_errno1='aoo-00201' AND l_errno2='apm-00024' THEN
             LET l_errno = 'aim-00148'
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = p_imae034
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             RETURN r_success
          END IF
          
          #不存在部門資料中，存在供應商中但是不是已確認
          IF l_errno1='aoo-00201' AND l_errno2='apm-00200' THEN
             LET l_errno = 'apm-00200'
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = p_imae034
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             RETURN r_success
          END IF
          
          #存在部門資料檔中，但是不在有效日期範圍內，不存在供應商中
          IF l_errno1='aim-00191' THEN  #AND l_errno2='apm-00024' THEN
             LET l_errno = 'aim-00191'
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = p_imae034
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             RETURN r_success
          END IF
          
          #存在部門中的，但是無效，不存在供應商中
          IF l_errno1='abm-00007' THEN  #AND l_errno2='apm-00024' THEN
             LET l_errno = 'sub-01302'  #160318-00005#20 mod  'abm-00007'
             LET r_success = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = l_errno
             LET g_errparam.extend = p_imae034
             #160318-00005#20  --add--str
             LET g_errparam.replace[1] ='aooi125'
             LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
             LET g_errparam.exeprog    ='aooi125'
             #160318-00005#20 --add--end
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             RETURN r_success
          END IF
          
          ##部門無效，供應商也無效
          #IF l_errno1='abm-00007' THEN  #AND l_errno2='apm-00200' THEN
          #   LET l_errno = 'abm-00007'
          #   LET r_success = FALSE
          #   INITIALIZE g_errparam TO NULL
#             LET g_errparam.code = l_errno
#             LET g_errparam.extend = p_imae034
#             LET g_errparam.popup = TRUE
#             CALL cl_err()
          
          #   RETURN r_success
          #END IF
       END IF
              
       RETURN r_success
          
END FUNCTION

PRIVATE FUNCTION aimm205_imae032_chk(p_imae032,p_imae033)
DEFINE p_imae032      LIKE imae_t.imae032  
DEFINE p_imae033      LIKE imae_t.imae033
DEFINE r_success      LIKE type_t.num5

       LET r_success = TRUE
       
       #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
       INITIALIZE g_chkparam.* TO NULL

       ##設定g_chkparam.*的參數
       #LET g_chkparam.arg1 = g_site
       #LET g_chkparam.arg2 = p_imae032
       #LET g_chkparam.arg3 = p_imae033
       #
       ##呼叫檢查存在並帶值的library
       #IF NOT cl_chk_exist("v_ecba002_1") THEN   
       #   LET r_success = FALSE
       #   RETURN r_success
       #END IF
       
       #設定g_chkparam.*的參數
       LET g_chkparam.arg1 = p_imae032
      
       #呼叫檢查存在並帶值的library
       IF cl_chk_exist("v_imaa001") THEN
          IF NOT cl_chk_exist("v_imaf001_14") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       ELSE
          LET r_success = FALSE
          RETURN r_success
       END IF
       
       RETURN r_success
       
END FUNCTION

PRIVATE FUNCTION aimm205_imae033_ref(p_imae033)
DEFINE p_imae033      LIKE imae_t.imae033
DEFINE r_imae033_desc LIKE ecba_t.ecba003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_imae033
       CALL ap_ref_array2(g_ref_fields,"SELECT ecba003 FROM ecba_t WHERE ecbaent='"||g_enterprise||"' AND ecbasite='"||g_site||"' AND ecba001 = '"||g_imae_m.imae032||"' AND ecba002 = ? ","") RETURNING g_rtn_fields
       LET r_imae033_desc = g_rtn_fields[1]
       RETURN r_imae033_desc

END FUNCTION
################################################################################
# Descriptions...: 重新带料件分群资料
# Usage..........: CALL aimm205_get_imcf()
# Date & Author..: 2014/02/17 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm205_get_imcf()
#DEFINE l_imcf    RECORD LIKE imcf_t.*  #161124-00048#2   2016/12/07 By 08734 mark
#161124-00048#2   2016/12/07 By 08734 add(S)
DEFINE l_imcf RECORD  #料件據點生管分群檔
       imcfsite LIKE imcf_t.imcfsite, #營運據點
       imcfent LIKE imcf_t.imcfent, #企業編號
       imcfownid LIKE imcf_t.imcfownid, #資料所有者
       imcfowndp LIKE imcf_t.imcfowndp, #資料所屬部門
       imcfcrtid LIKE imcf_t.imcfcrtid, #資料建立者
       imcfcrtdp LIKE imcf_t.imcfcrtdp, #資料建立部門
       imcfcrtdt LIKE imcf_t.imcfcrtdt, #資料創建日
       imcfmodid LIKE imcf_t.imcfmodid, #資料修改者
       imcfmoddt LIKE imcf_t.imcfmoddt, #最近修改日
       imcfstus LIKE imcf_t.imcfstus, #狀態碼
       imcf011 LIKE imcf_t.imcf011, #生管分群
       imcf012 LIKE imcf_t.imcf012, #計劃員
       imcf013 LIKE imcf_t.imcf013, #生產型態
       imcf014 LIKE imcf_t.imcf014, #領發料機制
       imcf015 LIKE imcf_t.imcf015, #生產損耗率
       imcf016 LIKE imcf_t.imcf016, #生產單位
       imcf017 LIKE imcf_t.imcf017, #生產單位批量
       imcf018 LIKE imcf_t.imcf018, #最小生產量
       imcf019 LIKE imcf_t.imcf019, #生產批量控管方式
       imcf020 LIKE imcf_t.imcf020, #生產超交率
       imcf021 LIKE imcf_t.imcf021, #生產命令展開選項
       imcf022 LIKE imcf_t.imcf022, #工單拆分批量
       imcf023 LIKE imcf_t.imcf023, #必要性質
       imcf031 LIKE imcf_t.imcf031, #預設工單別
       imcf032 LIKE imcf_t.imcf032, #製程料號
       imcf033 LIKE imcf_t.imcf033, #預設製程編號
       imcf034 LIKE imcf_t.imcf034, #預設部門/供應商
       imcf035 LIKE imcf_t.imcf035, #預設成本中心
       imcf036 LIKE imcf_t.imcf036, #允許需求合併生產
       imcf037 LIKE imcf_t.imcf037, #預設BOM特性
       imcf041 LIKE imcf_t.imcf041, #預設入庫庫位
       imcf042 LIKE imcf_t.imcf042, #預設入庫儲位
       imcf051 LIKE imcf_t.imcf051, #標準人工工時
       imcf052 LIKE imcf_t.imcf052, #標準機器工時
       imcf061 LIKE imcf_t.imcf061, #MPS計算
       imcf062 LIKE imcf_t.imcf062, #預設無效天數
       imcf063 LIKE imcf_t.imcf063, #No use
       imcf064 LIKE imcf_t.imcf064, #供給匯整時距
       imcf065 LIKE imcf_t.imcf065, #建議新單量
       imcf066 LIKE imcf_t.imcf066, #預計停產日
       imcf071 LIKE imcf_t.imcf071, #固定生產前置時間
       imcf072 LIKE imcf_t.imcf072, #變動生產前置時間
       imcf073 LIKE imcf_t.imcf073, #變動批量
       imcf074 LIKE imcf_t.imcf074, #QC前置時間
       imcf075 LIKE imcf_t.imcf075, #累計前置時間
       imcf076 LIKE imcf_t.imcf076, #嚴守交期前置時間
       imcf077 LIKE imcf_t.imcf077, #計劃批次移轉量
       imcf078 LIKE imcf_t.imcf078, #物規劃移轉時間
       imcf079 LIKE imcf_t.imcf079, #主料需求保留天數
       imcf080 LIKE imcf_t.imcf080, #關鍵物料
       imcf081 LIKE imcf_t.imcf081, #發料單位
       imcf082 LIKE imcf_t.imcf082, #發料單位批量
       imcf083 LIKE imcf_t.imcf083, #最小發料數量
       imcf084 LIKE imcf_t.imcf084, #發料批量控管方式
       imcf085 LIKE imcf_t.imcf085, #發料調整時間
       imcf091 LIKE imcf_t.imcf091, #倒扣料
       imcf092 LIKE imcf_t.imcf092, #發料前調整
       imcf101 LIKE imcf_t.imcf101, #預設發料庫位
       imcf102 LIKE imcf_t.imcf102, #預設發料儲位
       imcf103 LIKE imcf_t.imcf103, #預設退料庫位
       imcf104 LIKE imcf_t.imcf104, #預設退料儲位
       imcf086 LIKE imcf_t.imcf086 #庫存可混批供給
END RECORD
#161124-00048#2   2016/12/07 By 08734 add(E)

   INITIALIZE l_imcf.* TO NULL
   
   #SELECT * INTO l_imcf.* FROM imcf_t  #161124-00048#2   2016/12/07 By 08734 mark
   SELECT imcfsite,imcfent,imcfownid,imcfowndp,imcfcrtid,imcfcrtdp,imcfcrtdt,imcfmodid,imcfmoddt,imcfstus,imcf011,imcf012,imcf013,imcf014,imcf015,imcf016,imcf017,imcf018,imcf019,imcf020,imcf021,imcf022,imcf023,  #161124-00048#2   2016/12/07 By 08734 add
       imcf031,imcf032,imcf033,imcf034,imcf035,imcf036,imcf037,imcf041,imcf042,imcf051,imcf052,imcf061,imcf062,imcf063,imcf064,imcf065,imcf066,imcf071,imcf072,imcf073,imcf074,imcf075,imcf076,imcf077,imcf078,imcf079,imcf080,imcf081,imcf082,imcf083,imcf084,imcf085,imcf091,imcf092,imcf101,imcf102,imcf103,imcf104,imcf086 
     INTO l_imcf.* FROM imcf_t
    WHERE imcfent = g_enterprise
      AND imcfsite = g_site
      AND imcf011 = g_imae_m.imae011
   IF g_site = 'ALL' THEN
      LET g_imae_m.imae012 = l_imcf.imcf012
      LET g_imae_m.imae013 = l_imcf.imcf013
      LET g_imae_m.imae014 = l_imcf.imcf014
      LET g_imae_m.imae015 = l_imcf.imcf015
      LET g_imae_m.imae016 = l_imcf.imcf016
      LET g_imae_m.imae017 = l_imcf.imcf017
      LET g_imae_m.imae018 = l_imcf.imcf018
      LET g_imae_m.imae019 = l_imcf.imcf019
      LET g_imae_m.imae020 = l_imcf.imcf020
      LET g_imae_m.imae021 = l_imcf.imcf021
      LET g_imae_m.imae023 = l_imcf.imcf023
      
      LET g_imae_m.imae031 = l_imcf.imcf031
      LET g_imae_m.imae037 = l_imcf.imcf037
      LET g_imae_m.imae032 = l_imcf.imcf032
      LET g_imae_m.imae033 = l_imcf.imcf033
      LET g_imae_m.imae034 = l_imcf.imcf034
      LET g_imae_m.imae035 = l_imcf.imcf035
      LET g_imae_m.imae022 = l_imcf.imcf022
      LET g_imae_m.imae036 = l_imcf.imcf036
      LET g_imae_m.imae041 = l_imcf.imcf041
      LET g_imae_m.imae042 = l_imcf.imcf042
      LET g_imae_m.imae051 = l_imcf.imcf051
      LET g_imae_m.imae052 = l_imcf.imcf052
      LET g_imae_m.imae062 = l_imcf.imcf062
      LET g_imae_m.imae064 = l_imcf.imcf064
      LET g_imae_m.imae077 = l_imcf.imcf077
      LET g_imae_m.imae078 = l_imcf.imcf078
      LET g_imae_m.imae079 = l_imcf.imcf079
      LET g_imae_m.imae080 = l_imcf.imcf080
      LET g_imae_m.imae071 = l_imcf.imcf071
      LET g_imae_m.imae072 = l_imcf.imcf072
      LET g_imae_m.imae073 = l_imcf.imcf073
      LET g_imae_m.imae074 = l_imcf.imcf074
      LET g_imae_m.imae075 = l_imcf.imcf075
      LET g_imae_m.imae081 = l_imcf.imcf081
      LET g_imae_m.imae082 = l_imcf.imcf082
      LET g_imae_m.imae083 = l_imcf.imcf083
      LET g_imae_m.imae084 = l_imcf.imcf084
      LET g_imae_m.imae085 = l_imcf.imcf085
      LET g_imae_m.imae091 = l_imcf.imcf091
      LET g_imae_m.imae092 = l_imcf.imcf092
      LET g_imae_m.imae101 = l_imcf.imcf101
      LET g_imae_m.imae102 = l_imcf.imcf102
      LET g_imae_m.imae103 = l_imcf.imcf103
      LET g_imae_m.imae104 = l_imcf.imcf104
      LET g_imae_m.imae086 = l_imcf.imcf086    #161015-00001#3   2016/10/19 By 08734
   ELSE
      IF NOT aimm205_chk_ooeh('imae012') THEN
         LET g_imae_m.imae012 = l_imcf.imcf012
      END IF
      IF NOT aimm205_chk_ooeh('imae013') THEN
         LET g_imae_m.imae013 = l_imcf.imcf013
      END IF
      IF NOT aimm205_chk_ooeh('imae014') THEN
         LET g_imae_m.imae014 = l_imcf.imcf014
      END IF
      IF NOT aimm205_chk_ooeh('imae015') THEN
         LET g_imae_m.imae015 = l_imcf.imcf015
      END IF
      IF NOT aimm205_chk_ooeh('imae016') THEN
         LET g_imae_m.imae016 = l_imcf.imcf016
      END IF
      IF NOT aimm205_chk_ooeh('imae017') THEN
         LET g_imae_m.imae017 = l_imcf.imcf017
      END IF
      IF NOT aimm205_chk_ooeh('imae018') THEN
         LET g_imae_m.imae018 = l_imcf.imcf018
      END IF
      IF NOT aimm205_chk_ooeh('imae019') THEN
         LET g_imae_m.imae019 = l_imcf.imcf019
      END IF
      IF NOT aimm205_chk_ooeh('imae020') THEN
         LET g_imae_m.imae020 = l_imcf.imcf020
      END IF
      IF NOT aimm205_chk_ooeh('imae021') THEN
         LET g_imae_m.imae021 = l_imcf.imcf021
      END IF
      IF NOT aimm205_chk_ooeh('imae023') THEN
         LET g_imae_m.imae023 = l_imcf.imcf023
      END IF
      IF NOT aimm205_chk_ooeh('imae031') THEN
         LET g_imae_m.imae031 = l_imcf.imcf031
      END IF
      IF NOT aimm205_chk_ooeh('imae037') THEN
         LET g_imae_m.imae037 = l_imcf.imcf037
      END IF
      IF NOT aimm205_chk_ooeh('imae032') THEN
         LET g_imae_m.imae032 = l_imcf.imcf032
      END IF
      IF NOT aimm205_chk_ooeh('imae033') THEN
         LET g_imae_m.imae033 = l_imcf.imcf033
      END IF
      IF NOT aimm205_chk_ooeh('imae034') THEN
         LET g_imae_m.imae034 = l_imcf.imcf034
      END IF
      IF NOT aimm205_chk_ooeh('imae035') THEN
         LET g_imae_m.imae035 = l_imcf.imcf035
      END IF
      IF NOT aimm205_chk_ooeh('imae022') THEN
         LET g_imae_m.imae022 = l_imcf.imcf022
      END IF
      IF NOT aimm205_chk_ooeh('imae036') THEN
         LET g_imae_m.imae036 = l_imcf.imcf036
      END IF
      IF NOT aimm205_chk_ooeh('imae041') THEN
         LET g_imae_m.imae041 = l_imcf.imcf041
      END IF
      IF NOT aimm205_chk_ooeh('imae042') THEN
         LET g_imae_m.imae042 = l_imcf.imcf042
      END IF
      IF NOT aimm205_chk_ooeh('imae051') THEN
         LET g_imae_m.imae051 = l_imcf.imcf051
      END IF
      IF NOT aimm205_chk_ooeh('imae052') THEN
         LET g_imae_m.imae052 = l_imcf.imcf052
      END IF
      IF NOT aimm205_chk_ooeh('imae062') THEN
         LET g_imae_m.imae062 = l_imcf.imcf062
      END IF
      IF NOT aimm205_chk_ooeh('imae064') THEN
         LET g_imae_m.imae064 = l_imcf.imcf064
      END IF
      IF NOT aimm205_chk_ooeh('imae077') THEN
         LET g_imae_m.imae077 = l_imcf.imcf077
      END IF
      IF NOT aimm205_chk_ooeh('imae078') THEN
         LET g_imae_m.imae078 = l_imcf.imcf078
      END IF
      IF NOT aimm205_chk_ooeh('imae079') THEN
         LET g_imae_m.imae079 = l_imcf.imcf079
      END IF
      IF NOT aimm205_chk_ooeh('imae080') THEN
         LET g_imae_m.imae080 = l_imcf.imcf080
      END IF
      IF NOT aimm205_chk_ooeh('imae071') THEN
         LET g_imae_m.imae071 = l_imcf.imcf071
      END IF
      IF NOT aimm205_chk_ooeh('imae072') THEN
         LET g_imae_m.imae072 = l_imcf.imcf072
      END IF
      IF NOT aimm205_chk_ooeh('imae073') THEN
         LET g_imae_m.imae073 = l_imcf.imcf073
      END IF
      IF NOT aimm205_chk_ooeh('imae074') THEN
         LET g_imae_m.imae074 = l_imcf.imcf074
      END IF
      IF NOT aimm205_chk_ooeh('imae075') THEN
         LET g_imae_m.imae075 = l_imcf.imcf075
      END IF
      IF NOT aimm205_chk_ooeh('imae081') THEN
         LET g_imae_m.imae081 = l_imcf.imcf081
      END IF
      IF NOT aimm205_chk_ooeh('imae082') THEN
         LET g_imae_m.imae082 = l_imcf.imcf082
      END IF
      IF NOT aimm205_chk_ooeh('imae083') THEN
         LET g_imae_m.imae083 = l_imcf.imcf083
      END IF
      IF NOT aimm205_chk_ooeh('imae084') THEN
         LET g_imae_m.imae084 = l_imcf.imcf084
      END IF
      IF NOT aimm205_chk_ooeh('imae085') THEN
         LET g_imae_m.imae085 = l_imcf.imcf085
      END IF
      IF NOT aimm205_chk_ooeh('imae091') THEN
         LET g_imae_m.imae091 = l_imcf.imcf091
      END IF
      IF NOT aimm205_chk_ooeh('imae092') THEN
         LET g_imae_m.imae092 = l_imcf.imcf092
      END IF
      IF NOT aimm205_chk_ooeh('imae101') THEN
         LET g_imae_m.imae101 = l_imcf.imcf101
      END IF
      IF NOT aimm205_chk_ooeh('imae102') THEN
         LET g_imae_m.imae102 = l_imcf.imcf102
      END IF
      IF NOT aimm205_chk_ooeh('imae103') THEN
         LET g_imae_m.imae103 = l_imcf.imcf103
      END IF
      IF NOT aimm205_chk_ooeh('imae104') THEN
         LET g_imae_m.imae104 = l_imcf.imcf104
      END IF
      IF NOT aimm205_chk_ooeh('imae086') THEN      #161015-00001#3   2016/10/19 By 08734
         LET g_imae_m.imae086 = l_imcf.imcf086   
      END IF
   END IF
   
   #製程料號若無值時(ex.分群那邊沒設這個欄位)，預設料件編號
   IF cl_null(g_imae_m.imae032) THEN
      LET g_imae_m.imae032 = g_imae_m.imae001
   END IF
   IF cl_null(g_imae_m.imae016) THEN
      LET g_imae_m.imae016 = g_imae_m.imaa006
   END IF
   IF cl_null(g_imae_m.imae081) THEN
      LET g_imae_m.imae081 = g_imae_m.imaa006
   END IF
   

   DISPLAY BY NAME g_imae_m.imae012,g_imae_m.imae013,g_imae_m.imae014, 
     g_imae_m.imae015,g_imae_m.imae016,g_imae_m.imae017,g_imae_m.imae018,g_imae_m.imae019,g_imae_m.imae020, 
     g_imae_m.imae021,g_imae_m.imae023,g_imae_m.imae031,g_imae_m.imae033,g_imae_m.imae037,g_imae_m.imae034,g_imae_m.imae032, 
     g_imae_m.imae035,g_imae_m.imae022,g_imae_m.imae036,g_imae_m.imae041,g_imae_m.imae042,g_imae_m.imae051, 
     g_imae_m.imae052,g_imae_m.imae062,g_imae_m.imae064,g_imae_m.imae077,g_imae_m.imae078,g_imae_m.imae079, 
     g_imae_m.imae080,g_imae_m.imae071,g_imae_m.imae072,g_imae_m.imae073,g_imae_m.imae074,g_imae_m.imae075, 
     g_imae_m.imae081,g_imae_m.imae082,g_imae_m.imae083,g_imae_m.imae084,g_imae_m.imae085,g_imae_m.imae091, 
     g_imae_m.imae092,g_imae_m.imae101,g_imae_m.imae102,g_imae_m.imae103,g_imae_m.imae104
     
     
   CALL aimm205_imae012_ref(g_imae_m.imae012) RETURNING g_imae_m.imae012_desc
   DISPLAY BY NAME g_imae_m.imae012_desc

   CALL aimm205_imae016_ref(g_imae_m.imae016) RETURNING g_imae_m.imae016_desc
   DISPLAY BY NAME g_imae_m.imae016_desc

   CALL aimm205_imae032_ref(g_imae_m.imae032) RETURNING g_imae_m.imae032_desc
   DISPLAY BY NAME g_imae_m.imae032_desc
   
   CALL aimm205_imae033_ref(g_imae_m.imae033) RETURNING g_imae_m.imae033_desc
   DISPLAY g_imae_m.imae033_desc TO imae033_desc

   CALL aimm205_imae034_ref(g_imae_m.imae034) RETURNING g_imae_m.imae034_desc
   DISPLAY g_imae_m.imae033_desc TO imae034_desc

   CALL aimm205_imae035_ref(g_imae_m.imae035) RETURNING g_imae_m.imae035_desc
   DISPLAY BY NAME g_imae_m.imae035_desc

   CALL aimm205_imae041_ref(g_imae_m.imae041) RETURNING g_imae_m.imae041_desc
   DISPLAY BY NAME g_imae_m.imae041_desc

   CALL aimm205_imae042_ref(g_imae_m.imae041,g_imae_m.imae042) RETURNING g_imae_m.imae042_desc
   DISPLAY BY NAME g_imae_m.imae042_desc

   CALL aimm205_imae081_ref(g_imae_m.imae081) RETURNING g_imae_m.imae081_desc
   DISPLAY BY NAME g_imae_m.imae081_desc

   CALL aimm205_imae041_ref(g_imae_m.imae101) RETURNING g_imae_m.imae101_desc
   DISPLAY BY NAME g_imae_m.imae101_desc

   CALL aimm205_imae042_ref(g_imae_m.imae101,g_imae_m.imae102) RETURNING g_imae_m.imae102_desc
   DISPLAY BY NAME g_imae_m.imae102_desc

   CALL aimm205_imae041_ref(g_imae_m.imae103) RETURNING g_imae_m.imae103_desc
   DISPLAY BY NAME g_imae_m.imae103_desc

   CALL aimm205_imae042_ref(g_imae_m.imae103,g_imae_m.imae104) RETURNING g_imae_m.imae104_desc
   DISPLAY BY NAME g_imae_m.imae104_desc
END FUNCTION
################################################################################
# Descriptions...:檢查aooi090是否設置對應欄位
# Memo...........:
# Usage..........: CALL aimm205_chk_ooeh(p_ooeh002)
# Date & Author..: 2014/02/114 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION aimm205_chk_ooeh(p_ooeh002)
DEFINE p_ooeh002        LIKE ooeh_t.ooeh002
DEFINE r_success        LIKE type_t.num5
DEFINE l_n              LIKE type_t.num5

   LET r_success = TRUE
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM ooeh_t
    WHERE ooehent = g_enterprise
      AND ooeh001 = '2'
      AND ooeh002 = p_ooeh002
   IF l_n = 0 THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success

END FUNCTION

 
{</section>}
 
