#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0028(2016-10-21 14:09:48), PR版次:0028(2016-11-21 14:38:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000463
#+ Filename...: ammt320
#+ Description: 會員卡種基本資料申請作業
#+ Creator....: 01752(2013-07-31 14:34:11)
#+ Modifier...: 00700 -SD/PR- 02159
 
{</section>}
 
{<section id="ammt320.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: #160411-00034#1 2016/04/12 dongsz 卡种改为不可储值时，判断是否有储值记录的卡
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
#160604-00009#46  2016/06/20 by 08172   营运组织开窗修改
#160604-00009#65  2016/06/20 by 08172   卡记名金额默认
#160615-00046#2   2016/06/20 by 08172   效期规则起算基准修改
#160604-00009#105 2016/06/28 by 08172   新增加值类型
#160705-00042#6   2016/07/12 by sakura  查詢程式段q_ooba002_1開窗，呼叫開窗前的g_qryparam.arg若是要傳入程式代號，要改傳入g_prog
#160726-00023#1   2016/07/27 by 08172   外社卡勾选时栏位关闭清空
#160816-00068#4   2016/08/18 By earl    調整transaction
#160818-00017#21  2016/08/24 By 08742   删除修改未重新判断状态码
#160905-00007#6   2016/09/05 By 02599   SQL条件增加ent
#160728-00006#37  2016/09/07 by 08172   卡异动明细生成方式新增不管库存
#160819-00054#26  2016/10/21 by rainy   增加 與其它卡種同時使用(mmak072)/參加促銷金額(mmak073)
#160824-00007#110 2016/11/21 By sakura  新舊值備份處理
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_mmak_m RECORD
       mmaksite LIKE mmak_t.mmaksite, 
   mmaksite_desc LIKE type_t.chr80, 
   mmakdocdt LIKE mmak_t.mmakdocdt, 
   mmakdocno LIKE mmak_t.mmakdocno, 
   mmak000 LIKE mmak_t.mmak000, 
   mmak001 LIKE mmak_t.mmak001, 
   mmak002 LIKE mmak_t.mmak002, 
   mmakunit LIKE mmak_t.mmakunit, 
   mmak004_desc LIKE type_t.chr80, 
   mmak004 LIKE mmak_t.mmak004, 
   mmakl002 LIKE mmakl_t.mmakl002, 
   mmakl003 LIKE mmakl_t.mmakl003, 
   mmak066 LIKE mmak_t.mmak066, 
   mmak003 LIKE mmak_t.mmak003, 
   mmakacti LIKE mmak_t.mmakacti, 
   mmakstus LIKE mmak_t.mmakstus, 
   mmakownid LIKE mmak_t.mmakownid, 
   mmakownid_desc LIKE type_t.chr80, 
   mmakowndp LIKE mmak_t.mmakowndp, 
   mmakowndp_desc LIKE type_t.chr80, 
   mmakcrtid LIKE mmak_t.mmakcrtid, 
   mmakcrtid_desc LIKE type_t.chr80, 
   mmakcrtdp LIKE mmak_t.mmakcrtdp, 
   mmakcrtdp_desc LIKE type_t.chr80, 
   mmakcrtdt LIKE mmak_t.mmakcrtdt, 
   mmakmodid LIKE mmak_t.mmakmodid, 
   mmakmodid_desc LIKE type_t.chr80, 
   mmakmoddt LIKE mmak_t.mmakmoddt, 
   mmakcnfid LIKE mmak_t.mmakcnfid, 
   mmakcnfid_desc LIKE type_t.chr80, 
   mmakcnfdt LIKE mmak_t.mmakcnfdt, 
   mmak005 LIKE mmak_t.mmak005, 
   mmak006 LIKE mmak_t.mmak006, 
   mmak007 LIKE mmak_t.mmak007, 
   mmak008 LIKE mmak_t.mmak008, 
   mmak009 LIKE mmak_t.mmak009, 
   mmak010 LIKE mmak_t.mmak010, 
   mmak011 LIKE mmak_t.mmak011, 
   mmak012 LIKE mmak_t.mmak012, 
   mmak012_desc LIKE type_t.chr80, 
   mmak013 LIKE mmak_t.mmak013, 
   mmak014 LIKE mmak_t.mmak014, 
   mmak015 LIKE mmak_t.mmak015, 
   mmak069 LIKE mmak_t.mmak069, 
   mmak016 LIKE mmak_t.mmak016, 
   mmak017 LIKE mmak_t.mmak017, 
   mmak018 LIKE mmak_t.mmak018, 
   mmak019 LIKE mmak_t.mmak019, 
   mmak020 LIKE mmak_t.mmak020, 
   mmak021 LIKE mmak_t.mmak021, 
   mmak022 LIKE mmak_t.mmak022, 
   mmak023 LIKE mmak_t.mmak023, 
   mmak024 LIKE mmak_t.mmak024, 
   mmak025 LIKE mmak_t.mmak025, 
   mmak062 LIKE mmak_t.mmak062, 
   mmak063 LIKE mmak_t.mmak063, 
   mmak026 LIKE mmak_t.mmak026, 
   mmak064 LIKE mmak_t.mmak064, 
   mmak053 LIKE mmak_t.mmak053, 
   mmak053_desc LIKE type_t.chr80, 
   mmak060 LIKE mmak_t.mmak060, 
   mmak060_desc LIKE type_t.chr80, 
   mmak054 LIKE mmak_t.mmak054, 
   mmak054_desc LIKE type_t.chr80, 
   mmak061 LIKE mmak_t.mmak061, 
   mmak058 LIKE mmak_t.mmak058, 
   mmak058_desc LIKE type_t.chr80, 
   mmak072 LIKE mmak_t.mmak072, 
   mmak057 LIKE mmak_t.mmak057, 
   mmak057_desc LIKE type_t.chr80, 
   mmak073 LIKE mmak_t.mmak073, 
   mmak059 LIKE mmak_t.mmak059, 
   mmak027 LIKE mmak_t.mmak027, 
   mmak028 LIKE mmak_t.mmak028, 
   mmak029 LIKE mmak_t.mmak029, 
   mmak030 LIKE mmak_t.mmak030, 
   mmak067 LIKE mmak_t.mmak067, 
   mmak068 LIKE mmak_t.mmak068, 
   mmak036 LIKE mmak_t.mmak036, 
   mmak037 LIKE mmak_t.mmak037, 
   mmak031 LIKE mmak_t.mmak031, 
   mmak032 LIKE mmak_t.mmak032, 
   mmak033 LIKE mmak_t.mmak033, 
   mmak034 LIKE mmak_t.mmak034, 
   mmak035 LIKE mmak_t.mmak035, 
   mmak070 LIKE mmak_t.mmak070, 
   mmak038 LIKE mmak_t.mmak038, 
   mmak039 LIKE mmak_t.mmak039, 
   mmak040 LIKE mmak_t.mmak040, 
   mmak041 LIKE mmak_t.mmak041, 
   mmak055 LIKE mmak_t.mmak055, 
   mmak056 LIKE mmak_t.mmak056, 
   mmak042 LIKE mmak_t.mmak042, 
   mmak043 LIKE mmak_t.mmak043, 
   mmak065 LIKE mmak_t.mmak065, 
   mmak044 LIKE mmak_t.mmak044, 
   mmak045 LIKE mmak_t.mmak045, 
   mmak046 LIKE mmak_t.mmak046, 
   mmak047 LIKE mmak_t.mmak047, 
   mmak048 LIKE mmak_t.mmak048, 
   mmak049 LIKE mmak_t.mmak049, 
   mmak071 LIKE mmak_t.mmak071, 
   mmak050 LIKE mmak_t.mmak050, 
   mmak051 LIKE mmak_t.mmak051, 
   mmak052 LIKE mmak_t.mmak052
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_mmakdocno LIKE mmak_t.mmakdocno
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004  #參照表編號
#end add-point
 
#模組變數(Module Variables)
DEFINE g_mmak_m        type_g_mmak_m  #單頭變數宣告
DEFINE g_mmak_m_t      type_g_mmak_m  #單頭舊值宣告(系統還原用)
DEFINE g_mmak_m_o      type_g_mmak_m  #單頭舊值宣告(其他用途)
DEFINE g_mmak_m_mask_o type_g_mmak_m  #轉換遮罩前資料
DEFINE g_mmak_m_mask_n type_g_mmak_m  #轉換遮罩後資料
 
   DEFINE g_mmakdocno_t LIKE mmak_t.mmakdocno
 
   
 
   
DEFINE g_master_multi_table_t    RECORD
      mmakldocno LIKE mmakl_t.mmakldocno,
      mmakl002 LIKE mmakl_t.mmakl002,
      mmakl003 LIKE mmakl_t.mmakl003
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
DEFINE g_site_flag   LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="ammt320.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
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
   LET g_forupd_sql = " SELECT mmaksite,'',mmakdocdt,mmakdocno,mmak000,mmak001,mmak002,mmakunit,'',mmak004, 
       '','',mmak066,mmak003,mmakacti,mmakstus,mmakownid,'',mmakowndp,'',mmakcrtid,'',mmakcrtdp,'',mmakcrtdt, 
       mmakmodid,'',mmakmoddt,mmakcnfid,'',mmakcnfdt,mmak005,mmak006,mmak007,mmak008,mmak009,mmak010, 
       mmak011,mmak012,'',mmak013,mmak014,mmak015,mmak069,mmak016,mmak017,mmak018,mmak019,mmak020,mmak021, 
       mmak022,mmak023,mmak024,mmak025,mmak062,mmak063,mmak026,mmak064,mmak053,'',mmak060,'',mmak054, 
       '',mmak061,mmak058,'',mmak072,mmak057,'',mmak073,mmak059,mmak027,mmak028,mmak029,mmak030,mmak067, 
       mmak068,mmak036,mmak037,mmak031,mmak032,mmak033,mmak034,mmak035,mmak070,mmak038,mmak039,mmak040, 
       mmak041,mmak055,mmak056,mmak042,mmak043,mmak065,mmak044,mmak045,mmak046,mmak047,mmak048,mmak049, 
       mmak071,mmak050,mmak051,mmak052", 
                      " FROM mmak_t",
                      " WHERE mmakent= ? AND mmakdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt320_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mmaksite,t0.mmakdocdt,t0.mmakdocno,t0.mmak000,t0.mmak001,t0.mmak002, 
       t0.mmakunit,t0.mmak004,t0.mmak066,t0.mmak003,t0.mmakacti,t0.mmakstus,t0.mmakownid,t0.mmakowndp, 
       t0.mmakcrtid,t0.mmakcrtdp,t0.mmakcrtdt,t0.mmakmodid,t0.mmakmoddt,t0.mmakcnfid,t0.mmakcnfdt,t0.mmak005, 
       t0.mmak006,t0.mmak007,t0.mmak008,t0.mmak009,t0.mmak010,t0.mmak011,t0.mmak012,t0.mmak013,t0.mmak014, 
       t0.mmak015,t0.mmak069,t0.mmak016,t0.mmak017,t0.mmak018,t0.mmak019,t0.mmak020,t0.mmak021,t0.mmak022, 
       t0.mmak023,t0.mmak024,t0.mmak025,t0.mmak062,t0.mmak063,t0.mmak026,t0.mmak064,t0.mmak053,t0.mmak060, 
       t0.mmak054,t0.mmak061,t0.mmak058,t0.mmak072,t0.mmak057,t0.mmak073,t0.mmak059,t0.mmak027,t0.mmak028, 
       t0.mmak029,t0.mmak030,t0.mmak067,t0.mmak068,t0.mmak036,t0.mmak037,t0.mmak031,t0.mmak032,t0.mmak033, 
       t0.mmak034,t0.mmak035,t0.mmak070,t0.mmak038,t0.mmak039,t0.mmak040,t0.mmak041,t0.mmak055,t0.mmak056, 
       t0.mmak042,t0.mmak043,t0.mmak065,t0.mmak044,t0.mmak045,t0.mmak046,t0.mmak047,t0.mmak048,t0.mmak049, 
       t0.mmak071,t0.mmak050,t0.mmak051,t0.mmak052,t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooag011 ,t9.imaal003 ,t10.imaal003 ,t11.imaal003 ,t12.imaal003 , 
       t13.ooail003 ,t14.ooail003",
               " FROM mmak_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmaksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mmak004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.mmakownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.mmakowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.mmakcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.mmakcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mmakmodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mmakcnfid  ",
               " LEFT JOIN imaal_t t9 ON t9.imaalent="||g_enterprise||" AND t9.imaal001=t0.mmak012 AND t9.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t10 ON t10.imaalent="||g_enterprise||" AND t10.imaal001=t0.mmak053 AND t10.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t11 ON t11.imaalent="||g_enterprise||" AND t11.imaal001=t0.mmak060 AND t11.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t12 ON t12.imaalent="||g_enterprise||" AND t12.imaal001=t0.mmak054 AND t12.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t13 ON t13.ooailent="||g_enterprise||" AND t13.ooail001=t0.mmak058 AND t13.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t14 ON t14.ooailent="||g_enterprise||" AND t14.ooail001=t0.mmak057 AND t14.ooail002='"||g_dlang||"' ",
 
               " WHERE t0.mmakent = " ||g_enterprise|| " AND t0.mmakdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ammt320_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammt320 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammt320_init()   
 
      #進入選單 Menu (="N")
      CALL ammt320_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammt320
      
   END IF 
   
   CLOSE ammt320_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammt320.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt320_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('mmakstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mmak000','32') 
   CALL cl_set_combo_scc('mmak066','6823') 
   CALL cl_set_combo_scc('mmak009','6505') 
   CALL cl_set_combo_scc('mmak019','6506') 
   CALL cl_set_combo_scc('mmak020','6507') 
   CALL cl_set_combo_scc('mmak059','6021') 
   CALL cl_set_combo_scc('mmak028','6503') 
   CALL cl_set_combo_scc('mmak036','6509') 
   CALL cl_set_combo_scc('mmak037','12') 
   CALL cl_set_combo_scc('mmak031','6504') 
   CALL cl_set_combo_scc('mmak071','6947') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_ooef004 = ''
   SELECT ooef004 INTO g_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   LET g_errshow = '1'
   CALL cl_set_combo_scc('mmak061','6778')
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   CALL cl_set_combo_scc('mmak063','6788') #150429-00001#2 150430 geza add

   #end add-point
   
   #根據外部參數進行搜尋
   CALL ammt320_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt320.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ammt320_ui_dialog() 
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
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL ammt320_insert()
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
         INITIALIZE g_mmak_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL ammt320_init()
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
               CALL ammt320_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL ammt320_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL ammt320_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL ammt320_set_act_visible()
               CALL ammt320_set_act_no_visible()
               IF NOT (g_mmak_m.mmakdocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " mmakent = " ||g_enterprise|| " AND",
                                     " mmakdocno = '", g_mmak_m.mmakdocno, "' "
 
                  #填到對應位置
                  CALL ammt320_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL ammt320_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL ammt320_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL ammt320_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL ammt320_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL ammt320_fetch("L")  
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
                  CALL ammt320_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL ammt320_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt320_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL ammt320_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_ammt320_01
            LET g_action_choice="open_ammt320_01"
            IF cl_auth_chk_act("open_ammt320_01") THEN
               
               #add-point:ON ACTION open_ammt320_01 name="menu2.open_ammt320_01"
               IF NOT cl_null(g_mmak_m.mmakdocno) AND NOT cl_null(g_mmak_m.mmak000) AND 
                  NOT cl_null(g_mmak_m.mmak001) THEN
                  CALL ammt320_01(g_mmak_m.mmakdocno,g_mmak_m.mmak000,'ammt320',g_mmak_m.mmak001)
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00129'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_ammt320_02
            LET g_action_choice="open_ammt320_02"
            IF cl_auth_chk_act("open_ammt320_02") THEN
               
               #add-point:ON ACTION open_ammt320_02 name="menu2.open_ammt320_02"
               IF NOT cl_null(g_mmak_m.mmakdocno) AND NOT cl_null(g_mmak_m.mmak000) AND 
                  NOT cl_null(g_mmak_m.mmak001) THEN
                  IF g_mmak_m.mmak023 = 'Y' THEN
                     CALL ammt320_02(g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001)
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00135'
                     LET g_errparam.extend = g_mmak_m.mmak001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
            
                  END IF                  
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00129'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt320_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt320_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/amm/ammt320_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/amm/ammt320_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL ammt320_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt320_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu2.bpm_status"
            
            #END add-point
 
 
 
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt320_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt320_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt320_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mmak_m.mmakdocdt)
 
 
 
            
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
                  CALL ammt320_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL ammt320_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL ammt320_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL ammt320_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL ammt320_set_act_visible()
               CALL ammt320_set_act_no_visible()
               IF NOT (g_mmak_m.mmakdocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " mmakent = " ||g_enterprise|| " AND",
                                     " mmakdocno = '", g_mmak_m.mmakdocno, "' "
 
                  #填到對應位置
                  CALL ammt320_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL ammt320_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL ammt320_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL ammt320_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL ammt320_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL ammt320_fetch("L")  
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
                  CALL ammt320_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL ammt320_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt320_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL ammt320_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_ammt320_01
            LET g_action_choice="open_ammt320_01"
            IF cl_auth_chk_act("open_ammt320_01") THEN
               
               #add-point:ON ACTION open_ammt320_01 name="menu.open_ammt320_01"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_ammt320_02
            LET g_action_choice="open_ammt320_02"
            IF cl_auth_chk_act("open_ammt320_02") THEN
               
               #add-point:ON ACTION open_ammt320_02 name="menu.open_ammt320_02"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt320_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt320_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amm/ammt320_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amm/ammt320_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL ammt320_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt320_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt320_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt320_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt320_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mmak_m.mmakdocdt)
 
 
 
 
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
 
{<section id="ammt320.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION ammt320_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING #sakura add
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "mmakdocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   IF p_wc = "1=2" THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM mmak_t ",
               "  ",
               "  LEFT JOIN mmakl_t ON mmaklent = "||g_enterprise||" AND mmakdocno = mmakldocno AND mmakl001 = '",g_dlang,"' ",
               " WHERE mmakent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("mmak_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   CALL s_aooi500_sql_where(g_prog,'mmaksite') RETURNING l_where #sakura add
   LET g_sql = g_sql," AND ", l_where                            #sakura add
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
      INITIALIZE g_mmak_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.mmakstus,t0.mmakdocno",
               " FROM mmak_t t0 ",
               "  ",
               
               " LEFT JOIN mmakl_t ON mmaklent = "||g_enterprise||" AND mmakdocno = mmakldocno AND mmakl001 = '",g_dlang,"' ",
               " WHERE t0.mmakent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("mmak_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   LET g_sql = g_sql, " AND ", l_where  #sakura add
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmak_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmakdocno
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
   
   IF cl_null(g_browser[g_cnt].b_mmakdocno) THEN
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
 
{<section id="ammt320.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt320_construct()
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
   INITIALIZE g_mmak_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON mmaksite,mmakdocdt,mmakdocno,mmak000,mmak001,mmak002,mmakunit,mmak004, 
          mmakl002,mmakl003,mmak066,mmak003,mmakacti,mmakstus,mmakownid,mmakowndp,mmakcrtid,mmakcrtdp, 
          mmakcrtdt,mmakmodid,mmakmoddt,mmakcnfid,mmakcnfdt,mmak005,mmak006,mmak007,mmak008,mmak009, 
          mmak010,mmak011,mmak012,mmak013,mmak014,mmak015,mmak069,mmak016,mmak017,mmak018,mmak019,mmak020, 
          mmak021,mmak022,mmak023,mmak024,mmak025,mmak062,mmak063,mmak026,mmak064,mmak053,mmak060,mmak054, 
          mmak061,mmak058,mmak072,mmak057,mmak073,mmak059,mmak027,mmak028,mmak029,mmak030,mmak067,mmak068, 
          mmak036,mmak037,mmak031,mmak032,mmak033,mmak034,mmak035,mmak070,mmak038,mmak039,mmak040,mmak041, 
          mmak055,mmak056,mmak042,mmak043,mmak065,mmak044,mmak045,mmak046,mmak047,mmak048,mmak049,mmak071, 
          mmak050,mmak051,mmak052
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmakcrtdt>>----
         AFTER FIELD mmakcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmakmoddt>>----
         AFTER FIELD mmakmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmakcnfdt>>----
         AFTER FIELD mmakcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmakpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.mmaksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaksite
            #add-point:ON ACTION controlp INFIELD mmaksite name="construct.c.mmaksite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #sakura---mark---str
           #LET g_qryparam.arg1 = g_site
           #LET g_qryparam.arg2 = '8'
           #CALL q_ooed004()                           #呼叫開窗
           #sakura---mark---end
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaksite',g_site,'c') #sakura add #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                     #呼叫開窗                   #sakura add
            DISPLAY g_qryparam.return1 TO mmaksite  #顯示到畫面上
            NEXT FIELD mmaksite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaksite
            #add-point:BEFORE FIELD mmaksite name="construct.b.mmaksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaksite
            
            #add-point:AFTER FIELD mmaksite name="construct.a.mmaksite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakdocdt
            #add-point:BEFORE FIELD mmakdocdt name="construct.b.mmakdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakdocdt
            
            #add-point:AFTER FIELD mmakdocdt name="construct.a.mmakdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakdocdt
            #add-point:ON ACTION controlp INFIELD mmakdocdt name="construct.c.mmakdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmakdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakdocno
            #add-point:ON ACTION controlp INFIELD mmakdocno name="construct.c.mmakdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_mmakdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmakdocno  #顯示到畫面上

            NEXT FIELD mmakdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakdocno
            #add-point:BEFORE FIELD mmakdocno name="construct.b.mmakdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakdocno
            
            #add-point:AFTER FIELD mmakdocno name="construct.a.mmakdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak000
            #add-point:BEFORE FIELD mmak000 name="construct.b.mmak000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak000
            
            #add-point:AFTER FIELD mmak000 name="construct.a.mmak000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak000
            #add-point:ON ACTION controlp INFIELD mmak000 name="construct.c.mmak000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmak001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak001
            #add-point:ON ACTION controlp INFIELD mmak001 name="construct.c.mmak001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_mmak001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmak001  #顯示到畫面上

            NEXT FIELD mmak001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak001
            #add-point:BEFORE FIELD mmak001 name="construct.b.mmak001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak001
            
            #add-point:AFTER FIELD mmak001 name="construct.a.mmak001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak002
            #add-point:BEFORE FIELD mmak002 name="construct.b.mmak002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak002
            
            #add-point:AFTER FIELD mmak002 name="construct.a.mmak002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak002
            #add-point:ON ACTION controlp INFIELD mmak002 name="construct.c.mmak002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakunit
            #add-point:BEFORE FIELD mmakunit name="construct.b.mmakunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakunit
            
            #add-point:AFTER FIELD mmakunit name="construct.a.mmakunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakunit
            #add-point:ON ACTION controlp INFIELD mmakunit name="construct.c.mmakunit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmak004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak004
            #add-point:ON ACTION controlp INFIELD mmak004 name="construct.c.mmak004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = '2'
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmak004  #顯示到畫面上

            NEXT FIELD mmak004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak004
            #add-point:BEFORE FIELD mmak004 name="construct.b.mmak004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak004
            
            #add-point:AFTER FIELD mmak004 name="construct.a.mmak004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakl002
            #add-point:BEFORE FIELD mmakl002 name="construct.b.mmakl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakl002
            
            #add-point:AFTER FIELD mmakl002 name="construct.a.mmakl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakl002
            #add-point:ON ACTION controlp INFIELD mmakl002 name="construct.c.mmakl002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakl003
            #add-point:BEFORE FIELD mmakl003 name="construct.b.mmakl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakl003
            
            #add-point:AFTER FIELD mmakl003 name="construct.a.mmakl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakl003
            #add-point:ON ACTION controlp INFIELD mmakl003 name="construct.c.mmakl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak066
            #add-point:BEFORE FIELD mmak066 name="construct.b.mmak066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak066
            
            #add-point:AFTER FIELD mmak066 name="construct.a.mmak066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak066
            #add-point:ON ACTION controlp INFIELD mmak066 name="construct.c.mmak066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak003
            #add-point:BEFORE FIELD mmak003 name="construct.b.mmak003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak003
            
            #add-point:AFTER FIELD mmak003 name="construct.a.mmak003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak003
            #add-point:ON ACTION controlp INFIELD mmak003 name="construct.c.mmak003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakacti
            #add-point:BEFORE FIELD mmakacti name="construct.b.mmakacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakacti
            
            #add-point:AFTER FIELD mmakacti name="construct.a.mmakacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakacti
            #add-point:ON ACTION controlp INFIELD mmakacti name="construct.c.mmakacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakstus
            #add-point:BEFORE FIELD mmakstus name="construct.b.mmakstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakstus
            
            #add-point:AFTER FIELD mmakstus name="construct.a.mmakstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakstus
            #add-point:ON ACTION controlp INFIELD mmakstus name="construct.c.mmakstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmakownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakownid
            #add-point:ON ACTION controlp INFIELD mmakownid name="construct.c.mmakownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmakownid  #顯示到畫面上

            NEXT FIELD mmakownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakownid
            #add-point:BEFORE FIELD mmakownid name="construct.b.mmakownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakownid
            
            #add-point:AFTER FIELD mmakownid name="construct.a.mmakownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakowndp
            #add-point:ON ACTION controlp INFIELD mmakowndp name="construct.c.mmakowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmakowndp  #顯示到畫面上

            NEXT FIELD mmakowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakowndp
            #add-point:BEFORE FIELD mmakowndp name="construct.b.mmakowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakowndp
            
            #add-point:AFTER FIELD mmakowndp name="construct.a.mmakowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakcrtid
            #add-point:ON ACTION controlp INFIELD mmakcrtid name="construct.c.mmakcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmakcrtid  #顯示到畫面上

            NEXT FIELD mmakcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakcrtid
            #add-point:BEFORE FIELD mmakcrtid name="construct.b.mmakcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakcrtid
            
            #add-point:AFTER FIELD mmakcrtid name="construct.a.mmakcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmakcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakcrtdp
            #add-point:ON ACTION controlp INFIELD mmakcrtdp name="construct.c.mmakcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmakcrtdp  #顯示到畫面上

            NEXT FIELD mmakcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakcrtdp
            #add-point:BEFORE FIELD mmakcrtdp name="construct.b.mmakcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakcrtdp
            
            #add-point:AFTER FIELD mmakcrtdp name="construct.a.mmakcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakcrtdt
            #add-point:BEFORE FIELD mmakcrtdt name="construct.b.mmakcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmakmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakmodid
            #add-point:ON ACTION controlp INFIELD mmakmodid name="construct.c.mmakmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmakmodid  #顯示到畫面上

            NEXT FIELD mmakmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakmodid
            #add-point:BEFORE FIELD mmakmodid name="construct.b.mmakmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakmodid
            
            #add-point:AFTER FIELD mmakmodid name="construct.a.mmakmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakmoddt
            #add-point:BEFORE FIELD mmakmoddt name="construct.b.mmakmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmakcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakcnfid
            #add-point:ON ACTION controlp INFIELD mmakcnfid name="construct.c.mmakcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmakcnfid  #顯示到畫面上

            NEXT FIELD mmakcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakcnfid
            #add-point:BEFORE FIELD mmakcnfid name="construct.b.mmakcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakcnfid
            
            #add-point:AFTER FIELD mmakcnfid name="construct.a.mmakcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakcnfdt
            #add-point:BEFORE FIELD mmakcnfdt name="construct.b.mmakcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak005
            #add-point:BEFORE FIELD mmak005 name="construct.b.mmak005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak005
            
            #add-point:AFTER FIELD mmak005 name="construct.a.mmak005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak005
            #add-point:ON ACTION controlp INFIELD mmak005 name="construct.c.mmak005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak006
            #add-point:BEFORE FIELD mmak006 name="construct.b.mmak006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak006
            
            #add-point:AFTER FIELD mmak006 name="construct.a.mmak006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak006
            #add-point:ON ACTION controlp INFIELD mmak006 name="construct.c.mmak006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak007
            #add-point:BEFORE FIELD mmak007 name="construct.b.mmak007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak007
            
            #add-point:AFTER FIELD mmak007 name="construct.a.mmak007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak007
            #add-point:ON ACTION controlp INFIELD mmak007 name="construct.c.mmak007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak008
            #add-point:BEFORE FIELD mmak008 name="construct.b.mmak008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak008
            
            #add-point:AFTER FIELD mmak008 name="construct.a.mmak008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak008
            #add-point:ON ACTION controlp INFIELD mmak008 name="construct.c.mmak008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak009
            #add-point:BEFORE FIELD mmak009 name="construct.b.mmak009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak009
            
            #add-point:AFTER FIELD mmak009 name="construct.a.mmak009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak009
            #add-point:ON ACTION controlp INFIELD mmak009 name="construct.c.mmak009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak010
            #add-point:BEFORE FIELD mmak010 name="construct.b.mmak010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak010
            
            #add-point:AFTER FIELD mmak010 name="construct.a.mmak010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak010
            #add-point:ON ACTION controlp INFIELD mmak010 name="construct.c.mmak010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak011
            #add-point:BEFORE FIELD mmak011 name="construct.b.mmak011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak011
            
            #add-point:AFTER FIELD mmak011 name="construct.a.mmak011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak011
            #add-point:ON ACTION controlp INFIELD mmak011 name="construct.c.mmak011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmak012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak012
            #add-point:ON ACTION controlp INFIELD mmak012 name="construct.c.mmak012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmak012  #顯示到畫面上

            NEXT FIELD mmak012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak012
            #add-point:BEFORE FIELD mmak012 name="construct.b.mmak012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak012
            
            #add-point:AFTER FIELD mmak012 name="construct.a.mmak012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak013
            #add-point:BEFORE FIELD mmak013 name="construct.b.mmak013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak013
            
            #add-point:AFTER FIELD mmak013 name="construct.a.mmak013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak013
            #add-point:ON ACTION controlp INFIELD mmak013 name="construct.c.mmak013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak014
            #add-point:BEFORE FIELD mmak014 name="construct.b.mmak014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak014
            
            #add-point:AFTER FIELD mmak014 name="construct.a.mmak014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak014
            #add-point:ON ACTION controlp INFIELD mmak014 name="construct.c.mmak014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak015
            #add-point:BEFORE FIELD mmak015 name="construct.b.mmak015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak015
            
            #add-point:AFTER FIELD mmak015 name="construct.a.mmak015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak015
            #add-point:ON ACTION controlp INFIELD mmak015 name="construct.c.mmak015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak069
            #add-point:BEFORE FIELD mmak069 name="construct.b.mmak069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak069
            
            #add-point:AFTER FIELD mmak069 name="construct.a.mmak069"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak069
            #add-point:ON ACTION controlp INFIELD mmak069 name="construct.c.mmak069"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak016
            #add-point:BEFORE FIELD mmak016 name="construct.b.mmak016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak016
            
            #add-point:AFTER FIELD mmak016 name="construct.a.mmak016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak016
            #add-point:ON ACTION controlp INFIELD mmak016 name="construct.c.mmak016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak017
            #add-point:BEFORE FIELD mmak017 name="construct.b.mmak017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak017
            
            #add-point:AFTER FIELD mmak017 name="construct.a.mmak017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak017
            #add-point:ON ACTION controlp INFIELD mmak017 name="construct.c.mmak017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak018
            #add-point:BEFORE FIELD mmak018 name="construct.b.mmak018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak018
            
            #add-point:AFTER FIELD mmak018 name="construct.a.mmak018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak018
            #add-point:ON ACTION controlp INFIELD mmak018 name="construct.c.mmak018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak019
            #add-point:BEFORE FIELD mmak019 name="construct.b.mmak019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak019
            
            #add-point:AFTER FIELD mmak019 name="construct.a.mmak019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak019
            #add-point:ON ACTION controlp INFIELD mmak019 name="construct.c.mmak019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak020
            #add-point:BEFORE FIELD mmak020 name="construct.b.mmak020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak020
            
            #add-point:AFTER FIELD mmak020 name="construct.a.mmak020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak020
            #add-point:ON ACTION controlp INFIELD mmak020 name="construct.c.mmak020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak021
            #add-point:BEFORE FIELD mmak021 name="construct.b.mmak021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak021
            
            #add-point:AFTER FIELD mmak021 name="construct.a.mmak021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak021
            #add-point:ON ACTION controlp INFIELD mmak021 name="construct.c.mmak021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak022
            #add-point:BEFORE FIELD mmak022 name="construct.b.mmak022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak022
            
            #add-point:AFTER FIELD mmak022 name="construct.a.mmak022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak022
            #add-point:ON ACTION controlp INFIELD mmak022 name="construct.c.mmak022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak023
            #add-point:BEFORE FIELD mmak023 name="construct.b.mmak023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak023
            
            #add-point:AFTER FIELD mmak023 name="construct.a.mmak023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak023
            #add-point:ON ACTION controlp INFIELD mmak023 name="construct.c.mmak023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak024
            #add-point:BEFORE FIELD mmak024 name="construct.b.mmak024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak024
            
            #add-point:AFTER FIELD mmak024 name="construct.a.mmak024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak024
            #add-point:ON ACTION controlp INFIELD mmak024 name="construct.c.mmak024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak025
            #add-point:BEFORE FIELD mmak025 name="construct.b.mmak025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak025
            
            #add-point:AFTER FIELD mmak025 name="construct.a.mmak025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak025
            #add-point:ON ACTION controlp INFIELD mmak025 name="construct.c.mmak025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak062
            #add-point:BEFORE FIELD mmak062 name="construct.b.mmak062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak062
            
            #add-point:AFTER FIELD mmak062 name="construct.a.mmak062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak062
            #add-point:ON ACTION controlp INFIELD mmak062 name="construct.c.mmak062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak063
            #add-point:BEFORE FIELD mmak063 name="construct.b.mmak063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak063
            
            #add-point:AFTER FIELD mmak063 name="construct.a.mmak063"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak063
            #add-point:ON ACTION controlp INFIELD mmak063 name="construct.c.mmak063"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak026
            #add-point:BEFORE FIELD mmak026 name="construct.b.mmak026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak026
            
            #add-point:AFTER FIELD mmak026 name="construct.a.mmak026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak026
            #add-point:ON ACTION controlp INFIELD mmak026 name="construct.c.mmak026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak064
            #add-point:BEFORE FIELD mmak064 name="construct.b.mmak064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak064
            
            #add-point:AFTER FIELD mmak064 name="construct.a.mmak064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak064
            #add-point:ON ACTION controlp INFIELD mmak064 name="construct.c.mmak064"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmak053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak053
            #add-point:ON ACTION controlp INFIELD mmak053 name="construct.c.mmak053"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'c'      #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmak053  #顯示到畫面上

            NEXT FIELD mmak053                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak053
            #add-point:BEFORE FIELD mmak053 name="construct.b.mmak053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak053
            
            #add-point:AFTER FIELD mmak053 name="construct.a.mmak053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak060
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak060
            #add-point:ON ACTION controlp INFIELD mmak060 name="construct.c.mmak060"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmak060  #顯示到畫面上
            NEXT FIELD mmak060                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak060
            #add-point:BEFORE FIELD mmak060 name="construct.b.mmak060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak060
            
            #add-point:AFTER FIELD mmak060 name="construct.a.mmak060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak054
            #add-point:ON ACTION controlp INFIELD mmak054 name="construct.c.mmak054"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmak054  #顯示到畫面上

            NEXT FIELD mmak054                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak054
            #add-point:BEFORE FIELD mmak054 name="construct.b.mmak054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak054
            
            #add-point:AFTER FIELD mmak054 name="construct.a.mmak054"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak061
            #add-point:BEFORE FIELD mmak061 name="construct.b.mmak061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak061
            
            #add-point:AFTER FIELD mmak061 name="construct.a.mmak061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak061
            #add-point:ON ACTION controlp INFIELD mmak061 name="construct.c.mmak061"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmak058
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak058
            #add-point:ON ACTION controlp INFIELD mmak058 name="construct.c.mmak058"
            #此段落由子樣板a08產生 
            #20140220 By ming add ----------------------------(S) 
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.where = "ooiastus = 'Y' AND ooia002 = '60'"
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmak058      #顯示到畫面上
            NEXT FIELD mmak058                         #返回原欄位
            #20140220 By ming add ----------------------------(E) 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak058
            #add-point:BEFORE FIELD mmak058 name="construct.b.mmak058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak058
            
            #add-point:AFTER FIELD mmak058 name="construct.a.mmak058"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak072
            #add-point:BEFORE FIELD mmak072 name="construct.b.mmak072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak072
            
            #add-point:AFTER FIELD mmak072 name="construct.a.mmak072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak072
            #add-point:ON ACTION controlp INFIELD mmak072 name="construct.c.mmak072"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmak057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak057
            #add-point:ON ACTION controlp INFIELD mmak057 name="construct.c.mmak057"
            #此段落由子樣板a08產生 
            #20140220 By ming add ----------------------------(S) 
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooiastus = 'Y' AND ooia002 = '60'"
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmak057      #顯示到畫面上
            NEXT FIELD mmak057                         #返回原欄位
            #20140220 By ming add ----------------------------(E) 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak057
            #add-point:BEFORE FIELD mmak057 name="construct.b.mmak057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak057
            
            #add-point:AFTER FIELD mmak057 name="construct.a.mmak057"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak073
            #add-point:BEFORE FIELD mmak073 name="construct.b.mmak073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak073
            
            #add-point:AFTER FIELD mmak073 name="construct.a.mmak073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak073
            #add-point:ON ACTION controlp INFIELD mmak073 name="construct.c.mmak073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak059
            #add-point:BEFORE FIELD mmak059 name="construct.b.mmak059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak059
            
            #add-point:AFTER FIELD mmak059 name="construct.a.mmak059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak059
            #add-point:ON ACTION controlp INFIELD mmak059 name="construct.c.mmak059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak027
            #add-point:BEFORE FIELD mmak027 name="construct.b.mmak027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak027
            
            #add-point:AFTER FIELD mmak027 name="construct.a.mmak027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak027
            #add-point:ON ACTION controlp INFIELD mmak027 name="construct.c.mmak027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak028
            #add-point:BEFORE FIELD mmak028 name="construct.b.mmak028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak028
            
            #add-point:AFTER FIELD mmak028 name="construct.a.mmak028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak028
            #add-point:ON ACTION controlp INFIELD mmak028 name="construct.c.mmak028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak029
            #add-point:BEFORE FIELD mmak029 name="construct.b.mmak029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak029
            
            #add-point:AFTER FIELD mmak029 name="construct.a.mmak029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak029
            #add-point:ON ACTION controlp INFIELD mmak029 name="construct.c.mmak029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak030
            #add-point:BEFORE FIELD mmak030 name="construct.b.mmak030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak030
            
            #add-point:AFTER FIELD mmak030 name="construct.a.mmak030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak030
            #add-point:ON ACTION controlp INFIELD mmak030 name="construct.c.mmak030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak067
            #add-point:BEFORE FIELD mmak067 name="construct.b.mmak067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak067
            
            #add-point:AFTER FIELD mmak067 name="construct.a.mmak067"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak067
            #add-point:ON ACTION controlp INFIELD mmak067 name="construct.c.mmak067"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak068
            #add-point:BEFORE FIELD mmak068 name="construct.b.mmak068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak068
            
            #add-point:AFTER FIELD mmak068 name="construct.a.mmak068"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak068
            #add-point:ON ACTION controlp INFIELD mmak068 name="construct.c.mmak068"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak036
            #add-point:BEFORE FIELD mmak036 name="construct.b.mmak036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak036
            
            #add-point:AFTER FIELD mmak036 name="construct.a.mmak036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak036
            #add-point:ON ACTION controlp INFIELD mmak036 name="construct.c.mmak036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak037
            #add-point:BEFORE FIELD mmak037 name="construct.b.mmak037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak037
            
            #add-point:AFTER FIELD mmak037 name="construct.a.mmak037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak037
            #add-point:ON ACTION controlp INFIELD mmak037 name="construct.c.mmak037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak031
            #add-point:BEFORE FIELD mmak031 name="construct.b.mmak031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak031
            
            #add-point:AFTER FIELD mmak031 name="construct.a.mmak031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak031
            #add-point:ON ACTION controlp INFIELD mmak031 name="construct.c.mmak031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak032
            #add-point:BEFORE FIELD mmak032 name="construct.b.mmak032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak032
            
            #add-point:AFTER FIELD mmak032 name="construct.a.mmak032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak032
            #add-point:ON ACTION controlp INFIELD mmak032 name="construct.c.mmak032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak033
            #add-point:BEFORE FIELD mmak033 name="construct.b.mmak033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak033
            
            #add-point:AFTER FIELD mmak033 name="construct.a.mmak033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak033
            #add-point:ON ACTION controlp INFIELD mmak033 name="construct.c.mmak033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak034
            #add-point:BEFORE FIELD mmak034 name="construct.b.mmak034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak034
            
            #add-point:AFTER FIELD mmak034 name="construct.a.mmak034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak034
            #add-point:ON ACTION controlp INFIELD mmak034 name="construct.c.mmak034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak035
            #add-point:BEFORE FIELD mmak035 name="construct.b.mmak035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak035
            
            #add-point:AFTER FIELD mmak035 name="construct.a.mmak035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak035
            #add-point:ON ACTION controlp INFIELD mmak035 name="construct.c.mmak035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak070
            #add-point:BEFORE FIELD mmak070 name="construct.b.mmak070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak070
            
            #add-point:AFTER FIELD mmak070 name="construct.a.mmak070"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak070
            #add-point:ON ACTION controlp INFIELD mmak070 name="construct.c.mmak070"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak038
            #add-point:BEFORE FIELD mmak038 name="construct.b.mmak038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak038
            
            #add-point:AFTER FIELD mmak038 name="construct.a.mmak038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak038
            #add-point:ON ACTION controlp INFIELD mmak038 name="construct.c.mmak038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak039
            #add-point:BEFORE FIELD mmak039 name="construct.b.mmak039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak039
            
            #add-point:AFTER FIELD mmak039 name="construct.a.mmak039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak039
            #add-point:ON ACTION controlp INFIELD mmak039 name="construct.c.mmak039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak040
            #add-point:BEFORE FIELD mmak040 name="construct.b.mmak040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak040
            
            #add-point:AFTER FIELD mmak040 name="construct.a.mmak040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak040
            #add-point:ON ACTION controlp INFIELD mmak040 name="construct.c.mmak040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak041
            #add-point:BEFORE FIELD mmak041 name="construct.b.mmak041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak041
            
            #add-point:AFTER FIELD mmak041 name="construct.a.mmak041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak041
            #add-point:ON ACTION controlp INFIELD mmak041 name="construct.c.mmak041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak055
            #add-point:BEFORE FIELD mmak055 name="construct.b.mmak055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak055
            
            #add-point:AFTER FIELD mmak055 name="construct.a.mmak055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak055
            #add-point:ON ACTION controlp INFIELD mmak055 name="construct.c.mmak055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak056
            #add-point:BEFORE FIELD mmak056 name="construct.b.mmak056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak056
            
            #add-point:AFTER FIELD mmak056 name="construct.a.mmak056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak056
            #add-point:ON ACTION controlp INFIELD mmak056 name="construct.c.mmak056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak042
            #add-point:BEFORE FIELD mmak042 name="construct.b.mmak042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak042
            
            #add-point:AFTER FIELD mmak042 name="construct.a.mmak042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak042
            #add-point:ON ACTION controlp INFIELD mmak042 name="construct.c.mmak042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak043
            #add-point:BEFORE FIELD mmak043 name="construct.b.mmak043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak043
            
            #add-point:AFTER FIELD mmak043 name="construct.a.mmak043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak043
            #add-point:ON ACTION controlp INFIELD mmak043 name="construct.c.mmak043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak065
            #add-point:BEFORE FIELD mmak065 name="construct.b.mmak065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak065
            
            #add-point:AFTER FIELD mmak065 name="construct.a.mmak065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak065
            #add-point:ON ACTION controlp INFIELD mmak065 name="construct.c.mmak065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak044
            #add-point:BEFORE FIELD mmak044 name="construct.b.mmak044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak044
            
            #add-point:AFTER FIELD mmak044 name="construct.a.mmak044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak044
            #add-point:ON ACTION controlp INFIELD mmak044 name="construct.c.mmak044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak045
            #add-point:BEFORE FIELD mmak045 name="construct.b.mmak045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak045
            
            #add-point:AFTER FIELD mmak045 name="construct.a.mmak045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak045
            #add-point:ON ACTION controlp INFIELD mmak045 name="construct.c.mmak045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak046
            #add-point:BEFORE FIELD mmak046 name="construct.b.mmak046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak046
            
            #add-point:AFTER FIELD mmak046 name="construct.a.mmak046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak046
            #add-point:ON ACTION controlp INFIELD mmak046 name="construct.c.mmak046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak047
            #add-point:BEFORE FIELD mmak047 name="construct.b.mmak047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak047
            
            #add-point:AFTER FIELD mmak047 name="construct.a.mmak047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak047
            #add-point:ON ACTION controlp INFIELD mmak047 name="construct.c.mmak047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak048
            #add-point:BEFORE FIELD mmak048 name="construct.b.mmak048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak048
            
            #add-point:AFTER FIELD mmak048 name="construct.a.mmak048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak048
            #add-point:ON ACTION controlp INFIELD mmak048 name="construct.c.mmak048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak049
            #add-point:BEFORE FIELD mmak049 name="construct.b.mmak049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak049
            
            #add-point:AFTER FIELD mmak049 name="construct.a.mmak049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak049
            #add-point:ON ACTION controlp INFIELD mmak049 name="construct.c.mmak049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak071
            #add-point:BEFORE FIELD mmak071 name="construct.b.mmak071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak071
            
            #add-point:AFTER FIELD mmak071 name="construct.a.mmak071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak071
            #add-point:ON ACTION controlp INFIELD mmak071 name="construct.c.mmak071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak050
            #add-point:BEFORE FIELD mmak050 name="construct.b.mmak050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak050
            
            #add-point:AFTER FIELD mmak050 name="construct.a.mmak050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak050
            #add-point:ON ACTION controlp INFIELD mmak050 name="construct.c.mmak050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak051
            #add-point:BEFORE FIELD mmak051 name="construct.b.mmak051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak051
            
            #add-point:AFTER FIELD mmak051 name="construct.a.mmak051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak051
            #add-point:ON ACTION controlp INFIELD mmak051 name="construct.c.mmak051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak052
            #add-point:BEFORE FIELD mmak052 name="construct.b.mmak052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak052
            
            #add-point:AFTER FIELD mmak052 name="construct.a.mmak052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmak052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak052
            #add-point:ON ACTION controlp INFIELD mmak052 name="construct.c.mmak052"
            
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
 
{<section id="ammt320.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt320_query()
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
 
   INITIALIZE g_mmak_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL ammt320_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammt320_browser_fill(g_wc,"F")
      CALL ammt320_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL ammt320_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL ammt320_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="ammt320.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt320_fetch(p_fl)
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
   LET g_mmak_m.mmakdocno = g_browser[g_current_idx].b_mmakdocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE ammt320_master_referesh USING g_mmak_m.mmakdocno INTO g_mmak_m.mmaksite,g_mmak_m.mmakdocdt, 
       g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004, 
       g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid,g_mmak_m.mmakowndp, 
       g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt, 
       g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008, 
       g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak013,g_mmak_m.mmak014, 
       g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019, 
       g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025, 
       g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak060, 
       g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak073, 
       g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067, 
       g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033, 
       g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040, 
       g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065, 
       g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049, 
       g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052,g_mmak_m.mmaksite_desc,g_mmak_m.mmak004_desc, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid_desc,g_mmak_m.mmakcrtdp_desc, 
       g_mmak_m.mmakmodid_desc,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmak012_desc,g_mmak_m.mmak053_desc,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054_desc,g_mmak_m.mmak058_desc,g_mmak_m.mmak057_desc
   
   #遮罩相關處理
   LET g_mmak_m_mask_o.* =  g_mmak_m.*
   CALL ammt320_mmak_t_mask()
   LET g_mmak_m_mask_n.* =  g_mmak_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL ammt320_set_act_visible()
   CALL ammt320_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("reproduce", FALSE)
   
   IF g_mmak_m.mmakstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   END IF
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_mmak_m_t.* = g_mmak_m.*
   LET g_mmak_m_o.* = g_mmak_m.*
   
   LET g_data_owner = g_mmak_m.mmakownid      
   LET g_data_dept  = g_mmak_m.mmakowndp
   
   #重新顯示
   CALL ammt320_show()
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt320.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt320_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004 
   #ken---add---e
   DEFINE l_insert      LIKE type_t.num5 #sakura add   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_mmak_m.* TO NULL             #DEFAULT 設定
   LET g_mmakdocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmak_m.mmakownid = g_user
      LET g_mmak_m.mmakowndp = g_dept
      LET g_mmak_m.mmakcrtid = g_user
      LET g_mmak_m.mmakcrtdp = g_dept 
      LET g_mmak_m.mmakcrtdt = cl_get_current()
      LET g_mmak_m.mmakmodid = g_user
      LET g_mmak_m.mmakmoddt = cl_get_current()
      LET g_mmak_m.mmakstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmak_m.mmak000 = "I"
      LET g_mmak_m.mmak002 = "0"
      LET g_mmak_m.mmak066 = "1"
      LET g_mmak_m.mmak003 = "N"
      LET g_mmak_m.mmakacti = "Y"
      LET g_mmak_m.mmakstus = "N"
      LET g_mmak_m.mmak009 = "1"
      LET g_mmak_m.mmak010 = "0"
      LET g_mmak_m.mmak011 = "0"
      LET g_mmak_m.mmak013 = "0"
      LET g_mmak_m.mmak014 = "0"
      LET g_mmak_m.mmak015 = "N"
      LET g_mmak_m.mmak016 = "N"
      LET g_mmak_m.mmak017 = "N"
      LET g_mmak_m.mmak018 = "N"
      LET g_mmak_m.mmak019 = "2"
      LET g_mmak_m.mmak020 = "1"
      LET g_mmak_m.mmak023 = "N"
      LET g_mmak_m.mmak062 = "Y"
      LET g_mmak_m.mmak026 = "N"
      LET g_mmak_m.mmak061 = "1"
      LET g_mmak_m.mmak072 = "Y"
      LET g_mmak_m.mmak073 = "N"
      LET g_mmak_m.mmak059 = "1"
      LET g_mmak_m.mmak027 = "N"
      LET g_mmak_m.mmak028 = "1"
      LET g_mmak_m.mmak036 = "1"
      LET g_mmak_m.mmak037 = "1"
      LET g_mmak_m.mmak031 = "1"
      LET g_mmak_m.mmak070 = "N"
      LET g_mmak_m.mmak038 = "N"
      LET g_mmak_m.mmak042 = "N"
      LET g_mmak_m.mmak043 = "N"
      LET g_mmak_m.mmak065 = "N"
      LET g_mmak_m.mmak047 = "N"
      LET g_mmak_m.mmak049 = "N"
 
 
      #add-point:單頭預設值 name="insert.default"

      #sakura---add---str
      CALL s_aooi500_default(g_prog,'mmaksite',g_mmak_m.mmaksite)
         RETURNING l_insert,g_mmak_m.mmaksite
      IF l_insert = FALSE THEN
         RETURN
      END IF      
      #sakura---add---end      
      LET g_mmak_m.mmak019 = ""
      LET g_mmak_m.mmak020 = ""
      LET g_mmak_m.mmak028 = ""
      LET g_mmak_m.mmak036 = ""
      LET g_mmak_m.mmak037 = ""
      LET g_mmak_m.mmak031 = ""
      LET g_mmak_m.mmakdocdt = g_today
#      LET g_mmak_m.mmak004 = g_site
     #LET g_mmak_m.mmaksite = g_site #sakura mark
      LET g_mmak_m.mmakunit = g_mmak_m.mmaksite
      CALL ammt320_mmaksite_ref()
      #ken---add---s 需求單號：141125-00002 項次：4
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mmak_m.mmaksite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_mmak_m.mmakdocno = l_doctype
      #ken---add---e
      LET g_site_flag = FALSE         #sakura add
      LET g_mmak_m_o.* = g_mmak_m.*
      LET g_mmak_m_t.* = g_mmak_m.*
      #160604-00009#65-s by 08172
      IF g_mmak_m.mmak015='N' THEN
         LET g_mmak_m.mmak069=0
      END IF
      #160604-00009#65-e
      
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmak_m.mmakstus 
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
 
 
 
     
      #資料輸入
      CALL ammt320_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_mmak_m.* TO NULL
         CALL ammt320_show()
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
   CALL ammt320_set_act_visible()
   CALL ammt320_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mmakdocno_t = g_mmak_m.mmakdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmakent = " ||g_enterprise|| " AND",
                      " mmakdocno = '", g_mmak_m.mmakdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt320_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammt320_master_referesh USING g_mmak_m.mmakdocno INTO g_mmak_m.mmaksite,g_mmak_m.mmakdocdt, 
       g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004, 
       g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid,g_mmak_m.mmakowndp, 
       g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt, 
       g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008, 
       g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak013,g_mmak_m.mmak014, 
       g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019, 
       g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025, 
       g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak060, 
       g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak073, 
       g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067, 
       g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033, 
       g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040, 
       g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065, 
       g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049, 
       g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052,g_mmak_m.mmaksite_desc,g_mmak_m.mmak004_desc, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid_desc,g_mmak_m.mmakcrtdp_desc, 
       g_mmak_m.mmakmodid_desc,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmak012_desc,g_mmak_m.mmak053_desc,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054_desc,g_mmak_m.mmak058_desc,g_mmak_m.mmak057_desc
   
   
   #遮罩相關處理
   LET g_mmak_m_mask_o.* =  g_mmak_m.*
   CALL ammt320_mmak_t_mask()
   LET g_mmak_m_mask_n.* =  g_mmak_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmak_m.mmaksite,g_mmak_m.mmaksite_desc,g_mmak_m.mmakdocdt,g_mmak_m.mmakdocno,g_mmak_m.mmak000, 
       g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004_desc,g_mmak_m.mmak004,g_mmak_m.mmakl002, 
       g_mmak_m.mmakl003,g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtid_desc, 
       g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdp_desc,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmodid_desc, 
       g_mmak_m.mmakmoddt,g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005, 
       g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008,g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011, 
       g_mmak_m.mmak012,g_mmak_m.mmak012_desc,g_mmak_m.mmak013,g_mmak_m.mmak014,g_mmak_m.mmak015,g_mmak_m.mmak069, 
       g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021, 
       g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025,g_mmak_m.mmak062,g_mmak_m.mmak063, 
       g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak053_desc,g_mmak_m.mmak060,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054,g_mmak_m.mmak054_desc,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak058_desc, 
       g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak057_desc,g_mmak_m.mmak073,g_mmak_m.mmak059,g_mmak_m.mmak027, 
       g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak036, 
       g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035, 
       g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055, 
       g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065,g_mmak_m.mmak044,g_mmak_m.mmak045, 
       g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049,g_mmak_m.mmak071,g_mmak_m.mmak050, 
       g_mmak_m.mmak051,g_mmak_m.mmak052
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_mmak_m.mmakownid      
   LET g_data_dept  = g_mmak_m.mmakowndp
 
   #功能已完成,通報訊息中心
   CALL ammt320_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammt320.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt320_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_mmak_m.mmakdocno IS NULL
 
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
   LET g_mmakdocno_t = g_mmak_m.mmakdocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN ammt320_cl USING g_enterprise,g_mmak_m.mmakdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt320_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE ammt320_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt320_master_referesh USING g_mmak_m.mmakdocno INTO g_mmak_m.mmaksite,g_mmak_m.mmakdocdt, 
       g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004, 
       g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid,g_mmak_m.mmakowndp, 
       g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt, 
       g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008, 
       g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak013,g_mmak_m.mmak014, 
       g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019, 
       g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025, 
       g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak060, 
       g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak073, 
       g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067, 
       g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033, 
       g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040, 
       g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065, 
       g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049, 
       g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052,g_mmak_m.mmaksite_desc,g_mmak_m.mmak004_desc, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid_desc,g_mmak_m.mmakcrtdp_desc, 
       g_mmak_m.mmakmodid_desc,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmak012_desc,g_mmak_m.mmak053_desc,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054_desc,g_mmak_m.mmak058_desc,g_mmak_m.mmak057_desc
 
   #檢查是否允許此動作
   IF NOT ammt320_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_mmak_m_mask_o.* =  g_mmak_m.*
   CALL ammt320_mmak_t_mask()
   LET g_mmak_m_mask_n.* =  g_mmak_m.*
   
   
 
   #顯示資料
   CALL ammt320_show()
   
   WHILE TRUE
      LET g_mmak_m.mmakdocno = g_mmakdocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_mmak_m.mmakmodid = g_user 
LET g_mmak_m.mmakmoddt = cl_get_current()
LET g_mmak_m.mmakmodid_desc = cl_get_username(g_mmak_m.mmakmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_mmak_m_o.* = g_mmak_m.*
      LET g_mmak_m_t.* = g_mmak_m.*
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_mmak_m.mmakstus MATCHES "[DR]" THEN
         LET g_mmak_m.mmakstus = "N"
      END IF
      #end add-point
 
      #資料輸入
      CALL ammt320_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_mmak_m.* = g_mmak_m_t.*
         CALL ammt320_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE mmak_t SET (mmakmodid,mmakmoddt) = (g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt)
       WHERE mmakent = g_enterprise AND mmakdocno = g_mmakdocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL ammt320_set_act_visible()
   CALL ammt320_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmakent = " ||g_enterprise|| " AND",
                      " mmakdocno = '", g_mmak_m.mmakdocno, "' "
 
   #填到對應位置
   CALL ammt320_browser_fill(g_wc,"")
 
   CLOSE ammt320_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt320_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="ammt320.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt320_input(p_cmd)
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
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_imaa004       LIKE imaa_t.imaa004
   DEFINE l_success       LIKE type_t.num5  #sakura add   
   DEFINE l_errno         LIKE type_t.chr10 #sakura add
   DEFINE l_where         STRING            #sakura add
   DEFINE l_bkdocno       LIKE mmak_t.mmakdocno   #160704-00026#1 20160711 add by beckxie
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmak_m.mmaksite,g_mmak_m.mmaksite_desc,g_mmak_m.mmakdocdt,g_mmak_m.mmakdocno,g_mmak_m.mmak000, 
       g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004_desc,g_mmak_m.mmak004,g_mmak_m.mmakl002, 
       g_mmak_m.mmakl003,g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtid_desc, 
       g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdp_desc,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmodid_desc, 
       g_mmak_m.mmakmoddt,g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005, 
       g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008,g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011, 
       g_mmak_m.mmak012,g_mmak_m.mmak012_desc,g_mmak_m.mmak013,g_mmak_m.mmak014,g_mmak_m.mmak015,g_mmak_m.mmak069, 
       g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021, 
       g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025,g_mmak_m.mmak062,g_mmak_m.mmak063, 
       g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak053_desc,g_mmak_m.mmak060,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054,g_mmak_m.mmak054_desc,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak058_desc, 
       g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak057_desc,g_mmak_m.mmak073,g_mmak_m.mmak059,g_mmak_m.mmak027, 
       g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak036, 
       g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035, 
       g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055, 
       g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065,g_mmak_m.mmak044,g_mmak_m.mmak045, 
       g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049,g_mmak_m.mmak071,g_mmak_m.mmak050, 
       g_mmak_m.mmak051,g_mmak_m.mmak052
   
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
   CALL ammt320_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL ammt320_set_no_required(p_cmd)
   CALL ammt320_set_required(p_cmd)
   #end add-point
   CALL ammt320_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_mmak_m.mmaksite,g_mmak_m.mmakdocdt,g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001, 
          g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004,g_mmak_m.mmakl002,g_mmak_m.mmakl003,g_mmak_m.mmak066, 
          g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007, 
          g_mmak_m.mmak008,g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak013, 
          g_mmak_m.mmak014,g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018, 
          g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024, 
          g_mmak_m.mmak025,g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053, 
          g_mmak_m.mmak060,g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak072,g_mmak_m.mmak057, 
          g_mmak_m.mmak073,g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030, 
          g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032, 
          g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039, 
          g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043, 
          g_mmak_m.mmak065,g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048, 
          g_mmak_m.mmak049,g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               IF NOT cl_null(g_mmak_m.mmakdocno) THEN
                  CALL n_mmakl(g_mmak_m.mmakdocno)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mmak_m.mmakdocno
#                  CALL ap_ref_array2(g_ref_fields," SELECT mmakl002,mmakl003 FROM mmakl_t WHERE mmakldocno = ? AND mmakl001 = '"||g_lang||"'","") RETURNING g_rtn_fields #160905-00007#6 mark
                  CALL ap_ref_array2(g_ref_fields," SELECT mmakl002,mmakl003 FROM mmakl_t WHERE mmaklent="||g_enterprise||" AND mmakldocno = ? AND mmakl001 = '"||g_lang||"'","") RETURNING g_rtn_fields #160905-00007#6 add
                  LET g_mmak_m.mmakl002 = g_rtn_fields[1]
                  LET g_mmak_m.mmakl003 = g_rtn_fields[2]
                  DISPLAY BY NAME g_mmak_m.mmakl002
                  DISPLAY BY NAME g_mmak_m.mmakl003
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.mmakldocno = g_mmak_m.mmakdocno
LET g_master_multi_table_t.mmakl002 = g_mmak_m.mmakl002
LET g_master_multi_table_t.mmakl003 = g_mmak_m.mmakl003
 
            #add-point:input開始前 name="input.before.input"
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_required(p_cmd)
            CALL ammt320_set_required(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaksite
            
            #add-point:AFTER FIELD mmaksite name="input.a.mmaksite"
            LET g_mmak_m.mmaksite_desc = ' '
            DISPLAY BY NAME g_mmak_m.mmaksite_desc
           #sakura---mark---str
           #IF NOT cl_null(g_mmak_m.mmaksite) THEN
           #   IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_mmak_m.mmaksite != g_mmak_m_t.mmaksite OR g_mmak_m_t.mmaksite IS NULL)) THEN
           #      INITIALIZE g_chkparam.* TO NULL
           #      LET g_chkparam.arg1 = g_mmak_m.mmaksite
           #      LET g_chkparam.arg2 = '8'
           #      LET g_chkparam.arg3 = g_site
           #      IF NOT cl_chk_exist("v_ooed004") THEN
           #         LET g_mmak_m.mmaksite = g_mmak_m_t.mmaksite
           #         CALL ammt320_mmaksite_ref()
           #         NEXT FIELD CURRENT
           #      END IF
           #   END IF
           #END IF
           #sakura---mark---end
           #sakura---add---str
            IF NOT cl_null(g_mmak_m.mmaksite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmak_m.mmaksite != g_mmak_m_t.mmaksite OR g_mmak_m_t.mmaksite IS NULL )) THEN #160824-00007#110 by sakura mark
               IF g_mmak_m.mmaksite != g_mmak_m_o.mmaksite OR cl_null(g_mmak_m_o.mmaksite) THEN #160824-00007#110 by sakura add
                  CALL s_aooi500_chk(g_prog,'mmaksite',g_mmak_m.mmaksite,g_mmak_m.mmaksite)
                       RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_mmak_m.mmaksite = g_mmak_m_t.mmaksite #160824-00007#110 by sakura mark
                     #160824-00007#110 by sakura add(S)
                     LET g_mmak_m.mmaksite = g_mmak_m_o.mmaksite
                     LET g_mmak_m.mmak012 = g_mmak_m_o.mmak012
                     LET g_mmak_m.mmak053 = g_mmak_m_o.mmak053
                     LET g_mmak_m.mmak054 = g_mmak_m_o.mmak054
                     #160824-00007#110 by sakura add(E)
                     CALL s_desc_get_department_desc(g_mmak_m.mmaksite) RETURNING g_mmak_m.mmaksite_desc
                     DISPLAY BY NAME g_mmak_m.mmaksite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               #LET g_mmak_m.mmaksite = g_mmak_m_t.mmaksite #160824-00007#110 by sakura mark
               #160824-00007#110 by sakura add(S)
               LET g_mmak_m.mmaksite = g_mmak_m_o.mmaksite
               LET g_mmak_m.mmak012 = g_mmak_m_o.mmak012
               LET g_mmak_m.mmak053 = g_mmak_m_o.mmak053
               LET g_mmak_m.mmak054 = g_mmak_m_o.mmak054
               #160824-00007#110 by sakura add(E)
               CALL s_desc_get_department_desc(g_mmak_m.mmaksite) RETURNING g_mmak_m.mmaksite_desc
               DISPLAY BY NAME g_mmak_m.mmaksite_desc
               NEXT FIELD CURRENT
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_mmak_m.mmaksite) RETURNING g_mmak_m.mmaksite_desc
            DISPLAY BY NAME g_mmak_m.mmaksite_desc
           #sakura---add---end
            IF g_mmak_m.mmaksite != g_mmak_m_o.mmaksite OR cl_null(g_mmak_m.mmaksite) OR cl_null(g_mmak_m_o.mmaksite) THEN
               LET g_mmak_m.mmak012 = ''
               LET g_mmak_m.mmak053 = ''
               LET g_mmak_m.mmak054 = ''
               DISPLAY BY NAME g_mmak_m.mmak012,g_mmak_m.mmak053,g_mmak_m.mmak054
               CALL ammt320_mmak012_ref()
               CALL ammt320_mmak053_ref()
               CALL ammt320_mmak054_ref()
            END IF
            #LET g_mmak_m_o.mmaksite = g_mmak_m.mmaksite #160824-00007#110 by sakura mark
            LET g_mmak_m.mmakunit = g_mmak_m.mmaksite
            CALL ammt320_mmaksite_ref()
            
            CALL ammt320_set_entry(p_cmd)    #sakura add
            CALL ammt320_set_no_entry(p_cmd) #sakura add

            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaksite
            #add-point:BEFORE FIELD mmaksite name="input.b.mmaksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaksite
            #add-point:ON CHANGE mmaksite name="input.g.mmaksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakdocdt
            #add-point:BEFORE FIELD mmakdocdt name="input.b.mmakdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakdocdt
            
            #add-point:AFTER FIELD mmakdocdt name="input.a.mmakdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmakdocdt
            #add-point:ON CHANGE mmakdocdt name="input.g.mmakdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakdocno
            #add-point:BEFORE FIELD mmakdocno name="input.b.mmakdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakdocno
            
            #add-point:AFTER FIELD mmakdocno name="input.a.mmakdocno"
            #此段落由子樣板a05產生
           #sakura---mark---str
           #IF p_cmd = 'a' AND NOT cl_null(g_mmak_m.mmakdocno) THEN
           #   CALL ammt320_chk_mmakdocno()
           #   IF NOT cl_null(g_errno) THEN
           #      INITIALIZE g_errparam TO NULL
           #      LET g_errparam.code = g_errno
           #      LET g_errparam.extend = g_mmak_m.mmakdocno
           #      LET g_errparam.popup = TRUE
           #      CALL cl_err()
           #
           #      LET g_mmak_m.mmakdocno = g_mmak_m_t.mmakdocno
           #      NEXT FIELD CURRENT
           #   END IF
           #END IF
           #sakura---mark---end
           #sakura---add---str
            IF cl_null(g_mmak_m.mmakdocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00324'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            IF NOT cl_null(g_mmak_m.mmakdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmak_m.mmakdocno != g_mmakdocno_t )) THEN
                  IF NOT s_aooi200_chk_slip(g_mmak_m.mmaksite,'',g_mmak_m.mmakdocno,g_prog) THEN
                     LET g_mmak_m.mmakdocno = g_mmakdocno_t
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF           
           #sakura---add---end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmakdocno
            #add-point:ON CHANGE mmakdocno name="input.g.mmakdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak000
            #add-point:BEFORE FIELD mmak000 name="input.b.mmak000"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak000
            
            #add-point:AFTER FIELD mmak000 name="input.a.mmak000"
            IF g_mmak_m.mmak000 = 'I' THEN
              #LET g_mmak_m.mmak002 = '1' #sakura mark
               LET g_mmak_m.mmak002 = '0' #sakura add
               LET g_mmak_m.mmakacti = 'Y'
            ELSE
               IF p_cmd = 'a' THEN
                  LET g_mmak_m.mmak002 = ''               
               END IF
            END IF
            DISPLAY BY NAME g_mmak_m.mmak002,g_mmak_m.mmakacti            
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak000
            #add-point:ON CHANGE mmak000 name="input.g.mmak000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak001
            #add-point:BEFORE FIELD mmak001 name="input.b.mmak001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak001
            
            #add-point:AFTER FIELD mmak001 name="input.a.mmak001"
            IF NOT cl_null(g_mmak_m.mmak001) THEN
               IF g_mmak_m.mmak001 != g_mmak_m_o.mmak001 OR g_mmak_m_o.mmak001 IS NULL THEN
                  CALL ammt320_chk_mmak001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmak_m.mmak001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmak_m.mmak001 = g_mmak_m_o.mmak001
                     NEXT FIELD CURRENT
                  ELSE
                     CASE g_mmak_m.mmak000
                        WHEN 'U'
                           CALL ammt320_carry_mman()
                        WHEN 'I'
                           LET g_mmak_m.mmak002 = 1
                           DISPLAY BY NAME g_mmak_m.mmak002
                     END CASE
                  END IF
               END IF
            END IF
            LET g_mmak_m_o.mmak001 = g_mmak_m.mmak001
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak001
            #add-point:ON CHANGE mmak001 name="input.g.mmak001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak002
            #add-point:BEFORE FIELD mmak002 name="input.b.mmak002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak002
            
            #add-point:AFTER FIELD mmak002 name="input.a.mmak002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak002
            #add-point:ON CHANGE mmak002 name="input.g.mmak002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakunit
            #add-point:BEFORE FIELD mmakunit name="input.b.mmakunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakunit
            
            #add-point:AFTER FIELD mmakunit name="input.a.mmakunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmakunit
            #add-point:ON CHANGE mmakunit name="input.g.mmakunit"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak004
            
            #add-point:AFTER FIELD mmak004 name="input.a.mmak004"
            LET g_mmak_m.mmak004_desc = ' '
            DISPLAY BY NAME g_mmak_m.mmak004_desc
            IF NOT cl_null(g_mmak_m.mmak004) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_mmak_m.mmak004 != g_mmak_m_t.mmak004 OR g_mmak_m_t.mmak004 IS NULL)) THEN #160824-00007#110 by sakura mark
               IF g_mmak_m.mmak004 != g_mmak_m_o.mmak004 OR cl_null(g_mmak_m_o.mmak004) THEN #160824-00007#110 by sakura add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mmak_m.mmak004
                  LET g_chkparam.arg2 = '2'
                  LET g_chkparam.arg3 = g_site
                  IF NOT cl_chk_exist("v_ooed004") THEN
                     #LET g_mmak_m.mmak004 = g_mmak_m_t.mmak004 #160824-00007#110 by sakura mark
                     #160824-00007#110 by sakura add(S)
                     LET g_mmak_m.mmak004 = g_mmak_m_o.mmak004
                     LET g_mmak_m.mmak012 = g_mmak_m_o.mmak012
                     LET g_mmak_m.mmak053 = g_mmak_m_o.mmak053
                     LET g_mmak_m.mmak054 = g_mmak_m_o.mmak054
                     #160824-00007#110 by sakura add(E)
                     CALL ammt320_mmak004_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_mmak_m.mmak004 != g_mmak_m_o.mmak004 OR cl_null(g_mmak_m.mmak004) OR cl_null(g_mmak_m_o.mmak004) THEN
               LET g_mmak_m.mmak012 = ''
               LET g_mmak_m.mmak053 = ''
               LET g_mmak_m.mmak054 = ''
               DISPLAY BY NAME g_mmak_m.mmak012,g_mmak_m.mmak053,g_mmak_m.mmak054
               CALL ammt320_mmak012_ref()
               CALL ammt320_mmak053_ref()
               CALL ammt320_mmak054_ref()
            END IF
            #LET g_mmak_m_o.mmak004 = g_mmak_m.mmak004 #160824-00007#110 by sakura mark
            CALL ammt320_mmak004_ref()
            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak004
            #add-point:BEFORE FIELD mmak004 name="input.b.mmak004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak004
            #add-point:ON CHANGE mmak004 name="input.g.mmak004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakl002
            #add-point:BEFORE FIELD mmakl002 name="input.b.mmakl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakl002
            
            #add-point:AFTER FIELD mmakl002 name="input.a.mmakl002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmakl002
            #add-point:ON CHANGE mmakl002 name="input.g.mmakl002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakl003
            #add-point:BEFORE FIELD mmakl003 name="input.b.mmakl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakl003
            
            #add-point:AFTER FIELD mmakl003 name="input.a.mmakl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmakl003
            #add-point:ON CHANGE mmakl003 name="input.g.mmakl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak066
            #add-point:BEFORE FIELD mmak066 name="input.b.mmak066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak066
            
            #add-point:AFTER FIELD mmak066 name="input.a.mmak066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak066
            #add-point:ON CHANGE mmak066 name="input.g.mmak066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak003
            #add-point:BEFORE FIELD mmak003 name="input.b.mmak003"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak003
            
            #add-point:AFTER FIELD mmak003 name="input.a.mmak003"
#            IF g_mmak_m.mmak003 != g_mmak_m_o.mmak003 THEN
#               IF g_mmak_m.mmak003 = 'Y' THEN
#                  CALL ammt320_reset('1')
#               ELSE
#                  CALL ammt320_reset('2')
#               END IF
#            END IF
#            LET g_mmak_m_o.mmak003 = g_mmak_m.mmak003            
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak003
            #add-point:ON CHANGE mmak003 name="input.g.mmak003"
            IF g_mmak_m.mmak003 = 'Y' THEN
               IF NOT cl_ask_confirm('amm-00190') THEN
                  LET g_mmak_m.mmak003 = 'N'
                  DISPLAY BY NAME g_mmak_m.mmak003       
                  NEXT FIELD mmak003                  
               END IF
            END IF
            IF g_mmak_m.mmak003 = 'Y' THEN
               CALL ammt320_reset('1')
            ELSE
               CALL ammt320_reset('2')
            END IF     
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)  
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakacti
            #add-point:BEFORE FIELD mmakacti name="input.b.mmakacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakacti
            
            #add-point:AFTER FIELD mmakacti name="input.a.mmakacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmakacti
            #add-point:ON CHANGE mmakacti name="input.g.mmakacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmakstus
            #add-point:BEFORE FIELD mmakstus name="input.b.mmakstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmakstus
            
            #add-point:AFTER FIELD mmakstus name="input.a.mmakstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmakstus
            #add-point:ON CHANGE mmakstus name="input.g.mmakstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak005,"0.000","0","30.000","1","azz-00087",1) THEN
               NEXT FIELD mmak005
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak005 name="input.a.mmak005"
            IF NOT cl_null(g_mmak_m.mmak005) THEN
               IF (g_mmak_m.mmak005 != g_mmak_m_o.mmak005 OR g_mmak_m_o.mmak005 IS NULL) THEN
                  IF NOT cl_null(g_mmak_m.mmak006) THEN
                     IF g_mmak_m.mmak006 >= g_mmak_m.mmak005 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'amm-00103'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_mmak_m.mmak005 = g_mmak_m_o.mmak005
                        NEXT FIELD CURRENT
                     ELSE
                        LET g_mmak_m.mmak008 = g_mmak_m.mmak005 - g_mmak_m.mmak006
                        DISPLAY BY NAME g_mmak_m.mmak008
                     END IF
                  END IF
               END IF
            ELSE               
               LET g_mmak_m.mmak008 = ''
               DISPLAY BY NAME g_mmak_m.mmak008
            END IF
            LET g_mmak_m_o.mmak005 = g_mmak_m.mmak005
            
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak005
            #add-point:BEFORE FIELD mmak005 name="input.b.mmak005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak005
            #add-point:ON CHANGE mmak005 name="input.g.mmak005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak006
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak006 name="input.a.mmak006"
            IF NOT cl_null(g_mmak_m.mmak006) THEN
               IF (g_mmak_m.mmak006 != g_mmak_m_o.mmak006 OR g_mmak_m_o.mmak006 IS NULL) THEN               
                  IF g_mmak_m.mmak006 >= g_mmak_m.mmak005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00103'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmak_m.mmak006 = g_mmak_m_o.mmak006
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_mmak_m.mmak007 = ''
                     LET g_mmak_m.mmak008 = g_mmak_m.mmak005 - g_mmak_m.mmak006
                     DISPLAY BY NAME g_mmak_m.mmak007,g_mmak_m.mmak008
                  END IF
               END IF
            ELSE               
               LET g_mmak_m.mmak007 = ''
               LET g_mmak_m.mmak008 = '' 
               DISPLAY BY NAME g_mmak_m.mmak007,g_mmak_m.mmak008              
            END IF
            LET g_mmak_m_o.mmak006 = g_mmak_m.mmak006
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak006
            #add-point:BEFORE FIELD mmak006 name="input.b.mmak006"
            IF cl_null(g_mmak_m.mmak005) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00101'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD mmak005
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak006
            #add-point:ON CHANGE mmak006 name="input.g.mmak006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak007
            #add-point:BEFORE FIELD mmak007 name="input.b.mmak007"
            IF cl_null(g_mmak_m.mmak005) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00101'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD mmak005
            END IF
            IF cl_null(g_mmak_m.mmak006) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00102'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD mmak006
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak007
            
            #add-point:AFTER FIELD mmak007 name="input.a.mmak007"
            IF NOT cl_null(g_mmak_m.mmak007) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_mmak_m.mmak007 != g_mmak_m_t.mmak007 OR g_mmak_m_t.mmak007 IS NULL)) THEN #160824-00007#110 by sakura mark
               IF g_mmak_m.mmak007 != g_mmak_m_o.mmak007 OR cl_null(g_mmak_m_o.mmak007) THEN #160824-00007#110 by sakura add
                  CALL ammt320_chk_mmak007()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmak_m.mmak007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmak_m.mmak007 = g_mmak_m_t.mmak007 #160824-00007#110 by sakura mark
                     LET g_mmak_m.mmak007 = g_mmak_m_o.mmak007  #160824-00007#110 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak007
            #add-point:ON CHANGE mmak007 name="input.g.mmak007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak008
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak008 name="input.a.mmak008"
            IF NOT cl_null(g_mmak_m.mmak008) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak008
            #add-point:BEFORE FIELD mmak008 name="input.b.mmak008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak008
            #add-point:ON CHANGE mmak008 name="input.g.mmak008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak009
            #add-point:BEFORE FIELD mmak009 name="input.b.mmak009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak009
            
            #add-point:AFTER FIELD mmak009 name="input.a.mmak009"
#160302-00028#1 mark by yangxf 20160303
#            IF NOT cl_null(g_mmak_m.mmak009) THEN
#               IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_mmak_m.mmak009 != g_mmak_m_t.mmak009 OR g_mmak_m_t.mmak009 IS NULL)) THEN
#                  IF g_mmak_m.mmak009 = '2' THEN
#                     LET g_mmak_m.mmak010 = ''
#                  ELSE
#                     LET g_mmak_m.mmak010 = g_mmak_m_t.mmak010
#                  END IF
#               END IF
#            END IF
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160303
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak009
            #add-point:ON CHANGE mmak009 name="input.g.mmak009"
            IF g_mmak_m.mmak009 = '2' THEN
               LET g_mmak_m.mmak010 = ''
            END IF
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak010
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak010 name="input.a.mmak010"
            IF NOT cl_null(g_mmak_m.mmak010) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak010
            #add-point:BEFORE FIELD mmak010 name="input.b.mmak010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak010
            #add-point:ON CHANGE mmak010 name="input.g.mmak010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak011,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak011
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak011 name="input.a.mmak011"
            IF NOT cl_null(g_mmak_m.mmak011) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak011
            #add-point:BEFORE FIELD mmak011 name="input.b.mmak011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak011
            #add-point:ON CHANGE mmak011 name="input.g.mmak011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak012
            
            #add-point:AFTER FIELD mmak012 name="input.a.mmak012"
            LET g_mmak_m.mmak012_desc = ' '
            DISPLAY BY NAME g_mmak_m.mmak012_desc
            IF NOT cl_null(g_mmak_m.mmak012) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_mmak_m.mmak012 != g_mmak_m_t.mmak012 OR g_mmak_m_t.mmak012 IS NULL)) THEN #160824-00007#110 by sakura mark
               IF g_mmak_m.mmak012 != g_mmak_m_o.mmak012 OR cl_null(g_mmak_m_o.mmak012) THEN #160824-00007#110 by sakura add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mmak_m.mmak012
                  LET g_chkparam.arg2 = g_mmak_m.mmaksite
                  IF NOT cl_chk_exist("v_rtdx001") THEN
                     #LET g_mmak_m.mmak012 = g_mmak_m_t.mmak012 #160824-00007#110 by sakura mark
                     LET g_mmak_m.mmak012 = g_mmak_m_o.mmak012  #160824-00007#110 by sakura add
                     CALL ammt320_mmak012_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL ammt320_mmak012_ref()
            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak012
            #add-point:BEFORE FIELD mmak012 name="input.b.mmak012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak012
            #add-point:ON CHANGE mmak012 name="input.g.mmak012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak013,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak013
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak013 name="input.a.mmak013"
            IF NOT cl_null(g_mmak_m.mmak013) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak013
            #add-point:BEFORE FIELD mmak013 name="input.b.mmak013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak013
            #add-point:ON CHANGE mmak013 name="input.g.mmak013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak014,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak014
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak014 name="input.a.mmak014"
            IF NOT cl_null(g_mmak_m.mmak014) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak014
            #add-point:BEFORE FIELD mmak014 name="input.b.mmak014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak014
            #add-point:ON CHANGE mmak014 name="input.g.mmak014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak015
            #add-point:BEFORE FIELD mmak015 name="input.b.mmak015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak015
            
            #add-point:AFTER FIELD mmak015 name="input.a.mmak015"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak015
            #add-point:ON CHANGE mmak015 name="input.g.mmak015"
            #160302-00028#2 remark by yangxf 20160302 
            #150629-00020#1 150629 by lori mark---(S)
            IF g_mmak_m.mmak015 = 'Y' THEN
               LET g_mmak_m.mmak069 = ''
               DISPLAY BY NAME g_mmak_m.mmak069
               CALL cl_set_comp_entry('mmak069',FALSE)
            ELSE
               CALL cl_set_comp_entry('mmak069',TRUE)
               LET g_mmak_m.mmak069 = 0
               DISPLAY BY NAME g_mmak_m.mmak069
            END IF 
            #150629-00020#1 150629 by lori mark---(E)
            #160302-00028#2 remark by yangxf 20160302 
            #160302-00028#2 mark by yangxf 20160302 
            ##150629-00020#1 150629 by lori add---(S)
            #IF g_mmak_m.mmak015 = 'Y' THEN
            #   IF g_mmak_m.mmak015 <> g_mmak_m_t.mmak015 THEN
            #      LET g_mmak_m.mmak069 = ''
            #   END IF               
            #ELSE 
            #   LET g_mmak_m.mmak069 = 0
            #END IF
            #DISPLAY BY NAME g_mmak_m.mmak069
            
            #CALL ammt320_set_entry(p_cmd)
            #CALL ammt320_set_no_required(p_cmd)
            #CALL ammt320_set_required(p_cmd)
            #CALL ammt320_set_no_entry(p_cmd)
            #150629-00020#1 150629 by lori add---(S)
            #160302-00028#2 mark by yangxf 20160302 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak069
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak069,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mmak069
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak069 name="input.a.mmak069"

#160604-00009#65-s by 08172
#            #150629-00020#1 150629 by lori add---(S)
#            IF NOT cl_null(g_mmak_m.mmak069) THEN 
#               IF g_mmak_m.mmak015 = 'Y' THEN
#                  IF NOT cl_ap_chk_range(g_mmak_m.mmak069,"0.00","0","","","azz-00079",1) THEN
#                     NEXT FIELD mmak069
#                  END IF                
#               END IF
#            END IF 
#            #150629-00020#1 150629 by lori add---(E)
#160604-00009#65-e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak069
            #add-point:BEFORE FIELD mmak069 name="input.b.mmak069"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak069
            #add-point:ON CHANGE mmak069 name="input.g.mmak069"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak016
            #add-point:BEFORE FIELD mmak016 name="input.b.mmak016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak016
            
            #add-point:AFTER FIELD mmak016 name="input.a.mmak016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak016
            #add-point:ON CHANGE mmak016 name="input.g.mmak016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak017
            #add-point:BEFORE FIELD mmak017 name="input.b.mmak017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak017
            
            #add-point:AFTER FIELD mmak017 name="input.a.mmak017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak017
            #add-point:ON CHANGE mmak017 name="input.g.mmak017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak018
            #add-point:BEFORE FIELD mmak018 name="input.b.mmak018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak018
            
            #add-point:AFTER FIELD mmak018 name="input.a.mmak018"
#160302-00028#1 mark by yangxf 20160302
#            IF NOT cl_null(g_mmak_m.mmak018) AND 
#               (g_mmak_m.mmak018 != g_mmak_m_o.mmak018 OR g_mmak_m_o.mmak018 IS NULL) THEN 
#               IF g_mmak_m.mmak018 = 'Y' THEN
#                  IF cl_null(g_mmak_m_t.mmak019) THEN
#                     LET g_mmak_m.mmak019 = '2'
#                  ELSE
#                     LET g_mmak_m.mmak019 = g_mmak_m_t.mmak019
#                  END IF
#                  
#                  IF cl_null(g_mmak_m_t.mmak020) THEN
#                     LET g_mmak_m.mmak020 = '1'
#                  ELSE
#                     LET g_mmak_m.mmak020 = g_mmak_m_t.mmak020
#                     LET g_mmak_m.mmak021 = g_mmak_m_t.mmak021
#                     LET g_mmak_m.mmak022 = g_mmak_m_t.mmak022
#                  END IF     
#               ELSE              
#                  LET g_mmak_m.mmak019 = ''
#                  LET g_mmak_m.mmak020 = '' 
#                  LET g_mmak_m.mmak021 = ''
#                  LET g_mmak_m.mmak022 = ''
#               END IF
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022
#            LET g_mmak_m_o.mmak018 = g_mmak_m.mmak018            
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160302
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak018
            #add-point:ON CHANGE mmak018 name="input.g.mmak018"
            #160302-00028#1 add by yangxf 20160302
            IF g_mmak_m.mmak018 = 'Y' THEN
               IF cl_null(g_mmak_m_t.mmak019) THEN
                  LET g_mmak_m.mmak019 = '2'
               ELSE
                  LET g_mmak_m.mmak019 = g_mmak_m_t.mmak019
               END IF
               
               IF cl_null(g_mmak_m_t.mmak020) THEN
                  LET g_mmak_m.mmak020 = '1'
               ELSE
                  LET g_mmak_m.mmak020 = g_mmak_m_t.mmak020
                  LET g_mmak_m.mmak021 = g_mmak_m_t.mmak021
                  LET g_mmak_m.mmak022 = g_mmak_m_t.mmak022
               END IF     
            ELSE              
               LET g_mmak_m.mmak019 = ''
               LET g_mmak_m.mmak020 = '' 
               LET g_mmak_m.mmak021 = ''
               LET g_mmak_m.mmak022 = ''
               LET g_mmak_m.mmak023 = 'N'
               LET g_mmak_m.mmak024 = ''
               LET g_mmak_m.mmak025 = ''
            END IF
            DISPLAY BY NAME g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,
                            g_mmak_m.mmak024,g_mmak_m.mmak025
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #160302-00028#1 add by yangxf 20160302
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak019
            #add-point:BEFORE FIELD mmak019 name="input.b.mmak019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak019
            
            #add-point:AFTER FIELD mmak019 name="input.a.mmak019"
            CALL ammt320_set_no_entry(p_cmd)     #160615-00046#2 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak019
            #add-point:ON CHANGE mmak019 name="input.g.mmak019"
            CALL ammt320_set_no_entry(p_cmd)    #160615-00046#2 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak020
            #add-point:BEFORE FIELD mmak020 name="input.b.mmak020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak020
            
            #add-point:AFTER FIELD mmak020 name="input.a.mmak020"
#160302-00028#1 mark by yangxf 20160302
#            IF NOT cl_null(g_mmak_m.mmak020) AND 
#               (g_mmak_m.mmak020 != g_mmak_m_o.mmak020 OR g_mmak_m_o.mmak020 IS NULL) THEN
#               CASE g_mmak_m.mmak020
#                  WHEN '1'
#                     LET g_mmak_m.mmak022 = ''
#                  WHEN '2'
#                     LET g_mmak_m.mmak021 = ''
#               END CASE
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak021,g_mmak_m.mmak022
#            LET g_mmak_m_o.mmak020 = g_mmak_m.mmak020            
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160302
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak020
            #add-point:ON CHANGE mmak020 name="input.g.mmak020"
            #160302-00028#1 add by yangxf 20160302
            CASE g_mmak_m.mmak020
               WHEN '1'
                  LET g_mmak_m.mmak022 = ''
               WHEN '2'
                  LET g_mmak_m.mmak021 = ''
            END CASE
            DISPLAY BY NAME g_mmak_m.mmak021,g_mmak_m.mmak022   
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #160302-00028#1 add by yangxf 20160302
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak021
            #add-point:BEFORE FIELD mmak021 name="input.b.mmak021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak021
            
            #add-point:AFTER FIELD mmak021 name="input.a.mmak021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak021
            #add-point:ON CHANGE mmak021 name="input.g.mmak021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak022,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak022
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak022 name="input.a.mmak022"
            IF NOT cl_null(g_mmak_m.mmak022) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak022
            #add-point:BEFORE FIELD mmak022 name="input.b.mmak022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak022
            #add-point:ON CHANGE mmak022 name="input.g.mmak022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak023
            #add-point:BEFORE FIELD mmak023 name="input.b.mmak023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak023
            
            #add-point:AFTER FIELD mmak023 name="input.a.mmak023"
#160302-00028#1 mark by yangxf 20160302
#            IF NOT cl_null(g_mmak_m.mmak023) AND 
#               (g_mmak_m.mmak023 != g_mmak_m_o.mmak023 OR g_mmak_m_o.mmak023 IS NULL) THEN
#               IF g_mmak_m.mmak023 = 'Y' THEN
#                  LET g_mmak_m.mmak024 = g_mmak_m_t.mmak024
#                  LET g_mmak_m.mmak025 = g_mmak_m_t.mmak025
#               ELSE
#                  LET g_mmak_m.mmak024 = ''
#                  LET g_mmak_m.mmak025 = ''
#               END IF
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak024,g_mmak_m.mmak025
#            LET g_mmak_m_o.mmak023 = g_mmak_m.mmak023
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160302
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak023
            #add-point:ON CHANGE mmak023 name="input.g.mmak023"
            IF g_mmak_m.mmak023 = 'N' THEN
               IF p_cmd = 'a' AND g_mmak_m.mmak000 = 'U' THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM mmao_t
                   WHERE mmaoent = g_enterprise                  
                     AND mmao001 = g_mmak_m.mmak001
               ELSE
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM mmal_t
                   WHERE mmalent = g_enterprise                  
                     AND mmaldocno = g_mmak_m.mmakdocno
               END IF
               
               IF l_cnt > 0 THEN
                  IF NOT cl_ask_confirm('amm-00134') THEN
                     LET g_mmak_m.mmak023 = 'Y' 
                     DISPLAY BY NAME g_mmak_m.mmak023
                     NEXT FIELD mmak023
                  END IF
               END IF
            END IF
            #160302-00028#1 add by yangxf 20160302
            IF g_mmak_m.mmak023 = 'Y' THEN
               LET g_mmak_m.mmak024 = g_mmak_m_t.mmak024
               LET g_mmak_m.mmak025 = g_mmak_m_t.mmak025
            ELSE
               LET g_mmak_m.mmak024 = ''
               LET g_mmak_m.mmak025 = ''
            END IF
            DISPLAY BY NAME g_mmak_m.mmak024,g_mmak_m.mmak025
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #160302-00028#1 add by yangxf 20160302
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak024,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak024
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak024 name="input.a.mmak024"
            IF NOT cl_null(g_mmak_m.mmak024) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak024
            #add-point:BEFORE FIELD mmak024 name="input.b.mmak024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak024
            #add-point:ON CHANGE mmak024 name="input.g.mmak024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak025,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak025
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak025 name="input.a.mmak025"
            IF NOT cl_null(g_mmak_m.mmak025) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak025
            #add-point:BEFORE FIELD mmak025 name="input.b.mmak025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak025
            #add-point:ON CHANGE mmak025 name="input.g.mmak025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak062
            #add-point:BEFORE FIELD mmak062 name="input.b.mmak062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak062
            
            #add-point:AFTER FIELD mmak062 name="input.a.mmak062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak062
            #add-point:ON CHANGE mmak062 name="input.g.mmak062"
            IF g_mmak_m.mmak062 = 'N' THEN 
               LET g_mmak_m.mmak063 = ''
            END IF 
            IF g_mmak_m.mmak062 = 'Y' THEN 
               LET g_mmak_m.mmak063 = '1'
            END IF 
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak063
            #add-point:BEFORE FIELD mmak063 name="input.b.mmak063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak063
            
            #add-point:AFTER FIELD mmak063 name="input.a.mmak063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak063
            #add-point:ON CHANGE mmak063 name="input.g.mmak063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak026
            #add-point:BEFORE FIELD mmak026 name="input.b.mmak026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak026
            
            #add-point:AFTER FIELD mmak026 name="input.a.mmak026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak026
            #add-point:ON CHANGE mmak026 name="input.g.mmak026"
            IF g_mmak_m.mmak026 = 'N' THEN 
               LET g_mmak_m.mmak064 = ''
            END IF 
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak064
            #add-point:BEFORE FIELD mmak064 name="input.b.mmak064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak064
            
            #add-point:AFTER FIELD mmak064 name="input.a.mmak064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak064
            #add-point:ON CHANGE mmak064 name="input.g.mmak064"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak053
            
            #add-point:AFTER FIELD mmak053 name="input.a.mmak053"
            LET g_mmak_m.mmak053_desc = ' '
            DISPLAY BY NAME g_mmak_m.mmak053_desc
            IF NOT cl_null(g_mmak_m.mmak053) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_mmak_m.mmak053 != g_mmak_m_t.mmak053 OR g_mmak_m_t.mmak053 IS NULL)) THEN #160824-00007#110 by sakura mark
               IF g_mmak_m.mmak053 != g_mmak_m_o.mmak053 OR cl_null(g_mmak_m_o.mmak053) THEN #160824-00007#110 by sakura add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mmak_m.mmak053
                  LET g_chkparam.arg2 = g_mmak_m.mmaksite
                  IF NOT cl_chk_exist("v_rtdx001") THEN
                     #LET g_mmak_m.mmak053 = g_mmak_m_t.mmak053 #160824-00007#110 by sakura mark
                     LET g_mmak_m.mmak053 = g_mmak_m_o.mmak053  #160824-00007#110 by sakura add
                     CALL ammt320_mmak053_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL ammt320_mmak053_ref()
            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak053
            #add-point:BEFORE FIELD mmak053 name="input.b.mmak053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak053
            #add-point:ON CHANGE mmak053 name="input.g.mmak053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak060
            
            #add-point:AFTER FIELD mmak060 name="input.a.mmak060"
            IF NOT cl_null(g_mmak_m.mmak060) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_mmak_m.mmak060 != g_mmak_m_t.mmak060 OR g_mmak_m_t.mmak060 IS NULL)) THEN #160824-00007#110 by sakura mark
               IF g_mmak_m.mmak060 != g_mmak_m_o.mmak060 OR cl_null(g_mmak_m_o.mmak060) THEN #160824-00007#110 by sakura add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mmak_m.mmak060
                  LET g_chkparam.arg2 = g_mmak_m.mmaksite
                  IF NOT cl_chk_exist("v_rtdx001") THEN
                     #LET g_mmak_m.mmak060 = g_mmak_m_t.mmak060 #160824-00007#110 by sakura mark
                     LET g_mmak_m.mmak060 = g_mmak_m_o.mmak060  #160824-00007#110 by sakura add
                     DISPLAY BY NAME g_mmak_m.mmak060
                     NEXT FIELD CURRENT
                  ELSE
                     SELECT imaa004 INTO l_imaa004 FROM imaa_t
                      WHERE imaaent = g_enterprise
                        AND imaa001 = g_mmak_m.mmak060
                     IF cl_null(l_imaa004) OR l_imaa004 <> 'E' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'amm-00368'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_mmak_m.mmak060 = g_mmak_m_t.mmak060 #160824-00007#110 by sakura mark
                        LET g_mmak_m.mmak060 = g_mmak_m_o.mmak060  #160824-00007#110 by sakura add
                        DISPLAY BY NAME g_mmak_m.mmak060
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmak_m.mmak060
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmak_m.mmak060_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmak_m.mmak060_desc
            
            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak060
            #add-point:BEFORE FIELD mmak060 name="input.b.mmak060"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak060
            #add-point:ON CHANGE mmak060 name="input.g.mmak060"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak054
            
            #add-point:AFTER FIELD mmak054 name="input.a.mmak054"
            LET g_mmak_m.mmak054_desc = ' '
            DISPLAY BY NAME g_mmak_m.mmak054_desc
            IF NOT cl_null(g_mmak_m.mmak054) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ( g_mmak_m.mmak054 != g_mmak_m_t.mmak054 OR g_mmak_m_t.mmak054 IS NULL)) THEN #160824-00007#110 by sakura mark
               IF g_mmak_m.mmak054 != g_mmak_m_o.mmak054 OR cl_null(g_mmak_m_o.mmak054) THEN #160824-00007#110 by sakura add
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_mmak_m.mmak054
                  LET g_chkparam.arg2 = g_mmak_m.mmaksite
                  IF NOT cl_chk_exist("v_rtdx001") THEN
                     #LET g_mmak_m.mmak054 = g_mmak_m_t.mmak054 #160824-00007#110 by sakura mark
                     LET g_mmak_m.mmak054 = g_mmak_m_o.mmak054  #160824-00007#110 by sakura add
                     CALL ammt320_mmak054_ref()
                     NEXT FIELD CURRENT
                  ELSE
                     SELECT imaa004 INTO l_imaa004 FROM imaa_t
                      WHERE imaaent = g_enterprise
                        AND imaa001 = g_mmak_m.mmak054
                     IF cl_null(l_imaa004) OR l_imaa004 <> 'E' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'amm-00368'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_mmak_m.mmak054 = g_mmak_m_t.mmak054 #160824-00007#110 by sakura mark
                        LET g_mmak_m.mmak054 = g_mmak_m_o.mmak054  #160824-00007#110 by sakura add
                        CALL ammt320_mmak054_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL ammt320_mmak054_ref()
            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak054
            #add-point:BEFORE FIELD mmak054 name="input.b.mmak054"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak054
            #add-point:ON CHANGE mmak054 name="input.g.mmak054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak061
            #add-point:BEFORE FIELD mmak061 name="input.b.mmak061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak061
            
            #add-point:AFTER FIELD mmak061 name="input.a.mmak061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak061
            #add-point:ON CHANGE mmak061 name="input.g.mmak061"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak058
            
            #add-point:AFTER FIELD mmak058 name="input.a.mmak058"
            LET g_mmak_m.mmak058_desc = ' '
            DISPLAY BY NAME g_mmak_m.mmak058_desc 
            IF NOT cl_null(g_mmak_m.mmak058) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmak_m.mmak058 != g_mmak_m_t.mmak058 OR #160824-00007#110 by sakura mark
               #                                    g_mmak_m_t.mmak058 IS NULL)) THEN         #160824-00007#110 by sakura mark
               IF g_mmak_m.mmak058 != g_mmak_m_o.mmak058 OR cl_null(g_mmak_m_o.mmak058) THEN  #160824-00007#110 by sakura add
                  INITIALIZE g_chkparam.* TO NULL 
                  
                  LET g_chkparam.arg1 = g_mmak_m.mmak058    #款別編號 
                  LET g_chkparam.arg2 = '60'                #款別分類 
                  
                  IF NOT cl_chk_exist("v_ooia001_1") THEN 
                     #LET g_mmak_m.mmak058 = g_mmak_m_t.mmak058 #160824-00007#110 by sakura mark
                     LET g_mmak_m.mmak058 = g_mmak_m_o.mmak058  #160824-00007#110 by sakura add
                     CALL ammt320_mmak058_ref() 
                     NEXT FIELD CURRENT 
                  END IF 
               END IF 
            END IF  
            CALL ammt320_mmak058_ref()
            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak058
            #add-point:BEFORE FIELD mmak058 name="input.b.mmak058"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak058
            #add-point:ON CHANGE mmak058 name="input.g.mmak058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak072
            #add-point:BEFORE FIELD mmak072 name="input.b.mmak072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak072
            
            #add-point:AFTER FIELD mmak072 name="input.a.mmak072"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak072
            #add-point:ON CHANGE mmak072 name="input.g.mmak072"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak057
            
            #add-point:AFTER FIELD mmak057 name="input.a.mmak057"
            LET g_mmak_m.mmak057_desc = ' ' 
            DISPLAY BY NAME g_mmak_m.mmak057_desc 
            IF NOT cl_null(g_mmak_m.mmak057) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmak_m.mmak057 != g_mmak_m_t.mmak057 OR #160824-00007#110 by sakura mark
               #                                    g_mmak_m_t.mmak057 IS NULL )) THEN        #160824-00007#110 by sakura mark
               IF g_mmak_m.mmak057 != g_mmak_m_o.mmak057 OR cl_null(g_mmak_m_o.mmak057) THEN  #160824-00007#110 by sakura add
                  INITIALIZE g_chkparam.* TO NULL 
                  LET g_chkparam.arg1 = g_mmak_m.mmak057    #款別編號
                  LET g_chkparam.arg2 = '60'                #款別分類 
                  IF NOT cl_chk_exist("v_ooia001_1") THEN 
                     #LET g_mmak_m.mmak057 = g_mmak_m_t.mmak057 #160824-00007#110 by sakura mark
                     LET g_mmak_m.mmak057 = g_mmak_m_o.mmak057  #160824-00007#110 by sakura add
                     CALL ammt320_mmak057_ref() 
                     NEXT FIELD CURRENT 
                  END IF 
               END IF 
            END IF 
            CALL ammt320_mmak057_ref()
            LET g_mmak_m_o.* = g_mmak_m.*   #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak057
            #add-point:BEFORE FIELD mmak057 name="input.b.mmak057"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak057
            #add-point:ON CHANGE mmak057 name="input.g.mmak057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak073
            #add-point:BEFORE FIELD mmak073 name="input.b.mmak073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak073
            
            #add-point:AFTER FIELD mmak073 name="input.a.mmak073"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak073
            #add-point:ON CHANGE mmak073 name="input.g.mmak073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak059
            #add-point:BEFORE FIELD mmak059 name="input.b.mmak059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak059
            
            #add-point:AFTER FIELD mmak059 name="input.a.mmak059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak059
            #add-point:ON CHANGE mmak059 name="input.g.mmak059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak027
            #add-point:BEFORE FIELD mmak027 name="input.b.mmak027"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak027
            
            #add-point:AFTER FIELD mmak027 name="input.a.mmak027"
#160302-00028#1 mark by yangxf 20160302
#            IF NOT cl_null(g_mmak_m.mmak027) AND 
#               (g_mmak_m.mmak027 != g_mmak_m_o.mmak027 OR g_mmak_m_o.mmak027 IS NULL) THEN
#
#               IF g_mmak_m.mmak027 = 'Y' THEN
#                  IF cl_null(g_mmak_m_t.mmak028) THEN
#                     LET g_mmak_m.mmak028 = '1'
#                  ELSE
#                     LET g_mmak_m.mmak028 = g_mmak_m_t.mmak028
#                  END IF
#                  
#                  LET g_mmak_m.mmak029 = g_mmak_m_t.mmak029
#                  LET g_mmak_m.mmak030 = g_mmak_m_t.mmak030
#                  LET g_mmak_m.mmak067 = g_mmak_m_t.mmak067         #add by yangxf 
#                  LET g_mmak_m.mmak068 = g_mmak_m_t.mmak068         #add by yangxf 
#                  IF cl_null(g_mmak_m_t.mmak031) THEN
#                     LET g_mmak_m.mmak031 = '1'
#                  ELSE
#                     LET g_mmak_m.mmak031 = g_mmak_m_t.mmak031
#                     LET g_mmak_m.mmak032 = g_mmak_m_t.mmak032
#                     LET g_mmak_m.mmak033 = g_mmak_m_t.mmak033
#                     LET g_mmak_m.mmak034 = g_mmak_m_t.mmak034
#                     LET g_mmak_m.mmak035 = g_mmak_m_t.mmak035
#                  END IF
#                  
#                  IF cl_null(g_mmak_m_t.mmak036) THEN
#                     LET g_mmak_m.mmak036 = '1'
#                  ELSE
#                     LET g_mmak_m.mmak036 = g_mmak_m_t.mmak036
#                  END IF
#                  
#                  IF cl_null(g_mmak_m_t.mmak037) THEN
#                     LET g_mmak_m.mmak037 = '1'
#                  ELSE
#                     LET g_mmak_m.mmak037 = g_mmak_m_t.mmak037
#                  END IF
#               ELSE               
#                  LET g_mmak_m.mmak028 = ''
#                  LET g_mmak_m.mmak029 = '' 
#                  LET g_mmak_m.mmak030 = ''
#                  LET g_mmak_m.mmak067 = ''         #add by yangxf 
#                  LET g_mmak_m.mmak068 = ''         #add by yangxf 
#                  LET g_mmak_m.mmak031 = ''
#                  LET g_mmak_m.mmak032 = ''
#                  LET g_mmak_m.mmak033 = ''
#                  LET g_mmak_m.mmak034 = ''
#                  LET g_mmak_m.mmak035 = ''
#                  LET g_mmak_m.mmak036 = ''
#                  LET g_mmak_m.mmak037 = ''
#               END IF
#
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak031,g_mmak_m.mmak032,
#                            g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak036,g_mmak_m.mmak037,
#                            g_mmak_m.mmak067,g_mmak_m.mmak068     #add by yangxf 
#            LET g_mmak_m_o.mmak027 = g_mmak_m.mmak027
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160302
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak027
            #add-point:ON CHANGE mmak027 name="input.g.mmak027"
            #160302-00028#1 add by yangxf 20160302
            IF g_mmak_m.mmak027 = 'Y' THEN
               IF cl_null(g_mmak_m_t.mmak028) THEN
                  LET g_mmak_m.mmak028 = '1'
               ELSE
                  LET g_mmak_m.mmak028 = g_mmak_m_t.mmak028
               END IF
               LET g_mmak_m.mmak029 = g_mmak_m_t.mmak029
               LET g_mmak_m.mmak030 = g_mmak_m_t.mmak030
               LET g_mmak_m.mmak067 = g_mmak_m_t.mmak067         #add by yangxf 
               LET g_mmak_m.mmak068 = g_mmak_m_t.mmak068         #add by yangxf 
               IF cl_null(g_mmak_m_t.mmak031) THEN
                  LET g_mmak_m.mmak031 = '1'
               ELSE
                  LET g_mmak_m.mmak031 = g_mmak_m_t.mmak031
                  LET g_mmak_m.mmak032 = g_mmak_m_t.mmak032
                  LET g_mmak_m.mmak033 = g_mmak_m_t.mmak033
                  LET g_mmak_m.mmak034 = g_mmak_m_t.mmak034
                  LET g_mmak_m.mmak035 = g_mmak_m_t.mmak035
               END IF
               
               IF cl_null(g_mmak_m_t.mmak036) THEN
                  LET g_mmak_m.mmak036 = '1'
               ELSE
                  LET g_mmak_m.mmak036 = g_mmak_m_t.mmak036
               END IF
               
               IF cl_null(g_mmak_m_t.mmak037) THEN
                  LET g_mmak_m.mmak037 = '1'
               ELSE
                  LET g_mmak_m.mmak037 = g_mmak_m_t.mmak037
               END IF
            ELSE               
               LET g_mmak_m.mmak028 = ''
               LET g_mmak_m.mmak029 = '' 
               LET g_mmak_m.mmak030 = ''
               LET g_mmak_m.mmak067 = ''         #add by yangxf 
               LET g_mmak_m.mmak068 = ''         #add by yangxf 
               LET g_mmak_m.mmak031 = ''
               LET g_mmak_m.mmak032 = ''
               LET g_mmak_m.mmak033 = ''
               LET g_mmak_m.mmak034 = ''
               LET g_mmak_m.mmak035 = ''
               LET g_mmak_m.mmak036 = ''
               LET g_mmak_m.mmak037 = ''
               LET g_mmak_m.mmak038 = 'N'
               LET g_mmak_m.mmak039 = ''
               LET g_mmak_m.mmak040 = ''
               LET g_mmak_m.mmak041 = ''
               LET g_mmak_m.mmak055 = ''
               LET g_mmak_m.mmak056 = ''
            END IF
            DISPLAY BY NAME g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak031,g_mmak_m.mmak032,
                            g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak036,g_mmak_m.mmak037,
                            g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040,
                            g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #160302-00028#1 add by yangxf 20160302
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak028
            #add-point:BEFORE FIELD mmak028 name="input.b.mmak028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak028
            
            #add-point:AFTER FIELD mmak028 name="input.a.mmak028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak028
            #add-point:ON CHANGE mmak028 name="input.g.mmak028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak029,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak029
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak029 name="input.a.mmak029"
            IF NOT cl_null(g_mmak_m.mmak029) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak029
            #add-point:BEFORE FIELD mmak029 name="input.b.mmak029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak029
            #add-point:ON CHANGE mmak029 name="input.g.mmak029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak030,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak030
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak030 name="input.a.mmak030"
            IF NOT cl_null(g_mmak_m.mmak030) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak030
            #add-point:BEFORE FIELD mmak030 name="input.b.mmak030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak030
            #add-point:ON CHANGE mmak030 name="input.g.mmak030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak067
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak067,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak067
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak067 name="input.a.mmak067"
            IF NOT cl_null(g_mmak_m.mmak067) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak067
            #add-point:BEFORE FIELD mmak067 name="input.b.mmak067"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak067
            #add-point:ON CHANGE mmak067 name="input.g.mmak067"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak068
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak068,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak068
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak068 name="input.a.mmak068"
            IF NOT cl_null(g_mmak_m.mmak068) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak068
            #add-point:BEFORE FIELD mmak068 name="input.b.mmak068"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak068
            #add-point:ON CHANGE mmak068 name="input.g.mmak068"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak036
            #add-point:BEFORE FIELD mmak036 name="input.b.mmak036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak036
            
            #add-point:AFTER FIELD mmak036 name="input.a.mmak036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak036
            #add-point:ON CHANGE mmak036 name="input.g.mmak036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak037
            #add-point:BEFORE FIELD mmak037 name="input.b.mmak037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak037
            
            #add-point:AFTER FIELD mmak037 name="input.a.mmak037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak037
            #add-point:ON CHANGE mmak037 name="input.g.mmak037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak031
            #add-point:BEFORE FIELD mmak031 name="input.b.mmak031"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak031
            
            #add-point:AFTER FIELD mmak031 name="input.a.mmak031"
#160302-00028#1 add by yangxf 20160303
#            IF NOT cl_null(g_mmak_m.mmak031) AND 
#               (g_mmak_m.mmak031 != g_mmak_m_o.mmak031 OR g_mmak_m_o.mmak031 IS NULL) THEN
#               CASE g_mmak_m.mmak031 
#                  WHEN '2'
#                     LET g_mmak_m.mmak033 = ''
#                     LET g_mmak_m.mmak034 = ''
#                     LET g_mmak_m.mmak035 = ''
#                  WHEN '3'
#                     LET g_mmak_m.mmak032 = ''
#                     LET g_mmak_m.mmak034 = ''
#                     LET g_mmak_m.mmak035 = ''
#                  WHEN '4'
#                     LET g_mmak_m.mmak032 = ''
#                     LET g_mmak_m.mmak033 = ''
#                  OTHERWISE
#                     LET g_mmak_m.mmak032 = ''
#                     LET g_mmak_m.mmak033 = ''
#                     LET g_mmak_m.mmak034 = ''
#                     LET g_mmak_m.mmak035 = ''
#               END CASE
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak032,g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035
#            LET g_mmak_m_o.mmak031 = g_mmak_m.mmak031
#
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160303
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak031
            #add-point:ON CHANGE mmak031 name="input.g.mmak031"
            #160302-00028#1 add by yangxf 20160303
            CASE g_mmak_m.mmak031 
               WHEN '2'
                  LET g_mmak_m.mmak033 = ''
                  LET g_mmak_m.mmak034 = ''
                  LET g_mmak_m.mmak035 = ''
               WHEN '3'
                  LET g_mmak_m.mmak032 = ''
                  LET g_mmak_m.mmak034 = ''
                  LET g_mmak_m.mmak035 = ''
               WHEN '4'
                  LET g_mmak_m.mmak032 = ''
                  LET g_mmak_m.mmak033 = ''
               OTHERWISE
                  LET g_mmak_m.mmak032 = ''
                  LET g_mmak_m.mmak033 = ''
                  LET g_mmak_m.mmak034 = ''
                  LET g_mmak_m.mmak035 = ''
            END CASE
            DISPLAY BY NAME g_mmak_m.mmak032,g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035

            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #160302-00028#1 add by yangxf 20160303
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak032
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak032,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak032
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak032 name="input.a.mmak032"
            IF NOT cl_null(g_mmak_m.mmak032) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak032
            #add-point:BEFORE FIELD mmak032 name="input.b.mmak032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak032
            #add-point:ON CHANGE mmak032 name="input.g.mmak032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak033,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak033
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak033 name="input.a.mmak033"
            IF NOT cl_null(g_mmak_m.mmak033) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak033
            #add-point:BEFORE FIELD mmak033 name="input.b.mmak033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak033
            #add-point:ON CHANGE mmak033 name="input.g.mmak033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak034
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak034,"1.000","1","12.000","1","azz-00087",1) THEN
               NEXT FIELD mmak034
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak034 name="input.a.mmak034"
            IF NOT cl_null(g_mmak_m.mmak034) AND NOT cl_null(g_mmak_m.mmak035) THEN 
               CALL ammt320_chk_mmak034_35()
               IF NOT cl_null(g_errno) THEN                  
                  LET g_mmak_m.mmak035 = g_mmak_m_t.mmak035
                  NEXT FIELD mmak035
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak034
            #add-point:BEFORE FIELD mmak034 name="input.b.mmak034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak034
            #add-point:ON CHANGE mmak034 name="input.g.mmak034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak035
            #add-point:BEFORE FIELD mmak035 name="input.b.mmak035"
            IF cl_null(g_mmak_m.mmak034) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00105'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD mmak034
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak035
            
            #add-point:AFTER FIELD mmak035 name="input.a.mmak035"
            IF NOT cl_null(g_mmak_m.mmak034) AND NOT cl_null(g_mmak_m.mmak035) THEN 
               CALL ammt320_chk_mmak034_35()
               IF NOT cl_null(g_errno) THEN
                  LET g_mmak_m.mmak035 = g_mmak_m_t.mmak035
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak035
            #add-point:ON CHANGE mmak035 name="input.g.mmak035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak070
            #add-point:BEFORE FIELD mmak070 name="input.b.mmak070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak070
            
            #add-point:AFTER FIELD mmak070 name="input.a.mmak070"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak070
            #add-point:ON CHANGE mmak070 name="input.g.mmak070"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak038
            #add-point:BEFORE FIELD mmak038 name="input.b.mmak038"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak038
            
            #add-point:AFTER FIELD mmak038 name="input.a.mmak038"
#160302-00028#1 mark by yangxf 20160302
#            IF NOT cl_null(g_mmak_m.mmak038) AND 
#               (g_mmak_m.mmak038 != g_mmak_m_o.mmak038 OR g_mmak_m_o.mmak038 IS NULL) THEN
#               IF g_mmak_m.mmak038 = 'Y' THEN
#                  LET g_mmak_m.mmak039 = g_mmak_m_t.mmak039
#                  LET g_mmak_m.mmak040 = g_mmak_m_t.mmak040
#                  LET g_mmak_m.mmak041 = g_mmak_m_t.mmak041
#                  LET g_mmak_m.mmak055 = g_mmak_m_t.mmak055
#                  LET g_mmak_m.mmak056 = g_mmak_m_t.mmak056
#               ELSE              
#                  LET g_mmak_m.mmak039 = ''
#                  LET g_mmak_m.mmak040 = ''
#                  LET g_mmak_m.mmak041 = ''
#                  LET g_mmak_m.mmak055 = ''
#                  LET g_mmak_m.mmak056 = ''
#               END IF
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak039,g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056
#            LET g_mmak_m_o.mmak038 = g_mmak_m.mmak038
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#            CALL ammt320_set_no_required(p_cmd)   #20151028 dongsz add
#            CALL ammt320_set_required(p_cmd)      #20151028 dongsz add
#160302-00028#1 mark by yangxf 20160302
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak038
            #add-point:ON CHANGE mmak038 name="input.g.mmak038"
            #160302-00028#1 add by yangxf 20160302
            IF g_mmak_m.mmak038 = 'Y' THEN
               LET g_mmak_m.mmak039 = g_mmak_m_t.mmak039
               LET g_mmak_m.mmak040 = g_mmak_m_t.mmak040
               LET g_mmak_m.mmak041 = g_mmak_m_t.mmak041
               LET g_mmak_m.mmak055 = g_mmak_m_t.mmak055
               LET g_mmak_m.mmak056 = g_mmak_m_t.mmak056
            ELSE              
               LET g_mmak_m.mmak039 = ''
               LET g_mmak_m.mmak040 = ''
               LET g_mmak_m.mmak041 = ''
               LET g_mmak_m.mmak055 = ''
               LET g_mmak_m.mmak056 = ''
            END IF
            DISPLAY BY NAME g_mmak_m.mmak039,g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            CALL ammt320_set_no_required(p_cmd)
            CALL ammt320_set_required(p_cmd)
            #160302-00028#1 add by yangxf 20160302
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak039
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak039,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak039
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak039 name="input.a.mmak039"
            IF NOT cl_null(g_mmak_m.mmak039) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak039
            #add-point:BEFORE FIELD mmak039 name="input.b.mmak039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak039
            #add-point:ON CHANGE mmak039 name="input.g.mmak039"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak040
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak040,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak040
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak040 name="input.a.mmak040"
            IF NOT cl_null(g_mmak_m.mmak040) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak040
            #add-point:BEFORE FIELD mmak040 name="input.b.mmak040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak040
            #add-point:ON CHANGE mmak040 name="input.g.mmak040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak041
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak041,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak041
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak041 name="input.a.mmak041"
            IF NOT cl_null(g_mmak_m.mmak041) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak041
            #add-point:BEFORE FIELD mmak041 name="input.b.mmak041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak041
            #add-point:ON CHANGE mmak041 name="input.g.mmak041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak055
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak055,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD mmak055
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak055 name="input.a.mmak055"
            IF NOT cl_null(g_mmak_m.mmak055) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak055
            #add-point:BEFORE FIELD mmak055 name="input.b.mmak055"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak055
            #add-point:ON CHANGE mmak055 name="input.g.mmak055"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak056
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak056,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mmak056
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak056 name="input.a.mmak056"
            IF NOT cl_null(g_mmak_m.mmak056) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak056
            #add-point:BEFORE FIELD mmak056 name="input.b.mmak056"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak056
            #add-point:ON CHANGE mmak056 name="input.g.mmak056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak042
            #add-point:BEFORE FIELD mmak042 name="input.b.mmak042"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak042
            
            #add-point:AFTER FIELD mmak042 name="input.a.mmak042"
#160302-00028#1 mark by yangxf 20160302
#            IF NOT cl_null(g_mmak_m.mmak042) AND 
#               (g_mmak_m.mmak042 != g_mmak_m_o.mmak042 OR g_mmak_m_o.mmak042 IS NULL) THEN
#               IF g_mmak_m.mmak042 = 'Y' THEN
#                  IF cl_null(g_mmak_m_t.mmak043) THEN
#                     LET g_mmak_m.mmak043 = 'N'
#                     LET g_mmak_m.mmak065 = 'N'   #add  by geza 20150603
#                  ELSE
#                     LET g_mmak_m.mmak043 = g_mmak_m_t.mmak043
#                     LET g_mmak_m.mmak065 = g_mmak_m_t.mmak065 #add  by geza 20150603
#                  END IF
#                  LET g_mmak_m.mmak044 = g_mmak_m_t.mmak044
#                  LET g_mmak_m.mmak045 = g_mmak_m_t.mmak045
#                  LET g_mmak_m.mmak046 = g_mmak_m_t.mmak046
#               ELSE
#                  LET g_mmak_m.mmak043 = 'N'
#                  LET g_mmak_m.mmak065 = 'N' #add  by geza 20150603
#                  LET g_mmak_m.mmak044 = ''
#                  LET g_mmak_m.mmak045 = ''
#                  LET g_mmak_m.mmak046 = ''
#               END IF
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak043,g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak065 #add  by geza 20150603 mmak065
#            LET g_mmak_m_o.mmak042 = g_mmak_m.mmak042
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_required(p_cmd)
#            CALL ammt320_set_required(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160302
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak042
            #add-point:ON CHANGE mmak042 name="input.g.mmak042"
            #160302-00028#1 add by yangxf 20160302
            IF g_mmak_m.mmak042 = 'Y' THEN
               IF cl_null(g_mmak_m_t.mmak043) THEN
                  LET g_mmak_m.mmak043 = 'N'
                  LET g_mmak_m.mmak065 = 'N'   #add  by geza 20150603
               ELSE
                  LET g_mmak_m.mmak043 = g_mmak_m_t.mmak043
                  LET g_mmak_m.mmak065 = g_mmak_m_t.mmak065 #add  by geza 20150603
               END IF
               LET g_mmak_m.mmak044 = g_mmak_m_t.mmak044
               LET g_mmak_m.mmak045 = g_mmak_m_t.mmak045
               LET g_mmak_m.mmak046 = g_mmak_m_t.mmak046
            ELSE
               #160411-00034#1--dongsz add--str
               #判断是否存在已经储值的卡，存在则不允许修改
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM mmau_t,mmaq_t
                WHERE mmauent = mmaqent AND mmauent = g_enterprise
                  AND mmau001 = mmaq001
                  AND mmaq002 = g_mmak_m.mmak001
                  AND mmaq009 > 0
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00497'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_mmak_m.mmak042 = g_mmak_m_t.mmak042
                  NEXT FIELD mmak042
               END IF
               #160411-00034#1--dongsz add--end
               LET g_mmak_m.mmak043 = 'N'
               LET g_mmak_m.mmak065 = 'N' #add  by geza 20150603
               LET g_mmak_m.mmak044 = ''
               LET g_mmak_m.mmak045 = ''
               LET g_mmak_m.mmak046 = ''
               LET g_mmak_m.mmak047 = 'N'
               LET g_mmak_m.mmak049 = 'N'
               LET g_mmak_m.mmak048 = ''
               LET g_mmak_m.mmak050 = ''
               LET g_mmak_m.mmak051 = ''
               LET g_mmak_m.mmak052 = ''
               LET g_mmak_m.mmak071 = ''    #160604-00009#105
            END IF
            DISPLAY BY NAME g_mmak_m.mmak043,g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak065,
                            g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049,g_mmak_m.mmak050,g_mmak_m.mmak051,
                            g_mmak_m.mmak052                            
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_required(p_cmd)
            CALL ammt320_set_required(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #160302-00028#1 add by yangxf 20160302
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak043
            #add-point:BEFORE FIELD mmak043 name="input.b.mmak043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak043
            
            #add-point:AFTER FIELD mmak043 name="input.a.mmak043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak043
            #add-point:ON CHANGE mmak043 name="input.g.mmak043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak065
            #add-point:BEFORE FIELD mmak065 name="input.b.mmak065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak065
            
            #add-point:AFTER FIELD mmak065 name="input.a.mmak065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak065
            #add-point:ON CHANGE mmak065 name="input.g.mmak065"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak044
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak044,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak044
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak044 name="input.a.mmak044"
            IF NOT cl_null(g_mmak_m.mmak044) THEN 
               IF NOT cl_null(g_mmak_m.mmak045) THEN
                  IF g_mmak_m.mmak044 < g_mmak_m.mmak045 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00107'
                     LET g_errparam.extend = g_mmak_m.mmak044
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmak_m.mmak044 = g_mmak_m_t.mmak044
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_mmak_m.mmak046) THEN                
                  IF g_mmak_m.mmak046 < g_mmak_m.mmak044 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00108'
                     LET g_errparam.extend = g_mmak_m.mmak046
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmak_m.mmak044 = g_mmak_m_t.mmak044
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak044
            #add-point:BEFORE FIELD mmak044 name="input.b.mmak044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak044
            #add-point:ON CHANGE mmak044 name="input.g.mmak044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak045
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak045,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak045
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak045 name="input.a.mmak045"
            IF NOT cl_null(g_mmak_m.mmak045) THEN 
               IF NOT cl_null(g_mmak_m.mmak044) THEN                
                  IF g_mmak_m.mmak044 < g_mmak_m.mmak045 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00107'
                     LET g_errparam.extend = g_mmak_m.mmak045
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmak_m.mmak045 = g_mmak_m_t.mmak045
                     NEXT FIELD CURRENT
                  END IF
               END IF      
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak045
            #add-point:BEFORE FIELD mmak045 name="input.b.mmak045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak045
            #add-point:ON CHANGE mmak045 name="input.g.mmak045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak046
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak046,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak046
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak046 name="input.a.mmak046"
            IF NOT cl_null(g_mmak_m.mmak046) THEN 
               IF NOT cl_null(g_mmak_m.mmak044) THEN
                  IF g_mmak_m.mmak046 < g_mmak_m.mmak044 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00108'
                     LET g_errparam.extend = g_mmak_m.mmak046
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_mmak_m.mmak046 = g_mmak_m_t.mmak046
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak046
            #add-point:BEFORE FIELD mmak046 name="input.b.mmak046"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak046
            #add-point:ON CHANGE mmak046 name="input.g.mmak046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak047
            #add-point:BEFORE FIELD mmak047 name="input.b.mmak047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak047
            
            #add-point:AFTER FIELD mmak047 name="input.a.mmak047"
#160302-00028#1 mark by yangxf 20160302
#            IF NOT cl_null(g_mmak_m.mmak047) AND 
#               (g_mmak_m.mmak047 != g_mmak_m_o.mmak047 OR g_mmak_m_o.mmak047 IS NULL) THEN
#               IF g_mmak_m.mmak047 = 'Y' THEN
#                  LET g_mmak_m.mmak048 = g_mmak_m_t.mmak048
#               ELSE               
#                  LET g_mmak_m.mmak048 = ''
#               END IF
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak048
#            LET g_mmak_m_o.mmak047 = g_mmak_m.mmak047
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160302
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak047
            #add-point:ON CHANGE mmak047 name="input.g.mmak047"
            #160302-00028#1 add by yangxf 20160302
            IF g_mmak_m.mmak047 = 'N' THEN
               LET g_mmak_m.mmak048 = ''
            END IF
            DISPLAY BY NAME g_mmak_m.mmak048
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #160302-00028#1 add by yangxf 20160302
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak048
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak048,"0.000","1","100.00","1","azz-00087",1) THEN
               NEXT FIELD mmak048
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak048 name="input.a.mmak048"
            IF NOT cl_null(g_mmak_m.mmak048) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak048
            #add-point:BEFORE FIELD mmak048 name="input.b.mmak048"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak048
            #add-point:ON CHANGE mmak048 name="input.g.mmak048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak049
            #add-point:BEFORE FIELD mmak049 name="input.b.mmak049"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak049
            
            #add-point:AFTER FIELD mmak049 name="input.a.mmak049"
#160302-00028#1 mark by yangxf 20160302
#            IF NOT cl_null(g_mmak_m.mmak049) AND 
#               (g_mmak_m.mmak049 != g_mmak_m_o.mmak049 OR g_mmak_m_o.mmak049 IS NULL) THEN
#               IF g_mmak_m.mmak049 = 'Y' THEN
#                  LET g_mmak_m.mmak050 = g_mmak_m_t.mmak050
#                  LET g_mmak_m.mmak051 = g_mmak_m_t.mmak051
#                  LET g_mmak_m.mmak052 = g_mmak_m_t.mmak052
#               ELSE               
#                  LET g_mmak_m.mmak050 = ''
#                  LET g_mmak_m.mmak051 = ''
#                  LET g_mmak_m.mmak052 = ''
#               END IF
#            END IF
#            DISPLAY BY NAME g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052
#            LET g_mmak_m_o.mmak049 = g_mmak_m.mmak049
#            CALL ammt320_set_entry(p_cmd)
#            CALL ammt320_set_no_entry(p_cmd)
#160302-00028#1 mark by yangxf 20160302
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak049
            #add-point:ON CHANGE mmak049 name="input.g.mmak049"
            #160302-00028#1 add by yangxf 20160302
            IF g_mmak_m.mmak049 = 'N' THEN
               LET g_mmak_m.mmak050 = ''
               LET g_mmak_m.mmak051 = ''
               LET g_mmak_m.mmak052 = ''
               LET g_mmak_m.mmak071 = ''    #160604-00009#105
            END IF
            #160604-00009#105 -s by 08172
            IF g_mmak_m.mmak049 = 'Y' THEN
               LET g_mmak_m.mmak071 = '1'
            END IF
            #160604-00009#105 -e by 08172
            DISPLAY BY NAME g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052
            CALL ammt320_set_entry(p_cmd)
            CALL ammt320_set_no_entry(p_cmd)
            #160302-00028#1 add by yangxf 20160302
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak071
            #add-point:BEFORE FIELD mmak071 name="input.b.mmak071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak071
            
            #add-point:AFTER FIELD mmak071 name="input.a.mmak071"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak071
            #add-point:ON CHANGE mmak071 name="input.g.mmak071"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak050
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak050,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak050
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak050 name="input.a.mmak050"
            IF NOT cl_null(g_mmak_m.mmak050) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak050
            #add-point:BEFORE FIELD mmak050 name="input.b.mmak050"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak050
            #add-point:ON CHANGE mmak050 name="input.g.mmak050"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak051
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak051,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmak051
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak051 name="input.a.mmak051"
            IF NOT cl_null(g_mmak_m.mmak051) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak051
            #add-point:BEFORE FIELD mmak051 name="input.b.mmak051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak051
            #add-point:ON CHANGE mmak051 name="input.g.mmak051"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmak052
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmak_m.mmak052,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmak052
            END IF 
 
 
 
            #add-point:AFTER FIELD mmak052 name="input.a.mmak052"
            IF NOT cl_null(g_mmak_m.mmak052) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmak052
            #add-point:BEFORE FIELD mmak052 name="input.b.mmak052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmak052
            #add-point:ON CHANGE mmak052 name="input.g.mmak052"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmaksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaksite
            #add-point:ON ACTION controlp INFIELD mmaksite name="input.c.mmaksite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmak_m.mmaksite      #給予default值
            LET g_qryparam.default2 = g_mmak_m.mmaksite_desc #說明(簡稱)
           #sakura---mark---str 
           ##給予arg
           #LET g_qryparam.arg1 = g_site
           #LET g_qryparam.arg2 = "8" #
           #
           #CALL q_ooed004()                                #呼叫開窗
           #
           #LET g_mmak_m.mmaksite = g_qryparam.return1              
           #LET g_mmak_m.mmaksite_desc = g_qryparam.return2 
           #DISPLAY g_mmak_m.mmaksite TO mmaksite              #
           #DISPLAY g_mmak_m.mmaksite_desc TO mmaksite_desc #說明(簡稱)
           #NEXT FIELD mmaksite                          #返回原欄位
           #sakura---mark---end 
           #sakura---add---str
            CALL s_aooi500_q_where(g_prog,'mmaksite',g_mmak_m.mmaksite,'i') RETURNING l_where #150308-00001#3 150309 pomelo add 'i'
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()
            LET g_mmak_m.mmaksite = g_qryparam.return1
            DISPLAY g_mmak_m.mmaksite TO mmaksite
            CALL s_desc_get_department_desc(g_mmak_m.mmaksite) RETURNING g_mmak_m.mmaksite_desc
            DISPLAY BY NAME g_mmak_m.mmaksite_desc
            NEXT FIELD mmaksite                          #返回原欄位              
           #sakura---add---end            


            #END add-point
 
 
         #Ctrlp:input.c.mmakdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakdocdt
            #add-point:ON ACTION controlp INFIELD mmakdocdt name="input.c.mmakdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmakdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakdocno
            #add-point:ON ACTION controlp INFIELD mmakdocno name="input.c.mmakdocno"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.state = 'i'      #sakura add            
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mmak_m.mmakdocno  #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_ooef004               #參照表編號
            #LET g_qryparam.arg2 = "ammt320"              #對應程式代號  #160705-00042#6 160712 by sakura mark
            LET g_qryparam.arg2 = g_prog                  #160705-00042#6 160712 by sakura add
            CALL q_ooba002_1()                            #呼叫開窗
            LET g_mmak_m.mmakdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_mmak_m.mmakdocno TO mmakdocno       #顯示到畫面上
            NEXT FIELD mmakdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mmak000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak000
            #add-point:ON ACTION controlp INFIELD mmak000 name="input.c.mmak000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak001
            #add-point:ON ACTION controlp INFIELD mmak001 name="input.c.mmak001"
            #此段落由子樣板a07產生            
            #開窗i段
            IF g_mmak_m.mmak000 = 'U' THEN
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_mmak_m.mmak001      #給予default值
               CALL q_mman001_2()                                #呼叫開窗
               LET g_mmak_m.mmak001 = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_mmak_m.mmak001 TO mmak001             #顯示到畫面上
               NEXT FIELD mmak001                              #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.mmak002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak002
            #add-point:ON ACTION controlp INFIELD mmak002 name="input.c.mmak002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmakunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakunit
            #add-point:ON ACTION controlp INFIELD mmakunit name="input.c.mmakunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak004
            #add-point:ON ACTION controlp INFIELD mmak004 name="input.c.mmak004"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL #sakura add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mmak_m.mmak004      #給予default值
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = '2'
            CALL q_ooed004()                                #呼叫開窗
            LET g_mmak_m.mmak004 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_mmak_m.mmak004 TO mmak004             #顯示到畫面上
            CALL ammt320_mmak004_ref()
            NEXT FIELD mmak004                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mmakl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakl002
            #add-point:ON ACTION controlp INFIELD mmakl002 name="input.c.mmakl002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmakl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakl003
            #add-point:ON ACTION controlp INFIELD mmakl003 name="input.c.mmakl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak066
            #add-point:ON ACTION controlp INFIELD mmak066 name="input.c.mmak066"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak003
            #add-point:ON ACTION controlp INFIELD mmak003 name="input.c.mmak003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmakacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakacti
            #add-point:ON ACTION controlp INFIELD mmakacti name="input.c.mmakacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmakstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmakstus
            #add-point:ON ACTION controlp INFIELD mmakstus name="input.c.mmakstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak005
            #add-point:ON ACTION controlp INFIELD mmak005 name="input.c.mmak005"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak006
            #add-point:ON ACTION controlp INFIELD mmak006 name="input.c.mmak006"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak007
            #add-point:ON ACTION controlp INFIELD mmak007 name="input.c.mmak007"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak008
            #add-point:ON ACTION controlp INFIELD mmak008 name="input.c.mmak008"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak009
            #add-point:ON ACTION controlp INFIELD mmak009 name="input.c.mmak009"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak010
            #add-point:ON ACTION controlp INFIELD mmak010 name="input.c.mmak010"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak011
            #add-point:ON ACTION controlp INFIELD mmak011 name="input.c.mmak011"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak012
            #add-point:ON ACTION controlp INFIELD mmak012 name="input.c.mmak012"
            IF NOT cl_null(g_mmak_m.mmaksite) THEN
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL #sakura add
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = 'i'
               LET g_qryparam.default1 = g_mmak_m.mmak012       #給予default值
               LET g_qryparam.arg1 = g_mmak_m.mmaksite
               CALL q_rtdx001_1()                                 #呼叫開窗
               LET g_mmak_m.mmak012 = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_mmak_m.mmak012 TO mmak012              #顯示到畫面上
               CALL ammt320_mmak012_ref()
               NEXT FIELD mmak012                               #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.mmak013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak013
            #add-point:ON ACTION controlp INFIELD mmak013 name="input.c.mmak013"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak014
            #add-point:ON ACTION controlp INFIELD mmak014 name="input.c.mmak014"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak015
            #add-point:ON ACTION controlp INFIELD mmak015 name="input.c.mmak015"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak069
            #add-point:ON ACTION controlp INFIELD mmak069 name="input.c.mmak069"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak016
            #add-point:ON ACTION controlp INFIELD mmak016 name="input.c.mmak016"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak017
            #add-point:ON ACTION controlp INFIELD mmak017 name="input.c.mmak017"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak018
            #add-point:ON ACTION controlp INFIELD mmak018 name="input.c.mmak018"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak019
            #add-point:ON ACTION controlp INFIELD mmak019 name="input.c.mmak019"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak020
            #add-point:ON ACTION controlp INFIELD mmak020 name="input.c.mmak020"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak021
            #add-point:ON ACTION controlp INFIELD mmak021 name="input.c.mmak021"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak022
            #add-point:ON ACTION controlp INFIELD mmak022 name="input.c.mmak022"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak023
            #add-point:ON ACTION controlp INFIELD mmak023 name="input.c.mmak023"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak024
            #add-point:ON ACTION controlp INFIELD mmak024 name="input.c.mmak024"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak025
            #add-point:ON ACTION controlp INFIELD mmak025 name="input.c.mmak025"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak062
            #add-point:ON ACTION controlp INFIELD mmak062 name="input.c.mmak062"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak063
            #add-point:ON ACTION controlp INFIELD mmak063 name="input.c.mmak063"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak026
            #add-point:ON ACTION controlp INFIELD mmak026 name="input.c.mmak026"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak064
            #add-point:ON ACTION controlp INFIELD mmak064 name="input.c.mmak064"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak053
            #add-point:ON ACTION controlp INFIELD mmak053 name="input.c.mmak053"
            IF NOT cl_null(g_mmak_m.mmaksite) THEN
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL #sakura add
               LET g_qryparam.state = 'i' #sakura add
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_mmak_m.mmak053      #給予default值
               LET g_qryparam.arg1 = g_mmak_m.mmaksite
               CALL q_rtdx001_1()                              #呼叫開窗
               LET g_mmak_m.mmak053 = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_mmak_m.mmak053 TO mmak053             #顯示到畫面上
               CALL ammt320_mmak053_ref()
               NEXT FIELD mmak053                              #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.mmak060
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak060
            #add-point:ON ACTION controlp INFIELD mmak060 name="input.c.mmak060"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmak_m.mmak060             #給予default值
            LET g_qryparam.default2 = g_mmak_m.mmak060_desc 
            
            #給予arg
            LET g_qryparam.arg1 = g_mmak_m.mmaksite

            
            CALL q_rtdx001_14()                                #呼叫開窗

            LET g_mmak_m.mmak060 = g_qryparam.return1
            LET g_mmak_m.mmak060_desc = g_qryparam.return2            

            DISPLAY g_mmak_m.mmak060 TO mmak060              #
            DISPLAY g_mmak_m.mmak060_desc TO mmak060_desc

            NEXT FIELD mmak060                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmak054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak054
            #add-point:ON ACTION controlp INFIELD mmak054 name="input.c.mmak054"
            IF NOT cl_null(g_mmak_m.mmaksite) THEN
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL #sakura add
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = 'i'
               LET g_qryparam.default1 = g_mmak_m.mmak054      #給予default值
               LET g_qryparam.arg1 = g_mmak_m.mmaksite
               CALL q_rtdx001_14()                              #呼叫開窗
               LET g_mmak_m.mmak054 = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_mmak_m.mmak054 TO mmak054             #顯示到畫面上
               CALL ammt320_mmak054_ref()
               NEXT FIELD mmak054                              #返回原欄位
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.mmak061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak061
            #add-point:ON ACTION controlp INFIELD mmak061 name="input.c.mmak061"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak058
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak058
            #add-point:ON ACTION controlp INFIELD mmak058 name="input.c.mmak058"
            #此段落由子樣板a07產生            
            #20140220 By ming add ----------------------------(S) 
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooiastus = 'Y' AND ooia002 = '60'" 
            LET g_qryparam.default1 = g_mmak_m.mmak058             #給予default值

            #給予arg

            CALL q_ooia001()                                 #呼叫開窗
            LET g_mmak_m.mmak058 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_mmak_m.mmak058 TO mmak058              #顯示到畫面上 
            CALL ammt320_mmak058_ref()  
            NEXT FIELD mmak058                               #返回原欄位

            #20140220 By ming add ----------------------------(E) 
            #END add-point
 
 
         #Ctrlp:input.c.mmak072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak072
            #add-point:ON ACTION controlp INFIELD mmak072 name="input.c.mmak072"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak057
            #add-point:ON ACTION controlp INFIELD mmak057 name="input.c.mmak057"
            #此段落由子樣板a07產生            
            #20140220 By ming add ----------------------------(S) 
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooiastus = 'Y' AND ooia002 = '60' "
            LET g_qryparam.default1 = g_mmak_m.mmak057             #給予default值

            #給予arg

            CALL q_ooia001()                                #呼叫開窗
            LET g_mmak_m.mmak057 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_mmak_m.mmak057 TO mmak057             #顯示到畫面上
            CALL ammt320_mmak057_ref() 
            NEXT FIELD mmak057                              #返回原欄位

            #20140220 By ming add ----------------------------(E) 
            #END add-point
 
 
         #Ctrlp:input.c.mmak073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak073
            #add-point:ON ACTION controlp INFIELD mmak073 name="input.c.mmak073"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak059
            #add-point:ON ACTION controlp INFIELD mmak059 name="input.c.mmak059"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak027
            #add-point:ON ACTION controlp INFIELD mmak027 name="input.c.mmak027"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak028
            #add-point:ON ACTION controlp INFIELD mmak028 name="input.c.mmak028"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak029
            #add-point:ON ACTION controlp INFIELD mmak029 name="input.c.mmak029"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak030
            #add-point:ON ACTION controlp INFIELD mmak030 name="input.c.mmak030"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak067
            #add-point:ON ACTION controlp INFIELD mmak067 name="input.c.mmak067"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak068
            #add-point:ON ACTION controlp INFIELD mmak068 name="input.c.mmak068"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak036
            #add-point:ON ACTION controlp INFIELD mmak036 name="input.c.mmak036"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak037
            #add-point:ON ACTION controlp INFIELD mmak037 name="input.c.mmak037"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak031
            #add-point:ON ACTION controlp INFIELD mmak031 name="input.c.mmak031"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak032
            #add-point:ON ACTION controlp INFIELD mmak032 name="input.c.mmak032"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak033
            #add-point:ON ACTION controlp INFIELD mmak033 name="input.c.mmak033"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak034
            #add-point:ON ACTION controlp INFIELD mmak034 name="input.c.mmak034"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak035
            #add-point:ON ACTION controlp INFIELD mmak035 name="input.c.mmak035"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak070
            #add-point:ON ACTION controlp INFIELD mmak070 name="input.c.mmak070"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak038
            #add-point:ON ACTION controlp INFIELD mmak038 name="input.c.mmak038"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak039
            #add-point:ON ACTION controlp INFIELD mmak039 name="input.c.mmak039"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak040
            #add-point:ON ACTION controlp INFIELD mmak040 name="input.c.mmak040"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak041
            #add-point:ON ACTION controlp INFIELD mmak041 name="input.c.mmak041"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak055
            #add-point:ON ACTION controlp INFIELD mmak055 name="input.c.mmak055"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak056
            #add-point:ON ACTION controlp INFIELD mmak056 name="input.c.mmak056"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak042
            #add-point:ON ACTION controlp INFIELD mmak042 name="input.c.mmak042"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak043
            #add-point:ON ACTION controlp INFIELD mmak043 name="input.c.mmak043"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak065
            #add-point:ON ACTION controlp INFIELD mmak065 name="input.c.mmak065"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak044
            #add-point:ON ACTION controlp INFIELD mmak044 name="input.c.mmak044"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak045
            #add-point:ON ACTION controlp INFIELD mmak045 name="input.c.mmak045"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak046
            #add-point:ON ACTION controlp INFIELD mmak046 name="input.c.mmak046"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak047
            #add-point:ON ACTION controlp INFIELD mmak047 name="input.c.mmak047"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak048
            #add-point:ON ACTION controlp INFIELD mmak048 name="input.c.mmak048"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak049
            #add-point:ON ACTION controlp INFIELD mmak049 name="input.c.mmak049"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak071
            #add-point:ON ACTION controlp INFIELD mmak071 name="input.c.mmak071"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak050
            #add-point:ON ACTION controlp INFIELD mmak050 name="input.c.mmak050"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak051
            #add-point:ON ACTION controlp INFIELD mmak051 name="input.c.mmak051"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmak052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmak052
            #add-point:ON ACTION controlp INFIELD mmak052 name="input.c.mmak052"
            
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
               SELECT COUNT(1) INTO l_count FROM mmak_t
                WHERE mmakent = g_enterprise AND mmakdocno = g_mmak_m.mmakdocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  #160704-00026#1 20160711 add by beckxie---S
                  #備份單據別
                  LET l_bkdocno = g_mmak_m.mmakdocno
                  #160704-00026#1 20160711 add by beckxie---E
                  
                  CALL s_aooi200_gen_docno(g_mmak_m.mmaksite,g_mmak_m.mmakdocno,g_mmak_m.mmakdocdt,g_prog) RETURNING l_flag,g_mmak_m.mmakdocno
                  IF NOT l_flag THEN
                     NEXT FIELD mmakdocno
                  END IF  
                  
                  #160704-00026#1 20160711 add by beckxie---S
                  #更新開窗維護多語言單號key值 
                  UPDATE mmakl_t SET mmakldocno = g_mmak_m.mmakdocno
                   WHERE mmaklent = g_enterprise
                     AND mmakldocno = l_bkdocno
                  LET g_master_multi_table_t.mmakldocno = g_mmak_m.mmakdocno
                  #160704-00026#1 20160711 add by beckxie---E
                  
                  CALL ammt320_carry_data()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = "carry_data"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     NEXT FIELD mmakdocno
                  END IF
                  
                  #當 卡效期延長 更改為'N'時,將 效期延長規則設定清空
                  IF g_mmak_m.mmak023 = 'N' THEN
                     DELETE FROM mmal_t 
                      WHERE mmalent = g_enterprise
                        AND mmaldocno = g_mmak_m.mmakdocno
                  END IF
                  LET g_mmak_m.mmakunit = g_mmak_m.mmaksite #sakura add
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO mmak_t (mmakent,mmaksite,mmakdocdt,mmakdocno,mmak000,mmak001,mmak002,mmakunit, 
                      mmak004,mmak066,mmak003,mmakacti,mmakstus,mmakownid,mmakowndp,mmakcrtid,mmakcrtdp, 
                      mmakcrtdt,mmakmodid,mmakmoddt,mmakcnfid,mmakcnfdt,mmak005,mmak006,mmak007,mmak008, 
                      mmak009,mmak010,mmak011,mmak012,mmak013,mmak014,mmak015,mmak069,mmak016,mmak017, 
                      mmak018,mmak019,mmak020,mmak021,mmak022,mmak023,mmak024,mmak025,mmak062,mmak063, 
                      mmak026,mmak064,mmak053,mmak060,mmak054,mmak061,mmak058,mmak072,mmak057,mmak073, 
                      mmak059,mmak027,mmak028,mmak029,mmak030,mmak067,mmak068,mmak036,mmak037,mmak031, 
                      mmak032,mmak033,mmak034,mmak035,mmak070,mmak038,mmak039,mmak040,mmak041,mmak055, 
                      mmak056,mmak042,mmak043,mmak065,mmak044,mmak045,mmak046,mmak047,mmak048,mmak049, 
                      mmak071,mmak050,mmak051,mmak052)
                  VALUES (g_enterprise,g_mmak_m.mmaksite,g_mmak_m.mmakdocdt,g_mmak_m.mmakdocno,g_mmak_m.mmak000, 
                      g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004,g_mmak_m.mmak066, 
                      g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid,g_mmak_m.mmakowndp, 
                      g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt, 
                      g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007, 
                      g_mmak_m.mmak008,g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012, 
                      g_mmak_m.mmak013,g_mmak_m.mmak014,g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016, 
                      g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021, 
                      g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025,g_mmak_m.mmak062, 
                      g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak060, 
                      g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak072,g_mmak_m.mmak057, 
                      g_mmak_m.mmak073,g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028,g_mmak_m.mmak029, 
                      g_mmak_m.mmak030,g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037, 
                      g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035, 
                      g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040,g_mmak_m.mmak041, 
                      g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065, 
                      g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048, 
                      g_mmak_m.mmak049,g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmak_t:",SQLERRMESSAGE 
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
         IF g_mmak_m.mmakdocno = g_master_multi_table_t.mmakldocno AND
         g_mmak_m.mmakl002 = g_master_multi_table_t.mmakl002 AND 
         g_mmak_m.mmakl003 = g_master_multi_table_t.mmakl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mmaklent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mmak_m.mmakdocno
            LET l_field_keys[02] = 'mmakldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmakldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmakl001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmak_m.mmakl002
            LET l_fields[01] = 'mmakl002'
            LET l_vars[02] = g_mmak_m.mmakl003
            LET l_fields[02] = 'mmakl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmakl_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  LET g_mmakdocno_t = g_mmak_m.mmakdocno
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_mmak_m.mmakdocno
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               IF g_mmak_m.mmak001 != g_mmak_m_t.mmak001 THEN
                  CALL ammt320_carry_data()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = "carry_data"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               
               #當 卡效期延長 更改為'N'時,將 效期延長規則設定清空
               IF g_mmak_m.mmak023 = 'N' THEN
                  DELETE FROM mmal_t 
                   WHERE mmalent = g_enterprise
                     AND mmaldocno = g_mmak_m.mmakdocno
               END IF
               #end add-point
               
               #將遮罩欄位還原
               CALL ammt320_mmak_t_mask_restore('restore_mask_o')
               
               UPDATE mmak_t SET (mmaksite,mmakdocdt,mmakdocno,mmak000,mmak001,mmak002,mmakunit,mmak004, 
                   mmak066,mmak003,mmakacti,mmakstus,mmakownid,mmakowndp,mmakcrtid,mmakcrtdp,mmakcrtdt, 
                   mmakmodid,mmakmoddt,mmakcnfid,mmakcnfdt,mmak005,mmak006,mmak007,mmak008,mmak009,mmak010, 
                   mmak011,mmak012,mmak013,mmak014,mmak015,mmak069,mmak016,mmak017,mmak018,mmak019,mmak020, 
                   mmak021,mmak022,mmak023,mmak024,mmak025,mmak062,mmak063,mmak026,mmak064,mmak053,mmak060, 
                   mmak054,mmak061,mmak058,mmak072,mmak057,mmak073,mmak059,mmak027,mmak028,mmak029,mmak030, 
                   mmak067,mmak068,mmak036,mmak037,mmak031,mmak032,mmak033,mmak034,mmak035,mmak070,mmak038, 
                   mmak039,mmak040,mmak041,mmak055,mmak056,mmak042,mmak043,mmak065,mmak044,mmak045,mmak046, 
                   mmak047,mmak048,mmak049,mmak071,mmak050,mmak051,mmak052) = (g_mmak_m.mmaksite,g_mmak_m.mmakdocdt, 
                   g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit, 
                   g_mmak_m.mmak004,g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus, 
                   g_mmak_m.mmakownid,g_mmak_m.mmakowndp,g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdt, 
                   g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt,g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005, 
                   g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008,g_mmak_m.mmak009,g_mmak_m.mmak010, 
                   g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak013,g_mmak_m.mmak014,g_mmak_m.mmak015, 
                   g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019, 
                   g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024, 
                   g_mmak_m.mmak025,g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064, 
                   g_mmak_m.mmak053,g_mmak_m.mmak060,g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058, 
                   g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak073,g_mmak_m.mmak059,g_mmak_m.mmak027, 
                   g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067,g_mmak_m.mmak068, 
                   g_mmak_m.mmak036,g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033, 
                   g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039, 
                   g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042, 
                   g_mmak_m.mmak043,g_mmak_m.mmak065,g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046, 
                   g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049,g_mmak_m.mmak071,g_mmak_m.mmak050, 
                   g_mmak_m.mmak051,g_mmak_m.mmak052)
                WHERE mmakent = g_enterprise AND mmakdocno = g_mmakdocno_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmak_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmak_t:",SQLERRMESSAGE 
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
         IF g_mmak_m.mmakdocno = g_master_multi_table_t.mmakldocno AND
         g_mmak_m.mmakl002 = g_master_multi_table_t.mmakl002 AND 
         g_mmak_m.mmakl003 = g_master_multi_table_t.mmakl003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mmaklent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mmak_m.mmakdocno
            LET l_field_keys[02] = 'mmakldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmakldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmakl001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmak_m.mmakl002
            LET l_fields[01] = 'mmakl002'
            LET l_vars[02] = g_mmak_m.mmakl003
            LET l_fields[02] = 'mmakl003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmakl_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL ammt320_mmak_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     LET g_mmakdocno_t = g_mmak_m.mmakdocno
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_mmak_m_t)
                     LET g_log2 = util.JSON.stringify(g_mmak_m)
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
 
{<section id="ammt320.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt320_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE mmak_t.mmakdocno 
   DEFINE l_oldno     LIKE mmak_t.mmakdocno 
 
   DEFINE l_master    RECORD LIKE mmak_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert      LIKE type_t.num5    #sakura add
   DEFINE l_success     LIKE type_t.num5    #sakura add
   DEFINE l_doctype     LIKE rtai_t.rtai004 #sakura add
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_mmak_m.mmakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_mmakdocno_t = g_mmak_m.mmakdocno
 
   
   #清空key值
   LET g_mmak_m.mmakdocno = ""
 
    
   CALL ammt320_set_entry("a")
   CALL ammt320_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmak_m.mmakownid = g_user
      LET g_mmak_m.mmakowndp = g_dept
      LET g_mmak_m.mmakcrtid = g_user
      LET g_mmak_m.mmakcrtdp = g_dept 
      LET g_mmak_m.mmakcrtdt = cl_get_current()
      LET g_mmak_m.mmakmodid = g_user
      LET g_mmak_m.mmakmoddt = cl_get_current()
      LET g_mmak_m.mmakstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #sakura---add---str
   CALL s_aooi500_default(g_prog,'mmaksite',g_mmak_m.mmaksite)
      RETURNING l_insert,g_mmak_m.mmaksite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   #預設單據的單別 
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_mmak_m.mmaksite,g_prog,'1') RETURNING l_success, l_doctype
   LET g_mmak_m.mmakdocno = l_doctype   
   #sakura---add---end 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmak_m.mmakstus 
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
   
   
   #資料輸入
   CALL ammt320_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_mmak_m.* TO NULL
      CALL ammt320_show()
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
      LET g_errparam.extend = "mmak_t:",SQLERRMESSAGE 
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
   CALL ammt320_set_act_visible()
   CALL ammt320_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_mmakdocno_t = g_mmak_m.mmakdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmakent = " ||g_enterprise|| " AND",
                      " mmakdocno = '", g_mmak_m.mmakdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt320_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_mmak_m.mmakownid      
   LET g_data_dept  = g_mmak_m.mmakowndp
              
   #功能已完成,通報訊息中心
   CALL ammt320_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="ammt320.show" >}
#+ 資料顯示 
PRIVATE FUNCTION ammt320_show()
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
   CALL ammt320_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmak_m.mmakdocno
   CALL ap_ref_array2(g_ref_fields," SELECT mmakl002,mmakl003 FROM mmakl_t WHERE mmaklent = '"||g_enterprise||"' AND mmakldocno = ? AND mmakl001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_mmak_m.mmakl002 = g_rtn_fields[1] 
   LET g_mmak_m.mmakl003 = g_rtn_fields[2] 
   DISPLAY BY NAME g_mmak_m.mmakl002,g_mmak_m.mmakl003
   CALL ammt320_mmak004_ref()
   CALL ammt320_mmaksite_ref()
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmak_m.mmakownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmak_m.mmakownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmak_m.mmakownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmak_m.mmakowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmak_m.mmakowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmak_m.mmakowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmak_m.mmakcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmak_m.mmakcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmak_m.mmakcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmak_m.mmakcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmak_m.mmakcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmak_m.mmakcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmak_m.mmakmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmak_m.mmakmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmak_m.mmakmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmak_m.mmakcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmak_m.mmakcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmak_m.mmakcnfid_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmak_m.mmak060
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmak_m.mmak060_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmak_m.mmak060_desc
            
   CALL ammt320_mmak012_ref()
   CALL ammt320_mmak053_ref()
   CALL ammt320_mmak054_ref()
   CALL ammt320_mmak004_ref()
   CALL ammt320_mmaksite_ref()
   
   #20140220 By ming add ----------------------------(S) 
   CALL ammt320_mmak057_ref() 
   CALL ammt320_mmak058_ref() 
   #20140220 By ming add ----------------------------(E) 
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmak_m.mmaksite,g_mmak_m.mmaksite_desc,g_mmak_m.mmakdocdt,g_mmak_m.mmakdocno,g_mmak_m.mmak000, 
       g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004_desc,g_mmak_m.mmak004,g_mmak_m.mmakl002, 
       g_mmak_m.mmakl003,g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtid_desc, 
       g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdp_desc,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmodid_desc, 
       g_mmak_m.mmakmoddt,g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005, 
       g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008,g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011, 
       g_mmak_m.mmak012,g_mmak_m.mmak012_desc,g_mmak_m.mmak013,g_mmak_m.mmak014,g_mmak_m.mmak015,g_mmak_m.mmak069, 
       g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021, 
       g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025,g_mmak_m.mmak062,g_mmak_m.mmak063, 
       g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak053_desc,g_mmak_m.mmak060,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054,g_mmak_m.mmak054_desc,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak058_desc, 
       g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak057_desc,g_mmak_m.mmak073,g_mmak_m.mmak059,g_mmak_m.mmak027, 
       g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak036, 
       g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035, 
       g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055, 
       g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065,g_mmak_m.mmak044,g_mmak_m.mmak045, 
       g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049,g_mmak_m.mmak071,g_mmak_m.mmak050, 
       g_mmak_m.mmak051,g_mmak_m.mmak052
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL ammt320_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmak_m.mmakstus 
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
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammt320.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION ammt320_delete()
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
   IF g_mmak_m.mmakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_mmakdocno_t = g_mmak_m.mmakdocno
 
   
   LET g_master_multi_table_t.mmakldocno = g_mmak_m.mmakdocno
LET g_master_multi_table_t.mmakl002 = g_mmak_m.mmakl002
LET g_master_multi_table_t.mmakl003 = g_mmak_m.mmakl003
 
 
   OPEN ammt320_cl USING g_enterprise,g_mmak_m.mmakdocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt320_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE ammt320_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt320_master_referesh USING g_mmak_m.mmakdocno INTO g_mmak_m.mmaksite,g_mmak_m.mmakdocdt, 
       g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004, 
       g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid,g_mmak_m.mmakowndp, 
       g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt, 
       g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008, 
       g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak013,g_mmak_m.mmak014, 
       g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019, 
       g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025, 
       g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak060, 
       g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak073, 
       g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067, 
       g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033, 
       g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040, 
       g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065, 
       g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049, 
       g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052,g_mmak_m.mmaksite_desc,g_mmak_m.mmak004_desc, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid_desc,g_mmak_m.mmakcrtdp_desc, 
       g_mmak_m.mmakmodid_desc,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmak012_desc,g_mmak_m.mmak053_desc,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054_desc,g_mmak_m.mmak058_desc,g_mmak_m.mmak057_desc
   
   
   #檢查是否允許此動作
   IF NOT ammt320_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmak_m_mask_o.* =  g_mmak_m.*
   CALL ammt320_mmak_t_mask()
   LET g_mmak_m_mask_n.* =  g_mmak_m.*
   
   #將最新資料顯示到畫面上
   CALL ammt320_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammt320_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM mmak_t 
       WHERE mmakent = g_enterprise AND mmakdocno = g_mmak_m.mmakdocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmak_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'mmaklent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.mmakldocno
   LET l_field_keys[02] = 'mmakldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mmakl_t')
 
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      DELETE FROM mmakl_t 
       WHERE mmaklent = g_enterprise AND mmakldocno = g_mmak_m.mmakdocno  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmakl_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
      
      DELETE FROM mmal_t 
       WHERE mmalent = g_enterprise AND mmaldocno = g_mmak_m.mmakdocno 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmal_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
      
      DELETE FROM mmam_t 
       WHERE mmament = g_enterprise AND mmamdocno = g_mmak_m.mmakdocno  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmam_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
      #sakura---add---str
      IF NOT s_aooi200_del_docno(g_mmak_m.mmakdocno,g_mmak_m.mmakdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #sakura---add---end
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmak_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE ammt320_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL ammt320_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL ammt320_browser_fill(g_wc,"")
         CALL ammt320_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammt320_cl
 
   #功能已完成,通報訊息中心
   CALL ammt320_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammt320.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt320_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmakdocno = g_mmak_m.mmakdocno
 
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
 
{<section id="ammt320.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt320_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("mmakdocno",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mmakdocdt",TRUE)
      CALL cl_set_comp_entry("mmaksite",TRUE) #sakura add
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mmakacti,mmak000",TRUE)
   CALL cl_set_comp_entry("mmak005,mmak006,mmak007,mmak009",TRUE)
   CALL cl_set_comp_entry("mmak010,mmak011,mmak012,mmak013,mmak014",TRUE)
   CALL cl_set_comp_entry("mmak015,mmak016,mmak017,mmak018,mmak019",TRUE)
   CALL cl_set_comp_entry("mmak020,mmak021,mmak022,mmak023,mmak024",TRUE)
   CALL cl_set_comp_entry("mmak025,mmak026,mmak053,mmak054,mmak027",TRUE)
   CALL cl_set_comp_entry("mmak028,mmak029,mmak030,mmak031,mmak032",TRUE)
   CALL cl_set_comp_entry("mmak033,mmak034,mmak035,mmak036,mmak037",TRUE)
   CALL cl_set_comp_entry("mmak038,mmak039,mmak040,mmak041,mmak042",TRUE)
   CALL cl_set_comp_entry("mmak043,mmak044,mmak045,mmak046,mmak047",TRUE)
   CALL cl_set_comp_entry("mmak048,mmak049,mmak050,mmak051,mmak052",TRUE)
   CALL cl_set_comp_entry("mmak055,mmak056",TRUE)
   CALL cl_set_comp_entry("mmak062",TRUE)
   CALL cl_set_comp_entry("mmak063",TRUE)
   CALL cl_set_comp_entry("mmak064",TRUE)
   CALL cl_set_comp_entry("mmak065",TRUE) #add by geza 20150603
   CALL cl_set_comp_entry("mmak067,mmak068,mmak069",TRUE)    #add by yangxf 
   CALL cl_set_comp_entry("mmak071",TRUE)    #160604-00009#105
   CALL cl_set_comp_entry("mmak057,mmak058,mmak059,mmak060,mmak061,mmak070",TRUE) #160726-00023#1  by 08172
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt320.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt320_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmakdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mmakdocdt",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #sakura---add---str
    IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("mmaksite,mmakdocdt,mmakdocno",FALSE)
   END IF   
   #sakura---add---end   
   IF g_mmak_m.mmak000 = 'I' THEN
      CALL cl_set_comp_entry("mmakacti",FALSE)
   END IF
   
   IF NOT cl_null(g_mmak_m.mmak001) THEN
      CALL cl_set_comp_entry("mmak000",FALSE)
   END IF
   #160302-00028#1 remark by yangxf 20160302 (s)
   #150629-00020#1 150629 by lori mark---(S)
   ##150629-00020#1 150629 by lori add---(S)
   #add by yangxf ---start----
   IF g_mmak_m.mmak015 = 'Y' THEN 
      CALL cl_set_comp_entry("mmak069",FALSE)
   ELSE
      CALL cl_set_comp_entry("mmak069",TRUE)
   END IF 
   #add by yangxf ----end-----
   #150629-00020#1 150629 by lori mark---(E)
   #160302-00028#1 remark by yangxf 20160302 (e)
   #160302-00028#1 mark by yangxf 20160302 (s)
   #150629-00020#1 150629 by lori add---(S)
   #IF g_mmak_m.mmak015 = 'N' THEN
   #   CALL cl_set_comp_entry("mmak069",FALSE)
   #END IF
   #150629-00020#1 150629 by lori add---(E)
   #160302-00028#1 mark by yangxf 20160302 (e)
   #mmak003 = 'Y' 的時候將下面的欄位都設為no_entry
   IF g_mmak_m.mmak003 = 'Y' THEN
      CALL cl_set_comp_entry("mmak005,mmak006,mmak007,mmak009",FALSE)
      CALL cl_set_comp_entry("mmak010,mmak011,mmak012,mmak013,mmak014",FALSE)
      CALL cl_set_comp_entry("mmak015,mmak016,mmak017,mmak018,mmak019",FALSE)
      CALL cl_set_comp_entry("mmak020,mmak021,mmak022,mmak023,mmak024",FALSE)
      CALL cl_set_comp_entry("mmak025,mmak026,mmak053,mmak054,mmak027",FALSE)
      CALL cl_set_comp_entry("mmak028,mmak029,mmak030,mmak031,mmak032",FALSE)
      CALL cl_set_comp_entry("mmak033,mmak034,mmak035,mmak036,mmak037",FALSE)
      CALL cl_set_comp_entry("mmak038,mmak039,mmak040,mmak041,mmak042",FALSE)
      CALL cl_set_comp_entry("mmak043,mmak044,mmak045,mmak046,mmak047",FALSE)
      CALL cl_set_comp_entry("mmak048,mmak049,mmak050,mmak051,mmak052",FALSE)
      CALL cl_set_comp_entry("mmak055,mmak056",FALSE)
      CALL cl_set_comp_entry("mmak062,mmak063,mmak064",FALSE)
      CALL cl_set_comp_entry("mmak067,mmak068,mmak069",FALSE)    #add by yangxf 
      CALL cl_set_comp_entry("mmak057,mmak058,mmak059,mmak060,mmak061,mmak065,mmak070,mmak071",FALSE) #160726-00023#1  by 08172
   ELSE
#      IF cl_null(g_mmak_m.mmak005) THEN
#         CALL cl_set_comp_entry("mmak006,mmak007",FALSE)         
#      END IF
#      IF cl_null(g_mmak_m.mmak006) THEN
#         CALL cl_set_comp_entry("mmak007",FALSE)
#      END IF

#      LET l_cnt = 0
#      SELECT COUNT(*) INTO l_cnt FROM mmax_t
#       WHERE mmaxent = g_enterprise
#         AND mmax001 = g_mmak_m.mmak001
#      IF l_cnt > 0 THEN
#         CALL cl_set_comp_entry("mmak005,mmak006,mmak007",FALSE)
#      END IF

      IF g_mmak_m.mmak009 = '2' THEN
         CALL cl_set_comp_entry("mmak010",FALSE)
      END IF
      
      IF g_mmak_m.mmak018 = 'N' THEN
         CALL cl_set_comp_entry("mmak019,mmak020,mmak021,mmak022,mmak023",FALSE)
      ELSE
         IF cl_null(g_mmak_m.mmak020) THEN
            CALL cl_set_comp_entry("mmak021,mmak022",FALSE)
         ELSE
            CASE g_mmak_m.mmak020
               WHEN '1'
                  CALL cl_set_comp_entry("mmak022",FALSE)
               WHEN '2'
                  CALL cl_set_comp_entry("mmak021",FALSE)
               OTHERWISE
                  CALL cl_set_comp_entry("mmak021,mmak022",FALSE)
            END CASE
         END IF         
      END IF 
      
      IF g_mmak_m.mmak023 = 'N' THEN
         CALL cl_set_comp_entry("mmak024,mmak025",FALSE)
      END IF
      
      IF g_mmak_m.mmak027 = 'N' THEN
         CALL cl_set_comp_entry("mmak028,mmak029,mmak030,mmak031,mmak032",FALSE)
         CALL cl_set_comp_entry("mmak033,mmak034,mmak035,mmak036,mmak037",FALSE)
         CALL cl_set_comp_entry("mmak067,mmak068,mmak038",FALSE)    #add by yangxf 
      ELSE
         IF cl_null(g_mmak_m.mmak031) THEN
            CALL cl_set_comp_entry("mmak032,mmak033,mmak034,mmak035",FALSE)
         ELSE
            CASE g_mmak_m.mmak031
               WHEN '2'
                  CALL cl_set_comp_entry("mmak033,mmak034,mmak035",FALSE)
               WHEN '3'
                  CALL cl_set_comp_entry("mmak032,mmak034,mmak035",FALSE)
               WHEN '4'
                  CALL cl_set_comp_entry("mmak032,mmak033",FALSE)
               OTHERWISE
                  CALL cl_set_comp_entry("mmak032,mmak033,mmak034,mmak035",FALSE)
            END CASE
         END IF         
      END IF 
      
      IF g_mmak_m.mmak038 = 'N' THEN
         CALL cl_set_comp_entry("mmak039,mmak040,mmak041",FALSE)
         CALL cl_set_comp_entry("mmak055,mmak056",FALSE)
      END IF
      
      IF g_mmak_m.mmak042 = 'N' THEN
         CALL cl_set_comp_entry("mmak043,mmak044,mmak045,mmak046,mmak047,mmak049,mmak065",FALSE)
         CALL cl_set_comp_entry("mmak071",FALSE)    #160604-00009#105
      END IF
      
      IF g_mmak_m.mmak047 = 'N' THEN
         CALL cl_set_comp_entry("mmak048",FALSE)
      END IF
      
      IF g_mmak_m.mmak049 = 'N' THEN
         CALL cl_set_comp_entry("mmak050,mmak051,mmak052",FALSE)
         CALL cl_set_comp_entry("mmak071",FALSE)    #160604-00009#105
      END IF
   END IF
   #sakura---add---str
   #aooi500設定的欄位控卡   
   IF NOT s_aooi500_comp_entry(g_prog,'mmadsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("mmaksite",FALSE)
   END IF   
   #sakura---add---end
   
   IF g_mmak_m.mmak062 = 'N' THEN 
      CALL cl_set_comp_entry("mmak063",FALSE)
   END IF
   IF g_mmak_m.mmak026 = 'N' THEN 
      CALL cl_set_comp_entry("mmak064",FALSE)
   END IF
  
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt320.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammt320_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"

   CALL cl_set_act_visible("mmakstus",TRUE) #151109 add 
    
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt320.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammt320_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"

   #add 151109 ----
   IF g_mmak_m.mmakstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   END IF

   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("mmakstus",FALSE)    
   END IF
   #edn add 151109 ----
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt320.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt320_default_search()
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
      LET ls_wc = ls_wc, " mmakdocno = '", g_argv[01], "' AND "
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
 
{<section id="ammt320.mask_functions" >}
&include "erp/amm/ammt320_mask.4gl"
 
{</section>}
 
{<section id="ammt320.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION ammt320_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.chr1
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   #IF g_mmak_m.mmakstus != 'N' THEN       #mod 151109
   IF g_mmak_m.mmakstus MATCHES 'XC' THEN  #mod 151109
      RETURN
   END IF
   IF g_mmak_m.mmakstus = 'Y' THEN
      RETURN
   END IF
   LET g_action_choice="statechange"
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmak_m.mmakdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN ammt320_cl USING g_enterprise,g_mmak_m.mmakdocno
   IF STATUS THEN
      CLOSE ammt320_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt320_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE ammt320_master_referesh USING g_mmak_m.mmakdocno INTO g_mmak_m.mmaksite,g_mmak_m.mmakdocdt, 
       g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004, 
       g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid,g_mmak_m.mmakowndp, 
       g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt, 
       g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008, 
       g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak013,g_mmak_m.mmak014, 
       g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019, 
       g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025, 
       g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak060, 
       g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak073, 
       g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067, 
       g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033, 
       g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040, 
       g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065, 
       g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049, 
       g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052,g_mmak_m.mmaksite_desc,g_mmak_m.mmak004_desc, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid_desc,g_mmak_m.mmakcrtdp_desc, 
       g_mmak_m.mmakmodid_desc,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmak012_desc,g_mmak_m.mmak053_desc,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054_desc,g_mmak_m.mmak058_desc,g_mmak_m.mmak057_desc
   
 
   #檢查是否允許此動作
   IF NOT ammt320_action_chk() THEN
      CLOSE ammt320_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmak_m.mmaksite,g_mmak_m.mmaksite_desc,g_mmak_m.mmakdocdt,g_mmak_m.mmakdocno,g_mmak_m.mmak000, 
       g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004_desc,g_mmak_m.mmak004,g_mmak_m.mmakl002, 
       g_mmak_m.mmakl003,g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid, 
       g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtid_desc, 
       g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdp_desc,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmodid_desc, 
       g_mmak_m.mmakmoddt,g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005, 
       g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008,g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011, 
       g_mmak_m.mmak012,g_mmak_m.mmak012_desc,g_mmak_m.mmak013,g_mmak_m.mmak014,g_mmak_m.mmak015,g_mmak_m.mmak069, 
       g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021, 
       g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025,g_mmak_m.mmak062,g_mmak_m.mmak063, 
       g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak053_desc,g_mmak_m.mmak060,g_mmak_m.mmak060_desc, 
       g_mmak_m.mmak054,g_mmak_m.mmak054_desc,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak058_desc, 
       g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak057_desc,g_mmak_m.mmak073,g_mmak_m.mmak059,g_mmak_m.mmak027, 
       g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak036, 
       g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035, 
       g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055, 
       g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065,g_mmak_m.mmak044,g_mmak_m.mmak045, 
       g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049,g_mmak_m.mmak071,g_mmak_m.mmak050, 
       g_mmak_m.mmak051,g_mmak_m.mmak052
 
   CASE g_mmak_m.mmakstus
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
         CASE g_mmak_m.mmakstus
            
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
      #add 151109
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
      #end add 151109
   
     #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_mmak_m.mmakstus
         WHEN "X"
            HIDE OPTION "confirmed"
            HIDE OPTION "unconfirmed"
            CALL s_transaction_end('N','0')   #160816-00068#4
            RETURN
         WHEN "Y"
            HIDE OPTION "invalid"
            CALL cl_set_act_visible("invalid,confirmed,unhold",FALSE) #add 151109
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE) #add 151109
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
            IF NOT ammt320_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt320_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT ammt320_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt320_cl
            RETURN
         END IF
 
 
 
	  
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
      g_mmak_m.mmakstus = lc_state OR cl_null(lc_state) THEN
      CLOSE ammt320_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y'       
         CALL s_ammt320_conf_chk(g_mmak_m.mmakdocno,g_mmak_m.mmakstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('amm-00136') THEN
               CALL s_transaction_begin()
               CALL s_ammt320_carry_upd(g_mmak_m.mmakdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmak_m.mmakdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_ammt320_conf_upd(g_mmak_m.mmakdocno) RETURNING l_success,g_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmak_m.mmakdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#4            
               RETURN            
            END IF
         ELSE
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmak_m.mmakdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            END IF
            CALL s_transaction_end('N','0')   #160816-00068#4
            RETURN            
         END IF         
      WHEN 'X'
         CALL s_ammt320_void_chk(g_mmak_m.mmakdocno,g_mmak_m.mmakstus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_ammt320_void_upd(g_mmak_m.mmakdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmak_m.mmakdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#4
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmak_m.mmakdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#4
            RETURN    
         END IF
   END CASE 
   #end add-point
   
   LET g_mmak_m.mmakmodid = g_user
   LET g_mmak_m.mmakmoddt = cl_get_current()
   LET g_mmak_m.mmakstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mmak_t 
      SET (mmakstus,mmakmodid,mmakmoddt) 
        = (g_mmak_m.mmakstus,g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt)     
    WHERE mmakent = g_enterprise AND mmakdocno = g_mmak_m.mmakdocno
 
    
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
      EXECUTE ammt320_master_referesh USING g_mmak_m.mmakdocno INTO g_mmak_m.mmaksite,g_mmak_m.mmakdocdt, 
          g_mmak_m.mmakdocno,g_mmak_m.mmak000,g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004, 
          g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti,g_mmak_m.mmakstus,g_mmak_m.mmakownid,g_mmak_m.mmakowndp, 
          g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdt,g_mmak_m.mmakmodid,g_mmak_m.mmakmoddt, 
          g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfdt,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008, 
          g_mmak_m.mmak009,g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak013,g_mmak_m.mmak014, 
          g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018,g_mmak_m.mmak019, 
          g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024,g_mmak_m.mmak025, 
          g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053,g_mmak_m.mmak060, 
          g_mmak_m.mmak054,g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak072,g_mmak_m.mmak057,g_mmak_m.mmak073, 
          g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028,g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067, 
          g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037,g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033, 
          g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070,g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040, 
          g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056,g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065, 
          g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046,g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049, 
          g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051,g_mmak_m.mmak052,g_mmak_m.mmaksite_desc, 
          g_mmak_m.mmak004_desc,g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp_desc,g_mmak_m.mmakcrtid_desc, 
          g_mmak_m.mmakcrtdp_desc,g_mmak_m.mmakmodid_desc,g_mmak_m.mmakcnfid_desc,g_mmak_m.mmak012_desc, 
          g_mmak_m.mmak053_desc,g_mmak_m.mmak060_desc,g_mmak_m.mmak054_desc,g_mmak_m.mmak058_desc,g_mmak_m.mmak057_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mmak_m.mmaksite,g_mmak_m.mmaksite_desc,g_mmak_m.mmakdocdt,g_mmak_m.mmakdocno, 
          g_mmak_m.mmak000,g_mmak_m.mmak001,g_mmak_m.mmak002,g_mmak_m.mmakunit,g_mmak_m.mmak004_desc, 
          g_mmak_m.mmak004,g_mmak_m.mmakl002,g_mmak_m.mmakl003,g_mmak_m.mmak066,g_mmak_m.mmak003,g_mmak_m.mmakacti, 
          g_mmak_m.mmakstus,g_mmak_m.mmakownid,g_mmak_m.mmakownid_desc,g_mmak_m.mmakowndp,g_mmak_m.mmakowndp_desc, 
          g_mmak_m.mmakcrtid,g_mmak_m.mmakcrtid_desc,g_mmak_m.mmakcrtdp,g_mmak_m.mmakcrtdp_desc,g_mmak_m.mmakcrtdt, 
          g_mmak_m.mmakmodid,g_mmak_m.mmakmodid_desc,g_mmak_m.mmakmoddt,g_mmak_m.mmakcnfid,g_mmak_m.mmakcnfid_desc, 
          g_mmak_m.mmakcnfdt,g_mmak_m.mmak005,g_mmak_m.mmak006,g_mmak_m.mmak007,g_mmak_m.mmak008,g_mmak_m.mmak009, 
          g_mmak_m.mmak010,g_mmak_m.mmak011,g_mmak_m.mmak012,g_mmak_m.mmak012_desc,g_mmak_m.mmak013, 
          g_mmak_m.mmak014,g_mmak_m.mmak015,g_mmak_m.mmak069,g_mmak_m.mmak016,g_mmak_m.mmak017,g_mmak_m.mmak018, 
          g_mmak_m.mmak019,g_mmak_m.mmak020,g_mmak_m.mmak021,g_mmak_m.mmak022,g_mmak_m.mmak023,g_mmak_m.mmak024, 
          g_mmak_m.mmak025,g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak026,g_mmak_m.mmak064,g_mmak_m.mmak053, 
          g_mmak_m.mmak053_desc,g_mmak_m.mmak060,g_mmak_m.mmak060_desc,g_mmak_m.mmak054,g_mmak_m.mmak054_desc, 
          g_mmak_m.mmak061,g_mmak_m.mmak058,g_mmak_m.mmak058_desc,g_mmak_m.mmak072,g_mmak_m.mmak057, 
          g_mmak_m.mmak057_desc,g_mmak_m.mmak073,g_mmak_m.mmak059,g_mmak_m.mmak027,g_mmak_m.mmak028, 
          g_mmak_m.mmak029,g_mmak_m.mmak030,g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak036,g_mmak_m.mmak037, 
          g_mmak_m.mmak031,g_mmak_m.mmak032,g_mmak_m.mmak033,g_mmak_m.mmak034,g_mmak_m.mmak035,g_mmak_m.mmak070, 
          g_mmak_m.mmak038,g_mmak_m.mmak039,g_mmak_m.mmak040,g_mmak_m.mmak041,g_mmak_m.mmak055,g_mmak_m.mmak056, 
          g_mmak_m.mmak042,g_mmak_m.mmak043,g_mmak_m.mmak065,g_mmak_m.mmak044,g_mmak_m.mmak045,g_mmak_m.mmak046, 
          g_mmak_m.mmak047,g_mmak_m.mmak048,g_mmak_m.mmak049,g_mmak_m.mmak071,g_mmak_m.mmak050,g_mmak_m.mmak051, 
          g_mmak_m.mmak052
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   CALL ammt320_fetch('')
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE ammt320_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt320_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt320.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION ammt320_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.chr2
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
 
 
   CALL ammt320_show()
   CALL ammt320_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_ammt320_conf_chk(g_mmak_m.mmakdocno,g_mmak_m.mmakstus) RETURNING l_success,g_errno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = g_errno
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0') #add
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mmak_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
 
 
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
   #CALL ammt320_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION ammt320_draw_out()
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
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="ammt320.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammt320_set_pk_array()
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
   LET g_pk_array[1].values = g_mmak_m.mmakdocno
   LET g_pk_array[1].column = 'mmakdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt320.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="ammt320.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammt320_msgcentre_notify(lc_state)
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
   CALL ammt320_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmak_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt320.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammt320_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#21 add-S
   SELECT mmakstus  INTO g_mmak_m.mmakstus
     FROM mmak_t
    WHERE mmakent = g_enterprise
      AND mmakdocno = g_mmak_m.mmakdocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mmak_m.mmakstus
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
        LET g_errparam.extend = g_mmak_m.mmakdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL ammt320_set_act_visible()
        CALL ammt320_set_act_no_visible()
        CALL ammt320_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#21 add-E
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt320.other_function" readonly="Y" >}
#+
PUBLIC FUNCTION ammt320_chk_mmakdocno()
   DEFINE l_stus        LIKE type_t.chr1

   LET g_errno = ''
   SELECT oobastus INTO l_stus  FROM ooba_t,oobl_t
    WHERE oobaent = ooblent   AND ooba001 = oobl001
      AND ooba002 = oobl002   AND oobl003 = 'ammt320'
      AND oobl001 = g_ooef004 AND oobl002 = g_mmak_m.mmakdocno
      AND ooblent = g_enterprise

   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aim-00056'
        WHEN l_stus='N'            LET g_errno = 'aoo-00102'
   END CASE
END FUNCTION
#+
PUBLIC FUNCTION ammt320_chk_mmak001()
   DEFINE l_cnt    LIKE type_t.num5

   LET g_errno = ''
   CASE g_mmak_m.mmak000
      WHEN 'I'
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM mman_t
          WHERE mmanent = g_enterprise
            AND mman001 = g_mmak_m.mmak001
         IF l_cnt > 0 THEN
            #輸入的卡種編號已存在 會員卡種主檔 中
            LET g_errno = 'amm-00097'
         END IF

         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM mmak_t
          WHERE mmakent = g_enterprise
            AND mmak001 = g_mmak_m.mmak001
         IF l_cnt > 0 THEN
            #輸入的卡種編號已存在 卡種基本資料申請檔 中
            LET g_errno = 'amm-00098'
         END IF

      WHEN 'U'
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM mman_t
          WHERE mmanent = g_enterprise
            AND mman001 = g_mmak_m.mmak001
         IF l_cnt = 0 THEN
            #輸入的卡種編號不存在 會員卡種主檔 中
            LET g_errno = 'amm-00099'
         END IF
         IF NOT cl_null(g_mmak_m.mmakdocno) THEN
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM mmak_t
             WHERE mmakent = g_enterprise
               AND mmakdocno != g_mmak_m.mmakdocno
               AND mmak001 = g_mmak_m.mmak001
               AND mmakstus = 'N'
            IF l_cnt > 0 THEN
               #已存在一張相卡種編號,但未拋轉的會員卡種申請單!
               LET g_errno = 'amm-00100'
            END IF
         ELSE
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM mmak_t
             WHERE mmakent = g_enterprise
               AND mmak001 = g_mmak_m.mmak001
               AND mmakstus = 'N'
            IF l_cnt > 0 THEN
               #已存在一張相卡種編號,但未拋轉的會員卡種申請單!
               LET g_errno = 'amm-00100'
            END IF
         END IF

      OTHERWISE
         LET g_errno = 'art-00013'
   END CASE
END FUNCTION
#+
PUBLIC FUNCTION ammt320_carry_mman()
   DEFINE l_mman RECORD
      mman001     LIKE mman_t.mman001, 
      mman002     LIKE mman_t.mman002, 
      mman004     LIKE mman_t.mman004, 
      mman003     LIKE mman_t.mman003, 
      mman005     LIKE mman_t.mman005, 
      mman006     LIKE mman_t.mman006, 
      mman007     LIKE mman_t.mman007, 
      mman008     LIKE mman_t.mman008, 
      mman009     LIKE mman_t.mman009, 
      mman010     LIKE mman_t.mman010, 
      mman011     LIKE mman_t.mman011, 
      mman012     LIKE mman_t.mman012, 
      mman013     LIKE mman_t.mman013, 
      mman014     LIKE mman_t.mman014, 
      mman015     LIKE mman_t.mman015, 
      mman016     LIKE mman_t.mman016, 
      mman017     LIKE mman_t.mman017, 
      mman018     LIKE mman_t.mman018, 
      mman019     LIKE mman_t.mman019, 
      mman020     LIKE mman_t.mman020, 
      mman021     LIKE mman_t.mman021, 
      mman022     LIKE mman_t.mman022, 
      mman023     LIKE mman_t.mman023, 
      mman024     LIKE mman_t.mman024, 
      mman025     LIKE mman_t.mman025, 
      mman026     LIKE mman_t.mman026, 
      mman053     LIKE mman_t.mman053, 
      mman054     LIKE mman_t.mman054, 
      mman027     LIKE mman_t.mman027, 
      mman028     LIKE mman_t.mman028, 
      mman029     LIKE mman_t.mman029, 
      mman030     LIKE mman_t.mman030, 
      mman031     LIKE mman_t.mman031, 
      mman032     LIKE mman_t.mman032, 
      mman033     LIKE mman_t.mman033, 
      mman034     LIKE mman_t.mman034, 
      mman035     LIKE mman_t.mman035, 
      mman036     LIKE mman_t.mman036, 
      mman037     LIKE mman_t.mman037, 
      mman038     LIKE mman_t.mman038, 
      mman039     LIKE mman_t.mman039, 
      mman040     LIKE mman_t.mman040, 
      mman041     LIKE mman_t.mman041, 
      mman042     LIKE mman_t.mman042, 
      mman043     LIKE mman_t.mman043, 
      mman044     LIKE mman_t.mman044, 
      mman045     LIKE mman_t.mman045, 
      mman046     LIKE mman_t.mman046, 
      mman047     LIKE mman_t.mman047, 
      mman048     LIKE mman_t.mman048, 
      mman049     LIKE mman_t.mman049, 
      mman050     LIKE mman_t.mman050, 
      mman051     LIKE mman_t.mman051, 
      mman052     LIKE mman_t.mman052, 
      mmanstus    LIKE mman_t.mmanstus,
      mman057     LIKE mman_t.mman057,      #20140220 By ming add 
      mman058     LIKE mman_t.mman058,      #20140220 By ming add
      mman059     LIKE mman_t.mman059,      #160728-00006#37 by 08172      
      mman061     LIKE mman_t.mman061,      #20150414 By geza add 
      mman062     LIKE mman_t.mman062,      #20150430 By geza add  
      mman063     LIKE mman_t.mman063,      #20150430 By geza add 
      mman064     LIKE mman_t.mman064,       #20150430 By geza add 
      mman065     LIKE mman_t.mman065,       #20150603 By geza add
      mman066     LIKE mman_t.mman066,      #add by yangxf 
      mman067     LIKE mman_t.mman067,      #add by yangxf 
      mman068     LIKE mman_t.mman068,      #add by yangxf 
      mman069     LIKE mman_t.mman069,
      mman070     LIKE mman_t.mman070,       #add by geza 20150818 
      mman071     LIKE mman_t.mman071,        #160604-00009#105
      mman072     LIKE mman_t.mman072,        #160819-00054#26  add mmak072 by rainy 16/10/21
      mman073     LIKE mman_t.mman073         #160819-00054#26  add mmak073 by rainy 16/10/21
          END RECORD
   DEFINE l_mmanl RECORD
      mmanl003    LIKE mmanl_t.mmanl003,
      mmanl004    LIKE mmanl_t.mmanl004
          END RECORD
      
   SELECT mman001, mman002, mman004, mman003, mman005, 
          mman006, mman007, mman008, mman009, mman010, 
          mman011, mman012, mman013, mman014, mman015, 
          mman016, mman017, mman018, mman019, mman020, 
          mman021, mman022, mman023, mman024, mman025, 
          mman026, mman053, mman054, mman027, mman028, 
          mman029, mman030, mman031, mman032, mman033, 
          mman034, mman035, mman036, mman037, mman038, 
          mman039, mman040, mman041, mman042, mman043, 
          mman044, mman045, mman046, mman047, mman048, 
          mman049, mman050, mman051, mman052, mmanstus, 
          mman057, mman058, mman059, mman061, mman062, mman063, mman064,mman065,   #20140220 By ming add #2015/04/09 By geza add mman061 mman062 mman063 mman064,mman065  #160728-00006#37  add mman059 by 08172                      
          mman066, mman067, mman068, mman069, mman070,  #add by geza 20150818  mman070                                                #add by yangxf 
          mman071,           #160604-00009#105
          mman072, mman073   #160819-00054#26  add mmak072,mmak073 by rainy 16/10/21
     INTO l_mman.*
     FROM mman_t
    WHERE mman001 = g_mmak_m.mmak001
      AND mmanent = g_enterprise
    
   LET  g_mmak_m.mmak002 = l_mman.mman002 + 1 USING "<<<<<<<<#"
   LET  g_mmak_m.mmak004 = l_mman.mman004 
   LET  g_mmak_m.mmak003 = l_mman.mman003 
   LET  g_mmak_m.mmak005 = l_mman.mman005 
   LET  g_mmak_m.mmak006 = l_mman.mman006 
   LET  g_mmak_m.mmak007 = l_mman.mman007 
   LET  g_mmak_m.mmak008 = l_mman.mman008 
   LET  g_mmak_m.mmak009 = l_mman.mman009 
   LET  g_mmak_m.mmak010 = l_mman.mman010 
   LET  g_mmak_m.mmak011 = l_mman.mman011 
   LET  g_mmak_m.mmak012 = l_mman.mman012 
   LET  g_mmak_m.mmak013 = l_mman.mman013 
   LET  g_mmak_m.mmak014 = l_mman.mman014 
   LET  g_mmak_m.mmak015 = l_mman.mman015 
   LET  g_mmak_m.mmak016 = l_mman.mman016 
   LET  g_mmak_m.mmak017 = l_mman.mman017 
   LET  g_mmak_m.mmak018 = l_mman.mman018 
   LET  g_mmak_m.mmak019 = l_mman.mman019 
   LET  g_mmak_m.mmak020 = l_mman.mman020 
   LET  g_mmak_m.mmak021 = l_mman.mman021 
   LET  g_mmak_m.mmak022 = l_mman.mman022 
   LET  g_mmak_m.mmak023 = l_mman.mman023 
   LET  g_mmak_m.mmak024 = l_mman.mman024 
   LET  g_mmak_m.mmak025 = l_mman.mman025 
   LET  g_mmak_m.mmak026 = l_mman.mman026 
   LET  g_mmak_m.mmak053 = l_mman.mman053 
   LET  g_mmak_m.mmak054 = l_mman.mman054 
   LET  g_mmak_m.mmak027 = l_mman.mman027 
   LET  g_mmak_m.mmak028 = l_mman.mman028 
   LET  g_mmak_m.mmak029 = l_mman.mman029 
   LET  g_mmak_m.mmak030 = l_mman.mman030 
   LET  g_mmak_m.mmak066 = l_mman.mman066         #add by yangxf 
   LET  g_mmak_m.mmak067 = l_mman.mman067         #add by yangxf 
   LET  g_mmak_m.mmak068 = l_mman.mman068         #add by yangxf 
   LET  g_mmak_m.mmak069 = l_mman.mman069         #add by yangxf 
   LET  g_mmak_m.mmak031 = l_mman.mman031 
   LET  g_mmak_m.mmak032 = l_mman.mman032 
   LET  g_mmak_m.mmak033 = l_mman.mman033 
   LET  g_mmak_m.mmak034 = l_mman.mman034 
   LET  g_mmak_m.mmak035 = l_mman.mman035 
   LET  g_mmak_m.mmak036 = l_mman.mman036 
   LET  g_mmak_m.mmak037 = l_mman.mman037 
   LET  g_mmak_m.mmak038 = l_mman.mman038 
   LET  g_mmak_m.mmak039 = l_mman.mman039 
   LET  g_mmak_m.mmak040 = l_mman.mman040 
   LET  g_mmak_m.mmak041 = l_mman.mman041 
   LET  g_mmak_m.mmak042 = l_mman.mman042 
   LET  g_mmak_m.mmak043 = l_mman.mman043 
   LET  g_mmak_m.mmak044 = l_mman.mman044 
   LET  g_mmak_m.mmak045 = l_mman.mman045 
   LET  g_mmak_m.mmak046 = l_mman.mman046 
   LET  g_mmak_m.mmak047 = l_mman.mman047 
   LET  g_mmak_m.mmak048 = l_mman.mman048 
   LET  g_mmak_m.mmak049 = l_mman.mman049 
   LET  g_mmak_m.mmak050 = l_mman.mman050 
   LET  g_mmak_m.mmak051 = l_mman.mman051 
   LET  g_mmak_m.mmak052 = l_mman.mman052 
   #20140220 By ming add -----------------(S) 
   LET  g_mmak_m.mmak057 = l_mman.mman057 
   LET  g_mmak_m.mmak058 = l_mman.mman058 
   #20140220 By ming add -----------------(E) 
   LET  g_mmak_m.mmak059 = l_mman.mman059    #160728-00006#37  by 08172                      
   #20150409 By geza add -----------------(S)
   LET  g_mmak_m.mmak061 = l_mman.mman061 
   #20150409 By geza add -----------------(E)
   #20150430 By geza add -----------------(S)
   LET  g_mmak_m.mmak062 = l_mman.mman062
   LET  g_mmak_m.mmak063 = l_mman.mman063
   LET  g_mmak_m.mmak064 = l_mman.mman064
   #20150430 By geza add -----------------(E)
   LET  g_mmak_m.mmak065 = l_mman.mman065  #20150603 By geza add
   LET  g_mmak_m.mmak070 = l_mman.mman070  #add by geza 20150818
   LET  g_mmak_m.mmak071 = l_mman.mman071  #160604-00009#105
   LET  g_mmak_m.mmak072 = l_mman.mman072  #160819-00054#26 add by rainy 16/10/21
   LET  g_mmak_m.mmak073 = l_mman.mman073  #160819-00054#26 add by rainy 16/10/21
   
   LET  g_mmak_m_t.mmak002 = l_mman.mman002 + 1 USING "<<<<<<<<#"
   LET  g_mmak_m_t.mmak004 = l_mman.mman004 
   LET  g_mmak_m_t.mmak003 = l_mman.mman003 
   LET  g_mmak_m_t.mmak005 = l_mman.mman005 
   LET  g_mmak_m_t.mmak006 = l_mman.mman006 
   LET  g_mmak_m_t.mmak007 = l_mman.mman007 
   LET  g_mmak_m_t.mmak008 = l_mman.mman008 
   LET  g_mmak_m_t.mmak009 = l_mman.mman009 
   LET  g_mmak_m_t.mmak010 = l_mman.mman010 
   LET  g_mmak_m_t.mmak011 = l_mman.mman011 
   LET  g_mmak_m_t.mmak012 = l_mman.mman012 
   LET  g_mmak_m_t.mmak013 = l_mman.mman013 
   LET  g_mmak_m_t.mmak014 = l_mman.mman014 
   LET  g_mmak_m_t.mmak015 = l_mman.mman015 
   LET  g_mmak_m_t.mmak016 = l_mman.mman016 
   LET  g_mmak_m_t.mmak017 = l_mman.mman017 
   LET  g_mmak_m_t.mmak018 = l_mman.mman018 
   LET  g_mmak_m_t.mmak019 = l_mman.mman019 
   LET  g_mmak_m_t.mmak020 = l_mman.mman020 
   LET  g_mmak_m_t.mmak021 = l_mman.mman021 
   LET  g_mmak_m_t.mmak022 = l_mman.mman022 
   LET  g_mmak_m_t.mmak023 = l_mman.mman023 
   LET  g_mmak_m_t.mmak024 = l_mman.mman024 
   LET  g_mmak_m_t.mmak025 = l_mman.mman025 
   LET  g_mmak_m_t.mmak026 = l_mman.mman026 
   LET  g_mmak_m_t.mmak053 = l_mman.mman053 
   LET  g_mmak_m_t.mmak054 = l_mman.mman054 
   LET  g_mmak_m_t.mmak027 = l_mman.mman027 
   LET  g_mmak_m_t.mmak028 = l_mman.mman028 
   LET  g_mmak_m_t.mmak029 = l_mman.mman029 
   LET  g_mmak_m_t.mmak030 = l_mman.mman030 
   LET  g_mmak_m_t.mmak066 = l_mman.mman066     #add by yangxf
   LET  g_mmak_m_t.mmak067 = l_mman.mman067     #add by yangxf
   LET  g_mmak_m_t.mmak068 = l_mman.mman068     #add by yangxf 
   LET  g_mmak_m_t.mmak069 = l_mman.mman069     #add by yangxf 
   LET  g_mmak_m_t.mmak031 = l_mman.mman031 
   LET  g_mmak_m_t.mmak032 = l_mman.mman032 
   LET  g_mmak_m_t.mmak033 = l_mman.mman033 
   LET  g_mmak_m_t.mmak034 = l_mman.mman034 
   LET  g_mmak_m_t.mmak035 = l_mman.mman035 
   LET  g_mmak_m_t.mmak036 = l_mman.mman036 
   LET  g_mmak_m_t.mmak037 = l_mman.mman037 
   LET  g_mmak_m_t.mmak038 = l_mman.mman038 
   LET  g_mmak_m_t.mmak039 = l_mman.mman039 
   LET  g_mmak_m_t.mmak040 = l_mman.mman040 
   LET  g_mmak_m_t.mmak041 = l_mman.mman041 
   LET  g_mmak_m_t.mmak042 = l_mman.mman042 
   LET  g_mmak_m_t.mmak043 = l_mman.mman043 
   LET  g_mmak_m_t.mmak044 = l_mman.mman044 
   LET  g_mmak_m_t.mmak045 = l_mman.mman045 
   LET  g_mmak_m_t.mmak046 = l_mman.mman046 
   LET  g_mmak_m_t.mmak047 = l_mman.mman047 
   LET  g_mmak_m_t.mmak048 = l_mman.mman048 
   LET  g_mmak_m_t.mmak049 = l_mman.mman049 
   LET  g_mmak_m_t.mmak050 = l_mman.mman050 
   LET  g_mmak_m_t.mmak051 = l_mman.mman051 
   LET  g_mmak_m_t.mmak052 = l_mman.mman052 
   #20140220 By ming add -----------------(S)   
   LET  g_mmak_m_t.mmak057 = l_mman.mman057 
   LET  g_mmak_m_t.mmak058 = l_mman.mman058 
   #20140220 By ming add -----------------(E) 
   #20150409 By geza add -----------------(S)
   LET  g_mmak_m_t.mmak061 = l_mman.mman061 
   #20150409 By geza add -----------------(E)
   #20150430 By geza add -----------------(S)
   LET  g_mmak_m_t.mmak062 = l_mman.mman062
   LET  g_mmak_m_t.mmak063 = l_mman.mman063
   LET  g_mmak_m_t.mmak064 = l_mman.mman064
   #20150430 By geza add -----------------(E)
   LET  g_mmak_m_t.mmak065 = l_mman.mman065  #20150603 By geza add
   LET  g_mmak_m_t.mmak070 = l_mman.mman070  #add by geza 20150818
   LET  g_mmak_m_t.mmak071 = l_mman.mman071  #160604-00009#105
   LET  g_mmak_m_t.mmak072 = l_mman.mman072  #160819-00054#26 add by rainy 16/10/21
   LET  g_mmak_m_t.mmak073 = l_mman.mman073  #160819-00054#26 add by rainy 16/10/21
   
   IF l_mman.mmanstus = 'X' THEN
      LET g_mmak_m.mmakacti = 'N'
   ELSE
      LET g_mmak_m.mmakacti = 'Y'
   END IF
   LET g_mmak_m_o.* = g_mmak_m_t.*
   DISPLAY BY NAME g_mmak_m.mmak002, g_mmak_m.mmak004, g_mmak_m.mmak003, g_mmak_m.mmak005,
                   g_mmak_m.mmak006, g_mmak_m.mmak007, g_mmak_m.mmak008, g_mmak_m.mmak009,
                   g_mmak_m.mmak010, g_mmak_m.mmak011, g_mmak_m.mmak012, g_mmak_m.mmak013,
                   g_mmak_m.mmak014, g_mmak_m.mmak015, g_mmak_m.mmak016, g_mmak_m.mmak017,
                   g_mmak_m.mmak018, g_mmak_m.mmak019, g_mmak_m.mmak020, g_mmak_m.mmak021,
                   g_mmak_m.mmak022, g_mmak_m.mmak023, g_mmak_m.mmak024, g_mmak_m.mmak025,
                   g_mmak_m.mmak026, g_mmak_m.mmak053, g_mmak_m.mmak054, g_mmak_m.mmak027,
                   g_mmak_m.mmak028, g_mmak_m.mmak029, g_mmak_m.mmak030, g_mmak_m.mmak031,
                   g_mmak_m.mmak032, g_mmak_m.mmak033, g_mmak_m.mmak034, g_mmak_m.mmak035,
                   g_mmak_m.mmak036, g_mmak_m.mmak037, g_mmak_m.mmak038, g_mmak_m.mmak039,
                   g_mmak_m.mmak040, g_mmak_m.mmak041, g_mmak_m.mmak042, g_mmak_m.mmak043,
                   g_mmak_m.mmak044, g_mmak_m.mmak045, g_mmak_m.mmak046, g_mmak_m.mmak047,
                   g_mmak_m.mmak048, g_mmak_m.mmak049, g_mmak_m.mmak050, g_mmak_m.mmak051,
                   g_mmak_m.mmak052, g_mmak_m.mmakacti
   DISPLAY BY NAME g_mmak_m.mmak057,g_mmak_m.mmak058  #20140220 By ming add 
   DISPLAY BY NAME g_mmak_m.mmak059    #160728-00006#37 by 08172
   DISPLAY BY NAME g_mmak_m.mmak061  #20150409 By geza add 
   DISPLAY BY NAME g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak064  #20150430 By geza add
   DISPLAY BY NAME g_mmak_m.mmak065 #20150603 By geza add   
   DISPLAY BY NAME g_mmak_m.mmak066,g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak069     #add by yangxf 
   DISPLAY BY NAME g_mmak_m.mmak070 #add by geza 20150818
   DISPLAY BY NAME g_mmak_m.mmak071  #160604-00009#105
   DISPLAY BY NAME g_mmak_m.mmak072,g_mmak_m.mmak073  #160819-00054#26
   INITIALIZE l_mmanl.* TO NULL
   
   SELECT mmanl003,mmanl004 INTO l_mmanl.* FROM mmanl_t
    WHERE mmanl001 = g_mmak_m.mmak001
      AND mmanl002 = g_dlang
      AND mmanlent = g_enterprise
   
   LET  g_mmak_m.mmakl002 = l_mmanl.mmanl003
   LET  g_mmak_m.mmakl003 = l_mmanl.mmanl004
   
   DISPLAY BY NAME g_mmak_m.mmakl002,g_mmak_m.mmakl003      
   
   CALL ammt320_mmaksite_ref()
   CALL ammt320_mmak004_ref() 
   CALL ammt320_mmak012_ref()
   CALL ammt320_mmak053_ref()
   CALL ammt320_mmak054_ref() 
   
   #20140220 By ming add -----------------(S)  
   CALL ammt320_mmak057_ref() 
   CALL ammt320_mmak058_ref() 
   #20140220 By ming add -----------------(E) 
END FUNCTION
#+
PUBLIC FUNCTION ammt320_mmak004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmak_m.mmak004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmak_m.mmak004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmak_m.mmak004_desc
END FUNCTION
#+
PUBLIC FUNCTION ammt320_chk_mmak004()
   DEFINE l_stus    LIKE type_t.chr1

   LET g_errno = ''
   LET l_stus = ''
   SELECT ooeastus INTO l_stus FROM ooea_t
    WHERE ooeaent = g_enterprise
      AND ooea001 = g_mmak_m.mmak004
      AND ooea004 = 'Y'
   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00016'
        WHEN l_stus='N'            LET g_errno = 'aoo-00012'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
#+
PUBLIC FUNCTION ammt320_mmak012_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmak_m.mmak012
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmak_m.mmak012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmak_m.mmak012_desc
END FUNCTION
#+
PUBLIC FUNCTION ammt320_chk_product(p_product)
   DEFINE p_product LIKE imaa_t.imaa001
   DEFINE l_stus    LIKE type_t.chr1
   
   LET g_errno = ''
   LET l_stus = ''
   SELECT imaastus INTO l_stus FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_product
   CASE WHEN SQLCA.SQLCODE = 100   LET g_errno = 'art-00016'
        WHEN l_stus='X'            LET g_errno = 'art-00125'
        WHEN l_stus='N'            LET g_errno = 'art-00126'
        OTHERWISE                  LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
#+
PUBLIC FUNCTION ammt320_mmak054_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmak_m.mmak054
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmak_m.mmak054_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmak_m.mmak054_desc
END FUNCTION
#+
PUBLIC FUNCTION ammt320_mmak053_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmak_m.mmak053
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmak_m.mmak053_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmak_m.mmak053_desc
END FUNCTION
#+
PUBLIC FUNCTION ammt320_chk_mmak007()
   DEFINE l_mmak007    STRING
   
   LET g_errno = ''
   LET l_mmak007 = g_mmak_m.mmak007
   IF g_mmak_m.mmak006 != l_mmak007.getLength() THEN
      LET g_errno = 'amm-00104'
   END IF
END FUNCTION
#帶出 mmam_t(卡券生效申請檔營運據點設定申請檔)
#  與 mmal_t(卡效期延長規則申請檔)的資料
PUBLIC FUNCTION ammt320_carry_data()
   DEFINE l_sql    STRING
   
   LET g_errno = ''
   DELETE FROM mmal_t
    WHERE mmalent = g_enterprise
      AND mmaldocno = g_mmak_m.mmakdocno
   
   DELETE FROM mmam_t 
    WHERE mmament = g_enterprise
      AND mmamdocno = g_mmak_m.mmakdocno
      
   LET l_sql = " INSERT INTO mmal_t(mmalent,mmaldocno,mmal000,mmal001,mmal002,mmal003,mmal004,mmalacti) ",
               " SELECT mmaoent,'",g_mmak_m.mmakdocno,"','",g_mmak_m.mmak000,"',",
               "        mmao001,mmao002,mmao003,mmao004,mmaostus ",
               "   FROM mmao_t ",
               "  WHERE mmaoent = ? AND mmao001 = ? "
   PREPARE ins_mmal_pre FROM l_sql
   EXECUTE ins_mmal_pre USING g_enterprise,g_mmak_m.mmak001
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      RETURN
   END IF
  
   LET l_sql = " INSERT INTO mmam_t(mmament,mmamdocno,mmam000,mmam001,mmam002,mmam003,mmam004,",
               "                    mmam005,mmam006,mmam007,mmamacti) ",
               " SELECT mmapent,'",g_mmak_m.mmakdocno,"','",g_mmak_m.mmak000,"',",
               "       'ammt320',mmap002,mmap003,mmap004,",
               "        mmap005,mmap006,mmap007,mmapstus ",
               "   FROM mmap_t ",
               "  WHERE mmapent = ? AND mmap001 = 'ammm320' AND mmap002 = ? "
   PREPARE ins_mmam_pre FROM l_sql
   EXECUTE ins_mmam_pre USING g_enterprise,g_mmak_m.mmak001
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      RETURN
   END IF
END FUNCTION

PUBLIC FUNCTION ammt320_reset(p_cmd)
   DEFINE p_cmd     LIKE type_t.chr1
   
   
   IF p_cmd = '1' THEN
      #將相關欄位回到一開始初始化的狀態   
      LET g_mmak_m.mmak005 = ''
      LET g_mmak_m.mmak006 = ''
      LET g_mmak_m.mmak007 = ''
      LET g_mmak_m.mmak008 = ''
      LET g_mmak_m.mmak009 = ''
      LET g_mmak_m.mmak010 = ''
      LET g_mmak_m.mmak011 = ''
      LET g_mmak_m.mmak012 = '' 
      LET g_mmak_m.mmak013 = '' 
      LET g_mmak_m.mmak014 = '' 
      LET g_mmak_m.mmak015 = 'N' 
      LET g_mmak_m.mmak016 = 'N' 
      LET g_mmak_m.mmak017 = 'N' 
      LET g_mmak_m.mmak018 = 'N' 
      LET g_mmak_m.mmak019 = '' 
      LET g_mmak_m.mmak020 = '' 
      LET g_mmak_m.mmak021 = '' 
      LET g_mmak_m.mmak022 = '' 
      LET g_mmak_m.mmak023 = 'N' 
      LET g_mmak_m.mmak024 = '' 
      LET g_mmak_m.mmak025 = '' 
      LET g_mmak_m.mmak026 = 'N' 
      LET g_mmak_m.mmak053 = '' 
      LET g_mmak_m.mmak054 = '' 
      LET g_mmak_m.mmak027 = 'N' 
      LET g_mmak_m.mmak028 = ''
      LET g_mmak_m.mmak029 = ''
      LET g_mmak_m.mmak030 = ''
      LET g_mmak_m.mmak067 = ''    #add by yangxf
      LET g_mmak_m.mmak068 = ''    #add by yangxf 
      LET g_mmak_m.mmak069 = ''    #add by yangxf 
      LET g_mmak_m.mmak031 = ''
      LET g_mmak_m.mmak032 = ''
      LET g_mmak_m.mmak033 = ''
      LET g_mmak_m.mmak034 = ''
      LET g_mmak_m.mmak035 = ''
      LET g_mmak_m.mmak036 = ''
      LET g_mmak_m.mmak037 = ''
      LET g_mmak_m.mmak038 = 'N'
      LET g_mmak_m.mmak039 = ''
      LET g_mmak_m.mmak040 = ''
      LET g_mmak_m.mmak041 = ''
      LET g_mmak_m.mmak042 = 'N'
      LET g_mmak_m.mmak043 = 'N'
      LET g_mmak_m.mmak044 = ''
      LET g_mmak_m.mmak045 = ''
      LET g_mmak_m.mmak046 = ''
      LET g_mmak_m.mmak047 = 'N'
      LET g_mmak_m.mmak048 = ''
      LET g_mmak_m.mmak049 = 'N'
      LET g_mmak_m.mmak050 = ''
      LET g_mmak_m.mmak051 = ''
      LET g_mmak_m.mmak052 = ''
      LET g_mmak_m.mmak055 = ''
      LET g_mmak_m.mmak056 = ''
      #20140220 By ming add -----------------(S) 
      LET g_mmak_m.mmak057 = '' 
      LET g_mmak_m.mmak058 = '' 
      #20140220 By ming add -----------------(E) 
      #20150514 By geza add -----------------(S) 
      LET g_mmak_m.mmak062 = 'N'
      LET g_mmak_m.mmak063 = ''     
      LET g_mmak_m.mmak064 = ''       
      #20150514 By geza add -----------------(E)
      LET g_mmak_m.mmak065 = 'N'  #20150603 By geza add  
      LET g_mmak_m.mmak069 = ''
      LET g_mmak_m.mmak070 = 'N'  #add by geza 20150818
      LET g_mmak_m.mmak071 = ''  #160604-00009#105
      #160726-00023#1 -s by 08172
      LET g_mmak_m.mmak059 = ''
      LET g_mmak_m.mmak060 = ''
      LET g_mmak_m.mmak061 = ''
      #160726-00023#1 -e by 08172      
   ELSE 
      #將相關欄位回到舊值(g_mmak_m_t.)
      LET g_mmak_m.mmak005 = g_mmak_m_t.mmak005
      LET g_mmak_m.mmak006 = g_mmak_m_t.mmak006
      LET g_mmak_m.mmak007 = g_mmak_m_t.mmak007
      LET g_mmak_m.mmak008 = g_mmak_m_t.mmak008
      LET g_mmak_m.mmak009 = g_mmak_m_t.mmak009
      LET g_mmak_m.mmak010 = g_mmak_m_t.mmak010
      LET g_mmak_m.mmak011 = g_mmak_m_t.mmak011
      LET g_mmak_m.mmak012 = g_mmak_m_t.mmak012
      LET g_mmak_m.mmak013 = g_mmak_m_t.mmak013 
      LET g_mmak_m.mmak014 = g_mmak_m_t.mmak014 
      LET g_mmak_m.mmak015 = g_mmak_m_t.mmak015 
      LET g_mmak_m.mmak016 = g_mmak_m_t.mmak016 
      LET g_mmak_m.mmak017 = g_mmak_m_t.mmak017 
      LET g_mmak_m.mmak018 = g_mmak_m_t.mmak018 
      LET g_mmak_m.mmak019 = g_mmak_m_t.mmak019
      LET g_mmak_m.mmak020 = g_mmak_m_t.mmak020
      LET g_mmak_m.mmak021 = g_mmak_m_t.mmak021
      LET g_mmak_m.mmak022 = g_mmak_m_t.mmak022
      LET g_mmak_m.mmak023 = g_mmak_m_t.mmak023 
      LET g_mmak_m.mmak024 = g_mmak_m_t.mmak024
      LET g_mmak_m.mmak025 = g_mmak_m_t.mmak025
      LET g_mmak_m.mmak026 = g_mmak_m_t.mmak026 
      LET g_mmak_m.mmak053 = g_mmak_m_t.mmak053
      LET g_mmak_m.mmak054 = g_mmak_m_t.mmak054
      LET g_mmak_m.mmak027 = g_mmak_m_t.mmak027 
      LET g_mmak_m.mmak028 = g_mmak_m_t.mmak028
      LET g_mmak_m.mmak029 = g_mmak_m_t.mmak029
      LET g_mmak_m.mmak030 = g_mmak_m_t.mmak030
      LET g_mmak_m.mmak067 = g_mmak_m_t.mmak067    #add by yangxf 
      LET g_mmak_m.mmak068 = g_mmak_m_t.mmak068    #add by yangxf
      LET g_mmak_m.mmak069 = g_mmak_m_t.mmak069    #add by yangxf
      LET g_mmak_m.mmak031 = g_mmak_m_t.mmak031
      LET g_mmak_m.mmak032 = g_mmak_m_t.mmak032
      LET g_mmak_m.mmak033 = g_mmak_m_t.mmak033
      LET g_mmak_m.mmak034 = g_mmak_m_t.mmak034
      LET g_mmak_m.mmak035 = g_mmak_m_t.mmak035
      LET g_mmak_m.mmak036 = g_mmak_m_t.mmak036
      LET g_mmak_m.mmak037 = g_mmak_m_t.mmak037
      LET g_mmak_m.mmak038 = g_mmak_m_t.mmak038
      LET g_mmak_m.mmak039 = g_mmak_m_t.mmak039
      LET g_mmak_m.mmak040 = g_mmak_m_t.mmak040
      LET g_mmak_m.mmak041 = g_mmak_m_t.mmak041
      LET g_mmak_m.mmak042 = g_mmak_m_t.mmak042
      LET g_mmak_m.mmak043 = g_mmak_m_t.mmak043
      LET g_mmak_m.mmak044 = g_mmak_m_t.mmak044
      LET g_mmak_m.mmak045 = g_mmak_m_t.mmak045
      LET g_mmak_m.mmak046 = g_mmak_m_t.mmak046
      LET g_mmak_m.mmak047 = g_mmak_m_t.mmak047
      LET g_mmak_m.mmak048 = g_mmak_m_t.mmak048
      LET g_mmak_m.mmak049 = g_mmak_m_t.mmak049
      LET g_mmak_m.mmak050 = g_mmak_m_t.mmak050
      LET g_mmak_m.mmak051 = g_mmak_m_t.mmak051
      LET g_mmak_m.mmak052 = g_mmak_m_t.mmak052
      LET g_mmak_m.mmak055 = g_mmak_m_t.mmak055
      LET g_mmak_m.mmak056 = g_mmak_m_t.mmak056
      #20140220 By ming add -----------------(S) 
      LET g_mmak_m.mmak057 = g_mmak_m_t.mmak057 
      LET g_mmak_m.mmak058 = g_mmak_m_t.mmak058 
      #20140220 By ming add -----------------(E)
      #20150514 By geza add -----------------(S) 
      LET g_mmak_m.mmak062 = g_mmak_m_t.mmak062
      LET g_mmak_m.mmak063 = g_mmak_m_t.mmak063
      LET g_mmak_m.mmak064 = g_mmak_m_t.mmak064
      #20150514 By geza add -----------------(E)
      LET g_mmak_m.mmak065 = g_mmak_m_t.mmak065   #20150603 By geza add 
      LET g_mmak_m.mmak070 = g_mmak_m_t.mmak070   #add by geza 20150818
      LET g_mmak_m.mmak071 = g_mmak_m_t.mmak071   #160604-00009#105 
      #160726-00023#1 -s by 08172
      LET g_mmak_m.mmak059 = g_mmak_m_t.mmak059
      LET g_mmak_m.mmak060 = g_mmak_m_t.mmak060
      LET g_mmak_m.mmak061 = g_mmak_m_t.mmak061
      #160726-00023#1 -e by 08172       
   END IF
   
   DISPLAY BY NAME g_mmak_m.mmak005, g_mmak_m.mmak006, g_mmak_m.mmak007, g_mmak_m.mmak009,
                   g_mmak_m.mmak010, g_mmak_m.mmak011, g_mmak_m.mmak012, g_mmak_m.mmak013, 
                   g_mmak_m.mmak014, g_mmak_m.mmak015, g_mmak_m.mmak016, g_mmak_m.mmak017, 
                   g_mmak_m.mmak018, g_mmak_m.mmak019, g_mmak_m.mmak020, g_mmak_m.mmak021,
                   g_mmak_m.mmak022, g_mmak_m.mmak023, g_mmak_m.mmak024, g_mmak_m.mmak025,
                   g_mmak_m.mmak026, g_mmak_m.mmak053, g_mmak_m.mmak054, g_mmak_m.mmak027, 
                   g_mmak_m.mmak028, g_mmak_m.mmak029, g_mmak_m.mmak030, g_mmak_m.mmak031,
                   g_mmak_m.mmak032, g_mmak_m.mmak033, g_mmak_m.mmak034, g_mmak_m.mmak035,
                   g_mmak_m.mmak036, g_mmak_m.mmak037, g_mmak_m.mmak038, g_mmak_m.mmak039,
                   g_mmak_m.mmak040, g_mmak_m.mmak041, g_mmak_m.mmak042, g_mmak_m.mmak043,
                   g_mmak_m.mmak044, g_mmak_m.mmak045, g_mmak_m.mmak046, g_mmak_m.mmak047,
                   g_mmak_m.mmak048, g_mmak_m.mmak049, g_mmak_m.mmak050, g_mmak_m.mmak051,
                   g_mmak_m.mmak052, g_mmak_m.mmak055, g_mmak_m.mmak056
                   
   DISPLAY BY NAME g_mmak_m.mmak057, g_mmak_m.mmak058 #20140220 By ming add 
   DISPLAY BY NAME g_mmak_m.mmak062,g_mmak_m.mmak063,g_mmak_m.mmak064  #20150514 By geza add
   DISPLAY BY NAME g_mmak_m.mmak065 #20150603 By geza add
   DISPLAY BY NAME g_mmak_m.mmak067,g_mmak_m.mmak068,g_mmak_m.mmak069     #add by yangxf 
   DISPLAY BY NAME g_mmak_m.mmak070 #add by geza 20150818
   DISPLAY BY NAME g_mmak_m.mmak071 #160604-00009#105   
   CALL ammt320_mmak012_ref()
   CALL ammt320_mmak053_ref()
   CALL ammt320_mmak054_ref()
   
   #20140220 By ming add -----------------(S) 
   CALL ammt320_mmak057_ref() 
   CALL ammt320_mmak058_ref() 
   #20140220 By ming add -----------------(E) 
END FUNCTION

PUBLIC FUNCTION ammt320_chk_mmak034_35()
   LET g_errno = ''
   
   CASE 
      WHEN g_mmak_m.mmak034 = 1 OR g_mmak_m.mmak034 = 3 OR g_mmak_m.mmak034 = 5 OR g_mmak_m.mmak034 = 7 OR
           g_mmak_m.mmak034 = 8 OR g_mmak_m.mmak034 = 10 OR g_mmak_m.mmak034 = 12
         IF NOT cl_ap_chk_Range(g_mmak_m.mmak035,"1.000","1","31.000","1","azz-00087",1) THEN
            LET g_errno = 'azz-00087'
         END IF
      WHEN g_mmak_m.mmak034 = 4 OR g_mmak_m.mmak034 = 6 OR g_mmak_m.mmak034 =9  OR g_mmak_m.mmak034 = 11
         IF NOT cl_ap_chk_Range(g_mmak_m.mmak035,"1.000","1","30.000","1","azz-00087",1) THEN
            LET g_errno = 'azz-00087'
         END IF
      WHEN g_mmak_m.mmak034 = 2
         IF NOT cl_ap_chk_Range(g_mmak_m.mmak035,"1.000","1","29.000","1","azz-00087",1) THEN
            LET g_errno = 'azz-00087'
         END IF              
   END CASE
END FUNCTION

PUBLIC FUNCTION ammt320_set_required(p_cmd)
   DEFINE p_cmd     LIKE type_t.chr1
   
   IF g_mmak_m.mmak042 = 'Y' THEN
      CALL cl_set_comp_required("mmak054",TRUE)
   END IF
   #160302-00028#1 mark by yangxf 20160302 (s)
   #150629-00020#1 150629 by lori add---(S)
   #IF g_mmak_m.mmak015 = 'Y' THEN
   #   CALL cl_set_comp_required("mmak069",TRUE)
   #END IF
   #150629-00020#1 150629 by lori add---(S)
   #160302-00028#1 mark by yangxf 20160302 (s)
   #20151028--dongsz add--str---
   IF g_mmak_m.mmak038 = 'Y' THEN
      CALL cl_set_comp_required("mmak057",TRUE)
   END IF
   IF g_mmak_m.mmak042 = 'Y' THEN
      CALL cl_set_comp_required("mmak058",TRUE)
   END IF
   #20151028--dongsz add--end--
END FUNCTION

PUBLIC FUNCTION ammt320_set_no_required(p_cmd)
   DEFINE p_cmd     LIKE type_t.chr1
   
   CALL cl_set_comp_required("mmak054",FALSE)
   #CALL cl_set_comp_required("mmak069",FALSE)   #150629-00020#1 150629 by lori add #160302-00028#1 mark by yangxf 20160302 (s)
   CALL cl_set_comp_required("mmak057",FALSE)   #20151028 dongsz add
   CALL cl_set_comp_required("mmak058",FALSE)   #20151028 dongsz add
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt320_mmak057_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt320_mmak057_ref()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_mmak_m.mmak057 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") 
        RETURNING g_rtn_fields 
   LET g_mmak_m.mmak057_desc = '', g_rtn_fields[1], '' 
   DISPLAY BY NAME g_mmak_m.mmak057_desc 
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt320_mmak058_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/20 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt320_mmak058_ref()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_mmak_m.mmak058 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") 
        RETURNING g_rtn_fields 
   LET g_mmak_m.mmak058_desc = '', g_rtn_fields[1], '' 
   DISPLAY BY NAME g_mmak_m.mmak058_desc 
END FUNCTION

################################################################################
# display mmaksite
################################################################################
PRIVATE FUNCTION ammt320_mmaksite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmak_m.mmaksite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmak_m.mmaksite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmak_m.mmaksite_desc
END FUNCTION

 
{</section>}
 
