#該程式未解開Section, 採用最新樣板產出!
{<section id="aimi102.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0019(2016-10-24 16:27:42), PR版次:0019(2016-12-05 14:29:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000410
#+ Filename...: aimi102
#+ Description: 集團預設料件庫存分群資料維護作業
#+ Creator....: 02296(2013-08-01 12:40:48)
#+ Modifier...: 05423 -SD/PR- 08734
 
{</section>}
 
{<section id="aimi102.global" >}
#應用 i01 樣板自動產生(Version:50)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#19  2016/03/29 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#48  2016/04/29 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160620-00023#1   2016/06/24 By xianghui 除KEY值栏位必输其他栏位都不用必输
#160617-00004#2   2016/07/05 By lixiang   #1.「是否產生條碼」、「條碼編碼方式」、「條碼包裝數量」由aimi101移到aimi102的相關資料「箱盒號條碼管理」
                                          #2.「是否產生條碼」更名為「箱盒號條碼管理」，原「箱盒號條碼管理」從畫面拿掉，並把欄位名稱改為no use
#160505-00002#3   2016/07/11 By lixiang   数量栏位非必输，改由手动撰写代码判断值域范围 
#160705-00042#11  2016/07/14 By sakura    程式中寫死g_prog部分改寫MATCHES方式
#160729-00026#1   2016/08/02 By lixiang   仓管员集团应该要可以开到据点的人员资料
#160523-00031#2   2016/08/02 By zhujing   將主畫面上的所有欄位放到瀏覽畫面上
#160906-00056#1   2016/09/09 By ywtsai    修正庫存分群碼查詢時開窗使用q_imcc051
#161013-00017#2   2016/10/24 By zhujing   可以直接在aimi102增加新的分群代號，不用先在aimi002增加
#161108-00006#1   2016/11/08 By ywtsai  修正修改後取得瀏覽頁籤資料index問題
#161116-00050#1   2016/11/16 By ywtsai  修正倉管員全名直接取員工基本資料檔(ooag_t)的全名(ooag011)，不須再依照聯絡對象識別碼串到連絡對象檔
#161122-00018#1   2016/11/25 By 08734   新增资料保存后原来不可以删除修改，现在改为可以删除修改，并且新增资料时，箱盒号条码管理栏位预设值为Y
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
PRIVATE TYPE type_g_imcc_m RECORD
       imcc051 LIKE imcc_t.imcc051, 
   oocql004 LIKE oocql_t.oocql004, 
   oocql005 LIKE oocql_t.oocql005, 
   imcc052 LIKE imcc_t.imcc052, 
   imcc052_desc LIKE type_t.chr80, 
   imcc053 LIKE imcc_t.imcc053, 
   imcc053_desc LIKE type_t.chr80, 
   imcc054 LIKE imcc_t.imcc054, 
   imcc055 LIKE imcc_t.imcc055, 
   imcc057 LIKE imcc_t.imcc057, 
   imcc058 LIKE imcc_t.imcc058, 
   imcc059 LIKE imcc_t.imcc059, 
   imccstus LIKE imcc_t.imccstus, 
   imccownid LIKE imcc_t.imccownid, 
   imccownid_desc LIKE type_t.chr80, 
   imccowndp LIKE imcc_t.imccowndp, 
   imccowndp_desc LIKE type_t.chr80, 
   imcccrtid LIKE imcc_t.imcccrtid, 
   imcccrtid_desc LIKE type_t.chr80, 
   imcccrtdp LIKE imcc_t.imcccrtdp, 
   imcccrtdp_desc LIKE type_t.chr80, 
   imcccrtdt LIKE imcc_t.imcccrtdt, 
   imccmodid LIKE imcc_t.imccmodid, 
   imccmodid_desc LIKE type_t.chr80, 
   imccmoddt LIKE imcc_t.imccmoddt, 
   imcc061 LIKE imcc_t.imcc061, 
   imcc062 LIKE imcc_t.imcc062, 
   imcc063 LIKE imcc_t.imcc063, 
   imcc063_desc LIKE type_t.chr80, 
   imcc064 LIKE imcc_t.imcc064, 
   imcc071 LIKE imcc_t.imcc071, 
   imcc072 LIKE imcc_t.imcc072, 
   imcc073 LIKE imcc_t.imcc073, 
   imcc073_desc LIKE type_t.chr80, 
   imcc074 LIKE imcc_t.imcc074, 
   imcc081 LIKE imcc_t.imcc081, 
   imcc082 LIKE imcc_t.imcc082, 
   imcc083 LIKE imcc_t.imcc083, 
   imcc083_desc LIKE type_t.chr80, 
   imcc084 LIKE imcc_t.imcc084, 
   imcc091 LIKE imcc_t.imcc091, 
   imcc091_desc LIKE type_t.chr80, 
   imcc092 LIKE imcc_t.imcc092, 
   imcc092_desc LIKE type_t.chr80, 
   imcc103 LIKE imcc_t.imcc103, 
   imcc104 LIKE imcc_t.imcc104, 
   imcc104_desc LIKE type_t.chr80, 
   imcc105 LIKE imcc_t.imcc105, 
   imcc101 LIKE imcc_t.imcc101, 
   imcc102 LIKE imcc_t.imcc102, 
   imcc094 LIKE imcc_t.imcc094, 
   imcc095 LIKE imcc_t.imcc095
       END RECORD
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_imcc051 LIKE imcc_t.imcc051,
   b_imcc051_desc LIKE type_t.chr80,
      b_imcc052 LIKE imcc_t.imcc052,
   b_imcc052_desc LIKE type_t.chr80,
      b_imcc053 LIKE imcc_t.imcc053,
   b_imcc053_desc LIKE type_t.chr80,
      b_imcc054 LIKE imcc_t.imcc054,
      b_imcc055 LIKE imcc_t.imcc055,
      b_imcc057 LIKE imcc_t.imcc057,
      b_imcc058 LIKE imcc_t.imcc058,
      b_imcc059 LIKE imcc_t.imcc059,
      b_imcc061 LIKE imcc_t.imcc061,
      b_imcc062 LIKE imcc_t.imcc062,
      b_imcc063 LIKE imcc_t.imcc063,
   b_imcc063_desc LIKE type_t.chr80,
      b_imcc064 LIKE imcc_t.imcc064,
      b_imcc071 LIKE imcc_t.imcc071,
      b_imcc072 LIKE imcc_t.imcc072,
      b_imcc073 LIKE imcc_t.imcc073,
   b_imcc073_desc LIKE type_t.chr80,
      b_imcc074 LIKE imcc_t.imcc074,
      b_imcc081 LIKE imcc_t.imcc081,
      b_imcc082 LIKE imcc_t.imcc082,
      b_imcc083 LIKE imcc_t.imcc083,
   b_imcc083_desc LIKE type_t.chr80,
      b_imcc084 LIKE imcc_t.imcc084,
      b_imcc091 LIKE imcc_t.imcc091,
   b_imcc091_desc LIKE type_t.chr80,
      b_imcc092 LIKE imcc_t.imcc092,
   b_imcc092_desc LIKE type_t.chr80,
      b_imcc103 LIKE imcc_t.imcc103,
      b_imcc104 LIKE imcc_t.imcc104,
   b_imcc104_desc LIKE type_t.chr80,
      b_imcc105 LIKE imcc_t.imcc105,
      b_imcc101 LIKE imcc_t.imcc101,
      b_imcc102 LIKE imcc_t.imcc102,
      b_imcc094 LIKE imcc_t.imcc094,
      b_imcc095 LIKE imcc_t.imcc095
      END RECORD 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#define l_site                like inaa_t.inaasite  #160729-00026#1
DEFINE g_site_t              LIKE inaa_t.inaasite   #160729-00026#1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_imcc_m        type_g_imcc_m  #單頭變數宣告
DEFINE g_imcc_m_t      type_g_imcc_m  #單頭舊值宣告(系統還原用)
DEFINE g_imcc_m_o      type_g_imcc_m  #單頭舊值宣告(其他用途)
DEFINE g_imcc_m_mask_o type_g_imcc_m  #轉換遮罩前資料
DEFINE g_imcc_m_mask_n type_g_imcc_m  #轉換遮罩後資料
 
   DEFINE g_imcc051_t LIKE imcc_t.imcc051
 
   
 
   
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

#end add-point
 
{</section>}
 
{<section id="aimi102.main" >}
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
   #let l_site = g_site  #160729-00026#1
   LET g_site_t = g_site  #160729-00026#1
   IF NOT cl_null(g_argv[1]) THEN
      LET g_site = g_argv[1]
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT imcc051,'','',imcc052,'',imcc053,'',imcc054,imcc055,imcc057,imcc058,imcc059, 
       imccstus,imccownid,'',imccowndp,'',imcccrtid,'',imcccrtdp,'',imcccrtdt,imccmodid,'',imccmoddt, 
       imcc061,imcc062,imcc063,'',imcc064,imcc071,imcc072,imcc073,'',imcc074,imcc081,imcc082,imcc083, 
       '',imcc084,imcc091,'',imcc092,'',imcc103,imcc104,'',imcc105,imcc101,imcc102,imcc094,imcc095", 
        
                      " FROM imcc_t",
                      " WHERE imccent= ? AND imccsite= ? AND imcc051=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimi102_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imcc051,t0.imcc052,t0.imcc053,t0.imcc054,t0.imcc055,t0.imcc057,t0.imcc058, 
       t0.imcc059,t0.imccstus,t0.imccownid,t0.imccowndp,t0.imcccrtid,t0.imcccrtdp,t0.imcccrtdt,t0.imccmodid, 
       t0.imccmoddt,t0.imcc061,t0.imcc062,t0.imcc063,t0.imcc064,t0.imcc071,t0.imcc072,t0.imcc073,t0.imcc074, 
       t0.imcc081,t0.imcc082,t0.imcc083,t0.imcc084,t0.imcc091,t0.imcc092,t0.imcc103,t0.imcc104,t0.imcc105, 
       t0.imcc101,t0.imcc102,t0.imcc094,t0.imcc095,t1.ooag011 ,t2.oocal003 ,t3.ooag011 ,t4.ooefl003 , 
       t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.oofgl004",
               " FROM imcc_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.imcc052  ",
               " LEFT JOIN oocal_t t2 ON t2.oocalent="||g_enterprise||" AND t2.oocal001=t0.imcc053 AND t2.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.imccownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.imccowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.imcccrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.imcccrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.imccmodid  ",
               " LEFT JOIN oofgl_t t8 ON t8.oofglent="||g_enterprise||" AND t8.oofgl001=' ' AND t8.oofgl002=t0.imcc104 AND t8.oofgl003='"||g_dlang||"' ",
 
               " WHERE t0.imccent = " ||g_enterprise|| " AND t0.imccsite = ? AND t0.imcc051 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   #LET g_sql = " SELECT  t0.imcc051,t0.imcc052,t0.imcc053,t0.imcc054,t0.imcc055,t0.imcc057, 
   #    t0.imcc058,t0.imcc059,t0.imccstus,t0.imccownid,t0.imccowndp,t0.imcccrtid,t0.imcccrtdp,t0.imcccrtdt, 
   #    t0.imccmodid,t0.imccmoddt,t0.imcc061,t0.imcc062,t0.imcc063,t0.imcc064,t0.imcc071,t0.imcc072,t0.imcc073, 
   #    t0.imcc074,t0.imcc081,t0.imcc082,t0.imcc083,t0.imcc084,t0.imcc091,t0.imcc092,t0.imcc093, 
   #    t0.imcc094,t0.imcc095,t0.imcc101,t0.imcc102,t1.oocql004 ,t2.ooag011 ,t3.oocal003 ,t4.ooag011 , 
   #    t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011",
   #            " FROM imcc_t t0",
   #                           " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='201' AND t1.oocql002=t0.imcc051 AND t1.oocql003='"||g_dlang||"' ",
   #            " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.imcc052  ",
   #            " LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=t0.imcc053 AND t3.oocal002='"||g_dlang||"' ",
   #            " LEFT JOIN ooag_t t4 ON t4.ooagent='"||g_enterprise||"' AND t4.ooag001=t0.imccownid  ",
   #            " LEFT JOIN ooefl_t t5 ON t5.ooeflent='"||g_enterprise||"' AND t5.ooefl001=t0.imccowndp AND t5.ooefl002='"||g_dlang||"' ",
   #            " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.imcccrtid  ",
   #            " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=t0.imcccrtdp AND t7.ooefl002='"||g_dlang||"' ",
   #            " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.imccmodid  ",
   #
   #            " WHERE t0.imccent = '" ||g_enterprise|| "' AND t0.imcc051 = ?  AND t0.imccsite='",g_site,"' "
   #end add-point
   PREPARE aimi102_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimi102 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimi102_init()   
 
      #進入選單 Menu (="N")
      CALL aimi102_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimi102
      
   END IF 
   
   CLOSE aimi102_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimi102.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimi102_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   #定義combobox狀態
      CALL cl_set_combo_scc_part('imccstus','17','N,Y')
 
      CALL cl_set_combo_scc('imcc055','1019') 
   CALL cl_set_combo_scc('imcc057','36') 
   CALL cl_set_combo_scc('imcc058','1010') 
   CALL cl_set_combo_scc('imcc059','1011') 
   CALL cl_set_combo_scc('imcc061','1012') 
   CALL cl_set_combo_scc('imcc064','1014') 
   CALL cl_set_combo_scc('imcc071','1012') 
   CALL cl_set_combo_scc('imcc074','1014') 
   CALL cl_set_combo_scc('imcc081','1013') 
   CALL cl_set_combo_scc('imcc084','1014') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化 name="init.init"
   #160523-00031#2 add-S
   CALL cl_set_combo_scc_part('b_imccstus','17','N,Y')
   CALL cl_set_combo_scc('b_imcc055','1019') 
   CALL cl_set_combo_scc('b_imcc057','36') 
   CALL cl_set_combo_scc('b_imcc058','1010') 
   CALL cl_set_combo_scc('b_imcc059','1011') 
   CALL cl_set_combo_scc('b_imcc061','1012') 
   CALL cl_set_combo_scc('b_imcc064','1014') 
   CALL cl_set_combo_scc('b_imcc071','1012') 
   CALL cl_set_combo_scc('b_imcc074','1014') 
   CALL cl_set_combo_scc('b_imcc081','1013') 
   CALL cl_set_combo_scc('b_imcc084','1014') 
   #160523-00031#2 add-E
   #end add-point
   
   #根據外部參數進行搜尋
   CALL aimi102_default_search()
 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aimi102_ui_dialog() 
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
            CALL aimi102_insert()
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
         INITIALIZE g_imcc_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL aimi102_init()
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
               CALL aimi102_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL aimi102_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu name="ui_dialog.before_menu"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimi102' THEN        #160705-00042#11 160714 by sakura mark     
               IF g_prog MATCHES 'aimi102' THEN   #160705-00042#11 160714 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aimi102_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aimi102_set_act_visible()
               CALL aimi102_set_act_no_visible()
               IF NOT (g_imcc_m.imcc051 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " imccent = " ||g_enterprise|| " AND imccsite = '" ||g_site|| "' AND",
                                     " imcc051 = '", g_imcc_m.imcc051, "' "
 
                  #填到對應位置
                  CALL aimi102_browser_fill(g_wc,"")
               END IF
               
            #第一筆資料
            ON ACTION first
               CALL aimi102_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimi102_fetch("N")
               LET g_current_row = g_current_idx
            
            #指定筆資料
            ON ACTION jump
               CALL aimi102_fetch("/")
               LET g_current_row = g_current_idx
            
            #上一筆資料
            ON ACTION previous
               CALL aimi102_fetch("P")
               LET g_current_row = g_current_idx
            
            #最後筆資料
            ON ACTION last 
               CALL aimi102_fetch("L")  
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
                  CALL aimi102_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi102_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi102_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi102_modify()
               #add-point:ON ACTION modify name="menu2.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi102_delete()
               #add-point:ON ACTION delete name="menu2.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi102_insert()
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
               CALL aimi102_reproduce()
               #add-point:ON ACTION reproduce name="menu2.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi102_query()
               #add-point:ON ACTION query name="menu2.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi102_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi102_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi102_set_pk_array()
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
                  CALL aimi102_fetch("")
 
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
                  CALL aimi102_browser_fill(g_wc,"")
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
                  CALL aimi102_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before name="ui_dialog.b_dialog"
               #若執行集團級程式，則不開放切換營運中心的功能
               #IF g_prog = 'aimi102' THEN        #160705-00042#11 160714 by sakura mark    
               IF g_prog MATCHES 'aimi102' THEN   #160705-00042#11 160714 by sakura add
                  CALL cl_set_act_visible("logistics", FALSE)
               ELSE
                  CALL cl_set_act_visible("logistics", TRUE)
               END IF
               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
               
               #end add-point
            
            #狀態碼切換
            ON ACTION statechange
               CALL aimi102_statechange()
               LET g_action_choice="statechange"
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
               CALL aimi102_set_act_visible()
               CALL aimi102_set_act_no_visible()
               IF NOT (g_imcc_m.imcc051 IS NULL
 
                 ) THEN
                  #組合條件
                  LET g_add_browse = " imccent = " ||g_enterprise|| " AND imccsite = '" ||g_site|| "' AND",
                                     " imcc051 = '", g_imcc_m.imcc051, "' "
 
                  #填到對應位置
                  CALL aimi102_browser_fill(g_wc,"")
               END IF
         
            #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aimi102_filter()
               EXIT DIALOG
 
 
 
            
            #第一筆資料
            ON ACTION first
               CALL aimi102_fetch("F") 
               LET g_current_row = g_current_idx
            
            #下一筆資料
            ON ACTION next
               CALL aimi102_fetch("N")
               LET g_current_row = g_current_idx
         
            #指定筆資料
            ON ACTION jump
               CALL aimi102_fetch("/")
               LET g_current_row = g_current_idx
         
            #上一筆資料
            ON ACTION previous
               CALL aimi102_fetch("P")
               LET g_current_row = g_current_idx
          
            #最後筆資料
            ON ACTION last 
               CALL aimi102_fetch("L")  
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
                  CALL aimi102_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimi102_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimi102_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aimi102_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimi102_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimi102_insert()
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
               CALL aimi102_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimi102_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
            END IF
 
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimi102_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimi102_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimi102_set_pk_array()
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
 
{<section id="aimi102.browser_fill" >}
#應用 a29 樣板自動產生(Version:15)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION aimi102_browser_fill(p_wc,ps_page_action) 
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
   
   LET l_searchcol = "imcc051"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制 name="browser_fill.wc"
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(1) FROM imcc_t ",
               "  ",
               "  LEFT JOIN oocql_t ON oocqlent = "||g_enterprise||" AND '201' = oocql001 AND imcc051 = oocql002 AND oocql003 = '",g_dlang,"' ",
               " WHERE imccent = " ||g_enterprise|| " AND imccsite = '" ||g_site|| "' AND ", 
               p_wc CLIPPED, cl_sql_add_filter("imcc_t")
                
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
      INITIALIZE g_imcc_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.imccstus,t0.imcc051,t0.imcc052,t0.imcc053,t0.imcc054,t0.imcc055,t0.imcc057, 
       t0.imcc058,t0.imcc059,t0.imcc061,t0.imcc062,t0.imcc063,t0.imcc064,t0.imcc071,t0.imcc072,t0.imcc073, 
       t0.imcc074,t0.imcc081,t0.imcc082,t0.imcc083,t0.imcc084,t0.imcc091,t0.imcc092,t0.imcc103,t0.imcc104, 
       t0.imcc105,t0.imcc101,t0.imcc102,t0.imcc094,t0.imcc095,t1.oocql004 ,t2.ooag011 ,t3.oocal003 , 
       t4.oofgl004 ,t5.oofgl004 ,t6.oofgl004 ,t7.inayl003 ,t8.inab003 ,t9.oofgl004",
               " FROM imcc_t t0 ",
               "  ",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='201' AND t1.oocql002=t0.imcc051 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.imcc052  ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=t0.imcc053 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oofgl_t t4 ON t4.oofglent="||g_enterprise||" AND t4.oofgl001=' ' AND t4.oofgl002=t0.imcc063 AND t4.oofgl003='"||g_dlang||"' ",
               " LEFT JOIN oofgl_t t5 ON t5.oofglent="||g_enterprise||" AND t5.oofgl001=' ' AND t5.oofgl002=t0.imcc073 AND t5.oofgl003='"||g_dlang||"' ",
               " LEFT JOIN oofgl_t t6 ON t6.oofglent="||g_enterprise||" AND t6.oofgl001=' ' AND t6.oofgl002=t0.imcc083 AND t6.oofgl003='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent="||g_enterprise||" AND t7.inayl001=t0.imcc091 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t8 ON t8.inabent="||g_enterprise||" AND t8.inab001=t0.imcc091 AND t8.inab002=t0.imcc092  ",
               " LEFT JOIN oofgl_t t9 ON t9.oofglent="||g_enterprise||" AND t9.oofgl001=' ' AND t9.oofgl002=t0.imcc104 AND t9.oofgl003='"||g_dlang||"' ",
 
               " WHERE t0.imccent = " ||g_enterprise|| " AND t0.imccsite = '" ||g_site|| "' AND ", ls_wc, cl_sql_add_filter("imcc_t")
   #add-point:browser_fill段fill_wc name="browser_fill.fill_wc"
   #161108-00006#1 add---start---
   IF NOT cl_null(g_add_browse) THEN
      LET g_cnt = 1
   END IF
   #161108-00006#1 add---end---
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre name="browser_fill.before_pre"
#   LET g_sql = " SELECT t0.imccstus,t0.imcc051,t1.oocql004",
#               " FROM imcc_t t0 ",
#               " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='201' AND t1.oocql002=t0.imcc051 AND t1.oocql003='"||g_lang||"' ",
#               " WHERE t0.imccent = '" ||g_enterprise|| "' AND t0.imccsite = '" ||g_site|| "' AND ", g_wc, cl_sql_add_filter("imcc_t"),
#               "  ORDER BY ",l_searchcol," ",g_order
   LET g_sql = " SELECT t0.imccstus,t0.imcc051,t0.imcc052,t0.imcc053,t0.imcc054,t0.imcc055,t0.imcc057, 
       t0.imcc058,t0.imcc059,t0.imcc061,t0.imcc062,t0.imcc063,t0.imcc064,t0.imcc071,t0.imcc072,t0.imcc073, 
       t0.imcc074,t0.imcc081,t0.imcc082,t0.imcc083,t0.imcc084,t0.imcc091,t0.imcc092,t0.imcc103,t0.imcc104, 
       t0.imcc105,t0.imcc101,t0.imcc102,t0.imcc094,t0.imcc095,t1.oocql004 ,t2.ooag011 ,t3.oocal003 , 
       t4.oofgl004 ,t5.oofgl004 ,t6.oofgl004 ,t7.inayl003 ,t8.inab003 ,t9.oofgl004",
               " FROM imcc_t t0 ",
               "  ",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='201' AND t1.oocql002=t0.imcc051 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.imcc052  ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=t0.imcc053 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oofgl_t t4 ON t4.oofglent='"||g_enterprise||"' AND t4.oofgl001=t0.imcc063 AND t4.oofgl002=' ' AND t4.oofgl003='"||g_dlang||"' ",
               " LEFT JOIN oofgl_t t5 ON t5.oofglent='"||g_enterprise||"' AND t5.oofgl001=t0.imcc073 AND t5.oofgl002=' ' AND t5.oofgl003='"||g_dlang||"' ",
               " LEFT JOIN oofgl_t t6 ON t6.oofglent='"||g_enterprise||"' AND t6.oofgl001=t0.imcc083 AND t6.oofgl002=' ' AND t6.oofgl003='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t7 ON t7.inaylent='"||g_enterprise||"' AND t7.inayl001=t0.imcc091 AND t7.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t8 ON t8.inabent='"||g_enterprise||"' AND t8.inab001=t0.imcc091 AND t8.inab002=t0.imcc092 AND t8.inabsite = '",g_site_t,"' ",
               " LEFT JOIN oofgl_t t9 ON t9.oofglent='"||g_enterprise||"' AND t9.oofgl001=t0.imcc104 AND t9.oofgl002=' ' AND t9.oofgl003='"||g_dlang||"' ",
               " WHERE t0.imccent = '" ||g_enterprise|| "' AND t0.imccsite = '" ||g_site|| "' AND ", g_wc, cl_sql_add_filter("imcc_t"),
               "  ORDER BY ",l_searchcol," ",g_order
               
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"imcc_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imcc051,g_browser[g_cnt].b_imcc052, 
          g_browser[g_cnt].b_imcc053,g_browser[g_cnt].b_imcc054,g_browser[g_cnt].b_imcc055,g_browser[g_cnt].b_imcc057, 
          g_browser[g_cnt].b_imcc058,g_browser[g_cnt].b_imcc059,g_browser[g_cnt].b_imcc061,g_browser[g_cnt].b_imcc062, 
          g_browser[g_cnt].b_imcc063,g_browser[g_cnt].b_imcc064,g_browser[g_cnt].b_imcc071,g_browser[g_cnt].b_imcc072, 
          g_browser[g_cnt].b_imcc073,g_browser[g_cnt].b_imcc074,g_browser[g_cnt].b_imcc081,g_browser[g_cnt].b_imcc082, 
          g_browser[g_cnt].b_imcc083,g_browser[g_cnt].b_imcc084,g_browser[g_cnt].b_imcc091,g_browser[g_cnt].b_imcc092, 
          g_browser[g_cnt].b_imcc103,g_browser[g_cnt].b_imcc104,g_browser[g_cnt].b_imcc105,g_browser[g_cnt].b_imcc101, 
          g_browser[g_cnt].b_imcc102,g_browser[g_cnt].b_imcc094,g_browser[g_cnt].b_imcc095,g_browser[g_cnt].b_imcc051_desc, 
          g_browser[g_cnt].b_imcc052_desc,g_browser[g_cnt].b_imcc053_desc,g_browser[g_cnt].b_imcc063_desc, 
          g_browser[g_cnt].b_imcc073_desc,g_browser[g_cnt].b_imcc083_desc,g_browser[g_cnt].b_imcc091_desc, 
          g_browser[g_cnt].b_imcc092_desc,g_browser[g_cnt].b_imcc104_desc
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
         CALL aimi102_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_imcc051) THEN
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
 
{<section id="aimi102.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimi102_construct()
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
   INITIALIZE g_imcc_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON imcc051,oocql004,oocql005,imcc052,imcc053,imcc054,imcc055,imcc057,imcc058, 
          imcc059,imccstus,imccownid,imccowndp,imcccrtid,imcccrtdp,imcccrtdt,imccmodid,imccmoddt,imcc061, 
          imcc062,imcc063,imcc064,imcc071,imcc072,imcc073,imcc074,imcc081,imcc082,imcc083,imcc084,imcc091, 
          imcc092,imcc103,imcc104,imcc105,imcc101,imcc102,imcc094,imcc095
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point             
      
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imcccrtdt>>----
         AFTER FIELD imcccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imccmoddt>>----
         AFTER FIELD imccmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imcccnfdt>>----
         
         #----<<imccpstdt>>----
 
 
 
      
         #一般欄位
                  #Ctrlp:construct.c.imcc051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc051
            #add-point:ON ACTION controlp INFIELD imcc051 name="construct.c.imcc051"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '201'
            #CALL q_oocq002_22()                           #呼叫開窗   #160906-00056#1 mark
            CALL q_imcc051()                                          #160906-00056#1 add
            DISPLAY g_qryparam.return1 TO imcc051  #顯示到畫面上

            NEXT FIELD imcc051                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc051
            #add-point:BEFORE FIELD imcc051 name="construct.b.imcc051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc051
            
            #add-point:AFTER FIELD imcc051 name="construct.a.imcc051"
            
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
 
 
         #Ctrlp:construct.c.imcc052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc052
            #add-point:ON ACTION controlp INFIELD imcc052 name="construct.c.imcc052"
            #此段落由子樣板a08產生
            #開窗c段
            #160729-00026#1--s
            #LET g_qryparam.reqry = FALSE
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_site='ALL' THEN
               CALL q_ooag001()  
            ELSE
               CALL q_ooag001_2()  
            END IF
            #CALL q_ooag001_2()                           #呼叫開窗
            #160729-00026#1---e
            DISPLAY g_qryparam.return1 TO imcc052  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD imcc052                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc052
            #add-point:BEFORE FIELD imcc052 name="construct.b.imcc052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc052
            
            #add-point:AFTER FIELD imcc052 name="construct.a.imcc052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc053
            #add-point:ON ACTION controlp INFIELD imcc053 name="construct.c.imcc053"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcc053  #顯示到畫面上

            NEXT FIELD imcc053                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc053
            #add-point:BEFORE FIELD imcc053 name="construct.b.imcc053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc053
            
            #add-point:AFTER FIELD imcc053 name="construct.a.imcc053"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc054
            #add-point:BEFORE FIELD imcc054 name="construct.b.imcc054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc054
            
            #add-point:AFTER FIELD imcc054 name="construct.a.imcc054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc054
            #add-point:ON ACTION controlp INFIELD imcc054 name="construct.c.imcc054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc055
            #add-point:BEFORE FIELD imcc055 name="construct.b.imcc055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc055
            
            #add-point:AFTER FIELD imcc055 name="construct.a.imcc055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc055
            #add-point:ON ACTION controlp INFIELD imcc055 name="construct.c.imcc055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc057
            #add-point:BEFORE FIELD imcc057 name="construct.b.imcc057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc057
            
            #add-point:AFTER FIELD imcc057 name="construct.a.imcc057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc057
            #add-point:ON ACTION controlp INFIELD imcc057 name="construct.c.imcc057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc058
            #add-point:BEFORE FIELD imcc058 name="construct.b.imcc058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc058
            
            #add-point:AFTER FIELD imcc058 name="construct.a.imcc058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc058
            #add-point:ON ACTION controlp INFIELD imcc058 name="construct.c.imcc058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc059
            #add-point:BEFORE FIELD imcc059 name="construct.b.imcc059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc059
            
            #add-point:AFTER FIELD imcc059 name="construct.a.imcc059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc059
            #add-point:ON ACTION controlp INFIELD imcc059 name="construct.c.imcc059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imccstus
            #add-point:BEFORE FIELD imccstus name="construct.b.imccstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imccstus
            
            #add-point:AFTER FIELD imccstus name="construct.a.imccstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imccstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imccstus
            #add-point:ON ACTION controlp INFIELD imccstus name="construct.c.imccstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imccownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imccownid
            #add-point:ON ACTION controlp INFIELD imccownid name="construct.c.imccownid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imccownid  #顯示到畫面上

            NEXT FIELD imccownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imccownid
            #add-point:BEFORE FIELD imccownid name="construct.b.imccownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imccownid
            
            #add-point:AFTER FIELD imccownid name="construct.a.imccownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imccowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imccowndp
            #add-point:ON ACTION controlp INFIELD imccowndp name="construct.c.imccowndp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imccowndp  #顯示到畫面上

            NEXT FIELD imccowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imccowndp
            #add-point:BEFORE FIELD imccowndp name="construct.b.imccowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imccowndp
            
            #add-point:AFTER FIELD imccowndp name="construct.a.imccowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcccrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcccrtid
            #add-point:ON ACTION controlp INFIELD imcccrtid name="construct.c.imcccrtid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcccrtid  #顯示到畫面上

            NEXT FIELD imcccrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcccrtid
            #add-point:BEFORE FIELD imcccrtid name="construct.b.imcccrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcccrtid
            
            #add-point:AFTER FIELD imcccrtid name="construct.a.imcccrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcccrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcccrtdp
            #add-point:ON ACTION controlp INFIELD imcccrtdp name="construct.c.imcccrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcccrtdp  #顯示到畫面上

            NEXT FIELD imcccrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcccrtdp
            #add-point:BEFORE FIELD imcccrtdp name="construct.b.imcccrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcccrtdp
            
            #add-point:AFTER FIELD imcccrtdp name="construct.a.imcccrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcccrtdt
            #add-point:BEFORE FIELD imcccrtdt name="construct.b.imcccrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imccmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imccmodid
            #add-point:ON ACTION controlp INFIELD imccmodid name="construct.c.imccmodid"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imccmodid  #顯示到畫面上

            NEXT FIELD imccmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imccmodid
            #add-point:BEFORE FIELD imccmodid name="construct.b.imccmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imccmodid
            
            #add-point:AFTER FIELD imccmodid name="construct.a.imccmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imccmoddt
            #add-point:BEFORE FIELD imccmoddt name="construct.b.imccmoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc061
            #add-point:BEFORE FIELD imcc061 name="construct.b.imcc061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc061
            
            #add-point:AFTER FIELD imcc061 name="construct.a.imcc061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc061
            #add-point:ON ACTION controlp INFIELD imcc061 name="construct.c.imcc061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc062
            #add-point:BEFORE FIELD imcc062 name="construct.b.imcc062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc062
            
            #add-point:AFTER FIELD imcc062 name="construct.a.imcc062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc062
            #add-point:ON ACTION controlp INFIELD imcc062 name="construct.c.imcc062"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcc063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc063
            #add-point:ON ACTION controlp INFIELD imcc063 name="construct.c.imcc063"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = '6'     #6.庫存批號
            CALL q_oofg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcc063  #顯示到畫面上
            NEXT FIELD imcc063                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc063
            #add-point:BEFORE FIELD imcc063 name="construct.b.imcc063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc063
            
            #add-point:AFTER FIELD imcc063 name="construct.a.imcc063"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc064
            #add-point:BEFORE FIELD imcc064 name="construct.b.imcc064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc064
            
            #add-point:AFTER FIELD imcc064 name="construct.a.imcc064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc064
            #add-point:ON ACTION controlp INFIELD imcc064 name="construct.c.imcc064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc071
            #add-point:BEFORE FIELD imcc071 name="construct.b.imcc071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc071
            
            #add-point:AFTER FIELD imcc071 name="construct.a.imcc071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc071
            #add-point:ON ACTION controlp INFIELD imcc071 name="construct.c.imcc071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc072
            #add-point:BEFORE FIELD imcc072 name="construct.b.imcc072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc072
            
            #add-point:AFTER FIELD imcc072 name="construct.a.imcc072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc072
            #add-point:ON ACTION controlp INFIELD imcc072 name="construct.c.imcc072"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcc073
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc073
            #add-point:ON ACTION controlp INFIELD imcc073 name="construct.c.imcc073"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = '7'     #製造批號 
            CALL q_oofg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcc073  #顯示到畫面上
            NEXT FIELD imcc073                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc073
            #add-point:BEFORE FIELD imcc073 name="construct.b.imcc073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc073
            
            #add-point:AFTER FIELD imcc073 name="construct.a.imcc073"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc074
            #add-point:BEFORE FIELD imcc074 name="construct.b.imcc074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc074
            
            #add-point:AFTER FIELD imcc074 name="construct.a.imcc074"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc074
            #add-point:ON ACTION controlp INFIELD imcc074 name="construct.c.imcc074"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc081
            #add-point:BEFORE FIELD imcc081 name="construct.b.imcc081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc081
            
            #add-point:AFTER FIELD imcc081 name="construct.a.imcc081"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc081
            #add-point:ON ACTION controlp INFIELD imcc081 name="construct.c.imcc081"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc082
            #add-point:BEFORE FIELD imcc082 name="construct.b.imcc082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc082
            
            #add-point:AFTER FIELD imcc082 name="construct.a.imcc082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc082
            #add-point:ON ACTION controlp INFIELD imcc082 name="construct.c.imcc082"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcc083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc083
            #add-point:ON ACTION controlp INFIELD imcc083 name="construct.c.imcc083"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = '8'     #製造序號 
            CALL q_oofg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcc083  #顯示到畫面上
            NEXT FIELD imcc083                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc083
            #add-point:BEFORE FIELD imcc083 name="construct.b.imcc083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc083
            
            #add-point:AFTER FIELD imcc083 name="construct.a.imcc083"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc084
            #add-point:BEFORE FIELD imcc084 name="construct.b.imcc084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc084
            
            #add-point:AFTER FIELD imcc084 name="construct.a.imcc084"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc084
            #add-point:ON ACTION controlp INFIELD imcc084 name="construct.c.imcc084"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcc091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc091
            #add-point:ON ACTION controlp INFIELD imcc091 name="construct.c.imcc091"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_22()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcc091  #顯示到畫面上

            NEXT FIELD imcc091                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc091
            #add-point:BEFORE FIELD imcc091 name="construct.b.imcc091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc091
            
            #add-point:AFTER FIELD imcc091 name="construct.a.imcc091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc092
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc092
            #add-point:ON ACTION controlp INFIELD imcc092 name="construct.c.imcc092"
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcc092  #顯示到畫面上

            NEXT FIELD imcc092                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc092
            #add-point:BEFORE FIELD imcc092 name="construct.b.imcc092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc092
            
            #add-point:AFTER FIELD imcc092 name="construct.a.imcc092"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc103
            #add-point:BEFORE FIELD imcc103 name="construct.b.imcc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc103
            
            #add-point:AFTER FIELD imcc103 name="construct.a.imcc103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc103
            #add-point:ON ACTION controlp INFIELD imcc103 name="construct.c.imcc103"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imcc104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc104
            #add-point:ON ACTION controlp INFIELD imcc104 name="construct.c.imcc104"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160617-00004#2--s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '30'
            CALL q_oofg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imcc104  #顯示到畫面上
            NEXT FIELD imcc104                     #返回原欄位
            #160617-00004#2--e--



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc104
            #add-point:BEFORE FIELD imcc104 name="construct.b.imcc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc104
            
            #add-point:AFTER FIELD imcc104 name="construct.a.imcc104"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc105
            #add-point:BEFORE FIELD imcc105 name="construct.b.imcc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc105
            
            #add-point:AFTER FIELD imcc105 name="construct.a.imcc105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc105
            #add-point:ON ACTION controlp INFIELD imcc105 name="construct.c.imcc105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc101
            #add-point:BEFORE FIELD imcc101 name="construct.b.imcc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc101
            
            #add-point:AFTER FIELD imcc101 name="construct.a.imcc101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc101
            #add-point:ON ACTION controlp INFIELD imcc101 name="construct.c.imcc101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc102
            #add-point:BEFORE FIELD imcc102 name="construct.b.imcc102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc102
            
            #add-point:AFTER FIELD imcc102 name="construct.a.imcc102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc102
            #add-point:ON ACTION controlp INFIELD imcc102 name="construct.c.imcc102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc094
            #add-point:BEFORE FIELD imcc094 name="construct.b.imcc094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc094
            
            #add-point:AFTER FIELD imcc094 name="construct.a.imcc094"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc094
            #add-point:ON ACTION controlp INFIELD imcc094 name="construct.c.imcc094"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc095
            #add-point:BEFORE FIELD imcc095 name="construct.b.imcc095"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc095
            
            #add-point:AFTER FIELD imcc095 name="construct.a.imcc095"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imcc095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc095
            #add-point:ON ACTION controlp INFIELD imcc095 name="construct.c.imcc095"
            
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
 
{<section id="aimi102.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimi102_filter()
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
      CONSTRUCT g_wc_filter ON imcc051,imcc052,imcc053,imcc054,imcc055,imcc057,imcc058,imcc059,imcc061, 
          imcc062,imcc063,imcc064,imcc071,imcc072,imcc073,imcc074,imcc081,imcc082,imcc083,imcc084,imcc091, 
          imcc092,imcc103,imcc104,imcc105,imcc101,imcc102,imcc094,imcc095
                          FROM s_browse[1].b_imcc051,s_browse[1].b_imcc052,s_browse[1].b_imcc053,s_browse[1].b_imcc054, 
                              s_browse[1].b_imcc055,s_browse[1].b_imcc057,s_browse[1].b_imcc058,s_browse[1].b_imcc059, 
                              s_browse[1].b_imcc061,s_browse[1].b_imcc062,s_browse[1].b_imcc063,s_browse[1].b_imcc064, 
                              s_browse[1].b_imcc071,s_browse[1].b_imcc072,s_browse[1].b_imcc073,s_browse[1].b_imcc074, 
                              s_browse[1].b_imcc081,s_browse[1].b_imcc082,s_browse[1].b_imcc083,s_browse[1].b_imcc084, 
                              s_browse[1].b_imcc091,s_browse[1].b_imcc092,s_browse[1].b_imcc103,s_browse[1].b_imcc104, 
                              s_browse[1].b_imcc105,s_browse[1].b_imcc101,s_browse[1].b_imcc102,s_browse[1].b_imcc094, 
                              s_browse[1].b_imcc095
 
         BEFORE CONSTRUCT
               DISPLAY aimi102_filter_parser('imcc051') TO s_browse[1].b_imcc051
            DISPLAY aimi102_filter_parser('imcc052') TO s_browse[1].b_imcc052
            DISPLAY aimi102_filter_parser('imcc053') TO s_browse[1].b_imcc053
            DISPLAY aimi102_filter_parser('imcc054') TO s_browse[1].b_imcc054
            DISPLAY aimi102_filter_parser('imcc055') TO s_browse[1].b_imcc055
            DISPLAY aimi102_filter_parser('imcc057') TO s_browse[1].b_imcc057
            DISPLAY aimi102_filter_parser('imcc058') TO s_browse[1].b_imcc058
            DISPLAY aimi102_filter_parser('imcc059') TO s_browse[1].b_imcc059
            DISPLAY aimi102_filter_parser('imcc061') TO s_browse[1].b_imcc061
            DISPLAY aimi102_filter_parser('imcc062') TO s_browse[1].b_imcc062
            DISPLAY aimi102_filter_parser('imcc063') TO s_browse[1].b_imcc063
            DISPLAY aimi102_filter_parser('imcc064') TO s_browse[1].b_imcc064
            DISPLAY aimi102_filter_parser('imcc071') TO s_browse[1].b_imcc071
            DISPLAY aimi102_filter_parser('imcc072') TO s_browse[1].b_imcc072
            DISPLAY aimi102_filter_parser('imcc073') TO s_browse[1].b_imcc073
            DISPLAY aimi102_filter_parser('imcc074') TO s_browse[1].b_imcc074
            DISPLAY aimi102_filter_parser('imcc081') TO s_browse[1].b_imcc081
            DISPLAY aimi102_filter_parser('imcc082') TO s_browse[1].b_imcc082
            DISPLAY aimi102_filter_parser('imcc083') TO s_browse[1].b_imcc083
            DISPLAY aimi102_filter_parser('imcc084') TO s_browse[1].b_imcc084
            DISPLAY aimi102_filter_parser('imcc091') TO s_browse[1].b_imcc091
            DISPLAY aimi102_filter_parser('imcc092') TO s_browse[1].b_imcc092
            DISPLAY aimi102_filter_parser('imcc103') TO s_browse[1].b_imcc103
            DISPLAY aimi102_filter_parser('imcc104') TO s_browse[1].b_imcc104
            DISPLAY aimi102_filter_parser('imcc105') TO s_browse[1].b_imcc105
            DISPLAY aimi102_filter_parser('imcc101') TO s_browse[1].b_imcc101
            DISPLAY aimi102_filter_parser('imcc102') TO s_browse[1].b_imcc102
            DISPLAY aimi102_filter_parser('imcc094') TO s_browse[1].b_imcc094
            DISPLAY aimi102_filter_parser('imcc095') TO s_browse[1].b_imcc095
      
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
 
      CALL aimi102_filter_show('imcc051')
   CALL aimi102_filter_show('imcc052')
   CALL aimi102_filter_show('imcc053')
   CALL aimi102_filter_show('imcc054')
   CALL aimi102_filter_show('imcc055')
   CALL aimi102_filter_show('imcc057')
   CALL aimi102_filter_show('imcc058')
   CALL aimi102_filter_show('imcc059')
   CALL aimi102_filter_show('imcc061')
   CALL aimi102_filter_show('imcc062')
   CALL aimi102_filter_show('imcc063')
   CALL aimi102_filter_show('imcc064')
   CALL aimi102_filter_show('imcc071')
   CALL aimi102_filter_show('imcc072')
   CALL aimi102_filter_show('imcc073')
   CALL aimi102_filter_show('imcc074')
   CALL aimi102_filter_show('imcc081')
   CALL aimi102_filter_show('imcc082')
   CALL aimi102_filter_show('imcc083')
   CALL aimi102_filter_show('imcc084')
   CALL aimi102_filter_show('imcc091')
   CALL aimi102_filter_show('imcc092')
   CALL aimi102_filter_show('imcc103')
   CALL aimi102_filter_show('imcc104')
   CALL aimi102_filter_show('imcc105')
   CALL aimi102_filter_show('imcc101')
   CALL aimi102_filter_show('imcc102')
   CALL aimi102_filter_show('imcc094')
   CALL aimi102_filter_show('imcc095')
 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimi102_filter_parser(ps_field)
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
 
{<section id="aimi102.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimi102_filter_show(ps_field)
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
   LET ls_condition = aimi102_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimi102_query()
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
 
   INITIALIZE g_imcc_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL aimi102_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimi102_browser_fill(g_wc,"F")
      CALL aimi102_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL aimi102_browser_fill(g_wc,"F")   # 移到第一頁
   
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
      CALL aimi102_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="aimi102.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimi102_fetch(p_fl)
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
   LET g_imcc_m.imcc051 = g_browser[g_current_idx].b_imcc051
 
                       
   #讀取單頭所有欄位資料
   EXECUTE aimi102_master_referesh USING g_site,g_imcc_m.imcc051 INTO g_imcc_m.imcc051,g_imcc_m.imcc052, 
       g_imcc_m.imcc053,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058,g_imcc_m.imcc059, 
       g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccowndp,g_imcc_m.imcccrtid,g_imcc_m.imcccrtdp, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmoddt,g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063, 
       g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc074,g_imcc_m.imcc081, 
       g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc092,g_imcc_m.imcc103, 
       g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095, 
       g_imcc_m.imcc052_desc,g_imcc_m.imcc053_desc,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid_desc, 
       g_imcc_m.imcccrtdp_desc,g_imcc_m.imccmodid_desc,g_imcc_m.imcc104_desc
   
   #遮罩相關處理
   LET g_imcc_m_mask_o.* =  g_imcc_m.*
   CALL aimi102_imcc_t_mask()
   LET g_imcc_m_mask_n.* =  g_imcc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimi102_set_act_visible()
   CALL aimi102_set_act_no_visible()
 
   #add-point:fetch段action控制 name="fetch.action_control"
  #161122-00018#1   2016/11/25 By 08734 mark(S)
  # IF g_imcc_m.imccstus <> 'Y' THEN
  #    CALL cl_set_act_visible("modify,delete", FALSE)
  # ELSE
  #    CALL cl_set_act_visible("modify,delete", TRUE)   
  # END IF
  #161122-00018#1   2016/11/25 By 08734 mark(E)
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_imcc_m_t.* = g_imcc_m.*
   LET g_imcc_m_o.* = g_imcc_m.*
   
   LET g_data_owner = g_imcc_m.imccownid      
   LET g_data_dept  = g_imcc_m.imccowndp
   
   #重新顯示
   CALL aimi102_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimi102_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_imcc_m.* TO NULL             #DEFAULT 設定
   LET g_imcc051_t = NULL
 
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imcc_m.imccownid = g_user
      LET g_imcc_m.imccowndp = g_dept
      LET g_imcc_m.imcccrtid = g_user
      LET g_imcc_m.imcccrtdp = g_dept 
      LET g_imcc_m.imcccrtdt = cl_get_current()
      LET g_imcc_m.imccmodid = g_user
      LET g_imcc_m.imccmoddt = cl_get_current()
      LET g_imcc_m.imccstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imcc_m.imcc054 = "N"
      LET g_imcc_m.imcc055 = "3"
      LET g_imcc_m.imcc057 = "A"
      LET g_imcc_m.imcc058 = "0"
      LET g_imcc_m.imcc059 = "1"
      LET g_imcc_m.imccstus = "Y"
      LET g_imcc_m.imcc061 = "3"
      LET g_imcc_m.imcc062 = "N"
      LET g_imcc_m.imcc064 = "3"
      LET g_imcc_m.imcc071 = "1"
      LET g_imcc_m.imcc072 = "N"
      LET g_imcc_m.imcc074 = "2"
      LET g_imcc_m.imcc081 = "1"
      LET g_imcc_m.imcc082 = "N"
      LET g_imcc_m.imcc084 = "2"
      LET g_imcc_m.imcc101 = "0"
      LET g_imcc_m.imcc102 = "0"
 
 
      #add-point:單頭預設值 name="insert.default"
      LET g_imcc_m.imccstus = "Y" 
      INITIALIZE g_imcc_m_t.* TO NULL 
      LET g_imcc_m.imcc103 = "Y"   #161122-00018#1   2016/11/25 By 08734 add       
      #end add-point   
     
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcc_m.imccstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
     
      #資料輸入
      CALL aimi102_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_imcc_m.* TO NULL
         CALL aimi102_show()
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
   CALL aimi102_set_act_visible()
   CALL aimi102_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imcc051_t = g_imcc_m.imcc051
 
   
   #組合新增資料的條件
   LET g_add_browse = " imccent = " ||g_enterprise|| " AND imccsite = '" ||g_site|| "' AND",
                      " imcc051 = '", g_imcc_m.imcc051, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi102_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimi102_master_referesh USING g_site,g_imcc_m.imcc051 INTO g_imcc_m.imcc051,g_imcc_m.imcc052, 
       g_imcc_m.imcc053,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058,g_imcc_m.imcc059, 
       g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccowndp,g_imcc_m.imcccrtid,g_imcc_m.imcccrtdp, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmoddt,g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063, 
       g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc074,g_imcc_m.imcc081, 
       g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc092,g_imcc_m.imcc103, 
       g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095, 
       g_imcc_m.imcc052_desc,g_imcc_m.imcc053_desc,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid_desc, 
       g_imcc_m.imcccrtdp_desc,g_imcc_m.imccmodid_desc,g_imcc_m.imcc104_desc
   
   
   #遮罩相關處理
   LET g_imcc_m_mask_o.* =  g_imcc_m.*
   CALL aimi102_imcc_t_mask()
   LET g_imcc_m_mask_n.* =  g_imcc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imcc_m.imcc051,g_imcc_m.oocql004,g_imcc_m.oocql005,g_imcc_m.imcc052,g_imcc_m.imcc052_desc, 
       g_imcc_m.imcc053,g_imcc_m.imcc053_desc,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058, 
       g_imcc_m.imcc059,g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp, 
       g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid,g_imcc_m.imcccrtid_desc,g_imcc_m.imcccrtdp,g_imcc_m.imcccrtdp_desc, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmodid_desc,g_imcc_m.imccmoddt,g_imcc_m.imcc061, 
       g_imcc_m.imcc062,g_imcc_m.imcc063,g_imcc_m.imcc063_desc,g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072, 
       g_imcc_m.imcc073,g_imcc_m.imcc073_desc,g_imcc_m.imcc074,g_imcc_m.imcc081,g_imcc_m.imcc082,g_imcc_m.imcc083, 
       g_imcc_m.imcc083_desc,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc091_desc,g_imcc_m.imcc092, 
       g_imcc_m.imcc092_desc,g_imcc_m.imcc103,g_imcc_m.imcc104,g_imcc_m.imcc104_desc,g_imcc_m.imcc105, 
       g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095
 
   #add-point:新增結束後 name="insert.after"
   #161122-00018#1   2016/11/25 By 08734 add(S)
   CALL aimi102_set_act_visible()
   CALL aimi102_set_act_no_visible()
   #161122-00018#1   2016/11/25 By 08734 add(E)
   #end add-point 
 
   LET g_data_owner = g_imcc_m.imccownid      
   LET g_data_dept  = g_imcc_m.imccowndp
 
   #功能已完成,通報訊息中心
   CALL aimi102_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimi102.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimi102_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="modify.pre_function"
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_imcc_m.imcc051 IS NULL
 
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
   LET g_imcc051_t = g_imcc_m.imcc051
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN aimi102_cl USING g_enterprise, g_site,g_imcc_m.imcc051
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi102_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimi102_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi102_master_referesh USING g_site,g_imcc_m.imcc051 INTO g_imcc_m.imcc051,g_imcc_m.imcc052, 
       g_imcc_m.imcc053,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058,g_imcc_m.imcc059, 
       g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccowndp,g_imcc_m.imcccrtid,g_imcc_m.imcccrtdp, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmoddt,g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063, 
       g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc074,g_imcc_m.imcc081, 
       g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc092,g_imcc_m.imcc103, 
       g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095, 
       g_imcc_m.imcc052_desc,g_imcc_m.imcc053_desc,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid_desc, 
       g_imcc_m.imcccrtdp_desc,g_imcc_m.imccmodid_desc,g_imcc_m.imcc104_desc
 
   #檢查是否允許此動作
   IF NOT aimi102_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_imcc_m_mask_o.* =  g_imcc_m.*
   CALL aimi102_imcc_t_mask()
   LET g_imcc_m_mask_n.* =  g_imcc_m.*
   
   
 
   #顯示資料
   CALL aimi102_show()
   
   WHILE TRUE
      LET g_imcc_m.imcc051 = g_imcc051_t
 
      
      #寫入修改者/修改日期資訊
      LET g_imcc_m.imccmodid = g_user 
LET g_imcc_m.imccmoddt = cl_get_current()
LET g_imcc_m.imccmodid_desc = cl_get_username(g_imcc_m.imccmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
 
      #資料輸入
      CALL aimi102_input("u")     
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_imcc_m.* = g_imcc_m_t.*
         CALL aimi102_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE imcc_t SET (imccmodid,imccmoddt) = (g_imcc_m.imccmodid,g_imcc_m.imccmoddt)
       WHERE imccent = g_enterprise AND imccsite = g_site AND imcc051 = g_imcc051_t
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL aimi102_set_act_visible()
   CALL aimi102_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imccent = " ||g_enterprise|| " AND imccsite = '" ||g_site|| "' AND",
                      " imcc051 = '", g_imcc_m.imcc051, "' "
 
   #填到對應位置
   CALL aimi102_browser_fill(g_wc,"")
 
   CLOSE aimi102_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi102_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="aimi102.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimi102_input(p_cmd)
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
   DEFINE l_ooag002       LIKE ooag_t.ooag002
   CALL cl_set_comp_entry("imcc095,imcc094",true)
   IF p_cmd = 'u' THEN
      IF NOT cl_null(g_imcc_m.imcc094) THEN
         CALL cl_set_comp_entry("imcc095",FALSE)
      ELSE
         CALL cl_set_comp_entry("imcc095",TRUE)
      END IF 
      IF NOT cl_null(g_imcc_m.imcc095) THEN
         CALL cl_set_comp_entry("imcc094",FALSE)
      ELSE
         CALL cl_set_comp_entry("imcc094",TRUE)
      END IF      
   END IF
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
   DISPLAY BY NAME g_imcc_m.imcc051,g_imcc_m.oocql004,g_imcc_m.oocql005,g_imcc_m.imcc052,g_imcc_m.imcc052_desc, 
       g_imcc_m.imcc053,g_imcc_m.imcc053_desc,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058, 
       g_imcc_m.imcc059,g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp, 
       g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid,g_imcc_m.imcccrtid_desc,g_imcc_m.imcccrtdp,g_imcc_m.imcccrtdp_desc, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmodid_desc,g_imcc_m.imccmoddt,g_imcc_m.imcc061, 
       g_imcc_m.imcc062,g_imcc_m.imcc063,g_imcc_m.imcc063_desc,g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072, 
       g_imcc_m.imcc073,g_imcc_m.imcc073_desc,g_imcc_m.imcc074,g_imcc_m.imcc081,g_imcc_m.imcc082,g_imcc_m.imcc083, 
       g_imcc_m.imcc083_desc,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc091_desc,g_imcc_m.imcc092, 
       g_imcc_m.imcc092_desc,g_imcc_m.imcc103,g_imcc_m.imcc104,g_imcc_m.imcc104_desc,g_imcc_m.imcc105, 
       g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095
   
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
   CALL aimi102_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aimi102_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_imcc_m.imcc051,g_imcc_m.oocql004,g_imcc_m.oocql005,g_imcc_m.imcc052,g_imcc_m.imcc053, 
          g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058,g_imcc_m.imcc059,g_imcc_m.imccstus, 
          g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063,g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072, 
          g_imcc_m.imcc073,g_imcc_m.imcc074,g_imcc_m.imcc081,g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc084, 
          g_imcc_m.imcc091,g_imcc_m.imcc092,g_imcc_m.imcc103,g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101, 
          g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               #161013-00017#2 add-S
               IF NOT cl_null(g_imcc_m.imcc051)  THEN
                  CALL n_oocql('201',g_imcc_m.imcc051)    # n_glacl:對應多語言表格 。 g_glac_m.glac002: 對應值
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = '201'
                  LET g_ref_fields[2] = g_imcc_m.imcc051
                  CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                      ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imcc_m.oocql004 = g_rtn_fields[1]
                  LET g_imcc_m.oocql005 = g_rtn_fields[2]

                  DISPLAY BY NAME g_imcc_m.oocql004
                  DISPLAY BY NAME g_imcc_m.oocql005
               END IF
               #161013-00017#2 add-E
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #其他table資料備份(確定是否更改用)
            LET g_master_multi_table_t.oocql001 = '201'
LET g_master_multi_table_t.oocql002 = g_imcc_m.imcc051
LET g_master_multi_table_t.oocql004 = g_imcc_m.oocql004
LET g_master_multi_table_t.oocql005 = g_imcc_m.oocql005
 
            #add-point:input開始前 name="input.before.input"
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc051
            #add-point:BEFORE FIELD imcc051 name="input.b.imcc051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc051
            
            #add-point:AFTER FIELD imcc051 name="input.a.imcc051"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_imcc_m.imcc051) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcc_m.imcc051 != g_imcc051_t ))) THEN 
                  CALL aimi102_chk_imcc051(g_imcc_m.imcc051)             
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM imcc_t WHERE "||"imccent = '" ||g_enterprise|| "' AND imccsite = '" ||g_site|| "' AND "||"imcc051 = '"||g_imcc_m.imcc051 ||"'",'std-00004',0) THEN   
                     #161013-00017#2 marked-S
#                     LET g_imcc_m.imcc051_desc = NULL
#                     DISPLAY BY NAME g_imcc_m.imcc051_desc
                     #161013-00017#2 marked-E
                     #161013-00017#2 add-S
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = '201'
                     LET g_ref_fields[2] = g_imcc_m.imcc051
                     CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                         ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_imcc_m.oocql004 = g_rtn_fields[1]
                     LET g_imcc_m.oocql005 = g_rtn_fields[2]
   
                     DISPLAY BY NAME g_imcc_m.oocql004
                     DISPLAY BY NAME g_imcc_m.oocql005
                     #161013-00017#2 add-E
                     LET g_imcc_m.imcc051 = g_imcc051_t
                     NEXT FIELD CURRENT
                  END IF
                  #dorislai-20150630-modify----(S)
#                  CALL aimi102_imcc051(g_imcc_m.imcc051)
#                  IF NOT cl_null(g_errno) THEN
#                     DISPLAY BY NAME g_imcc_m.imcc051_desc
#                     LET g_imcc_m.imcc051 = g_imcc051_t
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_imcc_m.imcc051
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     CALL aimi102_chk_imcc051(g_imcc_m.imcc051)
#                     NEXT FIELD imcc051
#                  END IF
                  #161013-00017#2 marked-S
#                  IF NOT s_azzi650_chk_exist('201',g_imcc_m.imcc051) THEN
#                     DISPLAY BY NAME g_imcc_m.imcc051_desc
#                     LET g_imcc_m.imcc051 = g_imcc051_t
#                     CALL aimi102_chk_imcc051(g_imcc_m.imcc051)
#                     NEXT FIELD imcc051
#                  END IF 
                  #161013-00017#2 marked-E
                  #161013-00017#2 add-S
                  LET l_count = 1
                  SELECT COUNT(1) INTO l_count FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '201' AND oocq002 = g_imcc_m.imcc051
                  IF l_count > 0 THEN
                     LET l_count = 1
                     SELECT COUNT(1) INTO l_count FROM oocq_t
                      WHERE oocqent = g_enterprise AND oocq001 = '201' AND oocq002 = g_imcc_m.imcc051 AND oocqstus = 'Y'
                     IF l_count = 0 OR cl_null(l_count) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aim-00219'
                        LET g_errparam.extend = g_imcc_m.imcc051
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_imcc_m.imcc051 = g_imcc_m_t.imcc051
                        INITIALIZE g_ref_fields TO NULL
                        LET g_ref_fields[1] = '201'
                        LET g_ref_fields[2] = g_imcc_m.imcc051
                        CALL ap_ref_array2(g_ref_fields," SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent = '"
                            ||g_enterprise||"' AND oocql001 = ? AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                        LET g_imcc_m.oocql004 = g_rtn_fields[1]
                        LET g_imcc_m.oocql005 = g_rtn_fields[2]
                        DISPLAY BY NAME g_imcc_m.oocql004
                        DISPLAY BY NAME g_imcc_m.oocql005
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161013-00017#2 add-E
                  #dorislai-20150630-modify----(E)
               END IF
            END IF

            CALL aimi102_chk_imcc051(g_imcc_m.imcc051)

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc051
            #add-point:ON CHANGE imcc051 name="input.g.imcc051"
            
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
         AFTER FIELD imcc052
            
            #add-point:AFTER FIELD imcc052 name="input.a.imcc052"
            IF  NOT cl_null(g_imcc_m.imcc052) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcc_m.imcc052 != g_imcc_m_t.imcc052 ))) THEN
                  CALL aimi102_imcc052()
                  IF NOT cl_null(g_errno) THEN
                     DISPLAY BY NAME g_imcc_m.imcc052_desc
                     LET g_imcc_m.imcc052 = g_imcc_m_t.imcc052
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imcc_m.imcc052
                     #160318-00005#19  --add--str
                     LET g_errparam.replace[1] ='aooi130'
                     LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
                     LET g_errparam.exeprog    ='aooi130'
                     #160318-00005#19 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi102_chk_imcc052()
                     NEXT FIELD imcc052
                  END IF 
               END IF
            END IF
            
            CALL aimi102_chk_imcc052()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc052
            #add-point:BEFORE FIELD imcc052 name="input.b.imcc052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc052
            #add-point:ON CHANGE imcc052 name="input.g.imcc052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc053
            
            #add-point:AFTER FIELD imcc053 name="input.a.imcc053"
            IF  NOT cl_null(g_imcc_m.imcc053) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcc_m.imcc053 != g_imcc_m_t.imcc053 ))) THEN
                  CALL aimi102_imcc053()
                  IF NOT cl_null(g_errno) THEN
                     DISPLAY BY NAME g_imcc_m.imcc053_desc
                     LET g_imcc_m.imcc053 = g_imcc_m_t.imcc053
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imcc_m.imcc053
                     #160318-00005#19  --add--str
                     LET g_errparam.replace[1] ='aooi250'
                     LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                     LET g_errparam.exeprog    ='aooi250'
                     #160318-00005#19 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi102_display_imcc053()
                     NEXT FIELD imcc053
                  END IF 
               END IF
            END IF
            
            CALL aimi102_display_imcc053()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc053
            #add-point:BEFORE FIELD imcc053 name="input.b.imcc053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc053
            #add-point:ON CHANGE imcc053 name="input.g.imcc053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc054
            #add-point:BEFORE FIELD imcc054 name="input.b.imcc054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc054
            
            #add-point:AFTER FIELD imcc054 name="input.a.imcc054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc054
            #add-point:ON CHANGE imcc054 name="input.g.imcc054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc055
            #add-point:BEFORE FIELD imcc055 name="input.b.imcc055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc055
            
            #add-point:AFTER FIELD imcc055 name="input.a.imcc055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc055
            #add-point:ON CHANGE imcc055 name="input.g.imcc055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc057
            #add-point:BEFORE FIELD imcc057 name="input.b.imcc057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc057
            
            #add-point:AFTER FIELD imcc057 name="input.a.imcc057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc057
            #add-point:ON CHANGE imcc057 name="input.g.imcc057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc058
            #add-point:BEFORE FIELD imcc058 name="input.b.imcc058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc058
            
            #add-point:AFTER FIELD imcc058 name="input.a.imcc058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc058
            #add-point:ON CHANGE imcc058 name="input.g.imcc058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc059
            #add-point:BEFORE FIELD imcc059 name="input.b.imcc059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc059
            
            #add-point:AFTER FIELD imcc059 name="input.a.imcc059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc059
            #add-point:ON CHANGE imcc059 name="input.g.imcc059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imccstus
            #add-point:BEFORE FIELD imccstus name="input.b.imccstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imccstus
            
            #add-point:AFTER FIELD imccstus name="input.a.imccstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imccstus
            #add-point:ON CHANGE imccstus name="input.g.imccstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc061
            #add-point:BEFORE FIELD imcc061 name="input.b.imcc061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc061
            
            #add-point:AFTER FIELD imcc061 name="input.a.imcc061"
            CALL aimi102_set_entry(p_cmd)  
            CALL aimi102_set_no_required()
            CALL aimi102_set_required() 
            CALL aimi102_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc061
            #add-point:ON CHANGE imcc061 name="input.g.imcc061"
            CALL aimi102_set_entry(p_cmd)  
            CALL aimi102_set_no_required()
            CALL aimi102_set_required() 
            CALL aimi102_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc062
            #add-point:BEFORE FIELD imcc062 name="input.b.imcc062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc062
            
            #add-point:AFTER FIELD imcc062 name="input.a.imcc062"
            CALL aimi102_set_no_required()
            CALL aimi102_set_required()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc062
            #add-point:ON CHANGE imcc062 name="input.g.imcc062"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc063
            
            #add-point:AFTER FIELD imcc063 name="input.a.imcc063"
            CALL aimi102_get_oofg001_ref(g_imcc_m.imcc063) RETURNING g_imcc_m.imcc063_desc
            DISPLAY BY NAME g_imcc_m.imcc063_desc
            IF NOT cl_null(g_imcc_m.imcc063) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imcc_m.imcc063
               #160318-00025#48  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
               #160318-00025#48  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oofg001_1") THEN
                  LET g_imcc_m.imcc063 = g_imcc_m_t.imcc063
                  CALL aimi102_get_oofg001_ref(g_imcc_m.imcc063) RETURNING g_imcc_m.imcc063_desc
                  DISPLAY BY NAME g_imcc_m.imcc063_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc063
            #add-point:BEFORE FIELD imcc063 name="input.b.imcc063"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc063
            #add-point:ON CHANGE imcc063 name="input.g.imcc063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc064
            #add-point:BEFORE FIELD imcc064 name="input.b.imcc064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc064
            
            #add-point:AFTER FIELD imcc064 name="input.a.imcc064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc064
            #add-point:ON CHANGE imcc064 name="input.g.imcc064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc071
            #add-point:BEFORE FIELD imcc071 name="input.b.imcc071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc071
            
            #add-point:AFTER FIELD imcc071 name="input.a.imcc071"
            CALL aimi102_set_entry(p_cmd)  
            CALL aimi102_set_no_required()
            CALL aimi102_set_required() 
            CALL aimi102_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc071
            #add-point:ON CHANGE imcc071 name="input.g.imcc071"
            CALL aimi102_set_entry(p_cmd)  
            CALL aimi102_set_no_required()
            CALL aimi102_set_required() 
            CALL aimi102_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc072
            #add-point:BEFORE FIELD imcc072 name="input.b.imcc072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc072
            
            #add-point:AFTER FIELD imcc072 name="input.a.imcc072"
            CALL aimi102_set_no_required()
            CALL aimi102_set_required()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc072
            #add-point:ON CHANGE imcc072 name="input.g.imcc072"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc073
            
            #add-point:AFTER FIELD imcc073 name="input.a.imcc073"
            CALL aimi102_get_oofg001_ref(g_imcc_m.imcc073) RETURNING g_imcc_m.imcc073_desc
            DISPLAY BY NAME g_imcc_m.imcc073_desc
            IF NOT cl_null(g_imcc_m.imcc073) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imcc_m.imcc073
               #160318-00025#48  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
               #160318-00025#48  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oofg001_3") THEN
                  LET g_imcc_m.imcc073 = g_imcc_m_t.imcc073
                  CALL aimi102_get_oofg001_ref(g_imcc_m.imcc073) RETURNING g_imcc_m.imcc073_desc
                  DISPLAY BY NAME g_imcc_m.imcc073_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc073
            #add-point:BEFORE FIELD imcc073 name="input.b.imcc073"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc073
            #add-point:ON CHANGE imcc073 name="input.g.imcc073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc074
            #add-point:BEFORE FIELD imcc074 name="input.b.imcc074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc074
            
            #add-point:AFTER FIELD imcc074 name="input.a.imcc074"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc074
            #add-point:ON CHANGE imcc074 name="input.g.imcc074"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc081
            #add-point:BEFORE FIELD imcc081 name="input.b.imcc081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc081
            
            #add-point:AFTER FIELD imcc081 name="input.a.imcc081"
            CALL aimi102_set_entry(p_cmd)  
            CALL aimi102_set_no_required()
            CALL aimi102_set_required() 
            CALL aimi102_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc081
            #add-point:ON CHANGE imcc081 name="input.g.imcc081"
            CALL aimi102_set_entry(p_cmd)  
            CALL aimi102_set_no_required()
            CALL aimi102_set_required() 
            CALL aimi102_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc082
            #add-point:BEFORE FIELD imcc082 name="input.b.imcc082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc082
            
            #add-point:AFTER FIELD imcc082 name="input.a.imcc082"
            CALL aimi102_set_no_required()
            CALL aimi102_set_required()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc082
            #add-point:ON CHANGE imcc082 name="input.g.imcc082"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc083
            
            #add-point:AFTER FIELD imcc083 name="input.a.imcc083"
            CALL aimi102_get_oofg001_ref(g_imcc_m.imcc083) RETURNING g_imcc_m.imcc083_desc
            DISPLAY BY NAME g_imcc_m.imcc083_desc
            IF NOT cl_null(g_imcc_m.imcc083) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imcc_m.imcc083
               #160318-00025#48  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "apj-00004:sub-01302|aooi390|",cl_get_progname("aooi390",g_lang,"2"),"|:EXEPROGaooi390"
               #160318-00025#48  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_oofg001_4") THEN
                  LET g_imcc_m.imcc083 = g_imcc_m_t.imcc083
                  CALL aimi102_get_oofg001_ref(g_imcc_m.imcc083) RETURNING g_imcc_m.imcc083_desc
                  DISPLAY BY NAME g_imcc_m.imcc083_desc
                  NEXT FIELD CURRENT
               END IF

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc083
            #add-point:BEFORE FIELD imcc083 name="input.b.imcc083"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc083
            #add-point:ON CHANGE imcc083 name="input.g.imcc083"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc084
            #add-point:BEFORE FIELD imcc084 name="input.b.imcc084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc084
            
            #add-point:AFTER FIELD imcc084 name="input.a.imcc084"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc084
            #add-point:ON CHANGE imcc084 name="input.g.imcc084"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc091
            
            #add-point:AFTER FIELD imcc091 name="input.a.imcc091"
            LET g_imcc_m.imcc091_desc = null
            DISPLAY BY NAME g_imcc_m.imcc091_desc
            IF  NOT cl_null(g_imcc_m.imcc091) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcc_m.imcc091 != g_imcc_m_t.imcc091 OR g_imcc_m_t.imcc091 IS NULL ))) 
                  or (p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcc_m.imcc092 != g_imcc_m_t.imcc092  OR g_imcc_m_t.imcc092 IS null)))) THEN
                  CALL aimi102_imcc091()
                  IF NOT cl_null(g_errno) THEN
                     DISPLAY BY NAME g_imcc_m.imcc091_desc
                     LET g_imcc_m.imcc091 = g_imcc_m_t.imcc091
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imcc_m.imcc091
                     #160318-00005#19  --add--str
                     LET g_errparam.replace[1] ='aini001'
                     LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                     LET g_errparam.exeprog    ='aini001'
                     #160318-00005#19 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL aimi102_imcc091_ref()
                     NEXT FIELD imcc091
                  END IF
                  IF NOT cl_null(g_imcc_m.imcc092) THEN
                     CALL aimi102_imcc092()
                     IF NOT cl_null(g_errno) THEN
                        DISPLAY BY NAME g_imcc_m.imcc091_desc
#                        LET g_imcc_m.imcc091 = g_imcc_m_t.imcc091
                        INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imcc_m.imcc091
                     #160318-00005#19  --add--str
                     LET g_errparam.replace[1] ='aini002'
                     LET g_errparam.replace[2] = cl_get_progname('aini002',g_lang,"2")
                     LET g_errparam.exeprog    ='aini002'
                     #160318-00005#19 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                        CALL aimi102_imcc091_ref()
                        NEXT FIELD imcc092
                     END IF
                  END IF                  
               END IF
            END IF
            CALL aimi102_imcc091_ref()
            CALL aimi102_imcc092_ref()
            
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc091
            #add-point:BEFORE FIELD imcc091 name="input.b.imcc091"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc091
            #add-point:ON CHANGE imcc091 name="input.g.imcc091"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc092
            
            #add-point:AFTER FIELD imcc092 name="input.a.imcc092"
            IF  NOT cl_null(g_imcc_m.imcc092) THEN 
               IF (p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcc_m.imcc092 != g_imcc_m_t.imcc092  OR g_imcc_m_t.imcc092 IS null)))) 
                  or ( p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_imcc_m.imcc091 != g_imcc_m_t.imcc091 OR g_imcc_m_t.imcc091 IS NULL ))))  THEN
                  CALL aimi102_imcc092()
                  IF NOT cl_null(g_errno) THEN
                     DISPLAY BY NAME g_imcc_m.imcc092_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imcc_m.imcc092
                     #160318-00005#19  --add--str
                     LET g_errparam.replace[1] ='aini002'
                     LET g_errparam.replace[2] = cl_get_progname('aini002',g_lang,"2")
                     LET g_errparam.exeprog    ='aini002'
                     #160318-00005#19 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     LET g_ref_fields[1] = g_imcc_m.imcc091
                     LET g_ref_fields[2] = g_imcc_m.imcc092
                     CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
                     LET g_imcc_m.imcc092_desc = g_rtn_fields[1]
                     DISPLAY BY NAME g_imcc_m.imcc092_desc
                     NEXT FIELD imcc091
                  END IF 
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imcc091
            LET g_ref_fields[2] = g_imcc_m.imcc092
            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
            LET g_imcc_m.imcc092_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imcc092_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc092
            #add-point:BEFORE FIELD imcc092 name="input.b.imcc092"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc092
            #add-point:ON CHANGE imcc092 name="input.g.imcc092"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc103
            #add-point:BEFORE FIELD imcc103 name="input.b.imcc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc103
            
            #add-point:AFTER FIELD imcc103 name="input.a.imcc103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc103
            #add-point:ON CHANGE imcc103 name="input.g.imcc103"
            #160617-00004#2--s--
            CALL aimi102_set_entry(p_cmd)
            CALL aimi102_set_no_entry(p_cmd)
            #160617-00004#2---e
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc104
            
            #add-point:AFTER FIELD imcc104 name="input.a.imcc104"
            #160617-00004#2--s--
            CALL aimi102_imcc104_ref(g_imcc_m.imcc104) RETURNING g_imcc_m.imcc104_desc
            DISPLAY BY NAME g_imcc_m.imcc104_desc
            IF NOT cl_null(g_imcc_m.imcc104) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imcc_m.imcc104

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oofg001_2") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_imcc_m.imcc104 = g_imcc_m_t.imcc104
                  CALL aimi102_imcc104_ref(g_imcc_m.imcc104) RETURNING g_imcc_m.imcc104_desc
                  DISPLAY BY NAME g_imcc_m.imcc104_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #160617-00004#2--e--
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc104
            #add-point:BEFORE FIELD imcc104 name="input.b.imcc104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc104
            #add-point:ON CHANGE imcc104 name="input.g.imcc104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc105
            #add-point:BEFORE FIELD imcc105 name="input.b.imcc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc105
            
            #add-point:AFTER FIELD imcc105 name="input.a.imcc105"
            IF NOT cl_null(g_imcc_m.imcc105) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imcc_m.imcc105,"1","1","","","azz-00079",1) THEN
                  LET g_imcc_m.imcc105 = g_imcc_m_t.imcc105
                  NEXT FIELD imcc105
               END IF
               #160505-00002#3--e
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc105
            #add-point:ON CHANGE imcc105 name="input.g.imcc105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc101
            #add-point:BEFORE FIELD imcc101 name="input.b.imcc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc101
            
            #add-point:AFTER FIELD imcc101 name="input.a.imcc101"
            IF NOT cl_null(g_imcc_m.imcc101) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imcc_m.imcc101,"0.000","1","","","azz-00079",1) THEN
                  LET g_imcc_m.imcc101 = g_imcc_m_t.imcc101
                  NEXT FIELD imcc101
               END IF
               #160505-00002#3--e
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc101
            #add-point:ON CHANGE imcc101 name="input.g.imcc101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc102
            #add-point:BEFORE FIELD imcc102 name="input.b.imcc102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc102
            
            #add-point:AFTER FIELD imcc102 name="input.a.imcc102"
            IF NOT cl_null(g_imcc_m.imcc102) THEN
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imcc_m.imcc102,"0.000","1","","","azz-00079",1) THEN
                  LET g_imcc_m.imcc102 = g_imcc_m_t.imcc102
                  NEXT FIELD imcc102
               END IF 
               #160505-00002#3--e            
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc102
            #add-point:ON CHANGE imcc102 name="input.g.imcc102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc094
            #add-point:BEFORE FIELD imcc094 name="input.b.imcc094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc094
            
            #add-point:AFTER FIELD imcc094 name="input.a.imcc094"
            IF NOT cl_null(g_imcc_m.imcc094) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imcc_m.imcc094,"0.000","1","","","azz-00079",1) THEN
                  LET g_imcc_m.imcc094 = g_imcc_m_t.imcc094
                  NEXT FIELD imcc094
               END IF 
               #160505-00002#3--e   
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc094
            #add-point:ON CHANGE imcc094 name="input.g.imcc094"
            IF NOT cl_null(g_imcc_m.imcc094) THEN
               CALL cl_set_comp_entry("imcc095",FALSE)
            ELSE
               CALL cl_set_comp_entry("imcc095",TRUE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imcc095
            #add-point:BEFORE FIELD imcc095 name="input.b.imcc095"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imcc095
            
            #add-point:AFTER FIELD imcc095 name="input.a.imcc095"
            IF NOT cl_null(g_imcc_m.imcc095) THEN 
               #160505-00002#3--s
               IF NOT cl_ap_chk_range(g_imcc_m.imcc095,"0.000","1","100.000","1","azz-00087",1) THEN
                  LET g_imcc_m.imcc095 = g_imcc_m_t.imcc095
                  NEXT FIELD imcc095
               END IF 
               #160505-00002#3--e   
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imcc095
            #add-point:ON CHANGE imcc095 name="input.g.imcc095"
            IF NOT cl_null(g_imcc_m.imcc095) THEN
               CALL cl_set_comp_entry("imcc094",FALSE)
            ELSE
               CALL cl_set_comp_entry("imcc094",TRUE)
            END IF  
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imcc051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc051
            #add-point:ON ACTION controlp INFIELD imcc051 name="input.c.imcc051"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcc_m.imcc051             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "201" #應用分類

            CALL q_oocq002_22()                                #呼叫開窗

            LET g_imcc_m.imcc051 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcc_m.imcc051 TO imcc051              #顯示到畫面上
            CALL aimi102_chk_imcc051(g_imcc_m.imcc051)
            NEXT FIELD imcc051                          #返回原欄位


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
 
 
         #Ctrlp:input.c.imcc052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc052
            #add-point:ON ACTION controlp INFIELD imcc052 name="input.c.imcc052"
#此段落由子樣板a07產生            
            #開窗i段 
            INITIALIZE g_qryparam.* TO NULL   #160729-00026#1
            LET g_qryparam.state = 'i'    #160729-00026#1
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcc_m.imcc052             #給予default值
            LET g_qryparam.default2 = "" #g_imcc_m.oofa011 #全名

            #給予arg

            #160729-00026#1--s
            IF g_site='ALL' THEN
               CALL q_ooag001()
            ELSE
               CALL q_ooag001_2()  
            END IF
            #CALL q_ooag001_2()                           #呼叫開窗
            #160729-00026#1---e

            LET g_imcc_m.imcc052 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_imcc_m.oofa011 = g_qryparam.return2 #全名

            DISPLAY g_imcc_m.imcc052 TO imcc052              #顯示到畫面上
            #DISPLAY g_imcc_m.oofa011 TO oofa011 #全名
            CALL aimi102_chk_imcc052()  
            NEXT FIELD imcc052                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcc053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc053
            #add-point:ON ACTION controlp INFIELD imcc053 name="input.c.imcc053"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcc_m.imcc053             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imcc_m.imcc053 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcc_m.imcc053 TO imcc053              #顯示到畫面上
            CALL aimi102_display_imcc053()
            NEXT FIELD imcc053                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcc054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc054
            #add-point:ON ACTION controlp INFIELD imcc054 name="input.c.imcc054"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc055
            #add-point:ON ACTION controlp INFIELD imcc055 name="input.c.imcc055"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc057
            #add-point:ON ACTION controlp INFIELD imcc057 name="input.c.imcc057"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc058
            #add-point:ON ACTION controlp INFIELD imcc058 name="input.c.imcc058"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc059
            #add-point:ON ACTION controlp INFIELD imcc059 name="input.c.imcc059"
            
            #END add-point
 
 
         #Ctrlp:input.c.imccstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imccstus
            #add-point:ON ACTION controlp INFIELD imccstus name="input.c.imccstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc061
            #add-point:ON ACTION controlp INFIELD imcc061 name="input.c.imcc061"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc062
            #add-point:ON ACTION controlp INFIELD imcc062 name="input.c.imcc062"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc063
            #add-point:ON ACTION controlp INFIELD imcc063 name="input.c.imcc063"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcc_m.imcc063             #給予default值

            #給予arg
            LET g_qryparam.arg1  = '6'     #6.庫存批號


            CALL q_oofg001_3()                                #呼叫開窗

            LET g_imcc_m.imcc063 = g_qryparam.return1              

            DISPLAY g_imcc_m.imcc063 TO imcc063              #
            CALL aimi102_get_oofg001_ref(g_imcc_m.imcc063) RETURNING g_imcc_m.imcc063_desc
            DISPLAY BY NAME g_imcc_m.imcc063_desc

            NEXT FIELD imcc063                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcc064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc064
            #add-point:ON ACTION controlp INFIELD imcc064 name="input.c.imcc064"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc071
            #add-point:ON ACTION controlp INFIELD imcc071 name="input.c.imcc071"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc072
            #add-point:ON ACTION controlp INFIELD imcc072 name="input.c.imcc072"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc073
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc073
            #add-point:ON ACTION controlp INFIELD imcc073 name="input.c.imcc073"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcc_m.imcc073             #給予default值

            #給予arg
            LET g_qryparam.arg1  = '7'     #製造批號 


            CALL q_oofg001_3()                                #呼叫開窗

            LET g_imcc_m.imcc073 = g_qryparam.return1              

            DISPLAY g_imcc_m.imcc073 TO imcc073              #
            CALL aimi102_get_oofg001_ref(g_imcc_m.imcc073) RETURNING g_imcc_m.imcc073_desc
            DISPLAY BY NAME g_imcc_m.imcc073_desc

            NEXT FIELD imcc073                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcc074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc074
            #add-point:ON ACTION controlp INFIELD imcc074 name="input.c.imcc074"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc081
            #add-point:ON ACTION controlp INFIELD imcc081 name="input.c.imcc081"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc082
            #add-point:ON ACTION controlp INFIELD imcc082 name="input.c.imcc082"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc083
            #add-point:ON ACTION controlp INFIELD imcc083 name="input.c.imcc083"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcc_m.imcc083             #給予default值

            #給予arg
            LET g_qryparam.arg1  = '8'     #製造序號 


            CALL q_oofg001_3()                                #呼叫開窗

            LET g_imcc_m.imcc083 = g_qryparam.return1              

            DISPLAY g_imcc_m.imcc083 TO imcc083              #
            CALL aimi102_get_oofg001_ref(g_imcc_m.imcc083) RETURNING g_imcc_m.imcc083_desc
            DISPLAY BY NAME g_imcc_m.imcc083_desc

            NEXT FIELD imcc083                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcc084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc084
            #add-point:ON ACTION controlp INFIELD imcc084 name="input.c.imcc084"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc091
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc091
            #add-point:ON ACTION controlp INFIELD imcc091 name="input.c.imcc091"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcc_m.imcc091             #給予default值

            #給予arg
            IF g_site='ALL' then
               #LET g_qryparam.arg1=l_site  #160729-00026#1
               LET g_qryparam.arg1=g_site_t #160729-00026#1 
            ELSE
               LET g_qryparam.arg1=g_site
            END IF
            CALL q_inaa001_23()                                #呼叫開窗

            LET g_imcc_m.imcc091 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.arg1=null
            DISPLAY g_imcc_m.imcc091 TO imcc091              #顯示到畫面上

            NEXT FIELD imcc091                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcc092
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc092
            #add-point:ON ACTION controlp INFIELD imcc092 name="input.c.imcc092"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imcc_m.imcc092             #給予default值

            #給予arg
            IF g_site='ALL' THEN
               #LET g_qryparam.where = "inab001 = '",g_imcc_m.imcc091,"' AND inabsite='",l_site,"'"  #160729-00026#1
               LET g_qryparam.where = "inab001 = '",g_imcc_m.imcc091,"' AND inabsite='",g_site_t,"'" #160729-00026#1 
            ELSE
               LET g_qryparam.where = "inab001 = '",g_imcc_m.imcc091,"' AND inabsite='",g_site,"'"
            END IF
            CALL q_inab002_12()                                #呼叫開窗
            
            LET g_qryparam.where = null
            LET g_imcc_m.imcc092 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imcc_m.imcc092 TO imcc092              #顯示到畫面上

            NEXT FIELD imcc092                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imcc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc103
            #add-point:ON ACTION controlp INFIELD imcc103 name="input.c.imcc103"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc104
            #add-point:ON ACTION controlp INFIELD imcc104 name="input.c.imcc104"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160617-00004#2--s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imcc_m.imcc104             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "30" #s

 
            CALL q_oofg001_3()                                #呼叫開窗
 
            LET g_imcc_m.imcc104 = g_qryparam.return1              

            DISPLAY g_imcc_m.imcc104 TO imcc104              #
            CALL aimi102_imcc104_ref(g_imcc_m.imcc104) RETURNING g_imcc_m.imcc104_desc
            DISPLAY BY NAME g_imcc_m.imcc104_desc

            NEXT FIELD imcc104                          #返回原欄位

            #160617-00004#2--e---

            #END add-point
 
 
         #Ctrlp:input.c.imcc105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc105
            #add-point:ON ACTION controlp INFIELD imcc105 name="input.c.imcc105"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc101
            #add-point:ON ACTION controlp INFIELD imcc101 name="input.c.imcc101"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc102
            #add-point:ON ACTION controlp INFIELD imcc102 name="input.c.imcc102"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc094
            #add-point:ON ACTION controlp INFIELD imcc094 name="input.c.imcc094"
            
            #END add-point
 
 
         #Ctrlp:input.c.imcc095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imcc095
            #add-point:ON ACTION controlp INFIELD imcc095 name="input.c.imcc095"
            
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
               SELECT COUNT(1) INTO l_count FROM imcc_t
                WHERE imccent = g_enterprise AND imccsite = g_site AND imcc051 = g_imcc_m.imcc051
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前 name="input.head.b_insert"
                  #160505-00002#3--s
                  #IF (cl_null(g_imcc_m.imcc094) AND cl_null(g_imcc_m.imcc095)) THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'aim-00071'
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #
                  #   NEXT FIELD imcc094
                  #END IF
                  #160505-00002#3--e
                  LET g_imcc051_t = g_imcc_m.imcc051
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO imcc_t (imccent, imccsite,imcc051,imcc052,imcc053,imcc054,imcc055,imcc057, 
                      imcc058,imcc059,imccstus,imccownid,imccowndp,imcccrtid,imcccrtdp,imcccrtdt,imccmodid, 
                      imccmoddt,imcc061,imcc062,imcc063,imcc064,imcc071,imcc072,imcc073,imcc074,imcc081, 
                      imcc082,imcc083,imcc084,imcc091,imcc092,imcc103,imcc104,imcc105,imcc101,imcc102, 
                      imcc094,imcc095)
                  VALUES (g_enterprise, g_site,g_imcc_m.imcc051,g_imcc_m.imcc052,g_imcc_m.imcc053,g_imcc_m.imcc054, 
                      g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058,g_imcc_m.imcc059,g_imcc_m.imccstus, 
                      g_imcc_m.imccownid,g_imcc_m.imccowndp,g_imcc_m.imcccrtid,g_imcc_m.imcccrtdp,g_imcc_m.imcccrtdt, 
                      g_imcc_m.imccmodid,g_imcc_m.imccmoddt,g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063, 
                      g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc074, 
                      g_imcc_m.imcc081,g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc084,g_imcc_m.imcc091, 
                      g_imcc_m.imcc092,g_imcc_m.imcc103,g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101, 
                      g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095) 
                  
                  #add-point:單頭新增中 name="input.head.m_insert"
                  #161013-00017#2 add-S
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcc_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_count = 1
                  SELECT COUNT(1) INTO l_count FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '201' AND oocq002 = g_imcc_m.imcc051
                  IF l_count = 0 THEN #新增分类码及说明
                     INSERT INTO oocq_t (oocqent,oocqstus,oocq001,oocq002,oocq003)
                     VALUES (g_enterprise,'Y','201',g_imcc_m.imcc051,'201')
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
                  #161013-00017#2 add-E
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcc_t:",SQLERRMESSAGE 
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
         IF '201' = g_master_multi_table_t.oocql001 AND
         g_imcc_m.imcc051 = g_master_multi_table_t.oocql002 AND
         g_imcc_m.oocql004 = g_master_multi_table_t.oocql004 AND 
         g_imcc_m.oocql005 = g_master_multi_table_t.oocql005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '201'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_imcc_m.imcc051
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_imcc_m.oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_imcc_m.oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                  
                  #add-point:單頭新增後 name="input.head.a_insert"
                  
                  #end add-point
                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_imcc_m.imcc051
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前 name="input.head.b_update"
               #160505-00002#3---s
               #IF (cl_null(g_imcc_m.imcc094) AND cl_null(g_imcc_m.imcc095)) THEN
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.code = 'aim-00071'
               #   LET g_errparam.extend = ''
               #   LET g_errparam.popup = TRUE
               #   CALL cl_err()
               #
               #   NEXT FIELD imcc094
               #END IF
               #160505-00002#3---e
               #end add-point
               
               #將遮罩欄位還原
               CALL aimi102_imcc_t_mask_restore('restore_mask_o')
               
               UPDATE imcc_t SET (imcc051,imcc052,imcc053,imcc054,imcc055,imcc057,imcc058,imcc059,imccstus, 
                   imccownid,imccowndp,imcccrtid,imcccrtdp,imcccrtdt,imccmodid,imccmoddt,imcc061,imcc062, 
                   imcc063,imcc064,imcc071,imcc072,imcc073,imcc074,imcc081,imcc082,imcc083,imcc084,imcc091, 
                   imcc092,imcc103,imcc104,imcc105,imcc101,imcc102,imcc094,imcc095) = (g_imcc_m.imcc051, 
                   g_imcc_m.imcc052,g_imcc_m.imcc053,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057, 
                   g_imcc_m.imcc058,g_imcc_m.imcc059,g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccowndp, 
                   g_imcc_m.imcccrtid,g_imcc_m.imcccrtdp,g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmoddt, 
                   g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063,g_imcc_m.imcc064,g_imcc_m.imcc071, 
                   g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc074,g_imcc_m.imcc081,g_imcc_m.imcc082, 
                   g_imcc_m.imcc083,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc092,g_imcc_m.imcc103, 
                   g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094, 
                   g_imcc_m.imcc095)
                WHERE imccent = g_enterprise AND imccsite = g_site AND imcc051 = g_imcc051_t #
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imcc_t:",SQLERRMESSAGE 
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
         IF '201' = g_master_multi_table_t.oocql001 AND
         g_imcc_m.imcc051 = g_master_multi_table_t.oocql002 AND
         g_imcc_m.oocql004 = g_master_multi_table_t.oocql004 AND 
         g_imcc_m.oocql005 = g_master_multi_table_t.oocql005  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'oocqlent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = '201'
            LET l_field_keys[02] = 'oocql001'
            LET l_var_keys_bak[02] = g_master_multi_table_t.oocql001
            LET l_var_keys[03] = g_imcc_m.imcc051
            LET l_field_keys[03] = 'oocql002'
            LET l_var_keys_bak[03] = g_master_multi_table_t.oocql002
            LET l_var_keys[04] = g_dlang
            LET l_field_keys[04] = 'oocql003'
            LET l_var_keys_bak[04] = g_dlang
            LET l_vars[01] = g_imcc_m.oocql004
            LET l_fields[01] = 'oocql004'
            LET l_vars[02] = g_imcc_m.oocql005
            LET l_fields[02] = 'oocql005'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'oocql_t')
         END IF 
 
                     
                     #將遮罩欄位進行遮蔽
                     CALL aimi102_imcc_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_imcc_m_t)
                     LET g_log2 = util.JSON.stringify(g_imcc_m)
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
 
{<section id="aimi102.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimi102_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE imcc_t.imcc051 
   DEFINE l_oldno     LIKE imcc_t.imcc051 
 
   DEFINE l_master    RECORD LIKE imcc_t.* #此變數樣板目前無使用
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
   IF g_imcc_m.imcc051 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_imcc051_t = g_imcc_m.imcc051
 
   
   #清空key值
   LET g_imcc_m.imcc051 = ""
 
    
   CALL aimi102_set_entry("a")
   CALL aimi102_set_no_entry("a")
   
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imcc_m.imccownid = g_user
      LET g_imcc_m.imccowndp = g_dept
      LET g_imcc_m.imcccrtid = g_user
      LET g_imcc_m.imcccrtdp = g_dept 
      LET g_imcc_m.imcccrtdt = cl_get_current()
      LET g_imcc_m.imccmodid = g_user
      LET g_imcc_m.imccmoddt = cl_get_current()
      LET g_imcc_m.imccstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_imcc_m.imccstus= "Y"
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcc_m.imccstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL aimi102_input("r")
   
   IF INT_FLAG THEN
      #取消
      INITIALIZE g_imcc_m.* TO NULL
      CALL aimi102_show()
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
      LET g_errparam.extend = "imcc_t:",SQLERRMESSAGE 
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
   CALL aimi102_set_act_visible()
   CALL aimi102_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_imcc051_t = g_imcc_m.imcc051
 
   
   #組合新增資料的條件
   LET g_add_browse = " imccent = " ||g_enterprise|| " AND imccsite = '" ||g_site|| "' AND",
                      " imcc051 = '", g_imcc_m.imcc051, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimi102_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
              
   LET g_data_owner = g_imcc_m.imccownid      
   LET g_data_dept  = g_imcc_m.imccowndp
              
   #功能已完成,通報訊息中心
   CALL aimi102_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.show" >}
#+ 資料顯示 
PRIVATE FUNCTION aimi102_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE  l_ooag002  LIKE ooag_t.ooag002
   #end add-point  
   
   #add-point:show段Function前置處理  name="show.before"
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimi102_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imcc051
            #161013-00017#2 mod-S
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='201' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_imcc_m.imcc051_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_imcc_m.imcc051_desc
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='201' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcc_m.oocql004 = g_rtn_fields[1]
            LET g_imcc_m.oocql005 = g_rtn_fields[2]
            DISPLAY BY NAME g_imcc_m.oocql004
            DISPLAY BY NAME g_imcc_m.oocql005
            #161013-00017#2 mod-E

            INITIALIZE g_ref_fields TO NULL
            #161116-00050#1 mark---start---
            #LET l_ooag002 = null
            #SELECT ooag002 INTO l_ooag002 FROM ooag_t WHERE ooag001=g_imcc_m.imcc052 AND ooagent = g_enterprise 
            #LET g_ref_fields[1] = l_ooag002
            #CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa001=? ","") RETURNING g_rtn_fields
            #LET g_imcc_m.imcc052_desc = g_rtn_fields[1]
            #161116-00050#1 mark---end---
            #161116-00050#1 add---start---
            SELECT ooag011 INTO g_imcc_m.imcc052_desc
              FROM ooag_t
             WHERE ooag001 = g_imcc_m.imcc052
               AND ooagent = g_enterprise
            #161116-00050#1 add---end---
            DISPLAY BY NAME g_imcc_m.imcc052_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imcc053
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcc_m.imcc053_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imcc053_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imccownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcc_m.imccownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imccownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imccowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcc_m.imccowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imccowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imcccrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcc_m.imcccrtid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imcccrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imcccrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imcc_m.imcccrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imcccrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imccmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imcc_m.imccmodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imccmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imcc091
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
            #160523-00031#2 mod
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? ","") RETURNING g_rtn_fields
            LET g_imcc_m.imcc091_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imcc091_desc

            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imcc_m.imcc091
            LET g_ref_fields[2] = g_imcc_m.imcc092
            CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
            LET g_imcc_m.imcc092_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imcc_m.imcc092_desc
            
            CALL aimi102_get_oofg001_ref(g_imcc_m.imcc063) RETURNING g_imcc_m.imcc063_desc
            DISPLAY BY NAME g_imcc_m.imcc063_desc

	         CALL aimi102_get_oofg001_ref(g_imcc_m.imcc073) RETURNING g_imcc_m.imcc073_desc
            DISPLAY BY NAME g_imcc_m.imcc073_desc

	         CALL aimi102_get_oofg001_ref(g_imcc_m.imcc083) RETURNING g_imcc_m.imcc083_desc
            DISPLAY BY NAME g_imcc_m.imcc083_desc

   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imcc_m.imcc051,g_imcc_m.oocql004,g_imcc_m.oocql005,g_imcc_m.imcc052,g_imcc_m.imcc052_desc, 
       g_imcc_m.imcc053,g_imcc_m.imcc053_desc,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058, 
       g_imcc_m.imcc059,g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp, 
       g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid,g_imcc_m.imcccrtid_desc,g_imcc_m.imcccrtdp,g_imcc_m.imcccrtdp_desc, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmodid_desc,g_imcc_m.imccmoddt,g_imcc_m.imcc061, 
       g_imcc_m.imcc062,g_imcc_m.imcc063,g_imcc_m.imcc063_desc,g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072, 
       g_imcc_m.imcc073,g_imcc_m.imcc073_desc,g_imcc_m.imcc074,g_imcc_m.imcc081,g_imcc_m.imcc082,g_imcc_m.imcc083, 
       g_imcc_m.imcc083_desc,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc091_desc,g_imcc_m.imcc092, 
       g_imcc_m.imcc092_desc,g_imcc_m.imcc103,g_imcc_m.imcc104,g_imcc_m.imcc104_desc,g_imcc_m.imcc105, 
       g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL aimi102_set_pk_array()
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imcc_m.imccstus 
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
 
{<section id="aimi102.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION aimi102_delete()
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
   IF g_imcc_m.imcc051 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_imcc051_t = g_imcc_m.imcc051
 
   
   LET g_master_multi_table_t.oocql001 = '201'
LET g_master_multi_table_t.oocql002 = g_imcc_m.imcc051
LET g_master_multi_table_t.oocql004 = g_imcc_m.oocql004
LET g_master_multi_table_t.oocql005 = g_imcc_m.oocql005
 
 
   OPEN aimi102_cl USING g_enterprise, g_site,g_imcc_m.imcc051
   IF SQLCA.SQLCODE THEN    #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi102_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE 
      CLOSE aimi102_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimi102_master_referesh USING g_site,g_imcc_m.imcc051 INTO g_imcc_m.imcc051,g_imcc_m.imcc052, 
       g_imcc_m.imcc053,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058,g_imcc_m.imcc059, 
       g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccowndp,g_imcc_m.imcccrtid,g_imcc_m.imcccrtdp, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmoddt,g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063, 
       g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc074,g_imcc_m.imcc081, 
       g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc092,g_imcc_m.imcc103, 
       g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095, 
       g_imcc_m.imcc052_desc,g_imcc_m.imcc053_desc,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid_desc, 
       g_imcc_m.imcccrtdp_desc,g_imcc_m.imccmodid_desc,g_imcc_m.imcc104_desc
   
   
   #檢查是否允許此動作
   IF NOT aimi102_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imcc_m_mask_o.* =  g_imcc_m.*
   CALL aimi102_imcc_t_mask()
   LET g_imcc_m_mask_n.* =  g_imcc_m.*
   
   #將最新資料顯示到畫面上
   CALL aimi102_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimi102_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
      DELETE FROM imcc_t 
       WHERE imccent = g_enterprise AND imccsite = g_site AND imcc051 = g_imcc_m.imcc051 
 
 
      #add-point:單頭刪除中 name="delete.head.m_delete"
      #161013-00017#2 mod-S
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcc_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      #多语言不删除
      {
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imcc_t:",SQLERRMESSAGE 
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
      }
      #161013-00017#2 mod-E
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imcc_m)   #(ver:49)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:49)
         CLOSE aimi102_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL aimi102_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL aimi102_browser_fill(g_wc,"")
         CALL aimi102_fetch("P")
      ELSE
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE    
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimi102_cl
 
   #功能已完成,通報訊息中心
   CALL aimi102_msgcentre_notify('delete')
 
   #add-point:單頭刪除完成後 name="delete.a_delete"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimi102_ui_browser_refresh()
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
      IF g_browser[l_i].b_imcc051 = g_imcc_m.imcc051
 
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
 
{<section id="aimi102.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimi102_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization" 
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point     
    
   #add-point:Function前置處理 name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("imcc051",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("imcc062",TRUE)
   CALL cl_set_comp_entry("imcc063",TRUE)
   CALL cl_set_comp_entry("imcc064",TRUE)
   CALL cl_set_comp_entry("imcc072",TRUE)
   CALL cl_set_comp_entry("imcc073",TRUE)
   CALL cl_set_comp_entry("imcc074",TRUE)
   CALL cl_set_comp_entry("imcc082",TRUE)
   CALL cl_set_comp_entry("imcc083",TRUE)
   CALL cl_set_comp_entry("imcc084",TRUE)
   
   CALL cl_set_comp_entry("imcc104,imcc105",TRUE)  #160617-00004#2
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimi102_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imcc051",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_imcc_m.imcc061 = '2' THEN
      CALL cl_set_comp_entry("imcc062",FALSE)
      CALL cl_set_comp_entry("imcc063",FALSE)
      CALL cl_set_comp_entry("imcc064",FALSE)
      LET g_imcc_m.imcc062 = 'N'
      LET g_imcc_m.imcc063 = ''
      LET g_imcc_m.imcc064 = '1'
   END IF
   IF g_imcc_m.imcc071 = '2' THEN
      CALL cl_set_comp_entry("imcc072",FALSE)
      CALL cl_set_comp_entry("imcc073",FALSE)
      CALL cl_set_comp_entry("imcc074",FALSE)
      LET g_imcc_m.imcc072 = 'N'
      LET g_imcc_m.imcc073 = ''
      LET g_imcc_m.imcc074 = '1'
   END IF
   IF g_imcc_m.imcc081 = '2' THEN
      CALL cl_set_comp_entry("imcc082",FALSE)
      CALL cl_set_comp_entry("imcc083",FALSE)
      CALL cl_set_comp_entry("imcc084",FALSE)
      LET g_imcc_m.imcc082 = 'N'
      LET g_imcc_m.imcc083 = ''
      LET g_imcc_m.imcc084 = '1'
   END IF
   
   #160617-00004#2--s--
   IF cl_null(g_imcc_m.imcc103) OR g_imcc_m.imcc103 = 'N' THEN
      CALL cl_set_comp_entry("imcc104,imcc105",FALSE)
      LET g_imcc_m.imcc104 = ''
      LET g_imcc_m.imcc104_desc = ''
      LET g_imcc_m.imcc105 = ''
      DISPLAY BY NAME g_imcc_m.imcc104,g_imcc_m.imcc104_desc,g_imcc_m.imcc105
   END IF
   #160617-00004#2---e
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimi102_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization" 
   
   #end add-point  
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete", TRUE)  #161122-00018#1   2016/11/25 By 08734 add
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi102.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimi102_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #161122-00018#1   2016/11/25 By 08734 add(S)
   IF g_imcc_m.imccstus <> 'Y' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)   
   END IF
   #161122-00018#1   2016/11/25 By 08734 add(E)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimi102.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimi102_default_search()
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
      LET ls_wc = ls_wc, " imcc051 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " imcc051 = '", g_argv[02], "' AND "
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
      LET g_wc = g_wc , " AND imccsite = '", g_argv[01], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimi102.mask_functions" >}
&include "erp/aim/aimi102_mask.4gl"
 
{</section>}
 
{<section id="aimi102.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aimi102_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imcc_m.imcc051 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aimi102_cl USING g_enterprise, g_site,g_imcc_m.imcc051
   IF STATUS THEN
      CLOSE aimi102_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimi102_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aimi102_master_referesh USING g_site,g_imcc_m.imcc051 INTO g_imcc_m.imcc051,g_imcc_m.imcc052, 
       g_imcc_m.imcc053,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058,g_imcc_m.imcc059, 
       g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccowndp,g_imcc_m.imcccrtid,g_imcc_m.imcccrtdp, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmoddt,g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063, 
       g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc074,g_imcc_m.imcc081, 
       g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc092,g_imcc_m.imcc103, 
       g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095, 
       g_imcc_m.imcc052_desc,g_imcc_m.imcc053_desc,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid_desc, 
       g_imcc_m.imcccrtdp_desc,g_imcc_m.imccmodid_desc,g_imcc_m.imcc104_desc
   
 
   #檢查是否允許此動作
   IF NOT aimi102_action_chk() THEN
      CLOSE aimi102_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imcc_m.imcc051,g_imcc_m.oocql004,g_imcc_m.oocql005,g_imcc_m.imcc052,g_imcc_m.imcc052_desc, 
       g_imcc_m.imcc053,g_imcc_m.imcc053_desc,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058, 
       g_imcc_m.imcc059,g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp, 
       g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid,g_imcc_m.imcccrtid_desc,g_imcc_m.imcccrtdp,g_imcc_m.imcccrtdp_desc, 
       g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmodid_desc,g_imcc_m.imccmoddt,g_imcc_m.imcc061, 
       g_imcc_m.imcc062,g_imcc_m.imcc063,g_imcc_m.imcc063_desc,g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072, 
       g_imcc_m.imcc073,g_imcc_m.imcc073_desc,g_imcc_m.imcc074,g_imcc_m.imcc081,g_imcc_m.imcc082,g_imcc_m.imcc083, 
       g_imcc_m.imcc083_desc,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc091_desc,g_imcc_m.imcc092, 
       g_imcc_m.imcc092_desc,g_imcc_m.imcc103,g_imcc_m.imcc104,g_imcc_m.imcc104_desc,g_imcc_m.imcc105, 
       g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094,g_imcc_m.imcc095
 
   CASE g_imcc_m.imccstus
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
         CASE g_imcc_m.imccstus
            
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
      g_imcc_m.imccstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aimi102_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_imcc_m.imccmodid = g_user
   LET g_imcc_m.imccmoddt = cl_get_current()
   LET g_imcc_m.imccstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imcc_t 
      SET (imccstus,imccmodid,imccmoddt) 
        = (g_imcc_m.imccstus,g_imcc_m.imccmodid,g_imcc_m.imccmoddt)     
    WHERE imccent = g_enterprise AND imccsite = g_site AND imcc051 = g_imcc_m.imcc051
 
    
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
      EXECUTE aimi102_master_referesh USING g_site,g_imcc_m.imcc051 INTO g_imcc_m.imcc051,g_imcc_m.imcc052, 
          g_imcc_m.imcc053,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057,g_imcc_m.imcc058,g_imcc_m.imcc059, 
          g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccowndp,g_imcc_m.imcccrtid,g_imcc_m.imcccrtdp, 
          g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmoddt,g_imcc_m.imcc061,g_imcc_m.imcc062, 
          g_imcc_m.imcc063,g_imcc_m.imcc064,g_imcc_m.imcc071,g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc074, 
          g_imcc_m.imcc081,g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc084,g_imcc_m.imcc091,g_imcc_m.imcc092, 
          g_imcc_m.imcc103,g_imcc_m.imcc104,g_imcc_m.imcc105,g_imcc_m.imcc101,g_imcc_m.imcc102,g_imcc_m.imcc094, 
          g_imcc_m.imcc095,g_imcc_m.imcc052_desc,g_imcc_m.imcc053_desc,g_imcc_m.imccownid_desc,g_imcc_m.imccowndp_desc, 
          g_imcc_m.imcccrtid_desc,g_imcc_m.imcccrtdp_desc,g_imcc_m.imccmodid_desc,g_imcc_m.imcc104_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imcc_m.imcc051,g_imcc_m.oocql004,g_imcc_m.oocql005,g_imcc_m.imcc052,g_imcc_m.imcc052_desc, 
          g_imcc_m.imcc053,g_imcc_m.imcc053_desc,g_imcc_m.imcc054,g_imcc_m.imcc055,g_imcc_m.imcc057, 
          g_imcc_m.imcc058,g_imcc_m.imcc059,g_imcc_m.imccstus,g_imcc_m.imccownid,g_imcc_m.imccownid_desc, 
          g_imcc_m.imccowndp,g_imcc_m.imccowndp_desc,g_imcc_m.imcccrtid,g_imcc_m.imcccrtid_desc,g_imcc_m.imcccrtdp, 
          g_imcc_m.imcccrtdp_desc,g_imcc_m.imcccrtdt,g_imcc_m.imccmodid,g_imcc_m.imccmodid_desc,g_imcc_m.imccmoddt, 
          g_imcc_m.imcc061,g_imcc_m.imcc062,g_imcc_m.imcc063,g_imcc_m.imcc063_desc,g_imcc_m.imcc064, 
          g_imcc_m.imcc071,g_imcc_m.imcc072,g_imcc_m.imcc073,g_imcc_m.imcc073_desc,g_imcc_m.imcc074, 
          g_imcc_m.imcc081,g_imcc_m.imcc082,g_imcc_m.imcc083,g_imcc_m.imcc083_desc,g_imcc_m.imcc084, 
          g_imcc_m.imcc091,g_imcc_m.imcc091_desc,g_imcc_m.imcc092,g_imcc_m.imcc092_desc,g_imcc_m.imcc103, 
          g_imcc_m.imcc104,g_imcc_m.imcc104_desc,g_imcc_m.imcc105,g_imcc_m.imcc101,g_imcc_m.imcc102, 
          g_imcc_m.imcc094,g_imcc_m.imcc095
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   IF g_imcc_m.imccstus <> 'Y' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)   
   END IF
   #end add-point  
 
   CLOSE aimi102_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimi102_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi102.signature" >}
   
 
{</section>}
 
{<section id="aimi102.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimi102_set_pk_array()
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
   LET g_pk_array[1].values = g_imcc_m.imcc051
   LET g_pk_array[1].column = 'imcc051'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi102.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="aimi102.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimi102_msgcentre_notify(lc_state)
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
   CALL aimi102_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imcc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimi102.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimi102_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization" 
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimi102.other_function" readonly="Y" >}
#+ chk imcc051
PRIVATE FUNCTION aimi102_chk_imcc051(p_imcc051)
   DEFINE p_imcc051 LIKE imcc_t.imcc051
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_imcc051
   #161013-00017#2 mod-S
#   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='201' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004,oocql005 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='201' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   #161013-00017#2 mod-E
   #161013-00017#2 marked-S
#   LET g_imcc_m.imcc051_desc = g_rtn_fields[1]     
#   DISPLAY BY NAME g_imcc_m.imcc051_desc
   #161013-00017#2 marked-E
   #161013-00017#2 add-S
   LET g_imcc_m.oocql004 = g_rtn_fields[1]
   LET g_imcc_m.oocql005 = g_rtn_fields[2]
   DISPLAY BY NAME g_imcc_m.oocql004
   DISPLAY BY NAME g_imcc_m.oocql005
   #161013-00017#2 add-E
END FUNCTION
#+
PRIVATE FUNCTION aimi102_imcc095()
   LET g_errno = null
   IF NOT cl_null(g_imcc_m.imcc095) THEN
      IF (g_imcc_m.imcc095<0 OR g_imcc_m.imcc095 >100 )THEN
         LET g_errno = 'aim-00011'
      END IF
   END IF
END FUNCTION
#+ chk imcc094
PRIVATE FUNCTION aimi102_imcc094()
  LET g_errno = null
  IF NOT cl_null(g_imcc_m.imcc094) THEN
      IF g_imcc_m.imcc094<0 THEN
         LET g_errno = 'aim-00009'
      END IF
   END IF
END FUNCTION
#+ chk imcc092
PRIVATE FUNCTION aimi102_imcc092()
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_cnt1  LIKE type_t.num5
   LET g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   if g_site='ALL' then
   SELECT count(*) INTO l_cnt FROM inab_t 
    WHERE inab001 = g_imcc_m.imcc091 AND inab002 = g_imcc_m.imcc092
      AND inabent = g_enterprise 
      #AND inabsite = l_site   #160729-00026#1 
      AND inabsite = g_site_t   #160729-00026#1 
   IF l_cnt <= 0  THEN
      LET g_errno = 'aim-00062'
   ELSE
      SELECT count(*) INTO l_cnt1 FROM inab_t 
       WHERE inab001 = g_imcc_m.imcc091 AND inab002 = g_imcc_m.imcc092
         AND inabent = g_enterprise  AND inabstus='Y' 
         #AND inabsite = l_site  #160729-00026#1 
         AND inabsite = g_site_t   #160729-00026#1 
      IF l_cnt1 <= 0  THEN
         LET g_errno = 'sub-01302'  #160318-00005#19 mod 'aim-00063'
      END IF
   END IF
   else 
      SELECT count(*) INTO l_cnt FROM inab_t 
       WHERE inab001 = g_imcc_m.imcc091 AND inab002 = g_imcc_m.imcc092
         AND inabent = g_enterprise AND inabsite = g_site 
      IF l_cnt <= 0  THEN
         LET g_errno = 'aim-00062'
      ELSE
         SELECT count(*) INTO l_cnt1 FROM inab_t 
          WHERE inab001 = g_imcc_m.imcc091 AND inab002 = g_imcc_m.imcc092
            AND inabent = g_enterprise  AND inabstus='Y' AND inabsite = g_site
         IF l_cnt1 <= 0  THEN
            LET g_errno = 'sub-01302'  #160318-00005#19 mod 'aim-00063'
         END IF
      END IF
   end if
   IF NOT cl_null(g_imcc_m.imcc092) THEN
      LET g_imcc_m.imcc092_desc = NULL
   END IF
END FUNCTION
#+ chk imcc051
PRIVATE FUNCTION aimi102_imcc051(p_imcc051)
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_cnt1  LIKE type_t.num5
   DEFINE p_imcc051  LIKE imcc_t.imcc051
   LET g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT count(*) INTO l_cnt FROM oocq_t 
    WHERE oocq001='201' AND oocq002=p_imcc051
      AND oocqent=g_enterprise
   IF l_cnt <= 0  THEN
      LET g_errno = 'aim-00218' 
   ELSE
      SELECT count(*) INTO l_cnt1 FROM oocq_t 
       WHERE oocq001='201' AND oocq002=p_imcc051
         AND oocqent=g_enterprise AND oocqstus = 'Y'
      IF l_cnt1 <= 0  THEN
         LET g_errno = 'aim-00219'  
      END IF
   END IF
   IF NOT cl_null(g_errno) THEN   
      #161013-00017#2 mod-S
#      LET g_imcc_m.imcc051_desc = null
      LET g_imcc_m.oocql004 = null
      LET g_imcc_m.oocql005 = null
      #161013-00017#2 mod-E
   END IF  
END FUNCTION
#+ display imcc053_desc
PRIVATE FUNCTION aimi102_display_imcc053()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imcc_m.imcc053
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imcc_m.imcc053_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imcc_m.imcc053_desc
END FUNCTION
#+ chk imcc052
PRIVATE FUNCTION aimi102_chk_imcc052()
   DEFINE  l_ooag002   LIKE ooag_t.ooag002
   INITIALIZE g_ref_fields TO NULL
   LET l_ooag002 = null
   SELECT ooag002 INTO l_ooag002 FROM ooag_t WHERE ooag001=g_imcc_m.imcc052 AND ooagent = g_enterprise
            
   LET g_ref_fields[1] = l_ooag002
   CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM oofa_t WHERE oofaent='"||g_enterprise||"' AND oofa001=? ","") RETURNING g_rtn_fields
   LET g_imcc_m.imcc052_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imcc_m.imcc052_desc 
END FUNCTION
#+ chk imcc091
PRIVATE FUNCTION aimi102_imcc091()
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_cnt1  LIKE type_t.num5
   LET g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   if g_site='ALL' then
   SELECT count(*) INTO l_cnt FROM inaa_t 
    WHERE inaa001 = g_imcc_m.imcc091
      AND inaaent = g_enterprise 
      #AND inaasite = l_site  #160729-00026#1 
      AND inaasite = g_site_t   #160729-00026#1 
   IF l_cnt <= 0  THEN
      LET g_errno = 'aim-00064'
   ELSE
      SELECT count(*) INTO l_cnt1 FROM inaa_t 
       WHERE inaa001 = g_imcc_m.imcc091
         AND inaaent = g_enterprise AND inaastus='Y' 
         #AND inaasite = l_site  #160729-00026#1 
         AND inaasite = g_site_t   #160729-00026#1 
      IF l_cnt1 <= 0  THEN
         LET g_errno = 'sub-01302'  #160318-00005#19 mod 'aim-00065'
      END IF
   END IF 
   else
      SELECT count(*) INTO l_cnt FROM inaa_t 
       WHERE inaa001 = g_imcc_m.imcc091
         AND inaaent = g_enterprise AND inaasite = g_site
      IF l_cnt <= 0  THEN
         LET g_errno = 'aim-00064'
      ELSE
         SELECT count(*) INTO l_cnt1 FROM inaa_t 
          WHERE inaa001 = g_imcc_m.imcc091
            AND inaaent = g_enterprise AND inaastus='Y' AND inaasite = g_site
         IF l_cnt1 <= 0  THEN
            LET g_errno = 'sub-01302'  #160318-00005#19 mod 'aim-00065'
         END IF
      END IF
   end if
   IF NOT cl_null(g_imcc_m.imcc091) THEN
      LET g_imcc_m.imcc091_desc = NULL
   END IF
END FUNCTION
#+ chk imcc053
PRIVATE FUNCTION aimi102_imcc053()
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_cnt1  LIKE type_t.num5
   LET g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT count(*) INTO l_cnt FROM ooca_t 
    WHERE ooca001=g_imcc_m.imcc053
      AND oocaent=g_enterprise
   IF l_cnt <= 0  THEN
      LET g_errno = 'aim-00004'
   ELSE
      SELECT count(*) INTO l_cnt1 FROM ooca_t 
       WHERE ooca001=g_imcc_m.imcc053
         AND oocaent=g_enterprise AND oocastus='Y'
      IF l_cnt1 <= 0  THEN
         LET g_errno =  'sub-01302'  #160318-00005#19 mod 'aim-00005'
      END IF
   END IF
   IF NOT cl_null(g_errno) THEN
      LET g_imcc_m.imcc053_desc = NULL
   END IF
END FUNCTION
#+ chk imcc052
PRIVATE FUNCTION aimi102_imcc052()
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_cnt1     LIKE type_t.num5
   DEFINE l_ooag002  LIKE ooag_t.ooag002
   LET g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT count(*) INTO l_cnt FROM ooag_t 
    WHERE ooag001=g_imcc_m.imcc052
      AND ooagent=g_enterprise
   IF l_cnt <= 0  THEN
      LET g_errno = 'aim-00069'
   ELSE
      SELECT count(*) INTO l_cnt1 FROM ooag_t 
       WHERE ooag001=g_imcc_m.imcc052
         AND ooagent=g_enterprise AND ooagstus='Y'
      IF l_cnt1 <= 0  THEN   
          LET g_errno = 'sub-01302'  #160318-00005#19 mod 'aim-00070'
      END IF          
   END IF
   IF NOT cl_null(g_errno) THEN
      LET g_imcc_m.imcc052_desc = NULL
   END IF
END FUNCTION

##display imcc091
PRIVATE FUNCTION aimi102_imcc091_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imcc_m.imcc091
   CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"' ","") RETURNING g_rtn_fields
   LET g_imcc_m.imcc091_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imcc_m.imcc091_desc
END FUNCTION

##display imcc092
PRIVATE FUNCTION aimi102_imcc092_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imcc_m.imcc091
   LET g_ref_fields[2] = g_imcc_m.imcc092
   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inab001=? AND inab002=? ","") RETURNING g_rtn_fields
   LET g_imcc_m.imcc092_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imcc_m.imcc092_desc
END FUNCTION
#取得自動編碼的說明
PRIVATE FUNCTION aimi102_get_oofg001_ref(p_oofgl001)
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
#設定欄位是否必要輸入
PRIVATE FUNCTION aimi102_set_no_required()

   #CALL cl_set_comp_required("imaf063,imaf073,imaf083",FALSE)  #160620-00023#1 mark

END FUNCTION
#設定欄位是否必要輸入
PRIVATE FUNCTION aimi102_set_required()
   #160620-00023#1---mark---s
   #IF g_imcc_m.imcc062 = 'Y' THEN
   #   CALL cl_set_comp_required("imcc063",TRUE)
   #END IF
   #IF g_imcc_m.imcc072 = 'Y' THEN
   #   CALL cl_set_comp_required("imcc073",TRUE)
   #END IF
   #IF g_imcc_m.imcc082 = 'Y' THEN
   #   CALL cl_set_comp_required("imcc083",TRUE)
   #END IF
   #160620-00023#1---mark---e
END FUNCTION

#160617-00004#2
PRIVATE FUNCTION aimi102_imcc104_ref(p_imcc104)
DEFINE p_imcc104      LIKE imcc_t.imcc104
DEFINE r_imcc104_desc LIKE oofgl_t.oofgl004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_imcc104
   CALL ap_ref_array2(g_ref_fields,"SELECT oofgl004 FROM oofgl_t WHERE oofglent='"||g_enterprise||"' AND oofgl001=? AND oofgl002=' ' AND oofgl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_imcc104_desc =  g_rtn_fields[1]
   RETURN r_imcc104_desc
   
END FUNCTION

 
{</section>}
 
