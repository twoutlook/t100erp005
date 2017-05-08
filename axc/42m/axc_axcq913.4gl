#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq913.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-03-18 18:11:51), PR版次:0004(2016-10-26 14:20:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: axcq913
#+ Description: 銷售毛利查詢作業
#+ Creator....: 07675(2016-01-13 09:53:44)
#+ Modifier...: 07675 -SD/PR- 02040
 
{</section>}
 
{<section id="axcq913.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#151130-00003#15              By Dorislai    二次篩選
#160318-00025#10   2016/04/22 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160520-00002#5    2016/05/23 By 01531       效能优化;[数量汇总]小计合计总计有误；[销售收入]资料明细及小计有误
#160816-00001#10   16/08/17 By 08742     抓取理由碼改CALL sub
#160802-00020#9    2016/09/26  By 02097    法人:視azzi800的据點權限/帳套: 視USER的帳套權限/QBE下法人/帳套不用互相勾稽
#161019-00017#10   2016/10/26 By 08734       调整法人组织开窗由q_ooef001变为q_ooef001_2
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
PRIVATE type type_g_xcck_m        RECORD
       xcckcomp LIKE xcck_t.xcckcomp, 
   xcckcomp_desc LIKE type_t.chr80, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck001_desc LIKE type_t.chr80, 
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr80, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcck_d        RECORD
       xccksite LIKE xcck_t.xccksite, 
   xccksite_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck013 LIKE xcck_t.xcck013, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_1 LIKE type_t.chr500, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck022 LIKE xcck_t.xcck022, 
   xcck022_desc LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr500, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck202 LIKE xcck_t.xcck202, 
   amt LIKE type_t.num20_6, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_acc                 LIKE gzcb_t.gzcb007
DEFINE g_xcck2_d             DYNAMIC ARRAY OF RECORD
       xccksite_1            LIKE xcck_t.xccksite,
       xccksite_1_desc       LIKE type_t.chr500,
       xcck024_1             LIKE xcck_t.xcck024,
       xcck029_1             LIKE xcck_t.xcck029,
       xcck010_1             LIKE xcck_t.xcck010,
       xcck010_1_desc        LIKE type_t.chr500, 
       xcck010_1_desc_1      LIKE type_t.chr500,
       xcck011_1             LIKE xcck_t.xcck011,
       xcck021_1             LIKE xcck_t.xcck021,
       xcck021_1_desc        LIKE type_t.chr500,
       xcck022_1             LIKE xcck_t.xcck022,
       xcck022_1_desc        LIKE type_t.chr500,
       xcck023_1             LIKE xcck_t.xcck023,
       xcck025_1             LIKE xcck_t.xcck025,
       xcck025_1_desc        LIKE type_t.chr500,
       xcck026_1             LIKE xcck_t.xcck026,
       xcck027_1             LIKE xcck_t.xcck027,
       xcck028_1             LIKE xcck_t.xcck028,
       xcck030_1             LIKE xcck_t.xcck030,
       xcck031_1             LIKE xcck_t.xcck031,
       xcck044_1             LIKE xcck_t.xcck044,
       xcck044_1_desc        LIKE type_t.chr500,
       xcck201_1             LIKE xcck_t.xcck201,
       xcck202a_1            LIKE xcck_t.xcck202a,
       xcck202b_1            LIKE xcck_t.xcck202b,
       xcck202c_1            LIKE xcck_t.xcck202c,
       xcck202d_1            LIKE xcck_t.xcck202d,
       xcck202e_1            LIKE xcck_t.xcck202e,
       xcck202f_1            LIKE xcck_t.xcck202f,
       xcck202g_1            LIKE xcck_t.xcck202g,
       xcck202h_1            LIKE xcck_t.xcck202h,
       xcck202_1             LIKE xcck_t.xcck202,
       amt3                  LIKE xcck_t.xcck202,
       amt4                  LIKE xcck_t.xcck202,
       amt5                  LIKE xcck_t.xcck202,
       amt6                  LIKE xcck_t.xcck202,
       amt7                  LIKE xcck_t.xcck202
                             END RECORD

DEFINE g_rec_b2              LIKE type_t.num5
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150109
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150109
DEFINE g_sql_tmp             STRING                #临时表所用的sql #dujuan 20150325
#dujuan150324-----str
 TYPE type_g_glfb_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_glfb_e  
#dujuan150324-----end
#150805-00001#11add
DEFINE g_yy1 LIKE type_t.num5
DEFINE g_mm1 LIKE type_t.num5
DEFINE g_yy2 LIKE type_t.num5
DEFINE g_mm2 LIKE type_t.num5
#150805-00001#11add
#20150806--add--str--lujh
 TYPE type_g_xcck3_d RECORD
       xcck028 LIKE xcck_t.xcck028, 
   xcck028_2_desc LIKE type_t.chr500, 
   xcck202 LIKE xcck_t.xcck202
       END RECORD
DEFINE g_xcck3_d   DYNAMIC ARRAY OF type_g_xcck3_d
DEFINE g_xcck3_d_t type_g_xcck3_d
DEFINE g_xcck3_d_o type_g_xcck3_d
DEFINE g_xcck3_d_mask_o   DYNAMIC ARRAY OF type_g_xcck3_d #轉換遮罩前資料
DEFINE g_xcck3_d_mask_n   DYNAMIC ARRAY OF type_g_xcck3_d #轉換遮罩後資料
#20150806--add--end--lujh
#160802-00020#9-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#9-e-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcck_m          type_g_xcck_m
DEFINE g_xcck_m_t        type_g_xcck_m
DEFINE g_xcck_m_o        type_g_xcck_m
DEFINE g_xcck_m_mask_o   type_g_xcck_m #轉換遮罩前資料
DEFINE g_xcck_m_mask_n   type_g_xcck_m #轉換遮罩後資料
 
   DEFINE g_xcck004_t LIKE xcck_t.xcck004
DEFINE g_xcck001_t LIKE xcck_t.xcck001
DEFINE g_xcckld_t LIKE xcck_t.xcckld
DEFINE g_xcck005_t LIKE xcck_t.xcck005
DEFINE g_xcck003_t LIKE xcck_t.xcck003
 
 
DEFINE g_xcck_d          DYNAMIC ARRAY OF type_g_xcck_d
DEFINE g_xcck_d_t        type_g_xcck_d
DEFINE g_xcck_d_o        type_g_xcck_d
DEFINE g_xcck_d_mask_o   DYNAMIC ARRAY OF type_g_xcck_d #轉換遮罩前資料
DEFINE g_xcck_d_mask_n   DYNAMIC ARRAY OF type_g_xcck_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcckld LIKE xcck_t.xcckld,
      b_xcck001 LIKE xcck_t.xcck001,
      b_xcck003 LIKE xcck_t.xcck003,
      b_xcck004 LIKE xcck_t.xcck004,
      b_xcck005 LIKE xcck_t.xcck005
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
 
{<section id="axcq913.main" >}
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
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint302'    #160816-00001#10 mark
   LET g_acc = s_fin_get_scc_value('24','aint302','2')  #160816-00001#10  Add
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
   LET g_forupd_sql = " SELECT xcckcomp,'',xcck004,xcck001,'',xcckld,'',xcck005,xcck003,''", 
                      " FROM xcck_t",
                      " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND  
                          xcck005=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq913_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcckcomp,t0.xcck004,t0.xcck001,t0.xcckld,t0.xcck005,t0.xcck003,t1.ooefl003 , 
       t2.ooail003 ,t3.glaal002 ,t4.xcatl003",
               " FROM xcck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcckcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=t0.xcck001 AND t2.ooail002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.xcckld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t4 ON t4.xcatlent="||g_enterprise||" AND t4.xcatl001=t0.xcck003 AND t4.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcckent = " ||g_enterprise|| " AND t0.xcckld = ? AND t0.xcck001 = ? AND t0.xcck003 = ? AND t0.xcck004 = ? AND t0.xcck005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
#   #150805-00001#11add
#   LET g_sql = " SELECT UNIQUE t0.xcckcomp,t0.xcck001,t0.xcckld,t0.xcck003,t1.ooefl003 , 
#       t2.ooail003 ,t3.glaal002 ,t4.xcatl003",
#               " FROM xcck_t t0",
#                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xcckcomp AND t1.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN ooail_t t2 ON t2.ooailent='"||g_enterprise||"' AND t2.ooail001=t0.xcck001 AND t2.ooail002='"||g_dlang||"' ",
#               " LEFT JOIN glaal_t t3 ON t3.glaalent='"||g_enterprise||"' AND t3.glaalld=t0.xcckld AND t3.glaal001='"||g_dlang||"' ",
#               " LEFT JOIN xcatl_t t4 ON t4.xcatlent='"||g_enterprise||"' AND t4.xcatl001=t0.xcck003 AND t4.xcatl002='"||g_dlang||"' ",
# 
#               " WHERE t0.xcckent = '" ||g_enterprise|| "' AND t0.xcckld = ? AND t0.xcck001 = ? AND t0.xcck003 = ? "
#   LET g_sql = cl_sql_add_mask(g_sql) 
   #end add-point
   PREPARE axcq913_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq913 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq913_init()   
 
      #進入選單 Menu (="N")
      CALL axcq913_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq913
      
   END IF 
   
   CLOSE axcq913_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq913.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq913_init()
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
   CALL cl_set_combo_scc('xcck001','8914')
   #fengmy 150109----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF 
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否            
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_1',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck011,xcck011_1',FALSE)                
   END IF   
   #fengmy 150109----end
   #end add-point
   
   CALL axcq913_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq913.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq913_ui_dialog()
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
   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
      CALL axcq913_query()
   END IF
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcck_m.* TO NULL
         CALL g_xcck_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq913_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq913_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq913_ui_detailshow()
               
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
         DISPLAY ARRAY g_xcck2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page2  
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               CALL axcq913_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
             DISPLAY ARRAY g_xcck3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axcq913_idx_chk()
               CALL axcq913_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 3
            
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq913_browser_fill("")
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
               CALL axcq913_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq913_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
         NEXT FIELD xcck028_2          #20150806 add lujh
            #列印报表功能  20150325 By dujuan---------str 
            ON ACTION output
               LET g_action_choice="output"
#mark by chenhz 15/08/20(s) 换成GR报表  
#               IF cl_auth_chk_act("output") THEN
#                  #創建臨時表
#                  CALL axcq913_create_temp_table()
#                  #為臨時表加數據
#                  CALL axcq913_get_date()
#                  LET g_param.v = "axcq513_tmp"
#                  CALL axcq913_x01(" 1=1",g_param.v)                     
#                  EXIT DIALOG
#               END IF
            #20150325 By dujuan--------end 
#mark by chenhz 15/08/20(e)  
#add by chenhz 15/08/20(s)
             #!#!CALL cxcq913_g01(g_wc)
#add by chenhz 15/08/20(e)
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq913_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq913_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq913_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq913_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq913_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq913_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq913_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq913_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq913_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq913_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcck_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_xcck2_d)
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
               NEXT FIELD xcck002
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
               CALL axcq913_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq913_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq913_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq913_query()
               #add-point:ON ACTION query name="menu.query"
                NEXT FIELD xcck028_2          #20150806 add lujh
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axcq913_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq913_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq913_set_pk_array()
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
 
{<section id="axcq913.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq913_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq913.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq913_browser_fill(ps_page_action)
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
#   IF cl_null(g_wc) THEN
##      LET g_wc = " (xcck055 = '305' OR xcck055 = '307')"   #fengmy 150112 mark
#      LET g_wc = " xcck055 IN ('305','307','303','215')"   #fengmy 150112
#      LET g_wc = g_wc," AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  #150805-00001#11add     
#   ELSE
##      LET g_wc = g_wc," AND (xcck055 = '305' OR xcck055 = '307')"  #fengmy 150112 mark
#      LET g_wc = g_wc," AND xcck055 IN ('305','307','303','215')"  #fengmy 150112
#      LET g_wc = g_wc," AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  #150805-00001#11add     
#   END IF
  IF cl_null(g_wc) THEN
#    LET g_wc = " (xcck055 = '305' OR xcck055 = '307')"   #fengmy 150112 mark
     LET g_wc = " xcck055 IN ('305','307','303','215')"   #fengmy 150112

   ELSE
#     LET g_wc = g_wc," AND (xcck055 = '305' OR xcck055 = '307')"  #fengmy 150112 mark
      LET g_wc = g_wc," AND xcck055 IN ('305','307','303','215')"  #fengmy 150112
   END IF
   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_wc = g_wc , " AND xccKld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_wc = g_wc," AND xccKcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#9-e-add
   
   #end add-point    
 
   LET l_searchcol = "xcckld,xcck001,xcck003,xcck004,xcck005"
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
      LET l_sub_sql = " SELECT DISTINCT xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcckent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcckent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcck_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #151130-00003#15-add---(S)
   #把條件加在l_wc，這樣二次查詢完再查詢時，g_wc值才不會有g_wc_filter
   IF NOT cl_null(g_wc_filter) THEN
      LET l_wc = l_wc CLIPPED,"AND ",g_wc_filter
   END IF
   #151130-00003#15-add---(E)
   #150805-00001#11add
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                       ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ",
 
                      " WHERE xcckent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                       ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ",
                      " WHERE xcckent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xcck_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   #150805-00001#11add
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
      INITIALIZE g_xcck_m.* TO NULL
      CALL g_xcck_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005",
                " FROM xcck_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcckent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcck_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
##   #150805-00001#11add
   LET l_searchcol = "xcckld,xcck001,xcck003"

   LET g_sql  = "SELECT DISTINCT t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005",
               " FROM xcck_t t0",
                " ",
               " ",
 
                
                " WHERE t0.xcckent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcck_t")
###
   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xcckld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xcckcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#9-e-add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcck_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcckld,g_browser[g_cnt].b_xcck001,g_browser[g_cnt].b_xcck003, 
          g_browser[g_cnt].b_xcck004,g_browser[g_cnt].b_xcck005 
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
   
   IF cl_null(g_browser[g_cnt].b_xcckld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcck_m.* TO NULL
      CALL g_xcck_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq913_fetch('')
   
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
 
{<section id="axcq913.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq913_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld   
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001   
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003   
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004   
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005   
 
   EXECUTE axcq913_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   CALL axcq913_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq913_ui_detailshow()
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
 
{<section id="axcq913.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq913_ui_browser_refresh()
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
      IF g_browser[l_i].b_xcckld = g_xcck_m.xcckld 
         AND g_browser[l_i].b_xcck001 = g_xcck_m.xcck001 
         AND g_browser[l_i].b_xcck003 = g_xcck_m.xcck003 
         AND g_browser[l_i].b_xcck004 = g_xcck_m.xcck004 
         AND g_browser[l_i].b_xcck005 = g_xcck_m.xcck005 
 
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
 
{<section id="axcq913.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq913_construct()
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
   INITIALIZE g_xcck_m.* TO NULL
   CALL g_xcck_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   CALL g_xcck2_d.clear()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcckcomp,xcck004,xcck001,xcckld,xcck005,xcck003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CALL axcq913_default()
            #end add-point 
            
                 #Ctrlp:construct.c.xcckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="construct.c.xcckcomp"
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
          #  CALL q_ooef001()                           #呼叫開窗  #161019-00017#10   2016/10/26 By 08734  mark
            CALL q_ooef001_2()  #161019-00017#10   2016/10/26 By 08734  add
            DISPLAY g_qryparam.return1 TO xcckcomp  #顯示到畫面上
            NEXT FIELD xcckcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckcomp
            #add-point:BEFORE FIELD xcckcomp name="construct.b.xcckcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckcomp
            
            #add-point:AFTER FIELD xcckcomp name="construct.a.xcckcomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck004
            #add-point:BEFORE FIELD xcck004 name="construct.b.xcck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck004
            
            #add-point:AFTER FIELD xcck004 name="construct.a.xcck004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck004
            #add-point:ON ACTION controlp INFIELD xcck004 name="construct.c.xcck004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001 name="construct.b.xcck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001 name="construct.a.xcck001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001 name="construct.c.xcck001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcckld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="construct.c.xcckld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s-add
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept             
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9-e-add             
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcckld  #顯示到畫面上
            NEXT FIELD xcckld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckld
            #add-point:BEFORE FIELD xcckld name="construct.b.xcckld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld name="construct.a.xcckld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck005
            #add-point:BEFORE FIELD xcck005 name="construct.b.xcck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck005
            
            #add-point:AFTER FIELD xcck005 name="construct.a.xcck005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck005
            #add-point:ON ACTION controlp INFIELD xcck005 name="construct.c.xcck005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xcck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003 name="construct.c.xcck003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck003  #顯示到畫面上
            NEXT FIELD xcck003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck003
            #add-point:BEFORE FIELD xcck003 name="construct.b.xcck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck003
            
            #add-point:AFTER FIELD xcck003 name="construct.a.xcck003"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002, 
          xcck044,xcck201_s,xcck202_s,amt2
           FROM s_detail1[1].xccksite,s_detail1[1].xcck006,s_detail1[1].xcck007,s_detail1[1].xcck009, 
               s_detail1[1].xcck013,s_detail1[1].xcck010,s_detail1[1].xcck011,s_detail1[1].xcck022,s_detail1[1].xcck002, 
               s_detail1[1].xcck044,s_detail1[1].xcck201_s,s_detail1[1].xcck202_s,s_detail1[1].amt2
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #Ctrlp:construct.c.page1.xccksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccksite
            #add-point:ON ACTION controlp INFIELD xccksite name="construct.c.page1.xccksite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
         #  CALL q_ooef001()                           #呼叫開窗  #161019-00017#10   2016/10/26 By 08734  mark
            CALL q_ooef001_2()  #161019-00017#10   2016/10/26 By 08734  add
            DISPLAY g_qryparam.return1 TO xccksite  #顯示到畫面上
            NEXT FIELD xccksite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccksite
            #add-point:BEFORE FIELD xccksite name="construct.b.page1.xccksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccksite
            
            #add-point:AFTER FIELD xccksite name="construct.a.page1.xccksite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006 name="construct.b.page1.xcck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006 name="construct.a.page1.xcck006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006 name="construct.c.page1.xcck006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xmdkstus = 'S'"
            CALL q_xmdkdocno_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上            
            NEXT FIELD xcck006
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck007
            #add-point:BEFORE FIELD xcck007 name="construct.b.page1.xcck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck007
            
            #add-point:AFTER FIELD xcck007 name="construct.a.page1.xcck007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck007
            #add-point:ON ACTION controlp INFIELD xcck007 name="construct.c.page1.xcck007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009 name="construct.b.page1.xcck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009 name="construct.a.page1.xcck009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009 name="construct.c.page1.xcck009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck013
            #add-point:BEFORE FIELD xcck013 name="construct.b.page1.xcck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck013
            
            #add-point:AFTER FIELD xcck013 name="construct.a.page1.xcck013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck013
            #add-point:ON ACTION controlp INFIELD xcck013 name="construct.c.page1.xcck013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck010
            #add-point:BEFORE FIELD xcck010 name="construct.b.page1.xcck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010 name="construct.a.page1.xcck010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010 name="construct.c.page1.xcck010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcck011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011 name="construct.c.page1.xcck011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck011  #顯示到畫面上
            NEXT FIELD xcck011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck011
            #add-point:BEFORE FIELD xcck011 name="construct.b.page1.xcck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck011
            
            #add-point:AFTER FIELD xcck011 name="construct.a.page1.xcck011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck022
            #add-point:ON ACTION controlp INFIELD xcck022 name="construct.c.page1.xcck022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck022  #顯示到畫面上
            NEXT FIELD xcck022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck022
            #add-point:BEFORE FIELD xcck022 name="construct.b.page1.xcck022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck022
            
            #add-point:AFTER FIELD xcck022 name="construct.a.page1.xcck022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002 name="construct.b.page1.xcck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002 name="construct.a.page1.xcck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002 name="construct.c.page1.xcck002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上            
            NEXT FIELD xcck002                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcck044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck044
            #add-point:ON ACTION controlp INFIELD xcck044 name="construct.c.page1.xcck044"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck044  #顯示到畫面上
            NEXT FIELD xcck044                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck044
            #add-point:BEFORE FIELD xcck044 name="construct.b.page1.xcck044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck044
            
            #add-point:AFTER FIELD xcck044 name="construct.a.page1.xcck044"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck201_s
            #add-point:BEFORE FIELD xcck201_s name="construct.b.page1.xcck201_s"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck201_s
            
            #add-point:AFTER FIELD xcck201_s name="construct.a.page1.xcck201_s"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck201_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck201_s
            #add-point:ON ACTION controlp INFIELD xcck201_s name="construct.c.page1.xcck201_s"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202_s
            #add-point:BEFORE FIELD xcck202_s name="construct.b.page1.xcck202_s"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202_s
            
            #add-point:AFTER FIELD xcck202_s name="construct.a.page1.xcck202_s"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202_s
            #add-point:ON ACTION controlp INFIELD xcck202_s name="construct.c.page1.xcck202_s"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt
            #add-point:BEFORE FIELD amt name="construct.b.page1.amt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt
            
            #add-point:AFTER FIELD amt name="construct.a.page1.amt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.amt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt
            #add-point:ON ACTION controlp INFIELD amt name="construct.c.page1.amt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt2
            #add-point:BEFORE FIELD amt2 name="construct.b.page1.amt2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt2
            
            #add-point:AFTER FIELD amt2 name="construct.a.page1.amt2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt2
            #add-point:ON ACTION controlp INFIELD amt2 name="construct.c.page1.amt2"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
#      #150805-00001#11add
#      INPUT g_yy1,g_mm1,g_yy2,g_mm2 FROM xcck004,xcck005,b_xcck004,b_xcck005
#         AFTER FIELD xcck004 
#            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
#                IF g_yy1 > g_yy2 THEN
#                   INITIALIZE g_errparam TO NULL
#                   LET g_errparam.code = 'acr-00064'
#                   LET g_errparam.extend = ''
#                   LET g_errparam.popup = TRUE
#                   CALL cl_err()
#                   NEXT FIELD xcck004
#                END IF
#             END IF
#         AFTER FIELD xcck005
#            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
#               IF g_yy1 = g_yy2 AND g_mm1 > g_mm2 THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'acr-00067'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  NEXT FIELD xcck005
#               END IF
#            END IF
#         AFTER FIELD b_xcck004
#            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
#                IF g_yy1 > g_yy2 THEN
#                   INITIALIZE g_errparam TO NULL
#                   LET g_errparam.code = 'acr-00064'
#                   LET g_errparam.extend = ''
#                   LET g_errparam.popup = TRUE
#                   CALL cl_err()
#                   NEXT FIELD b_xcck004
#                END IF
#             END IF
#         AFTER FIELD b_xcck005   
#            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
#               IF g_yy1 = g_yy2 AND g_mm1 > g_mm2 THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'acr-00067'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  NEXT FIELD b_xcck005
#               END IF
#            END IF     
#      END INPUT
#      #150805-00001#11add
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         #add by chenhz 15/08/18 (s) 使单身能够录入查询条件    
      
            LET g_xcck_d[1].xccksite = ""
            DISPLAY ARRAY g_xcck_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
            END DISPLAY   
#add by chenhz 15/08/18 (e)
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
 
{<section id="axcq913.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq913_query()
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
   CALL g_xcck_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq913_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq913_browser_fill(g_wc)
      CALL axcq913_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq913_browser_fill("F")
   
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
      CALL axcq913_fetch("F") 
   END IF
   
   CALL axcq913_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq913_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
#   #150805-00001#11add
#   CASE p_flag
#      WHEN 'F' 
#         LET g_current_idx = 1
#      WHEN 'L' 
#         LET g_current_idx = g_header_cnt
#         LET g_current_idx = g_browser.getLength()              
#      WHEN 'P'
#         IF g_current_idx > 1 THEN               
#            LET g_current_idx = g_current_idx - 1
#         END IF 
#      WHEN 'N'
#         IF g_current_idx < g_header_cnt THEN
#            LET g_current_idx =  g_current_idx + 1
#         END IF        
#      WHEN '/'
#         IF (NOT g_no_ask) THEN    
#            CALL cl_set_act_visible("accept,cancel", TRUE)    
#            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
#            LET INT_FLAG = 0
# 
#            PROMPT ls_msg CLIPPED,': ' FOR g_jump
#               #交談指令共用ACTION
#               &include "common_action.4gl" 
#            END PROMPT
# 
#            CALL cl_set_act_visible("accept,cancel", FALSE)    
#            IF INT_FLAG THEN
#               LET INT_FLAG = 0
#               EXIT CASE  
#            END IF
#            
#         END IF
#         
#         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
#            LET g_current_idx = g_jump
#         END IF
# 
#         LET g_no_ask = FALSE  
#   END CASE    
#   
#   #若無資料則離開
#   IF g_current_idx = 0 THEN
#      RETURN
#   END IF
#    
#   LET g_detail_cnt = g_header_cnt                  
#   
#   #單身筆數顯示
#   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
#   IF g_detail_cnt > 0 THEN
#       DISPLAY g_detail_idx TO FORMONLY.idx  
#   ELSE
#      LET g_detail_idx = 0
#      DISPLAY ' ' TO FORMONLY.idx    
#   END IF
#   
#   #瀏覽頁筆數顯示
#   LET g_browser_idx = g_pagestart + g_current_idx-1
#   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
#   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
#   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
#   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
#   
#   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
#   
#   #代表沒有資料
#   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
#      RETURN
#   END IF
#   
#   #超出範圍
#   IF g_current_idx > g_browser.getLength() THEN
#      LET g_current_idx = g_browser.getLength()
#   END IF
#   
#   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld
#   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001
#   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003
#   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004
#   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005
#   
#   #重讀DB,因TEMP有不被更新特性
#    EXECUTE axcq513_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
#       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005, 
#       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
#
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "xcck_t" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
#      INITIALIZE g_xcck_m.* TO NULL
#      RETURN
#   END IF
# 
#   #遮罩相關處理
#   LET g_xcck_m_mask_o.* =  g_xcck_m.*
#   CALL axcq913_xcck_t_mask()
#   LET g_xcck_m_mask_n.* =  g_xcck_m.*
#   
#   #根據資料狀態切換action狀態
#   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
#   CALL axcq913_set_act_visible()
#   CALL axcq913_set_act_no_visible()
# 
#   #保存單頭舊值
#   LET g_xcck_m_t.* = g_xcck_m.*
#   LET g_xcck_m_o.* = g_xcck_m.*
#   
#   #重新顯示   
#   CALL axcq913_show()
#   RETURN
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
   
   #CALL axcq913_browser_fill(p_flag)
   
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
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq913_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcck_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq913_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq913_set_act_visible()
   CALL axcq913_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcck_m_t.* = g_xcck_m.*
   LET g_xcck_m_o.* = g_xcck_m.*
   
   #重新顯示   
   CALL axcq913_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq913.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq913_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcck_d.clear()
 
 
   INITIALIZE g_xcck_m.* TO NULL             #DEFAULT 設定
   LET g_xcckld_t = NULL
   LET g_xcck001_t = NULL
   LET g_xcck003_t = NULL
   LET g_xcck004_t = NULL
   LET g_xcck005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq913_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcck_m.* TO NULL
         INITIALIZE g_xcck_d TO NULL
 
         CALL axcq913_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq913_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcck_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq913_set_act_visible()
   CALL axcq913_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq913_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq913_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq913_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq913_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcck001_desc, 
       g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcck003_desc
   
   #功能已完成,通報訊息中心
   CALL axcq913_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq913_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcck_m.xcckld IS NULL
   OR g_xcck_m.xcck001 IS NULL
   OR g_xcck_m.xcck003 IS NULL
   OR g_xcck_m.xcck004 IS NULL
   OR g_xcck_m.xcck005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   CALL s_transaction_begin()
   
   OPEN axcq913_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq913_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq913_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq913_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq913_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq913_show()
   WHILE TRUE
      LET g_xcckld_t = g_xcck_m.xcckld
      LET g_xcck001_t = g_xcck_m.xcck001
      LET g_xcck003_t = g_xcck_m.xcck003
      LET g_xcck004_t = g_xcck_m.xcck004
      LET g_xcck005_t = g_xcck_m.xcck005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq913_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq913_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcck_m.xcckld != g_xcckld_t 
      OR g_xcck_m.xcck001 != g_xcck001_t 
      OR g_xcck_m.xcck003 != g_xcck003_t 
      OR g_xcck_m.xcck004 != g_xcck004_t 
      OR g_xcck_m.xcck005 != g_xcck005_t 
 
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
   CALL axcq913_set_act_visible()
   CALL axcq913_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到對應位置
   CALL axcq913_browser_fill("")
 
   CALL axcq913_idx_chk()
 
   CLOSE axcq913_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq913_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq913.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq913_input(p_cmd)
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
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcck001_desc, 
       g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcck003_desc
   
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
   LET g_forupd_sql = "SELECT xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002, 
       xcck044,xcck201,xcck202 FROM xcck_t WHERE xcckent=? AND xcckld=? AND xcck001=? AND xcck003=?  
       AND xcck004=? AND xcck005=? AND xcck002=? AND xcck006=? AND xcck007=? AND xcck009=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq913_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq913_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq913_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005, 
       g_xcck_m.xcck003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq913.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005, 
          g_xcck_m.xcck003 
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
         AFTER FIELD xcckcomp
            
            #add-point:AFTER FIELD xcckcomp name="input.a.xcckcomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcckcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcckcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcckcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckcomp
            #add-point:BEFORE FIELD xcckcomp name="input.b.xcckcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcckcomp
            #add-point:ON CHANGE xcckcomp name="input.g.xcckcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck004
            #add-point:BEFORE FIELD xcck004 name="input.b.xcck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck004
            
            #add-point:AFTER FIELD xcck004 name="input.a.xcck004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck004
            #add-point:ON CHANGE xcck004 name="input.g.xcck004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001 name="input.a.xcck001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcck001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcck001_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001 name="input.b.xcck001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck001
            #add-point:ON CHANGE xcck001 name="input.g.xcck001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld name="input.a.xcckld"
            IF NOT cl_null(g_xcck_m.xcckld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcckld
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
            LET g_ref_fields[1] = g_xcck_m.xcckld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcckld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcckld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcckld
            #add-point:BEFORE FIELD xcckld name="input.b.xcckld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcckld
            #add-point:ON CHANGE xcckld name="input.g.xcckld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck005
            #add-point:BEFORE FIELD xcck005 name="input.b.xcck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck005
            
            #add-point:AFTER FIELD xcck005 name="input.a.xcck005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck005
            #add-point:ON CHANGE xcck005 name="input.g.xcck005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck003
            
            #add-point:AFTER FIELD xcck003 name="input.a.xcck003"
            IF NOT cl_null(g_xcck_m.xcck003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcck003
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#10--add--end
                  
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
            LET g_ref_fields[1] = g_xcck_m.xcck003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcck003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcck003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck003
            #add-point:BEFORE FIELD xcck003 name="input.b.xcck003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck003
            #add-point:ON CHANGE xcck003 name="input.g.xcck003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcckcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="input.c.xcckcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck004
            #add-point:ON ACTION controlp INFIELD xcck004 name="input.c.xcck004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001 name="input.c.xcck001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcckld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="input.c.xcckld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcckld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcck_m.xcckld = g_qryparam.return1              

            DISPLAY g_xcck_m.xcckld TO xcckld              #

            NEXT FIELD xcckld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck005
            #add-point:ON ACTION controlp INFIELD xcck005 name="input.c.xcck005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003 name="input.c.xcck003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcck003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcck_m.xcck003 = g_qryparam.return1              

            DISPLAY g_xcck_m.xcck003 TO xcck003              #

            NEXT FIELD xcck003                          #返回原欄位


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
            DISPLAY BY NAME g_xcck_m.xcckld             
                            ,g_xcck_m.xcck001   
                            ,g_xcck_m.xcck003   
                            ,g_xcck_m.xcck004   
                            ,g_xcck_m.xcck005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq913_xcck_t_mask_restore('restore_mask_o')
            
               UPDATE xcck_t SET (xcckcomp,xcck004,xcck001,xcckld,xcck005,xcck003) = (g_xcck_m.xcckcomp, 
                   g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005,g_xcck_m.xcck003) 
 
                WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
                  AND xcck001 = g_xcck001_t
                  AND xcck003 = g_xcck003_t
                  AND xcck004 = g_xcck004_t
                  AND xcck005 = g_xcck005_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcck_m.xcckld
               LET gs_keys_bak[1] = g_xcckld_t
               LET gs_keys[2] = g_xcck_m.xcck001
               LET gs_keys_bak[2] = g_xcck001_t
               LET gs_keys[3] = g_xcck_m.xcck003
               LET gs_keys_bak[3] = g_xcck003_t
               LET gs_keys[4] = g_xcck_m.xcck004
               LET gs_keys_bak[4] = g_xcck004_t
               LET gs_keys[5] = g_xcck_m.xcck005
               LET gs_keys_bak[5] = g_xcck005_t
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[9] = g_xcck_d_t.xcck009
               CALL axcq913_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcck_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcck_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq913_xcck_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq913_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcckld_t = g_xcck_m.xcckld
           LET g_xcck001_t = g_xcck_m.xcck001
           LET g_xcck003_t = g_xcck_m.xcck003
           LET g_xcck004_t = g_xcck_m.xcck004
           LET g_xcck005_t = g_xcck_m.xcck005
 
           
           IF g_xcck_d.getLength() = 0 THEN
              NEXT FIELD xcck002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq913.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcck_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcck_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq913_b_fill(g_wc2) #test 
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
            CALL axcq913_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq913_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq913_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq913_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcck_d[l_ac].xcck002 IS NOT NULL
               AND g_xcck_d[l_ac].xcck006 IS NOT NULL
               AND g_xcck_d[l_ac].xcck007 IS NOT NULL
               AND g_xcck_d[l_ac].xcck009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcck_d_t.* = g_xcck_d[l_ac].*  #BACKUP
               LET g_xcck_d_o.* = g_xcck_d[l_ac].*  #BACKUP
               CALL axcq913_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq913_set_no_entry_b(l_cmd)
               OPEN axcq913_bcl USING g_enterprise,g_xcck_m.xcckld,
                                                g_xcck_m.xcck001,
                                                g_xcck_m.xcck003,
                                                g_xcck_m.xcck004,
                                                g_xcck_m.xcck005,
 
                                                g_xcck_d_t.xcck002
                                                ,g_xcck_d_t.xcck006
                                                ,g_xcck_d_t.xcck007
                                                ,g_xcck_d_t.xcck009
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq913_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq913_bcl INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007, 
                      g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
                      g_xcck_d[l_ac].xcck022,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201, 
                      g_xcck_d[l_ac].xcck202
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcck_d_t.xcck002,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
                  CALL axcq913_xcck_t_mask()
                  LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
                  
                  CALL axcq913_ref_show()
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
            INITIALIZE g_xcck_d_t.* TO NULL
            INITIALIZE g_xcck_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcck_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcck_d_t.* = g_xcck_d[l_ac].*     #新輸入資料
            LET g_xcck_d_o.* = g_xcck_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq913_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq913_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[g_xcck_d.getLength()].xcck002 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck006 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck007 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck009 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xcck_t 
             WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
               AND xcck001 = g_xcck_m.xcck001
               AND xcck003 = g_xcck_m.xcck003
               AND xcck004 = g_xcck_m.xcck004
               AND xcck005 = g_xcck_m.xcck005
 
               AND xcck002 = g_xcck_d[l_ac].xcck002
               AND xcck006 = g_xcck_d[l_ac].xcck006
               AND xcck007 = g_xcck_d[l_ac].xcck007
               AND xcck009 = g_xcck_d[l_ac].xcck009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xcck_t
                           (xcckent,
                            xcckcomp,xcck004,xcck001,xcckld,xcck005,xcck003,
                            xcck002,xcck006,xcck007,xcck009
                            ,xccksite,xcck013,xcck010,xcck011,xcck022,xcck044,xcck201,xcck202) 
                     VALUES(g_enterprise,
                            g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005,g_xcck_m.xcck003,
                            g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck009 
 
                            ,g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
                                g_xcck_d[l_ac].xcck022,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201, 
                                g_xcck_d[l_ac].xcck202)
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcck_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
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
               IF axcq913_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcck_m.xcckld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck009
 
 
                  #刪除下層單身
                  IF NOT axcq913_key_delete_b(gs_keys,'xcck_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq913_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq913_bcl
               LET l_count = g_xcck_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcck_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccksite
            
            #add-point:AFTER FIELD xccksite name="input.a.page1.xccksite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xccksite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xccksite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xccksite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccksite
            #add-point:BEFORE FIELD xccksite name="input.b.page1.xccksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccksite
            #add-point:ON CHANGE xccksite name="input.g.page1.xccksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006 name="input.b.page1.xcck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006 name="input.a.page1.xcck006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck006
            #add-point:ON CHANGE xcck006 name="input.g.page1.xcck006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck007
            #add-point:BEFORE FIELD xcck007 name="input.b.page1.xcck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck007
            
            #add-point:AFTER FIELD xcck007 name="input.a.page1.xcck007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck007
            #add-point:ON CHANGE xcck007 name="input.g.page1.xcck007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009 name="input.b.page1.xcck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009 name="input.a.page1.xcck009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck009
            #add-point:ON CHANGE xcck009 name="input.g.page1.xcck009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck013
            #add-point:BEFORE FIELD xcck013 name="input.b.page1.xcck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck013
            
            #add-point:AFTER FIELD xcck013 name="input.a.page1.xcck013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck013
            #add-point:ON CHANGE xcck013 name="input.g.page1.xcck013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010 name="input.a.page1.xcck010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck010
            #add-point:BEFORE FIELD xcck010 name="input.b.page1.xcck010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck010
            #add-point:ON CHANGE xcck010 name="input.g.page1.xcck010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck011
            #add-point:BEFORE FIELD xcck011 name="input.b.page1.xcck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck011
            
            #add-point:AFTER FIELD xcck011 name="input.a.page1.xcck011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck011
            #add-point:ON CHANGE xcck011 name="input.g.page1.xcck011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck022
            
            #add-point:AFTER FIELD xcck022 name="input.a.page1.xcck022"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck022
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck022_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck022_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck022
            #add-point:BEFORE FIELD xcck022 name="input.b.page1.xcck022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck022
            #add-point:ON CHANGE xcck022 name="input.g.page1.xcck022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002 name="input.a.page1.xcck002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002 name="input.b.page1.xcck002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck002
            #add-point:ON CHANGE xcck002 name="input.g.page1.xcck002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck044
            
            #add-point:AFTER FIELD xcck044 name="input.a.page1.xcck044"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck044
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck044_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck044_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck044
            #add-point:BEFORE FIELD xcck044 name="input.b.page1.xcck044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck044
            #add-point:ON CHANGE xcck044 name="input.g.page1.xcck044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck201_s
            #add-point:BEFORE FIELD xcck201_s name="input.b.page1.xcck201_s"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck201_s
            
            #add-point:AFTER FIELD xcck201_s name="input.a.page1.xcck201_s"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck201_s
            #add-point:ON CHANGE xcck201_s name="input.g.page1.xcck201_s"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202_s
            #add-point:BEFORE FIELD xcck202_s name="input.b.page1.xcck202_s"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202_s
            
            #add-point:AFTER FIELD xcck202_s name="input.a.page1.xcck202_s"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202_s
            #add-point:ON CHANGE xcck202_s name="input.g.page1.xcck202_s"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt
            #add-point:BEFORE FIELD amt name="input.b.page1.amt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt
            
            #add-point:AFTER FIELD amt name="input.a.page1.amt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt
            #add-point:ON CHANGE amt name="input.g.page1.amt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt1
            #add-point:BEFORE FIELD amt1 name="input.b.page1.amt1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt1
            
            #add-point:AFTER FIELD amt1 name="input.a.page1.amt1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt1
            #add-point:ON CHANGE amt1 name="input.g.page1.amt1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt2
            #add-point:BEFORE FIELD amt2 name="input.b.page1.amt2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt2
            
            #add-point:AFTER FIELD amt2 name="input.a.page1.amt2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt2
            #add-point:ON CHANGE amt2 name="input.g.page1.amt2"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xccksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccksite
            #add-point:ON ACTION controlp INFIELD xccksite name="input.c.page1.xccksite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006 name="input.c.page1.xcck006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck007
            #add-point:ON ACTION controlp INFIELD xcck007 name="input.c.page1.xcck007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009 name="input.c.page1.xcck009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck013
            #add-point:ON ACTION controlp INFIELD xcck013 name="input.c.page1.xcck013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010 name="input.c.page1.xcck010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011 name="input.c.page1.xcck011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck022
            #add-point:ON ACTION controlp INFIELD xcck022 name="input.c.page1.xcck022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002 name="input.c.page1.xcck002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck044
            #add-point:ON ACTION controlp INFIELD xcck044 name="input.c.page1.xcck044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck201_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck201_s
            #add-point:ON ACTION controlp INFIELD xcck201_s name="input.c.page1.xcck201_s"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202_s
            #add-point:ON ACTION controlp INFIELD xcck202_s name="input.c.page1.xcck202_s"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt
            #add-point:ON ACTION controlp INFIELD amt name="input.c.page1.amt"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt1
            #add-point:ON ACTION controlp INFIELD amt1 name="input.c.page1.amt1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt2
            #add-point:ON ACTION controlp INFIELD amt2 name="input.c.page1.amt2"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               CLOSE axcq913_bcl
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
               LET g_errparam.extend = g_xcck_d[l_ac].xcck002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq913_xcck_t_mask_restore('restore_mask_o')
         
               UPDATE xcck_t SET (xcckld,xcck001,xcck003,xcck004,xcck005,xccksite,xcck006,xcck007,xcck009, 
                   xcck013,xcck010,xcck011,xcck022,xcck002,xcck044,xcck201,xcck202) = (g_xcck_m.xcckld, 
                   g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_d[l_ac].xccksite, 
                   g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013, 
                   g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck022,g_xcck_d[l_ac].xcck002, 
                   g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202)
                WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld 
                 AND xcck001 = g_xcck_m.xcck001 
                 AND xcck003 = g_xcck_m.xcck003 
                 AND xcck004 = g_xcck_m.xcck004 
                 AND xcck005 = g_xcck_m.xcck005 
 
                 AND xcck002 = g_xcck_d_t.xcck002 #項次   
                 AND xcck006 = g_xcck_d_t.xcck006  
                 AND xcck007 = g_xcck_d_t.xcck007  
                 AND xcck009 = g_xcck_d_t.xcck009  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcck_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcck_m.xcckld
               LET gs_keys_bak[1] = g_xcckld_t
               LET gs_keys[2] = g_xcck_m.xcck001
               LET gs_keys_bak[2] = g_xcck001_t
               LET gs_keys[3] = g_xcck_m.xcck003
               LET gs_keys_bak[3] = g_xcck003_t
               LET gs_keys[4] = g_xcck_m.xcck004
               LET gs_keys_bak[4] = g_xcck004_t
               LET gs_keys[5] = g_xcck_m.xcck005
               LET gs_keys_bak[5] = g_xcck005_t
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[9] = g_xcck_d_t.xcck009
               CALL axcq913_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq913_xcck_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcck_m.xcckld
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck001
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck003
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck004
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck002
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck006
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck007
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck009
 
               CALL axcq913_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq913_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axcq913_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcck_d.getLength() = 0 THEN
               NEXT FIELD xcck002
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[li_reproduce_target].xcck002 = NULL
               LET g_xcck_d[li_reproduce_target].xcck006 = NULL
               LET g_xcck_d[li_reproduce_target].xcck007 = NULL
               LET g_xcck_d[li_reproduce_target].xcck009 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcck_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcck_d.getLength()+1
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
            NEXT FIELD xcckld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccksite
 
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
 
{<section id="axcq913.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq913_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #fengmy 150109----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcck_m.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   END IF
              
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF  
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_1',TRUE)                    
   ELSE                                         
      CALL cl_set_comp_visible('xcck011,xcck011_1',FALSE)                
   END IF   
   #fengmy 150109----end
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq913_b_fill(g_wc2) #第一階單身填充
      CALL axcq913_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq913_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcck_m.xcckld
      
      
   CASE g_xcck_m.xcck001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''                  
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
   END CASE                             
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcck001_desc, 
       g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcck003_desc
 
   CALL axcq913_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
#   #150805-00001#11add
#   DISPLAY g_yy1 TO xcck004
#   DISPLAY g_mm1 TO xcck005
#   DISPLAY g_yy2 TO b_xcck004
#   DISPLAY g_mm2 TO b_xcck005
#   #150805-00001#11add
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq913_ref_show()
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
   FOR l_ac = 1 TO g_xcck_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
 
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq913.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq913_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcck_t.xcckld 
   DEFINE l_oldno     LIKE xcck_t.xcckld 
   DEFINE l_newno02     LIKE xcck_t.xcck001 
   DEFINE l_oldno02     LIKE xcck_t.xcck001 
   DEFINE l_newno03     LIKE xcck_t.xcck003 
   DEFINE l_oldno03     LIKE xcck_t.xcck003 
   DEFINE l_newno04     LIKE xcck_t.xcck004 
   DEFINE l_oldno04     LIKE xcck_t.xcck004 
   DEFINE l_newno05     LIKE xcck_t.xcck005 
   DEFINE l_oldno05     LIKE xcck_t.xcck005 
 
   DEFINE l_master    RECORD LIKE xcck_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcck_t.* #此變數樣板目前無使用
 
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
 
   IF g_xcck_m.xcckld IS NULL
      OR g_xcck_m.xcck001 IS NULL
      OR g_xcck_m.xcck003 IS NULL
      OR g_xcck_m.xcck004 IS NULL
      OR g_xcck_m.xcck005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   LET g_xcck_m.xcckld = ""
   LET g_xcck_m.xcck001 = ""
   LET g_xcck_m.xcck003 = ""
   LET g_xcck_m.xcck004 = ""
   LET g_xcck_m.xcck005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq913_set_entry('a')
   CALL axcq913_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcck_m.xcck001_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck001_desc
   LET g_xcck_m.xcckld_desc = ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc
   LET g_xcck_m.xcck003_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
 
   
   CALL axcq913_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcck_m.* TO NULL
      INITIALIZE g_xcck_d TO NULL
 
      CALL axcq913_show()
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
   CALL axcq913_set_act_visible()
   CALL axcq913_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq913_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq913_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq913_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq913_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcck_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq913_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
    AND xcck001 = g_xcck001_t
    AND xcck003 = g_xcck003_t
    AND xcck004 = g_xcck004_t
    AND xcck005 = g_xcck005_t
 
       INTO TEMP axcq913_detail
   
   #將key修正為調整後   
   UPDATE axcq913_detail 
      #更新key欄位
      SET xcckld = g_xcck_m.xcckld
          , xcck001 = g_xcck_m.xcck001
          , xcck003 = g_xcck_m.xcck003
          , xcck004 = g_xcck_m.xcck004
          , xcck005 = g_xcck_m.xcck005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcck_t SELECT * FROM axcq913_detail
   
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
   DROP TABLE axcq913_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   DROP TABLE axcq913_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq913_delete()
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
   
   IF g_xcck_m.xcckld IS NULL
   OR g_xcck_m.xcck001 IS NULL
   OR g_xcck_m.xcck003 IS NULL
   OR g_xcck_m.xcck004 IS NULL
   OR g_xcck_m.xcck005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq913_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq913_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq913_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq913_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck001,g_xcck_m.xcckld,g_xcck_m.xcck005, 
       g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck001_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck003_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq913_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL axcq913_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq913_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcck_t WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
                                                               AND xcck001 = g_xcck_m.xcck001
                                                               AND xcck003 = g_xcck_m.xcck003
                                                               AND xcck004 = g_xcck_m.xcck004
                                                               AND xcck005 = g_xcck_m.xcck005
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
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
      #   CLOSE axcq913_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcck_d.clear() 
 
     
      CALL axcq913_ui_browser_refresh()  
      #CALL axcq913_ui_headershow()  
      #CALL axcq913_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq913_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq913_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq913_cl
 
   #功能已完成,通報訊息中心
   CALL axcq913_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq913.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq913_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql             STRING
   DEFINE l_xcck202_sum     LIKE xcck_t.xcck202
   DEFINE l_amt_sum         LIKE xcck_t.xcck202
   DEFINE l_amt1_sum        LIKE xcck_t.xcck202
   DEFINE l_xcck202_total   LIKE xcck_t.xcck202
   DEFINE l_amt_total       LIKE xcck_t.xcck202
   DEFINE l_amt1_total      LIKE xcck_t.xcck202
   DEFINE l_xmdk014         LIKE xmdk_t.xmdk014
   DEFINE l_xmdl027         LIKE xmdl_t.xmdl027
   DEFINE l_xmdl028         LIKE xmdl_t.xmdl028
   #20150317  --Begin
   DEFINE l_xrcb113         LIKE xrcb_t.xrcb113
   DEFINE l_xrcb123         LIKE xrcb_t.xrcb123
   DEFINE l_xrcb133         LIKE xrcb_t.xrcb133
   DEFINE l_xrcb022         LIKE xrcb_t.xrcb022
   #20150317  --End
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   #160520-00002#5 add--s--
   CALL axcq913_b_fill1()
   RETURN
   #160520-00002#5 add--e---
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcck_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #150805-00001#11add
   #CALL axcq913_b_fill_1()
   #RETURN
   #150805-00001#11add
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002, 
       xcck044,xcck201,xcck202,t1.ooefl003 ,t2.imaal003 ,t3.pmaal004 ,t4.xcbfl003 ,t5.oocal003 FROM xcck_t", 
          
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xcck010 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=xcck022 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t4 ON t4.xcbflent="||g_enterprise||" AND t4.xcbflcomp=xcckcomp AND t4.xcbfl001=xcck002 AND t4.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
 
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002, 
       xcck044,SUM(xcck201*xcck009*-1),SUM(xcck202*xcck009*-1),t1.ooefl003 ,t2.imaal003 ,t3.pmaal004 ,t4.xcbfl003 ,t5.oocal003 FROM xcck_t",  
          
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcck010 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent='"||g_enterprise||"' AND t3.pmaal001=xcck022 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t4 ON t4.xcbflent='"||g_enterprise||"' AND t4.xcbflcomp=xcckcomp AND t4.xcbfl001=xcck002 AND t4.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
 
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?" 

   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
#   LET g_sql = g_sql," AND (xcck055 = '305' OR xcck055 = '307')",   #fengmy 150112 mark
   LET g_sql = g_sql," AND xcck055 IN ('305','307','303','215')",    #fengmy 150112
               " GROUP BY xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,xcck044,t1.ooefl003,t2.imaal003,t3.pmaal004,t4.xcbfl003,t5.oocal003"
   LET l_sql = g_sql
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq913_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck009"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET g_sql = l_sql, " ORDER BY xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,xcck044"
      LET l_xcck202_sum = 0
      LET l_amt_sum = 0
      LET l_amt1_sum = 0
      LET l_xcck202_total = 0
      LET l_amt_total = 0
      LET l_amt1_total = 0
      LET g_sql_tmp = g_sql  #dujuan150324
     
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq913_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq913_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
          g_xcck_m.xcck005 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007, 
          g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
          g_xcck_d[l_ac].xcck022,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201, 
          g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xccksite_desc,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck022_desc, 
          g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck044_desc   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"

         #销售收入
         #20150317  --Begin
         #SELECT xmdl027 INTO l_xmdl027 FROM xmdl_t
         # WHERE xmdlent = g_enterprise AND xmdldocno = g_xcck_d[l_ac].xcck006 AND xmdlseq = g_xcck_d[l_ac].xcck007
         
 
         SELECT xrcb113,xrcb123,xrcb133,xrcb022 INTO l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022
           FROM xrca_t,xrcb_t
          WHERE xrcaent = xrcbent AND xrcaent = g_enterprise
            AND xrcald  = xrcbld  AND xrcald  = g_xcck_m.xcckld
            AND xrcadocno = xrcbdocno
            AND xrca001 IN ('01','02','12','17','22')
            AND xrcb002 = g_xcck_d[l_ac].xcck006
            AND xrcb003 = g_xcck_d[l_ac].xcck007
            AND xrcb023 <> 'Y'
            
 
         
         CASE g_xcck_m.xcck001
              WHEN '1' LET g_xcck_d[l_ac].amt = l_xrcb113 * l_xrcb022
              WHEN '2' LET g_xcck_d[l_ac].amt = l_xrcb123 * l_xrcb022
              WHEN '3' LET g_xcck_d[l_ac].amt = l_xrcb133 * l_xrcb022
         END CASE


         #LET g_xcck_d[l_ac].amt = l_xmdl027
         #LET g_xcck_d[l_ac].amt = g_xcck_d[l_ac].amt * g_xcck_d[l_ac].xcck009*-1
         #20150317  --End
         IF cl_null(g_xcck_d[l_ac].amt) THEN
            LET g_xcck_d[l_ac].amt = 0
         END IF
         
         #毛利
         LET g_xcck_d[l_ac].amt1 = g_xcck_d[l_ac].amt - g_xcck_d[l_ac].xcck202
         
         #毛利率
         LET g_xcck_d[l_ac].amt2 = g_xcck_d[l_ac].amt1 / g_xcck_d[l_ac].amt * 100
         CALL s_num_round('1',g_xcck_d[l_ac].amt2,2) RETURNING g_xcck_d[l_ac].amt2
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
         LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , ''
          
         CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc
         
         #依成本组织小计
         LET l_xcck202_sum = l_xcck202_sum + g_xcck_d[l_ac].xcck202
         LET l_amt_sum = l_amt_sum + g_xcck_d[l_ac].amt
         LET l_amt1_sum = l_amt1_sum + g_xcck_d[l_ac].amt1
         LET l_xcck202_total = l_xcck202_total + g_xcck_d[l_ac].xcck202
         LET l_amt_total = l_amt_total + g_xcck_d[l_ac].amt
         LET l_amt1_total = l_amt1_total + g_xcck_d[l_ac].amt1
         IF l_ac > 1 THEN
            IF g_xcck_d[l_ac].xccksite != g_xcck_d[l_ac - 1].xccksite THEN   
               #把当前行下移，并在当前行显示小计
               LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*  
               INITIALIZE  g_xcck_d[l_ac].* TO NULL              
               LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)
               LET g_xcck_d[l_ac].xcck202 = l_xcck202_sum - g_xcck_d[l_ac + 1].xcck202
               LET g_xcck_d[l_ac].amt = l_amt_sum - g_xcck_d[l_ac + 1].amt
               LET g_xcck_d[l_ac].amt1 = l_amt1_sum - g_xcck_d[l_ac + 1].amt1
               LET l_ac = l_ac + 1
               LET l_xcck202_sum = g_xcck_d[l_ac].xcck202
               LET l_amt_sum = g_xcck_d[l_ac].amt
               LET l_amt1_sum = g_xcck_d[l_ac].amt1
            END IF
         END IF
               
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
 
            CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   #最后一组小计
   LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)
   LET g_xcck_d[l_ac].xcck202 = l_xcck202_sum
   LET g_xcck_d[l_ac].amt = l_amt_sum
   LET g_xcck_d[l_ac].amt1 = l_amt1_sum
   LET l_ac = l_ac + 1
   #合计
   LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00204",g_lang)
   LET g_xcck_d[l_ac].xcck202 = l_xcck202_total
   LET g_xcck_d[l_ac].amt = l_amt_total
   LET g_xcck_d[l_ac].amt1 = l_amt1_total
   LET l_ac = l_ac + 1
      #20150806--add--str--lujh
   IF axcq913_fill_chk(1) THEN   
      LET g_sql = "SELECT xcck028,SUM(xcck202*xcck009)",
                  "  FROM xcck_t ",
                  " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?"                 
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
      END IF
      
      LET g_sql = g_sql," AND xcck055 IN ('305','307','303','215')"
      
      LET g_sql = g_sql," GROUP BY xcck028 ",
                        " ORDER BY xcck028 "	
      PREPARE axcq913_xcck_sum_prep FROM g_sql
      DECLARE axcq913_xcck_sum_cs CURSOR FOR axcq913_xcck_sum_prep

      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN axcq913_xcck_sum_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
                                         
      FOREACH axcq913_xcck_sum_cs INTO g_xcck3_d[l_ac].xcck028,g_xcck3_d[l_ac].xcck202
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xcck:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck3_d[l_ac].xcck028
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck3_d[l_ac].xcck028_2_desc = '', g_rtn_fields[1] , ''
            
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF         
      END FOREACH
   END IF

   CALL g_xcck3_d.deleteElement(g_xcck3_d.getLength())
   FREE axcq913_xcck_sum_prep
   #20150806--add--end--lujh
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcck_d.getLength()
      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
      CALL axcq913_xcck_t_mask()
      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
   END FOR
   
 
 
   FREE axcq913_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq913_idx_chk()
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
      IF g_detail_idx > g_xcck_d.getLength() THEN
         LET g_detail_idx = g_xcck_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcck_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcck_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq913_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_xcck201_sum      LIKE xcck_t.xcck201     #dorislai-20150923-add
   DEFINE l_xcck202a_sum     LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum     LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum     LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum     LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum     LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum     LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum     LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum     LIKE xcck_t.xcck202h
   DEFINE l_xcck202_sum      LIKE xcck_t.xcck202
   DEFINE l_amt3_sum         LIKE xcck_t.xcck202
   DEFINE l_amt5_sum         LIKE xcck_t.xcck202
   DEFINE l_xcck201_sum1     LIKE xcck_t.xcck201     #dorislai-20150923-add
   DEFINE l_xcck202a_sum1    LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum1    LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum1    LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum1    LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum1    LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum1    LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum1    LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum1    LIKE xcck_t.xcck202h
   DEFINE l_xcck202_sum1     LIKE xcck_t.xcck202
   DEFINE l_amt3_sum1        LIKE xcck_t.xcck202
   DEFINE l_amt5_sum1        LIKE xcck_t.xcck202
   DEFINE l_xcck201_sum2     LIKE xcck_t.xcck201     #dorislai-20150923-add
   DEFINE l_xcck202a_sum2    LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum2    LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum2    LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum2    LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum2    LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum2    LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum2    LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum2    LIKE xcck_t.xcck202h
   DEFINE l_xcck202_sum2     LIKE xcck_t.xcck202
   DEFINE l_amt3_sum2        LIKE xcck_t.xcck202
   DEFINE l_amt5_sum2        LIKE xcck_t.xcck202
   DEFINE l_xcck201_total    LIKE xcck_t.xcck201     #dorislai-20150923-add
   DEFINE l_xcck202a_total   LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_total   LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_total   LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_total   LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_total   LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_total   LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_total   LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_total   LIKE xcck_t.xcck202h
   DEFINE l_xcck202_total    LIKE xcck_t.xcck202
   DEFINE l_amt3_total       LIKE xcck_t.xcck202
   DEFINE l_amt5_total       LIKE xcck_t.xcck202
   DEFINE l_i                LIKE type_t.num5
   DEFINE l_j                LIKE type_t.num5
   DEFINE l_xcck006          LIKE xcck_t.xcck006
   DEFINE l_xcck007          LIKE xcck_t.xcck007
   DEFINE l_xcck009          LIKE xcck_t.xcck009
   DEFINE l_xmdk014          LIKE xmdk_t.xmdk014
   DEFINE l_xmdl027          LIKE xmdl_t.xmdl027
   DEFINE l_xmdl028          LIKE xmdl_t.xmdl028
   DEFINE l_xcck004         LIKE xcck_t.xcck004  #dorislai-20150922-add
   DEFINE l_xcck005         LIKE xcck_t.xcck005  #dorislai-20150922-add
   DEFINE l_sql             STRING   #160520-00002#5
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcck_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   #先清空單身變數內容
   CALL g_xcck2_d.clear()
#160520-00002#5 mod--s--   
#   LET g_sql = "SELECT UNIQUE xccksite,'',xcck024,xcck029,xcck010,'','',xcck011,xcck021,'',xcck022,'',xcck023,",
#               " xcck025,'',xcck026,xcck027,xcck028,xcck030,xcck031,xcck044,'',SUM(xcck201*xcck009*-1),SUM(xcck202a*xcck009*-1),",
#               " SUM(xcck202b*xcck009*-1),SUM(xcck202c*xcck009*-1),SUM(xcck202d*xcck009*-1),SUM(xcck202e*xcck009*-1),SUM(xcck202f*xcck009*-1),",
#               " SUM(xcck202g*xcck009*-1),SUM(xcck202h*xcck009*-1),SUM(xcck202*xcck009*-1),'','','','','' FROM xcck_t ",
#               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=? ",
##               "   AND (xcck055 = '305' OR xcck055 = '307') "    #fengmy 150112 mark
#               " AND xcck055 IN ('305','307','303','215') "       #fengmy 150112
   LET g_sql = "SELECT UNIQUE xccksite,",
               "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='",g_enterprise,"' AND ooefl001=xccksite AND ooefl002='",g_dlang,"'),",
               "       xcck024,xcck029,xcck010,",
               "       (SELECT imaal003 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xcck010 AND imaal002='",g_dlang,"'),",
               "       (SELECT imaal004 FROM imaal_t WHERE imaalent='",g_enterprise,"' AND imaal001=xcck010 AND imaal002='",g_dlang,"'),",               
               "       xcck011,xcck021,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent='",g_enterprise,"' AND oocql001='",g_acc,"' AND oocql002 = xcck021 AND oocql003='",g_dlang,"'),",
               "       xcck022,",
               "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent='",g_enterprise,"' AND pmaal001=xcck022 AND pmaal002='",g_dlang,"'),",
               "       xcck023,xcck025,",
               "       (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='",g_enterprise,"' AND ooefl001=xcck025 AND ooefl002='",g_dlang,"'),",
               "       xcck026,xcck027,xcck028,xcck030,xcck031,xcck044,",
               "       (SELECT oocal003 FROM oocal_t WHERE oocalent='",g_enterprise,"' AND oocal001=xcck044 AND oocal002='",g_dlang,"'),",
               "       SUM(xcck201*xcck009*-1),SUM(xcck202a*xcck009*-1),",
               " SUM(xcck202b*xcck009*-1),SUM(xcck202c*xcck009*-1),SUM(xcck202d*xcck009*-1),SUM(xcck202e*xcck009*-1),SUM(xcck202f*xcck009*-1),",
               " SUM(xcck202g*xcck009*-1),SUM(xcck202h*xcck009*-1),SUM(xcck202*xcck009*-1),'','','','','' FROM xcck_t ",
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=? ",
#               "   AND (xcck055 = '305' OR xcck055 = '307') "    #fengmy 150112 mark
               " AND xcck055 IN ('305','307','303','215') "       #fengmy 150112
#160520-00002#5 mod--e---
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
#160520-00002#5 mod--s---  
#   LET g_sql = g_sql, " GROUP BY xccksite,xcck024,xcck029,xcck010,xcck011,xcck021,xcck022,xcck023,xcck025,",
#                      " xcck026,xcck027,xcck028,xcck030,xcck031,xcck044 ",
   LET g_sql = g_sql, " GROUP BY xccksite,'',xcck024,xcck029,xcck010,'','',xcck011,xcck021,'',xcck022,'',xcck023,xcck025,'',",
                      " xcck026,xcck027,xcck028,xcck030,xcck031,xcck044,'' ",  
#160520-00002#5 mod--e---                      
                      " ORDER BY xccksite,xcck024,xcck029,xcck010,xcck011,xcck021,xcck022,xcck023,xcck025,",
                      " xcck026,xcck027,xcck028,xcck030,xcck031,xcck044 "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq513_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR axcq513_pb1
   
   #160520-00002#5 add---s---
   LET g_sql = "SELECT CASE WHEN SUM(xmdl027*xcck009*-1) IS NULL THEN 0 ELSE SUM(xmdl027*xcck009*-1) END FROM xcck_t,xmdl_t ",    
              " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=? ",
              "   AND xccksite=? AND xcck024=? AND xcck029=? AND xcck010=? AND xcck011=? AND xcck021=? ", 
              "   AND xcck022=? AND xcck023=? AND xcck025=? AND xcck026=? AND xcck027=? AND xcck028=? ",          
              "   AND xcck030=? AND xcck031=? AND xcck044=? ",                                            
               "   AND xcck055 IN ('305','307','303','215')", 
              "   AND xmdlent = xcckent",
              "   AND xmdldocno = xcck006",
               "   AND xmdlseq   = xcck007",
             "   AND (xcck008 = 0 OR xcck008 = 1 OR xcck008 IS NULL)"
   PREPARE axcq913_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR axcq913_pb2  


   LET l_sql = "SELECT SUM(xcck201*xcck009*-1),SUM(xcck202a*xcck009*-1),SUM(xcck202b*xcck009*-1),",
               "                    SUM(xcck202c*xcck009*-1),SUM(xcck202d*xcck009*-1),",
               "                    SUM(xcck202e*xcck009*-1),SUM(xcck202f*xcck009*-1),",
               "                    SUM(xcck202g*xcck009*-1),SUM(xcck202h*xcck009*-1),",
               "       SUM(xcck202*xcck009*-1)  ",
               "  FROM xcck_t ",
               " WHERE xcckent= '",g_enterprise,"' AND xcckld='",g_xcck_m.xcckld,"' AND xcck001= '",g_xcck_m.xcck001,"'",
               "   AND xcck003= '",g_xcck_m.xcck003,"' AND xcck004='",g_xcck_m.xcck004,"' AND xcck005='",g_xcck_m.xcck005,"' ",
               "   AND xcck055 IN ('305','307','303','215') "
  PREPARE axcq913_sum_pr FROM l_sql   
  
  LET g_sql = l_sql , " AND xccksite = ? AND xcck024 = ? AND xcck029 = ?"
  PREPARE axcq913_sum_pr1 FROM g_sql

  LET g_sql = l_sql , " AND xccksite = ? AND xcck024 = ? "
  PREPARE axcq913_sum_pr2 FROM g_sql 
  
  LET g_sql = l_sql , " AND xccksite = ? "
  PREPARE axcq913_sum_pr3 FROM g_sql  
   #160520-00002#5 add---e---          
                
                
   LET g_cnt = l_ac
   LET l_ac = 1
  # LET l_xcck201_sum = 0   #dorislai-20150923-add
#160520-00002#5  mod--s--- 
#   LET l_xcck202a_sum = 0
#   LET l_xcck202b_sum = 0
#   LET l_xcck202c_sum = 0
#   LET l_xcck202d_sum = 0
#   LET l_xcck202e_sum = 0
#   LET l_xcck202f_sum = 0
#   LET l_xcck202g_sum = 0
#   LET l_xcck202h_sum = 0
#   LET l_xcck202_sum  = 0
   LET l_amt3_sum     = 0
   LET l_amt5_sum     = 0
  # LET l_xcck201_sum1 = 0  #dorislai-20150923-add
#   LET l_xcck202a_sum1 = 0
#   LET l_xcck202b_sum1 = 0
#   LET l_xcck202c_sum1 = 0
#   LET l_xcck202d_sum1 = 0
#   LET l_xcck202e_sum1 = 0
#   LET l_xcck202f_sum1 = 0
#   LET l_xcck202g_sum1 = 0
#   LET l_xcck202h_sum1 = 0
#   LET l_xcck202_sum1  = 0
   LET l_amt3_sum1    = 0
   LET l_amt5_sum1    = 0
   #LET l_xcck201_sum2 = 0   #dorislai-20150923-add
#   LET l_xcck202a_sum2 = 0
#   LET l_xcck202b_sum2 = 0
#   LET l_xcck202c_sum2 = 0
#   LET l_xcck202d_sum2 = 0
#   LET l_xcck202e_sum2 = 0
#   LET l_xcck202f_sum2 = 0
#   LET l_xcck202g_sum2 = 0
#   LET l_xcck202h_sum2 = 0
#   LET l_xcck202_sum2  = 0
   LET l_amt3_sum2    = 0
   LET l_amt5_sum2    = 0
  # LET l_xcck201_total = 0  #dorislai-20150923-add
#   LET l_xcck202a_total = 0
#   LET l_xcck202b_total = 0
#   LET l_xcck202c_total = 0
#   LET l_xcck202d_total = 0
#   LET l_xcck202e_total = 0
#   LET l_xcck202f_total = 0
#   LET l_xcck202g_total = 0
#   LET l_xcck202h_total = 0
#   LET l_xcck202_total  = 0
#160520-00002#5   mod--e---
   LET l_amt3_total     = 0
   LET l_amt5_total     = 0
   LET l_i = 1
   LET l_j = 1
   
 OPEN b_fill_cs1 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
                                              
   FOREACH b_fill_cs1 INTO g_xcck2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #销售收入
#wujie 150303 --begin
#      LET g_sql = "SELECT xcck006,xcck007,xcck009 FROM xcck_t ",
#                  " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=? ",
##                  "   AND xccksite=? AND xcck024=? AND xcck029=? AND xcck010=? AND xcck011=? AND xcck021=? ",  #fengmy 150109 mark
##                  "   AND xcck022=? AND xcck023=? AND xcck025=? AND xcck026=? AND xcck027=? AND xcck028=? ",   #fengmy 150109 mark
##                  "   AND xcck030=? AND xcck031=? AND xcck044=? ",                                             #fengmy 150109 mark
##                  "   AND (xcck055 = '305' OR xcck055 = '307') "                                               #fengmy 150112 mark
#                   "   AND xcck055 IN ('305','307','303','215')"                                                #fengmy 150112  
#      IF NOT cl_null(g_xcck2_d[l_ac].xccksite_1) THEN
#         LET g_sql = g_sql," AND xccksite = '",g_xcck2_d[l_ac].xccksite_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck024_1) THEN
#         LET g_sql = g_sql," AND xcck024 = '",g_xcck2_d[l_ac].xcck024_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck029_1) THEN
#         LET g_sql = g_sql," AND xcck029 = '",g_xcck2_d[l_ac].xcck029_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck010_1) THEN
#         LET g_sql = g_sql," AND xcck010 = '",g_xcck2_d[l_ac].xcck010_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck011_1) THEN
#         LET g_sql = g_sql," AND xcck011 = '",g_xcck2_d[l_ac].xcck011_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck021_1) THEN
#         LET g_sql = g_sql," AND xcck021 = '",g_xcck2_d[l_ac].xcck021_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck022_1) THEN
#         LET g_sql = g_sql," AND xcck022 = '",g_xcck2_d[l_ac].xcck022_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck023_1) THEN
#         LET g_sql = g_sql," AND xcck023 = '",g_xcck2_d[l_ac].xcck023_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck025_1) THEN
#         LET g_sql = g_sql," AND xcck025 = '",g_xcck2_d[l_ac].xcck025_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck026_1) THEN
#         LET g_sql = g_sql," AND xcck026 = '",g_xcck2_d[l_ac].xcck026_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck027_1) THEN
#         LET g_sql = g_sql," AND xcck027 = '",g_xcck2_d[l_ac].xcck027_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck028_1) THEN
#         LET g_sql = g_sql," AND xcck028 = '",g_xcck2_d[l_ac].xcck028_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck030_1) THEN
#         LET g_sql = g_sql," AND xcck030 = '",g_xcck2_d[l_ac].xcck030_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck031_1) THEN
#         LET g_sql = g_sql," AND xcck031 = '",g_xcck2_d[l_ac].xcck031_1,"'"
#      END IF
#      IF NOT cl_null(g_xcck2_d[l_ac].xcck044_1) THEN
#         LET g_sql = g_sql," AND xcck044 = '",g_xcck2_d[l_ac].xcck044_1,"'"
#      END IF
#      IF NOT cl_null(g_wc2_table1) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
#      END IF
   #dorislai-20151112-mark----(S)   
      #dorislai-20150922-add----(S)
#      LET g_sql = "SELECT  DISTINCT xcck004,xcck005 FROM xcck_t ",
#                  "  LEFT JOIN xmdl_t ON xmdlent = xcckent ",
#                  "   AND xmdldocno = xcck006",
#                  "   AND xmdlseq   = xcck007",
#                  "   AND (xcck008 = 0 OR xcck008 = 1 OR xcck008 IS NULL) ",
#                  " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=?  ",
#                  "   AND xccksite=? AND xcck024=? AND xcck029=? AND xcck010=? AND xcck011=? AND xcck021=? ",
#                  "   AND xcck022=? AND xcck023=? AND xcck025=? AND xcck026=? AND xcck027=? AND xcck028=? ",
#                  "   AND xcck030=? AND xcck031=? AND xcck044=? ",
#                  "   AND xcck055 IN ('305','307','303','215')"
#
#      PREPARE axcq913_pb4 FROM g_sql
#      DECLARE b_fill_cs4 CURSOR FOR axcq913_pb4
#      OPEN b_fill_cs4 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,
#                            g_xcck2_d[l_ac].xccksite_1,g_xcck2_d[l_ac].xcck024_1,g_xcck2_d[l_ac].xcck029_1,g_xcck2_d[l_ac].xcck010_1,g_xcck2_d[l_ac].xcck011_1,
#                            g_xcck2_d[l_ac].xcck021_1,g_xcck2_d[l_ac].xcck022_1,g_xcck2_d[l_ac].xcck023_1,g_xcck2_d[l_ac].xcck025_1,g_xcck2_d[l_ac].xcck026_1,             
#                            g_xcck2_d[l_ac].xcck027_1,g_xcck2_d[l_ac].xcck028_1,g_xcck2_d[l_ac].xcck030_1,g_xcck2_d[l_ac].xcck031_1,g_xcck2_d[l_ac].xcck044_1
#      FETCH b_fill_cs4 INTO l_xcck004,l_xcck005
      #dorislai-20150922-add----(E)
   #dorislai-20151112-mark----(E)   
      
      #dorislai-20151006-modify----(S)
       #這段是最原始的，沒改過的，回收时还用的原来的
#160520-00002#5 add---s---       
#LET g_sql = "SELECT SUM(xmdl027*xcck009*-1) FROM xcck_t,xmdl_t ",     
#                 " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=? ",
#                 "   AND xccksite=? AND xcck024=? AND xcck029=? AND xcck010=? AND xcck011=? AND xcck021=? ", 
#                 "   AND xcck022=? AND xcck023=? AND xcck025=? AND xcck026=? AND xcck027=? AND xcck028=? ",          
#                 "   AND xcck030=? AND xcck031=? AND xcck044=? ",                                            
#                  "   AND xcck055 IN ('305','307','303','215')", 
#                 "   AND xmdlent = xcckent",
#                 "   AND xmdldocno = xcck006",
#                  "   AND xmdlseq   = xcck007",
#                "   AND (xcck008 = 0 OR xcck008 = 1 OR xcck008 IS NULL)"
#160520-00002#5 add---e---
     #----dorislai-20151112-mod-(S)
       #這段是在dorislai-20151006-modify有改過
#      LET g_sql = "SELECT SUM(xrcb113*xcck009*-1) FROM xcck_t ",
#                  "  LEFT OUTER JOIN xrcb_t ON xrcbent = xcckent AND xrcb002 = xcck006 AND xrcb003 = xcck007",      
#                  " INNER JOIN xrca_t ON xrcbent = xrcaent AND xrcbld = xrcald AND xrcbdocno = xrcadocno AND xrcastus <> 'X'",   #151101 Sarah add 
#                  " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=? ",
#                  "   AND xccksite=? AND xcck024=? AND xcck029=? AND xcck010=? AND xcck011=? AND xcck021=? ", 
#                  "   AND xcck022=? AND xcck023=? AND xcck025=? AND xcck026=? AND xcck027=? AND xcck028=? ",          
#                  "   AND xcck030=? AND xcck031=? AND xcck044=? ",                                            
#                  "   AND xcck055 IN ('305','307','303','215')",
#                  "   AND (xcck008 = 0 OR xcck008 = 1 OR xcck008 IS NULL)"
#      LET g_sql = "SELECT SUM(xrcb113*xcck009*-1) FROM xcck_t ",
#                  "  LEFT OUTER JOIN xrcb_t ON xrcbent = xcckent AND xrcb002 = xcck006 AND xrcb003 = xcck007 AND  xrcbld=xcckld ", 
#                  " INNER JOIN xrca_t ON xrcbent = xrcaent AND xrcbld = xrcald AND xrcbdocno = xrcadocno AND xrcastus <> 'X'",   
#                  " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=?  ",
#                  "   AND xccksite=? AND xcck024=? AND xcck029=? AND xcck010=? AND xcck011=? AND xcck021=? ",
#                  "   AND xcck022=? AND xcck023=? AND xcck025=? AND xcck026=? AND xcck027=? AND xcck028=? ",
#                  "   AND xcck030=? AND xcck031=? AND xcck044=? ",
#                  "   AND xcck055 IN ('305','307','303','215')",
#                  "   AND (xcck008 = 0 OR xcck008 = 1 OR xcck008 IS NULL)",
#                  " AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"
#      #dorislai-20151006-modify----(E)            
      #----dorislai-20151112-mod-(E)
#wujie 150303 --end
#160520-00002#5 mark---s---  
#      PREPARE axcq913_pb2 FROM g_sql
#      DECLARE b_fill_cs2 CURSOR FOR axcq913_pb2
#160520-00002#5 mark---e---  

      OPEN b_fill_cs2 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005    #dorislai-20151112-modify-(S)
   ##   OPEN b_fill_cs2 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003                                       #dorislai-20151112-modify-(E)
#wujie 150303 --begin
                            ,g_xcck2_d[l_ac].xccksite_1,g_xcck2_d[l_ac].xcck024_1,g_xcck2_d[l_ac].xcck029_1,g_xcck2_d[l_ac].xcck010_1,g_xcck2_d[l_ac].xcck011_1,
                            g_xcck2_d[l_ac].xcck021_1,g_xcck2_d[l_ac].xcck022_1,g_xcck2_d[l_ac].xcck023_1,g_xcck2_d[l_ac].xcck025_1,g_xcck2_d[l_ac].xcck026_1,             
                            g_xcck2_d[l_ac].xcck027_1,g_xcck2_d[l_ac].xcck028_1,g_xcck2_d[l_ac].xcck030_1,g_xcck2_d[l_ac].xcck031_1,g_xcck2_d[l_ac].xcck044_1
#wujie 150303 --end
      LET g_xcck2_d[l_ac].amt3 = 0  
#wujie 150303 --begin
      FETCH b_fill_cs2 INTO g_xcck2_d[l_ac].amt3                     

      #dorislai-20150922-add----(S)
      #沒抓到值給0，後續運算才能進行
#160520-00002#5 mark--s---      
#      IF cl_null(g_xcck2_d[l_ac].amt3) THEN
#         LET g_xcck2_d[l_ac].amt3 = 0
#      END IF
#160520-00002#5 mark--e--
      #dorislai-20150922-add----(E)
#      FOREACH b_fill_cs2 INTO l_xcck006,l_xcck007,l_xcck009
#         SELECT xmdl027 INTO l_xmdl027 FROM xmdl_t 
#          WHERE xmdlent = g_enterprise AND xmdldocno = l_xcck006 AND xmdlseq = l_xcck007
#
#        LET g_xcck2_d[l_ac].amt3 = g_xcck2_d[l_ac].amt3 + l_xmdl027 * l_xcck009*-1
#
#      END FOREACH
#wujie 150303 --end


      #毛利
      LET g_xcck2_d[l_ac].amt5 = g_xcck2_d[l_ac].amt3 - g_xcck2_d[l_ac].xcck202_1
      #毛利率
      LET g_xcck2_d[l_ac].amt7 = g_xcck2_d[l_ac].amt5 / g_xcck2_d[l_ac].amt3 * 100
      CALL s_num_round('1',g_xcck2_d[l_ac].amt7,2) RETURNING g_xcck2_d[l_ac].amt7
      
      #add-point:b_fill段資料填充
#160520-00002#5 mod--s--- 
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_xcck2_d[l_ac].xccksite_1
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_xcck2_d[l_ac].xccksite_1_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_xcck2_d[l_ac].xccksite_1_desc
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_xcck2_d[l_ac].xcck010_1
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_xcck2_d[l_ac].xcck010_1_desc = '', g_rtn_fields[1] , ''
#      LET g_xcck2_d[l_ac].xcck010_1_desc_1 = '', g_rtn_fields[2] , ''
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_xcck2_d[l_ac].xcck025_1
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_xcck2_d[l_ac].xcck025_1_desc = '', g_rtn_fields[1] , ''
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_xcck2_d[l_ac].xcck021_1
#      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_xcck2_d[l_ac].xcck021_1_desc = '', g_rtn_fields[1] , ''
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_xcck2_d[l_ac].xcck022_1
#      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_xcck2_d[l_ac].xcck022_1_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_xcck2_d[l_ac].xcck022_1_desc
#      
#      CALL s_desc_get_unit_desc(g_xcck2_d[l_ac].xcck044_1) RETURNING g_xcck2_d[l_ac].xcck044_1_desc
#160520-00002#5 mod--s---       
      #依成本组织、区域、品牌小计
      #依成本组织、区域合计
      #依成本组织共计
#160520-00002#5      
#      LET l_xcck201_sum = l_xcck201_sum + g_xcck2_d[l_ac].xcck201_1     #dorislai-20150923-add
#      LET l_xcck202a_sum = l_xcck202a_sum + g_xcck2_d[l_ac].xcck202a_1
#      LET l_xcck202b_sum = l_xcck202b_sum + g_xcck2_d[l_ac].xcck202b_1
#      LET l_xcck202c_sum = l_xcck202c_sum + g_xcck2_d[l_ac].xcck202c_1
#      LET l_xcck202d_sum = l_xcck202d_sum + g_xcck2_d[l_ac].xcck202d_1
#      LET l_xcck202e_sum = l_xcck202e_sum + g_xcck2_d[l_ac].xcck202e_1
#      LET l_xcck202f_sum = l_xcck202f_sum + g_xcck2_d[l_ac].xcck202f_1
#      LET l_xcck202g_sum = l_xcck202g_sum + g_xcck2_d[l_ac].xcck202g_1
#      LET l_xcck202h_sum = l_xcck202h_sum + g_xcck2_d[l_ac].xcck202h_1
#      LET l_xcck202_sum  = l_xcck202_sum  + g_xcck2_d[l_ac].xcck202_1
#160520-00002#5
      LET l_amt3_sum     = l_amt3_sum     + g_xcck2_d[l_ac].amt3
      LET l_amt5_sum     = l_amt5_sum     + g_xcck2_d[l_ac].amt5

#160520-00002#5
#      LET l_xcck201_sum1 = l_xcck201_sum1 + g_xcck2_d[l_ac].xcck201_1    #dorislai-20150923-add
#      LET l_xcck202a_sum1 = l_xcck202a_sum1 + g_xcck2_d[l_ac].xcck202a_1
#      LET l_xcck202b_sum1 = l_xcck202b_sum1 + g_xcck2_d[l_ac].xcck202b_1
#      LET l_xcck202c_sum1 = l_xcck202c_sum1 + g_xcck2_d[l_ac].xcck202c_1
#      LET l_xcck202d_sum1 = l_xcck202d_sum1 + g_xcck2_d[l_ac].xcck202d_1
#      LET l_xcck202e_sum1 = l_xcck202e_sum1 + g_xcck2_d[l_ac].xcck202e_1
#      LET l_xcck202f_sum1 = l_xcck202f_sum1 + g_xcck2_d[l_ac].xcck202f_1
#      LET l_xcck202g_sum1 = l_xcck202g_sum1 + g_xcck2_d[l_ac].xcck202g_1
#      LET l_xcck202h_sum1 = l_xcck202h_sum1 + g_xcck2_d[l_ac].xcck202h_1
#      LET l_xcck202_sum1  = l_xcck202_sum1  + g_xcck2_d[l_ac].xcck202_1
#160520-00002#5
      LET l_amt3_sum1     = l_amt3_sum1     + g_xcck2_d[l_ac].amt3
      LET l_amt5_sum1     = l_amt5_sum1     + g_xcck2_d[l_ac].amt5
      
#160520-00002#5      
#      LET l_xcck201_sum2 = l_xcck201_sum2 + g_xcck2_d[l_ac].xcck201_1    #dorislai-20150923-add
#      LET l_xcck202a_sum2 = l_xcck202a_sum2 + g_xcck2_d[l_ac].xcck202a_1
#      LET l_xcck202b_sum2 = l_xcck202b_sum2 + g_xcck2_d[l_ac].xcck202b_1
#      LET l_xcck202c_sum2 = l_xcck202c_sum2 + g_xcck2_d[l_ac].xcck202c_1
#      LET l_xcck202d_sum2 = l_xcck202d_sum2 + g_xcck2_d[l_ac].xcck202d_1
#      LET l_xcck202e_sum2 = l_xcck202e_sum2 + g_xcck2_d[l_ac].xcck202e_1
#      LET l_xcck202f_sum2 = l_xcck202f_sum2 + g_xcck2_d[l_ac].xcck202f_1
#      LET l_xcck202g_sum2 = l_xcck202g_sum2 + g_xcck2_d[l_ac].xcck202g_1
#      LET l_xcck202h_sum2 = l_xcck202h_sum2 + g_xcck2_d[l_ac].xcck202h_1
#      LET l_xcck202_sum2  = l_xcck202_sum2  + g_xcck2_d[l_ac].xcck202_1
      LET l_amt3_sum2     = l_amt3_sum2     + g_xcck2_d[l_ac].amt3
      LET l_amt5_sum2     = l_amt5_sum2     + g_xcck2_d[l_ac].amt5

#160520-00002#5
#      LET l_xcck201_total = l_xcck201_total + g_xcck2_d[l_ac].xcck201_1    #dorislai-20150923-add
#      LET l_xcck202a_total = l_xcck202a_total + g_xcck2_d[l_ac].xcck202a_1
#      LET l_xcck202b_total = l_xcck202b_total + g_xcck2_d[l_ac].xcck202b_1
#      LET l_xcck202c_total = l_xcck202c_total + g_xcck2_d[l_ac].xcck202c_1
#      LET l_xcck202d_total = l_xcck202d_total + g_xcck2_d[l_ac].xcck202d_1
#      LET l_xcck202e_total = l_xcck202e_total + g_xcck2_d[l_ac].xcck202e_1
#      LET l_xcck202f_total = l_xcck202f_total + g_xcck2_d[l_ac].xcck202f_1
#      LET l_xcck202g_total = l_xcck202g_total + g_xcck2_d[l_ac].xcck202g_1
#      LET l_xcck202h_total = l_xcck202h_total + g_xcck2_d[l_ac].xcck202h_1
#      LET l_xcck202_total  = l_xcck202_total  + g_xcck2_d[l_ac].xcck202_1
#160520-00002#5
      LET l_amt3_total     = l_amt3_total     + g_xcck2_d[l_ac].amt3
      LET l_amt5_total     = l_amt5_total     + g_xcck2_d[l_ac].amt5
      IF l_ac > 1 THEN
         IF g_xcck2_d[l_ac].xccksite_1 != g_xcck2_d[l_ac - 1].xccksite_1 OR g_xcck2_d[l_ac].xcck024_1 != g_xcck2_d[l_ac - 1].xcck024_1 OR g_xcck2_d[l_ac].xcck029_1 != g_xcck2_d[l_ac - 1].xcck029_1 THEN   
            #把当前行下移，并在当前行显示小计
            LET g_xcck2_d[l_ac + 1].* = g_xcck2_d[l_ac].*  
            INITIALIZE  g_xcck2_d[l_ac].* TO NULL              
            LET g_xcck2_d[l_ac].xcck029_1  = cl_getmsg("axc-00205",g_lang)
#160520-00002#5            
#            LET g_xcck2_d[l_ac].xcck201_1 = l_xcck201_sum - g_xcck2_d[l_ac+1].xcck201_1       #dorislai-20150923-add
#            LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_sum - g_xcck2_d[l_ac + 1].xcck202a_1
#            LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_sum - g_xcck2_d[l_ac + 1].xcck202b_1
#            LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_sum - g_xcck2_d[l_ac + 1].xcck202c_1
#            LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_sum - g_xcck2_d[l_ac + 1].xcck202d_1
#            LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_sum - g_xcck2_d[l_ac + 1].xcck202e_1
#            LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_sum - g_xcck2_d[l_ac + 1].xcck202f_1
#            LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_sum - g_xcck2_d[l_ac + 1].xcck202g_1
#            LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_sum - g_xcck2_d[l_ac + 1].xcck202h_1
#            LET g_xcck2_d[l_ac].xcck202_1  = l_xcck202_sum  - g_xcck2_d[l_ac + 1].xcck202_1
           
             EXECUTE axcq913_sum_pr1 USING g_xcck2_d[l_ac-1].xccksite_1,g_xcck2_d[l_ac - 1].xcck024_1,g_xcck2_d[l_ac - 1].xcck029_1
                                   INTO g_xcck2_d[l_ac].xcck201_1,
                                        g_xcck2_d[l_ac].xcck202a_1,g_xcck2_d[l_ac].xcck202b_1,
                                        g_xcck2_d[l_ac].xcck202c_1,g_xcck2_d[l_ac].xcck202d_1,g_xcck2_d[l_ac].xcck202e_1,
                                        g_xcck2_d[l_ac].xcck202f_1,g_xcck2_d[l_ac].xcck202g_1,g_xcck2_d[l_ac].xcck202h_1,
                                        g_xcck2_d[l_ac].xcck202_1
             IF cl_null(g_xcck2_d[l_ac].xcck202a_1) THEN LET g_xcck2_d[l_ac].xcck202a_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202b_1) THEN LET g_xcck2_d[l_ac].xcck202b_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202c_1) THEN LET g_xcck2_d[l_ac].xcck202c_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202d_1) THEN LET g_xcck2_d[l_ac].xcck202d_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202e_1) THEN LET g_xcck2_d[l_ac].xcck202e_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202f_1) THEN LET g_xcck2_d[l_ac].xcck202f_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202g_1) THEN LET g_xcck2_d[l_ac].xcck202g_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202h_1) THEN LET g_xcck2_d[l_ac].xcck202h_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202_1)  THEN LET g_xcck2_d[l_ac].xcck202_1  = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck201_1)  THEN LET g_xcck2_d[l_ac].xcck201_1  = 0 END IF             
#160520-00002#5

            LET g_xcck2_d[l_ac].amt3       = l_amt3_sum     - g_xcck2_d[l_ac + 1].amt3
            LET g_xcck2_d[l_ac].amt5       = l_amt5_sum     - g_xcck2_d[l_ac + 1].amt5
            LET l_ac = l_ac + 1
#160520-00002#5            
#            LET l_xcck201_sum = g_xcck2_d[l_ac].xcck201_1    #dorislai-20150923-add
#            LET l_xcck202a_sum = g_xcck2_d[l_ac].xcck202a_1
#            LET l_xcck202b_sum = g_xcck2_d[l_ac].xcck202b_1
#            LET l_xcck202c_sum = g_xcck2_d[l_ac].xcck202c_1
#            LET l_xcck202d_sum = g_xcck2_d[l_ac].xcck202d_1
#            LET l_xcck202e_sum = g_xcck2_d[l_ac].xcck202e_1
#            LET l_xcck202f_sum = g_xcck2_d[l_ac].xcck202f_1
#            LET l_xcck202g_sum = g_xcck2_d[l_ac].xcck202g_1
#            LET l_xcck202h_sum = g_xcck2_d[l_ac].xcck202h_1
#            LET l_xcck202_sum  = g_xcck2_d[l_ac].xcck202_1
#160520-00002#5
            LET l_amt3_sum     = g_xcck2_d[l_ac].amt3
            LET l_amt5_sum     = g_xcck2_d[l_ac].amt5
            
            IF g_xcck2_d[l_ac].xccksite_1 != g_xcck2_d[l_ac - 2].xccksite_1 OR g_xcck2_d[l_ac].xcck024_1 != g_xcck2_d[l_ac - 2].xcck024_1 THEN   
               #把当前行下移，并在当前行显示合计
               LET g_xcck2_d[l_ac + 1].* = g_xcck2_d[l_ac].*  
               INITIALIZE  g_xcck2_d[l_ac].* TO NULL              
               LET g_xcck2_d[l_ac].xcck024_1  = cl_getmsg("axc-00204",g_lang)
#160520-00002#5               
#               LET g_xcck2_d[l_ac].xcck201_1 = l_xcck201_sum1 - g_xcck2_d[l_ac + 1].xcck201_1     #dorislai-20150923-add
#               LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_sum1 - g_xcck2_d[l_ac + 1].xcck202a_1
#               LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_sum1 - g_xcck2_d[l_ac + 1].xcck202b_1
#               LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_sum1 - g_xcck2_d[l_ac + 1].xcck202c_1
#               LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_sum1 - g_xcck2_d[l_ac + 1].xcck202d_1
#               LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_sum1 - g_xcck2_d[l_ac + 1].xcck202e_1
#               LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_sum1 - g_xcck2_d[l_ac + 1].xcck202f_1
#               LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_sum1 - g_xcck2_d[l_ac + 1].xcck202g_1
#               LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_sum1 - g_xcck2_d[l_ac + 1].xcck202h_1
#               LET g_xcck2_d[l_ac].xcck202_1  = l_xcck202_sum1  - g_xcck2_d[l_ac + 1].xcck202_1
 
             EXECUTE axcq913_sum_pr2 USING g_xcck2_d[l_ac-2].xccksite_1,g_xcck2_d[l_ac - 2].xcck024_1
                                   INTO g_xcck2_d[l_ac].xcck201_1,
                                        g_xcck2_d[l_ac].xcck202a_1,g_xcck2_d[l_ac].xcck202b_1,
                                        g_xcck2_d[l_ac].xcck202c_1,g_xcck2_d[l_ac].xcck202d_1,g_xcck2_d[l_ac].xcck202e_1,
                                        g_xcck2_d[l_ac].xcck202f_1,g_xcck2_d[l_ac].xcck202g_1,g_xcck2_d[l_ac].xcck202h_1,
                                        g_xcck2_d[l_ac].xcck202_1
             IF cl_null(g_xcck2_d[l_ac].xcck202a_1) THEN LET g_xcck2_d[l_ac].xcck202a_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202b_1) THEN LET g_xcck2_d[l_ac].xcck202b_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202c_1) THEN LET g_xcck2_d[l_ac].xcck202c_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202d_1) THEN LET g_xcck2_d[l_ac].xcck202d_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202e_1) THEN LET g_xcck2_d[l_ac].xcck202e_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202f_1) THEN LET g_xcck2_d[l_ac].xcck202f_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202g_1) THEN LET g_xcck2_d[l_ac].xcck202g_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202h_1) THEN LET g_xcck2_d[l_ac].xcck202h_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202_1)  THEN LET g_xcck2_d[l_ac].xcck202_1  = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck201_1)  THEN LET g_xcck2_d[l_ac].xcck201_1  = 0 END IF 
#160520-00002#5
               LET g_xcck2_d[l_ac].amt3       = l_amt3_sum1     - g_xcck2_d[l_ac + 1].amt3
               LET g_xcck2_d[l_ac].amt5       = l_amt5_sum1     - g_xcck2_d[l_ac + 1].amt5
               LET l_ac = l_ac + 1
#160520-00002#5               
#               LET l_xcck201_sum1 = g_xcck2_d[l_ac].xcck201_1     #dorislai-20150923-add
#               LET l_xcck202a_sum1 = g_xcck2_d[l_ac].xcck202a_1
#               LET l_xcck202b_sum1 = g_xcck2_d[l_ac].xcck202b_1
#               LET l_xcck202c_sum1 = g_xcck2_d[l_ac].xcck202c_1
#               LET l_xcck202d_sum1 = g_xcck2_d[l_ac].xcck202d_1
#               LET l_xcck202e_sum1 = g_xcck2_d[l_ac].xcck202e_1
#               LET l_xcck202f_sum1 = g_xcck2_d[l_ac].xcck202f_1
#               LET l_xcck202g_sum1 = g_xcck2_d[l_ac].xcck202g_1
#               LET l_xcck202h_sum1 = g_xcck2_d[l_ac].xcck202h_1
#               LET l_xcck202_sum1  = g_xcck2_d[l_ac].xcck202_1
#160520-00002#5
               LET l_amt3_sum1     = g_xcck2_d[l_ac].amt3
               LET l_amt5_sum1     = g_xcck2_d[l_ac].amt5
               
               IF g_xcck2_d[l_ac].xccksite_1 != g_xcck2_d[l_ac - 3].xccksite_1 THEN   
                  #把当前行下移，并在当前行显示共计
                  LET g_xcck2_d[l_ac + 1].* = g_xcck2_d[l_ac].*  
                  INITIALIZE  g_xcck2_d[l_ac].* TO NULL              
                  LET g_xcck2_d[l_ac].xccksite_1 = cl_getmsg("lib-00133",g_lang)
#160520-00002#5                  
#                  LET g_xcck2_d[l_ac].xcck201_1 = l_xcck201_sum2 - g_xcck2_d[l_ac + 1].xcck201_1     #dorislai-20150923-add
#                  LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_sum2 - g_xcck2_d[l_ac + 1].xcck202a_1
#                  LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_sum2 - g_xcck2_d[l_ac + 1].xcck202b_1
#                  LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_sum2 - g_xcck2_d[l_ac + 1].xcck202c_1
#                  LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_sum2 - g_xcck2_d[l_ac + 1].xcck202d_1
#                  LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_sum2 - g_xcck2_d[l_ac + 1].xcck202e_1
#                  LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_sum2 - g_xcck2_d[l_ac + 1].xcck202f_1
#                  LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_sum2 - g_xcck2_d[l_ac + 1].xcck202g_1
#                  LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_sum2 - g_xcck2_d[l_ac + 1].xcck202h_1
#                  LET g_xcck2_d[l_ac].xcck202_1  = l_xcck202_sum2  - g_xcck2_d[l_ac + 1].xcck202_1
             EXECUTE axcq913_sum_pr3 USING g_xcck2_d[l_ac-3].xccksite_1 
                                   INTO g_xcck2_d[l_ac].xcck201_1,
                                        g_xcck2_d[l_ac].xcck202a_1,g_xcck2_d[l_ac].xcck202b_1,
                                        g_xcck2_d[l_ac].xcck202c_1,g_xcck2_d[l_ac].xcck202d_1,g_xcck2_d[l_ac].xcck202e_1,
                                        g_xcck2_d[l_ac].xcck202f_1,g_xcck2_d[l_ac].xcck202g_1,g_xcck2_d[l_ac].xcck202h_1,
                                        g_xcck2_d[l_ac].xcck202_1
             IF cl_null(g_xcck2_d[l_ac].xcck202a_1) THEN LET g_xcck2_d[l_ac].xcck202a_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202b_1) THEN LET g_xcck2_d[l_ac].xcck202b_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202c_1) THEN LET g_xcck2_d[l_ac].xcck202c_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202d_1) THEN LET g_xcck2_d[l_ac].xcck202d_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202e_1) THEN LET g_xcck2_d[l_ac].xcck202e_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202f_1) THEN LET g_xcck2_d[l_ac].xcck202f_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202g_1) THEN LET g_xcck2_d[l_ac].xcck202g_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202h_1) THEN LET g_xcck2_d[l_ac].xcck202h_1 = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck202_1)  THEN LET g_xcck2_d[l_ac].xcck202_1  = 0 END IF
             IF cl_null(g_xcck2_d[l_ac].xcck201_1)  THEN LET g_xcck2_d[l_ac].xcck201_1  = 0 END IF 
#160520-00002#5
                  LET g_xcck2_d[l_ac].amt3       = l_amt3_sum2     - g_xcck2_d[l_ac + 1].amt3
                  LET g_xcck2_d[l_ac].amt5       = l_amt5_sum2     - g_xcck2_d[l_ac + 1].amt5
                  LET l_ac = l_ac + 1            
                  
                  #销售额占比、毛利占比
                  FOR l_j = l_i TO l_ac - 1
                     IF g_xcck2_d[l_j].xcck029_1  = cl_getmsg("axc-00205",g_lang) OR 
                        g_xcck2_d[l_j].xcck024_1  = cl_getmsg("axc-00204",g_lang) OR
                        g_xcck2_d[l_j].xccksite_1  = cl_getmsg("lib-00133",g_lang) THEN
                        CONTINUE FOR
                     END IF
                     LET g_xcck2_d[l_j].amt4 = g_xcck2_d[l_j].amt3 / l_amt3_sum2 * 100
                     CALL s_num_round('1',g_xcck2_d[l_j].amt4,2) RETURNING g_xcck2_d[l_j].amt4
                     LET g_xcck2_d[l_j].amt6 = g_xcck2_d[l_j].amt5 / l_amt5_sum2 * 100
                     CALL s_num_round('1',g_xcck2_d[l_j].amt6,2) RETURNING g_xcck2_d[l_j].amt6
                  END FOR
                  LET l_i = l_ac
#160520-00002#5                  
#                  LET l_xcck201_sum2 = g_xcck2_d[l_ac].xcck201_1    #dorislai-20150923-add
#                  LET l_xcck202a_sum2 = g_xcck2_d[l_ac].xcck202a_1
#                  LET l_xcck202b_sum2 = g_xcck2_d[l_ac].xcck202b_1
#                  LET l_xcck202c_sum2 = g_xcck2_d[l_ac].xcck202c_1
#                  LET l_xcck202d_sum2 = g_xcck2_d[l_ac].xcck202d_1
#                  LET l_xcck202e_sum2 = g_xcck2_d[l_ac].xcck202e_1
#                  LET l_xcck202f_sum2 = g_xcck2_d[l_ac].xcck202f_1
#                  LET l_xcck202g_sum2 = g_xcck2_d[l_ac].xcck202g_1
#                  LET l_xcck202h_sum2 = g_xcck2_d[l_ac].xcck202h_1
#                  LET l_xcck202_sum2  = g_xcck2_d[l_ac].xcck202_1
#160520-00002#5
                  LET l_amt3_sum2     = g_xcck2_d[l_ac].amt3
                  LET l_amt5_sum2     = g_xcck2_d[l_ac].amt5
               END IF
            END IF
         END IF
      END IF
      
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
   
   #最后一组小计，合计，共计  

   LET g_xcck2_d[l_ac].xcck029_1  = cl_getmsg("axc-00205",g_lang)
#160520-00002#5   
#   LET g_xcck2_d[l_ac].xcck201_1 = l_xcck201_sum    #dorislai-20150923-add
#   LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_sum 
#   LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_sum 
#   LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_sum 
#   LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_sum 
#   LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_sum 
#   LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_sum 
#   LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_sum 
#   LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_sum 
#   LET g_xcck2_d[l_ac].xcck202_1  = l_xcck202_sum  
    
    EXECUTE axcq913_sum_pr1 USING g_xcck2_d[l_ac-1].xccksite_1,g_xcck2_d[l_ac-1].xcck024_1,g_xcck2_d[l_ac-1].xcck029_1
                          INTO g_xcck2_d[l_ac].xcck201_1,
                               g_xcck2_d[l_ac].xcck202a_1,g_xcck2_d[l_ac].xcck202b_1,
                               g_xcck2_d[l_ac].xcck202c_1,g_xcck2_d[l_ac].xcck202d_1,g_xcck2_d[l_ac].xcck202e_1,
                               g_xcck2_d[l_ac].xcck202f_1,g_xcck2_d[l_ac].xcck202g_1,g_xcck2_d[l_ac].xcck202h_1,
                               g_xcck2_d[l_ac].xcck202_1
    IF cl_null(g_xcck2_d[l_ac].xcck202a_1) THEN LET g_xcck2_d[l_ac].xcck202a_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202b_1) THEN LET g_xcck2_d[l_ac].xcck202b_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202c_1) THEN LET g_xcck2_d[l_ac].xcck202c_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202d_1) THEN LET g_xcck2_d[l_ac].xcck202d_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202e_1) THEN LET g_xcck2_d[l_ac].xcck202e_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202f_1) THEN LET g_xcck2_d[l_ac].xcck202f_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202g_1) THEN LET g_xcck2_d[l_ac].xcck202g_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202h_1) THEN LET g_xcck2_d[l_ac].xcck202h_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202_1)  THEN LET g_xcck2_d[l_ac].xcck202_1  = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck201_1)  THEN LET g_xcck2_d[l_ac].xcck201_1  = 0 END IF 
#160520-00002#5
   LET g_xcck2_d[l_ac].amt3       = l_amt3_sum     
   LET g_xcck2_d[l_ac].amt5       = l_amt5_sum     
   LET l_ac = l_ac + 1
   
   LET g_xcck2_d[l_ac].xcck024_1  = cl_getmsg("axc-00204",g_lang)
#160520-00002#5
#   LET g_xcck2_d[l_ac].xcck201_1 = l_xcck201_sum1   #dorislai-20150923-add
#   LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_sum1
#   LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_sum1
#   LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_sum1
#   LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_sum1
#   LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_sum1
#   LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_sum1
#   LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_sum1
#   LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_sum1
#   LET g_xcck2_d[l_ac].xcck202_1  = l_xcck202_sum1
 

    EXECUTE axcq913_sum_pr2 USING g_xcck2_d[l_ac-2].xccksite_1,g_xcck2_d[l_ac-2].xcck024_1
                          INTO g_xcck2_d[l_ac].xcck201_1,
                               g_xcck2_d[l_ac].xcck202a_1,g_xcck2_d[l_ac].xcck202b_1,
                               g_xcck2_d[l_ac].xcck202c_1,g_xcck2_d[l_ac].xcck202d_1,g_xcck2_d[l_ac].xcck202e_1,
                               g_xcck2_d[l_ac].xcck202f_1,g_xcck2_d[l_ac].xcck202g_1,g_xcck2_d[l_ac].xcck202h_1,
                               g_xcck2_d[l_ac].xcck202_1
    IF cl_null(g_xcck2_d[l_ac].xcck202a_1) THEN LET g_xcck2_d[l_ac].xcck202a_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202b_1) THEN LET g_xcck2_d[l_ac].xcck202b_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202c_1) THEN LET g_xcck2_d[l_ac].xcck202c_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202d_1) THEN LET g_xcck2_d[l_ac].xcck202d_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202e_1) THEN LET g_xcck2_d[l_ac].xcck202e_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202f_1) THEN LET g_xcck2_d[l_ac].xcck202f_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202g_1) THEN LET g_xcck2_d[l_ac].xcck202g_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202h_1) THEN LET g_xcck2_d[l_ac].xcck202h_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202_1)  THEN LET g_xcck2_d[l_ac].xcck202_1  = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck201_1)  THEN LET g_xcck2_d[l_ac].xcck201_1  = 0 END IF 
#160520-00002#5
   LET g_xcck2_d[l_ac].amt3       = l_amt3_sum1    
   LET g_xcck2_d[l_ac].amt5       = l_amt5_sum1    
   LET l_ac = l_ac + 1
   
   LET g_xcck2_d[l_ac].xccksite_1 = cl_getmsg("lib-00133",g_lang)
#160520-00002#5   
#   LET g_xcck2_d[l_ac].xcck201_1 = l_xcck201_sum2   #dorislai-20150923-add
#   LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_sum2
#   LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_sum2
#   LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_sum2
#   LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_sum2
#   LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_sum2
#   LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_sum2
#   LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_sum2
#   LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_sum2
#   LET g_xcck2_d[l_ac].xcck202_1  = l_xcck202_sum2 
    EXECUTE axcq913_sum_pr3 USING g_xcck2_d[l_ac-3].xccksite_1 
                          INTO g_xcck2_d[l_ac].xcck201_1,
                               g_xcck2_d[l_ac].xcck202a_1,g_xcck2_d[l_ac].xcck202b_1,
                               g_xcck2_d[l_ac].xcck202c_1,g_xcck2_d[l_ac].xcck202d_1,g_xcck2_d[l_ac].xcck202e_1,
                               g_xcck2_d[l_ac].xcck202f_1,g_xcck2_d[l_ac].xcck202g_1,g_xcck2_d[l_ac].xcck202h_1,
                               g_xcck2_d[l_ac].xcck202_1
    IF cl_null(g_xcck2_d[l_ac].xcck202a_1) THEN LET g_xcck2_d[l_ac].xcck202a_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202b_1) THEN LET g_xcck2_d[l_ac].xcck202b_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202c_1) THEN LET g_xcck2_d[l_ac].xcck202c_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202d_1) THEN LET g_xcck2_d[l_ac].xcck202d_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202e_1) THEN LET g_xcck2_d[l_ac].xcck202e_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202f_1) THEN LET g_xcck2_d[l_ac].xcck202f_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202g_1) THEN LET g_xcck2_d[l_ac].xcck202g_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202h_1) THEN LET g_xcck2_d[l_ac].xcck202h_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202_1)  THEN LET g_xcck2_d[l_ac].xcck202_1  = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck201_1)  THEN LET g_xcck2_d[l_ac].xcck201_1  = 0 END IF 
#160520-00002#5
   LET g_xcck2_d[l_ac].amt3       = l_amt3_sum2    
   LET g_xcck2_d[l_ac].amt5       = l_amt5_sum2    
   
   
   #销售额占比、毛利占比
   FOR l_j = l_i TO l_ac - 1
      IF g_xcck2_d[l_j].xcck029_1  = cl_getmsg("axc-00205",g_lang) OR 
         g_xcck2_d[l_j].xcck024_1  = cl_getmsg("axc-00204",g_lang) OR
         g_xcck2_d[l_j].xccksite_1  = cl_getmsg("lib-00133",g_lang) THEN
         CONTINUE FOR
      END IF
      LET g_xcck2_d[l_j].amt4 = g_xcck2_d[l_j].amt3 / l_amt3_sum2 * 100
      CALL s_num_round('1',g_xcck2_d[l_j].amt4,2) RETURNING g_xcck2_d[l_j].amt4
      LET g_xcck2_d[l_j].amt6 = g_xcck2_d[l_j].amt5 / l_amt5_sum2 * 100
      CALL s_num_round('1',g_xcck2_d[l_j].amt6,2) RETURNING g_xcck2_d[l_j].amt6
   END FOR
   #dorislai-20150923-add----(S)
   LET l_ac = l_ac + 1
   LET g_xcck2_d[l_ac].xccksite_1 = cl_getmsg("axc-00733",g_lang)
#160520-00002#5   
#   LET g_xcck2_d[l_ac].xcck201_1 = l_xcck201_total    #dorislai-20150923-add
#   LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_total
#   LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_total
#   LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_total
#   LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_total
#   LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_total
#   LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_total
#   LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_total
#   LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_total
#   LET g_xcck2_d[l_ac].xcck202_1  = l_xcck202_total 
    EXECUTE axcq913_sum_pr INTO g_xcck2_d[l_ac].xcck201_1,
                               g_xcck2_d[l_ac].xcck202a_1,g_xcck2_d[l_ac].xcck202b_1,
                               g_xcck2_d[l_ac].xcck202c_1,g_xcck2_d[l_ac].xcck202d_1,g_xcck2_d[l_ac].xcck202e_1,
                               g_xcck2_d[l_ac].xcck202f_1,g_xcck2_d[l_ac].xcck202g_1,g_xcck2_d[l_ac].xcck202h_1,
                               g_xcck2_d[l_ac].xcck202_1
    IF cl_null(g_xcck2_d[l_ac].xcck202a_1) THEN LET g_xcck2_d[l_ac].xcck202a_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202b_1) THEN LET g_xcck2_d[l_ac].xcck202b_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202c_1) THEN LET g_xcck2_d[l_ac].xcck202c_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202d_1) THEN LET g_xcck2_d[l_ac].xcck202d_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202e_1) THEN LET g_xcck2_d[l_ac].xcck202e_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202f_1) THEN LET g_xcck2_d[l_ac].xcck202f_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202g_1) THEN LET g_xcck2_d[l_ac].xcck202g_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202h_1) THEN LET g_xcck2_d[l_ac].xcck202h_1 = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck202_1)  THEN LET g_xcck2_d[l_ac].xcck202_1  = 0 END IF
    IF cl_null(g_xcck2_d[l_ac].xcck201_1)  THEN LET g_xcck2_d[l_ac].xcck201_1  = 0 END IF 
#160520-00002#5
   LET g_xcck2_d[l_ac].amt3       = l_amt3_total    
   LET g_xcck2_d[l_ac].amt5       = l_amt5_total  
   
#   FREE axcq913_pb4 #dorislai-20151112-mark
   #dorislai-20150923-add----(E)
   LET l_ac = l_ac + 1
   

  # FREE axcq913_pb1
   LET g_rec_b2 = l_ac - 1
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq913_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld AND
                              xcck001 = g_xcck_m.xcck001 AND
                              xcck003 = g_xcck_m.xcck003 AND
                              xcck004 = g_xcck_m.xcck004 AND
                              xcck005 = g_xcck_m.xcck005 AND
 
          xcck002 = g_xcck_d_t.xcck002
      AND xcck006 = g_xcck_d_t.xcck006
      AND xcck007 = g_xcck_d_t.xcck007
      AND xcck009 = g_xcck_d_t.xcck009
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:",SQLERRMESSAGE 
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
 
{<section id="axcq913.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq913_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq913.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq913_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq913.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq913_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq913.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq913_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcck_d[l_ac].xcck002 = g_xcck_d_t.xcck002 
      AND g_xcck_d[l_ac].xcck006 = g_xcck_d_t.xcck006 
      AND g_xcck_d[l_ac].xcck007 = g_xcck_d_t.xcck007 
      AND g_xcck_d[l_ac].xcck009 = g_xcck_d_t.xcck009 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq913_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq913.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq913_lock_b(ps_table,ps_page)
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
   #CALL axcq913_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq913.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq913_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq913.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq913_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcckld,xcck001,xcck003,xcck004,xcck005",TRUE)
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
 
{<section id="axcq913.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq913_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcckld,xcck001,xcck003,xcck004,xcck005",FALSE)
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
 
{<section id="axcq913.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq913_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq913_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq913_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq913.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq913_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq913.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq913_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq913.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq913_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq913.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq913_default_search()
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
      LET ls_wc = ls_wc, " xcckld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcck001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcck003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcck004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcck005 = '", g_argv[05], "' AND "
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
 
{<section id="axcq913.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq913_fill_chk(ps_idx)
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
 
{<section id="axcq913.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq913_modify_detail_chk(ps_record)
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
         LET ls_return = "xccksite"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq913.mask_functions" >}
&include "erp/axc/axcq913_mask.4gl"
 
{</section>}
 
{<section id="axcq913.state_change" >}
    
 
{</section>}
 
{<section id="axcq913.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq913_set_pk_array()
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
   LET g_pk_array[1].values = g_xcck_m.xcckld
   LET g_pk_array[1].column = 'xcckld'
   LET g_pk_array[2].values = g_xcck_m.xcck001
   LET g_pk_array[2].column = 'xcck001'
   LET g_pk_array[3].values = g_xcck_m.xcck003
   LET g_pk_array[3].column = 'xcck003'
   LET g_pk_array[4].values = g_xcck_m.xcck004
   LET g_pk_array[4].column = 'xcck004'
   LET g_pk_array[5].values = g_xcck_m.xcck005
   LET g_pk_array[5].column = 'xcck005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq913.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq913_msgcentre_notify(lc_state)
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
   CALL axcq913_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcck_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq913.other_function" readonly="Y" >}

#查询时预设条件
PRIVATE FUNCTION axcq913_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003
   #fengmy 150109----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcck_m.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   END IF
              
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xcck002,xcck002_desc',FALSE)                
   END IF  
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_1',TRUE)                    
   ELSE                                         
      CALL cl_set_comp_visible('xcck011,xcck011_1',FALSE)                
   END IF   
   #fengmy 150109----end   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcckcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcckcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcckld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
      
   LET g_xcck_m.xcck001 = '1'
   DISPLAY BY NAME g_xcck_m.xcck001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcck_m.xcckld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcck001_desc       
END FUNCTION

################################################################################
# Descriptions...: 描述说明:创建临时表
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150325 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq913_create_temp_table()
    DROP TABLE axcq913_tmp;
    CREATE TEMP TABLE axcq913_tmp(
      xccksite  VARCHAR(10), 
      xccksite_desc  VARCHAR(300), 
      xcck024  VARCHAR(10),       #dorislai-20151001-add
      xcck006  VARCHAR(20), 
      xcck007  INTEGER, 
      xcck009  SMALLINT, 
      xcck013  DATE, 
      xcck010  VARCHAR(40), 
      xcck010_desc  VARCHAR(300), 
      xcck010_desc_1  VARCHAR(300), 
      xcck011  VARCHAR(256), 
      xcck022  VARCHAR(10), 
      xcck022_desc  VARCHAR(300),
      xcck023  VARCHAR(10),       #dorislai-20151001-add      
      xcck002  VARCHAR(30), 
      xcck002_desc  VARCHAR(300), 
      xcck044  VARCHAR(10), 
      xcck044_desc  VARCHAR(300), 
      xcck201  DECIMAL(20,6), 
      xcck202  DECIMAL(20,6), 
      xcck202_desc1  DECIMAL(20,6), 
      xcck202_desc4  DECIMAL(20,6),       #dorislai-20151001-add
      xcck202_desc2  DECIMAL(20,6),
      xcck202_desc5  DECIMAL(20,6),       #dorislai-20151001-add      
      xcck202_desc3  DECIMAL(20,6), 
      xcckcomp  VARCHAR(10), 
      xcckcomp_desc  VARCHAR(300), 
      xcckld  VARCHAR(5), 
      xcckld_desc  VARCHAR(300), 
      xcck001  VARCHAR(1), 
      xcck004  SMALLINT, 
      xcck005  SMALLINT, 
      xcck003  VARCHAR(10), 
      xcck001_desc  VARCHAR(300), 
      xcck004_desc  VARCHAR(300), 
      xcck005_desc  VARCHAR(300), 
      xcck003_desc  VARCHAR(300), 
      xcck_key  VARCHAR(300)
   );
END FUNCTION

################################################################################
# Descriptions...: 描述说明:临时表加数据
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者:20150324 By dujuan
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq913_get_date()
   DEFINE sr RECORD 
      xccksite LIKE xcck_t.xccksite, 
      xccksite_desc LIKE type_t.chr300,
      xcck024 LIKE xcck_t.xcck024,  #dorislai-20151001-add      
      xcck006 LIKE xcck_t.xcck006, 
      xcck007 LIKE xcck_t.xcck007, 
      xcck009 LIKE xcck_t.xcck009, 
      xcck013 LIKE xcck_t.xcck013, 
      xcck010 LIKE xcck_t.xcck010, 
      xcck010_desc LIKE type_t.chr300, 
      xcck010_desc_1 LIKE type_t.chr300, 
      xcck011 LIKE xcck_t.xcck011, 
      xcck022 LIKE xcck_t.xcck022, 
      xcck022_desc LIKE type_t.chr300, 
      xcck023 LIKE xcck_t.xcck023,  #dorislai-20151001-add
      xcck002 LIKE xcck_t.xcck002, 
      xcck002_desc LIKE type_t.chr300, 
      xcck044 LIKE xcck_t.xcck044, 
      xcck044_desc LIKE type_t.chr300, 
      xcck201 LIKE xcck_t.xcck201, 
      xcck202 LIKE xcck_t.xcck202, 
      xcck202_desc1 LIKE type_t.num20_6, 
      xcck202_desc4 LIKE type_t.num20_6,  #dorislai-20151001-add
      xcck202_desc2 LIKE type_t.num20_6,
      xcck202_desc5 LIKE type_t.num20_6,  #dorislai-20151001-add      
      xcck202_desc3 LIKE type_t.num20_6, 
      xcckcomp LIKE xcck_t.xcckcomp, 
      xcckcomp_desc LIKE type_t.chr300, 
      xcckld LIKE xcck_t.xcckld, 
      xcckld_desc LIKE type_t.chr300, 
      xcck001 LIKE xcck_t.xcck001, 
      xcck004 LIKE xcck_t.xcck004, 
      xcck005 LIKE xcck_t.xcck005, 
      xcck003 LIKE xcck_t.xcck003, 
      xcck001_desc LIKE type_t.chr300, 
      xcck004_desc LIKE type_t.chr300, 
      xcck005_desc LIKE type_t.chr300, 
      xcck003_desc LIKE type_t.chr300, 
      xcck_key LIKE type_t.chr300
    END RECORD
    
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_cnt      LIKE type_t.num5
    DEFINE l_xrcb113         LIKE xrcb_t.xrcb113
    DEFINE l_xrcb123         LIKE xrcb_t.xrcb123
    DEFINE l_xrcb133         LIKE xrcb_t.xrcb133
    DEFINE l_xrcb022         LIKE xrcb_t.xrcb022
    DEFINE l_sql      STRING                #dorislai-20151001-add----(S)
    DEFINE l_sql_tmp  STRING
    DEFINE l_chk      LIKE type_t.num5
    DEFINE l_cnt1               LIKE type_t.num5
    DEFINE l_xcck202_desc1_tmp  LIKE xcck_t.xcck202
    DEFINE l_xcck202_desc2_tmp  LIKE xcck_t.xcck202
    DEFINE l_xcck202_desc4_sum  LIKE xcck_t.xcck202
    DEFINE l_xcck202_desc5_sum  LIKE xcck_t.xcck202
    DEFINE l_site_chk LIKE xcck_t.xccksite  #dorislai-20151001-add----(E)
    
    #刪除臨時表中資料
    DELETE FROM axcq913_tmp
    
    LET l_success = TRUE
    
    FOR l_cnt = 1 TO g_browser.getLength()
      LET sr.xcckld = g_browser[l_cnt].b_xcckld
      LET sr.xcck001 = g_browser[l_cnt].b_xcck001
      LET sr.xcck004 = g_browser[l_cnt].b_xcck004
      LET sr.xcck005 = g_browser[l_cnt].b_xcck005
      LET sr.xcck003 = g_browser[l_cnt].b_xcck003
      
      EXECUTE axcq913_master_referesh USING sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005 
         #dorislai-20150909-modify----(S)    原先對應值放錯位置 
#         INTO sr.xcckcomp,sr.xcck004,sr.xcck001,sr.xcckld,sr.xcck005,sr.xcck003,sr.xcckcomp_desc,
#             sr.xcck001_desc,sr.xcckld_desc,sr.xcck003_desc
         INTO sr.xcckcomp,sr.xcck004,sr.xcck005,sr.xcck001,sr.xcckld,sr.xcckcomp_desc,
             sr.xcck001_desc,sr.xcckld_desc,sr.xcck003_desc
         #dorislai-20150909-modify----(E)
      LET sr.xcck004_desc = sr.xcck004
      LET sr.xcck005_desc = sr.xcck005
      LET sr.xcck_key = sr.xcckcomp,"-",sr.xcckld,"-",sr.xcck004_desc CLIPPED,"-" CLIPPED,sr.xcck005_desc CLIPPED,"-",sr.xcck001,"-",sr.xcck003 CLIPPED
      
      LET l_xrcb113 = 0
      LET l_xrcb123 = 0
      LET l_xrcb133 = 0
      LET l_xrcb022 = 0
      LET l_xcck202_desc4_sum = 0
      LET l_xcck202_desc5_sum = 0
      LET l_chk = FALSE
      LET l_site_chk = "NULL" #dorislai-20151001-add
      #dorislai-20151005-add----(S)
      #此段與b_fill_1相同
      LET l_sql = "SELECT  UNIQUE xccksite,xcck024,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck023,xcck002,",   
                   "xcck044,SUM(xcck201*xcck009*-1),SUM(xcck202*xcck009*-1),t1.ooefl003 ,t2.imaal003 ,t3.pmaal004 ,t4.xcbfl003,",
                   #151112-00012#1-mod-(S)
#                   "t5.oocal003 FROM xcck_t",
                   "t5.oocal003,SUM(xrcb113),SUM(xrcb123),SUM(xrcb133),xrcb022 FROM xcck_t",
                   " LEFT JOIN xrca_t ON xrcaent=xcckent AND xrcald=xcckld AND xrcastus <> 'X' AND xrca001 IN ('01','02','12','17','22') ",
                   " LEFT JOIN xrcb_t ON xrcbent=xrcaent AND xrcbld=xrcald AND xrcbdocno=xrcadocno AND xrcb002=xcck006 AND xrcb003=xcck007 AND xrcb023<>'Y'",
                   #151112-00012#1-mod-(E)
                   " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
                   " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcck010 AND t2.imaal002='"||g_dlang||"' ",
                   " LEFT JOIN pmaal_t t3 ON t3.pmaalent='"||g_enterprise||"' AND t3.pmaal001=xcck022 AND t3.pmaal002='"||g_dlang||"' ",
                   " LEFT JOIN xcbfl_t t4 ON t4.xcbflent='"||g_enterprise||"' AND t4.xcbflcomp=xcckcomp AND t4.xcbfl001=xcck002 AND t4.xcbfl002='"||g_dlang||"' ",
                   " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
                   " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? ",
                   " AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"   #dorislai-20151112-add
      IF NOT cl_null(g_wc2_table1) THEN
         LET l_sql = l_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
      END IF
      
      #dorislai-20151005-add----(E)
      
      PREPARE axcq913_ins_tmp_pre FROM g_sql_tmp
      DECLARE axcq913_ins_tmp_cs CURSOR FOR axcq913_ins_tmp_pre
      
      #dorislai-20151001-modify----(S) 只有4個問號
#      OPEN axcq913_ins_tmp_cs USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005
      
#      FOREACH axcq913_ins_tmp_cs INTO sr.xccksite,sr.xcck006,,sr.xcck007,sr.xcck009,sr.xcck013,sr.xcck010,
#                                      sr.xcck011,sr.xcck022,sr.xcck002,sr.xcck044,sr.xcck201,sr.xcck202, 
#                                      sr.xccksite_desc,sr.xcck010_desc,sr.xcck022_desc,sr.xcck002_desc,sr.xcck044_desc
      OPEN axcq913_ins_tmp_cs USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003
      
      FOREACH axcq913_ins_tmp_cs INTO sr.xccksite,sr.xcck024,sr.xcck006,sr.xcck007,sr.xcck009,sr.xcck013,sr.xcck010,
                                      sr.xcck011,sr.xcck022,sr.xcck023,sr.xcck002,sr.xcck044,sr.xcck201,sr.xcck202, 
                                      sr.xccksite_desc,sr.xcck010_desc,sr.xcck022_desc,sr.xcck002_desc,sr.xcck044_desc,
                                      l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022 ##151112-00012#1-add
      #dorislai-20151001-modify----(E) 
         #151112-00012#1-mark-(S)
#         #dorislai-2015105-add---(S)        
#         #需將值清空，避免出現抓到NULL值時，無法寫入，造成值仍為舊值
#         LET l_xrcb113 = 0
#         LET l_xrcb123 = 0
#         LET l_xrcb133 = 0
#         LET l_xrcb022 = 0
#         #dorislai-2015105-add---(E) 
#         #销售收入
#         SELECT xrcb113,xrcb123,xrcb133,xrcb022 INTO l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022
#           FROM xrca_t,xrcb_t
#          WHERE xrcaent = xrcbent AND xrcaent = g_enterprise
#            AND xrcald  = xrcbld  AND xrcald  = g_xcck_m.xcckld
#            AND xrcadocno = xrcbdocno
#            AND xrca001 IN ('01','02','12','17','22')
#            AND xrcastus <> 'X' #151102 dorislai add 排除作廢的應收
#            AND xrcb002 = sr.xcck006
#            AND xrcb003 = sr.xcck007
#            AND xrcb023 <> 'Y'
         #151112-00012#1-mark-(E)
         CASE sr.xcck001
              WHEN '1' LET sr.xcck202_desc1 = l_xrcb113 * l_xrcb022
              WHEN '2' LET sr.xcck202_desc1 = l_xrcb123 * l_xrcb022
              WHEN '3' LET sr.xcck202_desc1 = l_xrcb133 * l_xrcb022
         END CASE
         
         IF cl_null(sr.xcck202_desc1) THEN
            LET sr.xcck202_desc1 = 0
         END IF
         
         #毛利
         LET sr.xcck202_desc2 = sr.xcck202_desc1 - sr.xcck202

         #dorislai-20151005-mark----(S)移至下面的程式段了
#         #毛利率
#         LET sr.xcck202_desc3 = sr.xcck202_desc2 / sr.xcck202_desc1 * 100
#         CALL s_num_round('1',sr.xcck202_desc3,2) RETURNING sr.xcck202_desc3
#         
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = sr.xcck010
#         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET sr.xcck010_desc = '', g_rtn_fields[1] , ''
#         LET sr.xcck010_desc_1 = '', g_rtn_fields[2] , ''
         #dorislai-20151005-mark----(E)
         #dorislai-20151001-add----(S)
         LET l_chk = TRUE
         #收入/毛利 加總
         LET l_xcck202_desc4_sum = l_xcck202_desc4_sum + sr.xcck202_desc1
         LET l_xcck202_desc5_sum = l_xcck202_desc5_sum + sr.xcck202_desc2
         
         IF l_site_chk = "NULL" OR l_site_chk = cl_getmsg("axc-00205",g_dlang) THEN
            LET l_site_chk = sr.xccksite
         END IF
         
         IF l_site_chk <> sr.xccksite THEN
            #收入/毛利 加總  扣除掉  比對到不同site的收入/毛利
            LET l_xcck202_desc4_sum = l_xcck202_desc4_sum - sr.xcck202_desc1
            LET l_xcck202_desc5_sum = l_xcck202_desc5_sum - sr.xcck202_desc2
            #與b_fill_1段相同，差別僅多加入據點條件
            LET l_sql_tmp = l_sql," AND xcck055 IN ('305','307','303','215') AND xccksite = '",l_site_chk,"'", 
                            " GROUP BY xccksite,xcck024,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck023,xcck002,xcck044,t1.ooefl003,t2.imaal003,t3.pmaal004,t4.xcbfl003,t5.oocal003,xrcb022" #151112-00012#1-add-xrcb022
   
            LET l_sql_tmp = l_sql_tmp, " ORDER BY xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,xcck044"
            
            #更換比對的site值
            LET l_site_chk = sr.xccksite
            #存比對到不同筆site的資料(EX:DSCTC的下一個據點DSCTP中的第一筆資料)
            LET l_xcck202_desc1_tmp = sr.xcck202_desc1
            LET l_xcck202_desc2_tmp = sr.xcck202_desc2
            PREPARE axcq913_ins_tmp_pre1 FROM l_sql_tmp
            DECLARE axcq913_ins_tmp_cs1 CURSOR FOR axcq913_ins_tmp_pre1
       
            OPEN axcq913_ins_tmp_cs1 USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003
            FOREACH axcq913_ins_tmp_cs1 INTO sr.xccksite,sr.xcck024,sr.xcck006,sr.xcck007,sr.xcck009,sr.xcck013,sr.xcck010,
                                             sr.xcck011,sr.xcck022,sr.xcck023,sr.xcck002,sr.xcck044,sr.xcck201,sr.xcck202, 
                                             sr.xccksite_desc,sr.xcck010_desc,sr.xcck022_desc,sr.xcck002_desc,sr.xcck044_desc,
                                             l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022 ##151112-00012#1-add
               #151112-00012#1-mark-(S)
#               #值歸零
#               LET l_xrcb113 = 0
#               LET l_xrcb123 = 0
#               LET l_xrcb133 = 0
#               LET l_xrcb022 = 0
#               #抓金額、正負值
#               SELECT xrcb113,xrcb123,xrcb133,xrcb022 INTO l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022
#                 FROM xrca_t,xrcb_t
#                WHERE xrcaent = xrcbent AND xrcaent = g_enterprise
#                  AND xrcald  = xrcbld  AND xrcald  = g_xcck_m.xcckld
#                  AND xrcadocno = xrcbdocno
#                  AND xrca001 IN ('01','02','12','17','22')
#                  AND xrcastus <> 'X'   #151102 dorislai add 排除作廢的應收
#                  AND xrcb002 = sr.xcck006
#                  AND xrcb003 = sr.xcck007
#                  AND xrcb023 <> 'Y'
               #151112-00012#1-mark-(E)
               
               CASE sr.xcck001
                    WHEN '1' LET sr.xcck202_desc1 = l_xrcb113 * l_xrcb022
                    WHEN '2' LET sr.xcck202_desc1 = l_xrcb123 * l_xrcb022
                    WHEN '3' LET sr.xcck202_desc1 = l_xrcb133 * l_xrcb022
               END CASE
               
               
               IF cl_null(sr.xcck202_desc1) THEN
                  LET sr.xcck202_desc1 = 0
               END IF
               
               #毛利
               LET sr.xcck202_desc2 = sr.xcck202_desc1 - sr.xcck202
               
               #dorislai-20151006-add----(S)  151102 dorislai mark (S)
               #若有兩筆參考單號、項次     
#               LET l_cnt1 = 0
#               SELECT COUNT(1) INTO l_cnt1 
#                 FROM xcck_t
#                WHERE xcckent = g_enterprise AND xcckld = sr.xcckld
#                  AND xcck001 = sr.xcck001   AND xcck003 = sr.xcck003
#                  AND xcck006 = sr.xcck006   AND xcck007 = sr.xcck007              
#               IF l_cnt1 > 1 THEN
#                  #出庫碼 = 1 的，收入、毛利值清除
#                  #出庫碼 = -1 的，收入、毛利值留下
#                  IF sr.xcck009 = 1 THEN
#                     LET l_xcck202_desc4_sum = l_xcck202_desc4_sum - sr.xcck202_desc1
#                     LET l_xcck202_desc5_sum = l_xcck202_desc5_sum - sr.xcck202_desc2
#                     LET sr.xcck202_desc1 = 0
#                     LET sr.xcck202_desc2 = 0
#                  END IF
#               END IF
               #dorislai-20151006-add----(E)   151102 dorislai mark (E)
               
               #毛利率
               LET sr.xcck202_desc3 = sr.xcck202_desc2 / sr.xcck202_desc1 * 100
               CALL s_num_round('1',sr.xcck202_desc3,2) RETURNING sr.xcck202_desc3
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = sr.xcck010
               CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET sr.xcck010_desc = '', g_rtn_fields[1] , ''
               LET sr.xcck010_desc_1 = '', g_rtn_fields[2] , ''

               #銷售額占比%
               LET sr.xcck202_desc4 = sr.xcck202_desc1/l_xcck202_desc4_sum * 100
               CALL s_num_round('1',sr.xcck202_desc4,2) RETURNING sr.xcck202_desc4
               #毛利占比%
               LET sr.xcck202_desc5 = sr.xcck202_desc2/l_xcck202_desc5_sum * 100
               CALL s_num_round('1',sr.xcck202_desc5,2) RETURNING sr.xcck202_desc5                              
               INSERT INTO axcq913_tmp ( xccksite,xccksite_desc,xcck024,xcck006,xcck007,xcck009,xcck013,xcck010,xcck010_desc,xcck010_desc_1,
                                      xcck011,xcck022,xcck022_desc,xcck023,xcck002,xcck002_desc,xcck044,xcck044_desc,xcck201,xcck202,
                                      xcck202_desc1,xcck202_desc4,xcck202_desc2,xcck202_desc5,xcck202_desc3,xcckcomp,xcckcomp_desc,xcckld,xcckld_desc,xcck001,
                                      xcck004,xcck005,xcck003,xcck001_desc,xcck004_desc,xcck005_desc,xcck003_desc,xcck_key)
                              VALUES ( sr.xccksite,sr.xccksite_desc,sr.xcck024,sr.xcck006,sr.xcck007,sr.xcck009,sr.xcck013,sr.xcck010,
                                       sr.xcck010_desc,sr.xcck010_desc_1,sr.xcck011,sr.xcck022,sr.xcck022_desc,sr.xcck023,sr.xcck002,
                                       sr.xcck002_desc,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck202,sr.xcck202_desc1,sr.xcck202_desc4,
                                       sr.xcck202_desc2,sr.xcck202_desc5,sr.xcck202_desc3,sr.xcckcomp,sr.xcckcomp_desc,sr.xcckld,sr.xcckld_desc,
                                       sr.xcck001,sr.xcck004,sr.xcck005,sr.xcck003,sr.xcck001_desc,sr.xcck004_desc,sr.xcck005_desc,
                                       sr.xcck003_desc,sr.xcck_key)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'insert axcq_tmp'
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
                  
            END FOREACH

            LET l_xcck202_desc4_sum = l_xcck202_desc1_tmp
            LET l_xcck202_desc5_sum = l_xcck202_desc2_tmp
         END IF
         

         #dorislai-20151001-add----(E)
         
         #dorislai-20151001-mark----(S)
#         INSERT INTO axcq913_tmp ( xccksite,xccksite_desc,xcck006,xcck007,xcck009,xcck013,xcck010,xcck010_desc,xcck010_desc_1,
#                                   xcck011,xcck022,xcck022_desc,xcck002,xcck002_desc,xcck044,xcck044_desc,xcck201,xcck202,
#                                   xcck202_desc1,xcck202_desc2,xcck202_desc3,xcckcomp,xcckcomp_desc,xcckld,xcckld_desc,xcck001,
#                                   xcck004,xcck005,xcck003,xcck001_desc,xcck004_desc,xcck005_desc,xcck003_desc,xcck_key)
#                          VALUES ( sr.xccksite,sr.xccksite_desc,sr.xcck006,sr.xcck007,sr.xcck009,sr.xcck013,sr.xcck010,
#                                   sr.xcck010_desc,sr.xcck010_desc_1,sr.xcck011,sr.xcck022,sr.xcck022_desc,sr.xcck002,
#                                   sr.xcck002_desc,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck202,sr.xcck202_desc1,
#                                   sr.xcck202_desc2,sr.xcck202_desc3,sr.xcckcomp,sr.xcckcomp_desc,sr.xcckld,sr.xcckld_desc,
#                                   sr.xcck001,sr.xcck004,sr.xcck005,sr.xcck003,sr.xcck001_desc,sr.xcck004_desc,sr.xcck005_desc,
#                                   sr.xcck003_desc,sr.xcck_key)

         #dorislai-20151001-mark----(E)
         IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'insert axcq_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET l_success = FALSE
         END IF

      END FOREACH
      #dorislai-20151002-add----(S)
      #寫入最後一筆據點的資料
      IF l_chk THEN
         #與b_fill_1段相同，差別僅多加入據點條件
         LET l_sql_tmp = l_sql," AND xcck055 IN ('305','307','303','215') AND xccksite = '",l_site_chk,"'", 
                         " GROUP BY xccksite,xcck024,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck023,xcck002,xcck044,t1.ooefl003,t2.imaal003,t3.pmaal004,t4.xcbfl003,t5.oocal003,xrcb022" #151112-00012#1-add-'xrcb022'
         LET l_sql_tmp = l_sql_tmp, " ORDER BY xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,xcck044"
         
         PREPARE axcq913_ins_tmp_pre2 FROM l_sql_tmp
         DECLARE axcq913_ins_tmp_cs2 CURSOR FOR axcq913_ins_tmp_pre2
    
         OPEN axcq913_ins_tmp_cs2 USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003
         FOREACH axcq913_ins_tmp_cs2 INTO sr.xccksite,sr.xcck024,sr.xcck006,sr.xcck007,sr.xcck009,sr.xcck013,sr.xcck010,
                                          sr.xcck011,sr.xcck022,sr.xcck023,sr.xcck002,sr.xcck044,sr.xcck201,sr.xcck202, 
                                          sr.xccksite_desc,sr.xcck010_desc,sr.xcck022_desc,sr.xcck002_desc,sr.xcck044_desc,
                                          l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022 #151112-00012#1-add
            #151112-00012#1-mark-(S)
#            #先將值歸零
#            LET l_xrcb113 = 0
#            LET l_xrcb123 = 0
#            LET l_xrcb133 = 0
#            LET l_xrcb022 = 0
#            #抓取金額、正負值
#            SELECT xrcb113,xrcb123,xrcb133,xrcb022 INTO l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022
#              FROM xrca_t,xrcb_t
#             WHERE xrcaent = xrcbent AND xrcaent = g_enterprise
#               AND xrcald  = xrcbld  AND xrcald  = g_xcck_m.xcckld
#               AND xrcadocno = xrcbdocno
#               AND xrca001 IN ('01','02','12','17','22')
#               AND xrcb002 = sr.xcck006
#               AND xrcb003 = sr.xcck007
#               AND xrcb023 <> 'Y'
            #151112-00012#1-mark-(E)
            
            CASE sr.xcck001
                 WHEN '1' LET sr.xcck202_desc1 = l_xrcb113 * l_xrcb022
                 WHEN '2' LET sr.xcck202_desc1 = l_xrcb123 * l_xrcb022
                 WHEN '3' LET sr.xcck202_desc1 = l_xrcb133 * l_xrcb022
            END CASE
    
            IF cl_null(sr.xcck202_desc1) THEN
               LET sr.xcck202_desc1 = 0
            END IF      
            
            
            #毛利
            LET sr.xcck202_desc2 = sr.xcck202_desc1 - sr.xcck202
           
            #若有兩筆參考單號、項次            
#            LET l_cnt1 = 0
#            SELECT COUNT(1) INTO l_cnt1 
#              FROM xcck_t
#             WHERE xcckent = g_enterprise AND xcckld = sr.xcckld
#               AND xcck001 = sr.xcck001   AND xcck003 = sr.xcck003
#               AND xcck006 = sr.xcck006   AND xcck007 = sr.xcck007               
#            IF l_cnt1 > 1 THEN
#               #出庫碼 = 1 的，收入、毛利值清除
#               #出庫碼 = -1 的，收入、毛利值留下
#               IF sr.xcck009 = 1 THEN
#                  LET l_xcck202_desc4_sum = l_xcck202_desc4_sum - sr.xcck202_desc1
#                  LET l_xcck202_desc5_sum = l_xcck202_desc5_sum - sr.xcck202_desc2
#                  LET sr.xcck202_desc1 = 0
#                  LET sr.xcck202_desc2 = 0
#               END IF
#            END IF

            #毛利率
            LET sr.xcck202_desc3 = sr.xcck202_desc2 / sr.xcck202_desc1 * 100
            CALL s_num_round('1',sr.xcck202_desc3,2) RETURNING sr.xcck202_desc3
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = sr.xcck010
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET sr.xcck010_desc = '', g_rtn_fields[1] , ''
            LET sr.xcck010_desc_1 = '', g_rtn_fields[2] , ''
            
            #銷售額占比%
            LET sr.xcck202_desc4 = sr.xcck202_desc1/l_xcck202_desc4_sum * 100
            CALL s_num_round('1',sr.xcck202_desc4,2) RETURNING sr.xcck202_desc4
            #毛利占比%
            LET sr.xcck202_desc5 = sr.xcck202_desc2/l_xcck202_desc5_sum * 100
            CALL s_num_round('1',sr.xcck202_desc5,2) RETURNING sr.xcck202_desc5                              
            INSERT INTO axcq913_tmp ( xccksite,xccksite_desc,xcck024,xcck006,xcck007,xcck009,xcck013,xcck010,xcck010_desc,xcck010_desc_1,
                                   xcck011,xcck022,xcck022_desc,xcck023,xcck002,xcck002_desc,xcck044,xcck044_desc,xcck201,xcck202,
                                   xcck202_desc1,xcck202_desc4,xcck202_desc2,xcck202_desc5,xcck202_desc3,xcckcomp,xcckcomp_desc,xcckld,xcckld_desc,xcck001,
                                   xcck004,xcck005,xcck003,xcck001_desc,xcck004_desc,xcck005_desc,xcck003_desc,xcck_key)
                           VALUES ( sr.xccksite,sr.xccksite_desc,sr.xcck024,sr.xcck006,sr.xcck007,sr.xcck009,sr.xcck013,sr.xcck010,
                                    sr.xcck010_desc,sr.xcck010_desc_1,sr.xcck011,sr.xcck022,sr.xcck022_desc,sr.xcck023,sr.xcck002,
                                    sr.xcck002_desc,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck202,sr.xcck202_desc1,sr.xcck202_desc4,
                                    sr.xcck202_desc2,sr.xcck202_desc5,sr.xcck202_desc3,sr.xcckcomp,sr.xcckcomp_desc,sr.xcckld,sr.xcckld_desc,
                                    sr.xcck001,sr.xcck004,sr.xcck005,sr.xcck003,sr.xcck001_desc,sr.xcck004_desc,sr.xcck005_desc,
                                    sr.xcck003_desc,sr.xcck_key)
            IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = 'insert axcq_tmp'
                 LET g_errparam.code = SQLCA.SQLCODE
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
                 LET l_success = FALSE
            END IF
         END FOREACH
      END IF
      FREE axcq913_ins_tmp_pre2
      #dorislai-20151002-add----(E)
      CALL cl_err_collect_show()
      IF l_success = FALSE THEN
        DELETE FROM axcq913_tmp
      END IF
      
      FREE axcq913_ins_tmp_pre
       
    END FOR
END FUNCTION

################################################################################
# Descriptions...: 替换axcq913_b_fill()   #150805-00001#11add
################################################################################
PRIVATE FUNCTION axcq913_b_fill_1()
#   DEFINE l_sql             STRING
#   DEFINE l_xcck201_sum     LIKE xcck_t.xcck201    #dorislai-20150923-add
#   DEFINE l_xcck202_sum     LIKE xcck_t.xcck202
#   DEFINE l_amt_sum         LIKE xcck_t.xcck202
#   DEFINE l_amt1_sum        LIKE xcck_t.xcck202
#   DEFINE l_xcck201_total   LIKE xcck_t.xcck201    #dorislai-20150923-add
#   DEFINE l_xcck202_total   LIKE xcck_t.xcck202
#   DEFINE l_amt_total       LIKE xcck_t.xcck202
#   DEFINE l_amt1_total      LIKE xcck_t.xcck202
#   DEFINE l_xmdk014         LIKE xmdk_t.xmdk014
#   DEFINE l_xmdl027         LIKE xmdl_t.xmdl027
#   DEFINE l_xmdl028         LIKE xmdl_t.xmdl028
#   DEFINE l_xrcb113         LIKE xrcb_t.xrcb113
#   DEFINE l_xrcb123         LIKE xrcb_t.xrcb123
#   DEFINE l_xrcb133         LIKE xrcb_t.xrcb133
#   DEFINE l_xrcb022         LIKE xrcb_t.xrcb022
#   DEFINE l_i               LIKE type_t.num5       #dorislai-20151006-add---(S)
#   DEFINE l_j               LIKE type_t.num5       
#   DEFINE l_cnt             LIKE type_t.num5
#   DEFINE l_k               LIKE type_t.num5       #dorislai-20151006-add---(E)
#   
#   #151130-00003#15-add-(S)
#   #加入二次篩選
#   IF NOT cl_null(g_wc_filter) THEN
#      LET g_wc = g_wc CLIPPED,"AND ",g_wc_filter 
#   END IF
#   #151130-00003#15-add-(E)
#   
#   #dorislai-20151001-modify----(S)     
##   LET g_sql = "SELECT  UNIQUE xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,          
##           xcck044,SUM(xcck201*xcck009*-1),SUM(xcck202*xcck009*-1),t1.ooefl003 ,t2.imaal003 ,t3.pmaal004 ,t4.xcbfl003 ,t5.oocal003 FROM xcck_t", 
##          
##               "",
##               
##                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
##               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcck010 AND t2.imaal002='"||g_dlang||"' ",
##               " LEFT JOIN pmaal_t t3 ON t3.pmaalent='"||g_enterprise||"' AND t3.pmaal001=xcck022 AND t3.pmaal002='"||g_dlang||"' ",
##               " LEFT JOIN xcbfl_t t4 ON t4.xcbflent='"||g_enterprise||"' AND t4.xcbflcomp=xcckcomp AND t4.xcbfl001=xcck002 AND t4.xcbfl002='"||g_dlang||"' ",
##               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
## 
##               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? "  
#   LET g_sql = "SELECT UNIQUE xccksite,xcck024,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck023,xcck002,",   
#               "xcck044,SUM(xcck201*xcck009*-1),SUM(xcck202*xcck009*-1),t1.ooefl003 ,t2.imaal003 ,t3.pmaal004 ,t4.xcbfl003,",
#               #151112-00012#1-mod-(S)
##               "t5.oocal003 FROM xcck_t", 
##               "t5.oocal003,SUM(xrcb113),SUM(xrcb123),SUM(xrcb133),xrcb022 FROM xcck_t", 
#                "t5.oocal003,xrcb113,xrcb123,xrcb133,xrcb022 FROM xcck_t", 
##               " LEFT JOIN xrca_t ON xrcaent=xcckent AND xrcald=xcckld AND xrcastus <> 'X' AND xrca001 IN ('01','02','12','17','22') ",
##               " LEFT JOIN xrcb_t ON xrcbent=xrcaent AND xrcbld=xrcald AND xrcbdocno=xrcadocno AND  xrcb002=xcck006 AND xrcb003=xcck007 AND xrcb023<>'Y'",
#               " LEFT OUTER JOIN xrcb_t ON xrcbent=xcckent AND xrcbld=xcckld AND xrcb002=xcck006 AND xrcb003=xcck007 AND xrcb023<>'Y'",
#               " INNER JOIN xrca_t ON xrcbent = xrcaent AND xrcbld = xrcald AND xrcastus <> 'X' AND xrca001 IN ('01','02','12','17','22')",
#               #151112-00012#1-mod-(E)
#               " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcck010 AND t2.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN pmaal_t t3 ON t3.pmaalent='"||g_enterprise||"' AND t3.pmaal001=xcck022 AND t3.pmaal002='"||g_dlang||"' ",
#               " LEFT JOIN xcbfl_t t4 ON t4.xcbflent='"||g_enterprise||"' AND t4.xcbflcomp=xcckcomp AND t4.xcbfl001=xcck002 AND t4.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
#               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND ", g_wc 
#   
#   #dorislai-20151001-modify----(E)
#   IF NOT cl_null(g_wc2_table1) THEN
#      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
#   END IF
#   LET g_sql = g_sql," AND (xcck004*12+xcck005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"   #wujie 15111
#   LET g_sql = g_sql," AND xcck055 IN ('305','307','303','215')",    #fengmy 150112
#               #dorislai-20151001-modify----(S)
##               " GROUP BY xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,xcck044,t1.ooefl003,t2.imaal003,t3.pmaal004,t4.xcbfl003,t5.oocal003"                 
#               " GROUP BY xccksite,xcck024,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck023,xcck002,xcck044,t1.ooefl003,t2.imaal003,t3.pmaal004,t4.xcbfl003,t5.oocal003,xrcb022" #151112-00012#1-add-'xrcb022'
#               #dorislai-20151001-modify----(E)               
#   LET l_sql = g_sql
#   
#   #子單身的WC
#   
#   
#   #判斷是否填充
#   IF axcq913_fill_chk(1) THEN
#      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
#         LET g_sql = g_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck009"
#         LET g_sql = l_sql, " ORDER BY xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,xcck044"
#         #dorislai-20151020-mark----(S)  加總值歸零，應寫在外圈
##         LET l_xcck202_sum = 0
##         LET l_amt_sum = 0
##         LET l_amt1_sum = 0
##         LET l_xcck202_total = 0
##         LET l_amt_total = 0
##         LET l_amt1_total = 0
#         #dorislai-20151020-mark----(E)
#         LET g_sql_tmp = g_sql  #dujuan150324
#     
#         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#         PREPARE axcq913_pb3 FROM g_sql
#         DECLARE b_fill_cs3 CURSOR FOR axcq913_pb3
#      END IF
#      #dorislai-20151020-add----(S)
#      LET l_xcck201_sum = 0    
#      LET l_xcck202_sum = 0
#      LET l_amt_sum = 0
#      LET l_amt1_sum = 0
#      LET l_xcck201_total = 0 
#      LET l_xcck202_total = 0
#      LET l_amt_total = 0
#      LET l_amt1_total = 0
#      LET l_i = 1              
#      #dorislai-20151020-add----(E)         
#      LET g_cnt = l_ac
#      LET l_ac = 1
#      
#      OPEN b_fill_cs3 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003
#      #dorislai-20151001-modify----(S)                                         
##      FOREACH b_fill_cs3 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck009, 
##          g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck022,        
##          g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202, 
##          g_xcck_d[l_ac].xccksite_desc,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck022_desc,g_xcck_d[l_ac].xcck002_desc, 
##          g_xcck_d[l_ac].xcck044_desc
#      FOREACH b_fill_cs3 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck024,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,
#                              g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,
#                              g_xcck_d[l_ac].xcck022,g_xcck_d[l_ac].xcck023,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck044,
#                              g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xccksite_desc,
#                              g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck022_desc,g_xcck_d[l_ac].xcck002_desc, 
#                              g_xcck_d[l_ac].xcck044_desc,l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022 #151112-00012#1-add-l_xrcb113.l_xrcb123.l_xrcb133.l_xrcb022
#      #dorislai-20151001-modify----(E)       
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "FOREACH:" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            EXIT FOREACH
#         END IF
#         
#         #151112-00012#1-mark----(S)
##         #dorislai-2015105-add---(S)  
##         #需將值清空，避免出現抓到NULL值時，無法寫入，造成值仍為舊值         
##         LET l_xrcb113 = 0
##         LET l_xrcb123 = 0
##         LET l_xrcb133 = 0
##         LET l_xrcb022 = 0
##         #dorislai-2015105-add---(E)
##         #销售收入
##         SELECT xrcb113,xrcb123,xrcb133,xrcb022 INTO l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022
##           FROM xrca_t,xrcb_t
##          WHERE xrcaent = xrcbent AND xrcaent = g_enterprise
##            AND xrcald  = xrcbld  AND xrcald  = g_xcck_m.xcckld
##            AND xrcadocno = xrcbdocno
##            AND xrca001 IN ('01','02','12','17','22')
##            AND xrcastus <> 'X'   #151101 Sarah add 排除作廢的應收
##            AND xrcb002 = g_xcck_d[l_ac].xcck006
##            AND xrcb003 = g_xcck_d[l_ac].xcck007
##            AND xrcb023 <> 'Y'
#         #151112-00012#1-mark----(E)
#         CASE g_xcck_m.xcck001
#              WHEN '1' LET g_xcck_d[l_ac].amt = l_xrcb113 * l_xrcb022
#              WHEN '2' LET g_xcck_d[l_ac].amt = l_xrcb123 * l_xrcb022
#              WHEN '3' LET g_xcck_d[l_ac].amt = l_xrcb133 * l_xrcb022
#         END CASE
#
#         IF cl_null(g_xcck_d[l_ac].amt) THEN
#            LET g_xcck_d[l_ac].amt = 0
#         END IF
#         
#         #毛利
#         LET g_xcck_d[l_ac].amt1 = g_xcck_d[l_ac].amt - g_xcck_d[l_ac].xcck202
#         
#         #毛利率
#         LET g_xcck_d[l_ac].amt2 = g_xcck_d[l_ac].amt1 / g_xcck_d[l_ac].amt * 100
#         CALL s_num_round('1',g_xcck_d[l_ac].amt2,2) RETURNING g_xcck_d[l_ac].amt2
#         
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
#         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
#         LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , ''
#          
#         CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc
#         
#         #依成本组织小计
#         LET l_xcck201_sum = l_xcck201_sum + g_xcck_d[l_ac].xcck201      #dorislai-20150923-add
#         LET l_xcck202_sum = l_xcck202_sum + g_xcck_d[l_ac].xcck202
#         LET l_amt_sum = l_amt_sum + g_xcck_d[l_ac].amt
#         LET l_amt1_sum = l_amt1_sum + g_xcck_d[l_ac].amt1
#         LET l_xcck201_total = l_xcck201_total + g_xcck_d[l_ac].xcck201  #dorislai-20150923-add
#         LET l_xcck202_total = l_xcck202_total + g_xcck_d[l_ac].xcck202
#         LET l_amt_total = l_amt_total + g_xcck_d[l_ac].amt
#         LET l_amt1_total = l_amt1_total + g_xcck_d[l_ac].amt1
#      #151101 Sarah mark -----(S)
#         #dorislai-20151006-add----(S)
#         #計算是否有兩筆資料，僅需留下出庫碼為1的金額
##         LET l_cnt = 0 
##         SELECT COUNT(1) INTO l_cnt
##           FROM xcck_t
##          WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
##            AND xcck001 = g_xcck_m.xcck001 AND xcck003 = g_xcck_m.xcck003 
##            AND xcck006 = g_xcck_d[l_ac].xcck006 
##            AND xcck007 = g_xcck_d[l_ac].xcck007 
##         IF l_cnt > 1 THEN
##            #出庫碼 = 1 的，收入、毛利值清除
##            #出庫碼 = -1 的，收入、毛利值留下
##            IF g_xcck_d[l_ac].xcck009 = 1 THEN
##               LET l_amt_sum = l_amt_sum - g_xcck_d[l_ac].amt
##               LET l_amt1_sum = l_amt_sum - g_xcck_d[l_ac].amt
##               LET g_xcck_d[l_ac].amt = 0
##               LET g_xcck_d[l_ac].amt1 = 0
##            END IF
##         END IF 
#         #dorislai-20151006-add----(E)
#      #151101 Sarah mark -----(E)
#         IF l_ac > 1 THEN
#            IF g_xcck_d[l_ac].xccksite != g_xcck_d[l_ac - 1].xccksite THEN   
#               #把当前行下移，并在当前行显示小计
#               LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*  
#               INITIALIZE  g_xcck_d[l_ac].* TO NULL              
#               LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)
#               LET g_xcck_d[l_ac].xcck201 = l_xcck201_sum - g_xcck_d[l_ac + 1].xcck201   #dorislai-20150923-add
#               LET g_xcck_d[l_ac].xcck202 = l_xcck202_sum - g_xcck_d[l_ac + 1].xcck202
#               LET g_xcck_d[l_ac].amt = l_amt_sum - g_xcck_d[l_ac + 1].amt
#               LET g_xcck_d[l_ac].amt1 = l_amt1_sum - g_xcck_d[l_ac + 1].amt1
#               
#               #dorislai-20151001-add----(S)
#               #銷售額占比、毛利占比
#               IF l_i = 0 THEN LET l_i = 1 END IF
#               FOR l_j = l_i TO l_ac - 1
#                  IF g_xcck_d[l_j].xccksite  = cl_getmsg("axc-00205",g_dlang) THEN
#                     CONTINUE FOR
#                  END IF
#                  LET g_xcck_d[l_j].amt8 = g_xcck_d[l_j].amt / g_xcck_d[l_ac].amt * 100
#                  CALL s_num_round('1',g_xcck_d[l_j].amt8,2) RETURNING g_xcck_d[l_j].amt8
#                  LET g_xcck_d[l_j].amt9 = g_xcck_d[l_j].amt1 / g_xcck_d[l_ac].amt1 * 100
#                  CALL s_num_round('1',g_xcck_d[l_j].amt9,2) RETURNING g_xcck_d[l_j].amt9
#               END FOR
#               LET l_i = l_ac
#               #dorislai-20151001-add----(E)   
#               
#               LET l_ac = l_ac + 1
#               LET l_xcck201_sum = g_xcck_d[l_ac].xcck201   #dorislai-20150923-add   
#               LET l_xcck202_sum = g_xcck_d[l_ac].xcck202
#               LET l_amt_sum = g_xcck_d[l_ac].amt
#               LET l_amt1_sum = g_xcck_d[l_ac].amt1
#
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
#      CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
# 
#      
#   END IF
#   
#        
#   #最后一组小计
#   LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)
#   LET g_xcck_d[l_ac].xcck201 = l_xcck201_sum   #dorislai-20150923-add
#   LET g_xcck_d[l_ac].xcck202 = l_xcck202_sum
#   LET g_xcck_d[l_ac].amt = l_amt_sum
#   LET g_xcck_d[l_ac].amt1 = l_amt1_sum
#   #dorislai-20151001-add----(S)
#   #銷售額占比、毛利占比
#   IF l_i = 0 THEN LET l_i = 1 END IF
#   FOR l_j = l_i TO l_ac - 1
#      IF g_xcck_d[l_j].xccksite  = cl_getmsg("axc-00205",g_dlang) THEN
#         CONTINUE FOR
#      END IF
#      LET g_xcck_d[l_j].amt8 = g_xcck_d[l_j].amt / g_xcck_d[l_ac].amt * 100
#      CALL s_num_round('1',g_xcck_d[l_j].amt8,2) RETURNING g_xcck_d[l_j].amt8
#      LET g_xcck_d[l_j].amt9 = g_xcck_d[l_j].amt1 / g_xcck_d[l_ac].amt1 * 100
#      CALL s_num_round('1',g_xcck_d[l_j].amt9,2) RETURNING g_xcck_d[l_j].amt9
#   END FOR
#   #dorislai-20151001-add----(E)
#   LET l_ac = l_ac + 1
#   
#   #合计
#   LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00204",g_lang)
#   LET g_xcck_d[l_ac].xcck201 = l_xcck201_total   #dorislai-20150923-add
#   LET g_xcck_d[l_ac].xcck202 = l_xcck202_total
#   LET g_xcck_d[l_ac].amt = l_amt_total
#   LET g_xcck_d[l_ac].amt1 = l_amt1_total
#   LET l_ac = l_ac + 1
#   
#   LET g_rec_b=l_ac-1
#   DISPLAY g_rec_b TO FORMONLY.cnt  
#   LET l_ac = g_cnt
#   LET g_cnt = 0 
# 
#   #遮罩相關處理
#   FOR l_ac = 1 TO g_xcck_d.getLength()
#      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
#      CALL axcq913_xcck_t_mask()
#      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
#   END FOR
#   
#   FREE axcq913_pb   
   
END FUNCTION

################################################################################
# Descriptions...: #+ filter過濾功能
# Memo...........:
# Usage..........: CALL axcq913_filter()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151130 By Dorislai (151130-00003#15)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq913_filter()
#   DEFINE  ls_result   STRING
#
#   LET l_ac = 1
#   LET g_detail_idx = 1
#   LET g_detail_idx2 = 1
# 
#   LET INT_FLAG = 0
# 
#   LET g_qryparam.state = 'c'
# 
#   LET g_wc_filter_t = g_wc_filter
#   LET g_wc_t = g_wc
#   
#   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
#   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
# 
#   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
#   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
# 
#      #單頭
#      CONSTRUCT g_wc_filter ON xccksite,xcck024,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022, 
#                               xcck023,xcck002,xcck044,xcck201_s,xcck202_s,amt8,amt9,amt2
#           FROM s_detail1[1].xccksite,s_detail1[1].xcck024,s_detail1[1].xcck006,s_detail1[1].xcck007, 
#                s_detail1[1].xcck009,s_detail1[1].xcck013,s_detail1[1].xcck010,s_detail1[1].xcck011,s_detail1[1].xcck022, 
#                s_detail1[1].xcck023,s_detail1[1].xcck002,s_detail1[1].xcck044,s_detail1[1].xcck201_s, 
#                s_detail1[1].xcck202_s,s_detail1[1].amt8,s_detail1[1].amt9,s_detail1[1].amt2
# 
#         BEFORE CONSTRUCT         
#            DISPLAY axcq913_filter_parser('xccksite') TO s_detail1[1].xccksite
#            DISPLAY axcq913_filter_parser('xcck024') TO s_detail1[1].xcck024
#            DISPLAY axcq913_filter_parser('xcck006') TO s_detail1[1].xcck006
#            DISPLAY axcq913_filter_parser('xcck007') TO s_detail1[1].xcck007 
#            DISPLAY axcq913_filter_parser('xcck009') TO s_detail1[1].xcck009
#            DISPLAY axcq913_filter_parser('xcck013') TO s_detail1[1].xcck013
#            DISPLAY axcq913_filter_parser('xcck010') TO s_detail1[1].xcck010
#            DISPLAY axcq913_filter_parser('xcck011') TO s_detail1[1].xcck011
#            DISPLAY axcq913_filter_parser('xcck022') TO s_detail1[1].xcck022 
#            DISPLAY axcq913_filter_parser('xcck023') TO s_detail1[1].xcck023
#            DISPLAY axcq913_filter_parser('xcck002') TO s_detail1[1].xcck002
#            DISPLAY axcq913_filter_parser('xcck044') TO s_detail1[1].xcck044
#            DISPLAY axcq913_filter_parser('xcck201_s') TO s_detail1[1].xcck201_s 
#            DISPLAY axcq913_filter_parser('xcck202_s') TO s_detail1[1].xcck202_s
#            DISPLAY axcq913_filter_parser('amt8') TO s_detail1[1].amt8
#            DISPLAY axcq913_filter_parser('amt9') TO s_detail1[1].amt9
#            DISPLAY axcq913_filter_parser('amt2') TO s_detail1[1].amt2
# 
#         #單身公用欄位開窗相關處理
#         
#           
#         #單身一般欄位開窗相關處理
#         ON ACTION controlp INFIELD xccksite
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xccksite  #顯示到畫面上
#            NEXT FIELD xccksite                     #返回原欄位
#    
#
#         ON ACTION controlp INFIELD xcck006
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " xmdkstus = 'S'"
#            CALL q_xmdkdocno_1()                       #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上            
#            NEXT FIELD xcck006
#
#         ON ACTION controlp INFIELD xcck010
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#			   LET g_qryparam.reqry = FALSE
#            CALL q_imaf001_15()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
#            NEXT FIELD xcck010                     #返回原欄位
#
#         ON ACTION controlp INFIELD xcck011
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_xcck011()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcck011  #顯示到畫面上
#            NEXT FIELD xcck011                     #返回原欄位
#
#
#         ON ACTION controlp INFIELD xcck022
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_pmaa001_4()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcck022  #顯示到畫面上
#            NEXT FIELD xcck022                     #返回原欄位
#
#         ON ACTION controlp INFIELD xcck023
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c' 
#            LET g_qryparam.reqry = FALSE
#            CALL q_oocq002()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcck023  #顯示到畫面上
#            NEXT FIELD xcck023                     #返回原欄位
#
#         ON ACTION controlp INFIELD xcck002
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_xcbf001()                       #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上            
#            NEXT FIELD xcck002                     #返回原欄位
#            #END add-point
#
#         ON ACTION controlp INFIELD xcck044
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_ooca001_1()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcck044  #顯示到畫面上
#            NEXT FIELD xcck044                     #返回原欄位
#    
#
# 
#      END CONSTRUCT
# 
#      #add-point:filter段add_cs
#
#      #end add-point
# 
#      BEFORE DIALOG
#         #add-point:filter段b_dialog
#
#         #end add-point  
# 
#      ON ACTION accept
#         ACCEPT DIALOG 
# 
#      ON ACTION cancel
#         LET INT_FLAG = 1
#         EXIT DIALOG 
# 
#      #交談指令共用ACTION
#      &include "common_action.4gl" 
#         CONTINUE DIALOG
# 
#   END DIALOG
# 
#   IF NOT INT_FLAG THEN
#      LET g_wc_filter = g_wc_filter, " "
#      LET g_wc_filter_t = g_wc_filter
#   ELSE
#      LET g_wc_filter = g_wc_filter_t
#   END IF
#   
#   CALL axcq913_filter_show('xccksite','xccksite')
#   CALL axcq913_filter_show('xcck024','xcck024')
#   CALL axcq913_filter_show('xcck006','xcck006')
#   CALL axcq913_filter_show('xcck007','xcck007')
#   CALL axcq913_filter_show('xcck009','xcck009')
#   CALL axcq913_filter_show('xcck013','xcck013')
#   CALL axcq913_filter_show('xcck010','xcck010')
#   CALL axcq913_filter_show('xcck011','xcck011')
#   CALL axcq913_filter_show('xcck022','xcck022')
#   CALL axcq913_filter_show('xcck023','xcck023')
#   CALL axcq913_filter_show('xcck002','xcck002')
#   CALL axcq913_filter_show('xcck044','xcck044')
#   CALL axcq913_filter_show('xcck201_s','xcck201_s')
#   CALL axcq913_filter_show('xcck202_s','xcck202_s')
#   CALL axcq913_filter_show('amt8','amt8')
#   CALL axcq913_filter_show('amt9','amt9')
#   CALL axcq913_filter_show('amt2','amt2')
# 
#    
#    
##   CALL axcq913_b_fill(g_wc2)
#   CALL axcq913_browser_fill("")
#   
#   LET g_wc = g_wc_t
#   
#   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
#   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
#   
END FUNCTION

################################################################################
# Descriptions...: #+ Browser標題欄位顯示搜尋條件
# Memo...........:
# Usage..........: CALL axcq913_filter_show(ps_field,ps_object)
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai(151130-00003#15)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq913_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
#   DEFINE lnode_item       om.DomNode
#   DEFINE ls_title         STRING
#   DEFINE ls_name          STRING
#   DEFINE ls_condition     STRING
#   
#   LET ls_name = "formonly.", ps_object
# 
#   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
#   LET ls_title = lnode_item.getAttribute("text")
#   IF ls_title.getIndexOf('※',1) > 0 THEN
#      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
#   END IF
# 
#   #顯示資料組合
#   LET ls_condition = axcq913_filter_parser(ps_field)
#   IF NOT cl_null(ls_condition) THEN
#      LET ls_title = ls_title, '※', ls_condition, '※'
#   END IF
# 
#   #將資料顯示回去
#   CALL lnode_item.setAttribute("text",ls_title)
END FUNCTION

################################################################################
# Descriptions...: #+ filter欄位解析
# Memo...........:
# Usage..........: CALL axcq913_filter_parser(ps_field)
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai(151130-00003#15)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq913_filter_parser(ps_field)
  DEFINE ps_field   STRING
#   DEFINE ls_tmp     STRING
#   DEFINE li_tmp     LIKE type_t.num5
#   DEFINE li_tmp2    LIKE type_t.num5
#   DEFINE ls_var     STRING
#   
#   #一般條件解析
#   LET ls_tmp = ps_field, "='"
#   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
#   IF li_tmp > 0 THEN
#      LET li_tmp = ls_tmp.getLength() + li_tmp
#      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
#      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
#   END IF
# 
#   #模糊條件解析
#   LET ls_tmp = ps_field, " like '"
#   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
#   IF li_tmp > 0 THEN
#      LET li_tmp = ls_tmp.getLength() + li_tmp
#      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
#      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
#      LET ls_var = cl_replace_str(ls_var,'%','*')
#   END IF
# 
#   RETURN ls_var
END FUNCTION

################################################################################
# Descriptions...: 优化b_fill()
# Memo...........:
# Usage..........: CALL axcq913_b_fill1()
# Date & Author..: 2016/05/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq913_b_fill1()
   #add-point:b_fill段define name="b_fill.define_customerization"

   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql             STRING
   DEFINE l_xcck202_sum     LIKE xcck_t.xcck202
   DEFINE l_amt_sum         LIKE xcck_t.xcck202
   DEFINE l_amt1_sum        LIKE xcck_t.xcck202
   DEFINE l_xcck202_total   LIKE xcck_t.xcck202
   DEFINE l_amt_total       LIKE xcck_t.xcck202
   DEFINE l_amt1_total      LIKE xcck_t.xcck202
   DEFINE l_xmdk014         LIKE xmdk_t.xmdk014
   DEFINE l_xmdl027         LIKE xmdl_t.xmdl027
   DEFINE l_xmdl028         LIKE xmdl_t.xmdl028
   #20150317  --Begin
   DEFINE l_xrcb113         LIKE xrcb_t.xrcb113
   DEFINE l_xrcb123         LIKE xrcb_t.xrcb123
   DEFINE l_xrcb133         LIKE xrcb_t.xrcb133
   DEFINE l_xrcb022         LIKE xrcb_t.xrcb022
   #20150317  --End
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"

   #end add-point
   
   #先清空單身變數內容
   CALL g_xcck_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #150805-00001#11add
   #CALL axcq913_b_fill_1()
   #RETURN
   #150805-00001#11add
   #160520-00002#5 add---s---
   LET g_sql = " SELECT CASE WHEN ? = '1' THEN CASE WHEN xrcb113*xrcb022 IS NULL THEN 0 ELSE xrcb113*xrcb022 END ",
               "             WHEN ? = '2' THEN CASE WHEN xrcb123*xrcb022 IS NULL THEN 0 ELSE xrcb123*xrcb022 END ",
               "             WHEN ? = '3' THEN CASE WHEN xrcb133*xrcb022 IS NULL THEN 0 ELSE xrcb133*xrcb022 END END ",  
               "   FROM xrca_t,xrcb_t ",
               "  WHERE xrcaent = xrcbent AND xrcaent = '",g_enterprise,"'",
               "    AND xrcald  = xrcbld  AND xrcald  = '",g_xcck_m.xcckld,"' ",
               "    AND xrcadocno = xrcbdocno ",
               "    AND xrca001 IN ('01','02','12','17','22') ",
               "    AND xrcb002 = ? ",
               "    AND xrcb003 = ? ",
               "    AND xrcb023 <> 'Y' " 

   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xrcald IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xrcacomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#9-e-add


   PREPARE axcq913_pr1 FROM g_sql 
   #160520-00002#5 add---e---
   #end add-point
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT  UNIQUE xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002, 
                xcck044,SUM(xcck201*xcck009*-1),SUM(xcck202*xcck009*-1),t1.ooefl003 ,t2.imaal003 ,t2.imaal004 ,t3.pmaal004 ,t4.xcbfl003 ,t5.oocal003 FROM xcck_t",   #160520-00002#5 add t2.imaal004
          
               "",
               
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=xccksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent='"||g_enterprise||"' AND t2.imaal001=xcck010 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent='"||g_enterprise||"' AND t3.pmaal001=xcck022 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN xcbfl_t t4 ON t4.xcbflent='"||g_enterprise||"' AND t4.xcbflcomp=xcckcomp AND t4.xcbfl001=xcck002 AND t4.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
 
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?" 

   #160802-00020#9-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xcckld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xcckcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#9-e-add

   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
#   LET g_sql = g_sql," AND (xcck055 = '305' OR xcck055 = '307')",   #fengmy 150112 mark
   LET g_sql = g_sql," AND xcck055 IN ('305','307','303','215')",    #fengmy 150112
               " GROUP BY xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,xcck044,t1.ooefl003,t2.imaal003,t2.imaal004,t3.pmaal004,t4.xcbfl003,t5.oocal003" #160520-00002#5 add t2.imaal004
   LET l_sql = g_sql
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq913_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck009"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
      LET g_sql = l_sql, " ORDER BY xccksite,xcck006,xcck007,xcck009,xcck013,xcck010,xcck011,xcck022,xcck002,xcck044"
      LET l_xcck202_sum = 0
      LET l_amt_sum = 0
      LET l_amt1_sum = 0
      LET l_xcck202_total = 0
      LET l_amt_total = 0
      LET l_amt1_total = 0
      LET g_sql_tmp = g_sql  #dujuan150324
     
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq913_pb_1 FROM g_sql
         DECLARE b_fill_cs_1 CURSOR FOR axcq913_pb_1
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs_1 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
                                               
      FOREACH b_fill_cs_1 INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck009, 
          g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck022, 
          g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202, 
          g_xcck_d[l_ac].xccksite_desc,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck010_desc_1, #160520-00002#5 add g_xcck_d[l_ac].xcck010_desc_1
          g_xcck_d[l_ac].xcck022_desc,g_xcck_d[l_ac].xcck002_desc,   
          g_xcck_d[l_ac].xcck044_desc
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"

         #销售收入
         #20150317  --Begin
         #SELECT xmdl027 INTO l_xmdl027 FROM xmdl_t
         # WHERE xmdlent = g_enterprise AND xmdldocno = g_xcck_d[l_ac].xcck006 AND xmdlseq = g_xcck_d[l_ac].xcck007
         
         #160520-00002#5 mod--s----
         #SELECT xrcb113,xrcb123,xrcb133,xrcb022 INTO l_xrcb113,l_xrcb123,l_xrcb133,l_xrcb022
         #  FROM xrca_t,xrcb_t
         # WHERE xrcaent = xrcbent AND xrcaent = g_enterprise
         #   AND xrcald  = xrcbld  AND xrcald  = g_xcck_m.xcckld
         #   AND xrcadocno = xrcbdocno
         #   AND xrca001 IN ('01','02','12','17','22')
         #   AND xrcb002 = g_xcck_d[l_ac].xcck006
         #   AND xrcb003 = g_xcck_d[l_ac].xcck007
         #   AND xrcb023 <> 'Y'
            
         EXECUTE axcq913_pr1 USING g_xcck_m.xcck001,g_xcck_m.xcck001,g_xcck_m.xcck001,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007
                               INTO g_xcck_d[l_ac].amt 
         #160520-00002#5 mod--e----
         
#160520-00002#5
#         CASE g_xcck_m.xcck001
#              WHEN '1' LET g_xcck_d[l_ac].amt = l_xrcb113 * l_xrcb022
#              WHEN '2' LET g_xcck_d[l_ac].amt = l_xrcb123 * l_xrcb022
#              WHEN '3' LET g_xcck_d[l_ac].amt = l_xrcb133 * l_xrcb022
#         END CASE
#160520-00002#5

         #LET g_xcck_d[l_ac].amt = l_xmdl027
         #LET g_xcck_d[l_ac].amt = g_xcck_d[l_ac].amt * g_xcck_d[l_ac].xcck009*-1
         #20150317  --End


         IF cl_null(g_xcck_d[l_ac].amt) THEN
            LET g_xcck_d[l_ac].amt = 0
         END IF

  
         
         #毛利
         LET g_xcck_d[l_ac].amt1 = g_xcck_d[l_ac].amt - g_xcck_d[l_ac].xcck202   
         
         #毛利率
         LET g_xcck_d[l_ac].amt2 = g_xcck_d[l_ac].amt1 / g_xcck_d[l_ac].amt * 100
         CALL s_num_round('1',g_xcck_d[l_ac].amt2,2) RETURNING g_xcck_d[l_ac].amt2

#160520-00002#5
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
#         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
#         LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , ''
#160520-00002#5

         #CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc  #160520-00002#5


         #依成本组织小计
        
         LET l_xcck202_sum = l_xcck202_sum + g_xcck_d[l_ac].xcck202
         LET l_amt_sum = l_amt_sum + g_xcck_d[l_ac].amt
         LET l_amt1_sum = l_amt1_sum + g_xcck_d[l_ac].amt1
         LET l_xcck202_total = l_xcck202_total + g_xcck_d[l_ac].xcck202
         LET l_amt_total = l_amt_total + g_xcck_d[l_ac].amt
         LET l_amt1_total = l_amt1_total + g_xcck_d[l_ac].amt1
 
         IF l_ac > 1 THEN
            IF g_xcck_d[l_ac].xccksite != g_xcck_d[l_ac - 1].xccksite THEN   
              
               #把当前行下移，并在当前行显示小计
               LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*  
               INITIALIZE  g_xcck_d[l_ac].* TO NULL              
               LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)
               LET g_xcck_d[l_ac].xcck202 = l_xcck202_sum - g_xcck_d[l_ac + 1].xcck202
               LET g_xcck_d[l_ac].amt = l_amt_sum - g_xcck_d[l_ac + 1].amt
               LET g_xcck_d[l_ac].amt1 = l_amt1_sum - g_xcck_d[l_ac + 1].amt1
               LET l_ac = l_ac + 1
               LET l_xcck202_sum = g_xcck_d[l_ac].xcck202
               LET l_amt_sum = g_xcck_d[l_ac].amt
               LET l_amt1_sum = g_xcck_d[l_ac].amt1
            END IF
         END IF
               
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
 
            CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   #最后一组小计
   LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00205",g_lang)
   LET g_xcck_d[l_ac].xcck202 = l_xcck202_sum
   LET g_xcck_d[l_ac].amt = l_amt_sum
   LET g_xcck_d[l_ac].amt1 = l_amt1_sum
   LET l_ac = l_ac + 1
   #合计
   LET g_xcck_d[l_ac].xccksite = cl_getmsg("axc-00204",g_lang) 
   LET g_xcck_d[l_ac].xcck202 = l_xcck202_total
   LET g_xcck_d[l_ac].amt = l_amt_total
   LET g_xcck_d[l_ac].amt1 = l_amt1_total


   LET l_ac = l_ac + 1
      #20150806--add--str--lujh
   IF axcq913_fill_chk(1) THEN   
      LET g_sql = "SELECT xcck028,SUM(xcck202*xcck009),",
                  "       (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='",g_enterprise,"' AND rtaxl001=xcck028 AND rtaxl002='",g_dlang,"')",  #160520-00002#5 add 
                  "  FROM xcck_t ",
                  " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?"                 
      
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
      END IF
      
      LET g_sql = g_sql," AND xcck055 IN ('305','307','303','215')"
      
      LET g_sql = g_sql," GROUP BY xcck028 ",
                        " ORDER BY xcck028 "	
      PREPARE axcq913_xcck_sum_prep1 FROM g_sql
      DECLARE axcq913_xcck_sum_cs1 CURSOR FOR axcq913_xcck_sum_prep1

      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN axcq913_xcck_sum_cs1 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
                                         
      FOREACH axcq913_xcck_sum_cs1 INTO g_xcck3_d[l_ac].xcck028,g_xcck3_d[l_ac].xcck202,g_xcck3_d[l_ac].xcck028_2_desc  #160520-00002#5 add g_xcck3_d[l_ac].xcck028_desc 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH xcck:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

#160520-00002#5
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_xcck3_d[l_ac].xcck028
#         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_xcck3_d[l_ac].xcck028_2_desc = '', g_rtn_fields[1] , ''
#160520-00002#5

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF         
      END FOREACH
   END IF

   CALL g_xcck3_d.deleteElement(g_xcck3_d.getLength())
   FREE axcq913_xcck_sum_prep1
   #20150806--add--end--lujh
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcck_d.getLength()
      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
      CALL axcq913_xcck_t_mask()
      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
   END FOR
   
 
 
   FREE axcq913_pb_1 
END FUNCTION

 
{</section>}
 
