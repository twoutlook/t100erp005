#該程式未解開Section, 採用最新樣板產出!
{<section id="axct202.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-08-15 10:21:32), PR版次:0013(2016-10-13 14:22:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000138
#+ Filename...: axct202
#+ Description: 工時費用統計和維護作業
#+ Creator....: 02114(2014-05-11 22:13:26)
#+ Modifier...: 02295 -SD/PR- 02040
 
{</section>}
 
{<section id="axct202.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160321-00028#1  2016/04/07  By dorislai 新增列印
#160419-00035#1  2016/04/21  By xianghui 科目栏位开窗传入参数调整
#160419-00039#1  2016/04/21  By xianghui 功能币二和三的隐藏调整
#160318-00025#11 2016/04/25  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160510-00025#1  2016/05/11  By xianghui 单身部分栏位不能小于零
#160811-00015#1  2016/08/15  By xianghui 单身的成本中心xcbj004和会计科目xcbj011应带出说明来
#160802-00020#5  2016/10/12  By 02040    增加帳套權限管控、法人權限管控
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
PRIVATE type type_g_xcbj_m        RECORD
       xcbjcomp LIKE xcbj_t.xcbjcomp, 
   xcbjcomp_desc LIKE type_t.chr80, 
   xcbjld LIKE xcbj_t.xcbjld, 
   xcbjld_desc LIKE type_t.chr80, 
   xcbj002 LIKE xcbj_t.xcbj002, 
   xcbj003 LIKE xcbj_t.xcbj003, 
   xcbj001 LIKE xcbj_t.xcbj001, 
   xcbj001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcbj_d        RECORD
       xcbj004 LIKE xcbj_t.xcbj004, 
   xcbj004_desc LIKE type_t.chr500, 
   xcbj005 LIKE xcbj_t.xcbj005, 
   xcbj006 LIKE xcbj_t.xcbj006, 
   xcbj010 LIKE xcbj_t.xcbj010, 
   xcbj011 LIKE xcbj_t.xcbj011, 
   xcbj011_desc LIKE type_t.chr500, 
   xcbj021 LIKE xcbj_t.xcbj021, 
   xcbj020 LIKE xcbj_t.xcbj020, 
   xcbj101 LIKE xcbj_t.xcbj101, 
   xcbj102 LIKE xcbj_t.xcbj102, 
   xcbj103 LIKE xcbj_t.xcbj103, 
   xcbj104 LIKE xcbj_t.xcbj104, 
   xcbj105 LIKE xcbj_t.xcbj105
       END RECORD
PRIVATE TYPE type_g_xcbj2_d RECORD
       xcbj004 LIKE xcbj_t.xcbj004, 
   xcbj005 LIKE xcbj_t.xcbj005, 
   xcbj006 LIKE xcbj_t.xcbj006, 
   xcbjownid LIKE xcbj_t.xcbjownid, 
   xcbjownid_desc LIKE type_t.chr500, 
   xcbjowndp LIKE xcbj_t.xcbjowndp, 
   xcbjowndp_desc LIKE type_t.chr500, 
   xcbjcrtid LIKE xcbj_t.xcbjcrtid, 
   xcbjcrtid_desc LIKE type_t.chr500, 
   xcbjcrtdp LIKE xcbj_t.xcbjcrtdp, 
   xcbjcrtdp_desc LIKE type_t.chr500, 
   xcbjcrtdt DATETIME YEAR TO SECOND, 
   xcbjmodid LIKE xcbj_t.xcbjmodid, 
   xcbjmodid_desc LIKE type_t.chr500, 
   xcbjmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa019             LIKE glaa_t.glaa019
#fengmy150120---begin
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa022             LIKE glaa_t.glaa022
#fengmy150120---end

 TYPE type_g_xcbj3_d RECORD
       xcbj004 LIKE xcbj_t.xcbj004,
   xcbj004_desc LIKE type_t.chr500,   #160811-00015#1      
   xcbj005 LIKE xcbj_t.xcbj005, 
   xcbj006 LIKE xcbj_t.xcbj006, 
   xcbj010 LIKE xcbj_t.xcbj010, 
   xcbj011 LIKE xcbj_t.xcbj011,
   xcbj011_desc LIKE type_t.chr500,   #160811-00015#1 
   xcbj021 LIKE xcbj_t.xcbj021, 
   xcbj020 LIKE xcbj_t.xcbj020, 
   xcbj111 LIKE xcbj_t.xcbj111, 
   xcbj112 LIKE xcbj_t.xcbj112, 
   xcbj113 LIKE xcbj_t.xcbj113, 
   xcbj114 LIKE xcbj_t.xcbj114, 
   xcbj115 LIKE xcbj_t.xcbj115
       END RECORD
 TYPE type_g_xcbj4_d RECORD
       xcbj004 LIKE xcbj_t.xcbj004,
   xcbj004_desc LIKE type_t.chr500,   #160811-00015#1       
   xcbj005 LIKE xcbj_t.xcbj005, 
   xcbj006 LIKE xcbj_t.xcbj006, 
   xcbj010 LIKE xcbj_t.xcbj010, 
   xcbj011 LIKE xcbj_t.xcbj011,
   xcbj011_desc LIKE type_t.chr500,   #160811-00015#1   
   xcbj021 LIKE xcbj_t.xcbj021, 
   xcbj020 LIKE xcbj_t.xcbj020, 
   xcbj121 LIKE xcbj_t.xcbj121, 
   xcbj122 LIKE xcbj_t.xcbj122, 
   xcbj123 LIKE xcbj_t.xcbj123, 
   xcbj124 LIKE xcbj_t.xcbj124, 
   xcbj125 LIKE xcbj_t.xcbj125
       END RECORD
DEFINE g_xcbj3_d   DYNAMIC ARRAY OF type_g_xcbj3_d
DEFINE g_xcbj3_d_t type_g_xcbj3_d
DEFINE g_xcbj4_d   DYNAMIC ARRAY OF type_g_xcbj4_d
DEFINE g_xcbj4_d_t type_g_xcbj4_d
#160802-00020#5-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#5-e-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcbj_m          type_g_xcbj_m
DEFINE g_xcbj_m_t        type_g_xcbj_m
DEFINE g_xcbj_m_o        type_g_xcbj_m
DEFINE g_xcbj_m_mask_o   type_g_xcbj_m #轉換遮罩前資料
DEFINE g_xcbj_m_mask_n   type_g_xcbj_m #轉換遮罩後資料
 
   DEFINE g_xcbjld_t LIKE xcbj_t.xcbjld
DEFINE g_xcbj002_t LIKE xcbj_t.xcbj002
DEFINE g_xcbj003_t LIKE xcbj_t.xcbj003
DEFINE g_xcbj001_t LIKE xcbj_t.xcbj001
 
 
DEFINE g_xcbj_d          DYNAMIC ARRAY OF type_g_xcbj_d
DEFINE g_xcbj_d_t        type_g_xcbj_d
DEFINE g_xcbj_d_o        type_g_xcbj_d
DEFINE g_xcbj_d_mask_o   DYNAMIC ARRAY OF type_g_xcbj_d #轉換遮罩前資料
DEFINE g_xcbj_d_mask_n   DYNAMIC ARRAY OF type_g_xcbj_d #轉換遮罩後資料
DEFINE g_xcbj2_d   DYNAMIC ARRAY OF type_g_xcbj2_d
DEFINE g_xcbj2_d_t type_g_xcbj2_d
DEFINE g_xcbj2_d_o type_g_xcbj2_d
DEFINE g_xcbj2_d_mask_o   DYNAMIC ARRAY OF type_g_xcbj2_d #轉換遮罩前資料
DEFINE g_xcbj2_d_mask_n   DYNAMIC ARRAY OF type_g_xcbj2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcbjld LIKE xcbj_t.xcbjld,
      b_xcbj001 LIKE xcbj_t.xcbj001,
      b_xcbj002 LIKE xcbj_t.xcbj002,
      b_xcbj003 LIKE xcbj_t.xcbj003
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
 
{<section id="axct202.main" >}
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
   #160802-00020#5-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#5-e-add 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcbjcomp,'',xcbjld,'',xcbj002,xcbj003,xcbj001,''", 
                      " FROM xcbj_t",
                      " WHERE xcbjent= ? AND xcbjld=? AND xcbj001=? AND xcbj002=? AND xcbj003=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct202_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcbjcomp,t0.xcbjld,t0.xcbj002,t0.xcbj003,t0.xcbj001,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003",
               " FROM xcbj_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcbjcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xcbjld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xcbj001 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcbjent = " ||g_enterprise|| " AND t0.xcbjld = ? AND t0.xcbj001 = ? AND t0.xcbj002 = ? AND t0.xcbj003 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axct202_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct202 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct202_init()   
 
      #進入選單 Menu (="N")
      CALL axct202_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct202
      
   END IF 
   
   CLOSE axct202_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axct202.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct202_init()
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
   CALL cl_set_combo_scc('xcbj005','8908')
   CALL cl_set_combo_scc('xcbj006','8909')
   CALL cl_set_combo_scc('xcbj010','8014')
   
   CALL cl_set_combo_scc('xcbj005_3','8908')
   CALL cl_set_combo_scc('xcbj006_3','8909')
   CALL cl_set_combo_scc('xcbj010_3','8014')
   
   CALL cl_set_combo_scc('xcbj005_4','8908')
   CALL cl_set_combo_scc('xcbj006_4','8909')
   CALL cl_set_combo_scc('xcbj010_4','8014')
   #end add-point
   
   CALL axct202_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct202.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct202_ui_dialog()
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
         INITIALIZE g_xcbj_m.* TO NULL
         CALL g_xcbj_d.clear()
         CALL g_xcbj2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axct202_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcbj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct202_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axct202_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_xcbj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axct202_idx_chk()
               CALL axct202_ui_detailshow()
               
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
         DISPLAY ARRAY g_xcbj3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct202_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_xcbj4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct202_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page4自定義行為

            #end add-point
         
         END DISPLAY
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axct202_browser_fill("")
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
               CALL axct202_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct202_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axct202_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct202_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axct202_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct202_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axct202_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct202_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axct202_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct202_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axct202_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct202_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcbj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcbj2_d)
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
               NEXT FIELD xcbj004
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
               CALL axct202_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axct202_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axct202_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axct202_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axct202_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct202_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #160321-00028#1-add-(S)
               LET g_rep_wc = " xcbjent = ",g_enterprise," AND xcbjcomp = '",g_xcbj_m.xcbjcomp,"' AND xcbjld = '",g_xcbj_m.xcbjld,"'",
                              " AND xcbj001 = '",g_xcbj_m.xcbj001,"' AND xcbj002 = ",g_xcbj_m.xcbj002," AND xcbj003 = ",g_xcbj_m.xcbj003
               #160321-00028#1-add-(E)               
               #END add-point
               &include "erp/axc/axct202_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #160321-00028#1-add-(S)
               LET g_rep_wc = " xcbjent = ",g_enterprise," AND xcbjcomp = '",g_xcbj_m.xcbjcomp,"' AND xcbjld = '",g_xcbj_m.xcbjld,"'",
                              " AND xcbj001 = '",g_xcbj_m.xcbj001,"' AND xcbj002 = ",g_xcbj_m.xcbj002," AND xcbj003 = ",g_xcbj_m.xcbj003
               #160321-00028#1-add-(E)               
               #END add-point
               &include "erp/axc/axct202_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axct202_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axct202_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct202_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axct202_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct202_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct202_set_pk_array()
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
 
{<section id="axct202.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axct202_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct202.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct202_browser_fill(ps_page_action)
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
   
   #end add-point    
 
   LET l_searchcol = "xcbjld,xcbj001,xcbj002,xcbj003"
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
      LET l_sub_sql = " SELECT DISTINCT xcbjld ",
                      ", xcbj001 ",
                      ", xcbj002 ",
                      ", xcbj003 ",
 
                      " FROM xcbj_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcbjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcbj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcbjld ",
                      ", xcbj001 ",
                      ", xcbj002 ",
                      ", xcbj003 ",
 
                      " FROM xcbj_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcbjent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcbj_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
  #160802-00020#5-s-add  
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xcbjld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xcbjcomp IN ",g_wc_cs_comp
   END IF  
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
  #160802-00020#5-e-add
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
      INITIALIZE g_xcbj_m.* TO NULL
      CALL g_xcbj_d.clear()        
      CALL g_xcbj2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcbjld,t0.xcbj001,t0.xcbj002,t0.xcbj003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcbjld,t0.xcbj001,t0.xcbj002,t0.xcbj003",
                " FROM xcbj_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcbjent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcbj_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xcbjld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xcbjcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#5-e-add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcbj_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcbjld,g_browser[g_cnt].b_xcbj001,g_browser[g_cnt].b_xcbj002, 
          g_browser[g_cnt].b_xcbj003 
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
   
   IF cl_null(g_browser[g_cnt].b_xcbjld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcbj_m.* TO NULL
      CALL g_xcbj_d.clear()
      CALL g_xcbj2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axct202_fetch('')
   
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
 
{<section id="axct202.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct202_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcbj_m.xcbjld = g_browser[g_current_idx].b_xcbjld   
   LET g_xcbj_m.xcbj001 = g_browser[g_current_idx].b_xcbj001   
   LET g_xcbj_m.xcbj002 = g_browser[g_current_idx].b_xcbj002   
   LET g_xcbj_m.xcbj003 = g_browser[g_current_idx].b_xcbj003   
 
   EXECUTE axct202_master_referesh USING g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003 INTO g_xcbj_m.xcbjcomp, 
       g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,g_xcbj_m.xcbjcomp_desc,g_xcbj_m.xcbjld_desc, 
       g_xcbj_m.xcbj001_desc
   CALL axct202_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct202_ui_detailshow()
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
 
{<section id="axct202.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct202_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcbjld = g_xcbj_m.xcbjld 
         AND g_browser[l_i].b_xcbj001 = g_xcbj_m.xcbj001 
         AND g_browser[l_i].b_xcbj002 = g_xcbj_m.xcbj002 
         AND g_browser[l_i].b_xcbj003 = g_xcbj_m.xcbj003 
 
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
 
{<section id="axct202.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct202_construct()
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
   INITIALIZE g_xcbj_m.* TO NULL
   CALL g_xcbj_d.clear()
   CALL g_xcbj2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcbjcomp,xcbjld,xcbj002,xcbj003,xcbj001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xcbjcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjcomp
            #add-point:ON ACTION controlp INFIELD xcbjcomp name="construct.c.xcbjcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #160802-00020#5-s-add 
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
           #160802-00020#5-e-add             
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbjcomp  #顯示到畫面上
            NEXT FIELD xcbjcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjcomp
            #add-point:BEFORE FIELD xcbjcomp name="construct.b.xcbjcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjcomp
            
            #add-point:AFTER FIELD xcbjcomp name="construct.a.xcbjcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbjld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjld
            #add-point:ON ACTION controlp INFIELD xcbjld name="construct.c.xcbjld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#5-s-add
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept            
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#5-e-add              
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbjld  #顯示到畫面上
            NEXT FIELD xcbjld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjld
            #add-point:BEFORE FIELD xcbjld name="construct.b.xcbjld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjld
            
            #add-point:AFTER FIELD xcbjld name="construct.a.xcbjld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj002
            #add-point:BEFORE FIELD xcbj002 name="construct.b.xcbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj002
            
            #add-point:AFTER FIELD xcbj002 name="construct.a.xcbj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj002
            #add-point:ON ACTION controlp INFIELD xcbj002 name="construct.c.xcbj002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj003
            #add-point:BEFORE FIELD xcbj003 name="construct.b.xcbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj003
            
            #add-point:AFTER FIELD xcbj003 name="construct.a.xcbj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj003
            #add-point:ON ACTION controlp INFIELD xcbj003 name="construct.c.xcbj003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj001
            #add-point:ON ACTION controlp INFIELD xcbj001 name="construct.c.xcbj001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbj001  #顯示到畫面上
            NEXT FIELD xcbj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj001
            #add-point:BEFORE FIELD xcbj001 name="construct.b.xcbj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj001
            
            #add-point:AFTER FIELD xcbj001 name="construct.a.xcbj001"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcbj004,xcbj005,xcbj006,xcbj010,xcbj011,xcbj021,xcbj020,xcbj101,xcbj102, 
          xcbj103,xcbj104,xcbj105,xcbjownid,xcbjowndp,xcbjcrtid,xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt 
 
           FROM s_detail1[1].xcbj004,s_detail1[1].xcbj005,s_detail1[1].xcbj006,s_detail1[1].xcbj010, 
               s_detail1[1].xcbj011,s_detail1[1].xcbj021,s_detail1[1].xcbj020,s_detail1[1].xcbj101,s_detail1[1].xcbj102, 
               s_detail1[1].xcbj103,s_detail1[1].xcbj104,s_detail1[1].xcbj105,s_detail2[1].xcbjownid, 
               s_detail2[1].xcbjowndp,s_detail2[1].xcbjcrtid,s_detail2[1].xcbjcrtdp,s_detail2[1].xcbjcrtdt, 
               s_detail2[1].xcbjmodid,s_detail2[1].xcbjmoddt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xcbjcrtdt>>----
         AFTER FIELD xcbjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xcbjmoddt>>----
         AFTER FIELD xcbjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xcbjcnfdt>>----
         
         #----<<xcbjpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.xcbj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj004
            #add-point:ON ACTION controlp INFIELD xcbj004 name="construct.c.page1.xcbj004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbj004  #顯示到畫面上
            NEXT FIELD xcbj004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj004
            #add-point:BEFORE FIELD xcbj004 name="construct.b.page1.xcbj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj004
            
            #add-point:AFTER FIELD xcbj004 name="construct.a.page1.xcbj004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj005
            #add-point:BEFORE FIELD xcbj005 name="construct.b.page1.xcbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj005
            
            #add-point:AFTER FIELD xcbj005 name="construct.a.page1.xcbj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj005
            #add-point:ON ACTION controlp INFIELD xcbj005 name="construct.c.page1.xcbj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj006
            #add-point:BEFORE FIELD xcbj006 name="construct.b.page1.xcbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj006
            
            #add-point:AFTER FIELD xcbj006 name="construct.a.page1.xcbj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj006
            #add-point:ON ACTION controlp INFIELD xcbj006 name="construct.c.page1.xcbj006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj010
            #add-point:BEFORE FIELD xcbj010 name="construct.b.page1.xcbj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj010
            
            #add-point:AFTER FIELD xcbj010 name="construct.a.page1.xcbj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj010
            #add-point:ON ACTION controlp INFIELD xcbj010 name="construct.c.page1.xcbj010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj011
            #add-point:BEFORE FIELD xcbj011 name="construct.b.page1.xcbj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj011
            
            #add-point:AFTER FIELD xcbj011 name="construct.a.page1.xcbj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj011
            #add-point:ON ACTION controlp INFIELD xcbj011 name="construct.c.page1.xcbj011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE       
            #160419-00035#1---mod---begin
            #LET g_qryparam.where = " glac003 != '1' "
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_xcbj_m.xcbjld,"'",
                                   "                    AND glad035='N' AND gladstus='Y' )"
            #160419-00035#1---mod---end            
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbj011  #顯示到畫面上
            NEXT FIELD xcbj011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj021
            #add-point:BEFORE FIELD xcbj021 name="construct.b.page1.xcbj021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj021
            
            #add-point:AFTER FIELD xcbj021 name="construct.a.page1.xcbj021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj021
            #add-point:ON ACTION controlp INFIELD xcbj021 name="construct.c.page1.xcbj021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj020
            #add-point:BEFORE FIELD xcbj020 name="construct.b.page1.xcbj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj020
            
            #add-point:AFTER FIELD xcbj020 name="construct.a.page1.xcbj020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj020
            #add-point:ON ACTION controlp INFIELD xcbj020 name="construct.c.page1.xcbj020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj101
            #add-point:BEFORE FIELD xcbj101 name="construct.b.page1.xcbj101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj101
            
            #add-point:AFTER FIELD xcbj101 name="construct.a.page1.xcbj101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj101
            #add-point:ON ACTION controlp INFIELD xcbj101 name="construct.c.page1.xcbj101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj102
            #add-point:BEFORE FIELD xcbj102 name="construct.b.page1.xcbj102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj102
            
            #add-point:AFTER FIELD xcbj102 name="construct.a.page1.xcbj102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj102
            #add-point:ON ACTION controlp INFIELD xcbj102 name="construct.c.page1.xcbj102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj103
            #add-point:BEFORE FIELD xcbj103 name="construct.b.page1.xcbj103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj103
            
            #add-point:AFTER FIELD xcbj103 name="construct.a.page1.xcbj103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj103
            #add-point:ON ACTION controlp INFIELD xcbj103 name="construct.c.page1.xcbj103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj104
            #add-point:BEFORE FIELD xcbj104 name="construct.b.page1.xcbj104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj104
            
            #add-point:AFTER FIELD xcbj104 name="construct.a.page1.xcbj104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj104
            #add-point:ON ACTION controlp INFIELD xcbj104 name="construct.c.page1.xcbj104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj105
            #add-point:BEFORE FIELD xcbj105 name="construct.b.page1.xcbj105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj105
            
            #add-point:AFTER FIELD xcbj105 name="construct.a.page1.xcbj105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbj105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj105
            #add-point:ON ACTION controlp INFIELD xcbj105 name="construct.c.page1.xcbj105"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcbjownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjownid
            #add-point:ON ACTION controlp INFIELD xcbjownid name="construct.c.page2.xcbjownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbjownid  #顯示到畫面上
            NEXT FIELD xcbjownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjownid
            #add-point:BEFORE FIELD xcbjownid name="construct.b.page2.xcbjownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjownid
            
            #add-point:AFTER FIELD xcbjownid name="construct.a.page2.xcbjownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbjowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjowndp
            #add-point:ON ACTION controlp INFIELD xcbjowndp name="construct.c.page2.xcbjowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbjowndp  #顯示到畫面上
            NEXT FIELD xcbjowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjowndp
            #add-point:BEFORE FIELD xcbjowndp name="construct.b.page2.xcbjowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjowndp
            
            #add-point:AFTER FIELD xcbjowndp name="construct.a.page2.xcbjowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbjcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjcrtid
            #add-point:ON ACTION controlp INFIELD xcbjcrtid name="construct.c.page2.xcbjcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbjcrtid  #顯示到畫面上
            NEXT FIELD xcbjcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjcrtid
            #add-point:BEFORE FIELD xcbjcrtid name="construct.b.page2.xcbjcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjcrtid
            
            #add-point:AFTER FIELD xcbjcrtid name="construct.a.page2.xcbjcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcbjcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjcrtdp
            #add-point:ON ACTION controlp INFIELD xcbjcrtdp name="construct.c.page2.xcbjcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbjcrtdp  #顯示到畫面上
            NEXT FIELD xcbjcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjcrtdp
            #add-point:BEFORE FIELD xcbjcrtdp name="construct.b.page2.xcbjcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjcrtdp
            
            #add-point:AFTER FIELD xcbjcrtdp name="construct.a.page2.xcbjcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjcrtdt
            #add-point:BEFORE FIELD xcbjcrtdt name="construct.b.page2.xcbjcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xcbjmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjmodid
            #add-point:ON ACTION controlp INFIELD xcbjmodid name="construct.c.page2.xcbjmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbjmodid  #顯示到畫面上
            NEXT FIELD xcbjmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjmodid
            #add-point:BEFORE FIELD xcbjmodid name="construct.b.page2.xcbjmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjmodid
            
            #add-point:AFTER FIELD xcbjmodid name="construct.a.page2.xcbjmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjmoddt
            #add-point:BEFORE FIELD xcbjmoddt name="construct.b.page2.xcbjmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         DISPLAY ARRAY g_xcbj_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #dorislai-20151027-add----(S)
         #預設當前site的法人,主帳套,年度期別,成本計算類型
         CALL s_axc_set_site_default() RETURNING g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001
         DISPLAY BY NAME g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001
         #dorislai-20151027-add----(E)
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
 
{<section id="axct202.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct202_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   
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
   CALL g_xcbj_d.clear()
   CALL g_xcbj2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axct202_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axct202_browser_fill(g_wc)
      CALL axct202_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axct202_browser_fill("F")
   
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
      CALL axct202_fetch("F") 
   END IF
   
   CALL axct202_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct202_fetch(p_flag)
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
   
   #CALL axct202_browser_fill(p_flag)
   
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
   
   LET g_xcbj_m.xcbjld = g_browser[g_current_idx].b_xcbjld
   LET g_xcbj_m.xcbj001 = g_browser[g_current_idx].b_xcbj001
   LET g_xcbj_m.xcbj002 = g_browser[g_current_idx].b_xcbj002
   LET g_xcbj_m.xcbj003 = g_browser[g_current_idx].b_xcbj003
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct202_master_referesh USING g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003 INTO g_xcbj_m.xcbjcomp, 
       g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,g_xcbj_m.xcbjcomp_desc,g_xcbj_m.xcbjld_desc, 
       g_xcbj_m.xcbj001_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcbj_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcbj_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcbj_m_mask_o.* =  g_xcbj_m.*
   CALL axct202_xcbj_t_mask()
   LET g_xcbj_m_mask_n.* =  g_xcbj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct202_set_act_visible()
   CALL axct202_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcbj_m_t.* = g_xcbj_m.*
   LET g_xcbj_m_o.* = g_xcbj_m.*
   
   #重新顯示   
   CALL axct202_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct202.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct202_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcbj_d.clear()
   CALL g_xcbj2_d.clear()
 
 
   INITIALIZE g_xcbj_m.* TO NULL             #DEFAULT 設定
   LET g_xcbjld_t = NULL
   LET g_xcbj001_t = NULL
   LET g_xcbj002_t = NULL
   LET g_xcbj003_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      #150105  fengmy--begin
      #预设当前site的法人，主账套，年度期别，成本计算类型
      CALL s_axc_set_site_default() RETURNING g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001
      DISPLAY BY NAME g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001
      CALL axct202_show_ref()
      #150105  fengmy--end
      #end add-point 
 
      CALL axct202_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcbj_m.* TO NULL
         INITIALIZE g_xcbj_d TO NULL
         INITIALIZE g_xcbj2_d TO NULL
 
         CALL axct202_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcbj_m.* = g_xcbj_m_t.*
         CALL axct202_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcbj_d.clear()
      #CALL g_xcbj2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct202_set_act_visible()
   CALL axct202_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcbjld_t = g_xcbj_m.xcbjld
   LET g_xcbj001_t = g_xcbj_m.xcbj001
   LET g_xcbj002_t = g_xcbj_m.xcbj002
   LET g_xcbj003_t = g_xcbj_m.xcbj003
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbjent = " ||g_enterprise|| " AND",
                      " xcbjld = '", g_xcbj_m.xcbjld, "' "
                      ," AND xcbj001 = '", g_xcbj_m.xcbj001, "' "
                      ," AND xcbj002 = '", g_xcbj_m.xcbj002, "' "
                      ," AND xcbj003 = '", g_xcbj_m.xcbj003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct202_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axct202_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axct202_master_referesh USING g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003 INTO g_xcbj_m.xcbjcomp, 
       g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,g_xcbj_m.xcbjcomp_desc,g_xcbj_m.xcbjld_desc, 
       g_xcbj_m.xcbj001_desc
   
   #遮罩相關處理
   LET g_xcbj_m_mask_o.* =  g_xcbj_m.*
   CALL axct202_xcbj_t_mask()
   LET g_xcbj_m_mask_n.* =  g_xcbj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjcomp_desc,g_xcbj_m.xcbjld,g_xcbj_m.xcbjld_desc,g_xcbj_m.xcbj002, 
       g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,g_xcbj_m.xcbj001_desc
   
   #功能已完成,通報訊息中心
   CALL axct202_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct202_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcbj_m.xcbjld IS NULL
   OR g_xcbj_m.xcbj001 IS NULL
   OR g_xcbj_m.xcbj002 IS NULL
   OR g_xcbj_m.xcbj003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcbjld_t = g_xcbj_m.xcbjld
   LET g_xcbj001_t = g_xcbj_m.xcbj001
   LET g_xcbj002_t = g_xcbj_m.xcbj002
   LET g_xcbj003_t = g_xcbj_m.xcbj003
 
   CALL s_transaction_begin()
   
   OPEN axct202_cl USING g_enterprise,g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct202_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct202_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct202_master_referesh USING g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003 INTO g_xcbj_m.xcbjcomp, 
       g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,g_xcbj_m.xcbjcomp_desc,g_xcbj_m.xcbjld_desc, 
       g_xcbj_m.xcbj001_desc
   
   #遮罩相關處理
   LET g_xcbj_m_mask_o.* =  g_xcbj_m.*
   CALL axct202_xcbj_t_mask()
   LET g_xcbj_m_mask_n.* =  g_xcbj_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axct202_show()
   WHILE TRUE
      LET g_xcbjld_t = g_xcbj_m.xcbjld
      LET g_xcbj001_t = g_xcbj_m.xcbj001
      LET g_xcbj002_t = g_xcbj_m.xcbj002
      LET g_xcbj003_t = g_xcbj_m.xcbj003
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axct202_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcbj_m.* = g_xcbj_m_t.*
         CALL axct202_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcbj_m.xcbjld != g_xcbjld_t 
      OR g_xcbj_m.xcbj001 != g_xcbj001_t 
      OR g_xcbj_m.xcbj002 != g_xcbj002_t 
      OR g_xcbj_m.xcbj003 != g_xcbj003_t 
 
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
   CALL axct202_set_act_visible()
   CALL axct202_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcbjent = " ||g_enterprise|| " AND",
                      " xcbjld = '", g_xcbj_m.xcbjld, "' "
                      ," AND xcbj001 = '", g_xcbj_m.xcbj001, "' "
                      ," AND xcbj002 = '", g_xcbj_m.xcbj002, "' "
                      ," AND xcbj003 = '", g_xcbj_m.xcbj003, "' "
 
   #填到對應位置
   CALL axct202_browser_fill("")
 
   CALL axct202_idx_chk()
 
   CLOSE axct202_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct202_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axct202.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct202_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_rate                LIKE type_t.num26_10    #fengmy150120
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
   DISPLAY BY NAME g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjcomp_desc,g_xcbj_m.xcbjld,g_xcbj_m.xcbjld_desc,g_xcbj_m.xcbj002, 
       g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,g_xcbj_m.xcbj001_desc
   
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
   LET g_forupd_sql = "SELECT xcbj004,xcbj005,xcbj006,xcbj010,xcbj011,xcbj021,xcbj020,xcbj101,xcbj102, 
       xcbj103,xcbj104,xcbj105,xcbj004,xcbj005,xcbj006,xcbjownid,xcbjowndp,xcbjcrtid,xcbjcrtdp,xcbjcrtdt, 
       xcbjmodid,xcbjmoddt FROM xcbj_t WHERE xcbjent=? AND xcbjld=? AND xcbj001=? AND xcbj002=? AND  
       xcbj003=? AND xcbj004=? AND xcbj005=? AND xcbj006=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct202_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct202_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axct202_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001 
 
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct202.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            #160419-00039#1---add---begin
            SELECT glaa001,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022 
              INTO g_glaa001,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022 
              FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_xcbj_m.xcbjld            
            CALL axct202_visible()
            #160419-00039#1---add---end
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjcomp
            
            #add-point:AFTER FIELD xcbjcomp name="input.a.xcbjcomp"
            CALL axct202_show_ref()
            
            IF NOT cl_null(g_xcbj_m.xcbjcomp) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               #fengmy ---150105--begin
               IF NOT cl_null(g_xcbj_m.xcbjcomp) THEN
                  IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xcbj_m_t.xcbjcomp IS NULL OR g_xcbj_m.xcbjcomp != g_xcbj_m_t.xcbjcomp)) THEN
                     IF NOT s_axc_chk_ld_comp(g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld) THEN
                        LET g_xcbj_m.xcbjcomp = g_xcbj_m_t.xcbjcomp
                        NEXT FIELD CURRENT
                     END IF
                  END IF               
               END IF
               #fengmy ---150105--end
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbj_m.xcbjcomp
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbj_m.xcbjcomp = g_xcbj_m_t.xcbjcomp
                  CALL axct202_show_ref()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjcomp
            #add-point:BEFORE FIELD xcbjcomp name="input.b.xcbjcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbjcomp
            #add-point:ON CHANGE xcbjcomp name="input.g.xcbjcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjld
            
            #add-point:AFTER FIELD xcbjld name="input.a.xcbjld"
            #此段落由子樣板a05產生
            #fengmy ----150105--begin
            IF NOT cl_null(g_xcbj_m.xcbjld) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xcbj_m_t.xcbjld IS NULL OR g_xcbj_m.xcbjld != g_xcbj_m_t.xcbjld)) THEN
                  IF NOT s_axc_chk_ld_comp(g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld) THEN
                     LET g_xcbj_m.xcbjld = g_xcbj_m_t.xcbjld
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF  
            #fengmy ----150105--end  
            IF  NOT cl_null(g_xcbj_m.xcbjld) AND NOT cl_null(g_xcbj_m.xcbj001) AND NOT cl_null(g_xcbj_m.xcbj002) AND NOT cl_null(g_xcbj_m.xcbj003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbj_m.xcbjld != g_xcbjld_t  OR g_xcbj_m.xcbj001 != g_xcbj001_t  OR g_xcbj_m.xcbj002 != g_xcbj002_t  OR g_xcbj_m.xcbj003 != g_xcbj003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbj_t WHERE "||"xcbjent = '" ||g_enterprise|| "' AND "||"xcbjld = '"||g_xcbj_m.xcbjld ||"' AND "|| "xcbj001 = '"||g_xcbj_m.xcbj001 ||"' AND "|| "xcbj002 = '"||g_xcbj_m.xcbj002 ||"' AND "|| "xcbj003 = '"||g_xcbj_m.xcbj003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            CALL axct202_show_ref()
            IF NOT cl_null(g_xcbj_m.xcbjld) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbj_m.xcbjld
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#11--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL axct202_visible()
                  CALL s_ld_chk_authorization(g_user,g_xcbj_m.xcbjld) RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_xcbj_m.xcbjld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_xcbj_m.xcbjld = ''
                     CALL axct202_show_ref()
                     NEXT FIELD CURRENT
                  END IF 
                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbj_m.xcbjld = g_xcbj_m_t.xcbjld
                  CALL axct202_show_ref()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            

            #fengmy150120---begin
            SELECT glaa001,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022 
              INTO g_glaa001,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022 
              FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_xcbj_m.xcbjld
            #fengmy150120---end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjld
            #add-point:BEFORE FIELD xcbjld name="input.b.xcbjld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbjld
            #add-point:ON CHANGE xcbjld name="input.g.xcbjld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj002
            #add-point:BEFORE FIELD xcbj002 name="input.b.xcbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj002
            
            #add-point:AFTER FIELD xcbj002 name="input.a.xcbj002"
            #此段落由子樣板a05產生
            #fengmy ----150105--begin
            IF NOT cl_null(g_xcbj_m.xcbj002) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xcbj_m_t.xcbj002 IS NULL OR g_xcbj_m.xcbj002 != g_xcbj_m_t.xcbj002)) THEN
                  IF NOT axct202_chk_year_period() THEN
                     LET g_xcbj_m.xcbj002 = g_xcbj_m_t.xcbj002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #fengmy ----150105--end  
            IF  NOT cl_null(g_xcbj_m.xcbjld) AND NOT cl_null(g_xcbj_m.xcbj001) AND NOT cl_null(g_xcbj_m.xcbj002) AND NOT cl_null(g_xcbj_m.xcbj003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbj_m.xcbjld != g_xcbjld_t  OR g_xcbj_m.xcbj001 != g_xcbj001_t  OR g_xcbj_m.xcbj002 != g_xcbj002_t  OR g_xcbj_m.xcbj003 != g_xcbj003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbj_t WHERE "||"xcbjent = '" ||g_enterprise|| "' AND "||"xcbjld = '"||g_xcbj_m.xcbjld ||"' AND "|| "xcbj001 = '"||g_xcbj_m.xcbj001 ||"' AND "|| "xcbj002 = '"||g_xcbj_m.xcbj002 ||"' AND "|| "xcbj003 = '"||g_xcbj_m.xcbj003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj002
            #add-point:ON CHANGE xcbj002 name="input.g.xcbj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj003
            #add-point:BEFORE FIELD xcbj003 name="input.b.xcbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj003
            
            #add-point:AFTER FIELD xcbj003 name="input.a.xcbj003"
            #此段落由子樣板a05產生
            #fengmy ----150105--begin
            IF NOT cl_null(g_xcbj_m.xcbj003) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xcbj_m_t.xcbj003 IS NULL OR g_xcbj_m.xcbj003 != g_xcbj_m_t.xcbj003)) THEN
                  IF NOT axct202_chk_year_period() THEN
                     LET g_xcbj_m.xcbj003 = g_xcbj_m_t.xcbj003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #fengmy ----150105--end  
            IF  NOT cl_null(g_xcbj_m.xcbjld) AND NOT cl_null(g_xcbj_m.xcbj001) AND NOT cl_null(g_xcbj_m.xcbj002) AND NOT cl_null(g_xcbj_m.xcbj003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbj_m.xcbjld != g_xcbjld_t  OR g_xcbj_m.xcbj001 != g_xcbj001_t  OR g_xcbj_m.xcbj002 != g_xcbj002_t  OR g_xcbj_m.xcbj003 != g_xcbj003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbj_t WHERE "||"xcbjent = '" ||g_enterprise|| "' AND "||"xcbjld = '"||g_xcbj_m.xcbjld ||"' AND "|| "xcbj001 = '"||g_xcbj_m.xcbj001 ||"' AND "|| "xcbj002 = '"||g_xcbj_m.xcbj002 ||"' AND "|| "xcbj003 = '"||g_xcbj_m.xcbj003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj003
            #add-point:ON CHANGE xcbj003 name="input.g.xcbj003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj001
            
            #add-point:AFTER FIELD xcbj001 name="input.a.xcbj001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xcbj_m.xcbjld) AND NOT cl_null(g_xcbj_m.xcbj001) AND NOT cl_null(g_xcbj_m.xcbj002) AND NOT cl_null(g_xcbj_m.xcbj003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcbj_m.xcbjld != g_xcbjld_t  OR g_xcbj_m.xcbj001 != g_xcbj001_t  OR g_xcbj_m.xcbj002 != g_xcbj002_t  OR g_xcbj_m.xcbj003 != g_xcbj003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbj_t WHERE "||"xcbjent = '" ||g_enterprise|| "' AND "||"xcbjld = '"||g_xcbj_m.xcbjld ||"' AND "|| "xcbj001 = '"||g_xcbj_m.xcbj001 ||"' AND "|| "xcbj002 = '"||g_xcbj_m.xcbj002 ||"' AND "|| "xcbj003 = '"||g_xcbj_m.xcbj003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            CALL axct202_show_ref()
            IF NOT cl_null(g_xcbj_m.xcbj001) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbj_m.xcbj001
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#11--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbj_m.xcbj001 = g_xcbj_m_t.xcbj001
                  CALL axct202_show_ref()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj001
            #add-point:BEFORE FIELD xcbj001 name="input.b.xcbj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj001
            #add-point:ON CHANGE xcbj001 name="input.g.xcbj001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcbjcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjcomp
            #add-point:ON ACTION controlp INFIELD xcbjcomp name="input.c.xcbjcomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbj_m.xcbjcomp             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_2()                                #呼叫開窗

            LET g_xcbj_m.xcbjcomp = g_qryparam.return1              
            CALL axct202_show_ref()
            DISPLAY g_xcbj_m.xcbjcomp TO xcbjcomp              #

            NEXT FIELD xcbjcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbjld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjld
            #add-point:ON ACTION controlp INFIELD xcbjld name="input.c.xcbjld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbj_m.xcbjld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            #fengmyadd 150116
            IF NOT cl_null(g_xcbj_m.xcbjcomp) THEN
               LET g_qryparam.where = " glaald IN(SELECT glaald FROM glaa_t WHERE glaaent = '",g_enterprise,"'",
                                      "    AND glaastus ='Y' AND glaacomp ='",g_xcbj_m.xcbjcomp,"')"
            END IF
            #fengmyadd 150116            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcbj_m.xcbjld = g_qryparam.return1              
            CALL axct202_show_ref()
            DISPLAY g_xcbj_m.xcbjld TO xcbjld              #

            NEXT FIELD xcbjld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj002
            #add-point:ON ACTION controlp INFIELD xcbj002 name="input.c.xcbj002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj003
            #add-point:ON ACTION controlp INFIELD xcbj003 name="input.c.xcbj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj001
            #add-point:ON ACTION controlp INFIELD xcbj001 name="input.c.xcbj001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbj_m.xcbj001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcbj_m.xcbj001 = g_qryparam.return1              
            CALL axct202_show_ref()
            DISPLAY g_xcbj_m.xcbj001 TO xcbj001              #

            NEXT FIELD xcbj001                          #返回原欄位


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
            DISPLAY BY NAME g_xcbj_m.xcbjld             
                            ,g_xcbj_m.xcbj001   
                            ,g_xcbj_m.xcbj002   
                            ,g_xcbj_m.xcbj003   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
 
               #end add-point
            
               #將遮罩欄位還原
               CALL axct202_xcbj_t_mask_restore('restore_mask_o')
            
               UPDATE xcbj_t SET (xcbjcomp,xcbjld,xcbj002,xcbj003,xcbj001) = (g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld, 
                   g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001)
                WHERE xcbjent = g_enterprise AND xcbjld = g_xcbjld_t
                  AND xcbj001 = g_xcbj001_t
                  AND xcbj002 = g_xcbj002_t
                  AND xcbj003 = g_xcbj003_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbj_m.xcbjld
               LET gs_keys_bak[1] = g_xcbjld_t
               LET gs_keys[2] = g_xcbj_m.xcbj001
               LET gs_keys_bak[2] = g_xcbj001_t
               LET gs_keys[3] = g_xcbj_m.xcbj002
               LET gs_keys_bak[3] = g_xcbj002_t
               LET gs_keys[4] = g_xcbj_m.xcbj003
               LET gs_keys_bak[4] = g_xcbj003_t
               LET gs_keys[5] = g_xcbj_d[g_detail_idx].xcbj004
               LET gs_keys_bak[5] = g_xcbj_d_t.xcbj004
               LET gs_keys[6] = g_xcbj_d[g_detail_idx].xcbj005
               LET gs_keys_bak[6] = g_xcbj_d_t.xcbj005
               LET gs_keys[7] = g_xcbj_d[g_detail_idx].xcbj006
               LET gs_keys_bak[7] = g_xcbj_d_t.xcbj006
               CALL axct202_update_b('xcbj_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcbj_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcbj_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axct202_xcbj_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct202_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcbjld_t = g_xcbj_m.xcbjld
           LET g_xcbj001_t = g_xcbj_m.xcbj001
           LET g_xcbj002_t = g_xcbj_m.xcbj002
           LET g_xcbj003_t = g_xcbj_m.xcbj003
 
           
           IF g_xcbj_d.getLength() = 0 THEN
              NEXT FIELD xcbj004
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axct202.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcbj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcbj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct202_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            #fengmy150120---begin
            SELECT glaa001,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022 
              INTO g_glaa001,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022 
              FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_xcbj_m.xcbjld
            #fengmy150120---end
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
            CALL axct202_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct202_cl USING g_enterprise,g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axct202_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct202_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcbj_d[l_ac].xcbj004 IS NOT NULL
               AND g_xcbj_d[l_ac].xcbj005 IS NOT NULL
               AND g_xcbj_d[l_ac].xcbj006 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcbj_d_t.* = g_xcbj_d[l_ac].*  #BACKUP
               LET g_xcbj_d_o.* = g_xcbj_d[l_ac].*  #BACKUP
               CALL axct202_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axct202_set_no_entry_b(l_cmd)
               OPEN axct202_bcl USING g_enterprise,g_xcbj_m.xcbjld,
                                                g_xcbj_m.xcbj001,
                                                g_xcbj_m.xcbj002,
                                                g_xcbj_m.xcbj003,
 
                                                g_xcbj_d_t.xcbj004
                                                ,g_xcbj_d_t.xcbj005
                                                ,g_xcbj_d_t.xcbj006
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct202_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct202_bcl INTO g_xcbj_d[l_ac].xcbj004,g_xcbj_d[l_ac].xcbj005,g_xcbj_d[l_ac].xcbj006, 
                      g_xcbj_d[l_ac].xcbj010,g_xcbj_d[l_ac].xcbj011,g_xcbj_d[l_ac].xcbj021,g_xcbj_d[l_ac].xcbj020, 
                      g_xcbj_d[l_ac].xcbj101,g_xcbj_d[l_ac].xcbj102,g_xcbj_d[l_ac].xcbj103,g_xcbj_d[l_ac].xcbj104, 
                      g_xcbj_d[l_ac].xcbj105,g_xcbj2_d[l_ac].xcbj004,g_xcbj2_d[l_ac].xcbj005,g_xcbj2_d[l_ac].xcbj006, 
                      g_xcbj2_d[l_ac].xcbjownid,g_xcbj2_d[l_ac].xcbjowndp,g_xcbj2_d[l_ac].xcbjcrtid, 
                      g_xcbj2_d[l_ac].xcbjcrtdp,g_xcbj2_d[l_ac].xcbjcrtdt,g_xcbj2_d[l_ac].xcbjmodid, 
                      g_xcbj2_d[l_ac].xcbjmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcbj_d_t.xcbj004,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcbj_d_mask_o[l_ac].* =  g_xcbj_d[l_ac].*
                  CALL axct202_xcbj_t_mask()
                  LET g_xcbj_d_mask_n[l_ac].* =  g_xcbj_d[l_ac].*
                  
                  CALL axct202_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL axct202_show_ref()
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xcbj_d_t.* TO NULL
            INITIALIZE g_xcbj_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcbj_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xcbj2_d[l_ac].xcbjownid = g_user
      LET g_xcbj2_d[l_ac].xcbjowndp = g_dept
      LET g_xcbj2_d[l_ac].xcbjcrtid = g_user
      LET g_xcbj2_d[l_ac].xcbjcrtdp = g_dept 
      LET g_xcbj2_d[l_ac].xcbjcrtdt = cl_get_current()
      LET g_xcbj2_d[l_ac].xcbjmodid = g_user
      LET g_xcbj2_d[l_ac].xcbjmoddt = cl_get_current()
 
 
  
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcbj_d_t.* = g_xcbj_d[l_ac].*     #新輸入資料
            LET g_xcbj_d_o.* = g_xcbj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct202_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axct202_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcbj_d[li_reproduce_target].* = g_xcbj_d[li_reproduce].*
               LET g_xcbj2_d[li_reproduce_target].* = g_xcbj2_d[li_reproduce].*
 
               LET g_xcbj_d[g_xcbj_d.getLength()].xcbj004 = NULL
               LET g_xcbj_d[g_xcbj_d.getLength()].xcbj005 = NULL
               LET g_xcbj_d[g_xcbj_d.getLength()].xcbj006 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_xcbj_d[l_ac].xcbj021 = 0
            LET g_xcbj_d[l_ac].xcbj020 = 0
            LET g_xcbj_d[l_ac].xcbj101 = 0
            LET g_xcbj_d[l_ac].xcbj102 = 0
            LET g_xcbj_d[l_ac].xcbj103 = 0
            LET g_xcbj_d[l_ac].xcbj104 = 0
            LET g_xcbj_d[l_ac].xcbj105 = 0
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
            SELECT COUNT(1) INTO l_count FROM xcbj_t 
             WHERE xcbjent = g_enterprise AND xcbjld = g_xcbj_m.xcbjld
               AND xcbj001 = g_xcbj_m.xcbj001
               AND xcbj002 = g_xcbj_m.xcbj002
               AND xcbj003 = g_xcbj_m.xcbj003
 
               AND xcbj004 = g_xcbj_d[l_ac].xcbj004
               AND xcbj005 = g_xcbj_d[l_ac].xcbj005
               AND xcbj006 = g_xcbj_d[l_ac].xcbj006
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
#               LET l_n = 0
#               SELECT COUNT(*) INTO l_n
#                 FROM xcba_t
#                WHERE xcbaent = g_enterprise
#                  AND xcbald = g_xcbj_m.xcbjld
#                  AND xcba004 = g_xcbj_d[l_ac].xcbj004
#                  AND xcba001 = g_xcbj_d[l_ac].xcbj005
#                  AND xcba007 = g_xcbj_d[l_ac].xcbj006
#               IF l_n = 0 THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'axc-00302'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CANCEL INSERT
#               END IF
               #fengmy150120--begin
               LET g_xcbj_d[l_ac].xcbj101 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj101,2)
               LET g_xcbj_d[l_ac].xcbj102 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj102,2)
               LET g_xcbj_d[l_ac].xcbj103 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj103,2)
               LET g_xcbj_d[l_ac].xcbj104 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj104,2)
               #LET g_xcbj_d[l_ac].xcbj105 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj105,2)  #20150709 mark lujh
               IF g_glaa015 = 'Y' OR g_glaa019 = 'Y' THEN
                  IF g_glaa015 = 'Y' THEN
                     CALL s_aooi160_get_exrate('2',g_xcbj_m.xcbjld,g_today,g_glaa001,    #fengmy150120
                                                    #目的幣別;  交易金額;              匯類類型
                                                     g_glaa016,0,g_glaa018)
                              RETURNING l_rate
                     LET g_xcbj3_d[l_ac].xcbj111 = g_xcbj_d[l_ac].xcbj101 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj112 = g_xcbj_d[l_ac].xcbj102 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj113 = g_xcbj_d[l_ac].xcbj103 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj114 = g_xcbj_d[l_ac].xcbj104 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj115 = g_xcbj_d[l_ac].xcbj105 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj111 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj111,2)
                     LET g_xcbj3_d[l_ac].xcbj112 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj112,2)
                     LET g_xcbj3_d[l_ac].xcbj113 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj113,2)
                     LET g_xcbj3_d[l_ac].xcbj114 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj114,2)
                     #LET g_xcbj3_d[l_ac].xcbj115 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj115,2)  #20150709 mark lujh
                  END IF
                  IF g_glaa019 = 'Y' THEN
                     CALL s_aooi160_get_exrate('2',g_xcbj_m.xcbjld,g_today,g_glaa001,    #fengmy150120
                                                    #目的幣別;  交易金額;              匯類類型
                                                     g_glaa020,0,g_glaa022)
                              RETURNING l_rate
                     LET g_xcbj4_d[l_ac].xcbj121 = g_xcbj_d[l_ac].xcbj101 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj122 = g_xcbj_d[l_ac].xcbj102 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj123 = g_xcbj_d[l_ac].xcbj103 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj124 = g_xcbj_d[l_ac].xcbj104 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj125 = g_xcbj_d[l_ac].xcbj105 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj121 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj121,2)
                     LET g_xcbj4_d[l_ac].xcbj122 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj122,2)
                     LET g_xcbj4_d[l_ac].xcbj123 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj123,2)
                     LET g_xcbj4_d[l_ac].xcbj124 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj124,2)
                     #LET g_xcbj4_d[l_ac].xcbj125 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj125,2)  #20150709 mark lujh
                  END IF
                  INSERT INTO xcbj_t
                           (xcbjent,
                            xcbjcomp,xcbjld,xcbj002,xcbj003,xcbj001,
                            xcbj004,xcbj005,xcbj006
                            ,xcbj010,xcbj011,xcbj021,xcbj020,
                            xcbj101,xcbj102,xcbj103,xcbj104,xcbj105,
                            xcbj111,xcbj112,xcbj113,xcbj114,xcbj115,
                            xcbj121,xcbj122,xcbj123,xcbj124,xcbj125,
                            xcbjownid,xcbjowndp,xcbjcrtid,xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt) 
                     VALUES(g_enterprise,
                            g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,
                            g_xcbj_d[l_ac].xcbj004,g_xcbj_d[l_ac].xcbj005,g_xcbj_d[l_ac].xcbj006
                            ,g_xcbj_d[l_ac].xcbj010,g_xcbj_d[l_ac].xcbj011,g_xcbj_d[l_ac].xcbj021,g_xcbj_d[l_ac].xcbj020, 
                                g_xcbj_d[l_ac].xcbj101,g_xcbj_d[l_ac].xcbj102,g_xcbj_d[l_ac].xcbj103, 
                                g_xcbj_d[l_ac].xcbj104,g_xcbj_d[l_ac].xcbj105,
                                g_xcbj3_d[l_ac].xcbj111,g_xcbj3_d[l_ac].xcbj112,g_xcbj3_d[l_ac].xcbj113, 
                                g_xcbj3_d[l_ac].xcbj114,g_xcbj3_d[l_ac].xcbj115,
                                g_xcbj4_d[l_ac].xcbj121,g_xcbj4_d[l_ac].xcbj122,g_xcbj4_d[l_ac].xcbj123, 
                                g_xcbj4_d[l_ac].xcbj124,g_xcbj4_d[l_ac].xcbj125,
                                g_xcbj2_d[l_ac].xcbjownid, 
                                g_xcbj2_d[l_ac].xcbjowndp,g_xcbj2_d[l_ac].xcbjcrtid,g_xcbj2_d[l_ac].xcbjcrtdp, 
                                g_xcbj2_d[l_ac].xcbjcrtdt,g_xcbj2_d[l_ac].xcbjmodid,g_xcbj2_d[l_ac].xcbjmoddt) 
               ELSE 
               #fengmy150120---end               
               #end add-point
               INSERT INTO xcbj_t
                           (xcbjent,
                            xcbjcomp,xcbjld,xcbj002,xcbj003,xcbj001,
                            xcbj004,xcbj005,xcbj006
                            ,xcbj010,xcbj011,xcbj021,xcbj020,xcbj101,xcbj102,xcbj103,xcbj104,xcbj105,xcbjownid,xcbjowndp,xcbjcrtid,xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt) 
                     VALUES(g_enterprise,
                            g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,
                            g_xcbj_d[l_ac].xcbj004,g_xcbj_d[l_ac].xcbj005,g_xcbj_d[l_ac].xcbj006
                            ,g_xcbj_d[l_ac].xcbj010,g_xcbj_d[l_ac].xcbj011,g_xcbj_d[l_ac].xcbj021,g_xcbj_d[l_ac].xcbj020, 
                                g_xcbj_d[l_ac].xcbj101,g_xcbj_d[l_ac].xcbj102,g_xcbj_d[l_ac].xcbj103, 
                                g_xcbj_d[l_ac].xcbj104,g_xcbj_d[l_ac].xcbj105,g_xcbj2_d[l_ac].xcbjownid, 
                                g_xcbj2_d[l_ac].xcbjowndp,g_xcbj2_d[l_ac].xcbjcrtid,g_xcbj2_d[l_ac].xcbjcrtdp, 
                                g_xcbj2_d[l_ac].xcbjcrtdt,g_xcbj2_d[l_ac].xcbjmodid,g_xcbj2_d[l_ac].xcbjmoddt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               END IF       #fengmy150120 
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcbj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcbj_t:",SQLERRMESSAGE 
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
               IF axct202_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcbj_m.xcbjld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbj_m.xcbj001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbj_m.xcbj002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbj_m.xcbj003
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbj_d_t.xcbj004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbj_d_t.xcbj005
                  LET gs_keys[gs_keys.getLength()+1] = g_xcbj_d_t.xcbj006
 
 
                  #刪除下層單身
                  IF NOT axct202_key_delete_b(gs_keys,'xcbj_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axct202_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct202_bcl
               LET l_count = g_xcbj_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcbj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj004
            
            #add-point:AFTER FIELD xcbj004 name="input.a.page1.xcbj004"
            CALL s_desc_get_department_desc(g_xcbj_d[l_ac].xcbj004) RETURNING g_xcbj_d[l_ac].xcbj004_desc   #160811-00015#1
            #此段落由子樣板a05產生
            IF  g_xcbj_m.xcbjld IS NOT NULL AND g_xcbj_m.xcbj001 IS NOT NULL AND g_xcbj_m.xcbj002 IS NOT NULL AND g_xcbj_m.xcbj003 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj004 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj005 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbj_m.xcbjld != g_xcbjld_t OR g_xcbj_m.xcbj001 != g_xcbj001_t OR g_xcbj_m.xcbj002 != g_xcbj002_t OR g_xcbj_m.xcbj003 != g_xcbj003_t OR g_xcbj_d[g_detail_idx].xcbj004 != g_xcbj_d_t.xcbj004 OR g_xcbj_d[g_detail_idx].xcbj005 != g_xcbj_d_t.xcbj005 OR g_xcbj_d[g_detail_idx].xcbj006 != g_xcbj_d_t.xcbj006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbj_t WHERE "||"xcbjent = '" ||g_enterprise|| "' AND "||"xcbjld = '"||g_xcbj_m.xcbjld ||"' AND "|| "xcbj001 = '"||g_xcbj_m.xcbj001 ||"' AND "|| "xcbj002 = '"||g_xcbj_m.xcbj002 ||"' AND "|| "xcbj003 = '"||g_xcbj_m.xcbj003 ||"' AND "|| "xcbj004 = '"||g_xcbj_d[g_detail_idx].xcbj004 ||"' AND "|| "xcbj005 = '"||g_xcbj_d[g_detail_idx].xcbj005 ||"' AND "|| "xcbj006 = '"||g_xcbj_d[g_detail_idx].xcbj006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xcbj_d[l_ac].xcbj004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcbj_d[l_ac].xcbj004
               LET g_chkparam.arg2 = g_today
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#11--add--end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_4") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbj_d[l_ac].xcbj004 = g_xcbj_d_t.xcbj004
                  NEXT FIELD CURRENT
               END IF
            

            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj004
            #add-point:BEFORE FIELD xcbj004 name="input.b.page1.xcbj004"
            CALL s_desc_get_department_desc(g_xcbj_d[l_ac].xcbj004) RETURNING g_xcbj_d[l_ac].xcbj004_desc   #160811-00015#1
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj004
            #add-point:ON CHANGE xcbj004 name="input.g.page1.xcbj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj005
            #add-point:BEFORE FIELD xcbj005 name="input.b.page1.xcbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj005
            
            #add-point:AFTER FIELD xcbj005 name="input.a.page1.xcbj005"
            #此段落由子樣板a05產生
            IF  g_xcbj_m.xcbjld IS NOT NULL AND g_xcbj_m.xcbj001 IS NOT NULL AND g_xcbj_m.xcbj002 IS NOT NULL AND g_xcbj_m.xcbj003 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj004 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj005 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbj_m.xcbjld != g_xcbjld_t OR g_xcbj_m.xcbj001 != g_xcbj001_t OR g_xcbj_m.xcbj002 != g_xcbj002_t OR g_xcbj_m.xcbj003 != g_xcbj003_t OR g_xcbj_d[g_detail_idx].xcbj004 != g_xcbj_d_t.xcbj004 OR g_xcbj_d[g_detail_idx].xcbj005 != g_xcbj_d_t.xcbj005 OR g_xcbj_d[g_detail_idx].xcbj006 != g_xcbj_d_t.xcbj006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbj_t WHERE "||"xcbjent = '" ||g_enterprise|| "' AND "||"xcbjld = '"||g_xcbj_m.xcbjld ||"' AND "|| "xcbj001 = '"||g_xcbj_m.xcbj001 ||"' AND "|| "xcbj002 = '"||g_xcbj_m.xcbj002 ||"' AND "|| "xcbj003 = '"||g_xcbj_m.xcbj003 ||"' AND "|| "xcbj004 = '"||g_xcbj_d[g_detail_idx].xcbj004 ||"' AND "|| "xcbj005 = '"||g_xcbj_d[g_detail_idx].xcbj005 ||"' AND "|| "xcbj006 = '"||g_xcbj_d[g_detail_idx].xcbj006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj005
            #add-point:ON CHANGE xcbj005 name="input.g.page1.xcbj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj006
            #add-point:BEFORE FIELD xcbj006 name="input.b.page1.xcbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj006
            
            #add-point:AFTER FIELD xcbj006 name="input.a.page1.xcbj006"
            #此段落由子樣板a05產生
            IF  g_xcbj_m.xcbjld IS NOT NULL AND g_xcbj_m.xcbj001 IS NOT NULL AND g_xcbj_m.xcbj002 IS NOT NULL AND g_xcbj_m.xcbj003 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj004 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj005 IS NOT NULL AND g_xcbj_d[g_detail_idx].xcbj006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcbj_m.xcbjld != g_xcbjld_t OR g_xcbj_m.xcbj001 != g_xcbj001_t OR g_xcbj_m.xcbj002 != g_xcbj002_t OR g_xcbj_m.xcbj003 != g_xcbj003_t OR g_xcbj_d[g_detail_idx].xcbj004 != g_xcbj_d_t.xcbj004 OR g_xcbj_d[g_detail_idx].xcbj005 != g_xcbj_d_t.xcbj005 OR g_xcbj_d[g_detail_idx].xcbj006 != g_xcbj_d_t.xcbj006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbj_t WHERE "||"xcbjent = '" ||g_enterprise|| "' AND "||"xcbjld = '"||g_xcbj_m.xcbjld ||"' AND "|| "xcbj001 = '"||g_xcbj_m.xcbj001 ||"' AND "|| "xcbj002 = '"||g_xcbj_m.xcbj002 ||"' AND "|| "xcbj003 = '"||g_xcbj_m.xcbj003 ||"' AND "|| "xcbj004 = '"||g_xcbj_d[g_detail_idx].xcbj004 ||"' AND "|| "xcbj005 = '"||g_xcbj_d[g_detail_idx].xcbj005 ||"' AND "|| "xcbj006 = '"||g_xcbj_d[g_detail_idx].xcbj006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj006
            #add-point:ON CHANGE xcbj006 name="input.g.page1.xcbj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj010
            #add-point:BEFORE FIELD xcbj010 name="input.b.page1.xcbj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj010
            
            #add-point:AFTER FIELD xcbj010 name="input.a.page1.xcbj010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj010
            #add-point:ON CHANGE xcbj010 name="input.g.page1.xcbj010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj011
            
            #add-point:AFTER FIELD xcbj011 name="input.a.page1.xcbj011"
            CALL s_desc_get_account_desc(g_xcbj_m.xcbjld,g_xcbj_d[l_ac].xcbj011) RETURNING g_xcbj_d[l_ac].xcbj011_desc  #160811-00015#1
            IF NOT cl_null(g_xcbj_d[l_ac].xcbj011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_xcbj_d[l_ac].xcbj011
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
               #160318-00025#11--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #LET  = g_chkparam.return2                  #DISPLAY BY NAME 
            
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcbj_d[l_ac].xcbj011 = g_xcbj_d_t.xcbj011
                  NEXT FIELD CURRENT
               END IF
            
            
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj011
            #add-point:BEFORE FIELD xcbj011 name="input.b.page1.xcbj011"
            CALL s_desc_get_account_desc(g_xcbj_m.xcbjld,g_xcbj_d[l_ac].xcbj011) RETURNING g_xcbj_d[l_ac].xcbj011_desc  #160811-00015#1
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj011
            #add-point:ON CHANGE xcbj011 name="input.g.page1.xcbj011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbj_d[l_ac].xcbj021,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbj021
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbj021 name="input.a.page1.xcbj021"
            #标准产能等于0时,闲置费用=0
            IF g_xcbj_d[l_ac].xcbj021 = 0 THEN 
               LET g_xcbj_d[l_ac].xcbj104 = 0 
            END IF
            #若标准产能>0,“标准产能”>“分摊指标总数”,且固定制费>0,则“闲置费用”＝“固定费用”＊（（标准产能－分摊指标总数）／标准产能）
            IF g_xcbj_d[l_ac].xcbj021 > 0 AND g_xcbj_d[l_ac].xcbj021 > g_xcbj_d[l_ac].xcbj020 AND
               g_xcbj_d[l_ac].xcbj102 > 0  THEN
               LET g_xcbj_d[l_ac].xcbj104 = g_xcbj_d[l_ac].xcbj102 * ((g_xcbj_d[l_ac].xcbj021 - g_xcbj_d[l_ac].xcbj020)/g_xcbj_d[l_ac].xcbj021)
            END IF
            #若“标准产能”<“分摊指标总数”,则闲置费用=0
            IF g_xcbj_d[l_ac].xcbj021 < g_xcbj_d[l_ac].xcbj020 THEN 
               LET g_xcbj_d[l_ac].xcbj104 = 0
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj021
            #add-point:BEFORE FIELD xcbj021 name="input.b.page1.xcbj021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj021
            #add-point:ON CHANGE xcbj021 name="input.g.page1.xcbj021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbj_d[l_ac].xcbj020,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbj020
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbj020 name="input.a.page1.xcbj020"
            #若标准产能>0,“标准产能”>“分摊指标总数”,且固定制费>0,则“闲置费用”＝“固定费用”＊（（标准产能－分摊指标总数）／标准产能）
            IF g_xcbj_d[l_ac].xcbj021 > 0 AND g_xcbj_d[l_ac].xcbj021 > g_xcbj_d[l_ac].xcbj020 AND
               g_xcbj_d[l_ac].xcbj102 > 0  THEN
               LET g_xcbj_d[l_ac].xcbj104 = g_xcbj_d[l_ac].xcbj102 * ((g_xcbj_d[l_ac].xcbj021 - g_xcbj_d[l_ac].xcbj020)/g_xcbj_d[l_ac].xcbj021)
            END IF
            #若“标准产能”<“分摊指标总数”,则闲置费用=0
            IF g_xcbj_d[l_ac].xcbj021 < g_xcbj_d[l_ac].xcbj020 THEN 
               LET g_xcbj_d[l_ac].xcbj104 = 0
            END IF
            LET g_xcbj_d[l_ac].xcbj105 = g_xcbj_d[l_ac].xcbj103 / g_xcbj_d[l_ac].xcbj020
            DISPLAY g_xcbj_d[l_ac].xcbj105 TO s_detail1[l_ac].xcbj105   #20150709 add lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj020
            #add-point:BEFORE FIELD xcbj020 name="input.b.page1.xcbj020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj020
            #add-point:ON CHANGE xcbj020 name="input.g.page1.xcbj020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj101
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbj_d[l_ac].xcbj101,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbj101
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbj101 name="input.a.page1.xcbj101"
            IF NOT cl_null(g_xcbj_d[l_ac].xcbj101) THEN 
               LET g_xcbj_d[l_ac].xcbj103 = g_xcbj_d[l_ac].xcbj101 - g_xcbj_d[l_ac].xcbj104
               IF cl_null(g_xcbj_d[l_ac].xcbj103) THEN 
                  LET g_xcbj_d[l_ac].xcbj103 = 0
               END IF
            END IF
            LET g_xcbj_d[l_ac].xcbj105 = g_xcbj_d[l_ac].xcbj103 / g_xcbj_d[l_ac].xcbj020
            IF cl_null(g_xcbj_d[l_ac].xcbj105) THEN 
               LET g_xcbj_d[l_ac].xcbj105 = 0
            END IF
            DISPLAY g_xcbj_d[l_ac].xcbj105 TO s_detail1[l_ac].xcbj105   #20150709 add lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj101
            #add-point:BEFORE FIELD xcbj101 name="input.b.page1.xcbj101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj101
            #add-point:ON CHANGE xcbj101 name="input.g.page1.xcbj101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj102
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbj_d[l_ac].xcbj102,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbj102
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbj102 name="input.a.page1.xcbj102"
            #若标准产能>0,“标准产能”>“分摊指标总数”,且固定制费>0,则“闲置费用”＝“固定费用”＊（（标准产能－分摊指标总数）／标准产能）
            IF g_xcbj_d[l_ac].xcbj021 > 0 AND g_xcbj_d[l_ac].xcbj021 > g_xcbj_d[l_ac].xcbj020 AND
               g_xcbj_d[l_ac].xcbj102 > 0  THEN
               LET g_xcbj_d[l_ac].xcbj104 = g_xcbj_d[l_ac].xcbj102 * ((g_xcbj_d[l_ac].xcbj021 - g_xcbj_d[l_ac].xcbj020)/g_xcbj_d[l_ac].xcbj021)
               
               IF cl_null(g_xcbj_d[l_ac].xcbj104) THEN 
                  LET g_xcbj_d[l_ac].xcbj104 = 0
               END IF
            END IF
            IF NOT cl_null(g_xcbj_d[l_ac].xcbj101) THEN 
               LET g_xcbj_d[l_ac].xcbj103 = g_xcbj_d[l_ac].xcbj101 - g_xcbj_d[l_ac].xcbj104
               IF cl_null(g_xcbj_d[l_ac].xcbj103) THEN 
                  LET g_xcbj_d[l_ac].xcbj103 = 0
               END IF
            END IF
            LET g_xcbj_d[l_ac].xcbj105 = g_xcbj_d[l_ac].xcbj103 / g_xcbj_d[l_ac].xcbj020
            
            IF cl_null(g_xcbj_d[l_ac].xcbj105) THEN 
               LET g_xcbj_d[l_ac].xcbj105 = 0
            END IF
            DISPLAY g_xcbj_d[l_ac].xcbj105 TO s_detail1[l_ac].xcbj105   #20150709 add lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj102
            #add-point:BEFORE FIELD xcbj102 name="input.b.page1.xcbj102"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj102
            #add-point:ON CHANGE xcbj102 name="input.g.page1.xcbj102"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj103
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbj_d[l_ac].xcbj103,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbj103
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbj103 name="input.a.page1.xcbj103"
            IF NOT cl_null(g_xcbj_d[l_ac].xcbj103) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj103
            #add-point:BEFORE FIELD xcbj103 name="input.b.page1.xcbj103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj103
            #add-point:ON CHANGE xcbj103 name="input.g.page1.xcbj103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj104
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbj_d[l_ac].xcbj104,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbj104
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbj104 name="input.a.page1.xcbj104"
            IF NOT cl_null(g_xcbj_d[l_ac].xcbj104) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj104
            #add-point:BEFORE FIELD xcbj104 name="input.b.page1.xcbj104"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj104
            #add-point:ON CHANGE xcbj104 name="input.g.page1.xcbj104"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj105
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xcbj_d[l_ac].xcbj105,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xcbj105
            END IF 
 
 
 
            #add-point:AFTER FIELD xcbj105 name="input.a.page1.xcbj105"
            IF NOT cl_null(g_xcbj_d[l_ac].xcbj105) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj105
            #add-point:BEFORE FIELD xcbj105 name="input.b.page1.xcbj105"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj105
            #add-point:ON CHANGE xcbj105 name="input.g.page1.xcbj105"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcbj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj004
            #add-point:ON ACTION controlp INFIELD xcbj004 name="input.c.page1.xcbj004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbj_d[l_ac].xcbj004             #給予default值
           #LET g_qryparam.where = " ooeg003 = '3' "   #fengmy 150105 mark
            LET g_qryparam.where = " ooeg003 = '3' AND ooeg009 = '",g_xcbj_m.xcbjcomp,"'"   #fengmy 150105 加法人过滤
            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_xcbj_d[l_ac].xcbj004 = g_qryparam.return1              

            DISPLAY g_xcbj_d[l_ac].xcbj004 TO xcbj004              #

            NEXT FIELD xcbj004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj005
            #add-point:ON ACTION controlp INFIELD xcbj005 name="input.c.page1.xcbj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj006
            #add-point:ON ACTION controlp INFIELD xcbj006 name="input.c.page1.xcbj006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj010
            #add-point:ON ACTION controlp INFIELD xcbj010 name="input.c.page1.xcbj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj011
            #add-point:ON ACTION controlp INFIELD xcbj011 name="input.c.page1.xcbj011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcbj_d[l_ac].xcbj011             #給予default值
            #160419-00035#1---mod---begin
            #LET g_qryparam.where = " glac001 = '",g_glaa004,"' AND glac003 <> '1'"
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_xcbj_m.xcbjld,"'",
                                   "                    AND glad035='N' AND gladstus='Y' )"
            #160419-00035#1---mod---end
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_xcbj_d[l_ac].xcbj011 = g_qryparam.return1              
            DISPLAY g_xcbj_d[l_ac].xcbj011 TO xcbj011              #

            NEXT FIELD xcbj011                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj021
            #add-point:ON ACTION controlp INFIELD xcbj021 name="input.c.page1.xcbj021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj020
            #add-point:ON ACTION controlp INFIELD xcbj020 name="input.c.page1.xcbj020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj101
            #add-point:ON ACTION controlp INFIELD xcbj101 name="input.c.page1.xcbj101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj102
            #add-point:ON ACTION controlp INFIELD xcbj102 name="input.c.page1.xcbj102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj103
            #add-point:ON ACTION controlp INFIELD xcbj103 name="input.c.page1.xcbj103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj104
            #add-point:ON ACTION controlp INFIELD xcbj104 name="input.c.page1.xcbj104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbj105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj105
            #add-point:ON ACTION controlp INFIELD xcbj105 name="input.c.page1.xcbj105"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcbj_d[l_ac].* = g_xcbj_d_t.*
               CLOSE axct202_bcl
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
               LET g_errparam.extend = g_xcbj_d[l_ac].xcbj004 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcbj_d[l_ac].* = g_xcbj_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcbj2_d[l_ac].xcbjmodid = g_user 
LET g_xcbj2_d[l_ac].xcbjmoddt = cl_get_current()
LET g_xcbj2_d[l_ac].xcbjmodid_desc = cl_get_username(g_xcbj2_d[l_ac].xcbjmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               LET g_xcbj_d[l_ac].xcbj101 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj101,2)
               LET g_xcbj_d[l_ac].xcbj102 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj102,2)
               LET g_xcbj_d[l_ac].xcbj103 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj103,2)
               LET g_xcbj_d[l_ac].xcbj104 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj104,2)
               #LET g_xcbj_d[l_ac].xcbj105 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa001,g_xcbj_d[l_ac].xcbj105,2)  #20150709 mark lujh
               #fengmy150120--begin
               IF g_glaa015 = 'Y' OR g_glaa019 = 'Y' THEN
                  IF g_glaa015 = 'Y' THEN
                     CALL s_aooi160_get_exrate('2',g_xcbj_m.xcbjld,g_today,g_glaa001,    #fengmy150120
                                                    #目的幣別;  交易金額;              匯類類型
                                                     g_glaa016,0,g_glaa018)
                              RETURNING l_rate
                     LET g_xcbj3_d[l_ac].xcbj111 = g_xcbj_d[l_ac].xcbj101 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj112 = g_xcbj_d[l_ac].xcbj102 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj113 = g_xcbj_d[l_ac].xcbj103 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj114 = g_xcbj_d[l_ac].xcbj104 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj115 = g_xcbj_d[l_ac].xcbj105 * l_rate
                     LET g_xcbj3_d[l_ac].xcbj111 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj111,2)
                     LET g_xcbj3_d[l_ac].xcbj112 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj112,2)
                     LET g_xcbj3_d[l_ac].xcbj113 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj113,2)
                     LET g_xcbj3_d[l_ac].xcbj114 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj114,2)
                     #LET g_xcbj3_d[l_ac].xcbj115 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa016,g_xcbj3_d[l_ac].xcbj115,2)  #20150709 mark lujh
                  END IF
                  IF g_glaa019 = 'Y' THEN
                     CALL s_aooi160_get_exrate('2',g_xcbj_m.xcbjld,g_today,g_glaa001,    #fengmy150120
                                                    #目的幣別;  交易金額;              匯類類型
                                                     g_glaa020,0,g_glaa022)
                              RETURNING l_rate
                     LET g_xcbj4_d[l_ac].xcbj121 = g_xcbj_d[l_ac].xcbj101 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj122 = g_xcbj_d[l_ac].xcbj102 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj123 = g_xcbj_d[l_ac].xcbj103 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj124 = g_xcbj_d[l_ac].xcbj104 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj125 = g_xcbj_d[l_ac].xcbj105 * l_rate
                     LET g_xcbj4_d[l_ac].xcbj121 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj121,2)
                     LET g_xcbj4_d[l_ac].xcbj122 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj122,2)
                     LET g_xcbj4_d[l_ac].xcbj123 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj123,2)
                     LET g_xcbj4_d[l_ac].xcbj124 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj124,2)
                     #LET g_xcbj4_d[l_ac].xcbj125 = s_curr_round(g_xcbj_m.xcbjcomp,g_glaa020,g_xcbj4_d[l_ac].xcbj125,2)  #20150709 mark lujh
                  END IF
                  UPDATE xcbj_t SET (xcbjld,xcbj001,xcbj002,xcbj003,xcbj004,xcbj005,xcbj006,xcbj010,xcbj011, 
                                     xcbj021,xcbj020,xcbj101,xcbj102,xcbj103,xcbj104,xcbj105,
                                                     xcbj111,xcbj112,xcbj113,xcbj114,xcbj115,
                                                     xcbj121,xcbj122,xcbj123,xcbj124,xcbj125,
                                     xcbjownid,xcbjowndp,xcbjcrtid,xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt) 
                   = (g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002, 
                   g_xcbj_m.xcbj003,g_xcbj_d[l_ac].xcbj004,g_xcbj_d[l_ac].xcbj005,g_xcbj_d[l_ac].xcbj006, 
                   g_xcbj_d[l_ac].xcbj010,g_xcbj_d[l_ac].xcbj011,g_xcbj_d[l_ac].xcbj021,g_xcbj_d[l_ac].xcbj020, 
                   g_xcbj_d[l_ac].xcbj101,g_xcbj_d[l_ac].xcbj102,g_xcbj_d[l_ac].xcbj103,g_xcbj_d[l_ac].xcbj104,g_xcbj_d[l_ac].xcbj105, 
                   g_xcbj3_d[l_ac].xcbj111,g_xcbj3_d[l_ac].xcbj112,g_xcbj3_d[l_ac].xcbj113,g_xcbj3_d[l_ac].xcbj114,g_xcbj3_d[l_ac].xcbj115, 
                   g_xcbj4_d[l_ac].xcbj121,g_xcbj4_d[l_ac].xcbj122,g_xcbj4_d[l_ac].xcbj123,g_xcbj4_d[l_ac].xcbj124,g_xcbj4_d[l_ac].xcbj125, 
                   g_xcbj2_d[l_ac].xcbjownid,g_xcbj2_d[l_ac].xcbjowndp,g_xcbj2_d[l_ac].xcbjcrtid, 
                   g_xcbj2_d[l_ac].xcbjcrtdp,g_xcbj2_d[l_ac].xcbjcrtdt,g_xcbj2_d[l_ac].xcbjmodid,g_xcbj2_d[l_ac].xcbjmoddt) 

                WHERE xcbjent = g_enterprise AND xcbjld = g_xcbj_m.xcbjld 
                 AND xcbj001 = g_xcbj_m.xcbj001 
                 AND xcbj002 = g_xcbj_m.xcbj002 
                 AND xcbj003 = g_xcbj_m.xcbj003 
 
                 AND xcbj004 = g_xcbj_d_t.xcbj004 #項次   
                 AND xcbj005 = g_xcbj_d_t.xcbj005  
                 AND xcbj006 = g_xcbj_d_t.xcbj006
               ELSE 
               #fengmy150120---end               
               #end add-point
         
               #將遮罩欄位還原
               CALL axct202_xcbj_t_mask_restore('restore_mask_o')
         
               UPDATE xcbj_t SET (xcbjld,xcbj001,xcbj002,xcbj003,xcbj004,xcbj005,xcbj006,xcbj010,xcbj011, 
                   xcbj021,xcbj020,xcbj101,xcbj102,xcbj103,xcbj104,xcbj105,xcbjownid,xcbjowndp,xcbjcrtid, 
                   xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt) = (g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002, 
                   g_xcbj_m.xcbj003,g_xcbj_d[l_ac].xcbj004,g_xcbj_d[l_ac].xcbj005,g_xcbj_d[l_ac].xcbj006, 
                   g_xcbj_d[l_ac].xcbj010,g_xcbj_d[l_ac].xcbj011,g_xcbj_d[l_ac].xcbj021,g_xcbj_d[l_ac].xcbj020, 
                   g_xcbj_d[l_ac].xcbj101,g_xcbj_d[l_ac].xcbj102,g_xcbj_d[l_ac].xcbj103,g_xcbj_d[l_ac].xcbj104, 
                   g_xcbj_d[l_ac].xcbj105,g_xcbj2_d[l_ac].xcbjownid,g_xcbj2_d[l_ac].xcbjowndp,g_xcbj2_d[l_ac].xcbjcrtid, 
                   g_xcbj2_d[l_ac].xcbjcrtdp,g_xcbj2_d[l_ac].xcbjcrtdt,g_xcbj2_d[l_ac].xcbjmodid,g_xcbj2_d[l_ac].xcbjmoddt) 
 
                WHERE xcbjent = g_enterprise AND xcbjld = g_xcbj_m.xcbjld 
                 AND xcbj001 = g_xcbj_m.xcbj001 
                 AND xcbj002 = g_xcbj_m.xcbj002 
                 AND xcbj003 = g_xcbj_m.xcbj003 
 
                 AND xcbj004 = g_xcbj_d_t.xcbj004 #項次   
                 AND xcbj005 = g_xcbj_d_t.xcbj005  
                 AND xcbj006 = g_xcbj_d_t.xcbj006  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               END IF      #fengmy150120 
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcbj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcbj_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbj_m.xcbjld
               LET gs_keys_bak[1] = g_xcbjld_t
               LET gs_keys[2] = g_xcbj_m.xcbj001
               LET gs_keys_bak[2] = g_xcbj001_t
               LET gs_keys[3] = g_xcbj_m.xcbj002
               LET gs_keys_bak[3] = g_xcbj002_t
               LET gs_keys[4] = g_xcbj_m.xcbj003
               LET gs_keys_bak[4] = g_xcbj003_t
               LET gs_keys[5] = g_xcbj_d[g_detail_idx].xcbj004
               LET gs_keys_bak[5] = g_xcbj_d_t.xcbj004
               LET gs_keys[6] = g_xcbj_d[g_detail_idx].xcbj005
               LET gs_keys_bak[6] = g_xcbj_d_t.xcbj005
               LET gs_keys[7] = g_xcbj_d[g_detail_idx].xcbj006
               LET gs_keys_bak[7] = g_xcbj_d_t.xcbj006
               CALL axct202_update_b('xcbj_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcbj_m),util.JSON.stringify(g_xcbj_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcbj_m),util.JSON.stringify(g_xcbj_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct202_xcbj_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcbj_m.xcbjld
               LET ls_keys[ls_keys.getLength()+1] = g_xcbj_m.xcbj001
               LET ls_keys[ls_keys.getLength()+1] = g_xcbj_m.xcbj002
               LET ls_keys[ls_keys.getLength()+1] = g_xcbj_m.xcbj003
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcbj_d_t.xcbj004
               LET ls_keys[ls_keys.getLength()+1] = g_xcbj_d_t.xcbj005
               LET ls_keys[ls_keys.getLength()+1] = g_xcbj_d_t.xcbj006
 
               CALL axct202_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axct202_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcbj_d[l_ac].* = g_xcbj_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axct202_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcbj_d.getLength() = 0 THEN
               NEXT FIELD xcbj004
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcbj_d[li_reproduce_target].* = g_xcbj_d[li_reproduce].*
               LET g_xcbj2_d[li_reproduce_target].* = g_xcbj2_d[li_reproduce].*
 
               LET g_xcbj_d[li_reproduce_target].xcbj004 = NULL
               LET g_xcbj_d[li_reproduce_target].xcbj005 = NULL
               LET g_xcbj_d[li_reproduce_target].xcbj006 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcbj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcbj_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xcbj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axct202_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axct202_idx_chk()
            CALL axct202_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      INPUT ARRAY g_xcbj3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, MAXCOUNT = g_max_rec, WITHOUT DEFAULTS, 
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL axct202_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN             
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前
            #fengmy150120---begin
            SELECT glaa001,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022 
              INTO g_glaa001,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022 
              FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_xcbj_m.xcbjld
            #fengmy150120---end
            #end add-point
 
         BEFORE ROW 
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()                #returns the current row
            IF l_ac > g_rec_b THEN               #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL axct202_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct202_set_no_entry_b(l_cmd)
               LET g_xcbj3_d_t.* = g_xcbj3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
             
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xcbj004
 
            INITIALIZE g_xcbj3_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcbj3_d[l_ac].* TO NULL
            
            #公用欄位預設值
            #此段落由子樣板a14產生    
      LET g_xcbj2_d[l_ac].xcbjownid = g_user
      LET g_xcbj2_d[l_ac].xcbjowndp = g_dept
      LET g_xcbj2_d[l_ac].xcbjcrtid = g_user
      LET g_xcbj2_d[l_ac].xcbjcrtdp = g_dept 
      LET g_xcbj2_d[l_ac].xcbjcrtdt = cl_get_current()
      LET g_xcbj2_d[l_ac].xcbjmodid = ""
      LET g_xcbj2_d[l_ac].xcbjmoddt = ""
      #LET .xcbjstus = ""
 
  
            
            #一般欄位預設值
            
            
            
            LET g_xcbj3_d_t.* = g_xcbj3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct202_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axct202_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcbj_d[li_reproduce_target].* = g_xcbj_d[li_reproduce].*
               LET g_xcbj2_d[li_reproduce_target].* = g_xcbj2_d[li_reproduce].*
               LET g_xcbj3_d[li_reproduce_target].* = g_xcbj3_d[li_reproduce].*
               LET g_xcbj4_d[li_reproduce_target].* = g_xcbj4_d[li_reproduce].*
 
               LET g_xcbj3_d[li_reproduce_target].xcbj004 = NULL
               LET g_xcbj3_d[li_reproduce_target].xcbj005 = NULL
               LET g_xcbj3_d[li_reproduce_target].xcbj006 = NULL
            END IF
            
            #add-point:modify段before insert

            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_xcbj3_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_xcbj_d.deleteElement(l_ac)
               NEXT FIELD xcbj004
            END IF
            IF g_xcbj_d_t.xcbj004 IS NOT NULL
               AND g_xcbj_d_t.xcbj005 IS NOT NULL
               AND g_xcbj_d_t.xcbj006 IS NOT NULL
            THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               IF axct202_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct202_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_xcbj3_d.getLength()
            END IF
            
         AFTER DELETE 
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xcbj3_d[l_ac].* = g_xcbj3_d_t.*
               CLOSE axct202_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xcbj_d[l_ac].xcbj004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xcbj3_d[l_ac].* = g_xcbj3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcbj2_d[l_ac].xcbjmodid = g_user 
LET g_xcbj2_d[l_ac].xcbjmoddt = cl_get_current()
 
                
               #add-point:單身修改前

               #end add-point
      
               UPDATE xcbj_t SET (xcbjld,xcbj001,xcbj002,xcbj003,xcbj004,xcbj005,xcbj006,xcbj010,xcbj011, 
                   xcbj021,xcbj020,xcbj101,xcbj102,xcbj103,xcbj104,xcbj105,xcbjownid,xcbjowndp,xcbjcrtid, 
                   xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt,xcbj111,xcbj112,xcbj113,xcbj114,xcbj115,xcbj121, 
                   xcbj122,xcbj123,xcbj124,xcbj125) = (g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002, 
                   g_xcbj_m.xcbj003,g_xcbj_d[l_ac].xcbj004,g_xcbj_d[l_ac].xcbj005,g_xcbj_d[l_ac].xcbj006, 
                   g_xcbj_d[l_ac].xcbj010,g_xcbj_d[l_ac].xcbj011,g_xcbj_d[l_ac].xcbj021,g_xcbj_d[l_ac].xcbj020, 
                   g_xcbj_d[l_ac].xcbj101,g_xcbj_d[l_ac].xcbj102,g_xcbj_d[l_ac].xcbj103,g_xcbj_d[l_ac].xcbj104, 
                   g_xcbj_d[l_ac].xcbj105,g_xcbj2_d[l_ac].xcbjownid,g_xcbj2_d[l_ac].xcbjowndp,g_xcbj2_d[l_ac].xcbjcrtid, 
                   g_xcbj2_d[l_ac].xcbjcrtdp,g_xcbj2_d[l_ac].xcbjcrtdt,g_xcbj2_d[l_ac].xcbjmodid,g_xcbj2_d[l_ac].xcbjmoddt, 
                   g_xcbj3_d[l_ac].xcbj111,g_xcbj3_d[l_ac].xcbj112,g_xcbj3_d[l_ac].xcbj113,g_xcbj3_d[l_ac].xcbj114, 
                   g_xcbj3_d[l_ac].xcbj115,g_xcbj4_d[l_ac].xcbj121,g_xcbj4_d[l_ac].xcbj122,g_xcbj4_d[l_ac].xcbj123, 
                   g_xcbj4_d[l_ac].xcbj124,g_xcbj4_d[l_ac].xcbj125) #自訂欄位頁簽
                WHERE xcbjent = g_enterprise AND xcbjld = g_xcbj_m.xcbjld
                 AND xcbj001 = g_xcbj_m.xcbj001
                 AND xcbj002 = g_xcbj_m.xcbj002
                 AND xcbj003 = g_xcbj_m.xcbj003
                 AND xcbj004 = g_xcbj3_d_t.xcbj004 #項次 
                 AND xcbj005 = g_xcbj3_d_t.xcbj005
                 AND xcbj006 = g_xcbj3_d_t.xcbj006
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xcbj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xcbj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbj_m.xcbjld
               LET gs_keys_bak[1] = g_xcbjld_t
               LET gs_keys[2] = g_xcbj_m.xcbj001
               LET gs_keys_bak[2] = g_xcbj001_t
               LET gs_keys[3] = g_xcbj_m.xcbj002
               LET gs_keys_bak[3] = g_xcbj002_t
               LET gs_keys[4] = g_xcbj_m.xcbj003
               LET gs_keys_bak[4] = g_xcbj003_t
               LET gs_keys[5] = g_xcbj3_d[g_detail_idx].xcbj004
               LET gs_keys_bak[5] = g_xcbj3_d_t.xcbj004
               LET gs_keys[6] = g_xcbj3_d[g_detail_idx].xcbj005
               LET gs_keys_bak[6] = g_xcbj3_d_t.xcbj005
               LET gs_keys[7] = g_xcbj3_d[g_detail_idx].xcbj006
               LET gs_keys_bak[7] = g_xcbj3_d_t.xcbj006
               CALL axct202_update_b('xcbj_t',gs_keys,gs_keys_bak,"'3'")
                     #多語言處理
                     
               END CASE
               
               #add-point:單身修改後

               #end add-point
            END IF
         
         #---------------------<  Detail: page3  >---------------------
         #----<<xcbj111>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj111
            #add-point:BEFORE FIELD xcbj111

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj111
            
            #add-point:AFTER FIELD xcbj111
            IF NOT cl_null(g_xcbj3_d[l_ac].xcbj111) THEN 
               LET g_xcbj3_d[l_ac].xcbj113 = g_xcbj3_d[l_ac].xcbj111 - g_xcbj3_d[l_ac].xcbj114
               IF cl_null(g_xcbj3_d[l_ac].xcbj113) THEN 
                  LET g_xcbj3_d[l_ac].xcbj113 = 0
               END IF
            END IF
            LET g_xcbj3_d[l_ac].xcbj115 = g_xcbj3_d[l_ac].xcbj113 / g_xcbj3_d[l_ac].xcbj020
            IF cl_null(g_xcbj3_d[l_ac].xcbj115) THEN 
               LET g_xcbj3_d[l_ac].xcbj115 = 0
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj111
            #add-point:ON CHANGE xcbj111

            #END add-point
 
         #----<<xcbj112>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj112
            #add-point:BEFORE FIELD xcbj112

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj112
            
            #add-point:AFTER FIELD xcbj112
            #若标准产能>0,“标准产能”<“分摊指标总数”,且固定制费>0,则“闲置费用”＝“固定费用”＊（（分摊指标总数－标准产能）／分摊指标总数）
            IF g_xcbj3_d[l_ac].xcbj021 > 0 AND g_xcbj3_d[l_ac].xcbj021 < g_xcbj3_d[l_ac].xcbj020 AND
               g_xcbj3_d[l_ac].xcbj112 > 0  THEN
               LET g_xcbj3_d[l_ac].xcbj114 = g_xcbj3_d[l_ac].xcbj112 * ((g_xcbj3_d[l_ac].xcbj020 - g_xcbj3_d[l_ac].xcbj021)/g_xcbj3_d[l_ac].xcbj020)
               
               IF cl_null(g_xcbj3_d[l_ac].xcbj114) THEN 
                  LET g_xcbj3_d[l_ac].xcbj114 = 0
               END IF
            END IF
            IF NOT cl_null(g_xcbj3_d[l_ac].xcbj111) THEN 
               LET g_xcbj3_d[l_ac].xcbj113 = g_xcbj3_d[l_ac].xcbj111 - g_xcbj3_d[l_ac].xcbj114
               IF cl_null(g_xcbj3_d[l_ac].xcbj113) THEN 
                  LET g_xcbj3_d[l_ac].xcbj113 = 0
               END IF
            END IF
            LET g_xcbj3_d[l_ac].xcbj115 = g_xcbj3_d[l_ac].xcbj113 / g_xcbj3_d[l_ac].xcbj020
            
            IF cl_null(g_xcbj3_d[l_ac].xcbj115) THEN 
               LET g_xcbj3_d[l_ac].xcbj115 = 0
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj112
            #add-point:ON CHANGE xcbj112

            #END add-point
 
         #----<<xcbj113>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj113
            #add-point:BEFORE FIELD xcbj113

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj113
            
            #add-point:AFTER FIELD xcbj113

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj113
            #add-point:ON CHANGE xcbj113

            #END add-point
 
         #----<<xcbj114>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj114
            #add-point:BEFORE FIELD xcbj114

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj114
            
            #add-point:AFTER FIELD xcbj114

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj114
            #add-point:ON CHANGE xcbj114

            #END add-point
 
         #----<<xcbj115>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj115
            #add-point:BEFORE FIELD xcbj115

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj115
            
            #add-point:AFTER FIELD xcbj115

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj115
            #add-point:ON CHANGE xcbj115

            #END add-point
 
 
         #---------------------<  Detail: page3  >---------------------
         #----<<xcbj111>>----
         #Ctrlp:input.c.page3.xcbj111
         ON ACTION controlp INFIELD xcbj111
            #add-point:ON ACTION controlp INFIELD xcbj111

            #END add-point
 
         #----<<xcbj112>>----
         #Ctrlp:input.c.page3.xcbj112
         ON ACTION controlp INFIELD xcbj112
            #add-point:ON ACTION controlp INFIELD xcbj112

            #END add-point
 
         #----<<xcbj113>>----
         #Ctrlp:input.c.page3.xcbj113
         ON ACTION controlp INFIELD xcbj113
            #add-point:ON ACTION controlp INFIELD xcbj113

            #END add-point
 
         #----<<xcbj114>>----
         #Ctrlp:input.c.page3.xcbj114
         ON ACTION controlp INFIELD xcbj114
            #add-point:ON ACTION controlp INFIELD xcbj114

            #END add-point
 
         #----<<xcbj115>>----
         #Ctrlp:input.c.page3.xcbj115
         ON ACTION controlp INFIELD xcbj115
            #add-point:ON ACTION controlp INFIELD xcbj115

            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcbj3_d[l_ac].* = g_xcbj3_d_t.*
               END IF
               CLOSE axct202_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE axct202_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point    
 
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_xcbj3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcbj3_d.getLength()+1
 
      END INPUT
      INPUT ARRAY g_xcbj4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b, MAXCOUNT = g_max_rec, WITHOUT DEFAULTS, 
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                   DELETE ROW = l_allow_delete,
                   APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL axct202_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN             
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前
            #fengmy150120---begin
            SELECT glaa001,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022 
              INTO g_glaa001,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022 
              FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_xcbj_m.xcbjld
            #fengmy150120---end
            #end add-point
 
         BEFORE ROW 
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()                #returns the current row
            IF l_ac > g_rec_b THEN               #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL axct202_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct202_set_no_entry_b(l_cmd)
               LET g_xcbj4_d_t.* = g_xcbj4_d[l_ac].*   #BACKUP  #page1
            END IF 
            
             
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xcbj004
 
            INITIALIZE g_xcbj4_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcbj4_d[l_ac].* TO NULL
            
            #公用欄位預設值
            #此段落由子樣板a14產生    
      LET g_xcbj2_d[l_ac].xcbjownid = g_user
      LET g_xcbj2_d[l_ac].xcbjowndp = g_dept
      LET g_xcbj2_d[l_ac].xcbjcrtid = g_user
      LET g_xcbj2_d[l_ac].xcbjcrtdp = g_dept 
      LET g_xcbj2_d[l_ac].xcbjcrtdt = cl_get_current()
      LET g_xcbj2_d[l_ac].xcbjmodid = ""
      LET g_xcbj2_d[l_ac].xcbjmoddt = ""
      #LET .xcbjstus = ""
 
  
            
            #一般欄位預設值
            
            
            
            LET g_xcbj4_d_t.* = g_xcbj4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct202_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axct202_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcbj_d[li_reproduce_target].* = g_xcbj_d[li_reproduce].*
               LET g_xcbj2_d[li_reproduce_target].* = g_xcbj2_d[li_reproduce].*
               LET g_xcbj3_d[li_reproduce_target].* = g_xcbj3_d[li_reproduce].*
               LET g_xcbj4_d[li_reproduce_target].* = g_xcbj4_d[li_reproduce].*
 
               LET g_xcbj4_d[li_reproduce_target].xcbj004 = NULL
               LET g_xcbj4_d[li_reproduce_target].xcbj005 = NULL
               LET g_xcbj4_d[li_reproduce_target].xcbj006 = NULL
            END IF
            
            #add-point:modify段before insert

            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_xcbj4_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_xcbj_d.deleteElement(l_ac)
               NEXT FIELD xcbj004
            END IF
            IF g_xcbj_d_t.xcbj004 IS NOT NULL
               AND g_xcbj_d_t.xcbj005 IS NOT NULL
               AND g_xcbj_d_t.xcbj006 IS NOT NULL
            THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               IF axct202_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct202_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_xcbj4_d.getLength()
            END IF
            
         AFTER DELETE 
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xcbj4_d[l_ac].* = g_xcbj4_d_t.*
               CLOSE axct202_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xcbj_d[l_ac].xcbj004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xcbj4_d[l_ac].* = g_xcbj4_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xcbj2_d[l_ac].xcbjmodid = g_user 
LET g_xcbj2_d[l_ac].xcbjmoddt = cl_get_current()
 
                
               #add-point:單身修改前

               #end add-point
      
               UPDATE xcbj_t SET (xcbjld,xcbj001,xcbj002,xcbj003,xcbj004,xcbj005,xcbj006,xcbj010,xcbj011, 
                   xcbj021,xcbj020,xcbj101,xcbj102,xcbj103,xcbj104,xcbj105,xcbjownid,xcbjowndp,xcbjcrtid, 
                   xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt,xcbj111,xcbj112,xcbj113,xcbj114,xcbj115,xcbj121, 
                   xcbj122,xcbj123,xcbj124,xcbj125) = (g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002, 
                   g_xcbj_m.xcbj003,g_xcbj_d[l_ac].xcbj004,g_xcbj_d[l_ac].xcbj005,g_xcbj_d[l_ac].xcbj006, 
                   g_xcbj_d[l_ac].xcbj010,g_xcbj_d[l_ac].xcbj011,g_xcbj_d[l_ac].xcbj021,g_xcbj_d[l_ac].xcbj020, 
                   g_xcbj_d[l_ac].xcbj101,g_xcbj_d[l_ac].xcbj102,g_xcbj_d[l_ac].xcbj103,g_xcbj_d[l_ac].xcbj104, 
                   g_xcbj_d[l_ac].xcbj105,g_xcbj2_d[l_ac].xcbjownid,g_xcbj2_d[l_ac].xcbjowndp,g_xcbj2_d[l_ac].xcbjcrtid, 
                   g_xcbj2_d[l_ac].xcbjcrtdp,g_xcbj2_d[l_ac].xcbjcrtdt,g_xcbj2_d[l_ac].xcbjmodid,g_xcbj2_d[l_ac].xcbjmoddt, 
                   g_xcbj3_d[l_ac].xcbj111,g_xcbj3_d[l_ac].xcbj112,g_xcbj3_d[l_ac].xcbj113,g_xcbj3_d[l_ac].xcbj114, 
                   g_xcbj3_d[l_ac].xcbj115,g_xcbj4_d[l_ac].xcbj121,g_xcbj4_d[l_ac].xcbj122,g_xcbj4_d[l_ac].xcbj123, 
                   g_xcbj4_d[l_ac].xcbj124,g_xcbj4_d[l_ac].xcbj125) #自訂欄位頁簽
                WHERE xcbjent = g_enterprise AND xcbjld = g_xcbj_m.xcbjld
                 AND xcbj001 = g_xcbj_m.xcbj001
                 AND xcbj002 = g_xcbj_m.xcbj002
                 AND xcbj003 = g_xcbj_m.xcbj003
                 AND xcbj004 = g_xcbj4_d_t.xcbj004 #項次 
                 AND xcbj005 = g_xcbj4_d_t.xcbj005
                 AND xcbj006 = g_xcbj4_d_t.xcbj006
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xcbj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xcbj_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcbj_m.xcbjld
               LET gs_keys_bak[1] = g_xcbjld_t
               LET gs_keys[2] = g_xcbj_m.xcbj001
               LET gs_keys_bak[2] = g_xcbj001_t
               LET gs_keys[3] = g_xcbj_m.xcbj002
               LET gs_keys_bak[3] = g_xcbj002_t
               LET gs_keys[4] = g_xcbj_m.xcbj003
               LET gs_keys_bak[4] = g_xcbj003_t
               LET gs_keys[5] = g_xcbj4_d[g_detail_idx].xcbj004
               LET gs_keys_bak[5] = g_xcbj4_d_t.xcbj004
               LET gs_keys[6] = g_xcbj4_d[g_detail_idx].xcbj005
               LET gs_keys_bak[6] = g_xcbj4_d_t.xcbj005
               LET gs_keys[7] = g_xcbj4_d[g_detail_idx].xcbj006
               LET gs_keys_bak[7] = g_xcbj4_d_t.xcbj006
               CALL axct202_update_b('xcbj_t',gs_keys,gs_keys_bak,"'4'")
                     #多語言處理
                     
               END CASE
               
               #add-point:單身修改後

               #end add-point
            END IF
         
         #---------------------<  Detail: page4  >---------------------
         #----<<xcbj121>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj121
            #add-point:BEFORE FIELD xcbj121

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj121
            
            #add-point:AFTER FIELD xcbj121
            IF NOT cl_null(g_xcbj4_d[l_ac].xcbj121) THEN 
               LET g_xcbj4_d[l_ac].xcbj123 = g_xcbj4_d[l_ac].xcbj121 - g_xcbj4_d[l_ac].xcbj124
               IF cl_null(g_xcbj4_d[l_ac].xcbj123) THEN 
                  LET g_xcbj4_d[l_ac].xcbj123 = 0
               END IF
            END IF
            LET g_xcbj4_d[l_ac].xcbj125 = g_xcbj4_d[l_ac].xcbj123 / g_xcbj4_d[l_ac].xcbj020
            IF cl_null(g_xcbj4_d[l_ac].xcbj125) THEN 
               LET g_xcbj4_d[l_ac].xcbj125 = 0
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj121
            #add-point:ON CHANGE xcbj121

            #END add-point
 
         #----<<xcbj122>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj122
            #add-point:BEFORE FIELD xcbj122

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj122
            
            #add-point:AFTER FIELD xcbj122
            #若标准产能>0,“标准产能”<“分摊指标总数”,且固定制费>0,则“闲置费用”＝“固定费用”＊（（分摊指标总数－标准产能）／分摊指标总数）
            IF g_xcbj4_d[l_ac].xcbj021 > 0 AND g_xcbj4_d[l_ac].xcbj021 < g_xcbj4_d[l_ac].xcbj020 AND
               g_xcbj4_d[l_ac].xcbj122 > 0  THEN
               LET g_xcbj4_d[l_ac].xcbj124 = g_xcbj4_d[l_ac].xcbj122 * ((g_xcbj4_d[l_ac].xcbj020 - g_xcbj4_d[l_ac].xcbj021)/g_xcbj4_d[l_ac].xcbj020)
               
               IF cl_null(g_xcbj4_d[l_ac].xcbj124) THEN 
                  LET g_xcbj4_d[l_ac].xcbj124 = 0
               END IF
            END IF
            IF NOT cl_null(g_xcbj4_d[l_ac].xcbj121) THEN 
               LET g_xcbj4_d[l_ac].xcbj123 = g_xcbj4_d[l_ac].xcbj121 - g_xcbj4_d[l_ac].xcbj124
               IF cl_null(g_xcbj4_d[l_ac].xcbj123) THEN 
                  LET g_xcbj4_d[l_ac].xcbj123 = 0
               END IF
            END IF
            LET g_xcbj4_d[l_ac].xcbj125 = g_xcbj4_d[l_ac].xcbj123 / g_xcbj4_d[l_ac].xcbj020
            
            IF cl_null(g_xcbj4_d[l_ac].xcbj125) THEN 
               LET g_xcbj4_d[l_ac].xcbj125 = 0
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj122
            #add-point:ON CHANGE xcbj122

            #END add-point
 
         #----<<xcbj123>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj123
            #add-point:BEFORE FIELD xcbj123

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj123
            
            #add-point:AFTER FIELD xcbj123

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj123
            #add-point:ON CHANGE xcbj123

            #END add-point
 
         #----<<xcbj124>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj124
            #add-point:BEFORE FIELD xcbj124

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj124
            
            #add-point:AFTER FIELD xcbj124

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj124
            #add-point:ON CHANGE xcbj124

            #END add-point
 
         #----<<xcbj125>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xcbj125
            #add-point:BEFORE FIELD xcbj125

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbj125
            
            #add-point:AFTER FIELD xcbj125

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbj125
            #add-point:ON CHANGE xcbj125

            #END add-point
 
 
         #---------------------<  Detail: page4  >---------------------
         #----<<xcbj121>>----
         #Ctrlp:input.c.page4.xcbj121
         ON ACTION controlp INFIELD xcbj121
            #add-point:ON ACTION controlp INFIELD xcbj121

            #END add-point
 
         #----<<xcbj122>>----
         #Ctrlp:input.c.page4.xcbj122
         ON ACTION controlp INFIELD xcbj122
            #add-point:ON ACTION controlp INFIELD xcbj122

            #END add-point
 
         #----<<xcbj123>>----
         #Ctrlp:input.c.page4.xcbj123
         ON ACTION controlp INFIELD xcbj123
            #add-point:ON ACTION controlp INFIELD xcbj123

            #END add-point
 
         #----<<xcbj124>>----
         #Ctrlp:input.c.page4.xcbj124
         ON ACTION controlp INFIELD xcbj124
            #add-point:ON ACTION controlp INFIELD xcbj124

            #END add-point
 
         #----<<xcbj125>>----
         #Ctrlp:input.c.page4.xcbj125
         ON ACTION controlp INFIELD xcbj125
            #add-point:ON ACTION controlp INFIELD xcbj125

            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcbj4_d[l_ac].* = g_xcbj4_d_t.*
               END IF
               CLOSE axct202_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE axct202_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point    
 
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_xcbj4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcbj4_d.getLength()+1
 
      END INPUT
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD xcbjcomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcbj004
               WHEN "s_detail2"
                  NEXT FIELD xcbj004_2
               WHEN "s_detail3"
                  NEXT FIELD xcbj004_3
               WHEN "s_detail4"
                  NEXT FIELD xcbj004_4
 
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcbjld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcbj004
               WHEN "s_detail2"
                  NEXT FIELD xcbj004_2
 
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
 
{<section id="axct202.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct202_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL axct202_show_ref()   #160811-00015#1
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axct202_b_fill(g_wc2) #第一階單身填充
      CALL axct202_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axct202_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcbj_m.xcbjcomp,g_xcbj_m.xcbjcomp_desc,g_xcbj_m.xcbjld,g_xcbj_m.xcbjld_desc,g_xcbj_m.xcbj002, 
       g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,g_xcbj_m.xcbj001_desc
 
   CALL axct202_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CALL axct202_visible()
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axct202_ref_show()
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcbj_m.xcbjld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaa004,glaa015,glaa019 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields 
            LET g_glaa004 = '', g_rtn_fields[1] , ''
            LET g_glaa015 = '', g_rtn_fields[2] , ''
            LET g_glaa019 = '', g_rtn_fields[3] , ''
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcbj_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcbj2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axct202.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct202_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcbj_t.xcbjld 
   DEFINE l_oldno     LIKE xcbj_t.xcbjld 
   DEFINE l_newno02     LIKE xcbj_t.xcbj001 
   DEFINE l_oldno02     LIKE xcbj_t.xcbj001 
   DEFINE l_newno03     LIKE xcbj_t.xcbj002 
   DEFINE l_oldno03     LIKE xcbj_t.xcbj002 
   DEFINE l_newno04     LIKE xcbj_t.xcbj003 
   DEFINE l_oldno04     LIKE xcbj_t.xcbj003 
 
   DEFINE l_master    RECORD LIKE xcbj_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcbj_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcbj_m.xcbjld IS NULL
      OR g_xcbj_m.xcbj001 IS NULL
      OR g_xcbj_m.xcbj002 IS NULL
      OR g_xcbj_m.xcbj003 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcbjld_t = g_xcbj_m.xcbjld
   LET g_xcbj001_t = g_xcbj_m.xcbj001
   LET g_xcbj002_t = g_xcbj_m.xcbj002
   LET g_xcbj003_t = g_xcbj_m.xcbj003
 
   
   LET g_xcbj_m.xcbjld = ""
   LET g_xcbj_m.xcbj001 = ""
   LET g_xcbj_m.xcbj002 = ""
   LET g_xcbj_m.xcbj003 = ""
 
   LET g_master_insert = FALSE
   CALL axct202_set_entry('a')
   CALL axct202_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcbj_m.xcbjld_desc = ''
   DISPLAY BY NAME g_xcbj_m.xcbjld_desc
   LET g_xcbj_m.xcbj001_desc = ''
   DISPLAY BY NAME g_xcbj_m.xcbj001_desc
 
   
   CALL axct202_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcbj_m.* TO NULL
      INITIALIZE g_xcbj_d TO NULL
      INITIALIZE g_xcbj2_d TO NULL
 
      CALL axct202_show()
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
   CALL axct202_set_act_visible()
   CALL axct202_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcbjld_t = g_xcbj_m.xcbjld
   LET g_xcbj001_t = g_xcbj_m.xcbj001
   LET g_xcbj002_t = g_xcbj_m.xcbj002
   LET g_xcbj003_t = g_xcbj_m.xcbj003
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcbjent = " ||g_enterprise|| " AND",
                      " xcbjld = '", g_xcbj_m.xcbjld, "' "
                      ," AND xcbj001 = '", g_xcbj_m.xcbj001, "' "
                      ," AND xcbj002 = '", g_xcbj_m.xcbj002, "' "
                      ," AND xcbj003 = '", g_xcbj_m.xcbj003, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct202_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axct202_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axct202_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct202_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcbj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct202_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcbj_t
    WHERE xcbjent = g_enterprise AND xcbjld = g_xcbjld_t
    AND xcbj001 = g_xcbj001_t
    AND xcbj002 = g_xcbj002_t
    AND xcbj003 = g_xcbj003_t
 
       INTO TEMP axct202_detail
   
   #將key修正為調整後   
   UPDATE axct202_detail 
      #更新key欄位
      SET xcbjld = g_xcbj_m.xcbjld
          , xcbj001 = g_xcbj_m.xcbj001
          , xcbj002 = g_xcbj_m.xcbj002
          , xcbj003 = g_xcbj_m.xcbj003
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xcbjownid = g_user 
       , xcbjowndp = g_dept
       , xcbjcrtid = g_user
       , xcbjcrtdp = g_dept 
       , xcbjcrtdt = ld_date
       , xcbjmodid = g_user
       , xcbjmoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xcbj_t SELECT * FROM axct202_detail
   
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
   DROP TABLE axct202_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcbjld_t = g_xcbj_m.xcbjld
   LET g_xcbj001_t = g_xcbj_m.xcbj001
   LET g_xcbj002_t = g_xcbj_m.xcbj002
   LET g_xcbj003_t = g_xcbj_m.xcbj003
 
   
   DROP TABLE axct202_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct202_delete()
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
   
   IF g_xcbj_m.xcbjld IS NULL
   OR g_xcbj_m.xcbj001 IS NULL
   OR g_xcbj_m.xcbj002 IS NULL
   OR g_xcbj_m.xcbj003 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axct202_cl USING g_enterprise,g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct202_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct202_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct202_master_referesh USING g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003 INTO g_xcbj_m.xcbjcomp, 
       g_xcbj_m.xcbjld,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003,g_xcbj_m.xcbj001,g_xcbj_m.xcbjcomp_desc,g_xcbj_m.xcbjld_desc, 
       g_xcbj_m.xcbj001_desc
   
   #遮罩相關處理
   LET g_xcbj_m_mask_o.* =  g_xcbj_m.*
   CALL axct202_xcbj_t_mask()
   LET g_xcbj_m_mask_n.* =  g_xcbj_m.*
   
   CALL axct202_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct202_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcbj_t WHERE xcbjent = g_enterprise AND xcbjld = g_xcbj_m.xcbjld
                                                               AND xcbj001 = g_xcbj_m.xcbj001
                                                               AND xcbj002 = g_xcbj_m.xcbj002
                                                               AND xcbj003 = g_xcbj_m.xcbj003
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcbj_t:",SQLERRMESSAGE 
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
      #   CLOSE axct202_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcbj_d.clear() 
      CALL g_xcbj2_d.clear()       
 
     
      CALL axct202_ui_browser_refresh()  
      #CALL axct202_ui_headershow()  
      #CALL axct202_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axct202_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axct202_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axct202_cl
 
   #功能已完成,通報訊息中心
   CALL axct202_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axct202.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct202_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcbj_d.clear()
   CALL g_xcbj2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_xcbj3_d.clear()
   CALL g_xcbj4_d.clear()
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcbj004,xcbj005,xcbj006,xcbj010,xcbj011,xcbj021,xcbj020,xcbj101,xcbj102, 
       xcbj103,xcbj104,xcbj105,xcbj004,xcbj005,xcbj006,xcbjownid,xcbjowndp,xcbjcrtid,xcbjcrtdp,xcbjcrtdt, 
       xcbjmodid,xcbjmoddt,t1.ooefl003 ,t2.glacl004 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 FROM xcbj_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=xcbj004 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t2 ON t2.glaclent="||g_enterprise||" AND t2.glacl001='' AND t2.glacl002=xcbj011 AND t2.glacl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=xcbjownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=xcbjowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=xcbjcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=xcbjcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=xcbjmodid  ",
 
               " WHERE xcbjent= ? AND xcbjld=? AND xcbj001=? AND xcbj002=? AND xcbj003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcbj_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  DISTINCT xcbj004,xcbj005,xcbj006,xcbj010,xcbj011,xcbj021,xcbj020,xcbj101,xcbj102, 
       xcbj103,xcbj104,xcbj105,xcbj004,xcbj005,xcbj006,xcbjownid,xcbjowndp,xcbjcrtid,xcbjcrtdp,xcbjcrtdt, 
       xcbjmodid,xcbjmoddt,t1.ooefl003 ,t2.glacl004 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 FROM xcbj_t",   
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xcbj004 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t2 ON t2.glaclent='"||g_enterprise||"' AND t2.glacl001='",g_glaa004,"' AND t2.glacl002=xcbj011 AND t2.glacl003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=xcbjownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=xcbjowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=xcbjcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=xcbjcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=xcbjmodid  ",
 
               " WHERE xcbjent= ? AND xcbjld=? AND xcbj001=? AND xcbj002=? AND xcbj003=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcbj_t")
   END IF
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct202_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcbj_t.xcbj004,xcbj_t.xcbj005,xcbj_t.xcbj006"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct202_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axct202_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcbj_m.xcbjld,g_xcbj_m.xcbj001,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003 INTO g_xcbj_d[l_ac].xcbj004, 
          g_xcbj_d[l_ac].xcbj005,g_xcbj_d[l_ac].xcbj006,g_xcbj_d[l_ac].xcbj010,g_xcbj_d[l_ac].xcbj011, 
          g_xcbj_d[l_ac].xcbj021,g_xcbj_d[l_ac].xcbj020,g_xcbj_d[l_ac].xcbj101,g_xcbj_d[l_ac].xcbj102, 
          g_xcbj_d[l_ac].xcbj103,g_xcbj_d[l_ac].xcbj104,g_xcbj_d[l_ac].xcbj105,g_xcbj2_d[l_ac].xcbj004, 
          g_xcbj2_d[l_ac].xcbj005,g_xcbj2_d[l_ac].xcbj006,g_xcbj2_d[l_ac].xcbjownid,g_xcbj2_d[l_ac].xcbjowndp, 
          g_xcbj2_d[l_ac].xcbjcrtid,g_xcbj2_d[l_ac].xcbjcrtdp,g_xcbj2_d[l_ac].xcbjcrtdt,g_xcbj2_d[l_ac].xcbjmodid, 
          g_xcbj2_d[l_ac].xcbjmoddt,g_xcbj_d[l_ac].xcbj004_desc,g_xcbj_d[l_ac].xcbj011_desc,g_xcbj2_d[l_ac].xcbjownid_desc, 
          g_xcbj2_d[l_ac].xcbjowndp_desc,g_xcbj2_d[l_ac].xcbjcrtid_desc,g_xcbj2_d[l_ac].xcbjcrtdp_desc, 
          g_xcbj2_d[l_ac].xcbjmodid_desc   #(ver:49)
                             
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
         
         
         #應用 a12 樣板自動產生(Version:4)
 
 
 
 
        
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
 
            CALL g_xcbj_d.deleteElement(g_xcbj_d.getLength())
      CALL g_xcbj2_d.deleteElement(g_xcbj2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   LET g_sql = "SELECT  UNIQUE xcbj004,xcbj005,xcbj006,xcbj010,xcbj011,xcbj021,xcbj020,xcbj111,xcbj112, 
                  xcbj113,xcbj114,xcbj115,ooefl003,glacl004 FROM xcbj_t",      #160811-00015#1 add ooefl003,glacl004
               " LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xcbj004 AND ooefl002='"||g_dlang||"' ",    #160811-00015#1
               " LEFT JOIN glacl_t ON glaclent='"||g_enterprise||"' AND glacl001='",g_glaa004,"' AND glacl002=xcbj011 AND glacl003='"||g_dlang||"' ",   #160811-00015#1      
               " WHERE xcbjent= ? AND xcbjld=? AND xcbj001=? AND xcbj002=? AND xcbj003=?"  
                  
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   
   #add-point:b_fill段sql_after

   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct202_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcbj_t.xcbj004,xcbj_t.xcbj005,xcbj_t.xcbj006"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      PREPARE axct202_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR axct202_pb1
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_enterprise,g_xcbj_m.xcbjld
                                               ,g_xcbj_m.xcbj001
                                               ,g_xcbj_m.xcbj002
                                               ,g_xcbj_m.xcbj003
 
                                               
      FOREACH b_fill_cs1 INTO g_xcbj3_d[l_ac].xcbj004,g_xcbj3_d[l_ac].xcbj005,g_xcbj3_d[l_ac].xcbj006,g_xcbj3_d[l_ac].xcbj010, 
                             g_xcbj3_d[l_ac].xcbj011,g_xcbj3_d[l_ac].xcbj021,g_xcbj3_d[l_ac].xcbj020,g_xcbj3_d[l_ac].xcbj111, 
                             g_xcbj3_d[l_ac].xcbj112,g_xcbj3_d[l_ac].xcbj113,g_xcbj3_d[l_ac].xcbj114,g_xcbj3_d[l_ac].xcbj115,
                             g_xcbj3_d[l_ac].xcbj004_desc,g_xcbj3_d[l_ac].xcbj011_desc    #160811-00015#1 add ooefl003,glacl004
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充

         #end add-point
      
         #帶出公用欄位reference值
         
         
         #此段落由子樣板a12產生
      #LET g_xcbj2_d[l_ac].xcbjownid_desc = cl_get_username(g_xcbj2_d[l_ac].xcbjownid)
      #LET g_xcbj2_d[l_ac].xcbjowndp_desc = cl_get_deptname(g_xcbj2_d[l_ac].xcbjowndp)
      #LET g_xcbj2_d[l_ac].xcbjcrtid_desc = cl_get_username(g_xcbj2_d[l_ac].xcbjcrtid)
      #LET g_xcbj2_d[l_ac].xcbjcrtdp_desc = cl_get_deptname(g_xcbj2_d[l_ac].xcbjcrtdp)
      #LET g_xcbj2_d[l_ac].xcbjmodid_desc = cl_get_username(g_xcbj2_d[l_ac].xcbjmodid)
      ##LET .xcbjcnfid_desc = cl_get_deptname(.xcbjcnfid)
      ##LET .xcbjpstid_desc = cl_get_deptname(.xcbjpstid)
      
 
 
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xcbj3_d.deleteElement(g_xcbj3_d.getLength())
 
   END IF
   
   LET g_sql = "SELECT  UNIQUE xcbj004,xcbj005,xcbj006,xcbj010,xcbj011,xcbj021,xcbj020,xcbj121,xcbj122, 
          xcbj123,xcbj124,xcbj125,ooefl003,glacl004 FROM xcbj_t",    #160811-00015#1 add ooefl003,glacl004 
               " LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xcbj004 AND ooefl002='"||g_dlang||"' ",    #160811-00015#1
               " LEFT JOIN glacl_t ON glaclent='"||g_enterprise||"' AND glacl001='",g_glaa004,"' AND glacl002=xcbj011 AND glacl003='"||g_dlang||"' ",   #160811-00015#1                    
                  " WHERE xcbjent= ? AND xcbjld=? AND xcbj001=? AND xcbj002=? AND xcbj003=?"  
                  
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   
   #add-point:b_fill段sql_after

   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct202_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcbj_t.xcbj004,xcbj_t.xcbj005,xcbj_t.xcbj006"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      PREPARE axct202_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR axct202_pb2
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_xcbj_m.xcbjld
                                               ,g_xcbj_m.xcbj001
                                               ,g_xcbj_m.xcbj002
                                               ,g_xcbj_m.xcbj003
 
                                               
      FOREACH b_fill_cs2 INTO g_xcbj4_d[l_ac].xcbj004,g_xcbj4_d[l_ac].xcbj005,g_xcbj4_d[l_ac].xcbj006,g_xcbj4_d[l_ac].xcbj010, 
                              g_xcbj4_d[l_ac].xcbj011,g_xcbj4_d[l_ac].xcbj021,g_xcbj4_d[l_ac].xcbj020,g_xcbj4_d[l_ac].xcbj121, 
                              g_xcbj4_d[l_ac].xcbj122,g_xcbj4_d[l_ac].xcbj123,g_xcbj4_d[l_ac].xcbj124,g_xcbj4_d[l_ac].xcbj125,
                              g_xcbj3_d[l_ac].xcbj004_desc,g_xcbj3_d[l_ac].xcbj011_desc    #160811-00015#1 add ooefl003,glacl004
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充

         #end add-point
      
         #帶出公用欄位reference值
         
         
         #此段落由子樣板a12產生
      #LET g_xcbj2_d[l_ac].xcbjownid_desc = cl_get_username(g_xcbj2_d[l_ac].xcbjownid)
      #LET g_xcbj2_d[l_ac].xcbjowndp_desc = cl_get_deptname(g_xcbj2_d[l_ac].xcbjowndp)
      #LET g_xcbj2_d[l_ac].xcbjcrtid_desc = cl_get_username(g_xcbj2_d[l_ac].xcbjcrtid)
      #LET g_xcbj2_d[l_ac].xcbjcrtdp_desc = cl_get_deptname(g_xcbj2_d[l_ac].xcbjcrtdp)
      #LET g_xcbj2_d[l_ac].xcbjmodid_desc = cl_get_username(g_xcbj2_d[l_ac].xcbjmodid)
      ##LET .xcbjcnfid_desc = cl_get_deptname(.xcbjcnfid)
      ##LET .xcbjpstid_desc = cl_get_deptname(.xcbjpstid)
      
 
 
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xcbj4_d.deleteElement(g_xcbj4_d.getLength())
 
   END IF
   
   FREE axct202_pb1 
   
   FREE axct202_pb2   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcbj_d.getLength()
      LET g_xcbj_d_mask_o[l_ac].* =  g_xcbj_d[l_ac].*
      CALL axct202_xcbj_t_mask()
      LET g_xcbj_d_mask_n[l_ac].* =  g_xcbj_d[l_ac].*
   END FOR
   
   LET g_xcbj2_d_mask_o.* =  g_xcbj2_d.*
   FOR l_ac = 1 TO g_xcbj2_d.getLength()
      LET g_xcbj2_d_mask_o[l_ac].* =  g_xcbj2_d[l_ac].*
      CALL axct202_xcbj_t_mask()
      LET g_xcbj2_d_mask_n[l_ac].* =  g_xcbj2_d[l_ac].*
   END FOR
 
 
   FREE axct202_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axct202_idx_chk()
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
      IF g_detail_idx > g_xcbj_d.getLength() THEN
         LET g_detail_idx = g_xcbj_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcbj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcbj_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcbj2_d.getLength() THEN
         LET g_detail_idx = g_xcbj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcbj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcbj2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct202_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcbj_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axct202_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcbj_t
    WHERE xcbjent = g_enterprise AND xcbjld = g_xcbj_m.xcbjld AND
                              xcbj001 = g_xcbj_m.xcbj001 AND
                              xcbj002 = g_xcbj_m.xcbj002 AND
                              xcbj003 = g_xcbj_m.xcbj003 AND
 
          xcbj004 = g_xcbj_d_t.xcbj004
      AND xcbj005 = g_xcbj_d_t.xcbj005
      AND xcbj006 = g_xcbj_d_t.xcbj006
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcbj_t:",SQLERRMESSAGE 
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
 
{<section id="axct202.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct202_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axct202.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct202_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axct202.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct202_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axct202.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axct202_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcbj_d[l_ac].xcbj004 = g_xcbj_d_t.xcbj004 
      AND g_xcbj_d[l_ac].xcbj005 = g_xcbj_d_t.xcbj005 
      AND g_xcbj_d[l_ac].xcbj006 = g_xcbj_d_t.xcbj006 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axct202_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axct202.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct202_lock_b(ps_table,ps_page)
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
   #CALL axct202_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct202.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct202_unlock_b(ps_table,ps_page)
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
 
{<section id="axct202.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct202_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcbjld,xcbj001,xcbj002,xcbj003",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("xcbjcomp",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct202.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct202_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcbjld,xcbj001,xcbj002,xcbj003",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("xcbjcomp",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct202.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct202_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct202_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axct202_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct202.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axct202_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct202.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axct202_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct202.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axct202_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct202.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct202_default_search()
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
      LET ls_wc = ls_wc, " xcbjld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcbj001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcbj002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcbj003 = '", g_argv[04], "' AND "
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
 
{<section id="axct202.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct202_fill_chk(ps_idx)
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
 
{<section id="axct202.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axct202_modify_detail_chk(ps_record)
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
         LET ls_return = "xcbj004"
      WHEN "s_detail2"
         LET ls_return = "xcbj004_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axct202.mask_functions" >}
&include "erp/axc/axct202_mask.4gl"
 
{</section>}
 
{<section id="axct202.state_change" >}
    
 
{</section>}
 
{<section id="axct202.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axct202_set_pk_array()
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
   LET g_pk_array[1].values = g_xcbj_m.xcbjld
   LET g_pk_array[1].column = 'xcbjld'
   LET g_pk_array[2].values = g_xcbj_m.xcbj001
   LET g_pk_array[2].column = 'xcbj001'
   LET g_pk_array[3].values = g_xcbj_m.xcbj002
   LET g_pk_array[3].column = 'xcbj002'
   LET g_pk_array[4].values = g_xcbj_m.xcbj003
   LET g_pk_array[4].column = 'xcbj003'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct202.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axct202_msgcentre_notify(lc_state)
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
   CALL axct202_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcbj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct202.other_function" readonly="Y" >}
#
PRIVATE FUNCTION axct202_visible()
   DEFINE l_date  DATE    #fengmy150120
   IF g_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('lbl_page3',TRUE)
   ELSE
      CALL cl_set_comp_visible('lbl_page3',FALSE) 
   END IF 
   IF g_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('lbl_page4',TRUE)
   ELSE
      CALL cl_set_comp_visible('lbl_page4',FALSE) 
   END IF 
   #fengmy 150120----begin
   #檢查年度期別>=關賬日期，則不可修改刪除
   CALL cl_get_para(g_enterprise,g_xcbj_m.xcbjcomp,'S-FIN-6012') RETURNING l_date
   IF g_xcbj_m.xcbj002 < YEAR(l_date) THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   ELSE
      IF g_xcbj_m.xcbj002 =  YEAR(l_date) THEN
         IF g_xcbj_m.xcbj003 < MONTH(l_date) THEN
            CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
          ELSE
            CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
         END IF
      ELSE
         CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)
      END IF
   END IF
   #fengmy 150120----end
END FUNCTION
# 參考欄位帶值
PRIVATE FUNCTION axct202_show_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbj_m.xcbjcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcbj_m.xcbjcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcbj_m.xcbjcomp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbj_m.xcbjld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcbj_m.xcbjld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcbj_m.xcbjld_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbj_m.xcbj001
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcbj_m.xcbj001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcbj_m.xcbj001_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcbj_m.xcbjld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaa004,glaa015,glaa019 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_glaa004 = '', g_rtn_fields[1] , ''
   LET g_glaa015 = '', g_rtn_fields[2] , ''
   LET g_glaa019 = '', g_rtn_fields[3] , ''
END FUNCTION

################################################################################
# Descriptions...: 检查法人账套
# Memo...........:
# Usage..........: CALL axct202_chk_ld_comp（）
#                  
# Input parameter: 无
# Return code....: 无
# Date & Author..: 20150105 By fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION axct202_chk_ld_comp()
DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success = TRUE

#只检查法人
   IF g_xcbj_m.xcbjld IS NULL AND g_xcbj_m.xcbjcomp IS NOT NULL THEN   
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xcbj_m.xcbjcomp
         
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooef001_1") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

#只检查账套
   IF g_xcbj_m.xcbjld IS NOT NULL AND g_xcbj_m.xcbjcomp IS NULL THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xcbj_m.xcbjld
      #160318-00025#11--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
      #160318-00025#11--add--end    
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_glaald") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
         CALL s_ld_chk_authorization(g_user,g_xcbj_m.xcbjld) RETURNING l_success
         IF l_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00022'
            LET g_errparam.extend = g_xcbj_m.xcbjld
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

#法人账套都存在，检查他们的关系
   IF NOT s_ld_chk_comp(g_xcbj_m.xcbjld,g_xcbj_m.xcbjcomp) THEN  #v_glaald_5 
      LET g_xcbj_m.xcbjcomp = g_xcbj_m_t.xcbjcomp
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查年月
# Memo...........:
# Usage..........: CALL axct202_chk_year_period()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 150105 By fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION axct202_chk_year_period()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_bdate          LIKE type_t.dat    #起始年度+期別對應的起始截止日期
   DEFINE l_edate          LIKE type_t.dat
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   DEFINE l_date  DATE
   DEFINE l_cnt            LIKE type_t.num5
   LET r_success = TRUE 
   #抓出会计周期参考表号  glaa003
   SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xcbj_m.xcbjcomp
         AND glaa014  = 'Y'   
   IF g_xcbj_m.xcbj002 IS NOT NULL  THEN
      IF NOT s_fin_date_chk_year(g_xcbj_m.xcbj002) THEN  
         LET r_success = FALSE
         RETURN r_success      
      END IF
      SELECT COUNT(*) INTO l_cnt FROM glav_t
      WHERE glavent = g_enterprise
        AND glav001 = l_glaa003
        AND glav002 = g_xcbj_m.xcbj002
        AND glavstus = 'Y' 
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00581'
         LET g_errparam.extend = g_xcbj_m.xcbj002
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         LET r_success = FALSE
         RETURN r_success 
      END IF
   END IF
   

   IF g_xcbj_m.xcbj002 IS NOT NULL AND g_xcbj_m.xcbj003 IS NOT NULL THEN
      IF NOT s_fin_date_chk_period(l_glaa003,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003) THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
      CALL s_fin_date_get_period_range(l_glaa003,g_xcbj_m.xcbj002,g_xcbj_m.xcbj003) RETURNING l_bdate,l_edate
      
      IF NOT s_date_chk_close(l_edate,'2') THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
   END IF
   RETURN r_success
END FUNCTION

 
{</section>}
 
