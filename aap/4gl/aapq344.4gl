#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq344.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-08-03 15:06:30), PR版次:0010(2016-11-24 10:20:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000068
#+ Filename...: aapq344
#+ Description: 待抵借支單查詢作業
#+ Creator....: 04152(2014-12-29 13:57:22)
#+ Modifier...: 05016 -SD/PR- 08171
 
{</section>}
 
{<section id="aapq344.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#151013-00019#11 2015/11/11 By Reanna    查詢時開放傳票號碼&來源單號
#160318-00025#7  2016/04/20 By 07675     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160518-00075#24 2016/08/03 By Hans      使用元件取得aooi200的限制人員/限制部門取用單別並加以限制範圍
#160812-00027#2  2016/08/16 By 06821     全面盤點應付程式帳套權限控管
#161014-00053#2  2016/10/20 By 08171     帳套權限控管調整
#161006-00005#19 2016/10/24 By 08732     組織類型與職能開窗調整
#161115-00042#4  2016/11/16 By 08171     開窗範圍處理
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aap_aapt300_13  #嵌入留置
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"  
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_apca_m RECORD
       apcasite LIKE apca_t.apcasite, 
   apcasite_desc LIKE type_t.chr80, 
   apca003 LIKE apca_t.apca003, 
   apca003_desc LIKE type_t.chr80, 
   apcald LIKE apca_t.apcald, 
   apcald_desc LIKE type_t.chr80, 
   apcadocno LIKE apca_t.apcadocno, 
   apca001 LIKE apca_t.apca001, 
   apcadocno_desc LIKE type_t.chr80, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apca015 LIKE apca_t.apca015, 
   apca015_desc LIKE type_t.chr80, 
   apca057 LIKE apca_t.apca057, 
   apca057_desc LIKE type_t.chr80, 
   apca038 LIKE apca_t.apca038, 
   apcastus LIKE apca_t.apcastus, 
   apca018 LIKE apca_t.apca018, 
   apca010 LIKE apca_t.apca010, 
   apca014 LIKE apca_t.apca014, 
   apca014_desc LIKE type_t.chr80, 
   apca034 LIKE apca_t.apca034, 
   apca034_desc LIKE type_t.chr80, 
   apca033 LIKE apca_t.apca033, 
   apca033_desc LIKE type_t.chr80, 
   apca007 LIKE apca_t.apca007, 
   apca007_desc LIKE type_t.chr80, 
   apca035 LIKE apca_t.apca035, 
   apca035_desc LIKE type_t.chr80, 
   apca100 LIKE apca_t.apca100, 
   apca103 LIKE apca_t.apca103, 
   apca104 LIKE apca_t.apca104, 
   apca106 LIKE apca_t.apca106, 
   apca108 LIKE apca_t.apca108, 
   apcc109 LIKE apcc_t.apcc109, 
   net108 LIKE type_t.num20_6, 
   glaa001 LIKE type_t.chr10, 
   apca101 LIKE apca_t.apca101, 
   apca113 LIKE apca_t.apca113, 
   apca114 LIKE apca_t.apca114, 
   apca116 LIKE apca_t.apca116, 
   apcc113 LIKE apcc_t.apcc113, 
   apca118 LIKE apca_t.apca118, 
   apcc119 LIKE type_t.num20_6, 
   net118 LIKE type_t.num20_6, 
   apca065 LIKE apca_t.apca065, 
   apca066 LIKE apca_t.apca066, 
   apca011 LIKE apca_t.apca011, 
   apca011_desc LIKE type_t.chr80, 
   apca013 LIKE apca_t.apca013, 
   apca012 LIKE apca_t.apca012, 
   apca060 LIKE apca_t.apca060, 
   apca058 LIKE apca_t.apca058, 
   apca058_desc LIKE type_t.chr80, 
   apca046 LIKE apca_t.apca046, 
   apca047 LIKE apca_t.apca047, 
   apca048 LIKE apca_t.apca048, 
   apca021 LIKE apca_t.apca021, 
   apca020 LIKE apca_t.apca020, 
   apca022 LIKE apca_t.apca022, 
   apca063 LIKE apca_t.apca063, 
   apca052 LIKE apca_t.apca052, 
   apca017 LIKE apca_t.apca017, 
   apca051 LIKE apca_t.apca051, 
   apca051_desc LIKE type_t.chr80, 
   apca053 LIKE apca_t.apca053, 
   apca025 LIKE apca_t.apca025, 
   apca031 LIKE apca_t.apca031, 
   apca030 LIKE apca_t.apca030, 
   apca030_desc LIKE type_t.chr80, 
   apca026 LIKE apca_t.apca026, 
   apca027 LIKE apca_t.apca027, 
   apca028 LIKE apca_t.apca028, 
   apca029 LIKE apca_t.apca029, 
   apca1001 LIKE type_t.chr10, 
   apca1031 LIKE type_t.num20_6, 
   apca1041 LIKE type_t.num20_6, 
   apca1061 LIKE type_t.num20_6, 
   fflabel_t3 LIKE type_t.chr80, 
   apca1081 LIKE type_t.num20_6, 
   apcc1091 LIKE type_t.num20_6, 
   net1081 LIKE type_t.num20_6, 
   glaa0011 LIKE type_t.chr10, 
   apca1011 LIKE type_t.num26_10, 
   apca120 LIKE apca_t.apca120, 
   apca121 LIKE apca_t.apca121, 
   apca130 LIKE apca_t.apca130, 
   apca131 LIKE apca_t.apca131, 
   apca1131 LIKE type_t.num20_6, 
   apca123 LIKE apca_t.apca123, 
   apca133 LIKE apca_t.apca133, 
   apca1141 LIKE type_t.num20_6, 
   apca124 LIKE apca_t.apca124, 
   apca134 LIKE apca_t.apca134, 
   apca1161 LIKE type_t.num20_6, 
   apca126 LIKE apca_t.apca126, 
   apca136 LIKE apca_t.apca136, 
   apcc1131 LIKE type_t.num20_6, 
   apcc123 LIKE apcc_t.apcc123, 
   apcc133 LIKE apcc_t.apcc133, 
   apca1181 LIKE type_t.num20_6, 
   apca128 LIKE apca_t.apca128, 
   apca138 LIKE apca_t.apca138, 
   apcc1191 LIKE type_t.num20_6, 
   apcc129 LIKE type_t.num20_6, 
   apcc139 LIKE type_t.num20_6, 
   net1181 LIKE type_t.num20_6, 
   net128 LIKE type_t.num20_6, 
   net138 LIKE type_t.num20_6, 
   apcaownid LIKE apca_t.apcaownid, 
   apcaownid_desc LIKE type_t.chr80, 
   apcaowndp LIKE apca_t.apcaowndp, 
   apcaowndp_desc LIKE type_t.chr80, 
   apcacrtid LIKE apca_t.apcacrtid, 
   apcacrtid_desc LIKE type_t.chr80, 
   apcacrtdp LIKE apca_t.apcacrtdp, 
   apcacrtdp_desc LIKE type_t.chr80, 
   apcacrtdt LIKE apca_t.apcacrtdt, 
   apcamodid LIKE apca_t.apcamodid, 
   apcamodid_desc LIKE type_t.chr80, 
   apcamoddt LIKE apca_t.apcamoddt, 
   apcacnfid LIKE apca_t.apcacnfid, 
   apcacnfid_desc LIKE type_t.chr80, 
   apcacnfdt LIKE apca_t.apcacnfdt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_apcald LIKE apca_t.apcald,
      b_apcadocno LIKE apca_t.apcadocno
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa                RECORD
                             glaacomp  LIKE glaa_t.glaacomp,
                             glaa001   LIKE glaa_t.glaa001,
                             glaa015   LIKE glaa_t.glaa015,
                             glaa016   LIKE glaa_t.glaa016,
                             glaa019   LIKE glaa_t.glaa019,
                             glaa020   LIKE glaa_t.glaa020
                         END RECORD
DEFINE g_ooef019             LIKE ooef_t.ooef019      #稅區參照表(依據所屬法人所帶的設定)
DEFINE g_user_dept_wc      STRING      #160518-00075#24
DEFINE g_user_dept_wc2     STRING      #160518-00075#24
DEFINE g_user_dept_wc_q    STRING      #160518-00075#24
DEFINE g_wc_cs_ld          STRING      #160812-00027#2    add 查詢時帳套權限範圍
DEFINE g_site_str          STRING      #161014-00053#2
DEFINE g_apcacomp          LIKE glaa_t.glaacomp   #161115-00042#4 add
DEFINE g_apcald            LIKE glaa_t.glaald     #161115-00042#4 add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_apca_m        type_g_apca_m  #單頭變數宣告
DEFINE g_apca_m_t      type_g_apca_m  #單頭舊值宣告(系統還原用)
DEFINE g_apca_m_o      type_g_apca_m  #單頭舊值宣告(其他用途)
DEFINE g_apca_m_mask_o type_g_apca_m  #轉換遮罩前資料
DEFINE g_apca_m_mask_n type_g_apca_m  #轉換遮罩後資料
 
   DEFINE g_apcald_t LIKE apca_t.apcald
DEFINE g_apcadocno_t LIKE apca_t.apcadocno
 
   
 
   
 
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
DEFINE g_wc2                 STRING    #151013-00019#11
#end add-point
 
{</section>}
 
{<section id="aapq344.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT apcasite,'',apca003,'',apcald,'',apcadocno,apca001,'',apcadocdt,apca015, 
       '',apca057,'',apca038,apcastus,apca018,apca010,apca014,'',apca034,'',apca033,'',apca007,'',apca035, 
       '',apca100,apca103,apca104,apca106,apca108,'','','',apca101,apca113,apca114,apca116,'',apca118, 
       '','',apca065,apca066,apca011,'',apca013,apca012,apca060,apca058,'',apca046,apca047,apca048,apca021, 
       apca020,apca022,apca063,apca052,apca017,apca051,'',apca053,apca025,apca031,apca030,'',apca026, 
       apca027,apca028,apca029,'','','','','','','','','','',apca120,apca121,apca130,apca131,'',apca123, 
       apca133,'',apca124,apca134,'',apca126,apca136,'','','','',apca128,apca138,'','','','','','',apcaownid, 
       '',apcaowndp,'',apcacrtid,'',apcacrtdp,'',apcacrtdt,apcamodid,'',apcamoddt,apcacnfid,'',apcacnfdt", 
        
                      " FROM apca_t",
                      " WHERE apcaent= ? AND apcald=? AND apcadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq344_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apcasite,t0.apca003,t0.apcald,t0.apcadocno,t0.apca001,t0.apcadocdt, 
       t0.apca015,t0.apca057,t0.apca038,t0.apcastus,t0.apca018,t0.apca010,t0.apca014,t0.apca034,t0.apca033, 
       t0.apca007,t0.apca035,t0.apca100,t0.apca103,t0.apca104,t0.apca106,t0.apca108,t0.apca101,t0.apca113, 
       t0.apca114,t0.apca116,t0.apca118,t0.apca065,t0.apca066,t0.apca011,t0.apca013,t0.apca012,t0.apca060, 
       t0.apca058,t0.apca046,t0.apca047,t0.apca048,t0.apca021,t0.apca020,t0.apca022,t0.apca063,t0.apca052, 
       t0.apca017,t0.apca051,t0.apca053,t0.apca025,t0.apca031,t0.apca030,t0.apca026,t0.apca027,t0.apca028, 
       t0.apca029,t0.apca120,t0.apca121,t0.apca130,t0.apca131,t0.apca123,t0.apca133,t0.apca124,t0.apca134, 
       t0.apca126,t0.apca136,t0.apca128,t0.apca138,t0.apcaownid,t0.apcaowndp,t0.apcacrtid,t0.apcacrtdp, 
       t0.apcacrtdt,t0.apcamodid,t0.apcamoddt,t0.apcacnfid,t0.apcacnfdt,t1.ooefl003 ,t2.ooag011 ,t3.glaal002 , 
       t4.ooefl003 ,t5.ooag011 ,t6.ooag011 ,t7.ooefl003 ,t8.ooefl003 ,t9.oocql004 ,t10.glacl004 ,t11.oodbl004 , 
       t12.oocql004 ,t13.ooag011 ,t14.ooefl003 ,t15.ooag011 ,t16.ooefl003 ,t17.ooag011 ,t18.ooag011", 
 
               " FROM apca_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.apcasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.apca003  ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.apcald AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.apca015 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.apca057  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.apca014  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.apca034 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.apca033 AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='3211' AND t9.oocql002=t0.apca007 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t10 ON t10.glaclent="||g_enterprise||" AND t10.glacl001='' AND t10.glacl002=t0.apca036 AND t10.glacl003='"||g_dlang||"' ",
               " LEFT JOIN oodbl_t t11 ON t11.oodblent="||g_enterprise||" AND t11.oodbl001='' AND t11.oodbl002=t0.apca011 AND t11.oodbl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='264' AND t12.oocql002=t0.apca058 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.apcaownid  ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent="||g_enterprise||" AND t14.ooefl001=t0.apcaowndp AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.apcacrtid  ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=t0.apcacrtdp AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t17 ON t17.ooagent="||g_enterprise||" AND t17.ooag001=t0.apcamodid  ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=t0.apcacnfid  ",
 
               " WHERE t0.apcaent = " ||g_enterprise|| " AND t0.apcald = ? AND t0.apcadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq344_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq344 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq344_init()   
 
      #進入選單 Menu (="N")
      CALL aapq344_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq344
      
   END IF 
   
   CLOSE aapq344_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq344.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapq344_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str        STRING
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('apcastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('apca001','8502') 
   CALL cl_set_combo_scc('apca060','8321') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aap", "aapt300_13"), "grid_7", "Grid", "master")　　              　#畫面-留置
   CALL cl_set_combo_scc('apca017','8324')                  #產生方式
   CALL cl_set_combo_scc('apca025','8511')                  #差異處理
   CALL cl_set_combo_scc('apca056','8323')                  #會計檢核附件狀態
   CALL cl_set_combo_scc('apca060','8321')                  #發票開立方式
   LET l_str = s_fin_last_doc_fields(g_prog,'8502','3|3')   #取得可用的來源類型       
   CALL cl_set_combo_scc_part('apca001','8502',l_str)       #帳款單性質
   #160518-00075#24--s
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','apcald','apcaent','apca018') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   #160518-00075#24--e   
   
   #160812-00027#2 --s add
   #帳套權限相關預設範圍
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld     
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld   
   #160812-00027#2 --e add
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aapq344_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aapq344.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapq344_ui_dialog() 
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
            CALL aapq344_insert()
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
         INITIALIZE g_apca_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aapq344_init()
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
               CALL aapq344_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aapq344_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aapq344_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aapq344_set_act_visible()
               CALL aapq344_set_act_no_visible()
               IF NOT (g_apca_m.apcald IS NULL
                 OR g_apca_m.apcadocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " apcaent = " ||g_enterprise|| " AND",
                                     " apcald = '", g_apca_m.apcald, "' "
                                     ," AND apcadocno = '", g_apca_m.apcadocno, "' "
 
                  #填到對應位置
                  CALL aapq344_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aapq344_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aapq344_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aapq344_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aapq344_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aapq344_fetch("L")  
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
                  CALL aapq344_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aapq344_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapq344_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt331
            LET g_action_choice="open_aapt331"
            IF cl_auth_chk_act("open_aapt331") THEN
               
               #add-point:ON ACTION open_aapt331 name="menu2.open_aapt331"
               LET la_param.prog = 'aapt331'
               LET la_param.param[1] = g_apca_m.apcald      #帳套
               LET la_param.param[2] = g_apca_m.apca018     #原本的借支單號
               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION lien
            LET g_action_choice="lien"
            IF cl_auth_chk_act("lien") THEN
               
               #add-point:ON ACTION lien name="menu2.lien"
               #帳款留置設定
               CALL aapt300_13_set_lien(g_apca_m.apcald,g_apca_m.apcadocno,TRUE)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapq344_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapq344_01
            LET g_action_choice="open_aapq344_01"
            IF cl_auth_chk_act("open_aapq344_01") THEN
               
               #add-point:ON ACTION open_aapq344_01 name="menu2.open_aapq344_01"
               CALL aapq344_01(g_apca_m.apcald,g_apca_m.apcadocno)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapq344_02
            LET g_action_choice="open_aapq344_02"
            IF cl_auth_chk_act("open_aapq344_02") THEN
               
               #add-point:ON ACTION open_aapq344_02 name="menu2.open_aapq344_02"
               CALL aapq344_02(g_apca_m.apcald,g_apca_m.apcadocno)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
               CALL aapr300_g01("apcaent ="|| g_enterprise ||" AND apcald ='"|| g_apca_m.apcald ||"' AND apcadocno ='"|| g_apca_m.apcadocno||"'")
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
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq344_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu2.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION waiver_of_lien
            LET g_action_choice="waiver_of_lien"
            IF cl_auth_chk_act("waiver_of_lien") THEN
               
               #add-point:ON ACTION waiver_of_lien name="menu2.waiver_of_lien"
               #ACTION 說明:解除帳款留置
               CALL aapt300_13_set_lien(g_apca_m.apcald,g_apca_m.apcadocno,FALSE)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apca038
            LET g_action_choice="prog_apca038"
            IF cl_auth_chk_act("prog_apca038") THEN
               
               #add-point:ON ACTION prog_apca038 name="menu2.prog_apca038"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               IF cl_null(g_apca_m.apcald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'apcald')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  IF cl_null(g_apca_m.apca038) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = 'sub-00280'
                     LET g_errparam.extend = s_fin_get_colname(g_prog,'apca038')
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     INITIALIZE la_param.* TO NULL
                     CALL s_aapt300_get_aglt3xx_prog(g_apca_m.apcald,g_apca_m.apca038)RETURNING la_param.prog
                     LET la_param.param[1] = g_apca_m.apcald
                     LET la_param.param[2] = g_apca_m.apca038
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapq344_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapq344_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapq344_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apca_m.apcadocdt)
 
 
 
            
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
                  CALL aapq344_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL aapq344_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aapq344_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aapq344_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aapq344_set_act_visible()
               CALL aapq344_set_act_no_visible()
               IF NOT (g_apca_m.apcald IS NULL
                 OR g_apca_m.apcadocno IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " apcaent = " ||g_enterprise|| " AND",
                                     " apcald = '", g_apca_m.apcald, "' "
                                     ," AND apcadocno = '", g_apca_m.apcadocno, "' "
 
                  #填到對應位置
                  CALL aapq344_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL aapq344_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aapq344_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aapq344_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aapq344_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aapq344_fetch("L")  
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
                  CALL aapq344_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aapq344_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapq344_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt331
            LET g_action_choice="open_aapt331"
            IF cl_auth_chk_act("open_aapt331") THEN
               
               #add-point:ON ACTION open_aapt331 name="menu.open_aapt331"
               LET la_param.prog = 'aapt331'
               LET la_param.param[1] = g_apca_m.apcald      #帳套
               LET la_param.param[2] = g_apca_m.apca018     #原本的借支單號
               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION lien
            LET g_action_choice="lien"
            IF cl_auth_chk_act("lien") THEN
               
               #add-point:ON ACTION lien name="menu.lien"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapq344_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapq344_01
            LET g_action_choice="open_aapq344_01"
            IF cl_auth_chk_act("open_aapq344_01") THEN
               
               #add-point:ON ACTION open_aapq344_01 name="menu.open_aapq344_01"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapq344_02
            LET g_action_choice="open_aapq344_02"
            IF cl_auth_chk_act("open_aapq344_02") THEN
               
               #add-point:ON ACTION open_aapq344_02 name="menu.open_aapq344_02"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aapr300_g01("apcaent ="|| g_enterprise ||" AND apcald ='"|| g_apca_m.apcald ||"' AND apcadocno ='"|| g_apca_m.apcadocno||"'")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aapr300_g01("apcaent ="|| g_enterprise ||" AND apcald ='"|| g_apca_m.apcald ||"' AND apcadocno ='"|| g_apca_m.apcadocno||"'")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapq344_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION waiver_of_lien
            LET g_action_choice="waiver_of_lien"
            IF cl_auth_chk_act("waiver_of_lien") THEN
               
               #add-point:ON ACTION waiver_of_lien name="menu.waiver_of_lien"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apca038
            LET g_action_choice="prog_apca038"
            IF cl_auth_chk_act("prog_apca038") THEN
               
               #add-point:ON ACTION prog_apca038 name="menu.prog_apca038"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               IF cl_null(g_apca_m.apcald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'apcald')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_apca_m.apca038) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'sub-00280'
                  LET g_errparam.extend = s_fin_get_colname(g_prog,'apca038')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               
               INITIALIZE la_param.* TO NULL
               CALL s_aapt300_get_aglt3xx_prog(g_apca_m.apcald,g_apca_m.apca038)RETURNING la_param.prog
               LET la_param.param[1] = g_apca_m.apcald
               LET la_param.param[2] = g_apca_m.apca038
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapq344_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapq344_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapq344_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apca_m.apcadocdt)
 
 
 
 
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
 
{<section id="aapq344.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aapq344_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING #161115-00042#4 add
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "apcald,apcadocno"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   CALL cl_set_act_visible("insert", FALSE)
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM apca_t ",
               "  ",
               "  ",
               " WHERE apcaent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("apca_t")
                
   #add-point:browser_fill段cnt_sql name="browser_fill.cnt_sql"
   LET g_sql = g_sql," AND apcastus = 'Y'"
   #151013-00019#11 add ------
   IF g_wc2 <> " 1=1" THEN
      CALL s_chr_replace(g_wc2,'apca018','apcadocno',0) RETURNING g_wc2
      LET g_sql = g_sql," AND apcadocno IN (SELECT apca019 FROM apca_t WHERE apcaent = ",g_enterprise," AND ",g_wc2,")"
   END IF
   #151013-00019#11 add end---
   #161115-00042#4 --s add
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apcald")
   LET p_wc = p_wc," AND ",l_ld_str
   #161115-00042#4 --e add
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
      INITIALIZE g_apca_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.apcastus,t0.apcald,t0.apcadocno",
               " FROM apca_t t0 ",
               "  ",
               
               " WHERE t0.apcaent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("apca_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   #151013-00019#11 add ------
   IF g_wc2 <> " 1=1" THEN
      LET g_sql = g_sql," AND apcadocno IN (SELECT apca019 FROM apca_t WHERE apcaent = ",g_enterprise," AND ",g_wc2,")"
   END IF
   #151013-00019#11 add end---
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
 
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"apca_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_apcald,g_browser[g_cnt].b_apcadocno 
 
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
   
   IF cl_null(g_browser[g_cnt].b_apcald) THEN
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
 
{<section id="aapq344.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapq344_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ld_str       STRING  #161014-00053#2 add
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_apca_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON apcasite,apca003,apcald,apcadocno,apca001,apcadocdt,apca015,apca057, 
          apcastus,apca010,apca014,apca034,apca033,apca007,apca035,apca100,apca103,apca104,apca106,apca108, 
          apca101,apca113,apca114,apca116,apca118,apca065,apca066,apca011,apca013,apca012,apca060,apca058, 
          apca046,apca047,apca048,apca021,apca020,apca022,apca063,apca052,apca017,apca051,apca051_desc, 
          apca053,apca025,apca031,apca030,apca030_desc,apca026,apca027,apca028,apca029,apca120,apca121, 
          apca130,apca131,apca123,apca133,apca124,apca134,apca126,apca136,apca128,apca138,apcaownid, 
          apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,apcacnfdt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apcacrtdt>>----
         AFTER FIELD apcacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apcamoddt>>----
         AFTER FIELD apcamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apcacnfdt>>----
         AFTER FIELD apcacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apcapstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcasite
            #add-point:ON ACTION controlp INFIELD apcasite name="construct.c.apcasite"
            #帳務中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#19   mark
            CALL q_ooef001_46()   #161006-00005#19   add 
            DISPLAY g_qryparam.return1 TO apcasite
            NEXT FIELD apcasite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcasite
            #add-point:BEFORE FIELD apcasite name="construct.b.apcasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcasite
            
            #add-point:AFTER FIELD apcasite name="construct.a.apcasite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str   #161014-00053#2
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca003
            #add-point:ON ACTION controlp INFIELD apca003 name="construct.c.apca003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apca003
            NEXT FIELD apca003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca003
            #add-point:BEFORE FIELD apca003 name="construct.b.apca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca003
            
            #add-point:AFTER FIELD apca003 name="construct.a.apca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="construct.c.apcald"
            #帳別
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str #161014-00053#2 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            #LET g_qryparam.arg2 = g_grup #160812-00027#2 mark
            #160812-00027#2 --s add
            LET g_qryparam.arg2 = g_dept
            #LET g_qryparam.where = " glaald IN ",g_wc_cs_ld   #161014-00053#2 mark
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')" #161014-00053#2 add
            #160812-00027#2 --e add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO apcald
            NEXT FIELD apcald
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcald
            #add-point:BEFORE FIELD apcald name="construct.b.apcald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcald
            
            #add-point:AFTER FIELD apcald name="construct.a.apcald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocno
            #add-point:ON ACTION controlp INFIELD apcadocno name="construct.c.apcadocno"
            #單據編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apca001 IN (",s_fin_get_scc_gzcb002('8502','3',g_prog) ,")"
            #LET g_qryparam.where = "apca001 IN ('26')"
            #161115-00042#4 --s add
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apcald")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161115-00042#4 --e add 
            CALL q_apcadocno()
            LET g_apca_m.apcadocno = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO apcadocno
            NEXT FIELD apcadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocno
            #add-point:BEFORE FIELD apcadocno name="construct.b.apcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocno
            
            #add-point:AFTER FIELD apcadocno name="construct.a.apcadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca001
            #add-point:BEFORE FIELD apca001 name="construct.b.apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca001
            
            #add-point:AFTER FIELD apca001 name="construct.a.apca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="construct.c.apca001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocdt
            #add-point:BEFORE FIELD apcadocdt name="construct.b.apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocdt
            
            #add-point:AFTER FIELD apcadocdt name="construct.a.apcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocdt
            #add-point:ON ACTION controlp INFIELD apcadocdt name="construct.c.apcadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca015
            #add-point:ON ACTION controlp INFIELD apca015 name="construct.c.apca015"
            #業務部門
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()               
            DISPLAY g_qryparam.return1 TO apca015  #顯示到畫面上
            NEXT FIELD apca015           

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca015
            #add-point:BEFORE FIELD apca015 name="construct.b.apca015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca015
            
            #add-point:AFTER FIELD apca015 name="construct.a.apca015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca057
            #add-point:ON ACTION controlp INFIELD apca057 name="construct.c.apca057"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apca057  #顯示到畫面上
            NEXT FIELD apca057                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca057
            #add-point:BEFORE FIELD apca057 name="construct.b.apca057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca057
            
            #add-point:AFTER FIELD apca057 name="construct.a.apca057"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcastus
            #add-point:BEFORE FIELD apcastus name="construct.b.apcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcastus
            
            #add-point:AFTER FIELD apcastus name="construct.a.apcastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcastus
            #add-point:ON ACTION controlp INFIELD apcastus name="construct.c.apcastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca010
            #add-point:BEFORE FIELD apca010 name="construct.b.apca010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca010
            
            #add-point:AFTER FIELD apca010 name="construct.a.apca010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca010
            #add-point:ON ACTION controlp INFIELD apca010 name="construct.c.apca010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca014
            #add-point:ON ACTION controlp INFIELD apca014 name="construct.c.apca014"
            #業務人員
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                 
            DISPLAY g_qryparam.return1 TO apca014  #顯示到畫面上
            NEXT FIELD apca014   


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca014
            #add-point:BEFORE FIELD apca014 name="construct.b.apca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca014
            
            #add-point:AFTER FIELD apca014 name="construct.a.apca014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca034
            #add-point:ON ACTION controlp INFIELD apca034 name="construct.c.apca034"
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_5()                     
            DISPLAY g_qryparam.return1 TO apca034  #顯示到畫面上

            NEXT FIELD apca034     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca034
            #add-point:BEFORE FIELD apca034 name="construct.b.apca034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca034
            
            #add-point:AFTER FIELD apca034 name="construct.a.apca034"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca033
            #add-point:BEFORE FIELD apca033 name="construct.b.apca033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca033
            
            #add-point:AFTER FIELD apca033 name="construct.a.apca033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca033
            #add-point:ON ACTION controlp INFIELD apca033 name="construct.c.apca033"
            #專案編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO apca033
            NEXT FIELD apca033
            #END add-point
 
 
         #Ctrlp:construct.c.apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca007
            #add-point:ON ACTION controlp INFIELD apca007 name="construct.c.apca007"
            #帳款類別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3111'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apca007
            NEXT FIELD apca007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca007
            #add-point:BEFORE FIELD apca007 name="construct.b.apca007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca007
            
            #add-point:AFTER FIELD apca007 name="construct.a.apca007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca035
            #add-point:ON ACTION controlp INFIELD apca035 name="construct.c.apca035"
            #應付(貸方)科目編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161115-00042#4 --s add
            SELECT ooef017 INTO g_apcacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_apcald FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_apcacomp
               AND glaa014 = 'Y'
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_apcald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161115-00042#4 --e add
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO apca035
            NEXT FIELD apca035
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca035
            #add-point:BEFORE FIELD apca035 name="construct.b.apca035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca035
            
            #add-point:AFTER FIELD apca035 name="construct.a.apca035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca100
            #add-point:ON ACTION controlp INFIELD apca100 name="construct.c.apca100"
            #交易幣別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO apca100
            NEXT FIELD apca100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca100
            #add-point:BEFORE FIELD apca100 name="construct.b.apca100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca100
            
            #add-point:AFTER FIELD apca100 name="construct.a.apca100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca103
            #add-point:BEFORE FIELD apca103 name="construct.b.apca103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca103
            
            #add-point:AFTER FIELD apca103 name="construct.a.apca103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca103
            #add-point:ON ACTION controlp INFIELD apca103 name="construct.c.apca103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca104
            #add-point:BEFORE FIELD apca104 name="construct.b.apca104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca104
            
            #add-point:AFTER FIELD apca104 name="construct.a.apca104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca104
            #add-point:ON ACTION controlp INFIELD apca104 name="construct.c.apca104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca106
            #add-point:BEFORE FIELD apca106 name="construct.b.apca106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca106
            
            #add-point:AFTER FIELD apca106 name="construct.a.apca106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca106
            #add-point:ON ACTION controlp INFIELD apca106 name="construct.c.apca106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca108
            #add-point:BEFORE FIELD apca108 name="construct.b.apca108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca108
            
            #add-point:AFTER FIELD apca108 name="construct.a.apca108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca108
            #add-point:ON ACTION controlp INFIELD apca108 name="construct.c.apca108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca101
            #add-point:BEFORE FIELD apca101 name="construct.b.apca101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca101
            
            #add-point:AFTER FIELD apca101 name="construct.a.apca101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca101
            #add-point:ON ACTION controlp INFIELD apca101 name="construct.c.apca101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca113
            #add-point:BEFORE FIELD apca113 name="construct.b.apca113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca113
            
            #add-point:AFTER FIELD apca113 name="construct.a.apca113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca113
            #add-point:ON ACTION controlp INFIELD apca113 name="construct.c.apca113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca114
            #add-point:BEFORE FIELD apca114 name="construct.b.apca114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca114
            
            #add-point:AFTER FIELD apca114 name="construct.a.apca114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca114
            #add-point:ON ACTION controlp INFIELD apca114 name="construct.c.apca114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca116
            #add-point:BEFORE FIELD apca116 name="construct.b.apca116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca116
            
            #add-point:AFTER FIELD apca116 name="construct.a.apca116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca116
            #add-point:ON ACTION controlp INFIELD apca116 name="construct.c.apca116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca118
            #add-point:BEFORE FIELD apca118 name="construct.b.apca118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca118
            
            #add-point:AFTER FIELD apca118 name="construct.a.apca118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca118
            #add-point:ON ACTION controlp INFIELD apca118 name="construct.c.apca118"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca065
            #add-point:BEFORE FIELD apca065 name="construct.b.apca065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca065
            
            #add-point:AFTER FIELD apca065 name="construct.a.apca065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca065
            #add-point:ON ACTION controlp INFIELD apca065 name="construct.c.apca065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca066
            #add-point:BEFORE FIELD apca066 name="construct.b.apca066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca066
            
            #add-point:AFTER FIELD apca066 name="construct.a.apca066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca066
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca066
            #add-point:ON ACTION controlp INFIELD apca066 name="construct.c.apca066"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_apca066()
            DISPLAY g_qryparam.return1 TO apca066
            NEXT FIELD apca066
            #END add-point
 
 
         #Ctrlp:construct.c.apca011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca011
            #add-point:ON ACTION controlp INFIELD apca011 name="construct.c.apca011"
            #稅區
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = g_ooef019        #稅區
            #CALL q_oodb002_5()
            CALL q_oodb002()
            DISPLAY g_qryparam.return1 TO apca011  #顯示到畫面上
            NEXT FIELD apca011
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca011
            #add-point:BEFORE FIELD apca011 name="construct.b.apca011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca011
            
            #add-point:AFTER FIELD apca011 name="construct.a.apca011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca013
            #add-point:BEFORE FIELD apca013 name="construct.b.apca013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca013
            
            #add-point:AFTER FIELD apca013 name="construct.a.apca013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca013
            #add-point:ON ACTION controlp INFIELD apca013 name="construct.c.apca013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca012
            #add-point:BEFORE FIELD apca012 name="construct.b.apca012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca012
            
            #add-point:AFTER FIELD apca012 name="construct.a.apca012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca012
            #add-point:ON ACTION controlp INFIELD apca012 name="construct.c.apca012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca060
            #add-point:BEFORE FIELD apca060 name="construct.b.apca060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca060
            
            #add-point:AFTER FIELD apca060 name="construct.a.apca060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca060
            #add-point:ON ACTION controlp INFIELD apca060 name="construct.c.apca060"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca058
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca058
            #add-point:ON ACTION controlp INFIELD apca058 name="construct.c.apca058"
            #採購分類
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = '264'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apca058
            NEXT FIELD apca058
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca058
            #add-point:BEFORE FIELD apca058 name="construct.b.apca058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca058
            
            #add-point:AFTER FIELD apca058 name="construct.a.apca058"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca046
            #add-point:BEFORE FIELD apca046 name="construct.b.apca046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca046
            
            #add-point:AFTER FIELD apca046 name="construct.a.apca046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca046
            #add-point:ON ACTION controlp INFIELD apca046 name="construct.c.apca046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca047
            #add-point:BEFORE FIELD apca047 name="construct.b.apca047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca047
            
            #add-point:AFTER FIELD apca047 name="construct.a.apca047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca047
            #add-point:ON ACTION controlp INFIELD apca047 name="construct.c.apca047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca048
            #add-point:BEFORE FIELD apca048 name="construct.b.apca048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca048
            
            #add-point:AFTER FIELD apca048 name="construct.a.apca048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca048
            #add-point:ON ACTION controlp INFIELD apca048 name="construct.c.apca048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca021
            #add-point:BEFORE FIELD apca021 name="construct.b.apca021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca021
            
            #add-point:AFTER FIELD apca021 name="construct.a.apca021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca021
            #add-point:ON ACTION controlp INFIELD apca021 name="construct.c.apca021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca020
            #add-point:BEFORE FIELD apca020 name="construct.b.apca020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca020
            
            #add-point:AFTER FIELD apca020 name="construct.a.apca020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca020
            #add-point:ON ACTION controlp INFIELD apca020 name="construct.c.apca020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca022
            #add-point:BEFORE FIELD apca022 name="construct.b.apca022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca022
            
            #add-point:AFTER FIELD apca022 name="construct.a.apca022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca022
            #add-point:ON ACTION controlp INFIELD apca022 name="construct.c.apca022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca063
            #add-point:ON ACTION controlp INFIELD apca063 name="construct.c.apca063"
            #整帳批序號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apca063()
            DISPLAY g_qryparam.return1 TO apca063
            NEXT FIELD apca063
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca063
            #add-point:BEFORE FIELD apca063 name="construct.b.apca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca063
            
            #add-point:AFTER FIELD apca063 name="construct.a.apca063"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca052
            #add-point:BEFORE FIELD apca052 name="construct.b.apca052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca052
            
            #add-point:AFTER FIELD apca052 name="construct.a.apca052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca052
            #add-point:ON ACTION controlp INFIELD apca052 name="construct.c.apca052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca017
            #add-point:BEFORE FIELD apca017 name="construct.b.apca017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca017
            
            #add-point:AFTER FIELD apca017 name="construct.a.apca017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca017
            #add-point:ON ACTION controlp INFIELD apca017 name="construct.c.apca017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca051
            #add-point:ON ACTION controlp INFIELD apca051 name="construct.c.apca051"
            #作廢理由碼
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3115"
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apca051
            NEXT FIELD apca051
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca051
            #add-point:BEFORE FIELD apca051 name="construct.b.apca051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca051
            
            #add-point:AFTER FIELD apca051 name="construct.a.apca051"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca051_desc
            #add-point:BEFORE FIELD apca051_desc name="construct.b.apca051_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca051_desc
            
            #add-point:AFTER FIELD apca051_desc name="construct.a.apca051_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca051_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca051_desc
            #add-point:ON ACTION controlp INFIELD apca051_desc name="construct.c.apca051_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca053
            #add-point:BEFORE FIELD apca053 name="construct.b.apca053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca053
            
            #add-point:AFTER FIELD apca053 name="construct.a.apca053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca053
            #add-point:ON ACTION controlp INFIELD apca053 name="construct.c.apca053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca025
            #add-point:BEFORE FIELD apca025 name="construct.b.apca025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca025
            
            #add-point:AFTER FIELD apca025 name="construct.a.apca025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca025
            #add-point:ON ACTION controlp INFIELD apca025 name="construct.c.apca025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca031
            #add-point:ON ACTION controlp INFIELD apca031 name="construct.c.apca031"
            #產生之差異折讓單號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apca019()
            DISPLAY g_qryparam.return1 TO apca031
            NEXT FIELD apca031
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca031
            #add-point:BEFORE FIELD apca031 name="construct.b.apca031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca031
            
            #add-point:AFTER FIELD apca031 name="construct.a.apca031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca030
            #add-point:BEFORE FIELD apca030 name="construct.b.apca030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca030
            
            #add-point:AFTER FIELD apca030 name="construct.a.apca030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca030
            #add-point:ON ACTION controlp INFIELD apca030 name="construct.c.apca030"
            #差異科目
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161115-00042#4 --s add
            SELECT ooef017 INTO g_apcacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_apcald FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_apcacomp
               AND glaa014 = 'Y'
            LET g_qryparam.where = " glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_apcald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161115-00042#4 --e add
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO apca030
            NEXT FIELD apca030
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca030_desc
            #add-point:BEFORE FIELD apca030_desc name="construct.b.apca030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca030_desc
            
            #add-point:AFTER FIELD apca030_desc name="construct.a.apca030_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca030_desc
            #add-point:ON ACTION controlp INFIELD apca030_desc name="construct.c.apca030_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca026
            #add-point:BEFORE FIELD apca026 name="construct.b.apca026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca026
            
            #add-point:AFTER FIELD apca026 name="construct.a.apca026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca026
            #add-point:ON ACTION controlp INFIELD apca026 name="construct.c.apca026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca027
            #add-point:BEFORE FIELD apca027 name="construct.b.apca027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca027
            
            #add-point:AFTER FIELD apca027 name="construct.a.apca027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca027
            #add-point:ON ACTION controlp INFIELD apca027 name="construct.c.apca027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca028
            #add-point:BEFORE FIELD apca028 name="construct.b.apca028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca028
            
            #add-point:AFTER FIELD apca028 name="construct.a.apca028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca028
            #add-point:ON ACTION controlp INFIELD apca028 name="construct.c.apca028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca029
            #add-point:BEFORE FIELD apca029 name="construct.b.apca029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca029
            
            #add-point:AFTER FIELD apca029 name="construct.a.apca029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca029
            #add-point:ON ACTION controlp INFIELD apca029 name="construct.c.apca029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca120
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca120
            #add-point:ON ACTION controlp INFIELD apca120 name="construct.c.apca120"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()
            DISPLAY g_qryparam.return1 TO apca120
            NEXT FIELD apca120
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca120
            #add-point:BEFORE FIELD apca120 name="construct.b.apca120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca120
            
            #add-point:AFTER FIELD apca120 name="construct.a.apca120"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca121
            #add-point:BEFORE FIELD apca121 name="construct.b.apca121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca121
            
            #add-point:AFTER FIELD apca121 name="construct.a.apca121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca121
            #add-point:ON ACTION controlp INFIELD apca121 name="construct.c.apca121"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca130
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca130
            #add-point:ON ACTION controlp INFIELD apca130 name="construct.c.apca130"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()
            DISPLAY g_qryparam.return1 TO apca130
            NEXT FIELD apca130
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca130
            #add-point:BEFORE FIELD apca130 name="construct.b.apca130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca130
            
            #add-point:AFTER FIELD apca130 name="construct.a.apca130"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca131
            #add-point:BEFORE FIELD apca131 name="construct.b.apca131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca131
            
            #add-point:AFTER FIELD apca131 name="construct.a.apca131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca131
            #add-point:ON ACTION controlp INFIELD apca131 name="construct.c.apca131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca123
            #add-point:BEFORE FIELD apca123 name="construct.b.apca123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca123
            
            #add-point:AFTER FIELD apca123 name="construct.a.apca123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca123
            #add-point:ON ACTION controlp INFIELD apca123 name="construct.c.apca123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca133
            #add-point:BEFORE FIELD apca133 name="construct.b.apca133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca133
            
            #add-point:AFTER FIELD apca133 name="construct.a.apca133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca133
            #add-point:ON ACTION controlp INFIELD apca133 name="construct.c.apca133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca124
            #add-point:BEFORE FIELD apca124 name="construct.b.apca124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca124
            
            #add-point:AFTER FIELD apca124 name="construct.a.apca124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca124
            #add-point:ON ACTION controlp INFIELD apca124 name="construct.c.apca124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca134
            #add-point:BEFORE FIELD apca134 name="construct.b.apca134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca134
            
            #add-point:AFTER FIELD apca134 name="construct.a.apca134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca134
            #add-point:ON ACTION controlp INFIELD apca134 name="construct.c.apca134"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca126
            #add-point:BEFORE FIELD apca126 name="construct.b.apca126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca126
            
            #add-point:AFTER FIELD apca126 name="construct.a.apca126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca126
            #add-point:ON ACTION controlp INFIELD apca126 name="construct.c.apca126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca136
            #add-point:BEFORE FIELD apca136 name="construct.b.apca136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca136
            
            #add-point:AFTER FIELD apca136 name="construct.a.apca136"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca136
            #add-point:ON ACTION controlp INFIELD apca136 name="construct.c.apca136"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca128
            #add-point:BEFORE FIELD apca128 name="construct.b.apca128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca128
            
            #add-point:AFTER FIELD apca128 name="construct.a.apca128"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca128
            #add-point:ON ACTION controlp INFIELD apca128 name="construct.c.apca128"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca138
            #add-point:BEFORE FIELD apca138 name="construct.b.apca138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca138
            
            #add-point:AFTER FIELD apca138 name="construct.a.apca138"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca138
            #add-point:ON ACTION controlp INFIELD apca138 name="construct.c.apca138"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apcaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcaownid
            #add-point:ON ACTION controlp INFIELD apcaownid name="construct.c.apcaownid"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apcaownid
            NEXT FIELD apcaownid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcaownid
            #add-point:BEFORE FIELD apcaownid name="construct.b.apcaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcaownid
            
            #add-point:AFTER FIELD apcaownid name="construct.a.apcaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcaowndp
            #add-point:ON ACTION controlp INFIELD apcaowndp name="construct.c.apcaowndp"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO apcaowndp
            NEXT FIELD apcaowndp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcaowndp
            #add-point:BEFORE FIELD apcaowndp name="construct.b.apcaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcaowndp
            
            #add-point:AFTER FIELD apcaowndp name="construct.a.apcaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcacrtid
            #add-point:ON ACTION controlp INFIELD apcacrtid name="construct.c.apcacrtid"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apcacrtid
            NEXT FIELD apcacrtid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcacrtid
            #add-point:BEFORE FIELD apcacrtid name="construct.b.apcacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcacrtid
            
            #add-point:AFTER FIELD apcacrtid name="construct.a.apcacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcacrtdp
            #add-point:ON ACTION controlp INFIELD apcacrtdp name="construct.c.apcacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           
            DISPLAY g_qryparam.return1 TO apcacrtdp  #顯示到畫面上
            NEXT FIELD apcacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcacrtdp
            #add-point:BEFORE FIELD apcacrtdp name="construct.b.apcacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcacrtdp
            
            #add-point:AFTER FIELD apcacrtdp name="construct.a.apcacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcacrtdt
            #add-point:BEFORE FIELD apcacrtdt name="construct.b.apcacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apcamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcamodid
            #add-point:ON ACTION controlp INFIELD apcamodid name="construct.c.apcamodid"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apcamodid
            NEXT FIELD apcamodid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcamodid
            #add-point:BEFORE FIELD apcamodid name="construct.b.apcamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcamodid
            
            #add-point:AFTER FIELD apcamodid name="construct.a.apcamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcamoddt
            #add-point:BEFORE FIELD apcamoddt name="construct.b.apcamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apcacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcacnfid
            #add-point:ON ACTION controlp INFIELD apcacnfid name="construct.c.apcacnfid"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apcacnfid
            NEXT FIELD apcacnfid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcacnfid
            #add-point:BEFORE FIELD apcacnfid name="construct.b.apcacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcacnfid
            
            #add-point:AFTER FIELD apcacnfid name="construct.a.apcacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcacnfdt
            #add-point:BEFORE FIELD apcacnfdt name="construct.b.apcacnfdt"
            
            #END add-point
 
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct name="cs.more_construct"
      #151013-00019#11 add ------
      CONSTRUCT BY NAME g_wc2 ON apca038,apca018
         BEFORE CONSTRUCT
         
      END CONSTRUCT
      #151013-00019#11 add end---
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
   #控制該作業可查詢的帳款單性質
   IF g_wc = ' 1=1' THEN
      LET g_wc = "apca001 IN (",s_fin_get_scc_gzcb002('8502','3',g_prog) ,")"
   ELSE
      LET g_wc = g_wc CLIPPED, " AND apca001 IN (",s_fin_get_scc_gzcb002('8502','3',g_prog) ,")" CLIPPED
   END IF
   LET g_wc = g_wc," AND ",g_user_dept_wc    #160518-00075#26 
  
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="aapq344.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapq344_query()
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
 
   INITIALIZE g_apca_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aapq344_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapq344_browser_fill(g_wc,"F")
      CALL aapq344_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aapq344_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aapq344_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aapq344.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapq344_fetch(p_fl)
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
   LET g_apca_m.apcald = g_browser[g_current_idx].b_apcald
   LET g_apca_m.apcadocno = g_browser[g_current_idx].b_apcadocno
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aapq344_master_referesh USING g_apca_m.apcald,g_apca_m.apcadocno INTO g_apca_m.apcasite,g_apca_m.apca003, 
       g_apca_m.apcald,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca057, 
       g_apca_m.apca038,g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca034, 
       g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104, 
       g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apca101,g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116, 
       g_apca_m.apca118,g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021, 
       g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051, 
       g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026,g_apca_m.apca027, 
       g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130,g_apca_m.apca131, 
       g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca124,g_apca_m.apca134,g_apca_m.apca126,g_apca_m.apca136, 
       g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcaownid,g_apca_m.apcaowndp,g_apca_m.apcacrtid,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamoddt,g_apca_m.apcacnfid,g_apca_m.apcacnfdt, 
       g_apca_m.apcasite_desc,g_apca_m.apca003_desc,g_apca_m.apcald_desc,g_apca_m.apca015_desc,g_apca_m.apca057_desc, 
       g_apca_m.apca014_desc,g_apca_m.apca034_desc,g_apca_m.apca033_desc,g_apca_m.apca007_desc,g_apca_m.apca035_desc, 
       g_apca_m.apca011_desc,g_apca_m.apca058_desc,g_apca_m.apcaownid_desc,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid_desc, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcamodid_desc,g_apca_m.apcacnfid_desc
   
   #遮罩相關處理
   LET g_apca_m_mask_o.* =  g_apca_m.*
   CALL aapq344_apca_t_mask()
   LET g_apca_m_mask_n.* =  g_apca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aapq344_set_act_visible()
   CALL aapq344_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_apca_m_t.* = g_apca_m.*
   LET g_apca_m_o.* = g_apca_m.*
   
   LET g_data_owner = g_apca_m.apcaownid      
   LET g_data_dept  = g_apca_m.apcaowndp
   
   #重新顯示
   CALL aapq344_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aapq344.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapq344_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_apca_m.* TO NULL             #DEFAULT 設定
   LET g_apcald_t = NULL
   LET g_apcadocno_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apca_m.apcaownid = g_user
      LET g_apca_m.apcaowndp = g_dept
      LET g_apca_m.apcacrtid = g_user
      LET g_apca_m.apcacrtdp = g_dept 
      LET g_apca_m.apcacrtdt = cl_get_current()
      LET g_apca_m.apcamodid = g_user
      LET g_apca_m.apcamoddt = cl_get_current()
      LET g_apca_m.apcastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apca_m.apcastus 
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
      CALL aapq344_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_apca_m.* TO NULL
         CALL aapq344_show()
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
   CALL aapq344_set_act_visible()
   CALL aapq344_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_apcald_t = g_apca_m.apcald
   LET g_apcadocno_t = g_apca_m.apcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apcaent = " ||g_enterprise|| " AND",
                      " apcald = '", g_apca_m.apcald, "' "
                      ," AND apcadocno = '", g_apca_m.apcadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapq344_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapq344_master_referesh USING g_apca_m.apcald,g_apca_m.apcadocno INTO g_apca_m.apcasite,g_apca_m.apca003, 
       g_apca_m.apcald,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca057, 
       g_apca_m.apca038,g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca034, 
       g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104, 
       g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apca101,g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116, 
       g_apca_m.apca118,g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021, 
       g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051, 
       g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026,g_apca_m.apca027, 
       g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130,g_apca_m.apca131, 
       g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca124,g_apca_m.apca134,g_apca_m.apca126,g_apca_m.apca136, 
       g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcaownid,g_apca_m.apcaowndp,g_apca_m.apcacrtid,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamoddt,g_apca_m.apcacnfid,g_apca_m.apcacnfdt, 
       g_apca_m.apcasite_desc,g_apca_m.apca003_desc,g_apca_m.apcald_desc,g_apca_m.apca015_desc,g_apca_m.apca057_desc, 
       g_apca_m.apca014_desc,g_apca_m.apca034_desc,g_apca_m.apca033_desc,g_apca_m.apca007_desc,g_apca_m.apca035_desc, 
       g_apca_m.apca011_desc,g_apca_m.apca058_desc,g_apca_m.apcaownid_desc,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid_desc, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcamodid_desc,g_apca_m.apcacnfid_desc
   
   
   #遮罩相關處理
   LET g_apca_m_mask_o.* =  g_apca_m.*
   CALL aapq344_apca_t_mask()
   LET g_apca_m_mask_n.* =  g_apca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apca_m.apcasite,g_apca_m.apcasite_desc,g_apca_m.apca003,g_apca_m.apca003_desc,g_apca_m.apcald, 
       g_apca_m.apcald_desc,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocno_desc,g_apca_m.apcadocdt, 
       g_apca_m.apca015,g_apca_m.apca015_desc,g_apca_m.apca057,g_apca_m.apca057_desc,g_apca_m.apca038, 
       g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca014_desc,g_apca_m.apca034, 
       g_apca_m.apca034_desc,g_apca_m.apca033,g_apca_m.apca033_desc,g_apca_m.apca007,g_apca_m.apca007_desc, 
       g_apca_m.apca035,g_apca_m.apca035_desc,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104,g_apca_m.apca106, 
       g_apca_m.apca108,g_apca_m.apcc109,g_apca_m.net108,g_apca_m.glaa001,g_apca_m.apca101,g_apca_m.apca113, 
       g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apcc113,g_apca_m.apca118,g_apca_m.apcc119,g_apca_m.net118, 
       g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca011_desc,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca058_desc,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048, 
       g_apca_m.apca021,g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017, 
       g_apca_m.apca051,g_apca_m.apca051_desc,g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030, 
       g_apca_m.apca030_desc,g_apca_m.apca026,g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca1001, 
       g_apca_m.apca1031,g_apca_m.apca1041,g_apca_m.apca1061,g_apca_m.fflabel_t3,g_apca_m.apca1081,g_apca_m.apcc1091, 
       g_apca_m.net1081,g_apca_m.glaa0011,g_apca_m.apca1011,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130, 
       g_apca_m.apca131,g_apca_m.apca1131,g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca1141,g_apca_m.apca124, 
       g_apca_m.apca134,g_apca_m.apca1161,g_apca_m.apca126,g_apca_m.apca136,g_apca_m.apcc1131,g_apca_m.apcc123, 
       g_apca_m.apcc133,g_apca_m.apca1181,g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcc1191,g_apca_m.apcc129, 
       g_apca_m.apcc139,g_apca_m.net1181,g_apca_m.net128,g_apca_m.net138,g_apca_m.apcaownid,g_apca_m.apcaownid_desc, 
       g_apca_m.apcaowndp,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid,g_apca_m.apcacrtid_desc,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamodid_desc,g_apca_m.apcamoddt, 
       g_apca_m.apcacnfid,g_apca_m.apcacnfid_desc,g_apca_m.apcacnfdt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_apca_m.apcaownid      
   LET g_data_dept  = g_apca_m.apcaowndp
 
   #功能已完成,通報訊息中心
   CALL aapq344_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapq344.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapq344_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_apca_m.apcald IS NULL
 
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
   LET g_apcald_t = g_apca_m.apcald
   LET g_apcadocno_t = g_apca_m.apcadocno
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aapq344_cl USING g_enterprise,g_apca_m.apcald,g_apca_m.apcadocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapq344_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aapq344_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapq344_master_referesh USING g_apca_m.apcald,g_apca_m.apcadocno INTO g_apca_m.apcasite,g_apca_m.apca003, 
       g_apca_m.apcald,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca057, 
       g_apca_m.apca038,g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca034, 
       g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104, 
       g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apca101,g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116, 
       g_apca_m.apca118,g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021, 
       g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051, 
       g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026,g_apca_m.apca027, 
       g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130,g_apca_m.apca131, 
       g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca124,g_apca_m.apca134,g_apca_m.apca126,g_apca_m.apca136, 
       g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcaownid,g_apca_m.apcaowndp,g_apca_m.apcacrtid,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamoddt,g_apca_m.apcacnfid,g_apca_m.apcacnfdt, 
       g_apca_m.apcasite_desc,g_apca_m.apca003_desc,g_apca_m.apcald_desc,g_apca_m.apca015_desc,g_apca_m.apca057_desc, 
       g_apca_m.apca014_desc,g_apca_m.apca034_desc,g_apca_m.apca033_desc,g_apca_m.apca007_desc,g_apca_m.apca035_desc, 
       g_apca_m.apca011_desc,g_apca_m.apca058_desc,g_apca_m.apcaownid_desc,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid_desc, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcamodid_desc,g_apca_m.apcacnfid_desc
 
   #檢查是否允許此動作
   IF NOT aapq344_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_apca_m_mask_o.* =  g_apca_m.*
   CALL aapq344_apca_t_mask()
   LET g_apca_m_mask_n.* =  g_apca_m.*
   
   
 
   #顯示資料
   CALL aapq344_show()
   
   WHILE TRUE
      LET g_apca_m.apcald = g_apcald_t
      LET g_apca_m.apcadocno = g_apcadocno_t
 
      
      #寫入修改者/修改日期資訊
      LET g_apca_m.apcamodid = g_user 
LET g_apca_m.apcamoddt = cl_get_current()
LET g_apca_m.apcamodid_desc = cl_get_username(g_apca_m.apcamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aapq344_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_apca_m.* = g_apca_m_t.*
         CALL aapq344_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE apca_t SET (apcamodid,apcamoddt) = (g_apca_m.apcamodid,g_apca_m.apcamoddt)
       WHERE apcaent = g_enterprise AND apcald = g_apcald_t
         AND apcadocno = g_apcadocno_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aapq344_set_act_visible()
   CALL aapq344_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apcaent = " ||g_enterprise|| " AND",
                      " apcald = '", g_apca_m.apcald, "' "
                      ," AND apcadocno = '", g_apca_m.apcadocno, "' "
 
   #填到對應位置
   CALL aapq344_browser_fill(g_wc,"")
 
   CLOSE aapq344_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapq344_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aapq344.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapq344_input(p_cmd)
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
   
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apca_m.apcasite,g_apca_m.apcasite_desc,g_apca_m.apca003,g_apca_m.apca003_desc,g_apca_m.apcald, 
       g_apca_m.apcald_desc,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocno_desc,g_apca_m.apcadocdt, 
       g_apca_m.apca015,g_apca_m.apca015_desc,g_apca_m.apca057,g_apca_m.apca057_desc,g_apca_m.apca038, 
       g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca014_desc,g_apca_m.apca034, 
       g_apca_m.apca034_desc,g_apca_m.apca033,g_apca_m.apca033_desc,g_apca_m.apca007,g_apca_m.apca007_desc, 
       g_apca_m.apca035,g_apca_m.apca035_desc,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104,g_apca_m.apca106, 
       g_apca_m.apca108,g_apca_m.apcc109,g_apca_m.net108,g_apca_m.glaa001,g_apca_m.apca101,g_apca_m.apca113, 
       g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apcc113,g_apca_m.apca118,g_apca_m.apcc119,g_apca_m.net118, 
       g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca011_desc,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca058_desc,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048, 
       g_apca_m.apca021,g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017, 
       g_apca_m.apca051,g_apca_m.apca051_desc,g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030, 
       g_apca_m.apca030_desc,g_apca_m.apca026,g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca1001, 
       g_apca_m.apca1031,g_apca_m.apca1041,g_apca_m.apca1061,g_apca_m.fflabel_t3,g_apca_m.apca1081,g_apca_m.apcc1091, 
       g_apca_m.net1081,g_apca_m.glaa0011,g_apca_m.apca1011,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130, 
       g_apca_m.apca131,g_apca_m.apca1131,g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca1141,g_apca_m.apca124, 
       g_apca_m.apca134,g_apca_m.apca1161,g_apca_m.apca126,g_apca_m.apca136,g_apca_m.apcc1131,g_apca_m.apcc123, 
       g_apca_m.apcc133,g_apca_m.apca1181,g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcc1191,g_apca_m.apcc129, 
       g_apca_m.apcc139,g_apca_m.net1181,g_apca_m.net128,g_apca_m.net138,g_apca_m.apcaownid,g_apca_m.apcaownid_desc, 
       g_apca_m.apcaowndp,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid,g_apca_m.apcacrtid_desc,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamodid_desc,g_apca_m.apcamoddt, 
       g_apca_m.apcacnfid,g_apca_m.apcacnfid_desc,g_apca_m.apcacnfdt
   
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
   CALL aapq344_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aapq344_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_apca_m.apcasite,g_apca_m.apca003,g_apca_m.apcald,g_apca_m.apcadocno,g_apca_m.apca001, 
          g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca057,g_apca_m.apcastus,g_apca_m.apca010,g_apca_m.apca014, 
          g_apca_m.apca034,g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103, 
          g_apca_m.apca104,g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apcc109,g_apca_m.net108,g_apca_m.apca101, 
          g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apcc113,g_apca_m.apca118,g_apca_m.apca065, 
          g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca013,g_apca_m.apca012,g_apca_m.apca060,g_apca_m.apca058, 
          g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021,g_apca_m.apca020,g_apca_m.apca022, 
          g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051,g_apca_m.apca053,g_apca_m.apca025, 
          g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026,g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029, 
          g_apca_m.apca1031,g_apca_m.apca120,g_apca_m.apca130,g_apca_m.apca131,g_apca_m.apca123,g_apca_m.apca133, 
          g_apca_m.apca124,g_apca_m.apca134,g_apca_m.apca126,g_apca_m.apca136,g_apca_m.apca128,g_apca_m.apca138, 
          g_apca_m.net1181 
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
         AFTER FIELD apcasite
            
            #add-point:AFTER FIELD apcasite name="input.a.apcasite"
            IF NOT cl_null(g_apca_m.apcasite) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_apca_m.apcasite
               #160318-00025#7--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aap-00004:sub-01302|aapi020|",cl_get_progname("aapi020",g_lang,"2"),"|:EXEPROGaapi020"
               #160318-00025#7--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_xrah002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apcasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apcasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apcasite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcasite
            #add-point:BEFORE FIELD apcasite name="input.b.apcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcasite
            #add-point:ON CHANGE apcasite name="input.g.apcasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca003
            
            #add-point:AFTER FIELD apca003 name="input.a.apca003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_apca_m.apca003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca003
            #add-point:BEFORE FIELD apca003 name="input.b.apca003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca003
            #add-point:ON CHANGE apca003 name="input.g.apca003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcald
            
            #add-point:AFTER FIELD apcald name="input.a.apcald"
            IF NOT cl_null(g_apca_m.apcald) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_apca_m.apcald
               #160318-00025#7--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#7--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glaald_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apcald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apcald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apcald_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_apca_m.apcald) AND NOT cl_null(g_apca_m.apcadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apca_m.apcald != g_apcald_t  OR g_apca_m.apcadocno != g_apcadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apca_t WHERE "||"apcaent = '" ||g_enterprise|| "' AND "||"apcald = '"||g_apca_m.apcald ||"' AND "|| "apcadocno = '"||g_apca_m.apcadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcald
            #add-point:BEFORE FIELD apcald name="input.b.apcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcald
            #add-point:ON CHANGE apcald name="input.g.apcald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocno
            
            #add-point:AFTER FIELD apcadocno name="input.a.apcadocno"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apcadocno
            CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apcadocno_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apcadocno_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_apca_m.apcald) AND NOT cl_null(g_apca_m.apcadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apca_m.apcald != g_apcald_t  OR g_apca_m.apcadocno != g_apcadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apca_t WHERE "||"apcaent = '" ||g_enterprise|| "' AND "||"apcald = '"||g_apca_m.apcald ||"' AND "|| "apcadocno = '"||g_apca_m.apcadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocno
            #add-point:BEFORE FIELD apcadocno name="input.b.apcadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocno
            #add-point:ON CHANGE apcadocno name="input.g.apcadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca001
            #add-point:BEFORE FIELD apca001 name="input.b.apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca001
            
            #add-point:AFTER FIELD apca001 name="input.a.apca001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca001
            #add-point:ON CHANGE apca001 name="input.g.apca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocdt
            #add-point:BEFORE FIELD apcadocdt name="input.b.apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocdt
            
            #add-point:AFTER FIELD apcadocdt name="input.a.apcadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocdt
            #add-point:ON CHANGE apcadocdt name="input.g.apcadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca015
            
            #add-point:AFTER FIELD apca015 name="input.a.apca015"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca015
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apca015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca015_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca015
            #add-point:BEFORE FIELD apca015 name="input.b.apca015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca015
            #add-point:ON CHANGE apca015 name="input.g.apca015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca057
            
            #add-point:AFTER FIELD apca057 name="input.a.apca057"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca057
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_apca_m.apca057_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca057_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca057
            #add-point:BEFORE FIELD apca057 name="input.b.apca057"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca057
            #add-point:ON CHANGE apca057 name="input.g.apca057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcastus
            #add-point:BEFORE FIELD apcastus name="input.b.apcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcastus
            
            #add-point:AFTER FIELD apcastus name="input.a.apcastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcastus
            #add-point:ON CHANGE apcastus name="input.g.apcastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca010
            #add-point:BEFORE FIELD apca010 name="input.b.apca010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca010
            
            #add-point:AFTER FIELD apca010 name="input.a.apca010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca010
            #add-point:ON CHANGE apca010 name="input.g.apca010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca014
            
            #add-point:AFTER FIELD apca014 name="input.a.apca014"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca014
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_apca_m.apca014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca014_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca014
            #add-point:BEFORE FIELD apca014 name="input.b.apca014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca014
            #add-point:ON CHANGE apca014 name="input.g.apca014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca034
            
            #add-point:AFTER FIELD apca034 name="input.a.apca034"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca034
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apca034_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca034_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca034
            #add-point:BEFORE FIELD apca034 name="input.b.apca034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca034
            #add-point:ON CHANGE apca034 name="input.g.apca034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca033
            
            #add-point:AFTER FIELD apca033 name="input.a.apca033"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca033
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apca033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca033_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca033
            #add-point:BEFORE FIELD apca033 name="input.b.apca033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca033
            #add-point:ON CHANGE apca033 name="input.g.apca033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca007
            
            #add-point:AFTER FIELD apca007 name="input.a.apca007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3211' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apca007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca007
            #add-point:BEFORE FIELD apca007 name="input.b.apca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca007
            #add-point:ON CHANGE apca007 name="input.g.apca007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca035
            
            #add-point:AFTER FIELD apca035 name="input.a.apca035"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca035
            #add-point:BEFORE FIELD apca035 name="input.b.apca035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca035
            #add-point:ON CHANGE apca035 name="input.g.apca035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca100
            #add-point:BEFORE FIELD apca100 name="input.b.apca100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca100
            
            #add-point:AFTER FIELD apca100 name="input.a.apca100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca100
            #add-point:ON CHANGE apca100 name="input.g.apca100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca103
            #add-point:BEFORE FIELD apca103 name="input.b.apca103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca103
            
            #add-point:AFTER FIELD apca103 name="input.a.apca103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca103
            #add-point:ON CHANGE apca103 name="input.g.apca103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca104
            #add-point:BEFORE FIELD apca104 name="input.b.apca104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca104
            
            #add-point:AFTER FIELD apca104 name="input.a.apca104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca104
            #add-point:ON CHANGE apca104 name="input.g.apca104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca106
            #add-point:BEFORE FIELD apca106 name="input.b.apca106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca106
            
            #add-point:AFTER FIELD apca106 name="input.a.apca106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca106
            #add-point:ON CHANGE apca106 name="input.g.apca106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca108
            #add-point:BEFORE FIELD apca108 name="input.b.apca108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca108
            
            #add-point:AFTER FIELD apca108 name="input.a.apca108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca108
            #add-point:ON CHANGE apca108 name="input.g.apca108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc109
            #add-point:BEFORE FIELD apcc109 name="input.b.apcc109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc109
            
            #add-point:AFTER FIELD apcc109 name="input.a.apcc109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc109
            #add-point:ON CHANGE apcc109 name="input.g.apcc109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD net108
            #add-point:BEFORE FIELD net108 name="input.b.net108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD net108
            
            #add-point:AFTER FIELD net108 name="input.a.net108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE net108
            #add-point:ON CHANGE net108 name="input.g.net108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca101
            #add-point:BEFORE FIELD apca101 name="input.b.apca101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca101
            
            #add-point:AFTER FIELD apca101 name="input.a.apca101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca101
            #add-point:ON CHANGE apca101 name="input.g.apca101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca113
            #add-point:BEFORE FIELD apca113 name="input.b.apca113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca113
            
            #add-point:AFTER FIELD apca113 name="input.a.apca113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca113
            #add-point:ON CHANGE apca113 name="input.g.apca113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca114
            #add-point:BEFORE FIELD apca114 name="input.b.apca114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca114
            
            #add-point:AFTER FIELD apca114 name="input.a.apca114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca114
            #add-point:ON CHANGE apca114 name="input.g.apca114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca116
            #add-point:BEFORE FIELD apca116 name="input.b.apca116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca116
            
            #add-point:AFTER FIELD apca116 name="input.a.apca116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca116
            #add-point:ON CHANGE apca116 name="input.g.apca116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc113
            #add-point:BEFORE FIELD apcc113 name="input.b.apcc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc113
            
            #add-point:AFTER FIELD apcc113 name="input.a.apcc113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc113
            #add-point:ON CHANGE apcc113 name="input.g.apcc113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca118
            #add-point:BEFORE FIELD apca118 name="input.b.apca118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca118
            
            #add-point:AFTER FIELD apca118 name="input.a.apca118"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca118
            #add-point:ON CHANGE apca118 name="input.g.apca118"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD net118
            #add-point:BEFORE FIELD net118 name="input.b.net118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD net118
            
            #add-point:AFTER FIELD net118 name="input.a.net118"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE net118
            #add-point:ON CHANGE net118 name="input.g.net118"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca065
            #add-point:BEFORE FIELD apca065 name="input.b.apca065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca065
            
            #add-point:AFTER FIELD apca065 name="input.a.apca065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca065
            #add-point:ON CHANGE apca065 name="input.g.apca065"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca066
            #add-point:BEFORE FIELD apca066 name="input.b.apca066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca066
            
            #add-point:AFTER FIELD apca066 name="input.a.apca066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca066
            #add-point:ON CHANGE apca066 name="input.g.apca066"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca011
            
            #add-point:AFTER FIELD apca011 name="input.a.apca011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca011
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apca011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca011
            #add-point:BEFORE FIELD apca011 name="input.b.apca011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca011
            #add-point:ON CHANGE apca011 name="input.g.apca011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca013
            #add-point:BEFORE FIELD apca013 name="input.b.apca013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca013
            
            #add-point:AFTER FIELD apca013 name="input.a.apca013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca013
            #add-point:ON CHANGE apca013 name="input.g.apca013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca012
            #add-point:BEFORE FIELD apca012 name="input.b.apca012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca012
            
            #add-point:AFTER FIELD apca012 name="input.a.apca012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca012
            #add-point:ON CHANGE apca012 name="input.g.apca012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca060
            #add-point:BEFORE FIELD apca060 name="input.b.apca060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca060
            
            #add-point:AFTER FIELD apca060 name="input.a.apca060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca060
            #add-point:ON CHANGE apca060 name="input.g.apca060"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca058
            
            #add-point:AFTER FIELD apca058 name="input.a.apca058"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apca_m.apca058
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='264' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apca_m.apca058_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apca_m.apca058_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca058
            #add-point:BEFORE FIELD apca058 name="input.b.apca058"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca058
            #add-point:ON CHANGE apca058 name="input.g.apca058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca046
            #add-point:BEFORE FIELD apca046 name="input.b.apca046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca046
            
            #add-point:AFTER FIELD apca046 name="input.a.apca046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca046
            #add-point:ON CHANGE apca046 name="input.g.apca046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca047
            #add-point:BEFORE FIELD apca047 name="input.b.apca047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca047
            
            #add-point:AFTER FIELD apca047 name="input.a.apca047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca047
            #add-point:ON CHANGE apca047 name="input.g.apca047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca048
            #add-point:BEFORE FIELD apca048 name="input.b.apca048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca048
            
            #add-point:AFTER FIELD apca048 name="input.a.apca048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca048
            #add-point:ON CHANGE apca048 name="input.g.apca048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca021
            #add-point:BEFORE FIELD apca021 name="input.b.apca021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca021
            
            #add-point:AFTER FIELD apca021 name="input.a.apca021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca021
            #add-point:ON CHANGE apca021 name="input.g.apca021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca020
            #add-point:BEFORE FIELD apca020 name="input.b.apca020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca020
            
            #add-point:AFTER FIELD apca020 name="input.a.apca020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca020
            #add-point:ON CHANGE apca020 name="input.g.apca020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca022
            #add-point:BEFORE FIELD apca022 name="input.b.apca022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca022
            
            #add-point:AFTER FIELD apca022 name="input.a.apca022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca022
            #add-point:ON CHANGE apca022 name="input.g.apca022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca063
            #add-point:BEFORE FIELD apca063 name="input.b.apca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca063
            
            #add-point:AFTER FIELD apca063 name="input.a.apca063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca063
            #add-point:ON CHANGE apca063 name="input.g.apca063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca052
            #add-point:BEFORE FIELD apca052 name="input.b.apca052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca052
            
            #add-point:AFTER FIELD apca052 name="input.a.apca052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca052
            #add-point:ON CHANGE apca052 name="input.g.apca052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca017
            #add-point:BEFORE FIELD apca017 name="input.b.apca017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca017
            
            #add-point:AFTER FIELD apca017 name="input.a.apca017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca017
            #add-point:ON CHANGE apca017 name="input.g.apca017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca051
            
            #add-point:AFTER FIELD apca051 name="input.a.apca051"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca051
            #add-point:BEFORE FIELD apca051 name="input.b.apca051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca051
            #add-point:ON CHANGE apca051 name="input.g.apca051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca053
            #add-point:BEFORE FIELD apca053 name="input.b.apca053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca053
            
            #add-point:AFTER FIELD apca053 name="input.a.apca053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca053
            #add-point:ON CHANGE apca053 name="input.g.apca053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca025
            #add-point:BEFORE FIELD apca025 name="input.b.apca025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca025
            
            #add-point:AFTER FIELD apca025 name="input.a.apca025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca025
            #add-point:ON CHANGE apca025 name="input.g.apca025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca031
            #add-point:BEFORE FIELD apca031 name="input.b.apca031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca031
            
            #add-point:AFTER FIELD apca031 name="input.a.apca031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca031
            #add-point:ON CHANGE apca031 name="input.g.apca031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca030
            
            #add-point:AFTER FIELD apca030 name="input.a.apca030"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca030
            #add-point:BEFORE FIELD apca030 name="input.b.apca030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca030
            #add-point:ON CHANGE apca030 name="input.g.apca030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca026
            #add-point:BEFORE FIELD apca026 name="input.b.apca026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca026
            
            #add-point:AFTER FIELD apca026 name="input.a.apca026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca026
            #add-point:ON CHANGE apca026 name="input.g.apca026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca027
            #add-point:BEFORE FIELD apca027 name="input.b.apca027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca027
            
            #add-point:AFTER FIELD apca027 name="input.a.apca027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca027
            #add-point:ON CHANGE apca027 name="input.g.apca027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca028
            #add-point:BEFORE FIELD apca028 name="input.b.apca028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca028
            
            #add-point:AFTER FIELD apca028 name="input.a.apca028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca028
            #add-point:ON CHANGE apca028 name="input.g.apca028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca029
            #add-point:BEFORE FIELD apca029 name="input.b.apca029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca029
            
            #add-point:AFTER FIELD apca029 name="input.a.apca029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca029
            #add-point:ON CHANGE apca029 name="input.g.apca029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca1031
            #add-point:BEFORE FIELD apca1031 name="input.b.apca1031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca1031
            
            #add-point:AFTER FIELD apca1031 name="input.a.apca1031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca1031
            #add-point:ON CHANGE apca1031 name="input.g.apca1031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca120
            #add-point:BEFORE FIELD apca120 name="input.b.apca120"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca120
            
            #add-point:AFTER FIELD apca120 name="input.a.apca120"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca120
            #add-point:ON CHANGE apca120 name="input.g.apca120"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca130
            #add-point:BEFORE FIELD apca130 name="input.b.apca130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca130
            
            #add-point:AFTER FIELD apca130 name="input.a.apca130"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca130
            #add-point:ON CHANGE apca130 name="input.g.apca130"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca131
            #add-point:BEFORE FIELD apca131 name="input.b.apca131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca131
            
            #add-point:AFTER FIELD apca131 name="input.a.apca131"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca131
            #add-point:ON CHANGE apca131 name="input.g.apca131"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca123
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apca_m.apca123,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apca123
            END IF 
 
 
 
            #add-point:AFTER FIELD apca123 name="input.a.apca123"
            IF NOT cl_null(g_apca_m.apca123) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca123
            #add-point:BEFORE FIELD apca123 name="input.b.apca123"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca123
            #add-point:ON CHANGE apca123 name="input.g.apca123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca133
            #add-point:BEFORE FIELD apca133 name="input.b.apca133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca133
            
            #add-point:AFTER FIELD apca133 name="input.a.apca133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca133
            #add-point:ON CHANGE apca133 name="input.g.apca133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca124
            #add-point:BEFORE FIELD apca124 name="input.b.apca124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca124
            
            #add-point:AFTER FIELD apca124 name="input.a.apca124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca124
            #add-point:ON CHANGE apca124 name="input.g.apca124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca134
            #add-point:BEFORE FIELD apca134 name="input.b.apca134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca134
            
            #add-point:AFTER FIELD apca134 name="input.a.apca134"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca134
            #add-point:ON CHANGE apca134 name="input.g.apca134"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca126
            #add-point:BEFORE FIELD apca126 name="input.b.apca126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca126
            
            #add-point:AFTER FIELD apca126 name="input.a.apca126"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca126
            #add-point:ON CHANGE apca126 name="input.g.apca126"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca136
            #add-point:BEFORE FIELD apca136 name="input.b.apca136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca136
            
            #add-point:AFTER FIELD apca136 name="input.a.apca136"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca136
            #add-point:ON CHANGE apca136 name="input.g.apca136"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca128
            #add-point:BEFORE FIELD apca128 name="input.b.apca128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca128
            
            #add-point:AFTER FIELD apca128 name="input.a.apca128"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca128
            #add-point:ON CHANGE apca128 name="input.g.apca128"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca138
            #add-point:BEFORE FIELD apca138 name="input.b.apca138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca138
            
            #add-point:AFTER FIELD apca138 name="input.a.apca138"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca138
            #add-point:ON CHANGE apca138 name="input.g.apca138"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD net1181
            #add-point:BEFORE FIELD net1181 name="input.b.net1181"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD net1181
            
            #add-point:AFTER FIELD net1181 name="input.a.net1181"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE net1181
            #add-point:ON CHANGE net1181 name="input.g.net1181"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apcasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcasite
            #add-point:ON ACTION controlp INFIELD apcasite name="input.c.apcasite"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca003
            #add-point:ON ACTION controlp INFIELD apca003 name="input.c.apca003"
 
            #END add-point
 
 
         #Ctrlp:input.c.apcald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="input.c.apcald"
 
            #END add-point
 
 
         #Ctrlp:input.c.apcadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocno
            #add-point:ON ACTION controlp INFIELD apcadocno name="input.c.apcadocno"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="input.c.apca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocdt
            #add-point:ON ACTION controlp INFIELD apcadocdt name="input.c.apcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca015
            #add-point:ON ACTION controlp INFIELD apca015 name="input.c.apca015"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca057
            #add-point:ON ACTION controlp INFIELD apca057 name="input.c.apca057"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcastus
            #add-point:ON ACTION controlp INFIELD apcastus name="input.c.apcastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca010
            #add-point:ON ACTION controlp INFIELD apca010 name="input.c.apca010"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca014
            #add-point:ON ACTION controlp INFIELD apca014 name="input.c.apca014"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca034
            #add-point:ON ACTION controlp INFIELD apca034 name="input.c.apca034"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca033
            #add-point:ON ACTION controlp INFIELD apca033 name="input.c.apca033"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca007
            #add-point:ON ACTION controlp INFIELD apca007 name="input.c.apca007"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca035
            #add-point:ON ACTION controlp INFIELD apca035 name="input.c.apca035"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca100
            #add-point:ON ACTION controlp INFIELD apca100 name="input.c.apca100"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca103
            #add-point:ON ACTION controlp INFIELD apca103 name="input.c.apca103"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca104
            #add-point:ON ACTION controlp INFIELD apca104 name="input.c.apca104"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca106
            #add-point:ON ACTION controlp INFIELD apca106 name="input.c.apca106"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca108
            #add-point:ON ACTION controlp INFIELD apca108 name="input.c.apca108"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcc109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc109
            #add-point:ON ACTION controlp INFIELD apcc109 name="input.c.apcc109"
            
            #END add-point
 
 
         #Ctrlp:input.c.net108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD net108
            #add-point:ON ACTION controlp INFIELD net108 name="input.c.net108"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca101
            #add-point:ON ACTION controlp INFIELD apca101 name="input.c.apca101"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca113
            #add-point:ON ACTION controlp INFIELD apca113 name="input.c.apca113"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca114
            #add-point:ON ACTION controlp INFIELD apca114 name="input.c.apca114"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca116
            #add-point:ON ACTION controlp INFIELD apca116 name="input.c.apca116"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc113
            #add-point:ON ACTION controlp INFIELD apcc113 name="input.c.apcc113"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca118
            #add-point:ON ACTION controlp INFIELD apca118 name="input.c.apca118"
            
            #END add-point
 
 
         #Ctrlp:input.c.net118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD net118
            #add-point:ON ACTION controlp INFIELD net118 name="input.c.net118"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca065
            #add-point:ON ACTION controlp INFIELD apca065 name="input.c.apca065"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca066
            #add-point:ON ACTION controlp INFIELD apca066 name="input.c.apca066"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca011
            #add-point:ON ACTION controlp INFIELD apca011 name="input.c.apca011"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca013
            #add-point:ON ACTION controlp INFIELD apca013 name="input.c.apca013"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca012
            #add-point:ON ACTION controlp INFIELD apca012 name="input.c.apca012"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca060
            #add-point:ON ACTION controlp INFIELD apca060 name="input.c.apca060"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca058
            #add-point:ON ACTION controlp INFIELD apca058 name="input.c.apca058"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca046
            #add-point:ON ACTION controlp INFIELD apca046 name="input.c.apca046"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca047
            #add-point:ON ACTION controlp INFIELD apca047 name="input.c.apca047"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca048
            #add-point:ON ACTION controlp INFIELD apca048 name="input.c.apca048"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca021
            #add-point:ON ACTION controlp INFIELD apca021 name="input.c.apca021"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca020
            #add-point:ON ACTION controlp INFIELD apca020 name="input.c.apca020"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca022
            #add-point:ON ACTION controlp INFIELD apca022 name="input.c.apca022"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca063
            #add-point:ON ACTION controlp INFIELD apca063 name="input.c.apca063"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca052
            #add-point:ON ACTION controlp INFIELD apca052 name="input.c.apca052"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca017
            #add-point:ON ACTION controlp INFIELD apca017 name="input.c.apca017"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca051
            #add-point:ON ACTION controlp INFIELD apca051 name="input.c.apca051"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca053
            #add-point:ON ACTION controlp INFIELD apca053 name="input.c.apca053"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca025
            #add-point:ON ACTION controlp INFIELD apca025 name="input.c.apca025"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca031
            #add-point:ON ACTION controlp INFIELD apca031 name="input.c.apca031"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca030
            #add-point:ON ACTION controlp INFIELD apca030 name="input.c.apca030"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca026
            #add-point:ON ACTION controlp INFIELD apca026 name="input.c.apca026"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca027
            #add-point:ON ACTION controlp INFIELD apca027 name="input.c.apca027"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca028
            #add-point:ON ACTION controlp INFIELD apca028 name="input.c.apca028"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca029
            #add-point:ON ACTION controlp INFIELD apca029 name="input.c.apca029"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca1031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca1031
            #add-point:ON ACTION controlp INFIELD apca1031 name="input.c.apca1031"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca120
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca120
            #add-point:ON ACTION controlp INFIELD apca120 name="input.c.apca120"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca130
            #add-point:ON ACTION controlp INFIELD apca130 name="input.c.apca130"
 
            #END add-point
 
 
         #Ctrlp:input.c.apca131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca131
            #add-point:ON ACTION controlp INFIELD apca131 name="input.c.apca131"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca123
            #add-point:ON ACTION controlp INFIELD apca123 name="input.c.apca123"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca133
            #add-point:ON ACTION controlp INFIELD apca133 name="input.c.apca133"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca124
            #add-point:ON ACTION controlp INFIELD apca124 name="input.c.apca124"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca134
            #add-point:ON ACTION controlp INFIELD apca134 name="input.c.apca134"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca126
            #add-point:ON ACTION controlp INFIELD apca126 name="input.c.apca126"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca136
            #add-point:ON ACTION controlp INFIELD apca136 name="input.c.apca136"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca128
            #add-point:ON ACTION controlp INFIELD apca128 name="input.c.apca128"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca138
            #add-point:ON ACTION controlp INFIELD apca138 name="input.c.apca138"
            
            #END add-point
 
 
         #Ctrlp:input.c.net1181
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD net1181
            #add-point:ON ACTION controlp INFIELD net1181 name="input.c.net1181"
            
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
               SELECT COUNT(1) INTO l_count FROM apca_t
                WHERE apcaent = g_enterprise AND apcald = g_apca_m.apcald
                  AND apcadocno = g_apca_m.apcadocno
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO apca_t (apcaent,apcasite,apca003,apcald,apcadocno,apca001,apcadocdt,apca015, 
                      apca057,apca038,apcastus,apca018,apca010,apca014,apca034,apca033,apca007,apca035, 
                      apca100,apca103,apca104,apca106,apca108,apca101,apca113,apca114,apca116,apca118, 
                      apca065,apca066,apca011,apca013,apca012,apca060,apca058,apca046,apca047,apca048, 
                      apca021,apca020,apca022,apca063,apca052,apca017,apca051,apca053,apca025,apca031, 
                      apca030,apca026,apca027,apca028,apca029,apca120,apca121,apca130,apca131,apca123, 
                      apca133,apca124,apca134,apca126,apca136,apca128,apca138,apcaownid,apcaowndp,apcacrtid, 
                      apcacrtdp,apcacrtdt,apcamodid,apcamoddt,apcacnfid,apcacnfdt)
                  VALUES (g_enterprise,g_apca_m.apcasite,g_apca_m.apca003,g_apca_m.apcald,g_apca_m.apcadocno, 
                      g_apca_m.apca001,g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca057,g_apca_m.apca038, 
                      g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca034, 
                      g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103, 
                      g_apca_m.apca104,g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apca101,g_apca_m.apca113, 
                      g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apca118,g_apca_m.apca065,g_apca_m.apca066, 
                      g_apca_m.apca011,g_apca_m.apca013,g_apca_m.apca012,g_apca_m.apca060,g_apca_m.apca058, 
                      g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021,g_apca_m.apca020, 
                      g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051, 
                      g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026, 
                      g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca120,g_apca_m.apca121, 
                      g_apca_m.apca130,g_apca_m.apca131,g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca124, 
                      g_apca_m.apca134,g_apca_m.apca126,g_apca_m.apca136,g_apca_m.apca128,g_apca_m.apca138, 
                      g_apca_m.apcaownid,g_apca_m.apcaowndp,g_apca_m.apcacrtid,g_apca_m.apcacrtdp,g_apca_m.apcacrtdt, 
                      g_apca_m.apcamodid,g_apca_m.apcamoddt,g_apca_m.apcacnfid,g_apca_m.apcacnfdt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apca_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_apca_m.apcald
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapq344_apca_t_mask_restore('restore_mask_o')
               
               UPDATE apca_t SET (apcasite,apca003,apcald,apcadocno,apca001,apcadocdt,apca015,apca057, 
                   apca038,apcastus,apca018,apca010,apca014,apca034,apca033,apca007,apca035,apca100, 
                   apca103,apca104,apca106,apca108,apca101,apca113,apca114,apca116,apca118,apca065,apca066, 
                   apca011,apca013,apca012,apca060,apca058,apca046,apca047,apca048,apca021,apca020,apca022, 
                   apca063,apca052,apca017,apca051,apca053,apca025,apca031,apca030,apca026,apca027,apca028, 
                   apca029,apca120,apca121,apca130,apca131,apca123,apca133,apca124,apca134,apca126,apca136, 
                   apca128,apca138,apcaownid,apcaowndp,apcacrtid,apcacrtdp,apcacrtdt,apcamodid,apcamoddt, 
                   apcacnfid,apcacnfdt) = (g_apca_m.apcasite,g_apca_m.apca003,g_apca_m.apcald,g_apca_m.apcadocno, 
                   g_apca_m.apca001,g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca057,g_apca_m.apca038, 
                   g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca034, 
                   g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103, 
                   g_apca_m.apca104,g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apca101,g_apca_m.apca113, 
                   g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apca118,g_apca_m.apca065,g_apca_m.apca066, 
                   g_apca_m.apca011,g_apca_m.apca013,g_apca_m.apca012,g_apca_m.apca060,g_apca_m.apca058, 
                   g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021,g_apca_m.apca020, 
                   g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051, 
                   g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026, 
                   g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca120,g_apca_m.apca121, 
                   g_apca_m.apca130,g_apca_m.apca131,g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca124, 
                   g_apca_m.apca134,g_apca_m.apca126,g_apca_m.apca136,g_apca_m.apca128,g_apca_m.apca138, 
                   g_apca_m.apcaownid,g_apca_m.apcaowndp,g_apca_m.apcacrtid,g_apca_m.apcacrtdp,g_apca_m.apcacrtdt, 
                   g_apca_m.apcamodid,g_apca_m.apcamoddt,g_apca_m.apcacnfid,g_apca_m.apcacnfdt)
                WHERE apcaent = g_enterprise AND apcald = g_apcald_t #
                  AND apcadocno = g_apcadocno_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apca_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apca_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL aapq344_apca_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_apca_m_t)
                     LET g_log2 = util.JSON.stringify(g_apca_m)
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
 
{<section id="aapq344.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapq344_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE apca_t.apcald 
   DEFINE l_oldno     LIKE apca_t.apcald 
   DEFINE l_newno02     LIKE apca_t.apcadocno 
   DEFINE l_oldno02     LIKE apca_t.apcadocno 
 
   DEFINE l_master    RECORD LIKE apca_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_apca_m.apcald IS NULL
      OR g_apca_m.apcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_apcald_t = g_apca_m.apcald
   LET g_apcadocno_t = g_apca_m.apcadocno
 
   
   #清空key值
   LET g_apca_m.apcald = ""
   LET g_apca_m.apcadocno = ""
 
    
   CALL aapq344_set_entry("a")
   CALL aapq344_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apca_m.apcaownid = g_user
      LET g_apca_m.apcaowndp = g_dept
      LET g_apca_m.apcacrtid = g_user
      LET g_apca_m.apcacrtdp = g_dept 
      LET g_apca_m.apcacrtdt = cl_get_current()
      LET g_apca_m.apcamodid = g_user
      LET g_apca_m.apcamoddt = cl_get_current()
      LET g_apca_m.apcastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apca_m.apcastus 
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
      LET g_apca_m.apcald_desc = ''
   DISPLAY BY NAME g_apca_m.apcald_desc
   LET g_apca_m.apcadocno_desc = ''
   DISPLAY BY NAME g_apca_m.apcadocno_desc
 
   
   #資料輸入
   CALL aapq344_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_apca_m.* TO NULL
      CALL aapq344_show()
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
      LET g_errparam.extend = "apca_t:",SQLERRMESSAGE 
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
   CALL aapq344_set_act_visible()
   CALL aapq344_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_apcald_t = g_apca_m.apcald
   LET g_apcadocno_t = g_apca_m.apcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apcaent = " ||g_enterprise|| " AND",
                      " apcald = '", g_apca_m.apcald, "' "
                      ," AND apcadocno = '", g_apca_m.apcadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapq344_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_apca_m.apcaownid      
   LET g_data_dept  = g_apca_m.apcaowndp
              
   #功能已完成,通報訊息中心
   CALL aapq344_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aapq344.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aapq344_show()
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
   CALL aapq344_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL aapt300_13_show_lien (g_apca_m.apcald,g_apca_m.apcadocno)
   CALL aapq344_set_ld_info(g_apca_m.apcald)
   CALL aapq344_curr_info_master()
   LET g_apca_m.apca1001 = g_apca_m.apca100
   LET g_apca_m.apca1011 = g_apca_m.apca101
   #LET g_apca_m.apcadocno_desc= s_aooi200_get_slip_desc(g_apca_m.apcadocno)               #單別
   LET g_apca_m.apcadocno_desc= s_aooi200_fin_get_slip_desc(g_apca_m.apcadocno)           #單別
   LET g_apca_m.apca011_desc  = s_desc_get_tax_desc(g_ooef019,g_apca_m.apca011)           #稅別
   LET g_apca_m.apca035_desc  = s_desc_get_account_desc(g_apca_m.apcald,g_apca_m.apca035) #會計科目(待沖銷科目)
   LET g_apca_m.apca033_desc  = s_desc_get_project_desc(g_apca_m.apca033)                 #專案編號
   LET g_apca_m.apca051_desc  = s_desc_get_acc_desc('3115',g_apca_m.apca051)              #作廢理由碼
   LET g_apca_m.apca030_desc  = s_desc_get_account_desc(g_apca_m.apcald,g_apca_m.apca030) #會計科目(差異科目)

   #取得來源單據的傳票號碼
   SELECT apca038 INTO g_apca_m.apca038
     FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcald = g_apca_m.apcald
      AND apcadocno = g_apca_m.apca018
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apca_m.apcasite,g_apca_m.apcasite_desc,g_apca_m.apca003,g_apca_m.apca003_desc,g_apca_m.apcald, 
       g_apca_m.apcald_desc,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocno_desc,g_apca_m.apcadocdt, 
       g_apca_m.apca015,g_apca_m.apca015_desc,g_apca_m.apca057,g_apca_m.apca057_desc,g_apca_m.apca038, 
       g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca014_desc,g_apca_m.apca034, 
       g_apca_m.apca034_desc,g_apca_m.apca033,g_apca_m.apca033_desc,g_apca_m.apca007,g_apca_m.apca007_desc, 
       g_apca_m.apca035,g_apca_m.apca035_desc,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104,g_apca_m.apca106, 
       g_apca_m.apca108,g_apca_m.apcc109,g_apca_m.net108,g_apca_m.glaa001,g_apca_m.apca101,g_apca_m.apca113, 
       g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apcc113,g_apca_m.apca118,g_apca_m.apcc119,g_apca_m.net118, 
       g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca011_desc,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca058_desc,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048, 
       g_apca_m.apca021,g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017, 
       g_apca_m.apca051,g_apca_m.apca051_desc,g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030, 
       g_apca_m.apca030_desc,g_apca_m.apca026,g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca1001, 
       g_apca_m.apca1031,g_apca_m.apca1041,g_apca_m.apca1061,g_apca_m.fflabel_t3,g_apca_m.apca1081,g_apca_m.apcc1091, 
       g_apca_m.net1081,g_apca_m.glaa0011,g_apca_m.apca1011,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130, 
       g_apca_m.apca131,g_apca_m.apca1131,g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca1141,g_apca_m.apca124, 
       g_apca_m.apca134,g_apca_m.apca1161,g_apca_m.apca126,g_apca_m.apca136,g_apca_m.apcc1131,g_apca_m.apcc123, 
       g_apca_m.apcc133,g_apca_m.apca1181,g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcc1191,g_apca_m.apcc129, 
       g_apca_m.apcc139,g_apca_m.net1181,g_apca_m.net128,g_apca_m.net138,g_apca_m.apcaownid,g_apca_m.apcaownid_desc, 
       g_apca_m.apcaowndp,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid,g_apca_m.apcacrtid_desc,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamodid_desc,g_apca_m.apcamoddt, 
       g_apca_m.apcacnfid,g_apca_m.apcacnfid_desc,g_apca_m.apcacnfdt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aapq344_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apca_m.apcastus 
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
 
{<section id="aapq344.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aapq344_delete()
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
   IF g_apca_m.apcald IS NULL
   OR g_apca_m.apcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_apcald_t = g_apca_m.apcald
   LET g_apcadocno_t = g_apca_m.apcadocno
 
   
   
 
   OPEN aapq344_cl USING g_enterprise,g_apca_m.apcald,g_apca_m.apcadocno
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapq344_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aapq344_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapq344_master_referesh USING g_apca_m.apcald,g_apca_m.apcadocno INTO g_apca_m.apcasite,g_apca_m.apca003, 
       g_apca_m.apcald,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca057, 
       g_apca_m.apca038,g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca034, 
       g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104, 
       g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apca101,g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116, 
       g_apca_m.apca118,g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021, 
       g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051, 
       g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026,g_apca_m.apca027, 
       g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130,g_apca_m.apca131, 
       g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca124,g_apca_m.apca134,g_apca_m.apca126,g_apca_m.apca136, 
       g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcaownid,g_apca_m.apcaowndp,g_apca_m.apcacrtid,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamoddt,g_apca_m.apcacnfid,g_apca_m.apcacnfdt, 
       g_apca_m.apcasite_desc,g_apca_m.apca003_desc,g_apca_m.apcald_desc,g_apca_m.apca015_desc,g_apca_m.apca057_desc, 
       g_apca_m.apca014_desc,g_apca_m.apca034_desc,g_apca_m.apca033_desc,g_apca_m.apca007_desc,g_apca_m.apca035_desc, 
       g_apca_m.apca011_desc,g_apca_m.apca058_desc,g_apca_m.apcaownid_desc,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid_desc, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcamodid_desc,g_apca_m.apcacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aapq344_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apca_m_mask_o.* =  g_apca_m.*
   CALL aapq344_apca_t_mask()
   LET g_apca_m_mask_n.* =  g_apca_m.*
   
   #將最新資料顯示到畫面上
   CALL aapq344_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapq344_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM apca_t 
       WHERE apcaent = g_enterprise AND apcald = g_apca_m.apcald 
         AND apcadocno = g_apca_m.apcadocno 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apca_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_apca_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aapq344_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aapq344_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aapq344_browser_fill(g_wc,"")
         CALL aapq344_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapq344_cl
 
   #功能已完成,通報訊息中心
   CALL aapq344_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq344.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapq344_ui_browser_refresh()
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
      IF g_browser[l_i].b_apcald = g_apca_m.apcald
         AND g_browser[l_i].b_apcadocno = g_apca_m.apcadocno
 
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
 
{<section id="aapq344.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapq344_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("apcald,apcadocno",TRUE)
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
 
{<section id="aapq344.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapq344_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apcald,apcadocno",FALSE)
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
 
{<section id="aapq344.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapq344_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapq344.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapq344_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapq344.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapq344_default_search()
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
      LET ls_wc = ls_wc, " apcald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apcadocno = '", g_argv[02], "' AND "
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
 
{<section id="aapq344.mask_functions" >}
&include "erp/aap/aapq344_mask.4gl"
 
{</section>}
 
{<section id="aapq344.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapq344_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   RETURN
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_apca_m.apcald IS NULL
      OR g_apca_m.apcadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapq344_cl USING g_enterprise,g_apca_m.apcald,g_apca_m.apcadocno
   IF STATUS THEN
      CLOSE aapq344_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapq344_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapq344_master_referesh USING g_apca_m.apcald,g_apca_m.apcadocno INTO g_apca_m.apcasite,g_apca_m.apca003, 
       g_apca_m.apcald,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca057, 
       g_apca_m.apca038,g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca034, 
       g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104, 
       g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apca101,g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116, 
       g_apca_m.apca118,g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021, 
       g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051, 
       g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026,g_apca_m.apca027, 
       g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130,g_apca_m.apca131, 
       g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca124,g_apca_m.apca134,g_apca_m.apca126,g_apca_m.apca136, 
       g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcaownid,g_apca_m.apcaowndp,g_apca_m.apcacrtid,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamoddt,g_apca_m.apcacnfid,g_apca_m.apcacnfdt, 
       g_apca_m.apcasite_desc,g_apca_m.apca003_desc,g_apca_m.apcald_desc,g_apca_m.apca015_desc,g_apca_m.apca057_desc, 
       g_apca_m.apca014_desc,g_apca_m.apca034_desc,g_apca_m.apca033_desc,g_apca_m.apca007_desc,g_apca_m.apca035_desc, 
       g_apca_m.apca011_desc,g_apca_m.apca058_desc,g_apca_m.apcaownid_desc,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid_desc, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcamodid_desc,g_apca_m.apcacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aapq344_action_chk() THEN
      CLOSE aapq344_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apca_m.apcasite,g_apca_m.apcasite_desc,g_apca_m.apca003,g_apca_m.apca003_desc,g_apca_m.apcald, 
       g_apca_m.apcald_desc,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocno_desc,g_apca_m.apcadocdt, 
       g_apca_m.apca015,g_apca_m.apca015_desc,g_apca_m.apca057,g_apca_m.apca057_desc,g_apca_m.apca038, 
       g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca014_desc,g_apca_m.apca034, 
       g_apca_m.apca034_desc,g_apca_m.apca033,g_apca_m.apca033_desc,g_apca_m.apca007,g_apca_m.apca007_desc, 
       g_apca_m.apca035,g_apca_m.apca035_desc,g_apca_m.apca100,g_apca_m.apca103,g_apca_m.apca104,g_apca_m.apca106, 
       g_apca_m.apca108,g_apca_m.apcc109,g_apca_m.net108,g_apca_m.glaa001,g_apca_m.apca101,g_apca_m.apca113, 
       g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apcc113,g_apca_m.apca118,g_apca_m.apcc119,g_apca_m.net118, 
       g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca011_desc,g_apca_m.apca013,g_apca_m.apca012, 
       g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca058_desc,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048, 
       g_apca_m.apca021,g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017, 
       g_apca_m.apca051,g_apca_m.apca051_desc,g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030, 
       g_apca_m.apca030_desc,g_apca_m.apca026,g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca1001, 
       g_apca_m.apca1031,g_apca_m.apca1041,g_apca_m.apca1061,g_apca_m.fflabel_t3,g_apca_m.apca1081,g_apca_m.apcc1091, 
       g_apca_m.net1081,g_apca_m.glaa0011,g_apca_m.apca1011,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130, 
       g_apca_m.apca131,g_apca_m.apca1131,g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca1141,g_apca_m.apca124, 
       g_apca_m.apca134,g_apca_m.apca1161,g_apca_m.apca126,g_apca_m.apca136,g_apca_m.apcc1131,g_apca_m.apcc123, 
       g_apca_m.apcc133,g_apca_m.apca1181,g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcc1191,g_apca_m.apcc129, 
       g_apca_m.apcc139,g_apca_m.net1181,g_apca_m.net128,g_apca_m.net138,g_apca_m.apcaownid,g_apca_m.apcaownid_desc, 
       g_apca_m.apcaowndp,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid,g_apca_m.apcacrtid_desc,g_apca_m.apcacrtdp, 
       g_apca_m.apcacrtdp_desc,g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamodid_desc,g_apca_m.apcamoddt, 
       g_apca_m.apcacnfid,g_apca_m.apcacnfid_desc,g_apca_m.apcacnfdt
 
   CASE g_apca_m.apcastus
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
         CASE g_apca_m.apcastus
            
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
      
      #end add-point
      
      
	  
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
      g_apca_m.apcastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapq344_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_apca_m.apcamodid = g_user
   LET g_apca_m.apcamoddt = cl_get_current()
   LET g_apca_m.apcastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE apca_t 
      SET (apcastus,apcamodid,apcamoddt) 
        = (g_apca_m.apcastus,g_apca_m.apcamodid,g_apca_m.apcamoddt)     
    WHERE apcaent = g_enterprise AND apcald = g_apca_m.apcald
      AND apcadocno = g_apca_m.apcadocno
    
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
      EXECUTE aapq344_master_referesh USING g_apca_m.apcald,g_apca_m.apcadocno INTO g_apca_m.apcasite, 
          g_apca_m.apca003,g_apca_m.apcald,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocdt,g_apca_m.apca015, 
          g_apca_m.apca057,g_apca_m.apca038,g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014, 
          g_apca_m.apca034,g_apca_m.apca033,g_apca_m.apca007,g_apca_m.apca035,g_apca_m.apca100,g_apca_m.apca103, 
          g_apca_m.apca104,g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apca101,g_apca_m.apca113,g_apca_m.apca114, 
          g_apca_m.apca116,g_apca_m.apca118,g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca013, 
          g_apca_m.apca012,g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048, 
          g_apca_m.apca021,g_apca_m.apca020,g_apca_m.apca022,g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017, 
          g_apca_m.apca051,g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca026, 
          g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130, 
          g_apca_m.apca131,g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca124,g_apca_m.apca134,g_apca_m.apca126, 
          g_apca_m.apca136,g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcaownid,g_apca_m.apcaowndp,g_apca_m.apcacrtid, 
          g_apca_m.apcacrtdp,g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamoddt,g_apca_m.apcacnfid, 
          g_apca_m.apcacnfdt,g_apca_m.apcasite_desc,g_apca_m.apca003_desc,g_apca_m.apcald_desc,g_apca_m.apca015_desc, 
          g_apca_m.apca057_desc,g_apca_m.apca014_desc,g_apca_m.apca034_desc,g_apca_m.apca033_desc,g_apca_m.apca007_desc, 
          g_apca_m.apca035_desc,g_apca_m.apca011_desc,g_apca_m.apca058_desc,g_apca_m.apcaownid_desc, 
          g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid_desc,g_apca_m.apcacrtdp_desc,g_apca_m.apcamodid_desc, 
          g_apca_m.apcacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apca_m.apcasite,g_apca_m.apcasite_desc,g_apca_m.apca003,g_apca_m.apca003_desc, 
          g_apca_m.apcald,g_apca_m.apcald_desc,g_apca_m.apcadocno,g_apca_m.apca001,g_apca_m.apcadocno_desc, 
          g_apca_m.apcadocdt,g_apca_m.apca015,g_apca_m.apca015_desc,g_apca_m.apca057,g_apca_m.apca057_desc, 
          g_apca_m.apca038,g_apca_m.apcastus,g_apca_m.apca018,g_apca_m.apca010,g_apca_m.apca014,g_apca_m.apca014_desc, 
          g_apca_m.apca034,g_apca_m.apca034_desc,g_apca_m.apca033,g_apca_m.apca033_desc,g_apca_m.apca007, 
          g_apca_m.apca007_desc,g_apca_m.apca035,g_apca_m.apca035_desc,g_apca_m.apca100,g_apca_m.apca103, 
          g_apca_m.apca104,g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apcc109,g_apca_m.net108,g_apca_m.glaa001, 
          g_apca_m.apca101,g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apcc113,g_apca_m.apca118, 
          g_apca_m.apcc119,g_apca_m.net118,g_apca_m.apca065,g_apca_m.apca066,g_apca_m.apca011,g_apca_m.apca011_desc, 
          g_apca_m.apca013,g_apca_m.apca012,g_apca_m.apca060,g_apca_m.apca058,g_apca_m.apca058_desc, 
          g_apca_m.apca046,g_apca_m.apca047,g_apca_m.apca048,g_apca_m.apca021,g_apca_m.apca020,g_apca_m.apca022, 
          g_apca_m.apca063,g_apca_m.apca052,g_apca_m.apca017,g_apca_m.apca051,g_apca_m.apca051_desc, 
          g_apca_m.apca053,g_apca_m.apca025,g_apca_m.apca031,g_apca_m.apca030,g_apca_m.apca030_desc, 
          g_apca_m.apca026,g_apca_m.apca027,g_apca_m.apca028,g_apca_m.apca029,g_apca_m.apca1001,g_apca_m.apca1031, 
          g_apca_m.apca1041,g_apca_m.apca1061,g_apca_m.fflabel_t3,g_apca_m.apca1081,g_apca_m.apcc1091, 
          g_apca_m.net1081,g_apca_m.glaa0011,g_apca_m.apca1011,g_apca_m.apca120,g_apca_m.apca121,g_apca_m.apca130, 
          g_apca_m.apca131,g_apca_m.apca1131,g_apca_m.apca123,g_apca_m.apca133,g_apca_m.apca1141,g_apca_m.apca124, 
          g_apca_m.apca134,g_apca_m.apca1161,g_apca_m.apca126,g_apca_m.apca136,g_apca_m.apcc1131,g_apca_m.apcc123, 
          g_apca_m.apcc133,g_apca_m.apca1181,g_apca_m.apca128,g_apca_m.apca138,g_apca_m.apcc1191,g_apca_m.apcc129, 
          g_apca_m.apcc139,g_apca_m.net1181,g_apca_m.net128,g_apca_m.net138,g_apca_m.apcaownid,g_apca_m.apcaownid_desc, 
          g_apca_m.apcaowndp,g_apca_m.apcaowndp_desc,g_apca_m.apcacrtid,g_apca_m.apcacrtid_desc,g_apca_m.apcacrtdp, 
          g_apca_m.apcacrtdp_desc,g_apca_m.apcacrtdt,g_apca_m.apcamodid,g_apca_m.apcamodid_desc,g_apca_m.apcamoddt, 
          g_apca_m.apcacnfid,g_apca_m.apcacnfid_desc,g_apca_m.apcacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aapq344_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapq344_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapq344.signature" >}
   
 
{</section>}
 
{<section id="aapq344.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapq344_set_pk_array()
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
   LET g_pk_array[1].values = g_apca_m.apcald
   LET g_pk_array[1].column = 'apcald'
   LET g_pk_array[2].values = g_apca_m.apcadocno
   LET g_pk_array[2].column = 'apcadocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapq344.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aapq344.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapq344_msgcentre_notify(lc_state)
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
   CALL aapq344_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apca_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapq344.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapq344_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapq344.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 帳別預設值
# Memo...........:
# Date & Author..: Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq344_set_ld_info(p_ld)
DEFINE p_ld        LIKE apca_t.apcald
DEFINE l_using     LIKE type_t.num5
DEFINE l_isai002   LIKE isai_t.isai002

   CALL s_ld_sel_glaa(p_ld,'glaacomp|glaa001|glaa015|glaa016|glaa019|glaa020') RETURNING g_sub_success,g_glaa.*
   LET g_apca_m.apca120 = g_glaa.glaa016
   LET g_apca_m.apca130 = g_glaa.glaa020
   LET g_apca_m.glaa001 = g_glaa.glaa001
   LET g_apca_m.glaa0011 = g_glaa.glaa001
    
   DISPLAY BY NAME g_apca_m.glaa001,g_apca_m.glaa0011,g_apca_m.apca120,g_apca_m.apca130
   
   #取得該法人的稅區
   SELECT ooef019 INTO g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp
   SELECT isai002 INTO l_isai002
     FROM isai_t
    WHERE isaient = g_enterprise AND isai001 = g_ooef019
   IF l_isai002 = "1" THEN
      CALL cl_set_comp_visible('apca065,isam009',FALSE)
   ELSE
      CALL cl_set_comp_visible('apca065,isam009',TRUE)
   END IF

   IF g_glaa.glaa015 = 'N' AND  g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('page7',FALSE)    #本位幣頁籤隱藏
   ELSE
      CALL cl_set_comp_visible('page7',TRUE)     #本位幣頁籤顯示
      #本幣二處理===(S)===
      IF g_glaa.glaa015 = 'Y' THEN LET l_using = TRUE ELSE LET l_using = FALSE END IF
      CALL cl_set_comp_visible('apca120,apca121,apca123,apca124,apca126,apca128,apcc123,apcc129,net128',l_using)
      #本幣二處理===(E)===
      
      #本幣三處理===(S)===
      LET l_using = TRUE
      IF g_glaa.glaa019 = 'Y' THEN LET l_using = TRUE ELSE LET l_using = FALSE END IF
      CALL cl_set_comp_visible('apca130,apca131,apca133,apca134,apca136,apca138,apcc133,apcc139,net138',l_using)
      #本幣三處理===(E)===
   END IF

END FUNCTION

################################################################################
# Descriptions...: 單頭本幣金額
# Memo...........:
# Date & Author..: Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq344_curr_info_master()

    CALL s_aapt300_curr_info_master(g_apca_m.apcald,g_apca_m.apcadocno) 
          RETURNING g_apca_m.apca103,g_apca_m.apca104,g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apcc109,g_apca_m.net108 ,
                    g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apca118,g_apca_m.apcc119,g_apca_m.net1181,g_apca_m.apcc113,
                    g_apca_m.apca123,g_apca_m.apca124,g_apca_m.apca126,g_apca_m.apca128,g_apca_m.apcc129,g_apca_m.net128,g_apca_m.apcc123,
                    g_apca_m.apca133,g_apca_m.apca134,g_apca_m.apca136,g_apca_m.apca138,g_apca_m.apcc139,g_apca_m.net138,g_apca_m.apcc133,
                    g_apca_m.apca1031,g_apca_m.apca1041,g_apca_m.apca1061,g_apca_m.apca1081,g_apca_m.apcc1091,g_apca_m.net1081,
                    g_apca_m.apca1131,g_apca_m.apca1141,g_apca_m.apca1161,g_apca_m.apca1181,g_apca_m.apcc1191,g_apca_m.net118,g_apca_m.apcc1131
    
    DISPLAY BY NAME g_apca_m.apca103,g_apca_m.apca104,g_apca_m.apca106,g_apca_m.apca108,g_apca_m.apcc109,g_apca_m.net108 ,
                    g_apca_m.apca113,g_apca_m.apca114,g_apca_m.apca116,g_apca_m.apca118,g_apca_m.apcc119,g_apca_m.net1181,g_apca_m.apcc113,
                    g_apca_m.apca123,g_apca_m.apca124,g_apca_m.apca126,g_apca_m.apca128,g_apca_m.apcc129,g_apca_m.net128,g_apca_m.apcc123,
                    g_apca_m.apca133,g_apca_m.apca134,g_apca_m.apca136,g_apca_m.apca138,g_apca_m.apcc139,g_apca_m.net138,g_apca_m.apcc133,
                    g_apca_m.apca1031,g_apca_m.apca1041,g_apca_m.apca1061,g_apca_m.apca1081,g_apca_m.apcc1091,g_apca_m.net1081,
                    g_apca_m.apca1131,g_apca_m.apca1141,g_apca_m.apca1161,g_apca_m.apca1181,g_apca_m.apcc1191,g_apca_m.net118,g_apca_m.apcc1131
                   
END FUNCTION

 
{</section>}
 
