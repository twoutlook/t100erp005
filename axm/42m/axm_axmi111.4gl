#該程式未解開Section, 採用最新樣板產出!
{<section id="axmi111.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-06-29 15:33:50), PR版次:0011(2016-11-14 12:14:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000349
#+ Filename...: axmi111
#+ Description: 銷售控制組客戶預設條件設定作業
#+ Creator....: 02332(2014-01-21 18:06:25)
#+ Modifier...: 02749 -SD/PR- 08993
 
{</section>}
 
{<section id="axmi111.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#35   2016/04/15 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160902-00048#2   2016/09/06  By 02097       針對SQL的WHERE條件中缺少ent的清單做補強
#161109-00085#11  2016/11/10  By 08993       整批調整系統星號寫法
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
PRIVATE TYPE type_g_xmae_m RECORD
       xmae002 LIKE xmae_t.xmae002, 
   xmae001 LIKE xmae_t.xmae001, 
   xmae002_desc LIKE type_t.chr80, 
   xmae001_desc LIKE type_t.chr80, 
   xmae003 LIKE xmae_t.xmae003, 
   xmae003_desc LIKE type_t.chr80, 
   xmae004 LIKE xmae_t.xmae004, 
   xmae004_desc LIKE type_t.chr80, 
   xmae020 LIKE xmae_t.xmae020, 
   xmae020_desc LIKE type_t.chr80, 
   xmae021 LIKE xmae_t.xmae021, 
   xmae021_desc LIKE type_t.chr80, 
   xmae022 LIKE xmae_t.xmae022, 
   xmae022_desc LIKE type_t.chr80, 
   xmae006 LIKE xmae_t.xmae006, 
   xmae006_desc LIKE type_t.chr80, 
   xmae008 LIKE xmae_t.xmae008, 
   xmae008_desc LIKE type_t.chr80, 
   xmae009 LIKE xmae_t.xmae009, 
   xmae009_desc LIKE type_t.chr80, 
   xmae023 LIKE xmae_t.xmae023, 
   xmae024 LIKE xmae_t.xmae024, 
   xmae010 LIKE xmae_t.xmae010, 
   xmae011 LIKE xmae_t.xmae011, 
   xmae011_desc LIKE type_t.chr80, 
   xmae012 LIKE xmae_t.xmae012, 
   xmae012_desc LIKE type_t.chr80, 
   xmae013 LIKE xmae_t.xmae013, 
   xmae013_desc LIKE type_t.chr80, 
   xmae014 LIKE xmae_t.xmae014, 
   xmae014_desc LIKE type_t.chr80, 
   xmae015 LIKE xmae_t.xmae015, 
   xmae016 LIKE xmae_t.xmae016, 
   xmae017 LIKE xmae_t.xmae017, 
   xmae017_desc LIKE type_t.chr80, 
   xmae018 LIKE xmae_t.xmae018, 
   xmae019 LIKE xmae_t.xmae019, 
   xmae019_desc LIKE type_t.chr80, 
   xmae025 LIKE xmae_t.xmae025, 
   xmae025_desc LIKE type_t.chr80, 
   xmaeownid LIKE xmae_t.xmaeownid, 
   xmaeownid_desc LIKE type_t.chr80, 
   xmaeowndp LIKE xmae_t.xmaeowndp, 
   xmaeowndp_desc LIKE type_t.chr80, 
   xmaecrtid LIKE xmae_t.xmaecrtid, 
   xmaecrtid_desc LIKE type_t.chr80, 
   xmaecrtdp LIKE xmae_t.xmaecrtdp, 
   xmaecrtdp_desc LIKE type_t.chr80, 
   xmaecrtdt LIKE xmae_t.xmaecrtdt, 
   xmaemodid LIKE xmae_t.xmaemodid, 
   xmaemodid_desc LIKE type_t.chr80, 
   xmaemoddt LIKE xmae_t.xmaemoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_xmae001 LIKE xmae_t.xmae001,
   b_xmae001_desc LIKE type_t.chr80,
   b_xmae001_desc_desc LIKE type_t.chr80,
      b_xmae002 LIKE xmae_t.xmae002,
   b_xmae002_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_apcacomp            LIKE apca_t.apcacomp
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_ooef019             LIKE ooef_t.ooef019
DEFINE g_ooef014             LIKE ooef_t.ooef014

#161109-00085#11-mod-s
#DEFINE g_glaa_t              RECORD LIKE glaa_t.*   #161109-00085#11 mark
DEFINE g_glaa_t              RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028 #匯率來源
          END RECORD
#161109-00085#11-mod-e
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmae_m        type_g_xmae_m  #單頭變數宣告
DEFINE g_xmae_m_t      type_g_xmae_m  #單頭舊值宣告(系統還原用)
DEFINE g_xmae_m_o      type_g_xmae_m  #單頭舊值宣告(其他用途)
DEFINE g_xmae_m_mask_o type_g_xmae_m  #轉換遮罩前資料
DEFINE g_xmae_m_mask_n type_g_xmae_m  #轉換遮罩後資料
 
   DEFINE g_xmae002_t LIKE xmae_t.xmae002
DEFINE g_xmae001_t LIKE xmae_t.xmae001
 
   
 
   
 
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
 
{<section id="axmi111.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
     
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xmae002,xmae001,'','',xmae003,'',xmae004,'',xmae020,'',xmae021,'',xmae022, 
       '',xmae006,'',xmae008,'',xmae009,'',xmae023,xmae024,xmae010,xmae011,'',xmae012,'',xmae013,'', 
       xmae014,'',xmae015,xmae016,xmae017,'',xmae018,xmae019,'',xmae025,'',xmaeownid,'',xmaeowndp,'', 
       xmaecrtid,'',xmaecrtdp,'',xmaecrtdt,xmaemodid,'',xmaemoddt", 
                      " FROM xmae_t",
                      " WHERE xmaeent= ? AND xmae001=? AND xmae002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmi111_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xmae002,t0.xmae001,t0.xmae003,t0.xmae004,t0.xmae020,t0.xmae021,t0.xmae022, 
       t0.xmae006,t0.xmae008,t0.xmae009,t0.xmae023,t0.xmae024,t0.xmae010,t0.xmae011,t0.xmae012,t0.xmae013, 
       t0.xmae014,t0.xmae015,t0.xmae016,t0.xmae017,t0.xmae018,t0.xmae019,t0.xmae025,t0.xmaeownid,t0.xmaeowndp, 
       t0.xmaecrtid,t0.xmaecrtdp,t0.xmaecrtdt,t0.xmaemodid,t0.xmaemoddt,t1.oohal003 ,t2.pmaal003 ,t3.ooail003 , 
       t4.oocql004 ,t5.xmahl003 ,t6.ooibl004 ,t7.oojdl003 ,t8.oocql004 ,t9.oocql004 ,t10.oocql004 ,t11.pmaal004 , 
       t12.ooag011 ,t13.ooefl003 ,t14.ooag011 ,t15.ooefl003 ,t16.ooag011 ,t17.ooefl003 ,t18.ooag011", 
 
               " FROM xmae_t t0",
                              " LEFT JOIN oohal_t t1 ON t1.oohalent="||g_enterprise||" AND t1.oohal001=t0.xmae002 AND t1.oohal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.xmae001 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=t0.xmae003 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='238' AND t4.oocql002=t0.xmae020 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN xmahl_t t5 ON t5.xmahlent="||g_enterprise||" AND t5.xmahl001=t0.xmae021 AND t5.xmahl002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t6 ON t6.ooiblent="||g_enterprise||" AND t6.ooibl002=t0.xmae006 AND t6.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t7 ON t7.oojdlent="||g_enterprise||" AND t7.oojdl001=t0.xmae008 AND t7.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='295' AND t8.oocql002=t0.xmae008 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='263' AND t9.oocql002=t0.xmae011 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='262' AND t10.oocql002=t0.xmae014 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t11 ON t11.pmaalent="||g_enterprise||" AND t11.pmaal001=t0.xmae017 AND t11.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.xmae019  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.xmae025 AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.xmaeownid  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=t0.xmaeowndp AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.xmaecrtid  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=t0.xmaecrtdp AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=t0.xmaemodid  ",
 
               " WHERE t0.xmaeent = " ||g_enterprise|| " AND t0.xmae001 = ? AND t0.xmae002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmi111_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmi111 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmi111_init()   
 
      #進入選單 Menu (="N")
      CALL axmi111_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmi111
      
   END IF 
   
   CLOSE axmi111_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmi111.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmi111_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
      CALL axmi111_xmae010_comb()
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
   
      CALL cl_set_combo_scc('xmae023','2085') 
   CALL cl_set_combo_scc('xmae024','2084') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
      SELECT DISTINCT ooef019,ooef014 INTO g_ooef019,g_ooef014 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site

   #end add-point
   
   #根據外部參數進行搜尋
   CALL axmi111_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="axmi111.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmi111_ui_dialog() 
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
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL axmi111_insert()
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
         INITIALIZE g_xmae_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL axmi111_init()
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
               CALL axmi111_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL axmi111_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
 
 
               
            #第一筆資料
            ON ACTION first
               CALL axmi111_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL axmi111_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL axmi111_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL axmi111_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL axmi111_fetch("L")  
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
                  CALL axmi111_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axmi111_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axmi111_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axmi111_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmi111_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmi111_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
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
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmi111_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmi111_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmi111_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmi111_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmi111_set_pk_array()
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
                  CALL axmi111_fetch("")
 
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
                  CALL axmi111_browser_fill(g_wc,"")
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
                  CALL axmi111_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
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
               CALL axmi111_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL axmi111_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL axmi111_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL axmi111_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL axmi111_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL axmi111_fetch("L")  
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
                  CALL axmi111_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axmi111_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axmi111_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axmi111_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmi111_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmi111_insert()
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
               CALL axmi111_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmi111_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmi111_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmi111_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmi111_set_pk_array()
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
 
{<section id="axmi111.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION axmi111_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "xmae001,xmae002"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM xmae_t ",
               "  ",
               "  ",
               " WHERE xmaeent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("xmae_t")
                
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
      INITIALIZE g_xmae_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.xmaestus,t0.xmae001,t0.xmae002,t1.pmaal004 ,t2.pmaal003 ,t3.oohal003",
               " FROM xmae_t t0 ",
               "  ",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.xmae001 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.xmae001 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oohal_t t3 ON t3.oohalent="||g_enterprise||" AND t3.oohal001=t0.xmae002 AND t3.oohal002='"||g_dlang||"' ",
 
               " WHERE t0.xmaeent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("xmae_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmae_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xmae001,g_browser[g_cnt].b_xmae002, 
          g_browser[g_cnt].b_xmae001_desc,g_browser[g_cnt].b_xmae001_desc_desc,g_browser[g_cnt].b_xmae002_desc 
 
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
         CALL axmi111_browser_mask()
         
         
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
   
   IF cl_null(g_browser[g_cnt].b_xmae001) THEN
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
 
{<section id="axmi111.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmi111_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
      DEFINE g_chose        STRING
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_xmae_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON xmae002,xmae001,xmae003,xmae004,xmae004_desc,xmae020,xmae021,xmae022, 
          xmae022_desc,xmae006,xmae008,xmae009,xmae023,xmae024,xmae010,xmae011,xmae012,xmae012_desc, 
          xmae013,xmae013_desc,xmae014,xmae015,xmae016,xmae017,xmae018,xmae019,xmae025,xmaeownid,xmaeowndp, 
          xmaecrtid,xmaecrtdp,xmaecrtdt,xmaemodid,xmaemoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
                        LET g_chose = ''
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmaecrtdt>>----
         AFTER FIELD xmaecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmaemoddt>>----
         AFTER FIELD xmaemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmaecnfdt>>----
         
         #----<<xmaepstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.xmae002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae002
            #add-point:ON ACTION controlp INFIELD xmae002 name="construct.c.xmae002"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooha001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae002  #顯示到畫面上

            NEXT FIELD xmae002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae002
            #add-point:BEFORE FIELD xmae002 name="construct.b.xmae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae002
            
            #add-point:AFTER FIELD xmae002 name="construct.a.xmae002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae001
            #add-point:ON ACTION controlp INFIELD xmae001 name="construct.c.xmae001"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            #ming 20141120 add ------------------------(S) 
            LET g_qryparam.arg1 = g_site
            #ming 20141120 add ------------------------(E) 
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae001  #顯示到畫面上

            NEXT FIELD xmae001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae001
            #add-point:BEFORE FIELD xmae001 name="construct.b.xmae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae001
            
            #add-point:AFTER FIELD xmae001 name="construct.a.xmae001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae003
            #add-point:ON ACTION controlp INFIELD xmae003 name="construct.c.xmae003"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1=g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae003  #顯示到畫面上

            NEXT FIELD xmae003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae003
            #add-point:BEFORE FIELD xmae003 name="construct.b.xmae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae003
            
            #add-point:AFTER FIELD xmae003 name="construct.a.xmae003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae004
            #add-point:ON ACTION controlp INFIELD xmae004 name="construct.c.xmae004"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_ooef019
            CALL q_oodb002_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae004  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oodb002 #稅別代碼 
               #DISPLAY g_qryparam.return3 TO oodb005 #含稅否 
               #DISPLAY g_qryparam.return4 TO oodb006 #稅率 

            NEXT FIELD xmae004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae004
            #add-point:BEFORE FIELD xmae004 name="construct.b.xmae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae004
            
            #add-point:AFTER FIELD xmae004 name="construct.a.xmae004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae004_desc
            #add-point:BEFORE FIELD xmae004_desc name="construct.b.xmae004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae004_desc
            
            #add-point:AFTER FIELD xmae004_desc name="construct.a.xmae004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae004_desc
            #add-point:ON ACTION controlp INFIELD xmae004_desc name="construct.c.xmae004_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmae020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae020
            #add-point:ON ACTION controlp INFIELD xmae020 name="construct.c.xmae020"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae020  #顯示到畫面上

            NEXT FIELD xmae020                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae020
            #add-point:BEFORE FIELD xmae020 name="construct.b.xmae020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae020
            
            #add-point:AFTER FIELD xmae020 name="construct.a.xmae020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae021
            #add-point:ON ACTION controlp INFIELD xmae021 name="construct.c.xmae021"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_xmah001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae021  #顯示到畫面上

            NEXT FIELD xmae021                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae021
            #add-point:BEFORE FIELD xmae021 name="construct.b.xmae021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae021
            
            #add-point:AFTER FIELD xmae021 name="construct.a.xmae021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae022
            #add-point:ON ACTION controlp INFIELD xmae022 name="construct.c.xmae022"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_ooef019 #
            LET g_qryparam.arg2 = '2'
            CALL q_isac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae022  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO isac002 #發票類型 

            NEXT FIELD xmae022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae022
            #add-point:BEFORE FIELD xmae022 name="construct.b.xmae022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae022
            
            #add-point:AFTER FIELD xmae022 name="construct.a.xmae022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae022_desc
            #add-point:BEFORE FIELD xmae022_desc name="construct.b.xmae022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae022_desc
            
            #add-point:AFTER FIELD xmae022_desc name="construct.a.xmae022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae022_desc
            #add-point:ON ACTION controlp INFIELD xmae022_desc name="construct.c.xmae022_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmae006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae006
            #add-point:ON ACTION controlp INFIELD xmae006 name="construct.c.xmae006"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmad002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae006  #顯示到畫面上

            NEXT FIELD xmae006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae006
            #add-point:BEFORE FIELD xmae006 name="construct.b.xmae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae006
            
            #add-point:AFTER FIELD xmae006 name="construct.a.xmae006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae008
            #add-point:ON ACTION controlp INFIELD xmae008 name="construct.c.xmae008"
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #160621-00003#6 160629 by lori mark ad add---(S)
            #CALL q_oocq002_7()
            
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001()            
            #160621-00003#6 160629 by lori mark ad add---(E)
            
            DISPLAY g_qryparam.return1 TO xmae008 
                                                   
            NEXT FIELD xmae008                     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae008
            #add-point:BEFORE FIELD xmae008 name="construct.b.xmae008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae008
            
            #add-point:AFTER FIELD xmae008 name="construct.a.xmae008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae009
            #add-point:ON ACTION controlp INFIELD xmae009 name="construct.c.xmae009"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae009  #顯示到畫面上

            NEXT FIELD xmae009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae009
            #add-point:BEFORE FIELD xmae009 name="construct.b.xmae009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae009
            
            #add-point:AFTER FIELD xmae009 name="construct.a.xmae009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae023
            #add-point:BEFORE FIELD xmae023 name="construct.b.xmae023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae023
            
            #add-point:AFTER FIELD xmae023 name="construct.a.xmae023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae023
            #add-point:ON ACTION controlp INFIELD xmae023 name="construct.c.xmae023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae024
            #add-point:BEFORE FIELD xmae024 name="construct.b.xmae024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae024
            
            #add-point:AFTER FIELD xmae024 name="construct.a.xmae024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae024
            #add-point:ON ACTION controlp INFIELD xmae024 name="construct.c.xmae024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae010
            #add-point:BEFORE FIELD xmae010 name="construct.b.xmae010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae010
            
            #add-point:AFTER FIELD xmae010 name="construct.a.xmae010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae010
            #add-point:ON ACTION controlp INFIELD xmae010 name="construct.c.xmae010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmae011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae011
            #add-point:ON ACTION controlp INFIELD xmae011 name="construct.c.xmae011"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae011  #顯示到畫面上
            LET g_chose = g_qryparam.return1
            NEXT FIELD xmae011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae011
            #add-point:BEFORE FIELD xmae011 name="construct.b.xmae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae011
            
            #add-point:AFTER FIELD xmae011 name="construct.a.xmae011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae012
            #add-point:ON ACTION controlp INFIELD xmae012 name="construct.c.xmae012"
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
            CASE 
               WHEN g_chose= '2' OR g_chose= '6' OR g_chose= '7' OR g_chose= 'H'
                   CALL q_oocq002_10()                           #呼叫開窗
               WHEN g_chose='5'
                   CALL q_oocq002_12()                           #呼叫開窗
               WHEN g_chose='0' OR g_chose='1' OR g_chose='3' OR g_chose='4'  OR g_chose='9' OR g_chose='A'  OR g_chose='W' OR g_chose='Y' OR g_chose='Z'
                   CALL q_oock003()                           #呼叫開窗
            END CASE
            DISPLAY g_qryparam.return1 TO xmae012  #顯示到畫面上                  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae012
            #add-point:BEFORE FIELD xmae012 name="construct.b.xmae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae012
            
            #add-point:AFTER FIELD xmae012 name="construct.a.xmae012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae012_desc
            #add-point:BEFORE FIELD xmae012_desc name="construct.b.xmae012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae012_desc
            
            #add-point:AFTER FIELD xmae012_desc name="construct.a.xmae012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae012_desc
            #add-point:ON ACTION controlp INFIELD xmae012_desc name="construct.c.xmae012_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmae013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae013
            #add-point:ON ACTION controlp INFIELD xmae013 name="construct.c.xmae013"
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
            CASE 
               WHEN g_chose= '2'
                   CALL q_oocq002_10()                           #呼叫開窗
               WHEN g_chose='5'
                   CALL q_oocq002_12()                           #呼叫開窗
               WHEN g_chose='0' OR g_chose='1' OR g_chose='3' OR g_chose='4' OR g_chose='6' OR g_chose='7' OR g_chose='9' OR g_chose='A' OR g_chose='H' OR g_chose='W' OR g_chose='Y' OR g_chose='Z'
                   CALL q_oock003()                           #呼叫開窗
            END CASE
            DISPLAY g_qryparam.return1 TO xmae013  #顯示到畫面上   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae013
            #add-point:BEFORE FIELD xmae013 name="construct.b.xmae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae013
            
            #add-point:AFTER FIELD xmae013 name="construct.a.xmae013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae013_desc
            #add-point:BEFORE FIELD xmae013_desc name="construct.b.xmae013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae013_desc
            
            #add-point:AFTER FIELD xmae013_desc name="construct.a.xmae013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae013_desc
            #add-point:ON ACTION controlp INFIELD xmae013_desc name="construct.c.xmae013_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmae014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae014
            #add-point:ON ACTION controlp INFIELD xmae014 name="construct.c.xmae014"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae014  #顯示到畫面上

            NEXT FIELD xmae014                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae014
            #add-point:BEFORE FIELD xmae014 name="construct.b.xmae014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae014
            
            #add-point:AFTER FIELD xmae014 name="construct.a.xmae014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae015
            #add-point:BEFORE FIELD xmae015 name="construct.b.xmae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae015
            
            #add-point:AFTER FIELD xmae015 name="construct.a.xmae015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae015
            #add-point:ON ACTION controlp INFIELD xmae015 name="construct.c.xmae015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae016
            #add-point:BEFORE FIELD xmae016 name="construct.b.xmae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae016
            
            #add-point:AFTER FIELD xmae016 name="construct.a.xmae016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae016
            #add-point:ON ACTION controlp INFIELD xmae016 name="construct.c.xmae016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmae017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae017
            #add-point:ON ACTION controlp INFIELD xmae017 name="construct.c.xmae017"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae017  #顯示到畫面上

            NEXT FIELD xmae017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae017
            #add-point:BEFORE FIELD xmae017 name="construct.b.xmae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae017
            
            #add-point:AFTER FIELD xmae017 name="construct.a.xmae017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae018
            #add-point:BEFORE FIELD xmae018 name="construct.b.xmae018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae018
            
            #add-point:AFTER FIELD xmae018 name="construct.a.xmae018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae018
            #add-point:ON ACTION controlp INFIELD xmae018 name="construct.c.xmae018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmae019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae019
            #add-point:ON ACTION controlp INFIELD xmae019 name="construct.c.xmae019"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae019  #顯示到畫面上

            NEXT FIELD xmae019                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae019
            #add-point:BEFORE FIELD xmae019 name="construct.b.xmae019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae019
            
            #add-point:AFTER FIELD xmae019 name="construct.a.xmae019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmae025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae025
            #add-point:ON ACTION controlp INFIELD xmae025 name="construct.c.xmae025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmae025  #顯示到畫面上
            NEXT FIELD xmae025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae025
            #add-point:BEFORE FIELD xmae025 name="construct.b.xmae025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae025
            
            #add-point:AFTER FIELD xmae025 name="construct.a.xmae025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmaeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaeownid
            #add-point:ON ACTION controlp INFIELD xmaeownid name="construct.c.xmaeownid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaeownid  #顯示到畫面上

            NEXT FIELD xmaeownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaeownid
            #add-point:BEFORE FIELD xmaeownid name="construct.b.xmaeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaeownid
            
            #add-point:AFTER FIELD xmaeownid name="construct.a.xmaeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmaeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaeowndp
            #add-point:ON ACTION controlp INFIELD xmaeowndp name="construct.c.xmaeowndp"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaeowndp  #顯示到畫面上

            NEXT FIELD xmaeowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaeowndp
            #add-point:BEFORE FIELD xmaeowndp name="construct.b.xmaeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaeowndp
            
            #add-point:AFTER FIELD xmaeowndp name="construct.a.xmaeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmaecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaecrtid
            #add-point:ON ACTION controlp INFIELD xmaecrtid name="construct.c.xmaecrtid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaecrtid  #顯示到畫面上

            NEXT FIELD xmaecrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaecrtid
            #add-point:BEFORE FIELD xmaecrtid name="construct.b.xmaecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaecrtid
            
            #add-point:AFTER FIELD xmaecrtid name="construct.a.xmaecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmaecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaecrtdp
            #add-point:ON ACTION controlp INFIELD xmaecrtdp name="construct.c.xmaecrtdp"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaecrtdp  #顯示到畫面上

            NEXT FIELD xmaecrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaecrtdp
            #add-point:BEFORE FIELD xmaecrtdp name="construct.b.xmaecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaecrtdp
            
            #add-point:AFTER FIELD xmaecrtdp name="construct.a.xmaecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaecrtdt
            #add-point:BEFORE FIELD xmaecrtdt name="construct.b.xmaecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmaemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaemodid
            #add-point:ON ACTION controlp INFIELD xmaemodid name="construct.c.xmaemodid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaemodid  #顯示到畫面上

            NEXT FIELD xmaemodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaemodid
            #add-point:BEFORE FIELD xmaemodid name="construct.b.xmaemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaemodid
            
            #add-point:AFTER FIELD xmaemodid name="construct.a.xmaemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaemoddt
            #add-point:BEFORE FIELD xmaemoddt name="construct.b.xmaemoddt"
            
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
 
{<section id="axmi111.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axmi111_filter()
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
      CONSTRUCT g_wc_filter ON xmae001,xmae002
                          FROM s_browse[1].b_xmae001,s_browse[1].b_xmae002
 
         BEFORE CONSTRUCT
               DISPLAY axmi111_filter_parser('xmae001') TO s_browse[1].b_xmae001
            DISPLAY axmi111_filter_parser('xmae002') TO s_browse[1].b_xmae002
      
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
 
      CALL axmi111_filter_show('xmae001')
   CALL axmi111_filter_show('xmae002')
 
END FUNCTION
 
{</section>}
 
{<section id="axmi111.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axmi111_filter_parser(ps_field)
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
 
{<section id="axmi111.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axmi111_filter_show(ps_field)
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
   LET ls_condition = axmi111_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmi111.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axmi111_query()
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
 
   INITIALIZE g_xmae_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL axmi111_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axmi111_browser_fill(g_wc,"F")
      CALL axmi111_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL axmi111_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL axmi111_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axmi111.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axmi111_fetch(p_fl)
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
   LET g_xmae_m.xmae001 = g_browser[g_current_idx].b_xmae001
   LET g_xmae_m.xmae002 = g_browser[g_current_idx].b_xmae002
 
                       
   #讀取單頭所有欄位資料
   EXECUTE axmi111_master_referesh USING g_xmae_m.xmae001,g_xmae_m.xmae002 INTO g_xmae_m.xmae002,g_xmae_m.xmae001, 
       g_xmae_m.xmae003,g_xmae_m.xmae004,g_xmae_m.xmae020,g_xmae_m.xmae021,g_xmae_m.xmae022,g_xmae_m.xmae006, 
       g_xmae_m.xmae008,g_xmae_m.xmae009,g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011, 
       g_xmae_m.xmae012,g_xmae_m.xmae013,g_xmae_m.xmae014,g_xmae_m.xmae015,g_xmae_m.xmae016,g_xmae_m.xmae017, 
       g_xmae_m.xmae018,g_xmae_m.xmae019,g_xmae_m.xmae025,g_xmae_m.xmaeownid,g_xmae_m.xmaeowndp,g_xmae_m.xmaecrtid, 
       g_xmae_m.xmaecrtdp,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid,g_xmae_m.xmaemoddt,g_xmae_m.xmae002_desc, 
       g_xmae_m.xmae001_desc,g_xmae_m.xmae003_desc,g_xmae_m.xmae020_desc,g_xmae_m.xmae021_desc,g_xmae_m.xmae006_desc, 
       g_xmae_m.xmae008_desc,g_xmae_m.xmae009_desc,g_xmae_m.xmae011_desc,g_xmae_m.xmae014_desc,g_xmae_m.xmae017_desc, 
       g_xmae_m.xmae019_desc,g_xmae_m.xmae025_desc,g_xmae_m.xmaeownid_desc,g_xmae_m.xmaeowndp_desc,g_xmae_m.xmaecrtid_desc, 
       g_xmae_m.xmaecrtdp_desc,g_xmae_m.xmaemodid_desc
   
   #遮罩相關處理
   LET g_xmae_m_mask_o.* =  g_xmae_m.*
   CALL axmi111_xmae_t_mask()
   LET g_xmae_m_mask_n.* =  g_xmae_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL axmi111_set_act_visible()
   CALL axmi111_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_xmae_m_t.* = g_xmae_m.*
   LET g_xmae_m_o.* = g_xmae_m.*
   
   LET g_data_owner = g_xmae_m.xmaeownid      
   LET g_data_dept  = g_xmae_m.xmaeowndp
   
   #重新顯示
   CALL axmi111_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="axmi111.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmi111_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_xmae_m.* TO NULL             #DEFAULT 設定
   LET g_xmae001_t = NULL
   LET g_xmae002_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmae_m.xmaeownid = g_user
      LET g_xmae_m.xmaeowndp = g_dept
      LET g_xmae_m.xmaecrtid = g_user
      LET g_xmae_m.xmaecrtdp = g_dept 
      LET g_xmae_m.xmaecrtdt = cl_get_current()
      LET g_xmae_m.xmaemodid = g_user
      LET g_xmae_m.xmaemoddt = cl_get_current()
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xmae_m.xmae023 = "1"
      LET g_xmae_m.xmae024 = "1"
 
 
      #add-point:單頭預設值 name="insert.default"
            LET g_xmae_m.xmae010 = g_dlang
      INITIALIZE g_xmae_m_t.* TO NULL
      LET g_xmae_m_t.* = g_xmae_m.*
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL axmi111_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_xmae_m.* TO NULL
         CALL axmi111_show()
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
   CALL axmi111_set_act_visible()
   CALL axmi111_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xmae001_t = g_xmae_m.xmae001
   LET g_xmae002_t = g_xmae_m.xmae002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmaeent = " ||g_enterprise|| " AND",
                      " xmae001 = '", g_xmae_m.xmae001, "' "
                      ," AND xmae002 = '", g_xmae_m.xmae002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmi111_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axmi111_master_referesh USING g_xmae_m.xmae001,g_xmae_m.xmae002 INTO g_xmae_m.xmae002,g_xmae_m.xmae001, 
       g_xmae_m.xmae003,g_xmae_m.xmae004,g_xmae_m.xmae020,g_xmae_m.xmae021,g_xmae_m.xmae022,g_xmae_m.xmae006, 
       g_xmae_m.xmae008,g_xmae_m.xmae009,g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011, 
       g_xmae_m.xmae012,g_xmae_m.xmae013,g_xmae_m.xmae014,g_xmae_m.xmae015,g_xmae_m.xmae016,g_xmae_m.xmae017, 
       g_xmae_m.xmae018,g_xmae_m.xmae019,g_xmae_m.xmae025,g_xmae_m.xmaeownid,g_xmae_m.xmaeowndp,g_xmae_m.xmaecrtid, 
       g_xmae_m.xmaecrtdp,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid,g_xmae_m.xmaemoddt,g_xmae_m.xmae002_desc, 
       g_xmae_m.xmae001_desc,g_xmae_m.xmae003_desc,g_xmae_m.xmae020_desc,g_xmae_m.xmae021_desc,g_xmae_m.xmae006_desc, 
       g_xmae_m.xmae008_desc,g_xmae_m.xmae009_desc,g_xmae_m.xmae011_desc,g_xmae_m.xmae014_desc,g_xmae_m.xmae017_desc, 
       g_xmae_m.xmae019_desc,g_xmae_m.xmae025_desc,g_xmae_m.xmaeownid_desc,g_xmae_m.xmaeowndp_desc,g_xmae_m.xmaecrtid_desc, 
       g_xmae_m.xmaecrtdp_desc,g_xmae_m.xmaemodid_desc
   
   
   #遮罩相關處理
   LET g_xmae_m_mask_o.* =  g_xmae_m.*
   CALL axmi111_xmae_t_mask()
   LET g_xmae_m_mask_n.* =  g_xmae_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmae_m.xmae002,g_xmae_m.xmae001,g_xmae_m.xmae002_desc,g_xmae_m.xmae001_desc,g_xmae_m.xmae003, 
       g_xmae_m.xmae003_desc,g_xmae_m.xmae004,g_xmae_m.xmae004_desc,g_xmae_m.xmae020,g_xmae_m.xmae020_desc, 
       g_xmae_m.xmae021,g_xmae_m.xmae021_desc,g_xmae_m.xmae022,g_xmae_m.xmae022_desc,g_xmae_m.xmae006, 
       g_xmae_m.xmae006_desc,g_xmae_m.xmae008,g_xmae_m.xmae008_desc,g_xmae_m.xmae009,g_xmae_m.xmae009_desc, 
       g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011,g_xmae_m.xmae011_desc,g_xmae_m.xmae012, 
       g_xmae_m.xmae012_desc,g_xmae_m.xmae013,g_xmae_m.xmae013_desc,g_xmae_m.xmae014,g_xmae_m.xmae014_desc, 
       g_xmae_m.xmae015,g_xmae_m.xmae016,g_xmae_m.xmae017,g_xmae_m.xmae017_desc,g_xmae_m.xmae018,g_xmae_m.xmae019, 
       g_xmae_m.xmae019_desc,g_xmae_m.xmae025,g_xmae_m.xmae025_desc,g_xmae_m.xmaeownid,g_xmae_m.xmaeownid_desc, 
       g_xmae_m.xmaeowndp,g_xmae_m.xmaeowndp_desc,g_xmae_m.xmaecrtid,g_xmae_m.xmaecrtid_desc,g_xmae_m.xmaecrtdp, 
       g_xmae_m.xmaecrtdp_desc,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid,g_xmae_m.xmaemodid_desc,g_xmae_m.xmaemoddt 
 
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_xmae_m.xmaeownid      
   LET g_data_dept  = g_xmae_m.xmaeowndp
 
   #功能已完成,通報訊息中心
   CALL axmi111_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axmi111.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmi111_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_xmae_m.xmae001 IS NULL
 
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
   LET g_xmae001_t = g_xmae_m.xmae001
   LET g_xmae002_t = g_xmae_m.xmae002
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN axmi111_cl USING g_enterprise,g_xmae_m.xmae001,g_xmae_m.xmae002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmi111_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE axmi111_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmi111_master_referesh USING g_xmae_m.xmae001,g_xmae_m.xmae002 INTO g_xmae_m.xmae002,g_xmae_m.xmae001, 
       g_xmae_m.xmae003,g_xmae_m.xmae004,g_xmae_m.xmae020,g_xmae_m.xmae021,g_xmae_m.xmae022,g_xmae_m.xmae006, 
       g_xmae_m.xmae008,g_xmae_m.xmae009,g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011, 
       g_xmae_m.xmae012,g_xmae_m.xmae013,g_xmae_m.xmae014,g_xmae_m.xmae015,g_xmae_m.xmae016,g_xmae_m.xmae017, 
       g_xmae_m.xmae018,g_xmae_m.xmae019,g_xmae_m.xmae025,g_xmae_m.xmaeownid,g_xmae_m.xmaeowndp,g_xmae_m.xmaecrtid, 
       g_xmae_m.xmaecrtdp,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid,g_xmae_m.xmaemoddt,g_xmae_m.xmae002_desc, 
       g_xmae_m.xmae001_desc,g_xmae_m.xmae003_desc,g_xmae_m.xmae020_desc,g_xmae_m.xmae021_desc,g_xmae_m.xmae006_desc, 
       g_xmae_m.xmae008_desc,g_xmae_m.xmae009_desc,g_xmae_m.xmae011_desc,g_xmae_m.xmae014_desc,g_xmae_m.xmae017_desc, 
       g_xmae_m.xmae019_desc,g_xmae_m.xmae025_desc,g_xmae_m.xmaeownid_desc,g_xmae_m.xmaeowndp_desc,g_xmae_m.xmaecrtid_desc, 
       g_xmae_m.xmaecrtdp_desc,g_xmae_m.xmaemodid_desc
 
   #檢查是否允許此動作
   IF NOT axmi111_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xmae_m_mask_o.* =  g_xmae_m.*
   CALL axmi111_xmae_t_mask()
   LET g_xmae_m_mask_n.* =  g_xmae_m.*
   
   
 
   #顯示資料
   CALL axmi111_show()
   
   WHILE TRUE
      LET g_xmae_m.xmae001 = g_xmae001_t
      LET g_xmae_m.xmae002 = g_xmae002_t
 
      
      #寫入修改者/修改日期資訊
      LET g_xmae_m.xmaemodid = g_user 
LET g_xmae_m.xmaemoddt = cl_get_current()
LET g_xmae_m.xmaemodid_desc = cl_get_username(g_xmae_m.xmaemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL axmi111_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xmae_m.* = g_xmae_m_t.*
         CALL axmi111_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE xmae_t SET (xmaemodid,xmaemoddt) = (g_xmae_m.xmaemodid,g_xmae_m.xmaemoddt)
       WHERE xmaeent = g_enterprise AND xmae001 = g_xmae001_t
         AND xmae002 = g_xmae002_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL axmi111_set_act_visible()
   CALL axmi111_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xmaeent = " ||g_enterprise|| " AND",
                      " xmae001 = '", g_xmae_m.xmae001, "' "
                      ," AND xmae002 = '", g_xmae_m.xmae002, "' "
 
   #填到對應位置
   CALL axmi111_browser_fill(g_wc,"")
 
   CLOSE axmi111_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmi111_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="axmi111.input" >}
#+ 資料輸入
PRIVATE FUNCTION axmi111_input(p_cmd)
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
   DEFINE l_oocq019       LIKE oocq_t.oocq019
   DEFINE l_oocq019_t     LIKE oocq_t.oocq019
   DEFINE l_msg           LIKE type_t.chr300   #160621-00003#6 160629 by lori add
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
   DISPLAY BY NAME g_xmae_m.xmae002,g_xmae_m.xmae001,g_xmae_m.xmae002_desc,g_xmae_m.xmae001_desc,g_xmae_m.xmae003, 
       g_xmae_m.xmae003_desc,g_xmae_m.xmae004,g_xmae_m.xmae004_desc,g_xmae_m.xmae020,g_xmae_m.xmae020_desc, 
       g_xmae_m.xmae021,g_xmae_m.xmae021_desc,g_xmae_m.xmae022,g_xmae_m.xmae022_desc,g_xmae_m.xmae006, 
       g_xmae_m.xmae006_desc,g_xmae_m.xmae008,g_xmae_m.xmae008_desc,g_xmae_m.xmae009,g_xmae_m.xmae009_desc, 
       g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011,g_xmae_m.xmae011_desc,g_xmae_m.xmae012, 
       g_xmae_m.xmae012_desc,g_xmae_m.xmae013,g_xmae_m.xmae013_desc,g_xmae_m.xmae014,g_xmae_m.xmae014_desc, 
       g_xmae_m.xmae015,g_xmae_m.xmae016,g_xmae_m.xmae017,g_xmae_m.xmae017_desc,g_xmae_m.xmae018,g_xmae_m.xmae019, 
       g_xmae_m.xmae019_desc,g_xmae_m.xmae025,g_xmae_m.xmae025_desc,g_xmae_m.xmaeownid,g_xmae_m.xmaeownid_desc, 
       g_xmae_m.xmaeowndp,g_xmae_m.xmaeowndp_desc,g_xmae_m.xmaecrtid,g_xmae_m.xmaecrtid_desc,g_xmae_m.xmaecrtdp, 
       g_xmae_m.xmaecrtdp_desc,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid,g_xmae_m.xmaemodid_desc,g_xmae_m.xmaemoddt 
 
   
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
   CALL axmi111_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axmi111_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
      LET g_errshow = 1 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_xmae_m.xmae002,g_xmae_m.xmae001,g_xmae_m.xmae003,g_xmae_m.xmae004,g_xmae_m.xmae020, 
          g_xmae_m.xmae021,g_xmae_m.xmae022,g_xmae_m.xmae006,g_xmae_m.xmae008,g_xmae_m.xmae009,g_xmae_m.xmae023, 
          g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011,g_xmae_m.xmae012,g_xmae_m.xmae013,g_xmae_m.xmae014, 
          g_xmae_m.xmae015,g_xmae_m.xmae016,g_xmae_m.xmae017,g_xmae_m.xmae018,g_xmae_m.xmae019,g_xmae_m.xmae025  
 
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
         AFTER FIELD xmae002
            
            #add-point:AFTER FIELD xmae002 name="input.a.xmae002"
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_xmae_m.xmae001) AND NOT cl_null(g_xmae_m.xmae002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmae_m.xmae001 != g_xmae001_t  OR g_xmae_m.xmae002 != g_xmae002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmae_t WHERE "||"xmaeent = '" ||g_enterprise|| "' AND "||"xmae001 = '"||g_xmae_m.xmae001 ||"' AND "|| "xmae002 = '"||g_xmae_m.xmae002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_xmae_m.xmae002) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae002
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "asr-00032:sub-01302|aooi380|",cl_get_progname("aooi380",g_lang,"2"),"|:EXEPROGaooi380"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooha001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae002=g_xmae_m_t.xmae002
                  IF cl_null(g_xmae_m.xmae002) THEN
                     LET g_xmae_m.xmae002_desc=NULL
                     DISPLAY g_xmae_m.xmae002_desc TO xmae002_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae002
            CALL ap_ref_array2(g_ref_fields,"SELECT oohal003 FROM oohal_t WHERE oohalent='"||g_enterprise||"' AND oohal001=? AND oohal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae002_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_xmae_m.xmae002_desc TO xmae002_desc         



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae002
            #add-point:BEFORE FIELD xmae002 name="input.b.xmae002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae002
            #add-point:ON CHANGE xmae002 name="input.g.xmae002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae001
            
            #add-point:AFTER FIELD xmae001 name="input.a.xmae001"
                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_xmae_m.xmae001) AND NOT cl_null(g_xmae_m.xmae002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmae_m.xmae001 != g_xmae001_t  OR g_xmae_m.xmae002 != g_xmae002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmae_t WHERE "||"xmaeent = '" ||g_enterprise|| "' AND "||"xmae001 = '"||g_xmae_m.xmae001 ||"' AND "|| "xmae002 = '"||g_xmae_m.xmae002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_xmae_m.xmae001) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae001
               #ming 20141120 add ----------------------(S) 
               LET g_chkparam.arg2 = g_site
               #ming 20141120 add ----------------------(E)

               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_3") THEN
                  IF  (g_xmae_m.xmae001<>g_xmae_m_t.xmae001) OR cl_null(g_xmae_m_t.xmae001) THEN
                     LET g_xmae_m.xmae006 = ''
                     LET g_xmae_m.xmae006_desc=''
                     DISPLAY g_xmae_m.xmae006 TO xmae006
                     DISPLAY g_xmae_m.xmae006_desc TO xmae006_desc
                  END IF
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae001=g_xmae_m_t.xmae001
                  IF cl_null(g_xmae_m.xmae001) THEN
                     LET g_xmae_m.xmae001_desc=NULL
                     DISPLAY g_xmae_m.xmae001_desc TO xmae001_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae001
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae001_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_xmae_m.xmae001_desc TO xmae001_desc   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae001
            #add-point:BEFORE FIELD xmae001 name="input.b.xmae001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae001
            #add-point:ON CHANGE xmae001 name="input.g.xmae001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae003
            
            #add-point:AFTER FIELD xmae003 name="input.a.xmae003"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae003_desc
            
            IF NOT cl_null(g_xmae_m.xmae003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef014
               LET g_chkparam.arg2 = g_xmae_m.xmae003
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae003=g_xmae_m_t.xmae003
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae003
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae003_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae003_desc
                  IF cl_null(g_xmae_m.xmae003) THEN
                     LET g_xmae_m.xmae003_desc=NULL
                     DISPLAY g_xmae_m.xmae003_desc TO xmae003_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae003
            #add-point:BEFORE FIELD xmae003 name="input.b.xmae003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae003
            #add-point:ON CHANGE xmae003 name="input.g.xmae003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae004
            
            #add-point:AFTER FIELD xmae004 name="input.a.xmae004"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooef019
            LET g_ref_fields[2] = g_xmae_m.xmae004
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodbl001 = ? AND oodbl002 = ? AND oodblent='"||g_enterprise||"' AND oodbl003= '"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae004_desc
            IF NOT cl_null(g_xmae_m.xmae004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_xmae_m.xmae004
               #160318-00025#35  2016/05/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
               #160318-00025#35  2016/05/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae004=g_xmae_m_t.xmae004
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooef019
                  LET g_ref_fields[2] = g_xmae_m.xmae004
                  CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodbl001 = ? AND oodbl002 = ? AND oodblent='"||g_enterprise||"' AND oodbl003= '"||g_lang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae004_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae004_desc
                  IF cl_null(g_xmae_m.xmae004) THEN
                     LET g_xmae_m.xmae004_desc=NULL
                     DISPLAY g_xmae_m.xmae004_desc TO xmae004_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae004
            #add-point:BEFORE FIELD xmae004 name="input.b.xmae004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae004
            #add-point:ON CHANGE xmae004 name="input.g.xmae004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae020
            
            #add-point:AFTER FIELD xmae020 name="input.a.xmae020"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae020
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae020_desc
            IF NOT cl_null(g_xmae_m.xmae020) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae020
               #160318-00025#35  2016/05/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apm-00070:sub-01302|apmi012|",cl_get_progname("apmi012",g_lang,"2"),"|:EXEPROGapmi012"
               LET g_chkparam.err_str[2] = "apm-00069:sub-01303|apmi012|",cl_get_progname("apmi012",g_lang,"2"),"|:EXEPROGapmi012"
               #160318-00025#35  2016/05/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_238") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae020=g_xmae_m_t.xmae020
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae020
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae020_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae020_desc
                  IF cl_null(g_xmae_m.xmae020) THEN
                     LET g_xmae_m.xmae020_desc=NULL
                     DISPLAY g_xmae_m.xmae020_desc TO xmae020_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
               IF cl_null(g_xmae_m.xmae021) THEN
                  SELECT oocq005 INTO g_xmae_m.xmae021 FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001='238' AND oocq002 = g_xmae_m.xmae020
                  DISPLAY g_xmae_m.xmae021 TO xmae021
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae021
                  CALL ap_ref_array2(g_ref_fields,"SELECT xmahl003 FROM xmahl_t WHERE xmahlent='"||g_enterprise||"' AND xmahl001=? AND xmahl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae021_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae021_desc
               END IF
            END IF 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae020
            #add-point:BEFORE FIELD xmae020 name="input.b.xmae020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae020
            #add-point:ON CHANGE xmae020 name="input.g.xmae020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae021
            
            #add-point:AFTER FIELD xmae021 name="input.a.xmae021"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae021
            CALL ap_ref_array2(g_ref_fields,"SELECT xmahl003 FROM xmahl_t WHERE xmahlent='"||g_enterprise||"' AND xmahl001=? AND xmahl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae021_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae021_desc
            IF NOT cl_null(g_xmae_m.xmae021) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae021
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "axm-00026:sub-01302|axmi130|",cl_get_progname("axmi130",g_lang,"2"),"|:EXEPROGaxmi130"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xmah001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae021=g_xmae_m_t.xmae021
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae021
                  CALL ap_ref_array2(g_ref_fields,"SELECT xmahl003 FROM xmahl_t WHERE xmahlent='"||g_enterprise||"' AND xmahl001=? AND xmahl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae021_desc = '', g_rtn_fields[1] , ''  
                  DISPLAY BY NAME g_xmae_m.xmae021_desc
                  IF cl_null(g_xmae_m.xmae021) THEN
                     LET g_xmae_m.xmae021_desc=NULL
                     DISPLAY g_xmae_m.xmae021_desc TO xmae021_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae021
            #add-point:BEFORE FIELD xmae021 name="input.b.xmae021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae021
            #add-point:ON CHANGE xmae021 name="input.g.xmae021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae022
            
            #add-point:AFTER FIELD xmae022 name="input.a.xmae022"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae022
            CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001='"||g_ooef019||"' AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae022_desc
            IF NOT cl_null(g_xmae_m.xmae022) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_xmae_m.xmae022

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_isac002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae022=g_xmae_m_t.xmae022
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae022
                  CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001='"||g_ooef019||"' AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae022_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae022_desc
                  IF cl_null(g_xmae_m.xmae022) THEN
                     LET g_xmae_m.xmae022_desc=NULL
                     DISPLAY g_xmae_m.xmae022_desc TO xmae022_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae022
            #add-point:BEFORE FIELD xmae022 name="input.b.xmae022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae022
            #add-point:ON CHANGE xmae022 name="input.g.xmae022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae006
            
            #add-point:AFTER FIELD xmae006 name="input.a.xmae006"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae006_desc
            IF NOT cl_null(g_xmae_m.xmae006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae001
               LET g_chkparam.arg2 = g_xmae_m.xmae006
               LET g_chkparam.arg3 = '2'  
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "axm-00029:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmad002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae006=g_xmae_m_t.xmae006
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae006
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae006_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae006_desc
                  IF cl_null(g_xmae_m.xmae006) THEN
                     LET g_xmae_m.xmae006_desc=NULL
                     DISPLAY g_xmae_m.xmae006_desc TO xmae006_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae006
            #add-point:BEFORE FIELD xmae006 name="input.b.xmae006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae006
            #add-point:ON CHANGE xmae006 name="input.g.xmae006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae008
            
            #add-point:AFTER FIELD xmae008 name="input.a.xmae008"
            #160621-00003#6 160629 by lor mark and add---(S)
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_xmae_m.xmae008
            #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=275 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_xmae_m.xmae008_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_xmae_m.xmae008_desc            
            #IF NOT cl_null(g_xmae_m.xmae008) THEN                
            #   
            #   #此段落由子樣板a19產生
            #   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
            #   INITIALIZE g_chkparam.* TO NULL
            #   
            #   #設定g_chkparam.*的參數
            #   LET g_chkparam.arg1 = g_xmae_m.xmae008
            #   #160318-00025#35  2016/05/15  by pengxin  add(S)
            #   LET g_errshow = TRUE #是否開窗 
            #   LET g_chkparam.err_str[1] = "axm-00030:sub-01303|apmi062|",cl_get_progname("apmi062",g_lang,"2"),"|:EXEPROGapmi062"
            #   LET g_chkparam.err_str[2] = "axm-00031:sub-01302|apmi062|",cl_get_progname("apmi062",g_lang,"2"),"|:EXEPROGapmi062"
            #   #160318-00025#35  2016/05/15  by pengxin  add(E)
            #      
            #   #呼叫檢查存在並帶值的library
            #   IF cl_chk_exist("v_oocq002_275") THEN
            #      #檢查成功時後續處理
            #      #LET  = g_chkparam.return1
            #      #DISPLAY BY NAME 
            #
            #   ELSE
            #      #檢查失敗時後續處理
            #      LET g_xmae_m.xmae008=g_xmae_m_t.xmae008
            #      INITIALIZE g_ref_fields TO NULL
            #      LET g_ref_fields[1] = g_xmae_m.xmae008
            #      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=275 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            #      LET g_xmae_m.xmae008_desc = '', g_rtn_fields[1] , ''
            #      DISPLAY BY NAME g_xmae_m.xmae008_desc
            #      IF cl_null(g_xmae_m.xmae008) THEN
            #         LET g_xmae_m.xmae008_desc=NULL
            #         DISPLAY g_xmae_m.xmae008_desc TO xmae008_desc
            #      END IF
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF 
            
            LET g_xmae_m.xmae008_desc = ' '
            DISPLAY BY NAME g_xmae_m.xmae008_desc
            IF NOT cl_null(g_xmae_m.xmae008) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmae_m.xmae008 != g_xmae_m_t.xmae008 OR g_xmae_m_t.xmae008 IS NULL )) THEN
                  LET l_msg = ''
                  SELECT gzze003 INTO l_msg
                    FROM gzze_t
                   WHERE gzze001 = 'aoo-00708'
                     AND gzze002 = g_dlang                    
                  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmae_m.xmae008
                  LET g_chkparam.arg2 = '1'
                  LET g_chkparam.err_str[1] = "aoo-00299|",l_msg
                  IF NOT cl_chk_exist("v_oojd001") THEN
                     LET g_xmae_m.xmae008 = g_xmae_m_t.xmae008
                     LET g_xmae_m.xmae008_desc = s_desc_get_oojdl003_desc(g_xmae_m.xmae008)
                     DISPLAY BY NAME g_xmae_m.xmae008,g_xmae_m.xmae008_desc
            
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_xmae_m.xmae008_desc = s_desc_get_oojdl003_desc(g_xmae_m.xmae008)
            DISPLAY BY NAME g_xmae_m.xmae008_desc
            #160621-00003#6 160629 by lor mark and add---(E)   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae008
            #add-point:BEFORE FIELD xmae008 name="input.b.xmae008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae008
            #add-point:ON CHANGE xmae008 name="input.g.xmae008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae009
            
            #add-point:AFTER FIELD xmae009 name="input.a.xmae009"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=295 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae009_desc
            IF NOT cl_null(g_xmae_m.xmae009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae009
               #160318-00025#35  2016/05/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apm-00168:sub-01303|axmi035|",cl_get_progname("axmi035",g_lang,"2"),"|:EXEPROGaxmi035"
               LET g_chkparam.err_str[2] = "apm-00169:sub-01302|axmi035|",cl_get_progname("axmi035",g_lang,"2"),"|:EXEPROGaxmi035"
               #160318-00025#35  2016/05/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_295") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae009=g_xmae_m_t.xmae009
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae009
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=295 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae009_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae009_desc
                  IF cl_null(g_xmae_m.xmae009) THEN
                     LET g_xmae_m.xmae009_desc=NULL
                     DISPLAY g_xmae_m.xmae009_desc TO xmae009_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae009
            #add-point:BEFORE FIELD xmae009 name="input.b.xmae009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae009
            #add-point:ON CHANGE xmae009 name="input.g.xmae009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae023
            #add-point:BEFORE FIELD xmae023 name="input.b.xmae023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae023
            
            #add-point:AFTER FIELD xmae023 name="input.a.xmae023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae023
            #add-point:ON CHANGE xmae023 name="input.g.xmae023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae024
            #add-point:BEFORE FIELD xmae024 name="input.b.xmae024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae024
            
            #add-point:AFTER FIELD xmae024 name="input.a.xmae024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae024
            #add-point:ON CHANGE xmae024 name="input.g.xmae024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae010
            #add-point:BEFORE FIELD xmae010 name="input.b.xmae010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae010
            
            #add-point:AFTER FIELD xmae010 name="input.a.xmae010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae010
            #add-point:ON CHANGE xmae010 name="input.g.xmae010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae011
            
            #add-point:AFTER FIELD xmae011 name="input.a.xmae011"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=263 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae011_desc
            
            IF NOT cl_null(g_xmae_m.xmae011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae011

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_263") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae011=g_xmae_m_t.xmae011
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae011
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=263 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae011_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae011_desc
                  IF cl_null(g_xmae_m.xmae011) THEN
                     LET g_xmae_m.xmae011_desc=NULL
                     DISPLAY g_xmae_m.xmae011_desc TO xmae011_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            SELECT oocq019 INTO l_oocq019 FROM oocq_t WHERE oocq001=263 AND oocq002=g_xmae_m.xmae011 AND oocqent = g_enterprise    #160902-00048#2
            SELECT oocq019 INTO l_oocq019_t FROM oocq_t WHERE oocq001=263 AND oocq002=g_xmae_m_t.xmae011 AND oocqent = g_enterprise    #160902-00048#2
            IF (l_oocq019 <> l_oocq019_t) OR cl_null(l_oocq019) OR cl_null(l_oocq019_t) THEN
               IF (l_oocq019='1' AND l_oocq019_t ='4') OR (l_oocq019='4' AND l_oocq019_t ='1') THEN 
               ELSE
                  LET g_xmae_m.xmae012=NULL
                  LET g_xmae_m.xmae012_desc=NULL
                  LET g_xmae_m.xmae013=NULL
                  LET g_xmae_m.xmae013_desc=NULL
                  DISPLAY g_xmae_m.xmae012 TO xmae012
                  DISPLAY g_xmae_m.xmae012_desc TO xmae012_desc
                  DISPLAY g_xmae_m.xmae013 TO xmae013
                  DISPLAY g_xmae_m.xmae013_desc TO xmae013_desc
               END IF
            END IF
            LET g_xmae_m_t.xmae011=g_xmae_m.xmae011

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae011
            #add-point:BEFORE FIELD xmae011 name="input.b.xmae011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae011
            #add-point:ON CHANGE xmae011 name="input.g.xmae011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae012
            
            #add-point:AFTER FIELD xmae012 name="input.a.xmae012"
                        LET l_oocq019 = NULL
            SELECT oocq019 INTO l_oocq019 FROM oocq_t WHERE oocq001=263 AND oocq002=g_xmae_m.xmae011 AND oocqent = g_enterprise    #160902-00048#2
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae012
            CASE l_oocq019
               WHEN '2'
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               WHEN '3'
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=276 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               OTHERWISE
                  CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            END CASE

            LET g_xmae_m.xmae012_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_xmae_m.xmae012_desc TO xmae012_desc
            IF NOT cl_null(g_xmae_m.xmae012) THEN
              
               INITIALIZE g_ref_fields TO NULL
               CASE l_oocq019
                  WHEN '2'
                     IF NOT s_azzi650_chk_exist('262',g_xmae_m.xmae012) THEN
                        LET g_xmae_m.xmae012 = g_xmae_m_t.xmae012
                        LET g_ref_fields[1] = g_xmae_m.xmae012
                        CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                        LET g_xmae_m.xmae012_desc = '', g_rtn_fields[1] , ''
                        DISPLAY g_xmae_m.xmae012_desc TO xmae012_desc
                        IF cl_null(g_xmae_m.xmae012) THEN
                           LET g_xmae_m.xmae012_desc=NULL
                           DISPLAY g_xmae_m.xmae012_desc TO xmae012_desc
                        END IF
                        NEXT FIELD CURRENT
                     END IF
                     
                  WHEN '3'
                     IF NOT s_azzi650_chk_exist('276',g_xmae_m.xmae012) THEN
                        LET g_xmae_m.xmae012 = g_xmae_m_t.xmae012
                        LET g_ref_fields[1] = g_xmae_m.xmae012
                        CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=276 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                        LET g_xmae_m.xmae012_desc = '', g_rtn_fields[1] , ''
                        DISPLAY g_xmae_m.xmae012_desc TO xmae012_desc
                        IF cl_null(g_xmae_m.xmae012) THEN
                           LET g_xmae_m.xmae012_desc=NULL
                           DISPLAY g_xmae_m.xmae012_desc TO xmae012_desc
                        END IF
                        NEXT FIELD CURRENT
                     END IF
                     
                  OTHERWISE
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n FROM oock_t WHERE oock003=g_xmae_m.xmae012 AND oockstus='Y' AND oockent = g_enterprise    #160902-00048#2
                     IF l_n = 0 THEN
                        LET g_xmae_m.xmae012 = g_xmae_m_t.xmae012
                        LET g_ref_fields[1] = g_xmae_m.xmae012
                        CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
                        LET g_xmae_m.xmae012_desc = '', g_rtn_fields[1] , ''
                        DISPLAY g_xmae_m.xmae012_desc TO xmae012_desc
                        IF cl_null(g_xmae_m.xmae012) THEN
                           LET g_xmae_m.xmae012_desc=NULL
                           DISPLAY g_xmae_m.xmae012_desc TO xmae012_desc
                        END IF
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aoo-00015'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        NEXT FIELD CURRENT
                     END IF
                     
               END CASE

            END IF
            IF cl_null(g_xmae_m.xmae012) THEN
               LET g_xmae_m.xmae012_desc=NULL
               DISPLAY g_xmae_m.xmae012_desc TO xmae012_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae012
            #add-point:BEFORE FIELD xmae012 name="input.b.xmae012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae012
            #add-point:ON CHANGE xmae012 name="input.g.xmae012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae013
            
            #add-point:AFTER FIELD xmae013 name="input.a.xmae013"
                        LET l_oocq019 = NULL
            SELECT oocq019 INTO l_oocq019 FROM oocq_t WHERE oocq001=263 AND oocq002=g_xmae_m.xmae011 AND oocqent = g_enterprise    #160902-00048#2
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae013
            CASE l_oocq019
               WHEN '2'
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               WHEN '3'
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=276 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               OTHERWISE
                  CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            END CASE
            LET g_xmae_m.xmae013_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_xmae_m.xmae013_desc TO xmae013_desc
            IF NOT cl_null(g_xmae_m.xmae013) THEN
           
               INITIALIZE g_ref_fields TO NULL
               CASE l_oocq019
                  WHEN '2'
                     IF NOT s_azzi650_chk_exist('262',g_xmae_m.xmae013) THEN
                        LET g_xmae_m.xmae013 = g_xmae_m_t.xmae013
                        LET g_ref_fields[1] = g_xmae_m.xmae013
                        CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                        LET g_xmae_m.xmae013_desc = '', g_rtn_fields[1] , ''
                        DISPLAY g_xmae_m.xmae013_desc TO xmae013_desc
                        IF cl_null(g_xmae_m.xmae013) THEN
                           LET g_xmae_m.xmae013_desc=NULL
                           DISPLAY g_xmae_m.xmae013_desc TO xmae013_desc
                        END IF
                        NEXT FIELD CURRENT
                     END IF
                     
                  WHEN '3'
                     IF NOT s_azzi650_chk_exist('276',g_xmae_m.xmae013) THEN
                        LET g_xmae_m.xmae013 = g_xmae_m_t.xmae013
                        LET g_ref_fields[1] = g_xmae_m.xmae013
                        CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=276 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                        LET g_xmae_m.xmae013_desc = '', g_rtn_fields[1] , ''
                        DISPLAY g_xmae_m.xmae013_desc TO xmae013_desc
                        IF cl_null(g_xmae_m.xmae013) THEN
                           LET g_xmae_m.xmae013_desc=NULL
                           DISPLAY g_xmae_m.xmae013_desc TO xmae013_desc
                        END IF
                        NEXT FIELD CURRENT
                     END IF
                     
                  OTHERWISE
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n FROM oock_t WHERE oock003=g_xmae_m.xmae013 AND oockstus='Y' AND oockent = g_enterprise    #160902-00048#2
                     IF l_n = 0 THEN
                        LET g_xmae_m.xmae013 = g_xmae_m_t.xmae013
                        LET g_ref_fields[1] = g_xmae_m.xmae013
                        CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
                        LET g_xmae_m.xmae013_desc = '', g_rtn_fields[1] , ''
                        DISPLAY g_xmae_m.xmae013_desc TO xmae013_desc
                        IF cl_null(g_xmae_m.xmae013) THEN
                           LET g_xmae_m.xmae013_desc=NULL
                           DISPLAY g_xmae_m.xmae013_desc TO xmae013_desc
                        END IF
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aoo-00015'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        NEXT FIELD CURRENT
                     END IF
                     END CASE

               
            END IF
            IF cl_null(g_xmae_m.xmae013) THEN
               LET g_xmae_m.xmae013_desc=NULL
               DISPLAY g_xmae_m.xmae013_desc TO xmae013_desc
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae013
            #add-point:BEFORE FIELD xmae013 name="input.b.xmae013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae013
            #add-point:ON CHANGE xmae013 name="input.g.xmae013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae014
            
            #add-point:AFTER FIELD xmae014 name="input.a.xmae014"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae014
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae014_desc
            IF NOT cl_null(g_xmae_m.xmae014) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae014
               #160318-00025#35  2016/05/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "axm-00032:sub-01303|apmi010|",cl_get_progname("apmi010",g_lang,"2"),"|:EXEPROGapmi010"
               LET g_chkparam.err_str[2] = "axm-00033:sub-01302|apmi010|",cl_get_progname("apmi010",g_lang,"2"),"|:EXEPROGapmi010"
               #160318-00025#35  2016/05/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_262") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae014=g_xmae_m_t.xmae014
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae014
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae014_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae014_desc
                  IF cl_null(g_xmae_m.xmae014) THEN
                     LET g_xmae_m.xmae014_desc=NULL
                     DISPLAY g_xmae_m.xmae014_desc TO xmae014_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae014
            #add-point:BEFORE FIELD xmae014 name="input.b.xmae014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae014
            #add-point:ON CHANGE xmae014 name="input.g.xmae014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmae_m.xmae015,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD xmae015
            END IF 
 
 
 
            #add-point:AFTER FIELD xmae015 name="input.a.xmae015"
                        IF NOT cl_null(g_xmae_m.xmae015) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae015
            #add-point:BEFORE FIELD xmae015 name="input.b.xmae015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae015
            #add-point:ON CHANGE xmae015 name="input.g.xmae015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmae_m.xmae016,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD xmae016
            END IF 
 
 
 
            #add-point:AFTER FIELD xmae016 name="input.a.xmae016"
                        IF NOT cl_null(g_xmae_m.xmae016) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae016
            #add-point:BEFORE FIELD xmae016 name="input.b.xmae016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae016
            #add-point:ON CHANGE xmae016 name="input.g.xmae016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae017
            
            #add-point:AFTER FIELD xmae017 name="input.a.xmae017"
                        INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae017
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae017_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae017_desc
            IF NOT cl_null(g_xmae_m.xmae017) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae017

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae017=g_xmae_m_t.xmae017
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_xmae_m.xmae017
                  CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_xmae_m.xmae017_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_xmae_m.xmae017_desc
                  IF cl_null(g_xmae_m.xmae017) THEN
                     LET g_xmae_m.xmae017_desc=NULL
                     DISPLAY g_xmae_m.xmae017_desc TO xmae017_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae017
            #add-point:BEFORE FIELD xmae017 name="input.b.xmae017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae017
            #add-point:ON CHANGE xmae017 name="input.g.xmae017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae018
            #add-point:BEFORE FIELD xmae018 name="input.b.xmae018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae018
            
            #add-point:AFTER FIELD xmae018 name="input.a.xmae018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae018
            #add-point:ON CHANGE xmae018 name="input.g.xmae018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae019
            
            #add-point:AFTER FIELD xmae019 name="input.a.xmae019"
            CALL axmi111_xmae019_ref()
            DISPLAY BY NAME g_xmae_m.xmae019_desc
            IF NOT cl_null(g_xmae_m.xmae019) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmae_m.xmae019
               #160318-00025#35  2016/05/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#35  2016/05/15  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_xmae_m.xmae019=g_xmae_m_t.xmae019
                  CALL axmi111_xmae019_ref()
                  DISPLAY BY NAME g_xmae_m.xmae019_desc
                  IF cl_null(g_xmae_m.xmae019) THEN
                     LET g_xmae_m.xmae019_desc=NULL
                     DISPLAY g_xmae_m.xmae019_desc TO xmae019_desc
                  END IF
                  NEXT FIELD CURRENT
               END IF
               #帶出歸屬部門ooag003
               SELECT ooag003 INTO g_xmae_m.xmae025
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_xmae_m.xmae019
               
               LET g_xmae_m_o.xmae025 = g_xmae_m.xmae025
               DISPLAY BY NAME g_xmae_m.xmae025

               CALL s_desc_get_department_desc(g_xmae_m.xmae025) RETURNING g_xmae_m.xmae025_desc
               DISPLAY BY NAME g_xmae_m.xmae025_desc

            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae019
            #add-point:BEFORE FIELD xmae019 name="input.b.xmae019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae019
            #add-point:ON CHANGE xmae019 name="input.g.xmae019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmae025
            
            #add-point:AFTER FIELD xmae025 name="input.a.xmae025"
            CALL s_desc_get_department_desc(g_xmae_m.xmae025) RETURNING g_xmae_m.xmae025_desc
            DISPLAY BY NAME g_xmae_m.xmae025_desc
   
            IF NOT cl_null(g_xmae_m.xmae025) THEN 
               IF g_xmae_m.xmae025 <> g_xmae_m_o.xmae025 OR cl_null(g_xmae_m_o.xmae025) THEN
                  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_xmae_m.xmae025
                  LET g_chkparam.arg2 = g_today
                  #160318-00025#35  2016/04/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#35  2016/04/15  by pengxin  add(E)
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_xmae_m.xmae025 = g_xmae_m_o.xmae025
                     
                     CALL s_desc_get_department_desc(g_xmae_m.xmae025) RETURNING g_xmae_m.xmae025_desc
                     DISPLAY BY NAME g_xmae_m.xmae025_desc                    
   
                     NEXT FIELD CURRENT
                  END IF               
               END IF
            END IF 
            
            LET g_xmae_m_o.xmae025 = g_xmae_m.xmae025
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmae025
            #add-point:BEFORE FIELD xmae025 name="input.b.xmae025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmae025
            #add-point:ON CHANGE xmae025 name="input.g.xmae025"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmae002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae002
            #add-point:ON ACTION controlp INFIELD xmae002 name="input.c.xmae002"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae002             #給予default值

            #給予arg

            CALL q_ooha001_3()                                #呼叫開窗

            LET g_xmae_m.xmae002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae002 TO xmae002              #顯示到畫面上

            NEXT FIELD xmae002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae001
            #add-point:ON ACTION controlp INFIELD xmae001 name="input.c.xmae001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae001             #給予default值

            #給予arg
            #ming 20141120 add ----------------------------(S) 
            LET g_qryparam.arg1 = g_site
            #ming 20141120 add ----------------------------(E) 
            CALL q_pmaa001_6()                                #呼叫開窗

            LET g_xmae_m.xmae001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae001 TO xmae001              #顯示到畫面上

            NEXT FIELD xmae001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae003
            #add-point:ON ACTION controlp INFIELD xmae003 name="input.c.xmae003"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae003             #給予default值

            #給予arg
            LET g_qryparam.arg1=g_site
            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_xmae_m.xmae003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae003 TO xmae003              #顯示到畫面上

            NEXT FIELD xmae003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae004
            #add-point:ON ACTION controlp INFIELD xmae004 name="input.c.xmae004"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae004             #給予default值
            LET g_qryparam.default2 = "" #g_xmae_m.oodb002 #稅別代碼
            LET g_qryparam.default3 = "" #g_xmae_m.oodb005 #含稅否
            LET g_qryparam.default4 = "" #g_xmae_m.oodb006 #稅率

            #給予arg
            LET g_qryparam.arg1 = g_ooef019
            CALL q_oodb002_7()                                #呼叫開窗

            LET g_xmae_m.xmae004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_xmae_m.oodb002 = g_qryparam.return2 #稅別代碼
            #LET g_xmae_m.oodb005 = g_qryparam.return3 #含稅否
            #LET g_xmae_m.oodb006 = g_qryparam.return4 #稅率

            DISPLAY g_xmae_m.xmae004 TO xmae004              #顯示到畫面上
            #DISPLAY g_xmae_m.oodb002 TO oodb002 #稅別代碼
            #DISPLAY g_xmae_m.oodb005 TO oodb005 #含稅否
            #DISPLAY g_xmae_m.oodb006 TO oodb006 #稅率

            NEXT FIELD xmae004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae020
            #add-point:ON ACTION controlp INFIELD xmae020 name="input.c.xmae020"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae020             #給予default值

            #給予arg

            CALL q_oocq002_6()                                #呼叫開窗

            LET g_xmae_m.xmae020 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae020 TO xmae020              #顯示到畫面上

            NEXT FIELD xmae020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae021
            #add-point:ON ACTION controlp INFIELD xmae021 name="input.c.xmae021"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae021             #給予default值

            #給予arg

            CALL q_xmah001()                                #呼叫開窗

            LET g_xmae_m.xmae021 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae021 TO xmae021              #顯示到畫面上

            NEXT FIELD xmae021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae022
            #add-point:ON ACTION controlp INFIELD xmae022 name="input.c.xmae022"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae022             #給予default值
            LET g_qryparam.default2 = "" #g_xmae_m.isac002 #發票類型

            #給予arg
            LET g_qryparam.arg1 = g_ooef019 #
            LET g_qryparam.arg2 = '2'
            CALL q_isac002_1()                                #呼叫開窗

            LET g_xmae_m.xmae022 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_xmae_m.isac002 = g_qryparam.return2 #發票類型

            DISPLAY g_xmae_m.xmae022 TO xmae022              #顯示到畫面上
            #DISPLAY g_xmae_m.isac002 TO isac002 #發票類型

            NEXT FIELD xmae022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae006
            #add-point:ON ACTION controlp INFIELD xmae006 name="input.c.xmae006"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xmae_m.xmae001
            CALL q_pmad002_3()                                #呼叫開窗

            LET g_xmae_m.xmae006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae006 TO xmae006              #顯示到畫面上

            NEXT FIELD xmae006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae008
            #add-point:ON ACTION controlp INFIELD xmae008 name="input.c.xmae008"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmae_m.xmae008    
            
			   #160621-00003#6 160629 by lori mark ad add---(S)
            #CALL q_oocq002_7()
            
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001()            
            #160621-00003#6 160629 by lori mark ad add---(E)
            
            LET g_xmae_m.xmae008 = g_qryparam.return1   
            DISPLAY g_xmae_m.xmae008 TO xmae008        
                      
            LET g_xmae_m.xmae008_desc = s_desc_get_oojdl003_desc(g_xmae_m.xmae008)   #160621-00003#6 160629 by lori add
            DISPLAY g_xmae_m.xmae008_desc TO xmae008_desc                            #160621-00003#6 160629 by lori add
            
            NEXT FIELD xmae008                         


            #END add-point
 
 
         #Ctrlp:input.c.xmae009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae009
            #add-point:ON ACTION controlp INFIELD xmae009 name="input.c.xmae009"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae009             #給予default值

            #給予arg

            CALL q_oocq002_8()                                #呼叫開窗

            LET g_xmae_m.xmae009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae009 TO xmae009              #顯示到畫面上

            NEXT FIELD xmae009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae023
            #add-point:ON ACTION controlp INFIELD xmae023 name="input.c.xmae023"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmae024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae024
            #add-point:ON ACTION controlp INFIELD xmae024 name="input.c.xmae024"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmae010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae010
            #add-point:ON ACTION controlp INFIELD xmae010 name="input.c.xmae010"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmae011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae011
            #add-point:ON ACTION controlp INFIELD xmae011 name="input.c.xmae011"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae011             #給予default值

            #給予arg

            CALL q_oocq002_9()                                #呼叫開窗

            LET g_xmae_m.xmae011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae011 TO xmae011              #顯示到畫面上

            NEXT FIELD xmae011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae012
            #add-point:ON ACTION controlp INFIELD xmae012 name="input.c.xmae012"
                        SELECT oocq019 INTO l_oocq019 FROM oocq_t WHERE oocq001=263 AND oocq002=g_xmae_m.xmae011 AND oocqent = g_enterprise    #160902-00048#2
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	        LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmae_m.xmae012             #給予default值
            CASE l_oocq019                 
               WHEN '2'
                   CALL q_oocq002_10()                           #呼叫開窗
               WHEN '3'
                   CALL q_oocq002_12()                           #呼叫開窗
               OTHERWISE
                   CALL q_oock003()                           #呼叫開窗
            END CASE
            LET g_xmae_m.xmae012 = g_qryparam.return1  #顯示到畫面上 
            DISPLAY g_xmae_m.xmae012 TO xmae012              #顯示到畫面上
            NEXT FIELD xmae012                          #返回原欄位            
            #END add-point
 
 
         #Ctrlp:input.c.xmae013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae013
            #add-point:ON ACTION controlp INFIELD xmae013 name="input.c.xmae013"
                        SELECT oocq019 INTO l_oocq019 FROM oocq_t WHERE oocq001=263 AND oocq002=g_xmae_m.xmae011 AND oocqent = g_enterprise    #160902-00048#2
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	        LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmae_m.xmae013             #給予default值
            CASE l_oocq019
               WHEN '2'
                   CALL q_oocq002_10()                           #呼叫開窗
               WHEN '3'
                   CALL q_oocq002_12()                           #呼叫開窗
               OTHERWISE
                   CALL q_oock003()                           #呼叫開窗
            END CASE
            LET g_xmae_m.xmae013 = g_qryparam.return1  #顯示到畫面上 
            DISPLAY g_xmae_m.xmae013 TO xmae013              #顯示到畫面上
            NEXT FIELD xmae013                          #返回原欄位   
            #END add-point
 
 
         #Ctrlp:input.c.xmae014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae014
            #add-point:ON ACTION controlp INFIELD xmae014 name="input.c.xmae014"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae014             #給予default值

            #給予arg

            CALL q_oocq002_10()                                #呼叫開窗

            LET g_xmae_m.xmae014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae014 TO xmae014              #顯示到畫面上

            NEXT FIELD xmae014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae015
            #add-point:ON ACTION controlp INFIELD xmae015 name="input.c.xmae015"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae016
            #add-point:ON ACTION controlp INFIELD xmae016 name="input.c.xmae016"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmae017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae017
            #add-point:ON ACTION controlp INFIELD xmae017 name="input.c.xmae017"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae017             #給予default值

            #給予arg

            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_xmae_m.xmae017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae017 TO xmae017              #顯示到畫面上

            NEXT FIELD xmae017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae018
            #add-point:ON ACTION controlp INFIELD xmae018 name="input.c.xmae018"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmae019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae019
            #add-point:ON ACTION controlp INFIELD xmae019 name="input.c.xmae019"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae019             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_xmae_m.xmae019 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae019 TO xmae019              #顯示到畫面上
            CALL axmi111_xmae019_ref()
            DISPLAY BY NAME g_xmae_m.xmae019_desc
            
            #帶出歸屬部門ooag003
            SELECT ooag003 INTO g_xmae_m.xmae025
              FROM ooag_t
             WHERE ooagent = g_enterprise
               AND ooag001 = g_xmae_m.xmae019
            
            LET g_xmae_m_o.xmae025 = g_xmae_m.xmae025
            DISPLAY BY NAME g_xmae_m.xmae025

            CALL s_desc_get_department_desc(g_xmae_m.xmae025) RETURNING g_xmae_m.xmae025_desc
            DISPLAY BY NAME g_xmae_m.xmae025_desc
            
            NEXT FIELD xmae019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmae025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmae025
            #add-point:ON ACTION controlp INFIELD xmae025 name="input.c.xmae025"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmae_m.xmae025             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            CALL q_ooeg001()                                #呼叫開窗

            LET g_xmae_m.xmae025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmae_m.xmae025 TO xmae025              #顯示到畫面上

            CALL s_desc_get_department_desc(g_xmae_m.xmae025) RETURNING g_xmae_m.xmae025_desc
            DISPLAY BY NAME g_xmae_m.xmae025_desc
   
            NEXT FIELD xmae025                          #返回原欄位
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
               SELECT COUNT(1) INTO l_count FROM xmae_t
                WHERE xmaeent = g_enterprise AND xmae001 = g_xmae_m.xmae001
                  AND xmae002 = g_xmae_m.xmae002
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO xmae_t (xmaeent,xmae002,xmae001,xmae003,xmae004,xmae020,xmae021,xmae022, 
                      xmae006,xmae008,xmae009,xmae023,xmae024,xmae010,xmae011,xmae012,xmae013,xmae014, 
                      xmae015,xmae016,xmae017,xmae018,xmae019,xmae025,xmaeownid,xmaeowndp,xmaecrtid, 
                      xmaecrtdp,xmaecrtdt,xmaemodid,xmaemoddt)
                  VALUES (g_enterprise,g_xmae_m.xmae002,g_xmae_m.xmae001,g_xmae_m.xmae003,g_xmae_m.xmae004, 
                      g_xmae_m.xmae020,g_xmae_m.xmae021,g_xmae_m.xmae022,g_xmae_m.xmae006,g_xmae_m.xmae008, 
                      g_xmae_m.xmae009,g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011, 
                      g_xmae_m.xmae012,g_xmae_m.xmae013,g_xmae_m.xmae014,g_xmae_m.xmae015,g_xmae_m.xmae016, 
                      g_xmae_m.xmae017,g_xmae_m.xmae018,g_xmae_m.xmae019,g_xmae_m.xmae025,g_xmae_m.xmaeownid, 
                      g_xmae_m.xmaeowndp,g_xmae_m.xmaecrtid,g_xmae_m.xmaecrtdp,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid, 
                      g_xmae_m.xmaemoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmae_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_xmae_m.xmae001
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axmi111_xmae_t_mask_restore('restore_mask_o')
               
               UPDATE xmae_t SET (xmae002,xmae001,xmae003,xmae004,xmae020,xmae021,xmae022,xmae006,xmae008, 
                   xmae009,xmae023,xmae024,xmae010,xmae011,xmae012,xmae013,xmae014,xmae015,xmae016,xmae017, 
                   xmae018,xmae019,xmae025,xmaeownid,xmaeowndp,xmaecrtid,xmaecrtdp,xmaecrtdt,xmaemodid, 
                   xmaemoddt) = (g_xmae_m.xmae002,g_xmae_m.xmae001,g_xmae_m.xmae003,g_xmae_m.xmae004, 
                   g_xmae_m.xmae020,g_xmae_m.xmae021,g_xmae_m.xmae022,g_xmae_m.xmae006,g_xmae_m.xmae008, 
                   g_xmae_m.xmae009,g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011, 
                   g_xmae_m.xmae012,g_xmae_m.xmae013,g_xmae_m.xmae014,g_xmae_m.xmae015,g_xmae_m.xmae016, 
                   g_xmae_m.xmae017,g_xmae_m.xmae018,g_xmae_m.xmae019,g_xmae_m.xmae025,g_xmae_m.xmaeownid, 
                   g_xmae_m.xmaeowndp,g_xmae_m.xmaecrtid,g_xmae_m.xmaecrtdp,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid, 
                   g_xmae_m.xmaemoddt)
                WHERE xmaeent = g_enterprise AND xmae001 = g_xmae001_t #
                  AND xmae002 = g_xmae002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmae_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmae_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL axmi111_xmae_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_xmae_m_t)
                     LET g_log2 = util.JSON.stringify(g_xmae_m)
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
 
{<section id="axmi111.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axmi111_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xmae_t.xmae001 
   DEFINE l_oldno     LIKE xmae_t.xmae001 
   DEFINE l_newno02     LIKE xmae_t.xmae002 
   DEFINE l_oldno02     LIKE xmae_t.xmae002 
 
   DEFINE l_master    RECORD LIKE xmae_t.* #此變數樣板目前無使用
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
   IF g_xmae_m.xmae001 IS NULL
      OR g_xmae_m.xmae002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_xmae001_t = g_xmae_m.xmae001
   LET g_xmae002_t = g_xmae_m.xmae002
 
   
   #清空key值
   LET g_xmae_m.xmae001 = ""
   LET g_xmae_m.xmae002 = ""
 
    
   CALL axmi111_set_entry("a")
   CALL axmi111_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmae_m.xmaeownid = g_user
      LET g_xmae_m.xmaeowndp = g_dept
      LET g_xmae_m.xmaecrtid = g_user
      LET g_xmae_m.xmaecrtdp = g_dept 
      LET g_xmae_m.xmaecrtdt = cl_get_current()
      LET g_xmae_m.xmaemodid = g_user
      LET g_xmae_m.xmaemoddt = cl_get_current()
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
      LET g_xmae_m.xmae002_desc = ''
   LET g_xmae_m.xmae001_desc = ''
   DISPLAY BY NAME g_xmae_m.xmae002_desc
   DISPLAY BY NAME g_xmae_m.xmae001_desc
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
      LET g_xmae_m.xmae002_desc = ''
   DISPLAY BY NAME g_xmae_m.xmae002_desc
   LET g_xmae_m.xmae001_desc = ''
   DISPLAY BY NAME g_xmae_m.xmae001_desc
 
   
   #資料輸入
   CALL axmi111_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_xmae_m.* TO NULL
      CALL axmi111_show()
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
      LET g_errparam.extend = "xmae_t:",SQLERRMESSAGE 
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
   CALL axmi111_set_act_visible()
   CALL axmi111_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xmae001_t = g_xmae_m.xmae001
   LET g_xmae002_t = g_xmae_m.xmae002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmaeent = " ||g_enterprise|| " AND",
                      " xmae001 = '", g_xmae_m.xmae001, "' "
                      ," AND xmae002 = '", g_xmae_m.xmae002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmi111_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_xmae_m.xmaeownid      
   LET g_data_dept  = g_xmae_m.xmaeowndp
              
   #功能已完成,通報訊息中心
   CALL axmi111_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="axmi111.show" >}
#+ 資料顯示 
PRIVATE FUNCTION axmi111_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
      DEFINE l_oocq019     LIKE oocq_t.oocq019
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
      SELECT DISTINCT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axmi111_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#               INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmaeownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmaeownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmaeownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmaeowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmaeowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmaeowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmaecrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmaecrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmaecrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmaecrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmaecrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmaecrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmaemodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmaemodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmaemodid_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oohal003 FROM oohal_t WHERE oohalent='"||g_enterprise||"' AND oohal001=? AND oohal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY g_xmae_m.xmae002_desc TO xmae002_desc         
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae001
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY g_xmae_m.xmae001_desc TO xmae001_desc  

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooef019
            LET g_ref_fields[2] = g_xmae_m.xmae004
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodbl001 = ? AND oodbl002 = ? AND oodblent='"||g_enterprise||"' AND oodbl003= '"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae004_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae020
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae020_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae020_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae022
            CALL ap_ref_array2(g_ref_fields,"SELECT isacl004 FROM isacl_t WHERE isaclent='"||g_enterprise||"' AND isacl001='"||g_ooef019||"' AND isacl002=? AND isacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmae_m.xmae022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmae_m.xmae022_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae006
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae006_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae008
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=275 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae009
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=295 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae009_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae009_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae011
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=263 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae011_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae011_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae014
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae014_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae014_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae019
#            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND  oofa003=? AND oofa002='2' ","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae019_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae019_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae003
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae003_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae021
#            CALL ap_ref_array2(g_ref_fields,"SELECT xmahl003 FROM xmahl_t WHERE xmahlent='"||g_enterprise||"' AND xmahl001=? AND xmahl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae021_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae021_desc

            LET l_oocq019 = NULL
            SELECT oocq019 INTO l_oocq019 FROM oocq_t WHERE oocq001=263 AND oocq002=g_xmae_m.xmae011 AND oocqent = g_enterprise    #160902-00048#2
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae012
            CASE l_oocq019
               WHEN '2'
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               WHEN '3'
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=276 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               OTHERWISE
                  CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            END CASE

            LET g_xmae_m.xmae012_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_xmae_m.xmae012_desc TO xmae012_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmae_m.xmae013
            CASE l_oocq019
               WHEN '2'
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=262 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               WHEN '3'
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=276 AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               OTHERWISE
                  CALL ap_ref_array2(g_ref_fields,"SELECT oockl005 FROM oockl_t WHERE oocklent='"||g_enterprise||"' AND oockl003=? AND oockl004='"||g_dlang||"'","") RETURNING g_rtn_fields
            END CASE

            LET g_xmae_m.xmae013_desc = '', g_rtn_fields[1] , ''
            DISPLAY  g_xmae_m.xmae013_desc TO xmae013_desc
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmae_m.xmae017
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmae_m.xmae017_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmae_m.xmae017_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmae_m.xmae002,g_xmae_m.xmae001,g_xmae_m.xmae002_desc,g_xmae_m.xmae001_desc,g_xmae_m.xmae003, 
       g_xmae_m.xmae003_desc,g_xmae_m.xmae004,g_xmae_m.xmae004_desc,g_xmae_m.xmae020,g_xmae_m.xmae020_desc, 
       g_xmae_m.xmae021,g_xmae_m.xmae021_desc,g_xmae_m.xmae022,g_xmae_m.xmae022_desc,g_xmae_m.xmae006, 
       g_xmae_m.xmae006_desc,g_xmae_m.xmae008,g_xmae_m.xmae008_desc,g_xmae_m.xmae009,g_xmae_m.xmae009_desc, 
       g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011,g_xmae_m.xmae011_desc,g_xmae_m.xmae012, 
       g_xmae_m.xmae012_desc,g_xmae_m.xmae013,g_xmae_m.xmae013_desc,g_xmae_m.xmae014,g_xmae_m.xmae014_desc, 
       g_xmae_m.xmae015,g_xmae_m.xmae016,g_xmae_m.xmae017,g_xmae_m.xmae017_desc,g_xmae_m.xmae018,g_xmae_m.xmae019, 
       g_xmae_m.xmae019_desc,g_xmae_m.xmae025,g_xmae_m.xmae025_desc,g_xmae_m.xmaeownid,g_xmae_m.xmaeownid_desc, 
       g_xmae_m.xmaeowndp,g_xmae_m.xmaeowndp_desc,g_xmae_m.xmaecrtid,g_xmae_m.xmaecrtid_desc,g_xmae_m.xmaecrtdp, 
       g_xmae_m.xmaecrtdp_desc,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid,g_xmae_m.xmaemodid_desc,g_xmae_m.xmaemoddt 
 
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL axmi111_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmi111.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION axmi111_delete()
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
   IF g_xmae_m.xmae001 IS NULL
   OR g_xmae_m.xmae002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_xmae001_t = g_xmae_m.xmae001
   LET g_xmae002_t = g_xmae_m.xmae002
 
   
   
 
   OPEN axmi111_cl USING g_enterprise,g_xmae_m.xmae001,g_xmae_m.xmae002
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmi111_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE axmi111_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmi111_master_referesh USING g_xmae_m.xmae001,g_xmae_m.xmae002 INTO g_xmae_m.xmae002,g_xmae_m.xmae001, 
       g_xmae_m.xmae003,g_xmae_m.xmae004,g_xmae_m.xmae020,g_xmae_m.xmae021,g_xmae_m.xmae022,g_xmae_m.xmae006, 
       g_xmae_m.xmae008,g_xmae_m.xmae009,g_xmae_m.xmae023,g_xmae_m.xmae024,g_xmae_m.xmae010,g_xmae_m.xmae011, 
       g_xmae_m.xmae012,g_xmae_m.xmae013,g_xmae_m.xmae014,g_xmae_m.xmae015,g_xmae_m.xmae016,g_xmae_m.xmae017, 
       g_xmae_m.xmae018,g_xmae_m.xmae019,g_xmae_m.xmae025,g_xmae_m.xmaeownid,g_xmae_m.xmaeowndp,g_xmae_m.xmaecrtid, 
       g_xmae_m.xmaecrtdp,g_xmae_m.xmaecrtdt,g_xmae_m.xmaemodid,g_xmae_m.xmaemoddt,g_xmae_m.xmae002_desc, 
       g_xmae_m.xmae001_desc,g_xmae_m.xmae003_desc,g_xmae_m.xmae020_desc,g_xmae_m.xmae021_desc,g_xmae_m.xmae006_desc, 
       g_xmae_m.xmae008_desc,g_xmae_m.xmae009_desc,g_xmae_m.xmae011_desc,g_xmae_m.xmae014_desc,g_xmae_m.xmae017_desc, 
       g_xmae_m.xmae019_desc,g_xmae_m.xmae025_desc,g_xmae_m.xmaeownid_desc,g_xmae_m.xmaeowndp_desc,g_xmae_m.xmaecrtid_desc, 
       g_xmae_m.xmaecrtdp_desc,g_xmae_m.xmaemodid_desc
   
   
   #檢查是否允許此動作
   IF NOT axmi111_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmae_m_mask_o.* =  g_xmae_m.*
   CALL axmi111_xmae_t_mask()
   LET g_xmae_m_mask_n.* =  g_xmae_m.*
   
   #將最新資料顯示到畫面上
   CALL axmi111_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmi111_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM xmae_t 
       WHERE xmaeent = g_enterprise AND xmae001 = g_xmae_m.xmae001 
         AND xmae002 = g_xmae_m.xmae002 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmae_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xmae_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE axmi111_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL axmi111_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL axmi111_browser_fill(g_wc,"")
         CALL axmi111_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axmi111_cl
 
   #功能已完成,通報訊息中心
   CALL axmi111_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmi111.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axmi111_ui_browser_refresh()
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
      IF g_browser[l_i].b_xmae001 = g_xmae_m.xmae001
         AND g_browser[l_i].b_xmae002 = g_xmae_m.xmae002
 
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
 
{<section id="axmi111.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axmi111_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("xmae001,xmae002",TRUE)
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
 
{<section id="axmi111.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axmi111_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xmae001,xmae002",FALSE)
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
 
{<section id="axmi111.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axmi111_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmi111.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axmi111_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmi111.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmi111_default_search()
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
      LET ls_wc = ls_wc, " xmae001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmae002 = '", g_argv[02], "' AND "
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
 
{<section id="axmi111.mask_functions" >}
&include "erp/axm/axmi111_mask.4gl"
 
{</section>}
 
{<section id="axmi111.state_change" >}
   
 
{</section>}
 
{<section id="axmi111.signature" >}
   
 
{</section>}
 
{<section id="axmi111.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmi111_set_pk_array()
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
   LET g_pk_array[1].values = g_xmae_m.xmae001
   LET g_pk_array[1].column = 'xmae001'
   LET g_pk_array[2].values = g_xmae_m.xmae002
   LET g_pk_array[2].column = 'xmae002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmi111.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="axmi111.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axmi111_msgcentre_notify(lc_state)
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
   CALL axmi111_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xmae_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmi111.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axmi111_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmi111.other_function" readonly="Y" >}
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
PUBLIC FUNCTION axmi111_xmae010_comb()
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
   CALL cl_set_combo_items("xmae_t.xmae010",ls_values,ls_items)
END FUNCTION

PRIVATE FUNCTION axmi111_xmae019_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmae_m.xmae019
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa003=? AND oofa002='2' ","") RETURNING g_rtn_fields
   LET g_xmae_m.xmae019_desc = '', g_rtn_fields[1] , ''
END FUNCTION

 
{</section>}
 
