#該程式未解開Section, 採用最新樣板產出!
{<section id="afat420.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2015-04-22 10:33:57), PR版次:0012(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000342
#+ Filename...: afat420
#+ Description: 資產變更作業
#+ Creator....: ()
#+ Modifier...: 02003 -SD/PR- 00000
 
{</section>}
 
{<section id="afat420.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#151125-00001#1    2015/11/27  BY fionchen    執行[作廢]作業時,增加詢問「是否執行作廢？」
#160318-00025#5    2016/04/14  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160812-00017#7    2016/08/16  By 06137       在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#8    2016/08/24  by 08172       修改删除时重新检查状态
#161024-00008#3    2016/10/16  By Hans        AFA組織類型與職能開窗清單調整。
#161017-00023#1    2016/10/26  By 02114       权限调整
#161111-00028#7    2016/11/23  by 02481       标准程式定义采用宣告模式,弃用.*写法
#161111-00049#11   2016/11/28  By 01531       二阶段FA问题7~14 调整作业:afap200/afat300/afat400/afat410/afat420/afat421/afat430/afat440
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
PRIVATE TYPE type_g_fabe_m RECORD
       fabe001 LIKE fabe_t.fabe001, 
   fabe002 LIKE fabe_t.fabe002, 
   fabe000 LIKE fabe_t.fabe000, 
   fabe003 LIKE fabe_t.fabe003, 
   fabe004 LIKE fabe_t.fabe004, 
   fabe045 LIKE fabe_t.fabe045, 
   fabe006 LIKE fabe_t.fabe006, 
   fabe006_desc LIKE type_t.chr80, 
   fabe007 LIKE fabe_t.fabe007, 
   fabe007_desc LIKE type_t.chr80, 
   fabe005 LIKE fabe_t.fabe005, 
   fabe008 LIKE fabe_t.fabe008, 
   fabe008_desc LIKE type_t.chr80, 
   fabestus LIKE fabe_t.fabestus, 
   fabe014 LIKE fabe_t.fabe014, 
   fabe015 LIKE fabe_t.fabe015, 
   fabe016 LIKE fabe_t.fabe016, 
   fabe042 LIKE fabe_t.fabe042, 
   fabe017 LIKE fabe_t.fabe017, 
   fabe017_desc LIKE type_t.chr80, 
   fabe018 LIKE fabe_t.fabe018, 
   fabe019 LIKE fabe_t.fabe019, 
   fabe020 LIKE fabe_t.fabe020, 
   fabe020_desc LIKE type_t.chr80, 
   fabe021 LIKE fabe_t.fabe021, 
   fabe022 LIKE fabe_t.fabe022, 
   fabe023 LIKE fabe_t.fabe023, 
   fabe024 LIKE fabe_t.fabe024, 
   fabe025 LIKE fabe_t.fabe025, 
   fabe025_desc LIKE type_t.chr80, 
   fabe026 LIKE fabe_t.fabe026, 
   fabe026_desc LIKE type_t.chr80, 
   fabe027 LIKE fabe_t.fabe027, 
   fabe027_desc LIKE type_t.chr80, 
   fabe028 LIKE fabe_t.fabe028, 
   fabe028_desc LIKE type_t.chr80, 
   fabe029 LIKE fabe_t.fabe029, 
   fabe029_desc LIKE type_t.chr80, 
   fabe030 LIKE fabe_t.fabe030, 
   fabe030_desc LIKE type_t.chr80, 
   fabe031 LIKE fabe_t.fabe031, 
   fabe031_desc LIKE type_t.chr80, 
   fabe032 LIKE fabe_t.fabe032, 
   fabe032_desc LIKE type_t.chr80, 
   fabe033 LIKE fabe_t.fabe033, 
   fabe009 LIKE fabe_t.fabe009, 
   fabe009_desc LIKE type_t.chr80, 
   fabe010 LIKE fabe_t.fabe010, 
   fabe010_desc LIKE type_t.chr80, 
   fabe011 LIKE fabe_t.fabe011, 
   fabe011_desc LIKE type_t.chr80, 
   fabe012 LIKE fabe_t.fabe012, 
   fabe013 LIKE fabe_t.fabe013, 
   fabe034 LIKE fabe_t.fabe034, 
   fabe035 LIKE fabe_t.fabe035, 
   fabe036 LIKE fabe_t.fabe036, 
   fabe037 LIKE fabe_t.fabe037, 
   fabe043 LIKE fabe_t.fabe043, 
   fabe044 LIKE fabe_t.fabe044, 
   fabe041 LIKE fabe_t.fabe041, 
   fabe038 LIKE fabe_t.fabe038, 
   fabe039 LIKE fabe_t.fabe039, 
   fabe040 LIKE fabe_t.fabe040, 
   fabeownid LIKE fabe_t.fabeownid, 
   fabeownid_desc LIKE type_t.chr80, 
   fabeowndp LIKE fabe_t.fabeowndp, 
   fabeowndp_desc LIKE type_t.chr80, 
   fabecrtid LIKE fabe_t.fabecrtid, 
   fabecrtid_desc LIKE type_t.chr80, 
   fabecrtdp LIKE fabe_t.fabecrtdp, 
   fabecrtdp_desc LIKE type_t.chr80, 
   fabecrtdt LIKE fabe_t.fabecrtdt, 
   fabemodid LIKE fabe_t.fabemodid, 
   fabemodid_desc LIKE type_t.chr80, 
   fabemoddt LIKE fabe_t.fabemoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_fabe000 LIKE fabe_t.fabe000,
      b_fabe001 LIKE fabe_t.fabe001,
      b_fabe003 LIKE fabe_t.fabe003,
      b_fabe004 LIKE fabe_t.fabe004,
      b_fabe045 LIKE fabe_t.fabe045
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fabf009             LIKE fabf_t.fabf009
DEFINE g_flag                LIKE type_t.chr1
DEFINE g_ooef017             LIKE ooef_t.ooef017  #161111-00049#11
#end add-point
 
#模組變數(Module Variables)
DEFINE g_fabe_m        type_g_fabe_m  #單頭變數宣告
DEFINE g_fabe_m_t      type_g_fabe_m  #單頭舊值宣告(系統還原用)
DEFINE g_fabe_m_o      type_g_fabe_m  #單頭舊值宣告(其他用途)
DEFINE g_fabe_m_mask_o type_g_fabe_m  #轉換遮罩前資料
DEFINE g_fabe_m_mask_n type_g_fabe_m  #轉換遮罩後資料
 
   DEFINE g_fabe001_t LIKE fabe_t.fabe001
DEFINE g_fabe000_t LIKE fabe_t.fabe000
DEFINE g_fabe003_t LIKE fabe_t.fabe003
DEFINE g_fabe004_t LIKE fabe_t.fabe004
DEFINE g_fabe045_t LIKE fabe_t.fabe045
 
   
 
   
 
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
 
{<section id="afat420.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fabe001,fabe002,fabe000,fabe003,fabe004,fabe045,fabe006,'',fabe007,'', 
       fabe005,fabe008,'',fabestus,fabe014,fabe015,fabe016,fabe042,fabe017,'',fabe018,fabe019,fabe020, 
       '',fabe021,fabe022,fabe023,fabe024,fabe025,'',fabe026,'',fabe027,'',fabe028,'',fabe029,'',fabe030, 
       '',fabe031,'',fabe032,'',fabe033,fabe009,'',fabe010,'',fabe011,'',fabe012,fabe013,fabe034,fabe035, 
       fabe036,fabe037,fabe043,fabe044,fabe041,fabe038,fabe039,fabe040,fabeownid,'',fabeowndp,'',fabecrtid, 
       '',fabecrtdp,'',fabecrtdt,fabemodid,'',fabemoddt", 
                      " FROM fabe_t",
                      " WHERE fabeent= ? AND fabe000=? AND fabe001=? AND fabe003=? AND fabe004=? AND  
                          fabe045=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat420_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fabe001,t0.fabe002,t0.fabe000,t0.fabe003,t0.fabe004,t0.fabe045,t0.fabe006, 
       t0.fabe007,t0.fabe005,t0.fabe008,t0.fabestus,t0.fabe014,t0.fabe015,t0.fabe016,t0.fabe042,t0.fabe017, 
       t0.fabe018,t0.fabe019,t0.fabe020,t0.fabe021,t0.fabe022,t0.fabe023,t0.fabe024,t0.fabe025,t0.fabe026, 
       t0.fabe027,t0.fabe028,t0.fabe029,t0.fabe030,t0.fabe031,t0.fabe032,t0.fabe033,t0.fabe009,t0.fabe010, 
       t0.fabe011,t0.fabe012,t0.fabe013,t0.fabe034,t0.fabe035,t0.fabe036,t0.fabe037,t0.fabe043,t0.fabe044, 
       t0.fabe041,t0.fabe038,t0.fabe039,t0.fabe040,t0.fabeownid,t0.fabeowndp,t0.fabecrtid,t0.fabecrtdp, 
       t0.fabecrtdt,t0.fabemodid,t0.fabemoddt,t1.faacl003 ,t2.faadl003 ,t3.oocql004 ,t4.oocal003 ,t5.ooail003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.oocql004 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 ,t12.ooefl003 ,t13.ooefl003 , 
       t14.pmaal004 ,t15.pmaal004 ,t16.oocgl003 ,t17.ooag011 ,t18.ooefl003 ,t19.ooag011 ,t20.ooefl003 , 
       t21.ooag011",
               " FROM fabe_t t0",
                              " LEFT JOIN faacl_t t1 ON t1.faaclent="||g_enterprise||" AND t1.faacl001=t0.fabe006 AND t1.faacl002='"||g_dlang||"' ",
               " LEFT JOIN faadl_t t2 ON t2.faadlent="||g_enterprise||" AND t2.faadl001=t0.fabe007 AND t2.faadl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='3903' AND t3.oocql002=t0.fabe008 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.fabe017 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t5 ON t5.ooailent="||g_enterprise||" AND t5.ooail001=t0.fabe020 AND t5.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fabe025  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.fabe026 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='3900' AND t8.oocql002=t0.fabe027 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.fabe028 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.fabe029  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.fabe030 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=t0.fabe031 AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.fabe032 AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t14 ON t14.pmaalent="||g_enterprise||" AND t14.pmaal001=t0.fabe009 AND t14.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t15 ON t15.pmaalent="||g_enterprise||" AND t15.pmaal001=t0.fabe010 AND t15.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t16 ON t16.oocglent="||g_enterprise||" AND t16.oocgl001=t0.fabe011 AND t16.oocgl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t17 ON t17.ooagent="||g_enterprise||" AND t17.ooag001=t0.fabeownid  ",
               " LEFT JOIN ooefl_t t18 ON t18.ooeflent="||g_enterprise||" AND t18.ooefl001=t0.fabeowndp AND t18.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t19 ON t19.ooagent="||g_enterprise||" AND t19.ooag001=t0.fabecrtid  ",
               " LEFT JOIN ooefl_t t20 ON t20.ooeflent="||g_enterprise||" AND t20.ooefl001=t0.fabecrtdp AND t20.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t21 ON t21.ooagent="||g_enterprise||" AND t21.ooag001=t0.fabemodid  ",
 
               " WHERE t0.fabeent = " ||g_enterprise|| " AND t0.fabe000 = ? AND t0.fabe001 = ? AND t0.fabe003 = ? AND t0.fabe004 = ? AND t0.fabe045 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afat420_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afat420 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afat420_init()   
 
      #進入選單 Menu (="N")
      CALL afat420_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afat420
      
   END IF 
   
   CLOSE afat420_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afat420.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afat420_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('fabestus','13','N,Y,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('fabe002','9911') 
   CALL cl_set_combo_scc('fabe005','9903')
   CALL cl_set_combo_scc('fabe015','9914') 
   CALL cl_set_combo_scc('fabe016','9913') 
   CALL cl_set_combo_scc('fabe042','9917') 
   CALL cl_set_combo_scc('fabe034','9905')
   CALL cl_set_combo_scc('fabe035','9906')
   CALL cl_set_combo_scc('fabe036','9907')
   CALL cl_set_combo_scc('fabe037','9908')
   #end add-point
   
   #根據外部參數進行搜尋
   CALL afat420_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="afat420.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afat420_ui_dialog() 
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
   DEFINE l_apca001 LIKE apca_t.apca001
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL afat420_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fabe_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afat420_init()
      END IF
      
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL afat420_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afat420_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afat420_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afat420_set_act_visible()
               CALL afat420_set_act_no_visible()
               IF NOT (g_fabe_m.fabe000 IS NULL
                 OR g_fabe_m.fabe001 IS NULL
                 OR g_fabe_m.fabe003 IS NULL
                 OR g_fabe_m.fabe004 IS NULL
                 OR g_fabe_m.fabe045 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " fabeent = " ||g_enterprise|| " AND",
                                     " fabe000 = '", g_fabe_m.fabe000, "' "
                                     ," AND fabe001 = '", g_fabe_m.fabe001, "' "
                                     ," AND fabe003 = '", g_fabe_m.fabe003, "' "
                                     ," AND fabe004 = '", g_fabe_m.fabe004, "' "
                                     ," AND fabe045 = '", g_fabe_m.fabe045, "' "
 
                  #填到對應位置
                  CALL afat420_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL afat420_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afat420_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL afat420_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL afat420_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL afat420_fetch("L")  
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
                  CALL afat420_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afat420_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat420_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afat420_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               #160818-00017#8 -s by 08172
               CALL afat420_set_act_visible()   
               CALL afat420_set_act_no_visible()
               #160818-00017#8 -e by 08172      
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat420_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               #160818-00017#8 -s by 08172
               CALL afat420_set_act_visible()   
               CALL afat420_set_act_no_visible()
               #160818-00017#8 -e by 08172  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat420_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/afa/afat420_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/afa/afat420_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afat420_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat420_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe025
            LET g_action_choice="prog_fabe025"
            IF cl_auth_chk_act("prog_fabe025") THEN
               
               #add-point:ON ACTION prog_fabe025 name="menu2.prog_fabe025"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fabe_m.fabe025)

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe029
            LET g_action_choice="prog_fabe029"
            IF cl_auth_chk_act("prog_fabe029") THEN
               
               #add-point:ON ACTION prog_fabe029 name="menu2.prog_fabe029"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fabe_m.fabe029)

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe038
            LET g_action_choice="prog_fabe038"
            IF cl_auth_chk_act("prog_fabe038") THEN
               
               #add-point:ON ACTION prog_fabe038 name="menu2.prog_fabe038"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt500'
               LET la_param.param[1] = g_fabe_m.fabe038

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe039
            LET g_action_choice="prog_fabe039"
            IF cl_auth_chk_act("prog_fabe039") THEN
               
               #add-point:ON ACTION prog_fabe039 name="menu2.prog_fabe039"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt570'
               LET la_param.param[1] = g_fabe_m.fabe039

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe040
            LET g_action_choice="prog_fabe040"
            IF cl_auth_chk_act("prog_fabe040") THEN
               
               #add-point:ON ACTION prog_fabe040 name="menu2.prog_fabe040"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               LET l_apca001 = ''
               SELECT apca001 INTO l_apca001
                 FROM apca_t
                WHERE apcaent = g_enterprise
                  AND apcadocno = g_fabe_m.fabe040
                  
               CASE l_apca001
                   WHEN '13'
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt300'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
          
                   WHEN '11'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt310'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '03'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt320'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '15'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt330'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                   WHEN '12' 
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt331'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                  WHEN '22'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[1] = g_fabe_m.fabe040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
               END CASE 
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat420_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat420_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat420_set_pk_array()
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
                  CALL afat420_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL afat420_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afat420_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afat420_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afat420_set_act_visible()
               CALL afat420_set_act_no_visible()
               IF NOT (g_fabe_m.fabe000 IS NULL
                 OR g_fabe_m.fabe001 IS NULL
                 OR g_fabe_m.fabe003 IS NULL
                 OR g_fabe_m.fabe004 IS NULL
                 OR g_fabe_m.fabe045 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " fabeent = " ||g_enterprise|| " AND",
                                     " fabe000 = '", g_fabe_m.fabe000, "' "
                                     ," AND fabe001 = '", g_fabe_m.fabe001, "' "
                                     ," AND fabe003 = '", g_fabe_m.fabe003, "' "
                                     ," AND fabe004 = '", g_fabe_m.fabe004, "' "
                                     ," AND fabe045 = '", g_fabe_m.fabe045, "' "
 
                  #填到對應位置
                  CALL afat420_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL afat420_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afat420_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL afat420_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL afat420_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL afat420_fetch("L")  
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
                  CALL afat420_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afat420_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat420_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afat420_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#8 -s by 08172
               CALL afat420_set_act_visible()   
               CALL afat420_set_act_no_visible()
               #160818-00017#8 -e by 08172  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat420_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#8 -s by 08172
               CALL afat420_set_act_visible()   
               CALL afat420_set_act_no_visible()
               #160818-00017#8 -e by 08172  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat420_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/afa/afat420_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/afa/afat420_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afat420_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat420_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe025
            LET g_action_choice="prog_fabe025"
            IF cl_auth_chk_act("prog_fabe025") THEN
               
               #add-point:ON ACTION prog_fabe025 name="menu.prog_fabe025"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fabe_m.fabe025)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe029
            LET g_action_choice="prog_fabe029"
            IF cl_auth_chk_act("prog_fabe029") THEN
               
               #add-point:ON ACTION prog_fabe029 name="menu.prog_fabe029"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fabe_m.fabe029)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe038
            LET g_action_choice="prog_fabe038"
            IF cl_auth_chk_act("prog_fabe038") THEN
               
               #add-point:ON ACTION prog_fabe038 name="menu.prog_fabe038"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt500'
               LET la_param.param[1] = g_fabe_m.fabe038

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe039
            LET g_action_choice="prog_fabe039"
            IF cl_auth_chk_act("prog_fabe039") THEN
               
               #add-point:ON ACTION prog_fabe039 name="menu.prog_fabe039"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt570'
               LET la_param.param[1] = g_fabe_m.fabe039

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabe040
            LET g_action_choice="prog_fabe040"
            IF cl_auth_chk_act("prog_fabe040") THEN
               
               #add-point:ON ACTION prog_fabe040 name="menu.prog_fabe040"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               LET l_apca001 = ''
               SELECT apca001 INTO l_apca001
                 FROM apca_t
                WHERE apcaent = g_enterprise
                  AND apcadocno = g_fabe_m.fabe040
                  
               CASE l_apca001
                   WHEN '13'
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt300'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
          
                   WHEN '11'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt310'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '03'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt320'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '15'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt330'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                   WHEN '12' 
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt331'
                      LET la_param.param[1] = g_fabe_m.fabe040
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                  WHEN '22'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[1] = g_fabe_m.fabe040
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
               END CASE 
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat420_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat420_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat420_set_pk_array()
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
 
{<section id="afat420.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION afat420_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE  l_comp_str     STRING              #161111-00049#11
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "fabe000,fabe001,fabe003,fabe004,fabe045"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   #161111-00049#11 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","fabe032")
   LET p_wc = p_wc," AND ",l_comp_str 

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","fabe028")
   LET p_wc = p_wc," AND ",l_comp_str
   
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","fabe030")
   LET p_wc = p_wc," AND ",l_comp_str  

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","fabe031")
   LET p_wc = p_wc," AND ",l_comp_str
   #161111-00049#11 add e---      
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM fabe_t ",
               "  ",
               "  ",
               " WHERE fabeent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("fabe_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   
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
   
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_fabe_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.fabestus,t0.fabe000,t0.fabe001,t0.fabe003,t0.fabe004,t0.fabe045",
               " FROM fabe_t t0 ",
               "  ",
               
               " WHERE t0.fabeent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("fabe_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   CALL g_browser.clear()
   LET g_cnt = 1
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabe_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fabe000,g_browser[g_cnt].b_fabe001, 
          g_browser[g_cnt].b_fabe003,g_browser[g_cnt].b_fabe004,g_browser[g_cnt].b_fabe045
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
         
         
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
   
   IF cl_null(g_browser[g_cnt].b_fabe000) THEN
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
   CALL afat420_set_act_visible()
   CALL afat420_set_act_no_visible()
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat420.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat420_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_comp_str     STRING       #161017-00023#1 add lujh
   DEFINE  l_ld_str      STRING              #161111-00049#11
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_fabe_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON fabe001,fabe002,fabe000,fabe003,fabe004,fabe045,fabe006,fabe007,fabe005, 
          fabe008,fabestus,fabe014,fabe015,fabe016,fabe042,fabe017,fabe018,fabe019,fabe020,fabe021,fabe022, 
          fabe023,fabe024,fabe025,fabe026,fabe027,fabe028,fabe029,fabe030,fabe031,fabe032,fabe033,fabe009, 
          fabe010,fabe011,fabe012,fabe013,fabe034,fabe035,fabe036,fabe037,fabe043,fabe044,fabe041,fabe038, 
          fabe039,fabe040,fabeownid,fabeowndp,fabecrtid,fabecrtdp,fabecrtdt,fabemodid,fabemoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fabecrtdt>>----
         AFTER FIELD fabecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fabemoddt>>----
         AFTER FIELD fabemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabecnfdt>>----
         
         #----<<fabepstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.fabe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe001
            #add-point:ON ACTION controlp INFIELD fabe001 name="construct.c.fabe001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #161111-00049#11 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#11 add e--- 			
            CALL q_faah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe001  #顯示到畫面上

            NEXT FIELD fabe001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe001
            #add-point:BEFORE FIELD fabe001 name="construct.b.fabe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe001
            
            #add-point:AFTER FIELD fabe001 name="construct.a.fabe001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe002
            #add-point:BEFORE FIELD fabe002 name="construct.b.fabe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe002
            
            #add-point:AFTER FIELD fabe002 name="construct.a.fabe002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe002
            #add-point:ON ACTION controlp INFIELD fabe002 name="construct.c.fabe002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe000
            #add-point:BEFORE FIELD fabe000 name="construct.b.fabe000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe000
            
            #add-point:AFTER FIELD fabe000 name="construct.a.fabe000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe000
            #add-point:ON ACTION controlp INFIELD fabe000 name="construct.c.fabe000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe003
            #add-point:ON ACTION controlp INFIELD fabe003 name="construct.c.fabe003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #161111-00049#11 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#11 add e--- 			
            CALL q_faah003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe003  #顯示到畫面上

            NEXT FIELD fabe003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe003
            #add-point:BEFORE FIELD fabe003 name="construct.b.fabe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe003
            
            #add-point:AFTER FIELD fabe003 name="construct.a.fabe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe004
            #add-point:ON ACTION controlp INFIELD fabe004 name="construct.c.fabe004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #161111-00049#11 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#11 add e--- 			
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe004  #顯示到畫面上

            NEXT FIELD fabe004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe004
            #add-point:BEFORE FIELD fabe004 name="construct.b.fabe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe004
            
            #add-point:AFTER FIELD fabe004 name="construct.a.fabe004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe045
            #add-point:BEFORE FIELD fabe045 name="construct.b.fabe045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe045
            
            #add-point:AFTER FIELD fabe045 name="construct.a.fabe045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe045
            #add-point:ON ACTION controlp INFIELD fabe045 name="construct.c.fabe045"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabe006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe006
            #add-point:ON ACTION controlp INFIELD fabe006 name="construct.c.fabe006"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#11 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161111-00049#11 add e---        			
            #CALL q_faac001()   #161111-00049#11 mark
            DISPLAY g_qryparam.return1 TO fabe006  #顯示到畫面上

            NEXT FIELD fabe006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe006
            #add-point:BEFORE FIELD fabe006 name="construct.b.fabe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe006
            
            #add-point:AFTER FIELD fabe006 name="construct.a.fabe006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe007
            #add-point:ON ACTION controlp INFIELD fabe007 name="construct.c.fabe007"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #161111-00049#11 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"
			   #161111-00049#11 add e---			
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe007  #顯示到畫面上

            NEXT FIELD fabe007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe007
            #add-point:BEFORE FIELD fabe007 name="construct.b.fabe007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe007
            
            #add-point:AFTER FIELD fabe007 name="construct.a.fabe007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe005
            #add-point:BEFORE FIELD fabe005 name="construct.b.fabe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe005
            
            #add-point:AFTER FIELD fabe005 name="construct.a.fabe005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe005
            #add-point:ON ACTION controlp INFIELD fabe005 name="construct.c.fabe005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabe008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe008
            #add-point:ON ACTION controlp INFIELD fabe008 name="construct.c.fabe008"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '3903'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe008  #顯示到畫面上

            NEXT FIELD fabe008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe008
            #add-point:BEFORE FIELD fabe008 name="construct.b.fabe008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe008
            
            #add-point:AFTER FIELD fabe008 name="construct.a.fabe008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabestus
            #add-point:BEFORE FIELD fabestus name="construct.b.fabestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabestus
            
            #add-point:AFTER FIELD fabestus name="construct.a.fabestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabestus
            #add-point:ON ACTION controlp INFIELD fabestus name="construct.c.fabestus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe014
            #add-point:BEFORE FIELD fabe014 name="construct.b.fabe014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe014
            
            #add-point:AFTER FIELD fabe014 name="construct.a.fabe014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe014
            #add-point:ON ACTION controlp INFIELD fabe014 name="construct.c.fabe014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe015
            #add-point:BEFORE FIELD fabe015 name="construct.b.fabe015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe015
            
            #add-point:AFTER FIELD fabe015 name="construct.a.fabe015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe015
            #add-point:ON ACTION controlp INFIELD fabe015 name="construct.c.fabe015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe016
            #add-point:BEFORE FIELD fabe016 name="construct.b.fabe016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe016
            
            #add-point:AFTER FIELD fabe016 name="construct.a.fabe016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe016
            #add-point:ON ACTION controlp INFIELD fabe016 name="construct.c.fabe016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe042
            #add-point:BEFORE FIELD fabe042 name="construct.b.fabe042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe042
            
            #add-point:AFTER FIELD fabe042 name="construct.a.fabe042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe042
            #add-point:ON ACTION controlp INFIELD fabe042 name="construct.c.fabe042"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabe017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe017
            #add-point:ON ACTION controlp INFIELD fabe017 name="construct.c.fabe017"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe017  #顯示到畫面上

            NEXT FIELD fabe017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe017
            #add-point:BEFORE FIELD fabe017 name="construct.b.fabe017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe017
            
            #add-point:AFTER FIELD fabe017 name="construct.a.fabe017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe018
            #add-point:BEFORE FIELD fabe018 name="construct.b.fabe018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe018
            
            #add-point:AFTER FIELD fabe018 name="construct.a.fabe018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe018
            #add-point:ON ACTION controlp INFIELD fabe018 name="construct.c.fabe018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe019
            #add-point:BEFORE FIELD fabe019 name="construct.b.fabe019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe019
            
            #add-point:AFTER FIELD fabe019 name="construct.a.fabe019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe019
            #add-point:ON ACTION controlp INFIELD fabe019 name="construct.c.fabe019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabe020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe020
            #add-point:ON ACTION controlp INFIELD fabe020 name="construct.c.fabe020"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe020  #顯示到畫面上

            NEXT FIELD fabe020                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe020
            #add-point:BEFORE FIELD fabe020 name="construct.b.fabe020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe020
            
            #add-point:AFTER FIELD fabe020 name="construct.a.fabe020"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe021
            #add-point:BEFORE FIELD fabe021 name="construct.b.fabe021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe021
            
            #add-point:AFTER FIELD fabe021 name="construct.a.fabe021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe021
            #add-point:ON ACTION controlp INFIELD fabe021 name="construct.c.fabe021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe022
            #add-point:BEFORE FIELD fabe022 name="construct.b.fabe022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe022
            
            #add-point:AFTER FIELD fabe022 name="construct.a.fabe022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe022
            #add-point:ON ACTION controlp INFIELD fabe022 name="construct.c.fabe022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe023
            #add-point:BEFORE FIELD fabe023 name="construct.b.fabe023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe023
            
            #add-point:AFTER FIELD fabe023 name="construct.a.fabe023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe023
            #add-point:ON ACTION controlp INFIELD fabe023 name="construct.c.fabe023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe024
            #add-point:BEFORE FIELD fabe024 name="construct.b.fabe024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe024
            
            #add-point:AFTER FIELD fabe024 name="construct.a.fabe024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe024
            #add-point:ON ACTION controlp INFIELD fabe024 name="construct.c.fabe024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabe025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe025
            #add-point:ON ACTION controlp INFIELD fabe025 name="construct.c.fabe025"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe025  #顯示到畫面上

            NEXT FIELD fabe025                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe025
            #add-point:BEFORE FIELD fabe025 name="construct.b.fabe025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe025
            
            #add-point:AFTER FIELD fabe025 name="construct.a.fabe025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe026
            #add-point:ON ACTION controlp INFIELD fabe026 name="construct.c.fabe026"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe026  #顯示到畫面上

            NEXT FIELD fabe026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe026
            #add-point:BEFORE FIELD fabe026 name="construct.b.fabe026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe026
            
            #add-point:AFTER FIELD fabe026 name="construct.a.fabe026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe027
            #add-point:ON ACTION controlp INFIELD fabe027 name="construct.c.fabe027"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '3900'
			LET g_qryparam.where = "( oocq004 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') OR oocq004 IS NULL)" #161111-00049#11
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe027  #顯示到畫面上

            NEXT FIELD fabe027                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe027
            #add-point:BEFORE FIELD fabe027 name="construct.b.fabe027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe027
            
            #add-point:AFTER FIELD fabe027 name="construct.a.fabe027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe028
            #add-point:ON ACTION controlp INFIELD fabe028 name="construct.c.fabe028"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161017-00023#1--add--str--lujh
			   LET g_qryparam.where = l_comp_str     
            CALL q_ooef001()   
            #161017-00023#1--add--end--lujh
            #CALL q_faab001()                      #呼叫開窗      #161017-00023#1 mark lujh
            DISPLAY g_qryparam.return1 TO fabe028  #顯示到畫面上

            NEXT FIELD fabe028                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe028
            #add-point:BEFORE FIELD fabe028 name="construct.b.fabe028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe028
            
            #add-point:AFTER FIELD fabe028 name="construct.a.fabe028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe029
            #add-point:ON ACTION controlp INFIELD fabe029 name="construct.c.fabe029"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe029  #顯示到畫面上

            NEXT FIELD fabe029                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe029
            #add-point:BEFORE FIELD fabe029 name="construct.b.fabe029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe029
            
            #add-point:AFTER FIELD fabe029 name="construct.a.fabe029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe030
            #add-point:ON ACTION controlp INFIELD fabe030 name="construct.c.fabe030"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef207 = 'Y' AND ",l_comp_str     #161017-00023#1 add lujh 
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#3 
            CALL q_ooef001_47()                                  #161024-00008#3 
            DISPLAY g_qryparam.return1 TO fabe030  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD fabe030                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe030
            #add-point:BEFORE FIELD fabe030 name="construct.b.fabe030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe030
            
            #add-point:AFTER FIELD fabe030 name="construct.a.fabe030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe031
            #add-point:ON ACTION controlp INFIELD fabe031 name="construct.c.fabe031"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161017-00023#1--add--str--lujh
			   LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str   
            CALL q_ooef001()   
            #161017-00023#1--add--end--lujh
            #CALL q_ooef001_04()                   #呼叫開窗      #161017-00023#1 mark lujh
            DISPLAY g_qryparam.return1 TO fabe031  #顯示到畫面上

            NEXT FIELD fabe031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe031
            #add-point:BEFORE FIELD fabe031 name="construct.b.fabe031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe031
            
            #add-point:AFTER FIELD fabe031 name="construct.a.fabe031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe032
            #add-point:ON ACTION controlp INFIELD fabe032 name="construct.c.fabe032"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE 
			   LET g_qryparam.where = l_comp_str    #161017-00023#1 add lujh
            #CALL q_ooef001()                           #呼叫開窗  #161024-00008#3
            CALL q_ooef001_2()                                        #161024-00008#3
            DISPLAY g_qryparam.return1 TO fabe032  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD fabe032                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe032
            #add-point:BEFORE FIELD fabe032 name="construct.b.fabe032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe032
            
            #add-point:AFTER FIELD fabe032 name="construct.a.fabe032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe033
            #add-point:BEFORE FIELD fabe033 name="construct.b.fabe033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe033
            
            #add-point:AFTER FIELD fabe033 name="construct.a.fabe033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe033
            #add-point:ON ACTION controlp INFIELD fabe033 name="construct.c.fabe033"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabe009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe009
            #add-point:ON ACTION controlp INFIELD fabe009 name="construct.c.fabe009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #161111-00049#11 mod s--
            #CALL q_pmaa001_10()              #呼叫開窗                                #呼叫開窗
            LET g_qryparam.arg1 = "('1','3')"
            SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_ooef017,"') "
            CALL q_pmaa001_1()               
            #161111-00049#11 mod e--             
            DISPLAY g_qryparam.return1 TO fabe009  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO pmaal004 #交易對象簡稱 

            NEXT FIELD fabe009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe009
            #add-point:BEFORE FIELD fabe009 name="construct.b.fabe009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe009
            
            #add-point:AFTER FIELD fabe009 name="construct.a.fabe009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe010
            #add-point:ON ACTION controlp INFIELD fabe010 name="construct.c.fabe010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.reqry = FALSE
            #161111-00049#11 mod s--
            #CALL q_pmaa001_5()                           #呼叫開窗
            LET g_qryparam.arg1 = "('2','3')"
            SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_ooef017,"') "
            CALL q_pmaa001_1()               
            #161111-00049#11 mod e-- 
            DISPLAY g_qryparam.return1 TO fabe010  #顯示到畫面上

            NEXT FIELD fabe010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe010
            #add-point:BEFORE FIELD fabe010 name="construct.b.fabe010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe010
            
            #add-point:AFTER FIELD fabe010 name="construct.a.fabe010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe011
            #add-point:ON ACTION controlp INFIELD fabe011 name="construct.c.fabe011"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabe011  #顯示到畫面上

            NEXT FIELD fabe011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe011
            #add-point:BEFORE FIELD fabe011 name="construct.b.fabe011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe011
            
            #add-point:AFTER FIELD fabe011 name="construct.a.fabe011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe012
            #add-point:BEFORE FIELD fabe012 name="construct.b.fabe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe012
            
            #add-point:AFTER FIELD fabe012 name="construct.a.fabe012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe012
            #add-point:ON ACTION controlp INFIELD fabe012 name="construct.c.fabe012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe013
            #add-point:BEFORE FIELD fabe013 name="construct.b.fabe013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe013
            
            #add-point:AFTER FIELD fabe013 name="construct.a.fabe013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe013
            #add-point:ON ACTION controlp INFIELD fabe013 name="construct.c.fabe013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe034
            #add-point:BEFORE FIELD fabe034 name="construct.b.fabe034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe034
            
            #add-point:AFTER FIELD fabe034 name="construct.a.fabe034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe034
            #add-point:ON ACTION controlp INFIELD fabe034 name="construct.c.fabe034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe035
            #add-point:BEFORE FIELD fabe035 name="construct.b.fabe035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe035
            
            #add-point:AFTER FIELD fabe035 name="construct.a.fabe035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe035
            #add-point:ON ACTION controlp INFIELD fabe035 name="construct.c.fabe035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe036
            #add-point:BEFORE FIELD fabe036 name="construct.b.fabe036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe036
            
            #add-point:AFTER FIELD fabe036 name="construct.a.fabe036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe036
            #add-point:ON ACTION controlp INFIELD fabe036 name="construct.c.fabe036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe037
            #add-point:BEFORE FIELD fabe037 name="construct.b.fabe037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe037
            
            #add-point:AFTER FIELD fabe037 name="construct.a.fabe037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe037
            #add-point:ON ACTION controlp INFIELD fabe037 name="construct.c.fabe037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe043
            #add-point:BEFORE FIELD fabe043 name="construct.b.fabe043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe043
            
            #add-point:AFTER FIELD fabe043 name="construct.a.fabe043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe043
            #add-point:ON ACTION controlp INFIELD fabe043 name="construct.c.fabe043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe044
            #add-point:BEFORE FIELD fabe044 name="construct.b.fabe044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe044
            
            #add-point:AFTER FIELD fabe044 name="construct.a.fabe044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe044
            #add-point:ON ACTION controlp INFIELD fabe044 name="construct.c.fabe044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe041
            #add-point:BEFORE FIELD fabe041 name="construct.b.fabe041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe041
            
            #add-point:AFTER FIELD fabe041 name="construct.a.fabe041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe041
            #add-point:ON ACTION controlp INFIELD fabe041 name="construct.c.fabe041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe038
            #add-point:BEFORE FIELD fabe038 name="construct.b.fabe038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe038
            
            #add-point:AFTER FIELD fabe038 name="construct.a.fabe038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe038
            #add-point:ON ACTION controlp INFIELD fabe038 name="construct.c.fabe038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe039
            #add-point:BEFORE FIELD fabe039 name="construct.b.fabe039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe039
            
            #add-point:AFTER FIELD fabe039 name="construct.a.fabe039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe039
            #add-point:ON ACTION controlp INFIELD fabe039 name="construct.c.fabe039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe040
            #add-point:BEFORE FIELD fabe040 name="construct.b.fabe040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe040
            
            #add-point:AFTER FIELD fabe040 name="construct.a.fabe040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabe040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe040
            #add-point:ON ACTION controlp INFIELD fabe040 name="construct.c.fabe040"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabeownid
            #add-point:ON ACTION controlp INFIELD fabeownid name="construct.c.fabeownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabeownid  #顯示到畫面上

            NEXT FIELD fabeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabeownid
            #add-point:BEFORE FIELD fabeownid name="construct.b.fabeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabeownid
            
            #add-point:AFTER FIELD fabeownid name="construct.a.fabeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabeowndp
            #add-point:ON ACTION controlp INFIELD fabeowndp name="construct.c.fabeowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabeowndp  #顯示到畫面上

            NEXT FIELD fabeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabeowndp
            #add-point:BEFORE FIELD fabeowndp name="construct.b.fabeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabeowndp
            
            #add-point:AFTER FIELD fabeowndp name="construct.a.fabeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabecrtid
            #add-point:ON ACTION controlp INFIELD fabecrtid name="construct.c.fabecrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabecrtid  #顯示到畫面上

            NEXT FIELD fabecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabecrtid
            #add-point:BEFORE FIELD fabecrtid name="construct.b.fabecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabecrtid
            
            #add-point:AFTER FIELD fabecrtid name="construct.a.fabecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabecrtdp
            #add-point:ON ACTION controlp INFIELD fabecrtdp name="construct.c.fabecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabecrtdp  #顯示到畫面上

            NEXT FIELD fabecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabecrtdp
            #add-point:BEFORE FIELD fabecrtdp name="construct.b.fabecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabecrtdp
            
            #add-point:AFTER FIELD fabecrtdp name="construct.a.fabecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabecrtdt
            #add-point:BEFORE FIELD fabecrtdt name="construct.b.fabecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabemodid
            #add-point:ON ACTION controlp INFIELD fabemodid name="construct.c.fabemodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabemodid  #顯示到畫面上

            NEXT FIELD fabemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabemodid
            #add-point:BEFORE FIELD fabemodid name="construct.b.fabemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabemodid
            
            #add-point:AFTER FIELD fabemodid name="construct.a.fabemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabemoddt
            #add-point:BEFORE FIELD fabemoddt name="construct.b.fabemoddt"
            
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
 
{<section id="afat420.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afat420_query()
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
 
   INITIALIZE g_fabe_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL afat420_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afat420_browser_fill(g_wc,"F")
      CALL afat420_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL afat420_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL afat420_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afat420.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afat420_fetch(p_fl)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
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
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_fabe_m.fabe000 = g_browser[g_current_idx].b_fabe000
   LET g_fabe_m.fabe001 = g_browser[g_current_idx].b_fabe001
   LET g_fabe_m.fabe003 = g_browser[g_current_idx].b_fabe003
   LET g_fabe_m.fabe004 = g_browser[g_current_idx].b_fabe004
   LET g_fabe_m.fabe045 = g_browser[g_current_idx].b_fabe045
 
                       
   #讀取單頭所有欄位資料
   EXECUTE afat420_master_referesh USING g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045 INTO g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabestus, 
       g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018, 
       g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
       g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010,g_fabe_m.fabe011, 
       g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037, 
       g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040, 
       g_fabe_m.fabeownid,g_fabe_m.fabeowndp,g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt, 
       g_fabe_m.fabemodid,g_fabe_m.fabemoddt,g_fabe_m.fabe006_desc,g_fabe_m.fabe007_desc,g_fabe_m.fabe008_desc, 
       g_fabe_m.fabe017_desc,g_fabe_m.fabe020_desc,g_fabe_m.fabe025_desc,g_fabe_m.fabe026_desc,g_fabe_m.fabe027_desc, 
       g_fabe_m.fabe028_desc,g_fabe_m.fabe029_desc,g_fabe_m.fabe030_desc,g_fabe_m.fabe031_desc,g_fabe_m.fabe032_desc, 
       g_fabe_m.fabe009_desc,g_fabe_m.fabe010_desc,g_fabe_m.fabe011_desc,g_fabe_m.fabeownid_desc,g_fabe_m.fabeowndp_desc, 
       g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp_desc,g_fabe_m.fabemodid_desc
   
   #遮罩相關處理
   LET g_fabe_m_mask_o.* =  g_fabe_m.*
   CALL afat420_fabe_t_mask()
   LET g_fabe_m_mask_n.* =  g_fabe_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afat420_set_act_visible()
   CALL afat420_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_fabe_m_t.* = g_fabe_m.*
   LET g_fabe_m_o.* = g_fabe_m.*
   
   LET g_data_owner = g_fabe_m.fabeownid      
   LET g_data_dept  = g_fabe_m.fabeowndp
   
   #重新顯示
   CALL afat420_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="afat420.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat420_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_fabe_m.* TO NULL             #DEFAULT 設定
   LET g_fabe000_t = NULL
   LET g_fabe001_t = NULL
   LET g_fabe003_t = NULL
   LET g_fabe004_t = NULL
   LET g_fabe045_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fabe_m.fabeownid = g_user
      LET g_fabe_m.fabeowndp = g_dept
      LET g_fabe_m.fabecrtid = g_user
      LET g_fabe_m.fabecrtdp = g_dept 
      LET g_fabe_m.fabecrtdt = cl_get_current()
      LET g_fabe_m.fabemodid = g_user
      LET g_fabe_m.fabemoddt = cl_get_current()
      LET g_fabe_m.fabestus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fabe_m.fabestus = "N"
      LET g_fabe_m.fabe018 = "0"
      LET g_fabe_m.fabe019 = "0"
      LET g_fabe_m.fabe021 = "0"
      LET g_fabe_m.fabe022 = "0"
      LET g_fabe_m.fabe023 = "0"
      LET g_fabe_m.fabe024 = "0"
      LET g_fabe_m.fabe033 = "Y"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_fabe_m_t.* = g_fabe_m.*
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabe_m.fabestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL afat420_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_fabe_m.* TO NULL
         CALL afat420_show()
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
   CALL afat420_set_act_visible()
   CALL afat420_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fabe000_t = g_fabe_m.fabe000
   LET g_fabe001_t = g_fabe_m.fabe001
   LET g_fabe003_t = g_fabe_m.fabe003
   LET g_fabe004_t = g_fabe_m.fabe004
   LET g_fabe045_t = g_fabe_m.fabe045
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabeent = " ||g_enterprise|| " AND",
                      " fabe000 = '", g_fabe_m.fabe000, "' "
                      ," AND fabe001 = '", g_fabe_m.fabe001, "' "
                      ," AND fabe003 = '", g_fabe_m.fabe003, "' "
                      ," AND fabe004 = '", g_fabe_m.fabe004, "' "
                      ," AND fabe045 = '", g_fabe_m.fabe045, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat420_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afat420_master_referesh USING g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045 INTO g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabestus, 
       g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018, 
       g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
       g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010,g_fabe_m.fabe011, 
       g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037, 
       g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040, 
       g_fabe_m.fabeownid,g_fabe_m.fabeowndp,g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt, 
       g_fabe_m.fabemodid,g_fabe_m.fabemoddt,g_fabe_m.fabe006_desc,g_fabe_m.fabe007_desc,g_fabe_m.fabe008_desc, 
       g_fabe_m.fabe017_desc,g_fabe_m.fabe020_desc,g_fabe_m.fabe025_desc,g_fabe_m.fabe026_desc,g_fabe_m.fabe027_desc, 
       g_fabe_m.fabe028_desc,g_fabe_m.fabe029_desc,g_fabe_m.fabe030_desc,g_fabe_m.fabe031_desc,g_fabe_m.fabe032_desc, 
       g_fabe_m.fabe009_desc,g_fabe_m.fabe010_desc,g_fabe_m.fabe011_desc,g_fabe_m.fabeownid_desc,g_fabe_m.fabeowndp_desc, 
       g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp_desc,g_fabe_m.fabemodid_desc
   
   
   #遮罩相關處理
   LET g_fabe_m_mask_o.* =  g_fabe_m.*
   CALL afat420_fabe_t_mask()
   LET g_fabe_m_mask_n.* =  g_fabe_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe006_desc,g_fabe_m.fabe007,g_fabe_m.fabe007_desc, 
       g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabe008_desc,g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015, 
       g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe017_desc,g_fabe_m.fabe018,g_fabe_m.fabe019, 
       g_fabe_m.fabe020,g_fabe_m.fabe020_desc,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe025_desc,g_fabe_m.fabe026,g_fabe_m.fabe026_desc,g_fabe_m.fabe027, 
       g_fabe_m.fabe027_desc,g_fabe_m.fabe028,g_fabe_m.fabe028_desc,g_fabe_m.fabe029,g_fabe_m.fabe029_desc, 
       g_fabe_m.fabe030,g_fabe_m.fabe030_desc,g_fabe_m.fabe031,g_fabe_m.fabe031_desc,g_fabe_m.fabe032, 
       g_fabe_m.fabe032_desc,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe009_desc,g_fabe_m.fabe010, 
       g_fabe_m.fabe010_desc,g_fabe_m.fabe011,g_fabe_m.fabe011_desc,g_fabe_m.fabe012,g_fabe_m.fabe013, 
       g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044, 
       g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeownid_desc, 
       g_fabe_m.fabeowndp,g_fabe_m.fabeowndp_desc,g_fabe_m.fabecrtid,g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp, 
       g_fabe_m.fabecrtdp_desc,g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemodid_desc,g_fabe_m.fabemoddt 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_fabe_m.fabeownid      
   LET g_data_dept  = g_fabe_m.fabeowndp
 
   #功能已完成,通報訊息中心
   CALL afat420_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afat420.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat420_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_fabe_m.fabe000 IS NULL
 
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
   LET g_fabe000_t = g_fabe_m.fabe000
   LET g_fabe001_t = g_fabe_m.fabe001
   LET g_fabe003_t = g_fabe_m.fabe003
   LET g_fabe004_t = g_fabe_m.fabe004
   LET g_fabe045_t = g_fabe_m.fabe045
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN afat420_cl USING g_enterprise,g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004,g_fabe_m.fabe045
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat420_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afat420_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat420_master_referesh USING g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045 INTO g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabestus, 
       g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018, 
       g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
       g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010,g_fabe_m.fabe011, 
       g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037, 
       g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040, 
       g_fabe_m.fabeownid,g_fabe_m.fabeowndp,g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt, 
       g_fabe_m.fabemodid,g_fabe_m.fabemoddt,g_fabe_m.fabe006_desc,g_fabe_m.fabe007_desc,g_fabe_m.fabe008_desc, 
       g_fabe_m.fabe017_desc,g_fabe_m.fabe020_desc,g_fabe_m.fabe025_desc,g_fabe_m.fabe026_desc,g_fabe_m.fabe027_desc, 
       g_fabe_m.fabe028_desc,g_fabe_m.fabe029_desc,g_fabe_m.fabe030_desc,g_fabe_m.fabe031_desc,g_fabe_m.fabe032_desc, 
       g_fabe_m.fabe009_desc,g_fabe_m.fabe010_desc,g_fabe_m.fabe011_desc,g_fabe_m.fabeownid_desc,g_fabe_m.fabeowndp_desc, 
       g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp_desc,g_fabe_m.fabemodid_desc
 
   #檢查是否允許此動作
   IF NOT afat420_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_fabe_m_mask_o.* =  g_fabe_m.*
   CALL afat420_fabe_t_mask()
   LET g_fabe_m_mask_n.* =  g_fabe_m.*
   
   
 
   #顯示資料
   CALL afat420_show()
   
   WHILE TRUE
      LET g_fabe_m.fabe000 = g_fabe000_t
      LET g_fabe_m.fabe001 = g_fabe001_t
      LET g_fabe_m.fabe003 = g_fabe003_t
      LET g_fabe_m.fabe004 = g_fabe004_t
      LET g_fabe_m.fabe045 = g_fabe045_t
 
      
      #寫入修改者/修改日期資訊
      LET g_fabe_m.fabemodid = g_user 
LET g_fabe_m.fabemoddt = cl_get_current()
LET g_fabe_m.fabemodid_desc = cl_get_username(g_fabe_m.fabemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL afat420_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_fabe_m.* = g_fabe_m_t.*
         CALL afat420_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE fabe_t SET (fabemodid,fabemoddt) = (g_fabe_m.fabemodid,g_fabe_m.fabemoddt)
       WHERE fabeent = g_enterprise AND fabe000 = g_fabe000_t
         AND fabe001 = g_fabe001_t
         AND fabe003 = g_fabe003_t
         AND fabe004 = g_fabe004_t
         AND fabe045 = g_fabe045_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afat420_set_act_visible()
   CALL afat420_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fabeent = " ||g_enterprise|| " AND",
                      " fabe000 = '", g_fabe_m.fabe000, "' "
                      ," AND fabe001 = '", g_fabe_m.fabe001, "' "
                      ," AND fabe003 = '", g_fabe_m.fabe003, "' "
                      ," AND fabe004 = '", g_fabe_m.fabe004, "' "
                      ," AND fabe045 = '", g_fabe_m.fabe045, "' "
 
   #填到對應位置
   CALL afat420_browser_fill(g_wc,"")
 
   CLOSE afat420_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat420_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="afat420.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat420_input(p_cmd)
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
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE  l_ld_str       STRING              #161111-00049#11 
   DEFINE  l_faad002      LIKE faad_t.faad002 #161111-00049#11   
   DEFINE  l_comp_str     STRING              #161111-00049#11
   DEFINE  l_site_str     STRING              #161111-00049#11
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe006_desc,g_fabe_m.fabe007,g_fabe_m.fabe007_desc, 
       g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabe008_desc,g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015, 
       g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe017_desc,g_fabe_m.fabe018,g_fabe_m.fabe019, 
       g_fabe_m.fabe020,g_fabe_m.fabe020_desc,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe025_desc,g_fabe_m.fabe026,g_fabe_m.fabe026_desc,g_fabe_m.fabe027, 
       g_fabe_m.fabe027_desc,g_fabe_m.fabe028,g_fabe_m.fabe028_desc,g_fabe_m.fabe029,g_fabe_m.fabe029_desc, 
       g_fabe_m.fabe030,g_fabe_m.fabe030_desc,g_fabe_m.fabe031,g_fabe_m.fabe031_desc,g_fabe_m.fabe032, 
       g_fabe_m.fabe032_desc,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe009_desc,g_fabe_m.fabe010, 
       g_fabe_m.fabe010_desc,g_fabe_m.fabe011,g_fabe_m.fabe011_desc,g_fabe_m.fabe012,g_fabe_m.fabe013, 
       g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044, 
       g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeownid_desc, 
       g_fabe_m.fabeowndp,g_fabe_m.fabeowndp_desc,g_fabe_m.fabecrtid,g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp, 
       g_fabe_m.fabecrtdp_desc,g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemodid_desc,g_fabe_m.fabemoddt 
 
   
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
   CALL afat420_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afat420_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   LET l_flag = 'N'
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
          g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabestus, 
          g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018, 
          g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
          g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
          g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010,g_fabe_m.fabe011, 
          g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037, 
          g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            IF p_cmd = 'a' THEN
               CALL cl_set_comp_font_color("fabe000,fabe001,fabe002,fabe003,fabe004,
               fabe005,fabe006,fabe007,fabe008,fabe009,fabe010,
               fabe011,fabe012,fabe013,fabe014,fabe015,fabe016,
               fabe017,fabe018,fabe019,fabe020,fabe021,fabe022,
               fabe023,fabe024,fabe025,fabe026,fabe027,fabe028,
               fabe029,fabe030,fabe031,fabe032,fabe033,fabe034,
               fabe035,fabe036,fabe037,fabe038,fabe039,fabe040,
               fabe041,fabe042,fabe043,fabe044,fabe045","black")  
               LET g_fabe_m.fabe004 = ' ' 
            END IF
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe001
            #add-point:BEFORE FIELD fabe001 name="input.b.fabe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe001
            
            #add-point:AFTER FIELD fabe001 name="input.a.fabe001"
            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_fabe_m.fabe000) AND NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) AND NOT cl_null(g_fabe_m.fabe004) AND NOT cl_null(g_fabe_m.fabe045) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabe_m.fabe000 != g_fabe000_t  OR g_fabe_m.fabe001 != g_fabe001_t  OR g_fabe_m.fabe003 != g_fabe003_t  OR g_fabe_m.fabe004 != g_fabe004_t  OR g_fabe_m.fabe045 != g_fabe045_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabe_t WHERE "||"fabeent = '" ||g_enterprise|| "' AND "||"fabe000 = '"||g_fabe_m.fabe000 ||"' AND "|| "fabe001 = '"||g_fabe_m.fabe001 ||"' AND "|| "fabe003 = '"||g_fabe_m.fabe003 ||"' AND "|| "fabe004 = '"||g_fabe_m.fabe004 ||"' AND "|| "fabe045 = '"||g_fabe_m.fabe045 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            
            IF NOT cl_null(g_fabe_m.fabe001) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 =  g_fabe_m.fabe001


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faah001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理 
                  LET g_fabe_m.fabe001 = g_fabe_m_t.fabe001
                  NEXT FIELD CURRENT
               END IF
            END IF         
            

            CALL afat420_fabe001_chk()
            IF NOT cl_null(g_errno) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_fabe_m.fabe001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_fabe_m.fabe001 = g_fabe_m_t.fabe001
               NEXT FIELD fabe001
            END IF 
 

 
            IF NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) AND g_fabe_m.fabe004 IS NOT NULL THEN 
               IF NOT afat420_fabe_ins() THEN  
                  LET g_fabe_m.fabe001 = g_fabe_m_t.fabe001
                  NEXT FIELD fabe001
               END IF
               LET l_flag = 'Y'   #帶值成功，重新進入單身，進入修改狀態
               #EXIT DIALOG      
               CONTINUE DIALOG                  
            END IF
            
            #161111-00049#11 add s---
            IF NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) THEN
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
               IF s_chr_get_index_of(l_comp_str,g_fabe_m.fabe032,1) = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-01133'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
            END IF   
            #161111-00049#11 add e---             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe001
            #add-point:ON CHANGE fabe001 name="input.g.fabe001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe002
            #add-point:BEFORE FIELD fabe002 name="input.b.fabe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe002
            
            #add-point:AFTER FIELD fabe002 name="input.a.fabe002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe002
            #add-point:ON CHANGE fabe002 name="input.g.fabe002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe000
            #add-point:BEFORE FIELD fabe000 name="input.b.fabe000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe000
            
            #add-point:AFTER FIELD fabe000 name="input.a.fabe000"
            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_fabe_m.fabe000) AND NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) AND NOT cl_null(g_fabe_m.fabe004) AND NOT cl_null(g_fabe_m.fabe045) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabe_m.fabe000 != g_fabe000_t  OR g_fabe_m.fabe001 != g_fabe001_t  OR g_fabe_m.fabe003 != g_fabe003_t  OR g_fabe_m.fabe004 != g_fabe004_t  OR g_fabe_m.fabe045 != g_fabe045_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabe_t WHERE "||"fabeent = '" ||g_enterprise|| "' AND "||"fabe000 = '"||g_fabe_m.fabe000 ||"' AND "|| "fabe001 = '"||g_fabe_m.fabe001 ||"' AND "|| "fabe003 = '"||g_fabe_m.fabe003 ||"' AND "|| "fabe004 = '"||g_fabe_m.fabe004 ||"' AND "|| "fabe045 = '"||g_fabe_m.fabe045 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe000
            #add-point:ON CHANGE fabe000 name="input.g.fabe000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe003
            #add-point:BEFORE FIELD fabe003 name="input.b.fabe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe003
            
            #add-point:AFTER FIELD fabe003 name="input.a.fabe003"
            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_fabe_m.fabe000) AND NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) AND NOT cl_null(g_fabe_m.fabe004) AND NOT cl_null(g_fabe_m.fabe045) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabe_m.fabe000 != g_fabe000_t  OR g_fabe_m.fabe001 != g_fabe001_t  OR g_fabe_m.fabe003 != g_fabe003_t  OR g_fabe_m.fabe004 != g_fabe004_t  OR g_fabe_m.fabe045 != g_fabe045_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabe_t WHERE "||"fabeent = '" ||g_enterprise|| "' AND "||"fabe000 = '"||g_fabe_m.fabe000 ||"' AND "|| "fabe001 = '"||g_fabe_m.fabe001 ||"' AND "|| "fabe003 = '"||g_fabe_m.fabe003 ||"' AND "|| "fabe004 = '"||g_fabe_m.fabe004 ||"' AND "|| "fabe045 = '"||g_fabe_m.fabe045 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            IF NOT cl_null(g_fabe_m.fabe003) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 =  g_fabe_m.fabe003


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faah003") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理 
                  LET g_fabe_m.fabe003 = g_fabe_m_t.fabe003
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            CALL afat420_fabe001_chk()
            IF NOT cl_null(g_errno) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_fabe_m.fabe003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_fabe_m.fabe003 = g_fabe_m_t.fabe003
               NEXT FIELD fabe003
            END IF 


            
            IF NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) AND g_fabe_m.fabe004 IS NOT NULL THEN 
               
               IF NOT afat420_fabe_ins() THEN  
                  LET g_fabe_m.fabe003 = g_fabe_m_t.fabe003
                  NEXT FIELD fabe003
               END IF
               LET l_flag = 'Y'   #帶值成功，重新進入單身，進入修改狀態
               #EXIT DIALOG   
               CONTINUE DIALOG   
            END IF
            
            #161111-00049#11 add s---
            IF NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) THEN
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
               IF s_chr_get_index_of(l_comp_str,g_fabe_m.fabe032,1) = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-01133'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
            END IF   
            #161111-00049#11 add e---             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe003
            #add-point:ON CHANGE fabe003 name="input.g.fabe003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe004
            #add-point:BEFORE FIELD fabe004 name="input.b.fabe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe004
            
            #add-point:AFTER FIELD fabe004 name="input.a.fabe004"
            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_fabe_m.fabe000) AND NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) AND NOT cl_null(g_fabe_m.fabe004) AND NOT cl_null(g_fabe_m.fabe045) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabe_m.fabe000 != g_fabe000_t  OR g_fabe_m.fabe001 != g_fabe001_t  OR g_fabe_m.fabe003 != g_fabe003_t  OR g_fabe_m.fabe004 != g_fabe004_t  OR g_fabe_m.fabe045 != g_fabe045_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabe_t WHERE "||"fabeent = '" ||g_enterprise|| "' AND "||"fabe000 = '"||g_fabe_m.fabe000 ||"' AND "|| "fabe001 = '"||g_fabe_m.fabe001 ||"' AND "|| "fabe003 = '"||g_fabe_m.fabe003 ||"' AND "|| "fabe004 = '"||g_fabe_m.fabe004 ||"' AND "|| "fabe045 = '"||g_fabe_m.fabe045 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF
            IF NOT cl_null(g_fabe_m.fabe004) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 =  g_fabe_m.fabe004


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faah004") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理 
                  LET g_fabe_m.fabe004 = g_fabe_m_t.fabe004
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_fabe_m.fabe004 = ' '
            END IF 

            CALL afat420_fabe001_chk()
            IF NOT cl_null(g_errno) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_fabe_m.fabe004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_fabe_m.fabe004 = g_fabe_m_t.fabe004
               NEXT FIELD fabe004
            END IF 
          
            IF NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) AND g_fabe_m.fabe004 IS NOT NULL THEN             
               IF NOT afat420_fabe_ins() THEN  
                  LET g_fabe_m.fabe004 = g_fabe_m_t.fabe004
                  NEXT FIELD fabe004
               END IF
               LET l_flag = 'Y'   #帶值成功，重新進入單身，進入修改狀態
               #EXIT DIALOG  
               CONTINUE DIALOG               
            END IF
            
            #161111-00049#11 add s---
            IF NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) THEN
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
               IF s_chr_get_index_of(l_comp_str,g_fabe_m.fabe032,1) = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-01133'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
            END IF   
            #161111-00049#11 add e---              
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe004
            #add-point:ON CHANGE fabe004 name="input.g.fabe004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe045
            #add-point:BEFORE FIELD fabe045 name="input.b.fabe045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe045
            
            #add-point:AFTER FIELD fabe045 name="input.a.fabe045"
            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_fabe_m.fabe000) AND NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) AND NOT cl_null(g_fabe_m.fabe004) AND NOT cl_null(g_fabe_m.fabe045) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabe_m.fabe000 != g_fabe000_t  OR g_fabe_m.fabe001 != g_fabe001_t  OR g_fabe_m.fabe003 != g_fabe003_t  OR g_fabe_m.fabe004 != g_fabe004_t  OR g_fabe_m.fabe045 != g_fabe045_t )) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabe_t WHERE "||"fabeent = '" ||g_enterprise|| "' AND "||"fabe000 = '"||g_fabe_m.fabe000 ||"' AND "|| "fabe001 = '"||g_fabe_m.fabe001 ||"' AND "|| "fabe003 = '"||g_fabe_m.fabe003 ||"' AND "|| "fabe004 = '"||g_fabe_m.fabe004 ||"' AND "|| "fabe045 = '"||g_fabe_m.fabe045 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe045
            #add-point:ON CHANGE fabe045 name="input.g.fabe045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe006
            
            #add-point:AFTER FIELD fabe006 name="input.a.fabe006"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe006
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faac001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#11 add s---
                  CALL s_axrt300_get_site(g_user,g_fabe_m.fabe032,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")	
                  LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str ," AND faal001 = '",g_fabe_m.fabe006,"'"
                  PREPARE afat420_fabe006_count FROM g_sql
                  EXECUTE afat420_fabe006_count INTO l_cnt   
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01123'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabe_m.fabe006 = g_fabe_m_t.fabe006
                     CALL afat420_ref_show()
                     CALL afat420_fabe006_get()
                     NEXT FIELD CURRENT  
                  ELSE
                     IF NOT cl_null(g_fabe_m.fabe007) THEN
                        LET l_cnt = 0 
                        SELECT COUNT(1) INTO l_cnt FROM faad_t WHERE faadent = g_enterprise AND faad001 = g_fabe_m.fabe007 AND faad002 = g_fabe_m.fabe006
                        IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                        IF l_cnt = 0 THEN 
                           LET g_fabe_m.fabe007 = NULL
                           LET g_fabe_m.fabe007_desc = NULL                         
                        ELSE   
                           LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str," AND faal001 = '",g_fabe_m.fabe006,"'" 
                           PREPARE afat420_fabe007_count1 FROM g_sql
                           EXECUTE afat420_fabe007_count1 INTO l_cnt   
                           IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                           IF l_cnt = 0 THEN 
                              LET g_fabe_m.fabe007 = NULL
                              LET g_fabe_m.fabe007_desc = NULL
                           END IF
                       END IF                          
                     END IF                     
                  END IF
                  #161111-00049#11 add e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe006 = g_fabe_m_t.fabe006
                  CALL afat420_ref_show()
                  CALL afat420_fabe006_get()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe006
            #add-point:BEFORE FIELD fabe006 name="input.b.fabe006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe006
            #add-point:ON CHANGE fabe006 name="input.g.fabe006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe007
            
            #add-point:AFTER FIELD fabe007 name="input.a.fabe007"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe007
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00009:sub-01302|afai030|",cl_get_progname("afai030",g_lang,"2"),"|:EXEPROGafai030"
               #160318-00025#5--add--end
                       
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#11 add s---
                  LET l_faad002 = NULL
                  IF cl_null(g_fabe_m.fabe006) THEN 
                     SELECT faad002 INTO l_faad002 FROM faad_t WHERE faadent = g_enterprise AND faad001 = g_fabe_m.fabe007
                  ELSE
                     LET l_faad002 = g_fabe_m.fabe006                  
                  END IF   
                  CALL s_axrt300_get_site(g_user,g_fabe_m.fabe032,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")	
                  LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str," AND faal001 = '",l_faad002,"'" 
                  PREPARE afat420_fabe007_count FROM g_sql
                  EXECUTE afat420_fabe007_count INTO l_cnt   
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01124'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabe_m.fabe007 = g_fabe_m_t.fabe007
                     CALL afat420_ref_show()
                     NEXT FIELD CURRENT                   
                  END IF
                  #161111-00049#11 add e--- 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe007 = g_fabe_m_t.fabe007
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe007
            #add-point:BEFORE FIELD fabe007 name="input.b.fabe007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe007
            #add-point:ON CHANGE fabe007 name="input.g.fabe007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe005
            #add-point:BEFORE FIELD fabe005 name="input.b.fabe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe005
            
            #add-point:AFTER FIELD fabe005 name="input.a.fabe005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe005
            #add-point:ON CHANGE fabe005 name="input.g.fabe005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe008
            
            #add-point:AFTER FIELD fabe008 name="input.a.fabe008"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe008) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe008
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00011:sub-01302|afai110|",cl_get_progname("afai110",g_lang,"2"),"|:EXEPROGafai110"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3903") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe008 = g_fabe_m_t.fabe008
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe008
            #add-point:BEFORE FIELD fabe008 name="input.b.fabe008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe008
            #add-point:ON CHANGE fabe008 name="input.g.fabe008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabestus
            #add-point:BEFORE FIELD fabestus name="input.b.fabestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabestus
            
            #add-point:AFTER FIELD fabestus name="input.a.fabestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabestus
            #add-point:ON CHANGE fabestus name="input.g.fabestus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe014
            #add-point:BEFORE FIELD fabe014 name="input.b.fabe014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe014
            
            #add-point:AFTER FIELD fabe014 name="input.a.fabe014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe014
            #add-point:ON CHANGE fabe014 name="input.g.fabe014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe015
            #add-point:BEFORE FIELD fabe015 name="input.b.fabe015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe015
            
            #add-point:AFTER FIELD fabe015 name="input.a.fabe015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe015
            #add-point:ON CHANGE fabe015 name="input.g.fabe015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe016
            #add-point:BEFORE FIELD fabe016 name="input.b.fabe016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe016
            
            #add-point:AFTER FIELD fabe016 name="input.a.fabe016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe016
            #add-point:ON CHANGE fabe016 name="input.g.fabe016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe042
            #add-point:BEFORE FIELD fabe042 name="input.b.fabe042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe042
            
            #add-point:AFTER FIELD fabe042 name="input.a.fabe042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe042
            #add-point:ON CHANGE fabe042 name="input.g.fabe042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe017
            
            #add-point:AFTER FIELD fabe017 name="input.a.fabe017"
            IF NOT cl_null(g_fabe_m.fabe017) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe017
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabe_m.fabe017
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabe_m.fabe017_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabe_m.fabe017_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe017
            #add-point:BEFORE FIELD fabe017 name="input.b.fabe017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe017
            #add-point:ON CHANGE fabe017 name="input.g.fabe017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe018
            #add-point:BEFORE FIELD fabe018 name="input.b.fabe018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe018
            
            #add-point:AFTER FIELD fabe018 name="input.a.fabe018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe018
            #add-point:ON CHANGE fabe018 name="input.g.fabe018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe019
            #add-point:BEFORE FIELD fabe019 name="input.b.fabe019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe019
            
            #add-point:AFTER FIELD fabe019 name="input.a.fabe019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe019
            #add-point:ON CHANGE fabe019 name="input.g.fabe019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe020
            
            #add-point:AFTER FIELD fabe020 name="input.a.fabe020"
            IF NOT cl_null(g_fabe_m.fabe020) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe020
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabe_m.fabe020
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabe_m.fabe020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabe_m.fabe020_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe020
            #add-point:BEFORE FIELD fabe020 name="input.b.fabe020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe020
            #add-point:ON CHANGE fabe020 name="input.g.fabe020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe021
            #add-point:BEFORE FIELD fabe021 name="input.b.fabe021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe021
            
            #add-point:AFTER FIELD fabe021 name="input.a.fabe021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe021
            #add-point:ON CHANGE fabe021 name="input.g.fabe021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe022
            #add-point:BEFORE FIELD fabe022 name="input.b.fabe022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe022
            
            #add-point:AFTER FIELD fabe022 name="input.a.fabe022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe022
            #add-point:ON CHANGE fabe022 name="input.g.fabe022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe023
            #add-point:BEFORE FIELD fabe023 name="input.b.fabe023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe023
            
            #add-point:AFTER FIELD fabe023 name="input.a.fabe023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe023
            #add-point:ON CHANGE fabe023 name="input.g.fabe023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe024
            #add-point:BEFORE FIELD fabe024 name="input.b.fabe024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe024
            
            #add-point:AFTER FIELD fabe024 name="input.a.fabe024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe024
            #add-point:ON CHANGE fabe024 name="input.g.fabe024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe025
            
            #add-point:AFTER FIELD fabe025 name="input.a.fabe025"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe025) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe025
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe025 = g_fabe_m_t.fabe025
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe025
            #add-point:BEFORE FIELD fabe025 name="input.b.fabe025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe025
            #add-point:ON CHANGE fabe025 name="input.g.fabe025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe026
            
            #add-point:AFTER FIELD fabe026 name="input.a.fabe026"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe026) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe026
               LET g_chkparam.arg2 = g_today
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe026 = g_fabe_m_t.fabe026
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe026
            #add-point:BEFORE FIELD fabe026 name="input.b.fabe026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe026
            #add-point:ON CHANGE fabe026 name="input.g.fabe026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe027
            
            #add-point:AFTER FIELD fabe027 name="input.a.fabe027"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe027) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe027

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3900") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#11 add s---
                  SELECT COUNT(1) INTO l_cnt FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '3900' 
                     AND oocq002 = g_fabe_m.fabe027 AND (oocq004 = g_fabe_m.fabe032 OR oocq004 IS NULL)  
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01120'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabe_m.fabe027 = g_fabe_m_t.fabe027
                     CALL afat420_ref_show()
                     NEXT FIELD CURRENT                  
                  END IF  
                  #161111-00049#11 add e---   
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe027 = g_fabe_m_t.fabe027
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe027
            #add-point:BEFORE FIELD fabe027 name="input.b.fabe027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe027
            #add-point:ON CHANGE fabe027 name="input.g.fabe027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe028
            
            #add-point:AFTER FIELD fabe028 name="input.a.fabe028"
            IF NOT cl_null(g_fabe_m.fabe028) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe028
               LET g_chkparam.arg2 = '參數2'

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faab002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabe_m.fabe028
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabe_m.fabe028_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabe_m.fabe028_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe028
            #add-point:BEFORE FIELD fabe028 name="input.b.fabe028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe028
            #add-point:ON CHANGE fabe028 name="input.g.fabe028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe029
            
            #add-point:AFTER FIELD fabe029 name="input.a.fabe029"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe029) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe029
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe029 = g_fabe_m_t.fabe029
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe029
            #add-point:BEFORE FIELD fabe029 name="input.b.fabe029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe029
            #add-point:ON CHANGE fabe029 name="input.g.fabe029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe030
            
            #add-point:AFTER FIELD fabe030 name="input.a.fabe030"
            IF NOT cl_null(g_fabe_m.fabe030) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe030
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN #161024-00008#3 
               IF cl_chk_exist("v_ooef001_26") THEN #161024-00008#3 
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabe_m.fabe030
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabe_m.fabe030_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabe_m.fabe030_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe030
            #add-point:BEFORE FIELD fabe030 name="input.b.fabe030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe030
            #add-point:ON CHANGE fabe030 name="input.g.fabe030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe031
            
            #add-point:AFTER FIELD fabe031 name="input.a.fabe031"
            IF NOT cl_null(g_fabe_m.fabe031) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe031
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN         #161024-00008#3
               IF cl_chk_exist("v_ooef001_23") THEN       #161024-00008#3
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabe_m.fabe031
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabe_m.fabe031_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabe_m.fabe031_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe031
            #add-point:BEFORE FIELD fabe031 name="input.b.fabe031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe031
            #add-point:ON CHANGE fabe031 name="input.g.fabe031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe032
            
            #add-point:AFTER FIELD fabe032 name="input.a.fabe032"
            IF NOT cl_null(g_fabe_m.fabe032) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe032
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN    #161024-00008#3 
               IF cl_chk_exist("v_ooef001_15") THEN #161024-00008#3 
               
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabe_m.fabe032
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabe_m.fabe032_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabe_m.fabe032_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe032
            #add-point:BEFORE FIELD fabe032 name="input.b.fabe032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe032
            #add-point:ON CHANGE fabe032 name="input.g.fabe032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe033
            #add-point:BEFORE FIELD fabe033 name="input.b.fabe033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe033
            
            #add-point:AFTER FIELD fabe033 name="input.a.fabe033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe033
            #add-point:ON CHANGE fabe033 name="input.g.fabe033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe009
            
            #add-point:AFTER FIELD fabe009 name="input.a.fabe009"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe009

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#11 add s---
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_fabe_m.fabe032 AND pmab001 = g_fabe_m.fabe009 
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01119'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabe_m.fabe009 = g_fabe_m_t.fabe009
                     CALL afat420_ref_show()
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#11 add e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe009 = g_fabe_m_t.fabe009
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe009
            #add-point:BEFORE FIELD fabe009 name="input.b.fabe009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe009
            #add-point:ON CHANGE fabe009 name="input.g.fabe009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe010
            
            #add-point:AFTER FIELD fabe010 name="input.a.fabe010"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe010
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#11 add s---
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_fabe_m.fabe032 AND pmab001 = g_fabe_m.fabe009 
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01119'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabe_m.fabe010 = g_fabe_m_t.fabe010
                     CALL afat420_ref_show()
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#11 add e--- 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe010 = g_fabe_m_t.fabe010
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe010
            #add-point:BEFORE FIELD fabe010 name="input.b.fabe010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe010
            #add-point:ON CHANGE fabe010 name="input.g.fabe010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe011
            
            #add-point:AFTER FIELD fabe011 name="input.a.fabe011"
            CALL afat420_ref_show()
            IF NOT cl_null(g_fabe_m.fabe011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabe_m.fabe011

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabe_m.fabe011 = g_fabe_m_t.fabe011
                  CALL afat420_ref_show()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe011
            #add-point:BEFORE FIELD fabe011 name="input.b.fabe011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe011
            #add-point:ON CHANGE fabe011 name="input.g.fabe011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe012
            #add-point:BEFORE FIELD fabe012 name="input.b.fabe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe012
            
            #add-point:AFTER FIELD fabe012 name="input.a.fabe012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe012
            #add-point:ON CHANGE fabe012 name="input.g.fabe012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe013
            #add-point:BEFORE FIELD fabe013 name="input.b.fabe013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe013
            
            #add-point:AFTER FIELD fabe013 name="input.a.fabe013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe013
            #add-point:ON CHANGE fabe013 name="input.g.fabe013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe034
            #add-point:BEFORE FIELD fabe034 name="input.b.fabe034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe034
            
            #add-point:AFTER FIELD fabe034 name="input.a.fabe034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe034
            #add-point:ON CHANGE fabe034 name="input.g.fabe034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe035
            #add-point:BEFORE FIELD fabe035 name="input.b.fabe035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe035
            
            #add-point:AFTER FIELD fabe035 name="input.a.fabe035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe035
            #add-point:ON CHANGE fabe035 name="input.g.fabe035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe036
            #add-point:BEFORE FIELD fabe036 name="input.b.fabe036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe036
            
            #add-point:AFTER FIELD fabe036 name="input.a.fabe036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe036
            #add-point:ON CHANGE fabe036 name="input.g.fabe036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe037
            #add-point:BEFORE FIELD fabe037 name="input.b.fabe037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe037
            
            #add-point:AFTER FIELD fabe037 name="input.a.fabe037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe037
            #add-point:ON CHANGE fabe037 name="input.g.fabe037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe043
            #add-point:BEFORE FIELD fabe043 name="input.b.fabe043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe043
            
            #add-point:AFTER FIELD fabe043 name="input.a.fabe043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe043
            #add-point:ON CHANGE fabe043 name="input.g.fabe043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe044
            #add-point:BEFORE FIELD fabe044 name="input.b.fabe044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe044
            
            #add-point:AFTER FIELD fabe044 name="input.a.fabe044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe044
            #add-point:ON CHANGE fabe044 name="input.g.fabe044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe041
            #add-point:BEFORE FIELD fabe041 name="input.b.fabe041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe041
            
            #add-point:AFTER FIELD fabe041 name="input.a.fabe041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe041
            #add-point:ON CHANGE fabe041 name="input.g.fabe041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe038
            #add-point:BEFORE FIELD fabe038 name="input.b.fabe038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe038
            
            #add-point:AFTER FIELD fabe038 name="input.a.fabe038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe038
            #add-point:ON CHANGE fabe038 name="input.g.fabe038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe039
            #add-point:BEFORE FIELD fabe039 name="input.b.fabe039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe039
            
            #add-point:AFTER FIELD fabe039 name="input.a.fabe039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe039
            #add-point:ON CHANGE fabe039 name="input.g.fabe039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabe040
            #add-point:BEFORE FIELD fabe040 name="input.b.fabe040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabe040
            
            #add-point:AFTER FIELD fabe040 name="input.a.fabe040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabe040
            #add-point:ON CHANGE fabe040 name="input.g.fabe040"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe001
            #add-point:ON ACTION controlp INFIELD fabe001 name="input.c.fabe001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe001             #給予default值
            LET g_qryparam.where = " (faah015 <> '0' AND faah015 <>'6' AND faah015 <> '5' AND faah015 <> '8')"
            #給予arg
            IF NOT cl_null(g_fabe_m.fabe003) AND g_fabe_m.fabe004 IS NOT NULL THEN
               LET g_qryparam.where =  g_qryparam.where," AND faah003 ='",g_fabe_m.fabe003,"' AND faah004 ='",g_fabe_m.fabe004,"'"
            END IF
            IF cl_null(g_fabe_m.fabe003) AND g_fabe_m.fabe004 IS NOT NULL AND g_fabe_m.fabe004 <> ' ' THEN
               LET g_qryparam.where =  g_qryparam.where,"AND faah004 ='",g_fabe_m.fabe004,"'"
            END IF
            IF NOT cl_null(g_fabe_m.fabe003) AND g_fabe_m.fabe004 IS NULL THEN 
               LET g_qryparam.where =  g_qryparam.where," AND faah003 ='",g_fabe_m.fabe003,"'"
            END IF
            
            #161111-00049#11 add s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND faah032 IN(SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ",l_site_str,")"             
            #161111-00049#11 add e---
            
            CALL q_faah001()                                #呼叫開窗

            LET g_fabe_m.fabe001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe001 TO fabe001              #顯示到畫面上

            NEXT FIELD fabe001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe002
            #add-point:ON ACTION controlp INFIELD fabe002 name="input.c.fabe002"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe000
            #add-point:ON ACTION controlp INFIELD fabe000 name="input.c.fabe000"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe003
            #add-point:ON ACTION controlp INFIELD fabe003 name="input.c.fabe003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe003             #給予default值
            
            LET g_qryparam.where = " (faah015 <> '0' AND faah015 <>'6' AND faah015 <> '5' AND faah015 <> '8')"
            IF NOT cl_null(g_fabe_m.fabe001) AND g_fabe_m.fabe004 IS NOT NULL THEN
               LET g_qryparam.where =g_qryparam.where," AND faah001 ='",g_fabe_m.fabe001,"' AND faah004 ='",g_fabe_m.fabe004,"'"
            END IF
            IF cl_null(g_fabe_m.fabe001) AND g_fabe_m.fabe004 IS NOT NULL AND g_fabe_m.fabe004 <> ' ' THEN
               LET g_qryparam.where =g_qryparam.where," AND faah004 ='",g_fabe_m.fabe004,"'"
            END IF
            IF NOT cl_null(g_fabe_m.fabe001) AND g_fabe_m.fabe004 IS  NULL THEN
               LET g_qryparam.where =g_qryparam.where," AND faah001 ='",g_fabe_m.fabe001,"'"
            END IF
            #給予arg
            #161111-00049#11 add s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND faah032 IN(SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ",l_site_str,")"             
            #161111-00049#11 add e---        
            CALL q_faah003()                                #呼叫開窗

            LET g_fabe_m.fabe003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe003 TO fabe003              #顯示到畫面上

            NEXT FIELD fabe003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe004
            #add-point:ON ACTION controlp INFIELD fabe004 name="input.c.fabe004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe004             #給予default值
            #給予arg
            
            LET g_qryparam.where = " (faah015 <> '0' AND faah015 <>'6' AND faah015 <> '5' AND faah015 <> '8')"
            IF NOT cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) THEN
               LET g_qryparam.where =g_qryparam.where," AND faah001 ='",g_fabe_m.fabe001,"' AND faah003 ='",g_fabe_m.fabe003,"'"
            END IF
            IF cl_null(g_fabe_m.fabe001) AND NOT cl_null(g_fabe_m.fabe003) THEN
               LET g_qryparam.where =g_qryparam.where," AND faah003 ='",g_fabe_m.fabe003,"'"
            END IF
            IF NOT cl_null(g_fabe_m.fabe001) AND cl_null(g_fabe_m.fabe003) THEN
               LET g_qryparam.where =g_qryparam.where," AND faah001 ='",g_fabe_m.fabe001,"'"
            END IF
            #161111-00049#11 add s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND faah032 IN(SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ",l_site_str,")"             
            #161111-00049#11 add e---          
            CALL q_faah004()                                #呼叫開窗

            LET g_fabe_m.fabe004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe004 TO fabe004              #顯示到畫面上

            NEXT FIELD fabe004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe045
            #add-point:ON ACTION controlp INFIELD fabe045 name="input.c.fabe045"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe006
            #add-point:ON ACTION controlp INFIELD fabe006 name="input.c.fabe006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe006             #給予default值

            #給予arg
			   #161111-00049#11 mod s---
			   CALL s_axrt300_get_site(g_user,g_fabe_m.fabe032,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str                       
            CALL q_faal001_1() 
            #CALL q_faac001()                                #呼叫開窗
            #161111-00049#11 mod e---
            LET g_fabe_m.fabe006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe006 TO fabe006              #顯示到畫面上
            CALL afat420_ref_show()
            CALL afat420_fabe006_get()
            NEXT FIELD fabe006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe007
            #add-point:ON ACTION controlp INFIELD fabe007 name="input.c.fabe007"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe007             #給予default值

            #給予arg
			   #161111-00049#11 add s---
			   CALL s_axrt300_get_site(g_user,g_fabe_m.fabe032,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 = '",g_fabe_m.fabe006,"' AND faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"   
			   #161111-00049#11 add e---
            CALL q_faad001()                                #呼叫開窗

            LET g_fabe_m.fabe007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe007 TO fabe007              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe005
            #add-point:ON ACTION controlp INFIELD fabe005 name="input.c.fabe005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe008
            #add-point:ON ACTION controlp INFIELD fabe008 name="input.c.fabe008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '3903'

            CALL q_oocq002()                                #呼叫開窗

            LET g_fabe_m.fabe008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe008 TO fabe008              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabestus
            #add-point:ON ACTION controlp INFIELD fabestus name="input.c.fabestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe014
            #add-point:ON ACTION controlp INFIELD fabe014 name="input.c.fabe014"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe015
            #add-point:ON ACTION controlp INFIELD fabe015 name="input.c.fabe015"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe016
            #add-point:ON ACTION controlp INFIELD fabe016 name="input.c.fabe016"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe042
            #add-point:ON ACTION controlp INFIELD fabe042 name="input.c.fabe042"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe017
            #add-point:ON ACTION controlp INFIELD fabe017 name="input.c.fabe017"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe017             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_fabe_m.fabe017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe017 TO fabe017              #顯示到畫面上

            NEXT FIELD fabe017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe018
            #add-point:ON ACTION controlp INFIELD fabe018 name="input.c.fabe018"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe019
            #add-point:ON ACTION controlp INFIELD fabe019 name="input.c.fabe019"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe020
            #add-point:ON ACTION controlp INFIELD fabe020 name="input.c.fabe020"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe020             #給予default值

            #給予arg

            CALL q_aooi001_1()                                #呼叫開窗

            LET g_fabe_m.fabe020 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe020 TO fabe020              #顯示到畫面上

            NEXT FIELD fabe020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe021
            #add-point:ON ACTION controlp INFIELD fabe021 name="input.c.fabe021"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe022
            #add-point:ON ACTION controlp INFIELD fabe022 name="input.c.fabe022"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe023
            #add-point:ON ACTION controlp INFIELD fabe023 name="input.c.fabe023"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe024
            #add-point:ON ACTION controlp INFIELD fabe024 name="input.c.fabe024"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe025
            #add-point:ON ACTION controlp INFIELD fabe025 name="input.c.fabe025"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe025             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_fabe_m.fabe025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe025 TO fabe025              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe026
            #add-point:ON ACTION controlp INFIELD fabe026 name="input.c.fabe026"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_fabe_m.fabe026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe026 TO fabe026              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe027
            #add-point:ON ACTION controlp INFIELD fabe027 name="input.c.fabe027"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '3900'
            #161111-00049#11 add s---
            IF NOT cl_null(g_fabe_m.fabe032) THEN 
               LET g_qryparam.where = " (oocq004 = '",g_fabe_m.fabe032,"' OR oocq004 IS NULL)" 
            ELSE
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
               LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","oocq004")
               LET g_qryparam.where = "(",l_comp_str," OR oocq004 IS NULL)"              
            END IF
            #161111-00049#11 add e---            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabe_m.fabe027 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe027 TO fabe027              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe028
            #add-point:ON ACTION controlp INFIELD fabe028 name="input.c.fabe028"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe028             #給予default值

            #給予arg
            #161111-00049#11 add s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
            LET g_qryparam.where = l_comp_str 
            #161111-00049#11 add e---
            CALL q_faab001()                                #呼叫開窗

            LET g_fabe_m.fabe028 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe028 TO fabe028              #顯示到畫面上

            NEXT FIELD fabe028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe029
            #add-point:ON ACTION controlp INFIELD fabe029 name="input.c.fabe029"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe029             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_fabe_m.fabe029 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe029 TO fabe029              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe030
            #add-point:ON ACTION controlp INFIELD fabe030 name="input.c.fabe030"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe030             #給予default值
            LET g_qryparam.default2 = "" #g_fabe_m.ooefl003 #說明(簡稱)

            #給予arg

            #CALL q_ooef001()                                #呼叫開窗 #161024-00008#3 
            #161111-00049#11 add s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
            LET g_qryparam.where = l_comp_str 
            #161111-00049#11 add e---            
            CALL q_ooef001_47()                                        #161024-00008#3 

            LET g_fabe_m.fabe030 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_fabe_m.ooefl003 = g_qryparam.return2 #說明(簡稱)

            DISPLAY g_fabe_m.fabe030 TO fabe030              #顯示到畫面上
            #DISPLAY g_fabe_m.ooefl003 TO ooefl003 #說明(簡稱)

            NEXT FIELD fabe030                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe031
            #add-point:ON ACTION controlp INFIELD fabe031 name="input.c.fabe031"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #CALL q_ooef001_04()                                #呼叫開窗 #161024-00008#3
             #161111-00049#11 add s---
             CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
             LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str 
             #161111-00049#11 add e---            
             #LET g_qryparam.where = " ooef204 = 'Y'  "                   #161024-00008#3 #161111-00049#11 mark
             CALL q_ooef001()                                            #161024-00008#3

            LET g_fabe_m.fabe031 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe031 TO fabe031              #顯示到畫面上

            NEXT FIELD fabe031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe032
            #add-point:ON ACTION controlp INFIELD fabe032 name="input.c.fabe032"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe032             #給予default值
            LET g_qryparam.default2 = "" #g_fabe_m.ooefl003 #說明(簡稱)

            #給予arg

            #CALL q_ooef001()                                #呼叫開窗#161024-00008#3
            #161111-00049#11 add s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
            LET g_qryparam.where = l_comp_str 
            #161111-00049#11 add e---              
            CALL q_ooef001_2()                                        #161024-00008#3

            LET g_fabe_m.fabe032 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_fabe_m.ooefl003 = g_qryparam.return2 #說明(簡稱)

            DISPLAY g_fabe_m.fabe032 TO fabe032              #顯示到畫面上
            #DISPLAY g_fabe_m.ooefl003 TO ooefl003 #說明(簡稱)

            NEXT FIELD fabe032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe033
            #add-point:ON ACTION controlp INFIELD fabe033 name="input.c.fabe033"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe009
            #add-point:ON ACTION controlp INFIELD fabe009 name="input.c.fabe009"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe009             #給予default值
            LET g_qryparam.default2 = "" #g_fabe_m.pmaal004 #交易對象簡稱

            #給予arg

            #161111-00049#11 mod s--
            #CALL q_pmaa001_10()   #呼叫開窗  
            LET g_qryparam.arg1 = "('1','3')"
            IF NOT cl_null(g_fabe_m.fabe032) THEN
               LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_fabe_m.fabe032,"')  "
            ELSE
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
               LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","pmabsite")
               LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND ",l_comp_str,")  "
            END IF   
            CALL q_pmaa001_1()               
            #161111-00049#11 mod e--

            LET g_fabe_m.fabe009 = g_qryparam.return1              #將開窗取得的值回傳到變數
   

            DISPLAY g_fabe_m.fabe009 TO fabe009              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe010
            #add-point:ON ACTION controlp INFIELD fabe010 name="input.c.fabe010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe010             #給予default值
            LET g_qryparam.where = " pmaastus = 'Y'"
            #給予arg

            #161111-00049#11 mod s--
            #CALL q_pmaa001_5()                                #呼叫開窗
            LET g_qryparam.arg1 = "('2','3')"
            IF NOT cl_null(g_fabe_m.fabe032) THEN
               LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_fabe_m.fabe032,"')  "
            ELSE
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
               LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","pmabsite")
               LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND ",l_comp_str,")  "            
            END IF
            CALL q_pmaa001_1()               
            #161111-00049#11 mod e--

            LET g_fabe_m.fabe010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe010 TO fabe010              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe011
            #add-point:ON ACTION controlp INFIELD fabe011 name="input.c.fabe011"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabe_m.fabe011             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_fabe_m.fabe011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabe_m.fabe011 TO fabe011              #顯示到畫面上
            CALL afat420_ref_show()
            NEXT FIELD fabe011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe012
            #add-point:ON ACTION controlp INFIELD fabe012 name="input.c.fabe012"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe013
            #add-point:ON ACTION controlp INFIELD fabe013 name="input.c.fabe013"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe034
            #add-point:ON ACTION controlp INFIELD fabe034 name="input.c.fabe034"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe035
            #add-point:ON ACTION controlp INFIELD fabe035 name="input.c.fabe035"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe036
            #add-point:ON ACTION controlp INFIELD fabe036 name="input.c.fabe036"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe037
            #add-point:ON ACTION controlp INFIELD fabe037 name="input.c.fabe037"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe043
            #add-point:ON ACTION controlp INFIELD fabe043 name="input.c.fabe043"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe044
            #add-point:ON ACTION controlp INFIELD fabe044 name="input.c.fabe044"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe041
            #add-point:ON ACTION controlp INFIELD fabe041 name="input.c.fabe041"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe038
            #add-point:ON ACTION controlp INFIELD fabe038 name="input.c.fabe038"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe039
            #add-point:ON ACTION controlp INFIELD fabe039 name="input.c.fabe039"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabe040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabe040
            #add-point:ON ACTION controlp INFIELD fabe040 name="input.c.fabe040"
            
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
               SELECT COUNT(1) INTO l_count FROM fabe_t
                WHERE fabeent = g_enterprise AND fabe000 = g_fabe_m.fabe000
                  AND fabe001 = g_fabe_m.fabe001
                  AND fabe003 = g_fabe_m.fabe003
                  AND fabe004 = g_fabe_m.fabe004
                  AND fabe045 = g_fabe_m.fabe045
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO fabe_t (fabeent,fabe001,fabe002,fabe000,fabe003,fabe004,fabe045,fabe006, 
                      fabe007,fabe005,fabe008,fabestus,fabe014,fabe015,fabe016,fabe042,fabe017,fabe018, 
                      fabe019,fabe020,fabe021,fabe022,fabe023,fabe024,fabe025,fabe026,fabe027,fabe028, 
                      fabe029,fabe030,fabe031,fabe032,fabe033,fabe009,fabe010,fabe011,fabe012,fabe013, 
                      fabe034,fabe035,fabe036,fabe037,fabe043,fabe044,fabe041,fabe038,fabe039,fabe040, 
                      fabeownid,fabeowndp,fabecrtid,fabecrtdp,fabecrtdt,fabemodid,fabemoddt)
                  VALUES (g_enterprise,g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003, 
                      g_fabe_m.fabe004,g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005, 
                      g_fabe_m.fabe008,g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016, 
                      g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018,g_fabe_m.fabe019,g_fabe_m.fabe020, 
                      g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024,g_fabe_m.fabe025, 
                      g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
                      g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010, 
                      g_fabe_m.fabe011,g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035, 
                      g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041, 
                      g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeowndp, 
                      g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemoddt)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  IF NOT afat420_dif_chk() THEN #若有變更則新增資產變更歷程檔
                     CONTINUE DIALOG                
                  END IF
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fabe_m.fabe000
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat420_fabe_t_mask_restore('restore_mask_o')
               
               UPDATE fabe_t SET (fabe001,fabe002,fabe000,fabe003,fabe004,fabe045,fabe006,fabe007,fabe005, 
                   fabe008,fabestus,fabe014,fabe015,fabe016,fabe042,fabe017,fabe018,fabe019,fabe020, 
                   fabe021,fabe022,fabe023,fabe024,fabe025,fabe026,fabe027,fabe028,fabe029,fabe030,fabe031, 
                   fabe032,fabe033,fabe009,fabe010,fabe011,fabe012,fabe013,fabe034,fabe035,fabe036,fabe037, 
                   fabe043,fabe044,fabe041,fabe038,fabe039,fabe040,fabeownid,fabeowndp,fabecrtid,fabecrtdp, 
                   fabecrtdt,fabemodid,fabemoddt) = (g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000, 
                   g_fabe_m.fabe003,g_fabe_m.fabe004,g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007, 
                   g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015, 
                   g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018,g_fabe_m.fabe019, 
                   g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
                   g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029, 
                   g_fabe_m.fabe030,g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009, 
                   g_fabe_m.fabe010,g_fabe_m.fabe011,g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034, 
                   g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044, 
                   g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid, 
                   g_fabe_m.fabeowndp,g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt,g_fabe_m.fabemodid, 
                   g_fabe_m.fabemoddt)
                WHERE fabeent = g_enterprise AND fabe000 = g_fabe000_t #
                  AND fabe001 = g_fabe001_t
                  AND fabe003 = g_fabe003_t
                  AND fabe004 = g_fabe004_t
                  AND fabe045 = g_fabe045_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabe_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afat420_fabe_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     IF NOT afat420_dif_chk() THEN #若有變更則新增資產變更歷程檔
                        CALL s_transaction_end('N','0')
                     END IF
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_fabe_m_t)
                     LET g_log2 = util.JSON.stringify(g_fabe_m)
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
  #IF l_flag = 'Y' THEN
  #   LET l_flag = 'N'
  #   CALL afat420_modify()
  #END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afat420.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afat420_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE fabe_t.fabe000 
   DEFINE l_oldno     LIKE fabe_t.fabe000 
   DEFINE l_newno02     LIKE fabe_t.fabe001 
   DEFINE l_oldno02     LIKE fabe_t.fabe001 
   DEFINE l_newno03     LIKE fabe_t.fabe003 
   DEFINE l_oldno03     LIKE fabe_t.fabe003 
   DEFINE l_newno04     LIKE fabe_t.fabe004 
   DEFINE l_oldno04     LIKE fabe_t.fabe004 
   DEFINE l_newno05     LIKE fabe_t.fabe045 
   DEFINE l_oldno05     LIKE fabe_t.fabe045 
 
   DEFINE l_master    RECORD LIKE fabe_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_fabe_m.fabe000 IS NULL
      OR g_fabe_m.fabe001 IS NULL
      OR g_fabe_m.fabe003 IS NULL
      OR g_fabe_m.fabe004 IS NULL
      OR g_fabe_m.fabe045 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_fabe000_t = g_fabe_m.fabe000
   LET g_fabe001_t = g_fabe_m.fabe001
   LET g_fabe003_t = g_fabe_m.fabe003
   LET g_fabe004_t = g_fabe_m.fabe004
   LET g_fabe045_t = g_fabe_m.fabe045
 
   
   #清空key值
   LET g_fabe_m.fabe000 = ""
   LET g_fabe_m.fabe001 = ""
   LET g_fabe_m.fabe003 = ""
   LET g_fabe_m.fabe004 = ""
   LET g_fabe_m.fabe045 = ""
 
    
   CALL afat420_set_entry("a")
   CALL afat420_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fabe_m.fabeownid = g_user
      LET g_fabe_m.fabeowndp = g_dept
      LET g_fabe_m.fabecrtid = g_user
      LET g_fabe_m.fabecrtdp = g_dept 
      LET g_fabe_m.fabecrtdt = cl_get_current()
      LET g_fabe_m.fabemodid = g_user
      LET g_fabe_m.fabemoddt = cl_get_current()
      LET g_fabe_m.fabestus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabe_m.fabestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL afat420_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_fabe_m.* TO NULL
      CALL afat420_show()
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
      LET g_errparam.extend = "fabe_t:",SQLERRMESSAGE 
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
   CALL afat420_set_act_visible()
   CALL afat420_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_fabe000_t = g_fabe_m.fabe000
   LET g_fabe001_t = g_fabe_m.fabe001
   LET g_fabe003_t = g_fabe_m.fabe003
   LET g_fabe004_t = g_fabe_m.fabe004
   LET g_fabe045_t = g_fabe_m.fabe045
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabeent = " ||g_enterprise|| " AND",
                      " fabe000 = '", g_fabe_m.fabe000, "' "
                      ," AND fabe001 = '", g_fabe_m.fabe001, "' "
                      ," AND fabe003 = '", g_fabe_m.fabe003, "' "
                      ," AND fabe004 = '", g_fabe_m.fabe004, "' "
                      ," AND fabe045 = '", g_fabe_m.fabe045, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat420_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_fabe_m.fabeownid      
   LET g_data_dept  = g_fabe_m.fabeowndp
              
   #功能已完成,通報訊息中心
   CALL afat420_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="afat420.show" >}
#+ 資料顯示 
PRIVATE FUNCTION afat420_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   #CALL afat420_ref_show()
  # IF g_fabe_m.fabestus = 'N' THEN
  #    CALL cl_set_act_visible("modify,delete", TRUE)   
  # ELSE
  #    CALL cl_set_act_visible("modify,delete", FALSE)
  # END IF
  # CALL cl_set_act_visible("reproduce", FALSE)
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afat420_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
 
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe006_desc,g_fabe_m.fabe007,g_fabe_m.fabe007_desc, 
       g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabe008_desc,g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015, 
       g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe017_desc,g_fabe_m.fabe018,g_fabe_m.fabe019, 
       g_fabe_m.fabe020,g_fabe_m.fabe020_desc,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe025_desc,g_fabe_m.fabe026,g_fabe_m.fabe026_desc,g_fabe_m.fabe027, 
       g_fabe_m.fabe027_desc,g_fabe_m.fabe028,g_fabe_m.fabe028_desc,g_fabe_m.fabe029,g_fabe_m.fabe029_desc, 
       g_fabe_m.fabe030,g_fabe_m.fabe030_desc,g_fabe_m.fabe031,g_fabe_m.fabe031_desc,g_fabe_m.fabe032, 
       g_fabe_m.fabe032_desc,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe009_desc,g_fabe_m.fabe010, 
       g_fabe_m.fabe010_desc,g_fabe_m.fabe011,g_fabe_m.fabe011_desc,g_fabe_m.fabe012,g_fabe_m.fabe013, 
       g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044, 
       g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeownid_desc, 
       g_fabe_m.fabeowndp,g_fabe_m.fabeowndp_desc,g_fabe_m.fabecrtid,g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp, 
       g_fabe_m.fabecrtdp_desc,g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemodid_desc,g_fabe_m.fabemoddt 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL afat420_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabe_m.fabestus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   CALL afat420_set_color()
   CALL afat420_hint_show('fabf_t','fabe_t',g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004,g_fabe_m.fabe045)

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat420.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION afat420_delete()
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
   IF g_fabe_m.fabe000 IS NULL
   OR g_fabe_m.fabe001 IS NULL
   OR g_fabe_m.fabe003 IS NULL
   OR g_fabe_m.fabe004 IS NULL
   OR g_fabe_m.fabe045 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_fabe000_t = g_fabe_m.fabe000
   LET g_fabe001_t = g_fabe_m.fabe001
   LET g_fabe003_t = g_fabe_m.fabe003
   LET g_fabe004_t = g_fabe_m.fabe004
   LET g_fabe045_t = g_fabe_m.fabe045
 
   
   
 
   OPEN afat420_cl USING g_enterprise,g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004,g_fabe_m.fabe045
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat420_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afat420_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat420_master_referesh USING g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045 INTO g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabestus, 
       g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018, 
       g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
       g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010,g_fabe_m.fabe011, 
       g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037, 
       g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040, 
       g_fabe_m.fabeownid,g_fabe_m.fabeowndp,g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt, 
       g_fabe_m.fabemodid,g_fabe_m.fabemoddt,g_fabe_m.fabe006_desc,g_fabe_m.fabe007_desc,g_fabe_m.fabe008_desc, 
       g_fabe_m.fabe017_desc,g_fabe_m.fabe020_desc,g_fabe_m.fabe025_desc,g_fabe_m.fabe026_desc,g_fabe_m.fabe027_desc, 
       g_fabe_m.fabe028_desc,g_fabe_m.fabe029_desc,g_fabe_m.fabe030_desc,g_fabe_m.fabe031_desc,g_fabe_m.fabe032_desc, 
       g_fabe_m.fabe009_desc,g_fabe_m.fabe010_desc,g_fabe_m.fabe011_desc,g_fabe_m.fabeownid_desc,g_fabe_m.fabeowndp_desc, 
       g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp_desc,g_fabe_m.fabemodid_desc
   
   
   #檢查是否允許此動作
   IF NOT afat420_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabe_m_mask_o.* =  g_fabe_m.*
   CALL afat420_fabe_t_mask()
   LET g_fabe_m_mask_n.* =  g_fabe_m.*
   
   #將最新資料顯示到畫面上
   CALL afat420_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat420_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM fabe_t 
       WHERE fabeent = g_enterprise AND fabe000 = g_fabe_m.fabe000 
         AND fabe001 = g_fabe_m.fabe001 
         AND fabe003 = g_fabe_m.fabe003 
         AND fabe004 = g_fabe_m.fabe004 
         AND fabe045 = g_fabe_m.fabe045 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      DELETE FROM fabf_t
       WHERE fabfent = g_enterprise
         AND fabf001 = g_fabe_m.fabe001
         AND fabf002 = g_fabe_m.fabe003
         AND fabf003 = g_fabe_m.fabe004
         AND fabf004 = g_fabe_m.fabe045
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "fabf_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fabe_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE afat420_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL afat420_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL afat420_browser_fill(g_wc,"")
         CALL afat420_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afat420_cl
 
   #功能已完成,通報訊息中心
   CALL afat420_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afat420.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afat420_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   IF 1=1 THEN 
      FOR l_i =1 TO g_browser.getLength()
         IF g_browser[l_i].b_fabe000 = g_fabe_m.fabe000 
            AND g_browser[l_i].b_fabe001 = g_fabe_m.fabe001 
            AND g_browser[l_i].b_fabe003 = g_fabe_m.fabe003 
            AND g_browser[l_i].b_fabe004 = g_fabe_m.fabe004 
            AND g_browser[l_i].b_fabe045 = g_fabe_m.fabe045
            THEN  
            CALL g_browser.deleteElement(l_i)
            LET g_header_cnt = g_header_cnt - 1
          END IF
      END FOR
      
      DISPLAY g_header_cnt TO FORMONLY.b_count     #page count
      DISPLAY g_header_cnt TO FORMONLY.h_count     #page count
      LET g_browser_cnt = g_browser_cnt-1
      IF g_current_idx > g_browser_cnt THEN        #確定browse 筆數指在同一筆
         LET g_current_idx = g_browser_cnt
      END IF
      RETURN 
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_fabe000 = g_fabe_m.fabe000
         AND g_browser[l_i].b_fabe001 = g_fabe_m.fabe001
         AND g_browser[l_i].b_fabe003 = g_fabe_m.fabe003
         AND g_browser[l_i].b_fabe004 = g_fabe_m.fabe004
         AND g_browser[l_i].b_fabe045 = g_fabe_m.fabe045
 
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
 
{<section id="afat420.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afat420_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("fabe000,fabe001,fabe003,fabe004,fabe045",TRUE)
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
 
{<section id="afat420.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afat420_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fabe000,fabe001,fabe003,fabe004,fabe045",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat420.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afat420_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat420.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afat420_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_fabe_m.fabestus = 'N' THEN
      CALL cl_set_act_visible("modify,delete", TRUE)   
   ELSE
      CALL cl_set_act_visible("modify,delete", FALSE)
   END IF
   CALL cl_set_act_visible("reproduce", FALSE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat420.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat420_default_search()
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
      LET ls_wc = ls_wc, " fabe000 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabe001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fabe003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " fabe004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " fabe045 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat420.mask_functions" >}
&include "erp/afa/afat420_mask.4gl"
 
{</section>}
 
{<section id="afat420.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afat420_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   DEFINE l_n LIKE type_t.num5
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fabe_m.fabe000 IS NULL
      OR g_fabe_m.fabe001 IS NULL      OR g_fabe_m.fabe003 IS NULL      OR g_fabe_m.fabe004 IS NULL      OR g_fabe_m.fabe045 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afat420_cl USING g_enterprise,g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004,g_fabe_m.fabe045
   IF STATUS THEN
      CLOSE afat420_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat420_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afat420_master_referesh USING g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045 INTO g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabestus, 
       g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018, 
       g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
       g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010,g_fabe_m.fabe011, 
       g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037, 
       g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040, 
       g_fabe_m.fabeownid,g_fabe_m.fabeowndp,g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt, 
       g_fabe_m.fabemodid,g_fabe_m.fabemoddt,g_fabe_m.fabe006_desc,g_fabe_m.fabe007_desc,g_fabe_m.fabe008_desc, 
       g_fabe_m.fabe017_desc,g_fabe_m.fabe020_desc,g_fabe_m.fabe025_desc,g_fabe_m.fabe026_desc,g_fabe_m.fabe027_desc, 
       g_fabe_m.fabe028_desc,g_fabe_m.fabe029_desc,g_fabe_m.fabe030_desc,g_fabe_m.fabe031_desc,g_fabe_m.fabe032_desc, 
       g_fabe_m.fabe009_desc,g_fabe_m.fabe010_desc,g_fabe_m.fabe011_desc,g_fabe_m.fabeownid_desc,g_fabe_m.fabeowndp_desc, 
       g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp_desc,g_fabe_m.fabemodid_desc
   
 
   #檢查是否允許此動作
   IF NOT afat420_action_chk() THEN
      CLOSE afat420_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
       g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe006_desc,g_fabe_m.fabe007,g_fabe_m.fabe007_desc, 
       g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabe008_desc,g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015, 
       g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe017_desc,g_fabe_m.fabe018,g_fabe_m.fabe019, 
       g_fabe_m.fabe020,g_fabe_m.fabe020_desc,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
       g_fabe_m.fabe025,g_fabe_m.fabe025_desc,g_fabe_m.fabe026,g_fabe_m.fabe026_desc,g_fabe_m.fabe027, 
       g_fabe_m.fabe027_desc,g_fabe_m.fabe028,g_fabe_m.fabe028_desc,g_fabe_m.fabe029,g_fabe_m.fabe029_desc, 
       g_fabe_m.fabe030,g_fabe_m.fabe030_desc,g_fabe_m.fabe031,g_fabe_m.fabe031_desc,g_fabe_m.fabe032, 
       g_fabe_m.fabe032_desc,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe009_desc,g_fabe_m.fabe010, 
       g_fabe_m.fabe010_desc,g_fabe_m.fabe011,g_fabe_m.fabe011_desc,g_fabe_m.fabe012,g_fabe_m.fabe013, 
       g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044, 
       g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeownid_desc, 
       g_fabe_m.fabeowndp,g_fabe_m.fabeowndp_desc,g_fabe_m.fabecrtid,g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp, 
       g_fabe_m.fabecrtdp_desc,g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemodid_desc,g_fabe_m.fabemoddt 
 
 
   CASE g_fabe_m.fabestus
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
         CASE g_fabe_m.fabestus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("open,invalid,confirmed",TRUE)
      CASE g_fabe_m.fabestus
         WHEN "N"
            CALL cl_set_act_visible("open,closed",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("invalid",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,open,confirmed",FALSE)
      END CASE

      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            IF g_fabe_m.fabestus = 'Y' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00188'
               LET g_errparam.extend = g_fabe_m.fabestus
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
               RETURN 
            END IF 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
         IF g_fabe_m.fabestus = 'X' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00084'
            LET g_errparam.extend = g_fabe_m.fabestus
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
            RETURN 
         END IF
         
         SELECT COUNT(*) INTO l_n FROM fabf_t 
         WHERE fabfent = g_enterprise 
           AND fabf001 = g_fabe_m.fabe001
           AND fabf002 = g_fabe_m.fabe003
           AND fabf003 = g_fabe_m.fabe004
           AND fabf004 = g_fabe_m.fabe045 AND fabf005 LIKE 'faah%'
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00367'
            LET g_errparam.extend = g_fabe_m.fabestus
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
            RETURN 
         END IF
         
         IF NOT cl_ask_confirm('afa-00083') THEN
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
            RETURN
         ELSE
            CALL afat420_faah_upd() RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
         IF g_fabe_m.fabestus = 'Y' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00085'
            LET g_errparam.extend = g_fabe_m.fabestus
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
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
      AND lc_state <> "X"
      ) OR 
      g_fabe_m.fabestus = lc_state OR cl_null(lc_state) THEN
      CLOSE afat420_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#1 add start ------------------
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
         RETURN
      END IF
   END IF
   #151125-00001#1 add end   ------------------
   #end add-point
   
   LET g_fabe_m.fabemodid = g_user
   LET g_fabe_m.fabemoddt = cl_get_current()
   LET g_fabe_m.fabestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fabe_t 
      SET (fabestus,fabemodid,fabemoddt) 
        = (g_fabe_m.fabestus,g_fabe_m.fabemodid,g_fabe_m.fabemoddt)     
    WHERE fabeent = g_enterprise AND fabe000 = g_fabe_m.fabe000
      AND fabe001 = g_fabe_m.fabe001      AND fabe003 = g_fabe_m.fabe003      AND fabe004 = g_fabe_m.fabe004      AND fabe045 = g_fabe_m.fabe045
    
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
      EXECUTE afat420_master_referesh USING g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004, 
          g_fabe_m.fabe045 INTO g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003, 
          g_fabe_m.fabe004,g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005,g_fabe_m.fabe008, 
          g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017, 
          g_fabe_m.fabe018,g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023, 
          g_fabe_m.fabe024,g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029, 
          g_fabe_m.fabe030,g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010, 
          g_fabe_m.fabe011,g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036, 
          g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039, 
          g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeowndp,g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp, 
          g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemoddt,g_fabe_m.fabe006_desc,g_fabe_m.fabe007_desc, 
          g_fabe_m.fabe008_desc,g_fabe_m.fabe017_desc,g_fabe_m.fabe020_desc,g_fabe_m.fabe025_desc,g_fabe_m.fabe026_desc, 
          g_fabe_m.fabe027_desc,g_fabe_m.fabe028_desc,g_fabe_m.fabe029_desc,g_fabe_m.fabe030_desc,g_fabe_m.fabe031_desc, 
          g_fabe_m.fabe032_desc,g_fabe_m.fabe009_desc,g_fabe_m.fabe010_desc,g_fabe_m.fabe011_desc,g_fabe_m.fabeownid_desc, 
          g_fabe_m.fabeowndp_desc,g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp_desc,g_fabe_m.fabemodid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003,g_fabe_m.fabe004, 
          g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe006_desc,g_fabe_m.fabe007,g_fabe_m.fabe007_desc, 
          g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabe008_desc,g_fabe_m.fabestus,g_fabe_m.fabe014, 
          g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe017_desc, 
          g_fabe_m.fabe018,g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe020_desc,g_fabe_m.fabe021, 
          g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024,g_fabe_m.fabe025,g_fabe_m.fabe025_desc, 
          g_fabe_m.fabe026,g_fabe_m.fabe026_desc,g_fabe_m.fabe027,g_fabe_m.fabe027_desc,g_fabe_m.fabe028, 
          g_fabe_m.fabe028_desc,g_fabe_m.fabe029,g_fabe_m.fabe029_desc,g_fabe_m.fabe030,g_fabe_m.fabe030_desc, 
          g_fabe_m.fabe031,g_fabe_m.fabe031_desc,g_fabe_m.fabe032,g_fabe_m.fabe032_desc,g_fabe_m.fabe033, 
          g_fabe_m.fabe009,g_fabe_m.fabe009_desc,g_fabe_m.fabe010,g_fabe_m.fabe010_desc,g_fabe_m.fabe011, 
          g_fabe_m.fabe011_desc,g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035, 
          g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038, 
          g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeownid_desc,g_fabe_m.fabeowndp, 
          g_fabe_m.fabeowndp_desc,g_fabe_m.fabecrtid,g_fabe_m.fabecrtid_desc,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdp_desc, 
          g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemodid_desc,g_fabe_m.fabemoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   CALL afat420_show()
   #end add-point  
 
   CLOSE afat420_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat420_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat420.signature" >}
   
 
{</section>}
 
{<section id="afat420.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat420_set_pk_array()
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
   LET g_pk_array[1].values = g_fabe_m.fabe000
   LET g_pk_array[1].column = 'fabe000'
   LET g_pk_array[2].values = g_fabe_m.fabe001
   LET g_pk_array[2].column = 'fabe001'
   LET g_pk_array[3].values = g_fabe_m.fabe003
   LET g_pk_array[3].column = 'fabe003'
   LET g_pk_array[4].values = g_fabe_m.fabe004
   LET g_pk_array[4].column = 'fabe004'
   LET g_pk_array[5].values = g_fabe_m.fabe045
   LET g_pk_array[5].column = 'fabe045'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat420.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="afat420.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afat420_msgcentre_notify(lc_state)
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
   CALL afat420_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fabe_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat420.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afat420_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#8 -s by 08172
   SELECT fabestus  INTO g_fabe_m.fabestus
     FROM fabe_t
    WHERE fabeent = g_enterprise
      AND fabe000 = g_fabe_m.fabe000
      AND fabe001 = g_fabe_m.fabe001
      AND fabe003 = g_fabe_m.fabe003
      AND fabe004 = g_fabe_m.fabe004
      AND fabe045 = g_fabe_m.fabe045
   LET g_errno = NULL
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_fabe_m.fabestus
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
        LET g_errparam.extend = g_fabe_m.fabe001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afat420_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#8 -e by 08172
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat420.other_function" readonly="Y" >}
#参考栏位带值
PRIVATE FUNCTION afat420_ref_show()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe006
   CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe006_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe007
   CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe007_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3903' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe017
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe017_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe020
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe020_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe025
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe025_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe025_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe026
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe026_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe026_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe027
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3900' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe027_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe028_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe029
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? ","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe029_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe029_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe030
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe030_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe030_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe031
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe031_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe031_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe032
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe032_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe009
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe009_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe010
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe010_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabe_m.fabe011
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabe_m.fabe011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabe_m.fabe011_desc
END FUNCTION
# 檢查卡片編號+財產編號+附號是否存在
PRIVATE FUNCTION afat420_fabe001_chk()
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_faah015    LIKE faah_t.faah015
   DEFINE l_faahstus   LIKE faah_t.faahstus
   
   LET g_errno = ''
   
   IF cl_null(g_fabe_m.fabe001) OR cl_null(g_fabe_m.fabe003)  THEN 
      RETURN 
   END IF
   IF g_fabe_m.fabe004 IS NULL THEN
      RETURN 
   END IF
   
    LET l_n = 0    
    SELECT COUNT(*) INTO l_n 
      FROM faah_t
     WHERE faahent = g_enterprise
       AND faah001 = g_fabe_m.fabe001
       AND faah003 = g_fabe_m.fabe003
       AND faah004 = g_fabe_m.fabe004
       
    IF l_n = 0 THEN 
       LET g_errno = 'afa-00076'
       RETURN 
    END IF
    
    LET l_faah015 = ''
    SELECT faah015,faahstus INTO l_faah015,l_faahstus
      FROM faah_t
     WHERE faahent = g_enterprise
       AND faah001 = g_fabe_m.fabe001
       AND faah003 = g_fabe_m.fabe003
       AND faah004 = g_fabe_m.fabe004
       
    IF l_faahstus <> 'Y' THEN 
       LET g_errno = 'afa-00086'
       RETURN 
    END IF
    
    #财产编号资产状态排除已销帐,出售，取得，停用，类型的已审核的
    IF l_faah015 = '0' OR l_faah015 = '5' OR l_faah015 = '6' OR l_faah015 = '8' THEN 
       LET g_errno = 'afa-00087'
       RETURN 
    END IF
    
    
    LET l_n = 0    
    SELECT COUNT(*) INTO l_n 
      FROM fabe_t
     WHERE fabeent = g_enterprise
       AND fabe001 = g_fabe_m.fabe001
       AND fabe003 = g_fabe_m.fabe003
       AND fabe004 = g_fabe_m.fabe004
       AND fabestus = 'N'
    
    IF l_n > 0 THEN 
       LET g_errno = 'afa-00082'
       RETURN 
    END IF

  
END FUNCTION
# 判斷是否有欄位做了修改
PRIVATE FUNCTION afat420_dif_chk()
  #161111-00028#7---modify--begin-----------
  #DEFINE l_faah     RECORD LIKE faah_t.*
   DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企業編號
       faah000 LIKE faah_t.faah000, #產生批號
       faah001 LIKE faah_t.faah001, #卡片編號
       faah002 LIKE faah_t.faah002, #型態
       faah003 LIKE faah_t.faah003, #財產編號
       faah004 LIKE faah_t.faah004, #附號
       faah005 LIKE faah_t.faah005, #資產性質
       faah006 LIKE faah_t.faah006, #資產主要類型
       faah007 LIKE faah_t.faah007, #資產次要類型
       faah008 LIKE faah_t.faah008, #資產組
       faah009 LIKE faah_t.faah009, #供應供應商
       faah010 LIKE faah_t.faah010, #製造供應商
       faah011 LIKE faah_t.faah011, #產地
       faah012 LIKE faah_t.faah012, #名稱
       faah013 LIKE faah_t.faah013, #規格型號
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #資產狀態
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #單位
       faah018 LIKE faah_t.faah018, #數量
       faah019 LIKE faah_t.faah019, #在外數量
       faah020 LIKE faah_t.faah020, #幣別
       faah021 LIKE faah_t.faah021, #原幣單價
       faah022 LIKE faah_t.faah022, #原幣金額
       faah023 LIKE faah_t.faah023, #本幣單價
       faah024 LIKE faah_t.faah024, #本幣金額
       faah025 LIKE faah_t.faah025, #保管人員
       faah026 LIKE faah_t.faah026, #保管部門
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放組織
       faah029 LIKE faah_t.faah029, #負責人員
       faah030 LIKE faah_t.faah030, #管理組織
       faah031 LIKE faah_t.faah031, #核算組織
       faah032 LIKE faah_t.faah032, #歸屬法人
       faah033 LIKE faah_t.faah033, #直接資本化
       faah034 LIKE faah_t.faah034, #保稅
       faah035 LIKE faah_t.faah035, #保險
       faah036 LIKE faah_t.faah036, #免稅
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #採購單號
       faah039 LIKE faah_t.faah039, #收貨單號
       faah040 LIKE faah_t.faah040, #帳款單號
       faah041 LIKE faah_t.faah041, #來源營運中心
       faah042 LIKE faah_t.faah042, #資產屬性
       faah043 LIKE faah_t.faah043, #預計總工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #帳款編號項次
       faahownid LIKE faah_t.faahownid, #資料所有者
       faahowndp LIKE faah_t.faahowndp, #資料所屬部門
       faahcrtid LIKE faah_t.faahcrtid, #資料建立者
       faahcrtdp LIKE faah_t.faahcrtdp, #資料建立部門
       faahcrtdt LIKE faah_t.faahcrtdt, #資料創建日
       faahmodid LIKE faah_t.faahmodid, #資料修改者
       faahmoddt LIKE faah_t.faahmoddt, #最近修改日
       faahstus LIKE faah_t.faahstus, #狀態碼
       faah046 LIKE faah_t.faah046, #備註
       faah047 LIKE faah_t.faah047, #保稅機器擷取否
       faah048 LIKE faah_t.faah048, #投資抵減狀態
       faah049 LIKE faah_t.faah049, #投資抵減合併碼
       faah050 LIKE faah_t.faah050, #抵減率
       faah051 LIKE faah_t.faah051, #投資抵減用途
       faah052 LIKE faah_t.faah052, #抵減金額
       faah053 LIKE faah_t.faah053, #已抵減金額
       faah054 LIKE faah_t.faah054, #投資抵減否
       faah055 LIKE faah_t.faah055, #投資抵減年限
       faah056 LIKE faah_t.faah056  #免稅狀態
       END RECORD
#161111-00028#7---modify--end-----------

   DEFINE l_flag     LIKE type_t.num5   #記錄是否有欄位變更
   DEFINE r_success  LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_flag = FALSE
       
   
   INITIALIZE l_faah.* TO NULL
   
   #帶出變更前的資料
   SELECT faah000,faah001,faah002,faah003,faah004,
          faah006,faah007,faah005,faah008,faah014,
          faah015,faah016,faah042,faah017,faah018,
          faah019,faah020,faah021,faah022,faah023,
          faah024,faah025,faah026,faah027,faah028,
          faah029,faah030,faah031,faah032,faah033,
          faah009,faah010,faah011,faah012,faah013,
          faah034,faah035,faah036,faah037,faah043,
          faah044,faah041,faah038,faah039,faah040
     INTO l_faah.faah000,l_faah.faah001,l_faah.faah002,l_faah.faah003,l_faah.faah004,
          l_faah.faah006,l_faah.faah007,l_faah.faah005,l_faah.faah008,l_faah.faah014,
          l_faah.faah015,l_faah.faah016,l_faah.faah042,l_faah.faah017,l_faah.faah018,
          l_faah.faah019,l_faah.faah020,l_faah.faah021,l_faah.faah022,l_faah.faah023,
          l_faah.faah024,l_faah.faah025,l_faah.faah026,l_faah.faah027,l_faah.faah028,
          l_faah.faah029,l_faah.faah030,l_faah.faah031,l_faah.faah032,l_faah.faah033,
          l_faah.faah009,l_faah.faah010,l_faah.faah011,l_faah.faah012,l_faah.faah013,
          l_faah.faah034,l_faah.faah035,l_faah.faah036,l_faah.faah037,l_faah.faah043,
          l_faah.faah044,l_faah.faah041,l_faah.faah038,l_faah.faah039,l_faah.faah040
     FROM faah_t
    WHERE faahent = g_enterprise
      AND faah001 = g_fabe_m.fabe001
      AND faah003 = g_fabe_m.fabe003
      AND faah004 = g_fabe_m.fabe004
   
   ####################################mark by huangtao   
   ##類型(fabe002)
   #IF (NOT cl_null(g_fabe_m.fabe002) AND (g_fabe_m.fabe002 != l_faah.faah002 OR cl_null(l_faah.faah002)))
   #   OR (cl_null(g_fabe_m.fabe002) AND NOT cl_null(l_faah.faah002))   THEN
   #   IF NOT afat420_fabf_ins("faah002",l_faah.faah002,g_fabe_m.fabe002) THEN
   #      LET r_success = FALSE
   #      RETURN r_success
   #   ELSE
   #      LET l_flag = TRUE   #有欄位變更，則更新為'Y'
   #   END IF
   #ELSE
   #   IF NOT afat420_fabf_del("faah002") THEN
   #      LET r_success = FALSE
   #      RETURN r_success
   #   END IF
   #END IF
   #####################################mark by huangtao
   
   #主要類型(fabe006)
   IF (NOT cl_null(g_fabe_m.fabe006) AND (g_fabe_m.fabe006 != l_faah.faah006 OR cl_null(l_faah.faah006)))
      OR (cl_null(g_fabe_m.fabe006) AND NOT cl_null(l_faah.faah006))   THEN
      LET g_fabf009 = "SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001='"||l_faah.faah006||"' AND faacl002=?"
      IF NOT afat420_fabf_ins("faah006",l_faah.faah006,g_fabe_m.fabe006) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah006") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #次要類型(fabe007)
   IF (NOT cl_null(g_fabe_m.fabe007) AND (g_fabe_m.fabe007 != l_faah.faah007 OR cl_null(l_faah.faah007)))
      OR (cl_null(g_fabe_m.fabe007) AND NOT cl_null(l_faah.faah007))   THEN
      LET g_fabf009 = "SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001='"||l_faah.faah007||"' AND faadl002=?"
      IF NOT afat420_fabf_ins("faah007",l_faah.faah007,g_fabe_m.fabe007) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah007") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
    
   #資產性質(fabe005)
   IF (NOT cl_null(g_fabe_m.fabe005) AND (g_fabe_m.fabe005 != l_faah.faah005 OR cl_null(l_faah.faah005)))
      OR (cl_null(g_fabe_m.fabe005) AND NOT cl_null(l_faah.faah005))   THEN
      IF NOT afat420_fabf_ins("faah005",l_faah.faah005,g_fabe_m.fabe005) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah005") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #資產組(fabe008)
   IF (NOT cl_null(g_fabe_m.fabe008) AND (g_fabe_m.fabe008 != l_faah.faah008 OR cl_null(l_faah.faah008)))
      OR (cl_null(g_fabe_m.fabe008) AND NOT cl_null(l_faah.faah008))   THEN
      LET g_fabf009 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3903' AND oocql002='"||l_faah.faah008||"' AND oocql003=?"
      IF NOT afat420_fabf_ins("faah008",l_faah.faah008,g_fabe_m.fabe008) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah008") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #取得日期(fabe014)
   IF (NOT cl_null(g_fabe_m.fabe014) AND (g_fabe_m.fabe014 != l_faah.faah014 OR cl_null(l_faah.faah014)))
      OR (cl_null(g_fabe_m.fabe014) AND NOT cl_null(l_faah.faah014))   THEN
      IF NOT afat420_fabf_ins("faah014",l_faah.faah014,g_fabe_m.fabe014) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah014") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #資產屬性(fabe042)
   IF (NOT cl_null(g_fabe_m.fabe042) AND (g_fabe_m.fabe042 != l_faah.faah042 OR cl_null(l_faah.faah042)))
      OR (cl_null(g_fabe_m.fabe042) AND NOT cl_null(l_faah.faah042))   THEN
      IF NOT afat420_fabf_ins("faah042",l_faah.faah042,g_fabe_m.fabe042) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah042") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #保管人員(fabe025)
   IF (NOT cl_null(g_fabe_m.fabe025) AND (g_fabe_m.fabe025 != l_faah.faah025 OR cl_null(l_faah.faah025)))
      OR (cl_null(g_fabe_m.fabe025) AND NOT cl_null(l_faah.faah025))   THEN
      LET g_fabf009 = "SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003='"||l_faah.faah025||"'"
      IF NOT afat420_fabf_ins("faah025",l_faah.faah025,g_fabe_m.fabe025) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah025") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #保管部門(fabe026)
   IF (NOT cl_null(g_fabe_m.fabe026) AND (g_fabe_m.fabe026 != l_faah.faah026 OR cl_null(l_faah.faah026)))
      OR (cl_null(g_fabe_m.fabe026) AND NOT cl_null(l_faah.faah026))   THEN
      LET g_fabf009 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_faah.faah026||"' AND ooefl002=?"
      IF NOT afat420_fabf_ins("faah026",l_faah.faah026,g_fabe_m.fabe026) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah026") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #存放位置(fabe027)
   IF (NOT cl_null(g_fabe_m.fabe027) AND (g_fabe_m.fabe027 != l_faah.faah027 OR cl_null(l_faah.faah027)))
      OR (cl_null(g_fabe_m.fabe027) AND NOT cl_null(l_faah.faah027))   THEN
      LET g_fabf009 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3900' AND oocql002='"||l_faah.faah027||"' AND oocql003=?"
      IF NOT afat420_fabf_ins("faah027",l_faah.faah027,g_fabe_m.fabe027) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah027") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #負責人員(fabe029)
   IF (NOT cl_null(g_fabe_m.fabe029) AND (g_fabe_m.fabe029 != l_faah.faah029 OR cl_null(l_faah.faah029)))
      OR (cl_null(g_fabe_m.fabe029) AND NOT cl_null(l_faah.faah029))   THEN
      LET g_fabf009 = "SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003='"||l_faah.faah029||"'"
      IF NOT afat420_fabf_ins("faah029",l_faah.faah029,g_fabe_m.fabe029) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah029") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #直接資本化(fabe033)
   IF (NOT cl_null(g_fabe_m.fabe033) AND (g_fabe_m.fabe033 != l_faah.faah033 OR cl_null(l_faah.faah033)))
      OR (cl_null(g_fabe_m.fabe033) AND NOT cl_null(l_faah.faah033))   THEN
      IF NOT afat420_fabf_ins("faah033",l_faah.faah033,g_fabe_m.fabe033) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah033") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #供應廠商(fabe009)
   IF (NOT cl_null(g_fabe_m.fabe009) AND (g_fabe_m.fabe009 != l_faah.faah009 OR cl_null(l_faah.faah009)))
      OR (cl_null(g_fabe_m.fabe009) AND NOT cl_null(l_faah.faah009))   THEN
      LET g_fabf009 = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001='"||l_faah.faah009||"' AND pmaal002=?"
      IF NOT afat420_fabf_ins("faah009",l_faah.faah009,g_fabe_m.fabe009) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah009") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #製造廠商(fabe010)
   IF (NOT cl_null(g_fabe_m.fabe010) AND (g_fabe_m.fabe010 != l_faah.faah010 OR cl_null(l_faah.faah010)))
      OR (cl_null(g_fabe_m.fabe010) AND NOT cl_null(l_faah.faah010))   THEN
      LET g_fabf009 = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001='"||l_faah.faah010||"' AND pmaal002=?"
      IF NOT afat420_fabf_ins("faah010",l_faah.faah010,g_fabe_m.fabe010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah010") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #產地(fabe011)
   IF (NOT cl_null(g_fabe_m.fabe011) AND (g_fabe_m.fabe011 != l_faah.faah011 OR cl_null(l_faah.faah011)))
      OR (cl_null(g_fabe_m.fabe011) AND NOT cl_null(l_faah.faah011))   THEN
      LET g_fabf009 = "SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001='"||l_faah.faah011||"' AND oocgl002=?"
      IF NOT afat420_fabf_ins("faah011",l_faah.faah011,g_fabe_m.fabe011) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah011") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   #名稱(fabe012)
   IF (NOT cl_null(g_fabe_m.fabe012) AND (g_fabe_m.fabe012 != l_faah.faah012 OR cl_null(l_faah.faah012)))
      OR (cl_null(g_fabe_m.fabe012) AND NOT cl_null(l_faah.faah012))   THEN
      IF NOT afat420_fabf_ins("faah012",l_faah.faah012,g_fabe_m.fabe012) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah012") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   ##########################################add by huangtao
  #規格型號
   IF (NOT cl_null(g_fabe_m.fabe013) AND (g_fabe_m.fabe013 != l_faah.faah013 OR cl_null(l_faah.faah013)))
      OR (cl_null(g_fabe_m.fabe013) AND NOT cl_null(l_faah.faah013))   THEN
      IF NOT afat420_fabf_ins("faah013",l_faah.faah013,g_fabe_m.fabe013) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah013") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   ##########################################add by huangtao
   
   #保稅(fabe034)
   IF (NOT cl_null(g_fabe_m.fabe034) AND (g_fabe_m.fabe034 != l_faah.faah034 OR cl_null(l_faah.faah034)))
      OR (cl_null(g_fabe_m.fabe034) AND NOT cl_null(l_faah.faah034))   THEN
      IF NOT afat420_fabf_ins("faah034",l_faah.faah034,g_fabe_m.fabe034) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah034") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #保險(fabe035)
   IF (NOT cl_null(g_fabe_m.fabe035) AND (g_fabe_m.fabe035 != l_faah.faah035 OR cl_null(l_faah.faah035)))
      OR (cl_null(g_fabe_m.fabe035) AND NOT cl_null(l_faah.faah035))   THEN
      IF NOT afat420_fabf_ins("faah035",l_faah.faah035,g_fabe_m.fabe035) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah035") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #免稅(fabe036)
   IF (NOT cl_null(g_fabe_m.fabe036) AND (g_fabe_m.fabe036 != l_faah.faah036 OR cl_null(l_faah.faah036)))
      OR (cl_null(g_fabe_m.fabe036) AND NOT cl_null(l_faah.faah036))   THEN
      IF NOT afat420_fabf_ins("faah036",l_faah.faah036,g_fabe_m.fabe036) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah036") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   #抵押(fabe037)
   IF (NOT cl_null(g_fabe_m.fabe037) AND (g_fabe_m.fabe037 != l_faah.faah037 OR cl_null(l_faah.faah037)))
      OR (cl_null(g_fabe_m.fabe037) AND NOT cl_null(l_faah.faah037))   THEN
      IF NOT afat420_fabf_ins("faah037",l_faah.faah037,g_fabe_m.fabe037) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah037") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   
   #預計總工作量(fabe043)
   IF (NOT cl_null(g_fabe_m.fabe043) AND (g_fabe_m.fabe043 != l_faah.faah043 OR cl_null(l_faah.faah043)))
      OR (cl_null(g_fabe_m.fabe043) AND NOT cl_null(l_faah.faah043))   THEN
      IF NOT afat420_fabf_ins("faah043",l_faah.faah043,g_fabe_m.fabe043) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE   #有欄位變更，則更新為'Y'
      END IF
   ELSE
      IF NOT afat420_fabf_del("faah043") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   
   RETURN r_success
END FUNCTION
#faah006主要類型帶值
PRIVATE FUNCTION afat420_fabe006_get()
   SELECT faac002,faac007,faac008,faac009,faac010,faac011
     INTO g_fabe_m.fabe005,g_fabe_m.fabe033,
          g_fabe_m.fabe034,g_fabe_m.fabe035,
          g_fabe_m.fabe036,g_fabe_m.fabe037
     FROM faac_t
    WHERE faacent = g_enterprise
      AND faac001 = g_fabe_m.fabe006
   DISPLAY g_fabe_m.fabe005 TO fabe005
   DISPLAY g_fabe_m.fabe033 TO fabe033
   DISPLAY g_fabe_m.fabe034 TO fabe034
   DISPLAY g_fabe_m.fabe035 TO fabe035
   DISPLAY g_fabe_m.fabe036 TO fabe036
   DISPLAY g_fabe_m.fabe037 TO fabe037
END FUNCTION
# 刪除資產變更檔
PRIVATE FUNCTION afat420_fabf_del(p_fabf005)
   DEFINE p_fabf005   LIKE fabf_t.fabf005   #變更欄位
   DEFINE r_success   LIKE type_t.num5

       LET r_success = TRUE
       
       DELETE FROM fabf_t 
        WHERE fabfent = g_enterprise 
          AND fabf001 = g_fabe_m.fabe001
          AND fabf002 = g_fabe_m.fabe003
          AND fabf003 = g_fabe_m.fabe004
          AND fabf004 = g_fabe_m.fabe045
          AND fabf005 = p_fabf005
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmde_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
  
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
END FUNCTION
# 新增資產變更歷程檔
PRIVATE FUNCTION afat420_fabf_ins(p_fabf005,p_fabf006,p_fabf007)
   DEFINE p_fabf005   LIKE fabf_t.fabf005   #變更欄位
   DEFINE p_fabf006   LIKE fabf_t.fabf006   #變更前內容
   DEFINE p_fabf007   LIKE fabf_t.fabf007   #變更後內容
   DEFINE l_fabf008   LIKE fabf_t.fabf008   #最後變更時間
   DEFINE l_fabfcrtdt LIKE fabf_t.fabfcrtdt
   DEFINE r_success   LIKE type_t.num5
       LET r_success = TRUE
       
       LET l_fabf008 = cl_get_current()
       LET l_fabfcrtdt = cl_get_current()
       
       DELETE FROM fabf_t 
        WHERE fabfent = g_enterprise 
          AND fabf001 = g_fabe_m.fabe001
          AND fabf002 = g_fabe_m.fabe003
          AND fabf003 = g_fabe_m.fabe004
          AND fabf004 = g_fabe_m.fabe045
          AND fabf005 = p_fabf005 
       
       INSERT INTO fabf_t (fabfent,fabf001,fabf002,fabf003,fabf004,fabf005,fabf006,fabf007,fabf008,fabf009,
                           fabfownid,fabfowndp,fabfcrtid,fabfcrtdp,fabfcrtdt)
         VALUES (g_enterprise,g_fabe_m.fabe001,g_fabe_m.fabe003,g_fabe_m.fabe004,g_fabe_m.fabe045,p_fabf005,p_fabf006,p_fabf007,l_fabf008,g_fabf009,
                 g_user,g_dept,g_user,g_dept,l_fabfcrtdt)  

       LET g_fabf009 = NULL
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "fabf_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
  
          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
       
END FUNCTION
# 顯示變更欄位的字體顏色為紅色
PRIVATE FUNCTION afat420_set_color()
   DEFINE l_fabf005    STRING
   DEFINE l_fabf005_1  LIKE fabf_t.fabf005
   DEFINE l_pmdc003    STRING
   DEFINE l_index      LIKE type_t.num5
   DEFINE l_len        LIKE type_t.num5
   DEFINE l_str        STRING
   DEFINE l_str1       STRING
   DEFINE l_str2       STRING

      #CALL cl_set_comp_font_color("pmdcsite,pmdcdocdt,pmdc901,pmdcdocno,pmdc900,pmdc902,pmdc002,pmdc001,pmdc003,pmdcstus,pmdcacti,pmdc004,pmdc010,pmdc011,pmdc012,pmdc005,pmdc007,pmdc021,pmdc020,pmdc006,pmdc022,pmdc905,pmdc906","white")
      #CALL cl_set_comp_font_color("pmddsite,pmdd901,pmddseq,pmdd001,pmdd002,pmdd003,pmdd004,pmdd005,pmdd007,pmdd006,pmdd009,pmdd008,pmdd011,pmdd010,pmdd030,pmdd048,pmdd031,pmdd050,pmdd032,pmdd033,pmdd049,pmdd902,pmdd903,pmdd012,pmdd014,pmdd015,pmdd016,pmdd017,pmdd018,pmdd019,pmdd020,pmdd021,pmdd034,pmdd035,pmdd036,pmdd037,pmdd038,pmdd039,pmdd040,pmdd041,pmdd042,pmdd043,pmdd044,pmdd045,pmdd046","white") 
      CALL cl_set_comp_font_color("fabe002","white")      
  

      DECLARE fabf_cs CURSOR FOR 
        SELECT fabf005 FROM fabf_t 
         WHERE fabfent = g_enterprise 
           AND fabf001 = g_fabe_m.fabe001
           AND fabf002 = g_fabe_m.fabe003
           AND fabf003 = g_fabe_m.fabe004
           AND fabf004 = g_fabe_m.fabe045
      
      FOREACH fabf_cs INTO l_fabf005_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
         #資產變更歷程檔中記錄的變更欄位為 faahxxx,需把faahxxx--> fabexxx
         LET l_fabf005 = l_fabf005_1
         LET l_str1 = l_fabf005.subString(1,2)   #fa
         LET l_str2 = l_fabf005.subString(5,l_fabf005.getLength()) #欄位後面的代號，如'001'
         LET l_str = l_str1 CLIPPED,'be' CLIPPED,l_str2
         CALL cl_set_comp_font_color(l_str,"red")
         
         
         #LET l_index = 0
         #LET l_index = l_pmde002.getIndexOf("a",2)
         #IF l_index > 0 THEN   #說明是pmdaxxx欄位
         #   LET l_len = 0
         #   LET l_str1 = ''
         #   LET l_str2 = ''
         #   LET l_len = l_pmde002.getLength()
         #   LET l_str1 = l_pmde002.subString(1,l_index-1)     #pmd
         #   LET l_str2 = l_pmde002.subString(l_index+1,l_len) #欄位後面的代號，如'001'
         #   LET l_pmdc003 = l_str1,'c',l_str2
         #   CALL cl_set_comp_font_color(l_pmdc003,"red")
         #END IF
  
         #LET l_index = 0
         #LET l_index = l_pmde002.getIndexOf("b",1)
         #IF l_index > 0 THEN   #說明是pmdbxxx欄位
         #   LET l_len = 0
         #   LET l_str1 = ''
         #   LET l_str2 = ''
         #   LET l_len = l_pmde002.getLength()
         #   LET l_str1 = l_pmde002.subString(1,l_index-1)     #pmd
         #   LET l_str2 = l_pmde002.subString(l_index+1,l_len) #欄位後面的代號，如'001'
         #   LET l_pmdc003 = l_str1,'d',l_str2
         #   CALL cl_set_comp_font_color(l_pmdc003,"red")
         #END IF
         
      END FOREACH
      
END FUNCTION
# 抓取變更前的值，以show hint顯示
PRIVATE FUNCTION afat420_hint_show(p_table,p_table1,p_fabf001,p_fabf002,p_fabf003,p_no)
   DEFINE p_table      STRING
   DEFINE p_table1     STRING
   DEFINE p_fabf001    LIKE fabf_t.fabf001
   DEFINE p_fabf002    LIKE fabf_t.fabf002
   DEFINE p_fabf003    LIKE fabf_t.fabf003
   DEFINE p_no         LIKE fabf_t.fabf004
   DEFINE lc_table     LIKE type_t.chr10
   DEFINE lc_table1    LIKE type_t.chr10
   DEFINE l_sql        STRING
   DEFINE lc_field     LIKE fabf_t.fabf005    #變更欄位
   DEFINE lc_value     LIKE fabf_t.fabf006    #變更前內容
   DEFINE ls_field     STRING
   DEFINE ls_value     STRING
   DEFINE lc_sql       LIKE fabf_t.fabf009
   DEFINE l_ref_fields DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE l_rtn_fields DYNAMIC ARRAY OF VARCHAR(500)

   #p_seq=0時，表示抓取單頭資料
   IF cl_null(p_table) OR cl_null(p_table1) OR cl_null(p_fabf001) OR cl_null(p_fabf002) OR p_fabf003 IS NULL OR cl_null(p_no) THEN
      RETURN
   END IF

   ##暫時先用自己寫，等lib好了再修改
   #重設屬性值
   CALL afat420_hint_show_reset_comments(p_table1,0)

   #取table前四碼
   LET lc_table = p_table.subString(1,p_table.getIndexOf('_',1)-1)
   LET lc_table1= p_table1.subString(1,p_table1.getIndexOf('_',1)-1)

   LET l_sql = "SELECT ",lc_table CLIPPED,"005,",lc_table CLIPPED,"006,",
                         lc_table CLIPPED,"009 ",
               "  FROM ",p_table,
               " WHERE ",lc_table CLIPPED,"ent = ",g_enterprise,
               "   AND ",lc_table CLIPPED,"001 = '",p_fabf001,"'",
               "   AND ",lc_table CLIPPED,"002 = '",p_fabf002,"'",
               "   AND ",lc_table CLIPPED,"003 = '",p_fabf003,"'",
               "   AND ",lc_table CLIPPED,"004 = ",p_no
   PREPARE hint_show_pre FROM l_sql
   DECLARE hint_show_cs CURSOR FOR hint_show_pre

   FOREACH hint_show_cs INTO lc_field,lc_value,lc_sql

      LET ls_field = lc_field
      CALL cl_str_replace(ls_field,ls_field.subString(1,4),lc_table1)
           RETURNING ls_field
      LET ls_value = cl_getmsg('sub-00358',g_dlang)," ",lc_value

      #欄位說明SQL不為空時，則依據該SQL抓取說明
      IF NOT cl_null(lc_sql) THEN
         INITIALIZE l_ref_fields TO NULL
         LET l_ref_fields[1] = g_dlang
         CALL ap_ref_array2(l_ref_fields,lc_sql,"") RETURNING l_rtn_fields
         LET ls_value = ls_value CLIPPED,"(",l_rtn_fields[1],")"
      END IF

      #暫時先用自己寫，等lib好了再修改
      CALL afat420_hint_show_set_comments(ls_field,ls_value)

   END FOREACH
END FUNCTION
# 根據卡片編號+財產編號+附號帶出固定資產基礎檔的資料
PRIVATE FUNCTION afat420_fabe_ins()
   DEFINE r_success  LIKE type_t.num5
   
   #INITIALIZE g_fabe_m.* TO NULL
   
   LET r_success = TRUE
   
   #版次
   SELECT MAX(fabe045) + 1 
     INTO g_fabe_m.fabe045
     FROM fabe_t
    WHERE fabeent = g_enterprise
      AND fabe001 = g_fabe_m.fabe001
      AND fabe003 = g_fabe_m.fabe003
      AND fabe004 = g_fabe_m.fabe004
   IF cl_null(g_fabe_m.fabe045) THEN 
      LET g_fabe_m.fabe045 = 1
   END IF
   
   SELECT faah000,faah001,faah002,faah003,faah004,
          faah006,faah007,faah005,faah008,faah014,
          faah015,faah016,faah042,faah017,faah018,
          faah019,faah020,faah021,faah022,faah023,
          faah024,faah025,faah026,faah027,faah028,
          faah029,faah030,faah031,faah032,faah033,
          faah009,faah010,faah011,faah012,faah013,
          faah034,faah035,faah036,faah037,faah043,
          faah044,faah041,faah038,faah039,faah040
     INTO g_fabe_m.fabe000,g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe003,g_fabe_m.fabe004,
          g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabe014,
          g_fabe_m.fabe015,g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018,
          g_fabe_m.fabe019,g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,
          g_fabe_m.fabe024,g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,
          g_fabe_m.fabe029,g_fabe_m.fabe030,g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,
          g_fabe_m.fabe009,g_fabe_m.fabe010,g_fabe_m.fabe011,g_fabe_m.fabe012,g_fabe_m.fabe013,
          g_fabe_m.fabe034,g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,
          g_fabe_m.fabe044,g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040
     FROM faah_t
    WHERE faahent = g_enterprise
      AND faah001 = g_fabe_m.fabe001
      AND faah003 = g_fabe_m.fabe003
      AND faah004 = g_fabe_m.fabe004
      
   LET g_fabe_m.fabeownid = g_user
   LET g_fabe_m.fabeowndp = g_dept
   LET g_fabe_m.fabecrtid = g_user
   LET g_fabe_m.fabecrtdp = g_dept 
   LET g_fabe_m.fabecrtdt = cl_get_current()
   LET g_fabe_m.fabemodid = ""
   LET g_fabe_m.fabemoddt = ""
   LET g_fabe_m.fabestus =  'N'
   
 #  INSERT INTO fabe_t (fabeent,fabe001,fabe002,fabe000,fabe003,fabe004,fabe045,fabe006, 
 #                     fabe007,fabe005,fabe008,fabestus,fabe014,fabe015,fabe016,fabe042,fabe017,fabe018, 
 #                     fabe019,fabe020,fabe021,fabe022,fabe023,fabe024,fabe025,fabe026,fabe027,fabe028, 
 #                     fabe029,fabe030,fabe031,fabe032,fabe033,fabe009,fabe010,fabe011,fabe012,fabe013, 
 #                     fabe034,fabe035,fabe036,fabe037,fabe043,fabe044,fabe041,fabe038,fabe039,fabe040, 
 #                     fabeownid,fabeowndp,fabecrtid,fabecrtdp,fabecrtdt,fabemodid,fabemoddt)
 #                 VALUES (g_enterprise,g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003, 
 #                     g_fabe_m.fabe004,g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005, 
 #                     g_fabe_m.fabe008,g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016, 
 #                     g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018,g_fabe_m.fabe019,g_fabe_m.fabe020, 
 #                     g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024,g_fabe_m.fabe025, 
 #                     g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
 #                     g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010, 
 #                     g_fabe_m.fabe011,g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035, 
 #                     g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041, 
 #                     g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeowndp, 
 #                     g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemoddt) 
 #                     
 # IF SQLCA.sqlcode THEN
 #    INITIALIZE g_errparam TO NULL
 #    LET g_errparam.code = SQLCA.sqlcode
 #    LET g_errparam.extend = "g_pmdc_m"
 #    LET g_errparam.popup = TRUE
 #    CALL cl_err()
 # 
 #    LET r_success = FALSE
 #    RETURN r_success
 # END IF
  DISPLAY BY NAME g_fabe_m.fabe001,g_fabe_m.fabe002,g_fabe_m.fabe000,g_fabe_m.fabe003, 
                      g_fabe_m.fabe004,g_fabe_m.fabe045,g_fabe_m.fabe006,g_fabe_m.fabe007,g_fabe_m.fabe005, 
                      g_fabe_m.fabe008,g_fabe_m.fabestus,g_fabe_m.fabe014,g_fabe_m.fabe015,g_fabe_m.fabe016, 
                      g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018,g_fabe_m.fabe019,g_fabe_m.fabe020, 
                      g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024,g_fabe_m.fabe025, 
                      g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029,g_fabe_m.fabe030, 
                      g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009,g_fabe_m.fabe010, 
                      g_fabe_m.fabe011,g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034,g_fabe_m.fabe035, 
                      g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044,g_fabe_m.fabe041, 
                      g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040,g_fabe_m.fabeownid,g_fabe_m.fabeowndp, 
                      g_fabe_m.fabecrtid,g_fabe_m.fabecrtdp,g_fabe_m.fabecrtdt,g_fabe_m.fabemodid,g_fabe_m.fabemoddt
  RETURN r_success
END FUNCTION
# 重設comment
PRIVATE FUNCTION afat420_hint_show_reset_comments(ps_table,p_n)
   DEFINE ps_table          STRING
   DEFINE p_n               LIKE type_t.chr1
   DEFINE li_i              LIKE type_t.num10
   DEFINE lnode_item        om.DomNode,
          lnode_child       om.DomNode,
          llst_items        om.NodeList
   DEFINE ls_item_name      STRING
   DEFINE lc_comment        STRING
   DEFINE lc_att_value      STRING
   DEFINE lwin_curr         ui.Window,
          lnode_win         om.DomNode


   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
                                                                                      
   IF p_n = 0 THEN
      LET llst_items = lnode_win.selectByTagName("FormField")
   ELSE
      LET llst_items = lnode_win.selectByTagName("TableColumn")
   END IF

   FOR li_i = 1 TO llst_items.getLength()
      LET lnode_item = llst_items.item(li_i)
      LET ls_item_name = lnode_item.getAttribute("name")
      IF ls_item_name IS NULL THEN
         LET ls_item_name = lnode_item.getAttribute("colName")
      END IF

      IF (ls_item_name IS NULL) THEN
         CONTINUE FOR
      END IF

      IF ls_item_name.subString(1,ls_item_name.getIndexOf('.',1)-1) <> ps_table THEN
         CONTINUE FOR
      END IF

      IF lnode_item.getTagName() = 'FormField' OR
         lnode_item.getTagName() = 'TableColumn' THEN
         LET lnode_child = lnode_item.getFirstChild()
         LET lc_att_value = 'cmt_',ls_item_name.subString(ls_item_name.getIndexOf('.',1)+1,ls_item_name.getLength())
         CALL lnode_child.setAttribute("comment",lc_att_value)
      END IF
   END FOR
END FUNCTION
# 設定欄位的comments
PRIVATE FUNCTION afat420_hint_show_set_comments(ps_fields,ps_att_value)
   DEFINE ps_fields          STRING,
          ps_att_value       STRING
   DEFINE lst_fields         base.StringTokenizer,
          lst_string         base.StringTokenizer,
          ls_field_name      STRING,
          ls_field_value     STRING
   DEFINE lnode_root         om.DomNode,
          lnode_win          om.DomNode,
          llst_items         om.NodeList,
          li_i               LIKE type_t.num5,
          lnode_item         om.DomNode,
          lnode_child        om.DomNode,
          ls_item_name       STRING
   DEFINE g_chg              DYNAMIC ARRAY OF RECORD
          item               STRING,
          value              STRING
                             END RECORD
   DEFINE lwin_curr          ui.Window

   IF (ps_fields IS NULL) THEN
      RETURN
   ELSE
      LET ps_fields = ps_fields.toLowerCase()
   END IF

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()

   LET llst_items = lnode_win.selectByPath("//Form//*")
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
   LET lst_string = base.StringTokenizer.create(ps_att_value,"|")
   WHILE lst_fields.hasMoreTokens() AND lst_string.hasMoreTokens()
      LET ls_field_name = lst_fields.nextToken()
      LET ls_field_value = lst_string.nextToken()
      LET ls_field_name = ls_field_name.trim()

      FOR li_i = 1 TO llst_items.getLength()
         LET lnode_item = llst_items.item(li_i)
         LET ls_item_name = lnode_item.getAttribute("colName")

         IF (ls_item_name IS NULL) THEN
            LET ls_item_name = lnode_item.getAttribute("name")

            IF (ls_item_name IS NULL) THEN
               CONTINUE FOR
            END IF
         END IF

         IF (ls_item_name.equals(ls_field_name)) THEN
            LET lnode_child = lnode_item.getFirstChild()
            CALL lnode_child.setAttribute("comment",ls_field_value)
            EXIT FOR
         END IF
      END FOR
   END WHILE
END FUNCTION
# 更新固定資產基礎資料檔
PRIVATE FUNCTION afat420_faah_upd()
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   
   UPDATE faah_t SET (faah001,faah002,faah000,faah003,faah004,faah006,faah007,faah005, 
                   faah008,faah014,faah015,faah016,faah042,faah017,faah018,faah019,faah020, 
                   faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031, 
                   faah032,faah033,faah009,faah010,faah011,faah012,faah013,faah034,faah035,faah036,faah037, 
                   faah043,faah044,faah041,faah038,faah039,faah040) = (g_fabe_m.fabe001,g_fabe_m.fabe002,
                   g_fabe_m.fabe000, g_fabe_m.fabe003,g_fabe_m.fabe004,g_fabe_m.fabe006,g_fabe_m.fabe007, 
                   g_fabe_m.fabe005,g_fabe_m.fabe008,g_fabe_m.fabe014,g_fabe_m.fabe015, 
                   g_fabe_m.fabe016,g_fabe_m.fabe042,g_fabe_m.fabe017,g_fabe_m.fabe018,g_fabe_m.fabe019, 
                   g_fabe_m.fabe020,g_fabe_m.fabe021,g_fabe_m.fabe022,g_fabe_m.fabe023,g_fabe_m.fabe024, 
                   g_fabe_m.fabe025,g_fabe_m.fabe026,g_fabe_m.fabe027,g_fabe_m.fabe028,g_fabe_m.fabe029, 
                   g_fabe_m.fabe030,g_fabe_m.fabe031,g_fabe_m.fabe032,g_fabe_m.fabe033,g_fabe_m.fabe009, 
                   g_fabe_m.fabe010,g_fabe_m.fabe011,g_fabe_m.fabe012,g_fabe_m.fabe013,g_fabe_m.fabe034, 
                   g_fabe_m.fabe035,g_fabe_m.fabe036,g_fabe_m.fabe037,g_fabe_m.fabe043,g_fabe_m.fabe044, 
                   g_fabe_m.fabe041,g_fabe_m.fabe038,g_fabe_m.fabe039,g_fabe_m.fabe040)
                WHERE faahent = g_enterprise 
                  AND faah001 = g_fabe_m.fabe001
                  AND faah003 = g_fabe_m.fabe003
                  AND faah004 = g_fabe_m.fabe004
                  
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
