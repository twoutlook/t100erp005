#該程式未解開Section, 採用最新樣板產出!
{<section id="aimi105.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2016-10-27 14:51:13), PR版次:0021(2017-02-21 09:48:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000432
#+ Filename...: aimi105
#+ Description: 集團預設料件生管分群資料維護作業
#+ Creator....: 02298(2013-07-22 17:21:29)
#+ Modifier...: 05423 -SD/PR- 08993
 
{</section>}
 
{<section id="aimi105.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#20  2016/03/30 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160623-00014#1   2016/06/27 by 07024    為應應行業別，修改g_prog。
#                                                     原：g_prog='程式代碼'→改成：g_prog MATCHES '程式代碼*' 
#160705-00042#9   2016/07/13 By sakura   #160623-00014#1,g_prog MATCHES '程式代碼*'→g_prog MATCHES '程式代碼'
#160523-00031#5   2016/08/02 By zhujing  將主畫面上的所有欄位放到瀏覽畫面上
#160811-00001#1   2016/08/22 By 01258    aimi105开窗需开全部，不需匹配据点
#160913-00055#1   2016/09/18 By lixiang  供应商栏位开窗调整为q_pmaa001，去掉手动加的限定条件
#161013-00017#5   2016/10/24 By zhujing  可以直接在aimi105增加新的分群代號，不用先在aimi005增加
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
PRIVATE TYPE type_g_imcf_m RECORD
       imcfsite LIKE imcf_t.imcfsite, 
   imcf011 LIKE imcf_t.imcf011, 
   oocql004 LIKE oocql_t.oocql004, 
   oocql005 LIKE oocql_t.oocql005, 
   imcf012 LIKE imcf_t.imcf012, 
   imcf012_desc LIKE type_t.chr80, 
   imcfstus LIKE imcf_t.imcfstus, 
   imcfownid LIKE imcf_t.imcfownid, 
   imcfownid_desc LIKE type_t.chr80, 
   imcfowndp LIKE imcf_t.imcfowndp, 
   imcfowndp_desc LIKE type_t.chr80, 
   imcfcrtid LIKE imcf_t.imcfcrtid, 
   imcfcrtid_desc LIKE type_t.chr80, 
   imcfcrtdp LIKE imcf_t.imcfcrtdp, 
   imcfcrtdp_desc LIKE type_t.chr80, 
   imcfcrtdt LIKE imcf_t.imcfcrtdt, 
   imcfmodid LIKE imcf_t.imcfmodid, 
   imcfmodid_desc LIKE type_t.chr80, 
   imcfmoddt LIKE imcf_t.imcfmoddt, 
   imcf013 LIKE imcf_t.imcf013, 
   imcf014 LIKE imcf_t.imcf014, 
   imcf015 LIKE imcf_t.imcf015, 
   imcf023 LIKE imcf_t.imcf023, 
   imcf016 LIKE imcf_t.imcf016, 
   imcf016_desc LIKE type_t.chr80, 
   imcf017 LIKE imcf_t.imcf017, 
   imcf018 LIKE imcf_t.imcf018, 
   imcf019 LIKE imcf_t.imcf019, 
   imcf020 LIKE imcf_t.imcf020, 
   imcf021 LIKE imcf_t.imcf021, 
   imcf031 LIKE imcf_t.imcf031, 
   imcf031_desc LIKE type_t.chr80, 
   imcf037 LIKE imcf_t.imcf037, 
   imcf032 LIKE imcf_t.imcf032, 
   imcf032_desc LIKE type_t.chr80, 
   imcf033 LIKE imcf_t.imcf033, 
   imcf033_desc LIKE type_t.chr80, 
   imcf034 LIKE imcf_t.imcf034, 
   imcf034_desc LIKE type_t.chr80, 
   imcf035 LIKE imcf_t.imcf035, 
   imcf035_desc LIKE type_t.chr80, 
   imcf022 LIKE imcf_t.imcf022, 
   imcf036 LIKE imcf_t.imcf036, 
   imcf041 LIKE imcf_t.imcf041, 
   imcf041_desc LIKE type_t.chr80, 
   imcf042 LIKE imcf_t.imcf042, 
   imcf042_desc LIKE type_t.chr80, 
   imcf051 LIKE imcf_t.imcf051, 
   imcf052 LIKE imcf_t.imcf052, 
   imcf062 LIKE imcf_t.imcf062, 
   imcf064 LIKE imcf_t.imcf064, 
   imcf077 LIKE imcf_t.imcf077, 
   imcf078 LIKE imcf_t.imcf078, 
   imcf079 LIKE imcf_t.imcf079, 
   imcf080 LIKE imcf_t.imcf080, 
   imcf086 LIKE imcf_t.imcf086, 
   imcf071 LIKE imcf_t.imcf071, 
   imcf072 LIKE imcf_t.imcf072, 
   imcf073 LIKE imcf_t.imcf073, 
   imcf074 LIKE imcf_t.imcf074, 
   imcf075 LIKE imcf_t.imcf075, 
   imcf081 LIKE imcf_t.imcf081, 
   imcf081_desc LIKE type_t.chr80, 
   imcf082 LIKE imcf_t.imcf082, 
   imcf083 LIKE imcf_t.imcf083, 
   imcf084 LIKE imcf_t.imcf084, 
   imcf085 LIKE imcf_t.imcf085, 
   imcf091 LIKE imcf_t.imcf091, 
   imcf092 LIKE imcf_t.imcf092, 
   imcf101 LIKE imcf_t.imcf101, 
   imcf101_desc LIKE type_t.chr80, 
   imcf102 LIKE imcf_t.imcf102, 
   imcf102_desc LIKE type_t.chr80, 
   imcf103 LIKE imcf_t.imcf103, 
   imcf103_desc LIKE type_t.chr80, 
   imcf104 LIKE imcf_t.imcf104, 
   imcf104_desc LIKE type_t.chr80
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_imcfsite LIKE imcf_t.imcfsite,
      b_imcf011 LIKE imcf_t.imcf011,
   b_imcf011_desc LIKE type_t.chr80,
      b_imcf012 LIKE imcf_t.imcf012,
   b_imcf012_desc LIKE type_t.chr80,
      b_imcf013 LIKE imcf_t.imcf013,
      b_imcf014 LIKE imcf_t.imcf014,
      b_imcf015 LIKE imcf_t.imcf015,
      b_imcf023 LIKE imcf_t.imcf023,
      b_imcf016 LIKE imcf_t.imcf016,
   b_imcf016_desc LIKE type_t.chr80,
      b_imcf017 LIKE imcf_t.imcf017,
      b_imcf018 LIKE imcf_t.imcf018,
      b_imcf019 LIKE imcf_t.imcf019,
      b_imcf020 LIKE imcf_t.imcf020,
      b_imcf021 LIKE imcf_t.imcf021,
      b_imcf031 LIKE imcf_t.imcf031,
   b_imcf031_desc LIKE type_t.chr80,
      b_imcf037 LIKE imcf_t.imcf037,
      b_imcf032 LIKE imcf_t.imcf032,
   b_imcf032_desc LIKE type_t.chr80,
      b_imcf033 LIKE imcf_t.imcf033,
   b_imcf033_desc LIKE type_t.chr80,
      b_imcf034 LIKE imcf_t.imcf034,
   b_imcf034_desc LIKE type_t.chr80,
      b_imcf035 LIKE imcf_t.imcf035,
   b_imcf035_desc LIKE type_t.chr80,
      b_imcf022 LIKE imcf_t.imcf022,
      b_imcf036 LIKE imcf_t.imcf036,
      b_imcf041 LIKE imcf_t.imcf041,
   b_imcf041_desc LIKE type_t.chr80,
      b_imcf042 LIKE imcf_t.imcf042,
   b_imcf042_desc LIKE type_t.chr80,
      b_imcf051 LIKE imcf_t.imcf051,
      b_imcf052 LIKE imcf_t.imcf052,
      b_imcf062 LIKE imcf_t.imcf062,
      b_imcf064 LIKE imcf_t.imcf064,
      b_imcf077 LIKE imcf_t.imcf077,
      b_imcf078 LIKE imcf_t.imcf078,
      b_imcf079 LIKE imcf_t.imcf079,
      b_imcf080 LIKE imcf_t.imcf080,
      b_imcf071 LIKE imcf_t.imcf071,
      b_imcf072 LIKE imcf_t.imcf072,
      b_imcf073 LIKE imcf_t.imcf073,
      b_imcf074 LIKE imcf_t.imcf074,
      b_imcf075 LIKE imcf_t.imcf075,
      b_imcf081 LIKE imcf_t.imcf081,
   b_imcf081_desc LIKE type_t.chr80,
      b_imcf082 LIKE imcf_t.imcf082,
      b_imcf083 LIKE imcf_t.imcf083,
      b_imcf084 LIKE imcf_t.imcf084,
      b_imcf085 LIKE imcf_t.imcf085,
      b_imcf091 LIKE imcf_t.imcf091,
      b_imcf092 LIKE imcf_t.imcf092,
      b_imcf101 LIKE imcf_t.imcf101,
   b_imcf101_desc LIKE type_t.chr80,
      b_imcf102 LIKE imcf_t.imcf102,
   b_imcf102_desc LIKE type_t.chr80,
      b_imcf103 LIKE imcf_t.imcf103,
   b_imcf103_desc LIKE type_t.chr80,
      b_imcf104 LIKE imcf_t.imcf104,
   b_imcf104_desc LIKE type_t.chr80
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_flag                LIKE type_t.num5     #标记部门/厂商,1:厂商，其他为部门
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imcf_m        type_g_imcf_m  #單頭變數宣告
DEFINE g_imcf_m_t      type_g_imcf_m  #單頭舊值宣告(系統還原用)
DEFINE g_imcf_m_o      type_g_imcf_m  #單頭舊值宣告(其他用途)
DEFINE g_imcf_m_mask_o type_g_imcf_m  #轉換遮罩前資料
DEFINE g_imcf_m_mask_n type_g_imcf_m  #轉換遮罩後資料
 
   DEFINE g_imcfsite_t LIKE imcf_t.imcfsite
DEFINE g_imcf011_t LIKE imcf_t.imcf011
 
   
 
   
DEFINE g_master_multi_table_t    RECORD
      oocql001 LIKE oocql_t.oocql001,
      oocql002 LIKE oocql_t.oocql002,
      oocql004 LIKE oocql_t.oocql004,
      oocql005 LIKE oocql_t.oocql005
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
DEFINE g_site_t              LIKE ooef_t.ooef001
#end add-point
 
{</section>}
 
{<section id="aimi105.main" >}
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
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imcfsite,imcf011,'','',imcf012,'',imcfstus,imcfownid,'',imcfowndp,'', 
       imcfcrtid,'',imcfcrtdp,'',imcfcrtdt,imcfmodid,'',imcfmoddt,imcf013,imcf014,imcf015,imcf023,imcf016, 
       '',imcf017,imcf018,imcf019,imcf020,imcf021,imcf031,'',imcf037,imcf032,'',imcf033,'',imcf034,'', 
       imcf035,'',imcf022,imcf036,imcf041,'',imcf042,'',imcf051,imcf052,imcf062,imcf064,imcf077,imcf078, 
       imcf079,imcf080,imcf086,imcf071,imcf072,imcf073,imcf074,imcf075,imcf081,'',imcf082,imcf083,imcf084, 
       imcf085,imcf091,imcf092,imcf101,'',imcf102,'',imcf103,'',imcf104,''", 
                      " FROM imcf_t",
                      " WHERE imcfent= ? AND imcfsite=? AND imcf011=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi105_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imcfsite,t0.imcf011,t0.imcf012,t0.imcfstus,t0.imcfownid,t0.imcfowndp, 
       t0.imcfcrtid,t0.imcfcrtdp,t0.imcfcrtdt,t0.imcfmodid,t0.imcfmoddt,t0.imcf013,t0.imcf014,t0.imcf015, 
       t0.imcf023,t0.imcf016,t0.imcf017,t0.imcf018,t0.imcf019,t0.imcf020,t0.imcf021,t0.imcf031,t0.imcf037, 
       t0.imcf032,t0.imcf033,t0.imcf034,t0.imcf035,t0.imcf022,t0.imcf036,t0.imcf041,t0.imcf042,t0.imcf051, 
       t0.imcf052,t0.imcf062,t0.imcf064,t0.imcf077,t0.imcf078,t0.imcf079,t0.imcf080,t0.imcf086,t0.imcf071, 
       t0.imcf072,t0.imcf073,t0.imcf074,t0.imcf075,t0.imcf081,t0.imcf082,t0.imcf083,t0.imcf084,t0.imcf085, 
       t0.imcf091,t0.imcf092,t0.imcf101,t0.imcf102,t0.imcf103,t0.imcf104,t1.ooag011 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.oocal003 ,t8.oobxl003 ,t9.imaal003 ,t10.ooefl003 ,t11.ooefl003 , 
       t12.oocal003",
               " FROM imcf_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.imcf012  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.imcfownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.imcfowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.imcfcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.imcfcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.imcfmodid  ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=t0.imcf016 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oobxl_t t8 ON t8.oobxlent="||g_enterprise||" AND t8.oobxl001=t0.imcf031 AND t8.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t9 ON t9.imaalent="||g_enterprise||" AND t9.imaal001=t0.imcf032 AND t9.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.imcf034 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.imcf035 AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t12 ON t12.oocalent="||g_enterprise||" AND t12.oocal001=t0.imcf081 AND t12.oocal002='"||g_dlang||"' ",
 
               " WHERE t0.imcfent = " ||g_enterprise|| " AND t0.imcfsite = ? AND t0.imcf011 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimi105_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimi105 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimi105_init()   
 
      #進入選單 Menu (="N")
      CALL aimi105_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimi105
      
   END IF 
   
   CLOSE aimi105_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimi105.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimi105_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('imcfstus','17','N,Y')
 
      CALL cl_set_combo_scc('imcf013','4001') 
   CALL cl_set_combo_scc('imcf014','4002') 
   CALL cl_set_combo_scc('imcf023','1101') 
   CALL cl_set_combo_scc('imcf019','2025') 
   CALL cl_set_combo_scc('imcf021','4003') 
   CALL cl_set_combo_scc('imcf084','2025') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   #營運據點（欄位被隱藏給初值）
   LET g_imcf_m.imcfsite =g_site
   #imcf031,利用營運據點到aooi120中抓取單據別參照表號
   SELECT ooef004 INTO g_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_site
   #160523-00031#5 add-S
   CALL cl_set_combo_scc_part('b_imcfstus','17','N,Y')
   CALL cl_set_combo_scc('b_imcf013','4001') 
   CALL cl_set_combo_scc('b_imcf014','4002') 
   CALL cl_set_combo_scc('b_imcf023','1101') 
   CALL cl_set_combo_scc('b_imcf019','2025') 
   CALL cl_set_combo_scc('b_imcf021','4003') 
   CALL cl_set_combo_scc('b_imcf084','2025') 
   #160523-00031#5 add-E
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aimi105_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aimi105.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimi105_ui_dialog() 
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
            CALL aimi105_insert()
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
         INITIALIZE g_imcf_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aimi105_init()
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
               CALL aimi105_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimi105_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #160623-00014#1-mod-(S)
#               IF g_prog = 'aimi105' THEN      
#                  CALL cl_set_act_visible("logistics", FALSE)
#               ELSE
#                  CALL cl_set_act_visible("logistics", TRUE)
#               END IF
#               IF g_prog MATCHES 'aimi105' THEN   #170217-00068#2 mark   
               IF g_prog MATCHES 'aimi105*' THEN   #170217-00068#2 mod
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #160623-00014#1-mod-(E)
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aimi105_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aimi105_set_act_visible()
               CALL aimi105_set_act_no_visible()
               IF NOT (g_imcf_m.imcfsite IS NULL
                 OR g_imcf_m.imcf011 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " imcfent = " ||g_enterprise|| " AND",
                                     " imcfsite = '", g_imcf_m.imcfsite, "' "
                                     ," AND imcf011 = '", g_imcf_m.imcf011, "' "
 
                  #填到對應位置
                  CALL aimi105_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aimi105_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimi105_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aimi105_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aimi105_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aimi105_fetch("L")  
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
                  CALL aimi105_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi105_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi105_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi105_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi105_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION firm
            LET g_action_choice="firm"
            IF cl_auth_chk_act("firm") THEN
               
               #add-point:ON ACTION firm name="menu2.firm"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi105_insert()
               #add-point:ON ACTION insert name="menu2.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION about_file
            LET g_action_choice="about_file"
            IF cl_auth_chk_act("about_file") THEN
               
               #add-point:ON ACTION about_file name="menu2.about_file"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION dept
            LET g_action_choice="dept"
            IF cl_auth_chk_act("dept") THEN
               
               #add-point:ON ACTION dept name="menu2.dept"
               
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
               CALL aimi105_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi105_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi105_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi105_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi105_set_pk_array()
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
                  CALL aimi105_fetch("")
 
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
                  CALL aimi105_browser_fill(g_wc,"")
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
                  CALL aimi105_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #160623-00014#1-mod-(S)
#               IF g_prog = 'aimi105' THEN      
#                  CALL cl_set_act_visible("logistics", FALSE)
#               ELSE
#                  CALL cl_set_act_visible("logistics", TRUE)
#               END IF     
#               IF g_prog MATCHES 'aimi105' THEN   #170217-00068#2 mark   
               IF g_prog MATCHES 'aimi105*' THEN   #170217-00068#2 mod
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #160623-00014#1-mod-(E)
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aimi105_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aimi105_set_act_visible()
               CALL aimi105_set_act_no_visible()
               IF NOT (g_imcf_m.imcfsite IS NULL
                 OR g_imcf_m.imcf011 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " imcfent = " ||g_enterprise|| " AND",
                                     " imcfsite = '", g_imcf_m.imcfsite, "' "
                                     ," AND imcf011 = '", g_imcf_m.imcf011, "' "
 
                  #填到對應位置
                  CALL aimi105_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aimi105_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aimi105_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimi105_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aimi105_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aimi105_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aimi105_fetch("L")  
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
                  CALL aimi105_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi105_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi105_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi105_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi105_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION firm
            LET g_action_choice="firm"
            IF cl_auth_chk_act("firm") THEN
               
               #add-point:ON ACTION firm name="menu.firm"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi105_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION about_file
            LET g_action_choice="about_file"
            IF cl_auth_chk_act("about_file") THEN
               
               #add-point:ON ACTION about_file name="menu.about_file"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION dept
            LET g_action_choice="dept"
            IF cl_auth_chk_act("dept") THEN
               
               #add-point:ON ACTION dept name="menu.dept"
               
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
               CALL aimi105_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi105_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi105_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi105_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi105_set_pk_array()
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
 
{<section id="aimi105.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aimi105_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "imcfsite,imcf011"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   LET p_wc = p_wc CLIPPED," AND imcfsite = '",g_site,"'"
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM imcf_t ",
               "  ",
               "  LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND '204' = oocql001 AND imcf011 = oocql002 AND oocql003 = '",g_dlang,"' ",
               " WHERE imcfent = " ||g_enterprise|| " AND ", 
               p_wc CLIPPED, cl_sql_add_filter("imcf_t")
                
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
      INITIALIZE g_imcf_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.imcfstus,t0.imcfsite,t0.imcf011,t0.imcf012,t0.imcf013,t0.imcf014,t0.imcf015, 
       t0.imcf023,t0.imcf016,t0.imcf017,t0.imcf018,t0.imcf019,t0.imcf020,t0.imcf021,t0.imcf031,t0.imcf037, 
       t0.imcf032,t0.imcf033,t0.imcf034,t0.imcf035,t0.imcf022,t0.imcf036,t0.imcf041,t0.imcf042,t0.imcf051, 
       t0.imcf052,t0.imcf062,t0.imcf064,t0.imcf077,t0.imcf078,t0.imcf079,t0.imcf080,t0.imcf071,t0.imcf072, 
       t0.imcf073,t0.imcf074,t0.imcf075,t0.imcf081,t0.imcf082,t0.imcf083,t0.imcf084,t0.imcf085,t0.imcf091, 
       t0.imcf092,t0.imcf101,t0.imcf102,t0.imcf103,t0.imcf104,t1.oocql004 ,t2.ooag011 ,t3.oocal003 , 
       t4.oobxl003 ,t5.imaal003 ,t6.ooefl003 ,t7.ooefl003 ,t8.inayl003 ,t9.inab003 ,t10.oocal003 ,t11.inayl003 , 
       t12.inab003 ,t13.inayl003 ,t14.inab003",
               " FROM imcf_t t0 ",
               "  ",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='204' AND t1.oocql002=t0.imcf011 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.imcf012  ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imcf016 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oobxl_t t4 ON t4.oobxlent="||g_enterprise||" AND t4.oobxl001=t0.imcf031 AND t4.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=t0.imcf032 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.imcf034 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.imcf035 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=t0.imcf041 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t9 ON t9.inabent="||g_enterprise||" AND t9.inabsite=t0.imcfsite AND t9.inab001=t0.imcf041 AND t9.inab002=t0.imcf042  ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=t0.imcf081 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t11 ON t11.inaylent="||g_enterprise||" AND t11.inayl001=t0.imcf101 AND t11.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t12 ON t12.inabent="||g_enterprise||" AND t12.inabsite=t0.imcfsite AND t12.inab001=t0.imcf101 AND t12.inab002=t0.imcf102  ",
               " LEFT JOIN inayl_t t13 ON t13.inaylent="||g_enterprise||" AND t13.inayl001=t0.imcf103 AND t13.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t14 ON t14.inabent="||g_enterprise||" AND t14.inabsite=t0.imcfsite AND t14.inab001=t0.imcf103 AND t14.inab002=t0.imcf104  ",
 
               " WHERE t0.imcfent = " ||g_enterprise|| " AND ", ls_wc, cl_sql_add_filter("imcf_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   LET g_sql = " SELECT t0.imcfstus,t0.imcfsite,t0.imcf011,t0.imcf012,t0.imcf013,t0.imcf014,t0.imcf015, 
       t0.imcf023,t0.imcf016,t0.imcf017,t0.imcf018,t0.imcf019,t0.imcf020,t0.imcf021,t0.imcf031,t0.imcf037, 
       t0.imcf032,t0.imcf033,t0.imcf034,t0.imcf035,t0.imcf022,t0.imcf036,t0.imcf041,t0.imcf042,t0.imcf051, 
       t0.imcf052,t0.imcf062,t0.imcf064,t0.imcf077,t0.imcf078,t0.imcf079,t0.imcf080,t0.imcf071,t0.imcf072, 
       t0.imcf073,t0.imcf074,t0.imcf075,t0.imcf081,t0.imcf082,t0.imcf083,t0.imcf084,t0.imcf085,t0.imcf091, 
       t0.imcf092,t0.imcf101,t0.imcf102,t0.imcf103,t0.imcf104,t1.oocql004 ,t2.ooag011 ,t3.oocal003 , 
       t4.oobxl003 ,t5.imaal003 ,t6.ooefl003 ,t7.ooefl003 ,t8.inayl003 ,t9.inab003 ,t10.oocal003 ,t11.inayl003 , 
       t12.inab003 ,t13.inayl003 ,t14.inab003",
               " FROM imcf_t t0 ",
               "  ",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='204' AND t1.oocql002=t0.imcf011 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.imcf012  ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=t0.imcf016 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oobxl_t t4 ON t4.oobxlent='"||g_enterprise||"' AND t4.oobxl001=t0.imcf031 AND t4.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent='"||g_enterprise||"' AND t5.imaal001=t0.imcf032 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t0.imcf034 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=t0.imcf035 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent='"||g_enterprise||"' AND t8.inayl001=t0.imcf041 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t9 ON t9.inabent='"||g_enterprise||"' AND t9.inabsite='",g_site_t,"' AND t9.inab001=t0.imcf041 AND t9.inab002=t0.imcf042  ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent='"||g_enterprise||"' AND t10.oocal001=t0.imcf081 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t11 ON t11.inaylent='"||g_enterprise||"' AND t11.inayl001=t0.imcf101 AND t11.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t12 ON t12.inabent='"||g_enterprise||"' AND t12.inabsite='",g_site_t,"' AND t12.inab001=t0.imcf101 AND t12.inab002=t0.imcf102  ",
               " LEFT JOIN inayl_t t13 ON t13.inaylent='"||g_enterprise||"' AND t13.inayl001=t0.imcf103 AND t13.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t14 ON t14.inabent='"||g_enterprise||"' AND t14.inabsite='",g_site_t,"' AND t14.inab001=t0.imcf103 AND t14.inab002=t0.imcf104  ",
 
               " WHERE t0.imcfent = '" ||g_enterprise|| "' AND ", ls_wc, cl_sql_add_filter("imcf_t")
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"imcf_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imcfsite,g_browser[g_cnt].b_imcf011, 
          g_browser[g_cnt].b_imcf012,g_browser[g_cnt].b_imcf013,g_browser[g_cnt].b_imcf014,g_browser[g_cnt].b_imcf015, 
          g_browser[g_cnt].b_imcf023,g_browser[g_cnt].b_imcf016,g_browser[g_cnt].b_imcf017,g_browser[g_cnt].b_imcf018, 
          g_browser[g_cnt].b_imcf019,g_browser[g_cnt].b_imcf020,g_browser[g_cnt].b_imcf021,g_browser[g_cnt].b_imcf031, 
          g_browser[g_cnt].b_imcf037,g_browser[g_cnt].b_imcf032,g_browser[g_cnt].b_imcf033,g_browser[g_cnt].b_imcf034, 
          g_browser[g_cnt].b_imcf035,g_browser[g_cnt].b_imcf022,g_browser[g_cnt].b_imcf036,g_browser[g_cnt].b_imcf041, 
          g_browser[g_cnt].b_imcf042,g_browser[g_cnt].b_imcf051,g_browser[g_cnt].b_imcf052,g_browser[g_cnt].b_imcf062, 
          g_browser[g_cnt].b_imcf064,g_browser[g_cnt].b_imcf077,g_browser[g_cnt].b_imcf078,g_browser[g_cnt].b_imcf079, 
          g_browser[g_cnt].b_imcf080,g_browser[g_cnt].b_imcf071,g_browser[g_cnt].b_imcf072,g_browser[g_cnt].b_imcf073, 
          g_browser[g_cnt].b_imcf074,g_browser[g_cnt].b_imcf075,g_browser[g_cnt].b_imcf081,g_browser[g_cnt].b_imcf082, 
          g_browser[g_cnt].b_imcf083,g_browser[g_cnt].b_imcf084,g_browser[g_cnt].b_imcf085,g_browser[g_cnt].b_imcf091, 
          g_browser[g_cnt].b_imcf092,g_browser[g_cnt].b_imcf101,g_browser[g_cnt].b_imcf102,g_browser[g_cnt].b_imcf103, 
          g_browser[g_cnt].b_imcf104,g_browser[g_cnt].b_imcf011_desc,g_browser[g_cnt].b_imcf012_desc, 
          g_browser[g_cnt].b_imcf016_desc,g_browser[g_cnt].b_imcf031_desc,g_browser[g_cnt].b_imcf032_desc, 
          g_browser[g_cnt].b_imcf034_desc,g_browser[g_cnt].b_imcf035_desc,g_browser[g_cnt].b_imcf041_desc, 
          g_browser[g_cnt].b_imcf042_desc,g_browser[g_cnt].b_imcf081_desc,g_browser[g_cnt].b_imcf101_desc, 
          g_browser[g_cnt].b_imcf102_desc,g_browser[g_cnt].b_imcf103_desc,g_browser[g_cnt].b_imcf104_desc 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         #160523-00031#5 add-S
         #制程编号
         IF NOT cl_null(g_browser[g_cnt].b_imcf033) THEN
            CALL aimi105_imcf033_desc(g_browser[g_cnt].b_imcf033) RETURNING g_browser[g_cnt].b_imcf033_desc
         END IF
         #160523-00031#5 add-E
         #end add-point
         
         #遮罩相關處理
         CALL aimi105_browser_mask()
         
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_imcfsite) THEN
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
 
{<section id="aimi105.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimi105_construct()
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
   INITIALIZE g_imcf_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON imcfsite,imcf011,oocql004,oocql005,imcf012,imcfstus,imcfownid,imcfowndp, 
          imcfcrtid,imcfcrtdp,imcfcrtdt,imcfmodid,imcfmoddt,imcf013,imcf014,imcf015,imcf023,imcf016, 
          imcf017,imcf018,imcf019,imcf020,imcf021,imcf031,imcf037,imcf032,imcf033,imcf034,imcf035,imcf022, 
          imcf036,imcf041,imcf042,imcf051,imcf052,imcf062,imcf064,imcf077,imcf078,imcf079,imcf080,imcf086, 
          imcf071,imcf072,imcf073,imcf074,imcf075,imcf081,imcf082,imcf083,imcf084,imcf085,imcf091,imcf092, 
          imcf101,imcf102,imcf103,imcf104
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imcfcrtdt>>----
         AFTER FIELD imcfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imcfmoddt>>----
         AFTER FIELD imcfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imcfcnfdt>>----
         
         #----<<imcfpstdt>>----
 
 
 
      
         #一般欄位
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfsite
            #add-point:BEFORE FIELD imcfsite name="construct.b.imcfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfsite
            
            #add-point:AFTER FIELD imcfsite name="construct.a.imcfsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfsite
            #add-point:ON ACTION controlp INFIELD imcfsite name="construct.c.imcfsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf011
            #add-point:ON ACTION controlp INFIELD imcf011 name="construct.c.imcf011"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 204          
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf011  #顯示到畫面上
            LET g_qryparam.arg1 = ''         
            NEXT FIELD imcf011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf011
            #add-point:BEFORE FIELD imcf011 name="construct.b.imcf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf011
            
            #add-point:AFTER FIELD imcf011 name="construct.a.imcf011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="construct.b.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="construct.a.oocql004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="construct.c.oocql004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="construct.b.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="construct.a.oocql005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="construct.c.oocql005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf012
            #add-point:ON ACTION controlp INFIELD imcf012 name="construct.c.imcf012"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN    #160811-00001
               CALL q_ooag001()       #160811-00001
            ELSE                      #160811-00001
               CALL q_ooag001_2()                           #呼叫開窗
            END IF                    #160811-00001                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf012  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD imcf012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf012
            #add-point:BEFORE FIELD imcf012 name="construct.b.imcf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf012
            
            #add-point:AFTER FIELD imcf012 name="construct.a.imcf012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfstus
            #add-point:BEFORE FIELD imcfstus name="construct.b.imcfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfstus
            
            #add-point:AFTER FIELD imcfstus name="construct.a.imcfstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfstus
            #add-point:ON ACTION controlp INFIELD imcfstus name="construct.c.imcfstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcfownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfownid
            #add-point:ON ACTION controlp INFIELD imcfownid name="construct.c.imcfownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcfownid  #顯示到畫面上

            NEXT FIELD imcfownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfownid
            #add-point:BEFORE FIELD imcfownid name="construct.b.imcfownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfownid
            
            #add-point:AFTER FIELD imcfownid name="construct.a.imcfownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcfowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfowndp
            #add-point:ON ACTION controlp INFIELD imcfowndp name="construct.c.imcfowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcfowndp  #顯示到畫面上

            NEXT FIELD imcfowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfowndp
            #add-point:BEFORE FIELD imcfowndp name="construct.b.imcfowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfowndp
            
            #add-point:AFTER FIELD imcfowndp name="construct.a.imcfowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcfcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfcrtid
            #add-point:ON ACTION controlp INFIELD imcfcrtid name="construct.c.imcfcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcfcrtid  #顯示到畫面上

            NEXT FIELD imcfcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfcrtid
            #add-point:BEFORE FIELD imcfcrtid name="construct.b.imcfcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfcrtid
            
            #add-point:AFTER FIELD imcfcrtid name="construct.a.imcfcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcfcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfcrtdp
            #add-point:ON ACTION controlp INFIELD imcfcrtdp name="construct.c.imcfcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcfcrtdp  #顯示到畫面上

            NEXT FIELD imcfcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfcrtdp
            #add-point:BEFORE FIELD imcfcrtdp name="construct.b.imcfcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfcrtdp
            
            #add-point:AFTER FIELD imcfcrtdp name="construct.a.imcfcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfcrtdt
            #add-point:BEFORE FIELD imcfcrtdt name="construct.b.imcfcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcfmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfmodid
            #add-point:ON ACTION controlp INFIELD imcfmodid name="construct.c.imcfmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcfmodid  #顯示到畫面上

            NEXT FIELD imcfmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfmodid
            #add-point:BEFORE FIELD imcfmodid name="construct.b.imcfmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfmodid
            
            #add-point:AFTER FIELD imcfmodid name="construct.a.imcfmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfmoddt
            #add-point:BEFORE FIELD imcfmoddt name="construct.b.imcfmoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf013
            #add-point:BEFORE FIELD imcf013 name="construct.b.imcf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf013
            
            #add-point:AFTER FIELD imcf013 name="construct.a.imcf013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf013
            #add-point:ON ACTION controlp INFIELD imcf013 name="construct.c.imcf013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf014
            #add-point:BEFORE FIELD imcf014 name="construct.b.imcf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf014
            
            #add-point:AFTER FIELD imcf014 name="construct.a.imcf014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf014
            #add-point:ON ACTION controlp INFIELD imcf014 name="construct.c.imcf014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf015
            #add-point:BEFORE FIELD imcf015 name="construct.b.imcf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf015
            
            #add-point:AFTER FIELD imcf015 name="construct.a.imcf015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf015
            #add-point:ON ACTION controlp INFIELD imcf015 name="construct.c.imcf015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf023
            #add-point:BEFORE FIELD imcf023 name="construct.b.imcf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf023
            
            #add-point:AFTER FIELD imcf023 name="construct.a.imcf023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf023
            #add-point:ON ACTION controlp INFIELD imcf023 name="construct.c.imcf023"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf016
            #add-point:ON ACTION controlp INFIELD imcf016 name="construct.c.imcf016"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf016  #顯示到畫面上

            NEXT FIELD imcf016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf016
            #add-point:BEFORE FIELD imcf016 name="construct.b.imcf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf016
            
            #add-point:AFTER FIELD imcf016 name="construct.a.imcf016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf017
            #add-point:BEFORE FIELD imcf017 name="construct.b.imcf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf017
            
            #add-point:AFTER FIELD imcf017 name="construct.a.imcf017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf017
            #add-point:ON ACTION controlp INFIELD imcf017 name="construct.c.imcf017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf018
            #add-point:BEFORE FIELD imcf018 name="construct.b.imcf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf018
            
            #add-point:AFTER FIELD imcf018 name="construct.a.imcf018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf018
            #add-point:ON ACTION controlp INFIELD imcf018 name="construct.c.imcf018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf019
            #add-point:BEFORE FIELD imcf019 name="construct.b.imcf019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf019
            
            #add-point:AFTER FIELD imcf019 name="construct.a.imcf019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf019
            #add-point:ON ACTION controlp INFIELD imcf019 name="construct.c.imcf019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf020
            #add-point:BEFORE FIELD imcf020 name="construct.b.imcf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf020
            
            #add-point:AFTER FIELD imcf020 name="construct.a.imcf020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf020
            #add-point:ON ACTION controlp INFIELD imcf020 name="construct.c.imcf020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf021
            #add-point:BEFORE FIELD imcf021 name="construct.b.imcf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf021
            
            #add-point:AFTER FIELD imcf021 name="construct.a.imcf021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf021
            #add-point:ON ACTION controlp INFIELD imcf021 name="construct.c.imcf021"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcf031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf031
            #add-point:ON ACTION controlp INFIELD imcf031 name="construct.c.imcf031"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #160711-00040#14 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#14 add(e)
            CALL q_ooba002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf031  #顯示到畫面上

            NEXT FIELD imcf031                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf031
            #add-point:BEFORE FIELD imcf031 name="construct.b.imcf031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf031
            
            #add-point:AFTER FIELD imcf031 name="construct.a.imcf031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf037
            #add-point:BEFORE FIELD imcf037 name="construct.b.imcf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf037
            
            #add-point:AFTER FIELD imcf037 name="construct.a.imcf037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf037
            #add-point:ON ACTION controlp INFIELD imcf037 name="construct.c.imcf037"
            #此段落由子樣板a08產生
            #開窗c段
			   #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c'
			   #LET g_qryparam.reqry = FALSE
            #CALL q_bmaa002()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO imcf037  #顯示到畫面上
            #
            #NEXT FIELD imcf037                     #返回原欄位


            #END add-point
 
 
         #Ctrlp:construct.c.imcf032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf032
            #add-point:ON ACTION controlp INFIELD imcf032 name="construct.c.imcf032"
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf032  #顯示到畫面上
            NEXT FIELD imcf032                    #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf032
            #add-point:BEFORE FIELD imcf032 name="construct.b.imcf032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf032
            
            #add-point:AFTER FIELD imcf032 name="construct.a.imcf032"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf033
            #add-point:BEFORE FIELD imcf033 name="construct.b.imcf033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf033
            
            #add-point:AFTER FIELD imcf033 name="construct.a.imcf033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf033
            #add-point:ON ACTION controlp INFIELD imcf033 name="construct.c.imcf033"
            #開窗c段
            #LET g_qryparam.reqry = FALSE
            #CALL q_ecba002()                          #呼叫開窗
            #DISPLAY g_qryparam.return1 TO imcf033  #顯示到畫面上
            #NEXT FIELD imcf033                    #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf034
            #add-point:BEFORE FIELD imcf034 name="construct.b.imcf034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf034
            
            #add-point:AFTER FIELD imcf034 name="construct.a.imcf034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf034
            #add-point:ON ACTION controlp INFIELD imcf034 name="construct.c.imcf034"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_1()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf034  #顯示到畫面上

            NEXT FIELD imcf034                     #返回原欄位


            #END add-point
 
 
         #Ctrlp:construct.c.imcf035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf035
            #add-point:ON ACTION controlp INFIELD imcf035 name="construct.c.imcf035"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooeg003 ='3' "
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf035  #顯示到畫面上
            LET g_qryparam.where = ''
            NEXT FIELD imcf035                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf035
            #add-point:BEFORE FIELD imcf035 name="construct.b.imcf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf035
            
            #add-point:AFTER FIELD imcf035 name="construct.a.imcf035"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf022
            #add-point:BEFORE FIELD imcf022 name="construct.b.imcf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf022
            
            #add-point:AFTER FIELD imcf022 name="construct.a.imcf022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf022
            #add-point:ON ACTION controlp INFIELD imcf022 name="construct.c.imcf022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf036
            #add-point:BEFORE FIELD imcf036 name="construct.b.imcf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf036
            
            #add-point:AFTER FIELD imcf036 name="construct.a.imcf036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf036
            #add-point:ON ACTION controlp INFIELD imcf036 name="construct.c.imcf036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcf041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf041
            #add-point:ON ACTION controlp INFIELD imcf041 name="construct.c.imcf041"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inaa001_4()
            LET g_qryparam.arg1 = ''
            DISPLAY g_qryparam.return1 TO imcf041  #顯示到畫面上

            NEXT FIELD imcf041                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf041
            #add-point:BEFORE FIELD imcf041 name="construct.b.imcf041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf041
            
            #add-point:AFTER FIELD imcf041 name="construct.a.imcf041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf042
            #add-point:ON ACTION controlp INFIELD imcf042 name="construct.c.imcf042"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inab002_8()
            LET g_qryparam.arg1 = ''
            DISPLAY g_qryparam.return1 TO imcf042  #顯示到畫面上
            LET g_qryparam.where =""
            NEXT FIELD imcf042                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf042
            #add-point:BEFORE FIELD imcf042 name="construct.b.imcf042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf042
            
            #add-point:AFTER FIELD imcf042 name="construct.a.imcf042"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf051
            #add-point:BEFORE FIELD imcf051 name="construct.b.imcf051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf051
            
            #add-point:AFTER FIELD imcf051 name="construct.a.imcf051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf051
            #add-point:ON ACTION controlp INFIELD imcf051 name="construct.c.imcf051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf052
            #add-point:BEFORE FIELD imcf052 name="construct.b.imcf052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf052
            
            #add-point:AFTER FIELD imcf052 name="construct.a.imcf052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf052
            #add-point:ON ACTION controlp INFIELD imcf052 name="construct.c.imcf052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf062
            #add-point:BEFORE FIELD imcf062 name="construct.b.imcf062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf062
            
            #add-point:AFTER FIELD imcf062 name="construct.a.imcf062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf062
            #add-point:ON ACTION controlp INFIELD imcf062 name="construct.c.imcf062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf064
            #add-point:BEFORE FIELD imcf064 name="construct.b.imcf064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf064
            
            #add-point:AFTER FIELD imcf064 name="construct.a.imcf064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf064
            #add-point:ON ACTION controlp INFIELD imcf064 name="construct.c.imcf064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf077
            #add-point:BEFORE FIELD imcf077 name="construct.b.imcf077"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf077
            
            #add-point:AFTER FIELD imcf077 name="construct.a.imcf077"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf077
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf077
            #add-point:ON ACTION controlp INFIELD imcf077 name="construct.c.imcf077"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf078
            #add-point:BEFORE FIELD imcf078 name="construct.b.imcf078"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf078
            
            #add-point:AFTER FIELD imcf078 name="construct.a.imcf078"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf078
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf078
            #add-point:ON ACTION controlp INFIELD imcf078 name="construct.c.imcf078"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf079
            #add-point:BEFORE FIELD imcf079 name="construct.b.imcf079"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf079
            
            #add-point:AFTER FIELD imcf079 name="construct.a.imcf079"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf079
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf079
            #add-point:ON ACTION controlp INFIELD imcf079 name="construct.c.imcf079"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf080
            #add-point:BEFORE FIELD imcf080 name="construct.b.imcf080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf080
            
            #add-point:AFTER FIELD imcf080 name="construct.a.imcf080"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf080
            #add-point:ON ACTION controlp INFIELD imcf080 name="construct.c.imcf080"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf086
            #add-point:BEFORE FIELD imcf086 name="construct.b.imcf086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf086
            
            #add-point:AFTER FIELD imcf086 name="construct.a.imcf086"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf086
            #add-point:ON ACTION controlp INFIELD imcf086 name="construct.c.imcf086"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf071
            #add-point:BEFORE FIELD imcf071 name="construct.b.imcf071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf071
            
            #add-point:AFTER FIELD imcf071 name="construct.a.imcf071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf071
            #add-point:ON ACTION controlp INFIELD imcf071 name="construct.c.imcf071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf072
            #add-point:BEFORE FIELD imcf072 name="construct.b.imcf072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf072
            
            #add-point:AFTER FIELD imcf072 name="construct.a.imcf072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf072
            #add-point:ON ACTION controlp INFIELD imcf072 name="construct.c.imcf072"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf073
            #add-point:BEFORE FIELD imcf073 name="construct.b.imcf073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf073
            
            #add-point:AFTER FIELD imcf073 name="construct.a.imcf073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf073
            #add-point:ON ACTION controlp INFIELD imcf073 name="construct.c.imcf073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf074
            #add-point:BEFORE FIELD imcf074 name="construct.b.imcf074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf074
            
            #add-point:AFTER FIELD imcf074 name="construct.a.imcf074"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf074
            #add-point:ON ACTION controlp INFIELD imcf074 name="construct.c.imcf074"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf075
            #add-point:BEFORE FIELD imcf075 name="construct.b.imcf075"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf075
            
            #add-point:AFTER FIELD imcf075 name="construct.a.imcf075"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf075
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf075
            #add-point:ON ACTION controlp INFIELD imcf075 name="construct.c.imcf075"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcf081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf081
            #add-point:ON ACTION controlp INFIELD imcf081 name="construct.c.imcf081"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf081  #顯示到畫面上

            NEXT FIELD imcf081                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf081
            #add-point:BEFORE FIELD imcf081 name="construct.b.imcf081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf081
            
            #add-point:AFTER FIELD imcf081 name="construct.a.imcf081"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf082
            #add-point:BEFORE FIELD imcf082 name="construct.b.imcf082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf082
            
            #add-point:AFTER FIELD imcf082 name="construct.a.imcf082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf082
            #add-point:ON ACTION controlp INFIELD imcf082 name="construct.c.imcf082"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf083
            #add-point:BEFORE FIELD imcf083 name="construct.b.imcf083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf083
            
            #add-point:AFTER FIELD imcf083 name="construct.a.imcf083"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf083
            #add-point:ON ACTION controlp INFIELD imcf083 name="construct.c.imcf083"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf084
            #add-point:BEFORE FIELD imcf084 name="construct.b.imcf084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf084
            
            #add-point:AFTER FIELD imcf084 name="construct.a.imcf084"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf084
            #add-point:ON ACTION controlp INFIELD imcf084 name="construct.c.imcf084"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf085
            #add-point:BEFORE FIELD imcf085 name="construct.b.imcf085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf085
            
            #add-point:AFTER FIELD imcf085 name="construct.a.imcf085"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf085
            #add-point:ON ACTION controlp INFIELD imcf085 name="construct.c.imcf085"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf091
            #add-point:BEFORE FIELD imcf091 name="construct.b.imcf091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf091
            
            #add-point:AFTER FIELD imcf091 name="construct.a.imcf091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf091
            #add-point:ON ACTION controlp INFIELD imcf091 name="construct.c.imcf091"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf092
            #add-point:BEFORE FIELD imcf092 name="construct.b.imcf092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf092
            
            #add-point:AFTER FIELD imcf092 name="construct.a.imcf092"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf092
            #add-point:ON ACTION controlp INFIELD imcf092 name="construct.c.imcf092"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcf101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf101
            #add-point:ON ACTION controlp INFIELD imcf101 name="construct.c.imcf101"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inaa001_4()
            LET g_qryparam.arg1 = ''                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf101  #顯示到畫面上

            NEXT FIELD imcf101                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf101
            #add-point:BEFORE FIELD imcf101 name="construct.b.imcf101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf101
            
            #add-point:AFTER FIELD imcf101 name="construct.a.imcf101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf102
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf102
            #add-point:ON ACTION controlp INFIELD imcf102 name="construct.c.imcf102"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inab002_8()
            LET g_qryparam.arg1 = ''                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf102  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imcf102                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf102
            #add-point:BEFORE FIELD imcf102 name="construct.b.imcf102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf102
            
            #add-point:AFTER FIELD imcf102 name="construct.a.imcf102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf103
            #add-point:ON ACTION controlp INFIELD imcf103 name="construct.c.imcf103"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inaa001_4()
            LET g_qryparam.arg1 = ''                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf103  #顯示到畫面上

            NEXT FIELD imcf103                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf103
            #add-point:BEFORE FIELD imcf103 name="construct.b.imcf103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf103
            
            #add-point:AFTER FIELD imcf103 name="construct.a.imcf103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcf104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf104
            #add-point:ON ACTION controlp INFIELD imcf104 name="construct.c.imcf104"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inab002_8()
            LET g_qryparam.arg1 = ''                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcf104  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imcf104                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf104
            #add-point:BEFORE FIELD imcf104 name="construct.b.imcf104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf104
            
            #add-point:AFTER FIELD imcf104 name="construct.a.imcf104"
            
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
 
{<section id="aimi105.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimi105_filter()
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
      CONSTRUCT g_wc_filter ON imcfsite,imcf011,imcf012,imcf013,imcf014,imcf015,imcf023,imcf016,imcf017, 
          imcf018,imcf019,imcf020,imcf021,imcf031,imcf037,imcf032,imcf033,imcf034,imcf035,imcf022,imcf036, 
          imcf041,imcf042,imcf051,imcf052,imcf062,imcf064,imcf077,imcf078,imcf079,imcf080,imcf071,imcf072, 
          imcf073,imcf074,imcf075,imcf081,imcf082,imcf083,imcf084,imcf085,imcf091,imcf092,imcf101,imcf102, 
          imcf103,imcf104
                          FROM s_browse[1].b_imcfsite,s_browse[1].b_imcf011,s_browse[1].b_imcf012,s_browse[1].b_imcf013, 
                              s_browse[1].b_imcf014,s_browse[1].b_imcf015,s_browse[1].b_imcf023,s_browse[1].b_imcf016, 
                              s_browse[1].b_imcf017,s_browse[1].b_imcf018,s_browse[1].b_imcf019,s_browse[1].b_imcf020, 
                              s_browse[1].b_imcf021,s_browse[1].b_imcf031,s_browse[1].b_imcf037,s_browse[1].b_imcf032, 
                              s_browse[1].b_imcf033,s_browse[1].b_imcf034,s_browse[1].b_imcf035,s_browse[1].b_imcf022, 
                              s_browse[1].b_imcf036,s_browse[1].b_imcf041,s_browse[1].b_imcf042,s_browse[1].b_imcf051, 
                              s_browse[1].b_imcf052,s_browse[1].b_imcf062,s_browse[1].b_imcf064,s_browse[1].b_imcf077, 
                              s_browse[1].b_imcf078,s_browse[1].b_imcf079,s_browse[1].b_imcf080,s_browse[1].b_imcf071, 
                              s_browse[1].b_imcf072,s_browse[1].b_imcf073,s_browse[1].b_imcf074,s_browse[1].b_imcf075, 
                              s_browse[1].b_imcf081,s_browse[1].b_imcf082,s_browse[1].b_imcf083,s_browse[1].b_imcf084, 
                              s_browse[1].b_imcf085,s_browse[1].b_imcf091,s_browse[1].b_imcf092,s_browse[1].b_imcf101, 
                              s_browse[1].b_imcf102,s_browse[1].b_imcf103,s_browse[1].b_imcf104
 
         BEFORE CONSTRUCT
               DISPLAY aimi105_filter_parser('imcfsite') TO s_browse[1].b_imcfsite
            DISPLAY aimi105_filter_parser('imcf011') TO s_browse[1].b_imcf011
            DISPLAY aimi105_filter_parser('imcf012') TO s_browse[1].b_imcf012
            DISPLAY aimi105_filter_parser('imcf013') TO s_browse[1].b_imcf013
            DISPLAY aimi105_filter_parser('imcf014') TO s_browse[1].b_imcf014
            DISPLAY aimi105_filter_parser('imcf015') TO s_browse[1].b_imcf015
            DISPLAY aimi105_filter_parser('imcf023') TO s_browse[1].b_imcf023
            DISPLAY aimi105_filter_parser('imcf016') TO s_browse[1].b_imcf016
            DISPLAY aimi105_filter_parser('imcf017') TO s_browse[1].b_imcf017
            DISPLAY aimi105_filter_parser('imcf018') TO s_browse[1].b_imcf018
            DISPLAY aimi105_filter_parser('imcf019') TO s_browse[1].b_imcf019
            DISPLAY aimi105_filter_parser('imcf020') TO s_browse[1].b_imcf020
            DISPLAY aimi105_filter_parser('imcf021') TO s_browse[1].b_imcf021
            DISPLAY aimi105_filter_parser('imcf031') TO s_browse[1].b_imcf031
            DISPLAY aimi105_filter_parser('imcf037') TO s_browse[1].b_imcf037
            DISPLAY aimi105_filter_parser('imcf032') TO s_browse[1].b_imcf032
            DISPLAY aimi105_filter_parser('imcf033') TO s_browse[1].b_imcf033
            DISPLAY aimi105_filter_parser('imcf034') TO s_browse[1].b_imcf034
            DISPLAY aimi105_filter_parser('imcf035') TO s_browse[1].b_imcf035
            DISPLAY aimi105_filter_parser('imcf022') TO s_browse[1].b_imcf022
            DISPLAY aimi105_filter_parser('imcf036') TO s_browse[1].b_imcf036
            DISPLAY aimi105_filter_parser('imcf041') TO s_browse[1].b_imcf041
            DISPLAY aimi105_filter_parser('imcf042') TO s_browse[1].b_imcf042
            DISPLAY aimi105_filter_parser('imcf051') TO s_browse[1].b_imcf051
            DISPLAY aimi105_filter_parser('imcf052') TO s_browse[1].b_imcf052
            DISPLAY aimi105_filter_parser('imcf062') TO s_browse[1].b_imcf062
            DISPLAY aimi105_filter_parser('imcf064') TO s_browse[1].b_imcf064
            DISPLAY aimi105_filter_parser('imcf077') TO s_browse[1].b_imcf077
            DISPLAY aimi105_filter_parser('imcf078') TO s_browse[1].b_imcf078
            DISPLAY aimi105_filter_parser('imcf079') TO s_browse[1].b_imcf079
            DISPLAY aimi105_filter_parser('imcf080') TO s_browse[1].b_imcf080
            DISPLAY aimi105_filter_parser('imcf071') TO s_browse[1].b_imcf071
            DISPLAY aimi105_filter_parser('imcf072') TO s_browse[1].b_imcf072
            DISPLAY aimi105_filter_parser('imcf073') TO s_browse[1].b_imcf073
            DISPLAY aimi105_filter_parser('imcf074') TO s_browse[1].b_imcf074
            DISPLAY aimi105_filter_parser('imcf075') TO s_browse[1].b_imcf075
            DISPLAY aimi105_filter_parser('imcf081') TO s_browse[1].b_imcf081
            DISPLAY aimi105_filter_parser('imcf082') TO s_browse[1].b_imcf082
            DISPLAY aimi105_filter_parser('imcf083') TO s_browse[1].b_imcf083
            DISPLAY aimi105_filter_parser('imcf084') TO s_browse[1].b_imcf084
            DISPLAY aimi105_filter_parser('imcf085') TO s_browse[1].b_imcf085
            DISPLAY aimi105_filter_parser('imcf091') TO s_browse[1].b_imcf091
            DISPLAY aimi105_filter_parser('imcf092') TO s_browse[1].b_imcf092
            DISPLAY aimi105_filter_parser('imcf101') TO s_browse[1].b_imcf101
            DISPLAY aimi105_filter_parser('imcf102') TO s_browse[1].b_imcf102
            DISPLAY aimi105_filter_parser('imcf103') TO s_browse[1].b_imcf103
            DISPLAY aimi105_filter_parser('imcf104') TO s_browse[1].b_imcf104
      
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
 
      CALL aimi105_filter_show('imcfsite')
   CALL aimi105_filter_show('imcf011')
   CALL aimi105_filter_show('imcf012')
   CALL aimi105_filter_show('imcf013')
   CALL aimi105_filter_show('imcf014')
   CALL aimi105_filter_show('imcf015')
   CALL aimi105_filter_show('imcf023')
   CALL aimi105_filter_show('imcf016')
   CALL aimi105_filter_show('imcf017')
   CALL aimi105_filter_show('imcf018')
   CALL aimi105_filter_show('imcf019')
   CALL aimi105_filter_show('imcf020')
   CALL aimi105_filter_show('imcf021')
   CALL aimi105_filter_show('imcf031')
   CALL aimi105_filter_show('imcf037')
   CALL aimi105_filter_show('imcf032')
   CALL aimi105_filter_show('imcf033')
   CALL aimi105_filter_show('imcf034')
   CALL aimi105_filter_show('imcf035')
   CALL aimi105_filter_show('imcf022')
   CALL aimi105_filter_show('imcf036')
   CALL aimi105_filter_show('imcf041')
   CALL aimi105_filter_show('imcf042')
   CALL aimi105_filter_show('imcf051')
   CALL aimi105_filter_show('imcf052')
   CALL aimi105_filter_show('imcf062')
   CALL aimi105_filter_show('imcf064')
   CALL aimi105_filter_show('imcf077')
   CALL aimi105_filter_show('imcf078')
   CALL aimi105_filter_show('imcf079')
   CALL aimi105_filter_show('imcf080')
   CALL aimi105_filter_show('imcf071')
   CALL aimi105_filter_show('imcf072')
   CALL aimi105_filter_show('imcf073')
   CALL aimi105_filter_show('imcf074')
   CALL aimi105_filter_show('imcf075')
   CALL aimi105_filter_show('imcf081')
   CALL aimi105_filter_show('imcf082')
   CALL aimi105_filter_show('imcf083')
   CALL aimi105_filter_show('imcf084')
   CALL aimi105_filter_show('imcf085')
   CALL aimi105_filter_show('imcf091')
   CALL aimi105_filter_show('imcf092')
   CALL aimi105_filter_show('imcf101')
   CALL aimi105_filter_show('imcf102')
   CALL aimi105_filter_show('imcf103')
   CALL aimi105_filter_show('imcf104')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi105.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimi105_filter_parser(ps_field)
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
 
{<section id="aimi105.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimi105_filter_show(ps_field)
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
   LET ls_condition = aimi105_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimi105.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimi105_query()
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
 
   INITIALIZE g_imcf_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aimi105_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimi105_browser_fill(g_wc,"F")
      CALL aimi105_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aimi105_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aimi105_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aimi105.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimi105_fetch(p_fl)
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
   LET g_imcf_m.imcfsite = g_browser[g_current_idx].b_imcfsite
   LET g_imcf_m.imcf011 = g_browser[g_current_idx].b_imcf011
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aimi105_master_referesh USING g_imcf_m.imcfsite,g_imcf_m.imcf011 INTO g_imcf_m.imcfsite,g_imcf_m.imcf011, 
       g_imcf_m.imcf012,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfowndp,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtdp, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt,g_imcf_m.imcf013,g_imcf_m.imcf014,g_imcf_m.imcf015, 
       g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf017,g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020, 
       g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf033,g_imcf_m.imcf034, 
       g_imcf_m.imcf035,g_imcf_m.imcf022,g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051, 
       g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079, 
       g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074, 
       g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf082,g_imcf_m.imcf083,g_imcf_m.imcf084,g_imcf_m.imcf085, 
       g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf102,g_imcf_m.imcf103,g_imcf_m.imcf104, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid_desc, 
       g_imcf_m.imcfcrtdp_desc,g_imcf_m.imcfmodid_desc,g_imcf_m.imcf016_desc,g_imcf_m.imcf031_desc,g_imcf_m.imcf032_desc, 
       g_imcf_m.imcf034_desc,g_imcf_m.imcf035_desc,g_imcf_m.imcf081_desc
   
   #遮罩相關處理
   LET g_imcf_m_mask_o.* =  g_imcf_m.*
   CALL aimi105_imcf_t_mask()
   LET g_imcf_m_mask_n.* =  g_imcf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimi105_set_act_visible()
   CALL aimi105_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("delete", TRUE)
   IF g_imcf_m.imcfstus != 'Y' THEN
      CALL cl_set_act_visible("delete", FALSE)
   END IF
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_imcf_m_t.* = g_imcf_m.*
   LET g_imcf_m_o.* = g_imcf_m.*
   
   LET g_data_owner = g_imcf_m.imcfownid      
   LET g_data_dept  = g_imcf_m.imcfowndp
   
   #重新顯示
   CALL aimi105_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimi105.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimi105_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_imcf_m.* TO NULL             #DEFAULT 設定
   LET g_imcfsite_t = NULL
   LET g_imcf011_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imcf_m.imcfownid = g_user
      LET g_imcf_m.imcfowndp = g_dept
      LET g_imcf_m.imcfcrtid = g_user
      LET g_imcf_m.imcfcrtdp = g_dept 
      LET g_imcf_m.imcfcrtdt = cl_get_current()
      LET g_imcf_m.imcfmodid = g_user
      LET g_imcf_m.imcfmoddt = cl_get_current()
      LET g_imcf_m.imcfstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imcf_m.imcfstus = "Y"
      LET g_imcf_m.imcf013 = "0"
      LET g_imcf_m.imcf014 = "0"
      LET g_imcf_m.imcf015 = "0"
      LET g_imcf_m.imcf023 = "1"
      LET g_imcf_m.imcf017 = "1"
      LET g_imcf_m.imcf018 = "1"
      LET g_imcf_m.imcf019 = "1"
      LET g_imcf_m.imcf020 = "0"
      LET g_imcf_m.imcf021 = "1"
      LET g_imcf_m.imcf022 = "0"
      LET g_imcf_m.imcf036 = "Y"
      LET g_imcf_m.imcf051 = "0"
      LET g_imcf_m.imcf052 = "0"
      LET g_imcf_m.imcf062 = "0"
      LET g_imcf_m.imcf064 = "0"
      LET g_imcf_m.imcf077 = "0"
      LET g_imcf_m.imcf078 = "0"
      LET g_imcf_m.imcf079 = "0"
      LET g_imcf_m.imcf080 = "N"
      LET g_imcf_m.imcf086 = "Y"
      LET g_imcf_m.imcf071 = "0"
      LET g_imcf_m.imcf072 = "0"
      LET g_imcf_m.imcf073 = "0"
      LET g_imcf_m.imcf074 = "0"
      LET g_imcf_m.imcf075 = "0"
      LET g_imcf_m.imcf082 = "0"
      LET g_imcf_m.imcf083 = "0"
      LET g_imcf_m.imcf084 = "1"
      LET g_imcf_m.imcf085 = "0"
      LET g_imcf_m.imcf091 = "N"
      LET g_imcf_m.imcf092 = "N"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_imcf_m.imcf037 = " "
      
      INITIALIZE g_imcf_m_t.* TO NULL
      LET g_imcf_m.imcfsite = g_site
      CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcf_m.imcfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aimi105_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_imcf_m.* TO NULL
         CALL aimi105_show()
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
   CALL aimi105_set_act_visible()
   CALL aimi105_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imcfsite_t = g_imcf_m.imcfsite
   LET g_imcf011_t = g_imcf_m.imcf011
 
   
   #組合新增資料的條件
   LET g_add_browse = " imcfent = " ||g_enterprise|| " AND",
                      " imcfsite = '", g_imcf_m.imcfsite, "' "
                      ," AND imcf011 = '", g_imcf_m.imcf011, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi105_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimi105_master_referesh USING g_imcf_m.imcfsite,g_imcf_m.imcf011 INTO g_imcf_m.imcfsite,g_imcf_m.imcf011, 
       g_imcf_m.imcf012,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfowndp,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtdp, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt,g_imcf_m.imcf013,g_imcf_m.imcf014,g_imcf_m.imcf015, 
       g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf017,g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020, 
       g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf033,g_imcf_m.imcf034, 
       g_imcf_m.imcf035,g_imcf_m.imcf022,g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051, 
       g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079, 
       g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074, 
       g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf082,g_imcf_m.imcf083,g_imcf_m.imcf084,g_imcf_m.imcf085, 
       g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf102,g_imcf_m.imcf103,g_imcf_m.imcf104, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid_desc, 
       g_imcf_m.imcfcrtdp_desc,g_imcf_m.imcfmodid_desc,g_imcf_m.imcf016_desc,g_imcf_m.imcf031_desc,g_imcf_m.imcf032_desc, 
       g_imcf_m.imcf034_desc,g_imcf_m.imcf035_desc,g_imcf_m.imcf081_desc
   
   
   #遮罩相關處理
   LET g_imcf_m_mask_o.* =  g_imcf_m.*
   CALL aimi105_imcf_t_mask()
   LET g_imcf_m_mask_n.* =  g_imcf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imcf_m.imcfsite,g_imcf_m.imcf011,g_imcf_m.oocql004,g_imcf_m.oocql005,g_imcf_m.imcf012, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp, 
       g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtid_desc,g_imcf_m.imcfcrtdp,g_imcf_m.imcfcrtdp_desc, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmodid_desc,g_imcf_m.imcfmoddt,g_imcf_m.imcf013, 
       g_imcf_m.imcf014,g_imcf_m.imcf015,g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf016_desc,g_imcf_m.imcf017, 
       g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf031_desc, 
       g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf032_desc,g_imcf_m.imcf033,g_imcf_m.imcf033_desc, 
       g_imcf_m.imcf034,g_imcf_m.imcf034_desc,g_imcf_m.imcf035,g_imcf_m.imcf035_desc,g_imcf_m.imcf022, 
       g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf041_desc,g_imcf_m.imcf042,g_imcf_m.imcf042_desc, 
       g_imcf_m.imcf051,g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078, 
       g_imcf_m.imcf079,g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073, 
       g_imcf_m.imcf074,g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf081_desc,g_imcf_m.imcf082,g_imcf_m.imcf083, 
       g_imcf_m.imcf084,g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf101_desc, 
       g_imcf_m.imcf102,g_imcf_m.imcf102_desc,g_imcf_m.imcf103,g_imcf_m.imcf103_desc,g_imcf_m.imcf104, 
       g_imcf_m.imcf104_desc
 
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
 
   LET g_data_owner = g_imcf_m.imcfownid      
   LET g_data_dept  = g_imcf_m.imcfowndp
 
   #功能已完成,通報訊息中心
   CALL aimi105_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimi105.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimi105_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imcf_m.imcfsite IS NULL
 
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
   LET g_imcfsite_t = g_imcf_m.imcfsite
   LET g_imcf011_t = g_imcf_m.imcf011
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aimi105_cl USING g_enterprise,g_imcf_m.imcfsite,g_imcf_m.imcf011
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi105_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimi105_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi105_master_referesh USING g_imcf_m.imcfsite,g_imcf_m.imcf011 INTO g_imcf_m.imcfsite,g_imcf_m.imcf011, 
       g_imcf_m.imcf012,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfowndp,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtdp, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt,g_imcf_m.imcf013,g_imcf_m.imcf014,g_imcf_m.imcf015, 
       g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf017,g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020, 
       g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf033,g_imcf_m.imcf034, 
       g_imcf_m.imcf035,g_imcf_m.imcf022,g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051, 
       g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079, 
       g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074, 
       g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf082,g_imcf_m.imcf083,g_imcf_m.imcf084,g_imcf_m.imcf085, 
       g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf102,g_imcf_m.imcf103,g_imcf_m.imcf104, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid_desc, 
       g_imcf_m.imcfcrtdp_desc,g_imcf_m.imcfmodid_desc,g_imcf_m.imcf016_desc,g_imcf_m.imcf031_desc,g_imcf_m.imcf032_desc, 
       g_imcf_m.imcf034_desc,g_imcf_m.imcf035_desc,g_imcf_m.imcf081_desc
 
   #檢查是否允許此動作
   IF NOT aimi105_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_imcf_m_mask_o.* =  g_imcf_m.*
   CALL aimi105_imcf_t_mask()
   LET g_imcf_m_mask_n.* =  g_imcf_m.*
   
   
 
   #顯示資料
   CALL aimi105_show()
   
   WHILE TRUE
      LET g_imcf_m.imcfsite = g_imcfsite_t
      LET g_imcf_m.imcf011 = g_imcf011_t
 
      
      #寫入修改者/修改日期資訊
      LET g_imcf_m.imcfmodid = g_user 
LET g_imcf_m.imcfmoddt = cl_get_current()
LET g_imcf_m.imcfmodid_desc = cl_get_username(g_imcf_m.imcfmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aimi105_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_imcf_m.* = g_imcf_m_t.*
         CALL aimi105_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE imcf_t SET (imcfmodid,imcfmoddt) = (g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt)
       WHERE imcfent = g_enterprise AND imcfsite = g_imcfsite_t
         AND imcf011 = g_imcf011_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimi105_set_act_visible()
   CALL aimi105_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imcfent = " ||g_enterprise|| " AND",
                      " imcfsite = '", g_imcf_m.imcfsite, "' "
                      ," AND imcf011 = '", g_imcf_m.imcf011, "' "
 
   #填到對應位置
   CALL aimi105_browser_fill(g_wc,"")
 
   CLOSE aimi105_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi105_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aimi105.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimi105_input(p_cmd)
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
   DEFINE l_success      LIKE type_t.num5
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
   DISPLAY BY NAME g_imcf_m.imcfsite,g_imcf_m.imcf011,g_imcf_m.oocql004,g_imcf_m.oocql005,g_imcf_m.imcf012, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp, 
       g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtid_desc,g_imcf_m.imcfcrtdp,g_imcf_m.imcfcrtdp_desc, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmodid_desc,g_imcf_m.imcfmoddt,g_imcf_m.imcf013, 
       g_imcf_m.imcf014,g_imcf_m.imcf015,g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf016_desc,g_imcf_m.imcf017, 
       g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf031_desc, 
       g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf032_desc,g_imcf_m.imcf033,g_imcf_m.imcf033_desc, 
       g_imcf_m.imcf034,g_imcf_m.imcf034_desc,g_imcf_m.imcf035,g_imcf_m.imcf035_desc,g_imcf_m.imcf022, 
       g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf041_desc,g_imcf_m.imcf042,g_imcf_m.imcf042_desc, 
       g_imcf_m.imcf051,g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078, 
       g_imcf_m.imcf079,g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073, 
       g_imcf_m.imcf074,g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf081_desc,g_imcf_m.imcf082,g_imcf_m.imcf083, 
       g_imcf_m.imcf084,g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf101_desc, 
       g_imcf_m.imcf102,g_imcf_m.imcf102_desc,g_imcf_m.imcf103,g_imcf_m.imcf103_desc,g_imcf_m.imcf104, 
       g_imcf_m.imcf104_desc
   
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
   CALL aimi105_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimi105_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   IF p_cmd = 'a'  THEN
      LET g_imcf_m.imcfstus = 'Y'
      CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
   END IF 
   
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_imcf_m.imcfsite,g_imcf_m.imcf011,g_imcf_m.oocql004,g_imcf_m.oocql005,g_imcf_m.imcf012, 
          g_imcf_m.imcfstus,g_imcf_m.imcf013,g_imcf_m.imcf014,g_imcf_m.imcf015,g_imcf_m.imcf023,g_imcf_m.imcf016, 
          g_imcf_m.imcf017,g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031, 
          g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf033,g_imcf_m.imcf034,g_imcf_m.imcf035,g_imcf_m.imcf022, 
          g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051,g_imcf_m.imcf052,g_imcf_m.imcf062, 
          g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079,g_imcf_m.imcf080,g_imcf_m.imcf086, 
          g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074,g_imcf_m.imcf075,g_imcf_m.imcf081, 
          g_imcf_m.imcf082,g_imcf_m.imcf083,g_imcf_m.imcf084,g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092, 
          g_imcf_m.imcf101,g_imcf_m.imcf102,g_imcf_m.imcf103,g_imcf_m.imcf104 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               #161013-00017#5 add-S
               IF NOT cl_null(g_imcf_m.imcf011)  THEN
                  CALL n_oocql('204',g_imcf_m.imcf011)    # n_glacl:對應多語言表格 。 g_glac_m.glac002: 對應值
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = '204'
                  LET g_ref_fields[2] = g_imcf_m.imcf011
                  CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                      ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imcf_m.oocql004 = g_rtn_fields[1]
                  LET g_imcf_m.oocql005 = g_rtn_fields[2]

                  DISPLAY BY NAME g_imcf_m.oocql004
                  DISPLAY BY NAME g_imcf_m.oocql005
               END IF
               #161013-00017#5 add-E
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.oocql001 = '204'
LET g_master_multi_table_t.oocql002 = g_imcf_m.imcf011
LET g_master_multi_table_t.oocql004 = g_imcf_m.oocql004
LET g_master_multi_table_t.oocql005 = g_imcf_m.oocql005
 
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfsite
            #add-point:BEFORE FIELD imcfsite name="input.b.imcfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfsite
            
            #add-point:AFTER FIELD imcfsite name="input.a.imcfsite"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_imcf_m.imcf011) AND NOT cl_null(g_imcf_m.imcfsite) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcf_m.imcf011 != g_imcf011_t  OR g_imcf_m.imcfsite != g_imcfsite_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imcf_t WHERE "||"imcfent = '" ||g_enterprise|| "' AND "||"imcf011 = '"||g_imcf_m.imcf011 ||"' AND "|| "imcfsite = '"||g_imcf_m.imcfsite ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcfsite
            #add-point:ON CHANGE imcfsite name="input.g.imcfsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf011
            
            #add-point:AFTER FIELD imcf011 name="input.a.imcf011"
            #161013-00017#5 mod-S
#            LET g_imcf_m.imcf011_desc = ' '
#            DISPLAY g_imcf_m.imcf011_desc TO imcf011_desc
            LET g_imcf_m.oocql004 = ' '
            LET g_imcf_m.oocql005 = ' '
            DISPLAY BY NAME g_imcf_m.oocql004
            DISPLAY BY NAME g_imcf_m.oocql005
            #161013-00017#5 mod-E
            #此段落由子樣板a05產生
            IF NOT cl_null(g_imcf_m.imcf011) AND NOT cl_null(g_imcf_m.imcfsite) THEN 
               #检查资料在应用分类码中是否存在且有效
               IF NOT aimi105_imcf011_chk(g_imcf_m.imcf011) THEN 
                  LET g_imcf_m.imcf011 = g_imcf011_t
                  #161013-00017#5 mod-S
                  CALL aimi105_imcf011_desc(g_imcf_m.imcf011) 
#                  RETURNING g_imcf_m.imcf011_desc
#                  DISPLAY g_imcf_m.imcf011_desc TO imcf011_desc               
                  DISPLAY BY NAME g_imcf_m.oocql004
                  DISPLAY BY NAME g_imcf_m.oocql005
                  #161013-00017#5 mod-E
                  NEXT FIELD imcf011
               END IF
               #检查重复 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcf_m.imcf011 != g_imcf011_t  OR g_imcf_m.imcfsite != g_imcfsite_t ))) THEN 
                  IF NOT ap_chk_notDup(g_imcf_m.imcf011,"SELECT COUNT(*) FROM imcf_t WHERE "||"imcfent = '" ||g_enterprise|| "' AND "||"imcf011 = '"||g_imcf_m.imcf011 ||"' AND "|| "imcfsite = '"||g_imcf_m.imcfsite ||"'",'std-00004',0) THEN 
                     LET g_imcf_m.imcf011=g_imcf011_t
                     #161013-00017#5 mod-S
                     CALL aimi105_imcf011_desc(g_imcf_m.imcf011) 
#                     RETURNING g_imcf_m.imcf011_desc
#                     DISPLAY g_imcf_m.imcf011_desc TO imcf011_desc               
                     DISPLAY BY NAME g_imcf_m.oocql004
                     DISPLAY BY NAME g_imcf_m.oocql005
                     #161013-00017#5 mod-E
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #生管分群说明
            #161013-00017#5 mod-S
            CALL aimi105_imcf011_desc(g_imcf_m.imcf011) 
#            RETURNING g_imcf_m.imcf011_desc
#            DISPLAY g_imcf_m.imcf011_desc TO imcf011_desc               
            DISPLAY BY NAME g_imcf_m.oocql004
            DISPLAY BY NAME g_imcf_m.oocql005
            #161013-00017#5 mod-E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf011
            #add-point:BEFORE FIELD imcf011 name="input.b.imcf011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf011
            #add-point:ON CHANGE imcf011 name="input.g.imcf011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql004
            #add-point:BEFORE FIELD oocql004 name="input.b.oocql004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql004
            
            #add-point:AFTER FIELD oocql004 name="input.a.oocql004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql004
            #add-point:ON CHANGE oocql004 name="input.g.oocql004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocql005
            #add-point:BEFORE FIELD oocql005 name="input.b.oocql005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocql005
            
            #add-point:AFTER FIELD oocql005 name="input.a.oocql005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocql005
            #add-point:ON CHANGE oocql005 name="input.g.oocql005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf012
            
            #add-point:AFTER FIELD imcf012 name="input.a.imcf012"
            DISPLAY '' TO imcf012_desc
            IF NOT cl_null(g_imcf_m.imcf012) THEN 
#此段落由子樣板a19產生
               CALL aimi105_imcf012_chk(g_imcf_m.imcf012)
               IF NOT cl_null (g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf012
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aooi130'
                  LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
                  LET g_errparam.exeprog    ='aooi130'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  LET g_imcf_m.imcf012 = g_imcf_m_t.imcf012
                  #160824-00002#1-s
                  #CALL aimi105_imcf012_desc(g_imcf_m.imcf012) RETURNING g_imcf_m.imcf012_desc
                  CALL s_desc_get_person_desc(g_imcf_m.imcf012) RETURNING g_imcf_m.imcf012_desc
                  #160824-00002#1-e
                  DISPLAY g_imcf_m.imcf012_desc TO imcf012_desc                 
                  NEXT FIELD imcf012
               END IF 

               #抓取员工全名
               #160824-00002#1-s
               #CALL aimi105_imcf012_desc(g_imcf_m.imcf012) RETURNING g_imcf_m.imcf012_desc
               CALL s_desc_get_person_desc(g_imcf_m.imcf012) RETURNING g_imcf_m.imcf012_desc
               #160824-00002#1-e
               DISPLAY g_imcf_m.imcf012_desc TO imcf012_desc

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf012
            #add-point:BEFORE FIELD imcf012 name="input.b.imcf012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf012
            #add-point:ON CHANGE imcf012 name="input.g.imcf012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcfstus
            #add-point:BEFORE FIELD imcfstus name="input.b.imcfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcfstus
            
            #add-point:AFTER FIELD imcfstus name="input.a.imcfstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcfstus
            #add-point:ON CHANGE imcfstus name="input.g.imcfstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf013
            #add-point:BEFORE FIELD imcf013 name="input.b.imcf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf013
            
            #add-point:AFTER FIELD imcf013 name="input.a.imcf013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf013
            #add-point:ON CHANGE imcf013 name="input.g.imcf013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf014
            #add-point:BEFORE FIELD imcf014 name="input.b.imcf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf014
            
            #add-point:AFTER FIELD imcf014 name="input.a.imcf014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf014
            #add-point:ON CHANGE imcf014 name="input.g.imcf014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf015
            #add-point:BEFORE FIELD imcf015 name="input.b.imcf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf015
            
            #add-point:AFTER FIELD imcf015 name="input.a.imcf015"
            IF NOT cl_null(g_imcf_m.imcf015) THEN 
               IF g_imcf_m.imcf015 < 0 OR g_imcf_m.imcf015 > 100  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00011'
                  LET g_errparam.extend = g_imcf_m.imcf015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF NOT cl_null(g_imcf_m_t.imcf015) THEN 
                     LET g_imcf_m.imcf015 = g_imcf_m_t.imcf015
                  ELSE
                     LET g_imcf_m.imcf015 =0                  
                  END IF  
                  NEXT FIELD imcf015
               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf015
            #add-point:ON CHANGE imcf015 name="input.g.imcf015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf023
            #add-point:BEFORE FIELD imcf023 name="input.b.imcf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf023
            
            #add-point:AFTER FIELD imcf023 name="input.a.imcf023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf023
            #add-point:ON CHANGE imcf023 name="input.g.imcf023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf016
            
            #add-point:AFTER FIELD imcf016 name="input.a.imcf016"
            DISPLAY ' ' TO imcf016_desc          
            IF NOT cl_null(g_imcf_m.imcf016)THEN
               CALL aimi105_imcf016_chk(g_imcf_m.imcf016)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf016
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_imcf_m.imcf016 = g_imcf_m_t.imcf016
                  CALL aimi105_imcf016_desc(g_imcf_m.imcf016) RETURNING g_imcf_m.imcf016_desc
                  DISPLAY g_imcf_m.imcf016_desc TO imcf016_desc                 
                  NEXT FIELD imcf016
               END IF    
            END IF 
            #单位名称
            CALL aimi105_imcf016_desc(g_imcf_m.imcf016) RETURNING g_imcf_m.imcf016_desc
            DISPLAY g_imcf_m.imcf016_desc TO imcf016_desc
           
            #發料單位請預設為生產單位
            IF NOT cl_null(g_imcf_m.imcf016)THEN
               LET g_imcf_m.imcf081 = g_imcf_m.imcf016
               CALL aimi105_imcf016_desc(g_imcf_m.imcf081) RETURNING g_imcf_m.imcf081_desc
               DISPLAY g_imcf_m.imcf081_desc TO imcf081_desc
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf016
            #add-point:BEFORE FIELD imcf016 name="input.b.imcf016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf016
            #add-point:ON CHANGE imcf016 name="input.g.imcf016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf017
            #add-point:BEFORE FIELD imcf017 name="input.b.imcf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf017
            
            #add-point:AFTER FIELD imcf017 name="input.a.imcf017"
            IF NOT cl_null(g_imcf_m.imcf017) THEN 
               IF g_imcf_m.imcf017 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf017
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf017) THEN 
                     LET g_imcf_m.imcf017 = g_imcf_m_t.imcf017
                  ELSE
                     LET g_imcf_m.imcf017 =0                  
                  END IF  
                  NEXT FIELD imcf017
               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf017
            #add-point:ON CHANGE imcf017 name="input.g.imcf017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf018
            #add-point:BEFORE FIELD imcf018 name="input.b.imcf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf018
            
            #add-point:AFTER FIELD imcf018 name="input.a.imcf018"
            IF NOT cl_null(g_imcf_m.imcf018) THEN 
               IF g_imcf_m.imcf018 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf018
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf018) THEN 
                     LET g_imcf_m.imcf018 = g_imcf_m_t.imcf018
                  ELSE
                     LET g_imcf_m.imcf018 =0                  
                  END IF  
                  NEXT FIELD imcf018
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf018
            #add-point:ON CHANGE imcf018 name="input.g.imcf018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf019
            #add-point:BEFORE FIELD imcf019 name="input.b.imcf019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf019
            
            #add-point:AFTER FIELD imcf019 name="input.a.imcf019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf019
            #add-point:ON CHANGE imcf019 name="input.g.imcf019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf020
            #add-point:BEFORE FIELD imcf020 name="input.b.imcf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf020
            
            #add-point:AFTER FIELD imcf020 name="input.a.imcf020"
            IF NOT cl_null(g_imcf_m.imcf020) THEN 
               IF g_imcf_m.imcf020 < 0 OR g_imcf_m.imcf020 > 100  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00011'
                  LET g_errparam.extend = g_imcf_m.imcf020
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf020) THEN 
                     LET g_imcf_m.imcf020 = g_imcf_m_t.imcf020
                  ELSE
                     LET g_imcf_m.imcf020 =0                  
                  END IF  
                  NEXT FIELD imcf020
               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf020
            #add-point:ON CHANGE imcf020 name="input.g.imcf020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf021
            #add-point:BEFORE FIELD imcf021 name="input.b.imcf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf021
            
            #add-point:AFTER FIELD imcf021 name="input.a.imcf021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf021
            #add-point:ON CHANGE imcf021 name="input.g.imcf021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf031
            
            #add-point:AFTER FIELD imcf031 name="input.a.imcf031"
            DISPLAY '' TO imcf031_desc 
            IF NOT cl_null(g_imcf_m.imcf031) THEN
               CALL aimi105_imcf031_chk(g_imcf_m.imcf031)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf031
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aooi200'
                  LET g_errparam.replace[2] = cl_get_progname('aooi200',g_lang,"2")
                  LET g_errparam.exeprog    ='aooi200'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_imcf_m.imcf031 = g_imcf_m_t.imcf031
                  CALL aimi105_imcf031_desc(g_imcf_m.imcf031) RETURNING g_imcf_m.imcf031_desc
                  DISPLAY g_imcf_m.imcf031_desc TO imcf031_desc                 
                  NEXT FIELD imcf031
               END IF     
            END IF 
            
            CALL aimi105_imcf031_desc(g_imcf_m.imcf031) RETURNING g_imcf_m.imcf031_desc
            DISPLAY g_imcf_m.imcf031_desc TO imcf031_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf031
            #add-point:BEFORE FIELD imcf031 name="input.b.imcf031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf031
            #add-point:ON CHANGE imcf031 name="input.g.imcf031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf037
            #add-point:BEFORE FIELD imcf037 name="input.b.imcf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf037
            
            #add-point:AFTER FIELD imcf037 name="input.a.imcf037"
            #IF NOT cl_null(g_imcf_m.imcf037) THEN
            #   CALL aimi105_imcf037_chk(g_imcf_m.imcf037)
            #   IF NOT cl_null(g_errno) THEN 
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = g_errno
            #      LET g_errparam.extend = g_imcf_m.imcf037
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #
            #      LET g_imcf_m.imcf037 = g_imcf_m_t.imcf037
            #      NEXT FIELD CURRENT
            #   END IF
            #ELSE
            #   LET g_imcf_m.imcf037 = ' '
            #END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf037
            #add-point:ON CHANGE imcf037 name="input.g.imcf037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf032
            
            #add-point:AFTER FIELD imcf032 name="input.a.imcf032"
            DISPLAY '' TO imcf032_desc
            IF NOT cl_null(g_imcf_m.imcf032) THEN
               #CALL aimi105_imcf032_chk(g_imcf_m.imcf032)
               IF NOT aimi105_imcf032_chk(g_imcf_m.imcf032) THEN 
                  #INITIALIZE g_errparam TO NULL
                  #LET g_errparam.code = g_errno
                  #LET g_errparam.extend = g_imcf_m.imcf032
                  #LET g_errparam.popup = TRUE
                  #CALL cl_err()
               
                  LET g_imcf_m.imcf032 = g_imcf_m_t.imcf032
                  CALL aimi105_imcf032_desc(g_imcf_m.imcf032) RETURNING g_imcf_m.imcf032_desc
                  DISPLAY g_imcf_m.imcf032_desc TO imcf032_desc                 
                  NEXT FIELD imcf032
               END IF     
            END IF 
            ##带出制程编号，说明
            #CALL aimi105_ecba002_ecba003()
            #DISPLAY BY NAME g_imcf_m.imcf033,g_imcf_m.imcf033_desc
            #料件品名            
            CALL aimi105_imcf032_desc(g_imcf_m.imcf032) RETURNING g_imcf_m.imcf032_desc
            DISPLAY g_imcf_m.imcf032_desc TO imcf032_desc    
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf032
            #add-point:BEFORE FIELD imcf032 name="input.b.imcf032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf032
            #add-point:ON CHANGE imcf032 name="input.g.imcf032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf033
            
            #add-point:AFTER FIELD imcf033 name="input.a.imcf033"
            #DISPLAY '' TO imcf033_desc
            #IF NOT cl_null(g_imcf_m.imcf033) THEN
            #   CALL aimi105_imcf033_chk(g_imcf_m.imcf032,g_imcf_m.imcf033)
            #   IF NOT cl_null(g_errno) THEN 
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = g_errno
            #      LET g_errparam.extend = g_imcf_m.imcf033
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #   
            #      LET g_imcf_m.imcf033 = g_imcf_m_t.imcf033
            #      CALL aimi105_imcf033_desc(g_imcf_m.imcf033) RETURNING g_imcf_m.imcf033_desc
            #      DISPLAY BY NAME g_imcf_m.imcf033_desc
            #      NEXT FIELD imcf033
            #   END IF     
            #END IF 
            #CALL aimi105_imcf033_desc(g_imcf_m.imcf033) RETURNING g_imcf_m.imcf033_desc
            #DISPLAY BY NAME g_imcf_m.imcf033_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf033
            #add-point:BEFORE FIELD imcf033 name="input.b.imcf033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf033
            #add-point:ON CHANGE imcf033 name="input.g.imcf033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf034
            
            #add-point:AFTER FIELD imcf034 name="input.a.imcf034"
            DISPLAY '' TO imcf034_desc
            IF NOT cl_null(g_imcf_m.imcf034) THEN 
               CALL aimi105_imcf034_chk(g_imcf_m.imcf034)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf034
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog    ='aooi125'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imcf_m.imcf034=g_imcf_m_t.imcf034
                  CALL aimi105_imcf034_desc(g_imcf_m.imcf034) RETURNING g_imcf_m.imcf034_desc                       
                  DISPLAY g_imcf_m.imcf034_desc TO imcf034_desc                 
                  NEXT FIELD imcf034
               END IF 
            END IF 
            
            CALL aimi105_imcf034_desc(g_imcf_m.imcf034) RETURNING g_imcf_m.imcf034_desc
            DISPLAY g_imcf_m.imcf034_desc TO imcf034_desc
            
            
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf034
            #add-point:BEFORE FIELD imcf034 name="input.b.imcf034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf034
            #add-point:ON CHANGE imcf034 name="input.g.imcf034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf035
            
            #add-point:AFTER FIELD imcf035 name="input.a.imcf035"
            DISPLAY '' TO imcf035_desc 
            IF NOT cl_null(g_imcf_m.imcf035) THEN 
               CALL s_aooi125_chk_center('3',g_imcf_m.imcf035) RETURNING l_success
               IF l_success = FALSE THEN               
                  LET g_imcf_m.imcf035=g_imcf_m_t.imcf035
                  #预设成本中心
                  CALL aimi105_imcf034_desc(g_imcf_m.imcf035) RETURNING g_imcf_m.imcf035_desc
                  DISPLAY g_imcf_m.imcf035_desc TO imcf035_desc       
                  NEXT FIELD imcf035
               END IF 
            END IF
            #预设成本中心（延用部门/厂商）
            CALL aimi105_imcf034_desc(g_imcf_m.imcf035) RETURNING g_imcf_m.imcf035_desc
            DISPLAY g_imcf_m.imcf035_desc TO imcf035_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf035
            #add-point:BEFORE FIELD imcf035 name="input.b.imcf035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf035
            #add-point:ON CHANGE imcf035 name="input.g.imcf035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf022
            #add-point:BEFORE FIELD imcf022 name="input.b.imcf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf022
            
            #add-point:AFTER FIELD imcf022 name="input.a.imcf022"
            IF NOT cl_null(g_imcf_m.imcf022) THEN
               IF g_imcf_m.imcf022 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf022
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf022) THEN 
                     LET g_imcf_m.imcf022 = g_imcf_m_t.imcf022
                  ELSE
                     LET g_imcf_m.imcf022 =0                  
                  END IF  
                  NEXT FIELD imcf022
               END IF
               #當輸入值大於0時，檢查輸入值須大於[C:生產單位批量]及[C:最小生產數量]
               IF g_imcf_m.imcf022 <= g_imcf_m.imcf017 AND g_imcf_m.imcf022 > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00195'
                  LET g_errparam.extend = g_imcf_m.imcf022
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF NOT cl_null(g_imcf_m_t.imcf022) THEN 
                     LET g_imcf_m.imcf022 = g_imcf_m_t.imcf022
                  ELSE
                     LET g_imcf_m.imcf022 =0                  
                  END IF 
                  NEXT FIELD imcf022                  
               END IF 

               IF g_imcf_m.imcf022 <= g_imcf_m.imcf018 AND g_imcf_m.imcf022 > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00196'
                  LET g_errparam.extend = g_imcf_m.imcf022
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF NOT cl_null(g_imcf_m_t.imcf022) THEN 
                     LET g_imcf_m.imcf022 = g_imcf_m_t.imcf022
                  ELSE
                     LET g_imcf_m.imcf022 =0                  
                  END IF
                  NEXT FIELD imcf022                  
               END IF   
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf022
            #add-point:ON CHANGE imcf022 name="input.g.imcf022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf036
            #add-point:BEFORE FIELD imcf036 name="input.b.imcf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf036
            
            #add-point:AFTER FIELD imcf036 name="input.a.imcf036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf036
            #add-point:ON CHANGE imcf036 name="input.g.imcf036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf041
            
            #add-point:AFTER FIELD imcf041 name="input.a.imcf041"
            DISPLAY '' TO imcf041_desc 
            IF NOT cl_null(g_imcf_m.imcf041) THEN 
               CALL aimi105_imcf041_chk(g_imcf_m.imcf041)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf041
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aini001'
                  LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                  LET g_errparam.exeprog    ='aini001'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_imcf_m.imcf041 = g_imcf_m_t.imcf041
                  CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf041) RETURNING g_imcf_m.imcf041_desc
                  DISPLAY g_imcf_m.imcf041_desc TO imcf041_desc                  
                  NEXT FIELD imcf041
               END IF 
            END IF 
            
            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf041) RETURNING g_imcf_m.imcf041_desc
            DISPLAY g_imcf_m.imcf041_desc TO imcf041_desc
            
            
           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf041
            #add-point:BEFORE FIELD imcf041 name="input.b.imcf041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf041
            #add-point:ON CHANGE imcf041 name="input.g.imcf041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf042
            
            #add-point:AFTER FIELD imcf042 name="input.a.imcf042"
            DISPLAY '' TO imcf042_desc 
            #IF NOT cl_null(g_imcf_m.imcf042) AND NOT cl_null(g_imcf_m.imcf041) THEN
            IF NOT cl_null(g_imcf_m.imcf042) THEN             
               CALL aimi105_imcf042_chk(g_imcf_m.imcf041,g_imcf_m.imcf042)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf042
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aini002'
                  LET g_errparam.replace[2] = cl_get_progname('aini002',g_lang,"2")
                  LET g_errparam.exeprog    ='aini002'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_imcf_m.imcf042 = g_imcf_m_t.imcf042
                  CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf041,g_imcf_m.imcf042) 
                  RETURNING g_imcf_m.imcf042_desc
                  DISPLAY g_imcf_m.imcf042_desc TO imcf042_desc                  
                  NEXT FIELD imcf042
               END IF 
            END IF 
           CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf041,g_imcf_m.imcf042) 
           RETURNING g_imcf_m.imcf042_desc
           DISPLAY g_imcf_m.imcf042_desc TO imcf042_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf042
            #add-point:BEFORE FIELD imcf042 name="input.b.imcf042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf042
            #add-point:ON CHANGE imcf042 name="input.g.imcf042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf051
            #add-point:BEFORE FIELD imcf051 name="input.b.imcf051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf051
            
            #add-point:AFTER FIELD imcf051 name="input.a.imcf051"
            IF NOT cl_null(g_imcf_m.imcf051) THEN
                IF g_imcf_m.imcf051 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf051
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf051) THEN 
                     LET g_imcf_m.imcf051 = g_imcf_m_t.imcf051
                  ELSE
                     LET g_imcf_m.imcf051 =0                  
                  END IF  
                  NEXT FIELD imcf051
               END IF                                     
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf051
            #add-point:ON CHANGE imcf051 name="input.g.imcf051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf052
            #add-point:BEFORE FIELD imcf052 name="input.b.imcf052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf052
            
            #add-point:AFTER FIELD imcf052 name="input.a.imcf052"
            IF NOT cl_null(g_imcf_m.imcf052) THEN 
               IF g_imcf_m.imcf052 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf052
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf052) THEN 
                     LET g_imcf_m.imcf052 = g_imcf_m_t.imcf052
                  ELSE
                     LET g_imcf_m.imcf052 =0                  
                  END IF  
                  NEXT FIELD imcf052
               END IF                       
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf052
            #add-point:ON CHANGE imcf052 name="input.g.imcf052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf062
            #add-point:BEFORE FIELD imcf062 name="input.b.imcf062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf062
            
            #add-point:AFTER FIELD imcf062 name="input.a.imcf062"
            IF NOT cl_null(g_imcf_m.imcf062) THEN
               IF g_imcf_m.imcf062 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf062
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                   
                  LET g_imcf_m.imcf062 = g_imcf_m_t.imcf062
                  NEXT FIELD imcf062
               END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf062
            #add-point:ON CHANGE imcf062 name="input.g.imcf062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf064
            #add-point:BEFORE FIELD imcf064 name="input.b.imcf064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf064
            
            #add-point:AFTER FIELD imcf064 name="input.a.imcf064"
            IF NOT cl_null(g_imcf_m.imcf064) THEN
               IF g_imcf_m.imcf064 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf064
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf064) THEN 
                     LET g_imcf_m.imcf064 = g_imcf_m_t.imcf064
                  ELSE
                     LET g_imcf_m.imcf064 =0                  
                  END IF  
                  NEXT FIELD imcf064
               END IF             
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf064
            #add-point:ON CHANGE imcf064 name="input.g.imcf064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf077
            #add-point:BEFORE FIELD imcf077 name="input.b.imcf077"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf077
            
            #add-point:AFTER FIELD imcf077 name="input.a.imcf077"
            IF NOT cl_null(g_imcf_m.imcf077) THEN 
               IF g_imcf_m.imcf077 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf077
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imcf_m.imcf077 = g_imcf_m_t.imcf077
                  NEXT FIELD imcf077
               END IF             
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf077
            #add-point:ON CHANGE imcf077 name="input.g.imcf077"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf078
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcf_m.imcf078,"0","1","","","azz-00079",1) THEN
               NEXT FIELD imcf078
            END IF 
 
 
 
            #add-point:AFTER FIELD imcf078 name="input.a.imcf078"
            IF NOT cl_null(g_imcf_m.imcf078) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf078
            #add-point:BEFORE FIELD imcf078 name="input.b.imcf078"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf078
            #add-point:ON CHANGE imcf078 name="input.g.imcf078"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf079
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcf_m.imcf079,"0","1","","","azz-00079",1) THEN
               NEXT FIELD imcf079
            END IF 
 
 
 
            #add-point:AFTER FIELD imcf079 name="input.a.imcf079"
            IF NOT cl_null(g_imcf_m.imcf079) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf079
            #add-point:BEFORE FIELD imcf079 name="input.b.imcf079"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf079
            #add-point:ON CHANGE imcf079 name="input.g.imcf079"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf080
            #add-point:BEFORE FIELD imcf080 name="input.b.imcf080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf080
            
            #add-point:AFTER FIELD imcf080 name="input.a.imcf080"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf080
            #add-point:ON CHANGE imcf080 name="input.g.imcf080"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf086
            #add-point:BEFORE FIELD imcf086 name="input.b.imcf086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf086
            
            #add-point:AFTER FIELD imcf086 name="input.a.imcf086"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf086
            #add-point:ON CHANGE imcf086 name="input.g.imcf086"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf071
            #add-point:BEFORE FIELD imcf071 name="input.b.imcf071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf071
            
            #add-point:AFTER FIELD imcf071 name="input.a.imcf071"
            IF NOT cl_null(g_imcf_m.imcf071) THEN
               IF g_imcf_m.imcf071 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf071
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf071) THEN 
                     LET g_imcf_m.imcf071 = g_imcf_m_t.imcf071
                  ELSE
                     LET g_imcf_m.imcf071 =0                  
                  END IF  
                  NEXT FIELD imcf071
               END IF                         
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf071
            #add-point:ON CHANGE imcf071 name="input.g.imcf071"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf072
            #add-point:BEFORE FIELD imcf072 name="input.b.imcf072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf072
            
            #add-point:AFTER FIELD imcf072 name="input.a.imcf072"
            IF NOT cl_null(g_imcf_m.imcf072) THEN
               IF g_imcf_m.imcf072 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf072
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf072) THEN 
                     LET g_imcf_m.imcf072 = g_imcf_m_t.imcf072
                  ELSE
                     LET g_imcf_m.imcf072 =0                  
                  END IF  
                  NEXT FIELD imcf072
               END IF                         
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf072
            #add-point:ON CHANGE imcf072 name="input.g.imcf072"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf073
            #add-point:BEFORE FIELD imcf073 name="input.b.imcf073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf073
            
            #add-point:AFTER FIELD imcf073 name="input.a.imcf073"
            IF NOT cl_null(g_imcf_m.imcf073) THEN
               IF g_imcf_m.imcf073 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf073
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf073) THEN 
                     LET g_imcf_m.imcf073 = g_imcf_m_t.imcf073
                  ELSE
                     LET g_imcf_m.imcf073 =0                  
                  END IF  
                  NEXT FIELD imcf073
               END IF             
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf073
            #add-point:ON CHANGE imcf073 name="input.g.imcf073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf074
            #add-point:BEFORE FIELD imcf074 name="input.b.imcf074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf074
            
            #add-point:AFTER FIELD imcf074 name="input.a.imcf074"
            IF NOT cl_null(g_imcf_m.imcf074) THEN 
               IF g_imcf_m.imcf074 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf074
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf074) THEN 
                     LET g_imcf_m.imcf074 = g_imcf_m_t.imcf074
                  ELSE
                     LET g_imcf_m.imcf074 =0                  
                  END IF  
                  NEXT FIELD imcf074
               END IF             
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf074
            #add-point:ON CHANGE imcf074 name="input.g.imcf074"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf075
            #add-point:BEFORE FIELD imcf075 name="input.b.imcf075"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf075
            
            #add-point:AFTER FIELD imcf075 name="input.a.imcf075"
            IF NOT cl_null(g_imcf_m.imcf075) THEN
               IF g_imcf_m.imcf075 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf075
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf075) THEN 
                     LET g_imcf_m.imcf075 = g_imcf_m_t.imcf075
                  ELSE
                     LET g_imcf_m.imcf075 =0                  
                  END IF  
                  NEXT FIELD imcf075
               END IF                         
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf075
            #add-point:ON CHANGE imcf075 name="input.g.imcf075"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf081
            
            #add-point:AFTER FIELD imcf081 name="input.a.imcf081"
            DISPLAY '' TO imcf081_desc             
            IF NOT cl_null(g_imcf_m.imcf081)THEN
               CALL aimi105_imcf016_chk(g_imcf_m.imcf081)
               IF NOT cl_null(g_errno) THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf081
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_imcf_m.imcf081 = g_imcf_m_t.imcf081
                  CALL aimi105_imcf016_desc(g_imcf_m.imcf081) RETURNING g_imcf_m.imcf081_desc
                  DISPLAY g_imcf_m.imcf081_desc TO imcf081_desc                
                  NEXT FIELD imcf081
               END IF    
            END IF 
            CALL aimi105_imcf016_desc(g_imcf_m.imcf081) RETURNING g_imcf_m.imcf081_desc
            DISPLAY g_imcf_m.imcf081_desc TO imcf081_desc
           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf081
            #add-point:BEFORE FIELD imcf081 name="input.b.imcf081"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf081
            #add-point:ON CHANGE imcf081 name="input.g.imcf081"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf082
            #add-point:BEFORE FIELD imcf082 name="input.b.imcf082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf082
            
            #add-point:AFTER FIELD imcf082 name="input.a.imcf082"
            IF NOT cl_null(g_imcf_m.imcf082) THEN
               IF g_imcf_m.imcf082 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf082
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf082) THEN 
                     LET g_imcf_m.imcf082 = g_imcf_m_t.imcf082
                  ELSE
                     LET g_imcf_m.imcf082 =0                  
                  END IF  
                  NEXT FIELD imcf082
               END IF                         
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf082
            #add-point:ON CHANGE imcf082 name="input.g.imcf082"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf083
            #add-point:BEFORE FIELD imcf083 name="input.b.imcf083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf083
            
            #add-point:AFTER FIELD imcf083 name="input.a.imcf083"
            IF NOT cl_null(g_imcf_m.imcf083) THEN
               IF g_imcf_m.imcf083 < 0   THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_imcf_m.imcf083
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                   IF NOT cl_null(g_imcf_m_t.imcf083) THEN 
                     LET g_imcf_m.imcf083 = g_imcf_m_t.imcf083
                  ELSE
                     LET g_imcf_m.imcf083 =0                  
                  END IF  
                  NEXT FIELD imcf083
               END IF                         
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf083
            #add-point:ON CHANGE imcf083 name="input.g.imcf083"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf084
            #add-point:BEFORE FIELD imcf084 name="input.b.imcf084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf084
            
            #add-point:AFTER FIELD imcf084 name="input.a.imcf084"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf084
            #add-point:ON CHANGE imcf084 name="input.g.imcf084"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf085
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imcf_m.imcf085,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imcf085
            END IF 
 
 
 
            #add-point:AFTER FIELD imcf085 name="input.a.imcf085"
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf085
            #add-point:BEFORE FIELD imcf085 name="input.b.imcf085"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf085
            #add-point:ON CHANGE imcf085 name="input.g.imcf085"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf091
            #add-point:BEFORE FIELD imcf091 name="input.b.imcf091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf091
            
            #add-point:AFTER FIELD imcf091 name="input.a.imcf091"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf091
            #add-point:ON CHANGE imcf091 name="input.g.imcf091"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf092
            #add-point:BEFORE FIELD imcf092 name="input.b.imcf092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf092
            
            #add-point:AFTER FIELD imcf092 name="input.a.imcf092"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf092
            #add-point:ON CHANGE imcf092 name="input.g.imcf092"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf101
            
            #add-point:AFTER FIELD imcf101 name="input.a.imcf101"
            DISPLAY ' ' TO imcf101_desc 
            IF NOT cl_null(g_imcf_m.imcf101) THEN 
               CALL aimi105_imcf041_chk(g_imcf_m.imcf101)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf101
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aini001'
                  LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                  LET g_errparam.exeprog    ='aini001'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imcf_m.imcf101 = g_imcf_m_t.imcf101
                  CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf101) RETURNING g_imcf_m.imcf101_desc
                  DISPLAY g_imcf_m.imcf101_desc TO imcf101_desc                                   
                  NEXT FIELD imcf101
               END IF 
            END IF 
            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf101) RETURNING g_imcf_m.imcf101_desc
            DISPLAY g_imcf_m.imcf101_desc TO imcf101_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf101
            #add-point:BEFORE FIELD imcf101 name="input.b.imcf101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf101
            #add-point:ON CHANGE imcf101 name="input.g.imcf101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf102
            
            #add-point:AFTER FIELD imcf102 name="input.a.imcf102"
            DISPLAY '' TO imcf102_desc 
            #IF NOT cl_null(g_imcf_m.imcf102) AND NOT cl_null(g_imcf_m.imcf101) THEN 
            IF NOT cl_null(g_imcf_m.imcf102)  THEN 
               CALL aimi105_imcf042_chk(g_imcf_m.imcf101,g_imcf_m.imcf102)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf102
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aini002'
                  LET g_errparam.replace[2] = cl_get_progname('aini002',g_lang,"2")
                  LET g_errparam.exeprog    ='aini002'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_imcf_m.imcf102 = g_imcf_m_t.imcf102
                  CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf101,g_imcf_m.imcf102) 
                  RETURNING g_imcf_m.imcf102_desc
                  DISPLAY g_imcf_m.imcf102_desc TO imcf102_desc                  
                  NEXT FIELD imcf102
               END IF 
            END IF 
            
            CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf101,g_imcf_m.imcf102) RETURNING g_imcf_m.imcf102_desc
            DISPLAY g_imcf_m.imcf102_desc TO imcf102_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf102
            #add-point:BEFORE FIELD imcf102 name="input.b.imcf102"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf102
            #add-point:ON CHANGE imcf102 name="input.g.imcf102"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf103
            
            #add-point:AFTER FIELD imcf103 name="input.a.imcf103"
             DISPLAY '' TO imcf103_desc 
            IF NOT cl_null(g_imcf_m.imcf103) THEN 
               CALL aimi105_imcf041_chk(g_imcf_m.imcf103)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf103
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aini001'
                  LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                  LET g_errparam.exeprog    ='aini001'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imcf_m.imcf103 = g_imcf_m_t.imcf103
                  CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf103) RETURNING g_imcf_m.imcf103_desc
                  DISPLAY g_imcf_m.imcf103_desc TO imcf103_desc                  
                  NEXT FIELD imcf103
               END IF 
            END IF 

            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf103) RETURNING g_imcf_m.imcf103_desc
            DISPLAY g_imcf_m.imcf103_desc TO imcf103_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf103
            #add-point:BEFORE FIELD imcf103 name="input.b.imcf103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf103
            #add-point:ON CHANGE imcf103 name="input.g.imcf103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcf104
            
            #add-point:AFTER FIELD imcf104 name="input.a.imcf104"
            DISPLAY '' TO imcf104_desc                                   
            #IF NOT cl_null(g_imcf_m.imcf104) AND NOT cl_null(g_imcf_m.imcf103) THEN 
            IF NOT cl_null(g_imcf_m.imcf104) THEN 
               CALL aimi105_imcf042_chk(g_imcf_m.imcf103,g_imcf_m.imcf104)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imcf_m.imcf104
                  #160318-00005#20  --add--str
                  LET g_errparam.replace[1] ='aini002'
                  LET g_errparam.replace[2] = cl_get_progname('aini002',g_lang,"2")
                  LET g_errparam.exeprog    ='aini002'
                  #160318-00005#20 --add--end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_imcf_m.imcf104 = g_imcf_m_t.imcf104
                  CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf103,g_imcf_m.imcf104) RETURNING g_imcf_m.imcf102_desc
                  DISPLAY g_imcf_m.imcf104_desc TO imcf104_desc                 
                  NEXT FIELD imcf104
               END IF 
            END IF 
            CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf103,g_imcf_m.imcf104) RETURNING g_imcf_m.imcf102_desc
            DISPLAY g_imcf_m.imcf104_desc TO imcf104_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcf104
            #add-point:BEFORE FIELD imcf104 name="input.b.imcf104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcf104
            #add-point:ON CHANGE imcf104 name="input.g.imcf104"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imcfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfsite
            #add-point:ON ACTION controlp INFIELD imcfsite name="input.c.imcfsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf011
            #add-point:ON ACTION controlp INFIELD imcf011 name="input.c.imcf011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_imcf_m.imcf011  
            LET g_qryparam.arg1 = 204          
            CALL q_oocq002()                                       #呼叫開窗
            LET g_imcf_m.imcf011 = g_qryparam.return1
            #161013-00017#5 mod-S
            CALL aimi105_imcf011_desc(g_imcf_m.imcf011) 
#            RETURNING g_imcf_m.imcf011_desc
#            DISPLAY g_imcf_m.imcf011_desc TO imcf011_desc
            DISPLAY BY NAME g_imcf_m.oocql004
            DISPLAY BY NAME g_imcf_m.oocql005
            #161013-00017#5 mod-E
            DISPLAY g_qryparam.return1 TO imcf011  #顯示到畫面上
            LET g_qryparam.arg1 =''
            NEXT FIELD imcf011                     #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.oocql004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql004
            #add-point:ON ACTION controlp INFIELD oocql004 name="input.c.oocql004"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocql005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocql005
            #add-point:ON ACTION controlp INFIELD oocql005 name="input.c.oocql005"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf012
            #add-point:ON ACTION controlp INFIELD imcf012 name="input.c.imcf012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf012            #給予default值

            #給予arg

            IF g_site = 'ALL' THEN    #160811-00001
               CALL q_ooag001()       #160811-00001
            ELSE                      #160811-00001
               CALL q_ooag001_2()                           #呼叫開窗
            END IF                    #160811-00001                           
            LET g_imcf_m.imcf012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #160824-00002#1-s
            #CALL aimi105_imcf012_desc(g_imcf_m.imcf012) RETURNING g_imcf_m.imcf012_desc
            CALL s_desc_get_person_desc(g_imcf_m.imcf012) RETURNING g_imcf_m.imcf012_desc
            #160824-00002#1-e
            DISPLAY g_imcf_m.imcf012_desc TO imcf012_desc
            DISPLAY g_imcf_m.imcf012 TO imcf012              #顯示到畫面上

            NEXT FIELD imcf012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcfstus
            #add-point:ON ACTION controlp INFIELD imcfstus name="input.c.imcfstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf013
            #add-point:ON ACTION controlp INFIELD imcf013 name="input.c.imcf013"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf014
            #add-point:ON ACTION controlp INFIELD imcf014 name="input.c.imcf014"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf015
            #add-point:ON ACTION controlp INFIELD imcf015 name="input.c.imcf015"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf023
            #add-point:ON ACTION controlp INFIELD imcf023 name="input.c.imcf023"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf016
            #add-point:ON ACTION controlp INFIELD imcf016 name="input.c.imcf016"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf016             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imcf_m.imcf016 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf016_desc(g_imcf_m.imcf016) RETURNING g_imcf_m.imcf016_desc
            DISPLAY g_imcf_m.imcf016_desc TO imcf016_desc    
            DISPLAY g_imcf_m.imcf016 TO imcf016              #顯示到畫面上

            NEXT FIELD imcf016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf017
            #add-point:ON ACTION controlp INFIELD imcf017 name="input.c.imcf017"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf018
            #add-point:ON ACTION controlp INFIELD imcf018 name="input.c.imcf018"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf019
            #add-point:ON ACTION controlp INFIELD imcf019 name="input.c.imcf019"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf020
            #add-point:ON ACTION controlp INFIELD imcf020 name="input.c.imcf020"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf021
            #add-point:ON ACTION controlp INFIELD imcf021 name="input.c.imcf021"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf031
            #add-point:ON ACTION controlp INFIELD imcf031 name="input.c.imcf031"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf031             #給予default值

            #給予arg
            LET g_qryparam.where = "ooba001 = '",g_ooef004,"' AND oobx003 = 'asft300'" #參照表編號

            #160711-00040#14 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_sql1
            END IF
            #160711-00040#14 add(e)
            CALL q_ooba002()                                #呼叫開窗

            LET g_imcf_m.imcf031 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf031_desc(g_imcf_m.imcf031) RETURNING g_imcf_m.imcf031_desc
            DISPLAY g_imcf_m.imcf031_desc TO imcf031_desc  
            DISPLAY g_imcf_m.imcf031 TO imcf031              #顯示到畫面上
            LET g_qryparam.where =''
            NEXT FIELD imcf031                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf037
            #add-point:ON ACTION controlp INFIELD imcf037 name="input.c.imcf037"
#此段落由子樣板a07產生            
            #開窗i段
			   #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
			   #LET g_qryparam.reqry = FALSE
            #
            #LET g_qryparam.default1 = g_imcf_m.imcf037             #給予default值
            #
            ##給予arg
            #
            #CALL q_bmaa002()                                #呼叫開窗
            #
            #LET g_imcf_m.imcf037 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #
            #DISPLAY g_imcf_m.imcf037 TO imcf037              #顯示到畫面上
            #
            #NEXT FIELD imcf037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf032
            #add-point:ON ACTION controlp INFIELD imcf032 name="input.c.imcf032"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf032             #給予default值

            #給予arg
            CALL q_imaf001_15()                                #呼叫開窗
            LET g_imcf_m.imcf032 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #CALL aimi105_ecba002_ecba003()
            #DISPLAY BY NAME g_imcf_m.imcf033,g_imcf_m.imcf033_desc
            CALL aimi105_imcf032_desc(g_imcf_m.imcf032) RETURNING g_imcf_m.imcf032_desc
            DISPLAY g_imcf_m.imcf032_desc TO imcf032_desc  
            DISPLAY g_imcf_m.imcf032 TO imcf032              #顯示到畫面上
            LET g_qryparam.where =''
            NEXT FIELD imcf032                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.imcf033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf033
            #add-point:ON ACTION controlp INFIELD imcf033 name="input.c.imcf033"
            
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.default1 = g_imcf_m.imcf033             #給予default值
            ##給予arg
            #LET g_qryparam.where = "ecba001= '",g_imcf_m.imcf032,"'"
            #CALL q_ecba002()                                #呼叫開窗
            #LET g_imcf_m.imcf033 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #CALL aimi105_imcf033_desc(g_imcf_m.imcf033) RETURNING g_imcf_m.imcf033_desc
            #DISPLAY g_imcf_m.imcf033_desc TO imcf033_desc
            #DISPLAY g_imcf_m.imcf033 TO imcf033              #顯示到畫面上
            #LET g_qryparam.where =''
            #NEXT FIELD imcf033                         #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.imcf034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf034
            #add-point:ON ACTION controlp INFIELD imcf034 name="input.c.imcf034"
#此段落由子樣板a07產生            
            #開窗i段
            MENU "" ATTRIBUTE (STYLE="popup", IMAGE="question")
             ON ACTION dept    #部门
               LET g_flag = 0
               EXIT MENU

             ON ACTION firm     #厂商
               LET g_flag = 1
               EXIT MENU
            END MENU
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_imcf_m.imcf034             #給予default值
    
            #給予arg
            IF g_flag <>1 THEN
               LET g_qryparam.arg1 = g_today
               CALL q_ooeg001()                                #呼叫開窗
            ELSE
               #LET g_qryparam.where = "pmaa002 IN ('1','3')"  #160913-00055#1
               CALL q_pmaa001() 
               LET g_qryparam.where =""
            END IF 
            LET g_imcf_m.imcf034 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #预设成本中心
            CALL aimi105_imcf034_desc(g_imcf_m.imcf034) RETURNING g_imcf_m.imcf034_desc
            DISPLAY g_imcf_m.imcf034_desc TO imcf034_desc       
            DISPLAY g_imcf_m.imcf034 TO imcf034              #顯示到畫面上
    
            NEXT FIELD imcf034                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf035
            #add-point:ON ACTION controlp INFIELD imcf035 name="input.c.imcf035"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf035             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = "ooeg003 = '3'"
            CALL q_ooeg001()                                 #呼叫開窗
            LET g_qryparam.where = ""
            LET g_qryparam.arg1=""            
            LET g_imcf_m.imcf035 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #预设成本中心
            CALL aimi105_imcf034_desc(g_imcf_m.imcf035) RETURNING g_imcf_m.imcf035_desc
            DISPLAY g_imcf_m.imcf035_desc TO imcf035_desc       
            DISPLAY g_imcf_m.imcf035 TO imcf035              #顯示到畫面上
            LET g_qryparam.where =''
            NEXT FIELD imcf035                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf022
            #add-point:ON ACTION controlp INFIELD imcf022 name="input.c.imcf022"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf036
            #add-point:ON ACTION controlp INFIELD imcf036 name="input.c.imcf036"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf041
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf041
            #add-point:ON ACTION controlp INFIELD imcf041 name="input.c.imcf041"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf041             #給予default值

            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inaa001_4()
            LET g_qryparam.arg1 = ''

            LET g_imcf_m.imcf041 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf041) RETURNING g_imcf_m.imcf041_desc
            DISPLAY g_imcf_m.imcf041_desc TO imcf041_desc           
            DISPLAY g_imcf_m.imcf041 TO imcf041              #顯示到畫面上

            NEXT FIELD imcf041                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf042
            #add-point:ON ACTION controlp INFIELD imcf042 name="input.c.imcf042"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_imcf_m.imcf042             #給予default值

            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            LET g_qryparam.arg2 = g_imcf_m.imcf041
            CALL q_inab002_8()
            LET g_qryparam.arg1 = ''
            LET g_qryparam.arg2 = ''

            LET g_imcf_m.imcf042 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf041,g_imcf_m.imcf042) 
            RETURNING g_imcf_m.imcf042_desc
            DISPLAY g_imcf_m.imcf042 TO imcf042              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imcf042                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf051
            #add-point:ON ACTION controlp INFIELD imcf051 name="input.c.imcf051"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf052
            #add-point:ON ACTION controlp INFIELD imcf052 name="input.c.imcf052"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf062
            #add-point:ON ACTION controlp INFIELD imcf062 name="input.c.imcf062"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf064
            #add-point:ON ACTION controlp INFIELD imcf064 name="input.c.imcf064"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf077
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf077
            #add-point:ON ACTION controlp INFIELD imcf077 name="input.c.imcf077"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf078
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf078
            #add-point:ON ACTION controlp INFIELD imcf078 name="input.c.imcf078"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf079
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf079
            #add-point:ON ACTION controlp INFIELD imcf079 name="input.c.imcf079"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf080
            #add-point:ON ACTION controlp INFIELD imcf080 name="input.c.imcf080"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf086
            #add-point:ON ACTION controlp INFIELD imcf086 name="input.c.imcf086"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf071
            #add-point:ON ACTION controlp INFIELD imcf071 name="input.c.imcf071"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf072
            #add-point:ON ACTION controlp INFIELD imcf072 name="input.c.imcf072"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf073
            #add-point:ON ACTION controlp INFIELD imcf073 name="input.c.imcf073"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf074
            #add-point:ON ACTION controlp INFIELD imcf074 name="input.c.imcf074"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf075
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf075
            #add-point:ON ACTION controlp INFIELD imcf075 name="input.c.imcf075"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf081
            #add-point:ON ACTION controlp INFIELD imcf081 name="input.c.imcf081"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf081             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imcf_m.imcf081 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf016_desc(g_imcf_m.imcf081) RETURNING g_imcf_m.imcf081_desc
            DISPLAY g_imcf_m.imcf081_desc TO imcf081_desc    
            DISPLAY g_imcf_m.imcf081 TO imcf081              #顯示到畫面上

            NEXT FIELD imcf081                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf082
            #add-point:ON ACTION controlp INFIELD imcf082 name="input.c.imcf082"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf083
            #add-point:ON ACTION controlp INFIELD imcf083 name="input.c.imcf083"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf084
            #add-point:ON ACTION controlp INFIELD imcf084 name="input.c.imcf084"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf085
            #add-point:ON ACTION controlp INFIELD imcf085 name="input.c.imcf085"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf091
            #add-point:ON ACTION controlp INFIELD imcf091 name="input.c.imcf091"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf092
            #add-point:ON ACTION controlp INFIELD imcf092 name="input.c.imcf092"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcf101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf101
            #add-point:ON ACTION controlp INFIELD imcf101 name="input.c.imcf101"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf101             #給予default值

            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inaa001_4()
            LET g_qryparam.arg1 = ''
            LET g_imcf_m.imcf101 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf101) RETURNING g_imcf_m.imcf101_desc
            DISPLAY g_imcf_m.imcf101_desc TO imcf101_desc           
            DISPLAY g_imcf_m.imcf101 TO imcf101              #顯示到畫面上

            NEXT FIELD imcf101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf102
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf102
            #add-point:ON ACTION controlp INFIELD imcf102 name="input.c.imcf102"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf102             #給予default值

            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            LET g_qryparam.arg2 = g_imcf_m.imcf101
            CALL q_inab002_8()
            LET g_qryparam.arg1 = ''
            LET g_qryparam.arg2 = ''

            LET g_imcf_m.imcf102 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf101,g_imcf_m.imcf102) 
            RETURNING g_imcf_m.imcf102_desc
            DISPLAY g_imcf_m.imcf102 TO imcf102              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imcf102                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf103
            #add-point:ON ACTION controlp INFIELD imcf103 name="input.c.imcf103"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf103             #給予default值

            #給予arg

            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            CALL q_inaa001_4()
            LET g_qryparam.arg1 = ''

            LET g_imcf_m.imcf103 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf103) RETURNING g_imcf_m.imcf103_desc
            DISPLAY g_imcf_m.imcf103_desc TO imcf103_desc           
            DISPLAY g_imcf_m.imcf103 TO imcf103              #顯示到畫面上

            NEXT FIELD imcf103                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcf104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcf104
            #add-point:ON ACTION controlp INFIELD imcf104 name="input.c.imcf104"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'

            LET g_qryparam.default1 = g_imcf_m.imcf104             #給予default值

            #給予arg
            IF g_site = 'ALL' THEN
               LET g_qryparam.arg1 = g_site_t                         #呼叫開窗
            ELSE   
               LET g_qryparam.arg1 = g_site                             #呼叫開窗
            END IF
            LET g_qryparam.arg2 = g_imcf_m.imcf103
            CALL q_inab002_8()
            LET g_qryparam.arg1 = ''
            LET g_qryparam.arg2 = ''
            LET g_imcf_m.imcf104 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf103,g_imcf_m.imcf104) 
            RETURNING g_imcf_m.imcf104_desc
            DISPLAY g_imcf_m.imcf104 TO imcf104              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imcf104                          #返回原欄位


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
               SELECT COUNT(1) INTO l_count FROM imcf_t
                WHERE imcfent = g_enterprise AND imcfsite = g_imcf_m.imcfsite
                  AND imcf011 = g_imcf_m.imcf011
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO imcf_t (imcfent,imcfsite,imcf011,imcf012,imcfstus,imcfownid,imcfowndp, 
                      imcfcrtid,imcfcrtdp,imcfcrtdt,imcfmodid,imcfmoddt,imcf013,imcf014,imcf015,imcf023, 
                      imcf016,imcf017,imcf018,imcf019,imcf020,imcf021,imcf031,imcf037,imcf032,imcf033, 
                      imcf034,imcf035,imcf022,imcf036,imcf041,imcf042,imcf051,imcf052,imcf062,imcf064, 
                      imcf077,imcf078,imcf079,imcf080,imcf086,imcf071,imcf072,imcf073,imcf074,imcf075, 
                      imcf081,imcf082,imcf083,imcf084,imcf085,imcf091,imcf092,imcf101,imcf102,imcf103, 
                      imcf104)
                  VALUES (g_enterprise,g_imcf_m.imcfsite,g_imcf_m.imcf011,g_imcf_m.imcf012,g_imcf_m.imcfstus, 
                      g_imcf_m.imcfownid,g_imcf_m.imcfowndp,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtdp,g_imcf_m.imcfcrtdt, 
                      g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt,g_imcf_m.imcf013,g_imcf_m.imcf014,g_imcf_m.imcf015, 
                      g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf017,g_imcf_m.imcf018,g_imcf_m.imcf019, 
                      g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf037,g_imcf_m.imcf032, 
                      g_imcf_m.imcf033,g_imcf_m.imcf034,g_imcf_m.imcf035,g_imcf_m.imcf022,g_imcf_m.imcf036, 
                      g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051,g_imcf_m.imcf052,g_imcf_m.imcf062, 
                      g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079,g_imcf_m.imcf080, 
                      g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074, 
                      g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf082,g_imcf_m.imcf083,g_imcf_m.imcf084, 
                      g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf102, 
                      g_imcf_m.imcf103,g_imcf_m.imcf104) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  #161013-00017#5 add-S
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_count = 1
                  SELECT COUNT(1) INTO l_count FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '204' AND oocq002 = g_imcf_m.imcf011
                  IF l_count = 0 THEN #新增分类码及说明
                     INSERT INTO oocq_t (oocqent,oocqstus,oocq001,oocq002,oocq003)
                     VALUES (g_enterprise,'Y','204',g_imcf_m.imcf011,'204')
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "oocq_t:",SQLERRMESSAGE 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET SQLCA.sqlcode = NULL
                  #161013-00017#5 add-E
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcf_t:",SQLERRMESSAGE 
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
         IF '204' = g_master_multi_table_t.oocql001 AND
         g_imcf_m.imcf011 = g_master_multi_table_t.oocql002 AND
         g_imcf_m.oocql004 = g_master_multi_table_t.oocql004 AND 
         g_imcf_m.oocql005 = g_master_multi_table_t.oocql005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '204'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_imcf_m.imcf011
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_imcf_m.oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_imcf_m.oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_imcf_m.imcfsite
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aimi105_imcf_t_mask_restore('restore_mask_o')
               
               UPDATE imcf_t SET (imcfsite,imcf011,imcf012,imcfstus,imcfownid,imcfowndp,imcfcrtid,imcfcrtdp, 
                   imcfcrtdt,imcfmodid,imcfmoddt,imcf013,imcf014,imcf015,imcf023,imcf016,imcf017,imcf018, 
                   imcf019,imcf020,imcf021,imcf031,imcf037,imcf032,imcf033,imcf034,imcf035,imcf022,imcf036, 
                   imcf041,imcf042,imcf051,imcf052,imcf062,imcf064,imcf077,imcf078,imcf079,imcf080,imcf086, 
                   imcf071,imcf072,imcf073,imcf074,imcf075,imcf081,imcf082,imcf083,imcf084,imcf085,imcf091, 
                   imcf092,imcf101,imcf102,imcf103,imcf104) = (g_imcf_m.imcfsite,g_imcf_m.imcf011,g_imcf_m.imcf012, 
                   g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfowndp,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtdp, 
                   g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt,g_imcf_m.imcf013,g_imcf_m.imcf014, 
                   g_imcf_m.imcf015,g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf017,g_imcf_m.imcf018, 
                   g_imcf_m.imcf019,g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf037, 
                   g_imcf_m.imcf032,g_imcf_m.imcf033,g_imcf_m.imcf034,g_imcf_m.imcf035,g_imcf_m.imcf022, 
                   g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051,g_imcf_m.imcf052, 
                   g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079, 
                   g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073, 
                   g_imcf_m.imcf074,g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf082,g_imcf_m.imcf083, 
                   g_imcf_m.imcf084,g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101, 
                   g_imcf_m.imcf102,g_imcf_m.imcf103,g_imcf_m.imcf104)
                WHERE imcfent = g_enterprise AND imcfsite = g_imcfsite_t #
                  AND imcf011 = g_imcf011_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcf_t:",SQLERRMESSAGE 
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
         IF '204' = g_master_multi_table_t.oocql001 AND
         g_imcf_m.imcf011 = g_master_multi_table_t.oocql002 AND
         g_imcf_m.oocql004 = g_master_multi_table_t.oocql004 AND 
         g_imcf_m.oocql005 = g_master_multi_table_t.oocql005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '204'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_imcf_m.imcf011
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_imcf_m.oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_imcf_m.oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL aimi105_imcf_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_imcf_m_t)
                     LET g_log2 = util.JSON.stringify(g_imcf_m)
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
 
{<section id="aimi105.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimi105_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE imcf_t.imcfsite 
   DEFINE l_oldno     LIKE imcf_t.imcfsite 
   DEFINE l_newno02     LIKE imcf_t.imcf011 
   DEFINE l_oldno02     LIKE imcf_t.imcf011 
 
   DEFINE l_master    RECORD LIKE imcf_t.* #此變數樣板目前無使用
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
   IF g_imcf_m.imcfsite IS NULL
      OR g_imcf_m.imcf011 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_imcfsite_t = g_imcf_m.imcfsite
   LET g_imcf011_t = g_imcf_m.imcf011
 
   
   #清空key值
   LET g_imcf_m.imcfsite = ""
   LET g_imcf_m.imcf011 = ""
 
    
   CALL aimi105_set_entry("a")
   CALL aimi105_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imcf_m.imcfownid = g_user
      LET g_imcf_m.imcfowndp = g_dept
      LET g_imcf_m.imcfcrtid = g_user
      LET g_imcf_m.imcfcrtdp = g_dept 
      LET g_imcf_m.imcfcrtdt = cl_get_current()
      LET g_imcf_m.imcfmodid = g_user
      LET g_imcf_m.imcfmoddt = cl_get_current()
      LET g_imcf_m.imcfstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_imcf_m.imcfsite = g_site
   
   #161013-00017#5 mod-S
#   LET g_imcf_m.imcf011_desc = ''
#   DISPLAY BY NAME g_imcf_m.imcf011_desc
   LET g_imcf_m.oocql004 = ''
   LET g_imcf_m.oocql005 = ''
   DISPLAY BY NAME g_imcf_m.oocql004
   DISPLAY BY NAME g_imcf_m.oocql005
   #161013-00017#5 mod-E
   
   LET g_imcf_m.imcfstus = "Y"
   CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcf_m.imcfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aimi105_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_imcf_m.* TO NULL
      CALL aimi105_show()
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
      LET g_errparam.extend = "imcf_t:",SQLERRMESSAGE 
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
   CALL aimi105_set_act_visible()
   CALL aimi105_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imcfsite_t = g_imcf_m.imcfsite
   LET g_imcf011_t = g_imcf_m.imcf011
 
   
   #組合新增資料的條件
   LET g_add_browse = " imcfent = " ||g_enterprise|| " AND",
                      " imcfsite = '", g_imcf_m.imcfsite, "' "
                      ," AND imcf011 = '", g_imcf_m.imcf011, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi105_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_imcf_m.imcfownid      
   LET g_data_dept  = g_imcf_m.imcfowndp
              
   #功能已完成,通報訊息中心
   CALL aimi105_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aimi105.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aimi105_show()
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
   CALL aimi105_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            #生產分群說明
            #161013-00017#5 mod-S
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_imcf_m.imcf011
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='204' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imcf_m.imcf011_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imcf_m.imcf011_desc
            
            CALL aimi105_imcf011_desc(g_imcf_m.imcf011)
            DISPLAY BY NAME g_imcf_m.oocql004
            DISPLAY BY NAME g_imcf_m.oocql005
            #161013-00017#5 mod-E
            #抓取計劃員全稱
            #160824-00002#1-s
            #CALL aimi105_imcf012_desc(g_imcf_m.imcf012) RETURNING g_imcf_m.imcf012_desc
            CALL s_desc_get_person_desc(g_imcf_m.imcf012) RETURNING g_imcf_m.imcf012_desc
            #160824-00002#1-e
            DISPLAY BY NAME g_imcf_m.imcf012_desc
              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcf_m.imcfownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcf_m.imcfownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcf_m.imcfownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcf_m.imcfowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcf_m.imcfowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcf_m.imcfowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcf_m.imcfcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcf_m.imcfcrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcf_m.imcfcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcf_m.imcfcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcf_m.imcfcrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcf_m.imcfcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcf_m.imcfmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcf_m.imcfmodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcf_m.imcfmodid_desc
            #單位說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcf_m.imcf016
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcf_m.imcf016_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcf_m.imcf016_desc
            #单据说明
            CALL aimi105_imcf031_desc(g_imcf_m.imcf031) RETURNING g_imcf_m.imcf031_desc
            DISPLAY BY NAME g_imcf_m.imcf031_desc
            #制程料号
            CALL aimi105_imcf032_desc(g_imcf_m.imcf032) RETURNING g_imcf_m.imcf032_desc
            DISPLAY BY NAME g_imcf_m.imcf032_desc
            #制程编号
            CALL aimi105_imcf033_desc(g_imcf_m.imcf033) RETURNING g_imcf_m.imcf033_desc
            DISPLAY BY NAME g_imcf_m.imcf033_desc
            #預設部門/廠商
            CALL aimi105_imcf034_desc(g_imcf_m.imcf034) RETURNING g_imcf_m.imcf034_desc
            DISPLAY BY NAME g_imcf_m.imcf034_desc
            #預設成本中心
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcf_m.imcf035
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcf_m.imcf035_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcf_m.imcf035_desc
            #庫位說明
            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf041) RETURNING g_imcf_m.imcf041_desc
            DISPLAY BY NAME g_imcf_m.imcf041_desc
            
            #倉儲說明
            CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf041,g_imcf_m.imcf042) 
            RETURNING g_imcf_m.imcf042_desc
            DISPLAY BY NAME g_imcf_m.imcf042_desc
            
            #發料單位說明
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcf_m.imcf081
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcf_m.imcf081_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcf_m.imcf081_desc
            
            #預設發料庫位說明
            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf101) RETURNING g_imcf_m.imcf101_desc
            DISPLAY BY NAME g_imcf_m.imcf101_desc
            
            #預設發料倉儲說明
            CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf101,g_imcf_m.imcf102) 
            RETURNING g_imcf_m.imcf102_desc
            DISPLAY BY NAME g_imcf_m.imcf102_desc
            
            #預設退料庫位說明
            CALL aimi105_imcf041_desc(g_imcf_m.imcfsite,g_imcf_m.imcf103) RETURNING g_imcf_m.imcf103_desc
            DISPLAY BY NAME g_imcf_m.imcf103_desc
            
            #預設退料倉儲說明
            CALL aimi105_imcf042_desc(g_imcf_m.imcfsite,g_imcf_m.imcf103,g_imcf_m.imcf104) 
            RETURNING g_imcf_m.imcf104_desc
            DISPLAY BY NAME g_imcf_m.imcf104_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imcf_m.imcfsite,g_imcf_m.imcf011,g_imcf_m.oocql004,g_imcf_m.oocql005,g_imcf_m.imcf012, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp, 
       g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtid_desc,g_imcf_m.imcfcrtdp,g_imcf_m.imcfcrtdp_desc, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmodid_desc,g_imcf_m.imcfmoddt,g_imcf_m.imcf013, 
       g_imcf_m.imcf014,g_imcf_m.imcf015,g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf016_desc,g_imcf_m.imcf017, 
       g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf031_desc, 
       g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf032_desc,g_imcf_m.imcf033,g_imcf_m.imcf033_desc, 
       g_imcf_m.imcf034,g_imcf_m.imcf034_desc,g_imcf_m.imcf035,g_imcf_m.imcf035_desc,g_imcf_m.imcf022, 
       g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf041_desc,g_imcf_m.imcf042,g_imcf_m.imcf042_desc, 
       g_imcf_m.imcf051,g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078, 
       g_imcf_m.imcf079,g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073, 
       g_imcf_m.imcf074,g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf081_desc,g_imcf_m.imcf082,g_imcf_m.imcf083, 
       g_imcf_m.imcf084,g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf101_desc, 
       g_imcf_m.imcf102,g_imcf_m.imcf102_desc,g_imcf_m.imcf103,g_imcf_m.imcf103_desc,g_imcf_m.imcf104, 
       g_imcf_m.imcf104_desc
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aimi105_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcf_m.imcfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimi105.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aimi105_delete()
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
   IF g_imcf_m.imcfsite IS NULL
   OR g_imcf_m.imcf011 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_imcfsite_t = g_imcf_m.imcfsite
   LET g_imcf011_t = g_imcf_m.imcf011
 
   
   LET g_master_multi_table_t.oocql001 = '204'
LET g_master_multi_table_t.oocql002 = g_imcf_m.imcf011
LET g_master_multi_table_t.oocql004 = g_imcf_m.oocql004
LET g_master_multi_table_t.oocql005 = g_imcf_m.oocql005
 
 
   OPEN aimi105_cl USING g_enterprise,g_imcf_m.imcfsite,g_imcf_m.imcf011
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi105_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimi105_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi105_master_referesh USING g_imcf_m.imcfsite,g_imcf_m.imcf011 INTO g_imcf_m.imcfsite,g_imcf_m.imcf011, 
       g_imcf_m.imcf012,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfowndp,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtdp, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt,g_imcf_m.imcf013,g_imcf_m.imcf014,g_imcf_m.imcf015, 
       g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf017,g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020, 
       g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf033,g_imcf_m.imcf034, 
       g_imcf_m.imcf035,g_imcf_m.imcf022,g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051, 
       g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079, 
       g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074, 
       g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf082,g_imcf_m.imcf083,g_imcf_m.imcf084,g_imcf_m.imcf085, 
       g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf102,g_imcf_m.imcf103,g_imcf_m.imcf104, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid_desc, 
       g_imcf_m.imcfcrtdp_desc,g_imcf_m.imcfmodid_desc,g_imcf_m.imcf016_desc,g_imcf_m.imcf031_desc,g_imcf_m.imcf032_desc, 
       g_imcf_m.imcf034_desc,g_imcf_m.imcf035_desc,g_imcf_m.imcf081_desc
   
   
   #檢查是否允許此動作
   IF NOT aimi105_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imcf_m_mask_o.* =  g_imcf_m.*
   CALL aimi105_imcf_t_mask()
   LET g_imcf_m_mask_n.* =  g_imcf_m.*
   
   #將最新資料顯示到畫面上
   CALL aimi105_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimi105_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM imcf_t 
       WHERE imcfent = g_enterprise AND imcfsite = g_imcf_m.imcfsite 
         AND imcf011 = g_imcf_m.imcf011 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      #161013-00017#5 add-S
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcf_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      CLEAR FORM
      CALL aimi105_ui_browser_refresh1()
      IF g_browser_cnt > 0 THEN
         CALL aimi105_fetch("P")
      ELSE
         CALL aimi105_browser_fill(" 1=1 ","F")
      END IF
      
   END IF
 
   CLOSE aimi105_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_imcf_m.imcfsite,"D")
   RETURN
      #161013-00017#5 add-E
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
  
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'oocqlent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
   LET l_field_keys[02] = 'oocql001'
   LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
   LET l_field_keys[03] = 'oocql002'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'oocql_t')
 
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      CLEAR FORM
      CALL aimi105_ui_browser_refresh1()
      IF g_browser_cnt > 0 THEN
         CALL aimi105_fetch("P")
      ELSE
         CALL aimi105_browser_fill(" 1=1 ","F")
      END IF
      
#   END IF   #161013-00017#5 marked    #多语言不用删除
 
   CLOSE aimi105_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_imcf_m.imcfsite,"D")
   RETURN
   #該段一下不會走，因為aimi105_ui_browser_refresh里用site作為區分的值來刷新數組有問題
   IF cl_ask_delete() THEN
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imcf_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aimi105_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aimi105_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aimi105_browser_fill(g_wc,"")
         CALL aimi105_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimi105_cl
 
   #功能已完成,通報訊息中心
   CALL aimi105_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimi105.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimi105_ui_browser_refresh()
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
      IF g_browser[l_i].b_imcfsite = g_imcf_m.imcfsite
         AND g_browser[l_i].b_imcf011 = g_imcf_m.imcf011
 
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
 
{<section id="aimi105.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimi105_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("imcfsite,imcf011",TRUE)
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
 
{<section id="aimi105.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimi105_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imcfsite,imcf011",FALSE)
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
 
{<section id="aimi105.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimi105_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi105.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimi105_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi105.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimi105_default_search()
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
      LET ls_wc = ls_wc, " imcfsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " imcf011 = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc =  " imcf011 = '", g_argv[02], "' AND "
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
      LET g_wc = g_wc , " AND imcfsite = '", g_argv[01], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi105.mask_functions" >}
&include "erp/aim/aimi105_mask.4gl"
 
{</section>}
 
{<section id="aimi105.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aimi105_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imcf_m.imcfsite IS NULL
      OR g_imcf_m.imcf011 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aimi105_cl USING g_enterprise,g_imcf_m.imcfsite,g_imcf_m.imcf011
   IF STATUS THEN
      CLOSE aimi105_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi105_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aimi105_master_referesh USING g_imcf_m.imcfsite,g_imcf_m.imcf011 INTO g_imcf_m.imcfsite,g_imcf_m.imcf011, 
       g_imcf_m.imcf012,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfowndp,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtdp, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt,g_imcf_m.imcf013,g_imcf_m.imcf014,g_imcf_m.imcf015, 
       g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf017,g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020, 
       g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf033,g_imcf_m.imcf034, 
       g_imcf_m.imcf035,g_imcf_m.imcf022,g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051, 
       g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079, 
       g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074, 
       g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf082,g_imcf_m.imcf083,g_imcf_m.imcf084,g_imcf_m.imcf085, 
       g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf102,g_imcf_m.imcf103,g_imcf_m.imcf104, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid_desc, 
       g_imcf_m.imcfcrtdp_desc,g_imcf_m.imcfmodid_desc,g_imcf_m.imcf016_desc,g_imcf_m.imcf031_desc,g_imcf_m.imcf032_desc, 
       g_imcf_m.imcf034_desc,g_imcf_m.imcf035_desc,g_imcf_m.imcf081_desc
   
 
   #檢查是否允許此動作
   IF NOT aimi105_action_chk() THEN
      CLOSE aimi105_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imcf_m.imcfsite,g_imcf_m.imcf011,g_imcf_m.oocql004,g_imcf_m.oocql005,g_imcf_m.imcf012, 
       g_imcf_m.imcf012_desc,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp, 
       g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtid_desc,g_imcf_m.imcfcrtdp,g_imcf_m.imcfcrtdp_desc, 
       g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmodid_desc,g_imcf_m.imcfmoddt,g_imcf_m.imcf013, 
       g_imcf_m.imcf014,g_imcf_m.imcf015,g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf016_desc,g_imcf_m.imcf017, 
       g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf031_desc, 
       g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf032_desc,g_imcf_m.imcf033,g_imcf_m.imcf033_desc, 
       g_imcf_m.imcf034,g_imcf_m.imcf034_desc,g_imcf_m.imcf035,g_imcf_m.imcf035_desc,g_imcf_m.imcf022, 
       g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf041_desc,g_imcf_m.imcf042,g_imcf_m.imcf042_desc, 
       g_imcf_m.imcf051,g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064,g_imcf_m.imcf077,g_imcf_m.imcf078, 
       g_imcf_m.imcf079,g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071,g_imcf_m.imcf072,g_imcf_m.imcf073, 
       g_imcf_m.imcf074,g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf081_desc,g_imcf_m.imcf082,g_imcf_m.imcf083, 
       g_imcf_m.imcf084,g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101,g_imcf_m.imcf101_desc, 
       g_imcf_m.imcf102,g_imcf_m.imcf102_desc,g_imcf_m.imcf103,g_imcf_m.imcf103_desc,g_imcf_m.imcf104, 
       g_imcf_m.imcf104_desc
 
   CASE g_imcf_m.imcfstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_imcf_m.imcfstus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_imcf_m.imcfstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aimi105_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_imcf_m.imcfmodid = g_user
   LET g_imcf_m.imcfmoddt = cl_get_current()
   LET g_imcf_m.imcfstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imcf_t 
      SET (imcfstus,imcfmodid,imcfmoddt) 
        = (g_imcf_m.imcfstus,g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt)     
    WHERE imcfent = g_enterprise AND imcfsite = g_imcf_m.imcfsite
      AND imcf011 = g_imcf_m.imcf011
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aimi105_master_referesh USING g_imcf_m.imcfsite,g_imcf_m.imcf011 INTO g_imcf_m.imcfsite, 
          g_imcf_m.imcf011,g_imcf_m.imcf012,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfowndp, 
          g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtdp,g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmoddt, 
          g_imcf_m.imcf013,g_imcf_m.imcf014,g_imcf_m.imcf015,g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf017, 
          g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031,g_imcf_m.imcf037, 
          g_imcf_m.imcf032,g_imcf_m.imcf033,g_imcf_m.imcf034,g_imcf_m.imcf035,g_imcf_m.imcf022,g_imcf_m.imcf036, 
          g_imcf_m.imcf041,g_imcf_m.imcf042,g_imcf_m.imcf051,g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064, 
          g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079,g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071, 
          g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074,g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf082, 
          g_imcf_m.imcf083,g_imcf_m.imcf084,g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092,g_imcf_m.imcf101, 
          g_imcf_m.imcf102,g_imcf_m.imcf103,g_imcf_m.imcf104,g_imcf_m.imcf012_desc,g_imcf_m.imcfownid_desc, 
          g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid_desc,g_imcf_m.imcfcrtdp_desc,g_imcf_m.imcfmodid_desc, 
          g_imcf_m.imcf016_desc,g_imcf_m.imcf031_desc,g_imcf_m.imcf032_desc,g_imcf_m.imcf034_desc,g_imcf_m.imcf035_desc, 
          g_imcf_m.imcf081_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imcf_m.imcfsite,g_imcf_m.imcf011,g_imcf_m.oocql004,g_imcf_m.oocql005,g_imcf_m.imcf012, 
          g_imcf_m.imcf012_desc,g_imcf_m.imcfstus,g_imcf_m.imcfownid,g_imcf_m.imcfownid_desc,g_imcf_m.imcfowndp, 
          g_imcf_m.imcfowndp_desc,g_imcf_m.imcfcrtid,g_imcf_m.imcfcrtid_desc,g_imcf_m.imcfcrtdp,g_imcf_m.imcfcrtdp_desc, 
          g_imcf_m.imcfcrtdt,g_imcf_m.imcfmodid,g_imcf_m.imcfmodid_desc,g_imcf_m.imcfmoddt,g_imcf_m.imcf013, 
          g_imcf_m.imcf014,g_imcf_m.imcf015,g_imcf_m.imcf023,g_imcf_m.imcf016,g_imcf_m.imcf016_desc, 
          g_imcf_m.imcf017,g_imcf_m.imcf018,g_imcf_m.imcf019,g_imcf_m.imcf020,g_imcf_m.imcf021,g_imcf_m.imcf031, 
          g_imcf_m.imcf031_desc,g_imcf_m.imcf037,g_imcf_m.imcf032,g_imcf_m.imcf032_desc,g_imcf_m.imcf033, 
          g_imcf_m.imcf033_desc,g_imcf_m.imcf034,g_imcf_m.imcf034_desc,g_imcf_m.imcf035,g_imcf_m.imcf035_desc, 
          g_imcf_m.imcf022,g_imcf_m.imcf036,g_imcf_m.imcf041,g_imcf_m.imcf041_desc,g_imcf_m.imcf042, 
          g_imcf_m.imcf042_desc,g_imcf_m.imcf051,g_imcf_m.imcf052,g_imcf_m.imcf062,g_imcf_m.imcf064, 
          g_imcf_m.imcf077,g_imcf_m.imcf078,g_imcf_m.imcf079,g_imcf_m.imcf080,g_imcf_m.imcf086,g_imcf_m.imcf071, 
          g_imcf_m.imcf072,g_imcf_m.imcf073,g_imcf_m.imcf074,g_imcf_m.imcf075,g_imcf_m.imcf081,g_imcf_m.imcf081_desc, 
          g_imcf_m.imcf082,g_imcf_m.imcf083,g_imcf_m.imcf084,g_imcf_m.imcf085,g_imcf_m.imcf091,g_imcf_m.imcf092, 
          g_imcf_m.imcf101,g_imcf_m.imcf101_desc,g_imcf_m.imcf102,g_imcf_m.imcf102_desc,g_imcf_m.imcf103, 
          g_imcf_m.imcf103_desc,g_imcf_m.imcf104,g_imcf_m.imcf104_desc
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aimi105_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi105_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi105.signature" >}
   
 
{</section>}
 
{<section id="aimi105.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimi105_set_pk_array()
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
   LET g_pk_array[1].values = g_imcf_m.imcfsite
   LET g_pk_array[1].column = 'imcfsite'
   LET g_pk_array[2].values = g_imcf_m.imcf011
   LET g_pk_array[2].column = 'imcf011'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi105.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aimi105.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimi105_msgcentre_notify(lc_state)
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
   CALL aimi105_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imcf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi105.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimi105_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi105.other_function" readonly="Y" >}
#生管分群说明
PRIVATE FUNCTION aimi105_imcf011_desc(p_imcf011)
   DEFINE p_imcf011      LIKE imcf_t.imcf011
    
    #161013-00017#5 mod-S
#    INITIALIZE g_ref_fields TO NULL
#    LET g_ref_fields[1] = p_imcf011
#    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='204' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#    RETURN g_rtn_fields[1]
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = '204'
    LET g_ref_fields[2] = g_imcf_m.imcf011
    CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
        ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_imcf_m.oocql004 = g_rtn_fields[1]
    LET g_imcf_m.oocql005 = g_rtn_fields[2]
     
    #161013-00017#5 mod-E
END FUNCTION
# 检查员工编号在员工资料档中是否存在且有效
PRIVATE FUNCTION aimi105_imcf012_chk(p_imcf012)
DEFINE  p_imcf012         LIKE imcf_t.imcf012
   DEFINE  l_ooag001         LIKE ooag_t.ooag001
   DEFINE  l_ooagstus        LIKE ooag_t.ooagstus

   
   LET g_errno='' 
   LET l_ooagstus =''
   IF g_site = 'ALL' THEN    #160811-00001
      SELECT ooag001,ooagstus INTO l_ooag001,l_ooagstus FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = p_imcf012  
   #160811-00001  --begin--
   ELSE
      SELECT ooag001,ooagstus INTO l_ooag001,l_ooagstus FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = p_imcf012
         AND (ooag004 = g_site OR ooag004 = 'ALL')
   END IF
  #160811-00001  --end--         
      
   CASE
      WHEN SQLCA.SQLCODE=100   LET g_errno = 'aoo-00074'
      WHEN l_ooagstus ='N'     LET g_errno =  'sub-01302'  #160318-00005#20 mod#'aoo-00071'   
   END CASE
END FUNCTION
# 检查资料在应用分类码中是否存在且有效
PRIVATE FUNCTION aimi105_imcf011_chk(p_imcf011)
DEFINE p_imcf011     LIKE imcf_t.imcf011
DEFINE r_success     LIKE type_t.num5
DEFINE l_count       LIKE type_t.num5     #161013-00017#5 add

    LET r_success = TRUE
    #161013-00017#5 mod-S
#    IF NOT s_azzi650_chk_exist('204',p_imcf011) THEN
#       LET r_success = FALSE
#       RETURN r_success
#    END IF
    LET l_count = 1
    SELECT COUNT(1) INTO l_count FROM oocq_t
     WHERE oocqent = g_enterprise AND oocq001 = '204' AND oocq002 = p_imcf011
    IF l_count > 0 THEN
       LET l_count = 1
       SELECT COUNT(1) INTO l_count FROM oocq_t
        WHERE oocqent = g_enterprise AND oocq001 = '204' AND oocq002 = p_imcf011 AND oocqstus = 'Y'
       IF l_count = 0 OR cl_null(l_count) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'sub-00295'     
          LET g_errparam.extend = p_imcf011
          LET g_errparam.popup = TRUE
          LET g_errparam.replace[1]='aimi005'
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
    END IF
    #161013-00017#5 mod-E
    RETURN r_success
  
END FUNCTION
# 錄完計劃員編號帶出全稱
PRIVATE FUNCTION aimi105_imcf012_desc(p_imcf012)
DEFINE l_imcf012_desc        LIKE oofa_t.oofa011
   DEFINE p_imcf012             LIKE imcf_t.imcf012
    
    LET  l_imcf012_desc= ''
    SELECT oofa011 INTO l_imcf012_desc FROM oofa_t
     WHERE oofaent = g_enterprise
       AND oofa001 IN (SELECT ooag002 FROM ooag_t
                        WHERE ooagent = g_enterprise
                          AND ooag001 = p_imcf012)
     RETURN l_imcf012_desc
END FUNCTION
#+单别名称
PRIVATE FUNCTION aimi105_imcf031_desc(p_imcf031)
    DEFINE p_imcf031  LIKE imcf_t.imcf031 
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_imcf031
    CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]

END FUNCTION
# 檢查部門/廠商是否存在且存在
PRIVATE FUNCTION aimi105_imcf034_chk(p_imcf034)
   DEFINE p_imcf034     LIKE imcf_t.imcf034
   DEFINE l_ooegstus    LIKE ooeg_t.ooegstus
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus

   
   LET g_errno = ''
   LET l_ooegstus = ''
   LET l_pmaastus = ''
   SELECT ooegstus INTO l_ooegstus FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = p_imcf034
     
    IF SQLCA.SQLCODE=100 THEN
       SELECT pmaastus INTO l_pmaastus FROM pmaa_t
        WHERE pmaaent = g_enterprise
          AND pmaa001 = p_imcf034
          AND pmaa002 in ('1','3')
       CASE 
          WHEN SQLCA.SQLCODE = 100     LET g_errno = 'aim-00154'
          WHEN l_pmaastus = 'N'        LET g_errno = 'apm-00200'
          WHEN l_pmaastus = 'X'        LET g_errno = 'apm-00200'
       END CASE  
    ELSE
       IF l_ooegstus = 'N' THEN
          LET g_errno = 'sub-01302'  #160318-00005#20 mod 'abm-00007'
       END IF 
    END IF 
END FUNCTION
# 檢查單據別編號在單據別檔中是否存在且有效
PRIVATE FUNCTION aimi105_imcf031_chk(p_imcf031)
     DEFINE p_imcf031    LIKE imcf_t.imcf031
     DEFINE l_oobastus   LIKE ooba_t.oobastus
     
     LET g_errno = ''
     SELECT oobastus INTO l_oobastus
       FROM ooba_t
       LEFT OUTER JOIN oobx_t ON oobaent = oobxent AND ooba002 = oobx001
      WHERE oobaent = g_enterprise
        AND ooba001 = g_ooef004
        AND ooba002 = p_imcf031
        AND oobx003 = 'asft300'
      CASE 
        WHEN SQLCA.SQLCODE = 100     LET g_errno = 'aim-00056'
        WHEN l_oobastus = 'N'        LET g_errno =  'sub-01302'  #160318-00005#20 mod'aim-00057'
       END CASE
END FUNCTION
# 檢查資料在單位檔中是否存在且有效
PRIVATE FUNCTION aimi105_imcf016_chk(p_imcf016)
DEFINE p_imcf016    LIKE imcf_t.imcf016
     DEFINE l_oocastus   LIKE ooca_t.oocastus
     
     LET g_errno = ''
     LET l_oocastus = ''
     SELECT oocastus INTO l_oocastus FROM ooca_t
      WHERE oocaent = g_enterprise
        AND ooca001 = p_imcf016
     CASE
        WHEN SQLCA.SQLCODE=100    LET g_errno='aim-00004'
        WHEN l_oocastus = 'N'     LET g_errno='agl-00025'
     END CASE
END FUNCTION
#+ 单位说明
PRIVATE FUNCTION aimi105_imcf016_desc(p_unit)
    DEFINE p_unit  LIKE imcf_t.imcf016 
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_unit
    CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION
#+ 预设部门/厂商
PRIVATE FUNCTION aimi105_imcf034_desc(p_imcf034)
     DEFINE p_imcf034  LIKE imcf_t.imcf034 
     DEFINE l_cnt      LIKE type_t.num5
     
     #判段取值开窗，如果开的厂商，那名称直接捞取厂商的，否则的话，
     #判断该值在部门中是否存在，存在的话则捞取部门的说明，否则捞取厂商的说明
     IF g_flag <> 1 THEN
        SELECT count(*) INTO l_cnt FROM ooeg_t WHERE ooegent = g_enterprise
                                    AND ooeg001 = p_imcf034
        IF l_cnt > 0 THEN                              
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = p_imcf034
           CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
           RETURN g_rtn_fields[1]
        ELSE
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = p_imcf034
           CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
           RETURN g_rtn_fields[1]
        END IF 
     ELSE
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = p_imcf034
        CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
        RETURN g_rtn_fields[1]
     END IF 
     LET g_flag = 0
END FUNCTION
# 檢查倉儲/儲位在儲位基本資料檔中是否存在且有效
PRIVATE FUNCTION aimi105_imcf042_chk(p_imcf041,p_imcf042)
DEFINE p_imcf041     LIKE imcf_t.imcf041
    DEFINE p_imcf042     LIKE imcf_t.imcf042
    DEFINE l_inabstus    LIKE inab_t.inabstus
    
    LET g_errno = ''
    LET l_inabstus = ''
    IF g_site = 'ALL' THEN
       SELECT inabstus INTO l_inabstus FROM inab_t
        WHERE inabent = g_enterprise AND inabsite = g_site_t
          AND inab001 = p_imcf041 AND inab002 = p_imcf042
    ELSE
       SELECT inabstus INTO l_inabstus FROM inab_t
        WHERE inabent = g_enterprise AND inabsite = g_site
          AND inab001 = p_imcf041 AND inab002 = p_imcf042
    END IF
    
    CASE 
       WHEN SQLCA.SQLCODE = 100     LET g_errno = 'aim-00062'
       WHEN l_inabstus = 'N'        LET g_errno = 'sub-01302'  #160318-00005#20 mod 'aim-00063'
     END CASE
END FUNCTION
#+ 储位说明
PRIVATE FUNCTION aimi105_imcf042_desc(p_site,p_location,p_store)
   DEFINE p_site      LIKE imcf_t.imcfsite
   DEFINE p_location  LIKE imcf_t.imcf041
   DEFINE p_store     LIKE imcf_t.imcf042
   
    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_site
   IF g_site = 'ALL' THEN
      LET g_ref_fields[1] = g_site_t
   END IF
   LET g_ref_fields[2] = p_location
   LET g_ref_fields[3] = p_store
   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite=? AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION
#+ 库位说明
PRIVATE FUNCTION aimi105_imcf041_desc(p_site,p_location)
   DEFINE p_site     LIKE imcf_t.imcfsite
   DEFINE p_location LIKE imcf_t.imcf041  
   DEFINE r_inayl003 LIKE inayl_t.inayl003
   
   IF g_site = 'ALL' THEN
      LET p_site = g_site_t
   END IF
   
   CALL s_desc_get_stock_desc(p_site,p_location) RETURNING r_inayl003
   
   RETURN r_inayl003
   
END FUNCTION
# 檢查成本中心在組織基本資料檔中是否存在且有效
PRIVATE FUNCTION aimi105_imcf035_chk(p_imcf035)
DEFINE p_imcf035     LIKE imcf_t.imcf035
   DEFINE l_ooeastus    LIKE ooea_t.ooeastus
   
   LET g_errno = ''
   LET l_ooeastus = ''
   SELECT ooeastus INTO l_ooeastus FROM ooea_t
    WHERE ooeaent = g_enterprise
      AND ooea004 = 'Y'
      AND ooea001 = p_imcf035
    CASE 
       WHEN SQLCA.SQLCODE = 100     LET g_errno = 'aim-00060'
       WHEN l_ooeastus = 'N'        LET g_errno =  'sub-01302'  #160318-00005#20 mod'aim-00061'
     END CASE
END FUNCTION
# 檢查庫存在庫存資料檔中是否存在且有效
PRIVATE FUNCTION aimi105_imcf041_chk(p_imcf041)
DEFINE p_imcf041     LIKE imcf_t.imcf041
DEFINE l_inaastus    LIKE inaa_t.inaastus
    
    LET g_errno = ''
    LET l_inaastus = ''
    IF g_site = 'ALL' THEN
       SELECT inaastus INTO l_inaastus FROM inaa_t
        WHERE inaaent = g_enterprise AND inaasite = g_site_t
          AND inaa001 = p_imcf041
    ELSE
       SELECT inaastus INTO l_inaastus FROM inaa_t
        WHERE inaaent = g_enterprise AND inaasite = g_site 
          AND inaa001 = p_imcf041
    END IF 
    CASE 
       WHEN SQLCA.SQLCODE = 100     LET g_errno = 'aim-00064'
       WHEN l_inaastus = 'N'        LET g_errno = 'sub-01302'  #160318-00005#20 mod'aim-00065'
     END CASE
END FUNCTION
#制程料号检查
PRIVATE FUNCTION aimi105_imcf032_chk(p_imcf032)
   DEFINE p_imcf032     LIKE ecba_t.ecba001
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF NOT cl_null(p_imcf032) THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL

      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = p_imcf032

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
   END IF
   RETURN r_success
   
   #LET g_errno = ''
   #SELECT COUNT(*) INTO l_cnt FROM ecba_t
   #  WHERE ecbaent = g_enterprise AND ecbasite = g_site
   #    AND ecba001 = p_imcf032  AND ecbastus = 'Y'
   # 
   #IF l_cnt = 0 THEN   
   #   LET g_errno = 'aec-00022'
   #END IF
END FUNCTION
#制程料件说明
PRIVATE FUNCTION aimi105_imcf032_desc(p_ecba001)
    DEFINE p_ecba001     LIKE ecba_t.ecba001
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_ecba001
    CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN  g_rtn_fields[1]
END FUNCTION
#制程编号检查
PRIVATE FUNCTION aimi105_imcf033_chk(p_imcf032,p_imcf033)
    DEFINE p_imcf033    LIKE imcf_t.imcf033
    DEFINE p_imcf032    LIKE imcf_t.imcf032
    DEFINE l_ecbastus   LIKE ecba_t.ecbastus
    
    LET g_errno = ''
    LET l_ecbastus = ''
    SELECT ecbastus INTO l_ecbastus FROM ecba_t
     WHERE ecbaent = g_enterprise 
       AND ecbasite = g_site
       AND ecba001 = p_imcf032
       AND ecba002 = p_imcf033
    CASE 
       WHEN SQLCA.SQLCODE = 100     LET g_errno = 'aec-00011'
       WHEN l_ecbastus = 'N'        LET g_errno =  'sub-01302'  #160318-00005#20 mod'aec-00012'
     END CASE
END FUNCTION
#制程编号
PRIVATE FUNCTION aimi105_imcf033_desc(p_imcf033)
  DEFINE p_imcf033     LIKE imcf_t.imcf033
  DEFINE l_ecba003     LIKE ecba_t.ecba003
  
  SELECT ecba003 INTO l_ecba003 FROM ecba_t
   WHERE ecbaent = g_enterprise
     AND ecba001 = g_imcf_m.imcf032
     AND ecba002 = g_imcf_m.imcf033
  RETURN  l_ecba003  
END FUNCTION
#由料号带出制程编号，说明
PRIVATE FUNCTION aimi105_ecba002_ecba003()
   #带出制程编号，说明
   SELECT ecba002,ecba003 INTO g_imcf_m.imcf033,g_imcf_m.imcf033_desc FROM ecba_t
    WHERE ecbaent=g_enterprise 
      AND ecba001 = g_imcf_m.imcf032 
      AND ecbastus = 'Y'
      AND ROWNUM = 1
END FUNCTION

PRIVATE FUNCTION aimi105_imcf037_chk(p_imcf037)
  DEFINE p_imcf037     LIKE imcf_t.imcf037
  DEFINE l_n           LIKE type_t.num5
  
   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM bmaa_t
    WHERE bmaaent = g_enterprise AND bmaasite = g_site
      AND bmaa002 = p_imcf037
   IF l_n > 0 THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM bmaa_t
       WHERE bmaaent = g_enterprise AND bmaasite = g_site
         AND bmaa002 = p_imcf037 AND bmaastus = 'Y' 
      IF l_n = 0 THEN
         LET g_errno =  'sub-01302'  #160318-00005#20 mod'aim-00127'
      END IF
   ELSE
      LET g_errno = 'aim-00126'
   END IF
 
END FUNCTION

PRIVATE FUNCTION aimi105_ui_browser_refresh1()
  DEFINE l_i    LIKE type_t.num5
  
  FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_imcf011 = g_imcf_m.imcf011 THEN  
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
END FUNCTION

 
{</section>}
 
