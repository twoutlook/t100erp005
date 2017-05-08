#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq901.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000050
#+ 
#+ Filename...: axcq901
#+ Description: 期末料件實際與標準成本差異查詢作業
#+ Creator....: 03297(2014-10-11 17:22:15)
#+ Modifier...: 03297(2014-10-14 09:09:44) -SD/PR- 02097
#+ Buildtype..: 應用 i07 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axcq901.global" >}

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
#160520-00003#13  2016-5-23   By zhujing  效能优化
#160920-00018#1   2016-9-20   By wuxja    单身笔数多，数组会越界，调整游标类型num5--》num10 
#160802-00020#9   2016/09/26  By 02097    法人:視azzi800的据點權限/帳套: 視USER的帳套權限/QBE下法人/帳套不用互相勾稽
#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xccc_m        RECORD
       xccccomp LIKE xccc_t.xccccomp, 
   xccccomp_desc LIKE type_t.chr80, 
   xccc004 LIKE xccc_t.xccc004, 
   xccc005 LIKE xccc_t.xccc005, 
   xccc003 LIKE xccc_t.xccc003, 
   xcccc003_desc LIKE type_t.chr80, 
   xcccld LIKE xccc_t.xcccld, 
   xcccld_desc LIKE type_t.chr80, 
   xccc001 LIKE xccc_t.xccc001,
   xccc001_desc LIKE type_t.chr80,   
   xcag001 LIKE type_t.chr500, 
   xcag001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccc_d        RECORD
       xccc002 LIKE xccc_t.xccc002, 
   xccc002_desc LIKE type_t.chr500, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc006_desc LIKE type_t.chr500, 
   xccc006_desc_desc LIKE type_t.chr500, 
   xccc008 LIKE xccc_t.xccc008, 
   xcbb005 LIKE type_t.chr10, 
   xccc901 LIKE xccc_t.xccc901, 
   xccc280 LIKE xccc_t.xccc280, 
   xccc902 LIKE xccc_t.xccc902, 
   xcag011 LIKE type_t.chr10, 
   xcag102 LIKE type_t.num20_6, 
   l_amt LIKE type_t.num20_6, 
   l_diff LIKE type_t.num20_6
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_xccc_m          type_g_xccc_m
DEFINE g_xccc_m_t        type_g_xccc_m
DEFINE g_xccc_m_o        type_g_xccc_m
 
   DEFINE g_xccc004_t LIKE xccc_t.xccc004
DEFINE g_xccc005_t LIKE xccc_t.xccc005
DEFINE g_xccc003_t LIKE xccc_t.xccc003
DEFINE g_xcccld_t LIKE xccc_t.xcccld
DEFINE g_xccc001_t LIKE xccc_t.xccc001
 
 
DEFINE g_xccc_d          DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_xccc_d_t        type_g_xccc_d
DEFINE g_xccc_d_o        type_g_xccc_d
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcccld LIKE xccc_t.xcccld,
      b_xccc001 LIKE xccc_t.xccc001,
      b_xccc003 LIKE xccc_t.xccc003,
      b_xccc004 LIKE xccc_t.xccc004,
      b_xccc005 LIKE xccc_t.xccc005,
      b_xcag001 LIKE xcag_t.xcag001
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
DEFINE g_rec_b               LIKE type_t.num10             #160920-00018#1  num5-->num10     
DEFINE l_ac                  LIKE type_t.num10             #160920-00018#1  num5-->num10 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10             #160920-00018#1  num5-->num10            
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10              #160920-00018#1  num5-->num10 #單身總筆數      
DEFINE g_detail_idx          LIKE type_t.num10              #160920-00018#1  num5-->num10 #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10              #160920-00018#1  num5-->num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10              #160920-00018#1  num5-->num10 #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10              #160920-00018#1  num5-->num10 #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10              #160920-00018#1  num5-->num10 #Browser目前所在筆數(暫存用)
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #160920-00018#1  num5-->num10 #Browser所在筆數
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_wc1                  STRING
DEFINE g_wc2_table3           STRING 
DEFINE g_sql_sub              STRING 
 TYPE type_g_xccc3_d        RECORD
       xcdc002 LIKE xcdc_t.xcdc002, 
   xcdc002_desc LIKE type_t.chr500, 
   xcdc006 LIKE xcdc_t.xcdc006, 
   xcdc007 LIKE xcdc_t.xcdc007, 
   xcdc006_desc LIKE type_t.chr500, 
   xcdc006_desc_desc LIKE type_t.chr500, 
   xcdc008 LIKE xcdc_t.xcdc008,
   xcdc009 LIKE xcdc_t.xcdc008,
   xcdc009_desc LIKE type_t.chr500, 
   xcbb005 LIKE type_t.chr10, 
   xcdc901 LIKE xcdc_t.xcdc901, 
   xcdc280 LIKE xcdc_t.xcdc280, 
   xcdc902 LIKE xcdc_t.xcdc902, 
   xcag011 LIKE type_t.chr10, 
   xcag102 LIKE type_t.num20_6, 
   l_amt_3 LIKE type_t.num20_6, 
   l_diff_3 LIKE type_t.num20_6
       END RECORD
DEFINE g_xccc3_d          DYNAMIC ARRAY OF type_g_xccc3_d
DEFINE g_xccc3_d_t        type_g_xccc3_d
DEFINE g_xccc3_d_o        type_g_xccc3_d

 TYPE type_g_xccc2_d        RECORD
       xccc002 LIKE xccc_t.xccc002, 
   xccc002_desc LIKE type_t.chr500, 
   xccc006 LIKE xccc_t.xccc006, 
   xccc007 LIKE xccc_t.xccc007, 
   xccc006_desc LIKE type_t.chr500, 
   xccc006_desc_desc LIKE type_t.chr500, 
   xccc008 LIKE xccc_t.xccc008, 
   xcbb005 LIKE type_t.chr10, 
   xccc901 LIKE xccc_t.xccc901,
   xcau003 LIKE xcau_t.xcau003, 
   xccc280a LIKE xccc_t.xccc280, 
   xccc902a LIKE xccc_t.xccc902, 
   xcag011 LIKE type_t.chr10, 
   xcag102a LIKE type_t.num20_6, 
   l_amt_2 LIKE type_t.num20_6, 
   l_diff_2 LIKE type_t.num20_6
       END RECORD
DEFINE g_xccc2_d          DYNAMIC ARRAY OF type_g_xccc2_d
DEFINE g_xccc2_d_t        type_g_xccc2_d
DEFINE g_xccc2_d_o        type_g_xccc2_d
DEFINE g_glaa001          LIKE glaa_t.glaa001
DEFINE g_rec_b2           LIKE type_t.num10     #160920-00018#1  num5-->num10 
DEFINE g_rec_b3           LIKE type_t.num10     #160920-00018#1  num5-->num10 
DEFINE g_current_page     LIKE type_t.num10     #160920-00018#1  num5-->num10         #目前所在頁數
DEFINE g_para_data        LIKE type_t.chr80     #采用成本域否
DEFINE g_para_data1       LIKE type_t.chr80     #采用特性否
DEFINE g_wc_cs_ld         STRING                  #160802-00020#9
DEFINE g_wc_cs_comp       STRING                  #160802-00020#9
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axcq901.main" >}
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
#160802-00020#9-s
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人
#160802-00020#9-e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT xccccomp,'',xccc004,xccc005,xccc003,'',xcccld,'',xccc001,'',''", 
                      " FROM xccc_t",
                      " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND  
                          xccc005=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq901_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xccccomp,t0.xccc004,t0.xccc005,t0.xccc003,t0.xcccld,t0.xccc001,t1.ooefl003 , 
       t2.glaal002",
               " FROM xccc_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xccccomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent='"||g_enterprise||"' AND t2.glaalld=t0.xcccld AND t2.glaal001='"||g_dlang||"' ",
 
               " WHERE t0.xcccent = '" ||g_enterprise|| "' AND t0.xcccld = ? AND t0.xccc001 = ? AND t0.xccc003 = ? AND t0.xccc004 = ? AND t0.xccc005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE axcq901_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq901 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq901_init()   
 
      #進入選單 Menu (="N")
      CALL axcq901_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq901
      
   END IF 
   
   CLOSE axcq901_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axcq901.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq901_init()
   #add-point:init段define
   
   #end add-point    
  
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('xcau003','8901') 
   CALL cl_set_combo_scc('xccc001','8914')
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc,xcdc002,xcdc002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc,xcdc002,xcdc002_desc',FALSE)                
   END IF 
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否            
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccc007,xccc007_2,xcdc007',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccc007,xccc007_2,xcdc007',FALSE)                
   END IF   
   #end add-point
   
   CALL axcq901_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq901.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq901_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define

   #end add-point  
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
   
      CALL axcq901_browser_fill("")
 
      
      ##判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      #IF g_state = "Y" THEN
      #   FOR li_idx = 1 TO g_browser.getLength()
      #      IF g_browser[li_idx].b_xcccld = g_xcccld_t
      #         AND g_browser[li_idx].b_xccc001 = g_xccc001_t
      #         AND g_browser[li_idx].b_xccc003 = g_xccc003_t
      #         AND g_browser[li_idx].b_xccc004 = g_xccc004_t
      #         AND g_browser[li_idx].b_xccc005 = g_xccc005_t
 
      #         THEN
      #         LET g_current_row = li_idx
      #         EXIT FOR
      #      END IF
      #   END FOR
      #   LET g_state = ""
      #END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xccc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axcq901_ui_detailshow()
               
               #add-point:page1自定義行為
               LET g_current_page = 1
               DISPLAY g_xccc_d.getLength() TO FORMONLY.cnt
               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY
        
 
         
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_xccc2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axcq901_ui_detailshow()
               
               #add-point:page1自定義行為
               LET g_current_page = 2
               DISPLAY g_xccc2_d.getLength() TO FORMONLY.cnt
               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               DISPLAY g_xccc2_d.getLength() TO FORMONLY.cnt
               IF g_xccc2_d.getLength() = 0 THEN
                  LET g_detail_idx = 0
               END IF
               DISPLAY g_detail_idx TO FORMONLY.idx
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
         DISPLAY ARRAY g_xccc3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b3) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axcq901_ui_detailshow()
               
               #add-point:page1自定義行為
               LET g_current_page = 3
               DISPLAY g_xccc3_d.getLength() TO FORMONLY.cnt
               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               DISPLAY g_xccc3_d.getLength() TO FORMONLY.cnt
               IF g_xccc3_d.getLength() = 0 THEN
                  LET g_detail_idx = 0
               END IF
               DISPLAY g_detail_idx TO FORMONLY.idx
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
         #end add-point
         
         
         BEFORE DIALOG
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
               CALL axcq901_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq901_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2

            #end add-point
 
         
         
         ON ACTION first
            CALL axcq901_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL axcq901_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL axcq901_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL axcq901_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL axcq901_fetch('L')
            LET g_current_row = g_current_idx
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xccc_d)
                  LEt g_export_id[1]="s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xccc2_d)
                  LEt g_export_id[2]="s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xccc3_d)
                  LEt g_export_id[3]="s_detail3"
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
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
               CALL axcq901_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq901_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL axcq901_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq901_query()
               #add-point:ON ACTION query

               #END add-point
               #此段落由子樣板a59產生  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
			   
 
 
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
            CALL axcq901_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq901_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq901_set_pk_array()
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
         EXIT WHILE
      END IF
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq901_browser_search(p_type)
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define
   
   #end add-point    
   
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "searchcol" 
      LET g_errparam.code   = "std-00005" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF 
   
   IF NOT cl_null(g_searchstr) THEN
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1"
   END IF         
   
   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY xcccld"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL axcq901_browser_fill("F")
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq901_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   
   #end add-point    
   
   #add-point:browser_fill段動作開始前
   
   #end add-point    
 
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "xcccld"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
                      ", xccc004 ",
                      ", xccc005 ",
 
                      " FROM xccc_t ",
                      " ",
                      " ",
 
                      " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccc_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
                      ", xccc004 ",
                      ", xccc005 ",
 
                      " FROM xccc_t ",
                      " ",
                      " ",
                      " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccc_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前
   #fengmy
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
                      ", xccc004 ",
                      ", xccc005 ",
                      ", xcag001 ",
                      " FROM xcag_t, ",
                      " ",
                      " LEFT JOIN xccc_t ON xcagent=xcccent AND xcagcomp=xccccomp ",
 
                      " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc," AND ", g_wc1, " AND ", l_wc2#,
                      
                      #cl_sql_add_filter("xcag_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcccld ",
                      ", xccc001 ",
                      ", xccc003 ",
                      ", xccc004 ",
                      ", xccc005 ",
                      ", xcag001 ",
                      " FROM xcag_t ",
                      " ",
                      " LEFT JOIN xccc_t ON xcagent=xcccent AND xcagcomp=xccccomp ",
                      " WHERE xcccent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED," AND ", g_wc1 CLIPPED#, 
                      
                      #cl_sql_add_filter("xcag_t")
   END IF 

#160802-00020#9-s
   #增加帳套過濾條件
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql," AND xcccld IN ",g_wc_cs_ld
   END IF
   #增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xccccomp IN ",g_wc_cs_comp
   END IF
#160802-00020#9-e

   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
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
 
   #依照t0.xcccld,t0.xccc001,t0.xccc003,t0.xccc004,t0.xccc005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcccld,t0.xccc001,t0.xccc003,t0.xccc004,t0.xccc005",
                " FROM xccc_t t0",
 
                
                " WHERE t0.xcccent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccc_t")
 
   #add-point:browser_fill,sql_rank前
   LET g_sql  = "SELECT DISTINCT t0.xcccld,t0.xccc001,t0.xccc003,t0.xccc004,t0.xccc005,t1.xcag001",
                " FROM xcag_t t1",
 
                " LEFT JOIN xccc_t t0 ON t1.xcagent=t0.xcccent AND t1.xcagcomp=t0.xccccomp ",
                " WHERE t0.xcccent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2," AND ", g_wc1#,                
               # cl_sql_add_filter("xcag_t")

#160802-00020#9-s
   #增加帳套過濾條件
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql," AND xcccld IN ",g_wc_cs_ld
   END IF
   #增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccccomp IN ",g_wc_cs_comp
   END IF
#160802-00020#9-e
   
   IF 1=2 THEN
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccc_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   #CALL g_browser.clear()
   #LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_xcccld,g_browser[g_cnt].b_xccc001,g_browser[g_cnt].b_xccc003, 
       g_browser[g_cnt].b_xccc004,g_browser[g_cnt].b_xccc005 
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
   
   IF cl_null(g_browser[g_cnt].b_xcccld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xccc_m.* TO NULL
      CALL g_xccc_d.clear()
 
      #add-point:browser_fill段after_clear
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
   END IF
   
   #add-point:browser_fill段結束前
   ELSE
       LET g_sql= g_sql, " ORDER BY xcag001,",l_searchcol, " ", g_order
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE browse_pre1 FROM g_sql
      DECLARE browse_cur1 CURSOR FOR browse_pre1
      
      #CALL g_browser.clear()
      #LET g_cnt = 1
      FOREACH browse_cur1 INTO g_browser[g_cnt].b_xcccld,g_browser[g_cnt].b_xccc001,g_browser[g_cnt].b_xccc003, 
          g_browser[g_cnt].b_xccc004,g_browser[g_cnt].b_xccc005,g_browser[g_cnt].b_xcag001 
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
      
      IF cl_null(g_browser[g_cnt].b_xcccld) THEN
         CALL g_browser.deleteElement(g_cnt)
      END IF
      
      IF g_browser.getLength() = 0 AND l_wc THEN
         INITIALIZE g_xccc_m.* TO NULL
         CALL g_xccc_d.clear()
      
         #add-point:browser_fill段after_clear
      
         #end add-point 
         CLEAR FORM
      END IF
      
      LET g_header_cnt = g_browser.getLength()
      LET g_rec_b = g_cnt - 1
      LET g_detail_cnt = g_rec_b
      LET g_cnt = 0
      
      LET g_browser_cnt = g_browser.getLength()
      DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      
      
      FREE browse_pre
      
      #若無資料則關閉相關功能
      IF g_browser_cnt = 0 THEN
         CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
      END IF 
   END IF
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq901_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_xccc_m.xcccld = g_browser[g_current_idx].b_xcccld   
   LET g_xccc_m.xccc001 = g_browser[g_current_idx].b_xccc001   
   LET g_xccc_m.xccc003 = g_browser[g_current_idx].b_xccc003   
   LET g_xccc_m.xccc004 = g_browser[g_current_idx].b_xccc004   
   LET g_xccc_m.xccc005 = g_browser[g_current_idx].b_xccc005   
 
   EXECUTE axcq901_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   CALL axcq901_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq901_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq901_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xcccld = g_xccc_m.xcccld 
         AND g_browser[l_i].b_xccc001 = g_xccc_m.xccc001 
         AND g_browser[l_i].b_xccc003 = g_xccc_m.xccc003 
         AND g_browser[l_i].b_xccc004 = g_xccc_m.xccc004 
         AND g_browser[l_i].b_xccc005 = g_xccc_m.xccc005 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser.getLength()
   #IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
   #   LET g_current_row = g_browser_cnt
   #END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq901_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xccc_m.* TO NULL
   CALL g_xccc_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外
   CALL g_xccc2_d.clear()
   CALL g_xccc3_d.clear()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccccomp,xccc004,xccc005,xccc003,xcccld,xccc001
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            CALL axcq901_default()
            #end add-point 
            
                 #此段落由子樣板a01產生
         BEFORE FIELD xccccomp
            #add-point:BEFORE FIELD xccccomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccccomp
            
            #add-point:AFTER FIELD xccccomp

            #END add-point
            
 
         #Ctrlp:construct.c.xccccomp
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s
            IF cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef003 = 'Y'"
            ELSE
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#9-e
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccccomp  #顯示到畫面上
            NEXT FIELD xccccomp                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004

            #END add-point
            
 
         #Ctrlp:construct.c.xccc004
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005

            #END add-point
            
 
         #Ctrlp:construct.c.xccc005
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc003
            #add-point:BEFORE FIELD xccc003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003

            #END add-point
            
 
         #Ctrlp:construct.c.xccc003
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc003  #顯示到畫面上
            NEXT FIELD xccc003                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcccld
            #add-point:BEFORE FIELD xcccld

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld

            #END add-point
            
 
         #Ctrlp:construct.c.xcccld
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#9-s
            #增加帳套過濾條件
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9-e
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcccld  #顯示到畫面上
            NEXT FIELD xcccld                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001

            #END add-point
            
 
         #Ctrlp:construct.c.xccc001
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001

            #END add-point
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccc002,xccc006,xccc007,xccc008,xccc901,xccc280,xccc902,xcag011, 
          xcag102
           FROM s_detail1[1].xccc002,s_detail1[1].xccc006,s_detail1[1].xccc007,s_detail1[1].xccc008, 
               s_detail1[1].xccc901,s_detail1[1].xccc280,s_detail1[1].xccc902,s_detail1[1].xcag011, 
               s_detail1[1].xcag102
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #此段落由子樣板a01產生
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccc002
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc002  #顯示到畫面上
            NEXT FIELD xccc002                     #返回原欄位
    
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc006
            #add-point:BEFORE FIELD xccc006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc006
            
            #add-point:AFTER FIELD xccc006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccc006
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc006  #顯示到畫面上
            NEXT FIELD xccc006                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc007
            #add-point:BEFORE FIELD xccc007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc007
            
            #add-point:AFTER FIELD xccc007

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccc007
         ON ACTION controlp INFIELD xccc007
            #add-point:ON ACTION controlp INFIELD xccc007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bmaa002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc007  #顯示到畫面上
            NEXT FIELD xccc007                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc008
            #add-point:BEFORE FIELD xccc008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc008
            
            #add-point:AFTER FIELD xccc008

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccc008
         ON ACTION controlp INFIELD xccc008
            #add-point:ON ACTION controlp INFIELD xccc008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc008  #顯示到畫面上
            NEXT FIELD xccc008                     #返回原欄位
    
            #END add-point
 
         #Ctrlp:construct.c.page1.xcbb005
         ON ACTION controlp INFIELD xcbb005
            #add-point:ON ACTION controlp INFIELD xcbb005
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbb005  #顯示到畫面上
            NEXT FIELD xcbb005                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcbb005
            #add-point:BEFORE FIELD xcbb005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbb005
            
            #add-point:AFTER FIELD xcbb005

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc901
            #add-point:BEFORE FIELD xccc901

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc901
            
            #add-point:AFTER FIELD xccc901

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccc901
         ON ACTION controlp INFIELD xccc901
            #add-point:ON ACTION controlp INFIELD xccc901

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc280
            #add-point:BEFORE FIELD xccc280

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc280
            
            #add-point:AFTER FIELD xccc280

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccc280
         ON ACTION controlp INFIELD xccc280
            #add-point:ON ACTION controlp INFIELD xccc280

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc902
            #add-point:BEFORE FIELD xccc902

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc902
            
            #add-point:AFTER FIELD xccc902

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccc902
         ON ACTION controlp INFIELD xccc902
            #add-point:ON ACTION controlp INFIELD xccc902

            #END add-point
 
         #Ctrlp:construct.c.page1.xcag011
         ON ACTION controlp INFIELD xcag011
            #add-point:ON ACTION controlp INFIELD xcag011
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcag011  #顯示到畫面上
            NEXT FIELD xcag011                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcag011
            #add-point:BEFORE FIELD xcag011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcag011
            
            #add-point:AFTER FIELD xcag011

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcag102
            #add-point:BEFORE FIELD xcag102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcag102
            
            #add-point:AFTER FIELD xcag102

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcag102
         ON ACTION controlp INFIELD xcag102
            #add-point:ON ACTION controlp INFIELD xcag102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD l_amt
            #add-point:BEFORE FIELD l_amt

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD l_amt
            
            #add-point:AFTER FIELD l_amt

            #END add-point
            
 
         #Ctrlp:construct.c.page1.l_amt
         ON ACTION controlp INFIELD l_amt
            #add-point:ON ACTION controlp INFIELD l_amt

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD l_diff
            #add-point:BEFORE FIELD l_diff

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD l_diff
            
            #add-point:AFTER FIELD l_diff

            #END add-point
            
 
         #Ctrlp:construct.c.page1.l_diff
         ON ACTION controlp INFIELD l_diff
            #add-point:ON ACTION controlp INFIELD l_diff

            #END add-point
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct
      CONSTRUCT BY NAME g_wc1 ON xcag001
       ON ACTION controlp INFIELD xcag001
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
          LET g_qryparam.reqry = FALSE
          CALL q_xcaa001()                           #呼叫開窗
          DISPLAY g_qryparam.return1 TO xcag001  #顯示到畫面上
          NEXT FIELD xcag001                     #返回原欄位
      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog

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
   
   #add-point:cs段after_construct

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
 
{<section id="axcq901.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq901_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point   
 
   #add-point:query開始前
   
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
   
   CALL axcq901_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axcq901_browser_fill(g_wc)
      CALL axcq901_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq901_browser_fill("F")
   
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
      CALL axcq901_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq901_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define

   #end add-point    
   
   #add-point:fetch段動作開始前

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
   
   #CALL axcq901_browser_fill(p_flag)
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
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
   LET g_xccc_m.xcag001 = g_browser[g_current_idx].b_xcag001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq901_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_xccc_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_dept =   
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq901_set_act_visible()
   CALL axcq901_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xccc_m_t.* = g_xccc_m.*
   LET g_xccc_m_o.* = g_xccc_m.*
   
   #重新顯示   
   CALL axcq901_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq901_insert()
   #add-point:insert段define
   
   #end add-point    
   
   #add-point:insert段before
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xccc_d.clear()
 
 
   INITIALIZE g_xccc_m.* LIKE xccc_t.*             #DEFAULT 設定
   LET g_xcccld_t = NULL
   LET g_xccc001_t = NULL
   LET g_xccc003_t = NULL
   LET g_xccc004_t = NULL
   LET g_xccc005_t = NULL
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值
      
      #end add-point 
 
      CALL axcq901_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xccc_m.* = g_xccc_m_t.*
         CALL axcq901_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccc_m.* TO NULL
         INITIALIZE g_xccc_d TO NULL
 
         CALL axcq901_show()
         RETURN
      END IF
    
      #CALL g_xccc_d.clear()
 
      
      #add-point:單頭輸入後2
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq901_set_act_visible()
   CALL axcq901_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcccent = '" ||g_enterprise|| "' AND",
                      " xcccld = '", g_xccc_m.xcccld CLIPPED, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001 CLIPPED, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003 CLIPPED, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004 CLIPPED, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq901_modify()
   #add-point:modify段define
   
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
   
   EXECUTE axcq901_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
 
   ERROR ""
  
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   CALL s_transaction_begin()
   
   OPEN axcq901_cl USING g_enterprise,g_xccc_m.xcccld
                                                       ,g_xccc_m.xccc001
                                                       ,g_xccc_m.xccc003
                                                       ,g_xccc_m.xccc004
                                                       ,g_xccc_m.xccc005
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq901_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE axcq901_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axcq901_cl INTO g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005, 
       g_xccc_m.xccc003,g_xccc_m.xcccc003_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.xccc001, 
       g_xccc_m.xcag001,g_xccc_m.xcag001_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xccc_m.xcccld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE axcq901_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq901_show()
   WHILE TRUE
      LET g_xcccld_t = g_xccc_m.xcccld
      LET g_xccc001_t = g_xccc_m.xccc001
      LET g_xccc003_t = g_xccc_m.xccc003
      LET g_xccc004_t = g_xccc_m.xccc004
      LET g_xccc005_t = g_xccc_m.xccc005
 
 
      #add-point:modify段修改前
      
      #end add-point
      
      CALL axcq901_input("u")     #欄位更改
      
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xccc_m.* = g_xccc_m_t.*
         CALL axcq901_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_xccc_m.xcccld != g_xcccld_t 
      OR g_xccc_m.xccc001 != g_xccc001_t 
      OR g_xccc_m.xccc003 != g_xccc003_t 
      OR g_xccc_m.xccc004 != g_xccc004_t 
      OR g_xccc_m.xccc005 != g_xccc005_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         
         #end add-point
         
         #更新單頭key值
         UPDATE xccc_t SET xcccld = g_xccc_m.xcccld
                                       , xccc001 = g_xccc_m.xccc001
                                       , xccc003 = g_xccc_m.xccc003
                                       , xccc004 = g_xccc_m.xccc004
                                       , xccc005 = g_xccc_m.xccc005
 
          WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
            AND xccc001 = g_xccc001_t
            AND xccc003 = g_xccc003_t
            AND xccc004 = g_xccc004_t
            AND xccc005 = g_xccc005_t
 
         #add-point:單頭(偽)修改中
         
         #end add-point
         
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccc_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
 
 
         
         #add-point:單頭(偽)修改後
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq901_set_act_visible()
   CALL axcq901_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcccent = '" ||g_enterprise|| "' AND",
                      " xcccld = '", g_xccc_m.xcccld CLIPPED, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001 CLIPPED, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003 CLIPPED, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004 CLIPPED, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005 CLIPPED, "' "
 
   #填到對應位置
   CALL axcq901_browser_fill("")
 
   CLOSE axcq901_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xccc_m.xcccld,'U')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq901.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq901_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num5                #未取消的ARRAY CNT 
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
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003, 
       g_xccc_m.xcccc003_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.xccc001,g_xccc_m.xcag001, 
       g_xccc_m.xcag001_desc
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT xccc002,xccc006,xccc007,xccc008,xccc901,xccc280,xccc902 FROM xccc_t WHERE  
       xcccent=? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=? AND xccc002=?  
       AND xccc006=? AND xccc007=? AND xccc008=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq901_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq901_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL axcq901_set_no_entry(p_cmd)
   #add-point:set_no_entry後
   
   #end add-point
 
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xcag001
   
   LET lb_reproduce = FALSE
   
   #add-point:進入修改段前
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq901.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003,g_xccc_m.xcccld, 
          g_xccc_m.xccc001,g_xccc_m.xcag001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前
            
            #end add-point
          
                  #此段落由子樣板a02產生
         AFTER FIELD xccccomp
            
            #add-point:AFTER FIELD xccccomp
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xccccomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xccccomp_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccccomp
            #add-point:BEFORE FIELD xccccomp
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccccomp
            #add-point:ON CHANGE xccccomp
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc004
            #add-point:ON CHANGE xccc004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc005
            #add-point:ON CHANGE xccc005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc003
            #add-point:BEFORE FIELD xccc003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc003
            #add-point:ON CHANGE xccc003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xcccld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xcccld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xcccld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcccld
            #add-point:BEFORE FIELD xcccld
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcccld
            #add-point:ON CHANGE xcccld
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc001
            #add-point:BEFORE FIELD xccc001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc001
            
            #add-point:AFTER FIELD xccc001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccc_m.xcccld) AND NOT cl_null(g_xccc_m.xccc001) AND NOT cl_null(g_xccc_m.xccc003) AND NOT cl_null(g_xccc_m.xccc004) AND NOT cl_null(g_xccc_m.xccc005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t  OR g_xccc_m.xccc001 != g_xccc001_t  OR g_xccc_m.xccc003 != g_xccc003_t  OR g_xccc_m.xccc004 != g_xccc004_t  OR g_xccc_m.xccc005 != g_xccc005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc001
            #add-point:ON CHANGE xccc001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcag001
            
            #add-point:AFTER FIELD xcag001
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xcag001
            CALL ap_ref_array2(g_ref_fields,"SELECT xcaal003 FROM xcaal_t WHERE xcaalent='"||g_enterprise||"' AND xcaal001=? AND xcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_m.xcag001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_m.xcag001_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcag001
            #add-point:BEFORE FIELD xcag001
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcag001
            #add-point:ON CHANGE xcag001
            
            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.xccccomp
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp
            
            #END add-point
 
         #Ctrlp:input.c.xccc004
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004
            
            #END add-point
 
         #Ctrlp:input.c.xccc005
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005
            
            #END add-point
 
         #Ctrlp:input.c.xccc003
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003
            
            #END add-point
 
         #Ctrlp:input.c.xcccld
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld
            
            #END add-point
 
         #Ctrlp:input.c.xccc001
         ON ACTION controlp INFIELD xccc001
            #add-point:ON ACTION controlp INFIELD xccc001
            
            #END add-point
 
         #Ctrlp:input.c.xcag001
         ON ACTION controlp INFIELD xcag001
            #add-point:ON ACTION controlp INFIELD xcag001
            
            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
 
            #多語言處理
            
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xccc_m.xcccld             
                            ,g_xccc_m.xccc001   
                            ,g_xccc_m.xccc003   
                            ,g_xccc_m.xccc004   
                            ,g_xccc_m.xccc005   
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               
               #end add-point
            
               UPDATE xccc_t SET (xccccomp,xccc004,xccc005,xccc003,xcccld,xccc001) = (g_xccc_m.xccccomp, 
                   g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003,g_xccc_m.xcccld,g_xccc_m.xccc001) 
 
                WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
                  AND xccc001 = g_xccc001_t
                  AND xccc003 = g_xccc003_t
                  AND xccc004 = g_xccc004_t
                  AND xccc005 = g_xccc005_t
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
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
               CALL axcq901_update_b('xccc_t',gs_keys,gs_keys_bak,"'1'")
                     
                     LET g_xcccld_t = g_xccc_m.xcccld
                     LET g_xccc001_t = g_xccc_m.xccc001
                     LET g_xccc003_t = g_xccc_m.xccc003
                     LET g_xccc004_t = g_xccc_m.xccc004
                     LET g_xccc005_t = g_xccc_m.xccc005
 
                     #add-point:單頭修改後
                     
                     #end add-point
                     
                     LET g_log1 = util.JSON.stringify(g_xccc_m_t)
                     LET g_log2 = util.JSON.stringify(g_xccc_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            
            ELSE    
               #add-point:單頭新增
               
               #end add-point
                                 
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq901_detail_reproduce()
               END IF
            END IF
           #controlp
                     
           LET g_xcccld_t = g_xccc_m.xcccld
           LET g_xccc001_t = g_xccc_m.xccc001
           LET g_xccc003_t = g_xccc_m.xccc003
           LET g_xccc004_t = g_xccc_m.xccc004
           LET g_xccc005_t = g_xccc_m.xccc005
 
           
           #若單身還沒有輸入資料, 強制切換至單身
           #IF cl_null(g_xccc_d[1].xccc002) THEN
           #   CALL g_xccc_d.deleteElement(1)
           #   NEXT FIELD xccc002
           #END IF
           
           IF g_xccc_d.getLength() = 0 THEN
              NEXT FIELD xccc002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq901.input.body" >}
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
 
            CALL axcq901_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq901_cl USING g_enterprise,
                                               g_xccc_m.xcccld
                                               ,g_xccc_m.xccc001
                                               ,g_xccc_m.xccc003
                                               ,g_xccc_m.xccc004
                                               ,g_xccc_m.xccc005
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq901_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axcq901_cl
                  CALL s_transaction_end('N','0')
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
               CALL axcq901_set_entry_b(l_cmd)
               #add-point:set_entry_b後
               
               #end add-point
               CALL axcq901_set_no_entry_b(l_cmd)
               OPEN axcq901_bcl USING g_enterprise,g_xccc_m.xcccld,
                                                g_xccc_m.xccc001,
                                                g_xccc_m.xccc003,
                                                g_xccc_m.xccc004,
                                                g_xccc_m.xccc005,
 
                                                g_xccc_d_t.xccc002
                                                ,g_xccc_d_t.xccc006
                                                ,g_xccc_d_t.xccc007
                                                ,g_xccc_d_t.xccc008
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq901_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq901_bcl INTO g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007, 
                      g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc902 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccc_d_t.xccc002 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axcq901_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xccc_d_t.* TO NULL
            INITIALIZE g_xccc_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccc_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xccc_d[l_ac].l_amt = "0"
      LET g_xccc_d[l_ac].l_diff = "0"
 
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_xccc_d_t.* = g_xccc_d[l_ac].*     #新輸入資料
            LET g_xccc_d_o.* = g_xccc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq901_set_entry_b(l_cmd)
            #add-point:set_entry_b後
            
            #end add-point
            CALL axcq901_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccc_d[li_reproduce_target].* = g_xccc_d[li_reproduce].*
 
               LET g_xccc_d[g_xccc_d.getLength()].xccc002 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc006 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc007 = NULL
               LET g_xccc_d[g_xccc_d.getLength()].xccc008 = NULL
 
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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xccc_t 
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
               #add-point:單身新增前
               
               #end add-point
               INSERT INTO xccc_t
                           (xcccent,
                            xccccomp,xccc004,xccc005,xccc003,xcccld,xccc001,
                            xccc002,xccc006,xccc007,xccc008
                            ,xccc901,xccc280,xccc902) 
                     VALUES(g_enterprise,
                            g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003,g_xccc_m.xcccld,g_xccc_m.xccc001,
                            g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008 
 
                            ,g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc902)
               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_xccc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前
               
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
               IF axcq901_before_delete() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq901_bcl
               LET l_count = g_xccc_d.getLength()
            END IF 
            
            #add-point:單身刪除後
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a02產生
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccc_m.xcccld IS NOT NULL AND g_xccc_m.xccc001 IS NOT NULL AND g_xccc_m.xccc003 IS NOT NULL AND g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc002 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc006 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc007 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t OR g_xccc_m.xccc001 != g_xccc001_t OR g_xccc_m.xccc003 != g_xccc003_t OR g_xccc_m.xccc004 != g_xccc004_t OR g_xccc_m.xccc005 != g_xccc005_t OR g_xccc_d[g_detail_idx].xccc002 != g_xccc_d_t.xccc002 OR g_xccc_d[g_detail_idx].xccc006 != g_xccc_d_t.xccc006 OR g_xccc_d[g_detail_idx].xccc007 != g_xccc_d_t.xccc007 OR g_xccc_d[g_detail_idx].xccc008 != g_xccc_d_t.xccc008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"' AND "|| "xccc002 = '"||g_xccc_d[g_detail_idx].xccc002 ||"' AND "|| "xccc006 = '"||g_xccc_d[g_detail_idx].xccc006 ||"' AND "|| "xccc007 = '"||g_xccc_d[g_detail_idx].xccc007 ||"' AND "|| "xccc008 = '"||g_xccc_d[g_detail_idx].xccc008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccc_m.xccccomp
            LET g_ref_fields[2] = g_xccc_d[l_ac].xccc002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccc_d[l_ac].xccc002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccc_d[l_ac].xccc002_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccc002
            #add-point:ON CHANGE xccc002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc006
            
            #add-point:AFTER FIELD xccc006
            #此段落由子樣板a05產生
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
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc006
            #add-point:BEFORE FIELD xccc006
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccc006
            #add-point:ON CHANGE xccc006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc007
            #add-point:BEFORE FIELD xccc007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc007
            
            #add-point:AFTER FIELD xccc007
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccc_m.xcccld IS NOT NULL AND g_xccc_m.xccc001 IS NOT NULL AND g_xccc_m.xccc003 IS NOT NULL AND g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc002 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc006 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc007 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t OR g_xccc_m.xccc001 != g_xccc001_t OR g_xccc_m.xccc003 != g_xccc003_t OR g_xccc_m.xccc004 != g_xccc004_t OR g_xccc_m.xccc005 != g_xccc005_t OR g_xccc_d[g_detail_idx].xccc002 != g_xccc_d_t.xccc002 OR g_xccc_d[g_detail_idx].xccc006 != g_xccc_d_t.xccc006 OR g_xccc_d[g_detail_idx].xccc007 != g_xccc_d_t.xccc007 OR g_xccc_d[g_detail_idx].xccc008 != g_xccc_d_t.xccc008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"' AND "|| "xccc002 = '"||g_xccc_d[g_detail_idx].xccc002 ||"' AND "|| "xccc006 = '"||g_xccc_d[g_detail_idx].xccc006 ||"' AND "|| "xccc007 = '"||g_xccc_d[g_detail_idx].xccc007 ||"' AND "|| "xccc008 = '"||g_xccc_d[g_detail_idx].xccc008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc007
            #add-point:ON CHANGE xccc007
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc008
            #add-point:BEFORE FIELD xccc008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc008
            
            #add-point:AFTER FIELD xccc008
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccc_m.xcccld IS NOT NULL AND g_xccc_m.xccc001 IS NOT NULL AND g_xccc_m.xccc003 IS NOT NULL AND g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc002 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc006 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc007 IS NOT NULL AND g_xccc_d[g_detail_idx].xccc008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccc_m.xcccld != g_xcccld_t OR g_xccc_m.xccc001 != g_xccc001_t OR g_xccc_m.xccc003 != g_xccc003_t OR g_xccc_m.xccc004 != g_xccc004_t OR g_xccc_m.xccc005 != g_xccc005_t OR g_xccc_d[g_detail_idx].xccc002 != g_xccc_d_t.xccc002 OR g_xccc_d[g_detail_idx].xccc006 != g_xccc_d_t.xccc006 OR g_xccc_d[g_detail_idx].xccc007 != g_xccc_d_t.xccc007 OR g_xccc_d[g_detail_idx].xccc008 != g_xccc_d_t.xccc008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccc_t WHERE "||"xcccent = '" ||g_enterprise|| "' AND "||"xcccld = '"||g_xccc_m.xcccld ||"' AND "|| "xccc001 = '"||g_xccc_m.xccc001 ||"' AND "|| "xccc003 = '"||g_xccc_m.xccc003 ||"' AND "|| "xccc004 = '"||g_xccc_m.xccc004 ||"' AND "|| "xccc005 = '"||g_xccc_m.xccc005 ||"' AND "|| "xccc002 = '"||g_xccc_d[g_detail_idx].xccc002 ||"' AND "|| "xccc006 = '"||g_xccc_d[g_detail_idx].xccc006 ||"' AND "|| "xccc007 = '"||g_xccc_d[g_detail_idx].xccc007 ||"' AND "|| "xccc008 = '"||g_xccc_d[g_detail_idx].xccc008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc008
            #add-point:ON CHANGE xccc008
            
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
         BEFORE FIELD xccc901
            #add-point:BEFORE FIELD xccc901
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc901
            
            #add-point:AFTER FIELD xccc901
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc901
            #add-point:ON CHANGE xccc901
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc280
            #add-point:BEFORE FIELD xccc280
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc280
            
            #add-point:AFTER FIELD xccc280
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc280
            #add-point:ON CHANGE xccc280
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccc902
            #add-point:BEFORE FIELD xccc902
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccc902
            
            #add-point:AFTER FIELD xccc902
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccc902
            #add-point:ON CHANGE xccc902
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcag011
            #add-point:BEFORE FIELD xcag011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcag011
            
            #add-point:AFTER FIELD xcag011
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcag011
            #add-point:ON CHANGE xcag011
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcag102
            #add-point:BEFORE FIELD xcag102
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcag102
            
            #add-point:AFTER FIELD xcag102
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcag102
            #add-point:ON CHANGE xcag102
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD l_amt
            #add-point:BEFORE FIELD l_amt
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD l_amt
            
            #add-point:AFTER FIELD l_amt
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE l_amt
            #add-point:ON CHANGE l_amt
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD l_diff
            #add-point:BEFORE FIELD l_diff
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD l_diff
            
            #add-point:AFTER FIELD l_diff
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE l_diff
            #add-point:ON CHANGE l_diff
            
            #END add-point
 
 
                  #Ctrlp:input.c.page1.xccc002
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002
            
            #END add-point
 
         #Ctrlp:input.c.page1.xccc006
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006
            
            #END add-point
 
         #Ctrlp:input.c.page1.xccc007
         ON ACTION controlp INFIELD xccc007
            #add-point:ON ACTION controlp INFIELD xccc007
            
            #END add-point
 
         #Ctrlp:input.c.page1.xccc008
         ON ACTION controlp INFIELD xccc008
            #add-point:ON ACTION controlp INFIELD xccc008
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcbb005
         ON ACTION controlp INFIELD xcbb005
            #add-point:ON ACTION controlp INFIELD xcbb005
            
            #END add-point
 
         #Ctrlp:input.c.page1.xccc901
         ON ACTION controlp INFIELD xccc901
            #add-point:ON ACTION controlp INFIELD xccc901
            
            #END add-point
 
         #Ctrlp:input.c.page1.xccc280
         ON ACTION controlp INFIELD xccc280
            #add-point:ON ACTION controlp INFIELD xccc280
            
            #END add-point
 
         #Ctrlp:input.c.page1.xccc902
         ON ACTION controlp INFIELD xccc902
            #add-point:ON ACTION controlp INFIELD xccc902
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcag011
         ON ACTION controlp INFIELD xcag011
            #add-point:ON ACTION controlp INFIELD xcag011
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcag102
         ON ACTION controlp INFIELD xcag102
            #add-point:ON ACTION controlp INFIELD xcag102
            
            #END add-point
 
         #Ctrlp:input.c.page1.l_amt
         ON ACTION controlp INFIELD l_amt
            #add-point:ON ACTION controlp INFIELD l_amt
            
            #END add-point
 
         #Ctrlp:input.c.page1.l_diff
         ON ACTION controlp INFIELD l_diff
            #add-point:ON ACTION controlp INFIELD l_diff
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xccc_d[l_ac].* = g_xccc_d_t.*
               CLOSE axcq901_bcl
               CALL s_transaction_end('N','0')
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
               
            
               #add-point:單身修改前
               
               #end add-point
         
               UPDATE xccc_t SET (xcccld,xccc001,xccc003,xccc004,xccc005,xccc002,xccc006,xccc007,xccc008, 
                   xccc901,xccc280,xccc902) = (g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
                   g_xccc_m.xccc005,g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007, 
                   g_xccc_d[l_ac].xccc008,g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc902) 
 
                WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld 
                 AND xccc001 = g_xccc_m.xccc001 
                 AND xccc003 = g_xccc_m.xccc003 
                 AND xccc004 = g_xccc_m.xccc004 
                 AND xccc005 = g_xccc_m.xccc005 
 
                 AND xccc002 = g_xccc_d_t.xccc002 #項次   
                 AND xccc006 = g_xccc_d_t.xccc006  
                 AND xccc007 = g_xccc_d_t.xccc007  
                 AND xccc008 = g_xccc_d_t.xccc008  
 
                 
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
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
               CALL axcq901_update_b('xccc_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccc_m),util.JSON.stringify(g_xccc_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後
               
               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccc_d.getLength() = 0 THEN
               NEXT FIELD xccc002
            END IF
            #add-point:input段after input 
            
            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xccc_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xccc_d.getLength()+1
            
      END INPUT
 
 
      
 
      
 
      
 
      
      #add-point:input段more_input
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog
         IF p_cmd = 'a' THEN
            NEXT FIELD xcccld
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccc002
               WHEN "s_detail2"
                  NEXT FIELD xccc002_2
               WHEN "s_detail3"
                  NEXT FIELD xcdc002
 
            END CASE
         END IF
         #end add-point 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcccld
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccc002
 
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
   
   #add-point:input段after_input
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq901_show()
   #add-point:show段define
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   #end add-point
   
   #add-point:show段之前
   IF cl_null(g_xccc_m.xccccomp) THEN
       CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
       CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
    ELSE
       CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
       CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
    END IF
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc,xcdc002,xcdc002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc,xcdc002,xcdc002_desc',FALSE)                
   END IF 
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否            
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccc007,xccc007_2,xcdc007',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccc007,xccc007_2,xcdc007',FALSE)                
   END IF   
   CALL axcq901_ref()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq901_b_fill(g_wc2) #單身填充
      CALL axcq901_b_fill2('0') #單身填充
   END IF
   
   
 
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL axcq901_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003, 
       g_xccc_m.xcccc003_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.xccc001,g_xccc_m.xcag001, 
       g_xccc_m.xcag001_desc,g_xccc_m.xccc001_desc
   CALL axcq901_b_fill(g_wc2_table1)                 #單身
   CALL axcq901_b_fill2('0') #單身填充
 
   CALL axcq901_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
  #DISPLAY g_xccc_d.getLength() TO FORMONLY.cnt
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq901_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xccc_d.getLength()
      #add-point:ref_show段d_reference
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq901_reproduce()
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
 
   DEFINE l_master    RECORD LIKE xccc_t.*
   DEFINE l_detail    RECORD LIKE xccc_t.*
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
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
 
    
   CALL axcq901_set_entry('a')
   CALL axcq901_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   CALL axcq901_input("r")
   
      LET g_xccc_m.xcccld_desc = ''
   DISPLAY BY NAME g_xccc_m.xcccld_desc
 
    
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xccc_m.* TO NULL
      INITIALIZE g_xccc_d TO NULL
 
      CALL axcq901_show()
      LET INT_FLAG = 0
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq901_set_act_visible()
   CALL axcq901_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcccent = '" ||g_enterprise|| "' AND",
                      " xcccld = '", g_xccc_m.xcccld CLIPPED, "' "
                      ," AND xccc001 = '", g_xccc_m.xccc001 CLIPPED, "' "
                      ," AND xccc003 = '", g_xccc_m.xccc003 CLIPPED, "' "
                      ," AND xccc004 = '", g_xccc_m.xccc004 CLIPPED, "' "
                      ," AND xccc005 = '", g_xccc_m.xccc005 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq901_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq901_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xccc_t.*
 
 
   #add-point:delete段define
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq901_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq901_detail AS ",
                "SELECT * FROM xccc_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axcq901_detail SELECT * FROM xccc_t 
                                         WHERE xcccent = g_enterprise AND xcccld = g_xcccld_t
                                         AND xccc001 = g_xccc001_t
                                         AND xccc003 = g_xccc003_t
                                         AND xccc004 = g_xccc004_t
                                         AND xccc005 = g_xccc005_t
 
   
   #將key修正為調整後   
   UPDATE axcq901_detail 
      #更新key欄位
      SET xcccld = g_xccc_m.xcccld
          , xccc001 = g_xccc_m.xccc001
          , xccc003 = g_xccc_m.xccc003
          , xccc004 = g_xccc_m.xccc004
          , xccc005 = g_xccc_m.xccc005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xccc_t SELECT * FROM axcq901_detail
   
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
   DROP TABLE axcq901_detail
   
   #add-point:單身複製後1
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcccld_t = g_xccc_m.xcccld
   LET g_xccc001_t = g_xccc_m.xccc001
   LET g_xccc003_t = g_xccc_m.xccc003
   LET g_xccc004_t = g_xccc_m.xccc004
   LET g_xccc005_t = g_xccc_m.xccc005
 
   
   DROP TABLE axcq901_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq901_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
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
 
   EXECUTE axcq901_master_referesh USING g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004, 
       g_xccc_m.xccc005 INTO g_xccc_m.xccccomp,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003,g_xccc_m.xcccld, 
       g_xccc_m.xccc001,g_xccc_m.xccccomp_desc,g_xccc_m.xcccld_desc
   
   CALL axcq901_show()
   
   CALL s_transaction_begin()
   
   
 
   OPEN axcq901_cl USING g_enterprise,g_xccc_m.xcccld
                                                       ,g_xccc_m.xccc001
                                                       ,g_xccc_m.xccc003
                                                       ,g_xccc_m.xccc004
                                                       ,g_xccc_m.xccc005
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq901_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE axcq901_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axcq901_cl INTO g_xccc_m.xccccomp,g_xccc_m.xccccomp_desc,g_xccc_m.xccc004,g_xccc_m.xccc005, 
       g_xccc_m.xccc003,g_xccc_m.xcccc003_desc,g_xccc_m.xcccld,g_xccc_m.xcccld_desc,g_xccc_m.xccc001, 
       g_xccc_m.xcag001,g_xccc_m.xcag001_desc
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xccc_m.xcccld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL axcq901_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
  
 
      #add-point:單身刪除前
      
      #end add-point
      
      DELETE FROM xccc_t WHERE xcccent = g_enterprise AND xcccld = g_xccc_m.xcccld
                                                               AND xccc001 = g_xccc_m.xccc001
                                                               AND xccc003 = g_xccc_m.xccc003
                                                               AND xccc004 = g_xccc_m.xccc004
                                                               AND xccc005 = g_xccc_m.xccc005
 
                                                               
      #add-point:單身刪除中
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      
      #end add-point
      
 
      
      CLEAR FORM
      CALL g_xccc_d.clear() 
 
     
      CALL axcq901_ui_browser_refresh()  
      #CALL axcq901_ui_headershow()  
      #CALL axcq901_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq901_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq901_browser_fill("F")
         CLEAR FORM
      END IF
       
   END IF
 
   CLOSE axcq901_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_xccc_m.xcccld,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq901.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq901_b_fill(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   DEFINE l_glaa003  LIKE glaa_t.glaa003
   DEFINE l_bdate    DATE
   DEFINE l_edate    DATE
   DEFINE l_xccc902_sum1   LIKE xccc_t.xccc902
   DEFINE l_amt_sum1       LIKE xccc_t.xccc902
   DEFINE l_diff_sum1      LIKE xccc_t.xccc902
   DEFINE l_xccc902_total1 LIKE xccc_t.xccc902
   DEFINE l_amt_total1     LIKE xccc_t.xccc902
   DEFINE l_diff_total1    LIKE xccc_t.xccc902
   DEFINE l_xcag002        LIKE xcag_t.xcag002
   #end add-point     
 
   #先清空單身變數內容
   CALL g_xccc_d.clear()
 
 
   #add-point:b_fill段sql_before
   IF g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL THEN      
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xccc_m.xccccomp
         AND glaa014  = 'Y' 

     CALL s_fin_date_get_period_range(l_glaa003,g_xccc_m.xccc004,g_xccc_m.xccc005) RETURNING l_bdate,l_edate
   END IF
   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,xccc280,xccc902,t1.xcbfl003 , 
       t2.imaal003 ,t3.imaal004 FROM xccc_t",   
               "",
               
                              " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbflcomp=xccccomp AND t1.xcbfl001=xccc002 AND t1.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xccc006 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xccc006 AND t3.imaal002='"||g_dlang||"' ",
 
               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
   END IF
   
   #add-point:b_fill段sql_after
   #160520-00003#13 add-S
   LET g_sql = "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,xccc280,xccc902,",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ,",
               "(SELECT xcbb005 FROM xcbb_t WHERE rownum = 1 AND xcbbent = xcccent AND xcbbcomp = xccccomp AND xcbb001 = xccc004 AND xcbb002 = xccc005 AND xcbb003 = xccc006) t3_xcbb005,",
               "(SELECT DISTINCT xcag011  FROM xcag_t ",
               "  WHERE xcagent = xcccent ",
               "    AND rownum = 1 ",
               "    AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "    AND xcag004 = xccc006 ",
               "    AND xcag002 = (SELECT MAX(xcag002) FROM xcag_t ",
               "                    WHERE xcagent = xcccent ",
               "                      AND xcagcomp = xccccomp ",
               "                      AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "                      AND xcag004 = xccc006",
               "                      AND xcag002 <= '",l_edate,"'",
               "                      AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"'))",
               "     AND (xcag003 IS NULL OR xcag003 = (SELECT MIN(xcag003) FROM xcag_t ",
               "             WHERE xcagent = xcccent ",
               "               AND xcagcomp = xccccomp ",
               "              AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "               AND xcag004 = xccc006 ",
               "               AND xcag002 <= '",l_edate,"'",
               "               AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"')))",
               "     AND xcag002 <= '",l_edate,"'",
               "     AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"'))t4_xcag011,",
               "(SELECT DISTINCT xcag102  FROM xcag_t ",
               "  WHERE xcagent = xcccent ",
               "    AND rownum = 1 ",
               "    AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "    AND xcag004 = xccc006 ",
               "    AND xcag002 = (SELECT MAX(xcag002) FROM xcag_t ",
               "                    WHERE xcagent = xcccent ",
               "                      AND xcagcomp = xccccomp ",
               "                      AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "                      AND xcag004 = xccc006",
               "                      AND xcag002 <= '",l_edate,"'",
               "                      AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"'))",
               "     AND (xcag003 IS NULL OR xcag003 = (SELECT MIN(xcag003) FROM xcag_t ",
               "             WHERE xcagent = xcccent ",
               "               AND xcagcomp = xccccomp ",
               "               AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "               AND xcag004 = xccc006 ",
               "               AND xcag002 <= '",l_edate,"'",
               "               AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"')))",
               "     AND xcag002 <= '",l_edate,"'",
               "     AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"'))t4_xcag102",
               " FROM xccc_t",   
               " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=?"  
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccc_t")
   END IF
   #160520-00003#13 add-E
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq901_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xccc_t.xccc002,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"
      
      #add-point:b_fill段fill_before
      LET g_sql=cl_replace_str(g_sql," ORDER BY xccc_t.xccc002,xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008"," ORDER BY xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008,xccc_t.xccc002")
      LET l_xccc902_sum1 = 0
      LET l_amt_sum1 = 0
      LET l_diff_sum1 = 0
      LET l_xccc902_total1 = 0
      LET l_amt_total1 = 0
      LET l_diff_total1 = 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq901_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR axcq901_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005
                                               
      FOREACH b_fill_cs INTO g_xccc_d[l_ac].xccc002,g_xccc_d[l_ac].xccc006,g_xccc_d[l_ac].xccc007,g_xccc_d[l_ac].xccc008, 
          g_xccc_d[l_ac].xccc901,g_xccc_d[l_ac].xccc280,g_xccc_d[l_ac].xccc902,g_xccc_d[l_ac].xccc002_desc, 
          g_xccc_d[l_ac].xccc006_desc,g_xccc_d[l_ac].xccc006_desc_desc,
          g_xccc_d[l_ac].xcbb005,g_xccc_d[l_ac].xcag011,g_xccc_d[l_ac].xcag102   #160520-00003#13 add
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         #160520-00003#13 marked-S-组到主sql中
#         #成本单位
#         SELECT xcbb005 INTO g_xccc_d[l_ac].xcbb005 FROM xcbb_t
#          WHERE xcbbent  = g_enterprise
#            AND xcbbcomp = g_xccc_m.xccccomp
#            AND xcbb001  = g_xccc_m.xccc004
#            AND xcbb002  = g_xccc_m.xccc005
#            AND xcbb003  = g_xccc_d[l_ac].xccc006         
         #標準幣別+單位成本
#         #按月底的时间去抓，月底要在有效期内
#         SELECT DISTINCT xcag011,xcag102 INTO g_xccc_d[l_ac].xcag011,g_xccc_d[l_ac].xcag102 FROM xcag_t
#          WHERE xcagent = g_enterprise
#            AND xcagcomp = g_xccc_m.xccccomp
#            AND xcag001 = g_xccc_m.xcag001
#            AND xcag004 = g_xccc_d[l_ac].xccc006
#            AND xcag002 = (SELECT MAX(xcag002) FROM xcag_t 
#                            WHERE xcagent = g_enterprise
#                              AND xcagcomp = g_xccc_m.xccccomp
#                              AND xcag001 = g_xccc_m.xcag001
#                              AND xcag004 = g_xccc_d[l_ac].xccc006
#                              AND xcag002 <= l_edate
#                              AND (xcag003 IS NULL OR xcag003 >= l_edate)) 
#            AND (xcag003 IS NULL OR xcag003 = (SELECT MIN(xcag003) FROM xcag_t 
#                            WHERE xcagent = g_enterprise
#                              AND xcagcomp = g_xccc_m.xccccomp
#                              AND xcag001 = g_xccc_m.xcag001
#                              AND xcag004 = g_xccc_d[l_ac].xccc006
#                              AND xcag002 <= l_edate
#                              AND (xcag003 IS NULL OR xcag003 >= l_edate)))                  
#            AND xcag002 <= l_edate
#            AND (xcag003 IS NULL OR xcag003 >= l_edate)
         #160520-00003#13 marked-E
         IF cl_null(g_xccc_d[l_ac].xcag102) THEN LET g_xccc_d[l_ac].xcag102 = 0 END IF
         LET g_xccc_d[l_ac].l_amt = g_xccc_d[l_ac].xcag102 * g_xccc_d[l_ac].xccc901
         LET g_xccc_d[l_ac].l_diff = g_xccc_d[l_ac].xccc902 - g_xccc_d[l_ac].l_amt
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取
         LET l_xccc902_total1 =l_xccc902_total1 + g_xccc_d[l_ac].xccc902 
         LET l_amt_total1 = l_amt_total1 + g_xccc_d[l_ac].l_amt
         LET l_diff_total1 = l_diff_total1 + g_xccc_d[l_ac].l_diff
         #按料号＋特性＋批号 小计
         LET l_xccc902_sum1 =l_xccc902_sum1 + g_xccc_d[l_ac].xccc902 
         LET l_amt_sum1 = l_amt_sum1 + g_xccc_d[l_ac].l_amt
         LET l_diff_sum1 = l_diff_sum1 + g_xccc_d[l_ac].l_diff
         IF l_ac > 1 THEN  
            IF g_xccc_d[l_ac].xccc006 != g_xccc_d[l_ac - 1].xccc006 OR 
               g_xccc_d[l_ac].xccc007 != g_xccc_d[l_ac - 1].xccc007 OR 
               g_xccc_d[l_ac].xccc008 != g_xccc_d[l_ac - 1].xccc008
               THEN #前两行相同 则此处为第三行
               #把当前行下移，并在当前行显示小计
               LET g_xccc_d[l_ac + 1].* = g_xccc_d[l_ac].*   
               INITIALIZE  g_xccc_d[l_ac].* TO NULL
               #LET g_xccc_d[l_ac].xccc008 = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
               LET g_xccc_d[l_ac].xccc006_desc_desc = g_xccc_d[l_ac - 1].xccc008,cl_getmsg("axc-00205",g_lang) #151029-00010#1 151029 By pomelo add
               LET g_xccc_d[l_ac].xccc902 = l_xccc902_sum1 - g_xccc_d[l_ac + 1].xccc902   
               LET g_xccc_d[l_ac].l_amt = l_amt_sum1 - g_xccc_d[l_ac + 1].l_amt    
               LET g_xccc_d[l_ac].l_diff = l_diff_sum1 - g_xccc_d[l_ac + 1].l_diff                  
               LET l_ac = l_ac + 1
               LET l_xccc902_sum1 = g_xccc_d[l_ac].xccc902
               LET l_amt_sum1 = g_xccc_d[l_ac].l_amt
               LET l_diff_sum1 = g_xccc_d[l_ac].l_diff               
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
 
            CALL g_xccc_d.deleteElement(g_xccc_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
   IF l_ac > 1 THEN
      #最后一组小计
      #LET g_xccc_d[l_ac].xccc008 = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
      LET g_xccc_d[l_ac].xccc006_desc_desc = g_xccc_d[l_ac - 1].xccc008,cl_getmsg("axc-00205",g_lang) #151029-00010#1 151029 By pomelo add
      LET g_xccc_d[l_ac].xccc902 = l_xccc902_sum1
      LET g_xccc_d[l_ac].l_amt = l_amt_sum1
      LET g_xccc_d[l_ac].l_diff = l_diff_sum1
      LET l_ac = l_ac + 1
      #合计      
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      IF g_para_data = 'Y' THEN
         LET g_xccc_d[l_ac].xccc002 = cl_getmsg("axc-00204",g_lang)                    
      ELSE
         LET g_xccc_d[l_ac].xccc006 = cl_getmsg("axc-00204",g_lang)                
      END IF
      LET g_xccc_d[l_ac].xccc902 = l_xccc902_total1
      LET g_xccc_d[l_ac].l_amt = l_amt_total1
      LET g_xccc_d[l_ac].l_diff = l_diff_total1
      LET l_ac = l_ac + 1
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axcq901_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq901_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   #add-point:b_fill2段define
  
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
   CALL axcq901_b_fill_2()
   CALL axcq901_b_fill_3()
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq901_before_delete()
   #add-point:before_delete段define
   
   #end add-point 
   
   #add-point:單筆刪除前
   
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
 
      
   #add-point:單筆刪除中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="axcq901.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq901_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq901_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq901_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
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
   
 
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq901_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL axcq901_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq901_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq901_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcccld,xccc001,xccc003,xccc004,xccc005",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq901_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcccld,xccc001,xccc003,xccc004,xccc005",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq901_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq901_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   
   #add-point:set_no_entry_b段
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq901_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq901.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq901_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq901.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq901_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point
   #add-point:set_act_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq901.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq901_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point
   #add-point:set_act_no_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq901.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq901_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
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
 
   
   #add-point:default_search段after sql
   
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
   
   #add-point:default_search段結束前
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq901_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
 
 
   
   #add-point:fill_chk段other
   
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq901.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq901_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xccc002"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq901.state_change" >}
    
 
{</section>}
 
{<section id="axcq901.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION axcq901_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
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
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axcq901.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq901_b_fill_2()
   DEFINE l_glaa003  LIKE glaa_t.glaa003
   DEFINE l_bdate    DATE
   DEFINE l_edate    DATE
   DEFINE l_xccc902a_sum1   LIKE xccc_t.xccc902a
   DEFINE l_amt_2_sum1       LIKE xccc_t.xccc902a
   DEFINE l_diff_2_sum1      LIKE xccc_t.xccc902a
   DEFINE l_xccc902a_total1 LIKE xccc_t.xccc902a
   DEFINE l_amt_2_total1     LIKE xccc_t.xccc902a
   DEFINE l_diff_2_total1    LIKE xccc_t.xccc902a
   #end add-point     
 
   #先清空單身變數內容
   CALL g_xccc2_d.clear()
   
 
   #add-point:b_fill段sql_before
   IF g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL THEN      
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xccc_m.xccccomp
         AND glaa014  = 'Y' 

     CALL s_fin_date_get_period_range(l_glaa003,g_xccc_m.xccc004,g_xccc_m.xccc005) RETURNING l_bdate,l_edate
   END IF
   #end add-point
   

   LET g_sql_sub = #160520-00003#13 marked-S
                   #" LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbflcomp=xccccomp AND t1.xcbfl001=xccc002 AND t1.xcbfl002='"||g_dlang||"' ",
                   #" LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xccc006 AND t2.imaal002='"||g_dlang||"' ",
                   #" LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xccc006 AND t3.imaal002='"||g_dlang||"' ",
                   #160520-00003#13 marked-E
                   " INNER JOIN xcag_t t4 ON t4.xcagent=xcccent AND t4.xcagcomp=xccccomp AND t4.xcag004 = xccc006 ",
                   "                     AND t4.xcag002 <= '",l_edate,"' AND (t4.xcag003 IS NULL OR t4.xcag003 > = '",l_edate,"')",
                   "                     AND t4.xcag002 = (SELECT MAX(xcag002) FROM xcag_t                                          ",
                   "                                        WHERE xcagent = t4.xcagent   ",
                   "                                          AND xcagcomp =t4.xcagcomp  ",
                   "                                          AND xcag001 = t4.xcag001   ",
                   "                                          AND xcag004 = t4.xcag004   ",
                   "                                          AND xcag002 <= '",l_edate,"'",
                   "                                          AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"')) ",
                   "                     AND (t4.xcag003 = (SELECT MIN(xcag003) FROM xcag_t                                          ",
                   "                                         WHERE xcagent = t4.xcagent   ",
                   "                                           AND xcagcomp =t4.xcagcomp  ",
                   "                                           AND xcag001 = t4.xcag001   ",
                   "                                           AND xcag004 = t4.xcag004   ",
                   "                                           AND xcag002 <= '",l_edate,"'",
                   "                                           AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"')) ", 
                   "                          OR t4.xcag003 IS NULL )   ",                   
                   " WHERE xcccent= ? AND xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=? AND t4.xcag001 = ?  "
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql_sub = g_sql_sub CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   #160520-00003#13 marked-S
#   LET g_sql = "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'1',COALESCE(xccc280a,0),COALESCE(xccc902a,0),xcag011,COALESCE(xcag102a,0),                
#                t1.xcbfl003,t2.imaal003 ,t3.imaal004 FROM xccc_t", 
#                g_sql_sub," UNION ALL ",
#               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'2',COALESCE(xccc280b,0),COALESCE(xccc902b,0),xcag011,COALESCE(xcag102b,0),
#                t1.xcbfl003,t2.imaal003 ,t3.imaal004 FROM xccc_t",
#                 g_sql_sub," UNION ALL ",
#               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'3',COALESCE(xccc280c,0),COALESCE(xccc902c,0),xcag011,COALESCE(xcag102c,0),
#                t1.xcbfl003,t2.imaal003 ,t3.imaal004 FROM xccc_t",
#                 g_sql_sub," UNION ALL ",
#               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'4',COALESCE(xccc280d,0),COALESCE(xccc902d,0),xcag011,COALESCE(xcag102d,0),
#                t1.xcbfl003,t2.imaal003 ,t3.imaal004 FROM xccc_t",
#                 g_sql_sub," UNION ALL ",
#               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'5',COALESCE(xccc280e,0),COALESCE(xccc902e,0),xcag011,COALESCE(xcag102e,0),
#                t1.xcbfl003,t2.imaal003 ,t3.imaal004 FROM xccc_t",
#                 g_sql_sub," UNION ALL ",
#               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'6',COALESCE(xccc280f,0),COALESCE(xccc902f,0),xcag011,COALESCE(xcag102f,0),
#                t1.xcbfl003,t2.imaal003 ,t3.imaal004 FROM xccc_t",
#                 g_sql_sub," UNION ALL ",
#               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'7',COALESCE(xccc280g,0),COALESCE(xccc902g,0),xcag011,COALESCE(xcag102g,0),
#                t1.xcbfl003,t2.imaal003 ,t3.imaal004 FROM xccc_t",
#                 g_sql_sub," UNION ALL ",
#               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'8',COALESCE(xccc280h,0),COALESCE(xccc902h,0),xcag011,COALESCE(xcag102h,0),
#                t1.xcbfl003,t2.imaal003 ,t3.imaal004 FROM xccc_t",
#                 g_sql_sub
   #160520-00003#13 marked-E
   #160520-00003#13 mod-S
   LET g_sql = "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'1',COALESCE(xccc280a,0),COALESCE(xccc902a,0),xcag011,COALESCE(xcag102a,0),",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ",
               " FROM xccc_t ", 
                g_sql_sub," UNION ALL ",
               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'2',COALESCE(xccc280b,0),COALESCE(xccc902b,0),xcag011,COALESCE(xcag102b,0),",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ",
                " FROM xccc_t ", 
                 g_sql_sub," UNION ALL ",
               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'3',COALESCE(xccc280c,0),COALESCE(xccc902c,0),xcag011,COALESCE(xcag102c,0),",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ",
               " FROM xccc_t ", 
                 g_sql_sub," UNION ALL ",
               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'4',COALESCE(xccc280d,0),COALESCE(xccc902d,0),xcag011,COALESCE(xcag102d,0),",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ",
               " FROM xccc_t ", 
                 g_sql_sub," UNION ALL ",
               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'5',COALESCE(xccc280e,0),COALESCE(xccc902e,0),xcag011,COALESCE(xcag102e,0),",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ",
               " FROM xccc_t ", 
                 g_sql_sub," UNION ALL ",
               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'6',COALESCE(xccc280f,0),COALESCE(xccc902f,0),xcag011,COALESCE(xcag102f,0),",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ",
               " FROM xccc_t ", 
                 g_sql_sub," UNION ALL ",
               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'7',COALESCE(xccc280g,0),COALESCE(xccc902g,0),xcag011,COALESCE(xcag102g,0),",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ",
               " FROM xccc_t ", 
                 g_sql_sub," UNION ALL ",
               "SELECT  UNIQUE xccc002,xccc006,xccc007,xccc008,xccc901,'8',COALESCE(xccc280h,0),COALESCE(xccc902h,0),xcag011,COALESCE(xcag102h,0),",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xccccomp AND xcbfl001 = xccc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcccent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xccc006 AND imaalent = xcccent AND imaal002 = '"||g_dlang||"')t2_imaal004 ",
               " FROM xccc_t ", 
                 g_sql_sub   
   #160520-00003#13 mod-E                 
   #add-point:b_fill段sql_after
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq901_fill_chk(1) THEN
     #LET g_sql = g_sql, " ORDER BY xccc_t.xccc006,xccc_t.xccc007,xccc_t.xccc008,xccc_t.xccc002"
      LET g_sql = g_sql, "ORDER BY 2,3,4,6"
      #add-point:b_fill段fill_before      
      LET l_xccc902a_sum1 = 0
      LET l_amt_2_sum1 = 0
      LET l_diff_2_sum1 = 0
      LET l_xccc902a_total1 = 0
      LET l_amt_2_total1 = 0
      LET l_diff_2_total1 = 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq901_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR axcq901_pb2
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcag001,
                            g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcag001,
                            g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcag001,
                            g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcag001,
                            g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcag001,
                            g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcag001,
                            g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcag001,
                            g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xcag001
                            
                                               
      FOREACH b_fill_cs2 INTO g_xccc2_d[l_ac].xccc002,g_xccc2_d[l_ac].xccc006,g_xccc2_d[l_ac].xccc007,g_xccc2_d[l_ac].xccc008, 
          g_xccc2_d[l_ac].xccc901,g_xccc2_d[l_ac].xcau003,g_xccc2_d[l_ac].xccc280a,g_xccc2_d[l_ac].xccc902a,g_xccc2_d[l_ac].xcag011,
          g_xccc2_d[l_ac].xcag102a,g_xccc2_d[l_ac].xccc002_desc, 
          g_xccc2_d[l_ac].xccc006_desc,g_xccc2_d[l_ac].xccc006_desc_desc
                             
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
         SELECT xcbb005 INTO g_xccc2_d[l_ac].xcbb005 FROM xcbb_t
          WHERE xcbbent  = g_enterprise
            AND xcbbcomp = g_xccc_m.xccccomp
            AND xcbb001  = g_xccc_m.xccc004
            AND xcbb002  = g_xccc_m.xccc005
            AND xcbb003  = g_xccc2_d[l_ac].xccc006         
         #標準幣別+單位成本        
         LET g_xccc2_d[l_ac].l_amt_2 = g_xccc2_d[l_ac].xcag102a * g_xccc2_d[l_ac].xccc901
         LET g_xccc2_d[l_ac].l_diff_2 = g_xccc2_d[l_ac].xccc902a - g_xccc2_d[l_ac].l_amt_2
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取
         LET l_xccc902a_total1 =l_xccc902a_total1 + g_xccc2_d[l_ac].xccc902a 
         LET l_amt_2_total1 = l_amt_2_total1 + g_xccc2_d[l_ac].l_amt_2
         LET l_diff_2_total1 = l_diff_2_total1 + g_xccc2_d[l_ac].l_diff_2
         #按料号＋特性＋批号 小计
         LET l_xccc902a_sum1 =l_xccc902a_sum1 + g_xccc2_d[l_ac].xccc902a 
         LET l_amt_2_sum1 = l_amt_2_sum1 + g_xccc2_d[l_ac].l_amt_2
         LET l_diff_2_sum1 = l_diff_2_sum1 + g_xccc2_d[l_ac].l_diff_2
         IF l_ac > 1 THEN  
            IF g_xccc2_d[l_ac].xccc006 != g_xccc2_d[l_ac - 1].xccc006 OR 
                g_xccc2_d[l_ac].xccc007 != g_xccc2_d[l_ac - 1].xccc007 OR 
               g_xccc2_d[l_ac].xccc008 != g_xccc2_d[l_ac - 1].xccc008
               THEN #前两行相同 则此处为第三行
               #把当前行下移，并在当前行显示小计
               LET g_xccc2_d[l_ac + 1].* = g_xccc2_d[l_ac].*   
               INITIALIZE  g_xccc2_d[l_ac].* TO NULL
               #LET g_xccc2_d[l_ac].xccc008 = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
               LET g_xccc2_d[l_ac].xccc006_desc_desc = g_xccc2_d[l_ac - 1].xccc008,cl_getmsg("axc-00205",g_lang) #151029-00010#1 151029 By pomelo add
               LET g_xccc2_d[l_ac].xccc902a = l_xccc902a_sum1 - g_xccc2_d[l_ac + 1].xccc902a   
               LET g_xccc2_d[l_ac].l_amt_2 = l_amt_2_sum1 - g_xccc2_d[l_ac + 1].l_amt_2    
               LET g_xccc2_d[l_ac].l_diff_2 = l_diff_2_sum1 - g_xccc2_d[l_ac + 1].l_diff_2                  
               LET l_ac = l_ac + 1
               LET l_xccc902a_sum1 = g_xccc2_d[l_ac].xccc902a
               LET l_amt_2_sum1 = g_xccc2_d[l_ac].l_amt_2
               LET l_diff_2_sum1 = g_xccc2_d[l_ac].l_diff_2               
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
 
            CALL g_xccc2_d.deleteElement(g_xccc2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
   IF l_ac > 1 THEN
      #最后一组小计
      #LET g_xccc2_d[l_ac].xccc008 = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
      LET g_xccc2_d[l_ac].xccc006_desc_desc = g_xccc2_d[l_ac - 1].xccc008,cl_getmsg("axc-00205",g_lang) #151029-00010#1 151029 By pomelo add
      LET g_xccc2_d[l_ac].xccc902a = l_xccc902a_sum1
      LET g_xccc2_d[l_ac].l_amt_2 = l_amt_2_sum1
      LET g_xccc2_d[l_ac].l_diff_2 = l_diff_2_sum1
      LET l_ac = l_ac + 1
      #合计
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      IF g_para_data = 'Y' THEN
         LET g_xccc2_d[l_ac].xccc002 = cl_getmsg("axc-00204",g_lang)                    
      ELSE
         LET g_xccc2_d[l_ac].xccc006 = cl_getmsg("axc-00204",g_lang)                
      END IF
      LET g_xccc2_d[l_ac].xccc902a = l_xccc902a_total1
      LET g_xccc2_d[l_ac].l_amt_2 = l_amt_2_total1
      LET g_xccc2_d[l_ac].l_diff_2 = l_diff_2_total1
      LET l_ac = l_ac + 1
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   IF g_current_page = 2 THEN
      DISPLAY g_rec_b TO FORMONLY.cnt 
   END IF   
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axcq901_pb2   

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
PRIVATE FUNCTION axcq901_b_fill_3()
DEFINE l_glaa003  LIKE glaa_t.glaa003
   DEFINE l_bdate    DATE
   DEFINE l_edate    DATE
   DEFINE l_xcdc902_sum1   LIKE xcdc_t.xcdc902
   DEFINE l_amt_3_sum1       LIKE xcdc_t.xcdc902
   DEFINE l_diff_3_sum1      LIKE xcdc_t.xcdc902
   DEFINE l_xcdc902_total1 LIKE xcdc_t.xcdc902
   DEFINE l_amt_3_total1     LIKE xcdc_t.xcdc902
   DEFINE l_diff_3_total1    LIKE xcdc_t.xcdc902
   #end add-point     
 
   #先清空單身變數內容
   CALL g_xccc3_d.clear()
   
 
   #add-point:b_fill段sql_before
   IF g_xccc_m.xccc004 IS NOT NULL AND g_xccc_m.xccc005 IS NOT NULL THEN      
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xccc_m.xccccomp
         AND glaa014  = 'Y' 

     CALL s_fin_date_get_period_range(l_glaa003,g_xccc_m.xccc004,g_xccc_m.xccc005) RETURNING l_bdate,l_edate
   END IF
   #end add-point
   #160520-00003#13 marked-S
#   LET g_sql = "SELECT  UNIQUE xcdc002,xcdc006,xcdc007,xcdc008,xcdc009,xcdc901,xcdc280,xcdc902,t1.xcbfl003 , 
#       t2.imaal003 ,t3.imaal004,t4.xcaul003 FROM xcdc_t",   
#               "",
#               
#                              " LEFT JOIN xcbfl_t t1 ON t1.xcbflent='"||g_enterprise||"' AND t1.xcbflcomp=xcdccomp AND t1.xcbfl001=xcdc002 AND t1.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcdc006 AND t2.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t3 ON t3.imaalent='"||g_enterprise||"' AND t3.imaal001=xcdc006 AND t3.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN xcaul_t t4 ON t4.xcaulent='"||g_enterprise||"' AND t4.xcaul001=xcdc009 AND t4.xcaul002='"||g_dlang||"' ",
#               " WHERE xcdcent= ? AND xcdcld=? AND xcdc001=? AND xcdc003=? AND xcdc004=? AND xcdc005=?"  
# 
#   IF NOT cl_null(g_wc2_table1) THEN
#      LET g_wc2_table3 = g_wc2_table1
#      LET g_wc2_table3=cl_replace_str(g_wc2_table3,"xccc","xcdc")
#      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED, cl_sql_add_filter("xcdc_t")
#   END IF
   #160520-00003#13 marked-E
   
   #add-point:b_fill段sql_after
   #160520-00003#13 add-S
   LET g_sql = "SELECT  UNIQUE xcdc002,xcdc006,xcdc007,xcdc008,xcdc009,xcdc901,xcdc280,xcdc902,",
               "(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflcomp = xcdccomp AND xcbfl001 = xcdc002 AND xcbfl002 = '"||g_dlang||"' AND xcbflent = xcdcent)t1_xcbfl003 , ",
               "(SELECT imaal003 FROM imaal_t WHERE imaal001 = xcdc006 AND imaalent = xcdcent AND imaal002 = '"||g_dlang||"')t2_imaal003 ,",
               "(SELECT imaal004 FROM imaal_t WHERE imaal001 = xcdc006 AND imaalent = xcdcent AND imaal002 = '"||g_dlang||"')t2_imaal004 ,",
               "(SELECT xcaul003 FROM xcaul_t WHERE xcaulent = xcdcent AND xcaul001 = xcdc009 AND xcaul002 = '"||g_dlang||"')t3_xcaul003,",
               "(SELECT xcbb005 FROM xcbb_t WHERE rownum = 1 AND xcbbent = xcdcent AND xcbbcomp = xcdccomp AND xcbb001 = xcdc004 AND xcbb002 = xcdc005 AND xcbb003 = xcdc006) t3_xcbb005,",
               "(SELECT DISTINCT xcag011  FROM xcag_t ",
               "  WHERE xcagent = xcdcent ",
               "    AND rownum = 1 ",
               "    AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "    AND xcag004 = xcdc006 ",
               "    AND xcag002 = (SELECT MAX(xcag002) FROM xcag_t ",
               "                    WHERE xcagent = xcdcent ",
               "                      AND xcagcomp = xcdccomp ",
               "                      AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "                      AND xcag004 = xcdc006",
               "                      AND xcag002 <= '",l_edate,"'",
               "                      AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"'))",
               "     AND (xcag003 IS NULL OR xcag003 = (SELECT MIN(xcag003) FROM xcag_t ",
               "             WHERE xcagent = xcdcent ",
               "               AND xcagcomp = xcdccomp ",
               "               AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "               AND xcag004 = xcdc006 ",
               "               AND xcag002 <= '",l_edate,"'",
               "               AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"')))",
               "     AND xcag002 <= '",l_edate,"'",
               "     AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"'))t4_xcag011,",
               "(SELECT DISTINCT xcag102  FROM xcag_t ",
               "  WHERE xcagent = xcccent ",
               "    AND rownum = 1 ",
               "    AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "    AND xcag004 = xcdc006 ",
               "    AND xcag002 = (SELECT MAX(xcag002) FROM xcag_t ",
               "                    WHERE xcagent = xcdcent ",
               "                      AND xcagcomp = xcdccomp ",
               "                      AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "                      AND xcag004 = xcdc006",
               "                      AND xcag002 <= '",l_edate,"'",
               "                      AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"'))",
               "     AND (xcag003 IS NULL OR xcag003 = (SELECT MIN(xcag003) FROM xcag_t ",
               "             WHERE xcagent = xcdcent ",
               "               AND xcagcomp = xcdccomp ",
               "               AND xcag001 = '"||g_xccc_m.xcag001||"' ",
               "               AND xcag004 = xcdc006 ",
               "               AND xcag002 <= '",l_edate,"'",
               "               AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"')))",
               "     AND xcag002 <= '",l_edate,"'",
               "     AND (xcag003 IS NULL OR xcag003 >= '",l_edate,"')   )t4_xcag102",
               " FROM xcdc_t",   
               " WHERE xcdcent= ? AND xcdcld=? AND xcdc001=? AND xcdc003=? AND xcdc004=? AND xcdc005=?"  
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_wc2_table3 = g_wc2_table1
      LET g_wc2_table3=cl_replace_str(g_wc2_table3,"xccc","xcdc")
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED, cl_sql_add_filter("xcdc_t")
   END IF
   #160520-00003#13 add-E
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq901_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcdc_t.xcdc006,xcdc_t.xcdc007,xcdc_t.xcdc008,xcdc_t.xcdc002"
      
      
      LET l_xcdc902_sum1 = 0
      LET l_amt_3_sum1 = 0
      LET l_diff_3_sum1 = 0
      LET l_xcdc902_total1 = 0
      LET l_amt_3_total1 = 0
      LET l_diff_3_total1 = 0
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq901_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axcq901_pb3
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_xccc_m.xcccld,g_xccc_m.xccc001,g_xccc_m.xccc003,g_xccc_m.xccc004,g_xccc_m.xccc005
                                               
      FOREACH b_fill_cs3 INTO g_xccc3_d[l_ac].xcdc002,g_xccc3_d[l_ac].xcdc006,g_xccc3_d[l_ac].xcdc007,g_xccc3_d[l_ac].xcdc008, 
          g_xccc3_d[l_ac].xcdc009,g_xccc3_d[l_ac].xcdc901,g_xccc3_d[l_ac].xcdc280,g_xccc3_d[l_ac].xcdc902,g_xccc3_d[l_ac].xcdc002_desc, 
          g_xccc3_d[l_ac].xcdc006_desc,g_xccc3_d[l_ac].xcdc006_desc_desc,g_xccc3_d[l_ac].xcdc009_desc,
          g_xccc3_d[l_ac].xcbb005,g_xccc3_d[l_ac].xcag011,g_xccc3_d[l_ac].xcag102   #160520-00003#13 add   
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         #160520-00003#13 marked-S
#         #成本单位
#         SELECT xcbb005 INTO g_xccc3_d[l_ac].xcbb005 FROM xcbb_t
#          WHERE xcbbent  = g_enterprise
#            AND xcbbcomp = g_xccc_m.xccccomp
#            AND xcbb001  = g_xccc_m.xccc004
#            AND xcbb002  = g_xccc_m.xccc005
#            AND xcbb003  = g_xccc3_d[l_ac].xcdc006         
         #標準幣別+單位成本
#         
#         SELECT DISTINCT xcag011,xcag102 INTO g_xccc3_d[l_ac].xcag011,g_xccc3_d[l_ac].xcag102 FROM xcag_t
#          WHERE xcagent = g_enterprise
#            AND xcagcomp = g_xccc_m.xccccomp
#            AND xcag001 = g_xccc_m.xcag001
#            AND xcag004 = g_xccc3_d[l_ac].xcdc006
#            AND xcag002 = (SELECT MAX(xcag002) FROM xcag_t 
#                            WHERE xcagent = g_enterprise
#                              AND xcagcomp = g_xccc_m.xccccomp
#                              AND xcag001 = g_xccc_m.xcag001
#                              AND xcag004 = g_xccc3_d[l_ac].xcdc006
#                              AND xcag002 <= l_edate
#                              AND (xcag003 IS NULL OR xcag003 >= l_edate)) 
#            AND (xcag003 IS NULL OR xcag003 = (SELECT MIN(xcag003) FROM xcag_t 
#                            WHERE xcagent = g_enterprise
#                              AND xcagcomp = g_xccc_m.xccccomp
#                              AND xcag001 = g_xccc_m.xcag001
#                              AND xcag004 = g_xccc3_d[l_ac].xcdc006
#                              AND xcag002 <= l_edate
#                              AND (xcag003 IS NULL OR xcag003 >= l_edate)))                  
#            AND xcag002 <= l_edate
#            AND (xcag003 IS NULL OR xcag003 >= l_edate)
         #160520-00003#13 marked-E
         IF cl_null(g_xccc3_d[l_ac].xcag102) THEN LET g_xccc3_d[l_ac].xcag102 = 0 END IF
         LET g_xccc3_d[l_ac].l_amt_3 = g_xccc3_d[l_ac].xcag102 * g_xccc3_d[l_ac].xcdc901
         LET g_xccc3_d[l_ac].l_diff_3 = g_xccc3_d[l_ac].xcdc902 - g_xccc3_d[l_ac].l_amt_3
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取
         LET l_xcdc902_total1 =l_xcdc902_total1 + g_xccc3_d[l_ac].xcdc902 
         LET l_amt_3_total1 = l_amt_3_total1 + g_xccc3_d[l_ac].l_amt_3
         LET l_diff_3_total1 = l_diff_3_total1 + g_xccc3_d[l_ac].l_diff_3
         #按料号＋特性＋批号 小计
         LET l_xcdc902_sum1 =l_xcdc902_sum1 + g_xccc3_d[l_ac].xcdc902 
         LET l_amt_3_sum1 = l_amt_3_sum1 + g_xccc3_d[l_ac].l_amt_3
         LET l_diff_3_sum1 = l_diff_3_sum1 + g_xccc3_d[l_ac].l_diff_3
         IF l_ac > 1 THEN  
            IF g_xccc3_d[l_ac].xcdc006 != g_xccc3_d[l_ac - 1].xcdc006 OR 
                g_xccc3_d[l_ac].xcdc007 != g_xccc3_d[l_ac - 1].xcdc007 OR 
               g_xccc3_d[l_ac].xcdc008 != g_xccc3_d[l_ac - 1].xcdc008
               THEN #前两行相同 则此处为第三行
               #把当前行下移，并在当前行显示小计
               LET g_xccc3_d[l_ac + 1].* = g_xccc3_d[l_ac].*   
               INITIALIZE  g_xccc3_d[l_ac].* TO NULL
               #LET g_xccc3_d[l_ac].xcdc008 = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
               LET g_xccc3_d[l_ac].xcdc006_desc_desc = g_xccc3_d[l_ac - 1].xcdc008,cl_getmsg("axc-00205",g_lang) #151029-00010#1 151029 By pomelo add
               LET g_xccc3_d[l_ac].xcdc902 = l_xcdc902_sum1 - g_xccc3_d[l_ac + 1].xcdc902   
               LET g_xccc3_d[l_ac].l_amt_3 = l_amt_3_sum1 - g_xccc3_d[l_ac + 1].l_amt_3    
               LET g_xccc3_d[l_ac].l_diff_3 = l_diff_3_sum1 - g_xccc3_d[l_ac + 1].l_diff_3                  
               LET l_ac = l_ac + 1
               LET l_xcdc902_sum1 = g_xccc3_d[l_ac].xcdc902
               LET l_amt_3_sum1 = g_xccc3_d[l_ac].l_amt_3
               LET l_diff_3_sum1 = g_xccc3_d[l_ac].l_diff_3               
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
 
            CALL g_xccc3_d.deleteElement(g_xccc3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
   IF l_ac > 1 THEN
      #最后一组小计
      #LET g_xccc3_d[l_ac].xcdc008 = cl_getmsg("axc-00205",g_lang)  #151029-00010#1 151029 By pomelo mark
      LET g_xccc3_d[l_ac].xcdc006_desc_desc = g_xccc3_d[l_ac - 1].xcdc008,cl_getmsg("axc-00205",g_lang) #151029-00010#1 151029 By pomelo add
      LET g_xccc3_d[l_ac].xcdc902 = l_xcdc902_sum1
      LET g_xccc3_d[l_ac].l_amt_3 = l_amt_3_sum1
      LET g_xccc3_d[l_ac].l_diff_3 = l_diff_3_sum1
      LET l_ac = l_ac + 1
      #合计
      CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      IF g_para_data = 'Y' THEN
         LET g_xccc3_d[l_ac].xcdc002 = cl_getmsg("axc-00204",g_lang)                    
      ELSE
         LET g_xccc3_d[l_ac].xcdc006 = cl_getmsg("axc-00204",g_lang)                
      END IF
      LET g_xccc3_d[l_ac].xcdc902 = l_xcdc902_total1
      LET g_xccc3_d[l_ac].l_amt_3 = l_amt_3_total1
      LET g_xccc3_d[l_ac].l_diff_3 = l_diff_3_total1
      LET l_ac = l_ac + 1
   END IF
   #end add-point
   
   LET g_rec_b=l_ac-1
   IF g_current_page = 3 THEN
      DISPLAY g_rec_b TO FORMONLY.cnt
   END IF      
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axcq901_pb3   

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
PRIVATE FUNCTION axcq901_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003
   DISPLAY BY NAME g_xccc_m.xccccomp,g_xccc_m.xcccld,g_xccc_m.xccc004,g_xccc_m.xccc005,g_xccc_m.xccc003
   IF cl_null(g_xccc_m.xccccomp) THEN
       CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
       CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
    ELSE
       CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
       CALL cl_get_para(g_enterprise,g_xccc_m.xccccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
    END IF
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc,xcdc002,xcdc002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccc002,xccc002_desc,xccc002_2,xccc002_2_desc,xcdc002,xcdc002_desc',FALSE)                
   END IF 
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否            
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccc007,xccc007_2,xcdc007',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccc007,xccc007_2,xcdc007',FALSE)                
   END IF      
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
   LET g_xccc_m.xcccc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xcccc003_desc
      
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
PRIVATE FUNCTION axcq901_ref()
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
   LET g_xccc_m.xcccc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xcccc003_desc
    
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
   LET g_glaa001 = l_glaa001
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xccc001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xccc001_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccc_m.xcag001
   CALL ap_ref_array2(g_ref_fields,"SELECT xcaal003 FROM xcaal_t WHERE xcaalent='"||g_enterprise||"' AND xcaal001=? AND xcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccc_m.xcag001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccc_m.xcag001_desc     
   
END FUNCTION

 
{</section>}
 
