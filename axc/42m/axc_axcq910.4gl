#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq910.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-11-17 10:05:50), PR版次:0006(2016-10-20 16:02:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000084
#+ Filename...: axcq910
#+ Description: 料件成本趨勢變化
#+ Creator....: 03297(2014-10-15 15:31:05)
#+ Modifier...: 03297 -SD/PR- 02040
 
{</section>}
 
{<section id="axcq910.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#150319-00004#27   Q轉xg
#151215-00010#2  151225 By Polly 當期抓不到金額時，檢核是否有開帳期別的數據，如有則抓取開帳資料
#160727-00019#21  2016/08/4 By 08742   系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                      Mod  axcq220_xcbz_tmp   --> axcq220_tmp01
#160802-00020#9   2016/09/26  By 02097    法人:視azzi800的据點權限/帳套: 視USER的帳套權限/QBE下法人/帳套不用互相勾稽
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
PRIVATE type type_g_xccc_m        RECORD
       xccccomp LIKE xccc_t.xccccomp, 
   xccccomp_desc LIKE type_t.chr80, 
   l_yy1 LIKE type_t.num5, 
   l_mm1 LIKE type_t.num5, 
   xccc003 LIKE xccc_t.xccc003, 
   xccc003_desc LIKE type_t.chr80, 
   xcccld LIKE xccc_t.xcccld, 
   xcccld_desc LIKE type_t.chr80, 
   l_yy2 LIKE type_t.num5, 
   l_mm2 LIKE type_t.num5, 
   xccc001 LIKE xccc_t.xccc001, 
   xccc001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccc_d        RECORD
       xccc004 LIKE xccc_t.xccc004, 
   xccc005 LIKE xccc_t.xccc005, 
   xccc002 LIKE xccc_t.xccc002, 
   xccc002_desc LIKE type_t.chr500, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc006_desc LIKE type_t.chr500, 
   xccc006_desc_desc LIKE type_t.chr500, 
   xccc008 LIKE xccc_t.xccc008, 
   xccc280 LIKE xccc_t.xccc280, 
   l_xccc280_1 LIKE type_t.num20_6, 
   l_xccc280_2 LIKE type_t.num20_6, 
   l_xccc280_3 LIKE type_t.num20_6, 
   l_xccc280_4 LIKE type_t.num20_6, 
   l_xccc280_5 LIKE type_t.num20_6, 
   l_xccc280_6 LIKE type_t.num20_6, 
   l_xccc280_7 LIKE type_t.num20_6, 
   l_xccc280_8 LIKE type_t.num20_6, 
   l_xccc280_9 LIKE type_t.num20_6, 
   l_xccc280_10 LIKE type_t.num20_6, 
   l_xccc280_11 LIKE type_t.num20_6, 
   l_xccc280_12 LIKE type_t.num20_6, 
   l_xccc280_13 LIKE type_t.num20_6, 
   l_xccc280_14 LIKE type_t.num20_6, 
   l_xccc280_15 LIKE type_t.num20_6, 
   l_xccc280_16 LIKE type_t.num20_6, 
   l_xccc280_17 LIKE type_t.num20_6, 
   l_xccc280_18 LIKE type_t.num20_6, 
   l_xccc280_19 LIKE type_t.num20_6, 
   l_xccc280_20 LIKE type_t.num20_6, 
   l_xccc280_21 LIKE type_t.num20_6, 
   l_xccc280_22 LIKE type_t.num20_6, 
   l_xccc280_23 LIKE type_t.num20_6, 
   l_xccc280_24 LIKE type_t.num20_6, 
   l_xccc280_25 LIKE type_t.num20_6, 
   l_xccc280_26 LIKE type_t.num20_6, 
   l_xccc280_27 LIKE type_t.num20_6, 
   l_xccc280_28 LIKE type_t.num20_6, 
   l_xccc280_29 LIKE type_t.num20_6, 
   l_xccc280_30 LIKE type_t.num20_6, 
   l_xccc280_31 LIKE type_t.num20_6, 
   l_xccc280_32 LIKE type_t.num20_6, 
   l_xccc280_33 LIKE type_t.num20_6, 
   l_xccc280_34 LIKE type_t.num20_6, 
   l_xccc280_35 LIKE type_t.num20_6, 
   l_xccc280_36 LIKE type_t.num20_6, 
   l_xccc280_37 LIKE type_t.num20_6, 
   l_xccc280_38 LIKE type_t.num20_6, 
   l_xccc280_39 LIKE type_t.num20_6, 
   l_xccc280_40 LIKE type_t.num20_6, 
   l_xccc280_41 LIKE type_t.num20_6, 
   l_xccc280_42 LIKE type_t.num20_6, 
   l_xccc280_43 LIKE type_t.num20_6, 
   l_xccc280_44 LIKE type_t.num20_6, 
   l_xccc280_45 LIKE type_t.num20_6, 
   l_xccc280_46 LIKE type_t.num20_6, 
   l_xccc280_47 LIKE type_t.num20_6, 
   l_xccc280_48 LIKE type_t.num20_6, 
   l_xccc280_49 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_by                  STRING  #起始年
DEFINE g_bm                  STRING  #起始月
DEFINE g_ey                  STRING  #截至年
DEFINE g_em                  STRING  #截至月
DEFINE g_yy1                 LIKE type_t.num5
DEFINE g_mm1                 LIKE type_t.num5
DEFINE g_yy2                 LIKE type_t.num5
DEFINE g_mm2                 LIKE type_t.num5
DEFINE g_wc3                 STRING  #年月条件
DEFINE g_ym      DYNAMIC ARRAY OF RECORD    #单身年月  
          year  LIKE xccc_t.xccc004,
          month LIKE xccc_t.xccc005
      END RECORD
DEFINE g_para_data        LIKE type_t.chr80     #采用成本域否
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150114
DEFINE g_flag           LIKE type_t.num5
DEFINE g_xccc002        LIKE type_t.chr1
DEFINE g_xccc007        LIKE type_t.chr1
#160802-00020#9-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#9-e-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xccc_m          type_g_xccc_m
DEFINE g_xccc_m_t        type_g_xccc_m
DEFINE g_xccc_m_o        type_g_xccc_m
DEFINE g_xccc_m_mask_o   type_g_xccc_m #轉換遮罩前資料
DEFINE g_xccc_m_mask_n   type_g_xccc_m #轉換遮罩後資料
 
   DEFINE g_xccc003_t LIKE xccc_t.xccc003
DEFINE g_xcccld_t LIKE xccc_t.xcccld
DEFINE g_xccc001_t LIKE xccc_t.xccc001
 
 
DEFINE g_xccc_d          DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_xccc_d_t        type_g_xccc_d
DEFINE g_xccc_d_o        type_g_xccc_d
DEFINE g_xccc_d_mask_o   DYNAMIC ARRAY OF type_g_xccc_d #轉換遮罩前資料
DEFINE g_xccc_d_mask_n   DYNAMIC ARRAY OF type_g_xccc_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcccld LIKE xccc_t.xcccld,
      b_xccc001 LIKE xccc_t.xccc001,
      b_xccc003 LIKE xccc_t.xccc003
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
 
{<section id="axcq910.main" >}
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
   #160802-00020#9-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#9-e-add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xccccomp,'','','',xccc003,'',xcccld,'','','',xccc001,''", 
                      " FROM xccc_t",
                      " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq910_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccccomp,t0.xccc003,t0.xcccld,t0.xccc001,t1.ooefl003 ,t2.xcatl003 , 
       t3.glaal002",
               " FROM xccc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xccccomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t2 ON t2.xcatlent="||g_enterprise||" AND t2.xcatl001=t0.xccc003 AND t2.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.xcccld AND t3.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.xcccent = " ||g_enterprise|| " AND t0.xcccld = ? AND t0.xccc001 = ? AND t0.xccc003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq910_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq910 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq910_init()   
 
      #進入選單 Menu (="N")
      CALL axcq910_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq910
      
   END IF 
   
   CLOSE axcq910_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq910.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq910_init()
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
   # 栏位显示控制,先隐藏    
   CALL cl_set_comp_visible("xccc280",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_1",FALSE)
   CALL cl_set_comp_visible("l_xccc280_2",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_3",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_4",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_5",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_6",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_7",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_8",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_9",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_10",FALSE)
   CALL cl_set_comp_visible("l_xccc280_11",FALSE)
   CALL cl_set_comp_visible("l_xccc280_12",FALSE)
   CALL cl_set_comp_visible("l_xccc280_13",FALSE)
   CALL cl_set_comp_visible("l_xccc280_14",FALSE)
   CALL cl_set_comp_visible("l_xccc280_15",FALSE)
   CALL cl_set_comp_visible("l_xccc280_16",FALSE)
   CALL cl_set_comp_visible("l_xccc280_17",FALSE)
   CALL cl_set_comp_visible("l_xccc280_18",FALSE)
   CALL cl_set_comp_visible("l_xccc280_19",FALSE)
   CALL cl_set_comp_visible("l_xccc280_20",FALSE)
   CALL cl_set_comp_visible("l_xccc280_21",FALSE)
   CALL cl_set_comp_visible("l_xccc280_22",FALSE)
   CALL cl_set_comp_visible("l_xccc280_23",FALSE)
   CALL cl_set_comp_visible("l_xccc280_24",FALSE)
   CALL cl_set_comp_visible("l_xccc280_25",FALSE)
   CALL cl_set_comp_visible("l_xccc280_26",FALSE)
   CALL cl_set_comp_visible("l_xccc280_27",FALSE)
   CALL cl_set_comp_visible("l_xccc280_28",FALSE)
   CALL cl_set_comp_visible("l_xccc280_29",FALSE)
   CALL cl_set_comp_visible("l_xccc280_30",FALSE)
   CALL cl_set_comp_visible("l_xccc280_31",FALSE)
   CALL cl_set_comp_visible("l_xccc280_32",FALSE)
   CALL cl_set_comp_visible("l_xccc280_33",FALSE)
   CALL cl_set_comp_visible("l_xccc280_34",FALSE)
   CALL cl_set_comp_visible("l_xccc280_35",FALSE)
   CALL cl_set_comp_visible("l_xccc280_36",FALSE)
   CALL cl_set_comp_visible("l_xccc280_37",FALSE)
   CALL cl_set_comp_visible("l_xccc280_38",FALSE)
   CALL cl_set_comp_visible("l_xccc280_39",FALSE)
   CALL cl_set_comp_visible("l_xccc280_40",FALSE)
   CALL cl_set_comp_visible("l_xccc280_41",FALSE)
   CALL cl_set_comp_visible("l_xccc280_42",FALSE)
   CALL cl_set_comp_visible("l_xccc280_43",FALSE)
   CALL cl_set_comp_visible("l_xccc280_44",FALSE)
   CALL cl_set_comp_visible("l_xccc280_45",FALSE)
   CALL cl_set_comp_visible("l_xccc280_46",FALSE)
   CALL cl_set_comp_visible("l_xccc280_47",FALSE)
   CALL cl_set_comp_visible("l_xccc280_48",FALSE)
   CALL cl_set_comp_visible("l_xccc280_49",FALSE)
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc002,xccc002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccc002,xccc002_desc',FALSE)                
   END IF
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否 
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccc007',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xccc007',FALSE)                
   END IF      
   #end add-point
   
   CALL axcq910_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq910.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq910_ui_dialog()
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
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq910_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xccc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq910_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq910_ui_detailshow()
               
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
            CALL axcq910_browser_fill("")
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
               CALL axcq910_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq910_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq910_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq910_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq910_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq910_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq910_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq910_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq910_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq910_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq910_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq910_idx_chk()
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
               CALL axcq910_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq910_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq910_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL axcq910_x01('1=1','axcq910_tmp01',g_flag,g_xccc007,g_xccc002)    #160727-00019#21 Mod  axcq910_print_tmp--> axcq910_tmp01
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axcq910_x01('1=1','axcq910_tmp01',g_flag,g_xccc007,g_xccc002)    #160727-00019#21 Mod  axcq910_print_tmp--> axcq910_tmp01
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq910_query()
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
            CALL axcq910_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq910_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq910_set_pk_array()
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
 
{<section id="axcq910.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq910_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq910.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq910_browser_fill(ps_page_action)
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
   LET g_wc3 = g_wc3 CLIPPED," AND (xccc004*12+xccc005) BETWEEN ",g_yy1*12+g_mm1," AND ",g_yy2*12+g_mm2
   #end add-point    
 
   LET l_searchcol = "xcccld,xccc001,xccc003"
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
 
                      " FROM xccc_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcccent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
 
                      " FROM xccc_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcccent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xccc_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
                     
 
                      " FROM xccc_t ",
                      " ",
                      " ",
 
                      " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc, " AND ",g_wc3, " AND ", l_wc2, cl_sql_add_filter("xccc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
                      
 
                      " FROM xccc_t ",
                      " ",
                      " ",
                      " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, " AND ",g_wc3, cl_sql_add_filter("xccc_t")
   END IF 
   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xcccld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xccccomp IN ",g_wc_cs_comp
   END IF  
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"   
   #160802-00020#9-e-add
   
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
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcccld,t0.xccc001,t0.xccc003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcccld,t0.xccc001,t0.xccc003",
                " FROM xccc_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcccent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccc_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   LET g_sql  = "SELECT DISTINCT t0.xcccld,t0.xccc001,t0.xccc003",
                " FROM xccc_t t0",
 
                
                " WHERE t0.xcccent = '" ||g_enterprise|| "' AND ", l_wc," AND ",g_wc3," AND ",l_wc2, cl_sql_add_filter("xccc_t")
   
   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xcccld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xccccomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#9-e-add
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
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcccld,g_browser[g_cnt].b_xccc001,g_browser[g_cnt].b_xccc003  
 
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
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq910_fetch('')
   
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
 
{<section id="axcq910.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq910_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xccc_m.xcccld = g_browser[g_current_idx].b_xcccld   
   LET g_xccc_m.xccc001 = g_browser[g_current_idx].b_xccc001   
   LET g_xccc_m.xccc003 = g_browser[g_current_idx].b_xccc003   
 
   EXECUTE axcq910_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003 INTO g_xccc_m.xccccomp, 
       g_xccc_m.xccc003,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xccc003_desc, 
       g_xccc_m.xcccld_desc
   CALL axcq910_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq910_ui_detailshow()
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
 
{<section id="axcq910.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq910_ui_browser_refresh()
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
 
{<section id="axcq910.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq910_construct()
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
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccccomp,xccc003,xcccld,xccc001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axcq910_default()
            #end add-point 
            
                 #Ctrlp:construct.c.xccccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp name="construct.c.xccccomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s
            IF cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef003 = 'Y'"
            ELSE
               LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#9-e
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
            
 
 
         #Ctrlp:construct.c.xccc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="construct.c.xccc003"
            #此段落由子樣板a08產生
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
            
 
 
         #Ctrlp:construct.c.xcccld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="construct.c.xcccld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#9-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9-e-add             
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
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccc004,xccc005,xccc002,xccc006,xccc007,xccc008
           FROM s_detail1[1].xccc004,s_detail1[1].xccc005,s_detail1[1].xccc002,s_detail1[1].xccc006, 
               s_detail1[1].xccc007,s_detail1[1].xccc008
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="construct.b.page1.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="construct.a.page1.xccc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004 name="construct.c.page1.xccc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005 name="construct.b.page1.xccc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005 name="construct.a.page1.xccc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005 name="construct.c.page1.xccc005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xccc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002 name="construct.c.page1.xccc002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc002  #顯示到畫面上
            NEXT FIELD xccc002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002 name="construct.b.page1.xccc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002 name="construct.a.page1.xccc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006 name="construct.c.page1.xccc006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc006  #顯示到畫面上
            NEXT FIELD xccc006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc006
            #add-point:BEFORE FIELD xccc006 name="construct.b.page1.xccc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc006
            
            #add-point:AFTER FIELD xccc006 name="construct.a.page1.xccc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc007
            #add-point:ON ACTION controlp INFIELD xccc007 name="construct.c.page1.xccc007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc007  #顯示到畫面上
            NEXT FIELD xccc007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc007
            #add-point:BEFORE FIELD xccc007 name="construct.b.page1.xccc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc007
            
            #add-point:AFTER FIELD xccc007 name="construct.a.page1.xccc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xccc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc008
            #add-point:ON ACTION controlp INFIELD xccc008 name="construct.c.page1.xccc008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc008  #顯示到畫面上
            NEXT FIELD xccc008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc008
            #add-point:BEFORE FIELD xccc008 name="construct.b.page1.xccc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc008
            
            #add-point:AFTER FIELD xccc008 name="construct.a.page1.xccc008"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      CONSTRUCT BY NAME g_by ON l_yy1          
      END CONSTRUCT
      CONSTRUCT BY NAME g_bm ON l_mm1        
      END CONSTRUCT
      CONSTRUCT BY NAME g_ey ON l_yy2             
      END CONSTRUCT
      CONSTRUCT BY NAME g_em ON l_mm2   
      END CONSTRUCT
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
   LET g_by = cl_replace_str(g_by,"l_yy1=","")
   LET g_bm = cl_replace_str(g_bm,"l_mm1=","")
   LET g_ey = cl_replace_str(g_ey,"l_yy2=","")
   LET g_em = cl_replace_str(g_em,"l_mm2=","") 
   LET g_yy1 = g_by 
   LET g_mm1 = g_bm
   LET g_yy2 = g_ey
   LET g_mm2 = g_em    
   LET g_wc3 = " 1=1 "   
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
 
{<section id="axcq910.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq910_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   # 栏位显示控制,先隐藏    
   CALL cl_set_comp_visible("xccc280",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_1",FALSE)
   CALL cl_set_comp_visible("l_xccc280_2",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_3",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_4",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_5",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_6",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_7",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_8",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_9",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_10",FALSE)
   CALL cl_set_comp_visible("l_xccc280_11",FALSE)
   CALL cl_set_comp_visible("l_xccc280_12",FALSE)
   CALL cl_set_comp_visible("l_xccc280_13",FALSE)
   CALL cl_set_comp_visible("l_xccc280_14",FALSE)
   CALL cl_set_comp_visible("l_xccc280_15",FALSE)
   CALL cl_set_comp_visible("l_xccc280_16",FALSE)
   CALL cl_set_comp_visible("l_xccc280_17",FALSE)
   CALL cl_set_comp_visible("l_xccc280_18",FALSE)
   CALL cl_set_comp_visible("l_xccc280_19",FALSE)
   CALL cl_set_comp_visible("l_xccc280_20",FALSE)
   CALL cl_set_comp_visible("l_xccc280_21",FALSE)
   CALL cl_set_comp_visible("l_xccc280_22",FALSE)
   CALL cl_set_comp_visible("l_xccc280_23",FALSE)
   CALL cl_set_comp_visible("l_xccc280_24",FALSE)
   CALL cl_set_comp_visible("l_xccc280_25",FALSE)
   CALL cl_set_comp_visible("l_xccc280_26",FALSE)
   CALL cl_set_comp_visible("l_xccc280_27",FALSE)
   CALL cl_set_comp_visible("l_xccc280_28",FALSE)
   CALL cl_set_comp_visible("l_xccc280_29",FALSE)
   CALL cl_set_comp_visible("l_xccc280_30",FALSE)
   CALL cl_set_comp_visible("l_xccc280_31",FALSE)
   CALL cl_set_comp_visible("l_xccc280_32",FALSE)
   CALL cl_set_comp_visible("l_xccc280_33",FALSE)
   CALL cl_set_comp_visible("l_xccc280_34",FALSE)
   CALL cl_set_comp_visible("l_xccc280_35",FALSE)
   CALL cl_set_comp_visible("l_xccc280_36",FALSE)
   CALL cl_set_comp_visible("l_xccc280_37",FALSE)
   CALL cl_set_comp_visible("l_xccc280_38",FALSE)
   CALL cl_set_comp_visible("l_xccc280_39",FALSE)
   CALL cl_set_comp_visible("l_xccc280_40",FALSE)
   CALL cl_set_comp_visible("l_xccc280_41",FALSE)
   CALL cl_set_comp_visible("l_xccc280_42",FALSE)
   CALL cl_set_comp_visible("l_xccc280_43",FALSE)
   CALL cl_set_comp_visible("l_xccc280_44",FALSE)
   CALL cl_set_comp_visible("l_xccc280_45",FALSE)
   CALL cl_set_comp_visible("l_xccc280_46",FALSE)
   CALL cl_set_comp_visible("l_xccc280_47",FALSE)
   CALL cl_set_comp_visible("l_xccc280_48",FALSE)
   CALL cl_set_comp_visible("l_xccc280_49",FALSE)
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
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq910_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq910_browser_fill(g_wc)
      CALL axcq910_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq910_browser_fill("F")
   
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
      CALL axcq910_fetch("F") 
   END IF
   
   CALL axcq910_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq910_fetch(p_flag)
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
   
   #CALL axcq910_browser_fill(p_flag)
   
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
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq910_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003 INTO g_xccc_m.xccccomp, 
       g_xccc_m.xccc003,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xccc003_desc, 
       g_xccc_m.xcccld_desc
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
   CALL axcq910_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq910_set_act_visible()
   CALL axcq910_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xccc_m_t.* = g_xccc_m.*
   LET g_xccc_m_o.* = g_xccc_m.*
   
   #重新顯示   
   CALL axcq910_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq910.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq910_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xccc_d.clear()
 
 
   INITIALIZE g_xccc_m.* TO NULL             #DEFAULT 設定
   LET g_xcccld_t = NULL
   LET g_xccc001_t = NULL
   LET g_xccc003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq910_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccc_m.* TO NULL
         INITIALIZE g_xccc_d TO NULL
 
         CALL axcq910_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccc_m.* = g_xccc_m_t.*
         CALL axcq910_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xccc_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq910_set_act_visible()
   CALL axcq910_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq910_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq910_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq910_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003 INTO g_xccc_m.xccccomp, 
       g_xccc_m.xccc003,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xccc003_desc, 
       g_xccc_m.xcccld_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq910_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.l_yy1,g_xccc_m.l_mm1,g_xccc_m.xccc003, 
       g_xccc_m.xccc003_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.l_yy2,g_xccc_m.l_mm2,g_xccc_m.xccc001, 
       g_xccc_m.xccc001_desc
   
   #功能已完成,通報訊息中心
   CALL axcq910_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq910_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xccc_m.xcccld IS NULL
   OR g_xccc_m.xccc001 IS NULL
   OR g_xccc_m.xccc003 IS NULL
 
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
 
   CALL s_transaction_begin()
   
   OPEN axcq910_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq910_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq910_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq910_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003 INTO g_xccc_m.xccccomp, 
       g_xccc_m.xccc003,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xccc003_desc, 
       g_xccc_m.xcccld_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq910_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq910_show()
   WHILE TRUE
      LET g_xcccld_t = g_xccc_m.xcccld
      LET g_xccc001_t = g_xccc_m.xccc001
      LET g_xccc003_t = g_xccc_m.xccc003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq910_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xccc_m.* = g_xccc_m_t.*
         CALL axcq910_show()
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
   CALL axcq910_set_act_visible()
   CALL axcq910_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
 
   #填到對應位置
   CALL axcq910_browser_fill("")
 
   CALL axcq910_idx_chk()
 
   CLOSE axcq910_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq910_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq910.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq910_input(p_cmd)
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
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.l_yy1,g_xccc_m.l_mm1,g_xccc_m.xccc003, 
       g_xccc_m.xccc003_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.l_yy2,g_xccc_m.l_mm2,g_xccc_m.xccc001, 
       g_xccc_m.xccc001_desc
   
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
   LET g_forupd_sql = "SELECT xccc004,xccc005,xccc002,xccc006,xccc007,xccc008,xccc280 FROM xccc_t WHERE  
       xcccent=? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc002=? AND xccc004=? AND xccc005=?  
       AND xccc006=? AND xccc007=? AND xccc008=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq910_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq910_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq910_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.l_yy1,g_xccc_m.l_mm1,g_xccc_m.xccc003,g_xccc_m.xcccld, 
       g_xccc_m.l_yy2,g_xccc_m.l_mm2,g_xccc_m.xccc001
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq910.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xccc_m.xccccomp,g_xccc_m.l_yy1,g_xccc_m.l_mm1,g_xccc_m.xccc003,g_xccc_m.xcccld, 
          g_xccc_m.l_yy2,g_xccc_m.l_mm2,g_xccc_m.xccc001 
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
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
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
         BEFORE FIELD l_yy1
            #add-point:BEFORE FIELD l_yy1 name="input.b.l_yy1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_yy1
            
            #add-point:AFTER FIELD l_yy1 name="input.a.l_yy1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_yy1
            #add-point:ON CHANGE l_yy1 name="input.g.l_yy1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_mm1
            #add-point:BEFORE FIELD l_mm1 name="input.b.l_mm1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_mm1
            
            #add-point:AFTER FIELD l_mm1 name="input.a.l_mm1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_mm1
            #add-point:ON CHANGE l_mm1 name="input.g.l_mm1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="input.a.xccc003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccc003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
           


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccc003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"'",'std-00004',0) THEN 
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="input.a.xcccld"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xcccld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xcccld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xcccld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
           


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xcccld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xcccld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xcccld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"'",'std-00004',0) THEN 
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
         BEFORE FIELD l_yy2
            #add-point:BEFORE FIELD l_yy2 name="input.b.l_yy2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_yy2
            
            #add-point:AFTER FIELD l_yy2 name="input.a.l_yy2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_yy2
            #add-point:ON CHANGE l_yy2 name="input.g.l_yy2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_mm2
            #add-point:BEFORE FIELD l_mm2 name="input.b.l_mm2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_mm2
            
            #add-point:AFTER FIELD l_mm2 name="input.a.l_mm2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_mm2
            #add-point:ON CHANGE l_mm2 name="input.g.l_mm2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001 name="input.a.xccc001"
            #此段落由子樣板a05產生
            #確認資料無重複
          



            #此段落由子樣板a05產生
            #確認資料無重複
           


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001 name="input.b.xccc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc001
            #add-point:ON CHANGE xccc001 name="input.g.xccc001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccccomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp name="input.c.xccccomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_yy1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_yy1
            #add-point:ON ACTION controlp INFIELD l_yy1 name="input.c.l_yy1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_mm1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_mm1
            #add-point:ON ACTION controlp INFIELD l_mm1 name="input.c.l_mm1"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="input.c.xccc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcccld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="input.c.xcccld"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_yy2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_yy2
            #add-point:ON ACTION controlp INFIELD l_yy2 name="input.c.l_yy2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_mm2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_mm2
            #add-point:ON ACTION controlp INFIELD l_mm2 name="input.c.l_mm2"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001 name="input.c.xccc001"
            
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
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq910_xccc_t_mask_restore('restore_mask_o')
            
               UPDATE xccc_t SET (xccccomp,xccc003,xcccld,xccc001) = (g_xccc_m.xccccomp,g_xccc_m.xccc003, 
                   g_xccc_m.xcccld,g_xccc_m.xccc001)
                WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
                  AND xccc001 = g_xccc001_t
                  AND xccc003 = g_xccc003_t
 
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
               LET gs_keys[4] = g_xccc_d[g_detail_idx].xccc002
               LET gs_keys_bak[4] = g_xccc_d_t.xccc002
               LET gs_keys[5] = g_xccc_d[g_detail_idx].xccc004
               LET gs_keys_bak[5] = g_xccc_d_t.xccc004
               LET gs_keys[6] = g_xccc_d[g_detail_idx].xccc005
               LET gs_keys_bak[6] = g_xccc_d_t.xccc005
               LET gs_keys[7] = g_xccc_d[g_detail_idx].xccc006
               LET gs_keys_bak[7] = g_xccc_d_t.xccc006
               LET gs_keys[8] = g_xccc_d[g_detail_idx].xccc007
               LET gs_keys_bak[8] = g_xccc_d_t.xccc007
               LET gs_keys[9] = g_xccc_d[g_detail_idx].xccc008
               LET gs_keys_bak[9] = g_xccc_d_t.xccc008
               CALL axcq910_update_b('xccc_t',gs_keys,gs_keys_bak,"'1'")
                     
 
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
               CALL axcq910_xccc_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq910_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcccld_t = g_xccc_m.xcccld
           LET g_xccc001_t = g_xccc_m.xccc001
           LET g_xccc003_t = g_xccc_m.xccc003
 
           
           IF g_xccc_d.getLength() = 0 THEN
              NEXT FIELD xccc002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq910.input.body" >}
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
 
            CALL axcq910_b_fill(g_wc2) #test 
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
            CALL axcq910_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq910_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq910_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq910_cl:" 
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
               AND g_xccc_d[l_ac].xccc004 IS NOT NULL
               AND g_xccc_d[l_ac].xccc005 IS NOT NULL
               AND g_xccc_d[l_ac].xccc006 IS NOT NULL
               AND g_xccc_d[l_ac].xccc007 IS NOT NULL
               AND g_xccc_d[l_ac].xccc008 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccc_d_t.* = g_xccc_d[l_ac].*  #BACKUP
               LET g_xccc_d_o.* = g_xccc_d[l_ac].*  #BACKUP
               CALL axcq910_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq910_set_no_entry_b(l_cmd)
               OPEN axcq910_bcl USING g_enterprise,g_xccc_m.xcccld,
                                                g_xccc_m.xccc001,
                                                g_xccc_m.xccc003,
 
                                                g_xccc_d_t.xccc002
                                                ,g_xccc_d_t.xccc004
                                                ,g_xccc_d_t.xccc005
                                                ,g_xccc_d_t.xccc006
                                                ,g_xccc_d_t.xccc007
                                                ,g_xccc_d_t.xccc008
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq910_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq910_bcl INTO g_xccc_d[l_ac].xccc004,g_xccc_d[l_ac].xccc005,g_xccc_d[l_ac].xccc002, 
                      g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc280 
 
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
                  CALL axcq910_xccc_t_mask()
                  LET g_xccc_d_mask_n[l_ac].* =  g_xccc_d[l_ac].*
                  
                  CALL axcq910_ref_show()
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
                  LET g_xccc_d[l_ac].xccc280 = "0"
      LET g_xccc_d[l_ac].l_xccc280_1 = "0"
      LET g_xccc_d[l_ac].l_xccc280_2 = "0"
      LET g_xccc_d[l_ac].l_xccc280_3 = "0"
      LET g_xccc_d[l_ac].l_xccc280_4 = "0"
      LET g_xccc_d[l_ac].l_xccc280_5 = "0"
      LET g_xccc_d[l_ac].l_xccc280_6 = "0"
      LET g_xccc_d[l_ac].l_xccc280_7 = "0"
      LET g_xccc_d[l_ac].l_xccc280_8 = "0"
      LET g_xccc_d[l_ac].l_xccc280_9 = "0"
      LET g_xccc_d[l_ac].l_xccc280_10 = "0"
      LET g_xccc_d[l_ac].l_xccc280_11 = "0"
      LET g_xccc_d[l_ac].l_xccc280_12 = "0"
      LET g_xccc_d[l_ac].l_xccc280_13 = "0"
      LET g_xccc_d[l_ac].l_xccc280_14 = "0"
      LET g_xccc_d[l_ac].l_xccc280_15 = "0"
      LET g_xccc_d[l_ac].l_xccc280_16 = "0"
      LET g_xccc_d[l_ac].l_xccc280_17 = "0"
      LET g_xccc_d[l_ac].l_xccc280_18 = "0"
      LET g_xccc_d[l_ac].l_xccc280_19 = "0"
      LET g_xccc_d[l_ac].l_xccc280_20 = "0"
      LET g_xccc_d[l_ac].l_xccc280_21 = "0"
      LET g_xccc_d[l_ac].l_xccc280_22 = "0"
      LET g_xccc_d[l_ac].l_xccc280_23 = "0"
      LET g_xccc_d[l_ac].l_xccc280_24 = "0"
      LET g_xccc_d[l_ac].l_xccc280_25 = "0"
      LET g_xccc_d[l_ac].l_xccc280_26 = "0"
      LET g_xccc_d[l_ac].l_xccc280_27 = "0"
      LET g_xccc_d[l_ac].l_xccc280_28 = "0"
      LET g_xccc_d[l_ac].l_xccc280_29 = "0"
      LET g_xccc_d[l_ac].l_xccc280_30 = "0"
      LET g_xccc_d[l_ac].l_xccc280_31 = "0"
      LET g_xccc_d[l_ac].l_xccc280_32 = "0"
      LET g_xccc_d[l_ac].l_xccc280_33 = "0"
      LET g_xccc_d[l_ac].l_xccc280_34 = "0"
      LET g_xccc_d[l_ac].l_xccc280_35 = "0"
      LET g_xccc_d[l_ac].l_xccc280_36 = "0"
      LET g_xccc_d[l_ac].l_xccc280_37 = "0"
      LET g_xccc_d[l_ac].l_xccc280_38 = "0"
      LET g_xccc_d[l_ac].l_xccc280_39 = "0"
      LET g_xccc_d[l_ac].l_xccc280_40 = "0"
      LET g_xccc_d[l_ac].l_xccc280_41 = "0"
      LET g_xccc_d[l_ac].l_xccc280_42 = "0"
      LET g_xccc_d[l_ac].l_xccc280_43 = "0"
      LET g_xccc_d[l_ac].l_xccc280_44 = "0"
      LET g_xccc_d[l_ac].l_xccc280_45 = "0"
      LET g_xccc_d[l_ac].l_xccc280_46 = "0"
      LET g_xccc_d[l_ac].l_xccc280_47 = "0"
      LET g_xccc_d[l_ac].l_xccc280_48 = "0"
      LET g_xccc_d[l_ac].l_xccc280_49 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xccc_d_t.* = g_xccc_d[l_ac].*     #新輸入資料
            LET g_xccc_d_o.* = g_xccc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq910_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq910_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccc_d[li_reproduce_target].* = g_xccc_d[li_reproduce].*
 
               LET g_xccc_d[g_xccc_d.getLength()].xccc002 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc004 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc005 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc006 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc007 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc008 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xccc_t 
             WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld
               AND xccc001 = g_xccc_m.xccc001
               AND xccc003 = g_xccc_m.xccc003
 
               AND xccc002 = g_xccc_d[l_ac].xccc002
               AND xccc004 = g_xccc_d[l_ac].xccc004
               AND xccc005 = g_xccc_d[l_ac].xccc005
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
                            xccccomp,xccc003,xcccld,xccc001,
                            xccc002,xccc004,xccc005,xccc006,xccc007,xccc008
                            ,xccc280) 
                     VALUES(g_enterprise,
                            g_xccc_m.xccccomp,g_xccc_m.xccc003,g_xccc_m.xcccld,g_xccc_m.xccc001,
                            g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc004,g_xccc_d[l_ac].xccc005,g_xccc_d[l_ac].xccc006, 
                                g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008
                            ,g_xccc_d[l_ac].xccc280)
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
               IF axcq910_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xccc_m.xcccld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_m.xccc003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc005
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc006
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc007
                  LET gs_keys[gs_keys.getLength()+1] = g_xccc_d_t.xccc008
 
 
                  #刪除下層單身
                  IF NOT axcq910_key_delete_b(gs_keys,'xccc_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq910_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq910_bcl
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
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="input.b.page1.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="input.a.page1.xccc004"
            #此段落由子樣板a05產生
            #確認資料無重複
          


            #此段落由子樣板a05產生
            #確認資料無重複
           

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc004
            #add-point:ON CHANGE xccc004 name="input.g.page1.xccc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005 name="input.b.page1.xccc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005 name="input.a.page1.xccc005"
            #此段落由子樣板a05產生
            #確認資料無重複
            


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc005
            #add-point:ON CHANGE xccc005 name="input.g.page1.xccc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002 name="input.a.page1.xccc002"
            #此段落由子樣板a05產生
            #確認資料無重複
           


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccccomp
            LET g_ref_fields[2] = g_xccc_d[l_ac].xccc002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc002_desc


            #此段落由子樣板a05產生
            #確認資料無重複
            


            #此段落由子樣板a05產生
            #確認資料無重複
           


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
            #此段落由子樣板a05產生
            #確認資料無重複
           

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_d[l_ac].xccc006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc006_desc


            #此段落由子樣板a05產生
            #確認資料無重複
            

            #此段落由子樣板a05產生
            #確認資料無重複
           


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
            #此段落由子樣板a05產生
            #確認資料無重複
            

            #此段落由子樣板a05產生
            #確認資料無重複
           


            #此段落由子樣板a05產生
            #確認資料無重複
           


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
            #此段落由子樣板a05產生
            #確認資料無重複
            


            #此段落由子樣板a05產生
            #確認資料無重複
            


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc008
            #add-point:ON CHANGE xccc008 name="input.g.page1.xccc008"
            
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
         BEFORE FIELD l_xccc280_1
            #add-point:BEFORE FIELD l_xccc280_1 name="input.b.page1.l_xccc280_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_1
            
            #add-point:AFTER FIELD l_xccc280_1 name="input.a.page1.l_xccc280_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_1
            #add-point:ON CHANGE l_xccc280_1 name="input.g.page1.l_xccc280_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_2
            #add-point:BEFORE FIELD l_xccc280_2 name="input.b.page1.l_xccc280_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_2
            
            #add-point:AFTER FIELD l_xccc280_2 name="input.a.page1.l_xccc280_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_2
            #add-point:ON CHANGE l_xccc280_2 name="input.g.page1.l_xccc280_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_3
            #add-point:BEFORE FIELD l_xccc280_3 name="input.b.page1.l_xccc280_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_3
            
            #add-point:AFTER FIELD l_xccc280_3 name="input.a.page1.l_xccc280_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_3
            #add-point:ON CHANGE l_xccc280_3 name="input.g.page1.l_xccc280_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_4
            #add-point:BEFORE FIELD l_xccc280_4 name="input.b.page1.l_xccc280_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_4
            
            #add-point:AFTER FIELD l_xccc280_4 name="input.a.page1.l_xccc280_4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_4
            #add-point:ON CHANGE l_xccc280_4 name="input.g.page1.l_xccc280_4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_5
            #add-point:BEFORE FIELD l_xccc280_5 name="input.b.page1.l_xccc280_5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_5
            
            #add-point:AFTER FIELD l_xccc280_5 name="input.a.page1.l_xccc280_5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_5
            #add-point:ON CHANGE l_xccc280_5 name="input.g.page1.l_xccc280_5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_6
            #add-point:BEFORE FIELD l_xccc280_6 name="input.b.page1.l_xccc280_6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_6
            
            #add-point:AFTER FIELD l_xccc280_6 name="input.a.page1.l_xccc280_6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_6
            #add-point:ON CHANGE l_xccc280_6 name="input.g.page1.l_xccc280_6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_7
            #add-point:BEFORE FIELD l_xccc280_7 name="input.b.page1.l_xccc280_7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_7
            
            #add-point:AFTER FIELD l_xccc280_7 name="input.a.page1.l_xccc280_7"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_7
            #add-point:ON CHANGE l_xccc280_7 name="input.g.page1.l_xccc280_7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_8
            #add-point:BEFORE FIELD l_xccc280_8 name="input.b.page1.l_xccc280_8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_8
            
            #add-point:AFTER FIELD l_xccc280_8 name="input.a.page1.l_xccc280_8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_8
            #add-point:ON CHANGE l_xccc280_8 name="input.g.page1.l_xccc280_8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_9
            #add-point:BEFORE FIELD l_xccc280_9 name="input.b.page1.l_xccc280_9"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_9
            
            #add-point:AFTER FIELD l_xccc280_9 name="input.a.page1.l_xccc280_9"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_9
            #add-point:ON CHANGE l_xccc280_9 name="input.g.page1.l_xccc280_9"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_10
            #add-point:BEFORE FIELD l_xccc280_10 name="input.b.page1.l_xccc280_10"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_10
            
            #add-point:AFTER FIELD l_xccc280_10 name="input.a.page1.l_xccc280_10"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_10
            #add-point:ON CHANGE l_xccc280_10 name="input.g.page1.l_xccc280_10"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_11
            #add-point:BEFORE FIELD l_xccc280_11 name="input.b.page1.l_xccc280_11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_11
            
            #add-point:AFTER FIELD l_xccc280_11 name="input.a.page1.l_xccc280_11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_11
            #add-point:ON CHANGE l_xccc280_11 name="input.g.page1.l_xccc280_11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_12
            #add-point:BEFORE FIELD l_xccc280_12 name="input.b.page1.l_xccc280_12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_12
            
            #add-point:AFTER FIELD l_xccc280_12 name="input.a.page1.l_xccc280_12"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_12
            #add-point:ON CHANGE l_xccc280_12 name="input.g.page1.l_xccc280_12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_13
            #add-point:BEFORE FIELD l_xccc280_13 name="input.b.page1.l_xccc280_13"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_13
            
            #add-point:AFTER FIELD l_xccc280_13 name="input.a.page1.l_xccc280_13"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_13
            #add-point:ON CHANGE l_xccc280_13 name="input.g.page1.l_xccc280_13"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_14
            #add-point:BEFORE FIELD l_xccc280_14 name="input.b.page1.l_xccc280_14"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_14
            
            #add-point:AFTER FIELD l_xccc280_14 name="input.a.page1.l_xccc280_14"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_14
            #add-point:ON CHANGE l_xccc280_14 name="input.g.page1.l_xccc280_14"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_15
            #add-point:BEFORE FIELD l_xccc280_15 name="input.b.page1.l_xccc280_15"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_15
            
            #add-point:AFTER FIELD l_xccc280_15 name="input.a.page1.l_xccc280_15"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_15
            #add-point:ON CHANGE l_xccc280_15 name="input.g.page1.l_xccc280_15"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_16
            #add-point:BEFORE FIELD l_xccc280_16 name="input.b.page1.l_xccc280_16"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_16
            
            #add-point:AFTER FIELD l_xccc280_16 name="input.a.page1.l_xccc280_16"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_16
            #add-point:ON CHANGE l_xccc280_16 name="input.g.page1.l_xccc280_16"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_17
            #add-point:BEFORE FIELD l_xccc280_17 name="input.b.page1.l_xccc280_17"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_17
            
            #add-point:AFTER FIELD l_xccc280_17 name="input.a.page1.l_xccc280_17"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_17
            #add-point:ON CHANGE l_xccc280_17 name="input.g.page1.l_xccc280_17"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_18
            #add-point:BEFORE FIELD l_xccc280_18 name="input.b.page1.l_xccc280_18"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_18
            
            #add-point:AFTER FIELD l_xccc280_18 name="input.a.page1.l_xccc280_18"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_18
            #add-point:ON CHANGE l_xccc280_18 name="input.g.page1.l_xccc280_18"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_19
            #add-point:BEFORE FIELD l_xccc280_19 name="input.b.page1.l_xccc280_19"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_19
            
            #add-point:AFTER FIELD l_xccc280_19 name="input.a.page1.l_xccc280_19"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_19
            #add-point:ON CHANGE l_xccc280_19 name="input.g.page1.l_xccc280_19"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_20
            #add-point:BEFORE FIELD l_xccc280_20 name="input.b.page1.l_xccc280_20"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_20
            
            #add-point:AFTER FIELD l_xccc280_20 name="input.a.page1.l_xccc280_20"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_20
            #add-point:ON CHANGE l_xccc280_20 name="input.g.page1.l_xccc280_20"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_21
            #add-point:BEFORE FIELD l_xccc280_21 name="input.b.page1.l_xccc280_21"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_21
            
            #add-point:AFTER FIELD l_xccc280_21 name="input.a.page1.l_xccc280_21"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_21
            #add-point:ON CHANGE l_xccc280_21 name="input.g.page1.l_xccc280_21"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_22
            #add-point:BEFORE FIELD l_xccc280_22 name="input.b.page1.l_xccc280_22"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_22
            
            #add-point:AFTER FIELD l_xccc280_22 name="input.a.page1.l_xccc280_22"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_22
            #add-point:ON CHANGE l_xccc280_22 name="input.g.page1.l_xccc280_22"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_23
            #add-point:BEFORE FIELD l_xccc280_23 name="input.b.page1.l_xccc280_23"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_23
            
            #add-point:AFTER FIELD l_xccc280_23 name="input.a.page1.l_xccc280_23"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_23
            #add-point:ON CHANGE l_xccc280_23 name="input.g.page1.l_xccc280_23"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_24
            #add-point:BEFORE FIELD l_xccc280_24 name="input.b.page1.l_xccc280_24"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_24
            
            #add-point:AFTER FIELD l_xccc280_24 name="input.a.page1.l_xccc280_24"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_24
            #add-point:ON CHANGE l_xccc280_24 name="input.g.page1.l_xccc280_24"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_25
            #add-point:BEFORE FIELD l_xccc280_25 name="input.b.page1.l_xccc280_25"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_25
            
            #add-point:AFTER FIELD l_xccc280_25 name="input.a.page1.l_xccc280_25"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_25
            #add-point:ON CHANGE l_xccc280_25 name="input.g.page1.l_xccc280_25"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_26
            #add-point:BEFORE FIELD l_xccc280_26 name="input.b.page1.l_xccc280_26"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_26
            
            #add-point:AFTER FIELD l_xccc280_26 name="input.a.page1.l_xccc280_26"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_26
            #add-point:ON CHANGE l_xccc280_26 name="input.g.page1.l_xccc280_26"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_27
            #add-point:BEFORE FIELD l_xccc280_27 name="input.b.page1.l_xccc280_27"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_27
            
            #add-point:AFTER FIELD l_xccc280_27 name="input.a.page1.l_xccc280_27"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_27
            #add-point:ON CHANGE l_xccc280_27 name="input.g.page1.l_xccc280_27"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_28
            #add-point:BEFORE FIELD l_xccc280_28 name="input.b.page1.l_xccc280_28"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_28
            
            #add-point:AFTER FIELD l_xccc280_28 name="input.a.page1.l_xccc280_28"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_28
            #add-point:ON CHANGE l_xccc280_28 name="input.g.page1.l_xccc280_28"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_29
            #add-point:BEFORE FIELD l_xccc280_29 name="input.b.page1.l_xccc280_29"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_29
            
            #add-point:AFTER FIELD l_xccc280_29 name="input.a.page1.l_xccc280_29"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_29
            #add-point:ON CHANGE l_xccc280_29 name="input.g.page1.l_xccc280_29"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_30
            #add-point:BEFORE FIELD l_xccc280_30 name="input.b.page1.l_xccc280_30"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_30
            
            #add-point:AFTER FIELD l_xccc280_30 name="input.a.page1.l_xccc280_30"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_30
            #add-point:ON CHANGE l_xccc280_30 name="input.g.page1.l_xccc280_30"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_31
            #add-point:BEFORE FIELD l_xccc280_31 name="input.b.page1.l_xccc280_31"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_31
            
            #add-point:AFTER FIELD l_xccc280_31 name="input.a.page1.l_xccc280_31"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_31
            #add-point:ON CHANGE l_xccc280_31 name="input.g.page1.l_xccc280_31"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_32
            #add-point:BEFORE FIELD l_xccc280_32 name="input.b.page1.l_xccc280_32"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_32
            
            #add-point:AFTER FIELD l_xccc280_32 name="input.a.page1.l_xccc280_32"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_32
            #add-point:ON CHANGE l_xccc280_32 name="input.g.page1.l_xccc280_32"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_33
            #add-point:BEFORE FIELD l_xccc280_33 name="input.b.page1.l_xccc280_33"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_33
            
            #add-point:AFTER FIELD l_xccc280_33 name="input.a.page1.l_xccc280_33"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_33
            #add-point:ON CHANGE l_xccc280_33 name="input.g.page1.l_xccc280_33"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_34
            #add-point:BEFORE FIELD l_xccc280_34 name="input.b.page1.l_xccc280_34"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_34
            
            #add-point:AFTER FIELD l_xccc280_34 name="input.a.page1.l_xccc280_34"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_34
            #add-point:ON CHANGE l_xccc280_34 name="input.g.page1.l_xccc280_34"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_35
            #add-point:BEFORE FIELD l_xccc280_35 name="input.b.page1.l_xccc280_35"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_35
            
            #add-point:AFTER FIELD l_xccc280_35 name="input.a.page1.l_xccc280_35"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_35
            #add-point:ON CHANGE l_xccc280_35 name="input.g.page1.l_xccc280_35"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_36
            #add-point:BEFORE FIELD l_xccc280_36 name="input.b.page1.l_xccc280_36"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_36
            
            #add-point:AFTER FIELD l_xccc280_36 name="input.a.page1.l_xccc280_36"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_36
            #add-point:ON CHANGE l_xccc280_36 name="input.g.page1.l_xccc280_36"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_37
            #add-point:BEFORE FIELD l_xccc280_37 name="input.b.page1.l_xccc280_37"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_37
            
            #add-point:AFTER FIELD l_xccc280_37 name="input.a.page1.l_xccc280_37"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_37
            #add-point:ON CHANGE l_xccc280_37 name="input.g.page1.l_xccc280_37"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_38
            #add-point:BEFORE FIELD l_xccc280_38 name="input.b.page1.l_xccc280_38"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_38
            
            #add-point:AFTER FIELD l_xccc280_38 name="input.a.page1.l_xccc280_38"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_38
            #add-point:ON CHANGE l_xccc280_38 name="input.g.page1.l_xccc280_38"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_39
            #add-point:BEFORE FIELD l_xccc280_39 name="input.b.page1.l_xccc280_39"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_39
            
            #add-point:AFTER FIELD l_xccc280_39 name="input.a.page1.l_xccc280_39"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_39
            #add-point:ON CHANGE l_xccc280_39 name="input.g.page1.l_xccc280_39"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_40
            #add-point:BEFORE FIELD l_xccc280_40 name="input.b.page1.l_xccc280_40"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_40
            
            #add-point:AFTER FIELD l_xccc280_40 name="input.a.page1.l_xccc280_40"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_40
            #add-point:ON CHANGE l_xccc280_40 name="input.g.page1.l_xccc280_40"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_41
            #add-point:BEFORE FIELD l_xccc280_41 name="input.b.page1.l_xccc280_41"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_41
            
            #add-point:AFTER FIELD l_xccc280_41 name="input.a.page1.l_xccc280_41"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_41
            #add-point:ON CHANGE l_xccc280_41 name="input.g.page1.l_xccc280_41"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_42
            #add-point:BEFORE FIELD l_xccc280_42 name="input.b.page1.l_xccc280_42"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_42
            
            #add-point:AFTER FIELD l_xccc280_42 name="input.a.page1.l_xccc280_42"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_42
            #add-point:ON CHANGE l_xccc280_42 name="input.g.page1.l_xccc280_42"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_43
            #add-point:BEFORE FIELD l_xccc280_43 name="input.b.page1.l_xccc280_43"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_43
            
            #add-point:AFTER FIELD l_xccc280_43 name="input.a.page1.l_xccc280_43"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_43
            #add-point:ON CHANGE l_xccc280_43 name="input.g.page1.l_xccc280_43"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_44
            #add-point:BEFORE FIELD l_xccc280_44 name="input.b.page1.l_xccc280_44"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_44
            
            #add-point:AFTER FIELD l_xccc280_44 name="input.a.page1.l_xccc280_44"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_44
            #add-point:ON CHANGE l_xccc280_44 name="input.g.page1.l_xccc280_44"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_45
            #add-point:BEFORE FIELD l_xccc280_45 name="input.b.page1.l_xccc280_45"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_45
            
            #add-point:AFTER FIELD l_xccc280_45 name="input.a.page1.l_xccc280_45"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_45
            #add-point:ON CHANGE l_xccc280_45 name="input.g.page1.l_xccc280_45"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_46
            #add-point:BEFORE FIELD l_xccc280_46 name="input.b.page1.l_xccc280_46"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_46
            
            #add-point:AFTER FIELD l_xccc280_46 name="input.a.page1.l_xccc280_46"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_46
            #add-point:ON CHANGE l_xccc280_46 name="input.g.page1.l_xccc280_46"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_47
            #add-point:BEFORE FIELD l_xccc280_47 name="input.b.page1.l_xccc280_47"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_47
            
            #add-point:AFTER FIELD l_xccc280_47 name="input.a.page1.l_xccc280_47"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_47
            #add-point:ON CHANGE l_xccc280_47 name="input.g.page1.l_xccc280_47"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_48
            #add-point:BEFORE FIELD l_xccc280_48 name="input.b.page1.l_xccc280_48"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_48
            
            #add-point:AFTER FIELD l_xccc280_48 name="input.a.page1.l_xccc280_48"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_48
            #add-point:ON CHANGE l_xccc280_48 name="input.g.page1.l_xccc280_48"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xccc280_49
            #add-point:BEFORE FIELD l_xccc280_49 name="input.b.page1.l_xccc280_49"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xccc280_49
            
            #add-point:AFTER FIELD l_xccc280_49 name="input.a.page1.l_xccc280_49"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xccc280_49
            #add-point:ON CHANGE l_xccc280_49 name="input.g.page1.l_xccc280_49"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xccc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004 name="input.c.page1.xccc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xccc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005 name="input.c.page1.xccc005"
            
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
 
 
         #Ctrlp:input.c.page1.xccc280
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc280
            #add-point:ON ACTION controlp INFIELD xccc280 name="input.c.page1.xccc280"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_1
            #add-point:ON ACTION controlp INFIELD l_xccc280_1 name="input.c.page1.l_xccc280_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_2
            #add-point:ON ACTION controlp INFIELD l_xccc280_2 name="input.c.page1.l_xccc280_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_3
            #add-point:ON ACTION controlp INFIELD l_xccc280_3 name="input.c.page1.l_xccc280_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_4
            #add-point:ON ACTION controlp INFIELD l_xccc280_4 name="input.c.page1.l_xccc280_4"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_5
            #add-point:ON ACTION controlp INFIELD l_xccc280_5 name="input.c.page1.l_xccc280_5"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_6
            #add-point:ON ACTION controlp INFIELD l_xccc280_6 name="input.c.page1.l_xccc280_6"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_7
            #add-point:ON ACTION controlp INFIELD l_xccc280_7 name="input.c.page1.l_xccc280_7"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_8
            #add-point:ON ACTION controlp INFIELD l_xccc280_8 name="input.c.page1.l_xccc280_8"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_9
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_9
            #add-point:ON ACTION controlp INFIELD l_xccc280_9 name="input.c.page1.l_xccc280_9"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_10
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_10
            #add-point:ON ACTION controlp INFIELD l_xccc280_10 name="input.c.page1.l_xccc280_10"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_11
            #add-point:ON ACTION controlp INFIELD l_xccc280_11 name="input.c.page1.l_xccc280_11"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_12
            #add-point:ON ACTION controlp INFIELD l_xccc280_12 name="input.c.page1.l_xccc280_12"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_13
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_13
            #add-point:ON ACTION controlp INFIELD l_xccc280_13 name="input.c.page1.l_xccc280_13"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_14
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_14
            #add-point:ON ACTION controlp INFIELD l_xccc280_14 name="input.c.page1.l_xccc280_14"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_15
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_15
            #add-point:ON ACTION controlp INFIELD l_xccc280_15 name="input.c.page1.l_xccc280_15"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_16
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_16
            #add-point:ON ACTION controlp INFIELD l_xccc280_16 name="input.c.page1.l_xccc280_16"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_17
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_17
            #add-point:ON ACTION controlp INFIELD l_xccc280_17 name="input.c.page1.l_xccc280_17"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_18
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_18
            #add-point:ON ACTION controlp INFIELD l_xccc280_18 name="input.c.page1.l_xccc280_18"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_19
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_19
            #add-point:ON ACTION controlp INFIELD l_xccc280_19 name="input.c.page1.l_xccc280_19"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_20
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_20
            #add-point:ON ACTION controlp INFIELD l_xccc280_20 name="input.c.page1.l_xccc280_20"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_21
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_21
            #add-point:ON ACTION controlp INFIELD l_xccc280_21 name="input.c.page1.l_xccc280_21"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_22
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_22
            #add-point:ON ACTION controlp INFIELD l_xccc280_22 name="input.c.page1.l_xccc280_22"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_23
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_23
            #add-point:ON ACTION controlp INFIELD l_xccc280_23 name="input.c.page1.l_xccc280_23"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_24
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_24
            #add-point:ON ACTION controlp INFIELD l_xccc280_24 name="input.c.page1.l_xccc280_24"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_25
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_25
            #add-point:ON ACTION controlp INFIELD l_xccc280_25 name="input.c.page1.l_xccc280_25"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_26
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_26
            #add-point:ON ACTION controlp INFIELD l_xccc280_26 name="input.c.page1.l_xccc280_26"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_27
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_27
            #add-point:ON ACTION controlp INFIELD l_xccc280_27 name="input.c.page1.l_xccc280_27"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_28
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_28
            #add-point:ON ACTION controlp INFIELD l_xccc280_28 name="input.c.page1.l_xccc280_28"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_29
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_29
            #add-point:ON ACTION controlp INFIELD l_xccc280_29 name="input.c.page1.l_xccc280_29"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_30
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_30
            #add-point:ON ACTION controlp INFIELD l_xccc280_30 name="input.c.page1.l_xccc280_30"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_31
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_31
            #add-point:ON ACTION controlp INFIELD l_xccc280_31 name="input.c.page1.l_xccc280_31"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_32
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_32
            #add-point:ON ACTION controlp INFIELD l_xccc280_32 name="input.c.page1.l_xccc280_32"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_33
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_33
            #add-point:ON ACTION controlp INFIELD l_xccc280_33 name="input.c.page1.l_xccc280_33"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_34
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_34
            #add-point:ON ACTION controlp INFIELD l_xccc280_34 name="input.c.page1.l_xccc280_34"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_35
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_35
            #add-point:ON ACTION controlp INFIELD l_xccc280_35 name="input.c.page1.l_xccc280_35"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_36
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_36
            #add-point:ON ACTION controlp INFIELD l_xccc280_36 name="input.c.page1.l_xccc280_36"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_37
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_37
            #add-point:ON ACTION controlp INFIELD l_xccc280_37 name="input.c.page1.l_xccc280_37"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_38
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_38
            #add-point:ON ACTION controlp INFIELD l_xccc280_38 name="input.c.page1.l_xccc280_38"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_39
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_39
            #add-point:ON ACTION controlp INFIELD l_xccc280_39 name="input.c.page1.l_xccc280_39"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_40
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_40
            #add-point:ON ACTION controlp INFIELD l_xccc280_40 name="input.c.page1.l_xccc280_40"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_41
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_41
            #add-point:ON ACTION controlp INFIELD l_xccc280_41 name="input.c.page1.l_xccc280_41"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_42
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_42
            #add-point:ON ACTION controlp INFIELD l_xccc280_42 name="input.c.page1.l_xccc280_42"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_43
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_43
            #add-point:ON ACTION controlp INFIELD l_xccc280_43 name="input.c.page1.l_xccc280_43"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_44
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_44
            #add-point:ON ACTION controlp INFIELD l_xccc280_44 name="input.c.page1.l_xccc280_44"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_45
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_45
            #add-point:ON ACTION controlp INFIELD l_xccc280_45 name="input.c.page1.l_xccc280_45"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_46
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_46
            #add-point:ON ACTION controlp INFIELD l_xccc280_46 name="input.c.page1.l_xccc280_46"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_47
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_47
            #add-point:ON ACTION controlp INFIELD l_xccc280_47 name="input.c.page1.l_xccc280_47"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_48
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_48
            #add-point:ON ACTION controlp INFIELD l_xccc280_48 name="input.c.page1.l_xccc280_48"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_xccc280_49
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xccc280_49
            #add-point:ON ACTION controlp INFIELD l_xccc280_49 name="input.c.page1.l_xccc280_49"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xccc_d[l_ac].* = g_xccc_d_t.*
               CLOSE axcq910_bcl
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
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq910_xccc_t_mask_restore('restore_mask_o')
         
               UPDATE xccc_t SET (xcccld,xccc001,xccc003,xccc004,xccc005,xccc002,xccc006,xccc007,xccc008, 
                   xccc280) = (g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_d[l_ac].xccc004, 
                   g_xccc_d[l_ac].xccc005,g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007, 
                   g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc280)
                WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld 
                 AND xccc001 = g_xccc_m.xccc001 
                 AND xccc003 = g_xccc_m.xccc003 
 
                 AND xccc002 = g_xccc_d_t.xccc002 #項次   
                 AND xccc004 = g_xccc_d_t.xccc004  
                 AND xccc005 = g_xccc_d_t.xccc005  
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
               LET gs_keys[4] = g_xccc_d[g_detail_idx].xccc002
               LET gs_keys_bak[4] = g_xccc_d_t.xccc002
               LET gs_keys[5] = g_xccc_d[g_detail_idx].xccc004
               LET gs_keys_bak[5] = g_xccc_d_t.xccc004
               LET gs_keys[6] = g_xccc_d[g_detail_idx].xccc005
               LET gs_keys_bak[6] = g_xccc_d_t.xccc005
               LET gs_keys[7] = g_xccc_d[g_detail_idx].xccc006
               LET gs_keys_bak[7] = g_xccc_d_t.xccc006
               LET gs_keys[8] = g_xccc_d[g_detail_idx].xccc007
               LET gs_keys_bak[8] = g_xccc_d_t.xccc007
               LET gs_keys[9] = g_xccc_d[g_detail_idx].xccc008
               LET gs_keys_bak[9] = g_xccc_d_t.xccc008
               CALL axcq910_update_b('xccc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq910_xccc_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xccc_m.xcccld
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc001
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_m.xccc003
 
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc002
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc004
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc005
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc006
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc007
               LET ls_keys[ls_keys.getLength()+1] = g_xccc_d_t.xccc008
 
               CALL axcq910_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq910_bcl
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
 
            CLOSE axcq910_bcl
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
 
               LET g_xccc_d[li_reproduce_target].xccc002 = NULL
               LET g_xccc_d[li_reproduce_target].xccc004 = NULL
               LET g_xccc_d[li_reproduce_target].xccc005 = NULL
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
            NEXT FIELD xcccld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
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
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq910_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE  l_glaa001        LIKE glaa_t.glaa001
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   IF cl_null(g_xccc_m.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否 
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否         
    ELSE
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否      
    END IF
      
    IF g_para_data = 'Y' THEN
       CALL cl_set_comp_visible('xccc002,xccc002_desc',TRUE)
       LET g_xccc002 = 'Y' #150319-00004 ---(s)---
    ELSE
       CALL cl_set_comp_visible('xccc002,xccc002_desc',FALSE)
       LET g_xccc002 = 'N' #150319-00004 ---(e)---
    END IF
    IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccc007',TRUE)
      LET g_xccc007 = 'Y' #150319-00004 ---(s)---
   ELSE                       
      CALL cl_set_comp_visible('xccc007',FALSE)
      LET g_xccc007 = 'N' #150319-00004 ---(e)---
   END IF
   LET g_xccc_m.l_yy1 = g_yy1
   LET g_xccc_m.l_mm1 = g_mm1
   LET g_xccc_m.l_yy2 = g_yy2
   LET g_xccc_m.l_mm2 = g_mm2
   CALL axcq910_ref()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq910_b_fill(g_wc2) #第一階單身填充
      CALL axcq910_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq910_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.l_yy1,g_xccc_m.l_mm1,g_xccc_m.xccc003, 
       g_xccc_m.xccc003_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.l_yy2,g_xccc_m.l_mm2,g_xccc_m.xccc001, 
       g_xccc_m.xccc001_desc
 
   CALL axcq910_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq910_ref_show()
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
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq910.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq910_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xccc_t.xcccld 
   DEFINE l_oldno     LIKE xccc_t.xcccld 
   DEFINE l_newno02     LIKE xccc_t.xccc001 
   DEFINE l_oldno02     LIKE xccc_t.xccc001 
   DEFINE l_newno03     LIKE xccc_t.xccc003 
   DEFINE l_oldno03     LIKE xccc_t.xccc003 
 
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
 
   
   LET g_xccc_m.xcccld = ""
   LET g_xccc_m.xccc001 = ""
   LET g_xccc_m.xccc003 = ""
 
   LET g_master_insert = FALSE
   CALL axcq910_set_entry('a')
   CALL axcq910_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xccc_m.xccc003_desc = ''
   DISPLAY BY NAME g_xccc_m.xccc003_desc
   LET g_xccc_m.xcccld_desc = ''
   DISPLAY BY NAME g_xccc_m.xcccld_desc
   LET g_xccc_m.xccc001_desc = ''
   DISPLAY BY NAME g_xccc_m.xccc001_desc
 
   
   CALL axcq910_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xccc_m.* TO NULL
      INITIALIZE g_xccc_d TO NULL
 
      CALL axcq910_show()
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
   CALL axcq910_set_act_visible()
   CALL axcq910_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcccent = " ||g_enterprise|| " AND",
                      " xcccld = '", g_xccc_m.xcccld, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq910_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq910_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq910_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq910_detail_reproduce()
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
   
   DROP TABLE axcq910_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xccc_t
    WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
    AND xccc001 = g_xccc001_t
    AND xccc003 = g_xccc003_t
 
       INTO TEMP axcq910_detail
   
   #將key修正為調整後   
   UPDATE axcq910_detail 
      #更新key欄位
      SET xcccld = g_xccc_m.xcccld
          , xccc001 = g_xccc_m.xccc001
          , xccc003 = g_xccc_m.xccc003
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xccc_t SELECT * FROM axcq910_detail
   
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
   DROP TABLE axcq910_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
 
   
   DROP TABLE axcq910_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq910_delete()
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
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq910_cl USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq910_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq910_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq910_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003 INTO g_xccc_m.xccccomp, 
       g_xccc_m.xccc003,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xccc003_desc, 
       g_xccc_m.xcccld_desc
   
   #遮罩相關處理
   LET g_xccc_m_mask_o.* =  g_xccc_m.*
   CALL axcq910_xccc_t_mask()
   LET g_xccc_m_mask_n.* =  g_xccc_m.*
   
   CALL axcq910_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq910_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xccc_t WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld
                                                               AND xccc001 = g_xccc_m.xccc001
                                                               AND xccc003 = g_xccc_m.xccc003
 
                                                               
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
      #   CLOSE axcq910_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xccc_d.clear() 
 
     
      CALL axcq910_ui_browser_refresh()  
      #CALL axcq910_ui_headershow()  
      #CALL axcq910_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq910_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq910_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq910_cl
 
   #功能已完成,通報訊息中心
   CALL axcq910_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq910.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq910_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   IF 1=2 THEN
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xccc_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xccc004,xccc005,xccc002,xccc006,xccc007,xccc008,xccc280,t1.xcbfl003 , 
       t2.imaal003 ,t3.imaal004 FROM xccc_t",   
               "",
               
                              " LEFT JOIN xcbfl_t t1 ON t1.xcbflent="||g_enterprise||" AND t1.xcbflcomp=xccccomp AND t1.xcbfl001=xccc002 AND t1.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xccc006 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=xccc006 AND t3.imaal002='"||g_dlang||"' ",
 
               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq910_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xccc_t.xccc002,xccc_t.xccc004,xccc_t.xccc005,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq910_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq910_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003 INTO g_xccc_d[l_ac].xccc004, 
          g_xccc_d[l_ac].xccc005,g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007, 
          g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc002_desc,g_xccc_d[l_ac].xccc006_desc, 
          g_xccc_d[l_ac].xccc006_desc_desc   #(ver:49)
                             
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
 
            CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   ELSE
      CALL axcq910_b_fill_1()
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xccc_d.getLength()
      LET g_xccc_d_mask_o[l_ac].* =  g_xccc_d[l_ac].*
      CALL axcq910_xccc_t_mask()
      LET g_xccc_d_mask_n[l_ac].* =  g_xccc_d[l_ac].*
   END FOR
   
 
 
   FREE axcq910_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq910_idx_chk()
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
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq910_b_fill2(pi_idx)
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
 
{<section id="axcq910.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq910_before_delete()
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
 
          xccc002 = g_xccc_d_t.xccc002
      AND xccc004 = g_xccc_d_t.xccc004
      AND xccc005 = g_xccc_d_t.xccc005
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
 
{<section id="axcq910.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq910_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq910.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq910_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq910.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq910_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq910.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq910_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xccc_d[l_ac].xccc002 = g_xccc_d_t.xccc002 
      AND g_xccc_d[l_ac].xccc004 = g_xccc_d_t.xccc004 
      AND g_xccc_d[l_ac].xccc005 = g_xccc_d_t.xccc005 
      AND g_xccc_d[l_ac].xccc006 = g_xccc_d_t.xccc006 
      AND g_xccc_d[l_ac].xccc007 = g_xccc_d_t.xccc007 
      AND g_xccc_d[l_ac].xccc008 = g_xccc_d_t.xccc008 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq910_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq910.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq910_lock_b(ps_table,ps_page)
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
   #CALL axcq910_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq910.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq910_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq910.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq910_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcccld,xccc001,xccc003",TRUE)
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
 
{<section id="axcq910.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq910_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcccld,xccc001,xccc003",FALSE)
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
 
{<section id="axcq910.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq910_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq910_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq910_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq910.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq910_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq910.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq910_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq910.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq910_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq910.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq910_default_search()
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
 
{<section id="axcq910.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq910_fill_chk(ps_idx)
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
 
{<section id="axcq910.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq910_modify_detail_chk(ps_record)
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
         LET ls_return = "xccc004"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq910.mask_functions" >}
&include "erp/axc/axcq910_mask.4gl"
 
{</section>}
 
{<section id="axcq910.state_change" >}
    
 
{</section>}
 
{<section id="axcq910.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq910_set_pk_array()
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
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq910.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq910_msgcentre_notify(lc_state)
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
   CALL axcq910_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xccc_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq910.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq910_b_fill_1()
#150319-00004# ---(s)---
DEFINE l_xccc002_desc   LIKE type_t.chr500
DEFINE l_xccc006_desc   LIKE type_t.chr500   
DEFINE l_comp_desc      LIKE type_t.chr80
DEFINE l_ld_desc        LIKE type_t.chr80
DEFINE l_strdate        LIKE type_t.chr80
DEFINE l_enddate        LIKE type_t.chr80
DEFINE l_xccc003_desc   LIKE type_t.chr80
DEFINE l_xccc001_desc   LIKE type_t.chr80

   DELETE FROM axcq910_tmp01      #160727-00019#21 Mod  axcq910_print_tmp--> axcq910_tmp01
#150319-00004#---(e)---

   CALL axcq910_create_tmp()
   CALL axcq910_insert_tmp()
   
   CALL g_xccc_d.clear() 
  
   LET g_sql = "SELECT  UNIQUE '','',xccc002,xccc006,xccc007,xccc008,",
               "        xccc280_1,xccc280_2,xccc280_3,xccc280_4,xccc280_5,",
               "        xccc280_6,xccc280_7,xccc280_8,xccc280_9,xccc280_10,",
               "        xccc280_11,xccc280_12,xccc280_13,xccc280_14,xccc280_15,",
               "        xccc280_16,xccc280_17,xccc280_18,xccc280_19,xccc280_20,",
               "        xccc280_21,xccc280_22,xccc280_23,xccc280_24,xccc280_25,",
               "        xccc280_26,xccc280_27,xccc280_28,xccc280_29,xccc280_30,",
               "        xccc280_31,xccc280_32,xccc280_33,xccc280_34,xccc280_35,",
               "        xccc280_36,xccc280_37,xccc280_38,xccc280_39,xccc280_40,",
               "        xccc280_41,xccc280_42,xccc280_43,xccc280_44,xccc280_45,",
               "        xccc280_46,xccc280_47,xccc280_48,xccc280_49,xccc280_50,",
               "        t1.xcbfl003 ,t2.imaal003 ,t3.imaal004",
               "  FROM axcq910_tmp",   
               "",
               
                              " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbflcomp='"||g_xccc_m.xccccomp||"' AND t1.xcbfl001=xccc002 AND t1.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xccc006 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xccc006 AND t3.imaal002='"||g_dlang||"' "
 
               
   
   #判斷是否填充
   IF axcq910_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xccc006,xccc007,xccc008,xccc002"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq910_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR axcq910_pb1
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      #OPEN b_fill_cs1 USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003
                                               
      FOREACH b_fill_cs1 INTO g_xccc_d[l_ac].xccc004,g_xccc_d[l_ac].xccc005,g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006, 
          g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc280,
          g_xccc_d[l_ac].l_xccc280_1,g_xccc_d[l_ac].l_xccc280_2,g_xccc_d[l_ac].l_xccc280_3,g_xccc_d[l_ac].l_xccc280_4,g_xccc_d[l_ac].l_xccc280_5,
          g_xccc_d[l_ac].l_xccc280_6,g_xccc_d[l_ac].l_xccc280_7,g_xccc_d[l_ac].l_xccc280_8,g_xccc_d[l_ac].l_xccc280_9,g_xccc_d[l_ac].l_xccc280_10,
          g_xccc_d[l_ac].l_xccc280_11,g_xccc_d[l_ac].l_xccc280_12,g_xccc_d[l_ac].l_xccc280_13,g_xccc_d[l_ac].l_xccc280_14,g_xccc_d[l_ac].l_xccc280_15,
          g_xccc_d[l_ac].l_xccc280_16,g_xccc_d[l_ac].l_xccc280_17,g_xccc_d[l_ac].l_xccc280_18,g_xccc_d[l_ac].l_xccc280_19,g_xccc_d[l_ac].l_xccc280_20,
          g_xccc_d[l_ac].l_xccc280_21,g_xccc_d[l_ac].l_xccc280_22,g_xccc_d[l_ac].l_xccc280_23,g_xccc_d[l_ac].l_xccc280_24,g_xccc_d[l_ac].l_xccc280_25,
          g_xccc_d[l_ac].l_xccc280_26,g_xccc_d[l_ac].l_xccc280_27,g_xccc_d[l_ac].l_xccc280_28,g_xccc_d[l_ac].l_xccc280_29,g_xccc_d[l_ac].l_xccc280_30,
          g_xccc_d[l_ac].l_xccc280_31,g_xccc_d[l_ac].l_xccc280_32,g_xccc_d[l_ac].l_xccc280_33,g_xccc_d[l_ac].l_xccc280_34,g_xccc_d[l_ac].l_xccc280_35,
          g_xccc_d[l_ac].l_xccc280_36,g_xccc_d[l_ac].l_xccc280_37,g_xccc_d[l_ac].l_xccc280_38,g_xccc_d[l_ac].l_xccc280_39,g_xccc_d[l_ac].l_xccc280_40,
          g_xccc_d[l_ac].l_xccc280_41,g_xccc_d[l_ac].l_xccc280_42,g_xccc_d[l_ac].l_xccc280_43,g_xccc_d[l_ac].l_xccc280_44,g_xccc_d[l_ac].l_xccc280_45,
          g_xccc_d[l_ac].l_xccc280_46,g_xccc_d[l_ac].l_xccc280_47,g_xccc_d[l_ac].l_xccc280_48,g_xccc_d[l_ac].l_xccc280_49,
          g_xccc_d[l_ac].xccc002_desc,g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_desc
          
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #150319-00004 ---(s)--- 
         IF NOT cl_null(g_xccc_d[l_ac].xccc002) THEN         
            LET l_xccc002_desc = g_xccc_d[l_ac].xccc002,".",g_xccc_d[l_ac].xccc002_desc
         END IF
         LET l_xccc006_desc = g_xccc_d[l_ac].xccc006,".",g_xccc_d[l_ac].xccc006_desc
         IF NOT cl_null(g_xccc_d[l_ac].xccc006_desc_desc) THEN 
            LET l_xccc006_desc = l_xccc006_desc,".",g_xccc_d[l_ac].xccc006_desc_desc
         END IF
         LET l_comp_desc    = g_xccc_m.xccccomp,".",g_xccc_m.xccccomp_desc
         LET l_ld_desc      = g_xccc_m.xcccld,".",g_xccc_m.xcccld_desc
         LET l_strdate      = g_xccc_m.l_yy1||"."||g_xccc_m.l_mm1
         LET l_enddate      = g_xccc_m.l_yy2||"."||g_xccc_m.l_mm2
         LET l_xccc003_desc = g_xccc_m.xccc003,".",g_xccc_m.xccc003_desc
         LET l_xccc001_desc = g_xccc_m.xccc001,":",s_desc_gzcbl004_desc('8914',g_xccc_m.xccc001),".",g_xccc_m.xccc001_desc
    
         
         INSERT INTO axcq910_tmp01             #160727-00019#21 Mod  axcq910_print_tmp--> axcq910_tmp01
         VALUES(l_xccc002_desc,l_xccc006_desc, 
          g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc280,
          g_xccc_d[l_ac].l_xccc280_1,g_xccc_d[l_ac].l_xccc280_2,g_xccc_d[l_ac].l_xccc280_3,g_xccc_d[l_ac].l_xccc280_4,g_xccc_d[l_ac].l_xccc280_5,
          g_xccc_d[l_ac].l_xccc280_6,g_xccc_d[l_ac].l_xccc280_7,g_xccc_d[l_ac].l_xccc280_8,g_xccc_d[l_ac].l_xccc280_9,g_xccc_d[l_ac].l_xccc280_10,
          g_xccc_d[l_ac].l_xccc280_11,g_xccc_d[l_ac].l_xccc280_12,g_xccc_d[l_ac].l_xccc280_13,g_xccc_d[l_ac].l_xccc280_14,g_xccc_d[l_ac].l_xccc280_15,
          g_xccc_d[l_ac].l_xccc280_16,g_xccc_d[l_ac].l_xccc280_17,g_xccc_d[l_ac].l_xccc280_18,g_xccc_d[l_ac].l_xccc280_19,g_xccc_d[l_ac].l_xccc280_20,
          g_xccc_d[l_ac].l_xccc280_21,g_xccc_d[l_ac].l_xccc280_22,g_xccc_d[l_ac].l_xccc280_23,g_xccc_d[l_ac].l_xccc280_24,g_xccc_d[l_ac].l_xccc280_25,
          g_xccc_d[l_ac].l_xccc280_26,g_xccc_d[l_ac].l_xccc280_27,g_xccc_d[l_ac].l_xccc280_28,g_xccc_d[l_ac].l_xccc280_29,g_xccc_d[l_ac].l_xccc280_30,
          g_xccc_d[l_ac].l_xccc280_31,g_xccc_d[l_ac].l_xccc280_32,g_xccc_d[l_ac].l_xccc280_33,g_xccc_d[l_ac].l_xccc280_34,g_xccc_d[l_ac].l_xccc280_35,
          g_xccc_d[l_ac].l_xccc280_36,g_xccc_d[l_ac].l_xccc280_37,g_xccc_d[l_ac].l_xccc280_38,g_xccc_d[l_ac].l_xccc280_39,g_xccc_d[l_ac].l_xccc280_40,
          g_xccc_d[l_ac].l_xccc280_41,g_xccc_d[l_ac].l_xccc280_42,g_xccc_d[l_ac].l_xccc280_43,g_xccc_d[l_ac].l_xccc280_44,g_xccc_d[l_ac].l_xccc280_45,
          g_xccc_d[l_ac].l_xccc280_46,g_xccc_d[l_ac].l_xccc280_47,g_xccc_d[l_ac].l_xccc280_48,g_xccc_d[l_ac].l_xccc280_49,
          'N',l_comp_desc,l_ld_desc,l_strdate,l_enddate,l_xccc003_desc,l_xccc001_desc
          ) 
         #150319-00004 ---(e)---          
         #add-point:b_fill段資料填充

         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取

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
PRIVATE FUNCTION axcq910_create_tmp()
DROP TABLE axcq910_tmp

CREATE TEMP TABLE axcq910_tmp(   
   xccc002  VARCHAR(30),   
   xccc006  VARCHAR(40), 
   xccc007  VARCHAR(256),  
   xccc008  VARCHAR(30),    
   xccc280_1  DECIMAL(20,6), 
   xccc280_2  DECIMAL(20,6), 
   xccc280_3  DECIMAL(20,6), 
   xccc280_4  DECIMAL(20,6), 
   xccc280_5  DECIMAL(20,6), 
   xccc280_6  DECIMAL(20,6), 
   xccc280_7  DECIMAL(20,6), 
   xccc280_8  DECIMAL(20,6), 
   xccc280_9  DECIMAL(20,6), 
   xccc280_10  DECIMAL(20,6), 
   xccc280_11  DECIMAL(20,6), 
   xccc280_12  DECIMAL(20,6), 
   xccc280_13  DECIMAL(20,6), 
   xccc280_14  DECIMAL(20,6), 
   xccc280_15  DECIMAL(20,6), 
   xccc280_16  DECIMAL(20,6), 
   xccc280_17  DECIMAL(20,6), 
   xccc280_18  DECIMAL(20,6), 
   xccc280_19  DECIMAL(20,6), 
   xccc280_20  DECIMAL(20,6), 
   xccc280_21  DECIMAL(20,6), 
   xccc280_22  DECIMAL(20,6), 
   xccc280_23  DECIMAL(20,6), 
   xccc280_24  DECIMAL(20,6), 
   xccc280_25  DECIMAL(20,6), 
   xccc280_26  DECIMAL(20,6), 
   xccc280_27  DECIMAL(20,6), 
   xccc280_28  DECIMAL(20,6), 
   xccc280_29  DECIMAL(20,6), 
   xccc280_30  DECIMAL(20,6), 
   xccc280_31  DECIMAL(20,6), 
   xccc280_32  DECIMAL(20,6), 
   xccc280_33  DECIMAL(20,6), 
   xccc280_34  DECIMAL(20,6), 
   xccc280_35  DECIMAL(20,6), 
   xccc280_36  DECIMAL(20,6), 
   xccc280_37  DECIMAL(20,6), 
   xccc280_38  DECIMAL(20,6), 
   xccc280_39  DECIMAL(20,6), 
   xccc280_40  DECIMAL(20,6), 
   xccc280_41  DECIMAL(20,6), 
   xccc280_42  DECIMAL(20,6), 
   xccc280_43  DECIMAL(20,6), 
   xccc280_44  DECIMAL(20,6), 
   xccc280_45  DECIMAL(20,6), 
   xccc280_46  DECIMAL(20,6), 
   xccc280_47  DECIMAL(20,6), 
   xccc280_48  DECIMAL(20,6), 
   xccc280_49  DECIMAL(20,6),
   xccc280_50  DECIMAL(20,6)
);
   #150319-00004 ---(s)---
DROP TABLE axcq910_tmp01                  #160727-00019#21 Mod  axcq910_print_tmp--> axcq910_tmp01
   CREATE TEMP TABLE axcq910_tmp01(       #160727-00019#21 Mod  axcq910_print_tmp--> axcq910_tmp01
   xccc002_desc  VARCHAR(500), 
   xccc006_desc  VARCHAR(500),   
   xccc007  VARCHAR(256),    
   xccc008  VARCHAR(30), 
   xccc280  DECIMAL(20,6), 
   l_xccc280_1  DECIMAL(20,6), 
   l_xccc280_2  DECIMAL(20,6), 
   l_xccc280_3  DECIMAL(20,6), 
   l_xccc280_4  DECIMAL(20,6), 
   l_xccc280_5  DECIMAL(20,6), 
   l_xccc280_6  DECIMAL(20,6), 
   l_xccc280_7  DECIMAL(20,6), 
   l_xccc280_8  DECIMAL(20,6), 
   l_xccc280_9  DECIMAL(20,6), 
   l_xccc280_10  DECIMAL(20,6), 
   l_xccc280_11  DECIMAL(20,6), 
   l_xccc280_12  DECIMAL(20,6), 
   l_xccc280_13  DECIMAL(20,6), 
   l_xccc280_14  DECIMAL(20,6), 
   l_xccc280_15  DECIMAL(20,6), 
   l_xccc280_16  DECIMAL(20,6), 
   l_xccc280_17  DECIMAL(20,6), 
   l_xccc280_18  DECIMAL(20,6), 
   l_xccc280_19  DECIMAL(20,6), 
   l_xccc280_20  DECIMAL(20,6), 
   l_xccc280_21  DECIMAL(20,6), 
   l_xccc280_22  DECIMAL(20,6), 
   l_xccc280_23  DECIMAL(20,6), 
   l_xccc280_24  DECIMAL(20,6), 
   l_xccc280_25  DECIMAL(20,6), 
   l_xccc280_26  DECIMAL(20,6), 
   l_xccc280_27  DECIMAL(20,6), 
   l_xccc280_28  DECIMAL(20,6), 
   l_xccc280_29  DECIMAL(20,6), 
   l_xccc280_30  DECIMAL(20,6), 
   l_xccc280_31  DECIMAL(20,6), 
   l_xccc280_32  DECIMAL(20,6), 
   l_xccc280_33  DECIMAL(20,6), 
   l_xccc280_34  DECIMAL(20,6), 
   l_xccc280_35  DECIMAL(20,6), 
   l_xccc280_36  DECIMAL(20,6), 
   l_xccc280_37  DECIMAL(20,6), 
   l_xccc280_38  DECIMAL(20,6), 
   l_xccc280_39  DECIMAL(20,6), 
   l_xccc280_40  DECIMAL(20,6), 
   l_xccc280_41  DECIMAL(20,6), 
   l_xccc280_42  DECIMAL(20,6), 
   l_xccc280_43  DECIMAL(20,6), 
   l_xccc280_44  DECIMAL(20,6), 
   l_xccc280_45  DECIMAL(20,6), 
   l_xccc280_46  DECIMAL(20,6), 
   l_xccc280_47  DECIMAL(20,6), 
   l_xccc280_48  DECIMAL(20,6), 
   l_xccc280_49  DECIMAL(20,6),
   l_flag        VARCHAR(1),
   l_comp_desc   VARCHAR(80),
   l_ld_desc        VARCHAR(80),
   l_strdate        VARCHAR(80),
   l_enddate        VARCHAR(80),
   l_xccc003_desc   VARCHAR(80),
   l_xccc001_desc   VARCHAR(80)
);

#150319-00004 ---(e)---




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
PRIVATE FUNCTION axcq910_insert_tmp()
   DEFINE l_ymc LIKE type_t.num5
   DEFINE l_i   LIKE type_t.num5
   DEFINE l_sql STRING
   DEFINE l_str STRING    #栏位标题显示
   DEFINE l_str1 STRING
   DEFINE l_str2 STRING   
   DEFINE l_length LIKE type_t.num5
   DEFINE l_glaa003 LIKE glaa_t.glaa003
   DEFINE l_max_m  LIKE xccc_t.xccc005
   
   CALL g_ym.clear() 
   DELETE FROM axcq910_tmp  
   LET l_str1 = cl_getmsg("axc-00588",g_lang)   #年
   LET l_str2 = cl_getmsg("axc-00589",g_lang)   #期 
   #单身年月-----------
   #年期参照表
   SELECT glaa003 INTO l_glaa003
     FROM glaa_t
    WHERE glaaent  = g_enterprise
      AND glaacomp = g_xccc_m.xccccomp
      AND glaa014  = 'Y' 
      
   LET g_ym[1].year = g_yy1 LET g_ym[1].month = g_mm1
   #查询年对应最大期别
   SELECT MAX(glav006) INTO l_max_m FROM glav_t  #可能有非12的设置
    WHERE glavent = g_enterprise
      AND glav001 = l_glaa003
      AND glav002 = g_ym[1].year
      AND glavstus = 'Y'
   IF cl_null(l_max_m) THEN LET l_max_m = 12 END IF
   
   FOR l_ymc = 2 TO 50 STEP 1      
      IF cl_null(g_ym[l_ymc-1].year) THEN EXIT FOR END IF
      IF g_ym[l_ymc-1].year= g_yy2 THEN   #到截至年了
         IF g_ym[l_ymc-1].month < g_mm2 THEN  #按月加1
            LET g_ym[l_ymc].year = g_ym[l_ymc-1].year  LET g_ym[l_ymc].month = g_ym[l_ymc-1].month + 1       
         END IF
      ELSE  #未到截至年        
         IF g_ym[l_ymc-1].month < l_max_m THEN  #判断是否进入下一年
            LET g_ym[l_ymc].year = g_ym[l_ymc-1].year   LET g_ym[l_ymc].month = g_ym[l_ymc-1].month + 1  
         ELSE  #下一年
            LET g_ym[l_ymc].year = g_ym[l_ymc-1].year + 1   LET g_ym[l_ymc].month = 1  
            #查询年对应最大期别
            SELECT MAX(glav006) INTO l_max_m FROM glav_t  #可能有非12的设置
             WHERE glavent = g_enterprise
               AND glav001 = l_glaa003
               AND glav002 = g_ym[l_ymc].year
               AND glavstus = 'Y'
            IF cl_null(l_max_m) THEN LET l_max_m = 12 END IF            
         END IF
      END IF
   END FOR

   #INSERT tmp
   LET l_sql = " INSERT INTO axcq910_tmp ",
               " SELECT DISTINCT xccc002,xccc006,xccc007,xccc008,",
               "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",       
               "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,",
               "0,0,0,0,0,0,0,0,0,0 FROM xccc_t ",
               "  WHERE xcccld = '",g_xccc_m.xcccld,"' AND xccc001 = '",g_xccc_m.xccc001,"'",
               "    AND xccc003 = '",g_xccc_m.xccc003,"' AND ",g_wc3 CLIPPED," AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED
    PREPARE axcq910_ins_tmp FROM l_sql
    EXECUTE axcq910_ins_tmp
    IF SQLCA.sqlcode THEN
       LET g_success='N'
       CALL cl_errmsg('','','INS axcq910_tmp',SQLCA.sqlcode,1)
       RETURN
    END IF 
               
   # 栏位显示控制,先隐藏    
   CALL cl_set_comp_visible("xccc280",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_1",FALSE)
   CALL cl_set_comp_visible("l_xccc280_2",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_3",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_4",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_5",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_6",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_7",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_8",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_9",FALSE) 
   CALL cl_set_comp_visible("l_xccc280_10",FALSE)
   CALL cl_set_comp_visible("l_xccc280_11",FALSE)
   CALL cl_set_comp_visible("l_xccc280_12",FALSE)
   CALL cl_set_comp_visible("l_xccc280_13",FALSE)
   CALL cl_set_comp_visible("l_xccc280_14",FALSE)
   CALL cl_set_comp_visible("l_xccc280_15",FALSE)
   CALL cl_set_comp_visible("l_xccc280_16",FALSE)
   CALL cl_set_comp_visible("l_xccc280_17",FALSE)
   CALL cl_set_comp_visible("l_xccc280_18",FALSE)
   CALL cl_set_comp_visible("l_xccc280_19",FALSE)
   CALL cl_set_comp_visible("l_xccc280_20",FALSE)
   CALL cl_set_comp_visible("l_xccc280_21",FALSE)
   CALL cl_set_comp_visible("l_xccc280_22",FALSE)
   CALL cl_set_comp_visible("l_xccc280_23",FALSE)
   CALL cl_set_comp_visible("l_xccc280_24",FALSE)
   CALL cl_set_comp_visible("l_xccc280_25",FALSE)
   CALL cl_set_comp_visible("l_xccc280_26",FALSE)
   CALL cl_set_comp_visible("l_xccc280_27",FALSE)
   CALL cl_set_comp_visible("l_xccc280_28",FALSE)
   CALL cl_set_comp_visible("l_xccc280_29",FALSE)
   CALL cl_set_comp_visible("l_xccc280_30",FALSE)
   CALL cl_set_comp_visible("l_xccc280_31",FALSE)
   CALL cl_set_comp_visible("l_xccc280_32",FALSE)
   CALL cl_set_comp_visible("l_xccc280_33",FALSE)
   CALL cl_set_comp_visible("l_xccc280_34",FALSE)
   CALL cl_set_comp_visible("l_xccc280_35",FALSE)
   CALL cl_set_comp_visible("l_xccc280_36",FALSE)
   CALL cl_set_comp_visible("l_xccc280_37",FALSE)
   CALL cl_set_comp_visible("l_xccc280_38",FALSE)
   CALL cl_set_comp_visible("l_xccc280_39",FALSE)
   CALL cl_set_comp_visible("l_xccc280_40",FALSE)
   CALL cl_set_comp_visible("l_xccc280_41",FALSE)
   CALL cl_set_comp_visible("l_xccc280_42",FALSE)
   CALL cl_set_comp_visible("l_xccc280_43",FALSE)
   CALL cl_set_comp_visible("l_xccc280_44",FALSE)
   CALL cl_set_comp_visible("l_xccc280_45",FALSE)
   CALL cl_set_comp_visible("l_xccc280_46",FALSE)
   CALL cl_set_comp_visible("l_xccc280_47",FALSE)
   CALL cl_set_comp_visible("l_xccc280_48",FALSE)
   CALL cl_set_comp_visible("l_xccc280_49",FALSE)
   
   
   #UPDATE xccc280  
   LET l_length = g_ym.getLength()
   IF cl_null(g_ym[l_length].year) THEN LET l_length = l_length - 1 END IF
   LET g_flag = l_length  
   FOR l_i = 1 TO l_length STEP 1
       LET l_sql =
           "MERGE INTO axcq910_tmp t0 ",
           "      USING (SELECT DISTINCT xccc002,xccc006,xccc007,xccc008,xccc280", 
           "               FROM xccc_t ",
           "              WHERE xcccent = ",g_enterprise,          #151215-00010#2  add
           "                AND xcccld = '",g_xccc_m.xcccld,"' AND xccc001 = '",g_xccc_m.xccc001,"'",
           "                AND xccc003 = '",g_xccc_m.xccc003,"' AND xccc004 = '",g_ym[l_i].year,"'",
           "                AND xccc005 = '",g_ym[l_i].month,"') t1",          
           "      ON (t0.xccc002 = t1.xccc002 AND t0.xccc006 = t1.xccc006 ", 
           "          AND t0.xccc007 = t1.xccc007 AND t0.xccc008 = t1.xccc008 ) ",
           "    WHEN MATCHED THEN ",
           " UPDATE SET t0.xccc280_1 = t1.xccc280"
           IF l_i=2  THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_2") END IF
           IF l_i=3  THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_3") END IF
           IF l_i=4  THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_4") END IF
           IF l_i=5  THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_5") END IF
           IF l_i=6  THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_6") END IF
           IF l_i=7  THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_7") END IF
           IF l_i=8  THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_8") END IF
           IF l_i=9  THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_9") END IF
           IF l_i=10 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_10") END IF
           IF l_i=11 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_11") END IF
           IF l_i=12 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_12") END IF
           IF l_i=13 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_13") END IF
           IF l_i=14 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_14") END IF
           IF l_i=15 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_15") END IF
           IF l_i=16 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_16") END IF
           IF l_i=17 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_17") END IF
           IF l_i=18 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_18") END IF
           IF l_i=19 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_19") END IF
           IF l_i=20 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_20") END IF
           IF l_i=21 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_21") END IF
           IF l_i=22 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_22") END IF
           IF l_i=23 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_23") END IF
           IF l_i=24 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_24") END IF
           IF l_i=25 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_25") END IF
           IF l_i=26 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_26") END IF
           IF l_i=27 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_27") END IF 
           IF l_i=28 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_28") END IF
           IF l_i=29 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_29") END IF
           IF l_i=30 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_30") END IF
           IF l_i=31 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_31") END IF
           IF l_i=32 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_32") END IF
           IF l_i=33 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_33") END IF
           IF l_i=34 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_34") END IF
           IF l_i=35 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_35") END IF
           IF l_i=36 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_36") END IF
           IF l_i=37 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_37") END IF
           IF l_i=38 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_38") END IF
           IF l_i=39 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_39") END IF
           IF l_i=40 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_40") END IF
           IF l_i=41 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_41") END IF
           IF l_i=42 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_42") END IF
           IF l_i=43 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_43") END IF
           IF l_i=44 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_44") END IF
           IF l_i=45 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_45") END IF
           IF l_i=46 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_46") END IF
           IF l_i=47 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_47") END IF
           IF l_i=48 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_48") END IF
           IF l_i=49 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_49") END IF
           IF l_i=50 THEN LET l_sql=cl_replace_str(l_sql,"xccc280_1","xccc280_50") END IF
           
      PREPARE axcq910_merge FROM l_sql
      EXECUTE axcq910_merge

      IF SQLCA.sqlcode THEN
         LET g_success='N'
         CALL cl_errmsg('','','MERGE xccc_t',SQLCA.sqlcode,1)
         RETURN
      END IF 
      
     #--151215-00010#2--add--(s)
      #檢查是否有開帳期別的數據，當金額為0時，如有開帳資料則改抓開帳資料
      LET l_sql =           
          "MERGE INTO axcq910_tmp t0 ",
          "      USING (SELECT DISTINCT xcca002,xcca006,xcca007,xcca008,xcca101,xcca102", 
          "               FROM xcca_t ",
          "              WHERE xccaent = ",g_enterprise,
          "                AND xccald = '",g_xccc_m.xcccld,"' AND xcca001 = '",g_xccc_m.xccc001,"'",
          "                AND xcca003 = '",g_xccc_m.xccc003,"' AND xcca004 = '",g_ym[l_i].year,"'",
          "                AND xcca005 = '",g_ym[l_i].month,"' AND xcca101 > 0) t1",            
          "      ON (t0.xccc002 = t1.xcca002 AND t0.xccc006 = t1.xcca006 AND ", 
          "          t0.xccc007 = t1.xcca007 AND t0.xccc008 = t1.xcca008 )",
          "    WHEN MATCHED THEN ",
          " UPDATE SET t0.xccc280_1 = t1.xcca102/t1.xcca101 ",
          "  WHERE t0.xccc280_1 = 0 "
      CASE l_i
        WHEN '2'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_2")
        WHEN '3'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_3") 
        WHEN '4'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_4") 
        WHEN '5'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_5") 
        WHEN '6'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_6") 
        WHEN '7'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_7") 
        WHEN '8'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_8") 
        WHEN '9'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_9") 
        WHEN '10'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_10") 
        WHEN '11'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_11") 
        WHEN '12'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_12") 
        WHEN '13'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_13") 
        WHEN '14'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_14") 
        WHEN '15'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_15") 
        WHEN '16'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_16") 
        WHEN '17'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_17") 
        WHEN '18'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_18") 
        WHEN '19'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_19") 
        WHEN '20'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_20") 
        WHEN '21'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_21") 
        WHEN '22'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_22") 
        WHEN '23'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_23") 
        WHEN '24'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_24")
        WHEN '25'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_25")
        WHEN '26'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_26")
        WHEN '27'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_27")
        WHEN '28'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_28")
        WHEN '29'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_29")
        WHEN '30'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_30")
        WHEN '31'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_31")
        WHEN '32'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_32")
        WHEN '33'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_33")
        WHEN '34'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_34")
        WHEN '35'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_35")
        WHEN '36'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_36")
        WHEN '37'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_37")
        WHEN '38'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_38")
        WHEN '39'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_39")
        WHEN '40'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_40")
        WHEN '41'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_41")
        WHEN '42'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_42")
        WHEN '43'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_43")
        WHEN '44'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_44")
        WHEN '45'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_45")
        WHEN '46'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_46")
        WHEN '47'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_47")
        WHEN '48'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_48")
        WHEN '49'
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_49")
        WHEN '50' 
          LET l_sql = cl_replace_str(l_sql,"xccc280_1","xccc280_50")
      END CASE            
      PREPARE axcq910_merge_2 FROM l_sql
      EXECUTE axcq910_merge_2

      IF SQLCA.sqlcode THEN
         LET g_success='N'
         CALL cl_errmsg('','','MERGE xccb_t',SQLCA.sqlcode,1)
         RETURN
      END IF                                  
     #--151215-00010#2--add--(e)
     
      #有条件显示栏位
      LET l_str = g_ym[l_i].year,l_str1,g_ym[l_i].month,l_str2
      IF l_i=1  THEN CALL cl_set_comp_att_text("xccc280",l_str) CALL cl_set_comp_visible("xccc280",TRUE) END IF      
      IF l_i=2  THEN CALL cl_set_comp_att_text("l_xccc280_1",l_str) CALL cl_set_comp_visible("l_xccc280_1",TRUE)END IF
      IF l_i=3  THEN CALL cl_set_comp_att_text("l_xccc280_2",l_str) CALL cl_set_comp_visible("l_xccc280_2",TRUE)END IF
      IF l_i=4  THEN CALL cl_set_comp_att_text("l_xccc280_3",l_str) CALL cl_set_comp_visible("l_xccc280_3",TRUE)END IF
      IF l_i=5  THEN CALL cl_set_comp_att_text("l_xccc280_4",l_str) CALL cl_set_comp_visible("l_xccc280_4",TRUE)END IF
      IF l_i=6  THEN CALL cl_set_comp_att_text("l_xccc280_5",l_str) CALL cl_set_comp_visible("l_xccc280_5",TRUE)END IF
      IF l_i=7  THEN CALL cl_set_comp_att_text("l_xccc280_6",l_str) CALL cl_set_comp_visible("l_xccc280_6",TRUE)END IF
      IF l_i=8  THEN CALL cl_set_comp_att_text("l_xccc280_7",l_str) CALL cl_set_comp_visible("l_xccc280_7",TRUE)END IF
      IF l_i=9  THEN CALL cl_set_comp_att_text("l_xccc280_8",l_str) CALL cl_set_comp_visible("l_xccc280_8",TRUE)END IF
      IF l_i=10 THEN CALL cl_set_comp_att_text("l_xccc280_9",l_str) CALL cl_set_comp_visible("l_xccc280_9",TRUE)END IF
      IF l_i=11 THEN CALL cl_set_comp_att_text("l_xccc280_10",l_str) CALL cl_set_comp_visible("l_xccc280_10",TRUE) END IF
      IF l_i=12 THEN CALL cl_set_comp_att_text("l_xccc280_11",l_str) CALL cl_set_comp_visible("l_xccc280_11",TRUE) END IF
      IF l_i=13 THEN CALL cl_set_comp_att_text("l_xccc280_12",l_str) CALL cl_set_comp_visible("l_xccc280_12",TRUE) END IF
      IF l_i=14 THEN CALL cl_set_comp_att_text("l_xccc280_13",l_str) CALL cl_set_comp_visible("l_xccc280_13",TRUE) END IF
      IF l_i=15 THEN CALL cl_set_comp_att_text("l_xccc280_14",l_str) CALL cl_set_comp_visible("l_xccc280_14",TRUE) END IF
      IF l_i=16 THEN CALL cl_set_comp_att_text("l_xccc280_15",l_str) CALL cl_set_comp_visible("l_xccc280_15",TRUE) END IF
      IF l_i=17 THEN CALL cl_set_comp_att_text("l_xccc280_16",l_str) CALL cl_set_comp_visible("l_xccc280_16",TRUE) END IF
      IF l_i=18 THEN CALL cl_set_comp_att_text("l_xccc280_17",l_str) CALL cl_set_comp_visible("l_xccc280_17",TRUE) END IF
      IF l_i=19 THEN CALL cl_set_comp_att_text("l_xccc280_18",l_str) CALL cl_set_comp_visible("l_xccc280_18",TRUE) END IF
      IF l_i=20 THEN CALL cl_set_comp_att_text("l_xccc280_19",l_str) CALL cl_set_comp_visible("l_xccc280_19",TRUE) END IF
      IF l_i=21 THEN CALL cl_set_comp_att_text("l_xccc280_20",l_str) CALL cl_set_comp_visible("l_xccc280_20",TRUE) END IF
      IF l_i=22 THEN CALL cl_set_comp_att_text("l_xccc280_21",l_str) CALL cl_set_comp_visible("l_xccc280_21",TRUE) END IF
      IF l_i=23 THEN CALL cl_set_comp_att_text("l_xccc280_22",l_str) CALL cl_set_comp_visible("l_xccc280_22",TRUE) END IF
      IF l_i=24 THEN CALL cl_set_comp_att_text("l_xccc280_23",l_str) CALL cl_set_comp_visible("l_xccc280_23",TRUE) END IF
      IF l_i=25 THEN CALL cl_set_comp_att_text("l_xccc280_24",l_str) CALL cl_set_comp_visible("l_xccc280_24",TRUE) END IF
      IF l_i=26 THEN CALL cl_set_comp_att_text("l_xccc280_25",l_str) CALL cl_set_comp_visible("l_xccc280_25",TRUE) END IF
      IF l_i=27 THEN CALL cl_set_comp_att_text("l_xccc280_26",l_str) CALL cl_set_comp_visible("l_xccc280_26",TRUE) END IF 
      IF l_i=28 THEN CALL cl_set_comp_att_text("l_xccc280_27",l_str) CALL cl_set_comp_visible("l_xccc280_27",TRUE) END IF
      IF l_i=29 THEN CALL cl_set_comp_att_text("l_xccc280_28",l_str) CALL cl_set_comp_visible("l_xccc280_28",TRUE) END IF
      IF l_i=30 THEN CALL cl_set_comp_att_text("l_xccc280_29",l_str) CALL cl_set_comp_visible("l_xccc280_29",TRUE) END IF
      IF l_i=31 THEN CALL cl_set_comp_att_text("l_xccc280_30",l_str) CALL cl_set_comp_visible("l_xccc280_30",TRUE) END IF
      IF l_i=32 THEN CALL cl_set_comp_att_text("l_xccc280_31",l_str) CALL cl_set_comp_visible("l_xccc280_31",TRUE) END IF
      IF l_i=33 THEN CALL cl_set_comp_att_text("l_xccc280_32",l_str) CALL cl_set_comp_visible("l_xccc280_32",TRUE) END IF
      IF l_i=34 THEN CALL cl_set_comp_att_text("l_xccc280_33",l_str) CALL cl_set_comp_visible("l_xccc280_33",TRUE) END IF
      IF l_i=35 THEN CALL cl_set_comp_att_text("l_xccc280_34",l_str) CALL cl_set_comp_visible("l_xccc280_34",TRUE) END IF
      IF l_i=36 THEN CALL cl_set_comp_att_text("l_xccc280_35",l_str) CALL cl_set_comp_visible("l_xccc280_35",TRUE) END IF
      IF l_i=37 THEN CALL cl_set_comp_att_text("l_xccc280_36",l_str) CALL cl_set_comp_visible("l_xccc280_36",TRUE) END IF
      IF l_i=38 THEN CALL cl_set_comp_att_text("l_xccc280_37",l_str) CALL cl_set_comp_visible("l_xccc280_37",TRUE) END IF
      IF l_i=39 THEN CALL cl_set_comp_att_text("l_xccc280_38",l_str) CALL cl_set_comp_visible("l_xccc280_38",TRUE) END IF
      IF l_i=40 THEN CALL cl_set_comp_att_text("l_xccc280_39",l_str) CALL cl_set_comp_visible("l_xccc280_39",TRUE) END IF
      IF l_i=41 THEN CALL cl_set_comp_att_text("l_xccc280_40",l_str) CALL cl_set_comp_visible("l_xccc280_40",TRUE) END IF
      IF l_i=42 THEN CALL cl_set_comp_att_text("l_xccc280_41",l_str) CALL cl_set_comp_visible("l_xccc280_41",TRUE) END IF
      IF l_i=43 THEN CALL cl_set_comp_att_text("l_xccc280_42",l_str) CALL cl_set_comp_visible("l_xccc280_42",TRUE) END IF
      IF l_i=44 THEN CALL cl_set_comp_att_text("l_xccc280_43",l_str) CALL cl_set_comp_visible("l_xccc280_43",TRUE) END IF
      IF l_i=45 THEN CALL cl_set_comp_att_text("l_xccc280_44",l_str) CALL cl_set_comp_visible("l_xccc280_44",TRUE) END IF
      IF l_i=46 THEN CALL cl_set_comp_att_text("l_xccc280_45",l_str) CALL cl_set_comp_visible("l_xccc280_45",TRUE) END IF
      IF l_i=47 THEN CALL cl_set_comp_att_text("l_xccc280_46",l_str) CALL cl_set_comp_visible("l_xccc280_46",TRUE) END IF
      IF l_i=48 THEN CALL cl_set_comp_att_text("l_xccc280_47",l_str) CALL cl_set_comp_visible("l_xccc280_47",TRUE) END IF
      IF l_i=49 THEN CALL cl_set_comp_att_text("l_xccc280_48",l_str) CALL cl_set_comp_visible("l_xccc280_48",TRUE) END IF
      IF l_i=50 THEN CALL cl_set_comp_att_text("l_xccc280_49",l_str) CALL cl_set_comp_visible("l_xccc280_49",TRUE) END IF 
      #150319-00004 ---(s)---
      IF l_i=1   THEN LET g_xg_fieldname[5 ] = l_str END IF
      IF l_i=2   THEN LET g_xg_fieldname[6 ] = l_str END IF
      IF l_i=3   THEN LET g_xg_fieldname[7 ] = l_str END IF
      IF l_i=4   THEN LET g_xg_fieldname[8 ] = l_str END IF
      IF l_i=5   THEN LET g_xg_fieldname[9 ] = l_str END IF
      IF l_i=6   THEN LET g_xg_fieldname[10] = l_str END IF
      IF l_i=7   THEN LET g_xg_fieldname[11] = l_str END IF
      IF l_i=8   THEN LET g_xg_fieldname[12] = l_str END IF
      IF l_i=9   THEN LET g_xg_fieldname[13] = l_str END IF
      IF l_i=10  THEN LET g_xg_fieldname[14] = l_str END IF
      IF l_i=11  THEN LET g_xg_fieldname[15] = l_str END IF
      IF l_i=12  THEN LET g_xg_fieldname[16] = l_str END IF
      IF l_i=13  THEN LET g_xg_fieldname[17] = l_str END IF
      IF l_i=14  THEN LET g_xg_fieldname[18] = l_str END IF
      IF l_i=15  THEN LET g_xg_fieldname[19] = l_str END IF
      IF l_i=16  THEN LET g_xg_fieldname[20] = l_str END IF
      IF l_i=17  THEN LET g_xg_fieldname[21] = l_str END IF
      IF l_i=18  THEN LET g_xg_fieldname[22] = l_str END IF
      IF l_i=19  THEN LET g_xg_fieldname[23] = l_str END IF
      IF l_i=20  THEN LET g_xg_fieldname[24] = l_str END IF
      IF l_i=21  THEN LET g_xg_fieldname[25] = l_str END IF
      IF l_i=22  THEN LET g_xg_fieldname[26] = l_str END IF
      IF l_i=23  THEN LET g_xg_fieldname[27] = l_str END IF
      IF l_i=24  THEN LET g_xg_fieldname[28] = l_str END IF
      IF l_i=25  THEN LET g_xg_fieldname[29] = l_str END IF
      IF l_i=26  THEN LET g_xg_fieldname[30] = l_str END IF
      IF l_i=27  THEN LET g_xg_fieldname[31] = l_str END IF
      IF l_i=28  THEN LET g_xg_fieldname[32] = l_str END IF
      IF l_i=29  THEN LET g_xg_fieldname[33] = l_str END IF
      IF l_i=30  THEN LET g_xg_fieldname[34] = l_str END IF
      IF l_i=31  THEN LET g_xg_fieldname[35] = l_str END IF
      IF l_i=32  THEN LET g_xg_fieldname[36] = l_str END IF
      IF l_i=33  THEN LET g_xg_fieldname[37] = l_str END IF
      IF l_i=34  THEN LET g_xg_fieldname[38] = l_str END IF
      IF l_i=35  THEN LET g_xg_fieldname[39] = l_str END IF
      IF l_i=36  THEN LET g_xg_fieldname[40] = l_str END IF
      IF l_i=37  THEN LET g_xg_fieldname[41] = l_str END IF
      IF l_i=38  THEN LET g_xg_fieldname[42] = l_str END IF
      IF l_i=39  THEN LET g_xg_fieldname[43] = l_str END IF
      IF l_i=40  THEN LET g_xg_fieldname[44] = l_str END IF
      IF l_i=41  THEN LET g_xg_fieldname[45] = l_str END IF
      IF l_i=42  THEN LET g_xg_fieldname[46] = l_str END IF
      IF l_i=43  THEN LET g_xg_fieldname[47] = l_str END IF
      IF l_i=44  THEN LET g_xg_fieldname[48] = l_str END IF
      IF l_i=45  THEN LET g_xg_fieldname[49] = l_str END IF
      IF l_i=46  THEN LET g_xg_fieldname[50] = l_str END IF
      IF l_i=47  THEN LET g_xg_fieldname[51] = l_str END IF
      IF l_i=48  THEN LET g_xg_fieldname[52] = l_str END IF
      IF l_i=49  THEN LET g_xg_fieldname[53] = l_str END IF
      IF l_i=50  THEN LET g_xg_fieldname[54] = l_str END IF
      #150319-00004 ---(e)---

   END FOR
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
PRIVATE FUNCTION axcq910_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001
DEFINE  l_today          LIKE type_t.dat
   IF cl_null(g_xccc_m.xccccomp) AND cl_null(g_xccc_m.xcccld) AND cl_null(g_xccc_m.xccc001) AND
      cl_null(g_xccc_m.l_yy2) AND cl_null(g_xccc_m.l_mm2) AND cl_null(g_xccc_m.xccc003) 
      THEN
   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.l_yy2,g_xccc_m.l_mm2,g_xccc_m.xccc003
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.l_yy2,g_xccc_m.l_mm2,g_xccc_m.xccc003
   
   IF cl_null(g_xccc_m.xccccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否 
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否         
    ELSE
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否      
    END IF
      
    IF g_para_data = 'Y' THEN
       CALL cl_set_comp_visible('xccc002,xccc002_desc',TRUE)
    ELSE
       CALL cl_set_comp_visible('xccc002,xccc002_desc',FALSE)
    END IF
    IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccc007',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xccc007',FALSE)                
   END IF
   IF cl_null(g_xccc_m.l_yy2) AND cl_null(g_xccc_m.l_mm2) THEN
      LET l_today = cl_get_today()
      LET g_xccc_m.l_yy2 = YEAR(l_today)
      LET g_xccc_m.l_mm2 = MONTH(l_today)
   END IF
   LET g_xccc_m.l_yy1 = g_xccc_m.l_yy2
   LET g_xccc_m.l_mm1 = g_xccc_m.l_mm2
   DISPLAY BY NAME g_xccc_m.l_yy2,g_xccc_m.l_mm2,g_xccc_m.l_yy1,g_xccc_m.l_mm1
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
PRIVATE FUNCTION axcq910_ref()
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

 
{</section>}
 
