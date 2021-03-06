#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq530.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0022(2015-10-16 15:40:13), PR版次:0022(2017-03-10 10:45:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000093
#+ Filename...: axcq530
#+ Description: 庫存成本多筆查詢作業
#+ Creator....: 03297(2014-12-25 10:06:49)
#+ Modifier...: 05384 -SD/PR- 02111
 
{</section>}
 
{<section id="axcq530.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#151013-00019#7   2015/10/28  By Reanna   bug追單
#160318-00025#9   2016/04/21  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160520-00003#5   2016/05/20  By lixiang  效能优化
#160802-00011#1   2016/08/02  By fengmy   期末金额汇总与明细不符，期末金额的年期取错
#160802-00020#4   2016/08/04  By dorislai 增加帳套權限管控
#160802-00020#10  2016/08/11  By dorislai 增加法人權限管控
#160811-00013#1   2016/08/12  By xianghui 期初数据抓取时年度期别错误
#160819-00026#1   2016/08/22  By 02040    抓取期末結存數量、金額改成用單頭輸入的截止年期 
#161019-00017#5   2016/10/21  By lixiang  调整组织栏位的开窗
#161024-00069#1   2016/10/26  By zhaoqya  修正漏抓xccc005成本单位
#170224-00017#1   2017/02/24  By Whitney  庫存成本明細頁籤抓取資料條件闕漏ENT
#170309-00049#1   2017/03/10    By Vmapire 修正沒有串查詢條件應該在主 SQL 條件裡。
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
PRIVATE type type_g_xccc_m        RECORD
       xccccomp LIKE xccc_t.xccccomp, 
   xccccomp_desc LIKE type_t.chr80, 
   xccc004 LIKE xccc_t.xccc004, 
   xccc005 LIKE xccc_t.xccc005, 
   xccc001 LIKE xccc_t.xccc001, 
   xccc001_desc LIKE type_t.chr80, 
   xcccld LIKE xccc_t.xcccld, 
   xcccld_desc LIKE type_t.chr80, 
   xccc004_1 LIKE type_t.num5, 
   xccc005_1 LIKE type_t.num5, 
   xccc003 LIKE xccc_t.xccc003, 
   xccc003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccc_d        RECORD
       imag011 LIKE type_t.chr10, 
   imag011_desc LIKE type_t.chr500, 
   xccc002 LIKE xccc_t.xccc002, 
   xccc002_desc LIKE type_t.chr500, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc006_desc LIKE type_t.chr500, 
   xccc006_desc_desc LIKE type_t.chr500, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc008 LIKE xccc_t.xccc008, 
   inadsite LIKE type_t.chr500, 
   inadsite_desc LIKE type_t.chr500, 
   inad010 LIKE type_t.chr500, 
   inad010_desc LIKE type_t.chr500, 
   xcbb005 LIKE type_t.chr10, 
   xccc101 LIKE xccc_t.xccc101, 
   l_unit LIKE type_t.num20_6, 
   xccc102 LIKE xccc_t.xccc102, 
   xccc201 LIKE xccc_t.xccc201, 
   xccc202 LIKE xccc_t.xccc202, 
   xccc280 LIKE xccc_t.xccc280, 
   xccc280a LIKE xccc_t.xccc280a, 
   xccc280b LIKE xccc_t.xccc280b, 
   xccc280c LIKE xccc_t.xccc280c, 
   xccc280d LIKE xccc_t.xccc280d, 
   xccc280e LIKE xccc_t.xccc280e, 
   xccc280f LIKE xccc_t.xccc280f, 
   xccc280g LIKE xccc_t.xccc280g, 
   xccc280h LIKE xccc_t.xccc280h, 
   xccc301 LIKE xccc_t.xccc301, 
   xccc302 LIKE xccc_t.xccc302, 
   xccc901 LIKE xccc_t.xccc901, 
   xccc902 LIKE xccc_t.xccc902, 
   xccc903 LIKE xccc_t.xccc903
       END RECORD
PRIVATE TYPE type_g_xccc2_d RECORD
       xccc004 LIKE xccc_t.xccc004, 
   xccc005 LIKE xccc_t.xccc005, 
   imag011 LIKE imag_t.imag011, 
   imag011_2_desc LIKE type_t.chr500, 
   xccc002 LIKE xccc_t.xccc002, 
   xccc002_2_desc LIKE type_t.chr500, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc006_2_desc LIKE type_t.chr500, 
   xccc006_2_desc_desc LIKE type_t.chr500, 
   xcbb005 LIKE xcbb_t.xcbb005, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc008 LIKE xccc_t.xccc008, 
   inadsite LIKE inad_t.inadsite, 
   inadsite_2_desc LIKE type_t.chr500, 
   inad010 LIKE inad_t.inad010, 
   inad010_2_desc LIKE type_t.chr500, 
   xccc101 LIKE xccc_t.xccc101, 
   l_unit_2 LIKE type_t.num20_6, 
   xccc102 LIKE xccc_t.xccc102, 
   xccc201 LIKE xccc_t.xccc201, 
   xccc202 LIKE xccc_t.xccc202, 
   xccc203 LIKE xccc_t.xccc203, 
   xccc204 LIKE xccc_t.xccc204, 
   xccc205 LIKE xccc_t.xccc205, 
   xccc206 LIKE xccc_t.xccc206, 
   xccc207 LIKE xccc_t.xccc207, 
   xccc208 LIKE xccc_t.xccc208, 
   xccc209 LIKE xccc_t.xccc209, 
   xccc210 LIKE xccc_t.xccc210, 
   xccc211 LIKE xccc_t.xccc211, 
   xccc212 LIKE xccc_t.xccc212, 
   xccc213 LIKE xccc_t.xccc213, 
   xccc214 LIKE xccc_t.xccc214, 
   xccc215 LIKE xccc_t.xccc215, 
   xccc216 LIKE xccc_t.xccc216, 
   xccc217 LIKE xccc_t.xccc217, 
   xccc218 LIKE xccc_t.xccc218, 
   xccc301 LIKE xccc_t.xccc301, 
   xccc302 LIKE xccc_t.xccc302, 
   xccc303 LIKE xccc_t.xccc303, 
   xccc304 LIKE xccc_t.xccc304, 
   xccc305 LIKE xccc_t.xccc305, 
   xccc306 LIKE xccc_t.xccc306, 
   xccc307 LIKE xccc_t.xccc307, 
   xccc308 LIKE xccc_t.xccc308, 
   xccc309 LIKE xccc_t.xccc309, 
   xccc310 LIKE xccc_t.xccc310, 
   xccc311 LIKE xccc_t.xccc311, 
   xccc312 LIKE xccc_t.xccc312, 
   xccc313 LIKE xccc_t.xccc313, 
   xccc314 LIKE xccc_t.xccc314, 
   xccc901 LIKE xccc_t.xccc901, 
   xccc902 LIKE xccc_t.xccc902, 
   xccc903 LIKE xccc_t.xccc903, 
   xccc903a LIKE xccc_t.xccc903a, 
   xccc903b LIKE xccc_t.xccc903b, 
   xccc903c LIKE xccc_t.xccc903c, 
   xccc903d LIKE xccc_t.xccc903d, 
   xccc903e LIKE xccc_t.xccc903e, 
   xccc903f LIKE xccc_t.xccc903f, 
   xccc903g LIKE xccc_t.xccc903g, 
   xccc903h LIKE xccc_t.xccc903h
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150114
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150114
#2015/3/26 ouhz add------begin----
TYPE type_g_xccc_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xccc_e
DEFINE g_sql_tmp             STRING
#wujie 150604 --begin
DEFINE g_wc3                 STRING 
#wujie 150604 --end
#2015/3/26 ouhz add------end---- 
#fengmy150806-----add
DEFINE g_yy1 LIKE type_t.num5
DEFINE g_mm1 LIKE type_t.num5
DEFINE g_yy2 LIKE type_t.num5
DEFINE g_mm2 LIKE type_t.num5
#fengmy150806-----end
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xccc_m          type_g_xccc_m
DEFINE g_xccc_m_t        type_g_xccc_m
DEFINE g_xccc_m_o        type_g_xccc_m
DEFINE g_xccc_m_mask_o   type_g_xccc_m #轉換遮罩前資料
DEFINE g_xccc_m_mask_n   type_g_xccc_m #轉換遮罩後資料
 
   DEFINE g_xccc004_t LIKE xccc_t.xccc004
DEFINE g_xccc005_t LIKE xccc_t.xccc005
DEFINE g_xccc001_t LIKE xccc_t.xccc001
DEFINE g_xcccld_t LIKE xccc_t.xcccld
DEFINE g_xccc003_t LIKE xccc_t.xccc003
 
 
DEFINE g_xccc_d          DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_xccc_d_t        type_g_xccc_d
DEFINE g_xccc_d_o        type_g_xccc_d
DEFINE g_xccc_d_mask_o   DYNAMIC ARRAY OF type_g_xccc_d #轉換遮罩前資料
DEFINE g_xccc_d_mask_n   DYNAMIC ARRAY OF type_g_xccc_d #轉換遮罩後資料
DEFINE g_xccc2_d   DYNAMIC ARRAY OF type_g_xccc2_d
DEFINE g_xccc2_d_t type_g_xccc2_d
DEFINE g_xccc2_d_o type_g_xccc2_d
DEFINE g_xccc2_d_mask_o   DYNAMIC ARRAY OF type_g_xccc2_d #轉換遮罩前資料
DEFINE g_xccc2_d_mask_n   DYNAMIC ARRAY OF type_g_xccc2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcccld LIKE xccc_t.xcccld,
      b_xccc001 LIKE xccc_t.xccc001,
      b_xccc003 LIKE xccc_t.xccc003,
      b_xccc004 LIKE xccc_t.xccc004,
      b_xccc005 LIKE xccc_t.xccc005
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
 
{<section id="axcq530.main" >}
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
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xccccomp,'',xccc004,xccc005,xccc001,'',xcccld,'','','',xccc003,''", 
                      " FROM xccc_t",
                      " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND  
                          xccc005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq530_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccccomp,t0.xccc004,t0.xccc005,t0.xccc001,t0.xcccld,t0.xccc003,t1.ooefl004 , 
       t2.glaal002",
               " FROM xccc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccccomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xcccld AND t2.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.xcccent = " ||g_enterprise|| " AND t0.xcccld = ? AND t0.xccc001 = ? AND t0.xccc003 = ? AND t0.xccc004 = ? AND t0.xccc005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq530_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq530 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq530_init()   
 
      #進入選單 Menu (="N")
      CALL axcq530_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq530
      
   END IF 
   
   CLOSE axcq530_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq530.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq530_init()
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
   #fengmy 150114----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccc007,xccc007_2',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xccc007,xccc007_2',FALSE)                
   END IF   
   #fengmy 150114----end 
   CALL cl_set_comp_visible('xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h',FALSE)  #fengmy150812 
   #end add-point
   
   CALL axcq530_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq530.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq530_ui_dialog()
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
         INITIALIZE g_xccc_m.* TO NULL
         CALL g_xccc_d.clear()
         CALL g_xccc2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq530_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xccc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq530_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq530_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_xccc2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axcq530_idx_chk()
               CALL axcq530_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq530_browser_fill("")
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
               CALL axcq530_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq530_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            #151130-00003#1   151130   By polly add s
            ON ACTION filter
               LET g_action_choice="filter"
               CALL axcq530_filter()
            #151130-00003#1   151130   By polly add s
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq530_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq530_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq530_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq530_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq530_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq530_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq530_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq530_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq530_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq530_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xccc_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xccc2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               NEXT FIELD xccc002
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
               CALL axcq530_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq530_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq530_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #ouhz 2015/3/26 add ----begin-----
               DROP TABLE axcq530_tmp;  
               #創建臨時表，存放當前單身數據
               CALL axcq530_create_temp_table()   
               #把單身內容放入暫存檔，以便XG調用打印
               CALL axcq530_ins_temp()        
               LET g_param.v = "axcq530_tmp"
               CALL axcq530_x01('1=1',g_param.v)
               #ouhz 2015/3/26 add ----end-----   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #ouhz 2015/3/26 add ----begin-----
               DROP TABLE axcq530_tmp;  
               #創建臨時表，存放當前單身數據
               CALL axcq530_create_temp_table()   
               #把單身內容放入暫存檔，以便XG調用打印
               CALL axcq530_ins_temp()        
               LET g_param.v = "axcq530_tmp"
               CALL axcq530_x01('1=1',g_param.v)
               #ouhz 2015/3/26 add ----end-----   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq530_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
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
            CALL axcq530_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq530_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq530_set_pk_array()
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
 
{<section id="axcq530.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq530_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq530.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq530_browser_fill(ps_page_action)
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
#wujie 150604 --begin
   DEFINE l_wc3             STRING
#wujie 150604 --end
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
#wujie 150604 --begin
#   LET l_wc3 = g_wc3.trim()
   IF cl_null(l_wc3) THEN  #p_wc 查詢條件
      LET l_wc3 = " 1=1"
   END IF
#wujie 150604 --end
   #end add-point    
 
   LET l_searchcol = "xcccld,xccc001,xccc003,xccc004,xccc005"
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
      LET l_sub_sql = " SELECT DISTINCT xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
                      ", xccc004 ",
                      ", xccc005 ",
 
                      " FROM xccc_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcccent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
                      ", xccc004 ",
                      ", xccc005 ",
 
                      " FROM xccc_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcccent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xccc_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   LET l_wc = l_wc," AND (xccc004*12+xccc005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  #fengmy150806
   LET g_wc = l_wc  #fengmy150813
   
  #151130-00003#1--mark--(s) 
  #IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
  #   #單身有輸入搜尋條件                      
  #   LET l_sub_sql = " SELECT UNIQUE xcccld ",
  #                   ", xccc001 ",
  #                   ", xccc003 ",
# #                   ", xccc004 ",    #fengmy150812  mark
# #                   ", xccc005 ",    #fengmy150812  mark 
  #                   " FROM xccc_t ",
  #                  #" LEFT OUTER JOIN imag_t t1 ON t1.imagent = '"||g_enterprise||"' AND t1.imagsite = '"||g_xccc_m.xccccomp||"' AND t1.imag001 = xccc006 ",  #151130-00002#1 mark
  #                   " LEFT OUTER JOIN imag_t t1 ON t1.imagent = xcccent AND t1.imagsite = xccccomp AND t1.imag001 = xccc006 ",                                #151130-00002#1 add                      
  #                   " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccc_t")
  #ELSE
  #   #單身未輸入搜尋條件
  #   LET l_sub_sql = " SELECT UNIQUE xcccld ",
  #                   ", xccc001 ",
  #                   ", xccc003 ",
# #                   ", xccc004 ",    #fengmy150812  mark
# #                   ", xccc005 ",    #fengmy150812  mark 
  #                   " FROM xccc_t ",
  #                   " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccc_t")
  #END IF 
  #151130-00003#1--mark--(e) 
  #151130-00003#1--add--(s) 
   LET l_sub_sql = " SELECT UNIQUE xcccld,xccc001,xccc003 FROM xccc_t "
   IF (g_wc2 <> " 1=1" AND NOT cl_null(g_wc2)) OR NOT cl_null(g_wc_filter) THEN 
      LET l_sub_sql = l_sub_sql CLIPPED , " LEFT OUTER JOIN imag_t t1 ON t1.imagent = xcccent AND t1.imagsite = xccccomp AND t1.imag001 = xccc006 "
   END IF
   LET l_sub_sql = l_sub_sql CLIPPED , " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
      LET l_sub_sql = l_sub_sql CLIPPED," AND ",g_wc2 CLIPPED
   END IF
   IF NOT cl_null(g_wc_filter) THEN
      LET l_sub_sql = l_sub_sql CLIPPED," AND ",g_wc_filter CLIPPED
   END IF   
   LET l_sub_sql = l_sub_sql CLIPPED, cl_sql_add_filter("xccc_t")
  #151130-00003#1--add--(e)   
  
  #160802-00020#4-add-(S)
  #---增加帳套權限
  IF NOT cl_null(g_wc_cs_ld) THEN
     LET g_sql = g_sql , " AND xcccld IN ",g_wc_cs_ld
   END IF
  #160802-00020#4-add-(E)
  #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccccomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
  
#wujie 150604 --begin
#如果明细页签单身有输门店或供应商查询条件的
   IF g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN
      LET l_sub_sql = s_chr_replace(l_sub_sql,"xccc_t","xccc_t,inad_t",0)
      LET l_sub_sql = l_sub_sql," AND inadent = xcccent ",
                                " AND inad001 = xccc006 ",
                                " AND inad002 = xccc007 ",
                                " AND inad003 = xccc008 ",
                                " AND ",g_wc3
   END IF
#wujie 150604 --end
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
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
      INITIALIZE g_xccc_m.* TO NULL
      CALL g_xccc_d.clear()        
      CALL g_xccc2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcccld,t0.xccc001,t0.xccc003,t0.xccc004,t0.xccc005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcccld,t0.xccc001,t0.xccc003,t0.xccc004,t0.xccc005",
                " FROM xccc_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcccent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccc_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   LET g_sql  = "SELECT DISTINCT t0.xcccld,t0.xccc001,t0.xccc003,'','' ",  #,t0.xccc004,t0.xccc005",   #fengmy150812  mark
                " FROM xccc_t t0",
               #" LEFT OUTER JOIN imag_t t1 ON t1.imagent = '"||g_enterprise||"' AND t1.imagsite = '"||g_xccc_m.xccccomp||"' AND t1.imag001 = xccc006 ",  #151130-00002#1  mark
                " LEFT OUTER JOIN imag_t t1 ON t1.imagent = t0.xcccent AND t1.imagsite = t0.xccccomp AND t1.imag001 = xccc006 ",                          #151130-00002#1  add                                         
                " WHERE t0.xcccent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccc_t")
  
  #151130-00003#1--add--(s) 
   IF NOT cl_null(g_wc_filter) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_filter CLIPPED
   END IF
  #151130-00003#1--add--(e)   

  #160802-00020#4-add-(S)
  #---增加帳套權限
  IF NOT cl_null(g_wc_cs_ld) THEN
     LET g_sql = g_sql , " AND xcccld IN ",g_wc_cs_ld
   END IF
  #160802-00020#4-add-(E)
  #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccccomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
  
#wujie 150604 --begin
#如果明细页签单身有输门店或供应商查询条件的
   IF g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN
      LET g_sql = s_chr_replace(g_sql,"xccc_t t0","xccc_t t0,inad_t",0)
      LET g_sql = g_sql," AND inadent = xcccent ",
                        " AND inad001 = xccc006 ",
                        " AND inad002 = xccc007 ",
                        " AND inad003 = xccc008 ",
                        " AND ",g_wc3
   END IF
#wujie 150604 --end    
   
   LET l_searchcol = "xcccld,xccc001,xccc003 "   #fengmy150812 add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccc_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcccld,g_browser[g_cnt].b_xccc001,g_browser[g_cnt].b_xccc003, 
          g_browser[g_cnt].b_xccc004,g_browser[g_cnt].b_xccc005 
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
   
   IF cl_null(g_browser[g_cnt].b_xcccld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xccc_m.* TO NULL
      CALL g_xccc_d.clear()
      CALL g_xccc2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq530_fetch('')
   
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
 
{<section id="axcq530.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq530_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xccc_m.xcccld = g_browser[g_current_idx].b_xcccld   
   LET g_xccc_m.xccc001 = g_browser[g_current_idx].b_xccc001   
   LET g_xccc_m.xccc003 = g_browser[g_current_idx].b_xccc003   
   LET g_xccc_m.xccc004 = g_browser[g_current_idx].b_xccc004   
   LET g_xccc_m.xccc005 = g_browser[g_current_idx].b_xccc005   
 
   EXECUTE axcq530_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld, 
       g_xccc_m.xccc003,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   CALL axcq530_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq530_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq530_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcccld = g_xccc_m.xcccld 
         AND g_browser[l_i].b_xccc001 = g_xccc_m.xccc001 
         AND g_browser[l_i].b_xccc003 = g_xccc_m.xccc003 
         AND g_browser[l_i].b_xccc004 = g_xccc_m.xccc004 
         AND g_browser[l_i].b_xccc005 = g_xccc_m.xccc005 
 
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
 
{<section id="axcq530.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq530_construct()
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
   INITIALIZE g_xccc_m.* TO NULL
   CALL g_xccc_d.clear()
   CALL g_xccc2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccccomp,xccc001,xcccld,xccc003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axcq530_default()
            #end add-point 
            
                 #Ctrlp:construct.c.xccccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp name="construct.c.xccccomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160802-00020#10-add-(S)
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#10-add-(E)
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccccomp  #顯示到畫面上
            NEXT FIELD xccccomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccccomp
            #add-point:BEFORE FIELD xccccomp name="construct.b.xccccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccccomp
            
            #add-point:AFTER FIELD xccccomp name="construct.a.xccccomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001 name="construct.b.xccc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001 name="construct.a.xccc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001 name="construct.c.xccc001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcccld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="construct.c.xcccld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160802-00020#4-add-(S)
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#4-add-(E)
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcccld  #顯示到畫面上
            NEXT FIELD xcccld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcccld
            #add-point:BEFORE FIELD xcccld name="construct.b.xcccld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="construct.a.xcccld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="construct.c.xccc003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc003  #顯示到畫面上
            NEXT FIELD xccc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc003
            #add-point:BEFORE FIELD xccc003 name="construct.b.xccc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="construct.a.xccc003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON imag011,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,xccc202, 
          xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,xccc301,xccc302, 
          xccc901,xccc902,xccc903,xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211, 
          xccc212,xccc213,xccc214,xccc215,xccc216,xccc217,xccc218,xccc303,xccc304,xccc305,xccc306,xccc307, 
          xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314
           FROM s_detail1[1].imag011,s_detail1[1].xccc002,s_detail1[1].xccc006,s_detail1[1].xccc007, 
               s_detail1[1].xccc008,s_detail1[1].xccc101,s_detail1[1].xccc102,s_detail1[1].xccc201,s_detail1[1].xccc202, 
               s_detail1[1].xccc280,s_detail1[1].xccc280a,s_detail1[1].xccc280b,s_detail1[1].xccc280c, 
               s_detail1[1].xccc280d,s_detail1[1].xccc280e,s_detail1[1].xccc280f,s_detail1[1].xccc280g, 
               s_detail1[1].xccc280h,s_detail1[1].xccc301,s_detail1[1].xccc302,s_detail1[1].xccc901, 
               s_detail1[1].xccc902,s_detail1[1].xccc903,s_detail2[1].xccc203,s_detail2[1].xccc204,s_detail2[1].xccc205, 
               s_detail2[1].xccc206,s_detail2[1].xccc207,s_detail2[1].xccc208,s_detail2[1].xccc209,s_detail2[1].xccc210, 
               s_detail2[1].xccc211,s_detail2[1].xccc212,s_detail2[1].xccc213,s_detail2[1].xccc214,s_detail2[1].xccc215, 
               s_detail2[1].xccc216,s_detail2[1].xccc217,s_detail2[1].xccc218,s_detail2[1].xccc303,s_detail2[1].xccc304, 
               s_detail2[1].xccc305,s_detail2[1].xccc306,s_detail2[1].xccc307,s_detail2[1].xccc308,s_detail2[1].xccc309, 
               s_detail2[1].xccc310,s_detail2[1].xccc311,s_detail2[1].xccc312,s_detail2[1].xccc313,s_detail2[1].xccc314 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="construct.c.page1.imag011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imag011  #顯示到畫面上
            NEXT FIELD imag011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="construct.b.page1.imag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="construct.a.page1.imag011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002 name="construct.b.page1.xccc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002 name="construct.a.page1.xccc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002 name="construct.c.page1.xccc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc006
            #add-point:BEFORE FIELD xccc006 name="construct.b.page1.xccc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc006
            
            #add-point:AFTER FIELD xccc006 name="construct.a.page1.xccc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006 name="construct.c.page1.xccc006"
            #151130-00002#1--add--(s)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc006  #顯示到畫面上
            NEXT FIELD xccc006                     #返回原欄位 
            #151130-00002#1--add--(e)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc007
            #add-point:BEFORE FIELD xccc007 name="construct.b.page1.xccc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc007
            
            #add-point:AFTER FIELD xccc007 name="construct.a.page1.xccc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc007
            #add-point:ON ACTION controlp INFIELD xccc007 name="construct.c.page1.xccc007"
            #151130-00002#1--add--(s)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd008()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc007  #顯示到畫面上
            NEXT FIELD xccc007                     #返回原欄位
            #151130-00002#1--add--(e)  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc008
            #add-point:BEFORE FIELD xccc008 name="construct.b.page1.xccc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc008
            
            #add-point:AFTER FIELD xccc008 name="construct.a.page1.xccc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc008
            #add-point:ON ACTION controlp INFIELD xccc008 name="construct.c.page1.xccc008"
            #151130-00002#1--add--(s)            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'F'
            CALL q_inaj010()                  #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc008  #顯示到畫面上
            NEXT FIELD xccc008 
            #151130-00002#1--add--(e)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc101
            #add-point:BEFORE FIELD xccc101 name="construct.b.page1.xccc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc101
            
            #add-point:AFTER FIELD xccc101 name="construct.a.page1.xccc101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc101
            #add-point:ON ACTION controlp INFIELD xccc101 name="construct.c.page1.xccc101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc102
            #add-point:BEFORE FIELD xccc102 name="construct.b.page1.xccc102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc102
            
            #add-point:AFTER FIELD xccc102 name="construct.a.page1.xccc102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc102
            #add-point:ON ACTION controlp INFIELD xccc102 name="construct.c.page1.xccc102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc201
            #add-point:BEFORE FIELD xccc201 name="construct.b.page1.xccc201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc201
            
            #add-point:AFTER FIELD xccc201 name="construct.a.page1.xccc201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc201
            #add-point:ON ACTION controlp INFIELD xccc201 name="construct.c.page1.xccc201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc202
            #add-point:BEFORE FIELD xccc202 name="construct.b.page1.xccc202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc202
            
            #add-point:AFTER FIELD xccc202 name="construct.a.page1.xccc202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc202
            #add-point:ON ACTION controlp INFIELD xccc202 name="construct.c.page1.xccc202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280
            #add-point:BEFORE FIELD xccc280 name="construct.b.page1.xccc280"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280
            
            #add-point:AFTER FIELD xccc280 name="construct.a.page1.xccc280"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280
            #add-point:ON ACTION controlp INFIELD xccc280 name="construct.c.page1.xccc280"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280a
            #add-point:BEFORE FIELD xccc280a name="construct.b.page1.xccc280a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280a
            
            #add-point:AFTER FIELD xccc280a name="construct.a.page1.xccc280a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280a
            #add-point:ON ACTION controlp INFIELD xccc280a name="construct.c.page1.xccc280a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280b
            #add-point:BEFORE FIELD xccc280b name="construct.b.page1.xccc280b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280b
            
            #add-point:AFTER FIELD xccc280b name="construct.a.page1.xccc280b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280b
            #add-point:ON ACTION controlp INFIELD xccc280b name="construct.c.page1.xccc280b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280c
            #add-point:BEFORE FIELD xccc280c name="construct.b.page1.xccc280c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280c
            
            #add-point:AFTER FIELD xccc280c name="construct.a.page1.xccc280c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280c
            #add-point:ON ACTION controlp INFIELD xccc280c name="construct.c.page1.xccc280c"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280d
            #add-point:BEFORE FIELD xccc280d name="construct.b.page1.xccc280d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280d
            
            #add-point:AFTER FIELD xccc280d name="construct.a.page1.xccc280d"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280d
            #add-point:ON ACTION controlp INFIELD xccc280d name="construct.c.page1.xccc280d"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280e
            #add-point:BEFORE FIELD xccc280e name="construct.b.page1.xccc280e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280e
            
            #add-point:AFTER FIELD xccc280e name="construct.a.page1.xccc280e"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280e
            #add-point:ON ACTION controlp INFIELD xccc280e name="construct.c.page1.xccc280e"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280f
            #add-point:BEFORE FIELD xccc280f name="construct.b.page1.xccc280f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280f
            
            #add-point:AFTER FIELD xccc280f name="construct.a.page1.xccc280f"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280f
            #add-point:ON ACTION controlp INFIELD xccc280f name="construct.c.page1.xccc280f"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280g
            #add-point:BEFORE FIELD xccc280g name="construct.b.page1.xccc280g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280g
            
            #add-point:AFTER FIELD xccc280g name="construct.a.page1.xccc280g"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280g
            #add-point:ON ACTION controlp INFIELD xccc280g name="construct.c.page1.xccc280g"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280h
            #add-point:BEFORE FIELD xccc280h name="construct.b.page1.xccc280h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280h
            
            #add-point:AFTER FIELD xccc280h name="construct.a.page1.xccc280h"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc280h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280h
            #add-point:ON ACTION controlp INFIELD xccc280h name="construct.c.page1.xccc280h"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc301
            #add-point:BEFORE FIELD xccc301 name="construct.b.page1.xccc301"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc301
            
            #add-point:AFTER FIELD xccc301 name="construct.a.page1.xccc301"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc301
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc301
            #add-point:ON ACTION controlp INFIELD xccc301 name="construct.c.page1.xccc301"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc302
            #add-point:BEFORE FIELD xccc302 name="construct.b.page1.xccc302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc302
            
            #add-point:AFTER FIELD xccc302 name="construct.a.page1.xccc302"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc302
            #add-point:ON ACTION controlp INFIELD xccc302 name="construct.c.page1.xccc302"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc901
            #add-point:BEFORE FIELD xccc901 name="construct.b.page1.xccc901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc901
            
            #add-point:AFTER FIELD xccc901 name="construct.a.page1.xccc901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc901
            #add-point:ON ACTION controlp INFIELD xccc901 name="construct.c.page1.xccc901"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc902
            #add-point:BEFORE FIELD xccc902 name="construct.b.page1.xccc902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc902
            
            #add-point:AFTER FIELD xccc902 name="construct.a.page1.xccc902"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc902
            #add-point:ON ACTION controlp INFIELD xccc902 name="construct.c.page1.xccc902"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc903
            #add-point:BEFORE FIELD xccc903 name="construct.b.page1.xccc903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc903
            
            #add-point:AFTER FIELD xccc903 name="construct.a.page1.xccc903"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc903
            #add-point:ON ACTION controlp INFIELD xccc903 name="construct.c.page1.xccc903"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc203
            #add-point:BEFORE FIELD xccc203 name="construct.b.page2.xccc203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc203
            
            #add-point:AFTER FIELD xccc203 name="construct.a.page2.xccc203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc203
            #add-point:ON ACTION controlp INFIELD xccc203 name="construct.c.page2.xccc203"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc204
            #add-point:BEFORE FIELD xccc204 name="construct.b.page2.xccc204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc204
            
            #add-point:AFTER FIELD xccc204 name="construct.a.page2.xccc204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc204
            #add-point:ON ACTION controlp INFIELD xccc204 name="construct.c.page2.xccc204"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc205
            #add-point:BEFORE FIELD xccc205 name="construct.b.page2.xccc205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc205
            
            #add-point:AFTER FIELD xccc205 name="construct.a.page2.xccc205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc205
            #add-point:ON ACTION controlp INFIELD xccc205 name="construct.c.page2.xccc205"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc206
            #add-point:BEFORE FIELD xccc206 name="construct.b.page2.xccc206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc206
            
            #add-point:AFTER FIELD xccc206 name="construct.a.page2.xccc206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc206
            #add-point:ON ACTION controlp INFIELD xccc206 name="construct.c.page2.xccc206"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc207
            #add-point:BEFORE FIELD xccc207 name="construct.b.page2.xccc207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc207
            
            #add-point:AFTER FIELD xccc207 name="construct.a.page2.xccc207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc207
            #add-point:ON ACTION controlp INFIELD xccc207 name="construct.c.page2.xccc207"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc208
            #add-point:BEFORE FIELD xccc208 name="construct.b.page2.xccc208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc208
            
            #add-point:AFTER FIELD xccc208 name="construct.a.page2.xccc208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc208
            #add-point:ON ACTION controlp INFIELD xccc208 name="construct.c.page2.xccc208"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc209
            #add-point:BEFORE FIELD xccc209 name="construct.b.page2.xccc209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc209
            
            #add-point:AFTER FIELD xccc209 name="construct.a.page2.xccc209"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc209
            #add-point:ON ACTION controlp INFIELD xccc209 name="construct.c.page2.xccc209"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc210
            #add-point:BEFORE FIELD xccc210 name="construct.b.page2.xccc210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc210
            
            #add-point:AFTER FIELD xccc210 name="construct.a.page2.xccc210"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc210
            #add-point:ON ACTION controlp INFIELD xccc210 name="construct.c.page2.xccc210"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc211
            #add-point:BEFORE FIELD xccc211 name="construct.b.page2.xccc211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc211
            
            #add-point:AFTER FIELD xccc211 name="construct.a.page2.xccc211"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc211
            #add-point:ON ACTION controlp INFIELD xccc211 name="construct.c.page2.xccc211"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc212
            #add-point:BEFORE FIELD xccc212 name="construct.b.page2.xccc212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc212
            
            #add-point:AFTER FIELD xccc212 name="construct.a.page2.xccc212"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc212
            #add-point:ON ACTION controlp INFIELD xccc212 name="construct.c.page2.xccc212"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc213
            #add-point:BEFORE FIELD xccc213 name="construct.b.page2.xccc213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc213
            
            #add-point:AFTER FIELD xccc213 name="construct.a.page2.xccc213"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc213
            #add-point:ON ACTION controlp INFIELD xccc213 name="construct.c.page2.xccc213"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc214
            #add-point:BEFORE FIELD xccc214 name="construct.b.page2.xccc214"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc214
            
            #add-point:AFTER FIELD xccc214 name="construct.a.page2.xccc214"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc214
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc214
            #add-point:ON ACTION controlp INFIELD xccc214 name="construct.c.page2.xccc214"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc215
            #add-point:BEFORE FIELD xccc215 name="construct.b.page2.xccc215"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc215
            
            #add-point:AFTER FIELD xccc215 name="construct.a.page2.xccc215"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc215
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc215
            #add-point:ON ACTION controlp INFIELD xccc215 name="construct.c.page2.xccc215"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc216
            #add-point:BEFORE FIELD xccc216 name="construct.b.page2.xccc216"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc216
            
            #add-point:AFTER FIELD xccc216 name="construct.a.page2.xccc216"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc216
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc216
            #add-point:ON ACTION controlp INFIELD xccc216 name="construct.c.page2.xccc216"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc217
            #add-point:BEFORE FIELD xccc217 name="construct.b.page2.xccc217"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc217
            
            #add-point:AFTER FIELD xccc217 name="construct.a.page2.xccc217"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc217
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc217
            #add-point:ON ACTION controlp INFIELD xccc217 name="construct.c.page2.xccc217"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc218
            #add-point:BEFORE FIELD xccc218 name="construct.b.page2.xccc218"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc218
            
            #add-point:AFTER FIELD xccc218 name="construct.a.page2.xccc218"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc218
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc218
            #add-point:ON ACTION controlp INFIELD xccc218 name="construct.c.page2.xccc218"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc303
            #add-point:BEFORE FIELD xccc303 name="construct.b.page2.xccc303"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc303
            
            #add-point:AFTER FIELD xccc303 name="construct.a.page2.xccc303"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc303
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc303
            #add-point:ON ACTION controlp INFIELD xccc303 name="construct.c.page2.xccc303"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc304
            #add-point:BEFORE FIELD xccc304 name="construct.b.page2.xccc304"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc304
            
            #add-point:AFTER FIELD xccc304 name="construct.a.page2.xccc304"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc304
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc304
            #add-point:ON ACTION controlp INFIELD xccc304 name="construct.c.page2.xccc304"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc305
            #add-point:BEFORE FIELD xccc305 name="construct.b.page2.xccc305"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc305
            
            #add-point:AFTER FIELD xccc305 name="construct.a.page2.xccc305"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc305
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc305
            #add-point:ON ACTION controlp INFIELD xccc305 name="construct.c.page2.xccc305"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc306
            #add-point:BEFORE FIELD xccc306 name="construct.b.page2.xccc306"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc306
            
            #add-point:AFTER FIELD xccc306 name="construct.a.page2.xccc306"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc306
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc306
            #add-point:ON ACTION controlp INFIELD xccc306 name="construct.c.page2.xccc306"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc307
            #add-point:BEFORE FIELD xccc307 name="construct.b.page2.xccc307"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc307
            
            #add-point:AFTER FIELD xccc307 name="construct.a.page2.xccc307"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc307
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc307
            #add-point:ON ACTION controlp INFIELD xccc307 name="construct.c.page2.xccc307"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc308
            #add-point:BEFORE FIELD xccc308 name="construct.b.page2.xccc308"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc308
            
            #add-point:AFTER FIELD xccc308 name="construct.a.page2.xccc308"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc308
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc308
            #add-point:ON ACTION controlp INFIELD xccc308 name="construct.c.page2.xccc308"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc309
            #add-point:BEFORE FIELD xccc309 name="construct.b.page2.xccc309"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc309
            
            #add-point:AFTER FIELD xccc309 name="construct.a.page2.xccc309"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc309
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc309
            #add-point:ON ACTION controlp INFIELD xccc309 name="construct.c.page2.xccc309"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc310
            #add-point:BEFORE FIELD xccc310 name="construct.b.page2.xccc310"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc310
            
            #add-point:AFTER FIELD xccc310 name="construct.a.page2.xccc310"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc310
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc310
            #add-point:ON ACTION controlp INFIELD xccc310 name="construct.c.page2.xccc310"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc311
            #add-point:BEFORE FIELD xccc311 name="construct.b.page2.xccc311"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc311
            
            #add-point:AFTER FIELD xccc311 name="construct.a.page2.xccc311"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc311
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc311
            #add-point:ON ACTION controlp INFIELD xccc311 name="construct.c.page2.xccc311"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc312
            #add-point:BEFORE FIELD xccc312 name="construct.b.page2.xccc312"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc312
            
            #add-point:AFTER FIELD xccc312 name="construct.a.page2.xccc312"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc312
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc312
            #add-point:ON ACTION controlp INFIELD xccc312 name="construct.c.page2.xccc312"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc313
            #add-point:BEFORE FIELD xccc313 name="construct.b.page2.xccc313"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc313
            
            #add-point:AFTER FIELD xccc313 name="construct.a.page2.xccc313"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc313
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc313
            #add-point:ON ACTION controlp INFIELD xccc313 name="construct.c.page2.xccc313"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc314
            #add-point:BEFORE FIELD xccc314 name="construct.b.page2.xccc314"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc314
            
            #add-point:AFTER FIELD xccc314 name="construct.a.page2.xccc314"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xccc314
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc314
            #add-point:ON ACTION controlp INFIELD xccc314 name="construct.c.page2.xccc314"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT g_wc3 ON inadsite,inad010
           FROM s_detail1[1].inadsite,s_detail1[1].inad010
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD inadsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗#161019-00017#5
            CALL q_ooef001_1()   #161019-00017#5
            DISPLAY g_qryparam.return1 TO inadsite  #顯示到畫面上
            NEXT FIELD inadsite                     #返回原欄位
    

         BEFORE FIELD inadsite
 

         AFTER FIELD inadsite

         ON ACTION controlp INFIELD inad010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inad010  #顯示到畫面上
            NEXT FIELD inad010                     #返回原欄位
    

 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD inad010
            #add-point:BEFORE FIELD inad010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inad010
            
            #add-point:AFTER FIELD inad010

            #END add-point
      END CONSTRUCT 
      #fengmy150806---begin
      INPUT g_yy1,g_mm1,g_yy2,g_mm2 FROM xccc004,xccc005,xccc004_1,xccc005_1
         AFTER FIELD xccc004 
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccc004
                END IF
             END IF
         AFTER FIELD xccc005
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               IF g_yy1 = g_yy2 AND 
                  g_mm1 > g_mm2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xccc005
               END IF
            END IF
         AFTER FIELD xccc004_1
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccc004_1
                END IF
             END IF
         AFTER FIELD xccc005_1   
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               IF g_yy1 = g_yy2 AND 
                  g_mm1 > g_mm2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xccc005_1
               END IF
            END IF               
      END INPUT
      #fengmy150806---end
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
 
{<section id="axcq530.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq530_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   CALL axcq530_create_temp_1() #fengmy150812 add
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
   CALL g_xccc_d.clear()
   CALL g_xccc2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq530_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq530_browser_fill(g_wc)
      CALL axcq530_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq530_browser_fill("F")
   
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
      CALL axcq530_fetch("F") 
   END IF
   
   CALL axcq530_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq530_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
#fengmy150812------begin
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
   
   #CALL axcq530_browser_fill(p_flag)
   
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
   
   LET g_xccc_m.xcccld = g_browser[g_current_idx].b_xcccld
   LET g_xccc_m.xccc001 = g_browser[g_current_idx].b_xccc001
   LET g_xccc_m.xccc003 = g_browser[g_current_idx].b_xccc003
   LET g_xccc_m.xccc004 = g_browser[g_current_idx].b_xccc004
   LET g_xccc_m.xccc005 = g_browser[g_current_idx].b_xccc005
 
   LET g_sql = " SELECT UNIQUE t0.xccccomp,t0.xccc001,t0.xcccld,t0.xccc003,t1.ooefl004 , 
       t2.glaal002",
               " FROM xccc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xccccomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent='"||g_enterprise||"' AND t2.glaalld=t0.xcccld AND t2.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.xcccent = '" ||g_enterprise|| "' AND t0.xcccld = ? AND t0.xccc001 = ? AND t0.xccc003 = ? "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq530_master_referesh1 FROM g_sql   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq530_master_referesh1 USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003
      INTO g_xccc_m.xccccomp,g_xccc_m.xccc001,g_xccc_m.xcccld, 
           g_xccc_m.xccc003,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
           
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xccc_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq530_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq530_set_act_visible()
   CALL axcq530_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xccc_m_t.* = g_xccc_m.*
   LET g_xccc_m_o.* = g_xccc_m.*
   
   #重新顯示   
   CALL axcq530_show()
   RETURN 
#fengmy150812------end
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
   
   #CALL axcq530_browser_fill(p_flag)
   
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
   
   LET g_xccc_m.xcccld = g_browser[g_current_idx].b_xcccld
   LET g_xccc_m.xccc001 = g_browser[g_current_idx].b_xccc001
   LET g_xccc_m.xccc003 = g_browser[g_current_idx].b_xccc003
   LET g_xccc_m.xccc004 = g_browser[g_current_idx].b_xccc004
   LET g_xccc_m.xccc005 = g_browser[g_current_idx].b_xccc005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq530_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld, 
       g_xccc_m.xccc003,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xccc_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq530_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq530_set_act_visible()
   CALL axcq530_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xccc_m_t.* = g_xccc_m.*
   LET g_xccc_m_o.* = g_xccc_m.*
   
   #重新顯示   
   CALL axcq530_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq530.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq530_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xccc_d.clear()
   CALL g_xccc2_d.clear()
 
 
   INITIALIZE g_xccc_m.* TO NULL             #DEFAULT 設定
   LET g_xcccld_t = NULL
   LET g_xccc001_t = NULL
   LET g_xccc003_t = NULL
   LET g_xccc004_t = NULL
   LET g_xccc005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq530_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccc_m.* TO NULL
         INITIALIZE g_xccc_d TO NULL
         INITIALIZE g_xccc2_d TO NULL
 
         CALL axcq530_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccc_m.* = g_xccc_m_t.*
         CALL axcq530_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xccc_d.clear()
      #CALL g_xccc2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq530_set_act_visible()
   CALL axcq530_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq530_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq530_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq530_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld, 
       g_xccc_m.xccc003,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq530_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001, 
       g_xccc_m.xccc001_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.xccc004_1,g_xccc_m.xccc005_1, 
       g_xccc_m.xccc003,g_xccc_m.xccc003_desc
   
   #功能已完成,通報訊息中心
   CALL axcq530_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq530_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xccc_m.xcccld IS NULL
   OR g_xccc_m.xccc001 IS NULL
   OR g_xccc_m.xccc003 IS NULL
   OR g_xccc_m.xccc004 IS NULL
   OR g_xccc_m.xccc005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   CALL s_transaction_begin()
   
   OPEN axcq530_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq530_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq530_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq530_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld, 
       g_xccc_m.xccc003,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq530_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq530_show()
   WHILE TRUE
      LET g_xcccld_t = g_xccc_m.xcccld
      LET g_xccc001_t = g_xccc_m.xccc001
      LET g_xccc003_t = g_xccc_m.xccc003
      LET g_xccc004_t = g_xccc_m.xccc004
      LET g_xccc005_t = g_xccc_m.xccc005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq530_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccc_m.* = g_xccc_m_t.*
         CALL axcq530_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xccc_m.xcccld != g_xcccld_t 
      OR g_xccc_m.xccc001 != g_xccc001_t 
      OR g_xccc_m.xccc003 != g_xccc003_t 
      OR g_xccc_m.xccc004 != g_xccc004_t 
      OR g_xccc_m.xccc005 != g_xccc005_t 
 
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
   CALL axcq530_set_act_visible()
   CALL axcq530_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005, "' "
 
   #填到對應位置
   CALL axcq530_browser_fill("")
 
   CALL axcq530_idx_chk()
 
   CLOSE axcq530_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq530_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq530.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq530_input(p_cmd)
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
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001, 
       g_xccc_m.xccc001_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.xccc004_1,g_xccc_m.xccc005_1, 
       g_xccc_m.xccc003,g_xccc_m.xccc003_desc
   
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
   LET g_forupd_sql = "SELECT xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,xccc202,xccc280, 
       xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,xccc301,xccc302,xccc901, 
       xccc902,xccc903,xccc004,xccc005,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,xccc202, 
       xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,xccc214, 
       xccc215,xccc216,xccc217,xccc218,xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307,xccc308, 
       xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903,xccc903a,xccc903b,xccc903c, 
       xccc903d,xccc903e,xccc903f,xccc903g,xccc903h FROM xccc_t WHERE xcccent=? AND xcccld=? AND xccc001=?  
       AND xccc003=? AND xccc004=? AND xccc005=? AND xccc002=? AND xccc006=? AND xccc007=? AND xccc008=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq530_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq530_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq530_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld, 
       g_xccc_m.xccc004_1,g_xccc_m.xccc005_1,g_xccc_m.xccc003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq530.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld, 
          g_xccc_m.xccc004_1,g_xccc_m.xccc005_1,g_xccc_m.xccc003 
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
         AFTER FIELD xccccomp
            
            #add-point:AFTER FIELD xccccomp name="input.a.xccccomp"
            IF NOT cl_null(g_xccc_m.xccccomp) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccc_m.xccccomp

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooef001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl004 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccccomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccccomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccccomp
            #add-point:BEFORE FIELD xccccomp name="input.b.xccccomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccccomp
            #add-point:ON CHANGE xccccomp name="input.g.xccccomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="input.b.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="input.a.xccc004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc004
            #add-point:ON CHANGE xccc004 name="input.g.xccc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005 name="input.b.xccc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005 name="input.a.xccc005"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc005
            #add-point:ON CHANGE xccc005 name="input.g.xccc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001 name="input.a.xccc001"

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


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
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="input.a.xcccld"
            IF NOT cl_null(g_xccc_m.xcccld) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccc_m.xcccld
               #160318-00025#9--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#9--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xcccld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xcccld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xcccld_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcccld
            #add-point:BEFORE FIELD xcccld name="input.b.xcccld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcccld
            #add-point:ON CHANGE xcccld name="input.g.xcccld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc004_1
            #add-point:BEFORE FIELD xccc004_1 name="input.b.xccc004_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004_1
            
            #add-point:AFTER FIELD xccc004_1 name="input.a.xccc004_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc004_1
            #add-point:ON CHANGE xccc004_1 name="input.g.xccc004_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005_1
            #add-point:BEFORE FIELD xccc005_1 name="input.b.xccc005_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005_1
            
            #add-point:AFTER FIELD xccc005_1 name="input.a.xccc005_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc005_1
            #add-point:ON CHANGE xccc005_1 name="input.g.xccc005_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="input.a.xccc003"
            IF NOT cl_null(g_xccc_m.xccc003) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccc_m.xccc003
               #160318-00025#9--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#9--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccc003_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc003
            #add-point:BEFORE FIELD xccc003 name="input.b.xccc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc003
            #add-point:ON CHANGE xccc003 name="input.g.xccc003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp name="input.c.xccccomp"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccc_m.xccccomp             #給予default值
            LET g_qryparam.default2 = "" #g_xccc_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooef001_2()                                #呼叫開窗

            LET g_xccc_m.xccccomp = g_qryparam.return1              
            #LET g_xccc_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xccc_m.xccccomp TO xccccomp              #
            #DISPLAY g_xccc_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xccccomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004 name="input.c.xccc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005 name="input.c.xccc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001 name="input.c.xccc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcccld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="input.c.xcccld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccc_m.xcccld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xccc_m.xcccld = g_qryparam.return1              

            DISPLAY g_xccc_m.xcccld TO xcccld              #

            NEXT FIELD xcccld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccc004_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004_1
            #add-point:ON ACTION controlp INFIELD xccc004_1 name="input.c.xccc004_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc005_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005_1
            #add-point:ON ACTION controlp INFIELD xccc005_1 name="input.c.xccc005_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="input.c.xccc003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccc_m.xccc003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_xcat001()                                #呼叫開窗

            LET g_xccc_m.xccc003 = g_qryparam.return1              

            DISPLAY g_xccc_m.xccc003 TO xccc003              #

            NEXT FIELD xccc003                          #返回原欄位


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
            DISPLAY BY NAME g_xccc_m.xcccld             
                            ,g_xccc_m.xccc001   
                            ,g_xccc_m.xccc003   
                            ,g_xccc_m.xccc004   
                            ,g_xccc_m.xccc005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq530_xccc_t_mask_restore('restore_mask_o')
            
               UPDATE xccc_t SET (xccccomp,xccc004,xccc005,xccc001,xcccld,xccc003) = (g_xccc_m.xccccomp, 
                   g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld,g_xccc_m.xccc003) 
 
                WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
                  AND xccc001 = g_xccc001_t
                  AND xccc003 = g_xccc003_t
                  AND xccc004 = g_xccc004_t
                  AND xccc005 = g_xccc005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccc_m.xcccld
               LET gs_keys_bak[1] = g_xcccld_t
               LET gs_keys[2] = g_xccc_m.xccc001
               LET gs_keys_bak[2] = g_xccc001_t
               LET gs_keys[3] = g_xccc_m.xccc003
               LET gs_keys_bak[3] = g_xccc003_t
               LET gs_keys[4] = g_xccc_m.xccc004
               LET gs_keys_bak[4] = g_xccc004_t
               LET gs_keys[5] = g_xccc_m.xccc005
               LET gs_keys_bak[5] = g_xccc005_t
               LET gs_keys[6] = g_xccc_d[g_detail_idx].xccc002
               LET gs_keys_bak[6] = g_xccc_d_t.xccc002
               LET gs_keys[7] = g_xccc_d[g_detail_idx].xccc006
               LET gs_keys_bak[7] = g_xccc_d_t.xccc006
               LET gs_keys[8] = g_xccc_d[g_detail_idx].xccc007
               LET gs_keys_bak[8] = g_xccc_d_t.xccc007
               LET gs_keys[9] = g_xccc_d[g_detail_idx].xccc008
               LET gs_keys_bak[9] = g_xccc_d_t.xccc008
               CALL axcq530_update_b('xccc_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xccc_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xccc_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq530_xccc_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq530_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcccld_t = g_xccc_m.xcccld
           LET g_xccc001_t = g_xccc_m.xccc001
           LET g_xccc003_t = g_xccc_m.xccc003
           LET g_xccc004_t = g_xccc_m.xccc004
           LET g_xccc005_t = g_xccc_m.xccc005
 
           
           IF g_xccc_d.getLength() = 0 THEN
              NEXT FIELD xccc002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq530.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xccc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq530_b_fill(g_wc2) #test 
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
            CALL axcq530_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq530_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq530_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq530_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xccc_d[l_ac].xccc002 IS NOT NULL
               AND g_xccc_d[l_ac].xccc006 IS NOT NULL
               AND g_xccc_d[l_ac].xccc007 IS NOT NULL
               AND g_xccc_d[l_ac].xccc008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccc_d_t.* = g_xccc_d[l_ac].*  #BACKUP
               LET g_xccc_d_o.* = g_xccc_d[l_ac].*  #BACKUP
               CALL axcq530_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq530_set_no_entry_b(l_cmd)
               OPEN axcq530_bcl USING g_enterprise,g_xccc_m.xcccld,
                                                g_xccc_m.xccc001,
                                                g_xccc_m.xccc003,
                                                g_xccc_m.xccc004,
                                                g_xccc_m.xccc005,
 
                                                g_xccc_d_t.xccc002
                                                ,g_xccc_d_t.xccc006
                                                ,g_xccc_d_t.xccc007
                                                ,g_xccc_d_t.xccc008
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq530_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq530_bcl INTO g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007, 
                      g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc101,g_xccc_d[l_ac].xccc102,g_xccc_d[l_ac].xccc201, 
                      g_xccc_d[l_ac].xccc202,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc280a,g_xccc_d[l_ac].xccc280b, 
                      g_xccc_d[l_ac].xccc280c,g_xccc_d[l_ac].xccc280d,g_xccc_d[l_ac].xccc280e,g_xccc_d[l_ac].xccc280f, 
                      g_xccc_d[l_ac].xccc280g,g_xccc_d[l_ac].xccc280h,g_xccc_d[l_ac].xccc301,g_xccc_d[l_ac].xccc302, 
                      g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc903,g_xccc2_d[l_ac].xccc004, 
                      g_xccc2_d[l_ac].xccc005,g_xccc2_d[l_ac].xccc002,g_xccc2_d[l_ac].xccc006,g_xccc2_d[l_ac].xccc007, 
                      g_xccc2_d[l_ac].xccc008,g_xccc2_d[l_ac].xccc101,g_xccc2_d[l_ac].xccc102,g_xccc2_d[l_ac].xccc201, 
                      g_xccc2_d[l_ac].xccc202,g_xccc2_d[l_ac].xccc203,g_xccc2_d[l_ac].xccc204,g_xccc2_d[l_ac].xccc205, 
                      g_xccc2_d[l_ac].xccc206,g_xccc2_d[l_ac].xccc207,g_xccc2_d[l_ac].xccc208,g_xccc2_d[l_ac].xccc209, 
                      g_xccc2_d[l_ac].xccc210,g_xccc2_d[l_ac].xccc211,g_xccc2_d[l_ac].xccc212,g_xccc2_d[l_ac].xccc213, 
                      g_xccc2_d[l_ac].xccc214,g_xccc2_d[l_ac].xccc215,g_xccc2_d[l_ac].xccc216,g_xccc2_d[l_ac].xccc217, 
                      g_xccc2_d[l_ac].xccc218,g_xccc2_d[l_ac].xccc301,g_xccc2_d[l_ac].xccc302,g_xccc2_d[l_ac].xccc303, 
                      g_xccc2_d[l_ac].xccc304,g_xccc2_d[l_ac].xccc305,g_xccc2_d[l_ac].xccc306,g_xccc2_d[l_ac].xccc307, 
                      g_xccc2_d[l_ac].xccc308,g_xccc2_d[l_ac].xccc309,g_xccc2_d[l_ac].xccc310,g_xccc2_d[l_ac].xccc311, 
                      g_xccc2_d[l_ac].xccc312,g_xccc2_d[l_ac].xccc313,g_xccc2_d[l_ac].xccc314,g_xccc2_d[l_ac].xccc901, 
                      g_xccc2_d[l_ac].xccc902,g_xccc2_d[l_ac].xccc903,g_xccc2_d[l_ac].xccc903a,g_xccc2_d[l_ac].xccc903b, 
                      g_xccc2_d[l_ac].xccc903c,g_xccc2_d[l_ac].xccc903d,g_xccc2_d[l_ac].xccc903e,g_xccc2_d[l_ac].xccc903f, 
                      g_xccc2_d[l_ac].xccc903g,g_xccc2_d[l_ac].xccc903h
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccc_d_t.xccc002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xccc_d_mask_o[l_ac].* =  g_xccc_d[l_ac].*
                  CALL axcq530_xccc_t_mask()
                  LET g_xccc_d_mask_n[l_ac].* =  g_xccc_d[l_ac].*
                  
                  CALL axcq530_ref_show()
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
            INITIALIZE g_xccc_d_t.* TO NULL
            INITIALIZE g_xccc_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccc_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccc_d[l_ac].xccc101 = "0"
      LET g_xccc_d[l_ac].l_unit = "0"
      LET g_xccc_d[l_ac].xccc102 = "0"
      LET g_xccc_d[l_ac].xccc201 = "0"
      LET g_xccc_d[l_ac].xccc202 = "0"
      LET g_xccc_d[l_ac].xccc280 = "0"
      LET g_xccc_d[l_ac].xccc280a = "0"
      LET g_xccc_d[l_ac].xccc280b = "0"
      LET g_xccc_d[l_ac].xccc280c = "0"
      LET g_xccc_d[l_ac].xccc280d = "0"
      LET g_xccc_d[l_ac].xccc280e = "0"
      LET g_xccc_d[l_ac].xccc280f = "0"
      LET g_xccc_d[l_ac].xccc280g = "0"
      LET g_xccc_d[l_ac].xccc280h = "0"
      LET g_xccc_d[l_ac].xccc301 = "0"
      LET g_xccc_d[l_ac].xccc302 = "0"
      LET g_xccc_d[l_ac].xccc901 = "0"
      LET g_xccc_d[l_ac].xccc902 = "0"
      LET g_xccc_d[l_ac].xccc903 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xccc_d_t.* = g_xccc_d[l_ac].*     #新輸入資料
            LET g_xccc_d_o.* = g_xccc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq530_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq530_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccc_d[li_reproduce_target].* = g_xccc_d[li_reproduce].*
               LET g_xccc2_d[li_reproduce_target].* = g_xccc2_d[li_reproduce].*
 
               LET g_xccc_d[g_xccc_d.getLength()].xccc002 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc006 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc007 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc008 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
{
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
            SELECT COUNT(1) INTO l_count FROM xccc_t 
             WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld
               AND xccc001 = g_xccc_m.xccc001
               AND xccc003 = g_xccc_m.xccc003
               AND xccc004 = g_xccc_m.xccc004
               AND xccc005 = g_xccc_m.xccc005
 
               AND xccc002 = g_xccc_d[l_ac].xccc002
               AND xccc006 = g_xccc_d[l_ac].xccc006
               AND xccc007 = g_xccc_d[l_ac].xccc007
               AND xccc008 = g_xccc_d[l_ac].xccc008
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xccc_t
                           (xcccent,
                            xccccomp,xccc004,xccc005,xccc001,xcccld,xccc003,
                            xccc002,xccc006,xccc007,xccc008
                            ,xccc101,xccc102,xccc201,xccc202,xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,xccc301,xccc302,xccc901,xccc902,xccc903,xccc101,xccc102,xccc201,xccc202,xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,xccc214,xccc215,xccc216,xccc217,xccc218,xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307,xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h) 
                     VALUES(g_enterprise,
                            g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld,g_xccc_m.xccc003,
                            g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008 
 
                            ,g_xccc_d[l_ac].xccc101,g_xccc_d[l_ac].xccc102,g_xccc_d[l_ac].xccc201,g_xccc_d[l_ac].xccc202, 
                                g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc280a,g_xccc_d[l_ac].xccc280b, 
                                g_xccc_d[l_ac].xccc280c,g_xccc_d[l_ac].xccc280d,g_xccc_d[l_ac].xccc280e, 
                                g_xccc_d[l_ac].xccc280f,g_xccc_d[l_ac].xccc280g,g_xccc_d[l_ac].xccc280h, 
                                g_xccc_d[l_ac].xccc301,g_xccc_d[l_ac].xccc302,g_xccc_d[l_ac].xccc901, 
                                g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc903,g_xccc_d[l_ac].xccc101, 
                                g_xccc_d[l_ac].xccc102,g_xccc_d[l_ac].xccc201,g_xccc_d[l_ac].xccc202, 
                                g_xccc2_d[l_ac].xccc203,g_xccc2_d[l_ac].xccc204,g_xccc2_d[l_ac].xccc205, 
                                g_xccc2_d[l_ac].xccc206,g_xccc2_d[l_ac].xccc207,g_xccc2_d[l_ac].xccc208, 
                                g_xccc2_d[l_ac].xccc209,g_xccc2_d[l_ac].xccc210,g_xccc2_d[l_ac].xccc211, 
                                g_xccc2_d[l_ac].xccc212,g_xccc2_d[l_ac].xccc213,g_xccc2_d[l_ac].xccc214, 
                                g_xccc2_d[l_ac].xccc215,g_xccc2_d[l_ac].xccc216,g_xccc2_d[l_ac].xccc217, 
                                g_xccc2_d[l_ac].xccc218,g_xccc_d[l_ac].xccc301,g_xccc_d[l_ac].xccc302, 
                                g_xccc2_d[l_ac].xccc303,g_xccc2_d[l_ac].xccc304,g_xccc2_d[l_ac].xccc305, 
                                g_xccc2_d[l_ac].xccc306,g_xccc2_d[l_ac].xccc307,g_xccc2_d[l_ac].xccc308, 
                                g_xccc2_d[l_ac].xccc309,g_xccc2_d[l_ac].xccc310,g_xccc2_d[l_ac].xccc311, 
                                g_xccc2_d[l_ac].xccc312,g_xccc2_d[l_ac].xccc313,g_xccc2_d[l_ac].xccc314, 
                                g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc903, 
                                g_xccc2_d[l_ac].xccc903a,g_xccc2_d[l_ac].xccc903b,g_xccc2_d[l_ac].xccc903c, 
                                g_xccc2_d[l_ac].xccc903d,g_xccc2_d[l_ac].xccc903e,g_xccc2_d[l_ac].xccc903f, 
                                g_xccc2_d[l_ac].xccc903g,g_xccc2_d[l_ac].xccc903h)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xccc_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
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
}
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
               IF axcq530_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xccc_m.xcccld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc006
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc007
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc008
 
 
                  #刪除下層單身
                  IF NOT axcq530_key_delete_b(gs_keys,'xccc_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq530_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq530_bcl
               LET l_count = g_xccc_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="input.a.page1.imag011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_d[l_ac].imag011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].imag011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].imag011_desc


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
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002 name="input.a.page1.xccc002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xccc_m.xcccld IS NOT NULL AND g_xccc_m.xccc001 IS NOT NULL AND g_xccc_m.xccc003 IS NOT NULL AND g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc002 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc006 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc007 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t OR g_xccc_m.xccc001 != g_xccc001_t OR g_xccc_m.xccc003 != g_xccc003_t OR g_xccc_m.xccc004 != g_xccc004_t OR g_xccc_m.xccc005 != g_xccc005_t OR g_xccc_d[g_detail_idx].xccc002 != g_xccc_d_t.xccc002 OR g_xccc_d[g_detail_idx].xccc006 != g_xccc_d_t.xccc006 OR g_xccc_d[g_detail_idx].xccc007 != g_xccc_d_t.xccc007 OR g_xccc_d[g_detail_idx].xccc008 != g_xccc_d_t.xccc008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"' AND "|| "xccc002 = '"||g_xccc_d[g_detail_idx].xccc002 ||"' AND "|| "xccc006 = '"||g_xccc_d[g_detail_idx].xccc006 ||"' AND "|| "xccc007 = '"||g_xccc_d[g_detail_idx].xccc007 ||"' AND "|| "xccc008 = '"||g_xccc_d[g_detail_idx].xccc008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_d[l_ac].xccc002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002 name="input.b.page1.xccc002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc002
            #add-point:ON CHANGE xccc002 name="input.g.page1.xccc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc006
            
            #add-point:AFTER FIELD xccc006 name="input.a.page1.xccc006"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xccc_m.xcccld IS NOT NULL AND g_xccc_m.xccc001 IS NOT NULL AND g_xccc_m.xccc003 IS NOT NULL AND g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc002 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc006 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc007 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t OR g_xccc_m.xccc001 != g_xccc001_t OR g_xccc_m.xccc003 != g_xccc003_t OR g_xccc_m.xccc004 != g_xccc004_t OR g_xccc_m.xccc005 != g_xccc005_t OR g_xccc_d[g_detail_idx].xccc002 != g_xccc_d_t.xccc002 OR g_xccc_d[g_detail_idx].xccc006 != g_xccc_d_t.xccc006 OR g_xccc_d[g_detail_idx].xccc007 != g_xccc_d_t.xccc007 OR g_xccc_d[g_detail_idx].xccc008 != g_xccc_d_t.xccc008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"' AND "|| "xccc002 = '"||g_xccc_d[g_detail_idx].xccc002 ||"' AND "|| "xccc006 = '"||g_xccc_d[g_detail_idx].xccc006 ||"' AND "|| "xccc007 = '"||g_xccc_d[g_detail_idx].xccc007 ||"' AND "|| "xccc008 = '"||g_xccc_d[g_detail_idx].xccc008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_d[l_ac].xccc006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc006
            #add-point:BEFORE FIELD xccc006 name="input.b.page1.xccc006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc006
            #add-point:ON CHANGE xccc006 name="input.g.page1.xccc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc007
            #add-point:BEFORE FIELD xccc007 name="input.b.page1.xccc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc007
            
            #add-point:AFTER FIELD xccc007 name="input.a.page1.xccc007"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xccc_m.xcccld IS NOT NULL AND g_xccc_m.xccc001 IS NOT NULL AND g_xccc_m.xccc003 IS NOT NULL AND g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc002 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc006 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc007 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t OR g_xccc_m.xccc001 != g_xccc001_t OR g_xccc_m.xccc003 != g_xccc003_t OR g_xccc_m.xccc004 != g_xccc004_t OR g_xccc_m.xccc005 != g_xccc005_t OR g_xccc_d[g_detail_idx].xccc002 != g_xccc_d_t.xccc002 OR g_xccc_d[g_detail_idx].xccc006 != g_xccc_d_t.xccc006 OR g_xccc_d[g_detail_idx].xccc007 != g_xccc_d_t.xccc007 OR g_xccc_d[g_detail_idx].xccc008 != g_xccc_d_t.xccc008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"' AND "|| "xccc002 = '"||g_xccc_d[g_detail_idx].xccc002 ||"' AND "|| "xccc006 = '"||g_xccc_d[g_detail_idx].xccc006 ||"' AND "|| "xccc007 = '"||g_xccc_d[g_detail_idx].xccc007 ||"' AND "|| "xccc008 = '"||g_xccc_d[g_detail_idx].xccc008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc007
            #add-point:ON CHANGE xccc007 name="input.g.page1.xccc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc008
            #add-point:BEFORE FIELD xccc008 name="input.b.page1.xccc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc008
            
            #add-point:AFTER FIELD xccc008 name="input.a.page1.xccc008"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xccc_m.xcccld IS NOT NULL AND g_xccc_m.xccc001 IS NOT NULL AND g_xccc_m.xccc003 IS NOT NULL AND g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc002 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc006 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc007 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t OR g_xccc_m.xccc001 != g_xccc001_t OR g_xccc_m.xccc003 != g_xccc003_t OR g_xccc_m.xccc004 != g_xccc004_t OR g_xccc_m.xccc005 != g_xccc005_t OR g_xccc_d[g_detail_idx].xccc002 != g_xccc_d_t.xccc002 OR g_xccc_d[g_detail_idx].xccc006 != g_xccc_d_t.xccc006 OR g_xccc_d[g_detail_idx].xccc007 != g_xccc_d_t.xccc007 OR g_xccc_d[g_detail_idx].xccc008 != g_xccc_d_t.xccc008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"' AND "|| "xccc002 = '"||g_xccc_d[g_detail_idx].xccc002 ||"' AND "|| "xccc006 = '"||g_xccc_d[g_detail_idx].xccc006 ||"' AND "|| "xccc007 = '"||g_xccc_d[g_detail_idx].xccc007 ||"' AND "|| "xccc008 = '"||g_xccc_d[g_detail_idx].xccc008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc008
            #add-point:ON CHANGE xccc008 name="input.g.page1.xccc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb005
            #add-point:BEFORE FIELD xcbb005 name="input.b.page1.xcbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb005
            
            #add-point:AFTER FIELD xcbb005 name="input.a.page1.xcbb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb005
            #add-point:ON CHANGE xcbb005 name="input.g.page1.xcbb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc101
            #add-point:BEFORE FIELD xccc101 name="input.b.page1.xccc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc101
            
            #add-point:AFTER FIELD xccc101 name="input.a.page1.xccc101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc101
            #add-point:ON CHANGE xccc101 name="input.g.page1.xccc101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_unit
            #add-point:BEFORE FIELD l_unit name="input.b.page1.l_unit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_unit
            
            #add-point:AFTER FIELD l_unit name="input.a.page1.l_unit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_unit
            #add-point:ON CHANGE l_unit name="input.g.page1.l_unit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc102
            #add-point:BEFORE FIELD xccc102 name="input.b.page1.xccc102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc102
            
            #add-point:AFTER FIELD xccc102 name="input.a.page1.xccc102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc102
            #add-point:ON CHANGE xccc102 name="input.g.page1.xccc102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc201
            #add-point:BEFORE FIELD xccc201 name="input.b.page1.xccc201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc201
            
            #add-point:AFTER FIELD xccc201 name="input.a.page1.xccc201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc201
            #add-point:ON CHANGE xccc201 name="input.g.page1.xccc201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc202
            #add-point:BEFORE FIELD xccc202 name="input.b.page1.xccc202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc202
            
            #add-point:AFTER FIELD xccc202 name="input.a.page1.xccc202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc202
            #add-point:ON CHANGE xccc202 name="input.g.page1.xccc202"
            
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
         BEFORE FIELD xccc280a
            #add-point:BEFORE FIELD xccc280a name="input.b.page1.xccc280a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280a
            
            #add-point:AFTER FIELD xccc280a name="input.a.page1.xccc280a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280a
            #add-point:ON CHANGE xccc280a name="input.g.page1.xccc280a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280b
            #add-point:BEFORE FIELD xccc280b name="input.b.page1.xccc280b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280b
            
            #add-point:AFTER FIELD xccc280b name="input.a.page1.xccc280b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280b
            #add-point:ON CHANGE xccc280b name="input.g.page1.xccc280b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280c
            #add-point:BEFORE FIELD xccc280c name="input.b.page1.xccc280c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280c
            
            #add-point:AFTER FIELD xccc280c name="input.a.page1.xccc280c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280c
            #add-point:ON CHANGE xccc280c name="input.g.page1.xccc280c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280d
            #add-point:BEFORE FIELD xccc280d name="input.b.page1.xccc280d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280d
            
            #add-point:AFTER FIELD xccc280d name="input.a.page1.xccc280d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280d
            #add-point:ON CHANGE xccc280d name="input.g.page1.xccc280d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280e
            #add-point:BEFORE FIELD xccc280e name="input.b.page1.xccc280e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280e
            
            #add-point:AFTER FIELD xccc280e name="input.a.page1.xccc280e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280e
            #add-point:ON CHANGE xccc280e name="input.g.page1.xccc280e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280f
            #add-point:BEFORE FIELD xccc280f name="input.b.page1.xccc280f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280f
            
            #add-point:AFTER FIELD xccc280f name="input.a.page1.xccc280f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280f
            #add-point:ON CHANGE xccc280f name="input.g.page1.xccc280f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280g
            #add-point:BEFORE FIELD xccc280g name="input.b.page1.xccc280g"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280g
            
            #add-point:AFTER FIELD xccc280g name="input.a.page1.xccc280g"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280g
            #add-point:ON CHANGE xccc280g name="input.g.page1.xccc280g"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc280h
            #add-point:BEFORE FIELD xccc280h name="input.b.page1.xccc280h"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc280h
            
            #add-point:AFTER FIELD xccc280h name="input.a.page1.xccc280h"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc280h
            #add-point:ON CHANGE xccc280h name="input.g.page1.xccc280h"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc301
            #add-point:BEFORE FIELD xccc301 name="input.b.page1.xccc301"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc301
            
            #add-point:AFTER FIELD xccc301 name="input.a.page1.xccc301"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc301
            #add-point:ON CHANGE xccc301 name="input.g.page1.xccc301"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc302
            #add-point:BEFORE FIELD xccc302 name="input.b.page1.xccc302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc302
            
            #add-point:AFTER FIELD xccc302 name="input.a.page1.xccc302"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc302
            #add-point:ON CHANGE xccc302 name="input.g.page1.xccc302"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc901
            #add-point:BEFORE FIELD xccc901 name="input.b.page1.xccc901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc901
            
            #add-point:AFTER FIELD xccc901 name="input.a.page1.xccc901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc901
            #add-point:ON CHANGE xccc901 name="input.g.page1.xccc901"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc902
            #add-point:BEFORE FIELD xccc902 name="input.b.page1.xccc902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc902
            
            #add-point:AFTER FIELD xccc902 name="input.a.page1.xccc902"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc902
            #add-point:ON CHANGE xccc902 name="input.g.page1.xccc902"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc903
            #add-point:BEFORE FIELD xccc903 name="input.b.page1.xccc903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc903
            
            #add-point:AFTER FIELD xccc903 name="input.a.page1.xccc903"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc903
            #add-point:ON CHANGE xccc903 name="input.g.page1.xccc903"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="input.c.page1.imag011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccc_d[l_ac].imag011             #給予default值
            LET g_qryparam.default2 = "" #g_xccc_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_xccc_d[l_ac].imag011 = g_qryparam.return1              
            #LET g_xccc_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_xccc_d[l_ac].imag011 TO imag011              #
            #DISPLAY g_xccc_d[l_ac].oocq002 TO oocq002 #應用分類碼
            NEXT FIELD imag011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002 name="input.c.page1.xccc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006 name="input.c.page1.xccc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc007
            #add-point:ON ACTION controlp INFIELD xccc007 name="input.c.page1.xccc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc008
            #add-point:ON ACTION controlp INFIELD xccc008 name="input.c.page1.xccc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb005
            #add-point:ON ACTION controlp INFIELD xcbb005 name="input.c.page1.xcbb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc101
            #add-point:ON ACTION controlp INFIELD xccc101 name="input.c.page1.xccc101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_unit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_unit
            #add-point:ON ACTION controlp INFIELD l_unit name="input.c.page1.l_unit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc102
            #add-point:ON ACTION controlp INFIELD xccc102 name="input.c.page1.xccc102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc201
            #add-point:ON ACTION controlp INFIELD xccc201 name="input.c.page1.xccc201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc202
            #add-point:ON ACTION controlp INFIELD xccc202 name="input.c.page1.xccc202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280
            #add-point:ON ACTION controlp INFIELD xccc280 name="input.c.page1.xccc280"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280a
            #add-point:ON ACTION controlp INFIELD xccc280a name="input.c.page1.xccc280a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280b
            #add-point:ON ACTION controlp INFIELD xccc280b name="input.c.page1.xccc280b"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280c
            #add-point:ON ACTION controlp INFIELD xccc280c name="input.c.page1.xccc280c"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280d
            #add-point:ON ACTION controlp INFIELD xccc280d name="input.c.page1.xccc280d"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280e
            #add-point:ON ACTION controlp INFIELD xccc280e name="input.c.page1.xccc280e"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280f
            #add-point:ON ACTION controlp INFIELD xccc280f name="input.c.page1.xccc280f"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280g
            #add-point:ON ACTION controlp INFIELD xccc280g name="input.c.page1.xccc280g"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc280h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280h
            #add-point:ON ACTION controlp INFIELD xccc280h name="input.c.page1.xccc280h"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc301
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc301
            #add-point:ON ACTION controlp INFIELD xccc301 name="input.c.page1.xccc301"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc302
            #add-point:ON ACTION controlp INFIELD xccc302 name="input.c.page1.xccc302"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc901
            #add-point:ON ACTION controlp INFIELD xccc901 name="input.c.page1.xccc901"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc902
            #add-point:ON ACTION controlp INFIELD xccc902 name="input.c.page1.xccc902"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc903
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc903
            #add-point:ON ACTION controlp INFIELD xccc903 name="input.c.page1.xccc903"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xccc_d[l_ac].* = g_xccc_d_t.*
               CLOSE axcq530_bcl
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
               LET g_errparam.extend = g_xccc_d[l_ac].xccc002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccc_d[l_ac].* = g_xccc_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
{
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq530_xccc_t_mask_restore('restore_mask_o')
         
               UPDATE xccc_t SET (xcccld,xccc001,xccc003,xccc004,xccc005,xccc002,xccc006,xccc007,xccc008, 
                   xccc101,xccc102,xccc201,xccc202,xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e, 
                   xccc280f,xccc280g,xccc280h,xccc301,xccc302,xccc901,xccc902,xccc903,xccc203,xccc204, 
                   xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,xccc214,xccc215, 
                   xccc216,xccc217,xccc218,xccc303,xccc304,xccc305,xccc306,xccc307,xccc308,xccc309,xccc310, 
                   xccc311,xccc312,xccc313,xccc314,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f, 
                   xccc903g,xccc903h) = (g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
                   g_xccc_m.xccc005,g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007, 
                   g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc101,g_xccc_d[l_ac].xccc102,g_xccc_d[l_ac].xccc201, 
                   g_xccc_d[l_ac].xccc202,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc280a,g_xccc_d[l_ac].xccc280b, 
                   g_xccc_d[l_ac].xccc280c,g_xccc_d[l_ac].xccc280d,g_xccc_d[l_ac].xccc280e,g_xccc_d[l_ac].xccc280f, 
                   g_xccc_d[l_ac].xccc280g,g_xccc_d[l_ac].xccc280h,g_xccc_d[l_ac].xccc301,g_xccc_d[l_ac].xccc302, 
                   g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc903,g_xccc2_d[l_ac].xccc203, 
                   g_xccc2_d[l_ac].xccc204,g_xccc2_d[l_ac].xccc205,g_xccc2_d[l_ac].xccc206,g_xccc2_d[l_ac].xccc207, 
                   g_xccc2_d[l_ac].xccc208,g_xccc2_d[l_ac].xccc209,g_xccc2_d[l_ac].xccc210,g_xccc2_d[l_ac].xccc211, 
                   g_xccc2_d[l_ac].xccc212,g_xccc2_d[l_ac].xccc213,g_xccc2_d[l_ac].xccc214,g_xccc2_d[l_ac].xccc215, 
                   g_xccc2_d[l_ac].xccc216,g_xccc2_d[l_ac].xccc217,g_xccc2_d[l_ac].xccc218,g_xccc2_d[l_ac].xccc303, 
                   g_xccc2_d[l_ac].xccc304,g_xccc2_d[l_ac].xccc305,g_xccc2_d[l_ac].xccc306,g_xccc2_d[l_ac].xccc307, 
                   g_xccc2_d[l_ac].xccc308,g_xccc2_d[l_ac].xccc309,g_xccc2_d[l_ac].xccc310,g_xccc2_d[l_ac].xccc311, 
                   g_xccc2_d[l_ac].xccc312,g_xccc2_d[l_ac].xccc313,g_xccc2_d[l_ac].xccc314,g_xccc2_d[l_ac].xccc903a, 
                   g_xccc2_d[l_ac].xccc903b,g_xccc2_d[l_ac].xccc903c,g_xccc2_d[l_ac].xccc903d,g_xccc2_d[l_ac].xccc903e, 
                   g_xccc2_d[l_ac].xccc903f,g_xccc2_d[l_ac].xccc903g,g_xccc2_d[l_ac].xccc903h)
                WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld 
                 AND xccc001 = g_xccc_m.xccc001 
                 AND xccc003 = g_xccc_m.xccc003 
                 AND xccc004 = g_xccc_m.xccc004 
                 AND xccc005 = g_xccc_m.xccc005 
 
                 AND xccc002 = g_xccc_d_t.xccc002 #項次   
                 AND xccc006 = g_xccc_d_t.xccc006  
                 AND xccc007 = g_xccc_d_t.xccc007  
                 AND xccc008 = g_xccc_d_t.xccc008  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccc_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccc_m.xcccld
               LET gs_keys_bak[1] = g_xcccld_t
               LET gs_keys[2] = g_xccc_m.xccc001
               LET gs_keys_bak[2] = g_xccc001_t
               LET gs_keys[3] = g_xccc_m.xccc003
               LET gs_keys_bak[3] = g_xccc003_t
               LET gs_keys[4] = g_xccc_m.xccc004
               LET gs_keys_bak[4] = g_xccc004_t
               LET gs_keys[5] = g_xccc_m.xccc005
               LET gs_keys_bak[5] = g_xccc005_t
               LET gs_keys[6] = g_xccc_d[g_detail_idx].xccc002
               LET gs_keys_bak[6] = g_xccc_d_t.xccc002
               LET gs_keys[7] = g_xccc_d[g_detail_idx].xccc006
               LET gs_keys_bak[7] = g_xccc_d_t.xccc006
               LET gs_keys[8] = g_xccc_d[g_detail_idx].xccc007
               LET gs_keys_bak[8] = g_xccc_d_t.xccc007
               LET gs_keys[9] = g_xccc_d[g_detail_idx].xccc008
               LET gs_keys_bak[9] = g_xccc_d_t.xccc008
               CALL axcq530_update_b('xccc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq530_xccc_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xccc_m.xcccld
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc001
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc003
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc004
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc002
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc006
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc007
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc008
 
               CALL axcq530_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
}
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq530_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccc_d[l_ac].* = g_xccc_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq530_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccc_d.getLength() = 0 THEN
               NEXT FIELD xccc002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xccc_d[li_reproduce_target].* = g_xccc_d[li_reproduce].*
               LET g_xccc2_d[li_reproduce_target].* = g_xccc2_d[li_reproduce].*
 
               LET g_xccc_d[li_reproduce_target].xccc002 = NULL
               LET g_xccc_d[li_reproduce_target].xccc006 = NULL
               LET g_xccc_d[li_reproduce_target].xccc007 = NULL
               LET g_xccc_d[li_reproduce_target].xccc008 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xccc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xccc_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_xccc2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL axcq530_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 2
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body2.before_row2"
            
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq530_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL axcq530_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body2.before_row.set_entry_b"
               
               #end add-point
               CALL axcq530_set_no_entry_b(l_cmd)
               LET g_xccc2_d_t.* = g_xccc2_d[l_ac].*   #BACKUP  #page1
               LET g_xccc2_d_o.* = g_xccc2_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xccc002
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xccc2_d_t.* TO NULL
            INITIALIZE g_xccc2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccc2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccc2_d[l_ac].l_unit_2 = "0"
      LET g_xccc2_d[l_ac].xccc203 = "0"
      LET g_xccc2_d[l_ac].xccc204 = "0"
      LET g_xccc2_d[l_ac].xccc205 = "0"
      LET g_xccc2_d[l_ac].xccc206 = "0"
      LET g_xccc2_d[l_ac].xccc207 = "0"
      LET g_xccc2_d[l_ac].xccc208 = "0"
      LET g_xccc2_d[l_ac].xccc209 = "0"
      LET g_xccc2_d[l_ac].xccc210 = "0"
      LET g_xccc2_d[l_ac].xccc211 = "0"
      LET g_xccc2_d[l_ac].xccc212 = "0"
      LET g_xccc2_d[l_ac].xccc213 = "0"
      LET g_xccc2_d[l_ac].xccc214 = "0"
      LET g_xccc2_d[l_ac].xccc215 = "0"
      LET g_xccc2_d[l_ac].xccc216 = "0"
      LET g_xccc2_d[l_ac].xccc217 = "0"
      LET g_xccc2_d[l_ac].xccc218 = "0"
      LET g_xccc2_d[l_ac].xccc303 = "0"
      LET g_xccc2_d[l_ac].xccc304 = "0"
      LET g_xccc2_d[l_ac].xccc305 = "0"
      LET g_xccc2_d[l_ac].xccc306 = "0"
      LET g_xccc2_d[l_ac].xccc307 = "0"
      LET g_xccc2_d[l_ac].xccc308 = "0"
      LET g_xccc2_d[l_ac].xccc309 = "0"
      LET g_xccc2_d[l_ac].xccc310 = "0"
      LET g_xccc2_d[l_ac].xccc311 = "0"
      LET g_xccc2_d[l_ac].xccc312 = "0"
      LET g_xccc2_d[l_ac].xccc313 = "0"
      LET g_xccc2_d[l_ac].xccc314 = "0"
 
            
            #add-point:modify段before備份 name="input.body2.before_insert.before_bak"
            
            #end add-point
            LET g_xccc2_d_t.* = g_xccc2_d[l_ac].*     #新輸入資料
            LET g_xccc2_d_o.* = g_xccc2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq530_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body2.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq530_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccc_d[li_reproduce_target].* = g_xccc_d[li_reproduce].*
               LET g_xccc2_d[li_reproduce_target].* = g_xccc2_d[li_reproduce].*
 
               LET g_xccc2_d[li_reproduce_target].xccc002 = NULL
               LET g_xccc2_d[li_reproduce_target].xccc006 = NULL
               LET g_xccc2_d[li_reproduce_target].xccc007 = NULL
               LET g_xccc2_d[li_reproduce_target].xccc008 = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point
            
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
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF axcq530_before_delete() THEN 
                  
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xccc_m.xcccld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc005
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc006
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc007
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc008
 
                  #刪除下層單身
                  IF NOT axcq530_key_delete_b(gs_keys,'xccc_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq530_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq530_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_xccc2_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body2.after_delete"
               
               #end add-point
                              CALL axcq530_delete_b('xccc_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccc2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xccc2_d[l_ac].* = g_xccc2_d_t.*
               CLOSE axcq530_bcl
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
               LET g_errparam.extend = g_xccc_d[l_ac].xccc002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccc2_d[l_ac].* = g_xccc2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axcq530_xccc_t_mask_restore('restore_mask_o')
                     
               UPDATE xccc_t SET (xcccld,xccc001,xccc003,xccc004,xccc005,xccc002,xccc006,xccc007,xccc008, 
                   xccc101,xccc102,xccc201,xccc202,xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e, 
                   xccc280f,xccc280g,xccc280h,xccc301,xccc302,xccc901,xccc902,xccc903,xccc203,xccc204, 
                   xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,xccc214,xccc215, 
                   xccc216,xccc217,xccc218,xccc303,xccc304,xccc305,xccc306,xccc307,xccc308,xccc309,xccc310, 
                   xccc311,xccc312,xccc313,xccc314,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f, 
                   xccc903g,xccc903h) = (g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
                   g_xccc_m.xccc005,g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007, 
                   g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc101,g_xccc_d[l_ac].xccc102,g_xccc_d[l_ac].xccc201, 
                   g_xccc_d[l_ac].xccc202,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc280a,g_xccc_d[l_ac].xccc280b, 
                   g_xccc_d[l_ac].xccc280c,g_xccc_d[l_ac].xccc280d,g_xccc_d[l_ac].xccc280e,g_xccc_d[l_ac].xccc280f, 
                   g_xccc_d[l_ac].xccc280g,g_xccc_d[l_ac].xccc280h,g_xccc_d[l_ac].xccc301,g_xccc_d[l_ac].xccc302, 
                   g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc903,g_xccc2_d[l_ac].xccc203, 
                   g_xccc2_d[l_ac].xccc204,g_xccc2_d[l_ac].xccc205,g_xccc2_d[l_ac].xccc206,g_xccc2_d[l_ac].xccc207, 
                   g_xccc2_d[l_ac].xccc208,g_xccc2_d[l_ac].xccc209,g_xccc2_d[l_ac].xccc210,g_xccc2_d[l_ac].xccc211, 
                   g_xccc2_d[l_ac].xccc212,g_xccc2_d[l_ac].xccc213,g_xccc2_d[l_ac].xccc214,g_xccc2_d[l_ac].xccc215, 
                   g_xccc2_d[l_ac].xccc216,g_xccc2_d[l_ac].xccc217,g_xccc2_d[l_ac].xccc218,g_xccc2_d[l_ac].xccc303, 
                   g_xccc2_d[l_ac].xccc304,g_xccc2_d[l_ac].xccc305,g_xccc2_d[l_ac].xccc306,g_xccc2_d[l_ac].xccc307, 
                   g_xccc2_d[l_ac].xccc308,g_xccc2_d[l_ac].xccc309,g_xccc2_d[l_ac].xccc310,g_xccc2_d[l_ac].xccc311, 
                   g_xccc2_d[l_ac].xccc312,g_xccc2_d[l_ac].xccc313,g_xccc2_d[l_ac].xccc314,g_xccc2_d[l_ac].xccc903a, 
                   g_xccc2_d[l_ac].xccc903b,g_xccc2_d[l_ac].xccc903c,g_xccc2_d[l_ac].xccc903d,g_xccc2_d[l_ac].xccc903e, 
                   g_xccc2_d[l_ac].xccc903f,g_xccc2_d[l_ac].xccc903g,g_xccc2_d[l_ac].xccc903h) #自訂欄位頁簽 
 
                WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld
                 AND xccc001 = g_xccc_m.xccc001
                 AND xccc003 = g_xccc_m.xccc003
                 AND xccc004 = g_xccc_m.xccc004
                 AND xccc005 = g_xccc_m.xccc005
                 AND xccc002 = g_xccc2_d_t.xccc002 #項次 
                 AND xccc006 = g_xccc2_d_t.xccc006
                 AND xccc007 = g_xccc2_d_t.xccc007
                 AND xccc008 = g_xccc2_d_t.xccc008
               #add-point:單身修改中 name="modify.body2.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccc_m.xcccld
               LET gs_keys_bak[1] = g_xcccld_t
               LET gs_keys[2] = g_xccc_m.xccc001
               LET gs_keys_bak[2] = g_xccc001_t
               LET gs_keys[3] = g_xccc_m.xccc003
               LET gs_keys_bak[3] = g_xccc003_t
               LET gs_keys[4] = g_xccc_m.xccc004
               LET gs_keys_bak[4] = g_xccc004_t
               LET gs_keys[5] = g_xccc_m.xccc005
               LET gs_keys_bak[5] = g_xccc005_t
               LET gs_keys[6] = g_xccc2_d[g_detail_idx].xccc002
               LET gs_keys_bak[6] = g_xccc2_d_t.xccc002
               LET gs_keys[7] = g_xccc2_d[g_detail_idx].xccc006
               LET gs_keys_bak[7] = g_xccc2_d_t.xccc006
               LET gs_keys[8] = g_xccc2_d[g_detail_idx].xccc007
               LET gs_keys_bak[8] = g_xccc2_d_t.xccc007
               LET gs_keys[9] = g_xccc2_d[g_detail_idx].xccc008
               LET gs_keys_bak[9] = g_xccc2_d_t.xccc008
               CALL axcq530_update_b('xccc_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc2_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq530_xccc_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_unit_2
            #add-point:BEFORE FIELD l_unit_2 name="input.b.page2.l_unit_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_unit_2
            
            #add-point:AFTER FIELD l_unit_2 name="input.a.page2.l_unit_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_unit_2
            #add-point:ON CHANGE l_unit_2 name="input.g.page2.l_unit_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc203
            #add-point:BEFORE FIELD xccc203 name="input.b.page2.xccc203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc203
            
            #add-point:AFTER FIELD xccc203 name="input.a.page2.xccc203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc203
            #add-point:ON CHANGE xccc203 name="input.g.page2.xccc203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc204
            #add-point:BEFORE FIELD xccc204 name="input.b.page2.xccc204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc204
            
            #add-point:AFTER FIELD xccc204 name="input.a.page2.xccc204"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc204
            #add-point:ON CHANGE xccc204 name="input.g.page2.xccc204"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc205
            #add-point:BEFORE FIELD xccc205 name="input.b.page2.xccc205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc205
            
            #add-point:AFTER FIELD xccc205 name="input.a.page2.xccc205"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc205
            #add-point:ON CHANGE xccc205 name="input.g.page2.xccc205"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc206
            #add-point:BEFORE FIELD xccc206 name="input.b.page2.xccc206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc206
            
            #add-point:AFTER FIELD xccc206 name="input.a.page2.xccc206"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc206
            #add-point:ON CHANGE xccc206 name="input.g.page2.xccc206"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc207
            #add-point:BEFORE FIELD xccc207 name="input.b.page2.xccc207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc207
            
            #add-point:AFTER FIELD xccc207 name="input.a.page2.xccc207"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc207
            #add-point:ON CHANGE xccc207 name="input.g.page2.xccc207"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc208
            #add-point:BEFORE FIELD xccc208 name="input.b.page2.xccc208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc208
            
            #add-point:AFTER FIELD xccc208 name="input.a.page2.xccc208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc208
            #add-point:ON CHANGE xccc208 name="input.g.page2.xccc208"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc209
            #add-point:BEFORE FIELD xccc209 name="input.b.page2.xccc209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc209
            
            #add-point:AFTER FIELD xccc209 name="input.a.page2.xccc209"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc209
            #add-point:ON CHANGE xccc209 name="input.g.page2.xccc209"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc210
            #add-point:BEFORE FIELD xccc210 name="input.b.page2.xccc210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc210
            
            #add-point:AFTER FIELD xccc210 name="input.a.page2.xccc210"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc210
            #add-point:ON CHANGE xccc210 name="input.g.page2.xccc210"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc211
            #add-point:BEFORE FIELD xccc211 name="input.b.page2.xccc211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc211
            
            #add-point:AFTER FIELD xccc211 name="input.a.page2.xccc211"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc211
            #add-point:ON CHANGE xccc211 name="input.g.page2.xccc211"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc212
            #add-point:BEFORE FIELD xccc212 name="input.b.page2.xccc212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc212
            
            #add-point:AFTER FIELD xccc212 name="input.a.page2.xccc212"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc212
            #add-point:ON CHANGE xccc212 name="input.g.page2.xccc212"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc213
            #add-point:BEFORE FIELD xccc213 name="input.b.page2.xccc213"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc213
            
            #add-point:AFTER FIELD xccc213 name="input.a.page2.xccc213"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc213
            #add-point:ON CHANGE xccc213 name="input.g.page2.xccc213"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc214
            #add-point:BEFORE FIELD xccc214 name="input.b.page2.xccc214"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc214
            
            #add-point:AFTER FIELD xccc214 name="input.a.page2.xccc214"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc214
            #add-point:ON CHANGE xccc214 name="input.g.page2.xccc214"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc215
            #add-point:BEFORE FIELD xccc215 name="input.b.page2.xccc215"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc215
            
            #add-point:AFTER FIELD xccc215 name="input.a.page2.xccc215"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc215
            #add-point:ON CHANGE xccc215 name="input.g.page2.xccc215"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc216
            #add-point:BEFORE FIELD xccc216 name="input.b.page2.xccc216"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc216
            
            #add-point:AFTER FIELD xccc216 name="input.a.page2.xccc216"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc216
            #add-point:ON CHANGE xccc216 name="input.g.page2.xccc216"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc217
            #add-point:BEFORE FIELD xccc217 name="input.b.page2.xccc217"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc217
            
            #add-point:AFTER FIELD xccc217 name="input.a.page2.xccc217"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc217
            #add-point:ON CHANGE xccc217 name="input.g.page2.xccc217"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc218
            #add-point:BEFORE FIELD xccc218 name="input.b.page2.xccc218"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc218
            
            #add-point:AFTER FIELD xccc218 name="input.a.page2.xccc218"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc218
            #add-point:ON CHANGE xccc218 name="input.g.page2.xccc218"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc303
            #add-point:BEFORE FIELD xccc303 name="input.b.page2.xccc303"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc303
            
            #add-point:AFTER FIELD xccc303 name="input.a.page2.xccc303"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc303
            #add-point:ON CHANGE xccc303 name="input.g.page2.xccc303"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc304
            #add-point:BEFORE FIELD xccc304 name="input.b.page2.xccc304"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc304
            
            #add-point:AFTER FIELD xccc304 name="input.a.page2.xccc304"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc304
            #add-point:ON CHANGE xccc304 name="input.g.page2.xccc304"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc305
            #add-point:BEFORE FIELD xccc305 name="input.b.page2.xccc305"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc305
            
            #add-point:AFTER FIELD xccc305 name="input.a.page2.xccc305"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc305
            #add-point:ON CHANGE xccc305 name="input.g.page2.xccc305"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc306
            #add-point:BEFORE FIELD xccc306 name="input.b.page2.xccc306"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc306
            
            #add-point:AFTER FIELD xccc306 name="input.a.page2.xccc306"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc306
            #add-point:ON CHANGE xccc306 name="input.g.page2.xccc306"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc307
            #add-point:BEFORE FIELD xccc307 name="input.b.page2.xccc307"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc307
            
            #add-point:AFTER FIELD xccc307 name="input.a.page2.xccc307"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc307
            #add-point:ON CHANGE xccc307 name="input.g.page2.xccc307"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc308
            #add-point:BEFORE FIELD xccc308 name="input.b.page2.xccc308"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc308
            
            #add-point:AFTER FIELD xccc308 name="input.a.page2.xccc308"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc308
            #add-point:ON CHANGE xccc308 name="input.g.page2.xccc308"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc309
            #add-point:BEFORE FIELD xccc309 name="input.b.page2.xccc309"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc309
            
            #add-point:AFTER FIELD xccc309 name="input.a.page2.xccc309"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc309
            #add-point:ON CHANGE xccc309 name="input.g.page2.xccc309"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc310
            #add-point:BEFORE FIELD xccc310 name="input.b.page2.xccc310"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc310
            
            #add-point:AFTER FIELD xccc310 name="input.a.page2.xccc310"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc310
            #add-point:ON CHANGE xccc310 name="input.g.page2.xccc310"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc311
            #add-point:BEFORE FIELD xccc311 name="input.b.page2.xccc311"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc311
            
            #add-point:AFTER FIELD xccc311 name="input.a.page2.xccc311"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc311
            #add-point:ON CHANGE xccc311 name="input.g.page2.xccc311"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc312
            #add-point:BEFORE FIELD xccc312 name="input.b.page2.xccc312"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc312
            
            #add-point:AFTER FIELD xccc312 name="input.a.page2.xccc312"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc312
            #add-point:ON CHANGE xccc312 name="input.g.page2.xccc312"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc313
            #add-point:BEFORE FIELD xccc313 name="input.b.page2.xccc313"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc313
            
            #add-point:AFTER FIELD xccc313 name="input.a.page2.xccc313"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc313
            #add-point:ON CHANGE xccc313 name="input.g.page2.xccc313"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc314
            #add-point:BEFORE FIELD xccc314 name="input.b.page2.xccc314"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc314
            
            #add-point:AFTER FIELD xccc314 name="input.a.page2.xccc314"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc314
            #add-point:ON CHANGE xccc314 name="input.g.page2.xccc314"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.l_unit_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_unit_2
            #add-point:ON ACTION controlp INFIELD l_unit_2 name="input.c.page2.l_unit_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc203
            #add-point:ON ACTION controlp INFIELD xccc203 name="input.c.page2.xccc203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc204
            #add-point:ON ACTION controlp INFIELD xccc204 name="input.c.page2.xccc204"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc205
            #add-point:ON ACTION controlp INFIELD xccc205 name="input.c.page2.xccc205"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc206
            #add-point:ON ACTION controlp INFIELD xccc206 name="input.c.page2.xccc206"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc207
            #add-point:ON ACTION controlp INFIELD xccc207 name="input.c.page2.xccc207"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc208
            #add-point:ON ACTION controlp INFIELD xccc208 name="input.c.page2.xccc208"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc209
            #add-point:ON ACTION controlp INFIELD xccc209 name="input.c.page2.xccc209"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc210
            #add-point:ON ACTION controlp INFIELD xccc210 name="input.c.page2.xccc210"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc211
            #add-point:ON ACTION controlp INFIELD xccc211 name="input.c.page2.xccc211"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc212
            #add-point:ON ACTION controlp INFIELD xccc212 name="input.c.page2.xccc212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc213
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc213
            #add-point:ON ACTION controlp INFIELD xccc213 name="input.c.page2.xccc213"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc214
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc214
            #add-point:ON ACTION controlp INFIELD xccc214 name="input.c.page2.xccc214"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc215
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc215
            #add-point:ON ACTION controlp INFIELD xccc215 name="input.c.page2.xccc215"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc216
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc216
            #add-point:ON ACTION controlp INFIELD xccc216 name="input.c.page2.xccc216"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc217
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc217
            #add-point:ON ACTION controlp INFIELD xccc217 name="input.c.page2.xccc217"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc218
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc218
            #add-point:ON ACTION controlp INFIELD xccc218 name="input.c.page2.xccc218"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc303
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc303
            #add-point:ON ACTION controlp INFIELD xccc303 name="input.c.page2.xccc303"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc304
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc304
            #add-point:ON ACTION controlp INFIELD xccc304 name="input.c.page2.xccc304"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc305
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc305
            #add-point:ON ACTION controlp INFIELD xccc305 name="input.c.page2.xccc305"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc306
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc306
            #add-point:ON ACTION controlp INFIELD xccc306 name="input.c.page2.xccc306"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc307
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc307
            #add-point:ON ACTION controlp INFIELD xccc307 name="input.c.page2.xccc307"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc308
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc308
            #add-point:ON ACTION controlp INFIELD xccc308 name="input.c.page2.xccc308"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc309
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc309
            #add-point:ON ACTION controlp INFIELD xccc309 name="input.c.page2.xccc309"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc310
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc310
            #add-point:ON ACTION controlp INFIELD xccc310 name="input.c.page2.xccc310"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc311
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc311
            #add-point:ON ACTION controlp INFIELD xccc311 name="input.c.page2.xccc311"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc312
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc312
            #add-point:ON ACTION controlp INFIELD xccc312 name="input.c.page2.xccc312"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc313
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc313
            #add-point:ON ACTION controlp INFIELD xccc313 name="input.c.page2.xccc313"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xccc314
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc314
            #add-point:ON ACTION controlp INFIELD xccc314 name="input.c.page2.xccc314"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body2.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccc2_d[l_ac].* = g_xccc2_d_t.*
               END IF
               CLOSE axcq530_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE axcq530_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xccc_d[li_reproduce_target].* = g_xccc_d[li_reproduce].*
               LET g_xccc2_d[li_reproduce_target].* = g_xccc2_d[li_reproduce].*
 
               LET g_xccc2_d[li_reproduce_target].xccc002 = NULL
               LET g_xccc2_d[li_reproduce_target].xccc006 = NULL
               LET g_xccc2_d[li_reproduce_target].xccc007 = NULL
               LET g_xccc2_d[li_reproduce_target].xccc008 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xccc2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xccc2_d.getLength()+1
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
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcccld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imag011
               WHEN "s_detail2"
                  NEXT FIELD xccc004
 
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
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
 
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq530_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE  l_xcat005        LIKE xcat_t.xcat005    #wujie 150605
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #fengmy 150114----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xccc_m.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF 
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccc007,xccc007_2',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xccc007,xccc007_2',FALSE)                
   END IF   
   #fengmy 150114----end 
#wujie 150605 --begin
   CALL cl_set_comp_visible('inadsite,inadsite_2,inad010,inad010_2,inadsite_desc,inadsite_2_desc,inad010_desc,inad010_2_desc',TRUE)
   LET l_xcat005 = NULL
   SELECT xcat005 INTO l_xcat005 
     FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xccc_m.xccc003
   IF l_xcat005 <> '3' THEN   #不是批次成本的，隐藏门店和供应商
      CALL cl_set_comp_visible('inadsite,inadsite_2,inad010,inad010_2,inadsite_desc,inadsite_2_desc,inad010_desc,inad010_2_desc',FALSE)
   END IF
#wujie 150605 --end
   CALL axcq530_ref()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq530_b_fill(g_wc2) #第一階單身填充
      CALL axcq530_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq530_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001, 
       g_xccc_m.xccc001_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.xccc004_1,g_xccc_m.xccc005_1, 
       g_xccc_m.xccc003,g_xccc_m.xccc003_desc
 
   CALL axcq530_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   #fengmy150812---begin
         CALL cl_set_comp_visible('xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h',FALSE)  #fengmy150812
   IF g_yy1 = g_yy2 AND g_mm1 = g_mm2 THEN
      CALL cl_set_comp_visible('xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h',TRUE)  #fengmy150812
   END IF
   DISPLAY g_yy1 TO xccc004
   DISPLAY g_mm1 TO xccc005
   DISPLAY g_yy2 TO xccc004_1
   DISPLAY g_mm2 TO xccc005_1
   #fengmy150812---end 
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq530_ref_show()
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
   FOR l_ac = 1 TO g_xccc_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xccc2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq530.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq530_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xccc_t.xcccld 
   DEFINE l_oldno     LIKE xccc_t.xcccld 
   DEFINE l_newno02     LIKE xccc_t.xccc001 
   DEFINE l_oldno02     LIKE xccc_t.xccc001 
   DEFINE l_newno03     LIKE xccc_t.xccc003 
   DEFINE l_oldno03     LIKE xccc_t.xccc003 
   DEFINE l_newno04     LIKE xccc_t.xccc004 
   DEFINE l_oldno04     LIKE xccc_t.xccc004 
   DEFINE l_newno05     LIKE xccc_t.xccc005 
   DEFINE l_oldno05     LIKE xccc_t.xccc005 
 
   DEFINE l_master    RECORD LIKE xccc_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xccc_t.* #此變數樣板目前無使用
 
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
 
   IF g_xccc_m.xcccld IS NULL
      OR g_xccc_m.xccc001 IS NULL
      OR g_xccc_m.xccc003 IS NULL
      OR g_xccc_m.xccc004 IS NULL
      OR g_xccc_m.xccc005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   LET g_xccc_m.xcccld = ""
   LET g_xccc_m.xccc001 = ""
   LET g_xccc_m.xccc003 = ""
   LET g_xccc_m.xccc004 = ""
   LET g_xccc_m.xccc005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq530_set_entry('a')
   CALL axcq530_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xccc_m.xccc001_desc = ''
   DISPLAY BY NAME g_xccc_m.xccc001_desc
   LET g_xccc_m.xcccld_desc = ''
   DISPLAY BY NAME g_xccc_m.xcccld_desc
   LET g_xccc_m.xccc003_desc = ''
   DISPLAY BY NAME g_xccc_m.xccc003_desc
 
   
   CALL axcq530_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xccc_m.* TO NULL
      INITIALIZE g_xccc_d TO NULL
      INITIALIZE g_xccc2_d TO NULL
 
      CALL axcq530_show()
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
   CALL axcq530_set_act_visible()
   CALL axcq530_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq530_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq530_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq530_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq530_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xccc_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
 
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq530_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
 
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xccc_t
    WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
    AND xccc001 = g_xccc001_t
    AND xccc003 = g_xccc003_t
    AND xccc004 = g_xccc004_t
    AND xccc005 = g_xccc005_t
 
       INTO TEMP axcq530_detail
   
   #將key修正為調整後   
   UPDATE axcq530_detail 
      #更新key欄位
      SET xcccld = g_xccc_m.xcccld
          , xccc001 = g_xccc_m.xccc001
          , xccc003 = g_xccc_m.xccc003
          , xccc004 = g_xccc_m.xccc004
          , xccc005 = g_xccc_m.xccc005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xccc_t SELECT * FROM axcq530_detail
   
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
   DROP TABLE axcq530_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   DROP TABLE axcq530_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq530_delete()
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
   
   IF g_xccc_m.xcccld IS NULL
   OR g_xccc_m.xccc001 IS NULL
   OR g_xccc_m.xccc003 IS NULL
   OR g_xccc_m.xccc004 IS NULL
   OR g_xccc_m.xccc005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq530_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq530_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq530_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq530_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc001,g_xccc_m.xcccld, 
       g_xccc_m.xccc003,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq530_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   CALL axcq530_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq530_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xccc_t WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld
                                                               AND xccc001 = g_xccc_m.xccc001
                                                               AND xccc003 = g_xccc_m.xccc003
                                                               AND xccc004 = g_xccc_m.xccc004
                                                               AND xccc005 = g_xccc_m.xccc005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
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
      #   CLOSE axcq530_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xccc_d.clear() 
      CALL g_xccc2_d.clear()       
 
     
      CALL axcq530_ui_browser_refresh()  
      #CALL axcq530_ui_headershow()  
      #CALL axcq530_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq530_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq530_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq530_cl
 
   #功能已完成,通報訊息中心
   CALL axcq530_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq530.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq530_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xccc_d.clear()
   CALL g_xccc2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axcq530_b_fill_1(p_wc2)
   RETURN
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,xccc202,xccc280, 
       xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,xccc301,xccc302,xccc901, 
       xccc902,xccc903,xccc004,xccc005,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,xccc202, 
       xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,xccc214, 
       xccc215,xccc216,xccc217,xccc218,xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307,xccc308, 
       xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903,xccc903a,xccc903b,xccc903c, 
       xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,t2.xcbfl003 ,t3.imaal003 ,t4.imaal004 ,t7.imaal004 FROM xccc_t", 
          
               "",
               
                              " LEFT JOIN xcbfl_t t2 ON t2.xcbflent="||g_enterprise||" AND t2.xcbfl001=xccc002 AND t2.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=xccc006 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=xccc006 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t7 ON t7.imaalent="||g_enterprise||" AND t7.imaal001=xccc006 AND t7.imaal002='"||g_dlang||"' ",
 
               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,
       (xccc201+xccc203+xccc205+xccc207+xccc209+xccc211+xccc213+xccc215+xccc217),
       (xccc202+xccc204+xccc206+xccc208+xccc210+xccc212+xccc214+xccc216+xccc218),xccc280, 
       (xccc301+xccc303+xccc305+xccc307+xccc309+xccc311+xccc313),
       (xccc302+xccc304+xccc306+xccc308+xccc310+xccc312+xccc314),xccc901,xccc902,xccc903,
       xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201, 
       xccc202,xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213, 
       xccc214,xccc215,xccc216,xccc217,xccc218,xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307, 
       xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903,t2.xcbfl003 , 
       t3.imaal003 ,t4.imaal004 ,t5.imaal004 FROM xccc_t",   
               "",
               
                              " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xccc002 AND t2.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xccc006 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xccc006 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent='"||g_enterprise||"' AND t5.imaal001=xccc006 AND t5.imaal002='"||g_dlang||"' ",
 
               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
   END IF
   
  
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq530_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xccc_t.xccc002,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq530_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq530_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
          g_xccc_m.xccc005 INTO g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007, 
          g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc101,g_xccc_d[l_ac].xccc102,g_xccc_d[l_ac].xccc201, 
          g_xccc_d[l_ac].xccc202,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc280a,g_xccc_d[l_ac].xccc280b, 
          g_xccc_d[l_ac].xccc280c,g_xccc_d[l_ac].xccc280d,g_xccc_d[l_ac].xccc280e,g_xccc_d[l_ac].xccc280f, 
          g_xccc_d[l_ac].xccc280g,g_xccc_d[l_ac].xccc280h,g_xccc_d[l_ac].xccc301,g_xccc_d[l_ac].xccc302, 
          g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc903,g_xccc2_d[l_ac].xccc004, 
          g_xccc2_d[l_ac].xccc005,g_xccc2_d[l_ac].xccc002,g_xccc2_d[l_ac].xccc006,g_xccc2_d[l_ac].xccc007, 
          g_xccc2_d[l_ac].xccc008,g_xccc2_d[l_ac].xccc101,g_xccc2_d[l_ac].xccc102,g_xccc2_d[l_ac].xccc201, 
          g_xccc2_d[l_ac].xccc202,g_xccc2_d[l_ac].xccc203,g_xccc2_d[l_ac].xccc204,g_xccc2_d[l_ac].xccc205, 
          g_xccc2_d[l_ac].xccc206,g_xccc2_d[l_ac].xccc207,g_xccc2_d[l_ac].xccc208,g_xccc2_d[l_ac].xccc209, 
          g_xccc2_d[l_ac].xccc210,g_xccc2_d[l_ac].xccc211,g_xccc2_d[l_ac].xccc212,g_xccc2_d[l_ac].xccc213, 
          g_xccc2_d[l_ac].xccc214,g_xccc2_d[l_ac].xccc215,g_xccc2_d[l_ac].xccc216,g_xccc2_d[l_ac].xccc217, 
          g_xccc2_d[l_ac].xccc218,g_xccc2_d[l_ac].xccc301,g_xccc2_d[l_ac].xccc302,g_xccc2_d[l_ac].xccc303, 
          g_xccc2_d[l_ac].xccc304,g_xccc2_d[l_ac].xccc305,g_xccc2_d[l_ac].xccc306,g_xccc2_d[l_ac].xccc307, 
          g_xccc2_d[l_ac].xccc308,g_xccc2_d[l_ac].xccc309,g_xccc2_d[l_ac].xccc310,g_xccc2_d[l_ac].xccc311, 
          g_xccc2_d[l_ac].xccc312,g_xccc2_d[l_ac].xccc313,g_xccc2_d[l_ac].xccc314,g_xccc2_d[l_ac].xccc901, 
          g_xccc2_d[l_ac].xccc902,g_xccc2_d[l_ac].xccc903,g_xccc2_d[l_ac].xccc903a,g_xccc2_d[l_ac].xccc903b, 
          g_xccc2_d[l_ac].xccc903c,g_xccc2_d[l_ac].xccc903d,g_xccc2_d[l_ac].xccc903e,g_xccc2_d[l_ac].xccc903f, 
          g_xccc2_d[l_ac].xccc903g,g_xccc2_d[l_ac].xccc903h,g_xccc_d[l_ac].xccc002_desc,g_xccc_d[l_ac].xccc006_desc, 
          g_xccc_d[l_ac].xccc006_desc_desc,g_xccc2_d[l_ac].xccc006_2_desc_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #成本分群
         SELECT imag011 INTO g_xccc_d[l_ac].imag011 FROM imag_t 
          WHERE imagent = g_enterprise AND imagsite = g_xccc_m.xccccomp
            AND imag001 = g_xccc_d[l_ac].xccc006
         
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
         LET g_ref_fields[1] = g_xccc_d[l_ac].imag011                                                                                                                        
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccc_d[l_ac].imag011_desc = '', g_rtn_fields[1] , ''  
         DISPLAY BY NAME g_xccc_d[l_ac].imag011_desc   
         
         #成本單位取axci120
         SELECT xcbb005 INTO g_xccc_d[l_ac].xcbb005 FROM xcbb_t
          WHERE xcbbent  = g_enterprise
            AND xcbbcomp = g_xccc_m.xccccomp
            AND xcbb001  = g_xccc_m.xccc004
            AND xcbb002  = g_xccc_m.xccc005
            AND xcbb003  = g_xccc_d[l_ac].xccc006

         #期初單位成本
         LET g_xccc_d[l_ac].l_unit = g_xccc_d[l_ac].xccc102/g_xccc_d[l_ac].xccc101
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
 
            CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
      CALL g_xccc2_d.deleteElement(g_xccc2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xccc_d.getLength()
      LET g_xccc_d_mask_o[l_ac].* =  g_xccc_d[l_ac].*
      CALL axcq530_xccc_t_mask()
      LET g_xccc_d_mask_n[l_ac].* =  g_xccc_d[l_ac].*
   END FOR
   
   LET g_xccc2_d_mask_o.* =  g_xccc2_d.*
   FOR l_ac = 1 TO g_xccc2_d.getLength()
      LET g_xccc2_d_mask_o[l_ac].* =  g_xccc2_d[l_ac].*
      CALL axcq530_xccc_t_mask()
      LET g_xccc2_d_mask_n[l_ac].* =  g_xccc2_d[l_ac].*
   END FOR
 
 
   FREE axcq530_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq530_idx_chk()
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
      IF g_detail_idx > g_xccc_d.getLength() THEN
         LET g_detail_idx = g_xccc_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xccc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccc_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xccc2_d.getLength() THEN
         LET g_detail_idx = g_xccc2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xccc2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccc2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq530_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xccc_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq530_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xccc_t
    WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld AND
                              xccc001 = g_xccc_m.xccc001 AND
                              xccc003 = g_xccc_m.xccc003 AND
                              xccc004 = g_xccc_m.xccc004 AND
                              xccc005 = g_xccc_m.xccc005 AND
 
          xccc002 = g_xccc_d_t.xccc002
      AND xccc006 = g_xccc_d_t.xccc006
      AND xccc007 = g_xccc_d_t.xccc007
      AND xccc008 = g_xccc_d_t.xccc008
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:",SQLERRMESSAGE 
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
 
{<section id="axcq530.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq530_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq530.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq530_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq530.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq530_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq530.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq530_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xccc_d[l_ac].xccc002 = g_xccc_d_t.xccc002 
      AND g_xccc_d[l_ac].xccc006 = g_xccc_d_t.xccc006 
      AND g_xccc_d[l_ac].xccc007 = g_xccc_d_t.xccc007 
      AND g_xccc_d[l_ac].xccc008 = g_xccc_d_t.xccc008 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq530_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq530.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq530_lock_b(ps_table,ps_page)
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
   #CALL axcq530_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq530.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq530_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq530.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq530_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcccld,xccc001,xccc003,xccc004,xccc005",TRUE)
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
 
{<section id="axcq530.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq530_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcccld,xccc001,xccc003,xccc004,xccc005",FALSE)
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
 
{<section id="axcq530.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq530_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq530_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq530_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq530.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq530_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq530.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq530_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq530.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq530_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq530.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq530_default_search()
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
      LET ls_wc = ls_wc, " xcccld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccc001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccc003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccc004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xccc005 = '", g_argv[05], "' AND "
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
 
{<section id="axcq530.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq530_fill_chk(ps_idx)
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
 
{<section id="axcq530.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq530_modify_detail_chk(ps_record)
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
         LET ls_return = "imag011"
      WHEN "s_detail2"
         LET ls_return = "xccc004"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq530.mask_functions" >}
&include "erp/axc/axcq530_mask.4gl"
 
{</section>}
 
{<section id="axcq530.state_change" >}
    
 
{</section>}
 
{<section id="axcq530.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq530_set_pk_array()
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
   LET g_pk_array[1].values = g_xccc_m.xcccld
   LET g_pk_array[1].column = 'xcccld'
   LET g_pk_array[2].values = g_xccc_m.xccc001
   LET g_pk_array[2].column = 'xccc001'
   LET g_pk_array[3].values = g_xccc_m.xccc003
   LET g_pk_array[3].column = 'xccc003'
   LET g_pk_array[4].values = g_xccc_m.xccc004
   LET g_pk_array[4].column = 'xccc004'
   LET g_pk_array[5].values = g_xccc_m.xccc005
   LET g_pk_array[5].column = 'xccc005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq530.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq530_msgcentre_notify(lc_state)
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
   CALL axcq530_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xccc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq530.other_function" readonly="Y" >}
#單身g_xccc_d填充
PRIVATE FUNCTION axcq530_b_fill_1(p_wc2)
DEFINE p_wc2      STRING
DEFINE l_xccc1011_sum   LIKE xccc_t.xccc101 #dorislai-20151104-add
DEFINE l_unit1_sum      LIKE type_t.num20_6 #dorislai-20151104-add
DEFINE l_xccc1021_sum   LIKE xccc_t.xccc102 
DEFINE l_xccc2011_sum   LIKE xccc_t.xccc201 #dorislai-20151104-add
DEFINE l_xccc2021_sum   LIKE xccc_t.xccc202 
#dorislai-20151104-add---(S)
DEFINE l_xccc2801_sum    LIKE xccc_t.xccc280
DEFINE l_xccc280a1_sum   LIKE xccc_t.xccc280a
DEFINE l_xccc280b1_sum   LIKE xccc_t.xccc280b
DEFINE l_xccc280c1_sum   LIKE xccc_t.xccc280c
DEFINE l_xccc280d1_sum   LIKE xccc_t.xccc280d
DEFINE l_xccc280e1_sum   LIKE xccc_t.xccc280e
DEFINE l_xccc280f1_sum   LIKE xccc_t.xccc280f
DEFINE l_xccc280g1_sum   LIKE xccc_t.xccc280g
DEFINE l_xccc280h1_sum   LIKE xccc_t.xccc280h
DEFINE l_xccc3011_sum    LIKE xccc_t.xccc301
#dorislai-20151104-add---(E) 
DEFINE l_xccc3021_sum   LIKE xccc_t.xccc302 
DEFINE l_xccc9011_sum   LIKE xccc_t.xccc901 #dorislai-20151104-add
DEFINE l_xccc9021_sum   LIKE xccc_t.xccc902 
DEFINE l_xccc9031_sum   LIKE xccc_t.xccc903

DEFINE l_xccc1022_sum   LIKE xccc_t.xccc102
DEFINE l_xccc2022_sum   LIKE xccc_t.xccc202
DEFINE l_xccc2042_sum   LIKE xccc_t.xccc204
DEFINE l_xccc2062_sum   LIKE xccc_t.xccc206
DEFINE l_xccc2082_sum   LIKE xccc_t.xccc208
DEFINE l_xccc2102_sum   LIKE xccc_t.xccc210
DEFINE l_xccc2122_sum   LIKE xccc_t.xccc212
DEFINE l_xccc2142_sum   LIKE xccc_t.xccc214
DEFINE l_xccc2162_sum   LIKE xccc_t.xccc216
DEFINE l_xccc2182_sum   LIKE xccc_t.xccc218
DEFINE l_xccc3022_sum   LIKE xccc_t.xccc302
DEFINE l_xccc3042_sum   LIKE xccc_t.xccc304
DEFINE l_xccc3062_sum   LIKE xccc_t.xccc306
DEFINE l_xccc3082_sum   LIKE xccc_t.xccc308
DEFINE l_xccc3102_sum   LIKE xccc_t.xccc310
DEFINE l_xccc3122_sum   LIKE xccc_t.xccc312
DEFINE l_xccc3142_sum   LIKE xccc_t.xccc314
DEFINE l_xccc9022_sum   LIKE xccc_t.xccc902 
DEFINE l_xccc9032_sum   LIKE xccc_t.xccc903
#add--2015/10/06 By shiun--(S)
DEFINE l_xccc903a2_sum   LIKE xccc_t.xccc903a
DEFINE l_xccc903b2_sum   LIKE xccc_t.xccc903b
DEFINE l_xccc903c2_sum   LIKE xccc_t.xccc903c
DEFINE l_xccc903d2_sum   LIKE xccc_t.xccc903d
DEFINE l_xccc903e2_sum   LIKE xccc_t.xccc903e
DEFINE l_xccc903f2_sum   LIKE xccc_t.xccc903f
DEFINE l_xccc903g2_sum   LIKE xccc_t.xccc903g
DEFINE l_xccc903h2_sum   LIKE xccc_t.xccc903h
#add--2015/10/06 By shiun--(E)
DEFINE l_xccc1011_total   LIKE xccc_t.xccc101 #dorislai-20151104-add
DEFINE l_unit1_total      LIKE type_t.num20_6 #dorislai-20151104-add
DEFINE l_xccc1021_total   LIKE xccc_t.xccc102 
DEFINE l_xccc2011_total   LIKE xccc_t.xccc201 #dorislai-20151104-add
DEFINE l_xccc2021_total   LIKE xccc_t.xccc202 
#dorislai-20151104-add---(S)
DEFINE l_xccc2801_total    LIKE xccc_t.xccc280
DEFINE l_xccc280a1_total   LIKE xccc_t.xccc280a
DEFINE l_xccc280b1_total   LIKE xccc_t.xccc280b
DEFINE l_xccc280c1_total   LIKE xccc_t.xccc280c
DEFINE l_xccc280d1_total   LIKE xccc_t.xccc280d
DEFINE l_xccc280e1_total   LIKE xccc_t.xccc280e
DEFINE l_xccc280f1_total   LIKE xccc_t.xccc280f
DEFINE l_xccc280g1_total   LIKE xccc_t.xccc280g
DEFINE l_xccc280h1_total   LIKE xccc_t.xccc280h
DEFINE l_xccc3011_total    LIKE xccc_t.xccc301
#dorislai-20151104-add---(E)
DEFINE l_xccc3021_total   LIKE xccc_t.xccc302 
DEFINE l_xccc9011_total   LIKE xccc_t.xccc901 #dorislai-20151104-add
DEFINE l_xccc9021_total   LIKE xccc_t.xccc902 
DEFINE l_xccc9031_total   LIKE xccc_t.xccc903 
DEFINE l_xccc1022_total   LIKE xccc_t.xccc102
DEFINE l_xccc2022_total   LIKE xccc_t.xccc202
DEFINE l_xccc2042_total   LIKE xccc_t.xccc204
DEFINE l_xccc2062_total   LIKE xccc_t.xccc206
DEFINE l_xccc2082_total   LIKE xccc_t.xccc208
DEFINE l_xccc2102_total   LIKE xccc_t.xccc210
DEFINE l_xccc2122_total   LIKE xccc_t.xccc212
DEFINE l_xccc2142_total   LIKE xccc_t.xccc214
DEFINE l_xccc2162_total   LIKE xccc_t.xccc216
DEFINE l_xccc2182_total   LIKE xccc_t.xccc218
DEFINE l_xccc3022_total   LIKE xccc_t.xccc302
DEFINE l_xccc3042_total   LIKE xccc_t.xccc304
DEFINE l_xccc3062_total   LIKE xccc_t.xccc306
DEFINE l_xccc3082_total   LIKE xccc_t.xccc308
DEFINE l_xccc3102_total   LIKE xccc_t.xccc310
DEFINE l_xccc3122_total   LIKE xccc_t.xccc312
DEFINE l_xccc3142_total   LIKE xccc_t.xccc314
DEFINE l_xccc9022_total   LIKE xccc_t.xccc902 
DEFINE l_xccc9032_total   LIKE xccc_t.xccc903 
#add--2015/10/06 By shiun--(S)
DEFINE l_xccc903a2_total  LIKE xccc_t.xccc903a
DEFINE l_xccc903b2_total  LIKE xccc_t.xccc903b
DEFINE l_xccc903c2_total  LIKE xccc_t.xccc903c
DEFINE l_xccc903d2_total  LIKE xccc_t.xccc903d
DEFINE l_xccc903e2_total  LIKE xccc_t.xccc903e
DEFINE l_xccc903f2_total  LIKE xccc_t.xccc903f
DEFINE l_xccc903g2_total  LIKE xccc_t.xccc903g
DEFINE l_xccc903h2_total  LIKE xccc_t.xccc903h
#add--2015/10/06 By shiun--(E)
#wujie 150604 --begin
DEFINE l_sql1,l_sql2,l_sql3       STRING
DEFINE l_xcat005        LIKE xcat_t.xcat005    #wujie 150605 
#wujie 150604 --end

   CALL axcq530_ins_temp_1() #fengmy150812 
   
   #CALL axcq530_b_fill_2(p_wc2)   #fengmy150812  此段对应的页签因未调整完整，征求wujiea的意见暂删除
   #add-point:b_fill段sql_after
   
   #160520-00003#5---s
   #LET g_sql = "SELECT  UNIQUE t1.imag011,",   
   LET g_sql = "SELECT UNIQUE imag011, ",
               "              xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,",
               "              xccc201,xccc202,xccc280,",
               "              xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,",   #fengmy150519 add            
               "              xccc301,xccc302,xccc901,xccc902,xccc903,",
               "              imaal003,imaal004,",
               "              (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=imag011 AND oocql003='"||g_dlang||"') oocql004  ",
               "              ,(SELECT xcbb005  FROM xcbb_t WHERE xcbbent='",g_enterprise,"' AND xcbbcomp='",g_xccc_m.xccccomp,"' AND xcbb001=",g_yy2," AND xcbb002=",g_mm2," 
                              AND xcbb003=xccc006 AND xcbb004=xccc007) xcbb005 ",  #161024-00069 add by zhaoqya 16/10/25                
               " FROM ( ",
               "        SELECT UNIQUE (SELECT imag011 FROM imag_t WHERE imagent = '"||g_enterprise||"' AND imagsite = '"||g_xccc_m.xccccomp||"' AND imag001 = xccc006 ) imag011, ",
   #160520-00003#5--e
               "               xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,",
               "               (xccc201+xccc203+xccc205+xccc207+xccc209+xccc211+xccc213+xccc215+xccc217) xccc201 ,",
               "               (xccc202+xccc204+xccc206+xccc208+xccc210+xccc212+xccc214+xccc216+xccc218) xccc202 ,xccc280,",
               "               xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,",   #fengmy150519 add            
               "               (xccc301+xccc303+xccc305+xccc307+xccc309+xccc311+xccc313) xccc301 ,",
               "               (xccc302+xccc304+xccc306+xccc308+xccc310+xccc312+xccc314) xccc302 ,xccc901,xccc902,xccc903,",
               #mark--2015/10/07 By shiun--(S)
#              #"               t1.imag011,xccc002,xccc006,xccc007,xccc008,'','',xccc101,xccc102,xccc201,",   #fengmy150702 mark
#               "               xccc004,xccc005,t1.imag011,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,",         #fengmy150702 
#               "               xccc202,xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,", 
#               "               xccc214,xccc215,xccc216,xccc217,xccc218,xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307,", 
#               "               xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903,xccc903a,xccc903b,",
#               "               xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,t2.xcbfl003,", #modify--2015/10/06 By shiun
#              #"               t3.imaal003 ,t4.imaal004 ,t5.imaal004 FROM xccc_t ",   #fengmy150812 mark
              #mark--2015/10/07 By shiun--(E)
               #modify--2015/10/07 By shiun--(S)
#               "               t3.imaal003 ,t4.imaal004 ,t5.imaal004 FROM axcq530_tmp1 t0",   #fengmy150812 
               #160520-00003#5--s
               #"               t3.imaal003 ,t3.imaal004 ",  
               " (SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ) imaal003, " , 
               " (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ) imaal004 " ,
               #160520-00003#5--e
               "   FROM axcq530_tmp1 t0"
               #modify--2015/10/07 By shiun--(E)
               #160520-00003#5--s
               #" LEFT OUTER JOIN imag_t t1 ON t1.imagent = '"||g_enterprise||"' AND t1.imagsite = '"||g_xccc_m.xccccomp||"' AND t1.imag001 = t0.xccc006 ",               
               #" LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=t0.xccc002 AND t2.xcbfl002='"||g_dlang||"' ",
               #" LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=t0.xccc006 AND t3.imaal002='"||g_dlang||"' "#,
               #160520-00003#5--e
               #mark--2015/10/07 By shiun--(S)
#               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=t0.xccc006 AND t4.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t5 ON t5.imaalent='"||g_enterprise||"' AND t5.imaal001=t0.xccc006 AND t5.imaal002='"||g_dlang||"' "     
               #mark--2015/10/07 By shiun--(E)
              #" WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=?"  #fengmy150812 mark
               
  
#wujie 150604 --begin
   LET l_sql1 = NULL
   LET l_xcat005 = NULL
   SELECT xcat005 INTO l_xcat005    #l_xcat005 =3表示是批次成本，单身填充时要去找出门店和供应商
     FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xccc_m.xccc003
   IF l_xcat005 = '3' THEN   
      LET l_sql1 = " SELECT MIN(inadsite),MIN(inad010) FROM inad_t ",
                   "  WHERE inadent = ? ",
                   "    AND inad001 = ? ",
                   "    AND inad002 = ? ",
                   "    AND inad003 = ? ",
                   "    AND ",g_wc3,
                   "  GROUP BY inadent,inad001,inad002,inad003"
                   
      PREPARE axcq530_inad FROM l_sql1
                   
   END IF
#wujie 150604 --end

#170309-00049#1 mark start -----
#   IF NOT cl_null(g_wc2_table1) THEN
##     LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")   #fengmy151125 mark
#      LET g_sql = g_sql CLIPPED," WHERE ",g_wc2_table1 CLIPPED   #fengmy151125     
#  #151130-00003#1--add--(s) 
#      IF NOT cl_null(g_wc_filter) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc_filter CLIPPED
#      END IF    
#   ELSE
#      IF NOT cl_null(g_wc_filter) THEN
#         LET g_sql = g_sql CLIPPED," WHERE ",g_wc_filter CLIPPED
#      END IF  
#  #151130-00003#1--add--(e) 
#   
#   END IF  
#170309-00049#1 mark end   -----
   
   LET g_sql = g_sql , " ) "  #160520-00003#5

   #170309-00049#1 add start -----
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," WHERE ",g_wc2_table1 CLIPPED
      IF NOT cl_null(g_wc_filter) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc_filter CLIPPED
      END IF
   ELSE
      IF NOT cl_null(g_wc_filter) THEN
         LET g_sql = g_sql CLIPPED," WHERE ",g_wc_filter CLIPPED
      END IF
   END IF
   #170309-00049#1 add end   -----
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq530_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         #LET g_sql = g_sql, " ORDER BY t1.imag011,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"  #160520-00003#5
         LET g_sql = g_sql, " ORDER BY imag011,xccc006,xccc007,xccc008"  #160520-00003#5
         #add-point:b_fill段fill_before
         LET g_sql = s_chr_replace(g_sql,"xccc_t","t0",0)
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         LET g_sql_tmp = g_sql    #wujie 150611
         PREPARE axcq530_pb1 FROM g_sql
         DECLARE b_fill_cs1 CURSOR FOR axcq530_pb1
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      
      LET l_xccc1011_sum = 0  #dorislai-20151104-add
      LET l_unit1_sum = 0     #dorislai-20151104-add
      LET l_xccc1021_sum = 0  
      LET l_xccc2011_sum = 0  #dorislai-20151104-add
      LET l_xccc2021_sum = 0  
      #dorislai-20151104-add----(S)
      LET l_xccc2801_sum = 0
      LET l_xccc280a1_sum = 0
      LET l_xccc280b1_sum = 0
      LET l_xccc280c1_sum = 0
      LET l_xccc280d1_sum = 0
      LET l_xccc280e1_sum = 0
      LET l_xccc280f1_sum = 0
      LET l_xccc280g1_sum = 0
      LET l_xccc280h1_sum = 0
      LET l_xccc3011_sum = 0 
      #dorislai-20151104-add----(E)
      LET l_xccc3021_sum = 0  
      LET l_xccc9011_sum = 0  #dorislai-20151104-add
      LET l_xccc9021_sum = 0  
      LET l_xccc9031_sum = 0  
      #mark--2015/10/07 By shiun--(S)
#      LET l_xccc1022_sum = 0  
#      LET l_xccc2022_sum = 0  
#      LET l_xccc2042_sum = 0  
#      LET l_xccc2062_sum = 0  
#      LET l_xccc2082_sum = 0  
#      LET l_xccc2102_sum = 0  
#      LET l_xccc2122_sum = 0  
#      LET l_xccc2142_sum = 0  
#      LET l_xccc2162_sum = 0  
#      LET l_xccc2182_sum = 0  
#      LET l_xccc3022_sum = 0  
#      LET l_xccc3042_sum = 0  
#      LET l_xccc3062_sum = 0  
#      LET l_xccc3082_sum = 0  
#      LET l_xccc3102_sum = 0  
#      LET l_xccc3122_sum = 0  
#      LET l_xccc3142_sum = 0  
#      LET l_xccc9022_sum = 0  
#      LET l_xccc9032_sum = 0  
#      #add--2015/10/06 By shiun--(S)
#      LET l_xccc903a2_sum = 0
#      LET l_xccc903b2_sum = 0
#      LET l_xccc903c2_sum = 0
#      LET l_xccc903d2_sum = 0
#      LET l_xccc903e2_sum = 0
#      LET l_xccc903f2_sum = 0
#      LET l_xccc903g2_sum = 0
#      LET l_xccc903h2_sum = 0
#      #add--2015/10/06 By shiun--(E)
      #mark--2015/10/07 By shiun--(E)
      LET l_xccc1011_total = 0 #dorislai-20151104-add
      LET l_unit1_total = 0    #dorislai-20151104-add
      LET l_xccc1021_total = 0
      LET l_xccc2011_total = 0 #dorislai-20151104-add
      LET l_xccc2021_total = 0
      #dorislai-20151104-add----(S)
      LET l_xccc2801_total = 0
      LET l_xccc280a1_total = 0
      LET l_xccc280b1_total = 0
      LET l_xccc280c1_total = 0
      LET l_xccc280d1_total = 0
      LET l_xccc280e1_total = 0
      LET l_xccc280f1_total = 0
      LET l_xccc280g1_total = 0
      LET l_xccc280h1_total = 0
      LET l_xccc3011_total = 0 
      #dorislai-20151104-add----(E)
      LET l_xccc3021_total = 0
      LET l_xccc9011_total = 0 #dorislai-20151104-add
      LET l_xccc9021_total = 0
      LET l_xccc9031_total = 0
      #mark--2015/10/07 By shiun--(S)
#      LET l_xccc1022_total = 0
#      LET l_xccc2022_total = 0
#      LET l_xccc2042_total = 0
#      LET l_xccc2062_total = 0
#      LET l_xccc2082_total = 0
#      LET l_xccc2102_total = 0
#      LET l_xccc2122_total = 0
#      LET l_xccc2142_total = 0
#      LET l_xccc2162_total = 0
#      LET l_xccc2182_total = 0
#      LET l_xccc3022_total = 0
#      LET l_xccc3042_total = 0
#      LET l_xccc3062_total = 0
#      LET l_xccc3082_total = 0
#      LET l_xccc3102_total = 0
#      LET l_xccc3122_total = 0
#      LET l_xccc3142_total = 0
#      LET l_xccc9022_total = 0
#      LET l_xccc9032_total = 0
#      #add--2015/10/06 By shiun--(S)
#      LET l_xccc903a2_total = 0
#      LET l_xccc903b2_total = 0
#      LET l_xccc903c2_total = 0
#      LET l_xccc903d2_total = 0
#      LET l_xccc903e2_total = 0
#      LET l_xccc903f2_total = 0
#      LET l_xccc903g2_total = 0
#      LET l_xccc903h2_total = 0
#      #add--2015/10/06 By shiun--(E)
      #mark--2015/10/07 By shiun--(E)
     #OPEN b_fill_cs1 USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005  #fengmy150812 mark
      OPEN b_fill_cs1  #fengmy150812 
     
      FOREACH b_fill_cs1 INTO g_xccc_d[l_ac].imag011,g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008,
          g_xccc_d[l_ac].xccc101,g_xccc_d[l_ac].xccc102,g_xccc_d[l_ac].xccc201,g_xccc_d[l_ac].xccc202,g_xccc_d[l_ac].xccc280,
          g_xccc_d[l_ac].xccc280a,g_xccc_d[l_ac].xccc280b,g_xccc_d[l_ac].xccc280c,g_xccc_d[l_ac].xccc280d,  #fengmy150519 add
          g_xccc_d[l_ac].xccc280e,g_xccc_d[l_ac].xccc280f,g_xccc_d[l_ac].xccc280g,g_xccc_d[l_ac].xccc280h,  #fengmy150519 add
          g_xccc_d[l_ac].xccc301,g_xccc_d[l_ac].xccc302,g_xccc_d[l_ac].xccc901, 
          g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc903,
          #mark--2015/10/07 By shiun--(S)
#          g_xccc2_d[l_ac].xccc004,g_xccc2_d[l_ac].xccc005,#modify--2015/10/06 By shiun add xccc004-5
#          g_xccc2_d[l_ac].imag011,g_xccc2_d[l_ac].xccc002,g_xccc2_d[l_ac].xccc006, 
#          g_xccc2_d[l_ac].xccc007,g_xccc2_d[l_ac].xccc008,g_xccc2_d[l_ac].xccc101,g_xccc2_d[l_ac].xccc102,       
#          g_xccc2_d[l_ac].xccc201,g_xccc2_d[l_ac].xccc202,g_xccc2_d[l_ac].xccc203,g_xccc2_d[l_ac].xccc204, 
#          g_xccc2_d[l_ac].xccc205,g_xccc2_d[l_ac].xccc206,g_xccc2_d[l_ac].xccc207,g_xccc2_d[l_ac].xccc208, 
#          g_xccc2_d[l_ac].xccc209,g_xccc2_d[l_ac].xccc210,g_xccc2_d[l_ac].xccc211,g_xccc2_d[l_ac].xccc212, 
#          g_xccc2_d[l_ac].xccc213,g_xccc2_d[l_ac].xccc214,g_xccc2_d[l_ac].xccc215,g_xccc2_d[l_ac].xccc216, 
#          g_xccc2_d[l_ac].xccc217,g_xccc2_d[l_ac].xccc218,g_xccc2_d[l_ac].xccc301,g_xccc2_d[l_ac].xccc302, 
#          g_xccc2_d[l_ac].xccc303,g_xccc2_d[l_ac].xccc304,g_xccc2_d[l_ac].xccc305,g_xccc2_d[l_ac].xccc306, 
#          g_xccc2_d[l_ac].xccc307,g_xccc2_d[l_ac].xccc308,g_xccc2_d[l_ac].xccc309,g_xccc2_d[l_ac].xccc310, 
#          g_xccc2_d[l_ac].xccc311,g_xccc2_d[l_ac].xccc312,g_xccc2_d[l_ac].xccc313,g_xccc2_d[l_ac].xccc314, 
#          g_xccc2_d[l_ac].xccc901,g_xccc2_d[l_ac].xccc902,g_xccc2_d[l_ac].xccc903,
#          #add--2015/10/06 By shiun--(S)
#          g_xccc2_d[l_ac].xccc903a,g_xccc2_d[l_ac].xccc903b,g_xccc2_d[l_ac].xccc903c,g_xccc2_d[l_ac].xccc903d,
#          g_xccc2_d[l_ac].xccc903e,g_xccc2_d[l_ac].xccc903f,g_xccc2_d[l_ac].xccc903g,g_xccc2_d[l_ac].xccc903h,
          #add--2015/10/06 By shiun--(E)
          #mark--2015/10/07 By shiun--(E)
          #modify--2015/10/29 By shiun--(S)
#          g_xccc_d[l_ac].xccc002_desc,g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_desc#,g_xccc2_d[l_ac].xccc006_2_desc_desc 
          g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_desc,#,g_xccc2_d[l_ac].xccc006_2_desc_desc 
          g_xccc_d[l_ac].imag011_desc #160520-00003#5
          #modify--2015/10/29 By shiun--(E)
          ,g_xccc_d[l_ac].xcbb005  #161024-00069 add by zhaoqya 16/10/25
          
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
#         LET g_xccc2_d[l_ac].xccc006_2_desc = g_xccc_d[l_ac].xccc006_desc #mark--2015/10/07 By shiun
         #成本分群
         #160520-00003#5----s         
         #INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
         #LET g_ref_fields[1] = g_xccc_d[l_ac].imag011                                                                                                                        
         #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         #LET g_xccc_d[l_ac].imag011_desc = '', g_rtn_fields[1] , ''  
         #DISPLAY BY NAME g_xccc_d[l_ac].imag011_desc  
         #160520-00003#5----e         
         #mark--2015/10/07 By shiun--(S)
#         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
#         LET g_ref_fields[1] = g_xccc2_d[l_ac].imag011                                                                                                                        
#         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_xccc2_d[l_ac].imag011_2_desc = '', g_rtn_fields[1] , ''  
#         DISPLAY BY NAME g_xccc2_d[l_ac].imag011_2_desc   
         #mark--2015/10/07 By shiun--(E)
         
         #160520-00003#5----s        
         #成本單位取axci120
         #SELECT xcbb005 INTO g_xccc_d[l_ac].xcbb005 FROM xcbb_t
         # WHERE xcbbent  = g_enterprise
         #   AND xcbbcomp = g_xccc_m.xccccomp
         #   AND xcbb001  = g_xccc_m.xccc004
         #   AND xcbb002  = g_xccc_m.xccc005
         #   AND xcbb003  = g_xccc_d[l_ac].xccc006
         #160520-00003#5----e
         
         #mark--2015/10/07 By shiun--(S)
#         SELECT xcbb005 INTO g_xccc2_d[l_ac].xcbb005 FROM xcbb_t
#          WHERE xcbbent  = g_enterprise
#            AND xcbbcomp = g_xccc_m.xccccomp
#            AND xcbb001  = g_xccc_m.xccc004
#            AND xcbb002  = g_xccc_m.xccc005
#            AND xcbb003  = g_xccc2_d[l_ac].xccc006
         #mark--2015/10/07 By shiun--(E)
         #期初單位成本
         LET g_xccc_d[l_ac].l_unit = g_xccc_d[l_ac].xccc102/g_xccc_d[l_ac].xccc101
#         LET g_xccc2_d[l_ac].l_unit_2 = g_xccc2_d[l_ac].xccc102/g_xccc2_d[l_ac].xccc101   #mark--2015/10/07 By shiun
         IF cl_null(g_xccc_d[l_ac].l_unit) THEN LET g_xccc_d[l_ac].l_unit = 0 END IF
#         IF cl_null(g_xccc2_d[l_ac].l_unit_2) THEN LET g_xccc2_d[l_ac].l_unit_2 = 0 END IF   #mark--2015/10/07 By shiun
         #end add-point
      
         #帶出公用欄位reference值
#wujie 150604 --begin
         IF l_xcat005 = '3' THEN
            EXECUTE axcq530_inad INTO g_xccc_d[l_ac].inadsite,g_xccc_d[l_ac].inad010 USING g_enterprise,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008
            IF g_xccc_d[l_ac].inadsite IS NULL AND g_xccc_d[l_ac].inad010 IS NULL THEN
               CONTINUE FOREACH
            END IF
#            LET g_xccc2_d[l_ac].inadsite = g_xccc_d[l_ac].inadsite   #mark--2015/10/07 By shiun
#            LET g_xccc2_d[l_ac].inad010 = g_xccc_d[l_ac].inad010   #mark--2015/10/07 By shiun
            LET g_xccc_d[l_ac].inadsite_desc = s_desc_get_department_desc(g_xccc_d[l_ac].inadsite)
#            LET g_xccc2_d[l_ac].inadsite_2_desc = s_desc_get_department_desc(g_xccc2_d[l_ac].inadsite)   #mark--2015/10/07 By shiun
            LET g_xccc_d[l_ac].inad010_desc = s_desc_get_trading_partner_full_desc(g_xccc_d[l_ac].inad010)
#            LET g_xccc2_d[l_ac].inad010_2_desc = s_desc_get_trading_partner_full_desc(g_xccc2_d[l_ac].inad010)   #mark--2015/10/07 By shiun
         END IF
#wujie 150604 --end
         
         
 
        
         #add-point:單身資料抓取
         #mark--2015/10/26 By shiun--(S) #151013-00019#7 remark ------
         #合计
         LET l_xccc1011_total = l_xccc1011_total + g_xccc_d[l_ac].xccc101 #dorislai-20151104-add
         LET l_unit1_total = l_unit1_total + g_xccc_d[l_ac].l_unit        #dorislai-20151104-add
         LET l_xccc1021_total = l_xccc1021_total + g_xccc_d[l_ac].xccc102
         LET l_xccc2011_total = l_xccc2011_total + g_xccc_d[l_ac].xccc201 #dorislai-20151104-add
         LET l_xccc2021_total = l_xccc2021_total + g_xccc_d[l_ac].xccc202
         #dorislai-20151104-add----(S)
         LET l_xccc2801_total = l_xccc2801_total + g_xccc_d[l_ac].xccc280 
         LET l_xccc280a1_total = l_xccc280a1_total + g_xccc_d[l_ac].xccc280a 
         LET l_xccc280b1_total = l_xccc280b1_total + g_xccc_d[l_ac].xccc280b 
         LET l_xccc280c1_total = l_xccc280c1_total + g_xccc_d[l_ac].xccc280c 
         LET l_xccc280d1_total = l_xccc280d1_total + g_xccc_d[l_ac].xccc280d 
         LET l_xccc280e1_total = l_xccc280e1_total + g_xccc_d[l_ac].xccc280e 
         LET l_xccc280f1_total = l_xccc280f1_total + g_xccc_d[l_ac].xccc280f 
         LET l_xccc280g1_total = l_xccc280g1_total + g_xccc_d[l_ac].xccc280g 
         LET l_xccc280h1_total = l_xccc280h1_total + g_xccc_d[l_ac].xccc280h 
         LET l_xccc3011_total = l_xccc3011_total + g_xccc_d[l_ac].xccc301
         #dorislai-20151104-add----(E)
         LET l_xccc3021_total = l_xccc3021_total + g_xccc_d[l_ac].xccc302
         LET l_xccc9011_total = l_xccc9011_total + g_xccc_d[l_ac].xccc901 #dorislai-20151104-add
         LET l_xccc9021_total = l_xccc9021_total + g_xccc_d[l_ac].xccc902
         LET l_xccc9031_total = l_xccc9031_total + g_xccc_d[l_ac].xccc903
         #mark--2015/10/26 By shiun--(E) #151013-00019#7 remark end---
         #mark--2015/10/07 By shiun--(S)
#         LET l_xccc1022_total = l_xccc1022_total + g_xccc2_d[l_ac].xccc102
#         LET l_xccc2022_total = l_xccc2022_total + g_xccc2_d[l_ac].xccc202
#         LET l_xccc2042_total = l_xccc2042_total + g_xccc2_d[l_ac].xccc204
#         LET l_xccc2062_total = l_xccc2062_total + g_xccc2_d[l_ac].xccc206
#         LET l_xccc2082_total = l_xccc2082_total + g_xccc2_d[l_ac].xccc208
#         LET l_xccc2102_total = l_xccc2102_total + g_xccc2_d[l_ac].xccc210
#         LET l_xccc2122_total = l_xccc2122_total + g_xccc2_d[l_ac].xccc212
#         LET l_xccc2142_total = l_xccc2142_total + g_xccc2_d[l_ac].xccc214
#         LET l_xccc2162_total = l_xccc2162_total + g_xccc2_d[l_ac].xccc216
#         LET l_xccc2182_total = l_xccc2182_total + g_xccc2_d[l_ac].xccc218
#         LET l_xccc3022_total = l_xccc3022_total + g_xccc2_d[l_ac].xccc302
#         LET l_xccc3042_total = l_xccc3042_total + g_xccc2_d[l_ac].xccc304
#         LET l_xccc3062_total = l_xccc3062_total + g_xccc2_d[l_ac].xccc306
#         LET l_xccc3082_total = l_xccc3082_total + g_xccc2_d[l_ac].xccc308
#         LET l_xccc3102_total = l_xccc3102_total + g_xccc2_d[l_ac].xccc310
#         LET l_xccc3122_total = l_xccc3122_total + g_xccc2_d[l_ac].xccc312
#         LET l_xccc3142_total = l_xccc3142_total + g_xccc2_d[l_ac].xccc314
#         LET l_xccc9022_total = l_xccc9022_total + g_xccc2_d[l_ac].xccc902
#         LET l_xccc9032_total = l_xccc9032_total + g_xccc2_d[l_ac].xccc903
#         #add--2015/10/06 By shiun--(S)
#         LET l_xccc903a2_total = l_xccc903a2_total + g_xccc2_d[l_ac].xccc903a
#         LET l_xccc903b2_total = l_xccc903b2_total + g_xccc2_d[l_ac].xccc903b
#         LET l_xccc903c2_total = l_xccc903c2_total + g_xccc2_d[l_ac].xccc903c
#         LET l_xccc903d2_total = l_xccc903d2_total + g_xccc2_d[l_ac].xccc903d
#         LET l_xccc903e2_total = l_xccc903e2_total + g_xccc2_d[l_ac].xccc903e
#         LET l_xccc903f2_total = l_xccc903f2_total + g_xccc2_d[l_ac].xccc903f
#         LET l_xccc903g2_total = l_xccc903g2_total + g_xccc2_d[l_ac].xccc903g
#         LET l_xccc903h2_total = l_xccc903h2_total + g_xccc2_d[l_ac].xccc903h
#         #add--2015/10/06 By shiun--(E)
         #mark--2015/10/07 By shiun--(E)
         #mark--2015/10/26 By shiun--(S) #151013-00019#7 remark ------
         #按成本分群 小计
         LET l_xccc1011_sum = l_xccc1011_sum + g_xccc_d[l_ac].xccc101 #dorislai-20151104-add
         LET l_unit1_sum = l_unit1_sum + g_xccc_d[l_ac].l_unit        #dorislai-20151104-add
         LET l_xccc1021_sum = l_xccc1021_sum + g_xccc_d[l_ac].xccc102 
         LET l_xccc2011_sum = l_xccc2011_sum + g_xccc_d[l_ac].xccc201 #dorislai-20151104-add
         LET l_xccc2021_sum = l_xccc2021_sum + g_xccc_d[l_ac].xccc202
         #dorislai-20151104-add----(S)
         LET l_xccc2801_sum = l_xccc2801_sum + g_xccc_d[l_ac].xccc280
         LET l_xccc280a1_sum = l_xccc280a1_sum + g_xccc_d[l_ac].xccc280a
         LET l_xccc280b1_sum = l_xccc280b1_sum + g_xccc_d[l_ac].xccc280b
         LET l_xccc280c1_sum = l_xccc280c1_sum + g_xccc_d[l_ac].xccc280c
         LET l_xccc280d1_sum = l_xccc280d1_sum + g_xccc_d[l_ac].xccc280d
         LET l_xccc280e1_sum = l_xccc280e1_sum + g_xccc_d[l_ac].xccc280e
         LET l_xccc280f1_sum = l_xccc280f1_sum + g_xccc_d[l_ac].xccc280f
         LET l_xccc280g1_sum = l_xccc280g1_sum + g_xccc_d[l_ac].xccc280g
         LET l_xccc280h1_sum = l_xccc280h1_sum + g_xccc_d[l_ac].xccc280h
         LET l_xccc3011_sum = l_xccc3011_sum + g_xccc_d[l_ac].xccc301 
         #dorislai-20151104-add----(E)
         LET l_xccc3021_sum = l_xccc3021_sum + g_xccc_d[l_ac].xccc302
         LET l_xccc9011_sum = l_xccc9011_sum + g_xccc_d[l_ac].xccc901 #dorislai-20151104-add
         LET l_xccc9021_sum = l_xccc9021_sum + g_xccc_d[l_ac].xccc902
         LET l_xccc9031_sum = l_xccc9031_sum + g_xccc_d[l_ac].xccc903
         #mark--2015/10/26 By shiun--(E) #151013-00019#7 remark end---
         #mark--2015/10/07 By shiun--(S)
#         LET l_xccc1022_sum = l_xccc1022_sum + g_xccc2_d[l_ac].xccc102
#         LET l_xccc2022_sum = l_xccc2022_sum + g_xccc2_d[l_ac].xccc202
#         LET l_xccc2042_sum = l_xccc2042_sum + g_xccc2_d[l_ac].xccc204
#         LET l_xccc2062_sum = l_xccc2062_sum + g_xccc2_d[l_ac].xccc206
#         LET l_xccc2082_sum = l_xccc2082_sum + g_xccc2_d[l_ac].xccc208
#         LET l_xccc2102_sum = l_xccc2102_sum + g_xccc2_d[l_ac].xccc210
#         LET l_xccc2122_sum = l_xccc2122_sum + g_xccc2_d[l_ac].xccc212
#         LET l_xccc2142_sum = l_xccc2142_sum + g_xccc2_d[l_ac].xccc214
#         LET l_xccc2162_sum = l_xccc2162_sum + g_xccc2_d[l_ac].xccc216
#         LET l_xccc2182_sum = l_xccc2182_sum + g_xccc2_d[l_ac].xccc218
#         LET l_xccc3022_sum = l_xccc3022_sum + g_xccc2_d[l_ac].xccc302
#         LET l_xccc3042_sum = l_xccc3042_sum + g_xccc2_d[l_ac].xccc304
#         LET l_xccc3062_sum = l_xccc3062_sum + g_xccc2_d[l_ac].xccc306
#         LET l_xccc3082_sum = l_xccc3082_sum + g_xccc2_d[l_ac].xccc308
#         LET l_xccc3102_sum = l_xccc3102_sum + g_xccc2_d[l_ac].xccc310
#         LET l_xccc3122_sum = l_xccc3122_sum + g_xccc2_d[l_ac].xccc312
#         LET l_xccc3142_sum = l_xccc3142_sum + g_xccc2_d[l_ac].xccc314
#         LET l_xccc9022_sum = l_xccc9022_sum + g_xccc2_d[l_ac].xccc902
#         LET l_xccc9032_sum = l_xccc9032_sum + g_xccc2_d[l_ac].xccc903
#         #add--2015/10/06 By shiun--(S)
#         LET l_xccc903a2_sum = l_xccc903a2_sum + g_xccc2_d[l_ac].xccc903a
#         LET l_xccc903b2_sum = l_xccc903b2_sum + g_xccc2_d[l_ac].xccc903b
#         LET l_xccc903c2_sum = l_xccc903c2_sum + g_xccc2_d[l_ac].xccc903c
#         LET l_xccc903d2_sum = l_xccc903d2_sum + g_xccc2_d[l_ac].xccc903d
#         LET l_xccc903e2_sum = l_xccc903e2_sum + g_xccc2_d[l_ac].xccc903e
#         LET l_xccc903f2_sum = l_xccc903f2_sum + g_xccc2_d[l_ac].xccc903f
#         LET l_xccc903g2_sum = l_xccc903g2_sum + g_xccc2_d[l_ac].xccc903g
#         LET l_xccc903h2_sum = l_xccc903h2_sum + g_xccc2_d[l_ac].xccc903h
#         #add--2015/10/06 By shiun--(E)
         #mark--2015/10/07 By shiun--(E)
         #mark--2015/10/26 By shiun--(S) #151013-00019#7 remark ------
         IF l_ac > 1 THEN
            IF cl_null(g_xccc_d[l_ac].imag011) THEN LET g_xccc_d[l_ac].imag011 = ' ' END IF 
            IF g_xccc_d[l_ac].imag011 != g_xccc_d[l_ac - 1].imag011 THEN  #151013-00019#7 remark
           #IF g_xccc_d[l_ac].xccc006 != g_xccc_d[l_ac - 1].xccc006 OR g_xccc_d[l_ac].xccc007 != g_xccc_d[l_ac - 1].xccc007 THEN   #modify--2015/10/07 By shiun #151013-00019#7 mark
               LET g_xccc_d[l_ac + 1].* = g_xccc_d[l_ac].*
#               LET g_xccc2_d[l_ac + 1].* = g_xccc2_d[l_ac].*   #mark--2015/10/07 By shiun
               INITIALIZE  g_xccc_d[l_ac].* TO NULL
#               INITIALIZE  g_xccc2_d[l_ac].* TO NULL   #mark--2015/10/07 By shiun
               #modify--2015/10/07 By shiun--(S)
#               LET g_xccc_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)
#               LET g_xccc2_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)
               #LET g_xccc_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)    #151029-00010#3 20151029 mark by beckxie
               LET g_xccc_d[l_ac].imag011_desc = g_xccc_d[l_ac-1].imag011,cl_getmsg("axc-00205",g_lang)    #151029-00010#3 20151029 add by beckxie
#               LET g_xccc2_d[l_ac].xccc006 = cl_getmsg("axc-00205",g_lang)
               #modify--2015/10/07 By shiun--(E)
               LET g_xccc_d[l_ac].xccc101 = l_xccc1011_sum - g_xccc_d[l_ac + 1].xccc101 #dorislai-20151104-add
               LET g_xccc_d[l_ac].l_unit = l_unit1_sum - g_xccc_d[l_ac + 1].l_unit      #dorislai-20151104-add
               LET g_xccc_d[l_ac].xccc102 = l_xccc1021_sum - g_xccc_d[l_ac + 1].xccc102
               LET g_xccc_d[l_ac].xccc201 = l_xccc2011_sum - g_xccc_d[l_ac + 1].xccc201 #dorislai-20151104-add
               LET g_xccc_d[l_ac].xccc202 = l_xccc2021_sum - g_xccc_d[l_ac + 1].xccc202
               #dorislai-20151104-add----(S)
               LET g_xccc_d[l_ac].xccc280 = l_xccc2801_sum - g_xccc_d[l_ac + 1].xccc280
               LET g_xccc_d[l_ac].xccc280a = l_xccc280a1_sum - g_xccc_d[l_ac + 1].xccc280a
               LET g_xccc_d[l_ac].xccc280b = l_xccc280b1_sum - g_xccc_d[l_ac + 1].xccc280b
               LET g_xccc_d[l_ac].xccc280c = l_xccc280c1_sum - g_xccc_d[l_ac + 1].xccc280c
               LET g_xccc_d[l_ac].xccc280d = l_xccc280d1_sum - g_xccc_d[l_ac + 1].xccc280d
               LET g_xccc_d[l_ac].xccc280e = l_xccc280e1_sum - g_xccc_d[l_ac + 1].xccc280e
               LET g_xccc_d[l_ac].xccc280f = l_xccc280f1_sum - g_xccc_d[l_ac + 1].xccc280f
               LET g_xccc_d[l_ac].xccc280g = l_xccc280g1_sum - g_xccc_d[l_ac + 1].xccc280g
               LET g_xccc_d[l_ac].xccc280h = l_xccc280h1_sum - g_xccc_d[l_ac + 1].xccc280h
               #dorislai-20151104-add----(E)
               LET g_xccc_d[l_ac].xccc301 = l_xccc3011_sum - g_xccc_d[l_ac + 1].xccc301 #dorislai-20151104-add
               LET g_xccc_d[l_ac].xccc302 = l_xccc3021_sum - g_xccc_d[l_ac + 1].xccc302
               LET g_xccc_d[l_ac].xccc901 = l_xccc9011_sum - g_xccc_d[l_ac + 1].xccc901 #dorislai-20151104-add
               LET g_xccc_d[l_ac].xccc902 = l_xccc9021_sum - g_xccc_d[l_ac + 1].xccc902
               LET g_xccc_d[l_ac].xccc903 = l_xccc9031_sum - g_xccc_d[l_ac + 1].xccc903
               #mark--2015/10/07 By shiun--(S)
#               LET g_xccc2_d[l_ac].xccc102= l_xccc1022_sum - g_xccc2_d[l_ac+ 1].xccc102
#               LET g_xccc2_d[l_ac].xccc202= l_xccc2022_sum - g_xccc2_d[l_ac+ 1].xccc202
#               LET g_xccc2_d[l_ac].xccc204= l_xccc2042_sum - g_xccc2_d[l_ac+ 1].xccc204
#               LET g_xccc2_d[l_ac].xccc206= l_xccc2062_sum - g_xccc2_d[l_ac+ 1].xccc206
#               LET g_xccc2_d[l_ac].xccc208= l_xccc2082_sum - g_xccc2_d[l_ac+ 1].xccc208
#               LET g_xccc2_d[l_ac].xccc210= l_xccc2102_sum - g_xccc2_d[l_ac+ 1].xccc210
#               LET g_xccc2_d[l_ac].xccc212= l_xccc2122_sum - g_xccc2_d[l_ac+ 1].xccc212
#               LET g_xccc2_d[l_ac].xccc214= l_xccc2142_sum - g_xccc2_d[l_ac+ 1].xccc214
#               LET g_xccc2_d[l_ac].xccc216= l_xccc2162_sum - g_xccc2_d[l_ac+ 1].xccc216
#               LET g_xccc2_d[l_ac].xccc218= l_xccc2182_sum - g_xccc2_d[l_ac+ 1].xccc218
#               LET g_xccc2_d[l_ac].xccc302= l_xccc3022_sum - g_xccc2_d[l_ac+ 1].xccc302
#               LET g_xccc2_d[l_ac].xccc304= l_xccc3042_sum - g_xccc2_d[l_ac+ 1].xccc304
#               LET g_xccc2_d[l_ac].xccc306= l_xccc3062_sum - g_xccc2_d[l_ac+ 1].xccc306
#               LET g_xccc2_d[l_ac].xccc308= l_xccc3082_sum - g_xccc2_d[l_ac+ 1].xccc308
#               LET g_xccc2_d[l_ac].xccc310= l_xccc3102_sum - g_xccc2_d[l_ac+ 1].xccc310
#               LET g_xccc2_d[l_ac].xccc312= l_xccc3122_sum - g_xccc2_d[l_ac+ 1].xccc312
#               LET g_xccc2_d[l_ac].xccc314= l_xccc3142_sum - g_xccc2_d[l_ac+ 1].xccc314
#               LET g_xccc2_d[l_ac].xccc902= l_xccc9022_sum - g_xccc2_d[l_ac+ 1].xccc902
#               LET g_xccc2_d[l_ac].xccc903= l_xccc9032_sum - g_xccc2_d[l_ac+ 1].xccc903
#               #add--2015/10/06 By shiun--(S)
#               LET g_xccc2_d[l_ac].xccc903a= l_xccc903a2_sum - g_xccc2_d[l_ac+ 1].xccc903a
#               LET g_xccc2_d[l_ac].xccc903b= l_xccc903b2_sum - g_xccc2_d[l_ac+ 1].xccc903b
#               LET g_xccc2_d[l_ac].xccc903c= l_xccc903c2_sum - g_xccc2_d[l_ac+ 1].xccc903c
#               LET g_xccc2_d[l_ac].xccc903d= l_xccc903d2_sum - g_xccc2_d[l_ac+ 1].xccc903d
#               LET g_xccc2_d[l_ac].xccc903e= l_xccc903e2_sum - g_xccc2_d[l_ac+ 1].xccc903e
#               LET g_xccc2_d[l_ac].xccc903f= l_xccc903f2_sum - g_xccc2_d[l_ac+ 1].xccc903f
#               LET g_xccc2_d[l_ac].xccc903g= l_xccc903g2_sum - g_xccc2_d[l_ac+ 1].xccc903g
#               LET g_xccc2_d[l_ac].xccc903h= l_xccc903h2_sum - g_xccc2_d[l_ac+ 1].xccc903h
#               #add--2015/10/06 By shiun--(E)
               #mark--2015/10/07 By shiun--(E)
               LET l_ac = l_ac + 1
               LET l_xccc1011_sum = g_xccc_d[l_ac].xccc101 #dorislai-20151104-add
               LET l_unit1_sum = g_xccc_d[l_ac].l_unit     #dorislai-20151104-add
               LET l_xccc1021_sum = g_xccc_d[l_ac].xccc102 
               LET l_xccc2011_sum = g_xccc_d[l_ac].xccc201 #dorislai-20151104-add
               LET l_xccc2021_sum = g_xccc_d[l_ac].xccc202 
               #dorislai-20151104-add----(S)
               LET l_xccc2801_sum = g_xccc_d[l_ac].xccc280 
               LET l_xccc280a1_sum = g_xccc_d[l_ac].xccc280a 
               LET l_xccc280b1_sum = g_xccc_d[l_ac].xccc280b 
               LET l_xccc280c1_sum = g_xccc_d[l_ac].xccc280c 
               LET l_xccc280d1_sum = g_xccc_d[l_ac].xccc280d 
               LET l_xccc280e1_sum = g_xccc_d[l_ac].xccc280e 
               LET l_xccc280f1_sum = g_xccc_d[l_ac].xccc280f 
               LET l_xccc280g1_sum = g_xccc_d[l_ac].xccc280g 
               LET l_xccc280h1_sum = g_xccc_d[l_ac].xccc280h 
               LET l_xccc3011_sum = g_xccc_d[l_ac].xccc301
               #dorislai-20151104-add----(E)
               LET l_xccc3021_sum = g_xccc_d[l_ac].xccc302 
               LET l_xccc9011_sum = g_xccc_d[l_ac].xccc901 #dorislai-20151104-add
               LET l_xccc9021_sum = g_xccc_d[l_ac].xccc902 
               LET l_xccc9031_sum = g_xccc_d[l_ac].xccc903  
               #mark--2015/10/07 By shiun--(S)
#               LET l_xccc1022_sum = g_xccc2_d[l_ac].xccc102
#               LET l_xccc2022_sum = g_xccc2_d[l_ac].xccc202
#               LET l_xccc2042_sum = g_xccc2_d[l_ac].xccc204
#               LET l_xccc2062_sum = g_xccc2_d[l_ac].xccc206
#               LET l_xccc2082_sum = g_xccc2_d[l_ac].xccc208
#               LET l_xccc2102_sum = g_xccc2_d[l_ac].xccc210
#               LET l_xccc2122_sum = g_xccc2_d[l_ac].xccc212
#               LET l_xccc2142_sum = g_xccc2_d[l_ac].xccc214
#               LET l_xccc2162_sum = g_xccc2_d[l_ac].xccc216
#               LET l_xccc2182_sum = g_xccc2_d[l_ac].xccc218
#               LET l_xccc3022_sum = g_xccc2_d[l_ac].xccc302
#               LET l_xccc3042_sum = g_xccc2_d[l_ac].xccc304
#               LET l_xccc3062_sum = g_xccc2_d[l_ac].xccc306
#               LET l_xccc3082_sum = g_xccc2_d[l_ac].xccc308
#               LET l_xccc3102_sum = g_xccc2_d[l_ac].xccc310
#               LET l_xccc3122_sum = g_xccc2_d[l_ac].xccc312
#               LET l_xccc3142_sum = g_xccc2_d[l_ac].xccc314
#               LET l_xccc9022_sum = g_xccc2_d[l_ac].xccc902
#               LET l_xccc9032_sum = g_xccc2_d[l_ac].xccc903
#               #add--2015/10/06 By shiun--(S)
#               LET l_xccc903a2_sum = g_xccc2_d[l_ac].xccc903a
#               LET l_xccc903b2_sum = g_xccc2_d[l_ac].xccc903b
#               LET l_xccc903c2_sum = g_xccc2_d[l_ac].xccc903c
#               LET l_xccc903d2_sum = g_xccc2_d[l_ac].xccc903d
#               LET l_xccc903e2_sum = g_xccc2_d[l_ac].xccc903e
#               LET l_xccc903f2_sum = g_xccc2_d[l_ac].xccc903f
#               LET l_xccc903g2_sum = g_xccc2_d[l_ac].xccc903g
#               LET l_xccc903h2_sum = g_xccc2_d[l_ac].xccc903h
#               #add--2015/10/06 By shiun--(E)
               #mark--2015/10/07 By shiun--(E)
            END IF
         END IF
         #mark--2015/10/26 By shiun--(E) #151013-00019#7 remark end---
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
 
#            CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
#      CALL g_xccc2_d.deleteElement(g_xccc2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
   #mark--2015/10/26 By shiun--(S) #151013-00019#7 remark ------
   IF l_ac > 1 THEN
      #最后一组小计
      #modify--2015/10/07 By shiun--(S)
#      LET g_xccc_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)
#      LET g_xccc2_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)
      #LET g_xccc_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
      LET g_xccc_d[l_ac].imag011_desc = g_xccc_d[l_ac-1].imag011,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie
#      LET g_xccc2_d[l_ac].xccc006 = cl_getmsg("axc-00205",g_lang)   #mark--2015/10/07 By shiun
      #modify--2015/10/07 By shiun--(E)
      LET g_xccc_d[l_ac].xccc101  = l_xccc1011_sum #dorislai-20151104-add
      LET g_xccc_d[l_ac].l_unit  = l_unit1_sum     #dorislai-20151104-add
      LET g_xccc_d[l_ac].xccc102  = l_xccc1021_sum
      LET g_xccc_d[l_ac].xccc201  = l_xccc2011_sum #dorislai-20151104-add
      LET g_xccc_d[l_ac].xccc202  = l_xccc2021_sum
      #dorislai-20151104-add----(S)
      LET g_xccc_d[l_ac].xccc280  = l_xccc2801_sum
      LET g_xccc_d[l_ac].xccc280a  = l_xccc280a1_sum
      LET g_xccc_d[l_ac].xccc280b  = l_xccc280b1_sum
      LET g_xccc_d[l_ac].xccc280c  = l_xccc280c1_sum
      LET g_xccc_d[l_ac].xccc280d  = l_xccc280d1_sum
      LET g_xccc_d[l_ac].xccc280e  = l_xccc280e1_sum
      LET g_xccc_d[l_ac].xccc280f  = l_xccc280f1_sum
      LET g_xccc_d[l_ac].xccc280g  = l_xccc280g1_sum
      LET g_xccc_d[l_ac].xccc280h  = l_xccc280h1_sum
      LET g_xccc_d[l_ac].xccc301  = l_xccc3011_sum 
      #dorislai-20151104-add----(E)
      LET g_xccc_d[l_ac].xccc302  = l_xccc3021_sum
      LET g_xccc_d[l_ac].xccc901  = l_xccc9011_sum #dorislai-20151104-add
      LET g_xccc_d[l_ac].xccc902  = l_xccc9021_sum
      LET g_xccc_d[l_ac].xccc903  = l_xccc9031_sum
      #mark--2015/10/07 By shiun--(S)
#      LET g_xccc2_d[l_ac].xccc102 = l_xccc1022_sum
#      LET g_xccc2_d[l_ac].xccc202 = l_xccc2022_sum
#      LET g_xccc2_d[l_ac].xccc204 = l_xccc2042_sum
#      LET g_xccc2_d[l_ac].xccc206 = l_xccc2062_sum
#      LET g_xccc2_d[l_ac].xccc208 = l_xccc2082_sum
#      LET g_xccc2_d[l_ac].xccc210 = l_xccc2102_sum
#      LET g_xccc2_d[l_ac].xccc212 = l_xccc2122_sum
#      LET g_xccc2_d[l_ac].xccc214 = l_xccc2142_sum
#      LET g_xccc2_d[l_ac].xccc216 = l_xccc2162_sum
#      LET g_xccc2_d[l_ac].xccc218 = l_xccc2182_sum
#      LET g_xccc2_d[l_ac].xccc302 = l_xccc3022_sum
#      LET g_xccc2_d[l_ac].xccc304 = l_xccc3042_sum
#      LET g_xccc2_d[l_ac].xccc306 = l_xccc3062_sum
#      LET g_xccc2_d[l_ac].xccc308 = l_xccc3082_sum
#      LET g_xccc2_d[l_ac].xccc310 = l_xccc3102_sum
#      LET g_xccc2_d[l_ac].xccc312 = l_xccc3122_sum
#      LET g_xccc2_d[l_ac].xccc314 = l_xccc3142_sum
#      LET g_xccc2_d[l_ac].xccc902 = l_xccc9022_sum
#      LET g_xccc2_d[l_ac].xccc903 = l_xccc9032_sum  
#      #add--2015/10/06 By shiun--(S)
#      LET g_xccc2_d[l_ac].xccc903a = l_xccc903a2_sum
#      LET g_xccc2_d[l_ac].xccc903b = l_xccc903b2_sum
#      LET g_xccc2_d[l_ac].xccc903c = l_xccc903c2_sum
#      LET g_xccc2_d[l_ac].xccc903d = l_xccc903d2_sum
#      LET g_xccc2_d[l_ac].xccc903e = l_xccc903e2_sum
#      LET g_xccc2_d[l_ac].xccc903f = l_xccc903f2_sum
#      LET g_xccc2_d[l_ac].xccc903g = l_xccc903g2_sum
#      LET g_xccc2_d[l_ac].xccc903h = l_xccc903h2_sum
#      #add--2015/10/06 By shiun--(E)
      #mark--2015/10/07 By shiun--(E)
      LET l_ac = l_ac + 1     
      #合计
      #modify--2015/10/07 By shiun--(S)
#      LET g_xccc_d[l_ac].imag011 = cl_getmsg("axc-00204",g_lang)
#      LET g_xccc2_d[l_ac].imag011 = cl_getmsg("axc-00204",g_lang)
      LET g_xccc_d[l_ac].imag011 = cl_getmsg("axc-00204",g_lang)
#      LET g_xccc2_d[l_ac].xccc006 = cl_getmsg("axc-00204",g_lang)   #mark--2015/10/07 By shiun
      #modify--2015/10/07 By shiun--(E) 
      LET g_xccc_d[l_ac].xccc101  = l_xccc1011_total #dorislai-20151104-add
      LET g_xccc_d[l_ac].l_unit  = l_unit1_total     #dorislai-20151104-add
      LET g_xccc_d[l_ac].xccc102  = l_xccc1021_total
      LET g_xccc_d[l_ac].xccc201  = l_xccc2011_total #dorislai-20151104-add
      LET g_xccc_d[l_ac].xccc202  = l_xccc2021_total
      #dorislai-20151104-add----(S)
      LET g_xccc_d[l_ac].xccc280  = l_xccc2801_total
      LET g_xccc_d[l_ac].xccc280a  = l_xccc280a1_total
      LET g_xccc_d[l_ac].xccc280b  = l_xccc280b1_total
      LET g_xccc_d[l_ac].xccc280c  = l_xccc280c1_total
      LET g_xccc_d[l_ac].xccc280d  = l_xccc280d1_total
      LET g_xccc_d[l_ac].xccc280e  = l_xccc280e1_total
      LET g_xccc_d[l_ac].xccc280f  = l_xccc280f1_total
      LET g_xccc_d[l_ac].xccc280g  = l_xccc280g1_total
      LET g_xccc_d[l_ac].xccc280h  = l_xccc280h1_total
      LET g_xccc_d[l_ac].xccc301  = l_xccc3011_total
      #dorislai-20151104-add----(E)
      LET g_xccc_d[l_ac].xccc302  = l_xccc3021_total
      LET g_xccc_d[l_ac].xccc901  = l_xccc9011_total #dorislai-20151104-add
      LET g_xccc_d[l_ac].xccc902  = l_xccc9021_total
      LET g_xccc_d[l_ac].xccc903  = l_xccc9031_total
      #mark--2015/10/07 By shiun--(S)
#      LET g_xccc2_d[l_ac].xccc102 = l_xccc1022_total
#      LET g_xccc2_d[l_ac].xccc202 = l_xccc2022_total
#      LET g_xccc2_d[l_ac].xccc204 = l_xccc2042_total
#      LET g_xccc2_d[l_ac].xccc206 = l_xccc2062_total
#      LET g_xccc2_d[l_ac].xccc208 = l_xccc2082_total
#      LET g_xccc2_d[l_ac].xccc210 = l_xccc2102_total
#      LET g_xccc2_d[l_ac].xccc212 = l_xccc2122_total
#      LET g_xccc2_d[l_ac].xccc214 = l_xccc2142_total
#      LET g_xccc2_d[l_ac].xccc216 = l_xccc2162_total
#      LET g_xccc2_d[l_ac].xccc218 = l_xccc2182_total
#      LET g_xccc2_d[l_ac].xccc302 = l_xccc3022_total
#      LET g_xccc2_d[l_ac].xccc304 = l_xccc3042_total
#      LET g_xccc2_d[l_ac].xccc306 = l_xccc3062_total
#      LET g_xccc2_d[l_ac].xccc308 = l_xccc3082_total
#      LET g_xccc2_d[l_ac].xccc310 = l_xccc3102_total
#      LET g_xccc2_d[l_ac].xccc312 = l_xccc3122_total
#      LET g_xccc2_d[l_ac].xccc314 = l_xccc3142_total
#      LET g_xccc2_d[l_ac].xccc902 = l_xccc9022_total
#      LET g_xccc2_d[l_ac].xccc903 = l_xccc9032_total
#      #add--2015/10/06 By shiun--(S)
#      LET g_xccc2_d[l_ac].xccc903a = l_xccc903a2_total
#      LET g_xccc2_d[l_ac].xccc903b = l_xccc903b2_total
#      LET g_xccc2_d[l_ac].xccc903c = l_xccc903c2_total
#      LET g_xccc2_d[l_ac].xccc903d = l_xccc903d2_total
#      LET g_xccc2_d[l_ac].xccc903e = l_xccc903e2_total
#      LET g_xccc2_d[l_ac].xccc903f = l_xccc903f2_total
#      LET g_xccc2_d[l_ac].xccc903g = l_xccc903g2_total
#      LET g_xccc2_d[l_ac].xccc903h = l_xccc903h2_total
#      #add--2015/10/06 By shiun--(E)
      #mark--2015/10/07 By shiun--(E)
      LET l_ac = l_ac + 1
   END IF
   #mark--2015/10/26 By shiun--(E) #151013-00019#7 remark end---
   #end add-point
   
#   LET g_rec_b=l_ac-1
#   DISPLAY g_rec_b TO FORMONLY.cnt  
#   LET l_ac = g_cnt
#   LET g_cnt = 0 
 
   FREE axcq530_pb1   
   CALL axcq530_b_fill_3(p_wc2)
   #CALL axcq530_b_fill_2(p_wc2)   #fengmy150812 mark   此二页签删除，暂mark
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
PRIVATE FUNCTION axcq530_default()
   DEFINE  l_glaa001        LIKE glaa_t.glaa001
   DEFINE  l_xcat005        LIKE xcat_t.xcat005    #wujie 150605
   
   #预设当前site的法人，主账套，年度期别，成本计算类型
   #fengmy150806----begin
#   CALL s_axc_set_site_default() RETURNING g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003
#   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003
   IF cl_null(g_xccc_m.xccccomp) AND cl_null(g_xccc_m.xcccld) AND cl_null(g_yy1) AND cl_null(g_mm1) 
             AND cl_null(g_yy2) AND cl_null(g_mm2) AND cl_null(g_xccc_m.xccc003) AND cl_null(g_xccc_m.xccc001) THEN
      CALL s_axc_set_site_default() RETURNING g_xccc_m.xccccomp,g_xccc_m.xcccld,g_yy2,g_mm2,g_xccc_m.xccc003
      DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.xccc003
      LET g_yy1 = g_yy2
      LET g_mm1 = g_mm2
      DISPLAY g_yy1 TO xccc004
      DISPLAY g_mm1 TO xccc005
      DISPLAY g_yy2 TO xccc004_1
      DISPLAY g_mm2 TO xccc005_1
   END IF
   #fengmy150806----end   

   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccc_m.xccccomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccccomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccccomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccc_m.xcccld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xcccld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xcccld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccc_m.xccc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccc003_desc
      
   LET g_xccc_m.xccc001 = '1'
   DISPLAY BY NAME g_xccc_m.xccc001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccc_m.xcccld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccc001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccc001_desc  

#wujie 150605 --begin
   CALL cl_set_comp_visible('inadsite,inadsite_2,inad010,inad010_2,inadsite_desc,inadsite_2_desc,inad010_desc,inad010_2_desc',TRUE)
   LET l_xcat005 = NULL
   SELECT xcat005 INTO l_xcat005 
     FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xccc_m.xccc003
   IF l_xcat005 <> '3' THEN   #不是批次成本的，隐藏门店和供应商
      CALL cl_set_comp_visible('inadsite,inadsite_2,inad010,inad010_2,inadsite_desc,inadsite_2_desc,inad010_desc,inad010_2_desc',FALSE)
   END IF
#wujie 150605 --end
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
PRIVATE FUNCTION axcq530_ref()
DEFINE  l_glaa001        LIKE glaa_t.glaa001
  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccc_m.xccccomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccccomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccccomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccc_m.xcccld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xcccld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xcccld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccc_m.xccc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccc003_desc
      
  LET l_glaa001 = ' '
   CASE g_xccc_m.xccc001
      WHEN '1'
         SELECT glaa001 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xccc_m.xcccld
      WHEN '2'
         SELECT glaa016 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xccc_m.xcccld
      WHEN '3'
         SELECT glaa020 INTO l_glaa001
          FROM glaa_t
         WHERE glaaent = g_enterprise
           AND glaald  = g_xccc_m.xcccld
   END CASE
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccc001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccc001_desc
END FUNCTION

################################################################################
# Descriptions...: 創建暫存檔
# Date & Author..: 2015/3/26 By ouhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq530_create_temp_table()
DROP TABLE axcq530_tmp;
 CREATE TEMP TABLE axcq530_tmp(
   #add--2015/10/06 By shiun--(S)
   xccc004          SMALLINT, 
   xccc005          SMALLINT, 
   #add--2015/10/06 By shiun--(E) 
   imag011          VARCHAR(100), 
   imag011_desc     VARCHAR(100), 
   xccc002          VARCHAR(30), 
   xccc002_desc     VARCHAR(100), 
   xccc006          VARCHAR(40), 
   xccc006_desc     VARCHAR(100), 
   xccc006_desc_1   VARCHAR(100), 
   xcbb005          VARCHAR(100), 
   xccc007          VARCHAR(256), 
   xccc008          VARCHAR(30),
#wujie 150611 --begin
   inadsite         VARCHAR(10),
   inadsite_desc    VARCHAR(500),
   inad010          VARCHAR(10),
   inad010_desc     VARCHAR(80),
#wujie 150611 --end
   xccc101          DECIMAL(20,6), 
   l_unit           VARCHAR(30), 
   xccc102          DECIMAL(20,6), 
   xccc201          DECIMAL(20,6), 
   xccc202          DECIMAL(20,6), 
   #add--2015/10/16 By shiun--(S)
   xccc203          DECIMAL(20,6), 
   xccc204          DECIMAL(20,6), 
   xccc205          DECIMAL(20,6), 
   xccc206          DECIMAL(20,6), 
   xccc207          DECIMAL(20,6), 
   xccc208          DECIMAL(20,6), 
   xccc209          DECIMAL(20,6), 
   xccc210          DECIMAL(20,6), 
   xccc211          DECIMAL(20,6), 
   xccc212          DECIMAL(20,6), 
   xccc213          DECIMAL(20,6), 
   xccc214          DECIMAL(20,6), 
   xccc215          DECIMAL(20,6), 
   xccc216          DECIMAL(20,6), 
   xccc217          DECIMAL(20,6), 
   xccc218          DECIMAL(20,6), 
   #add--2015/10/16 By shiun--(E)
   #mark--2015/10/16 By shiun--(S)
#   xccc280         LIKE xccc_t.xccc280, 
#   xccc280a        LIKE xccc_t.xccc280a,    #fengmy150519 add
#   xccc280b        LIKE xccc_t.xccc280b,    #fengmy150519 add
#   xccc280c        LIKE xccc_t.xccc280c,    #fengmy150519 add
#   xccc280d        LIKE xccc_t.xccc280d,    #fengmy150519 add
#   xccc280e        LIKE xccc_t.xccc280e,    #fengmy150519 add
#   xccc280f        LIKE xccc_t.xccc280f,    #fengmy150519 add
#   xccc280g        LIKE xccc_t.xccc280g,    #fengmy150519 add
#   xccc280h        LIKE xccc_t.xccc280h,    #fengmy150519 add
   #mark--2015/10/16 By shiun--(E)
   xccc301          DECIMAL(20,6), 
   xccc302          DECIMAL(20,6), 
   #add--2015/10/16 By shiun--(S)
   xccc303          DECIMAL(20,6), 
   xccc304          DECIMAL(20,6), 
   xccc305          DECIMAL(20,6), 
   xccc306          DECIMAL(20,6), 
   xccc307          DECIMAL(20,6), 
   xccc308          DECIMAL(20,6), 
   xccc309          DECIMAL(20,6), 
   xccc310          DECIMAL(20,6), 
   xccc311          DECIMAL(20,6), 
   xccc312          DECIMAL(20,6), 
   xccc313          DECIMAL(20,6), 
   xccc314          DECIMAL(20,6),
   #add--2015/10/16 By shiun--(E)
   xccc901          DECIMAL(20,6), 
   xccc902          DECIMAL(20,6), 
   xccc903          DECIMAL(20,6),
   #add--2015/10/06 By shiun--(S)
   xccc903a    DECIMAL(20,6),
   xccc903b    DECIMAL(20,6),
   xccc903c    DECIMAL(20,6),
   xccc903d    DECIMAL(20,6),
   xccc903e    DECIMAL(20,6),
   xccc903f    DECIMAL(20,6),
   xccc903g    DECIMAL(20,6),
   xccc903h    DECIMAL(20,6),
   #add--2015/10/06 By shiun--(E)   
   xccccomp         VARCHAR(10), 
   xccccomp_desc    VARCHAR(100), 
   xccc001          VARCHAR(1), 
   xccc001_desc     VARCHAR(100), 
   xcccld           VARCHAR(5), 
   xcccld_desc      VARCHAR(100), 
   xccc003          VARCHAR(10), 
   xccc003_desc     VARCHAR(100), 
   xcccent          SMALLINT, 
   xccckey          VARCHAR(1000),
   l_xccc004_s     VARCHAR(100),       #add--2015/10/06 By shiun
   l_xccc004_e     VARCHAR(100)     #add--2015/10/06 By shiun
 );
END FUNCTION

################################################################################
# Descriptions...: 將單身數據存放在暫存檔
# Date & Author..: 2015/3/26 By ouhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq530_ins_temp()
DEFINE sr          RECORD 
   #add--2015/10/06 By shiun--(S)
   xccc004         LIKE xccc_t.xccc004, 
   xccc005         LIKE xccc_t.xccc005, 
   #add--2015/10/06 By shiun--(E)
   imag011         LIKE type_t.chr100, 
   imag011_desc    LIKE type_t.chr100, 
   xccc002         LIKE xccc_t.xccc002, 
   xccc002_desc    LIKE type_t.chr100, 
   xccc006         LIKE xccc_t.xccc006, 
   xccc006_desc    LIKE type_t.chr100, 
   xccc006_desc_1  LIKE type_t.chr100, 
   xcbb005         LIKE type_t.chr100, 
   xccc007         LIKE xccc_t.xccc007, 
   xccc008         LIKE xccc_t.xccc008, 
#wujie 150611 --begin
   inadsite        LIKE inad_t.inadsite,
   inadsite_desc   LIKE ooefl_t.ooefl003,
   inad010         LIKE inad_t.inad010,
   inad010_desc    LIKE pmaal_t.pmaal004,
#wujie 150611 --end
   xccc101         LIKE xccc_t.xccc101, 
   l_unit          LIKE type_t.chr30, 
   xccc102         LIKE xccc_t.xccc102, 
   xccc201         LIKE xccc_t.xccc201, 
   xccc202         LIKE xccc_t.xccc202, 
   #add--2015/10/16 By shiun--(S)
   xccc203         LIKE xccc_t.xccc203, 
   xccc204         LIKE xccc_t.xccc204, 
   xccc205         LIKE xccc_t.xccc205, 
   xccc206         LIKE xccc_t.xccc206, 
   xccc207         LIKE xccc_t.xccc207, 
   xccc208         LIKE xccc_t.xccc208, 
   xccc209         LIKE xccc_t.xccc209, 
   xccc210         LIKE xccc_t.xccc210, 
   xccc211         LIKE xccc_t.xccc211, 
   xccc212         LIKE xccc_t.xccc212, 
   xccc213         LIKE xccc_t.xccc213, 
   xccc214         LIKE xccc_t.xccc214, 
   xccc215         LIKE xccc_t.xccc215, 
   xccc216         LIKE xccc_t.xccc216, 
   xccc217         LIKE xccc_t.xccc217, 
   xccc218         LIKE xccc_t.xccc218, 
   #add--2015/10/16 By shiun--(E)
   #mark--2015/10/16 By shiun--(S)
#   xccc280         LIKE xccc_t.xccc280, 
#   xccc280a        LIKE xccc_t.xccc280a,    #fengmy150519 add
#   xccc280b        LIKE xccc_t.xccc280b,    #fengmy150519 add
#   xccc280c        LIKE xccc_t.xccc280c,    #fengmy150519 add
#   xccc280d        LIKE xccc_t.xccc280d,    #fengmy150519 add
#   xccc280e        LIKE xccc_t.xccc280e,    #fengmy150519 add
#   xccc280f        LIKE xccc_t.xccc280f,    #fengmy150519 add
#   xccc280g        LIKE xccc_t.xccc280g,    #fengmy150519 add
#   xccc280h        LIKE xccc_t.xccc280h,    #fengmy150519 add
   #mark--2015/10/16 By shiun--(E)
   xccc301         LIKE xccc_t.xccc301, 
   xccc302         LIKE xccc_t.xccc302, 
   #add--2015/10/16 By shiun--(S)
   xccc303         LIKE xccc_t.xccc303, 
   xccc304         LIKE xccc_t.xccc304, 
   xccc305         LIKE xccc_t.xccc305, 
   xccc306         LIKE xccc_t.xccc306, 
   xccc307         LIKE xccc_t.xccc307, 
   xccc308         LIKE xccc_t.xccc308, 
   xccc309         LIKE xccc_t.xccc309, 
   xccc310         LIKE xccc_t.xccc310, 
   xccc311         LIKE xccc_t.xccc311, 
   xccc312         LIKE xccc_t.xccc312, 
   xccc313         LIKE xccc_t.xccc313, 
   xccc314         LIKE xccc_t.xccc314,
   #add--2015/10/16 By shiun--(E)
   xccc901         LIKE xccc_t.xccc901, 
   xccc902         LIKE xccc_t.xccc902, 
   xccc903         LIKE xccc_t.xccc903, 
   #add--2015/10/06 By shiun--(S)
   xccc903a        LIKE xccc_t.xccc903a,
   xccc903b        LIKE xccc_t.xccc903b,
   xccc903c        LIKE xccc_t.xccc903c,
   xccc903d        LIKE xccc_t.xccc903d,
   xccc903e        LIKE xccc_t.xccc903e,
   xccc903f        LIKE xccc_t.xccc903f,
   xccc903g        LIKE xccc_t.xccc903g,
   xccc903h        LIKE xccc_t.xccc903h,
   #add--2015/10/06 By shiun--(E)
   xccccomp        LIKE xccc_t.xccccomp, 
   xccccomp_desc   LIKE type_t.chr100, 
   xccc001         LIKE xccc_t.xccc001, 
   xccc001_desc    LIKE type_t.chr100, 
   xcccld          LIKE xccc_t.xcccld, 
   xcccld_desc     LIKE type_t.chr100, 
   xccc003         LIKE xccc_t.xccc003, 
   xccc003_desc    LIKE type_t.chr100, 
   xcccent         LIKE xccc_t.xcccent, 
   xccckey         LIKE type_t.chr1000,
   l_xccc004_s    LIKE type_t.chr100,  #add--2015/10/06 By shiun
   l_xccc004_e    LIKE type_t.chr100   #add--2015/10/06 By shiun
                   END RECORD
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5                        
DEFINE l_i               LIKE type_t.num5
DEFINE l_glaa001         LIKE glaa_t.glaa001
DEFINE l_glaa016         LIKE glaa_t.glaa016
DEFINE l_glaa020         LIKE glaa_t.glaa020
DEFINE l_xccc004         LIKE type_t.chr30
DEFINE l_xccc005         LIKE type_t.chr30                       
DEFINE l_xcat005        LIKE xcat_t.xcat005    #fengmy 150702
DEFINE l_sql1           STRING
DEFINE l_cnt1           LIKE type_t.num5
DEFINE l_length         LIKE type_t.num5
  #刪除臨時表中資料
  DELETE FROM axcq530_tmp
    
#  LET l_success = TRUE
#  IF cl_null(g_sql_tmp) THEN
#  LET g_sql_tmp = "SELECT  UNIQUE t1.imag011,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,
#       (xccc201+xccc203+xccc205+xccc207+xccc209+xccc211+xccc213+xccc215+xccc217),
#       (xccc202+xccc204+xccc206+xccc208+xccc210+xccc212+xccc214+xccc216+xccc218),xccc280,
#       ","xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,",   #fengmy150519 add            
#     " (xccc301+xccc303+xccc305+xccc307+xccc309+xccc311+xccc313),
#       (xccc302+xccc304+xccc306+xccc308+xccc310+xccc312+xccc314),xccc901,xccc902,xccc903,
#       xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h, ",   #add--2015/10/06 By shiun
#     " t1.imag011,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201, 
#       xccc202,xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213, 
#       xccc214,xccc215,xccc216,xccc217,xccc218,xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307, 
#       xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903,
#       xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h, ",   #add--2015/10/06 By shiun
#     " t2.xcbfl003 , ",
#     #"  t3.imaal003 ,t4.imaal004 ,t5.imaal004 FROM xccc_t",     #fengmy150812 mark
#      "  t3.imaal003 ,t4.imaal004 ,t5.imaal004 FROM axcq530_tmp1",     #fengmy150812 
#               " LEFT OUTER JOIN imag_t t1 ON t1.imagent = '"||g_enterprise||"' AND t1.imagsite = xccccomp AND t1.imag001 = xccc006 ",
#               
#                              " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xccc002 AND t2.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xccc006 AND t3.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xccc006 AND t4.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t5 ON t5.imaalent='"||g_enterprise||"' AND t5.imaal001=xccc006 AND t5.imaal002='"||g_dlang||"' ",
# 
#              #" WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=?"   #fengmy150812 mark
#               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? "   #fengmy150812 
# 
#   IF NOT cl_null(g_wc2_table1) THEN
#      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
#   END IF 
#  
# END IF 
#
#  FOR l_i = 1 TO g_browser.getLength()
#  
#    LET sr.xccc004  = g_browser[l_i].b_xccc004
#    LET sr.xccc001  = g_browser[l_i].b_xccc001
#    LET sr.xcccld   = g_browser[l_i].b_xcccld
#    LET sr.xccc005  = g_browser[l_i].b_xccc005
#    LET sr.xccc003  = g_browser[l_i].b_xccc003
#    
##fengmy150812-----begin     
##    EXECUTE axcq530_master_referesh USING sr.xcccld,sr.xccc001,sr.xccc003,sr.xccc004,sr.xccc005 
##    INTO  sr.xccccomp,sr.xccc004,sr.xccc001,sr.xcccld,sr.xccc005,sr.xccc003,sr.xccccomp_desc,sr.xcccld_desc,sr.xccc003_desc
#   EXECUTE axcq530_master_referesh1 USING sr.xcccld,sr.xccc001,sr.xccc003
#      INTO sr.xccccomp,sr.xccc001,sr.xcccld, 
#           sr.xccc003,sr.xccccomp_desc,sr.xcccld_desc
##fengmy150812-----end 
#    LET l_xccc004=sr.xccc004
#    LET l_xccc005=sr.xccc005
#    LET sr.xccckey = sr.xccccomp,"-",sr.xcccld,"-",l_xccc004 CLIPPED,"-",l_xccc005 CLIPPED,"-",sr.xccc001 CLIPPED,"-",sr.xccc003
#    
#    PREPARE axcq530_ins_tmp_pre FROM g_sql_tmp
#    DECLARE axcq530_ins_tmp_cs CURSOR FOR axcq530_ins_tmp_pre
#      
#    OPEN axcq530_ins_tmp_cs USING g_enterprise,sr.xcccld,sr.xccc001,sr.xccc003,sr.xccc004,sr.xccc005
#      
##    FOREACH axcq530_ins_tmp_cs INTO sr.imag011,sr.xccc002,sr.xccc006,sr.xccc007,sr.xccc008,sr.inadsite,sr.inad010,sr.xccc101,sr.xccc102,sr.xccc201,sr.xccc202,    #wujie 150611 add inad #fengmy150702 mark
#    FOREACH axcq530_ins_tmp_cs INTO sr.imag011,sr.xccc002,sr.xccc006,sr.xccc007,sr.xccc008,sr.xccc101,sr.xccc102,sr.xccc201,sr.xccc202,    #fengmy150702
#                                   sr.xccc280,sr.xccc280a,sr.xccc280b,sr.xccc280c,sr.xccc280d,sr.xccc280e,sr.xccc280f,sr.xccc280g,sr.xccc280h, #add xccc280a-h fengmy150519
#                                   sr.xccc301,sr.xccc302,sr.xccc901,sr.xccc902,sr.xccc903,sr.xccc903a,sr.xccc903b,sr.xccc903c,sr.xccc903d,sr.xccc903e,
#                                   sr.xccc903f,sr.xccc903g,sr.xccc903h,sr.xccc002_desc,sr.xccc006_desc,sr.xccc006_desc_1   #modify--2015/10/06 By shiun add xccc903a~h
#        
#     #成本分群     
#      INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
#      LET g_ref_fields[1] = sr.imag011                                                                                                                        
#      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.imag011_desc = '', g_rtn_fields[1] , ''  
#      DISPLAY BY NAME sr.imag011_desc 
#      
#    #成本域   
#     INITIALIZE g_ref_fields TO NULL
#     LET g_ref_fields[1] = sr.xccc002
#     CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#     LET sr.xccc002_desc = '', g_rtn_fields[1] , ''
#     DISPLAY BY NAME sr.xccc002_desc  
#     
#      #成本單位取axci120
#      SELECT xcbb005 INTO sr.xcbb005 FROM xcbb_t
#       WHERE xcbbent  = g_enterprise
#         AND xcbbcomp = sr.xccccomp
#         AND xcbb001  = sr.xccc004
#         AND xcbb002  = sr.xccc005
#         AND xcbb003  = sr.xccc006
#         
#      INITIALIZE g_ref_fields TO NULL
#       LET g_ref_fields[1] = sr.xccc006
#       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#       LET sr.xccc006_desc = '', g_rtn_fields[1] , ''
#       LET sr.xccc006_desc_1 = '', g_rtn_fields[2] , ''   
#         
#      #期初單位成本
#      LET sr.l_unit = sr.xccc102/sr.xccc101
##fengmy 150702 --begin
#       LET l_xcat005 = NULL
#       SELECT xcat005 INTO l_xcat005    #l_xcat005 =3表示是批次成本，单身填充时要去找出门店和供应商
#         FROM xcat_t
#        WHERE xcatent = g_enterprise
#          AND xcat001 = sr.xccc003
#       IF l_xcat005 = '3' THEN 
#          LET l_sql1 = " SELECT MIN(inadsite),MIN(inad010) FROM inad_t ",
#                       "  WHERE inadent = ? ",
#                       "    AND inad001 = ? ",
#                       "    AND inad002 = ? ",
#                       "    AND inad003 = ? ",
#                       "    AND ",g_wc3,
#                       "  GROUP BY inadent,inad001,inad002,inad003"
#          PREPARE axcq530_inad1 FROM l_sql1
#            EXECUTE axcq530_inad1 INTO sr.inadsite,sr.inad010 USING g_enterprise,sr.xccc006,sr.xccc007,sr.xccc008
#            IF sr.inadsite IS NULL AND sr.inad010 IS NULL THEN
#               CONTINUE FOREACH
#            END IF
#       END IF
##wujie 150702 --end
##wujie 150611 --begin
#         LET sr.inadsite_desc = s_desc_get_department_desc(sr.inadsite)
#         LET sr.inad010_desc = s_desc_get_trading_partner_full_desc(sr.inad010)
##wujie 150611 --end
#
#      INSERT INTO axcq530_tmp ( imag011,imag011_desc,xccc002,xccc002_desc,xccc006,xccc006_desc,xccc006_desc_1,xccc007,xccc008,inadsite,inadsite_desc,inad010,inad010_desc,xcbb005,xccc101,l_unit,xccc102,xccc201,xccc202,xccc280,    #wujie 150611 add inad
#                                xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h, #add xccc280a-h fengmy150519
#                                xccc301,xccc302,xccc901,xccc902,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,   #modify--2015/10/06 By shiun add xccc903a~h
#                                xccccomp,xccccomp_desc,xccc004,xccc001,xccc001_desc,xccc005,xcccld,xcccld_desc,xccc003,xccc003_desc,xcccent,xccckey )
#                       VALUES(  sr.imag011,sr.imag011_desc,sr.xccc002,sr.xccc002_desc,sr.xccc006,sr.xccc006_desc,sr.xccc006_desc_1,sr.xccc007,sr.xccc008,sr.inadsite,sr.inadsite_desc,sr.inad010,sr.inad010_desc,sr.xcbb005,sr.xccc101,sr.l_unit,   #wujie 150611 add inad
#                                sr.xccc102,sr.xccc201,sr.xccc202,sr.xccc280,
#                                sr.xccc280a,sr.xccc280b,sr.xccc280c,sr.xccc280d,sr.xccc280e,sr.xccc280f,sr.xccc280g,sr.xccc280h, #add xccc280a-h fengmy150519
#                                sr.xccc301,sr.xccc302,sr.xccc901,sr.xccc902,sr.xccc903,sr.xccc903a,sr.xccc903b,sr.xccc903c,sr.xccc903d,sr.xccc903e,sr.xccc903f,sr.xccc903g,sr.xccc903h,   #modify--2015/10/06 By shiun add xccc903a~h
#                                sr.xccccomp,sr.xccccomp_desc,sr.xccc004,sr.xccc001,sr.xccc001_desc,sr.xccc005,sr.xcccld,sr.xcccld_desc,sr.xccc003,sr.xccc003_desc,sr.xcccent,sr.xccckey )
#
#      IF SQLCA.sqlcode  THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = 'insert tmp'
#         LET g_errparam.code = SQLCA.SQLCODE
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF   
#     END FOREACH
#     
#     CALL cl_err_collect_show()
#     IF l_success = FALSE THEN
#        DELETE FROM axcq530_tmp
#     END IF
#      
#     FREE axcq530_ins_tmp_pre
#     
#   END FOR     
   
#add--2015/10/06 By shiun--(S)
  #將畫面資料擷取傳至temptable
   FOR l_cnt1 = 1 TO g_xccc2_d.getLength()
      LET sr.xccc001  = g_xccc_m.xccc001  
      LET sr.xccc001  = g_xccc_m.xccc001_desc    #160520-00003#5
      LET sr.xcccld   = g_xccc_m.xcccld      
      LET sr.xccc003  = g_xccc_m.xccc003
      
      LET sr.xccc004  = g_xccc2_d[l_cnt1].xccc004
      LET sr.xccc005  = g_xccc2_d[l_cnt1].xccc005
      LET sr.imag011 = g_xccc2_d[l_cnt1].imag011 
      LET sr.xccc002 = g_xccc2_d[l_cnt1].xccc002 
      LET sr.xccc006 = g_xccc2_d[l_cnt1].xccc006 
      LET sr.xcbb005 = g_xccc2_d[l_cnt1].xcbb005
      LET sr.xccc007 = g_xccc2_d[l_cnt1].xccc007 
      LET sr.xccc008 = g_xccc2_d[l_cnt1].xccc008 
      LET sr.xccc101 = g_xccc2_d[l_cnt1].xccc101 
      LET sr.xccc102 = g_xccc2_d[l_cnt1].xccc102 
      LET sr.xccc201 = g_xccc2_d[l_cnt1].xccc201 
      LET sr.xccc202 = g_xccc2_d[l_cnt1].xccc202 
      #add--2015/10/16 By shiun--(S)
      LET sr.xccc203 = g_xccc2_d[l_cnt1].xccc203
      LET sr.xccc204 = g_xccc2_d[l_cnt1].xccc204
      LET sr.xccc205 = g_xccc2_d[l_cnt1].xccc205
      LET sr.xccc206 = g_xccc2_d[l_cnt1].xccc206
      LET sr.xccc207 = g_xccc2_d[l_cnt1].xccc207
      LET sr.xccc208 = g_xccc2_d[l_cnt1].xccc208
      LET sr.xccc209 = g_xccc2_d[l_cnt1].xccc209
      LET sr.xccc210 = g_xccc2_d[l_cnt1].xccc210
      LET sr.xccc211 = g_xccc2_d[l_cnt1].xccc211
      LET sr.xccc212 = g_xccc2_d[l_cnt1].xccc212
      LET sr.xccc213 = g_xccc2_d[l_cnt1].xccc213
      LET sr.xccc214 = g_xccc2_d[l_cnt1].xccc214
      LET sr.xccc215 = g_xccc2_d[l_cnt1].xccc215
      LET sr.xccc216 = g_xccc2_d[l_cnt1].xccc216
      LET sr.xccc217 = g_xccc2_d[l_cnt1].xccc217
      LET sr.xccc218 = g_xccc2_d[l_cnt1].xccc218
      #add--2015/10/16 By shiun--(E)
      #mark--2015/10/16 By shiun--(S)
#      LET sr.xccc280 = g_xccc_d[l_cnt1].xccc280 
#      LET sr.xccc280a = g_xccc_d[l_cnt1].xccc280a
#      LET sr.xccc280b = g_xccc_d[l_cnt1].xccc280b
#      LET sr.xccc280c = g_xccc_d[l_cnt1].xccc280c
#      LET sr.xccc280d = g_xccc_d[l_cnt1].xccc280d
#      LET sr.xccc280e = g_xccc_d[l_cnt1].xccc280e
#      LET sr.xccc280f = g_xccc_d[l_cnt1].xccc280f
#      LET sr.xccc280g = g_xccc_d[l_cnt1].xccc280g
#      LET sr.xccc280h = g_xccc_d[l_cnt1].xccc280h
      #mark--2015/10/16 By shiun--(E)
      LET sr.xccc301 = g_xccc2_d[l_cnt1].xccc301 
      LET sr.xccc302 = g_xccc2_d[l_cnt1].xccc302
      #add--2015/10/16 By shiun--(S)
      LET sr.xccc303 = g_xccc2_d[l_cnt1].xccc303
      LET sr.xccc304 = g_xccc2_d[l_cnt1].xccc304
      LET sr.xccc305 = g_xccc2_d[l_cnt1].xccc305
      LET sr.xccc306 = g_xccc2_d[l_cnt1].xccc306
      LET sr.xccc307 = g_xccc2_d[l_cnt1].xccc307
      LET sr.xccc308 = g_xccc2_d[l_cnt1].xccc308
      LET sr.xccc309 = g_xccc2_d[l_cnt1].xccc309
      LET sr.xccc310 = g_xccc2_d[l_cnt1].xccc310
      LET sr.xccc311 = g_xccc2_d[l_cnt1].xccc311
      LET sr.xccc312 = g_xccc2_d[l_cnt1].xccc312
      LET sr.xccc313 = g_xccc2_d[l_cnt1].xccc313
      LET sr.xccc314 = g_xccc2_d[l_cnt1].xccc314      
      #add--2015/10/16 By shiun--(S)
      LET sr.xccc901 = g_xccc2_d[l_cnt1].xccc901 
      LET sr.xccc902 = g_xccc2_d[l_cnt1].xccc902 
      LET sr.xccc903 = g_xccc2_d[l_cnt1].xccc903 
      LET sr.xccc903a = g_xccc2_d[l_cnt1].xccc903a
      LET sr.xccc903b = g_xccc2_d[l_cnt1].xccc903b
      LET sr.xccc903c = g_xccc2_d[l_cnt1].xccc903c
      LET sr.xccc903d = g_xccc2_d[l_cnt1].xccc903d
      LET sr.xccc903e = g_xccc2_d[l_cnt1].xccc903e
      LET sr.xccc903f = g_xccc2_d[l_cnt1].xccc903f
      LET sr.xccc903g = g_xccc2_d[l_cnt1].xccc903g
      LET sr.xccc903h = g_xccc2_d[l_cnt1].xccc903h
      LET sr.xccc002_desc = g_xccc2_d[l_cnt1].xccc002_2_desc
      LET sr.xccc006_desc = g_xccc2_d[l_cnt1].xccc006_2_desc
      LET sr.xccc006_desc_1 = g_xccc2_d[l_cnt1].xccc006_2_desc_desc
      LET sr.imag011_desc = g_xccc2_d[l_cnt1].imag011_2_desc   #160520-00003#5
      
      LET sr.l_xccc004_s   =g_yy1 USING "<<<<" CLIPPED ," ",g_mm1 USING "<<" CLIPPED
      LET sr.l_xccc004_e   =g_yy2 USING "<<<<" CLIPPED ," ",g_mm2 USING "<<" CLIPPED
      
      SELECT DISTINCT xccccomp INTO sr.xccccomp FROM xccc_t
       WHERE xcccent = g_enterprise AND xcccld = sr.xcccld AND xccc001 = sr.xccc001
         AND xccc003 = sr.xccc003 AND xccc004 = sr.xccc004 AND xccc005 = sr.xccc005  

      EXECUTE axcq530_master_referesh USING sr.xcccld,sr.xccc001,sr.xccc003,sr.xccc004, 
       sr.xccc005 INTO sr.xccccomp,sr.xccc004,sr.xccc005,sr.xccc001,sr.xcccld, 
       sr.xccc003,sr.xccccomp_desc,sr.xcccld_desc
   

      LET sr.xccckey = sr.xccccomp,"-",sr.xcccld CLIPPED,"-",sr.xccc001,"-",sr.xccc003 CLIPPED

     #160520-00003#5----s
     ##成本分群     
     # INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
     # LET g_ref_fields[1] = sr.imag011                                                                                                                        
     # CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
     # LET sr.imag011_desc = '', g_rtn_fields[1] , ''  
     # DISPLAY BY NAME sr.imag011_desc 
     # 
    ##成本域   
     #INITIALIZE g_ref_fields TO NULL
     #LET g_ref_fields[1] = sr.xccc002
     #CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     #LET sr.xccc002_desc = '', g_rtn_fields[1] , ''
     #DISPLAY BY NAME sr.xccc002_desc  
     #160520-00003#5----e
     
     
#     IF sr.xccc006 <> cl_getmsg("axc-00205",g_lang) AND sr.xccc006 <> cl_getmsg("axc-00204",g_lang) THEN   #add--2015/10/07 By shiun
#        #成本單位取axci120
#        SELECT xcbb005 INTO sr.xcbb005 FROM xcbb_t
#         WHERE xcbbent  = g_enterprise
#           AND xcbbcomp = sr.xccccomp
#           AND xcbb001  = sr.xccc004
#           AND xcbb002  = sr.xccc005
#           AND xcbb003  = sr.xccc006
#      END IF   #add--2015/10/07 By shiun

      #160520-00003#5----s
      #INITIALIZE g_ref_fields TO NULL
      # LET g_ref_fields[1] = sr.xccc006
      # CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      # LET sr.xccc006_desc = '', g_rtn_fields[1] , ''
      # LET sr.xccc006_desc_1 = '', g_rtn_fields[2] , ''   
      #160520-00003#5----e


      #期初單位成本
      LET sr.l_unit = sr.xccc102/sr.xccc101
#fengmy 150702 --begin
       LET l_xcat005 = NULL
       SELECT xcat005 INTO l_xcat005    #l_xcat005 =3表示是批次成本，单身填充时要去找出门店和供应商
         FROM xcat_t
        WHERE xcatent = g_enterprise
          AND xcat001 = sr.xccc003
       IF l_xcat005 = '3' THEN 
          LET l_sql1 = " SELECT MIN(inadsite),MIN(inad010) FROM inad_t ",
                       "  WHERE inadent = ? ",
                       "    AND inad001 = ? ",
                       "    AND inad002 = ? ",
                       "    AND inad003 = ? ",
                       "    AND ",g_wc3,
                       "  GROUP BY inadent,inad001,inad002,inad003"
          PREPARE axcq530_inad1 FROM l_sql1
            EXECUTE axcq530_inad1 INTO sr.inadsite,sr.inad010 USING g_enterprise,sr.xccc006,sr.xccc007,sr.xccc008
            IF sr.inadsite IS NULL AND sr.inad010 IS NULL THEN
               CONTINUE FOR
            END IF
       END IF
#wujie 150702 --end
#wujie 150611 --begin
         LET sr.inadsite_desc = s_desc_get_department_desc(sr.inadsite)
         LET sr.inad010_desc = s_desc_get_trading_partner_full_desc(sr.inad010)
#wujie 150611 --end
      #modify--2015/10/16 By shiun--(S)
#      INSERT INTO axcq530_tmp ( imag011,imag011_desc,xccc002,xccc002_desc,xccc006,xccc006_desc,xccc006_desc_1,xccc007,xccc008,inadsite,inadsite_desc,inad010,inad010_desc,xcbb005,xccc101,l_unit,xccc102,xccc201,xccc202,xccc280,    #wujie 150611 add inad
#                                xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h, #add xccc280a-h fengmy150519
#                                xccc301,xccc302,xccc901,xccc902,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,   #modify--2015/10/06 By shiun add xccc903a~h
#                                xccccomp,xccccomp_desc,xccc004,xccc001,xccc001_desc,xccc005,xcccld,xcccld_desc,xccc003,xccc003_desc,xcccent,xccckey,l_xccc004_s,l_xccc004_e )
#                       VALUES(  sr.imag011,sr.imag011_desc,sr.xccc002,sr.xccc002_desc,sr.xccc006,sr.xccc006_desc,sr.xccc006_desc_1,sr.xccc007,sr.xccc008,sr.inadsite,sr.inadsite_desc,sr.inad010,sr.inad010_desc,sr.xcbb005,sr.xccc101,sr.l_unit,   #wujie 150611 add inad
#                                sr.xccc102,sr.xccc201,sr.xccc202,sr.xccc280,
#                                sr.xccc280a,sr.xccc280b,sr.xccc280c,sr.xccc280d,sr.xccc280e,sr.xccc280f,sr.xccc280g,sr.xccc280h, #add xccc280a-h fengmy150519
#                                sr.xccc301,sr.xccc302,sr.xccc901,sr.xccc902,sr.xccc903,sr.xccc903a,sr.xccc903b,sr.xccc903c,sr.xccc903d,sr.xccc903e,sr.xccc903f,sr.xccc903g,sr.xccc903h,   #modify--2015/10/06 By shiun add xccc903a~h
#                                sr.xccccomp,sr.xccccomp_desc,sr.xccc004,sr.xccc001,sr.xccc001_desc,sr.xccc005,sr.xcccld,sr.xcccld_desc,sr.xccc003,sr.xccc003_desc,sr.xcccent,sr.xccckey,sr.l_xccc004_s,sr.l_xccc004_e )
      
      INSERT INTO axcq530_tmp ( imag011,imag011_desc,xccc002,xccc002_desc,xccc006,xccc006_desc,xccc006_desc_1,xccc007,xccc008,inadsite,inadsite_desc,inad010,inad010_desc,xcbb005,xccc101,l_unit,xccc102,xccc201,xccc202,
                                xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,xccc214,xccc215,xccc216,xccc217,xccc218,
                                xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307,xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,
                                xccc901,xccc902,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,
                                xccccomp,xccccomp_desc,xccc004,xccc001,xccc001_desc,xccc005,xcccld,xcccld_desc,xccc003,xccc003_desc,xcccent,xccckey,l_xccc004_s,l_xccc004_e )
                       VALUES(  sr.imag011,sr.imag011_desc,sr.xccc002,sr.xccc002_desc,sr.xccc006,sr.xccc006_desc,sr.xccc006_desc_1,sr.xccc007,sr.xccc008,sr.inadsite,sr.inadsite_desc,sr.inad010,sr.inad010_desc,sr.xcbb005,sr.xccc101,sr.l_unit,   #wujie 150611 add inad
                                sr.xccc102,sr.xccc201,sr.xccc202,sr.xccc203,sr.xccc204,sr.xccc205,sr.xccc206,sr.xccc207,sr.xccc208,sr.xccc209,sr.xccc210,
                                sr.xccc211,sr.xccc212,sr.xccc213,sr.xccc214,sr.xccc215,sr.xccc216,sr.xccc217,sr.xccc218,
                                sr.xccc301,sr.xccc302,sr.xccc303,sr.xccc304,sr.xccc305,sr.xccc306,sr.xccc307,sr.xccc308,sr.xccc309,sr.xccc310,sr.xccc311,sr.xccc312,sr.xccc313,sr.xccc314,sr.xccc901,sr.xccc902,sr.xccc903,sr.xccc903a,sr.xccc903b,sr.xccc903c,sr.xccc903d,sr.xccc903e,sr.xccc903f,sr.xccc903g,sr.xccc903h,   #modify--2015/10/06 By shiun add xccc903a~h
                                sr.xccccomp,sr.xccccomp_desc,sr.xccc004,sr.xccc001,sr.xccc001_desc,sr.xccc005,sr.xcccld,sr.xcccld_desc,sr.xccc003,sr.xccc003_desc,sr.xcccent,sr.xccckey,sr.l_xccc004_s,sr.l_xccc004_e )
      #modify--2015/10/16 By shiun--(E)
      
      IF SQLCA.sqlcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'insert tmp'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF   
   END FOR
#add--2015/10/06 By shiun--(E)
END FUNCTION
# 单身填充
PRIVATE FUNCTION axcq530_b_fill_2(p_wc2)
DEFINE p_wc2      STRING
#DEFINE l_xccc1021_sum   LIKE xccc_t.xccc102
#DEFINE l_xccc2021_sum   LIKE xccc_t.xccc202
#DEFINE l_xccc3021_sum   LIKE xccc_t.xccc302
#DEFINE l_xccc9021_sum   LIKE xccc_t.xccc902
#DEFINE l_xccc9031_sum   LIKE xccc_t.xccc903
#DEFINE l_xccc1022_sum   LIKE xccc_t.xccc102
#DEFINE l_xccc2022_sum   LIKE xccc_t.xccc202
#DEFINE l_xccc2042_sum   LIKE xccc_t.xccc204
#DEFINE l_xccc2062_sum   LIKE xccc_t.xccc206
#DEFINE l_xccc2082_sum   LIKE xccc_t.xccc208
#DEFINE l_xccc2102_sum   LIKE xccc_t.xccc210
#DEFINE l_xccc2122_sum   LIKE xccc_t.xccc212
#DEFINE l_xccc2142_sum   LIKE xccc_t.xccc214
#DEFINE l_xccc2162_sum   LIKE xccc_t.xccc216
#DEFINE l_xccc2182_sum   LIKE xccc_t.xccc218
#DEFINE l_xccc3022_sum   LIKE xccc_t.xccc302
#DEFINE l_xccc3042_sum   LIKE xccc_t.xccc304
#DEFINE l_xccc3062_sum   LIKE xccc_t.xccc306
#DEFINE l_xccc3082_sum   LIKE xccc_t.xccc308
#DEFINE l_xccc3102_sum   LIKE xccc_t.xccc310
#DEFINE l_xccc3122_sum   LIKE xccc_t.xccc312
#DEFINE l_xccc3142_sum   LIKE xccc_t.xccc314
#DEFINE l_xccc9022_sum   LIKE xccc_t.xccc902
#DEFINE l_xccc9032_sum   LIKE xccc_t.xccc903
#
#DEFINE l_xccc1021_total   LIKE xccc_t.xccc102
#DEFINE l_xccc2021_total   LIKE xccc_t.xccc202
#DEFINE l_xccc3021_total   LIKE xccc_t.xccc302
#DEFINE l_xccc9021_total   LIKE xccc_t.xccc902
#DEFINE l_xccc9031_total   LIKE xccc_t.xccc903
#DEFINE l_xccc1022_total   LIKE xccc_t.xccc102
#DEFINE l_xccc2022_total   LIKE xccc_t.xccc202
#DEFINE l_xccc2042_total   LIKE xccc_t.xccc204
#DEFINE l_xccc2062_total   LIKE xccc_t.xccc206
#DEFINE l_xccc2082_total   LIKE xccc_t.xccc208
#DEFINE l_xccc2102_total   LIKE xccc_t.xccc210
#DEFINE l_xccc2122_total   LIKE xccc_t.xccc212
#DEFINE l_xccc2142_total   LIKE xccc_t.xccc214
#DEFINE l_xccc2162_total   LIKE xccc_t.xccc216
#DEFINE l_xccc2182_total   LIKE xccc_t.xccc218
#DEFINE l_xccc3022_total   LIKE xccc_t.xccc302
#DEFINE l_xccc3042_total   LIKE xccc_t.xccc304
#DEFINE l_xccc3062_total   LIKE xccc_t.xccc306
#DEFINE l_xccc3082_total   LIKE xccc_t.xccc308
#DEFINE l_xccc3102_total   LIKE xccc_t.xccc310
#DEFINE l_xccc3122_total   LIKE xccc_t.xccc312
#DEFINE l_xccc3142_total   LIKE xccc_t.xccc314
#DEFINE l_xccc9022_total   LIKE xccc_t.xccc902
#DEFINE l_xccc9032_total   LIKE xccc_t.xccc903
#DEFINE l_sql1,l_sql2,l_sql3       STRING
#
#   LET g_sql = "SELECT  UNIQUE t1.imag011,xccc002,xccc006,xccc007,xccc008,t6.inadsite,t6.inad010,xccc101,xccc102,
#       (xccc201+xccc203+xccc205+xccc207+xccc209+xccc211+xccc213+xccc215+xccc217),
#       (xccc202+xccc204+xccc206+xccc208+xccc210+xccc212+xccc214+xccc216+xccc218),
#       (xccc301+xccc303+xccc305+xccc307+xccc309+xccc311+xccc313),
#       (xccc302+xccc304+xccc306+xccc308+xccc310+xccc312+xccc314),xccc901,xccc902,xccc903,
#       t1.imag011,xccc002,xccc006,xccc007,xccc008,t6.inadsite,t6.inad010,xccc101,xccc102,xccc201,
#       xccc202,xccc211,xccc212,xccc213,
#       xccc214,xccc215,xccc216,xccc303,xccc304,xccc305,xccc306,xccc307,
#       xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903",
#      " FROM xccc_t"
#
#   LET l_sql1 = NULL
#   LET l_sql2 = NULL
#   LET l_sql3 = NULL
#   LET l_sql1 = " ,(SELECT MIN(inadsite),MIN(inad010),inad001,inad002,inad003 FROM inad_t WHERE inadent = xcccent AND inad001 = xccc006 AND inad002 = xccc007 AND inad003 = xccc008 AND ",g_wc3," GROUP BY inad001,inad002,inad003) t6"
#   LET l_sql2 = " AND xccc006 = t6.inad001 AND xccc007 = t6.inad002 AND xccc008 = t6.inad003 "
#
#   LET l_sql3 = " LEFT OUTER JOIN imag_t t1 ON t1.imagent = '"||g_enterprise||"' AND t1.imagsite = '"||g_xccc_m.xccccomp||"' AND t1.imag001 = xccc006 ",
#                " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=?"
#
#   IF g_wc3 <> " 1=1" AND NOT cl_null(g_wc3) THEN
#      LET g_sql = g_sql,l_sql1,l_sql3,l_sql2
#   ELSE
#      LET g_sql = s_chr_replace(g_sql,"t6.inadsite","''",0)
#      LET g_sql = s_chr_replace(g_sql,"t6.inad010","''",0)
#      LET g_sql = g_sql,l_sql3
#   END IF
#
#   IF NOT cl_null(g_wc2_table1) THEN
#      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
#   END IF
#
#   #判斷是否填充
#   IF axcq530_fill_chk(1) THEN
#      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
#         LET g_sql = g_sql, " ORDER BY t1.imag011,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"
#
#         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#         LET g_sql_tmp = g_sql    
#         PREPARE axcq530_pb2 FROM g_sql
#         DECLARE b_fill_cs2 CURSOR FOR axcq530_pb2
#      END IF
#
#      LET g_cnt = l_ac
#      LET l_ac = 1
#
#      LET l_xccc1021_sum = 0
#      LET l_xccc2021_sum = 0
#      LET l_xccc3021_sum = 0
#      LET l_xccc9021_sum = 0
#      LET l_xccc9031_sum = 0
#      LET l_xccc1022_sum = 0
#      LET l_xccc2022_sum = 0
#      LET l_xccc2042_sum = 0
#      LET l_xccc2062_sum = 0
#      LET l_xccc2082_sum = 0
#      LET l_xccc2102_sum = 0
#      LET l_xccc2122_sum = 0
#      LET l_xccc2142_sum = 0
#      LET l_xccc2162_sum = 0
#      LET l_xccc2182_sum = 0
#      LET l_xccc3022_sum = 0
#      LET l_xccc3042_sum = 0
#      LET l_xccc3062_sum = 0
#      LET l_xccc3082_sum = 0
#      LET l_xccc3102_sum = 0
#      LET l_xccc3122_sum = 0
#      LET l_xccc3142_sum = 0
#      LET l_xccc9022_sum = 0
#      LET l_xccc9032_sum = 0
#
#      LET l_xccc1021_total = 0
#      LET l_xccc2021_total = 0
#      LET l_xccc3021_total = 0
#      LET l_xccc9021_total = 0
#      LET l_xccc9031_total = 0
#      LET l_xccc1022_total = 0
#      LET l_xccc2022_total = 0
#      LET l_xccc2042_total = 0
#      LET l_xccc2062_total = 0
#      LET l_xccc2082_total = 0
#      LET l_xccc2102_total = 0
#      LET l_xccc2122_total = 0
#      LET l_xccc2142_total = 0
#      LET l_xccc2162_total = 0
#      LET l_xccc2182_total = 0
#      LET l_xccc3022_total = 0
#      LET l_xccc3042_total = 0
#      LET l_xccc3062_total = 0
#      LET l_xccc3082_total = 0
#      LET l_xccc3102_total = 0
#      LET l_xccc3122_total = 0
#      LET l_xccc3142_total = 0
#      LET l_xccc9022_total = 0
#      LET l_xccc9032_total = 0
#
#      OPEN b_fill_cs2 USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005
#
#      FOREACH b_fill_cs2 INTO g_xccc3_d[l_ac].imag011,g_xccc3_d[l_ac].xccc002,g_xccc3_d[l_ac].xccc006,g_xccc3_d[l_ac].xccc007,
#                              g_xccc3_d[l_ac].xccc008,g_xccc3_d[l_ac].inadsite,g_xccc3_d[l_ac].inad010,g_xccc3_d[l_ac].xccc101,
#                              g_xccc3_d[l_ac].xccc102,g_xccc3_d[l_ac].xccc201,g_xccc3_d[l_ac].xccc202,g_xccc3_d[l_ac].xccc301,
#                              g_xccc3_d[l_ac].xccc302,g_xccc3_d[l_ac].xccc901,g_xccc3_d[l_ac].xccc902,g_xccc3_d[l_ac].xccc903,
#                              g_xccc4_d[l_ac].imag011,g_xccc4_d[l_ac].xccc002,g_xccc4_d[l_ac].xccc006,g_xccc4_d[l_ac].xccc007,
#                              g_xccc4_d[l_ac].xccc008,g_xccc4_d[l_ac].inadsite,g_xccc4_d[l_ac].inad010,g_xccc4_d[l_ac].xccc101,
#                              g_xccc4_d[l_ac].xccc102,g_xccc4_d[l_ac].xccc201,g_xccc4_d[l_ac].xccc202,g_xccc4_d[l_ac].xccc211,
#                              g_xccc4_d[l_ac].xccc212,g_xccc4_d[l_ac].xccc213,g_xccc4_d[l_ac].xccc214,g_xccc4_d[l_ac].xccc215,
#                              g_xccc4_d[l_ac].xccc216,g_xccc4_d[l_ac].xccc303,g_xccc4_d[l_ac].xccc304,g_xccc4_d[l_ac].xccc305,
#                              g_xccc4_d[l_ac].xccc306,g_xccc4_d[l_ac].xccc307,g_xccc4_d[l_ac].xccc308,g_xccc4_d[l_ac].xccc309,
#                              g_xccc4_d[l_ac].xccc310,g_xccc4_d[l_ac].xccc311,g_xccc4_d[l_ac].xccc312,g_xccc4_d[l_ac].xccc313,
#                              g_xccc4_d[l_ac].xccc314,g_xccc4_d[l_ac].xccc901,g_xccc4_d[l_ac].xccc902,g_xccc4_d[l_ac].xccc903
#
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = "FOREACH:"
#            LET g_errparam.code   = SQLCA.sqlcode
#            LET g_errparam.popup  = TRUE
#            CALL cl_err()
#            EXIT FOREACH
#         END IF
#         #期初單位成本
#         LET g_xccc3_d[l_ac].l_unit_3 = g_xccc3_d[l_ac].xccc102/g_xccc3_d[l_ac].xccc101
#         LET g_xccc4_d[l_ac].l_unit_4 = g_xccc4_d[l_ac].xccc102/g_xccc4_d[l_ac].xccc101
#        #
#         #帶出公用欄位reference值
#         LET g_xccc3_d[l_ac].inadsite_3_desc = s_desc_get_department_desc(g_xccc3_d[l_ac].inadsite)
#         LET g_xccc4_d[l_ac].inadsite_4_desc = s_desc_get_department_desc(g_xccc4_d[l_ac].inadsite)
#         LET g_xccc3_d[l_ac].inad010_3_desc = s_desc_get_trading_partner_full_desc(g_xccc3_d[l_ac].inad010)
#         LET g_xccc4_d[l_ac].inad010_4_desc = s_desc_get_trading_partner_full_desc(g_xccc4_d[l_ac].inad010)
#
#         #合计
#         LET l_xccc1021_total = l_xccc1021_total + g_xccc3_d[l_ac].xccc102
#         LET l_xccc2021_total = l_xccc2021_total + g_xccc3_d[l_ac].xccc202
#         LET l_xccc3021_total = l_xccc3021_total + g_xccc3_d[l_ac].xccc302
#         LET l_xccc9021_total = l_xccc9021_total + g_xccc3_d[l_ac].xccc902
#         LET l_xccc9031_total = l_xccc9031_total + g_xccc3_d[l_ac].xccc903
#         LET l_xccc1022_total = l_xccc1022_total + g_xccc4_d[l_ac].xccc102
#         LET l_xccc2022_total = l_xccc2022_total + g_xccc4_d[l_ac].xccc202
#         LET l_xccc2122_total = l_xccc2122_total + g_xccc4_d[l_ac].xccc212
#         LET l_xccc2142_total = l_xccc2142_total + g_xccc4_d[l_ac].xccc214
#         LET l_xccc2162_total = l_xccc2162_total + g_xccc4_d[l_ac].xccc216
#         LET l_xccc3042_total = l_xccc3042_total + g_xccc4_d[l_ac].xccc304
#         LET l_xccc3062_total = l_xccc3062_total + g_xccc4_d[l_ac].xccc306
#         LET l_xccc3082_total = l_xccc3082_total + g_xccc4_d[l_ac].xccc308
#         LET l_xccc3102_total = l_xccc3102_total + g_xccc4_d[l_ac].xccc310
#         LET l_xccc3122_total = l_xccc3122_total + g_xccc4_d[l_ac].xccc312
#         LET l_xccc3142_total = l_xccc3142_total + g_xccc4_d[l_ac].xccc314
#         LET l_xccc9022_total = l_xccc9022_total + g_xccc4_d[l_ac].xccc902
#         LET l_xccc9032_total = l_xccc9032_total + g_xccc4_d[l_ac].xccc903
#         #按成本分群 小计
#         LET l_xccc1021_sum = l_xccc1021_sum + g_xccc3_d[l_ac].xccc102
#         LET l_xccc2021_sum = l_xccc2021_sum + g_xccc3_d[l_ac].xccc202
#         LET l_xccc3021_sum = l_xccc3021_sum + g_xccc3_d[l_ac].xccc302
#         LET l_xccc9021_sum = l_xccc9021_sum + g_xccc3_d[l_ac].xccc902
#         LET l_xccc9031_sum = l_xccc9031_sum + g_xccc3_d[l_ac].xccc903
#         LET l_xccc1022_sum = l_xccc1022_sum + g_xccc4_d[l_ac].xccc102
#         LET l_xccc2022_sum = l_xccc2022_sum + g_xccc4_d[l_ac].xccc202
#         LET l_xccc2122_sum = l_xccc2122_sum + g_xccc4_d[l_ac].xccc212
#         LET l_xccc2142_sum = l_xccc2142_sum + g_xccc4_d[l_ac].xccc214
#         LET l_xccc2162_sum = l_xccc2162_sum + g_xccc4_d[l_ac].xccc216
#         LET l_xccc3042_sum = l_xccc3042_sum + g_xccc4_d[l_ac].xccc304
#         LET l_xccc3062_sum = l_xccc3062_sum + g_xccc4_d[l_ac].xccc306
#         LET l_xccc3082_sum = l_xccc3082_sum + g_xccc4_d[l_ac].xccc308
#         LET l_xccc3102_sum = l_xccc3102_sum + g_xccc4_d[l_ac].xccc310
#         LET l_xccc3122_sum = l_xccc3122_sum + g_xccc4_d[l_ac].xccc312
#         LET l_xccc3142_sum = l_xccc3142_sum + g_xccc4_d[l_ac].xccc314
#         LET l_xccc9022_sum = l_xccc9022_sum + g_xccc4_d[l_ac].xccc902
#         LET l_xccc9032_sum = l_xccc9032_sum + g_xccc4_d[l_ac].xccc903
#         IF l_ac > 1 THEN
#            IF cl_null(g_xccc3_d[l_ac].imag011) THEN LET g_xccc3_d[l_ac].imag011 = ' ' END IF
#            IF g_xccc3_d[l_ac].imag011 != g_xccc3_d[l_ac - 1].imag011 THEN
#               LET g_xccc3_d[l_ac + 1].* = g_xccc3_d[l_ac].*
#               LET g_xccc4_d[l_ac + 1].* = g_xccc4_d[l_ac].*
#               INITIALIZE  g_xccc3_d[l_ac].* TO NULL
#               INITIALIZE  g_xccc4_d[l_ac].* TO NULL
#               LET g_xccc3_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)
#               LET g_xccc4_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)
#               LET g_xccc3_d[l_ac].xccc102 = l_xccc1021_sum - g_xccc3_d[l_ac + 1].xccc102
#               LET g_xccc3_d[l_ac].xccc202 = l_xccc2021_sum - g_xccc3_d[l_ac + 1].xccc202
#               LET g_xccc3_d[l_ac].xccc302 = l_xccc3021_sum - g_xccc3_d[l_ac + 1].xccc302
#               LET g_xccc3_d[l_ac].xccc902 = l_xccc9021_sum - g_xccc3_d[l_ac + 1].xccc902
#               LET g_xccc3_d[l_ac].xccc903 = l_xccc9031_sum - g_xccc3_d[l_ac + 1].xccc903
#               LET g_xccc4_d[l_ac].xccc102= l_xccc1022_sum - g_xccc4_d[l_ac+ 1].xccc102
#               LET g_xccc4_d[l_ac].xccc202= l_xccc2022_sum - g_xccc4_d[l_ac+ 1].xccc202
#               LET g_xccc4_d[l_ac].xccc212= l_xccc2122_sum - g_xccc4_d[l_ac+ 1].xccc212
#               LET g_xccc4_d[l_ac].xccc214= l_xccc2142_sum - g_xccc4_d[l_ac+ 1].xccc214
#               LET g_xccc4_d[l_ac].xccc216= l_xccc2162_sum - g_xccc4_d[l_ac+ 1].xccc216
#               LET g_xccc4_d[l_ac].xccc304= l_xccc3042_sum - g_xccc4_d[l_ac+ 1].xccc304
#               LET g_xccc4_d[l_ac].xccc306= l_xccc3062_sum - g_xccc4_d[l_ac+ 1].xccc306
#               LET g_xccc4_d[l_ac].xccc308= l_xccc3082_sum - g_xccc4_d[l_ac+ 1].xccc308
#               LET g_xccc4_d[l_ac].xccc310= l_xccc3102_sum - g_xccc4_d[l_ac+ 1].xccc310
#               LET g_xccc4_d[l_ac].xccc312= l_xccc3122_sum - g_xccc4_d[l_ac+ 1].xccc312
#               LET g_xccc4_d[l_ac].xccc314= l_xccc3142_sum - g_xccc4_d[l_ac+ 1].xccc314
#               LET g_xccc4_d[l_ac].xccc902= l_xccc9022_sum - g_xccc4_d[l_ac+ 1].xccc902
#               LET g_xccc4_d[l_ac].xccc903= l_xccc9032_sum - g_xccc4_d[l_ac+ 1].xccc903
#               LET l_ac = l_ac + 1
#               LET l_xccc1021_sum = g_xccc3_d[l_ac].xccc102
#               LET l_xccc2021_sum = g_xccc3_d[l_ac].xccc202
#               LET l_xccc3021_sum = g_xccc3_d[l_ac].xccc302
#               LET l_xccc9021_sum = g_xccc3_d[l_ac].xccc902
#               LET l_xccc9031_sum = g_xccc3_d[l_ac].xccc903
#               LET l_xccc1022_sum = g_xccc4_d[l_ac].xccc102
#               LET l_xccc2022_sum = g_xccc4_d[l_ac].xccc202
#               LET l_xccc2122_sum = g_xccc4_d[l_ac].xccc212
#               LET l_xccc2142_sum = g_xccc4_d[l_ac].xccc214
#               LET l_xccc2162_sum = g_xccc4_d[l_ac].xccc216
#               LET l_xccc3042_sum = g_xccc4_d[l_ac].xccc304
#               LET l_xccc3062_sum = g_xccc4_d[l_ac].xccc306
#               LET l_xccc3082_sum = g_xccc4_d[l_ac].xccc308
#               LET l_xccc3102_sum = g_xccc4_d[l_ac].xccc310
#               LET l_xccc3122_sum = g_xccc4_d[l_ac].xccc312
#               LET l_xccc3142_sum = g_xccc4_d[l_ac].xccc314
#               LET l_xccc9022_sum = g_xccc4_d[l_ac].xccc902
#               LET l_xccc9032_sum = g_xccc4_d[l_ac].xccc903
#            END IF
#         END IF
#
#         IF l_ac > g_max_rec THEN
#            IF g_error_show = 1 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = l_ac
#               LET g_errparam.code   = 9035
#               LET g_errparam.popup  = TRUE
#               CALL cl_err()
#            END IF
#            EXIT FOREACH
#         END IF
#
#         LET l_ac = l_ac + 1
#
#      END FOREACH
#
#   END IF
#
#   IF l_ac > 1 THEN
#      #最后一组小计
#      LET g_xccc3_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)
#      LET g_xccc4_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)
#      LET g_xccc3_d[l_ac].xccc102  = l_xccc1021_sum
#      LET g_xccc3_d[l_ac].xccc202  = l_xccc2021_sum
#      LET g_xccc3_d[l_ac].xccc302  = l_xccc3021_sum
#      LET g_xccc3_d[l_ac].xccc902  = l_xccc9021_sum
#      LET g_xccc3_d[l_ac].xccc903  = l_xccc9031_sum
#      LET g_xccc4_d[l_ac].xccc102 = l_xccc1022_sum
#      LET g_xccc4_d[l_ac].xccc202 = l_xccc2022_sum
#      LET g_xccc4_d[l_ac].xccc212 = l_xccc2122_sum
#      LET g_xccc4_d[l_ac].xccc214 = l_xccc2142_sum
#      LET g_xccc4_d[l_ac].xccc216 = l_xccc2162_sum
#      LET g_xccc4_d[l_ac].xccc304 = l_xccc3042_sum
#      LET g_xccc4_d[l_ac].xccc306 = l_xccc3062_sum
#      LET g_xccc4_d[l_ac].xccc308 = l_xccc3082_sum
#      LET g_xccc4_d[l_ac].xccc310 = l_xccc3102_sum
#      LET g_xccc4_d[l_ac].xccc312 = l_xccc3122_sum
#      LET g_xccc4_d[l_ac].xccc314 = l_xccc3142_sum
#      LET g_xccc4_d[l_ac].xccc902 = l_xccc9022_sum
#      LET g_xccc4_d[l_ac].xccc903 = l_xccc9032_sum
#      LET l_ac = l_ac + 1
#      #合计
#      LET g_xccc3_d[l_ac].imag011 = cl_getmsg("axc-00204",g_lang)
#      LET g_xccc4_d[l_ac].imag011 = cl_getmsg("axc-00204",g_lang)
#      LET g_xccc3_d[l_ac].xccc102  = l_xccc1021_total
#      LET g_xccc3_d[l_ac].xccc202  = l_xccc2021_total
#      LET g_xccc3_d[l_ac].xccc302  = l_xccc3021_total
#      LET g_xccc3_d[l_ac].xccc902  = l_xccc9021_total
#      LET g_xccc3_d[l_ac].xccc903  = l_xccc9031_total
#      LET g_xccc4_d[l_ac].xccc102 = l_xccc1022_total
#      LET g_xccc4_d[l_ac].xccc202 = l_xccc2022_total
#      LET g_xccc4_d[l_ac].xccc212 = l_xccc2122_total
#      LET g_xccc4_d[l_ac].xccc214 = l_xccc2142_total
#      LET g_xccc4_d[l_ac].xccc216 = l_xccc2162_total
#      LET g_xccc4_d[l_ac].xccc304 = l_xccc3042_total
#      LET g_xccc4_d[l_ac].xccc306 = l_xccc3062_total
#      LET g_xccc4_d[l_ac].xccc308 = l_xccc3082_total
#      LET g_xccc4_d[l_ac].xccc310 = l_xccc3102_total
#      LET g_xccc4_d[l_ac].xccc312 = l_xccc3122_total
#      LET g_xccc4_d[l_ac].xccc314 = l_xccc3142_total
#      LET g_xccc4_d[l_ac].xccc902 = l_xccc9022_total
#      LET g_xccc4_d[l_ac].xccc903 = l_xccc9032_total
#      LET l_ac = l_ac + 1
#   END IF
#
#   FREE axcq530_pb2
END FUNCTION

################################################################################
# Descriptions...: 另起临时表，不与报表临时表通用
# Memo...........: 为跨年期查询
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 150812 By fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq530_ins_temp_1()
DEFINE l_merge_qc      STRING
DEFINE l_merge_qm      STRING
DEFINE l_merge_xccc280 STRING
#add--2015/10/07 By shiun--(S)
DEFINE l_xccc004_max   LIKE xccc_t.xccc004
DEFINE l_xccc005_max   LIKE xccc_t.xccc005
DEFINE l_max           LIKE xccc_t.xccc004
DEFINE l_sql_xccc006   STRING 
DEFINE l_xccc002       LIKE xccc_t.xccc002
DEFINE l_xccc006       LIKE xccc_t.xccc006
DEFINE l_xccc007       LIKE xccc_t.xccc007
DEFINE l_xccc008       LIKE xccc_t.xccc008
DEFINE l_xccc901       LIKE xccc_t.xccc901
DEFINE l_xccc902       LIKE xccc_t.xccc902
#add--2015/10/07 By shiun--(E)
DEFINE l_wc2          STRING    #151130-00002#1--add

   DELETE FROM axcq530_tmp1

  #151130-00002#1--add--(s)
   LET l_wc2 = g_wc2.trim()
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
      LET g_sql =   " INSERT INTO axcq530_tmp1 ",
                    " SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,0,0,SUM(xccc201),",         
                    "               SUM(xccc202),SUM(xccc203),SUM(xccc204),SUM(xccc205),SUM(xccc206),SUM(xccc207),SUM(xccc208),SUM(xccc209),SUM(xccc210),SUM(xccc211),SUM(xccc212),SUM(xccc213),", 
                    "               SUM(xccc214),SUM(xccc215),SUM(xccc216),SUM(xccc217),SUM(xccc218),SUM(xccc301),SUM(xccc302),SUM(xccc303),SUM(xccc304),SUM(xccc305),SUM(xccc306),SUM(xccc307),", 
                    "               SUM(xccc308),SUM(xccc309),SUM(xccc310),SUM(xccc311),SUM(xccc312),SUM(xccc313),SUM(xccc314),0,0,SUM(xccc903),",
                    "               0,0,0,0,0,0,0,0,0 ",
                    "  FROM xccc_t LEFT OUTER JOIN imag_t ON imagent = xcccent AND imagsite = xccccomp AND imag001 = xccc006 ",
                    " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? "," AND ",g_wc ," AND ",l_wc2 CLIPPED,
                    "  GROUP BY xccc002,xccc006,xccc007,xccc008 "  
   ELSE
  #-151130-00002#1--add--(e) 
      LET g_sql =   " INSERT INTO axcq530_tmp1 ",
                    " SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,0,0,SUM(xccc201),",         
                    "               SUM(xccc202),SUM(xccc203),SUM(xccc204),SUM(xccc205),SUM(xccc206),SUM(xccc207),SUM(xccc208),SUM(xccc209),SUM(xccc210),SUM(xccc211),SUM(xccc212),SUM(xccc213),", 
                    "               SUM(xccc214),SUM(xccc215),SUM(xccc216),SUM(xccc217),SUM(xccc218),SUM(xccc301),SUM(xccc302),SUM(xccc303),SUM(xccc304),SUM(xccc305),SUM(xccc306),SUM(xccc307),", 
                    "               SUM(xccc308),SUM(xccc309),SUM(xccc310),SUM(xccc311),SUM(xccc312),SUM(xccc313),SUM(xccc314),0,0,SUM(xccc903),",
                    "               0,0,0,0,0,0,0,0,0 FROM xccc_t ",
                    " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? "," AND ",g_wc CLIPPED,
                    "  GROUP BY xccc002,xccc006,xccc007,xccc008 "               
   END IF           #151130-00002#1--add              

   PREPARE axcq530_ins_tmp FROM g_sql
   EXECUTE axcq530_ins_tmp USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg('','','INS axcq503_tmp1',SQLCA.sqlcode,1)
      RETURN
   END IF
   #modify--2015/10/06 By shiun--(S)
   #160811-00013#1---mark---s
   #IF g_mm1 = 1 THEN
   #   LET l_merge_qc =                  
   #       " MERGE INTO axcq530_tmp1 t0 ",
   #       "      USING (SELECT xccc002,xccc006,xccc007,xccc008,xccc101,xccc102 ", #151013-00019#7 remark
   #      #"      USING (SELECT xccc002,xccc006,xccc007,xccc008,xccc901,xccc902 ", #modify--2015/10/08 By shiun #151013-00019#7 mark
   #       "               FROM xccc_t ",
   #       "              WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? 
   #                        AND xccc004 = '",g_yy1 - 1,"' AND xccc005 = '12' ) tqc",          
   #       "      ON ( t0.xccc002 = tqc.xccc002 AND t0.xccc006 = tqc.xccc006
   #                  AND t0.xccc007 = tqc.xccc007 AND t0.xccc008 = tqc.xccc008 ) ",
   #       "    WHEN MATCHED THEN ",
   #       #modify--2015/10/08 By shiun--(S)
   #       " UPDATE SET t0.xccc101 = tqc.xccc101,",  #151013-00019#7 remark
   #       "            t0.xccc102 = tqc.xccc102 "   #151013-00019#7 remark
   #      #" UPDATE SET t0.xccc101 = tqc.xccc901,",  #151013-00019#7 mark
   #      #"            t0.xccc102 = tqc.xccc902 "   #151013-00019#7 mark
   #       #modify--2015/10/08 By shiun--(E)
   #ELSE
   #160811-00013#1---mark---e
      LET l_merge_qc =                  
          " MERGE INTO axcq530_tmp1 t0 ",
          "      USING (SELECT xccc002,xccc006,xccc007,xccc008,xccc101,xccc102 ", #151013-00019#7 remark
         #"      USING (SELECT xccc002,xccc006,xccc007,xccc008,xccc901,xccc902 ", #modify--2015/10/08 By shiun #151013-00019#7 mark
          "               FROM xccc_t ",
          "              WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? 
                           AND xccc004 = '",g_yy1,"' AND xccc005 = '",g_mm1,"' ) tqc",
          "      ON ( t0.xccc002 = tqc.xccc002 AND t0.xccc006 = tqc.xccc006
                     AND t0.xccc007 = tqc.xccc007 AND t0.xccc008 = tqc.xccc008 ) ",
          "    WHEN MATCHED THEN ",
          #modify--2015/10/08 By shiun--(S)
          " UPDATE SET t0.xccc101 = tqc.xccc101,",  #151013-00019#7 remark
          "            t0.xccc102 = tqc.xccc102 "   #151013-00019#7 remark
         #" UPDATE SET t0.xccc101 = tqc.xccc901,",  #151013-00019#7 mark
         #"            t0.xccc102 = tqc.xccc902 "   #151013-00019#7 mark
          #modify--2015/10/08 By shiun--(E)
   #END IF    #160811-00013#1---mark
   #modify--2015/10/06 By shiun--(E)
   PREPARE axcq530_merge_qc FROM l_merge_qc
   EXECUTE axcq530_merge_qc USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003
   
   #modify--2015/10/08 By shiun--(S)
   LET l_sql_xccc006 = " SELECT xccc002,xccc006,xccc007,xccc008 FROM axcq530_tmp1 "
   PREPARE axcq530_xccc006_prepare  FROM l_sql_xccc006
   DECLARE axcq530_xccc006_curs CURSOR FOR axcq530_xccc006_prepare 
   FOREACH axcq530_xccc006_curs INTO l_xccc002,l_xccc006,l_xccc007,l_xccc008
      #取最後年度期別
#      SELECT MAX(xccc004*12+xccc005) INTO l_max
#        FROM axcq530_tmp1
#       WHERE xcccent = g_enterprise
#         AND xcccld = g_xccc_m.xcccld
#         AND xccc001 = g_xccc_m.xccc001
#         AND xccc002 = l_xccc002
#         AND xccc003 = g_xccc_m.xccc003
#         AND xccc006 = l_xccc006
#         AND xccc007 = l_xccc007
#         AND xccc008 = l_xccc008

      SELECT MAX(xccc004) INTO l_xccc004_max
        FROM xccc_t
       WHERE xcccent = g_enterprise
         AND xcccld = g_xccc_m.xcccld
         AND xccc001 = g_xccc_m.xccc001
         AND xccc002 = l_xccc002
         AND xccc003 = g_xccc_m.xccc003
         AND xccc006 = l_xccc006
         AND xccc007 = l_xccc007
         AND xccc008 = l_xccc008

      SELECT MAX(xccc005) INTO l_xccc005_max
        FROM xccc_t
       WHERE xcccent = g_enterprise
         AND xcccld = g_xccc_m.xcccld
         AND xccc001 = g_xccc_m.xccc001
         AND xccc002 = l_xccc002
         AND xccc003 = g_xccc_m.xccc003
         AND xccc006 = l_xccc006
         AND xccc007 = l_xccc007
         AND xccc008 = l_xccc008
         AND xccc004 = l_xccc004_max
         
#      SELECT xccc004,xccc005 INTO l_xccc004_max,l_xccc005_max
#        FROM axcq530_tmp1
#       WHERE xcccent = g_enterprise
#         AND xcccld = g_xccc_m.xcccld
#         AND xccc001 = g_xccc_m.xccc001
#         AND xccc002 = l_xccc002
#         AND xccc003 = g_xccc_m.xccc003
#         AND xccc006 = l_xccc006
#         AND xccc007 = l_xccc007
#         AND xccc008 = l_xccc008
#         AND (xccc004 * 12 + xccc005) = l_max
      
      SELECT xccc901,xccc902 INTO l_xccc901,l_xccc902
        FROM xccc_t
       WHERE xcccent = g_enterprise
         AND xcccld = g_xccc_m.xcccld
         AND xccc001 = g_xccc_m.xccc001
         AND xccc002 = l_xccc002
         AND xccc003 = g_xccc_m.xccc003
        #AND xccc004 = l_xccc004_max    #160819-00026#1 mark
        #AND xccc005 = l_xccc005_max    #160819-00026#1 mark
         AND xccc004 = g_yy2            #160819-00026#1 add
         AND xccc005 = g_mm2            #160819-00026#1 add         
         AND xccc006 = l_xccc006
         AND xccc007 = l_xccc007
         AND xccc008 = l_xccc008
      
      
      LET l_merge_qm =                  
          " MERGE INTO axcq530_tmp1 t0 ",
          "      USING (SELECT xccc002,xccc006,xccc007,xccc008,xccc901,xccc902 ", 
          "               FROM xccc_t ",
          "              WHERE xcccent = ? AND xcccld = ? AND xccc001 = ? AND xccc002 = ? AND xccc003 = ? 
                           AND xccc004 = ? AND xccc005 = ? AND xccc006 = ? AND xccc007 = ? AND xccc008 = ? ) tqm",          
          "      ON ( t0.xccc002 = tqm.xccc002  AND t0.xccc006 = tqm.xccc006
                     AND t0.xccc007 = tqm.xccc007 AND t0.xccc008 = tqm.xccc008 ) ",
          "    WHEN MATCHED THEN ",
          " UPDATE SET t0.xccc901 = tqm.xccc901,",      
          "            t0.xccc902 = tqm.xccc902 "
      PREPARE axcq530_merge_qm FROM l_merge_qm
      EXECUTE axcq530_merge_qm USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,l_xccc002,g_xccc_m.xccc003,
#                                     l_xccc004_max,l_xccc005_max,l_xccc006,l_xccc007,l_xccc008  #160802-00011#1 mark
                                      g_yy2,g_mm2,l_xccc006,l_xccc007,l_xccc008  #160802-00011#1 

   END FOREACH

   #modify--2015/10/08 By shiun--(E)
   IF g_yy1 = g_yy2 AND g_mm1 = g_mm2 THEN
      LET l_merge_xccc280 =                  
          " MERGE INTO axcq530_tmp1 t0 ",
          "      USING (SELECT xccc002,xccc006,xccc007,xccc008,xccc280,",
          "               xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h ",   
          "               FROM xccc_t ",
          "              WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? 
                           AND xccc004 = '",g_yy2,"' AND xccc005 = '",g_mm2,"' ) t280",          
          "      ON ( t0.xccc002 = t280.xccc002 AND t0.xccc006 = t280.xccc006
                     AND t0.xccc007 = t280.xccc007 AND t0.xccc008 = t280.xccc008 ) ",
          "    WHEN MATCHED THEN ",
          " UPDATE SET t0.xccc280  = t280.xccc280 ,",      
          "            t0.xccc280a = t280.xccc280a,",
          "            t0.xccc280b = t280.xccc280b,",
          "            t0.xccc280c = t280.xccc280c,",
          "            t0.xccc280d = t280.xccc280d,",
          "            t0.xccc280e = t280.xccc280e,",
          "            t0.xccc280f = t280.xccc280f,",
          "            t0.xccc280g = t280.xccc280g,",
          "            t0.xccc280h = t280.xccc280h "
      PREPARE axcq530_merge_xccc280 FROM l_merge_xccc280
      EXECUTE axcq530_merge_xccc280 USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003
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
PRIVATE FUNCTION axcq530_create_temp_1()
DROP TABLE axcq530_tmp1;
 CREATE TEMP TABLE axcq530_tmp1(
#   #add--2015/10/06 By shiun--(S)
#   xccc004         LIKE xccc_t.xccc004, 
#   xccc005         LIKE xccc_t.xccc005, 
#   #add--2015/10/06 By shiun--(E) 
   xccc002    VARCHAR(30),
   xccc006    VARCHAR(40),
   xccc007    VARCHAR(256), 
   xccc008    VARCHAR(30),
   xccc101    DECIMAL(20,6),
   xccc102    DECIMAL(20,6),
   xccc201    DECIMAL(20,6),
   xccc202    DECIMAL(20,6),
   xccc203    DECIMAL(20,6),
   xccc204    DECIMAL(20,6),
   xccc205    DECIMAL(20,6),
   xccc206    DECIMAL(20,6),
   xccc207    DECIMAL(20,6),
   xccc208    DECIMAL(20,6),
   xccc209    DECIMAL(20,6),
   xccc210    DECIMAL(20,6),
   xccc211    DECIMAL(20,6),
   xccc212    DECIMAL(20,6),
   xccc213    DECIMAL(20,6),
   xccc214    DECIMAL(20,6),
   xccc215    DECIMAL(20,6),
   xccc216    DECIMAL(20,6),
   xccc217    DECIMAL(20,6),
   xccc218    DECIMAL(20,6),
   xccc301    DECIMAL(20,6),
   xccc302    DECIMAL(20,6),
   xccc303    DECIMAL(20,6),
   xccc304    DECIMAL(20,6),
   xccc305    DECIMAL(20,6),
   xccc306    DECIMAL(20,6),
   xccc307    DECIMAL(20,6),
   xccc308    DECIMAL(20,6),
   xccc309    DECIMAL(20,6),
   xccc310    DECIMAL(20,6),
   xccc311    DECIMAL(20,6),
   xccc312    DECIMAL(20,6),
   xccc313    DECIMAL(20,6),
   xccc314    DECIMAL(20,6),
   xccc901    DECIMAL(20,6),
   xccc902    DECIMAL(20,6),
   xccc903    DECIMAL(20,6),
#   #add--2015/10/06 By shiun--(S)
#   xccc903a   LIKE xccc_t.xccc903a,
#   xccc903b   LIKE xccc_t.xccc903b,
#   xccc903c   LIKE xccc_t.xccc903c,
#   xccc903d   LIKE xccc_t.xccc903d,
#   xccc903e   LIKE xccc_t.xccc903e,
#   xccc903f   LIKE xccc_t.xccc903f,
#   xccc903g   LIKE xccc_t.xccc903g,
#   xccc903h   LIKE xccc_t.xccc903h,
#   #add--2015/10/06 By shiun--(E)
   xccc280    DECIMAL(20,6), 
   xccc280a   DECIMAL(20,6),    
   xccc280b   DECIMAL(20,6),    
   xccc280c   DECIMAL(20,6),    
   xccc280d   DECIMAL(20,6),    
   xccc280e   DECIMAL(20,6),    
   xccc280f   DECIMAL(20,6),    
   xccc280g   DECIMAL(20,6),    
   xccc280h   DECIMAL(20,6)
 );
END FUNCTION
#單身g_xccc2_d填充
PRIVATE FUNCTION axcq530_b_fill_3(p_wc2)
DEFINE p_wc2              STRING
DEFINE l_xccc1012_sum     LIKE xccc_t.xccc101 #dorislai-20151104-add
DEFINE l_unit_22_sum      LIKE type_t.num20_6 #dorislai-20151104-add
DEFINE l_xccc1022_sum     LIKE xccc_t.xccc102
DEFINE l_xccc2012_sum     LIKE xccc_t.xccc201 #dorislai-20151104-add
DEFINE l_xccc2022_sum     LIKE xccc_t.xccc202
DEFINE l_xccc2032_sum     LIKE xccc_t.xccc203 #dorislai-20151104-add
DEFINE l_xccc2042_sum     LIKE xccc_t.xccc204
DEFINE l_xccc2052_sum     LIKE xccc_t.xccc205 #dorislai-20151104-add
DEFINE l_xccc2062_sum     LIKE xccc_t.xccc206
DEFINE l_xccc2072_sum     LIKE xccc_t.xccc207 #dorislai-20151104-add
DEFINE l_xccc2082_sum     LIKE xccc_t.xccc208
DEFINE l_xccc2092_sum     LIKE xccc_t.xccc209 #dorislai-20151104-add
DEFINE l_xccc2102_sum     LIKE xccc_t.xccc210
DEFINE l_xccc2112_sum     LIKE xccc_t.xccc211 #dorislai-20151104-add
DEFINE l_xccc2122_sum     LIKE xccc_t.xccc212
DEFINE l_xccc2132_sum     LIKE xccc_t.xccc213 #dorislai-20151104-add
DEFINE l_xccc2142_sum     LIKE xccc_t.xccc214
DEFINE l_xccc2152_sum     LIKE xccc_t.xccc215 #dorislai-20151104-add
DEFINE l_xccc2162_sum     LIKE xccc_t.xccc216
DEFINE l_xccc2172_sum     LIKE xccc_t.xccc217 #dorislai-20151104-add
DEFINE l_xccc2182_sum     LIKE xccc_t.xccc218
DEFINE l_xccc3012_sum     LIKE xccc_t.xccc301 #dorislai-20151104-add
DEFINE l_xccc3022_sum     LIKE xccc_t.xccc302
DEFINE l_xccc3032_sum     LIKE xccc_t.xccc303 #dorislai-20151104-add
DEFINE l_xccc3042_sum     LIKE xccc_t.xccc304
DEFINE l_xccc3052_sum     LIKE xccc_t.xccc305 #dorislai-20151104-add
DEFINE l_xccc3062_sum     LIKE xccc_t.xccc306
DEFINE l_xccc3072_sum     LIKE xccc_t.xccc307 #dorislai-20151104-add
DEFINE l_xccc3082_sum     LIKE xccc_t.xccc308
DEFINE l_xccc3092_sum     LIKE xccc_t.xccc309 #dorislai-20151104-add
DEFINE l_xccc3102_sum     LIKE xccc_t.xccc310
DEFINE l_xccc3112_sum     LIKE xccc_t.xccc311 #dorislai-20151104-add
DEFINE l_xccc3122_sum     LIKE xccc_t.xccc312
DEFINE l_xccc3132_sum     LIKE xccc_t.xccc313 #dorislai-20151104-add
DEFINE l_xccc3142_sum     LIKE xccc_t.xccc314
DEFINE l_xccc9012_sum     LIKE xccc_t.xccc901 #dorislai-20151104-add
DEFINE l_xccc9022_sum     LIKE xccc_t.xccc902 
DEFINE l_xccc9032_sum     LIKE xccc_t.xccc903
DEFINE l_xccc903a2_sum    LIKE xccc_t.xccc903a
DEFINE l_xccc903b2_sum    LIKE xccc_t.xccc903b
DEFINE l_xccc903c2_sum    LIKE xccc_t.xccc903c
DEFINE l_xccc903d2_sum    LIKE xccc_t.xccc903d
DEFINE l_xccc903e2_sum    LIKE xccc_t.xccc903e
DEFINE l_xccc903f2_sum    LIKE xccc_t.xccc903f
DEFINE l_xccc903g2_sum    LIKE xccc_t.xccc903g
DEFINE l_xccc903h2_sum    LIKE xccc_t.xccc903h
DEFINE l_xccc1012_total   LIKE xccc_t.xccc101 #dorislai-20151104-add
DEFINE l_unit_22_total    LIKE type_t.num20_6 #dorislai-20151104-add
DEFINE l_xccc1022_total   LIKE xccc_t.xccc102
DEFINE l_xccc2012_total   LIKE xccc_t.xccc201 #dorislai-20151104-add
DEFINE l_xccc2022_total   LIKE xccc_t.xccc202
DEFINE l_xccc2032_total   LIKE xccc_t.xccc203 #dorislai-20151104-add
DEFINE l_xccc2042_total   LIKE xccc_t.xccc204
DEFINE l_xccc2052_total   LIKE xccc_t.xccc205 #dorislai-20151104-add
DEFINE l_xccc2062_total   LIKE xccc_t.xccc206
DEFINE l_xccc2072_total   LIKE xccc_t.xccc207 #dorislai-20151104-add
DEFINE l_xccc2082_total   LIKE xccc_t.xccc208
DEFINE l_xccc2092_total   LIKE xccc_t.xccc209 #dorislai-20151104-add
DEFINE l_xccc2102_total   LIKE xccc_t.xccc210
DEFINE l_xccc2112_total   LIKE xccc_t.xccc211 #dorislai-20151104-add
DEFINE l_xccc2122_total   LIKE xccc_t.xccc212
DEFINE l_xccc2132_total   LIKE xccc_t.xccc213 #dorislai-20151104-add
DEFINE l_xccc2142_total   LIKE xccc_t.xccc214
DEFINE l_xccc2152_total   LIKE xccc_t.xccc215 #dorislai-20151104-add
DEFINE l_xccc2162_total   LIKE xccc_t.xccc216
DEFINE l_xccc2172_total   LIKE xccc_t.xccc217 #dorislai-20151104-add
DEFINE l_xccc2182_total   LIKE xccc_t.xccc218
DEFINE l_xccc3012_total   LIKE xccc_t.xccc301 #dorislai-20151104-add
DEFINE l_xccc3022_total   LIKE xccc_t.xccc302
DEFINE l_xccc3032_total   LIKE xccc_t.xccc303 #dorislai-20151104-add
DEFINE l_xccc3042_total   LIKE xccc_t.xccc304
DEFINE l_xccc3052_total   LIKE xccc_t.xccc305 #dorislai-20151104-add
DEFINE l_xccc3062_total   LIKE xccc_t.xccc306
DEFINE l_xccc3072_total   LIKE xccc_t.xccc307 #dorislai-20151104-add
DEFINE l_xccc3082_total   LIKE xccc_t.xccc308
DEFINE l_xccc3092_total   LIKE xccc_t.xccc309 #dorislai-20151104-add
DEFINE l_xccc3102_total   LIKE xccc_t.xccc310
DEFINE l_xccc3112_total   LIKE xccc_t.xccc311 #dorislai-20151104-add
DEFINE l_xccc3122_total   LIKE xccc_t.xccc312
DEFINE l_xccc3132_total   LIKE xccc_t.xccc313 #dorislai-20151104-add
DEFINE l_xccc3142_total   LIKE xccc_t.xccc314
DEFINE l_xccc9012_total   LIKE xccc_t.xccc901 #dorislai-20151104-add
DEFINE l_xccc9022_total   LIKE xccc_t.xccc902 
DEFINE l_xccc9032_total   LIKE xccc_t.xccc903 
DEFINE l_xccc903a2_total  LIKE xccc_t.xccc903a
DEFINE l_xccc903b2_total  LIKE xccc_t.xccc903b
DEFINE l_xccc903c2_total  LIKE xccc_t.xccc903c
DEFINE l_xccc903d2_total  LIKE xccc_t.xccc903d
DEFINE l_xccc903e2_total  LIKE xccc_t.xccc903e
DEFINE l_xccc903f2_total  LIKE xccc_t.xccc903f
DEFINE l_xccc903g2_total  LIKE xccc_t.xccc903g
DEFINE l_xccc903h2_total  LIKE xccc_t.xccc903h
DEFINE l_sql1             STRING
DEFINE l_sql2             STRING
DEFINE l_sql3             STRING
DEFINE  l_xcat005         LIKE xcat_t.xcat005

   #160520-00003#5----s
   #LET g_sql = "SELECT  UNIQUE xccc004,xccc005,t1.imag011,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,",
   LET g_sql = "SELECT UNIQUE xccc004,xccc005,imag011,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,",
               "               xccc202,xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,", 
               "               xccc214,xccc215,xccc216,xccc217,xccc218,xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307,", 
               "               xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903,xccc903a,xccc903b,",
               "               xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,xcbfl003,",
               "               imaal003 ,imaal004 ,",
               "              (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=imag011 AND oocql003='"||g_dlang||"') oocql004 , ",
               "              xcbb005 ",
               "  FROM ( ",
               "        SELECT UNIQUE xccc004,xccc005,",
               "               (SELECT imag011 FROM imag_t WHERE imagent = '"||g_enterprise||"' AND imagsite = '"||g_xccc_m.xccccomp||"' AND imag001 = xccc006 ) imag011, ",
               "               xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,",
   #160520-00003#5----e
               "               xccc202,xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211,xccc212,xccc213,", 
               "               xccc214,xccc215,xccc216,xccc217,xccc218,xccc301,xccc302,xccc303,xccc304,xccc305,xccc306,xccc307,", 
               "               xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314,xccc901,xccc902,xccc903,xccc903a,xccc903b,",
               "               xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,xccc903h,",
               #160520-00003#5----s
               #"               t2.xcbfl003,",
               #"               t3.imaal003 ,t3.imaal004 ",
               "               (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp= '"||g_xccc_m.xccccomp||"' AND xcbfl001=xccc002 AND xcbfl002='"||g_dlang||"') xcbfl003 ,",
               "               (SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ) imaal003, " , 
               "               (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xccc006 AND imaal002='"||g_dlang||"' ) imaal004, " ,
               "               (SELECT xcbb005 FROM xcbb_t WHERE xcbbent='"||g_enterprise||"' AND xcbbcomp='"||g_xccc_m.xccccomp||"' AND xcbb001 = xccc004 AND xcbb002 = xccc005 AND xcbb003 = xccc006 AND xcbb004 = xccc007) xcbb005 ",
               #160520-00003#5----e
               "      FROM xccc_t",
               #160520-00003#5----s
               #"    LEFT OUTER JOIN imag_t t1 ON t1.imagent = '"||g_enterprise||"' AND t1.imagsite = '"||g_xccc_m.xccccomp||"' AND t1.imag001 = xccc_t.xccc006 ",               
               #"    LEFT OUTER JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xccc_t.xccc002 AND t2.xcbfl002='"||g_dlang||"' ",
               #"    LEFT OUTER JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xccc_t.xccc006 AND t3.imaal002='"||g_dlang||"' ",
               #160520-00003#5----e
               "    WHERE xcccent='"||g_enterprise||"' AND ",g_wc  #170224-00017#1

   LET l_sql1 = NULL
   LET l_xcat005 = NULL
   SELECT xcat005 INTO l_xcat005    #l_xcat005 =3表示是批次成本，单身填充时要去找出门店和供应商
     FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xccc_m.xccc003
   IF l_xcat005 = '3' THEN   
      LET l_sql1 = " SELECT MIN(inadsite),MIN(inad010) FROM inad_t ",
                   "  WHERE inadent = ? ",
                   "    AND inad001 = ? ",
                   "    AND inad002 = ? ",
                   "    AND inad003 = ? ",
                   "    AND ",g_wc3,
                   "  GROUP BY inadent,inad001,inad002,inad003"
                   
      PREPARE axcq530_inad_2 FROM l_sql1
                   
   END IF
#wujie 150604 --end

   IF NOT cl_null(g_wc2_table1) THEN
     #LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t") 
  #151130-00003#1--add--(s) 
      IF NOT cl_null(g_wc_filter) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc_filter CLIPPED
      END IF    
   ELSE
      IF NOT cl_null(g_wc_filter) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc_filter CLIPPED
      END IF  
  #151130-00003#1--add--(e)      
   END IF
   
   LET g_sql = g_sql CLIPPED , " ) "  #160520-00003#5
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq530_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         #LET g_sql = g_sql, " ORDER BY t1.imag011,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc004,xccc_t.xccc005,xccc_t.xccc008"  #160520-00003#5
         LET g_sql = g_sql, " ORDER BY imag011,xccc006,xccc007,xccc004,xccc005,xccc008"  #160520-00003#5
         #add-point:b_fill段fill_before
#         LET g_sql = s_chr_replace(g_sql,"xccc_t","t0",0)
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         LET g_sql_tmp = g_sql    #wujie 150611
         PREPARE axcq530_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR axcq530_pb3
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      LET l_xccc1012_sum = 0 #dorislai-20151104-add  
      LET l_unit_22_sum = 0  #dorislai-20151104-add  
      LET l_xccc1022_sum = 0  
      LET l_xccc2012_sum = 0 #dorislai-20151104-add  
      LET l_xccc2022_sum = 0  
      LET l_xccc2032_sum = 0 #dorislai-20151104-add  
      LET l_xccc2042_sum = 0  
      LET l_xccc2052_sum = 0 #dorislai-20151104-add  
      LET l_xccc2062_sum = 0  
      LET l_xccc2072_sum = 0 #dorislai-20151104-add  
      LET l_xccc2082_sum = 0  
      LET l_xccc2092_sum = 0 #dorislai-20151104-add  
      LET l_xccc2102_sum = 0  
      LET l_xccc2112_sum = 0 #dorislai-20151104-add  
      LET l_xccc2122_sum = 0  
      LET l_xccc2132_sum = 0 #dorislai-20151104-add  
      LET l_xccc2142_sum = 0  
      LET l_xccc2152_sum = 0 #dorislai-20151104-add  
      LET l_xccc2162_sum = 0  
      LET l_xccc2172_sum = 0 #dorislai-20151104-add  
      LET l_xccc2182_sum = 0  
      LET l_xccc3012_sum = 0 #dorislai-20151104-add  
      LET l_xccc3022_sum = 0  
      LET l_xccc3032_sum = 0 #dorislai-20151104-add  
      LET l_xccc3042_sum = 0  
      LET l_xccc3052_sum = 0 #dorislai-20151104-add  
      LET l_xccc3062_sum = 0  
      LET l_xccc3072_sum = 0 #dorislai-20151104-add  
      LET l_xccc3082_sum = 0  
      LET l_xccc3092_sum = 0 #dorislai-20151104-add  
      LET l_xccc3102_sum = 0  
      LET l_xccc3112_sum = 0 #dorislai-20151104-add  
      LET l_xccc3122_sum = 0  
      LET l_xccc3132_sum = 0 #dorislai-20151104-add  
      LET l_xccc3142_sum = 0  
      LET l_xccc9012_sum = 0 #dorislai-20151104-add  
      LET l_xccc9022_sum = 0  
      LET l_xccc9032_sum = 0  
      LET l_xccc903a2_sum = 0
      LET l_xccc903b2_sum = 0
      LET l_xccc903c2_sum = 0
      LET l_xccc903d2_sum = 0
      LET l_xccc903e2_sum = 0
      LET l_xccc903f2_sum = 0
      LET l_xccc903g2_sum = 0
      LET l_xccc903h2_sum = 0
      
      LET l_xccc1012_total = 0 #dorislai-20151104-add
      LET l_unit_22_total = 0  #dorislai-20151104-add
      LET l_xccc1022_total = 0
      LET l_xccc2012_total = 0 #dorislai-20151104-add
      LET l_xccc2022_total = 0
      LET l_xccc2032_total = 0 #dorislai-20151104-add
      LET l_xccc2042_total = 0
      LET l_xccc2052_total = 0 #dorislai-20151104-add
      LET l_xccc2062_total = 0
      LET l_xccc2072_total = 0 #dorislai-20151104-add
      LET l_xccc2082_total = 0
      LET l_xccc2092_total = 0 #dorislai-20151104-add
      LET l_xccc2102_total = 0
      LET l_xccc2112_total = 0 #dorislai-20151104-add
      LET l_xccc2122_total = 0
      LET l_xccc2132_total = 0 #dorislai-20151104-add
      LET l_xccc2142_total = 0
      LET l_xccc2152_total = 0 #dorislai-20151104-add
      LET l_xccc2162_total = 0
      LET l_xccc2172_total = 0 #dorislai-20151104-add
      LET l_xccc2182_total = 0
      LET l_xccc3012_total = 0 #dorislai-20151104-add
      LET l_xccc3022_total = 0
      LET l_xccc3032_total = 0 #dorislai-20151104-add
      LET l_xccc3042_total = 0
      LET l_xccc3052_total = 0 #dorislai-20151104-add
      LET l_xccc3062_total = 0
      LET l_xccc3072_total = 0 #dorislai-20151104-add
      LET l_xccc3082_total = 0
      LET l_xccc3092_total = 0 #dorislai-20151104-add
      LET l_xccc3102_total = 0
      LET l_xccc3112_total = 0 #dorislai-20151104-add
      LET l_xccc3122_total = 0
      LET l_xccc3132_total = 0 #dorislai-20151104-add
      LET l_xccc3142_total = 0
      LET l_xccc9012_total = 0 #dorislai-20151104-add
      LET l_xccc9022_total = 0
      LET l_xccc9032_total = 0
      LET l_xccc903a2_total = 0
      LET l_xccc903b2_total = 0
      LET l_xccc903c2_total = 0
      LET l_xccc903d2_total = 0
      LET l_xccc903e2_total = 0
      LET l_xccc903f2_total = 0
      LET l_xccc903g2_total = 0
      LET l_xccc903h2_total = 0
      #add--2015/10/
      OPEN b_fill_cs3  #fengmy150812 
     
      FOREACH b_fill_cs3 INTO g_xccc2_d[l_ac].xccc004,g_xccc2_d[l_ac].xccc005,
          g_xccc2_d[l_ac].imag011,g_xccc2_d[l_ac].xccc002,g_xccc2_d[l_ac].xccc006, 
          g_xccc2_d[l_ac].xccc007,g_xccc2_d[l_ac].xccc008,g_xccc2_d[l_ac].xccc101,g_xccc2_d[l_ac].xccc102,       
          g_xccc2_d[l_ac].xccc201,g_xccc2_d[l_ac].xccc202,g_xccc2_d[l_ac].xccc203,g_xccc2_d[l_ac].xccc204, 
          g_xccc2_d[l_ac].xccc205,g_xccc2_d[l_ac].xccc206,g_xccc2_d[l_ac].xccc207,g_xccc2_d[l_ac].xccc208, 
          g_xccc2_d[l_ac].xccc209,g_xccc2_d[l_ac].xccc210,g_xccc2_d[l_ac].xccc211,g_xccc2_d[l_ac].xccc212, 
          g_xccc2_d[l_ac].xccc213,g_xccc2_d[l_ac].xccc214,g_xccc2_d[l_ac].xccc215,g_xccc2_d[l_ac].xccc216, 
          g_xccc2_d[l_ac].xccc217,g_xccc2_d[l_ac].xccc218,g_xccc2_d[l_ac].xccc301,g_xccc2_d[l_ac].xccc302, 
          g_xccc2_d[l_ac].xccc303,g_xccc2_d[l_ac].xccc304,g_xccc2_d[l_ac].xccc305,g_xccc2_d[l_ac].xccc306, 
          g_xccc2_d[l_ac].xccc307,g_xccc2_d[l_ac].xccc308,g_xccc2_d[l_ac].xccc309,g_xccc2_d[l_ac].xccc310, 
          g_xccc2_d[l_ac].xccc311,g_xccc2_d[l_ac].xccc312,g_xccc2_d[l_ac].xccc313,g_xccc2_d[l_ac].xccc314, 
          g_xccc2_d[l_ac].xccc901,g_xccc2_d[l_ac].xccc902,g_xccc2_d[l_ac].xccc903,
          g_xccc2_d[l_ac].xccc903a,g_xccc2_d[l_ac].xccc903b,g_xccc2_d[l_ac].xccc903c,g_xccc2_d[l_ac].xccc903d,
          g_xccc2_d[l_ac].xccc903e,g_xccc2_d[l_ac].xccc903f,g_xccc2_d[l_ac].xccc903g,g_xccc2_d[l_ac].xccc903h,
          g_xccc2_d[l_ac].xccc002_2_desc,g_xccc2_d[l_ac].xccc006_2_desc,g_xccc2_d[l_ac].xccc006_2_desc_desc,
          g_xccc2_d[l_ac].imag011_2_desc,g_xccc2_d[l_ac].xcbb005   #160520-00003#5

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         
         #160520-00003#5----s
         #INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
         #LET g_ref_fields[1] = g_xccc2_d[l_ac].imag011                                                                                                                        
         #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         #LET g_xccc2_d[l_ac].imag011_2_desc = '', g_rtn_fields[1] , ''  
         #DISPLAY BY NAME g_xccc2_d[l_ac].imag011_2_desc   
         #
         ##成本單位取axci120
         #SELECT xcbb005 INTO g_xccc2_d[l_ac].xcbb005 FROM xcbb_t
         # WHERE xcbbent  = g_enterprise
         #   AND xcbbcomp = g_xccc_m.xccccomp
         #   AND xcbb001  = g_xccc2_d[l_ac].xccc004
         #   AND xcbb002  = g_xccc2_d[l_ac].xccc005
         #   AND xcbb003  = g_xccc2_d[l_ac].xccc006
         #160520-00003#5---e   
         
         #期初單位成本

         LET g_xccc2_d[l_ac].l_unit_2 = g_xccc2_d[l_ac].xccc102/g_xccc2_d[l_ac].xccc101   #mark--2015/10/07 By shiun

         IF cl_null(g_xccc2_d[l_ac].l_unit_2) THEN LET g_xccc2_d[l_ac].l_unit_2 = 0 END IF   #mark--2015/10/07 By shiun

      
         #帶出公用欄位reference值
#wujie 150604 --begin
         IF l_xcat005 = '3' THEN
            EXECUTE axcq530_inad_2 INTO g_xccc2_d[l_ac].inadsite,g_xccc2_d[l_ac].inad010 USING g_enterprise,g_xccc2_d[l_ac].xccc006,g_xccc2_d[l_ac].xccc007,g_xccc2_d[l_ac].xccc008
            IF g_xccc2_d[l_ac].inadsite IS NULL AND g_xccc2_d[l_ac].inad010 IS NULL THEN
               CONTINUE FOREACH
            END IF
            LET g_xccc2_d[l_ac].inadsite_2_desc = s_desc_get_department_desc(g_xccc2_d[l_ac].inadsite)
            LET g_xccc2_d[l_ac].inad010_2_desc = s_desc_get_trading_partner_full_desc(g_xccc2_d[l_ac].inad010)
         END IF

         #合计
         LET l_xccc1012_total = l_xccc1012_total + g_xccc2_d[l_ac].xccc101 #dorislai-20151104-add
         LET l_unit_22_total = l_unit_22_total + g_xccc2_d[l_ac].l_unit_2  #dorislai-20151104-add
         LET l_xccc1022_total = l_xccc1022_total + g_xccc2_d[l_ac].xccc102
         LET l_xccc2012_total = l_xccc2012_total + g_xccc2_d[l_ac].xccc201 #dorislai-20151104-add
         LET l_xccc2022_total = l_xccc2022_total + g_xccc2_d[l_ac].xccc202
         LET l_xccc2032_total = l_xccc2032_total + g_xccc2_d[l_ac].xccc203 #dorislai-20151104-add
         LET l_xccc2042_total = l_xccc2042_total + g_xccc2_d[l_ac].xccc204
         LET l_xccc2052_total = l_xccc2052_total + g_xccc2_d[l_ac].xccc205 #dorislai-20151104-add
         LET l_xccc2062_total = l_xccc2062_total + g_xccc2_d[l_ac].xccc206
         LET l_xccc2072_total = l_xccc2072_total + g_xccc2_d[l_ac].xccc207 #dorislai-20151104-add
         LET l_xccc2082_total = l_xccc2082_total + g_xccc2_d[l_ac].xccc208
         LET l_xccc2092_total = l_xccc2092_total + g_xccc2_d[l_ac].xccc209 #dorislai-20151104-add
         LET l_xccc2102_total = l_xccc2102_total + g_xccc2_d[l_ac].xccc210
         LET l_xccc2112_total = l_xccc2112_total + g_xccc2_d[l_ac].xccc211 #dorislai-20151104-add
         LET l_xccc2122_total = l_xccc2122_total + g_xccc2_d[l_ac].xccc212
         LET l_xccc2132_total = l_xccc2132_total + g_xccc2_d[l_ac].xccc213 #dorislai-20151104-add
         LET l_xccc2142_total = l_xccc2142_total + g_xccc2_d[l_ac].xccc214
         LET l_xccc2152_total = l_xccc2152_total + g_xccc2_d[l_ac].xccc215 #dorislai-20151104-add
         LET l_xccc2162_total = l_xccc2162_total + g_xccc2_d[l_ac].xccc216
         LET l_xccc2172_total = l_xccc2172_total + g_xccc2_d[l_ac].xccc217 #dorislai-20151104-add
         LET l_xccc2182_total = l_xccc2182_total + g_xccc2_d[l_ac].xccc218
         LET l_xccc3012_total = l_xccc3012_total + g_xccc2_d[l_ac].xccc301 #dorislai-20151104-add
         LET l_xccc3022_total = l_xccc3022_total + g_xccc2_d[l_ac].xccc302
         LET l_xccc3032_total = l_xccc3032_total + g_xccc2_d[l_ac].xccc303 #dorislai-20151104-add
         LET l_xccc3042_total = l_xccc3042_total + g_xccc2_d[l_ac].xccc304
         LET l_xccc3052_total = l_xccc3052_total + g_xccc2_d[l_ac].xccc305 #dorislai-20151104-add
         LET l_xccc3062_total = l_xccc3062_total + g_xccc2_d[l_ac].xccc306
         LET l_xccc3072_total = l_xccc3072_total + g_xccc2_d[l_ac].xccc307 #dorislai-20151104-add
         LET l_xccc3082_total = l_xccc3082_total + g_xccc2_d[l_ac].xccc308
         LET l_xccc3092_total = l_xccc3092_total + g_xccc2_d[l_ac].xccc309 #dorislai-20151104-add
         LET l_xccc3102_total = l_xccc3102_total + g_xccc2_d[l_ac].xccc310
         LET l_xccc3112_total = l_xccc3112_total + g_xccc2_d[l_ac].xccc311 #dorislai-20151104-add
         LET l_xccc3122_total = l_xccc3122_total + g_xccc2_d[l_ac].xccc312
         LET l_xccc3132_total = l_xccc3132_total + g_xccc2_d[l_ac].xccc313 #dorislai-20151104-add
         LET l_xccc3142_total = l_xccc3142_total + g_xccc2_d[l_ac].xccc314
         LET l_xccc9012_total = l_xccc9012_total + g_xccc2_d[l_ac].xccc901 #dorislai-20151104-add
         LET l_xccc9022_total = l_xccc9022_total + g_xccc2_d[l_ac].xccc902
         LET l_xccc9032_total = l_xccc9032_total + g_xccc2_d[l_ac].xccc903
         LET l_xccc903a2_total = l_xccc903a2_total + g_xccc2_d[l_ac].xccc903a
         LET l_xccc903b2_total = l_xccc903b2_total + g_xccc2_d[l_ac].xccc903b
         LET l_xccc903c2_total = l_xccc903c2_total + g_xccc2_d[l_ac].xccc903c
         LET l_xccc903d2_total = l_xccc903d2_total + g_xccc2_d[l_ac].xccc903d
         LET l_xccc903e2_total = l_xccc903e2_total + g_xccc2_d[l_ac].xccc903e
         LET l_xccc903f2_total = l_xccc903f2_total + g_xccc2_d[l_ac].xccc903f
         LET l_xccc903g2_total = l_xccc903g2_total + g_xccc2_d[l_ac].xccc903g
         LET l_xccc903h2_total = l_xccc903h2_total + g_xccc2_d[l_ac].xccc903h
         
         LET l_xccc1012_sum = l_xccc1012_sum + g_xccc2_d[l_ac].xccc101 #dorislai-20151104-add
         LET l_unit_22_sum = l_unit_22_sum + g_xccc2_d[l_ac].l_unit_2  #dorislai-20151104-add
         LET l_xccc1022_sum = l_xccc1022_sum + g_xccc2_d[l_ac].xccc102
         LET l_xccc2012_sum = l_xccc2012_sum + g_xccc2_d[l_ac].xccc201 #dorislai-20151104-add
         LET l_xccc2022_sum = l_xccc2022_sum + g_xccc2_d[l_ac].xccc202
         LET l_xccc2032_sum = l_xccc2032_sum + g_xccc2_d[l_ac].xccc203 #dorislai-20151104-add
         LET l_xccc2042_sum = l_xccc2042_sum + g_xccc2_d[l_ac].xccc204
         LET l_xccc2052_sum = l_xccc2052_sum + g_xccc2_d[l_ac].xccc205 #dorislai-20151104-add
         LET l_xccc2062_sum = l_xccc2062_sum + g_xccc2_d[l_ac].xccc206
         LET l_xccc2072_sum = l_xccc2072_sum + g_xccc2_d[l_ac].xccc207 #dorislai-20151104-add
         LET l_xccc2082_sum = l_xccc2082_sum + g_xccc2_d[l_ac].xccc208
         LET l_xccc2092_sum = l_xccc2092_sum + g_xccc2_d[l_ac].xccc209 #dorislai-20151104-add
         LET l_xccc2102_sum = l_xccc2102_sum + g_xccc2_d[l_ac].xccc210
         LET l_xccc2112_sum = l_xccc2112_sum + g_xccc2_d[l_ac].xccc211 #dorislai-20151104-add
         LET l_xccc2122_sum = l_xccc2122_sum + g_xccc2_d[l_ac].xccc212
         LET l_xccc2132_sum = l_xccc2132_sum + g_xccc2_d[l_ac].xccc213 #dorislai-20151104-add
         LET l_xccc2142_sum = l_xccc2142_sum + g_xccc2_d[l_ac].xccc214
         LET l_xccc2152_sum = l_xccc2152_sum + g_xccc2_d[l_ac].xccc215 #dorislai-20151104-add
         LET l_xccc2162_sum = l_xccc2162_sum + g_xccc2_d[l_ac].xccc216
         LET l_xccc2172_sum = l_xccc2172_sum + g_xccc2_d[l_ac].xccc217 #dorislai-20151104-add
         LET l_xccc2182_sum = l_xccc2182_sum + g_xccc2_d[l_ac].xccc218
         LET l_xccc3012_sum = l_xccc3012_sum + g_xccc2_d[l_ac].xccc301 #dorislai-20151104-add
         LET l_xccc3022_sum = l_xccc3022_sum + g_xccc2_d[l_ac].xccc302
         LET l_xccc3032_sum = l_xccc3032_sum + g_xccc2_d[l_ac].xccc303 #dorislai-20151104-add
         LET l_xccc3042_sum = l_xccc3042_sum + g_xccc2_d[l_ac].xccc304
         LET l_xccc3052_sum = l_xccc3052_sum + g_xccc2_d[l_ac].xccc305 #dorislai-20151104-add
         LET l_xccc3062_sum = l_xccc3062_sum + g_xccc2_d[l_ac].xccc306
         LET l_xccc3072_sum = l_xccc3072_sum + g_xccc2_d[l_ac].xccc307 #dorislai-20151104-add
         LET l_xccc3082_sum = l_xccc3082_sum + g_xccc2_d[l_ac].xccc308
         LET l_xccc3092_sum = l_xccc3092_sum + g_xccc2_d[l_ac].xccc309 #dorislai-20151104-add
         LET l_xccc3102_sum = l_xccc3102_sum + g_xccc2_d[l_ac].xccc310
         LET l_xccc3112_sum = l_xccc3112_sum + g_xccc2_d[l_ac].xccc311 #dorislai-20151104-add
         LET l_xccc3122_sum = l_xccc3122_sum + g_xccc2_d[l_ac].xccc312
         LET l_xccc3132_sum = l_xccc3132_sum + g_xccc2_d[l_ac].xccc313 #dorislai-20151104-add
         LET l_xccc3142_sum = l_xccc3142_sum + g_xccc2_d[l_ac].xccc314
         LET l_xccc9012_sum = l_xccc9012_sum + g_xccc2_d[l_ac].xccc901 #dorislai-20151104-add
         LET l_xccc9022_sum = l_xccc9022_sum + g_xccc2_d[l_ac].xccc902
         LET l_xccc9032_sum = l_xccc9032_sum + g_xccc2_d[l_ac].xccc903
         LET l_xccc903a2_sum = l_xccc903a2_sum + g_xccc2_d[l_ac].xccc903a
         LET l_xccc903b2_sum = l_xccc903b2_sum + g_xccc2_d[l_ac].xccc903b
         LET l_xccc903c2_sum = l_xccc903c2_sum + g_xccc2_d[l_ac].xccc903c
         LET l_xccc903d2_sum = l_xccc903d2_sum + g_xccc2_d[l_ac].xccc903d
         LET l_xccc903e2_sum = l_xccc903e2_sum + g_xccc2_d[l_ac].xccc903e
         LET l_xccc903f2_sum = l_xccc903f2_sum + g_xccc2_d[l_ac].xccc903f
         LET l_xccc903g2_sum = l_xccc903g2_sum + g_xccc2_d[l_ac].xccc903g
         LET l_xccc903h2_sum = l_xccc903h2_sum + g_xccc2_d[l_ac].xccc903h

         IF l_ac > 1 THEN
           #IF g_xccc2_d[l_ac].xccc006 != g_xccc2_d[l_ac - 1].xccc006 OR g_xccc2_d[l_ac].xccc007 != g_xccc2_d[l_ac - 1].xccc007 THEN #151013-00019#7 mark
            IF g_xccc2_d[l_ac].imag011 != g_xccc2_d[l_ac - 1].imag011 THEN  #151013-00019#7
               LET g_xccc2_d[l_ac + 1].* = g_xccc2_d[l_ac].*
               INITIALIZE  g_xccc2_d[l_ac].* TO NULL
               #LET g_xccc2_d[l_ac].xccc006 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
               LET g_xccc2_d[l_ac].imag011_2_desc = g_xccc2_d[l_ac-1].imag011,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie

               LET g_xccc2_d[l_ac].xccc101= l_xccc1012_sum - g_xccc2_d[l_ac+ 1].xccc101 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].l_unit_2= l_unit_22_sum - g_xccc2_d[l_ac+ 1].l_unit_2#dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc102= l_xccc1022_sum - g_xccc2_d[l_ac+ 1].xccc102
               LET g_xccc2_d[l_ac].xccc201= l_xccc2012_sum - g_xccc2_d[l_ac+ 1].xccc201 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc202= l_xccc2022_sum - g_xccc2_d[l_ac+ 1].xccc202
               LET g_xccc2_d[l_ac].xccc203= l_xccc2032_sum - g_xccc2_d[l_ac+ 1].xccc203 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc204= l_xccc2042_sum - g_xccc2_d[l_ac+ 1].xccc204
               LET g_xccc2_d[l_ac].xccc205= l_xccc2052_sum - g_xccc2_d[l_ac+ 1].xccc205 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc206= l_xccc2062_sum - g_xccc2_d[l_ac+ 1].xccc206
               LET g_xccc2_d[l_ac].xccc207= l_xccc2072_sum - g_xccc2_d[l_ac+ 1].xccc207 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc208= l_xccc2082_sum - g_xccc2_d[l_ac+ 1].xccc208
               LET g_xccc2_d[l_ac].xccc209= l_xccc2092_sum - g_xccc2_d[l_ac+ 1].xccc209 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc210= l_xccc2102_sum - g_xccc2_d[l_ac+ 1].xccc210
               LET g_xccc2_d[l_ac].xccc211= l_xccc2112_sum - g_xccc2_d[l_ac+ 1].xccc211 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc212= l_xccc2122_sum - g_xccc2_d[l_ac+ 1].xccc212
               LET g_xccc2_d[l_ac].xccc213= l_xccc2132_sum - g_xccc2_d[l_ac+ 1].xccc213 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc214= l_xccc2142_sum - g_xccc2_d[l_ac+ 1].xccc214
               LET g_xccc2_d[l_ac].xccc215= l_xccc2152_sum - g_xccc2_d[l_ac+ 1].xccc215 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc216= l_xccc2162_sum - g_xccc2_d[l_ac+ 1].xccc216
               LET g_xccc2_d[l_ac].xccc217= l_xccc2172_sum - g_xccc2_d[l_ac+ 1].xccc217 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc218= l_xccc2182_sum - g_xccc2_d[l_ac+ 1].xccc218
               LET g_xccc2_d[l_ac].xccc301= l_xccc3012_sum - g_xccc2_d[l_ac+ 1].xccc301 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc302= l_xccc3022_sum - g_xccc2_d[l_ac+ 1].xccc302
               LET g_xccc2_d[l_ac].xccc303= l_xccc3032_sum - g_xccc2_d[l_ac+ 1].xccc303 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc304= l_xccc3042_sum - g_xccc2_d[l_ac+ 1].xccc304
               LET g_xccc2_d[l_ac].xccc305= l_xccc3052_sum - g_xccc2_d[l_ac+ 1].xccc305 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc306= l_xccc3062_sum - g_xccc2_d[l_ac+ 1].xccc306
               LET g_xccc2_d[l_ac].xccc307= l_xccc3072_sum - g_xccc2_d[l_ac+ 1].xccc307 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc308= l_xccc3082_sum - g_xccc2_d[l_ac+ 1].xccc308
               LET g_xccc2_d[l_ac].xccc309= l_xccc3092_sum - g_xccc2_d[l_ac+ 1].xccc309 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc310= l_xccc3102_sum - g_xccc2_d[l_ac+ 1].xccc310
               LET g_xccc2_d[l_ac].xccc311= l_xccc3112_sum - g_xccc2_d[l_ac+ 1].xccc311 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc312= l_xccc3122_sum - g_xccc2_d[l_ac+ 1].xccc312
               LET g_xccc2_d[l_ac].xccc313= l_xccc3132_sum - g_xccc2_d[l_ac+ 1].xccc313 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc314= l_xccc3142_sum - g_xccc2_d[l_ac+ 1].xccc314
               LET g_xccc2_d[l_ac].xccc901= l_xccc9012_sum - g_xccc2_d[l_ac+ 1].xccc901 #dorislai-20151104-add
               LET g_xccc2_d[l_ac].xccc902= l_xccc9022_sum - g_xccc2_d[l_ac+ 1].xccc902
               LET g_xccc2_d[l_ac].xccc903= l_xccc9032_sum - g_xccc2_d[l_ac+ 1].xccc903
               LET g_xccc2_d[l_ac].xccc903a= l_xccc903a2_sum - g_xccc2_d[l_ac+ 1].xccc903a
               LET g_xccc2_d[l_ac].xccc903b= l_xccc903b2_sum - g_xccc2_d[l_ac+ 1].xccc903b
               LET g_xccc2_d[l_ac].xccc903c= l_xccc903c2_sum - g_xccc2_d[l_ac+ 1].xccc903c
               LET g_xccc2_d[l_ac].xccc903d= l_xccc903d2_sum - g_xccc2_d[l_ac+ 1].xccc903d
               LET g_xccc2_d[l_ac].xccc903e= l_xccc903e2_sum - g_xccc2_d[l_ac+ 1].xccc903e
               LET g_xccc2_d[l_ac].xccc903f= l_xccc903f2_sum - g_xccc2_d[l_ac+ 1].xccc903f
               LET g_xccc2_d[l_ac].xccc903g= l_xccc903g2_sum - g_xccc2_d[l_ac+ 1].xccc903g
               LET g_xccc2_d[l_ac].xccc903h= l_xccc903h2_sum - g_xccc2_d[l_ac+ 1].xccc903h

               LET l_ac = l_ac + 1
               
               LET l_xccc1012_sum = g_xccc2_d[l_ac].xccc101 #dorislai-20151104-add
               LET l_unit_22_sum = g_xccc2_d[l_ac].l_unit_2 #dorislai-20151104-add
               LET l_xccc1022_sum = g_xccc2_d[l_ac].xccc102
               LET l_xccc2012_sum = g_xccc2_d[l_ac].xccc201 #dorislai-20151104-add
               LET l_xccc2022_sum = g_xccc2_d[l_ac].xccc202
               LET l_xccc2032_sum = g_xccc2_d[l_ac].xccc203 #dorislai-20151104-add
               LET l_xccc2042_sum = g_xccc2_d[l_ac].xccc204
               LET l_xccc2052_sum = g_xccc2_d[l_ac].xccc205 #dorislai-20151104-add
               LET l_xccc2062_sum = g_xccc2_d[l_ac].xccc206
               LET l_xccc2072_sum = g_xccc2_d[l_ac].xccc207 #dorislai-20151104-add
               LET l_xccc2082_sum = g_xccc2_d[l_ac].xccc208
               LET l_xccc2092_sum = g_xccc2_d[l_ac].xccc209 #dorislai-20151104-add
               LET l_xccc2102_sum = g_xccc2_d[l_ac].xccc210
               LET l_xccc2112_sum = g_xccc2_d[l_ac].xccc211 #dorislai-20151104-add
               LET l_xccc2122_sum = g_xccc2_d[l_ac].xccc212
               LET l_xccc2132_sum = g_xccc2_d[l_ac].xccc213 #dorislai-20151104-add
               LET l_xccc2142_sum = g_xccc2_d[l_ac].xccc214
               LET l_xccc2152_sum = g_xccc2_d[l_ac].xccc215 #dorislai-20151104-add
               LET l_xccc2162_sum = g_xccc2_d[l_ac].xccc216
               LET l_xccc2172_sum = g_xccc2_d[l_ac].xccc217 #dorislai-20151104-add
               LET l_xccc2182_sum = g_xccc2_d[l_ac].xccc218
               LET l_xccc3012_sum = g_xccc2_d[l_ac].xccc301 #dorislai-20151104-add
               LET l_xccc3022_sum = g_xccc2_d[l_ac].xccc302
               LET l_xccc3032_sum = g_xccc2_d[l_ac].xccc303 #dorislai-20151104-add
               LET l_xccc3042_sum = g_xccc2_d[l_ac].xccc304
               LET l_xccc3052_sum = g_xccc2_d[l_ac].xccc305 #dorislai-20151104-add
               LET l_xccc3062_sum = g_xccc2_d[l_ac].xccc306
               LET l_xccc3072_sum = g_xccc2_d[l_ac].xccc307 #dorislai-20151104-add
               LET l_xccc3082_sum = g_xccc2_d[l_ac].xccc308
               LET l_xccc3092_sum = g_xccc2_d[l_ac].xccc309 #dorislai-20151104-add
               LET l_xccc3102_sum = g_xccc2_d[l_ac].xccc310
               LET l_xccc3112_sum = g_xccc2_d[l_ac].xccc311 #dorislai-20151104-add
               LET l_xccc3122_sum = g_xccc2_d[l_ac].xccc312
               LET l_xccc3132_sum = g_xccc2_d[l_ac].xccc313 #dorislai-20151104-add
               LET l_xccc3142_sum = g_xccc2_d[l_ac].xccc314
               LET l_xccc9012_sum = g_xccc2_d[l_ac].xccc901 #dorislai-20151104-add
               LET l_xccc9022_sum = g_xccc2_d[l_ac].xccc902
               LET l_xccc9032_sum = g_xccc2_d[l_ac].xccc903
               LET l_xccc903a2_sum = g_xccc2_d[l_ac].xccc903a
               LET l_xccc903b2_sum = g_xccc2_d[l_ac].xccc903b
               LET l_xccc903c2_sum = g_xccc2_d[l_ac].xccc903c
               LET l_xccc903d2_sum = g_xccc2_d[l_ac].xccc903d
               LET l_xccc903e2_sum = g_xccc2_d[l_ac].xccc903e
               LET l_xccc903f2_sum = g_xccc2_d[l_ac].xccc903f
               LET l_xccc903g2_sum = g_xccc2_d[l_ac].xccc903g
               LET l_xccc903h2_sum = g_xccc2_d[l_ac].xccc903h

            END IF
         END IF 
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
   END IF
   
   #add-point:b_fill段more
   IF l_ac > 1 THEN
      #最后一组小计
      #LET g_xccc2_d[l_ac].xccc006 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
      LET g_xccc2_d[l_ac].imag011_2_desc = g_xccc2_d[l_ac-1].imag011,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie
      
      LET g_xccc2_d[l_ac].xccc101 = l_xccc1012_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].l_unit_2 = l_unit_22_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc102 = l_xccc1022_sum
      LET g_xccc2_d[l_ac].xccc201 = l_xccc2012_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc202 = l_xccc2022_sum
      LET g_xccc2_d[l_ac].xccc203 = l_xccc2032_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc204 = l_xccc2042_sum
      LET g_xccc2_d[l_ac].xccc205 = l_xccc2052_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc206 = l_xccc2062_sum
      LET g_xccc2_d[l_ac].xccc207 = l_xccc2072_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc208 = l_xccc2082_sum
      LET g_xccc2_d[l_ac].xccc209 = l_xccc2092_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc210 = l_xccc2102_sum
      LET g_xccc2_d[l_ac].xccc211 = l_xccc2112_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc212 = l_xccc2122_sum
      LET g_xccc2_d[l_ac].xccc213 = l_xccc2132_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc214 = l_xccc2142_sum
      LET g_xccc2_d[l_ac].xccc215 = l_xccc2152_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc216 = l_xccc2162_sum
      LET g_xccc2_d[l_ac].xccc217 = l_xccc2172_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc218 = l_xccc2182_sum
      LET g_xccc2_d[l_ac].xccc301 = l_xccc3012_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc302 = l_xccc3022_sum
      LET g_xccc2_d[l_ac].xccc303 = l_xccc3032_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc304 = l_xccc3042_sum
      LET g_xccc2_d[l_ac].xccc305 = l_xccc3052_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc306 = l_xccc3062_sum
      LET g_xccc2_d[l_ac].xccc307 = l_xccc3072_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc308 = l_xccc3082_sum
      LET g_xccc2_d[l_ac].xccc309 = l_xccc3092_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc310 = l_xccc3102_sum
      LET g_xccc2_d[l_ac].xccc311 = l_xccc3112_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc312 = l_xccc3122_sum
      LET g_xccc2_d[l_ac].xccc313 = l_xccc3132_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc314 = l_xccc3142_sum
      LET g_xccc2_d[l_ac].xccc901 = l_xccc9012_sum #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc902 = l_xccc9022_sum
      LET g_xccc2_d[l_ac].xccc903 = l_xccc9032_sum  
      LET g_xccc2_d[l_ac].xccc903a = l_xccc903a2_sum
      LET g_xccc2_d[l_ac].xccc903b = l_xccc903b2_sum
      LET g_xccc2_d[l_ac].xccc903c = l_xccc903c2_sum
      LET g_xccc2_d[l_ac].xccc903d = l_xccc903d2_sum
      LET g_xccc2_d[l_ac].xccc903e = l_xccc903e2_sum
      LET g_xccc2_d[l_ac].xccc903f = l_xccc903f2_sum
      LET g_xccc2_d[l_ac].xccc903g = l_xccc903g2_sum
      LET g_xccc2_d[l_ac].xccc903h = l_xccc903h2_sum

      LET l_ac = l_ac + 1     
      #合计
      LET g_xccc2_d[l_ac].xccc006 = cl_getmsg("axc-00204",g_lang)

      LET g_xccc2_d[l_ac].xccc101 = l_xccc1012_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].l_unit_2 = l_unit_22_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc102 = l_xccc1022_total
      LET g_xccc2_d[l_ac].xccc201 = l_xccc2012_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc202 = l_xccc2022_total
      LET g_xccc2_d[l_ac].xccc203 = l_xccc2032_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc204 = l_xccc2042_total
      LET g_xccc2_d[l_ac].xccc205 = l_xccc2052_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc206 = l_xccc2062_total
      LET g_xccc2_d[l_ac].xccc207 = l_xccc2072_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc208 = l_xccc2082_total
      LET g_xccc2_d[l_ac].xccc209 = l_xccc2092_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc210 = l_xccc2102_total
      LET g_xccc2_d[l_ac].xccc211 = l_xccc2112_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc212 = l_xccc2122_total
      LET g_xccc2_d[l_ac].xccc213 = l_xccc2132_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc214 = l_xccc2142_total
      LET g_xccc2_d[l_ac].xccc215 = l_xccc2152_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc216 = l_xccc2162_total
      LET g_xccc2_d[l_ac].xccc217 = l_xccc2172_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc218 = l_xccc2182_total
      LET g_xccc2_d[l_ac].xccc301 = l_xccc3012_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc302 = l_xccc3022_total
      LET g_xccc2_d[l_ac].xccc303 = l_xccc3032_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc304 = l_xccc3042_total
      LET g_xccc2_d[l_ac].xccc305 = l_xccc3052_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc306 = l_xccc3062_total
      LET g_xccc2_d[l_ac].xccc307 = l_xccc3072_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc308 = l_xccc3082_total
      LET g_xccc2_d[l_ac].xccc309 = l_xccc3092_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc310 = l_xccc3102_total
      LET g_xccc2_d[l_ac].xccc311 = l_xccc3112_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc312 = l_xccc3122_total
      LET g_xccc2_d[l_ac].xccc313 = l_xccc3132_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc314 = l_xccc3142_total
      LET g_xccc2_d[l_ac].xccc901 = l_xccc9012_total #dorislai-20151104-add
      LET g_xccc2_d[l_ac].xccc902 = l_xccc9022_total
      LET g_xccc2_d[l_ac].xccc903 = l_xccc9032_total
      LET g_xccc2_d[l_ac].xccc903a = l_xccc903a2_total
      LET g_xccc2_d[l_ac].xccc903b = l_xccc903b2_total
      LET g_xccc2_d[l_ac].xccc903c = l_xccc903c2_total
      LET g_xccc2_d[l_ac].xccc903d = l_xccc903d2_total
      LET g_xccc2_d[l_ac].xccc903e = l_xccc903e2_total
      LET g_xccc2_d[l_ac].xccc903f = l_xccc903f2_total
      LET g_xccc2_d[l_ac].xccc903g = l_xccc903g2_total
      LET g_xccc2_d[l_ac].xccc903h = l_xccc903h2_total

      LET l_ac = l_ac + 1
   END IF
   #end add-point
   
 
   FREE axcq530_pb3   

END FUNCTION
################################################################################
# Descriptions...: filter過濾功能
# Memo...........:
# Usage..........: CALL axcq530_filter()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 151130 By Polly
# Modify.........: 151130-00003#1  增加二次?選功能
################################################################################
PRIVATE FUNCTION axcq530_filter()
      LET l_ac = 1
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      
      LET INT_FLAG = 0
      
      LET g_qryparam.state = 'c'
      
      #備份
      LET g_wc_filter_t = g_wc_filter        
      LET g_wc_t = g_wc   

      CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
      CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
      LET g_wc = cl_replace_str(g_wc, g_wc_filter, '') 
    

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc_filter ON imag011,xccc002,xccc006,xccc007,xccc008,xccc101,xccc102,xccc201,xccc202, 
                               xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,xccc301,xccc302, 
                               xccc901,xccc902,xccc903,xccc203,xccc204,xccc205,xccc206,xccc207,xccc208,xccc209,xccc210,xccc211, 
                               xccc212,xccc213,xccc214,xccc215,xccc216,xccc217,xccc218,xccc303,xccc304,xccc305,xccc306,xccc307, 
                               xccc308,xccc309,xccc310,xccc311,xccc312,xccc313,xccc314
          FROM s_detail1[1].imag011,s_detail1[1].xccc002,s_detail1[1].xccc006,s_detail1[1].xccc007, 
               s_detail1[1].xccc008,s_detail1[1].xccc101,s_detail1[1].xccc102,s_detail1[1].xccc201,s_detail1[1].xccc202, 
               s_detail1[1].xccc280,s_detail1[1].xccc280a,s_detail1[1].xccc280b,s_detail1[1].xccc280c, 
               s_detail1[1].xccc280d,s_detail1[1].xccc280e,s_detail1[1].xccc280f,s_detail1[1].xccc280g, 
               s_detail1[1].xccc280h,s_detail1[1].xccc301,s_detail1[1].xccc302,s_detail1[1].xccc901, 
               s_detail1[1].xccc902,s_detail1[1].xccc903,s_detail2[1].xccc203,s_detail2[1].xccc204,s_detail2[1].xccc205, 
               s_detail2[1].xccc206,s_detail2[1].xccc207,s_detail2[1].xccc208,s_detail2[1].xccc209,s_detail2[1].xccc210, 
               s_detail2[1].xccc211,s_detail2[1].xccc212,s_detail2[1].xccc213,s_detail2[1].xccc214,s_detail2[1].xccc215, 
               s_detail2[1].xccc216,s_detail2[1].xccc217,s_detail2[1].xccc218,s_detail2[1].xccc303,s_detail2[1].xccc304, 
               s_detail2[1].xccc305,s_detail2[1].xccc306,s_detail2[1].xccc307,s_detail2[1].xccc308,s_detail2[1].xccc309, 
               s_detail2[1].xccc310,s_detail2[1].xccc311,s_detail2[1].xccc312,s_detail2[1].xccc313,s_detail2[1].xccc314 

         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD imag011
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO imag011  #顯示到畫面上
            NEXT FIELD imag011                     #返回原欄位            
            
         ON ACTION controlp INFIELD xccc006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc006  #顯示到畫面上
            NEXT FIELD xccc006                     #返回原欄位 

            
         ON ACTION controlp INFIELD xccc007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd008()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc007  #顯示到畫面上
            NEXT FIELD xccc007                     #返回原欄位

            
         ON ACTION controlp INFIELD xccc008            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'F'
            CALL q_inaj010()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc008  #顯示到畫面上
            NEXT FIELD xccc008 
                                  
               
      END CONSTRUCT


      BEFORE DIALOG

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
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF

   #CALL axcq530_b_fill(g_wc2) #第一階單身填充
   #CALL axcq530_b_fill2('0')  #第二階單身填充 
   CALL axcq530_browser_fill("")
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)   
END FUNCTION
################################################################################
# Descriptions...: Browser標題欄位顯示搜尋條件
# Memo...........:
# Usage..........: axcq530_filter_show(ps_field,ps_object)
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 151130 By Polly
# Modify.........: 151130-00003#1  增加二次蒒選功能
################################################################################
PRIVATE FUNCTION axcq530_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF   
   
    #顯示資料組合
   LET ls_condition = axcq530_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
END FUNCTION
################################################################################
# Descriptions...: filter欄位解析
# Memo...........:
# Usage..........: axcq530_filter_parser(ps_field)
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 151130 By Polly
# Modify.........: 151130-00003#1  增加二次?選功能
################################################################################
PRIVATE FUNCTION axcq530_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   
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
 
