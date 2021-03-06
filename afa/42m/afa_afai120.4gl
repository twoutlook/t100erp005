#該程式未解開Section, 採用最新樣板產出!
{<section id="afai120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0024(2016-08-25 15:06:05), PR版次:0024(2017-02-09 10:16:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000299
#+ Filename...: afai120
#+ Description: 固定資產底稿維護作業
#+ Creator....: 02416(2014-02-20 14:27:42)
#+ Modifier...: 06814 -SD/PR- 01531
 
{</section>}
 
{<section id="afai120.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#151008-00017#1  by albireo 151012    (afai120是走在建工程才有此資料)固資相關參數說明無底稿編號自動編碼的描述,且底稿設置的自動編碼與固資號碼相同造成跳號,
#                                     故修改取消底稿編號的自動編碼
#151125-00001#1...: 2015/11/27 BY fionchen 執行[作廢]作業時,增加詢問「是否執行作廢？」
#160318-00025#4...: 2016/04/12 By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160408-00020#4     2016/04/22 By 01531    新增栏位faak052,faak054,faak053
#160812-00017#6     2016/08/19 By 06814    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 
#                                          造成transaction沒有結束就直接RETURN
#161009-00006#2     2016/10/12 By 02114    卡编自动编码时，抓取max（卡编）要按归属法人来抓
#161024-00008#1     2016/10/24 By Hans     AFA組織類型與職能開窗清單調整。
#161017-00023#1     2016/10/26 By 02114    权限调整
#161024-00008#5     2016/10/24 By Hans     AFA組織類型與職能開窗清單調整。
#161111-00049#5     2016/11/16 By 01531    固资栏位过滤
#161111-00028#6     2016/11/21 by 06189    标准程式定义采用宣告模式,弃用.*写
#161130-00026#1     2016/11/20 By 01531    确认时取消faak007为空检查
#160426-00014#15    2017/02/04 By 01531    新增杂发单号传参  
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
PRIVATE TYPE type_g_faak_m RECORD
       faak001 LIKE faak_t.faak001, 
   faak003 LIKE faak_t.faak003, 
   faak004 LIKE faak_t.faak004, 
   faak002 LIKE faak_t.faak002, 
   faak012 LIKE faak_t.faak012, 
   faak013 LIKE faak_t.faak013, 
   faak006 LIKE faak_t.faak006, 
   faak006_desc LIKE type_t.chr80, 
   faak007 LIKE faak_t.faak007, 
   faak007_desc LIKE type_t.chr80, 
   faak049 LIKE faak_t.faak049, 
   faakstus LIKE faak_t.faakstus, 
   faak014 LIKE faak_t.faak014, 
   faak015 LIKE faak_t.faak015, 
   faak016 LIKE faak_t.faak016, 
   faak017 LIKE faak_t.faak017, 
   faak017_desc LIKE type_t.chr80, 
   faak018 LIKE faak_t.faak018, 
   faak019 LIKE faak_t.faak019, 
   faak019_desc LIKE type_t.chr80, 
   faak021 LIKE faak_t.faak021, 
   faak022 LIKE faak_t.faak022, 
   faak020 LIKE faak_t.faak020, 
   faak023 LIKE faak_t.faak023, 
   faak024 LIKE faak_t.faak024, 
   faak025 LIKE faak_t.faak025, 
   faak025_desc LIKE type_t.chr80, 
   faak026 LIKE faak_t.faak026, 
   faak026_desc LIKE type_t.chr80, 
   faak027 LIKE faak_t.faak027, 
   faak027_desc LIKE type_t.chr80, 
   faak028 LIKE faak_t.faak028, 
   faak028_desc LIKE type_t.chr80, 
   faak030 LIKE faak_t.faak030, 
   faak030_desc LIKE type_t.chr80, 
   faak031 LIKE faak_t.faak031, 
   faak031_desc LIKE type_t.chr80, 
   faak032 LIKE faak_t.faak032, 
   faak032_desc LIKE type_t.chr80, 
   faak029 LIKE faak_t.faak029, 
   faak029_desc LIKE type_t.chr80, 
   faak009 LIKE faak_t.faak009, 
   faak009_desc LIKE type_t.chr80, 
   faak010 LIKE faak_t.faak010, 
   faak010_desc LIKE type_t.chr80, 
   faak011 LIKE faak_t.faak011, 
   faak011_desc LIKE type_t.chr80, 
   faak000 LIKE faak_t.faak000, 
   faak043 LIKE faak_t.faak043, 
   faak005 LIKE faak_t.faak005, 
   faak008 LIKE faak_t.faak008, 
   faak008_desc LIKE type_t.chr80, 
   faak035 LIKE faak_t.faak035, 
   faak036 LIKE faak_t.faak036, 
   faak037 LIKE faak_t.faak037, 
   faak038 LIKE faak_t.faak038, 
   faak042 LIKE faak_t.faak042, 
   faak042_desc LIKE type_t.chr80, 
   faak047 LIKE faak_t.faak047, 
   faak048 LIKE faak_t.faak048, 
   faak039 LIKE faak_t.faak039, 
   faak040 LIKE faak_t.faak040, 
   faak041 LIKE faak_t.faak041, 
   faakld LIKE faak_t.faakld, 
   faak052 LIKE faak_t.faak052, 
   faak053 LIKE faak_t.faak053, 
   faak054 LIKE faak_t.faak054, 
   faakownid LIKE faak_t.faakownid, 
   faakownid_desc LIKE type_t.chr80, 
   faakcrtid LIKE faak_t.faakcrtid, 
   faakcrtid_desc LIKE type_t.chr80, 
   faakowndp LIKE faak_t.faakowndp, 
   faakowndp_desc LIKE type_t.chr80, 
   faakcrtdp LIKE faak_t.faakcrtdp, 
   faakcrtdp_desc LIKE type_t.chr80, 
   faakmodid LIKE faak_t.faakmodid, 
   faakmodid_desc LIKE type_t.chr80, 
   faakcrtdt LIKE faak_t.faakcrtdt, 
   faakmoddt LIKE faak_t.faakmoddt
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_faakld LIKE faak_t.faakld,
      b_faak000 LIKE faak_t.faak000,
      b_faak001 LIKE faak_t.faak001,
      b_faak003 LIKE faak_t.faak003,
      b_faak004 LIKE faak_t.faak004
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef017             LIKE ooef_t.ooef017
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa025             LIKE glaa_t.glaa025
DEFINE g_ooan005             LIKE ooan_t.ooan005
DEFINE g_para_data           LIKE type_t.chr80
DEFINE g_comp                LIKE ooef_t.ooef017
DEFINE g_para_data2          LIKE type_t.chr80
DEFINE g_para_data3          LIKE type_t.chr80 
 TYPE type_g_faai_d_1        RECORD
   faai000 LIKE faai_t.faai000,
   faai001 LIKE faai_t.faai001,
   faai002 LIKE faai_t.faai002,
   faai003 LIKE faai_t.faai003,
   faaiseq LIKE faai_t.faaiseq, 
   faai004 LIKE faai_t.faai004, 
   faai012 LIKE faai_t.faai012, 
   faai013 LIKE faai_t.faai013, 
   faai005 LIKE faai_t.faai005, 
   faai006 LIKE faai_t.faai006, 
   faai007 LIKE faai_t.faai007, 
   faai008 LIKE faai_t.faai008, 
   faai010 LIKE faai_t.faai010, 
   faai009 LIKE faai_t.faai009, 
   faai014 LIKE faai_t.faai014, 
   faai015 LIKE faai_t.faai015, 
   faai016 LIKE faai_t.faai016, 
   faai017 LIKE faai_t.faai017, 
   faai018 LIKE faai_t.faai018, 
   faai019 LIKE faai_t.faai019, 
   faai020 LIKE faai_t.faai020, 
   faai021 LIKE faai_t.faai021, 
   faai022 LIKE faai_t.faai022, 
   faai023 LIKE faai_t.faai023
       END RECORD
       
DEFINE g_faai_d_1          DYNAMIC ARRAY OF type_g_faai_d_1
DEFINE g_faai_d_1_t        type_g_faai_d_1
DEFINE g_faai_d_1_o        type_g_faai_d_1
DEFINE g_wc2               STRING 
DEFINE g_detail_cnt        LIKE type_t.num10
DEFINE g_insert            LIKE type_t.chr1
DEFINE g_detail_idx        LIKE type_t.num5
DEFINE gs_keys             DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak         DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_loc               LIKE type_t.chr1
DEFINE g_current_page      LIKE type_t.num5 
DEFINE g_update            BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_wc4               STRING 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_faak_m        type_g_faak_m  #單頭變數宣告
DEFINE g_faak_m_t      type_g_faak_m  #單頭舊值宣告(系統還原用)
DEFINE g_faak_m_o      type_g_faak_m  #單頭舊值宣告(其他用途)
DEFINE g_faak_m_mask_o type_g_faak_m  #轉換遮罩前資料
DEFINE g_faak_m_mask_n type_g_faak_m  #轉換遮罩後資料
 
   DEFINE g_faak001_t LIKE faak_t.faak001
DEFINE g_faak003_t LIKE faak_t.faak003
DEFINE g_faak004_t LIKE faak_t.faak004
DEFINE g_faak000_t LIKE faak_t.faak000
DEFINE g_faakld_t LIKE faak_t.faakld
 
   
 
   
 
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
 
{<section id="afai120.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success  LIKE type_t.num5  #add--2015/03/19 By shiun
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/19 By shiun
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
                           
   #end add-point
   LET g_forupd_sql = " SELECT faak001,faak003,faak004,faak002,faak012,faak013,faak006,'',faak007,'', 
       faak049,faakstus,faak014,faak015,faak016,faak017,'',faak018,faak019,'',faak021,faak022,faak020, 
       faak023,faak024,faak025,'',faak026,'',faak027,'',faak028,'',faak030,'',faak031,'',faak032,'', 
       faak029,'',faak009,'',faak010,'',faak011,'',faak000,faak043,faak005,faak008,'',faak035,faak036, 
       faak037,faak038,faak042,'',faak047,faak048,faak039,faak040,faak041,faakld,faak052,faak053,faak054, 
       faakownid,'',faakcrtid,'',faakowndp,'',faakcrtdp,'',faakmodid,'',faakcrtdt,faakmoddt", 
                      " FROM faak_t",
                      " WHERE faakent= ? AND faakld=? AND faak000=? AND faak001=? AND faak003=? AND  
                          faak004=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
                           
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afai120_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.faak001,t0.faak003,t0.faak004,t0.faak002,t0.faak012,t0.faak013,t0.faak006, 
       t0.faak007,t0.faak049,t0.faakstus,t0.faak014,t0.faak015,t0.faak016,t0.faak017,t0.faak018,t0.faak019, 
       t0.faak021,t0.faak022,t0.faak020,t0.faak023,t0.faak024,t0.faak025,t0.faak026,t0.faak027,t0.faak028, 
       t0.faak030,t0.faak031,t0.faak032,t0.faak029,t0.faak009,t0.faak010,t0.faak011,t0.faak000,t0.faak043, 
       t0.faak005,t0.faak008,t0.faak035,t0.faak036,t0.faak037,t0.faak038,t0.faak042,t0.faak047,t0.faak048, 
       t0.faak039,t0.faak040,t0.faak041,t0.faakld,t0.faak052,t0.faak053,t0.faak054,t0.faakownid,t0.faakcrtid, 
       t0.faakowndp,t0.faakcrtdp,t0.faakmodid,t0.faakcrtdt,t0.faakmoddt,t1.faacl003 ,t2.faadl003 ,t3.oocal003 , 
       t4.ooail003 ,t5.ooag011 ,t6.ooefl003 ,t7.oocql004 ,t8.ooefl003 ,t9.ooefl003 ,t10.ooefl003 ,t11.ooefl003 , 
       t12.ooag011 ,t13.pmaal003 ,t14.pmaal003 ,t15.oocgl003 ,t16.oocql004 ,t17.ooefl003 ,t18.ooag011 , 
       t19.ooag011 ,t20.ooefl003 ,t21.ooefl003 ,t22.ooag011",
               " FROM faak_t t0",
                              " LEFT JOIN faacl_t t1 ON t1.faaclent="||g_enterprise||" AND t1.faacl001=t0.faak006 AND t1.faacl002='"||g_dlang||"' ",
               " LEFT JOIN faadl_t t2 ON t2.faadlent="||g_enterprise||" AND t2.faadl001=t0.faak007 AND t2.faadl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.faak017 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.faak019 AND t4.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.faak025  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.faak026 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='3900' AND t7.oocql002=t0.faak027 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.faak028 AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.faak030 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.faak031 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.faak032 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.faak029  ",
               " LEFT JOIN pmaal_t t13 ON t13.pmaalent="||g_enterprise||" AND t13.pmaal001=t0.faak009 AND t13.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t14 ON t14.pmaalent="||g_enterprise||" AND t14.pmaal001=t0.faak010 AND t14.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t15 ON t15.oocglent="||g_enterprise||" AND t15.oocgl001=t0.faak011 AND t15.oocgl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='3903' AND t16.oocql002=t0.faak008 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=t0.faak042 AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=t0.faakownid  ",
               " LEFT JOIN ooag_t t19 ON t19.ooagent="||g_enterprise||" AND t19.ooag001=t0.faakcrtid  ",
               " LEFT JOIN ooefl_t t20 ON t20.ooeflent="||g_enterprise||" AND t20.ooefl001=t0.faakowndp AND t20.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t21 ON t21.ooeflent="||g_enterprise||" AND t21.ooefl001=t0.faakcrtdp AND t21.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t22 ON t22.ooagent="||g_enterprise||" AND t22.ooag001=t0.faakmodid  ",
 
               " WHERE t0.faakent = " ||g_enterprise|| " AND t0.faakld = ? AND t0.faak000 = ? AND t0.faak001 = ? AND t0.faak003 = ? AND t0.faak004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afai120_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                                                      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afai120 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afai120_init()   
 
      #進入選單 Menu (="N")
      CALL afai120_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                                                      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afai120
      
   END IF 
   
   CLOSE afai120_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/19 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afai120.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afai120_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
                           DEFINE  l_ooag004 LIKE ooag_t.ooag004
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('faakstus','13','N,Y,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('faak002','9911') 
   CALL cl_set_combo_scc('faak005','9903')
   CALL cl_set_combo_scc('faak015','9914') 
   CALL cl_set_combo_scc('faak016','9913') 
   CALL cl_set_combo_scc('faak049','9917') 
   CALL cl_set_combo_scc('faak035','9905')
   CALL cl_set_combo_scc('faak036','9906')
   CALL cl_set_combo_scc('faak037','9907')
   CALL cl_set_combo_scc('faak038','9908')
   
   CALL cl_set_combo_scc('faak053','9909')   #160408-00020#4 
   LET g_faak_m.faak053 = '0'                #160408-00020#4   
#   SELECT ooag004 INTO l_ooag004
#     FROM ooag_t
#    WHERE ooagent = g_enterprise
#      AND ooag001 = g_user
   
#   SELECT ooef017 INTO g_ooef017 
#     FROM ooef_t
#    WHERE ooefent = g_enterprise
#      AND ooef001 = l_ooag004
   
#   SELECT glaa001,glaald,glaa025
#     INTO g_glaa001,g_glaald,g_glaa025
#     FROM glaa_t
#    WHERE glaaent = g_enterprise
#      AND glaacomp = g_ooef017
#      AND glaa014 = 'Y'
      

   #取归属法人
   SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
   CALL cl_get_para(g_enterprise,g_comp,'S-FIN-9010') RETURNING g_para_data3  #財编自动编号否
   #end add-point
   
   #根據外部參數進行搜尋
   CALL afai120_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="afai120.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afai120_ui_dialog() 
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
            CALL afai120_insert()
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
         INITIALIZE g_faak_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL afai120_init()
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
               CALL afai120_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afai120_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               IF g_browser_cnt > 0 THEN
                  CALL afai120_fetch("F")   
               END IF   
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afai120_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afai120_set_act_visible()
               CALL afai120_set_act_no_visible()
               IF NOT (g_faak_m.faakld IS NULL
                 OR g_faak_m.faak000 IS NULL
                 OR g_faak_m.faak001 IS NULL
                 OR g_faak_m.faak003 IS NULL
                 OR g_faak_m.faak004 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " faakent = " ||g_enterprise|| " AND",
                                     " faakld = '", g_faak_m.faakld, "' "
                                     ," AND faak000 = '", g_faak_m.faak000, "' "
                                     ," AND faak001 = '", g_faak_m.faak001, "' "
                                     ," AND faak003 = '", g_faak_m.faak003, "' "
                                     ," AND faak004 = '", g_faak_m.faak004, "' "
 
                  #填到對應位置
                  CALL afai120_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL afai120_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afai120_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL afai120_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL afai120_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL afai120_fetch("L")  
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
                  CALL afai120_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afai120_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afai120_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afai120_modify()
               #add-point:ON ACTION modify name="menu2.modify"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afai120_delete()
               #add-point:ON ACTION delete name="menu2.delete"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afai120_insert()
               #add-point:ON ACTION insert name="menu2.insert"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afai120_01
            LET g_action_choice="open_afai120_01"
            IF cl_auth_chk_act("open_afai120_01") THEN
               
               #add-point:ON ACTION open_afai120_01 name="menu2.open_afai120_01"
               CALL afai120_ui_dialog_1()
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
               CALL afai120_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afai120_query()
               #add-point:ON ACTION query name="menu2.query"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak025
            LET g_action_choice="prog_faak025"
            IF cl_auth_chk_act("prog_faak025") THEN
               
               #add-point:ON ACTION prog_faak025 name="menu2.prog_faak025"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faak_m.faak025)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak029
            LET g_action_choice="prog_faak029"
            IF cl_auth_chk_act("prog_faak029") THEN
               
               #add-point:ON ACTION prog_faak029 name="menu2.prog_faak029"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faak_m.faak025)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak047
            LET g_action_choice="prog_faak047"
            IF cl_auth_chk_act("prog_faak047") THEN
               
               #add-point:ON ACTION prog_faak047 name="menu2.prog_faak047"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint301'
               LET la_param.param[1] = g_faak_m.faak047

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak048
            LET g_action_choice="prog_faak048"
            IF cl_auth_chk_act("prog_faak048") THEN
               
               #add-point:ON ACTION prog_faak048 name="menu2.prog_faak048"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               IF NOT cl_null(g_faak_m.faak048) THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aglt310'
                  LET la_param.param[1] = g_faak_m.faakld  #150727-00004#1 add
                  LET la_param.param[2] = g_faak_m.faak048 #150727-00004#1 mod
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak039
            LET g_action_choice="prog_faak039"
            IF cl_auth_chk_act("prog_faak039") THEN
               
               #add-point:ON ACTION prog_faak039 name="menu2.prog_faak039"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt500'
               LET la_param.param[1] = g_faak_m.faak039
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak040
            LET g_action_choice="prog_faak040"
            IF cl_auth_chk_act("prog_faak040") THEN
               
               #add-point:ON ACTION prog_faak040 name="menu2.prog_faak040"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt570'
               LET la_param.param[1] = g_faak_m.faak040

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak041
            LET g_action_choice="prog_faak041"
            IF cl_auth_chk_act("prog_faak041") THEN
               
               #add-point:ON ACTION prog_faak041 name="menu2.prog_faak041"
               #應用 a41 樣板自動產生(Version:2)
               LET l_apca001 = ''
               SELECT apca001 INTO l_apca001
                 FROM apca_t
                WHERE apcaent = g_enterprise
                  AND apcadocno = g_faak_m.faak041
                  
               CASE l_apca001
                   WHEN '03'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt320'
                      LET la_param.param[2] = g_faak_m.faak041
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)                  
          
                   WHEN '11'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt310'
                      LET la_param.param[2] = g_faak_m.faak041
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                  WHEN '13'
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt300'
                      LET la_param.param[3] = g_faak_m.faak041
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                  WHEN '12' 
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt331'
                      LET la_param.param[2] = g_faak_m.faak041
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
                      
                  WHEN '15'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt330'
                      LET la_param.param[2] = g_faak_m.faak041
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)

                  WHEN '22'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  
                  #150803-00012#1 20150806--add--str
                  WHEN '01'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt320'
                     LET la_param.param[2] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '14'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt310'
                     LET la_param.param[2] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '16'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '17'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[3] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '19'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[1] = '1'
                     LET la_param.param[3] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #150803-00012#1 20150806--add--end
               END CASE 
               #150803-00012#1 20150806--add--str
               IF cl_null(l_apca001) THEN 
                  SELECT faba003 INTO l_apca001
                    FROM faba_t
                   WHERE fabaent = g_enterprise
                     AND fabadocno = g_faak_m.faak041
               END IF
               IF l_apca001 = '20' THEN
                  #應用 a41 樣板自動產生(Version:2)
                  #使用JSON格式組合參數與作業編號(串查)
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'afat460'
                  LET la_param.param[1] = g_faak_m.faak041
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #150803-00012#1 20150806--add--end
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afai120_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afai120_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afai120_set_pk_array()
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
                  CALL afai120_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                                                                                                            
            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL afai120_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL afai120_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
                                                                                                                                       
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL afai120_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL afai120_set_act_visible()
               CALL afai120_set_act_no_visible()
               IF NOT (g_faak_m.faakld IS NULL
                 OR g_faak_m.faak000 IS NULL
                 OR g_faak_m.faak001 IS NULL
                 OR g_faak_m.faak003 IS NULL
                 OR g_faak_m.faak004 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " faakent = " ||g_enterprise|| " AND",
                                     " faakld = '", g_faak_m.faakld, "' "
                                     ," AND faak000 = '", g_faak_m.faak000, "' "
                                     ," AND faak001 = '", g_faak_m.faak001, "' "
                                     ," AND faak003 = '", g_faak_m.faak003, "' "
                                     ," AND faak004 = '", g_faak_m.faak004, "' "
 
                  #填到對應位置
                  CALL afai120_browser_fill(g_wc,"")
               END IF
         
            
            
            #第一筆資料
            ON ACTION first
               CALL afai120_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL afai120_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL afai120_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL afai120_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL afai120_fetch("L")  
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
                  CALL afai120_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afai120_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afai120_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afai120_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afai120_delete()
               #add-point:ON ACTION delete name="menu.delete"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afai120_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afai120_01
            LET g_action_choice="open_afai120_01"
            IF cl_auth_chk_act("open_afai120_01") THEN
               
               #add-point:ON ACTION open_afai120_01 name="menu.open_afai120_01"
               CALL afai120_ui_dialog_1()
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
               CALL afai120_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afai120_query()
               #add-point:ON ACTION query name="menu.query"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak025
            LET g_action_choice="prog_faak025"
            IF cl_auth_chk_act("prog_faak025") THEN
               
               #add-point:ON ACTION prog_faak025 name="menu.prog_faak025"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faak_m.faak025)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak029
            LET g_action_choice="prog_faak029"
            IF cl_auth_chk_act("prog_faak029") THEN
               
               #add-point:ON ACTION prog_faak029 name="menu.prog_faak029"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faak_m.faak025)


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak047
            LET g_action_choice="prog_faak047"
            IF cl_auth_chk_act("prog_faak047") THEN
               
               #add-point:ON ACTION prog_faak047 name="menu.prog_faak047"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint301'
               LET la_param.param[1] = g_faak_m.faak047

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak048
            LET g_action_choice="prog_faak048"
            IF cl_auth_chk_act("prog_faak048") THEN
               
               #add-point:ON ACTION prog_faak048 name="menu.prog_faak048"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               IF NOT cl_null(g_faak_m.faak048) THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aglt310'
                  LET la_param.param[1] = g_faak_m.faakld  #150727-00004#1 add
                  LET la_param.param[2] = g_faak_m.faak048 #150727-00004#1 mod
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak039
            LET g_action_choice="prog_faak039"
            IF cl_auth_chk_act("prog_faak039") THEN
               
               #add-point:ON ACTION prog_faak039 name="menu.prog_faak039"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt500'
               LET la_param.param[1] = g_faak_m.faak039

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak040
            LET g_action_choice="prog_faak040"
            IF cl_auth_chk_act("prog_faak040") THEN
               
               #add-point:ON ACTION prog_faak040 name="menu.prog_faak040"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'apmt570'
               LET la_param.param[1] = g_faak_m.faak040

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faak041
            LET g_action_choice="prog_faak041"
            IF cl_auth_chk_act("prog_faak041") THEN
               
               #add-point:ON ACTION prog_faak041 name="menu.prog_faak041"
               #應用 a41 樣板自動產生(Version:2)
               LET l_apca001 = ''
               SELECT apca001 INTO l_apca001
                 FROM apca_t
                WHERE apcaent = g_enterprise
                  AND apcadocno = g_faak_m.faak041
                  
               CASE l_apca001
                   WHEN '13'
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt300'
                      LET la_param.param[3] = g_faak_m.faak041
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
          
                   WHEN '11'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt310'
                      LET la_param.param[2] = g_faak_m.faak041
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '03'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt320'
                      LET la_param.param[2] = g_faak_m.faak041
                      
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 
                   WHEN '15'
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt330'
                      LET la_param.param[2] = g_faak_m.faak041
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                   WHEN '12' 
                      #應用 a41 樣板自動產生(Version:2)
                      #使用JSON格式組合參數與作業編號(串查)
                      INITIALIZE la_param.* TO NULL
                      LET la_param.prog     = 'aapt331'
                      LET la_param.param[2] = g_faak_m.faak041
                      LET ls_js = util.JSON.stringify(la_param)
                      CALL cl_cmdrun_wait(ls_js)
 

                  WHEN '22'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #150803-00012#1 20150806--add--str
                  WHEN '01'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt320'
                     LET la_param.param[2] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '14'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt310'
                     LET la_param.param[2] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '16'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt340'
                     LET la_param.param[3] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '17'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[3] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  WHEN '19'
                     #應用 a41 樣板自動產生(Version:2)
                     #使用JSON格式組合參數與作業編號(串查)
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'aapt300'
                     LET la_param.param[1] = '1'
                     LET la_param.param[3] = g_faak_m.faak041
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #150803-00012#1 20150806--add--end
               END CASE 
               #150803-00012#1 20150806--add--str
               IF cl_null(l_apca001) THEN 
                  SELECT faba003 INTO l_apca001
                    FROM faba_t
                   WHERE fabaent = g_enterprise
                     AND fabadocno = g_faak_m.faak041
               END IF
               IF l_apca001 = '20' THEN
                  #應用 a41 樣板自動產生(Version:2)
                  #使用JSON格式組合參數與作業編號(串查)
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'afat460'
                  LET la_param.param[1] = g_faak_m.faak041
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #150803-00012#1 20150806--add--end 
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afai120_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afai120_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afai120_set_pk_array()
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
 
{<section id="afai120.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION afai120_browser_fill(p_wc,ps_page_action) 
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_comp_str        STRING #161111-00049#5                          
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.pre_function"
   
   #end add-point
   
   LET l_searchcol = "faakld,faak000,faak001,faak003,faak004"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   #161111-00049#5 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","faak032")
   LET p_wc = p_wc," AND ",l_comp_str

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","faak028")
   LET p_wc = p_wc," AND ",l_comp_str
   
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","faak030")
   LET p_wc = p_wc," AND ",l_comp_str  

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","faak031")
   LET p_wc = p_wc," AND ",l_comp_str
   #161111-00049#5 add e---   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM faak_t ",
               "  ",
               "  ",
               " WHERE faakent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("faak_t")
                
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
      INITIALIZE g_faak_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.faakstus,t0.faakld,t0.faak000,t0.faak001,t0.faak003,t0.faak004",
               " FROM faak_t t0 ",
               "  ",
               
               " WHERE t0.faakent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("faak_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
                           
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"faak_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_faakld,g_browser[g_cnt].b_faak000, 
          g_browser[g_cnt].b_faak001,g_browser[g_cnt].b_faak003,g_browser[g_cnt].b_faak004
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
   
   IF cl_null(g_browser[g_cnt].b_faakld) THEN
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
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afai120_set_act_visible()
   CALL afai120_set_act_no_visible()
   #end add-point   
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai120.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afai120_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_comp_str     STRING       #161017-00023#1 add lujh  
   DEFINE  l_ld_str      STRING       #161111-00049#5   
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
 
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_faak_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON faak001,faak003,faak004,faak002,faak012,faak013,faak006,faak007,faak049, 
          faakstus,faak014,faak015,faak016,faak017,faak018,faak019,faak021,faak022,faak020,faak023,faak024, 
          faak025,faak026,faak027,faak028,faak030,faak031,faak032,faak029,faak009,faak010,faak011,faak000, 
          faak043,faak005,faak008,faak035,faak036,faak037,faak038,faak042,faak047,faak048,faak039,faak040, 
          faak041,faakld,faak052,faak053,faak054,faakownid,faakcrtid,faakowndp,faakcrtdp,faakmodid,faakcrtdt, 
          faakmoddt
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
                                                                                                            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<faakcrtdt>>----
         AFTER FIELD faakcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<faakmoddt>>----
         AFTER FIELD faakmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<faakcnfdt>>----
         
         #----<<faakpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.faak001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak001
            #add-point:ON ACTION controlp INFIELD faak001 name="construct.c.faak001"
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faak032")
			   LET g_qryparam.where = " faak032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#5 add e--- 			   
            CALL q_faak001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak001  #顯示到畫面上

            NEXT FIELD faak001                     #返回原欄位                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak001
            #add-point:BEFORE FIELD faak001 name="construct.b.faak001"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak001
            
            #add-point:AFTER FIELD faak001 name="construct.a.faak001"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak003
            #add-point:ON ACTION controlp INFIELD faak003 name="construct.c.faak003"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faak032")
			   LET g_qryparam.where = " faak032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#5 add e--- 			   
            CALL q_faak003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak003  #顯示到畫面上

            NEXT FIELD faak003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak003
            #add-point:BEFORE FIELD faak003 name="construct.b.faak003"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak003
            
            #add-point:AFTER FIELD faak003 name="construct.a.faak003"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak004
            #add-point:ON ACTION controlp INFIELD faak004 name="construct.c.faak004"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faak032")
			   LET g_qryparam.where = " faak032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   #161111-00049#5 add e--- 				   
            CALL q_faak004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak004  #顯示到畫面上

            NEXT FIELD faak004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak004
            #add-point:BEFORE FIELD faak004 name="construct.b.faak004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak004
            
            #add-point:AFTER FIELD faak004 name="construct.a.faak004"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak002
            #add-point:BEFORE FIELD faak002 name="construct.b.faak002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak002
            
            #add-point:AFTER FIELD faak002 name="construct.a.faak002"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak002
            #add-point:ON ACTION controlp INFIELD faak002 name="construct.c.faak002"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak012
            #add-point:BEFORE FIELD faak012 name="construct.b.faak012"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak012
            
            #add-point:AFTER FIELD faak012 name="construct.a.faak012"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak012
            #add-point:ON ACTION controlp INFIELD faak012 name="construct.c.faak012"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak013
            #add-point:BEFORE FIELD faak013 name="construct.b.faak013"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak013
            
            #add-point:AFTER FIELD faak013 name="construct.a.faak013"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak013
            #add-point:ON ACTION controlp INFIELD faak013 name="construct.c.faak013"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.faak006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak006
            #add-point:ON ACTION controlp INFIELD faak006 name="construct.c.faak006"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161111-00049#5 add e---     			   
            #CALL q_faac001_1()  #161111-00049#5 mark
            DISPLAY g_qryparam.return1 TO faak006  #顯示到畫面上

            NEXT FIELD faak006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak006
            #add-point:BEFORE FIELD faak006 name="construct.b.faak006"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak006
            
            #add-point:AFTER FIELD faak006 name="construct.a.faak006"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak007
            #add-point:ON ACTION controlp INFIELD faak007 name="construct.c.faak007"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"
			   #161111-00049#5 add e---			
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak007  #顯示到畫面上

            NEXT FIELD faak007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak007
            #add-point:BEFORE FIELD faak007 name="construct.b.faak007"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak007
            
            #add-point:AFTER FIELD faak007 name="construct.a.faak007"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak049
            #add-point:BEFORE FIELD faak049 name="construct.b.faak049"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak049
            
            #add-point:AFTER FIELD faak049 name="construct.a.faak049"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak049
            #add-point:ON ACTION controlp INFIELD faak049 name="construct.c.faak049"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakstus
            #add-point:BEFORE FIELD faakstus name="construct.b.faakstus"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakstus
            
            #add-point:AFTER FIELD faakstus name="construct.a.faakstus"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faakstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakstus
            #add-point:ON ACTION controlp INFIELD faakstus name="construct.c.faakstus"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak014
            #add-point:BEFORE FIELD faak014 name="construct.b.faak014"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak014
            
            #add-point:AFTER FIELD faak014 name="construct.a.faak014"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak014
            #add-point:ON ACTION controlp INFIELD faak014 name="construct.c.faak014"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak015
            #add-point:BEFORE FIELD faak015 name="construct.b.faak015"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak015
            
            #add-point:AFTER FIELD faak015 name="construct.a.faak015"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak015
            #add-point:ON ACTION controlp INFIELD faak015 name="construct.c.faak015"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak016
            #add-point:BEFORE FIELD faak016 name="construct.b.faak016"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak016
            
            #add-point:AFTER FIELD faak016 name="construct.a.faak016"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak016
            #add-point:ON ACTION controlp INFIELD faak016 name="construct.c.faak016"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.faak017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak017
            #add-point:ON ACTION controlp INFIELD faak017 name="construct.c.faak017"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak017  #顯示到畫面上

            NEXT FIELD faak017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak017
            #add-point:BEFORE FIELD faak017 name="construct.b.faak017"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak017
            
            #add-point:AFTER FIELD faak017 name="construct.a.faak017"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak018
            #add-point:BEFORE FIELD faak018 name="construct.b.faak018"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak018
            
            #add-point:AFTER FIELD faak018 name="construct.a.faak018"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak018
            #add-point:ON ACTION controlp INFIELD faak018 name="construct.c.faak018"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.faak019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak019
            #add-point:ON ACTION controlp INFIELD faak019 name="construct.c.faak019"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak019  #顯示到畫面上

            NEXT FIELD faak019                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak019
            #add-point:BEFORE FIELD faak019 name="construct.b.faak019"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak019
            
            #add-point:AFTER FIELD faak019 name="construct.a.faak019"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak021
            #add-point:BEFORE FIELD faak021 name="construct.b.faak021"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak021
            
            #add-point:AFTER FIELD faak021 name="construct.a.faak021"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak021
            #add-point:ON ACTION controlp INFIELD faak021 name="construct.c.faak021"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak022
            #add-point:BEFORE FIELD faak022 name="construct.b.faak022"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak022
            
            #add-point:AFTER FIELD faak022 name="construct.a.faak022"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak022
            #add-point:ON ACTION controlp INFIELD faak022 name="construct.c.faak022"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak020
            #add-point:BEFORE FIELD faak020 name="construct.b.faak020"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak020
            
            #add-point:AFTER FIELD faak020 name="construct.a.faak020"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak020
            #add-point:ON ACTION controlp INFIELD faak020 name="construct.c.faak020"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak023
            #add-point:BEFORE FIELD faak023 name="construct.b.faak023"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak023
            
            #add-point:AFTER FIELD faak023 name="construct.a.faak023"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak023
            #add-point:ON ACTION controlp INFIELD faak023 name="construct.c.faak023"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak024
            #add-point:BEFORE FIELD faak024 name="construct.b.faak024"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak024
            
            #add-point:AFTER FIELD faak024 name="construct.a.faak024"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak024
            #add-point:ON ACTION controlp INFIELD faak024 name="construct.c.faak024"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.faak025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak025
            #add-point:ON ACTION controlp INFIELD faak025 name="construct.c.faak025"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak025  #顯示到畫面上

            NEXT FIELD faak025                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak025
            #add-point:BEFORE FIELD faak025 name="construct.b.faak025"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak025
            
            #add-point:AFTER FIELD faak025 name="construct.a.faak025"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak026
            #add-point:ON ACTION controlp INFIELD faak026 name="construct.c.faak026"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_9()                           #呼叫開窗     #161024-00008#5
             CALL q_ooeg001_4()                                #呼叫開窗 #161024-00008#5 
            DISPLAY g_qryparam.return1 TO faak026  #顯示到畫面上

            NEXT FIELD faak026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak026
            #add-point:BEFORE FIELD faak026 name="construct.b.faak026"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak026
            
            #add-point:AFTER FIELD faak026 name="construct.a.faak026"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak027
            #add-point:ON ACTION controlp INFIELD faak027 name="construct.c.faak027"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
		      LET g_qryparam.arg1 = '3900'
		      LET g_qryparam.where = "( oocq004 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') OR oocq004 IS NULL)" #161111-00049#5 add 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak027  #顯示到畫面上

            NEXT FIELD faak027                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak027
            #add-point:BEFORE FIELD faak027 name="construct.b.faak027"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak027
            
            #add-point:AFTER FIELD faak027 name="construct.a.faak027"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak028
            #add-point:ON ACTION controlp INFIELD faak028 name="construct.c.faak028"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak028  #顯示到畫面上

            NEXT FIELD faak028                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak028
            #add-point:BEFORE FIELD faak028 name="construct.b.faak028"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak028
            
            #add-point:AFTER FIELD faak028 name="construct.a.faak028"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak030
            #add-point:ON ACTION controlp INFIELD faak030 name="construct.c.faak030"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            #CALL q_ooef001()                                 #呼叫開窗   #161024-00008#1
            CALL q_ooef001_47()                                         #161024-00008#1
            DISPLAY g_qryparam.return1 TO faak030  #顯示到畫面上

            NEXT FIELD faak030                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak030
            #add-point:BEFORE FIELD faak030 name="construct.b.faak030"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak030
            
            #add-point:AFTER FIELD faak030 name="construct.a.faak030"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak031
            #add-point:ON ACTION controlp INFIELD faak031 name="construct.c.faak031"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = "3"  
            #CALL q_ooef001_04()                           #呼叫開窗
            LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str     #161024-00008#1    #161017-00023#1 add l_comp_str lujh
            CALL q_ooef001()                                            #161024-00008#1
            DISPLAY g_qryparam.return1 TO faak031  #顯示到畫面上

            NEXT FIELD faak031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak031
            #add-point:BEFORE FIELD faak031 name="construct.b.faak031"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak031
            
            #add-point:AFTER FIELD faak031 name="construct.a.faak031"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak032
            #add-point:ON ACTION controlp INFIELD faak032 name="construct.c.faak032"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_comp_str                   #161017-00023#1 add lujh
            #CALL q_ooef001()                      #呼叫開窗     #161017-00023#1 mark lujh
            CALL q_ooef001_2()                                  #161017-00023#1 add lujh
            DISPLAY g_qryparam.return1 TO faak032  #顯示到畫面上

            NEXT FIELD faak032                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak032
            #add-point:BEFORE FIELD faak032 name="construct.b.faak032"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak032
            
            #add-point:AFTER FIELD faak032 name="construct.a.faak032"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak029
            #add-point:ON ACTION controlp INFIELD faak029 name="construct.c.faak029"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak029  #顯示到畫面上

            NEXT FIELD faak029                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak029
            #add-point:BEFORE FIELD faak029 name="construct.b.faak029"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak029
            
            #add-point:AFTER FIELD faak029 name="construct.a.faak029"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak009
            #add-point:ON ACTION controlp INFIELD faak009 name="construct.c.faak009"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 mod e-- 
            #CALL q_pmaa001_10()                           #呼叫開窗
            LET g_qryparam.arg1 = "('1','3')"
            SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_ooef017,"') "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--              
            DISPLAY g_qryparam.return1 TO faak009  #顯示到畫面上

            NEXT FIELD faak009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak009
            #add-point:BEFORE FIELD faak009 name="construct.b.faak009"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak009
            
            #add-point:AFTER FIELD faak009 name="construct.a.faak009"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak010
            #add-point:ON ACTION controlp INFIELD faak010 name="construct.c.faak010"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #161111-00049#5 mod s--
            #CALL q_pmaa001_5()                           #呼叫開窗
            LET g_qryparam.arg1 = "('2','3')"
            SELECT ooef017 INTO g_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_ooef017,"') "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--             
            DISPLAY g_qryparam.return1 TO faak010  #顯示到畫面上

            NEXT FIELD faak010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak010
            #add-point:BEFORE FIELD faak010 name="construct.b.faak010"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak010
            
            #add-point:AFTER FIELD faak010 name="construct.a.faak010"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak011
            #add-point:ON ACTION controlp INFIELD faak011 name="construct.c.faak011"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak011  #顯示到畫面上

            NEXT FIELD faak011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak011
            #add-point:BEFORE FIELD faak011 name="construct.b.faak011"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak011
            
            #add-point:AFTER FIELD faak011 name="construct.a.faak011"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak000
            #add-point:BEFORE FIELD faak000 name="construct.b.faak000"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak000
            
            #add-point:AFTER FIELD faak000 name="construct.a.faak000"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak000
            #add-point:ON ACTION controlp INFIELD faak000 name="construct.c.faak000"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak043
            #add-point:BEFORE FIELD faak043 name="construct.b.faak043"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak043
            
            #add-point:AFTER FIELD faak043 name="construct.a.faak043"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak043
            #add-point:ON ACTION controlp INFIELD faak043 name="construct.c.faak043"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak005
            #add-point:BEFORE FIELD faak005 name="construct.b.faak005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak005
            
            #add-point:AFTER FIELD faak005 name="construct.a.faak005"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak005
            #add-point:ON ACTION controlp INFIELD faak005 name="construct.c.faak005"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.faak008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak008
            #add-point:ON ACTION controlp INFIELD faak008 name="construct.c.faak008"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '3903'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak008  #顯示到畫面上

            NEXT FIELD faak008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak008
            #add-point:BEFORE FIELD faak008 name="construct.b.faak008"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak008
            
            #add-point:AFTER FIELD faak008 name="construct.a.faak008"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak035
            #add-point:BEFORE FIELD faak035 name="construct.b.faak035"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak035
            
            #add-point:AFTER FIELD faak035 name="construct.a.faak035"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak035
            #add-point:ON ACTION controlp INFIELD faak035 name="construct.c.faak035"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak036
            #add-point:BEFORE FIELD faak036 name="construct.b.faak036"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak036
            
            #add-point:AFTER FIELD faak036 name="construct.a.faak036"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak036
            #add-point:ON ACTION controlp INFIELD faak036 name="construct.c.faak036"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak037
            #add-point:BEFORE FIELD faak037 name="construct.b.faak037"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak037
            
            #add-point:AFTER FIELD faak037 name="construct.a.faak037"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak037
            #add-point:ON ACTION controlp INFIELD faak037 name="construct.c.faak037"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak038
            #add-point:BEFORE FIELD faak038 name="construct.b.faak038"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak038
            
            #add-point:AFTER FIELD faak038 name="construct.a.faak038"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak038
            #add-point:ON ACTION controlp INFIELD faak038 name="construct.c.faak038"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.faak042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak042
            #add-point:ON ACTION controlp INFIELD faak042 name="construct.c.faak042"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak042  #顯示到畫面上

            NEXT FIELD faak042                     #返回原欄位
                                                                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak042
            #add-point:BEFORE FIELD faak042 name="construct.b.faak042"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak042
            
            #add-point:AFTER FIELD faak042 name="construct.a.faak042"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak047
            #add-point:ON ACTION controlp INFIELD faak047 name="construct.c.faak047"
            			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inbadocno_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak047  #顯示到畫面上
            NEXT FIELD faak047                     #返回原欄位                                                                                                   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak047
            #add-point:BEFORE FIELD faak047 name="construct.b.faak047"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak047
            
            #add-point:AFTER FIELD faak047 name="construct.a.faak047"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak048
            #add-point:ON ACTION controlp INFIELD faak048 name="construct.c.faak048"
            			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak048  #顯示到畫面上
            NEXT FIELD faak048                     #返回原欄位                                                                                                  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak048
            #add-point:BEFORE FIELD faak048 name="construct.b.faak048"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak048
            
            #add-point:AFTER FIELD faak048 name="construct.a.faak048"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak039
            #add-point:ON ACTION controlp INFIELD faak039 name="construct.c.faak039"
            			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak039  #顯示到畫面上

            NEXT FIELD faak039                     #返回原欄位                                                                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak039
            #add-point:BEFORE FIELD faak039 name="construct.b.faak039"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak039
            
            #add-point:AFTER FIELD faak039 name="construct.a.faak039"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak040
            #add-point:ON ACTION controlp INFIELD faak040 name="construct.c.faak040"
            			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmdsdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak040  #顯示到畫面上
            NEXT FIELD faak040                     #返回原欄位                                                                                                  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak040
            #add-point:BEFORE FIELD faak040 name="construct.b.faak040"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak040
            
            #add-point:AFTER FIELD faak040 name="construct.a.faak040"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak041
            #add-point:ON ACTION controlp INFIELD faak041 name="construct.c.faak041"
            			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_apcadocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faak041  #顯示到畫面上
            NEXT FIELD faak041                     #返回原欄位                                                                                                  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak041
            #add-point:BEFORE FIELD faak041 name="construct.b.faak041"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak041
            
            #add-point:AFTER FIELD faak041 name="construct.a.faak041"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakld
            #add-point:BEFORE FIELD faakld name="construct.b.faakld"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakld
            
            #add-point:AFTER FIELD faakld name="construct.a.faakld"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faakld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakld
            #add-point:ON ACTION controlp INFIELD faakld name="construct.c.faakld"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak052
            #add-point:BEFORE FIELD faak052 name="construct.b.faak052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak052
            
            #add-point:AFTER FIELD faak052 name="construct.a.faak052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak052
            #add-point:ON ACTION controlp INFIELD faak052 name="construct.c.faak052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak053
            #add-point:BEFORE FIELD faak053 name="construct.b.faak053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak053
            
            #add-point:AFTER FIELD faak053 name="construct.a.faak053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak053
            #add-point:ON ACTION controlp INFIELD faak053 name="construct.c.faak053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak054
            #add-point:BEFORE FIELD faak054 name="construct.b.faak054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak054
            
            #add-point:AFTER FIELD faak054 name="construct.a.faak054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faak054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak054
            #add-point:ON ACTION controlp INFIELD faak054 name="construct.c.faak054"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faakownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakownid
            #add-point:ON ACTION controlp INFIELD faakownid name="construct.c.faakownid"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faakownid  #顯示到畫面上

            NEXT FIELD faakownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakownid
            #add-point:BEFORE FIELD faakownid name="construct.b.faakownid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakownid
            
            #add-point:AFTER FIELD faakownid name="construct.a.faakownid"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faakcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakcrtid
            #add-point:ON ACTION controlp INFIELD faakcrtid name="construct.c.faakcrtid"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faakcrtid  #顯示到畫面上

            NEXT FIELD faakcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakcrtid
            #add-point:BEFORE FIELD faakcrtid name="construct.b.faakcrtid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakcrtid
            
            #add-point:AFTER FIELD faakcrtid name="construct.a.faakcrtid"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faakowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakowndp
            #add-point:ON ACTION controlp INFIELD faakowndp name="construct.c.faakowndp"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faakowndp  #顯示到畫面上

            NEXT FIELD faakowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakowndp
            #add-point:BEFORE FIELD faakowndp name="construct.b.faakowndp"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakowndp
            
            #add-point:AFTER FIELD faakowndp name="construct.a.faakowndp"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faakcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakcrtdp
            #add-point:ON ACTION controlp INFIELD faakcrtdp name="construct.c.faakcrtdp"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faakcrtdp  #顯示到畫面上

            NEXT FIELD faakcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakcrtdp
            #add-point:BEFORE FIELD faakcrtdp name="construct.b.faakcrtdp"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakcrtdp
            
            #add-point:AFTER FIELD faakcrtdp name="construct.a.faakcrtdp"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faakmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakmodid
            #add-point:ON ACTION controlp INFIELD faakmodid name="construct.c.faakmodid"
                                                                                                                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faakmodid  #顯示到畫面上

            NEXT FIELD faakmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakmodid
            #add-point:BEFORE FIELD faakmodid name="construct.b.faakmodid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakmodid
            
            #add-point:AFTER FIELD faakmodid name="construct.a.faakmodid"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakcrtdt
            #add-point:BEFORE FIELD faakcrtdt name="construct.b.faakcrtdt"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakmoddt
            #add-point:BEFORE FIELD faakmoddt name="construct.b.faakmoddt"
                                                                                                            
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
 
{<section id="afai120.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afai120_query()
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
 
   INITIALIZE g_faak_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL afai120_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afai120_browser_fill(g_wc,"F")
      CALL afai120_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL afai120_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL afai120_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="afai120.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afai120_fetch(p_fl)
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
   LET g_faak_m.faakld = g_browser[g_current_idx].b_faakld
   LET g_faak_m.faak000 = g_browser[g_current_idx].b_faak000
   LET g_faak_m.faak001 = g_browser[g_current_idx].b_faak001
   LET g_faak_m.faak003 = g_browser[g_current_idx].b_faak003
   LET g_faak_m.faak004 = g_browser[g_current_idx].b_faak004
 
                       
   #讀取單頭所有欄位資料
   EXECUTE afai120_master_referesh USING g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003, 
       g_faak_m.faak004 INTO g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014, 
       g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak026, 
       g_faak_m.faak027,g_faak_m.faak028,g_faak_m.faak030,g_faak_m.faak031,g_faak_m.faak032,g_faak_m.faak029, 
       g_faak_m.faak009,g_faak_m.faak010,g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005, 
       g_faak_m.faak008,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042, 
       g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld, 
       g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakcrtid,g_faak_m.faakowndp, 
       g_faak_m.faakcrtdp,g_faak_m.faakmodid,g_faak_m.faakcrtdt,g_faak_m.faakmoddt,g_faak_m.faak006_desc, 
       g_faak_m.faak007_desc,g_faak_m.faak017_desc,g_faak_m.faak019_desc,g_faak_m.faak025_desc,g_faak_m.faak026_desc, 
       g_faak_m.faak027_desc,g_faak_m.faak028_desc,g_faak_m.faak030_desc,g_faak_m.faak031_desc,g_faak_m.faak032_desc, 
       g_faak_m.faak029_desc,g_faak_m.faak009_desc,g_faak_m.faak010_desc,g_faak_m.faak011_desc,g_faak_m.faak008_desc, 
       g_faak_m.faak042_desc,g_faak_m.faakownid_desc,g_faak_m.faakcrtid_desc,g_faak_m.faakowndp_desc, 
       g_faak_m.faakcrtdp_desc,g_faak_m.faakmodid_desc
   
   #遮罩相關處理
   LET g_faak_m_mask_o.* =  g_faak_m.*
   CALL afai120_faak_t_mask()
   LET g_faak_m_mask_n.* =  g_faak_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afai120_set_act_visible()
   CALL afai120_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
                           
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_faak_m_t.* = g_faak_m.*
   LET g_faak_m_o.* = g_faak_m.*
   
   LET g_data_owner = g_faak_m.faakownid      
   LET g_data_dept  = g_faak_m.faakowndp
   
   #重新顯示
   CALL afai120_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="afai120.insert" >}
#+ 資料新增
PRIVATE FUNCTION afai120_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
                           
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_faak_m.* TO NULL             #DEFAULT 設定
   LET g_faakld_t = NULL
   LET g_faak000_t = NULL
   LET g_faak001_t = NULL
   LET g_faak003_t = NULL
   LET g_faak004_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faak_m.faakownid = g_user
      LET g_faak_m.faakowndp = g_dept
      LET g_faak_m.faakcrtid = g_user
      LET g_faak_m.faakcrtdp = g_dept 
      LET g_faak_m.faakcrtdt = cl_get_current()
      LET g_faak_m.faakmodid = g_user
      LET g_faak_m.faakmoddt = cl_get_current()
      LET g_faak_m.faakstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_faak_m.faak002 = "1"
      LET g_faak_m.faak049 = "1"
      LET g_faak_m.faakstus = "N"
      LET g_faak_m.faak015 = "0"
      LET g_faak_m.faak018 = "0"
      LET g_faak_m.faak021 = "0"
      LET g_faak_m.faak022 = "0"
      LET g_faak_m.faak023 = "0"
      LET g_faak_m.faak024 = "0"
      LET g_faak_m.faak043 = "N"
      LET g_faak_m.faak005 = "1"
      LET g_faak_m.faak035 = "0"
      LET g_faak_m.faak036 = "0"
      LET g_faak_m.faak037 = "0"
      LET g_faak_m.faak038 = "0"
      LET g_faak_m.faak054 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      #add by yangxf
      SELECT ooef017 INTO g_faak_m.faak032
        FROM ooef_t
       WHERE ooef001 = g_site
         AND ooefent = g_enterprise   #20150610 add lujh
      SELECT glaa001,glaald,glaa025
        INTO g_glaa001,g_glaald,g_glaa025
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_faak_m.faak032
         AND glaa014 = 'Y'      
      #add by yangxf
      LET g_faak_m.faakld = g_glaald
      LET g_faak_m.faak004 = " "
      LET g_faak_m.faak014 = g_today
      LET g_faak_m.faak019 = g_glaa001
      LET g_faak_m.faak028 = g_site
      LET g_faak_m.faak030 = g_site
      LET g_faak_m.faak031 = g_site
#      LET g_faak_m.faak032 = g_ooef017
      LET g_faak_m.faak042 = g_site
      LET g_faak_m.faak016 = '1'
      LET g_faak_m.faak020 = '1'
      LET g_faak_m.faak025 = g_user
      LET g_faak_m.faak018 = 0
      LET g_faak_m.faak021 = 0
      LET g_faak_m.faak022 = 0
      LET g_faak_m.faak023 = 0
      LET g_faak_m.faak024 = 0
      LET g_faak_m.faak015 = 0
      LET g_faak_m.faak029=g_user
      LET g_faak_m.faak026=g_dept
      CALL afai120_faak026_desc()
      CALL afai120_faak029_desc()      
      CALL afai120_faak019_desc()
      CALL afai120_faak028_desc()
      CALL afai120_faak030_desc()
      CALL afai120_faak031_desc()
      CALL afai120_faak032_desc()
      CALL afai120_faak042_desc()
      CALL afai120_faak025_desc()
      LET g_faak_m_t.* = g_faak_m.*
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faak_m.faakstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL afai120_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
                                                      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_faak_m.* TO NULL
         CALL afai120_show()
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
   CALL afai120_set_act_visible()
   CALL afai120_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_faakld_t = g_faak_m.faakld
   LET g_faak000_t = g_faak_m.faak000
   LET g_faak001_t = g_faak_m.faak001
   LET g_faak003_t = g_faak_m.faak003
   LET g_faak004_t = g_faak_m.faak004
 
   
   #組合新增資料的條件
   LET g_add_browse = " faakent = " ||g_enterprise|| " AND",
                      " faakld = '", g_faak_m.faakld, "' "
                      ," AND faak000 = '", g_faak_m.faak000, "' "
                      ," AND faak001 = '", g_faak_m.faak001, "' "
                      ," AND faak003 = '", g_faak_m.faak003, "' "
                      ," AND faak004 = '", g_faak_m.faak004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afai120_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afai120_master_referesh USING g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003, 
       g_faak_m.faak004 INTO g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014, 
       g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak026, 
       g_faak_m.faak027,g_faak_m.faak028,g_faak_m.faak030,g_faak_m.faak031,g_faak_m.faak032,g_faak_m.faak029, 
       g_faak_m.faak009,g_faak_m.faak010,g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005, 
       g_faak_m.faak008,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042, 
       g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld, 
       g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakcrtid,g_faak_m.faakowndp, 
       g_faak_m.faakcrtdp,g_faak_m.faakmodid,g_faak_m.faakcrtdt,g_faak_m.faakmoddt,g_faak_m.faak006_desc, 
       g_faak_m.faak007_desc,g_faak_m.faak017_desc,g_faak_m.faak019_desc,g_faak_m.faak025_desc,g_faak_m.faak026_desc, 
       g_faak_m.faak027_desc,g_faak_m.faak028_desc,g_faak_m.faak030_desc,g_faak_m.faak031_desc,g_faak_m.faak032_desc, 
       g_faak_m.faak029_desc,g_faak_m.faak009_desc,g_faak_m.faak010_desc,g_faak_m.faak011_desc,g_faak_m.faak008_desc, 
       g_faak_m.faak042_desc,g_faak_m.faakownid_desc,g_faak_m.faakcrtid_desc,g_faak_m.faakowndp_desc, 
       g_faak_m.faakcrtdp_desc,g_faak_m.faakmodid_desc
   
   
   #遮罩相關處理
   LET g_faak_m_mask_o.* =  g_faak_m.*
   CALL afai120_faak_t_mask()
   LET g_faak_m_mask_n.* =  g_faak_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak006_desc,g_faak_m.faak007,g_faak_m.faak007_desc, 
       g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014,g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017, 
       g_faak_m.faak017_desc,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak019_desc,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak025_desc, 
       g_faak_m.faak026,g_faak_m.faak026_desc,g_faak_m.faak027,g_faak_m.faak027_desc,g_faak_m.faak028, 
       g_faak_m.faak028_desc,g_faak_m.faak030,g_faak_m.faak030_desc,g_faak_m.faak031,g_faak_m.faak031_desc, 
       g_faak_m.faak032,g_faak_m.faak032_desc,g_faak_m.faak029,g_faak_m.faak029_desc,g_faak_m.faak009, 
       g_faak_m.faak009_desc,g_faak_m.faak010,g_faak_m.faak010_desc,g_faak_m.faak011,g_faak_m.faak011_desc, 
       g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005,g_faak_m.faak008,g_faak_m.faak008_desc,g_faak_m.faak035, 
       g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042,g_faak_m.faak042_desc,g_faak_m.faak047, 
       g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld,g_faak_m.faak052, 
       g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakownid_desc,g_faak_m.faakcrtid, 
       g_faak_m.faakcrtid_desc,g_faak_m.faakowndp,g_faak_m.faakowndp_desc,g_faak_m.faakcrtdp,g_faak_m.faakcrtdp_desc, 
       g_faak_m.faakmodid,g_faak_m.faakmodid_desc,g_faak_m.faakcrtdt,g_faak_m.faakmoddt
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_faak_m.faakownid      
   LET g_data_dept  = g_faak_m.faakowndp
 
   #功能已完成,通報訊息中心
   CALL afai120_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afai120.modify" >}
#+ 資料修改
PRIVATE FUNCTION afai120_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
                           
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_faak_m.faakld IS NULL
 
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
   LET g_faakld_t = g_faak_m.faakld
   LET g_faak000_t = g_faak_m.faak000
   LET g_faak001_t = g_faak_m.faak001
   LET g_faak003_t = g_faak_m.faak003
   LET g_faak004_t = g_faak_m.faak004
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN afai120_cl USING g_enterprise,g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai120_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afai120_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afai120_master_referesh USING g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003, 
       g_faak_m.faak004 INTO g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014, 
       g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak026, 
       g_faak_m.faak027,g_faak_m.faak028,g_faak_m.faak030,g_faak_m.faak031,g_faak_m.faak032,g_faak_m.faak029, 
       g_faak_m.faak009,g_faak_m.faak010,g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005, 
       g_faak_m.faak008,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042, 
       g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld, 
       g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakcrtid,g_faak_m.faakowndp, 
       g_faak_m.faakcrtdp,g_faak_m.faakmodid,g_faak_m.faakcrtdt,g_faak_m.faakmoddt,g_faak_m.faak006_desc, 
       g_faak_m.faak007_desc,g_faak_m.faak017_desc,g_faak_m.faak019_desc,g_faak_m.faak025_desc,g_faak_m.faak026_desc, 
       g_faak_m.faak027_desc,g_faak_m.faak028_desc,g_faak_m.faak030_desc,g_faak_m.faak031_desc,g_faak_m.faak032_desc, 
       g_faak_m.faak029_desc,g_faak_m.faak009_desc,g_faak_m.faak010_desc,g_faak_m.faak011_desc,g_faak_m.faak008_desc, 
       g_faak_m.faak042_desc,g_faak_m.faakownid_desc,g_faak_m.faakcrtid_desc,g_faak_m.faakowndp_desc, 
       g_faak_m.faakcrtdp_desc,g_faak_m.faakmodid_desc
 
   #檢查是否允許此動作
   IF NOT afai120_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_faak_m_mask_o.* =  g_faak_m.*
   CALL afai120_faak_t_mask()
   LET g_faak_m_mask_n.* =  g_faak_m.*
   
   
 
   #顯示資料
   CALL afai120_show()
   
   WHILE TRUE
      LET g_faak_m.faakld = g_faakld_t
      LET g_faak_m.faak000 = g_faak000_t
      LET g_faak_m.faak001 = g_faak001_t
      LET g_faak_m.faak003 = g_faak003_t
      LET g_faak_m.faak004 = g_faak004_t
 
      
      #寫入修改者/修改日期資訊
      LET g_faak_m.faakmodid = g_user 
LET g_faak_m.faakmoddt = cl_get_current()
LET g_faak_m.faakmodid_desc = cl_get_username(g_faak_m.faakmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
             IF g_faak_m.faakstus = 'Y' THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'afa-00015'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN
       END IF
       IF g_faak_m.faakstus = 'X' THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'afa-00023'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN
       END IF          
      #end add-point
 
      #資料輸入
      CALL afai120_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
                                                      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_faak_m.* = g_faak_m_t.*
         CALL afai120_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE faak_t SET (faakmodid,faakmoddt) = (g_faak_m.faakmodid,g_faak_m.faakmoddt)
       WHERE faakent = g_enterprise AND faakld = g_faakld_t
         AND faak000 = g_faak000_t
         AND faak001 = g_faak001_t
         AND faak003 = g_faak003_t
         AND faak004 = g_faak004_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL afai120_set_act_visible()
   CALL afai120_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " faakent = " ||g_enterprise|| " AND",
                      " faakld = '", g_faak_m.faakld, "' "
                      ," AND faak000 = '", g_faak_m.faak000, "' "
                      ," AND faak001 = '", g_faak_m.faak001, "' "
                      ," AND faak003 = '", g_faak_m.faak003, "' "
                      ," AND faak004 = '", g_faak_m.faak004, "' "
 
   #填到對應位置
   CALL afai120_browser_fill(g_wc,"")
 
   CLOSE afai120_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afai120_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="afai120.input" >}
#+ 資料輸入
PRIVATE FUNCTION afai120_input(p_cmd)
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
   DEFINE  l_year                STRING
   DEFINE  l_month               STRING
   DEFINE  l_str                 STRING
   DEFINE  l_faak000       LIKE faak_t.faak000
   DEFINE  l_str1,l_str2   STRING
   DEFINE  l_ooef204       LIKE ooef_t.ooef204
   DEFINE  l_ooef003       LIKE ooef_t.ooef003
   DEFINE  l_ooef017             LIKE ooef_t.ooef017
   DEFINE  l_ooef017_t           LIKE ooef_t.ooef017
   DEFINE  l_glaa001             LIKE glaa_t.glaa001
   DEFINE  l_glaa001_t           LIKE glaa_t.glaa001
   DEFINE  l_glaald              LIKE glaa_t.glaald
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_comp_str            STRING       #161017-00023#1 add lujh 
   
   #150311---earl---add---s
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #150311---earl---add---e
   DEFINE  l_ld_str              STRING              #161111-00049#5 
   DEFINE  l_faad002             LIKE faad_t.faad002 #161111-00049#5   
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak006_desc,g_faak_m.faak007,g_faak_m.faak007_desc, 
       g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014,g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017, 
       g_faak_m.faak017_desc,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak019_desc,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak025_desc, 
       g_faak_m.faak026,g_faak_m.faak026_desc,g_faak_m.faak027,g_faak_m.faak027_desc,g_faak_m.faak028, 
       g_faak_m.faak028_desc,g_faak_m.faak030,g_faak_m.faak030_desc,g_faak_m.faak031,g_faak_m.faak031_desc, 
       g_faak_m.faak032,g_faak_m.faak032_desc,g_faak_m.faak029,g_faak_m.faak029_desc,g_faak_m.faak009, 
       g_faak_m.faak009_desc,g_faak_m.faak010,g_faak_m.faak010_desc,g_faak_m.faak011,g_faak_m.faak011_desc, 
       g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005,g_faak_m.faak008,g_faak_m.faak008_desc,g_faak_m.faak035, 
       g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042,g_faak_m.faak042_desc,g_faak_m.faak047, 
       g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld,g_faak_m.faak052, 
       g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakownid_desc,g_faak_m.faakcrtid, 
       g_faak_m.faakcrtid_desc,g_faak_m.faakowndp,g_faak_m.faakowndp_desc,g_faak_m.faakcrtdp,g_faak_m.faakcrtdp_desc, 
       g_faak_m.faakmodid,g_faak_m.faakmodid_desc,g_faak_m.faakcrtdt,g_faak_m.faakmoddt
   
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
   CALL afai120_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
                           
   #end add-point
   CALL afai120_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
                     CALL cl_set_combo_scc_part('faak015','9914','0,4')       
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
          g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014, 
          g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak021, 
          g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak026, 
          g_faak_m.faak027,g_faak_m.faak028,g_faak_m.faak030,g_faak_m.faak031,g_faak_m.faak032,g_faak_m.faak029, 
          g_faak_m.faak009,g_faak_m.faak010,g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005, 
          g_faak_m.faak008,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042, 
          g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld, 
          g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前 name="input.before.input"
                                                                                                            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak001
            #add-point:BEFORE FIELD faak001 name="input.b.faak001"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak001
            
            #add-point:AFTER FIELD faak001 name="input.a.faak001"
            IF NOT cl_null(g_faak_m.faak001) THEN 
               IF g_para_data = 'N' AND p_cmd = 'a' THEN
                  SELECT lpad(g_faak_m.faak001,10,'0') INTO g_faak_m.faak001
                    FROM faak_t
                   WHERE faakent = g_enterprise 
                   DISPLAY BY NAME g_faak_m.faak001
                END IF
            END IF 
            IF g_para_data2 = 'Y' AND g_faak_m.faak002 = '1' THEN
               CALL cl_set_comp_entry("faak003",FALSE)               
               LET g_faak_m.faak003 = g_faak_m.faak001
               DISPLAY BY NAME g_faak_m.faak003
            ELSE
               CALL cl_set_comp_entry("faak003",TRUE)  
            END IF
            IF  NOT cl_null(g_faak_m.faakld) AND NOT cl_null(g_faak_m.faak001) AND NOT cl_null(g_faak_m.faak003) AND g_faak_m.faak004 IS NOT NULL THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faak_m.faakld != g_faakld_t  OR g_faak_m.faak001 != g_faak001_t  OR g_faak_m.faak003 != g_faak003_t  OR g_faak_m.faak004 != g_faak004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faak_t WHERE "||"faakent = '" ||g_enterprise|| "' AND "||"faakld = '"||g_faak_m.faakld ||"' AND "|| "faak001 = '"||g_faak_m.faak001 ||"' AND "|| "faak003 = '"||g_faak_m.faak003 ||"' AND "|| "faak004 = '"||g_faak_m.faak004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #mark by yangxf
#            IF NOT cl_null(g_faak_m.faak001) THEN 
#               #卡片编号手动输入时，自动更新为十位编码
#               IF g_para_data = 'N' AND p_cmd = 'a' THEN
#                  LET g_faak_m.faak001 = g_faak_m.faak001 USING '&&&&&&&&&&' 
#                  SELECT COUNT(*) INTO l_cnt FROM faak_t
#                   WHERE faakent = g_enterprise
#                     AND faak001 = g_faak_m.faak001
#                  IF l_cnt >= 1 THEN 
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = g_faak_m.faak001 
#                     LET g_errparam.code   = "afa-00174" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     NEXT FIELD faak001
#                  END IF                  
#               END IF               
#            END IF
#            mark by yangxf

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak001
            #add-point:ON CHANGE faak001 name="input.g.faak001"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak003
            #add-point:BEFORE FIELD faak003 name="input.b.faak003"
            IF g_para_data2 <> 'Y' THEN 
               IF cl_null(g_faak_m.faak003) AND g_faak_m.faak002 = '1' THEN
                  IF g_para_data3 = 'Y' AND g_para_data2 ='N' THEN 
                     #151008-00017#1 mark-----s
#                     #150311---earl---mod---s
#                     #CALL s_aooi390('3') RETURNING l_success,g_faak_m.faak003
##                     CALL s_aooi390_auto_no('3') RETURNING l_success,g_faak_m.faak003,l_oofg_return
#                     CALL s_aooi390_gen('3') RETURNING l_success,g_faak_m.faak003,l_oofg_return   #add--2015/07/01 By shiun
#                     #150311---earl---mod---e
                     #151008-00017#1 mark-----e
                     DISPLAY BY NAME g_faak_m.faak003
                  END IF 
               END IF
            END IF                                                                                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak003
            
            #add-point:AFTER FIELD faak003 name="input.a.faak003"
                                                                                                                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_faak_m.faakld)  AND NOT cl_null(g_faak_m.faak003) AND g_faak_m.faak004 IS NOT NULL THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faak_m.faakld != g_faakld_t OR g_faak_m.faak003 != g_faak003_t  OR g_faak_m.faak004 != g_faak004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faak_t WHERE "||"faakent = '" ||g_enterprise|| "' AND "||"faakld = '"||g_faak_m.faakld ||"'  AND "|| "faak003 = '"||g_faak_m.faak003 ||"' AND "|| "faak004 = '"||g_faak_m.faak004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  #151008-00017#1-----s
#                  #add--2015/07/01 By shiun--(S)
#                  IF NOT s_aooi390_chk('3',g_faak_m.faak003) THEN
#                     LET g_faak_m.faak003 = g_faak003_t
#                     DISPLAY BY NAME g_faak_m.faak003
#                     NEXT FIELD CURRENT
#                  END IF
#                  #add--2015/07/01 By shiun--(E)
                  #151008-00017#1-----e
               END IF
            END IF
            IF  NOT cl_null(g_faak_m.faakld) AND NOT cl_null(g_faak_m.faak003) AND g_faak_m.faak002='1' THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faak_m.faakld != g_faakld_t OR g_faak_m.faak003 != g_faak003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faak_t WHERE "||"faakent = '" ||g_enterprise|| "' AND "||"faakld = '"||g_faak_m.faakld ||"'  AND "|| "faak003 = '"||g_faak_m.faak003 ||"' AND "|| "faak002 = '1' ",'afa-00069',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT afai120_faak003_chk() THEN
               LET g_faak_m.faak003 = g_faak_m_t.faak003
               NEXT FIELD faak003
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak003
            #add-point:ON CHANGE faak003 name="input.g.faak003"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak004
            #add-point:BEFORE FIELD faak004 name="input.b.faak004"
           CALL afai120_set_entry(p_cmd)
           CALL afai120_set_no_entry(p_cmd)                                                                                                                  
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak004
            
            #add-point:AFTER FIELD faak004 name="input.a.faak004"
                                                                                                                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_faak_m.faakld)  AND NOT cl_null(g_faak_m.faak003) AND g_faak_m.faak004 IS NOT NULL THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faak_m.faakld != g_faakld_t OR g_faak_m.faak003 != g_faak003_t  OR g_faak_m.faak004 != g_faak004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faak_t WHERE "||"faakent = '" ||g_enterprise|| "' AND "||"faakld = '"||g_faak_m.faakld ||"'  AND "|| "faak003 = '"||g_faak_m.faak003 ||"' AND "|| "faak004 = '"||g_faak_m.faak004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak004
            #add-point:ON CHANGE faak004 name="input.g.faak004"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak002
            #add-point:BEFORE FIELD faak002 name="input.b.faak002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak002
            
            #add-point:AFTER FIELD faak002 name="input.a.faak002"
           
        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak002
            #add-point:ON CHANGE faak002 name="input.g.faak002"
            IF g_faak_m.faak002 = '1' THEN 
               LET g_faak_m.faak003 = ''
               LET g_faak_m.faak004 = ' '
               CALL cl_set_comp_entry("faak004",FALSE)
            ELSE
               LET g_faak_m.faak003 = ''
               LET g_faak_m.faak004 = ''
               CALL cl_set_comp_entry("faak004",TRUE)
            END IF
            IF g_para_data2 = 'Y' AND g_faak_m.faak002 = '1' THEN
               CALL cl_set_comp_entry("faak003",FALSE)               
               LET g_faak_m.faak003 = g_faak_m.faak001
               DISPLAY BY NAME g_faak_m.faak003
               IF NOT cl_null(g_faak_m.faak001) AND NOT cl_null(g_faak_m.faak003) AND g_faak_m.faak004 IS NOT NULL THEN 
                  IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_faak_m.faak002 != g_faak_m_t.faak002 )) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faak_t WHERE "||"faakent = '" ||g_enterprise|| "' AND " || "faak001 = '"||g_faak_m.faak001 ||"' AND "|| "faak003 = '"||g_faak_m.faak003 ||"' AND "|| "faak004 = '"||g_faak_m.faak004 ||"'",'std-00004',0) THEN  
                        LET g_faak_m.faak002 = ''
                        NEXT FIELD faak002
                     END IF
                  END IF
               END IF
            ELSE
               CALL cl_set_comp_entry("faak003",TRUE)    
            END IF            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak012
            #add-point:BEFORE FIELD faak012 name="input.b.faak012"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak012
            
            #add-point:AFTER FIELD faak012 name="input.a.faak012"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak012
            #add-point:ON CHANGE faak012 name="input.g.faak012"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak013
            #add-point:BEFORE FIELD faak013 name="input.b.faak013"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak013
            
            #add-point:AFTER FIELD faak013 name="input.a.faak013"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak013
            #add-point:ON CHANGE faak013 name="input.g.faak013"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak006
            
            #add-point:AFTER FIELD faak006 name="input.a.faak006"
                                                                                                                        IF NOT cl_null(g_faak_m.faak006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak006
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faac001") THEN
                  #161111-00049#5 add s---
                  CALL s_axrt300_get_site(g_user,g_faak_m.faak032,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")	
                  LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str ," AND faal001 = '",g_faak_m.faak006,"'"
                  PREPARE afai120_faak006_count FROM g_sql
                  EXECUTE afai120_faak006_count INTO l_cnt   
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01123'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faak_m.faak006 = g_faak_m_t.faak006
                     CALL afai120_faak006_desc() 
                     NEXT FIELD CURRENT  
                  ELSE
                     IF NOT cl_null(g_faak_m.faak007) THEN
                        LET l_cnt = 0 
                        SELECT COUNT(1) INTO l_cnt FROM faad_t WHERE faadent = g_enterprise AND faad001 = g_faak_m.faak007 AND faad002 = g_faak_m.faak006
                        IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                        IF l_cnt = 0 THEN 
                           LET g_faak_m.faak007 = NULL                        
                        ELSE   
                           LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str," AND faal001 = '",g_faak_m.faak006,"'" 
                           PREPARE afai120_faak007_count1 FROM g_sql
                           EXECUTE afai120_faak007_count1 INTO l_cnt   
                           IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                           IF l_cnt = 0 THEN 
                              LET g_faak_m.faak007 = NULL
                           END IF
                       END IF 
                       INITIALIZE g_ref_fields TO NULL
                       LET g_ref_fields[1] = g_faak_m.faak007
                       CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                       LET g_faak_m.faak007_desc = '', g_rtn_fields[1] , ''
                       DISPLAY BY NAME g_faak_m.faak007_desc                       
                     END IF                     
                  END IF
                  #161111-00049#5 add e---
               ELSE
                  LET g_faak_m.faak006 = g_faak_m_t.faak006
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL afai120_faak006_desc()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak006
            #add-point:BEFORE FIELD faak006 name="input.b.faak006"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak006
            #add-point:ON CHANGE faak006 name="input.g.faak006"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak007
            
            #add-point:AFTER FIELD faak007 name="input.a.faak007"
                                                                                                                        IF NOT cl_null(g_faak_m.faak007) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak007
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00009:sub-01302|afai030|",cl_get_progname("afai030",g_lang,"2"),"|:EXEPROGafai030"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#5 add s---
                  LET l_faad002 = NULL
                  IF cl_null(g_faak_m.faak006) THEN 
                     SELECT faad002 INTO l_faad002 FROM faad_t WHERE faadent = g_enterprise AND faad001 = g_faak_m.faak007
                  ELSE
                     LET l_faad002 = g_faak_m.faak006                  
                  END IF   
                  CALL s_axrt300_get_site(g_user,g_faak_m.faak032,'2') RETURNING l_ld_str 
                  LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")	
                  LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str," AND faal001 = '",l_faad002,"'" 
                  PREPARE afai120_faak007_count FROM g_sql
                  EXECUTE afai120_faak007_count INTO l_cnt   
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01124'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faak_m.faak007 = g_faak_m_t.faak007
                     NEXT FIELD CURRENT                   
                  END IF
                  #161111-00049#5 add e---  
               ELSE
                   LET g_faak_m.faak007 = g_faak_m_t.faak007
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faak_m.faak007
            CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faak_m.faak007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faak_m.faak007_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak007
            #add-point:BEFORE FIELD faak007 name="input.b.faak007"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak007
            #add-point:ON CHANGE faak007 name="input.g.faak007"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak049
            #add-point:BEFORE FIELD faak049 name="input.b.faak049"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak049
            
            #add-point:AFTER FIELD faak049 name="input.a.faak049"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak049
            #add-point:ON CHANGE faak049 name="input.g.faak049"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakstus
            #add-point:BEFORE FIELD faakstus name="input.b.faakstus"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakstus
            
            #add-point:AFTER FIELD faakstus name="input.a.faakstus"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faakstus
            #add-point:ON CHANGE faakstus name="input.g.faakstus"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak014
            #add-point:BEFORE FIELD faak014 name="input.b.faak014"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak014
            
            #add-point:AFTER FIELD faak014 name="input.a.faak014"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak014
            #add-point:ON CHANGE faak014 name="input.g.faak014"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak015
            #add-point:BEFORE FIELD faak015 name="input.b.faak015"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak015
            
            #add-point:AFTER FIELD faak015 name="input.a.faak015"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak015
            #add-point:ON CHANGE faak015 name="input.g.faak015"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak016
            #add-point:BEFORE FIELD faak016 name="input.b.faak016"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak016
            
            #add-point:AFTER FIELD faak016 name="input.a.faak016"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak016
            #add-point:ON CHANGE faak016 name="input.g.faak016"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak017
            
            #add-point:AFTER FIELD faak017 name="input.a.faak017"
                                                                                                                        IF NOT cl_null(g_faak_m.faak017) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak017
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  LET g_faak_m.faak017 = g_faak_m_t.faak017
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faak_m.faak017
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faak_m.faak017_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faak_m.faak017_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak017
            #add-point:BEFORE FIELD faak017 name="input.b.faak017"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak017
            #add-point:ON CHANGE faak017 name="input.g.faak017"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faak_m.faak018,"0","0","","","azz-00079",1) THEN
               NEXT FIELD faak018
            END IF 
 
 
 
            #add-point:AFTER FIELD faak018 name="input.a.faak018"
#mark by yangxf
#            IF NOT cl_null(g_faak_m.faak018) AND NOT cl_null(g_faak_m.faak021) THEN 
#               LET g_faak_m.faak022 = g_faak_m.faak021 * g_faak_m.faak018
#               CALL s_curr_round(g_site,g_faak_m.faak019,g_faak_m.faak022,2) RETURNING g_faak_m.faak022
#               DISPLAY g_faak_m.faak022 TO faak022                  
#            END IF 
#            IF NOT cl_null(g_faak_m.faak018) AND NOT cl_null(g_faak_m.faak023)  THEN 
#               LET g_faak_m.faak024 = g_faak_m.faak023 * g_faak_m.faak018
#               CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak024,2) RETURNING g_faak_m.faak024
#               DISPLAY g_faak_m.faak024 TO faak024                 
#            END IF
#mark by yangxf
            IF NOT cl_null(g_faak_m.faak021) THEN 
               LET g_faak_m.faak022 = g_faak_m.faak018 * g_faak_m.faak021
            END IF 
            IF NOT cl_null(g_faak_m.faak023) THEN 
               LET g_faak_m.faak024 = g_faak_m.faak018 * g_faak_m.faak023
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak018
            #add-point:BEFORE FIELD faak018 name="input.b.faak018"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak018
            #add-point:ON CHANGE faak018 name="input.g.faak018"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak019
            
            #add-point:AFTER FIELD faak019 name="input.a.faak019"
                                                                                                                        IF NOT cl_null(g_faak_m.faak019) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak019
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                   LET l_str1 = afai120_set_format_str(g_site,g_faak_m.faak019,1)
                   LET l_str2 = afai120_set_format_str(g_site,g_faak_m.faak019,2)
#                   CALL afai120_set_format('faak021',l_str1)  
#                   CALL afai120_set_format('faak022',l_str2)
                   CALL afai120_get_exrate()
                   LET g_faak_m.faak020 = g_ooan005
                   DISPLAY BY NAME g_faak_m.faak020
                   IF NOT cl_null(g_faak_m.faak021) AND NOT cl_null(g_faak_m.faak018) THEN 
                     CALL s_curr_round(g_site,g_faak_m.faak019,g_faak_m.faak021,1) RETURNING g_faak_m.faak021
                     LET g_faak_m.faak022 = g_faak_m.faak018 * g_faak_m.faak021
                     CALL s_curr_round(g_site,g_faak_m.faak019,g_faak_m.faak022,2) RETURNING g_faak_m.faak022
                     LET g_faak_m.faak023 = g_faak_m.faak021 * g_ooan005
                     CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak023,1) RETURNING g_faak_m.faak023
                     LET g_faak_m.faak024 = g_faak_m.faak018 * g_faak_m.faak023
                     CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak024,2) RETURNING g_faak_m.faak024
                     DISPLAY g_faak_m.faak021 TO faak021
                     DISPLAY g_faak_m.faak022 TO faak022
                     DISPLAY g_faak_m.faak023 TO faak023
                     DISPLAY g_faak_m.faak024 TO faak024
                  END IF  
               ELSE
                  LET g_faak_m.faak019 = g_faak_m_t.faak019
                  NEXT FIELD CURRENT
               END IF
            
               CALL afai120_faak019_desc()
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak019
            #add-point:BEFORE FIELD faak019 name="input.b.faak019"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak019
            #add-point:ON CHANGE faak019 name="input.g.faak019"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faak_m.faak021,"0","0","","","azz-00079",1) THEN
               NEXT FIELD faak021
            END IF 
 
 
 
            #add-point:AFTER FIELD faak021 name="input.a.faak021"
                                                                                                                        CALL afai120_get_exrate()
            IF NOT cl_null(g_faak_m.faak021) AND NOT cl_null(g_faak_m.faak018) THEN 
               CALL s_curr_round(g_site,g_faak_m.faak019,g_faak_m.faak021,1) RETURNING g_faak_m.faak021
               LET g_faak_m.faak022 = g_faak_m.faak018 * g_faak_m.faak021
               CALL s_curr_round(g_site,g_faak_m.faak019,g_faak_m.faak022,2) RETURNING g_faak_m.faak022
               LET g_faak_m.faak023 = g_faak_m.faak021 * g_ooan005
               CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak023,1) RETURNING g_faak_m.faak023
               LET g_faak_m.faak024 = g_faak_m.faak018 * g_faak_m.faak023
               CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak024,2) RETURNING g_faak_m.faak024 
               DISPLAY g_faak_m.faak021 TO faak021               
               DISPLAY g_faak_m.faak022 TO faak022
               DISPLAY g_faak_m.faak023 TO faak023
               DISPLAY g_faak_m.faak024 TO faak024
            END IF 
            
            IF NOT cl_null(g_faak_m.faak021) AND NOT cl_null(g_faak_m.faak023) AND g_faak_m.faak019 = g_glaa001 THEN 
               IF g_faak_m.faak021 <> g_faak_m.faak023 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00017'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faak_m.faak021 = g_faak_m_t.faak021
                  NEXT FIELD faak021
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak021
            #add-point:BEFORE FIELD faak021 name="input.b.faak021"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak021
            #add-point:ON CHANGE faak021 name="input.g.faak021"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak022
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faak_m.faak022,"0","0","","","azz-00079",1) THEN
               NEXT FIELD faak022
            END IF 
 
 
 
            #add-point:AFTER FIELD faak022 name="input.a.faak022"
#                                                            IF NOT cl_null(g_faak_m.faak022) THEN 
#               CALL s_curr_round(g_site,g_faak_m.faak019,g_faak_m.faak022,2) RETURNING g_faak_m.faak022
#               DISPLAY g_faak_m.faak022 TO faak022 
#               IF NOT cl_null(g_faak_m.faak021) THEN
#                  LET g_faak_m.faak018 = g_faak_m.faak022 / g_faak_m.faak021
#                  LET g_faak_m.faak024 = g_faak_m.faak018 * g_faak_m.faak023
#                  CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak024,2) RETURNING g_faak_m.faak024
#                  DISPLAY BY NAME g_faak_m.faak018,g_faak_m.faak024
#               END IF
#            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak022
            #add-point:BEFORE FIELD faak022 name="input.b.faak022"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak022
            #add-point:ON CHANGE faak022 name="input.g.faak022"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak020
            #add-point:BEFORE FIELD faak020 name="input.b.faak020"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak020
            
            #add-point:AFTER FIELD faak020 name="input.a.faak020"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak020
            #add-point:ON CHANGE faak020 name="input.g.faak020"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faak_m.faak023,"0","0","","","azz-00079",1) THEN
               NEXT FIELD faak023
            END IF 
 
 
 
            #add-point:AFTER FIELD faak023 name="input.a.faak023"
            IF NOT cl_null(g_faak_m.faak021) AND NOT cl_null(g_faak_m.faak023) AND g_faak_m.faak020 = g_glaa001 THEN 
               IF g_faak_m.faak021 <> g_faak_m.faak023 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00017'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faak_m.faak023 = g_faak_m_t.faak023
                  NEXT FIELD faak023
               END IF
            END IF
#            CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak023,1) RETURNING g_faak_m.faak023
#            DISPLAY g_faak_m.faak023 TO faak023                
#            IF NOT cl_null(g_faak_m.faak023) AND NOT cl_null(g_faak_m.faak028) THEN 
#               LET g_faak_m.faak024 = g_faak_m.faak018 * g_faak_m.faak023
#               CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak024,2) RETURNING g_faak_m.faak024
#               DISPLAY g_faak_m.faak024 TO faak024                   
#            END IF
            IF NOT cl_null(g_faak_m.faak023) AND NOT cl_null(g_faak_m.faak018) THEN 
               LET g_faak_m.faak024 = g_faak_m.faak018 * g_faak_m.faak023
               DISPLAY BY NAME g_faak_m.faak024
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak023
            #add-point:BEFORE FIELD faak023 name="input.b.faak023"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak023
            #add-point:ON CHANGE faak023 name="input.g.faak023"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak024
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faak_m.faak024,"0","0","","","azz-00079",1) THEN
               NEXT FIELD faak024
            END IF 
 
 
 
            #add-point:AFTER FIELD faak024 name="input.a.faak024"
#                                                IF NOT cl_null(g_faak_m.faak024) THEN 
#               CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak024,2) RETURNING g_faak_m.faak024
#               DISPLAY g_faak_m.faak024 TO faak024 
#            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak024
            #add-point:BEFORE FIELD faak024 name="input.b.faak024"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak024
            #add-point:ON CHANGE faak024 name="input.g.faak024"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak025
            
            #add-point:AFTER FIELD faak025 name="input.a.faak025"
                                                                                                                        IF NOT cl_null(g_faak_m.faak025) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak025
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  LET g_faak_m.faak025 = g_faak_m_t.faak025
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faak_m.faak025
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faak_m.faak025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faak_m.faak025_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak025
            #add-point:BEFORE FIELD faak025 name="input.b.faak025"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak025
            #add-point:ON CHANGE faak025 name="input.g.faak025"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak026
            
            #add-point:AFTER FIELD faak026 name="input.a.faak026"
                                                                                                                        IF NOT cl_null(g_faak_m.faak026) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_faak_m.faak026
               LET g_chkparam.arg2 = g_today
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
               #IF cl_chk_exist("v_ooeg001_3") THEN #161024-00008#5
               IF cl_chk_exist("v_ooeg001_8") THEN  #161024-00008#5
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faak_m.faak026 = g_faak_m_t.faak026
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL afai120_faak026_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak026
            #add-point:BEFORE FIELD faak026 name="input.b.faak026"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak026
            #add-point:ON CHANGE faak026 name="input.g.faak026"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak027
            
            #add-point:AFTER FIELD faak027 name="input.a.faak027"
                                                                                                                        IF NOT cl_null(g_faak_m.faak027) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak027

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3900") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#5 add s---
                  LET l_cnt = 0 
                  SELECT COUNT(1) INTO l_cnt FROM oocq_t WHERE oocqent = g_enterprise AND oocq001 = '3900' 
                     AND oocq002 = g_faak_m.faak027 AND (oocq004 = g_faak_m.faak032 OR oocq004 IS NULL) 
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01120'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faak_m.faak027 = g_faak_m_t.faak027
                     NEXT FIELD CURRENT                  
                  END IF  
                  #161111-00049#5 add e---  
               ELSE
                  #檢查失敗時後續處理
                  LET g_faak_m.faak027 = g_faak_m_t.faak027
                  NEXT FIELD CURRENT
               END IF
               CALL afai120_faak027_desc()

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak027
            #add-point:BEFORE FIELD faak027 name="input.b.faak027"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak027
            #add-point:ON CHANGE faak027 name="input.g.faak027"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak028
            
            #add-point:AFTER FIELD faak028 name="input.a.faak028"
            IF NOT cl_null(g_faak_m.faak028) THEN 
               
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak028
               LET g_chkparam.arg2 = g_site
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #161111-00049#5 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_faak_m.faak028,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faak_m.faak028 = g_faak_m_t.faak028
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e---               
                  IF g_faak_m.faak028 <> g_faak_m_t.faak028 THEN 
                     SELECT ooef017 INTO l_ooef017
                       FROM ooef_t
                      WHERE ooefent = g_enterprise
                        AND ooef001 = g_faak_m.faak028
                     SELECT ooef017 INTO l_ooef017_t
                       FROM ooef_t
                      WHERE ooefent = g_enterprise
                        AND ooef001 = g_faak_m_t.faak028 
                        
                     SELECT glaa001,glaald INTO l_glaa001,l_glaald,g_glaa025
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = l_ooef017
                        AND glaa014 = 'Y'
                        
                     LET g_glaald = l_glaald
                     LET g_glaa001 = l_glaa001
                     LET g_faak_m.faak032 = l_ooef017  
                     DISPLAY BY NAME g_faak_m.faak032   
                     

                     CALL cl_get_para(g_enterprise,g_faak_m.faak032,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
                     CALL cl_get_para(g_enterprise,g_faak_m.faak032,'S-FIN-9003') RETURNING g_para_data2  #关帐日期
                     SELECT glaa001 INTO l_glaa001_t
                       FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = l_ooef017_t
                        AND glaa014 = 'Y'
                        
                     IF l_ooef017 <> l_ooef017_t AND l_glaa001_t <> l_glaa001 THEN 
                        LET g_faak_m.faak032 = l_ooef017  #161111-00049#5
                        DISPLAY BY NAME g_faak_m.faak032  #161111-00049#5
                        CALL cl_get_para(g_enterprise,g_faak_m.faak032,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號 #161111-00049#5
                        CALL cl_get_para(g_enterprise,g_faak_m.faak032,'S-FIN-9003') RETURNING g_para_data2  #关帐日期            #161111-00049#5             
                        #161111-00049#5 add s---
                        #檢查主要類型是不在此所有組織下
                        IF NOT cl_null(g_faak_m.faak006) THEN 
                           CALL s_axrt300_get_site(g_user,g_faak_m.faak032,'2') RETURNING l_ld_str 
                           LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")	
                           LET g_sql = " SELECT COUNT(1) FROM faal_t WHERE faalent = '",g_enterprise,"' AND ", l_ld_str ," AND faal001 = '",g_faak_m.faak006,"'"
                           PREPARE afai120_faak006_count1 FROM g_sql
                           EXECUTE afai120_faak006_count1 INTO l_cnt   
                           IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF                  
                           IF l_cnt = 0 THEN 
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'afa-01123'
                              LET g_errparam.extend = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              NEXT FIELD faak006  
                           END IF 
                        END IF                        
                        #161111-00049#5 add e---                     
                        CALL afai120_get_exrate()
                         LET g_faak_m.faak020 = g_ooan005
                         DISPLAY BY NAME g_faak_m.faak020
                         IF NOT cl_null(g_faak_m.faak021) AND NOT cl_null(g_faak_m.faak018) THEN 
                           CALL s_curr_round(g_site,g_faak_m.faak019,g_faak_m.faak021,1) RETURNING g_faak_m.faak021
                           LET g_faak_m.faak022 = g_faak_m.faak018 * g_faak_m.faak021
                           CALL s_curr_round(g_site,g_faak_m.faak019,g_faak_m.faak022,2) RETURNING g_faak_m.faak022
                           LET g_faak_m.faak023 = g_faak_m.faak021 * g_ooan005
                           CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak023,1) RETURNING g_faak_m.faak023
                           LET g_faak_m.faak024 = g_faak_m.faak018 * g_faak_m.faak023
                           CALL s_curr_round(g_site,g_glaa001,g_faak_m.faak024,2) RETURNING g_faak_m.faak024
                           DISPLAY g_faak_m.faak021 TO faak021
                           DISPLAY g_faak_m.faak022 TO faak022
                           DISPLAY g_faak_m.faak023 TO faak023
                           DISPLAY g_faak_m.faak024 TO faak024
                        END IF
                     END IF
                  END IF
                      
               ELSE
                  #檢查失敗時後續處理
                  LET g_faak_m.faak028 = g_faak_m_t.faak028
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            CALL afai120_faak028_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak028
            #add-point:BEFORE FIELD faak028 name="input.b.faak028"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak028
            #add-point:ON CHANGE faak028 name="input.g.faak028"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak030
            
            #add-point:AFTER FIELD faak030 name="input.a.faak030"
                                                                                                                        IF NOT cl_null(g_faak_m.faak030) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak030
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
              # IF cl_chk_exist("v_ooef001") THEN   #161024-00008#1
               IF cl_chk_exist("v_ooef001_26") THEN #161024-00008#1
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#5 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_faak_m.faak030,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faak_m.faak030 = g_faak_m_t.faak030
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e---
               ELSE
                  LET g_faak_m.faak030 = g_faak_m_t.faak030
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL afai120_faak030_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak030
            #add-point:BEFORE FIELD faak030 name="input.b.faak030"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak030
            #add-point:ON CHANGE faak030 name="input.g.faak030"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak031
            
            #add-point:AFTER FIELD faak031 name="input.a.faak031"
                                                                                                                        IF NOT cl_null(g_faak_m.faak031) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak031
#               LET g_chkparam.arg2 = '3'    #mark by yangxf
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end    
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN
               #161024-00008#1 ---s---
               IF cl_chk_exist("v_ooef001_23") THEN
#               IF cl_chk_exist("v_ooef001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #SELECT ooef204,ooef003 INTO l_ooef204,l_ooef003
                  #  FROM ooef_t
                  # WHERE ooefent = g_enterprise
                  #   AND ooef001 = g_faak_m.faak031
                  #   
                  #IF l_ooef204 = 'N' AND l_ooef003 = 'N' THEN 
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "" 
                  #   LET g_errparam.code   = "afa-00325" 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   LET g_faak_m.faak031 = g_faak_m_t.faak031
                  #   DISPLAY BY NAME g_faak_m.faak031
                  #   NEXT FIELD CURRENT
                  #END IF
                  #161024-00008#1 ---e---
                  #161111-00049#5 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_faak_m.faak031,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faak_m.faak031 = g_faak_m_t.faak031
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e---                   
               ELSE
                  LET g_faak_m.faak031 = g_faak_m_t.faak031
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL afai120_faak031_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak031
            #add-point:BEFORE FIELD faak031 name="input.b.faak031"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak031
            #add-point:ON CHANGE faak031 name="input.g.faak031"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak032
            
            #add-point:AFTER FIELD faak032 name="input.a.faak032"
                                                                                                                        IF NOT cl_null(g_faak_m.faak032) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak032
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  LET g_faak_m.faak032 = g_faak_m_t.faak032
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL afai120_faak032_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak032
            #add-point:BEFORE FIELD faak032 name="input.b.faak032"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak032
            #add-point:ON CHANGE faak032 name="input.g.faak032"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak029
            
            #add-point:AFTER FIELD faak029 name="input.a.faak029"
                                                                                                                        IF NOT cl_null(g_faak_m.faak029) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak029
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  LET g_faak_m.faak029 = g_faak_m_t.faak029
                  NEXT FIELD CURRENT
               END IF
            

            END IF           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faak_m.faak029
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faak_m.faak029_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faak_m.faak029_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak029
            #add-point:BEFORE FIELD faak029 name="input.b.faak029"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak029
            #add-point:ON CHANGE faak029 name="input.g.faak029"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak009
            
            #add-point:AFTER FIELD faak009 name="input.a.faak009"
                                                                                                                        IF NOT cl_null(g_faak_m.faak009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak009

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#5 add s---
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_faak_m.faak032 AND pmab001 = g_faak_m.faak009 
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01119'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faak_m.faak009 = g_faak_m_t.faak009
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e---
               ELSE
                  #檢查失敗時後續處理
                  LET g_faak_m.faak009 = g_faak_m_t.faak009
                  NEXT FIELD CURRENT
               END IF
            END IF 
            LET  g_faak_m.faak010=g_faak_m.faak009
            DISPLAY g_faak_m.faak010 TO faak010
            CALL afai120_faak010_desc()
            CALL afai120_faak009_desc()
            SELECT oocg001 INTO g_faak_m.faak011 FROM oocg_t WHERE oocgent=g_enterprise AND
               oocg001 =(SELECT pmaa007 FROM pmaa_t WHERE pmaa001=g_faak_m.faak009 AND pmaaent=g_enterprise)
            DISPLAY g_faak_m.faak011 TO faak011
            CALL afai120_faak011_desc()
 
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak009
            #add-point:BEFORE FIELD faak009 name="input.b.faak009"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak009
            #add-point:ON CHANGE faak009 name="input.g.faak009"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak010
            
            #add-point:AFTER FIELD faak010 name="input.a.faak010"
                                                                                                                        IF NOT cl_null(g_faak_m.faak010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak010

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#5 add s---
                  LET l_cnt = 0
                  SELECT COUNT(1) INTO l_cnt FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = g_faak_m.faak032 AND pmab001 = g_faak_m.faak009 
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01119'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faak_m.faak010 = g_faak_m_t.faak010
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#5 add e--- 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faak_m.faak010 = g_faak_m_t.faak010
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL afai120_faak010_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak010
            #add-point:BEFORE FIELD faak010 name="input.b.faak010"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak010
            #add-point:ON CHANGE faak010 name="input.g.faak010"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak011
            
            #add-point:AFTER FIELD faak011 name="input.a.faak011"
                                                                                                                        IF NOT cl_null(g_faak_m.faak011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faak_m.faak011

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faak_m.faak011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faak_m.faak011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faak_m.faak011_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak011
            #add-point:BEFORE FIELD faak011 name="input.b.faak011"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak011
            #add-point:ON CHANGE faak011 name="input.g.faak011"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak000
            #add-point:BEFORE FIELD faak000 name="input.b.faak000"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak000
            
            #add-point:AFTER FIELD faak000 name="input.a.faak000"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak000
            #add-point:ON CHANGE faak000 name="input.g.faak000"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak043
            #add-point:BEFORE FIELD faak043 name="input.b.faak043"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak043
            
            #add-point:AFTER FIELD faak043 name="input.a.faak043"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak043
            #add-point:ON CHANGE faak043 name="input.g.faak043"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak005
            #add-point:BEFORE FIELD faak005 name="input.b.faak005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak005
            
            #add-point:AFTER FIELD faak005 name="input.a.faak005"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak005
            #add-point:ON CHANGE faak005 name="input.g.faak005"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak008
            
            #add-point:AFTER FIELD faak008 name="input.a.faak008"
                                                                                                                        IF NOT cl_null(g_faak_m.faak008) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '3903'
               LET g_chkparam.arg2 = g_faak_m.faak008
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  LET g_faak_m.faak008 = g_faak_m_t.faak008
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faak_m.faak008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3903' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faak_m.faak008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faak_m.faak008_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak008
            #add-point:BEFORE FIELD faak008 name="input.b.faak008"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak008
            #add-point:ON CHANGE faak008 name="input.g.faak008"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak035
            #add-point:BEFORE FIELD faak035 name="input.b.faak035"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak035
            
            #add-point:AFTER FIELD faak035 name="input.a.faak035"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak035
            #add-point:ON CHANGE faak035 name="input.g.faak035"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak036
            #add-point:BEFORE FIELD faak036 name="input.b.faak036"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak036
            
            #add-point:AFTER FIELD faak036 name="input.a.faak036"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak036
            #add-point:ON CHANGE faak036 name="input.g.faak036"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak037
            #add-point:BEFORE FIELD faak037 name="input.b.faak037"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak037
            
            #add-point:AFTER FIELD faak037 name="input.a.faak037"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak037
            #add-point:ON CHANGE faak037 name="input.g.faak037"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak038
            #add-point:BEFORE FIELD faak038 name="input.b.faak038"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak038
            
            #add-point:AFTER FIELD faak038 name="input.a.faak038"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak038
            #add-point:ON CHANGE faak038 name="input.g.faak038"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak042
            
            #add-point:AFTER FIELD faak042 name="input.a.faak042"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak042
            #add-point:BEFORE FIELD faak042 name="input.b.faak042"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak042
            #add-point:ON CHANGE faak042 name="input.g.faak042"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak047
            #add-point:BEFORE FIELD faak047 name="input.b.faak047"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak047
            
            #add-point:AFTER FIELD faak047 name="input.a.faak047"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak047
            #add-point:ON CHANGE faak047 name="input.g.faak047"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak048
            #add-point:BEFORE FIELD faak048 name="input.b.faak048"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak048
            
            #add-point:AFTER FIELD faak048 name="input.a.faak048"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak048
            #add-point:ON CHANGE faak048 name="input.g.faak048"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak039
            #add-point:BEFORE FIELD faak039 name="input.b.faak039"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak039
            
            #add-point:AFTER FIELD faak039 name="input.a.faak039"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak039
            #add-point:ON CHANGE faak039 name="input.g.faak039"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak040
            #add-point:BEFORE FIELD faak040 name="input.b.faak040"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak040
            
            #add-point:AFTER FIELD faak040 name="input.a.faak040"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak040
            #add-point:ON CHANGE faak040 name="input.g.faak040"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak041
            #add-point:BEFORE FIELD faak041 name="input.b.faak041"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak041
            
            #add-point:AFTER FIELD faak041 name="input.a.faak041"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak041
            #add-point:ON CHANGE faak041 name="input.g.faak041"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faakld
            #add-point:BEFORE FIELD faakld name="input.b.faakld"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faakld
            
            #add-point:AFTER FIELD faakld name="input.a.faakld"
                                                                                                                        #此段落由子樣板a05產生
            IF  NOT cl_null(g_faak_m.faakld) AND NOT cl_null(g_faak_m.faak001) AND NOT cl_null(g_faak_m.faak003) AND g_faak_m.faak004 IS NOT NULL THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faak_m.faakld != g_faakld_t  OR g_faak_m.faak001 != g_faak001_t  OR g_faak_m.faak003 != g_faak003_t  OR g_faak_m.faak004 != g_faak004_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faak_t WHERE "||"faakent = '" ||g_enterprise|| "' AND "||"faakld = '"||g_faak_m.faakld ||"' AND "|| "faak001 = '"||g_faak_m.faak001 ||"' AND "|| "faak003 = '"||g_faak_m.faak003 ||"' AND "|| "faak004 = '"||g_faak_m.faak004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faakld
            #add-point:ON CHANGE faakld name="input.g.faakld"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak052
            #add-point:BEFORE FIELD faak052 name="input.b.faak052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak052
            
            #add-point:AFTER FIELD faak052 name="input.a.faak052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak052
            #add-point:ON CHANGE faak052 name="input.g.faak052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak053
            #add-point:BEFORE FIELD faak053 name="input.b.faak053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak053
            
            #add-point:AFTER FIELD faak053 name="input.a.faak053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak053
            #add-point:ON CHANGE faak053 name="input.g.faak053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faak054
            #add-point:BEFORE FIELD faak054 name="input.b.faak054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faak054
            
            #add-point:AFTER FIELD faak054 name="input.a.faak054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faak054
            #add-point:ON CHANGE faak054 name="input.g.faak054"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.faak001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak001
            #add-point:ON ACTION controlp INFIELD faak001 name="input.c.faak001"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak003
            #add-point:ON ACTION controlp INFIELD faak003 name="input.c.faak003"
            IF g_faak_m.faak002 = '2' OR g_faak_m.faak002 = '3' THEN
               #此段落由子樣板a07產生            
               #開窗i段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_faak_m.faak003             #給予default值
               IF NOT cl_null(g_faak_m.faak004) THEN
                  LET g_qryparam.where = " faak004 = '",g_faak_m.faak004,"'"
               END IF
               
               #給予arg
               
               CALL q_faak003()                                #呼叫開窗
               
               LET g_faak_m.faak003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_qryparam.where = " "
               
               DISPLAY g_faak_m.faak003 TO faak003              #顯示到畫面上

               NEXT FIELD faak003                          #返回原欄位
            END IF                                                                           
            #END add-point
 
 
         #Ctrlp:input.c.faak004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak004
            #add-point:ON ACTION controlp INFIELD faak004 name="input.c.faak004"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak002
            #add-point:ON ACTION controlp INFIELD faak002 name="input.c.faak002"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak012
            #add-point:ON ACTION controlp INFIELD faak012 name="input.c.faak012"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak013
            #add-point:ON ACTION controlp INFIELD faak013 name="input.c.faak013"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak006
            #add-point:ON ACTION controlp INFIELD faak006 name="input.c.faak006"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak006             #給予default值

            #給予arg
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_faak_m.faak032,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161111-00049#5 add e--- 
            #CALL q_faac001_1()    #161111-00049#5 mark

            LET g_faak_m.faak006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak006 TO faak006              #顯示到畫面上

            NEXT FIELD faak006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak007
            #add-point:ON ACTION controlp INFIELD faak007 name="input.c.faak007"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak007             #給予default值

            #給予arg
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_faak_m.faak032,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 = '",g_faak_m.faak006,"' AND faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"
			   #161111-00049#5 add e---
            CALL q_faad001()                                #呼叫開窗

            LET g_faak_m.faak007 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak007 TO faak007              #顯示到畫面上

            NEXT FIELD faak007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak049
            #add-point:ON ACTION controlp INFIELD faak049 name="input.c.faak049"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faakstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakstus
            #add-point:ON ACTION controlp INFIELD faakstus name="input.c.faakstus"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak014
            #add-point:ON ACTION controlp INFIELD faak014 name="input.c.faak014"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak015
            #add-point:ON ACTION controlp INFIELD faak015 name="input.c.faak015"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak016
            #add-point:ON ACTION controlp INFIELD faak016 name="input.c.faak016"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak017
            #add-point:ON ACTION controlp INFIELD faak017 name="input.c.faak017"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak017             #給予default值

            #給予arg

            CALL q_ooca001()                                #呼叫開窗

            LET g_faak_m.faak017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak017 TO faak017              #顯示到畫面上

            NEXT FIELD faak017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak018
            #add-point:ON ACTION controlp INFIELD faak018 name="input.c.faak018"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak019
            #add-point:ON ACTION controlp INFIELD faak019 name="input.c.faak019"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak019             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_faak_m.faak019 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak019 TO faak019              #顯示到畫面上

            NEXT FIELD faak019                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak021
            #add-point:ON ACTION controlp INFIELD faak021 name="input.c.faak021"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak022
            #add-point:ON ACTION controlp INFIELD faak022 name="input.c.faak022"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak020
            #add-point:ON ACTION controlp INFIELD faak020 name="input.c.faak020"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak023
            #add-point:ON ACTION controlp INFIELD faak023 name="input.c.faak023"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak024
            #add-point:ON ACTION controlp INFIELD faak024 name="input.c.faak024"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak025
            #add-point:ON ACTION controlp INFIELD faak025 name="input.c.faak025"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak025             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_faak_m.faak025 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak025 TO faak025              #顯示到畫面上

            NEXT FIELD faak025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak026
            #add-point:ON ACTION controlp INFIELD faak026 name="input.c.faak026"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_faak_m.faak014              #呼叫開窗 #161024-00008#5 
            #CALL q_ooef001_9()                                #呼叫開窗 #161024-00008#5 
            CALL q_ooeg001_4()                                 #呼叫開窗 #161024-00008#5 

            LET g_faak_m.faak026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak026 TO faak026              #顯示到畫面上

            NEXT FIELD faak026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak027
            #add-point:ON ACTION controlp INFIELD faak027 name="input.c.faak027"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3900" #
            LET g_qryparam.where = " (oocq004 = '",g_faak_m.faak032,"' OR oocq004 IS NULL)" #161111-00049#5 add
            CALL q_oocq002()                                #呼叫開窗

            LET g_faak_m.faak027 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak027 TO faak027              #顯示到畫面上

            NEXT FIELD faak027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak028
            #add-point:ON ACTION controlp INFIELD faak028 name="input.c.faak028"
            #此段落由子樣板a07產生            
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak028             #給予default值
            LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_faak_m.faak028 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak028 TO faak028              #顯示到畫面上

            NEXT FIELD faak028                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak030
            #add-point:ON ACTION controlp INFIELD faak030 name="input.c.faak030"
            #此段落由子樣板a07產生            
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak030             #給予default值
            LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            #給予arg

            #CALL q_ooef001()                                #呼叫開窗
            CALL q_ooef001_47()                              #161024-00008#1  

            LET g_faak_m.faak030 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak030 TO faak030              #顯示到畫面上

            NEXT FIELD faak030                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak031
            #add-point:ON ACTION controlp INFIELD faak031 name="input.c.faak031"
            #此段落由子樣板a07產生            
            #開窗i段
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str    #161017-00023#1 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak031             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = "3" #
#            CALL q_ooef001_04()                                #呼叫開窗 
            #LET g_qryparam.where = " ooef204 = 'Y' OR ooef003 = 'Y' " #161024-00008#1 
            LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str    #161024-00008#1    #161017-00023#1 add l_comp_str lujh
            #給予arg

            CALL q_ooef001()                               #呼叫開窗
            LET g_faak_m.faak031 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak031 TO faak031              #顯示到畫面上

            NEXT FIELD faak031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak032
            #add-point:ON ACTION controlp INFIELD faak032 name="input.c.faak032"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak032             #給予default值

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_faak_m.faak032 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak032 TO faak032              #顯示到畫面上

            NEXT FIELD faak032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak029
            #add-point:ON ACTION controlp INFIELD faak029 name="input.c.faak029"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak029             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_faak_m.faak029 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak029 TO faak029              #顯示到畫面上

            NEXT FIELD faak029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak009
            #add-point:ON ACTION controlp INFIELD faak009 name="input.c.faak009"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak009             #給予default值

            #給予arg
            #161111-00049#5 mod s--
            #CALL q_pmaa001_10()                                #呼叫開窗
            LET g_qryparam.arg1 = "('1','3')"
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_faak_m.faak032,"')  "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--
            LET g_faak_m.faak009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak009 TO faak009              #顯示到畫面上

            NEXT FIELD faak009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak010
            #add-point:ON ACTION controlp INFIELD faak010 name="input.c.faak010"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak010             #給予default值

            #給予arg
            #161111-00049#5 mod s-- 
            #CALL q_pmaa001_5()                                #呼叫開窗
            LET g_qryparam.arg1 = "('2','3')"
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite ='",g_faak_m.faak032,"')  "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--
            LET g_faak_m.faak010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak010 TO faak010              #顯示到畫面上

            NEXT FIELD faak010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak011
            #add-point:ON ACTION controlp INFIELD faak011 name="input.c.faak011"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak011             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_faak_m.faak011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak011 TO faak011              #顯示到畫面上

            NEXT FIELD faak011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak000
            #add-point:ON ACTION controlp INFIELD faak000 name="input.c.faak000"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak043
            #add-point:ON ACTION controlp INFIELD faak043 name="input.c.faak043"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak005
            #add-point:ON ACTION controlp INFIELD faak005 name="input.c.faak005"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak008
            #add-point:ON ACTION controlp INFIELD faak008 name="input.c.faak008"
                                                                                                            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faak_m.faak008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3903" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_faak_m.faak008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faak_m.faak008 TO faak008              #顯示到畫面上

            NEXT FIELD faak008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faak035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak035
            #add-point:ON ACTION controlp INFIELD faak035 name="input.c.faak035"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak036
            #add-point:ON ACTION controlp INFIELD faak036 name="input.c.faak036"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak037
            #add-point:ON ACTION controlp INFIELD faak037 name="input.c.faak037"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak038
            #add-point:ON ACTION controlp INFIELD faak038 name="input.c.faak038"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak042
            #add-point:ON ACTION controlp INFIELD faak042 name="input.c.faak042"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak047
            #add-point:ON ACTION controlp INFIELD faak047 name="input.c.faak047"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak048
            #add-point:ON ACTION controlp INFIELD faak048 name="input.c.faak048"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak039
            #add-point:ON ACTION controlp INFIELD faak039 name="input.c.faak039"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak040
            #add-point:ON ACTION controlp INFIELD faak040 name="input.c.faak040"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak041
            #add-point:ON ACTION controlp INFIELD faak041 name="input.c.faak041"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faakld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faakld
            #add-point:ON ACTION controlp INFIELD faakld name="input.c.faakld"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.faak052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak052
            #add-point:ON ACTION controlp INFIELD faak052 name="input.c.faak052"
            
            #END add-point
 
 
         #Ctrlp:input.c.faak053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak053
            #add-point:ON ACTION controlp INFIELD faak053 name="input.c.faak053"
            
            #END add-point
 
 
         #Ctrlp:input.c.faak054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faak054
            #add-point:ON ACTION controlp INFIELD faak054 name="input.c.faak054"
            
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
               SELECT COUNT(1) INTO l_count FROM faak_t
                WHERE faakent = g_enterprise AND faakld = g_faak_m.faakld
                  AND faak000 = g_faak_m.faak000
                  AND faak001 = g_faak_m.faak001
                  AND faak003 = g_faak_m.faak003
                  AND faak004 = g_faak_m.faak004
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                                                                                                                             IF g_para_data = 'Y' THEN
                  #SELECT lpad((MAX(faak001) + 1),10,'0') INTO g_faak_m.faak001                #161009-00006#2 mark lujh
                  SELECT lpad((MAX(lpad(faak001,10,'0')) + 1),10,'0') INTO g_faak_m.faak001    #161009-00006#2 add lujh
                    FROM faak_t
                   WHERE faakent = g_enterprise
#                     AND faakld = g_faak_m.faakld           #mark by yangxf
                     AND faak032 = g_faak_m.faak032     #161009-00006#2 add lujh
                  IF cl_null(g_faak_m.faak001) THEN
                     LET g_faak_m.faak001 = '0000000001'
                  END IF
               END IF
               IF g_para_data2 = 'Y' AND g_faak_m.faak002 = '1' THEN          
                  LET g_faak_m.faak003 = g_faak_m.faak001
                  DISPLAY BY NAME g_faak_m.faak001,g_faak_m.faak003
               END IF
               LET l_year = YEAR(g_today)
               LET l_month = MONTH(g_today)
               IF l_month < 10 THEN
                  LET l_month = '0' CLIPPED,l_month
               END IF

               LET l_str = l_year CLIPPED,l_month

               LET g_sql = "SELECT MAX(faak000) ",
                           "  FROM faak_t ",
                           " WHERE faakent = '",g_enterprise,"'",
                           "   AND faakld = '",g_faak_m.faakld,"'",
                           "   AND faak000 LIKE '",l_str,"%'"
               PREPARE faak000_pre FROM g_sql
               EXECUTE faak000_pre INTO l_faak000
               IF cl_null(l_faak000) THEN
                  LET g_faak_m.faak000 = l_str,'0001'
               ELSE
                  LET g_sql = "SELECT lpad((lpad((substr(MAX(faak000),7,10) + 1),4,'0')),10,'",l_str,"')",
                              "  FROM faak_t ",
                              " WHERE faakent = '",g_enterprise,"'",
                              "   AND faakld = '",g_faak_m.faakld,"'",
                              "   AND faak000 LIKE '",l_str,"%'"
                  PREPARE faak000_pre1 FROM g_sql
                  EXECUTE faak000_pre1 INTO g_faak_m.faak000
               END IF
               
               ##151008-00017#1-----s
#               #add--2015/07/01 By shiun--(S)
#               CALL s_aooi390_get_auto_no('3',g_faak_m.faak003) RETURNING l_success,g_faak_m.faak003         
#               DISPLAY BY NAME g_faak_m.faak003
#               #add--2015/07/01 By shiun--(E)
#               CALL s_aooi390_oofi_upd('3',g_faak_m.faak003) RETURNING l_success  #add--2015/05/18 By shiun 增加編碼功能
               #151008-00017#1-----e
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO faak_t (faakent,faak001,faak003,faak004,faak002,faak012,faak013,faak006, 
                      faak007,faak049,faakstus,faak014,faak015,faak016,faak017,faak018,faak019,faak021, 
                      faak022,faak020,faak023,faak024,faak025,faak026,faak027,faak028,faak030,faak031, 
                      faak032,faak029,faak009,faak010,faak011,faak000,faak043,faak005,faak008,faak035, 
                      faak036,faak037,faak038,faak042,faak047,faak048,faak039,faak040,faak041,faakld, 
                      faak052,faak053,faak054,faakownid,faakcrtid,faakowndp,faakcrtdp,faakmodid,faakcrtdt, 
                      faakmoddt)
                  VALUES (g_enterprise,g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002, 
                      g_faak_m.faak012,g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049, 
                      g_faak_m.faakstus,g_faak_m.faak014,g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017, 
                      g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak021,g_faak_m.faak022,g_faak_m.faak020, 
                      g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak026,g_faak_m.faak027, 
                      g_faak_m.faak028,g_faak_m.faak030,g_faak_m.faak031,g_faak_m.faak032,g_faak_m.faak029, 
                      g_faak_m.faak009,g_faak_m.faak010,g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043, 
                      g_faak_m.faak005,g_faak_m.faak008,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037, 
                      g_faak_m.faak038,g_faak_m.faak042,g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039, 
                      g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld,g_faak_m.faak052,g_faak_m.faak053, 
                      g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakcrtid,g_faak_m.faakowndp,g_faak_m.faakcrtdp, 
                      g_faak_m.faakmodid,g_faak_m.faakcrtdt,g_faak_m.faakmoddt) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                                                                                                                                                                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faak_t:",SQLERRMESSAGE 
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
                  LET g_errparam.extend = g_faak_m.faakld
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
                                                                                                                                       
               #end add-point
               
               #將遮罩欄位還原
               CALL afai120_faak_t_mask_restore('restore_mask_o')
               
               UPDATE faak_t SET (faak001,faak003,faak004,faak002,faak012,faak013,faak006,faak007,faak049, 
                   faakstus,faak014,faak015,faak016,faak017,faak018,faak019,faak021,faak022,faak020, 
                   faak023,faak024,faak025,faak026,faak027,faak028,faak030,faak031,faak032,faak029,faak009, 
                   faak010,faak011,faak000,faak043,faak005,faak008,faak035,faak036,faak037,faak038,faak042, 
                   faak047,faak048,faak039,faak040,faak041,faakld,faak052,faak053,faak054,faakownid, 
                   faakcrtid,faakowndp,faakcrtdp,faakmodid,faakcrtdt,faakmoddt) = (g_faak_m.faak001, 
                   g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012,g_faak_m.faak013, 
                   g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014, 
                   g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017,g_faak_m.faak018,g_faak_m.faak019, 
                   g_faak_m.faak021,g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024, 
                   g_faak_m.faak025,g_faak_m.faak026,g_faak_m.faak027,g_faak_m.faak028,g_faak_m.faak030, 
                   g_faak_m.faak031,g_faak_m.faak032,g_faak_m.faak029,g_faak_m.faak009,g_faak_m.faak010, 
                   g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005,g_faak_m.faak008, 
                   g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042, 
                   g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041, 
                   g_faak_m.faakld,g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid, 
                   g_faak_m.faakcrtid,g_faak_m.faakowndp,g_faak_m.faakcrtdp,g_faak_m.faakmodid,g_faak_m.faakcrtdt, 
                   g_faak_m.faakmoddt)
                WHERE faakent = g_enterprise AND faakld = g_faakld_t #
                  AND faak000 = g_faak000_t
                  AND faak001 = g_faak001_t
                  AND faak003 = g_faak003_t
                  AND faak004 = g_faak004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
                                                                                                                                       
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faak_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faak_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL afai120_faak_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                                                                                                                                                                                             
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_faak_m_t)
                     LET g_log2 = util.JSON.stringify(g_faak_m)
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
 
{<section id="afai120.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afai120_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE faak_t.faakld 
   DEFINE l_oldno     LIKE faak_t.faakld 
   DEFINE l_newno02     LIKE faak_t.faak000 
   DEFINE l_oldno02     LIKE faak_t.faak000 
   DEFINE l_newno03     LIKE faak_t.faak001 
   DEFINE l_oldno03     LIKE faak_t.faak001 
   DEFINE l_newno04     LIKE faak_t.faak003 
   DEFINE l_oldno04     LIKE faak_t.faak003 
   DEFINE l_newno05     LIKE faak_t.faak004 
   DEFINE l_oldno05     LIKE faak_t.faak004 
 
   DEFINE l_master    RECORD LIKE faak_t.* #此變數樣板目前無使用
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
                           
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_faak_m.faakld IS NULL
      OR g_faak_m.faak000 IS NULL
      OR g_faak_m.faak001 IS NULL
      OR g_faak_m.faak003 IS NULL
      OR g_faak_m.faak004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_faakld_t = g_faak_m.faakld
   LET g_faak000_t = g_faak_m.faak000
   LET g_faak001_t = g_faak_m.faak001
   LET g_faak003_t = g_faak_m.faak003
   LET g_faak004_t = g_faak_m.faak004
 
   
   #清空key值
   LET g_faak_m.faakld = ""
   LET g_faak_m.faak000 = ""
   LET g_faak_m.faak001 = ""
   LET g_faak_m.faak003 = ""
   LET g_faak_m.faak004 = ""
 
    
   CALL afai120_set_entry("a")
   CALL afai120_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faak_m.faakownid = g_user
      LET g_faak_m.faakowndp = g_dept
      LET g_faak_m.faakcrtid = g_user
      LET g_faak_m.faakcrtdp = g_dept 
      LET g_faak_m.faakcrtdt = cl_get_current()
      LET g_faak_m.faakmodid = g_user
      LET g_faak_m.faakmoddt = cl_get_current()
      LET g_faak_m.faakstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
                  LET g_faak_m.faakld = g_faakld_t
                  LET g_faak_m.faakstus = 'N'
                  LET g_faak_m.faak041 = ''
                  LET g_faak_m.faak004 = ' '
                  LET g_faak_m.faak043 = 'N'
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faak_m.faakstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL afai120_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_faak_m.* TO NULL
      CALL afai120_show()
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
      LET g_errparam.extend = "faak_t:",SQLERRMESSAGE 
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
   CALL afai120_set_act_visible()
   CALL afai120_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_faakld_t = g_faak_m.faakld
   LET g_faak000_t = g_faak_m.faak000
   LET g_faak001_t = g_faak_m.faak001
   LET g_faak003_t = g_faak_m.faak003
   LET g_faak004_t = g_faak_m.faak004
 
   
   #組合新增資料的條件
   LET g_add_browse = " faakent = " ||g_enterprise|| " AND",
                      " faakld = '", g_faak_m.faakld, "' "
                      ," AND faak000 = '", g_faak_m.faak000, "' "
                      ," AND faak001 = '", g_faak_m.faak001, "' "
                      ," AND faak003 = '", g_faak_m.faak003, "' "
                      ," AND faak004 = '", g_faak_m.faak004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afai120_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
                           
   #end add-point
              
   LET g_data_owner = g_faak_m.faakownid      
   LET g_data_dept  = g_faak_m.faakowndp
              
   #功能已完成,通報訊息中心
   CALL afai120_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="afai120.show" >}
#+ 資料顯示 
PRIVATE FUNCTION afai120_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
                              DEFINE  l_str1,l_str2,l_str3,l_str4 STRING
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
             LET l_str1 = afai120_set_format_str(g_site,g_faak_m.faak019,1)
    LET l_str2 = afai120_set_format_str(g_site,g_faak_m.faak019,2)
    LET l_str3 = afai120_set_format_str(g_site,g_glaa001,1)
    LET l_str4 = afai120_set_format_str(g_site,g_glaa001,2)
#     CALL afai120_set_format('faak021,faak023',l_str1)  
#     CALL afai120_set_format('faak022,faak024',l_str2)
#     CALL afai120_set_format('faak023',l_str3)  
#     CALL afai120_set_format('faak024',l_str4)
   IF g_faak_m.faakstus <>'N' THEN
      CALL cl_set_act_visible('modify,delete',FALSE)
   ELSE
      CALL cl_set_act_visible('modify,delete',TRUE)
   END IF     
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afai120_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#                                       INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_faak_m.faakownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_faak_m.faakownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_faak_m.faakownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_faak_m.faakowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_faak_m.faakowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_faak_m.faakowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_faak_m.faakcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_faak_m.faakcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_faak_m.faakcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_faak_m.faakcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_faak_m.faakcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_faak_m.faakcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_faak_m.faakmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_faak_m.faakmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_faak_m.faakmodid_desc
#            CALL afai120_ref_show()
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak006_desc,g_faak_m.faak007,g_faak_m.faak007_desc, 
       g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014,g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017, 
       g_faak_m.faak017_desc,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak019_desc,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak025_desc, 
       g_faak_m.faak026,g_faak_m.faak026_desc,g_faak_m.faak027,g_faak_m.faak027_desc,g_faak_m.faak028, 
       g_faak_m.faak028_desc,g_faak_m.faak030,g_faak_m.faak030_desc,g_faak_m.faak031,g_faak_m.faak031_desc, 
       g_faak_m.faak032,g_faak_m.faak032_desc,g_faak_m.faak029,g_faak_m.faak029_desc,g_faak_m.faak009, 
       g_faak_m.faak009_desc,g_faak_m.faak010,g_faak_m.faak010_desc,g_faak_m.faak011,g_faak_m.faak011_desc, 
       g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005,g_faak_m.faak008,g_faak_m.faak008_desc,g_faak_m.faak035, 
       g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042,g_faak_m.faak042_desc,g_faak_m.faak047, 
       g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld,g_faak_m.faak052, 
       g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakownid_desc,g_faak_m.faakcrtid, 
       g_faak_m.faakcrtid_desc,g_faak_m.faakowndp,g_faak_m.faakowndp_desc,g_faak_m.faakcrtdp,g_faak_m.faakcrtdp_desc, 
       g_faak_m.faakmodid,g_faak_m.faakmodid_desc,g_faak_m.faakcrtdt,g_faak_m.faakmoddt
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL afai120_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faak_m.faakstus 
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
                           
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afai120.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION afai120_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
        IF g_faak_m.faakstus = 'Y' THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'afa-00015'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()

        RETURN
     END IF
     IF g_faak_m.faakstus = 'X' THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'afa-00023'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()

        RETURN
     END IF                         
   #end add-point  
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_faak_m.faakld IS NULL
   OR g_faak_m.faak000 IS NULL
   OR g_faak_m.faak001 IS NULL
   OR g_faak_m.faak003 IS NULL
   OR g_faak_m.faak004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_faakld_t = g_faak_m.faakld
   LET g_faak000_t = g_faak_m.faak000
   LET g_faak001_t = g_faak_m.faak001
   LET g_faak003_t = g_faak_m.faak003
   LET g_faak004_t = g_faak_m.faak004
 
   
   
 
   OPEN afai120_cl USING g_enterprise,g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai120_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE afai120_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afai120_master_referesh USING g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003, 
       g_faak_m.faak004 INTO g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014, 
       g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak026, 
       g_faak_m.faak027,g_faak_m.faak028,g_faak_m.faak030,g_faak_m.faak031,g_faak_m.faak032,g_faak_m.faak029, 
       g_faak_m.faak009,g_faak_m.faak010,g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005, 
       g_faak_m.faak008,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042, 
       g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld, 
       g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakcrtid,g_faak_m.faakowndp, 
       g_faak_m.faakcrtdp,g_faak_m.faakmodid,g_faak_m.faakcrtdt,g_faak_m.faakmoddt,g_faak_m.faak006_desc, 
       g_faak_m.faak007_desc,g_faak_m.faak017_desc,g_faak_m.faak019_desc,g_faak_m.faak025_desc,g_faak_m.faak026_desc, 
       g_faak_m.faak027_desc,g_faak_m.faak028_desc,g_faak_m.faak030_desc,g_faak_m.faak031_desc,g_faak_m.faak032_desc, 
       g_faak_m.faak029_desc,g_faak_m.faak009_desc,g_faak_m.faak010_desc,g_faak_m.faak011_desc,g_faak_m.faak008_desc, 
       g_faak_m.faak042_desc,g_faak_m.faakownid_desc,g_faak_m.faakcrtid_desc,g_faak_m.faakowndp_desc, 
       g_faak_m.faakcrtdp_desc,g_faak_m.faakmodid_desc
   
   
   #檢查是否允許此動作
   IF NOT afai120_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_faak_m_mask_o.* =  g_faak_m.*
   CALL afai120_faak_t_mask()
   LET g_faak_m_mask_n.* =  g_faak_m.*
   
   #將最新資料顯示到畫面上
   CALL afai120_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
                                                      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afai120_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM faak_t 
       WHERE faakent = g_enterprise AND faakld = g_faak_m.faakld 
         AND faak000 = g_faak_m.faak000 
         AND faak001 = g_faak_m.faak001 
         AND faak003 = g_faak_m.faak003 
         AND faak004 = g_faak_m.faak004 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
                                                      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faak_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
                                                      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_faak_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE afai120_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL afai120_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL afai120_browser_fill(g_wc,"")
         CALL afai120_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afai120_cl
 
   #功能已完成,通報訊息中心
   CALL afai120_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afai120.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afai120_ui_browser_refresh()
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
      IF g_browser[l_i].b_faakld = g_faak_m.faakld
         AND g_browser[l_i].b_faak000 = g_faak_m.faak000
         AND g_browser[l_i].b_faak001 = g_faak_m.faak001
         AND g_browser[l_i].b_faak003 = g_faak_m.faak003
         AND g_browser[l_i].b_faak004 = g_faak_m.faak004
 
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
 
{<section id="afai120.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afai120_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
                           
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("faakld,faak000,faak001,faak003,faak004",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                                                      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
                             
   CALL cl_set_comp_entry("faa001",TRUE)
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afai120.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afai120_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
                           
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("faakld,faak000,faak001,faak003,faak004",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("faak003,faak004",TRUE)                                                
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
                              IF g_para_data = 'Y' THEN 
      CALL cl_set_comp_entry("faak001",FALSE)
   END IF
   IF g_faak_m.faak002='1' THEN
      CALL cl_set_comp_entry("faak004",FALSE)
   END IF
   IF g_faak_m_t.faak002 = '1' AND g_faak_m.faak002 <> '1' THEN
      CALL  cl_set_comp_entry("faak004",TRUE)           
   END IF   
   IF g_para_data2 = 'Y' AND g_faak_m.faak002 = '1' THEN
      CALL cl_set_comp_entry("faak003",FALSE)               
      LET g_faak_m.faak003 = g_faak_m.faak001
      DISPLAY BY NAME g_faak_m.faak003
   ELSE
      CALL cl_set_comp_entry("faak003",TRUE)  
   END IF
   IF NOT cl_null(g_faak_m.faak041) THEN 
      CALL cl_set_comp_entry("faak018,faak019,faak020,faak021,faak023,faak028",FALSE)
   ELSE
      CALL cl_set_comp_entry("faak018,faak019,faak020,faak021,faak023,faak028",TRUE)
   END IF 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afai120.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afai120_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   #20141128 add str-by chenying
   IF g_faak_m.faakstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #20141128 add end-
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afai120.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afai120_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afai120.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afai120_default_search()
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
#   IF cl_null(g_order) THEN
#      LET g_order = "ASC"
#   END IF
#   
#   #根據外部參數(g_argv)組合wc
#   IF NOT cl_null(g_argv[01]) THEN
#      LET ls_wc = ls_wc, " faakld = '", g_argv[01], "' AND "
#   END IF
#   
#   IF NOT cl_null(g_argv[02]) THEN
#      LET ls_wc = ls_wc, " faak000 = '", g_argv[02], "' AND "
#   END IF
#   IF NOT cl_null(g_argv[03]) THEN
#      LET ls_wc = ls_wc, " faak001 = '", g_argv[03], "' AND "
#   END IF
#   IF NOT cl_null(g_argv[04]) THEN
#      LET ls_wc = ls_wc, " faak003 = '", g_argv[04], "' AND "
#   END IF
#   IF NOT cl_null(g_argv[05]) THEN
#      LET ls_wc = ls_wc, " faak004 = '", g_argv[05], "' AND "
#   END IF
#   #afat460確認后，通過【利息單】查看底稿資料
#   IF NOT cl_null(g_argv[06]) THEN
#      LET ls_wc = ls_wc, " faak041 = '", g_argv[06], "' AND "
#   END IF  
#   #afap200在建项目底稿抛转  
#   IF NOT cl_null(g_argv[07]) THEN 
#      LET ls_wc = ls_wc, " （ faak041 = ", g_argv[07], " AND "
#      
#   END IF
#   IF NOT cl_null(ls_wc) THEN
#      #若有外部參數則根據該參數組合
#      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
#      LET g_default = TRUE
#   ELSE
#      #若無外部參數則預設為1=1
#      LET g_default = FALSE
#      #預設查詢條件
#      LET g_wc = cl_qbe_get_default_qryplan()
#      IF cl_null(g_wc) THEN
#         LET g_wc = " 1=2"
#      END IF
#   END IF
#   IF g_wc.getIndexOf(" 1=2", 1) THEN
#      LET g_default = TRUE
#   END IF
# 
#   RETURN   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " faakld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " faak000 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " faak001 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " faak003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " faak004 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
      #afat460確認后，通過【利息單】查看底稿資料
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " faak041 = '", g_argv[06], "' AND "
   END IF  
   IF NOT cl_null(g_argv[07]) THEN 
      LET ls_wc = ls_wc, " (faak041 = ", g_argv[07], " AND "
      
   END IF
   #160426-00014#15 add s---
   IF NOT cl_null(g_argv[08]) THEN 
      LET ls_wc = ls_wc, " (faak047 = ", g_argv[08], " AND "
      
   END IF    
   #160426-00014#15 add e---
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
#   IF g_wc = " 1=2" THEN LET g_wc = " 1=1" END IF                           
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="afai120.mask_functions" >}
&include "erp/afa/afai120_mask.4gl"
 
{</section>}
 
{<section id="afai120.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afai120_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
                           DEFINE l_succ      LIKE type_t.chr1
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
                              LET l_succ = TRUE
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_faak_m.faakld IS NULL
      OR g_faak_m.faak000 IS NULL      OR g_faak_m.faak001 IS NULL      OR g_faak_m.faak003 IS NULL      OR g_faak_m.faak004 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afai120_cl USING g_enterprise,g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004
   IF STATUS THEN
      CLOSE afai120_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai120_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afai120_master_referesh USING g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003, 
       g_faak_m.faak004 INTO g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014, 
       g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak026, 
       g_faak_m.faak027,g_faak_m.faak028,g_faak_m.faak030,g_faak_m.faak031,g_faak_m.faak032,g_faak_m.faak029, 
       g_faak_m.faak009,g_faak_m.faak010,g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005, 
       g_faak_m.faak008,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042, 
       g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld, 
       g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakcrtid,g_faak_m.faakowndp, 
       g_faak_m.faakcrtdp,g_faak_m.faakmodid,g_faak_m.faakcrtdt,g_faak_m.faakmoddt,g_faak_m.faak006_desc, 
       g_faak_m.faak007_desc,g_faak_m.faak017_desc,g_faak_m.faak019_desc,g_faak_m.faak025_desc,g_faak_m.faak026_desc, 
       g_faak_m.faak027_desc,g_faak_m.faak028_desc,g_faak_m.faak030_desc,g_faak_m.faak031_desc,g_faak_m.faak032_desc, 
       g_faak_m.faak029_desc,g_faak_m.faak009_desc,g_faak_m.faak010_desc,g_faak_m.faak011_desc,g_faak_m.faak008_desc, 
       g_faak_m.faak042_desc,g_faak_m.faakownid_desc,g_faak_m.faakcrtid_desc,g_faak_m.faakowndp_desc, 
       g_faak_m.faakcrtdp_desc,g_faak_m.faakmodid_desc
   
 
   #檢查是否允許此動作
   IF NOT afai120_action_chk() THEN
      CLOSE afai120_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
       g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak006_desc,g_faak_m.faak007,g_faak_m.faak007_desc, 
       g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014,g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017, 
       g_faak_m.faak017_desc,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak019_desc,g_faak_m.faak021, 
       g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak025_desc, 
       g_faak_m.faak026,g_faak_m.faak026_desc,g_faak_m.faak027,g_faak_m.faak027_desc,g_faak_m.faak028, 
       g_faak_m.faak028_desc,g_faak_m.faak030,g_faak_m.faak030_desc,g_faak_m.faak031,g_faak_m.faak031_desc, 
       g_faak_m.faak032,g_faak_m.faak032_desc,g_faak_m.faak029,g_faak_m.faak029_desc,g_faak_m.faak009, 
       g_faak_m.faak009_desc,g_faak_m.faak010,g_faak_m.faak010_desc,g_faak_m.faak011,g_faak_m.faak011_desc, 
       g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005,g_faak_m.faak008,g_faak_m.faak008_desc,g_faak_m.faak035, 
       g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042,g_faak_m.faak042_desc,g_faak_m.faak047, 
       g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld,g_faak_m.faak052, 
       g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakownid_desc,g_faak_m.faakcrtid, 
       g_faak_m.faakcrtid_desc,g_faak_m.faakowndp,g_faak_m.faakowndp_desc,g_faak_m.faakcrtdp,g_faak_m.faakcrtdp_desc, 
       g_faak_m.faakmodid,g_faak_m.faakmodid_desc,g_faak_m.faakcrtdt,g_faak_m.faakmoddt
 
   CASE g_faak_m.faakstus
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
         CASE g_faak_m.faakstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
                                                      
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            IF g_faak_m.faak043 = 'Y' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00324'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_succ = FALSE
            END IF 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
                                                                                         
         LET l_succ = afai120_conf_chk()        
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
                  IF g_faak_m.faakstus = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00015'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET l_succ = FALSE
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
      g_faak_m.faakstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afai120_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF NOT l_succ THEN
      CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
      RETURN
   END IF
   #151125-00001#1 add start ------------------
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
         RETURN
      END IF
   END IF
   #151125-00001#1 add end   ------------------
   #end add-point
   
   LET g_faak_m.faakmodid = g_user
   LET g_faak_m.faakmoddt = cl_get_current()
   LET g_faak_m.faakstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE faak_t 
      SET (faakstus,faakmodid,faakmoddt) 
        = (g_faak_m.faakstus,g_faak_m.faakmodid,g_faak_m.faakmoddt)     
    WHERE faakent = g_enterprise AND faakld = g_faak_m.faakld
      AND faak000 = g_faak_m.faak000      AND faak001 = g_faak_m.faak001      AND faak003 = g_faak_m.faak003      AND faak004 = g_faak_m.faak004
    
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
      EXECUTE afai120_master_referesh USING g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003, 
          g_faak_m.faak004 INTO g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002, 
          g_faak_m.faak012,g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak007,g_faak_m.faak049,g_faak_m.faakstus, 
          g_faak_m.faak014,g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017,g_faak_m.faak018,g_faak_m.faak019, 
          g_faak_m.faak021,g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025, 
          g_faak_m.faak026,g_faak_m.faak027,g_faak_m.faak028,g_faak_m.faak030,g_faak_m.faak031,g_faak_m.faak032, 
          g_faak_m.faak029,g_faak_m.faak009,g_faak_m.faak010,g_faak_m.faak011,g_faak_m.faak000,g_faak_m.faak043, 
          g_faak_m.faak005,g_faak_m.faak008,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038, 
          g_faak_m.faak042,g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041, 
          g_faak_m.faakld,g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakcrtid, 
          g_faak_m.faakowndp,g_faak_m.faakcrtdp,g_faak_m.faakmodid,g_faak_m.faakcrtdt,g_faak_m.faakmoddt, 
          g_faak_m.faak006_desc,g_faak_m.faak007_desc,g_faak_m.faak017_desc,g_faak_m.faak019_desc,g_faak_m.faak025_desc, 
          g_faak_m.faak026_desc,g_faak_m.faak027_desc,g_faak_m.faak028_desc,g_faak_m.faak030_desc,g_faak_m.faak031_desc, 
          g_faak_m.faak032_desc,g_faak_m.faak029_desc,g_faak_m.faak009_desc,g_faak_m.faak010_desc,g_faak_m.faak011_desc, 
          g_faak_m.faak008_desc,g_faak_m.faak042_desc,g_faak_m.faakownid_desc,g_faak_m.faakcrtid_desc, 
          g_faak_m.faakowndp_desc,g_faak_m.faakcrtdp_desc,g_faak_m.faakmodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004,g_faak_m.faak002,g_faak_m.faak012, 
          g_faak_m.faak013,g_faak_m.faak006,g_faak_m.faak006_desc,g_faak_m.faak007,g_faak_m.faak007_desc, 
          g_faak_m.faak049,g_faak_m.faakstus,g_faak_m.faak014,g_faak_m.faak015,g_faak_m.faak016,g_faak_m.faak017, 
          g_faak_m.faak017_desc,g_faak_m.faak018,g_faak_m.faak019,g_faak_m.faak019_desc,g_faak_m.faak021, 
          g_faak_m.faak022,g_faak_m.faak020,g_faak_m.faak023,g_faak_m.faak024,g_faak_m.faak025,g_faak_m.faak025_desc, 
          g_faak_m.faak026,g_faak_m.faak026_desc,g_faak_m.faak027,g_faak_m.faak027_desc,g_faak_m.faak028, 
          g_faak_m.faak028_desc,g_faak_m.faak030,g_faak_m.faak030_desc,g_faak_m.faak031,g_faak_m.faak031_desc, 
          g_faak_m.faak032,g_faak_m.faak032_desc,g_faak_m.faak029,g_faak_m.faak029_desc,g_faak_m.faak009, 
          g_faak_m.faak009_desc,g_faak_m.faak010,g_faak_m.faak010_desc,g_faak_m.faak011,g_faak_m.faak011_desc, 
          g_faak_m.faak000,g_faak_m.faak043,g_faak_m.faak005,g_faak_m.faak008,g_faak_m.faak008_desc, 
          g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,g_faak_m.faak042,g_faak_m.faak042_desc, 
          g_faak_m.faak047,g_faak_m.faak048,g_faak_m.faak039,g_faak_m.faak040,g_faak_m.faak041,g_faak_m.faakld, 
          g_faak_m.faak052,g_faak_m.faak053,g_faak_m.faak054,g_faak_m.faakownid,g_faak_m.faakownid_desc, 
          g_faak_m.faakcrtid,g_faak_m.faakcrtid_desc,g_faak_m.faakowndp,g_faak_m.faakowndp_desc,g_faak_m.faakcrtdp, 
          g_faak_m.faakcrtdp_desc,g_faak_m.faakmodid,g_faak_m.faakmodid_desc,g_faak_m.faakcrtdt,g_faak_m.faakmoddt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
                           
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
                           
   #end add-point  
 
   CLOSE afai120_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afai120_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai120.signature" >}
   
 
{</section>}
 
{<section id="afai120.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afai120_set_pk_array()
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
   LET g_pk_array[1].values = g_faak_m.faakld
   LET g_pk_array[1].column = 'faakld'
   LET g_pk_array[2].values = g_faak_m.faak000
   LET g_pk_array[2].column = 'faak000'
   LET g_pk_array[3].values = g_faak_m.faak001
   LET g_pk_array[3].column = 'faak001'
   LET g_pk_array[4].values = g_faak_m.faak003
   LET g_pk_array[4].column = 'faak003'
   LET g_pk_array[5].values = g_faak_m.faak004
   LET g_pk_array[5].column = 'faak004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai120.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="afai120.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afai120_msgcentre_notify(lc_state)
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
   CALL afai120_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_faak_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai120.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afai120_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afai120.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 欄位檢查
################################################################################
PRIVATE FUNCTION afai120_faak003_chk()
   DEFINE l_n      LIKE type_t.num5
   
   IF NOT cl_null(g_faak_m.faak002) AND NOT cl_null(g_faak_m.faak003) AND g_faak_m.faak002 <> '1' THEN 
      SELECT count(*) INTO l_n 
        FROM faak_t
       WHERE faakent = g_enterprise
         AND faakld = g_faak_m.faakld
         AND faak003 = g_faak_m.faak003
         AND faak002 = '1'
         
      IF l_n = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00016'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF 
   END IF 
 RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 資產主要類型帶值
################################################################################
PRIVATE FUNCTION afai120_faak006_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak006
   CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak006_desc
   SELECT faac002,faac008,faac009,faac010,faac011,faac012,faac013,faac015  #160408-00020#4 add faac012,faac013,faac015
     INTO g_faak_m.faak005,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,
          g_faak_m.faak053,g_faak_m.faak052,g_faak_m.faak054     #160408-00020#4 add 
     FROM faac_t
    WHERE faacent = g_enterprise
      AND faac001 = g_faak_m.faak006
   DISPLAY BY NAME g_faak_m.faak005,g_faak_m.faak035,g_faak_m.faak036,g_faak_m.faak037,g_faak_m.faak038,
                   g_faak_m.faak053,g_faak_m.faak052,g_faak_m.faak054     #160408-00020#4 add 
END FUNCTION
################################################################################
# Descriptions...: 帶值說明
################################################################################
PRIVATE FUNCTION afai120_faak026_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak026
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak026_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak026_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak027_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak027
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3900' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak027_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak030_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak030
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak030_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak030_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak031_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak031
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak031_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak031_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak009_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak009
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak009_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak010_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak010
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak010_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak032_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak032
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak032_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak019_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak019
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak019_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak019_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak028_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak028_desc
END FUNCTION
################################################################################
# Descriptions...: 獲取匯率
################################################################################
PRIVATE FUNCTION afai120_get_exrate()
                            #     帳套; 日期;       來源幣別
   CALL s_aooi160_get_exrate('2',g_glaald,g_today,g_faak_m.faak019,
                         #目的幣別;  交易金額;              匯類類型
                          g_glaa001,0,g_glaa025)
   RETURNING g_ooan005
END FUNCTION
################################################################################
# Descriptions...: 設置格式string
# Memo...........:
# Usage..........: CALL afai120_set_format_str (传入参数)
#                  RETURNING 回传参数
# Input parameter: p_site  當前據點 p_faak019幣別 p_type 單價or金額
# Return code....: l_str   格式字符串
# Date & Author..: 14/03/03 By yuhuabao
# Modify.........:
################################################################################
PRIVATE FUNCTION afai120_set_format_str(p_site,p_faak019,p_type)
DEFINE p_site   LIKE apaa_t.apaasite
DEFINE p_faak019 LIKE faak_t.faak019
DEFINE p_type   LIKE type_t.chr1
DEFINE l_str    STRING
DEFINE l_ooef014 LIKE ooef_t.ooef014
DEFINE l_ooef016 LIKE ooef_t.ooef016
DEFINE l_ooaj003 LIKE ooaj_t.ooaj003
DEFINE l_ooaj004 LIKE ooaj_t.ooaj004
DEFINE l_num     LIKE ooaj_t.ooaj004
   SELECT ooef014,ooef016 INTO l_ooef014,l_ooef016 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_site
   IF cl_null(p_faak019) THEN LET p_faak019 = g_glaa001 END IF

   #2.取币种设定档
   SELECT ooaj003,ooaj004 INTO l_ooaj003,l_ooaj004 FROM ooaj_t
    WHERE ooajent = g_enterprise
      AND ooaj001 = l_ooef014
      AND ooaj002 = p_faak019
    IF p_type = '1' THEN
       LET l_num = l_ooaj003
    ELSE
       LET l_num = l_ooaj004
    END IF
    CASE l_num
       WHEN 0
          LET l_str = "###,###,###,##&"
       WHEN 1
          LET l_str = "###,###,###,##&.#"
       WHEN 2
          LET l_str = "###,###,###,##&.##"
       WHEN 3
         LET l_str = "###,###,###,##&.###"
       WHEN 4
         LET l_str = "###,###,###,##&.####"
       WHEN 5
         LET l_str = "###,###,###,##&.#####"  
       WHEN 6
         LET l_str = "###,###,###,##&.######"         
    END CASE
    RETURN l_str
END FUNCTION
################################################################################
# Descriptions...: 審核檢查
################################################################################
PRIVATE FUNCTION afai120_conf_chk()
   DEFINE  l_ooef204             LIKE ooef_t.ooef204
   DEFINE  l_ooef003             LIKE ooef_t.ooef003
   
    IF cl_null(g_faak_m.faak001) OR cl_null(g_faak_m.faak002)
       OR cl_null(g_faak_m.faak003) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = -400
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()

       RETURN FALSE
    END IF
   IF g_faak_m.faakstus = 'X' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00023'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      RETURN FALSE
   END IF
   
   IF g_faak_m.faakstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00024'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   #检查必输栏位是否为空
   IF cl_null(g_faak_m.faak005) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak005'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF
   IF cl_null(g_faak_m.faak006) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak006'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
#161130-00026#1 mark s---   
#   IF cl_null(g_faak_m.faak007) THEN 
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'amm-00017'
#      LET g_errparam.extend = 'faak007'
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      RETURN FALSE 
#   END IF 
#161130-00026#1 mark e---
   IF cl_null(g_faak_m.faak014) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak014'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak015) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak015'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak017) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak017'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF    
   IF cl_null(g_faak_m.faak018) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak018'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak019) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak019'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak021) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak021'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak022) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak022'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak023) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak023'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak024) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak024'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak025) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak025'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak026) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak026'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak027) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak027'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak028) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak028'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak029) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak029'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak030) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak030'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak031) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak031'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   IF cl_null(g_faak_m.faak032) THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00017'
      LET g_errparam.extend = 'faak032'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE 
   END IF 
   
   IF g_faak_m.faak022 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00025'
      LET g_errparam.extend = g_faak_m.faak022
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   #检查保管人员
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_faak_m.faak025
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
   #160318-00025#4--add--end
   IF NOT cl_chk_exist("v_ooag001") THEN
      RETURN FALSE 
   END IF 
   #检查保管部门是否存在部门档中
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_faak_m.faak026
   LET g_chkparam.arg2 = g_today
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
   #160318-00025#4--add--end
   IF NOT cl_chk_exist("v_ooeg001_3") THEN
      RETURN FALSE 
   END IF 
   #检查存放位置
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_faak_m.faak027
   IF NOT cl_chk_exist("v_oocq002_3900") THEN
      RETURN FALSE 
   END IF 
   #检查所属组织
   INITIALIZE g_chkparam.* TO NULL
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
   #160318-00025#4--add--end
   LET g_chkparam.arg1 = g_faak_m.faak028
   IF NOT cl_chk_exist("v_ooef001") THEN
      RETURN FALSE 
   END IF 
   #检查负责人
   INITIALIZE g_chkparam.* TO NULL
   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_faak_m.faak029
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
   #160318-00025#4--add--end
   #呼叫檢查存在並帶值的library
   IF NOT cl_chk_exist("v_ooag001") THEN
      RETURN FALSE 
   END IF 
   #检查管理组织
   INITIALIZE g_chkparam.* TO NULL
   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_faak_m.faak030
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
   #160318-00025#4--add--end
   IF NOT cl_chk_exist("v_ooef001") THEN
      RETURN FALSE 
   END IF 
   #检查核算组织
   INITIALIZE g_chkparam.* TO NULL
   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_faak_m.faak031
   #160318-00025#4--add--str
   LET g_errshow = TRUE 
   LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
   #160318-00025#4--add--end
   #呼叫檢查存在並帶值的library
   IF cl_chk_exist("v_ooef001") THEN   
      #錄入的核算組織職能類型非核算組織,請檢查！   
      SELECT ooef204,ooef003 INTO l_ooef204,l_ooef003
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_faak_m.faak031
         
      IF l_ooef204 = 'N' AND l_ooef003 = 'N' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00325'
         LET g_errparam.extend = g_faak_m.faak031
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   ELSE 
      RETURN FALSE 
   END IF 
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 未審核檢查
################################################################################
PRIVATE FUNCTION afai120_unconf_chk()
    IF cl_null(g_faak_m.faak001) OR cl_null(g_faak_m.faak002)
       OR cl_null(g_faak_m.faak003) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = -400
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()

       RETURN FALSE
    END IF
    
#    IF g_faak_m.faakstus <> 'Y' THEN
#       CALL cl_err('','afa-00026',1)
#       RETURN FALSE
#    END IF
    
    IF g_faak_m.faak015 <> '0' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'afa-00027'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()

       RETURN FALSE
    END IF
    RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_ref_show()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak006
   CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak006_desc 
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faak_m.faak007
    CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_faak_m.faak007_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_faak_m.faak007_desc    
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faak_m.faak008
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3903' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_faak_m.faak008_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_faak_m.faak008_desc

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faak_m.faak017
    CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_faak_m.faak017_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_faak_m.faak017_desc
    
    CALL afai120_faak019_desc()   
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faak_m.faak025
    CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
    LET g_faak_m.faak025_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_faak_m.faak025_desc    
 
    CALL afai120_faak026_desc()
    CALL afai120_faak027_desc()
    CALL afai120_faak028_desc()
 

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faak_m.faak029
    CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
    LET g_faak_m.faak029_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_faak_m.faak029_desc
    
    CALL afai120_faak030_desc()
    CALL afai120_faak031_desc()
    CALL afai120_faak032_desc()
    CALL afai120_faak009_desc()
    CALL afai120_faak010_desc()
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_faak_m.faak011
    CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_faak_m.faak011_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_faak_m.faak011_desc
    
    CALL afai120_faak042_desc()
END FUNCTION
################################################################################
# Descriptions...: 金額欄位格式顯示
# Memo...........:
# Usage..........: CALL afai120_set_format (传入参数)
# Input parameter: ps_fields  欄位名稱
#                : ps_formate 欄位格式
# Return code....: 無
# Date & Author..: 14/03/03 By yuhuabao 
# Modify.........:
################################################################################
PRIVATE FUNCTION afai120_set_format(ps_fields,ps_format)
   DEFINE   ps_fields           STRING,
            ps_format           STRING
   DEFINE   lst_fields          base.StringTokenizer,
            ls_field_name       STRING
   DEFINE   lnode_root          om.DomNode,
            llst_items          om.NodeList,
            li_i                LIKE type_t.num5,
            lnode_item          om.DomNode,
            ls_item_name        STRING,
            lnode_item_child    om.DomNode,
            ls_item_child_tag   STRING
   DEFINE   lwin_curr           ui.Window

   IF (ps_fields IS NULL) THEN
      RETURN
   ELSE
      LET ps_fields = ps_fields.toLowerCase()
   END IF

   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_root = lwin_curr.getNode()

   LET llst_items = lnode_root.selectByPath("//Form//*")
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
   WHILE lst_fields.hasMoreTokens()
      LET ls_field_name = lst_fields.nextToken()
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
            LET lnode_item_child = lnode_item.getFirstChild()
            LET ls_item_child_tag = lnode_item_child.getTagName()
            IF (ls_item_child_tag.equals("Edit") OR
                ls_item_child_tag.equals("ButtonEdit") OR
                ls_item_child_tag.equals("Label") OR
                ls_item_child_tag.equals("DateEdit")) THEN

               CALL lnode_item_child.setAttribute("format", "")
               CALL lnode_item_child.setAttribute("format", ps_format)
            END IF

            EXIT FOR
         END IF
      END FOR
   END WHILE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak042_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak042
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak042_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak042_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak025_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak025
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_faak_m.faak025_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak025_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afai120_faak011_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak011
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faak_m.faak011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak011_desc
END FUNCTION

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
PRIVATE FUNCTION afai120_faak029_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faak_m.faak029
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_faak_m.faak029_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faak_m.faak029_desc
END FUNCTION

################################################################################
# Descriptions...: 自動產生標籤明細
# Memo...........:
# Usage..........: CALL afai120_faai_ins(p_type)
#                  RETURNING 回传参数
# Input parameter: 無
# Return code....: 無
# Date & Author..: yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afai120_faai_ins(p_type)
   DEFINE p_type          LIKE type_t.chr1
   DEFINE l_n             LIKE type_t.num5
   DEFINE i               LIKE type_t.num5
   DEFINE l_fagl          LIKE type_t.num5
   DEFINE l_fagl2         LIKE type_t.num5
   #DEFINE l_faai          RECORD LIKE faai_t.* #mark by geza 20161122 #161111-00028#6
   #add by geza 20161122 #161111-00028#6(S)
   DEFINE l_faai RECORD  #固定資產標籤檔
       faaient LIKE faai_t.faaient, #企业编号
       faai000 LIKE faai_t.faai000, #生成批号
       faai001 LIKE faai_t.faai001, #卡片编号
       faai002 LIKE faai_t.faai002, #财产编号
       faai003 LIKE faai_t.faai003, #附号
       faaiseq LIKE faai_t.faaiseq, #项次
       faai004 LIKE faai_t.faai004, #财签条码
       faai005 LIKE faai_t.faai005, #S/N号码
       faai006 LIKE faai_t.faai006, #单位
       faai007 LIKE faai_t.faai007, #数量
       faai008 LIKE faai_t.faai008, #在外数量
       faai009 LIKE faai_t.faai009, #供应供应商
       faai010 LIKE faai_t.faai010, #制造供应商
       faai011 LIKE faai_t.faai011, #产地
       faai012 LIKE faai_t.faai012, #名称
       faai013 LIKE faai_t.faai013, #规格型号
       faai014 LIKE faai_t.faai014, #取得日期
       faai015 LIKE faai_t.faai015, #保管人员
       faai016 LIKE faai_t.faai016, #保管部门
       faai017 LIKE faai_t.faai017, #存放位置
       faai018 LIKE faai_t.faai018, #存放组织
       faai019 LIKE faai_t.faai019, #负责人员
       faai020 LIKE faai_t.faai020, #管理组织
       faai021 LIKE faai_t.faai021, #核算组织
       faai022 LIKE faai_t.faai022, #归属法人
       faai023 LIKE faai_t.faai023  #标签状态
END RECORD
   #add by geza 20161122 #161111-00028#6(E)
   DEFINE l_n1            LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_str1          LIKE type_t.chr10
   DEFINE l_str2          LIKE type_t.chr10
   DEFINE l_sql           STRING 
   DEFINE l_faai004_str   STRING
   DEFINE l_faai004_str2  LIKE type_t.chr10
   DEFINE l_faai004_str3  LIKE type_t.chr10
   DEFINE l_faai005_str   STRING
   DEFINE l_faai005_str2  LIKE type_t.chr10
   DEFINE l_faai005_str3  LIKE type_t.chr10
   DEFINE l_faai004       LIKE faai_t.faai004
   DEFINE l_faai005       LIKE faai_t.faai005
   
   IF g_faak_m.faak000 IS NULL
   OR g_faak_m.faak001 IS NULL
   OR g_faak_m.faak003 IS NULL
   OR g_faak_m.faak004 IS NULL THEN
      RETURN 
   END IF 
   IF g_faak_m.faakstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00284" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF 
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM faai_t
    WHERE faaient = g_enterprise
      AND faai000 = g_faak_m.faak000
      AND faai001 = g_faak_m.faak001
      AND faai002 = g_faak_m.faak003
      AND faai003 = g_faak_m.faak004
   IF l_n > 0 THEN 
      IF p_type = '1' THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 'afa-00288'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF 
      RETURN 
   END IF
   IF cl_null(g_faak_m.faak018) OR g_faak_m.faak018 = 0 THEN 
      RETURN 
   END IF 
   IF p_type = '2' THEN 
      IF NOT cl_ask_confirm('afa-00281') THEN 
         RETURN 
      END IF
   END IF       
   LET l_str = g_faak_m.faak018
   LET l_n1 = l_str.getIndexOf('.',1) 
   LET l_sql = " SELECT lpad(1,'",l_n1,"','0') FROM dual "
   PREPARE getnum_prepare1 FROM l_sql
   EXECUTE getnum_prepare1 INTO l_str1
   LET l_faai004 = g_faak_m.faak003,l_str1
   LET l_faai005 = g_faak_m.faak003,l_str1   
   CALL afai100_01(l_faai005,l_faai005,l_n1,g_faak_m.faak018) RETURNING l_faai004,l_faai005,l_fagl,l_fagl2
   
   INITIALIZE l_faai.* TO NULL
   LET l_faai.faaient = g_enterprise
   LET l_faai.faai000 = g_faak_m.faak000
   LET l_faai.faai001 = g_faak_m.faak001
   LET l_faai.faai002 = g_faak_m.faak003
   LET l_faai.faai003 = g_faak_m.faak004
   LET l_faai.faai006 = g_faak_m.faak017
   LET l_faai.faai009 = g_faak_m.faak009
   LET l_faai.faai010 = g_faak_m.faak010
   LET l_faai.faai011 = g_faak_m.faak011
   LET l_faai.faai012 = g_faak_m.faak012
   LET l_faai.faai013 = g_faak_m.faak013
   LET l_faai.faai014 = g_faak_m.faak014
   LET l_faai.faai015 = g_faak_m.faak025
   LET l_faai.faai016 = g_faak_m.faak026
   LET l_faai.faai017 = g_faak_m.faak027
   LET l_faai.faai018 = g_faak_m.faak028
   LET l_faai.faai019 = g_faak_m.faak029
   LET l_faai.faai020 = g_faak_m.faak030
   LET l_faai.faai021 = g_faak_m.faak031
   LET l_faai.faai022 = g_faak_m.faak032
   LET l_faai.faai023 = g_faak_m.faak015
   LET l_faai.faai008 = 0
   LET l_faai004_str = l_faai004
   LET l_faai005_str = l_faai005
   LET l_faai004_str2 = l_faai004_str.subString(1,l_faai004_str.getLength()-l_n1+1)
   LET l_faai004_str3 = l_faai004_str.subString(l_faai004_str.getLength()-l_n1+2,l_faai004_str.getLength())
   LET l_faai005_str2 = l_faai005_str.subString(1,l_faai005_str.getLength()-l_n1+1)
   LET l_faai005_str3 = l_faai005_str.subString(l_faai005_str.getLength()-l_n1+2,l_faai005_str.getLength())
   FOR i = 1 TO g_faak_m.faak018
      LET l_faai.faaiseq = i
      IF l_fagl THEN 
         LET l_str1 = ''
         LET l_sql = " SELECT lpad(",l_faai004_str3," +",i-1,",'",l_n1-1,"','0') FROM dual "
         PREPARE getnum_prepare FROM l_sql
         EXECUTE getnum_prepare INTO l_str1
         LET l_faai.faai004 = l_faai004_str2,l_str1
      ELSE
         LET l_faai.faai004 = l_faai004
      END IF 
      
      IF l_fagl2 THEN 
         LET l_str1 = ''
         LET l_sql = " SELECT lpad(",l_faai005_str3," +",i-1,",'",l_n1-1,"','0') FROM dual "
         PREPARE getnum_prepare2 FROM l_sql
         EXECUTE getnum_prepare2 INTO l_str2
         LET l_faai.faai005 = l_faai005_str2,l_str2
      ELSE
         LET l_faai.faai005 = l_faai005
      END IF 
      
      LET l_faai.faai007 = 1
      #INSERT INTO faai_t VALUES(l_faai.*) #mark by geza 20161122 #161111-00028#6
      #add by geza 20161122 #161111-00028#6(S)
      INSERT INTO faai_t
      (faaient,faai000,faai001,faai002,faai003,
       faaiseq,faai004,faai005,faai006,faai007,
       faai008,faai009,faai010,faai011,faai012,
       faai013,faai014,faai015,faai016,faai017,
       faai018,faai019,faai020,faai021,faai022,
       faai023) 
      VALUES(l_faai.faaient,l_faai.faai000,l_faai.faai001,l_faai.faai002,l_faai.faai003,
             l_faai.faaiseq,l_faai.faai004,l_faai.faai005,l_faai.faai006,l_faai.faai007,
             l_faai.faai008,l_faai.faai009,l_faai.faai010,l_faai.faai011,l_faai.faai012,
             l_faai.faai013,l_faai.faai014,l_faai.faai015,l_faai.faai016,l_faai.faai017,
             l_faai.faai018,l_faai.faai019,l_faai.faai020,l_faai.faai021,l_faai.faai022,
             l_faai.faai023) 
      #add by geza 20161122 #161111-00028#6(E)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO faai_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOR 
      END IF 
   END FOR 
   CALL afai120_s01_display()  
END FUNCTION

################################################################################
# Descriptions...:  显示单身
# Memo...........:
# Usage..........: CALL afai120_s01_display()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/08 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afai120_s01_display()
   CALL g_faai_d_1.clear()   
   LET g_sql = "SELECT  UNIQUE faai000,faai001,faai002,faai003,faaiseq,faai004,faai012,faai013,faai005,faai006,faai007,faai008, 
                               faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022, 
                               faai023  FROM faai_t",   
               " INNER JOIN faak_t ON faak000 = faai000 ",
               " AND faak001 = faai001 ",
               " AND faak003 = faai002 ",
               " AND faak004 = faai003 ",
               " WHERE faaient=? AND faai000=? AND faai001=? AND faai002=? AND faai003=?"
   LET g_sql = cl_sql_add_mask(g_sql)
   LET g_sql = g_sql, " ORDER BY faai_t.faaiseq"
   LET g_sql = cl_sql_add_mask(g_sql)            
   PREPARE afai120_pb_1 FROM g_sql
   DECLARE b_fill_cs_1 CURSOR FOR afai120_pb_1
   LET g_cnt = l_ac
   LET l_ac = 1
   OPEN b_fill_cs_1 USING g_enterprise,g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004                           
   FOREACH b_fill_cs_1 INTO g_faai_d_1[l_ac].faai000,g_faai_d_1[l_ac].faai001,g_faai_d_1[l_ac].faai002,g_faai_d_1[l_ac].faai003,
       g_faai_d_1[l_ac].faaiseq,g_faai_d_1[l_ac].faai004,g_faai_d_1[l_ac].faai012,g_faai_d_1[l_ac].faai013, 
       g_faai_d_1[l_ac].faai005,g_faai_d_1[l_ac].faai006,g_faai_d_1[l_ac].faai007,g_faai_d_1[l_ac].faai008, 
       g_faai_d_1[l_ac].faai010,g_faai_d_1[l_ac].faai009,g_faai_d_1[l_ac].faai014,g_faai_d_1[l_ac].faai015, 
       g_faai_d_1[l_ac].faai016,g_faai_d_1[l_ac].faai017,g_faai_d_1[l_ac].faai018,g_faai_d_1[l_ac].faai019, 
       g_faai_d_1[l_ac].faai020,g_faai_d_1[l_ac].faai021,g_faai_d_1[l_ac].faai022,g_faai_d_1[l_ac].faai023 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_faai_d_1.deleteElement(g_faai_d_1.getLength())
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afai120_pb_1
END FUNCTION

################################################################################
# Descriptions...: 标签明细
# Memo...........:
# Usage..........: CALL afai120_s01()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/08 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afai120_s01()
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   DEFINE  l_faai007_sum         LIKE faai_t.faai007
   DEFINE  l_year                STRING
   DEFINE  l_month               STRING
   DEFINE  l_str                 STRING
   DEFINE  l_faak000             LIKE faak_t.faak000
   DEFINE  l_ooef017             LIKE ooef_t.ooef017
   DEFINE  l_ooef017_t           LIKE ooef_t.ooef017
   DEFINE  l_glaa001             LIKE glaa_t.glaa001
   DEFINE  l_glaa001_t           LIKE glaa_t.glaa001
   DEFINE  l_glaald              LIKE glaa_t.glaald
   DEFINE  l_ooef204             LIKE ooef_t.ooef204
   DEFINE  l_ooag004             LIKE ooag_t.ooag004
   DEFINE  l_num1                LIKE type_t.num5
   DEFINE  l_num2                LIKE type_t.num5
   DEFINE  l_str1                STRING
   DEFINE  l_str2                STRING
   DEFINE  l_cnt1                LIKE type_t.num5  
   DEFINE  l_ooef003             LIKE ooef_t.ooef003
  
  
   IF g_faak_m.faak000 IS NULL
   OR g_faak_m.faak001 IS NULL
   OR g_faak_m.faak003 IS NULL
   OR g_faak_m.faak004 IS NULL THEN
      RETURN 
   END IF 
   IF g_faak_m.faakstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00284" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF 
   LET g_action_choice = ""
   LET g_forupd_sql = "SELECT faai000,faai001,faai002,faai003,faaiseq,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai010, 
       faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023 FROM  
       faai_t WHERE faaient=? AND faai000=? AND faai001=? AND faai002=? AND faai003=? AND faaiseq=?  
       FOR UPDATE"
   
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              
   DECLARE afai120_bcl_1 CURSOR FROM g_forupd_sql
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT ARRAY g_faai_d_1 FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         BEFORE INPUT
            #如果单身没有资料提示是否自动产生
            CALL afai120_faai_ins('2')
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_faai_d_1.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afai120_s01_display()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_rec_b = g_faai_d_1.getLength()
         
         BEFORE ROW
            #add-point:modify段before row2

            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afai120_cl USING g_enterprise,g_faak_m.faakld,g_faak_m.faak000,g_faak_m.faak001,
                                  g_faak_m.faak003,g_faak_m.faak004
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afai120_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE afai120_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_faai_d_1.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_faai_d_1[l_ac].faaiseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_faai_d_1_t.* = g_faai_d_1[l_ac].*  
               LET g_faai_d_1_o.* = g_faai_d_1[l_ac].* 
               IF NOT afai120_lock_b_1("faai_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afai120_bcl_1 INTO g_faai_d_1[l_ac].faai000,g_faai_d_1[l_ac].faai001,g_faai_d_1[l_ac].faai002,g_faai_d_1[l_ac].faai003,
                      g_faai_d_1[l_ac].faaiseq,g_faai_d_1[l_ac].faai004,g_faai_d_1[l_ac].faai012, 
                      g_faai_d_1[l_ac].faai013,g_faai_d_1[l_ac].faai005,g_faai_d_1[l_ac].faai006,g_faai_d_1[l_ac].faai007, 
                      g_faai_d_1[l_ac].faai008,g_faai_d_1[l_ac].faai010,g_faai_d_1[l_ac].faai009,g_faai_d_1[l_ac].faai014, 
                      g_faai_d_1[l_ac].faai015,g_faai_d_1[l_ac].faai016,g_faai_d_1[l_ac].faai017,g_faai_d_1[l_ac].faai018, 
                      g_faai_d_1[l_ac].faai019,g_faai_d_1[l_ac].faai020,g_faai_d_1[l_ac].faai021,g_faai_d_1[l_ac].faai022, 
                      g_faai_d_1[l_ac].faai023
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_faai_d_1_t.faaiseq 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faai_d_1[l_ac].* TO NULL 
            INITIALIZE g_faai_d_1_t.* TO NULL 
            INITIALIZE g_faai_d_1_o.* TO NULL 
            LET g_faai_d_1_t.* = g_faai_d_1[l_ac].*     #新輸入資料
            LET g_faai_d_1_o.* = g_faai_d_1[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faai_d_1[li_reproduce_target].* = g_faai_d_1[li_reproduce].*
 
               LET g_faai_d_1[li_reproduce_target].faaiseq = NULL
 
            END IF
            
            #add-point:modify段before insert
            IF l_cmd = 'a' THEN 
               IF cl_null(g_faai_d_1[g_detail_idx].faaiseq) THEN 
                  SELECT MAX(faaiseq) INTO g_faai_d_1[g_detail_idx].faaiseq
                    FROM faai_t
                   WHERE faaient = g_enterprise
                     AND faai001 = g_faak_m.faak001
                     AND faai002 = g_faak_m.faak003
                     AND faai003 = g_faak_m.faak004
                     
                  IF cl_null(g_faai_d_1[g_detail_idx].faaiseq) THEN 
                     LET g_faai_d_1[g_detail_idx].faaiseq = 1
                  ELSE
                     LET g_faai_d_1[g_detail_idx].faaiseq = g_faai_d_1[g_detail_idx].faaiseq + 1
                  END IF
               END IF
            END IF
            LET g_faai_d_1[l_ac].faai012 = g_faak_m.faak012
            LET g_faai_d_1[l_ac].faai013 = g_faak_m.faak013
            LET g_faai_d_1[l_ac].faai006 = g_faak_m.faak017
            LET g_faai_d_1[l_ac].faai007 = 0
            LET g_faai_d_1[l_ac].faai008 = 0
            LET g_faai_d_1[l_ac].faai014 = g_today
            LET g_faai_d_1[l_ac].faai015 = g_faak_m.faak025
            LET g_faai_d_1[l_ac].faai016 = g_faak_m.faak026
            LET g_faai_d_1[l_ac].faai017 = g_faak_m.faak027
            LET g_faai_d_1[l_ac].faai018 = g_faak_m.faak028
            LET g_faai_d_1[l_ac].faai019 = g_faak_m.faak029
            LET g_faai_d_1[l_ac].faai020 = g_faak_m.faak030
            LET g_faai_d_1[l_ac].faai021 = g_faak_m.faak031
            LET g_faai_d_1[l_ac].faai022 = g_faak_m.faak032
            LET g_faai_d_1[l_ac].faai009 = g_faak_m.faak009
            LET g_faai_d_1[l_ac].faai010 = g_faak_m.faak010
            LET g_faai_d_1[l_ac].faai014 = g_faak_m.faak014
            LET g_faai_d_1[l_ac].faai023 = g_faak_m.faak015
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM faai_t 
             WHERE faaient = g_enterprise AND faai000 = g_faak_m.faak000
               AND faai001 = g_faak_m.faak001
               AND faai002 = g_faak_m.faak003
               AND faai003 = g_faak_m.faak004
 
               AND faaiseq = g_faai_d_1[l_ac].faaiseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faak_m.faak000
               LET gs_keys[2] = g_faak_m.faak001
               LET gs_keys[3] = g_faak_m.faak003
               LET gs_keys[4] = g_faak_m.faak004
               LET gs_keys[5] = g_faai_d_1[g_detail_idx].faaiseq
               CALL afai120_insert_b('faai_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_faai_d_1[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faai_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               DELETE FROM faai_t
                WHERE faaient = g_enterprise AND faai000 = g_faak_m.faak000 AND
                                          faai001 = g_faak_m.faak001 AND
                                          faai002 = g_faak_m.faak003 AND
                                          faai003 = g_faak_m.faak004 AND
                      faaiseq = g_faai_d_1_t.faaiseq
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "faai_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE afai120_bcl_1
            END IF 
              
         AFTER DELETE 
            IF l_cmd = 'd' THEN 
               #add-point:單身刪除後(=d)

               #end add-point
            ELSE
               #add-point:單身刪除後(<>d)
            
               #end add-point

            END IF
            #如果是最後一筆
            IF l_ac = (g_faai_d_1.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD faaiseq
            #add-point:BEFORE FIELD faaiseq
            IF cl_null(g_faai_d_1[g_detail_idx].faaiseq) THEN 
               SELECT MAX(faaiseq) INTO g_faai_d_1[g_detail_idx].faaiseq
                 FROM faai_t
                WHERE faaient = g_enterprise
                  AND faai001 = g_faak_m.faak001
                  AND faai002 = g_faak_m.faak002
                  AND faai003 = g_faak_m.faak003
                  
               IF cl_null(g_faai_d_1[g_detail_idx].faaiseq) THEN 
                  LET g_faai_d_1[g_detail_idx].faaiseq = 1
               ELSE
                  LET g_faai_d_1[g_detail_idx].faaiseq = g_faai_d_1[g_detail_idx].faaiseq + 1
               END IF
            END IF
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faaiseq
            
            #add-point:AFTER FIELD faaiseq
                        #此段落由子樣板a05產生
            IF g_faak_m.faak001 IS NOT NULL AND g_faak_m.faak003 IS NOT NULL AND g_faak_m.faak004 IS NOT NULL AND g_faai_d_1[g_detail_idx].faaiseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faak_m.faak001 != g_faak001_t OR g_faak_m.faak003 != g_faak003_t OR g_faak_m.faak004 != g_faak004_t OR g_faai_d_1[g_detail_idx].faaiseq != g_faai_d_1_t.faaiseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faai_t WHERE "||"faaient = '" ||g_enterprise|| "' AND "|| "faai001 = '"||g_faak_m.faak001 ||"' AND "|| "faai002 = '"||g_faak_m.faak003 ||"' AND "|| "faai003 = '"||g_faak_m.faak004 ||"' AND "|| "faaiseq = '"||g_faai_d_1[g_detail_idx].faaiseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai007
            #應用 a15 樣板自動產生(Version:1)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faai_d_1[l_ac].faai007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faai007
            END IF
 
 
            #add-point:AFTER FIELD faai007
            IF NOT cl_null(g_faai_d_1[l_ac].faai007) THEN 
               LET l_faai007_sum = 0
               SELECT SUM(faai007) INTO l_faai007_sum
                 FROM faai_t
                WHERE faaient = g_enterprise
                  AND faai001 = g_faak_m.faak001
                  AND faai002 = g_faak_m.faak003
                  AND faai003 = g_faak_m.faak004
               
               IF (l_cmd = 'a' AND l_faai007_sum + g_faai_d_1[l_ac].faai007 > g_faak_m.faak018) 
               OR (l_cmd = 'u' AND l_faai007_sum + g_faai_d_1[l_ac].faai007 - g_faai_d_1_t.faai007> g_faak_m.faak018) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00019'
                  LET g_errparam.extend = g_faai_d_1[l_ac].faai007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faai_d_1[l_ac].faai007 = g_faai_d_1_t.faai007
                  NEXT FIELD faai007
               
               END IF
            END IF 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai010
            
            #add-point:AFTER FIELD faai010
                        IF NOT cl_null(g_faai_d_1[l_ac].faai010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai010
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai009
            
            #add-point:AFTER FIELD faai009
                        IF NOT cl_null(g_faai_d_1[l_ac].faai009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai009
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai015
            
            #add-point:AFTER FIELD faai015
                        IF NOT cl_null(g_faai_d_1[l_ac].faai015) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai015
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai016
            
            #add-point:AFTER FIELD faai016
                        IF NOT cl_null(g_faai_d_1[l_ac].faai016) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai016
               LET g_chkparam.arg2 = g_today
			      #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai016 = g_faai_d_1_t.faai016
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai017
            
            #add-point:AFTER FIELD faai017
                        IF NOT cl_null(g_faai_d_1[l_ac].faai017) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai017

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3900") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai017 = g_faai_d_1_t.faai017
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai018
            
            #add-point:AFTER FIELD faai018
                        IF NOT cl_null(g_faai_d_1[l_ac].faai018) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai018
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
               IF cl_chk_exist("v_ooef001") THEN
               
               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai018 = g_faai_d_1_t.faai018
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            IF NOT cl_null(g_faai_d_1[l_ac].faai018) THEN 
              SELECT ooef017 INTO g_faai_d_1[l_ac].faai022
                FROM ooef_t
               WHERE ooefent = g_enterprise
                 AND ooef001 = g_faai_d_1[l_ac].faai018
              DISPLAY g_faai_d_1[l_ac].faai022 TO s_detail1[l_ac].faai022
            END IF 

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai019
            
            #add-point:AFTER FIELD faai019
                        IF NOT cl_null(g_faai_d_1[l_ac].faai019) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai019
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai019 = g_faai_d_1_t.faai019
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai020
            
            #add-point:AFTER FIELD faai020
                        IF NOT cl_null(g_faai_d_1[l_ac].faai020) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai020
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai020 = g_faai_d_1_t.faai020
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai021
            IF NOT cl_null(g_faai_d_1[l_ac].faai021) THEN 
            
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai021
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT ooef204,ooef003 INTO l_ooef204,l_ooef003
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_faai_d_1[l_ac].faai021
                     
                  IF l_ooef204 = 'N' AND l_ooef003 = 'N' THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "afa-00325" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_faai_d_1[l_ac].faai021 = g_faai_d_1_t.faai021
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai021 = g_faai_d_1_t.faai021
                  NEXT FIELD CURRENT
               END IF
            END IF 

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD faai022
            
            #add-point:AFTER FIELD faai022
                        IF NOT cl_null(g_faai_d_1[l_ac].faai022) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faai_d_1[l_ac].faai022
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_faai_d_1[l_ac].faai022 = g_faai_d_1_t.faai022
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

         #Ctrlp:input.c.page1.faai010
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai010
            #add-point:ON ACTION controlp INFIELD faai010
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai010             #給予default值

            #給予arg

            CALL q_pmaa001_5()                                #呼叫開窗

            LET g_faai_d_1[l_ac].faai010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai010 TO faai010              #顯示到畫面上

            NEXT FIELD faai010                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.faai009
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai009
            #add-point:ON ACTION controlp INFIELD faai009
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai009             #給予default值

            #給予arg

            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_faai_d_1[l_ac].faai009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai009 TO faai009              #顯示到畫面上

            NEXT FIELD faai009                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.faai014
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai014
            #add-point:ON ACTION controlp INFIELD faai014
            
            #END add-point
 
         #Ctrlp:input.c.page1.faai015
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai015
            #add-point:ON ACTION controlp INFIELD faai015
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai015             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_faai_d_1[l_ac].faai015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai015 TO faai015              #顯示到畫面上

            NEXT FIELD faai015                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.faai016
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai016
            #add-point:ON ACTION controlp INFIELD faai016
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            CALL q_ooeg001_4()                                  #呼叫開窗

            LET g_faai_d_1[l_ac].faai016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai016 TO faai016              #顯示到畫面上

            NEXT FIELD faai016
 
         #Ctrlp:input.c.page1.faai017
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai017
            #add-point:ON ACTION controlp INFIELD faai017
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai017

            #給予arg
            LET g_qryparam.arg1 = "" 

            CALL q_oocq002()

            LET g_faai_d_1[l_ac].faai017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faai_d_1[l_ac].faai017 TO faai017              #顯示到畫面上

            NEXT FIELD faai017
 
         #Ctrlp:input.c.page1.faai018
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai018
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai018
            CALL q_ooef001()
            LET g_faai_d_1[l_ac].faai018 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai018 TO faai018
            NEXT FIELD faai018 
         #Ctrlp:input.c.page1.faai019
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai019
            #add-point:ON ACTION controlp INFIELD faai019
            #此段落由子樣板a07產生            
            #開窗i段
	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai019
            CALL q_ooag001()
            LET g_faai_d_1[l_ac].faai019 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai019 TO faai019   
            NEXT FIELD faai019
 
         #Ctrlp:input.c.page1.faai020
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai020
            #add-point:ON ACTION controlp INFIELD faai020
            #此段落由子樣板a07產生            
            #開窗i段
	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai020
            CALL q_ooef001()
            LET g_faai_d_1[l_ac].faai020 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai020 TO faai020
            NEXT FIELD faai020
 
         #Ctrlp:input.c.page1.faai021
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai021
            #add-point:ON ACTION controlp INFIELD faai021
            #此段落由子樣板a07產生            
            #開窗i段
	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai021
            LET g_qryparam.where = " ooef003 = 'Y' OR ooef204 = 'Y' "
            CALL q_ooef001()
            LET g_faai_d_1[l_ac].faai021 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai021 TO faai021
            NEXT FIELD faai021
 
         #Ctrlp:input.c.page1.faai022
         #應用 a03 樣板自動產生(Version:1)
         ON ACTION controlp INFIELD faai022
            #add-point:ON ACTION controlp INFIELD faai022
            #此段落由子樣板a07產生            
            #開窗i段
	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	    LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faai_d_1[l_ac].faai022 
            CALL q_ooef001()
            LET g_faai_d_1[l_ac].faai022 = g_qryparam.return1
            DISPLAY g_faai_d_1[l_ac].faai022 TO faai022
            NEXT FIELD faai022                         

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_faai_d_1[l_ac].* = g_faai_d_1_t.*
               CLOSE afai120_bcl_1
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_faai_d_1[l_ac].faaiseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_faai_d_1[l_ac].* = g_faai_d_1_t.*
            ELSE
      
               UPDATE faai_t SET (faai000,faai001,faai002,faai003,faaiseq,faai004,faai012,faai013,faai005, 
                   faai006,faai007,faai008,faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019, 
                   faai020,faai021,faai022,faai023) = (g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003, 
                   g_faak_m.faak004,g_faai_d_1[l_ac].faaiseq,g_faai_d_1[l_ac].faai004,g_faai_d_1[l_ac].faai012, 
                   g_faai_d_1[l_ac].faai013,g_faai_d_1[l_ac].faai005,g_faai_d_1[l_ac].faai006,g_faai_d_1[l_ac].faai007, 
                   g_faai_d_1[l_ac].faai008,g_faai_d_1[l_ac].faai010,g_faai_d_1[l_ac].faai009,g_faai_d_1[l_ac].faai014, 
                   g_faai_d_1[l_ac].faai015,g_faai_d_1[l_ac].faai016,g_faai_d_1[l_ac].faai017,g_faai_d_1[l_ac].faai018, 
                   g_faai_d_1[l_ac].faai019,g_faai_d_1[l_ac].faai020,g_faai_d_1[l_ac].faai021,g_faai_d_1[l_ac].faai022, 
                   g_faai_d_1[l_ac].faai023)
                WHERE faaient = g_enterprise AND faai000 = g_faak_m.faak000 
                  AND faai001 = g_faak_m.faak001 
                  AND faai002 = g_faak_m.faak003 
                  AND faai003 = g_faak_m.faak004 
 
                  AND faaiseq = g_faai_d_1_t.faaiseq #項次   
 
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faai_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_faai_d_1[l_ac].* = g_faai_d_1_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faai_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_faai_d_1[l_ac].* = g_faai_d_1_t.*  
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faak_m.faak000
               LET gs_keys_bak[1] = g_faak000_t
               LET gs_keys[2] = g_faak_m.faak001
               LET gs_keys_bak[2] = g_faak001_t
               LET gs_keys[3] = g_faak_m.faak003
               LET gs_keys_bak[3] = g_faak003_t
               LET gs_keys[4] = g_faak_m.faak004
               LET gs_keys_bak[4] = g_faak004_t
               LET gs_keys[5] = g_faai_d_1[g_detail_idx].faaiseq
               LET gs_keys_bak[5] = g_faai_d_1_t.faaiseq
               CALL afai120_update_b('faai_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_faak_m),util.JSON.stringify(g_faai_d_1_t)
               LET g_log2 = util.JSON.stringify(g_faak_m),util.JSON.stringify(g_faai_d_1[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
 
            END IF
            
         AFTER ROW
            CALL afai120_unlock_b("faai_t","'1'")
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT
            LET l_faai007_sum = 0
            SELECT SUM(faai007) INTO l_faai007_sum
              FROM faai_t
             WHERE faaient = g_enterprise
               AND faai001 = g_faak_m.faak001
               AND faai002 = g_faak_m.faak003
               AND faai003 = g_faak_m.faak004       
            IF l_faai007_sum > g_faak_m.faak018 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00019'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD faai007
            END IF
            IF l_faai007_sum < g_faak_m.faak018 THEN
               IF NOT cl_ask_confirm('afa-00282') THEN 
                  NEXT FIELD faai007
               END IF 
            END IF 
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_faai_d_1.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_faai_d_1.getLength()+1
            
 
      END INPUT

    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG

   CALL afai120_s01_display()
END FUNCTION

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
PRIVATE FUNCTION afai120_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num5
   
   LET g_update = TRUE  
   
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN

      INSERT INTO faai_t
                  (faaient,
                   faai000,faai001,faai002,faai003,
                   faaiseq
                   ,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_faai_d_1[g_detail_idx].faai004,g_faai_d_1[g_detail_idx].faai012,g_faai_d_1[g_detail_idx].faai013, 
                       g_faai_d_1[g_detail_idx].faai005,g_faai_d_1[g_detail_idx].faai006,g_faai_d_1[g_detail_idx].faai007, 
                       g_faai_d_1[g_detail_idx].faai008,g_faai_d_1[g_detail_idx].faai010,g_faai_d_1[g_detail_idx].faai009, 
                       g_faai_d_1[g_detail_idx].faai014,g_faai_d_1[g_detail_idx].faai015,g_faai_d_1[g_detail_idx].faai016, 
                       g_faai_d_1[g_detail_idx].faai017,g_faai_d_1[g_detail_idx].faai018,g_faai_d_1[g_detail_idx].faai019, 
                       g_faai_d_1[g_detail_idx].faai020,g_faai_d_1[g_detail_idx].faai021,g_faai_d_1[g_detail_idx].faai022, 
                       g_faai_d_1[g_detail_idx].faai023)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faai_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_faai_d_1.insertElement(li_idx) 
      END IF 
 
   END IF
END FUNCTION

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
PRIVATE FUNCTION afai120_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "faai_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE faai_t 
         SET (faai000,faai001,faai002,faai003,
              faaiseq
              ,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_faai_d_1[g_detail_idx].faai004,g_faai_d_1[g_detail_idx].faai012,g_faai_d_1[g_detail_idx].faai013, 
                  g_faai_d_1[g_detail_idx].faai005,g_faai_d_1[g_detail_idx].faai006,g_faai_d_1[g_detail_idx].faai007, 
                  g_faai_d_1[g_detail_idx].faai008,g_faai_d_1[g_detail_idx].faai010,g_faai_d_1[g_detail_idx].faai009, 
                  g_faai_d_1[g_detail_idx].faai014,g_faai_d_1[g_detail_idx].faai015,g_faai_d_1[g_detail_idx].faai016, 
                  g_faai_d_1[g_detail_idx].faai017,g_faai_d_1[g_detail_idx].faai018,g_faai_d_1[g_detail_idx].faai019, 
                  g_faai_d_1[g_detail_idx].faai020,g_faai_d_1[g_detail_idx].faai021,g_faai_d_1[g_detail_idx].faai022, 
                  g_faai_d_1[g_detail_idx].faai023) 
         WHERE faaient = g_enterprise AND faai000 = ps_keys_bak[1] AND faai001 = ps_keys_bak[2] AND faai002 = ps_keys_bak[3] AND faai003 = ps_keys_bak[4] AND faaiseq = ps_keys_bak[5]

      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faai_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faai_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
   END IF
END FUNCTION

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
PRIVATE FUNCTION afai120_delate_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num5
   
   
   LET g_update = TRUE  

   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
 
      DELETE FROM faai_t
       WHERE faaient = g_enterprise AND
         faai000 = ps_keys_bak[1] AND faai001 = ps_keys_bak[2] AND faai002 = ps_keys_bak[3] AND faai003 = ps_keys_bak[4] AND faaiseq = ps_keys_bak[5]

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
   END IF
END FUNCTION

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
PRIVATE FUNCTION afai120_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afai120_bcl_1
   END IF
END FUNCTION

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
PRIVATE FUNCTION afai120_ui_dialog_1()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path   STRING
   #畫面開啟 (identifier)
   OPEN WINDOW w_afai100_s01 WITH FORM cl_ap_formpath("afa","afai100_s01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   CALL cl_set_combo_scc('faai023','9914') 
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   
   LET g_qryparam.state = "i"
   CALL afai120_s01_display()
   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET lb_first = TRUE
   WHILE TRUE 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_faai_d_1 TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL afai120_idx_chk_1()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               

            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afai120_idx_chk_1()
               
         END DISPLAY
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #筆數顯示
            LET g_current_page = 1

         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION afai100_02
            LET g_action_choice="afai100_02"
            IF cl_auth_chk_act("afai100_02") THEN
               CALL afai120_faai_del()
               CALL afai120_idx_chk_1()
            END IF
 
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afai120_s01()
               
            END IF
            
         #應用 a43 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afai120_s01()
               CALL afai120_idx_chk_1()
            END IF

         ON ACTION afai100_01
            LET g_action_choice="afai100_01"
            IF cl_auth_chk_act("afai100_01") THEN
               CALL afai120_faai_ins('1')
               CALL afai120_idx_chk_1()
            END IF

         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
            
      END DIALOG
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
    
   END WHILE
   CALL cl_set_act_visible("accept,cancel", TRUE)
   #畫面關閉
   CLOSE WINDOW w_afai100_s01  
   LET g_action_choice = "afai120_01" 
END FUNCTION

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
PRIVATE FUNCTION afai120_lock_b_1(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING

   LET ls_group = "faai_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afai120_bcl_1 USING g_enterprise,
                               g_faak_m.faak000,g_faak_m.faak001,g_faak_m.faak003,g_faak_m.faak004, 
                               g_faai_d_1[g_detail_idx].faaiseq     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afai120_bcl_1" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

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
PRIVATE FUNCTION afai120_idx_chk_1()

   LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
   IF g_detail_idx > g_faai_d_1.getLength() THEN
      LET g_detail_idx = g_faai_d_1.getLength()
   END IF
   IF g_detail_idx = 0 AND g_faai_d_1.getLength() <> 0 THEN
      LET g_detail_idx = 1
   END IF
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_faai_d_1.getLength() TO FORMONLY.cnt
   
END FUNCTION

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
PRIVATE FUNCTION afai120_faai_del()
   IF g_faak_m.faak000 IS NULL
   OR g_faak_m.faak001 IS NULL
   OR g_faak_m.faak003 IS NULL
   OR g_faak_m.faak004 IS NULL THEN
      RETURN 
   END IF 
   IF g_faak_m.faakstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00284" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF 
   IF NOT cl_ask_confirm('afa-00285') THEN 
      RETURN 
   END IF 
   DELETE FROM faai_t 
    WHERE faaient = g_enterprise
      AND faai000 = g_faak_m.faak000
      AND faai001 = g_faak_m.faak001
      AND faai002 = g_faak_m.faak003
      AND faai003 = g_faak_m.faak004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE faai_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL g_faai_d_1.clear() 
      CALL afai120_s01_display() 
   END IF
END FUNCTION

 
{</section>}
 
