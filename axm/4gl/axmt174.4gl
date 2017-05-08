#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt174.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-06-29 16:09:15), PR版次:0013(2016-12-02 17:56:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000368
#+ Filename...: axmt174
#+ Description: 銷售預測生管調整作業(跨營運據點）
#+ Creator....: 01534(2014-03-27 18:02:15)
#+ Modifier...: 02749 -SD/PR- 08171
 
{</section>}
 
{<section id="axmt174.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#49  2016/03/29 by pengxin  修正azzi920重复定义之错误讯息
#161013-00051#1   2016/10/18 By shiun    整批調整據點組織開窗
#161109-00085#8   2016/11/10 By 08993    整批調整系統星號寫法
#161109-00085#64  2016/11/30 By 08171    整批調整系統星號寫法
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
PRIVATE type type_g_xmig_m        RECORD
       xmigsite LIKE xmig_t.xmigsite, 
   xmigsite_desc LIKE type_t.chr80, 
   xmig002 LIKE xmig_t.xmig002, 
   xmig001 LIKE xmig_t.xmig001, 
   xmig001_desc LIKE type_t.chr80, 
   xmig003 LIKE xmig_t.xmig003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xmig_d        RECORD
       xmig017 LIKE xmig_t.xmig017, 
   xmig006 LIKE xmig_t.xmig006, 
   xmig006_desc LIKE type_t.chr500, 
   xmig006_desc_desc LIKE type_t.chr500, 
   xmig007 LIKE xmig_t.xmig007, 
   xmig007_desc LIKE type_t.chr500, 
   xmig006_desc2 LIKE type_t.chr500, 
   xmig006_desc3 LIKE type_t.chr500, 
   xmig004 LIKE xmig_t.xmig004, 
   xmig004_desc LIKE type_t.chr500, 
   xmig005 LIKE xmig_t.xmig005, 
   xmig005_desc LIKE type_t.chr500, 
   xmig008 LIKE xmig_t.xmig008, 
   xmig008_desc LIKE type_t.chr500, 
   xmig009 LIKE xmig_t.xmig009, 
   xmig009_desc LIKE type_t.chr500, 
   xmig010 LIKE xmig_t.xmig010, 
   xmig018 LIKE xmig_t.xmig018, 
   xmig018_desc LIKE type_t.chr500, 
   xmig013 LIKE xmig_t.xmig013, 
   l_xmig013_01 LIKE type_t.num20_6, 
   l_xmig013_02 LIKE type_t.num20_6, 
   l_xmig013_03 LIKE type_t.num20_6, 
   l_xmig013_04 LIKE type_t.num20_6, 
   l_xmig013_05 LIKE type_t.num20_6, 
   l_xmig013_06 LIKE type_t.num20_6, 
   l_xmig013_07 LIKE type_t.num20_6, 
   l_xmig013_08 LIKE type_t.num20_6, 
   l_xmig013_09 LIKE type_t.num20_6, 
   l_xmig013_10 LIKE type_t.num20_6, 
   l_xmig013_11 LIKE type_t.num20_6, 
   l_xmig013_12 LIKE type_t.num20_6, 
   l_xmig013_13 LIKE type_t.num20_6, 
   l_xmig013_14 LIKE type_t.num20_6, 
   l_xmig013_15 LIKE type_t.num20_6, 
   l_xmig013_16 LIKE type_t.num20_6, 
   l_xmig013_17 LIKE type_t.num20_6, 
   l_xmig013_18 LIKE type_t.num20_6, 
   l_xmig013_19 LIKE type_t.num20_6, 
   l_xmig013_20 LIKE type_t.num20_6, 
   l_xmig013_21 LIKE type_t.num20_6, 
   l_xmig013_22 LIKE type_t.num20_6, 
   l_xmig013_23 LIKE type_t.num20_6, 
   l_xmig013_24 LIKE type_t.num20_6, 
   xmig016 LIKE xmig_t.xmig016, 
   l_xmig016_01 LIKE type_t.num20_6, 
   l_xmig016_02 LIKE type_t.num20_6, 
   l_xmig016_03 LIKE type_t.num20_6, 
   l_xmig016_04 LIKE type_t.num20_6, 
   l_xmig016_05 LIKE type_t.num20_6, 
   l_xmig016_06 LIKE type_t.num20_6, 
   l_xmig016_07 LIKE type_t.num20_6, 
   l_xmig016_08 LIKE type_t.num20_6, 
   l_xmig016_09 LIKE type_t.num20_6, 
   l_xmig016_10 LIKE type_t.num20_6, 
   l_xmig016_11 LIKE type_t.num20_6, 
   l_xmig016_12 LIKE type_t.num20_6, 
   l_xmig016_13 LIKE type_t.num20_6, 
   l_xmig016_14 LIKE type_t.num20_6, 
   l_xmig016_15 LIKE type_t.num20_6, 
   l_xmig016_16 LIKE type_t.num20_6, 
   l_xmig016_17 LIKE type_t.chr10, 
   l_xmig016_18 LIKE type_t.num20_6, 
   l_xmig016_19 LIKE type_t.num20_6, 
   l_xmig016_20 LIKE type_t.num20_6, 
   l_xmig016_21 LIKE type_t.num20_6, 
   l_xmig016_22 LIKE type_t.num20_6, 
   l_xmig016_23 LIKE type_t.num20_6, 
   l_xmig016_24 LIKE type_t.chr500, 
   l_xmig016_s LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_forupd_sql2     STRING
 TYPE type_g_xmig2_d        RECORD
   l_xmig006_2           LIKE xmig_t.xmig006,
   l_xmig006_2_desc      LIKE type_t.chr500,
   l_xmig006_2_desc1     LIKE type_t.chr500,
   l_xmig006_2_desc2     LIKE type_t.chr500, 
   l_xmig006_2_desc3     LIKE type_t.chr500,
   l_xmig010_2           LIKE xmig_t.xmig010,
   l_xmig013_2_01 LIKE type_t.num20_6,
   l_xmig013_2_02 LIKE type_t.num20_6,
   l_xmig013_2_03 LIKE type_t.num20_6,
   l_xmig013_2_04 LIKE type_t.num20_6,
   l_xmig013_2_05 LIKE type_t.num20_6,
   l_xmig013_2_06 LIKE type_t.num20_6,
   l_xmig013_2_07 LIKE type_t.num20_6,
   l_xmig013_2_08 LIKE type_t.num20_6,
   l_xmig013_2_09 LIKE type_t.num20_6,
   l_xmig013_2_10 LIKE type_t.num20_6,
   l_xmig013_2_11 LIKE type_t.num20_6,
   l_xmig013_2_12 LIKE type_t.num20_6,
   l_xmig013_2_13 LIKE type_t.num20_6,
   l_xmig013_2_14 LIKE type_t.num20_6,
   l_xmig013_2_15 LIKE type_t.num20_6,
   l_xmig013_2_16 LIKE type_t.num20_6,
   l_xmig013_2_17 LIKE type_t.num20_6,
   l_xmig013_2_18 LIKE type_t.num20_6,
   l_xmig013_2_19 LIKE type_t.num20_6,
   l_xmig013_2_20 LIKE type_t.num20_6,
   l_xmig013_2_21 LIKE type_t.num20_6,
   l_xmig013_2_22 LIKE type_t.num20_6,
   l_xmig013_2_23 LIKE type_t.num20_6,
   l_xmig013_2_24 LIKE type_t.num20_6,
   l_xmig016_2_01 LIKE type_t.num20_6,
   l_xmig016_2_02 LIKE type_t.num20_6,
   l_xmig016_2_03 LIKE type_t.num20_6,
   l_xmig016_2_04 LIKE type_t.num20_6,
   l_xmig016_2_05 LIKE type_t.num20_6,
   l_xmig016_2_06 LIKE type_t.num20_6,
   l_xmig016_2_07 LIKE type_t.num20_6,
   l_xmig016_2_08 LIKE type_t.num20_6,
   l_xmig016_2_09 LIKE type_t.num20_6,
   l_xmig016_2_10 LIKE type_t.num20_6,
   l_xmig016_2_11 LIKE type_t.num20_6,
   l_xmig016_2_12 LIKE type_t.num20_6,
   l_xmig016_2_13 LIKE type_t.num20_6,
   l_xmig016_2_14 LIKE type_t.num20_6,
   l_xmig016_2_15 LIKE type_t.num20_6,
   l_xmig016_2_16 LIKE type_t.num20_6,
   l_xmig016_2_17 LIKE type_t.num20_6,
   l_xmig016_2_18 LIKE type_t.num20_6,
   l_xmig016_2_19 LIKE type_t.num20_6,
   l_xmig016_2_20 LIKE type_t.num20_6,
   l_xmig016_2_21 LIKE type_t.num20_6,
   l_xmig016_2_22 LIKE type_t.num20_6,
   l_xmig016_2_23 LIKE type_t.num20_6,
   l_xmig016_2_24 LIKE type_t.num20_6,
   l_xmig016_2_s  LIKE type_t.num20_6   
                  END RECORD
DEFINE g_xmig2_d          DYNAMIC ARRAY OF type_g_xmig2_d     
DEFINE g_xmig2_d_t        type_g_xmig2_d  
DEFINE g_rec_b1           LIKE type_t.num5
DEFINE g_flag             LIKE type_t.num5
 TYPE type_g_xmig3_d        RECORD
   xmig004 LIKE xmig_t.xmig004,
   xmig004_desc LIKE type_t.chr500,
   xmig005 LIKE xmig_t.xmig005,
   xmig005_desc LIKE type_t.chr500,
   xmig008 LIKE xmig_t.xmig008,
   xmig008_desc LIKE type_t.chr500,
   xmig009 LIKE xmig_t.xmig009,
   xmig009_desc LIKE type_t.chr500,
   xmig006 LIKE xmig_t.xmig006,
   xmig006_desc LIKE type_t.chr500,
   xmig006_desc1 LIKE type_t.chr500,
   xmig007 LIKE xmig_t.xmig007,
   xmig006_desc2 LIKE type_t.chr500,
   xmig006_desc3 LIKE rtaxl_t.rtaxl003,
   xmig010 LIKE xmig_t.xmig010,
   xmig013 LIKE type_t.num20_6,
   xmig016 LIKE type_t.num20_6,
   l_xmig016_s LIKE type_t.num20_6,
   xmig017 LIKE xmig_t.xmig017
                 END RECORD
DEFINE g_xmig3_d          DYNAMIC ARRAY OF type_g_xmig3_d     
DEFINE g_xmig3_d_t        type_g_xmig3_d  
DEFINE g_rate             LIKE type_t.num5
DEFINE g_number           LIKE type_t.num20_6  
DEFINE g_rec_b2           LIKE type_t.num5
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xmig_m          type_g_xmig_m
DEFINE g_xmig_m_t        type_g_xmig_m
DEFINE g_xmig_m_o        type_g_xmig_m
DEFINE g_xmig_m_mask_o   type_g_xmig_m #轉換遮罩前資料
DEFINE g_xmig_m_mask_n   type_g_xmig_m #轉換遮罩後資料
 
   DEFINE g_xmigsite_t LIKE xmig_t.xmigsite
DEFINE g_xmig002_t LIKE xmig_t.xmig002
DEFINE g_xmig001_t LIKE xmig_t.xmig001
DEFINE g_xmig003_t LIKE xmig_t.xmig003
 
 
DEFINE g_xmig_d          DYNAMIC ARRAY OF type_g_xmig_d
DEFINE g_xmig_d_t        type_g_xmig_d
DEFINE g_xmig_d_o        type_g_xmig_d
DEFINE g_xmig_d_mask_o   DYNAMIC ARRAY OF type_g_xmig_d #轉換遮罩前資料
DEFINE g_xmig_d_mask_n   DYNAMIC ARRAY OF type_g_xmig_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xmigsite LIKE xmig_t.xmigsite,
   b_xmigsite_desc LIKE type_t.chr80,
      b_xmig001 LIKE xmig_t.xmig001,
   b_xmig001_desc LIKE type_t.chr80,
      b_xmig002 LIKE xmig_t.xmig002,
      b_xmig003 LIKE xmig_t.xmig003
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"
DEFINE g_xmib   DYNAMIC ARRAY OF RECORD
              xmib002     LIKE xmib_t.xmib002,
              xmib003     LIKE xmib_t.xmib003,
              b_date      LIKE type_t.chr80,
              e_date      LIKE type_t.chr80
       END RECORD       
#end add-point
 
{</section>}
 
{<section id="axmt174.main" >}
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
   LET g_forupd_sql = " SELECT xmigsite,'',xmig002,xmig001,'',xmig003", 
                      " FROM xmig_t",
                      " WHERE xmigent= ? AND xmigsite=? AND xmig001=? AND xmig002=? AND xmig003=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt174_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xmigsite,t0.xmig002,t0.xmig001,t0.xmig003,t1.ooefl003 ,t2.xmial003", 
 
               " FROM xmig_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xmigsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN xmial_t t2 ON t2.xmialent="||g_enterprise||" AND t2.xmial001=t0.xmig001 AND t2.xmial002='"||g_dlang||"' ",
 
               " WHERE t0.xmigent = " ||g_enterprise|| " AND t0.xmigsite = ? AND t0.xmig001 = ? AND t0.xmig002 = ? AND t0.xmig003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmt174_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmt174 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmt174_init()   
 
      #進入選單 Menu (="N")
      CALL axmt174_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmt174
      
   END IF 
   
   CLOSE axmt174_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmt174.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmt174_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE ls_hide   STRING
   DEFINE li_i      LIKE type_t.num5
   DEFINE lc_index  LIKE type_t.chr2   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   IF g_code = 'axmt176' THEN
      LET g_argv[1] = '2'
   END IF   
   IF g_argv[1] = '2' THEN  
      CALL cl_set_comp_visible("xmigsite",FALSE)
   END IF
   CALL cl_set_combo_scc('xmig017','3014') 
   LET ls_hide = ' '   
   FOR li_i = 1 TO 24     #欄位的隱藏
      LET lc_index = li_i USING '&&' 
      IF li_i = 1 THEN      
         LET ls_hide = ls_hide || "l_xmig013_" || lc_index || ",l_xmig013_2_" || lc_index || ",l_xmig016_" || lc_index || ",l_xmig016_2_" || lc_index                   
      ELSE
         LET ls_hide = ls_hide || ",l_xmig013_" || lc_index || ",l_xmig013_2_" || lc_index || ",l_xmig016_" || lc_index || ",l_xmig016_2_" || lc_index                             
      END IF    
   END FOR  
   CALL cl_set_comp_visible(ls_hide,FALSE) 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN  
      CALL cl_set_comp_visible("xmig007,xmig007_desc",FALSE) 
   END IF     
   #end add-point
   
   CALL axmt174_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axmt174.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axmt174_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog                  STRING,
          actionid              STRING,
          background            LIKE type_t.chr1,
          param                 DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE li_idx                LIKE type_t.num10
   DEFINE ls_wc                 STRING
   DEFINE lb_first              BOOLEAN
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_act     LIKE type_t.chr1
   DEFINE l_cmd     STRING
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0 
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL cl_set_combo_scc('xmig017','3014') 
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xmig_m.* TO NULL
         CALL g_xmig_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmt174_init()
      END IF
 
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
         
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axmt174_idx_chk()
               CALL axmt174_fetch('') # reload data
               LET g_detail_idx = 1
               CALL axmt174_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_xmig_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axmt174_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axmt174_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xmig2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b1) #page1  

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axmt174_ui_detailshow()

               #add-point:page1自定義行為

               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axmt174_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axmt174_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axmt174_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            CALL cl_set_act_visible("insert,delete,modify,modify_detail,reproduce", FALSE)
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL axmt174_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axmt174_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt174_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axmt174_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt174_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axmt174_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt174_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axmt174_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt174_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axmt174_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt174_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_xmig_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_xmig2_d)
                  LET g_export_id[2]   = "s_detail2"
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION mainhidden       #主頁摺疊
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
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD xmig004
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axmt174_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axmt174_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axmt174_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axmt174_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axmt174_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION adjust_batch
            LET g_action_choice="adjust_batch"
            IF cl_auth_chk_act("adjust_batch") THEN
               
               #add-point:ON ACTION adjust_batch name="menu.adjust_batch"
               CALL axmt174_adjust_batch()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axmr174_act2
            LET g_action_choice="axmr174_act2"
            IF cl_auth_chk_act("axmr174_act2") THEN
               
               #add-point:ON ACTION axmr174_act2 name="menu.axmr174_act2"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmt174_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmt174_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
#               MENU "" ATTRIBUTE (STYLE="popup", IMAGE="question")
#                  ON ACTION axmr174_act1
#                     LET l_act = '1'
#                     EXIT MENU
#               
#                  ON ACTION axmr174_act2
#                     LET l_act = '2'
#                     EXIT MENU
#               END MENU
#               LET l_cmd = " xmigsite = '",g_xmig_m.xmigsite,"' AND xmig001 = '",g_xmig_m.xmig001,"' AND xmig002 = '",g_xmig_m.xmig002," 'AND xmig003 = '",g_xmig_m.xmig003,"'"
#               IF l_act = '1' THEN
#                  CALL axmr174_x01(l_cmd)                  
#               ELSE
#                  CALL axmr174_x02(l_cmd)                 
#               END IF
               LET g_rep_wc = " xmigsite = '",g_xmig_m.xmigsite,"' AND xmig001 = '",g_xmig_m.xmig001,"' AND xmig002 = '",g_xmig_m.xmig002," 'AND xmig003 = '",g_xmig_m.xmig003,"'"
               #END add-point
               &include "erp/axm/axmt174_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
#               MENU "" ATTRIBUTE (STYLE="popup", IMAGE="question")
#                  ON ACTION axmr174_act1
#                     LET l_act = '1'
#                     EXIT MENU
#               
#                  ON ACTION axmr174_act2
#                     LET l_act = '2'
#                     EXIT MENU
#               END MENU
#               LET l_cmd = " xmigsite = '",g_xmig_m.xmigsite,"' AND xmig001 = '",g_xmig_m.xmig001,"' AND xmig002 = '",g_xmig_m.xmig002," 'AND xmig003 = '",g_xmig_m.xmig003,"'"
#               IF l_act = '1' THEN
#                  CALL axmr174_x01(l_cmd)                  
#               ELSE
#                  CALL axmr174_x02(l_cmd)                 
#               END IF
               LET g_rep_wc = " xmigsite = '",g_xmig_m.xmigsite,"' AND xmig001 = '",g_xmig_m.xmig001,"' AND xmig002 = '",g_xmig_m.xmig002," 'AND xmig003 = '",g_xmig_m.xmig003,"'"
               #END add-point
               &include "erp/axm/axmt174_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmt174_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmt174_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION adjust
            LET g_action_choice="adjust"
            IF cl_auth_chk_act("adjust") THEN
               
               #add-point:ON ACTION adjust name="menu.adjust"
               LET g_flag = TRUE
               CALL axmt174_modify()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION memo
            LET g_action_choice="memo"
            IF cl_auth_chk_act("memo") THEN
               
               #add-point:ON ACTION memo name="menu.memo"
                CALL aooi360_02('6','axmt174',g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003,'','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axmr174_act1
            LET g_action_choice="axmr174_act1"
            IF cl_auth_chk_act("axmr174_act1") THEN
               
               #add-point:ON ACTION axmr174_act1 name="menu.axmr174_act1"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmt174_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmt174_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmt174_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
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
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axmt174_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axmt174_browser_fill(ps_page_action)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   LET l_wc  = g_wc.trim() 

   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
      IF g_argv[1] = '2' THEN
         LET g_wc = " xmigsite = '",g_site,"'"
      END IF
   
   ELSE
      IF g_argv[1] = '2' THEN
         LET g_wc = g_wc, " AND xmigsite = '",g_site,"'"
      END IF
   
   END IF
   
   LET l_wc  = g_wc.trim() 
   #end add-point    
 
   LET l_searchcol = "xmigsite,xmig001,xmig002,xmig003"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xmigsite ",
                      ", xmig001 ",
                      ", xmig002 ",
                      ", xmig003 ",
 
                      " FROM xmig_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xmigent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xmig_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xmigsite ",
                      ", xmig001 ",
                      ", xmig002 ",
                      ", xmig003 ",
 
                      " FROM xmig_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xmigent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xmig_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
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
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_xmig_m.* TO NULL
      CALL g_xmig_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xmigsite,t0.xmig001,t0.xmig002,t0.xmig003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xmigsite,t0.xmig001,t0.xmig002,t0.xmig003,t1.ooefl003 ,t2.xmial003", 
 
                " FROM xmig_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xmigsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN xmial_t t2 ON t2.xmialent="||g_enterprise||" AND t2.xmial001=t0.xmig001 AND t2.xmial002='"||g_dlang||"' ",
 
                " WHERE t0.xmigent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xmig_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmig_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xmigsite,g_browser[g_cnt].b_xmig001,g_browser[g_cnt].b_xmig002, 
          g_browser[g_cnt].b_xmig003,g_browser[g_cnt].b_xmigsite_desc,g_browser[g_cnt].b_xmig001_desc  
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         
         
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point  
      
         #遮罩相關處理
         CALL axmt174_browser_mask()
         
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
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
   
   IF cl_null(g_browser[g_cnt].b_xmigsite) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xmig_m.* TO NULL
      CALL g_xmig_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axmt174_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axmt174_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xmig_m.xmigsite = g_browser[g_current_idx].b_xmigsite   
   LET g_xmig_m.xmig001 = g_browser[g_current_idx].b_xmig001   
   LET g_xmig_m.xmig002 = g_browser[g_current_idx].b_xmig002   
   LET g_xmig_m.xmig003 = g_browser[g_current_idx].b_xmig003   
 
   EXECUTE axmt174_master_referesh USING g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003 INTO g_xmig_m.xmigsite, 
       g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig003,g_xmig_m.xmigsite_desc,g_xmig_m.xmig001_desc 
 
   CALL axmt174_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axmt174_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axmt174_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xmigsite = g_xmig_m.xmigsite 
         AND g_browser[l_i].b_xmig001 = g_xmig_m.xmig001 
         AND g_browser[l_i].b_xmig002 = g_xmig_m.xmig002 
         AND g_browser[l_i].b_xmig003 = g_xmig_m.xmig003 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmt174_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xmig_m.* TO NULL
   CALL g_xmig_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL g_xmig2_d.clear()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xmigsite,xmig002,xmig001,xmig003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xmigsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmigsite
            #add-point:ON ACTION controlp INFIELD xmigsite name="construct.c.xmigsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_12()                           #呼叫開窗
            CALL q_ooef001_1()
            #mod--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO xmigsite  #顯示到畫面上
            NEXT FIELD xmigsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmigsite
            #add-point:BEFORE FIELD xmigsite name="construct.b.xmigsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmigsite
            
            #add-point:AFTER FIELD xmigsite name="construct.a.xmigsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig002
            #add-point:BEFORE FIELD xmig002 name="construct.b.xmig002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig002
            
            #add-point:AFTER FIELD xmig002 name="construct.a.xmig002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmig002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig002
            #add-point:ON ACTION controlp INFIELD xmig002 name="construct.c.xmig002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmig001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig001
            #add-point:ON ACTION controlp INFIELD xmig001 name="construct.c.xmig001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig001  #顯示到畫面上
            NEXT FIELD xmig001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig001
            #add-point:BEFORE FIELD xmig001 name="construct.b.xmig001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig001
            
            #add-point:AFTER FIELD xmig001 name="construct.a.xmig001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig003
            #add-point:BEFORE FIELD xmig003 name="construct.b.xmig003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig003
            
            #add-point:AFTER FIELD xmig003 name="construct.a.xmig003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmig003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig003
            #add-point:ON ACTION controlp INFIELD xmig003 name="construct.c.xmig003"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xmig017,xmig006,xmig007,xmig004,xmig005,xmig008,xmig009,xmig010,xmig018, 
          xmig013,xmig016,l_xmig016_16
           FROM s_detail1[1].xmig017,s_detail1[1].xmig006,s_detail1[1].xmig007,s_detail1[1].xmig004, 
               s_detail1[1].xmig005,s_detail1[1].xmig008,s_detail1[1].xmig009,s_detail1[1].xmig010,s_detail1[1].xmig018, 
               s_detail1[1].xmig013,s_detail1[1].xmig016,s_detail1[1].l_xmig016_16
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig017
            #add-point:BEFORE FIELD xmig017 name="construct.b.page1.xmig017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig017
            
            #add-point:AFTER FIELD xmig017 name="construct.a.page1.xmig017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig017
            #add-point:ON ACTION controlp INFIELD xmig017 name="construct.c.page1.xmig017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmig006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig006
            #add-point:ON ACTION controlp INFIELD xmig006 name="construct.c.page1.xmig006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig006  #顯示到畫面上
            NEXT FIELD xmig006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig006
            #add-point:BEFORE FIELD xmig006 name="construct.b.page1.xmig006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig006
            
            #add-point:AFTER FIELD xmig006 name="construct.a.page1.xmig006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig007
            #add-point:ON ACTION controlp INFIELD xmig007 name="construct.c.page1.xmig007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig007  #顯示到畫面上
            NEXT FIELD xmig007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig007
            #add-point:BEFORE FIELD xmig007 name="construct.b.page1.xmig007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig007
            
            #add-point:AFTER FIELD xmig007 name="construct.a.page1.xmig007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig004
            #add-point:ON ACTION controlp INFIELD xmig004 name="construct.c.page1.xmig004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig004  #顯示到畫面上
            NEXT FIELD xmig004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig004
            #add-point:BEFORE FIELD xmig004 name="construct.b.page1.xmig004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig004
            
            #add-point:AFTER FIELD xmig004 name="construct.a.page1.xmig004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig005
            #add-point:ON ACTION controlp INFIELD xmig005 name="construct.c.page1.xmig005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig005  #顯示到畫面上
            NEXT FIELD xmig005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig005
            #add-point:BEFORE FIELD xmig005 name="construct.b.page1.xmig005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig005
            
            #add-point:AFTER FIELD xmig005 name="construct.a.page1.xmig005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig008
            #add-point:ON ACTION controlp INFIELD xmig008 name="construct.c.page1.xmig008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig008  #顯示到畫面上
            NEXT FIELD xmig008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig008
            #add-point:BEFORE FIELD xmig008 name="construct.b.page1.xmig008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig008
            
            #add-point:AFTER FIELD xmig008 name="construct.a.page1.xmig008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig009
            #add-point:ON ACTION controlp INFIELD xmig009 name="construct.c.page1.xmig009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            #160621-00003#6 160629 by lori mark and add---(S)
            #CALL q_xmig009()                          
            
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001()
            #160621-00003#6 160629 by lori mark and add---(E)
            
            DISPLAY g_qryparam.return1 TO xmig009  #顯示到畫面上
            NEXT FIELD xmig009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig009
            #add-point:BEFORE FIELD xmig009 name="construct.b.page1.xmig009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig009
            
            #add-point:AFTER FIELD xmig009 name="construct.a.page1.xmig009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig010
            #add-point:BEFORE FIELD xmig010 name="construct.b.page1.xmig010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig010
            
            #add-point:AFTER FIELD xmig010 name="construct.a.page1.xmig010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig010
            #add-point:ON ACTION controlp INFIELD xmig010 name="construct.c.page1.xmig010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmig018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig018
            #add-point:ON ACTION controlp INFIELD xmig018 name="construct.c.page1.xmig018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig018()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig018  #顯示到畫面上
            NEXT FIELD xmig018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig018
            #add-point:BEFORE FIELD xmig018 name="construct.b.page1.xmig018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig018
            
            #add-point:AFTER FIELD xmig018 name="construct.a.page1.xmig018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig013
            #add-point:BEFORE FIELD xmig013 name="construct.b.page1.xmig013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig013
            
            #add-point:AFTER FIELD xmig013 name="construct.a.page1.xmig013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig013
            #add-point:ON ACTION controlp INFIELD xmig013 name="construct.c.page1.xmig013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig016
            #add-point:BEFORE FIELD xmig016 name="construct.b.page1.xmig016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig016
            
            #add-point:AFTER FIELD xmig016 name="construct.a.page1.xmig016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmig016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig016
            #add-point:ON ACTION controlp INFIELD xmig016 name="construct.c.page1.xmig016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_16
            #add-point:BEFORE FIELD l_xmig016_16 name="construct.b.page1.l_xmig016_16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_16
            
            #add-point:AFTER FIELD l_xmig016_16 name="construct.a.page1.l_xmig016_16"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_xmig016_16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_16
            #add-point:ON ACTION controlp INFIELD l_xmig016_16 name="construct.c.page1.l_xmig016_16"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         LET g_xmig_d[1].xmig017 = ""
         DISPLAY ARRAY g_xmig_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #end add-point
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axmt174_filter()
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
      CONSTRUCT g_wc_filter ON xmigsite,xmig001,xmig002,xmig003
                          FROM s_browse[1].b_xmigsite,s_browse[1].b_xmig001,s_browse[1].b_xmig002,s_browse[1].b_xmig003 
 
 
         BEFORE CONSTRUCT
               DISPLAY axmt174_filter_parser('xmigsite') TO s_browse[1].b_xmigsite
            DISPLAY axmt174_filter_parser('xmig001') TO s_browse[1].b_xmig001
            DISPLAY axmt174_filter_parser('xmig002') TO s_browse[1].b_xmig002
            DISPLAY axmt174_filter_parser('xmig003') TO s_browse[1].b_xmig003
      
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
 
      CALL axmt174_filter_show('xmigsite')
   CALL axmt174_filter_show('xmig001')
   CALL axmt174_filter_show('xmig002')
   CALL axmt174_filter_show('xmig003')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axmt174_filter_parser(ps_field)
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
 
{<section id="axmt174.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axmt174_filter_show(ps_field)
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
   LET ls_condition = axmt174_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axmt174_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE ls_hide   STRING
   DEFINE li_i      LIKE type_t.num5
   DEFINE lc_index  LIKE type_t.chr2
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   CALL g_xmig2_d.clear()
   LET ls_hide = ' '   
   FOR li_i = 1 TO 24     #欄位的隱藏
      LET lc_index = li_i USING '&&' 
      IF li_i = 1 THEN      
         LET ls_hide = ls_hide || "l_xmig013_" || lc_index || ",l_xmig013_2_" || lc_index || ",l_xmig016_" || lc_index || ",l_xmig016_2_" || lc_index                   
      ELSE
         LET ls_hide = ls_hide || ",l_xmig013_" || lc_index || ",l_xmig013_2_" || lc_index || ",l_xmig016_" || lc_index || ",l_xmig016_2_" || lc_index                             
      END IF    
   END FOR  
   CALL cl_set_comp_visible(ls_hide,FALSE)    
   #end add-point 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
   
   LET ls_wc = g_wc
 
   LET INT_FLAG = 0    
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_xmig_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axmt174_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axmt174_browser_fill(g_wc)
      CALL axmt174_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axmt174_browser_fill("F")
   
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
      CALL axmt174_fetch("F") 
   END IF
   
   CALL axmt174_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axmt174_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
 
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF
            
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xmig_m.xmigsite = g_browser[g_current_idx].b_xmigsite
   LET g_xmig_m.xmig001 = g_browser[g_current_idx].b_xmig001
   LET g_xmig_m.xmig002 = g_browser[g_current_idx].b_xmig002
   LET g_xmig_m.xmig003 = g_browser[g_current_idx].b_xmig003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axmt174_master_referesh USING g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003 INTO g_xmig_m.xmigsite, 
       g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig003,g_xmig_m.xmigsite_desc,g_xmig_m.xmig001_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xmig_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xmig_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xmig_m_mask_o.* =  g_xmig_m.*
   CALL axmt174_xmig_t_mask()
   LET g_xmig_m_mask_n.* =  g_xmig_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt174_set_act_visible()
   CALL axmt174_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xmig_m_t.* = g_xmig_m.*
   LET g_xmig_m_o.* = g_xmig_m.*
   
   #重新顯示   
   CALL axmt174_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmt174_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   CALL g_xmig2_d.clear()
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xmig_d.clear()
 
 
   INITIALIZE g_xmig_m.* TO NULL             #DEFAULT 設定
   LET g_xmigsite_t = NULL
   LET g_xmig001_t = NULL
   LET g_xmig002_t = NULL
   LET g_xmig003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      CALL cl_set_combo_scc('xmig017','3014') 
      #end add-point 
 
      CALL axmt174_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xmig_m.* TO NULL
         INITIALIZE g_xmig_d TO NULL
 
         CALL axmt174_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xmig_m.* = g_xmig_m_t.*
         CALL axmt174_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xmig_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      CALL g_xmig2_d.clear()
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt174_set_act_visible()
   CALL axmt174_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xmigsite_t = g_xmig_m.xmigsite
   LET g_xmig001_t = g_xmig_m.xmig001
   LET g_xmig002_t = g_xmig_m.xmig002
   LET g_xmig003_t = g_xmig_m.xmig003
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmigent = " ||g_enterprise|| " AND",
                      " xmigsite = '", g_xmig_m.xmigsite, "' "
                      ," AND xmig001 = '", g_xmig_m.xmig001, "' "
                      ," AND xmig002 = '", g_xmig_m.xmig002, "' "
                      ," AND xmig003 = '", g_xmig_m.xmig003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt174_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axmt174_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axmt174_master_referesh USING g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003 INTO g_xmig_m.xmigsite, 
       g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig003,g_xmig_m.xmigsite_desc,g_xmig_m.xmig001_desc 
 
   
   #遮罩相關處理
   LET g_xmig_m_mask_o.* =  g_xmig_m.*
   CALL axmt174_xmig_t_mask()
   LET g_xmig_m_mask_n.* =  g_xmig_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmig_m.xmigsite,g_xmig_m.xmigsite_desc,g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig001_desc, 
       g_xmig_m.xmig003
   
   #功能已完成,通報訊息中心
   CALL axmt174_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmt174_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xmig_m.xmigsite IS NULL
   OR g_xmig_m.xmig001 IS NULL
   OR g_xmig_m.xmig002 IS NULL
   OR g_xmig_m.xmig003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xmigsite_t = g_xmig_m.xmigsite
   LET g_xmig001_t = g_xmig_m.xmig001
   LET g_xmig002_t = g_xmig_m.xmig002
   LET g_xmig003_t = g_xmig_m.xmig003
 
   CALL s_transaction_begin()
   
   OPEN axmt174_cl USING g_enterprise,g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt174_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axmt174_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt174_master_referesh USING g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003 INTO g_xmig_m.xmigsite, 
       g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig003,g_xmig_m.xmigsite_desc,g_xmig_m.xmig001_desc 
 
   
   #遮罩相關處理
   LET g_xmig_m_mask_o.* =  g_xmig_m.*
   CALL axmt174_xmig_t_mask()
   LET g_xmig_m_mask_n.* =  g_xmig_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axmt174_show()
   WHILE TRUE
      LET g_xmigsite_t = g_xmig_m.xmigsite
      LET g_xmig001_t = g_xmig_m.xmig001
      LET g_xmig002_t = g_xmig_m.xmig002
      LET g_xmig003_t = g_xmig_m.xmig003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axmt174_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xmig_m.* = g_xmig_m_t.*
         CALL axmt174_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xmig_m.xmigsite != g_xmigsite_t 
      OR g_xmig_m.xmig001 != g_xmig001_t 
      OR g_xmig_m.xmig002 != g_xmig002_t 
      OR g_xmig_m.xmig003 != g_xmig003_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt174_set_act_visible()
   CALL axmt174_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xmigent = " ||g_enterprise|| " AND",
                      " xmigsite = '", g_xmig_m.xmigsite, "' "
                      ," AND xmig001 = '", g_xmig_m.xmig001, "' "
                      ," AND xmig002 = '", g_xmig_m.xmig002, "' "
                      ," AND xmig003 = '", g_xmig_m.xmig003, "' "
 
   #填到對應位置
   CALL axmt174_browser_fill("")
 
   CALL axmt174_idx_chk()
 
   CLOSE axmt174_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt174_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axmt174.input" >}
#+ 資料輸入
PRIVATE FUNCTION axmt174_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  r_success             LIKE type_t.chr1
   DEFINE  l_ac_1                LIKE type_t.num10
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmig_m.xmigsite,g_xmig_m.xmigsite_desc,g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig001_desc, 
       g_xmig_m.xmig003
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xmig017,xmig006,xmig007,xmig004,xmig005,xmig008,xmig009,xmig010,xmig018, 
       xmig013,xmig016 FROM xmig_t WHERE xmigent=? AND xmigsite=? AND xmig001=? AND xmig002=? AND xmig003=?  
       AND xmig004=? AND xmig005=? AND xmig006=? AND xmig007=? AND xmig008=? AND xmig009=? AND xmig010=?  
       AND xmig017=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   LET g_forupd_sql2 = "SELECT xmig006,'','','','',
       '','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','' FROM xmig_t  
       WHERE xmigent=? AND xmigsite=? AND xmig001=? AND xmig002=? AND xmig003=?
         AND xmig006=? FOR UPDATE"
   LET g_forupd_sql2 = cl_sql_forupd(g_forupd_sql2)
   DECLARE axmt174_bcl2 CURSOR FROM g_forupd_sql2  
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt174_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axmt174_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axmt174_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xmig_m.xmigsite,g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_flag = FALSE
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axmt174.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xmig_m.xmigsite,g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            CALL cl_set_combo_scc('xmig017','3014') 
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmigsite
            
            #add-point:AFTER FIELD xmigsite name="input.a.xmigsite"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xmig_m.xmigsite) AND NOT cl_null(g_xmig_m.xmig001) AND NOT cl_null(g_xmig_m.xmig002) AND NOT cl_null(g_xmig_m.xmig003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t  OR g_xmig_m.xmig001 != g_xmig001_t  OR g_xmig_m.xmig002 != g_xmig002_t  OR g_xmig_m.xmig003 != g_xmig003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmigsite
            #add-point:BEFORE FIELD xmigsite name="input.b.xmigsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmigsite
            #add-point:ON CHANGE xmigsite name="input.g.xmigsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig002
            #add-point:BEFORE FIELD xmig002 name="input.b.xmig002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig002
            
            #add-point:AFTER FIELD xmig002 name="input.a.xmig002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xmig_m.xmigsite) AND NOT cl_null(g_xmig_m.xmig001) AND NOT cl_null(g_xmig_m.xmig002) AND NOT cl_null(g_xmig_m.xmig003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t  OR g_xmig_m.xmig001 != g_xmig001_t  OR g_xmig_m.xmig002 != g_xmig002_t  OR g_xmig_m.xmig003 != g_xmig003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig002
            #add-point:ON CHANGE xmig002 name="input.g.xmig002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig001
            
            #add-point:AFTER FIELD xmig001 name="input.a.xmig001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xmig_m.xmigsite) AND NOT cl_null(g_xmig_m.xmig001) AND NOT cl_null(g_xmig_m.xmig002) AND NOT cl_null(g_xmig_m.xmig003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t  OR g_xmig_m.xmig001 != g_xmig001_t  OR g_xmig_m.xmig002 != g_xmig002_t  OR g_xmig_m.xmig003 != g_xmig003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig001
            #add-point:BEFORE FIELD xmig001 name="input.b.xmig001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig001
            #add-point:ON CHANGE xmig001 name="input.g.xmig001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig003
            #add-point:BEFORE FIELD xmig003 name="input.b.xmig003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig003
            
            #add-point:AFTER FIELD xmig003 name="input.a.xmig003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xmig_m.xmigsite) AND NOT cl_null(g_xmig_m.xmig001) AND NOT cl_null(g_xmig_m.xmig002) AND NOT cl_null(g_xmig_m.xmig003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t  OR g_xmig_m.xmig001 != g_xmig001_t  OR g_xmig_m.xmig002 != g_xmig002_t  OR g_xmig_m.xmig003 != g_xmig003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig003
            #add-point:ON CHANGE xmig003 name="input.g.xmig003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmigsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmigsite
            #add-point:ON ACTION controlp INFIELD xmigsite name="input.c.xmigsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmig002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig002
            #add-point:ON ACTION controlp INFIELD xmig002 name="input.c.xmig002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmig001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig001
            #add-point:ON ACTION controlp INFIELD xmig001 name="input.c.xmig001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmig003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig003
            #add-point:ON ACTION controlp INFIELD xmig003 name="input.c.xmig003"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xmig_m.xmigsite             
                            ,g_xmig_m.xmig001   
                            ,g_xmig_m.xmig002   
                            ,g_xmig_m.xmig003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axmt174_xmig_t_mask_restore('restore_mask_o')
            
               UPDATE xmig_t SET (xmigsite,xmig002,xmig001,xmig003) = (g_xmig_m.xmigsite,g_xmig_m.xmig002, 
                   g_xmig_m.xmig001,g_xmig_m.xmig003)
                WHERE xmigent = g_enterprise AND xmigsite = g_xmigsite_t
                  AND xmig001 = g_xmig001_t
                  AND xmig002 = g_xmig002_t
                  AND xmig003 = g_xmig003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmig_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmig_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmig_m.xmigsite
               LET gs_keys_bak[1] = g_xmigsite_t
               LET gs_keys[2] = g_xmig_m.xmig001
               LET gs_keys_bak[2] = g_xmig001_t
               LET gs_keys[3] = g_xmig_m.xmig002
               LET gs_keys_bak[3] = g_xmig002_t
               LET gs_keys[4] = g_xmig_m.xmig003
               LET gs_keys_bak[4] = g_xmig003_t
               LET gs_keys[5] = g_xmig_d[g_detail_idx].xmig004
               LET gs_keys_bak[5] = g_xmig_d_t.xmig004
               LET gs_keys[6] = g_xmig_d[g_detail_idx].xmig005
               LET gs_keys_bak[6] = g_xmig_d_t.xmig005
               LET gs_keys[7] = g_xmig_d[g_detail_idx].xmig006
               LET gs_keys_bak[7] = g_xmig_d_t.xmig006
               LET gs_keys[8] = g_xmig_d[g_detail_idx].xmig007
               LET gs_keys_bak[8] = g_xmig_d_t.xmig007
               LET gs_keys[9] = g_xmig_d[g_detail_idx].xmig008
               LET gs_keys_bak[9] = g_xmig_d_t.xmig008
               LET gs_keys[10] = g_xmig_d[g_detail_idx].xmig009
               LET gs_keys_bak[10] = g_xmig_d_t.xmig009
               LET gs_keys[11] = g_xmig_d[g_detail_idx].xmig010
               LET gs_keys_bak[11] = g_xmig_d_t.xmig010
               LET gs_keys[12] = g_xmig_d[g_detail_idx].xmig017
               LET gs_keys_bak[12] = g_xmig_d_t.xmig017
               CALL axmt174_update_b('xmig_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xmig_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xmig_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axmt174_xmig_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axmt174_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xmigsite_t = g_xmig_m.xmigsite
           LET g_xmig001_t = g_xmig_m.xmig001
           LET g_xmig002_t = g_xmig_m.xmig002
           LET g_xmig003_t = g_xmig_m.xmig003
 
           
           IF g_xmig_d.getLength() = 0 THEN
              NEXT FIELD xmig004
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axmt174.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xmig_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmig_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt174_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
#            IF NOT g_flag THEN
#               EXIT INPUT
#            END IF   
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt174_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axmt174_cl USING g_enterprise,g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axmt174_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axmt174_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xmig_d[l_ac].xmig004 IS NOT NULL
               AND g_xmig_d[l_ac].xmig005 IS NOT NULL
               AND g_xmig_d[l_ac].xmig006 IS NOT NULL
               AND g_xmig_d[l_ac].xmig007 IS NOT NULL
               AND g_xmig_d[l_ac].xmig008 IS NOT NULL
               AND g_xmig_d[l_ac].xmig009 IS NOT NULL
               AND g_xmig_d[l_ac].xmig010 IS NOT NULL
               AND g_xmig_d[l_ac].xmig017 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmig_d_t.* = g_xmig_d[l_ac].*  #BACKUP
               LET g_xmig_d_o.* = g_xmig_d[l_ac].*  #BACKUP
               CALL axmt174_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axmt174_set_no_entry_b(l_cmd)
               OPEN axmt174_bcl USING g_enterprise,g_xmig_m.xmigsite,
                                                g_xmig_m.xmig001,
                                                g_xmig_m.xmig002,
                                                g_xmig_m.xmig003,
 
                                                g_xmig_d_t.xmig004
                                                ,g_xmig_d_t.xmig005
                                                ,g_xmig_d_t.xmig006
                                                ,g_xmig_d_t.xmig007
                                                ,g_xmig_d_t.xmig008
                                                ,g_xmig_d_t.xmig009
                                                ,g_xmig_d_t.xmig010
                                                ,g_xmig_d_t.xmig017
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axmt174_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt174_bcl INTO g_xmig_d[l_ac].xmig017,g_xmig_d[l_ac].xmig006,g_xmig_d[l_ac].xmig007, 
                      g_xmig_d[l_ac].xmig004,g_xmig_d[l_ac].xmig005,g_xmig_d[l_ac].xmig008,g_xmig_d[l_ac].xmig009, 
                      g_xmig_d[l_ac].xmig010,g_xmig_d[l_ac].xmig018,g_xmig_d[l_ac].xmig013,g_xmig_d[l_ac].xmig016 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xmig_d_t.xmig004,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmig_d_mask_o[l_ac].* =  g_xmig_d[l_ac].*
                  CALL axmt174_xmig_t_mask()
                  LET g_xmig_d_mask_n[l_ac].* =  g_xmig_d[l_ac].*
                  
                  CALL axmt174_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd='u' THEN 
               LET l_ac_1 = l_ac
               CALL axmt174_show()
               LET l_ac = l_ac_1
            END IF   
            #end add-point  
            
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xmig_d_t.* TO NULL
            INITIALIZE g_xmig_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmig_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xmig_d[l_ac].xmig017 = "0"
      LET g_xmig_d[l_ac].xmig016 = "0"
      LET g_xmig_d[l_ac].l_xmig016_01 = "0"
      LET g_xmig_d[l_ac].l_xmig016_02 = "0"
      LET g_xmig_d[l_ac].l_xmig016_03 = "0"
      LET g_xmig_d[l_ac].l_xmig016_04 = "0"
      LET g_xmig_d[l_ac].l_xmig016_05 = "0"
      LET g_xmig_d[l_ac].l_xmig016_06 = "0"
      LET g_xmig_d[l_ac].l_xmig016_07 = "0"
      LET g_xmig_d[l_ac].l_xmig016_08 = "0"
      LET g_xmig_d[l_ac].l_xmig016_09 = "0"
      LET g_xmig_d[l_ac].l_xmig016_10 = "0"
      LET g_xmig_d[l_ac].l_xmig016_11 = "0"
      LET g_xmig_d[l_ac].l_xmig016_12 = "0"
      LET g_xmig_d[l_ac].l_xmig016_13 = "0"
      LET g_xmig_d[l_ac].l_xmig016_14 = "0"
      LET g_xmig_d[l_ac].l_xmig016_15 = "0"
      LET g_xmig_d[l_ac].l_xmig016_16 = "0"
      LET g_xmig_d[l_ac].l_xmig016_17 = "0"
      LET g_xmig_d[l_ac].l_xmig016_18 = "0"
      LET g_xmig_d[l_ac].l_xmig016_19 = "0"
      LET g_xmig_d[l_ac].l_xmig016_20 = "0"
      LET g_xmig_d[l_ac].l_xmig016_21 = "0"
      LET g_xmig_d[l_ac].l_xmig016_22 = "0"
      LET g_xmig_d[l_ac].l_xmig016_23 = "0"
      LET g_xmig_d[l_ac].l_xmig016_24 = "0"
      LET g_xmig_d[l_ac].l_xmig016_s = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xmig_d_t.* = g_xmig_d[l_ac].*     #新輸入資料
            LET g_xmig_d_o.* = g_xmig_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt174_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axmt174_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmig_d[li_reproduce_target].* = g_xmig_d[li_reproduce].*
 
               LET g_xmig_d[g_xmig_d.getLength()].xmig004 = NULL
               LET g_xmig_d[g_xmig_d.getLength()].xmig005 = NULL
               LET g_xmig_d[g_xmig_d.getLength()].xmig006 = NULL
               LET g_xmig_d[g_xmig_d.getLength()].xmig007 = NULL
               LET g_xmig_d[g_xmig_d.getLength()].xmig008 = NULL
               LET g_xmig_d[g_xmig_d.getLength()].xmig009 = NULL
               LET g_xmig_d[g_xmig_d.getLength()].xmig010 = NULL
               LET g_xmig_d[g_xmig_d.getLength()].xmig017 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xmig_t 
             WHERE xmigent = g_enterprise AND xmigsite = g_xmig_m.xmigsite
               AND xmig001 = g_xmig_m.xmig001
               AND xmig002 = g_xmig_m.xmig002
               AND xmig003 = g_xmig_m.xmig003
 
               AND xmig004 = g_xmig_d[l_ac].xmig004
               AND xmig005 = g_xmig_d[l_ac].xmig005
               AND xmig006 = g_xmig_d[l_ac].xmig006
               AND xmig007 = g_xmig_d[l_ac].xmig007
               AND xmig008 = g_xmig_d[l_ac].xmig008
               AND xmig009 = g_xmig_d[l_ac].xmig009
               AND xmig010 = g_xmig_d[l_ac].xmig010
               AND xmig017 = g_xmig_d[l_ac].xmig017
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xmig_t
                           (xmigent,
                            xmigsite,xmig002,xmig001,xmig003,
                            xmig004,xmig005,xmig006,xmig007,xmig008,xmig009,xmig010,xmig017
                            ,xmig018,xmig013,xmig016) 
                     VALUES(g_enterprise,
                            g_xmig_m.xmigsite,g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig003,
                            g_xmig_d[l_ac].xmig004,g_xmig_d[l_ac].xmig005,g_xmig_d[l_ac].xmig006,g_xmig_d[l_ac].xmig007, 
                                g_xmig_d[l_ac].xmig008,g_xmig_d[l_ac].xmig009,g_xmig_d[l_ac].xmig010, 
                                g_xmig_d[l_ac].xmig017
                            ,g_xmig_d[l_ac].xmig018,g_xmig_d[l_ac].xmig013,g_xmig_d[l_ac].xmig016)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xmig_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmig_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF axmt174_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xmig_m.xmigsite
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_m.xmig001
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_m.xmig002
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_m.xmig003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_d_t.xmig004
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_d_t.xmig005
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_d_t.xmig006
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_d_t.xmig007
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_d_t.xmig008
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_d_t.xmig009
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_d_t.xmig010
                  LET gs_keys[gs_keys.getLength()+1] = g_xmig_d_t.xmig017
 
 
                  #刪除下層單身
                  IF NOT axmt174_key_delete_b(gs_keys,'xmig_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axmt174_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axmt174_bcl
               LET l_count = g_xmig_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xmig_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig017
            #add-point:BEFORE FIELD xmig017 name="input.b.page1.xmig017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig017
            
            #add-point:AFTER FIELD xmig017 name="input.a.page1.xmig017"
            #此段落由子樣板a05產生
            IF  g_xmig_m.xmigsite IS NOT NULL AND g_xmig_m.xmig001 IS NOT NULL AND g_xmig_m.xmig002 IS NOT NULL AND g_xmig_m.xmig003 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig004 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig005 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig006 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig007 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig008 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig009 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig010 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig017 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t OR g_xmig_m.xmig001 != g_xmig001_t OR g_xmig_m.xmig002 != g_xmig002_t OR g_xmig_m.xmig003 != g_xmig003_t OR g_xmig_d[g_detail_idx].xmig004 != g_xmig_d_t.xmig004 OR g_xmig_d[g_detail_idx].xmig005 != g_xmig_d_t.xmig005 OR g_xmig_d[g_detail_idx].xmig006 != g_xmig_d_t.xmig006 OR g_xmig_d[g_detail_idx].xmig007 != g_xmig_d_t.xmig007 OR g_xmig_d[g_detail_idx].xmig008 != g_xmig_d_t.xmig008 OR g_xmig_d[g_detail_idx].xmig009 != g_xmig_d_t.xmig009 OR g_xmig_d[g_detail_idx].xmig010 != g_xmig_d_t.xmig010 OR g_xmig_d[g_detail_idx].xmig017 != g_xmig_d_t.xmig017)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"' AND "|| "xmig004 = '"||g_xmig_d[g_detail_idx].xmig004 ||"' AND "|| "xmig005 = '"||g_xmig_d[g_detail_idx].xmig005 ||"' AND "|| "xmig006 = '"||g_xmig_d[g_detail_idx].xmig006 ||"' AND "|| "xmig007 = '"||g_xmig_d[g_detail_idx].xmig007 ||"' AND "|| "xmig008 = '"||g_xmig_d[g_detail_idx].xmig008 ||"' AND "|| "xmig009 = '"||g_xmig_d[g_detail_idx].xmig009 ||"' AND "|| "xmig010 = '"||g_xmig_d[g_detail_idx].xmig010 ||"' AND "|| "xmig017 = '"||g_xmig_d[g_detail_idx].xmig017 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig017
            #add-point:ON CHANGE xmig017 name="input.g.page1.xmig017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig006
            
            #add-point:AFTER FIELD xmig006 name="input.a.page1.xmig006"
            #此段落由子樣板a05產生
            IF  g_xmig_m.xmigsite IS NOT NULL AND g_xmig_m.xmig001 IS NOT NULL AND g_xmig_m.xmig002 IS NOT NULL AND g_xmig_m.xmig003 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig004 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig005 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig006 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig007 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig008 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig009 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig010 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig017 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t OR g_xmig_m.xmig001 != g_xmig001_t OR g_xmig_m.xmig002 != g_xmig002_t OR g_xmig_m.xmig003 != g_xmig003_t OR g_xmig_d[g_detail_idx].xmig004 != g_xmig_d_t.xmig004 OR g_xmig_d[g_detail_idx].xmig005 != g_xmig_d_t.xmig005 OR g_xmig_d[g_detail_idx].xmig006 != g_xmig_d_t.xmig006 OR g_xmig_d[g_detail_idx].xmig007 != g_xmig_d_t.xmig007 OR g_xmig_d[g_detail_idx].xmig008 != g_xmig_d_t.xmig008 OR g_xmig_d[g_detail_idx].xmig009 != g_xmig_d_t.xmig009 OR g_xmig_d[g_detail_idx].xmig010 != g_xmig_d_t.xmig010 OR g_xmig_d[g_detail_idx].xmig017 != g_xmig_d_t.xmig017)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"' AND "|| "xmig004 = '"||g_xmig_d[g_detail_idx].xmig004 ||"' AND "|| "xmig005 = '"||g_xmig_d[g_detail_idx].xmig005 ||"' AND "|| "xmig006 = '"||g_xmig_d[g_detail_idx].xmig006 ||"' AND "|| "xmig007 = '"||g_xmig_d[g_detail_idx].xmig007 ||"' AND "|| "xmig008 = '"||g_xmig_d[g_detail_idx].xmig008 ||"' AND "|| "xmig009 = '"||g_xmig_d[g_detail_idx].xmig009 ||"' AND "|| "xmig010 = '"||g_xmig_d[g_detail_idx].xmig010 ||"' AND "|| "xmig017 = '"||g_xmig_d[g_detail_idx].xmig017 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig006
            #add-point:BEFORE FIELD xmig006 name="input.b.page1.xmig006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig006
            #add-point:ON CHANGE xmig006 name="input.g.page1.xmig006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig007
            
            #add-point:AFTER FIELD xmig007 name="input.a.page1.xmig007"
            #此段落由子樣板a05產生
            IF  g_xmig_m.xmigsite IS NOT NULL AND g_xmig_m.xmig001 IS NOT NULL AND g_xmig_m.xmig002 IS NOT NULL AND g_xmig_m.xmig003 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig004 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig005 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig006 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig007 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig008 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig009 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig010 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig017 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t OR g_xmig_m.xmig001 != g_xmig001_t OR g_xmig_m.xmig002 != g_xmig002_t OR g_xmig_m.xmig003 != g_xmig003_t OR g_xmig_d[g_detail_idx].xmig004 != g_xmig_d_t.xmig004 OR g_xmig_d[g_detail_idx].xmig005 != g_xmig_d_t.xmig005 OR g_xmig_d[g_detail_idx].xmig006 != g_xmig_d_t.xmig006 OR g_xmig_d[g_detail_idx].xmig007 != g_xmig_d_t.xmig007 OR g_xmig_d[g_detail_idx].xmig008 != g_xmig_d_t.xmig008 OR g_xmig_d[g_detail_idx].xmig009 != g_xmig_d_t.xmig009 OR g_xmig_d[g_detail_idx].xmig010 != g_xmig_d_t.xmig010 OR g_xmig_d[g_detail_idx].xmig017 != g_xmig_d_t.xmig017)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"' AND "|| "xmig004 = '"||g_xmig_d[g_detail_idx].xmig004 ||"' AND "|| "xmig005 = '"||g_xmig_d[g_detail_idx].xmig005 ||"' AND "|| "xmig006 = '"||g_xmig_d[g_detail_idx].xmig006 ||"' AND "|| "xmig007 = '"||g_xmig_d[g_detail_idx].xmig007 ||"' AND "|| "xmig008 = '"||g_xmig_d[g_detail_idx].xmig008 ||"' AND "|| "xmig009 = '"||g_xmig_d[g_detail_idx].xmig009 ||"' AND "|| "xmig010 = '"||g_xmig_d[g_detail_idx].xmig010 ||"' AND "|| "xmig017 = '"||g_xmig_d[g_detail_idx].xmig017 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig007
            #add-point:BEFORE FIELD xmig007 name="input.b.page1.xmig007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig007
            #add-point:ON CHANGE xmig007 name="input.g.page1.xmig007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig004
            
            #add-point:AFTER FIELD xmig004 name="input.a.page1.xmig004"
            #此段落由子樣板a05產生
            IF  g_xmig_m.xmigsite IS NOT NULL AND g_xmig_m.xmig001 IS NOT NULL AND g_xmig_m.xmig002 IS NOT NULL AND g_xmig_m.xmig003 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig004 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig005 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig006 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig007 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig008 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig009 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig010 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig017 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t OR g_xmig_m.xmig001 != g_xmig001_t OR g_xmig_m.xmig002 != g_xmig002_t OR g_xmig_m.xmig003 != g_xmig003_t OR g_xmig_d[g_detail_idx].xmig004 != g_xmig_d_t.xmig004 OR g_xmig_d[g_detail_idx].xmig005 != g_xmig_d_t.xmig005 OR g_xmig_d[g_detail_idx].xmig006 != g_xmig_d_t.xmig006 OR g_xmig_d[g_detail_idx].xmig007 != g_xmig_d_t.xmig007 OR g_xmig_d[g_detail_idx].xmig008 != g_xmig_d_t.xmig008 OR g_xmig_d[g_detail_idx].xmig009 != g_xmig_d_t.xmig009 OR g_xmig_d[g_detail_idx].xmig010 != g_xmig_d_t.xmig010 OR g_xmig_d[g_detail_idx].xmig017 != g_xmig_d_t.xmig017)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"' AND "|| "xmig004 = '"||g_xmig_d[g_detail_idx].xmig004 ||"' AND "|| "xmig005 = '"||g_xmig_d[g_detail_idx].xmig005 ||"' AND "|| "xmig006 = '"||g_xmig_d[g_detail_idx].xmig006 ||"' AND "|| "xmig007 = '"||g_xmig_d[g_detail_idx].xmig007 ||"' AND "|| "xmig008 = '"||g_xmig_d[g_detail_idx].xmig008 ||"' AND "|| "xmig009 = '"||g_xmig_d[g_detail_idx].xmig009 ||"' AND "|| "xmig010 = '"||g_xmig_d[g_detail_idx].xmig010 ||"' AND "|| "xmig017 = '"||g_xmig_d[g_detail_idx].xmig017 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig004
            #add-point:BEFORE FIELD xmig004 name="input.b.page1.xmig004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig004
            #add-point:ON CHANGE xmig004 name="input.g.page1.xmig004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig005
            
            #add-point:AFTER FIELD xmig005 name="input.a.page1.xmig005"
            #此段落由子樣板a05產生
            IF  g_xmig_m.xmigsite IS NOT NULL AND g_xmig_m.xmig001 IS NOT NULL AND g_xmig_m.xmig002 IS NOT NULL AND g_xmig_m.xmig003 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig004 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig005 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig006 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig007 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig008 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig009 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig010 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig017 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t OR g_xmig_m.xmig001 != g_xmig001_t OR g_xmig_m.xmig002 != g_xmig002_t OR g_xmig_m.xmig003 != g_xmig003_t OR g_xmig_d[g_detail_idx].xmig004 != g_xmig_d_t.xmig004 OR g_xmig_d[g_detail_idx].xmig005 != g_xmig_d_t.xmig005 OR g_xmig_d[g_detail_idx].xmig006 != g_xmig_d_t.xmig006 OR g_xmig_d[g_detail_idx].xmig007 != g_xmig_d_t.xmig007 OR g_xmig_d[g_detail_idx].xmig008 != g_xmig_d_t.xmig008 OR g_xmig_d[g_detail_idx].xmig009 != g_xmig_d_t.xmig009 OR g_xmig_d[g_detail_idx].xmig010 != g_xmig_d_t.xmig010 OR g_xmig_d[g_detail_idx].xmig017 != g_xmig_d_t.xmig017)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"' AND "|| "xmig004 = '"||g_xmig_d[g_detail_idx].xmig004 ||"' AND "|| "xmig005 = '"||g_xmig_d[g_detail_idx].xmig005 ||"' AND "|| "xmig006 = '"||g_xmig_d[g_detail_idx].xmig006 ||"' AND "|| "xmig007 = '"||g_xmig_d[g_detail_idx].xmig007 ||"' AND "|| "xmig008 = '"||g_xmig_d[g_detail_idx].xmig008 ||"' AND "|| "xmig009 = '"||g_xmig_d[g_detail_idx].xmig009 ||"' AND "|| "xmig010 = '"||g_xmig_d[g_detail_idx].xmig010 ||"' AND "|| "xmig017 = '"||g_xmig_d[g_detail_idx].xmig017 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig005
            #add-point:BEFORE FIELD xmig005 name="input.b.page1.xmig005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig005
            #add-point:ON CHANGE xmig005 name="input.g.page1.xmig005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig008
            
            #add-point:AFTER FIELD xmig008 name="input.a.page1.xmig008"
            #此段落由子樣板a05產生
            IF  g_xmig_m.xmigsite IS NOT NULL AND g_xmig_m.xmig001 IS NOT NULL AND g_xmig_m.xmig002 IS NOT NULL AND g_xmig_m.xmig003 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig004 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig005 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig006 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig007 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig008 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig009 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig010 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig017 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t OR g_xmig_m.xmig001 != g_xmig001_t OR g_xmig_m.xmig002 != g_xmig002_t OR g_xmig_m.xmig003 != g_xmig003_t OR g_xmig_d[g_detail_idx].xmig004 != g_xmig_d_t.xmig004 OR g_xmig_d[g_detail_idx].xmig005 != g_xmig_d_t.xmig005 OR g_xmig_d[g_detail_idx].xmig006 != g_xmig_d_t.xmig006 OR g_xmig_d[g_detail_idx].xmig007 != g_xmig_d_t.xmig007 OR g_xmig_d[g_detail_idx].xmig008 != g_xmig_d_t.xmig008 OR g_xmig_d[g_detail_idx].xmig009 != g_xmig_d_t.xmig009 OR g_xmig_d[g_detail_idx].xmig010 != g_xmig_d_t.xmig010 OR g_xmig_d[g_detail_idx].xmig017 != g_xmig_d_t.xmig017)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"' AND "|| "xmig004 = '"||g_xmig_d[g_detail_idx].xmig004 ||"' AND "|| "xmig005 = '"||g_xmig_d[g_detail_idx].xmig005 ||"' AND "|| "xmig006 = '"||g_xmig_d[g_detail_idx].xmig006 ||"' AND "|| "xmig007 = '"||g_xmig_d[g_detail_idx].xmig007 ||"' AND "|| "xmig008 = '"||g_xmig_d[g_detail_idx].xmig008 ||"' AND "|| "xmig009 = '"||g_xmig_d[g_detail_idx].xmig009 ||"' AND "|| "xmig010 = '"||g_xmig_d[g_detail_idx].xmig010 ||"' AND "|| "xmig017 = '"||g_xmig_d[g_detail_idx].xmig017 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig008
            #add-point:BEFORE FIELD xmig008 name="input.b.page1.xmig008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig008
            #add-point:ON CHANGE xmig008 name="input.g.page1.xmig008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig009
            
            #add-point:AFTER FIELD xmig009 name="input.a.page1.xmig009"
            #此段落由子樣板a05產生
            IF  g_xmig_m.xmigsite IS NOT NULL AND g_xmig_m.xmig001 IS NOT NULL AND g_xmig_m.xmig002 IS NOT NULL AND g_xmig_m.xmig003 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig004 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig005 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig006 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig007 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig008 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig009 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig010 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig017 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t OR g_xmig_m.xmig001 != g_xmig001_t OR g_xmig_m.xmig002 != g_xmig002_t OR g_xmig_m.xmig003 != g_xmig003_t OR g_xmig_d[g_detail_idx].xmig004 != g_xmig_d_t.xmig004 OR g_xmig_d[g_detail_idx].xmig005 != g_xmig_d_t.xmig005 OR g_xmig_d[g_detail_idx].xmig006 != g_xmig_d_t.xmig006 OR g_xmig_d[g_detail_idx].xmig007 != g_xmig_d_t.xmig007 OR g_xmig_d[g_detail_idx].xmig008 != g_xmig_d_t.xmig008 OR g_xmig_d[g_detail_idx].xmig009 != g_xmig_d_t.xmig009 OR g_xmig_d[g_detail_idx].xmig010 != g_xmig_d_t.xmig010 OR g_xmig_d[g_detail_idx].xmig017 != g_xmig_d_t.xmig017)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"' AND "|| "xmig004 = '"||g_xmig_d[g_detail_idx].xmig004 ||"' AND "|| "xmig005 = '"||g_xmig_d[g_detail_idx].xmig005 ||"' AND "|| "xmig006 = '"||g_xmig_d[g_detail_idx].xmig006 ||"' AND "|| "xmig007 = '"||g_xmig_d[g_detail_idx].xmig007 ||"' AND "|| "xmig008 = '"||g_xmig_d[g_detail_idx].xmig008 ||"' AND "|| "xmig009 = '"||g_xmig_d[g_detail_idx].xmig009 ||"' AND "|| "xmig010 = '"||g_xmig_d[g_detail_idx].xmig010 ||"' AND "|| "xmig017 = '"||g_xmig_d[g_detail_idx].xmig017 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig009
            #add-point:BEFORE FIELD xmig009 name="input.b.page1.xmig009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig009
            #add-point:ON CHANGE xmig009 name="input.g.page1.xmig009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig010
            #add-point:BEFORE FIELD xmig010 name="input.b.page1.xmig010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig010
            
            #add-point:AFTER FIELD xmig010 name="input.a.page1.xmig010"
            #此段落由子樣板a05產生
            IF  g_xmig_m.xmigsite IS NOT NULL AND g_xmig_m.xmig001 IS NOT NULL AND g_xmig_m.xmig002 IS NOT NULL AND g_xmig_m.xmig003 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig004 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig005 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig006 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig007 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig008 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig009 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig010 IS NOT NULL AND g_xmig_d[g_detail_idx].xmig017 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmig_m.xmigsite != g_xmigsite_t OR g_xmig_m.xmig001 != g_xmig001_t OR g_xmig_m.xmig002 != g_xmig002_t OR g_xmig_m.xmig003 != g_xmig003_t OR g_xmig_d[g_detail_idx].xmig004 != g_xmig_d_t.xmig004 OR g_xmig_d[g_detail_idx].xmig005 != g_xmig_d_t.xmig005 OR g_xmig_d[g_detail_idx].xmig006 != g_xmig_d_t.xmig006 OR g_xmig_d[g_detail_idx].xmig007 != g_xmig_d_t.xmig007 OR g_xmig_d[g_detail_idx].xmig008 != g_xmig_d_t.xmig008 OR g_xmig_d[g_detail_idx].xmig009 != g_xmig_d_t.xmig009 OR g_xmig_d[g_detail_idx].xmig010 != g_xmig_d_t.xmig010 OR g_xmig_d[g_detail_idx].xmig017 != g_xmig_d_t.xmig017)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmig_t WHERE "||"xmigent = '" ||g_enterprise|| "' AND "||"xmigsite = '"||g_xmig_m.xmigsite ||"' AND "|| "xmig001 = '"||g_xmig_m.xmig001 ||"' AND "|| "xmig002 = '"||g_xmig_m.xmig002 ||"' AND "|| "xmig003 = '"||g_xmig_m.xmig003 ||"' AND "|| "xmig004 = '"||g_xmig_d[g_detail_idx].xmig004 ||"' AND "|| "xmig005 = '"||g_xmig_d[g_detail_idx].xmig005 ||"' AND "|| "xmig006 = '"||g_xmig_d[g_detail_idx].xmig006 ||"' AND "|| "xmig007 = '"||g_xmig_d[g_detail_idx].xmig007 ||"' AND "|| "xmig008 = '"||g_xmig_d[g_detail_idx].xmig008 ||"' AND "|| "xmig009 = '"||g_xmig_d[g_detail_idx].xmig009 ||"' AND "|| "xmig010 = '"||g_xmig_d[g_detail_idx].xmig010 ||"' AND "|| "xmig017 = '"||g_xmig_d[g_detail_idx].xmig017 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig010
            #add-point:ON CHANGE xmig010 name="input.g.page1.xmig010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig018
            
            #add-point:AFTER FIELD xmig018 name="input.a.page1.xmig018"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig018_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig018
            #add-point:BEFORE FIELD xmig018 name="input.b.page1.xmig018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig018
            #add-point:ON CHANGE xmig018 name="input.g.page1.xmig018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig013
            #add-point:BEFORE FIELD xmig013 name="input.b.page1.xmig013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig013
            
            #add-point:AFTER FIELD xmig013 name="input.a.page1.xmig013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig013
            #add-point:ON CHANGE xmig013 name="input.g.page1.xmig013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_01
            #add-point:BEFORE FIELD l_xmig013_01 name="input.b.page1.l_xmig013_01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_01
            
            #add-point:AFTER FIELD l_xmig013_01 name="input.a.page1.l_xmig013_01"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_01
            #add-point:ON CHANGE l_xmig013_01 name="input.g.page1.l_xmig013_01"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_02
            #add-point:BEFORE FIELD l_xmig013_02 name="input.b.page1.l_xmig013_02"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_02
            
            #add-point:AFTER FIELD l_xmig013_02 name="input.a.page1.l_xmig013_02"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_02
            #add-point:ON CHANGE l_xmig013_02 name="input.g.page1.l_xmig013_02"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_03
            #add-point:BEFORE FIELD l_xmig013_03 name="input.b.page1.l_xmig013_03"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_03
            
            #add-point:AFTER FIELD l_xmig013_03 name="input.a.page1.l_xmig013_03"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_03
            #add-point:ON CHANGE l_xmig013_03 name="input.g.page1.l_xmig013_03"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_04
            #add-point:BEFORE FIELD l_xmig013_04 name="input.b.page1.l_xmig013_04"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_04
            
            #add-point:AFTER FIELD l_xmig013_04 name="input.a.page1.l_xmig013_04"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_04
            #add-point:ON CHANGE l_xmig013_04 name="input.g.page1.l_xmig013_04"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_05
            #add-point:BEFORE FIELD l_xmig013_05 name="input.b.page1.l_xmig013_05"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_05
            
            #add-point:AFTER FIELD l_xmig013_05 name="input.a.page1.l_xmig013_05"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_05
            #add-point:ON CHANGE l_xmig013_05 name="input.g.page1.l_xmig013_05"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_06
            #add-point:BEFORE FIELD l_xmig013_06 name="input.b.page1.l_xmig013_06"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_06
            
            #add-point:AFTER FIELD l_xmig013_06 name="input.a.page1.l_xmig013_06"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_06
            #add-point:ON CHANGE l_xmig013_06 name="input.g.page1.l_xmig013_06"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_07
            #add-point:BEFORE FIELD l_xmig013_07 name="input.b.page1.l_xmig013_07"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_07
            
            #add-point:AFTER FIELD l_xmig013_07 name="input.a.page1.l_xmig013_07"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_07
            #add-point:ON CHANGE l_xmig013_07 name="input.g.page1.l_xmig013_07"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_08
            #add-point:BEFORE FIELD l_xmig013_08 name="input.b.page1.l_xmig013_08"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_08
            
            #add-point:AFTER FIELD l_xmig013_08 name="input.a.page1.l_xmig013_08"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_08
            #add-point:ON CHANGE l_xmig013_08 name="input.g.page1.l_xmig013_08"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_09
            #add-point:BEFORE FIELD l_xmig013_09 name="input.b.page1.l_xmig013_09"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_09
            
            #add-point:AFTER FIELD l_xmig013_09 name="input.a.page1.l_xmig013_09"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_09
            #add-point:ON CHANGE l_xmig013_09 name="input.g.page1.l_xmig013_09"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_10
            #add-point:BEFORE FIELD l_xmig013_10 name="input.b.page1.l_xmig013_10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_10
            
            #add-point:AFTER FIELD l_xmig013_10 name="input.a.page1.l_xmig013_10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_10
            #add-point:ON CHANGE l_xmig013_10 name="input.g.page1.l_xmig013_10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_11
            #add-point:BEFORE FIELD l_xmig013_11 name="input.b.page1.l_xmig013_11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_11
            
            #add-point:AFTER FIELD l_xmig013_11 name="input.a.page1.l_xmig013_11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_11
            #add-point:ON CHANGE l_xmig013_11 name="input.g.page1.l_xmig013_11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_12
            #add-point:BEFORE FIELD l_xmig013_12 name="input.b.page1.l_xmig013_12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_12
            
            #add-point:AFTER FIELD l_xmig013_12 name="input.a.page1.l_xmig013_12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_12
            #add-point:ON CHANGE l_xmig013_12 name="input.g.page1.l_xmig013_12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_13
            #add-point:BEFORE FIELD l_xmig013_13 name="input.b.page1.l_xmig013_13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_13
            
            #add-point:AFTER FIELD l_xmig013_13 name="input.a.page1.l_xmig013_13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_13
            #add-point:ON CHANGE l_xmig013_13 name="input.g.page1.l_xmig013_13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_14
            #add-point:BEFORE FIELD l_xmig013_14 name="input.b.page1.l_xmig013_14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_14
            
            #add-point:AFTER FIELD l_xmig013_14 name="input.a.page1.l_xmig013_14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_14
            #add-point:ON CHANGE l_xmig013_14 name="input.g.page1.l_xmig013_14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_15
            #add-point:BEFORE FIELD l_xmig013_15 name="input.b.page1.l_xmig013_15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_15
            
            #add-point:AFTER FIELD l_xmig013_15 name="input.a.page1.l_xmig013_15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_15
            #add-point:ON CHANGE l_xmig013_15 name="input.g.page1.l_xmig013_15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_16
            #add-point:BEFORE FIELD l_xmig013_16 name="input.b.page1.l_xmig013_16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_16
            
            #add-point:AFTER FIELD l_xmig013_16 name="input.a.page1.l_xmig013_16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_16
            #add-point:ON CHANGE l_xmig013_16 name="input.g.page1.l_xmig013_16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_17
            #add-point:BEFORE FIELD l_xmig013_17 name="input.b.page1.l_xmig013_17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_17
            
            #add-point:AFTER FIELD l_xmig013_17 name="input.a.page1.l_xmig013_17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_17
            #add-point:ON CHANGE l_xmig013_17 name="input.g.page1.l_xmig013_17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_18
            #add-point:BEFORE FIELD l_xmig013_18 name="input.b.page1.l_xmig013_18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_18
            
            #add-point:AFTER FIELD l_xmig013_18 name="input.a.page1.l_xmig013_18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_18
            #add-point:ON CHANGE l_xmig013_18 name="input.g.page1.l_xmig013_18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_19
            #add-point:BEFORE FIELD l_xmig013_19 name="input.b.page1.l_xmig013_19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_19
            
            #add-point:AFTER FIELD l_xmig013_19 name="input.a.page1.l_xmig013_19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_19
            #add-point:ON CHANGE l_xmig013_19 name="input.g.page1.l_xmig013_19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_20
            #add-point:BEFORE FIELD l_xmig013_20 name="input.b.page1.l_xmig013_20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_20
            
            #add-point:AFTER FIELD l_xmig013_20 name="input.a.page1.l_xmig013_20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_20
            #add-point:ON CHANGE l_xmig013_20 name="input.g.page1.l_xmig013_20"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_21
            #add-point:BEFORE FIELD l_xmig013_21 name="input.b.page1.l_xmig013_21"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_21
            
            #add-point:AFTER FIELD l_xmig013_21 name="input.a.page1.l_xmig013_21"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_21
            #add-point:ON CHANGE l_xmig013_21 name="input.g.page1.l_xmig013_21"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_22
            #add-point:BEFORE FIELD l_xmig013_22 name="input.b.page1.l_xmig013_22"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_22
            
            #add-point:AFTER FIELD l_xmig013_22 name="input.a.page1.l_xmig013_22"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_22
            #add-point:ON CHANGE l_xmig013_22 name="input.g.page1.l_xmig013_22"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_23
            #add-point:BEFORE FIELD l_xmig013_23 name="input.b.page1.l_xmig013_23"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_23
            
            #add-point:AFTER FIELD l_xmig013_23 name="input.a.page1.l_xmig013_23"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_23
            #add-point:ON CHANGE l_xmig013_23 name="input.g.page1.l_xmig013_23"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig013_24
            #add-point:BEFORE FIELD l_xmig013_24 name="input.b.page1.l_xmig013_24"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig013_24
            
            #add-point:AFTER FIELD l_xmig013_24 name="input.a.page1.l_xmig013_24"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig013_24
            #add-point:ON CHANGE l_xmig013_24 name="input.g.page1.l_xmig013_24"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmig016
            #add-point:BEFORE FIELD xmig016 name="input.b.page1.xmig016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmig016
            
            #add-point:AFTER FIELD xmig016 name="input.a.page1.xmig016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmig016
            #add-point:ON CHANGE xmig016 name="input.g.page1.xmig016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_01
            #add-point:BEFORE FIELD l_xmig016_01 name="input.b.page1.l_xmig016_01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_01
            
            #add-point:AFTER FIELD l_xmig016_01 name="input.a.page1.l_xmig016_01"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_01
            #add-point:ON CHANGE l_xmig016_01 name="input.g.page1.l_xmig016_01"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_02
            #add-point:BEFORE FIELD l_xmig016_02 name="input.b.page1.l_xmig016_02"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_02
            
            #add-point:AFTER FIELD l_xmig016_02 name="input.a.page1.l_xmig016_02"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_02
            #add-point:ON CHANGE l_xmig016_02 name="input.g.page1.l_xmig016_02"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_03
            #add-point:BEFORE FIELD l_xmig016_03 name="input.b.page1.l_xmig016_03"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_03
            
            #add-point:AFTER FIELD l_xmig016_03 name="input.a.page1.l_xmig016_03"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_03
            #add-point:ON CHANGE l_xmig016_03 name="input.g.page1.l_xmig016_03"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_04
            #add-point:BEFORE FIELD l_xmig016_04 name="input.b.page1.l_xmig016_04"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_04
            
            #add-point:AFTER FIELD l_xmig016_04 name="input.a.page1.l_xmig016_04"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_04
            #add-point:ON CHANGE l_xmig016_04 name="input.g.page1.l_xmig016_04"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_05
            #add-point:BEFORE FIELD l_xmig016_05 name="input.b.page1.l_xmig016_05"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_05
            
            #add-point:AFTER FIELD l_xmig016_05 name="input.a.page1.l_xmig016_05"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_05
            #add-point:ON CHANGE l_xmig016_05 name="input.g.page1.l_xmig016_05"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_06
            #add-point:BEFORE FIELD l_xmig016_06 name="input.b.page1.l_xmig016_06"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_06
            
            #add-point:AFTER FIELD l_xmig016_06 name="input.a.page1.l_xmig016_06"
            IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_06) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_06
            #add-point:ON CHANGE l_xmig016_06 name="input.g.page1.l_xmig016_06"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_07
            #add-point:BEFORE FIELD l_xmig016_07 name="input.b.page1.l_xmig016_07"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_07
            
            #add-point:AFTER FIELD l_xmig016_07 name="input.a.page1.l_xmig016_07"
            IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_07) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_07
            #add-point:ON CHANGE l_xmig016_07 name="input.g.page1.l_xmig016_07"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_08
            #add-point:BEFORE FIELD l_xmig016_08 name="input.b.page1.l_xmig016_08"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_08
            
            #add-point:AFTER FIELD l_xmig016_08 name="input.a.page1.l_xmig016_08"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_08
            #add-point:ON CHANGE l_xmig016_08 name="input.g.page1.l_xmig016_08"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_09
            #add-point:BEFORE FIELD l_xmig016_09 name="input.b.page1.l_xmig016_09"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_09
            
            #add-point:AFTER FIELD l_xmig016_09 name="input.a.page1.l_xmig016_09"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_09
            #add-point:ON CHANGE l_xmig016_09 name="input.g.page1.l_xmig016_09"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_10
            #add-point:BEFORE FIELD l_xmig016_10 name="input.b.page1.l_xmig016_10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_10
            
            #add-point:AFTER FIELD l_xmig016_10 name="input.a.page1.l_xmig016_10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_10
            #add-point:ON CHANGE l_xmig016_10 name="input.g.page1.l_xmig016_10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_11
            #add-point:BEFORE FIELD l_xmig016_11 name="input.b.page1.l_xmig016_11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_11
            
            #add-point:AFTER FIELD l_xmig016_11 name="input.a.page1.l_xmig016_11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_11
            #add-point:ON CHANGE l_xmig016_11 name="input.g.page1.l_xmig016_11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_12
            #add-point:BEFORE FIELD l_xmig016_12 name="input.b.page1.l_xmig016_12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_12
            
            #add-point:AFTER FIELD l_xmig016_12 name="input.a.page1.l_xmig016_12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_12
            #add-point:ON CHANGE l_xmig016_12 name="input.g.page1.l_xmig016_12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_13
            #add-point:BEFORE FIELD l_xmig016_13 name="input.b.page1.l_xmig016_13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_13
            
            #add-point:AFTER FIELD l_xmig016_13 name="input.a.page1.l_xmig016_13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_13
            #add-point:ON CHANGE l_xmig016_13 name="input.g.page1.l_xmig016_13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_14
            #add-point:BEFORE FIELD l_xmig016_14 name="input.b.page1.l_xmig016_14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_14
            
            #add-point:AFTER FIELD l_xmig016_14 name="input.a.page1.l_xmig016_14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_14
            #add-point:ON CHANGE l_xmig016_14 name="input.g.page1.l_xmig016_14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_15
            #add-point:BEFORE FIELD l_xmig016_15 name="input.b.page1.l_xmig016_15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_15
            
            #add-point:AFTER FIELD l_xmig016_15 name="input.a.page1.l_xmig016_15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_15
            #add-point:ON CHANGE l_xmig016_15 name="input.g.page1.l_xmig016_15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_16
            #add-point:BEFORE FIELD l_xmig016_16 name="input.b.page1.l_xmig016_16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_16
            
            #add-point:AFTER FIELD l_xmig016_16 name="input.a.page1.l_xmig016_16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_16
            #add-point:ON CHANGE l_xmig016_16 name="input.g.page1.l_xmig016_16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_17
            #add-point:BEFORE FIELD l_xmig016_17 name="input.b.page1.l_xmig016_17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_17
            
            #add-point:AFTER FIELD l_xmig016_17 name="input.a.page1.l_xmig016_17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_17
            #add-point:ON CHANGE l_xmig016_17 name="input.g.page1.l_xmig016_17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_18
            #add-point:BEFORE FIELD l_xmig016_18 name="input.b.page1.l_xmig016_18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_18
            
            #add-point:AFTER FIELD l_xmig016_18 name="input.a.page1.l_xmig016_18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_18
            #add-point:ON CHANGE l_xmig016_18 name="input.g.page1.l_xmig016_18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_19
            #add-point:BEFORE FIELD l_xmig016_19 name="input.b.page1.l_xmig016_19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_19
            
            #add-point:AFTER FIELD l_xmig016_19 name="input.a.page1.l_xmig016_19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_19
            #add-point:ON CHANGE l_xmig016_19 name="input.g.page1.l_xmig016_19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_20
            #add-point:BEFORE FIELD l_xmig016_20 name="input.b.page1.l_xmig016_20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_20
            
            #add-point:AFTER FIELD l_xmig016_20 name="input.a.page1.l_xmig016_20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_20
            #add-point:ON CHANGE l_xmig016_20 name="input.g.page1.l_xmig016_20"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_21
            #add-point:BEFORE FIELD l_xmig016_21 name="input.b.page1.l_xmig016_21"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_21
            
            #add-point:AFTER FIELD l_xmig016_21 name="input.a.page1.l_xmig016_21"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_21
            #add-point:ON CHANGE l_xmig016_21 name="input.g.page1.l_xmig016_21"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_22
            #add-point:BEFORE FIELD l_xmig016_22 name="input.b.page1.l_xmig016_22"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_22
            
            #add-point:AFTER FIELD l_xmig016_22 name="input.a.page1.l_xmig016_22"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_22
            #add-point:ON CHANGE l_xmig016_22 name="input.g.page1.l_xmig016_22"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_23
            #add-point:BEFORE FIELD l_xmig016_23 name="input.b.page1.l_xmig016_23"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_23
            
            #add-point:AFTER FIELD l_xmig016_23 name="input.a.page1.l_xmig016_23"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_23
            #add-point:ON CHANGE l_xmig016_23 name="input.g.page1.l_xmig016_23"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_24
            #add-point:BEFORE FIELD l_xmig016_24 name="input.b.page1.l_xmig016_24"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_24
            
            #add-point:AFTER FIELD l_xmig016_24 name="input.a.page1.l_xmig016_24"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_24
            #add-point:ON CHANGE l_xmig016_24 name="input.g.page1.l_xmig016_24"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmig016_s
            #add-point:BEFORE FIELD l_xmig016_s name="input.b.page1.l_xmig016_s"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmig016_s
            
            #add-point:AFTER FIELD l_xmig016_s name="input.a.page1.l_xmig016_s"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmig016_s
            #add-point:ON CHANGE l_xmig016_s name="input.g.page1.l_xmig016_s"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmig017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig017
            #add-point:ON ACTION controlp INFIELD xmig017 name="input.c.page1.xmig017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig006
            #add-point:ON ACTION controlp INFIELD xmig006 name="input.c.page1.xmig006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig007
            #add-point:ON ACTION controlp INFIELD xmig007 name="input.c.page1.xmig007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig004
            #add-point:ON ACTION controlp INFIELD xmig004 name="input.c.page1.xmig004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig005
            #add-point:ON ACTION controlp INFIELD xmig005 name="input.c.page1.xmig005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig008
            #add-point:ON ACTION controlp INFIELD xmig008 name="input.c.page1.xmig008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig009
            #add-point:ON ACTION controlp INFIELD xmig009 name="input.c.page1.xmig009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig010
            #add-point:ON ACTION controlp INFIELD xmig010 name="input.c.page1.xmig010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig018
            #add-point:ON ACTION controlp INFIELD xmig018 name="input.c.page1.xmig018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig013
            #add-point:ON ACTION controlp INFIELD xmig013 name="input.c.page1.xmig013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_01
            #add-point:ON ACTION controlp INFIELD l_xmig013_01 name="input.c.page1.l_xmig013_01"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_02
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_02
            #add-point:ON ACTION controlp INFIELD l_xmig013_02 name="input.c.page1.l_xmig013_02"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_03
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_03
            #add-point:ON ACTION controlp INFIELD l_xmig013_03 name="input.c.page1.l_xmig013_03"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_04
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_04
            #add-point:ON ACTION controlp INFIELD l_xmig013_04 name="input.c.page1.l_xmig013_04"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_05
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_05
            #add-point:ON ACTION controlp INFIELD l_xmig013_05 name="input.c.page1.l_xmig013_05"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_06
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_06
            #add-point:ON ACTION controlp INFIELD l_xmig013_06 name="input.c.page1.l_xmig013_06"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_07
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_07
            #add-point:ON ACTION controlp INFIELD l_xmig013_07 name="input.c.page1.l_xmig013_07"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_08
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_08
            #add-point:ON ACTION controlp INFIELD l_xmig013_08 name="input.c.page1.l_xmig013_08"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_09
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_09
            #add-point:ON ACTION controlp INFIELD l_xmig013_09 name="input.c.page1.l_xmig013_09"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_10
            #add-point:ON ACTION controlp INFIELD l_xmig013_10 name="input.c.page1.l_xmig013_10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_11
            #add-point:ON ACTION controlp INFIELD l_xmig013_11 name="input.c.page1.l_xmig013_11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_12
            #add-point:ON ACTION controlp INFIELD l_xmig013_12 name="input.c.page1.l_xmig013_12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_13
            #add-point:ON ACTION controlp INFIELD l_xmig013_13 name="input.c.page1.l_xmig013_13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_14
            #add-point:ON ACTION controlp INFIELD l_xmig013_14 name="input.c.page1.l_xmig013_14"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_15
            #add-point:ON ACTION controlp INFIELD l_xmig013_15 name="input.c.page1.l_xmig013_15"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_16
            #add-point:ON ACTION controlp INFIELD l_xmig013_16 name="input.c.page1.l_xmig013_16"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_17
            #add-point:ON ACTION controlp INFIELD l_xmig013_17 name="input.c.page1.l_xmig013_17"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_18
            #add-point:ON ACTION controlp INFIELD l_xmig013_18 name="input.c.page1.l_xmig013_18"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_19
            #add-point:ON ACTION controlp INFIELD l_xmig013_19 name="input.c.page1.l_xmig013_19"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_20
            #add-point:ON ACTION controlp INFIELD l_xmig013_20 name="input.c.page1.l_xmig013_20"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_21
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_21
            #add-point:ON ACTION controlp INFIELD l_xmig013_21 name="input.c.page1.l_xmig013_21"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_22
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_22
            #add-point:ON ACTION controlp INFIELD l_xmig013_22 name="input.c.page1.l_xmig013_22"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_23
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_23
            #add-point:ON ACTION controlp INFIELD l_xmig013_23 name="input.c.page1.l_xmig013_23"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig013_24
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig013_24
            #add-point:ON ACTION controlp INFIELD l_xmig013_24 name="input.c.page1.l_xmig013_24"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmig016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmig016
            #add-point:ON ACTION controlp INFIELD xmig016 name="input.c.page1.xmig016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_01
            #add-point:ON ACTION controlp INFIELD l_xmig016_01 name="input.c.page1.l_xmig016_01"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_02
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_02
            #add-point:ON ACTION controlp INFIELD l_xmig016_02 name="input.c.page1.l_xmig016_02"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_03
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_03
            #add-point:ON ACTION controlp INFIELD l_xmig016_03 name="input.c.page1.l_xmig016_03"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_04
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_04
            #add-point:ON ACTION controlp INFIELD l_xmig016_04 name="input.c.page1.l_xmig016_04"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_05
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_05
            #add-point:ON ACTION controlp INFIELD l_xmig016_05 name="input.c.page1.l_xmig016_05"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_06
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_06
            #add-point:ON ACTION controlp INFIELD l_xmig016_06 name="input.c.page1.l_xmig016_06"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_07
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_07
            #add-point:ON ACTION controlp INFIELD l_xmig016_07 name="input.c.page1.l_xmig016_07"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_08
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_08
            #add-point:ON ACTION controlp INFIELD l_xmig016_08 name="input.c.page1.l_xmig016_08"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_09
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_09
            #add-point:ON ACTION controlp INFIELD l_xmig016_09 name="input.c.page1.l_xmig016_09"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_10
            #add-point:ON ACTION controlp INFIELD l_xmig016_10 name="input.c.page1.l_xmig016_10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_11
            #add-point:ON ACTION controlp INFIELD l_xmig016_11 name="input.c.page1.l_xmig016_11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_12
            #add-point:ON ACTION controlp INFIELD l_xmig016_12 name="input.c.page1.l_xmig016_12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_13
            #add-point:ON ACTION controlp INFIELD l_xmig016_13 name="input.c.page1.l_xmig016_13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_14
            #add-point:ON ACTION controlp INFIELD l_xmig016_14 name="input.c.page1.l_xmig016_14"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_15
            #add-point:ON ACTION controlp INFIELD l_xmig016_15 name="input.c.page1.l_xmig016_15"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_16
            #add-point:ON ACTION controlp INFIELD l_xmig016_16 name="input.c.page1.l_xmig016_16"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_17
            #add-point:ON ACTION controlp INFIELD l_xmig016_17 name="input.c.page1.l_xmig016_17"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_18
            #add-point:ON ACTION controlp INFIELD l_xmig016_18 name="input.c.page1.l_xmig016_18"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_19
            #add-point:ON ACTION controlp INFIELD l_xmig016_19 name="input.c.page1.l_xmig016_19"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_20
            #add-point:ON ACTION controlp INFIELD l_xmig016_20 name="input.c.page1.l_xmig016_20"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_21
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_21
            #add-point:ON ACTION controlp INFIELD l_xmig016_21 name="input.c.page1.l_xmig016_21"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_22
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_22
            #add-point:ON ACTION controlp INFIELD l_xmig016_22 name="input.c.page1.l_xmig016_22"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_23
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_23
            #add-point:ON ACTION controlp INFIELD l_xmig016_23 name="input.c.page1.l_xmig016_23"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_24
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_24
            #add-point:ON ACTION controlp INFIELD l_xmig016_24 name="input.c.page1.l_xmig016_24"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xmig016_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmig016_s
            #add-point:ON ACTION controlp INFIELD l_xmig016_s name="input.c.page1.l_xmig016_s"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmig_d[l_ac].* = g_xmig_d_t.*
               CLOSE axmt174_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xmig_d[l_ac].xmig004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmig_d[l_ac].* = g_xmig_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
 
               #end add-point
         
               #將遮罩欄位還原
               CALL axmt174_xmig_t_mask_restore('restore_mask_o')
         
               UPDATE xmig_t SET (xmigsite,xmig001,xmig002,xmig003,xmig017,xmig006,xmig007,xmig004,xmig005, 
                   xmig008,xmig009,xmig010,xmig018,xmig013,xmig016) = (g_xmig_m.xmigsite,g_xmig_m.xmig001, 
                   g_xmig_m.xmig002,g_xmig_m.xmig003,g_xmig_d[l_ac].xmig017,g_xmig_d[l_ac].xmig006,g_xmig_d[l_ac].xmig007, 
                   g_xmig_d[l_ac].xmig004,g_xmig_d[l_ac].xmig005,g_xmig_d[l_ac].xmig008,g_xmig_d[l_ac].xmig009, 
                   g_xmig_d[l_ac].xmig010,g_xmig_d[l_ac].xmig018,g_xmig_d[l_ac].xmig013,g_xmig_d[l_ac].xmig016) 
 
                WHERE xmigent = g_enterprise AND xmigsite = g_xmig_m.xmigsite 
                 AND xmig001 = g_xmig_m.xmig001 
                 AND xmig002 = g_xmig_m.xmig002 
                 AND xmig003 = g_xmig_m.xmig003 
 
                 AND xmig004 = g_xmig_d_t.xmig004 #項次   
                 AND xmig005 = g_xmig_d_t.xmig005  
                 AND xmig006 = g_xmig_d_t.xmig006  
                 AND xmig007 = g_xmig_d_t.xmig007  
                 AND xmig008 = g_xmig_d_t.xmig008  
                 AND xmig009 = g_xmig_d_t.xmig009  
                 AND xmig010 = g_xmig_d_t.xmig010  
                 AND xmig017 = g_xmig_d_t.xmig017  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               CALL axmt174_upd_xmig() RETURNING r_success
               IF r_success = 'N' THEN
               #  CALL cl_err('','',1)
                  LET g_xmig_d[l_ac].* = g_xmig_d_t.*                     
                  CALL s_transaction_end('N','0')               
               END IF
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmig_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xmig_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmig_m.xmigsite
               LET gs_keys_bak[1] = g_xmigsite_t
               LET gs_keys[2] = g_xmig_m.xmig001
               LET gs_keys_bak[2] = g_xmig001_t
               LET gs_keys[3] = g_xmig_m.xmig002
               LET gs_keys_bak[3] = g_xmig002_t
               LET gs_keys[4] = g_xmig_m.xmig003
               LET gs_keys_bak[4] = g_xmig003_t
               LET gs_keys[5] = g_xmig_d[g_detail_idx].xmig004
               LET gs_keys_bak[5] = g_xmig_d_t.xmig004
               LET gs_keys[6] = g_xmig_d[g_detail_idx].xmig005
               LET gs_keys_bak[6] = g_xmig_d_t.xmig005
               LET gs_keys[7] = g_xmig_d[g_detail_idx].xmig006
               LET gs_keys_bak[7] = g_xmig_d_t.xmig006
               LET gs_keys[8] = g_xmig_d[g_detail_idx].xmig007
               LET gs_keys_bak[8] = g_xmig_d_t.xmig007
               LET gs_keys[9] = g_xmig_d[g_detail_idx].xmig008
               LET gs_keys_bak[9] = g_xmig_d_t.xmig008
               LET gs_keys[10] = g_xmig_d[g_detail_idx].xmig009
               LET gs_keys_bak[10] = g_xmig_d_t.xmig009
               LET gs_keys[11] = g_xmig_d[g_detail_idx].xmig010
               LET gs_keys_bak[11] = g_xmig_d_t.xmig010
               LET gs_keys[12] = g_xmig_d[g_detail_idx].xmig017
               LET gs_keys_bak[12] = g_xmig_d_t.xmig017
               CALL axmt174_update_b('xmig_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xmig_m),util.JSON.stringify(g_xmig_d_t)
                     LET g_log2 = util.JSON.stringify(g_xmig_m),util.JSON.stringify(g_xmig_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt174_xmig_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xmig_m.xmigsite
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_m.xmig001
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_m.xmig002
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_m.xmig003
 
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_d_t.xmig004
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_d_t.xmig005
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_d_t.xmig006
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_d_t.xmig007
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_d_t.xmig008
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_d_t.xmig009
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_d_t.xmig010
               LET ls_keys[ls_keys.getLength()+1] = g_xmig_d_t.xmig017
 
               CALL axmt174_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axmt174_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmig_d[l_ac].* = g_xmig_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axmt174_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xmig_d.getLength() = 0 THEN
               NEXT FIELD xmig004
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmig_d[li_reproduce_target].* = g_xmig_d[li_reproduce].*
 
               LET g_xmig_d[li_reproduce_target].xmig004 = NULL
               LET g_xmig_d[li_reproduce_target].xmig005 = NULL
               LET g_xmig_d[li_reproduce_target].xmig006 = NULL
               LET g_xmig_d[li_reproduce_target].xmig007 = NULL
               LET g_xmig_d[li_reproduce_target].xmig008 = NULL
               LET g_xmig_d[li_reproduce_target].xmig009 = NULL
               LET g_xmig_d[li_reproduce_target].xmig010 = NULL
               LET g_xmig_d[li_reproduce_target].xmig017 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmig_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmig_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"

      INPUT ARRAY g_xmig2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)

         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_xmig2_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL axmt174_b_fill(g_wc2)
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF

         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx


            CALL s_transaction_begin()

            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axmt174_cl USING g_enterprise,
                                               g_xmig_m.xmigsite
                                               ,g_xmig_m.xmig001

                                               ,g_xmig_m.xmig002

                                               ,g_xmig_m.xmig003



               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axmt174_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE axmt174_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF

            LET l_cmd = ''

            IF g_rec_b1 >= l_ac AND g_xmig_d[l_ac].xmig006 IS NOT NULL THEN
               LET l_cmd='u'
               LET g_xmig2_d_t.* = g_xmig2_d[l_ac].*  #BACKUP
               CALL axmt174_set_entry_b(l_cmd)
               CALL axmt174_set_no_entry_b(l_cmd)
               OPEN axmt174_bcl2 USING g_enterprise,g_xmig_m.xmigsite,
                                                g_xmig_m.xmig001,

                                                g_xmig_m.xmig002,

                                                g_xmig_m.xmig003,

                                                g_xmig_d_t.xmig006

               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN axmt174_bcl2:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt174_bcl2 INTO g_xmig2_d[l_ac].l_xmig006_2,g_xmig2_d[l_ac].l_xmig006_2_desc,
                      g_xmig2_d[l_ac].l_xmig006_2_desc1,g_xmig2_d[l_ac].l_xmig006_2_desc2,
                      g_xmig2_d[l_ac].l_xmig006_2_desc3,g_xmig2_d[l_ac].l_xmig013_2_01,
                      g_xmig2_d[l_ac].l_xmig013_2_02,g_xmig2_d[l_ac].l_xmig013_2_03,g_xmig2_d[l_ac].l_xmig013_2_04,
                      g_xmig2_d[l_ac].l_xmig013_2_05,g_xmig2_d[l_ac].l_xmig013_2_06,g_xmig2_d[l_ac].l_xmig013_2_07,
                      g_xmig2_d[l_ac].l_xmig013_2_08,g_xmig2_d[l_ac].l_xmig013_2_09,g_xmig2_d[l_ac].l_xmig013_2_10,
                      g_xmig2_d[l_ac].l_xmig013_2_11,g_xmig2_d[l_ac].l_xmig013_2_12,g_xmig2_d[l_ac].l_xmig013_2_13,
                      g_xmig2_d[l_ac].l_xmig013_2_14,g_xmig2_d[l_ac].l_xmig013_2_15,g_xmig2_d[l_ac].l_xmig013_2_16,
                      g_xmig2_d[l_ac].l_xmig013_2_17,g_xmig2_d[l_ac].l_xmig013_2_18,g_xmig2_d[l_ac].l_xmig013_2_19,
                      g_xmig2_d[l_ac].l_xmig013_2_20,g_xmig2_d[l_ac].l_xmig013_2_21,g_xmig2_d[l_ac].l_xmig013_2_22,
                      g_xmig2_d[l_ac].l_xmig013_2_23,g_xmig2_d[l_ac].l_xmig013_2_24,g_xmig2_d[l_ac].l_xmig016_2_01,
                      g_xmig2_d[l_ac].l_xmig016_2_02,g_xmig2_d[l_ac].l_xmig016_2_03,g_xmig2_d[l_ac].l_xmig016_2_04,
                      g_xmig2_d[l_ac].l_xmig016_2_05,g_xmig2_d[l_ac].l_xmig016_2_06,g_xmig2_d[l_ac].l_xmig016_2_07,
                      g_xmig2_d[l_ac].l_xmig016_2_08,g_xmig2_d[l_ac].l_xmig016_2_09,g_xmig2_d[l_ac].l_xmig016_2_10,
                      g_xmig2_d[l_ac].l_xmig016_2_11,g_xmig2_d[l_ac].l_xmig016_2_12,g_xmig2_d[l_ac].l_xmig016_2_13,
                      g_xmig2_d[l_ac].l_xmig016_2_14,g_xmig2_d[l_ac].l_xmig016_2_15,g_xmig2_d[l_ac].l_xmig016_2_16,
                      g_xmig2_d[l_ac].l_xmig016_2_17,g_xmig2_d[l_ac].l_xmig016_2_18,g_xmig2_d[l_ac].l_xmig016_2_19,
                      g_xmig2_d[l_ac].l_xmig016_2_20,g_xmig2_d[l_ac].l_xmig016_2_21,g_xmig2_d[l_ac].l_xmig016_2_22,
                      g_xmig2_d[l_ac].l_xmig016_2_23,g_xmig2_d[l_ac].l_xmig016_2_24,g_xmig2_d[l_ac].l_xmig016_2_s

                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_xmig2_d_t.l_xmig006_2
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF

                  CALL axmt174_ref_show()
                  CALL cl_show_fld_cont()
                  LET l_ac_1 = l_ac
                  CALL axmt174_show()
                  LET l_ac = l_ac_1                  
               END IF
            ELSE
               LET l_cmd='a'
            END IF
 
         BEFORE INSERT

         AFTER INSERT     
         
         BEFORE DELETE 

         AFTER FIELD l_xmig016_2_01 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_01) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_01 = 0
            END IF
         AFTER FIELD l_xmig016_2_02 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_02) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_02 = 0
            END IF
         AFTER FIELD l_xmig016_2_03 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_03) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_03 = 0
            END IF
         AFTER FIELD l_xmig016_2_04 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_04) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_04 = 0
            END IF
         AFTER FIELD l_xmig016_2_05 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_05) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_05 = 0
            END IF
         AFTER FIELD l_xmig016_2_06 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_06) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_06 = 0
            END IF
         AFTER FIELD l_xmig016_2_07 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_07) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_07 = 0
            END IF
         AFTER FIELD l_xmig016_2_08 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_08) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_08 = 0
            END IF
         AFTER FIELD l_xmig016_2_09
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_09) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_09 = 0
            END IF
         AFTER FIELD l_xmig016_2_10
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_10) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_10 = 0
            END IF
         AFTER FIELD l_xmig016_2_11 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_11) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_11 = 0
            END IF
         AFTER FIELD l_xmig016_2_12 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_12) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_12 = 0
            END IF
         AFTER FIELD l_xmig016_2_13 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_13) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_13 = 0
            END IF
         AFTER FIELD l_xmig016_2_14 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_14) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_14 = 0
            END IF
         AFTER FIELD l_xmig016_2_15 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_15) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_15 = 0
            END IF
         AFTER FIELD l_xmig016_2_16 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_16) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_16 = 0
            END IF
         AFTER FIELD l_xmig016_2_17 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_17) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_17 = 0
            END IF
         AFTER FIELD l_xmig016_2_18 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_18) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_18 = 0
            END IF
         AFTER FIELD l_xmig016_2_19
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_19) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_19 = 0
            END IF
         AFTER FIELD l_xmig016_2_20
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_20) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_20 = 0
            END IF
         AFTER FIELD l_xmig016_2_21 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_21) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_21 = 0
            END IF    
         AFTER FIELD l_xmig016_2_22 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_22) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_22 = 0
            END IF  
         AFTER FIELD l_xmig016_2_23 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_23) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_23 = 0
            END IF  
         AFTER FIELD l_xmig016_2_24 
            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_24) THEN
               LET g_xmig2_d[l_ac].l_xmig016_2_24 = 0
            END IF              

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xmig2_d[l_ac].* = g_xmig2_d_t.*
               CLOSE axmt174_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            CALL axmt174_xmig_allot() RETURNING r_success

            IF r_success = 'Y' THEN
               #尾差處理
               IF NOT axmt174_xmig016_diff() THEN
                  CALL s_transaction_end('N','0')
               ELSE               
                  CALL s_transaction_end('Y','0')  
               END IF                  
            ELSE
               CALL s_transaction_end('N','0')
            END IF            
      END INPUT
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         CALL cl_set_act_visible("insert,delete,modify,modify_detail,reproduce", FALSE)
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xmigsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xmig017
 
            END CASE
         END IF
   
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
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
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axmt174_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL cl_set_comp_visible("xmigsite",TRUE)
   LET g_bfill = 'Y'
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axmt174_b_fill(g_wc2) #第一階單身填充
      CALL axmt174_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axmt174_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xmig_m.xmigsite,g_xmig_m.xmigsite_desc,g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig001_desc, 
       g_xmig_m.xmig003
 
   CALL axmt174_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   #CALL axmt174_desc_date()   #add by lixh 20150831
   CALL axmt174_xmig_hide()
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axmt174_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   DEFINE r_success   LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_m.xmigsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_m.xmigsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_m.xmigsite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_m.xmig001
            CALL ap_ref_array2(g_ref_fields,"SELECT xmial003 FROM xmial_t WHERE xmialent='"||g_enterprise||"' AND xmial001=? AND xmial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_m.xmig001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_m.xmig001_desc

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xmig_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig006_desc = '', g_rtn_fields[1] , ''
            LET g_xmig_d[l_ac].xmig006_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig006_desc
            DISPLAY BY NAME g_xmig_d[l_ac].xmig006_desc_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig008
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig008_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='275' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig009_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig018_desc
            CALL axmt174_xmig004_desc()
            CALL axmt174_xmig005_desc()
            CALL s_feature_description(g_xmig_d[l_ac].xmig006,g_xmig_d[l_ac].xmig007)
                RETURNING r_success,g_xmig_d[l_ac].xmig007_desc             
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axmt174_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xmig_t.xmigsite 
   DEFINE l_oldno     LIKE xmig_t.xmigsite 
   DEFINE l_newno02     LIKE xmig_t.xmig001 
   DEFINE l_oldno02     LIKE xmig_t.xmig001 
   DEFINE l_newno03     LIKE xmig_t.xmig002 
   DEFINE l_oldno03     LIKE xmig_t.xmig002 
   DEFINE l_newno04     LIKE xmig_t.xmig003 
   DEFINE l_oldno04     LIKE xmig_t.xmig003 
 
   DEFINE l_master    RECORD LIKE xmig_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xmig_t.* #此變數樣板目前無使用
 
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
 
   IF g_xmig_m.xmigsite IS NULL
      OR g_xmig_m.xmig001 IS NULL
      OR g_xmig_m.xmig002 IS NULL
      OR g_xmig_m.xmig003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xmigsite_t = g_xmig_m.xmigsite
   LET g_xmig001_t = g_xmig_m.xmig001
   LET g_xmig002_t = g_xmig_m.xmig002
   LET g_xmig003_t = g_xmig_m.xmig003
 
   
   LET g_xmig_m.xmigsite = ""
   LET g_xmig_m.xmig001 = ""
   LET g_xmig_m.xmig002 = ""
   LET g_xmig_m.xmig003 = ""
 
   LET g_master_insert = FALSE
   CALL axmt174_set_entry('a')
   CALL axmt174_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xmig_m.xmigsite_desc = ''
   DISPLAY BY NAME g_xmig_m.xmigsite_desc
   LET g_xmig_m.xmig001_desc = ''
   DISPLAY BY NAME g_xmig_m.xmig001_desc
 
   
   CALL axmt174_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xmig_m.* TO NULL
      INITIALIZE g_xmig_d TO NULL
 
      CALL axmt174_show()
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt174_set_act_visible()
   CALL axmt174_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xmigsite_t = g_xmig_m.xmigsite
   LET g_xmig001_t = g_xmig_m.xmig001
   LET g_xmig002_t = g_xmig_m.xmig002
   LET g_xmig003_t = g_xmig_m.xmig003
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmigent = " ||g_enterprise|| " AND",
                      " xmigsite = '", g_xmig_m.xmigsite, "' "
                      ," AND xmig001 = '", g_xmig_m.xmig001, "' "
                      ," AND xmig002 = '", g_xmig_m.xmig002, "' "
                      ," AND xmig003 = '", g_xmig_m.xmig003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt174_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axmt174_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axmt174_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axmt174_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xmig_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axmt174_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmig_t
    WHERE xmigent = g_enterprise AND xmigsite = g_xmigsite_t
    AND xmig001 = g_xmig001_t
    AND xmig002 = g_xmig002_t
    AND xmig003 = g_xmig003_t
 
       INTO TEMP axmt174_detail
   
   #將key修正為調整後   
   UPDATE axmt174_detail 
      #更新key欄位
      SET xmigsite = g_xmig_m.xmigsite
          , xmig001 = g_xmig_m.xmig001
          , xmig002 = g_xmig_m.xmig002
          , xmig003 = g_xmig_m.xmig003
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xmig_t SELECT * FROM axmt174_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt174_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xmigsite_t = g_xmig_m.xmigsite
   LET g_xmig001_t = g_xmig_m.xmig001
   LET g_xmig002_t = g_xmig_m.xmig002
   LET g_xmig003_t = g_xmig_m.xmig003
 
   
   DROP TABLE axmt174_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axmt174_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE   l_success      LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xmig_m.xmigsite IS NULL
   OR g_xmig_m.xmig001 IS NULL
   OR g_xmig_m.xmig002 IS NULL
   OR g_xmig_m.xmig003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axmt174_cl USING g_enterprise,g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt174_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axmt174_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt174_master_referesh USING g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003 INTO g_xmig_m.xmigsite, 
       g_xmig_m.xmig002,g_xmig_m.xmig001,g_xmig_m.xmig003,g_xmig_m.xmigsite_desc,g_xmig_m.xmig001_desc 
 
   
   #遮罩相關處理
   LET g_xmig_m_mask_o.* =  g_xmig_m.*
   CALL axmt174_xmig_t_mask()
   LET g_xmig_m_mask_n.* =  g_xmig_m.*
   
   CALL axmt174_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmt174_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      CALL s_aooi360_del('6','axmt174',g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003,'','','','','','4') RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
      DELETE FROM xmig_t WHERE xmigent = g_enterprise AND xmigsite = g_xmig_m.xmigsite
                                                               AND xmig001 = g_xmig_m.xmig001
                                                               AND xmig002 = g_xmig_m.xmig002
                                                               AND xmig003 = g_xmig_m.xmig003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmig_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      CALL g_xmig2_d.clear()
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE axmt174_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xmig_d.clear() 
 
     
      CALL axmt174_ui_browser_refresh()  
      #CALL axmt174_ui_headershow()  
      #CALL axmt174_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axmt174_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axmt174_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axmt174_cl
 
   #功能已完成,通報訊息中心
   CALL axmt174_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axmt174.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmt174_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE i          LIKE type_t.num5
   DEFINE l_xmia002  LIKE xmia_t.xmia002
   DEFINE l_xmig004  LIKE xmig_t.xmig004
   DEFINE l_xmig005  LIKE xmig_t.xmig005 
   DEFINE l_xmig006  LIKE xmig_t.xmig006
   DEFINE l_xmig007  LIKE xmig_t.xmig007
   DEFINE l_xmig008  LIKE xmig_t.xmig008
   DEFINE l_xmig009  LIKE xmig_t.xmig009
   DEFINE l_xmig010  LIKE xmig_t.xmig010
   DEFINE g_sql1     STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xmig_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_xmig2_d.clear()
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xmig017,xmig006,xmig007,xmig004,xmig005,xmig008,xmig009,xmig010,xmig018, 
       xmig013,xmig016,t1.imaal003 ,t2.imaal004 ,t3.ooefl003 ,t4.ooag011 ,t5.pmaal004 ,t6.oojdl003 , 
       t7.oocal003 FROM xmig_t",   
               "",
               
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmig006 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmig006 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=xmig004 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=xmig005  ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=xmig008 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oojdl_t t6 ON t6.oojdlent="||g_enterprise||" AND t6.oojdl001=xmig009 AND t6.oojdl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=xmig018 AND t7.oocal002='"||g_dlang||"' ",
 
               " WHERE xmigent= ? AND xmigsite=? AND xmig001=? AND xmig002=? AND xmig003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xmig_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#   LET g_sql = "SELECT  UNIQUE xmig017,xmig006,'','',xmig007,'','',xmig004,'',xmig005,'',xmig008,'', 
#          xmig009,'',xmig010,xmig018,'',xmig013,'','','','','','','','','','','','','','','','','','','', 
#          '','','','',xmig016,'','','','','','','','','','','','','','','','','','','','','','','','' FROM xmig_t", 
#             
#                  "",
#                  
#                  " WHERE xmigent= ? AND xmigsite=? AND xmig001=? AND xmig002=? AND xmig003=?"            
#                  
#   IF NOT cl_null(g_wc2_table1) THEN
#      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
#   END IF 
#   
   LET g_sql1 = "SELECT  UNIQUE xmig006,'','','','',xmig010, 
          SUM(xmig013),'','','','','','','','','','','','','','','','','','','', 
          '','','','',SUM(xmig016),'','','','','','','','','','','','','','','','','','','','','','','','' FROM xmig_t", 
             
                  "",
                  
                  " WHERE xmigent= ? AND xmigsite=? AND xmig001=? AND xmig002=? AND xmig003=? "
                 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql1 = g_sql1 CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF        
   LET g_sql1 = g_sql1 CLIPPED, " GROUP BY xmig006,xmig010 ", 
                                " ORDER BY xmig006,xmig010"      
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axmt174_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xmig_t.xmig004,xmig_t.xmig005,xmig_t.xmig006,xmig_t.xmig007,xmig_t.xmig008,xmig_t.xmig009,xmig_t.xmig010,xmig_t.xmig017"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET l_xmig004 = NULL
      LET l_xmig005 = NULL 
      LET l_xmig006 = NULL
      LET l_xmig007 = NULL
      LET l_xmig008 = NULL 
      LET l_xmig009 = NULL
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt174_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axmt174_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003 INTO g_xmig_d[l_ac].xmig017, 
          g_xmig_d[l_ac].xmig006,g_xmig_d[l_ac].xmig007,g_xmig_d[l_ac].xmig004,g_xmig_d[l_ac].xmig005, 
          g_xmig_d[l_ac].xmig008,g_xmig_d[l_ac].xmig009,g_xmig_d[l_ac].xmig010,g_xmig_d[l_ac].xmig018, 
          g_xmig_d[l_ac].xmig013,g_xmig_d[l_ac].xmig016,g_xmig_d[l_ac].xmig006_desc,g_xmig_d[l_ac].xmig006_desc_desc, 
          g_xmig_d[l_ac].xmig004_desc,g_xmig_d[l_ac].xmig005_desc,g_xmig_d[l_ac].xmig008_desc,g_xmig_d[l_ac].xmig009_desc, 
          g_xmig_d[l_ac].xmig018_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         IF l_ac = 1 THEN
            LET l_xmig004 = g_xmig_d[l_ac].xmig004
            LET l_xmig005 = g_xmig_d[l_ac].xmig005
            LET l_xmig006 = g_xmig_d[l_ac].xmig006
            LET l_xmig007 = g_xmig_d[l_ac].xmig007
            LET l_xmig008 = g_xmig_d[l_ac].xmig008
            LET l_xmig009 = g_xmig_d[l_ac].xmig009
      
           # LET g_xmig_d[l_ac].l_xmig016_s = g_xmig_d[l_ac].l_xmig016_01  
            LET g_xmig_d[l_ac].l_xmig016_s = g_xmig_d[l_ac].xmig016 
            LET g_xmig_d[l_ac].l_xmig013_01 = g_xmig_d[l_ac].xmig013
            LET g_xmig_d[l_ac].l_xmig016_01 = g_xmig_d[l_ac].xmig016  
            
         END IF
                  
         LET l_xmig010 = g_xmig_d[l_ac].xmig010
         #另起一行
         IF g_xmig_d[l_ac].xmig004 <> l_xmig004 OR g_xmig_d[l_ac].xmig005 <> l_xmig005 OR g_xmig_d[l_ac].xmig006 <> l_xmig006 OR
            g_xmig_d[l_ac].xmig007 <> l_xmig007 OR g_xmig_d[l_ac].xmig008 <> l_xmig008 OR g_xmig_d[l_ac].xmig009 <> l_xmig009 THEN
            LET l_xmig004 = g_xmig_d[l_ac].xmig004
            LET l_xmig005 = g_xmig_d[l_ac].xmig005 
            LET l_xmig006 = g_xmig_d[l_ac].xmig006
            LET l_xmig007 = g_xmig_d[l_ac].xmig007
            LET l_xmig008 = g_xmig_d[l_ac].xmig008 
            LET l_xmig009 = g_xmig_d[l_ac].xmig009
            LET g_xmig_d[l_ac].l_xmig016_s = g_xmig_d[l_ac].xmig016    
            LET g_xmig_d[l_ac].l_xmig013_01 = g_xmig_d[l_ac].xmig013
            LET g_xmig_d[l_ac].l_xmig016_01 = g_xmig_d[l_ac].xmig016              
         ELSE
            IF l_ac > 1 THEN
               LET l_ac = l_ac-1
            END IF   
            IF l_xmig010 > 1 THEN
               CALL axmt174_b_desc(l_xmig010,l_ac)
            END IF   
         END IF   
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         CALL axmt174_xmig006_desc()
         CALL axmt174_xmig008_desc()
         CALL axmt174_xmig009_desc()
         CALL axmt174_xmig018_desc()
         #end add-point
      
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
 
            CALL g_xmig_d.deleteElement(g_xmig_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   LET g_rec_b=l_ac-1
#   LET g_rec_b=l_ac
#   IF l_ac >  1 THEN 
#   INITIALIZE g_xmig_d[l_ac].* TO NULL
#
#   CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xmig_d[l_ac].xmig006
#   SELECT xmia002 INTO l_xmia002 FROM xmia_t
#    WHERE xmiaent = g_enterprise
#      AND xmia001 = g_xmig_m.xmig001
#   FOR i = 1 TO l_xmia002            #依期別做合計
#       CALL axmt174_sum_xmig(i)
#   END FOR
#   SELECT SUM(xmig016) INTO g_xmig_d[l_ac].l_xmig016_s FROM xmig_t     
#    WHERE xmigent = g_enterprise
#      AND xmigsite = g_xmig_m.xmigsite
#      AND xmig001 = g_xmig_m.xmig001
#      AND xmig002 = g_xmig_m.xmig002
#      AND xmig003 = g_xmig_m.xmig003    
#   LET g_xmig2_d[l_ac].l_xmig016_2_s = g_xmig_d[l_ac].l_xmig016_s   
#       
#   DISPLAY g_rec_b TO FORMONLY.cnt  
#   END IF

   
   DISPLAY g_rec_b TO FORMONLY.cnt   
   LET l_ac = g_cnt
   LET g_cnt = 0 
   FREE axmt174_pb  
   
   PREPARE axmt174_pb_01 FROM g_sql1
   DECLARE b_fill_cs_01 CURSOR FOR axmt174_pb_01

   LET l_ac = 1

   OPEN b_fill_cs_01 USING g_enterprise,g_xmig_m.xmigsite
                                       ,g_xmig_m.xmig001

                                       ,g_xmig_m.xmig002

                                       ,g_xmig_m.xmig003   
                                       

   FOREACH b_fill_cs_01 INTO g_xmig2_d[l_ac].l_xmig006_2,g_xmig2_d[l_ac].l_xmig006_2_desc,
          g_xmig2_d[l_ac].l_xmig006_2_desc1,g_xmig2_d[l_ac].l_xmig006_2_desc2,g_xmig2_d[l_ac].l_xmig006_2_desc3,
          g_xmig2_d[l_ac].l_xmig010_2,g_xmig2_d[l_ac].l_xmig013_2_01,g_xmig2_d[l_ac].l_xmig013_2_02,
          g_xmig2_d[l_ac].l_xmig013_2_03,g_xmig2_d[l_ac].l_xmig013_2_04,g_xmig2_d[l_ac].l_xmig013_2_05,g_xmig2_d[l_ac].l_xmig013_2_06,
          g_xmig2_d[l_ac].l_xmig013_2_07,g_xmig2_d[l_ac].l_xmig013_2_08,g_xmig2_d[l_ac].l_xmig013_2_09,g_xmig2_d[l_ac].l_xmig013_2_10,
          g_xmig2_d[l_ac].l_xmig013_2_11,g_xmig2_d[l_ac].l_xmig013_2_12,g_xmig2_d[l_ac].l_xmig013_2_13,g_xmig2_d[l_ac].l_xmig013_2_14,
          g_xmig2_d[l_ac].l_xmig013_2_15,g_xmig2_d[l_ac].l_xmig013_2_16,g_xmig2_d[l_ac].l_xmig013_2_17,g_xmig2_d[l_ac].l_xmig013_2_18,
          g_xmig2_d[l_ac].l_xmig013_2_19,g_xmig2_d[l_ac].l_xmig013_2_20,g_xmig2_d[l_ac].l_xmig013_2_21,g_xmig2_d[l_ac].l_xmig013_2_22,
          g_xmig2_d[l_ac].l_xmig013_2_23,g_xmig2_d[l_ac].l_xmig013_2_24,g_xmig2_d[l_ac].l_xmig016_2_01,g_xmig2_d[l_ac].l_xmig016_2_02,
          g_xmig2_d[l_ac].l_xmig016_2_03,g_xmig2_d[l_ac].l_xmig016_2_04,g_xmig2_d[l_ac].l_xmig016_2_05,g_xmig2_d[l_ac].l_xmig016_2_06,
          g_xmig2_d[l_ac].l_xmig016_2_07,g_xmig2_d[l_ac].l_xmig016_2_08,g_xmig2_d[l_ac].l_xmig016_2_09,g_xmig2_d[l_ac].l_xmig016_2_10,
          g_xmig2_d[l_ac].l_xmig016_2_11,g_xmig2_d[l_ac].l_xmig016_2_12,g_xmig2_d[l_ac].l_xmig016_2_13,g_xmig2_d[l_ac].l_xmig016_2_14,
          g_xmig2_d[l_ac].l_xmig016_2_15,g_xmig2_d[l_ac].l_xmig016_2_16,g_xmig2_d[l_ac].l_xmig016_2_17,g_xmig2_d[l_ac].l_xmig016_2_18,
          g_xmig2_d[l_ac].l_xmig016_2_19,g_xmig2_d[l_ac].l_xmig016_2_20,g_xmig2_d[l_ac].l_xmig016_2_21,g_xmig2_d[l_ac].l_xmig016_2_22,
          g_xmig2_d[l_ac].l_xmig016_2_23,g_xmig2_d[l_ac].l_xmig016_2_24,g_xmig2_d[l_ac].l_xmig016_2_s
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         IF l_ac = 1 THEN
            LET l_xmig006 = g_xmig2_d[l_ac].l_xmig006_2
            LET l_xmig010 = g_xmig2_d[l_ac].l_xmig010_2
      
            LET g_xmig2_d[l_ac].l_xmig016_2_s = g_xmig2_d[l_ac].l_xmig016_2_01  
           
         END IF
                  
         LET l_xmig010 = g_xmig2_d[l_ac].l_xmig010_2
         #另起一行
         IF g_xmig2_d[l_ac].l_xmig006_2 <> l_xmig006 OR g_xmig2_d[l_ac].l_xmig010_2 <> l_xmig010 THEN 
            LET l_xmig006 = g_xmig2_d[l_ac].l_xmig006_2
            LET l_xmig010 = g_xmig2_d[l_ac].l_xmig010_2
            LET g_xmig2_d[l_ac].l_xmig016_2_s = g_xmig2_d[l_ac].l_xmig016_2_01    
         ELSE
            IF l_ac > 1 THEN
               LET l_ac = l_ac-1
            END IF   
            IF l_xmig010 > 1 THEN
               CALL axmt174_b_desc_01(l_xmig010,l_ac)
            END IF   
         END IF   
         CALL axmt174_xmig006_desc_1()
         CALL axmt174_xmig008_desc()
         CALL axmt174_xmig009_desc()
         CALL axmt174_xmig018_desc()
         
         LET l_ac = l_ac + 1
         
         CALL axmt174_xmig006_desc_1()
         
   END FOREACH 
   CALL g_xmig2_d.deleteElement(g_xmig2_d.getLength())
   LET g_rec_b1 = l_ac - 1 
#   INITIALIZE g_xmig2_d[l_ac].* TO NULL
#
#   CALL cl_getmsg('axc-00204',g_lang) RETURNING g_xmig2_d[l_ac].l_xmig006_2
#   LET g_xmig2_d[l_ac].l_xmig016_2_s = g_xmig_d[l_ac].l_xmig016_s
#
#   SELECT xmia002 INTO l_xmia002 FROM xmia_t
#    WHERE xmiaent = g_enterprise
#      AND xmia001 = g_xmig_m.xmig001
#      
#   FOR i = 1 TO l_xmia002            #依期別做合計
#       CALL axmt174_sum_xmig(i)
#   END FOR

   LET l_ac = g_cnt
   LET g_cnt = 0 
   FREE axmt174_pb_01 
   RETURN
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmig_d.getLength()
      LET g_xmig_d_mask_o[l_ac].* =  g_xmig_d[l_ac].*
      CALL axmt174_xmig_t_mask()
      LET g_xmig_d_mask_n[l_ac].* =  g_xmig_d[l_ac].*
   END FOR
   
 
 
   FREE axmt174_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axmt174_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xmig_d.getLength() THEN
         LET g_detail_idx = g_xmig_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xmig_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmig_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmt174_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xmig_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axmt174_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xmig_t
    WHERE xmigent = g_enterprise AND xmigsite = g_xmig_m.xmigsite AND
                              xmig001 = g_xmig_m.xmig001 AND
                              xmig002 = g_xmig_m.xmig002 AND
                              xmig003 = g_xmig_m.xmig003 AND
 
          xmig004 = g_xmig_d_t.xmig004
      AND xmig005 = g_xmig_d_t.xmig005
      AND xmig006 = g_xmig_d_t.xmig006
      AND xmig007 = g_xmig_d_t.xmig007
      AND xmig008 = g_xmig_d_t.xmig008
      AND xmig009 = g_xmig_d_t.xmig009
      AND xmig010 = g_xmig_d_t.xmig010
      AND xmig017 = g_xmig_d_t.xmig017
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xmig_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="axmt174.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axmt174_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axmt174_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axmt174_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"
   
   #end add-point 
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
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
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axmt174_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xmig_d[l_ac].xmig004 = g_xmig_d_t.xmig004 
      AND g_xmig_d[l_ac].xmig005 = g_xmig_d_t.xmig005 
      AND g_xmig_d[l_ac].xmig006 = g_xmig_d_t.xmig006 
      AND g_xmig_d[l_ac].xmig007 = g_xmig_d_t.xmig007 
      AND g_xmig_d[l_ac].xmig008 = g_xmig_d_t.xmig008 
      AND g_xmig_d[l_ac].xmig009 = g_xmig_d_t.xmig009 
      AND g_xmig_d[l_ac].xmig010 = g_xmig_d_t.xmig010 
      AND g_xmig_d[l_ac].xmig017 = g_xmig_d_t.xmig017 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axmt174_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axmt174_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL axmt174_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axmt174_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axmt174_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xmigsite,xmig001,xmig002,xmig003",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("xmigsite,xmig001,xmig002,xmig003",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axmt174_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xmigsite,xmig001,xmig002,xmig003",FALSE)
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
 
{<section id="axmt174.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axmt174_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   IF g_flag THEN
      CALL cl_set_comp_entry("l_xmig016_2_01,l_xmig016_2_02,l_xmig016_2_03,l_xmig016_2_04,l_xmig016_2_05,l_xmig016_2_06,l_xmig016_2_07,l_xmig016_2_08",TRUE)
      CALL cl_set_comp_entry("l_xmig016_2_09,l_xmig016_2_10,l_xmig016_2_11,l_xmig016_2_12,l_xmig016_2_13,l_xmig016_2_14,l_xmig016_2_15,l_xmig016_2_16",TRUE)
      CALL cl_set_comp_entry("l_xmig016_2_17,l_xmig016_2_18,l_xmig016_2_19,l_xmig016_2_20,l_xmig016_2_21,l_xmig016_2_22,l_xmig016_2_23,l_xmig016_2_24",TRUE)
   END IF   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axmt174_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   IF NOT g_flag THEN
      CALL cl_set_comp_entry("l_xmig016_2_01,l_xmig016_2_02,l_xmig016_2_03,l_xmig016_2_04,l_xmig016_2_05,l_xmig016_2_06,l_xmig016_2_07,l_xmig016_2_08",FALSE)
      CALL cl_set_comp_entry("l_xmig016_2_09,l_xmig016_2_10,l_xmig016_2_11,l_xmig016_2_12,l_xmig016_2_13,l_xmig016_2_14,l_xmig016_2_15,l_xmig016_2_16",FALSE)
      CALL cl_set_comp_entry("l_xmig016_2_17,l_xmig016_2_18,l_xmig016_2_19,l_xmig016_2_20,l_xmig016_2_21,l_xmig016_2_22,l_xmig016_2_23,l_xmig016_2_24",FALSE)
   END IF   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axmt174_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmt174.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axmt174_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmt174.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axmt174_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmt174.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axmt174_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmt174.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmt174_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xmigsite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmig001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xmig002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xmig003 = '", g_argv[04], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmig001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xmig002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xmig003 = '", g_argv[04], "' AND "
   END IF   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
#   IF g_argv[1] = '2' THEN
#      LET g_wc = " xmigsite = '",g_site,"'"
#   END IF
#   IF g_argv[1] NOT MATCHES '[12]' THEN
#      LET g_wc = " 1=1"
#   END IF
   IF g_argv[1] = '2' THEN
      LET g_wc = g_wc," xmigsite = '",g_site,"'"
   END IF
   IF g_argv[1] NOT MATCHES '[12]' THEN
      LET g_wc = g_wc, " 1=1"
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axmt174_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmt174.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axmt174_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xmig017"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axmt174.mask_functions" >}
&include "erp/axm/axmt174_mask.4gl"
 
{</section>}
 
{<section id="axmt174.state_change" >}
    
 
{</section>}
 
{<section id="axmt174.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmt174_set_pk_array()
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
   LET g_pk_array[1].values = g_xmig_m.xmigsite
   LET g_pk_array[1].column = 'xmigsite'
   LET g_pk_array[2].values = g_xmig_m.xmig001
   LET g_pk_array[2].column = 'xmig001'
   LET g_pk_array[3].values = g_xmig_m.xmig002
   LET g_pk_array[3].column = 'xmig002'
   LET g_pk_array[4].values = g_xmig_m.xmig003
   LET g_pk_array[4].column = 'xmig003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt174.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axmt174_msgcentre_notify(lc_state)
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
   CALL axmt174_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xmig_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt174.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig006_desc()
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig006_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig006_desc = '', g_rtn_fields[1] , ''
            LET g_xmig_d[l_ac].xmig006_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig006_desc
            DISPLAY BY NAME g_xmig_d[l_ac].xmig006_desc_desc
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=?","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig006_desc2 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig006_desc2 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig006_desc2 
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig006_desc3 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig006_desc3            
END FUNCTION

################################################################################
# Descriptions...: axmt174_xmig008_desc()
# Memo...........:
# Usage..........: CALL axmt174_xmig008_desc()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig008_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig008
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig008_desc
END FUNCTION

################################################################################
# Descriptions...: axmt174_xmig009_desc()
# Memo...........:
# Usage..........: CALL axmt174_xmig009_desc()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig009_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='275' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig009_desc
END FUNCTION

################################################################################
# Descriptions...: axmt174_xmig018_desc()
# Memo...........:
# Usage..........: CALL axmt174_xmig018_desc()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig018_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig018_desc
END FUNCTION

################################################################################
# Descriptions...:數量合計
# Memo...........:
# Usage..........: CALL axmt174_sum_xmig(p_xmig010) 
#                  RETURNING 回传参数
# Input parameter: p_xmig010   期别
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_sum_xmig(p_xmig010)
DEFINE   p_xmig010       LIKE xmig_t.xmig010
DEFINE   l_sql           STRING
DEFINE   l_sum_xmig013       LIKE xmig_t.xmig013
DEFINE   l_sum_xmig016       LIKE xmig_t.xmig016

   LET l_sql = " SELECT SUM(xmig013),SUM(xmig016) FROM xmig_t ",
               "  WHERE xmigent = '",g_enterprise,"'",
               "    AND xmigsite = '",g_xmig_m.xmigsite,"'",
               "    AND xmig001 = '",g_xmig_m.xmig001,"'",
               "    AND xmig002 = '",g_xmig_m.xmig002,"'",
               "    AND xmig003 = '",g_xmig_m.xmig003,"'",
               "    AND xmig010 = ?"
         
   PREPARE axmt174_sum_xmig FROM l_sql   
   EXECUTE axmt174_sum_xmig USING p_xmig010 
                             INTO l_sum_xmig013,l_sum_xmig016    
   IF p_xmig010 = 1 THEN
      LET g_xmig_d[l_ac].l_xmig013_01 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_01 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_01 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_01 = l_sum_xmig016         
   END IF   
   IF p_xmig010 = 2 THEN
      LET g_xmig_d[l_ac].l_xmig013_02 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_02 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_02 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_02 = l_sum_xmig016         
   END IF     
   IF p_xmig010 = 3 THEN
      LET g_xmig_d[l_ac].l_xmig013_03 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_03 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_03 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_03 = l_sum_xmig016     
   END IF     
   IF p_xmig010 = 4 THEN
      LET g_xmig_d[l_ac].l_xmig013_04 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_04 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_04 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_04 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 5 THEN
      LET g_xmig_d[l_ac].l_xmig013_05 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_05 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_05 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_05 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 6 THEN
      LET g_xmig_d[l_ac].l_xmig013_06 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_06 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_06 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_06 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 7 THEN
      LET g_xmig_d[l_ac].l_xmig013_07 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_07 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_07 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_07 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 8 THEN
      LET g_xmig_d[l_ac].l_xmig013_08 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_08 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_08 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_08 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 9 THEN
      LET g_xmig_d[l_ac].l_xmig013_09 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_09 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_09 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_09 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 10 THEN
      LET g_xmig_d[l_ac].l_xmig013_10 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_10 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_10 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_10 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 11 THEN
      LET g_xmig_d[l_ac].l_xmig013_11 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_11 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_11 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_11 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 12 THEN
      LET g_xmig_d[l_ac].l_xmig013_12 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_12 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_12 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_12 = l_sum_xmig016      
   END IF     
   IF p_xmig010 = 13 THEN
      LET g_xmig_d[l_ac].l_xmig013_13 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_13 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_13 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_13 = l_sum_xmig016      
   END IF         
   IF p_xmig010 = 14 THEN
      LET g_xmig_d[l_ac].l_xmig013_14 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_14 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_14 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_14 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 15 THEN
      LET g_xmig_d[l_ac].l_xmig013_15 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_15 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_15 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_15 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 16 THEN
      LET g_xmig_d[l_ac].l_xmig013_16 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_16 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_16 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_16 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 17 THEN
      LET g_xmig_d[l_ac].l_xmig013_17 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_17 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_17 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_17 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 18 THEN
      LET g_xmig_d[l_ac].l_xmig013_18 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_18 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_18 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_18 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 19 THEN
      LET g_xmig_d[l_ac].l_xmig013_19 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_19 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_19 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_19 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 20 THEN
      LET g_xmig_d[l_ac].l_xmig013_20 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_20 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_20 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_20 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 21 THEN
      LET g_xmig_d[l_ac].l_xmig013_21 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_21 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_21 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_21 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 22 THEN
      LET g_xmig_d[l_ac].l_xmig013_22 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_22 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_22 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_22 = l_sum_xmig016
   END IF   
   IF p_xmig010 = 23 THEN
      LET g_xmig_d[l_ac].l_xmig013_23 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_23 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_23 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_23 = l_sum_xmig016      
   END IF   
   IF p_xmig010 = 24 THEN
      LET g_xmig_d[l_ac].l_xmig013_24 = l_sum_xmig013
      LET g_xmig_d[l_ac].l_xmig016_24 = l_sum_xmig016
      LET g_xmig2_d[l_ac].l_xmig013_2_24 = l_sum_xmig013
      LET g_xmig2_d[l_ac].l_xmig016_2_24 = l_sum_xmig016      
   END IF  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmid008_desc()
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmid008_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig008
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig008_desc
END FUNCTION

################################################################################
# Descriptions...: 不同的期別顯示在同一筆單身資料中
# Memo...........:
# Usage..........: CALL axmt174_b_desc(p_xmig010,p_ac)
# Input parameter: p_xmig010  期別
#                : p_ac       資料筆數
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_b_desc(p_xmig010,p_ac)
DEFINE  p_xmig010      LIKE xmig_t.xmig010
DEFINE  p_ac           LIKE type_t.num10  #add by lixh 20150831 =>num10
   IF p_xmig010 = 2 THEN 
      LET g_xmig_d[p_ac].l_xmig013_02 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_02 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_02
   END IF
   IF p_xmig010 = 3 THEN 
      LET g_xmig_d[p_ac].l_xmig013_03 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_03 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_03
   END IF
   IF p_xmig010 = 4 THEN 
      LET g_xmig_d[p_ac].l_xmig013_04 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_04 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_04
   END IF
   IF p_xmig010 = 5 THEN 
      LET g_xmig_d[p_ac].l_xmig013_05 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_05 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_05
   END IF
   IF p_xmig010 = 6 THEN 
      LET g_xmig_d[p_ac].l_xmig013_06 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_06 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_06
   END IF
   IF p_xmig010 = 7 THEN 
      LET g_xmig_d[p_ac].l_xmig013_07 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_07 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_07
   END IF
   IF p_xmig010 = 8 THEN 
      LET g_xmig_d[p_ac].l_xmig013_08 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_08 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_08
   END IF
   IF p_xmig010 = 9 THEN 
      LET g_xmig_d[p_ac].l_xmig013_09 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_09 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_09
   END IF
   IF p_xmig010 = 10 THEN 
      LET g_xmig_d[p_ac].l_xmig013_10 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_10 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_10
   END IF  
   IF p_xmig010 = 11 THEN 
      LET g_xmig_d[p_ac].l_xmig013_11 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_11 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_11
   END IF  
   IF p_xmig010 = 12 THEN 
      LET g_xmig_d[p_ac].l_xmig013_12 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_12 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_12
   END IF  
   IF p_xmig010 = 13 THEN 
      LET g_xmig_d[p_ac].l_xmig013_13 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_13 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_13
   END IF  
   IF p_xmig010 = 14 THEN 
      LET g_xmig_d[p_ac].l_xmig013_14 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_14 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_14
   END IF  
   IF p_xmig010 = 15 THEN 
      LET g_xmig_d[p_ac].l_xmig013_15 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_15 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_15
   END IF  
   IF p_xmig010 = 16 THEN 
      LET g_xmig_d[p_ac].l_xmig013_16 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_16 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_16
   END IF  
   IF p_xmig010 = 17 THEN 
      LET g_xmig_d[p_ac].l_xmig013_17 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_17 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_17
   END IF  
   IF p_xmig010 = 18 THEN 
      LET g_xmig_d[p_ac].l_xmig013_18 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_18 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_18
   END IF  
   IF p_xmig010 = 19 THEN 
      LET g_xmig_d[p_ac].l_xmig013_19 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_19 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_19
   END IF  
   IF p_xmig010 = 20 THEN 
      LET g_xmig_d[p_ac].l_xmig013_20 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_20 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_20
   END IF  
   IF p_xmig010 = 21 THEN 
      LET g_xmig_d[p_ac].l_xmig013_21 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_21 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_21
   END IF   
   IF p_xmig010 = 22 THEN 
      LET g_xmig_d[p_ac].l_xmig013_22 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_22 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_22
   END IF   
   IF p_xmig010 = 23 THEN 
      LET g_xmig_d[p_ac].l_xmig013_23 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_23 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_23
   END IF   
   IF p_xmig010 = 24 THEN 
      LET g_xmig_d[p_ac].l_xmig013_24 = g_xmig_d[p_ac+1].xmig013
      LET g_xmig_d[p_ac].l_xmig016_24 = g_xmig_d[p_ac+1].xmig016
      LET g_xmig_d[p_ac].l_xmig016_s = g_xmig_d[p_ac].l_xmig016_s + g_xmig_d[p_ac].l_xmig016_24
   END IF      
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig_hide()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig_hide()
DEFINE lc_index        LIKE type_t.chr2
DEFINE li_i            LIKE type_t.num5
DEFINE li_j            LIKE type_t.num5
DEFINE l_xmia002       LIKE xmia_t.xmia002
DEFINE ls_show         STRING
DEFINE ls_hide         STRING
DEFINE l_field         STRING
DEFINE l_msg           STRING
   LET l_field = ' '
   LET ls_hide = ' '
   LET ls_show = ' '   
   SELECT xmia002 INTO l_xmia002 FROM xmia_t
    WHERE xmiaent = g_enterprise
      AND xmia001 = g_xmig_m.xmig001
   FOR li_i = 1 TO l_xmia002    #欄位的顯示  
      LET l_msg = ''
      LET l_msg = g_xmib[li_i].b_date,'~',g_xmib[li_i].e_date   
      LET lc_index = li_i USING '&&'   
      IF li_i = 1 THEN      
         LET ls_show = ls_show || "l_xmig013_" || lc_index || ",l_xmig013_2_" || lc_index || ",l_xmig016_" || lc_index || ",l_xmig016_2_" || lc_index                   
      ELSE
         LET ls_show = ls_show || ",l_xmig013_" || lc_index || ",l_xmig013_2_" || lc_index || ",l_xmig016_" || lc_index || ",l_xmig016_2_" || lc_index                             
      END IF  
#      LET l_field = ''
#      LET l_field = 'l_xmig013_' CLIPPED,lc_index CLIPPED    
#      LET l_field = l_field.trim()
#      CALL cl_set_comp_att_text(l_field,l_msg)  
#      LET l_field = ''
#      LET l_field = 'l_xmig013_2_' CLIPPED,lc_index CLIPPED    
#      LET l_field = l_field.trim()
#      CALL cl_set_comp_att_text(l_field,l_msg) 
#      LET l_field = ''
#      LET l_field = 'l_xmig016_' CLIPPED,lc_index CLIPPED    
#      LET l_field = l_field.trim()
#      CALL cl_set_comp_att_text(l_field,l_msg) 
#      LET l_field = ''
#      LET l_field = 'l_xmig016_2_' CLIPPED,lc_index CLIPPED    
#      LET l_field = l_field.trim()
#      CALL cl_set_comp_att_text(l_field,l_msg)        
   END FOR
   CALL cl_set_comp_visible(ls_show,TRUE) 
   
   LET ls_hide = ' '    
   FOR li_j = li_i TO 24    #欄位的隱藏  
      LET lc_index = li_j USING '&&'   
      IF li_j = li_i THEN
         LET  ls_hide = ls_hide || "l_xmig013_" || lc_index || ",l_xmig013_2_" || lc_index || ",l_xmig016_" || lc_index || ",l_xmig016_2_" || lc_index 
      ELSE
         LET  ls_hide = ls_hide || ",l_xmig013_" || lc_index || ",l_xmig013_2_" || lc_index || ",l_xmig016_" || lc_index || ",l_xmig016_2_" || lc_index 
      END IF
   END FOR
   CALL cl_set_comp_visible(ls_hide,FALSE)    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig006_desc_2(p_ac)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig006_desc_2(p_ac)
DEFINE   p_ac     LIKE type_t.num10    #add by lixh 20150831 =>num10
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig3_d[p_ac].xmig006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig3_d[p_ac].xmig006_desc = '', g_rtn_fields[1] , ''
            LET g_xmig3_d[p_ac].xmig006_desc1 = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_xmig3_d[p_ac].xmig006_desc
            DISPLAY BY NAME g_xmig3_d[p_ac].xmig006_desc1
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig3_d[p_ac].xmig006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=?","") RETURNING g_rtn_fields
            LET g_xmig3_d[p_ac].xmig006_desc2 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig3_d[p_ac].xmig006_desc2

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig3_d[p_ac].xmig006_desc2
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig3_d[p_ac].xmig006_desc3 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig3_d[p_ac].xmig006_desc3
END FUNCTION

################################################################################
# Descriptions...: 不同的期別顯示在同一筆單身資料中
# Memo...........:
# Usage..........: CALL axmt174_b_desc_01(p_xmig010,p_ac)
# Input parameter: p_xmig010  期別
#                : p_ac       資料筆數
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_b_desc_01(p_xmig010,p_ac)
DEFINE  p_xmig010      LIKE xmig_t.xmig010
DEFINE   p_ac     LIKE type_t.num10    #add by lixh 20150831 =>num10
   IF p_xmig010 = 2 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_02 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_02 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_02
   END IF
   IF p_xmig010 = 3 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_03 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_03 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_03
   END IF
   IF p_xmig010 = 4 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_04 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_04 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_04
   END IF
   IF p_xmig010 = 5 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_05 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_05 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_05
   END IF
   IF p_xmig010 = 6 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_06 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_06 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_06
   END IF
   IF p_xmig010 = 7 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_07 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_07 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_07
   END IF
   IF p_xmig010 = 8 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_08 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_08 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_08
   END IF
   IF p_xmig010 = 9 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_09 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_09 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_09
   END IF
   IF p_xmig010 = 10 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_10 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_10 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_10
   END IF  
   IF p_xmig010 = 11 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_11 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_11 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_11
   END IF  
   IF p_xmig010 = 12 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_12 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_12 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_12
   END IF  
   IF p_xmig010 = 13 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_13 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_13 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_13
   END IF  
   IF p_xmig010 = 14 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_14 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_14 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_14
   END IF  
   IF p_xmig010 = 15 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_15 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_15 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_15
   END IF  
   IF p_xmig010 = 16 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_16 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_16 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_16
   END IF  
   IF p_xmig010 = 17 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_17 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_17 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_17
   END IF  
   IF p_xmig010 = 18 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_18 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_18 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_18
   END IF  
   IF p_xmig010 = 19 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_19 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_19 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_19
   END IF  
   IF p_xmig010 = 20 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_20 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_20 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_20
   END IF  
   IF p_xmig010 = 21 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_21 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_21 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_21
   END IF   
   IF p_xmig010 = 22 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_22 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_22 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_22
   END IF   
   IF p_xmig010 = 23 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_23 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_23 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_23
   END IF   
   IF p_xmig010 = 24 THEN 
      LET g_xmig2_d[p_ac].l_xmig013_2_24 = g_xmig2_d[p_ac+1].l_xmig013_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_24 = g_xmig2_d[p_ac+1].l_xmig016_2_01
      LET g_xmig2_d[p_ac].l_xmig016_2_s = g_xmig2_d[p_ac].l_xmig016_2_s + g_xmig2_d[p_ac].l_xmig016_2_24
   END IF    
END FUNCTION

################################################################################
# Descriptions...: 生管數量調整
# Memo...........:
# Usage..........: CALL axmt174_adjust()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_adjust()
#   LET g_forupd_sql2 = "SELECT xmig006,'','','',
#       '','','','','','','','','','','','','','','','','','','','','','','','', 
#       '','','','','','','','','','','','','','','','','','','','','','','','','' FROM xmig_t  
#       WHERE xmigent=? AND xmigsite=? AND xmig001=? AND xmig002=? AND xmig003=?
#         AND xmig006=? FOR UPDATE"
#   LET g_forupd_sql2 = cl_sql_forupd(g_forupd_sql2)
#   DECLARE axmt174_bcl2 CURSOR FROM g_forupd_sql2  
#
#   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)      
#   INPUT ARRAY g_xmig2_d FROM s_detail2.*
#          ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
#                  INSERT ROW = FALSE,
#                  DELETE ROW = FALSE,
#                  APPEND ROW = FALSE)
#
#         BEFORE INPUT
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
#              CALL FGL_SET_ARR_CURR(g_xmig2_d.getLength()+1)
#              LET g_insert = 'N'
#           END IF
#
#            CALL axmt174_b_fill(g_wc2)
#            IF g_rec_b != 0 THEN
#               CALL fgl_set_arr_curr(l_ac)
#            END IF
#
#         BEFORE ROW
#            LET l_insert = FALSE
#            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
#            LET l_ac = ARR_CURR()
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            DISPLAY l_ac TO FORMONLY.idx
#
#
#            CALL s_transaction_begin()
#
#            #判定新增或修改
#            IF l_cmd = 'u' THEN
#               OPEN axmt174_cl USING g_enterprise,
#                                               g_xmig_m.xmigsite
#                                               ,g_xmig_m.xmig001
#
#                                               ,g_xmig_m.xmig002
#
#                                               ,g_xmig_m.xmig003
#
#
#
#               IF STATUS THEN
#                  CALL cl_err("OPEN axmt174_cl:", STATUS, 1)
#                  CLOSE axmt174_cl
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               END IF
#            END IF
#
#            LET l_cmd = ''
#
#            IF g_rec_b1 >= l_ac AND g_xmig_d[l_ac].xmig006 IS NOT NULL THEN
#               LET l_cmd='u'
#               LET g_xmig2_d_t.* = g_xmig2_d[l_ac].*  #BACKUP
#               CALL axmt174_set_entry_b(l_cmd)
#               CALL axmt174_set_no_entry_b(l_cmd)
#               OPEN axmt174_bcl2 USING g_enterprise,g_xmig_m.xmigsite,
#                                                g_xmig_m.xmig001,
#
#                                                g_xmig_m.xmig002,
#
#                                                g_xmig_m.xmig003,
#
#                                                g_xmig_d_t.xmig006
#
#               IF STATUS THEN
#                  CALL cl_err("OPEN axmt174_bcl2:", STATUS, 1)
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH axmt174_bcl2 INTO g_xmig2_d[l_ac].l_xmig006_2,g_xmig2_d[l_ac].l_xmig006_2_desc,
#                      g_xmig2_d[l_ac].l_xmig006_2_desc1,g_xmig2_d[l_ac].l_xmig006_2_desc2,
#                      g_xmig2_d[l_ac].l_xmig013_2_01,
#                      g_xmig2_d[l_ac].l_xmig013_2_02,g_xmig2_d[l_ac].l_xmig013_2_03,g_xmig2_d[l_ac].l_xmig013_2_04,
#                      g_xmig2_d[l_ac].l_xmig013_2_05,g_xmig2_d[l_ac].l_xmig013_2_06,g_xmig2_d[l_ac].l_xmig013_2_07,
#                      g_xmig2_d[l_ac].l_xmig013_2_08,g_xmig2_d[l_ac].l_xmig013_2_09,g_xmig2_d[l_ac].l_xmig013_2_10,
#                      g_xmig2_d[l_ac].l_xmig013_2_11,g_xmig2_d[l_ac].l_xmig013_2_12,g_xmig2_d[l_ac].l_xmig013_2_13,
#                      g_xmig2_d[l_ac].l_xmig013_2_14,g_xmig2_d[l_ac].l_xmig013_2_15,g_xmig2_d[l_ac].l_xmig013_2_16,
#                      g_xmig2_d[l_ac].l_xmig013_2_17,g_xmig2_d[l_ac].l_xmig013_2_18,g_xmig2_d[l_ac].l_xmig013_2_19,
#                      g_xmig2_d[l_ac].l_xmig013_2_20,g_xmig2_d[l_ac].l_xmig013_2_21,g_xmig2_d[l_ac].l_xmig013_2_22,
#                      g_xmig2_d[l_ac].l_xmig013_2_23,g_xmig2_d[l_ac].l_xmig013_2_24,g_xmig2_d[l_ac].l_xmig016_2_01,
#                      g_xmig2_d[l_ac].l_xmig016_2_02,g_xmig2_d[l_ac].l_xmig016_2_03,g_xmig2_d[l_ac].l_xmig016_2_04,
#                      g_xmig2_d[l_ac].l_xmig016_2_05,g_xmig2_d[l_ac].l_xmig016_2_06,g_xmig2_d[l_ac].l_xmig016_2_07,
#                      g_xmig2_d[l_ac].l_xmig016_2_08,g_xmig2_d[l_ac].l_xmig016_2_09,g_xmig2_d[l_ac].l_xmig016_2_10,
#                      g_xmig2_d[l_ac].l_xmig016_2_11,g_xmig2_d[l_ac].l_xmig016_2_12,g_xmig2_d[l_ac].l_xmig016_2_13,
#                      g_xmig2_d[l_ac].l_xmig016_2_14,g_xmig2_d[l_ac].l_xmig016_2_15,g_xmig2_d[l_ac].l_xmig016_2_16,
#                      g_xmig2_d[l_ac].l_xmig016_2_17,g_xmig2_d[l_ac].l_xmig016_2_18,g_xmig2_d[l_ac].l_xmig016_2_19,
#                      g_xmig2_d[l_ac].l_xmig016_2_20,g_xmig2_d[l_ac].l_xmig016_2_21,g_xmig2_d[l_ac].l_xmig016_2_22,
#                      g_xmig2_d[l_ac].l_xmig016_2_23,g_xmig2_d[l_ac].l_xmig016_2_24,g_xmig2_d[l_ac].l_xmig016_2_s
#
#                  IF SQLCA.sqlcode THEN
#                      CALL cl_err(g_xmig2_d_t.l_xmig006_2,SQLCA.sqlcode,1)
#                      LET l_lock_sw = "Y"
#                  END IF
#
#                  CALL axmt174_ref_show()
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#
#         BEFORE INSERT
#
#         AFTER INSERT
#
#         BEFORE DELETE
#
#         AFTER FIELD l_xmig016_2_01
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_01) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_01 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_02
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_02) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_02 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_03
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_03) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_03 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_04
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_04) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_04 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_05
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_05) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_05 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_06
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_06) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_06 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_07
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_07) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_07 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_08
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_08) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_08 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_09
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_09) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_09 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_10
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_10) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_10 = 0
#            END IF
#         AFTER FIELD l_xmig016_2_11
#            IF cl_null(g_xmig2_d[l_ac].l_xmig016_2_11) THEN
#               LET g_xmig2_d[l_ac].l_xmig016_2_11 = 0
#            END IF
#
#      END INPUT
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_get_xmig(p_wc,p_flag)
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_get_xmig(p_wc,p_flag)
DEFINE   l_sql        STRING
DEFINE   p_wc         STRING
DEFINE   l_ac         LIKE type_t.num10   #add by lixh 20150831 =>num10
DEFINE   l_num        LIKE type_t.num20
DEFINE   l_num_s      LIKE xmig_t.xmig016
DEFINE   l_rate       LIKE type_t.num5
DEFINE   p_flag       LIKE type_t.chr1

   CALL g_xmig3_d.clear()
   IF cl_null(p_wc) THEN LET p_wc = "1 = 1"  END IF
   LET l_sql = "SELECT xmig004,'',xmig005,'',xmig008,'',xmig009,'',xmig006,'','',xmig007,'','',xmig010,xmig013,xmig016,'',xmig017 FROM xmig_t ",
               " WHERE xmigent = '",g_enterprise,"'",
               "   AND xmigsite = '",g_xmig_m.xmigsite,"'",
               "   AND xmig001 = '",g_xmig_m.xmig001,"'",
               "   AND xmig002 = '",g_xmig_m.xmig002,"'",
               "   AND xmig003 = '",g_xmig_m.xmig003,"'",
               "   AND ",p_wc CLIPPED
   IF NOT cl_null(g_wc2_table1) THEN
      LET l_sql = l_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF                
   LET l_sql = l_sql, " ORDER BY xmigsite,xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,xmig008,xmig009,xmig010,xmig017"
   PREPARE axmt174_get_xmig_pre FROM l_sql
   DECLARE axmt174_get_xmig_cur CURSOR FOR axmt174_get_xmig_pre  
   LET l_ac = 1    
   FOREACH axmt174_get_xmig_cur INTO 
           g_xmig3_d[l_ac].xmig004,g_xmig3_d[l_ac].xmig004_desc,g_xmig3_d[l_ac].xmig005,g_xmig3_d[l_ac].xmig005_desc,
           g_xmig3_d[l_ac].xmig008,g_xmig3_d[l_ac].xmig008_desc,g_xmig3_d[l_ac].xmig009,g_xmig3_d[l_ac].xmig009_desc,
           g_xmig3_d[l_ac].xmig006,g_xmig3_d[l_ac].xmig006_desc,g_xmig3_d[l_ac].xmig006_desc1,g_xmig3_d[l_ac].xmig007,
           g_xmig3_d[l_ac].xmig006_desc2,g_xmig3_d[l_ac].xmig006_desc3,g_xmig3_d[l_ac].xmig010,g_xmig3_d[l_ac].xmig013,g_xmig3_d[l_ac].xmig016,
           g_xmig3_d[l_ac].l_xmig016_s,g_xmig3_d[l_ac].xmig017           
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF     
         IF NOT cl_null(g_rate) AND g_rate > 0 THEN 
            LET g_xmig3_d[l_ac].xmig016 = g_xmig3_d[l_ac].xmig013 * (1+g_rate/100)
         ELSE
            LET l_rate = g_rate*(-1)
            LET g_xmig3_d[l_ac].xmig016 = g_xmig3_d[l_ac].xmig013 * (1-l_rate/100)         
         END IF 
         LET l_num_s = g_xmig3_d[l_ac].xmig016/g_number
         CALL s_num_round(3,l_num_s,'') RETURNING l_num         
         IF l_num_s <> l_num THEN
            LET g_xmig3_d[l_ac].xmig016 = g_number * (l_num+1)
         END IF   
         LET g_xmig3_d[l_ac].l_xmig016_s = g_xmig3_d[l_ac].xmig016 - g_xmig3_d[l_ac].xmig013
         CALL axmt174_xmig004_desc_2(l_ac)  
         CALL axmt174_xmig005_desc_2(l_ac)
         CALL axmt174_xmig006_desc_2(l_ac)
         CALL axmt174_xmig008_desc_2(l_ac)
         CALL axmt174_xmig009_desc_2(l_ac)
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF  
                  
   END FOREACH 
   LET g_rec_b2 = l_ac-1
   IF g_rec_b2 = 0 AND p_flag = 'Y' THEN
      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'axm-00276'     #160318-00005#49  mark
      LET g_errparam.code = 'sub-01321'      #160318-00005#49  add
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   CALL g_xmig3_d.deleteElement(g_xmig3_d.getLength())
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 整批調整生管確認數量
# Memo...........:
# Usage..........: CALL axmt174_adjust_batch()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_adjust_batch()
   DEFINE   l_wc              STRING
#   DEFINE   l_wc_t            STRING   
   DEFINE   l_lock_sw         LIKE type_t.chr1 
   DEFINE   r_success         LIKE type_t.chr1
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt174_s01 WITH FORM cl_ap_formpath("axm","axmt174_s01")
   CALL g_xmig3_d.clear()
   LET l_wc = ''
   LET g_rate = NULL
   LET g_number = NULL
   INITIALIZE g_xmig3_d_t.* TO NULL
   LET g_errshow = 1
   LET g_forupd_sql = "SELECT xmig004,'',xmig005,'',xmig008,'',xmig009, 
       '',xmig006,'','',xmig007,'','',xmig010,xmig013,xmig016,'',xmig017 FROM xmig_t WHERE  
       xmigent=? AND xmigsite=? AND xmig001=? AND xmig002=? AND xmig003=? AND xmig004=? AND xmig005=?  
       AND xmig006=? AND xmig007=? AND xmig008=? AND xmig009=? AND xmig010=? AND xmig017=? FOR UPDATE"    
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE axmt174_bcl3 CURSOR FROM g_forupd_sql    
   LET g_errshow = 1   
   LET r_success = 'Y'
   CALL s_transaction_begin()
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME l_wc ON xmig004,xmig005,xmig008,xmig009,xmig006
      
         ON ACTION controlp INFIELD xmig004

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig004  #顯示到畫面上
            NEXT FIELD xmig004   
            
         ON ACTION controlp INFIELD xmig005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig005  #顯示到畫面上
            NEXT FIELD xmig005   
                        
         ON ACTION controlp INFIELD xmig008            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig008  #顯示到畫面上
            NEXT FIELD xmig008                     #返回原欄位    

         ON ACTION controlp INFIELD xmig009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160621-00003#6 160629 by lori mark and add---(S)
            #CALL q_xmig009()                          
            
            LET g_qryparam.arg1 = '1'
            CALL q_oojd001()
            #160621-00003#6 160629 by lori mark and add---(E)
            DISPLAY g_qryparam.return1 TO xmig009  #顯示到畫面上
            NEXT FIELD xmig009 
 
         ON ACTION controlp INFIELD xmig006 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmig006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmig006  #顯示到畫面上
            NEXT FIELD xmig006   
            
         AFTER CONSTRUCT
#            IF NOT cl_null(g_rate) AND NOT cl_null(g_number) THEN
               IF NOT axmt174_get_xmig(l_wc,'Y') THEN
                  NEXT FIELD xmig004
               END IF            
#            END IF
      END CONSTRUCT  

      INPUT g_rate,g_number FROM rate,number                  
         ATTRIBUTE(WITHOUT DEFAULTS)  
         BEFORE INPUT
            LET g_number = 1
            DISPLAY g_number TO number
         
         AFTER FIELD rate

         AFTER FIELD number
          
         AFTER INPUT
            IF NOT axmt174_get_xmig(l_wc,'Y') THEN
               NEXT FIELD xmig004
            END IF
      END INPUT
      
      INPUT ARRAY g_xmig3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE) 
                  
         BEFORE INPUT   
            IF cl_null(g_rate) OR cl_null(g_number) THEN
               NEXT FIELD rate
            END IF
            IF NOT axmt174_get_xmig(l_wc,'N') THEN
               NEXT FIELD xmig004
            END IF               

                        
            
         BEFORE ROW
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_ac = ARR_CURR()
#            CALL s_transaction_begin()
            OPEN axmt174_bcl3 USING g_enterprise,g_xmig_m.xmigsite,g_xmig_m.xmig001,g_xmig_m.xmig002,g_xmig_m.xmig003,
                                    g_xmig3_d[l_ac].xmig004,g_xmig3_d[l_ac].xmig005,g_xmig3_d[l_ac].xmig006,g_xmig3_d[l_ac].xmig007,
                                    g_xmig3_d[l_ac].xmig008,g_xmig3_d[l_ac].xmig009,g_xmig3_d[l_ac].xmig010,g_xmig3_d[l_ac].xmig017
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN axmt174_bcl3:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE axmt174_bcl3
               LET l_lock_sw='Y'
               LET r_success = 'N'
#               CALL s_transaction_end('N','0')
               RETURN
            END IF                
            LET g_xmig3_d_t.* = g_xmig3_d[l_ac].* 
            
          AFTER FIELD xmig016
             IF NOT cl_null(g_xmig3_d[l_ac].xmig016) THEN
                LET g_xmig3_d[l_ac].l_xmig016_s = g_xmig3_d[l_ac].xmig016 - g_xmig3_d[l_ac].xmig013
                DISPLAY BY NAME g_xmig3_d[l_ac].l_xmig016_s
             END IF      
             
          ON ROW CHANGE     
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xmig3_d[l_ac].* = g_xmig3_d_t.*
               CLOSE axmt174_bcl3
               LET r_success = 'N'
#               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xmig3_d[l_ac].xmig006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xmig3_d[l_ac].* = g_xmig3_d_t.*
            ELSE
               UPDATE xmig_t SET xmig016 = g_xmig3_d[l_ac].xmig016
                WHERE xmigent = g_enterprise
                  AND xmig001 = g_xmig_m.xmig001
                  AND xmig002 = g_xmig_m.xmig002
                  AND xmig003 = g_xmig_m.xmig003
                  AND xmig004 = g_xmig3_d[l_ac].xmig004
                  AND xmig005 = g_xmig3_d[l_ac].xmig005
                  AND xmig006 = g_xmig3_d[l_ac].xmig006
                  AND xmig007 = g_xmig3_d[l_ac].xmig007
                  AND xmig008 = g_xmig3_d[l_ac].xmig008
                  AND xmig009 = g_xmig3_d[l_ac].xmig009
                  AND xmig010 = g_xmig3_d[l_ac].xmig010
                  AND xmig017 = g_xmig3_d[l_ac].xmig017                  
                             
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xmig_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET r_success = 'N'
#                     CALL s_transaction_end('N','1')
                     LET g_xmig3_d[l_ac].* = g_xmig3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xmig_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xmig3_d[l_ac].* = g_xmig3_d_t.*  
                     LET r_success = 'N'                     
#                     CALL s_transaction_end('N','1')   
                  OTHERWISE 
#                     CALL s_transaction_end('Y','0') 
               END CASE                      
            END IF
      END INPUT
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
      BEFORE DIALOG
         CALL cl_qbe_init()            
   END DIALOG 
      
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')      
   ELSE
      #更新数据 
      IF r_success = 'Y' THEN
         IF NOT axmt174_adjust_batch_upd() THEN 
            CALL s_transaction_end('N','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00231'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
           
         ELSE
            CALL s_transaction_end('Y','0')
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00230'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
   
         END IF         
      ELSE
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ain-00231'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
               
      END IF      
   END IF      
     
   #畫面關閉
   CLOSE WINDOW w_axmt174_s01   
END FUNCTION

################################################################################
# Descriptions...: 取得計算期間
# Memo...........:
# Usage..........: CALL axmt174_desc_date()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_desc_date()
DEFINE   l_yy       LIKE type_t.num5
DEFINE   l_mm       LIKE type_t.num5
DEFINE   l_dd       LIKE type_t.num5
DEFINE   l_dd_1     LIKE type_t.num5
DEFINE   l_ac       LIKE type_t.num5
DEFINE   l_sql      STRING
DEFINE   l_e_date   LIKE type_t.chr80

   IF cl_null(g_xmig_m.xmig001) OR cl_null(g_xmig_m.xmig002) THEN
      RETURN
   END IF
   LET l_sql = " SELECT xmib002,xmib003 FROM xmib_t",
               "  WHERE xmibent = '",g_enterprise,"'",
               "    AND xmib001 = '",g_xmig_m.xmig001,"'"
   PREPARE axmt174_xmib002 FROM l_sql
   DECLARE axmt174_xmib002_cur CURSOR FOR axmt174_xmib002
   CALL g_xmib.clear()
   LET l_ac = 1
   LET g_xmib[l_ac].b_date = g_xmig_m.xmig002
   FOREACH axmt174_xmib002_cur INTO g_xmib[l_ac].xmib002,g_xmib[l_ac].xmib003
      IF g_xmib[l_ac].xmib002 = 1 THEN
         LET g_xmib[l_ac].b_date = g_xmig_m.xmig002
         LET l_yy = YEAR(g_xmib[l_ac].b_date)
         LET l_mm = MONTH(g_xmib[l_ac].b_date)
         LET l_dd = DAY(g_xmib[l_ac].b_date) 
         IF g_xmib[l_ac].xmib003 = '1' THEN   #周
            IF l_dd = 1 THEN
               LET g_xmib[l_ac].e_date = g_xmib[l_ac].b_date + 6
            END IF
            IF l_dd = 8 OR l_dd = 16 THEN
               LET g_xmib[l_ac].e_date = g_xmib[l_ac].b_date + 7
            END IF
            IF l_dd = 24 THEN
               CALL s_date_get_last_date(g_xmib[l_ac].b_date) RETURNING g_xmib[l_ac].e_date
            END IF 
         END IF
         IF g_xmib[l_ac].xmib003 = '2' THEN   #旬
            IF l_dd = 1 THEN
               LET g_xmib[l_ac].e_date = MDY(l_mm,10,l_yy)
            END IF
            IF l_dd = 11 THEN
               LET g_xmib[l_ac].e_date = MDY(l_mm,20,l_yy)
            END IF
            IF l_dd = 21 THEN
               CALL s_date_get_last_date(g_xmib[l_ac].b_date) RETURNING g_xmib[l_ac].e_date
            END IF
         END IF
         IF g_xmib[l_ac].xmib003 = '3' THEN   #月
            IF l_dd = 1 THEN
               CALL s_date_get_last_date(g_xmib[l_ac].b_date) RETURNING g_xmib[l_ac].e_date
            ELSE 
               IF l_mm = 12 THEN
                  LET l_yy = l_yy +1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1
               END IF               
               LET g_xmib[l_ac].e_date = MDY(l_mm,l_dd-1,l_yy)
            END IF                      
         END IF
      ELSE
         IF l_ac = 1 THEN CONTINUE FOREACH END IF   #add by lixh 20150831
         LET l_yy = YEAR(g_xmib[l_ac-1].e_date)
         LET l_mm = MONTH(g_xmib[l_ac-1].e_date)
         LET l_dd = DAY(g_xmib[l_ac-1].e_date)
         IF g_xmib[l_ac].xmib003 = '1' THEN   #周 
            IF l_dd > 23 THEN
               IF l_mm = 12 THEN
                  LET l_yy = l_yy + 1
                  LET l_mm = 1
               ELSE    
                  LET l_mm = l_mm + 1
               END IF                    
               LET g_xmib[l_ac].b_date = MDY(l_mm,1,l_yy)
               LET g_xmib[l_ac].e_date = MDY(l_mm,7,l_yy)
            END IF 
            IF l_dd = 7 THEN
               LET g_xmib[l_ac].b_date = MDY(l_mm,8,l_yy)
               LET g_xmib[l_ac].e_date = MDY(l_mm,15,l_yy)
            END IF
            IF l_dd = 15 THEN
               LET g_xmib[l_ac].b_date = MDY(l_mm,16,l_yy)
               LET g_xmib[l_ac].e_date = MDY(l_mm,23,l_yy)
            END IF
            IF l_dd = 23 THEN
               LET g_xmib[l_ac].b_date = MDY(l_mm,24,l_yy)
               CALL s_date_get_last_date(g_xmib[l_ac].b_date) RETURNING g_xmib[l_ac].e_date
            END IF
         END IF
         IF g_xmib[l_ac].xmib003 = '2' THEN   #旬
            IF l_dd > 20 THEN
               IF l_mm = 12 THEN
                  LET l_yy = l_yy + 1
                  LET l_mm = 1
               ELSE
                 LET l_mm = l_mm + 1                
               END IF
               LET g_xmib[l_ac].b_date = MDY(l_mm,1,l_yy)
               LET g_xmib[l_ac].e_date = MDY(l_mm,10,l_yy)
            END IF
            IF l_dd = 10 THEN
               LET g_xmib[l_ac].b_date = MDY(l_mm,11,l_yy)
               LET g_xmib[l_ac].e_date = MDY(l_mm,20,l_yy)
            END IF
            IF l_dd = 20 THEN
               LET g_xmib[l_ac].b_date = MDY(l_mm,21,l_yy)
               CALL s_date_get_last_date(g_xmib[l_ac].b_date) RETURNING g_xmib[l_ac].e_date
            END IF
         END IF

         IF g_xmib[l_ac].xmib003 = '3' THEN   #月
            CALL s_date_get_last_date(g_xmib[l_ac-1].e_date) RETURNING l_e_date
            IF g_xmib[l_ac-1].e_date = l_e_date THEN   #最後一天
               LET l_dd = 1 
            END IF   
            IF l_dd = 1 THEN
               IF l_mm = 12 THEN
                  LET l_yy = l_yy + 1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1             
               END IF
               LET g_xmib[l_ac].b_date = MDY(l_mm,1,l_yy)
               CALL s_date_get_last_date(g_xmib[l_ac].b_date) RETURNING g_xmib[l_ac].e_date
            ELSE
               LET g_xmib[l_ac].b_date = MDY(l_mm,l_dd+1,l_yy)
               IF l_mm = 12 THEN
                  LET l_yy = l_yy + 1
                  LET l_mm = 1
               ELSE
                  LET l_mm = l_mm + 1                  
               END IF
               LET g_xmib[l_ac].e_date = MDY(l_mm,l_dd,l_yy)
            END IF
         END IF               
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_xmib.deleteElement(g_xmib.getLength())  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_adjust_batch_upd()
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_adjust_batch_upd()
DEFINE  l_ac         LIKE type_t.num10   #add by lixh 20150831 =>num10
DEFINE  r_success    LIKE type_t.chr1
   LET r_success = 'Y' 
#   CALL s_transaction_begin()
   FOR l_ac = 1 TO g_xmig3_d.getLength()  
         UPDATE xmig_t SET xmig016 = g_xmig3_d[l_ac].xmig016
          WHERE xmigent = g_enterprise
            AND xmigsite = g_xmig_m.xmigsite
            AND xmig001 = g_xmig_m.xmig001
            AND xmig002 = g_xmig_m.xmig002
            AND xmig003 = g_xmig_m.xmig003
            AND xmig004 = g_xmig3_d[l_ac].xmig004
            AND xmig005 = g_xmig3_d[l_ac].xmig005   
            AND xmig006 = g_xmig3_d[l_ac].xmig006  
            AND xmig007 = g_xmig3_d[l_ac].xmig007  
            AND xmig008 = g_xmig3_d[l_ac].xmig008  
            AND xmig009 = g_xmig3_d[l_ac].xmig009  
            AND xmig010 = g_xmig3_d[l_ac].xmig010  
            AND xmig017 = g_xmig3_d[l_ac].xmig017
         IF SQLCA.sqlcode THEN   
            LET r_success = 'N'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "xmig_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOR
         END IF      
   END FOR
   IF r_success = 'Y' THEN 
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF      
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig_allot()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig_allot()
DEFINE  l_sql     STRING 
#161109-00085#8-mod-s
#DEFINE  l_xmig    RECORD LIKE xmig_t.*   #161109-00085#8   mark
DEFINE  l_xmig    RECORD  #營運據點銷售預測分配資料
       xmigent LIKE xmig_t.xmigent, #企業編號
       xmigsite LIKE xmig_t.xmigsite, #營運據點
       xmig001 LIKE xmig_t.xmig001, #預測編號
       xmig002 LIKE xmig_t.xmig002, #預測起始日
       xmig003 LIKE xmig_t.xmig003, #版本
       xmig004 LIKE xmig_t.xmig004, #預測組織
       xmig005 LIKE xmig_t.xmig005, #業務員
       xmig006 LIKE xmig_t.xmig006, #預測料號
       xmig007 LIKE xmig_t.xmig007, #產品特徵
       xmig008 LIKE xmig_t.xmig008, #客戶
       xmig009 LIKE xmig_t.xmig009, #通路
       xmig010 LIKE xmig_t.xmig010, #期別
       xmig011 LIKE xmig_t.xmig011, #起始日期
       xmig012 LIKE xmig_t.xmig012, #截止日期
       xmig013 LIKE xmig_t.xmig013, #業務預測數量
       xmig014 LIKE xmig_t.xmig014, #單價
       xmig015 LIKE xmig_t.xmig015, #金額
       xmig016 LIKE xmig_t.xmig016, #生管確認數量
       xmig017 LIKE xmig_t.xmig017, #預測類型
      #xmig018 LIKE xmig_t.xmig018 #單位 #161109-00085#64 mark
       #161109-00085#64 --s add 
       xmig018 LIKE xmig_t.xmig018, #單位
       xmigud001 LIKE xmig_t.xmigud001, #自定義欄位(文字)001
       xmigud002 LIKE xmig_t.xmigud002, #自定義欄位(文字)002
       xmigud003 LIKE xmig_t.xmigud003, #自定義欄位(文字)003
       xmigud004 LIKE xmig_t.xmigud004, #自定義欄位(文字)004
       xmigud005 LIKE xmig_t.xmigud005, #自定義欄位(文字)005
       xmigud006 LIKE xmig_t.xmigud006, #自定義欄位(文字)006
       xmigud007 LIKE xmig_t.xmigud007, #自定義欄位(文字)007
       xmigud008 LIKE xmig_t.xmigud008, #自定義欄位(文字)008
       xmigud009 LIKE xmig_t.xmigud009, #自定義欄位(文字)009
       xmigud010 LIKE xmig_t.xmigud010, #自定義欄位(文字)010
       xmigud011 LIKE xmig_t.xmigud011, #自定義欄位(數字)011
       xmigud012 LIKE xmig_t.xmigud012, #自定義欄位(數字)012
       xmigud013 LIKE xmig_t.xmigud013, #自定義欄位(數字)013
       xmigud014 LIKE xmig_t.xmigud014, #自定義欄位(數字)014
       xmigud015 LIKE xmig_t.xmigud015, #自定義欄位(數字)015
       xmigud016 LIKE xmig_t.xmigud016, #自定義欄位(數字)016
       xmigud017 LIKE xmig_t.xmigud017, #自定義欄位(數字)017
       xmigud018 LIKE xmig_t.xmigud018, #自定義欄位(數字)018
       xmigud019 LIKE xmig_t.xmigud019, #自定義欄位(數字)019
       xmigud020 LIKE xmig_t.xmigud020, #自定義欄位(數字)020
       xmigud021 LIKE xmig_t.xmigud021, #自定義欄位(日期時間)021
       xmigud022 LIKE xmig_t.xmigud022, #自定義欄位(日期時間)022
       xmigud023 LIKE xmig_t.xmigud023, #自定義欄位(日期時間)023
       xmigud024 LIKE xmig_t.xmigud024, #自定義欄位(日期時間)024
       xmigud025 LIKE xmig_t.xmigud025, #自定義欄位(日期時間)025
       xmigud026 LIKE xmig_t.xmigud026, #自定義欄位(日期時間)026
       xmigud027 LIKE xmig_t.xmigud027, #自定義欄位(日期時間)027
       xmigud028 LIKE xmig_t.xmigud028, #自定義欄位(日期時間)028
       xmigud029 LIKE xmig_t.xmigud029, #自定義欄位(日期時間)029
       xmigud030 LIKE xmig_t.xmigud030  #自定義欄位(日期時間)030
       #161109-00085#64 --e add
          END RECORD
#161109-00085#8-mod-e

DEFINE  r_success LIKE type_t.chr1
   #161109-00085#8-mod-s
#   LET l_sql = "SELECT * FROM xmig_t ",   #161109-00085#8-mark
   #161109-00085#64 --s mark
   #LET l_sql = "SELECT xmigent,xmigsite,xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,
   #                    xmig008,xmig009,xmig010,xmig011,xmig012,xmig013,xmig014,xmig015,xmig016,xmig017,xmig018 
   #                FROM xmig_t ",
   #161109-00085#64 --e mark
   #161109-00085#8-mod-e
   #161109-00085#64 --s add
   LET l_sql = "SELECT xmigent,xmigsite,xmig001,xmig002,xmig003, ",
               "       xmig004,xmig005,xmig006,xmig007,xmig008, ",
               "       xmig009,xmig010,xmig011,xmig012,xmig013, ",
               "       xmig014,xmig015,xmig016,xmig017,xmig018, ",
               "       xmigud001,xmigud002,xmigud003,xmigud004,xmigud005, ",
               "       xmigud006,xmigud007,xmigud008,xmigud009,xmigud010, ",
               "       xmigud011,xmigud012,xmigud013,xmigud014,xmigud015, ",
               "       xmigud016,xmigud017,xmigud018,xmigud019,xmigud020, ",
               "       xmigud021,xmigud022,xmigud023,xmigud024,xmigud025, ",
               "       xmigud026,xmigud027,xmigud028,xmigud029,xmigud030  ",
               "  FROM xmig_t",
   #161109-00085#64 --e add
               " WHERE xmigent = '",g_enterprise,"'",
               "   AND xmigsite = '",g_xmig_m.xmigsite,"'",
               "   AND xmig001 = '",g_xmig_m.xmig001,"'",
               "   AND xmig002 = '",g_xmig_m.xmig002,"'",
               "   AND xmig003 = '",g_xmig_m.xmig003,"'",  
               "   AND xmig006 = '",g_xmig2_d[l_ac].l_xmig006_2,"'",
               " ORDER BY xmigsite,xmig001,xmig002,xmig003,xmig006,xmig010,xmig004,xmig005,xmig006,xmig007,xmig008,xmig009 "
               
   PREPARE axmt174_allot_pre FROM l_sql
   DECLARE axmt174_allot_cur CURSOR FOR axmt174_allot_pre
   LET r_success = 'Y' 
   #161109-00085#8-mod-s
#   FOREACH axmt174_allot_cur INTO l_xmig.*   #161109-00085#8-mark
   #161109-00085#64 --s mark
   #FOREACH axmt174_allot_cur INTO l_xmig.xmigent,l_xmig.xmigsite,l_xmig.xmig001,l_xmig.xmig002,l_xmig.xmig003,
   #                               l_xmig.xmig004,l_xmig.xmig005,l_xmig.xmig006,l_xmig.xmig007,l_xmig.xmig008,
   #                               l_xmig.xmig009,l_xmig.xmig010,l_xmig.xmig011,l_xmig.xmig012,l_xmig.xmig013,
   #                               l_xmig.xmig014,l_xmig.xmig015,l_xmig.xmig016,l_xmig.xmig017,l_xmig.xmig018
   #161109-00085#64 --e mark
   #161109-00085#8-mod-e
   #161109-00085#64 --s add
   FOREACH axmt174_allot_cur INTO l_xmig.xmigent,l_xmig.xmigsite,l_xmig.xmig001,l_xmig.xmig002,l_xmig.xmig003,
                                  l_xmig.xmig004,l_xmig.xmig005,l_xmig.xmig006,l_xmig.xmig007,l_xmig.xmig008,
                                  l_xmig.xmig009,l_xmig.xmig010,l_xmig.xmig011,l_xmig.xmig012,l_xmig.xmig013,
                                  l_xmig.xmig014,l_xmig.xmig015,l_xmig.xmig016,l_xmig.xmig017,l_xmig.xmig018,
                                  l_xmig.xmigud001,l_xmig.xmigud002,l_xmig.xmigud003,l_xmig.xmigud004,l_xmig.xmigud005,
                                  l_xmig.xmigud006,l_xmig.xmigud007,l_xmig.xmigud008,l_xmig.xmigud009,l_xmig.xmigud010,
                                  l_xmig.xmigud011,l_xmig.xmigud012,l_xmig.xmigud013,l_xmig.xmigud014,l_xmig.xmigud015,
                                  l_xmig.xmigud016,l_xmig.xmigud017,l_xmig.xmigud018,l_xmig.xmigud019,l_xmig.xmigud020,
                                  l_xmig.xmigud021,l_xmig.xmigud022,l_xmig.xmigud023,l_xmig.xmigud024,l_xmig.xmigud025,
                                  l_xmig.xmigud026,l_xmig.xmigud027,l_xmig.xmigud028,l_xmig.xmigud029,l_xmig.xmigud030
   #161109-00085#64 --e add
#      LET l_xmig.xmig016 = l_xmig.xmig016/g_xmig2_d[l_ac].l_xmig016_2_01
      IF l_xmig.xmig010 = 1  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_01) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_01 <> g_xmig2_d_t.l_xmig016_2_01 OR g_xmig2_d_t.l_xmig016_2_01 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_01)*g_xmig2_d[l_ac].l_xmig016_2_01
      END IF
      IF l_xmig.xmig010 = 2  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_02) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_02 <> g_xmig2_d_t.l_xmig016_2_02 OR g_xmig2_d_t.l_xmig016_2_02 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_02)*g_xmig2_d[l_ac].l_xmig016_2_02
      END IF      
      IF l_xmig.xmig010 = 3  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_04) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_04 <> g_xmig2_d_t.l_xmig016_2_04 OR g_xmig2_d_t.l_xmig016_2_04 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_04)*g_xmig2_d[l_ac].l_xmig016_2_04
      END IF
      IF l_xmig.xmig010 = 4  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_04) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_04 <> g_xmig2_d_t.l_xmig016_2_04 OR g_xmig2_d_t.l_xmig016_2_04 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_04)*g_xmig2_d[l_ac].l_xmig016_2_04
      END IF
      IF l_xmig.xmig010 = 5  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_05) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_05 <> g_xmig2_d_t.l_xmig016_2_05 OR g_xmig2_d_t.l_xmig016_2_05 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_05)*g_xmig2_d[l_ac].l_xmig016_2_05
      END IF
      IF l_xmig.xmig010 = 6  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_06) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_06 <> g_xmig2_d_t.l_xmig016_2_06 OR g_xmig2_d_t.l_xmig016_2_06 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_06)*g_xmig2_d[l_ac].l_xmig016_2_06
      END IF    
      IF l_xmig.xmig010 = 7  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_07) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_07 <> g_xmig2_d_t.l_xmig016_2_07 OR g_xmig2_d_t.l_xmig016_2_07 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_07)*g_xmig2_d[l_ac].l_xmig016_2_07
      END IF
      IF l_xmig.xmig010 = 8  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_08) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_08 <> g_xmig2_d_t.l_xmig016_2_08 OR g_xmig2_d_t.l_xmig016_2_08 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_08)*g_xmig2_d[l_ac].l_xmig016_2_08
      END IF
      IF l_xmig.xmig010 = 9  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_09) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_09 <> g_xmig2_d_t.l_xmig016_2_09 OR g_xmig2_d_t.l_xmig016_2_09 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_09)*g_xmig2_d[l_ac].l_xmig016_2_09
      END IF
      IF l_xmig.xmig010 = 10  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_10) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_10 <> g_xmig2_d_t.l_xmig016_2_10 OR g_xmig2_d_t.l_xmig016_2_10 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_10)*g_xmig2_d[l_ac].l_xmig016_2_10
      END IF
      IF l_xmig.xmig010 = 11  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_11) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_11 <> g_xmig2_d_t.l_xmig016_2_11 OR g_xmig2_d_t.l_xmig016_2_11 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_11)*g_xmig2_d[l_ac].l_xmig016_2_11
      END IF
      IF l_xmig.xmig010 = 12  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_12) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_12 <> g_xmig2_d_t.l_xmig016_2_12 OR g_xmig2_d_t.l_xmig016_2_12 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_12)*g_xmig2_d[l_ac].l_xmig016_2_12
      END IF
      IF l_xmig.xmig010 = 13  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_13) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_13 <> g_xmig2_d_t.l_xmig016_2_13 OR g_xmig2_d_t.l_xmig016_2_13 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_13)*g_xmig2_d[l_ac].l_xmig016_2_13
      END IF
      IF l_xmig.xmig010 = 14 AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_14) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_14 <> g_xmig2_d_t.l_xmig016_2_14 OR g_xmig2_d_t.l_xmig016_2_14 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_14)*g_xmig2_d[l_ac].l_xmig016_2_14
      END IF
      IF l_xmig.xmig010 = 15  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_15) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_15 <> g_xmig2_d_t.l_xmig016_2_15 OR g_xmig2_d_t.l_xmig016_2_15 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_15)*g_xmig2_d[l_ac].l_xmig016_2_15
      END IF
      IF l_xmig.xmig010 = 16  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_16) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_16 <> g_xmig2_d_t.l_xmig016_2_16 OR g_xmig2_d_t.l_xmig016_2_16 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_16)*g_xmig2_d[l_ac].l_xmig016_2_16
      END IF
      IF l_xmig.xmig010 = 17  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_17) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_17 <> g_xmig2_d_t.l_xmig016_2_17 OR g_xmig2_d_t.l_xmig016_2_17 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_17)*g_xmig2_d[l_ac].l_xmig016_2_17
      END IF
      IF l_xmig.xmig010 = 18  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_18) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_18 <> g_xmig2_d_t.l_xmig016_2_18 OR g_xmig2_d_t.l_xmig016_2_18 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_18)*g_xmig2_d[l_ac].l_xmig016_2_18
      END IF
      IF l_xmig.xmig010 = 19  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_19) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_19 <> g_xmig2_d_t.l_xmig016_2_19 OR g_xmig2_d_t.l_xmig016_2_19 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_19)*g_xmig2_d[l_ac].l_xmig016_2_19
      END IF
      IF l_xmig.xmig010 = 20  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_20) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_20 <> g_xmig2_d_t.l_xmig016_2_20 OR g_xmig2_d_t.l_xmig016_2_20 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_20)*g_xmig2_d[l_ac].l_xmig016_2_20
      END IF
      IF l_xmig.xmig010 = 21  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_21) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_21 <> g_xmig2_d_t.l_xmig016_2_21 OR g_xmig2_d_t.l_xmig016_2_21 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_21)*g_xmig2_d[l_ac].l_xmig016_2_21
      END IF
      IF l_xmig.xmig010 = 22  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_22) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_22 <> g_xmig2_d_t.l_xmig016_2_22 OR g_xmig2_d_t.l_xmig016_2_22 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_22)*g_xmig2_d[l_ac].l_xmig016_2_22
      END IF
      IF l_xmig.xmig010 = 23  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_23) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_23 <> g_xmig2_d_t.l_xmig016_2_23 OR g_xmig2_d_t.l_xmig016_2_23 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_23)*g_xmig2_d[l_ac].l_xmig016_2_23
      END IF
      IF l_xmig.xmig010 = 24  AND (NOT cl_null(g_xmig2_d[l_ac].l_xmig016_2_24) AND 
        (g_xmig2_d[l_ac].l_xmig016_2_24 <> g_xmig2_d_t.l_xmig016_2_24 OR g_xmig2_d_t.l_xmig016_2_24 IS NULL)) THEN 
        LET l_xmig.xmig016 = (l_xmig.xmig013/g_xmig2_d[l_ac].l_xmig013_2_24)*g_xmig2_d[l_ac].l_xmig016_2_24
      END IF  
      UPDATE xmig_t SET xmig016 = l_xmig.xmig016
       WHERE xmigent = g_enterprise
         AND xmigsite = l_xmig.xmigsite
         AND xmig001 = l_xmig.xmig001   
         AND xmig002 = l_xmig.xmig002 
         AND xmig003 = l_xmig.xmig003 
         AND xmig004 = l_xmig.xmig004 
         AND xmig005 = l_xmig.xmig005 
         AND xmig006 = l_xmig.xmig006 
         AND xmig007 = l_xmig.xmig007 
         AND xmig008 = l_xmig.xmig008 
         AND xmig009 = l_xmig.xmig009 
         AND xmig010 = l_xmig.xmig010 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = 'N' 
         EXIT FOREACH
      END IF        
   END FOREACH 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig004_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig004_desc()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmig_d[l_ac].xmig004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_xmig_d[l_ac].xmig004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmig_d[l_ac].xmig004_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig005_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig005_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig_d[l_ac].xmig005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xmig_d[l_ac].xmig005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig_d[l_ac].xmig005_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig006_desc_1()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig006_desc_1()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig2_d[l_ac].l_xmig006_2
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig2_d[l_ac].l_xmig006_2_desc = '', g_rtn_fields[1] , ''
            LET g_xmig2_d[l_ac].l_xmig006_2_desc1 = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_xmig2_d[l_ac].l_xmig006_2_desc
            DISPLAY BY NAME g_xmig2_d[l_ac].l_xmig006_2_desc1
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig2_d[l_ac].l_xmig006_2
            CALL ap_ref_array2(g_ref_fields,"SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=?","") RETURNING g_rtn_fields
            LET g_xmig2_d[l_ac].l_xmig006_2_desc2 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig2_d[l_ac].l_xmig006_2_desc2 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig2_d[l_ac].l_xmig006_2_desc2
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig2_d[l_ac].l_xmig006_2_desc3 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig2_d[l_ac].l_xmig006_2_desc3               
END FUNCTION

################################################################################
# Descriptions...: 修改生管確認數量
# Memo...........:
# Usage..........: CALL axmt174_upd_xmig()
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_upd_xmig()
DEFINE   r_success      LIKE type_t.chr1
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_01) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_01,1) THEN
         LET r_success = 'N'
      END IF
   END IF
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_02) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_02,2) THEN
         LET r_success = 'N'
      END IF            
   END IF   
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_03) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_03,3) THEN
        LET r_success = 'N'
      END IF   
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_04) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_04,4) THEN
         LET r_success = 'N'
      END IF   
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_05) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_05,5) THEN
         LET r_success = 'N'
      END IF
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_06) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_06,6) THEN
         LET r_success = 'N'
      END IF   
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_07) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_07,7) THEN
         LET r_success = 'N'
      END IF   
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_08) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_08,8) THEN
         LET r_success = 'N'   
      END IF         
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_09) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_09,9) THEN
         LET r_success = 'N'   
      END IF      
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_10) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_10,10) THEN
         LET r_success = 'N'   
      END IF      
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_11) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_11,11) THEN
         LET r_success = 'N'
      END IF
   END IF
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_12) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_12,12) THEN
         LET r_success = 'N'
      END IF            
   END IF   
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_13) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_13,13) THEN
        LET r_success = 'N'
      END IF   
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_14) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_14,14) THEN
         LET r_success = 'N'
      END IF   
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_15) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_15,15) THEN
         LET r_success = 'N'
      END IF
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_16) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_16,16) THEN
         LET r_success = 'N'
      END IF   
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_17) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_17,17) THEN
         LET r_success = 'N'
      END IF   
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_18) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_18,18) THEN
         LET r_success = 'N'   
      END IF         
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_19) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_19,19) THEN
         LET r_success = 'N'   
      END IF      
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_20) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_20,20) THEN
         LET r_success = 'N'   
      END IF      
   END IF 
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_21) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_21,21) THEN
         LET r_success = 'N'   
      END IF 
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_22) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_22,22) THEN
         LET r_success = 'N'   
      END IF 
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_23) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_23,23) THEN
         LET r_success = 'N'   
      END IF 
   END IF  
   IF NOT cl_null(g_xmig_d[l_ac].l_xmig016_24) THEN
      IF NOT axmt174_upd_xmig010(g_xmig_d[l_ac].l_xmig016_24,24) THEN
         LET r_success = 'N'   
      END IF 
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 更改生管確認數量
# Memo...........:
# Usage..........: CALL axmt174_upd_xmig010(p_xmig016,p_xmig010)
#                  RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_upd_xmig010(p_xmig016,p_xmig010)
DEFINE   p_xmig016      LIKE xmig_t.xmig016
DEFINE   p_xmig010      LIKE xmig_t.xmig010

   UPDATE xmig_t SET xmig016 = p_xmig016                     
    WHERE xmigent = g_enterprise
      AND xmigsite = g_xmig_m.xmigsite
      AND xmig001 = g_xmig_m.xmig001
      AND xmig002 = g_xmig_m.xmig002
      AND xmig003 = g_xmig_m.xmig003
      AND xmig004 = g_xmig_d[l_ac].xmig004
      AND xmig005 = g_xmig_d[l_ac].xmig005
      AND xmig006 = g_xmig_d[l_ac].xmig006
      AND xmig007 = g_xmig_d[l_ac].xmig007
      AND xmig008 = g_xmig_d[l_ac].xmig008
      AND xmig009 = g_xmig_d[l_ac].xmig009
      AND xmig010 = p_xmig010
      
   IF SQLCA.sqlcode THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xmig_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF      
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 尾差處理
# Memo...........:
# Usage..........: CALL axmt174_xmig016_diff()
#                  RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig016_diff()
DEFINE l_xmig016_sum   LIKE xmig_t.xmig016
DEFINE l_xmig016_diff  LIKE xmig_t.xmig016
DEFINE l_xmia002       LIKE xmia_t.xmia002
DEFINE i               LIKE type_t.num5

   SELECT xmia002 INTO l_xmia002 FROM xmia_t
    WHERE xmiaent = g_enterprise
      AND xmia001 = g_xmig_m.xmig001
   FOR i = 1 TO l_xmia002
      #尾差調整
      IF i = 1 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_01 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_01 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF   
      IF i = 2 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_02 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_02 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF   
      IF i = 3 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_03 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_03 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF    
      IF i = 4 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_04 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_04 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 5 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_05 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_05 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 6 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_06 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_06 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF  
      IF i = 7 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_07 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_07 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF  
      IF i = 8 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_08 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_08 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 9 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_09 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_09 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF     
      IF i = 10 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_10 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_10 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 11 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_11 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_11 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF  
      IF i = 12 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_12 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_12 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 13 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_13 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_13 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF   
      IF i = 14 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_14 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_14 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF   
      IF i = 15 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_15 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_15 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF   
      IF i = 16 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_16 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_16 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 17 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_17 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_17 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF      
      IF i = 18 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_18 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_18 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF   
      IF i = 19 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_19 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_19 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF  
      IF i = 20 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_20 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_20 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 21 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_21 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_21 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF  
      IF i = 22 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_22 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_22 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 23 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_23 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_23 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF 
      IF i = 24 AND l_xmig016_sum <> g_xmig2_d[l_ac].l_xmig016_2_24 THEN  
         LET l_xmig016_diff = g_xmig2_d[l_ac].l_xmig016_2_24 - l_xmig016_sum   
         IF NOT axmt174_xmig016_tail(i,l_xmig016_diff) THEN
            RETURN FALSE
         END IF                  
      END IF      
   END FOR  
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig016_tail(p_xmig010,p_xmig016)
#                  RETURNING TRUE/FALSE
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig016_tail(p_xmig010,p_xmig016)
DEFINE  l_xmig016_s    LIKE xmig_t.xmig016
DEFINE  p_xmig016      LIKE xmig_t.xmig016
DEFINE  l_xmig016      LIKE xmig_t.xmig016
DEFINE  p_xmig010      LIKE xmig_t.xmig010
DEFINE  l_xmig004      LIKE xmig_t.xmig004
DEFINE  l_xmig005      LIKE xmig_t.xmig005
DEFINE  l_xmig007      LIKE xmig_t.xmig007
DEFINE  l_xmig008      LIKE xmig_t.xmig008
DEFINE  l_xmig009      LIKE xmig_t.xmig009
DEFINE  l_sql          STRING      
      LET l_sql = " SELECT xmig004,xmig005,xmig007,xmig008,xmig009,xmig016 FROM xmig_t ",
                 "   WHERE xmigent = '",g_enterprise,"'",
                 "     AND xmigsite = '",g_xmig_m.xmigsite,"'",
                 "     AND xmig001 = '",g_xmig_m.xmig001,"'",
                 "     AND xmig002 = '",g_xmig_m.xmig002,"'",
                 "     AND xmig003 = '",g_xmig_m.xmig003,"'",
                 "     AND xmig006 = '",g_xmig2_d[l_ac].l_xmig006_2,"'",
                 "     AND xmig010 = '",p_xmig010,"'",
                 "   ORDER BY xmigsite,xmig001,xmig002,xmig003,xmig006,xmig010,xmig016 desc"
      PREPARE axmt174_diff FROM l_sql
      EXECUTE axmt174_diff INTO l_xmig004,l_xmig005,l_xmig007,l_xmig008,l_xmig009,l_xmig016
      LET l_xmig016_s = l_xmig016 + p_xmig016
      UPDATE xmig_t SET xmig016 = l_xmig016_s
       WHERE xmigent = g_enterprise
         AND xmigsite = g_xmig_m.xmigsite
         AND xmig001 = g_xmig_m.xmig001
         AND xmig002 = g_xmig_m.xmig002
         AND xmig003 = g_xmig_m.xmig003
         AND xmig006 = g_xmig2_d[l_ac].l_xmig006_2
         AND xmig004 = l_xmig004
         AND xmig005 = l_xmig005
         AND xmig007 = l_xmig007
         AND xmig008 = l_xmig008
         AND xmig009 = l_xmig009
         AND xmig010 = p_xmig010  
   IF SQLCA.sqlcode THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xmig_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF  
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig004_desc_2(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig004_desc_2(p_ac)
DEFINE  p_ac     LIKE type_t.num10   #add by lixh 20150831 =>num10
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmig3_d[p_ac].xmig004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_xmig3_d[p_ac].xmig004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xmig3_d[p_ac].xmig004_desc
END FUNCTION

################################################################################
# Descriptions...: 業務員說明
# Memo...........:
# Usage..........: CALL axmt174_xmig005_desc_2(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig005_desc_2(p_ac)
DEFINE   p_ac     LIKE type_t.num10   #add by lixh 20150831 =>num10
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig3_d[p_ac].xmig005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_xmig3_d[p_ac].xmig005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig3_d[p_ac].xmig005_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig008_desc_2(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig008_desc_2(p_ac)
DEFINE   p_ac     LIKE type_t.num10   #add by lixh 20150831 =>num10
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig3_d[p_ac].xmig008
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmig3_d[p_ac].xmig008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig3_d[p_ac].xmig008_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmt174_xmig009_desc_2(p_ac)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt174_xmig009_desc_2(p_ac)
DEFINE   p_ac     LIKE type_t.num10  #add by lixh 20150831 =>num10
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmig3_d[p_ac].xmig009
            #160621-00003#3 20160627 modify by beckxie---S
            #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='275' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #160621-00003#3 20160627 modify by beckxie---E
            LET g_xmig3_d[p_ac].xmig009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmig3_d[p_ac].xmig009_desc
END FUNCTION

 
{</section>}
 
