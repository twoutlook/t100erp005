#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq701.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-05-06 09:37:50), PR版次:0007(2016-08-16 17:59:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000075
#+ Filename...: axcq701
#+ Description: 在製成本次要素查詢作業
#+ Creator....: 03297(2014-10-20 13:52:32)
#+ Modifier...: 06821 -SD/PR- 07024
 
{</section>}
 
{<section id="axcq701.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150319-00004#11  150506   By Jessy 查詢類轉XG報表
#160318-00025#9   160421   By 07675 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160802-00020#8   160816   By dorislai 增加帳套權限管控、法人權限管控
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
PRIVATE type type_g_xccd_m        RECORD
       xccdcomp LIKE xccd_t.xccdcomp, 
   xccdcomp_desc LIKE type_t.chr80, 
   xccd004 LIKE xccd_t.xccd004, 
   xccd005 LIKE xccd_t.xccd005, 
   xccdld LIKE xccd_t.xccdld, 
   xccdld_desc LIKE type_t.chr80, 
   xccd006 LIKE xccd_t.xccd006, 
   xccd003 LIKE xccd_t.xccd003, 
   xccd003_desc LIKE type_t.chr80, 
   xccd007 LIKE xccd_t.xccd007, 
   xccd007_desc LIKE type_t.chr80, 
   xccd007_desc_desc LIKE type_t.chr80, 
   imag014 LIKE type_t.chr10, 
   imag014_desc LIKE type_t.chr80, 
   xccd002 LIKE xccd_t.xccd002, 
   xccd002_desc LIKE type_t.chr80, 
   sfaa048 LIKE type_t.dat, 
   xccd009 LIKE xccd_t.xccd009, 
   xcbb006 LIKE type_t.num5, 
   sfaa042 LIKE type_t.chr1, 
   xccd200 LIKE xccd_t.xccd200, 
   xccd001 LIKE xccd_t.xccd001
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcde_d        RECORD
       xcde007 LIKE xcde_t.xcde007, 
   xcde007_desc LIKE type_t.chr500, 
   xcde007_desc_desc LIKE type_t.chr500, 
   xcde008 LIKE xcde_t.xcde008, 
   xcde009 LIKE xcde_t.xcde009, 
   xcau003 LIKE type_t.num10, 
   xcde010 LIKE xcde_t.xcde010, 
   xcde010_desc LIKE type_t.chr500, 
   xcde101 LIKE xcde_t.xcde101, 
   xcde102 LIKE xcde_t.xcde102, 
   xcde201 LIKE xcde_t.xcde201, 
   xcde202 LIKE xcde_t.xcde202, 
   xcde301 LIKE xcde_t.xcde301, 
   xcde302 LIKE xcde_t.xcde302, 
   xcde303 LIKE xcde_t.xcde303, 
   xcde304 LIKE xcde_t.xcde304, 
   xcde901 LIKE xcde_t.xcde901, 
   xcde902 LIKE xcde_t.xcde902
       END RECORD
PRIVATE TYPE type_g_xcde2_d RECORD
       xcde007 LIKE xcde_t.xcde007, 
   xcde007_2_desc LIKE type_t.chr500, 
   xcde007_2_desc_desc LIKE type_t.chr500, 
   xcde008 LIKE xcde_t.xcde008, 
   xcde009 LIKE xcde_t.xcde009, 
   xcau003 LIKE xcau_t.xcau003, 
   xcde010 LIKE xcde_t.xcde010, 
   xcde010_2_desc LIKE type_t.chr500, 
   xcde101 LIKE xcde_t.xcde101, 
   xcde102 LIKE xcde_t.xcde102, 
   xcde205 LIKE xcde_t.xcde205, 
   xcde206 LIKE xcde_t.xcde206, 
   xcde307 LIKE xcde_t.xcde307, 
   xcde308 LIKE xcde_t.xcde308, 
   xcde303 LIKE xcde_t.xcde303, 
   xcde304 LIKE xcde_t.xcde304, 
   xcde901 LIKE xcde_t.xcde901, 
   xcde902 LIKE xcde_t.xcde902
       END RECORD
PRIVATE TYPE type_g_xcde3_d RECORD
       xcde007 LIKE xcde_t.xcde007, 
   xcde007_3_desc LIKE type_t.chr500, 
   xcde007_3_desc_desc LIKE type_t.chr500, 
   xcde008 LIKE xcde_t.xcde008, 
   xcde009 LIKE xcde_t.xcde009, 
   xcau003 LIKE xcau_t.xcau003, 
   xcde010 LIKE xcde_t.xcde010, 
   xcde010_3_desc LIKE type_t.chr500, 
   xcde207 LIKE xcde_t.xcde207, 
   xcde208 LIKE xcde_t.xcde208, 
   xcde209 LIKE xcde_t.xcde209, 
   xcde210 LIKE xcde_t.xcde210, 
   xcde301 LIKE xcde_t.xcde301, 
   xcde302 LIKE xcde_t.xcde302, 
   xcde303 LIKE xcde_t.xcde303, 
   xcde304 LIKE xcde_t.xcde304, 
   xcde901 LIKE xcde_t.xcde901, 
   xcde902 LIKE xcde_t.xcde902
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xccdld LIKE xccd_t.xccdld,
      b_xccd001 LIKE xccd_t.xccd001,
      b_xccd002 LIKE xccd_t.xccd002,
      b_xccd003 LIKE xccd_t.xccd003,
      b_xccd004 LIKE xccd_t.xccd004,
      b_xccd005 LIKE xccd_t.xccd005,
      b_xccd006 LIKE xccd_t.xccd006
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150113
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150113
DEFINE g_wc_cs_ld            STRING          #160802-00020#8-add
DEFINE g_wc_cs_comp          STRING          #160802-00020#8-add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xccd_m          type_g_xccd_m
DEFINE g_xccd_m_t        type_g_xccd_m
DEFINE g_xccd_m_o        type_g_xccd_m
DEFINE g_xccd_m_mask_o   type_g_xccd_m #轉換遮罩前資料
DEFINE g_xccd_m_mask_n   type_g_xccd_m #轉換遮罩後資料
 
   DEFINE g_xccd004_t LIKE xccd_t.xccd004
DEFINE g_xccd005_t LIKE xccd_t.xccd005
DEFINE g_xccdld_t LIKE xccd_t.xccdld
DEFINE g_xccd006_t LIKE xccd_t.xccd006
DEFINE g_xccd003_t LIKE xccd_t.xccd003
DEFINE g_xccd002_t LIKE xccd_t.xccd002
DEFINE g_xccd001_t LIKE xccd_t.xccd001
 
 
DEFINE g_xcde_d          DYNAMIC ARRAY OF type_g_xcde_d
DEFINE g_xcde_d_t        type_g_xcde_d
DEFINE g_xcde_d_o        type_g_xcde_d
DEFINE g_xcde_d_mask_o   DYNAMIC ARRAY OF type_g_xcde_d #轉換遮罩前資料
DEFINE g_xcde_d_mask_n   DYNAMIC ARRAY OF type_g_xcde_d #轉換遮罩後資料
DEFINE g_xcde2_d          DYNAMIC ARRAY OF type_g_xcde2_d
DEFINE g_xcde2_d_t        type_g_xcde2_d
DEFINE g_xcde2_d_o        type_g_xcde2_d
DEFINE g_xcde2_d_mask_o   DYNAMIC ARRAY OF type_g_xcde2_d #轉換遮罩前資料
DEFINE g_xcde2_d_mask_n   DYNAMIC ARRAY OF type_g_xcde2_d #轉換遮罩後資料
DEFINE g_xcde3_d          DYNAMIC ARRAY OF type_g_xcde3_d
DEFINE g_xcde3_d_t        type_g_xcde3_d
DEFINE g_xcde3_d_o        type_g_xcde3_d
DEFINE g_xcde3_d_mask_o   DYNAMIC ARRAY OF type_g_xcde3_d #轉換遮罩前資料
DEFINE g_xcde3_d_mask_n   DYNAMIC ARRAY OF type_g_xcde3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
DEFINE g_wc2_extend          STRING
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
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcq701.main" >}
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
   #160802-00020#8-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#8-add-(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xccdcomp,'',xccd004,xccd005,xccdld,'',xccd006,xccd003,'',xccd007,'','', 
       '','',xccd002,'','',xccd009,'','',xccd200,xccd001", 
                      " FROM xccd_t",
                      " WHERE xccdent= ? AND xccdld=? AND xccd001=? AND xccd002=? AND xccd003=? AND  
                          xccd004=? AND xccd005=? AND xccd006=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq701_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xccdcomp,t0.xccd004,t0.xccd005,t0.xccdld,t0.xccd006,t0.xccd003,t0.xccd007, 
       t0.xccd002,t0.xccd009,t0.xccd200,t0.xccd001,t4.xcbfl003",
               " FROM xccd_t t0",
                              " LEFT JOIN xcbfl_t t4 ON t4.xcbflent="||g_enterprise||" AND t4.xcbflcomp=t0.xccdcomp AND t4.xcbfl001=t0.xccd002 AND t4.xcbfl002='"||g_dlang||"' ",
 
               " WHERE t0.xccdent = " ||g_enterprise|| " AND t0.xccdld = ? AND t0.xccd001 = ? AND t0.xccd002 = ? AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ? AND t0.xccd006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
    LET g_sql = " SELECT UNIQUE t0.xccdcomp,t0.xccd004,t0.xccd005,t0.xccdld,t0.xccd006,t0.xccd003,t0.xccd007, 
       t0.xccd002,t0.xccd009,t0.xccd200,t4.xcbfl003",
               " FROM xccd_t t0",
                              " LEFT JOIN xcbfl_t t4 ON t4.xcbflent='"||g_enterprise||"' AND t4.xcbflcomp=t0.xccdcomp AND t4.xcbfl001=t0.xccd002 AND t4.xcbfl002='"||g_dlang||"' ",
 
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND t0.xccdld = ? AND t0.xccd002 = ? AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ? AND t0.xccd006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE axcq701_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq701 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq701_init()   
 
      #進入選單 Menu (="N")
      CALL axcq701_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq701
      
   END IF 
   
   CLOSE axcq701_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq701.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq701_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2','3',","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL axcq701_x01_tmp()                  #150319-00004#11 建立臨時表
   CALL cl_set_combo_scc('xcau003','8901')
   CALL cl_set_combo_scc('xcau003_2','8901')
   CALL cl_set_combo_scc('xcau003_3','8901')   
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否           
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccd002,xccd002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcde008_3',TRUE)                    
   ELSE                           
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcde008_3',FALSE)                
   END IF   
   #end add-point
   
   #初始化搜尋條件
   CALL axcq701_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq701.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq701_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xccd_m.* TO NULL
         CALL g_xcde_d.clear()
         CALL g_xcde2_d.clear()
         CALL g_xcde3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq701_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_xcde_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq701_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2','3',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL axcq701_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xcde2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq701_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axcq701_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xcde3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq701_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL axcq701_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq701_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axcq701_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq701_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axcq701_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
 
 
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xccd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcde_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL axcq701_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xccd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xcde_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axcq701_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axcq701_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq701_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq701_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq701_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq701_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq701_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq701_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq701_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq701_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq701_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq701_idx_chk()
          
         #excel匯出功能          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcde_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcde2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xcde3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #150319-00004#11-----s
               CALL axcq701_insert_tmp()                   #填充XG報表列印的資料
               CALL axcq701_x01(' 1=1','axcq701_x01_tmp',g_para_data1)  #畫面的東西轉成XG報表
               #150319-00004#11-----e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150319-00004#11-----s
               CALL axcq701_insert_tmp()                   #填充XG報表列印的資料
               CALL axcq701_x01(' 1=1','axcq701_x01_tmp',g_para_data1)  #畫面的東西轉成XG報表
               #150319-00004#11-----e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq701_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
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
            CALL axcq701_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq701_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq701_set_pk_array()
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
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="axcq701.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq701_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006 ",
                      " FROM xccd_t ",
                      " ",
                      " LEFT JOIN xcde_t ON xcdeent = xccdent AND xccdld = xcdeld AND xccd001 = xcde001 AND xccd002 = xcde002 AND xccd003 = xcde003 AND xccd004 = xcde004 AND xccd005 = xcde005 AND xccd006 = xcde006 ", "  ",
                      #add-point:browser_fill段sql(xcde_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE xccdent = " ||g_enterprise|| " AND xcdeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006 ",
                      " FROM xccd_t ", 
                      "  ",
                      "  ",
                      " WHERE xccdent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xccd_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
    IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xccdld,'',xccd002,xccd003,xccd004,xccd005,xccd006 ",
                      " FROM xccd_t ",
                      " ",
                      " LEFT JOIN xcde_t ON xcdeent = xccdent AND xccdld = xcdeld AND xccd001 = xcde001 AND xccd002 = xcde002 AND xccd003 = xcde003 AND xccd004 = xcde004 AND xccd005 = xcde005 AND xccd006 = xcde006 ",
 
 
                      " ", 
                      " ", 
                      " WHERE xccdent = '" ||g_enterprise|| "' AND xcdeent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xccdld,'',xccd002,xccd003,xccd004,xccd005,xccd006 ",
                      " FROM xccd_t ", 
                      "  ",
                      "  ",
                      " WHERE xccdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccd_t")
   END IF
   #160802-00020#8-add-(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql ," AND xccdld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql ," AND xccdcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#8-add-(E)
   #end add-point
   
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
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_xccd_m.* TO NULL
      CALL g_xcde_d.clear()        
      CALL g_xcde2_d.clear() 
      CALL g_xcde3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xccdld,t0.xccd001,t0.xccd002,t0.xccd003,t0.xccd004,t0.xccd005,t0.xccd006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT '',t0.xccdld,t0.xccd001,t0.xccd002,t0.xccd003,t0.xccd004,t0.xccd005, 
          t0.xccd006 ",
                  " FROM xccd_t t0",
                  "  ",
                  "  LEFT JOIN xcde_t ON xcdeent = xccdent AND xccdld = xcdeld AND xccd001 = xcde001 AND xccd002 = xcde002 AND xccd003 = xcde003 AND xccd004 = xcde004 AND xccd005 = xcde005 AND xccd006 = xcde006 ", "  ", 
                  #add-point:browser_fill段sql(xcde_t1) name="browser_fill.join.xcde_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.xccdent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xccd_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT '',t0.xccdld,t0.xccd001,t0.xccd002,t0.xccd003,t0.xccd004,t0.xccd005, 
          t0.xccd006 ",
                  " FROM xccd_t t0",
                  "  ",
                  
                  " WHERE t0.xccdent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xccd_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = " SELECT DISTINCT '',t0.xccdld,'',t0.xccd002,t0.xccd003,t0.xccd004,t0.xccd005, 
       t0.xccd006 ",
               " FROM xccd_t t0",
               "  ",
               "  LEFT JOIN xcde_t ON xcdeent = xccdent AND xccdld = xcdeld AND xccd001 = xcde001 AND xccd002 = xcde002 AND xccd003 = xcde003 AND xccd004 = xcde004 AND xccd005 = xcde005 AND xccd006 = xcde006 ",
 
 
               "  ",
               
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xccd_t")
   #160802-00020#8-add-(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND t0.xccdld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND t0.xccdcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#8-add-(E)
   #end add-point
   LET g_sql = g_sql, " ORDER BY xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   LET g_sql = cl_replace_str(g_sql," ORDER BY xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006 "," ORDER BY xccdld,xccd002,xccd003,xccd004,xccd005,xccd006 ")
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xccdld,g_browser[g_cnt].b_xccd001, 
          g_browser[g_cnt].b_xccd002,g_browser[g_cnt].b_xccd003,g_browser[g_cnt].b_xccd004,g_browser[g_cnt].b_xccd005, 
          g_browser[g_cnt].b_xccd006
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
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
   
   IF cl_null(g_browser[g_cnt].b_xccdld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
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
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq701_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xccd_m.xccdld = g_browser[g_current_idx].b_xccdld   
   LET g_xccd_m.xccd001 = g_browser[g_current_idx].b_xccd001   
   LET g_xccd_m.xccd002 = g_browser[g_current_idx].b_xccd002   
   LET g_xccd_m.xccd003 = g_browser[g_current_idx].b_xccd003   
   LET g_xccd_m.xccd004 = g_browser[g_current_idx].b_xccd004   
   LET g_xccd_m.xccd005 = g_browser[g_current_idx].b_xccd005   
   LET g_xccd_m.xccd006 = g_browser[g_current_idx].b_xccd006   
 
   EXECUTE axcq701_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005, 
       g_xccd_m.xccdld,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.xccd002,g_xccd_m.xccd009, 
       g_xccd_m.xccd200,g_xccd_m.xccd001,g_xccd_m.xccd002_desc
   
   CALL axcq701_xccd_t_mask()
   CALL axcq701_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axcq701.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq701_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq701_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xccdld = g_xccd_m.xccdld 
         AND g_browser[l_i].b_xccd001 = g_xccd_m.xccd001 
         AND g_browser[l_i].b_xccd002 = g_xccd_m.xccd002 
         AND g_browser[l_i].b_xccd003 = g_xccd_m.xccd003 
         AND g_browser[l_i].b_xccd004 = g_xccd_m.xccd004 
         AND g_browser[l_i].b_xccd005 = g_xccd_m.xccd005 
         AND g_browser[l_i].b_xccd006 = g_xccd_m.xccd006 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
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
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq701_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xccd_m.* TO NULL
   CALL g_xcde_d.clear()        
   CALL g_xcde2_d.clear() 
   CALL g_xcde3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccdcomp,xccd004,xccd005,xccdld,xccd006,xccd003,xccd007,xccd002,xccd009, 
          xccd200,xccd001
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            CALL axcq701_default()
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xccdcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccdcomp
            #add-point:ON ACTION controlp INFIELD xccdcomp name="construct.c.xccdcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#8-add-(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#8-add-(E)
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccdcomp  #顯示到畫面上
            NEXT FIELD xccdcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccdcomp
            #add-point:BEFORE FIELD xccdcomp name="construct.b.xccdcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccdcomp
            
            #add-point:AFTER FIELD xccdcomp name="construct.a.xccdcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd004
            #add-point:BEFORE FIELD xccd004 name="construct.b.xccd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd004
            
            #add-point:AFTER FIELD xccd004 name="construct.a.xccd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd004
            #add-point:ON ACTION controlp INFIELD xccd004 name="construct.c.xccd004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd005
            #add-point:BEFORE FIELD xccd005 name="construct.b.xccd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd005
            
            #add-point:AFTER FIELD xccd005 name="construct.a.xccd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd005
            #add-point:ON ACTION controlp INFIELD xccd005 name="construct.c.xccd005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xccdld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccdld
            #add-point:ON ACTION controlp INFIELD xccdld name="construct.c.xccdld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#8-add-(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#8-add-(E)
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccdld  #顯示到畫面上
            NEXT FIELD xccdld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccdld
            #add-point:BEFORE FIELD xccdld name="construct.b.xccdld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccdld
            
            #add-point:AFTER FIELD xccdld name="construct.a.xccdld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd006
            #add-point:ON ACTION controlp INFIELD xccd006 name="construct.c.xccd006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd006  #顯示到畫面上
            NEXT FIELD xccd006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd006
            #add-point:BEFORE FIELD xccd006 name="construct.b.xccd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd006
            
            #add-point:AFTER FIELD xccd006 name="construct.a.xccd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd003
            #add-point:ON ACTION controlp INFIELD xccd003 name="construct.c.xccd003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd003  #顯示到畫面上
            NEXT FIELD xccd003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd003
            #add-point:BEFORE FIELD xccd003 name="construct.b.xccd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd003
            
            #add-point:AFTER FIELD xccd003 name="construct.a.xccd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd007
            #add-point:ON ACTION controlp INFIELD xccd007 name="construct.c.xccd007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd007  #顯示到畫面上
            NEXT FIELD xccd007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd007
            #add-point:BEFORE FIELD xccd007 name="construct.b.xccd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd007
            
            #add-point:AFTER FIELD xccd007 name="construct.a.xccd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd002
            #add-point:ON ACTION controlp INFIELD xccd002 name="construct.c.xccd002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd002  #顯示到畫面上
            NEXT FIELD xccd002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd002
            #add-point:BEFORE FIELD xccd002 name="construct.b.xccd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd002
            
            #add-point:AFTER FIELD xccd002 name="construct.a.xccd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd009
            #add-point:ON ACTION controlp INFIELD xccd009 name="construct.c.xccd009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd009  #顯示到畫面上
            NEXT FIELD xccd009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd009
            #add-point:BEFORE FIELD xccd009 name="construct.b.xccd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd009
            
            #add-point:AFTER FIELD xccd009 name="construct.a.xccd009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd200
            #add-point:BEFORE FIELD xccd200 name="construct.b.xccd200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd200
            
            #add-point:AFTER FIELD xccd200 name="construct.a.xccd200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd200
            #add-point:ON ACTION controlp INFIELD xccd200 name="construct.c.xccd200"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd001
            #add-point:BEFORE FIELD xccd001 name="construct.b.xccd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd001
            
            #add-point:AFTER FIELD xccd001 name="construct.a.xccd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd001
            #add-point:ON ACTION controlp INFIELD xccd001 name="construct.c.xccd001"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xcde007,xcde008,xcde009,xcau003,xcde010,xcde101,xcde102,xcde201,xcde202, 
          xcde301,xcde302,xcde303,xcde304,xcde901,xcde902,xcde205,xcde206,xcde307,xcde308,xcde207,xcde208, 
          xcde209,xcde210
           FROM s_detail1[1].xcde007,s_detail1[1].xcde008,s_detail1[1].xcde009,s_detail1[1].xcau003, 
               s_detail1[1].xcde010,s_detail1[1].xcde101,s_detail1[1].xcde102,s_detail1[1].xcde201,s_detail1[1].xcde202, 
               s_detail1[1].xcde301,s_detail1[1].xcde302,s_detail1[1].xcde303,s_detail1[1].xcde304,s_detail1[1].xcde901, 
               s_detail1[1].xcde902,s_detail2[1].xcde205,s_detail2[1].xcde206,s_detail2[1].xcde307,s_detail2[1].xcde308, 
               s_detail3[1].xcde207,s_detail3[1].xcde208,s_detail3[1].xcde209,s_detail3[1].xcde210
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde007
            #add-point:BEFORE FIELD xcde007 name="construct.b.page1.xcde007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde007
            
            #add-point:AFTER FIELD xcde007 name="construct.a.page1.xcde007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde007
            #add-point:ON ACTION controlp INFIELD xcde007 name="construct.c.page1.xcde007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde008
            #add-point:BEFORE FIELD xcde008 name="construct.b.page1.xcde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde008
            
            #add-point:AFTER FIELD xcde008 name="construct.a.page1.xcde008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde008
            #add-point:ON ACTION controlp INFIELD xcde008 name="construct.c.page1.xcde008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde009
            #add-point:BEFORE FIELD xcde009 name="construct.b.page1.xcde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde009
            
            #add-point:AFTER FIELD xcde009 name="construct.a.page1.xcde009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde009
            #add-point:ON ACTION controlp INFIELD xcde009 name="construct.c.page1.xcde009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcau003
            #add-point:BEFORE FIELD xcau003 name="construct.b.page1.xcau003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcau003
            
            #add-point:AFTER FIELD xcau003 name="construct.a.page1.xcau003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcau003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcau003
            #add-point:ON ACTION controlp INFIELD xcau003 name="construct.c.page1.xcau003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcde010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde010
            #add-point:ON ACTION controlp INFIELD xcde010 name="construct.c.page1.xcde010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcau001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde010  #顯示到畫面上
            NEXT FIELD xcde010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde010
            #add-point:BEFORE FIELD xcde010 name="construct.b.page1.xcde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde010
            
            #add-point:AFTER FIELD xcde010 name="construct.a.page1.xcde010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde101
            #add-point:BEFORE FIELD xcde101 name="construct.b.page1.xcde101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde101
            
            #add-point:AFTER FIELD xcde101 name="construct.a.page1.xcde101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde101
            #add-point:ON ACTION controlp INFIELD xcde101 name="construct.c.page1.xcde101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde102
            #add-point:BEFORE FIELD xcde102 name="construct.b.page1.xcde102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde102
            
            #add-point:AFTER FIELD xcde102 name="construct.a.page1.xcde102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde102
            #add-point:ON ACTION controlp INFIELD xcde102 name="construct.c.page1.xcde102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde201
            #add-point:BEFORE FIELD xcde201 name="construct.b.page1.xcde201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde201
            
            #add-point:AFTER FIELD xcde201 name="construct.a.page1.xcde201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde201
            #add-point:ON ACTION controlp INFIELD xcde201 name="construct.c.page1.xcde201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde202
            #add-point:BEFORE FIELD xcde202 name="construct.b.page1.xcde202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde202
            
            #add-point:AFTER FIELD xcde202 name="construct.a.page1.xcde202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde202
            #add-point:ON ACTION controlp INFIELD xcde202 name="construct.c.page1.xcde202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde301
            #add-point:BEFORE FIELD xcde301 name="construct.b.page1.xcde301"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde301
            
            #add-point:AFTER FIELD xcde301 name="construct.a.page1.xcde301"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde301
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde301
            #add-point:ON ACTION controlp INFIELD xcde301 name="construct.c.page1.xcde301"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde302
            #add-point:BEFORE FIELD xcde302 name="construct.b.page1.xcde302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde302
            
            #add-point:AFTER FIELD xcde302 name="construct.a.page1.xcde302"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde302
            #add-point:ON ACTION controlp INFIELD xcde302 name="construct.c.page1.xcde302"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde303
            #add-point:BEFORE FIELD xcde303 name="construct.b.page1.xcde303"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde303
            
            #add-point:AFTER FIELD xcde303 name="construct.a.page1.xcde303"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde303
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde303
            #add-point:ON ACTION controlp INFIELD xcde303 name="construct.c.page1.xcde303"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde304
            #add-point:BEFORE FIELD xcde304 name="construct.b.page1.xcde304"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde304
            
            #add-point:AFTER FIELD xcde304 name="construct.a.page1.xcde304"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde304
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde304
            #add-point:ON ACTION controlp INFIELD xcde304 name="construct.c.page1.xcde304"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde901
            #add-point:BEFORE FIELD xcde901 name="construct.b.page1.xcde901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde901
            
            #add-point:AFTER FIELD xcde901 name="construct.a.page1.xcde901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde901
            #add-point:ON ACTION controlp INFIELD xcde901 name="construct.c.page1.xcde901"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde902
            #add-point:BEFORE FIELD xcde902 name="construct.b.page1.xcde902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde902
            
            #add-point:AFTER FIELD xcde902 name="construct.a.page1.xcde902"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcde902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde902
            #add-point:ON ACTION controlp INFIELD xcde902 name="construct.c.page1.xcde902"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde205
            #add-point:BEFORE FIELD xcde205 name="construct.b.page2.xcde205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde205
            
            #add-point:AFTER FIELD xcde205 name="construct.a.page2.xcde205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcde205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde205
            #add-point:ON ACTION controlp INFIELD xcde205 name="construct.c.page2.xcde205"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde206
            #add-point:BEFORE FIELD xcde206 name="construct.b.page2.xcde206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde206
            
            #add-point:AFTER FIELD xcde206 name="construct.a.page2.xcde206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcde206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde206
            #add-point:ON ACTION controlp INFIELD xcde206 name="construct.c.page2.xcde206"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde307
            #add-point:BEFORE FIELD xcde307 name="construct.b.page2.xcde307"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde307
            
            #add-point:AFTER FIELD xcde307 name="construct.a.page2.xcde307"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcde307
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde307
            #add-point:ON ACTION controlp INFIELD xcde307 name="construct.c.page2.xcde307"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde308
            #add-point:BEFORE FIELD xcde308 name="construct.b.page2.xcde308"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde308
            
            #add-point:AFTER FIELD xcde308 name="construct.a.page2.xcde308"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcde308
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde308
            #add-point:ON ACTION controlp INFIELD xcde308 name="construct.c.page2.xcde308"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde207
            #add-point:BEFORE FIELD xcde207 name="construct.b.page3.xcde207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde207
            
            #add-point:AFTER FIELD xcde207 name="construct.a.page3.xcde207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xcde207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde207
            #add-point:ON ACTION controlp INFIELD xcde207 name="construct.c.page3.xcde207"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde208
            #add-point:BEFORE FIELD xcde208 name="construct.b.page3.xcde208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde208
            
            #add-point:AFTER FIELD xcde208 name="construct.a.page3.xcde208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xcde208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde208
            #add-point:ON ACTION controlp INFIELD xcde208 name="construct.c.page3.xcde208"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde209
            #add-point:BEFORE FIELD xcde209 name="construct.b.page3.xcde209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde209
            
            #add-point:AFTER FIELD xcde209 name="construct.a.page3.xcde209"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xcde209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde209
            #add-point:ON ACTION controlp INFIELD xcde209 name="construct.c.page3.xcde209"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde210
            #add-point:BEFORE FIELD xcde210 name="construct.b.page3.xcde210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde210
            
            #add-point:AFTER FIELD xcde210 name="construct.a.page3.xcde210"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xcde210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde210
            #add-point:ON ACTION controlp INFIELD xcde210 name="construct.c.page3.xcde210"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "xccd_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xcde_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
               END CASE
            END FOR
         END IF
    
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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   LET g_wc2 = cl_replace_str(g_wc2,"l_","")
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq701_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_xcde_d.clear()
   CALL g_xcde2_d.clear()
   CALL g_xcde3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axcq701_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq701_browser_fill("")
      CALL axcq701_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL axcq701_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axcq701_fetch("F") 
      #顯示單身筆數
      CALL axcq701_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq701_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   IF 1=2 THEN
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
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
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
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
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xccd_m.xccdld = g_browser[g_current_idx].b_xccdld
   LET g_xccd_m.xccd001 = g_browser[g_current_idx].b_xccd001
   LET g_xccd_m.xccd002 = g_browser[g_current_idx].b_xccd002
   LET g_xccd_m.xccd003 = g_browser[g_current_idx].b_xccd003
   LET g_xccd_m.xccd004 = g_browser[g_current_idx].b_xccd004
   LET g_xccd_m.xccd005 = g_browser[g_current_idx].b_xccd005
   LET g_xccd_m.xccd006 = g_browser[g_current_idx].b_xccd006
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq701_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005, 
       g_xccd_m.xccdld,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.xccd002,g_xccd_m.xccd009, 
       g_xccd_m.xccd200,g_xccd_m.xccd001,g_xccd_m.xccd002_desc
   
   #遮罩相關處理
   LET g_xccd_m_mask_o.* =  g_xccd_m.*
   CALL axcq701_xccd_t_mask()
   LET g_xccd_m_mask_n.* =  g_xccd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq701_set_act_visible()   
   CALL axcq701_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   ELSE
      IF g_browser_cnt = 0 THEN
         RETURN
      END IF
      
      CASE p_flag
         WHEN 'F' 
            LET g_current_idx = 1
         WHEN 'L'  
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
     
               PROMPT ls_msg CLIPPED,':' FOR g_jump
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
      
      #CALL axcq701_browser_fill(p_flag)
      
      
      LET g_detail_cnt = g_header_cnt                  
      
      #單身總筆數顯示
      IF g_detail_cnt > 0 THEN
         #若單身有資料時, idx至少為1
         IF g_detail_idx <= 0 THEN
            LET g_detail_idx = 1
         END IF
         DISPLAY g_detail_idx TO FORMONLY.idx  
      ELSE
         LET g_detail_idx = 0
         DISPLAY ' ' TO FORMONLY.idx    
      END IF
      
      #瀏覽頁筆數顯示
      LET g_pagestart = g_current_idx
      DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
      DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
      
      CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
      
      #代表沒有資料
      IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
         RETURN
      END IF
      
      #超出範圍
      IF g_current_idx > g_browser.getLength() THEN
         LET g_current_idx = g_browser.getLength()
      END IF
      
      LET g_xccd_m.xccdld = g_browser[g_current_idx].b_xccdld
      LET g_xccd_m.xccd001 = g_browser[g_current_idx].b_xccd001
      LET g_xccd_m.xccd002 = g_browser[g_current_idx].b_xccd002
      LET g_xccd_m.xccd003 = g_browser[g_current_idx].b_xccd003
      LET g_xccd_m.xccd004 = g_browser[g_current_idx].b_xccd004
      LET g_xccd_m.xccd005 = g_browser[g_current_idx].b_xccd005
      LET g_xccd_m.xccd006 = g_browser[g_current_idx].b_xccd006
     
      
      #重讀DB,因TEMP有不被更新特性
      EXECUTE axcq701_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd002,g_xccd_m.xccd003, 
          g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005, 
          g_xccd_m.xccdld,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.xccd002,g_xccd_m.xccd009, 
          g_xccd_m.xccd200,g_xccd_m.xccd002_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
     
         INITIALIZE g_xccd_m.* TO NULL
         RETURN
      END IF
      
      #根據資料狀態切換action狀態
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
      CALL axcq701_set_act_visible()   
      CALL axcq701_set_act_no_visible() 
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xccd_m_t.* = g_xccd_m.*
   LET g_xccd_m_o.* = g_xccd_m.*
   
   
   #重新顯示   
   CALL axcq701_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq701_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xcde_d.clear()   
   CALL g_xcde2_d.clear()  
   CALL g_xcde3_d.clear()  
 
 
   INITIALIZE g_xccd_m.* TO NULL             #DEFAULT 設定
   
   LET g_xccdld_t = NULL
   LET g_xccd001_t = NULL
   LET g_xccd002_t = NULL
   LET g_xccd003_t = NULL
   LET g_xccd004_t = NULL
   LET g_xccd005_t = NULL
   LET g_xccd006_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xccd_m.sfaa042 = "N"
      LET g_xccd_m.xccd001 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xccd_m_t.* = g_xccd_m.*
      LET g_xccd_m_o.* = g_xccd_m.*
      
      #顯示狀態(stus)圖片
      
    
      CALL axcq701_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccd_m.* TO NULL
         INITIALIZE g_xcde_d TO NULL
         INITIALIZE g_xcde2_d TO NULL
         INITIALIZE g_xcde3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axcq701_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xcde_d.clear()
      #CALL g_xcde2_d.clear()
      #CALL g_xcde3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq701_set_act_visible()   
   CALL axcq701_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001
   LET g_xccd002_t = g_xccd_m.xccd002
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   LET g_xccd006_t = g_xccd_m.xccd006
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccdent = " ||g_enterprise|| " AND",
                      " xccdld = '", g_xccd_m.xccdld, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001, "' "
                      ," AND xccd002 = '", g_xccd_m.xccd002, "' "
                      ," AND xccd003 = '", g_xccd_m.xccd003, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005, "' "
                      ," AND xccd006 = '", g_xccd_m.xccd006, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq701_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axcq701_cl
   
   CALL axcq701_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq701_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005, 
       g_xccd_m.xccdld,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.xccd002,g_xccd_m.xccd009, 
       g_xccd_m.xccd200,g_xccd_m.xccd001,g_xccd_m.xccd002_desc
   
   
   #遮罩相關處理
   LET g_xccd_m_mask_o.* =  g_xccd_m.*
   CALL axcq701_xccd_t_mask()
   LET g_xccd_m_mask_n.* =  g_xccd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccdld, 
       g_xccd_m.xccdld_desc,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd003_desc,g_xccd_m.xccd007, 
       g_xccd_m.xccd007_desc,g_xccd_m.xccd007_desc_desc,g_xccd_m.imag014,g_xccd_m.imag014_desc,g_xccd_m.xccd002, 
       g_xccd_m.xccd002_desc,g_xccd_m.sfaa048,g_xccd_m.xccd009,g_xccd_m.xcbb006,g_xccd_m.sfaa042,g_xccd_m.xccd200, 
       g_xccd_m.xccd001
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   
   #功能已完成,通報訊息中心
   CALL axcq701_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq701_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xccd_m_t.* = g_xccd_m.*
   LET g_xccd_m_o.* = g_xccd_m.*
   
   IF g_xccd_m.xccdld IS NULL
   OR g_xccd_m.xccd001 IS NULL
   OR g_xccd_m.xccd002 IS NULL
   OR g_xccd_m.xccd003 IS NULL
   OR g_xccd_m.xccd004 IS NULL
   OR g_xccd_m.xccd005 IS NULL
   OR g_xccd_m.xccd006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001
   LET g_xccd002_t = g_xccd_m.xccd002
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   LET g_xccd006_t = g_xccd_m.xccd006
 
   CALL s_transaction_begin()
   
   OPEN axcq701_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq701_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axcq701_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq701_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005, 
       g_xccd_m.xccdld,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.xccd002,g_xccd_m.xccd009, 
       g_xccd_m.xccd200,g_xccd_m.xccd001,g_xccd_m.xccd002_desc
   
   #檢查是否允許此動作
   IF NOT axcq701_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xccd_m_mask_o.* =  g_xccd_m.*
   CALL axcq701_xccd_t_mask()
   LET g_xccd_m_mask_n.* =  g_xccd_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL axcq701_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_xccdld_t = g_xccd_m.xccdld
      LET g_xccd001_t = g_xccd_m.xccd001
      LET g_xccd002_t = g_xccd_m.xccd002
      LET g_xccd003_t = g_xccd_m.xccd003
      LET g_xccd004_t = g_xccd_m.xccd004
      LET g_xccd005_t = g_xccd_m.xccd005
      LET g_xccd006_t = g_xccd_m.xccd006
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axcq701_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xccd_m.* = g_xccd_m_t.*
            CALL axcq701_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xccd_m.xccdld != g_xccd_m_t.xccdld
      OR g_xccd_m.xccd001 != g_xccd_m_t.xccd001
      OR g_xccd_m.xccd002 != g_xccd_m_t.xccd002
      OR g_xccd_m.xccd003 != g_xccd_m_t.xccd003
      OR g_xccd_m.xccd004 != g_xccd_m_t.xccd004
      OR g_xccd_m.xccd005 != g_xccd_m_t.xccd005
      OR g_xccd_m.xccd006 != g_xccd_m_t.xccd006
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xcde_t SET xcdeld = g_xccd_m.xccdld
                                       ,xcde001 = g_xccd_m.xccd001
                                       ,xcde002 = g_xccd_m.xccd002
                                       ,xcde003 = g_xccd_m.xccd003
                                       ,xcde004 = g_xccd_m.xccd004
                                       ,xcde005 = g_xccd_m.xccd005
                                       ,xcde006 = g_xccd_m.xccd006
 
          WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m_t.xccdld
            AND xcde001 = g_xccd_m_t.xccd001
            AND xcde002 = g_xccd_m_t.xccd002
            AND xcde003 = g_xccd_m_t.xccd003
            AND xcde004 = g_xccd_m_t.xccd004
            AND xcde005 = g_xccd_m_t.xccd005
            AND xcde006 = g_xccd_m_t.xccd006
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xcde_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq701_set_act_visible()   
   CALL axcq701_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccdent = " ||g_enterprise|| " AND",
                      " xccdld = '", g_xccd_m.xccdld, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001, "' "
                      ," AND xccd002 = '", g_xccd_m.xccd002, "' "
                      ," AND xccd003 = '", g_xccd_m.xccd003, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005, "' "
                      ," AND xccd006 = '", g_xccd_m.xccd006, "' "
 
   #填到對應位置
   CALL axcq701_browser_fill("")
 
   CLOSE axcq701_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq701_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axcq701.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq701_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
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
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
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
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccdld, 
       g_xccd_m.xccdld_desc,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd003_desc,g_xccd_m.xccd007, 
       g_xccd_m.xccd007_desc,g_xccd_m.xccd007_desc_desc,g_xccd_m.imag014,g_xccd_m.imag014_desc,g_xccd_m.xccd002, 
       g_xccd_m.xccd002_desc,g_xccd_m.sfaa048,g_xccd_m.xccd009,g_xccd_m.xcbb006,g_xccd_m.sfaa042,g_xccd_m.xccd200, 
       g_xccd_m.xccd001
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xcde007,xcde008,xcde009,xcde010,xcde101,xcde102,xcde201,xcde202,xcde301, 
       xcde302,xcde303,xcde304,xcde901,xcde902,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102,xcde205, 
       xcde206,xcde307,xcde308,xcde303,xcde304,xcde901,xcde902,xcde007,xcde008,xcde009,xcde010,xcde207, 
       xcde208,xcde209,xcde210,xcde301,xcde302,xcde303,xcde304,xcde901,xcde902 FROM xcde_t WHERE xcdeent=?  
       AND xcdeld=? AND xcde001=? AND xcde002=? AND xcde003=? AND xcde004=? AND xcde005=? AND xcde006=?  
       AND xcde007=? AND xcde008=? AND xcde009=? AND xcde010=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq701_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq701_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq701_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccdld,g_xccd_m.xccd006, 
       g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.imag014,g_xccd_m.xccd002,g_xccd_m.sfaa048,g_xccd_m.xccd009, 
       g_xccd_m.xcbb006,g_xccd_m.sfaa042,g_xccd_m.xccd200,g_xccd_m.xccd001
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq701.input.head" >}
      #單頭段
      INPUT BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccdld,g_xccd_m.xccd006, 
          g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.imag014,g_xccd_m.xccd002,g_xccd_m.sfaa048,g_xccd_m.xccd009, 
          g_xccd_m.xcbb006,g_xccd_m.sfaa042,g_xccd_m.xccd200,g_xccd_m.xccd001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axcq701_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axcq701_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axcq701_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axcq701_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL axcq701_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccdcomp
            
            #add-point:AFTER FIELD xccdcomp name="input.a.xccdcomp"
            IF NOT cl_null(g_xccd_m.xccdcomp) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccd_m.xccdcomp

                  
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
            LET g_ref_fields[1] = g_xccd_m.xccdcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccd_m.xccdcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccdcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccdcomp
            #add-point:BEFORE FIELD xccdcomp name="input.b.xccdcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccdcomp
            #add-point:ON CHANGE xccdcomp name="input.g.xccdcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd004
            #add-point:BEFORE FIELD xccd004 name="input.b.xccd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd004
            
            #add-point:AFTER FIELD xccd004 name="input.a.xccd004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd004
            #add-point:ON CHANGE xccd004 name="input.g.xccd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd005
            #add-point:BEFORE FIELD xccd005 name="input.b.xccd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd005
            
            #add-point:AFTER FIELD xccd005 name="input.a.xccd005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd005
            #add-point:ON CHANGE xccd005 name="input.g.xccd005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccdld
            
            #add-point:AFTER FIELD xccdld name="input.a.xccdld"
            IF NOT cl_null(g_xccd_m.xccdld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccd_m.xccdld
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
            LET g_ref_fields[1] = g_xccd_m.xccdld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccd_m.xccdld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccdld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccdld
            #add-point:BEFORE FIELD xccdld name="input.b.xccdld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccdld
            #add-point:ON CHANGE xccdld name="input.g.xccdld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd006
            #add-point:BEFORE FIELD xccd006 name="input.b.xccd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd006
            
            #add-point:AFTER FIELD xccd006 name="input.a.xccd006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd006
            #add-point:ON CHANGE xccd006 name="input.g.xccd006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd003
            
            #add-point:AFTER FIELD xccd003 name="input.a.xccd003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccd_m.xccd003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccd_m.xccd003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccd003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd003
            #add-point:BEFORE FIELD xccd003 name="input.b.xccd003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd003
            #add-point:ON CHANGE xccd003 name="input.g.xccd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd007
            
            #add-point:AFTER FIELD xccd007 name="input.a.xccd007"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd007
            #add-point:BEFORE FIELD xccd007 name="input.b.xccd007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd007
            #add-point:ON CHANGE xccd007 name="input.g.xccd007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag014
            
            #add-point:AFTER FIELD imag014 name="input.a.imag014"
            IF NOT cl_null(g_xccd_m.imag014) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccd_m.imag014
               #160318-00025#9--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#9--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag014
            #add-point:BEFORE FIELD imag014 name="input.b.imag014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imag014
            #add-point:ON CHANGE imag014 name="input.g.imag014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd002
            
            #add-point:AFTER FIELD xccd002 name="input.a.xccd002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccd_m.xccdcomp
            LET g_ref_fields[2] = g_xccd_m.xccd002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccd_m.xccd002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccd002_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd002
            #add-point:BEFORE FIELD xccd002 name="input.b.xccd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd002
            #add-point:ON CHANGE xccd002 name="input.g.xccd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa048
            #add-point:BEFORE FIELD sfaa048 name="input.b.sfaa048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa048
            
            #add-point:AFTER FIELD sfaa048 name="input.a.sfaa048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaa048
            #add-point:ON CHANGE sfaa048 name="input.g.sfaa048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd009
            #add-point:BEFORE FIELD xccd009 name="input.b.xccd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd009
            
            #add-point:AFTER FIELD xccd009 name="input.a.xccd009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd009
            #add-point:ON CHANGE xccd009 name="input.g.xccd009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006
            #add-point:BEFORE FIELD xcbb006 name="input.b.xcbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006
            
            #add-point:AFTER FIELD xcbb006 name="input.a.xcbb006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb006
            #add-point:ON CHANGE xcbb006 name="input.g.xcbb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa042
            #add-point:BEFORE FIELD sfaa042 name="input.b.sfaa042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa042
            
            #add-point:AFTER FIELD sfaa042 name="input.a.sfaa042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaa042
            #add-point:ON CHANGE sfaa042 name="input.g.sfaa042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd200
            #add-point:BEFORE FIELD xccd200 name="input.b.xccd200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd200
            
            #add-point:AFTER FIELD xccd200 name="input.a.xccd200"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd200
            #add-point:ON CHANGE xccd200 name="input.g.xccd200"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccd001
            #add-point:BEFORE FIELD xccd001 name="input.b.xccd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccd001
            
            #add-point:AFTER FIELD xccd001 name="input.a.xccd001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccd001
            #add-point:ON CHANGE xccd001 name="input.g.xccd001"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xccdcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccdcomp
            #add-point:ON ACTION controlp INFIELD xccdcomp name="input.c.xccdcomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccd_m.xccdcomp             #給予default值
            LET g_qryparam.default2 = "" #g_xccd_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_2()                                #呼叫開窗

            LET g_xccd_m.xccdcomp = g_qryparam.return1              
            #LET g_xccd_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xccd_m.xccdcomp TO xccdcomp              #
            #DISPLAY g_xccd_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xccdcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd004
            #add-point:ON ACTION controlp INFIELD xccd004 name="input.c.xccd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd005
            #add-point:ON ACTION controlp INFIELD xccd005 name="input.c.xccd005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccdld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccdld
            #add-point:ON ACTION controlp INFIELD xccdld name="input.c.xccdld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccd_m.xccdld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xccd_m.xccdld = g_qryparam.return1              

            DISPLAY g_xccd_m.xccdld TO xccdld              #

            NEXT FIELD xccdld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd006
            #add-point:ON ACTION controlp INFIELD xccd006 name="input.c.xccd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd003
            #add-point:ON ACTION controlp INFIELD xccd003 name="input.c.xccd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd007
            #add-point:ON ACTION controlp INFIELD xccd007 name="input.c.xccd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.imag014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag014
            #add-point:ON ACTION controlp INFIELD imag014 name="input.c.imag014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccd_m.imag014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_xccd_m.imag014 = g_qryparam.return1              

            DISPLAY g_xccd_m.imag014 TO imag014              #

            NEXT FIELD imag014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xccd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd002
            #add-point:ON ACTION controlp INFIELD xccd002 name="input.c.xccd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.sfaa048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa048
            #add-point:ON ACTION controlp INFIELD sfaa048 name="input.c.sfaa048"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd009
            #add-point:ON ACTION controlp INFIELD xccd009 name="input.c.xccd009"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006
            #add-point:ON ACTION controlp INFIELD xcbb006 name="input.c.xcbb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.sfaa042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa042
            #add-point:ON ACTION controlp INFIELD sfaa042 name="input.c.sfaa042"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccd200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd200
            #add-point:ON ACTION controlp INFIELD xccd200 name="input.c.xccd200"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccd001
            #add-point:ON ACTION controlp INFIELD xccd001 name="input.c.xccd001"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004, 
                g_xccd_m.xccd005,g_xccd_m.xccd006
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO xccd_t (xccdent,xccdcomp,xccd004,xccd005,xccdld,xccd006,xccd003,xccd007,xccd002, 
                   xccd009,xccd200,xccd001)
               VALUES (g_enterprise,g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccdld, 
                   g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.xccd002,g_xccd_m.xccd009, 
                   g_xccd_m.xccd200,g_xccd_m.xccd001) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xccd_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq701_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axcq701_b_fill()
                  CALL axcq701_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axcq701_xccd_t_mask_restore('restore_mask_o')
               
               UPDATE xccd_t SET (xccdcomp,xccd004,xccd005,xccdld,xccd006,xccd003,xccd007,xccd002,xccd009, 
                   xccd200,xccd001) = (g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccdld, 
                   g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.xccd002,g_xccd_m.xccd009, 
                   g_xccd_m.xccd200,g_xccd_m.xccd001)
                WHERE xccdent = g_enterprise AND xccdld = g_xccdld_t
                  AND xccd001 = g_xccd001_t
                  AND xccd002 = g_xccd002_t
                  AND xccd003 = g_xccd003_t
                  AND xccd004 = g_xccd004_t
                  AND xccd005 = g_xccd005_t
                  AND xccd006 = g_xccd006_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xccd_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axcq701_xccd_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xccd_m_t)
               LET g_log2 = util.JSON.stringify(g_xccd_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xccdld_t = g_xccd_m.xccdld
            LET g_xccd001_t = g_xccd_m.xccd001
            LET g_xccd002_t = g_xccd_m.xccd002
            LET g_xccd003_t = g_xccd_m.xccd003
            LET g_xccd004_t = g_xccd_m.xccd004
            LET g_xccd005_t = g_xccd_m.xccd005
            LET g_xccd006_t = g_xccd_m.xccd006
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axcq701.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq701_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xcde_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axcq701_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axcq701_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axcq701_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xcde_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcde_d[l_ac].xcde007 IS NOT NULL
               AND g_xcde_d[l_ac].xcde008 IS NOT NULL
               AND g_xcde_d[l_ac].xcde009 IS NOT NULL
               AND g_xcde_d[l_ac].xcde010 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcde_d_t.* = g_xcde_d[l_ac].*  #BACKUP
               LET g_xcde_d_o.* = g_xcde_d[l_ac].*  #BACKUP
               CALL axcq701_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axcq701_set_no_entry_b(l_cmd)
               IF NOT axcq701_lock_b("xcde_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq701_bcl INTO g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009, 
                      g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201, 
                      g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303, 
                      g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde007, 
                      g_xcde2_d[l_ac].xcde008,g_xcde2_d[l_ac].xcde009,g_xcde2_d[l_ac].xcde010,g_xcde2_d[l_ac].xcde101, 
                      g_xcde2_d[l_ac].xcde102,g_xcde2_d[l_ac].xcde205,g_xcde2_d[l_ac].xcde206,g_xcde2_d[l_ac].xcde307, 
                      g_xcde2_d[l_ac].xcde308,g_xcde2_d[l_ac].xcde303,g_xcde2_d[l_ac].xcde304,g_xcde2_d[l_ac].xcde901, 
                      g_xcde2_d[l_ac].xcde902,g_xcde3_d[l_ac].xcde007,g_xcde3_d[l_ac].xcde008,g_xcde3_d[l_ac].xcde009, 
                      g_xcde3_d[l_ac].xcde010,g_xcde3_d[l_ac].xcde207,g_xcde3_d[l_ac].xcde208,g_xcde3_d[l_ac].xcde209, 
                      g_xcde3_d[l_ac].xcde210,g_xcde3_d[l_ac].xcde301,g_xcde3_d[l_ac].xcde302,g_xcde3_d[l_ac].xcde303, 
                      g_xcde3_d[l_ac].xcde304,g_xcde3_d[l_ac].xcde901,g_xcde3_d[l_ac].xcde902
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xcde_d_t.xcde007,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcde_d_mask_o[l_ac].* =  g_xcde_d[l_ac].*
                  CALL axcq701_xcde_t_mask()
                  LET g_xcde_d_mask_n[l_ac].* =  g_xcde_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axcq701_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcde_d[l_ac].* TO NULL 
            INITIALIZE g_xcde_d_t.* TO NULL 
            INITIALIZE g_xcde_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xcde_d_t.* = g_xcde_d[l_ac].*     #新輸入資料
            LET g_xcde_d_o.* = g_xcde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq701_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axcq701_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcde_d[li_reproduce_target].* = g_xcde_d[li_reproduce].*
               LET g_xcde2_d[li_reproduce_target].* = g_xcde2_d[li_reproduce].*
               LET g_xcde3_d[li_reproduce_target].* = g_xcde3_d[li_reproduce].*
 
               LET g_xcde_d[li_reproduce_target].xcde007 = NULL
               LET g_xcde_d[li_reproduce_target].xcde008 = NULL
               LET g_xcde_d[li_reproduce_target].xcde009 = NULL
               LET g_xcde_d[li_reproduce_target].xcde010 = NULL
 
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xcde_t 
             WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld
               AND xcde001 = g_xccd_m.xccd001
               AND xcde002 = g_xccd_m.xccd002
               AND xcde003 = g_xccd_m.xccd003
               AND xcde004 = g_xccd_m.xccd004
               AND xcde005 = g_xccd_m.xccd005
               AND xcde006 = g_xccd_m.xccd006
 
               AND xcde007 = g_xcde_d[l_ac].xcde007
               AND xcde008 = g_xcde_d[l_ac].xcde008
               AND xcde009 = g_xcde_d[l_ac].xcde009
               AND xcde010 = g_xcde_d[l_ac].xcde010
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccd_m.xccdld
               LET gs_keys[2] = g_xccd_m.xccd001
               LET gs_keys[3] = g_xccd_m.xccd002
               LET gs_keys[4] = g_xccd_m.xccd003
               LET gs_keys[5] = g_xccd_m.xccd004
               LET gs_keys[6] = g_xccd_m.xccd005
               LET gs_keys[7] = g_xccd_m.xccd006
               LET gs_keys[8] = g_xcde_d[g_detail_idx].xcde007
               LET gs_keys[9] = g_xcde_d[g_detail_idx].xcde008
               LET gs_keys[10] = g_xcde_d[g_detail_idx].xcde009
               LET gs_keys[11] = g_xcde_d[g_detail_idx].xcde010
               CALL axcq701_insert_b('xcde_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xcde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axcq701_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xccd_m.xccdld
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd001
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd002
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd003
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd004
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd005
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd006
 
               LET gs_keys[gs_keys.getLength()+1] = g_xcde_d_t.xcde007
               LET gs_keys[gs_keys.getLength()+1] = g_xcde_d_t.xcde008
               LET gs_keys[gs_keys.getLength()+1] = g_xcde_d_t.xcde009
               LET gs_keys[gs_keys.getLength()+1] = g_xcde_d_t.xcde010
 
            
               #刪除同層單身
               IF NOT axcq701_delete_b('xcde_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axcq701_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axcq701_key_delete_b(gs_keys,'xcde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axcq701_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axcq701_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xcde_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xcde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde007
            
            #add-point:AFTER FIELD xcde007 name="input.a.page1.xcde007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde007 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde008 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde009 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde_d[g_detail_idx].xcde007 != g_xcde_d_t.xcde007 OR g_xcde_d[g_detail_idx].xcde008 != g_xcde_d_t.xcde008 OR g_xcde_d[g_detail_idx].xcde009 != g_xcde_d_t.xcde009 OR g_xcde_d[g_detail_idx].xcde010 != g_xcde_d_t.xcde010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcde_t WHERE "||"xcdeent = '" ||g_enterprise|| "' AND "||"xcdeld = '"||g_xccd_m.xccdld ||"' AND "|| "xcde001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcde002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcde003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcde004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcde005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcde006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcde007 = '"||g_xcde_d[g_detail_idx].xcde007 ||"' AND "|| "xcde008 = '"||g_xcde_d[g_detail_idx].xcde008 ||"' AND "|| "xcde009 = '"||g_xcde_d[g_detail_idx].xcde009 ||"' AND "|| "xcde010 = '"||g_xcde_d[g_detail_idx].xcde010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcde_d[l_ac].xcde007
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcde_d[l_ac].xcde007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcde_d[l_ac].xcde007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde007
            #add-point:BEFORE FIELD xcde007 name="input.b.page1.xcde007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde007
            #add-point:ON CHANGE xcde007 name="input.g.page1.xcde007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde008
            #add-point:BEFORE FIELD xcde008 name="input.b.page1.xcde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde008
            
            #add-point:AFTER FIELD xcde008 name="input.a.page1.xcde008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde007 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde008 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde009 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde_d[g_detail_idx].xcde007 != g_xcde_d_t.xcde007 OR g_xcde_d[g_detail_idx].xcde008 != g_xcde_d_t.xcde008 OR g_xcde_d[g_detail_idx].xcde009 != g_xcde_d_t.xcde009 OR g_xcde_d[g_detail_idx].xcde010 != g_xcde_d_t.xcde010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcde_t WHERE "||"xcdeent = '" ||g_enterprise|| "' AND "||"xcdeld = '"||g_xccd_m.xccdld ||"' AND "|| "xcde001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcde002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcde003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcde004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcde005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcde006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcde007 = '"||g_xcde_d[g_detail_idx].xcde007 ||"' AND "|| "xcde008 = '"||g_xcde_d[g_detail_idx].xcde008 ||"' AND "|| "xcde009 = '"||g_xcde_d[g_detail_idx].xcde009 ||"' AND "|| "xcde010 = '"||g_xcde_d[g_detail_idx].xcde010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde008
            #add-point:ON CHANGE xcde008 name="input.g.page1.xcde008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde009
            #add-point:BEFORE FIELD xcde009 name="input.b.page1.xcde009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde009
            
            #add-point:AFTER FIELD xcde009 name="input.a.page1.xcde009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde007 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde008 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde009 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde_d[g_detail_idx].xcde007 != g_xcde_d_t.xcde007 OR g_xcde_d[g_detail_idx].xcde008 != g_xcde_d_t.xcde008 OR g_xcde_d[g_detail_idx].xcde009 != g_xcde_d_t.xcde009 OR g_xcde_d[g_detail_idx].xcde010 != g_xcde_d_t.xcde010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcde_t WHERE "||"xcdeent = '" ||g_enterprise|| "' AND "||"xcdeld = '"||g_xccd_m.xccdld ||"' AND "|| "xcde001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcde002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcde003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcde004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcde005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcde006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcde007 = '"||g_xcde_d[g_detail_idx].xcde007 ||"' AND "|| "xcde008 = '"||g_xcde_d[g_detail_idx].xcde008 ||"' AND "|| "xcde009 = '"||g_xcde_d[g_detail_idx].xcde009 ||"' AND "|| "xcde010 = '"||g_xcde_d[g_detail_idx].xcde010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde009
            #add-point:ON CHANGE xcde009 name="input.g.page1.xcde009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcau003
            #add-point:BEFORE FIELD xcau003 name="input.b.page1.xcau003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcau003
            
            #add-point:AFTER FIELD xcau003 name="input.a.page1.xcau003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcau003
            #add-point:ON CHANGE xcau003 name="input.g.page1.xcau003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde010
            
            #add-point:AFTER FIELD xcde010 name="input.a.page1.xcde010"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde007 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde008 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde009 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde_d[g_detail_idx].xcde007 != g_xcde_d_t.xcde007 OR g_xcde_d[g_detail_idx].xcde008 != g_xcde_d_t.xcde008 OR g_xcde_d[g_detail_idx].xcde009 != g_xcde_d_t.xcde009 OR g_xcde_d[g_detail_idx].xcde010 != g_xcde_d_t.xcde010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcde_t WHERE "||"xcdeent = '" ||g_enterprise|| "' AND "||"xcdeld = '"||g_xccd_m.xccdld ||"' AND "|| "xcde001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcde002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcde003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcde004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcde005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcde006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcde007 = '"||g_xcde_d[g_detail_idx].xcde007 ||"' AND "|| "xcde008 = '"||g_xcde_d[g_detail_idx].xcde008 ||"' AND "|| "xcde009 = '"||g_xcde_d[g_detail_idx].xcde009 ||"' AND "|| "xcde010 = '"||g_xcde_d[g_detail_idx].xcde010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcde_d[l_ac].xcde010
            CALL ap_ref_array2(g_ref_fields,"SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=? AND xcaul002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcde_d[l_ac].xcde010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcde_d[l_ac].xcde010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde010
            #add-point:BEFORE FIELD xcde010 name="input.b.page1.xcde010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde010
            #add-point:ON CHANGE xcde010 name="input.g.page1.xcde010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde101
            #add-point:BEFORE FIELD xcde101 name="input.b.page1.xcde101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde101
            
            #add-point:AFTER FIELD xcde101 name="input.a.page1.xcde101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde101
            #add-point:ON CHANGE xcde101 name="input.g.page1.xcde101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde102
            #add-point:BEFORE FIELD xcde102 name="input.b.page1.xcde102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde102
            
            #add-point:AFTER FIELD xcde102 name="input.a.page1.xcde102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde102
            #add-point:ON CHANGE xcde102 name="input.g.page1.xcde102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde201
            #add-point:BEFORE FIELD xcde201 name="input.b.page1.xcde201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde201
            
            #add-point:AFTER FIELD xcde201 name="input.a.page1.xcde201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde201
            #add-point:ON CHANGE xcde201 name="input.g.page1.xcde201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde202
            #add-point:BEFORE FIELD xcde202 name="input.b.page1.xcde202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde202
            
            #add-point:AFTER FIELD xcde202 name="input.a.page1.xcde202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde202
            #add-point:ON CHANGE xcde202 name="input.g.page1.xcde202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde301
            #add-point:BEFORE FIELD xcde301 name="input.b.page1.xcde301"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde301
            
            #add-point:AFTER FIELD xcde301 name="input.a.page1.xcde301"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde301
            #add-point:ON CHANGE xcde301 name="input.g.page1.xcde301"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde302
            #add-point:BEFORE FIELD xcde302 name="input.b.page1.xcde302"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde302
            
            #add-point:AFTER FIELD xcde302 name="input.a.page1.xcde302"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde302
            #add-point:ON CHANGE xcde302 name="input.g.page1.xcde302"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde303
            #add-point:BEFORE FIELD xcde303 name="input.b.page1.xcde303"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde303
            
            #add-point:AFTER FIELD xcde303 name="input.a.page1.xcde303"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde303
            #add-point:ON CHANGE xcde303 name="input.g.page1.xcde303"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde304
            #add-point:BEFORE FIELD xcde304 name="input.b.page1.xcde304"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde304
            
            #add-point:AFTER FIELD xcde304 name="input.a.page1.xcde304"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde304
            #add-point:ON CHANGE xcde304 name="input.g.page1.xcde304"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde901
            #add-point:BEFORE FIELD xcde901 name="input.b.page1.xcde901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde901
            
            #add-point:AFTER FIELD xcde901 name="input.a.page1.xcde901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde901
            #add-point:ON CHANGE xcde901 name="input.g.page1.xcde901"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde902
            #add-point:BEFORE FIELD xcde902 name="input.b.page1.xcde902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde902
            
            #add-point:AFTER FIELD xcde902 name="input.a.page1.xcde902"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde902
            #add-point:ON CHANGE xcde902 name="input.g.page1.xcde902"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcde007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde007
            #add-point:ON ACTION controlp INFIELD xcde007 name="input.c.page1.xcde007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde008
            #add-point:ON ACTION controlp INFIELD xcde008 name="input.c.page1.xcde008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde009
            #add-point:ON ACTION controlp INFIELD xcde009 name="input.c.page1.xcde009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcau003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcau003
            #add-point:ON ACTION controlp INFIELD xcau003 name="input.c.page1.xcau003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde010
            #add-point:ON ACTION controlp INFIELD xcde010 name="input.c.page1.xcde010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde101
            #add-point:ON ACTION controlp INFIELD xcde101 name="input.c.page1.xcde101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde102
            #add-point:ON ACTION controlp INFIELD xcde102 name="input.c.page1.xcde102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde201
            #add-point:ON ACTION controlp INFIELD xcde201 name="input.c.page1.xcde201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde202
            #add-point:ON ACTION controlp INFIELD xcde202 name="input.c.page1.xcde202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde301
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde301
            #add-point:ON ACTION controlp INFIELD xcde301 name="input.c.page1.xcde301"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde302
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde302
            #add-point:ON ACTION controlp INFIELD xcde302 name="input.c.page1.xcde302"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde303
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde303
            #add-point:ON ACTION controlp INFIELD xcde303 name="input.c.page1.xcde303"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde304
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde304
            #add-point:ON ACTION controlp INFIELD xcde304 name="input.c.page1.xcde304"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde901
            #add-point:ON ACTION controlp INFIELD xcde901 name="input.c.page1.xcde901"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcde902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde902
            #add-point:ON ACTION controlp INFIELD xcde902 name="input.c.page1.xcde902"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcde_d[l_ac].* = g_xcde_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axcq701_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcde_d[l_ac].xcde007 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xcde_d[l_ac].* = g_xcde_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axcq701_xcde_t_mask_restore('restore_mask_o')
      
               UPDATE xcde_t SET (xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,xcde007,xcde008, 
                   xcde009,xcde010,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde901, 
                   xcde902,xcde205,xcde206,xcde307,xcde308,xcde207,xcde208,xcde209,xcde210) = (g_xccd_m.xccdld, 
                   g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005, 
                   g_xccd_m.xccd006,g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009, 
                   g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201, 
                   g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303, 
                   g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde205, 
                   g_xcde2_d[l_ac].xcde206,g_xcde2_d[l_ac].xcde307,g_xcde2_d[l_ac].xcde308,g_xcde3_d[l_ac].xcde207, 
                   g_xcde3_d[l_ac].xcde208,g_xcde3_d[l_ac].xcde209,g_xcde3_d[l_ac].xcde210)
                WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld 
                  AND xcde001 = g_xccd_m.xccd001 
                  AND xcde002 = g_xccd_m.xccd002 
                  AND xcde003 = g_xccd_m.xccd003 
                  AND xcde004 = g_xccd_m.xccd004 
                  AND xcde005 = g_xccd_m.xccd005 
                  AND xcde006 = g_xccd_m.xccd006 
 
                  AND xcde007 = g_xcde_d_t.xcde007 #項次   
                  AND xcde008 = g_xcde_d_t.xcde008  
                  AND xcde009 = g_xcde_d_t.xcde009  
                  AND xcde010 = g_xcde_d_t.xcde010  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xcde_d[l_ac].* = g_xcde_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xcde_d[l_ac].* = g_xcde_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccd_m.xccdld
               LET gs_keys_bak[1] = g_xccdld_t
               LET gs_keys[2] = g_xccd_m.xccd001
               LET gs_keys_bak[2] = g_xccd001_t
               LET gs_keys[3] = g_xccd_m.xccd002
               LET gs_keys_bak[3] = g_xccd002_t
               LET gs_keys[4] = g_xccd_m.xccd003
               LET gs_keys_bak[4] = g_xccd003_t
               LET gs_keys[5] = g_xccd_m.xccd004
               LET gs_keys_bak[5] = g_xccd004_t
               LET gs_keys[6] = g_xccd_m.xccd005
               LET gs_keys_bak[6] = g_xccd005_t
               LET gs_keys[7] = g_xccd_m.xccd006
               LET gs_keys_bak[7] = g_xccd006_t
               LET gs_keys[8] = g_xcde_d[g_detail_idx].xcde007
               LET gs_keys_bak[8] = g_xcde_d_t.xcde007
               LET gs_keys[9] = g_xcde_d[g_detail_idx].xcde008
               LET gs_keys_bak[9] = g_xcde_d_t.xcde008
               LET gs_keys[10] = g_xcde_d[g_detail_idx].xcde009
               LET gs_keys_bak[10] = g_xcde_d_t.xcde009
               LET gs_keys[11] = g_xcde_d[g_detail_idx].xcde010
               LET gs_keys_bak[11] = g_xcde_d_t.xcde010
               CALL axcq701_update_b('xcde_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axcq701_xcde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xcde_d[g_detail_idx].xcde007 = g_xcde_d_t.xcde007 
                  AND g_xcde_d[g_detail_idx].xcde008 = g_xcde_d_t.xcde008 
                  AND g_xcde_d[g_detail_idx].xcde009 = g_xcde_d_t.xcde009 
                  AND g_xcde_d[g_detail_idx].xcde010 = g_xcde_d_t.xcde010 
 
                  ) THEN
                  LET gs_keys[01] = g_xccd_m.xccdld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd005
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd006
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde_d_t.xcde007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde_d_t.xcde008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde_d_t.xcde009
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde_d_t.xcde010
 
                  CALL axcq701_key_update_b(gs_keys,'xcde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde_d_t)
               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axcq701_unlock_b("xcde_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcde_d[li_reproduce_target].* = g_xcde_d[li_reproduce].*
               LET g_xcde2_d[li_reproduce_target].* = g_xcde2_d[li_reproduce].*
               LET g_xcde3_d[li_reproduce_target].* = g_xcde3_d[li_reproduce].*
 
               LET g_xcde_d[li_reproduce_target].xcde007 = NULL
               LET g_xcde_d[li_reproduce_target].xcde008 = NULL
               LET g_xcde_d[li_reproduce_target].xcde009 = NULL
               LET g_xcde_d[li_reproduce_target].xcde010 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcde_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcde_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xcde2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL axcq701_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xcde2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcde2_d[l_ac].* TO NULL 
            INITIALIZE g_xcde2_d_t.* TO NULL 
            INITIALIZE g_xcde2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_xcde2_d_t.* = g_xcde2_d[l_ac].*     #新輸入資料
            LET g_xcde2_d_o.* = g_xcde2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq701_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL axcq701_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcde_d[li_reproduce_target].* = g_xcde_d[li_reproduce].*
               LET g_xcde2_d[li_reproduce_target].* = g_xcde2_d[li_reproduce].*
               LET g_xcde3_d[li_reproduce_target].* = g_xcde3_d[li_reproduce].*
 
               LET g_xcde2_d[li_reproduce_target].xcde007 = NULL
               LET g_xcde2_d[li_reproduce_target].xcde008 = NULL
               LET g_xcde2_d[li_reproduce_target].xcde009 = NULL
               LET g_xcde2_d[li_reproduce_target].xcde010 = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axcq701_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axcq701_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axcq701_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xcde2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcde2_d[l_ac].xcde007 IS NOT NULL
               AND g_xcde2_d[l_ac].xcde008 IS NOT NULL
               AND g_xcde2_d[l_ac].xcde009 IS NOT NULL
               AND g_xcde2_d[l_ac].xcde010 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xcde2_d_t.* = g_xcde2_d[l_ac].*  #BACKUP
               LET g_xcde2_d_o.* = g_xcde2_d[l_ac].*  #BACKUP
               CALL axcq701_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL axcq701_set_no_entry_b(l_cmd)
               IF NOT axcq701_lock_b("xcde_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq701_bcl INTO g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009, 
                      g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201, 
                      g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303, 
                      g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde007, 
                      g_xcde2_d[l_ac].xcde008,g_xcde2_d[l_ac].xcde009,g_xcde2_d[l_ac].xcde010,g_xcde2_d[l_ac].xcde101, 
                      g_xcde2_d[l_ac].xcde102,g_xcde2_d[l_ac].xcde205,g_xcde2_d[l_ac].xcde206,g_xcde2_d[l_ac].xcde307, 
                      g_xcde2_d[l_ac].xcde308,g_xcde2_d[l_ac].xcde303,g_xcde2_d[l_ac].xcde304,g_xcde2_d[l_ac].xcde901, 
                      g_xcde2_d[l_ac].xcde902,g_xcde3_d[l_ac].xcde007,g_xcde3_d[l_ac].xcde008,g_xcde3_d[l_ac].xcde009, 
                      g_xcde3_d[l_ac].xcde010,g_xcde3_d[l_ac].xcde207,g_xcde3_d[l_ac].xcde208,g_xcde3_d[l_ac].xcde209, 
                      g_xcde3_d[l_ac].xcde210,g_xcde3_d[l_ac].xcde301,g_xcde3_d[l_ac].xcde302,g_xcde3_d[l_ac].xcde303, 
                      g_xcde3_d[l_ac].xcde304,g_xcde3_d[l_ac].xcde901,g_xcde3_d[l_ac].xcde902
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcde2_d_mask_o[l_ac].* =  g_xcde2_d[l_ac].*
                  CALL axcq701_xcde_t_mask()
                  LET g_xcde2_d_mask_n[l_ac].* =  g_xcde2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axcq701_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xccd_m.xccdld
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd001
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd002
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd003
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd004
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd005
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd006
               LET gs_keys[gs_keys.getLength()+1] = g_xcde2_d_t.xcde007
               LET gs_keys[gs_keys.getLength()+1] = g_xcde2_d_t.xcde008
               LET gs_keys[gs_keys.getLength()+1] = g_xcde2_d_t.xcde009
               LET gs_keys[gs_keys.getLength()+1] = g_xcde2_d_t.xcde010
            
               #刪除同層單身
               IF NOT axcq701_delete_b('xcde_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axcq701_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axcq701_key_delete_b(gs_keys,'xcde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axcq701_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axcq701_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xcde_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xcde2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xcde_t 
             WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld
               AND xcde001 = g_xccd_m.xccd001
               AND xcde002 = g_xccd_m.xccd002
               AND xcde003 = g_xccd_m.xccd003
               AND xcde004 = g_xccd_m.xccd004
               AND xcde005 = g_xccd_m.xccd005
               AND xcde006 = g_xccd_m.xccd006
               AND xcde007 = g_xcde2_d[l_ac].xcde007
               AND xcde008 = g_xcde2_d[l_ac].xcde008
               AND xcde009 = g_xcde2_d[l_ac].xcde009
               AND xcde010 = g_xcde2_d[l_ac].xcde010
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccd_m.xccdld
               LET gs_keys[2] = g_xccd_m.xccd001
               LET gs_keys[3] = g_xccd_m.xccd002
               LET gs_keys[4] = g_xccd_m.xccd003
               LET gs_keys[5] = g_xccd_m.xccd004
               LET gs_keys[6] = g_xccd_m.xccd005
               LET gs_keys[7] = g_xccd_m.xccd006
               LET gs_keys[8] = g_xcde2_d[g_detail_idx].xcde007
               LET gs_keys[9] = g_xcde2_d[g_detail_idx].xcde008
               LET gs_keys[10] = g_xcde2_d[g_detail_idx].xcde009
               LET gs_keys[11] = g_xcde2_d[g_detail_idx].xcde010
               CALL axcq701_insert_b('xcde_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xcde_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axcq701_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcde2_d[l_ac].* = g_xcde2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axcq701_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xcde2_d[l_ac].* = g_xcde2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axcq701_xcde_t_mask_restore('restore_mask_o')
                              
               UPDATE xcde_t SET (xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,xcde007,xcde008, 
                   xcde009,xcde010,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde901, 
                   xcde902,xcde205,xcde206,xcde307,xcde308,xcde207,xcde208,xcde209,xcde210) = (g_xccd_m.xccdld, 
                   g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005, 
                   g_xccd_m.xccd006,g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009, 
                   g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201, 
                   g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303, 
                   g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde205, 
                   g_xcde2_d[l_ac].xcde206,g_xcde2_d[l_ac].xcde307,g_xcde2_d[l_ac].xcde308,g_xcde3_d[l_ac].xcde207, 
                   g_xcde3_d[l_ac].xcde208,g_xcde3_d[l_ac].xcde209,g_xcde3_d[l_ac].xcde210) #自訂欄位頁簽 
 
                WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld
                  AND xcde001 = g_xccd_m.xccd001
                  AND xcde002 = g_xccd_m.xccd002
                  AND xcde003 = g_xccd_m.xccd003
                  AND xcde004 = g_xccd_m.xccd004
                  AND xcde005 = g_xccd_m.xccd005
                  AND xcde006 = g_xccd_m.xccd006
                  AND xcde007 = g_xcde2_d_t.xcde007 #項次 
                  AND xcde008 = g_xcde2_d_t.xcde008
                  AND xcde009 = g_xcde2_d_t.xcde009
                  AND xcde010 = g_xcde2_d_t.xcde010
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xcde2_d[l_ac].* = g_xcde2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xcde2_d[l_ac].* = g_xcde2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccd_m.xccdld
               LET gs_keys_bak[1] = g_xccdld_t
               LET gs_keys[2] = g_xccd_m.xccd001
               LET gs_keys_bak[2] = g_xccd001_t
               LET gs_keys[3] = g_xccd_m.xccd002
               LET gs_keys_bak[3] = g_xccd002_t
               LET gs_keys[4] = g_xccd_m.xccd003
               LET gs_keys_bak[4] = g_xccd003_t
               LET gs_keys[5] = g_xccd_m.xccd004
               LET gs_keys_bak[5] = g_xccd004_t
               LET gs_keys[6] = g_xccd_m.xccd005
               LET gs_keys_bak[6] = g_xccd005_t
               LET gs_keys[7] = g_xccd_m.xccd006
               LET gs_keys_bak[7] = g_xccd006_t
               LET gs_keys[8] = g_xcde2_d[g_detail_idx].xcde007
               LET gs_keys_bak[8] = g_xcde2_d_t.xcde007
               LET gs_keys[9] = g_xcde2_d[g_detail_idx].xcde008
               LET gs_keys_bak[9] = g_xcde2_d_t.xcde008
               LET gs_keys[10] = g_xcde2_d[g_detail_idx].xcde009
               LET gs_keys_bak[10] = g_xcde2_d_t.xcde009
               LET gs_keys[11] = g_xcde2_d[g_detail_idx].xcde010
               LET gs_keys_bak[11] = g_xcde2_d_t.xcde010
               CALL axcq701_update_b('xcde_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq701_xcde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xcde2_d[g_detail_idx].xcde007 = g_xcde2_d_t.xcde007 
                  AND g_xcde2_d[g_detail_idx].xcde008 = g_xcde2_d_t.xcde008 
                  AND g_xcde2_d[g_detail_idx].xcde009 = g_xcde2_d_t.xcde009 
                  AND g_xcde2_d[g_detail_idx].xcde010 = g_xcde2_d_t.xcde010 
                  ) THEN
                  LET gs_keys[01] = g_xccd_m.xccdld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd005
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde2_d_t.xcde007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde2_d_t.xcde008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde2_d_t.xcde009
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde2_d_t.xcde010
                  CALL axcq701_key_update_b(gs_keys,'xcde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde2_d_t)
               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde205
            #add-point:BEFORE FIELD xcde205 name="input.b.page2.xcde205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde205
            
            #add-point:AFTER FIELD xcde205 name="input.a.page2.xcde205"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde205
            #add-point:ON CHANGE xcde205 name="input.g.page2.xcde205"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde206
            #add-point:BEFORE FIELD xcde206 name="input.b.page2.xcde206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde206
            
            #add-point:AFTER FIELD xcde206 name="input.a.page2.xcde206"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde206
            #add-point:ON CHANGE xcde206 name="input.g.page2.xcde206"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde307
            #add-point:BEFORE FIELD xcde307 name="input.b.page2.xcde307"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde307
            
            #add-point:AFTER FIELD xcde307 name="input.a.page2.xcde307"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde307
            #add-point:ON CHANGE xcde307 name="input.g.page2.xcde307"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde308
            #add-point:BEFORE FIELD xcde308 name="input.b.page2.xcde308"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde308
            
            #add-point:AFTER FIELD xcde308 name="input.a.page2.xcde308"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde308
            #add-point:ON CHANGE xcde308 name="input.g.page2.xcde308"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xcde205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde205
            #add-point:ON ACTION controlp INFIELD xcde205 name="input.c.page2.xcde205"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcde206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde206
            #add-point:ON ACTION controlp INFIELD xcde206 name="input.c.page2.xcde206"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcde307
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde307
            #add-point:ON ACTION controlp INFIELD xcde307 name="input.c.page2.xcde307"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcde308
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde308
            #add-point:ON ACTION controlp INFIELD xcde308 name="input.c.page2.xcde308"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcde2_d[l_ac].* = g_xcde2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axcq701_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axcq701_unlock_b("xcde_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcde_d[li_reproduce_target].* = g_xcde_d[li_reproduce].*
               LET g_xcde2_d[li_reproduce_target].* = g_xcde2_d[li_reproduce].*
               LET g_xcde3_d[li_reproduce_target].* = g_xcde3_d[li_reproduce].*
 
               LET g_xcde2_d[li_reproduce_target].xcde007 = NULL
               LET g_xcde2_d[li_reproduce_target].xcde008 = NULL
               LET g_xcde2_d[li_reproduce_target].xcde009 = NULL
               LET g_xcde2_d[li_reproduce_target].xcde010 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcde2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcde2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xcde3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            
            CALL axcq701_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xcde3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcde3_d[l_ac].* TO NULL 
            INITIALIZE g_xcde3_d_t.* TO NULL 
            INITIALIZE g_xcde3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_xcde3_d_t.* = g_xcde3_d[l_ac].*     #新輸入資料
            LET g_xcde3_d_o.* = g_xcde3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq701_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL axcq701_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcde_d[li_reproduce_target].* = g_xcde_d[li_reproduce].*
               LET g_xcde2_d[li_reproduce_target].* = g_xcde2_d[li_reproduce].*
               LET g_xcde3_d[li_reproduce_target].* = g_xcde3_d[li_reproduce].*
 
               LET g_xcde3_d[li_reproduce_target].xcde007 = NULL
               LET g_xcde3_d[li_reproduce_target].xcde008 = NULL
               LET g_xcde3_d[li_reproduce_target].xcde009 = NULL
               LET g_xcde3_d[li_reproduce_target].xcde010 = NULL
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axcq701_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axcq701_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axcq701_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xcde3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcde3_d[l_ac].xcde007 IS NOT NULL
               AND g_xcde3_d[l_ac].xcde008 IS NOT NULL
               AND g_xcde3_d[l_ac].xcde009 IS NOT NULL
               AND g_xcde3_d[l_ac].xcde010 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xcde3_d_t.* = g_xcde3_d[l_ac].*  #BACKUP
               LET g_xcde3_d_o.* = g_xcde3_d[l_ac].*  #BACKUP
               CALL axcq701_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL axcq701_set_no_entry_b(l_cmd)
               IF NOT axcq701_lock_b("xcde_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq701_bcl INTO g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009, 
                      g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201, 
                      g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303, 
                      g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde007, 
                      g_xcde2_d[l_ac].xcde008,g_xcde2_d[l_ac].xcde009,g_xcde2_d[l_ac].xcde010,g_xcde2_d[l_ac].xcde101, 
                      g_xcde2_d[l_ac].xcde102,g_xcde2_d[l_ac].xcde205,g_xcde2_d[l_ac].xcde206,g_xcde2_d[l_ac].xcde307, 
                      g_xcde2_d[l_ac].xcde308,g_xcde2_d[l_ac].xcde303,g_xcde2_d[l_ac].xcde304,g_xcde2_d[l_ac].xcde901, 
                      g_xcde2_d[l_ac].xcde902,g_xcde3_d[l_ac].xcde007,g_xcde3_d[l_ac].xcde008,g_xcde3_d[l_ac].xcde009, 
                      g_xcde3_d[l_ac].xcde010,g_xcde3_d[l_ac].xcde207,g_xcde3_d[l_ac].xcde208,g_xcde3_d[l_ac].xcde209, 
                      g_xcde3_d[l_ac].xcde210,g_xcde3_d[l_ac].xcde301,g_xcde3_d[l_ac].xcde302,g_xcde3_d[l_ac].xcde303, 
                      g_xcde3_d[l_ac].xcde304,g_xcde3_d[l_ac].xcde901,g_xcde3_d[l_ac].xcde902
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcde3_d_mask_o[l_ac].* =  g_xcde3_d[l_ac].*
                  CALL axcq701_xcde_t_mask()
                  LET g_xcde3_d_mask_n[l_ac].* =  g_xcde3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axcq701_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
            #其他table進行lock
            
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xccd_m.xccdld
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd001
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd002
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd003
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd004
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd005
               LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd006
               LET gs_keys[gs_keys.getLength()+1] = g_xcde3_d_t.xcde007
               LET gs_keys[gs_keys.getLength()+1] = g_xcde3_d_t.xcde008
               LET gs_keys[gs_keys.getLength()+1] = g_xcde3_d_t.xcde009
               LET gs_keys[gs_keys.getLength()+1] = g_xcde3_d_t.xcde010
            
               #刪除同層單身
               IF NOT axcq701_delete_b('xcde_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axcq701_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axcq701_key_delete_b(gs_keys,'xcde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axcq701_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axcq701_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_xcde_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xcde3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xcde_t 
             WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld
               AND xcde001 = g_xccd_m.xccd001
               AND xcde002 = g_xccd_m.xccd002
               AND xcde003 = g_xccd_m.xccd003
               AND xcde004 = g_xccd_m.xccd004
               AND xcde005 = g_xccd_m.xccd005
               AND xcde006 = g_xccd_m.xccd006
               AND xcde007 = g_xcde3_d[l_ac].xcde007
               AND xcde008 = g_xcde3_d[l_ac].xcde008
               AND xcde009 = g_xcde3_d[l_ac].xcde009
               AND xcde010 = g_xcde3_d[l_ac].xcde010
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccd_m.xccdld
               LET gs_keys[2] = g_xccd_m.xccd001
               LET gs_keys[3] = g_xccd_m.xccd002
               LET gs_keys[4] = g_xccd_m.xccd003
               LET gs_keys[5] = g_xccd_m.xccd004
               LET gs_keys[6] = g_xccd_m.xccd005
               LET gs_keys[7] = g_xccd_m.xccd006
               LET gs_keys[8] = g_xcde3_d[g_detail_idx].xcde007
               LET gs_keys[9] = g_xcde3_d[g_detail_idx].xcde008
               LET gs_keys[10] = g_xcde3_d[g_detail_idx].xcde009
               LET gs_keys[11] = g_xcde3_d[g_detail_idx].xcde010
               CALL axcq701_insert_b('xcde_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xcde_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axcq701_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axcq701_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL axcq701_xcde_t_mask_restore('restore_mask_o')
                              
               UPDATE xcde_t SET (xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,xcde007,xcde008, 
                   xcde009,xcde010,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde901, 
                   xcde902,xcde205,xcde206,xcde307,xcde308,xcde207,xcde208,xcde209,xcde210) = (g_xccd_m.xccdld, 
                   g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005, 
                   g_xccd_m.xccd006,g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009, 
                   g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201, 
                   g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303, 
                   g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde205, 
                   g_xcde2_d[l_ac].xcde206,g_xcde2_d[l_ac].xcde307,g_xcde2_d[l_ac].xcde308,g_xcde3_d[l_ac].xcde207, 
                   g_xcde3_d[l_ac].xcde208,g_xcde3_d[l_ac].xcde209,g_xcde3_d[l_ac].xcde210) #自訂欄位頁簽 
 
                WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld
                  AND xcde001 = g_xccd_m.xccd001
                  AND xcde002 = g_xccd_m.xccd002
                  AND xcde003 = g_xccd_m.xccd003
                  AND xcde004 = g_xccd_m.xccd004
                  AND xcde005 = g_xccd_m.xccd005
                  AND xcde006 = g_xccd_m.xccd006
                  AND xcde007 = g_xcde3_d_t.xcde007 #項次 
                  AND xcde008 = g_xcde3_d_t.xcde008
                  AND xcde009 = g_xcde3_d_t.xcde009
                  AND xcde010 = g_xcde3_d_t.xcde010
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccd_m.xccdld
               LET gs_keys_bak[1] = g_xccdld_t
               LET gs_keys[2] = g_xccd_m.xccd001
               LET gs_keys_bak[2] = g_xccd001_t
               LET gs_keys[3] = g_xccd_m.xccd002
               LET gs_keys_bak[3] = g_xccd002_t
               LET gs_keys[4] = g_xccd_m.xccd003
               LET gs_keys_bak[4] = g_xccd003_t
               LET gs_keys[5] = g_xccd_m.xccd004
               LET gs_keys_bak[5] = g_xccd004_t
               LET gs_keys[6] = g_xccd_m.xccd005
               LET gs_keys_bak[6] = g_xccd005_t
               LET gs_keys[7] = g_xccd_m.xccd006
               LET gs_keys_bak[7] = g_xccd006_t
               LET gs_keys[8] = g_xcde3_d[g_detail_idx].xcde007
               LET gs_keys_bak[8] = g_xcde3_d_t.xcde007
               LET gs_keys[9] = g_xcde3_d[g_detail_idx].xcde008
               LET gs_keys_bak[9] = g_xcde3_d_t.xcde008
               LET gs_keys[10] = g_xcde3_d[g_detail_idx].xcde009
               LET gs_keys_bak[10] = g_xcde3_d_t.xcde009
               LET gs_keys[11] = g_xcde3_d[g_detail_idx].xcde010
               LET gs_keys_bak[11] = g_xcde3_d_t.xcde010
               CALL axcq701_update_b('xcde_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq701_xcde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xcde3_d[g_detail_idx].xcde007 = g_xcde3_d_t.xcde007 
                  AND g_xcde3_d[g_detail_idx].xcde008 = g_xcde3_d_t.xcde008 
                  AND g_xcde3_d[g_detail_idx].xcde009 = g_xcde3_d_t.xcde009 
                  AND g_xcde3_d[g_detail_idx].xcde010 = g_xcde3_d_t.xcde010 
                  ) THEN
                  LET gs_keys[01] = g_xccd_m.xccdld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd005
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde3_d_t.xcde007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde3_d_t.xcde008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde3_d_t.xcde009
                  LET gs_keys[gs_keys.getLength()+1] = g_xcde3_d_t.xcde010
                  CALL axcq701_key_update_b(gs_keys,'xcde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde3_d_t)
               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde207
            #add-point:BEFORE FIELD xcde207 name="input.b.page3.xcde207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde207
            
            #add-point:AFTER FIELD xcde207 name="input.a.page3.xcde207"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde207
            #add-point:ON CHANGE xcde207 name="input.g.page3.xcde207"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde208
            #add-point:BEFORE FIELD xcde208 name="input.b.page3.xcde208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde208
            
            #add-point:AFTER FIELD xcde208 name="input.a.page3.xcde208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde208
            #add-point:ON CHANGE xcde208 name="input.g.page3.xcde208"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde209
            #add-point:BEFORE FIELD xcde209 name="input.b.page3.xcde209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde209
            
            #add-point:AFTER FIELD xcde209 name="input.a.page3.xcde209"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde209
            #add-point:ON CHANGE xcde209 name="input.g.page3.xcde209"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcde210
            #add-point:BEFORE FIELD xcde210 name="input.b.page3.xcde210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcde210
            
            #add-point:AFTER FIELD xcde210 name="input.a.page3.xcde210"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcde210
            #add-point:ON CHANGE xcde210 name="input.g.page3.xcde210"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.xcde207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde207
            #add-point:ON ACTION controlp INFIELD xcde207 name="input.c.page3.xcde207"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xcde208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde208
            #add-point:ON ACTION controlp INFIELD xcde208 name="input.c.page3.xcde208"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xcde209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde209
            #add-point:ON ACTION controlp INFIELD xcde209 name="input.c.page3.xcde209"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xcde210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcde210
            #add-point:ON ACTION controlp INFIELD xcde210 name="input.c.page3.xcde210"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axcq701_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axcq701_unlock_b("xcde_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcde_d[li_reproduce_target].* = g_xcde_d[li_reproduce].*
               LET g_xcde2_d[li_reproduce_target].* = g_xcde2_d[li_reproduce].*
               LET g_xcde3_d[li_reproduce_target].* = g_xcde3_d[li_reproduce].*
 
               LET g_xcde3_d[li_reproduce_target].xcde007 = NULL
               LET g_xcde3_d[li_reproduce_target].xcde008 = NULL
               LET g_xcde3_d[li_reproduce_target].xcde009 = NULL
               LET g_xcde3_d[li_reproduce_target].xcde010 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcde3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcde3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="axcq701.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2','3',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xccdld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcde007
               WHEN "s_detail2"
                  NEXT FIELD xcde007_2
               WHEN "s_detail3"
                  NEXT FIELD xcde007_3
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq701_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xccd_m.xccdcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否        
   ELSE
      CALL cl_get_para(g_enterprise,g_xccd_m.xccdcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xccd_m.xccdcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF    
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccd002,xccd002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcde008_3',TRUE)                    
   ELSE                           
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcde008_3',FALSE)                
   END IF   
   CALL axcq701_ref()
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axcq701_b_fill() #單身填充
      CALL axcq701_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq701_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_xccd_m_mask_o.* =  g_xccd_m.*
   CALL axcq701_xccd_t_mask()
   LET g_xccd_m_mask_n.* =  g_xccd_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccdld, 
       g_xccd_m.xccdld_desc,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd003_desc,g_xccd_m.xccd007, 
       g_xccd_m.xccd007_desc,g_xccd_m.xccd007_desc_desc,g_xccd_m.imag014,g_xccd_m.imag014_desc,g_xccd_m.xccd002, 
       g_xccd_m.xccd002_desc,g_xccd_m.sfaa048,g_xccd_m.xccd009,g_xccd_m.xcbb006,g_xccd_m.sfaa042,g_xccd_m.xccd200, 
       g_xccd_m.xccd001
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcde_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcde2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xcde3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axcq701_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axcq701_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq701_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xccd_t.xccdld 
   DEFINE l_oldno     LIKE xccd_t.xccdld 
   DEFINE l_newno02     LIKE xccd_t.xccd001 
   DEFINE l_oldno02     LIKE xccd_t.xccd001 
   DEFINE l_newno03     LIKE xccd_t.xccd002 
   DEFINE l_oldno03     LIKE xccd_t.xccd002 
   DEFINE l_newno04     LIKE xccd_t.xccd003 
   DEFINE l_oldno04     LIKE xccd_t.xccd003 
   DEFINE l_newno05     LIKE xccd_t.xccd004 
   DEFINE l_oldno05     LIKE xccd_t.xccd004 
   DEFINE l_newno06     LIKE xccd_t.xccd005 
   DEFINE l_oldno06     LIKE xccd_t.xccd005 
   DEFINE l_newno07     LIKE xccd_t.xccd006 
   DEFINE l_oldno07     LIKE xccd_t.xccd006 
 
   DEFINE l_master    RECORD LIKE xccd_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcde_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_xccd_m.xccdld IS NULL
   OR g_xccd_m.xccd001 IS NULL
   OR g_xccd_m.xccd002 IS NULL
   OR g_xccd_m.xccd003 IS NULL
   OR g_xccd_m.xccd004 IS NULL
   OR g_xccd_m.xccd005 IS NULL
   OR g_xccd_m.xccd006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001
   LET g_xccd002_t = g_xccd_m.xccd002
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   LET g_xccd006_t = g_xccd_m.xccd006
 
    
   LET g_xccd_m.xccdld = ""
   LET g_xccd_m.xccd001 = ""
   LET g_xccd_m.xccd002 = ""
   LET g_xccd_m.xccd003 = ""
   LET g_xccd_m.xccd004 = ""
   LET g_xccd_m.xccd005 = ""
   LET g_xccd_m.xccd006 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
      LET g_xccd_m.xccdld_desc = ''
   DISPLAY BY NAME g_xccd_m.xccdld_desc
   LET g_xccd_m.xccd003_desc = ''
   DISPLAY BY NAME g_xccd_m.xccd003_desc
   LET g_xccd_m.xccd002_desc = ''
   DISPLAY BY NAME g_xccd_m.xccd002_desc
 
   
   CALL axcq701_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xccd_m.* TO NULL
      INITIALIZE g_xcde_d TO NULL
      INITIALIZE g_xcde2_d TO NULL
      INITIALIZE g_xcde3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axcq701_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq701_set_act_visible()   
   CALL axcq701_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001
   LET g_xccd002_t = g_xccd_m.xccd002
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   LET g_xccd006_t = g_xccd_m.xccd006
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccdent = " ||g_enterprise|| " AND",
                      " xccdld = '", g_xccd_m.xccdld, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001, "' "
                      ," AND xccd002 = '", g_xccd_m.xccd002, "' "
                      ," AND xccd003 = '", g_xccd_m.xccd003, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005, "' "
                      ," AND xccd006 = '", g_xccd_m.xccd006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq701_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axcq701_idx_chk()
   
   
   #功能已完成,通報訊息中心
   CALL axcq701_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq701_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcde_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq701_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcde_t
    WHERE xcdeent = g_enterprise AND xcdeld = g_xccdld_t
     AND xcde001 = g_xccd001_t
     AND xcde002 = g_xccd002_t
     AND xcde003 = g_xccd003_t
     AND xcde004 = g_xccd004_t
     AND xcde005 = g_xccd005_t
     AND xcde006 = g_xccd006_t
 
    INTO TEMP axcq701_detail
 
   #將key修正為調整後   
   UPDATE axcq701_detail 
      #更新key欄位
      SET xcdeld = g_xccd_m.xccdld
          , xcde001 = g_xccd_m.xccd001
          , xcde002 = g_xccd_m.xccd002
          , xcde003 = g_xccd_m.xccd003
          , xcde004 = g_xccd_m.xccd004
          , xcde005 = g_xccd_m.xccd005
          , xcde006 = g_xccd_m.xccd006
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xcde_t SELECT * FROM axcq701_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axcq701_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001
   LET g_xccd002_t = g_xccd_m.xccd002
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   LET g_xccd006_t = g_xccd_m.xccd006
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq701_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xccd_m.xccdld IS NULL
   OR g_xccd_m.xccd001 IS NULL
   OR g_xccd_m.xccd002 IS NULL
   OR g_xccd_m.xccd003 IS NULL
   OR g_xccd_m.xccd004 IS NULL
   OR g_xccd_m.xccd005 IS NULL
   OR g_xccd_m.xccd006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axcq701_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq701_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axcq701_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq701_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd005, 
       g_xccd_m.xccdld,g_xccd_m.xccd006,g_xccd_m.xccd003,g_xccd_m.xccd007,g_xccd_m.xccd002,g_xccd_m.xccd009, 
       g_xccd_m.xccd200,g_xccd_m.xccd001,g_xccd_m.xccd002_desc
   
   
   #檢查是否允許此動作
   IF NOT axcq701_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xccd_m_mask_o.* =  g_xccd_m.*
   CALL axcq701_xccd_t_mask()
   LET g_xccd_m_mask_n.* =  g_xccd_m.*
   
   CALL axcq701_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq701_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xccdld_t = g_xccd_m.xccdld
      LET g_xccd001_t = g_xccd_m.xccd001
      LET g_xccd002_t = g_xccd_m.xccd002
      LET g_xccd003_t = g_xccd_m.xccd003
      LET g_xccd004_t = g_xccd_m.xccd004
      LET g_xccd005_t = g_xccd_m.xccd005
      LET g_xccd006_t = g_xccd_m.xccd006
 
 
      DELETE FROM xccd_t
       WHERE xccdent = g_enterprise AND xccdld = g_xccd_m.xccdld
         AND xccd001 = g_xccd_m.xccd001
         AND xccd002 = g_xccd_m.xccd002
         AND xccd003 = g_xccd_m.xccd003
         AND xccd004 = g_xccd_m.xccd004
         AND xccd005 = g_xccd_m.xccd005
         AND xccd006 = g_xccd_m.xccd006
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xccd_m.xccdld,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcde_t
       WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld
         AND xcde001 = g_xccd_m.xccd001
         AND xcde002 = g_xccd_m.xccd002
         AND xcde003 = g_xccd_m.xccd003
         AND xcde004 = g_xccd_m.xccd004
         AND xcde005 = g_xccd_m.xccd005
         AND xcde006 = g_xccd_m.xccd006
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xccd_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axcq701_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xcde_d.clear() 
      CALL g_xcde2_d.clear()       
      CALL g_xcde3_d.clear()       
 
     
      CALL axcq701_ui_browser_refresh()  
      #CALL axcq701_ui_headershow()  
      #CALL axcq701_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axcq701_browser_fill("")
         CALL axcq701_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axcq701_cl
 
   #功能已完成,通報訊息中心
   CALL axcq701_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq701.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq701_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xcde_d.clear()
   CALL g_xcde2_d.clear()
   CALL g_xcde3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF 1 = 2 THEN
   #end add-point
   
   #判斷是否填充
   IF axcq701_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xcde007,xcde008,xcde009,xcde010,xcde101,xcde102,xcde201,xcde202, 
             xcde301,xcde302,xcde303,xcde304,xcde901,xcde902,xcde007,xcde008,xcde009,xcde010,xcde101, 
             xcde102,xcde205,xcde206,xcde307,xcde308,xcde303,xcde304,xcde901,xcde902,xcde007,xcde008, 
             xcde009,xcde010,xcde207,xcde208,xcde209,xcde210,xcde301,xcde302,xcde303,xcde304,xcde901, 
             xcde902 ,t1.imaal003 ,t2.imaal004 ,t3.xcaul003 FROM xcde_t",   
                     " INNER JOIN xccd_t ON xccdent = " ||g_enterprise|| " AND xccdld = xcdeld ",
                     " AND xccd001 = xcde001 ",
                     " AND xccd002 = xcde002 ",
                     " AND xccd003 = xcde003 ",
                     " AND xccd004 = xcde004 ",
                     " AND xccd005 = xcde005 ",
                     " AND xccd006 = xcde006 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xcde007 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xcde007 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t3 ON t3.xcaulent="||g_enterprise||" AND t3.xcaul001=xcde010 AND t3.xcaul002='"||g_dlang||"' ",
 
                     " WHERE xcdeent=? AND xcdeld=? AND xcde001=? AND xcde002=? AND xcde003=? AND xcde004=? AND xcde005=? AND xcde006=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xcde_t.xcde007,xcde_t.xcde008,xcde_t.xcde009,xcde_t.xcde010"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq701_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq701_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
          g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008, 
          g_xcde_d[l_ac].xcde009,g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102, 
          g_xcde_d[l_ac].xcde201,g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302, 
          g_xcde_d[l_ac].xcde303,g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902, 
          g_xcde2_d[l_ac].xcde007,g_xcde2_d[l_ac].xcde008,g_xcde2_d[l_ac].xcde009,g_xcde2_d[l_ac].xcde010, 
          g_xcde2_d[l_ac].xcde101,g_xcde2_d[l_ac].xcde102,g_xcde2_d[l_ac].xcde205,g_xcde2_d[l_ac].xcde206, 
          g_xcde2_d[l_ac].xcde307,g_xcde2_d[l_ac].xcde308,g_xcde2_d[l_ac].xcde303,g_xcde2_d[l_ac].xcde304, 
          g_xcde2_d[l_ac].xcde901,g_xcde2_d[l_ac].xcde902,g_xcde3_d[l_ac].xcde007,g_xcde3_d[l_ac].xcde008, 
          g_xcde3_d[l_ac].xcde009,g_xcde3_d[l_ac].xcde010,g_xcde3_d[l_ac].xcde207,g_xcde3_d[l_ac].xcde208, 
          g_xcde3_d[l_ac].xcde209,g_xcde3_d[l_ac].xcde210,g_xcde3_d[l_ac].xcde301,g_xcde3_d[l_ac].xcde302, 
          g_xcde3_d[l_ac].xcde303,g_xcde3_d[l_ac].xcde304,g_xcde3_d[l_ac].xcde901,g_xcde3_d[l_ac].xcde902, 
          g_xcde_d[l_ac].xcde007_desc,g_xcde_d[l_ac].xcde007_desc_desc,g_xcde_d[l_ac].xcde010_desc   
           #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   ELSE     
      CALL axcq701_b_fill_1()      
   END IF
   #end add-point
   
   CALL g_xcde_d.deleteElement(g_xcde_d.getLength())
   CALL g_xcde2_d.deleteElement(g_xcde2_d.getLength())
   CALL g_xcde3_d.deleteElement(g_xcde3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axcq701_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcde_d.getLength()
      LET g_xcde_d_mask_o[l_ac].* =  g_xcde_d[l_ac].*
      CALL axcq701_xcde_t_mask()
      LET g_xcde_d_mask_n[l_ac].* =  g_xcde_d[l_ac].*
   END FOR
   
   LET g_xcde2_d_mask_o.* =  g_xcde2_d.*
   FOR l_ac = 1 TO g_xcde2_d.getLength()
      LET g_xcde2_d_mask_o[l_ac].* =  g_xcde2_d[l_ac].*
      CALL axcq701_xcde_t_mask()
      LET g_xcde2_d_mask_n[l_ac].* =  g_xcde2_d[l_ac].*
   END FOR
   LET g_xcde3_d_mask_o.* =  g_xcde3_d.*
   FOR l_ac = 1 TO g_xcde3_d.getLength()
      LET g_xcde3_d_mask_o[l_ac].* =  g_xcde3_d[l_ac].*
      CALL axcq701_xcde_t_mask()
      LET g_xcde3_d_mask_n[l_ac].* =  g_xcde3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq701_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM xcde_t
       WHERE xcdeent = g_enterprise AND
         xcdeld = ps_keys_bak[1] AND xcde001 = ps_keys_bak[2] AND xcde002 = ps_keys_bak[3] AND xcde003 = ps_keys_bak[4] AND xcde004 = ps_keys_bak[5] AND xcde005 = ps_keys_bak[6] AND xcde006 = ps_keys_bak[7] AND xcde007 = ps_keys_bak[8] AND xcde008 = ps_keys_bak[9] AND xcde009 = ps_keys_bak[10] AND xcde010 = ps_keys_bak[11]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xcde_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xcde2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xcde3_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq701_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO xcde_t
                  (xcdeent,
                   xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,
                   xcde007,xcde008,xcde009,xcde010
                   ,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde901,xcde902,xcde101,xcde102,xcde205,xcde206,xcde307,xcde308,xcde303,xcde304,xcde901,xcde902,xcde207,xcde208,xcde209,xcde210,xcde301,xcde302,xcde303,xcde304,xcde901,xcde902) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10],ps_keys[11]
                   ,g_xcde_d[g_detail_idx].xcde101,g_xcde_d[g_detail_idx].xcde102,g_xcde_d[g_detail_idx].xcde201, 
                       g_xcde_d[g_detail_idx].xcde202,g_xcde_d[g_detail_idx].xcde301,g_xcde_d[g_detail_idx].xcde302, 
                       g_xcde_d[g_detail_idx].xcde303,g_xcde_d[g_detail_idx].xcde304,g_xcde_d[g_detail_idx].xcde901, 
                       g_xcde_d[g_detail_idx].xcde902,g_xcde_d[g_detail_idx].xcde101,g_xcde_d[g_detail_idx].xcde102, 
                       g_xcde2_d[g_detail_idx].xcde205,g_xcde2_d[g_detail_idx].xcde206,g_xcde2_d[g_detail_idx].xcde307, 
                       g_xcde2_d[g_detail_idx].xcde308,g_xcde_d[g_detail_idx].xcde303,g_xcde_d[g_detail_idx].xcde304, 
                       g_xcde_d[g_detail_idx].xcde901,g_xcde_d[g_detail_idx].xcde902,g_xcde3_d[g_detail_idx].xcde207, 
                       g_xcde3_d[g_detail_idx].xcde208,g_xcde3_d[g_detail_idx].xcde209,g_xcde3_d[g_detail_idx].xcde210, 
                       g_xcde_d[g_detail_idx].xcde301,g_xcde_d[g_detail_idx].xcde302,g_xcde_d[g_detail_idx].xcde303, 
                       g_xcde_d[g_detail_idx].xcde304,g_xcde_d[g_detail_idx].xcde901,g_xcde_d[g_detail_idx].xcde902) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xcde_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xcde2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xcde3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq701_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
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
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcde_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axcq701_xcde_t_mask_restore('restore_mask_o')
               
      UPDATE xcde_t 
         SET (xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,
              xcde007,xcde008,xcde009,xcde010
              ,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde901,xcde902,xcde101,xcde102,xcde205,xcde206,xcde307,xcde308,xcde303,xcde304,xcde901,xcde902,xcde207,xcde208,xcde209,xcde210,xcde301,xcde302,xcde303,xcde304,xcde901,xcde902) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10],ps_keys[11]
              ,g_xcde_d[g_detail_idx].xcde101,g_xcde_d[g_detail_idx].xcde102,g_xcde_d[g_detail_idx].xcde201, 
                  g_xcde_d[g_detail_idx].xcde202,g_xcde_d[g_detail_idx].xcde301,g_xcde_d[g_detail_idx].xcde302, 
                  g_xcde_d[g_detail_idx].xcde303,g_xcde_d[g_detail_idx].xcde304,g_xcde_d[g_detail_idx].xcde901, 
                  g_xcde_d[g_detail_idx].xcde902,g_xcde_d[g_detail_idx].xcde101,g_xcde_d[g_detail_idx].xcde102, 
                  g_xcde2_d[g_detail_idx].xcde205,g_xcde2_d[g_detail_idx].xcde206,g_xcde2_d[g_detail_idx].xcde307, 
                  g_xcde2_d[g_detail_idx].xcde308,g_xcde_d[g_detail_idx].xcde303,g_xcde_d[g_detail_idx].xcde304, 
                  g_xcde_d[g_detail_idx].xcde901,g_xcde_d[g_detail_idx].xcde902,g_xcde3_d[g_detail_idx].xcde207, 
                  g_xcde3_d[g_detail_idx].xcde208,g_xcde3_d[g_detail_idx].xcde209,g_xcde3_d[g_detail_idx].xcde210, 
                  g_xcde_d[g_detail_idx].xcde301,g_xcde_d[g_detail_idx].xcde302,g_xcde_d[g_detail_idx].xcde303, 
                  g_xcde_d[g_detail_idx].xcde304,g_xcde_d[g_detail_idx].xcde901,g_xcde_d[g_detail_idx].xcde902)  
 
         WHERE xcdeent = g_enterprise AND xcdeld = ps_keys_bak[1] AND xcde001 = ps_keys_bak[2] AND xcde002 = ps_keys_bak[3] AND xcde003 = ps_keys_bak[4] AND xcde004 = ps_keys_bak[5] AND xcde005 = ps_keys_bak[6] AND xcde006 = ps_keys_bak[7] AND xcde007 = ps_keys_bak[8] AND xcde008 = ps_keys_bak[9] AND xcde009 = ps_keys_bak[10] AND xcde010 = ps_keys_bak[11]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcde_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcde_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axcq701_xcde_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axcq701_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq701_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq701_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL axcq701_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2','3',"
   #僅鎖定自身table
   LET ls_group = "xcde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axcq701_bcl USING g_enterprise,
                                       g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
                                           g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006,g_xcde_d[g_detail_idx].xcde007, 
                                           g_xcde_d[g_detail_idx].xcde008,g_xcde_d[g_detail_idx].xcde009, 
                                           g_xcde_d[g_detail_idx].xcde010     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axcq701_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq701_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axcq701_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq701_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xccdld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006",TRUE)
      CALL cl_set_comp_entry("",TRUE)
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
 
{<section id="axcq701.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq701_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xccdld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq701_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axcq701.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq701_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axcq701.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq701_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq701_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq701_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq701_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq701_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xccdld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccd001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccd002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccd003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xccd004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xccd005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " xccd006 = '", g_argv[07], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "xccd_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xcde_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
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
 
{<section id="axcq701.state_change" >}
   
 
{</section>}
 
{<section id="axcq701.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq701_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xcde_d.getLength() THEN
         LET g_detail_idx = g_xcde_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcde_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcde_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcde2_d.getLength() THEN
         LET g_detail_idx = g_xcde2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcde2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcde2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_xcde3_d.getLength() THEN
         LET g_detail_idx = g_xcde3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcde3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcde3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq701_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL axcq701_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq701_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq701.status_show" >}
PRIVATE FUNCTION axcq701_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq701.mask_functions" >}
&include "erp/axc/axcq701_mask.4gl"
 
{</section>}
 
{<section id="axcq701.signature" >}
   
 
{</section>}
 
{<section id="axcq701.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq701_set_pk_array()
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
   LET g_pk_array[1].values = g_xccd_m.xccdld
   LET g_pk_array[1].column = 'xccdld'
   LET g_pk_array[2].values = g_xccd_m.xccd001
   LET g_pk_array[2].column = 'xccd001'
   LET g_pk_array[3].values = g_xccd_m.xccd002
   LET g_pk_array[3].column = 'xccd002'
   LET g_pk_array[4].values = g_xccd_m.xccd003
   LET g_pk_array[4].column = 'xccd003'
   LET g_pk_array[5].values = g_xccd_m.xccd004
   LET g_pk_array[5].column = 'xccd004'
   LET g_pk_array[6].values = g_xccd_m.xccd005
   LET g_pk_array[6].column = 'xccd005'
   LET g_pk_array[7].values = g_xccd_m.xccd006
   LET g_pk_array[7].column = 'xccd006'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq701.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axcq701.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq701_msgcentre_notify(lc_state)
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
   CALL axcq701_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xccd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq701.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axcq701_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axcq701.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq701_b_fill_1()
   
   DEFINE l_xcde102_sum   LIKE xcde_t.xcde102   
   DEFINE l_xcde202_sum   LIKE xcde_t.xcde202   
   DEFINE l_xcde302_sum   LIKE xcde_t.xcde302   
   DEFINE l_xcde304_sum   LIKE xcde_t.xcde304   
   DEFINE l_xcde902_sum   LIKE xcde_t.xcde902    
   DEFINE l_xcde102_total LIKE xcde_t.xcde102    
   DEFINE l_xcde202_total LIKE xcde_t.xcde202    
   DEFINE l_xcde302_total LIKE xcde_t.xcde302    
   DEFINE l_xcde304_total LIKE xcde_t.xcde304    
   DEFINE l_xcde902_total LIKE xcde_t.xcde902
   DEFINE l_sql           STRING
#币一
      LET g_sql = "SELECT  UNIQUE '','','',t2.xcau003,xcde010,SUM(xcde101),SUM(xcde102),
          SUM(xcde201+xcde205+xcde207+xcde209),SUM(xcde202+xcde206+xcde208+xcde210),
          SUM(xcde301+xcde307),SUM(xcde302+xcde308),
          SUM(xcde303),SUM(xcde304),SUM(xcde901),SUM(xcde902),t1.xcaul003 FROM xcde_t", 
             
                  " INNER JOIN xccd_t ON xccdld = xcdeld ",
                  " AND xccd001 = xcde001 ",
                  " AND xccd002 = xcde002 ",
                  " AND xccd003 = xcde003 ",
                  " AND xccd004 = xcde004 ",
                  " AND xccd005 = xcde005 ",
                  " AND xccd006 = xcde006 ",
 
                   " LEFT JOIN xcau_t t2 ON t2.xcauent='"||g_enterprise||"' AND t2.xcau001=xcde010 ",
                  
                  "",
                                 " LEFT JOIN xcaul_t t1 ON t1.xcaulent='"||g_enterprise||"' AND t1.xcaul001=xcde010 AND t1.xcaul002='"||g_dlang||"' ",
 
                  " WHERE xcdeent=? AND xcdeld=?  AND xcde002=? AND xcde003=? AND xcde004=? AND xcde005=? AND xcde006=?"
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料

      #add-point:b_fill段sql_before

      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      LET l_sql = g_sql
      LET g_sql = g_sql," AND xcde001 = '1' "
      LET g_sql = g_sql," GROUP BY xcde010,t2.xcau003,t1.xcaul003 "
      LET g_sql = g_sql, " ORDER BY t2.xcau003,xcde_t.xcde010"
      
      #add-point:單身填充控制
      LET l_xcde102_sum  = 0 
      LET l_xcde202_sum  = 0 
      LET l_xcde302_sum  = 0 
      LET l_xcde304_sum  = 0 
      LET l_xcde902_sum  = 0 
      LET l_xcde102_total= 0 
      LET l_xcde202_total= 0 
      LET l_xcde302_total= 0 
      LET l_xcde304_total= 0 
      LET l_xcde902_total= 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq701_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR axcq701_pb1
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
                                               
      FOREACH b_fill_cs1 INTO g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009,
          g_xcde_d[l_ac].xcau003,g_xcde_d[l_ac].xcde010, 
          g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201,g_xcde_d[l_ac].xcde202, 
          g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303,g_xcde_d[l_ac].xcde304, 
          g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902,g_xcde_d[l_ac].xcde010_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #合计 
         LET l_xcde102_total=l_xcde102_total + g_xcde_d[l_ac].xcde102 
         LET l_xcde202_total=l_xcde202_total + g_xcde_d[l_ac].xcde202
         LET l_xcde302_total=l_xcde302_total + g_xcde_d[l_ac].xcde302
         LET l_xcde304_total=l_xcde304_total + g_xcde_d[l_ac].xcde304
         LET l_xcde902_total=l_xcde902_total + g_xcde_d[l_ac].xcde902 
         #按主要素 小计
         LET l_xcde102_sum=l_xcde102_sum + g_xcde_d[l_ac].xcde102
         LET l_xcde202_sum=l_xcde202_sum + g_xcde_d[l_ac].xcde202
         LET l_xcde302_sum=l_xcde302_sum + g_xcde_d[l_ac].xcde302
         LET l_xcde304_sum=l_xcde304_sum + g_xcde_d[l_ac].xcde304
         LET l_xcde902_sum=l_xcde902_sum + g_xcde_d[l_ac].xcde902 
         IF l_ac > 1 THEN
            IF g_xcde_d[l_ac].xcau003 != g_xcde_d[l_ac - 1].xcau003 THEN 
               LET g_xcde_d[l_ac + 1].* = g_xcde_d[l_ac].* 
               INITIALIZE  g_xcde_d[l_ac].* TO NULL    
               #LET g_xcde_d[l_ac].xcde010 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
               LET g_xcde_d[l_ac].xcde010_desc = g_xcde_d[l_ac-1].xcau003,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie
               LET g_xcde_d[l_ac].xcde102 = l_xcde102_sum - g_xcde_d[l_ac + 1].xcde102
               LET g_xcde_d[l_ac].xcde202 = l_xcde202_sum - g_xcde_d[l_ac + 1].xcde202
               LET g_xcde_d[l_ac].xcde302 = l_xcde302_sum - g_xcde_d[l_ac + 1].xcde302
               LET g_xcde_d[l_ac].xcde304 = l_xcde304_sum - g_xcde_d[l_ac + 1].xcde304
               LET g_xcde_d[l_ac].xcde902 = l_xcde902_sum - g_xcde_d[l_ac + 1].xcde902
               LET l_ac = l_ac + 1
               LET l_xcde102_sum = g_xcde_d[l_ac].xcde102
               LET l_xcde202_sum = g_xcde_d[l_ac].xcde202
               LET l_xcde302_sum = g_xcde_d[l_ac].xcde302
               LET l_xcde304_sum = g_xcde_d[l_ac].xcde304
               LET l_xcde902_sum = g_xcde_d[l_ac].xcde902               
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
      LET g_error_show = 0
      
      FREE axcq701_pb1
      
      IF l_ac > 1 THEN
         #最后一组小计
         #LET g_xcde_d[l_ac].xcde010 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
         LET g_xcde_d[l_ac].xcde010_desc = g_xcde_d[l_ac-1].xcau003,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie
         LET g_xcde_d[l_ac].xcde102 = l_xcde102_sum
         LET g_xcde_d[l_ac].xcde202 = l_xcde202_sum
         LET g_xcde_d[l_ac].xcde302 = l_xcde302_sum
         LET g_xcde_d[l_ac].xcde304 = l_xcde304_sum
         LET g_xcde_d[l_ac].xcde902 = l_xcde902_sum
         LET l_ac = l_ac + 1
         #合计
         LET g_xcde_d[l_ac].xcde010 = cl_getmsg("axc-00204",g_lang)
         LET g_xcde_d[l_ac].xcde102 = l_xcde102_total
         LET g_xcde_d[l_ac].xcde202 = l_xcde202_total
         LET g_xcde_d[l_ac].xcde302 = l_xcde302_total
         LET g_xcde_d[l_ac].xcde304 = l_xcde304_total
         LET g_xcde_d[l_ac].xcde902 = l_xcde902_total 
         LET l_ac = l_ac + 1 
         #对付deleteElement 人为加一行
         LET g_xcde_d[l_ac].xcde010 = ' '
         LET g_xcde_d[l_ac].xcde101 = 0
         LET g_xcde_d[l_ac].xcde102 = 0
         LET g_xcde_d[l_ac].xcde201 = 0
         LET g_xcde_d[l_ac].xcde202 = 0
         LET g_xcde_d[l_ac].xcde301 = 0
         LET g_xcde_d[l_ac].xcde302 = 0
         LET g_xcde_d[l_ac].xcde303 = 0
         LET g_xcde_d[l_ac].xcde304 = 0
         LET g_xcde_d[l_ac].xcde901 = 0
         LET g_xcde_d[l_ac].xcde902 = 0
      END IF
      
#币二
   IF g_glaa015 = 'Y' THEN      
      LET g_sql = l_sql," AND xcde001 = '2' "
      LET g_sql = g_sql," GROUP BY xcde010,t2.xcau003,t1.xcaul003 "
      LET g_sql = g_sql, " ORDER BY t2.xcau003,xcde_t.xcde010"
      
      #add-point:單身填充控制
      LET l_xcde102_sum  = 0
      LET l_xcde202_sum  = 0
      LET l_xcde302_sum  = 0 
      LET l_xcde304_sum  = 0 
      LET l_xcde902_sum  = 0
      LET l_xcde102_total= 0
      LET l_xcde202_total= 0 
      LET l_xcde302_total= 0 
      LET l_xcde304_total= 0
      LET l_xcde902_total= 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq701_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR axcq701_pb2
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
                                               
      FOREACH b_fill_cs2 INTO g_xcde2_d[l_ac].xcde007,g_xcde2_d[l_ac].xcde008,g_xcde2_d[l_ac].xcde009,
          g_xcde2_d[l_ac].xcau003,g_xcde2_d[l_ac].xcde010, 
          g_xcde2_d[l_ac].xcde101,g_xcde2_d[l_ac].xcde102,g_xcde2_d[l_ac].xcde205,g_xcde2_d[l_ac].xcde206, 
          g_xcde2_d[l_ac].xcde307,g_xcde2_d[l_ac].xcde308,g_xcde2_d[l_ac].xcde303,g_xcde2_d[l_ac].xcde304, 
          g_xcde2_d[l_ac].xcde901,g_xcde2_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde010_2_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #合计  
         LET l_xcde102_total=l_xcde102_total + g_xcde2_d[l_ac].xcde102
         LET l_xcde202_total=l_xcde202_total + g_xcde2_d[l_ac].xcde206
         LET l_xcde302_total=l_xcde302_total + g_xcde2_d[l_ac].xcde308
         LET l_xcde304_total=l_xcde304_total + g_xcde2_d[l_ac].xcde304
         LET l_xcde902_total=l_xcde902_total + g_xcde2_d[l_ac].xcde902 
         #按主要素 小计 
         LET l_xcde102_sum=l_xcde102_sum + g_xcde2_d[l_ac].xcde102
         LET l_xcde202_sum=l_xcde202_sum + g_xcde2_d[l_ac].xcde206
         LET l_xcde302_sum=l_xcde302_sum + g_xcde2_d[l_ac].xcde308
         LET l_xcde304_sum=l_xcde304_sum + g_xcde2_d[l_ac].xcde304
         LET l_xcde902_sum=l_xcde902_sum + g_xcde2_d[l_ac].xcde902 
         IF l_ac > 1 THEN
            IF g_xcde2_d[l_ac].xcau003 != g_xcde2_d[l_ac - 1].xcau003 THEN 
               LET g_xcde2_d[l_ac + 1].* = g_xcde2_d[l_ac].* 
               INITIALIZE  g_xcde2_d[l_ac].* TO NULL    
               #LET g_xcde2_d[l_ac].xcde010 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
               LET g_xcde2_d[l_ac].xcde010_2_desc = g_xcde2_d[l_ac-1].xcau003,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie
               LET g_xcde2_d[l_ac].xcde102 = l_xcde102_sum - g_xcde2_d[l_ac + 1].xcde102
               LET g_xcde2_d[l_ac].xcde206 = l_xcde202_sum - g_xcde2_d[l_ac + 1].xcde206
               LET g_xcde2_d[l_ac].xcde308 = l_xcde302_sum - g_xcde2_d[l_ac + 1].xcde308
               LET g_xcde2_d[l_ac].xcde304 = l_xcde304_sum - g_xcde2_d[l_ac + 1].xcde304
               LET g_xcde2_d[l_ac].xcde902 = l_xcde902_sum - g_xcde2_d[l_ac + 1].xcde902
               LET l_ac = l_ac + 1
               LET l_xcde102_sum = g_xcde2_d[l_ac].xcde102
               LET l_xcde202_sum = g_xcde2_d[l_ac].xcde206
               LET l_xcde302_sum = g_xcde2_d[l_ac].xcde308
               LET l_xcde304_sum = g_xcde2_d[l_ac].xcde304
               LET l_xcde902_sum = g_xcde2_d[l_ac].xcde902               
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
      LET g_error_show = 0
      
      FREE axcq701_pb2
      
      IF l_ac > 1 THEN
         #最后一组小计
         #LET g_xcde2_d[l_ac].xcde010 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
         LET g_xcde2_d[l_ac].xcde010_2_desc = g_xcde2_d[l_ac-1].xcau003,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie
         LET g_xcde2_d[l_ac].xcde102 = l_xcde102_sum
         LET g_xcde2_d[l_ac].xcde206 = l_xcde202_sum
         LET g_xcde2_d[l_ac].xcde308 = l_xcde302_sum
         LET g_xcde2_d[l_ac].xcde304 = l_xcde304_sum
         LET g_xcde2_d[l_ac].xcde902 = l_xcde902_sum
         LET l_ac = l_ac + 1
         #合计
         LET g_xcde2_d[l_ac].xcde010 = cl_getmsg("axc-00204",g_lang)
         LET g_xcde2_d[l_ac].xcde102 = l_xcde102_total
         LET g_xcde2_d[l_ac].xcde206 = l_xcde202_total
         LET g_xcde2_d[l_ac].xcde308 = l_xcde302_total
         LET g_xcde2_d[l_ac].xcde304 = l_xcde304_total
         LET g_xcde2_d[l_ac].xcde902 = l_xcde902_total 
         LET l_ac = l_ac + 1 
         #对付deleteElement 人为加一行
         LET g_xcde2_d[l_ac].xcde010 = ' '
         LET g_xcde2_d[l_ac].xcde101 = 0
         LET g_xcde2_d[l_ac].xcde102 = 0
         LET g_xcde2_d[l_ac].xcde205 = 0
         LET g_xcde2_d[l_ac].xcde206 = 0
         LET g_xcde2_d[l_ac].xcde307 = 0
         LET g_xcde2_d[l_ac].xcde308 = 0
         LET g_xcde2_d[l_ac].xcde303 = 0
         LET g_xcde2_d[l_ac].xcde304 = 0
         LET g_xcde2_d[l_ac].xcde901 = 0
         LET g_xcde2_d[l_ac].xcde902 = 0
      END IF
   END IF
   
#币三
   IF g_glaa019 = 'Y' THEN      
      LET g_sql = l_sql," AND xcde001 = '3' "
      LET g_sql = g_sql," GROUP BY xcde010,t2.xcau003,t1.xcaul003 "
      LET g_sql = g_sql, " ORDER BY t2.xcau003,xcde_t.xcde010"
      
      #add-point:單身填充控制
      LET l_xcde102_sum  = 0 
      LET l_xcde202_sum  = 0 
      LET l_xcde302_sum  = 0
      LET l_xcde304_sum  = 0 
      LET l_xcde902_sum  = 0
      LET l_xcde102_total= 0
      LET l_xcde202_total= 0
      LET l_xcde302_total= 0
      LET l_xcde304_total= 0
      LET l_xcde902_total= 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq701_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axcq701_pb3
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
                                               
      FOREACH b_fill_cs3 INTO g_xcde3_d[l_ac].xcde007,g_xcde3_d[l_ac].xcde008,g_xcde3_d[l_ac].xcde009,
          g_xcde3_d[l_ac].xcau003,g_xcde3_d[l_ac].xcde010, 
          g_xcde3_d[l_ac].xcde207,g_xcde3_d[l_ac].xcde208,g_xcde3_d[l_ac].xcde209,g_xcde3_d[l_ac].xcde210, 
          g_xcde3_d[l_ac].xcde301,g_xcde3_d[l_ac].xcde302,g_xcde3_d[l_ac].xcde303,g_xcde3_d[l_ac].xcde304, 
          g_xcde3_d[l_ac].xcde901,g_xcde3_d[l_ac].xcde902,g_xcde3_d[l_ac].xcde010_3_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #合计
         LET l_xcde102_total=l_xcde102_total + g_xcde3_d[l_ac].xcde208
         LET l_xcde202_total=l_xcde202_total + g_xcde3_d[l_ac].xcde210
         LET l_xcde302_total=l_xcde302_total + g_xcde3_d[l_ac].xcde302
         LET l_xcde304_total=l_xcde304_total + g_xcde3_d[l_ac].xcde304
         LET l_xcde902_total=l_xcde902_total + g_xcde3_d[l_ac].xcde902 
         #按主要素 小计  
         LET l_xcde102_sum=l_xcde102_sum + g_xcde3_d[l_ac].xcde208 
         LET l_xcde202_sum=l_xcde202_sum + g_xcde3_d[l_ac].xcde210 
         LET l_xcde302_sum=l_xcde302_sum + g_xcde3_d[l_ac].xcde302 
         LET l_xcde304_sum=l_xcde304_sum + g_xcde3_d[l_ac].xcde304 
         LET l_xcde902_sum=l_xcde902_sum + g_xcde3_d[l_ac].xcde902 
         IF l_ac > 1 THEN
            IF g_xcde3_d[l_ac].xcau003 != g_xcde3_d[l_ac - 1].xcau003 THEN 
               LET g_xcde3_d[l_ac + 1].* = g_xcde3_d[l_ac].* 
               INITIALIZE  g_xcde3_d[l_ac].* TO NULL
               #LET g_xcde3_d[l_ac].xcde010 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
               LET g_xcde3_d[l_ac].xcde010_3_desc = g_xcde3_d[l_ac-1].xcau003,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie
               LET g_xcde3_d[l_ac].xcde208 = l_xcde102_sum - g_xcde3_d[l_ac + 1].xcde208
               LET g_xcde3_d[l_ac].xcde210 = l_xcde202_sum - g_xcde3_d[l_ac + 1].xcde210
               LET g_xcde3_d[l_ac].xcde302 = l_xcde302_sum - g_xcde3_d[l_ac + 1].xcde302
               LET g_xcde3_d[l_ac].xcde304 = l_xcde304_sum - g_xcde3_d[l_ac + 1].xcde304
               LET g_xcde3_d[l_ac].xcde902 = l_xcde902_sum - g_xcde3_d[l_ac + 1].xcde902
               LET l_ac = l_ac + 1
               LET l_xcde102_sum = g_xcde3_d[l_ac].xcde208
               LET l_xcde202_sum = g_xcde3_d[l_ac].xcde210
               LET l_xcde302_sum = g_xcde3_d[l_ac].xcde302
               LET l_xcde304_sum = g_xcde3_d[l_ac].xcde304
               LET l_xcde902_sum = g_xcde3_d[l_ac].xcde902               
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
      LET g_error_show = 0
      
      FREE axcq701_pb3
      
      IF l_ac > 1 THEN
         #最后一组小计
         #LET g_xcde3_d[l_ac].xcde010 = cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 mark by beckxie
         LET g_xcde3_d[l_ac].xcde010_3_desc = g_xcde3_d[l_ac-1].xcde010,cl_getmsg("axc-00205",g_lang)   #151029-00010#3 20151029 add by beckxie
         LET g_xcde3_d[l_ac].xcde208 = l_xcde102_sum
         LET g_xcde3_d[l_ac].xcde210 = l_xcde202_sum
         LET g_xcde3_d[l_ac].xcde302 = l_xcde302_sum
         LET g_xcde3_d[l_ac].xcde304 = l_xcde304_sum
         LET g_xcde3_d[l_ac].xcde902 = l_xcde902_sum
         LET l_ac = l_ac + 1
         #合计
         LET g_xcde3_d[l_ac].xcde010 = cl_getmsg("axc-00204",g_lang)
         LET g_xcde3_d[l_ac].xcde208 = l_xcde102_total
         LET g_xcde3_d[l_ac].xcde210 = l_xcde202_total
         LET g_xcde3_d[l_ac].xcde302 = l_xcde302_total
         LET g_xcde3_d[l_ac].xcde304 = l_xcde304_total
         LET g_xcde3_d[l_ac].xcde902 = l_xcde902_total 
         LET l_ac = l_ac + 1 
         #对付deleteElement 人为加一行
         LET g_xcde3_d[l_ac].xcde010 = ' '
         LET g_xcde3_d[l_ac].xcde207 = 0
         LET g_xcde3_d[l_ac].xcde208 = 0
         LET g_xcde3_d[l_ac].xcde209 = 0
         LET g_xcde3_d[l_ac].xcde210 = 0
         LET g_xcde3_d[l_ac].xcde301 = 0
         LET g_xcde3_d[l_ac].xcde302 = 0
         LET g_xcde3_d[l_ac].xcde303 = 0
         LET g_xcde3_d[l_ac].xcde304 = 0
         LET g_xcde3_d[l_ac].xcde901 = 0
         LET g_xcde3_d[l_ac].xcde902 = 0
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
PRIVATE FUNCTION axcq701_default()

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd003
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd003
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xccd_m.xccdcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否      
   ELSE
      CALL cl_get_para(g_enterprise,g_xccd_m.xccdcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xccd_m.xccdcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF    
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccd002,xccd002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcde008_3',TRUE)                    
   ELSE                           
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcde008_3',FALSE)                
   END IF      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccdcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccdcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccdcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccdld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccdld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccdld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccd003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccd003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccd003_desc
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
PRIVATE FUNCTION axcq701_ref()
   SELECT glaa015,glaa019
     INTO g_glaa015,g_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_xccd_m.xccdld
      
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("page_3",TRUE)
   ELSE
      CALL cl_set_comp_visible("page_3",FALSE) 
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible("page_4",TRUE)
   ELSE
      CALL cl_set_comp_visible("page_4",FALSE)
   END IF
   #根据工单抓返工否，结案日期
   SELECT sfaa042,sfaa048 INTO g_xccd_m.sfaa042,g_xccd_m.sfaa048
     FROM sfaa_t
    WHERE sfaaent   = g_enterprise
      AND sfaadocno = g_xccd_m.xccd006
      
   SELECT xcbb005 INTO g_xccd_m.imag014
     FROM xcbb_t
    WHERE xcbbent  = g_enterprise
      AND xcbbcomp = g_xccd_m.xccdcomp
      AND xcbb003  = g_xccd_m.xccd007
      AND xcbb001  = g_xccd_m.xccd004
      AND xcbb002  = g_xccd_m.xccd005
   
   CALL s_desc_get_unit_desc(g_xccd_m.imag014)
         RETURNING g_xccd_m.imag014_desc 
         
#抓成本阶
   SELECT DISTINCT xcbb006 INTO g_xccd_m.xcbb006
     FROM xcbb_t
    WHERE xcbbent  = g_enterprise
      AND xcbbcomp = g_xccd_m.xccdcomp
      AND xcbb001  = g_xccd_m.xccd004
      AND xcbb002  = g_xccd_m.xccd005
      AND xcbb003  = g_xccd_m.xccd007   #不写特性，因为相同料号不同特性的xcbb成本阶一样的cbb成本阶一样的
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccdcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccdcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccdcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccdld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccdld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccdld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccd003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccd003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccd003_desc
      
   
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........: #150319-00004#11
# Usage..........: CALL axcq701_x01_tmp()
# Date & Author..: 150506 By Jessy
################################################################################
PRIVATE FUNCTION axcq701_x01_tmp()
   #150319-00004#11-----s      
   #建立臨時表     
   DROP TABLE axcq701_x01_tmp;
   CREATE TEMP TABLE axcq701_x01_tmp(
      l_xccdcomp_desc          LIKE type_t.chr500,        #法人組織
      l_xccd004_xccd005_desc   LIKE type_t.chr500,        #年度期別  
      l_xccdld_desc            LIKE type_t.chr500,        #帳套 
      xccd006                  LIKE xccd_t.xccd006,       #工單編號
      l_xccd003_desc           LIKE type_t.chr500,        #成本計算類型
      l_xccd007_desc           LIKE type_t.chr500,        #主件料號
      l_imag014_desc           LIKE type_t.chr500,        #成本單位
      l_xccd002_desc           LIKE type_t.chr500,        #成本域
      l_sfaa048_desc           LIKE type_t.chr500,        #結案日期
      xccd009                  LIKE xccd_t.xccd009,       #批號
      xcbb006                  LIKE type_t.num5,          #成本階
      xccd200                  LIKE type_t.num20_6,       #本期投入工時 
      xcde008                  LIKE xcde_t.xcde008,       #特性
      l_xcau003_desc           LIKE type_t.chr500,        #成本主要素
      xcde010                  LIKE xcde_t.xcde010,       #成本次要素
      l_xcde010_desc           LIKE type_t.chr500,        #說明
      xcde101                  LIKE xcde_t.xcde101,       #期初數量
      xcde102                  LIKE xcde_t.xcde102,       #期初成本
      xcde201                  LIKE xcde_t.xcde201,       #本期投入數量
      xcde202                  LIKE xcde_t.xcde202,       #本期投入成本
      xcde301                  LIKE xcde_t.xcde301,       #本期轉出數量
      xcde302                  LIKE xcde_t.xcde302,       #本期轉出成本
      xcde303                  LIKE xcde_t.xcde303,       #差異轉出數量
      xcde304                  LIKE xcde_t.xcde304,       #差異轉出成本
      xcde901                  LIKE xcde_t.xcde901,       #期末數量
      xcde902                  LIKE xcde_t.xcde902        #期末成本
   )
   #150319-00004#11-----e
END FUNCTION

################################################################################
# Descriptions...: 填充臨時表資料
# Memo...........: #150319-00004#11
# Usage..........: CALL axcq701_insert_temp()
# Date & Author..: 150506 By Jessy
################################################################################
PRIVATE FUNCTION axcq701_insert_tmp()
   #150319-00004#11-----s
   #XG報表用的temp
   DEFINE l_i               LIKE type_t.num10
   DEFINE l_x01_tmp         RECORD
      l_xccdcomp_desc          LIKE type_t.chr500,        #法人組織
      l_xccd004_xccd005_desc   LIKE type_t.chr500,        #年度期別  
      l_xccdld_desc            LIKE type_t.chr500,        #帳套 
      xccd006                  LIKE xccd_t.xccd006,       #工單編號
      l_xccd003_desc           LIKE type_t.chr500,        #成本計算類型
      l_xccd007_desc           LIKE type_t.chr500,        #主件料號
      l_imag014_desc           LIKE type_t.chr500,        #成本單位
      l_xccd002_desc           LIKE type_t.chr500,        #成本域
      l_sfaa048_desc           LIKE type_t.chr500,        #結案日期
      xccd009                  LIKE xccd_t.xccd009,       #批號
      xcbb006                  LIKE type_t.num5,          #成本階
      xccd200                  LIKE type_t.num20_6,       #本期投入工時 
      xcde008                  LIKE xcde_t.xcde008,       #特性
      l_xcau003_desc           LIKE type_t.chr500,        #成本主要素
      xcde010                  LIKE xcde_t.xcde010,       #成本次要素
      l_xcde010_desc           LIKE type_t.chr500,        #說明
      xcde101                  LIKE xcde_t.xcde101,       #期初數量
      xcde102                  LIKE xcde_t.xcde102,       #期初成本
      xcde201                  LIKE xcde_t.xcde201,       #本期投入數量
      xcde202                  LIKE xcde_t.xcde202,       #本期投入成本
      xcde301                  LIKE xcde_t.xcde301,       #本期轉出數量
      xcde302                  LIKE xcde_t.xcde302,       #本期轉出成本
      xcde303                  LIKE xcde_t.xcde303,       #差異轉出數量
      xcde304                  LIKE xcde_t.xcde304,       #差異轉出成本
      xcde901                  LIKE xcde_t.xcde901,       #期末數量
      xcde902                  LIKE xcde_t.xcde902        #期末成本
   END RECORD

   #依畫面資料INSERT XG_tmp 
   DELETE FROM axcq701_x01_tmp
   FOR l_i = 1 TO g_xcde_d.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.l_xccdcomp_desc           = g_xccd_m.xccdcomp,":",g_xccd_m.xccdcomp_desc #法人組織
      LET l_x01_tmp.l_xccd004_xccd005_desc    = g_xccd_m.xccd004,":",g_xccd_m.xccd005        #年度期別  
      LET l_x01_tmp.l_xccdld_desc             = g_xccd_m.xccdld,":",g_xccd_m.xccdld_desc     #帳套 
      LET l_x01_tmp.xccd006                   = g_xccd_m.xccd006                             #工單編號
      LET l_x01_tmp.l_xccd003_desc            = g_xccd_m.xccd003,":",g_xccd_m.xccd003_desc   #成本計算類型
      LET l_x01_tmp.l_xccd007_desc            = g_xccd_m.xccd007                             #主件料號
      LET l_x01_tmp.l_imag014_desc            = g_xccd_m.imag014,":",g_xccd_m.imag014_desc   #成本單位
      LET l_x01_tmp.l_xccd002_desc            = g_xccd_m.xccd002,":",g_xccd_m.xccd002_desc   #成本域
      LET l_x01_tmp.l_sfaa048_desc            = g_xccd_m.sfaa048                             #結案日期
      LET l_x01_tmp.xccd009                   = g_xccd_m.xccd009                             #批號
      LET l_x01_tmp.xcbb006                   = g_xccd_m.xcbb006                             #成本階
      LET l_x01_tmp.xccd200                   = g_xccd_m.xccd200                             #本期投入工時 
      LET l_x01_tmp.xcde008                   = g_xcde_d[l_i].xcde008                        #特性
      
      IF NOT cl_null(g_xcde_d[l_i].xcau003) THEN
         LET l_x01_tmp.l_xcau003_desc         = g_xcde_d[l_i].xcau003,":",s_desc_gzcbl004_desc('8901',g_xcde_d[l_i].xcau003)  #成本主要素
      ELSE
         LET l_x01_tmp.l_xcau003_desc         = ""
      END IF
      
      LET l_x01_tmp.xcde010                   = g_xcde_d[l_i].xcde010                        #成本次要素
      LET l_x01_tmp.l_xcde010_desc            = g_xcde_d[l_i].xcde010_desc                   #說明
      LET l_x01_tmp.xcde101                   = g_xcde_d[l_i].xcde101                        #期初數量
      LET l_x01_tmp.xcde102                   = g_xcde_d[l_i].xcde102                        #期初成本
      LET l_x01_tmp.xcde201                   = g_xcde_d[l_i].xcde201                        #本期投入數量
      LET l_x01_tmp.xcde202                   = g_xcde_d[l_i].xcde202                        #本期投入成本
      LET l_x01_tmp.xcde301                   = g_xcde_d[l_i].xcde301                        #本期轉出數量
      LET l_x01_tmp.xcde302                   = g_xcde_d[l_i].xcde302                        #本期轉出成本
      LET l_x01_tmp.xcde303                   = g_xcde_d[l_i].xcde303                        #差異轉出數量
      LET l_x01_tmp.xcde304                   = g_xcde_d[l_i].xcde304                        #差異轉出成本
      LET l_x01_tmp.xcde901                   = g_xcde_d[l_i].xcde901                        #期末數量
      LET l_x01_tmp.xcde902                   = g_xcde_d[l_i].xcde902	                     #期末成本
      INSERT INTO axcq701_x01_tmp VALUES(l_x01_tmp.*)
   END FOR 
   #150319-00004#11-----e
END FUNCTION

 
{</section>}
 
