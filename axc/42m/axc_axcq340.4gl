#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq340.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-05-20 11:11:03), PR版次:0006(2016-10-21 15:33:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: axcq340
#+ Description: 料件領用與投入數量和金額差異查詢
#+ Creator....: 05947(2015-07-30 14:12:26)
#+ Modifier...: 04543 -SD/PR- 05384
 
{</section>}
 
{<section id="axcq340.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160413-00011#10  2016/04/22 By  lixiang  效能优化
#160414-00018#46  2016/05/20 By  earl     效能優化
#160905-00007#3   2016/09/05 By  zhujing  调整系统中无ENT的SQL条件增加ent
#160803-00021#1   2016/10/14 By  02295    1.重工工单数据抓取时增加xcck055='207'的xcck资料
#                                         2.本作业不需要查询拆件式工单资料
#160802-00020#7   2016/10/06 By shiun    增加帳套權限管控、法人權限管控
#161019-00017#4  2016/10/21 By lixiang  调整组织栏位的开窗
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
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr80, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr80, 
   chk LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcck_d        RECORD
       xcck002 LIKE xcck_t.xcck002, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_1 LIKE type_t.chr500, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck017 LIKE xcck_t.xcck017, 
   xcbb006 LIKE type_t.chr500, 
   xcck047 LIKE xcck_t.xcck047, 
   sfaa010 LIKE type_t.chr500, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc_1 LIKE type_t.chr500, 
   xcbb006a LIKE type_t.chr500, 
   sfaa003 LIKE type_t.chr500, 
   sfaa042 LIKE type_t.chr500, 
   xcck201 LIKE type_t.chr500, 
   xcck202 LIKE type_t.chr500, 
   xcce201 LIKE type_t.chr500, 
   xcce202 LIKE type_t.chr500, 
   diffqty LIKE type_t.chr500, 
   diffamt LIKE type_t.chr500, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck009 LIKE xcck_t.xcck009
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_xcck2_d RECORD
   xcck002_1 LIKE xcck_t.xcck002, 
   xcck010_1 LIKE xcck_t.xcck010, 
   xcck010_1_desc  LIKE imaal_t.imaal003, 
   xcck010_1_desc1 LIKE imaal_t.imaal004, 
   xcck011_1 LIKE xcck_t.xcck011, 
   xcck017_1 LIKE xcck_t.xcck017, 
   xcbb006_1 LIKE xcbb_t.xcbb006, 
   xcck047_1 LIKE xcck_t.xcck047, 
   sfaa010_1 LIKE sfaa_t.sfaa010, 
   sfaa010_1_desc  LIKE imaal_t.imaal003, 
   sfaa010_1_desc1 LIKE imaal_t.imaal004, 
   xcbb006_1a LIKE xcbb_t.xcbb006,
   sfaa003_1 LIKE sfaa_t.sfaa003, 
   sfaa042_1 LIKE sfaa_t.sfaa042, 
   xcck201_1 LIKE xcck_t.xcck201, 
   xcck202_1 LIKE xcck_t.xcck202, 
   xcce201_1 LIKE xcce_t.xcce201, 
   xcce202_1 LIKE xcce_t.xcce202, 
   diffqty_1 LIKE xcck_t.xcck201, 
   diffamt_1 LIKE xcck_t.xcck202
       END RECORD
DEFINE g_xcck2_d          DYNAMIC ARRAY OF type_g_xcck2_d
DEFINE g_xcck2_d_t        type_g_xcck2_d
TYPE type_g_xcck3_d RECORD
   xcck002_2 LIKE xcck_t.xcck002, 
   xcck010_2 LIKE xcck_t.xcck010, 
   xcck010_2_desc  LIKE imaal_t.imaal003, 
   xcck010_2_desc1 LIKE imaal_t.imaal004, 
   xcck011_2 LIKE xcck_t.xcck011, 
   xcck017_2 LIKE xcck_t.xcck017, 
   xcbb006_2 LIKE xcbb_t.xcbb006, 
   xcck047_2 LIKE xcck_t.xcck047, 
   sfaa010_2 LIKE sfaa_t.sfaa010, 
   sfaa010_2_desc  LIKE imaal_t.imaal003, 
   sfaa010_2_desc1 LIKE imaal_t.imaal004, 
   xcbb006_2a LIKE xcbb_t.xcbb006,
   sfaa003_2 LIKE sfaa_t.sfaa003, 
   sfaa042_2 LIKE sfaa_t.sfaa042, 
   xcck201_2 LIKE xcck_t.xcck201, 
   xcck202_2 LIKE xcck_t.xcck202, 
   xcce201_2 LIKE xcce_t.xcce201, 
   xcce202_2 LIKE xcce_t.xcce202, 
   diffqty_2 LIKE xcck_t.xcck201, 
   diffamt_2 LIKE xcck_t.xcck202
       END RECORD
DEFINE g_xcck3_d          DYNAMIC ARRAY OF type_g_xcck3_d
DEFINE g_xcck3_d_t        type_g_xcck3_d
DEFINE g_sql_tmp             STRING
TYPE type_g_xcck_e RECORD
       v          STRING
       END RECORD
DEFINE g_param     type_g_xcck_e
DEFINE g_wc3                 STRING
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa022       LIKE glaa_t.glaa022

DEFINE g_rec_b2              LIKE type_t.num5
#add--160802-00020#7 By shiun--(S)
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#add--160802-00020#7 By shiun--(E)
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcck_m          type_g_xcck_m
DEFINE g_xcck_m_t        type_g_xcck_m
DEFINE g_xcck_m_o        type_g_xcck_m
DEFINE g_xcck_m_mask_o   type_g_xcck_m #轉換遮罩前資料
DEFINE g_xcck_m_mask_n   type_g_xcck_m #轉換遮罩後資料
 
   DEFINE g_xcckld_t LIKE xcck_t.xcckld
DEFINE g_xcck004_t LIKE xcck_t.xcck004
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
DEFINE g_chk         LIKE type_t.chr1
#end add-point
 
{</section>}
 
{<section id="axcq340.main" >}
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
   #add--160802-00020#7 By shiun--(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #add--160802-00020#7 By shiun--(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xcckcomp,'',xcckld,'',xcck004,xcck005,xcck003,'',''", 
                      " FROM xcck_t",
                      " WHERE xcckent= ? AND xcckld=? AND xcck003=? AND xcck004=? AND xcck005=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq340_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcckcomp,t0.xcckld,t0.xcck004,t0.xcck005,t0.xcck003,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003",
               " FROM xcck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.xcckcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent="||g_enterprise||" AND t2.glaalld=t0.xcckld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xcck003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcckent = " ||g_enterprise|| " AND t0.xcckld = ? AND t0.xcck003 = ? AND t0.xcck004 = ? AND t0.xcck005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   #LET g_sql = g_sql.trim()," AND xcck055='3012' "    #160803-00021#1 mark
   LET g_sql = g_sql.trim()," AND xcck055 IN('3012','207') AND xcck020 <> '113' "  #160803-00021#1 add
   #end add-point
   PREPARE axcq340_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq340 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq340_init()   
 
      #進入選單 Menu (="N")
      CALL axcq340_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq340
      
   END IF 
   
   CLOSE axcq340_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq340.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq340_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_xcat005   LIKE xcat_t.xcat005
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
   LET g_xcck_m.chk = 'N'
   
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible("xcck011,xcck011_1,xcck011_2",FALSE)
   ELSE
      CALL cl_set_comp_visible("xcck011,xcck011_1,xcck011_2",TRUE)
   END IF
      
   #IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
   #   CALL cl_set_comp_visible("xcck011",FALSE)
   #END IF
   #SELECT xcat005 INTO l_xcat005 FROM xcat_t 
   #if xcat005<>'3'
   #CALL cl_set_comp_visible("xcck002",FALSE)
   #end if 
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible("xcck002,xcck002_1,xcck002_2",FALSE)
   ELSE
      CALL cl_set_comp_visible("xcck002,xcck002_1,xcck002_2",TRUE)   
   END IF
   CALL cl_set_comp_visible("xcck017",FALSE) 
   #end add-point
   
   CALL axcq340_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq340.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq340_ui_dialog()
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
         INITIALIZE g_xcck_m.* TO NULL
         CALL g_xcck_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq340_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq340_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq340_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
              #IF g_glaa015 = 'Y' THEN 
                  #CALL axcq340_b_fill_1(g_wc3) #單身填充  #160413-00011#10  mark #axcq340_ui_detailshow()中会调用show函数，show()会调用b_bill(),b_fill()中会调用b_fill_1,所以此次无需再调用一次b_fill_1()
               #END IF
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
         DISPLAY ARRAY g_xcck2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq340_idx_chk()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               CALL axcq340_ui_detailshow()
               
               #add-point:page1自定義行為
               IF g_glaa015 = 'Y' THEN 
                  CALL axcq340_b_fill_2(g_wc3) #單身填充
               END IF
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 1
  
         END DISPLAY
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq340_browser_fill("")
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
               CALL axcq340_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq340_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq340_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq340_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq340_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq340_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq340_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq340_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq340_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq340_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq340_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq340_idx_chk()
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
               NEXT FIELD xcck001
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
               CALL axcq340_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq340_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq340_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               IF g_xcck_d.getLength()>0 THEN
                  #CALL axcq340_create_temp()  
                  #CALL axcq340_i_tmp()               
                  LET g_param.v = "axcq340_xccktmp"
                  CALL axcq340_x01('1=1',g_param.v)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               IF g_xcck_d.getLength()>0 THEN
                  #CALL axcq340_create_temp()  
                  #CALL axcq340_i_tmp()               
                  LET g_param.v = "axcq340_xccktmp"
                  CALL axcq340_x01('1=1',g_param.v)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq340_query()
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
            CALL axcq340_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq340_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq340_set_pk_array()
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
 
{<section id="axcq340.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq340_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq340.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq340_browser_fill(ps_page_action)
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
   #LET g_wc=g_wc.trim()," AND xcck055='3012' "   #160803-00021#1 mark
   LET g_wc=g_wc.trim()," AND xcck055 IN('3012','207') AND xcck020 <> '113'"   #160803-00021#1 add
   #end add-point    
 
   LET l_searchcol = "xcckld,xcck003,xcck004,xcck005"
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
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql ," AND xcckld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql ," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   #add--160802-00020#7 By shiun--(E)
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
 
   #依照t0.xcckld,t0.xcck003,t0.xcck004,t0.xcck005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcckld,t0.xcck003,t0.xcck004,t0.xcck005",
                " FROM xcck_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcckent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcck_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcckld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
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
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcckld,g_browser[g_cnt].b_xcck003,g_browser[g_cnt].b_xcck004, 
          g_browser[g_cnt].b_xcck005 
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
   CALL axcq340_fetch('')
   
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
 
{<section id="axcq340.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq340_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld   
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003   
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004   
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005   
 
   EXECUTE axcq340_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp, 
       g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcckld_desc, 
       g_xcck_m.xcck003_desc
   CALL axcq340_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq340_ui_detailshow()
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
 
{<section id="axcq340.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq340_ui_browser_refresh()
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
 
{<section id="axcq340.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq340_construct()
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
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcckcomp,xcckld,xcck004,xcck005,xcck003
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xcckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="construct.c.xcckcomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #add--160802-00020#7 By shiun--(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #add--160802-00020#7 By shiun--(S)
            #CALL q_ooef001()                           #呼叫開窗  #161019-00017#4
            CALL q_ooef001_2()   #161019-00017#4
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
            
 
 
         #Ctrlp:construct.c.xcckld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="construct.c.xcckld"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #add--160802-00020#7 By shiun--(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #add--160802-00020#7 By shiun--(E)
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
            #應用 a08 樣板自動產生(Version:2)
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
 
      CONSTRUCT g_wc2_table1 ON xcck002,xcck010,xcck011,xcck017,xcbb006,xcck047,sfaa010,sfaa010_desc, 
          sfaa010_desc_1,xcbb006a,sfaa003,sfaa042,xcck201,xcck202,xcce201,xcce202,diffqty,diffamt,xcck001, 
          xcck006,xcck007,xcck008,xcck009
           FROM s_detail1[1].xcck002,s_detail1[1].xcck010,s_detail1[1].xcck011,s_detail1[1].xcck017, 
               s_detail1[1].xcbb006,s_detail1[1].xcck047,s_detail1[1].sfaa010,s_detail1[1].sfaa010_desc, 
               s_detail1[1].sfaa010_desc_1,s_detail1[1].xcbb006a,s_detail1[1].sfaa003,s_detail1[1].sfaa042, 
               s_detail1[1].xcck201,s_detail1[1].xcck202,s_detail1[1].xcce201,s_detail1[1].xcce202,s_detail1[1].diffqty, 
               s_detail1[1].diffamt,s_detail1[1].xcck001,s_detail1[1].xcck006,s_detail1[1].xcck007,s_detail1[1].xcck008, 
               s_detail1[1].xcck009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002 name="construct.b.page1.xcck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002 name="construct.a.page1.xcck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002 name="construct.c.page1.xcck002"
            
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010 name="construct.c.page1.xcck010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcck011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011 name="construct.c.page1.xcck011"
            #應用 a08 樣板自動產生(Version:2)
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
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck017
            #add-point:BEFORE FIELD xcck017 name="construct.b.page1.xcck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck017
            
            #add-point:AFTER FIELD xcck017 name="construct.a.page1.xcck017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcck017 name="construct.c.page1.xcck017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006
            #add-point:BEFORE FIELD xcbb006 name="construct.b.page1.xcbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006
            
            #add-point:AFTER FIELD xcbb006 name="construct.a.page1.xcbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006
            #add-point:ON ACTION controlp INFIELD xcbb006 name="construct.c.page1.xcbb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck047
            #add-point:BEFORE FIELD xcck047 name="construct.b.page1.xcck047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck047
            
            #add-point:AFTER FIELD xcck047 name="construct.a.page1.xcck047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck047
            #add-point:ON ACTION controlp INFIELD xcck047 name="construct.c.page1.xcck047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa010
            #add-point:BEFORE FIELD sfaa010 name="construct.b.page1.sfaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa010
            
            #add-point:AFTER FIELD sfaa010 name="construct.a.page1.sfaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa010
            #add-point:ON ACTION controlp INFIELD sfaa010 name="construct.c.page1.sfaa010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa010_desc
            #add-point:BEFORE FIELD sfaa010_desc name="construct.b.page1.sfaa010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa010_desc
            
            #add-point:AFTER FIELD sfaa010_desc name="construct.a.page1.sfaa010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfaa010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa010_desc
            #add-point:ON ACTION controlp INFIELD sfaa010_desc name="construct.c.page1.sfaa010_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa010_desc_1
            #add-point:BEFORE FIELD sfaa010_desc_1 name="construct.b.page1.sfaa010_desc_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa010_desc_1
            
            #add-point:AFTER FIELD sfaa010_desc_1 name="construct.a.page1.sfaa010_desc_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfaa010_desc_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa010_desc_1
            #add-point:ON ACTION controlp INFIELD sfaa010_desc_1 name="construct.c.page1.sfaa010_desc_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006a
            #add-point:BEFORE FIELD xcbb006a name="construct.b.page1.xcbb006a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006a
            
            #add-point:AFTER FIELD xcbb006a name="construct.a.page1.xcbb006a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcbb006a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006a
            #add-point:ON ACTION controlp INFIELD xcbb006a name="construct.c.page1.xcbb006a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa003
            #add-point:BEFORE FIELD sfaa003 name="construct.b.page1.sfaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa003
            
            #add-point:AFTER FIELD sfaa003 name="construct.a.page1.sfaa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa003
            #add-point:ON ACTION controlp INFIELD sfaa003 name="construct.c.page1.sfaa003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa042
            #add-point:BEFORE FIELD sfaa042 name="construct.b.page1.sfaa042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa042
            
            #add-point:AFTER FIELD sfaa042 name="construct.a.page1.sfaa042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfaa042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa042
            #add-point:ON ACTION controlp INFIELD sfaa042 name="construct.c.page1.sfaa042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck201
            #add-point:BEFORE FIELD xcck201 name="construct.b.page1.xcck201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck201
            
            #add-point:AFTER FIELD xcck201 name="construct.a.page1.xcck201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck201
            #add-point:ON ACTION controlp INFIELD xcck201 name="construct.c.page1.xcck201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202
            #add-point:BEFORE FIELD xcck202 name="construct.b.page1.xcck202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202
            
            #add-point:AFTER FIELD xcck202 name="construct.a.page1.xcck202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202
            #add-point:ON ACTION controlp INFIELD xcck202 name="construct.c.page1.xcck202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcce201
            #add-point:BEFORE FIELD xcce201 name="construct.b.page1.xcce201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcce201
            
            #add-point:AFTER FIELD xcce201 name="construct.a.page1.xcce201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcce201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcce201
            #add-point:ON ACTION controlp INFIELD xcce201 name="construct.c.page1.xcce201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcce202
            #add-point:BEFORE FIELD xcce202 name="construct.b.page1.xcce202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcce202
            
            #add-point:AFTER FIELD xcce202 name="construct.a.page1.xcce202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcce202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcce202
            #add-point:ON ACTION controlp INFIELD xcce202 name="construct.c.page1.xcce202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD diffqty
            #add-point:BEFORE FIELD diffqty name="construct.b.page1.diffqty"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD diffqty
            
            #add-point:AFTER FIELD diffqty name="construct.a.page1.diffqty"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.diffqty
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD diffqty
            #add-point:ON ACTION controlp INFIELD diffqty name="construct.c.page1.diffqty"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD diffamt
            #add-point:BEFORE FIELD diffamt name="construct.b.page1.diffamt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD diffamt
            
            #add-point:AFTER FIELD diffamt name="construct.a.page1.diffamt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.diffamt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD diffamt
            #add-point:ON ACTION controlp INFIELD diffamt name="construct.c.page1.diffamt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001 name="construct.b.page1.xcck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001 name="construct.a.page1.xcck001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001 name="construct.c.page1.xcck001"
            
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006 name="construct.c.page1.xcck006"
            
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
         BEFORE FIELD xcck008
            #add-point:BEFORE FIELD xcck008 name="construct.b.page1.xcck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck008
            
            #add-point:AFTER FIELD xcck008 name="construct.a.page1.xcck008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck008
            #add-point:ON ACTION controlp INFIELD xcck008 name="construct.c.page1.xcck008"
            
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
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      INPUT BY NAME g_xcck_m.chk 
         ATTRIBUTE(WITHOUT DEFAULTS)
        
        AFTER FIELD chk
          LET g_chk = g_xcck_m.chk        
        
      END INPUT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         CALL axcq340_head_default() #dorislai-20151027-add
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
 
{<section id="axcq340.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq340_query()
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
   
   CALL axcq340_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq340_browser_fill(g_wc)
      CALL axcq340_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq340_browser_fill("F")
   
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
      CALL axcq340_fetch("F") 
   END IF
   
   CALL axcq340_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq340_fetch(p_flag)
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
   
   #CALL axcq340_browser_fill(p_flag)
   
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
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq340_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp, 
       g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcckld_desc, 
       g_xcck_m.xcck003_desc
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
   CALL axcq340_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq340_set_act_visible()
   CALL axcq340_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcck_m_t.* = g_xcck_m.*
   LET g_xcck_m_o.* = g_xcck_m.*
   
   #重新顯示   
   CALL axcq340_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq340.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq340_insert()
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
   LET g_xcck003_t = NULL
   LET g_xcck004_t = NULL
   LET g_xcck005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_xcck_m.chk = "N"
 
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axcq340_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcck_m.* TO NULL
         INITIALIZE g_xcck_d TO NULL
 
         CALL axcq340_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq340_show()
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
   CALL axcq340_set_act_visible()
   CALL axcq340_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq340_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq340_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq340_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp, 
       g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcckld_desc, 
       g_xcck_m.xcck003_desc
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq340_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck004, 
       g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcck003_desc,g_xcck_m.chk
   
   #功能已完成,通報訊息中心
   CALL axcq340_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq340_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcck_m.xcckld IS NULL
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
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   CALL s_transaction_begin()
   
   OPEN axcq340_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq340_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq340_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq340_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp, 
       g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcckld_desc, 
       g_xcck_m.xcck003_desc
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq340_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq340_show()
   WHILE TRUE
      LET g_xcckld_t = g_xcck_m.xcckld
      LET g_xcck003_t = g_xcck_m.xcck003
      LET g_xcck004_t = g_xcck_m.xcck004
      LET g_xcck005_t = g_xcck_m.xcck005
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL axcq340_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq340_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcck_m.xcckld != g_xcckld_t 
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
   CALL axcq340_set_act_visible()
   CALL axcq340_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到對應位置
   CALL axcq340_browser_fill("")
 
   CALL axcq340_idx_chk()
 
   CLOSE axcq340_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axcq340_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq340.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq340_input(p_cmd)
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
   
   LET g_xcck_m.chk='N'
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
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck004, 
       g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcck003_desc,g_xcck_m.chk
   
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
   LET g_forupd_sql = "SELECT xcck002,xcck010,xcck011,xcck017,xcck047,xcck201,xcck202,xcck001,xcck006, 
       xcck007,xcck008,xcck009 FROM xcck_t WHERE xcckent=? AND xcckld=? AND xcck003=? AND xcck004=?  
       AND xcck005=? AND xcck001=? AND xcck002=? AND xcck006=? AND xcck007=? AND xcck008=? AND xcck009=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq340_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq340_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axcq340_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003, 
       g_xcck_m.chk
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq340.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003, 
          g_xcck_m.chk 
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld name="input.a.xcckld"
            IF NOT cl_null(g_xcck_m.xcckld) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcckld

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
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

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
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
         BEFORE FIELD xcck004
            #add-point:BEFORE FIELD xcck004 name="input.b.xcck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck004
            
            #add-point:AFTER FIELD xcck004 name="input.a.xcck004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck004
            #add-point:ON CHANGE xcck004 name="input.g.xcck004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck005
            #add-point:BEFORE FIELD xcck005 name="input.b.xcck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck005
            
            #add-point:AFTER FIELD xcck005 name="input.a.xcck005"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
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
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcck003

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcat001") THEN
                  #檢查成功時後續處理
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

            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.chk"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcckcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp name="input.c.xcckcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcckld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld name="input.c.xcckld"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcckld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.arg2 = "" #s

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcck_m.xcckld = g_qryparam.return1              

            DISPLAY g_xcck_m.xcckld TO xcckld              #

            NEXT FIELD xcckld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck004
            #add-point:ON ACTION controlp INFIELD xcck004 name="input.c.xcck004"
            
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcck003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_xcat001()                                #呼叫開窗

            LET g_xcck_m.xcck003 = g_qryparam.return1              

            DISPLAY g_xcck_m.xcck003 TO xcck003              #

            NEXT FIELD xcck003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
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
                            ,g_xcck_m.xcck003   
                            ,g_xcck_m.xcck004   
                            ,g_xcck_m.xcck005   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axcq340_xcck_t_mask_restore('restore_mask_o')
            
               UPDATE xcck_t SET (xcckcomp,xcckld,xcck004,xcck005,xcck003) = (g_xcck_m.xcckcomp,g_xcck_m.xcckld, 
                   g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003)
                WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
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
               LET gs_keys[2] = g_xcck_m.xcck003
               LET gs_keys_bak[2] = g_xcck003_t
               LET gs_keys[3] = g_xcck_m.xcck004
               LET gs_keys_bak[3] = g_xcck004_t
               LET gs_keys[4] = g_xcck_m.xcck005
               LET gs_keys_bak[4] = g_xcck005_t
               LET gs_keys[5] = g_xcck_d[g_detail_idx].xcck001
               LET gs_keys_bak[5] = g_xcck_d_t.xcck001
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck008
               LET gs_keys_bak[9] = g_xcck_d_t.xcck008
               LET gs_keys[10] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[10] = g_xcck_d_t.xcck009
               CALL axcq340_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     
 
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
               CALL axcq340_xcck_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq340_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcckld_t = g_xcck_m.xcckld
           LET g_xcck003_t = g_xcck_m.xcck003
           LET g_xcck004_t = g_xcck_m.xcck004
           LET g_xcck005_t = g_xcck_m.xcck005
 
           
           IF g_xcck_d.getLength() = 0 THEN
              NEXT FIELD xcck001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq340.input.body" >}
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
 
            CALL axcq340_b_fill(g_wc2) #test 
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
            CALL axcq340_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq340_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axcq340_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq340_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcck_d[l_ac].xcck001 IS NOT NULL
               AND g_xcck_d[l_ac].xcck002 IS NOT NULL
               AND g_xcck_d[l_ac].xcck006 IS NOT NULL
               AND g_xcck_d[l_ac].xcck007 IS NOT NULL
               AND g_xcck_d[l_ac].xcck008 IS NOT NULL
               AND g_xcck_d[l_ac].xcck009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcck_d_t.* = g_xcck_d[l_ac].*  #BACKUP
               LET g_xcck_d_o.* = g_xcck_d[l_ac].*  #BACKUP
               CALL axcq340_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axcq340_set_no_entry_b(l_cmd)
               OPEN axcq340_bcl USING g_enterprise,g_xcck_m.xcckld,
                                                g_xcck_m.xcck003,
                                                g_xcck_m.xcck004,
                                                g_xcck_m.xcck005,
 
                                                g_xcck_d_t.xcck001
                                                ,g_xcck_d_t.xcck002
                                                ,g_xcck_d_t.xcck006
                                                ,g_xcck_d_t.xcck007
                                                ,g_xcck_d_t.xcck008
                                                ,g_xcck_d_t.xcck009
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq340_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq340_bcl INTO g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
                      g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck047,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202, 
                      g_xcck_d[l_ac].xcck001,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
                      g_xcck_d[l_ac].xcck009
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcck_d_t.xcck001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
                  CALL axcq340_xcck_t_mask()
                  LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
                  
                  CALL axcq340_ref_show()
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
                  LET g_xcck_d[l_ac].sfaa042 = "Y"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xcck_d_t.* = g_xcck_d[l_ac].*     #新輸入資料
            LET g_xcck_d_o.* = g_xcck_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq340_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axcq340_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[g_xcck_d.getLength()].xcck001 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck002 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck006 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck007 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck008 = NULL
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
               AND xcck003 = g_xcck_m.xcck003
               AND xcck004 = g_xcck_m.xcck004
               AND xcck005 = g_xcck_m.xcck005
 
               AND xcck001 = g_xcck_d[l_ac].xcck001
               AND xcck002 = g_xcck_d[l_ac].xcck002
               AND xcck006 = g_xcck_d[l_ac].xcck006
               AND xcck007 = g_xcck_d[l_ac].xcck007
               AND xcck008 = g_xcck_d[l_ac].xcck008
               AND xcck009 = g_xcck_d[l_ac].xcck009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO xcck_t
                           (xcckent,
                            xcckcomp,xcckld,xcck004,xcck005,xcck003,
                            xcck001,xcck002,xcck006,xcck007,xcck008,xcck009
                            ,xcck010,xcck011,xcck017,xcck047,xcck201,xcck202) 
                     VALUES(g_enterprise,
                            g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,
                            g_xcck_d[l_ac].xcck001,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007, 
                                g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009
                            ,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck047, 
                                g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202)
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
               IF axcq340_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcck_m.xcckld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_m.xcck005
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcck_d_t.xcck009
 
 
                  #刪除下層單身
                  IF NOT axcq340_key_delete_b(gs_keys,'xcck_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axcq340_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq340_bcl
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
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002 name="input.b.page1.xcck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002 name="input.a.page1.xcck002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck002
            #add-point:ON CHANGE xcck002 name="input.g.page1.xcck002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010 name="input.a.page1.xcck010"


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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck017
            #add-point:BEFORE FIELD xcck017 name="input.b.page1.xcck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck017
            
            #add-point:AFTER FIELD xcck017 name="input.a.page1.xcck017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck017
            #add-point:ON CHANGE xcck017 name="input.g.page1.xcck017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006
            #add-point:BEFORE FIELD xcbb006 name="input.b.page1.xcbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006
            
            #add-point:AFTER FIELD xcbb006 name="input.a.page1.xcbb006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb006
            #add-point:ON CHANGE xcbb006 name="input.g.page1.xcbb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck047
            #add-point:BEFORE FIELD xcck047 name="input.b.page1.xcck047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck047
            
            #add-point:AFTER FIELD xcck047 name="input.a.page1.xcck047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck047
            #add-point:ON CHANGE xcck047 name="input.g.page1.xcck047"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa010
            
            #add-point:AFTER FIELD sfaa010 name="input.a.page1.sfaa010"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa010
            #add-point:BEFORE FIELD sfaa010 name="input.b.page1.sfaa010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaa010
            #add-point:ON CHANGE sfaa010 name="input.g.page1.sfaa010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa010_desc
            #add-point:BEFORE FIELD sfaa010_desc name="input.b.page1.sfaa010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa010_desc
            
            #add-point:AFTER FIELD sfaa010_desc name="input.a.page1.sfaa010_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaa010_desc
            #add-point:ON CHANGE sfaa010_desc name="input.g.page1.sfaa010_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa010_desc_1
            #add-point:BEFORE FIELD sfaa010_desc_1 name="input.b.page1.sfaa010_desc_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa010_desc_1
            
            #add-point:AFTER FIELD sfaa010_desc_1 name="input.a.page1.sfaa010_desc_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaa010_desc_1
            #add-point:ON CHANGE sfaa010_desc_1 name="input.g.page1.sfaa010_desc_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006a
            #add-point:BEFORE FIELD xcbb006a name="input.b.page1.xcbb006a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006a
            
            #add-point:AFTER FIELD xcbb006a name="input.a.page1.xcbb006a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbb006a
            #add-point:ON CHANGE xcbb006a name="input.g.page1.xcbb006a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa003
            #add-point:BEFORE FIELD sfaa003 name="input.b.page1.sfaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa003
            
            #add-point:AFTER FIELD sfaa003 name="input.a.page1.sfaa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaa003
            #add-point:ON CHANGE sfaa003 name="input.g.page1.sfaa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa042
            #add-point:BEFORE FIELD sfaa042 name="input.b.page1.sfaa042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa042
            
            #add-point:AFTER FIELD sfaa042 name="input.a.page1.sfaa042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaa042
            #add-point:ON CHANGE sfaa042 name="input.g.page1.sfaa042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck201
            #add-point:BEFORE FIELD xcck201 name="input.b.page1.xcck201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck201
            
            #add-point:AFTER FIELD xcck201 name="input.a.page1.xcck201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck201
            #add-point:ON CHANGE xcck201 name="input.g.page1.xcck201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck202
            #add-point:BEFORE FIELD xcck202 name="input.b.page1.xcck202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck202
            
            #add-point:AFTER FIELD xcck202 name="input.a.page1.xcck202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck202
            #add-point:ON CHANGE xcck202 name="input.g.page1.xcck202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcce201
            #add-point:BEFORE FIELD xcce201 name="input.b.page1.xcce201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcce201
            
            #add-point:AFTER FIELD xcce201 name="input.a.page1.xcce201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcce201
            #add-point:ON CHANGE xcce201 name="input.g.page1.xcce201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcce202
            #add-point:BEFORE FIELD xcce202 name="input.b.page1.xcce202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcce202
            
            #add-point:AFTER FIELD xcce202 name="input.a.page1.xcce202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcce202
            #add-point:ON CHANGE xcce202 name="input.g.page1.xcce202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD diffqty
            #add-point:BEFORE FIELD diffqty name="input.b.page1.diffqty"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD diffqty
            
            #add-point:AFTER FIELD diffqty name="input.a.page1.diffqty"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE diffqty
            #add-point:ON CHANGE diffqty name="input.g.page1.diffqty"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD diffamt
            #add-point:BEFORE FIELD diffamt name="input.b.page1.diffamt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD diffamt
            
            #add-point:AFTER FIELD diffamt name="input.a.page1.diffamt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE diffamt
            #add-point:ON CHANGE diffamt name="input.g.page1.diffamt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001 name="input.b.page1.xcck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001 name="input.a.page1.xcck001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck001 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck001 != g_xcck_d_t.xcck001 OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck001 = '"||g_xcck_d[g_detail_idx].xcck001 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck001
            #add-point:ON CHANGE xcck001 name="input.g.page1.xcck001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006 name="input.b.page1.xcck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006 name="input.a.page1.xcck006"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck001 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck001 != g_xcck_d_t.xcck001 OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck001 = '"||g_xcck_d[g_detail_idx].xcck001 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
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
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck001 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck001 != g_xcck_d_t.xcck001 OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck001 = '"||g_xcck_d[g_detail_idx].xcck001 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
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
         BEFORE FIELD xcck008
            #add-point:BEFORE FIELD xcck008 name="input.b.page1.xcck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck008
            
            #add-point:AFTER FIELD xcck008 name="input.a.page1.xcck008"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck001 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck001 != g_xcck_d_t.xcck001 OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck001 = '"||g_xcck_d[g_detail_idx].xcck001 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck008
            #add-point:ON CHANGE xcck008 name="input.g.page1.xcck008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009 name="input.b.page1.xcck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009 name="input.a.page1.xcck009"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck001 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck001 != g_xcck_d_t.xcck001 OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck001 = '"||g_xcck_d[g_detail_idx].xcck001 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcck009
            #add-point:ON CHANGE xcck009 name="input.g.page1.xcck009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002 name="input.c.page1.xcck002"
            
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
 
 
         #Ctrlp:input.c.page1.xcck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcck017 name="input.c.page1.xcck017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006
            #add-point:ON ACTION controlp INFIELD xcbb006 name="input.c.page1.xcbb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck047
            #add-point:ON ACTION controlp INFIELD xcck047 name="input.c.page1.xcck047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa010
            #add-point:ON ACTION controlp INFIELD sfaa010 name="input.c.page1.sfaa010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfaa010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa010_desc
            #add-point:ON ACTION controlp INFIELD sfaa010_desc name="input.c.page1.sfaa010_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfaa010_desc_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa010_desc_1
            #add-point:ON ACTION controlp INFIELD sfaa010_desc_1 name="input.c.page1.sfaa010_desc_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcbb006a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006a
            #add-point:ON ACTION controlp INFIELD xcbb006a name="input.c.page1.xcbb006a"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa003
            #add-point:ON ACTION controlp INFIELD sfaa003 name="input.c.page1.sfaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfaa042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa042
            #add-point:ON ACTION controlp INFIELD sfaa042 name="input.c.page1.sfaa042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck201
            #add-point:ON ACTION controlp INFIELD xcck201 name="input.c.page1.xcck201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck202
            #add-point:ON ACTION controlp INFIELD xcck202 name="input.c.page1.xcck202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcce201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcce201
            #add-point:ON ACTION controlp INFIELD xcce201 name="input.c.page1.xcce201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcce202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcce202
            #add-point:ON ACTION controlp INFIELD xcce202 name="input.c.page1.xcce202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.diffqty
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD diffqty
            #add-point:ON ACTION controlp INFIELD diffqty name="input.c.page1.diffqty"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.diffamt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD diffamt
            #add-point:ON ACTION controlp INFIELD diffamt name="input.c.page1.diffamt"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001 name="input.c.page1.xcck001"
            
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
 
 
         #Ctrlp:input.c.page1.xcck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck008
            #add-point:ON ACTION controlp INFIELD xcck008 name="input.c.page1.xcck008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009 name="input.c.page1.xcck009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               CLOSE axcq340_bcl
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
               LET g_errparam.extend = g_xcck_d[l_ac].xcck001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq340_xcck_t_mask_restore('restore_mask_o')
         
               UPDATE xcck_t SET (xcckld,xcck003,xcck004,xcck005,xcck002,xcck010,xcck011,xcck017,xcck047, 
                   xcck201,xcck202,xcck001,xcck006,xcck007,xcck008,xcck009) = (g_xcck_m.xcckld,g_xcck_m.xcck003, 
                   g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011, 
                   g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck047,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202, 
                   g_xcck_d[l_ac].xcck001,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
                   g_xcck_d[l_ac].xcck009)
                WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld 
                 AND xcck003 = g_xcck_m.xcck003 
                 AND xcck004 = g_xcck_m.xcck004 
                 AND xcck005 = g_xcck_m.xcck005 
 
                 AND xcck001 = g_xcck_d_t.xcck001 #項次   
                 AND xcck002 = g_xcck_d_t.xcck002  
                 AND xcck006 = g_xcck_d_t.xcck006  
                 AND xcck007 = g_xcck_d_t.xcck007  
                 AND xcck008 = g_xcck_d_t.xcck008  
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
               LET gs_keys[2] = g_xcck_m.xcck003
               LET gs_keys_bak[2] = g_xcck003_t
               LET gs_keys[3] = g_xcck_m.xcck004
               LET gs_keys_bak[3] = g_xcck004_t
               LET gs_keys[4] = g_xcck_m.xcck005
               LET gs_keys_bak[4] = g_xcck005_t
               LET gs_keys[5] = g_xcck_d[g_detail_idx].xcck001
               LET gs_keys_bak[5] = g_xcck_d_t.xcck001
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck008
               LET gs_keys_bak[9] = g_xcck_d_t.xcck008
               LET gs_keys[10] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[10] = g_xcck_d_t.xcck009
               CALL axcq340_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq340_xcck_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcck_m.xcckld
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck003
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck004
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck001
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck002
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck006
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck007
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck008
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck009
 
               CALL axcq340_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axcq340_bcl
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
 
            CLOSE axcq340_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcck_d.getLength() = 0 THEN
               NEXT FIELD xcck001
            END IF
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[li_reproduce_target].xcck001 = NULL
               LET g_xcck_d[li_reproduce_target].xcck002 = NULL
               LET g_xcck_d[li_reproduce_target].xcck006 = NULL
               LET g_xcck_d[li_reproduce_target].xcck007 = NULL
               LET g_xcck_d[li_reproduce_target].xcck008 = NULL
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
                  NEXT FIELD xcck002
 
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
 
{<section id="axcq340.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq340_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   IF g_xcck_m.chk IS NULL THEN
      LET g_xcck_m.chk = g_chk
      DISPLAY BY NAME g_xcck_m.chk
   END IF
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq340_b_fill(g_wc2) #第一階單身填充
      CALL axcq340_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axcq340_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck004, 
       g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcck003_desc,g_xcck_m.chk
 
   CALL axcq340_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
  IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('page_2',TRUE)
      CALL axcq340_b_fill_2("2") #單身填充
   ELSE
      CALL cl_set_comp_visible('page_2',FALSE)
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('page_3',TRUE)
      CALL axcq340_b_fill_2("3") #單身填充
   ELSE
      CALL cl_set_comp_visible('page_3',FALSE)
   END IF
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq340_ref_show()
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
   SELECT glaa001,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022 
     INTO g_glaa001,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022 
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_xcck_m.xcckld
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
 
{<section id="axcq340.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq340_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcck_t.xcckld 
   DEFINE l_oldno     LIKE xcck_t.xcckld 
   DEFINE l_newno02     LIKE xcck_t.xcck003 
   DEFINE l_oldno02     LIKE xcck_t.xcck003 
   DEFINE l_newno03     LIKE xcck_t.xcck004 
   DEFINE l_oldno03     LIKE xcck_t.xcck004 
   DEFINE l_newno04     LIKE xcck_t.xcck005 
   DEFINE l_oldno04     LIKE xcck_t.xcck005 
 
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
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   LET g_xcck_m.xcckld = ""
   LET g_xcck_m.xcck003 = ""
   LET g_xcck_m.xcck004 = ""
   LET g_xcck_m.xcck005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq340_set_entry('a')
   CALL axcq340_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcck_m.xcckld_desc = ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc
   LET g_xcck_m.xcck003_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
 
   
   CALL axcq340_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcck_m.* TO NULL
      INITIALIZE g_xcck_d TO NULL
 
      CALL axcq340_show()
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
   CALL axcq340_set_act_visible()
   CALL axcq340_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = " ||g_enterprise|| " AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq340_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq340_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axcq340_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq340_detail_reproduce()
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
   
   DROP TABLE axcq340_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
    AND xcck003 = g_xcck003_t
    AND xcck004 = g_xcck004_t
    AND xcck005 = g_xcck005_t
 
       INTO TEMP axcq340_detail
   
   #將key修正為調整後   
   UPDATE axcq340_detail 
      #更新key欄位
      SET xcckld = g_xcck_m.xcckld
          , xcck003 = g_xcck_m.xcck003
          , xcck004 = g_xcck_m.xcck004
          , xcck005 = g_xcck_m.xcck005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcck_t SELECT * FROM axcq340_detail
   
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
   DROP TABLE axcq340_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   DROP TABLE axcq340_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq340_delete()
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
   
   
 
   OPEN axcq340_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq340_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axcq340_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq340_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp, 
       g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckcomp_desc,g_xcck_m.xcckld_desc, 
       g_xcck_m.xcck003_desc
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq340_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL axcq340_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axcq340_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcck_t WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
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
      #   CLOSE axcq340_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcck_d.clear() 
 
     
      CALL axcq340_ui_browser_refresh()  
      #CALL axcq340_ui_headershow()  
      #CALL axcq340_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq340_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq340_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axcq340_cl
 
   #功能已完成,通報訊息中心
   CALL axcq340_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq340.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq340_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   CALL axcq340_b_fill_1(p_wc2) #單身填充
   RETURN
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcck_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcck002,xcck010,xcck011,xcck017,xcck047,xcck201,xcck202,xcck001,xcck006, 
       xcck007,xcck008,xcck009 FROM xcck_t",   
               "",
               
               
               " WHERE xcckent= ? AND xcckld=? AND xcck003=? AND xcck004=? AND xcck005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
 #LET g_sql = g_sql CLIPPED," AND xcck055='3012' AND xcckcomp='"||g_xcck_m.xcckcomp||"' AND xcck001='1'"
 
 LET g_sql = g_sql CLIPPED," AND xcckcomp='"||g_xcck_m.xcckcomp||"' AND xcck001='1'"
 
 LET g_sql_tmp=g_sql
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq340_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcck_t.xcck001,xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq340_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq340_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005 INTO g_xcck_d[l_ac].xcck002, 
          g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck047, 
          g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xcck001,g_xcck_d[l_ac].xcck006, 
          g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #获取料号的品名规格
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001 = ? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , '' 
         LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , '' 
         
         #获取成本阶
         SELECT xcbb006 INTO g_xcck_d[l_ac].xcbb006 FROM xcbb_t WHERE xcbbent=g_enterprise and xcbbcomp=g_xcck_m.xcckcomp and xcbb001=g_xcck_m.xcck004 and xcbb002=g_xcck_m.xcck005 and xcbb003=g_xcck_d[l_ac].xcck010 and xcbb004=g_xcck_d[l_ac].xcck011
         LET g_xcck_d[l_ac].xcbb006a=g_xcck_d[l_ac].xcbb006
         
         #获取主件编号，工单类型，重工否
         SELECT sfaa010,sfaa003,sfaa042 INTO g_xcck_d[l_ac].sfaa010,g_xcck_d[l_ac].sfaa003,g_xcck_d[l_ac].sfaa042 FROM sfaa_t
            WHERE sfaaent=g_enterprise and sfaadocno=g_xcck_d[l_ac].xcck006 and sfaa011=g_xcck_d[l_ac].xcck011
         IF cl_null(g_xcck_d[l_ac].sfaa042) THEN
            LET g_xcck_d[l_ac].sfaa042='N'
         END IF
         
         #获取主件编号的品名规格         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].sfaa010
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001 = ? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].sfaa010_desc = '', g_rtn_fields[1] , '' 
         LET g_xcck_d[l_ac].sfaa010_desc_1 = '', g_rtn_fields[2] , ''  

         #获取领用数量和领用金额
         SELECT SUM(xcck201),SUM(xcck202) INTO g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202 FROM xcck_t
            WHERE xcckent=g_enterprise AND xcckcomp=g_xcck_m.xcckcomp AND xcck004=g_xcck_m.xcck004 AND xcc005=g_xcck_m.xcck005 
            AND xcck003=g_xcck_m.xcck003 AND xcckld=g_xcck_m.xcckld #AND xcck055='3012' AND xcck001='1'
            GROUP BY xcck010,xcck011,xcck017,xcck002;
         IF cl_null(g_xcck_d[l_ac].xcck201) THEN LET g_xcck_d[l_ac].xcck201=0 END IF
         IF cl_null(g_xcck_d[l_ac].xcck202) THEN LET g_xcck_d[l_ac].xcck202=0 END IF
         #获取投入数量和投入金额         
         SELECT SUM(xcce201+xcce205+xcce207+xcce209),SUM(xcce202+xcce206+xcce208+xcce210) INTO g_xcck_d[l_ac].xcce201,g_xcck_d[l_ac].xcce202 FROM xcce_t
            WHERE xcceent=g_enterprise AND xccecomp=g_xcck_m.xcckcomp AND xcce004=g_xcck_m.xcck004 AND xcce005=g_xcck_m.xcck005
            AND xcce003=g_xcck_m.xcck003 AND xcceld=g_xcck_m.xcckld
            GROUP BY xcce007,xcce008,xcce009,xcce002   
         IF cl_null(g_xcck_d[l_ac].xcce201) THEN LET g_xcck_d[l_ac].xcce201=0 END IF
         IF cl_null(g_xcck_d[l_ac].xcce202) THEN LET g_xcck_d[l_ac].xcce202=0 END IF
         
         LET g_xcck_d[l_ac].diffqty=g_xcck_d[l_ac].xcck201-g_xcck_d[l_ac].xcce201
         LET g_xcck_d[l_ac].diffamt=g_xcck_d[l_ac].xcck202-g_xcck_d[l_ac].xcce202
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
 
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcck_d.getLength()
      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
      CALL axcq340_xcck_t_mask()
      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
   END FOR
   
 
 
   FREE axcq340_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq340_idx_chk()
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
 
{<section id="axcq340.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq340_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcck_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq340_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld AND
                              xcck003 = g_xcck_m.xcck003 AND
                              xcck004 = g_xcck_m.xcck004 AND
                              xcck005 = g_xcck_m.xcck005 AND
 
          xcck001 = g_xcck_d_t.xcck001
      AND xcck002 = g_xcck_d_t.xcck002
      AND xcck006 = g_xcck_d_t.xcck006
      AND xcck007 = g_xcck_d_t.xcck007
      AND xcck008 = g_xcck_d_t.xcck008
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
 
{<section id="axcq340.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq340_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axcq340.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq340_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axcq340.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq340_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axcq340.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq340_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcck_d[l_ac].xcck001 = g_xcck_d_t.xcck001 
      AND g_xcck_d[l_ac].xcck002 = g_xcck_d_t.xcck002 
      AND g_xcck_d[l_ac].xcck006 = g_xcck_d_t.xcck006 
      AND g_xcck_d[l_ac].xcck007 = g_xcck_d_t.xcck007 
      AND g_xcck_d[l_ac].xcck008 = g_xcck_d_t.xcck008 
      AND g_xcck_d[l_ac].xcck009 = g_xcck_d_t.xcck009 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axcq340_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axcq340.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq340_lock_b(ps_table,ps_page)
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
   #CALL axcq340_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq340.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq340_unlock_b(ps_table,ps_page)
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
 
{<section id="axcq340.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq340_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcckld,xcck003,xcck004,xcck005",TRUE)
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
 
{<section id="axcq340.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq340_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcckld,xcck003,xcck004,xcck005",FALSE)
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
 
{<section id="axcq340.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq340_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq340_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq340_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq340.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq340_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq340.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq340_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq340.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq340_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq340.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq340_default_search()
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
      LET ls_wc = ls_wc, " xcck003 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcck004 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcck005 = '", g_argv[04], "' AND "
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
 
{<section id="axcq340.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq340_fill_chk(ps_idx)
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
 
{<section id="axcq340.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq340_modify_detail_chk(ps_record)
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
         LET ls_return = "xcck002"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq340.mask_functions" >}
&include "erp/axc/axcq340_mask.4gl"
 
{</section>}
 
{<section id="axcq340.state_change" >}
    
 
{</section>}
 
{<section id="axcq340.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq340_set_pk_array()
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
   LET g_pk_array[2].values = g_xcck_m.xcck003
   LET g_pk_array[2].column = 'xcck003'
   LET g_pk_array[3].values = g_xcck_m.xcck004
   LET g_pk_array[3].column = 'xcck004'
   LET g_pk_array[4].values = g_xcck_m.xcck005
   LET g_pk_array[4].column = 'xcck005'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq340.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axcq340_msgcentre_notify(lc_state)
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
   CALL axcq340_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcck_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axcq340.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 创建临时报表
################################################################################
PRIVATE FUNCTION axcq340_create_temp()
DROP TABLE axcq340_xccktmp;
   CREATE TEMP TABLE axcq340_xccktmp(
   xcckcomp         VARCHAR(10), 
   l_xcckcomp       VARCHAR(100), 
   xcckld           VARCHAR(5), 
   l_xcckld         VARCHAR(100), 
   xcck004          SMALLINT, 
   xcck005          SMALLINT, 
   xcck003          VARCHAR(10), 
   l_xcck003        VARCHAR(100), 
   l_chk            VARCHAR(30), 
   xcck002          VARCHAR(30), 
   l_xcck002        VARCHAR(100), 
   xcck010          VARCHAR(40), 
   l_xcck010_desc   VARCHAR(100), 
   l_xcck010_desc1  VARCHAR(100), 
   xcck011          VARCHAR(256), 
   xcck017          VARCHAR(30), 
   l_xcbb006        SMALLINT, 
   xcck047          VARCHAR(20), 
   l_sfaa010        VARCHAR(40), 
   l_sfaa010_desc   VARCHAR(100), 
   l_sfaa010_desc1  VARCHAR(100), 
   l_xb1            VARCHAR(100), 
   l_sfaa003        VARCHAR(1), 
   l_sfaa042        VARCHAR(1), 
   l_xcck201        DECIMAL(20,6), 
   l_xcck202        DECIMAL(20,6), 
   l_xcce201        DECIMAL(20,6), 
   l_xcce202        DECIMAL(20,6), 
   l_qty            DECIMAL(20,6), 
   l_amt            DECIMAL(20,6), 
   l_key            VARCHAR(100)
);
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
PRIVATE FUNCTION axcq340_b_fill_1(p_wc2)
DEFINE p_wc2      STRING
DEFINE l_n        LIKE type_t.num5
DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004  #160414-00018#46  2016/05/20 By  earl add
         
   CALL axcq340_tmp()
   CALL axcq340_create_temp()
   DELETE FROM xccktmp
   DELETE FROM xccetmp
   DELETE FROM axcq340_xccktmp
   CALL axcq340_i_tmp()
   
   SELECT COUNT(1) INTO l_n FROM xcat_t where xcat005=3 AND xcat001=g_xcck_m.xcck003
      AND xcatent = g_enterprise #160905-00007#3 add
   IF l_n>0 THEN
      CALL cl_set_comp_visible("xcck017",TRUE) 
   END IF
   #先清空單身變數內容
   CALL g_xcck2_d.clear()
   
   #160414-00018#46  2016/05/20 By  earl mod s
   LET g_sql = "SELECT UNIQUE xcck002,xcck010,l_xcck010_desc,l_xcck010_desc1,",
               "              xcck011,xcck017,l_xcbb006,xcck047,",
               "              l_sfaa010,l_sfaa010_desc,l_sfaa010_desc1,",
               "              l_xb1,l_sfaa003,l_sfaa042,",
               "              l_xcck201,l_xcck202,l_xcce201,l_xcce202,l_qty,l_amt,",
               "              (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4007' AND gzcbl003 ='",g_dlang,"' AND gzcbl002 = l_sfaa003) gzcbl004",
               "  FROM axcq340_xccktmp",
               " WHERE xcckcomp=? AND xcckld=? AND xcck003=? AND xcck004=? AND xcck005=? "

   IF g_xcck_m.chk = 'Y' THEN
      LET g_sql = g_sql," AND l_qty <> 0"
   END IF

   #160414-00018#46  2016/05/20 By  earl mod e
        
   IF NOT cl_null(g_wc3) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc3 CLIPPED
   END IF
    
   #判斷是否填充
   IF axcq340_fill_chk(1) THEN
             
      PREPARE axcq340_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR axcq340_pb1
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
                                               
      FOREACH b_fill_cs1 INTO g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck010_desc_1,
                              g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcbb006,g_xcck_d[l_ac].xcck047,
                              g_xcck_d[l_ac].sfaa010,g_xcck_d[l_ac].sfaa010_desc,g_xcck_d[l_ac].sfaa010_desc_1,
                              g_xcck_d[l_ac].xcbb006a,g_xcck_d[l_ac].sfaa003,g_xcck_d[l_ac].sfaa042,
                              g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xcce201,g_xcck_d[l_ac].xcce202,g_xcck_d[l_ac].diffqty,g_xcck_d[l_ac].diffamt,
                              l_gzcbl004  #160414-00018#46  2016/05/20 By  earl add
                              
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
         #160414-00018#46  2016/05/20 By  earl mod s
         LET g_xcck_d[l_ac].sfaa003 = l_gzcbl004
         #SELECT gzcbl004 INTO g_xcck_d[l_ac].sfaa003 FROM gzcbl_t WHERE gzcbl001 = '4007' AND gzcbl003 ='zh_CN' AND gzcbl002=g_xcck_d[l_ac].sfaa003
         
#         IF g_xcck_m.chk = 'Y' AND g_xcck_d[l_ac].diffqty = 0 THEN
#            CALL g_xcck_d.deleteElement(l_ac)
#            CONTINUE FOREACH
#         END IF
         #160414-00018#46  2016/05/20 By  earl mod e
         
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
  
   END IF
    
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axcq340_pb1   
END FUNCTION

PRIVATE FUNCTION axcq340_b_fill_2(p_wc2)
DEFINE p_wc2      STRING
DEFINE l_xcck001  LIKE xcck_t.xcck001
DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004   #160414-00018#46  2016/05/20 By  earl mod s

   CALL axcq340_tmp()
   CALL axcq340_create_temp()
   DELETE FROM xccktmp
   DELETE FROM xccetmp
   DELETE FROM axcq340_xccktmp
   IF p_wc2="2" THEN 
      LET l_xcck001=2
   ELSE 
      LET l_xcck001=3
   END IF      
   CALL axcq340_ins_tmp(l_xcck001)
   #先清空單身變數內容
   CALL g_xcck2_d.clear()
   CALL g_xcck3_d.clear()
   
   #160414-00018#46  2016/05/20 By  earl mod s
   LET g_sql = "SELECT UNIQUE xcck002,xcck010,l_xcck010_desc,l_xcck010_desc1,",
               "              xcck011,xcck017,l_xcbb006,xcck047,",
               "              l_sfaa010,l_sfaa010_desc,l_sfaa010_desc1,",
               "              l_xb1,l_sfaa003,l_sfaa042,",
               "              l_xcck201,l_xcck202,l_xcce201,l_xcce202,",
               "              l_qty,l_amt,",
               "              (SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '4007' AND gzcbl003 = '",g_dlang,"' AND gzcbl002 = l_sfaa003) gzcbl004",
               "  FROM axcq340_xccktmp",
       " WHERE xcckcomp=? AND xcckld=? AND xcck003=? AND xcck004=? AND xcck005=?"  
   #160414-00018#46  2016/05/20 By  earl mod e
        
   IF NOT cl_null(g_wc3) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc3 CLIPPED
   END IF
    
   #判斷是否填充
   IF axcq340_fill_chk(1) THEN
             
      PREPARE axcq340_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR axcq340_pb2
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
#160414-00018#46  2016/05/20 By  earl mod s
#      FOREACH b_fill_cs2 INTO g_xcck2_d[l_ac].xcck002_1,g_xcck2_d[l_ac].xcck010_1,g_xcck2_d[l_ac].xcck011_1,g_xcck2_d[l_ac].xcck017_1,
#                              g_xcck2_d[l_ac].xcbb006_1,g_xcck2_d[l_ac].xcck047_1, g_xcck2_d[l_ac].sfaa010_1,g_xcck2_d[l_ac].xcbb006_1a,
#                              g_xcck2_d[l_ac].sfaa003_1,g_xcck2_d[l_ac].sfaa042_1

      FOREACH b_fill_cs2 INTO g_xcck2_d[l_ac].xcck002_1,g_xcck2_d[l_ac].xcck010_1,g_xcck2_d[l_ac].xcck010_1_desc,g_xcck2_d[l_ac].xcck010_1_desc1,
                              g_xcck2_d[l_ac].xcck011_1,g_xcck2_d[l_ac].xcck017_1,g_xcck2_d[l_ac].xcbb006_1,g_xcck2_d[l_ac].xcck047_1,
                              g_xcck2_d[l_ac].sfaa010_1,g_xcck2_d[l_ac].sfaa010_1_desc,g_xcck2_d[l_ac].sfaa010_1_desc1,
                              g_xcck2_d[l_ac].xcbb006_1a,g_xcck2_d[l_ac].sfaa003_1,g_xcck2_d[l_ac].sfaa042_1,
                              g_xcck2_d[l_ac].xcck201_1,g_xcck2_d[l_ac].xcck202_1,g_xcck2_d[l_ac].xcce201_1,g_xcck2_d[l_ac].xcce202_1,
                              g_xcck2_d[l_ac].diffqty_1,g_xcck2_d[l_ac].diffamt_1,
                              l_gzcbl004
#160414-00018#46  2016/05/20 By  earl mod e

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

#160414-00018#46  2016/05/20 By  earl mod s
         #SELECT gzcbl004 INTO g_xcck2_d[l_ac].sfaa003_1 FROM gzcbl_t WHERE gzcbl001 = '4007' AND gzcbl003 ='zh_CN' AND gzcbl002=g_xcck2_d[l_ac].sfaa003_1
         LET g_xcck2_d[l_ac].sfaa003_1 = l_gzcbl004
         
         LET g_xcck3_d[l_ac].xcck002_2       = g_xcck2_d[l_ac].xcck002_1
         LET g_xcck3_d[l_ac].xcck010_2       = g_xcck2_d[l_ac].xcck010_1
         LET g_xcck3_d[l_ac].xcck010_2_desc  = g_xcck2_d[l_ac].xcck010_1_desc
         LET g_xcck3_d[l_ac].xcck010_2_desc1 = g_xcck2_d[l_ac].xcck010_1_desc1
         LET g_xcck3_d[l_ac].xcck011_2       = g_xcck2_d[l_ac].xcck011_1
         LET g_xcck3_d[l_ac].xcck017_2       = g_xcck2_d[l_ac].xcck017_1
         LET g_xcck3_d[l_ac].xcbb006_2       = g_xcck2_d[l_ac].xcbb006_1
         LET g_xcck3_d[l_ac].xcck047_2       = g_xcck2_d[l_ac].xcck047_1
         LET g_xcck3_d[l_ac].sfaa010_2       = g_xcck2_d[l_ac].sfaa010_1
         LET g_xcck3_d[l_ac].sfaa010_2_desc  = g_xcck2_d[l_ac].sfaa010_1_desc
         LET g_xcck3_d[l_ac].sfaa010_2_desc1 = g_xcck2_d[l_ac].sfaa010_1_desc1
         LET g_xcck3_d[l_ac].xcbb006_2a      = g_xcck2_d[l_ac].xcbb006_1a
         LET g_xcck3_d[l_ac].sfaa003_2       = g_xcck2_d[l_ac].sfaa003_1
         LET g_xcck3_d[l_ac].sfaa042_2       = g_xcck2_d[l_ac].sfaa042_1
         LET g_xcck3_d[l_ac].xcck201_2       = g_xcck2_d[l_ac].xcck201_1
         LET g_xcck3_d[l_ac].xcck202_2       = g_xcck2_d[l_ac].xcck202_1
         LET g_xcck3_d[l_ac].xcce201_2       = g_xcck2_d[l_ac].xcce201_1
         LET g_xcck3_d[l_ac].xcce202_2       = g_xcck2_d[l_ac].xcce202_1
         LET g_xcck3_d[l_ac].diffqty_2       = g_xcck2_d[l_ac].diffqty_1
         LET g_xcck3_d[l_ac].diffamt_2       = g_xcck2_d[l_ac].diffamt_1

         
#160414-00018#46  2016/05/20 By  earl mod e
                  
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
      
      CALL g_xcck2_d.deleteElement(g_xcck_d.getLength())

#160414-00018#46  2016/05/20 By  earl mark s
#      FOREACH b_fill_cs2 INTO g_xcck3_d[l_ac].xcck002_2,g_xcck3_d[l_ac].xcck010_2,g_xcck3_d[l_ac].xcck011_2,g_xcck3_d[l_ac].xcck017_2,
#                              g_xcck3_d[l_ac].xcbb006_2,g_xcck3_d[l_ac].xcck047_2, g_xcck3_d[l_ac].sfaa010_2,g_xcck3_d[l_ac].xcbb006_2a,
#                              g_xcck3_d[l_ac].sfaa003_2,g_xcck3_d[l_ac].sfaa042_2
#                              
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "FOREACH:"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            EXIT FOREACH
#         END IF
#         
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_xcck3_d[l_ac].xcck010_2
#         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001 = ? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_xcck3_d[l_ac].xcck010_2_desc = '', g_rtn_fields[1] , '' 
#         LET g_xcck3_d[l_ac].xcck010_2_desc1 = '', g_rtn_fields[2] , '' 
#
#         LET l_ac = l_ac + 1
#         IF l_ac > g_max_rec THEN
#            EXIT FOREACH
#         END IF
#         
#      END FOREACH
#160414-00018#46  2016/05/20 By  earl mark e

      CALL g_xcck3_d.deleteElement(g_xcck3_d.getLength())


   END IF    
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axcq340_pb2   
   LET g_rec_b2 = l_ac - 1

END FUNCTION

PRIVATE FUNCTION axcq340_tmp()
DROP TABLE xccktmp;
   CREATE TEMP TABLE xccktmp(
   xcckent         SMALLINT,      #企业编号
   xcckcomp        VARCHAR(10),     #法人组织
   xcckld          VARCHAR(5),       #帐套
   xcck002         VARCHAR(30),      #成本域
   xcck003         VARCHAR(10),      #成本计算类型
   xcck004         SMALLINT,      #年度
   xcck005         SMALLINT,      #期别  
   xcck010         VARCHAR(40),      #料号    
   xcck011         VARCHAR(256),      #特性
   xcck017         VARCHAR(30),      #批号
   xcck047         VARCHAR(20),
   l_xcck201       DECIMAL(20,6), 
   l_xcck202       DECIMAL(20,6)
  );
  
  DROP TABLE xccetmp;
   CREATE TEMP TABLE xccetmp(
   xcckent         SMALLINT,      #企业编号
   xcckcomp        VARCHAR(10),     #法人组织
   xcckld          VARCHAR(5),       #帐套
   xcck002         VARCHAR(30),      #成本域
   xcck003         VARCHAR(10),      #成本计算类型
   xcck004         SMALLINT,      #年度
   xcck005         SMALLINT,      #期别       
   xcck010         VARCHAR(40),      #料号    
   xcck011         VARCHAR(256),      #特性
   xcck017         VARCHAR(30),      #批号 
   xcck047         VARCHAR(20),        #150703-00018#6
   l_xcce201       DECIMAL(20,6),  
   l_xcce202       DECIMAL(20,6)
  );
END FUNCTION

PRIVATE FUNCTION axcq340_i_tmp()
DEFINE sr           RECORD  
   xcckent         LIKE xcck_t.xcckent,
   xcckcomp        LIKE xcck_t.xcckcomp, 
   l_xcckcomp      LIKE type_t.chr100, 
   xcckld          LIKE xcck_t.xcckld, 
   l_xcckld        LIKE type_t.chr100, 
   xcck004         LIKE xcck_t.xcck004, 
   xcck005         LIKE xcck_t.xcck005,
   xcck003         LIKE xcck_t.xcck003, 
   l_xcck003       LIKE type_t.chr100, 
   l_chk           LIKE type_t.chr30, 
   xcck002         LIKE xcck_t.xcck002, 
   l_xcck002       LIKE type_t.chr100, 
   xcck010         LIKE xcck_t.xcck010, 
   l_xcck010_desc  LIKE type_t.chr100, 
   l_xcck010_desc1 LIKE type_t.chr100, 
   xcck011         LIKE xcck_t.xcck011, 
   xcck017         LIKE xcck_t.xcck017, 
   l_xcbb006       LIKE xcbb_t.xcbb006, 
   xcck047         LIKE xcck_t.xcck047, 
   l_sfaa010       LIKE sfaa_t.sfaa010, 
   l_sfaa010_desc  LIKE type_t.chr100, 
   l_sfaa010_desc1 LIKE type_t.chr100, 
   l_xb1           LIKE type_t.chr100, 
   l_sfaa003       LIKE sfaa_t.sfaa003, 
   l_sfaa042       LIKE sfaa_t.sfaa042, 
   l_xcck201       LIKE xcck_t.xcck201, 
   l_xcck202       LIKE xcck_t.xcck202, 
   l_xcce201       LIKE xcce_t.xcce201, 
   l_xcce202       LIKE xcce_t.xcce202, 
   l_qty           LIKE xcce_t.xcce201, 
   l_amt           LIKE xcce_t.xcce202, 
   l_key           LIKE type_t.chr100
    END RECORD
DEFINE l_i          LIKE type_t.num5    
DEFINE l_n          LIKE type_t.num5 
DEFINE l_sql        STRING 
DEFINE l_xcck005  LIKE type_t.chr100
DEFINE l_xcck004  LIKE type_t.chr100

#   SELECT COUNT(1) INTO l_i FROM xcck_t WHERE xcckent=g_enterprise AND xcckld = sr.xcckld AND xcck055='3012' AND xcck001=1 
#          AND xcck003 = sr.xcck003 AND xcck004 = sr.xcck004 AND xcck005 = sr.xcck005
#   SELECT COUNT(1) INTO l_n FROM xcce_t WHERE xcceent = g_enterprise AND xcceld = sr.xcckld AND xcck001=1
#          AND xcce003 = sr.xcck003 AND xcce004 = sr.xcck004 AND xcce005 = sr.xcck005  
#   IF l_i>0 OR l_n>0 THEN
   FOR l_i = 1 TO g_browser.getLength()
      INITIALIZE sr.* TO NULL          
      LET sr.xcck004  = g_browser[l_i].b_xcck004
      LET sr.xcckld   = g_browser[l_i].b_xcckld
      LET sr.xcck005  = g_browser[l_i].b_xcck005
      LET sr.xcck003  = g_browser[l_i].b_xcck003

      SELECT xcckcomp INTO sr.xcckcomp FROM xcck_t
       WHERE xcckent = g_enterprise AND xcckld = sr.xcckld 
         AND xcck003 = sr.xcck003 AND xcck004 = sr.xcck004 AND xcck005 = sr.xcck005 
         
      #插入临时表xccktmp
      LET l_sql=" INSERT INTO xccktmp ",                                                                         
         #" SELECT UNIQUE xcckent,xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017,xcck047,SUM(xcck201) over (partition BY xcck010) AS xcck201,SUM(xcck202) over (partition BY xcck010) AS xcck202 FROM xcck_t",    #150703-00018#6 mark
         " SELECT UNIQUE xcckent,xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017,xcck047,SUM(xcck201) over (partition BY xcck010,xcck047) AS xcck201,SUM(xcck202) over (partition BY xcck010,xcck047) AS xcck202 FROM xcck_t",   #150703-00018#6 add
         #" WHERE xcckent = '"||g_enterprise||"' AND xcckld = '"||sr.xcckld||"' AND xcck055='3012' AND xcck001=1 ",     #160803-00021#1 mark
         " WHERE xcckent = '"||g_enterprise||"' AND xcckld = '"||sr.xcckld||"' AND xcck055 IN('3012','207') AND xcck020 <> '113' AND xcck001=1 ",   #160803-00021#1 add
         " AND xcck003 = '"||sr.xcck003||"' AND xcck004 = '"||sr.xcck004||"' AND xcck005 = '"||sr.xcck005||"'" 
      PREPARE xcck_tmp FROM l_sql
      EXECUTE xcck_tmp
      #插入临时表xccetmp
      LET l_sql=" INSERT INTO xccetmp ",
         #" SELECT UNIQUE xcceent,xccecomp,xcceld,xcce002,xcce003,xcce004,xcce005,xcce007,xcce008,xcce009,SUM(xcce201+xcce205+xcce207+xcce209) over (partition BY xcce007) xcce201,SUM(xcce202+xcce206+xcce208+xcce210) over (partition BY xcce007) xcce202 FROM xcce_t",   #150703-00018#6 mark
         " SELECT UNIQUE xcceent,xccecomp,xcceld,xcce002,xcce003,xcce004,xcce005,xcce007,xcce008,xcce009,xcce006,SUM(xcce201+xcce205+xcce207+xcce209) over (partition BY xcce006,xcce007) xcce201,SUM(xcce202+xcce206+xcce208+xcce210) over (partition BY xcce006,xcce007) xcce202 FROM xcce_t",   #150703-00018#6 add 
         " WHERE xcceent = '"||g_enterprise||"' AND xcceld = '"||sr.xcckld||"' AND xcce001=1 ",
         " AND xcce003 = '"||sr.xcck003||"' AND xcce004 = '"||sr.xcck004||"' AND xcce005 = '"||sr.xcck005||"'" 
      PREPARE xcce_tmp FROM l_sql
      EXECUTE xcce_tmp
     
   #获取字段值
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = sr.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET sr.l_xcckcomp = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = sr.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET sr.l_xcckld = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = sr.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET sr.l_xcck003 = '', g_rtn_fields[1] , ''
        
   LET l_xcck005=sr.xcck005                                                                                                                
   LET l_xcck004=sr.xcck004
   LET sr.l_key=sr.xcckcomp,"-",sr.xcckld,"-" CLIPPED,l_xcck004,"-" CLIPPED,l_xcck005,"-",sr.xcck003 CLIPPED
   
   INITIALIZE sr.* TO NULL     
#   LET l_sql=" SELECT a_.xcckcomp,a_.xcckld,a_.xcck002,a_.xcck003,a_.xcck004,a_.xcck005,a_.xcck010,a_.xcck011,a_.xcck017,xccktmp.xcck006,xccktmp.xcck047,xccktmp.l_xcck201,xccktmp.l_xcck202,xccetmp.l_xcce201,xccetmp.l_xcce202 FROM",
#             " (SELECT xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017 FROM xccktmp",
#             " UNION",
#             " SELECT xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017 FROM xccetmp",
#             " ) a_,xccktmp,xccetmp",
#             " LEFT OUTER JOIN xccktmp ON a_.xcckcomp=xccktmp.xcckcomp AND a_.xcckld=xccktmp.xcckld AND a_.xcck004=xccktmp.xcck004 AND a_.xcck005=xccktmp.xcck005 AND a_.xcck010=xccktmp.xcck010",
#             " LEFT OUTER JOIN xccetmp ON a_.xcckcomp=xccetmp.xcckcomp AND a_.xcckld=xccetmp.xcckld AND a_.xcck004=xccetmp.xcck004 AND a_.xcck005=xccetmp.xcck005 AND a_.xcck010=xccetmp.xcck010"
   
#160414-00018#46  2016/05/20 By  earl mod s
#   LET l_sql=" SELECT UNIQUE j,a,b,c,d,e,f,g,h,i,xccktmp.xcck047,xccktmp.l_xcck201,xccktmp.l_xcck202,xccetmp.l_xcce201,xccetmp.l_xcce202 FROM",
#             " (SELECT xcckent j,xcckcomp a,xcckld b,xcck002 c,xcck003 d,xcck004 e,xcck005 f,xcck010 g,xcck011 h,xcck017 i FROM xccktmp",
#             " UNION",
#             " SELECT xcckent j,xcckcomp a,xcckld b,xcck002 c,xcck003 d,xcck004 e,xcck005 f,xcck010 g,xcck011 h,xcck017 i FROM xccetmp",
#             " ) M",
#             " LEFT OUTER JOIN xccktmp ON a=xccktmp.xcckcomp AND b=xccktmp.xcckld AND e=xccktmp.xcck004 AND f=xccktmp.xcck005 AND g=xccktmp.xcck010",
#             " LEFT OUTER JOIN xccetmp ON a=xccetmp.xcckcomp AND b=xccetmp.xcckld AND e=xccetmp.xcck004 AND f=xccetmp.xcck005 AND g=xccetmp.xcck010"

   LET l_sql=" SELECT UNIQUE j,a,b,c,d,e,f,g,h,i,k,",  #150703-00018#6
             #"               xccktmp.xcck047,",  #150703-00018#6  mark
             "               COALESCE(xccktmp.l_xcck201,0),COALESCE(xccktmp.l_xcck202,0),",
             "               COALESCE(xccetmp.l_xcce201,0),COALESCE(xccetmp.l_xcce202,0),",
             "               (SELECT imaal003 FROM imaal_t WHERE imaalent = j AND imaal001 = g AND imaal002 = '",g_dlang,"') l_xcck010_desc,",
             "               (SELECT imaal004 FROM imaal_t WHERE imaalent = j AND imaal001 = g AND imaal002 = '",g_dlang,"') l_xcck010_desc1,",
             "               (SELECT sfaa010 FROM sfaa_t WHERE sfaaent = j AND sfaadocno = k) sfaa010,",  #150703-00018#6 xccktmp.xcck047->k
             "               (SELECT sfaa003 FROM sfaa_t WHERE sfaaent = j AND sfaadocno = k) sfaa003,",  #150703-00018#6 xccktmp.xcck047->k
             "               COALESCE((SELECT sfaa042 FROM sfaa_t WHERE sfaaent = j AND sfaadocno = k),'N') sfaa042,",   #150703-00018#6 xccktmp.xcck047->k
             
             "               (SELECT xcbb006 FROM xcbb_t WHERE xcbbent = j AND xcbbcomp = a AND xcbb001 = e AND xcbb002 = f AND xcbb003 = (SELECT sfaa010 FROM sfaa_t WHERE sfaaent = j AND sfaadocno = k) AND xcbb004 = h) xcbb006,",    #150703-00018#6 xccktmp.xcck047->k          
             "               (SELECT imaal003 FROM imaal_t WHERE imaalent = j AND imaal001 = (SELECT sfaa010 FROM sfaa_t WHERE sfaaent = j AND sfaadocno = k) AND imaal002 = '",g_dlang,"') l_sfaa010_desc,",   #150703-00018#6 xccktmp.xcck047->k
             "               (SELECT imaal004 FROM imaal_t WHERE imaalent = j AND imaal001 = (SELECT sfaa010 FROM sfaa_t WHERE sfaaent = j AND sfaadocno = k) AND imaal002 = '",g_dlang,"') l_sfaa010_desc1,",  #150703-00018#6 xccktmp.xcck047->k
             "               'N',' ',",
             "               (SELECT xcbb006 FROM xcbb_t WHERE xcbbent= j and xcbbcomp=a and xcbb001=e and xcbb002=f and xcbb003=g and xcbb004=h) xcbb006_2 ",
             "   FROM",
             "       (SELECT xcckent j,xcckcomp a,xcckld b,xcck002 c,xcck003 d,xcck004 e,xcck005 f,xcck010 g,xcck011 h,xcck017 i,xcck047 k FROM xccktmp",  #150703-00018#6 add k
             "         UNION",
             "        SELECT xcckent j,xcckcomp a,xcckld b,xcck002 c,xcck003 d,xcck004 e,xcck005 f,xcck010 g,xcck011 h,xcck017 i,xcck047 k FROM xccetmp",  #150703-00018#6 add k
             "       ) M",
             " LEFT OUTER JOIN xccktmp ON a=xccktmp.xcckcomp AND b=xccktmp.xcckld AND e=xccktmp.xcck004 AND f=xccktmp.xcck005 AND g=xccktmp.xcck010 AND k=xccktmp.xcck047",
             " LEFT OUTER JOIN xccetmp ON a=xccetmp.xcckcomp AND b=xccetmp.xcckld AND e=xccetmp.xcck004 AND f=xccetmp.xcck005 AND g=xccetmp.xcck010 AND k=xccetmp.xcck047"

#160414-00018#46  2016/05/20 By  earl mod e

   PREPARE tmp FROM l_sql
   DECLARE tmp_cs CURSOR FOR tmp
   
#160414-00018#46  2016/05/20 By  earl mod s
   FOREACH tmp_cs INTO sr.xcckent,sr.xcckcomp,sr.xcckld,sr.xcck002,sr.xcck003,sr.xcck004,sr.xcck005,sr.xcck010,sr.xcck011,sr.xcck017,
                       sr.xcck047,
                       sr.l_xcck201,sr.l_xcck202,
                       sr.l_xcce201,sr.l_xcce202,
                       sr.l_xcck010_desc,
                       sr.l_xcck010_desc1,
                       sr.l_sfaa010,
                       sr.l_sfaa003,
                       sr.l_sfaa042,
                       #sr.l_xcbb006,   #150703-00018#6 mark
                       sr.l_xb1,        #150703-00018#6
                       sr.l_sfaa010_desc,
                       sr.l_sfaa010_desc1,
                       sr.l_chk,sr.l_xcck002,
                       sr.l_xcbb006    #150703-00018#6
       IF sr.l_sfaa003 = '3' THEN CONTINUE FOREACH END IF   #160803-00021#1 add              
#   FOREACH tmp_cs INTO sr.xcckent,sr.xcckcomp,sr.xcckld,sr.xcck002,sr.xcck003,sr.xcck004,sr.xcck005,sr.xcck010,sr.xcck011,sr.xcck017,sr.xcck047,sr.l_xcck201,sr.l_xcck202,sr.l_xcce201,sr.l_xcce202
#     
#      #获取料号的品名规格
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xcck010
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001 = ? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.l_xcck010_desc = '', g_rtn_fields[1] , '' 
#      LET sr.l_xcck010_desc1 = '', g_rtn_fields[2] , '' 
#
#      #获取主件编号，工单类型，重工否
#      SELECT sfaa010,sfaa003,sfaa042 INTO sr.l_sfaa010,sr.l_sfaa003,sr.l_sfaa042 FROM sfaa_t
##      WHERE sfaaent=g_enterprise and sfaadocno=g_xcck_d[l_ac].xcck006 and sfaa011=g_xcck_d[l_ac].xcck011
#WHERE sfaaent=sr.xcckent and sfaadocno=sr.xcck047
#      IF cl_null(sr.l_sfaa042) THEN
#         LET sr.l_sfaa042='N'
#      END IF
#      
#      #获取成本阶
#      SELECT xcbb006 INTO sr.l_xcbb006 FROM xcbb_t WHERE xcbbent=sr.xcckent and xcbbcomp=sr.xcckcomp and xcbb001=sr.xcck004 and xcbb002=sr.xcck005 and xcbb003=sr.l_sfaa010 and xcbb004=sr.xcck011
       #LET sr.l_xb1=sr.l_xcbb006   #150703-00018#6 mark
#      #获取主件编号的品名规格         
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.l_sfaa010
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001 = ? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.l_sfaa010_desc = '', g_rtn_fields[1] , '' 
#      LET sr.l_sfaa010_desc1 = '', g_rtn_fields[2] , ''  
#            
#      IF cl_null(sr.l_xcck201) THEN LET sr.l_xcck201=0 END IF     
#      IF cl_null(sr.l_xcck202) THEN LET sr.l_xcck202=0 END IF
#      IF cl_null(sr.l_xcce201) THEN LET sr.l_xcce201=0 END IF
#      IF cl_null(sr.l_xcce202) THEN LET sr.l_xcce202=0 END IF
      LET sr.l_qty=sr.l_xcck201-sr.l_xcce201
      LET sr.l_amt=sr.l_xcck202-sr.l_xcce202
#            
#      LET sr.l_chk='N'
#      LET sr.l_xcck002=' '
##      LET sr.xcck047=' '
#160414-00018#46  2016/05/20 By  earl mod e


      INSERT INTO axcq340_xccktmp (xcckcomp,l_xcckcomp,xcckld,l_xcckld,xcck004,xcck005,xcck003,l_xcck003,l_chk,xcck002,l_xcck002,xcck010,
         l_xcck010_desc,l_xcck010_desc1,xcck011,xcck017,l_xcbb006,xcck047,l_sfaa010,l_sfaa010_desc,l_sfaa010_desc1,l_xb1,l_sfaa003,l_sfaa042,
         l_xcck201,l_xcck202,l_xcce201,l_xcce202,l_qty,l_amt,l_key)
         VALUES (sr.xcckcomp,sr.l_xcckcomp,sr.xcckld,sr.l_xcckld,sr.xcck004,sr.xcck005,sr.xcck003,sr.l_xcck003,sr.l_chk,sr.xcck002,sr.l_xcck002,sr.xcck010,
            sr.l_xcck010_desc,sr.l_xcck010_desc1,sr.xcck011,sr.xcck017,sr.l_xcbb006,sr.xcck047,sr.l_sfaa010,sr.l_sfaa010_desc,sr.l_sfaa010_desc1,sr.l_xb1,
            sr.l_sfaa003,sr.l_sfaa042,sr.l_xcck201,sr.l_xcck202,sr.l_xcce201,sr.l_xcce202,sr.l_qty,sr.l_amt,sr.l_key)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
      END IF
      DELETE FROM xccktmp
      DELETE FROM xccetmp
  END FOREACH      
  FREE tmp_cs
  END FOR
#  END IF
END FUNCTION

################################################################################
# Descriptions...: 新增/查詢時，預帶單頭欄位
# Memo...........:
# Usage..........: CALL axcq340_head_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151027 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq340_head_default()
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003

   CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
   
   IF cl_null(g_xcck_m.xcckcomp) THEN
      LET g_xcck_m.xcckcomp = l_comp
   END IF
   IF cl_null(g_xcck_m.xcckld) THEN
      LET g_xcck_m.xcckld = l_ld
   END IF
   IF cl_null(g_xcck_m.xcck004) THEN
      LET g_xcck_m.xcck004 = l_year
   END IF
   IF cl_null(g_xcck_m.xcck005) THEN
      LET g_xcck_m.xcck005 = l_period
   END IF
   IF cl_null(g_xcck_m.xcck003) THEN
      LET g_xcck_m.xcck003 = l_calc_type
   END IF
   
   LET g_xcck_m.chk = 'N'
   LET g_chk = 'N'
   DISPLAY BY NAME g_xcck_m.chk  
   
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,
                   g_xcck_m.xcck005,g_xcck_m.xcck003
   
END FUNCTION

################################################################################
# Descriptions...: 根据本位币查询
# Memo...........:
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq340_ins_tmp(p_xcck001)
DEFINE p_xcck001   LIKE xcck_t.xcck001 
DEFINE sr           RECORD  
   xcckcomp        LIKE xcck_t.xcckcomp, 
   l_xcckcomp      LIKE type_t.chr100, 
   xcckld          LIKE xcck_t.xcckld, 
   l_xcckld        LIKE type_t.chr100, 
   xcck004         LIKE xcck_t.xcck004, 
   xcck005         LIKE xcck_t.xcck005,
   xcck003         LIKE xcck_t.xcck003, 
   l_xcck003       LIKE type_t.chr100, 
   l_chk           LIKE type_t.chr30, 
   xcck002         LIKE xcck_t.xcck002, 
   l_xcck002       LIKE type_t.chr100, 
   xcck010         LIKE xcck_t.xcck010, 
   l_xcck010_desc  LIKE type_t.chr100, 
   l_xcck010_desc1 LIKE type_t.chr100, 
   xcck011         LIKE xcck_t.xcck011, 
   xcck017         LIKE xcck_t.xcck017, 
   l_xcbb006       LIKE xcbb_t.xcbb006, 
   xcck047         LIKE xcck_t.xcck047, 
   l_sfaa010       LIKE sfaa_t.sfaa010, 
   l_sfaa010_desc  LIKE type_t.chr100, 
   l_sfaa010_desc1 LIKE type_t.chr100, 
   l_xb1           LIKE type_t.chr100, 
   l_sfaa003       LIKE sfaa_t.sfaa003, 
   l_sfaa042       LIKE sfaa_t.sfaa042, 
   l_xcck201       LIKE xcck_t.xcck201, 
   l_xcck202       LIKE xcck_t.xcck202, 
   l_xcce201       LIKE xcce_t.xcce201, 
   l_xcce202       LIKE xcce_t.xcce202, 
   l_qty           LIKE xcce_t.xcce201, 
   l_amt           LIKE xcce_t.xcce202, 
   l_key           LIKE type_t.chr100
    END RECORD
DEFINE l_i          LIKE type_t.num5   
DEFINE l_n          LIKE type_t.num5
DEFINE l_sql        STRING 
DEFINE l_xcck005  LIKE type_t.chr100
DEFINE l_xcck004  LIKE type_t.chr100

   #SELECT COUNT(1) INTO l_i FROM xcck_t WHERE xcckent=g_enterprise AND xcckld = sr.xcckld AND xcck055='3012' AND xcck001=1     #160803-00021#1 mark
   SELECT COUNT(1) INTO l_i FROM xcck_t WHERE xcckent=g_enterprise AND xcckld = sr.xcckld AND xcck055 IN('3012','207') AND xcck020 <> '113' AND xcck001=1    #160803-00021#1 add
          AND xcck003 = sr.xcck003 AND xcck004 = sr.xcck004 AND xcck005 = sr.xcck005
   SELECT COUNT(1) INTO l_n FROM xcce_t WHERE xcceent = g_enterprise AND xcceld = sr.xcckld AND xcck001=1
          AND xcce003 = sr.xcck003 AND xcce004 = sr.xcck004 AND xcce005 = sr.xcck005  
   IF l_i>0 OR l_n>0 THEN
   FOR l_i = 1 TO g_browser.getLength()
      INITIALIZE sr.* TO NULL          
      LET sr.xcck004  = g_browser[l_i].b_xcck004
      LET sr.xcckld   = g_browser[l_i].b_xcckld
      LET sr.xcck005  = g_browser[l_i].b_xcck005
      LET sr.xcck003  = g_browser[l_i].b_xcck003

      SELECT xcckcomp INTO sr.xcckcomp FROM xcck_t
       WHERE xcckent = g_enterprise AND xcckld = sr.xcckld 
         AND xcck003 = sr.xcck003 AND xcck004 = sr.xcck004 AND xcck005 = sr.xcck005 
         
      #插入临时表xcck
      LET l_sql=" INSERT INTO xccktmp ",
         " SELECT UNIQUE xcckent,xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017,xcck047,SUM(xcck201) over (partition BY xcck010) AS xcck201,SUM(xcck202) over (partition BY xcck010) AS xcck202 FROM xcck_t",  #150703-00018#6 mark
         " SELECT UNIQUE xcckent,xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017,xcck047,SUM(xcck201) over (partition BY xcck010,xcck047) AS xcck201,SUM(xcck202) over (partition BY xcck010,xcck047) AS xcck202 FROM xcck_t",  #150703-00018#6 add
         #" WHERE xcckent = '"||g_enterprise||"' AND xcckld = '"||sr.xcckld||"' AND xcck055='3012'",   #160803-00021#1 mark
         " WHERE xcckent = '"||g_enterprise||"' AND xcckld = '"||sr.xcckld||"' AND xcck055 IN('3012','207') AND xcck020 <> '113' " ,   #160803-00021#1 add
         " AND xcck003 = '"||sr.xcck003||"' AND xcck004 = '"||sr.xcck004||"' AND xcck005 = '"||sr.xcck005||"' AND xcck001= ", p_xcck001 
      PREPARE xcck_tmp1 FROM l_sql
      EXECUTE xcck_tmp1
      #插入临时表xcce
      LET l_sql=" INSERT INTO xccetmp ",
         " SELECT UNIQUE xcceent,xccecomp,xcceld,xcce002,xcce003,xcce004,xcce005,xcce007,xcce008,xcce009,SUM(xcce201+xcce205+xcce207+xcce209) over (partition BY xcce007) xcce201,SUM(xcce202+xcce206+xcce208+xcce210) over (partition BY xcce007) xcce202 FROM xcce_t",
         " WHERE xcceent = '"||g_enterprise||"' AND xcceld = '"||sr.xcckld||"'",
         " AND xcce003 = '"||sr.xcck003||"' AND xcce004 = '"||sr.xcck004||"' AND xcce005 = '"||sr.xcck005||"' AND xcck001= " , p_xcck001 
      PREPARE xcce_tmp1 FROM l_sql
      EXECUTE xcce_tmp1
     
   #获取字段值
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = sr.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET sr.l_xcckcomp = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = sr.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET sr.l_xcckld = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = sr.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET sr.l_xcck003 = '', g_rtn_fields[1] , ''
        
   LET l_xcck005=sr.xcck005
   LET l_xcck004=sr.xcck004
   LET sr.l_key=sr.xcckcomp,"-",sr.xcckld,"-" CLIPPED,l_xcck004,"-" CLIPPED,l_xcck005,"-",sr.xcck003 CLIPPED
   
   INITIALIZE sr.* TO NULL     

#160414-00018#46  2016/05/20 By  earl mod s
#   LET l_sql=" SELECT a_.xcckcomp,a_.xcckld,a_.xcck002,a_.xcck003,a_.xcck004,a_.xcck005,a_.xcck010,a_.xcck011,a_.xcck017,xccktmp.xcck047,xccktmp.l_xcck201,xccktmp.l_xcck201,xccetmp.l_xcce201,xccetmp.l_xcce202 FROM",
#             " (SELECT xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017 FROM xccktmp",
#             " UNION",
#             " SELECT xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017 FROM xccetmp",
#             " ) a_",
#             " LEFT OUTER JOIN xccktmp ON a_.xcckcomp=xccktmp.xcckcomp AND a_.xcckld=xccktmp.xcckld AND a_.xcck004=xccktmp.xcck004 AND a_.xcck005=xccktmp.xcck005 AND a_.xcck010=xccktmp.xcck010",
#             " LEFT OUTER JOIN xccetmp ON a_.xcckcomp=xccetmp.xcckcomp AND a_.xcckld=xccetmp.xcckld AND a_.xcck004=xccetmp.xcck004 AND a_.xcck005=xccetmp.xcck005 AND a_.xcck010=xccetmp.xcck010"

   LET l_sql=" SELECT a_.xcckcomp,a_.xcckld,a_.xcck002,a_.xcck003,a_.xcck004,a_.xcck005,",
             "        a_.xcck010,a_.xcck011,a_.xcck017,xccktmp.xcck047,",
             "        COALESCE(xccktmp.l_xcck201,0),COALESCE(xccktmp.l_xcck202,0),COALESCE(xccetmp.l_xcce201,0),COALESCE(xccetmp.l_xcce202,0),",
             "        (SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = a_.xcck010 AND imaal002 = '",g_dlang,"') l_xcck010_desc,",
             "        (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = a_.xcck010 AND imaal002 = '",g_dlang,"') l_xcck010_desc1,",
             "        (SELECT xcbb006 FROM xcbb_t WHERE xcbbent = ",g_enterprise," AND xcbbcomp = a_.xcckcomp AND xcbb001 = a_.xcck004 AND xcbb002 = a_.xcck005 AND xcbb003 = a_.xcck010 AND xcbb004 = a_.xcck011) xcbb006,",
             "        (SELECT sfaa010 FROM sfaa_t WHERE sfaaent = ",g_enterprise," AND sfaadocno = xccktmp.xcck047) sfaa010,",
             "        (SELECT sfaa003 FROM sfaa_t WHERE sfaaent = ",g_enterprise," AND sfaadocno = xccktmp.xcck047) sfaa003,",
             "        COALESCE((SELECT sfaa042 FROM sfaa_t WHERE sfaaent = ",g_enterprise," AND sfaadocno = xccktmp.xcck047),'N') sfaa042,",
             "        (SELECT imaal003 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = (SELECT sfaa010 FROM sfaa_t WHERE sfaaent = ",g_enterprise," AND sfaadocno = xccktmp.xcck047) AND imaal002='",g_dlang,"') l_sfaa010_desc,",
             "        (SELECT imaal004 FROM imaal_t WHERE imaalent = ",g_enterprise," AND imaal001 = (SELECT sfaa010 FROM sfaa_t WHERE sfaaent = ",g_enterprise," AND sfaadocno = xccktmp.xcck047) AND imaal002='",g_dlang,"') l_sfaa010_desc1,",
             "        'N',' '",
             "   FROM",
             "   (SELECT xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017 FROM xccktmp",
             "     UNION",
             "    SELECT xcckcomp,xcckld,xcck002,xcck003,xcck004,xcck005,xcck010,xcck011,xcck017 FROM xccetmp",
             "   ) a_",
             " LEFT OUTER JOIN xccktmp ON a_.xcckcomp=xccktmp.xcckcomp AND a_.xcckld=xccktmp.xcckld AND a_.xcck004=xccktmp.xcck004 AND a_.xcck005=xccktmp.xcck005 AND a_.xcck010=xccktmp.xcck010",
             " LEFT OUTER JOIN xccetmp ON a_.xcckcomp=xccetmp.xcckcomp AND a_.xcckld=xccetmp.xcckld AND a_.xcck004=xccetmp.xcck004 AND a_.xcck005=xccetmp.xcck005 AND a_.xcck010=xccetmp.xcck010"
   PREPARE tmp1 FROM l_sql
   DECLARE tmp_cs1 CURSOR FOR tmp1
   

#FOREACH tmp_cs1 INTO sr.xcckcomp,sr.xcckld,sr.xcck002,sr.xcck003,sr.xcck004,sr.xcck005,sr.xcck010,sr.xcck011,sr.xcck017,sr.xcck047,sr.l_xcck201,sr.l_xcck202,sr.l_xcce201,sr.l_xcce202
   FOREACH tmp_cs1 INTO sr.xcckcomp,sr.xcckld,sr.xcck002,sr.xcck003,sr.xcck004,sr.xcck005,
                        sr.xcck010,sr.xcck011,sr.xcck017,sr.xcck047,
                        sr.l_xcck201,sr.l_xcck202,sr.l_xcce201,sr.l_xcce202,
                        sr.l_xcck010_desc,
                        sr.l_xcck010_desc1,
                        sr.l_xcbb006,
                        sr.l_sfaa010,
                        sr.l_sfaa003,
                        sr.l_sfaa042,
                        sr.l_sfaa010_desc,
                        sr.l_sfaa010_desc1,
                        sr.l_chk,sr.l_xcck002
       IF sr.l_sfaa003 = '3' THEN CONTINUE FOREACH END IF   #160803-00021#1 add  
#      #获取料号的品名规格
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xcck010
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001 = ? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.l_xcck010_desc = '', g_rtn_fields[1] , '' 
#      LET sr.l_xcck010_desc1 = '', g_rtn_fields[2] , '' 
#            
#      #获取成本阶
#      SELECT xcbb006 INTO sr.l_xcbb006 FROM xcbb_t WHERE xcbbent=g_enterprise and xcbbcomp=sr.xcckcomp and xcbb001=sr.xcck004 and xcbb002=sr.xcck005 and xcbb003=sr.xcck010 and xcbb004=sr.xcck011
      LET sr.l_xb1=sr.l_xcbb006
#            
#      #获取主件编号，工单类型，重工否
#      SELECT sfaa010,sfaa003,sfaa042 INTO sr.l_sfaa010,sr.l_sfaa003,sr.l_sfaa042 FROM sfaa_t
#      WHERE sfaaent=g_enterprise and sfaadocno=sr.xcck047
#      IF cl_null(sr.l_sfaa042) THEN
#         LET sr.l_sfaa042='N'
#      END IF
#            
#      #获取主件编号的品名规格         
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.l_sfaa010
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001 = ? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.l_sfaa010_desc = '', g_rtn_fields[1] , '' 
#      LET sr.l_sfaa010_desc1 = '', g_rtn_fields[2] , ''  
#                  
#      IF cl_null(sr.l_xcck201) THEN LET sr.l_xcck201=0 END IF     
#      IF cl_null(sr.l_xcck202) THEN LET sr.l_xcck202=0 END IF
#      IF cl_null(sr.l_xcce201) THEN LET sr.l_xcce201=0 END IF
#      IF cl_null(sr.l_xcce202) THEN LET sr.l_xcce202=0 END IF
      LET sr.l_qty=sr.l_xcck201-sr.l_xcce201
      LET sr.l_amt=sr.l_xcck202-sr.l_xcce202
#            
#      LET sr.l_chk='N'
#      LET sr.l_xcck002=' '
   
         INSERT INTO axcq340_xccktmp (xcckcomp,l_xcckcomp,xcckld,l_xcckld,xcck004,xcck005,xcck003,l_xcck003,l_chk,xcck002,l_xcck002,xcck010,
            l_xcck010_desc,l_xcck010_desc1,xcck011,xcck017,l_xcbb006,xcck047,l_sfaa010,l_sfaa010_desc,l_sfaa010_desc1,l_xb1,l_sfaa003,l_sfaa042,
            l_xcck201,l_xcck202,l_xcce201,l_xcce202,l_qty,l_amt,l_key)
            VALUES (sr.xcckcomp,sr.l_xcckcomp,sr.xcckld,sr.l_xcckld,sr.xcck004,sr.xcck005,sr.xcck003,sr.l_xcck003,sr.l_chk,sr.xcck002,sr.l_xcck002,sr.xcck010,
            sr.l_xcck010_desc,sr.l_xcck010_desc1,sr.xcck011,sr.xcck017,sr.l_xcbb006,sr.xcck047,sr.l_sfaa010,sr.l_sfaa010_desc,sr.l_sfaa010_desc1,sr.l_xb1,
            sr.l_sfaa003,sr.l_sfaa042,sr.l_xcck201,sr.l_xcck202,sr.l_xcce201,sr.l_xcce202,sr.l_qty,sr.l_amt,sr.l_key)
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "FOREACH:" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err() 
        END IF
      DELETE FROM xccktmp
      DELETE FROM xccetmp
  END FOREACH      
  FREE tmp_cs1
  END FOR
  END IF
END FUNCTION

 
{</section>}
 
