#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq541.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000013
#+ 
#+ Filename...: axcq541
#+ Description: 工單在製累計投入和轉出查詢作業
#+ Creator....: 00537(2015-03-17 10:36:08)
#+ Modifier...: 00537(2015-03-18 11:08:28) -SD/PR- 05599
 
{</section>}
 
{<section id="axcq541.global" >}
#應用 t01 樣板自動產生(Version:25)
# 151130-00003#18  15/11/30  By Sarah     增加單身二次過濾功能
#160318-00025#9    16/04/21  By 07675     將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160520-00004#5    16/05/23  By dorislai  效能改善-報表
#160802-00020#4    16/08/04  By dorislai  增加帳套權限管控
#160802-00020#10   16/08/11  By dorislai  增加法人權限管控
#170218-00009#1    17/02/18  By charles4m 1.將新增按鈕失效 2.補上INNER JOIN xccd_t 及 INNER JOIN xcch_t的ENT條件
        
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xccd_m        RECORD
       xccdcomp LIKE xccd_t.xccdcomp, 
   xccdcomp_desc LIKE type_t.chr80, 
   xccdld LIKE xccd_t.xccdld, 
   xccdld_desc LIKE type_t.chr80, 
   xccd004 LIKE xccd_t.xccd004, 
   xccd005 LIKE xccd_t.xccd005, 
   xccd001 LIKE xccd_t.xccd001, 
   xccd001_desc LIKE type_t.chr80, 
   xccd003 LIKE xccd_t.xccd003, 
   xccd003_desc LIKE type_t.chr80, 
   xccd002 LIKE xccd_t.xccd002, 
   xccd002_desc LIKE type_t.chr80, 
   xccd006 LIKE xccd_t.xccd006, 
   sfaa019 LIKE type_t.chr80, 
   sfaa020 LIKE type_t.chr80, 
   xccd007 LIKE xccd_t.xccd007, 
   sfaa012 LIKE type_t.num20_6, 
   sfaa049 LIKE type_t.num20_6, 
   xccd007_desc LIKE type_t.chr80, 
   xccd301_sum LIKE type_t.num20_6, 
   xccd301 LIKE xccd_t.xccd301, 
   xccd007_desc_1 LIKE type_t.chr80, 
   xcbk100 LIKE type_t.num20_6, 
   xcbk100_1 LIKE type_t.num20_6,
   chk       LIKE type_t.chr1    #wujie 150419
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcce_d        RECORD
       xcce002 LIKE xcce_t.xcce002, 
   xcce002_desc LIKE type_t.chr500, 
   xcce007 LIKE xcce_t.xcce007, 
   xcce007_desc LIKE type_t.chr500, 
   xcce007_desc_1 LIKE type_t.chr500, 
   xcce008 LIKE xcce_t.xcce008, 
   xcce009 LIKE xcce_t.xcce009, 
   xcbb005 LIKE type_t.chr500, 
   xcbb005_desc LIKE type_t.chr500, 
   xcce201 LIKE xcce_t.xcce201, 
   xcce202a LIKE xcce_t.xcce202a, 
   xcce202b LIKE xcce_t.xcce202b, 
   xcce202c LIKE xcce_t.xcce202c, 
   xcce202d LIKE xcce_t.xcce202d, 
   xcce202e LIKE xcce_t.xcce202e, 
   xcce202f LIKE xcce_t.xcce202f, 
   xcce202g LIKE xcce_t.xcce202g, 
   xcce202h LIKE xcce_t.xcce202h, 
   xcce202 LIKE xcce_t.xcce202, 
   xcce301_sum LIKE xcce_t.xcce301, 
   xcce302a_sum LIKE xcce_t.xcce302a, 
   xcce302b_sum LIKE xcce_t.xcce302b, 
   xcce302c_sum LIKE xcce_t.xcce302c, 
   xcce302d_sum LIKE xcce_t.xcce302d, 
   xcce302e_sum LIKE xcce_t.xcce302e, 
   xcce302f_sum LIKE xcce_t.xcce302f, 
   xcce302g_sum LIKE xcce_t.xcce302g, 
   xcce302h_sum LIKE xcce_t.xcce302h, 
   xcce302_sum LIKE xcce_t.xcce302, 
   xcce301 LIKE xcce_t.xcce301, 
   xcce302a LIKE xcce_t.xcce302a, 
   xcce302b LIKE xcce_t.xcce302b, 
   xcce302c LIKE xcce_t.xcce302c, 
   xcce302d LIKE xcce_t.xcce302d, 
   xcce302e LIKE xcce_t.xcce302e, 
   xcce302f LIKE xcce_t.xcce302f, 
   xcce302g LIKE xcce_t.xcce302g, 
   xcce302h LIKE xcce_t.xcce302h, 
   xcce302 LIKE xcce_t.xcce302,
   xcce_price LIKE xccc_t.xccc280,          
   xcce_conv_rate LIKE type_t.num26_10,    #wujie 150416
   xcce_conv_price LIKE xccc_t.xccc280,    #wujie 150416
   xcce303 LIKE xcce_t.xcce303, 
   xcce304a LIKE xcce_t.xcce304a, 
   xcce304b LIKE xcce_t.xcce304b, 
   xcce304c LIKE xcce_t.xcce304c, 
   xcce304d LIKE xcce_t.xcce304d, 
   xcce304e LIKE xcce_t.xcce304e, 
   xcce304f LIKE xcce_t.xcce304f, 
   xcce304g LIKE xcce_t.xcce304g, 
   xcce304h LIKE xcce_t.xcce304h, 
   xcce304 LIKE xcce_t.xcce304, 
   xcce901 LIKE xcce_t.xcce901, 
   xcce902a LIKE xcce_t.xcce902a, 
   xcce902b LIKE xcce_t.xcce902b, 
   xcce902c LIKE xcce_t.xcce902c, 
   xcce902d LIKE xcce_t.xcce902d, 
   xcce902e LIKE xcce_t.xcce902e, 
   xcce902f LIKE xcce_t.xcce902f, 
   xcce902g LIKE xcce_t.xcce902g, 
   xcce902h LIKE xcce_t.xcce902h, 
   xcce902 LIKE xcce_t.xcce902
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_xccd_m          type_g_xccd_m
DEFINE g_xccd_m_t        type_g_xccd_m
DEFINE g_xccd_m_o        type_g_xccd_m
 
   DEFINE g_xccdld_t LIKE xccd_t.xccdld
DEFINE g_xccd004_t LIKE xccd_t.xccd004
DEFINE g_xccd005_t LIKE xccd_t.xccd005
DEFINE g_xccd001_t LIKE xccd_t.xccd001
DEFINE g_xccd003_t LIKE xccd_t.xccd003
DEFINE g_xccd002_t LIKE xccd_t.xccd002
DEFINE g_xccd006_t LIKE xccd_t.xccd006
 
 
DEFINE g_xcce_d          DYNAMIC ARRAY OF type_g_xcce_d
DEFINE g_xcce_d_t        type_g_xcce_d
DEFINE g_xcce_d_o        type_g_xcce_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_xccdld LIKE xccd_t.xccdld,
      b_xccd001 LIKE xccd_t.xccd001,
      b_xccd002 LIKE xccd_t.xccd002,
      b_xccd003 LIKE xccd_t.xccd003,
      b_xccd004 LIKE xccd_t.xccd004,
      b_xccd005 LIKE xccd_t.xccd005,
      b_xccd006 LIKE xccd_t.xccd006
      END RECORD 
      
DEFINE g_browser_f  RECORD #資料瀏覽之欄位 
       b_statepic     LIKE type_t.chr50,
          b_xccdld LIKE xccd_t.xccdld,
      b_xccd001 LIKE xccd_t.xccd001,
      b_xccd002 LIKE xccd_t.xccd002,
      b_xccd003 LIKE xccd_t.xccd003,
      b_xccd004 LIKE xccd_t.xccd004,
      b_xccd005 LIKE xccd_t.xccd005,
      b_xccd006 LIKE xccd_t.xccd006
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
DEFINE g_rec_b               LIKE type_t.num10 #5           
DEFINE l_ac                  LIKE type_t.num10 #5    
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num10 #5           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
DEFINE g_detail_cnt          LIKE type_t.num10 #5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10 #5              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10 #5              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10 #5              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10 #5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10 #5              #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10 #5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10 #5              #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_wc_xcch             STRING
DEFINE g_wc2_xcci_table1     STRING
DEFINE g_wc2_xcci            STRING
DEFINE g_sql_tmp             STRING
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axcq541.main" >}
#應用 a26 樣板自動產生(Version:3)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define
   
   #end add-point   
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT xccdcomp,'',xccdld,'',xccd004,xccd005,xccd001,'',xccd003,'',xccd002,'', 
       xccd006,'','',xccd007,'','','','',xccd301,'','',''", 
                      " FROM xccd_t",
                      " WHERE xccdent= ? AND xccdld=? AND xccd001=? AND xccd002=? AND xccd003=? AND  
                          xccd004=? AND xccd005=? AND xccd006=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq541_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xccdcomp,t0.xccdld,t0.xccd004,t0.xccd005,t0.xccd001,t0.xccd003,t0.xccd002, 
       t0.xccd006,t0.xccd007,t0.xccd301,t5.xcbfl003 ,t6.imaal003",
               " FROM xccd_t t0",
                              " LEFT JOIN xcbfl_t t5 ON t5.xcbflent='"||g_enterprise||"' AND t5.xcbfl001=t0.xccd002 AND t5.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t6 ON t6.imaalent='"||g_enterprise||"' AND t6.imaal001=t0.xccd007 AND t6.imaal002='"||g_dlang||"' ",
 
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND t0.xccdld = ? AND t0.xccd001 = ? AND t0.xccd002 = ? AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ? AND t0.xccd006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   #160802-00020#4-mod-(S)
#   LET g_sql = " SELECT UNIQUE t0.xccdcomp,t0.xccdld,t0.xccd004,t0.xccd005,t0.xccd001,t0.xccd003,t0.xccd002,", 
#               "               t0.xccd006,t0.xccd007,t0.xccd301,t5.xcbfl003 ,t6.imaal003",
#               " FROM xccd_t t0",
#               " LEFT JOIN xcbfl_t t5 ON t5.xcbflent='"||g_enterprise||"' AND t5.xcbfl001=t0.xccd002 AND t5.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t6 ON t6.imaalent='"||g_enterprise||"' AND t6.imaal001=t0.xccd007 AND t6.imaal002='"||g_dlang||"' ", 
#               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND t0.xccdld = ? AND t0.xccd001 = ? AND t0.xccd002 = ? AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ? AND t0.xccd006 = ?",
#               " UNION ",
#               " SELECT UNIQUE t7.xcchcomp,t7.xcchld,t7.xcch004,t7.xcch005,t7.xcch001,t7.xcch003,t7.xcch002,", 
#               "               t7.xcch006,t7.xcch007,t7.xcch301,t8.xcbfl003 ,t9.imaal003",
#               " FROM xcch_t t7",
#               " LEFT JOIN xcbfl_t t8 ON t8.xcbflent='"||g_enterprise||"' AND t8.xcbfl001=t7.xcch002 AND t8.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t9 ON t9.imaalent='"||g_enterprise||"' AND t9.imaal001=t7.xcch007 AND t9.imaal002='"||g_dlang||"' ", 
#               " WHERE t7.xcchent = '" ||g_enterprise|| "' AND t7.xcchld = ? AND t7.xcch001 = ? AND t7.xcch002 = ? AND t7.xcch003 = ? AND t7.xcch004 = ? AND t7.xcch005 = ? AND t7.xcch006 = ?"
   LET g_sql = " SELECT UNIQUE t0.xccdcomp,t0.xccdld,t0.xccd004,t0.xccd005,t0.xccd001,t0.xccd003,t0.xccd002,", 
               "               t0.xccd006,t0.xccd007,t0.xccd301,t5.xcbfl003 ,t6.imaal003",
               " FROM xccd_t t0",
               " LEFT JOIN xcbfl_t t5 ON t5.xcbflent='"||g_enterprise||"' AND t5.xcbfl001=t0.xccd002 AND t5.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t6 ON t6.imaalent='"||g_enterprise||"' AND t6.imaal001=t0.xccd007 AND t6.imaal002='"||g_dlang||"' ", 
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND t0.xccdld = ? AND t0.xccd001 = ? AND t0.xccd002 = ? AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ? AND t0.xccd006 = ?"
   #---帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql CLIPPED," AND t0.xccdld IN ",g_wc_cs_ld
   END IF 
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xccdcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   LET g_sql = g_sql CLIPPED," UNION ",
               " SELECT UNIQUE t7.xcchcomp,t7.xcchld,t7.xcch004,t7.xcch005,t7.xcch001,t7.xcch003,t7.xcch002,", 
               "               t7.xcch006,t7.xcch007,t7.xcch301,t8.xcbfl003 ,t9.imaal003",
               " FROM xcch_t t7",
               " LEFT JOIN xcbfl_t t8 ON t8.xcbflent='"||g_enterprise||"' AND t8.xcbfl001=t7.xcch002 AND t8.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t9 ON t9.imaalent='"||g_enterprise||"' AND t9.imaal001=t7.xcch007 AND t9.imaal002='"||g_dlang||"' ", 
               " WHERE t7.xcchent = '" ||g_enterprise|| "' AND t7.xcchld = ? AND t7.xcch001 = ? AND t7.xcch002 = ? AND t7.xcch003 = ? AND t7.xcch004 = ? AND t7.xcch005 = ? AND t7.xcch006 = ?"
   #---帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t7.xcchld IN ",g_wc_cs_ld
   END IF 
   #160802-00020#4-mod-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t7.xcchcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE axcq541_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq541 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq541_init()   
 
      #進入選單 Menu (="N")
      CALL axcq541_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq541
      
   END IF 
   
   CLOSE axcq541_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="axcq541.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq541_init()
   #add-point:init段define
   
   #end add-point    
   #add-point:init段define
   
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
   
      CALL cl_set_combo_scc('xccd001','8914') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   #特性
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible('xcce008',FALSE)
   END IF
   #成本域
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc,xcce002,xcce002_desc',FALSE) 
   END IF
   #end add-point
   
   CALL axcq541_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq541.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq541_ui_dialog()
   DEFINE li_idx    LIKE type_t.num10 #5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define

   #end add-point
   #add-point:ui_dialog段define

   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:2)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL axcq541_insert()
            #add-point:ON ACTION insert

            #END add-point
         END IF
 
      #add-point:action default自訂

      #end add-point
      OTHERWISE
   END CASE
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE 
 
      IF g_action_choice = "logistics" THEN
 
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xccd_m.* TO NULL
         CALL g_xcce_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq541_init()
      END IF
 
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_xcce_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq541_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL axcq541_idx_chk()
               #add-point:page1自定義行為

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array

         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq541_browser_fill("")
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
               CALL axcq541_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq541_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axcq541_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2

        #151130-00003#18 -----(S)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq541_filter()
        #151130-00003#18 -----(E)
            #end add-point
 
 
 
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq541_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq541_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq541_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq541_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq541_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq541_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq541_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq541_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq541_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq541_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq541_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq541_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq541_idx_chk()
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcce_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel

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
    
         
         #應用 a43 樣板自動產生(Version:2)
        #170218-00009#1 ---mark (s)--- 因已變成freestyle，故需手動mark
        #ON ACTION insert
        #   LET g_action_choice="insert"
        #   IF cl_auth_chk_act("insert") THEN
        #      CALL axcq541_insert()
        #      #add-point:ON ACTION insert

        #      #END add-point
        #      
        #   END IF
        #170218-00009#1 ---mark (e)---
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               CALL axcq541_create_tmp()
               CALL axcq541_ins_tmp()
               CALL axcq541_x01(" 1=1",'axcq541_tmp')
               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq541_query()
               #add-point:ON ACTION query

               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               
            END IF
 
 
 
         
         #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL axcq541_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq541_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq541_set_pk_array()
            #add-point:ON ACTION followup

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
         #add-point:ui_dialog段離開dialog前

         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="axcq541.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq541_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   DEFINE l_wc_xcch         STRING
   DEFINE l_wc2_xcci        STRING
   #end add-point   
   #add-point:browser_fill段define

   #end add-point   
   
   #add-point:browser_fill段動作開始前

   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前
   IF cl_null(g_wc_xcch) THEN
      LET g_wc_xcch = " 1=1"
   END IF
   IF cl_null(g_wc2_xcci) THEN
      LET g_wc2_xcci = " 1=1"
   END IF
   LET l_wc_xcch  = g_wc_xcch.trim() 
   LET l_wc2_xcci = g_wc2_xcci.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006 ",
                      " FROM xccd_t ",
                      " ",
                      " LEFT JOIN xcce_t ON xcceent = xccdent AND xccdld = xcceld AND xccd001 = xcce001 AND xccd002 = xcce003 AND xccd003 = xcce004 AND xccd004 = xcce005 AND xccd005 = xcce006 ", "  ",
                      #add-point:browser_fill段sql(xcce_t1)

                      #end add-point
 
 
                      " ", 
                      " ", 
                      " WHERE xccdent = '" ||g_enterprise|| "' AND xcceent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006 ",
                      " FROM xccd_t ", 
                      "  ",
                      "  ",
                      " WHERE xccdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccd_t")
   END IF
   
   #add-point:browser_fill,cnt wc
   #160802-00020#4-mod-(S)
#   IF g_wc2 <> " 1=1" THEN
#      #單身有輸入搜尋條件                      
#      LET l_sub_sql = " SELECT UNIQUE xccdld xccdld,xccd001 xccd001,xccd002 xccd002,xccd003 xccd003,xccd004 xccd004,xccd005 xccd005,xccd006 xccd006 ",
#                      " FROM xccd_t ",
#                      " LEFT JOIN xcce_t ON xcceent = xccdent AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 AND xccd006 = xcce006 ",
#                      " WHERE xccdent = '" ||g_enterprise|| "' AND xcceent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t"),
#                      " UNION ",
#                      " SELECT UNIQUE xcchld xccdld,xcch001 xccd001,xcch002 xccd002,xcch003 xcch003,xcch004 xcch004,xcch005 xccd005,xcch006 xccd006 ",
#                      " FROM xcch_t ",
#                      " LEFT JOIN xcci_t ON xccient = xcchent AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 AND xcch006 = xcci006 ",
#                      " WHERE xcchent = '" ||g_enterprise|| "' AND xccient = '" ||g_enterprise|| "' AND ",l_wc_xcch, " AND ", l_wc2_xcci, cl_sql_add_filter("xcch_t")
#   ELSE
#      #單身未輸入搜尋條件
#      LET l_sub_sql = " SELECT UNIQUE xccdld xccdld,xccd001 xccd001,xccd002 xccd002,xccd003 xccd003,xccd004 xccd004,xccd005 xccd005,xccd006 xccd006 ",
#                      " FROM xccd_t ", 
#                      " WHERE xccdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccd_t"),
#                      " UNION ",
#                      " SELECT UNIQUE xcchld xccdld,xcch001 xccd001,xcch002 xccd002,xcch003 xcch003,xcch004 xcch004,xcch005 xccd005,xcch006 xccd006 ",
#                      " FROM xcch_t ", 
#                      " WHERE xcchent = '" ||g_enterprise|| "' AND ",l_wc_xcch CLIPPED, cl_sql_add_filter("xcch_t")
#   END IF
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xccdld xccdld,xccd001 xccd001,xccd002 xccd002,xccd003 xccd003,xccd004 xccd004,xccd005 xccd005,xccd006 xccd006 ",
                      " FROM xccd_t ",
                      " LEFT JOIN xcce_t ON xcceent = xccdent AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 AND xccd006 = xcce006 ",
                      " WHERE xccdent = '" ||g_enterprise|| "' AND xcceent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t")
      #---帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sub_sql = l_sub_sql CLIPPED," AND xccdld IN ",g_wc_cs_ld
      END IF
      #160802-00020#10-add-(S)
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET g_sql = g_sql," AND xccdcomp IN ",g_wc_cs_comp
      END IF
      #160802-00020#10-add-(E)
      LET l_sub_sql = l_sub_sql CLIPPED," UNION ",
                      " SELECT UNIQUE xcchld xccdld,xcch001 xccd001,xcch002 xccd002,xcch003 xcch003,xcch004 xcch004,xcch005 xccd005,xcch006 xccd006 ",
                      " FROM xcch_t ",
                      " LEFT JOIN xcci_t ON xccient = xcchent AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 AND xcch006 = xcci006 ",
                      " WHERE xcchent = '" ||g_enterprise|| "' AND xccient = '" ||g_enterprise|| "' AND ",l_wc_xcch, " AND ", l_wc2_xcci, cl_sql_add_filter("xcch_t")
      #---帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sub_sql = l_sub_sql , " AND xcchld IN ",g_wc_cs_ld
      END IF      
      #160802-00020#10-add-(S)
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET g_sql = g_sql," AND xcchcomp IN ",g_wc_cs_comp
      END IF
      #160802-00020#10-add-(E)      
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xccdld xccdld,xccd001 xccd001,xccd002 xccd002,xccd003 xccd003,xccd004 xccd004,xccd005 xccd005,xccd006 xccd006 ",
                      " FROM xccd_t ", 
                      " WHERE xccdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccd_t")
      #---帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sub_sql = l_sub_sql CLIPPED," AND xccdld IN ",g_wc_cs_ld
      END IF   
      #160802-00020#10-add-(S)
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET g_sql = g_sql," AND xccdcomp IN ",g_wc_cs_comp
      END IF
      #160802-00020#10-add-(E)      
      LET l_sub_sql = l_sub_sql CLIPPED," UNION ",
                      " SELECT UNIQUE xcchld xccdld,xcch001 xccd001,xcch002 xccd002,xcch003 xcch003,xcch004 xcch004,xcch005 xccd005,xcch006 xccd006 ",
                      " FROM xcch_t ", 
                      " WHERE xcchent = '" ||g_enterprise|| "' AND ",l_wc_xcch CLIPPED, cl_sql_add_filter("xcch_t")
      #---帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET l_sub_sql = l_sub_sql , " AND xcchld IN ",g_wc_cs_ld
      END IF    
      #160802-00020#10-add-(S)
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET g_sql = g_sql," AND xcchcomp IN ",g_wc_cs_comp
      END IF
     #160802-00020#10-add-(E)      
   END IF
   #160802-00020#4-mod-(E)

   #end add-point
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前

   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
    
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
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_xccd_m.* TO NULL
      CALL g_xcce_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理

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
 
               

              
 
 
             
               
 

 
 
 
   #add-point:browser_fill,before_prepare
   #160802-00020#4-mod-(S)
#   LET g_sql = " SELECT UNIQUE '',xccdld xccdld,xccd001 xccd001,xccd002 xccd002,xccd003 xccd003,xccd004 xccd004,xccd005 xccd005,xccd006 xccd006 ",
#               " FROM xccd_t ",
#               " LEFT JOIN xcce_t ON xcceent = xccdent AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 AND xccd006 = xcce006 ",
#               " WHERE xccdent = '" ||g_enterprise|| "' AND xcceent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t"),
#               " UNION ",
#               " SELECT UNIQUE '',xcchld xccdld,xcch001 xccd001,xcch002 xccd002,xcch003 xcch003,xcch004 xcch004,xcch005 xccd005,xcch006 xccd006 ",
#               " FROM xcch_t ",
#               " LEFT JOIN xcci_t ON xccient = xcchent AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 AND xcch006 = xcci006 ",
#               " WHERE xcchent = '" ||g_enterprise|| "' AND xccient = '" ||g_enterprise|| "' AND ",l_wc_xcch, " AND ", l_wc2_xcci, cl_sql_add_filter("xcch_t")
   LET g_sql = " SELECT UNIQUE '',xccdld xccdld,xccd001 xccd001,xccd002 xccd002,xccd003 xccd003,xccd004 xccd004,xccd005 xccd005,xccd006 xccd006 ",
               " FROM xccd_t ",
               " LEFT JOIN xcce_t ON xcceent = xccdent AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 AND xccd006 = xcce006 ",
               " WHERE xccdent = '" ||g_enterprise|| "' AND xcceent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t")
   #---帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql CLIPPED," AND xccdld IN ",g_wc_cs_ld
   END IF
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccdcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)   
   LET g_sql = g_sql CLIPPED," UNION ",
               " SELECT UNIQUE '',xcchld xccdld,xcch001 xccd001,xcch002 xccd002,xcch003 xcch003,xcch004 xcch004,xcch005 xccd005,xcch006 xccd006 ",
               " FROM xcch_t ",
               " LEFT JOIN xcci_t ON xccient = xcchent AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 AND xcch006 = xcci006 ",
               " WHERE xcchent = '" ||g_enterprise|| "' AND xccient = '" ||g_enterprise|| "' AND ",l_wc_xcch, " AND ", l_wc2_xcci, cl_sql_add_filter("xcch_t")
   #---帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcchld IN ",g_wc_cs_ld
   END IF 
   #160802-00020#4-mod-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xcchcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill段open cursor

   #end add-point
   
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xccdld,g_browser[g_cnt].b_xccd001, 
       g_browser[g_cnt].b_xccd002,g_browser[g_cnt].b_xccd003,g_browser[g_cnt].b_xccd004,g_browser[g_cnt].b_xccd005, 
       g_browser[g_cnt].b_xccd006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:browser_fill段reference

      #end add-point
  
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_browse THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
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
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前

   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq541_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_xccd_m.xccdld = g_browser[g_current_idx].b_xccdld   
   LET g_xccd_m.xccd001 = g_browser[g_current_idx].b_xccd001   
   LET g_xccd_m.xccd002 = g_browser[g_current_idx].b_xccd002   
   LET g_xccd_m.xccd003 = g_browser[g_current_idx].b_xccd003   
   LET g_xccd_m.xccd004 = g_browser[g_current_idx].b_xccd004   
   LET g_xccd_m.xccd005 = g_browser[g_current_idx].b_xccd005   
   LET g_xccd_m.xccd006 = g_browser[g_current_idx].b_xccd006   
 
   EXECUTE axcq541_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007, 
       g_xccd_m.xccd301,g_xccd_m.xccd002_desc,g_xccd_m.xccd007_desc
   CALL axcq541_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axcq541.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq541_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq541_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   #add-point:ui_browser_refresh段define
   
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
   
   #add-point:ui_browser_refresh段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq541_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   
   #end add-point    
   #add-point:cs段define
   
   #end add-point    
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xccd_m.* TO NULL
   CALL g_xcce_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccdcomp,xccdld,xccd004,xccd005,xccd001,xccd003,xccd002,xccd006,xccd007 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xccdcomp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccdcomp
            #add-point:ON ACTION controlp INFIELD xccdcomp
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
            DISPLAY g_qryparam.return1 TO xccdcomp  #顯示到畫面上
            NEXT FIELD xccdcomp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccdcomp
            #add-point:BEFORE FIELD xccdcomp
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccdcomp
            
            #add-point:AFTER FIELD xccdcomp
            
            #END add-point
            
 
         #Ctrlp:construct.c.xccdld
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccdld
            #add-point:ON ACTION controlp INFIELD xccdld
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
            DISPLAY g_qryparam.return1 TO xccdld  #顯示到畫面上
            NEXT FIELD xccdld                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccdld
            #add-point:BEFORE FIELD xccdld
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccdld
            
            #add-point:AFTER FIELD xccdld
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd004
            #add-point:BEFORE FIELD xccd004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd004
            
            #add-point:AFTER FIELD xccd004
            
            #END add-point
            
 
         #Ctrlp:construct.c.xccd004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd004
            #add-point:ON ACTION controlp INFIELD xccd004
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd005
            #add-point:BEFORE FIELD xccd005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd005
            
            #add-point:AFTER FIELD xccd005
            
            #END add-point
            
 
         #Ctrlp:construct.c.xccd005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd005
            #add-point:ON ACTION controlp INFIELD xccd005
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd001
            #add-point:BEFORE FIELD xccd001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd001
            
            #add-point:AFTER FIELD xccd001
            
            #END add-point
            
 
         #Ctrlp:construct.c.xccd001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd001
            #add-point:ON ACTION controlp INFIELD xccd001
            
            #END add-point
 
         #Ctrlp:construct.c.xccd003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd003
            #add-point:ON ACTION controlp INFIELD xccd003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd003  #顯示到畫面上
            NEXT FIELD xccd003                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd003
            #add-point:BEFORE FIELD xccd003
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd003
            
            #add-point:AFTER FIELD xccd003
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd002
            #add-point:BEFORE FIELD xccd002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd002
            
            #add-point:AFTER FIELD xccd002
            
            #END add-point
            
 
         #Ctrlp:construct.c.xccd002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd002
            #add-point:ON ACTION controlp INFIELD xccd002
            
            #END add-point
 
         #Ctrlp:construct.c.xccd006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd006
            #add-point:ON ACTION controlp INFIELD xccd006
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno_4()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd006  #顯示到畫面上
            NEXT FIELD xccd006                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd006
            #add-point:BEFORE FIELD xccd006
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd006
            
            #add-point:AFTER FIELD xccd006
            
            #END add-point
            
 
         #Ctrlp:construct.c.xccd007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd007
            #add-point:ON ACTION controlp INFIELD xccd007
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd007  #顯示到畫面上
            NEXT FIELD xccd007                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd007
            #add-point:BEFORE FIELD xccd007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd007
            
            #add-point:AFTER FIELD xccd007
            
            #END add-point
            
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xcce002,xcce007,xcce008,xcce009,xcce201,xcce202a,xcce202b,xcce202c,xcce202d, 
          xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e, 
          xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f, 
          xcce304g,xcce304h,xcce304,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g, 
          xcce902h,xcce902
           FROM s_detail1[1].xcce002,s_detail1[1].xcce007,s_detail1[1].xcce008,s_detail1[1].xcce009, 
               s_detail1[1].xcce201,s_detail1[1].xcce202a,s_detail1[1].xcce202b,s_detail1[1].xcce202c, 
               s_detail1[1].xcce202d,s_detail1[1].xcce202e,s_detail1[1].xcce202f,s_detail1[1].xcce202g, 
               s_detail1[1].xcce202h,s_detail1[1].xcce202,s_detail1[1].xcce301,s_detail1[1].xcce302a, 
               s_detail1[1].xcce302b,s_detail1[1].xcce302c,s_detail1[1].xcce302d,s_detail1[1].xcce302e, 
               s_detail1[1].xcce302f,s_detail1[1].xcce302g,s_detail1[1].xcce302h,s_detail1[1].xcce302, 
               s_detail1[1].xcce303,s_detail1[1].xcce304a,s_detail1[1].xcce304b,s_detail1[1].xcce304c, 
               s_detail1[1].xcce304d,s_detail1[1].xcce304e,s_detail1[1].xcce304f,s_detail1[1].xcce304g, 
               s_detail1[1].xcce304h,s_detail1[1].xcce304,s_detail1[1].xcce901,s_detail1[1].xcce902a, 
               s_detail1[1].xcce902b,s_detail1[1].xcce902c,s_detail1[1].xcce902d,s_detail1[1].xcce902e, 
               s_detail1[1].xcce902f,s_detail1[1].xcce902g,s_detail1[1].xcce902h,s_detail1[1].xcce902 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            DISPLAY ARRAY g_xcce_d TO s_detail1.*
               BEFORE DISPLAY
                  EXIT DISPLAY
            END DISPLAY
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce002
            #add-point:BEFORE FIELD xcce002
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce002
            
            #add-point:AFTER FIELD xcce002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce002
            #add-point:ON ACTION controlp INFIELD xcce002
            
            #END add-point
 
         #Ctrlp:construct.c.page1.xcce007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce007
            #add-point:ON ACTION controlp INFIELD xcce007
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce007  #顯示到畫面上
            NEXT FIELD xcce007                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce007
            #add-point:BEFORE FIELD xcce007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce007
            
            #add-point:AFTER FIELD xcce007
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce008
            #add-point:BEFORE FIELD xcce008
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce008
            
            #add-point:AFTER FIELD xcce008
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce008
            #add-point:ON ACTION controlp INFIELD xcce008
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce009
            #add-point:BEFORE FIELD xcce009
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce009
            
            #add-point:AFTER FIELD xcce009
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce009
            #add-point:ON ACTION controlp INFIELD xcce009
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce201
            #add-point:BEFORE FIELD xcce201
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce201
            
            #add-point:AFTER FIELD xcce201
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce201
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce201
            #add-point:ON ACTION controlp INFIELD xcce201
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202a
            #add-point:BEFORE FIELD xcce202a
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202a
            
            #add-point:AFTER FIELD xcce202a
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202a
            #add-point:ON ACTION controlp INFIELD xcce202a
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202b
            #add-point:BEFORE FIELD xcce202b
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202b
            
            #add-point:AFTER FIELD xcce202b
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202b
            #add-point:ON ACTION controlp INFIELD xcce202b
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202c
            #add-point:BEFORE FIELD xcce202c
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202c
            
            #add-point:AFTER FIELD xcce202c
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202c
            #add-point:ON ACTION controlp INFIELD xcce202c
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202d
            #add-point:BEFORE FIELD xcce202d
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202d
            
            #add-point:AFTER FIELD xcce202d
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202d
            #add-point:ON ACTION controlp INFIELD xcce202d
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202e
            #add-point:BEFORE FIELD xcce202e
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202e
            
            #add-point:AFTER FIELD xcce202e
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202e
            #add-point:ON ACTION controlp INFIELD xcce202e
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202f
            #add-point:BEFORE FIELD xcce202f
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202f
            
            #add-point:AFTER FIELD xcce202f
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202f
            #add-point:ON ACTION controlp INFIELD xcce202f
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202g
            #add-point:BEFORE FIELD xcce202g
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202g
            
            #add-point:AFTER FIELD xcce202g
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202g
            #add-point:ON ACTION controlp INFIELD xcce202g
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202h
            #add-point:BEFORE FIELD xcce202h
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202h
            
            #add-point:AFTER FIELD xcce202h
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202h
            #add-point:ON ACTION controlp INFIELD xcce202h
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202
            #add-point:BEFORE FIELD xcce202
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202
            
            #add-point:AFTER FIELD xcce202
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202
            #add-point:ON ACTION controlp INFIELD xcce202
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce301
            #add-point:BEFORE FIELD xcce301
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce301
            
            #add-point:AFTER FIELD xcce301
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce301
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce301
            #add-point:ON ACTION controlp INFIELD xcce301
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302a
            #add-point:BEFORE FIELD xcce302a
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302a
            
            #add-point:AFTER FIELD xcce302a
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302a
            #add-point:ON ACTION controlp INFIELD xcce302a
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302b
            #add-point:BEFORE FIELD xcce302b
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302b
            
            #add-point:AFTER FIELD xcce302b
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302b
            #add-point:ON ACTION controlp INFIELD xcce302b
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302c
            #add-point:BEFORE FIELD xcce302c
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302c
            
            #add-point:AFTER FIELD xcce302c
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302c
            #add-point:ON ACTION controlp INFIELD xcce302c
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302d
            #add-point:BEFORE FIELD xcce302d
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302d
            
            #add-point:AFTER FIELD xcce302d
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302d
            #add-point:ON ACTION controlp INFIELD xcce302d
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302e
            #add-point:BEFORE FIELD xcce302e
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302e
            
            #add-point:AFTER FIELD xcce302e
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302e
            #add-point:ON ACTION controlp INFIELD xcce302e
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302f
            #add-point:BEFORE FIELD xcce302f
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302f
            
            #add-point:AFTER FIELD xcce302f
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302f
            #add-point:ON ACTION controlp INFIELD xcce302f
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302g
            #add-point:BEFORE FIELD xcce302g
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302g
            
            #add-point:AFTER FIELD xcce302g
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302g
            #add-point:ON ACTION controlp INFIELD xcce302g
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302h
            #add-point:BEFORE FIELD xcce302h
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302h
            
            #add-point:AFTER FIELD xcce302h
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302h
            #add-point:ON ACTION controlp INFIELD xcce302h
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302
            #add-point:BEFORE FIELD xcce302
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302
            
            #add-point:AFTER FIELD xcce302
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302
            #add-point:ON ACTION controlp INFIELD xcce302
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce303
            #add-point:BEFORE FIELD xcce303
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce303
            
            #add-point:AFTER FIELD xcce303
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce303
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce303
            #add-point:ON ACTION controlp INFIELD xcce303
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304a
            #add-point:BEFORE FIELD xcce304a
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304a
            
            #add-point:AFTER FIELD xcce304a
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304a
            #add-point:ON ACTION controlp INFIELD xcce304a
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304b
            #add-point:BEFORE FIELD xcce304b
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304b
            
            #add-point:AFTER FIELD xcce304b
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304b
            #add-point:ON ACTION controlp INFIELD xcce304b
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304c
            #add-point:BEFORE FIELD xcce304c
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304c
            
            #add-point:AFTER FIELD xcce304c
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304c
            #add-point:ON ACTION controlp INFIELD xcce304c
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304d
            #add-point:BEFORE FIELD xcce304d
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304d
            
            #add-point:AFTER FIELD xcce304d
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304d
            #add-point:ON ACTION controlp INFIELD xcce304d
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304e
            #add-point:BEFORE FIELD xcce304e
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304e
            
            #add-point:AFTER FIELD xcce304e
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304e
            #add-point:ON ACTION controlp INFIELD xcce304e
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304f
            #add-point:BEFORE FIELD xcce304f
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304f
            
            #add-point:AFTER FIELD xcce304f
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304f
            #add-point:ON ACTION controlp INFIELD xcce304f
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304g
            #add-point:BEFORE FIELD xcce304g
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304g
            
            #add-point:AFTER FIELD xcce304g
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304g
            #add-point:ON ACTION controlp INFIELD xcce304g
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304h
            #add-point:BEFORE FIELD xcce304h
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304h
            
            #add-point:AFTER FIELD xcce304h
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304h
            #add-point:ON ACTION controlp INFIELD xcce304h
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304
            #add-point:BEFORE FIELD xcce304
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304
            
            #add-point:AFTER FIELD xcce304
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304
            #add-point:ON ACTION controlp INFIELD xcce304
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce901
            #add-point:BEFORE FIELD xcce901
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce901
            
            #add-point:AFTER FIELD xcce901
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce901
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce901
            #add-point:ON ACTION controlp INFIELD xcce901
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902a
            #add-point:BEFORE FIELD xcce902a
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902a
            
            #add-point:AFTER FIELD xcce902a
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902a
            #add-point:ON ACTION controlp INFIELD xcce902a
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902b
            #add-point:BEFORE FIELD xcce902b
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902b
            
            #add-point:AFTER FIELD xcce902b
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902b
            #add-point:ON ACTION controlp INFIELD xcce902b
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902c
            #add-point:BEFORE FIELD xcce902c
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902c
            
            #add-point:AFTER FIELD xcce902c
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902c
            #add-point:ON ACTION controlp INFIELD xcce902c
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902d
            #add-point:BEFORE FIELD xcce902d
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902d
            
            #add-point:AFTER FIELD xcce902d
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902d
            #add-point:ON ACTION controlp INFIELD xcce902d
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902e
            #add-point:BEFORE FIELD xcce902e
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902e
            
            #add-point:AFTER FIELD xcce902e
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902e
            #add-point:ON ACTION controlp INFIELD xcce902e
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902f
            #add-point:BEFORE FIELD xcce902f
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902f
            
            #add-point:AFTER FIELD xcce902f
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902f
            #add-point:ON ACTION controlp INFIELD xcce902f
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902g
            #add-point:BEFORE FIELD xcce902g
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902g
            
            #add-point:AFTER FIELD xcce902g
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902g
            #add-point:ON ACTION controlp INFIELD xcce902g
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902h
            #add-point:BEFORE FIELD xcce902h
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902h
            
            #add-point:AFTER FIELD xcce902h
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902h
            #add-point:ON ACTION controlp INFIELD xcce902h
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902
            #add-point:BEFORE FIELD xcce902
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902
            
            #add-point:AFTER FIELD xcce902
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902
            #add-point:ON ACTION controlp INFIELD xcce902
            
            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
#wujie 150419 --begin
      INPUT BY NAME g_xccd_m.chk
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
         ON CHANGE chk
            CALL cl_set_comp_visible('xcce201,xcce202,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce301_sum,xcce302_sum,xcce302a_sum,xcce302b_sum,xcce302c_sum,xcce302d_sum,xcce302e_sum,xcce302f_sum,xcce302g_sum,xcce302h_sum',TRUE) 
            IF g_xccd_m.chk = 'Y' THEN   #隐藏累计投入/转出
               CALL cl_set_comp_visible('xcce201,xcce202,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce301_sum,xcce302_sum,xcce302a_sum,xcce302b_sum,xcce302c_sum,xcce302d_sum,xcce302e_sum,xcce302f_sum,xcce302g_sum,xcce302h_sum',FALSE) 
            END IF         
         AFTER INPUT
      END INPUT
#wujie 150419 --end
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         CALL axcq541_default()
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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前
   LET g_wc_xcch = s_chr_replace(g_wc,'xccd','xcch',0) 
   LET g_wc2_xcci_table1 = s_chr_replace(g_wc2_table1,'xcce','xcci',0)
   LET g_wc2_xcci = g_wc2_xcci_table1
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq541_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point   
   #add-point:query段define
   
   #end add-point   
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_xcce_d.clear()
 
   
   #add-point:query段other
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axcq541_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axcq541_browser_fill("")
      CALL axcq541_fetch("")
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
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL axcq541_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL axcq541_fetch("F") 
      #顯示單身筆數
      CALL axcq541_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq541_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
#默认fetch不适用，又不能改，新写一个跳过去
   CALL axcq541_fetch1(p_flag)
   RETURN
   #end add-point    
   #add-point:fetch段define
   
   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
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
   EXECUTE axcq541_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007, 
       g_xccd_m.xccd301,g_xccd_m.xccd002_desc,g_xccd_m.xccd007_desc
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
   CALL axcq541_set_act_visible()   
   CALL axcq541_set_act_no_visible()
   
   #add-point:fetch段action控制
   
   #end add-point  
   
   
   
   #add-point:fetch結束前
   
   #end add-point
   
   #保存單頭舊值
   LET g_xccd_m_t.* = g_xccd_m.*
   LET g_xccd_m_o.* = g_xccd_m.*
   
   
   #重新顯示   
   CALL axcq541_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq541_insert()
   #add-point:insert段define
   
   #end add-point    
   #add-point:insert段define
   
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xcce_d.clear()   
 
 
   INITIALIZE g_xccd_m.* LIKE xccd_t.*             #DEFAULT 設定
   
   LET g_xccdld_t = NULL
   LET g_xccd001_t = NULL
   LET g_xccd002_t = NULL
   LET g_xccd003_t = NULL
   LET g_xccd004_t = NULL
   LET g_xccd005_t = NULL
   LET g_xccd006_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xccd_m.xccd001 = "1"
 
  
      #add-point:單頭預設值
      CALL axcq541_default() #dorislai-20151026-add
      #end add-point 
      
      #顯示狀態(stus)圖片
      
    
      CALL axcq541_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccd_m.* TO NULL
         INITIALIZE g_xcce_d TO NULL
 
         #add-point:取消新增後
         
         #end add-point 
         CALL axcq541_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xcce_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq541_set_act_visible()   
   CALL axcq541_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001
   LET g_xccd002_t = g_xccd_m.xccd002
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   LET g_xccd006_t = g_xccd_m.xccd006
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
                      " xccdld = '", g_xccd_m.xccdld, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001, "' "
                      ," AND xccd002 = '", g_xccd_m.xccd002, "' "
                      ," AND xccd003 = '", g_xccd_m.xccd003, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005, "' "
                      ," AND xccd006 = '", g_xccd_m.xccd006, "' "
 
                      
   #add-point:組合新增資料的條件後
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq541_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axcq541_cl
   
   CALL axcq541_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq541_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007, 
       g_xccd_m.xccd301,g_xccd_m.xccd002_desc,g_xccd_m.xccd007_desc
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld,g_xccd_m.xccdld_desc,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd001_desc,g_xccd_m.xccd003,g_xccd_m.xccd003_desc, 
       g_xccd_m.xccd002,g_xccd_m.xccd002_desc,g_xccd_m.xccd006,g_xccd_m.sfaa019,g_xccd_m.sfaa020,g_xccd_m.xccd007, 
       g_xccd_m.sfaa012,g_xccd_m.sfaa049,g_xccd_m.xccd007_desc,g_xccd_m.xccd301_sum,g_xccd_m.xccd301, 
       g_xccd_m.xccd007_desc_1,g_xccd_m.xcbk100,g_xccd_m.xcbk100_1
   
   #add-point:新增結束後
   
   #end add-point 
  
   #流程通知預埋點-I
   CALL axcq541_set_pk_array()
   CALL cl_flow_notify('','I')
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq541_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define
   
   #end add-point    
   #add-point:modify段define
   
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
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
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
   
   OPEN axcq541_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq541_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE axcq541_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq541_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007, 
       g_xccd_m.xccd301,g_xccd_m.xccd002_desc,g_xccd_m.xccd007_desc
   
   
   
   #add-point:modify段show之前
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL axcq541_show()
   #add-point:modify段show之後
   
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
      
      
      #add-point:modify段修改前
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      CALL axcq541_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後
      
      #end add-point
      
 
    
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xccd_m.* = g_xccd_m_t.*
         CALL axcq541_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xccd_m.xccdld != g_xccdld_t 
      OR g_xccd_m.xccd001 != g_xccd001_t 
      OR g_xccd_m.xccd002 != g_xccd002_t 
      OR g_xccd_m.xccd003 != g_xccd003_t 
      OR g_xccd_m.xccd004 != g_xccd004_t 
      OR g_xccd_m.xccd005 != g_xccd005_t 
      OR g_xccd_m.xccd006 != g_xccd006_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
         #更新單身key值
         UPDATE xcce_t SET xcceld = g_xccd_m.xccdld
                                       ,xcce001 = g_xccd_m.xccd001
                                       ,xcce003 = g_xccd_m.xccd003
                                       ,xcce004 = g_xccd_m.xccd004
                                       ,xcce005 = g_xccd_m.xccd005
                                       ,xcce006 = g_xccd_m.xccd006 
          WHERE xcceent = g_enterprise AND xcceld = g_xccdld_t
            AND xcce001 = g_xccd001_t
            AND xcce003 = g_xccd003_t
            AND xcce004 = g_xccd004_t
            AND xcce005 = g_xccd005_t
            AND xcce006 = g_xccd006_t
#         #end add-point
#         
#         #更新單身key值
#         UPDATE xcce_t SET xcceld = g_xccd_m.xccdld
#                                       ,xcce001 = g_xccd_m.xccd001
#                                       ,xcce003 = g_xccd_m.xccd002
#                                       ,xcce004 = g_xccd_m.xccd003
#                                       ,xcce005 = g_xccd_m.xccd004
#                                       ,xcce006 = g_xccd_m.xccd005
#                                       , = g_xccd_m.xccd006
# 
#          WHERE xcceent = g_enterprise AND xcceld = g_xccdld_t
#            AND xcce001 = g_xccd001_t
#            AND xcce003 = g_xccd002_t
#            AND xcce004 = g_xccd003_t
#            AND xcce005 = g_xccd004_t
#            AND xcce006 = g_xccd005_t
#            AND  = g_xccd006_t
# 
#            
#         #add-point:單身fk修改中
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcce_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcce_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq541_set_act_visible()   
   CALL axcq541_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
                      " xccdld = '", g_xccd_m.xccdld, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001, "' "
                      ," AND xccd002 = '", g_xccd_m.xccd002, "' "
                      ," AND xccd003 = '", g_xccd_m.xccd003, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005, "' "
                      ," AND xccd006 = '", g_xccd_m.xccd006, "' "
 
   #填到對應位置
   CALL axcq541_browser_fill("")
 
   CLOSE axcq541_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL axcq541_set_pk_array()
   CALL cl_flow_notify('','U')
 
END FUNCTION   
 
{</section>}
 
{<section id="axcq541.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq541_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10 #5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10 #5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num10 #5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num10 #5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10 #5
   DEFINE  l_i                   LIKE type_t.num10 #5
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
   #add-point:input段define
   
   #end add-point  
   #add-point:input段define
   
   #end add-point  
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld,g_xccd_m.xccdld_desc,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd001_desc,g_xccd_m.xccd003,g_xccd_m.xccd003_desc, 
       g_xccd_m.xccd002,g_xccd_m.xccd002_desc,g_xccd_m.xccd006,g_xccd_m.sfaa019,g_xccd_m.sfaa020,g_xccd_m.xccd007, 
       g_xccd_m.sfaa012,g_xccd_m.sfaa049,g_xccd_m.xccd007_desc,g_xccd_m.xccd301_sum,g_xccd_m.xccd301, 
       g_xccd_m.xccd007_desc_1,g_xccd_m.xcbk100,g_xccd_m.xcbk100_1
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT xcce002,xcce007,xcce008,xcce009,xcce201,xcce202a,xcce202b,xcce202c,xcce202d, 
       xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e, 
       xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f, 
       xcce304g,xcce304h,xcce304,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g, 
       xcce902h,xcce902 FROM xcce_t WHERE xcceent=? AND xcceld=? AND xcce001=? AND xcce003=? AND xcce004=?  
       AND xcce005=? AND xcce006=? AND xcce002=? AND xcce007=? AND xcce008=? AND xcce009=? FOR UPDATE" 
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq541_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq541_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL axcq541_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001, 
       g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq541.input.head" >}
      #單頭段
      INPUT BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001, 
          g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axcq541_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axcq541_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE axcq541_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            CALL axcq541_set_entry(p_cmd)
            #add-point:資料輸入前
            
            #end add-point
            CALL axcq541_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccdcomp
            
            #add-point:AFTER FIELD xccdcomp
            IF NOT cl_null(g_xccd_m.xccdcomp) THEN 
#應用 a19 樣板自動產生(Version:2)
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
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccdcomp
            #add-point:BEFORE FIELD xccdcomp
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccdcomp
            #add-point:ON CHANGE xccdcomp
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccdld
            
            #add-point:AFTER FIELD xccdld
            IF NOT cl_null(g_xccd_m.xccdld) THEN 
#應用 a19 樣板自動產生(Version:2)
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

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccdld
            #add-point:BEFORE FIELD xccdld
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccdld
            #add-point:ON CHANGE xccdld
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd004
            #add-point:BEFORE FIELD xccd004
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd004
            
            #add-point:AFTER FIELD xccd004
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccd004
            #add-point:ON CHANGE xccd004
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd005
            #add-point:BEFORE FIELD xccd005
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd005
            
            #add-point:AFTER FIELD xccd005
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccd005
            #add-point:ON CHANGE xccd005
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd001
            
            #add-point:AFTER FIELD xccd001
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccd_m.xccd001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND =? ","") RETURNING g_rtn_fields
            LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccd001_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd001
            #add-point:BEFORE FIELD xccd001
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccd001
            #add-point:ON CHANGE xccd001
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd003
            
            #add-point:AFTER FIELD xccd003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccd_m.xccd003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccd_m.xccd003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccd003_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd003
            #add-point:BEFORE FIELD xccd003
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccd003
            #add-point:ON CHANGE xccd003
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd002
            
            #add-point:AFTER FIELD xccd002
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccd_m.xccd002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccd_m.xccd002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccd002_desc

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd002
            #add-point:BEFORE FIELD xccd002
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccd002
            #add-point:ON CHANGE xccd002
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd006
            #add-point:BEFORE FIELD xccd006
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd006
            
            #add-point:AFTER FIELD xccd006
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccd006
            #add-point:ON CHANGE xccd006
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xccd007
            
            #add-point:AFTER FIELD xccd007
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccd_m.xccd007
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccd_m.xccd007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccd007_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xccd007
            #add-point:BEFORE FIELD xccd007
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xccd007
            #add-point:ON CHANGE xccd007
            
            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.xccdcomp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccdcomp
            #add-point:ON ACTION controlp INFIELD xccdcomp
            #應用 a07 樣板自動產生(Version:2)   
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
 
         #Ctrlp:input.c.xccdld
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccdld
            #add-point:ON ACTION controlp INFIELD xccdld
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccd_m.xccdld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xccd_m.xccdld = g_qryparam.return1              

            DISPLAY g_xccd_m.xccdld TO xccdld              #

            NEXT FIELD xccdld                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.xccd004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd004
            #add-point:ON ACTION controlp INFIELD xccd004
            
            #END add-point
 
         #Ctrlp:input.c.xccd005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd005
            #add-point:ON ACTION controlp INFIELD xccd005
            
            #END add-point
 
         #Ctrlp:input.c.xccd001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd001
            #add-point:ON ACTION controlp INFIELD xccd001
            
            #END add-point
 
         #Ctrlp:input.c.xccd003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd003
            #add-point:ON ACTION controlp INFIELD xccd003
            
            #END add-point
 
         #Ctrlp:input.c.xccd002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd002
            #add-point:ON ACTION controlp INFIELD xccd002
            
            #END add-point
 
         #Ctrlp:input.c.xccd006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd006
            #add-point:ON ACTION controlp INFIELD xccd006
            
            #END add-point
 
         #Ctrlp:input.c.xccd007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xccd007
            #add-point:ON ACTION controlp INFIELD xccd007
            
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
                        
            #add-point:單頭INPUT後
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
               
               #end add-point
               
               INSERT INTO xccd_t (xccdent,xccdcomp,xccdld,xccd004,xccd005,xccd001,xccd003,xccd002,xccd006, 
                   xccd007,xccd301)
               VALUES (g_enterprise,g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005, 
                   g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007, 
                   g_xccd_m.xccd301) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xccd_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq541_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axcq541_b_fill()
               END IF
               
               #add-point:單頭新增後
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
               
               #end add-point
               
               UPDATE xccd_t SET (xccdcomp,xccdld,xccd004,xccd005,xccd001,xccd003,xccd002,xccd006,xccd007, 
                   xccd301) = (g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001, 
                   g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007,g_xccd_m.xccd301) 
 
                WHERE xccdent = g_enterprise AND xccdld = g_xccdld_t
                  AND xccd001 = g_xccd001_t
                  AND xccd002 = g_xccd002_t
                  AND xccd003 = g_xccd003_t
                  AND xccd004 = g_xccd004_t
                  AND xccd005 = g_xccd005_t
                  AND xccd006 = g_xccd006_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xccd_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中
               
               #end add-point
               
               
               
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_xccd_m_t)
               LET g_log2 = util.JSON.stringify(g_xccd_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後
               
               #end add-point
            END IF
            
            LET g_xccdld_t = g_xccd_m.xccdld
            LET g_xccd001_t = g_xccd_m.xccd001
            LET g_xccd002_t = g_xccd_m.xccd002
            LET g_xccd003_t = g_xccd_m.xccd003
            LET g_xccd004_t = g_xccd_m.xccd004
            LET g_xccd005_t = g_xccd_m.xccd005
            LET g_xccd006_t = g_xccd_m.xccd006
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axcq541.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcce_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前

            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcce_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq541_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xcce_d.getLength()
            #add-point:資料輸入前

            #end add-point
         
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
            OPEN axcq541_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axcq541_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE axcq541_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_xcce_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcce_d[l_ac].xcce002 IS NOT NULL
               AND g_xcce_d[l_ac].xcce007 IS NOT NULL
               AND g_xcce_d[l_ac].xcce008 IS NOT NULL
               AND g_xcce_d[l_ac].xcce009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcce_d_t.* = g_xcce_d[l_ac].*  #BACKUP
               LET g_xcce_d_o.* = g_xcce_d[l_ac].*  #BACKUP
               CALL axcq541_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL axcq541_set_no_entry_b(l_cmd)
               IF NOT axcq541_lock_b("xcce_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq541_bcl INTO g_xcce_d[l_ac].xcce002,g_xcce_d[l_ac].xcce007,g_xcce_d[l_ac].xcce008, 
                      g_xcce_d[l_ac].xcce009,g_xcce_d[l_ac].xcce201,g_xcce_d[l_ac].xcce202a,g_xcce_d[l_ac].xcce202b, 
                      g_xcce_d[l_ac].xcce202c,g_xcce_d[l_ac].xcce202d,g_xcce_d[l_ac].xcce202e,g_xcce_d[l_ac].xcce202f, 
                      g_xcce_d[l_ac].xcce202g,g_xcce_d[l_ac].xcce202h,g_xcce_d[l_ac].xcce202,g_xcce_d[l_ac].xcce301, 
                      g_xcce_d[l_ac].xcce302a,g_xcce_d[l_ac].xcce302b,g_xcce_d[l_ac].xcce302c,g_xcce_d[l_ac].xcce302d, 
                      g_xcce_d[l_ac].xcce302e,g_xcce_d[l_ac].xcce302f,g_xcce_d[l_ac].xcce302g,g_xcce_d[l_ac].xcce302h, 
                      g_xcce_d[l_ac].xcce302,g_xcce_d[l_ac].xcce303,g_xcce_d[l_ac].xcce304a,g_xcce_d[l_ac].xcce304b, 
                      g_xcce_d[l_ac].xcce304c,g_xcce_d[l_ac].xcce304d,g_xcce_d[l_ac].xcce304e,g_xcce_d[l_ac].xcce304f, 
                      g_xcce_d[l_ac].xcce304g,g_xcce_d[l_ac].xcce304h,g_xcce_d[l_ac].xcce304,g_xcce_d[l_ac].xcce901, 
                      g_xcce_d[l_ac].xcce902a,g_xcce_d[l_ac].xcce902b,g_xcce_d[l_ac].xcce902c,g_xcce_d[l_ac].xcce902d, 
                      g_xcce_d[l_ac].xcce902e,g_xcce_d[l_ac].xcce902f,g_xcce_d[l_ac].xcce902g,g_xcce_d[l_ac].xcce902h, 
                      g_xcce_d[l_ac].xcce902
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xcce_d_t.xcce002 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL axcq541_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcce_d[l_ac].* TO NULL 
            INITIALIZE g_xcce_d_t.* TO NULL 
            INITIALIZE g_xcce_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份

            #end add-point
            LET g_xcce_d_t.* = g_xcce_d[l_ac].*     #新輸入資料
            LET g_xcce_d_o.* = g_xcce_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq541_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL axcq541_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcce_d[li_reproduce_target].* = g_xcce_d[li_reproduce].*
 
               LET g_xcce_d[li_reproduce_target].xcce002 = NULL
               LET g_xcce_d[li_reproduce_target].xcce007 = NULL
               LET g_xcce_d[li_reproduce_target].xcce008 = NULL
               LET g_xcce_d[li_reproduce_target].xcce009 = NULL
 
            END IF
            
            #add-point:modify段before insert

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
            SELECT COUNT(*) INTO l_count FROM xcce_t 
             WHERE xcceent = g_enterprise AND xcceld = g_xccd_m.xccdld
               AND xcce001 = g_xccd_m.xccd001
               AND xcce003 = g_xccd_m.xccd003
               AND xcce004 = g_xccd_m.xccd004
               AND xcce005 = g_xccd_m.xccd005
               AND xcce006 = g_xccd_m.xccd006 
               AND xcce002 = g_xcce_d[l_ac].xcce002
               AND xcce007 = g_xcce_d[l_ac].xcce007
               AND xcce008 = g_xcce_d[l_ac].xcce008
               AND xcce009 = g_xcce_d[l_ac].xcce009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

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
               LET gs_keys[8] = g_xcce_d[g_detail_idx].xcce002
               LET gs_keys[9] = g_xcce_d[g_detail_idx].xcce007
               LET gs_keys[10] = g_xcce_d[g_detail_idx].xcce008
               LET gs_keys[11] = g_xcce_d[g_detail_idx].xcce009
               CALL axcq541_insert_b('xcce_t',gs_keys,"'1'")
                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xcce_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcce_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axcq541_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d)

               #end add-point
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
               
               #add-point:單身刪除前

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
 
               LET gs_keys[gs_keys.getLength()+1] = g_xcce_d_t.xcce002
               LET gs_keys[gs_keys.getLength()+1] = g_xcce_d_t.xcce007
               LET gs_keys[gs_keys.getLength()+1] = g_xcce_d_t.xcce008
               LET gs_keys[gs_keys.getLength()+1] = g_xcce_d_t.xcce009
 
            
               #刪除同層單身
               IF NOT axcq541_delete_b('xcce_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axcq541_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axcq541_key_delete_b(gs_keys,'xcce_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axcq541_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
               
               #add-point:單身刪除中

               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axcq541_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後

               #end add-point
               LET l_count = g_xcce_d.getLength()
               
               #add-point:單身刪除後(<>d)

               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xcce_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce002
            
            #add-point:AFTER FIELD xcce002
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcce_d[l_ac].xcce002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcce_d[l_ac].xcce002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcce_d[l_ac].xcce002_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce002
            #add-point:BEFORE FIELD xcce002

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce002
            #add-point:ON CHANGE xcce002

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce007
            
            #add-point:AFTER FIELD xcce007
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce007 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce008 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcce_d[g_detail_idx].xcce007 != g_xcce_d_t.xcce007 OR g_xcce_d[g_detail_idx].xcce008 != g_xcce_d_t.xcce008 OR g_xcce_d[g_detail_idx].xcce009 != g_xcce_d_t.xcce009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcce_t WHERE "||"xcceent = '" ||g_enterprise|| "' AND "||"xcceld = '"||g_xccd_m.xccdld ||"' AND "|| "xcce001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcce002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcce003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcce004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcce005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcce006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcce007 = '"||g_xcce_d[g_detail_idx].xcce007 ||"' AND "|| "xcce008 = '"||g_xcce_d[g_detail_idx].xcce008 ||"' AND "|| "xcce009 = '"||g_xcce_d[g_detail_idx].xcce009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcce_d[l_ac].xcce007
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcce_d[l_ac].xcce007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcce_d[l_ac].xcce007_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce007
            #add-point:BEFORE FIELD xcce007

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce007
            #add-point:ON CHANGE xcce007

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce008
            #add-point:BEFORE FIELD xcce008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce008
            
            #add-point:AFTER FIELD xcce008
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce007 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce008 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcce_d[g_detail_idx].xcce007 != g_xcce_d_t.xcce007 OR g_xcce_d[g_detail_idx].xcce008 != g_xcce_d_t.xcce008 OR g_xcce_d[g_detail_idx].xcce009 != g_xcce_d_t.xcce009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcce_t WHERE "||"xcceent = '" ||g_enterprise|| "' AND "||"xcceld = '"||g_xccd_m.xccdld ||"' AND "|| "xcce001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcce002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcce003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcce004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcce005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcce006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcce007 = '"||g_xcce_d[g_detail_idx].xcce007 ||"' AND "|| "xcce008 = '"||g_xcce_d[g_detail_idx].xcce008 ||"' AND "|| "xcce009 = '"||g_xcce_d[g_detail_idx].xcce009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce008
            #add-point:ON CHANGE xcce008

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce009
            #add-point:BEFORE FIELD xcce009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce009
            
            #add-point:AFTER FIELD xcce009
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce007 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce008 IS NOT NULL AND g_xcce_d[g_detail_idx].xcce009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcce_d[g_detail_idx].xcce007 != g_xcce_d_t.xcce007 OR g_xcce_d[g_detail_idx].xcce008 != g_xcce_d_t.xcce008 OR g_xcce_d[g_detail_idx].xcce009 != g_xcce_d_t.xcce009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcce_t WHERE "||"xcceent = '" ||g_enterprise|| "' AND "||"xcceld = '"||g_xccd_m.xccdld ||"' AND "|| "xcce001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcce002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcce003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcce004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcce005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcce006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcce007 = '"||g_xcce_d[g_detail_idx].xcce007 ||"' AND "|| "xcce008 = '"||g_xcce_d[g_detail_idx].xcce008 ||"' AND "|| "xcce009 = '"||g_xcce_d[g_detail_idx].xcce009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce009
            #add-point:ON CHANGE xcce009

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce201
            #add-point:BEFORE FIELD xcce201

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce201
            
            #add-point:AFTER FIELD xcce201

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce201
            #add-point:ON CHANGE xcce201

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202a
            #add-point:BEFORE FIELD xcce202a

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202a
            
            #add-point:AFTER FIELD xcce202a

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202a
            #add-point:ON CHANGE xcce202a

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202b
            #add-point:BEFORE FIELD xcce202b

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202b
            
            #add-point:AFTER FIELD xcce202b

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202b
            #add-point:ON CHANGE xcce202b

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202c
            #add-point:BEFORE FIELD xcce202c

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202c
            
            #add-point:AFTER FIELD xcce202c

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202c
            #add-point:ON CHANGE xcce202c

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202d
            #add-point:BEFORE FIELD xcce202d

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202d
            
            #add-point:AFTER FIELD xcce202d

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202d
            #add-point:ON CHANGE xcce202d

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202e
            #add-point:BEFORE FIELD xcce202e

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202e
            
            #add-point:AFTER FIELD xcce202e

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202e
            #add-point:ON CHANGE xcce202e

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202f
            #add-point:BEFORE FIELD xcce202f

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202f
            
            #add-point:AFTER FIELD xcce202f

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202f
            #add-point:ON CHANGE xcce202f

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202g
            #add-point:BEFORE FIELD xcce202g

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202g
            
            #add-point:AFTER FIELD xcce202g

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202g
            #add-point:ON CHANGE xcce202g

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202h
            #add-point:BEFORE FIELD xcce202h

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202h
            
            #add-point:AFTER FIELD xcce202h

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202h
            #add-point:ON CHANGE xcce202h

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce202
            #add-point:BEFORE FIELD xcce202

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce202
            
            #add-point:AFTER FIELD xcce202

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce202
            #add-point:ON CHANGE xcce202

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce301
            #add-point:BEFORE FIELD xcce301

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce301
            
            #add-point:AFTER FIELD xcce301

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce301
            #add-point:ON CHANGE xcce301

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302a
            #add-point:BEFORE FIELD xcce302a

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302a
            
            #add-point:AFTER FIELD xcce302a

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302a
            #add-point:ON CHANGE xcce302a

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302b
            #add-point:BEFORE FIELD xcce302b

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302b
            
            #add-point:AFTER FIELD xcce302b

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302b
            #add-point:ON CHANGE xcce302b

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302c
            #add-point:BEFORE FIELD xcce302c

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302c
            
            #add-point:AFTER FIELD xcce302c

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302c
            #add-point:ON CHANGE xcce302c

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302d
            #add-point:BEFORE FIELD xcce302d

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302d
            
            #add-point:AFTER FIELD xcce302d

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302d
            #add-point:ON CHANGE xcce302d

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302e
            #add-point:BEFORE FIELD xcce302e

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302e
            
            #add-point:AFTER FIELD xcce302e

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302e
            #add-point:ON CHANGE xcce302e

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302f
            #add-point:BEFORE FIELD xcce302f

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302f
            
            #add-point:AFTER FIELD xcce302f

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302f
            #add-point:ON CHANGE xcce302f

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302g
            #add-point:BEFORE FIELD xcce302g

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302g
            
            #add-point:AFTER FIELD xcce302g

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302g
            #add-point:ON CHANGE xcce302g

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302h
            #add-point:BEFORE FIELD xcce302h

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302h
            
            #add-point:AFTER FIELD xcce302h

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302h
            #add-point:ON CHANGE xcce302h

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce302
            #add-point:BEFORE FIELD xcce302

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce302
            
            #add-point:AFTER FIELD xcce302

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce302
            #add-point:ON CHANGE xcce302

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce303
            #add-point:BEFORE FIELD xcce303

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce303
            
            #add-point:AFTER FIELD xcce303

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce303
            #add-point:ON CHANGE xcce303

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304a
            #add-point:BEFORE FIELD xcce304a

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304a
            
            #add-point:AFTER FIELD xcce304a

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304a
            #add-point:ON CHANGE xcce304a

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304b
            #add-point:BEFORE FIELD xcce304b

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304b
            
            #add-point:AFTER FIELD xcce304b

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304b
            #add-point:ON CHANGE xcce304b

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304c
            #add-point:BEFORE FIELD xcce304c

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304c
            
            #add-point:AFTER FIELD xcce304c

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304c
            #add-point:ON CHANGE xcce304c

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304d
            #add-point:BEFORE FIELD xcce304d

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304d
            
            #add-point:AFTER FIELD xcce304d

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304d
            #add-point:ON CHANGE xcce304d

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304e
            #add-point:BEFORE FIELD xcce304e

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304e
            
            #add-point:AFTER FIELD xcce304e

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304e
            #add-point:ON CHANGE xcce304e

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304f
            #add-point:BEFORE FIELD xcce304f

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304f
            
            #add-point:AFTER FIELD xcce304f

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304f
            #add-point:ON CHANGE xcce304f

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304g
            #add-point:BEFORE FIELD xcce304g

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304g
            
            #add-point:AFTER FIELD xcce304g

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304g
            #add-point:ON CHANGE xcce304g

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304h
            #add-point:BEFORE FIELD xcce304h

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304h
            
            #add-point:AFTER FIELD xcce304h

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304h
            #add-point:ON CHANGE xcce304h

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce304
            #add-point:BEFORE FIELD xcce304

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce304
            
            #add-point:AFTER FIELD xcce304

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce304
            #add-point:ON CHANGE xcce304

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce901
            #add-point:BEFORE FIELD xcce901

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce901
            
            #add-point:AFTER FIELD xcce901

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce901
            #add-point:ON CHANGE xcce901

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902a
            #add-point:BEFORE FIELD xcce902a

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902a
            
            #add-point:AFTER FIELD xcce902a

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902a
            #add-point:ON CHANGE xcce902a

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902b
            #add-point:BEFORE FIELD xcce902b

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902b
            
            #add-point:AFTER FIELD xcce902b

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902b
            #add-point:ON CHANGE xcce902b

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902c
            #add-point:BEFORE FIELD xcce902c

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902c
            
            #add-point:AFTER FIELD xcce902c

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902c
            #add-point:ON CHANGE xcce902c

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902d
            #add-point:BEFORE FIELD xcce902d

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902d
            
            #add-point:AFTER FIELD xcce902d

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902d
            #add-point:ON CHANGE xcce902d

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902e
            #add-point:BEFORE FIELD xcce902e

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902e
            
            #add-point:AFTER FIELD xcce902e

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902e
            #add-point:ON CHANGE xcce902e

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902f
            #add-point:BEFORE FIELD xcce902f

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902f
            
            #add-point:AFTER FIELD xcce902f

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902f
            #add-point:ON CHANGE xcce902f

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902g
            #add-point:BEFORE FIELD xcce902g

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902g
            
            #add-point:AFTER FIELD xcce902g

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902g
            #add-point:ON CHANGE xcce902g

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902h
            #add-point:BEFORE FIELD xcce902h

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902h
            
            #add-point:AFTER FIELD xcce902h

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902h
            #add-point:ON CHANGE xcce902h

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcce902
            #add-point:BEFORE FIELD xcce902

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcce902
            
            #add-point:AFTER FIELD xcce902

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcce902
            #add-point:ON CHANGE xcce902

            #END add-point 
 
 
                  #Ctrlp:input.c.page1.xcce002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce002
            #add-point:ON ACTION controlp INFIELD xcce002

            #END add-point
 
         #Ctrlp:input.c.page1.xcce007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce007
            #add-point:ON ACTION controlp INFIELD xcce007

            #END add-point
 
         #Ctrlp:input.c.page1.xcce008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce008
            #add-point:ON ACTION controlp INFIELD xcce008

            #END add-point
 
         #Ctrlp:input.c.page1.xcce009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce009
            #add-point:ON ACTION controlp INFIELD xcce009

            #END add-point
 
         #Ctrlp:input.c.page1.xcce201
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce201
            #add-point:ON ACTION controlp INFIELD xcce201

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202a
            #add-point:ON ACTION controlp INFIELD xcce202a

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202b
            #add-point:ON ACTION controlp INFIELD xcce202b

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202c
            #add-point:ON ACTION controlp INFIELD xcce202c

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202d
            #add-point:ON ACTION controlp INFIELD xcce202d

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202e
            #add-point:ON ACTION controlp INFIELD xcce202e

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202f
            #add-point:ON ACTION controlp INFIELD xcce202f

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202g
            #add-point:ON ACTION controlp INFIELD xcce202g

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202h
            #add-point:ON ACTION controlp INFIELD xcce202h

            #END add-point
 
         #Ctrlp:input.c.page1.xcce202
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce202
            #add-point:ON ACTION controlp INFIELD xcce202

            #END add-point
 
         #Ctrlp:input.c.page1.xcce301
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce301
            #add-point:ON ACTION controlp INFIELD xcce301

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302a
            #add-point:ON ACTION controlp INFIELD xcce302a

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302b
            #add-point:ON ACTION controlp INFIELD xcce302b

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302c
            #add-point:ON ACTION controlp INFIELD xcce302c

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302d
            #add-point:ON ACTION controlp INFIELD xcce302d

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302e
            #add-point:ON ACTION controlp INFIELD xcce302e

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302f
            #add-point:ON ACTION controlp INFIELD xcce302f

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302g
            #add-point:ON ACTION controlp INFIELD xcce302g

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302h
            #add-point:ON ACTION controlp INFIELD xcce302h

            #END add-point
 
         #Ctrlp:input.c.page1.xcce302
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce302
            #add-point:ON ACTION controlp INFIELD xcce302

            #END add-point
 
         #Ctrlp:input.c.page1.xcce303
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce303
            #add-point:ON ACTION controlp INFIELD xcce303

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304a
            #add-point:ON ACTION controlp INFIELD xcce304a

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304b
            #add-point:ON ACTION controlp INFIELD xcce304b

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304c
            #add-point:ON ACTION controlp INFIELD xcce304c

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304d
            #add-point:ON ACTION controlp INFIELD xcce304d

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304e
            #add-point:ON ACTION controlp INFIELD xcce304e

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304f
            #add-point:ON ACTION controlp INFIELD xcce304f

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304g
            #add-point:ON ACTION controlp INFIELD xcce304g

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304h
            #add-point:ON ACTION controlp INFIELD xcce304h

            #END add-point
 
         #Ctrlp:input.c.page1.xcce304
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce304
            #add-point:ON ACTION controlp INFIELD xcce304

            #END add-point
 
         #Ctrlp:input.c.page1.xcce901
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce901
            #add-point:ON ACTION controlp INFIELD xcce901

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902a
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902a
            #add-point:ON ACTION controlp INFIELD xcce902a

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902b
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902b
            #add-point:ON ACTION controlp INFIELD xcce902b

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902c
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902c
            #add-point:ON ACTION controlp INFIELD xcce902c

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902d
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902d
            #add-point:ON ACTION controlp INFIELD xcce902d

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902e
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902e
            #add-point:ON ACTION controlp INFIELD xcce902e

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902f
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902f
            #add-point:ON ACTION controlp INFIELD xcce902f

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902g
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902g
            #add-point:ON ACTION controlp INFIELD xcce902g

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902h
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902h
            #add-point:ON ACTION controlp INFIELD xcce902h

            #END add-point
 
         #Ctrlp:input.c.page1.xcce902
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcce902
            #add-point:ON ACTION controlp INFIELD xcce902

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xcce_d[l_ac].* = g_xcce_d_t.*
               CLOSE axcq541_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcce_d[l_ac].xcce002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcce_d[l_ac].* = g_xcce_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE xcce_t SET (xcceld,xcce001,xcce002,xcce003,xcce004,xcce005,xcce006,xcce007,xcce008, 
                   xcce009,xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h, 
                   xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h, 
                   xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h, 
                   xcce304,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h, 
                   xcce902) = (g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004, 
                   g_xccd_m.xccd005,g_xccd_m.xccd006,g_xcce_d[l_ac].xcce007,g_xcce_d[l_ac].xcce008, 
                   g_xcce_d[l_ac].xcce009,g_xcce_d[l_ac].xcce201,g_xcce_d[l_ac].xcce202a,g_xcce_d[l_ac].xcce202b, 
                   g_xcce_d[l_ac].xcce202c,g_xcce_d[l_ac].xcce202d,g_xcce_d[l_ac].xcce202e,g_xcce_d[l_ac].xcce202f, 
                   g_xcce_d[l_ac].xcce202g,g_xcce_d[l_ac].xcce202h,g_xcce_d[l_ac].xcce202,g_xcce_d[l_ac].xcce301, 
                   g_xcce_d[l_ac].xcce302a,g_xcce_d[l_ac].xcce302b,g_xcce_d[l_ac].xcce302c,g_xcce_d[l_ac].xcce302d, 
                   g_xcce_d[l_ac].xcce302e,g_xcce_d[l_ac].xcce302f,g_xcce_d[l_ac].xcce302g,g_xcce_d[l_ac].xcce302h, 
                   g_xcce_d[l_ac].xcce302,g_xcce_d[l_ac].xcce303,g_xcce_d[l_ac].xcce304a,g_xcce_d[l_ac].xcce304b, 
                   g_xcce_d[l_ac].xcce304c,g_xcce_d[l_ac].xcce304d,g_xcce_d[l_ac].xcce304e,g_xcce_d[l_ac].xcce304f, 
                   g_xcce_d[l_ac].xcce304g,g_xcce_d[l_ac].xcce304h,g_xcce_d[l_ac].xcce304,g_xcce_d[l_ac].xcce901, 
                   g_xcce_d[l_ac].xcce902a,g_xcce_d[l_ac].xcce902b,g_xcce_d[l_ac].xcce902c,g_xcce_d[l_ac].xcce902d, 
                   g_xcce_d[l_ac].xcce902e,g_xcce_d[l_ac].xcce902f,g_xcce_d[l_ac].xcce902g,g_xcce_d[l_ac].xcce902h, 
                   g_xcce_d[l_ac].xcce902)
                WHERE xcceent = g_enterprise AND xcceld = g_xccd_m.xccdld 
                  AND xcce001 = g_xccd_m.xccd001 
                  AND xcce003 = g_xccd_m.xccd003 
                  AND xcce004 = g_xccd_m.xccd004 
                  AND xcce005 = g_xccd_m.xccd005 
                  AND xcce006 = g_xccd_m.xccd006 
                  AND xcce002 = g_xcce_d_t.xcce002 #項次   
                  AND xcce007 = g_xcce_d_t.xcce007  
                  AND xcce008 = g_xcce_d_t.xcce008  
                  AND xcce009 = g_xcce_d_t.xcce009  
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcce_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xcce_d[l_ac].* = g_xcce_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcce_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_xcce_d[l_ac].* = g_xcce_d_t.*  
                  OTHERWISE
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
               LET gs_keys[8] = g_xcce_d[g_detail_idx].xcce002
               LET gs_keys_bak[8] = g_xcce_d_t.xcce002
               LET gs_keys[9] = g_xcce_d[g_detail_idx].xcce007
               LET gs_keys_bak[9] = g_xcce_d_t.xcce007
               LET gs_keys[10] = g_xcce_d[g_detail_idx].xcce008
               LET gs_keys_bak[10] = g_xcce_d_t.xcce008
               LET gs_keys[11] = g_xcce_d[g_detail_idx].xcce009
               LET gs_keys_bak[11] = g_xcce_d_t.xcce009
               CALL axcq541_update_b('xcce_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
 
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xcce_d[g_detail_idx].xcce002 = g_xcce_d_t.xcce002 
                  AND g_xcce_d[g_detail_idx].xcce007 = g_xcce_d_t.xcce007 
                  AND g_xcce_d[g_detail_idx].xcce008 = g_xcce_d_t.xcce008 
                  AND g_xcce_d[g_detail_idx].xcce009 = g_xcce_d_t.xcce009 
 
                  ) THEN
                  LET gs_keys[01] = g_xccd_m.xccdld
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd001
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd002
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd003
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd004
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd005
                  LET gs_keys[gs_keys.getLength()+1] = g_xccd_m.xccd006
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcce_d_t.xcce002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcce_d_t.xcce007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcce_d_t.xcce008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcce_d_t.xcce009
 
                  CALL axcq541_key_update_b(gs_keys,'xcce_t')
               END IF
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcce_d_t)
               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcce_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row

            #end add-point
            CALL axcq541_unlock_b("xcce_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2

            #end add-point
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_xcce_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcce_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="axcq541.input.other" >}
      
      #add-point:自定義input
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field
            
            #end add-point  
            NEXT FIELD xccdld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcce002
 
               #add-point:input段modify_detail 
               
               #end add-point  
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
         #add-point:input段accept 
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
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
    
   #add-point:input段after input 
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq541_show()
   DEFINE l_ac_t    LIKE type_t.num10 #5
   #add-point:show段define
   DEFINE l_glaa001    LIKE glaa_t.glaa001
   DEFINE l_glaa016    LIKE glaa_t.glaa016
   DEFINE l_glaa020    LIKE glaa_t.glaa020
   #end add-point  
   #add-point:show段define
   
   #end add-point  
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axcq541_b_fill() #單身填充
      CALL axcq541_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL axcq541_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
#工单编号带出的开工日期，完工日期，预计生产数量，已发料套数
   SELECT sfaa012,sfaa019,sfaa020,sfaa049 
     INTO g_xccd_m.sfaa012,g_xccd_m.sfaa019,g_xccd_m.sfaa020,g_xccd_m.sfaa049
     FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaadocno = g_xccd_m.xccd006
   DISPLAY BY NAME g_xccd_m.sfaa012,g_xccd_m.sfaa019,g_xccd_m.sfaa020,g_xccd_m.sfaa049

#法人，账套，本位币顺序，成本计算类型
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
   
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccd_m.xccdld
           
   CASE g_xccd_m.xccd001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''                  
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''
   END CASE  

#累计入库数量
   SELECT SUM(xccd301) INTO g_xccd_m.xccd301_sum
     FROM xccd_t
    WHERE xccdent=g_enterprise 
      AND xccdld =g_xccd_m.xccdld 
      AND xccd001=g_xccd_m.xccd001 
      AND xccd002=g_xccd_m.xccd002 
      AND xccd003=g_xccd_m.xccd003 
      AND (xccd004*12+xccd005)<=(g_xccd_m.xccd004*12+g_xccd_m.xccd005) 
      AND xccd006=g_xccd_m.xccd006

   IF g_xccd_m.xccd301_sum IS NULL OR g_xccd_m.xccd301_sum = 0 THEN
      SELECT SUM(xcch301) INTO g_xccd_m.xccd301_sum
        FROM xcch_t
       WHERE xcchent=g_enterprise 
         AND xcchld =g_xccd_m.xccdld 
         AND xcch001=g_xccd_m.xccd001 
         AND xcch002=g_xccd_m.xccd002 
         AND xcch003=g_xccd_m.xccd003 
         AND (xcch004*12+xcch005)<=(g_xccd_m.xccd004*12+g_xccd_m.xccd005) 
         AND xcch006=g_xccd_m.xccd006
   END IF
   IF g_xccd_m.xccd301_sum IS NULL THEN LET g_xccd_m.xccd301_sum = 0 END IF
#累计投入工时
   SELECT SUM(xcbk100) INTO g_xccd_m.xcbk100
     FROM xcbk_t
    WHERE xcbkent = g_enterprise
      AND xcbkld  = g_xccd_m.xccdld
      AND xcbk001 = g_xccd_m.xccd003
      AND (xcbk002*12+xcbk003) <= (g_xccd_m.xccd004*12+g_xccd_m.xccd005)
      AND xcbk005 = '1'
      AND xcbk006 = g_xccd_m.xccd006
      
#本期投入工时
   SELECT SUM(xcbk100) INTO g_xccd_m.xcbk100_1
     FROM xcbk_t
    WHERE xcbkent = g_enterprise
      AND xcbkld  = g_xccd_m.xccdld
      AND xcbk001 = g_xccd_m.xccd003
      AND xcbk002 = g_xccd_m.xccd004
      AND xcbk003 = g_xccd_m.xccd005
      AND xcbk005 = '1'
      AND xcbk006 = g_xccd_m.xccd006

   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld,g_xccd_m.xccdld_desc,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd001_desc,g_xccd_m.xccd003,g_xccd_m.xccd003_desc, 
       g_xccd_m.xccd002,g_xccd_m.xccd002_desc,g_xccd_m.xccd006,g_xccd_m.sfaa019,g_xccd_m.sfaa020,g_xccd_m.xccd007, 
       g_xccd_m.sfaa012,g_xccd_m.sfaa049,g_xccd_m.xccd007_desc,g_xccd_m.xccd301_sum,g_xccd_m.xccd301, 
       g_xccd_m.xccd007_desc_1,g_xccd_m.xcbk100,g_xccd_m.xcbk100_1
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcce_d.getLength()
      #add-point:show段單身reference
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axcq541_detail_show()
   
   #add-point:show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axcq541_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
   #add-point:detail_show段define
   
   #end add-point  
   
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq541_reproduce()
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
 
   DEFINE l_master    RECORD LIKE xccd_t.*
   DEFINE l_detail    RECORD LIKE xcce_t.*
 
 
   DEFINE l_cnt       LIKE type_t.num10 #5
   #add-point:reproduce段define
   
   #end add-point   
   #add-point:reproduce段define
   
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
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
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
 
    
   CALL axcq541_set_entry('a')
   CALL axcq541_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
      LET g_xccd_m.xccdld_desc = ''
   DISPLAY BY NAME g_xccd_m.xccdld_desc
   LET g_xccd_m.xccd001_desc = ''
   DISPLAY BY NAME g_xccd_m.xccd001_desc
   LET g_xccd_m.xccd003_desc = ''
   DISPLAY BY NAME g_xccd_m.xccd003_desc
   LET g_xccd_m.xccd002_desc = ''
   DISPLAY BY NAME g_xccd_m.xccd002_desc
 
   
   CALL axcq541_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xccd_m.* TO NULL
      INITIALIZE g_xcce_d TO NULL
 
      #add-point:複製取消後
      
      #end add-point
      CALL axcq541_show()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq541_set_act_visible()   
   CALL axcq541_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001
   LET g_xccd002_t = g_xccd_m.xccd002
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   LET g_xccd006_t = g_xccd_m.xccd006
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
                      " xccdld = '", g_xccd_m.xccdld, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001, "' "
                      ," AND xccd002 = '", g_xccd_m.xccd002, "' "
                      ," AND xccd003 = '", g_xccd_m.xccd003, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005, "' "
                      ," AND xccd006 = '", g_xccd_m.xccd006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq541_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
   
   #end add-point
   
   CALL axcq541_idx_chk()
 
   #流程通知預埋點-R
   CALL axcq541_set_pk_array()
   CALL cl_flow_notify('','R')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq541_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcce_t.*
 
 
   #add-point:delete段define

   #end add-point    
   #add-point:delete段define

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq541_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq541_detail AS ",
                "SELECT * FROM xcce_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axcq541_detail SELECT * FROM xcce_t 
                                         WHERE xcceent = g_enterprise AND xcceld = g_xccdld_t
                                         AND xcce001 = g_xccd001_t
                                         AND xcce003 = g_xccd003_t
                                         AND xcce004 = g_xccd004_t
                                         AND xcce005 = g_xccd005_t
                                         AND xcce006 = g_xccd006_t
 
 
   
   #將key修正為調整後   
   UPDATE axcq541_detail 
      #更新key欄位
      SET xcceld = g_xccd_m.xccdld
          , xcce001 = g_xccd_m.xccd001
          , xcce003 = g_xccd_m.xccd003
          , xcce004 = g_xccd_m.xccd004
          , xcce005 = g_xccd_m.xccd005
          , xcce006 = g_xccd_m.xccd006
 
 
      #更新共用欄位
      
 
   #add-point:單身修改前

   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xcce_t SELECT * FROM axcq541_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axcq541_detail
   
   #add-point:單身複製後1

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
 
{<section id="axcq541.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq541_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   #add-point:delete段define

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
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axcq541_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq541_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE axcq541_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq541_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006 INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007, 
       g_xccd_m.xccd301,g_xccd_m.xccd002_desc,g_xccd_m.xccd007_desc
   
   CALL axcq541_show()
   
   #add-point:delete段before ask

   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前

      #end add-point   
      
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL axcq541_set_pk_array()
      #add-point:相關文件刪除前

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
 
       
      #add-point:單頭刪除中

      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xccd_m.xccdld 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後

      #end add-point
  
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM xcce_t
       WHERE xcceent = g_enterprise AND xcceld = g_xccd_m.xccdld
         AND xcce001 = g_xccd_m.xccd001
         AND xcce003 = g_xccd_m.xccd003
         AND xcce004 = g_xccd_m.xccd004
         AND xcce005 = g_xccd_m.xccd005
         AND xcce006 = g_xccd_m.xccd006
 
 
 
      #add-point:單身刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後

      #end add-point
      
            
                                                               
 
 
 
                                                               
      CLEAR FORM
      CALL g_xcce_d.clear() 
 
     
      CALL axcq541_ui_browser_refresh()  
      #CALL axcq541_ui_headershow()  
      #CALL axcq541_ui_detailshow()
      
      IF g_browser_cnt > 0 THEN 
         #CALL axcq541_browser_fill("")
         CALL axcq541_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
 
      #add-point:多語言刪除

      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除

      #end add-point
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE axcq541_cl
 
   #流程通知預埋點-D
   CALL axcq541_set_pk_array()
   CALL cl_flow_notify('','D')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq541.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq541_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   DEFINE l_glaa001    LIKE glaa_t.glaa001
   DEFINE l_glaa016    LIKE glaa_t.glaa016
   DEFINE l_glaa020    LIKE glaa_t.glaa020
   DEFINE l_curr       LIKE glaa_t.glaa001
   DEFINE l_wc_filter  STRING   #151130-00003#18 add
   #end add-point     
   #add-point:b_fill段define

   #end add-point     
   
   CALL g_xcce_d.clear()    #g_xcce_d 單頭及單身 
 
 
   #add-point:b_fill段sql_before
#为单价先取得币种 
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccd_m.xccdld
           

   #end add-point
         LET g_sql = "SELECT  UNIQUE xcce002,xcce007,xcce008,xcce009,",
                     "               SUM(xcce201+xcce205+xcce207+xcce209) xcce201,SUM(xcce202a+xcce206a+xcce208a+xcce210a) xcce202a,SUM(xcce202b+xcce206b+xcce208b+xcce210b) xcce202b,",
                     "               SUM(xcce202c+xcce206c+xcce208c+xcce210c) xcce202c,SUM(xcce202d+xcce206d+xcce208d+xcce210d) xcce202d,SUM(xcce202e+xcce206e+xcce208e+xcce210e) xcce202e,SUM(xcce202f+xcce206f+xcce208f+xcce210f) xcce202f,",
                     "               SUM(xcce202g+xcce206g+xcce208g+xcce210g) xcce202g,SUM(xcce202h+xcce206h+xcce208h+xcce210h) xcce202h,SUM(xcce202+xcce206+xcce208+xcce210) xcce202,",
                     "               SUM(xcce301) xcce301_sum,SUM(xcce302a) xcce302a_sum,SUM(xcce302b) xcce302b_sum,SUM(xcce302c) xcce302c_sum,SUM(xcce302d) xcce302d_sum,SUM(xcce302e) xcce302e_sum,SUM(xcce302f) xcce302f_sum,SUM(xcce302g) xcce302g_sum,SUM(xcce302h) xcce302h_sum,SUM(xcce302) xcce302_sum,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce301 ELSE 0 END) xcce301,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302a ELSE 0 END) xcce302a,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302b ELSE 0 END) xcce302b,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302c ELSE 0 END) xcce302c,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302d ELSE 0 END) xcce302d,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302e ELSE 0 END) xcce302e,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302f ELSE 0 END) xcce302f,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302g ELSE 0 END) xcce302g,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302h ELSE 0 END) xcce302h,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce302 ELSE 0 END) xcce302,",
                     "               0, ",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce303 ELSE 0 END) xcce303,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304a ELSE 0 END) xcce304a,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304b ELSE 0 END) xcce304b,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304c ELSE 0 END) xcce304c,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304d ELSE 0 END) xcce304d,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304e ELSE 0 END) xcce304e,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304f ELSE 0 END) xcce304f,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304g ELSE 0 END) xcce304g,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304h ELSE 0 END) xcce304h,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce304 ELSE 0 END) xcce304,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce901 ELSE 0 END) xcce901,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902a ELSE 0 END) xcce902a,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902b ELSE 0 END) xcce902b,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902c ELSE 0 END) xcce902c,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902d ELSE 0 END) xcce902d,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902e ELSE 0 END) xcce902e,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902f ELSE 0 END) xcce902f,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902g ELSE 0 END) xcce902g,SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902h ELSE 0 END) xcce902h,",
                     "               SUM(CASE xcce004*12+xcce005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcce902 ELSE 0 END) xcce902,",
                     "               t1.xcbfl003 xcbfl003,t2.imaal003 imaal003 FROM xcce_t",                 
                     " INNER JOIN xccd_t ON xccdld = xcceld ",
                     " AND xccd001 = xcce001 ",
                     " AND xccd003 = xcce003 ",
                     " AND xccd004 = xcce004 ",
                     " AND xccd005 = xcce005 ",
                     " AND xccd006 = xcce006 ",
                     " AND xccdent = xcceent ", #170218-00009#1 add
                     " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbfl001=xcce002 AND t1.xcbfl002='"||g_dlang||"' ",
                     " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcce007 AND t2.imaal002='"||g_dlang||"' ", 
                     " WHERE xcceent=? AND xcceld=? AND xcce001=? AND xcce003 = ?",
                     "   AND (xcce004*12+xcce005) <=?*12+? ",  #为配合不能改的using才这么写的，否则直接传单头变量
                     "   AND xcce006=?"
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
        #151130-00003#18 add -----(S)
         IF NOT cl_null(g_wc_filter) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc_filter CLIPPED
            LET l_wc_filter = cl_replace_str(g_wc_filter,'xcce','xcci')
         END IF
        #151130-00003#18 add -----(E)
         LET g_sql   = g_sql,
                     " GROUP BY  xcce002,xcce007,xcce008,xcce009,t1.xcbfl003 ,t2.imaal003 ",
                     " UNION ",
                     "SELECT  UNIQUE xcci002,xcci007,xcci008,xcci009,",
                     "               SUM(xcci201) xcci201,SUM(xcci202a) xcci202a,SUM(xcci202b) xcci202b,",
                     "               SUM(xcci202c) xcci202c,SUM(xcci202d) xcci202d,SUM(xcci202e) xcci202e,SUM(xcci202f) xcci202f,",
                     "               SUM(xcci202g) xcci202g,SUM(xcci202h) xcci202h,SUM(xcci202) xcci202,",
                     "               SUM(xcci301) xcci301_sum,SUM(xcci302a) xcci302a_sum,SUM(xcci302b) xcci302b_sum,SUM(xcci302c) xcci302c_sum,SUM(xcci302d) xcci302d_sum,SUM(xcci302e) xcci302e_sum,SUM(xcci302f) xcci302f_sum,SUM(xcci302g) xcci302g_sum,SUM(xcci302h) xcci302h_sum,SUM(xcci302) xcci302_sum,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci301 ELSE 0 END) xcci301,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302a ELSE 0 END) xcci302a,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302b ELSE 0 END) xcci302b,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302c ELSE 0 END) xcci302c,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302d ELSE 0 END) xcci302d,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302e ELSE 0 END) xcci302e,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302f ELSE 0 END) xcci302f,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302g ELSE 0 END) xcci302g,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302h ELSE 0 END) xcci302h,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci302 ELSE 0 END) xcci302,",
                     "               0, ",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci303 ELSE 0 END) xcci303,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304a ELSE 0 END) xcci304a,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304b ELSE 0 END) xcci304b,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304c ELSE 0 END) xcci304c,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304d ELSE 0 END) xcci304d,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304e ELSE 0 END) xcci304e,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304f ELSE 0 END) xcci304f,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304g ELSE 0 END) xcci304g,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304h ELSE 0 END) xcci304h,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci304 ELSE 0 END) xcci304,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci901 ELSE 0 END) xcci901,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902a ELSE 0 END) xcci902a,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902b ELSE 0 END) xcci902b,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902c ELSE 0 END) xcci902c,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902d ELSE 0 END) xcci902d,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902e ELSE 0 END) xcci902e,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902f ELSE 0 END) xcci902f,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902g ELSE 0 END) xcci902g,SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902h ELSE 0 END) xcci902h,",
                     "               SUM(CASE xcci004*12+xcci005 WHEN ",g_xccd_m.xccd004*12+g_xccd_m.xccd005," THEN xcci902 ELSE 0 END) xcci902,",
                     "               t3.xcbfl003 ,t4.imaal003 FROM xcci_t",                 
                     " INNER JOIN xcch_t ON xcchld = xccild ",
                     " AND xcch001 = xcci001 ",
                     " AND xcch003 = xcci003 ",
                     " AND xcch004 = xcci004 ",
                     " AND xcch005 = xcci005 ",
                     " AND xcch006 = xcci006 ",
                     " AND xcchent = xccient ", #170218-00009#1 add
                     " LEFT JOIN xcbfl_t t3 ON t3.xcbflent='"||g_enterprise||"' AND t3.xcbfl001=xcci002 AND t3.xcbfl002='"||g_dlang||"' ",
                     " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcci007 AND t4.imaal002='"||g_dlang||"' ", 
                     " WHERE xccient=? AND xccild=? AND xcci001=? AND xcci003=? ",
                     "   AND (xcci004*12+xcci005) <=?*12+? ",  #为配合不能改的using才这么写的，否则直接传单头变量
                     "   AND xcci006=?"
         IF NOT cl_null(g_wc2_xcci_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_xcci_table1 CLIPPED
         END IF 
        #151130-00003#18 add -----(S)
         IF NOT cl_null(l_wc_filter) THEN
            LET g_sql = g_sql CLIPPED, " AND ", l_wc_filter CLIPPED
         END IF
        #151130-00003#18 add -----(E)          
         LET g_sql   = g_sql,
                     " GROUP BY  xcci002,xcci007,xcci008,xcci009,t3.xcbfl003 ,t4.imaal003 ",
                     " ORDER BY  xcce002,xcce007,xcce008,xcce009,xcbfl003,imaal003 "

 
 
 
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      
      LET g_sql_tmp = g_sql   #by wuxja add 20150320
      
      PREPARE axcq541_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR axcq541_pb
 
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006,
                           g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
                                               
      FOREACH b_fill_cs INTO g_xcce_d[l_ac].xcce002,g_xcce_d[l_ac].xcce007,g_xcce_d[l_ac].xcce008,g_xcce_d[l_ac].xcce009, 
          g_xcce_d[l_ac].xcce201,g_xcce_d[l_ac].xcce202a,g_xcce_d[l_ac].xcce202b,g_xcce_d[l_ac].xcce202c, 
          g_xcce_d[l_ac].xcce202d,g_xcce_d[l_ac].xcce202e,g_xcce_d[l_ac].xcce202f,g_xcce_d[l_ac].xcce202g, 
          g_xcce_d[l_ac].xcce202h,g_xcce_d[l_ac].xcce202,g_xcce_d[l_ac].xcce301_sum,g_xcce_d[l_ac].xcce302a_sum, 
          g_xcce_d[l_ac].xcce302b_sum,g_xcce_d[l_ac].xcce302c_sum,g_xcce_d[l_ac].xcce302d_sum,g_xcce_d[l_ac].xcce302e_sum, 
          g_xcce_d[l_ac].xcce302f_sum,g_xcce_d[l_ac].xcce302g_sum,g_xcce_d[l_ac].xcce302h_sum,g_xcce_d[l_ac].xcce302_sum,
          g_xcce_d[l_ac].xcce301,g_xcce_d[l_ac].xcce302a, 
          g_xcce_d[l_ac].xcce302b,g_xcce_d[l_ac].xcce302c,g_xcce_d[l_ac].xcce302d,g_xcce_d[l_ac].xcce302e, 
          g_xcce_d[l_ac].xcce302f,g_xcce_d[l_ac].xcce302g,g_xcce_d[l_ac].xcce302h,g_xcce_d[l_ac].xcce302,g_xcce_d[l_ac].xcce_price,          
          g_xcce_d[l_ac].xcce303,g_xcce_d[l_ac].xcce304a,g_xcce_d[l_ac].xcce304b,g_xcce_d[l_ac].xcce304c, 
          g_xcce_d[l_ac].xcce304d,g_xcce_d[l_ac].xcce304e,g_xcce_d[l_ac].xcce304f,g_xcce_d[l_ac].xcce304g, 
          g_xcce_d[l_ac].xcce304h,g_xcce_d[l_ac].xcce304,g_xcce_d[l_ac].xcce901,g_xcce_d[l_ac].xcce902a, 
          g_xcce_d[l_ac].xcce902b,g_xcce_d[l_ac].xcce902c,g_xcce_d[l_ac].xcce902d,g_xcce_d[l_ac].xcce902e, 
          g_xcce_d[l_ac].xcce902f,g_xcce_d[l_ac].xcce902g,g_xcce_d[l_ac].xcce902h,g_xcce_d[l_ac].xcce902, 
          g_xcce_d[l_ac].xcce002_desc,g_xcce_d[l_ac].xcce007_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL s_desc_get_item_desc(g_xcce_d[l_ac].xcce007) RETURNING g_xcce_d[l_ac].xcce007_desc,g_xcce_d[l_ac].xcce007_desc_1
         SELECT xcbb005 INTO g_xcce_d[l_ac].xcbb005 
           FROM xcbb_t 
          WHERE xcbbent = g_enterprise
            AND xcbbcomp = g_xccd_m.xccdcomp
            AND xcbb001 = g_xccd_m.xccd004 
            AND xcbb002 = g_xccd_m.xccd005  
            AND xcbb003 = g_xcce_d[l_ac].xcce007 
            AND xcbb004 = g_xcce_d[l_ac].xcce008 
            
         CALL s_desc_get_unit_desc(g_xcce_d[l_ac].xcbb005) RETURNING g_xcce_d[l_ac].xcbb005_desc

#         LET g_xcce_d[l_ac].xcce_price = g_xcce_d[l_ac].xcce302/g_xcce_d[l_ac].xcce301   #wujie 150416 mark
         CASE g_xccd_m.xccd001
            WHEN '1' 
              LET l_curr = l_glaa001
            WHEN '2'
              LET l_curr = l_glaa016
            WHEN '3'
              LET l_curr = l_glaa020
         END CASE
#wujie 150416 --begin
#DL+OH+SUB的在制转出单价取值逻辑不同，为元件转出成本/单头主件本期入库数量，转出比率固定为1  
         IF g_xcce_d[l_ac].xcce007 ='DL+OH+SUB' THEN
            LET g_xcce_d[l_ac].xcce_price = g_xcce_d[l_ac].xcce302/g_xccd_m.xccd301
            LET g_xcce_d[l_ac].xcce_conv_rate  = 1
         ELSE
            LET g_xcce_d[l_ac].xcce_price = g_xcce_d[l_ac].xcce302/g_xcce_d[l_ac].xcce301
            LET g_xcce_d[l_ac].xcce_conv_rate  = g_xcce_d[l_ac].xcce301/g_xccd_m.xccd301
         END IF
         LET g_xcce_d[l_ac].xcce_conv_price = g_xcce_d[l_ac].xcce_conv_rate*g_xcce_d[l_ac].xcce_price
         CALL s_curr_round(g_xccd_m.xccdcomp,l_curr,g_xcce_d[l_ac].xcce_conv_price,'1') RETURNING g_xcce_d[l_ac].xcce_conv_price       
#wujie 150416 --end
         CALL s_curr_round(g_xccd_m.xccdcomp,l_curr,g_xcce_d[l_ac].xcce_price,'1') RETURNING g_xcce_d[l_ac].xcce_price
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
   
   
 
   
   #add-point:browser_fill段其他table處理

   #end add-point
   
   CALL g_xcce_d.deleteElement(g_xcce_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axcq541_pb
 
   CALL cl_ap_performance_next_end()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq541_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10 #5
   #add-point:delete_b段define
   
   #end add-point     
   #add-point:delete_b段define
   
   #end add-point     
 
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM xcce_t
       WHERE xcceent = g_enterprise AND
         xcceld = ps_keys_bak[1] AND xcce001 = ps_keys_bak[2] AND xcce003 = ps_keys_bak[3] AND xcce004 = ps_keys_bak[4] AND xcce005 = ps_keys_bak[5] AND xcce006 = ps_keys_bak[6] AND xcce002 = ps_keys_bak[7] AND xcce007 = ps_keys_bak[8] AND xcce008 = ps_keys_bak[9] AND xcce009 = ps_keys_bak[10]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xcce_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq541_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10 #5
   #add-point:insert_b段define
   
   #end add-point     
   #add-point:insert_b段define
   
   #end add-point     
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point 
      INSERT INTO xcce_t
                  (xcceent,
                   xcceld,xcce001,xcce003,xcce004,xcce005,xcce006,
                   xcce002,xcce007,xcce008,xcce009
                   ,xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce304,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcce902) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
                   ,g_xcce_d[g_detail_idx].xcce201,g_xcce_d[g_detail_idx].xcce202a,g_xcce_d[g_detail_idx].xcce202b, 
                       g_xcce_d[g_detail_idx].xcce202c,g_xcce_d[g_detail_idx].xcce202d,g_xcce_d[g_detail_idx].xcce202e, 
                       g_xcce_d[g_detail_idx].xcce202f,g_xcce_d[g_detail_idx].xcce202g,g_xcce_d[g_detail_idx].xcce202h, 
                       g_xcce_d[g_detail_idx].xcce202,g_xcce_d[g_detail_idx].xcce301,g_xcce_d[g_detail_idx].xcce302a, 
                       g_xcce_d[g_detail_idx].xcce302b,g_xcce_d[g_detail_idx].xcce302c,g_xcce_d[g_detail_idx].xcce302d, 
                       g_xcce_d[g_detail_idx].xcce302e,g_xcce_d[g_detail_idx].xcce302f,g_xcce_d[g_detail_idx].xcce302g, 
                       g_xcce_d[g_detail_idx].xcce302h,g_xcce_d[g_detail_idx].xcce302,g_xcce_d[g_detail_idx].xcce303, 
                       g_xcce_d[g_detail_idx].xcce304a,g_xcce_d[g_detail_idx].xcce304b,g_xcce_d[g_detail_idx].xcce304c, 
                       g_xcce_d[g_detail_idx].xcce304d,g_xcce_d[g_detail_idx].xcce304e,g_xcce_d[g_detail_idx].xcce304f, 
                       g_xcce_d[g_detail_idx].xcce304g,g_xcce_d[g_detail_idx].xcce304h,g_xcce_d[g_detail_idx].xcce304, 
                       g_xcce_d[g_detail_idx].xcce901,g_xcce_d[g_detail_idx].xcce902a,g_xcce_d[g_detail_idx].xcce902b, 
                       g_xcce_d[g_detail_idx].xcce902c,g_xcce_d[g_detail_idx].xcce902d,g_xcce_d[g_detail_idx].xcce902e, 
                       g_xcce_d[g_detail_idx].xcce902f,g_xcce_d[g_detail_idx].xcce902g,g_xcce_d[g_detail_idx].xcce902h, 
                       g_xcce_d[g_detail_idx].xcce902)
      #add-point:insert_b段資料新增中
      
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xcce_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq541_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 #5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define
   
   #end add-point   
   #add-point:update_b段define
   
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcce_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE xcce_t 
         SET (xcceld,xcce001,xcce003,xcce004,xcce005,xcce006,
              xcce002,xcce007,xcce008,xcce009
              ,xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce304,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcce902) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
              ,g_xcce_d[g_detail_idx].xcce201,g_xcce_d[g_detail_idx].xcce202a,g_xcce_d[g_detail_idx].xcce202b, 
                  g_xcce_d[g_detail_idx].xcce202c,g_xcce_d[g_detail_idx].xcce202d,g_xcce_d[g_detail_idx].xcce202e, 
                  g_xcce_d[g_detail_idx].xcce202f,g_xcce_d[g_detail_idx].xcce202g,g_xcce_d[g_detail_idx].xcce202h, 
                  g_xcce_d[g_detail_idx].xcce202,g_xcce_d[g_detail_idx].xcce301,g_xcce_d[g_detail_idx].xcce302a, 
                  g_xcce_d[g_detail_idx].xcce302b,g_xcce_d[g_detail_idx].xcce302c,g_xcce_d[g_detail_idx].xcce302d, 
                  g_xcce_d[g_detail_idx].xcce302e,g_xcce_d[g_detail_idx].xcce302f,g_xcce_d[g_detail_idx].xcce302g, 
                  g_xcce_d[g_detail_idx].xcce302h,g_xcce_d[g_detail_idx].xcce302,g_xcce_d[g_detail_idx].xcce303, 
                  g_xcce_d[g_detail_idx].xcce304a,g_xcce_d[g_detail_idx].xcce304b,g_xcce_d[g_detail_idx].xcce304c, 
                  g_xcce_d[g_detail_idx].xcce304d,g_xcce_d[g_detail_idx].xcce304e,g_xcce_d[g_detail_idx].xcce304f, 
                  g_xcce_d[g_detail_idx].xcce304g,g_xcce_d[g_detail_idx].xcce304h,g_xcce_d[g_detail_idx].xcce304, 
                  g_xcce_d[g_detail_idx].xcce901,g_xcce_d[g_detail_idx].xcce902a,g_xcce_d[g_detail_idx].xcce902b, 
                  g_xcce_d[g_detail_idx].xcce902c,g_xcce_d[g_detail_idx].xcce902d,g_xcce_d[g_detail_idx].xcce902e, 
                  g_xcce_d[g_detail_idx].xcce902f,g_xcce_d[g_detail_idx].xcce902g,g_xcce_d[g_detail_idx].xcce902h, 
                  g_xcce_d[g_detail_idx].xcce902) 
         WHERE xcceent = g_enterprise AND xcceld = ps_keys_bak[1] AND xcce001 = ps_keys_bak[2] AND xcce003 = ps_keys_bak[3] AND xcce004 = ps_keys_bak[4] AND xcce005 = ps_keys_bak[5] AND xcce006 = ps_keys_bak[6] AND xcce002 = ps_keys_bak[7] AND xcce007 = ps_keys_bak[8] AND xcce008 = ps_keys_bak[9] AND xcce009 = ps_keys_bak[10]
      #add-point:update_b段修改中
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcce_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcce_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF
   
 
   
 
   
   #add-point:update_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axcq541_key_update_b(ps_keys_bak,ps_table)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:update_b段define
   
   #end add-point
   #add-point:update_b段define
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq541_key_delete_b(ps_keys_bak,ps_table)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define
   
   #end add-point
   #add-point:delete_b段define
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq541_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   #add-point:lock_b段define
   
   #end add-point   
    
   #先刷新資料
   #CALL axcq541_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xcce_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axcq541_bcl USING g_enterprise,
                                       g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
                                           g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006,g_xcce_d[g_detail_idx].xcce002, 
                                           g_xcce_d[g_detail_idx].xcce007,g_xcce_d[g_detail_idx].xcce008, 
                                           g_xcce_d[g_detail_idx].xcce009     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axcq541_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq541_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   #add-point:unlock_b段define
   
   #end add-point  
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axcq541_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq541_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
   #add-point:set_entry段define
   
   #end add-point       
 
   CALL cl_set_comp_entry("xccdld",TRUE)
  
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq541_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
   #add-point:set_no_entry段define
   
   #end add-point     
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("xccdld",FALSE)
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq541_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段define
   
   #end add-point     
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axcq541.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq541_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   #add-point:set_no_entry_b段define
   
   #end add-point    
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axcq541.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq541_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point   
   #add-point:set_act_visible段define
   
   #end add-point   
   #add-point:set_act_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq541_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point   
   #add-point:set_act_no_visible段define
   
   #end add-point   
   #add-point:set_act_no_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq541_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point   
   #add-point:set_act_visible_b段define
   
   #end add-point   
   #add-point:set_act_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq541_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point   
   #add-point:set_act_no_visible_b段define
   
   #end add-point   
   #add-point:set_act_no_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq541_default_search()
   DEFINE li_idx  LIKE type_t.num10 #5
   DEFINE li_cnt  LIKE type_t.num10 #5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
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
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
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
   
   #add-point:default_search段結束前
   LET g_wc = ' 1=2'    
   LET g_wc_xcch = ' 1=2'
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.state_change" >}
   
 
{</section>}
 
{<section id="axcq541.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq541_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xcce_d.getLength() THEN
         LET g_detail_idx = g_xcce_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcce_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcce_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq541_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10 #5
   DEFINE li_ac           LIKE type_t.num10 #5
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
   
   #end add-point
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL axcq541_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq541.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq541_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   #add-point:fill_chk段define
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq541.signature" >}
   
 
{</section>}
 
{<section id="axcq541.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq541_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
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
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axcq541.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axcq541.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq541_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd003
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd003
   
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
      
   LET g_xccd_m.xccd001 = '1'
   DISPLAY BY NAME g_xccd_m.xccd001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccd_m.xccdld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccd001_desc  
#wujie 150419 --begin
   LET g_xccd_m.chk = 'N'
   CALL cl_set_comp_visible('xcce201,xcce202,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce301_sum,xcce302_sum,xcce302a_sum,xcce302b_sum,xcce302c_sum,xcce302d_sum,xcce302e_sum,xcce302f_sum,xcce302g_sum,xcce302h_sum',TRUE) 
#wujie 150419 --end
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
PRIVATE FUNCTION axcq541_fetch1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING  
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
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
   EXECUTE axcq541_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
       INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd002,g_xccd_m.xccd006,g_xccd_m.xccd007, 
       g_xccd_m.xccd301,g_xccd_m.xccd002_desc,g_xccd_m.xccd007_desc
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
   CALL axcq541_set_act_visible()   
   CALL axcq541_set_act_no_visible()
   
   #add-point:fetch段action控制

   #end add-point  
   
   
   
   #add-point:fetch結束前

   #end add-point
   
   #保存單頭舊值
   LET g_xccd_m_t.* = g_xccd_m.*
   LET g_xccd_m_o.* = g_xccd_m.*
   
   
   #重新顯示   
   CALL axcq541_show()
 
END FUNCTION
#创建临时表 
#by wuxja add 20150320
PRIVATE FUNCTION axcq541_create_tmp()
   DROP TABLE axcq541_tmp;
   CREATE TEMP TABLE axcq541_tmp(
      xccdcomp  VARCHAR(10),
      xccdcomp_desc  VARCHAR(100),
      xccdld  VARCHAR(5),
      xccdld_desc  VARCHAR(100),
      xccd004  SMALLINT,
      xccd005  SMALLINT,
      xccd001  VARCHAR(1),
      xccd001_desc  VARCHAR(100),
      xccd003  VARCHAR(10),
      xccd003_desc  VARCHAR(100),
      xccd002  VARCHAR(30),
      xccd002_desc  VARCHAR(30),
      xccd006  VARCHAR(20),
      sfaa_t_sfaa019  DATE,
      sfaa_t_sfaa020  DATE,
      xccd007  VARCHAR(40),
      xccd007_desc  VARCHAR(100),
      sfaa_t_sfaa012  DECIMAL(20,6),
      sfaa_t_sfaa049  DECIMAL(20,6),
      xccd301_sum  DECIMAL(20,6),
      xccd301  DECIMAL(20,6),
      xcbk_t_xcbk100  DECIMAL(20,6),
      xcbk100_1  DECIMAL(20,6),
      xcce002  VARCHAR(30),
      xcce002_desc  VARCHAR(30),
      xcce007  VARCHAR(40),
      xcce007_desc  VARCHAR(30),
      xcce007_desc_1  VARCHAR(30),
      xcce008  VARCHAR(256),
      xcce009  VARCHAR(30),
      xcbb_t_xcbb005  VARCHAR(10),
      xcbb005_desc  VARCHAR(30),
      xcce201  DECIMAL(20,6),
      xcce202a  DECIMAL(20,6),
      xcce202b  DECIMAL(20,6),
      xcce202c  DECIMAL(20,6),
      xcce202d  DECIMAL(20,6),
      xcce202e  DECIMAL(20,6),
      xcce202f  DECIMAL(20,6),
      xcce202g  DECIMAL(20,6),
      xcce202h  DECIMAL(20,6),
      xcce202  DECIMAL(20,6),
      xcce301  DECIMAL(20,6), 
      xcce302a  DECIMAL(20,6), 
      xcce302b  DECIMAL(20,6), 
      xcce302c  DECIMAL(20,6), 
      xcce302d  DECIMAL(20,6), 
      xcce302e  DECIMAL(20,6), 
      xcce302f  DECIMAL(20,6), 
      xcce302g  DECIMAL(20,6), 
      xcce302h  DECIMAL(20,6), 
      xcce302  DECIMAL(20,6),
      xcce_price  DECIMAL(20,6),
      xcce_conv_rate  DECIMAL(26,10),         #wujie 150416
      xcce_conv_price  DECIMAL(20,6),         #wujie 150416      
      xcce303  DECIMAL(20,6),
      xcce304a  DECIMAL(20,6),
      xcce304b  DECIMAL(20,6),
      xcce304c  DECIMAL(20,6),
      xcce304d  DECIMAL(20,6),
      xcce304e  DECIMAL(20,6),
      xcce304f  DECIMAL(20,6),
      xcce304g  DECIMAL(20,6),
      xcce304h  DECIMAL(20,6),
      xcce304  DECIMAL(20,6),
      xcce901  DECIMAL(20,6),
      xcce902a  DECIMAL(20,6),
      xcce902b  DECIMAL(20,6),
      xcce902c  DECIMAL(20,6),
      xcce902d  DECIMAL(20,6),
      xcce902e  DECIMAL(20,6),
      xcce902f  DECIMAL(20,6),
      xcce902g  DECIMAL(20,6),
      xcce902h  DECIMAL(20,6),
      xcce902  DECIMAL(20,6),
      xcce201_sum  DECIMAL(20,6),
      xcce202a_sum  DECIMAL(20,6),
      xcce202b_sum  DECIMAL(20,6),
      xcce202c_sum  DECIMAL(20,6),
      xcce202d_sum  DECIMAL(20,6),
      xcce202e_sum  VARCHAR(30),
      xcce202f_sum  DECIMAL(20,6),
      xcce202g_sum  DECIMAL(20,6),
      xcce202h_sum  DECIMAL(20,6),
      xcce202_sum  DECIMAL(20,6),
      xcce202_total  DECIMAL(20,6),
      xcce301_sum  DECIMAL(20,6),
      xcce302a_sum  DECIMAL(20,6),
      xcce302b_sum  DECIMAL(20,6),
      xcce302c_sum  DECIMAL(20,6),
      xcce302d_sum  DECIMAL(20,6),
      xcce302e_sum  DECIMAL(20,6),
      xcce302f_sum  DECIMAL(20,6),
      xcce302g_sum  DECIMAL(20,6),
      xcce302h_sum  DECIMAL(20,6),
      xcce302_sum  DECIMAL(20,6),
      xcce302_total  DECIMAL(20,6),
      xcce303_sum  DECIMAL(20,6),
      xcce304a_sum  DECIMAL(20,6),
      xcce304b_sum  DECIMAL(20,6),
      xcce304c_sum  DECIMAL(20,6),
      xcce304d_sum  DECIMAL(20,6),
      xcce304e_sum  DECIMAL(20,6),
      xcce304f_sum  DECIMAL(20,6),
      xcce304g_sum  DECIMAL(20,6),
      xcce304h_sum  DECIMAL(20,6),
      xcce304_sum  DECIMAL(20,6),
      xcce304_total  DECIMAL(20,6),
      xcce901_sum  DECIMAL(20,6),
      xcce902a_sum  DECIMAL(20,6),
      xcce902b_sum  DECIMAL(20,6),
      xcce902c_sum  DECIMAL(20,6),
      xcce902d_sum  DECIMAL(20,6),
      xcce902e_sum  DECIMAL(20,6),
      xcce902f_sum  DECIMAL(20,6),
      xcce902g_sum  DECIMAL(20,6),
      xcce902h_sum  DECIMAL(20,6),
      xcce902_sum  DECIMAL(20,6),
      xcce902_total  DECIMAL(20,6)
   );
END FUNCTION
#新增临时表资料
#add by wuxja add 20150320
PRIVATE FUNCTION axcq541_ins_tmp()
DEFINE sr                RECORD
       xccdcomp LIKE xccd_t.xccdcomp,
      xccdcomp_desc LIKE type_t.chr100,
      xccdld LIKE xccd_t.xccdld,
      xccdld_desc LIKE type_t.chr100,
      xccd004 LIKE xccd_t.xccd004,
      xccd005 LIKE xccd_t.xccd005,
      xccd001 LIKE xccd_t.xccd001,
      xccd001_desc LIKE type_t.chr100,
      xccd003 LIKE xccd_t.xccd003,
      xccd003_desc LIKE type_t.chr100,
      xccd002 LIKE xccd_t.xccd002,
      xccd002_desc LIKE type_t.chr30,
      xccd006 LIKE xccd_t.xccd006,
      sfaa_t_sfaa019 LIKE sfaa_t.sfaa019,
      sfaa_t_sfaa020 LIKE sfaa_t.sfaa020,
      xccd007 LIKE xccd_t.xccd007,
      xccd007_desc LIKE type_t.chr100,
      sfaa_t_sfaa012 LIKE sfaa_t.sfaa012,
      sfaa_t_sfaa049 LIKE sfaa_t.sfaa049,
      xccd301_sum LIKE type_t.num20_6,
      xccd301 LIKE xccd_t.xccd301,
      xcbk_t_xcbk100 LIKE xcbk_t.xcbk100,
      xcbk100_1 LIKE type_t.num20_6,
      xcce002 LIKE xcce_t.xcce002,
      xcce002_desc LIKE type_t.chr30,
      xcce007 LIKE xcce_t.xcce007,
      xcce007_desc LIKE type_t.chr30,
      xcce007_desc_1 LIKE type_t.chr30,
      xcce008 LIKE xcce_t.xcce008,
      xcce009 LIKE xcce_t.xcce009,
      xcbb_t_xcbb005 LIKE xcbb_t.xcbb005,
      xcbb005_desc LIKE type_t.chr30,
      xcce201 LIKE xcce_t.xcce201,
      xcce202a LIKE xcce_t.xcce202a,
      xcce202b LIKE xcce_t.xcce202b,
      xcce202c LIKE xcce_t.xcce202c,
      xcce202d LIKE xcce_t.xcce202d,
      xcce202e LIKE xcce_t.xcce202e,
      xcce202f LIKE xcce_t.xcce202f,
      xcce202g LIKE xcce_t.xcce202g,
      xcce202h LIKE xcce_t.xcce202h,
      xcce202 LIKE xcce_t.xcce202,
      xcce301 LIKE xcce_t.xcce301,
      xcce302a LIKE xcce_t.xcce302a,
      xcce302b LIKE xcce_t.xcce302b,
      xcce302c LIKE xcce_t.xcce302c,
      xcce302d LIKE xcce_t.xcce302d,
      xcce302e LIKE xcce_t.xcce302e,
      xcce302f LIKE xcce_t.xcce302f,
      xcce302g LIKE xcce_t.xcce302g,
      xcce302h LIKE xcce_t.xcce302h,
      xcce302 LIKE xcce_t.xcce302,
#wujie 150417 --begin
      xcce_price LIKE xccc_t.xccc280,                       
      xcce_conv_rate LIKE type_t.num26_10,    #wujie 150416 
      xcce_conv_price LIKE xccc_t.xccc280,    #wujie 150416 
#wujie 150417 --end
      xcce303 LIKE xcce_t.xcce303,
      xcce304a LIKE xcce_t.xcce304a,
      xcce304b LIKE xcce_t.xcce304b,
      xcce304c LIKE xcce_t.xcce304c,
      xcce304d LIKE xcce_t.xcce304d,
      xcce304e LIKE xcce_t.xcce304e,
      xcce304f LIKE xcce_t.xcce304f,
      xcce304g LIKE xcce_t.xcce304g,
      xcce304h LIKE xcce_t.xcce304h,
      xcce304 LIKE xcce_t.xcce304,
      xcce901 LIKE xcce_t.xcce901,
      xcce902a LIKE xcce_t.xcce902a,
      xcce902b LIKE xcce_t.xcce902b,
      xcce902c LIKE xcce_t.xcce902c,
      xcce902d LIKE xcce_t.xcce902d,
      xcce902e LIKE xcce_t.xcce902e,
      xcce902f LIKE xcce_t.xcce902f,
      xcce902g LIKE xcce_t.xcce902g,
      xcce902h LIKE xcce_t.xcce902h,
      xcce902 LIKE xcce_t.xcce902,
      xcce201_sum LIKE type_t.num20_6,
      xcce202a_sum LIKE type_t.num20_6,
      xcce202b_sum LIKE type_t.num20_6,
      xcce202c_sum LIKE type_t.num20_6,
      xcce202d_sum LIKE type_t.num20_6,
      xcce202e_sum LIKE type_t.chr30,
      xcce202f_sum LIKE type_t.num20_6,
      xcce202g_sum LIKE type_t.num20_6,
      xcce202h_sum LIKE type_t.num20_6,
      xcce202_sum LIKE type_t.num20_6,
      xcce202_total LIKE type_t.num20_6,
      xcce301_sum LIKE type_t.num20_6,
      xcce302a_sum LIKE type_t.num20_6,
      xcce302b_sum LIKE type_t.num20_6,
      xcce302c_sum LIKE type_t.num20_6,
      xcce302d_sum LIKE type_t.num20_6,
      xcce302e_sum LIKE type_t.num20_6,
      xcce302f_sum LIKE type_t.num20_6,
      xcce302g_sum LIKE type_t.num20_6,
      xcce302h_sum LIKE type_t.num20_6,
      xcce302_sum LIKE type_t.num20_6,
      xcce302_total LIKE type_t.num20_6,
      xcce303_sum LIKE type_t.num20_6,
      xcce304a_sum LIKE type_t.num20_6,
      xcce304b_sum LIKE type_t.num20_6,
      xcce304c_sum LIKE type_t.num20_6,
      xcce304d_sum LIKE type_t.num20_6,
      xcce304e_sum LIKE type_t.num20_6,
      xcce304f_sum LIKE type_t.num20_6,
      xcce304g_sum LIKE type_t.num20_6,
      xcce304h_sum LIKE type_t.num20_6,
      xcce304_sum LIKE type_t.num20_6,
      xcce304_total LIKE type_t.num20_6,
      xcce901_sum LIKE type_t.num20_6,
      xcce902a_sum LIKE type_t.num20_6,
      xcce902b_sum LIKE type_t.num20_6,
      xcce902c_sum LIKE type_t.num20_6,
      xcce902d_sum LIKE type_t.num20_6,
      xcce902e_sum LIKE type_t.num20_6,
      xcce902f_sum LIKE type_t.num20_6,
      xcce902g_sum LIKE type_t.num20_6,
      xcce902h_sum LIKE type_t.num20_6,
      xcce902_sum LIKE type_t.num20_6,
      xcce902_total LIKE type_t.num20_6
                         END RECORD
DEFINE l_i               LIKE type_t.num5
DEFINE l_glaa001         LIKE glaa_t.glaa001
DEFINE l_glaa016         LIKE glaa_t.glaa016
DEFINE l_glaa020         LIKE glaa_t.glaa020
DEFINE l_curr            LIKE glaa_t.glaa001   #wujie 150417
DEFINE l_sql             STRING                #160520-00004#5-add
   #160520-00004#5-add-(S)
   PREPARE axcq541_ins_tmp_pre FROM g_sql_tmp
   DECLARE axcq541_ins_tmp_cs CURSOR FOR axcq541_ins_tmp_pre
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald  = sr.xccdld
         
   LET l_sql =  " SELECT t0_xccdcomp,t0_xccd007,t0_xccd301,xcbfl003,imaal003,ooefl003,glaal002,xcatl003,ooail003,
                         sfaa012,sfaa019,sfaa020,sfaa049,
                         (CASE WHEN xccd301_1=0 OR xccd301_1 IS NULL THEN NVL(xccd301_2,0) ELSE NVL(xccd301_1,0) END),
                         xcbk100,xcbk100_1,glaa001,glaa016,glaa020
                    FROM(SELECT UNIQUE t0.xccdcomp t0_xccdcomp,t0.xccd007 t0_xccd007,t0.xccd301 t0_xccd301,
                                       (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=t0.xccd002 AND xcbfl002='"||g_dlang||"') xcbfl003,
                                       (SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=t0.xccd007 AND imaal002='"||g_dlang||"') imaal003,
                                       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=t0.xccdcomp AND ooefl002='"||g_dlang||"') ooefl003,
                                       (SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=t0.xccdld AND glaal001='"||g_dlang||"') glaal002,
                                       (SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=t0.xccd003 AND xcatl002='"||g_dlang||"') xcatl003,
                                       (CASE t0.xccd001
                                          WHEN '1' THEN
                                             (SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail002='"||g_dlang||"' 
                                                AND ooail001=(SELECT glaa001 FROM glaa_t WHERE glaaent = t0.xccdent AND glaald  = t0.xccdld))
                                          WHEN '2' THEN
                                             (SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail002='"||g_dlang||"' 
                                                AND ooail001=(SELECT glaa016 FROM glaa_t WHERE glaaent = t0.xccdent AND glaald  = t0.xccdld))
                                          WHEN '3' THEN
                                             (SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail002='"||g_dlang||"' 
                                                AND ooail001=(SELECT glaa020 FROM glaa_t WHERE glaaent = t0.xccdent AND glaald  = t0.xccdld))
                                       END) ooail003 ,
                                       (SELECT sfaa012 FROM sfaa_t WHERE sfaaent = t0.xccdent AND sfaadocno = t0.xccd006) sfaa012,
                                       (SELECT sfaa019 FROM sfaa_t WHERE sfaaent = t0.xccdent AND sfaadocno = t0.xccd006) sfaa019,
                                       (SELECT sfaa020 FROM sfaa_t WHERE sfaaent = t0.xccdent AND sfaadocno = t0.xccd006) sfaa020,
                                       (SELECT sfaa049 FROM sfaa_t WHERE sfaaent = t0.xccdent AND sfaadocno = t0.xccd006) sfaa049,
                                       (SELECT SUM(NVL(xccd301,0)) FROM xccd_t WHERE xccdent=t0.xccdent AND xccdld=t0.xccdld AND xccd001=t0.xccd001 
                                                                          AND xccd002=t0.xccd002 AND xccd003=t0.xccd003 
                                                                          AND (xccd004*12+xccd005)<=(t0.xccd004*12+t0.xccd005) AND xccd006=t0.xccd006) xccd301_1,
                                       (SELECT SUM(NVL(xcch301,0)) FROM xcch_t WHERE xcchent=t0.xccdent AND xcchld=t0.xccdld AND xcch001=t0.xccd001 
                                                                                 AND xcch002=t0.xccd002 AND xcch003=t0.xccd003 
                                                                                 AND (xcch004*12+xcch005)<=(t0.xccd004*12+t0.xccd005) AND xcch006=t0.xccd006) xccd301_2,
                                       (SELECT SUM(NVL(xcbk100,0)) FROM xcbk_t WHERE xcbkent = t0.xccdent AND xcbkld  = t0.xccdld AND xcbk001 = t0.xccd003
                                                                          AND (xcbk002*12+xcbk003) <= (t0.xccd004*12+t0.xccd005) AND xcbk005 = '1' AND xcbk006 = t0.xccd006) xcbk100,
                                       
                                       (SELECT SUM(NVL(xcbk100,0)) FROM xcbk_t WHERE xcbkent = t0.xccdent AND xcbkld = t0.xccdld AND xcbk001 = t0.xccd003
                                                                          AND xcbk002 = t0.xccd004 AND xcbk003 = t0.xccd005 AND xcbk005 = '1' AND xcbk006 = t0.xccd006) xcbk100_1,
                                       (SELECT glaa001 FROM glaa_t WHERE glaaent = '"||g_enterprise||"' AND glaald  = t0.xccdld ) glaa001,
                                       (SELECT glaa016 FROM glaa_t WHERE glaaent = '"||g_enterprise||"' AND glaald  = t0.xccdld ) glaa016,
                                       (SELECT glaa020 FROM glaa_t WHERE glaaent = '"||g_enterprise||"' AND glaald  = t0.xccdld ) glaa020 ",
               "          FROM xccd_t t0",
               "          WHERE t0.xccdent = '" ||g_enterprise|| "' ",
               "            AND t0.xccdld = ? AND t0.xccd001 = ? AND t0.xccd002 = ? AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ? AND t0.xccd006 = ?",
               "        ) "
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE axcq541_pre FROM l_sql
   #160520-00004#5-add-(E)
   
   FOR l_i = 1 TO g_browser.getLength()
      LET sr.xccdld = g_browser[l_i].b_xccdld
      LET sr.xccd001 = g_browser[l_i].b_xccd001
      LET sr.xccd002 = g_browser[l_i].b_xccd002
      LET sr.xccd003 = g_browser[l_i].b_xccd003
      LET sr.xccd004 = g_browser[l_i].b_xccd004
      LET sr.xccd005 = g_browser[l_i].b_xccd005
      LET sr.xccd006 = g_browser[l_i].b_xccd006
      #160520-00004#5-mark-(S)     
#      SELECT xccdcomp,xccd007,xccd301 INTO sr.xccdcomp,sr.xccd007,sr.xccd301 FROM xccd_t
#       WHERE xccdent = g_enterprise AND xccdld = sr.xccdld AND xccd001 = sr.xccd001
#         AND xccd002 = sr.xccd002 AND xccd003 = sr.xccd003 AND xccd004 = sr.xccd004
#         AND xccd005 = sr.xccd005 AND xccd006 = sr.xccd006
         
#      #法人，账套，本位币顺序，成本计算类型
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xccdcomp
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xccdcomp_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME sr.xccdcomp_desc 
      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xccdld
#      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xccdld_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME sr.xccdld_desc 
     
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xccd003
#      CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xccd003_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME sr.xccd003_desc
      
#      SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
#        FROM glaa_t
#       WHERE glaaent = g_enterprise
#         AND glaald  = sr.xccdld
#              
#      CASE sr.xccd001
#         WHEN '1' 
#           INITIALIZE g_ref_fields TO NULL
#           LET g_ref_fields[1] = l_glaa001
#           CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#           LET sr.xccd001_desc = '', g_rtn_fields[1] , ''                  
#         WHEN '2'
#           INITIALIZE g_ref_fields TO NULL
#           LET g_ref_fields[1] = l_glaa016
#           CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#           LET sr.xccd001_desc = '', g_rtn_fields[1] , ''
#         WHEN '3'
#           INITIALIZE g_ref_fields TO NULL
#           LET g_ref_fields[1] = l_glaa020
#           CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#           LET sr.xccd001_desc = '', g_rtn_fields[1] , ''
#      END CASE 
      
#      SELECT sfaa012,sfaa019,sfaa020,sfaa049
#        INTO sr.sfaa_t_sfaa012,sr.sfaa_t_sfaa019,sr.sfaa_t_sfaa020,sr.sfaa_t_sfaa049
#        FROM sfaa_t
#       WHERE sfaaent = g_enterprise AND sfaadocno = sr.xccd006
      
#      #主料料号
#      SELECT imaal003 INTO sr.xccd007_desc FROM imaal_t
#       WHERE imaalent = g_enterprise AND imaal001 = sr.xccd007
#         AND imaal002 = g_dlang
         
#      #累计入库数量
#      SELECT SUM(xccd301) INTO sr.xccd301_sum
#        FROM xccd_t
#       WHERE xccdent=g_enterprise 
#         AND xccdld =sr.xccdld 
#         AND xccd001=sr.xccd001 
#         AND xccd002=sr.xccd002 
#         AND xccd003=sr.xccd003 
#         AND (xccd004*12+xccd005)<=(sr.xccd004*12+sr.xccd005) 
#         AND xccd006=sr.xccd006
#    
#      IF sr.xccd301_sum IS NULL OR sr.xccd301_sum = 0 THEN
#         SELECT SUM(xcch301) INTO sr.xccd301_sum
#           FROM xcch_t
#          WHERE xcchent=g_enterprise 
#            AND xcchld =sr.xccdld 
#            AND xcch001=sr.xccd001 
#            AND xcch002=sr.xccd002 
#            AND xcch003=sr.xccd003 
#            AND (xcch004*12+xcch005)<=(sr.xccd004*12+sr.xccd005) 
#            AND xcch006=sr.xccd006
#      END IF
#      IF sr.xccd301_sum IS NULL THEN LET sr.xccd301_sum = 0 END IF
#      #累计投入工时
#      SELECT SUM(xcbk100) INTO sr.xcbk_t_xcbk100
#        FROM xcbk_t
#       WHERE xcbkent = g_enterprise
#         AND xcbkld  = sr.xccdld
#         AND xcbk001 = sr.xccd003
#         AND (xcbk002*12+xcbk003) <= (sr.xccd004*12+sr.xccd005)
#         AND xcbk005 = '1'
#         AND xcbk006 = sr.xccd006
#         
#      #本期投入工时
#      SELECT SUM(xcbk100) INTO sr.xcbk100_1
#        FROM xcbk_t
#       WHERE xcbkent = g_enterprise
#         AND xcbkld  = sr.xccdld
#         AND xcbk001 = sr.xccd003
#         AND xcbk002 = sr.xccd004
#         AND xcbk003 = sr.xccd005
#         AND xcbk005 = '1'
#         AND xcbk006 = sr.xccd006
      #160520-00004#5-mark-(E)
      
      #160520-00004#5-add-(S)
      EXECUTE axcq541_pre USING sr.xccdld,sr.xccd001,sr.xccd002,sr.xccd003,sr.xccd004,sr.xccd005,sr.xccd006
         INTO sr.xccdcomp,sr.xccd007,sr.xccd301,sr.xccd002_desc,sr.xccd007_desc,sr.xccdcomp_desc,sr.xccdld_desc,
              sr.xccd003_desc,sr.xccd001_desc,sr.sfaa_t_sfaa012,sr.sfaa_t_sfaa019,sr.sfaa_t_sfaa020,sr.sfaa_t_sfaa049,
              sr.xccd301_sum,sr.xcbk_t_xcbk100,sr.xcbk100_1,l_glaa001,l_glaa016,l_glaa020
     #160520-00004#5-add-(E)


      #160520-00004#5-mark-(S)   
#      PREPARE axcq541_ins_tmp_pre FROM g_sql_tmp
#      DECLARE axcq541_ins_tmp_cs CURSOR FOR axcq541_ins_tmp_pre
      #160520-00004#5-mark-(E)      
      OPEN axcq541_ins_tmp_cs USING g_enterprise,sr.xccdld,sr.xccd001,sr.xccd003,sr.xccd004,sr.xccd005,sr.xccd006,
                                    g_enterprise,sr.xccdld,sr.xccd001,sr.xccd003,sr.xccd004,sr.xccd005,sr.xccd006
      FOREACH axcq541_ins_tmp_cs INTO sr.xcce002,sr.xcce007,sr.xcce008,sr.xcce009, 
          sr.xcce201,sr.xcce202a,sr.xcce202b,sr.xcce202c, 
          sr.xcce202d,sr.xcce202e,sr.xcce202f,sr.xcce202g, 
          sr.xcce202h,sr.xcce202,sr.xcce301,sr.xcce302a, 
          sr.xcce302b,sr.xcce302c,sr.xcce302d,sr.xcce302e, 
          sr.xcce302f,sr.xcce302g,sr.xcce302h,sr.xcce302, 
          sr.xcce303,sr.xcce304a,sr.xcce304b,sr.xcce304c, 
          sr.xcce304d,sr.xcce304e,sr.xcce304f,sr.xcce304g, 
          sr.xcce304h,sr.xcce304,sr.xcce901,sr.xcce902a, 
          sr.xcce902b,sr.xcce902c,sr.xcce902d,sr.xcce902e, 
          sr.xcce902f,sr.xcce902g,sr.xcce902h,sr.xcce902, 
          sr.xcce002_desc,sr.xcce007_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         CALL s_desc_get_item_desc(sr.xcce007) RETURNING sr.xcce007_desc,sr.xcce007_desc_1
         
         SELECT xcbb005 INTO sr.xcbb_t_xcbb005 FROM xcbb_t 
          WHERE xcbbent = g_enterprise
            AND xcbbcomp = sr.xccdcomp
            AND xcbb001 = sr.xccd004 
            AND xcbb002 = sr.xccd005  
            AND xcbb003 = sr.xcce007 
            AND xcbb004 = sr.xcce008 
            
         CALL s_desc_get_unit_desc(sr.xcbb_t_xcbb005) RETURNING sr.xcbb005_desc
#wujie 150416 --begin
         CASE sr.xccd001
            WHEN '1' 
              LET l_curr = l_glaa001
            WHEN '2'
              LET l_curr = l_glaa016
            WHEN '3'
              LET l_curr = l_glaa020
         END CASE

#DL+OH+SUB的在制转出单价取值逻辑不同，为元件转出成本/单头主件本期入库数量，转出比率固定为1  
         IF sr.xcce007 ='DL+OH+SUB' THEN
            LET sr.xcce_price = sr.xcce302/sr.xccd301
            LET sr.xcce_conv_rate  = 1
         ELSE
            LET sr.xcce_price = sr.xcce302/sr.xcce301
            LET sr.xcce_conv_rate  = sr.xcce301/sr.xccd301
         END IF
         LET sr.xcce_conv_price = sr.xcce_conv_rate*sr.xcce_price
         CALL s_curr_round(sr.xccdcomp,l_curr,sr.xcce_conv_price,'1') RETURNING sr.xcce_conv_price       
         CALL s_curr_round(sr.xccdcomp,l_curr,sr.xcce_price,'1') RETURNING sr.xcce_price
#wujie 150416 --end
                              
         INSERT INTO axcq541_tmp(xccdcomp,xccdcomp_desc,xccdld,xccdld_desc,xccd004,xccd005,xccd001,xccd001_desc,xccd003,xccd003_desc,xccd002,xccd002_desc,xccd006,
            sfaa_t_sfaa019,sfaa_t_sfaa020,xccd007,xccd007_desc,sfaa_t_sfaa012,sfaa_t_sfaa049,xccd301_sum,xccd301,xcbk_t_xcbk100,xcbk100_1,
            xcce002,xcce002_desc,xcce007,xcce007_desc,xcce007_desc_1,xcce008,xcce009,xcbb_t_xcbb005,xcbb005_desc,xcce201 ,xcce202a,
            xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce202 ,xcce301 ,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,
            xcce302f,xcce302g,xcce302h,xcce302 ,xcce_price,xcce_conv_rate,xcce_conv_price,xcce303 ,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce304 ,
            xcce901 ,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcce902 ,xcce201_sum ,xcce202a_sum,xcce202b_sum,
            xcce202c_sum,xcce202d_sum,xcce202e_sum,xcce202f_sum,xcce202g_sum,xcce202h_sum,xcce202_sum ,xcce202_total,xcce301_sum ,xcce302a_sum,
            xcce302b_sum,xcce302c_sum,xcce302d_sum,xcce302e_sum,xcce302f_sum,xcce302g_sum,xcce302h_sum,xcce302_sum ,xcce302_total,xcce303_sum ,
            xcce304a_sum,xcce304b_sum,xcce304c_sum,xcce304d_sum,xcce304e_sum,xcce304f_sum,xcce304g_sum,xcce304h_sum,xcce304_sum ,
            xcce304_total,xcce901_sum ,xcce902a_sum,xcce902b_sum,xcce902c_sum,xcce902d_sum,xcce902e_sum,xcce902f_sum,xcce902g_sum,
            xcce902h_sum,xcce902_sum ,xcce902_total)
         VALUES(sr.xccdcomp,sr.xccdcomp_desc,sr.xccdld,sr.xccdld_desc,sr.xccd004,sr.xccd005,sr.xccd001,sr.xccd001_desc,sr.xccd003,sr.xccd003_desc,sr.xccd002,sr.xccd002_desc,sr.xccd006,
            sr.sfaa_t_sfaa019,sr.sfaa_t_sfaa020,sr.xccd007,sr.xccd007_desc,sr.sfaa_t_sfaa012,sr.sfaa_t_sfaa049,sr.xccd301_sum,sr.xccd301,sr.xcbk_t_xcbk100,sr.xcbk100_1,
            sr.xcce002,sr.xcce002_desc,sr.xcce007,sr.xcce007_desc,sr.xcce007_desc_1,sr.xcce008,sr.xcce009,sr.xcbb_t_xcbb005,sr.xcbb005_desc,sr.xcce201 ,sr.xcce202a,
            sr.xcce202b,sr.xcce202c,sr.xcce202d,sr.xcce202e,sr.xcce202f,sr.xcce202g,sr.xcce202h,sr.xcce202 ,sr.xcce301 ,sr.xcce302a,sr.xcce302b,sr.xcce302c,sr.xcce302d,sr.xcce302e,
            sr.xcce302f,sr.xcce302g,sr.xcce302h,sr.xcce302 ,sr.xcce_price,sr.xcce_conv_rate,sr.xcce_conv_price,sr.xcce303 ,sr.xcce304a,sr.xcce304b,sr.xcce304c,sr.xcce304d,sr.xcce304e,sr.xcce304f,sr.xcce304g,sr.xcce304h,sr.xcce304 ,
            sr.xcce901 ,sr.xcce902a,sr.xcce902b,sr.xcce902c,sr.xcce902d,sr.xcce902e,sr.xcce902f,sr.xcce902g,sr.xcce902h,sr.xcce902 ,sr.xcce201_sum ,sr.xcce202a_sum,sr.xcce202b_sum,
            sr.xcce202c_sum,sr.xcce202d_sum,sr.xcce202e_sum,sr.xcce202f_sum,sr.xcce202g_sum,sr.xcce202h_sum,sr.xcce202_sum ,sr.xcce202_total,sr.xcce301_sum ,sr.xcce302a_sum,
            sr.xcce302b_sum,sr.xcce302c_sum,sr.xcce302d_sum,sr.xcce302e_sum,sr.xcce302f_sum,sr.xcce302g_sum,sr.xcce302h_sum,sr.xcce302_sum ,sr.xcce302_total,sr.xcce303_sum ,
            sr.xcce304a_sum,sr.xcce304b_sum,sr.xcce304c_sum,sr.xcce304d_sum,sr.xcce304e_sum,sr.xcce304f_sum,sr.xcce304g_sum,sr.xcce304h_sum,sr.xcce304_sum ,
            sr.xcce304_total,sr.xcce901_sum ,sr.xcce902a_sum,sr.xcce902b_sum,sr.xcce902c_sum,sr.xcce902d_sum,sr.xcce902e_sum,sr.xcce902f_sum,sr.xcce902g_sum,
            sr.xcce902h_sum,sr.xcce902_sum ,sr.xcce902_total)                 
      END FOREACH
      
      FREE axcq541_ins_tmp_pre
      
      SELECT SUM(xcce201),SUM(xcce202a),SUM(xcce202b),SUM(xcce202c), 
              SUM(xcce202d),SUM(xcce202e),SUM(xcce202f),SUM(xcce202g), 
              SUM(xcce202h),SUM(xcce202),SUM(xcce301),SUM(xcce302a), 
              SUM(xcce302b),SUM(xcce302c),SUM(xcce302d),SUM(xcce302e), 
              SUM(xcce302f),SUM(xcce302g),SUM(xcce302h),SUM(xcce302), 
              SUM(xcce303),SUM(xcce304a),SUM(xcce304b),SUM(xcce304c), 
              SUM(xcce304d),SUM(xcce304e),SUM(xcce304f),SUM(xcce304g), 
              SUM(xcce304h),SUM(xcce304),SUM(xcce901),SUM(xcce902a), 
              SUM(xcce902b),SUM(xcce902c),SUM(xcce902d),SUM(xcce902e), 
              SUM(xcce902f),SUM(xcce902g),SUM(xcce902h),SUM(xcce902)
         INTO sr.xcce201_sum,sr.xcce202a_sum,sr.xcce202b_sum,sr.xcce202c_sum,
              sr.xcce202d_sum,sr.xcce202e_sum,sr.xcce202f_sum,sr.xcce202g_sum,
              sr.xcce202h_sum,sr.xcce202_sum,sr.xcce301_sum,sr.xcce302a_sum,
              sr.xcce302b_sum,sr.xcce302c_sum,sr.xcce302d_sum,sr.xcce302e_sum,
              sr.xcce302f_sum,sr.xcce302g_sum,sr.xcce302h_sum,sr.xcce302_sum,
              sr.xcce303_sum,sr.xcce304a_sum,sr.xcce304b_sum,sr.xcce304c_sum,
              sr.xcce304d_sum,sr.xcce304e_sum,sr.xcce304f_sum,sr.xcce304g_sum,
              sr.xcce304h_sum,sr.xcce304_sum,sr.xcce901_sum,sr.xcce902a_sum,
              sr.xcce902b_sum,sr.xcce902c_sum,sr.xcce902d_sum,sr.xcce902e_sum,
              sr.xcce902f_sum,sr.xcce902g_sum,sr.xcce902h_sum,sr.xcce902_sum
         FROM axcq541_tmp
        WHERE xccdld=sr.xccdld AND xccd001=sr.xccd001 AND xccd002=sr.xccd002 
          AND xccd003=sr.xccd003 AND xccd004=sr.xccd004 AND xccd005=sr.xccd005 AND xccd006=sr.xccd006
        
        LET sr.xcce202_total=sr.xcce202a_sum+sr.xcce202b_sum+sr.xcce202c_sum+sr.xcce202d_sum+sr.xcce202e_sum+sr.xcce202f_sum+sr.xcce202g_sum+sr.xcce202h_sum+sr.xcce202_sum    
        LET sr.xcce302_total=sr.xcce302a_sum+sr.xcce302b_sum+sr.xcce302c_sum+sr.xcce302d_sum+sr.xcce302e_sum+sr.xcce302f_sum+sr.xcce302g_sum+sr.xcce302h_sum+sr.xcce302_sum 
        LET sr.xcce304_total=sr.xcce304a_sum+sr.xcce304b_sum+sr.xcce304c_sum+sr.xcce304d_sum+sr.xcce304e_sum+sr.xcce304f_sum+sr.xcce304g_sum+sr.xcce304h_sum+sr.xcce304_sum 
        LET sr.xcce902_total=sr.xcce902a_sum+sr.xcce902b_sum+sr.xcce902c_sum+sr.xcce902d_sum+sr.xcce902e_sum+sr.xcce902f_sum+sr.xcce902g_sum+sr.xcce902h_sum+sr.xcce902_sum 

        UPDATE axcq541_tmp 
         SET (xcce201_sum,xcce202a_sum,xcce202b_sum,xcce202c_sum, 
              xcce202d_sum,xcce202e_sum,xcce202f_sum,xcce202g_sum, 
              xcce202h_sum,xcce202_sum,xcce301_sum,xcce302a_sum, 
              xcce302b_sum,xcce302c_sum,xcce302d_sum,xcce302e_sum, 
              xcce302f_sum,xcce302g_sum,xcce302h_sum,xcce302_sum, 
              xcce303_sum,xcce304a_sum,xcce304b_sum,xcce304c_sum, 
              xcce304d_sum,xcce304e_sum,xcce304f_sum,xcce304g_sum, 
              xcce304h_sum,xcce304_sum,xcce901_sum,xcce902a_sum, 
              xcce902b_sum,xcce902c_sum,xcce902d_sum,xcce902e_sum, 
              xcce902f_sum,xcce902g_sum,xcce902h_sum,xcce902_sum,
              xcce202_total,xcce302_total,xcce304_total,xcce902_total)
            =(sr.xcce201_sum,sr.xcce202a_sum,sr.xcce202b_sum,sr.xcce202c_sum,
              sr.xcce202d_sum,sr.xcce202e_sum,sr.xcce202f_sum,sr.xcce202g_sum,
              sr.xcce202h_sum,sr.xcce202_sum,sr.xcce301_sum,sr.xcce302a_sum,
              sr.xcce302b_sum,sr.xcce302c_sum,sr.xcce302d_sum,sr.xcce302e_sum,
              sr.xcce302f_sum,sr.xcce302g_sum,sr.xcce302h_sum,sr.xcce302_sum,
              sr.xcce303_sum,sr.xcce304a_sum,sr.xcce304b_sum,sr.xcce304c_sum,
              sr.xcce304d_sum,sr.xcce304e_sum,sr.xcce304f_sum,sr.xcce304g_sum,
              sr.xcce304h_sum,sr.xcce304_sum,sr.xcce901_sum,sr.xcce902a_sum,
              sr.xcce902b_sum,sr.xcce902c_sum,sr.xcce902d_sum,sr.xcce902e_sum,
              sr.xcce902f_sum,sr.xcce902g_sum,sr.xcce902h_sum,sr.xcce902_sum,
              sr.xcce202_total,sr.xcce302_total,sr.xcce304_total,sr.xcce902_total)
        WHERE xccdld=sr.xccdld AND xccd001=sr.xccd001 AND xccd002=sr.xccd002 
          AND xccd003=sr.xccd003 AND xccd004=sr.xccd004 AND xccd005=sr.xccd005 AND xccd006=sr.xccd006
   END FOR
   
   FREE axcq541_pre #160520-00004#5-add
END FUNCTION

################################################################################
# Descriptions...: filter過濾功能
# Memo...........:
# Usage..........: CALL axcq541_filter()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/11/30 By Sarah
# Modify.........: 151130-00003#18 add
################################################################################
PRIVATE FUNCTION axcq541_filter()

   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   #備份
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   LET g_wc_filter       = ''
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xcce002,xcce007,xcce008,xcce009,
                               xcce201,xcce202a,xcce202b,xcce202c,
                               xcce202d,xcce202e,xcce202f,xcce202g,
                               xcce202h,xcce202,xcce301_sum,xcce302a_sum,
                               xcce302b_sum,xcce302c_sum,xcce302d_sum,xcce302e_sum,
                               xcce302f_sum,xcce302g_sum,xcce302h_sum,xcce302_sum,
                               xcce301,xcce302a,xcce302b,xcce302c,
                               xcce302d,xcce302e,xcce302f,xcce302g,
                               xcce302h,xcce302,xcce_price,
                               xcce303,xcce304a,xcce304b,xcce304c,
                               xcce304d,xcce304e,xcce304f,xcce304g,
                               xcce304h,xcce304,xcce901,xcce902a,
                               xcce902b,xcce902c,xcce902d,xcce902e,
                               xcce902f,xcce902g,xcce902h,xcce902
           FROM s_detail1[1].xcce002,s_detail1[1].xcce007,s_detail1[1].xcce008,s_detail1[1].xcce009,
                s_detail1[1].xcce201,s_detail1[1].xcce202a,s_detail1[1].xcce202b,s_detail1[1].xcce202c,
                s_detail1[1].xcce202d,s_detail1[1].xcce202e,s_detail1[1].xcce202f,s_detail1[1].xcce202g,
                s_detail1[1].xcce202h,s_detail1[1].xcce202,s_detail1[1].xcce301_sum,s_detail1[1].xcce302a_sum,
                s_detail1[1].xcce302b_sum,s_detail1[1].xcce302c_sum,s_detail1[1].xcce302d_sum,s_detail1[1].xcce302e_sum,
                s_detail1[1].xcce302f_sum,s_detail1[1].xcce302g_sum,s_detail1[1].xcce302h_sum,s_detail1[1].xcce302_sum,
                s_detail1[1].xcce301,s_detail1[1].xcce302a,s_detail1[1].xcce302b,s_detail1[1].xcce302c,
                s_detail1[1].xcce302d,s_detail1[1].xcce302e,s_detail1[1].xcce302f,s_detail1[1].xcce302g,
                s_detail1[1].xcce302h,s_detail1[1].xcce302,s_detail1[1].xcce_price,
                s_detail1[1].xcce303,s_detail1[1].xcce304a,s_detail1[1].xcce304b,s_detail1[1].xcce304c,
                s_detail1[1].xcce304d,s_detail1[1].xcce304e,s_detail1[1].xcce304f,s_detail1[1].xcce304g,
                s_detail1[1].xcce304h,s_detail1[1].xcce304,s_detail1[1].xcce901,s_detail1[1].xcce902a,
                s_detail1[1].xcce902b,s_detail1[1].xcce902c,s_detail1[1].xcce902d,s_detail1[1].xcce902e,
                s_detail1[1].xcce902f,s_detail1[1].xcce902g,s_detail1[1].xcce902h,s_detail1[1].xcce902
 
         BEFORE CONSTRUCT
            DISPLAY axcq541_filter_parser('xcce002') TO s_detail1[1].xcce002
            DISPLAY axcq541_filter_parser('xcce007') TO s_detail1[1].xcce007
            DISPLAY axcq541_filter_parser('xcce008') TO s_detail1[1].xcce008
            DISPLAY axcq541_filter_parser('xcce009') TO s_detail1[1].xcce009
            DISPLAY axcq541_filter_parser('xcce201') TO s_detail1[1].xcce201
            DISPLAY axcq541_filter_parser('xcce202a') TO s_detail1[1].xcce202a
            DISPLAY axcq541_filter_parser('xcce202b') TO s_detail1[1].xcce202b
            DISPLAY axcq541_filter_parser('xcce202c') TO s_detail1[1].xcce202c
            DISPLAY axcq541_filter_parser('xcce202d') TO s_detail1[1].xcce202d
            DISPLAY axcq541_filter_parser('xcce202e') TO s_detail1[1].xcce202e
            DISPLAY axcq541_filter_parser('xcce202f') TO s_detail1[1].xcce202f
            DISPLAY axcq541_filter_parser('xcce202g') TO s_detail1[1].xcce202g
            DISPLAY axcq541_filter_parser('xcce202h') TO s_detail1[1].xcce202h
            DISPLAY axcq541_filter_parser('xcce202') TO s_detail1[1].xcce202
            DISPLAY axcq541_filter_parser('xcce301_sum') TO s_detail1[1].xcce301_sum
            DISPLAY axcq541_filter_parser('xcce302a_sum') TO s_detail1[1].xcce302a_sum
            DISPLAY axcq541_filter_parser('xcce302b_sum') TO s_detail1[1].xcce302b_sum
            DISPLAY axcq541_filter_parser('xcce302c_sum') TO s_detail1[1].xcce302c_sum
            DISPLAY axcq541_filter_parser('xcce302d_sum') TO s_detail1[1].xcce302d_sum
            DISPLAY axcq541_filter_parser('xcce302e_sum') TO s_detail1[1].xcce302e_sum
            DISPLAY axcq541_filter_parser('xcce302f_sum') TO s_detail1[1].xcce302f_sum
            DISPLAY axcq541_filter_parser('xcce302g_sum') TO s_detail1[1].xcce302g_sum
            DISPLAY axcq541_filter_parser('xcce302h_sum') TO s_detail1[1].xcce302h_sum
            DISPLAY axcq541_filter_parser('xcce302_sum') TO s_detail1[1].xcce302_sum
            DISPLAY axcq541_filter_parser('xcce301') TO s_detail1[1].xcce301
            DISPLAY axcq541_filter_parser('xcce302a') TO s_detail1[1].xcce302a
            DISPLAY axcq541_filter_parser('xcce302b') TO s_detail1[1].xcce302b
            DISPLAY axcq541_filter_parser('xcce302c') TO s_detail1[1].xcce302c
            DISPLAY axcq541_filter_parser('xcce302d') TO s_detail1[1].xcce302d
            DISPLAY axcq541_filter_parser('xcce302e') TO s_detail1[1].xcce302e
            DISPLAY axcq541_filter_parser('xcce302f') TO s_detail1[1].xcce302f
            DISPLAY axcq541_filter_parser('xcce302g') TO s_detail1[1].xcce302g
            DISPLAY axcq541_filter_parser('xcce302h') TO s_detail1[1].xcce302h
            DISPLAY axcq541_filter_parser('xcce302') TO s_detail1[1].xcce302
            DISPLAY axcq541_filter_parser('xcce_price') TO s_detail1[1].xcce_price
            DISPLAY axcq541_filter_parser('xcce303') TO s_detail1[1].xcce303
            DISPLAY axcq541_filter_parser('xcce304a') TO s_detail1[1].xcce304a
            DISPLAY axcq541_filter_parser('xcce304b') TO s_detail1[1].xcce304b
            DISPLAY axcq541_filter_parser('xcce304c') TO s_detail1[1].xcce304c
            DISPLAY axcq541_filter_parser('xcce304d') TO s_detail1[1].xcce304d
            DISPLAY axcq541_filter_parser('xcce304e') TO s_detail1[1].xcce304e
            DISPLAY axcq541_filter_parser('xcce304f') TO s_detail1[1].xcce304f
            DISPLAY axcq541_filter_parser('xcce304g') TO s_detail1[1].xcce304g
            DISPLAY axcq541_filter_parser('xcce304h') TO s_detail1[1].xcce304h
            DISPLAY axcq541_filter_parser('xcce304') TO s_detail1[1].xcce304
            DISPLAY axcq541_filter_parser('xcce901') TO s_detail1[1].xcce901
            DISPLAY axcq541_filter_parser('xcce902a') TO s_detail1[1].xcce902a
            DISPLAY axcq541_filter_parser('xcce902b') TO s_detail1[1].xcce902b
            DISPLAY axcq541_filter_parser('xcce902c') TO s_detail1[1].xcce902c
            DISPLAY axcq541_filter_parser('xcce902d') TO s_detail1[1].xcce902d
            DISPLAY axcq541_filter_parser('xcce902e') TO s_detail1[1].xcce902e
            DISPLAY axcq541_filter_parser('xcce902f') TO s_detail1[1].xcce902f
            DISPLAY axcq541_filter_parser('xcce902g') TO s_detail1[1].xcce902g
            DISPLAY axcq541_filter_parser('xcce902h') TO s_detail1[1].xcce902h
            DISPLAY axcq541_filter_parser('xcce902') TO s_detail1[1].xcce902
 
         #--单身开窗
         ON ACTION controlp INFIELD xcce002
            #成本域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce002  #顯示到畫面上
            NEXT FIELD xcce002                     #返回原欄位

         ON ACTION controlp INFIELD xcce007
            #元件編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce007  #顯示到畫面上
            NEXT FIELD xcce007                     #返回原欄位

         ON ACTION controlp INFIELD xcce008
            #特性
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce008  #顯示到畫面上
            NEXT FIELD xcce008                     #返回原欄位       

         ON ACTION controlp INFIELD xcce009
            #批號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inad003()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce009  #顯示到畫面上
            NEXT FIELD xcce009                     #返回原欄位 
            
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

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
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
   
   CALL axcq541_filter_show('xcce002','xcce_t.xcce002')
   CALL axcq541_filter_show('xcce007','xcce_t.xcce007')
   CALL axcq541_filter_show('xcce008','xcce_t.xcce008')
   CALL axcq541_filter_show('xcce009','xcce_t.xcce009')
   CALL axcq541_filter_show('xcce201','xcce_t.xcce201')
   CALL axcq541_filter_show('xcce202a','xcce_t.xcce202a')
   CALL axcq541_filter_show('xcce202b','xcce_t.xcce202b')
   CALL axcq541_filter_show('xcce202c','xcce_t.xcce202c')
   CALL axcq541_filter_show('xcce202d','xcce_t.xcce202d')
   CALL axcq541_filter_show('xcce202e','xcce_t.xcce202e')
   CALL axcq541_filter_show('xcce202f','xcce_t.xcce202f')
   CALL axcq541_filter_show('xcce202g','xcce_t.xcce202g')
   CALL axcq541_filter_show('xcce202h','xcce_t.xcce202h')
   CALL axcq541_filter_show('xcce202','xcce_t.xcce202')
   CALL axcq541_filter_show('xcce301_sum','xcce301_sum')
   CALL axcq541_filter_show('xcce302a_sum','xcce302a_sum')
   CALL axcq541_filter_show('xcce302b_sum','xcce302b_sum')
   CALL axcq541_filter_show('xcce302c_sum','xcce302c_sum')
   CALL axcq541_filter_show('xcce302d_sum','xcce302d_sum')
   CALL axcq541_filter_show('xcce302e_sum','xcce302e_sum')
   CALL axcq541_filter_show('xcce302f_sum','xcce302f_sum')
   CALL axcq541_filter_show('xcce302g_sum','xcce302g_sum')
   CALL axcq541_filter_show('xcce302h_sum','xcce302h_sum')
   CALL axcq541_filter_show('xcce302_sum','xcce302_sum')
   CALL axcq541_filter_show('xcce301','xcce301')
   CALL axcq541_filter_show('xcce302a','xcce302a')
   CALL axcq541_filter_show('xcce302b','xcce302b')
   CALL axcq541_filter_show('xcce302c','xcce302c')
   CALL axcq541_filter_show('xcce302d','xcce302d')
   CALL axcq541_filter_show('xcce302e','xcce302e')
   CALL axcq541_filter_show('xcce302f','xcce302f')
   CALL axcq541_filter_show('xcce302g','xcce302g')
   CALL axcq541_filter_show('xcce302h','xcce302h')
   CALL axcq541_filter_show('xcce302','xcce302')
   CALL axcq541_filter_show('xcce_price','xcce_price')
   CALL axcq541_filter_show('xcce303','xcce_t.xcce303')
   CALL axcq541_filter_show('xcce304a','xcce_t.xcce304a')
   CALL axcq541_filter_show('xcce304b','xcce_t.xcce304b')
   CALL axcq541_filter_show('xcce304c','xcce_t.xcce304c')
   CALL axcq541_filter_show('xcce304d','xcce_t.xcce304d')
   CALL axcq541_filter_show('xcce304e','xcce_t.xcce304e')
   CALL axcq541_filter_show('xcce304f','xcce_t.xcce304f')
   CALL axcq541_filter_show('xcce304g','xcce_t.xcce304g')
   CALL axcq541_filter_show('xcce304h','xcce_t.xcce304h')
   CALL axcq541_filter_show('xcce304','xcce_t.xcce304')
   CALL axcq541_filter_show('xcce901','xcce_t.xcce901')
   CALL axcq541_filter_show('xcce902a','xcce_t.xcce902a')
   CALL axcq541_filter_show('xcce902b','xcce_t.xcce902b')
   CALL axcq541_filter_show('xcce902c','xcce_t.xcce902c')
   CALL axcq541_filter_show('xcce902d','xcce_t.xcce902d')
   CALL axcq541_filter_show('xcce902e','xcce_t.xcce902e')
   CALL axcq541_filter_show('xcce902f','xcce_t.xcce902f')
   CALL axcq541_filter_show('xcce902g','xcce_t.xcce902g')
   CALL axcq541_filter_show('xcce902h','xcce_t.xcce902h')
   CALL axcq541_filter_show('xcce902','xcce_t.xcce902')

   CALL axcq541_b_fill()
   CALL axcq541_show()

END FUNCTION

################################################################################
# Descriptions...: filter欄位解析
# Memo...........:
# Usage..........: CALL axcq541_filter_parser(ps_field)
#                  RETURNING ls_var
# Input parameter: ps_field   欄位代號
# Return code....: ls_var     欄位查詢條件
# Date & Author..: 15/11/30 By Sarah
# Modify.........: 151130-00003#18 add
################################################################################
PRIVATE FUNCTION axcq541_filter_parser(ps_field)
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

################################################################################
# Descriptions...: Browser標題欄位顯示搜尋條件
# Memo...........:
# Usage..........: CALL axcq541_filter_show(ps_field,ps_object)
# Input parameter: ps_field   欄位代號
#                : ps_object  物件代號
# Return code....: 無
# Date & Author..: 15/11/30 By Sarah
# Modify.........: 151130-00003#18 add
################################################################################
PRIVATE FUNCTION axcq541_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   
   LET ls_name = ps_object

   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF

   #顯示資料組合
   LET ls_condition = axcq541_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
   
END FUNCTION

 
{</section>}
 
