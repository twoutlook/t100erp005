#該程式未解開Section, 採用最新樣板產出!
{<section id="aist403.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-12-23 17:32:25), PR版次:0007(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: aist403
#+ Description: 403銷售額與稅額申報書維護作業
#+ Creator....: 05016(2015-04-20 15:03:07)
#+ Modifier...: 05599 -SD/PR- 00000
 
{</section>}
 
{<section id="aist403.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#150401-00001#13  15/07/21 By RayHuang   statechange段問題修正
#151125-00001#3   15/11/27 By Charles4m  增加詢問是否作廢。
#150915-00009#11  15/12/23 By Reanna     1.增加iscb109調整稅額顯示 2.部份欄位加上電子發票字眼
#160818-00017#19  16-08-22 By 08742      删除修改未重新判断状态码
#161006-00005#16  16/10/17 By 08732      組織類型與職能開窗調整
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
PRIVATE TYPE type_g_iscb_m RECORD
       iscbsite LIKE iscb_t.iscbsite, 
   iscbsite_desc LIKE type_t.chr80, 
   iscbcomp LIKE iscb_t.iscbcomp, 
   iscbcomp_desc LIKE type_t.chr80, 
   iscb200 LIKE iscb_t.iscb200, 
   iscb201 LIKE iscb_t.iscb201, 
   iscb202 LIKE iscb_t.iscb202, 
   iscb050 LIKE iscb_t.iscb050, 
   iscbstus LIKE iscb_t.iscbstus, 
   iscb001 LIKE iscb_t.iscb001, 
   iscb005 LIKE iscb_t.iscb005, 
   iscb009 LIKE iscb_t.iscb009, 
   iscb013 LIKE iscb_t.iscb013, 
   iscb017 LIKE iscb_t.iscb017, 
   iscb021 LIKE iscb_t.iscb021, 
   iscb025 LIKE iscb_t.iscb025, 
   iscb027 LIKE iscb_t.iscb027, 
   iscb002 LIKE iscb_t.iscb002, 
   iscb006 LIKE iscb_t.iscb006, 
   iscb010 LIKE iscb_t.iscb010, 
   iscb014 LIKE iscb_t.iscb014, 
   iscb018 LIKE iscb_t.iscb018, 
   iscb022 LIKE iscb_t.iscb022, 
   iscb004 LIKE iscb_t.iscb004, 
   iscb008 LIKE iscb_t.iscb008, 
   iscb012 LIKE iscb_t.iscb012, 
   iscb016 LIKE iscb_t.iscb016, 
   iscb020 LIKE iscb_t.iscb020, 
   iscb024 LIKE iscb_t.iscb024, 
   iscb007 LIKE iscb_t.iscb007, 
   iscb015 LIKE iscb_t.iscb015, 
   iscb019 LIKE iscb_t.iscb019, 
   iscb023 LIKE iscb_t.iscb023, 
   iscb082 LIKE iscb_t.iscb082, 
   iscb101 LIKE iscb_t.iscb101, 
   iscb103 LIKE iscb_t.iscb103, 
   iscb104 LIKE iscb_t.iscb104, 
   iscb105 LIKE iscb_t.iscb105, 
   iscb106 LIKE iscb_t.iscb106, 
   iscb107 LIKE iscb_t.iscb107, 
   iscb108 LIKE iscb_t.iscb108, 
   iscb109 LIKE iscb_t.iscb109, 
   iscb110 LIKE iscb_t.iscb110, 
   iscb111 LIKE iscb_t.iscb111, 
   iscb112 LIKE iscb_t.iscb112, 
   iscb113 LIKE iscb_t.iscb113, 
   iscb114 LIKE iscb_t.iscb114, 
   iscb115 LIKE iscb_t.iscb115, 
   iscb052 LIKE iscb_t.iscb052, 
   iscb053 LIKE iscb_t.iscb053, 
   iscb054 LIKE iscb_t.iscb054, 
   iscb055 LIKE iscb_t.iscb055, 
   iscb056 LIKE iscb_t.iscb056, 
   iscb057 LIKE iscb_t.iscb057, 
   iscb060 LIKE iscb_t.iscb060, 
   iscb061 LIKE iscb_t.iscb061, 
   iscb062 LIKE iscb_t.iscb062, 
   iscb063 LIKE iscb_t.iscb063, 
   iscb064 LIKE iscb_t.iscb064, 
   iscb065 LIKE iscb_t.iscb065, 
   iscb066 LIKE iscb_t.iscb066, 
   iscb028 LIKE iscb_t.iscb028, 
   iscb029 LIKE iscb_t.iscb029, 
   iscb051 LIKE iscb_t.iscb051, 
   iscb030 LIKE iscb_t.iscb030, 
   iscb031 LIKE iscb_t.iscb031, 
   iscb073 LIKE iscb_t.iscb073, 
   iscb032 LIKE iscb_t.iscb032, 
   iscb033 LIKE iscb_t.iscb033, 
   iscb074 LIKE iscb_t.iscb074, 
   iscb034 LIKE iscb_t.iscb034, 
   iscb035 LIKE iscb_t.iscb035, 
   iscb075 LIKE iscb_t.iscb075, 
   iscb036 LIKE iscb_t.iscb036, 
   iscb037 LIKE iscb_t.iscb037, 
   iscb076 LIKE iscb_t.iscb076, 
   iscb038 LIKE iscb_t.iscb038, 
   iscb039 LIKE iscb_t.iscb039, 
   iscb078 LIKE iscb_t.iscb078, 
   iscb079 LIKE iscb_t.iscb079, 
   iscb080 LIKE iscb_t.iscb080, 
   iscb081 LIKE iscb_t.iscb081, 
   iscb040 LIKE iscb_t.iscb040, 
   iscb041 LIKE iscb_t.iscb041, 
   iscb042 LIKE iscb_t.iscb042, 
   iscb043 LIKE iscb_t.iscb043, 
   iscb044 LIKE iscb_t.iscb044, 
   iscb045 LIKE iscb_t.iscb045, 
   iscb046 LIKE iscb_t.iscb046, 
   iscb047 LIKE iscb_t.iscb047, 
   iscb048 LIKE iscb_t.iscb048, 
   iscb049 LIKE iscb_t.iscb049, 
   iscbownid LIKE iscb_t.iscbownid, 
   iscbownid_desc LIKE type_t.chr80, 
   iscbowndp LIKE iscb_t.iscbowndp, 
   iscbowndp_desc LIKE type_t.chr80, 
   iscbcrtid LIKE iscb_t.iscbcrtid, 
   iscbcrtid_desc LIKE type_t.chr80, 
   iscbcrtdp LIKE iscb_t.iscbcrtdp, 
   iscbcrtdp_desc LIKE type_t.chr80, 
   iscbcrtdt LIKE iscb_t.iscbcrtdt, 
   iscbmodid LIKE iscb_t.iscbmodid, 
   iscbmodid_desc LIKE type_t.chr80, 
   iscbmoddt LIKE iscb_t.iscbmoddt, 
   iscbcnfid LIKE iscb_t.iscbcnfid, 
   iscbcnfid_desc LIKE type_t.chr80, 
   iscbcnfdt LIKE iscb_t.iscbcnfdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_iscbsite LIKE iscb_t.iscbsite,
      b_iscbcomp LIKE iscb_t.iscbcomp,
      b_iscb200 LIKE iscb_t.iscb200,
      b_iscb201 LIKE iscb_t.iscb201
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_isca_m RECORD
       isca701 LIKE isca_t.isca701, 
       isca702 LIKE isca_t.isca702, 
       isca703 LIKE isca_t.isca703, 
       isca704 LIKE isca_t.isca704, 
       isca705 LIKE isca_t.isca705, 
       isca706 LIKE isca_t.isca706, 
       isca707 LIKE isca_t.isca707, 
       isca708 LIKE isca_t.isca708, 
       isca805 LIKE isca_t.isca805, 
       isca806 LIKE isca_t.isca806, 
       isca807 LIKE isca_t.isca807, 
       isca801 LIKE isca_t.isca801, 
       isca803 LIKE isca_t.isca803, 
       isca802 LIKE isca_t.isca802, 
       isca804 LIKE isca_t.isca804
   END　RECORD 

DEFINE g_isca_m      type_g_isca_m
DEFINE g_isca_m_t    type_g_isca_m  
DEFINE g_isca_m_o    type_g_isca_m
  
DEFINE g_wc_comp         STRING   #161006-00005#16  add

#end add-point
 
#模組變數(Module Variables)
DEFINE g_iscb_m        type_g_iscb_m  #單頭變數宣告
DEFINE g_iscb_m_t      type_g_iscb_m  #單頭舊值宣告(系統還原用)
DEFINE g_iscb_m_o      type_g_iscb_m  #單頭舊值宣告(其他用途)
DEFINE g_iscb_m_mask_o type_g_iscb_m  #轉換遮罩前資料
DEFINE g_iscb_m_mask_n type_g_iscb_m  #轉換遮罩後資料
 
   DEFINE g_iscbsite_t LIKE iscb_t.iscbsite
DEFINE g_iscbcomp_t LIKE iscb_t.iscbcomp
DEFINE g_iscb200_t LIKE iscb_t.iscb200
DEFINE g_iscb201_t LIKE iscb_t.iscb201
 
   
 
   
 
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
 
{<section id="aist403.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT iscbsite,'',iscbcomp,'',iscb200,iscb201,iscb202,iscb050,iscbstus,iscb001, 
       iscb005,iscb009,iscb013,iscb017,iscb021,iscb025,iscb027,iscb002,iscb006,iscb010,iscb014,iscb018, 
       iscb022,iscb004,iscb008,iscb012,iscb016,iscb020,iscb024,iscb007,iscb015,iscb019,iscb023,iscb082, 
       iscb101,iscb103,iscb104,iscb105,iscb106,iscb107,iscb108,iscb109,iscb110,iscb111,iscb112,iscb113, 
       iscb114,iscb115,iscb052,iscb053,iscb054,iscb055,iscb056,iscb057,iscb060,iscb061,iscb062,iscb063, 
       iscb064,iscb065,iscb066,iscb028,iscb029,iscb051,iscb030,iscb031,iscb073,iscb032,iscb033,iscb074, 
       iscb034,iscb035,iscb075,iscb036,iscb037,iscb076,iscb038,iscb039,iscb078,iscb079,iscb080,iscb081, 
       iscb040,iscb041,iscb042,iscb043,iscb044,iscb045,iscb046,iscb047,iscb048,iscb049,iscbownid,'', 
       iscbowndp,'',iscbcrtid,'',iscbcrtdp,'',iscbcrtdt,iscbmodid,'',iscbmoddt,iscbcnfid,'',iscbcnfdt", 
        
                      " FROM iscb_t",
                      " WHERE iscbent= ? AND iscbcomp=? AND iscbsite=? AND iscb200=? AND iscb201=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aist403_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.iscbsite,t0.iscbcomp,t0.iscb200,t0.iscb201,t0.iscb202,t0.iscb050, 
       t0.iscbstus,t0.iscb001,t0.iscb005,t0.iscb009,t0.iscb013,t0.iscb017,t0.iscb021,t0.iscb025,t0.iscb027, 
       t0.iscb002,t0.iscb006,t0.iscb010,t0.iscb014,t0.iscb018,t0.iscb022,t0.iscb004,t0.iscb008,t0.iscb012, 
       t0.iscb016,t0.iscb020,t0.iscb024,t0.iscb007,t0.iscb015,t0.iscb019,t0.iscb023,t0.iscb082,t0.iscb101, 
       t0.iscb103,t0.iscb104,t0.iscb105,t0.iscb106,t0.iscb107,t0.iscb108,t0.iscb109,t0.iscb110,t0.iscb111, 
       t0.iscb112,t0.iscb113,t0.iscb114,t0.iscb115,t0.iscb052,t0.iscb053,t0.iscb054,t0.iscb055,t0.iscb056, 
       t0.iscb057,t0.iscb060,t0.iscb061,t0.iscb062,t0.iscb063,t0.iscb064,t0.iscb065,t0.iscb066,t0.iscb028, 
       t0.iscb029,t0.iscb051,t0.iscb030,t0.iscb031,t0.iscb073,t0.iscb032,t0.iscb033,t0.iscb074,t0.iscb034, 
       t0.iscb035,t0.iscb075,t0.iscb036,t0.iscb037,t0.iscb076,t0.iscb038,t0.iscb039,t0.iscb078,t0.iscb079, 
       t0.iscb080,t0.iscb081,t0.iscb040,t0.iscb041,t0.iscb042,t0.iscb043,t0.iscb044,t0.iscb045,t0.iscb046, 
       t0.iscb047,t0.iscb048,t0.iscb049,t0.iscbownid,t0.iscbowndp,t0.iscbcrtid,t0.iscbcrtdp,t0.iscbcrtdt, 
       t0.iscbmodid,t0.iscbmoddt,t0.iscbcnfid,t0.iscbcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooag011",
               " FROM iscb_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.iscbownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.iscbowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.iscbcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.iscbcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.iscbmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.iscbcnfid  ",
 
               " WHERE t0.iscbent = " ||g_enterprise|| " AND t0.iscbcomp = ? AND t0.iscbsite = ? AND t0.iscb200 = ? AND t0.iscb201 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aist403_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aist403 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aist403_init()   
 
      #進入選單 Menu (="N")
      CALL aist403_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aist403
      
   END IF 
   
   CLOSE aist403_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aist403.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aist403_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('iscbstus','13','Y,N,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   #161006-00005#16   add-s
   CALL s_fin_create_account_center_tmp() 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_comp
   CALL s_fin_get_wc_str(g_wc_comp) RETURNING g_wc_comp
   #161006-00005#16   add-e
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aist403_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aist403.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aist403_ui_dialog() 
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
         INITIALIZE g_iscb_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aist403_init()
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
               CALL aist403_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aist403_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aist403_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aist403_set_act_visible()
               CALL aist403_set_act_no_visible()
               IF NOT (g_iscb_m.iscbcomp IS NULL
                 OR g_iscb_m.iscbsite IS NULL
                 OR g_iscb_m.iscb200 IS NULL
                 OR g_iscb_m.iscb201 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " iscbent = " ||g_enterprise|| " AND",
                                     " iscbcomp = '", g_iscb_m.iscbcomp, "' "
                                     ," AND iscbsite = '", g_iscb_m.iscbsite, "' "
                                     ," AND iscb200 = '", g_iscb_m.iscb200, "' "
                                     ," AND iscb201 = '", g_iscb_m.iscb201, "' "
 
                  #填到對應位置
                  CALL aist403_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aist403_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aist403_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aist403_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aist403_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aist403_fetch("L")  
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
                  CALL aist403_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aist403_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aist403_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aist403_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               
               #END add-point
               &include "erp/ais/aist403_rep.4gl"
               #add-point:ON ACTION output.after name="menu2.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               &include "erp/ais/aist403_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu2.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aist403_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aist403_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aist403_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aist403_set_pk_array()
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
                  CALL aist403_fetch("")
 
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
                  CALL aist403_browser_fill(g_wc,"")
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
                  CALL aist403_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aist403_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aist403_set_act_visible()
               CALL aist403_set_act_no_visible()
               IF NOT (g_iscb_m.iscbcomp IS NULL
                 OR g_iscb_m.iscbsite IS NULL
                 OR g_iscb_m.iscb200 IS NULL
                 OR g_iscb_m.iscb201 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " iscbent = " ||g_enterprise|| " AND",
                                     " iscbcomp = '", g_iscb_m.iscbcomp, "' "
                                     ," AND iscbsite = '", g_iscb_m.iscbsite, "' "
                                     ," AND iscb200 = '", g_iscb_m.iscb200, "' "
                                     ," AND iscb201 = '", g_iscb_m.iscb201, "' "
 
                  #填到對應位置
                  CALL aist403_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aist403_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aist403_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aist403_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aist403_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aist403_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aist403_fetch("L")  
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
                  CALL aist403_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aist403_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aist403_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aist403_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ais/aist403_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ais/aist403_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aist403_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aist403_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aist403_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aist403_set_pk_array()
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
 
{<section id="aist403.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aist403_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "iscbcomp,iscbsite,iscb200,iscb201"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM iscb_t ",
               "  ",
               "  ",
               " WHERE iscbent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("iscb_t")
                
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
      INITIALIZE g_iscb_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.iscbstus,t0.iscbsite,t0.iscbcomp,t0.iscb200,t0.iscb201",
               " FROM iscb_t t0 ",
               "  ",
               
               " WHERE t0.iscbent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("iscb_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"iscb_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_iscbsite,g_browser[g_cnt].b_iscbcomp, 
          g_browser[g_cnt].b_iscb200,g_browser[g_cnt].b_iscb201
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
         
         #遮罩相關處理
         CALL aist403_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_iscbcomp) THEN
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
   CALL aist403_set_act_visible()
   CALL aist403_set_act_no_visible()
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aist403.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aist403_construct()
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
   INITIALIZE g_iscb_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON iscbsite,iscbcomp,iscb200,iscb201,iscb202,iscb050,iscbstus,iscb082,iscb101, 
          iscb108,iscb052,iscb053,iscb054,iscb055,iscb056,iscb057,iscb060,iscb061,iscb062,iscb063,iscb064, 
          iscb065,iscb066,iscb073,iscbownid,iscbowndp,iscbcrtid,iscbcrtdp,iscbcrtdt,iscbmodid,iscbmoddt, 
          iscbcnfid,iscbcnfdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<iscbcrtdt>>----
         AFTER FIELD iscbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<iscbmoddt>>----
         AFTER FIELD iscbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<iscbcnfdt>>----
         AFTER FIELD iscbcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<iscbpstdt>>----
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbsite
            #add-point:BEFORE FIELD iscbsite name="construct.b.iscbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbsite
            
            #add-point:AFTER FIELD iscbsite name="construct.a.iscbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbsite
            #add-point:ON ACTION controlp INFIELD iscbsite name="construct.c.iscbsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_isaa001()
            DISPLAY g_qryparam.return1 TO iscbsite
            NEXT FIELD iscbsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbcomp
            #add-point:BEFORE FIELD iscbcomp name="construct.b.iscbcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbcomp
            
            #add-point:AFTER FIELD iscbcomp name="construct.a.iscbcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscbcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbcomp
            #add-point:ON ACTION controlp INFIELD iscbcomp name="construct.c.iscbcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' ",
                                   " AND ooef001 IN ",g_wc_comp   #161006-00005#16   add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO iscbcomp
            NEXT FIELD iscbcomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb200
            #add-point:BEFORE FIELD iscb200 name="construct.b.iscb200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb200
            
            #add-point:AFTER FIELD iscb200 name="construct.a.iscb200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb200
            #add-point:ON ACTION controlp INFIELD iscb200 name="construct.c.iscb200"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb201
            #add-point:BEFORE FIELD iscb201 name="construct.b.iscb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb201
            
            #add-point:AFTER FIELD iscb201 name="construct.a.iscb201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb201
            #add-point:ON ACTION controlp INFIELD iscb201 name="construct.c.iscb201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb202
            #add-point:BEFORE FIELD iscb202 name="construct.b.iscb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb202
            
            #add-point:AFTER FIELD iscb202 name="construct.a.iscb202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb202
            #add-point:ON ACTION controlp INFIELD iscb202 name="construct.c.iscb202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb050
            #add-point:BEFORE FIELD iscb050 name="construct.b.iscb050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb050
            
            #add-point:AFTER FIELD iscb050 name="construct.a.iscb050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb050
            #add-point:ON ACTION controlp INFIELD iscb050 name="construct.c.iscb050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbstus
            #add-point:BEFORE FIELD iscbstus name="construct.b.iscbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbstus
            
            #add-point:AFTER FIELD iscbstus name="construct.a.iscbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbstus
            #add-point:ON ACTION controlp INFIELD iscbstus name="construct.c.iscbstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb082
            #add-point:BEFORE FIELD iscb082 name="construct.b.iscb082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb082
            
            #add-point:AFTER FIELD iscb082 name="construct.a.iscb082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb082
            #add-point:ON ACTION controlp INFIELD iscb082 name="construct.c.iscb082"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb101
            #add-point:BEFORE FIELD iscb101 name="construct.b.iscb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb101
            
            #add-point:AFTER FIELD iscb101 name="construct.a.iscb101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb101
            #add-point:ON ACTION controlp INFIELD iscb101 name="construct.c.iscb101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb108
            #add-point:BEFORE FIELD iscb108 name="construct.b.iscb108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb108
            
            #add-point:AFTER FIELD iscb108 name="construct.a.iscb108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb108
            #add-point:ON ACTION controlp INFIELD iscb108 name="construct.c.iscb108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb052
            #add-point:BEFORE FIELD iscb052 name="construct.b.iscb052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb052
            
            #add-point:AFTER FIELD iscb052 name="construct.a.iscb052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb052
            #add-point:ON ACTION controlp INFIELD iscb052 name="construct.c.iscb052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb053
            #add-point:BEFORE FIELD iscb053 name="construct.b.iscb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb053
            
            #add-point:AFTER FIELD iscb053 name="construct.a.iscb053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb053
            #add-point:ON ACTION controlp INFIELD iscb053 name="construct.c.iscb053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb054
            #add-point:BEFORE FIELD iscb054 name="construct.b.iscb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb054
            
            #add-point:AFTER FIELD iscb054 name="construct.a.iscb054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb054
            #add-point:ON ACTION controlp INFIELD iscb054 name="construct.c.iscb054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb055
            #add-point:BEFORE FIELD iscb055 name="construct.b.iscb055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb055
            
            #add-point:AFTER FIELD iscb055 name="construct.a.iscb055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb055
            #add-point:ON ACTION controlp INFIELD iscb055 name="construct.c.iscb055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb056
            #add-point:BEFORE FIELD iscb056 name="construct.b.iscb056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb056
            
            #add-point:AFTER FIELD iscb056 name="construct.a.iscb056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb056
            #add-point:ON ACTION controlp INFIELD iscb056 name="construct.c.iscb056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb057
            #add-point:BEFORE FIELD iscb057 name="construct.b.iscb057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb057
            
            #add-point:AFTER FIELD iscb057 name="construct.a.iscb057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb057
            #add-point:ON ACTION controlp INFIELD iscb057 name="construct.c.iscb057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb060
            #add-point:BEFORE FIELD iscb060 name="construct.b.iscb060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb060
            
            #add-point:AFTER FIELD iscb060 name="construct.a.iscb060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb060
            #add-point:ON ACTION controlp INFIELD iscb060 name="construct.c.iscb060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb061
            #add-point:BEFORE FIELD iscb061 name="construct.b.iscb061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb061
            
            #add-point:AFTER FIELD iscb061 name="construct.a.iscb061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb061
            #add-point:ON ACTION controlp INFIELD iscb061 name="construct.c.iscb061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb062
            #add-point:BEFORE FIELD iscb062 name="construct.b.iscb062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb062
            
            #add-point:AFTER FIELD iscb062 name="construct.a.iscb062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb062
            #add-point:ON ACTION controlp INFIELD iscb062 name="construct.c.iscb062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb063
            #add-point:BEFORE FIELD iscb063 name="construct.b.iscb063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb063
            
            #add-point:AFTER FIELD iscb063 name="construct.a.iscb063"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb063
            #add-point:ON ACTION controlp INFIELD iscb063 name="construct.c.iscb063"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb064
            #add-point:BEFORE FIELD iscb064 name="construct.b.iscb064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb064
            
            #add-point:AFTER FIELD iscb064 name="construct.a.iscb064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb064
            #add-point:ON ACTION controlp INFIELD iscb064 name="construct.c.iscb064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb065
            #add-point:BEFORE FIELD iscb065 name="construct.b.iscb065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb065
            
            #add-point:AFTER FIELD iscb065 name="construct.a.iscb065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb065
            #add-point:ON ACTION controlp INFIELD iscb065 name="construct.c.iscb065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb066
            #add-point:BEFORE FIELD iscb066 name="construct.b.iscb066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb066
            
            #add-point:AFTER FIELD iscb066 name="construct.a.iscb066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb066
            #add-point:ON ACTION controlp INFIELD iscb066 name="construct.c.iscb066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb073
            #add-point:BEFORE FIELD iscb073 name="construct.b.iscb073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb073
            
            #add-point:AFTER FIELD iscb073 name="construct.a.iscb073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscb073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb073
            #add-point:ON ACTION controlp INFIELD iscb073 name="construct.c.iscb073"
            
            #END add-point
 
 
         #Ctrlp:construct.c.iscbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbownid
            #add-point:ON ACTION controlp INFIELD iscbownid name="construct.c.iscbownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO iscbownid  #顯示到畫面上
            NEXT FIELD iscbownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbownid
            #add-point:BEFORE FIELD iscbownid name="construct.b.iscbownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbownid
            
            #add-point:AFTER FIELD iscbownid name="construct.a.iscbownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbowndp
            #add-point:ON ACTION controlp INFIELD iscbowndp name="construct.c.iscbowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO iscbowndp  #顯示到畫面上
            NEXT FIELD iscbowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbowndp
            #add-point:BEFORE FIELD iscbowndp name="construct.b.iscbowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbowndp
            
            #add-point:AFTER FIELD iscbowndp name="construct.a.iscbowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbcrtid
            #add-point:ON ACTION controlp INFIELD iscbcrtid name="construct.c.iscbcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO iscbcrtid  #顯示到畫面上
            NEXT FIELD iscbcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbcrtid
            #add-point:BEFORE FIELD iscbcrtid name="construct.b.iscbcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbcrtid
            
            #add-point:AFTER FIELD iscbcrtid name="construct.a.iscbcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.iscbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbcrtdp
            #add-point:ON ACTION controlp INFIELD iscbcrtdp name="construct.c.iscbcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO iscbcrtdp  #顯示到畫面上
            NEXT FIELD iscbcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbcrtdp
            #add-point:BEFORE FIELD iscbcrtdp name="construct.b.iscbcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbcrtdp
            
            #add-point:AFTER FIELD iscbcrtdp name="construct.a.iscbcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbcrtdt
            #add-point:BEFORE FIELD iscbcrtdt name="construct.b.iscbcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.iscbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbmodid
            #add-point:ON ACTION controlp INFIELD iscbmodid name="construct.c.iscbmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO iscbmodid  #顯示到畫面上
            NEXT FIELD iscbmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbmodid
            #add-point:BEFORE FIELD iscbmodid name="construct.b.iscbmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbmodid
            
            #add-point:AFTER FIELD iscbmodid name="construct.a.iscbmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbmoddt
            #add-point:BEFORE FIELD iscbmoddt name="construct.b.iscbmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.iscbcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbcnfid
            #add-point:ON ACTION controlp INFIELD iscbcnfid name="construct.c.iscbcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO iscbcnfid  #顯示到畫面上
            NEXT FIELD iscbcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbcnfid
            #add-point:BEFORE FIELD iscbcnfid name="construct.b.iscbcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbcnfid
            
            #add-point:AFTER FIELD iscbcnfid name="construct.a.iscbcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbcnfdt
            #add-point:BEFORE FIELD iscbcnfdt name="construct.b.iscbcnfdt"
            
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
 
{<section id="aist403.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aist403_filter()
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
      CONSTRUCT g_wc_filter ON iscbsite,iscbcomp,iscb200,iscb201
                          FROM s_browse[1].b_iscbsite,s_browse[1].b_iscbcomp,s_browse[1].b_iscb200,s_browse[1].b_iscb201 
 
 
         BEFORE CONSTRUCT
               DISPLAY aist403_filter_parser('iscbsite') TO s_browse[1].b_iscbsite
            DISPLAY aist403_filter_parser('iscbcomp') TO s_browse[1].b_iscbcomp
            DISPLAY aist403_filter_parser('iscb200') TO s_browse[1].b_iscb200
            DISPLAY aist403_filter_parser('iscb201') TO s_browse[1].b_iscb201
      
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
 
      CALL aist403_filter_show('iscbsite')
   CALL aist403_filter_show('iscbcomp')
   CALL aist403_filter_show('iscb200')
   CALL aist403_filter_show('iscb201')
 
END FUNCTION
 
{</section>}
 
{<section id="aist403.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aist403_filter_parser(ps_field)
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
 
{<section id="aist403.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aist403_filter_show(ps_field)
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
   LET ls_condition = aist403_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aist403.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aist403_query()
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
 
   INITIALIZE g_iscb_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aist403_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aist403_browser_fill(g_wc,"F")
      CALL aist403_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aist403_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aist403_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aist403.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aist403_fetch(p_fl)
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
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx)
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_iscb_m.iscbcomp = g_browser[g_current_idx].b_iscbcomp
   LET g_iscb_m.iscbsite = g_browser[g_current_idx].b_iscbsite
   LET g_iscb_m.iscb200 = g_browser[g_current_idx].b_iscb200
   LET g_iscb_m.iscb201 = g_browser[g_current_idx].b_iscb201
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aist403_master_referesh USING g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201 INTO g_iscb_m.iscbsite, 
       g_iscb_m.iscbcomp,g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus, 
       g_iscb_m.iscb001,g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021, 
       g_iscb_m.iscb025,g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014, 
       g_iscb_m.iscb018,g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016, 
       g_iscb_m.iscb020,g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023, 
       g_iscb_m.iscb082,g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106, 
       g_iscb_m.iscb107,g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112, 
       g_iscb_m.iscb113,g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054, 
       g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062, 
       g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029, 
       g_iscb_m.iscb051,g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033, 
       g_iscb_m.iscb074,g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037, 
       g_iscb_m.iscb076,g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080, 
       g_iscb_m.iscb081,g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044, 
       g_iscb_m.iscb045,g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtdp,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid, 
       g_iscb_m.iscbmoddt,g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt,g_iscb_m.iscbownid_desc,g_iscb_m.iscbowndp_desc, 
       g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbcnfid_desc 
 
   
   #遮罩相關處理
   LET g_iscb_m_mask_o.* =  g_iscb_m.*
   CALL aist403_iscb_t_mask()
   LET g_iscb_m_mask_n.* =  g_iscb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aist403_set_act_visible()
   CALL aist403_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   LET g_isca_m_t.* = g_isca_m.*
   LET g_isca_m_o.* = g_isca_m.*
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_iscb_m_t.* = g_iscb_m.*
   LET g_iscb_m_o.* = g_iscb_m.*
   
   LET g_data_owner = g_iscb_m.iscbownid      
   LET g_data_dept  = g_iscb_m.iscbowndp
   
   #重新顯示
   CALL aist403_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aist403.insert" >}
#+ 資料新增
PRIVATE FUNCTION aist403_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_iscb_m.* TO NULL             #DEFAULT 設定
   LET g_iscbcomp_t = NULL
   LET g_iscbsite_t = NULL
   LET g_iscb200_t = NULL
   LET g_iscb201_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_iscb_m.iscbownid = g_user
      LET g_iscb_m.iscbowndp = g_dept
      LET g_iscb_m.iscbcrtid = g_user
      LET g_iscb_m.iscbcrtdp = g_dept 
      LET g_iscb_m.iscbcrtdt = cl_get_current()
      LET g_iscb_m.iscbmodid = g_user
      LET g_iscb_m.iscbmoddt = cl_get_current()
      LET g_iscb_m.iscbstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_iscb_m.iscb001 = "0"
      LET g_iscb_m.iscb005 = "0"
      LET g_iscb_m.iscb009 = "0"
      LET g_iscb_m.iscb013 = "0"
      LET g_iscb_m.iscb017 = "0"
      LET g_iscb_m.iscb021 = "0"
      LET g_iscb_m.iscb025 = "0"
      LET g_iscb_m.iscb027 = "0"
      LET g_iscb_m.iscb002 = "0"
      LET g_iscb_m.iscb006 = "0"
      LET g_iscb_m.iscb010 = "0"
      LET g_iscb_m.iscb014 = "0"
      LET g_iscb_m.iscb018 = "0"
      LET g_iscb_m.iscb022 = "0"
      LET g_iscb_m.iscb004 = "0"
      LET g_iscb_m.iscb008 = "0"
      LET g_iscb_m.iscb012 = "0"
      LET g_iscb_m.iscb016 = "0"
      LET g_iscb_m.iscb020 = "0"
      LET g_iscb_m.iscb024 = "0"
      LET g_iscb_m.iscb007 = "0"
      LET g_iscb_m.iscb015 = "0"
      LET g_iscb_m.iscb019 = "0"
      LET g_iscb_m.iscb023 = "0"
      LET g_iscb_m.iscb082 = "0"
      LET g_iscb_m.iscb101 = "0"
      LET g_iscb_m.iscb103 = "0"
      LET g_iscb_m.iscb104 = "0"
      LET g_iscb_m.iscb105 = "0"
      LET g_iscb_m.iscb106 = "0"
      LET g_iscb_m.iscb107 = "0"
      LET g_iscb_m.iscb108 = "0"
      LET g_iscb_m.iscb109 = "0"
      LET g_iscb_m.iscb110 = "0"
      LET g_iscb_m.iscb111 = "0"
      LET g_iscb_m.iscb112 = "0"
      LET g_iscb_m.iscb113 = "0"
      LET g_iscb_m.iscb114 = "0"
      LET g_iscb_m.iscb115 = "0"
      LET g_iscb_m.iscb052 = "0"
      LET g_iscb_m.iscb053 = "0"
      LET g_iscb_m.iscb054 = "0"
      LET g_iscb_m.iscb055 = "0"
      LET g_iscb_m.iscb056 = "0"
      LET g_iscb_m.iscb057 = "0"
      LET g_iscb_m.iscb060 = "0"
      LET g_iscb_m.iscb061 = "0"
      LET g_iscb_m.iscb062 = "0"
      LET g_iscb_m.iscb063 = "0"
      LET g_iscb_m.iscb064 = "0"
      LET g_iscb_m.iscb065 = "0"
      LET g_iscb_m.iscb066 = "0"
      LET g_iscb_m.iscb028 = "0"
      LET g_iscb_m.iscb029 = "0"
      LET g_iscb_m.iscb051 = "0"
      LET g_iscb_m.iscb030 = "0"
      LET g_iscb_m.iscb031 = "0"
      LET g_iscb_m.iscb073 = "0"
      LET g_iscb_m.iscb032 = "0"
      LET g_iscb_m.iscb033 = "0"
      LET g_iscb_m.iscb074 = "0"
      LET g_iscb_m.iscb034 = "0"
      LET g_iscb_m.iscb035 = "0"
      LET g_iscb_m.iscb075 = "0"
      LET g_iscb_m.iscb036 = "0"
      LET g_iscb_m.iscb037 = "0"
      LET g_iscb_m.iscb076 = "0"
      LET g_iscb_m.iscb038 = "0"
      LET g_iscb_m.iscb039 = "0"
      LET g_iscb_m.iscb078 = "0"
      LET g_iscb_m.iscb079 = "0"
      LET g_iscb_m.iscb080 = "0"
      LET g_iscb_m.iscb081 = "0"
      LET g_iscb_m.iscb040 = "0"
      LET g_iscb_m.iscb041 = "0"
      LET g_iscb_m.iscb042 = "0"
      LET g_iscb_m.iscb043 = "0"
      LET g_iscb_m.iscb044 = "0"
      LET g_iscb_m.iscb045 = "0"
      LET g_iscb_m.iscb046 = "0"
      LET g_iscb_m.iscb047 = "0"
      LET g_iscb_m.iscb048 = "0"
      LET g_iscb_m.iscb049 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_iscb_m.iscbstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aist403_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_iscb_m.* TO NULL
         CALL aist403_show()
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
   CALL aist403_set_act_visible()
   CALL aist403_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_iscbcomp_t = g_iscb_m.iscbcomp
   LET g_iscbsite_t = g_iscb_m.iscbsite
   LET g_iscb200_t = g_iscb_m.iscb200
   LET g_iscb201_t = g_iscb_m.iscb201
 
   
   #組合新增資料的條件
   LET g_add_browse = " iscbent = " ||g_enterprise|| " AND",
                      " iscbcomp = '", g_iscb_m.iscbcomp, "' "
                      ," AND iscbsite = '", g_iscb_m.iscbsite, "' "
                      ," AND iscb200 = '", g_iscb_m.iscb200, "' "
                      ," AND iscb201 = '", g_iscb_m.iscb201, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aist403_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aist403_master_referesh USING g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201 INTO g_iscb_m.iscbsite, 
       g_iscb_m.iscbcomp,g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus, 
       g_iscb_m.iscb001,g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021, 
       g_iscb_m.iscb025,g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014, 
       g_iscb_m.iscb018,g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016, 
       g_iscb_m.iscb020,g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023, 
       g_iscb_m.iscb082,g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106, 
       g_iscb_m.iscb107,g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112, 
       g_iscb_m.iscb113,g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054, 
       g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062, 
       g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029, 
       g_iscb_m.iscb051,g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033, 
       g_iscb_m.iscb074,g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037, 
       g_iscb_m.iscb076,g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080, 
       g_iscb_m.iscb081,g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044, 
       g_iscb_m.iscb045,g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtdp,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid, 
       g_iscb_m.iscbmoddt,g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt,g_iscb_m.iscbownid_desc,g_iscb_m.iscbowndp_desc, 
       g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_iscb_m_mask_o.* =  g_iscb_m.*
   CALL aist403_iscb_t_mask()
   LET g_iscb_m_mask_n.* =  g_iscb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_iscb_m.iscbsite,g_iscb_m.iscbsite_desc,g_iscb_m.iscbcomp,g_iscb_m.iscbcomp_desc, 
       g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus,g_iscb_m.iscb001, 
       g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021,g_iscb_m.iscb025, 
       g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014,g_iscb_m.iscb018, 
       g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016,g_iscb_m.iscb020, 
       g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023,g_iscb_m.iscb082, 
       g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106,g_iscb_m.iscb107, 
       g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112,g_iscb_m.iscb113, 
       g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054,g_iscb_m.iscb055, 
       g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062,g_iscb_m.iscb063, 
       g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029,g_iscb_m.iscb051, 
       g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033,g_iscb_m.iscb074, 
       g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037,g_iscb_m.iscb076, 
       g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080,g_iscb_m.iscb081, 
       g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044,g_iscb_m.iscb045, 
       g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid,g_iscb_m.iscbownid_desc, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbowndp_desc,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp, 
       g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbmoddt, 
       g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfid_desc,g_iscb_m.iscbcnfdt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_iscb_m.iscbownid      
   LET g_data_dept  = g_iscb_m.iscbowndp
 
   #功能已完成,通報訊息中心
   CALL aist403_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aist403.modify" >}
#+ 資料修改
PRIVATE FUNCTION aist403_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_iscb_m.iscbcomp IS NULL
 
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
   LET g_iscbcomp_t = g_iscb_m.iscbcomp
   LET g_iscbsite_t = g_iscb_m.iscbsite
   LET g_iscb200_t = g_iscb_m.iscb200
   LET g_iscb201_t = g_iscb_m.iscb201
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aist403_cl USING g_enterprise,g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aist403_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aist403_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aist403_master_referesh USING g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201 INTO g_iscb_m.iscbsite, 
       g_iscb_m.iscbcomp,g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus, 
       g_iscb_m.iscb001,g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021, 
       g_iscb_m.iscb025,g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014, 
       g_iscb_m.iscb018,g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016, 
       g_iscb_m.iscb020,g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023, 
       g_iscb_m.iscb082,g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106, 
       g_iscb_m.iscb107,g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112, 
       g_iscb_m.iscb113,g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054, 
       g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062, 
       g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029, 
       g_iscb_m.iscb051,g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033, 
       g_iscb_m.iscb074,g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037, 
       g_iscb_m.iscb076,g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080, 
       g_iscb_m.iscb081,g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044, 
       g_iscb_m.iscb045,g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtdp,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid, 
       g_iscb_m.iscbmoddt,g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt,g_iscb_m.iscbownid_desc,g_iscb_m.iscbowndp_desc, 
       g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbcnfid_desc 
 
 
   #檢查是否允許此動作
   IF NOT aist403_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_iscb_m_mask_o.* =  g_iscb_m.*
   CALL aist403_iscb_t_mask()
   LET g_iscb_m_mask_n.* =  g_iscb_m.*
   
   
 
   #顯示資料
   CALL aist403_show()
   
   WHILE TRUE
      LET g_iscb_m.iscbcomp = g_iscbcomp_t
      LET g_iscb_m.iscbsite = g_iscbsite_t
      LET g_iscb_m.iscb200 = g_iscb200_t
      LET g_iscb_m.iscb201 = g_iscb201_t
 
      
      #寫入修改者/修改日期資訊
      LET g_iscb_m.iscbmodid = g_user 
LET g_iscb_m.iscbmoddt = cl_get_current()
LET g_iscb_m.iscbmodid_desc = cl_get_username(g_iscb_m.iscbmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aist403_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_iscb_m.* = g_iscb_m_t.*
         CALL aist403_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE iscb_t SET (iscbmodid,iscbmoddt) = (g_iscb_m.iscbmodid,g_iscb_m.iscbmoddt)
       WHERE iscbent = g_enterprise AND iscbcomp = g_iscbcomp_t
         AND iscbsite = g_iscbsite_t
         AND iscb200 = g_iscb200_t
         AND iscb201 = g_iscb201_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aist403_set_act_visible()
   CALL aist403_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " iscbent = " ||g_enterprise|| " AND",
                      " iscbcomp = '", g_iscb_m.iscbcomp, "' "
                      ," AND iscbsite = '", g_iscb_m.iscbsite, "' "
                      ," AND iscb200 = '", g_iscb_m.iscb200, "' "
                      ," AND iscb201 = '", g_iscb_m.iscb201, "' "
 
   #填到對應位置
   CALL aist403_browser_fill(g_wc,"")
 
   CLOSE aist403_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aist403_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aist403.input" >}
#+ 資料輸入
PRIVATE FUNCTION aist403_input(p_cmd)
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
   DEFINE l_isaa012       LIKE isaa_t.isaa012    #年度
   DEFINE l_isaa013       LIKE isaa_t.isaa013    #月份
   DEFINE l_day1          LIKE type_t.dat        #輸入的年月
   DEFINE l_day2          LIKE type_t.dat        #aisi010設定的年月
   DEFINE l_other         LIKE isca_t.isca801
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
   DISPLAY BY NAME g_iscb_m.iscbsite,g_iscb_m.iscbsite_desc,g_iscb_m.iscbcomp,g_iscb_m.iscbcomp_desc, 
       g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus,g_iscb_m.iscb001, 
       g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021,g_iscb_m.iscb025, 
       g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014,g_iscb_m.iscb018, 
       g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016,g_iscb_m.iscb020, 
       g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023,g_iscb_m.iscb082, 
       g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106,g_iscb_m.iscb107, 
       g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112,g_iscb_m.iscb113, 
       g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054,g_iscb_m.iscb055, 
       g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062,g_iscb_m.iscb063, 
       g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029,g_iscb_m.iscb051, 
       g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033,g_iscb_m.iscb074, 
       g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037,g_iscb_m.iscb076, 
       g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080,g_iscb_m.iscb081, 
       g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044,g_iscb_m.iscb045, 
       g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid,g_iscb_m.iscbownid_desc, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbowndp_desc,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp, 
       g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbmoddt, 
       g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfid_desc,g_iscb_m.iscbcnfdt
   
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
   CALL aist403_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aist403_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_iscb_m.iscbsite,g_iscb_m.iscbcomp,g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202, 
          g_iscb_m.iscb050,g_iscb_m.iscbstus,g_iscb_m.iscb082,g_iscb_m.iscb108,g_iscb_m.iscb052,g_iscb_m.iscb053, 
          g_iscb_m.iscb054,g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061, 
          g_iscb_m.iscb062,g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb073  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbsite
            
            #add-point:AFTER FIELD iscbsite name="input.a.iscbsite"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_iscb_m.iscbcomp) AND NOT cl_null(g_iscb_m.iscbsite) AND NOT cl_null(g_iscb_m.iscb200) AND NOT cl_null(g_iscb_m.iscb201) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_iscb_m.iscbcomp != g_iscbcomp_t  OR g_iscb_m.iscbsite != g_iscbsite_t  OR g_iscb_m.iscb200 != g_iscb200_t  OR g_iscb_m.iscb201 != g_iscb201_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM iscb_t WHERE "||"iscbent = '" ||g_enterprise|| "' AND "||"iscbcomp = '"||g_iscb_m.iscbcomp ||"' AND "|| "iscbsite = '"||g_iscb_m.iscbsite ||"' AND "|| "iscb200 = '"||g_iscb_m.iscb200 ||"' AND "|| "iscb201 = '"||g_iscb_m.iscb201 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbsite
            #add-point:BEFORE FIELD iscbsite name="input.b.iscbsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscbsite
            #add-point:ON CHANGE iscbsite name="input.g.iscbsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbcomp
            
            #add-point:AFTER FIELD iscbcomp name="input.a.iscbcomp"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_iscb_m.iscbcomp) AND NOT cl_null(g_iscb_m.iscbsite) AND NOT cl_null(g_iscb_m.iscb200) AND NOT cl_null(g_iscb_m.iscb201) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_iscb_m.iscbcomp != g_iscbcomp_t  OR g_iscb_m.iscbsite != g_iscbsite_t  OR g_iscb_m.iscb200 != g_iscb200_t  OR g_iscb_m.iscb201 != g_iscb201_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM iscb_t WHERE "||"iscbent = '" ||g_enterprise|| "' AND "||"iscbcomp = '"||g_iscb_m.iscbcomp ||"' AND "|| "iscbsite = '"||g_iscb_m.iscbsite ||"' AND "|| "iscb200 = '"||g_iscb_m.iscb200 ||"' AND "|| "iscb201 = '"||g_iscb_m.iscb201 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbcomp
            #add-point:BEFORE FIELD iscbcomp name="input.b.iscbcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscbcomp
            #add-point:ON CHANGE iscbcomp name="input.g.iscbcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb200
            #add-point:BEFORE FIELD iscb200 name="input.b.iscb200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb200
            
            #add-point:AFTER FIELD iscb200 name="input.a.iscb200"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_iscb_m.iscbcomp) AND NOT cl_null(g_iscb_m.iscbsite) AND NOT cl_null(g_iscb_m.iscb200) AND NOT cl_null(g_iscb_m.iscb201) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_iscb_m.iscbcomp != g_iscbcomp_t  OR g_iscb_m.iscbsite != g_iscbsite_t  OR g_iscb_m.iscb200 != g_iscb200_t  OR g_iscb_m.iscb201 != g_iscb201_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM iscb_t WHERE "||"iscbent = '" ||g_enterprise|| "' AND "||"iscbcomp = '"||g_iscb_m.iscbcomp ||"' AND "|| "iscbsite = '"||g_iscb_m.iscbsite ||"' AND "|| "iscb200 = '"||g_iscb_m.iscb200 ||"' AND "|| "iscb201 = '"||g_iscb_m.iscb201 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb200
            #add-point:ON CHANGE iscb200 name="input.g.iscb200"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb201
            #add-point:BEFORE FIELD iscb201 name="input.b.iscb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb201
            
            #add-point:AFTER FIELD iscb201 name="input.a.iscb201"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_iscb_m.iscbcomp) AND NOT cl_null(g_iscb_m.iscbsite) AND NOT cl_null(g_iscb_m.iscb200) AND NOT cl_null(g_iscb_m.iscb201) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_iscb_m.iscbcomp != g_iscbcomp_t  OR g_iscb_m.iscbsite != g_iscbsite_t  OR g_iscb_m.iscb200 != g_iscb200_t  OR g_iscb_m.iscb201 != g_iscb201_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM iscb_t WHERE "||"iscbent = '" ||g_enterprise|| "' AND "||"iscbcomp = '"||g_iscb_m.iscbcomp ||"' AND "|| "iscbsite = '"||g_iscb_m.iscbsite ||"' AND "|| "iscb200 = '"||g_iscb_m.iscb200 ||"' AND "|| "iscb201 = '"||g_iscb_m.iscb201 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb201
            #add-point:ON CHANGE iscb201 name="input.g.iscb201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb202
            #add-point:BEFORE FIELD iscb202 name="input.b.iscb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb202
            
            #add-point:AFTER FIELD iscb202 name="input.a.iscb202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb202
            #add-point:ON CHANGE iscb202 name="input.g.iscb202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb050
            #add-point:BEFORE FIELD iscb050 name="input.b.iscb050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb050
            
            #add-point:AFTER FIELD iscb050 name="input.a.iscb050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb050
            #add-point:ON CHANGE iscb050 name="input.g.iscb050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscbstus
            #add-point:BEFORE FIELD iscbstus name="input.b.iscbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscbstus
            
            #add-point:AFTER FIELD iscbstus name="input.a.iscbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscbstus
            #add-point:ON CHANGE iscbstus name="input.g.iscbstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb082
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb082,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb082
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb082 name="input.a.iscb082"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb082
            #add-point:BEFORE FIELD iscb082 name="input.b.iscb082"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb082
            #add-point:ON CHANGE iscb082 name="input.g.iscb082"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb108
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb108,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb108
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb108 name="input.a.iscb108"



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb108
            #add-point:BEFORE FIELD iscb108 name="input.b.iscb108"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb108
            #add-point:ON CHANGE iscb108 name="input.g.iscb108"
            LET g_iscb_m.iscb110 = g_iscb_m.iscb107 + g_iscb_m.iscb108 
            IF g_iscb_m.iscb101 - g_iscb_m.iscb110 > 0 THEN
               LET g_iscb_m.iscb111 = g_iscb_m.iscb101 - g_iscb_m.iscb110
               LET g_iscb_m.iscb112 = 0
            ELSE
               LET g_iscb_m.iscb112 = g_iscb_m.iscb110 - g_iscb_m.iscb101
               LET g_iscb_m.iscb111 = 0
            END IF
            IF g_iscb_m.iscb112 > g_iscb_m.iscb113 THEN
               LET g_iscb_m.iscb114 = g_iscb_m.iscb113
            ELSE 
               LET g_iscb_m.iscb114 = g_iscb_m.iscb112
            END IF
            LET g_iscb_m.iscb115 = g_iscb_m.iscb112 - g_iscb_m.iscb114
            
            DISPLAY BY NAME g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112,
                            g_iscb_m.iscb114,g_iscb_m.iscb115
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb052
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb052,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb052
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb052 name="input.a.iscb052"
            IF NOT cl_null(g_iscb_m.iscb052) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb052 != g_iscb_m_t.iscb052 OR cl_null(g_iscb_m_t.iscb052) )) THEN
                  CALL aist403_sum_iscb065()
                  LET g_iscb_m_t.iscb052 = g_iscb_m.iscb052
                  DISPLAY BY NAME g_iscb_m.iscb052
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb052
            #add-point:BEFORE FIELD iscb052 name="input.b.iscb052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb052
            #add-point:ON CHANGE iscb052 name="input.g.iscb052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb053
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb053,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb053
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb053 name="input.a.iscb053"
            IF NOT cl_null(g_iscb_m.iscb053) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb053 != g_iscb_m_t.iscb053 OR cl_null(g_iscb_m_t.iscb053) )) THEN
                  CALL aist403_sum_iscb066()
                  LET g_iscb_m_t.iscb053 = g_iscb_m.iscb053
                  DISPLAY BY NAME g_iscb_m.iscb053
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb053
            #add-point:BEFORE FIELD iscb053 name="input.b.iscb053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb053
            #add-point:ON CHANGE iscb053 name="input.g.iscb053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb054
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb054,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb054
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb054 name="input.a.iscb054"
            IF NOT cl_null(g_iscb_m.iscb054) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb054 != g_iscb_m_t.iscb054 OR cl_null(g_iscb_m_t.iscb054) )) THEN
                  CALL aist403_sum_iscb065()
                  LET g_iscb_m_t.iscb054 = g_iscb_m.iscb054
                  DISPLAY BY NAME g_iscb_m.iscb054
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb054
            #add-point:BEFORE FIELD iscb054 name="input.b.iscb054"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb054
            #add-point:ON CHANGE iscb054 name="input.g.iscb054"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb055
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb055,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb055
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb055 name="input.a.iscb055"
            IF NOT cl_null(g_iscb_m.iscb055) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb055 != g_iscb_m_t.iscb055 OR cl_null(g_iscb_m_t.iscb055) )) THEN
                  CALL aist403_sum_iscb066()
                  LET g_iscb_m_t.iscb055 = g_iscb_m.iscb055
                  DISPLAY BY NAME g_iscb_m.iscb055
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb055
            #add-point:BEFORE FIELD iscb055 name="input.b.iscb055"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb055
            #add-point:ON CHANGE iscb055 name="input.g.iscb055"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb056
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb056,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb056
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb056 name="input.a.iscb056"
            IF NOT cl_null(g_iscb_m.iscb056) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb056 != g_iscb_m_t.iscb056 OR cl_null(g_iscb_m_t.iscb056) )) THEN
                  CALL aist403_sum_iscb065()
                  LET g_iscb_m_t.iscb056 = g_iscb_m.iscb056
                  DISPLAY BY NAME g_iscb_m.iscb056
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb056
            #add-point:BEFORE FIELD iscb056 name="input.b.iscb056"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb056
            #add-point:ON CHANGE iscb056 name="input.g.iscb056"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb057
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb057,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb057
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb057 name="input.a.iscb057"
            IF NOT cl_null(g_iscb_m.iscb057) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb057 != g_iscb_m_t.iscb057 OR cl_null(g_iscb_m_t.iscb057) )) THEN
                  CALL aist403_sum_iscb066()
                  LET g_iscb_m_t.iscb057 = g_iscb_m.iscb057
                  DISPLAY BY NAME g_iscb_m.iscb057
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb057
            #add-point:BEFORE FIELD iscb057 name="input.b.iscb057"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb057
            #add-point:ON CHANGE iscb057 name="input.g.iscb057"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb060
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb060,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb060
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb060 name="input.a.iscb060"
            IF NOT cl_null(g_iscb_m.iscb060) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb060 != g_iscb_m_t.iscb060 OR cl_null(g_iscb_m_t.iscb060) )) THEN
                  CALL aist403_sum_iscb065()
                  LET g_iscb_m_t.iscb060 = g_iscb_m.iscb060
                  DISPLAY BY NAME g_iscb_m.iscb060
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb060
            #add-point:BEFORE FIELD iscb060 name="input.b.iscb060"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb060
            #add-point:ON CHANGE iscb060 name="input.g.iscb060"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb061
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb061,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb061
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb061 name="input.a.iscb061"
            IF NOT cl_null(g_iscb_m.iscb061) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb061 != g_iscb_m_t.iscb061 OR cl_null(g_iscb_m_t.iscb061) )) THEN
                  CALL aist403_sum_iscb066()
                  LET g_iscb_m_t.iscb061 = g_iscb_m.iscb061
                  DISPLAY BY NAME g_iscb_m.iscb061
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb061
            #add-point:BEFORE FIELD iscb061 name="input.b.iscb061"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb061
            #add-point:ON CHANGE iscb061 name="input.g.iscb061"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb062
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb062,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb062
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb062 name="input.a.iscb062"
            IF NOT cl_null(g_iscb_m.iscb062) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb062 != g_iscb_m_t.iscb062 OR cl_null(g_iscb_m_t.iscb062) )) THEN
                  CALL aist403_sum_iscb065()
                  LET g_iscb_m_t.iscb062 = g_iscb_m.iscb062
                  DISPLAY BY NAME g_iscb_m.iscb062
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb062
            #add-point:BEFORE FIELD iscb062 name="input.b.iscb062"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb062
            #add-point:ON CHANGE iscb062 name="input.g.iscb062"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb063
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb063,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb063
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb063 name="input.a.iscb063"
            IF NOT cl_null(g_iscb_m.iscb063) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb063 != g_iscb_m_t.iscb063 OR cl_null(g_iscb_m_t.iscb063) )) THEN
                  CALL aist403_sum_iscb065()
                  LET g_iscb_m_t.iscb063 = g_iscb_m.iscb063
                  DISPLAY BY NAME g_iscb_m.iscb063
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb063
            #add-point:BEFORE FIELD iscb063 name="input.b.iscb063"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb063
            #add-point:ON CHANGE iscb063 name="input.g.iscb063"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb064
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb064,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb064
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb064 name="input.a.iscb064"
            IF NOT cl_null(g_iscb_m.iscb064) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_iscb_m.iscb064 != g_iscb_m_t.iscb064 OR cl_null(g_iscb_m_t.iscb064) )) THEN
                  CALL aist403_sum_iscb066()
                  LET g_iscb_m_t.iscb064 = g_iscb_m.iscb064
                  DISPLAY BY NAME g_iscb_m.iscb064
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb064
            #add-point:BEFORE FIELD iscb064 name="input.b.iscb064"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb064
            #add-point:ON CHANGE iscb064 name="input.g.iscb064"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb065
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb065,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb065
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb065 name="input.a.iscb065"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb065
            #add-point:BEFORE FIELD iscb065 name="input.b.iscb065"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb065
            #add-point:ON CHANGE iscb065 name="input.g.iscb065"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb066
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb066,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb066
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb066 name="input.a.iscb066"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb066
            #add-point:BEFORE FIELD iscb066 name="input.b.iscb066"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb066
            #add-point:ON CHANGE iscb066 name="input.g.iscb066"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD iscb073
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_iscb_m.iscb073,"0","1","","","azz-00079",1) THEN
               NEXT FIELD iscb073
            END IF 
 
 
 
            #add-point:AFTER FIELD iscb073 name="input.a.iscb073"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD iscb073
            #add-point:BEFORE FIELD iscb073 name="input.b.iscb073"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE iscb073
            #add-point:ON CHANGE iscb073 name="input.g.iscb073"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.iscbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbsite
            #add-point:ON ACTION controlp INFIELD iscbsite name="input.c.iscbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscbcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbcomp
            #add-point:ON ACTION controlp INFIELD iscbcomp name="input.c.iscbcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb200
            #add-point:ON ACTION controlp INFIELD iscb200 name="input.c.iscb200"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb201
            #add-point:ON ACTION controlp INFIELD iscb201 name="input.c.iscb201"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb202
            #add-point:ON ACTION controlp INFIELD iscb202 name="input.c.iscb202"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb050
            #add-point:ON ACTION controlp INFIELD iscb050 name="input.c.iscb050"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscbstus
            #add-point:ON ACTION controlp INFIELD iscbstus name="input.c.iscbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb082
            #add-point:ON ACTION controlp INFIELD iscb082 name="input.c.iscb082"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb108
            #add-point:ON ACTION controlp INFIELD iscb108 name="input.c.iscb108"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb052
            #add-point:ON ACTION controlp INFIELD iscb052 name="input.c.iscb052"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb053
            #add-point:ON ACTION controlp INFIELD iscb053 name="input.c.iscb053"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb054
            #add-point:ON ACTION controlp INFIELD iscb054 name="input.c.iscb054"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb055
            #add-point:ON ACTION controlp INFIELD iscb055 name="input.c.iscb055"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb056
            #add-point:ON ACTION controlp INFIELD iscb056 name="input.c.iscb056"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb057
            #add-point:ON ACTION controlp INFIELD iscb057 name="input.c.iscb057"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb060
            #add-point:ON ACTION controlp INFIELD iscb060 name="input.c.iscb060"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb061
            #add-point:ON ACTION controlp INFIELD iscb061 name="input.c.iscb061"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb062
            #add-point:ON ACTION controlp INFIELD iscb062 name="input.c.iscb062"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb063
            #add-point:ON ACTION controlp INFIELD iscb063 name="input.c.iscb063"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb064
            #add-point:ON ACTION controlp INFIELD iscb064 name="input.c.iscb064"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb065
            #add-point:ON ACTION controlp INFIELD iscb065 name="input.c.iscb065"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb066
            #add-point:ON ACTION controlp INFIELD iscb066 name="input.c.iscb066"
            
            #END add-point
 
 
         #Ctrlp:input.c.iscb073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD iscb073
            #add-point:ON ACTION controlp INFIELD iscb073 name="input.c.iscb073"
            
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
               SELECT COUNT(1) INTO l_count FROM iscb_t
                WHERE iscbent = g_enterprise AND iscbcomp = g_iscb_m.iscbcomp
                  AND iscbsite = g_iscb_m.iscbsite
                  AND iscb200 = g_iscb_m.iscb200
                  AND iscb201 = g_iscb_m.iscb201
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO iscb_t (iscbent,iscbsite,iscbcomp,iscb200,iscb201,iscb202,iscb050,iscbstus, 
                      iscb001,iscb005,iscb009,iscb013,iscb017,iscb021,iscb025,iscb027,iscb002,iscb006, 
                      iscb010,iscb014,iscb018,iscb022,iscb004,iscb008,iscb012,iscb016,iscb020,iscb024, 
                      iscb007,iscb015,iscb019,iscb023,iscb082,iscb101,iscb103,iscb104,iscb105,iscb106, 
                      iscb107,iscb108,iscb109,iscb110,iscb111,iscb112,iscb113,iscb114,iscb115,iscb052, 
                      iscb053,iscb054,iscb055,iscb056,iscb057,iscb060,iscb061,iscb062,iscb063,iscb064, 
                      iscb065,iscb066,iscb028,iscb029,iscb051,iscb030,iscb031,iscb073,iscb032,iscb033, 
                      iscb074,iscb034,iscb035,iscb075,iscb036,iscb037,iscb076,iscb038,iscb039,iscb078, 
                      iscb079,iscb080,iscb081,iscb040,iscb041,iscb042,iscb043,iscb044,iscb045,iscb046, 
                      iscb047,iscb048,iscb049,iscbownid,iscbowndp,iscbcrtid,iscbcrtdp,iscbcrtdt,iscbmodid, 
                      iscbmoddt,iscbcnfid,iscbcnfdt)
                  VALUES (g_enterprise,g_iscb_m.iscbsite,g_iscb_m.iscbcomp,g_iscb_m.iscb200,g_iscb_m.iscb201, 
                      g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus,g_iscb_m.iscb001,g_iscb_m.iscb005, 
                      g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021,g_iscb_m.iscb025, 
                      g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014, 
                      g_iscb_m.iscb018,g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012, 
                      g_iscb_m.iscb016,g_iscb_m.iscb020,g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015, 
                      g_iscb_m.iscb019,g_iscb_m.iscb023,g_iscb_m.iscb082,g_iscb_m.iscb101,g_iscb_m.iscb103, 
                      g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106,g_iscb_m.iscb107,g_iscb_m.iscb108, 
                      g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112,g_iscb_m.iscb113, 
                      g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054, 
                      g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061, 
                      g_iscb_m.iscb062,g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066, 
                      g_iscb_m.iscb028,g_iscb_m.iscb029,g_iscb_m.iscb051,g_iscb_m.iscb030,g_iscb_m.iscb031, 
                      g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033,g_iscb_m.iscb074,g_iscb_m.iscb034, 
                      g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037,g_iscb_m.iscb076, 
                      g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080, 
                      g_iscb_m.iscb081,g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043, 
                      g_iscb_m.iscb044,g_iscb_m.iscb045,g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048, 
                      g_iscb_m.iscb049,g_iscb_m.iscbownid,g_iscb_m.iscbowndp,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtdp, 
                      g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid,g_iscb_m.iscbmoddt,g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt)  
 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "iscb_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_iscb_m.iscbcomp
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aist403_iscb_t_mask_restore('restore_mask_o')
               
               UPDATE iscb_t SET (iscbsite,iscbcomp,iscb200,iscb201,iscb202,iscb050,iscbstus,iscb001, 
                   iscb005,iscb009,iscb013,iscb017,iscb021,iscb025,iscb027,iscb002,iscb006,iscb010,iscb014, 
                   iscb018,iscb022,iscb004,iscb008,iscb012,iscb016,iscb020,iscb024,iscb007,iscb015,iscb019, 
                   iscb023,iscb082,iscb101,iscb103,iscb104,iscb105,iscb106,iscb107,iscb108,iscb109,iscb110, 
                   iscb111,iscb112,iscb113,iscb114,iscb115,iscb052,iscb053,iscb054,iscb055,iscb056,iscb057, 
                   iscb060,iscb061,iscb062,iscb063,iscb064,iscb065,iscb066,iscb028,iscb029,iscb051,iscb030, 
                   iscb031,iscb073,iscb032,iscb033,iscb074,iscb034,iscb035,iscb075,iscb036,iscb037,iscb076, 
                   iscb038,iscb039,iscb078,iscb079,iscb080,iscb081,iscb040,iscb041,iscb042,iscb043,iscb044, 
                   iscb045,iscb046,iscb047,iscb048,iscb049,iscbownid,iscbowndp,iscbcrtid,iscbcrtdp,iscbcrtdt, 
                   iscbmodid,iscbmoddt,iscbcnfid,iscbcnfdt) = (g_iscb_m.iscbsite,g_iscb_m.iscbcomp,g_iscb_m.iscb200, 
                   g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus,g_iscb_m.iscb001, 
                   g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021, 
                   g_iscb_m.iscb025,g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010, 
                   g_iscb_m.iscb014,g_iscb_m.iscb018,g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008, 
                   g_iscb_m.iscb012,g_iscb_m.iscb016,g_iscb_m.iscb020,g_iscb_m.iscb024,g_iscb_m.iscb007, 
                   g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023,g_iscb_m.iscb082,g_iscb_m.iscb101, 
                   g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106,g_iscb_m.iscb107, 
                   g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112, 
                   g_iscb_m.iscb113,g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053, 
                   g_iscb_m.iscb054,g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060, 
                   g_iscb_m.iscb061,g_iscb_m.iscb062,g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065, 
                   g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029,g_iscb_m.iscb051,g_iscb_m.iscb030, 
                   g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033,g_iscb_m.iscb074, 
                   g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037, 
                   g_iscb_m.iscb076,g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079, 
                   g_iscb_m.iscb080,g_iscb_m.iscb081,g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042, 
                   g_iscb_m.iscb043,g_iscb_m.iscb044,g_iscb_m.iscb045,g_iscb_m.iscb046,g_iscb_m.iscb047, 
                   g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid,g_iscb_m.iscbowndp,g_iscb_m.iscbcrtid, 
                   g_iscb_m.iscbcrtdp,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid,g_iscb_m.iscbmoddt,g_iscb_m.iscbcnfid, 
                   g_iscb_m.iscbcnfdt)
                WHERE iscbent = g_enterprise AND iscbcomp = g_iscbcomp_t #
                  AND iscbsite = g_iscbsite_t
                  AND iscb200 = g_iscb200_t
                  AND iscb201 = g_iscb201_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "iscb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "iscb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL aist403_iscb_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_iscb_m_t)
                     LET g_log2 = util.JSON.stringify(g_iscb_m)
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
      INPUT BY NAME g_isca_m.isca701,g_isca_m.isca702,g_isca_m.isca703,g_isca_m.isca704,g_isca_m.isca705,
                    g_isca_m.isca707,g_isca_m.isca706,g_isca_m.isca708,g_isca_m.isca805, 
                    g_isca_m.isca806,g_isca_m.isca807,g_isca_m.isca801,g_isca_m.isca803,g_isca_m.isca802,g_isca_m.isca804 
      
      
       ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD isca702
            IF NOT cl_null(g_isca_m.isca702) THEN
               #無條件截位
               CALL s_num_round(3,g_isca_m.isca702,0) RETURNING g_isca_m.isca702
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca702 != g_isca_m_t.isca702 OR cl_null(g_isca_m_t.isca702) )) THEN
                  CALL aist403_sum_isca701() RETURNING g_isca_m.isca701,g_isca_m.isca806
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  LET g_isca_m_t.isca702 = g_isca_m.isca702
                  DISPLAY BY NAME g_isca_m.isca701,g_isca_m.isca806,g_isca_m.isca805
               END IF
            END IF
            
         AFTER FIELD isca703                    
            IF NOT cl_null(g_isca_m.isca703) THEN
               CALL s_num_round(3,g_isca_m.isca703,0) RETURNING g_isca_m.isca703
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca703 != g_isca_m_t.isca703 OR cl_null(g_isca_m_t.isca703) )) THEN
                  CALL aist403_sum_isca701() RETURNING g_isca_m.isca701,g_isca_m.isca807
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  LET g_isca_m_t.isca703 = g_isca_m.isca703
                  DISPLAY BY NAME g_isca_m.isca701,g_isca_m.isca807,g_isca_m.isca805
               END IF
            END IF
            
         AFTER FIELD isca704                 
            IF NOT cl_null(g_isca_m.isca704) THEN
               CALL s_num_round(3,g_isca_m.isca704,0) RETURNING g_isca_m.isca704
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca704 != g_isca_m_t.isca704 OR cl_null(g_isca_m_t.isca704) )) THEN
                  CALL aist403_sum_isca701() RETURNING g_isca_m.isca701,l_other
                  LET g_isca_m_t.isca704 = g_isca_m.isca704
                  DISPLAY BY NAME g_isca_m.isca701
               END IF
            END IF
            
         AFTER FIELD isca705            
            IF NOT cl_null(g_isca_m.isca705) THEN
               CALL s_num_round(3,g_isca_m.isca705,0) RETURNING g_isca_m.isca705
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca705 != g_isca_m_t.isca705 OR cl_null(g_isca_m_t.isca705) )) THEN
                  CALL aist403_sum_isca701() RETURNING g_isca_m.isca701,g_isca_m.isca801
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  LET g_isca_m_t.isca705 = g_isca_m.isca705
                  DISPLAY BY NAME g_isca_m.isca701,g_isca_m.isca801,g_isca_m.isca805
               END IF
            END IF
         
         AFTER FIELD isca707
            IF NOT cl_null(g_isca_m.isca707) THEN
               CALL s_num_round(3,g_isca_m.isca707,0) RETURNING g_isca_m.isca707
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca707 != g_isca_m_t.isca707 OR cl_null(g_isca_m_t.isca707) )) THEN
                  CALL aist403_sum_isca701() RETURNING g_isca_m.isca701,g_isca_m.isca803
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  LET g_isca_m_t.isca707 = g_isca_m.isca707
                  DISPLAY BY NAME g_isca_m.isca701,g_isca_m.isca803,g_isca_m.isca805
               END IF
            END IF
            
         AFTER FIELD isca706
            IF NOT cl_null(g_isca_m.isca706) THEN
               CALL s_num_round(3,g_isca_m.isca706,0) RETURNING g_isca_m.isca706
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca706 != g_isca_m_t.isca706 OR cl_null(g_isca_m_t.isca706) )) THEN
                  CALL aist403_sum_isca701() RETURNING g_isca_m.isca701,g_isca_m.isca802
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  LET g_isca_m_t.isca706 = g_isca_m.isca706
                  DISPLAY BY NAME g_isca_m.isca701,g_isca_m.isca802,g_isca_m.isca805
               END IF
            END IF     
            
         AFTER FIELD isca708            
            IF NOT cl_null(g_isca_m.isca708) THEN
               CALL s_num_round(3,g_isca_m.isca708,0) RETURNING g_isca_m.isca708
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca708 != g_isca_m_t.isca708 OR cl_null(g_isca_m_t.isca708) )) THEN
                  CALL aist403_sum_isca701() RETURNING g_isca_m.isca701,g_isca_m.isca804
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  LET g_isca_m_t.isca708 = g_isca_m.isca708
                  DISPLAY BY NAME g_isca_m.isca701,g_isca_m.isca804,g_isca_m.isca805
               END IF
            END IF    
            
         AFTER FIELD isca806    
            IF NOT cl_null(g_isca_m.isca806) THEN
               CALL s_num_round(3,g_isca_m.isca806,0) RETURNING g_isca_m.isca806
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca806 != g_isca_m_t.isca806 OR cl_null(g_isca_m_t.isca806) )) THEN
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  CALL aist403_chk_rate() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isca_m.isca806 = g_isca_m_t.isca806
                     CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                     DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca806
                     NEXT FIELD CURRENT
                  END IF
                  LET g_isca_m_t.isca806 = g_isca_m.isca806
                  DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca806
               END IF
            END IF      
            
         AFTER FIELD isca807            
            IF NOT cl_null(g_isca_m.isca807) THEN
               CALL s_num_round(3,g_isca_m.isca807,0) RETURNING g_isca_m.isca807
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca807 != g_isca_m_t.isca807 OR cl_null(g_isca_m_t.isca807) )) THEN
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  CALL aist403_chk_rate() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isca_m.isca807 = g_isca_m_t.isca807
                     CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                     DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca807
                     NEXT FIELD CURRENT
                  END IF
                  LET g_isca_m_t.isca807 = g_isca_m.isca807
                  DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca807
               END IF
            END IF
            
         AFTER FIELD isca801                     
            IF NOT cl_null(g_isca_m.isca801) THEN
               CALL s_num_round(3,g_isca_m.isca801,0) RETURNING g_isca_m.isca801
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca801 != g_isca_m_t.isca801 OR cl_null(g_isca_m_t.isca801) )) THEN
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  CALL aist403_chk_rate() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isca_m.isca801 = g_isca_m_t.isca801
                     CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                     DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca801
                     NEXT FIELD CURRENT
                  END IF
                  LET g_isca_m_t.isca801 = g_isca_m.isca801
                  DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca801
               END IF
            END IF 
         
         AFTER FIELD isca803
            IF NOT cl_null(g_isca_m.isca803) THEN
               CALL s_num_round(3,g_isca_m.isca803,0) RETURNING g_isca_m.isca803
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca803 != g_isca_m_t.isca803 OR cl_null(g_isca_m_t.isca803) )) THEN
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  CALL aist403_chk_rate() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isca_m.isca803 = g_isca_m_t.isca803
                     CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                     DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca803
                     NEXT FIELD CURRENT
                  END IF
                  LET g_isca_m_t.isca803 = g_isca_m.isca803
                  DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca803
               END IF
            END IF
            
         AFTER FIELD isca802
            IF NOT cl_null(g_isca_m.isca802) THEN
               CALL s_num_round(3,g_isca_m.isca802,0) RETURNING g_isca_m.isca802
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca802 != g_isca_m_t.isca802 OR cl_null(g_isca_m_t.isca802) )) THEN
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  CALL aist403_chk_rate() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isca_m.isca802 = g_isca_m_t.isca802
                     CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                     DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca802
                     NEXT FIELD CURRENT
                  END IF
                  LET g_isca_m_t.isca802 = g_isca_m.isca802
                  DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca802
               END IF
            END IF
            
         AFTER FIELD isca804
            IF NOT cl_null(g_isca_m.isca804) THEN
               CALL s_num_round(3,g_isca_m.isca804,0) RETURNING g_isca_m.isca804
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_isca_m.isca804 != g_isca_m_t.isca804 OR cl_null(g_isca_m_t.isca804) )) THEN
                  CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                  CALL aist403_chk_rate() RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isca_m.isca804 = g_isca_m_t.isca804
                     CALL aist403_sum_isca805() RETURNING g_isca_m.isca805
                     DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca804
                     NEXT FIELD CURRENT
                  END IF
                  LET g_isca_m_t.isca804 = g_isca_m.isca804
                  DISPLAY BY NAME g_isca_m.isca805,g_isca_m.isca804
               END IF
            END IF  
            
     
      AFTER INPUT
         IF INT_FLAG THEN
            EXIT DIALOG
         END IF              
         #end add-point
         UPDATE isca_t SET (isca701,isca702,isca703,isca704,isca705,
                            isca707,isca706,isca708,
                            isca805,isca806,isca807,isca801,isca803,isca802,isca804) 
                         = (g_isca_m.isca701,g_isca_m.isca702,g_isca_m.isca703,g_isca_m.isca704,g_isca_m.isca705, 
                            g_isca_m.isca707,g_isca_m.isca706,g_isca_m.isca708,
                            g_isca_m.isca805,g_isca_m.isca806,g_isca_m.isca807,
                            g_isca_m.isca801,g_isca_m.isca803,g_isca_m.isca802,g_isca_m.isca804) 
                            
          WHERE iscaent = g_enterprise AND iscasite = g_iscbsite_t 
            AND isca001 = g_iscb200_t
            AND isca002 = g_iscb201_t
            
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isca_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               NEXT FIELD CURRENT
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "isca_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               NEXT FIELD CURRENT
            OTHERWISE
               
               #資料多語言用-增/改
               
               #add-point:單頭修改後
         
               #end add-point
               #紀錄資料更動
               LET g_log1 = util.JSON.stringify(g_isca_m_t)
               LET g_log2 = util.JSON.stringify(g_isca_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
         END CASE     
     
      END INPUT
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog  name="input.before_dialog"
         CALL aist403_mod()RETURNING g_sub_success
         IF NOT g_sub_success THEN RETURN END IF
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
 
{<section id="aist403.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aist403_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE iscb_t.iscbcomp 
   DEFINE l_oldno     LIKE iscb_t.iscbcomp 
   DEFINE l_newno02     LIKE iscb_t.iscbsite 
   DEFINE l_oldno02     LIKE iscb_t.iscbsite 
   DEFINE l_newno03     LIKE iscb_t.iscb200 
   DEFINE l_oldno03     LIKE iscb_t.iscb200 
   DEFINE l_newno04     LIKE iscb_t.iscb201 
   DEFINE l_oldno04     LIKE iscb_t.iscb201 
 
   DEFINE l_master    RECORD LIKE iscb_t.* #此變數樣板目前無使用
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
   IF g_iscb_m.iscbcomp IS NULL
      OR g_iscb_m.iscbsite IS NULL
      OR g_iscb_m.iscb200 IS NULL
      OR g_iscb_m.iscb201 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_iscbcomp_t = g_iscb_m.iscbcomp
   LET g_iscbsite_t = g_iscb_m.iscbsite
   LET g_iscb200_t = g_iscb_m.iscb200
   LET g_iscb201_t = g_iscb_m.iscb201
 
   
   #清空key值
   LET g_iscb_m.iscbcomp = ""
   LET g_iscb_m.iscbsite = ""
   LET g_iscb_m.iscb200 = ""
   LET g_iscb_m.iscb201 = ""
 
    
   CALL aist403_set_entry("a")
   CALL aist403_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_iscb_m.iscbownid = g_user
      LET g_iscb_m.iscbowndp = g_dept
      LET g_iscb_m.iscbcrtid = g_user
      LET g_iscb_m.iscbcrtdp = g_dept 
      LET g_iscb_m.iscbcrtdt = cl_get_current()
      LET g_iscb_m.iscbmodid = g_user
      LET g_iscb_m.iscbmoddt = cl_get_current()
      LET g_iscb_m.iscbstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_iscb_m.iscbstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_iscb_m.iscbsite_desc = ''
   DISPLAY BY NAME g_iscb_m.iscbsite_desc
   LET g_iscb_m.iscbcomp_desc = ''
   DISPLAY BY NAME g_iscb_m.iscbcomp_desc
 
   
   #資料輸入
   CALL aist403_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_iscb_m.* TO NULL
      CALL aist403_show()
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
      LET g_errparam.extend = "iscb_t:",SQLERRMESSAGE 
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
   CALL aist403_set_act_visible()
   CALL aist403_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_iscbcomp_t = g_iscb_m.iscbcomp
   LET g_iscbsite_t = g_iscb_m.iscbsite
   LET g_iscb200_t = g_iscb_m.iscb200
   LET g_iscb201_t = g_iscb_m.iscb201
 
   
   #組合新增資料的條件
   LET g_add_browse = " iscbent = " ||g_enterprise|| " AND",
                      " iscbcomp = '", g_iscb_m.iscbcomp, "' "
                      ," AND iscbsite = '", g_iscb_m.iscbsite, "' "
                      ," AND iscb200 = '", g_iscb_m.iscb200, "' "
                      ," AND iscb201 = '", g_iscb_m.iscb201, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aist403_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_iscb_m.iscbownid      
   LET g_data_dept  = g_iscb_m.iscbowndp
              
   #功能已完成,通報訊息中心
   CALL aist403_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aist403.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aist403_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_isaa022  LIKE isaa_t.isaa022
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aist403_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   SELECT isca701,isca702,isca703,isca704,isca705,
          isca706,isca707,isca708,
          isca801,isca802,isca803,isca804,isca805,
          isca806,isca807
     INTO g_isca_m.isca701,g_isca_m.isca702,g_isca_m.isca703,g_isca_m.isca704,g_isca_m.isca705,
          g_isca_m.isca706,g_isca_m.isca707,g_isca_m.isca708,
          g_isca_m.isca801,g_isca_m.isca802,g_isca_m.isca803,g_isca_m.isca804,g_isca_m.isca805,
          g_isca_m.isca806,g_isca_m.isca807
     FROM isca_t
    WHERE iscaent  = g_enterprise
      AND iscasite = g_iscb_m.iscbsite
      AND isca001  = g_iscb_m.iscb200
      AND isca002  = g_iscb_m.iscb201

   DISPLAY BY NAME  g_isca_m.isca701,g_isca_m.isca702,g_isca_m.isca703,g_isca_m.isca704,g_isca_m.isca705,
                    g_isca_m.isca706,g_isca_m.isca707,g_isca_m.isca708,
                    g_isca_m.isca801,g_isca_m.isca802,g_isca_m.isca803,g_isca_m.isca804,g_isca_m.isca805,
                    g_isca_m.isca806,g_isca_m.isca807
   LET g_iscb_m.iscbsite_desc =  s_desc_get_department_desc(g_iscb_m.iscbsite)                
   LET g_iscb_m.iscbcomp_desc =  s_desc_get_department_desc(g_iscb_m.iscbcomp)
   
   
   #是否採用直接扣抵法
   LET l_isaa022 = ''
   SELECT isaa022 INTO l_isaa022
     FROM isaa_t
    WHERE isaaent = g_enterprise
      AND isaa001 = g_iscb_m.iscbsite
   IF l_isaa022 = 'N' THEN 
      #國外勞務不顯示
      CALL cl_set_comp_visible("page_4", FALSE) 
   ELSE
      CALL cl_set_comp_visible("page_4", TRUE)   
   END IF
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_iscb_m.iscbsite,g_iscb_m.iscbsite_desc,g_iscb_m.iscbcomp,g_iscb_m.iscbcomp_desc, 
       g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus,g_iscb_m.iscb001, 
       g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021,g_iscb_m.iscb025, 
       g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014,g_iscb_m.iscb018, 
       g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016,g_iscb_m.iscb020, 
       g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023,g_iscb_m.iscb082, 
       g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106,g_iscb_m.iscb107, 
       g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112,g_iscb_m.iscb113, 
       g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054,g_iscb_m.iscb055, 
       g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062,g_iscb_m.iscb063, 
       g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029,g_iscb_m.iscb051, 
       g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033,g_iscb_m.iscb074, 
       g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037,g_iscb_m.iscb076, 
       g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080,g_iscb_m.iscb081, 
       g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044,g_iscb_m.iscb045, 
       g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid,g_iscb_m.iscbownid_desc, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbowndp_desc,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp, 
       g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbmoddt, 
       g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfid_desc,g_iscb_m.iscbcnfdt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aist403_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_iscb_m.iscbstus 
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aist403.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aist403_delete()
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
   IF g_iscb_m.iscbcomp IS NULL
   OR g_iscb_m.iscbsite IS NULL
   OR g_iscb_m.iscb200 IS NULL
   OR g_iscb_m.iscb201 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_iscbcomp_t = g_iscb_m.iscbcomp
   LET g_iscbsite_t = g_iscb_m.iscbsite
   LET g_iscb200_t = g_iscb_m.iscb200
   LET g_iscb201_t = g_iscb_m.iscb201
 
   
   
 
   OPEN aist403_cl USING g_enterprise,g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aist403_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aist403_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aist403_master_referesh USING g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201 INTO g_iscb_m.iscbsite, 
       g_iscb_m.iscbcomp,g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus, 
       g_iscb_m.iscb001,g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021, 
       g_iscb_m.iscb025,g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014, 
       g_iscb_m.iscb018,g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016, 
       g_iscb_m.iscb020,g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023, 
       g_iscb_m.iscb082,g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106, 
       g_iscb_m.iscb107,g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112, 
       g_iscb_m.iscb113,g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054, 
       g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062, 
       g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029, 
       g_iscb_m.iscb051,g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033, 
       g_iscb_m.iscb074,g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037, 
       g_iscb_m.iscb076,g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080, 
       g_iscb_m.iscb081,g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044, 
       g_iscb_m.iscb045,g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtdp,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid, 
       g_iscb_m.iscbmoddt,g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt,g_iscb_m.iscbownid_desc,g_iscb_m.iscbowndp_desc, 
       g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aist403_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_iscb_m_mask_o.* =  g_iscb_m.*
   CALL aist403_iscb_t_mask()
   LET g_iscb_m_mask_n.* =  g_iscb_m.*
   
   #將最新資料顯示到畫面上
   CALL aist403_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aist403_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM iscb_t 
       WHERE iscbent = g_enterprise AND iscbcomp = g_iscb_m.iscbcomp 
         AND iscbsite = g_iscb_m.iscbsite 
         AND iscb200 = g_iscb_m.iscb200 
         AND iscb201 = g_iscb_m.iscb201 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "iscb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_iscb_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aist403_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aist403_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aist403_browser_fill(g_wc,"")
         CALL aist403_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aist403_cl
 
   #功能已完成,通報訊息中心
   CALL aist403_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aist403.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aist403_ui_browser_refresh()
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
      IF g_browser[l_i].b_iscbcomp = g_iscb_m.iscbcomp
         AND g_browser[l_i].b_iscbsite = g_iscb_m.iscbsite
         AND g_browser[l_i].b_iscb200 = g_iscb_m.iscb200
         AND g_browser[l_i].b_iscb201 = g_iscb_m.iscb201
 
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
 
{<section id="aist403.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aist403_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("iscbcomp,iscbsite,iscb200,iscb201",TRUE)
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
 
{<section id="aist403.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aist403_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("iscbcomp,iscbsite,iscb200,iscb201",FALSE)
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
 
{<section id="aist403.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aist403_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aist403.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aist403_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_iscb_m.iscbstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   END IF 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aist403.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aist403_default_search()
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
      LET ls_wc = ls_wc, " iscbcomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " iscbsite = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " iscb200 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " iscb201 = '", g_argv[04], "' AND "
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
 
{<section id="aist403.mask_functions" >}
&include "erp/ais/aist403_mask.4gl"
 
{</section>}
 
{<section id="aist403.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aist403_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   CALL aist403_mod()RETURNING g_sub_success
   IF NOT g_sub_success THEN RETURN END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_iscb_m.iscbcomp IS NULL
      OR g_iscb_m.iscbsite IS NULL      OR g_iscb_m.iscb200 IS NULL      OR g_iscb_m.iscb201 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aist403_cl USING g_enterprise,g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201
   IF STATUS THEN
      CLOSE aist403_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aist403_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aist403_master_referesh USING g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201 INTO g_iscb_m.iscbsite, 
       g_iscb_m.iscbcomp,g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus, 
       g_iscb_m.iscb001,g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021, 
       g_iscb_m.iscb025,g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014, 
       g_iscb_m.iscb018,g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016, 
       g_iscb_m.iscb020,g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023, 
       g_iscb_m.iscb082,g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106, 
       g_iscb_m.iscb107,g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112, 
       g_iscb_m.iscb113,g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054, 
       g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062, 
       g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029, 
       g_iscb_m.iscb051,g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033, 
       g_iscb_m.iscb074,g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037, 
       g_iscb_m.iscb076,g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080, 
       g_iscb_m.iscb081,g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044, 
       g_iscb_m.iscb045,g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtdp,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid, 
       g_iscb_m.iscbmoddt,g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt,g_iscb_m.iscbownid_desc,g_iscb_m.iscbowndp_desc, 
       g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aist403_action_chk() THEN
      CLOSE aist403_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_iscb_m.iscbsite,g_iscb_m.iscbsite_desc,g_iscb_m.iscbcomp,g_iscb_m.iscbcomp_desc, 
       g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus,g_iscb_m.iscb001, 
       g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021,g_iscb_m.iscb025, 
       g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014,g_iscb_m.iscb018, 
       g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016,g_iscb_m.iscb020, 
       g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023,g_iscb_m.iscb082, 
       g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106,g_iscb_m.iscb107, 
       g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112,g_iscb_m.iscb113, 
       g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054,g_iscb_m.iscb055, 
       g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062,g_iscb_m.iscb063, 
       g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029,g_iscb_m.iscb051, 
       g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033,g_iscb_m.iscb074, 
       g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037,g_iscb_m.iscb076, 
       g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080,g_iscb_m.iscb081, 
       g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044,g_iscb_m.iscb045, 
       g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid,g_iscb_m.iscbownid_desc, 
       g_iscb_m.iscbowndp,g_iscb_m.iscbowndp_desc,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp, 
       g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbmoddt, 
       g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfid_desc,g_iscb_m.iscbcnfdt
 
   CASE g_iscb_m.iscbstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_iscb_m.iscbstus
            
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
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
   IF (lc_state <> "Y" 
      AND lc_state <> "N"
      AND lc_state <> "X"
      ) OR 
      g_iscb_m.iscbstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aist403_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF lc_state = 'Y' THEN
      CALL s_transaction_begin()
      LET g_iscb_m.iscbcnfid = g_user
      LET g_iscb_m.iscbcnfdt = cl_get_current()
      UPDATE iscb_t 
         SET (iscbstus,iscbcnfid,iscbcnfdt) 
           = ('Y',g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt )     
       WHERE iscbent = g_enterprise AND iscbcomp = g_iscb_m.iscbcomp
         AND iscbsite = g_iscb_m.iscbsite      AND iscb200 = g_iscb_m.iscb200      AND iscb201 = g_iscb_m.iscb201 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN                            #150401-00001#13
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
   END IF
   
   IF lc_state = 'N' THEN   
      LET g_iscb_m.iscbcnfid = ''
      LET g_iscb_m.iscbcnfdt = ''
       UPDATE iscb_t 
         SET (iscbstus,iscbcnfid,iscbcnfdt) 
           = ('N',g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt )     
       WHERE iscbent = g_enterprise AND iscbcomp = g_iscb_m.iscbcomp
         AND iscbsite = g_iscb_m.iscbsite      AND iscb200 = g_iscb_m.iscb200      AND iscb201 = g_iscb_m.iscb201
      CALL s_transaction_begin()         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')  
         RETURN                            #150401-00001#13
      ELSE
         CALL s_transaction_end('Y','0')          
      END IF
   END IF
   
   #151125-00001#3 ---add (S)---
   IF lc_state = "X" THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #151125-00001#3 ---add (E)---
   #end add-point
   
   LET g_iscb_m.iscbmodid = g_user
   LET g_iscb_m.iscbmoddt = cl_get_current()
   LET g_iscb_m.iscbstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE iscb_t 
      SET (iscbstus,iscbmodid,iscbmoddt) 
        = (g_iscb_m.iscbstus,g_iscb_m.iscbmodid,g_iscb_m.iscbmoddt)     
    WHERE iscbent = g_enterprise AND iscbcomp = g_iscb_m.iscbcomp
      AND iscbsite = g_iscb_m.iscbsite      AND iscb200 = g_iscb_m.iscb200      AND iscb201 = g_iscb_m.iscb201
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aist403_master_referesh USING g_iscb_m.iscbcomp,g_iscb_m.iscbsite,g_iscb_m.iscb200,g_iscb_m.iscb201 INTO g_iscb_m.iscbsite, 
          g_iscb_m.iscbcomp,g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus, 
          g_iscb_m.iscb001,g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021, 
          g_iscb_m.iscb025,g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014, 
          g_iscb_m.iscb018,g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016, 
          g_iscb_m.iscb020,g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023, 
          g_iscb_m.iscb082,g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106, 
          g_iscb_m.iscb107,g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112, 
          g_iscb_m.iscb113,g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054, 
          g_iscb_m.iscb055,g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062, 
          g_iscb_m.iscb063,g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029, 
          g_iscb_m.iscb051,g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033, 
          g_iscb_m.iscb074,g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037, 
          g_iscb_m.iscb076,g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080, 
          g_iscb_m.iscb081,g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044, 
          g_iscb_m.iscb045,g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid, 
          g_iscb_m.iscbowndp,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtdp,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid, 
          g_iscb_m.iscbmoddt,g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfdt,g_iscb_m.iscbownid_desc,g_iscb_m.iscbowndp_desc, 
          g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_iscb_m.iscbsite,g_iscb_m.iscbsite_desc,g_iscb_m.iscbcomp,g_iscb_m.iscbcomp_desc, 
          g_iscb_m.iscb200,g_iscb_m.iscb201,g_iscb_m.iscb202,g_iscb_m.iscb050,g_iscb_m.iscbstus,g_iscb_m.iscb001, 
          g_iscb_m.iscb005,g_iscb_m.iscb009,g_iscb_m.iscb013,g_iscb_m.iscb017,g_iscb_m.iscb021,g_iscb_m.iscb025, 
          g_iscb_m.iscb027,g_iscb_m.iscb002,g_iscb_m.iscb006,g_iscb_m.iscb010,g_iscb_m.iscb014,g_iscb_m.iscb018, 
          g_iscb_m.iscb022,g_iscb_m.iscb004,g_iscb_m.iscb008,g_iscb_m.iscb012,g_iscb_m.iscb016,g_iscb_m.iscb020, 
          g_iscb_m.iscb024,g_iscb_m.iscb007,g_iscb_m.iscb015,g_iscb_m.iscb019,g_iscb_m.iscb023,g_iscb_m.iscb082, 
          g_iscb_m.iscb101,g_iscb_m.iscb103,g_iscb_m.iscb104,g_iscb_m.iscb105,g_iscb_m.iscb106,g_iscb_m.iscb107, 
          g_iscb_m.iscb108,g_iscb_m.iscb109,g_iscb_m.iscb110,g_iscb_m.iscb111,g_iscb_m.iscb112,g_iscb_m.iscb113, 
          g_iscb_m.iscb114,g_iscb_m.iscb115,g_iscb_m.iscb052,g_iscb_m.iscb053,g_iscb_m.iscb054,g_iscb_m.iscb055, 
          g_iscb_m.iscb056,g_iscb_m.iscb057,g_iscb_m.iscb060,g_iscb_m.iscb061,g_iscb_m.iscb062,g_iscb_m.iscb063, 
          g_iscb_m.iscb064,g_iscb_m.iscb065,g_iscb_m.iscb066,g_iscb_m.iscb028,g_iscb_m.iscb029,g_iscb_m.iscb051, 
          g_iscb_m.iscb030,g_iscb_m.iscb031,g_iscb_m.iscb073,g_iscb_m.iscb032,g_iscb_m.iscb033,g_iscb_m.iscb074, 
          g_iscb_m.iscb034,g_iscb_m.iscb035,g_iscb_m.iscb075,g_iscb_m.iscb036,g_iscb_m.iscb037,g_iscb_m.iscb076, 
          g_iscb_m.iscb038,g_iscb_m.iscb039,g_iscb_m.iscb078,g_iscb_m.iscb079,g_iscb_m.iscb080,g_iscb_m.iscb081, 
          g_iscb_m.iscb040,g_iscb_m.iscb041,g_iscb_m.iscb042,g_iscb_m.iscb043,g_iscb_m.iscb044,g_iscb_m.iscb045, 
          g_iscb_m.iscb046,g_iscb_m.iscb047,g_iscb_m.iscb048,g_iscb_m.iscb049,g_iscb_m.iscbownid,g_iscb_m.iscbownid_desc, 
          g_iscb_m.iscbowndp,g_iscb_m.iscbowndp_desc,g_iscb_m.iscbcrtid,g_iscb_m.iscbcrtid_desc,g_iscb_m.iscbcrtdp, 
          g_iscb_m.iscbcrtdp_desc,g_iscb_m.iscbcrtdt,g_iscb_m.iscbmodid,g_iscb_m.iscbmodid_desc,g_iscb_m.iscbmoddt, 
          g_iscb_m.iscbcnfid,g_iscb_m.iscbcnfid_desc,g_iscb_m.iscbcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aist403_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aist403_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aist403.signature" >}
   
 
{</section>}
 
{<section id="aist403.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aist403_set_pk_array()
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
   LET g_pk_array[1].values = g_iscb_m.iscbcomp
   LET g_pk_array[1].column = 'iscbcomp'
   LET g_pk_array[2].values = g_iscb_m.iscbsite
   LET g_pk_array[2].column = 'iscbsite'
   LET g_pk_array[3].values = g_iscb_m.iscb200
   LET g_pk_array[3].column = 'iscb200'
   LET g_pk_array[4].values = g_iscb_m.iscb201
   LET g_pk_array[4].column = 'iscb201'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aist403.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aist403.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aist403_msgcentre_notify(lc_state)
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
   CALL aist403_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_iscb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aist403.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aist403_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#19 add-S
   SELECT iscbstus  INTO g_iscb_m.iscbstus
     FROM iscb_t
    WHERE iscbent = g_enterprise
      AND iscbcomp = g_iscb_m.iscbcomp
      AND iscbsite = g_iscb_m.iscbsite
      AND iscb200 = g_iscb_m.iscb200
      AND iscd201 = g_iscb_m.iscb201

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
    LET g_errno = NULL    
    CASE g_iscb_m.iscbstus
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
        LET g_errparam.extend = g_iscb_m.iscbcomp
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aist403_set_act_visible()
        CALL aist403_set_act_no_visible()
        CALL aist403_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#19 add-E
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aist403.other_function" readonly="Y" >}

################################################################################
#Descriptions...: 能否修改
# Memo...........:
# Usage..........: CALL aist403_mod()
# Date & Author..: 2015/04/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aist403_mod()
DEFINE l_isaa012 LIKE isaa_t.isaa012
DEFINE l_isaa013 LIKE isaa_t.isaa013
DEFINE l_day1    LIKE type_t.dat
DEFINE l_day2    LIKE type_t.dat   
DEFINE r_success LIKE type_t.chr1

   LET r_success = TRUE

   SELECT isaa012,isaa013 
     INTO l_isaa012,l_isaa013
     FROM isaa_t
    WHERE isaaent = g_enterprise
      AND isaa001 = g_iscb_m.iscbsite
   
   IF NOT cl_null(l_isaa012) THEN
      IF g_iscb_m.iscb200 < l_isaa012 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ais-00198'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT cl_null(l_isaa013) THEN
         LET l_day1= MDY(g_iscb_m.iscb201,1,g_iscb_m.iscb200)
         LET l_day2= MDY(l_isaa013,1,l_isaa012)
         IF l_day1 <= l_day2 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ais-00198'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 合計(1)=(2)+(3)+(4)
# Memo...........:
# Usage..........: CALL aist430_sum_isca701()
# Date & Author..: 2015/04/17 By Hans
# Modify.........:##########################################################
PRIVATE FUNCTION aist403_sum_isca701()
DEFINE r_isca701     LIKE isca_t.isca701
DEFINE r_amt         LIKE isca_t.isca801

   LET r_isca701 = 0
   LET r_isca701 = g_isca_m.isca702 + g_isca_m.isca703 + g_isca_m.isca704 +
                   g_isca_m.isca705 + g_isca_m.isca707 +
                   g_isca_m.isca706 + g_isca_m.isca708
   #重新計算應納營業稅稅額
   CALL aist403_recount() RETURNING r_amt

   RETURN r_isca701,r_amt
END FUNCTION

################################################################################
# Descriptions...: 合計(5)=(6)+(7)
# Memo...........:
# Usage..........: CALL aist430_sum_isca805()
# Date & Author..: 2015/03/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aist403_sum_isca805()
DEFINE r_isca805     LIKE isca_t.isca805

   LET r_isca805 = 0
   LET r_isca805 = g_isca_m.isca806 + g_isca_m.isca807 +
                   g_isca_m.isca801 + g_isca_m.isca803 +
                   g_isca_m.isca802 + g_isca_m.isca804

   RETURN r_isca805
END FUNCTION

################################################################################
# Descriptions...: 重新計算應納營業稅稅額
# Memo...........:
# Usage..........: CALL aist430_recount()
# Date & Author..: 2015/03/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aist403_recount()
DEFINE r_amt         LIKE isca_t.isca801 
   
   LET r_amt = 0
   
   #g(1%)
   IF INFIELD (isca702) THEN
      LET r_amt = g_isca_m.isca702 * 0.01
   END IF
   #h(2%)
   IF INFIELD (isca705) THEN
      LET r_amt = g_isca_m.isca705 * 0.02
   END IF
   #i(5%)
   IF INFIELD (isca706) THEN
      LET r_amt = g_isca_m.isca706 * 0.05
   END IF
   
   #j(1%)
   IF INFIELD (isca703) THEN
      LET r_amt = g_isca_m.isca703 * g_iscb_m.iscb050 * 0.01 * 0.01
   END IF
   #k(2%)
   IF INFIELD (isca707) THEN
      LET r_amt = g_isca_m.isca707 * g_iscb_m.iscb050 * 0.01 * 0.02
   END IF
   #l(5%)
   IF INFIELD (isca708) THEN
      LET r_amt = g_isca_m.isca708 * g_iscb_m.iscb050 * 0.01 * 0.05
   END IF

   CALL s_num_round(3,r_amt,0) RETURNING r_amt
   
   RETURN r_amt
END FUNCTION

################################################################################
# Descriptions...: 稅額檢查
# Memo...........:
# Usage..........: CALL aist430_chk_rate()
# Date & Author..: 2015/04/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aist403_chk_rate()
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      LIKE gzze_t.gzze001
DEFINE l_stand      LIKE isca_t.isca806
DEFINE l_diff       LIKE isca_t.isca806
   
   LET r_success = TRUE
   LET r_errno = ""

   #稅額容差範圍為1
   LET l_stand = 0
   LET l_diff = 0
   #g(1%)
   IF INFIELD (isca806) THEN
      LET l_stand = g_isca_m.isca702 * 0.01
      CALL s_num_round(3,l_stand,0) RETURNING l_stand
      LET l_diff = s_math_abs(g_isca_m.isca806 - l_stand)
   END IF
   #h(2%)
   IF INFIELD (isca801) THEN
      LET l_stand = g_isca_m.isca705 * 0.02
      CALL s_num_round(3,l_stand,0) RETURNING l_stand
      LET l_diff = s_math_abs(g_isca_m.isca801 - l_stand)
   END IF
   #i(5%)
   IF INFIELD (isca802) THEN
      LET l_stand = g_isca_m.isca706 * 0.05
      CALL s_num_round(3,l_stand,0) RETURNING l_stand
      LET l_diff = s_math_abs(g_isca_m.isca802 - l_stand)
   END IF
   
   #j(1%)
   IF INFIELD (isca807) THEN
      LET l_stand = g_isca_m.isca703 * g_iscb_m.iscb050 * 0.01 * 0.01
      CALL s_num_round(3,l_stand,0) RETURNING l_stand
      LET l_diff = s_math_abs(g_isca_m.isca807 - l_stand)
   END IF
   #k(2%)
   IF INFIELD (isca803) THEN
      LET l_stand = g_isca_m.isca707 * g_iscb_m.iscb050 * 0.01 * 0.02
      CALL s_num_round(3,l_stand,0) RETURNING l_stand
      LET l_diff = s_math_abs(g_isca_m.isca803 - l_stand)
   END IF
   #l(5%)
   IF INFIELD (isca804) THEN
      LET l_stand = g_isca_m.isca708 * g_iscb_m.iscb050 * 0.01 * 0.05
      CALL s_num_round(3,l_stand,0) RETURNING l_stand
      LET l_diff = s_math_abs(g_isca_m.isca804 - l_stand)
   END IF
   
   IF l_diff > 1 THEN
      LET r_errno = "ais-00192"
      LET r_success = FALSE
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 重計算iscb065
# Memo...........:
# Usage..........: CALL aist403_sum_iscb065()
# Date & Author..: 2015/04/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aist403_sum_iscb065()
  
   LET g_iscb_m.iscb065 = g_iscb_m.iscb052 + g_iscb_m.iscb054 + g_iscb_m.iscb056 
                        + g_iscb_m.iscb060 + g_iscb_m.iscb062 + g_iscb_m.iscb063
   #iscb025重算                     
   LET g_iscb_m.iscb025 = g_iscb_m.iscb021 + g_iscb_m.iscb023
                        + g_iscb_m.iscb024 + g_iscb_m.iscb065
                             
   DISPLAY BY NAME g_iscb_m.iscb065,g_iscb_m.iscb025                      

END FUNCTION

################################################################################
# Descriptions...: 重新計算iscb066
# Memo...........:
# Usage..........: CALL aist403_sum_iscb066()
# Date & Author..: 2015/04/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aist403_sum_iscb066()
   
   
   LET g_iscb_m.iscb066 = g_iscb_m.iscb053 + g_iscb_m.iscb055 + g_iscb_m.iscb057
                        + g_iscb_m.iscb061 + g_iscb_m.iscb064
                        
   DISPLAY BY NAME g_iscb_m.iscb066

END FUNCTION

 
{</section>}
 
