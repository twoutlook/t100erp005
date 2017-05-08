#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-12-27 15:23:04), PR版次:0008(2017-01-13 15:29:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: axcq801
#+ Description: 存貨貨齡查詢作業
#+ Creator....: 03297(2014-11-04 13:44:14)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="axcq801.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#150319-00004#23  Q轉xg  
#160318-00005#46  2016/03/28  by pengxin  修正azzi920重复定义之错误讯息
#160714-00027#1   2016/08/01  By 02097    金額取位/欄位開窗調整
#160727-00019#21  2016/08/04  By 08742    系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                         Mod  axcq801_print_tmp--> axcq801_tmp01
#160802-00020#9   2016/09/26  By 02097    法人: 視azzi800的据點權限/帳套: 視USER的帳套權限/QBE下法人/帳套不用互相勾稽
#161108-00037#7   2016/12/22  By 02040    單頭增加材料分類欄位，依材料分類做不同呈現
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
GLOBALS "../../cfg/top_report.inc"
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xcfj_m        RECORD
       xcfjcomp LIKE xcfj_t.xcfjcomp, 
   xcfjcomp_desc LIKE type_t.chr80, 
   xcfj003 LIKE xcfj_t.xcfj003, 
   xcfj004 LIKE xcfj_t.xcfj004, 
   xccc001 LIKE type_t.chr1, 
   xccc001_desc LIKE type_t.chr80, 
   xcfc013 LIKE type_t.chr10, 
   xcfc013_desc LIKE type_t.chr80, 
   xcfjld LIKE xcfj_t.xcfjld, 
   xcfjld_desc LIKE type_t.chr80, 
   xcfj002 LIKE xcfj_t.xcfj002, 
   xcfj002_desc LIKE type_t.chr80, 
   xcfa004 LIKE type_t.chr1
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcfj_d        RECORD
       xcfb010 LIKE type_t.chr10, 
   xcfb010_desc LIKE type_t.chr500, 
   imaa003 LIKE type_t.chr10, 
   imaa003_desc LIKE type_t.chr500, 
   imag011 LIKE type_t.chr10, 
   imag011_desc LIKE type_t.chr500, 
   xcfj001 LIKE xcfj_t.xcfj001, 
   xcfj001_desc LIKE type_t.chr500, 
   xcfj005 LIKE xcfj_t.xcfj005, 
   xcfj005_desc LIKE type_t.chr500, 
   xcfj005_desc_desc LIKE type_t.chr500, 
   xcfj006 LIKE xcfj_t.xcfj006, 
   xcfj007 LIKE xcfj_t.xcfj007, 
   xcfj008 LIKE xcfj_t.xcfj008, 
   xcfj009 LIKE xcfj_t.xcfj009, 
   xccc280 LIKE type_t.num20_6, 
   l_amount LIKE type_t.num20_6, 
   l_idle LIKE type_t.num20_6, 
   l_qty1 LIKE type_t.num20_6, 
   l_amt1 LIKE type_t.num20_6, 
   l_rate1 LIKE type_t.num20_6, 
   l_idle1 LIKE type_t.num20_6, 
   l_qty2 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6, 
   l_rate2 LIKE type_t.num20_6, 
   l_idle2 LIKE type_t.num20_6, 
   l_qty3 LIKE type_t.num20_6, 
   l_amt3 LIKE type_t.num20_6, 
   l_rate3 LIKE type_t.num20_6, 
   l_idle3 LIKE type_t.num20_6, 
   l_qty4 LIKE type_t.num20_6, 
   l_amt4 LIKE type_t.num20_6, 
   l_rate4 LIKE type_t.num20_6, 
   l_idle4 LIKE type_t.num20_6, 
   l_qty5 LIKE type_t.num20_6, 
   l_amt5 LIKE type_t.num20_6, 
   l_rate5 LIKE type_t.num20_6, 
   l_idle5 LIKE type_t.num20_6, 
   l_qty6 LIKE type_t.num20_6, 
   l_amt6 LIKE type_t.num20_6, 
   l_rate6 LIKE type_t.num20_6, 
   l_idle6 LIKE type_t.num20_6, 
   l_qty7 LIKE type_t.num20_6, 
   l_amt7 LIKE type_t.num20_6, 
   l_rate7 LIKE type_t.num20_6, 
   l_idle7 LIKE type_t.num20_6, 
   l_qty8 LIKE type_t.num20_6, 
   l_amt8 LIKE type_t.num20_6, 
   l_rate8 LIKE type_t.num20_6, 
   l_idle8 LIKE type_t.num20_6, 
   l_qty9 LIKE type_t.num20_6, 
   l_amt9 LIKE type_t.num20_6, 
   l_rate9 LIKE type_t.num20_6, 
   l_idle9 LIKE type_t.num20_6, 
   l_qty10 LIKE type_t.num20_6, 
   l_amt10 LIKE type_t.num20_6, 
   l_rate10 LIKE type_t.num20_6, 
   l_idle10 LIKE type_t.num20_6, 
   l_qty11 LIKE type_t.num20_6, 
   l_amt11 LIKE type_t.num20_6, 
   l_rate11 LIKE type_t.num20_6, 
   l_idle11 LIKE type_t.num20_6, 
   l_qty12 LIKE type_t.num20_6, 
   l_amt12 LIKE type_t.num20_6, 
   l_rate12 LIKE type_t.num20_6, 
   l_idle12 LIKE type_t.num20_6, 
   l_qty13 LIKE type_t.num20_6, 
   l_amt13 LIKE type_t.num20_6, 
   l_rate13 LIKE type_t.num20_6, 
   l_idle13 LIKE type_t.num20_6, 
   l_qty14 LIKE type_t.num20_6, 
   l_amt14 LIKE type_t.num20_6, 
   l_rate14 LIKE type_t.num20_6, 
   l_idle14 LIKE type_t.num20_6, 
   l_qty15 LIKE type_t.num20_6, 
   l_amt15 LIKE type_t.num20_6, 
   l_rate15 LIKE type_t.num20_6, 
   l_idle15 LIKE type_t.num20_6, 
   l_qty16 LIKE type_t.num20_6, 
   l_amt16 LIKE type_t.num20_6, 
   l_rate16 LIKE type_t.num20_6, 
   l_idle16 LIKE type_t.num20_6, 
   l_qty17 LIKE type_t.num20_6, 
   l_amt17 LIKE type_t.num20_6, 
   l_rate17 LIKE type_t.num20_6, 
   l_idle17 LIKE type_t.num20_6, 
   l_qty18 LIKE type_t.num20_6, 
   l_amt18 LIKE type_t.num20_6, 
   l_rate18 LIKE type_t.num20_6, 
   l_idle18 LIKE type_t.num20_6, 
   l_qty19 LIKE type_t.num20_6, 
   l_amt19 LIKE type_t.num20_6, 
   l_rate19 LIKE type_t.num20_6, 
   l_idle19 LIKE type_t.num20_6, 
   l_qty20 LIKE type_t.num20_6, 
   l_amt20 LIKE type_t.num20_6, 
   l_rate20 LIKE type_t.num20_6, 
   l_idle20 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc3              STRING
DEFINE g_wc4              STRING
DEFINE g_wc5              STRING       #161108-00037#7 add
DEFINE g_xccc001          LIKE xccc_t.xccc001
DEFINE g_xcfa004          LIKE xcfa_t.xcfa004
DEFINE g_cn               LIKE type_t.num5
DEFINE g_glaa001          LIKE glaa_t.glaa001
DEFINE g_glaa003          LIKE glaa_t.glaa003
DEFINE g_glaa015          LIKE glaa_t.glaa015
DEFINE g_glaa016          LIKE glaa_t.glaa016
DEFINE g_glaa019          LIKE glaa_t.glaa019
DEFINE g_glaa020          LIKE glaa_t.glaa020
DEFINE g_curr             LIKE glaa_t.glaa001
DEFINE g_ooaj004          LIKE ooaj_t.ooaj004
DEFINE g_bded      DYNAMIC ARRAY OF RECORD    #单身年月  
          bday    LIKE xcfc_t.xcfc010,
          eday    LIKE xcfc_t.xcfc011,
          rate    LIKE xcfc_t.xcfc012   
      END RECORD
DEFINE g_para_data        LIKE type_t.chr80     #采用成本域否  #fengmy150113
DEFINE g_para_data1       LIKE type_t.chr80     #采用特性否    #fengmy150113
DEFINE g_flag             LIKE type_t.num5
DEFINE g_xcfj001          LIKE type_t.chr1
DEFINE g_xcfj006          LIKE type_t.chr1
DEFINE g_xcfjcomp         LIKE xcfj_t.xcfjcomp    #160714-00027#1
DEFINE g_wc_cs_ld         STRING                  #160802-00020#9
DEFINE g_wc_cs_comp       STRING                  #160802-00020#9
#161108-00037#7-s-add
DEFINE g_browser1      DYNAMIC ARRAY OF RECORD   
       xcfjcomp LIKE xcfj_t.xcfjcomp,
       xcfjld   LIKE xcfj_t.xcfjld,
       xcfj002  LIKE xcfj_t.xcfj002,
       xcfj003  LIKE xcfj_t.xcfj003,
       xcfj004  LIKE xcfj_t.xcfj004,
       xcfc013  LIKE xcfc_t.xcfc013      
      END RECORD 
#161108-00037#7-e-add      
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcfj_m          type_g_xcfj_m
DEFINE g_xcfj_m_t        type_g_xcfj_m
DEFINE g_xcfj_m_o        type_g_xcfj_m
DEFINE g_xcfj_m_mask_o   type_g_xcfj_m #轉換遮罩前資料
DEFINE g_xcfj_m_mask_n   type_g_xcfj_m #轉換遮罩後資料
 
   DEFINE g_xcfj003_t LIKE xcfj_t.xcfj003
DEFINE g_xcfj004_t LIKE xcfj_t.xcfj004
DEFINE g_xcfjld_t LIKE xcfj_t.xcfjld
DEFINE g_xcfj002_t LIKE xcfj_t.xcfj002
 
 
DEFINE g_xcfj_d          DYNAMIC ARRAY OF type_g_xcfj_d
DEFINE g_xcfj_d_t        type_g_xcfj_d
DEFINE g_xcfj_d_o        type_g_xcfj_d
DEFINE g_xcfj_d_mask_o   DYNAMIC ARRAY OF type_g_xcfj_d #轉換遮罩前資料
DEFINE g_xcfj_d_mask_n   DYNAMIC ARRAY OF type_g_xcfj_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcfjld LIKE xcfj_t.xcfjld,
      b_xcfj002 LIKE xcfj_t.xcfj002,
      b_xcfj003 LIKE xcfj_t.xcfj003,
      b_xcfj004 LIKE xcfj_t.xcfj004
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

#end add-point
 
{</section>}
 
{<section id="axcq801.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
#160802-00020#9-s add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人
#160802-00020#9-e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcfjcomp,'',xcfj003,xcfj004,'','','','',xcfjld,'',xcfj002,'',''", 
                      " FROM xcfj_t",
                      " WHERE xcfjent= ? AND xcfjld=? AND xcfj002=? AND xcfj003=? AND xcfj004=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq801_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcfjcomp,t0.xcfj003,t0.xcfj004,t0.xcfjld,t0.xcfj002,t1.ooefl003 , 
       t3.glaal003 ,t4.xcatl003",
               " FROM xcfj_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcfjcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaal001=t0.xcfjld AND t3.glaal002='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t4 ON t4.xcatlent="||g_enterprise||" AND t4.xcatl001=t0.xcfj002 AND t4.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcfjent = " ||g_enterprise|| " AND t0.xcfjld = ? AND t0.xcfj002 = ? AND t0.xcfj003 = ? AND t0.xcfj004 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq801_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq801 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq801_init()   
 
      #進入選單 Menu (="N")
      CALL axcq801_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq801
      
   END IF 
   
   CLOSE axcq801_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq801.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq801_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
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
   CALL cl_set_combo_scc('xccc001','8914')
   CALL cl_set_combo_scc('xcfa004','8043')
   CALL cl_set_comp_visible("l_qty1",FALSE)
   CALL cl_set_comp_visible("l_amt1",FALSE)
   CALL cl_set_comp_visible("l_rate1",FALSE)
   CALL cl_set_comp_visible("l_idle1",FALSE)
   CALL cl_set_comp_visible("l_qty2",FALSE)
   CALL cl_set_comp_visible("l_amt2",FALSE)
   CALL cl_set_comp_visible("l_rate2",FALSE)
   CALL cl_set_comp_visible("l_idle2",FALSE)
   CALL cl_set_comp_visible("l_qty3",FALSE)
   CALL cl_set_comp_visible("l_amt3",FALSE)
   CALL cl_set_comp_visible("l_rate3",FALSE)
   CALL cl_set_comp_visible("l_idle3",FALSE)
   CALL cl_set_comp_visible("l_qty4",FALSE)
   CALL cl_set_comp_visible("l_amt4",FALSE)
   CALL cl_set_comp_visible("l_rate4",FALSE)
   CALL cl_set_comp_visible("l_idle4",FALSE)
   CALL cl_set_comp_visible("l_qty5",FALSE)
   CALL cl_set_comp_visible("l_amt5",FALSE)
   CALL cl_set_comp_visible("l_rate5",FALSE)
   CALL cl_set_comp_visible("l_idle5",FALSE)
   CALL cl_set_comp_visible("l_qty6",FALSE)
   CALL cl_set_comp_visible("l_amt6",FALSE)
   CALL cl_set_comp_visible("l_rate6",FALSE)
   CALL cl_set_comp_visible("l_idle6",FALSE)
   CALL cl_set_comp_visible("l_qty7",FALSE)
   CALL cl_set_comp_visible("l_amt7",FALSE)
   CALL cl_set_comp_visible("l_rate7",FALSE)
   CALL cl_set_comp_visible("l_idle7",FALSE)
   CALL cl_set_comp_visible("l_qty8",FALSE)
   CALL cl_set_comp_visible("l_amt8",FALSE)
   CALL cl_set_comp_visible("l_rate8",FALSE)
   CALL cl_set_comp_visible("l_idle8",FALSE)
   CALL cl_set_comp_visible("l_qty9",FALSE)
   CALL cl_set_comp_visible("l_amt9",FALSE)
   CALL cl_set_comp_visible("l_rate9",FALSE)
   CALL cl_set_comp_visible("l_idle9",FALSE)
   CALL cl_set_comp_visible("l_qty10",FALSE)
   CALL cl_set_comp_visible("l_amt10",FALSE)
   CALL cl_set_comp_visible("l_rate10",FALSE)
   CALL cl_set_comp_visible("l_idle10",FALSE)
   CALL cl_set_comp_visible("l_qty11",FALSE)
   CALL cl_set_comp_visible("l_amt11",FALSE)
   CALL cl_set_comp_visible("l_rate11",FALSE)
   CALL cl_set_comp_visible("l_idle11",FALSE)
   CALL cl_set_comp_visible("l_qty12",FALSE)
   CALL cl_set_comp_visible("l_amt12",FALSE)
   CALL cl_set_comp_visible("l_rate12",FALSE)
   CALL cl_set_comp_visible("l_idle12",FALSE)
   CALL cl_set_comp_visible("l_qty13",FALSE)
   CALL cl_set_comp_visible("l_amt13",FALSE)
   CALL cl_set_comp_visible("l_rate13",FALSE)
   CALL cl_set_comp_visible("l_idle13",FALSE)
   CALL cl_set_comp_visible("l_qty14",FALSE)
   CALL cl_set_comp_visible("l_amt14",FALSE)
   CALL cl_set_comp_visible("l_rate14",FALSE)
   CALL cl_set_comp_visible("l_idle14",FALSE)
   CALL cl_set_comp_visible("l_qty15",FALSE)
   CALL cl_set_comp_visible("l_amt15",FALSE)
   CALL cl_set_comp_visible("l_rate15",FALSE)
   CALL cl_set_comp_visible("l_idle15",FALSE)
   CALL cl_set_comp_visible("l_qty16",FALSE)
   CALL cl_set_comp_visible("l_amt16",FALSE)
   CALL cl_set_comp_visible("l_rate16",FALSE)
   CALL cl_set_comp_visible("l_idle16",FALSE)
   CALL cl_set_comp_visible("l_qty17",FALSE)
   CALL cl_set_comp_visible("l_amt17",FALSE)
   CALL cl_set_comp_visible("l_rate17",FALSE)
   CALL cl_set_comp_visible("l_idle17",FALSE)
   CALL cl_set_comp_visible("l_qty18",FALSE)
   CALL cl_set_comp_visible("l_amt18",FALSE)
   CALL cl_set_comp_visible("l_rate18",FALSE)
   CALL cl_set_comp_visible("l_idle18",FALSE)
   CALL cl_set_comp_visible("l_qty19",FALSE)
   CALL cl_set_comp_visible("l_amt19",FALSE)
   CALL cl_set_comp_visible("l_rate19",FALSE)
   CALL cl_set_comp_visible("l_idle19",FALSE)
   CALL cl_set_comp_visible("l_qty20",FALSE)
   CALL cl_set_comp_visible("l_amt20",FALSE)
   CALL cl_set_comp_visible("l_rate20",FALSE)
   CALL cl_set_comp_visible("l_idle20",FALSE)
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcfj001,xcfj001_desc',TRUE)          
   ELSE                        
      CALL cl_set_comp_visible('xcfj001,xcfj001_desc',FALSE)       
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcfj006',TRUE)    
   ELSE                       
      CALL cl_set_comp_visible('xcfj006',FALSE)      
   END IF   
   #fengmy 150113----end
   #end add-point
   
   CALL axcq801_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq801.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq801_ui_dialog()
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
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcfj_m.* TO NULL
         CALL g_xcfj_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq801_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcfj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq801_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq801_ui_detailshow()
               
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
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq801_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
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
               CALL axcq801_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq801_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq801_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq801_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq801_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq801_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq801_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq801_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq801_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq801_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq801_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq801_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcfj_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
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
               NEXT FIELD xcfj001
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
               CALL axcq801_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq801_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq801_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL axcq801_x01('1=1','axcq801_tmp01',g_flag,g_xcfj001,g_xcfj006) #141218-0001   #160727-00019#21 Mod  axcq801_print_tmp--> axcq801_tmp01
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axcq801_x01('1=1','axcq801_tmp01',g_flag,g_xcfj001,g_xcfj006) #141218-0001   #160727-00019#21 Mod  axcq801_print_tmp--> axcq801_tmp01
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq801_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axcq801_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq801_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq801_set_pk_array()
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
 
{<section id="axcq801.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq801_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq801.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq801_browser_fill(ps_page_action)
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
  #161108-00037#7-s-add 
   CALL axcq801_browser_fill_1(ps_page_action)
   RETURN
  #161108-00037#7-e-add 
#160802-00020#9-s add
   #增加帳套過濾條件
   IF NOT cl_null(g_wc_cs_ld) THEN
     #LET g_wc = g_wc," AND xcccld IN ",g_wc_cs_ld   #161108-00037#7 mark
      LET g_wc = g_wc," AND xcfjld IN ",g_wc_cs_ld   #161108-00037#7 add
   END IF
   #增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
     #LET g_wc = g_wc," AND xccccomp IN ",g_wc_cs_comp  #161108-00037#7 mark
      LET g_wc = g_wc," AND xcfjcomp IN ",g_wc_cs_comp  #161108-00037#7 add
   END IF
#160802-00020#9-e add
   #end add-point    
 
   LET l_searchcol = "xcfjld,xcfj002,xcfj003,xcfj004"
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
      LET l_sub_sql = " SELECT DISTINCT xcfjld ",
                      ", xcfj002 ",
                      ", xcfj003 ",
                      ", xcfj004 ",
 
                      " FROM xcfj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcfjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcfj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcfjld ",
                      ", xcfj002 ",
                      ", xcfj003 ",
                      ", xcfj004 ",
 
                      " FROM xcfj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcfjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcfj_t")
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
      INITIALIZE g_xcfj_m.* TO NULL
      CALL g_xcfj_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcfjld,t0.xcfj002,t0.xcfj003,t0.xcfj004 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcfjld,t0.xcfj002,t0.xcfj003,t0.xcfj004",
                " FROM xcfj_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcfjent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcfj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
 
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcfj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcfjld,g_browser[g_cnt].b_xcfj002,g_browser[g_cnt].b_xcfj003, 
          g_browser[g_cnt].b_xcfj004 
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
   
   IF cl_null(g_browser[g_cnt].b_xcfjld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcfj_m.* TO NULL
      CALL g_xcfj_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq801_fetch('')
   
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
 
{<section id="axcq801.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq801_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcfj_m.xcfjld = g_browser[g_current_idx].b_xcfjld   
   LET g_xcfj_m.xcfj002 = g_browser[g_current_idx].b_xcfj002   
   LET g_xcfj_m.xcfj003 = g_browser[g_current_idx].b_xcfj003   
   LET g_xcfj_m.xcfj004 = g_browser[g_current_idx].b_xcfj004   
 
   EXECUTE axcq801_master_referesh USING g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004 INTO g_xcfj_m.xcfjcomp, 
       g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfjcomp_desc,g_xcfj_m.xcfjld_desc, 
       g_xcfj_m.xcfj002_desc
   CALL axcq801_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq801_ui_detailshow()
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
 
{<section id="axcq801.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq801_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcfjld = g_xcfj_m.xcfjld 
         AND g_browser[l_i].b_xcfj002 = g_xcfj_m.xcfj002 
         AND g_browser[l_i].b_xcfj003 = g_xcfj_m.xcfj003 
         AND g_browser[l_i].b_xcfj004 = g_xcfj_m.xcfj004 
 
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
 
{<section id="axcq801.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq801_construct()
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
   INITIALIZE g_xcfj_m.* TO NULL
   CALL g_xcfj_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcfjcomp,xcfj003,xcfj004,xcfjld,xcfj002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axcq801_default()
            #end add-point 
            
                 #Ctrlp:construct.c.xcfjcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfjcomp
            #add-point:ON ACTION controlp INFIELD xcfjcomp name="construct.c.xcfjcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF cl_null(g_wc_cs_comp) THEN    #160802-00020#9
               LET g_qryparam.where = " ooef003 = 'Y'"     #160714-00027#1
            #160802-00020#9-s
            ELSE
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#9-e
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfjcomp  #顯示到畫面上
            LET g_xcfjcomp = g_qryparam.return1   #160714-00027#1
            NEXT FIELD xcfjcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfjcomp
            #add-point:BEFORE FIELD xcfjcomp name="construct.b.xcfjcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfjcomp
            
            #add-point:AFTER FIELD xcfjcomp name="construct.a.xcfjcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj003
            #add-point:BEFORE FIELD xcfj003 name="construct.b.xcfj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj003
            
            #add-point:AFTER FIELD xcfj003 name="construct.a.xcfj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj003
            #add-point:ON ACTION controlp INFIELD xcfj003 name="construct.c.xcfj003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj004
            #add-point:BEFORE FIELD xcfj004 name="construct.b.xcfj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj004
            
            #add-point:AFTER FIELD xcfj004 name="construct.a.xcfj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj004
            #add-point:ON ACTION controlp INFIELD xcfj004 name="construct.c.xcfj004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcfjld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfjld
            #add-point:ON ACTION controlp INFIELD xcfjld name="construct.c.xcfjld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#9--mark-s QBE不勾稽
            #160714-00027#1--(S)
            #IF NOT cl_null(g_xcfjcomp) THEN
            #   LET g_qryparam.where = " glaacomp = '",g_xcfjcomp,"'"
            #END IF
            #160714-00027#1--(E)
            #增加帳套過濾條件
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9--mark-e
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfjld  #顯示到畫面上
            NEXT FIELD xcfjld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfjld
            #add-point:BEFORE FIELD xcfjld name="construct.b.xcfjld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfjld
            
            #add-point:AFTER FIELD xcfjld name="construct.a.xcfjld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcfj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj002
            #add-point:ON ACTION controlp INFIELD xcfj002 name="construct.c.xcfj002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfj002  #顯示到畫面上
            NEXT FIELD xcfj002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj002
            #add-point:BEFORE FIELD xcfj002 name="construct.b.xcfj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj002
            
            #add-point:AFTER FIELD xcfj002 name="construct.a.xcfj002"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcfj001,xcfj005,xcfj006,xcfj007,xcfj008,l_qty1,l_amt1,l_rate1,l_idle1, 
          l_qty2,l_amt2,l_rate2,l_idle2,l_qty3,l_amt3,l_rate3,l_idle3,l_qty4,l_amt4,l_rate4,l_idle4, 
          l_qty5,l_amt5,l_rate5,l_idle5,l_qty6,l_amt6,l_rate6,l_idle6,l_qty7,l_amt7,l_rate7,l_idle7, 
          l_qty8,l_amt8,l_rate8,l_idle8,l_qty9,l_amt9,l_rate9,l_idle9,l_qty10,l_amt10,l_rate10,l_idle10, 
          l_qty11,l_amt11,l_rate11,l_idle11,l_qty12,l_amt12,l_rate12,l_idle12,l_qty13,l_amt13,l_rate13, 
          l_idle13,l_qty14,l_amt14,l_rate14,l_idle14,l_qty15,l_amt15,l_rate15,l_idle15,l_qty16,l_amt16, 
          l_rate16,l_idle16,l_qty17,l_amt17,l_rate17,l_idle17,l_qty18,l_amt18,l_rate18,l_idle18,l_qty19, 
          l_amt19,l_rate19,l_idle19,l_qty20,l_amt20,l_rate20,l_idle20
           FROM s_detail1[1].xcfj001,s_detail1[1].xcfj005,s_detail1[1].xcfj006,s_detail1[1].xcfj007, 
               s_detail1[1].xcfj008,s_detail1[1].l_qty1,s_detail1[1].l_amt1,s_detail1[1].l_rate1,s_detail1[1].l_idle1, 
               s_detail1[1].l_qty2,s_detail1[1].l_amt2,s_detail1[1].l_rate2,s_detail1[1].l_idle2,s_detail1[1].l_qty3, 
               s_detail1[1].l_amt3,s_detail1[1].l_rate3,s_detail1[1].l_idle3,s_detail1[1].l_qty4,s_detail1[1].l_amt4, 
               s_detail1[1].l_rate4,s_detail1[1].l_idle4,s_detail1[1].l_qty5,s_detail1[1].l_amt5,s_detail1[1].l_rate5, 
               s_detail1[1].l_idle5,s_detail1[1].l_qty6,s_detail1[1].l_amt6,s_detail1[1].l_rate6,s_detail1[1].l_idle6, 
               s_detail1[1].l_qty7,s_detail1[1].l_amt7,s_detail1[1].l_rate7,s_detail1[1].l_idle7,s_detail1[1].l_qty8, 
               s_detail1[1].l_amt8,s_detail1[1].l_rate8,s_detail1[1].l_idle8,s_detail1[1].l_qty9,s_detail1[1].l_amt9, 
               s_detail1[1].l_rate9,s_detail1[1].l_idle9,s_detail1[1].l_qty10,s_detail1[1].l_amt10,s_detail1[1].l_rate10, 
               s_detail1[1].l_idle10,s_detail1[1].l_qty11,s_detail1[1].l_amt11,s_detail1[1].l_rate11, 
               s_detail1[1].l_idle11,s_detail1[1].l_qty12,s_detail1[1].l_amt12,s_detail1[1].l_rate12, 
               s_detail1[1].l_idle12,s_detail1[1].l_qty13,s_detail1[1].l_amt13,s_detail1[1].l_rate13, 
               s_detail1[1].l_idle13,s_detail1[1].l_qty14,s_detail1[1].l_amt14,s_detail1[1].l_rate14, 
               s_detail1[1].l_idle14,s_detail1[1].l_qty15,s_detail1[1].l_amt15,s_detail1[1].l_rate15, 
               s_detail1[1].l_idle15,s_detail1[1].l_qty16,s_detail1[1].l_amt16,s_detail1[1].l_rate16, 
               s_detail1[1].l_idle16,s_detail1[1].l_qty17,s_detail1[1].l_amt17,s_detail1[1].l_rate17, 
               s_detail1[1].l_idle17,s_detail1[1].l_qty18,s_detail1[1].l_amt18,s_detail1[1].l_rate18, 
               s_detail1[1].l_idle18,s_detail1[1].l_qty19,s_detail1[1].l_amt19,s_detail1[1].l_rate19, 
               s_detail1[1].l_idle19,s_detail1[1].l_qty20,s_detail1[1].l_amt20,s_detail1[1].l_rate20, 
               s_detail1[1].l_idle20
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.xcfj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj001
            #add-point:ON ACTION controlp INFIELD xcfj001 name="construct.c.page1.xcfj001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfj001  #顯示到畫面上
            NEXT FIELD xcfj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj001
            #add-point:BEFORE FIELD xcfj001 name="construct.b.page1.xcfj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj001
            
            #add-point:AFTER FIELD xcfj001 name="construct.a.page1.xcfj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj005
            #add-point:ON ACTION controlp INFIELD xcfj005 name="construct.c.page1.xcfj005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfj005  #顯示到畫面上
            NEXT FIELD xcfj005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj005
            #add-point:BEFORE FIELD xcfj005 name="construct.b.page1.xcfj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj005
            
            #add-point:AFTER FIELD xcfj005 name="construct.a.page1.xcfj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj006
            #add-point:ON ACTION controlp INFIELD xcfj006 name="construct.c.page1.xcfj006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfj006  #顯示到畫面上
            NEXT FIELD xcfj006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj006
            #add-point:BEFORE FIELD xcfj006 name="construct.b.page1.xcfj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj006
            
            #add-point:AFTER FIELD xcfj006 name="construct.a.page1.xcfj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj007
            #add-point:ON ACTION controlp INFIELD xcfj007 name="construct.c.page1.xcfj007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcfj007  #顯示到畫面上
            NEXT FIELD xcfj007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj007
            #add-point:BEFORE FIELD xcfj007 name="construct.b.page1.xcfj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj007
            
            #add-point:AFTER FIELD xcfj007 name="construct.a.page1.xcfj007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj008
            #add-point:BEFORE FIELD xcfj008 name="construct.b.page1.xcfj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj008
            
            #add-point:AFTER FIELD xcfj008 name="construct.a.page1.xcfj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcfj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj008
            #add-point:ON ACTION controlp INFIELD xcfj008 name="construct.c.page1.xcfj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle
            #add-point:BEFORE FIELD l_idle name="construct.b.page1.l_idle"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle
            
            #add-point:AFTER FIELD l_idle name="construct.a.page1.l_idle"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle
            #add-point:ON ACTION controlp INFIELD l_idle name="construct.c.page1.l_idle"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty1
            #add-point:BEFORE FIELD l_qty1 name="construct.b.page1.l_qty1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty1
            
            #add-point:AFTER FIELD l_qty1 name="construct.a.page1.l_qty1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty1
            #add-point:ON ACTION controlp INFIELD l_qty1 name="construct.c.page1.l_qty1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt1
            #add-point:BEFORE FIELD l_amt1 name="construct.b.page1.l_amt1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt1
            
            #add-point:AFTER FIELD l_amt1 name="construct.a.page1.l_amt1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt1
            #add-point:ON ACTION controlp INFIELD l_amt1 name="construct.c.page1.l_amt1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate1
            #add-point:BEFORE FIELD l_rate1 name="construct.b.page1.l_rate1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate1
            
            #add-point:AFTER FIELD l_rate1 name="construct.a.page1.l_rate1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate1
            #add-point:ON ACTION controlp INFIELD l_rate1 name="construct.c.page1.l_rate1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle1
            #add-point:BEFORE FIELD l_idle1 name="construct.b.page1.l_idle1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle1
            
            #add-point:AFTER FIELD l_idle1 name="construct.a.page1.l_idle1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle1
            #add-point:ON ACTION controlp INFIELD l_idle1 name="construct.c.page1.l_idle1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty2
            #add-point:BEFORE FIELD l_qty2 name="construct.b.page1.l_qty2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty2
            
            #add-point:AFTER FIELD l_qty2 name="construct.a.page1.l_qty2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty2
            #add-point:ON ACTION controlp INFIELD l_qty2 name="construct.c.page1.l_qty2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt2
            #add-point:BEFORE FIELD l_amt2 name="construct.b.page1.l_amt2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt2
            
            #add-point:AFTER FIELD l_amt2 name="construct.a.page1.l_amt2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt2
            #add-point:ON ACTION controlp INFIELD l_amt2 name="construct.c.page1.l_amt2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate2
            #add-point:BEFORE FIELD l_rate2 name="construct.b.page1.l_rate2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate2
            
            #add-point:AFTER FIELD l_rate2 name="construct.a.page1.l_rate2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate2
            #add-point:ON ACTION controlp INFIELD l_rate2 name="construct.c.page1.l_rate2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle2
            #add-point:BEFORE FIELD l_idle2 name="construct.b.page1.l_idle2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle2
            
            #add-point:AFTER FIELD l_idle2 name="construct.a.page1.l_idle2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle2
            #add-point:ON ACTION controlp INFIELD l_idle2 name="construct.c.page1.l_idle2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty3
            #add-point:BEFORE FIELD l_qty3 name="construct.b.page1.l_qty3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty3
            
            #add-point:AFTER FIELD l_qty3 name="construct.a.page1.l_qty3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty3
            #add-point:ON ACTION controlp INFIELD l_qty3 name="construct.c.page1.l_qty3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt3
            #add-point:BEFORE FIELD l_amt3 name="construct.b.page1.l_amt3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt3
            
            #add-point:AFTER FIELD l_amt3 name="construct.a.page1.l_amt3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt3
            #add-point:ON ACTION controlp INFIELD l_amt3 name="construct.c.page1.l_amt3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate3
            #add-point:BEFORE FIELD l_rate3 name="construct.b.page1.l_rate3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate3
            
            #add-point:AFTER FIELD l_rate3 name="construct.a.page1.l_rate3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate3
            #add-point:ON ACTION controlp INFIELD l_rate3 name="construct.c.page1.l_rate3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle3
            #add-point:BEFORE FIELD l_idle3 name="construct.b.page1.l_idle3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle3
            
            #add-point:AFTER FIELD l_idle3 name="construct.a.page1.l_idle3"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle3
            #add-point:ON ACTION controlp INFIELD l_idle3 name="construct.c.page1.l_idle3"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty4
            #add-point:BEFORE FIELD l_qty4 name="construct.b.page1.l_qty4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty4
            
            #add-point:AFTER FIELD l_qty4 name="construct.a.page1.l_qty4"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty4
            #add-point:ON ACTION controlp INFIELD l_qty4 name="construct.c.page1.l_qty4"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt4
            #add-point:BEFORE FIELD l_amt4 name="construct.b.page1.l_amt4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt4
            
            #add-point:AFTER FIELD l_amt4 name="construct.a.page1.l_amt4"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt4
            #add-point:ON ACTION controlp INFIELD l_amt4 name="construct.c.page1.l_amt4"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate4
            #add-point:BEFORE FIELD l_rate4 name="construct.b.page1.l_rate4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate4
            
            #add-point:AFTER FIELD l_rate4 name="construct.a.page1.l_rate4"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate4
            #add-point:ON ACTION controlp INFIELD l_rate4 name="construct.c.page1.l_rate4"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle4
            #add-point:BEFORE FIELD l_idle4 name="construct.b.page1.l_idle4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle4
            
            #add-point:AFTER FIELD l_idle4 name="construct.a.page1.l_idle4"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle4
            #add-point:ON ACTION controlp INFIELD l_idle4 name="construct.c.page1.l_idle4"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty5
            #add-point:BEFORE FIELD l_qty5 name="construct.b.page1.l_qty5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty5
            
            #add-point:AFTER FIELD l_qty5 name="construct.a.page1.l_qty5"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty5
            #add-point:ON ACTION controlp INFIELD l_qty5 name="construct.c.page1.l_qty5"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt5
            #add-point:BEFORE FIELD l_amt5 name="construct.b.page1.l_amt5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt5
            
            #add-point:AFTER FIELD l_amt5 name="construct.a.page1.l_amt5"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt5
            #add-point:ON ACTION controlp INFIELD l_amt5 name="construct.c.page1.l_amt5"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate5
            #add-point:BEFORE FIELD l_rate5 name="construct.b.page1.l_rate5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate5
            
            #add-point:AFTER FIELD l_rate5 name="construct.a.page1.l_rate5"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate5
            #add-point:ON ACTION controlp INFIELD l_rate5 name="construct.c.page1.l_rate5"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle5
            #add-point:BEFORE FIELD l_idle5 name="construct.b.page1.l_idle5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle5
            
            #add-point:AFTER FIELD l_idle5 name="construct.a.page1.l_idle5"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle5
            #add-point:ON ACTION controlp INFIELD l_idle5 name="construct.c.page1.l_idle5"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty6
            #add-point:BEFORE FIELD l_qty6 name="construct.b.page1.l_qty6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty6
            
            #add-point:AFTER FIELD l_qty6 name="construct.a.page1.l_qty6"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty6
            #add-point:ON ACTION controlp INFIELD l_qty6 name="construct.c.page1.l_qty6"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt6
            #add-point:BEFORE FIELD l_amt6 name="construct.b.page1.l_amt6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt6
            
            #add-point:AFTER FIELD l_amt6 name="construct.a.page1.l_amt6"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt6
            #add-point:ON ACTION controlp INFIELD l_amt6 name="construct.c.page1.l_amt6"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate6
            #add-point:BEFORE FIELD l_rate6 name="construct.b.page1.l_rate6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate6
            
            #add-point:AFTER FIELD l_rate6 name="construct.a.page1.l_rate6"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate6
            #add-point:ON ACTION controlp INFIELD l_rate6 name="construct.c.page1.l_rate6"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle6
            #add-point:BEFORE FIELD l_idle6 name="construct.b.page1.l_idle6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle6
            
            #add-point:AFTER FIELD l_idle6 name="construct.a.page1.l_idle6"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle6
            #add-point:ON ACTION controlp INFIELD l_idle6 name="construct.c.page1.l_idle6"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty7
            #add-point:BEFORE FIELD l_qty7 name="construct.b.page1.l_qty7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty7
            
            #add-point:AFTER FIELD l_qty7 name="construct.a.page1.l_qty7"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty7
            #add-point:ON ACTION controlp INFIELD l_qty7 name="construct.c.page1.l_qty7"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt7
            #add-point:BEFORE FIELD l_amt7 name="construct.b.page1.l_amt7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt7
            
            #add-point:AFTER FIELD l_amt7 name="construct.a.page1.l_amt7"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt7
            #add-point:ON ACTION controlp INFIELD l_amt7 name="construct.c.page1.l_amt7"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate7
            #add-point:BEFORE FIELD l_rate7 name="construct.b.page1.l_rate7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate7
            
            #add-point:AFTER FIELD l_rate7 name="construct.a.page1.l_rate7"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate7
            #add-point:ON ACTION controlp INFIELD l_rate7 name="construct.c.page1.l_rate7"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle7
            #add-point:BEFORE FIELD l_idle7 name="construct.b.page1.l_idle7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle7
            
            #add-point:AFTER FIELD l_idle7 name="construct.a.page1.l_idle7"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle7
            #add-point:ON ACTION controlp INFIELD l_idle7 name="construct.c.page1.l_idle7"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty8
            #add-point:BEFORE FIELD l_qty8 name="construct.b.page1.l_qty8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty8
            
            #add-point:AFTER FIELD l_qty8 name="construct.a.page1.l_qty8"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty8
            #add-point:ON ACTION controlp INFIELD l_qty8 name="construct.c.page1.l_qty8"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt8
            #add-point:BEFORE FIELD l_amt8 name="construct.b.page1.l_amt8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt8
            
            #add-point:AFTER FIELD l_amt8 name="construct.a.page1.l_amt8"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt8
            #add-point:ON ACTION controlp INFIELD l_amt8 name="construct.c.page1.l_amt8"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate8
            #add-point:BEFORE FIELD l_rate8 name="construct.b.page1.l_rate8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate8
            
            #add-point:AFTER FIELD l_rate8 name="construct.a.page1.l_rate8"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate8
            #add-point:ON ACTION controlp INFIELD l_rate8 name="construct.c.page1.l_rate8"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle8
            #add-point:BEFORE FIELD l_idle8 name="construct.b.page1.l_idle8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle8
            
            #add-point:AFTER FIELD l_idle8 name="construct.a.page1.l_idle8"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle8
            #add-point:ON ACTION controlp INFIELD l_idle8 name="construct.c.page1.l_idle8"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty9
            #add-point:BEFORE FIELD l_qty9 name="construct.b.page1.l_qty9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty9
            
            #add-point:AFTER FIELD l_qty9 name="construct.a.page1.l_qty9"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty9
            #add-point:ON ACTION controlp INFIELD l_qty9 name="construct.c.page1.l_qty9"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt9
            #add-point:BEFORE FIELD l_amt9 name="construct.b.page1.l_amt9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt9
            
            #add-point:AFTER FIELD l_amt9 name="construct.a.page1.l_amt9"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt9
            #add-point:ON ACTION controlp INFIELD l_amt9 name="construct.c.page1.l_amt9"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate9
            #add-point:BEFORE FIELD l_rate9 name="construct.b.page1.l_rate9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate9
            
            #add-point:AFTER FIELD l_rate9 name="construct.a.page1.l_rate9"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate9
            #add-point:ON ACTION controlp INFIELD l_rate9 name="construct.c.page1.l_rate9"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle9
            #add-point:BEFORE FIELD l_idle9 name="construct.b.page1.l_idle9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle9
            
            #add-point:AFTER FIELD l_idle9 name="construct.a.page1.l_idle9"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle9
            #add-point:ON ACTION controlp INFIELD l_idle9 name="construct.c.page1.l_idle9"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty10
            #add-point:BEFORE FIELD l_qty10 name="construct.b.page1.l_qty10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty10
            
            #add-point:AFTER FIELD l_qty10 name="construct.a.page1.l_qty10"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty10
            #add-point:ON ACTION controlp INFIELD l_qty10 name="construct.c.page1.l_qty10"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt10
            #add-point:BEFORE FIELD l_amt10 name="construct.b.page1.l_amt10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt10
            
            #add-point:AFTER FIELD l_amt10 name="construct.a.page1.l_amt10"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt10
            #add-point:ON ACTION controlp INFIELD l_amt10 name="construct.c.page1.l_amt10"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate10
            #add-point:BEFORE FIELD l_rate10 name="construct.b.page1.l_rate10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate10
            
            #add-point:AFTER FIELD l_rate10 name="construct.a.page1.l_rate10"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate10
            #add-point:ON ACTION controlp INFIELD l_rate10 name="construct.c.page1.l_rate10"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle10
            #add-point:BEFORE FIELD l_idle10 name="construct.b.page1.l_idle10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle10
            
            #add-point:AFTER FIELD l_idle10 name="construct.a.page1.l_idle10"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle10
            #add-point:ON ACTION controlp INFIELD l_idle10 name="construct.c.page1.l_idle10"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty11
            #add-point:BEFORE FIELD l_qty11 name="construct.b.page1.l_qty11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty11
            
            #add-point:AFTER FIELD l_qty11 name="construct.a.page1.l_qty11"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty11
            #add-point:ON ACTION controlp INFIELD l_qty11 name="construct.c.page1.l_qty11"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt11
            #add-point:BEFORE FIELD l_amt11 name="construct.b.page1.l_amt11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt11
            
            #add-point:AFTER FIELD l_amt11 name="construct.a.page1.l_amt11"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt11
            #add-point:ON ACTION controlp INFIELD l_amt11 name="construct.c.page1.l_amt11"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate11
            #add-point:BEFORE FIELD l_rate11 name="construct.b.page1.l_rate11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate11
            
            #add-point:AFTER FIELD l_rate11 name="construct.a.page1.l_rate11"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate11
            #add-point:ON ACTION controlp INFIELD l_rate11 name="construct.c.page1.l_rate11"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle11
            #add-point:BEFORE FIELD l_idle11 name="construct.b.page1.l_idle11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle11
            
            #add-point:AFTER FIELD l_idle11 name="construct.a.page1.l_idle11"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle11
            #add-point:ON ACTION controlp INFIELD l_idle11 name="construct.c.page1.l_idle11"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty12
            #add-point:BEFORE FIELD l_qty12 name="construct.b.page1.l_qty12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty12
            
            #add-point:AFTER FIELD l_qty12 name="construct.a.page1.l_qty12"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty12
            #add-point:ON ACTION controlp INFIELD l_qty12 name="construct.c.page1.l_qty12"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt12
            #add-point:BEFORE FIELD l_amt12 name="construct.b.page1.l_amt12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt12
            
            #add-point:AFTER FIELD l_amt12 name="construct.a.page1.l_amt12"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt12
            #add-point:ON ACTION controlp INFIELD l_amt12 name="construct.c.page1.l_amt12"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate12
            #add-point:BEFORE FIELD l_rate12 name="construct.b.page1.l_rate12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate12
            
            #add-point:AFTER FIELD l_rate12 name="construct.a.page1.l_rate12"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate12
            #add-point:ON ACTION controlp INFIELD l_rate12 name="construct.c.page1.l_rate12"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle12
            #add-point:BEFORE FIELD l_idle12 name="construct.b.page1.l_idle12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle12
            
            #add-point:AFTER FIELD l_idle12 name="construct.a.page1.l_idle12"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle12
            #add-point:ON ACTION controlp INFIELD l_idle12 name="construct.c.page1.l_idle12"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty13
            #add-point:BEFORE FIELD l_qty13 name="construct.b.page1.l_qty13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty13
            
            #add-point:AFTER FIELD l_qty13 name="construct.a.page1.l_qty13"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty13
            #add-point:ON ACTION controlp INFIELD l_qty13 name="construct.c.page1.l_qty13"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt13
            #add-point:BEFORE FIELD l_amt13 name="construct.b.page1.l_amt13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt13
            
            #add-point:AFTER FIELD l_amt13 name="construct.a.page1.l_amt13"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt13
            #add-point:ON ACTION controlp INFIELD l_amt13 name="construct.c.page1.l_amt13"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate13
            #add-point:BEFORE FIELD l_rate13 name="construct.b.page1.l_rate13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate13
            
            #add-point:AFTER FIELD l_rate13 name="construct.a.page1.l_rate13"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate13
            #add-point:ON ACTION controlp INFIELD l_rate13 name="construct.c.page1.l_rate13"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle13
            #add-point:BEFORE FIELD l_idle13 name="construct.b.page1.l_idle13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle13
            
            #add-point:AFTER FIELD l_idle13 name="construct.a.page1.l_idle13"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle13
            #add-point:ON ACTION controlp INFIELD l_idle13 name="construct.c.page1.l_idle13"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty14
            #add-point:BEFORE FIELD l_qty14 name="construct.b.page1.l_qty14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty14
            
            #add-point:AFTER FIELD l_qty14 name="construct.a.page1.l_qty14"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty14
            #add-point:ON ACTION controlp INFIELD l_qty14 name="construct.c.page1.l_qty14"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt14
            #add-point:BEFORE FIELD l_amt14 name="construct.b.page1.l_amt14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt14
            
            #add-point:AFTER FIELD l_amt14 name="construct.a.page1.l_amt14"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt14
            #add-point:ON ACTION controlp INFIELD l_amt14 name="construct.c.page1.l_amt14"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate14
            #add-point:BEFORE FIELD l_rate14 name="construct.b.page1.l_rate14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate14
            
            #add-point:AFTER FIELD l_rate14 name="construct.a.page1.l_rate14"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate14
            #add-point:ON ACTION controlp INFIELD l_rate14 name="construct.c.page1.l_rate14"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle14
            #add-point:BEFORE FIELD l_idle14 name="construct.b.page1.l_idle14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle14
            
            #add-point:AFTER FIELD l_idle14 name="construct.a.page1.l_idle14"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle14
            #add-point:ON ACTION controlp INFIELD l_idle14 name="construct.c.page1.l_idle14"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty15
            #add-point:BEFORE FIELD l_qty15 name="construct.b.page1.l_qty15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty15
            
            #add-point:AFTER FIELD l_qty15 name="construct.a.page1.l_qty15"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty15
            #add-point:ON ACTION controlp INFIELD l_qty15 name="construct.c.page1.l_qty15"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt15
            #add-point:BEFORE FIELD l_amt15 name="construct.b.page1.l_amt15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt15
            
            #add-point:AFTER FIELD l_amt15 name="construct.a.page1.l_amt15"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt15
            #add-point:ON ACTION controlp INFIELD l_amt15 name="construct.c.page1.l_amt15"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate15
            #add-point:BEFORE FIELD l_rate15 name="construct.b.page1.l_rate15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate15
            
            #add-point:AFTER FIELD l_rate15 name="construct.a.page1.l_rate15"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate15
            #add-point:ON ACTION controlp INFIELD l_rate15 name="construct.c.page1.l_rate15"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle15
            #add-point:BEFORE FIELD l_idle15 name="construct.b.page1.l_idle15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle15
            
            #add-point:AFTER FIELD l_idle15 name="construct.a.page1.l_idle15"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle15
            #add-point:ON ACTION controlp INFIELD l_idle15 name="construct.c.page1.l_idle15"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty16
            #add-point:BEFORE FIELD l_qty16 name="construct.b.page1.l_qty16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty16
            
            #add-point:AFTER FIELD l_qty16 name="construct.a.page1.l_qty16"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty16
            #add-point:ON ACTION controlp INFIELD l_qty16 name="construct.c.page1.l_qty16"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt16
            #add-point:BEFORE FIELD l_amt16 name="construct.b.page1.l_amt16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt16
            
            #add-point:AFTER FIELD l_amt16 name="construct.a.page1.l_amt16"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt16
            #add-point:ON ACTION controlp INFIELD l_amt16 name="construct.c.page1.l_amt16"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate16
            #add-point:BEFORE FIELD l_rate16 name="construct.b.page1.l_rate16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate16
            
            #add-point:AFTER FIELD l_rate16 name="construct.a.page1.l_rate16"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate16
            #add-point:ON ACTION controlp INFIELD l_rate16 name="construct.c.page1.l_rate16"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle16
            #add-point:BEFORE FIELD l_idle16 name="construct.b.page1.l_idle16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle16
            
            #add-point:AFTER FIELD l_idle16 name="construct.a.page1.l_idle16"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle16
            #add-point:ON ACTION controlp INFIELD l_idle16 name="construct.c.page1.l_idle16"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty17
            #add-point:BEFORE FIELD l_qty17 name="construct.b.page1.l_qty17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty17
            
            #add-point:AFTER FIELD l_qty17 name="construct.a.page1.l_qty17"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty17
            #add-point:ON ACTION controlp INFIELD l_qty17 name="construct.c.page1.l_qty17"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt17
            #add-point:BEFORE FIELD l_amt17 name="construct.b.page1.l_amt17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt17
            
            #add-point:AFTER FIELD l_amt17 name="construct.a.page1.l_amt17"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt17
            #add-point:ON ACTION controlp INFIELD l_amt17 name="construct.c.page1.l_amt17"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate17
            #add-point:BEFORE FIELD l_rate17 name="construct.b.page1.l_rate17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate17
            
            #add-point:AFTER FIELD l_rate17 name="construct.a.page1.l_rate17"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate17
            #add-point:ON ACTION controlp INFIELD l_rate17 name="construct.c.page1.l_rate17"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle17
            #add-point:BEFORE FIELD l_idle17 name="construct.b.page1.l_idle17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle17
            
            #add-point:AFTER FIELD l_idle17 name="construct.a.page1.l_idle17"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle17
            #add-point:ON ACTION controlp INFIELD l_idle17 name="construct.c.page1.l_idle17"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty18
            #add-point:BEFORE FIELD l_qty18 name="construct.b.page1.l_qty18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty18
            
            #add-point:AFTER FIELD l_qty18 name="construct.a.page1.l_qty18"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty18
            #add-point:ON ACTION controlp INFIELD l_qty18 name="construct.c.page1.l_qty18"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt18
            #add-point:BEFORE FIELD l_amt18 name="construct.b.page1.l_amt18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt18
            
            #add-point:AFTER FIELD l_amt18 name="construct.a.page1.l_amt18"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt18
            #add-point:ON ACTION controlp INFIELD l_amt18 name="construct.c.page1.l_amt18"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate18
            #add-point:BEFORE FIELD l_rate18 name="construct.b.page1.l_rate18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate18
            
            #add-point:AFTER FIELD l_rate18 name="construct.a.page1.l_rate18"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate18
            #add-point:ON ACTION controlp INFIELD l_rate18 name="construct.c.page1.l_rate18"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle18
            #add-point:BEFORE FIELD l_idle18 name="construct.b.page1.l_idle18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle18
            
            #add-point:AFTER FIELD l_idle18 name="construct.a.page1.l_idle18"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle18
            #add-point:ON ACTION controlp INFIELD l_idle18 name="construct.c.page1.l_idle18"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty19
            #add-point:BEFORE FIELD l_qty19 name="construct.b.page1.l_qty19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty19
            
            #add-point:AFTER FIELD l_qty19 name="construct.a.page1.l_qty19"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty19
            #add-point:ON ACTION controlp INFIELD l_qty19 name="construct.c.page1.l_qty19"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt19
            #add-point:BEFORE FIELD l_amt19 name="construct.b.page1.l_amt19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt19
            
            #add-point:AFTER FIELD l_amt19 name="construct.a.page1.l_amt19"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt19
            #add-point:ON ACTION controlp INFIELD l_amt19 name="construct.c.page1.l_amt19"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate19
            #add-point:BEFORE FIELD l_rate19 name="construct.b.page1.l_rate19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate19
            
            #add-point:AFTER FIELD l_rate19 name="construct.a.page1.l_rate19"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate19
            #add-point:ON ACTION controlp INFIELD l_rate19 name="construct.c.page1.l_rate19"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle19
            #add-point:BEFORE FIELD l_idle19 name="construct.b.page1.l_idle19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle19
            
            #add-point:AFTER FIELD l_idle19 name="construct.a.page1.l_idle19"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle19
            #add-point:ON ACTION controlp INFIELD l_idle19 name="construct.c.page1.l_idle19"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty20
            #add-point:BEFORE FIELD l_qty20 name="construct.b.page1.l_qty20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty20
            
            #add-point:AFTER FIELD l_qty20 name="construct.a.page1.l_qty20"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty20
            #add-point:ON ACTION controlp INFIELD l_qty20 name="construct.c.page1.l_qty20"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt20
            #add-point:BEFORE FIELD l_amt20 name="construct.b.page1.l_amt20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt20
            
            #add-point:AFTER FIELD l_amt20 name="construct.a.page1.l_amt20"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_amt20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt20
            #add-point:ON ACTION controlp INFIELD l_amt20 name="construct.c.page1.l_amt20"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate20
            #add-point:BEFORE FIELD l_rate20 name="construct.b.page1.l_rate20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate20
            
            #add-point:AFTER FIELD l_rate20 name="construct.a.page1.l_rate20"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_rate20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate20
            #add-point:ON ACTION controlp INFIELD l_rate20 name="construct.c.page1.l_rate20"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle20
            #add-point:BEFORE FIELD l_idle20 name="construct.b.page1.l_idle20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle20
            
            #add-point:AFTER FIELD l_idle20 name="construct.a.page1.l_idle20"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_idle20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle20
            #add-point:ON ACTION controlp INFIELD l_idle20 name="construct.c.page1.l_idle20"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT BY NAME  g_wc3 ON xcfa004
      END CONSTRUCT
      CONSTRUCT BY NAME  g_wc4 ON xccc001
      END CONSTRUCT
     #161108-00037#7-s-add
      CONSTRUCT BY NAME  g_wc5 ON xcfc013
         ON ACTION controlp INFIELD xcfc013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "201" 
            CALL q_oocq002_02()         
            DISPLAY g_qryparam.return1 TO xcfc013  
            NEXT FIELD xcfc013  
        
      END CONSTRUCT      
     #161108-00037#7-e-add
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         
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
   LET g_xccc001 = cl_replace_str(g_wc4,"xccc001='","")
   LET g_xcfa004 = cl_replace_str(g_wc3,"xcfa004='","")

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
 
{<section id="axcq801.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq801_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
  #161108-00037#7-s-add 
   CALL axcq801_query_1()
   RETURN
  #161108-00037#7-e-add 
   CALL cl_set_comp_visible("l_qty1",FALSE)
   CALL cl_set_comp_visible("l_amt1",FALSE)
   CALL cl_set_comp_visible("l_rate1",FALSE)
   CALL cl_set_comp_visible("l_idle1",FALSE)
   CALL cl_set_comp_visible("l_qty2",FALSE)
   CALL cl_set_comp_visible("l_amt2",FALSE)
   CALL cl_set_comp_visible("l_rate2",FALSE)
   CALL cl_set_comp_visible("l_idle2",FALSE)
   CALL cl_set_comp_visible("l_qty3",FALSE)
   CALL cl_set_comp_visible("l_amt3",FALSE)
   CALL cl_set_comp_visible("l_rate3",FALSE)
   CALL cl_set_comp_visible("l_idle3",FALSE)
   CALL cl_set_comp_visible("l_qty4",FALSE)
   CALL cl_set_comp_visible("l_amt4",FALSE)
   CALL cl_set_comp_visible("l_rate4",FALSE)
   CALL cl_set_comp_visible("l_idle4",FALSE)
   CALL cl_set_comp_visible("l_qty5",FALSE)
   CALL cl_set_comp_visible("l_amt5",FALSE)
   CALL cl_set_comp_visible("l_rate5",FALSE)
   CALL cl_set_comp_visible("l_idle5",FALSE)
   CALL cl_set_comp_visible("l_qty6",FALSE)
   CALL cl_set_comp_visible("l_amt6",FALSE)
   CALL cl_set_comp_visible("l_rate6",FALSE)
   CALL cl_set_comp_visible("l_idle6",FALSE)
   CALL cl_set_comp_visible("l_qty7",FALSE)
   CALL cl_set_comp_visible("l_amt7",FALSE)
   CALL cl_set_comp_visible("l_rate7",FALSE)
   CALL cl_set_comp_visible("l_idle7",FALSE)
   CALL cl_set_comp_visible("l_qty8",FALSE)
   CALL cl_set_comp_visible("l_amt8",FALSE)
   CALL cl_set_comp_visible("l_rate8",FALSE)
   CALL cl_set_comp_visible("l_idle8",FALSE)
   CALL cl_set_comp_visible("l_qty9",FALSE)
   CALL cl_set_comp_visible("l_amt9",FALSE)
   CALL cl_set_comp_visible("l_rate9",FALSE)
   CALL cl_set_comp_visible("l_idle9",FALSE)
   CALL cl_set_comp_visible("l_qty10",FALSE)
   CALL cl_set_comp_visible("l_amt10",FALSE)
   CALL cl_set_comp_visible("l_rate10",FALSE)
   CALL cl_set_comp_visible("l_idle10",FALSE)
   CALL cl_set_comp_visible("l_qty11",FALSE)
   CALL cl_set_comp_visible("l_amt11",FALSE)
   CALL cl_set_comp_visible("l_rate11",FALSE)
   CALL cl_set_comp_visible("l_idle11",FALSE)
   CALL cl_set_comp_visible("l_qty12",FALSE)
   CALL cl_set_comp_visible("l_amt12",FALSE)
   CALL cl_set_comp_visible("l_rate12",FALSE)
   CALL cl_set_comp_visible("l_idle12",FALSE)
   CALL cl_set_comp_visible("l_qty13",FALSE)
   CALL cl_set_comp_visible("l_amt13",FALSE)
   CALL cl_set_comp_visible("l_rate13",FALSE)
   CALL cl_set_comp_visible("l_idle13",FALSE)
   CALL cl_set_comp_visible("l_qty14",FALSE)
   CALL cl_set_comp_visible("l_amt14",FALSE)
   CALL cl_set_comp_visible("l_rate14",FALSE)
   CALL cl_set_comp_visible("l_idle14",FALSE)
   CALL cl_set_comp_visible("l_qty15",FALSE)
   CALL cl_set_comp_visible("l_amt15",FALSE)
   CALL cl_set_comp_visible("l_rate15",FALSE)
   CALL cl_set_comp_visible("l_idle15",FALSE)
   CALL cl_set_comp_visible("l_qty16",FALSE)
   CALL cl_set_comp_visible("l_amt16",FALSE)
   CALL cl_set_comp_visible("l_rate16",FALSE)
   CALL cl_set_comp_visible("l_idle16",FALSE)
   CALL cl_set_comp_visible("l_qty17",FALSE)
   CALL cl_set_comp_visible("l_amt17",FALSE)
   CALL cl_set_comp_visible("l_rate17",FALSE)
   CALL cl_set_comp_visible("l_idle17",FALSE)
   CALL cl_set_comp_visible("l_qty18",FALSE)
   CALL cl_set_comp_visible("l_amt18",FALSE)
   CALL cl_set_comp_visible("l_rate18",FALSE)
   CALL cl_set_comp_visible("l_idle18",FALSE)
   CALL cl_set_comp_visible("l_qty19",FALSE)
   CALL cl_set_comp_visible("l_amt19",FALSE)
   CALL cl_set_comp_visible("l_rate19",FALSE)
   CALL cl_set_comp_visible("l_idle19",FALSE)
   CALL cl_set_comp_visible("l_qty20",FALSE)
   CALL cl_set_comp_visible("l_amt20",FALSE)
   CALL cl_set_comp_visible("l_rate20",FALSE)
   CALL cl_set_comp_visible("l_idle20",FALSE)
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
   CALL g_xcfj_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq801_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq801_browser_fill(g_wc)
      CALL axcq801_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq801_browser_fill("F")
   
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
      CALL axcq801_fetch("F") 
   END IF
   
   CALL axcq801_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq801_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
  #161108-00037#7-s-add 
   CALL axcq801_fetch_1(p_flag) 
   RETURN
  #161108-00037#7-e-add 
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
   
   #CALL axcq801_browser_fill(p_flag)
   
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
   
   LET g_xcfj_m.xcfjld = g_browser[g_current_idx].b_xcfjld
   LET g_xcfj_m.xcfj002 = g_browser[g_current_idx].b_xcfj002
   LET g_xcfj_m.xcfj003 = g_browser[g_current_idx].b_xcfj003
   LET g_xcfj_m.xcfj004 = g_browser[g_current_idx].b_xcfj004
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq801_master_referesh USING g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004 INTO g_xcfj_m.xcfjcomp, 
       g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfjcomp_desc,g_xcfj_m.xcfjld_desc, 
       g_xcfj_m.xcfj002_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcfj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcfj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcfj_m_mask_o.* =  g_xcfj_m.*
   CALL axcq801_xcfj_t_mask()
   LET g_xcfj_m_mask_n.* =  g_xcfj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq801_set_act_visible()
   CALL axcq801_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcfj_m_t.* = g_xcfj_m.*
   LET g_xcfj_m_o.* = g_xcfj_m.*
   
   #重新顯示   
   CALL axcq801_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq801.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq801_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcfj_d.clear()
 
 
   INITIALIZE g_xcfj_m.* TO NULL             #DEFAULT 設定
   LET g_xcfjld_t = NULL
   LET g_xcfj002_t = NULL
   LET g_xcfj003_t = NULL
   LET g_xcfj004_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_xcfj_m.xcfa004 = "1"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq801_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcfj_m.* TO NULL
         INITIALIZE g_xcfj_d TO NULL
 
         CALL axcq801_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcfj_m.* = g_xcfj_m_t.*
         CALL axcq801_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcfj_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq801_set_act_visible()
   CALL axcq801_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcfjld_t = g_xcfj_m.xcfjld
   LET g_xcfj002_t = g_xcfj_m.xcfj002
   LET g_xcfj003_t = g_xcfj_m.xcfj003
   LET g_xcfj004_t = g_xcfj_m.xcfj004
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcfjent = " ||g_enterprise|| " AND",
                      " xcfjld = '", g_xcfj_m.xcfjld, "' "
                      ," AND xcfj002 = '", g_xcfj_m.xcfj002, "' "
                      ," AND xcfj003 = '", g_xcfj_m.xcfj003, "' "
                      ," AND xcfj004 = '", g_xcfj_m.xcfj004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq801_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq801_master_referesh USING g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004 INTO g_xcfj_m.xcfjcomp, 
       g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfjcomp_desc,g_xcfj_m.xcfjld_desc, 
       g_xcfj_m.xcfj002_desc
   
   #遮罩相關處理
   LET g_xcfj_m_mask_o.* =  g_xcfj_m.*
   CALL axcq801_xcfj_t_mask()
   LET g_xcfj_m_mask_n.* =  g_xcfj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcfj_m.xcfjcomp,g_xcfj_m.xcfjcomp_desc,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xccc001, 
       g_xcfj_m.xccc001_desc,g_xcfj_m.xcfc013,g_xcfj_m.xcfc013_desc,g_xcfj_m.xcfjld,g_xcfj_m.xcfjld_desc, 
       g_xcfj_m.xcfj002,g_xcfj_m.xcfj002_desc,g_xcfj_m.xcfa004
   
   #功能已完成,通報訊息中心
   CALL axcq801_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq801_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcfj_m.xcfjld IS NULL
   OR g_xcfj_m.xcfj002 IS NULL
   OR g_xcfj_m.xcfj003 IS NULL
   OR g_xcfj_m.xcfj004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcfjld_t = g_xcfj_m.xcfjld
   LET g_xcfj002_t = g_xcfj_m.xcfj002
   LET g_xcfj003_t = g_xcfj_m.xcfj003
   LET g_xcfj004_t = g_xcfj_m.xcfj004
 
   CALL s_transaction_begin()
   
   OPEN axcq801_cl USING g_enterprise,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq801_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq801_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq801_master_referesh USING g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004 INTO g_xcfj_m.xcfjcomp, 
       g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfjcomp_desc,g_xcfj_m.xcfjld_desc, 
       g_xcfj_m.xcfj002_desc
   
   #遮罩相關處理
   LET g_xcfj_m_mask_o.* =  g_xcfj_m.*
   CALL axcq801_xcfj_t_mask()
   LET g_xcfj_m_mask_n.* =  g_xcfj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq801_show()
   WHILE TRUE
      LET g_xcfjld_t = g_xcfj_m.xcfjld
      LET g_xcfj002_t = g_xcfj_m.xcfj002
      LET g_xcfj003_t = g_xcfj_m.xcfj003
      LET g_xcfj004_t = g_xcfj_m.xcfj004
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq801_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcfj_m.* = g_xcfj_m_t.*
         CALL axcq801_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcfj_m.xcfjld != g_xcfjld_t 
      OR g_xcfj_m.xcfj002 != g_xcfj002_t 
      OR g_xcfj_m.xcfj003 != g_xcfj003_t 
      OR g_xcfj_m.xcfj004 != g_xcfj004_t 
 
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
   CALL axcq801_set_act_visible()
   CALL axcq801_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcfjent = " ||g_enterprise|| " AND",
                      " xcfjld = '", g_xcfj_m.xcfjld, "' "
                      ," AND xcfj002 = '", g_xcfj_m.xcfj002, "' "
                      ," AND xcfj003 = '", g_xcfj_m.xcfj003, "' "
                      ," AND xcfj004 = '", g_xcfj_m.xcfj004, "' "
 
   #填到對應位置
   CALL axcq801_browser_fill("")
 
   CALL axcq801_idx_chk()
 
   CLOSE axcq801_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq801_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq801.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq801_input(p_cmd)
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
   DISPLAY BY NAME g_xcfj_m.xcfjcomp,g_xcfj_m.xcfjcomp_desc,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xccc001, 
       g_xcfj_m.xccc001_desc,g_xcfj_m.xcfc013,g_xcfj_m.xcfc013_desc,g_xcfj_m.xcfjld,g_xcfj_m.xcfjld_desc, 
       g_xcfj_m.xcfj002,g_xcfj_m.xcfj002_desc,g_xcfj_m.xcfa004
   
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
   LET g_forupd_sql = "SELECT xcfj001,xcfj005,xcfj006,xcfj007,xcfj008,xcfj009 FROM xcfj_t WHERE xcfjent=?  
       AND xcfjld=? AND xcfj002=? AND xcfj003=? AND xcfj004=? AND xcfj001=? AND xcfj005=? AND xcfj006=?  
       AND xcfj007=? AND xcfj008=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq801_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq801_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq801_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcfj_m.xcfjcomp,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xccc001,g_xcfj_m.xcfc013, 
       g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfa004
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq801.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcfj_m.xcfjcomp,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xccc001,g_xcfj_m.xcfc013, 
          g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfa004 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfjcomp
            
            #add-point:AFTER FIELD xcfjcomp name="input.a.xcfjcomp"



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfjcomp
            #add-point:BEFORE FIELD xcfjcomp name="input.b.xcfjcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfjcomp
            #add-point:ON CHANGE xcfjcomp name="input.g.xcfjcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj003
            #add-point:BEFORE FIELD xcfj003 name="input.b.xcfj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj003
            
            #add-point:AFTER FIELD xcfj003 name="input.a.xcfj003"



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj003
            #add-point:ON CHANGE xcfj003 name="input.g.xcfj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj004
            #add-point:BEFORE FIELD xcfj004 name="input.b.xcfj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj004
            
            #add-point:AFTER FIELD xcfj004 name="input.a.xcfj004"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj004
            #add-point:ON CHANGE xcfj004 name="input.g.xcfj004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001 name="input.a.xccc001"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001 name="input.b.xccc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc001
            #add-point:ON CHANGE xccc001 name="input.g.xccc001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfc013
            
            #add-point:AFTER FIELD xcfc013 name="input.a.xcfc013"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfc013
            #add-point:BEFORE FIELD xcfc013 name="input.b.xcfc013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfc013
            #add-point:ON CHANGE xcfc013 name="input.g.xcfc013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfjld
            
            #add-point:AFTER FIELD xcfjld name="input.a.xcfjld"



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfjld
            #add-point:BEFORE FIELD xcfjld name="input.b.xcfjld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfjld
            #add-point:ON CHANGE xcfjld name="input.g.xcfjld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj002
            
            #add-point:AFTER FIELD xcfj002 name="input.a.xcfj002"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj002
            #add-point:BEFORE FIELD xcfj002 name="input.b.xcfj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj002
            #add-point:ON CHANGE xcfj002 name="input.g.xcfj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfa004
            #add-point:BEFORE FIELD xcfa004 name="input.b.xcfa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfa004
            
            #add-point:AFTER FIELD xcfa004 name="input.a.xcfa004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfa004
            #add-point:ON CHANGE xcfa004 name="input.g.xcfa004"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcfjcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfjcomp
            #add-point:ON ACTION controlp INFIELD xcfjcomp name="input.c.xcfjcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj003
            #add-point:ON ACTION controlp INFIELD xcfj003 name="input.c.xcfj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj004
            #add-point:ON ACTION controlp INFIELD xcfj004 name="input.c.xcfj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001 name="input.c.xccc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfc013
            #add-point:ON ACTION controlp INFIELD xcfc013 name="input.c.xcfc013"
 
            #END add-point
 
 
         #Ctrlp:input.c.xcfjld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfjld
            #add-point:ON ACTION controlp INFIELD xcfjld name="input.c.xcfjld"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj002
            #add-point:ON ACTION controlp INFIELD xcfj002 name="input.c.xcfj002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcfa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfa004
            #add-point:ON ACTION controlp INFIELD xcfa004 name="input.c.xcfa004"
            
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
            DISPLAY BY NAME g_xcfj_m.xcfjld             
                            ,g_xcfj_m.xcfj002   
                            ,g_xcfj_m.xcfj003   
                            ,g_xcfj_m.xcfj004   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq801_xcfj_t_mask_restore('restore_mask_o')
            
               UPDATE xcfj_t SET (xcfjcomp,xcfj003,xcfj004,xcfjld,xcfj002) = (g_xcfj_m.xcfjcomp,g_xcfj_m.xcfj003, 
                   g_xcfj_m.xcfj004,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002)
                WHERE xcfjent = g_enterprise AND xcfjld = g_xcfjld_t
                  AND xcfj002 = g_xcfj002_t
                  AND xcfj003 = g_xcfj003_t
                  AND xcfj004 = g_xcfj004_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcfj_m.xcfjld
               LET gs_keys_bak[1] = g_xcfjld_t
               LET gs_keys[2] = g_xcfj_m.xcfj002
               LET gs_keys_bak[2] = g_xcfj002_t
               LET gs_keys[3] = g_xcfj_m.xcfj003
               LET gs_keys_bak[3] = g_xcfj003_t
               LET gs_keys[4] = g_xcfj_m.xcfj004
               LET gs_keys_bak[4] = g_xcfj004_t
               LET gs_keys[5] = g_xcfj_d[g_detail_idx].xcfj001
               LET gs_keys_bak[5] = g_xcfj_d_t.xcfj001
               LET gs_keys[6] = g_xcfj_d[g_detail_idx].xcfj005
               LET gs_keys_bak[6] = g_xcfj_d_t.xcfj005
               LET gs_keys[7] = g_xcfj_d[g_detail_idx].xcfj006
               LET gs_keys_bak[7] = g_xcfj_d_t.xcfj006
               LET gs_keys[8] = g_xcfj_d[g_detail_idx].xcfj007
               LET gs_keys_bak[8] = g_xcfj_d_t.xcfj007
               LET gs_keys[9] = g_xcfj_d[g_detail_idx].xcfj008
               LET gs_keys_bak[9] = g_xcfj_d_t.xcfj008
               CALL axcq801_update_b('xcfj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcfj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcfj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq801_xcfj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq801_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcfjld_t = g_xcfj_m.xcfjld
           LET g_xcfj002_t = g_xcfj_m.xcfj002
           LET g_xcfj003_t = g_xcfj_m.xcfj003
           LET g_xcfj004_t = g_xcfj_m.xcfj004
 
           
           IF g_xcfj_d.getLength() = 0 THEN
              NEXT FIELD xcfj001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq801.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcfj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcfj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq801_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            
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
            CALL axcq801_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq801_cl USING g_enterprise,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq801_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq801_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcfj_d[l_ac].xcfj001 IS NOT NULL
               AND g_xcfj_d[l_ac].xcfj005 IS NOT NULL
               AND g_xcfj_d[l_ac].xcfj006 IS NOT NULL
               AND g_xcfj_d[l_ac].xcfj007 IS NOT NULL
               AND g_xcfj_d[l_ac].xcfj008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcfj_d_t.* = g_xcfj_d[l_ac].*  #BACKUP
               LET g_xcfj_d_o.* = g_xcfj_d[l_ac].*  #BACKUP
               CALL axcq801_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq801_set_no_entry_b(l_cmd)
               OPEN axcq801_bcl USING g_enterprise,g_xcfj_m.xcfjld,
                                                g_xcfj_m.xcfj002,
                                                g_xcfj_m.xcfj003,
                                                g_xcfj_m.xcfj004,
 
                                                g_xcfj_d_t.xcfj001
                                                ,g_xcfj_d_t.xcfj005
                                                ,g_xcfj_d_t.xcfj006
                                                ,g_xcfj_d_t.xcfj007
                                                ,g_xcfj_d_t.xcfj008
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq801_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq801_bcl INTO g_xcfj_d[l_ac].xcfj001,g_xcfj_d[l_ac].xcfj005,g_xcfj_d[l_ac].xcfj006, 
                      g_xcfj_d[l_ac].xcfj007,g_xcfj_d[l_ac].xcfj008,g_xcfj_d[l_ac].xcfj009
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcfj_d_t.xcfj001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcfj_d_mask_o[l_ac].* =  g_xcfj_d[l_ac].*
                  CALL axcq801_xcfj_t_mask()
                  LET g_xcfj_d_mask_n[l_ac].* =  g_xcfj_d[l_ac].*
                  
                  CALL axcq801_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xcfj_d_t.* TO NULL
            INITIALIZE g_xcfj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcfj_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xcfj_d[l_ac].xcfj009 = "0"
      LET g_xcfj_d[l_ac].xccc280 = "0"
      LET g_xcfj_d[l_ac].l_amount = "0"
      LET g_xcfj_d[l_ac].l_idle = "0"
      LET g_xcfj_d[l_ac].l_qty1 = "0"
      LET g_xcfj_d[l_ac].l_amt1 = "0"
      LET g_xcfj_d[l_ac].l_idle1 = "0"
      LET g_xcfj_d[l_ac].l_qty2 = "0"
      LET g_xcfj_d[l_ac].l_amt2 = "0"
      LET g_xcfj_d[l_ac].l_idle2 = "0"
      LET g_xcfj_d[l_ac].l_qty3 = "0"
      LET g_xcfj_d[l_ac].l_amt3 = "0"
      LET g_xcfj_d[l_ac].l_idle3 = "0"
      LET g_xcfj_d[l_ac].l_qty4 = "0"
      LET g_xcfj_d[l_ac].l_amt4 = "0"
      LET g_xcfj_d[l_ac].l_idle4 = "0"
      LET g_xcfj_d[l_ac].l_qty5 = "0"
      LET g_xcfj_d[l_ac].l_amt5 = "0"
      LET g_xcfj_d[l_ac].l_idle5 = "0"
      LET g_xcfj_d[l_ac].l_qty6 = "0"
      LET g_xcfj_d[l_ac].l_amt6 = "0"
      LET g_xcfj_d[l_ac].l_idle6 = "0"
      LET g_xcfj_d[l_ac].l_qty7 = "0"
      LET g_xcfj_d[l_ac].l_amt7 = "0"
      LET g_xcfj_d[l_ac].l_idle7 = "0"
      LET g_xcfj_d[l_ac].l_qty8 = "0"
      LET g_xcfj_d[l_ac].l_amt8 = "0"
      LET g_xcfj_d[l_ac].l_idle8 = "0"
      LET g_xcfj_d[l_ac].l_qty9 = "0"
      LET g_xcfj_d[l_ac].l_amt9 = "0"
      LET g_xcfj_d[l_ac].l_idle9 = "0"
      LET g_xcfj_d[l_ac].l_qty10 = "0"
      LET g_xcfj_d[l_ac].l_amt10 = "0"
      LET g_xcfj_d[l_ac].l_idle10 = "0"
      LET g_xcfj_d[l_ac].l_qty11 = "0"
      LET g_xcfj_d[l_ac].l_amt11 = "0"
      LET g_xcfj_d[l_ac].l_idle11 = "0"
      LET g_xcfj_d[l_ac].l_qty12 = "0"
      LET g_xcfj_d[l_ac].l_amt12 = "0"
      LET g_xcfj_d[l_ac].l_idle12 = "0"
      LET g_xcfj_d[l_ac].l_qty13 = "0"
      LET g_xcfj_d[l_ac].l_amt13 = "0"
      LET g_xcfj_d[l_ac].l_idle13 = "0"
      LET g_xcfj_d[l_ac].l_qty14 = "0"
      LET g_xcfj_d[l_ac].l_amt14 = "0"
      LET g_xcfj_d[l_ac].l_idle14 = "0"
      LET g_xcfj_d[l_ac].l_qty15 = "0"
      LET g_xcfj_d[l_ac].l_amt15 = "0"
      LET g_xcfj_d[l_ac].l_idle15 = "0"
      LET g_xcfj_d[l_ac].l_qty16 = "0"
      LET g_xcfj_d[l_ac].l_amt16 = "0"
      LET g_xcfj_d[l_ac].l_idle16 = "0"
      LET g_xcfj_d[l_ac].l_qty17 = "0"
      LET g_xcfj_d[l_ac].l_amt17 = "0"
      LET g_xcfj_d[l_ac].l_idle17 = "0"
      LET g_xcfj_d[l_ac].l_qty18 = "0"
      LET g_xcfj_d[l_ac].l_amt18 = "0"
      LET g_xcfj_d[l_ac].l_idle18 = "0"
      LET g_xcfj_d[l_ac].l_qty19 = "0"
      LET g_xcfj_d[l_ac].l_amt19 = "0"
      LET g_xcfj_d[l_ac].l_idle19 = "0"
      LET g_xcfj_d[l_ac].l_qty20 = "0"
      LET g_xcfj_d[l_ac].l_amt20 = "0"
      LET g_xcfj_d[l_ac].l_idle20 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcfj_d_t.* = g_xcfj_d[l_ac].*     #新輸入資料
            LET g_xcfj_d_o.* = g_xcfj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq801_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcfj_d[li_reproduce_target].* = g_xcfj_d[li_reproduce].*
 
               LET g_xcfj_d[g_xcfj_d.getLength()].xcfj001 = NULL
               LET g_xcfj_d[g_xcfj_d.getLength()].xcfj005 = NULL
               LET g_xcfj_d[g_xcfj_d.getLength()].xcfj006 = NULL
               LET g_xcfj_d[g_xcfj_d.getLength()].xcfj007 = NULL
               LET g_xcfj_d[g_xcfj_d.getLength()].xcfj008 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xcfj_t 
             WHERE xcfjent = g_enterprise AND xcfjld = g_xcfj_m.xcfjld
               AND xcfj002 = g_xcfj_m.xcfj002
               AND xcfj003 = g_xcfj_m.xcfj003
               AND xcfj004 = g_xcfj_m.xcfj004
 
               AND xcfj001 = g_xcfj_d[l_ac].xcfj001
               AND xcfj005 = g_xcfj_d[l_ac].xcfj005
               AND xcfj006 = g_xcfj_d[l_ac].xcfj006
               AND xcfj007 = g_xcfj_d[l_ac].xcfj007
               AND xcfj008 = g_xcfj_d[l_ac].xcfj008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xcfj_t
                           (xcfjent,
                            xcfjcomp,xcfj003,xcfj004,xcfjld,xcfj002,
                            xcfj001,xcfj005,xcfj006,xcfj007,xcfj008
                            ,xcfj009) 
                     VALUES(g_enterprise,
                            g_xcfj_m.xcfjcomp,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,
                            g_xcfj_d[l_ac].xcfj001,g_xcfj_d[l_ac].xcfj005,g_xcfj_d[l_ac].xcfj006,g_xcfj_d[l_ac].xcfj007, 
                                g_xcfj_d[l_ac].xcfj008
                            ,g_xcfj_d[l_ac].xcfj009)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcfj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcfj_t:",SQLERRMESSAGE 
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
               IF axcq801_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcfj_m.xcfjld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfj_m.xcfj002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfj_m.xcfj003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfj_m.xcfj004
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfj_d_t.xcfj001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfj_d_t.xcfj005
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfj_d_t.xcfj006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfj_d_t.xcfj007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcfj_d_t.xcfj008
 
 
                  #刪除下層單身
                  IF NOT axcq801_key_delete_b(gs_keys,'xcfj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq801_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq801_bcl
               LET l_count = g_xcfj_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcfj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfb010
            
            #add-point:AFTER FIELD xcfb010 name="input.a.page1.xcfb010"




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfb010
            #add-point:BEFORE FIELD xcfb010 name="input.b.page1.xcfb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfb010
            #add-point:ON CHANGE xcfb010 name="input.g.page1.xcfb010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="input.a.page1.imaa003"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="input.b.page1.imaa003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa003
            #add-point:ON CHANGE imaa003 name="input.g.page1.imaa003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="input.a.page1.imag011"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="input.b.page1.imag011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imag011
            #add-point:ON CHANGE imag011 name="input.g.page1.imag011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj001
            
            #add-point:AFTER FIELD xcfj001 name="input.a.page1.xcfj001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcfj_m.xcfjld IS NOT NULL AND g_xcfj_m.xcfj002 IS NOT NULL AND g_xcfj_m.xcfj003 IS NOT NULL AND g_xcfj_m.xcfj004 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj007 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj008 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj001 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj005 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcfj_m.xcfjld != g_xcfjld_t OR g_xcfj_m.xcfj002 != g_xcfj002_t OR g_xcfj_m.xcfj003 != g_xcfj003_t OR g_xcfj_m.xcfj004 != g_xcfj004_t OR g_xcfj_d[g_detail_idx].xcfj007 != g_xcfj_d_t.xcfj007 OR g_xcfj_d[g_detail_idx].xcfj008 != g_xcfj_d_t.xcfj008 OR g_xcfj_d[g_detail_idx].xcfj001 != g_xcfj_d_t.xcfj001 OR g_xcfj_d[g_detail_idx].xcfj005 != g_xcfj_d_t.xcfj005 OR g_xcfj_d[g_detail_idx].xcfj006 != g_xcfj_d_t.xcfj006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcfj_t WHERE "||"xcfjent = '" ||g_enterprise|| "' AND "||"xcfjld = '"||g_xcfj_m.xcfjld ||"' AND "|| "xcfj002 = '"||g_xcfj_m.xcfj002 ||"' AND "|| "xcfj003 = '"||g_xcfj_m.xcfj003 ||"' AND "|| "xcfj004 = '"||g_xcfj_m.xcfj004 ||"' AND "|| "xcfj007 = '"||g_xcfj_d[g_detail_idx].xcfj007 ||"' AND "|| "xcfj008 = '"||g_xcfj_d[g_detail_idx].xcfj008 ||"' AND "|| "xcfj001 = '"||g_xcfj_d[g_detail_idx].xcfj001 ||"' AND "|| "xcfj005 = '"||g_xcfj_d[g_detail_idx].xcfj005 ||"' AND "|| "xcfj006 = '"||g_xcfj_d[g_detail_idx].xcfj006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcfj_m.xcfjcomp
            LET g_ref_fields[2] = g_xcfj_d[l_ac].xcfj001
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcfj_d[l_ac].xcfj001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcfj_d[l_ac].xcfj001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj001
            #add-point:BEFORE FIELD xcfj001 name="input.b.page1.xcfj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj001
            #add-point:ON CHANGE xcfj001 name="input.g.page1.xcfj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj005
            
            #add-point:AFTER FIELD xcfj005 name="input.a.page1.xcfj005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcfj_m.xcfjld IS NOT NULL AND g_xcfj_m.xcfj002 IS NOT NULL AND g_xcfj_m.xcfj003 IS NOT NULL AND g_xcfj_m.xcfj004 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj007 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj008 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj001 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj005 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcfj_m.xcfjld != g_xcfjld_t OR g_xcfj_m.xcfj002 != g_xcfj002_t OR g_xcfj_m.xcfj003 != g_xcfj003_t OR g_xcfj_m.xcfj004 != g_xcfj004_t OR g_xcfj_d[g_detail_idx].xcfj007 != g_xcfj_d_t.xcfj007 OR g_xcfj_d[g_detail_idx].xcfj008 != g_xcfj_d_t.xcfj008 OR g_xcfj_d[g_detail_idx].xcfj001 != g_xcfj_d_t.xcfj001 OR g_xcfj_d[g_detail_idx].xcfj005 != g_xcfj_d_t.xcfj005 OR g_xcfj_d[g_detail_idx].xcfj006 != g_xcfj_d_t.xcfj006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcfj_t WHERE "||"xcfjent = '" ||g_enterprise|| "' AND "||"xcfjld = '"||g_xcfj_m.xcfjld ||"' AND "|| "xcfj002 = '"||g_xcfj_m.xcfj002 ||"' AND "|| "xcfj003 = '"||g_xcfj_m.xcfj003 ||"' AND "|| "xcfj004 = '"||g_xcfj_m.xcfj004 ||"' AND "|| "xcfj007 = '"||g_xcfj_d[g_detail_idx].xcfj007 ||"' AND "|| "xcfj008 = '"||g_xcfj_d[g_detail_idx].xcfj008 ||"' AND "|| "xcfj001 = '"||g_xcfj_d[g_detail_idx].xcfj001 ||"' AND "|| "xcfj005 = '"||g_xcfj_d[g_detail_idx].xcfj005 ||"' AND "|| "xcfj006 = '"||g_xcfj_d[g_detail_idx].xcfj006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcfj_d[l_ac].xcfj005
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcfj_d[l_ac].xcfj005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcfj_d[l_ac].xcfj005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj005
            #add-point:BEFORE FIELD xcfj005 name="input.b.page1.xcfj005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj005
            #add-point:ON CHANGE xcfj005 name="input.g.page1.xcfj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj006
            #add-point:BEFORE FIELD xcfj006 name="input.b.page1.xcfj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj006
            
            #add-point:AFTER FIELD xcfj006 name="input.a.page1.xcfj006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcfj_m.xcfjld IS NOT NULL AND g_xcfj_m.xcfj002 IS NOT NULL AND g_xcfj_m.xcfj003 IS NOT NULL AND g_xcfj_m.xcfj004 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj007 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj008 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj001 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj005 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcfj_m.xcfjld != g_xcfjld_t OR g_xcfj_m.xcfj002 != g_xcfj002_t OR g_xcfj_m.xcfj003 != g_xcfj003_t OR g_xcfj_m.xcfj004 != g_xcfj004_t OR g_xcfj_d[g_detail_idx].xcfj007 != g_xcfj_d_t.xcfj007 OR g_xcfj_d[g_detail_idx].xcfj008 != g_xcfj_d_t.xcfj008 OR g_xcfj_d[g_detail_idx].xcfj001 != g_xcfj_d_t.xcfj001 OR g_xcfj_d[g_detail_idx].xcfj005 != g_xcfj_d_t.xcfj005 OR g_xcfj_d[g_detail_idx].xcfj006 != g_xcfj_d_t.xcfj006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcfj_t WHERE "||"xcfjent = '" ||g_enterprise|| "' AND "||"xcfjld = '"||g_xcfj_m.xcfjld ||"' AND "|| "xcfj002 = '"||g_xcfj_m.xcfj002 ||"' AND "|| "xcfj003 = '"||g_xcfj_m.xcfj003 ||"' AND "|| "xcfj004 = '"||g_xcfj_m.xcfj004 ||"' AND "|| "xcfj007 = '"||g_xcfj_d[g_detail_idx].xcfj007 ||"' AND "|| "xcfj008 = '"||g_xcfj_d[g_detail_idx].xcfj008 ||"' AND "|| "xcfj001 = '"||g_xcfj_d[g_detail_idx].xcfj001 ||"' AND "|| "xcfj005 = '"||g_xcfj_d[g_detail_idx].xcfj005 ||"' AND "|| "xcfj006 = '"||g_xcfj_d[g_detail_idx].xcfj006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj006
            #add-point:ON CHANGE xcfj006 name="input.g.page1.xcfj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj007
            #add-point:BEFORE FIELD xcfj007 name="input.b.page1.xcfj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj007
            
            #add-point:AFTER FIELD xcfj007 name="input.a.page1.xcfj007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcfj_m.xcfjld IS NOT NULL AND g_xcfj_m.xcfj002 IS NOT NULL AND g_xcfj_m.xcfj003 IS NOT NULL AND g_xcfj_m.xcfj004 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj007 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj008 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj001 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj005 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcfj_m.xcfjld != g_xcfjld_t OR g_xcfj_m.xcfj002 != g_xcfj002_t OR g_xcfj_m.xcfj003 != g_xcfj003_t OR g_xcfj_m.xcfj004 != g_xcfj004_t OR g_xcfj_d[g_detail_idx].xcfj007 != g_xcfj_d_t.xcfj007 OR g_xcfj_d[g_detail_idx].xcfj008 != g_xcfj_d_t.xcfj008 OR g_xcfj_d[g_detail_idx].xcfj001 != g_xcfj_d_t.xcfj001 OR g_xcfj_d[g_detail_idx].xcfj005 != g_xcfj_d_t.xcfj005 OR g_xcfj_d[g_detail_idx].xcfj006 != g_xcfj_d_t.xcfj006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcfj_t WHERE "||"xcfjent = '" ||g_enterprise|| "' AND "||"xcfjld = '"||g_xcfj_m.xcfjld ||"' AND "|| "xcfj002 = '"||g_xcfj_m.xcfj002 ||"' AND "|| "xcfj003 = '"||g_xcfj_m.xcfj003 ||"' AND "|| "xcfj004 = '"||g_xcfj_m.xcfj004 ||"' AND "|| "xcfj007 = '"||g_xcfj_d[g_detail_idx].xcfj007 ||"' AND "|| "xcfj008 = '"||g_xcfj_d[g_detail_idx].xcfj008 ||"' AND "|| "xcfj001 = '"||g_xcfj_d[g_detail_idx].xcfj001 ||"' AND "|| "xcfj005 = '"||g_xcfj_d[g_detail_idx].xcfj005 ||"' AND "|| "xcfj006 = '"||g_xcfj_d[g_detail_idx].xcfj006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj007
            #add-point:ON CHANGE xcfj007 name="input.g.page1.xcfj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj008
            #add-point:BEFORE FIELD xcfj008 name="input.b.page1.xcfj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj008
            
            #add-point:AFTER FIELD xcfj008 name="input.a.page1.xcfj008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcfj_m.xcfjld IS NOT NULL AND g_xcfj_m.xcfj002 IS NOT NULL AND g_xcfj_m.xcfj003 IS NOT NULL AND g_xcfj_m.xcfj004 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj007 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj008 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj001 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj005 IS NOT NULL AND g_xcfj_d[g_detail_idx].xcfj006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcfj_m.xcfjld != g_xcfjld_t OR g_xcfj_m.xcfj002 != g_xcfj002_t OR g_xcfj_m.xcfj003 != g_xcfj003_t OR g_xcfj_m.xcfj004 != g_xcfj004_t OR g_xcfj_d[g_detail_idx].xcfj007 != g_xcfj_d_t.xcfj007 OR g_xcfj_d[g_detail_idx].xcfj008 != g_xcfj_d_t.xcfj008 OR g_xcfj_d[g_detail_idx].xcfj001 != g_xcfj_d_t.xcfj001 OR g_xcfj_d[g_detail_idx].xcfj005 != g_xcfj_d_t.xcfj005 OR g_xcfj_d[g_detail_idx].xcfj006 != g_xcfj_d_t.xcfj006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcfj_t WHERE "||"xcfjent = '" ||g_enterprise|| "' AND "||"xcfjld = '"||g_xcfj_m.xcfjld ||"' AND "|| "xcfj002 = '"||g_xcfj_m.xcfj002 ||"' AND "|| "xcfj003 = '"||g_xcfj_m.xcfj003 ||"' AND "|| "xcfj004 = '"||g_xcfj_m.xcfj004 ||"' AND "|| "xcfj007 = '"||g_xcfj_d[g_detail_idx].xcfj007 ||"' AND "|| "xcfj008 = '"||g_xcfj_d[g_detail_idx].xcfj008 ||"' AND "|| "xcfj001 = '"||g_xcfj_d[g_detail_idx].xcfj001 ||"' AND "|| "xcfj005 = '"||g_xcfj_d[g_detail_idx].xcfj005 ||"' AND "|| "xcfj006 = '"||g_xcfj_d[g_detail_idx].xcfj006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj008
            #add-point:ON CHANGE xcfj008 name="input.g.page1.xcfj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcfj009
            #add-point:BEFORE FIELD xcfj009 name="input.b.page1.xcfj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcfj009
            
            #add-point:AFTER FIELD xcfj009 name="input.a.page1.xcfj009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcfj009
            #add-point:ON CHANGE xcfj009 name="input.g.page1.xcfj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280
            #add-point:BEFORE FIELD xccc280 name="input.b.page1.xccc280"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280
            
            #add-point:AFTER FIELD xccc280 name="input.a.page1.xccc280"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280
            #add-point:ON CHANGE xccc280 name="input.g.page1.xccc280"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amount
            #add-point:BEFORE FIELD l_amount name="input.b.page1.l_amount"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amount
            
            #add-point:AFTER FIELD l_amount name="input.a.page1.l_amount"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amount
            #add-point:ON CHANGE l_amount name="input.g.page1.l_amount"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle
            #add-point:BEFORE FIELD l_idle name="input.b.page1.l_idle"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle
            
            #add-point:AFTER FIELD l_idle name="input.a.page1.l_idle"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle
            #add-point:ON CHANGE l_idle name="input.g.page1.l_idle"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty1
            #add-point:BEFORE FIELD l_qty1 name="input.b.page1.l_qty1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty1
            
            #add-point:AFTER FIELD l_qty1 name="input.a.page1.l_qty1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty1
            #add-point:ON CHANGE l_qty1 name="input.g.page1.l_qty1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt1
            #add-point:BEFORE FIELD l_amt1 name="input.b.page1.l_amt1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt1
            
            #add-point:AFTER FIELD l_amt1 name="input.a.page1.l_amt1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt1
            #add-point:ON CHANGE l_amt1 name="input.g.page1.l_amt1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate1
            #add-point:BEFORE FIELD l_rate1 name="input.b.page1.l_rate1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate1
            
            #add-point:AFTER FIELD l_rate1 name="input.a.page1.l_rate1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate1
            #add-point:ON CHANGE l_rate1 name="input.g.page1.l_rate1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle1
            #add-point:BEFORE FIELD l_idle1 name="input.b.page1.l_idle1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle1
            
            #add-point:AFTER FIELD l_idle1 name="input.a.page1.l_idle1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle1
            #add-point:ON CHANGE l_idle1 name="input.g.page1.l_idle1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty2
            #add-point:BEFORE FIELD l_qty2 name="input.b.page1.l_qty2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty2
            
            #add-point:AFTER FIELD l_qty2 name="input.a.page1.l_qty2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty2
            #add-point:ON CHANGE l_qty2 name="input.g.page1.l_qty2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt2
            #add-point:BEFORE FIELD l_amt2 name="input.b.page1.l_amt2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt2
            
            #add-point:AFTER FIELD l_amt2 name="input.a.page1.l_amt2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt2
            #add-point:ON CHANGE l_amt2 name="input.g.page1.l_amt2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate2
            #add-point:BEFORE FIELD l_rate2 name="input.b.page1.l_rate2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate2
            
            #add-point:AFTER FIELD l_rate2 name="input.a.page1.l_rate2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate2
            #add-point:ON CHANGE l_rate2 name="input.g.page1.l_rate2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle2
            #add-point:BEFORE FIELD l_idle2 name="input.b.page1.l_idle2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle2
            
            #add-point:AFTER FIELD l_idle2 name="input.a.page1.l_idle2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle2
            #add-point:ON CHANGE l_idle2 name="input.g.page1.l_idle2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty3
            #add-point:BEFORE FIELD l_qty3 name="input.b.page1.l_qty3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty3
            
            #add-point:AFTER FIELD l_qty3 name="input.a.page1.l_qty3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty3
            #add-point:ON CHANGE l_qty3 name="input.g.page1.l_qty3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt3
            #add-point:BEFORE FIELD l_amt3 name="input.b.page1.l_amt3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt3
            
            #add-point:AFTER FIELD l_amt3 name="input.a.page1.l_amt3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt3
            #add-point:ON CHANGE l_amt3 name="input.g.page1.l_amt3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate3
            #add-point:BEFORE FIELD l_rate3 name="input.b.page1.l_rate3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate3
            
            #add-point:AFTER FIELD l_rate3 name="input.a.page1.l_rate3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate3
            #add-point:ON CHANGE l_rate3 name="input.g.page1.l_rate3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle3
            #add-point:BEFORE FIELD l_idle3 name="input.b.page1.l_idle3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle3
            
            #add-point:AFTER FIELD l_idle3 name="input.a.page1.l_idle3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle3
            #add-point:ON CHANGE l_idle3 name="input.g.page1.l_idle3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty4
            #add-point:BEFORE FIELD l_qty4 name="input.b.page1.l_qty4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty4
            
            #add-point:AFTER FIELD l_qty4 name="input.a.page1.l_qty4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty4
            #add-point:ON CHANGE l_qty4 name="input.g.page1.l_qty4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt4
            #add-point:BEFORE FIELD l_amt4 name="input.b.page1.l_amt4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt4
            
            #add-point:AFTER FIELD l_amt4 name="input.a.page1.l_amt4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt4
            #add-point:ON CHANGE l_amt4 name="input.g.page1.l_amt4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate4
            #add-point:BEFORE FIELD l_rate4 name="input.b.page1.l_rate4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate4
            
            #add-point:AFTER FIELD l_rate4 name="input.a.page1.l_rate4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate4
            #add-point:ON CHANGE l_rate4 name="input.g.page1.l_rate4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle4
            #add-point:BEFORE FIELD l_idle4 name="input.b.page1.l_idle4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle4
            
            #add-point:AFTER FIELD l_idle4 name="input.a.page1.l_idle4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle4
            #add-point:ON CHANGE l_idle4 name="input.g.page1.l_idle4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty5
            #add-point:BEFORE FIELD l_qty5 name="input.b.page1.l_qty5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty5
            
            #add-point:AFTER FIELD l_qty5 name="input.a.page1.l_qty5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty5
            #add-point:ON CHANGE l_qty5 name="input.g.page1.l_qty5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt5
            #add-point:BEFORE FIELD l_amt5 name="input.b.page1.l_amt5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt5
            
            #add-point:AFTER FIELD l_amt5 name="input.a.page1.l_amt5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt5
            #add-point:ON CHANGE l_amt5 name="input.g.page1.l_amt5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate5
            #add-point:BEFORE FIELD l_rate5 name="input.b.page1.l_rate5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate5
            
            #add-point:AFTER FIELD l_rate5 name="input.a.page1.l_rate5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate5
            #add-point:ON CHANGE l_rate5 name="input.g.page1.l_rate5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle5
            #add-point:BEFORE FIELD l_idle5 name="input.b.page1.l_idle5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle5
            
            #add-point:AFTER FIELD l_idle5 name="input.a.page1.l_idle5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle5
            #add-point:ON CHANGE l_idle5 name="input.g.page1.l_idle5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty6
            #add-point:BEFORE FIELD l_qty6 name="input.b.page1.l_qty6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty6
            
            #add-point:AFTER FIELD l_qty6 name="input.a.page1.l_qty6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty6
            #add-point:ON CHANGE l_qty6 name="input.g.page1.l_qty6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt6
            #add-point:BEFORE FIELD l_amt6 name="input.b.page1.l_amt6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt6
            
            #add-point:AFTER FIELD l_amt6 name="input.a.page1.l_amt6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt6
            #add-point:ON CHANGE l_amt6 name="input.g.page1.l_amt6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate6
            #add-point:BEFORE FIELD l_rate6 name="input.b.page1.l_rate6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate6
            
            #add-point:AFTER FIELD l_rate6 name="input.a.page1.l_rate6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate6
            #add-point:ON CHANGE l_rate6 name="input.g.page1.l_rate6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle6
            #add-point:BEFORE FIELD l_idle6 name="input.b.page1.l_idle6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle6
            
            #add-point:AFTER FIELD l_idle6 name="input.a.page1.l_idle6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle6
            #add-point:ON CHANGE l_idle6 name="input.g.page1.l_idle6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty7
            #add-point:BEFORE FIELD l_qty7 name="input.b.page1.l_qty7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty7
            
            #add-point:AFTER FIELD l_qty7 name="input.a.page1.l_qty7"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty7
            #add-point:ON CHANGE l_qty7 name="input.g.page1.l_qty7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt7
            #add-point:BEFORE FIELD l_amt7 name="input.b.page1.l_amt7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt7
            
            #add-point:AFTER FIELD l_amt7 name="input.a.page1.l_amt7"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt7
            #add-point:ON CHANGE l_amt7 name="input.g.page1.l_amt7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate7
            #add-point:BEFORE FIELD l_rate7 name="input.b.page1.l_rate7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate7
            
            #add-point:AFTER FIELD l_rate7 name="input.a.page1.l_rate7"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate7
            #add-point:ON CHANGE l_rate7 name="input.g.page1.l_rate7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle7
            #add-point:BEFORE FIELD l_idle7 name="input.b.page1.l_idle7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle7
            
            #add-point:AFTER FIELD l_idle7 name="input.a.page1.l_idle7"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle7
            #add-point:ON CHANGE l_idle7 name="input.g.page1.l_idle7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty8
            #add-point:BEFORE FIELD l_qty8 name="input.b.page1.l_qty8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty8
            
            #add-point:AFTER FIELD l_qty8 name="input.a.page1.l_qty8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty8
            #add-point:ON CHANGE l_qty8 name="input.g.page1.l_qty8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt8
            #add-point:BEFORE FIELD l_amt8 name="input.b.page1.l_amt8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt8
            
            #add-point:AFTER FIELD l_amt8 name="input.a.page1.l_amt8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt8
            #add-point:ON CHANGE l_amt8 name="input.g.page1.l_amt8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate8
            #add-point:BEFORE FIELD l_rate8 name="input.b.page1.l_rate8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate8
            
            #add-point:AFTER FIELD l_rate8 name="input.a.page1.l_rate8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate8
            #add-point:ON CHANGE l_rate8 name="input.g.page1.l_rate8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle8
            #add-point:BEFORE FIELD l_idle8 name="input.b.page1.l_idle8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle8
            
            #add-point:AFTER FIELD l_idle8 name="input.a.page1.l_idle8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle8
            #add-point:ON CHANGE l_idle8 name="input.g.page1.l_idle8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty9
            #add-point:BEFORE FIELD l_qty9 name="input.b.page1.l_qty9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty9
            
            #add-point:AFTER FIELD l_qty9 name="input.a.page1.l_qty9"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty9
            #add-point:ON CHANGE l_qty9 name="input.g.page1.l_qty9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt9
            #add-point:BEFORE FIELD l_amt9 name="input.b.page1.l_amt9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt9
            
            #add-point:AFTER FIELD l_amt9 name="input.a.page1.l_amt9"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt9
            #add-point:ON CHANGE l_amt9 name="input.g.page1.l_amt9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate9
            #add-point:BEFORE FIELD l_rate9 name="input.b.page1.l_rate9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate9
            
            #add-point:AFTER FIELD l_rate9 name="input.a.page1.l_rate9"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate9
            #add-point:ON CHANGE l_rate9 name="input.g.page1.l_rate9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle9
            #add-point:BEFORE FIELD l_idle9 name="input.b.page1.l_idle9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle9
            
            #add-point:AFTER FIELD l_idle9 name="input.a.page1.l_idle9"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle9
            #add-point:ON CHANGE l_idle9 name="input.g.page1.l_idle9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty10
            #add-point:BEFORE FIELD l_qty10 name="input.b.page1.l_qty10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty10
            
            #add-point:AFTER FIELD l_qty10 name="input.a.page1.l_qty10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty10
            #add-point:ON CHANGE l_qty10 name="input.g.page1.l_qty10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt10
            #add-point:BEFORE FIELD l_amt10 name="input.b.page1.l_amt10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt10
            
            #add-point:AFTER FIELD l_amt10 name="input.a.page1.l_amt10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt10
            #add-point:ON CHANGE l_amt10 name="input.g.page1.l_amt10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate10
            #add-point:BEFORE FIELD l_rate10 name="input.b.page1.l_rate10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate10
            
            #add-point:AFTER FIELD l_rate10 name="input.a.page1.l_rate10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate10
            #add-point:ON CHANGE l_rate10 name="input.g.page1.l_rate10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle10
            #add-point:BEFORE FIELD l_idle10 name="input.b.page1.l_idle10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle10
            
            #add-point:AFTER FIELD l_idle10 name="input.a.page1.l_idle10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle10
            #add-point:ON CHANGE l_idle10 name="input.g.page1.l_idle10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty11
            #add-point:BEFORE FIELD l_qty11 name="input.b.page1.l_qty11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty11
            
            #add-point:AFTER FIELD l_qty11 name="input.a.page1.l_qty11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty11
            #add-point:ON CHANGE l_qty11 name="input.g.page1.l_qty11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt11
            #add-point:BEFORE FIELD l_amt11 name="input.b.page1.l_amt11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt11
            
            #add-point:AFTER FIELD l_amt11 name="input.a.page1.l_amt11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt11
            #add-point:ON CHANGE l_amt11 name="input.g.page1.l_amt11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate11
            #add-point:BEFORE FIELD l_rate11 name="input.b.page1.l_rate11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate11
            
            #add-point:AFTER FIELD l_rate11 name="input.a.page1.l_rate11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate11
            #add-point:ON CHANGE l_rate11 name="input.g.page1.l_rate11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle11
            #add-point:BEFORE FIELD l_idle11 name="input.b.page1.l_idle11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle11
            
            #add-point:AFTER FIELD l_idle11 name="input.a.page1.l_idle11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle11
            #add-point:ON CHANGE l_idle11 name="input.g.page1.l_idle11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty12
            #add-point:BEFORE FIELD l_qty12 name="input.b.page1.l_qty12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty12
            
            #add-point:AFTER FIELD l_qty12 name="input.a.page1.l_qty12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty12
            #add-point:ON CHANGE l_qty12 name="input.g.page1.l_qty12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt12
            #add-point:BEFORE FIELD l_amt12 name="input.b.page1.l_amt12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt12
            
            #add-point:AFTER FIELD l_amt12 name="input.a.page1.l_amt12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt12
            #add-point:ON CHANGE l_amt12 name="input.g.page1.l_amt12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate12
            #add-point:BEFORE FIELD l_rate12 name="input.b.page1.l_rate12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate12
            
            #add-point:AFTER FIELD l_rate12 name="input.a.page1.l_rate12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate12
            #add-point:ON CHANGE l_rate12 name="input.g.page1.l_rate12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle12
            #add-point:BEFORE FIELD l_idle12 name="input.b.page1.l_idle12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle12
            
            #add-point:AFTER FIELD l_idle12 name="input.a.page1.l_idle12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle12
            #add-point:ON CHANGE l_idle12 name="input.g.page1.l_idle12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty13
            #add-point:BEFORE FIELD l_qty13 name="input.b.page1.l_qty13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty13
            
            #add-point:AFTER FIELD l_qty13 name="input.a.page1.l_qty13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty13
            #add-point:ON CHANGE l_qty13 name="input.g.page1.l_qty13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt13
            #add-point:BEFORE FIELD l_amt13 name="input.b.page1.l_amt13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt13
            
            #add-point:AFTER FIELD l_amt13 name="input.a.page1.l_amt13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt13
            #add-point:ON CHANGE l_amt13 name="input.g.page1.l_amt13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate13
            #add-point:BEFORE FIELD l_rate13 name="input.b.page1.l_rate13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate13
            
            #add-point:AFTER FIELD l_rate13 name="input.a.page1.l_rate13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate13
            #add-point:ON CHANGE l_rate13 name="input.g.page1.l_rate13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle13
            #add-point:BEFORE FIELD l_idle13 name="input.b.page1.l_idle13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle13
            
            #add-point:AFTER FIELD l_idle13 name="input.a.page1.l_idle13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle13
            #add-point:ON CHANGE l_idle13 name="input.g.page1.l_idle13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty14
            #add-point:BEFORE FIELD l_qty14 name="input.b.page1.l_qty14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty14
            
            #add-point:AFTER FIELD l_qty14 name="input.a.page1.l_qty14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty14
            #add-point:ON CHANGE l_qty14 name="input.g.page1.l_qty14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt14
            #add-point:BEFORE FIELD l_amt14 name="input.b.page1.l_amt14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt14
            
            #add-point:AFTER FIELD l_amt14 name="input.a.page1.l_amt14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt14
            #add-point:ON CHANGE l_amt14 name="input.g.page1.l_amt14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate14
            #add-point:BEFORE FIELD l_rate14 name="input.b.page1.l_rate14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate14
            
            #add-point:AFTER FIELD l_rate14 name="input.a.page1.l_rate14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate14
            #add-point:ON CHANGE l_rate14 name="input.g.page1.l_rate14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle14
            #add-point:BEFORE FIELD l_idle14 name="input.b.page1.l_idle14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle14
            
            #add-point:AFTER FIELD l_idle14 name="input.a.page1.l_idle14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle14
            #add-point:ON CHANGE l_idle14 name="input.g.page1.l_idle14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty15
            #add-point:BEFORE FIELD l_qty15 name="input.b.page1.l_qty15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty15
            
            #add-point:AFTER FIELD l_qty15 name="input.a.page1.l_qty15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty15
            #add-point:ON CHANGE l_qty15 name="input.g.page1.l_qty15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt15
            #add-point:BEFORE FIELD l_amt15 name="input.b.page1.l_amt15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt15
            
            #add-point:AFTER FIELD l_amt15 name="input.a.page1.l_amt15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt15
            #add-point:ON CHANGE l_amt15 name="input.g.page1.l_amt15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate15
            #add-point:BEFORE FIELD l_rate15 name="input.b.page1.l_rate15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate15
            
            #add-point:AFTER FIELD l_rate15 name="input.a.page1.l_rate15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate15
            #add-point:ON CHANGE l_rate15 name="input.g.page1.l_rate15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle15
            #add-point:BEFORE FIELD l_idle15 name="input.b.page1.l_idle15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle15
            
            #add-point:AFTER FIELD l_idle15 name="input.a.page1.l_idle15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle15
            #add-point:ON CHANGE l_idle15 name="input.g.page1.l_idle15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty16
            #add-point:BEFORE FIELD l_qty16 name="input.b.page1.l_qty16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty16
            
            #add-point:AFTER FIELD l_qty16 name="input.a.page1.l_qty16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty16
            #add-point:ON CHANGE l_qty16 name="input.g.page1.l_qty16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt16
            #add-point:BEFORE FIELD l_amt16 name="input.b.page1.l_amt16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt16
            
            #add-point:AFTER FIELD l_amt16 name="input.a.page1.l_amt16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt16
            #add-point:ON CHANGE l_amt16 name="input.g.page1.l_amt16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate16
            #add-point:BEFORE FIELD l_rate16 name="input.b.page1.l_rate16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate16
            
            #add-point:AFTER FIELD l_rate16 name="input.a.page1.l_rate16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate16
            #add-point:ON CHANGE l_rate16 name="input.g.page1.l_rate16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle16
            #add-point:BEFORE FIELD l_idle16 name="input.b.page1.l_idle16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle16
            
            #add-point:AFTER FIELD l_idle16 name="input.a.page1.l_idle16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle16
            #add-point:ON CHANGE l_idle16 name="input.g.page1.l_idle16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty17
            #add-point:BEFORE FIELD l_qty17 name="input.b.page1.l_qty17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty17
            
            #add-point:AFTER FIELD l_qty17 name="input.a.page1.l_qty17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty17
            #add-point:ON CHANGE l_qty17 name="input.g.page1.l_qty17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt17
            #add-point:BEFORE FIELD l_amt17 name="input.b.page1.l_amt17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt17
            
            #add-point:AFTER FIELD l_amt17 name="input.a.page1.l_amt17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt17
            #add-point:ON CHANGE l_amt17 name="input.g.page1.l_amt17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate17
            #add-point:BEFORE FIELD l_rate17 name="input.b.page1.l_rate17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate17
            
            #add-point:AFTER FIELD l_rate17 name="input.a.page1.l_rate17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate17
            #add-point:ON CHANGE l_rate17 name="input.g.page1.l_rate17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle17
            #add-point:BEFORE FIELD l_idle17 name="input.b.page1.l_idle17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle17
            
            #add-point:AFTER FIELD l_idle17 name="input.a.page1.l_idle17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle17
            #add-point:ON CHANGE l_idle17 name="input.g.page1.l_idle17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty18
            #add-point:BEFORE FIELD l_qty18 name="input.b.page1.l_qty18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty18
            
            #add-point:AFTER FIELD l_qty18 name="input.a.page1.l_qty18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty18
            #add-point:ON CHANGE l_qty18 name="input.g.page1.l_qty18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt18
            #add-point:BEFORE FIELD l_amt18 name="input.b.page1.l_amt18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt18
            
            #add-point:AFTER FIELD l_amt18 name="input.a.page1.l_amt18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt18
            #add-point:ON CHANGE l_amt18 name="input.g.page1.l_amt18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate18
            #add-point:BEFORE FIELD l_rate18 name="input.b.page1.l_rate18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate18
            
            #add-point:AFTER FIELD l_rate18 name="input.a.page1.l_rate18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate18
            #add-point:ON CHANGE l_rate18 name="input.g.page1.l_rate18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle18
            #add-point:BEFORE FIELD l_idle18 name="input.b.page1.l_idle18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle18
            
            #add-point:AFTER FIELD l_idle18 name="input.a.page1.l_idle18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle18
            #add-point:ON CHANGE l_idle18 name="input.g.page1.l_idle18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty19
            #add-point:BEFORE FIELD l_qty19 name="input.b.page1.l_qty19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty19
            
            #add-point:AFTER FIELD l_qty19 name="input.a.page1.l_qty19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty19
            #add-point:ON CHANGE l_qty19 name="input.g.page1.l_qty19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt19
            #add-point:BEFORE FIELD l_amt19 name="input.b.page1.l_amt19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt19
            
            #add-point:AFTER FIELD l_amt19 name="input.a.page1.l_amt19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt19
            #add-point:ON CHANGE l_amt19 name="input.g.page1.l_amt19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate19
            #add-point:BEFORE FIELD l_rate19 name="input.b.page1.l_rate19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate19
            
            #add-point:AFTER FIELD l_rate19 name="input.a.page1.l_rate19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate19
            #add-point:ON CHANGE l_rate19 name="input.g.page1.l_rate19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle19
            #add-point:BEFORE FIELD l_idle19 name="input.b.page1.l_idle19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle19
            
            #add-point:AFTER FIELD l_idle19 name="input.a.page1.l_idle19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle19
            #add-point:ON CHANGE l_idle19 name="input.g.page1.l_idle19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty20
            #add-point:BEFORE FIELD l_qty20 name="input.b.page1.l_qty20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty20
            
            #add-point:AFTER FIELD l_qty20 name="input.a.page1.l_qty20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty20
            #add-point:ON CHANGE l_qty20 name="input.g.page1.l_qty20"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_amt20
            #add-point:BEFORE FIELD l_amt20 name="input.b.page1.l_amt20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_amt20
            
            #add-point:AFTER FIELD l_amt20 name="input.a.page1.l_amt20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_amt20
            #add-point:ON CHANGE l_amt20 name="input.g.page1.l_amt20"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_rate20
            #add-point:BEFORE FIELD l_rate20 name="input.b.page1.l_rate20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_rate20
            
            #add-point:AFTER FIELD l_rate20 name="input.a.page1.l_rate20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_rate20
            #add-point:ON CHANGE l_rate20 name="input.g.page1.l_rate20"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_idle20
            #add-point:BEFORE FIELD l_idle20 name="input.b.page1.l_idle20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_idle20
            
            #add-point:AFTER FIELD l_idle20 name="input.a.page1.l_idle20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_idle20
            #add-point:ON CHANGE l_idle20 name="input.g.page1.l_idle20"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcfb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfb010
            #add-point:ON ACTION controlp INFIELD xcfb010 name="input.c.page1.xcfb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="input.c.page1.imaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imag011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="input.c.page1.imag011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj001
            #add-point:ON ACTION controlp INFIELD xcfj001 name="input.c.page1.xcfj001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj005
            #add-point:ON ACTION controlp INFIELD xcfj005 name="input.c.page1.xcfj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj006
            #add-point:ON ACTION controlp INFIELD xcfj006 name="input.c.page1.xcfj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj007
            #add-point:ON ACTION controlp INFIELD xcfj007 name="input.c.page1.xcfj007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj008
            #add-point:ON ACTION controlp INFIELD xcfj008 name="input.c.page1.xcfj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcfj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcfj009
            #add-point:ON ACTION controlp INFIELD xcfj009 name="input.c.page1.xcfj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280
            #add-point:ON ACTION controlp INFIELD xccc280 name="input.c.page1.xccc280"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amount
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amount
            #add-point:ON ACTION controlp INFIELD l_amount name="input.c.page1.l_amount"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle
            #add-point:ON ACTION controlp INFIELD l_idle name="input.c.page1.l_idle"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty1
            #add-point:ON ACTION controlp INFIELD l_qty1 name="input.c.page1.l_qty1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt1
            #add-point:ON ACTION controlp INFIELD l_amt1 name="input.c.page1.l_amt1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate1
            #add-point:ON ACTION controlp INFIELD l_rate1 name="input.c.page1.l_rate1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle1
            #add-point:ON ACTION controlp INFIELD l_idle1 name="input.c.page1.l_idle1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty2
            #add-point:ON ACTION controlp INFIELD l_qty2 name="input.c.page1.l_qty2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt2
            #add-point:ON ACTION controlp INFIELD l_amt2 name="input.c.page1.l_amt2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate2
            #add-point:ON ACTION controlp INFIELD l_rate2 name="input.c.page1.l_rate2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle2
            #add-point:ON ACTION controlp INFIELD l_idle2 name="input.c.page1.l_idle2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty3
            #add-point:ON ACTION controlp INFIELD l_qty3 name="input.c.page1.l_qty3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt3
            #add-point:ON ACTION controlp INFIELD l_amt3 name="input.c.page1.l_amt3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate3
            #add-point:ON ACTION controlp INFIELD l_rate3 name="input.c.page1.l_rate3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle3
            #add-point:ON ACTION controlp INFIELD l_idle3 name="input.c.page1.l_idle3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty4
            #add-point:ON ACTION controlp INFIELD l_qty4 name="input.c.page1.l_qty4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt4
            #add-point:ON ACTION controlp INFIELD l_amt4 name="input.c.page1.l_amt4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate4
            #add-point:ON ACTION controlp INFIELD l_rate4 name="input.c.page1.l_rate4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle4
            #add-point:ON ACTION controlp INFIELD l_idle4 name="input.c.page1.l_idle4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty5
            #add-point:ON ACTION controlp INFIELD l_qty5 name="input.c.page1.l_qty5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt5
            #add-point:ON ACTION controlp INFIELD l_amt5 name="input.c.page1.l_amt5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate5
            #add-point:ON ACTION controlp INFIELD l_rate5 name="input.c.page1.l_rate5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle5
            #add-point:ON ACTION controlp INFIELD l_idle5 name="input.c.page1.l_idle5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty6
            #add-point:ON ACTION controlp INFIELD l_qty6 name="input.c.page1.l_qty6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt6
            #add-point:ON ACTION controlp INFIELD l_amt6 name="input.c.page1.l_amt6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate6
            #add-point:ON ACTION controlp INFIELD l_rate6 name="input.c.page1.l_rate6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle6
            #add-point:ON ACTION controlp INFIELD l_idle6 name="input.c.page1.l_idle6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty7
            #add-point:ON ACTION controlp INFIELD l_qty7 name="input.c.page1.l_qty7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt7
            #add-point:ON ACTION controlp INFIELD l_amt7 name="input.c.page1.l_amt7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate7
            #add-point:ON ACTION controlp INFIELD l_rate7 name="input.c.page1.l_rate7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle7
            #add-point:ON ACTION controlp INFIELD l_idle7 name="input.c.page1.l_idle7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty8
            #add-point:ON ACTION controlp INFIELD l_qty8 name="input.c.page1.l_qty8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt8
            #add-point:ON ACTION controlp INFIELD l_amt8 name="input.c.page1.l_amt8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate8
            #add-point:ON ACTION controlp INFIELD l_rate8 name="input.c.page1.l_rate8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle8
            #add-point:ON ACTION controlp INFIELD l_idle8 name="input.c.page1.l_idle8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty9
            #add-point:ON ACTION controlp INFIELD l_qty9 name="input.c.page1.l_qty9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt9
            #add-point:ON ACTION controlp INFIELD l_amt9 name="input.c.page1.l_amt9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate9
            #add-point:ON ACTION controlp INFIELD l_rate9 name="input.c.page1.l_rate9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle9
            #add-point:ON ACTION controlp INFIELD l_idle9 name="input.c.page1.l_idle9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty10
            #add-point:ON ACTION controlp INFIELD l_qty10 name="input.c.page1.l_qty10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt10
            #add-point:ON ACTION controlp INFIELD l_amt10 name="input.c.page1.l_amt10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate10
            #add-point:ON ACTION controlp INFIELD l_rate10 name="input.c.page1.l_rate10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle10
            #add-point:ON ACTION controlp INFIELD l_idle10 name="input.c.page1.l_idle10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty11
            #add-point:ON ACTION controlp INFIELD l_qty11 name="input.c.page1.l_qty11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt11
            #add-point:ON ACTION controlp INFIELD l_amt11 name="input.c.page1.l_amt11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate11
            #add-point:ON ACTION controlp INFIELD l_rate11 name="input.c.page1.l_rate11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle11
            #add-point:ON ACTION controlp INFIELD l_idle11 name="input.c.page1.l_idle11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty12
            #add-point:ON ACTION controlp INFIELD l_qty12 name="input.c.page1.l_qty12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt12
            #add-point:ON ACTION controlp INFIELD l_amt12 name="input.c.page1.l_amt12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate12
            #add-point:ON ACTION controlp INFIELD l_rate12 name="input.c.page1.l_rate12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle12
            #add-point:ON ACTION controlp INFIELD l_idle12 name="input.c.page1.l_idle12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty13
            #add-point:ON ACTION controlp INFIELD l_qty13 name="input.c.page1.l_qty13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt13
            #add-point:ON ACTION controlp INFIELD l_amt13 name="input.c.page1.l_amt13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate13
            #add-point:ON ACTION controlp INFIELD l_rate13 name="input.c.page1.l_rate13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle13
            #add-point:ON ACTION controlp INFIELD l_idle13 name="input.c.page1.l_idle13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty14
            #add-point:ON ACTION controlp INFIELD l_qty14 name="input.c.page1.l_qty14"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt14
            #add-point:ON ACTION controlp INFIELD l_amt14 name="input.c.page1.l_amt14"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate14
            #add-point:ON ACTION controlp INFIELD l_rate14 name="input.c.page1.l_rate14"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle14
            #add-point:ON ACTION controlp INFIELD l_idle14 name="input.c.page1.l_idle14"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty15
            #add-point:ON ACTION controlp INFIELD l_qty15 name="input.c.page1.l_qty15"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt15
            #add-point:ON ACTION controlp INFIELD l_amt15 name="input.c.page1.l_amt15"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate15
            #add-point:ON ACTION controlp INFIELD l_rate15 name="input.c.page1.l_rate15"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle15
            #add-point:ON ACTION controlp INFIELD l_idle15 name="input.c.page1.l_idle15"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty16
            #add-point:ON ACTION controlp INFIELD l_qty16 name="input.c.page1.l_qty16"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt16
            #add-point:ON ACTION controlp INFIELD l_amt16 name="input.c.page1.l_amt16"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate16
            #add-point:ON ACTION controlp INFIELD l_rate16 name="input.c.page1.l_rate16"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle16
            #add-point:ON ACTION controlp INFIELD l_idle16 name="input.c.page1.l_idle16"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty17
            #add-point:ON ACTION controlp INFIELD l_qty17 name="input.c.page1.l_qty17"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt17
            #add-point:ON ACTION controlp INFIELD l_amt17 name="input.c.page1.l_amt17"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate17
            #add-point:ON ACTION controlp INFIELD l_rate17 name="input.c.page1.l_rate17"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle17
            #add-point:ON ACTION controlp INFIELD l_idle17 name="input.c.page1.l_idle17"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty18
            #add-point:ON ACTION controlp INFIELD l_qty18 name="input.c.page1.l_qty18"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt18
            #add-point:ON ACTION controlp INFIELD l_amt18 name="input.c.page1.l_amt18"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate18
            #add-point:ON ACTION controlp INFIELD l_rate18 name="input.c.page1.l_rate18"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle18
            #add-point:ON ACTION controlp INFIELD l_idle18 name="input.c.page1.l_idle18"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty19
            #add-point:ON ACTION controlp INFIELD l_qty19 name="input.c.page1.l_qty19"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt19
            #add-point:ON ACTION controlp INFIELD l_amt19 name="input.c.page1.l_amt19"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate19
            #add-point:ON ACTION controlp INFIELD l_rate19 name="input.c.page1.l_rate19"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle19
            #add-point:ON ACTION controlp INFIELD l_idle19 name="input.c.page1.l_idle19"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty20
            #add-point:ON ACTION controlp INFIELD l_qty20 name="input.c.page1.l_qty20"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_amt20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_amt20
            #add-point:ON ACTION controlp INFIELD l_amt20 name="input.c.page1.l_amt20"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_rate20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_rate20
            #add-point:ON ACTION controlp INFIELD l_rate20 name="input.c.page1.l_rate20"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_idle20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_idle20
            #add-point:ON ACTION controlp INFIELD l_idle20 name="input.c.page1.l_idle20"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcfj_d[l_ac].* = g_xcfj_d_t.*
               CLOSE axcq801_bcl
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
               LET g_errparam.extend = g_xcfj_d[l_ac].xcfj001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcfj_d[l_ac].* = g_xcfj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq801_xcfj_t_mask_restore('restore_mask_o')
         
               UPDATE xcfj_t SET (xcfjld,xcfj002,xcfj003,xcfj004,xcfj001,xcfj005,xcfj006,xcfj007,xcfj008, 
                   xcfj009) = (g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_d[l_ac].xcfj001, 
                   g_xcfj_d[l_ac].xcfj005,g_xcfj_d[l_ac].xcfj006,g_xcfj_d[l_ac].xcfj007,g_xcfj_d[l_ac].xcfj008, 
                   g_xcfj_d[l_ac].xcfj009)
                WHERE xcfjent = g_enterprise AND xcfjld = g_xcfj_m.xcfjld 
                 AND xcfj002 = g_xcfj_m.xcfj002 
                 AND xcfj003 = g_xcfj_m.xcfj003 
                 AND xcfj004 = g_xcfj_m.xcfj004 
 
                 AND xcfj001 = g_xcfj_d_t.xcfj001 #項次   
                 AND xcfj005 = g_xcfj_d_t.xcfj005  
                 AND xcfj006 = g_xcfj_d_t.xcfj006  
                 AND xcfj007 = g_xcfj_d_t.xcfj007  
                 AND xcfj008 = g_xcfj_d_t.xcfj008  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcfj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcfj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcfj_m.xcfjld
               LET gs_keys_bak[1] = g_xcfjld_t
               LET gs_keys[2] = g_xcfj_m.xcfj002
               LET gs_keys_bak[2] = g_xcfj002_t
               LET gs_keys[3] = g_xcfj_m.xcfj003
               LET gs_keys_bak[3] = g_xcfj003_t
               LET gs_keys[4] = g_xcfj_m.xcfj004
               LET gs_keys_bak[4] = g_xcfj004_t
               LET gs_keys[5] = g_xcfj_d[g_detail_idx].xcfj001
               LET gs_keys_bak[5] = g_xcfj_d_t.xcfj001
               LET gs_keys[6] = g_xcfj_d[g_detail_idx].xcfj005
               LET gs_keys_bak[6] = g_xcfj_d_t.xcfj005
               LET gs_keys[7] = g_xcfj_d[g_detail_idx].xcfj006
               LET gs_keys_bak[7] = g_xcfj_d_t.xcfj006
               LET gs_keys[8] = g_xcfj_d[g_detail_idx].xcfj007
               LET gs_keys_bak[8] = g_xcfj_d_t.xcfj007
               LET gs_keys[9] = g_xcfj_d[g_detail_idx].xcfj008
               LET gs_keys_bak[9] = g_xcfj_d_t.xcfj008
               CALL axcq801_update_b('xcfj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcfj_m),util.JSON.stringify(g_xcfj_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcfj_m),util.JSON.stringify(g_xcfj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq801_xcfj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcfj_m.xcfjld
               LET ls_keys[ls_keys.getLength()+1] = g_xcfj_m.xcfj002
               LET ls_keys[ls_keys.getLength()+1] = g_xcfj_m.xcfj003
               LET ls_keys[ls_keys.getLength()+1] = g_xcfj_m.xcfj004
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcfj_d_t.xcfj001
               LET ls_keys[ls_keys.getLength()+1] = g_xcfj_d_t.xcfj005
               LET ls_keys[ls_keys.getLength()+1] = g_xcfj_d_t.xcfj006
               LET ls_keys[ls_keys.getLength()+1] = g_xcfj_d_t.xcfj007
               LET ls_keys[ls_keys.getLength()+1] = g_xcfj_d_t.xcfj008
 
               CALL axcq801_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq801_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcfj_d[l_ac].* = g_xcfj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq801_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcfj_d.getLength() = 0 THEN
               NEXT FIELD xcfj001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcfj_d[li_reproduce_target].* = g_xcfj_d[li_reproduce].*
 
               LET g_xcfj_d[li_reproduce_target].xcfj001 = NULL
               LET g_xcfj_d[li_reproduce_target].xcfj005 = NULL
               LET g_xcfj_d[li_reproduce_target].xcfj006 = NULL
               LET g_xcfj_d[li_reproduce_target].xcfj007 = NULL
               LET g_xcfj_d[li_reproduce_target].xcfj008 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcfj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcfj_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcfjld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcfb010
 
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
 
{<section id="axcq801.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq801_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcfj_m.xcfjcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcfj_m.xcfjcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcfj_m.xcfjcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF   
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcfj001,xcfj001_desc',TRUE)
       LET g_xcfj001 = 'Y'      #141218-0001
   ELSE                        
      CALL cl_set_comp_visible('xcfj001,xcfj001_desc',FALSE)
       LET g_xcfj001 = 'N'      #141218-0001
   END IF   
   
    IF g_para_data1 = 'Y' THEN
       CALL cl_set_comp_visible('xcfj006,xcfj006_desc',TRUE)
       LET g_xcfj006 = 'Y'      #141218-0001
    ELSE                        
       CALL cl_set_comp_visible('xcfj006,xcfj006_desc',FALSE)
       LET g_xcfj006 = 'N'      #141218-0001
    END IF           
    
#   IF g_para_data = 'Y' THEN
#      CALL cl_set_comp_visible('xcfj001,xcfj001_desc',TRUE)
#      LET g_xcfj006 = 'Y'      #141218-0001
#   ELSE                        
#      CALL cl_set_comp_visible('xcfj001,xcfj001_desc',FALSE)
#      LET g_xcfj006 = 'N'      #141218-0001
#   END IF  
   
   
   
   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcfj006',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcfj006',FALSE)                
   END IF   
   #fengmy 150113----end
   CALL axcq801_ref()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq801_b_fill(g_wc2) #第一階單身填充
      CALL axcq801_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq801_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcfj_m.xcfjcomp,g_xcfj_m.xcfjcomp_desc,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xccc001, 
       g_xcfj_m.xccc001_desc,g_xcfj_m.xcfc013,g_xcfj_m.xcfc013_desc,g_xcfj_m.xcfjld,g_xcfj_m.xcfjld_desc, 
       g_xcfj_m.xcfj002,g_xcfj_m.xcfj002_desc,g_xcfj_m.xcfa004
 
   CALL axcq801_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq801_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcfj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq801.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq801_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcfj_t.xcfjld 
   DEFINE l_oldno     LIKE xcfj_t.xcfjld 
   DEFINE l_newno02     LIKE xcfj_t.xcfj002 
   DEFINE l_oldno02     LIKE xcfj_t.xcfj002 
   DEFINE l_newno03     LIKE xcfj_t.xcfj003 
   DEFINE l_oldno03     LIKE xcfj_t.xcfj003 
   DEFINE l_newno04     LIKE xcfj_t.xcfj004 
   DEFINE l_oldno04     LIKE xcfj_t.xcfj004 
 
   DEFINE l_master    RECORD LIKE xcfj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcfj_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcfj_m.xcfjld IS NULL
      OR g_xcfj_m.xcfj002 IS NULL
      OR g_xcfj_m.xcfj003 IS NULL
      OR g_xcfj_m.xcfj004 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcfjld_t = g_xcfj_m.xcfjld
   LET g_xcfj002_t = g_xcfj_m.xcfj002
   LET g_xcfj003_t = g_xcfj_m.xcfj003
   LET g_xcfj004_t = g_xcfj_m.xcfj004
 
   
   LET g_xcfj_m.xcfjld = ""
   LET g_xcfj_m.xcfj002 = ""
   LET g_xcfj_m.xcfj003 = ""
   LET g_xcfj_m.xcfj004 = ""
 
   LET g_master_insert = FALSE
   CALL axcq801_set_entry('a')
   CALL axcq801_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcfj_m.xcfjld_desc = ''
   DISPLAY BY NAME g_xcfj_m.xcfjld_desc
   LET g_xcfj_m.xcfj002_desc = ''
   DISPLAY BY NAME g_xcfj_m.xcfj002_desc
 
   
   CALL axcq801_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcfj_m.* TO NULL
      INITIALIZE g_xcfj_d TO NULL
 
      CALL axcq801_show()
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
   CALL axcq801_set_act_visible()
   CALL axcq801_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcfjld_t = g_xcfj_m.xcfjld
   LET g_xcfj002_t = g_xcfj_m.xcfj002
   LET g_xcfj003_t = g_xcfj_m.xcfj003
   LET g_xcfj004_t = g_xcfj_m.xcfj004
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcfjent = " ||g_enterprise|| " AND",
                      " xcfjld = '", g_xcfj_m.xcfjld, "' "
                      ," AND xcfj002 = '", g_xcfj_m.xcfj002, "' "
                      ," AND xcfj003 = '", g_xcfj_m.xcfj003, "' "
                      ," AND xcfj004 = '", g_xcfj_m.xcfj004, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq801_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq801_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq801_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcfj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq801_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcfj_t
    WHERE xcfjent = g_enterprise AND xcfjld = g_xcfjld_t
    AND xcfj002 = g_xcfj002_t
    AND xcfj003 = g_xcfj003_t
    AND xcfj004 = g_xcfj004_t
 
       INTO TEMP axcq801_detail
   
   #將key修正為調整後   
   UPDATE axcq801_detail 
      #更新key欄位
      SET xcfjld = g_xcfj_m.xcfjld
          , xcfj002 = g_xcfj_m.xcfj002
          , xcfj003 = g_xcfj_m.xcfj003
          , xcfj004 = g_xcfj_m.xcfj004
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcfj_t SELECT * FROM axcq801_detail
   
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
   DROP TABLE axcq801_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcfjld_t = g_xcfj_m.xcfjld
   LET g_xcfj002_t = g_xcfj_m.xcfj002
   LET g_xcfj003_t = g_xcfj_m.xcfj003
   LET g_xcfj004_t = g_xcfj_m.xcfj004
 
   
   DROP TABLE axcq801_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq801_delete()
   #add-point:delete段define name="delete.define_customerization"
   
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
   
   IF g_xcfj_m.xcfjld IS NULL
   OR g_xcfj_m.xcfj002 IS NULL
   OR g_xcfj_m.xcfj003 IS NULL
   OR g_xcfj_m.xcfj004 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq801_cl USING g_enterprise,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq801_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq801_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq801_master_referesh USING g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004 INTO g_xcfj_m.xcfjcomp, 
       g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfjcomp_desc,g_xcfj_m.xcfjld_desc, 
       g_xcfj_m.xcfj002_desc
   
   #遮罩相關處理
   LET g_xcfj_m_mask_o.* =  g_xcfj_m.*
   CALL axcq801_xcfj_t_mask()
   LET g_xcfj_m_mask_n.* =  g_xcfj_m.*
   
   CALL axcq801_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq801_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcfj_t WHERE xcfjent = g_enterprise AND xcfjld = g_xcfj_m.xcfjld
                                                               AND xcfj002 = g_xcfj_m.xcfj002
                                                               AND xcfj003 = g_xcfj_m.xcfj003
                                                               AND xcfj004 = g_xcfj_m.xcfj004
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcfj_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE axcq801_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcfj_d.clear() 
 
     
      CALL axcq801_ui_browser_refresh()  
      #CALL axcq801_ui_headershow()  
      #CALL axcq801_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq801_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq801_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq801_cl
 
   #功能已完成,通報訊息中心
   CALL axcq801_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq801.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq801_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcfj_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF 1=2 THEN
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcfj001,xcfj005,xcfj006,xcfj007,xcfj008,xcfj009,t4.xcbfl003 ,t5.imaal003 , 
       t6.imaal004 FROM xcfj_t",   
               "",
               
                              " LEFT JOIN xcbfl_t t4 ON t4.xcbflent="||g_enterprise||" AND t4.xcbflcomp=xcfjcomp AND t4.xcbfl001=xcfj001 AND t4.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=xcfj005 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t6 ON t6.imaalent="||g_enterprise||" AND t6.imaal001=xcfj005 AND t6.imaal002='"||g_dlang||"' ",
 
               " WHERE xcfjent= ? AND xcfjld=? AND xcfj002=? AND xcfj003=? AND xcfj004=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcfj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq801_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcfj_t.xcfj001,xcfj_t.xcfj005,xcfj_t.xcfj006,xcfj_t.xcfj007,xcfj_t.xcfj008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq801_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq801_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcfj_m.xcfjld,g_xcfj_m.xcfj002,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004 INTO g_xcfj_d[l_ac].xcfj001, 
          g_xcfj_d[l_ac].xcfj005,g_xcfj_d[l_ac].xcfj006,g_xcfj_d[l_ac].xcfj007,g_xcfj_d[l_ac].xcfj008, 
          g_xcfj_d[l_ac].xcfj009,g_xcfj_d[l_ac].xcfj001_desc,g_xcfj_d[l_ac].xcfj005_desc,g_xcfj_d[l_ac].xcfj005_desc_desc  
            #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         
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
 
            CALL g_xcfj_d.deleteElement(g_xcfj_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   ELSE
      CALL axcq801_b_fill_1()
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcfj_d.getLength()
      LET g_xcfj_d_mask_o[l_ac].* =  g_xcfj_d[l_ac].*
      CALL axcq801_xcfj_t_mask()
      LET g_xcfj_d_mask_n[l_ac].* =  g_xcfj_d[l_ac].*
   END FOR
   
 
 
   FREE axcq801_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq801_idx_chk()
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
      IF g_detail_idx > g_xcfj_d.getLength() THEN
         LET g_detail_idx = g_xcfj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcfj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcfj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq801_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcfj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq801_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcfj_t
    WHERE xcfjent = g_enterprise AND xcfjld = g_xcfj_m.xcfjld AND
                              xcfj002 = g_xcfj_m.xcfj002 AND
                              xcfj003 = g_xcfj_m.xcfj003 AND
                              xcfj004 = g_xcfj_m.xcfj004 AND
 
          xcfj001 = g_xcfj_d_t.xcfj001
      AND xcfj005 = g_xcfj_d_t.xcfj005
      AND xcfj006 = g_xcfj_d_t.xcfj006
      AND xcfj007 = g_xcfj_d_t.xcfj007
      AND xcfj008 = g_xcfj_d_t.xcfj008
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcfj_t:",SQLERRMESSAGE 
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
 
{<section id="axcq801.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq801_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq801.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq801_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq801.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq801_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq801.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq801_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcfj_d[l_ac].xcfj001 = g_xcfj_d_t.xcfj001 
      AND g_xcfj_d[l_ac].xcfj005 = g_xcfj_d_t.xcfj005 
      AND g_xcfj_d[l_ac].xcfj006 = g_xcfj_d_t.xcfj006 
      AND g_xcfj_d[l_ac].xcfj007 = g_xcfj_d_t.xcfj007 
      AND g_xcfj_d[l_ac].xcfj008 = g_xcfj_d_t.xcfj008 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq801_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq801.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq801_lock_b(ps_table,ps_page)
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
   #CALL axcq801_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq801.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq801_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq801.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq801_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcfjld,xcfj002,xcfj003,xcfj004",TRUE)
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
 
{<section id="axcq801.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq801_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcfjld,xcfj002,xcfj003,xcfj004",FALSE)
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
 
{<section id="axcq801.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq801_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq801_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq801_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq801.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq801_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq801.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq801_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq801.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq801_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq801.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq801_default_search()
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
      LET ls_wc = ls_wc, " xcfjld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcfj002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcfj003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcfj004 = '", g_argv[04], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq801.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq801_fill_chk(ps_idx)
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
 
{<section id="axcq801.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq801_modify_detail_chk(ps_record)
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
         LET ls_return = "xcfb010"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq801.mask_functions" >}
&include "erp/axc/axcq801_mask.4gl"
 
{</section>}
 
{<section id="axcq801.state_change" >}
    
 
{</section>}
 
{<section id="axcq801.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq801_set_pk_array()
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
   LET g_pk_array[1].values = g_xcfj_m.xcfjld
   LET g_pk_array[1].column = 'xcfjld'
   LET g_pk_array[2].values = g_xcfj_m.xcfj002
   LET g_pk_array[2].column = 'xcfj002'
   LET g_pk_array[3].values = g_xcfj_m.xcfj003
   LET g_pk_array[3].column = 'xcfj003'
   LET g_pk_array[4].values = g_xcfj_m.xcfj004
   LET g_pk_array[4].column = 'xcfj004'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq801.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq801_msgcentre_notify(lc_state)
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
   CALL axcq801_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcfj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq801.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq801_b_fill_1()
   DEFINE l_amount_sum  LIKE xccc_t.xccc280
   DEFINE l_amt1_sum    LIKE xccc_t.xccc280
   DEFINE l_amt2_sum    LIKE xccc_t.xccc280
   DEFINE l_amt3_sum    LIKE xccc_t.xccc280
   DEFINE l_amt4_sum    LIKE xccc_t.xccc280
   DEFINE l_amt5_sum    LIKE xccc_t.xccc280
   DEFINE l_amt6_sum    LIKE xccc_t.xccc280
   DEFINE l_amt7_sum    LIKE xccc_t.xccc280
   DEFINE l_amt8_sum    LIKE xccc_t.xccc280
   DEFINE l_amt9_sum    LIKE xccc_t.xccc280
   DEFINE l_amt10_sum   LIKE xccc_t.xccc280
   DEFINE l_amt11_sum   LIKE xccc_t.xccc280
   DEFINE l_amt12_sum   LIKE xccc_t.xccc280
   DEFINE l_amt13_sum   LIKE xccc_t.xccc280
   DEFINE l_amt14_sum   LIKE xccc_t.xccc280
   DEFINE l_amt15_sum   LIKE xccc_t.xccc280
   DEFINE l_amt16_sum   LIKE xccc_t.xccc280
   DEFINE l_amt17_sum   LIKE xccc_t.xccc280
   DEFINE l_amt18_sum   LIKE xccc_t.xccc280
   DEFINE l_amt19_sum   LIKE xccc_t.xccc280
   DEFINE l_amt20_sum   LIKE xccc_t.xccc280
   DEFINE l_idle_sum    LIKE xccc_t.xccc280
   DEFINE l_idle1_sum   LIKE xccc_t.xccc280
   DEFINE l_idle2_sum   LIKE xccc_t.xccc280
   DEFINE l_idle3_sum   LIKE xccc_t.xccc280
   DEFINE l_idle4_sum   LIKE xccc_t.xccc280
   DEFINE l_idle5_sum   LIKE xccc_t.xccc280
   DEFINE l_idle6_sum   LIKE xccc_t.xccc280
   DEFINE l_idle7_sum   LIKE xccc_t.xccc280
   DEFINE l_idle8_sum   LIKE xccc_t.xccc280
   DEFINE l_idle9_sum   LIKE xccc_t.xccc280
   DEFINE l_idle10_sum  LIKE xccc_t.xccc280
   DEFINE l_idle11_sum  LIKE xccc_t.xccc280
   DEFINE l_idle12_sum  LIKE xccc_t.xccc280
   DEFINE l_idle13_sum  LIKE xccc_t.xccc280
   DEFINE l_idle14_sum  LIKE xccc_t.xccc280
   DEFINE l_idle15_sum  LIKE xccc_t.xccc280
   DEFINE l_idle16_sum  LIKE xccc_t.xccc280
   DEFINE l_idle17_sum  LIKE xccc_t.xccc280
   DEFINE l_idle18_sum  LIKE xccc_t.xccc280
   DEFINE l_idle19_sum  LIKE xccc_t.xccc280
   DEFINE l_idle20_sum  LIKE xccc_t.xccc280
   DEFINE l_amount_total LIKE xccc_t.xccc280
   DEFINE l_amt1_total   LIKE xccc_t.xccc280
   DEFINE l_amt2_total   LIKE xccc_t.xccc280
   DEFINE l_amt3_total   LIKE xccc_t.xccc280
   DEFINE l_amt4_total   LIKE xccc_t.xccc280
   DEFINE l_amt5_total   LIKE xccc_t.xccc280
   DEFINE l_amt6_total   LIKE xccc_t.xccc280
   DEFINE l_amt7_total   LIKE xccc_t.xccc280
   DEFINE l_amt8_total   LIKE xccc_t.xccc280
   DEFINE l_amt9_total   LIKE xccc_t.xccc280
   DEFINE l_amt10_total  LIKE xccc_t.xccc280
   DEFINE l_amt11_total  LIKE xccc_t.xccc280
   DEFINE l_amt12_total  LIKE xccc_t.xccc280
   DEFINE l_amt13_total  LIKE xccc_t.xccc280
   DEFINE l_amt14_total  LIKE xccc_t.xccc280
   DEFINE l_amt15_total  LIKE xccc_t.xccc280
   DEFINE l_amt16_total  LIKE xccc_t.xccc280
   DEFINE l_amt17_total  LIKE xccc_t.xccc280
   DEFINE l_amt18_total  LIKE xccc_t.xccc280
   DEFINE l_amt19_total  LIKE xccc_t.xccc280
   DEFINE l_amt20_total  LIKE xccc_t.xccc280
   DEFINE l_idle_total   LIKE xccc_t.xccc280
   DEFINE l_idle1_total   LIKE xccc_t.xccc280
   DEFINE l_idle2_total   LIKE xccc_t.xccc280
   DEFINE l_idle3_total   LIKE xccc_t.xccc280
   DEFINE l_idle4_total   LIKE xccc_t.xccc280
   DEFINE l_idle5_total   LIKE xccc_t.xccc280
   DEFINE l_idle6_total   LIKE xccc_t.xccc280
   DEFINE l_idle7_total   LIKE xccc_t.xccc280
   DEFINE l_idle8_total   LIKE xccc_t.xccc280
   DEFINE l_idle9_total   LIKE xccc_t.xccc280
   DEFINE l_idle10_total  LIKE xccc_t.xccc280
   DEFINE l_idle11_total  LIKE xccc_t.xccc280
   DEFINE l_idle12_total  LIKE xccc_t.xccc280
   DEFINE l_idle13_total  LIKE xccc_t.xccc280
   DEFINE l_idle14_total  LIKE xccc_t.xccc280
   DEFINE l_idle15_total  LIKE xccc_t.xccc280
   DEFINE l_idle16_total  LIKE xccc_t.xccc280
   DEFINE l_idle17_total  LIKE xccc_t.xccc280
   DEFINE l_idle18_total  LIKE xccc_t.xccc280
   DEFINE l_idle19_total  LIKE xccc_t.xccc280
   DEFINE l_idle20_total  LIKE xccc_t.xccc280
   DEFINE l_round_type    LIKE ooaa_t.ooaa002
  
  #150319-00004---(s)---
   DEFINE l_xcfb010_desc  LIKE type_t.chr500
   DEFINE l_imaa003_desc  LIKE type_t.chr500
   DEFINE l_imag011_desc  LIKE type_t.chr500
   DEFINE l_xcfj001_desc  LIKE type_t.chr500
   DEFINE l_xcfj005_desc  LIKE type_t.chr500  
   DEFINE l_ld_desc       LIKE type_t.chr80
   DEFINE l_comp_desc     LIKE type_t.chr80
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_mon           LIKE type_t.num5
   DEFINE l_xcfj002       LIKE type_t.chr80
   DEFINE l_xrcc001       LIKE type_t.chr80
   DEFINE l_xcfa004       LIKE type_t.chr80
   
   DELETE FROM axcq801_tmp01       #160727-00019#21 Mod  axcq801_print_tmp--> axcq801_tmp01
   #150319-00004---(e)---
#  DEFINE l_amtcpr        LIKE xccc_t.xccc280   #fengmy150217
   CALL axcq801_create_tmp()
   CALL axcq801_insert_tmp()
   #add-point:b_fill段sql_after
#   LET g_sql = "SELECT  UNIQUE imaf051,xcfj001,xcfj005,xcfj006,xcfj007,xccc280,xccc901,xccc902,t2.xcbfl003 ,t3.imaal003 ,t4.imaal004,t1.oocql004,   #fengmy150216 mark
   LET g_sql = "SELECT  UNIQUE imaf051,imaa003,imag011,xcfj001,xcfj005,xcfj006,xcfj007,xccc280,xccc901,xccc902,t2.xcbfl003 ,t3.imaal003 ,t4.imaal004,t1.oocql004,t5.oocql004,t6.oocql004, 
                               qty1,amt1,rate1,idle1,qty2,amt2,rate2,idle2,qty3,amt3,rate3,idle3,qty4,amt4,rate4,idle4,qty5,amt5,rate5,idle5,
                               qty6,amt6,rate6,idle6,qty7,amt7,rate7,idle7,qty8,amt8,rate8,idle8,qty9,amt9,rate9,idle9,qty10,amt10,rate10,idle10, 
                               qty11,amt11,rate11,idle11,qty12,amt12,rate12,idle12,qty13,amt13,rate13,idle13,qty14,amt14,rate14,idle14,qty15,amt15,rate15,idle15,
                               qty16,amt16,rate16,idle16,qty17,amt17,rate17,idle17,qty18,amt18,rate18,idle18,qty19,amt19,rate19,idle19,qty20,amt20,rate20,idle20
                               FROM axcq801_tmp",   
               "",
               " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='201' AND t1.oocql002=imaf051 AND t1.oocql003='"||g_dlang||"' ",
               #fengmy150216----begin
               " LEFT JOIN oocql_t t5 ON t5.oocqlent='"||g_enterprise||"' AND t5.oocql001='200' AND t5.oocql002=imaa003 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent='"||g_enterprise||"' AND t6.oocql001='206' AND t6.oocql002=imag011 AND t6.oocql003='"||g_dlang||"' ",
               #fengmy150216----end
                " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbflcomp='"||g_xcfj_m.xcfjcomp||"' AND t2.xcbfl001=xcfj001 AND t2.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcfj005 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcfj005 AND t4.imaal002='"||g_dlang||"' "

   #end add-point
   
   #子單身的WC
      
   #判斷是否填充
   IF axcq801_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY imaf051,xcfj005,xcfj006,xcfj007"
      
      #add-point:b_fill段fill_before
      LET l_round_type = cl_get_para(g_enterprise,'','E-COM-0006')
      LET l_amount_sum  = 0 
      LET l_amt1_sum    = 0
      LET l_amt2_sum    = 0
      LET l_amt3_sum    = 0
      LET l_amt4_sum    = 0
      LET l_amt5_sum    = 0
      LET l_amt6_sum    = 0
      LET l_amt7_sum    = 0
      LET l_amt8_sum    = 0
      LET l_amt9_sum    = 0
      LET l_amt10_sum   = 0
      LET l_amt11_sum   = 0
      LET l_amt12_sum   = 0
      LET l_amt13_sum   = 0
      LET l_amt14_sum   = 0
      LET l_amt15_sum   = 0
      LET l_amt16_sum   = 0
      LET l_amt17_sum   = 0
      LET l_amt18_sum   = 0
      LET l_amt19_sum   = 0
      LET l_amt20_sum   = 0
      LET l_idle_sum    = 0
      LET l_idle1_sum   = 0
      LET l_idle2_sum   = 0
      LET l_idle3_sum   = 0
      LET l_idle4_sum   = 0
      LET l_idle5_sum   = 0
      LET l_idle6_sum   = 0
      LET l_idle7_sum   = 0
      LET l_idle8_sum   = 0
      LET l_idle9_sum   = 0
      LET l_idle10_sum  = 0
      LET l_idle11_sum   = 0
      LET l_idle12_sum   = 0
      LET l_idle13_sum   = 0
      LET l_idle14_sum   = 0
      LET l_idle15_sum   = 0
      LET l_idle16_sum   = 0
      LET l_idle17_sum   = 0
      LET l_idle18_sum   = 0
      LET l_idle19_sum   = 0
      LET l_idle20_sum  = 0
      LET l_amount_total= 0
      LET l_amt1_total  = 0
      LET l_amt2_total  = 0
      LET l_amt3_total  = 0
      LET l_amt4_total  = 0
      LET l_amt5_total  = 0
      LET l_amt6_total  = 0
      LET l_amt7_total  = 0
      LET l_amt8_total  = 0
      LET l_amt9_total  = 0
      LET l_amt10_total = 0
      LET l_amt11_total  = 0
      LET l_amt12_total  = 0
      LET l_amt13_total  = 0
      LET l_amt14_total  = 0
      LET l_amt15_total  = 0
      LET l_amt16_total  = 0
      LET l_amt17_total  = 0
      LET l_amt18_total  = 0
      LET l_amt19_total  = 0
      LET l_amt20_total = 0      
      LET l_idle_total  = 0
      LET l_idle1_total = 0
      LET l_idle2_total = 0
      LET l_idle3_total = 0
      LET l_idle4_total = 0
      LET l_idle5_total = 0
      LET l_idle6_total = 0
      LET l_idle7_total = 0
      LET l_idle8_total = 0
      LET l_idle9_total = 0
      LET l_idle10_total= 0
      LET l_idle11_total = 0
      LET l_idle12_total = 0
      LET l_idle13_total = 0
      LET l_idle14_total = 0
      LET l_idle15_total = 0
      LET l_idle16_total = 0
      LET l_idle17_total = 0
      LET l_idle18_total = 0
      LET l_idle19_total = 0
      LET l_idle20_total= 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq801_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR axcq801_pb1
      
      LET g_cnt = l_ac
      LET l_ac = 1
                                                          
      FOREACH b_fill_cs1 INTO g_xcfj_d[l_ac].xcfb010,g_xcfj_d[l_ac].imaa003,g_xcfj_d[l_ac].imag011,g_xcfj_d[l_ac].xcfj001,g_xcfj_d[l_ac].xcfj005,g_xcfj_d[l_ac].xcfj006,g_xcfj_d[l_ac].xcfj007, 
          g_xcfj_d[l_ac].xccc280,g_xcfj_d[l_ac].xcfj009,g_xcfj_d[l_ac].l_amount,g_xcfj_d[l_ac].xcfj001_desc,g_xcfj_d[l_ac].xcfj005_desc, 
          g_xcfj_d[l_ac].xcfj005_desc_desc,g_xcfj_d[l_ac].xcfb010_desc,g_xcfj_d[l_ac].imaa003_desc,g_xcfj_d[l_ac].imag011_desc,
          g_xcfj_d[l_ac].l_qty1,g_xcfj_d[l_ac].l_amt1,g_xcfj_d[l_ac].l_rate1,g_xcfj_d[l_ac].l_idle1,g_xcfj_d[l_ac].l_qty2,g_xcfj_d[l_ac].l_amt2,g_xcfj_d[l_ac].l_rate2,g_xcfj_d[l_ac].l_idle2,
          g_xcfj_d[l_ac].l_qty3,g_xcfj_d[l_ac].l_amt3,g_xcfj_d[l_ac].l_rate3,g_xcfj_d[l_ac].l_idle3,g_xcfj_d[l_ac].l_qty4,g_xcfj_d[l_ac].l_amt4,g_xcfj_d[l_ac].l_rate4,g_xcfj_d[l_ac].l_idle4,
          g_xcfj_d[l_ac].l_qty5,g_xcfj_d[l_ac].l_amt5,g_xcfj_d[l_ac].l_rate5,g_xcfj_d[l_ac].l_idle5,g_xcfj_d[l_ac].l_qty6,g_xcfj_d[l_ac].l_amt6,g_xcfj_d[l_ac].l_rate6,g_xcfj_d[l_ac].l_idle6,
          g_xcfj_d[l_ac].l_qty7,g_xcfj_d[l_ac].l_amt7,g_xcfj_d[l_ac].l_rate7,g_xcfj_d[l_ac].l_idle7,g_xcfj_d[l_ac].l_qty8,g_xcfj_d[l_ac].l_amt8,g_xcfj_d[l_ac].l_rate8,g_xcfj_d[l_ac].l_idle8,
          g_xcfj_d[l_ac].l_qty9,g_xcfj_d[l_ac].l_amt9,g_xcfj_d[l_ac].l_rate9,g_xcfj_d[l_ac].l_idle9,g_xcfj_d[l_ac].l_qty10,g_xcfj_d[l_ac].l_amt10,g_xcfj_d[l_ac].l_rate10,g_xcfj_d[l_ac].l_idle10,
          g_xcfj_d[l_ac].l_qty11,g_xcfj_d[l_ac].l_amt11,g_xcfj_d[l_ac].l_rate11,g_xcfj_d[l_ac].l_idle11,g_xcfj_d[l_ac].l_qty12,g_xcfj_d[l_ac].l_amt12,g_xcfj_d[l_ac].l_rate12,g_xcfj_d[l_ac].l_idle12,
          g_xcfj_d[l_ac].l_qty13,g_xcfj_d[l_ac].l_amt13,g_xcfj_d[l_ac].l_rate13,g_xcfj_d[l_ac].l_idle13,g_xcfj_d[l_ac].l_qty14,g_xcfj_d[l_ac].l_amt14,g_xcfj_d[l_ac].l_rate14,g_xcfj_d[l_ac].l_idle14,
          g_xcfj_d[l_ac].l_qty15,g_xcfj_d[l_ac].l_amt15,g_xcfj_d[l_ac].l_rate15,g_xcfj_d[l_ac].l_idle15,g_xcfj_d[l_ac].l_qty16,g_xcfj_d[l_ac].l_amt16,g_xcfj_d[l_ac].l_rate16,g_xcfj_d[l_ac].l_idle16,
          g_xcfj_d[l_ac].l_qty17,g_xcfj_d[l_ac].l_amt17,g_xcfj_d[l_ac].l_rate17,g_xcfj_d[l_ac].l_idle17,g_xcfj_d[l_ac].l_qty18,g_xcfj_d[l_ac].l_amt18,g_xcfj_d[l_ac].l_rate18,g_xcfj_d[l_ac].l_idle18,
          g_xcfj_d[l_ac].l_qty19,g_xcfj_d[l_ac].l_amt19,g_xcfj_d[l_ac].l_rate19,g_xcfj_d[l_ac].l_idle19,g_xcfj_d[l_ac].l_qty20,g_xcfj_d[l_ac].l_amt20,g_xcfj_d[l_ac].l_rate20,g_xcfj_d[l_ac].l_idle20

          
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         #取位
         #160714-00027#1--(S)
         IF cl_null(g_xcfj_d[l_ac].l_amount) THEN LET g_xcfj_d[l_ac].l_amount = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt1) THEN LET g_xcfj_d[l_ac].l_amt1 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt2) THEN LET g_xcfj_d[l_ac].l_amt2 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt3) THEN LET g_xcfj_d[l_ac].l_amt3 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt4) THEN LET g_xcfj_d[l_ac].l_amt4 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt5) THEN LET g_xcfj_d[l_ac].l_amt5 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt6) THEN LET g_xcfj_d[l_ac].l_amt6 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt7) THEN LET g_xcfj_d[l_ac].l_amt7 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt8) THEN LET g_xcfj_d[l_ac].l_amt8 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt9) THEN LET g_xcfj_d[l_ac].l_amt9 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt10) THEN LET g_xcfj_d[l_ac].l_amt10 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt11) THEN LET g_xcfj_d[l_ac].l_amt11 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt12) THEN LET g_xcfj_d[l_ac].l_amt12 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt13) THEN LET g_xcfj_d[l_ac].l_amt13 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt14) THEN LET g_xcfj_d[l_ac].l_amt14 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt15) THEN LET g_xcfj_d[l_ac].l_amt15 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt16) THEN LET g_xcfj_d[l_ac].l_amt16 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt17) THEN LET g_xcfj_d[l_ac].l_amt17 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt18) THEN LET g_xcfj_d[l_ac].l_amt18 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt19) THEN LET g_xcfj_d[l_ac].l_amt19 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_amt20) THEN LET g_xcfj_d[l_ac].l_amt20 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle1) THEN LET g_xcfj_d[l_ac].l_idle1 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle2) THEN LET g_xcfj_d[l_ac].l_idle2 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle3) THEN LET g_xcfj_d[l_ac].l_idle3 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle4) THEN LET g_xcfj_d[l_ac].l_idle4 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle5) THEN LET g_xcfj_d[l_ac].l_idle5 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle6) THEN LET g_xcfj_d[l_ac].l_idle6 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle7) THEN LET g_xcfj_d[l_ac].l_idle7 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle8) THEN LET g_xcfj_d[l_ac].l_idle8 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle9) THEN LET g_xcfj_d[l_ac].l_idle9 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle10) THEN LET g_xcfj_d[l_ac].l_idle10 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle11) THEN LET g_xcfj_d[l_ac].l_idle11 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle12) THEN LET g_xcfj_d[l_ac].l_idle12 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle13) THEN LET g_xcfj_d[l_ac].l_idle13 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle14) THEN LET g_xcfj_d[l_ac].l_idle14 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle15) THEN LET g_xcfj_d[l_ac].l_idle15 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle16) THEN LET g_xcfj_d[l_ac].l_idle16 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle17) THEN LET g_xcfj_d[l_ac].l_idle17 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle18) THEN LET g_xcfj_d[l_ac].l_idle18 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle19) THEN LET g_xcfj_d[l_ac].l_idle19 = 0 END IF
         IF cl_null(g_xcfj_d[l_ac].l_idle20) THEN LET g_xcfj_d[l_ac].l_idle20 = 0 END IF
         #160714-00027#1--(E)
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amount,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amount
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt1,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt1
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt2,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt2
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt3,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt3
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt4,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt4
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt5,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt5
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt6,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt6
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt7,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt7
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt8,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt8
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt9,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt9
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt10,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt10
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt11,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt11
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt12,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt12
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt13,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt13
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt14,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt14
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt15,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt15
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt16,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt16
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt17,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt17
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt18,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt18
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt19,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt19
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_amt20,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_amt20         
         CALL axcq801_diff()   #fengmy150217 
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle ,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle    #160714-00027#1
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle1,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle1
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle2,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle2
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle3,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle3
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle4,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle4
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle5,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle5
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle6,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle6
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle7,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle7
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle8,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle8
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle9,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle9
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle10,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle10
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle11,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle11
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle12,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle12
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle13,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle13
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle14,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle14
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle15,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle15
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle16,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle16
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle17,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle17
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle18,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle18
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle19,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle19
         CALL s_num_round(l_round_type,g_xcfj_d[l_ac].l_idle20,g_ooaj004) RETURNING g_xcfj_d[l_ac].l_idle20

#fengmy150217----mark----begin
#         IF g_cn = 1 THEN             
#            LET g_xcfj_d[l_ac].l_amt1 = g_xcfj_d[l_ac].l_amount 
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1
#         END IF
#         IF g_cn = 2 THEN             
#            LET g_xcfj_d[l_ac].l_amt2 = g_xcfj_d[l_ac].l_amount - g_xcfj_d[l_ac].l_amt1
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2
#         END IF
#         IF g_cn = 3 THEN 
#            LET g_xcfj_d[l_ac].l_amt3 = g_xcfj_d[l_ac].l_amount - (g_xcfj_d[l_ac].l_amt1 + g_xcfj_d[l_ac].l_amt2)
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3
#         END IF
#         IF g_cn = 4 THEN 
#            LET g_xcfj_d[l_ac].l_amt4 = g_xcfj_d[l_ac].l_amount - (g_xcfj_d[l_ac].l_amt1 + g_xcfj_d[l_ac].l_amt2 + g_xcfj_d[l_ac].l_amt3)
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3 + g_xcfj_d[l_ac].l_idle4
#         END IF
#         IF g_cn = 5 THEN 
#            LET g_xcfj_d[l_ac].l_amt5 = g_xcfj_d[l_ac].l_amount - 
#                                     (g_xcfj_d[l_ac].l_amt1 + g_xcfj_d[l_ac].l_amt2 + g_xcfj_d[l_ac].l_amt3 + g_xcfj_d[l_ac].l_amt4)
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3 
#                                        + g_xcfj_d[l_ac].l_idle4 + g_xcfj_d[l_ac].l_idle5
#         END IF
#         IF g_cn = 6 THEN 
#            LET g_xcfj_d[l_ac].l_amt6 = g_xcfj_d[l_ac].l_amount - 
#                                     (g_xcfj_d[l_ac].l_amt1 + g_xcfj_d[l_ac].l_amt2 + g_xcfj_d[l_ac].l_amt3 
#                                      + g_xcfj_d[l_ac].l_amt4 + g_xcfj_d[l_ac].l_amt5)
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3 
#                                        + g_xcfj_d[l_ac].l_idle4 + g_xcfj_d[l_ac].l_idle5 + g_xcfj_d[l_ac].l_idle6
#         END IF
#         IF g_cn = 7 THEN 
#            LET g_xcfj_d[l_ac].l_amt7 = g_xcfj_d[l_ac].l_amount - 
#                                     (g_xcfj_d[l_ac].l_amt1 + g_xcfj_d[l_ac].l_amt2 + g_xcfj_d[l_ac].l_amt3 
#                                      + g_xcfj_d[l_ac].l_amt4 + g_xcfj_d[l_ac].l_amt5 + g_xcfj_d[l_ac].l_amt6)
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3 
#                                        + g_xcfj_d[l_ac].l_idle4 + g_xcfj_d[l_ac].l_idle5 + g_xcfj_d[l_ac].l_idle6
#                                        + g_xcfj_d[l_ac].l_idle7
#         END IF
#         IF g_cn = 8 THEN 
#            LET g_xcfj_d[l_ac].l_amt8 = g_xcfj_d[l_ac].l_amount - 
#                                     (g_xcfj_d[l_ac].l_amt1 + g_xcfj_d[l_ac].l_amt2 + g_xcfj_d[l_ac].l_amt3 
#                                      + g_xcfj_d[l_ac].l_amt4 + g_xcfj_d[l_ac].l_amt5 + g_xcfj_d[l_ac].l_amt6 
#                                      + g_xcfj_d[l_ac].l_amt7)
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3 
#                                        + g_xcfj_d[l_ac].l_idle4 + g_xcfj_d[l_ac].l_idle5 + g_xcfj_d[l_ac].l_idle6
#                                        + g_xcfj_d[l_ac].l_idle7 + g_xcfj_d[l_ac].l_idle8
#         END IF
#         IF g_cn = 9 THEN 
#            LET g_xcfj_d[l_ac].l_amt9 = (g_xcfj_d[l_ac].l_amt1 + g_xcfj_d[l_ac].l_amt2 + g_xcfj_d[l_ac].l_amt3 
#                                      + g_xcfj_d[l_ac].l_amt4 + g_xcfj_d[l_ac].l_amt5 + g_xcfj_d[l_ac].l_amt6 
#                                      + g_xcfj_d[l_ac].l_amt7 + g_xcfj_d[l_ac].l_amt8)
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3 
#                                        + g_xcfj_d[l_ac].l_idle4 + g_xcfj_d[l_ac].l_idle5 + g_xcfj_d[l_ac].l_idle6
#                                        + g_xcfj_d[l_ac].l_idle7 + g_xcfj_d[l_ac].l_idle8 + g_xcfj_d[l_ac].l_idle9
#         END IF
#         IF g_cn = 10 THEN 
#            LET g_xcfj_d[l_ac].l_amt10 = (g_xcfj_d[l_ac].l_amt1 + g_xcfj_d[l_ac].l_amt2 + g_xcfj_d[l_ac].l_amt3 
#                                      + g_xcfj_d[l_ac].l_amt4 + g_xcfj_d[l_ac].l_amt5 + g_xcfj_d[l_ac].l_amt6 
#                                      + g_xcfj_d[l_ac].l_amt7 + g_xcfj_d[l_ac].l_amt8 + g_xcfj_d[l_ac].l_amt9)
#            LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3 
#                                        + g_xcfj_d[l_ac].l_idle4 + g_xcfj_d[l_ac].l_idle5 + g_xcfj_d[l_ac].l_idle6
#                                        + g_xcfj_d[l_ac].l_idle7 + g_xcfj_d[l_ac].l_idle8 + g_xcfj_d[l_ac].l_idle9 
#                                        + g_xcfj_d[l_ac].l_idle10
#         END IF
         #fengmy150217----mark----end
                  
         #end add-point
      
         #帶出公用欄位reference值
               
         #add-point:單身資料抓取
         #总计
         LET l_amount_total= l_amount_total+ g_xcfj_d[l_ac].l_amount
         LET l_amt1_total  = l_amt1_total  + g_xcfj_d[l_ac].l_amt1  
         LET l_amt2_total  = l_amt2_total  + g_xcfj_d[l_ac].l_amt2  
         LET l_amt3_total  = l_amt3_total  + g_xcfj_d[l_ac].l_amt3  
         LET l_amt4_total  = l_amt4_total  + g_xcfj_d[l_ac].l_amt4  
         LET l_amt5_total  = l_amt5_total  + g_xcfj_d[l_ac].l_amt5  
         LET l_amt6_total  = l_amt6_total  + g_xcfj_d[l_ac].l_amt6  
         LET l_amt7_total  = l_amt7_total  + g_xcfj_d[l_ac].l_amt7  
         LET l_amt8_total  = l_amt8_total  + g_xcfj_d[l_ac].l_amt8  
         LET l_amt9_total  = l_amt9_total  + g_xcfj_d[l_ac].l_amt9  
         LET l_amt10_total = l_amt10_total + g_xcfj_d[l_ac].l_amt10 
         LET l_amt11_total  = l_amt11_total + g_xcfj_d[l_ac].l_amt11  
         LET l_amt12_total  = l_amt12_total + g_xcfj_d[l_ac].l_amt12  
         LET l_amt13_total  = l_amt13_total + g_xcfj_d[l_ac].l_amt13  
         LET l_amt14_total  = l_amt14_total + g_xcfj_d[l_ac].l_amt14  
         LET l_amt15_total  = l_amt15_total + g_xcfj_d[l_ac].l_amt15  
         LET l_amt16_total  = l_amt16_total + g_xcfj_d[l_ac].l_amt16  
         LET l_amt17_total  = l_amt17_total + g_xcfj_d[l_ac].l_amt17  
         LET l_amt18_total  = l_amt18_total + g_xcfj_d[l_ac].l_amt18  
         LET l_amt19_total  = l_amt19_total + g_xcfj_d[l_ac].l_amt19  
         LET l_amt20_total = l_amt20_total + g_xcfj_d[l_ac].l_amt20          
         LET l_idle_total  = l_idle_total  + g_xcfj_d[l_ac].l_idle  
         LET l_idle1_total = l_idle1_total + g_xcfj_d[l_ac].l_idle1 
         LET l_idle2_total = l_idle2_total + g_xcfj_d[l_ac].l_idle2 
         LET l_idle3_total = l_idle3_total + g_xcfj_d[l_ac].l_idle3 
         LET l_idle4_total = l_idle4_total + g_xcfj_d[l_ac].l_idle4 
         LET l_idle5_total = l_idle5_total + g_xcfj_d[l_ac].l_idle5 
         LET l_idle6_total = l_idle6_total + g_xcfj_d[l_ac].l_idle6 
         LET l_idle7_total = l_idle7_total + g_xcfj_d[l_ac].l_idle7 
         LET l_idle8_total = l_idle8_total + g_xcfj_d[l_ac].l_idle8 
         LET l_idle9_total = l_idle9_total + g_xcfj_d[l_ac].l_idle9 
         LET l_idle10_total= l_idle10_total+ g_xcfj_d[l_ac].l_idle10
         LET l_idle11_total = l_idle11_total + g_xcfj_d[l_ac].l_idle11 
         LET l_idle12_total = l_idle12_total + g_xcfj_d[l_ac].l_idle12 
         LET l_idle13_total = l_idle13_total + g_xcfj_d[l_ac].l_idle13 
         LET l_idle14_total = l_idle14_total + g_xcfj_d[l_ac].l_idle14 
         LET l_idle15_total = l_idle15_total + g_xcfj_d[l_ac].l_idle15 
         LET l_idle16_total = l_idle16_total + g_xcfj_d[l_ac].l_idle16 
         LET l_idle17_total = l_idle17_total + g_xcfj_d[l_ac].l_idle17 
         LET l_idle18_total = l_idle18_total + g_xcfj_d[l_ac].l_idle18 
         LET l_idle19_total = l_idle19_total + g_xcfj_d[l_ac].l_idle19 
         LET l_idle20_total= l_idle20_total+ g_xcfj_d[l_ac].l_idle20
         #小计--材料分类
         LET l_amount_sum= l_amount_sum+ g_xcfj_d[l_ac].l_amount
         LET l_amt1_sum  = l_amt1_sum  + g_xcfj_d[l_ac].l_amt1  
         LET l_amt2_sum  = l_amt2_sum  + g_xcfj_d[l_ac].l_amt2  
         LET l_amt3_sum  = l_amt3_sum  + g_xcfj_d[l_ac].l_amt3  
         LET l_amt4_sum  = l_amt4_sum  + g_xcfj_d[l_ac].l_amt4  
         LET l_amt5_sum  = l_amt5_sum  + g_xcfj_d[l_ac].l_amt5  
         LET l_amt6_sum  = l_amt6_sum  + g_xcfj_d[l_ac].l_amt6  
         LET l_amt7_sum  = l_amt7_sum  + g_xcfj_d[l_ac].l_amt7  
         LET l_amt8_sum  = l_amt8_sum  + g_xcfj_d[l_ac].l_amt8  
         LET l_amt9_sum  = l_amt9_sum  + g_xcfj_d[l_ac].l_amt9  
         LET l_amt10_sum = l_amt10_sum + g_xcfj_d[l_ac].l_amt10 
         LET l_amt11_sum  = l_amt11_sum  + g_xcfj_d[l_ac].l_amt11  
         LET l_amt12_sum  = l_amt12_sum  + g_xcfj_d[l_ac].l_amt12  
         LET l_amt13_sum  = l_amt13_sum  + g_xcfj_d[l_ac].l_amt13  
         LET l_amt14_sum  = l_amt14_sum  + g_xcfj_d[l_ac].l_amt14  
         LET l_amt15_sum  = l_amt15_sum  + g_xcfj_d[l_ac].l_amt15  
         LET l_amt16_sum  = l_amt16_sum  + g_xcfj_d[l_ac].l_amt16  
         LET l_amt17_sum  = l_amt17_sum  + g_xcfj_d[l_ac].l_amt17  
         LET l_amt18_sum  = l_amt18_sum  + g_xcfj_d[l_ac].l_amt18  
         LET l_amt19_sum  = l_amt19_sum  + g_xcfj_d[l_ac].l_amt19  
         LET l_amt20_sum = l_amt20_sum + g_xcfj_d[l_ac].l_amt20 
         LET l_idle_sum  = l_idle_sum  + g_xcfj_d[l_ac].l_idle  
         LET l_idle1_sum = l_idle1_sum + g_xcfj_d[l_ac].l_idle1 
         LET l_idle2_sum = l_idle2_sum + g_xcfj_d[l_ac].l_idle2 
         LET l_idle3_sum = l_idle3_sum + g_xcfj_d[l_ac].l_idle3 
         LET l_idle4_sum = l_idle4_sum + g_xcfj_d[l_ac].l_idle4 
         LET l_idle5_sum = l_idle5_sum + g_xcfj_d[l_ac].l_idle5 
         LET l_idle6_sum = l_idle6_sum + g_xcfj_d[l_ac].l_idle6 
         LET l_idle7_sum = l_idle7_sum + g_xcfj_d[l_ac].l_idle7 
         LET l_idle8_sum = l_idle8_sum + g_xcfj_d[l_ac].l_idle8 
         LET l_idle9_sum = l_idle9_sum + g_xcfj_d[l_ac].l_idle9 
         LET l_idle10_sum= l_idle10_sum+ g_xcfj_d[l_ac].l_idle10
         LET l_idle11_sum = l_idle11_sum + g_xcfj_d[l_ac].l_idle11 
         LET l_idle12_sum = l_idle12_sum + g_xcfj_d[l_ac].l_idle12 
         LET l_idle13_sum = l_idle13_sum + g_xcfj_d[l_ac].l_idle13 
         LET l_idle14_sum = l_idle14_sum + g_xcfj_d[l_ac].l_idle14 
         LET l_idle15_sum = l_idle15_sum + g_xcfj_d[l_ac].l_idle15 
         LET l_idle16_sum = l_idle16_sum + g_xcfj_d[l_ac].l_idle16 
         LET l_idle17_sum = l_idle17_sum + g_xcfj_d[l_ac].l_idle17 
         LET l_idle18_sum = l_idle18_sum + g_xcfj_d[l_ac].l_idle18 
         LET l_idle19_sum = l_idle19_sum + g_xcfj_d[l_ac].l_idle19 
         LET l_idle20_sum= l_idle20_sum+ g_xcfj_d[l_ac].l_idle20
         IF l_ac > 1 THEN
            IF g_xcfj_d[l_ac].xcfb010 != g_xcfj_d[l_ac - 1].xcfb010 THEN
               LET g_xcfj_d[l_ac + 1].* = g_xcfj_d[l_ac].* 
               INITIALIZE  g_xcfj_d[l_ac].* TO NULL
               LET g_xcfj_d[l_ac].xcfb010_desc = cl_getmsg("axc-00205",g_lang) 
               LET g_xcfj_d[l_ac].l_amount= l_amount_sum- g_xcfj_d[l_ac + 1].l_amount
               LET g_xcfj_d[l_ac].l_amt1  = l_amt1_sum  - g_xcfj_d[l_ac + 1].l_amt1  
               LET g_xcfj_d[l_ac].l_amt2  = l_amt2_sum  - g_xcfj_d[l_ac + 1].l_amt2  
               LET g_xcfj_d[l_ac].l_amt3  = l_amt3_sum  - g_xcfj_d[l_ac + 1].l_amt3  
               LET g_xcfj_d[l_ac].l_amt4  = l_amt4_sum  - g_xcfj_d[l_ac + 1].l_amt4  
               LET g_xcfj_d[l_ac].l_amt5  = l_amt5_sum  - g_xcfj_d[l_ac + 1].l_amt5  
               LET g_xcfj_d[l_ac].l_amt6  = l_amt6_sum  - g_xcfj_d[l_ac + 1].l_amt6  
               LET g_xcfj_d[l_ac].l_amt7  = l_amt7_sum  - g_xcfj_d[l_ac + 1].l_amt7  
               LET g_xcfj_d[l_ac].l_amt8  = l_amt8_sum  - g_xcfj_d[l_ac + 1].l_amt8  
               LET g_xcfj_d[l_ac].l_amt9  = l_amt9_sum  - g_xcfj_d[l_ac + 1].l_amt9  
               LET g_xcfj_d[l_ac].l_amt10 = l_amt10_sum - g_xcfj_d[l_ac + 1].l_amt10 
               LET g_xcfj_d[l_ac].l_amt11  = l_amt11_sum  - g_xcfj_d[l_ac + 1].l_amt11  
               LET g_xcfj_d[l_ac].l_amt12  = l_amt12_sum  - g_xcfj_d[l_ac + 1].l_amt12  
               LET g_xcfj_d[l_ac].l_amt13  = l_amt13_sum  - g_xcfj_d[l_ac + 1].l_amt13  
               LET g_xcfj_d[l_ac].l_amt14  = l_amt14_sum  - g_xcfj_d[l_ac + 1].l_amt14  
               LET g_xcfj_d[l_ac].l_amt15  = l_amt15_sum  - g_xcfj_d[l_ac + 1].l_amt15  
               LET g_xcfj_d[l_ac].l_amt16  = l_amt16_sum  - g_xcfj_d[l_ac + 1].l_amt16  
               LET g_xcfj_d[l_ac].l_amt17  = l_amt17_sum  - g_xcfj_d[l_ac + 1].l_amt17  
               LET g_xcfj_d[l_ac].l_amt18  = l_amt18_sum  - g_xcfj_d[l_ac + 1].l_amt18  
               LET g_xcfj_d[l_ac].l_amt19  = l_amt19_sum  - g_xcfj_d[l_ac + 1].l_amt19  
               LET g_xcfj_d[l_ac].l_amt20 = l_amt20_sum - g_xcfj_d[l_ac + 1].l_amt20 
               LET g_xcfj_d[l_ac].l_idle  = l_idle_sum  - g_xcfj_d[l_ac + 1].l_idle  
               LET g_xcfj_d[l_ac].l_idle1 = l_idle1_sum - g_xcfj_d[l_ac + 1].l_idle1 
               LET g_xcfj_d[l_ac].l_idle2 = l_idle2_sum - g_xcfj_d[l_ac + 1].l_idle2 
               LET g_xcfj_d[l_ac].l_idle3 = l_idle3_sum - g_xcfj_d[l_ac + 1].l_idle3 
               LET g_xcfj_d[l_ac].l_idle4 = l_idle4_sum - g_xcfj_d[l_ac + 1].l_idle4 
               LET g_xcfj_d[l_ac].l_idle5 = l_idle5_sum - g_xcfj_d[l_ac + 1].l_idle5 
               LET g_xcfj_d[l_ac].l_idle6 = l_idle6_sum - g_xcfj_d[l_ac + 1].l_idle6 
               LET g_xcfj_d[l_ac].l_idle7 = l_idle7_sum - g_xcfj_d[l_ac + 1].l_idle7 
               LET g_xcfj_d[l_ac].l_idle8 = l_idle8_sum - g_xcfj_d[l_ac + 1].l_idle8 
               LET g_xcfj_d[l_ac].l_idle9 = l_idle9_sum - g_xcfj_d[l_ac + 1].l_idle9 
               LET g_xcfj_d[l_ac].l_idle10= l_idle10_sum- g_xcfj_d[l_ac + 1].l_idle10
               LET g_xcfj_d[l_ac].l_idle11 = l_idle11_sum - g_xcfj_d[l_ac + 1].l_idle11 
               LET g_xcfj_d[l_ac].l_idle12 = l_idle12_sum - g_xcfj_d[l_ac + 1].l_idle12 
               LET g_xcfj_d[l_ac].l_idle13 = l_idle13_sum - g_xcfj_d[l_ac + 1].l_idle13 
               LET g_xcfj_d[l_ac].l_idle14 = l_idle14_sum - g_xcfj_d[l_ac + 1].l_idle14 
               LET g_xcfj_d[l_ac].l_idle15 = l_idle15_sum - g_xcfj_d[l_ac + 1].l_idle15 
               LET g_xcfj_d[l_ac].l_idle16 = l_idle16_sum - g_xcfj_d[l_ac + 1].l_idle16 
               LET g_xcfj_d[l_ac].l_idle17 = l_idle17_sum - g_xcfj_d[l_ac + 1].l_idle17 
               LET g_xcfj_d[l_ac].l_idle18 = l_idle18_sum - g_xcfj_d[l_ac + 1].l_idle18 
               LET g_xcfj_d[l_ac].l_idle19 = l_idle19_sum - g_xcfj_d[l_ac + 1].l_idle19 
               LET g_xcfj_d[l_ac].l_idle20= l_idle20_sum- g_xcfj_d[l_ac + 1].l_idle20
               LET l_ac = l_ac + 1
               LET l_amount_sum= g_xcfj_d[l_ac].l_amount
               LET l_amt1_sum  = g_xcfj_d[l_ac].l_amt1  
               LET l_amt2_sum  = g_xcfj_d[l_ac].l_amt2  
               LET l_amt3_sum  = g_xcfj_d[l_ac].l_amt3  
               LET l_amt4_sum  = g_xcfj_d[l_ac].l_amt4  
               LET l_amt5_sum  = g_xcfj_d[l_ac].l_amt5  
               LET l_amt6_sum  = g_xcfj_d[l_ac].l_amt6  
               LET l_amt7_sum  = g_xcfj_d[l_ac].l_amt7  
               LET l_amt8_sum  = g_xcfj_d[l_ac].l_amt8  
               LET l_amt9_sum  = g_xcfj_d[l_ac].l_amt9  
               LET l_amt10_sum = g_xcfj_d[l_ac].l_amt10 
               LET l_amt11_sum  = g_xcfj_d[l_ac].l_amt11  
               LET l_amt12_sum  = g_xcfj_d[l_ac].l_amt12  
               LET l_amt13_sum  = g_xcfj_d[l_ac].l_amt13  
               LET l_amt14_sum  = g_xcfj_d[l_ac].l_amt14  
               LET l_amt15_sum  = g_xcfj_d[l_ac].l_amt15  
               LET l_amt16_sum  = g_xcfj_d[l_ac].l_amt16  
               LET l_amt17_sum  = g_xcfj_d[l_ac].l_amt17  
               LET l_amt18_sum  = g_xcfj_d[l_ac].l_amt18  
               LET l_amt19_sum  = g_xcfj_d[l_ac].l_amt19  
               LET l_amt20_sum = g_xcfj_d[l_ac].l_amt20 
               LET l_idle_sum  = g_xcfj_d[l_ac].l_idle  
               LET l_idle1_sum = g_xcfj_d[l_ac].l_idle1 
               LET l_idle2_sum = g_xcfj_d[l_ac].l_idle2 
               LET l_idle3_sum = g_xcfj_d[l_ac].l_idle3 
               LET l_idle4_sum = g_xcfj_d[l_ac].l_idle4 
               LET l_idle5_sum = g_xcfj_d[l_ac].l_idle5 
               LET l_idle6_sum = g_xcfj_d[l_ac].l_idle6 
               LET l_idle7_sum = g_xcfj_d[l_ac].l_idle7 
               LET l_idle8_sum = g_xcfj_d[l_ac].l_idle8 
               LET l_idle9_sum = g_xcfj_d[l_ac].l_idle9 
               LET l_idle10_sum= g_xcfj_d[l_ac].l_idle10    
               LET l_idle11_sum = g_xcfj_d[l_ac].l_idle11 
               LET l_idle12_sum = g_xcfj_d[l_ac].l_idle12 
               LET l_idle13_sum = g_xcfj_d[l_ac].l_idle13 
               LET l_idle14_sum = g_xcfj_d[l_ac].l_idle14 
               LET l_idle15_sum = g_xcfj_d[l_ac].l_idle15 
               LET l_idle16_sum = g_xcfj_d[l_ac].l_idle16 
               LET l_idle17_sum = g_xcfj_d[l_ac].l_idle17 
               LET l_idle18_sum = g_xcfj_d[l_ac].l_idle18 
               LET l_idle19_sum = g_xcfj_d[l_ac].l_idle19 
               LET l_idle20_sum= g_xcfj_d[l_ac].l_idle20                 
            END IF
         END IF
         #141218-0001---(s)---               
         LET l_xcfb010_desc = g_xcfj_d[l_ac].xcfb010,".",g_xcfj_d[l_ac].xcfb010_desc
         LET l_imaa003_desc = g_xcfj_d[l_ac].imaa003,".",g_xcfj_d[l_ac].imaa003_desc
         LET l_imag011_desc = g_xcfj_d[l_ac].imag011,".",g_xcfj_d[l_ac].imag011_desc
         LET l_xcfj001_desc = g_xcfj_d[l_ac].xcfj001,".",g_xcfj_d[l_ac].xcfj001_desc
         
         LET l_xcfj005_desc = g_xcfj_d[l_ac].xcfj005,".",g_xcfj_d[l_ac].xcfj005_desc
         IF NOT cl_null(g_xcfj_d[l_ac].xcfj005_desc_desc) THEN
            LET l_xcfj005_desc = l_xcfj005_desc,".",g_xcfj_d[l_ac].xcfj005_desc_desc
         END IF
         LET l_ld_desc   = g_xcfj_m.xcfjld,".",g_xcfj_m.xcfjld_desc
         LET l_comp_desc = g_xcfj_m.xcfjcomp,".",g_xcfj_m.xcfjcomp_desc
         LET l_year = g_xcfj_m.xcfj003
         LET l_mon  = g_xcfj_m.xcfj004
         LET l_xcfj002   = g_xcfj_m.xcfj002,".",g_xcfj_m.xcfj002_desc
         LET l_xrcc001   = g_xcfj_m.xccc001,".",s_desc_gzcbl004_desc('8914',g_xcfj_m.xccc001)
         LET l_xcfa004   = g_xcfj_m.xcfa004,".",s_desc_gzcbl004_desc('8043',g_xcfj_m.xcfa004)         
         
         INSERT INTO axcq801_tmp01            #160727-00019#21 Mod  axcq801_print_tmp--> axcq801_tmp01
         VALUES(l_xcfb010_desc,l_imaa003_desc,l_imag011_desc,l_xcfj001_desc,l_xcfj005_desc,
                g_xcfj_d[l_ac].xcfj006,g_xcfj_d[l_ac].xcfj007,g_xcfj_d[l_ac].xcfj009,
                g_xcfj_d[l_ac].xccc280,g_xcfj_d[l_ac].l_amount,g_xcfj_d[l_ac].l_idle,                  
                g_xcfj_d[l_ac].l_qty1,g_xcfj_d[l_ac].l_amt1,g_xcfj_d[l_ac].l_rate1/100,g_xcfj_d[l_ac].l_idle1,
                g_xcfj_d[l_ac].l_qty2,g_xcfj_d[l_ac].l_amt2,g_xcfj_d[l_ac].l_rate2/100,g_xcfj_d[l_ac].l_idle2,
                g_xcfj_d[l_ac].l_qty3,g_xcfj_d[l_ac].l_amt3,g_xcfj_d[l_ac].l_rate3/100,g_xcfj_d[l_ac].l_idle3,
                g_xcfj_d[l_ac].l_qty4,g_xcfj_d[l_ac].l_amt4,g_xcfj_d[l_ac].l_rate4/100,g_xcfj_d[l_ac].l_idle4,
                g_xcfj_d[l_ac].l_qty5,g_xcfj_d[l_ac].l_amt5,g_xcfj_d[l_ac].l_rate5/100,g_xcfj_d[l_ac].l_idle5,
                g_xcfj_d[l_ac].l_qty6,g_xcfj_d[l_ac].l_amt6,g_xcfj_d[l_ac].l_rate6/100,g_xcfj_d[l_ac].l_idle6,
                g_xcfj_d[l_ac].l_qty7,g_xcfj_d[l_ac].l_amt7,g_xcfj_d[l_ac].l_rate7/100,g_xcfj_d[l_ac].l_idle7,
                g_xcfj_d[l_ac].l_qty8,g_xcfj_d[l_ac].l_amt8,g_xcfj_d[l_ac].l_rate8/100,g_xcfj_d[l_ac].l_idle8,
                g_xcfj_d[l_ac].l_qty9,g_xcfj_d[l_ac].l_amt9,g_xcfj_d[l_ac].l_rate9/100,g_xcfj_d[l_ac].l_idle9,
                g_xcfj_d[l_ac].l_qty10,g_xcfj_d[l_ac].l_amt10,g_xcfj_d[l_ac].l_rate10/100,g_xcfj_d[l_ac].l_idle10,
                g_xcfj_d[l_ac].l_qty11,g_xcfj_d[l_ac].l_amt11,g_xcfj_d[l_ac].l_rate11/100,g_xcfj_d[l_ac].l_idle11,
                g_xcfj_d[l_ac].l_qty12,g_xcfj_d[l_ac].l_amt12,g_xcfj_d[l_ac].l_rate12/100,g_xcfj_d[l_ac].l_idle12,
                g_xcfj_d[l_ac].l_qty13,g_xcfj_d[l_ac].l_amt13,g_xcfj_d[l_ac].l_rate13/100,g_xcfj_d[l_ac].l_idle13,
                g_xcfj_d[l_ac].l_qty14,g_xcfj_d[l_ac].l_amt14,g_xcfj_d[l_ac].l_rate14/100,g_xcfj_d[l_ac].l_idle14,
                g_xcfj_d[l_ac].l_qty15,g_xcfj_d[l_ac].l_amt15,g_xcfj_d[l_ac].l_rate15/100,g_xcfj_d[l_ac].l_idle15,
                g_xcfj_d[l_ac].l_qty16,g_xcfj_d[l_ac].l_amt16,g_xcfj_d[l_ac].l_rate16/100,g_xcfj_d[l_ac].l_idle16,
                g_xcfj_d[l_ac].l_qty17,g_xcfj_d[l_ac].l_amt17,g_xcfj_d[l_ac].l_rate17/100,g_xcfj_d[l_ac].l_idle17,
                g_xcfj_d[l_ac].l_qty18,g_xcfj_d[l_ac].l_amt18,g_xcfj_d[l_ac].l_rate18/100,g_xcfj_d[l_ac].l_idle18,
                g_xcfj_d[l_ac].l_qty19,g_xcfj_d[l_ac].l_amt19,g_xcfj_d[l_ac].l_rate19/100,g_xcfj_d[l_ac].l_idle19,
                g_xcfj_d[l_ac].l_qty20,g_xcfj_d[l_ac].l_amt20,g_xcfj_d[l_ac].l_rate20/100,g_xcfj_d[l_ac].l_idle20,                
                l_ld_desc,l_comp_desc,l_year,l_mon,l_xcfj002,l_xrcc001,l_xcfa004)
         #141218-0001---(e)---      
         
         
         
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
 
            CALL g_xcfj_d.deleteElement(g_xcfj_d.getLength())
 
      
   END IF
   IF l_ac > 1 THEN
      #小计
      LET g_xcfj_d[l_ac].xcfb010_desc = cl_getmsg("axc-00205",g_lang)
      LET g_xcfj_d[l_ac].l_amount= l_amount_sum
      LET g_xcfj_d[l_ac].l_amt1  = l_amt1_sum  
      LET g_xcfj_d[l_ac].l_amt2  = l_amt2_sum  
      LET g_xcfj_d[l_ac].l_amt3  = l_amt3_sum  
      LET g_xcfj_d[l_ac].l_amt4  = l_amt4_sum  
      LET g_xcfj_d[l_ac].l_amt5  = l_amt5_sum  
      LET g_xcfj_d[l_ac].l_amt6  = l_amt6_sum  
      LET g_xcfj_d[l_ac].l_amt7  = l_amt7_sum  
      LET g_xcfj_d[l_ac].l_amt8  = l_amt8_sum  
      LET g_xcfj_d[l_ac].l_amt9  = l_amt9_sum  
      LET g_xcfj_d[l_ac].l_amt10 = l_amt10_sum 
      LET g_xcfj_d[l_ac].l_amt11  = l_amt11_sum  
      LET g_xcfj_d[l_ac].l_amt12  = l_amt12_sum  
      LET g_xcfj_d[l_ac].l_amt13  = l_amt13_sum  
      LET g_xcfj_d[l_ac].l_amt14  = l_amt14_sum  
      LET g_xcfj_d[l_ac].l_amt15  = l_amt15_sum  
      LET g_xcfj_d[l_ac].l_amt16  = l_amt16_sum  
      LET g_xcfj_d[l_ac].l_amt17  = l_amt17_sum  
      LET g_xcfj_d[l_ac].l_amt18  = l_amt18_sum  
      LET g_xcfj_d[l_ac].l_amt19  = l_amt19_sum  
      LET g_xcfj_d[l_ac].l_amt20 = l_amt20_sum 
      LET g_xcfj_d[l_ac].l_idle  = l_idle_sum  
      LET g_xcfj_d[l_ac].l_idle1 = l_idle1_sum 
      LET g_xcfj_d[l_ac].l_idle2 = l_idle2_sum 
      LET g_xcfj_d[l_ac].l_idle3 = l_idle3_sum 
      LET g_xcfj_d[l_ac].l_idle4 = l_idle4_sum 
      LET g_xcfj_d[l_ac].l_idle5 = l_idle5_sum 
      LET g_xcfj_d[l_ac].l_idle6 = l_idle6_sum 
      LET g_xcfj_d[l_ac].l_idle7 = l_idle7_sum 
      LET g_xcfj_d[l_ac].l_idle8 = l_idle8_sum 
      LET g_xcfj_d[l_ac].l_idle9 = l_idle9_sum 
      LET g_xcfj_d[l_ac].l_idle10= l_idle10_sum
      LET g_xcfj_d[l_ac].l_idle11 = l_idle11_sum 
      LET g_xcfj_d[l_ac].l_idle12 = l_idle12_sum 
      LET g_xcfj_d[l_ac].l_idle13 = l_idle13_sum 
      LET g_xcfj_d[l_ac].l_idle14 = l_idle14_sum 
      LET g_xcfj_d[l_ac].l_idle15 = l_idle15_sum 
      LET g_xcfj_d[l_ac].l_idle16 = l_idle16_sum 
      LET g_xcfj_d[l_ac].l_idle17 = l_idle17_sum 
      LET g_xcfj_d[l_ac].l_idle18 = l_idle18_sum 
      LET g_xcfj_d[l_ac].l_idle19 = l_idle19_sum 
      LET g_xcfj_d[l_ac].l_idle20= l_idle20_sum
      LET l_ac = l_ac + 1
      #合计
      LET g_xcfj_d[l_ac].xcfb010_desc = cl_getmsg("axc-00204",g_lang)
      LET g_xcfj_d[l_ac].l_amount= l_amount_total
      LET g_xcfj_d[l_ac].l_amt1  = l_amt1_total  
      LET g_xcfj_d[l_ac].l_amt2  = l_amt2_total  
      LET g_xcfj_d[l_ac].l_amt3  = l_amt3_total  
      LET g_xcfj_d[l_ac].l_amt4  = l_amt4_total  
      LET g_xcfj_d[l_ac].l_amt5  = l_amt5_total  
      LET g_xcfj_d[l_ac].l_amt6  = l_amt6_total  
      LET g_xcfj_d[l_ac].l_amt7  = l_amt7_total  
      LET g_xcfj_d[l_ac].l_amt8  = l_amt8_total  
      LET g_xcfj_d[l_ac].l_amt9  = l_amt9_total  
      LET g_xcfj_d[l_ac].l_amt10 = l_amt10_total 
      LET g_xcfj_d[l_ac].l_amt11  = l_amt11_total  
      LET g_xcfj_d[l_ac].l_amt12  = l_amt12_total  
      LET g_xcfj_d[l_ac].l_amt13  = l_amt13_total  
      LET g_xcfj_d[l_ac].l_amt14  = l_amt14_total  
      LET g_xcfj_d[l_ac].l_amt15  = l_amt15_total  
      LET g_xcfj_d[l_ac].l_amt16  = l_amt16_total  
      LET g_xcfj_d[l_ac].l_amt17  = l_amt17_total  
      LET g_xcfj_d[l_ac].l_amt18  = l_amt18_total  
      LET g_xcfj_d[l_ac].l_amt19  = l_amt19_total  
      LET g_xcfj_d[l_ac].l_amt20 = l_amt20_total 
      LET g_xcfj_d[l_ac].l_idle  = l_idle_total  
      LET g_xcfj_d[l_ac].l_idle1 = l_idle1_total 
      LET g_xcfj_d[l_ac].l_idle2 = l_idle2_total 
      LET g_xcfj_d[l_ac].l_idle3 = l_idle3_total 
      LET g_xcfj_d[l_ac].l_idle4 = l_idle4_total 
      LET g_xcfj_d[l_ac].l_idle5 = l_idle5_total 
      LET g_xcfj_d[l_ac].l_idle6 = l_idle6_total 
      LET g_xcfj_d[l_ac].l_idle7 = l_idle7_total 
      LET g_xcfj_d[l_ac].l_idle8 = l_idle8_total 
      LET g_xcfj_d[l_ac].l_idle9 = l_idle9_total 
      LET g_xcfj_d[l_ac].l_idle10= l_idle10_total
      LET g_xcfj_d[l_ac].l_idle11 = l_idle11_total 
      LET g_xcfj_d[l_ac].l_idle12 = l_idle12_total 
      LET g_xcfj_d[l_ac].l_idle13 = l_idle13_total 
      LET g_xcfj_d[l_ac].l_idle14 = l_idle14_total 
      LET g_xcfj_d[l_ac].l_idle15 = l_idle15_total 
      LET g_xcfj_d[l_ac].l_idle16 = l_idle16_total 
      LET g_xcfj_d[l_ac].l_idle17 = l_idle17_total 
      LET g_xcfj_d[l_ac].l_idle18 = l_idle18_total 
      LET g_xcfj_d[l_ac].l_idle19 = l_idle19_total 
      LET g_xcfj_d[l_ac].l_idle20= l_idle20_total
      LET l_ac = l_ac + 1
   END IF
   FREE axcq801_pb1  
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
PRIVATE FUNCTION axcq801_create_tmp()
   DROP TABLE axcq801_tmp
   CREATE TEMP TABLE axcq801_tmp(
      xcfj001 LIKE xcfj_t.xcfj001,
      xcfj005 LIKE xcfj_t.xcfj005,
      xcfj006 LIKE xcfj_t.xcfj006,
      xcfj007 LIKE xcfj_t.xcfj007,
      xccc901 LIKE xccc_t.xccc901,      
      xccc280 LIKE xccc_t.xccc280,
      xccc902 LIKE xccc_t.xccc902, 
      imaf051 LIKE imaf_t.imaf051,
      imaa003 LIKE imaa_t.imaa003,   #fengmy150216
      imag011 LIKE imag_t.imag011,   #fengmy150216
      qty1    LIKE xcfj_t.xcfj009,
      amt1    LIKE xccc_t.xccc280,
      rate1   LIKE xcfc_t.xcfc012,
      idle1   LIKE xccc_t.xccc280,
      qty2    LIKE xcfj_t.xcfj009,
      amt2    LIKE xccc_t.xccc280,
      rate2   LIKE xcfc_t.xcfc012,
      idle2   LIKE xccc_t.xccc280,
      qty3    LIKE xcfj_t.xcfj009,
      amt3    LIKE xccc_t.xccc280,
      rate3   LIKE xcfc_t.xcfc012,
      idle3   LIKE xccc_t.xccc280,
      qty4    LIKE xcfj_t.xcfj009,
      amt4    LIKE xccc_t.xccc280,
      rate4   LIKE xcfc_t.xcfc012,
      idle4   LIKE xccc_t.xccc280,
      qty5    LIKE xcfj_t.xcfj009,
      amt5    LIKE xccc_t.xccc280,
      rate5   LIKE xcfc_t.xcfc012,
      idle5   LIKE xccc_t.xccc280,
      qty6    LIKE xcfj_t.xcfj009,
      amt6    LIKE xccc_t.xccc280,
      rate6   LIKE xcfc_t.xcfc012,
      idle6   LIKE xccc_t.xccc280,
      qty7    LIKE xcfj_t.xcfj009,
      amt7    LIKE xccc_t.xccc280,
      rate7   LIKE xcfc_t.xcfc012,
      idle7   LIKE xccc_t.xccc280,
      qty8    LIKE xcfj_t.xcfj009,
      amt8    LIKE xccc_t.xccc280,
      rate8   LIKE xcfc_t.xcfc012,
      idle8   LIKE xccc_t.xccc280,
      qty9    LIKE xcfj_t.xcfj009,
      amt9    LIKE xccc_t.xccc280,
      rate9   LIKE xcfc_t.xcfc012,
      idle9   LIKE xccc_t.xccc280,
      qty10   LIKE xcfj_t.xcfj009,
      amt10   LIKE xccc_t.xccc280,
      rate10  LIKE xcfc_t.xcfc012,
      idle10  LIKE xccc_t.xccc280,
      qty11   LIKE xcfj_t.xcfj009,
      amt11   LIKE xccc_t.xccc280,
      rate11  LIKE xcfc_t.xcfc012,
      idle11  LIKE xccc_t.xccc280,  
      qty12   LIKE xcfj_t.xcfj009,
      amt12   LIKE xccc_t.xccc280,
      rate12  LIKE xcfc_t.xcfc012,
      idle12  LIKE xccc_t.xccc280,  
      qty13   LIKE xcfj_t.xcfj009,
      amt13   LIKE xccc_t.xccc280,
      rate13  LIKE xcfc_t.xcfc012,
      idle13  LIKE xccc_t.xccc280,  
      qty14   LIKE xcfj_t.xcfj009,
      amt14   LIKE xccc_t.xccc280,
      rate14  LIKE xcfc_t.xcfc012,
      idle14  LIKE xccc_t.xccc280,  
      qty15   LIKE xcfj_t.xcfj009,
      amt15   LIKE xccc_t.xccc280,
      rate15  LIKE xcfc_t.xcfc012,
      idle15  LIKE xccc_t.xccc280,  
      qty16   LIKE xcfj_t.xcfj009,
      amt16   LIKE xccc_t.xccc280,
      rate16  LIKE xcfc_t.xcfc012,
      idle16  LIKE xccc_t.xccc280,  
      qty17   LIKE xcfj_t.xcfj009,
      amt17   LIKE xccc_t.xccc280,
      rate17  LIKE xcfc_t.xcfc012,
      idle17  LIKE xccc_t.xccc280,  
      qty18   LIKE xcfj_t.xcfj009,
      amt18   LIKE xccc_t.xccc280,
      rate18  LIKE xcfc_t.xcfc012,
      idle18  LIKE xccc_t.xccc280,  
      qty19   LIKE xcfj_t.xcfj009,
      amt19   LIKE xccc_t.xccc280,
      rate19  LIKE xcfc_t.xcfc012,
      idle19  LIKE xccc_t.xccc280,  
      qty20   LIKE xcfj_t.xcfj009,
      amt20   LIKE xccc_t.xccc280,
      rate20  LIKE xcfc_t.xcfc012,
      idle20  LIKE xccc_t.xccc280 
   );   
   #141218-0001---(s)---
   DROP TABLE axcq801_tmp01          #160727-00019#21 Mod  axcq801_print_tmp--> axcq801_tmp01
   CREATE TEMP TABLE axcq801_tmp01(  #160727-00019#21 Mod  axcq801_print_tmp--> axcq801_tmp01
      xcfb010_desc  LIKE type_t.chr500, 
      imaa003_desc  LIKE type_t.chr500, 
      imag011_desc  LIKE type_t.chr500, 
      xcfj001_desc  LIKE type_t.chr500, 
      xcfj005_desc  LIKE type_t.chr500, 
      xcfj006 LIKE xcfj_t.xcfj006,      #特性 
      xcfj007 LIKE xcfj_t.xcfj007,      #批號
      xcfj009 LIKE xcfj_t.xcfj009,  
      xccc280 LIKE type_t.num20_6, 
      l_amount LIKE type_t.num20_6,
      l_idle   LIKE type_t.num20_6,    #呆滯成本     
      l_qty1 LIKE type_t.num20_6, 
      l_amt1 LIKE type_t.num20_6, 
      l_rate1 LIKE type_t.num20_6, 
      l_idle1 LIKE type_t.num20_6, 
      l_qty2 LIKE type_t.num20_6, 
      l_amt2 LIKE type_t.num20_6, 
      l_rate2 LIKE type_t.num20_6, 
      l_idle2 LIKE type_t.num20_6, 
      l_qty3 LIKE type_t.num20_6, 
      l_amt3 LIKE type_t.num20_6, 
      l_rate3 LIKE type_t.num20_6, 
      l_idle3 LIKE type_t.num20_6, 
      l_qty4 LIKE type_t.num20_6, 
      l_amt4 LIKE type_t.num20_6, 
      l_rate4 LIKE type_t.num20_6, 
      l_idle4 LIKE type_t.num20_6, 
      l_qty5 LIKE type_t.num20_6, 
      l_amt5 LIKE type_t.num20_6, 
      l_rate5 LIKE type_t.num20_6, 
      l_idle5 LIKE type_t.num20_6, 
      l_qty6 LIKE type_t.num20_6, 
      l_amt6 LIKE type_t.num20_6, 
      l_rate6 LIKE type_t.num20_6, 
      l_idle6 LIKE type_t.num20_6, 
      l_qty7 LIKE type_t.num20_6, 
      l_amt7 LIKE type_t.num20_6, 
      l_rate7 LIKE type_t.num20_6, 
      l_idle7 LIKE type_t.num20_6, 
      l_qty8 LIKE type_t.num20_6, 
      l_amt8 LIKE type_t.num20_6, 
      l_rate8 LIKE type_t.num20_6, 
      l_idle8 LIKE type_t.num20_6, 
      l_qty9 LIKE type_t.num20_6, 
      l_amt9 LIKE type_t.num20_6, 
      l_rate9     LIKE type_t.num20_6, 
      l_idle9     LIKE type_t.num20_6, 
      l_qty10     LIKE type_t.num20_6, 
      l_amt10     LIKE type_t.num20_6, 
      l_rate10    LIKE type_t.num20_6, 
      l_idle10    LIKE type_t.num20_6,
      l_qty11 LIKE type_t.num20_6, 
      l_amt11 LIKE type_t.num20_6, 
      l_rate11 LIKE type_t.num20_6, 
      l_idle11 LIKE type_t.num20_6, 
      l_qty12 LIKE type_t.num20_6, 
      l_amt12 LIKE type_t.num20_6, 
      l_rate12 LIKE type_t.num20_6, 
      l_idle12 LIKE type_t.num20_6, 
      l_qty13 LIKE type_t.num20_6, 
      l_amt13 LIKE type_t.num20_6, 
      l_rate13 LIKE type_t.num20_6, 
      l_idle13 LIKE type_t.num20_6, 
      l_qty14 LIKE type_t.num20_6, 
      l_amt14 LIKE type_t.num20_6, 
      l_rate14 LIKE type_t.num20_6, 
      l_idle14 LIKE type_t.num20_6, 
      l_qty15 LIKE type_t.num20_6, 
      l_amt15 LIKE type_t.num20_6, 
      l_rate15 LIKE type_t.num20_6, 
      l_idle15 LIKE type_t.num20_6, 
      l_qty16 LIKE type_t.num20_6, 
      l_amt16 LIKE type_t.num20_6, 
      l_rate16 LIKE type_t.num20_6, 
      l_idle16 LIKE type_t.num20_6, 
      l_qty17 LIKE type_t.num20_6, 
      l_amt17 LIKE type_t.num20_6, 
      l_rate17 LIKE type_t.num20_6, 
      l_idle17 LIKE type_t.num20_6, 
      l_qty18 LIKE type_t.num20_6, 
      l_amt18 LIKE type_t.num20_6, 
      l_rate18 LIKE type_t.num20_6, 
      l_idle18 LIKE type_t.num20_6, 
      l_qty19 LIKE type_t.num20_6, 
      l_amt19 LIKE type_t.num20_6, 
      l_rate19 LIKE type_t.num20_6, 
      l_idle19 LIKE type_t.num20_6, 
      l_qty20 LIKE type_t.num20_6, 
      l_amt20 LIKE type_t.num20_6, 
      l_rate20 LIKE type_t.num20_6, 
      l_idle20 LIKE type_t.num20_6,
      l_ld_desc   LIKE type_t.chr80,
      l_comp_desc LIKE type_t.chr80,
      l_year      LIKE xcfj_t.xcfj003,
      l_mon       LIKE xcfj_t.xcfj004,
      l_xcfj002   LIKE type_t.chr80,  #成本計算類型
      l_xrcc001   LIKE type_t.chr80,  #本位幣順序
      l_xcfa004   LIKE type_t.chr80   #呆滯計算方式    
   );   
   #141218-0001---(e)---
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
PRIVATE FUNCTION axcq801_insert_tmp()
   DEFINE l_str1 STRING
   DEFINE l_str2 STRING
   DEFINE l_sql  STRING 
   DEFINE l_sql1 STRING
   DEFINE l_sql2 STRING
   DEFINE l_sql3 STRING 
   DEFINE l_str  STRING   
   DEFINE l_cn  LIKE type_t.num5  
   #fengmy150216----begin
   DEFINE l_strq STRING
   DEFINE l_stra STRING
   DEFINE l_strr STRING
   DEFINE l_stri STRING
   DEFINE l_msg1 STRING
   DEFINE l_msg2 STRING
   DEFINE l_msg3 STRING
   DEFINE l_msg4 STRING
   #fengmy150216----end
   DEFINE l_cnt   LIKE type_t.num5  #161108-00037#7 add
   
  
   #取该年度期别最后一天
#  CALL axcq801_get_date()
   
   CALL g_bded.clear()
   #INSERT tmp
   LET l_sql = " INSERT INTO axcq801_tmp ",
               " SELECT DISTINCT xcfj001,xcfj005,xcfj006,xcfj007,",
              #g_edate," - xcfj008,xccc280,",
               " t1.xccc901,t1.xccc280,t1.xccc902,t2.imaf051, ",
               " t3.imaa003,t4.imag011, ",    #fengmy150216
               "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",       
               "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",
               "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",       
               "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",               
               " FROM xcfj_t ",
               " LEFT JOIN xccc_t t1 ON t1.xcccent='"||g_enterprise||"' AND t1.xcccld = xcfjld AND t1.xccc002 = xcfj001 ",
               "                    AND t1.xccc003 = xcfj002 AND t1.xccc004 = xcfj003 AND t1.xccc005 = xcfj004 ", 
               "                    AND t1.xccc006 = xcfj005 AND t1.xccc007 = xcfj006 AND t1.xccc008 = xcfj007 ",
               "                    AND t1.xccc001 = '",g_xccc001,"'",
               " LEFT JOIN imaf_t t2 ON t2.imafent='"||g_enterprise||"' AND t2.imafsite =xcfjcomp AND t2.imaf001=xcfj005 ",
               #fengmy150216--begin
               " LEFT JOIN imaa_t t3 ON t3.imaaent='"||g_enterprise||"' AND t3.imaa001=xcfj005 ",
               " LEFT JOIN imag_t t4 ON t4.imagent='"||g_enterprise||"' AND t4.imagsite =xcfjcomp AND t4.imag001=xcfj005 ",
               #fengmy150216--end
               "  WHERE xcfjld = '",g_xcfj_m.xcfjld,"' AND xcfj002 = '",g_xcfj_m.xcfj002,"'",
               "    AND xcfj003 = ",g_xcfj_m.xcfj003," AND xcfj004 = ",g_xcfj_m.xcfj004,
               "    AND xcfjent = '",g_enterprise,"'",
               " AND t2.imaf051 = '",g_xcfj_m.xcfc013,"'",      #161108-00037#7 add
               " AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED 
              ," AND xcfjcomp IN ",g_wc_cs_comp                 #160802-00020#9
#              " GROUP BY xcfj001,xcfj005,xcfj006,xcfj007,t1.xccc280,t1.xccc901,t1.xccc902,t2.imaf051"

    PREPARE axcq801_ins_tmp FROM l_sql
    EXECUTE axcq801_ins_tmp
    IF SQLCA.sqlcode THEN
       LET g_success='N'
       CALL cl_errmsg('','','INS axcq801_tmp',SQLCA.sqlcode,1)
       RETURN
    END IF
    #无条件隐藏栏位    
   CALL cl_set_comp_visible("l_qty1",FALSE)
   CALL cl_set_comp_visible("l_amt1",FALSE)
   CALL cl_set_comp_visible("l_rate1",FALSE)
   CALL cl_set_comp_visible("l_idle1",FALSE)
   CALL cl_set_comp_visible("l_qty2",FALSE)
   CALL cl_set_comp_visible("l_amt2",FALSE)
   CALL cl_set_comp_visible("l_rate2",FALSE)
   CALL cl_set_comp_visible("l_idle2",FALSE)
   CALL cl_set_comp_visible("l_qty3",FALSE)
   CALL cl_set_comp_visible("l_amt3",FALSE)
   CALL cl_set_comp_visible("l_rate3",FALSE)
   CALL cl_set_comp_visible("l_idle3",FALSE)
   CALL cl_set_comp_visible("l_qty4",FALSE)
   CALL cl_set_comp_visible("l_amt4",FALSE)
   CALL cl_set_comp_visible("l_rate4",FALSE)
   CALL cl_set_comp_visible("l_idle4",FALSE)
   CALL cl_set_comp_visible("l_qty5",FALSE)
   CALL cl_set_comp_visible("l_amt5",FALSE)
   CALL cl_set_comp_visible("l_rate5",FALSE)
   CALL cl_set_comp_visible("l_idle5",FALSE)
   CALL cl_set_comp_visible("l_qty6",FALSE)
   CALL cl_set_comp_visible("l_amt6",FALSE)
   CALL cl_set_comp_visible("l_rate6",FALSE)
   CALL cl_set_comp_visible("l_idle6",FALSE)
   CALL cl_set_comp_visible("l_qty7",FALSE)
   CALL cl_set_comp_visible("l_amt7",FALSE)
   CALL cl_set_comp_visible("l_rate7",FALSE)
   CALL cl_set_comp_visible("l_idle7",FALSE)
   CALL cl_set_comp_visible("l_qty8",FALSE)
   CALL cl_set_comp_visible("l_amt8",FALSE)
   CALL cl_set_comp_visible("l_rate8",FALSE)
   CALL cl_set_comp_visible("l_idle8",FALSE)
   CALL cl_set_comp_visible("l_qty9",FALSE)
   CALL cl_set_comp_visible("l_amt9",FALSE)
   CALL cl_set_comp_visible("l_rate9",FALSE)
   CALL cl_set_comp_visible("l_idle9",FALSE)
   CALL cl_set_comp_visible("l_qty10",FALSE)
   CALL cl_set_comp_visible("l_amt10",FALSE)
   CALL cl_set_comp_visible("l_rate10",FALSE)
   CALL cl_set_comp_visible("l_idle10",FALSE)
   CALL cl_set_comp_visible("l_qty11",FALSE)
   CALL cl_set_comp_visible("l_amt11",FALSE)
   CALL cl_set_comp_visible("l_rate11",FALSE)
   CALL cl_set_comp_visible("l_idle11",FALSE)
   CALL cl_set_comp_visible("l_qty12",FALSE)
   CALL cl_set_comp_visible("l_amt12",FALSE)
   CALL cl_set_comp_visible("l_rate12",FALSE)
   CALL cl_set_comp_visible("l_idle12",FALSE)
   CALL cl_set_comp_visible("l_qty13",FALSE)
   CALL cl_set_comp_visible("l_amt13",FALSE)
   CALL cl_set_comp_visible("l_rate13",FALSE)
   CALL cl_set_comp_visible("l_idle13",FALSE)
   CALL cl_set_comp_visible("l_qty14",FALSE)
   CALL cl_set_comp_visible("l_amt14",FALSE)
   CALL cl_set_comp_visible("l_rate14",FALSE)
   CALL cl_set_comp_visible("l_idle14",FALSE)
   CALL cl_set_comp_visible("l_qty15",FALSE)
   CALL cl_set_comp_visible("l_amt15",FALSE)
   CALL cl_set_comp_visible("l_rate15",FALSE)
   CALL cl_set_comp_visible("l_idle15",FALSE)
   CALL cl_set_comp_visible("l_qty16",FALSE)
   CALL cl_set_comp_visible("l_amt16",FALSE)
   CALL cl_set_comp_visible("l_rate16",FALSE)
   CALL cl_set_comp_visible("l_idle16",FALSE)
   CALL cl_set_comp_visible("l_qty17",FALSE)
   CALL cl_set_comp_visible("l_amt17",FALSE)
   CALL cl_set_comp_visible("l_rate17",FALSE)
   CALL cl_set_comp_visible("l_idle17",FALSE)
   CALL cl_set_comp_visible("l_qty18",FALSE)
   CALL cl_set_comp_visible("l_amt18",FALSE)
   CALL cl_set_comp_visible("l_rate18",FALSE)
   CALL cl_set_comp_visible("l_idle18",FALSE)
   CALL cl_set_comp_visible("l_qty19",FALSE)
   CALL cl_set_comp_visible("l_amt19",FALSE)
   CALL cl_set_comp_visible("l_rate19",FALSE)
   CALL cl_set_comp_visible("l_idle19",FALSE)
   CALL cl_set_comp_visible("l_qty20",FALSE)
   CALL cl_set_comp_visible("l_amt20",FALSE)
   CALL cl_set_comp_visible("l_rate20",FALSE)
   CALL cl_set_comp_visible("l_idle20",FALSE)
   

  #161108-00037#7-s-add
   LET l_cnt = 0
   SELECT COUNT(1) FROM xcfc_t
    WHERE xcfcent = g_enterprise
      AND xcfcld = g_xcfj_m.xcfjld
      AND xcfc001 = g_xcfj_m.xcfj003  
      AND xcfc002 = g_xcfj_m.xcfj004
      AND xcfc013 = g_xcfj_m.xcfc013      
   #呆滞起始天数，截至天数
   LET l_sql =" SELECT t1.xcfc010,t1.xcfc011,t1.xcfc012 FROM xcfc_t t1",   
              "  WHERE t1.xcfcent = ",g_enterprise,             
              "    AND t1.xcfcld = '",g_xcfj_m.xcfjld,"'",
              "    AND t1.xcfc001 = ",g_xcfj_m.xcfj003,
              "    AND t1.xcfc002 = ",g_xcfj_m.xcfj004
   IF l_cnt > 0 THEN
      LET l_sql = l_sql," AND t1.xcfc013 = '",g_xcfj_m.xcfc013,"'"
   ELSE
      LET l_sql = l_sql," AND NOT EXISTS(SELECT 1 FROM xcfc_t t2 ",
                        "                 WHERE t2.xcfcent = t1.xcfcent AND t2.xcfccomp = t1.xcfccomp ",
                        "                   AND t2.xcfcld = t2.xcfcld   AND t2.xcfc001 = t1.xcfc001 ",
                        "                   AND t2.xcfc002 = t1.xcfc002 AND t2.xcfc013 = t1.xcfc013 ",
                        "                   AND t2.xcfc013 IS NOT NULL) "  
   END IF                 
   LET l_sql = l_sql,"    ORDER BY t1.xcfcseq "  
  #161108-00037#7-e-add  
   PREPARE axcq801_xcfc FROM l_sql
   DECLARE xcfc_cs CURSOR FOR axcq801_xcfc
   LET l_cn = 1
   CALL g_xg_fieldname.clear()
   FOREACH xcfc_cs INTO g_bded[l_cn].bday,g_bded[l_cn].eday,g_bded[l_cn].rate
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH: xcfc" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      CASE g_xcfa004 
         WHEN 1  #材料分类
            LET l_sql1 =
                 "MERGE INTO axcq801_tmp t0 ",
                 "      USING (SELECT DISTINCT xcfj001,xcfj005,xcfj006,xcfj007,SUM(xcfj009) qty", 
                 "               FROM xcfj_t ",
                 "              WHERE xcfjld = '",g_xcfj_m.xcfjld,"' AND xcfj002 = '",g_xcfj_m.xcfj002,"'",
                 "                AND xcfj003 = ",g_xcfj_m.xcfj003," AND xcfj004 = ",g_xcfj_m.xcfj004,
                 "                AND xcfjent = '",g_enterprise,"'",
                 
                 "                AND ( (SELECT MAX(glav004)  FROM glav_t   ",
                 "                        WHERE glavent = '",g_enterprise,"'",
                 "                          AND glav001 = '",g_glaa003,"'",         
                 "                          AND glav002 = '",g_xcfj_m.xcfj003,"'",
                 "                          AND glav006 = '",g_xcfj_m.xcfj004,"'",
                 "                          AND glavstus = 'Y' ) ",
                 "                     - xcfj008 BETWEEN ",g_bded[l_cn].bday," AND ",g_bded[l_cn].eday,")",
                 "                GROUP BY xcfj001,xcfj005,xcfj006,xcfj007 ) t1",          
                 "      ON (t0.xcfj001 = t1.xcfj001 AND t0.xcfj005 = t1.xcfj005 ", 
                 "          AND t0.xcfj006 = t1.xcfj006 AND t0.xcfj007 = t1.xcfj007 ) ",
                 "    WHEN MATCHED THEN ",
                 " UPDATE SET t0.qty1 = t1.qty,",      
                 "            t0.amt1 = t1.qty * t0.xccc280 " 
#                 PREPARE axcq801_merge FROM l_sql
#                 EXECUTE axcq801_merge
            LET l_sql2 =                  
                "MERGE INTO axcq801_tmp t0 ",
                "      USING (SELECT DISTINCT xcfb010,xcfb013 ", 
                "               FROM xcfb_t ",
                "              WHERE xcfbld = '",g_xcfj_m.xcfjld,"' ",
                "                AND xcfb001 = ",g_xcfj_m.xcfj003," AND xcfb002 = ",g_xcfj_m.xcfj004,
                "                AND xcfbent = '",g_enterprise,"' ) t1",          
                "      ON (t0.imaf051 = t1.xcfb010 AND t0.amt1 >0 ) ",
                "    WHEN MATCHED THEN ",
                " UPDATE SET t0.rate1 = t1.xcfb013,",      
                "            t0.idle1 = t1.xcfb013 * t0.amt1/100 " 
#                PREPARE axcq801_merge1 FROM l_sql
#                EXECUTE axcq801_merge1
         WHEN 2  #货龄段
            LET l_sql3 =
                 "MERGE INTO axcq801_tmp t0 ",
                 "      USING (SELECT DISTINCT xcfj001,xcfj005,xcfj006,xcfj007,SUM(xcfj009) qty", 
                 "               FROM xcfj_t ",
                 "              WHERE xcfjld = '",g_xcfj_m.xcfjld,"' AND xcfj002 = '",g_xcfj_m.xcfj002,"'",
                 "                AND xcfj003 = ",g_xcfj_m.xcfj003," AND xcfj004 = ",g_xcfj_m.xcfj004,
                 "                AND xcfjent = '",g_enterprise,"'",
                 "                AND ( (SELECT MAX(glav004)  FROM glav_t   ",
                 "                        WHERE glavent = '",g_enterprise,"'",
                 "                          AND glav001 = '",g_glaa003,"'",         
                 "                          AND glav002 = '",g_xcfj_m.xcfj003,"'",
                 "                          AND glav006 = '",g_xcfj_m.xcfj004,"'",
                 "                          AND glavstus = 'Y' ) ",
                 "                     - xcfj008 BETWEEN ",g_bded[l_cn].bday," AND ",g_bded[l_cn].eday,")",
                 "                GROUP BY xcfj001,xcfj005,xcfj006,xcfj007 ) t1",          
                 "      ON (t0.xcfj001 = t1.xcfj001 AND t0.xcfj005 = t1.xcfj005 ", 
                 "          AND t0.xcfj006 = t1.xcfj006 AND t0.xcfj007 = t1.xcfj007 ) ",
                 "    WHEN MATCHED THEN ",
                 " UPDATE SET t0.qty1 = t1.qty,",      
                 "            t0.amt1 = t1.qty * t0.xccc280, ", 
                 "            t0.rate1 = ",g_bded[l_cn].rate,",",                 
                 "            t0.idle1 = t1.qty * t0.xccc280 * ",g_bded[l_cn].rate,"/100"
#            PREPARE axcq801_merge2 FROM l_sql
#            EXECUTE axcq801_merge2
            
      END CASE
      LET l_str1 = g_bded[l_cn].bday
      LET l_str1 = cl_replace_str(l_str1,".000","") 
      LET l_str2 = g_bded[l_cn].eday
      LET l_str2 = cl_replace_str(l_str2,".000","")
      LET l_str = l_str1,"~",l_str2
      #fengmy150216--begin
#     LET l_msg1 = cl_getmsg("axc-00657",g_lang)  #数量   #160318-00005#46  mark
      LET l_msg1 = cl_getmsg("asf-00086",g_lang)  #数量    #160318-00005#46  add
      LET l_msg2 = cl_getmsg("axc-00658",g_lang)  #金额
      LET l_msg3 = cl_getmsg("axc-00659",g_lang)  #比率
      LET l_msg4 = cl_getmsg("axc-00660",g_lang)  #呆滞
      #141218-0001---(s)---
      LET l_strq = l_msg1,"(",l_str,")"
      LET l_stra = l_msg2,"(",l_str,")"
      LET l_strr = l_msg3,"(",l_str,")"
      LET l_stri = l_msg4,"(",l_str,")" 
      #141218-0001---(e)---       
      #fengmy150216--end
      IF l_cn=1 THEN 
         CALL cl_set_comp_att_text("l_qty1",l_strq) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_qty1",TRUE) 
         CALL cl_set_comp_att_text("l_amt1",l_stra) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_amt1",TRUE) 
         CALL cl_set_comp_att_text("l_rate1",l_strr) #fengmy150216 mod  
         CALL cl_set_comp_visible("l_rate1",TRUE) 
         CALL cl_set_comp_att_text("l_idle1",l_stri) #fengmy150216 mod  
         CALL cl_set_comp_visible("l_idle1",TRUE)  
         #141218-0001---(s)---         
         LET g_xg_fieldname[12] = l_strq
         LET g_xg_fieldname[13] = l_stra
         LET g_xg_fieldname[14] = l_strr
         LET g_xg_fieldname[15] = l_stri
         #141218-0001---(e)---          
      END IF
      IF l_cn=2 THEN 
         CALL cl_set_comp_att_text("l_qty2",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty2",TRUE) 
         CALL cl_set_comp_att_text("l_amt2",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt2",TRUE) 
         CALL cl_set_comp_att_text("l_rate2",l_strr) #fengmy150216 mod
         CALL cl_set_comp_visible("l_rate2",TRUE) 
         CALL cl_set_comp_att_text("l_idle2",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle2",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty2") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt2") 
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt2")           
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate2") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle2") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty2") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt2")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate2") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle2")
         #141218-0001---(s)---
         LET g_xg_fieldname[16] = l_strq
         LET g_xg_fieldname[17] = l_stra
         LET g_xg_fieldname[18] = l_strr
         LET g_xg_fieldname[19] = l_stri
         #141218-0001---(e)---          
      END IF
      IF l_cn=3 THEN 
         CALL cl_set_comp_att_text("l_qty3",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty3",TRUE) 
         CALL cl_set_comp_att_text("l_amt3",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt3",TRUE) 
         CALL cl_set_comp_att_text("l_rate3",l_strr) #fengmy150216 mod
         CALL cl_set_comp_visible("l_rate3",TRUE) 
         CALL cl_set_comp_att_text("l_idle3",l_stri) #fengmy150216 mod  
         CALL cl_set_comp_visible("l_idle3",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty3") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt3")  
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt3")  
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate3") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle3") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty3") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt3")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate3") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle3")
         #141218-0001---(s)---         
         LET g_xg_fieldname[20] = l_strq
         LET g_xg_fieldname[21] = l_stra
         LET g_xg_fieldname[22] = l_strr
         LET g_xg_fieldname[23] = l_stri
         #141218-0001---(e)---          
      END IF
      IF l_cn=4 THEN 
         CALL cl_set_comp_att_text("l_qty4",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty4",TRUE) 
         CALL cl_set_comp_att_text("l_amt4",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt4",TRUE) 
         CALL cl_set_comp_att_text("l_rate4",l_strr) #fengmy150216 mod
         CALL cl_set_comp_visible("l_rate4",TRUE) 
         CALL cl_set_comp_att_text("l_idle4",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle4",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty4") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt4") 
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt4")           
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate4") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle4") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty4") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt4")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate4") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle4")
         #141218-0001---(s)---
         LET g_xg_fieldname[24] = l_strq
         LET g_xg_fieldname[25] = l_stra
         LET g_xg_fieldname[26] = l_strr
         LET g_xg_fieldname[27] = l_stri
         #141218-0001---(e)---          
      END IF
      IF l_cn=5 THEN 
         CALL cl_set_comp_att_text("l_qty5",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty5",TRUE) 
         CALL cl_set_comp_att_text("l_amt5",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt5",TRUE) 
         CALL cl_set_comp_att_text("l_rate5",l_strr) #fengmy150216 mod
         CALL cl_set_comp_visible("l_rate5",TRUE) 
         CALL cl_set_comp_att_text("l_idle5",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle5",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty5") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt5") 
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt5")          
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate5") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle5") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty5") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt5")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate5") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle5")
         #141218-0001---(s)---
         LET g_xg_fieldname[28] = l_strq
         LET g_xg_fieldname[29] = l_stra
         LET g_xg_fieldname[30] = l_strr
         LET g_xg_fieldname[31] = l_stri
         #141218-0001---(e)---          
      END IF
      IF l_cn=6 THEN 
         CALL cl_set_comp_att_text("l_qty6",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty6",TRUE) 
         CALL cl_set_comp_att_text("l_amt6",l_stra) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_amt6",TRUE) 
         CALL cl_set_comp_att_text("l_rate6",l_strr) #fengmy150216 mod
         CALL cl_set_comp_visible("l_rate6",TRUE) 
         CALL cl_set_comp_att_text("l_idle6",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle6",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty6") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt6")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt6")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate6") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle6") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty6") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt6")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate6") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle6")
         #141218-0001---(s)---
         LET g_xg_fieldname[32] = l_strq
         LET g_xg_fieldname[33] = l_stra
         LET g_xg_fieldname[34] = l_strr
         LET g_xg_fieldname[35] = l_stri
         #141218-0001---(e)---          
      END IF
      IF l_cn=7 THEN 
         CALL cl_set_comp_att_text("l_qty7",l_strq) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_qty7",TRUE) 
         CALL cl_set_comp_att_text("l_amt7",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt7",TRUE) 
         CALL cl_set_comp_att_text("l_rate7",l_strr) #fengmy150216 mod
         CALL cl_set_comp_visible("l_rate7",TRUE) 
         CALL cl_set_comp_att_text("l_idle7",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle7",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty7") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt7")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt7")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate7") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle7") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty7") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt7")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate7") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle7")
         #141218-0001---(s)---
         LET g_xg_fieldname[36] = l_strq
         LET g_xg_fieldname[37] = l_stra
         LET g_xg_fieldname[38] = l_strr
         LET g_xg_fieldname[39] = l_stri
         #141218-0001---(e)---          
      END IF
      IF l_cn=8 THEN 
         CALL cl_set_comp_att_text("l_qty8",l_strq) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_qty8",TRUE) 
         CALL cl_set_comp_att_text("l_amt8",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt8",TRUE) 
         CALL cl_set_comp_att_text("l_rate8",l_strr) #fengmy150216 mod
         CALL cl_set_comp_visible("l_rate8",TRUE) 
         CALL cl_set_comp_att_text("l_idle8",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle8",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty8") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt8") 
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt8")          
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate8") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle8") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty8") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt8")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate8") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle8")
         #141218-0001---(s)---         
         LET g_xg_fieldname[40] = l_strq
         LET g_xg_fieldname[41] = l_stra
         LET g_xg_fieldname[42] = l_strr
         LET g_xg_fieldname[43] = l_stri  
         #141218-0001---(e)---           
      END IF
      IF l_cn=9 THEN 
         CALL cl_set_comp_att_text("l_qty9",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty9",TRUE) 
         CALL cl_set_comp_att_text("l_amt9",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt9",TRUE) 
         CALL cl_set_comp_att_text("l_rate9",l_strr) #fengmy150216 mod
         CALL cl_set_comp_visible("l_rate9",TRUE) 
         CALL cl_set_comp_att_text("l_idle9",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle9",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty9") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt9")  
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt9")  
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate9") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle9") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty9") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt9")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate9") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle9")
         #141218-0001---(s)---         
         LET g_xg_fieldname[44] = l_strq
         LET g_xg_fieldname[45] = l_stra
         LET g_xg_fieldname[46] = l_strr
         LET g_xg_fieldname[47] = l_stri
         #141218-0001---(e)---           
      END IF
      IF l_cn=10 THEN 
         CALL cl_set_comp_att_text("l_qty10",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty10",TRUE) 
         CALL cl_set_comp_att_text("l_amt10",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt10",TRUE) 
         CALL cl_set_comp_att_text("l_rate10",l_strr) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_rate10",TRUE) 
         CALL cl_set_comp_att_text("l_idle10",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle10",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty10") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt10")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt10")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate10") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle10") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty10") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt10")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate10") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle10")
         #141218-0001---(s)---         
         LET g_xg_fieldname[48] = l_strq
         LET g_xg_fieldname[49] = l_stra
         LET g_xg_fieldname[50] = l_strr
         LET g_xg_fieldname[51] = l_stri 
         #141218-0001---(e)---           
      END IF
      IF l_cn=11 THEN 
         CALL cl_set_comp_att_text("l_qty11",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty11",TRUE) 
         CALL cl_set_comp_att_text("l_amt11",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt11",TRUE) 
         CALL cl_set_comp_att_text("l_rate11",l_strr) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_rate11",TRUE) 
         CALL cl_set_comp_att_text("l_idle11",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle11",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty11") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt11")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt11")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate11") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle11") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty11") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt11")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate11") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle11")
         #141218-0001---(s)---         
         LET g_xg_fieldname[52] = l_strq
         LET g_xg_fieldname[53] = l_stra
         LET g_xg_fieldname[54] = l_strr
         LET g_xg_fieldname[55] = l_stri 
         #141218-0001---(e)---           
      END IF
      IF l_cn=12 THEN 
         CALL cl_set_comp_att_text("l_qty12",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty12",TRUE) 
         CALL cl_set_comp_att_text("l_amt12",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt12",TRUE) 
         CALL cl_set_comp_att_text("l_rate12",l_strr) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_rate12",TRUE) 
         CALL cl_set_comp_att_text("l_idle12",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle12",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty12") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt12")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt12")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate12") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle12") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty12") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt12")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate12") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle12")
         #141218-0001---(s)---         
         LET g_xg_fieldname[56] = l_strq
         LET g_xg_fieldname[57] = l_stra
         LET g_xg_fieldname[58] = l_strr
         LET g_xg_fieldname[59] = l_stri 
         #141218-0001---(e)---           
      END IF
      IF l_cn=13 THEN 
         CALL cl_set_comp_att_text("l_qty13",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty13",TRUE) 
         CALL cl_set_comp_att_text("l_amt13",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt13",TRUE) 
         CALL cl_set_comp_att_text("l_rate13",l_strr) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_rate13",TRUE) 
         CALL cl_set_comp_att_text("l_idle13",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle13",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty13") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt13")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt13")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate13") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle13") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty13") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt13")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate13") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle13")
         #141318-0001---(s)---         
         LET g_xg_fieldname[60] = l_strq
         LET g_xg_fieldname[61] = l_stra
         LET g_xg_fieldname[62] = l_strr
         LET g_xg_fieldname[63] = l_stri 
         #141318-0001---(e)---           
      END IF
      IF l_cn=14 THEN 
         CALL cl_set_comp_att_text("l_qty14",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty14",TRUE) 
         CALL cl_set_comp_att_text("l_amt14",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt14",TRUE) 
         CALL cl_set_comp_att_text("l_rate14",l_strr) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_rate14",TRUE) 
         CALL cl_set_comp_att_text("l_idle14",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle14",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty14") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt14")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt14")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate14") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle14") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty14") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt14")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate14") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle14")
         #141418-0001---(s)---         
         LET g_xg_fieldname[64] = l_strq
         LET g_xg_fieldname[65] = l_stra
         LET g_xg_fieldname[66] = l_strr
         LET g_xg_fieldname[67] = l_stri 
         #141418-0001---(e)---           
      END IF
      IF l_cn=15 THEN 
         CALL cl_set_comp_att_text("l_qty15",l_strq) #fengmy150216 mod
         CALL cl_set_comp_visible("l_qty15",TRUE) 
         CALL cl_set_comp_att_text("l_amt15",l_stra) #fengmy150216 mod
         CALL cl_set_comp_visible("l_amt15",TRUE) 
         CALL cl_set_comp_att_text("l_rate15",l_strr) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_rate15",TRUE) 
         CALL cl_set_comp_att_text("l_idle15",l_stri) #fengmy150216 mod 
         CALL cl_set_comp_visible("l_idle15",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty15") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt15")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt15")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate15") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle15") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty15") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt15")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate15") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle15")
         #151518-0001---(s)---         
         LET g_xg_fieldname[68] = l_strq
         LET g_xg_fieldname[69] = l_stra
         LET g_xg_fieldname[70] = l_strr
         LET g_xg_fieldname[71] = l_stri 
         #151518-0001---(e)---           
      END IF
      IF l_cn=16 THEN 
         CALL cl_set_comp_att_text("l_qty16",l_strq) #fengmy160216 mod
         CALL cl_set_comp_visible("l_qty16",TRUE) 
         CALL cl_set_comp_att_text("l_amt16",l_stra) #fengmy160216 mod
         CALL cl_set_comp_visible("l_amt16",TRUE) 
         CALL cl_set_comp_att_text("l_rate16",l_strr) #fengmy160216 mod 
         CALL cl_set_comp_visible("l_rate16",TRUE) 
         CALL cl_set_comp_att_text("l_idle16",l_stri) #fengmy160216 mod 
         CALL cl_set_comp_visible("l_idle16",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty16") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt16")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt16")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate16") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle16") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty16") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt16")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate16") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle16")
         #161618-0001---(s)---         
         LET g_xg_fieldname[72] = l_strq
         LET g_xg_fieldname[73] = l_stra
         LET g_xg_fieldname[74] = l_strr
         LET g_xg_fieldname[75] = l_stri 
         #161618-0001---(e)---           
      END IF      
      IF l_cn=17 THEN 
         CALL cl_set_comp_att_text("l_qty17",l_strq) #fengmy170217 mod
         CALL cl_set_comp_visible("l_qty17",TRUE) 
         CALL cl_set_comp_att_text("l_amt17",l_stra) #fengmy170217 mod
         CALL cl_set_comp_visible("l_amt17",TRUE) 
         CALL cl_set_comp_att_text("l_rate17",l_strr) #fengmy170217 mod 
         CALL cl_set_comp_visible("l_rate17",TRUE) 
         CALL cl_set_comp_att_text("l_idle17",l_stri) #fengmy170217 mod 
         CALL cl_set_comp_visible("l_idle17",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty17") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt17")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt17")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate17") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle17") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty17") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt17")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate17") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle17")
         #171718-0001---(s)---         
         LET g_xg_fieldname[76] = l_strq
         LET g_xg_fieldname[77] = l_stra
         LET g_xg_fieldname[78] = l_strr
         LET g_xg_fieldname[79] = l_stri 
         #171718-0001---(e)---           
      END IF
      IF l_cn=18 THEN 
         CALL cl_set_comp_att_text("l_qty18",l_strq) #fengmy180218 mod
         CALL cl_set_comp_visible("l_qty18",TRUE) 
         CALL cl_set_comp_att_text("l_amt18",l_stra) #fengmy180218 mod
         CALL cl_set_comp_visible("l_amt18",TRUE) 
         CALL cl_set_comp_att_text("l_rate18",l_strr) #fengmy180218 mod 
         CALL cl_set_comp_visible("l_rate18",TRUE) 
         CALL cl_set_comp_att_text("l_idle18",l_stri) #fengmy180218 mod 
         CALL cl_set_comp_visible("l_idle18",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty18") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt18")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt18")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate18") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle18") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty18") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt18")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate18") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle18")
         #181818-0001---(s)---         
         LET g_xg_fieldname[80] = l_strq
         LET g_xg_fieldname[81] = l_stra
         LET g_xg_fieldname[82] = l_strr
         LET g_xg_fieldname[83] = l_stri 
         #181818-0001---(e)---           
      END IF    
      IF l_cn=19 THEN 
         CALL cl_set_comp_att_text("l_qty19",l_strq) #fengmy190219 mod
         CALL cl_set_comp_visible("l_qty19",TRUE) 
         CALL cl_set_comp_att_text("l_amt19",l_stra) #fengmy190219 mod
         CALL cl_set_comp_visible("l_amt19",TRUE) 
         CALL cl_set_comp_att_text("l_rate19",l_strr) #fengmy190219 mod 
         CALL cl_set_comp_visible("l_rate19",TRUE) 
         CALL cl_set_comp_att_text("l_idle19",l_stri) #fengmy190219 mod 
         CALL cl_set_comp_visible("l_idle19",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty19") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt19")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt19")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate19") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle19") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty19") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt19")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate19") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle19")
         #191919-0001---(s)---         
         LET g_xg_fieldname[84] = l_strq
         LET g_xg_fieldname[85] = l_stra
         LET g_xg_fieldname[86] = l_strr
         LET g_xg_fieldname[87] = l_stri 
         #191919-0001---(e)---           
      END IF 
      IF l_cn=20 THEN 
         CALL cl_set_comp_att_text("l_qty20",l_strq) #fengmy200220 mod
         CALL cl_set_comp_visible("l_qty20",TRUE) 
         CALL cl_set_comp_att_text("l_amt20",l_stra) #fengmy200220 mod
         CALL cl_set_comp_visible("l_amt20",TRUE) 
         CALL cl_set_comp_att_text("l_rate20",l_strr) #fengmy200220 mod 
         CALL cl_set_comp_visible("l_rate20",TRUE) 
         CALL cl_set_comp_att_text("l_idle20",l_stri) #fengmy200220 mod 
         CALL cl_set_comp_visible("l_idle20",TRUE)  
         LET l_sql1=cl_replace_str(l_sql1,"qty1","qty20") 
         LET l_sql1=cl_replace_str(l_sql1,"amt1","amt20")
         LET l_sql2=cl_replace_str(l_sql2,"amt1","amt20")         
         LET l_sql2=cl_replace_str(l_sql2,"rate1","rate20") 
         LET l_sql2=cl_replace_str(l_sql2,"idle1","idle20") 
         LET l_sql3=cl_replace_str(l_sql3,"qty1","qty20") 
         LET l_sql3=cl_replace_str(l_sql3,"amt1","amt20")  
         LET l_sql3=cl_replace_str(l_sql3,"rate1","rate20") 
         LET l_sql3=cl_replace_str(l_sql3,"idle1","idle20")
         #202020-0001---(s)---         
         LET g_xg_fieldname[88] = l_strq
         LET g_xg_fieldname[89] = l_stra
         LET g_xg_fieldname[90] = l_strr
         LET g_xg_fieldname[91] = l_stri 
         #202020-0001---(e)---           
      END IF      
      CASE g_xcfa004 
         WHEN 1
            PREPARE axcq801_merge1 FROM l_sql1
            EXECUTE axcq801_merge1
            PREPARE axcq801_merge2 FROM l_sql2
            EXECUTE axcq801_merge2
         WHEN 2
            PREPARE axcq801_merge3 FROM l_sql3
            EXECUTE axcq801_merge3
      END CASE      
      
      
      LET l_cn = l_cn + 1
   END FOREACH   
   LET g_cn = l_cn - 1
   LET g_flag = g_cn
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
PRIVATE FUNCTION axcq801_ref()
   DEFINE l_ooef014 LIKE ooef_t.ooef014
   
   
   SELECT ooef014 INTO l_ooef014 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      
   LET g_xcfj_m.xccc001 = g_xccc001
   LET g_xcfj_m.xcfa004 = g_xcfa004
   
   SELECT glaa001,glaa003,glaa015,glaa016,glaa019,glaa020
     INTO g_glaa001,g_glaa003,g_glaa015,g_glaa016,g_glaa019,g_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_xcfj_m.xcfjld
      
   LET g_curr = ' '
   CASE g_xccc001
      WHEN '1'
         LET g_curr = g_glaa001
      WHEN '2'
         IF g_glaa015 = 'Y' THEN            
            LET g_curr = g_glaa016            
         ELSE 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "axc-00595" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN
         END IF
      WHEN '3'
         IF g_glaa019 = 'Y' THEN            
            LET g_curr = g_glaa020                      
         ELSE 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "axc-00596" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN
         END IF
   END CASE
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_curr
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xccc001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xccc001_desc
   
   #取小数位
   CALL s_curr_sel_ooaj004(l_ooef014,g_curr) RETURNING g_ooaj004
   IF cl_null(g_ooaj004) THEN
      LET g_ooaj004 = 2
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfj_m.xcfjcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xcfjcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xcfjcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfj_m.xcfjld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xcfjld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xcfjld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfj_m.xcfj002
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xcfj002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xcfj002_desc
  #161108-00037#7-s-add 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfj_m.xcfc013
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='201' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xcfc013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xcfc013_desc         
  #161108-00037#7-e-add 
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
PRIVATE FUNCTION axcq801_default()
   DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xcfj_m.xcfjcomp,g_xcfj_m.xcfjld,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xcfj002
   DISPLAY BY NAME g_xcfj_m.xcfjcomp,g_xcfj_m.xcfjld,g_xcfj_m.xcfj003,g_xcfj_m.xcfj004,g_xcfj_m.xcfj002
   LET g_xcfjcomp = g_xcfj_m.xcfjcomp   #160714-00027#1
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcfj_m.xcfjcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcfj_m.xcfjcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcfj_m.xcfjcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF   
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcfj001,xcfj001_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xcfj001,xcfj001_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcfj006',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcfj006',FALSE)                
   END IF   
   #fengmy 150113----end   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfj_m.xcfjcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xcfjcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xcfjcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfj_m.xcfjld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xcfjld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xcfjld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcfj_m.xcfj002
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xcfj002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xcfj002_desc
      
   LET g_xcfj_m.xccc001 = '1'
   DISPLAY BY NAME g_xcfj_m.xccc001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcfj_m.xcfjld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcfj_m.xccc001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcfj_m.xccc001_desc  

   SELECT xcfa004 INTO g_xcfj_m.xcfa004 FROM xcfa_t 
    WHERE xcfaent = g_enterprise AND xcfald = g_xcfj_m.xcfjld
      AND xcfa001 = g_xcfj_m.xcfj003 AND xcfa002 = g_xcfj_m.xcfj004
   IF cl_null(g_xcfj_m.xcfa004) THEN 
      LET g_xcfj_m.xcfa004 = '2'
   END IF
   DISPLAY BY NAME g_xcfj_m.xcfa004
END FUNCTION

################################################################################
# Descriptions...: 尾差显示
# Memo...........: 尾差归入金额最大的一笔
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 150217 By fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq801_diff()
DEFINE l_diff    LIKE xccc_t.xccc280
DEFINE l_max     LIKE xccc_t.xccc280

   LET l_max = g_xcfj_d[l_ac].l_amt1
   IF l_max < g_xcfj_d[l_ac].l_amt2  THEN LET l_max = g_xcfj_d[l_ac].l_amt2  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt3  THEN LET l_max = g_xcfj_d[l_ac].l_amt3  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt4  THEN LET l_max = g_xcfj_d[l_ac].l_amt4  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt5  THEN LET l_max = g_xcfj_d[l_ac].l_amt5  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt6  THEN LET l_max = g_xcfj_d[l_ac].l_amt6  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt7  THEN LET l_max = g_xcfj_d[l_ac].l_amt7  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt8  THEN LET l_max = g_xcfj_d[l_ac].l_amt8  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt9  THEN LET l_max = g_xcfj_d[l_ac].l_amt9  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt10 THEN LET l_max = g_xcfj_d[l_ac].l_amt10 END IF
   IF l_max < g_xcfj_d[l_ac].l_amt11  THEN LET l_max = g_xcfj_d[l_ac].l_amt11  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt12  THEN LET l_max = g_xcfj_d[l_ac].l_amt12  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt13  THEN LET l_max = g_xcfj_d[l_ac].l_amt13  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt14  THEN LET l_max = g_xcfj_d[l_ac].l_amt14  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt15  THEN LET l_max = g_xcfj_d[l_ac].l_amt15  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt16  THEN LET l_max = g_xcfj_d[l_ac].l_amt16  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt17  THEN LET l_max = g_xcfj_d[l_ac].l_amt17  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt18  THEN LET l_max = g_xcfj_d[l_ac].l_amt18  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt19  THEN LET l_max = g_xcfj_d[l_ac].l_amt19  END IF
   IF l_max < g_xcfj_d[l_ac].l_amt20 THEN LET l_max = g_xcfj_d[l_ac].l_amt20 END IF
   
   
   LET l_diff = g_xcfj_d[l_ac].l_amount - g_xcfj_d[l_ac].l_amt10
                - g_xcfj_d[l_ac].l_amt1 - g_xcfj_d[l_ac].l_amt2 - g_xcfj_d[l_ac].l_amt3 
                - g_xcfj_d[l_ac].l_amt4 - g_xcfj_d[l_ac].l_amt5 - g_xcfj_d[l_ac].l_amt6 
                - g_xcfj_d[l_ac].l_amt7 - g_xcfj_d[l_ac].l_amt8 - g_xcfj_d[l_ac].l_amt9
                - g_xcfj_d[l_ac].l_amt20
                - g_xcfj_d[l_ac].l_amt11 - g_xcfj_d[l_ac].l_amt12 - g_xcfj_d[l_ac].l_amt13 
                - g_xcfj_d[l_ac].l_amt14 - g_xcfj_d[l_ac].l_amt15 - g_xcfj_d[l_ac].l_amt16 
                - g_xcfj_d[l_ac].l_amt17 - g_xcfj_d[l_ac].l_amt18 - g_xcfj_d[l_ac].l_amt19
                
   IF g_xcfj_d[l_ac].l_amt1 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt1 = g_xcfj_d[l_ac].l_amt1 + l_diff
      LET g_xcfj_d[l_ac].l_idle1 = g_xcfj_d[l_ac].l_amt1 * g_xcfj_d[l_ac].l_rate1/100
   END IF
   IF g_xcfj_d[l_ac].l_amt2 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt2 = g_xcfj_d[l_ac].l_amt2 + l_diff
      LET g_xcfj_d[l_ac].l_idle2 = g_xcfj_d[l_ac].l_amt2 * g_xcfj_d[l_ac].l_rate2/100
   END IF
   IF g_xcfj_d[l_ac].l_amt3 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt3 = g_xcfj_d[l_ac].l_amt3 + l_diff
      LET g_xcfj_d[l_ac].l_idle3 = g_xcfj_d[l_ac].l_amt3 * g_xcfj_d[l_ac].l_rate3/100
   END IF
   IF g_xcfj_d[l_ac].l_amt4 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt4 = g_xcfj_d[l_ac].l_amt4 + l_diff
      LET g_xcfj_d[l_ac].l_idle4 = g_xcfj_d[l_ac].l_amt4 * g_xcfj_d[l_ac].l_rate4/100
   END IF
   IF g_xcfj_d[l_ac].l_amt5 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt5 = g_xcfj_d[l_ac].l_amt5 + l_diff
      LET g_xcfj_d[l_ac].l_idle5 = g_xcfj_d[l_ac].l_amt5 * g_xcfj_d[l_ac].l_rate5/100
   END IF
   IF g_xcfj_d[l_ac].l_amt6 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt6 = g_xcfj_d[l_ac].l_amt6 + l_diff
      LET g_xcfj_d[l_ac].l_idle6 = g_xcfj_d[l_ac].l_amt6 * g_xcfj_d[l_ac].l_rate6/100
   END IF
   IF g_xcfj_d[l_ac].l_amt7 = l_max THEN 
      LET g_xcfj_d[l_ac].l_amt7 = g_xcfj_d[l_ac].l_amt7 + l_diff
      LET g_xcfj_d[l_ac].l_idle7 = g_xcfj_d[l_ac].l_amt7 * g_xcfj_d[l_ac].l_rate7/100
   END IF
   IF g_xcfj_d[l_ac].l_amt8 = l_max THEN 
      LET g_xcfj_d[l_ac].l_amt8 = g_xcfj_d[l_ac].l_amt8 + l_diff
      LET g_xcfj_d[l_ac].l_idle8 = g_xcfj_d[l_ac].l_amt8 * g_xcfj_d[l_ac].l_rate8/100
   END IF
   IF g_xcfj_d[l_ac].l_amt9 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt9 = g_xcfj_d[l_ac].l_amt9 + l_diff
      LET g_xcfj_d[l_ac].l_idle9 = g_xcfj_d[l_ac].l_amt9 * g_xcfj_d[l_ac].l_rate9/100
   END IF
   IF g_xcfj_d[l_ac].l_amt10 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt10 = g_xcfj_d[l_ac].l_amt10 + l_diff
      LET g_xcfj_d[l_ac].l_idle10 = g_xcfj_d[l_ac].l_amt10 * g_xcfj_d[l_ac].l_rate10/100
   END IF
   IF g_xcfj_d[l_ac].l_amt11 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt11 = g_xcfj_d[l_ac].l_amt11 + l_diff
      LET g_xcfj_d[l_ac].l_idle11 = g_xcfj_d[l_ac].l_amt11 * g_xcfj_d[l_ac].l_rate11/100
   END IF
   IF g_xcfj_d[l_ac].l_amt12 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt12 = g_xcfj_d[l_ac].l_amt12 + l_diff
      LET g_xcfj_d[l_ac].l_idle12 = g_xcfj_d[l_ac].l_amt12 * g_xcfj_d[l_ac].l_rate12/100
   END IF
   IF g_xcfj_d[l_ac].l_amt13 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt13 = g_xcfj_d[l_ac].l_amt13 + l_diff
      LET g_xcfj_d[l_ac].l_idle13 = g_xcfj_d[l_ac].l_amt13 * g_xcfj_d[l_ac].l_rate13/100
   END IF
   IF g_xcfj_d[l_ac].l_amt14 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt14 = g_xcfj_d[l_ac].l_amt14 + l_diff
      LET g_xcfj_d[l_ac].l_idle14 = g_xcfj_d[l_ac].l_amt14 * g_xcfj_d[l_ac].l_rate14/100
   END IF
   IF g_xcfj_d[l_ac].l_amt15 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt15 = g_xcfj_d[l_ac].l_amt15 + l_diff
      LET g_xcfj_d[l_ac].l_idle15 = g_xcfj_d[l_ac].l_amt15 * g_xcfj_d[l_ac].l_rate15/100
   END IF
   IF g_xcfj_d[l_ac].l_amt16 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt16 = g_xcfj_d[l_ac].l_amt16 + l_diff
      LET g_xcfj_d[l_ac].l_idle16 = g_xcfj_d[l_ac].l_amt16 * g_xcfj_d[l_ac].l_rate16/100
   END IF
   IF g_xcfj_d[l_ac].l_amt17 = l_max THEN 
      LET g_xcfj_d[l_ac].l_amt17 = g_xcfj_d[l_ac].l_amt17 + l_diff
      LET g_xcfj_d[l_ac].l_idle17 = g_xcfj_d[l_ac].l_amt17 * g_xcfj_d[l_ac].l_rate17/100
   END IF
   IF g_xcfj_d[l_ac].l_amt18 = l_max THEN 
      LET g_xcfj_d[l_ac].l_amt18 = g_xcfj_d[l_ac].l_amt18 + l_diff
      LET g_xcfj_d[l_ac].l_idle18 = g_xcfj_d[l_ac].l_amt18 * g_xcfj_d[l_ac].l_rate18/100
   END IF
   IF g_xcfj_d[l_ac].l_amt19 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt19 = g_xcfj_d[l_ac].l_amt19 + l_diff
      LET g_xcfj_d[l_ac].l_idle19 = g_xcfj_d[l_ac].l_amt19 * g_xcfj_d[l_ac].l_rate19/100
   END IF
   IF g_xcfj_d[l_ac].l_amt20 = l_max THEN
      LET g_xcfj_d[l_ac].l_amt20 = g_xcfj_d[l_ac].l_amt20 + l_diff
      LET g_xcfj_d[l_ac].l_idle20 = g_xcfj_d[l_ac].l_amt20 * g_xcfj_d[l_ac].l_rate20/100
   END IF   
   LET g_xcfj_d[l_ac].l_idle = g_xcfj_d[l_ac].l_idle1 + g_xcfj_d[l_ac].l_idle2 + g_xcfj_d[l_ac].l_idle3 
                               + g_xcfj_d[l_ac].l_idle4 + g_xcfj_d[l_ac].l_idle5 + g_xcfj_d[l_ac].l_idle6
                               + g_xcfj_d[l_ac].l_idle7 + g_xcfj_d[l_ac].l_idle8 + g_xcfj_d[l_ac].l_idle9 
                               + g_xcfj_d[l_ac].l_idle10
                               + g_xcfj_d[l_ac].l_idle11 + g_xcfj_d[l_ac].l_idle12 + g_xcfj_d[l_ac].l_idle13 
                               + g_xcfj_d[l_ac].l_idle14 + g_xcfj_d[l_ac].l_idle15 + g_xcfj_d[l_ac].l_idle16
                               + g_xcfj_d[l_ac].l_idle17 + g_xcfj_d[l_ac].l_idle18 + g_xcfj_d[l_ac].l_idle19 
                               + g_xcfj_d[l_ac].l_idle20
END FUNCTION

################################################################################
# Descriptions...: axcq801_browser_fill
# Memo...........:
# Usage..........: CALL axcq801_browser_fill_1(ps_page_action)
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: #161108-00037#7 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq801_browser_fill_1(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_wc5             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   DEFINE l_cnt             LIKE type_t.num5
   

   #增加帳套過濾條件
   IF NOT cl_null(g_wc_cs_ld) THEN    
      LET g_wc = g_wc," AND xcfjld IN ",g_wc_cs_ld   
   END IF
   #增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN     
      LET g_wc = g_wc," AND xcfjcomp IN ",g_wc_cs_comp  
   END IF
  
 
   LET l_searchcol = ""
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   LET l_wc5 = g_wc5.trim()
   LET l_wc5 = cl_replace_str(l_wc5,"xcfc013","imaf051")
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   IF cl_null(l_wc5) THEN  #材料分類
      LET l_wc5 = " 1=1"
   END IF   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xcfjcomp,xcfjld,xcfj002,xcfj003,xcfj004,imaf051 ",
                      "   FROM xcfj_t LEFT JOIN imaf_t ON imafent = xcfjent AND imafsite = xcfjcomp AND imaf001 = xcfj005 ",     
                      "  WHERE  cfjent = ",g_enterprise, " AND ",l_wc, " AND ", l_wc2, " AND ",l_wc5, cl_sql_add_filter("xcfj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcfjcomp,xcfjld,xcfj002,xcfj003,xcfj004,imaf051 ",
                      "   FROM xcfj_t LEFT JOIN imaf_t ON imafent = xcfjent AND imafsite = xcfjcomp AND imaf001 = xcfj005 ",      
                      "  WHERE xcfjent = ",g_enterprise," AND ",l_wc, " AND ",l_wc5, cl_sql_add_filter("xcfj_t")
   END IF 

   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"

   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre1 FROM g_sql
      EXECUTE header_cnt_pre1 INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre1
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
      INITIALIZE g_xcfj_m.* TO NULL
      CALL g_xcfj_d.clear()        
 
      CALL g_browser1.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF

   LET g_sql = " SELECT DISTINCT xcfjcomp,xcfjld,xcfj002,xcfj003,xcfj004,imaf051 ",
               "   FROM xcfj_t LEFT JOIN imaf_t ON imafent = xcfjent AND imafsite = xcfjcomp AND imaf001 = xcfj005 ",                
               "  WHERE xcfjent = ",g_enterprise," AND ", l_wc," AND ",l_wc2, " AND ",l_wc5, cl_sql_add_filter("xcfj_t")

   LET g_sql= g_sql, " ORDER BY xcfjcomp,xcfjld,xcfj002,xcfj003,xcfj004,imaf051"
                
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre1 FROM g_sql
      DECLARE browse_cur1 CURSOR FOR browse_pre1
      
      FOREACH browse_cur1 INTO g_browser1[g_cnt].xcfjcomp,g_browser1[g_cnt].xcfjld,g_browser1[g_cnt].xcfj002,
                               g_browser1[g_cnt].xcfj003,g_browser1[g_cnt].xcfj004,g_browser1[g_cnt].xcfc013 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF 

         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
      END FOREACH
      FREE browse_pre1
   END IF
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser1[g_cnt].xcfjld) THEN
      CALL g_browser1.deleteElement(g_cnt)
   END IF
   
   IF g_browser1.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcfj_m.* TO NULL
      CALL g_xcfj_d.clear()
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser1.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser1.getLength()
   CALL axcq801_fetch_1('')
   
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
 
   
END FUNCTION

################################################################################
# Descriptions...: axcq801_fetch
# Memo...........:
# Usage..........: CALL axcq801_fetch_1(p_flag)
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: #161108-00037#7 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq801_fetch_1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
  
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
         LET g_current_idx = g_browser1.getLength()              
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
         
         IF g_jump > 0 AND g_jump <= g_browser1.getLength() THEN
            LET g_current_idx = g_jump
         END IF
 
         LET g_no_ask = FALSE  
   END CASE    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 

   IF g_detail_cnt > 0 THEN
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
   IF g_current_idx = 0 OR g_browser1.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser1.getLength() THEN
      LET g_current_idx = g_browser1.getLength()
   END IF
   LET g_xcfj_m.xcfjcomp = g_browser1[g_current_idx].xcfjcomp
   LET g_xcfj_m.xcfjld = g_browser1[g_current_idx].xcfjld
   LET g_xcfj_m.xcfj002 = g_browser1[g_current_idx].xcfj002
   LET g_xcfj_m.xcfj003 = g_browser1[g_current_idx].xcfj003
   LET g_xcfj_m.xcfj004 = g_browser1[g_current_idx].xcfj004
   LET g_xcfj_m.xcfc013 = g_browser1[g_current_idx].xcfc013


   #遮罩相關處理
   LET g_xcfj_m_mask_o.* =  g_xcfj_m.*
   CALL axcq801_xcfj_t_mask()
   LET g_xcfj_m_mask_n.* =  g_xcfj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq801_set_act_visible()
   CALL axcq801_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xcfj_m_t.* = g_xcfj_m.*
   LET g_xcfj_m_o.* = g_xcfj_m.*
   
   #重新顯示   
   CALL axcq801_show()
 
END FUNCTION

################################################################################
# Descriptions...: axcq801_query()
# Memo...........:
# Usage..........: CALL axcq801_query_1()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: #161108-00037#7 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq801_query_1()
   DEFINE ls_wc STRING

   CALL cl_set_comp_visible("l_qty1",FALSE)
   CALL cl_set_comp_visible("l_amt1",FALSE)
   CALL cl_set_comp_visible("l_rate1",FALSE)
   CALL cl_set_comp_visible("l_idle1",FALSE)
   CALL cl_set_comp_visible("l_qty2",FALSE)
   CALL cl_set_comp_visible("l_amt2",FALSE)
   CALL cl_set_comp_visible("l_rate2",FALSE)
   CALL cl_set_comp_visible("l_idle2",FALSE)
   CALL cl_set_comp_visible("l_qty3",FALSE)
   CALL cl_set_comp_visible("l_amt3",FALSE)
   CALL cl_set_comp_visible("l_rate3",FALSE)
   CALL cl_set_comp_visible("l_idle3",FALSE)
   CALL cl_set_comp_visible("l_qty4",FALSE)
   CALL cl_set_comp_visible("l_amt4",FALSE)
   CALL cl_set_comp_visible("l_rate4",FALSE)
   CALL cl_set_comp_visible("l_idle4",FALSE)
   CALL cl_set_comp_visible("l_qty5",FALSE)
   CALL cl_set_comp_visible("l_amt5",FALSE)
   CALL cl_set_comp_visible("l_rate5",FALSE)
   CALL cl_set_comp_visible("l_idle5",FALSE)
   CALL cl_set_comp_visible("l_qty6",FALSE)
   CALL cl_set_comp_visible("l_amt6",FALSE)
   CALL cl_set_comp_visible("l_rate6",FALSE)
   CALL cl_set_comp_visible("l_idle6",FALSE)
   CALL cl_set_comp_visible("l_qty7",FALSE)
   CALL cl_set_comp_visible("l_amt7",FALSE)
   CALL cl_set_comp_visible("l_rate7",FALSE)
   CALL cl_set_comp_visible("l_idle7",FALSE)
   CALL cl_set_comp_visible("l_qty8",FALSE)
   CALL cl_set_comp_visible("l_amt8",FALSE)
   CALL cl_set_comp_visible("l_rate8",FALSE)
   CALL cl_set_comp_visible("l_idle8",FALSE)
   CALL cl_set_comp_visible("l_qty9",FALSE)
   CALL cl_set_comp_visible("l_amt9",FALSE)
   CALL cl_set_comp_visible("l_rate9",FALSE)
   CALL cl_set_comp_visible("l_idle9",FALSE)
   CALL cl_set_comp_visible("l_qty10",FALSE)
   CALL cl_set_comp_visible("l_amt10",FALSE)
   CALL cl_set_comp_visible("l_rate10",FALSE)
   CALL cl_set_comp_visible("l_idle10",FALSE)
   CALL cl_set_comp_visible("l_qty11",FALSE)
   CALL cl_set_comp_visible("l_amt11",FALSE)
   CALL cl_set_comp_visible("l_rate11",FALSE)
   CALL cl_set_comp_visible("l_idle11",FALSE)
   CALL cl_set_comp_visible("l_qty12",FALSE)
   CALL cl_set_comp_visible("l_amt12",FALSE)
   CALL cl_set_comp_visible("l_rate12",FALSE)
   CALL cl_set_comp_visible("l_idle12",FALSE)
   CALL cl_set_comp_visible("l_qty13",FALSE)
   CALL cl_set_comp_visible("l_amt13",FALSE)
   CALL cl_set_comp_visible("l_rate13",FALSE)
   CALL cl_set_comp_visible("l_idle13",FALSE)
   CALL cl_set_comp_visible("l_qty14",FALSE)
   CALL cl_set_comp_visible("l_amt14",FALSE)
   CALL cl_set_comp_visible("l_rate14",FALSE)
   CALL cl_set_comp_visible("l_idle14",FALSE)
   CALL cl_set_comp_visible("l_qty15",FALSE)
   CALL cl_set_comp_visible("l_amt15",FALSE)
   CALL cl_set_comp_visible("l_rate15",FALSE)
   CALL cl_set_comp_visible("l_idle15",FALSE)
   CALL cl_set_comp_visible("l_qty16",FALSE)
   CALL cl_set_comp_visible("l_amt16",FALSE)
   CALL cl_set_comp_visible("l_rate16",FALSE)
   CALL cl_set_comp_visible("l_idle16",FALSE)
   CALL cl_set_comp_visible("l_qty17",FALSE)
   CALL cl_set_comp_visible("l_amt17",FALSE)
   CALL cl_set_comp_visible("l_rate17",FALSE)
   CALL cl_set_comp_visible("l_idle17",FALSE)
   CALL cl_set_comp_visible("l_qty18",FALSE)
   CALL cl_set_comp_visible("l_amt18",FALSE)
   CALL cl_set_comp_visible("l_rate18",FALSE)
   CALL cl_set_comp_visible("l_idle18",FALSE)
   CALL cl_set_comp_visible("l_qty19",FALSE)
   CALL cl_set_comp_visible("l_amt19",FALSE)
   CALL cl_set_comp_visible("l_rate19",FALSE)
   CALL cl_set_comp_visible("l_idle19",FALSE)
   CALL cl_set_comp_visible("l_qty20",FALSE)
   CALL cl_set_comp_visible("l_amt20",FALSE)
   CALL cl_set_comp_visible("l_rate20",FALSE)
   CALL cl_set_comp_visible("l_idle20",FALSE)

   
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
   CALL g_browser1.clear()       
   CALL g_xcfj_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq801_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq801_browser_fill(g_wc)
      CALL axcq801_fetch_1("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq801_browser_fill("F")
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser1.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL axcq801_fetch_1("F") 
   END IF
   
   CALL axcq801_idx_chk()
   
   LET g_wc_filter = ""
END FUNCTION

 
{</section>}
 
