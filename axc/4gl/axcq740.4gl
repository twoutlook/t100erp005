#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq740.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000012
#+ 
#+ Filename...: axcq740
#+ Description: 在制成本次要素匯總查詢作業
#+ Creator....: 03297(2014-10-11 15:47:29)
#+ Modifier...: 03297(2014-10-15 09:51:42) -SD/PR- 08734
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axcq740.global" >}
#150319-00004#22              by rayhuang    新增Q轉XG功能
#160318-00025#10   2016/04/22 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160520-00003#14   2016/05/23 By lixiang     效能优化
#160802-00020#8    2016/09/29 By dorislai    增加帳套權限管控、法人權限管控
#161108-00012#4    2016/11/09 By 08734       g_browser_cnt 由num5改為num10
#161208-00014#1    2016/12/13 By 02040       增加本期在製投入數量小計/總計
#161124-00048#17   2016/12/16 By 08734       星号整批调整
        
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
   xccd004 LIKE xccd_t.xccd004, 
   xccd001 LIKE xccd_t.xccd001, 
   xccd001_desc LIKE type_t.chr80,
   xccdld LIKE xccd_t.xccdld, 
   xccdld_desc LIKE type_t.chr80, 
   xccd005 LIKE xccd_t.xccd005, 
   xccd003 LIKE xccd_t.xccd003, 
   xccd003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcde_d        RECORD
       sfaasite LIKE sfaa_t.sfaasite, 
   sfaasite_desc LIKE type_t.chr500, 
   xccd002 LIKE xccd_t.xccd002, 
   xccd002_desc LIKE type_t.chr500, 
   xccd006 LIKE xccd_t.xccd006, 
   xcde007 LIKE xcde_t.xcde007, 
   xcde007_desc LIKE type_t.chr500, 
   xcde007_desc_desc LIKE type_t.chr500, 
   xcde008 LIKE xcde_t.xcde008, 
   xcde009 LIKE xcde_t.xcde009, 
   xcde010 LIKE xcde_t.xcde010, 
   xcde010_desc LIKE type_t.chr500, 
   xcbb005 LIKE type_t.chr10, 
   xcde101 LIKE xcde_t.xcde101, 
   xcde102 LIKE xcde_t.xcde102, 
   xcde201 LIKE xcde_t.xcde201, 
   xcde202 LIKE xcde_t.xcde202, 
   xcde301 LIKE xcde_t.xcde301, 
   xcde302 LIKE xcde_t.xcde302, 
   xcde303 LIKE xcde_t.xcde303, 
   xcde304 LIKE xcde_t.xcde304, 
   xcde307 LIKE xcde_t.xcde307, 
   xcde308 LIKE xcde_t.xcde308, 
   xcde901 LIKE xcde_t.xcde901, 
   xcde902 LIKE xcde_t.xcde902
       END RECORD
PRIVATE TYPE type_g_xcde2_d RECORD
       sfaasite LIKE sfaa_t.sfaasite,
   sfaasite_2_desc LIKE type_t.chr500, 
   xccd002 LIKE xccd_t.xccd002, 
   xccd002_2_desc LIKE type_t.chr500, 
   xccd006 LIKE xccd_t.xccd006, 
   xcde007 LIKE xcde_t.xcde007, 
   xcde007_2_desc LIKE type_t.chr500, 
   xcde007_2_desc_desc LIKE type_t.chr500, 
   xcde008 LIKE xcde_t.xcde008, 
   xcde009 LIKE xcde_t.xcde009, 
   xcde010 LIKE xcde_t.xcde010, 
   xcde010_2_desc LIKE type_t.chr500, 
   xcbb005 LIKE xcbb_t.xcbb005, 
   xcde101 LIKE xcde_t.xcde101, 
   xcde102 LIKE xcde_t.xcde102, 
   xcde201 LIKE xcde_t.xcde201, 
   xcde202 LIKE xcde_t.xcde202, 
   xcde301 LIKE xcde_t.xcde301, 
   xcde302 LIKE xcde_t.xcde302, 
   xcde303 LIKE xcde_t.xcde303, 
   xcde304 LIKE xcde_t.xcde304, 
   xcde307 LIKE xcde_t.xcde307, 
   xcde308 LIKE xcde_t.xcde308, 
   xcde901 LIKE xcde_t.xcde901, 
   xcde902 LIKE xcde_t.xcde902
       END RECORD
PRIVATE TYPE type_g_xcde3_d RECORD
       sfaasite LIKE sfaa_t.sfaasite,
   sfaasite_3_desc LIKE type_t.chr500, 
   xccd002 LIKE xccd_t.xccd002, 
   xccd002_3_desc LIKE type_t.chr500, 
   xccd006 LIKE xccd_t.xccd006, 
   xcdi007 LIKE xcdi_t.xcdi007, 
   xcdi007_desc LIKE type_t.chr500, 
   xcdi007_desc_desc LIKE type_t.chr500, 
   xcdi008 LIKE xcdi_t.xcdi008, 
   xcdi009 LIKE xcdi_t.xcdi009, 
   xcdi010 LIKE xcdi_t.xcdi010, 
   xcdi010_desc LIKE type_t.chr500, 
   xcbb005 LIKE xcbb_t.xcbb005, 
   xcdi101 LIKE xcdi_t.xcdi101, 
   xcdi102 LIKE xcdi_t.xcdi102, 
   xcdi201 LIKE xcdi_t.xcdi201, 
   xcdi202 LIKE xcdi_t.xcdi202, 
   xcdi301 LIKE xcdi_t.xcdi301, 
   xcdi302 LIKE xcdi_t.xcdi302, 
   xcdi303 LIKE xcdi_t.xcdi303, 
   xcdi304 LIKE xcdi_t.xcdi304, 
   xcdi901 LIKE xcdi_t.xcdi901, 
   xcdi902 LIKE xcdi_t.xcdi902
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_xccd_m          type_g_xccd_m
DEFINE g_xccd_m_t        type_g_xccd_m
DEFINE g_xccd_m_o        type_g_xccd_m
 
   DEFINE g_xccd004_t LIKE xccd_t.xccd004
DEFINE g_xccd001_t LIKE xccd_t.xccd001
DEFINE g_xccdld_t LIKE xccd_t.xccdld
DEFINE g_xccd005_t LIKE xccd_t.xccd005
DEFINE g_xccd003_t LIKE xccd_t.xccd003
 
 
DEFINE g_xcde_d          DYNAMIC ARRAY OF type_g_xcde_d
DEFINE g_xcde_d_t        type_g_xcde_d
DEFINE g_xcde_d_o        type_g_xcde_d
DEFINE g_xcde2_d   DYNAMIC ARRAY OF type_g_xcde2_d
DEFINE g_xcde2_d_t type_g_xcde2_d
DEFINE g_xcde2_d_o type_g_xcde2_d
DEFINE g_xcde3_d   DYNAMIC ARRAY OF type_g_xcde3_d
DEFINE g_xcde3_d_t type_g_xcde3_d
DEFINE g_xcde3_d_o type_g_xcde3_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_xccdld LIKE xccd_t.xccdld,
      b_xccd001 LIKE xccd_t.xccd001,      
      b_xccd003 LIKE xccd_t.xccd003,
      b_xccd004 LIKE xccd_t.xccd004,
      b_xccd005 LIKE xccd_t.xccd005      
      END RECORD 
      
DEFINE g_browser_f  RECORD #資料瀏覽之欄位 
       b_statepic     LIKE type_t.chr50,
          b_xccdld LIKE xccd_t.xccdld,
      b_xccd001 LIKE xccd_t.xccd001,
      b_xccd003 LIKE xccd_t.xccd003,
      b_xccd004 LIKE xccd_t.xccd004,
      b_xccd005 LIKE xccd_t.xccd005
      END RECORD 
      
DEFINE g_detail_multi_table_t    RECORD
      xccdld LIKE xccd_t.xccdld,
      xccd001 LIKE xccd_t.xccd001,
      xccd002 LIKE xccd_t.xccd002,
      xccd003 LIKE xccd_t.xccd003,
      xccd004 LIKE xccd_t.xccd004,
      xccd005 LIKE xccd_t.xccd005,
      xccd006 LIKE xccd_t.xccd006#,
#      xccd002 LIKE xccd_t.xccd002,
#      xccd006 LIKE xccd_t.xccd006
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10   #161108-00012#4 num5==》num10        
DEFINE l_ac                  LIKE type_t.num10   #161108-00012#4 num5==》num10  
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num10    #161108-00012#4 num5==》num10       
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數   #161108-00012#4 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數   #161108-00012#4 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數   #161108-00012#4 num5==》num10
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數       #161108-00012#4 num5==》num10
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數   #161108-00012#4 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#4 num5==》num10
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數   #161108-00012#4 num5==》num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數   #161108-00012#4 num5==》num10
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_wc2_table3          STRING
DEFINE g_wc2_table4          STRING
DEFINE g_wc2_table5          STRING
DEFINE g_wc2_table6          STRING
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150113
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150113
DEFINE g_wc_cs_ld            STRING                #160802-00020#8-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#8-add
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axcq740.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
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
   #160802-00020#8-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#8-add-(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT xccdcomp,'',xccd004,xccd001,xccdld,'',xccd005,xccd003,''", 
                      " FROM xccd_t",
                      " WHERE xccdent= ? AND xccdld=? AND xccd001=? AND xccd002=? AND xccd003=? AND  
                          xccd004=? AND xccd005=? AND xccd006=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq740_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xccdcomp,t0.xccd004,t0.xccd001,t0.xccdld,t0.xccd005,t0.xccd003",
               " FROM xccd_t t0",
               
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND t0.xccdld = ? AND t0.xccd001 = ? AND t0.xccd002 = ? AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ? AND t0.xccd006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   LET g_sql = " SELECT UNIQUE t0.xccdcomp,t0.xccd004,t0.xccd001,t0.xccdld,t0.xccd005,t0.xccd003",
               " FROM xccd_t t0",
               
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND t0.xccdld = ? AND t0.xccd001 = ?  AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ? "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE axcq740_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq740 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq740_init()   
 
      #進入選單 Menu (="N")
      CALL axcq740_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq740
      
   END IF 
   
   CLOSE axcq740_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axcq740.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq740_init()
   #add-point:init段define
   
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   CALL axcq740_x01_tmp()               #150319-00004#22
   CALL cl_set_combo_scc('xccd001','8914')
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc,xccd002_2,xccd002_2_desc,xccd002_3,xccd002_3_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccd002,xccd002_desc,xccd002_2,xccd002_2_desc,xccd002_3,xccd002_3_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcdi008',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcdi008',FALSE)                
   END IF   
   #fengmy 150113----end  
   #end add-point
   
   CALL axcq740_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq740.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq740_ui_dialog()
   DEFINE li_idx    LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define

   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE 
   
      #先填充browser資料
      CALL axcq740_browser_fill("")
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
 
 
               
      
         
        
         DISPLAY ARRAY g_xcde_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq740_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL axcq740_idx_chk()
               #add-point:page1自定義行為

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xcde2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq740_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axcq740_idx_chk()
               #add-point:page2自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xcde3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq740_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL axcq740_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array

         #end add-point
         
      
         BEFORE DIALOG
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
               CALL axcq740_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq740_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axcq740_idx_chk()
            
            #add-point:ui_dialog段before_dialog2

            #end add-point
        
 
 
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq740_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq740_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL axcq740_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            CALL axcq740_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq740_idx_chk()
            
         ON ACTION previous
            CALL axcq740_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq740_idx_chk()
            
         ON ACTION jump
            CALL axcq740_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq740_idx_chk()
            
         ON ACTION next
            CALL axcq740_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq740_idx_chk()
            
         ON ACTION last
            CALL axcq740_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq740_idx_chk()
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_xcde_d)
                  LET g_export_node[2] = base.typeInfo.create(g_xcde2_d)
                  LET g_export_node[3] = base.typeInfo.create(g_xcde3_d)
 
                  #add-point:ON ACTION exporttoexcel
                  LET g_export_id[1]="s_detail1"
                  LET g_export_id[2]="s_detail2"
                  LET g_export_id[3]="s_detail3"
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
            
       
         #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
    
         
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               #150319-00004#22-----s
               CALL axcq740_insert_tmp()
               CALL axcq740_x01(" 1 = 1","axcq740_x01_tmp",g_para_data,g_para_data1)
               #150319-00004#22-----e
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq740_query()
               #add-point:ON ACTION query

               #END add-point
               #此段落由子樣板a59產生  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
			   
 
 
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               
            END IF
 
 
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL axcq740_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq740_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq740_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
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
 
{<section id="axcq740.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq740_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
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

   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd003,xccd004,xccd005 ",
                      " FROM xccd_t ",
                      " ",
                      " LEFT JOIN xcde_t ON xcdeent = xccdent AND xccdld = xcdeld AND xccd001 = xcde001 AND xccd003 = xcde003 AND xccd004 = xcde004 AND xccd005 = xcde005  ",
                      " LEFT JOIN xcdi_t ON xcdient = xccdent AND xccdld = xcdild AND xccd001 = xcdi001 AND xccd003 = xcdi003 AND xccd004 = xcdi004 AND xccd005 = xcdi005 ", 
 
 
 
                      " ", 
                      " LEFT JOIN xccd_t ON xccdent = '"||g_enterprise||"' AND xccdld = xccdld AND xccd001 = xccd001 AND xccd003 = xccd003 AND xccd004 = xccd004 AND xccd005 = xccd005  ", 
                      " WHERE xccdent = '" ||g_enterprise|| "' AND xcdeent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd003,xccd004,xccd005 ",
                      " FROM xccd_t ", 
                      "  ",
                      "  ",
                      " WHERE xccdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccd_t")
   END IF
   
   #add-point:browser_fill,cnt wc
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
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前

   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   IF g_browser_cnt > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_rec
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
   LET g_sql = " SELECT DISTINCT '',t0.xccdld,t0.xccd001,t0.xccd003,t0.xccd004,t0.xccd005 ",
               " FROM xccd_t t0",
               "  ",
               "  LEFT JOIN xcde_t ON xcdeent = xccdent AND xccdld = xcdeld AND xccd001 = xcde001 AND xccd003 = xcde003 AND xccd004 = xcde004 AND xccd005 = xcde005  ",
               "  LEFT JOIN xcdi_t ON xcdient = xccdent AND xccdld = xcdild AND xccd001 = xcdi001 AND xccd003 = xcdi003 AND xccd004 = xcdi004 AND xccd005 = xcdi005 ",
 
 
 
             # "  LEFT JOIN xccd_t ON xccdent = '"||g_enterprise||"' AND xccdld = xccdld AND xccd001 = xccd001 AND xccd003 = xccd003 AND xccd004 = xccd004 AND xccd005 = xccd005 ",
               
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xccd_t")
   #add-point:browser_fill,sql wc
   #160802-00020#8-add-(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xccdld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xccdcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#8-add-(E)
   #end add-point
   LET g_sql = g_sql, " ORDER BY xccdld,xccd001,xccd003,xccd004,xccd005 ",g_order
 
   #add-point:browser_fill,before_prepare

   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill段open cursor

   #end add-point
   
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xccdld,g_browser[g_cnt].b_xccd001, 
       g_browser[g_cnt].b_xccd003,g_browser[g_cnt].b_xccd004,g_browser[g_cnt].b_xccd005 
       
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
      IF g_cnt > g_max_rec THEN
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
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   DISPLAY g_current_idx TO FORMONLY.b_index   #當下筆數的顯示
   DISPLAY g_current_idx TO FORMONLY.h_index   #當下筆數的顯示
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", FALSE)
   END IF
   
   #add-point:browser_fill段結束前

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq740_ui_headershow()
   #add-point:ui_headershow段define

   #end add-point    
   
   LET g_xccd_m.xccdld = g_browser[g_current_idx].b_xccdld   
   LET g_xccd_m.xccd001 = g_browser[g_current_idx].b_xccd001   
   LET g_xccd_m.xccd003 = g_browser[g_current_idx].b_xccd003   
   LET g_xccd_m.xccd004 = g_browser[g_current_idx].b_xccd004   
   LET g_xccd_m.xccd005 = g_browser[g_current_idx].b_xccd005 
 
   EXECUTE axcq740_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd001, 
       g_xccd_m.xccdld,g_xccd_m.xccd005,g_xccd_m.xccd003
   CALL axcq740_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq740_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq740_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define

   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xccdld = g_xccd_m.xccdld 
         AND g_browser[l_i].b_xccd001 = g_xccd_m.xccd001        
         AND g_browser[l_i].b_xccd003 = g_xccd_m.xccd003 
         AND g_browser[l_i].b_xccd004 = g_xccd_m.xccd004 
         AND g_browser[l_i].b_xccd005 = g_xccd_m.xccd005 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser.getLength()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq740_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

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
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前

   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccdcomp,xccd004,xccd001,xccdld,xccd005,xccd003
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            CALL axcq740_default()
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xccdcomp
         ON ACTION controlp INFIELD xccdcomp
            #add-point:ON ACTION controlp INFIELD xccdcomp
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
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccdcomp
            #add-point:BEFORE FIELD xccdcomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccdcomp
            
            #add-point:AFTER FIELD xccdcomp

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd004
            #add-point:BEFORE FIELD xccd004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd004
            
            #add-point:AFTER FIELD xccd004

            #END add-point
            
 
         #Ctrlp:construct.c.xccd004
         ON ACTION controlp INFIELD xccd004
            #add-point:ON ACTION controlp INFIELD xccd004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd001
            #add-point:BEFORE FIELD xccd001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd001
            
            #add-point:AFTER FIELD xccd001

            #END add-point
            
 
         #Ctrlp:construct.c.xccd001
         ON ACTION controlp INFIELD xccd001
            #add-point:ON ACTION controlp INFIELD xccd001

            #END add-point
 
         #Ctrlp:construct.c.xccdld
         ON ACTION controlp INFIELD xccdld
            #add-point:ON ACTION controlp INFIELD xccdld
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
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccdld
            #add-point:BEFORE FIELD xccdld

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccdld
            
            #add-point:AFTER FIELD xccdld

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd005
            #add-point:BEFORE FIELD xccd005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd005
            
            #add-point:AFTER FIELD xccd005

            #END add-point
            
 
         #Ctrlp:construct.c.xccd005
         ON ACTION controlp INFIELD xccd005
            #add-point:ON ACTION controlp INFIELD xccd005

            #END add-point
 
         #Ctrlp:construct.c.xccd003
         ON ACTION controlp INFIELD xccd003
            #add-point:ON ACTION controlp INFIELD xccd003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd003  #顯示到畫面上
            NEXT FIELD xccd003                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd003
            #add-point:BEFORE FIELD xccd003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd003
            
            #add-point:AFTER FIELD xccd003

            #END add-point
            
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON sfaasite,xccd002,xccd006,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102, 
          xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902
           FROM s_detail1[1].sfaasite,s_detail1[1].xccd002,s_detail1[1].xccd006,s_detail1[1].xcde007, 
               s_detail1[1].xcde008,s_detail1[1].xcde009,s_detail1[1].xcde010,s_detail1[1].xcde101,s_detail1[1].xcde102, 
               s_detail1[1].xcde201,s_detail1[1].xcde202,s_detail1[1].xcde301,s_detail1[1].xcde302,s_detail1[1].xcde303, 
               s_detail1[1].xcde304,s_detail1[1].xcde307,s_detail1[1].xcde308,s_detail1[1].xcde901,s_detail1[1].xcde902 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.sfaasite
         ON ACTION controlp INFIELD sfaasite
            #add-point:ON ACTION controlp INFIELD sfaasite
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaasite  #顯示到畫面上
            NEXT FIELD sfaasite                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfaasite
            #add-point:BEFORE FIELD xcdecomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfaasite
            
            #add-point:AFTER FIELD xcdecomp

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccd002
         ON ACTION controlp INFIELD xccd002
            #add-point:ON ACTION controlp INFIELD xccd002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd002  #顯示到畫面上
            NEXT FIELD xccd002                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd002
            #add-point:BEFORE FIELD xccd002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd002
            
            #add-point:AFTER FIELD xccd002

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd006
            #add-point:BEFORE FIELD xccd006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd006
            
            #add-point:AFTER FIELD xccd006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccd006
         ON ACTION controlp INFIELD xccd006
            #add-point:ON ACTION controlp INFIELD xccd006

            #END add-point
 
         #Ctrlp:construct.c.page1.xcde007
         ON ACTION controlp INFIELD xcde007
            #add-point:ON ACTION controlp INFIELD xcde007
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde007  #顯示到畫面上
            NEXT FIELD xcde007                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde007
            #add-point:BEFORE FIELD xcde007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde007
            
            #add-point:AFTER FIELD xcde007

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde008
         ON ACTION controlp INFIELD xcde008
            #add-point:ON ACTION controlp INFIELD xcde008
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde008  #顯示到畫面上
            NEXT FIELD xcde008                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde008
            #add-point:BEFORE FIELD xcde008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde008
            
            #add-point:AFTER FIELD xcde008

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde009
         ON ACTION controlp INFIELD xcde009
            #add-point:ON ACTION controlp INFIELD xcde009
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde009  #顯示到畫面上
            NEXT FIELD xcde009                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde009
            #add-point:BEFORE FIELD xcde009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde009
            
            #add-point:AFTER FIELD xcde009

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde010
         ON ACTION controlp INFIELD xcde010
            #add-point:ON ACTION controlp INFIELD xcde010
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcau001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde010  #顯示到畫面上
            NEXT FIELD xcde010                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde010
            #add-point:BEFORE FIELD xcde010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde010
            
            #add-point:AFTER FIELD xcde010

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde101
            #add-point:BEFORE FIELD xcde101

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde101
            
            #add-point:AFTER FIELD xcde101

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde101
         ON ACTION controlp INFIELD xcde101
            #add-point:ON ACTION controlp INFIELD xcde101

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde102
            #add-point:BEFORE FIELD xcde102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde102
            
            #add-point:AFTER FIELD xcde102

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde102
         ON ACTION controlp INFIELD xcde102
            #add-point:ON ACTION controlp INFIELD xcde102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde201
            #add-point:BEFORE FIELD xcde201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde201
            
            #add-point:AFTER FIELD xcde201

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde201
         ON ACTION controlp INFIELD xcde201
            #add-point:ON ACTION controlp INFIELD xcde201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde202
            #add-point:BEFORE FIELD xcde202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde202
            
            #add-point:AFTER FIELD xcde202

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde202
         ON ACTION controlp INFIELD xcde202
            #add-point:ON ACTION controlp INFIELD xcde202

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde301
            #add-point:BEFORE FIELD xcde301

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde301
            
            #add-point:AFTER FIELD xcde301

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde301
         ON ACTION controlp INFIELD xcde301
            #add-point:ON ACTION controlp INFIELD xcde301

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde302
            #add-point:BEFORE FIELD xcde302

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde302
            
            #add-point:AFTER FIELD xcde302

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde302
         ON ACTION controlp INFIELD xcde302
            #add-point:ON ACTION controlp INFIELD xcde302

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde303
            #add-point:BEFORE FIELD xcde303

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde303
            
            #add-point:AFTER FIELD xcde303

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde303
         ON ACTION controlp INFIELD xcde303
            #add-point:ON ACTION controlp INFIELD xcde303

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde304
            #add-point:BEFORE FIELD xcde304

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde304
            
            #add-point:AFTER FIELD xcde304

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde304
         ON ACTION controlp INFIELD xcde304
            #add-point:ON ACTION controlp INFIELD xcde304

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde307
            #add-point:BEFORE FIELD xcde307

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde307
            
            #add-point:AFTER FIELD xcde307

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde307
         ON ACTION controlp INFIELD xcde307
            #add-point:ON ACTION controlp INFIELD xcde307

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde308
            #add-point:BEFORE FIELD xcde308

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde308
            
            #add-point:AFTER FIELD xcde308

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde308
         ON ACTION controlp INFIELD xcde308
            #add-point:ON ACTION controlp INFIELD xcde308

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde901
            #add-point:BEFORE FIELD xcde901

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde901
            
            #add-point:AFTER FIELD xcde901

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde901
         ON ACTION controlp INFIELD xcde901
            #add-point:ON ACTION controlp INFIELD xcde901

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde902
            #add-point:BEFORE FIELD xcde902

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde902
            
            #add-point:AFTER FIELD xcde902

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde902
         ON ACTION controlp INFIELD xcde902
            #add-point:ON ACTION controlp INFIELD xcde902

            #END add-point
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON sfaasite,xccd002,xccd006,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, 
          xcdi301,xcdi302,xcdi303,xcdi304,xcdi901,xcdi902
           FROM s_detail3[1].sfaasite_3,s_detail3[1].xccd002_3,s_detail3[1].xccd006_3,s_detail3[1].xcdi007,s_detail3[1].xcdi008,s_detail3[1].xcdi009, 
               s_detail3[1].xcdi010,s_detail3[1].xcdi101,s_detail3[1].xcdi102,s_detail3[1].xcdi201,s_detail3[1].xcdi202, 
               s_detail3[1].xcdi301,s_detail3[1].xcdi302,s_detail3[1].xcdi303,s_detail3[1].xcdi304,s_detail3[1].xcdi901, 
               s_detail3[1].xcdi902
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #此段落由子樣板a01產生
         BEFORE FIELD sfaasite_3
            #add-point:BEFORE FIELD xcdicomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfaasite_3
            
            #add-point:AFTER FIELD xcdicomp

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdicomp
         ON ACTION controlp INFIELD sfaasite_3
            #add-point:ON ACTION controlp INFIELD xcdicomp

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi007
            #add-point:BEFORE FIELD xcdi007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi007
            
            #add-point:AFTER FIELD xcdi007

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi007
         ON ACTION controlp INFIELD xcdi007
            #add-point:ON ACTION controlp INFIELD xcdi007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi008
            #add-point:BEFORE FIELD xcdi008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi008
            
            #add-point:AFTER FIELD xcdi008

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi008
         ON ACTION controlp INFIELD xcdi008
            #add-point:ON ACTION controlp INFIELD xcdi008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi009
            #add-point:BEFORE FIELD xcdi009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi009
            
            #add-point:AFTER FIELD xcdi009

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi009
         ON ACTION controlp INFIELD xcdi009
            #add-point:ON ACTION controlp INFIELD xcdi009

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi010
            #add-point:BEFORE FIELD xcdi010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi010
            
            #add-point:AFTER FIELD xcdi010

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi010
         ON ACTION controlp INFIELD xcdi010
            #add-point:ON ACTION controlp INFIELD xcdi010

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi101
            #add-point:BEFORE FIELD xcdi101

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi101
            
            #add-point:AFTER FIELD xcdi101

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi101
         ON ACTION controlp INFIELD xcdi101
            #add-point:ON ACTION controlp INFIELD xcdi101

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi102
            #add-point:BEFORE FIELD xcdi102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi102
            
            #add-point:AFTER FIELD xcdi102

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi102
         ON ACTION controlp INFIELD xcdi102
            #add-point:ON ACTION controlp INFIELD xcdi102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi201
            #add-point:BEFORE FIELD xcdi201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi201
            
            #add-point:AFTER FIELD xcdi201

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi201
         ON ACTION controlp INFIELD xcdi201
            #add-point:ON ACTION controlp INFIELD xcdi201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi202
            #add-point:BEFORE FIELD xcdi202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi202
            
            #add-point:AFTER FIELD xcdi202

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi202
         ON ACTION controlp INFIELD xcdi202
            #add-point:ON ACTION controlp INFIELD xcdi202

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi301
            #add-point:BEFORE FIELD xcdi301

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi301
            
            #add-point:AFTER FIELD xcdi301

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi301
         ON ACTION controlp INFIELD xcdi301
            #add-point:ON ACTION controlp INFIELD xcdi301

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi302
            #add-point:BEFORE FIELD xcdi302

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi302
            
            #add-point:AFTER FIELD xcdi302

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi302
         ON ACTION controlp INFIELD xcdi302
            #add-point:ON ACTION controlp INFIELD xcdi302

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi303
            #add-point:BEFORE FIELD xcdi303

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi303
            
            #add-point:AFTER FIELD xcdi303

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi303
         ON ACTION controlp INFIELD xcdi303
            #add-point:ON ACTION controlp INFIELD xcdi303

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi304
            #add-point:BEFORE FIELD xcdi304

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi304
            
            #add-point:AFTER FIELD xcdi304

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi304
         ON ACTION controlp INFIELD xcdi304
            #add-point:ON ACTION controlp INFIELD xcdi304

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi901
            #add-point:BEFORE FIELD xcdi901

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi901
            
            #add-point:AFTER FIELD xcdi901

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi901
         ON ACTION controlp INFIELD xcdi901
            #add-point:ON ACTION controlp INFIELD xcdi901

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi902
            #add-point:BEFORE FIELD xcdi902

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi902
            
            #add-point:AFTER FIELD xcdi902

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcdi902
         ON ACTION controlp INFIELD xcdi902
            #add-point:ON ACTION controlp INFIELD xcdi902

            #END add-point
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      CONSTRUCT g_wc2_table3 ON sfaasite,xccd002,xccd006,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102, 
          xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902
          
           FROM s_detail2[1].sfaasite_2,s_detail2[1].xccd002_2,s_detail2[1].xccd006_2,s_detail2[1].xcde007_2, 
               s_detail2[1].xcde008_2,s_detail2[1].xcde009_2,s_detail2[1].xcde010_2,s_detail2[1].xcde101_2,s_detail2[1].xcde102_2, 
               s_detail2[1].xcde201_2,s_detail2[1].xcde202_2,s_detail2[1].xcde301_2,s_detail2[1].xcde302_2,s_detail2[1].xcde303_2, 
               s_detail2[1].xcde304_2,s_detail2[1].xcde307_2,s_detail2[1].xcde308_2,s_detail2[1].xcde901_2,s_detail2[1].xcde902_2 

                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.xcdecomp_2
         ON ACTION controlp INFIELD sfaasite_2
            #add-point:ON ACTION controlp INFIELD xcdecomp_2
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaasite_2  #顯示到畫面上
            NEXT FIELD sfaasite_2                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfaasite_2
            #add-point:BEFORE FIELD xcdecomp_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfaasite_2
            
            #add-point:AFTER FIELD xcdecomp_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccd002_2
         ON ACTION controlp INFIELD xccd002_2
            #add-point:ON ACTION controlp INFIELD xccd002_2
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd002_2  #顯示到畫面上
            NEXT FIELD xccd002_2                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd002_2
            #add-point:BEFORE FIELD xccd002_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd002_2
            
            #add-point:AFTER FIELD xccd002_2

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd006_2
            #add-point:BEFORE FIELD xccd006_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd006_2
            
            #add-point:AFTER FIELD xccd006_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccd006_2
         ON ACTION controlp INFIELD xccd006_2
            #add-point:ON ACTION controlp INFIELD xccd006_2

            #END add-point
 
         #Ctrlp:construct.c.page1.xcde007_2
         ON ACTION controlp INFIELD xcde007_2
            #add-point:ON ACTION controlp INFIELD xcde007_2
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde007_2  #顯示到畫面上
            NEXT FIELD xcde007_2                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde007_2
            #add-point:BEFORE FIELD xcde007_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde007_2
            
            #add-point:AFTER FIELD xcde007_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde008_2
         ON ACTION controlp INFIELD xcde008_2
            #add-point:ON ACTION controlp INFIELD xcde008_2
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde008_2  #顯示到畫面上
            NEXT FIELD xcde008_2                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde008_2
            #add-point:BEFORE FIELD xcde008_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde008_2
            
            #add-point:AFTER FIELD xcde008_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde009_2
         ON ACTION controlp INFIELD xcde009_2
            #add-point:ON ACTION controlp INFIELD xcde009_2
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde009_2  #顯示到畫面上
            NEXT FIELD xcde009_2                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde009_2
            #add-point:BEFORE FIELD xcde009_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde009_2
            
            #add-point:AFTER FIELD xcde009_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde010_2
         ON ACTION controlp INFIELD xcde010_2
            #add-point:ON ACTION controlp INFIELD xcde010_2
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcau001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcde010_2  #顯示到畫面上
            NEXT FIELD xcde010_2                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde010_2
            #add-point:BEFORE FIELD xcde010_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde010_2
            
            #add-point:AFTER FIELD xcde010_2

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde101_2
            #add-point:BEFORE FIELD xcde101_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde101_2
            
            #add-point:AFTER FIELD xcde101_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde101_2
         ON ACTION controlp INFIELD xcde101_2
            #add-point:ON ACTION controlp INFIELD xcde101_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde102_2
            #add-point:BEFORE FIELD xcde102_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde102_2
            
            #add-point:AFTER FIELD xcde102_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde102_2
         ON ACTION controlp INFIELD xcde102_2
            #add-point:ON ACTION controlp INFIELD xcde102_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde201_2
            #add-point:BEFORE FIELD xcde201_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde201_2
            
            #add-point:AFTER FIELD xcde201_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde201_2
         ON ACTION controlp INFIELD xcde201_2
            #add-point:ON ACTION controlp INFIELD xcde201_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde202_2
            #add-point:BEFORE FIELD xcde202_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde202_2
            
            #add-point:AFTER FIELD xcde202_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde202_2
         ON ACTION controlp INFIELD xcde202_2
            #add-point:ON ACTION controlp INFIELD xcde202_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde301_2
            #add-point:BEFORE FIELD xcde301_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde301_2
            
            #add-point:AFTER FIELD xcde301_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde301_2
         ON ACTION controlp INFIELD xcde301_2
            #add-point:ON ACTION controlp INFIELD xcde301_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde302_2
            #add-point:BEFORE FIELD xcde302_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde302_2
            
            #add-point:AFTER FIELD xcde302_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde302_2
         ON ACTION controlp INFIELD xcde302_2
            #add-point:ON ACTION controlp INFIELD xcde302_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde303_2
            #add-point:BEFORE FIELD xcde303_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde303_2
            
            #add-point:AFTER FIELD xcde303_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde303_2
         ON ACTION controlp INFIELD xcde303_2
            #add-point:ON ACTION controlp INFIELD xcde303_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde304_2
            #add-point:BEFORE FIELD xcde304_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde304_2
            
            #add-point:AFTER FIELD xcde304_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde304_2
         ON ACTION controlp INFIELD xcde304_2
            #add-point:ON ACTION controlp INFIELD xcde304_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde307_2
            #add-point:BEFORE FIELD xcde307_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde307_2
            
            #add-point:AFTER FIELD xcde307_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde307_2
         ON ACTION controlp INFIELD xcde307_2
            #add-point:ON ACTION controlp INFIELD xcde307_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde308_2
            #add-point:BEFORE FIELD xcde308_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde308_2
            
            #add-point:AFTER FIELD xcde308_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde308_2
         ON ACTION controlp INFIELD xcde308_2
            #add-point:ON ACTION controlp INFIELD xcde308_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde901_2
            #add-point:BEFORE FIELD xcde901_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde901_2
            
            #add-point:AFTER FIELD xcde901_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde901_2
         ON ACTION controlp INFIELD xcde901_2
            #add-point:ON ACTION controlp INFIELD xcde901_2

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde902_2
            #add-point:BEFORE FIELD xcde902_2

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde902_2
            
            #add-point:AFTER FIELD xcde902_2

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcde902_2
         ON ACTION controlp INFIELD xcde902_2
            #add-point:ON ACTION controlp INFIELD xcde902_2

            #END add-point
 
   
       
      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

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
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
 
 
   
   #add-point:cs段結束前
   IF cl_null(g_wc2_table3) THEN
      LET g_wc2_table3 = " 1=1"
   END IF
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq740_query()
   DEFINE ls_wc STRING
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
   CALL g_xcde_d.clear()
   CALL g_xcde2_d.clear()
   CALL g_xcde3_d.clear()
 
   
   #add-point:query段other
   
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq740_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axcq740_browser_fill("")
      CALL axcq740_fetch("")
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
   CALL axcq740_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   ELSE
      CALL axcq740_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq740_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define

   #end add-point    
   
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
   
   #CALL axcq740_browser_fill(p_flag)
   
   
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
   LET g_xccd_m.xccd003 = g_browser[g_current_idx].b_xccd003
   LET g_xccd_m.xccd004 = g_browser[g_current_idx].b_xccd004
   LET g_xccd_m.xccd005 = g_browser[g_current_idx].b_xccd005
   
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq740_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd001, 
       g_xccd_m.xccdld,g_xccd_m.xccd005,g_xccd_m.xccd003
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
   CALL axcq740_set_act_visible()   
   CALL axcq740_set_act_no_visible()
   
   #add-point:fetch段action控制

   #end add-point  
   
   
   
   #add-point:fetch結束前

   #end add-point
   
   #保存單頭舊值
   LET g_xccd_m_t.* = g_xccd_m.*
   LET g_xccd_m_o.* = g_xccd_m.*
   
   
   #重新顯示   
   CALL axcq740_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq740_insert()
   #add-point:insert段define

   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xcde_d.clear()   
   CALL g_xcde2_d.clear()  
   CALL g_xcde3_d.clear()  
 
 
   #INITIALIZE g_xccd_m.* LIKE xccd_t.*             #DEFAULT 設定  #161124-00048#17 2016/12/16 By 08734 mark
   INITIALIZE g_xccd_m.* TO NULL             #DEFAULT 設定  #161124-00048#17 2016/12/16 By 08734 add
   
#   LET g_xccdld_t = NULL
#   LET g_xccd001_t = NULL
#   LET g_xccd002_t = NULL
#   LET g_xccd003_t = NULL
#   LET g_xccd004_t = NULL
#   LET g_xccd005_t = NULL
#   LET g_xccd006_t = NULL
 
   
   LET g_master_insert = FALSE
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值

      #end add-point 
      
      #顯示狀態(stus)圖片
      
    
      CALL axcq740_input("a")
      
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
         INITIALIZE g_xcde_d TO NULL
         INITIALIZE g_xcde2_d TO NULL
         INITIALIZE g_xcde3_d TO NULL
 
         #add-point:取消新增後

         #end add-point 
         CALL axcq740_show()
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
   CALL axcq740_set_act_visible()   
   CALL axcq740_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001   
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
                      " xccdld = '", g_xccd_m.xccdld CLIPPED, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001 CLIPPED, "' "                      
                      ," AND xccd003 = '", g_xccd_m.xccd003 CLIPPED, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004 CLIPPED, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005 CLIPPED, "' "
                      
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq740_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axcq740_cl
   
   CALL axcq740_idx_chk()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq740_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define

   #end add-point    
   
   #保存單頭舊值
   LET g_xccd_m_t.* = g_xccd_m.*
   LET g_xccd_m_o.* = g_xccd_m.*
   
   IF g_xccd_m.xccdld IS NULL
   OR g_xccd_m.xccd001 IS NULL   
   OR g_xccd_m.xccd003 IS NULL
   OR g_xccd_m.xccd004 IS NULL
   OR g_xccd_m.xccd005 IS NULL
   
 
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
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
   
 
   CALL s_transaction_begin()
   
   OPEN axcq740_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq740_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE axcq740_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq740_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd001, 
       g_xccd_m.xccdld,g_xccd_m.xccd005,g_xccd_m.xccd003
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xccd_m.xccdld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE axcq740_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
   
   #add-point:modify段show之前

   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL axcq740_show()
   #add-point:modify段show之後

   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_xccdld_t = g_xccd_m.xccdld
      LET g_xccd001_t = g_xccd_m.xccd001      
      LET g_xccd003_t = g_xccd_m.xccd003
      LET g_xccd004_t = g_xccd_m.xccd004
      LET g_xccd005_t = g_xccd_m.xccd005
      
 
      
      #寫入修改者/修改日期資訊(單頭)
      
      
      #add-point:modify段修改前

      #end add-point
      
      #欄位更改
      CALL axcq740_input("u")
 
      #add-point:modify段修改後

      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xccd_m.* = g_xccd_m_t.*
         CALL axcq740_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      
      #若有modid跟moddt則進行update
 
                  
      #若單頭key欄位有變更
      IF g_xccd_m.xccdld != g_xccdld_t 
      OR g_xccd_m.xccd001 != g_xccd001_t      
      OR g_xccd_m.xccd003 != g_xccd003_t 
      OR g_xccd_m.xccd004 != g_xccd004_t 
      OR g_xccd_m.xccd005 != g_xccd005_t 
      
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前

         #end add-point
         
         #更新單身key值
         UPDATE xcde_t SET xcdeld = g_xccd_m.xccdld
                                       ,xcde001 = g_xccd_m.xccd001
                                       
                                       ,xcde003 = g_xccd_m.xccd003
                                       ,xcde004 = g_xccd_m.xccd004
                                       ,xcde005 = g_xccd_m.xccd005
                                       
 
          WHERE xcdeent = g_enterprise AND xcdeld = g_xccdld_t
            AND xcde001 = g_xccd001_t
            AND xcde002 = g_xccd002_t
            AND xcde003 = g_xccd003_t
            AND xcde004 = g_xccd004_t
            AND xcde005 = g_xccd005_t
            AND xcde006 = g_xccd006_t
 
            
         #add-point:單身fk修改中

         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcde_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcde_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後

         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前

         #end add-point
         UPDATE xcdi_t
            SET xcdild = g_xccd_m.xccdld
               ,xcdi001 = g_xccd_m.xccd001
               
               ,xcdi003 = g_xccd_m.xccd003
               ,xcdi004 = g_xccd_m.xccd004
               ,xcdi005 = g_xccd_m.xccd005
               
 
          WHERE xcdient = g_enterprise AND
                xcdild = g_xccdld_t
            AND xcdi001 = g_xccd001_t
            AND xcdi002 = g_xccd002_t
            AND xcdi003 = g_xccd003_t
            AND xcdi004 = g_xccd004_t
            AND xcdi005 = g_xccd005_t
            AND xcdi006 = g_xccd006_t
 
         #add-point:單身fk修改中

         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcdi_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcdi_t" 
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
   CALL axcq740_set_act_visible()   
   CALL axcq740_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
                      " xccdld = '", g_xccd_m.xccdld CLIPPED, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001 CLIPPED, "' "
                      
                      ," AND xccd003 = '", g_xccd_m.xccd003 CLIPPED, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004 CLIPPED, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005 CLIPPED, "' "
                      
 
   #填到對應位置
   CALL axcq740_browser_fill("")
 
   CLOSE axcq740_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xccd_m.xccdld,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="axcq740.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq740_input(p_cmd)
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
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccd004,g_xccd_m.xccd001,g_xccd_m.xccdld, 
       g_xccd_m.xccdld_desc,g_xccd_m.xccd005,g_xccd_m.xccd003,g_xccd_m.xccd003_desc
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql

   #end add-point 
#   LET g_forupd_sql = "SELECT xcdecomp,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102,xcde201,xcde202, 
#       xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902,xcdecomp,xcde007,xcde008,xcde009, 
#       xcde010,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901, 
#       xcde902 FROM xcde_t WHERE xcdeent=? AND xcdeld=? AND xcde001=? AND xcde002=? AND xcde003=? AND  
#       xcde004=? AND xcde005=? AND xcde006=? AND xcde007=? AND xcde008=? AND xcde009=? AND xcde010=?  
#       FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq740_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql

   #end add-point    
   LET g_forupd_sql = "SELECT xcdicomp,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, 
       xcdi301,xcdi302,xcdi303,xcdi304,xcdi901,xcdi902 FROM xcdi_t WHERE xcdient=? AND xcdild=? AND  
       xcdi001=? AND xcdi002=? AND xcdi003=? AND xcdi004=? AND xcdi005=? AND xcdi006=? AND xcdi007=?  
       AND xcdi008=? AND xcdi009=? AND xcdi010=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq740_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql

   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq740_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL axcq740_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd001,g_xccd_m.xccdld,g_xccd_m.xccd005, 
       g_xccd_m.xccd003
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="axcq740.input.head" >}
      #單頭段
      INPUT BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd001,g_xccd_m.xccdld,g_xccd_m.xccd005, 
          g_xccd_m.xccd003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:資料輸入前

            #end add-point
 
                  #此段落由子樣板a02產生
         AFTER FIELD xccdcomp
            
            #add-point:AFTER FIELD xccdcomp
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
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccdcomp
            #add-point:BEFORE FIELD xccdcomp

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccdcomp
            #add-point:ON CHANGE xccdcomp

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd004
            #add-point:BEFORE FIELD xccd004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd004
            
            #add-point:AFTER FIELD xccd004
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001)  AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005)  THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccd004
            #add-point:ON CHANGE xccd004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd001
            #add-point:BEFORE FIELD xccd001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd001
            
            #add-point:AFTER FIELD xccd001
            #此段落由子樣板a05產生
#            #確認資料無重複
#            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccd001
            #add-point:ON CHANGE xccd001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccdld
            
            #add-point:AFTER FIELD xccdld
            IF NOT cl_null(g_xccd_m.xccdld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccd_m.xccdld
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#10--add--end
                  
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
#            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccdld
            #add-point:BEFORE FIELD xccdld

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccdld
            #add-point:ON CHANGE xccdld

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd005
            #add-point:BEFORE FIELD xccd005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd005
            
            #add-point:AFTER FIELD xccd005
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccd005
            #add-point:ON CHANGE xccd005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd003
            
            #add-point:AFTER FIELD xccd003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccd_m.xccd003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccd_m.xccd003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccd_m.xccd003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  NOT cl_null(g_xccd_m.xccdld) AND NOT cl_null(g_xccd_m.xccd001) AND NOT cl_null(g_xccd_m.xccd002) AND NOT cl_null(g_xccd_m.xccd003) AND NOT cl_null(g_xccd_m.xccd004) AND NOT cl_null(g_xccd_m.xccd005) AND NOT cl_null(g_xccd_m.xccd006) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t  OR g_xccd_m.xccd001 != g_xccd001_t  OR g_xccd_m.xccd002 != g_xccd002_t  OR g_xccd_m.xccd003 != g_xccd003_t  OR g_xccd_m.xccd004 != g_xccd004_t  OR g_xccd_m.xccd005 != g_xccd005_t  OR g_xccd_m.xccd006 != g_xccd006_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccd_t WHERE "||"xccdent = '" ||g_enterprise|| "' AND "||"xccdld = '"||g_xccd_m.xccdld ||"' AND "|| "xccd001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xccd002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xccd003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xccd004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xccd005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xccd006 = '"||g_xccd_m.xccd006 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd003
            #add-point:BEFORE FIELD xccd003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccd003
            #add-point:ON CHANGE xccd003

            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.xccdcomp
         ON ACTION controlp INFIELD xccdcomp
            #add-point:ON ACTION controlp INFIELD xccdcomp
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
         ON ACTION controlp INFIELD xccd004
            #add-point:ON ACTION controlp INFIELD xccd004

            #END add-point
 
         #Ctrlp:input.c.xccd001
         ON ACTION controlp INFIELD xccd001
            #add-point:ON ACTION controlp INFIELD xccd001

            #END add-point
 
         #Ctrlp:input.c.xccdld
         ON ACTION controlp INFIELD xccdld
            #add-point:ON ACTION controlp INFIELD xccdld
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
 
         #Ctrlp:input.c.xccd005
         ON ACTION controlp INFIELD xccd005
            #add-point:ON ACTION controlp INFIELD xccd005

            #END add-point
 
         #Ctrlp:input.c.xccd003
         ON ACTION controlp INFIELD xccd003
            #add-point:ON ACTION controlp INFIELD xccd003

            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004, 
                g_xccd_m.xccd005
                        
            #add-point:單頭INPUT後

            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前

               #end add-point
               
               INSERT INTO xccd_t (xccdent,xccdcomp,xccd004,xccd001,xccdld,xccd005,xccd003)
               VALUES (g_enterprise,g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd001,g_xccd_m.xccdld, 
                   g_xccd_m.xccd005,g_xccd_m.xccd003) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xccd_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中

               #end add-point
               
               
               
               
               #add-point:單頭新增後

               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq740_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axcq740_b_fill()
               END IF
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前

               #end add-point
               
               UPDATE xccd_t SET (xccdcomp,xccd004,xccd001,xccdld,xccd005,xccd003) = (g_xccd_m.xccdcomp, 
                   g_xccd_m.xccd004,g_xccd_m.xccd001,g_xccd_m.xccdld,g_xccd_m.xccd005,g_xccd_m.xccd003) 
 
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
                  CONTINUE DIALOG
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
            
            LET g_xccd003_t = g_xccd_m.xccd003
            LET g_xccd004_t = g_xccd_m.xccd004
            LET g_xccd005_t = g_xccd_m.xccd005
            
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axcq740.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前

            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq740_b_fill()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_rec_b = g_xcde_d.getLength()
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
            OPEN axcq740_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axcq740_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CLOSE axcq740_cl
               CALL s_transaction_end('N','0')
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
               CALL axcq740_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL axcq740_set_no_entry_b(l_cmd)
               IF NOT axcq740_lock_b("xcde_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq740_bcl INTO g_xcde_d[l_ac].sfaasite,g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008, 
                      g_xcde_d[l_ac].xcde009,g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102, 
                      g_xcde_d[l_ac].xcde201,g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302, 
                      g_xcde_d[l_ac].xcde303,g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde307,g_xcde_d[l_ac].xcde308, 
                      g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902,g_xcde2_d[l_ac].sfaasite,g_xcde2_d[l_ac].xcde007, 
                      g_xcde2_d[l_ac].xcde008,g_xcde2_d[l_ac].xcde009,g_xcde2_d[l_ac].xcde010,g_xcde2_d[l_ac].xcde101, 
                      g_xcde2_d[l_ac].xcde102,g_xcde2_d[l_ac].xcde201,g_xcde2_d[l_ac].xcde202,g_xcde2_d[l_ac].xcde301, 
                      g_xcde2_d[l_ac].xcde302,g_xcde2_d[l_ac].xcde303,g_xcde2_d[l_ac].xcde304,g_xcde2_d[l_ac].xcde307, 
                      g_xcde2_d[l_ac].xcde308,g_xcde2_d[l_ac].xcde901,g_xcde2_d[l_ac].xcde902
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xcde_d_t.xcde007 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL axcq740_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            LET g_detail_multi_table_t.xccdld = g_xccd_m.xccdld
LET g_detail_multi_table_t.xccd001 = g_xccd_m.xccd001
LET g_detail_multi_table_t.xccd002 = g_xcde_d[l_ac].xccd002
LET g_detail_multi_table_t.xccd003 = g_xccd_m.xccd003
LET g_detail_multi_table_t.xccd004 = g_xccd_m.xccd004
LET g_detail_multi_table_t.xccd005 = g_xccd_m.xccd005
LET g_detail_multi_table_t.xccd006 = g_xcde_d[l_ac].xccd006
LET g_detail_multi_table_t.xccd002 = g_xcde3_d[l_ac].xcdi007
LET g_detail_multi_table_t.xccd006 = g_xcde3_d[l_ac].xcdi008
 
            #其他table進行lock
                        INITIALIZE l_var_keys TO NULL 
            INITIALIZE l_field_keys TO NULL 
            LET l_field_keys[01] = 'xccdld'
            LET l_var_keys[01] = g_xccd_m.xccdld
            LET l_field_keys[02] = 'xccd001'
            LET l_var_keys[02] = g_xccd_m.xccd001
            LET l_field_keys[03] = 'xccd002'
            LET l_var_keys[03] = g_xcde_d[l_ac].xccd002
            LET l_field_keys[04] = 'xccd003'
            LET l_var_keys[04] = g_xccd_m.xccd003
            LET l_field_keys[05] = 'xccd004'
            LET l_var_keys[05] = g_xccd_m.xccd004
            LET l_field_keys[06] = 'xccd005'
            LET l_var_keys[06] = g_xccd_m.xccd005
            LET l_field_keys[07] = 'xccd006'
            LET l_var_keys[07] = g_xcde_d[l_ac].xccd006
            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'xccd_t') THEN
               RETURN 
            END IF 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcde_d[l_ac].* TO NULL 
            INITIALIZE g_xcde_d_t.* TO NULL 
            INITIALIZE g_xcde_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份

            #end add-point
            LET g_xcde_d_t.* = g_xcde_d[l_ac].*     #新輸入資料
            LET g_xcde_d_o.* = g_xcde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq740_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL axcq740_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcde_d[li_reproduce_target].* = g_xcde_d[li_reproduce].*
               LET g_xcde2_d[li_reproduce_target].* = g_xcde2_d[li_reproduce].*
 
               LET g_xcde_d[li_reproduce_target].xcde007 = NULL
               LET g_xcde_d[li_reproduce_target].xcde008 = NULL
               LET g_xcde_d[li_reproduce_target].xcde009 = NULL
               LET g_xcde_d[li_reproduce_target].xcde010 = NULL
 
            END IF
            LET g_detail_multi_table_t.xccdld = g_xccd_m.xccdld
LET g_detail_multi_table_t.xccd001 = g_xccd_m.xccd001
LET g_detail_multi_table_t.xccd002 = g_xcde_d[l_ac].xccd002
LET g_detail_multi_table_t.xccd003 = g_xccd_m.xccd003
LET g_detail_multi_table_t.xccd004 = g_xccd_m.xccd004
LET g_detail_multi_table_t.xccd005 = g_xccd_m.xccd005
LET g_detail_multi_table_t.xccd006 = g_xcde_d[l_ac].xccd006
LET g_detail_multi_table_t.xccd002 = g_xcde3_d[l_ac].xcdi007
LET g_detail_multi_table_t.xccd006 = g_xcde3_d[l_ac].xcdi008
 
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
            SELECT COUNT(*) INTO l_count FROM xcde_t 
             WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld
               AND xcde001 = g_xccd_m.xccd001
               
               AND xcde003 = g_xccd_m.xccd003
               AND xcde004 = g_xccd_m.xccd004
               AND xcde005 = g_xccd_m.xccd005
               
 
               AND xcde007 = g_xcde_d[l_ac].xcde007
               AND xcde008 = g_xcde_d[l_ac].xcde008
               AND xcde009 = g_xcde_d[l_ac].xcde009
               AND xcde010 = g_xcde_d[l_ac].xcde010
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
               #同步新增到同層的table
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd002
#               LET gs_keys[4] = g_xccd_m.xccd003
#               LET gs_keys[5] = g_xccd_m.xccd004
#               LET gs_keys[6] = g_xccd_m.xccd005
#               LET gs_keys[7] = g_xccd_m.xccd006
#               LET gs_keys[8] = g_xcde_d[g_detail_idx].xcde007
#               LET gs_keys[9] = g_xcde_d[g_detail_idx].xcde008
#               LET gs_keys[10] = g_xcde_d[g_detail_idx].xcde009
#               LET gs_keys[11] = g_xcde_d[g_detail_idx].xcde010
#               CALL axcq740_insert_b('xcde_t',gs_keys,"'1'")
#                           
               #add-point:單身新增後

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_xcde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcde_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axcq740_b_fill()
               #資料多語言用-增/改
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xccd_m.xccdld = g_detail_multi_table_t.xccdld AND
         g_xccd_m.xccd001 = g_detail_multi_table_t.xccd001 AND
         g_xcde_d[l_ac].xccd002 = g_detail_multi_table_t.xccd002 AND
         g_xccd_m.xccd003 = g_detail_multi_table_t.xccd003 AND
         g_xccd_m.xccd004 = g_detail_multi_table_t.xccd004 AND
         g_xccd_m.xccd005 = g_detail_multi_table_t.xccd005 AND
         g_xcde_d[l_ac].xccd006 = g_detail_multi_table_t.xccd006 AND
         g_xcde3_d[l_ac].xcdi007 = g_detail_multi_table_t.xccd002 AND
         g_xcde3_d[l_ac].xcdi008 = g_detail_multi_table_t.xccd006 #AND
#         g_xcde3_d[l_ac].xcdi009 =  AND
#         g_xcde3_d[l_ac].xcdi010 =  AND
#         g_xcde_d[l_ac].xccd002 =  AND
#         g_xcde_d[l_ac].xccd006 =  
          THEN
         ELSE 
            LET l_var_keys[01] = g_xccd_m.xccdld
            LET l_field_keys[01] = 'xccdld'
            LET l_var_keys[02] = g_xccd_m.xccd001
            LET l_field_keys[02] = 'xccd001'
            LET l_var_keys[03] = g_xcde_d[l_ac].xccd002
            LET l_field_keys[03] = 'xccd002'
            LET l_var_keys[04] = g_xccd_m.xccd003
            LET l_field_keys[04] = 'xccd003'
            LET l_var_keys[05] = g_xccd_m.xccd004
            LET l_field_keys[05] = 'xccd004'
            LET l_var_keys[06] = g_xccd_m.xccd005
            LET l_field_keys[06] = 'xccd005'
            LET l_var_keys[07] = g_xcde_d[l_ac].xccd006
            LET l_field_keys[07] = 'xccd006'
            LET l_vars[01] = g_xcde_d[l_ac].xccd002
            LET l_fields[01] = 'xccd002'
            LET l_vars[02] = g_xcde_d[l_ac].xccd006
            LET l_fields[02] = 'xccd006'
            LET l_vars[03] = g_enterprise 
            LET l_fields[03] = 'xccdent'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.xccdld
            LET l_var_keys_bak[02] = g_detail_multi_table_t.xccd001
            LET l_var_keys_bak[03] = g_detail_multi_table_t.xccd002
            LET l_var_keys_bak[04] = g_detail_multi_table_t.xccd003
            LET l_var_keys_bak[05] = g_detail_multi_table_t.xccd004
            LET l_var_keys_bak[06] = g_detail_multi_table_t.xccd005
            LET l_var_keys_bak[07] = g_detail_multi_table_t.xccd006
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xccd_t')
         END IF 
 
               #add-point:input段-after_insert

               #end add-point
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
               
               #add-point:單身刪除前

               #end add-point 
#               
#               DELETE FROM xcde_t
#                WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld AND
#                                          xcde001 = g_xccd_m.xccd001 AND
#                                          xcde002 = g_xccd_m.xccd002 AND
#                                          xcde003 = g_xccd_m.xccd003 AND
#                                          xcde004 = g_xccd_m.xccd004 AND
#                                          xcde005 = g_xccd_m.xccd005 AND
#                                          xcde006 = g_xccd_m.xccd006 AND
# 
#                      xcde007 = g_xcde_d_t.xcde007
#                  AND xcde008 = g_xcde_d_t.xcde008
#                  AND xcde009 = g_xcde_d_t.xcde009
#                  AND xcde010 = g_xcde_d_t.xcde010
 
                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xcde_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'xccdld'
                  LET l_field_keys[02] = 'xccd001'
                  LET l_field_keys[03] = 'xccd002'
                  LET l_field_keys[04] = 'xccd003'
                  LET l_field_keys[05] = 'xccd004'
                  LET l_field_keys[06] = 'xccd005'
                  LET l_field_keys[07] = 'xccd006'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.xccdld
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xccd001
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.xccd002
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.xccd003
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.xccd004
                  LET l_var_keys_bak[06] = g_detail_multi_table_t.xccd005
                  LET l_var_keys_bak[07] = g_detail_multi_table_t.xccd006
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xccd_t')
 
                  #add-point:單身刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE axcq740_bcl
               LET l_count = g_xcde_d.getLength()
                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd002
#               LET gs_keys[4] = g_xccd_m.xccd003
#               LET gs_keys[5] = g_xccd_m.xccd004
#               LET gs_keys[6] = g_xccd_m.xccd005
#               LET gs_keys[7] = g_xccd_m.xccd006
#               LET gs_keys[8] = g_xcde_d[g_detail_idx].xcde007
#               LET gs_keys[9] = g_xcde_d[g_detail_idx].xcde008
#               LET gs_keys[10] = g_xcde_d[g_detail_idx].xcde009
#               LET gs_keys[11] = g_xcde_d[g_detail_idx].xcde010
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
                              CALL axcq740_delete_b('xcde_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #此段落由子樣板a02產生
       #  AFTER FIELD xcdecomp
            
            #add-point:AFTER FIELD xcdecomp


            #END add-point
            
 
         #此段落由子樣板a01產生
        # BEFORE FIELD xcdecomp
            #add-point:BEFORE FIELD xcdecomp

            #END add-point
 
         #此段落由子樣板a04產生
        # ON CHANGE xcdecomp
            #add-point:ON CHANGE xcdecomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd002
            
            #add-point:AFTER FIELD xccd002
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccd_m.xccdcomp
            LET g_ref_fields[2] = g_xcde_d[l_ac].xccd002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcde_d[l_ac].xccd002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcde_d[l_ac].xccd002_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd002
            #add-point:BEFORE FIELD xccd002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccd002
            #add-point:ON CHANGE xccd002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd006
            #add-point:BEFORE FIELD xccd006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd006
            
            #add-point:AFTER FIELD xccd006

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccd006
            #add-point:ON CHANGE xccd006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde007
            
            #add-point:AFTER FIELD xcde007
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde007 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde008 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde009 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde010 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde_d[g_detail_idx].xcde007 != g_xcde_d_t.xcde007 OR g_xcde_d[g_detail_idx].xcde008 != g_xcde_d_t.xcde008 OR g_xcde_d[g_detail_idx].xcde009 != g_xcde_d_t.xcde009 OR g_xcde_d[g_detail_idx].xcde010 != g_xcde_d_t.xcde010)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcde_t WHERE "||"xcdeent = '" ||g_enterprise|| "' AND "||"xcdeld = '"||g_xccd_m.xccdld ||"' AND "|| "xcde001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcde002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcde003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcde004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcde005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcde006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcde007 = '"||g_xcde_d[g_detail_idx].xcde007 ||"' AND "|| "xcde008 = '"||g_xcde_d[g_detail_idx].xcde008 ||"' AND "|| "xcde009 = '"||g_xcde_d[g_detail_idx].xcde009 ||"' AND "|| "xcde010 = '"||g_xcde_d[g_detail_idx].xcde010 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcde_d[l_ac].xcde007
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcde_d[l_ac].xcde007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcde_d[l_ac].xcde007_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde007
            #add-point:BEFORE FIELD xcde007

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcde007
            #add-point:ON CHANGE xcde007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde008
            #add-point:BEFORE FIELD xcde008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde008
            
            #add-point:AFTER FIELD xcde008
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde007 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde008 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde009 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde010 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde_d[g_detail_idx].xcde007 != g_xcde_d_t.xcde007 OR g_xcde_d[g_detail_idx].xcde008 != g_xcde_d_t.xcde008 OR g_xcde_d[g_detail_idx].xcde009 != g_xcde_d_t.xcde009 OR g_xcde_d[g_detail_idx].xcde010 != g_xcde_d_t.xcde010)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcde_t WHERE "||"xcdeent = '" ||g_enterprise|| "' AND "||"xcdeld = '"||g_xccd_m.xccdld ||"' AND "|| "xcde001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcde002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcde003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcde004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcde005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcde006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcde007 = '"||g_xcde_d[g_detail_idx].xcde007 ||"' AND "|| "xcde008 = '"||g_xcde_d[g_detail_idx].xcde008 ||"' AND "|| "xcde009 = '"||g_xcde_d[g_detail_idx].xcde009 ||"' AND "|| "xcde010 = '"||g_xcde_d[g_detail_idx].xcde010 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde008
            #add-point:ON CHANGE xcde008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde009
            #add-point:BEFORE FIELD xcde009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde009
            
            #add-point:AFTER FIELD xcde009
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde007 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde008 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde009 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde010 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde_d[g_detail_idx].xcde007 != g_xcde_d_t.xcde007 OR g_xcde_d[g_detail_idx].xcde008 != g_xcde_d_t.xcde008 OR g_xcde_d[g_detail_idx].xcde009 != g_xcde_d_t.xcde009 OR g_xcde_d[g_detail_idx].xcde010 != g_xcde_d_t.xcde010)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcde_t WHERE "||"xcdeent = '" ||g_enterprise|| "' AND "||"xcdeld = '"||g_xccd_m.xccdld ||"' AND "|| "xcde001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcde002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcde003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcde004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcde005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcde006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcde007 = '"||g_xcde_d[g_detail_idx].xcde007 ||"' AND "|| "xcde008 = '"||g_xcde_d[g_detail_idx].xcde008 ||"' AND "|| "xcde009 = '"||g_xcde_d[g_detail_idx].xcde009 ||"' AND "|| "xcde010 = '"||g_xcde_d[g_detail_idx].xcde010 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde009
            #add-point:ON CHANGE xcde009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde010
            
            #add-point:AFTER FIELD xcde010
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde007 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde008 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde009 IS NOT NULL AND g_xcde_d[g_detail_idx].xcde010 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde_d[g_detail_idx].xcde007 != g_xcde_d_t.xcde007 OR g_xcde_d[g_detail_idx].xcde008 != g_xcde_d_t.xcde008 OR g_xcde_d[g_detail_idx].xcde009 != g_xcde_d_t.xcde009 OR g_xcde_d[g_detail_idx].xcde010 != g_xcde_d_t.xcde010)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcde_t WHERE "||"xcdeent = '" ||g_enterprise|| "' AND "||"xcdeld = '"||g_xccd_m.xccdld ||"' AND "|| "xcde001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcde002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcde003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcde004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcde005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcde006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcde007 = '"||g_xcde_d[g_detail_idx].xcde007 ||"' AND "|| "xcde008 = '"||g_xcde_d[g_detail_idx].xcde008 ||"' AND "|| "xcde009 = '"||g_xcde_d[g_detail_idx].xcde009 ||"' AND "|| "xcde010 = '"||g_xcde_d[g_detail_idx].xcde010 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            IF NOT cl_null(g_xcde_d[l_ac].xcde010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcde_d[l_ac].xcde010
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axc-00056:sub-01302|axci111|",cl_get_progname("axci111",g_lang,"2"),"|:EXEPROGaxci111"
               #160318-00025#10--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_xcau001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            IF NOT cl_null(g_xcde_d[l_ac].xcde010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcde_d[l_ac].xcde010
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axc-00056:sub-01302|axci111|",cl_get_progname("axci111",g_lang,"2"),"|:EXEPROGaxci111"
               #160318-00025#10--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_xcau001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcde_d[l_ac].xcde010
            CALL ap_ref_array2(g_ref_fields,"SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=? AND xcaul002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcde_d[l_ac].xcde010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcde_d[l_ac].xcde010_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde010
            #add-point:BEFORE FIELD xcde010

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcde010
            #add-point:ON CHANGE xcde010

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcbb005
            #add-point:BEFORE FIELD xcbb005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbb005
            
            #add-point:AFTER FIELD xcbb005

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcbb005
            #add-point:ON CHANGE xcbb005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde101
            #add-point:BEFORE FIELD xcde101

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde101
            
            #add-point:AFTER FIELD xcde101

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde101
            #add-point:ON CHANGE xcde101

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde102
            #add-point:BEFORE FIELD xcde102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde102
            
            #add-point:AFTER FIELD xcde102

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde102
            #add-point:ON CHANGE xcde102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde201
            #add-point:BEFORE FIELD xcde201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde201
            
            #add-point:AFTER FIELD xcde201

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde201
            #add-point:ON CHANGE xcde201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde202
            #add-point:BEFORE FIELD xcde202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde202
            
            #add-point:AFTER FIELD xcde202

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde202
            #add-point:ON CHANGE xcde202

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde301
            #add-point:BEFORE FIELD xcde301

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde301
            
            #add-point:AFTER FIELD xcde301

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde301
            #add-point:ON CHANGE xcde301

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde302
            #add-point:BEFORE FIELD xcde302

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde302
            
            #add-point:AFTER FIELD xcde302

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde302
            #add-point:ON CHANGE xcde302

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde303
            #add-point:BEFORE FIELD xcde303

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde303
            
            #add-point:AFTER FIELD xcde303

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde303
            #add-point:ON CHANGE xcde303

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde304
            #add-point:BEFORE FIELD xcde304

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde304
            
            #add-point:AFTER FIELD xcde304

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde304
            #add-point:ON CHANGE xcde304

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde307
            #add-point:BEFORE FIELD xcde307

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde307
            
            #add-point:AFTER FIELD xcde307

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde307
            #add-point:ON CHANGE xcde307

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde308
            #add-point:BEFORE FIELD xcde308

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde308
            
            #add-point:AFTER FIELD xcde308

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde308
            #add-point:ON CHANGE xcde308

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde901
            #add-point:BEFORE FIELD xcde901

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde901
            
            #add-point:AFTER FIELD xcde901

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde901
            #add-point:ON CHANGE xcde901

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcde902
            #add-point:BEFORE FIELD xcde902

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcde902
            
            #add-point:AFTER FIELD xcde902

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcde902
            #add-point:ON CHANGE xcde902

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xcdecomp
       #ON ACTION controlp INFIELD xcdecomp
            #add-point:ON ACTION controlp INFIELD xcdecomp
            #此段落由子樣板a07產生            
            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_xcde_d[l_ac].xcdecomp             #給予default值
#            LET g_qryparam.default2 = "" #g_xcde_d[l_ac].ooefl003 #說明(簡稱)
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_ooef001_2()                                #呼叫開窗
#
#            LET g_xcde_d[l_ac].xcdecomp = g_qryparam.return1              
#            #LET g_xcde_d[l_ac].ooefl003 = g_qryparam.return2 
#            DISPLAY g_xcde_d[l_ac].xcdecomp TO xcdecomp              #
#            #DISPLAY g_xcde_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
#            NEXT FIELD xcdecomp                          #返回原欄位
#

            #END add-point
 
         #Ctrlp:input.c.page1.xccd002
         ON ACTION controlp INFIELD xccd002
            #add-point:ON ACTION controlp INFIELD xccd002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcde_d[l_ac].xccd002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcbf001()                                #呼叫開窗

            LET g_xcde_d[l_ac].xccd002 = g_qryparam.return1              

            DISPLAY g_xcde_d[l_ac].xccd002 TO xccd002              #

            NEXT FIELD xccd002                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xccd006
         ON ACTION controlp INFIELD xccd006
            #add-point:ON ACTION controlp INFIELD xccd006

            #END add-point
 
         #Ctrlp:input.c.page1.xcde007
         ON ACTION controlp INFIELD xcde007
            #add-point:ON ACTION controlp INFIELD xcde007
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcde_d[l_ac].xcde007             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imag001_2()                                #呼叫開窗

            LET g_xcde_d[l_ac].xcde007 = g_qryparam.return1              

            DISPLAY g_xcde_d[l_ac].xcde007 TO xcde007              #

            NEXT FIELD xcde007                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xcde008
         ON ACTION controlp INFIELD xcde008
            #add-point:ON ACTION controlp INFIELD xcde008

            #END add-point
 
         #Ctrlp:input.c.page1.xcde009
         ON ACTION controlp INFIELD xcde009
            #add-point:ON ACTION controlp INFIELD xcde009

            #END add-point
 
         #Ctrlp:input.c.page1.xcde010
         ON ACTION controlp INFIELD xcde010
            #add-point:ON ACTION controlp INFIELD xcde010
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcde_d[l_ac].xcde010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcau001()                                #呼叫開窗

            LET g_xcde_d[l_ac].xcde010 = g_qryparam.return1              

            DISPLAY g_xcde_d[l_ac].xcde010 TO xcde010              #

            NEXT FIELD xcde010                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xcbb005
         ON ACTION controlp INFIELD xcbb005
            #add-point:ON ACTION controlp INFIELD xcbb005

            #END add-point
 
         #Ctrlp:input.c.page1.xcde101
         ON ACTION controlp INFIELD xcde101
            #add-point:ON ACTION controlp INFIELD xcde101

            #END add-point
 
         #Ctrlp:input.c.page1.xcde102
         ON ACTION controlp INFIELD xcde102
            #add-point:ON ACTION controlp INFIELD xcde102

            #END add-point
 
         #Ctrlp:input.c.page1.xcde201
         ON ACTION controlp INFIELD xcde201
            #add-point:ON ACTION controlp INFIELD xcde201

            #END add-point
 
         #Ctrlp:input.c.page1.xcde202
         ON ACTION controlp INFIELD xcde202
            #add-point:ON ACTION controlp INFIELD xcde202

            #END add-point
 
         #Ctrlp:input.c.page1.xcde301
         ON ACTION controlp INFIELD xcde301
            #add-point:ON ACTION controlp INFIELD xcde301

            #END add-point
 
         #Ctrlp:input.c.page1.xcde302
         ON ACTION controlp INFIELD xcde302
            #add-point:ON ACTION controlp INFIELD xcde302

            #END add-point
 
         #Ctrlp:input.c.page1.xcde303
         ON ACTION controlp INFIELD xcde303
            #add-point:ON ACTION controlp INFIELD xcde303

            #END add-point
 
         #Ctrlp:input.c.page1.xcde304
         ON ACTION controlp INFIELD xcde304
            #add-point:ON ACTION controlp INFIELD xcde304

            #END add-point
 
         #Ctrlp:input.c.page1.xcde307
         ON ACTION controlp INFIELD xcde307
            #add-point:ON ACTION controlp INFIELD xcde307

            #END add-point
 
         #Ctrlp:input.c.page1.xcde308
         ON ACTION controlp INFIELD xcde308
            #add-point:ON ACTION controlp INFIELD xcde308

            #END add-point
 
         #Ctrlp:input.c.page1.xcde901
         ON ACTION controlp INFIELD xcde901
            #add-point:ON ACTION controlp INFIELD xcde901

            #END add-point
 
         #Ctrlp:input.c.page1.xcde902
         ON ACTION controlp INFIELD xcde902
            #add-point:ON ACTION controlp INFIELD xcde902

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xcde_d[l_ac].* = g_xcde_d_t.*
               CLOSE axcq740_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcde_d[l_ac].xcde007 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_xcde_d[l_ac].* = g_xcde_d_t.*
            ELSE
            
               #add-point:單身修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
#               UPDATE xcde_t SET (xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,xcdecomp,xcde007, 
#                   xcde008,xcde009,xcde010,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304, 
#                   xcde307,xcde308,xcde901,xcde902) = (g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002, 
#                   g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006,g_xcde_d[l_ac].xcdecomp, 
#                   g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009,g_xcde_d[l_ac].xcde010, 
#                   g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201,g_xcde_d[l_ac].xcde202, 
#                   g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303,g_xcde_d[l_ac].xcde304, 
#                   g_xcde_d[l_ac].xcde307,g_xcde_d[l_ac].xcde308,g_xcde_d[l_ac].xcde901,g_xcde_d[l_ac].xcde902) 
#
#                WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld 
#                  AND xcde001 = g_xccd_m.xccd001 
#                  AND xcde002 = g_xccd_m.xccd002 
#                  AND xcde003 = g_xccd_m.xccd003 
#                  AND xcde004 = g_xccd_m.xccd004 
#                  AND xcde005 = g_xccd_m.xccd005 
#                  AND xcde006 = g_xccd_m.xccd006 
# 
#                  AND xcde007 = g_xcde_d_t.xcde007 #項次   
#                  AND xcde008 = g_xcde_d_t.xcde008  
#                  AND xcde009 = g_xcde_d_t.xcde009  
#                  AND xcde010 = g_xcde_d_t.xcde010  
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcde_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xcde_d[l_ac].* = g_xcde_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcde_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_xcde_d[l_ac].* = g_xcde_d_t.*  
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys_bak[1] = g_xccdld_t
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys_bak[2] = g_xccd001_t
#               LET gs_keys[3] = g_xccd_m.xccd002
#               LET gs_keys_bak[3] = g_xccd002_t
#               LET gs_keys[4] = g_xccd_m.xccd003
#               LET gs_keys_bak[4] = g_xccd003_t
#               LET gs_keys[5] = g_xccd_m.xccd004
#               LET gs_keys_bak[5] = g_xccd004_t
#               LET gs_keys[6] = g_xccd_m.xccd005
#               LET gs_keys_bak[6] = g_xccd005_t
#               LET gs_keys[7] = g_xccd_m.xccd006
#               LET gs_keys_bak[7] = g_xccd006_t
#               LET gs_keys[8] = g_xcde_d[g_detail_idx].xcde007
#               LET gs_keys_bak[8] = g_xcde_d_t.xcde007
#               LET gs_keys[9] = g_xcde_d[g_detail_idx].xcde008
#               LET gs_keys_bak[9] = g_xcde_d_t.xcde008
#               LET gs_keys[10] = g_xcde_d[g_detail_idx].xcde009
#               LET gs_keys_bak[10] = g_xcde_d_t.xcde009
#               LET gs_keys[11] = g_xcde_d[g_detail_idx].xcde010
#               LET gs_keys_bak[11] = g_xcde_d_t.xcde010
#               CALL axcq740_update_b('xcde_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         INITIALIZE l_var_keys_bak TO NULL 
         IF g_xccd_m.xccdld = g_detail_multi_table_t.xccdld AND
         g_xccd_m.xccd001 = g_detail_multi_table_t.xccd001 AND
         g_xcde_d[l_ac].xccd002 = g_detail_multi_table_t.xccd002 AND
         g_xccd_m.xccd003 = g_detail_multi_table_t.xccd003 AND
         g_xccd_m.xccd004 = g_detail_multi_table_t.xccd004 AND
         g_xccd_m.xccd005 = g_detail_multi_table_t.xccd005 AND
         g_xcde_d[l_ac].xccd006 = g_detail_multi_table_t.xccd006 AND
         g_xcde3_d[l_ac].xcdi007 = g_detail_multi_table_t.xccd002 AND
         g_xcde3_d[l_ac].xcdi008 = g_detail_multi_table_t.xccd006 #AND
#         g_xcde3_d[l_ac].xcdi009 =  AND
#         g_xcde3_d[l_ac].xcdi010 =  AND
#         g_xcde_d[l_ac].xccd002 =  AND
#         g_xcde_d[l_ac].xccd006 =  
           THEN
         ELSE 
            LET l_var_keys[01] = g_xccd_m.xccdld
            LET l_field_keys[01] = 'xccdld'
            LET l_var_keys[02] = g_xccd_m.xccd001
            LET l_field_keys[02] = 'xccd001'
            LET l_var_keys[03] = g_xcde_d[l_ac].xccd002
            LET l_field_keys[03] = 'xccd002'
            LET l_var_keys[04] = g_xccd_m.xccd003
            LET l_field_keys[04] = 'xccd003'
            LET l_var_keys[05] = g_xccd_m.xccd004
            LET l_field_keys[05] = 'xccd004'
            LET l_var_keys[06] = g_xccd_m.xccd005
            LET l_field_keys[06] = 'xccd005'
            LET l_var_keys[07] = g_xcde_d[l_ac].xccd006
            LET l_field_keys[07] = 'xccd006'
            LET l_vars[01] = g_xcde_d[l_ac].xccd002
            LET l_fields[01] = 'xccd002'
            LET l_vars[02] = g_xcde_d[l_ac].xccd006
            LET l_fields[02] = 'xccd006'
            LET l_vars[03] = g_enterprise 
            LET l_fields[03] = 'xccdent'
            LET l_var_keys_bak[01] = g_detail_multi_table_t.xccdld
            LET l_var_keys_bak[02] = g_detail_multi_table_t.xccd001
            LET l_var_keys_bak[03] = g_detail_multi_table_t.xccd002
            LET l_var_keys_bak[04] = g_detail_multi_table_t.xccd003
            LET l_var_keys_bak[05] = g_detail_multi_table_t.xccd004
            LET l_var_keys_bak[06] = g_detail_multi_table_t.xccd005
            LET l_var_keys_bak[07] = g_detail_multi_table_t.xccd006
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xccd_t')
         END IF 
 
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde_d_t)
               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後

               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row

            #end add-point
            CALL axcq740_unlock_b("xcde_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2

            #end add-point
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_xcde_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcde_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xcde3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前

            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcde3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq740_b_fill()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_rec_b = g_xcde3_d.getLength()
            #add-point:資料輸入前

            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcde3_d[l_ac].* TO NULL 
            INITIALIZE g_xcde3_d_t.* TO NULL 
            INITIALIZE g_xcde3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份

            #end add-point
            LET g_xcde3_d_t.* = g_xcde3_d[l_ac].*     #新輸入資料
            LET g_xcde3_d_o.* = g_xcde3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq740_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL axcq740_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcde3_d[li_reproduce_target].* = g_xcde3_d[li_reproduce].*
 
               LET g_xcde3_d[li_reproduce_target].xcdi007 = NULL
               LET g_xcde3_d[li_reproduce_target].xcdi008 = NULL
               LET g_xcde3_d[li_reproduce_target].xcdi009 = NULL
               LET g_xcde3_d[li_reproduce_target].xcdi010 = NULL
            END IF
            LET g_detail_multi_table_t.xccdld = g_xccd_m.xccdld
LET g_detail_multi_table_t.xccd001 = g_xccd_m.xccd001
LET g_detail_multi_table_t.xccd002 = g_xcde_d[l_ac].xccd002
LET g_detail_multi_table_t.xccd003 = g_xccd_m.xccd003
LET g_detail_multi_table_t.xccd004 = g_xccd_m.xccd004
LET g_detail_multi_table_t.xccd005 = g_xccd_m.xccd005
LET g_detail_multi_table_t.xccd006 = g_xcde_d[l_ac].xccd006
LET g_detail_multi_table_t.xccd002 = g_xcde3_d[l_ac].xcdi007
LET g_detail_multi_table_t.xccd006 = g_xcde3_d[l_ac].xcdi008
 
            #add-point:modify段before insert

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
            OPEN axcq740_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axcq740_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE axcq740_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_xcde3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xcde3_d[l_ac].xcdi007 IS NOT NULL
               AND g_xcde3_d[l_ac].xcdi008 IS NOT NULL
               AND g_xcde3_d[l_ac].xcdi009 IS NOT NULL
               AND g_xcde3_d[l_ac].xcdi010 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xcde3_d_t.* = g_xcde3_d[l_ac].*  #BACKUP
               LET g_xcde3_d_o.* = g_xcde3_d[l_ac].*  #BACKUP
               CALL axcq740_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL axcq740_set_no_entry_b(l_cmd)
               IF NOT axcq740_lock_b("xcdi_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq740_bcl2 INTO g_xcde3_d[l_ac].sfaasite,g_xcde3_d[l_ac].xcdi007,g_xcde3_d[l_ac].xcdi008, 
                      g_xcde3_d[l_ac].xcdi009,g_xcde3_d[l_ac].xcdi010,g_xcde3_d[l_ac].xcdi101,g_xcde3_d[l_ac].xcdi102, 
                      g_xcde3_d[l_ac].xcdi201,g_xcde3_d[l_ac].xcdi202,g_xcde3_d[l_ac].xcdi301,g_xcde3_d[l_ac].xcdi302, 
                      g_xcde3_d[l_ac].xcdi303,g_xcde3_d[l_ac].xcdi304,g_xcde3_d[l_ac].xcdi901,g_xcde3_d[l_ac].xcdi902 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL axcq740_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row

            #end add-point  
            #其他table資料備份(確定是否更改用)
            LET g_detail_multi_table_t.xccdld = g_xccd_m.xccdld
LET g_detail_multi_table_t.xccd001 = g_xccd_m.xccd001
LET g_detail_multi_table_t.xccd002 = g_xcde_d[l_ac].xccd002
LET g_detail_multi_table_t.xccd003 = g_xccd_m.xccd003
LET g_detail_multi_table_t.xccd004 = g_xccd_m.xccd004
LET g_detail_multi_table_t.xccd005 = g_xccd_m.xccd005
LET g_detail_multi_table_t.xccd006 = g_xcde_d[l_ac].xccd006
LET g_detail_multi_table_t.xccd002 = g_xcde3_d[l_ac].xcdi007
LET g_detail_multi_table_t.xccd006 = g_xcde3_d[l_ac].xcdi008
 
            #其他table進行lock
            
            
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
               
               #add-point:單身3刪除前

               #end add-point    
               
#               DELETE FROM xcdi_t
#                WHERE xcdient = g_enterprise AND xcdild = g_xccd_m.xccdld AND
#                                          xcdi001 = g_xccd_m.xccd001 AND
#                                          xcdi002 = g_xccd_m.xccd002 AND
#                                          xcdi003 = g_xccd_m.xccd003 AND
#                                          xcdi004 = g_xccd_m.xccd004 AND
#                                          xcdi005 = g_xccd_m.xccd005 AND
#                                          xcdi006 = g_xccd_m.xccd006 AND
#                      xcdi007 = g_xcde3_d_t.xcdi007
#                  AND xcdi008 = g_xcde3_d_t.xcdi008
#                  AND xcdi009 = g_xcde3_d_t.xcdi009
#                  AND xcdi010 = g_xcde3_d_t.xcdi010
#                  
               #add-point:單身3刪除中

               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xcde_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  INITIALIZE l_var_keys_bak TO NULL 
                  INITIALIZE l_field_keys TO NULL 
                  LET l_field_keys[01] = 'xccdld'
                  LET l_field_keys[02] = 'xccd001'
                  LET l_field_keys[03] = 'xccd002'
                  LET l_field_keys[04] = 'xccd003'
                  LET l_field_keys[05] = 'xccd004'
                  LET l_field_keys[06] = 'xccd005'
                  LET l_field_keys[07] = 'xccd006'
                  LET l_var_keys_bak[01] = g_detail_multi_table_t.xccdld
                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xccd001
                  LET l_var_keys_bak[03] = g_detail_multi_table_t.xccd002
                  LET l_var_keys_bak[04] = g_detail_multi_table_t.xccd003
                  LET l_var_keys_bak[05] = g_detail_multi_table_t.xccd004
                  LET l_var_keys_bak[06] = g_detail_multi_table_t.xccd005
                  LET l_var_keys_bak[07] = g_detail_multi_table_t.xccd006
                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xccd_t')
 
                  #add-point:單身3刪除後

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE axcq740_bcl
               LET l_count = g_xcde_d.getLength()
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd002
#               LET gs_keys[4] = g_xccd_m.xccd003
#               LET gs_keys[5] = g_xccd_m.xccd004
#               LET gs_keys[6] = g_xccd_m.xccd005
#               LET gs_keys[7] = g_xccd_m.xccd006
#               LET gs_keys[8] = g_xcde3_d[g_detail_idx].xcdi007
#               LET gs_keys[9] = g_xcde3_d[g_detail_idx].xcdi008
#               LET gs_keys[10] = g_xcde3_d[g_detail_idx].xcdi009
#               LET gs_keys[11] = g_xcde3_d[g_detail_idx].xcdi010
# 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
                              CALL axcq740_delete_b('xcdi_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcde3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身3新增前

            #end add-point
               
            LET l_count = 1  
#            SELECT COUNT(*) INTO l_count FROM xcdi_t 
#             WHERE xcdient = g_enterprise AND xcdild = g_xccd_m.xccdld
#               AND xcdi001 = g_xccd_m.xccd001
#               AND xcdi002 = g_xccd_m.xccd002
#               AND xcdi003 = g_xccd_m.xccd003
#               AND xcdi004 = g_xccd_m.xccd004
#               AND xcdi005 = g_xccd_m.xccd005
#               AND xcdi006 = g_xccd_m.xccd006
#               AND xcdi007 = g_xcde3_d[l_ac].xcdi007
#               AND xcdi008 = g_xcde3_d[l_ac].xcdi008
#               AND xcdi009 = g_xcde3_d[l_ac].xcdi009
#               AND xcdi010 = g_xcde3_d[l_ac].xcdi010
#                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd002
#               LET gs_keys[4] = g_xccd_m.xccd003
#               LET gs_keys[5] = g_xccd_m.xccd004
#               LET gs_keys[6] = g_xccd_m.xccd005
#               LET gs_keys[7] = g_xccd_m.xccd006
#               LET gs_keys[8] = g_xcde3_d[g_detail_idx].xcdi007
#               LET gs_keys[9] = g_xcde3_d[g_detail_idx].xcdi008
#               LET gs_keys[10] = g_xcde3_d[g_detail_idx].xcdi009
#               LET gs_keys[11] = g_xcde3_d[g_detail_idx].xcdi010
#               CALL axcq740_insert_b('xcdi_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xcde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcdi_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axcq740_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
               CLOSE axcq740_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
            ELSE
               #add-point:單身page3修改前

               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
#               UPDATE xcdi_t SET (xcdild,xcdi001,xcdi002,xcdi003,xcdi004,xcdi005,xcdi006,xcdicomp,xcdi007, 
#                   xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202,xcdi301,xcdi302,xcdi303,xcdi304, 
#                   xcdi901,xcdi902) = (g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003, 
#                   g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006,g_xcde3_d[l_ac].xcdicomp,g_xcde3_d[l_ac].xcdi007, 
#                   g_xcde3_d[l_ac].xcdi008,g_xcde3_d[l_ac].xcdi009,g_xcde3_d[l_ac].xcdi010,g_xcde3_d[l_ac].xcdi101, 
#                   g_xcde3_d[l_ac].xcdi102,g_xcde3_d[l_ac].xcdi201,g_xcde3_d[l_ac].xcdi202,g_xcde3_d[l_ac].xcdi301, 
#                   g_xcde3_d[l_ac].xcdi302,g_xcde3_d[l_ac].xcdi303,g_xcde3_d[l_ac].xcdi304,g_xcde3_d[l_ac].xcdi901, 
#                   g_xcde3_d[l_ac].xcdi902) #自訂欄位頁簽
#                WHERE xcdient = g_enterprise AND xcdild = g_xccd_m.xccdld
#                  AND xcdi001 = g_xccd_m.xccd001
#                  AND xcdi002 = g_xccd_m.xccd002
#                  AND xcdi003 = g_xccd_m.xccd003
#                  AND xcdi004 = g_xccd_m.xccd004
#                  AND xcdi005 = g_xccd_m.xccd005
#                  AND xcdi006 = g_xccd_m.xccd006
#                  AND xcdi007 = g_xcde3_d_t.xcdi007 #項次 
#                  AND xcdi008 = g_xcde3_d_t.xcdi008
#                  AND xcdi009 = g_xcde3_d_t.xcdi009
#                  AND xcdi010 = g_xcde3_d_t.xcdi010
                  
               #add-point:單身page3修改中

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdi_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdi_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys_bak[1] = g_xccdld_t
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys_bak[2] = g_xccd001_t
#               LET gs_keys[3] = g_xccd_m.xccd002
#               LET gs_keys_bak[3] = g_xccd002_t
#               LET gs_keys[4] = g_xccd_m.xccd003
#               LET gs_keys_bak[4] = g_xccd003_t
#               LET gs_keys[5] = g_xccd_m.xccd004
#               LET gs_keys_bak[5] = g_xccd004_t
#               LET gs_keys[6] = g_xccd_m.xccd005
#               LET gs_keys_bak[6] = g_xccd005_t
#               LET gs_keys[7] = g_xccd_m.xccd006
#               LET gs_keys_bak[7] = g_xccd006_t
#               LET gs_keys[8] = g_xcde3_d[g_detail_idx].xcdi007
#               LET gs_keys_bak[8] = g_xcde3_d_t.xcdi007
#               LET gs_keys[9] = g_xcde3_d[g_detail_idx].xcdi008
#               LET gs_keys_bak[9] = g_xcde3_d_t.xcdi008
#               LET gs_keys[10] = g_xcde3_d[g_detail_idx].xcdi009
#               LET gs_keys_bak[10] = g_xcde3_d_t.xcdi009
#               LET gs_keys[11] = g_xcde3_d[g_detail_idx].xcdi010
#               LET gs_keys_bak[11] = g_xcde3_d_t.xcdi010
#               CALL axcq740_update_b('xcdi_t',gs_keys,gs_keys_bak,"'3'")
#                     #資料多語言用-增/改
#                     
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde3_d_t)
               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xcde3_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後

               #end add-point
            END IF
         
                  #此段落由子樣板a02產生
       # AFTER FIELD xcdicomp
            
            #add-point:AFTER FIELD xcdicomp


            #END add-point
            
 
         #此段落由子樣板a01產生
#         BEFORE FIELD xcdicomp
            #add-point:BEFORE FIELD xcdicomp

            #END add-point
 
         #此段落由子樣板a04產生
#         ON CHANGE xcdicomp
            #add-point:ON CHANGE xcdicomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi007
            
            #add-point:AFTER FIELD xcdi007
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi007 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi008 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi009 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi010 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde3_d[g_detail_idx].xcdi007 != g_xcde3_d_t.xcdi007 OR g_xcde3_d[g_detail_idx].xcdi008 != g_xcde3_d_t.xcdi008 OR g_xcde3_d[g_detail_idx].xcdi009 != g_xcde3_d_t.xcdi009 OR g_xcde3_d[g_detail_idx].xcdi010 != g_xcde3_d_t.xcdi010)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdi_t WHERE "||"xcdient = '" ||g_enterprise|| "' AND "||"xcdild = '"||g_xccd_m.xccdld ||"' AND "|| "xcdi001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcdi002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcdi003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcdi004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcdi005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcdi006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcdi007 = '"||g_xcde3_d[g_detail_idx].xcdi007 ||"' AND "|| "xcdi008 = '"||g_xcde3_d[g_detail_idx].xcdi008 ||"' AND "|| "xcdi009 = '"||g_xcde3_d[g_detail_idx].xcdi009 ||"' AND "|| "xcdi010 = '"||g_xcde3_d[g_detail_idx].xcdi010 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi007
            #add-point:BEFORE FIELD xcdi007

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi007
            #add-point:ON CHANGE xcdi007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi008
            #add-point:BEFORE FIELD xcdi008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi008
            
            #add-point:AFTER FIELD xcdi008
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi007 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi008 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi009 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi010 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde3_d[g_detail_idx].xcdi007 != g_xcde3_d_t.xcdi007 OR g_xcde3_d[g_detail_idx].xcdi008 != g_xcde3_d_t.xcdi008 OR g_xcde3_d[g_detail_idx].xcdi009 != g_xcde3_d_t.xcdi009 OR g_xcde3_d[g_detail_idx].xcdi010 != g_xcde3_d_t.xcdi010)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdi_t WHERE "||"xcdient = '" ||g_enterprise|| "' AND "||"xcdild = '"||g_xccd_m.xccdld ||"' AND "|| "xcdi001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcdi002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcdi003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcdi004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcdi005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcdi006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcdi007 = '"||g_xcde3_d[g_detail_idx].xcdi007 ||"' AND "|| "xcdi008 = '"||g_xcde3_d[g_detail_idx].xcdi008 ||"' AND "|| "xcdi009 = '"||g_xcde3_d[g_detail_idx].xcdi009 ||"' AND "|| "xcdi010 = '"||g_xcde3_d[g_detail_idx].xcdi010 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi008
            #add-point:ON CHANGE xcdi008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi009
            #add-point:BEFORE FIELD xcdi009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi009
            
            #add-point:AFTER FIELD xcdi009
            #此段落由子樣板a05產生
            #確認資料無重複
#            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi007 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi008 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi009 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi010 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde3_d[g_detail_idx].xcdi007 != g_xcde3_d_t.xcdi007 OR g_xcde3_d[g_detail_idx].xcdi008 != g_xcde3_d_t.xcdi008 OR g_xcde3_d[g_detail_idx].xcdi009 != g_xcde3_d_t.xcdi009 OR g_xcde3_d[g_detail_idx].xcdi010 != g_xcde3_d_t.xcdi010)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdi_t WHERE "||"xcdient = '" ||g_enterprise|| "' AND "||"xcdild = '"||g_xccd_m.xccdld ||"' AND "|| "xcdi001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcdi002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcdi003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcdi004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcdi005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcdi006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcdi007 = '"||g_xcde3_d[g_detail_idx].xcdi007 ||"' AND "|| "xcdi008 = '"||g_xcde3_d[g_detail_idx].xcdi008 ||"' AND "|| "xcdi009 = '"||g_xcde3_d[g_detail_idx].xcdi009 ||"' AND "|| "xcdi010 = '"||g_xcde3_d[g_detail_idx].xcdi010 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi009
            #add-point:ON CHANGE xcdi009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi010
            
            #add-point:AFTER FIELD xcdi010
            #此段落由子樣板a05產生
#            #確認資料無重複
#            IF  g_xccd_m.xccdld IS NOT NULL AND g_xccd_m.xccd001 IS NOT NULL AND g_xccd_m.xccd002 IS NOT NULL AND g_xccd_m.xccd003 IS NOT NULL AND g_xccd_m.xccd004 IS NOT NULL AND g_xccd_m.xccd005 IS NOT NULL AND g_xccd_m.xccd006 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi007 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi008 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi009 IS NOT NULL AND g_xcde3_d[g_detail_idx].xcdi010 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccd_m.xccdld != g_xccdld_t OR g_xccd_m.xccd001 != g_xccd001_t OR g_xccd_m.xccd002 != g_xccd002_t OR g_xccd_m.xccd003 != g_xccd003_t OR g_xccd_m.xccd004 != g_xccd004_t OR g_xccd_m.xccd005 != g_xccd005_t OR g_xccd_m.xccd006 != g_xccd006_t OR g_xcde3_d[g_detail_idx].xcdi007 != g_xcde3_d_t.xcdi007 OR g_xcde3_d[g_detail_idx].xcdi008 != g_xcde3_d_t.xcdi008 OR g_xcde3_d[g_detail_idx].xcdi009 != g_xcde3_d_t.xcdi009 OR g_xcde3_d[g_detail_idx].xcdi010 != g_xcde3_d_t.xcdi010)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdi_t WHERE "||"xcdient = '" ||g_enterprise|| "' AND "||"xcdild = '"||g_xccd_m.xccdld ||"' AND "|| "xcdi001 = '"||g_xccd_m.xccd001 ||"' AND "|| "xcdi002 = '"||g_xccd_m.xccd002 ||"' AND "|| "xcdi003 = '"||g_xccd_m.xccd003 ||"' AND "|| "xcdi004 = '"||g_xccd_m.xccd004 ||"' AND "|| "xcdi005 = '"||g_xccd_m.xccd005 ||"' AND "|| "xcdi006 = '"||g_xccd_m.xccd006 ||"' AND "|| "xcdi007 = '"||g_xcde3_d[g_detail_idx].xcdi007 ||"' AND "|| "xcdi008 = '"||g_xcde3_d[g_detail_idx].xcdi008 ||"' AND "|| "xcdi009 = '"||g_xcde3_d[g_detail_idx].xcdi009 ||"' AND "|| "xcdi010 = '"||g_xcde3_d[g_detail_idx].xcdi010 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
#

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi010
            #add-point:BEFORE FIELD xcdi010

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi010
            #add-point:ON CHANGE xcdi010

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi101
            #add-point:BEFORE FIELD xcdi101

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi101
            
            #add-point:AFTER FIELD xcdi101

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi101
            #add-point:ON CHANGE xcdi101

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi102
            #add-point:BEFORE FIELD xcdi102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi102
            
            #add-point:AFTER FIELD xcdi102

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi102
            #add-point:ON CHANGE xcdi102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi201
            #add-point:BEFORE FIELD xcdi201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi201
            
            #add-point:AFTER FIELD xcdi201

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi201
            #add-point:ON CHANGE xcdi201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi202
            #add-point:BEFORE FIELD xcdi202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi202
            
            #add-point:AFTER FIELD xcdi202

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi202
            #add-point:ON CHANGE xcdi202

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi301
            #add-point:BEFORE FIELD xcdi301

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi301
            
            #add-point:AFTER FIELD xcdi301

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi301
            #add-point:ON CHANGE xcdi301

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi302
            #add-point:BEFORE FIELD xcdi302

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi302
            
            #add-point:AFTER FIELD xcdi302

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi302
            #add-point:ON CHANGE xcdi302

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi303
            #add-point:BEFORE FIELD xcdi303

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi303
            
            #add-point:AFTER FIELD xcdi303

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi303
            #add-point:ON CHANGE xcdi303

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi304
            #add-point:BEFORE FIELD xcdi304

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi304
            
            #add-point:AFTER FIELD xcdi304

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi304
            #add-point:ON CHANGE xcdi304

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi901
            #add-point:BEFORE FIELD xcdi901

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi901
            
            #add-point:AFTER FIELD xcdi901

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi901
            #add-point:ON CHANGE xcdi901

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdi902
            #add-point:BEFORE FIELD xcdi902

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdi902
            
            #add-point:AFTER FIELD xcdi902

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdi902
            #add-point:ON CHANGE xcdi902

            #END add-point
 
 
                  #Ctrlp:input.c.page3.xcdicomp
#         ON ACTION controlp INFIELD xcdicomp
            #add-point:ON ACTION controlp INFIELD xcdicomp

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi007
         ON ACTION controlp INFIELD xcdi007
            #add-point:ON ACTION controlp INFIELD xcdi007

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi008
         ON ACTION controlp INFIELD xcdi008
            #add-point:ON ACTION controlp INFIELD xcdi008

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi009
         ON ACTION controlp INFIELD xcdi009
            #add-point:ON ACTION controlp INFIELD xcdi009

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi010
         ON ACTION controlp INFIELD xcdi010
            #add-point:ON ACTION controlp INFIELD xcdi010

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi101
         ON ACTION controlp INFIELD xcdi101
            #add-point:ON ACTION controlp INFIELD xcdi101

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi102
         ON ACTION controlp INFIELD xcdi102
            #add-point:ON ACTION controlp INFIELD xcdi102

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi201
         ON ACTION controlp INFIELD xcdi201
            #add-point:ON ACTION controlp INFIELD xcdi201

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi202
         ON ACTION controlp INFIELD xcdi202
            #add-point:ON ACTION controlp INFIELD xcdi202

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi301
         ON ACTION controlp INFIELD xcdi301
            #add-point:ON ACTION controlp INFIELD xcdi301

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi302
         ON ACTION controlp INFIELD xcdi302
            #add-point:ON ACTION controlp INFIELD xcdi302

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi303
         ON ACTION controlp INFIELD xcdi303
            #add-point:ON ACTION controlp INFIELD xcdi303

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi304
         ON ACTION controlp INFIELD xcdi304
            #add-point:ON ACTION controlp INFIELD xcdi304

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi901
         ON ACTION controlp INFIELD xcdi901
            #add-point:ON ACTION controlp INFIELD xcdi901

            #END add-point
 
         #Ctrlp:input.c.page3.xcdi902
         ON ACTION controlp INFIELD xcdi902
            #add-point:ON ACTION controlp INFIELD xcdi902

            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcde3_d[l_ac].* = g_xcde3_d_t.*
               END IF
               CLOSE axcq740_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axcq740_unlock_b("xcdi_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2

            #end add-point
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_xcde3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcde3_d.getLength()+1
 
      END INPUT
 
      
 
      
      DISPLAY ARRAY g_xcde2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL axcq740_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作

            #end add-point
            
         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL axcq740_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為

         #end add-point
      
      END DISPLAY
 
      
 
      
 
{</section>}
 
{<section id="axcq740.input.other" >}
      
      #add-point:自定義input

      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog

         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccdld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD sfaasite
               WHEN "s_detail2"
                  NEXT FIELD sfaasite_2
               WHEN "s_detail3"
                  NEXT FIELD sfaasite_3
 
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
 
{<section id="axcq740.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq740_show()
   DEFINE l_ac_t    LIKE type_t.num10  #161108-00012#4 num5==》num10
   #add-point:show段define
   
   #end add-point  
 
   #add-point:show段之前
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
      CALL cl_set_comp_visible('xccd002,xccd002_desc,xccd002_2,xccd002_2_desc,xccd002_3,xccd002_3_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccd002,xccd002_desc,xccd002_2,xccd002_2_desc,xccd002_3,xccd002_3_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcdi008',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcde008,xcde008_2,xcdi008',FALSE)                
   END IF   
   #fengmy 150113----end     
   
   CALL axcq740_ref()
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axcq740_b_fill() #單身填充
      CALL axcq740_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL axcq740_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
   
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccd004,g_xccd_m.xccd001,g_xccd_m.xccdld, 
       g_xccd_m.xccdld_desc,g_xccd_m.xccd005,g_xccd_m.xccd003,g_xccd_m.xccd003_desc,g_xccd_m.xccd001_desc
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcde_d.getLength()
      #add-point:show段單身reference

   
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcde2_d.getLength()
      #add-point:show段單身reference

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xcde3_d.getLength()
      #add-point:show段單身reference

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other

   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axcq740_detail_show()
   
   #add-point:show段之後

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axcq740_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq740_reproduce()
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
 
   #DEFINE l_master    RECORD LIKE xccd_t.*  #161124-00048#17 2016/12/16 By 08734 mark
   #161124-00048#17 2016/12/16 By 08734 add(S)
   DEFINE l_master RECORD  #在製主件成本期異動統計檔
       xccdent LIKE xccd_t.xccdent, #企业编号
       xccdcomp LIKE xccd_t.xccdcomp, #法人组织
       xccdld LIKE xccd_t.xccdld, #账套
       xccd001 LIKE xccd_t.xccd001, #账套本位币顺序
       xccd002 LIKE xccd_t.xccd002, #成本域
       xccd003 LIKE xccd_t.xccd003, #成本计算类型
       xccd004 LIKE xccd_t.xccd004, #年度
       xccd005 LIKE xccd_t.xccd005, #期别
       xccd006 LIKE xccd_t.xccd006, #工单编号
       xccd007 LIKE xccd_t.xccd007, #主件料号
       xccd008 LIKE xccd_t.xccd008, #特性
       xccd009 LIKE xccd_t.xccd009, #批号
       xccd010 LIKE xccd_t.xccd010, #项目号
       xccd011 LIKE xccd_t.xccd011, #核算币种
       xccd012 LIKE xccd_t.xccd012, #重复性成产否
       xccd013 LIKE xccd_t.xccd013, #成产计划号
       xccd014 LIKE xccd_t.xccd014, #BOM特性
       xccd101 LIKE xccd_t.xccd101, #上期结存数量
       xccd102 LIKE xccd_t.xccd102, #上期结存金额
       xccd200 LIKE xccd_t.xccd200, #本期投入工时
       xccd201 LIKE xccd_t.xccd201, #本期投入数量
       xccd202 LIKE xccd_t.xccd202, #本期本阶投入金额
       xccd204 LIKE xccd_t.xccd204, #本期下阶投入金额
       xccd301 LIKE xccd_t.xccd301, #本期转出数量
       xccd302 LIKE xccd_t.xccd302, #本期转出金额
       xccd303 LIKE xccd_t.xccd303, #差异转出数量
       xccd304 LIKE xccd_t.xccd304, #差异转出金额
       xccd901 LIKE xccd_t.xccd901, #期末结存数量
       xccd902 LIKE xccd_t.xccd902 #期末结存金额
END RECORD
#161124-00048#17 2016/12/16 By 08734 add(E)
   #DEFINE l_detail    RECORD LIKE xcde_t.*  #161124-00048#17 2016/12/16 By 08734 mark
   #161124-00048#17 2016/12/16 By 08734 add(S)
   DEFINE l_detail RECORD  #在製成本次要素期異動統計檔
       xcdeent LIKE xcde_t.xcdeent, #企业编号
       xcdecomp LIKE xcde_t.xcdecomp, #法人组织
       xcdeld LIKE xcde_t.xcdeld, #账套
       xcde001 LIKE xcde_t.xcde001, #账套本位币顺序
       xcde002 LIKE xcde_t.xcde002, #成本域
       xcde003 LIKE xcde_t.xcde003, #成本计算类型
       xcde004 LIKE xcde_t.xcde004, #年度
       xcde005 LIKE xcde_t.xcde005, #期别
       xcde006 LIKE xcde_t.xcde006, #工单编号/在制编号
       xcde007 LIKE xcde_t.xcde007, #元件料号
       xcde008 LIKE xcde_t.xcde008, #特性
       xcde009 LIKE xcde_t.xcde009, #批号
       xcde010 LIKE xcde_t.xcde010, #成本次要素
       xcde020 LIKE xcde_t.xcde020, #核算币种
       xcde101 LIKE xcde_t.xcde101, #上期结存数量
       xcde102 LIKE xcde_t.xcde102, #上期结存金额
       xcde201 LIKE xcde_t.xcde201, #本期投入数量
       xcde202 LIKE xcde_t.xcde202, #本期本阶投入金额
       xcde205 LIKE xcde_t.xcde205, #本期当站下线数量
       xcde206 LIKE xcde_t.xcde206, #本期当站下线成本
       xcde207 LIKE xcde_t.xcde207, #本期一般退料数量
       xcde208 LIKE xcde_t.xcde208, #本期一般退料成本
       xcde209 LIKE xcde_t.xcde209, #本期超领退数量
       xcde210 LIKE xcde_t.xcde210, #本期超领退金额
       xcde301 LIKE xcde_t.xcde301, #本期转出数量
       xcde302 LIKE xcde_t.xcde302, #本期转出金额
       xcde303 LIKE xcde_t.xcde303, #差异转出数量
       xcde304 LIKE xcde_t.xcde304, #差异转出金额
       xcde307 LIKE xcde_t.xcde307, #盘差数量
       xcde308 LIKE xcde_t.xcde308, #盘差金额
       xcde901 LIKE xcde_t.xcde901, #期末结存数量
       xcde902 LIKE xcde_t.xcde902 #期末结存金额
END RECORD
#161124-00048#17 2016/12/16 By 08734 add(E)
   #DEFINE l_detail2    RECORD LIKE xcdi_t.*  #161124-00048#17 2016/12/16 By 08734 mark
   #161124-00048#17 2016/12/16 By 08734 add(S)
   DEFINE l_detail2 RECORD  #拆件在製成本次要素期異動統計當
       xcdient LIKE xcdi_t.xcdient, #企业编号
       xcdicomp LIKE xcdi_t.xcdicomp, #法人组织
       xcdild LIKE xcdi_t.xcdild, #账套
       xcdi001 LIKE xcdi_t.xcdi001, #账套本位币顺序
       xcdi002 LIKE xcdi_t.xcdi002, #成本域
       xcdi003 LIKE xcdi_t.xcdi003, #成本计算类型
       xcdi004 LIKE xcdi_t.xcdi004, #年度
       xcdi005 LIKE xcdi_t.xcdi005, #期别
       xcdi006 LIKE xcdi_t.xcdi006, #拆件工单编号
       xcdi007 LIKE xcdi_t.xcdi007, #元件料号
       xcdi008 LIKE xcdi_t.xcdi008, #特性
       xcdi009 LIKE xcdi_t.xcdi009, #批次
       xcdi010 LIKE xcdi_t.xcdi010, #成本次要素
       xcdi020 LIKE xcdi_t.xcdi020, #核算币种
       xcdi101 LIKE xcdi_t.xcdi101, #上期结存数量
       xcdi102 LIKE xcdi_t.xcdi102, #上期结存金额
       xcdi201 LIKE xcdi_t.xcdi201, #本期投入数量
       xcdi202 LIKE xcdi_t.xcdi202, #本期本阶投入金额
       xcdi301 LIKE xcdi_t.xcdi301, #本期转出数量
       xcdi302 LIKE xcdi_t.xcdi302, #本期转出金额
       xcdi303 LIKE xcdi_t.xcdi303, #差异转出数量
       xcdi304 LIKE xcdi_t.xcdi304, #差异转出金额
       xcdi901 LIKE xcdi_t.xcdi901, #期末结存数量
       xcdi902 LIKE xcdi_t.xcdi902 #期末结存金额
END RECORD
#161124-00048#17 2016/12/16 By 08734 add(E)
 
 
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define

   #end add-point   
 
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_xccd_m.xccdld IS NULL
   OR g_xccd_m.xccd001 IS NULL   
   OR g_xccd_m.xccd003 IS NULL
   OR g_xccd_m.xccd004 IS NULL
   OR g_xccd_m.xccd005 IS NULL
   
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
#   LET g_xccdld_t = g_xccd_m.xccdld
#   LET g_xccd001_t = g_xccd_m.xccd001
#   LET g_xccd002_t = g_xccd_m.xccd002
#   LET g_xccd003_t = g_xccd_m.xccd003
#   LET g_xccd004_t = g_xccd_m.xccd004
#   LET g_xccd005_t = g_xccd_m.xccd005
#   LET g_xccd006_t = g_xccd_m.xccd006
# 
#    
#   LET g_xccd_m.xccdld = ""
#   LET g_xccd_m.xccd001 = ""
#   LET g_xccd_m.xccd002 = ""
#   LET g_xccd_m.xccd003 = ""
#   LET g_xccd_m.xccd004 = ""
#   LET g_xccd_m.xccd005 = ""
#   LET g_xccd_m.xccd006 = ""
 
    
   CALL axcq740_set_entry('a')
   CALL axcq740_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前

   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   CALL axcq740_input("r")
   
      LET g_xccd_m.xccdld_desc = ''
   DISPLAY BY NAME g_xccd_m.xccdld_desc
   LET g_xccd_m.xccd003_desc = ''
   DISPLAY BY NAME g_xccd_m.xccd003_desc
 
   
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
      INITIALIZE g_xcde_d TO NULL
      INITIALIZE g_xcde2_d TO NULL
      INITIALIZE g_xcde3_d TO NULL
 
      #add-point:複製取消後

      #end add-point
      CALL axcq740_show()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq740_set_act_visible()   
   CALL axcq740_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
#   LET g_xccdld_t = g_xccd_m.xccdld
#   LET g_xccd001_t = g_xccd_m.xccd001
#   LET g_xccd002_t = g_xccd_m.xccd002
#   LET g_xccd003_t = g_xccd_m.xccd003
#   LET g_xccd004_t = g_xccd_m.xccd004
#   LET g_xccd005_t = g_xccd_m.xccd005
#   LET g_xccd006_t = g_xccd_m.xccd006
 
   
   #組合新增資料的條件
#   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
#                      " xccdld = '", g_xccd_m.xccdld CLIPPED, "' "
#                      ," AND xccd001 = '", g_xccd_m.xccd001 CLIPPED, "' "
#                      ," AND xccd002 = '", g_xccd_m.xccd002 CLIPPED, "' "
#                      ," AND xccd003 = '", g_xccd_m.xccd003 CLIPPED, "' "
#                      ," AND xccd004 = '", g_xccd_m.xccd004 CLIPPED, "' "
#                      ," AND xccd005 = '", g_xccd_m.xccd005 CLIPPED, "' "
#                      ," AND xccd006 = '", g_xccd_m.xccd006 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq740_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後

   #end add-point
   
   CALL axcq740_idx_chk()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq740_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   #DEFINE l_detail    RECORD LIKE xcde_t.*  #161124-00048#17 2016/12/16 By 08734 mark
   #161124-00048#17 2016/12/16 By 08734 add(S)
   DEFINE l_detail RECORD  #在製成本次要素期異動統計檔
       xcdeent LIKE xcde_t.xcdeent, #企业编号
       xcdecomp LIKE xcde_t.xcdecomp, #法人组织
       xcdeld LIKE xcde_t.xcdeld, #账套
       xcde001 LIKE xcde_t.xcde001, #账套本位币顺序
       xcde002 LIKE xcde_t.xcde002, #成本域
       xcde003 LIKE xcde_t.xcde003, #成本计算类型
       xcde004 LIKE xcde_t.xcde004, #年度
       xcde005 LIKE xcde_t.xcde005, #期别
       xcde006 LIKE xcde_t.xcde006, #工单编号/在制编号
       xcde007 LIKE xcde_t.xcde007, #元件料号
       xcde008 LIKE xcde_t.xcde008, #特性
       xcde009 LIKE xcde_t.xcde009, #批号
       xcde010 LIKE xcde_t.xcde010, #成本次要素
       xcde020 LIKE xcde_t.xcde020, #核算币种
       xcde101 LIKE xcde_t.xcde101, #上期结存数量
       xcde102 LIKE xcde_t.xcde102, #上期结存金额
       xcde201 LIKE xcde_t.xcde201, #本期投入数量
       xcde202 LIKE xcde_t.xcde202, #本期本阶投入金额
       xcde205 LIKE xcde_t.xcde205, #本期当站下线数量
       xcde206 LIKE xcde_t.xcde206, #本期当站下线成本
       xcde207 LIKE xcde_t.xcde207, #本期一般退料数量
       xcde208 LIKE xcde_t.xcde208, #本期一般退料成本
       xcde209 LIKE xcde_t.xcde209, #本期超领退数量
       xcde210 LIKE xcde_t.xcde210, #本期超领退金额
       xcde301 LIKE xcde_t.xcde301, #本期转出数量
       xcde302 LIKE xcde_t.xcde302, #本期转出金额
       xcde303 LIKE xcde_t.xcde303, #差异转出数量
       xcde304 LIKE xcde_t.xcde304, #差异转出金额
       xcde307 LIKE xcde_t.xcde307, #盘差数量
       xcde308 LIKE xcde_t.xcde308, #盘差金额
       xcde901 LIKE xcde_t.xcde901, #期末结存数量
       xcde902 LIKE xcde_t.xcde902 #期末结存金额
END RECORD
#161124-00048#17 2016/12/16 By 08734 add(E)
   #DEFINE l_detail2    RECORD LIKE xcdi_t.*  #161124-00048#17 2016/12/16 By 08734 mark
   #161124-00048#17 2016/12/16 By 08734 add(S)
   DEFINE l_detail2 RECORD  #拆件在製成本次要素期異動統計當
       xcdient LIKE xcdi_t.xcdient, #企业编号
       xcdicomp LIKE xcdi_t.xcdicomp, #法人组织
       xcdild LIKE xcdi_t.xcdild, #账套
       xcdi001 LIKE xcdi_t.xcdi001, #账套本位币顺序
       xcdi002 LIKE xcdi_t.xcdi002, #成本域
       xcdi003 LIKE xcdi_t.xcdi003, #成本计算类型
       xcdi004 LIKE xcdi_t.xcdi004, #年度
       xcdi005 LIKE xcdi_t.xcdi005, #期别
       xcdi006 LIKE xcdi_t.xcdi006, #拆件工单编号
       xcdi007 LIKE xcdi_t.xcdi007, #元件料号
       xcdi008 LIKE xcdi_t.xcdi008, #特性
       xcdi009 LIKE xcdi_t.xcdi009, #批次
       xcdi010 LIKE xcdi_t.xcdi010, #成本次要素
       xcdi020 LIKE xcdi_t.xcdi020, #核算币种
       xcdi101 LIKE xcdi_t.xcdi101, #上期结存数量
       xcdi102 LIKE xcdi_t.xcdi102, #上期结存金额
       xcdi201 LIKE xcdi_t.xcdi201, #本期投入数量
       xcdi202 LIKE xcdi_t.xcdi202, #本期本阶投入金额
       xcdi301 LIKE xcdi_t.xcdi301, #本期转出数量
       xcdi302 LIKE xcdi_t.xcdi302, #本期转出金额
       xcdi303 LIKE xcdi_t.xcdi303, #差异转出数量
       xcdi304 LIKE xcdi_t.xcdi304, #差异转出金额
       xcdi901 LIKE xcdi_t.xcdi901, #期末结存数量
       xcdi902 LIKE xcdi_t.xcdi902 #期末结存金额
END RECORD
#161124-00048#17 2016/12/16 By 08734 add(E)
 
 
 
   #add-point:delete段define

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq740_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq740_detail AS ",
                "SELECT * FROM xcde_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axcq740_detail SELECT * FROM xcde_t 
                                         WHERE xcdeent = g_enterprise AND xcdeld = g_xccdld_t
                                         AND xcde001 = g_xccd001_t
                                         AND xcde002 = g_xccd002_t
                                         AND xcde003 = g_xccd003_t
                                         AND xcde004 = g_xccd004_t
                                         AND xcde005 = g_xccd005_t
                                         AND xcde006 = g_xccd006_t
 
   
   #將key修正為調整後   
#   UPDATE axcq740_detail 
#      #更新key欄位
#      SET xcdeld = g_xccd_m.xccdld
#          , xcde001 = g_xccd_m.xccd001
#          , xcde002 = g_xccd_m.xccd002
#          , xcde003 = g_xccd_m.xccd003
#          , xcde004 = g_xccd_m.xccd004
#          , xcde005 = g_xccd_m.xccd005
#          , xcde006 = g_xccd_m.xccd006
 
      #更新共用欄位
      
 
   #add-point:單身修改前

   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xcde_t SELECT * FROM axcq740_detail
   
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
   DROP TABLE axcq740_detail
   
   #add-point:單身複製後1

   #end add-point
 
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE axcq740_detail AS ",
      "SELECT * FROM xcdi_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axcq740_detail SELECT * FROM xcdi_t
                                         WHERE xcdient = g_enterprise AND xcdild = g_xccdld_t
                                         AND xcdi001 = g_xccd001_t
                                         AND xcdi002 = g_xccd002_t
                                         AND xcdi003 = g_xccd003_t
                                         AND xcdi004 = g_xccd004_t
                                         AND xcdi005 = g_xccd005_t
                                         AND xcdi006 = g_xccd006_t
 
 
   #將key修正為調整後   
#   UPDATE axcq740_detail SET xcdild = g_xccd_m.xccdld
#                                       , xcdi001 = g_xccd_m.xccd001
#                                       , xcdi002 = g_xccd_m.xccd002
#                                       , xcdi003 = g_xccd_m.xccd003
#                                       , xcdi004 = g_xccd_m.xccd004
#                                       , xcdi005 = g_xccd_m.xccd005
#                                       , xcdi006 = g_xccd_m.xccd006
# 
#  
   #將資料塞回原table   
   INSERT INTO xcdi_t SELECT * FROM axcq740_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axcq740_detail
   
   #add-point:單身複製後

   #end add-point
 
 
   
 
   
   #多語言複製段落
      #此段落由子樣板a38產生
   #單身多語言複製
   DROP TABLE axcq740_detail_lang
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq740_detail_lang AS ",
                "SELECT * FROM xccd_t "
   PREPARE repro_xccd_t FROM ls_sql
   EXECUTE repro_xccd_t
   FREE repro_xccd_t
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axcq740_detail_lang SELECT * FROM xccd_t 
                                             WHERE xccdent = g_enterprise AND xccdld = g_xccdld_t
                                             AND xccd001 = g_xccd001_t                                             AND xccd002 = g_xccd002_t                                             AND xccd003 = g_xccd003_t                                             AND xccd004 = g_xccd004_t                                             AND xccd005 = g_xccd005_t                                             AND xccd006 = g_xccd006_t
   
   #將key修正為調整後   
#   UPDATE axcq740_detail_lang 
#      #更新key欄位
#      SET xccdld = g_xccd_m.xccdld
#          , xccd001 = g_xccd_m.xccd001          , xccd002 = g_xccd_m.xccd002          , xccd003 = g_xccd_m.xccd003          , xccd004 = g_xccd_m.xccd004          , xccd005 = g_xccd_m.xccd005          , xccd006 = g_xccd_m.xccd006
#  
   #將資料塞回原table   
   INSERT INTO xccd_t SELECT * FROM axcq740_detail_lang
   
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
   DROP TABLE axcq740_detail_lang
   
   #add-point:單身複製後1

   #end add-point
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
#   LET g_xccdld_t = g_xccd_m.xccdld
#   LET g_xccd001_t = g_xccd_m.xccd001
#   LET g_xccd002_t = g_xccd_m.xccd002
#   LET g_xccd003_t = g_xccd_m.xccd003
#   LET g_xccd004_t = g_xccd_m.xccd004
#   LET g_xccd005_t = g_xccd_m.xccd005
#   LET g_xccd006_t = g_xccd_m.xccd006
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq740_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   
#   IF g_xccd_m.xccdld IS NULL
#   OR g_xccd_m.xccd001 IS NULL
#   OR g_xccd_m.xccd002 IS NULL
#   OR g_xccd_m.xccd003 IS NULL
#   OR g_xccd_m.xccd004 IS NULL
#   OR g_xccd_m.xccd005 IS NULL
#   OR g_xccd_m.xccd006 IS NULL
# 
#   THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = "std-00003" 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#      RETURN
#   END IF
   
   
 
   CALL axcq740_show()
   
   CALL s_transaction_begin()
 
#   OPEN axcq740_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd002,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd006
#   IF STATUS THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "OPEN axcq740_cl:" 
#      LET g_errparam.code   = STATUS 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      CLOSE axcq740_cl
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
 
   #顯示最新的資料
   EXECUTE axcq740_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003, 
       g_xccd_m.xccd004,g_xccd_m.xccd005 INTO g_xccd_m.xccdcomp,g_xccd_m.xccd004,g_xccd_m.xccd001, 
       g_xccd_m.xccdld,g_xccd_m.xccd005,g_xccd_m.xccd003
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xccd_m.xccdld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段before ask

   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前

      #end add-point   
      
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL axcq740_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_xccdld_t = g_xccd_m.xccdld
      LET g_xccd001_t = g_xccd_m.xccd001
      
      LET g_xccd003_t = g_xccd_m.xccd003
      LET g_xccd004_t = g_xccd_m.xccd004
      LET g_xccd005_t = g_xccd_m.xccd005
      
 
 
#      DELETE FROM xccd_t
#       WHERE xccdent = g_enterprise AND xccdld = g_xccd_m.xccdld
#         AND xccd001 = g_xccd_m.xccd001
#         AND xccd002 = g_xccd_m.xccd002
#         AND xccd003 = g_xccd_m.xccd003
#         AND xccd004 = g_xccd_m.xccd004
#         AND xccd005 = g_xccd_m.xccd005
#         AND xccd006 = g_xccd_m.xccd006
# 
       
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
      
#      DELETE FROM xcde_t
#       WHERE xcdeent = g_enterprise AND xcdeld = g_xccd_m.xccdld
#         AND xcde001 = g_xccd_m.xccd001
#         AND xcde002 = g_xccd_m.xccd002
#         AND xcde003 = g_xccd_m.xccd003
#         AND xcde004 = g_xccd_m.xccd004
#         AND xcde005 = g_xccd_m.xccd005
#         AND xcde006 = g_xccd_m.xccd006
 
 
      #add-point:單身刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcde_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後

      #end add-point
      
            
                                                               
      #add-point:單身刪除前

      #end add-point
#      DELETE FROM xcdi_t
#       WHERE xcdient = g_enterprise AND
#             xcdild = g_xccd_m.xccdld AND xcdi001 = g_xccd_m.xccd001 AND xcdi002 = g_xccd_m.xccd002 AND xcdi003 = g_xccd_m.xccd003 AND xcdi004 = g_xccd_m.xccd004 AND xcdi005 = g_xccd_m.xccd005 AND xcdi006 = g_xccd_m.xccd006
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcde_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後

      #end add-point
 
 
 
 
                                                               
      CLEAR FORM
      CALL g_xcde_d.clear() 
      CALL g_xcde2_d.clear()       
      CALL g_xcde3_d.clear()       
 
     
      CALL axcq740_ui_browser_refresh()  
      #CALL axcq740_ui_headershow()  
      #CALL axcq740_ui_detailshow()
      
      IF g_browser_cnt > 0 THEN 
         #CALL axcq740_browser_fill("")
         CALL axcq740_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
 
      #add-point:多語言刪除

      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      #該單身多語言並無串接到單頭的key值, 若要刪除所有單身請於add-point中自行撰寫!
      
 
 
 
   
      #add-point:多語言刪除

      #end add-point
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE axcq740_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_xccd_m.xccdld,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq740.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq740_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   DEFINE l_xcde102_sum1  LIKE xcde_t.xcde102
   DEFINE l_xcde202_sum1  LIKE xcde_t.xcde202
   DEFINE l_xcde302_sum1  LIKE xcde_t.xcde302
   DEFINE l_xcde304_sum1  LIKE xcde_t.xcde304
   DEFINE l_xcde308_sum1  LIKE xcde_t.xcde308
   DEFINE l_xcde902_sum1  LIKE xcde_t.xcde902
   DEFINE l_xcde102_sum2  LIKE xcde_t.xcde102
   DEFINE l_xcde202_sum2  LIKE xcde_t.xcde202
   DEFINE l_xcde302_sum2  LIKE xcde_t.xcde302
   DEFINE l_xcde304_sum2  LIKE xcde_t.xcde304
   DEFINE l_xcde308_sum2  LIKE xcde_t.xcde308
   DEFINE l_xcde902_sum2  LIKE xcde_t.xcde902
   DEFINE l_xcde102_total LIKE xcde_t.xcde102
   DEFINE l_xcde202_total LIKE xcde_t.xcde202
   DEFINE l_xcde302_total LIKE xcde_t.xcde302
   DEFINE l_xcde304_total LIKE xcde_t.xcde304
   DEFINE l_xcde308_total LIKE xcde_t.xcde308
   DEFINE l_xcde902_total LIKE xcde_t.xcde902  
   DEFINE l_stre          STRING
   DEFINE l_stri          STRING
   #end add-point     
 
   CALL g_xcde_d.clear()    #g_xcde_d 單頭及單身 
   CALL g_xcde2_d.clear()
   CALL g_xcde3_d.clear()
 
 
   #add-point:b_fill段sql_before
   CALL axcq740_b_fill_1()  #160520-00003#14 
   RETURN                   #160520-00003#14 
   
   
   LET l_stre = ' '
   LET l_stri = ' '
   IF NOT cl_null(g_wc2_table1) THEN      
      LET g_wc2_table1=cl_replace_str(g_wc2_table1,"xccd002","xcde002")
      LET g_wc2_table1=cl_replace_str(g_wc2_table1,"xccd006","xcde006")
      LET l_stre = l_stre CLIPPED," AND ",g_wc2_table1 CLIPPED 
      LET g_wc2_table4 = g_wc2_table1
      LET g_wc2_table4=cl_replace_str(g_wc2_table4,"xcde","xcdi")
      LET l_stri = l_stri CLIPPED," AND ",g_wc2_table4 CLIPPED
   END IF
   IF NOT cl_null(g_wc2_table2) THEN      
      LET g_wc2_table2=cl_replace_str(g_wc2_table2,"xccd002","xcdi002")
      LET g_wc2_table2=cl_replace_str(g_wc2_table2,"xccd006","xcdi006")
      LET l_stri = l_stri CLIPPED," AND ",g_wc2_table2 CLIPPED
      LET g_wc2_table5 = g_wc2_table2
      LET g_wc2_table5=cl_replace_str(g_wc2_table5,"xcdi","xcde")
      LET l_stre = l_stre CLIPPED," AND ",g_wc2_table5 CLIPPED 
   END IF
   IF NOT cl_null(g_wc2_table3) THEN      
      LET g_wc2_table3=cl_replace_str(g_wc2_table3,"xccd002","xcde002")
      LET g_wc2_table3=cl_replace_str(g_wc2_table3,"xccd006","xcde006")
      LET l_stre = l_stre CLIPPED," AND ",g_wc2_table3 CLIPPED  
      LET g_wc2_table6 = g_wc2_table3
      LET g_wc2_table6=cl_replace_str(g_wc2_table6,"xcde","xcdi")
      LET l_stri = l_stri CLIPPED," AND ",g_wc2_table6 CLIPPED
   END IF
   
   #end add-point
   
   #判斷是否填充
   #IF axcq740_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE xcdecomp,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102,
          (xcde201+xcde205+xcde207+xcde209),(xcde202+xcde206+xcde208+xcde210), 
          xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902,xcdecomp,xcde007,xcde008,xcde009, 
          xcde010,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901, 
          xcde902 ,t1.ooefl003 ,t3.imaal003 ,t4.imaal004 ,t5.xcaul003 FROM xcde_t",   
                  " INNER JOIN xccd_t ON xccdld = xcdeld ",
                  " AND xccd001 = xcde001 ",
                  " AND xccd002 = xcde002 ",
                  " AND xccd003 = xcde003 ",
                  " AND xccd004 = xcde004 ",
                  " AND xccd005 = xcde005 ",
                  " AND xccd006 = xcde006 ",
 
                  #" LEFT JOIN xccd_t ON xccdent = '"||g_enterprise||"' AND xccdld = xccdld AND xccd001 = xccd001 AND xccd002 = xccd002 AND xccd003 = xccd003 AND xccd004 = xccd004 AND xccd005 = xccd005 AND xccd006 = xccd006xcdi007 = xcdi008 = xcdi009 = xcdi010 =",
                  
                #" LEFT JOIN xccd_t ON xccdent = '"||g_enterprise||"' AND xccdld = xccdld AND xccd001 = xccd001 AND xccd002 = xccd002 AND xccd003 = xccd003 AND xccd004 = xccd004 AND xccd005 = xccd005 AND xccd006 = xccd006",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t7.sfaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcde007 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcde007 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t5 ON t5.xcaulent='"||g_enterprise||"' AND t5.xcaul001=xcde010 AND t5.xcaul002='"||g_dlang||"' ",
 
                  " WHERE xcdeent=? AND xcdeld=? AND xcde001=? AND xcde002=? AND xcde003=? AND xcde004=? AND xcde005=? AND xcde006=?"
                  
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #add-point:b_fill段sql_before
      LET g_sql = "SELECT  UNIQUE t7.sfaasite,xcde002,xcde006,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102,
          (xcde201+xcde205+xcde207+xcde209),(xcde202+xcde206+xcde208+xcde210),
          xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902,
          t3.imaal003 ,t4.imaal004 ,t5.xcaul003 FROM xcde_t",   
                  " INNER JOIN xccd_t ON xccdld = xcdeld ",
                  " AND xccd001 = xcde001 ",
                  " AND xccd002 = xcde002 ",
                  " AND xccd003 = xcde003 ",
                  " AND xccd004 = xcde004 ",
                  " AND xccd005 = xcde005 ",
                  " AND xccd006 = xcde006 ",
 
                 
                  
               " LEFT JOIN sfaa_t t7 ON t7.sfaaent = xcdeent AND t7.sfaadocno = xcde006 ",
              #" LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t7.sfaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcde007 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcde007 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t5 ON t5.xcaulent='"||g_enterprise||"' AND t5.xcaul001=xcde010 AND t5.xcaul002='"||g_dlang||"' ",
              #" LEFT JOIN xcbfl_t t6 ON t6.xcbflent='"||g_enterprise||"' AND t6.xcbflcomp=t7.sfaasite AND t6.xcbfl001=xcde002 AND t6.xcbfl002='"||g_dlang||"' ",
                  " WHERE xcdeent=? AND xcdeld=? AND xcde001=? AND xcde003=? AND xcde004=? AND xcde005=? "
               ,l_stre
      LET g_sql = g_sql CLIPPED ," UNION ALL ",
                  "SELECT  UNIQUE t7.sfaasite,xcdi002,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, 
          xcdi301,xcdi302,xcdi303,xcdi304,0,0,xcdi901,xcdi902,t3.imaal003 ,t4.imaal004 ,t5.xcaul003 ",
          " FROM xcdi_t",   
                 #150115 by wuxj begin
                 #" INNER JOIN xccd_t ON xccdld = xcdild ",
                 #" AND xccd001 = xcdi001 ",
                 #" AND xccd002 = xcdi002 ",
                 #" AND xccd003 = xcdi003 ",
                 #" AND xccd004 = xcdi004 ",
                 #" AND xccd005 = xcdi005 ",
                 #" AND xccd006 = xcdi006 ",
                  " INNER JOIN xcch_t ON xcchld = xcdild ",
                  " AND xcch001 = xcdi001 ",
                  " AND xcch002 = xcdi002 ",
                  " AND xcch003 = xcdi003 ",
                  " AND xcch004 = xcdi004 ",
                  " AND xcch005 = xcdi005 ",
                  " AND xcch006 = xcdi006 ",
                 #150115 by wuxj end
                  " LEFT JOIN sfaa_t t7 ON t7.sfaaent = xcdient AND t7.sfaadocno = xcdi006 ",
#                  " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t7.sfaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcdi007 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcdi007 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t5 ON t5.xcaulent='"||g_enterprise||"' AND t5.xcaul001=xcdi010 AND t5.xcaul002='"||g_dlang||"' ",
#               " LEFT JOIN xcbfl_t t6 ON t6.xcbflent='"||g_enterprise||"' AND t6.xcbflcomp=t7.sfaasite AND t6.xcbfl001=xcdi002 AND t6.xcbfl002='"||g_dlang||"' ",
                  
                  
                  " WHERE xcdient=? AND xcdild=? AND xcdi001=? AND xcdi003=? AND xcdi004=? AND xcdi005=? " 
               ,l_stri                  
      #end add-point
      
      
      #子單身的WC
      
      
    #LET g_sql = g_sql, " ORDER BY xcde_t.xcde007,xcde_t.xcde008,xcde_t.xcde009,xcde_t.xcde010"
      
      #add-point:單身填充控制
      LET g_sql = g_sql, " ORDER BY 1,3,4,5,6,7,2"
      LET l_xcde102_sum1 = 0
      LET l_xcde202_sum1 = 0
      LET l_xcde302_sum1 = 0
      LET l_xcde304_sum1 = 0
      LET l_xcde308_sum1 = 0
      LET l_xcde902_sum1 = 0
      LET l_xcde102_sum2 = 0
      LET l_xcde202_sum2 = 0
      LET l_xcde302_sum2 = 0
      LET l_xcde304_sum2 = 0
      LET l_xcde308_sum2 = 0
      LET l_xcde902_sum2 = 0
      LET l_xcde102_total= 0
      LET l_xcde202_total= 0
      LET l_xcde302_total= 0
      LET l_xcde304_total= 0
      LET l_xcde308_total= 0
      LET l_xcde902_total= 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq740_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR axcq740_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,
                           g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005                    
      FOREACH b_fill_cs INTO g_xcde_d[l_ac].sfaasite,g_xcde_d[l_ac].xccd002,g_xcde_d[l_ac].xccd006,g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009, 
          g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201, 
          g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303, 
          g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde307,g_xcde_d[l_ac].xcde308,g_xcde_d[l_ac].xcde901, 
          g_xcde_d[l_ac].xcde902,g_xcde_d[l_ac].xcde007_desc, 
          g_xcde_d[l_ac].xcde007_desc_desc,g_xcde_d[l_ac].xcde010_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #组织
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcde_d[l_ac].sfaasite
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcde_d[l_ac].sfaasite_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xcde_d[l_ac].sfaasite_desc   
         #成本域
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xcde_d[l_ac].sfaasite                                                                                                                                                
         LET g_ref_fields[2] = g_xcde_d[l_ac].xccd002                                                                                                                                           
         CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcde_d[l_ac].xccd002_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xcde_d[l_ac].xccd002_desc 
         #成本单位
         SELECT xcbb005 INTO g_xcde_d[l_ac].xcbb005 FROM xcbb_t
          WHERE xcbbent  = g_enterprise
            AND xcbbcomp = g_xcde_d[l_ac].sfaasite
            AND xcbb001  = g_xccd_m.xccd004
            AND xcbb002  = g_xccd_m.xccd005
            AND xcbb003  = g_xcde_d[l_ac].xcde007
         
         #共计         
         LET l_xcde102_total= l_xcde102_total + g_xcde_d[l_ac].xcde102
         LET l_xcde202_total= l_xcde202_total + g_xcde_d[l_ac].xcde202
         LET l_xcde302_total= l_xcde302_total + g_xcde_d[l_ac].xcde302
         LET l_xcde304_total= l_xcde304_total + g_xcde_d[l_ac].xcde304
         LET l_xcde308_total= l_xcde308_total + g_xcde_d[l_ac].xcde308
         LET l_xcde902_total= l_xcde902_total + g_xcde_d[l_ac].xcde902
         #小计 单号
         LET l_xcde102_sum1= l_xcde102_sum1 + g_xcde_d[l_ac].xcde102
         LET l_xcde202_sum1= l_xcde202_sum1 + g_xcde_d[l_ac].xcde202
         LET l_xcde302_sum1= l_xcde302_sum1 + g_xcde_d[l_ac].xcde302
         LET l_xcde304_sum1= l_xcde304_sum1 + g_xcde_d[l_ac].xcde304
         LET l_xcde308_sum1= l_xcde308_sum1 + g_xcde_d[l_ac].xcde308
         LET l_xcde902_sum1= l_xcde902_sum1 + g_xcde_d[l_ac].xcde902
         IF l_ac > 1 THEN 
            IF g_xcde_d[l_ac].xccd006 != g_xcde_d[l_ac-1].xccd006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xcde_d[l_ac + 1].* = g_xcde_d[l_ac].*  
               INITIALIZE  g_xcde_d[l_ac].* TO NULL
               LET g_xcde_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
               LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum1  - g_xcde_d[l_ac+1].xcde102
               LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum1  - g_xcde_d[l_ac+1].xcde202 
               LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum1  - g_xcde_d[l_ac+1].xcde302 
               LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum1  - g_xcde_d[l_ac+1].xcde304 
               LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum1  - g_xcde_d[l_ac+1].xcde308 
               LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum1  - g_xcde_d[l_ac+1].xcde902 
               LET l_ac = l_ac + 1
               LET l_xcde102_sum1  = g_xcde_d[l_ac].xcde102
               LET l_xcde202_sum1  = g_xcde_d[l_ac].xcde202 
               LET l_xcde302_sum1  = g_xcde_d[l_ac].xcde302 
               LET l_xcde304_sum1  = g_xcde_d[l_ac].xcde304 
               LET l_xcde308_sum1  = g_xcde_d[l_ac].xcde308 
               LET l_xcde902_sum1  = g_xcde_d[l_ac].xcde902 
            ELSE
               IF g_xcde_d[l_ac].sfaasite != g_xcde_d[l_ac-1].sfaasite THEN
                  LET g_xcde_d[l_ac + 1].* = g_xcde_d[l_ac].*  
                  INITIALIZE  g_xcde_d[l_ac].* TO NULL
                  LET g_xcde_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
                  LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum1  - g_xcde_d[l_ac+1].xcde102
                  LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum1  - g_xcde_d[l_ac+1].xcde202 
                  LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum1  - g_xcde_d[l_ac+1].xcde302 
                  LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum1  - g_xcde_d[l_ac+1].xcde304 
                  LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum1  - g_xcde_d[l_ac+1].xcde308 
                  LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum1  - g_xcde_d[l_ac+1].xcde902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum1  = g_xcde_d[l_ac].xcde102
                  LET l_xcde202_sum1  = g_xcde_d[l_ac].xcde202 
                  LET l_xcde302_sum1  = g_xcde_d[l_ac].xcde302 
                  LET l_xcde304_sum1  = g_xcde_d[l_ac].xcde304 
                  LET l_xcde308_sum1  = g_xcde_d[l_ac].xcde308 
                  LET l_xcde902_sum1  = g_xcde_d[l_ac].xcde902 
               END IF
            END IF               
         END IF     
         #合计 组织
         LET l_xcde102_sum2= l_xcde102_sum2 + g_xcde_d[l_ac].xcde102
         LET l_xcde202_sum2= l_xcde202_sum2 + g_xcde_d[l_ac].xcde202
         LET l_xcde302_sum2= l_xcde302_sum2 + g_xcde_d[l_ac].xcde302
         LET l_xcde304_sum2= l_xcde304_sum2 + g_xcde_d[l_ac].xcde304
         LET l_xcde308_sum2= l_xcde308_sum2 + g_xcde_d[l_ac].xcde308
         LET l_xcde902_sum2= l_xcde902_sum2 + g_xcde_d[l_ac].xcde902
         IF l_ac > 2 THEN
            IF g_xcde_d[l_ac-2].sfaasite != cl_getmsg("axc-00578",g_lang) THEN
               IF g_xcde_d[l_ac].sfaasite != g_xcde_d[l_ac-2].sfaasite THEN
                  #把当前行下移，并在当前行显示小计
                  LET g_xcde_d[l_ac + 1].* = g_xcde_d[l_ac].*  
                  INITIALIZE  g_xcde_d[l_ac].* TO NULL
                  LET g_xcde_d[l_ac].sfaasite = cl_getmsg("axc-00578",g_lang)            
                  LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum2  - g_xcde_d[l_ac+1].xcde102
                  LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum2  - g_xcde_d[l_ac+1].xcde202 
                  LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum2  - g_xcde_d[l_ac+1].xcde302 
                  LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum2  - g_xcde_d[l_ac+1].xcde304 
                  LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum2  - g_xcde_d[l_ac+1].xcde308 
                  LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum2  - g_xcde_d[l_ac+1].xcde902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum2  = g_xcde_d[l_ac].xcde102 
                  LET l_xcde202_sum2  = g_xcde_d[l_ac].xcde202 
                  LET l_xcde302_sum2  = g_xcde_d[l_ac].xcde302 
                  LET l_xcde304_sum2  = g_xcde_d[l_ac].xcde304 
                  LET l_xcde308_sum2  = g_xcde_d[l_ac].xcde308 
                  LET l_xcde902_sum2  = g_xcde_d[l_ac].xcde902
               END IF 
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
     #LET g_error_show = 0
      #最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN 
         LET g_xcde_d[l_ac].xccd006   = cl_getmsg("axc-00577",g_lang)
         LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum1 
         LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum1   
         LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum1   
         LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum1   
         LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum1   
         LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum1  
         LET l_ac = l_ac+1  
#按组织小计 
         LET g_xcde_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)
         LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum2 
         LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum2   
         LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum2   
         LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum2   
         LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum2   
         LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum2  
         LET l_ac = l_ac + 1
#合计 
         LET g_xcde_d[l_ac].sfaasite  = cl_getmsg("lib-00133",g_lang)
         LET g_xcde_d[l_ac].xcde102  = l_xcde102_total  
         LET g_xcde_d[l_ac].xcde202  = l_xcde202_total
         LET g_xcde_d[l_ac].xcde302  = l_xcde302_total   
         LET g_xcde_d[l_ac].xcde304  = l_xcde304_total   
         LET g_xcde_d[l_ac].xcde308  = l_xcde308_total   
         LET g_xcde_d[l_ac].xcde902  = l_xcde902_total 
                  
      END IF                
   #END IF
   
   #判斷是否填充
   #IF axcq740_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE t7.sfaasite,xcdi002,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, 
          xcdi301,xcdi302,xcdi303,xcdi304,xcdi901,xcdi902,t3.imaal003 ,t4.imaal004 ,t5.xcaul003 ",
          " FROM xcdi_t",   
                  " INNER JOIN xccd_t ON xccdld = xcdild ",
                  " AND xccd001 = xcdi001 ",
                  " AND xccd002 = xcdi002 ",
                  " AND xccd003 = xcdi003 ",
                  " AND xccd004 = xcdi004 ",
                  " AND xccd005 = xcdi005 ",
                  " AND xccd006 = xcdi006 ",
                  " LEFT JOIN sfaa_t t7 ON t7.sfaaent = xcdient AND t7.sfaadocno = xcdi006 ",
#                " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t7.sfaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcdi007 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcdi007 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t5 ON t5.xcaulent='"||g_enterprise||"' AND t5.xcaul001=xcdi010 AND t5.xcaul002='"||g_dlang||"' ",
#               " LEFT JOIN xcbfl_t t6 ON t6.xcbflent='"||g_enterprise||"' AND t6.xcbflcomp=t7.sfaasite AND t6.xcbfl001=xcdi002 AND t6.xcbfl002='"||g_dlang||"' ",
                  
                  
                  " WHERE xcdient=? AND xcdild=? AND xcdi001=? AND xcdi003=? AND xcdi004=? AND xcdi005=? "   
                 ,l_stri
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #add-point:b_fill段sql_before
      #150115 by wuxj add
      LET g_sql = "SELECT  UNIQUE t7.sfaasite,xcdi002,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, 
          xcdi301,xcdi302,xcdi303,xcdi304,xcdi901,xcdi902,t3.imaal003 ,t4.imaal004 ,t5.xcaul003 ",
          " FROM xcdi_t",   
                  " INNER JOIN xcch_t ON xcchld = xcdild ",
                  " AND xcch001 = xcdi001 ",
                  " AND xcch002 = xcdi002 ",
                  " AND xcch003 = xcdi003 ",
                  " AND xcch004 = xcdi004 ",
                  " AND xcch005 = xcdi005 ",
                  " AND xcch006 = xcdi006 ",
                  " LEFT JOIN sfaa_t t7 ON t7.sfaaent = xcdient AND t7.sfaadocno = xcdi006 ",
#                " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t7.sfaasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcdi007 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcdi007 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t5 ON t5.xcaulent='"||g_enterprise||"' AND t5.xcaul001=xcdi010 AND t5.xcaul002='"||g_dlang||"' ",
#               " LEFT JOIN xcbfl_t t6 ON t6.xcbflent='"||g_enterprise||"' AND t6.xcbflcomp=t7.sfaasite AND t6.xcbfl001=xcdi002 AND t6.xcbfl002='"||g_dlang||"' ",
                  
                  
                  " WHERE xcdient=? AND xcdild=? AND xcdi001=? AND xcdi003=? AND xcdi004=? AND xcdi005=? "   
                 ,l_stri
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #150115 by wuxj end
      #end add-point
     
      
      #子單身的WC
      
      
     #LET g_sql = g_sql, " ORDER BY xcdi_t.xcdi007,xcdi_t.xcdi008,xcdi_t.xcdi009,xcdi_t.xcdi010"
      
      #add-point:單身填充控制
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
      LET g_sql = g_sql, " ORDER BY 1,3,4,5,6,7,2"
      LET l_xcde102_sum1 = 0
      LET l_xcde202_sum1 = 0
      LET l_xcde302_sum1 = 0
      LET l_xcde304_sum1 = 0
      LET l_xcde308_sum1 = 0
      LET l_xcde902_sum1 = 0
      LET l_xcde102_sum2 = 0
      LET l_xcde202_sum2 = 0
      LET l_xcde302_sum2 = 0
      LET l_xcde304_sum2 = 0
      LET l_xcde308_sum2 = 0
      LET l_xcde902_sum2 = 0
      LET l_xcde102_total= 0
      LET l_xcde202_total= 0
      LET l_xcde302_total= 0
      LET l_xcde304_total= 0
      LET l_xcde308_total= 0
      LET l_xcde902_total= 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq740_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR axcq740_pb2
      
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
                                               
      FOREACH b_fill_cs2 INTO g_xcde3_d[l_ac].sfaasite,g_xcde3_d[l_ac].xccd002,g_xcde3_d[l_ac].xccd006,g_xcde3_d[l_ac].xcdi007,g_xcde3_d[l_ac].xcdi008, 
          g_xcde3_d[l_ac].xcdi009,g_xcde3_d[l_ac].xcdi010,g_xcde3_d[l_ac].xcdi101,g_xcde3_d[l_ac].xcdi102, 
          g_xcde3_d[l_ac].xcdi201,g_xcde3_d[l_ac].xcdi202,g_xcde3_d[l_ac].xcdi301,g_xcde3_d[l_ac].xcdi302, 
          g_xcde3_d[l_ac].xcdi303,g_xcde3_d[l_ac].xcdi304,g_xcde3_d[l_ac].xcdi901,g_xcde3_d[l_ac].xcdi902,           
          g_xcde3_d[l_ac].xcdi007_desc, 
          g_xcde3_d[l_ac].xcdi007_desc_desc,g_xcde3_d[l_ac].xcdi010_desc
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #成本单位
         SELECT xcbb005 INTO g_xcde3_d[l_ac].xcbb005 FROM xcbb_t
          WHERE xcbbent  = g_enterprise
            AND xcbbcomp = g_xcde3_d[l_ac].sfaasite
            AND xcbb001  = g_xccd_m.xccd004
            AND xcbb002  = g_xccd_m.xccd005
            AND xcbb003  = g_xcde3_d[l_ac].xcdi007
         #组织
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcde3_d[l_ac].sfaasite
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcde3_d[l_ac].sfaasite_3_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xcde3_d[l_ac].sfaasite_3_desc   
         #成本域
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xcde3_d[l_ac].sfaasite                                                                                                                                                
         LET g_ref_fields[2] = g_xcde3_d[l_ac].xccd002                                                                                                                                           
         CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcde3_d[l_ac].xccd002_3_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xcde3_d[l_ac].xccd002_3_desc 
         #共计         
         LET l_xcde102_total= l_xcde102_total + g_xcde3_d[l_ac].xcdi102
         LET l_xcde202_total= l_xcde202_total + g_xcde3_d[l_ac].xcdi202
         LET l_xcde302_total= l_xcde302_total + g_xcde3_d[l_ac].xcdi302
         LET l_xcde304_total= l_xcde304_total + g_xcde3_d[l_ac].xcdi304        
         LET l_xcde902_total= l_xcde902_total + g_xcde3_d[l_ac].xcdi902
         #小计 单号
         LET l_xcde102_sum1= l_xcde102_sum1 + g_xcde3_d[l_ac].xcdi102
         LET l_xcde202_sum1= l_xcde202_sum1 + g_xcde3_d[l_ac].xcdi202
         LET l_xcde302_sum1= l_xcde302_sum1 + g_xcde3_d[l_ac].xcdi302
         LET l_xcde304_sum1= l_xcde304_sum1 + g_xcde3_d[l_ac].xcdi304        
         LET l_xcde902_sum1= l_xcde902_sum1 + g_xcde3_d[l_ac].xcdi902
         IF l_ac > 1 THEN 
            IF g_xcde3_d[l_ac].xccd006 != g_xcde3_d[l_ac-1].xccd006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xcde3_d[l_ac + 1].* = g_xcde3_d[l_ac].*  
               INITIALIZE  g_xcde3_d[l_ac].* TO NULL
               LET g_xcde3_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
               LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum1  - g_xcde3_d[l_ac+1].xcdi102
               LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum1  - g_xcde3_d[l_ac+1].xcdi202 
               LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum1  - g_xcde3_d[l_ac+1].xcdi302 
               LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum1  - g_xcde3_d[l_ac+1].xcdi304
               LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum1  - g_xcde3_d[l_ac+1].xcdi902 
               LET l_ac = l_ac + 1
               LET l_xcde102_sum1  = g_xcde3_d[l_ac].xcdi102
               LET l_xcde202_sum1  = g_xcde3_d[l_ac].xcdi202 
               LET l_xcde302_sum1  = g_xcde3_d[l_ac].xcdi302 
               LET l_xcde304_sum1  = g_xcde3_d[l_ac].xcdi304
               LET l_xcde902_sum1  = g_xcde3_d[l_ac].xcdi902
            ELSE
               IF g_xcde3_d[l_ac].sfaasite != g_xcde3_d[l_ac-1].sfaasite THEN
                  LET g_xcde3_d[l_ac + 1].* = g_xcde3_d[l_ac].*  
                  INITIALIZE  g_xcde3_d[l_ac].* TO NULL
                  LET g_xcde3_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
                  LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum1  - g_xcde3_d[l_ac+1].xcdi102
                  LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum1  - g_xcde3_d[l_ac+1].xcdi202 
                  LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum1  - g_xcde3_d[l_ac+1].xcdi302 
                  LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum1  - g_xcde3_d[l_ac+1].xcdi304
                  LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum1  - g_xcde3_d[l_ac+1].xcdi902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum1  = g_xcde3_d[l_ac].xcdi102
                  LET l_xcde202_sum1  = g_xcde3_d[l_ac].xcdi202 
                  LET l_xcde302_sum1  = g_xcde3_d[l_ac].xcdi302 
                  LET l_xcde304_sum1  = g_xcde3_d[l_ac].xcdi304
                  LET l_xcde902_sum1  = g_xcde3_d[l_ac].xcdi902
               END IF               
            END IF               
         END IF     
         #合计 组织
         LET l_xcde102_sum2= l_xcde102_sum2 + g_xcde3_d[l_ac].xcdi102
         LET l_xcde202_sum2= l_xcde202_sum2 + g_xcde3_d[l_ac].xcdi202
         LET l_xcde302_sum2= l_xcde302_sum2 + g_xcde3_d[l_ac].xcdi302
         LET l_xcde304_sum2= l_xcde304_sum2 + g_xcde3_d[l_ac].xcdi304
         LET l_xcde902_sum2= l_xcde902_sum2 + g_xcde3_d[l_ac].xcdi902
         IF l_ac > 2 THEN
            IF g_xcde3_d[l_ac-2].sfaasite != cl_getmsg("axc-00578",g_lang) THEN
               IF g_xcde3_d[l_ac].sfaasite != g_xcde3_d[l_ac-2].sfaasite THEN
                  #把当前行下移，并在当前行显示小计
                  LET g_xcde3_d[l_ac + 1].* = g_xcde3_d[l_ac].*  
                  INITIALIZE  g_xcde3_d[l_ac].* TO NULL
                  LET g_xcde3_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)            
                  LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum2  - g_xcde3_d[l_ac+1].xcdi102
                  LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum2  - g_xcde3_d[l_ac+1].xcdi202 
                  LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum2  - g_xcde3_d[l_ac+1].xcdi302 
                  LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum2  - g_xcde3_d[l_ac+1].xcdi304
                  LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum2  - g_xcde3_d[l_ac+1].xcdi902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum2  = g_xcde3_d[l_ac].xcdi102 
                  LET l_xcde202_sum2  = g_xcde3_d[l_ac].xcdi202 
                  LET l_xcde302_sum2  = g_xcde3_d[l_ac].xcdi302 
                  LET l_xcde304_sum2  = g_xcde3_d[l_ac].xcdi304
                  LET l_xcde902_sum2  = g_xcde3_d[l_ac].xcdi902
               END IF 
            END IF            
         END IF  
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
      #最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN 
         LET g_xcde3_d[l_ac].xccd006   = cl_getmsg("axc-00577",g_lang)
         LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum1 
         LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum1   
         LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum1   
         LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum1  
         LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum1  
         LET l_ac = l_ac+1  
#按组织小计 
         LET g_xcde3_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)
         LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum2 
         LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum2   
         LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum2   
         LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum2  
         LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum2  
         LET l_ac = l_ac + 1
#合计 
         LET g_xcde3_d[l_ac].sfaasite  = cl_getmsg("lib-00133",g_lang)
         LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_total  
         LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_total
         LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_total   
         LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_total  
         LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_total
                  
      END IF                
   #END IF
   
 
   
   #add-point:browser_fill段其他table處理
    
   
     
      LET g_sql = "SELECT  UNIQUE t7.sfaasite,xcde002,xcde006,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102,
          (xcde201+xcde205+xcde207+xcde209),(xcde202+xcde206+xcde208+xcde210),
          xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902,
          t3.imaal003 ,t4.imaal004 ,t5.xcaul003 FROM xcde_t",   
                  " INNER JOIN xccd_t ON xccdld = xcdeld ",
                  " AND xccd001 = xcde001 ",
                  " AND xccd002 = xcde002 ",
                  " AND xccd003 = xcde003 ",
                  " AND xccd004 = xcde004 ",
                  " AND xccd005 = xcde005 ",
                  " AND xccd006 = xcde006 ",
 
#                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t7.sfaasite AND t1.ooefl002='"||g_dlang||"' ",
                  " LEFT JOIN sfaa_t t7 ON t7.sfaaent = xcdeent AND t7.sfaadocno = xcde006 ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcde007 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcde007 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN xcaul_t t5 ON t5.xcaulent='"||g_enterprise||"' AND t5.xcaul001=xcde010 AND t5.xcaul002='"||g_dlang||"' ",
#               " LEFT JOIN xcbfl_t t6 ON t6.xcbflent='"||g_enterprise||"' AND t6.xcbflcomp=t7.sfaasite AND t6.xcbfl001=xcde002 AND t6.xcbfl002='"||g_dlang||"' ",
                  " WHERE xcdeent=? AND xcdeld=? AND xcde001=? AND xcde003=? AND xcde004=? AND xcde005=? "
                  ,l_stre
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #end add-point
      
      
      #子單身的WC
      
      
      
      #add-point:單身填充控制
      LET g_sql = g_sql, " ORDER BY 1,3,4,5,6,7,2"
      LET l_xcde102_sum1 = 0
      LET l_xcde202_sum1 = 0
      LET l_xcde302_sum1 = 0
      LET l_xcde304_sum1 = 0
      LET l_xcde308_sum1 = 0
      LET l_xcde902_sum1 = 0
      LET l_xcde102_sum2 = 0
      LET l_xcde202_sum2 = 0
      LET l_xcde302_sum2 = 0
      LET l_xcde304_sum2 = 0
      LET l_xcde308_sum2 = 0
      LET l_xcde902_sum2 = 0
      LET l_xcde102_total= 0
      LET l_xcde202_total= 0
      LET l_xcde302_total= 0
      LET l_xcde304_total= 0
      LET l_xcde308_total= 0
      LET l_xcde902_total= 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq740_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axcq740_pb3
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
                                               
      FOREACH b_fill_cs3 INTO g_xcde2_d[l_ac].sfaasite,g_xcde2_d[l_ac].xccd002,g_xcde2_d[l_ac].xccd006,g_xcde2_d[l_ac].xcde007,g_xcde2_d[l_ac].xcde008,g_xcde2_d[l_ac].xcde009, 
          g_xcde2_d[l_ac].xcde010,g_xcde2_d[l_ac].xcde101,g_xcde2_d[l_ac].xcde102,g_xcde2_d[l_ac].xcde201, 
          g_xcde2_d[l_ac].xcde202,g_xcde2_d[l_ac].xcde301,g_xcde2_d[l_ac].xcde302,g_xcde2_d[l_ac].xcde303, 
          g_xcde2_d[l_ac].xcde304,g_xcde2_d[l_ac].xcde307,g_xcde2_d[l_ac].xcde308,g_xcde2_d[l_ac].xcde901, 
          g_xcde2_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde007_2_desc, 
          g_xcde2_d[l_ac].xcde007_2_desc_desc,g_xcde2_d[l_ac].xcde010_2_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #成本单位
         SELECT xcbb005 INTO g_xcde2_d[l_ac].xcbb005 FROM xcbb_t
          WHERE xcbbent  = g_enterprise
            AND xcbbcomp = g_xcde2_d[l_ac].sfaasite
            AND xcbb001  = g_xccd_m.xccd004
            AND xcbb002  = g_xccd_m.xccd005
            AND xcbb003  = g_xcde2_d[l_ac].xcde007
         #组织
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcde2_d[l_ac].sfaasite
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcde2_d[l_ac].sfaasite_2_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xcde2_d[l_ac].sfaasite_2_desc   
         #成本域
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xcde2_d[l_ac].sfaasite                                                                                                                                                
         LET g_ref_fields[2] = g_xcde2_d[l_ac].xccd002                                                                                                                                           
         CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcde2_d[l_ac].xccd002_2_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xcde2_d[l_ac].xccd002_2_desc 
         #共计         
         LET l_xcde102_total= l_xcde102_total + g_xcde2_d[l_ac].xcde102
         LET l_xcde202_total= l_xcde202_total + g_xcde2_d[l_ac].xcde202
         LET l_xcde302_total= l_xcde302_total + g_xcde2_d[l_ac].xcde302
         LET l_xcde304_total= l_xcde304_total + g_xcde2_d[l_ac].xcde304
         LET l_xcde308_total= l_xcde308_total + g_xcde2_d[l_ac].xcde308
         LET l_xcde902_total= l_xcde902_total + g_xcde2_d[l_ac].xcde902
         #小计 单号
         LET l_xcde102_sum1= l_xcde102_sum1 + g_xcde2_d[l_ac].xcde102
         LET l_xcde202_sum1= l_xcde202_sum1 + g_xcde2_d[l_ac].xcde202
         LET l_xcde302_sum1= l_xcde302_sum1 + g_xcde2_d[l_ac].xcde302
         LET l_xcde304_sum1= l_xcde304_sum1 + g_xcde2_d[l_ac].xcde304
         LET l_xcde308_sum1= l_xcde308_sum1 + g_xcde2_d[l_ac].xcde308
         LET l_xcde902_sum1= l_xcde902_sum1 + g_xcde2_d[l_ac].xcde902
         IF l_ac > 1 THEN 
            IF g_xcde2_d[l_ac].xccd006 != g_xcde2_d[l_ac-1].xccd006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xcde2_d[l_ac + 1].* = g_xcde2_d[l_ac].*  
               INITIALIZE  g_xcde2_d[l_ac].* TO NULL
               LET g_xcde2_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
               LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum1  - g_xcde2_d[l_ac+1].xcde102
               LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum1  - g_xcde2_d[l_ac+1].xcde202 
               LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum1  - g_xcde2_d[l_ac+1].xcde302 
               LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum1  - g_xcde2_d[l_ac+1].xcde304 
               LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum1  - g_xcde2_d[l_ac+1].xcde308 
               LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum1  - g_xcde2_d[l_ac+1].xcde902 
               LET l_ac = l_ac + 1
               LET l_xcde102_sum1  = g_xcde2_d[l_ac].xcde102
               LET l_xcde202_sum1  = g_xcde2_d[l_ac].xcde202 
               LET l_xcde302_sum1  = g_xcde2_d[l_ac].xcde302 
               LET l_xcde304_sum1  = g_xcde2_d[l_ac].xcde304 
               LET l_xcde308_sum1  = g_xcde2_d[l_ac].xcde308 
               LET l_xcde902_sum1  = g_xcde2_d[l_ac].xcde902 
            ELSE
               IF g_xcde2_d[l_ac].sfaasite != g_xcde2_d[l_ac-1].sfaasite THEN
                  #把当前行下移，并在当前行显示小计
                  LET g_xcde2_d[l_ac + 1].* = g_xcde2_d[l_ac].*  
                  INITIALIZE  g_xcde2_d[l_ac].* TO NULL
                  LET g_xcde2_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
                  LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum1  - g_xcde2_d[l_ac+1].xcde102
                  LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum1  - g_xcde2_d[l_ac+1].xcde202 
                  LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum1  - g_xcde2_d[l_ac+1].xcde302 
                  LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum1  - g_xcde2_d[l_ac+1].xcde304 
                  LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum1  - g_xcde2_d[l_ac+1].xcde308 
                  LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum1  - g_xcde2_d[l_ac+1].xcde902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum1  = g_xcde2_d[l_ac].xcde102
                  LET l_xcde202_sum1  = g_xcde2_d[l_ac].xcde202 
                  LET l_xcde302_sum1  = g_xcde2_d[l_ac].xcde302 
                  LET l_xcde304_sum1  = g_xcde2_d[l_ac].xcde304 
                  LET l_xcde308_sum1  = g_xcde2_d[l_ac].xcde308 
                  LET l_xcde902_sum1  = g_xcde2_d[l_ac].xcde902 
               END IF
            END IF               
         END IF     
         #合计 组织
         LET l_xcde102_sum2= l_xcde102_sum2 + g_xcde2_d[l_ac].xcde102
         LET l_xcde202_sum2= l_xcde202_sum2 + g_xcde2_d[l_ac].xcde202
         LET l_xcde302_sum2= l_xcde302_sum2 + g_xcde2_d[l_ac].xcde302
         LET l_xcde304_sum2= l_xcde304_sum2 + g_xcde2_d[l_ac].xcde304
         LET l_xcde308_sum2= l_xcde308_sum2 + g_xcde2_d[l_ac].xcde308
         LET l_xcde902_sum2= l_xcde902_sum2 + g_xcde2_d[l_ac].xcde902
         IF l_ac > 2 THEN
            IF g_xcde2_d[l_ac-2].sfaasite != cl_getmsg("axc-00578",g_lang) THEN 
               IF g_xcde2_d[l_ac].sfaasite != g_xcde2_d[l_ac-2].sfaasite THEN
                  #把当前行下移，并在当前行显示小计
                  LET g_xcde2_d[l_ac + 1].* = g_xcde2_d[l_ac].*  
                  INITIALIZE  g_xcde2_d[l_ac].* TO NULL
                  LET g_xcde2_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)            
                  LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum2  - g_xcde2_d[l_ac+1].xcde102
                  LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum2  - g_xcde2_d[l_ac+1].xcde202 
                  LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum2  - g_xcde2_d[l_ac+1].xcde302 
                  LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum2  - g_xcde2_d[l_ac+1].xcde304 
                  LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum2  - g_xcde2_d[l_ac+1].xcde308 
                  LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum2  - g_xcde2_d[l_ac+1].xcde902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum2  = g_xcde2_d[l_ac].xcde102 
                  LET l_xcde202_sum2  = g_xcde2_d[l_ac].xcde202 
                  LET l_xcde302_sum2  = g_xcde2_d[l_ac].xcde302 
                  LET l_xcde304_sum2  = g_xcde2_d[l_ac].xcde304 
                  LET l_xcde308_sum2  = g_xcde2_d[l_ac].xcde308 
                  LET l_xcde902_sum2  = g_xcde2_d[l_ac].xcde902
               END IF 
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
     #最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN 
         LET g_xcde2_d[l_ac].xccd006   = cl_getmsg("axc-00577",g_lang)
         LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum1 
         LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum1   
         LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum1   
         LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum1   
         LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum1   
         LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum1  
         LET l_ac = l_ac+1  
#按组织小计 
         LET g_xcde2_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)
         LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum2 
         LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum2   
         LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum2   
         LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum2   
         LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum2   
         LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum2  
         LET l_ac = l_ac + 1
#合计 
         LET g_xcde2_d[l_ac].sfaasite  = cl_getmsg("lib-00133",g_lang)
         LET g_xcde2_d[l_ac].xcde102  = l_xcde102_total  
         LET g_xcde2_d[l_ac].xcde202  = l_xcde202_total
         LET g_xcde2_d[l_ac].xcde302  = l_xcde302_total   
         LET g_xcde2_d[l_ac].xcde304  = l_xcde304_total   
         LET g_xcde2_d[l_ac].xcde308  = l_xcde308_total   
         LET g_xcde2_d[l_ac].xcde902  = l_xcde902_total
                 
      END IF                
   

      
   FREE axcq740_pb3

   #end add-point
   
#   CALL g_xcde_d.deleteElement(g_xcde_d.getLength())
#   CALL g_xcde2_d.deleteElement(g_xcde2_d.getLength())
#   CALL g_xcde3_d.deleteElement(g_xcde3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axcq740_pb
   FREE axcq740_pb2
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq740_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM xcde_t
       WHERE xcdeent = g_enterprise AND
         xcdeld = ps_keys_bak[1] AND xcde001 = ps_keys_bak[2] AND xcde002 = ps_keys_bak[3] AND xcde003 = ps_keys_bak[4] AND xcde004 = ps_keys_bak[5] AND xcde005 = ps_keys_bak[6] AND xcde006 = ps_keys_bak[7] AND xcde007 = ps_keys_bak[8] AND xcde008 = ps_keys_bak[9] AND xcde009 = ps_keys_bak[10] AND xcde010 = ps_keys_bak[11]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point   
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM xcdi_t
       WHERE xcdient = g_enterprise AND
         xcdild = ps_keys_bak[1] AND xcdi001 = ps_keys_bak[2] AND xcdi002 = ps_keys_bak[3] AND xcdi003 = ps_keys_bak[4] AND xcdi004 = ps_keys_bak[5] AND xcdi005 = ps_keys_bak[6] AND xcdi006 = ps_keys_bak[7] AND xcdi007 = ps_keys_bak[8] AND xcdi008 = ps_keys_bak[9] AND xcdi009 = ps_keys_bak[10] AND xcdi010 = ps_keys_bak[11]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcdi_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq740_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define

   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
#      INSERT INTO xcde_t
#                  (xcdeent,
#                   xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,
#                   xcde007,xcde008,xcde009,xcde010
#                   ,xcdecomp,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902,xcdecomp,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10],ps_keys[11]
#                   ,g_xcde_d[g_detail_idx].xcdecomp,g_xcde_d[g_detail_idx].xcde101,g_xcde_d[g_detail_idx].xcde102, 
#                       g_xcde_d[g_detail_idx].xcde201,g_xcde_d[g_detail_idx].xcde202,g_xcde_d[g_detail_idx].xcde301, 
#                       g_xcde_d[g_detail_idx].xcde302,g_xcde_d[g_detail_idx].xcde303,g_xcde_d[g_detail_idx].xcde304, 
#                       g_xcde_d[g_detail_idx].xcde307,g_xcde_d[g_detail_idx].xcde308,g_xcde_d[g_detail_idx].xcde901, 
#                       g_xcde_d[g_detail_idx].xcde902,g_xcde_d[g_detail_idx].xcdecomp,g_xcde_d[g_detail_idx].xcde101, 
#                       g_xcde_d[g_detail_idx].xcde102,g_xcde_d[g_detail_idx].xcde201,g_xcde_d[g_detail_idx].xcde202, 
#                       g_xcde_d[g_detail_idx].xcde301,g_xcde_d[g_detail_idx].xcde302,g_xcde_d[g_detail_idx].xcde303, 
#                       g_xcde_d[g_detail_idx].xcde304,g_xcde_d[g_detail_idx].xcde307,g_xcde_d[g_detail_idx].xcde308, 
#                       g_xcde_d[g_detail_idx].xcde901,g_xcde_d[g_detail_idx].xcde902)
      #add-point:insert_b段資料新增中

      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcde_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後

      #end add-point 
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
#      INSERT INTO xcdi_t
#                  (xcdient,
#                   xcdild,xcdi001,xcdi002,xcdi003,xcdi004,xcdi005,xcdi006,
#                   xcdi007,xcdi008,xcdi009,xcdi010
#                   ,xcdicomp,xcdi101,xcdi102,xcdi201,xcdi202,xcdi301,xcdi302,xcdi303,xcdi304,xcdi901,xcdi902) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10],ps_keys[11]
#                   ,g_xcde3_d[g_detail_idx].xcdicomp,g_xcde3_d[g_detail_idx].xcdi101,g_xcde3_d[g_detail_idx].xcdi102, 
#                       g_xcde3_d[g_detail_idx].xcdi201,g_xcde3_d[g_detail_idx].xcdi202,g_xcde3_d[g_detail_idx].xcdi301, 
#                       g_xcde3_d[g_detail_idx].xcdi302,g_xcde3_d[g_detail_idx].xcdi303,g_xcde3_d[g_detail_idx].xcdi304, 
#                       g_xcde3_d[g_detail_idx].xcdi901,g_xcde3_d[g_detail_idx].xcdi902)
#      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcdi_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後

      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other

   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq740_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

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
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcde_t" THEN
      #add-point:update_b段修改前

      #end add-point     
#      UPDATE xcde_t 
#         SET (xcdeld,xcde001,xcde002,xcde003,xcde004,xcde005,xcde006,
#              xcde007,xcde008,xcde009,xcde010
#              ,xcdecomp,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902,xcdecomp,xcde101,xcde102,xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10],ps_keys[11]
#              ,g_xcde_d[g_detail_idx].xcdecomp,g_xcde_d[g_detail_idx].xcde101,g_xcde_d[g_detail_idx].xcde102, 
#                  g_xcde_d[g_detail_idx].xcde201,g_xcde_d[g_detail_idx].xcde202,g_xcde_d[g_detail_idx].xcde301, 
#                  g_xcde_d[g_detail_idx].xcde302,g_xcde_d[g_detail_idx].xcde303,g_xcde_d[g_detail_idx].xcde304, 
#                  g_xcde_d[g_detail_idx].xcde307,g_xcde_d[g_detail_idx].xcde308,g_xcde_d[g_detail_idx].xcde901, 
#                  g_xcde_d[g_detail_idx].xcde902,g_xcde_d[g_detail_idx].xcdecomp,g_xcde_d[g_detail_idx].xcde101, 
#                  g_xcde_d[g_detail_idx].xcde102,g_xcde_d[g_detail_idx].xcde201,g_xcde_d[g_detail_idx].xcde202, 
#                  g_xcde_d[g_detail_idx].xcde301,g_xcde_d[g_detail_idx].xcde302,g_xcde_d[g_detail_idx].xcde303, 
#                  g_xcde_d[g_detail_idx].xcde304,g_xcde_d[g_detail_idx].xcde307,g_xcde_d[g_detail_idx].xcde308, 
#                  g_xcde_d[g_detail_idx].xcde901,g_xcde_d[g_detail_idx].xcde902) 
#         WHERE xcdeent = g_enterprise AND xcdeld = ps_keys_bak[1] AND xcde001 = ps_keys_bak[2] AND xcde002 = ps_keys_bak[3] AND xcde003 = ps_keys_bak[4] AND xcde004 = ps_keys_bak[5] AND xcde005 = ps_keys_bak[6] AND xcde006 = ps_keys_bak[7] AND xcde007 = ps_keys_bak[8] AND xcde008 = ps_keys_bak[9] AND xcde009 = ps_keys_bak[10] AND xcde010 = ps_keys_bak[11]
      #add-point:update_b段修改中

      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcde_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcde_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            LET l_new_key[01] = ps_keys[01] 
LET l_old_key[01] = ps_keys_bak[01] 
LET l_field_key[01] = 'xccdld'
LET l_new_key[02] = ps_keys[02] 
LET l_old_key[02] = ps_keys_bak[02] 
LET l_field_key[02] = 'xccd001'
LET l_new_key[03] = ps_keys[03] 
LET l_old_key[03] = ps_keys_bak[03] 
LET l_field_key[03] = 'xccd002'
LET l_new_key[04] = ps_keys[04] 
LET l_old_key[04] = ps_keys_bak[04] 
LET l_field_key[04] = 'xccd003'
LET l_new_key[05] = ps_keys[05] 
LET l_old_key[05] = ps_keys_bak[05] 
LET l_field_key[05] = 'xccd004'
LET l_new_key[06] = ps_keys[06] 
LET l_old_key[06] = ps_keys_bak[06] 
LET l_field_key[06] = 'xccd005'
LET l_new_key[07] = ps_keys[07] 
LET l_old_key[07] = ps_keys_bak[07] 
LET l_field_key[07] = 'xccd006'
CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'xccd_t')
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcdi_t" THEN
      #add-point:update_b段修改前

      #end add-point     
#      UPDATE xcdi_t 
#         SET (xcdild,xcdi001,xcdi002,xcdi003,xcdi004,xcdi005,xcdi006,
#              xcdi007,xcdi008,xcdi009,xcdi010
#              ,xcdicomp,xcdi101,xcdi102,xcdi201,xcdi202,xcdi301,xcdi302,xcdi303,xcdi304,xcdi901,xcdi902) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10],ps_keys[11]
#              ,g_xcde3_d[g_detail_idx].xcdicomp,g_xcde3_d[g_detail_idx].xcdi101,g_xcde3_d[g_detail_idx].xcdi102, 
#                  g_xcde3_d[g_detail_idx].xcdi201,g_xcde3_d[g_detail_idx].xcdi202,g_xcde3_d[g_detail_idx].xcdi301, 
#                  g_xcde3_d[g_detail_idx].xcdi302,g_xcde3_d[g_detail_idx].xcdi303,g_xcde3_d[g_detail_idx].xcdi304, 
#                  g_xcde3_d[g_detail_idx].xcdi901,g_xcde3_d[g_detail_idx].xcdi902) 
#         WHERE xcdient = g_enterprise AND xcdild = ps_keys_bak[1] AND xcdi001 = ps_keys_bak[2] AND xcdi002 = ps_keys_bak[3] AND xcdi003 = ps_keys_bak[4] AND xcdi004 = ps_keys_bak[5] AND xcdi005 = ps_keys_bak[6] AND xcdi006 = ps_keys_bak[7] AND xcdi007 = ps_keys_bak[8] AND xcdi008 = ps_keys_bak[9] AND xcdi009 = ps_keys_bak[10] AND xcdi010 = ps_keys_bak[11]
#      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcdi_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcdi_t" 
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
 
{<section id="axcq740.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq740_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define

   #end add-point   
   
   #先刷新資料
   #CALL axcq740_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "xcde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axcq740_bcl USING g_enterprise,
                                       g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003, 
                                           g_xccd_m.xccd004,g_xccd_m.xccd005,g_xcde_d[g_detail_idx].xcde007, 
                                           g_xcde_d[g_detail_idx].xcde008,g_xcde_d[g_detail_idx].xcde009, 
                                           g_xcde_d[g_detail_idx].xcde010     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axcq740_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "xcdi_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axcq740_bcl2 USING g_enterprise,
                                             g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003, 
                                                 g_xccd_m.xccd004,g_xccd_m.xccd005, 
                                                 g_xcde3_d[g_detail_idx].xcdi007,g_xcde3_d[g_detail_idx].xcdi008, 
                                                 g_xcde3_d[g_detail_idx].xcdi009,g_xcde3_d[g_detail_idx].xcdi010 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axcq740_bcl2" 
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
 
{<section id="axcq740.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq740_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axcq740_bcl
   END IF
   
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axcq740_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq740_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq740_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq740_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
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
 
{<section id="axcq740.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq740_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
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
 
{<section id="axcq740.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq740_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point   
   #add-point:set_act_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq740_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point   
   #add-point:set_act_no_visible段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq740_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point   
   #add-point:set_act_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq740_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point   
   #add-point:set_act_no_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq740_default_search()
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_cnt  LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE ls_wc   STRING 
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

   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.state_change" >}
   
 
{</section>}
 
{<section id="axcq740.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq740_idx_chk()
   #add-point:idx_chk段define
   
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
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq740_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define

   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
 
      
   #add-point:單身填充後

   #end add-point
    
   LET l_ac = li_ac
   
   CALL axcq740_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq740.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq740_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
      
      #end add-point
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
   IF ps_idx = 2 AND
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
 
 
   
   #add-point:fill_chk段after_chk
   
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq740.signature" >}
   
 
{</section>}
 
{<section id="axcq740.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION axcq740_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   
   #add-point:set_pk_array段之前

   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xccd_m.xccdld
   LET g_pk_array[1].column = 'xccdld'
   LET g_pk_array[2].values = g_xccd_m.xccd001
   LET g_pk_array[2].column = 'xccd001'
   
   LET g_pk_array[4].values = g_xccd_m.xccd003
   LET g_pk_array[4].column = 'xccd003'
   LET g_pk_array[5].values = g_xccd_m.xccd004
   LET g_pk_array[5].column = 'xccd004'
   LET g_pk_array[6].values = g_xccd_m.xccd005
   LET g_pk_array[6].column = 'xccd005'
   
   
   #add-point:set_pk_array段之後

   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axcq740.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axcq740.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq740_default()
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
PRIVATE FUNCTION axcq740_ref()
DEFINE l_glaa001 LIKE glaa_t.glaa001
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

LET l_glaa001= ' '
CASE g_xccd_m.xccd001
   WHEN '1'
      SELECT glaa001 INTO l_glaa001
       FROM glaa_t
      WHERE glaaent = g_enterprise
        AND glaald  = g_xccd_m.xccdld
   WHEN '2'
      SELECT glaa016 INTO l_glaa001
       FROM glaa_t
      WHERE glaaent = g_enterprise
        AND glaald  = g_xccd_m.xccdld
   WHEN '3'
      SELECT glaa020 INTO l_glaa001
       FROM glaa_t
      WHERE glaaent = g_enterprise
        AND glaald  = g_xccd_m.xccdld
END CASE
INITIALIZE g_ref_fields TO NULL
LET g_ref_fields[1] = l_glaa001
CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''
DISPLAY BY NAME g_xccd_m.xccd001_desc
END FUNCTION
################################################################################
# Descriptions...: 建立TMP TABLE供Q轉XG用
# Memo...........: #150319-00004#22
#
# Date & Author..: 150512 By rayhuang
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq740_x01_tmp()
   DROP TABLE axcq740_x01_tmp;
   CREATE TEMP TABLE axcq740_x01_tmp(
      l_sfaasite      LIKE sfaa_t.sfaasite, 
      l_sfaasite_desc LIKE type_t.chr500, 
      xccd002         LIKE xccd_t.xccd002, 
      l_xccd002_desc  LIKE type_t.chr500, 
      xccd006         LIKE xccd_t.xccd006, 
      xcde007         LIKE xcde_t.xcde007, 
      l_imaal003      LIKE type_t.chr500, 
      l_imaal004      LIKE type_t.chr500, 
      xcde008         LIKE xcde_t.xcde008, 
      xcde009         LIKE xcde_t.xcde009, 
      xcde010         LIKE xcde_t.xcde010, 
      l_xcde010_desc  LIKE type_t.chr500, 
      l_xcbb005       LIKE type_t.chr500, 
      xcde101         LIKE xcde_t.xcde101, 
      xcde102         LIKE xcde_t.xcde102, 
      xcde201         LIKE xcde_t.xcde201, 
      xcde202         LIKE xcde_t.xcde202, 
      xcde301         LIKE xcde_t.xcde301, 
      xcde302         LIKE xcde_t.xcde302, 
      xcde303         LIKE xcde_t.xcde303, 
      xcde304         LIKE xcde_t.xcde304, 
      xcde307         LIKE xcde_t.xcde307, 
      xcde308         LIKE xcde_t.xcde308, 
      xcde901         LIKE xcde_t.xcde901, 
      xcde902         LIKE xcde_t.xcde902,
      l_xccdcomp_desc LIKE type_t.chr500, 
      l_xccdld_desc   LIKE type_t.chr500,
      xccd004         LIKE xccd_t.xccd004, 
      xccd005         LIKE xccd_t.xccd005,
      l_xccd001_desc  LIKE type_t.chr500,
      l_xccd003_desc  LIKE type_t.chr500,
      l_odr           LIKE type_t.num5)
END FUNCTION
################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: #150319-00004#22
#
# Date & Author..: 150512 By rayhuang
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq740_insert_tmp()
   DEFINE l_i like type_t.num10
   DEFINE l_xccd001_desc LIKE type_t.chr500    #取得SCC的說明文字
   DEFINE l_x01_tmp RECORD
      l_sfaasite      LIKE sfaa_t.sfaasite, 
      l_sfaasite_desc LIKE type_t.chr500, 
      xccd002         LIKE xccd_t.xccd002, 
      l_xccd002_desc  LIKE type_t.chr500, 
      xccd006         LIKE xccd_t.xccd006, 
      xcde007         LIKE xcde_t.xcde007, 
      l_imaal003      LIKE type_t.chr500, 
      l_imaal004      LIKE type_t.chr500, 
      xcde008         LIKE xcde_t.xcde008, 
      xcde009         LIKE xcde_t.xcde009, 
      xcde010         LIKE xcde_t.xcde010, 
      l_xcde010_desc  LIKE type_t.chr500, 
      l_xcbb005       LIKE type_t.chr500, 
      xcde101         LIKE xcde_t.xcde101, 
      xcde102         LIKE xcde_t.xcde102, 
      xcde201         LIKE xcde_t.xcde201, 
      xcde202         LIKE xcde_t.xcde202, 
      xcde301         LIKE xcde_t.xcde301, 
      xcde302         LIKE xcde_t.xcde302, 
      xcde303         LIKE xcde_t.xcde303, 
      xcde304         LIKE xcde_t.xcde304, 
      xcde307         LIKE xcde_t.xcde307, 
      xcde308         LIKE xcde_t.xcde308, 
      xcde901         LIKE xcde_t.xcde901, 
      xcde902         LIKE xcde_t.xcde902,
      l_xccdcomp_desc LIKE type_t.chr500, 
      l_xccdld_desc   LIKE type_t.chr500,
      xccd004         LIKE xccd_t.xccd004, 
      xccd005         LIKE xccd_t.xccd005,
      l_xccd001_desc  LIKE type_t.chr500,
      l_xccd003_desc  LIKE type_t.chr500,
      l_odr           LIKE type_t.num5
                END RECORD
   DELETE FROM axcq740_x01_tmp
   FOR l_i = 1 TO g_xcde_d.getLength()
      CALL s_desc_gzcbl004_desc('8914',g_xccd_m.xccd001) RETURNING l_xccd001_desc
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.l_sfaasite      = g_xcde_d[l_i].sfaasite 
      LET l_x01_tmp.l_sfaasite_desc = g_xcde_d[l_i].sfaasite_desc 
      LET l_x01_tmp.xccd002         = g_xcde_d[l_i].xccd002 
      LET l_x01_tmp.l_xccd002_desc  = g_xcde_d[l_i].xccd002_desc 
      LET l_x01_tmp.xccd006         = g_xcde_d[l_i].xccd006 
      LET l_x01_tmp.xcde007         = g_xcde_d[l_i].xcde007 
      LET l_x01_tmp.l_imaal003      = g_xcde_d[l_i].xcde007_desc 
      LET l_x01_tmp.l_imaal004      = g_xcde_d[l_i].xcde007_desc_desc 
      LET l_x01_tmp.xcde008         = g_xcde_d[l_i].xcde008 
      LET l_x01_tmp.xcde009         = g_xcde_d[l_i].xcde009 
      LET l_x01_tmp.xcde010         = g_xcde_d[l_i].xcde010 
      LET l_x01_tmp.l_xcde010_desc  = g_xcde_d[l_i].xcde010_desc 
      LET l_x01_tmp.l_xcbb005       = g_xcde_d[l_i].xcbb005 
      LET l_x01_tmp.xcde101         = g_xcde_d[l_i].xcde101 
      LET l_x01_tmp.xcde102         = g_xcde_d[l_i].xcde102 
      LET l_x01_tmp.xcde201         = g_xcde_d[l_i].xcde201 
      LET l_x01_tmp.xcde202         = g_xcde_d[l_i].xcde202 
      LET l_x01_tmp.xcde301         = g_xcde_d[l_i].xcde301 
      LET l_x01_tmp.xcde302         = g_xcde_d[l_i].xcde302 
      LET l_x01_tmp.xcde303         = g_xcde_d[l_i].xcde303 
      LET l_x01_tmp.xcde304         = g_xcde_d[l_i].xcde304 
      LET l_x01_tmp.xcde307         = g_xcde_d[l_i].xcde307 
      LET l_x01_tmp.xcde308         = g_xcde_d[l_i].xcde308 
      LET l_x01_tmp.xcde901         = g_xcde_d[l_i].xcde901 
      LET l_x01_tmp.xcde902         = g_xcde_d[l_i].xcde902
      LET l_x01_tmp.l_xccdcomp_desc = g_xccd_m.xccdcomp,":",g_xccd_m.xccdcomp_desc 
      LET l_x01_tmp.l_xccdld_desc   = g_xccd_m.xccdld,":",  g_xccd_m.xccdld_desc
      LET l_x01_tmp.xccd004         = g_xccd_m.xccd004 
      LET l_x01_tmp.xccd005         = g_xccd_m.xccd005 
      LET l_x01_tmp.l_xccd001_desc  = g_xccd_m.xccd001,":",l_xccd001_desc,":",g_xccd_m.xccd001_desc
      LET l_x01_tmp.l_xccd003_desc  = g_xccd_m.xccd003,":",g_xccd_m.xccd003_desc
      LET l_x01_tmp.l_odr           = l_i
      INSERT INTO axcq740_x01_tmp VALUES(l_x01_tmp.*)
   END FOR
END FUNCTION

#160520-00003#14 因效能优化，原b_fill()中的sql重写
#+ 單身陣列填充
PRIVATE FUNCTION axcq740_b_fill_1()
   DEFINE l_xcde102_sum1  LIKE xcde_t.xcde102
   DEFINE l_xcde202_sum1  LIKE xcde_t.xcde202
   DEFINE l_xcde302_sum1  LIKE xcde_t.xcde302
   DEFINE l_xcde304_sum1  LIKE xcde_t.xcde304
   DEFINE l_xcde308_sum1  LIKE xcde_t.xcde308
   DEFINE l_xcde902_sum1  LIKE xcde_t.xcde902
   DEFINE l_xcde102_sum2  LIKE xcde_t.xcde102
   DEFINE l_xcde202_sum2  LIKE xcde_t.xcde202
   DEFINE l_xcde302_sum2  LIKE xcde_t.xcde302
   DEFINE l_xcde304_sum2  LIKE xcde_t.xcde304
   DEFINE l_xcde308_sum2  LIKE xcde_t.xcde308
   DEFINE l_xcde902_sum2  LIKE xcde_t.xcde902
   DEFINE l_xcde102_total LIKE xcde_t.xcde102
   DEFINE l_xcde202_total LIKE xcde_t.xcde202
   DEFINE l_xcde302_total LIKE xcde_t.xcde302
   DEFINE l_xcde304_total LIKE xcde_t.xcde304
   DEFINE l_xcde308_total LIKE xcde_t.xcde308
   DEFINE l_xcde902_total LIKE xcde_t.xcde902  
   DEFINE l_stre          STRING
   DEFINE l_stri          STRING
  #161208-00014#1-s-add 
   DEFINE l_xcde201_sum1  LIKE xcde_t.xcde201
   DEFINE l_xcde201_sum2  LIKE xcde_t.xcde201
   DEFINE l_xcde201_total LIKE xcde_t.xcde201
  #161208-00014#1-e-add
   #end add-point     

   LET l_stre = ' '
   LET l_stri = ' '
   IF NOT cl_null(g_wc2_table1) THEN      
      LET g_wc2_table1=cl_replace_str(g_wc2_table1,"xccd002","xcde002")
      LET g_wc2_table1=cl_replace_str(g_wc2_table1,"xccd006","xcde006")
      LET l_stre = l_stre CLIPPED," AND ",g_wc2_table1 CLIPPED 
      LET g_wc2_table4 = g_wc2_table1
      LET g_wc2_table4=cl_replace_str(g_wc2_table4,"xcde","xcdi")
      LET l_stri = l_stri CLIPPED," AND ",g_wc2_table4 CLIPPED
   END IF
   IF NOT cl_null(g_wc2_table2) THEN      
      LET g_wc2_table2=cl_replace_str(g_wc2_table2,"xccd002","xcdi002")
      LET g_wc2_table2=cl_replace_str(g_wc2_table2,"xccd006","xcdi006")
      LET l_stri = l_stri CLIPPED," AND ",g_wc2_table2 CLIPPED
      LET g_wc2_table5 = g_wc2_table2
      LET g_wc2_table5=cl_replace_str(g_wc2_table5,"xcdi","xcde")
      LET l_stre = l_stre CLIPPED," AND ",g_wc2_table5 CLIPPED 
   END IF
   IF NOT cl_null(g_wc2_table3) THEN      
      LET g_wc2_table3=cl_replace_str(g_wc2_table3,"xccd002","xcde002")
      LET g_wc2_table3=cl_replace_str(g_wc2_table3,"xccd006","xcde006")
      LET l_stre = l_stre CLIPPED," AND ",g_wc2_table3 CLIPPED  
      LET g_wc2_table6 = g_wc2_table3
      LET g_wc2_table6=cl_replace_str(g_wc2_table6,"xcde","xcdi")
      LET l_stri = l_stri CLIPPED," AND ",g_wc2_table6 CLIPPED
   END IF
   
   LET g_sql = "SELECT UNIQUE sfaasite,xcde002,xcde006,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102, ",
               "     xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902, ",
               "     imaal003 ,imaal004 ,xcaul003,",
               "     (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=sfaasite AND ooefl002='"||g_dlang||"') ooefl003 ,",
               "     (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=sfaasite AND xcbfl001=xcde002 AND xcbfl002='"||g_dlang||"' ) xcbfl003 ,",
               "     (SELECT xcbb005 FROM xcbb_t WHERE xcbbent='",g_enterprise,"' AND xcbbcomp=sfaasite AND xcbb001='",g_xccd_m.xccd004,"' AND xcbb002='",g_xccd_m.xccd005,"' AND xcbb003=xcde007) xcbb005 ",
               "  FROM ", 
               " ( " ,
               "    SELECT UNIQUE (SELECT sfaasite FROM sfaa_t WHERE sfaaent = xcdeent AND sfaadocno = xcde006) sfaasite, ",
               "       xcde002,xcde006,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102, ",
               "       (xcde201+xcde205+xcde207+xcde209) xcde201 ,(xcde202+xcde206+xcde208+xcde210) xcde202 , ",
               "       xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902, ",
               "       (SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xcde007 AND imaal002='"||g_dlang||"' ) imaal003 ,",
               "       (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xcde007 AND imaal002='"||g_dlang||"' ) imaal004 , ",
               "       (SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=xcde010 AND xcaul002='"||g_dlang||"' ) xcaul003 ",
               "    FROM xcde_t",   
               "     INNER JOIN xccd_t ON xccdld = xcdeld ",
               "     AND xccd001 = xcde001 ",
               "     AND xccd002 = xcde002 ",
               "     AND xccd003 = xcde003 ",
               "     AND xccd004 = xcde004 ",
               "     AND xccd005 = xcde005 ",
               "     AND xccd006 = xcde006 ",
               "    WHERE xcdeent=? AND xcdeld=? AND xcde001=? AND xcde003=? AND xcde004=? AND xcde005=? "
                    ,l_stre ,
               "  )  "
      LET g_sql = g_sql CLIPPED ," UNION ALL ",
                  " SELECT UNIQUE sfaasite,xcdi002,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, ",
                  "   xcdi301,xcdi302,xcdi303,xcdi304,0,0,xcdi901,xcdi902,imaal003 ,imaal004 ,xcaul003 ,",
                  "   (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=sfaasite AND ooefl002='"||g_dlang||"') ooefl003 ,",
                  "   (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=sfaasite AND xcbfl001=xcdi002 AND xcbfl002='"||g_dlang||"' ) xcbfl003,",
                  "   (SELECT xcbb005 FROM xcbb_t WHERE xcbbent='",g_enterprise,"' AND xcbbcomp=sfaasite AND xcbb001='",g_xccd_m.xccd004,"' AND xcbb002='",g_xccd_m.xccd005,"' AND xcbb003=xcdi007) xcbb005 ",
                  "  FROM ", 
                  " ( " ,
                  "     SELECT UNIQUE (SELECT sfaasite FROM sfaa_t WHERE sfaaent = xcdient AND sfaadocno = xcdi006) sfaasite,",
                  "            xcdi002,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, ",
                  "            xcdi301,xcdi302,xcdi303,xcdi304,0,0,xcdi901,xcdi902,",
                  "            (SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xcdi007 AND imaal002='"||g_dlang||"' ) imaal003 ,",
                  "            (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xcdi007 AND imaal002='"||g_dlang||"' ) imaal004 ,",
                  "            (SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=xcdi010 AND xcaul002='"||g_dlang||"' ) xcaul003 ",
                  "    FROM xcdi_t",   
                  "    INNER JOIN xcch_t ON xcchld = xcdild ",
                  "    AND xcch001 = xcdi001 ",
                  "    AND xcch002 = xcdi002 ",
                  "    AND xcch003 = xcdi003 ",
                  "    AND xcch004 = xcdi004 ",
                  "    AND xcch005 = xcdi005 ",
                  "    AND xcch006 = xcdi006 ",
                  "   WHERE xcdient=? AND xcdild=? AND xcdi001=? AND xcdi003=? AND xcdi004=? AND xcdi005=? " 
                      ,l_stri              
      #end add-point
      
      
      #子單身的WC
      LET g_sql = g_sql CLIPPED, "  ) "

      #add-point:單身填充控制
      LET g_sql = g_sql, " ORDER BY 1,3,4,5,6,7,2"
      LET l_xcde102_sum1 = 0
      LET l_xcde202_sum1 = 0
      LET l_xcde302_sum1 = 0
      LET l_xcde304_sum1 = 0
      LET l_xcde308_sum1 = 0
      LET l_xcde902_sum1 = 0
      LET l_xcde102_sum2 = 0
      LET l_xcde202_sum2 = 0
      LET l_xcde302_sum2 = 0
      LET l_xcde304_sum2 = 0
      LET l_xcde308_sum2 = 0
      LET l_xcde902_sum2 = 0
      LET l_xcde102_total= 0
      LET l_xcde202_total= 0
      LET l_xcde302_total= 0
      LET l_xcde304_total= 0
      LET l_xcde308_total= 0
      LET l_xcde902_total= 0
     #161208-00014#1-s-add
      LET l_xcde201_sum1 = 0
      LET l_xcde201_sum2 = 0
      LET l_xcde201_total= 0
     #161208-00014#1-e-add     
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq740_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR axcq740_pb4
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,
                            g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005                    
      FOREACH b_fill_cs4 INTO g_xcde_d[l_ac].sfaasite,g_xcde_d[l_ac].xccd002,g_xcde_d[l_ac].xccd006,g_xcde_d[l_ac].xcde007,g_xcde_d[l_ac].xcde008,g_xcde_d[l_ac].xcde009, 
          g_xcde_d[l_ac].xcde010,g_xcde_d[l_ac].xcde101,g_xcde_d[l_ac].xcde102,g_xcde_d[l_ac].xcde201, 
          g_xcde_d[l_ac].xcde202,g_xcde_d[l_ac].xcde301,g_xcde_d[l_ac].xcde302,g_xcde_d[l_ac].xcde303, 
          g_xcde_d[l_ac].xcde304,g_xcde_d[l_ac].xcde307,g_xcde_d[l_ac].xcde308,g_xcde_d[l_ac].xcde901, 
          g_xcde_d[l_ac].xcde902,g_xcde_d[l_ac].xcde007_desc, 
          g_xcde_d[l_ac].xcde007_desc_desc,g_xcde_d[l_ac].xcde010_desc,
          g_xcde_d[l_ac].sfaasite_desc,g_xcde_d[l_ac].xccd002_desc,g_xcde_d[l_ac].xcbb005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #共计         
         LET l_xcde102_total= l_xcde102_total + g_xcde_d[l_ac].xcde102
         LET l_xcde201_total= l_xcde201_total + g_xcde_d[l_ac].xcde201  #161208-00014#1
         LET l_xcde202_total= l_xcde202_total + g_xcde_d[l_ac].xcde202  
         LET l_xcde302_total= l_xcde302_total + g_xcde_d[l_ac].xcde302
         LET l_xcde304_total= l_xcde304_total + g_xcde_d[l_ac].xcde304
         LET l_xcde308_total= l_xcde308_total + g_xcde_d[l_ac].xcde308
         LET l_xcde902_total= l_xcde902_total + g_xcde_d[l_ac].xcde902
         #小计 单号
         LET l_xcde102_sum1= l_xcde102_sum1 + g_xcde_d[l_ac].xcde102
         LET l_xcde201_sum1= l_xcde201_sum1 + g_xcde_d[l_ac].xcde201  #161208-00014#1
         LET l_xcde202_sum1= l_xcde202_sum1 + g_xcde_d[l_ac].xcde202  
         LET l_xcde302_sum1= l_xcde302_sum1 + g_xcde_d[l_ac].xcde302
         LET l_xcde304_sum1= l_xcde304_sum1 + g_xcde_d[l_ac].xcde304
         LET l_xcde308_sum1= l_xcde308_sum1 + g_xcde_d[l_ac].xcde308
         LET l_xcde902_sum1= l_xcde902_sum1 + g_xcde_d[l_ac].xcde902
         IF l_ac > 1 THEN 
            IF g_xcde_d[l_ac].xccd006 != g_xcde_d[l_ac-1].xccd006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xcde_d[l_ac + 1].* = g_xcde_d[l_ac].*  
               INITIALIZE  g_xcde_d[l_ac].* TO NULL
               LET g_xcde_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
               LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum1  - g_xcde_d[l_ac+1].xcde102
               LET g_xcde_d[l_ac].xcde201  = l_xcde201_sum1  - g_xcde_d[l_ac+1].xcde201 #161208-00014#1
               LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum1  - g_xcde_d[l_ac+1].xcde202 
               LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum1  - g_xcde_d[l_ac+1].xcde302 
               LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum1  - g_xcde_d[l_ac+1].xcde304 
               LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum1  - g_xcde_d[l_ac+1].xcde308 
               LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum1  - g_xcde_d[l_ac+1].xcde902 
               LET l_ac = l_ac + 1
               LET l_xcde102_sum1  = g_xcde_d[l_ac].xcde102
               LET l_xcde201_sum1  = g_xcde_d[l_ac].xcde201  #161208-00014#1
               LET l_xcde202_sum1  = g_xcde_d[l_ac].xcde202  
               LET l_xcde302_sum1  = g_xcde_d[l_ac].xcde302 
               LET l_xcde304_sum1  = g_xcde_d[l_ac].xcde304 
               LET l_xcde308_sum1  = g_xcde_d[l_ac].xcde308 
               LET l_xcde902_sum1  = g_xcde_d[l_ac].xcde902 
            ELSE
               IF g_xcde_d[l_ac].sfaasite != g_xcde_d[l_ac-1].sfaasite THEN
                  LET g_xcde_d[l_ac + 1].* = g_xcde_d[l_ac].*  
                  INITIALIZE  g_xcde_d[l_ac].* TO NULL
                  LET g_xcde_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
                  LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum1  - g_xcde_d[l_ac+1].xcde102
                  LET g_xcde_d[l_ac].xcde201  = l_xcde201_sum1  - g_xcde_d[l_ac+1].xcde201 #161208-00014#1
                  LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum1  - g_xcde_d[l_ac+1].xcde202 
                  LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum1  - g_xcde_d[l_ac+1].xcde302 
                  LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum1  - g_xcde_d[l_ac+1].xcde304 
                  LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum1  - g_xcde_d[l_ac+1].xcde308 
                  LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum1  - g_xcde_d[l_ac+1].xcde902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum1  = g_xcde_d[l_ac].xcde102
                  LET l_xcde201_sum1  = g_xcde_d[l_ac].xcde201 #161208-00014#1
                  LET l_xcde202_sum1  = g_xcde_d[l_ac].xcde202 
                  LET l_xcde302_sum1  = g_xcde_d[l_ac].xcde302 
                  LET l_xcde304_sum1  = g_xcde_d[l_ac].xcde304 
                  LET l_xcde308_sum1  = g_xcde_d[l_ac].xcde308 
                  LET l_xcde902_sum1  = g_xcde_d[l_ac].xcde902 
               END IF
            END IF               
         END IF     
         #合计 组织
         LET l_xcde102_sum2= l_xcde102_sum2 + g_xcde_d[l_ac].xcde102
         LET l_xcde201_sum2= l_xcde201_sum2 + g_xcde_d[l_ac].xcde201 #161208-00014#1
         LET l_xcde202_sum2= l_xcde202_sum2 + g_xcde_d[l_ac].xcde202 
         LET l_xcde302_sum2= l_xcde302_sum2 + g_xcde_d[l_ac].xcde302
         LET l_xcde304_sum2= l_xcde304_sum2 + g_xcde_d[l_ac].xcde304
         LET l_xcde308_sum2= l_xcde308_sum2 + g_xcde_d[l_ac].xcde308
         LET l_xcde902_sum2= l_xcde902_sum2 + g_xcde_d[l_ac].xcde902
         IF l_ac > 2 THEN
            IF g_xcde_d[l_ac-2].sfaasite != cl_getmsg("axc-00578",g_lang) THEN
               IF g_xcde_d[l_ac].sfaasite != g_xcde_d[l_ac-2].sfaasite THEN
                  #把当前行下移，并在当前行显示小计
                  LET g_xcde_d[l_ac + 1].* = g_xcde_d[l_ac].*  
                  INITIALIZE  g_xcde_d[l_ac].* TO NULL
                  LET g_xcde_d[l_ac].sfaasite = cl_getmsg("axc-00578",g_lang)            
                  LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum2  - g_xcde_d[l_ac+1].xcde102
                  LET g_xcde_d[l_ac].xcde201  = l_xcde201_sum2  - g_xcde_d[l_ac+1].xcde201 #161208-00014#1
                  LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum2  - g_xcde_d[l_ac+1].xcde202 
                  LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum2  - g_xcde_d[l_ac+1].xcde302 
                  LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum2  - g_xcde_d[l_ac+1].xcde304 
                  LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum2  - g_xcde_d[l_ac+1].xcde308 
                  LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum2  - g_xcde_d[l_ac+1].xcde902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum2  = g_xcde_d[l_ac].xcde102 
                  LET l_xcde201_sum2  = g_xcde_d[l_ac].xcde201 #161208-00014#1
                  LET l_xcde202_sum2  = g_xcde_d[l_ac].xcde202 
                  LET l_xcde302_sum2  = g_xcde_d[l_ac].xcde302 
                  LET l_xcde304_sum2  = g_xcde_d[l_ac].xcde304 
                  LET l_xcde308_sum2  = g_xcde_d[l_ac].xcde308 
                  LET l_xcde902_sum2  = g_xcde_d[l_ac].xcde902
               END IF 
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
     #LET g_error_show = 0
      #最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN 
         LET g_xcde_d[l_ac].xccd006   = cl_getmsg("axc-00577",g_lang)
         LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum1 
         LET g_xcde_d[l_ac].xcde201  = l_xcde201_sum1 #161208-00014#1  
         LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum1   
         LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum1   
         LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum1   
         LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum1   
         LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum1  
         LET l_ac = l_ac+1  
#按组织小计 
         LET g_xcde_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)
         LET g_xcde_d[l_ac].xcde102  = l_xcde102_sum2 
         LET g_xcde_d[l_ac].xcde201  = l_xcde201_sum2  #161208-00014#1 
         LET g_xcde_d[l_ac].xcde202  = l_xcde202_sum2  
         LET g_xcde_d[l_ac].xcde302  = l_xcde302_sum2   
         LET g_xcde_d[l_ac].xcde304  = l_xcde304_sum2   
         LET g_xcde_d[l_ac].xcde308  = l_xcde308_sum2   
         LET g_xcde_d[l_ac].xcde902  = l_xcde902_sum2  
         LET l_ac = l_ac + 1
#合计 
         LET g_xcde_d[l_ac].sfaasite  = cl_getmsg("lib-00133",g_lang)
         LET g_xcde_d[l_ac].xcde102  = l_xcde102_total  
         LET g_xcde_d[l_ac].xcde201  = l_xcde201_total #161208-00014#1 
         LET g_xcde_d[l_ac].xcde202  = l_xcde202_total 
         LET g_xcde_d[l_ac].xcde302  = l_xcde302_total   
         LET g_xcde_d[l_ac].xcde304  = l_xcde304_total   
         LET g_xcde_d[l_ac].xcde308  = l_xcde308_total   
         LET g_xcde_d[l_ac].xcde902  = l_xcde902_total 
                  
      END IF                

      LET g_sql = "SELECT UNIQUE sfaasite,xcdi002,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, ", 
                  "       xcdi301,xcdi302,xcdi303,xcdi304,xcdi901,xcdi902, imaal003 ,imaal004 ,xcaul003 ,",
                  "   (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=sfaasite AND ooefl002='"||g_dlang||"') ooefl003 ,",
                  "   (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=sfaasite AND xcbfl001=xcdi002 AND xcbfl002='"||g_dlang||"' ) xcbfl003,",
                  "   (SELECT xcbb005 FROM xcbb_t WHERE xcbbent='",g_enterprise,"' AND xcbbcomp=sfaasite AND xcbb001='",g_xccd_m.xccd004,"' AND xcbb002='",g_xccd_m.xccd005,"' AND xcbb003=xcdi007) xcbb005 ",
                  " FROM ", 
                  " (  ",
                  "   SELECT UNIQUE (SELECT sfaasite FROM sfaa_t WHERE sfaaent = xcdient AND sfaadocno = xcdi006) sfaasite,",
                  "          xcdi002,xcdi006,xcdi007,xcdi008,xcdi009,xcdi010,xcdi101,xcdi102,xcdi201,xcdi202, ",
                  "          xcdi301,xcdi302,xcdi303,xcdi304,xcdi901,xcdi902,",
                  "          (SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xcdi007 AND imaal002='"||g_dlang||"' ) imaal003 ,",
                  "          (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xcdi007 AND imaal002='"||g_dlang||"' ) imaal004 ,",
                  "          (SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=xcdi010 AND xcaul002='"||g_dlang||"' ) xcaul003 ",
                  "    FROM xcdi_t",   
                  "    INNER JOIN xcch_t ON xcchld = xcdild ",
                  "    AND xcch001 = xcdi001 ",
                  "    AND xcch002 = xcdi002 ",
                  "    AND xcch003 = xcdi003 ",
                  "    AND xcch004 = xcdi004 ",
                  "    AND xcch005 = xcdi005 ",
                  "    AND xcch006 = xcdi006 ",
                  " WHERE xcdient=? AND xcdild=? AND xcdi001=? AND xcdi003=? AND xcdi004=? AND xcdi005=? "   
                     ,l_stri 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #end add-point
     
      
      #子單身的WC

      #add-point:單身填充控制
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
      LET g_sql = g_sql CLIPPED, "  ) "
      
      LET g_sql = g_sql, " ORDER BY 1,3,4,5,6,7,2"
      LET l_xcde102_sum1 = 0
      LET l_xcde202_sum1 = 0
      LET l_xcde302_sum1 = 0
      LET l_xcde304_sum1 = 0
      LET l_xcde308_sum1 = 0
      LET l_xcde902_sum1 = 0
      LET l_xcde102_sum2 = 0
      LET l_xcde202_sum2 = 0
      LET l_xcde302_sum2 = 0
      LET l_xcde304_sum2 = 0
      LET l_xcde308_sum2 = 0
      LET l_xcde902_sum2 = 0
      LET l_xcde102_total= 0
      LET l_xcde202_total= 0
      LET l_xcde302_total= 0
      LET l_xcde304_total= 0
      LET l_xcde308_total= 0
      LET l_xcde902_total= 0
     #161208-00014#1-s-add
      LET l_xcde201_sum1 = 0
      LET l_xcde201_sum2 = 0
      LET l_xcde201_total= 0
     #161208-00014#1-e-add          
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq740_pb5 FROM g_sql
      DECLARE b_fill_cs5 CURSOR FOR axcq740_pb5
      
      LET l_ac = 1
      
      OPEN b_fill_cs5 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
                                               
      FOREACH b_fill_cs5 INTO g_xcde3_d[l_ac].sfaasite,g_xcde3_d[l_ac].xccd002,g_xcde3_d[l_ac].xccd006,g_xcde3_d[l_ac].xcdi007,g_xcde3_d[l_ac].xcdi008, 
          g_xcde3_d[l_ac].xcdi009,g_xcde3_d[l_ac].xcdi010,g_xcde3_d[l_ac].xcdi101,g_xcde3_d[l_ac].xcdi102, 
          g_xcde3_d[l_ac].xcdi201,g_xcde3_d[l_ac].xcdi202,g_xcde3_d[l_ac].xcdi301,g_xcde3_d[l_ac].xcdi302, 
          g_xcde3_d[l_ac].xcdi303,g_xcde3_d[l_ac].xcdi304,g_xcde3_d[l_ac].xcdi901,g_xcde3_d[l_ac].xcdi902,           
          g_xcde3_d[l_ac].xcdi007_desc, 
          g_xcde3_d[l_ac].xcdi007_desc_desc,g_xcde3_d[l_ac].xcdi010_desc,
          g_xcde3_d[l_ac].sfaasite_3_desc,g_xcde3_d[l_ac].xccd002_3_desc,g_xcde3_d[l_ac].xcbb005

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #共计         
         LET l_xcde102_total= l_xcde102_total + g_xcde3_d[l_ac].xcdi102
         LET l_xcde201_total= l_xcde201_total + g_xcde3_d[l_ac].xcdi201 #161208-00014#1
         LET l_xcde202_total= l_xcde202_total + g_xcde3_d[l_ac].xcdi202 
         LET l_xcde302_total= l_xcde302_total + g_xcde3_d[l_ac].xcdi302
         LET l_xcde304_total= l_xcde304_total + g_xcde3_d[l_ac].xcdi304        
         LET l_xcde902_total= l_xcde902_total + g_xcde3_d[l_ac].xcdi902
         #小计 单号
         LET l_xcde102_sum1= l_xcde102_sum1 + g_xcde3_d[l_ac].xcdi102
         LET l_xcde201_sum1= l_xcde201_sum1 + g_xcde3_d[l_ac].xcdi201 #161208-00014#1
         LET l_xcde202_sum1= l_xcde202_sum1 + g_xcde3_d[l_ac].xcdi202 
         LET l_xcde302_sum1= l_xcde302_sum1 + g_xcde3_d[l_ac].xcdi302
         LET l_xcde304_sum1= l_xcde304_sum1 + g_xcde3_d[l_ac].xcdi304        
         LET l_xcde902_sum1= l_xcde902_sum1 + g_xcde3_d[l_ac].xcdi902
         IF l_ac > 1 THEN 
            IF g_xcde3_d[l_ac].xccd006 != g_xcde3_d[l_ac-1].xccd006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xcde3_d[l_ac + 1].* = g_xcde3_d[l_ac].*  
               INITIALIZE  g_xcde3_d[l_ac].* TO NULL
               LET g_xcde3_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
               LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum1  - g_xcde3_d[l_ac+1].xcdi102
               LET g_xcde3_d[l_ac].xcdi201  = l_xcde201_sum1  - g_xcde3_d[l_ac+1].xcdi201 #161208-00014#1
               LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum1  - g_xcde3_d[l_ac+1].xcdi202 
               LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum1  - g_xcde3_d[l_ac+1].xcdi302 
               LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum1  - g_xcde3_d[l_ac+1].xcdi304
               LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum1  - g_xcde3_d[l_ac+1].xcdi902 
               LET l_ac = l_ac + 1
               LET l_xcde102_sum1  = g_xcde3_d[l_ac].xcdi102
               LET l_xcde201_sum1  = g_xcde3_d[l_ac].xcdi201 #161208-00014#1
               LET l_xcde202_sum1  = g_xcde3_d[l_ac].xcdi202 
               LET l_xcde302_sum1  = g_xcde3_d[l_ac].xcdi302 
               LET l_xcde304_sum1  = g_xcde3_d[l_ac].xcdi304
               LET l_xcde902_sum1  = g_xcde3_d[l_ac].xcdi902
            ELSE
               IF g_xcde3_d[l_ac].sfaasite != g_xcde3_d[l_ac-1].sfaasite THEN
                  LET g_xcde3_d[l_ac + 1].* = g_xcde3_d[l_ac].*  
                  INITIALIZE  g_xcde3_d[l_ac].* TO NULL
                  LET g_xcde3_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
                  LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum1  - g_xcde3_d[l_ac+1].xcdi102
                  LET g_xcde3_d[l_ac].xcdi201  = l_xcde201_sum1  - g_xcde3_d[l_ac+1].xcdi201 #161208-00014#1
                  LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum1  - g_xcde3_d[l_ac+1].xcdi202 
                  LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum1  - g_xcde3_d[l_ac+1].xcdi302 
                  LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum1  - g_xcde3_d[l_ac+1].xcdi304
                  LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum1  - g_xcde3_d[l_ac+1].xcdi902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum1  = g_xcde3_d[l_ac].xcdi102
                  LET l_xcde201_sum1  = g_xcde3_d[l_ac].xcdi201 #161208-00014#1
                  LET l_xcde202_sum1  = g_xcde3_d[l_ac].xcdi202 
                  LET l_xcde302_sum1  = g_xcde3_d[l_ac].xcdi302 
                  LET l_xcde304_sum1  = g_xcde3_d[l_ac].xcdi304
                  LET l_xcde902_sum1  = g_xcde3_d[l_ac].xcdi902
               END IF               
            END IF               
         END IF     
         #合计 组织
         LET l_xcde102_sum2= l_xcde102_sum2 + g_xcde3_d[l_ac].xcdi102
         LET l_xcde201_sum2= l_xcde201_sum2 + g_xcde3_d[l_ac].xcdi201  #161208-00014#1
         LET l_xcde202_sum2= l_xcde202_sum2 + g_xcde3_d[l_ac].xcdi202  
         LET l_xcde302_sum2= l_xcde302_sum2 + g_xcde3_d[l_ac].xcdi302
         LET l_xcde304_sum2= l_xcde304_sum2 + g_xcde3_d[l_ac].xcdi304
         LET l_xcde902_sum2= l_xcde902_sum2 + g_xcde3_d[l_ac].xcdi902
         IF l_ac > 2 THEN
            IF g_xcde3_d[l_ac-2].sfaasite != cl_getmsg("axc-00578",g_lang) THEN
               IF g_xcde3_d[l_ac].sfaasite != g_xcde3_d[l_ac-2].sfaasite THEN
                  #把当前行下移，并在当前行显示小计
                  LET g_xcde3_d[l_ac + 1].* = g_xcde3_d[l_ac].*  
                  INITIALIZE  g_xcde3_d[l_ac].* TO NULL
                  LET g_xcde3_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)            
                  LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum2  - g_xcde3_d[l_ac+1].xcdi102
                  LET g_xcde3_d[l_ac].xcdi201  = l_xcde201_sum2  - g_xcde3_d[l_ac+1].xcdi201 #161208-00014#1
                  LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum2  - g_xcde3_d[l_ac+1].xcdi202 
                  LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum2  - g_xcde3_d[l_ac+1].xcdi302 
                  LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum2  - g_xcde3_d[l_ac+1].xcdi304
                  LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum2  - g_xcde3_d[l_ac+1].xcdi902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum2  = g_xcde3_d[l_ac].xcdi102 
                  LET l_xcde201_sum2  = g_xcde3_d[l_ac].xcdi201 #161208-00014#1
                  LET l_xcde202_sum2  = g_xcde3_d[l_ac].xcdi202 
                  LET l_xcde302_sum2  = g_xcde3_d[l_ac].xcdi302 
                  LET l_xcde304_sum2  = g_xcde3_d[l_ac].xcdi304
                  LET l_xcde902_sum2  = g_xcde3_d[l_ac].xcdi902
               END IF 
            END IF            
         END IF  
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
      #最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN 
         LET g_xcde3_d[l_ac].xccd006   = cl_getmsg("axc-00577",g_lang)
         LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum1 
         LET g_xcde3_d[l_ac].xcdi201  = l_xcde201_sum1   #161208-00014#1
         LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum1   
         LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum1   
         LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum1  
         LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum1  
         LET l_ac = l_ac+1  
#按组织小计 
         LET g_xcde3_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)
         LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_sum2 
         LET g_xcde3_d[l_ac].xcdi201  = l_xcde201_sum2   #161208-00014#1
         LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_sum2   
         LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_sum2   
         LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_sum2  
         LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_sum2  
         LET l_ac = l_ac + 1
#合计 
         LET g_xcde3_d[l_ac].sfaasite  = cl_getmsg("lib-00133",g_lang)
         LET g_xcde3_d[l_ac].xcdi102  = l_xcde102_total  
         LET g_xcde3_d[l_ac].xcdi201  = l_xcde201_total #161208-00014#1
         LET g_xcde3_d[l_ac].xcdi202  = l_xcde202_total 
         LET g_xcde3_d[l_ac].xcdi302  = l_xcde302_total   
         LET g_xcde3_d[l_ac].xcdi304  = l_xcde304_total  
         LET g_xcde3_d[l_ac].xcdi902  = l_xcde902_total
                  
      END IF                
   
      LET g_sql = "SELECT UNIQUE sfaasite,xcde002,xcde006,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102, ",
                  "       xcde201,xcde202,xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902, ",
                  "       imaal003 ,imaal004 ,xcaul003 ,",
                  "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=sfaasite AND ooefl002='"||g_dlang||"') ooefl003 ,",
                  "       (SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=sfaasite AND xcbfl001=xcde002 AND xcbfl002='"||g_dlang||"' ) xcbfl003,",
                  "       (SELECT xcbb005 FROM xcbb_t WHERE xcbbent='",g_enterprise,"' AND xcbbcomp=sfaasite AND xcbb001='",g_xccd_m.xccd004,"' AND xcbb002='",g_xccd_m.xccd005,"' AND xcbb003=xcde007) xcbb005 ",
                  " FROM ",   
                  " ( ",
                  "   SELECT UNIQUE (SELECT sfaasite FROM sfaa_t WHERE sfaaent = xcdeent AND sfaadocno = xcde006 ) sfaasite,",
                  "          xcde002,xcde006,xcde007,xcde008,xcde009,xcde010,xcde101,xcde102, ",
                  "          (xcde201+xcde205+xcde207+xcde209) xcde201 ,(xcde202+xcde206+xcde208+xcde210) xcde202, ",
                  "          xcde301,xcde302,xcde303,xcde304,xcde307,xcde308,xcde901,xcde902, ",
                  "          (SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xcde007 AND imaal002='"||g_dlang||"' ) imaal003 ,",
                  "          (SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=xcde007 AND imaal002='"||g_dlang||"' ) imaal004 ,",
                  "          (SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=xcde010 AND xcaul002='"||g_dlang||"' ) xcaul003 ",
                  "   FROM xcde_t",   
                  "    INNER JOIN xccd_t ON xccdld = xcdeld ",
                  "    AND xccd001 = xcde001 ",
                  "    AND xccd002 = xcde002 ",
                  "    AND xccd003 = xcde003 ",
                  "    AND xccd004 = xcde004 ",
                  "    AND xccd005 = xcde005 ",
                  "    AND xccd006 = xcde006 ",
                  " WHERE xcdeent=? AND xcdeld=? AND xcde001=? AND xcde003=? AND xcde004=? AND xcde005=? "
                    ,l_stre 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #end add-point
      
      
      LET g_sql = g_sql CLIPPED, "  ) "
      
      #add-point:單身填充控制
      LET g_sql = g_sql, " ORDER BY 1,3,4,5,6,7,2"
      LET l_xcde102_sum1 = 0
      LET l_xcde202_sum1 = 0
      LET l_xcde302_sum1 = 0
      LET l_xcde304_sum1 = 0
      LET l_xcde308_sum1 = 0
      LET l_xcde902_sum1 = 0
      LET l_xcde102_sum2 = 0
      LET l_xcde202_sum2 = 0
      LET l_xcde302_sum2 = 0
      LET l_xcde304_sum2 = 0
      LET l_xcde308_sum2 = 0
      LET l_xcde902_sum2 = 0
      LET l_xcde102_total= 0
      LET l_xcde202_total= 0
      LET l_xcde302_total= 0
      LET l_xcde304_total= 0
      LET l_xcde308_total= 0
      LET l_xcde902_total= 0
     #161208-00014#1-s-add
      LET l_xcde201_sum1 = 0
      LET l_xcde201_sum2 = 0
      LET l_xcde201_total= 0
     #161208-00014#1-e-add          
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq740_pb6 FROM g_sql
      DECLARE b_fill_cs6 CURSOR FOR axcq740_pb6
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs6 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
                                               
      FOREACH b_fill_cs6 INTO g_xcde2_d[l_ac].sfaasite,g_xcde2_d[l_ac].xccd002,g_xcde2_d[l_ac].xccd006,g_xcde2_d[l_ac].xcde007,g_xcde2_d[l_ac].xcde008,g_xcde2_d[l_ac].xcde009, 
          g_xcde2_d[l_ac].xcde010,g_xcde2_d[l_ac].xcde101,g_xcde2_d[l_ac].xcde102,g_xcde2_d[l_ac].xcde201, 
          g_xcde2_d[l_ac].xcde202,g_xcde2_d[l_ac].xcde301,g_xcde2_d[l_ac].xcde302,g_xcde2_d[l_ac].xcde303, 
          g_xcde2_d[l_ac].xcde304,g_xcde2_d[l_ac].xcde307,g_xcde2_d[l_ac].xcde308,g_xcde2_d[l_ac].xcde901, 
          g_xcde2_d[l_ac].xcde902,g_xcde2_d[l_ac].xcde007_2_desc, 
          g_xcde2_d[l_ac].xcde007_2_desc_desc,g_xcde2_d[l_ac].xcde010_2_desc,
          g_xcde2_d[l_ac].sfaasite_2_desc,g_xcde2_d[l_ac].xccd002_2_desc,g_xcde2_d[l_ac].xcbb005
          
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
        
         #共计         
         LET l_xcde102_total= l_xcde102_total + g_xcde2_d[l_ac].xcde102
         LET l_xcde201_total= l_xcde201_total + g_xcde2_d[l_ac].xcde201  #161208-00014#1
         LET l_xcde202_total= l_xcde202_total + g_xcde2_d[l_ac].xcde202  
         LET l_xcde302_total= l_xcde302_total + g_xcde2_d[l_ac].xcde302
         LET l_xcde304_total= l_xcde304_total + g_xcde2_d[l_ac].xcde304
         LET l_xcde308_total= l_xcde308_total + g_xcde2_d[l_ac].xcde308
         LET l_xcde902_total= l_xcde902_total + g_xcde2_d[l_ac].xcde902
         #小计 单号
         LET l_xcde102_sum1= l_xcde102_sum1 + g_xcde2_d[l_ac].xcde102
         LET l_xcde201_sum1= l_xcde201_sum1 + g_xcde2_d[l_ac].xcde201 #161208-00014#1
         LET l_xcde202_sum1= l_xcde202_sum1 + g_xcde2_d[l_ac].xcde202 
         LET l_xcde302_sum1= l_xcde302_sum1 + g_xcde2_d[l_ac].xcde302
         LET l_xcde304_sum1= l_xcde304_sum1 + g_xcde2_d[l_ac].xcde304
         LET l_xcde308_sum1= l_xcde308_sum1 + g_xcde2_d[l_ac].xcde308
         LET l_xcde902_sum1= l_xcde902_sum1 + g_xcde2_d[l_ac].xcde902
         IF l_ac > 1 THEN 
            IF g_xcde2_d[l_ac].xccd006 != g_xcde2_d[l_ac-1].xccd006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xcde2_d[l_ac + 1].* = g_xcde2_d[l_ac].*  
               INITIALIZE  g_xcde2_d[l_ac].* TO NULL
               LET g_xcde2_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
               LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum1  - g_xcde2_d[l_ac+1].xcde102
               LET g_xcde2_d[l_ac].xcde201  = l_xcde201_sum1  - g_xcde2_d[l_ac+1].xcde201 #161208-00014#1
               LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum1  - g_xcde2_d[l_ac+1].xcde202 
               LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum1  - g_xcde2_d[l_ac+1].xcde302 
               LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum1  - g_xcde2_d[l_ac+1].xcde304 
               LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum1  - g_xcde2_d[l_ac+1].xcde308 
               LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum1  - g_xcde2_d[l_ac+1].xcde902 
               LET l_ac = l_ac + 1
               LET l_xcde102_sum1  = g_xcde2_d[l_ac].xcde102
               LET l_xcde201_sum1  = g_xcde2_d[l_ac].xcde201 #161208-00014#1
               LET l_xcde202_sum1  = g_xcde2_d[l_ac].xcde202 
               LET l_xcde302_sum1  = g_xcde2_d[l_ac].xcde302 
               LET l_xcde304_sum1  = g_xcde2_d[l_ac].xcde304 
               LET l_xcde308_sum1  = g_xcde2_d[l_ac].xcde308 
               LET l_xcde902_sum1  = g_xcde2_d[l_ac].xcde902 
            ELSE
               IF g_xcde2_d[l_ac].sfaasite != g_xcde2_d[l_ac-1].sfaasite THEN
                  #把当前行下移，并在当前行显示小计
                  LET g_xcde2_d[l_ac + 1].* = g_xcde2_d[l_ac].*  
                  INITIALIZE  g_xcde2_d[l_ac].* TO NULL
                  LET g_xcde2_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang)            
                  LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum1  - g_xcde2_d[l_ac+1].xcde102
                  LET g_xcde2_d[l_ac].xcde201  = l_xcde201_sum1  - g_xcde2_d[l_ac+1].xcde201 #161208-00014#1
                  LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum1  - g_xcde2_d[l_ac+1].xcde202 
                  LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum1  - g_xcde2_d[l_ac+1].xcde302 
                  LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum1  - g_xcde2_d[l_ac+1].xcde304 
                  LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum1  - g_xcde2_d[l_ac+1].xcde308 
                  LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum1  - g_xcde2_d[l_ac+1].xcde902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum1  = g_xcde2_d[l_ac].xcde102
                  LET l_xcde201_sum1  = g_xcde2_d[l_ac].xcde201 #161208-00014#1
                  LET l_xcde202_sum1  = g_xcde2_d[l_ac].xcde202 
                  LET l_xcde302_sum1  = g_xcde2_d[l_ac].xcde302 
                  LET l_xcde304_sum1  = g_xcde2_d[l_ac].xcde304 
                  LET l_xcde308_sum1  = g_xcde2_d[l_ac].xcde308 
                  LET l_xcde902_sum1  = g_xcde2_d[l_ac].xcde902 
               END IF
            END IF               
         END IF     
         #合计 组织
         LET l_xcde102_sum2= l_xcde102_sum2 + g_xcde2_d[l_ac].xcde102
         LET l_xcde201_sum2= l_xcde201_sum2 + g_xcde2_d[l_ac].xcde201 #161208-00014#1
         LET l_xcde202_sum2= l_xcde202_sum2 + g_xcde2_d[l_ac].xcde202 
         LET l_xcde302_sum2= l_xcde302_sum2 + g_xcde2_d[l_ac].xcde302
         LET l_xcde304_sum2= l_xcde304_sum2 + g_xcde2_d[l_ac].xcde304
         LET l_xcde308_sum2= l_xcde308_sum2 + g_xcde2_d[l_ac].xcde308
         LET l_xcde902_sum2= l_xcde902_sum2 + g_xcde2_d[l_ac].xcde902
         IF l_ac > 2 THEN
            IF g_xcde2_d[l_ac-2].sfaasite != cl_getmsg("axc-00578",g_lang) THEN 
               IF g_xcde2_d[l_ac].sfaasite != g_xcde2_d[l_ac-2].sfaasite THEN
                  #把当前行下移，并在当前行显示小计
                  LET g_xcde2_d[l_ac + 1].* = g_xcde2_d[l_ac].*  
                  INITIALIZE  g_xcde2_d[l_ac].* TO NULL
                  LET g_xcde2_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)            
                  LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum2  - g_xcde2_d[l_ac+1].xcde102
                  LET g_xcde2_d[l_ac].xcde201  = l_xcde201_sum2  - g_xcde2_d[l_ac+1].xcde201  #161208-00014#1
                  LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum2  - g_xcde2_d[l_ac+1].xcde202  
                  LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum2  - g_xcde2_d[l_ac+1].xcde302 
                  LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum2  - g_xcde2_d[l_ac+1].xcde304 
                  LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum2  - g_xcde2_d[l_ac+1].xcde308 
                  LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum2  - g_xcde2_d[l_ac+1].xcde902 
                  LET l_ac = l_ac + 1
                  LET l_xcde102_sum2  = g_xcde2_d[l_ac].xcde102 
                  LET l_xcde201_sum2  = g_xcde2_d[l_ac].xcde201 #161208-00014#1
                  LET l_xcde202_sum2  = g_xcde2_d[l_ac].xcde202 
                  LET l_xcde302_sum2  = g_xcde2_d[l_ac].xcde302 
                  LET l_xcde304_sum2  = g_xcde2_d[l_ac].xcde304 
                  LET l_xcde308_sum2  = g_xcde2_d[l_ac].xcde308 
                  LET l_xcde902_sum2  = g_xcde2_d[l_ac].xcde902
               END IF 
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
     #最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN 
         LET g_xcde2_d[l_ac].xccd006   = cl_getmsg("axc-00577",g_lang)
         LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum1 
         LET g_xcde2_d[l_ac].xcde201  = l_xcde201_sum1   #161208-00014#1
         LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum1   
         LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum1   
         LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum1   
         LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum1   
         LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum1  
         LET l_ac = l_ac+1  
#按组织小计 
         LET g_xcde2_d[l_ac].sfaasite  = cl_getmsg("axc-00578",g_lang)
         LET g_xcde2_d[l_ac].xcde102  = l_xcde102_sum2 
         LET g_xcde2_d[l_ac].xcde201  = l_xcde201_sum2   #161208-00014#1
         LET g_xcde2_d[l_ac].xcde202  = l_xcde202_sum2   
         LET g_xcde2_d[l_ac].xcde302  = l_xcde302_sum2   
         LET g_xcde2_d[l_ac].xcde304  = l_xcde304_sum2   
         LET g_xcde2_d[l_ac].xcde308  = l_xcde308_sum2   
         LET g_xcde2_d[l_ac].xcde902  = l_xcde902_sum2  
         LET l_ac = l_ac + 1
#合计 
         LET g_xcde2_d[l_ac].sfaasite  = cl_getmsg("lib-00133",g_lang)
         LET g_xcde2_d[l_ac].xcde102  = l_xcde102_total  
         LET g_xcde2_d[l_ac].xcde201  = l_xcde201_total #161208-00014#1
         LET g_xcde2_d[l_ac].xcde202  = l_xcde202_total 
         LET g_xcde2_d[l_ac].xcde302  = l_xcde302_total   
         LET g_xcde2_d[l_ac].xcde304  = l_xcde304_total   
         LET g_xcde2_d[l_ac].xcde308  = l_xcde308_total   
         LET g_xcde2_d[l_ac].xcde902  = l_xcde902_total
                 
      END IF                
   
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axcq740_pb4
   FREE axcq740_pb5
   FREE axcq740_pb6
 
END FUNCTION

 
{</section>}
 
