#該程式未解開Section, 採用最新樣板產出!
{<section id="axmi129.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-11-25 17:17:49), PR版次:0011(2016-12-01 15:31:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000565
#+ Filename...: axmi129
#+ Description: 銷售價格表維護作業
#+ Creator....: 01534(2014-02-08 16:51:18)
#+ Modifier...: 08993 -SD/PR- 08993
 
{</section>}
 
{<section id="axmi129.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#151224-00025#2  15/12/25 By catmoon 手動輸入特徵碼同步新增inam_t[料件產品特徵明細檔]
#160318-00005#48  20160328   by pengxin  修正azzi920重复定义之错误讯息
#160318-00025#17 16/04/11 By 07900   校验代码的重复错误讯息修改
#161109-00085#11 2016/11/10  By 08993    整批調整系統星號寫法
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
PRIVATE type type_g_xmaw_m        RECORD
       xmaw001 LIKE xmaw_t.xmaw001, 
   xmaw001_desc LIKE type_t.chr80, 
   xmaw002 LIKE xmaw_t.xmaw002, 
   xmaw002_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xmaw_d        RECORD
       xmawstus LIKE xmaw_t.xmawstus, 
   xmaw011 LIKE xmaw_t.xmaw011, 
   xmaw011_desc LIKE type_t.chr500, 
   xmaw011_desc_desc LIKE type_t.chr500, 
   xmaw012 LIKE xmaw_t.xmaw012, 
   xmaw012_desc LIKE type_t.chr500, 
   xmaw031 LIKE xmaw_t.xmaw031, 
   xmaw031_desc LIKE type_t.chr500, 
   xmaw032 LIKE xmaw_t.xmaw032, 
   xmaw032_desc LIKE type_t.chr500, 
   xmaw013 LIKE xmaw_t.xmaw013, 
   xmaw013_desc LIKE type_t.chr500, 
   xmaw014 LIKE xmaw_t.xmaw014, 
   xmaw015 LIKE xmaw_t.xmaw015, 
   xmaw015_desc LIKE type_t.chr500, 
   xmaw015_desc_desc LIKE type_t.chr500, 
   xmaw016 LIKE xmaw_t.xmaw016, 
   xmaw033 LIKE xmaw_t.xmaw033, 
   xmaw033_desc LIKE type_t.chr500, 
   xmaw034 LIKE xmaw_t.xmaw034, 
   xmaw034_desc LIKE type_t.chr500, 
   xmaw017 LIKE xmaw_t.xmaw017, 
   xmaw018 LIKE xmaw_t.xmaw018, 
   xmaw019 LIKE xmaw_t.xmaw019, 
   xmaw020 LIKE xmaw_t.xmaw020, 
   xmaw021 LIKE xmaw_t.xmaw021, 
   xmaw022 LIKE xmaw_t.xmaw022, 
   xmaw023 LIKE xmaw_t.xmaw023, 
   xmaw100 LIKE xmaw_t.xmaw100
       END RECORD
PRIVATE TYPE type_g_xmaw2_d RECORD
       xmaw011 LIKE xmaw_t.xmaw011, 
   xmaw012 LIKE xmaw_t.xmaw012, 
   xmaw013 LIKE xmaw_t.xmaw013, 
   xmawownid LIKE xmaw_t.xmawownid, 
   xmawownid_desc LIKE type_t.chr500, 
   xmawowndp LIKE xmaw_t.xmawowndp, 
   xmawowndp_desc LIKE type_t.chr500, 
   xmawcrtid LIKE xmaw_t.xmawcrtid, 
   xmawcrtid_desc LIKE type_t.chr500, 
   xmawcrtdp LIKE xmaw_t.xmawcrtdp, 
   xmawcrtdp_desc LIKE type_t.chr500, 
   xmawcrtdt DATETIME YEAR TO SECOND, 
   xmawmodid LIKE xmaw_t.xmawmodid, 
   xmawmodid_desc LIKE type_t.chr500, 
   xmawmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

 type type_g_xmaw_s        RECORD
   xmaw001      LIKE xmaw_t.xmaw001, 
   xmaw001_desc LIKE type_t.chr80, 
   xmaw002      LIKE xmaw_t.xmaw002, 
   xmaw002_desc LIKE type_t.chr80,
   chk1         LIKE type_t.chr1, 
   xmaw019_1    LIKE gzcb_t.gzcb002,
   xmaw019_rate LIKE xmaw_t.xmaw019,
   xmaw019_w    LIKE gzcb_t.gzcb002,
   xmaw019_s    LIKE type_t.num5,
   xmaw019_r    LIKE type_t.num5,
   chk2         LIKE type_t.chr1,
   xmaw020_1    LIKE gzcb_t.gzcb002,
   xmaw020_rate LIKE xmaw_t.xmaw020,
   xmaw020_w    LIKE gzcb_t.gzcb002,
   xmaw020_s    LIKE type_t.num5,
   xmaw020_r    LIKE type_t.num5,
   xmaw021_1    LIKE gzcb_t.gzcb002,
   xmaw021_rate LIKE xmaw_t.xmaw021,
   xmaw021_w    LIKE gzcb_t.gzcb002,
   xmaw021_s    LIKE type_t.num5,
   xmaw021_r    LIKE type_t.num5,
   xmaw022_1    LIKE gzcb_t.gzcb002,
   xmaw022_rate LIKE xmaw_t.xmaw022,
   xmaw022_w    LIKE gzcb_t.gzcb002,
   xmaw022_s    LIKE type_t.num5,
   xmaw022_r    LIKE type_t.num5,
   xmaw023_1    LIKE gzcb_t.gzcb002,
   xmaw023_rate LIKE xmaw_t.xmaw023,
   xmaw023_w    LIKE gzcb_t.gzcb002,
   xmaw023_s    LIKE type_t.num5,
   xmaw023_r    LIKE type_t.num5, 
   xmaw019      LIKE xmaw_t.xmaw019,   
   xmaw020      LIKE xmaw_t.xmaw020,
   xmaw021      LIKE xmaw_t.xmaw021,
   xmaw022      LIKE xmaw_t.xmaw022,
   xmaw023      LIKE xmaw_t.xmaw023
       END RECORD
DEFINE g_xmaw_s            type_g_xmaw_s      
DEFINE   g_s_imaa001       LIKE imaa_t.imaa001
DEFINE   g_e_imaa001       LIKE imaa_t.imaa001 
DEFINE   l_success         LIKE type_t.chr1
DEFINE g_xmaw001         LIKE xmaw_t.xmaw001               #2015/07/16 by stellar add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xmaw_m          type_g_xmaw_m
DEFINE g_xmaw_m_t        type_g_xmaw_m
DEFINE g_xmaw_m_o        type_g_xmaw_m
DEFINE g_xmaw_m_mask_o   type_g_xmaw_m #轉換遮罩前資料
DEFINE g_xmaw_m_mask_n   type_g_xmaw_m #轉換遮罩後資料
 
   DEFINE g_xmaw001_t LIKE xmaw_t.xmaw001
DEFINE g_xmaw002_t LIKE xmaw_t.xmaw002
 
 
DEFINE g_xmaw_d          DYNAMIC ARRAY OF type_g_xmaw_d
DEFINE g_xmaw_d_t        type_g_xmaw_d
DEFINE g_xmaw_d_o        type_g_xmaw_d
DEFINE g_xmaw_d_mask_o   DYNAMIC ARRAY OF type_g_xmaw_d #轉換遮罩前資料
DEFINE g_xmaw_d_mask_n   DYNAMIC ARRAY OF type_g_xmaw_d #轉換遮罩後資料
DEFINE g_xmaw2_d   DYNAMIC ARRAY OF type_g_xmaw2_d
DEFINE g_xmaw2_d_t type_g_xmaw2_d
DEFINE g_xmaw2_d_o type_g_xmaw2_d
DEFINE g_xmaw2_d_mask_o   DYNAMIC ARRAY OF type_g_xmaw2_d #轉換遮罩前資料
DEFINE g_xmaw2_d_mask_n   DYNAMIC ARRAY OF type_g_xmaw2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xmaw001 LIKE xmaw_t.xmaw001,
   b_xmaw001_desc LIKE type_t.chr80,
      b_xmaw002 LIKE xmaw_t.xmaw002,
   b_xmaw002_desc LIKE type_t.chr80
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
GLOBALS
   DEFINE g_notneed_labeltag   BOOLEAN
END GLOBALS
#end add-point
 
{</section>}
 
{<section id="axmi129.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
                              
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
                              
   #end add-point
   LET g_forupd_sql = " SELECT xmaw001,'',xmaw002,''", 
                      " FROM xmaw_t",
                      " WHERE xmawent= ? AND xmaw001=? AND xmaw002=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
                              
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmi129_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xmaw001,t0.xmaw002,t1.ooall004 ,t2.ooail003",
               " FROM xmaw_t t0",
                              " LEFT JOIN ooall_t t1 ON t1.ooallent="||g_enterprise||" AND t1.ooall001='15' AND t1.ooall002=t0.xmaw001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=t0.xmaw002 AND t2.ooail002='"||g_dlang||"' ",
 
               " WHERE t0.xmawent = " ||g_enterprise|| " AND t0.xmaw001 = ? AND t0.xmaw002 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmi129_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                                                            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmi129 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmi129_init()   
 
      #進入選單 Menu (="N")
      CALL axmi129_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                                                            
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmi129
      
   END IF 
   
   CLOSE axmi129_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
                              
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmi129.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmi129_init()
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
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN   
      CALL cl_set_comp_visible("xmaw012,xmaw012_desc",FALSE)
   END IF        

   #2015/07/16 by stellar add ----- (S)
   #取得銷售價格參照表號
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0009') RETURNING g_xmaw001
   #2015/07/16 by stellar add ----- (E)
   #end add-point
   
   CALL axmi129_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axmi129.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axmi129_ui_dialog()
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
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0 
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
                              
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xmaw_m.* TO NULL
         CALL g_xmaw_d.clear()
         CALL g_xmaw2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmi129_init()
      END IF
 
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
         
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axmi129_idx_chk()
               CALL axmi129_fetch('') # reload data
               LET g_detail_idx = 1
               CALL axmi129_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_xmaw_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axmi129_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axmi129_ui_detailshow()
               
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
        
         DISPLAY ARRAY g_xmaw2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axmi129_idx_chk()
               CALL axmi129_ui_detailshow()
               
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
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axmi129_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
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
               CALL axmi129_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axmi129_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
                                                                                                                        
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL axmi129_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axmi129_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi129_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axmi129_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi129_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axmi129_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi129_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axmi129_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi129_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axmi129_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmi129_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_xmaw_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xmaw2_d)
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
          
         ON ACTION mainhidden       #主頁摺疊
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
               NEXT FIELD xmaw011
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
               CALL axmi129_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axmi129_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axmi129_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axmi129_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                                                                                                                                      
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axmi129_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                                                                                                                                      
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmi129_delete()
               #add-point:ON ACTION delete name="menu.delete"
                                                                                                                                                      
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmi129_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                                                                                                                      
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                                                                                                                                                      
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                                                                                                                                                      
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmi129_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                                                                                                                                      
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmi129_query()
               #add-point:ON ACTION query name="menu.query"
                                                                                                                                                      
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION auto_gene
            LET g_action_choice="auto_gene"
            IF cl_auth_chk_act("auto_gene") THEN
               
               #add-point:ON ACTION auto_gene name="menu.auto_gene"
                                                                                                                                                                     CALL axmi129_auto_gene('')
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmi129_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmi129_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmi129_set_pk_array()
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
 
{<section id="axmi129.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axmi129_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
                              
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmi129.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axmi129_browser_fill(ps_page_action)
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
   #2015/07/16 by stellar add ----- (S)
   #限制條件：只能查該據點使用的參照表號
   LET g_wc = g_wc CLIPPED," AND xmaw001 = '",g_xmaw001,"'"
   #2015/07/16 by stellar add ----- (E)
   #end add-point    
 
   LET l_searchcol = "xmaw001,xmaw002"
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
      LET l_sub_sql = " SELECT DISTINCT xmaw001 ",
                      ", xmaw002 ",
 
                      " FROM xmaw_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xmawent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xmaw_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xmaw001 ",
                      ", xmaw002 ",
 
                      " FROM xmaw_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xmawent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xmaw_t")
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
      INITIALIZE g_xmaw_m.* TO NULL
      CALL g_xmaw_d.clear()        
      CALL g_xmaw2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xmaw001,t0.xmaw002 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xmaw001,t0.xmaw002,t1.ooall004 ,t2.ooail003",
                " FROM xmaw_t t0",
                #" ",
                " ",
 
 
 
                               " LEFT JOIN ooall_t t1 ON t1.ooallent="||g_enterprise||" AND t1.ooall001='15' AND t1.ooall002=t0.xmaw001 AND t1.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t2 ON t2.ooailent="||g_enterprise||" AND t2.ooail001=t0.xmaw002 AND t2.ooail002='"||g_dlang||"' ",
 
                " WHERE t0.xmawent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xmaw_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmaw_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xmaw001,g_browser[g_cnt].b_xmaw002,g_browser[g_cnt].b_xmaw001_desc, 
          g_browser[g_cnt].b_xmaw002_desc 
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
      
         #遮罩相關處理
         CALL axmi129_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_xmaw001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xmaw_m.* TO NULL
      CALL g_xmaw_d.clear()
      CALL g_xmaw2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axmi129_fetch('')
   
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
 
{<section id="axmi129.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axmi129_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
                              
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xmaw_m.xmaw001 = g_browser[g_current_idx].b_xmaw001   
   LET g_xmaw_m.xmaw002 = g_browser[g_current_idx].b_xmaw002   
 
   EXECUTE axmi129_master_referesh USING g_xmaw_m.xmaw001,g_xmaw_m.xmaw002 INTO g_xmaw_m.xmaw001,g_xmaw_m.xmaw002, 
       g_xmaw_m.xmaw001_desc,g_xmaw_m.xmaw002_desc
   CALL axmi129_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axmi129_ui_detailshow()
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
 
{<section id="axmi129.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axmi129_ui_browser_refresh()
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
      IF g_browser[l_i].b_xmaw001 = g_xmaw_m.xmaw001 
         AND g_browser[l_i].b_xmaw002 = g_xmaw_m.xmaw002 
 
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
 
{<section id="axmi129.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmi129_construct()
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
   INITIALIZE g_xmaw_m.* TO NULL
   CALL g_xmaw_d.clear()
   CALL g_xmaw2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   #2015/07/16 by stellar add ----- (S)
   LET g_xmaw_m.xmaw001 = g_xmaw001
   DISPLAY BY NAME g_xmaw_m.xmaw001
   CALL axmi129_xmaw001_ref()
   #2015/07/16 by stellar add ----- (E)          
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xmaw002
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
                                                                                                                        
            #end add-point 
            
                 #Ctrlp:construct.c.xmaw002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw002
            #add-point:ON ACTION controlp INFIELD xmaw002 name="construct.c.xmaw002"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#		   	LET g_qryparam.arg1 = 'ALL'
            LET g_qryparam.arg1 = g_site   #add by lixh 20150323
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw002  #顯示到畫面上

            NEXT FIELD xmaw002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw002
            #add-point:BEFORE FIELD xmaw002 name="construct.b.xmaw002"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw002
            
            #add-point:AFTER FIELD xmaw002 name="construct.a.xmaw002"
                                                                                                                        
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xmawstus,xmaw011,xmaw012,xmaw012_desc,xmaw031,xmaw032,xmaw013,xmaw014, 
          xmaw015,xmaw016,xmaw033,xmaw034,xmaw017,xmaw018,xmaw019,xmaw020,xmaw021,xmaw022,xmaw023,xmaw100, 
          xmawownid,xmawowndp,xmawcrtid,xmawcrtdp,xmawcrtdt,xmawmodid,xmawmoddt
           FROM s_detail1[1].xmawstus,s_detail1[1].xmaw011,s_detail1[1].xmaw012,s_detail1[1].xmaw012_desc, 
               s_detail1[1].xmaw031,s_detail1[1].xmaw032,s_detail1[1].xmaw013,s_detail1[1].xmaw014,s_detail1[1].xmaw015, 
               s_detail1[1].xmaw016,s_detail1[1].xmaw033,s_detail1[1].xmaw034,s_detail1[1].xmaw017,s_detail1[1].xmaw018, 
               s_detail1[1].xmaw019,s_detail1[1].xmaw020,s_detail1[1].xmaw021,s_detail1[1].xmaw022,s_detail1[1].xmaw023, 
               s_detail1[1].xmaw100,s_detail2[1].xmawownid,s_detail2[1].xmawowndp,s_detail2[1].xmawcrtid, 
               s_detail2[1].xmawcrtdp,s_detail2[1].xmawcrtdt,s_detail2[1].xmawmodid,s_detail2[1].xmawmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
                                                                                                                        
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmawcrtdt>>----
         AFTER FIELD xmawcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmawmoddt>>----
         AFTER FIELD xmawmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmawcnfdt>>----
         
         #----<<xmawpstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawstus
            #add-point:BEFORE FIELD xmawstus name="construct.b.page1.xmawstus"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmawstus
            
            #add-point:AFTER FIELD xmawstus name="construct.a.page1.xmawstus"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmawstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmawstus
            #add-point:ON ACTION controlp INFIELD xmawstus name="construct.c.page1.xmawstus"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmaw011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw011
            #add-point:ON ACTION controlp INFIELD xmaw011 name="construct.c.page1.xmaw011"
                                                                                                                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "ALL"
            CALL q_imaf001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw011  #顯示到畫面上

            NEXT FIELD xmaw011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw011
            #add-point:BEFORE FIELD xmaw011 name="construct.b.page1.xmaw011"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw011
            
            #add-point:AFTER FIELD xmaw011 name="construct.a.page1.xmaw011"
                                                                                                                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw012
            #add-point:BEFORE FIELD xmaw012 name="construct.b.page1.xmaw012"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw012
            
            #add-point:AFTER FIELD xmaw012 name="construct.a.page1.xmaw012"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw012
            #add-point:ON ACTION controlp INFIELD xmaw012 name="construct.c.page1.xmaw012"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw012_desc
            #add-point:BEFORE FIELD xmaw012_desc name="construct.b.page1.xmaw012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw012_desc
            
            #add-point:AFTER FIELD xmaw012_desc name="construct.a.page1.xmaw012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw012_desc
            #add-point:ON ACTION controlp INFIELD xmaw012_desc name="construct.c.page1.xmaw012_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmaw031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw031
            #add-point:ON ACTION controlp INFIELD xmaw031 name="construct.c.page1.xmaw031"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2003"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw031  #顯示到畫面上
            NEXT FIELD xmaw031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw031
            #add-point:BEFORE FIELD xmaw031 name="construct.b.page1.xmaw031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw031
            
            #add-point:AFTER FIELD xmaw031 name="construct.a.page1.xmaw031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw032
            #add-point:ON ACTION controlp INFIELD xmaw032 name="construct.c.page1.xmaw032"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw032  #顯示到畫面上
            NEXT FIELD xmaw032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw032
            #add-point:BEFORE FIELD xmaw032 name="construct.b.page1.xmaw032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw032
            
            #add-point:AFTER FIELD xmaw032 name="construct.a.page1.xmaw032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw013
            #add-point:ON ACTION controlp INFIELD xmaw013 name="construct.c.page1.xmaw013"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw013  #顯示到畫面上

            NEXT FIELD xmaw013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw013
            #add-point:BEFORE FIELD xmaw013 name="construct.b.page1.xmaw013"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw013
            
            #add-point:AFTER FIELD xmaw013 name="construct.a.page1.xmaw013"
                                                                                                                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw014
            #add-point:BEFORE FIELD xmaw014 name="construct.b.page1.xmaw014"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw014
            
            #add-point:AFTER FIELD xmaw014 name="construct.a.page1.xmaw014"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw014
            #add-point:ON ACTION controlp INFIELD xmaw014 name="construct.c.page1.xmaw014"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmaw015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw015
            #add-point:ON ACTION controlp INFIELD xmaw015 name="construct.c.page1.xmaw015"
                                                                                                                                    #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_xmaw_m.xmaw001
#            LET g_qryparam.arg2 = g_xmaw_m.xmaw002
#            LET g_qryparam.arg3 = g_xmaw_d[l_ac].xmaw013
            CALL q_xmaw015()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw015  #顯示到畫面上

            NEXT FIELD xmaw015                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw015
            #add-point:BEFORE FIELD xmaw015 name="construct.b.page1.xmaw015"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw015
            
            #add-point:AFTER FIELD xmaw015 name="construct.a.page1.xmaw015"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw016
            #add-point:ON ACTION controlp INFIELD xmaw016 name="construct.c.page1.xmaw016"
                                                                                                                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_xmaw_m.xmaw001
#            LET g_qryparam.arg2 = g_xmaw_m.xmaw002
#            LET g_qryparam.arg3 = g_xmaw_d[l_ac].xmaw011
#            LET g_qryparam.arg4 = g_xmaw_d[l_ac].xmaw013            
            CALL q_xmaw016()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw016  #顯示到畫面上

            NEXT FIELD xmaw016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw016
            #add-point:BEFORE FIELD xmaw016 name="construct.b.page1.xmaw016"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw016
            
            #add-point:AFTER FIELD xmaw016 name="construct.a.page1.xmaw016"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw033
            #add-point:ON ACTION controlp INFIELD xmaw033 name="construct.c.page1.xmaw033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmaw033_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw033  #顯示到畫面上
            NEXT FIELD xmaw033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw033
            #add-point:BEFORE FIELD xmaw033 name="construct.b.page1.xmaw033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw033
            
            #add-point:AFTER FIELD xmaw033 name="construct.a.page1.xmaw033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw034
            #add-point:ON ACTION controlp INFIELD xmaw034 name="construct.c.page1.xmaw034"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmaw034_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw034  #顯示到畫面上
            NEXT FIELD xmaw034                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw034
            #add-point:BEFORE FIELD xmaw034 name="construct.b.page1.xmaw034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw034
            
            #add-point:AFTER FIELD xmaw034 name="construct.a.page1.xmaw034"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw017
            #add-point:BEFORE FIELD xmaw017 name="construct.b.page1.xmaw017"
                                                                                                       
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw017
            
            #add-point:AFTER FIELD xmaw017 name="construct.a.page1.xmaw017"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw017
            #add-point:ON ACTION controlp INFIELD xmaw017 name="construct.c.page1.xmaw017"
                                                                                                                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw018
            #add-point:BEFORE FIELD xmaw018 name="construct.b.page1.xmaw018"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw018
            
            #add-point:AFTER FIELD xmaw018 name="construct.a.page1.xmaw018"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw018
            #add-point:ON ACTION controlp INFIELD xmaw018 name="construct.c.page1.xmaw018"
                                                                                                                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw019
            #add-point:BEFORE FIELD xmaw019 name="construct.b.page1.xmaw019"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw019
            
            #add-point:AFTER FIELD xmaw019 name="construct.a.page1.xmaw019"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw019
            #add-point:ON ACTION controlp INFIELD xmaw019 name="construct.c.page1.xmaw019"
                                                                                                                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw020
            #add-point:BEFORE FIELD xmaw020 name="construct.b.page1.xmaw020"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw020
            
            #add-point:AFTER FIELD xmaw020 name="construct.a.page1.xmaw020"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw020
            #add-point:ON ACTION controlp INFIELD xmaw020 name="construct.c.page1.xmaw020"
                                                                                                                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw021
            #add-point:BEFORE FIELD xmaw021 name="construct.b.page1.xmaw021"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw021
            
            #add-point:AFTER FIELD xmaw021 name="construct.a.page1.xmaw021"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw021
            #add-point:ON ACTION controlp INFIELD xmaw021 name="construct.c.page1.xmaw021"
                                                                                                                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw022
            #add-point:BEFORE FIELD xmaw022 name="construct.b.page1.xmaw022"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw022
            
            #add-point:AFTER FIELD xmaw022 name="construct.a.page1.xmaw022"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw022
            #add-point:ON ACTION controlp INFIELD xmaw022 name="construct.c.page1.xmaw022"
                                                                                                                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw023
            #add-point:BEFORE FIELD xmaw023 name="construct.b.page1.xmaw023"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw023
            
            #add-point:AFTER FIELD xmaw023 name="construct.a.page1.xmaw023"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmaw023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw023
            #add-point:ON ACTION controlp INFIELD xmaw023 name="construct.c.page1.xmaw023"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmaw100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw100
            #add-point:ON ACTION controlp INFIELD xmaw100 name="construct.c.page1.xmaw100"
                                                                                                                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_xmbvdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmaw100  #顯示到畫面上

            NEXT FIELD xmaw100                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw100
            #add-point:BEFORE FIELD xmaw100 name="construct.b.page1.xmaw100"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw100
            
            #add-point:AFTER FIELD xmaw100 name="construct.a.page1.xmaw100"
                                                                                                                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmawownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmawownid
            #add-point:ON ACTION controlp INFIELD xmawownid name="construct.c.page2.xmawownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmawownid  #顯示到畫面上
            NEXT FIELD xmawownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawownid
            #add-point:BEFORE FIELD xmawownid name="construct.b.page2.xmawownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmawownid
            
            #add-point:AFTER FIELD xmawownid name="construct.a.page2.xmawownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmawowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmawowndp
            #add-point:ON ACTION controlp INFIELD xmawowndp name="construct.c.page2.xmawowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmawowndp  #顯示到畫面上
            NEXT FIELD xmawowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawowndp
            #add-point:BEFORE FIELD xmawowndp name="construct.b.page2.xmawowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmawowndp
            
            #add-point:AFTER FIELD xmawowndp name="construct.a.page2.xmawowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmawcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmawcrtid
            #add-point:ON ACTION controlp INFIELD xmawcrtid name="construct.c.page2.xmawcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmawcrtid  #顯示到畫面上
            NEXT FIELD xmawcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawcrtid
            #add-point:BEFORE FIELD xmawcrtid name="construct.b.page2.xmawcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmawcrtid
            
            #add-point:AFTER FIELD xmawcrtid name="construct.a.page2.xmawcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmawcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmawcrtdp
            #add-point:ON ACTION controlp INFIELD xmawcrtdp name="construct.c.page2.xmawcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmawcrtdp  #顯示到畫面上
            NEXT FIELD xmawcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawcrtdp
            #add-point:BEFORE FIELD xmawcrtdp name="construct.b.page2.xmawcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmawcrtdp
            
            #add-point:AFTER FIELD xmawcrtdp name="construct.a.page2.xmawcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawcrtdt
            #add-point:BEFORE FIELD xmawcrtdt name="construct.b.page2.xmawcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmawmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmawmodid
            #add-point:ON ACTION controlp INFIELD xmawmodid name="construct.c.page2.xmawmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmawmodid  #顯示到畫面上
            NEXT FIELD xmawmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawmodid
            #add-point:BEFORE FIELD xmawmodid name="construct.b.page2.xmawmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmawmodid
            
            #add-point:AFTER FIELD xmawmodid name="construct.a.page2.xmawmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawmoddt
            #add-point:BEFORE FIELD xmawmoddt name="construct.b.page2.xmawmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
                                                            
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
 
{<section id="axmi129.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axmi129_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
                              
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xmaw001,xmaw002
                          FROM s_browse[1].b_xmaw001,s_browse[1].b_xmaw002
 
         BEFORE CONSTRUCT
               DISPLAY axmi129_filter_parser('xmaw001') TO s_browse[1].b_xmaw001
            DISPLAY axmi129_filter_parser('xmaw002') TO s_browse[1].b_xmaw002
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
                                                            
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
                                                                                          
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
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL axmi129_filter_show('xmaw001')
   CALL axmi129_filter_show('xmaw002')
 
END FUNCTION
 
{</section>}
 
{<section id="axmi129.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axmi129_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
                              
   #end add-point    
   
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
 
{<section id="axmi129.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axmi129_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axmi129_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmi129.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axmi129_query()
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
   CALL g_xmaw_d.clear()
   CALL g_xmaw2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axmi129_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axmi129_browser_fill(g_wc)
      CALL axmi129_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axmi129_browser_fill("F")
   
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
      CALL axmi129_fetch("F") 
   END IF
   
   CALL axmi129_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axmi129_fetch(p_flag)
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
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
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
   
   LET g_xmaw_m.xmaw001 = g_browser[g_current_idx].b_xmaw001
   LET g_xmaw_m.xmaw002 = g_browser[g_current_idx].b_xmaw002
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axmi129_master_referesh USING g_xmaw_m.xmaw001,g_xmaw_m.xmaw002 INTO g_xmaw_m.xmaw001,g_xmaw_m.xmaw002, 
       g_xmaw_m.xmaw001_desc,g_xmaw_m.xmaw002_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xmaw_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xmaw_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xmaw_m_mask_o.* =  g_xmaw_m.*
   CALL axmi129_xmaw_t_mask()
   LET g_xmaw_m_mask_n.* =  g_xmaw_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axmi129_set_act_visible()
   CALL axmi129_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xmaw_m_t.* = g_xmaw_m.*
   LET g_xmaw_m_o.* = g_xmaw_m.*
   
   #重新顯示   
   CALL axmi129_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axmi129.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmi129_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE  l_ooef014   LIKE ooef_t.ooef014                            
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
                              
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xmaw_d.clear()
   CALL g_xmaw2_d.clear()
 
 
   INITIALIZE g_xmaw_m.* TO NULL             #DEFAULT 設定
   LET g_xmaw001_t = NULL
   LET g_xmaw002_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      #add by lixh 20150323
      SELECT ooef014 INTO l_ooef014 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      SELECT DISTINCT ooaj002 INTO g_xmaw_m.xmaw002 FROM ooaj_t
       WHERE ooajent = g_enterprise
         AND ooaj001 = l_ooef014
         AND ooajstus = 'Y'
      CALL s_desc_get_currency_desc(g_xmaw_m.xmaw002) RETURNING g_xmaw_m.xmaw002_desc
      DISPLAY BY NAME g_xmaw_m.xmaw002,g_xmaw_m.xmaw002_desc      
      #add by lixh 20150323

      #2015/07/16 by stellar add ----- (S)
      LET g_xmaw_m.xmaw001 = g_xmaw001
      CALL axmi129_xmaw001_ref()
      #2015/07/16 by stellar add ----- (E) 
      #end add-point 
 
      CALL axmi129_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
                                                            
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xmaw_m.* TO NULL
         INITIALIZE g_xmaw_d TO NULL
         INITIALIZE g_xmaw2_d TO NULL
 
         CALL axmi129_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xmaw_m.* = g_xmaw_m_t.*
         CALL axmi129_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xmaw_d.clear()
      #CALL g_xmaw2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
                                                            
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axmi129_set_act_visible()
   CALL axmi129_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xmaw001_t = g_xmaw_m.xmaw001
   LET g_xmaw002_t = g_xmaw_m.xmaw002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmawent = " ||g_enterprise|| " AND",
                      " xmaw001 = '", g_xmaw_m.xmaw001, "' "
                      ," AND xmaw002 = '", g_xmaw_m.xmaw002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmi129_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axmi129_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axmi129_master_referesh USING g_xmaw_m.xmaw001,g_xmaw_m.xmaw002 INTO g_xmaw_m.xmaw001,g_xmaw_m.xmaw002, 
       g_xmaw_m.xmaw001_desc,g_xmaw_m.xmaw002_desc
   
   #遮罩相關處理
   LET g_xmaw_m_mask_o.* =  g_xmaw_m.*
   CALL axmi129_xmaw_t_mask()
   LET g_xmaw_m_mask_n.* =  g_xmaw_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmaw_m.xmaw001,g_xmaw_m.xmaw001_desc,g_xmaw_m.xmaw002,g_xmaw_m.xmaw002_desc
   
   #功能已完成,通報訊息中心
   CALL axmi129_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmi129_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
                              
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xmaw_m.xmaw001 IS NULL
   OR g_xmaw_m.xmaw002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xmaw001_t = g_xmaw_m.xmaw001
   LET g_xmaw002_t = g_xmaw_m.xmaw002
 
   CALL s_transaction_begin()
   
   OPEN axmi129_cl USING g_enterprise,g_xmaw_m.xmaw001,g_xmaw_m.xmaw002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmi129_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axmi129_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmi129_master_referesh USING g_xmaw_m.xmaw001,g_xmaw_m.xmaw002 INTO g_xmaw_m.xmaw001,g_xmaw_m.xmaw002, 
       g_xmaw_m.xmaw001_desc,g_xmaw_m.xmaw002_desc
   
   #遮罩相關處理
   LET g_xmaw_m_mask_o.* =  g_xmaw_m.*
   CALL axmi129_xmaw_t_mask()
   LET g_xmaw_m_mask_n.* =  g_xmaw_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axmi129_show()
   WHILE TRUE
      LET g_xmaw001_t = g_xmaw_m.xmaw001
      LET g_xmaw002_t = g_xmaw_m.xmaw002
 
 
      #add-point:modify段修改前 name="modify.before_input"
                                                            
      #end add-point
      
      CALL axmi129_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
                                                            
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xmaw_m.* = g_xmaw_m_t.*
         CALL axmi129_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xmaw_m.xmaw001 != g_xmaw001_t 
      OR g_xmaw_m.xmaw002 != g_xmaw002_t 
 
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
   CALL axmi129_set_act_visible()
   CALL axmi129_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xmawent = " ||g_enterprise|| " AND",
                      " xmaw001 = '", g_xmaw_m.xmaw001, "' "
                      ," AND xmaw002 = '", g_xmaw_m.xmaw002, "' "
 
   #填到對應位置
   CALL axmi129_browser_fill("")
 
   CALL axmi129_idx_chk()
 
   CLOSE axmi129_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmi129_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axmi129.input" >}
#+ 資料輸入
PRIVATE FUNCTION axmi129_input(p_cmd)
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
   DEFINE  l_imaa005             LIKE imaa_t.imaa005 
   DEFINE  l_sql                 STRING
   DEFINE  l_xmaw011             LIKE xmaw_t.xmaw011
   DEFINE  l_xmaw012             LIKE xmaw_t.xmaw012
   DEFINE  l_xmaw013             LIKE xmaw_t.xmaw013
   DEFINE  l_xmaw015             LIKE xmaw_t.xmaw015
   DEFINE  l_xmaw016             LIKE xmaw_t.xmaw016
   DEFINE  l_xmaw017             LIKE xmaw_t.xmaw017
   DEFINE  l_xmaw018             LIKE xmaw_t.xmaw018
   DEFINE  l_xmaw019             LIKE xmaw_t.xmaw019
   DEFINE  l_xmaw020             LIKE xmaw_t.xmaw020
   DEFINE  l_xmaw021             LIKE xmaw_t.xmaw021
   DEFINE  l_xmaw022             LIKE xmaw_t.xmaw022
   DEFINE  l_xmaw023             LIKE xmaw_t.xmaw023
   DEFINE  r_success             LIKE type_t.num5
   DEFINE  l_type                LIKE type_t.chr1
   DEFINE  l_xmaw012_t           LIKE xmaw_t.xmaw012
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_msg                 STRING                               #接收回傳的字串
   DEFINE  l_msg1                STRING                               #接收axm-00645 %1 的替代值
   DEFINE  l_msg2                STRING                               #接收axm-00645 %2 的替代值
   DEFINE  l_chk                 LIKE  type_t.num10                   #僅在小部分程式段內的確認
   DEFINE  l_fie_chk             LIKE  type_t.num5                    #讓產品特徵在經過料號欄位後，才會自動跳出元件出來
   DEFINE  l_chk2                LIKE  type_t.num5                    #避免AFTER ROW、AFTER INSERT、ON ROW CHANGE的訊息重複出現
   DEFINE  l_del_chk             LIKE  type_t.num5                    #判斷是否有進入刪除資料 
   DEFINE  l_imaa001             LIKE  type_t.chr100                  #接收抓取到的料件編號值
   DEFINE  l_str                 STRING                               #串料件編號的字串
   DEFINE  l_str_cnt             LIKE  type_t.num10                   #計算接收字串次數
   DEFINE  l_field_num           LIKE  type_t.num5                    #用來記錄傳送的欄位 
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
   DISPLAY BY NAME g_xmaw_m.xmaw001,g_xmaw_m.xmaw001_desc,g_xmaw_m.xmaw002,g_xmaw_m.xmaw002_desc
   
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
   LET g_forupd_sql = "SELECT xmawstus,xmaw011,xmaw012,xmaw031,xmaw032,xmaw013,xmaw014,xmaw015,xmaw016, 
       xmaw033,xmaw034,xmaw017,xmaw018,xmaw019,xmaw020,xmaw021,xmaw022,xmaw023,xmaw100,xmaw011,xmaw012, 
       xmaw013,xmawownid,xmawowndp,xmawcrtid,xmawcrtdp,xmawcrtdt,xmawmodid,xmawmoddt FROM xmaw_t WHERE  
       xmawent=? AND xmaw001=? AND xmaw002=? AND xmaw011=? AND xmaw012=? AND xmaw013=? AND xmaw031=?  
       AND xmaw032=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
                              
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmi129_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axmi129_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
                              
   #end add-point
   CALL axmi129_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   #160224-00016 by whitney add ----- (S)
   IF l_cmd_t = 'r' THEN
      LET g_xmaw_m.xmaw001 = g_xmaw001
      CALL axmi129_xmaw001_ref()
   END IF
   #160224-00016 by whitney add ----- (E) 

   #end add-point
 
   DISPLAY BY NAME g_xmaw_m.xmaw001,g_xmaw_m.xmaw002
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET g_errshow = 1
   LET l_del_chk = FALSE
   LET l_fie_chk = FALSE

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axmi129.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xmaw_m.xmaw001,g_xmaw_m.xmaw002 
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
         AFTER FIELD xmaw001
            
            #add-point:AFTER FIELD xmaw001 name="input.a.xmaw001"
                                                                                                                                    #此段落由子樣板a05產生

            IF  NOT cl_null(g_xmaw_m.xmaw001) AND NOT cl_null(g_xmaw_m.xmaw002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t  OR g_xmaw_m.xmaw002 != g_xmaw002_t )) THEN 
                  LET g_xmaw_m.xmaw001_desc = ''
                  CALL axmi129_xmaw001_ref()               
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmaw_t WHERE "||"xmawent = '" ||g_enterprise|| "' AND "||"xmaw001 = '"||g_xmaw_m.xmaw001 ||"' AND "|| "xmaw002 = '"||g_xmaw_m.xmaw002 ||"'",'std-00004',1) THEN 
                     LET g_xmaw_m.xmaw001 = g_xmaw001_t
                     CALL axmi129_xmaw001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xmaw_m.xmaw001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t OR g_xmaw001_t IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmaw_m.xmaw001
                  #160318-00025#17  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="axm-00187:sub-01302|aooi085|",cl_get_progname("aooi085",g_lang,"2"),"|:EXEPROGaooi085"
                  #160318-00025#17  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooal002_15") THEN
                     LET g_xmaw_m.xmaw001 = g_xmaw001_t
                     CALL axmi129_xmaw001_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axmi129_xmaw001_ref()
         #   CALL axmi129_xmaw015_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw001
            #add-point:BEFORE FIELD xmaw001 name="input.b.xmaw001"
                                                                                                                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw001
            #add-point:ON CHANGE xmaw001 name="input.g.xmaw001"
                                                                                                                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw002
            
            #add-point:AFTER FIELD xmaw002 name="input.a.xmaw002"
                                                                                                                                    #此段落由子樣板a05產生
           
            IF  NOT cl_null(g_xmaw_m.xmaw001) AND NOT cl_null(g_xmaw_m.xmaw002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t  OR g_xmaw_m.xmaw002 != g_xmaw002_t )) THEN 
                  LET g_xmaw_m.xmaw002_desc = ''
                  CALL axmi129_xmaw002_ref() 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmaw_t WHERE "||"xmawent = '" ||g_enterprise|| "' AND "||"xmaw001 = '"||g_xmaw_m.xmaw001 ||"' AND "|| "xmaw002 = '"||g_xmaw_m.xmaw002 ||"'",'std-00004',1) THEN 
                     LET g_xmaw_m.xmaw002 = g_xmaw002_t
                     CALL axmi129_xmaw002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_xmaw_m.xmaw002) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmaw_m.xmaw002 != g_xmaw002_t OR g_xmaw002_t IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = 'ALL'
                  LET g_chkparam.arg1 = g_site   #add by lixh 20150323
                  LET g_chkparam.arg2 = g_xmaw_m.xmaw002
                  #160318-00025#17  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#17  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_xmaw_m.xmaw002 = g_xmaw002_t
                     CALL axmi129_xmaw002_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL axmi129_xmaw002_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw002
            #add-point:BEFORE FIELD xmaw002 name="input.b.xmaw002"
                                                                                                                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw002
            #add-point:ON CHANGE xmaw002 name="input.g.xmaw002"
                                                                                                                        
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmaw001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw001
            #add-point:ON ACTION controlp INFIELD xmaw001 name="input.c.xmaw001"
                                                                                                                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmaw_m.xmaw001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "15" 

            CALL q_ooal002_0()                                #呼叫開窗

            LET g_xmaw_m.xmaw001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmaw_m.xmaw001 TO xmaw001              #顯示到畫面上

            NEXT FIELD xmaw001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xmaw002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw002
            #add-point:ON ACTION controlp INFIELD xmaw002 name="input.c.xmaw002"
                                                                                                                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmaw_m.xmaw002             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = 'ALL'
            LET g_qryparam.arg1 = g_site   #add by lixh 20150323
            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_xmaw_m.xmaw002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmaw_m.xmaw002 TO xmaw002              #顯示到畫面上

            NEXT FIELD xmaw002                          #返回原欄位


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
            DISPLAY BY NAME g_xmaw_m.xmaw001             
                            ,g_xmaw_m.xmaw002   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
                                                                                                                                                      
               #end add-point
            
               #將遮罩欄位還原
               CALL axmi129_xmaw_t_mask_restore('restore_mask_o')
            
               UPDATE xmaw_t SET (xmaw001,xmaw002) = (g_xmaw_m.xmaw001,g_xmaw_m.xmaw002)
                WHERE xmawent = g_enterprise AND xmaw001 = g_xmaw001_t
                  AND xmaw002 = g_xmaw002_t
 
               #add-point:單頭修改中 name="input.head.m_update"
                                                                                                                                                      
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmaw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmaw_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmaw_m.xmaw001
               LET gs_keys_bak[1] = g_xmaw001_t
               LET gs_keys[2] = g_xmaw_m.xmaw002
               LET gs_keys_bak[2] = g_xmaw002_t
               LET gs_keys[3] = g_xmaw_d[g_detail_idx].xmaw011
               LET gs_keys_bak[3] = g_xmaw_d_t.xmaw011
               LET gs_keys[4] = g_xmaw_d[g_detail_idx].xmaw012
               LET gs_keys_bak[4] = g_xmaw_d_t.xmaw012
               LET gs_keys[5] = g_xmaw_d[g_detail_idx].xmaw013
               LET gs_keys_bak[5] = g_xmaw_d_t.xmaw013
               LET gs_keys[6] = g_xmaw_d[g_detail_idx].xmaw031
               LET gs_keys_bak[6] = g_xmaw_d_t.xmaw031
               LET gs_keys[7] = g_xmaw_d[g_detail_idx].xmaw032
               LET gs_keys_bak[7] = g_xmaw_d_t.xmaw032
               CALL axmi129_update_b('xmaw_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                                                                                                                                                                                                                  
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xmaw_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xmaw_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axmi129_xmaw_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               IF NOT (l_cmd_t = 'r' AND p_cmd = 'a') THEN
                  IF cl_ask_confirm('axm-00080') THEN
                     CALL axmi129_auto_gene('a')
                  END IF  
               END IF                  
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axmi129_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xmaw001_t = g_xmaw_m.xmaw001
           LET g_xmaw002_t = g_xmaw_m.xmaw002
 
           
           IF g_xmaw_d.getLength() = 0 THEN
              NEXT FIELD xmaw011
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axmi129.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xmaw_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmaw_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmi129_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            LET l_del_chk = FALSE                                                                                              
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
            CALL axmi129_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axmi129_cl USING g_enterprise,g_xmaw_m.xmaw001,g_xmaw_m.xmaw002                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axmi129_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axmi129_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xmaw_d[l_ac].xmaw011 IS NOT NULL
               AND g_xmaw_d[l_ac].xmaw012 IS NOT NULL
               AND g_xmaw_d[l_ac].xmaw013 IS NOT NULL
               AND g_xmaw_d[l_ac].xmaw031 IS NOT NULL
               AND g_xmaw_d[l_ac].xmaw032 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmaw_d_t.* = g_xmaw_d[l_ac].*  #BACKUP
               LET g_xmaw_d_o.* = g_xmaw_d[l_ac].*  #BACKUP
               CALL axmi129_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axmi129_set_no_entry_b(l_cmd)
               OPEN axmi129_bcl USING g_enterprise,g_xmaw_m.xmaw001,
                                                g_xmaw_m.xmaw002,
 
                                                g_xmaw_d_t.xmaw011
                                                ,g_xmaw_d_t.xmaw012
                                                ,g_xmaw_d_t.xmaw013
                                                ,g_xmaw_d_t.xmaw031
                                                ,g_xmaw_d_t.xmaw032
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axmi129_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmi129_bcl INTO g_xmaw_d[l_ac].xmawstus,g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012, 
                      g_xmaw_d[l_ac].xmaw031,g_xmaw_d[l_ac].xmaw032,g_xmaw_d[l_ac].xmaw013,g_xmaw_d[l_ac].xmaw014, 
                      g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016,g_xmaw_d[l_ac].xmaw033,g_xmaw_d[l_ac].xmaw034, 
                      g_xmaw_d[l_ac].xmaw017,g_xmaw_d[l_ac].xmaw018,g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020, 
                      g_xmaw_d[l_ac].xmaw021,g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023,g_xmaw_d[l_ac].xmaw100, 
                      g_xmaw2_d[l_ac].xmaw011,g_xmaw2_d[l_ac].xmaw012,g_xmaw2_d[l_ac].xmaw013,g_xmaw2_d[l_ac].xmawownid, 
                      g_xmaw2_d[l_ac].xmawowndp,g_xmaw2_d[l_ac].xmawcrtid,g_xmaw2_d[l_ac].xmawcrtdp, 
                      g_xmaw2_d[l_ac].xmawcrtdt,g_xmaw2_d[l_ac].xmawmodid,g_xmaw2_d[l_ac].xmawmoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xmaw_d_t.xmaw011,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmaw_d_mask_o[l_ac].* =  g_xmaw_d[l_ac].*
                  CALL axmi129_xmaw_t_mask()
                  LET g_xmaw_d_mask_n[l_ac].* =  g_xmaw_d[l_ac].*
                  
                  CALL axmi129_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
                                                                                                                                    #實時備份舊值
            LET g_xmaw_d_o.* = g_xmaw_d[l_ac].*  
            CALL axmi129_set_entry_b(l_cmd)           
            CALL axmi129_set_no_required_b()
            CALL axmi129_set_required_b()
            CALL axmi129_set_no_entry_b(l_cmd)             
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xmaw_d_t.* TO NULL
            INITIALIZE g_xmaw_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmaw_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmaw2_d[l_ac].xmawownid = g_user
      LET g_xmaw2_d[l_ac].xmawowndp = g_dept
      LET g_xmaw2_d[l_ac].xmawcrtid = g_user
      LET g_xmaw2_d[l_ac].xmawcrtdp = g_dept 
      LET g_xmaw2_d[l_ac].xmawcrtdt = cl_get_current()
      LET g_xmaw2_d[l_ac].xmawmodid = g_user
      LET g_xmaw2_d[l_ac].xmawmoddt = cl_get_current()
      LET g_xmaw_d[l_ac].xmawstus = ''
 
 
  
            #一般欄位預設值
                  LET g_xmaw_d[l_ac].xmawstus = "Y"
      LET g_xmaw_d[l_ac].xmaw014 = "N"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_xmaw_d_t.* = g_xmaw_d[l_ac].*     #新輸入資料
            LET g_xmaw_d_o.* = g_xmaw_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmi129_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axmi129_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmaw_d[li_reproduce_target].* = g_xmaw_d[li_reproduce].*
               LET g_xmaw2_d[li_reproduce_target].* = g_xmaw2_d[li_reproduce].*
 
               LET g_xmaw_d[g_xmaw_d.getLength()].xmaw011 = NULL
               LET g_xmaw_d[g_xmaw_d.getLength()].xmaw012 = NULL
               LET g_xmaw_d[g_xmaw_d.getLength()].xmaw013 = NULL
               LET g_xmaw_d[g_xmaw_d.getLength()].xmaw031 = NULL
               LET g_xmaw_d[g_xmaw_d.getLength()].xmaw032 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
                                                                                                                                    LET g_xmaw_d_o.* = g_xmaw_d[l_ac].*
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
            SELECT COUNT(1) INTO l_count FROM xmaw_t 
             WHERE xmawent = g_enterprise AND xmaw001 = g_xmaw_m.xmaw001
               AND xmaw002 = g_xmaw_m.xmaw002
 
               AND xmaw011 = g_xmaw_d[l_ac].xmaw011
               AND xmaw012 = g_xmaw_d[l_ac].xmaw012
               AND xmaw013 = g_xmaw_d[l_ac].xmaw013
               AND xmaw031 = g_xmaw_d[l_ac].xmaw031
               AND xmaw032 = g_xmaw_d[l_ac].xmaw032
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               #dorislai-20150626-add----(S)
               #料號、系列、產品分類至少要輸入一項 (如果都沒輸入的話應該報錯 )
               LET l_chk2 = TRUE      #讓錯誤訊息只出現一次的開關    
               IF cl_null(g_xmaw_d_o.xmaw011) AND cl_null(g_xmaw_d_o.xmaw031) AND 
                  cl_null(g_xmaw_d_o.xmaw032) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'axm-00650'     #料件編號、系列、產品分類請擇一輸入 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 

                  LET l_chk2 = FALSE  
                  NEXT FIELD xmaw011 
               END IF 

               #如果有勾選「參考資料否」，則三個參考欄位至少要有輸入一個  
               IF g_xmaw_d_o.xmaw014 = 'Y' THEN 
                  IF cl_null(g_xmaw_d_o.xmaw015) AND cl_null(g_xmaw_d_o.xmaw033) AND 
                     cl_null(g_xmaw_d_o.xmaw034) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'axm-00674' 
                     LET g_errparam.popup  = TRUE  
                     CALL cl_err() 

                     LET l_chk2 = FALSE
                     NEXT FIELD xmaw015  
                  END IF 
               END IF  


               #料號、產品特徵、系列、產品分類是key，所以無值時需給空格 
               IF cl_null(g_xmaw_d[l_ac].xmaw011) THEN     #料號  
                  LET g_xmaw_d[l_ac].xmaw011 = ' ' 
               END IF 
               
               IF cl_null(g_xmaw_d[l_ac].xmaw012) THEN     #產品特徵  
                  LET g_xmaw_d[l_ac].xmaw012 = ' ' 
               END IF 

               IF cl_null(g_xmaw_d[l_ac].xmaw031) THEN     #系列  
                  LET g_xmaw_d[l_ac].xmaw031 = ' '  
               END IF 

               IF cl_null(g_xmaw_d[l_ac].xmaw032) THEN     #產品分類  
                  LET g_xmaw_d[l_ac].xmaw032 = ' ' 
               END IF 
               #dorislai-20150626-end----(E) 
                                                                                                                                       
               #end add-point
               INSERT INTO xmaw_t
                           (xmawent,
                            xmaw001,xmaw002,
                            xmaw011,xmaw012,xmaw013,xmaw031,xmaw032
                            ,xmawstus,xmaw014,xmaw015,xmaw016,xmaw033,xmaw034,xmaw017,xmaw018,xmaw019,xmaw020,xmaw021,xmaw022,xmaw023,xmaw100,xmawownid,xmawowndp,xmawcrtid,xmawcrtdp,xmawcrtdt,xmawmodid,xmawmoddt) 
                     VALUES(g_enterprise,
                            g_xmaw_m.xmaw001,g_xmaw_m.xmaw002,
                            g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012,g_xmaw_d[l_ac].xmaw013,g_xmaw_d[l_ac].xmaw031, 
                                g_xmaw_d[l_ac].xmaw032
                            ,g_xmaw_d[l_ac].xmawstus,g_xmaw_d[l_ac].xmaw014,g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016, 
                                g_xmaw_d[l_ac].xmaw033,g_xmaw_d[l_ac].xmaw034,g_xmaw_d[l_ac].xmaw017, 
                                g_xmaw_d[l_ac].xmaw018,g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020, 
                                g_xmaw_d[l_ac].xmaw021,g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023, 
                                g_xmaw_d[l_ac].xmaw100,g_xmaw2_d[l_ac].xmawownid,g_xmaw2_d[l_ac].xmawowndp, 
                                g_xmaw2_d[l_ac].xmawcrtid,g_xmaw2_d[l_ac].xmawcrtdp,g_xmaw2_d[l_ac].xmawcrtdt, 
                                g_xmaw2_d[l_ac].xmawmodid,g_xmaw2_d[l_ac].xmawmoddt)
               #add-point:單身新增中 name="input.body.m_insert"
                                                                                                                                                      
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xmaw_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmaw_t:",SQLERRMESSAGE 
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
               #dorislai-20150627-modify---(S)
               #判斷資料是否有被其他資料參考，如果欄位有其中一個有輸入的話，再進來檢查就好 
               IF (NOT cl_null(g_xmaw_d[l_ac].xmaw011)) OR (NOT cl_null(g_xmaw_d[l_ac].xmaw031)) OR (NOT cl_null(g_xmaw_d[l_ac].xmaw032)) THEN               
#                  IF NOT axmi129_xmaw011_chk() THEN
#                     CANCEL DELETE
#                  END IF
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
                     IF NOT axmi129_xmaw011_chk() THEN
                        CANCEL DELETE
                     END IF 
                  END IF
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN
                     IF NOT axmi129_xmaw031_chk() THEN
                        CANCEL DELETE
                     END IF
                  END IF
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN   
                     IF NOT axmi129_xmaw032_chk() THEN
                        CANCEL DELETE
                     END IF  
                  END IF
               END IF
               #dorislai-20150627-modify---(E)               
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
               IF axmi129_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xmaw_m.xmaw001
                  LET gs_keys[gs_keys.getLength()+1] = g_xmaw_m.xmaw002
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xmaw_d_t.xmaw011
                  LET gs_keys[gs_keys.getLength()+1] = g_xmaw_d_t.xmaw012
                  LET gs_keys[gs_keys.getLength()+1] = g_xmaw_d_t.xmaw013
                  LET gs_keys[gs_keys.getLength()+1] = g_xmaw_d_t.xmaw031
                  LET gs_keys[gs_keys.getLength()+1] = g_xmaw_d_t.xmaw032
 
 
                  #刪除下層單身
                  IF NOT axmi129_key_delete_b(gs_keys,'xmaw_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axmi129_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axmi129_bcl
               LET l_count = g_xmaw_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
                                                                                                             
            LET l_del_chk = TRUE         #避免刪除後，跑進AFTER ROW、AFTER INSERT、ON ROW CHANGE三欄位皆為空判斷式  
                                                                                               
                                                                                                             
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
                                                                                                                        
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xmaw_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmawstus
            #add-point:BEFORE FIELD xmawstus name="input.b.page1.xmawstus"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmawstus
            
            #add-point:AFTER FIELD xmawstus name="input.a.page1.xmawstus"
                                                                                                                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmawstus
            #add-point:ON CHANGE xmawstus name="input.g.page1.xmawstus"
                                                                                                                                    IF g_xmaw_d[l_ac].xmawstus = 'N' AND l_cmd = 'u' AND g_xmaw_d[l_ac].xmawstus ! = g_xmaw_d_t.xmawstus THEN 
               LET l_cnt = 0
               SELECT COUNT(xmaw001) INTO l_cnt FROM xmaw_t
                WHERE xmawent = g_enterprise
                  AND xmaw001 = g_xmaw_m.xmaw001
                  AND xmaw002 = g_xmaw_m.xmaw002
                  AND xmaw013 = g_xmaw_d[l_ac].xmaw013
                  AND xmaw015 = g_xmaw_d[l_ac].xmaw011
                  AND xmaw016 = g_xmaw_d[l_ac].xmaw012
                  AND xmaw011 != g_xmaw_d[l_ac].xmaw011
                  AND (xmaw012 != g_xmaw_d[l_ac].xmaw012 OR xmaw012 = ' ')                 
                  AND xmawstus = 'Y' 
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00039'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xmaw_d[l_ac].xmawstus = 'Y'                 
               END IF               
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw011
            
            #add-point:AFTER FIELD xmaw011 name="input.a.page1.xmaw011"
                                                                                                                                 #此段落由子樣板a05產生
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) AND g_xmaw_d[l_ac].xmaw011!= g_xmaw_d_o.xmaw011 THEN
               IF NOT axmi129_xmaw011_chk() THEN
                  LET g_xmaw_d[l_ac].xmaw011 = g_xmaw_d_o.xmaw011
                  CALL axmi129_xmaw011_ref()
                  NEXT FIELD xmaw011
               END IF               
            END IF    
            #dorislai- 20150627-modify---(S)           
#            IF  g_xmaw_m.xmaw001 IS NOT NULL AND g_xmaw_m.xmaw002 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw011 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw012 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw013 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw031 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw032 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t OR g_xmaw_m.xmaw002 != g_xmaw002_t OR g_xmaw_d[g_detail_idx].xmaw011 != g_xmaw_d_t.xmaw011 OR g_xmaw_d[g_detail_idx].xmaw012 != g_xmaw_d_t.xmaw012 OR g_xmaw_d[g_detail_idx].xmaw013 != g_xmaw_d_t.xmaw013 OR g_xmaw_d[g_detail_idx].xmaw031 != g_xmaw_d_t.xmaw031 OR g_xmaw_d[g_detail_idx].xmaw032 != g_xmaw_d_t.xmaw032)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmaw_t WHERE "||"xmawent = '" ||g_enterprise|| "' AND "||"xmaw001 = '"||g_xmaw_m.xmaw001 ||"' AND "|| "xmaw002 = '"||g_xmaw_m.xmaw002 ||"' AND "|| "xmaw011 = '"||g_xmaw_d[g_detail_idx].xmaw011 ||"' AND "|| "xmaw012 = '"||g_xmaw_d[g_detail_idx].xmaw012 ||"' AND "|| "xmaw013 = '"||g_xmaw_d[g_detail_idx].xmaw013 ||"' AND "|| "xmaw031 = '"||g_xmaw_d[g_detail_idx].xmaw031 ||"' AND "|| "xmaw032 = '"||g_xmaw_d[g_detail_idx].xmaw032 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
  
            #KEY欄位重複性檢查
            IF l_cmd = 'a' AND g_xmaw_d[l_ac].xmaw011 IS NOT NULL OR ( l_cmd = 'u' AND g_xmaw_d[l_ac].xmaw011 != g_xmaw_d_t.xmaw011 ) THEN
               LET l_field_num = 1
               IF NOT  axmi129_xmaw_rep_chk(l_field_num) THEN
                  LET g_xmaw_d[l_ac].xmaw011 = ''
                  LET g_xmaw_d[l_ac].xmaw012 = ''
                  CALL axmi129_xmaw011_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #dorislai- 20150627-modify---(E)  
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
               
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmaw_d[l_ac].xmaw011
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               LET g_chkparam.err_str[2] ="aim-00121:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在的library
               IF NOT cl_chk_exist("v_imaf001_4") THEN
                  LET g_xmaw_d[l_ac].xmaw011 = g_xmaw_d_o.xmaw011
                  CALL axmi129_xmaw011_ref()
                  NEXT FIELD CURRENT
               END IF
               CALL axmi129_xmaw011_ref()
               CALL axmi129_xmaw015_ref()
               #預設計價單位
               IF cl_null(g_xmaw_d[l_ac].xmaw013) THEN
                  SELECT imaf113 INTO g_xmaw_d[l_ac].xmaw013 FROM imaf_t
                   WHERE imafent = g_enterprise
                     AND imafsite = 'ALL'
                     AND imaf001 = g_xmaw_d[l_ac].xmaw011  
               END IF
               #dorislai-20150629-add----(S)  
               #料號，沒產品特徵時，需清空，避免畫面上殘留舊值               
               SELECT imaa005 INTO l_imaa005 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_xmaw_d[l_ac].xmaw011
               IF cl_null(l_imaa005) THEN     
                  LET g_xmaw_d[l_ac].xmaw012 = ''
                  LET g_xmaw_d[l_ac].xmaw012_desc = ''
               END IF 
               #dorislai-20150629-add----(E)               
#               SELECT imaa005 INTO l_imaa005 FROM imaa_t
#                WHERE imaaent = g_enterprise
#                  AND imaa001 = g_xmaw_d[l_ac].xmaw011
#               IF NOT cl_null(l_imaa005) THEN
#                  CALL cl_set_comp_entry("xmaw012",TRUE)
#               ELSE
#                  CALL cl_set_comp_entry("xmaw012",FALSE) 
#                  LET g_xmaw_d[l_ac].xmaw012 = ' '
#               END IF
#               IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
#                  LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d[l_ac].xmaw011
#                  LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d[l_ac].xmaw012
#                  LET g_xmaw_d[l_ac].xmaw017 = ''
#                  LET g_xmaw_d[l_ac].xmaw018 = ''
#               END IF                  
            END IF   
            #dorislai-20150612-add----(S)
            #判斷料件編號、系列、產品分類，是否僅有一欄位有值
               #料件編號有值時，系列、產品分類是否也有值         
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) AND (cl_null(g_xmaw_d[l_ac].xmaw031)=FALSE  OR cl_null(g_xmaw_d[l_ac].xmaw032)=FALSE) THEN
               LET l_msg = ''   #清空值
               LET l_msg1 = ''
               LET l_msg2 = ''   
#               CALL cl_getmsg('axm-00647',g_lang) RETURNING l_msg1  #%1替換成 料件編號    #160318-00005#48  mark
               CALL cl_getmsg('apm-00939',g_lang) RETURNING l_msg1  #%1替換成 料件編號     #160318-00005#48  add
               
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN
                  CALL cl_getmsg('axm-00648',g_lang) RETURNING l_msg2  #%2替換成 系列
               ELSE
                  CALL cl_getmsg('axm-00649',g_lang) RETURNING l_msg2  #%2替換成 產品分類             
               END IF
               
               #替換axm-00645的字串(料件編號、系列、產品分類擇一輸入，%1已有值，是否將%2清空？)
               CALL cl_getmsg_parm('axm-00645',g_lang,l_msg1 ||'|'|| l_msg2) RETURNING l_msg
               #跳出提醒視窗，確認：保留當下欄位值、清除另一個欄位值  ; 取消：保留另一個欄位值、清除當下欄位值
               IF cl_ask_confirm2('',l_msg) THEN    
                  #判斷系列跟產品分類是否有被當作參考資料使用，有→FALSE(不可清空&同時清空當下欄位);無→TRUE(可清空)
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN 
                     IF axmi129_xmaw031_chk() THEN
                         CALL axmi129_xmaw031_clear()
                     ELSE 
                         LET g_xmaw_d[l_ac].xmaw031 = g_xmaw_d_t.xmaw031
                         CALL axmi129_xmaw011_clear() 
                     END IF                                       
                  END IF
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN
                     IF axmi129_xmaw032_chk() THEN
                        CALL axmi129_xmaw032_clear()
                     ELSE 
                         LET g_xmaw_d[l_ac].xmaw032 = g_xmaw_d_t.xmaw032
                         CALL axmi129_xmaw011_clear() 
                     END IF                                       
                  END IF    
               ELSE 
                  CALL axmi129_xmaw011_clear()
               END IF
                  
            END IF
            
            LET  g_xmaw_d_o.xmaw011 = g_xmaw_d[l_ac].xmaw011
            LET  g_xmaw_d_o.xmaw012 = g_xmaw_d[l_ac].xmaw012
            LET  g_xmaw_d_o.xmaw013 = g_xmaw_d[l_ac].xmaw013  #因料號會自動帶單位出來，需傳回舊值，避免發生參考欄位無法控卡狀況
            LET  l_fie_chk = FALSE
             
               #dorislai-20150626-modify---(S)     
            #dorislai-20150612-add----(E)
            CALL axmi129_xmaw011_ref()
            CALL axmi129_xmaw013_ref()
            CALL axmi129_xmaw015_ref() 
            CALL axmi129_set_entry_b(l_cmd)
            CALL axmi129_set_no_entry_b(l_cmd)            
       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw011
            #add-point:BEFORE FIELD xmaw011 name="input.b.page1.xmaw011"
                                                                                                                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw011
            #add-point:ON CHANGE xmaw011 name="input.g.page1.xmaw011"
                                                                                                                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw012
            
            #add-point:AFTER FIELD xmaw012 name="input.a.page1.xmaw012"
            #此段落由子樣板a05產生
            CALL axmi129_set_entry_b(l_cmd)
            CALL axmi129_set_no_entry_b(l_cmd) 
            
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
               CALL s_feature_description(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012)
                    RETURNING l_success,g_xmaw_d[l_ac].xmaw012_desc  
               #dorislai-20150626-modify---(S)     
                #現在產品特徵是一定要輸入的，所以不用給一個空白               
#               IF g_xmaw_d[l_ac].xmaw012 IS NULL THEN
#                  LET g_xmaw_d[l_ac].xmaw012 = ' '
#               END IF 
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw012) THEN
                  IF NOT s_feature_check(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012) THEN  
                     LET g_xmaw_d[l_ac].xmaw012 = g_xmaw_d_o.xmaw012 
                     CALL s_feature_description(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012)
                          RETURNING l_success,g_xmaw_d[l_ac].xmaw012_desc              
                     NEXT FIELD CURRENT            
                  END IF
                  #151224-00025#2--add--start--
                  IF NOT s_feature_direct_input(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012,g_xmaw_d_o.xmaw012,'',g_site) THEN
                     NEXT FIELD CURRENT
                  END IF 
                  #151224-00025#2--add--end----
               #161116-00041#1-add-s
               ELSE
                  LET g_xmaw_d[l_ac].xmaw012 = ' '
               END IF
               #161116-00041#1-add-e
               #dorislai-20150626-modify---(E)   
            END IF 
            #dorislai-20150626-add---(S)
            #判斷欄位重覆
            IF l_cmd = 'a' AND NOT g_xmaw_d[l_ac].xmaw012 OR ( l_cmd = 'u' AND g_xmaw_d[l_ac].xmaw012 != g_xmaw_d_t.xmaw012 ) THEN
               LET l_field_num = 1   #來判斷要以料號 或系列 或產品分類 組字串
               IF NOT  axmi129_xmaw_rep_chk(l_field_num) THEN
                  LET g_xmaw_d[l_ac].xmaw011 = ''
                  LET g_xmaw_d[l_ac].xmaw012 = ''
                  CALL axmi129_xmaw011_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #dorislai-20150626-add---(E)
#            IF  g_xmaw_m.xmaw001 IS NOT NULL AND g_xmaw_m.xmaw002 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw011 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw012 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw013 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw031 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw032 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t OR g_xmaw_m.xmaw002 != g_xmaw002_t OR g_xmaw_d[g_detail_idx].xmaw011 != g_xmaw_d_t.xmaw011 OR g_xmaw_d[g_detail_idx].xmaw012 != g_xmaw_d_t.xmaw012 OR g_xmaw_d[g_detail_idx].xmaw013 != g_xmaw_d_t.xmaw013 OR g_xmaw_d[g_detail_idx].xmaw031 != g_xmaw_d_t.xmaw031 OR g_xmaw_d[g_detail_idx].xmaw032 != g_xmaw_d_t.xmaw032)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmaw_t WHERE "||"xmawent = '" ||g_enterprise|| "' AND "||"xmaw001 = '"||g_xmaw_m.xmaw001 ||"' AND "|| "xmaw002 = '"||g_xmaw_m.xmaw002 ||"' AND "|| "xmaw011 = '"||g_xmaw_d[g_detail_idx].xmaw011 ||"' AND "|| "xmaw012 = '"||g_xmaw_d[g_detail_idx].xmaw012 ||"' AND "|| "xmaw013 = '"||g_xmaw_d[g_detail_idx].xmaw013 ||"' AND "|| "xmaw031 = '"||g_xmaw_d[g_detail_idx].xmaw031 ||"' AND "|| "xmaw032 = '"||g_xmaw_d[g_detail_idx].xmaw032 ||"'",'std-00004',0) THEN 
#                     LET g_xmaw_d[l_ac].xmaw012 = g_xmaw_d_t.xmaw012
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF            
#            IF  g_xmaw_m.xmaw001 IS NOT NULL AND g_xmaw_m.xmaw002 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw011 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw012 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw013 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t OR g_xmaw_m.xmaw002 != g_xmaw002_t OR g_xmaw_d[g_detail_idx].xmaw011 != g_xmaw_d_t.xmaw011 OR g_xmaw_d[g_detail_idx].xmaw012 != g_xmaw_d_t.xmaw012 OR g_xmaw_d[g_detail_idx].xmaw013 != g_xmaw_d_t.xmaw013)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmaw_t WHERE "||"xmawent = '" ||g_enterprise|| "' AND "||"xmaw001 = '"||g_xmaw_m.xmaw001 ||"' AND "|| "xmaw002 = '"||g_xmaw_m.xmaw002 ||"' AND "|| "xmaw011 = '"||g_xmaw_d[g_detail_idx].xmaw011 ||"' AND "|| "xmaw012 = '"||g_xmaw_d[g_detail_idx].xmaw012 ||"' AND "|| "xmaw013 = '"||g_xmaw_d[g_detail_idx].xmaw013 ||"'",'std-00004',1) THEN 
#                      
#                     CALL s_feature_description(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012)
#                          RETURNING l_success,g_xmaw_d[l_ac].xmaw012_desc                         
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF  
            
            
            IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
               LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d[l_ac].xmaw012               
            END IF        
            LET g_xmaw_d_o.xmaw012 = g_xmaw_d[l_ac].xmaw012            
#            IF g_xmaw_d[l_ac].xmaw012 IS NOT NULL AND g_xmaw_d[l_ac].xmaw012 != g_xmaw_d_t.xmaw012 THEN
#               IF NOT axmi129_xmaw011_chk() THEN
#                  LET g_xmaw_d[l_ac].xmaw012 = g_xmaw_d_t.xmaw012 
#                  CALL s_feature_description(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012)
#                       RETURNING l_success,g_xmaw_d[l_ac].xmaw012_desc                   
#                  NEXT FIELD xmaw012
#               END IF
#            END IF            
#            CALL s_feature_description(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012)
#                 RETURNING l_success,g_xmaw_d[l_ac].xmaw012_desc  


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw012
            #add-point:BEFORE FIELD xmaw012 name="input.b.page1.xmaw012"
            
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN 
               SELECT imaa005 INTO l_imaa005 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_xmaw_d[l_ac].xmaw011
               IF NOT cl_null(l_imaa005) AND l_fie_chk = FALSE  AND cl_null(g_xmaw_d[l_ac].xmaw012) THEN            
                  CALL s_feature_single(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012,'ALL','') 
                     RETURNING l_success,g_xmaw_d[l_ac].xmaw012
                
                  DISPLAY BY NAME g_xmaw_d[l_ac].xmaw012  
            #ELSE
            #   CALL s_feature_description(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012)
            #        RETURNING l_success,g_xmaw_d[l_ac].xmaw012_desc 
            #   DISPLAY g_xmaw_d[l_ac].xmaw012_desc TO xmaw012_desc  
               END IF            
            END IF  
            LET l_fie_chk = TRUE
            CALL axmi129_set_entry_b(l_cmd)
            CALL axmi129_set_no_entry_b(l_cmd)             
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw012
            #add-point:ON CHANGE xmaw012 name="input.g.page1.xmaw012"
                                                                                                                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw012_desc
            #add-point:BEFORE FIELD xmaw012_desc name="input.b.page1.xmaw012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw012_desc
            
            #add-point:AFTER FIELD xmaw012_desc name="input.a.page1.xmaw012_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw012_desc
            #add-point:ON CHANGE xmaw012_desc name="input.g.page1.xmaw012_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw031
            
            #add-point:AFTER FIELD xmaw031 name="input.a.page1.xmaw031"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
#            IF  g_xmaw_m.xmaw001 IS NOT NULL AND g_xmaw_m.xmaw002 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw011 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw012 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw013 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw031 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw032 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t OR g_xmaw_m.xmaw002 != g_xmaw002_t OR g_xmaw_d[g_detail_idx].xmaw011 != g_xmaw_d_t.xmaw011 OR g_xmaw_d[g_detail_idx].xmaw012 != g_xmaw_d_t.xmaw012 OR g_xmaw_d[g_detail_idx].xmaw013 != g_xmaw_d_t.xmaw013 OR g_xmaw_d[g_detail_idx].xmaw031 != g_xmaw_d_t.xmaw031 OR g_xmaw_d[g_detail_idx].xmaw032 != g_xmaw_d_t.xmaw032)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmaw_t WHERE "||"xmawent = '" ||g_enterprise|| "' AND "||"xmaw001 = '"||g_xmaw_m.xmaw001 ||"' AND "|| "xmaw002 = '"||g_xmaw_m.xmaw002 ||"' AND "|| "xmaw011 = '"||g_xmaw_d[g_detail_idx].xmaw011 ||"' AND "|| "xmaw012 = '"||g_xmaw_d[g_detail_idx].xmaw012 ||"' AND "|| "xmaw013 = '"||g_xmaw_d[g_detail_idx].xmaw013 ||"' AND "|| "xmaw031 = '"||g_xmaw_d[g_detail_idx].xmaw031 ||"' AND "|| "xmaw032 = '"||g_xmaw_d[g_detail_idx].xmaw032 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #dorislai-20150611-add---(S)    
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN
               #確認資料無重複
               IF g_xmaw_d_t.xmaw031 != g_xmaw_d[l_ac].xmaw031 THEN
                  LET l_field_num = 2
                  IF NOT  axmi129_xmaw_rep_chk(l_field_num) THEN
                     LET g_xmaw_d[l_ac].xmaw031 = ''
                     CALL axmi129_xmaw031_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #抓取系列說明(含校驗帶值)               
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = '2003'
               LET g_chkparam.arg2 = g_xmaw_d[l_ac].xmaw031
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#17  by 07900 --add-end
               IF NOT cl_chk_exist("v_oocq002_01") THEN  #判斷是否有此 校驗帶值
                  LET g_xmaw_d[l_ac].xmaw031 = g_xmaw_d_o.xmaw031
                  DISPLAY BY NAME g_xmaw_d[l_ac].xmaw031
                  CALL axmi129_xmaw031_ref()
                  NEXT FIELD CURRENT
               END IF
               #判斷料件編號、系列、產品分類，是否僅有一欄位有值
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) AND (cl_null(g_xmaw_d[l_ac].xmaw011)=FALSE  OR cl_null(g_xmaw_d[l_ac].xmaw032)=FALSE) THEN
                  LET l_msg = ''   #清空值
                  LET l_msg1 = ''
                  LET l_msg2 = ''
                  CALL cl_getmsg('axm-00648',g_lang) RETURNING l_msg1  #%1替換成 系列
                  
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
#                     CALL cl_getmsg('axm-00647',g_lang) RETURNING l_msg2  #%2替換成 料件編號    #160318-00005#48  mark
                     CALL cl_getmsg('apm-00939',g_lang) RETURNING l_msg2  #%2替換成 料件編號     #160318-00005#48  add
                  ELSE
                     CALL cl_getmsg('axm-00649',g_lang) RETURNING l_msg2  #%2替換成 產品分類             
                  END IF
                  
                  #替換axm-00645的字串(料件編號、系列、產品分類擇一輸入，%1已有值，是否將%2清空？)
                  CALL cl_getmsg_parm('axm-00645',g_lang,l_msg1 ||'|'|| l_msg2) RETURNING l_msg
                  
                  #跳出提醒視窗，並確認要保留當下欄位值、清除另一個欄位值；或保留另一個欄位值、清除當下欄位值
                  IF cl_ask_confirm2('',l_msg) THEN
                     #判斷料號跟產品分類是否有被當作參考資料使用，有→FALSE(不可清空&同時清空當下欄位);無→TRUE(可清空)
                     IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN 
                        IF axmi129_xmaw011_chk() THEN
                            CALL axmi129_xmaw011_clear()
                        ELSE 
                            LET g_xmaw_d[l_ac].xmaw011 = g_xmaw_d_t.xmaw011
                            CALL axmi129_xmaw031_clear() 
                        END IF                                       
                     END IF
                     IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN
                        IF axmi129_xmaw032_chk() THEN
                            CALL axmi129_xmaw032_clear()
                        ELSE 
                            LET g_xmaw_d[l_ac].xmaw032 = g_xmaw_d_t.xmaw032
                            CALL axmi129_xmaw031_clear() 
                        END IF                                       
                     END IF
                  ELSE 
                     CALL axmi129_xmaw031_clear() 
                  END IF
               END IF
               #判斷是否有被當做參考資料使用
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) AND g_xmaw_d[l_ac].xmaw031 != g_xmaw_d_o.xmaw031 THEN
                  IF NOT axmi129_xmaw031_chk() THEN
                     LET g_xmaw_d[l_ac].xmaw031 = g_xmaw_d_t.xmaw031
                     CALL axmi129_xmaw031_ref()
                     NEXT FIELD CURRENT
                  END IF 
               END IF               
               #確認單位，若當下單位不在當下輸入系列中的單位值，則清空單位
               IF NOT axmi129_xmaw031_xmaw032_chk_unit() THEN
                  LET g_xmaw_d[l_ac].xmaw013 = ''
                  LET g_xmaw_d_o.xmaw013 = g_xmaw_d[l_ac].xmaw013
                  CALL axmi129_xmaw013_ref()
               END IF
            END IF
            
            LET  g_xmaw_d_o.xmaw031 = g_xmaw_d[l_ac].xmaw031
            CALL axmi129_xmaw031_ref()
            CALL axmi129_set_entry_b(l_cmd)
            CALL axmi129_set_no_entry_b(l_cmd) 

            #dorislai-20150611-add---(E) 
            
   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw031
            #add-point:BEFORE FIELD xmaw031 name="input.b.page1.xmaw031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw031
            #add-point:ON CHANGE xmaw031 name="input.g.page1.xmaw031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw032
            
            #add-point:AFTER FIELD xmaw032 name="input.a.page1.xmaw032"
            #應用 a05 樣板自動產生(Version:2)
            #dorislai-20150612-mark---(S) 
            #確認資料無重複
#            IF  g_xmaw_m.xmaw001 IS NOT NULL AND g_xmaw_m.xmaw002 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw011 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw012 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw013 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw031 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw032 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t OR g_xmaw_m.xmaw002 != g_xmaw002_t OR g_xmaw_d[g_detail_idx].xmaw011 != g_xmaw_d_t.xmaw011 OR g_xmaw_d[g_detail_idx].xmaw012 != g_xmaw_d_t.xmaw012 OR g_xmaw_d[g_detail_idx].xmaw013 != g_xmaw_d_t.xmaw013 OR g_xmaw_d[g_detail_idx].xmaw031 != g_xmaw_d_t.xmaw031 OR g_xmaw_d[g_detail_idx].xmaw032 != g_xmaw_d_t.xmaw032)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmaw_t WHERE "||"xmawent = '" ||g_enterprise|| "' AND "||"xmaw001 = '"||g_xmaw_m.xmaw001 ||"' AND "|| "xmaw002 = '"||g_xmaw_m.xmaw002 ||"' AND "|| "xmaw011 = '"||g_xmaw_d[g_detail_idx].xmaw011 ||"' AND "|| "xmaw012 = '"||g_xmaw_d[g_detail_idx].xmaw012 ||"' AND "|| "xmaw013 = '"||g_xmaw_d[g_detail_idx].xmaw013 ||"' AND "|| "xmaw031 = '"||g_xmaw_d[g_detail_idx].xmaw031 ||"' AND "|| "xmaw032 = '"||g_xmaw_d[g_detail_idx].xmaw032 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #dorislai-20150612-mark---(E) 
            #dorislai-20150612-add---(S) 
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN   
               #確認資料無重複
               IF g_xmaw_d_t.xmaw032 != g_xmaw_d[l_ac].xmaw032 THEN
                  LET l_field_num = 3
                  IF NOT  axmi129_xmaw_rep_chk(l_field_num) THEN
                     LET g_xmaw_d[l_ac].xmaw032 = ''
                     CALL axmi129_xmaw032_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
          
               #抓取產品分類說明(含校驗帶值)
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_xmaw_d[l_ac].xmaw032
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
               #160318-00025#17  by 07900 --add-end
               IF NOT cl_chk_exist("v_rtax001") THEN
                  LET g_xmaw_d[l_ac].xmaw032 = g_xmaw_d_o.xmaw032
                  DISPLAY BY NAME g_xmaw_d[l_ac].xmaw032
                  CALL axmi129_xmaw032_ref()
                  NEXT FIELD CURRENT
               END IF
               
               #判斷料件編號、系列、產品分類，是否僅有一欄位有值   
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) AND (cl_null(g_xmaw_d[l_ac].xmaw011)=FALSE  OR cl_null(g_xmaw_d[l_ac].xmaw031)=FALSE) THEN
                  LET l_msg = ''   #清空值
                  LET l_msg1 = ''
                  LET l_msg2 = ''
                  CALL cl_getmsg('axm-00649',g_lang) RETURNING l_msg1  #%1替換成 產品分類
                  
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
#                     CALL cl_getmsg('axm-00647',g_lang) RETURNING l_msg2  #%2替換成 料件編號    #160318-00005#48  mark
                     CALL cl_getmsg('apm-00939',g_lang) RETURNING l_msg2  #%2替換成 料件編號     #160318-00005#48  add
                  ELSE
                     CALL cl_getmsg('axm-00648',g_lang) RETURNING l_msg2  #%2替換成 系列             
                  END IF
                  
                  #替換axm-00645的字串(料件編號、系列、產品分類擇一輸入，%1已有值，是否將%2清空？)
                  CALL cl_getmsg_parm('axm-00645',g_lang,l_msg1 ||'|'|| l_msg2) RETURNING l_msg
                  #跳出提醒視窗，並確認要保留當下欄位值、清除另一個欄位值；或保留另一個欄位值、清除當下欄位值
                  IF cl_ask_confirm2('',l_msg) THEN
                     #判斷料號跟系列是否有被當作參考資料使用，有→FALSE(不可清空&同時清空當下欄位);無→TRUE(可清空)
                     IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN 
                        IF axmi129_xmaw011_chk() THEN
                            CALL axmi129_xmaw011_clear()
                        ELSE 
                            LET g_xmaw_d[l_ac].xmaw011 = g_xmaw_d_t.xmaw011
                            CALL axmi129_xmaw032_clear() 
                        END IF                                       
                     END IF
                     IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN
                        IF axmi129_xmaw031_chk() THEN
                            CALL axmi129_xmaw031_clear()
                        ELSE 
                            LET g_xmaw_d[l_ac].xmaw031 = g_xmaw_d_t.xmaw031
                            CALL axmi129_xmaw032_clear() 
                        END IF                                       
                     END IF    
                  ELSE 
                     CALL axmi129_xmaw032_clear()
                  END IF
               END IF
          
               #判斷是否有被當作參考資料使用
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) AND g_xmaw_d[l_ac].xmaw032 != g_xmaw_d_o.xmaw032 THEN
                  IF NOT axmi129_xmaw032_chk() THEN
                     LET g_xmaw_d[l_ac].xmaw032 = g_xmaw_d_t.xmaw032
                     CALL axmi129_xmaw032_ref()
                     NEXT FIELD CURRENT
                  END IF    
               END IF
               #確認單位，若當下單位不在當下輸入系列中的單位值，則清空單位
               IF NOT axmi129_xmaw031_xmaw032_chk_unit() THEN
                  LET g_xmaw_d[l_ac].xmaw013 = ''
                  LET g_xmaw_d_o.xmaw013 = g_xmaw_d[l_ac].xmaw013
                  CALL axmi129_xmaw013_ref()
               END IF
            END IF
            
            LET  g_xmaw_d_o.xmaw032 = g_xmaw_d[l_ac].xmaw032
            CALL axmi129_xmaw032_ref()
            CALL axmi129_set_entry_b(l_cmd)
            CALL axmi129_set_no_entry_b(l_cmd) 
            
            ##dorislai-20150612-add---(E) 
 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw032
            #add-point:BEFORE FIELD xmaw032 name="input.b.page1.xmaw032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw032
            #add-point:ON CHANGE xmaw032 name="input.g.page1.xmaw032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw013
            
            #add-point:AFTER FIELD xmaw013 name="input.a.page1.xmaw013"
                                                                                                            #此段落由子樣板a05產生
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND g_xmaw_d[l_ac].xmaw013!= g_xmaw_d_t.xmaw013 THEN
               #dorislai-20150612-modify---(S) 
#               IF NOT axmi129_xmaw011_chk() THEN
#                  LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
#                  NEXT FIELD xmaw013
#               END IF
               #如果欄位有其中一個有輸入的話，再進來檢查就好 
               IF (NOT cl_null(g_xmaw_d[l_ac].xmaw011)) OR (NOT cl_null(g_xmaw_d[l_ac].xmaw031)) OR (NOT cl_null(g_xmaw_d[l_ac].xmaw032)) THEN 
                  #若料件編號、系列、產品分類有被其他資料參考，則不能對單位做任何更改，並給回原值
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN           
                     IF NOT axmi129_xmaw011_chk() THEN
                        LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
                        NEXT FIELD xmaw013
                     END IF 
                  END IF
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN
                     IF NOT axmi129_xmaw031_chk() THEN
                        LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
                        NEXT FIELD xmaw013
                     END IF
                  END IF
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN
                     IF NOT axmi129_xmaw032_chk()THEN
                        LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
                        NEXT FIELD xmaw013
                     END IF
                  END IF
               END IF
               #dorislai-20150612-modify---(E)                
            END IF
            #dorislai-20150612-modify---(S)
#            IF  g_xmaw_m.xmaw001 IS NOT NULL AND g_xmaw_m.xmaw002 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw011 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw012 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw013 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw031 IS NOT NULL AND g_xmaw_d[g_detail_idx].xmaw032 IS NOT NULL THEN 
#               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmaw_m.xmaw001 != g_xmaw001_t OR g_xmaw_m.xmaw002 != g_xmaw002_t OR g_xmaw_d[g_detail_idx].xmaw011 != g_xmaw_d_t.xmaw011 OR g_xmaw_d[g_detail_idx].xmaw012 != g_xmaw_d_t.xmaw012 OR g_xmaw_d[g_detail_idx].xmaw013 != g_xmaw_d_t.xmaw013 OR g_xmaw_d[g_detail_idx].xmaw031 != g_xmaw_d_t.xmaw031 OR g_xmaw_d[g_detail_idx].xmaw032 != g_xmaw_d_t.xmaw032)) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmaw_t WHERE "||"xmawent = '" ||g_enterprise|| "' AND "||"xmaw001 = '"||g_xmaw_m.xmaw001 ||"' AND "|| "xmaw002 = '"||g_xmaw_m.xmaw002 ||"' AND "|| "xmaw011 = '"||g_xmaw_d[g_detail_idx].xmaw011 ||"' AND "|| "xmaw012 = '"||g_xmaw_d[g_detail_idx].xmaw012 ||"' AND "|| "xmaw013 = '"||g_xmaw_d[g_detail_idx].xmaw013 ||"' AND "|| "xmaw031 = '"||g_xmaw_d[g_detail_idx].xmaw031 ||"' AND "|| "xmaw032 = '"||g_xmaw_d[g_detail_idx].xmaw032 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF
            #欄位重複性檢查
            IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_xmaw_d[l_ac].xmaw013 != g_xmaw_d_t.xmaw013 ) AND g_xmaw_d[l_ac].xmaw013 IS NOT NULL THEN 
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
                  LET l_field_num = 1
               END IF
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN
                  LET l_field_num = 2
               END IF
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN
                  LET l_field_num = 3
                  
               END IF
               IF NOT  axmi129_xmaw_rep_chk(l_field_num) THEN
                  LET g_xmaw_d[l_ac].xmaw013 = ''
                  CALL axmi129_xmaw013_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL axmi129_xmaw013_ref()            

             #dorislai-20150612-modify---(E)
            
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND (p_cmd = 'a' OR p_cmd = 'u')THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xmaw_d[l_ac].xmaw013
               #160318-00025#17  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#17  by 07900 --add-end
               #呼叫檢查存在的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_o.xmaw013
                  CALL axmi129_xmaw013_ref()
                  NEXT FIELD CURRENT
               END IF
               
               #有料件的話要檢查是否跟他可使用的單位勾稽
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw011)THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmaw_d[l_ac].xmaw011
                  LET g_chkparam.arg2 = g_xmaw_d[l_ac].xmaw013
                  IF NOT cl_chk_exist("v_imao002")THEN
                     LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_o.xmaw013
                     CALL axmi129_xmaw013_ref()
                     NEXT FIELD CURRENT                     
                  END IF
               END IF
               
               
               #dorislai-20150627-add----(S)
               #系列 或 產品分類有值的話，檢查跟他可使用的單位勾稽
               IF (NOT cl_null(g_xmaw_d[l_ac].xmaw031)) OR cl_null(g_xmaw_d[l_ac].xmaw032) = FALSE THEN
                  IF NOT axmi129_xmaw031_xmaw032_chk_unit() THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend=""
                     LET g_errparam.code="aim-00212"
                     LET g_errparam.popup=TRUE
                     #放回舊值
                     LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_o.xmaw013
                     CALL axmi129_xmaw013_ref()
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF           
               END IF
               #dorislai-20150627-add----(E)           
            END IF
            
            
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND (g_xmaw_d[l_ac].xmaw013!= g_xmaw_d_t.xmaw013 OR g_xmaw_d_t.xmaw013 IS NULL) THEN
               #dorislai-20150627-modify----(S)
#               IF NOT axmi129_xmaw015_chk() THEN
#                  LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
#                  NEXT FIELD xmaw013
#               END IF   
               #如果參考欄位有其中一個有輸入的話，再進來檢查就好 
               #如果參考欄位有其中一個有輸入的話，再進來檢查就好 
               IF (NOT cl_null(g_xmaw_d[l_ac].xmaw015)) OR (NOT cl_null(g_xmaw_d[l_ac].xmaw033)) OR (NOT cl_null(g_xmaw_d[l_ac].xmaw034)) THEN  
                  #只需要檢查有輸入值的即可
                  IF NOT axmi129_xmaw015_chk() THEN
                     LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
                     NEXT FIELD xmaw013
                  END IF 
                  IF NOT axmi129_xmaw033_chk() THEN
                     LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
                     NEXT FIELD xmaw013
                  END IF 
                  IF NOT axmi129_xmaw034_chk() THEN
                     LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
                     NEXT FIELD xmaw013
                  END IF                
                  #dorislai-20150627-modify----(E)
               END IF
               LET l_success = 'Y' 
               CALL axmi129_xmaw015_upd_chk(g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016) 
               IF l_success = 'N' THEN   
                  NEXT FIELD xmaw013
               END IF                  
            END IF
            
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND (g_xmaw_d[l_ac].xmaw013!= g_xmaw_d_o.xmaw013 OR g_xmaw_d_o.xmaw013 IS NULL) THEN
               CALL axmi129_xmaw_price()
            END IF
            
            LET g_xmaw_d_o.xmaw013 = g_xmaw_d[l_ac].xmaw013 
            CALL axmi129_xmaw013_ref()   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw013
            #add-point:BEFORE FIELD xmaw013 name="input.b.page1.xmaw013"
                                                                                                                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw013
            #add-point:ON CHANGE xmaw013 name="input.g.page1.xmaw013"
                                                                                                                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw014
            #add-point:BEFORE FIELD xmaw014 name="input.b.page1.xmaw014"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw014
            
            #add-point:AFTER FIELD xmaw014 name="input.a.page1.xmaw014"
             CALL axmi129_set_entry_b(l_cmd)
             CALL axmi129_set_no_required_b()
             CALL axmi129_set_required_b()               
             CALL axmi129_set_no_entry_b(l_cmd)
#            IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
#               CALL cl_set_comp_entry("xmaw015,xmaw016,xmaw017,xmaw018",FALSE)
#               CALL cl_set_comp_entry("xmaw019,xmaw020,xmaw021,xmaw022,xmaw023",TRUE)
#               LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d[l_ac].xmaw011
#               LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d[l_ac].xmaw012
#               LET g_xmaw_d[l_ac].xmaw017 = ''
#               LET g_xmaw_d[l_ac].xmaw018 = ''
#            END IF
            IF g_xmaw_d[l_ac].xmaw014 = 'Y' THEN
#               LET g_xmaw_d[l_ac].xmaw015 = ''
#               LET g_xmaw_d[l_ac].xmaw015_desc = ''
#               LET g_xmaw_d[l_ac].xmaw015_desc1 = ''
#               LET g_xmaw_d[l_ac].xmaw016 = ''
#               IF NOT cl_null(g_xmaw_d[l_ac].xmaw017) OR NOT cl_null(g_xmaw_d[l_ac].xmaw018) THEN                    
#                  LET g_xmaw_d[l_ac].xmaw019 = ''
#                  LET g_xmaw_d[l_ac].xmaw020 = ''
#                  LET g_xmaw_d[l_ac].xmaw021 = ''
#                  LET g_xmaw_d[l_ac].xmaw022 = ''
#                  LET g_xmaw_d[l_ac].xmaw023 = ''
#               END IF   
               IF axmi129_xmaw015_chk() THEN 
                  NEXT FIELD xmaw015
               END IF                  
            END IF  
            LET g_xmaw_d_o.xmaw014 = g_xmaw_d[l_ac].xmaw014
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw014
            #add-point:ON CHANGE xmaw014 name="input.g.page1.xmaw014"
             CALL axmi129_set_entry_b(l_cmd)
             CALL axmi129_set_no_required_b()
             CALL axmi129_set_required_b()              
             CALL axmi129_set_no_entry_b(l_cmd)
            
#            IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
#               CALL cl_set_comp_entry("xmaw015,xmaw016,xmaw017,xmaw018",FALSE)
#               CALL cl_set_comp_entry("xmaw019,xmaw020,xmaw021,xmaw022,xmaw023",TRUE)
#               LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d[l_ac].xmaw011
#               LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d[l_ac].xmaw012
#               LET g_xmaw_d[l_ac].xmaw017 = ''
#               LET g_xmaw_d[l_ac].xmaw018 = ''
#            END IF

             #dorislai-20150629-modify----(S)
#            IF g_xmaw_d[l_ac].xmaw014 = 'Y' THEN
#               LET g_xmaw_d[l_ac].xmaw015 = ''
#               LET g_xmaw_d[l_ac].xmaw015_desc = ''
#               LET g_xmaw_d[l_ac].xmaw015_desc_desc = ''                             
#               LET g_xmaw_d[l_ac].xmaw016 = ''
#               LET g_xmaw_d_o.xmaw015 = ''
#               IF NOT cl_null(g_xmaw_d[l_ac].xmaw017) OR NOT cl_null(g_xmaw_d[l_ac].xmaw018) THEN               
#                  LET g_xmaw_d[l_ac].xmaw019 = ''
#                  LET g_xmaw_d[l_ac].xmaw020 = ''
#                  LET g_xmaw_d[l_ac].xmaw021 = ''
#                  LET g_xmaw_d[l_ac].xmaw022 = ''
#                  LET g_xmaw_d[l_ac].xmaw023 = '' 
#               END IF
                #IF axmi129_xmaw015_chk() THEN 
                #   NEXT FIELD xmaw015
                #END IF 
#            END IF
            
            IF g_xmaw_d[l_ac].xmaw014 = 'Y' THEN
               #若無可用參考資料，取消勾選
               IF NOT axmi129_xmaw014_chk() THEN
                  LET g_xmaw_d[l_ac].xmaw014 = 'N'
                  DISPLAY BY NAME g_xmaw_d[l_ac].xmaw014
                  LET g_xmaw_d_o.xmaw014 = g_xmaw_d[l_ac].xmaw014
                  NEXT FIELD CURRENT
               #有參考資料可用
               ELSE
                  LET g_xmaw_d[l_ac].xmaw015 = ''
                  LET g_xmaw_d[l_ac].xmaw015_desc = ''
                  LET g_xmaw_d[l_ac].xmaw015_desc_desc = ''               
                  LET g_xmaw_d[l_ac].xmaw033 = ''  
                  LET g_xmaw_d[l_ac].xmaw033_desc = ''               
                  LET g_xmaw_d[l_ac].xmaw034 = ''
                  LET g_xmaw_d[l_ac].xmaw034_desc = ''               
                  LET g_xmaw_d[l_ac].xmaw016 = ''
                  LET g_xmaw_d_o.xmaw015 = ''
                  LET g_xmaw_d_o.xmaw033 = ''
                  LET g_xmaw_d_o.xmaw034 = ''
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw017) OR NOT cl_null(g_xmaw_d[l_ac].xmaw018) THEN               
                     LET g_xmaw_d[l_ac].xmaw019 = ''
                     LET g_xmaw_d[l_ac].xmaw020 = ''
                     LET g_xmaw_d[l_ac].xmaw021 = ''
                     LET g_xmaw_d[l_ac].xmaw022 = ''
                     LET g_xmaw_d[l_ac].xmaw023 = '' 
                  END IF
                  LET g_xmaw_d_o.xmaw014 = g_xmaw_d[l_ac].xmaw014
                  #如果參考欄位有其中一個有輸入的話，再進來檢查就好 
                  IF (NOT cl_null(g_xmaw_d[l_ac].xmaw015)) OR  
                     (NOT cl_null(g_xmaw_d[l_ac].xmaw033)) OR  
                     (NOT cl_null(g_xmaw_d[l_ac].xmaw034)) THEN 
                 
                     #只需要檢查有輸入值的即可 
                     IF NOT cl_null(g_xmaw_d[l_ac].xmaw015) THEN 
                        IF axmi129_xmaw015_chk() THEN 
                           NEXT FIELD xmaw015 
                        END IF 
                     END IF 
                 
                     IF NOT cl_null(g_xmaw_d[l_ac].xmaw033) THEN 
                        IF axmi129_xmaw033_chk() THEN 
                           NEXT FIELD xmaw033 
                        END IF 
                     END IF 
                 
                     IF NOT cl_null(g_xmaw_d[l_ac].xmaw034) THEN 
                        IF axmi129_xmaw034_chk() THEN 
                           NEXT FIELD xmaw034 
                        END IF 
                     END IF 
                  END IF 
               END IF  
            END IF  
            LET g_xmaw_d_o.xmaw014 = g_xmaw_d[l_ac].xmaw014
            #dorislai-20150629-modify----(E)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw015
            
            #add-point:AFTER FIELD xmaw015 name="input.a.page1.xmaw015"
            
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw015) THEN
               CALL axmi129_auto_xmaw016()
               IF NOT axmi129_xmaw015_chk() THEN
                  LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d_o.xmaw015
                  IF g_xmaw_d[l_ac].xmaw015 = g_xmaw_d[l_ac].xmaw011 THEN
                     LET g_xmaw_d[l_ac].xmaw015 = ''
                     LET g_xmaw_d[l_ac].xmaw016 = ''
                     LET g_xmaw_d[l_ac].xmaw015_desc = ''
                     LET g_xmaw_d[l_ac].xmaw015_desc_desc = ''
                     CALL axmi129_xmaw015_ref()
                  END IF
                  NEXT FIELD xmaw015
               END IF
#               LET l_success = 'Y' 
#               CALL axmi129_xmaw015_upd_chk(g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016) 
#               IF l_success = 'N' THEN 
#                  LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d_t.xmaw015
#                  IF g_xmaw_d[l_ac].xmaw015 = g_xmaw_d[l_ac].xmaw011 THEN
#                     LET g_xmaw_d[l_ac].xmaw015 = ''
#                     LET g_xmaw_d[l_ac].xmaw016 = ''
#                     LET g_xmaw_d[l_ac].xmaw015_desc = ''
#                     LET g_xmaw_d[l_ac].xmaw015_desc1 = ''
#                  END IF               
#                  NEXT FIELD xmaw015
#               END IF                  
               CALL axmi129_xmaw015_ref()
            END IF 
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw015) AND (g_xmaw_d[l_ac].xmaw015!= g_xmaw_d_o.xmaw015 OR g_xmaw_d_o.xmaw015 IS NULL) THEN
               CALL axmi129_xmaw_price()
            END IF
              
            LET l_success = 'Y' 
            CALL axmi129_xmaw015_upd_chk(g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016) 
            IF l_success = 'N' THEN 
               LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d_t.xmaw015
               IF g_xmaw_d[l_ac].xmaw015 = g_xmaw_d[l_ac].xmaw011 THEN
                  LET g_xmaw_d[l_ac].xmaw015 = ''
                  LET g_xmaw_d[l_ac].xmaw016 = ''
                  LET g_xmaw_d[l_ac].xmaw015_desc = ''
                  LET g_xmaw_d[l_ac].xmaw015_desc_desc = ''
               END IF               
               NEXT FIELD xmaw015
            END IF  
            IF cl_null(g_xmaw_d[l_ac].xmaw015) THEN LET g_xmaw_d[l_ac].xmaw016 = '' END IF            
            LET g_xmaw_d_o.xmaw015 = g_xmaw_d[l_ac].xmaw015
            
            
            #dorislai-20150612-add----(S)
            #判斷參考料件編號、參考系列、參考產品分類，是否僅有一欄位有值
               #參考料件編號有值時，參考系列、參考產品分類是否也有值         
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw015) AND (cl_null(g_xmaw_d[l_ac].xmaw033)=FALSE  OR cl_null(g_xmaw_d[l_ac].xmaw034)=FALSE) THEN
               LET l_msg = ''   #清空值
               LET l_msg1 = ''
               LET l_msg2 = ''   
               CALL cl_getmsg('axm-00671',g_lang) RETURNING l_msg1  #%1替換成 參考料件編號
               
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw033) THEN
                  CALL cl_getmsg('axm-00672',g_lang) RETURNING l_msg2  #%2替換成 參考系列
               ELSE
                  CALL cl_getmsg('axm-00673',g_lang) RETURNING l_msg2  #%2替換成 參考產品分類             
               END IF
               
               #替換axm-00670的字串(參考料件編號、參考系列、參考產品分類擇一輸入，%1已有值，是否將%2清空？)
               CALL cl_getmsg_parm('axm-00670',g_lang,l_msg1 ||'|'|| l_msg2) RETURNING l_msg
               #跳出提醒視窗，確認：保留當下欄位值、清除另一個欄位值  ; 取消：保留另一個欄位值、清除當下欄位值
               IF cl_ask_confirm2('',l_msg) THEN
                  CALL axmi129_xmaw033_clear()
                  CALL axmi129_xmaw034_clear()
               ELSE 
                  CALL axmi129_xmaw015_clear()
               END IF
                  
            END IF
             #dorislai-20150612-add----(E)
            LET  g_xmaw_d_o.xmaw015 = g_xmaw_d[l_ac].xmaw015
            LET  g_xmaw_d_o.xmaw016 = g_xmaw_d[l_ac].xmaw016
            CALL axmi129_xmaw015_ref()
            CALL axmi129_set_entry_b(l_cmd)
            CALL axmi129_set_no_entry_b(l_cmd)   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw015
            #add-point:BEFORE FIELD xmaw015 name="input.b.page1.xmaw015"
                                                                                                                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw015
            #add-point:ON CHANGE xmaw015 name="input.g.page1.xmaw015"
                                                                                                                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw016
            #add-point:BEFORE FIELD xmaw016 name="input.b.page1.xmaw016"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw016
            
            #add-point:AFTER FIELD xmaw016 name="input.a.page1.xmaw016"
            
            IF g_xmaw_d[l_ac].xmaw016 IS NULL THEN 
               LET g_xmaw_d[l_ac].xmaw016 = ' '
            END IF 
            IF g_xmaw_d[l_ac].xmaw016 IS NOT NULL THEN
               IF NOT axmi129_xmaw015_chk() THEN
                  LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d_o.xmaw016
                  NEXT FIELD xmaw016
               END IF                  
            END IF 
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw016) AND (g_xmaw_d[l_ac].xmaw016!= g_xmaw_d_o.xmaw016 OR g_xmaw_d_o.xmaw016 IS NULL) THEN
               CALL axmi129_xmaw_price()
            END IF         
            LET l_success = 'Y' 
            CALL axmi129_xmaw015_upd_chk(g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016) 
            IF l_success = 'N' THEN   
               LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d_o.xmaw016
               NEXT FIELD xmaw016
            END IF            
            LET g_xmaw_d_o.xmaw016 = g_xmaw_d[l_ac].xmaw016
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw016
            #add-point:ON CHANGE xmaw016 name="input.g.page1.xmaw016"
                                                                                                                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw033
            
            #add-point:AFTER FIELD xmaw033 name="input.a.page1.xmaw033"
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw033) THEN
               #dorislai-20150610-add----(S) 
               #參考系列校驗帶值
               IF NOT axmi129_xmaw033_chk() THEN
                  LET g_xmaw_d[l_ac].xmaw033=g_xmaw_d_o.xmaw033
                  CALL axmi129_xmaw033_ref()
                  NEXT FIELD CURRENT 
               END IF

               #判斷參考料件編號、參考系列、參考產品分類，是否僅有一欄位有值
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw033) AND (cl_null(g_xmaw_d[l_ac].xmaw015)=FALSE  OR cl_null(g_xmaw_d[l_ac].xmaw034)=FALSE) THEN
                  LET l_msg = ''   #清空值
                  LET l_msg1 = ''
                  LET l_msg2 = ''
                  CALL cl_getmsg('axm-00672',g_lang) RETURNING l_msg1  #%1替換成 參考系列
                  
                  IF NOT cl_null(g_xmaw_d[l_ac].xmaw015) THEN
                     CALL cl_getmsg('axm-00671',g_lang) RETURNING l_msg2  #%2替換成 參考料件編號
                  ELSE
                     CALL cl_getmsg('axm-00673',g_lang) RETURNING l_msg2  #%2替換成 參考產品分類             
                  END IF
                  
                  #替換axm-00670的字串(參考料件編號、參考系列、參考產品分類擇一輸入，%1已有值，是否將%2清空？)
                  CALL cl_getmsg_parm('axm-00670',g_lang,l_msg1 ||'|'|| l_msg2) RETURNING l_msg
                  
                  #跳出提醒視窗，並確認要保留當下欄位值、清除另一個欄位值；或保留另一個欄位值、清除當下欄位值
                  IF cl_ask_confirm2('',l_msg) THEN            
                     CALL axmi129_xmaw015_clear()
                     CALL axmi129_xmaw034_clear()
                  ELSE 
                     CALL axmi129_xmaw033_clear() 
                  END IF
               END IF               
              
            END IF
            #判斷參考系列是否會形成迴圈
            IF NOT axmi129_xmaw033_upd_chk() THEN
               CALL axmi129_xmaw033_ref()
               NEXT FIELD xmaw033
            END IF
            LET  g_xmaw_d_o.xmaw033 = g_xmaw_d[l_ac].xmaw033     
            CALL axmi129_xmaw_price()
            CALL axmi129_xmaw033_ref()
            
            ##dorislai-20150610-add----(E) 




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw033
            #add-point:BEFORE FIELD xmaw033 name="input.b.page1.xmaw033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw033
            #add-point:ON CHANGE xmaw033 name="input.g.page1.xmaw033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw034
            
            #add-point:AFTER FIELD xmaw034 name="input.a.page1.xmaw034"
            #dorislai-20150612-add----(S) 
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw034) THEN
              #參考產品分類校驗帶值
              IF NOT axmi129_xmaw034_chk() THEN
                 LET g_xmaw_d[l_ac].xmaw034 = g_xmaw_d_o.xmaw034
                 CALL axmi129_xmaw034_ref()
                 NEXT FIELD CURRENT
              END IF
 
              #判斷參考料件編號、參考系列、參考產品分類，是否僅有一欄位有值                
              IF NOT cl_null(g_xmaw_d[l_ac].xmaw034) AND (cl_null(g_xmaw_d[l_ac].xmaw015)=FALSE  OR cl_null(g_xmaw_d[l_ac].xmaw033)=FALSE) THEN
                 LET l_msg = ''   #清空值
                 LET l_msg1 = ''
                 LET l_msg2 = ''
                 CALL cl_getmsg('axm-00673',g_lang) RETURNING l_msg1  #%1替換成 參考產品分類
                 
                 IF NOT cl_null(g_xmaw_d[l_ac].xmaw015) THEN
                    CALL cl_getmsg('axm-00671',g_lang) RETURNING l_msg2  #%2替換成 參考料件編號
                 ELSE
                    CALL cl_getmsg('axm-00672',g_lang) RETURNING l_msg2  #%2替換成 參考系列             
                 END IF
                 
                 #替換axm-00670的字串(參考料件編號、參考系列、參考產品分類擇一輸入，%1已有值，是否將%2清空？)
                 CALL cl_getmsg_parm('axm-00670',g_lang,l_msg1 ||'|'|| l_msg2) RETURNING l_msg
                 #跳出提醒視窗，並確認要保留當下欄位值、清除另一個欄位值；或保留另一個欄位值、清除當下欄位值
                 IF cl_ask_confirm2('',l_msg) THEN
                    CALL axmi129_xmaw015_clear()
                    CALL axmi129_xmaw033_clear()
                 ELSE 
                    CALL axmi129_xmaw034_clear()
                 END IF
              END IF
   
            END IF
            #判斷參考產品分類是否會形成迴圈
            IF NOT axmi129_xmaw034_upd_chk() THEN
               CALL axmi129_xmaw034_ref()
               NEXT FIELD xmaw034
            END IF
            LET  g_xmaw_d_o.xmaw034 = g_xmaw_d[l_ac].xmaw034
            CALL axmi129_xmaw_price()
            CALL axmi129_xmaw034_ref()
            #dorislai-20150612-add----(E) 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw034
            #add-point:BEFORE FIELD xmaw034 name="input.b.page1.xmaw034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw034
            #add-point:ON CHANGE xmaw034 name="input.g.page1.xmaw034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmaw_d[l_ac].xmaw017,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw017
            END IF 
 
 
 
            #add-point:AFTER FIELD xmaw017 name="input.a.page1.xmaw017"
                                                                                                                                    IF g_xmaw_d[l_ac].xmaw018 <> 0 AND g_xmaw_d[l_ac].xmaw017 <>0 THEN
            LET g_xmaw_d[l_ac].xmaw018 = ''   #金額和百分比只能選擇一個
               DISPLAY BY NAME g_xmaw_d[l_ac].xmaw018
            END IF
            
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw017) THEN            
               #重新計算金額
               CALL axmi129_xmaw_price()
            ELSE
               NEXT FIELD xmaw018            
            END IF 
            LET g_xmaw_d_o.xmaw017 = g_xmaw_d[l_ac].xmaw017 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw017
            #add-point:BEFORE FIELD xmaw017 name="input.b.page1.xmaw017"
            #dorislai-20150627-add----(S) 
            #換行時，無勾選參考資料，不能輸入加金額的欄位，所以要幫它只指定跳去其他欄位
            IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
               NEXT FIELD xmaw019
            END IF
            #dorislai-20150627-add----(E) 
            CALL axmi129_set_entry_b(l_cmd)  
            CALL axmi129_set_no_required_b()        
            CALL axmi129_set_no_entry_b(l_cmd)                                                                                                                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw017
            #add-point:ON CHANGE xmaw017 name="input.g.page1.xmaw017"
            CALL axmi129_set_entry_b(l_cmd)   
            CALL axmi129_set_no_required_b()            
            CALL axmi129_set_no_entry_b(l_cmd)                                                                                                             
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmaw_d[l_ac].xmaw018,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw018
            END IF 
 
 
 
            #add-point:AFTER FIELD xmaw018 name="input.a.page1.xmaw018"
            IF g_xmaw_d[l_ac].xmaw017 <> 0 AND g_xmaw_d[l_ac].xmaw018 <> 0 THEN
               LET g_xmaw_d[l_ac].xmaw017 = ''   #金額和百分比只能選擇一個
               DISPLAY BY NAME g_xmaw_d[l_ac].xmaw017
            END IF
            
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw018) THEN 
               #重新計算金額
               CALL axmi129_xmaw_price()     
            ELSE
               NEXT FIELD xmaw017            
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw018
            #add-point:BEFORE FIELD xmaw018 name="input.b.page1.xmaw018"
            #dorislai-20150627-add----(S) 
            #換行時，無勾選參考資料，不能輸入加百分比的欄位，所以要幫它只指定跳去其他欄位
            IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
               NEXT FIELD xmaw019
            END IF
            #dorislai-20150627-add----(E) 
            CALL axmi129_set_entry_b(l_cmd)  
            CALL axmi129_set_no_required_b()             
            CALL axmi129_set_no_entry_b(l_cmd)                                                                                                              
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw018
            #add-point:ON CHANGE xmaw018 name="input.g.page1.xmaw018"
            CALL axmi129_set_entry_b(l_cmd) 
            CALL axmi129_set_no_required_b()             
            CALL axmi129_set_no_entry_b(l_cmd)                                                                                                             
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmaw_d[l_ac].xmaw019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw019
            END IF 
 
 
 
            #add-point:AFTER FIELD xmaw019 name="input.a.page1.xmaw019"
                                                                                                                                    IF NOT cl_null(g_xmaw_d[l_ac].xmaw019) AND (g_xmaw_d[l_ac].xmaw019 != g_xmaw_d_o.xmaw019 OR g_xmaw_d_o.xmaw019 IS NULL) THEN             
               CALL axmi129_over_xmaw019() RETURNING r_success,l_type
               IF NOT r_success THEN 
                  IF l_type = '0' THEN
                     NEXT FIELD xmaw020 
                  END IF 
                  IF l_type = '1' THEN
                     NEXT FIELD xmaw021 
                  END IF  
                  IF l_type = '2' THEN
                     NEXT FIELD xmaw022 
                  END IF   
                  IF l_type = '3' THEN
                     NEXT FIELD xmaw023
                  END IF                   
               END IF                
            END IF 
            LET g_xmaw_d_o.xmaw019 = g_xmaw_d[l_ac].xmaw019
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw019
            #add-point:BEFORE FIELD xmaw019 name="input.b.page1.xmaw019"
                                                                                                                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw019
            #add-point:ON CHANGE xmaw019 name="input.g.page1.xmaw019"
                                                                                                                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw020
            #add-point:BEFORE FIELD xmaw020 name="input.b.page1.xmaw020"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw020
            
            #add-point:AFTER FIELD xmaw020 name="input.a.page1.xmaw020"
                                                                                                                                    IF NOT cl_null(g_xmaw_d[l_ac].xmaw020) THEN 
               CALL axmi129_over_xmaw019() RETURNING r_success,l_type
               IF NOT r_success THEN 
                  IF l_type = '0' THEN
                     NEXT FIELD xmaw020 
                  END IF 
                  IF l_type = '1' THEN
                     NEXT FIELD xmaw021 
                  END IF  
                  IF l_type = '2' THEN
                     NEXT FIELD xmaw022 
                  END IF   
                  IF l_type = '3' THEN
                     NEXT FIELD xmaw023
                  END IF                   
               END IF                   
            END IF 
            LET g_xmaw_d_o.xmaw020 = g_xmaw_d[l_ac].xmaw020
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw020
            #add-point:ON CHANGE xmaw020 name="input.g.page1.xmaw020"
                                                                                                                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw021
            #add-point:BEFORE FIELD xmaw021 name="input.b.page1.xmaw021"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw021
            
            #add-point:AFTER FIELD xmaw021 name="input.a.page1.xmaw021"
                                                                                                                                    IF NOT cl_null(g_xmaw_d[l_ac].xmaw021) THEN 
               CALL axmi129_over_xmaw019() RETURNING r_success,l_type
               IF NOT r_success THEN 
                  IF l_type = '0' THEN
                     NEXT FIELD xmaw020 
                  END IF 
                  IF l_type = '1' THEN
                     NEXT FIELD xmaw021 
                  END IF  
                  IF l_type = '2' THEN
                     NEXT FIELD xmaw022 
                  END IF   
                  IF l_type = '3' THEN
                     NEXT FIELD xmaw023
                  END IF                   
               END IF  
            END IF
            LET g_xmaw_d_o.xmaw021 = g_xmaw_d[l_ac].xmaw021
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw021
            #add-point:ON CHANGE xmaw021 name="input.g.page1.xmaw021"
                                                                                                                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw022
            #add-point:BEFORE FIELD xmaw022 name="input.b.page1.xmaw022"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw022
            
            #add-point:AFTER FIELD xmaw022 name="input.a.page1.xmaw022"
                                                                                                                                    IF NOT cl_null(g_xmaw_d[l_ac].xmaw022) THEN 
               CALL axmi129_over_xmaw019() RETURNING r_success,l_type
               IF NOT r_success THEN 
                  IF l_type = '0' THEN
                     NEXT FIELD xmaw020 
                  END IF 
                  IF l_type = '1' THEN
                     NEXT FIELD xmaw021 
                  END IF  
                  IF l_type = '2' THEN
                     NEXT FIELD xmaw022 
                  END IF   
                  IF l_type = '3' THEN
                     NEXT FIELD xmaw023
                  END IF                   
               END IF    
            END IF
            LET g_xmaw_d_o.xmaw022 = g_xmaw_d[l_ac].xmaw022
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw022
            #add-point:ON CHANGE xmaw022 name="input.g.page1.xmaw022"
                                                                                                                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw023
            #add-point:BEFORE FIELD xmaw023 name="input.b.page1.xmaw023"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw023
            
            #add-point:AFTER FIELD xmaw023 name="input.a.page1.xmaw023"
                                                                                                                                    IF NOT cl_null(g_xmaw_d[l_ac].xmaw023) THEN 
               CALL axmi129_over_xmaw019() RETURNING r_success,l_type
               IF NOT r_success THEN 
                  IF l_type = '0' THEN
                     NEXT FIELD xmaw020 
                  END IF 
                  IF l_type = '1' THEN
                     NEXT FIELD xmaw021 
                  END IF  
                  IF l_type = '2' THEN
                     NEXT FIELD xmaw022 
                  END IF   
                  IF l_type = '3' THEN
                     NEXT FIELD xmaw023
                  END IF                   
               END IF 
            END IF 
            LET g_xmaw_d_o.xmaw023 = g_xmaw_d[l_ac].xmaw023
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw023
            #add-point:ON CHANGE xmaw023 name="input.g.page1.xmaw023"
                                                                                                                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmaw100
            #add-point:BEFORE FIELD xmaw100 name="input.b.page1.xmaw100"
                                                                                                                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmaw100
            
            #add-point:AFTER FIELD xmaw100 name="input.a.page1.xmaw100"
                                                                                                                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmaw100
            #add-point:ON CHANGE xmaw100 name="input.g.page1.xmaw100"
                                                                                                                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmawstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmawstus
            #add-point:ON ACTION controlp INFIELD xmawstus name="input.c.page1.xmawstus"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw011
            #add-point:ON ACTION controlp INFIELD xmaw011 name="input.c.page1.xmaw011"
                                                                                                                        #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "ALL"
            LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw011             #給予default值
            #給予arg
            CALL q_imaf001_8()                                #呼叫開窗
            LET g_xmaw_d[l_ac].xmaw011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmaw_d[l_ac].xmaw011 TO xmaw011              #顯示到畫面上
            CALL axmi129_xmaw011_ref()
            
            NEXT FIELD xmaw011                          #返回原欄位
            


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw012
            #add-point:ON ACTION controlp INFIELD xmaw012 name="input.c.page1.xmaw012"
            CALL axmi129_set_entry_b(l_cmd)
            CALL axmi129_set_no_entry_b(l_cmd) 
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
               LET l_xmaw012_t = g_xmaw_d[l_ac].xmaw012                                                                                                                    
               CALL s_feature_single(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012,'ALL','') 
                  RETURNING l_success,g_xmaw_d[l_ac].xmaw012               
               IF cl_null(g_xmaw_d[l_ac].xmaw012) THEN 
                  LET g_xmaw_d[l_ac].xmaw012 = l_xmaw012_t
               END IF   
               DISPLAY g_xmaw_d[l_ac].xmaw012 TO xmaw012
            END IF               
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw012_desc
            #add-point:ON ACTION controlp INFIELD xmaw012_desc name="input.c.page1.xmaw012_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw031
            #add-point:ON ACTION controlp INFIELD xmaw031 name="input.c.page1.xmaw031"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw031             #給予default值
            #LET g_qryparam.default2 = "" #g_xmaw_d[l_ac].oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "2003" #s
            CALL q_oocq002()                                #呼叫開窗
            LET g_xmaw_d[l_ac].xmaw031 = g_qryparam.return1              
            #LET g_xmaw_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw031              #
            #DISPLAY g_xmaw_d[l_ac].oocql004 TO oocql004 #說明
            CALL axmi129_xmaw031_ref()
            NEXT FIELD xmaw031                          #返回原欄位
            


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw032
            #add-point:ON ACTION controlp INFIELD xmaw032 name="input.c.page1.xmaw032"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw032             #給予default值
            CALL q_rtax001()                                #呼叫開窗
            LET g_xmaw_d[l_ac].xmaw032 = g_qryparam.return1              
            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw032     #
            CALL axmi129_xmaw032_ref()
            NEXT FIELD xmaw032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw013
            #add-point:ON ACTION controlp INFIELD xmaw013 name="input.c.page1.xmaw013"
            

            #此段落由子樣板a07產生            
            #開窗i段
            #dorislai-20150627-modify----(S)
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#			   LET g_qryparam.reqry = FALSE
#            CALL q_ooca001_1()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xmaw013  #顯示到畫面上
#            NEXT FIELD xmaw013                     #返回原欄位
            LET l_chk = FALSE #避免輸入料件編號出現二次開窗
            #若料件編號有值
            IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
		         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		         LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw013             #給予default值
               LET g_qryparam.arg1 = g_xmaw_d[l_ac].xmaw011
               CALL q_imao002()                                             #呼叫開窗
               LET g_xmaw_d[l_ac].xmaw013 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET l_chk = TRUE
            END IF
            #dorislai-20150627-modify----(E)            
         
         
            ##dorislai-20150612-add----(S) 
            #若系列或產品分類有值，抓取aimm200中的單位開窗
            IF (NOT cl_null(g_xmaw_d[l_ac].xmaw031)) OR cl_null(g_xmaw_d[l_ac].xmaw032) = FALSE THEN
               #先判斷是哪個欄位有值，給予sql查詢條件
                  #---用系列去抓料件編號
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw031)THEN
                  LET l_sql = "SELECT imaa001 FROM imaa_t ",
                              "WHERE imaaent = '"||g_enterprise||"' AND imaa127 = '"||g_xmaw_d[l_ac].xmaw031||"'",
                              "ORDER BY imaa001" 
               END IF
                  #---用產品分類抓料件編號
               IF NOT cl_null(g_xmaw_d[l_ac].xmaw032)THEN
                  LET l_sql = "SELECT imaa001 FROM imaa_t ",
                              "WHERE imaaent = '"||g_enterprise||"' AND imaa009 = '"||g_xmaw_d[l_ac].xmaw032||"'",
                              "ORDER BY imaa001" 
               END IF
                              
               PREPARE axmi129_get_imaa001_open_pre FROM l_sql
               DECLARE axmi129_get_imaa001_open_curs CURSOR FOR axmi129_get_imaa001_open_pre
               #先清空值，避免殘留舊值
               LET l_imaa001 = ''
               LET l_str = ''
               LET l_str_cnt = 1
               #一筆一筆比對是否有符合任一 料件編號中的可使用單位
               FOREACH axmi129_get_imaa001_open_curs INTO l_imaa001
                  #抓取到第一筆資料時，開始組字串
                  IF l_str_cnt = 1 THEN
                     LET l_str = "'",l_imaa001,"'"
                  #抓取道第二筆資料時(含第二筆)，接著第一筆或先前的字串繼續串字串
                  ELSE
                     LET l_str = l_str||",'"||l_imaa001||"'"
                  END IF
                  LET l_str_cnt = l_str_cnt + 1 #筆數增加，避免重複判斷是第一筆資料
               END FOREACH
               FREE axmi129_get_imaa001_open_pre#已使用完畢，釋放
               
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               #依是否抓到料號，來決定g_qryparam.where值
               IF cl_null(l_str) THEN   #沒抓到對應的料號
                  LET g_qryparam.where = "imao001 = ''"
               ELSE
                  LET g_qryparam.where = "imao001 IN ("||l_str||")"#增加q_imao002_01的條件判斷
               END IF
               CALL q_imao002_01()
               LET g_xmaw_d[l_ac].xmaw013 = g_qryparam.return1
            #若料號、系列、產品分類都沒有值，直接開窗全部的單位值
            ELSE
               IF l_chk = FALSE THEN
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw013   #給予default值
                  #給予arg
                  CALL q_ooca001_1()                          #呼叫開窗
                  LET g_xmaw_d[l_ac].xmaw013 = g_qryparam.return1
               END IF
            END IF
            #dorislai-20150612-add----(S) 

            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw013      #顯示到畫面上
            CALL axmi129_xmaw013_ref()
            NEXT FIELD xmaw013                          #返回原欄位
            
            
            
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw014
            #add-point:ON ACTION controlp INFIELD xmaw014 name="input.c.page1.xmaw014"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw015
            #add-point:ON ACTION controlp INFIELD xmaw015 name="input.c.page1.xmaw015"
                                                                                                                        #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw015             #給予default值
            LET g_qryparam.default2 = g_xmaw_d[l_ac].xmaw016 #g_xmaw_d[l_ac].xmaw012 #產品特徵

            #給予arg
            LET g_qryparam.arg1 = g_xmaw_m.xmaw001
            LET g_qryparam.arg2 = g_xmaw_m.xmaw002
            LET g_qryparam.arg3 = g_xmaw_d[l_ac].xmaw013
            LET g_qryparam.arg4 = g_xmaw_d[l_ac].xmaw011            
            LET g_qryparam.arg5 = g_xmaw_d[l_ac].xmaw012
            #dorislai-20150627-add----(S)
            IF cl_null(g_qryparam.arg4) THEN               #避免為NULL，抓不到值
               LET g_qryparam.arg4 = ' '
            END IF
            #dorislai-20150627-add----(E)
            CALL q_xmaw015_2()   #呼叫開窗              

            LET g_xmaw_d[l_ac].xmaw015 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_xmaw_d[l_ac].xmaw016 = g_qryparam.return2 #產品特徵
            IF cl_null(g_xmaw_d[l_ac].xmaw016) THEN
               LET g_xmaw_d[l_ac].xmaw016 = ' '
            END IF   

            DISPLAY g_xmaw_d[l_ac].xmaw015 TO xmaw015              #顯示到畫面上
            DISPLAY g_xmaw_d[l_ac].xmaw016 TO xmaw016   #產品特徵
            CALL axmi129_xmaw015_ref()
            NEXT FIELD xmaw015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw016
            #add-point:ON ACTION controlp INFIELD xmaw016 name="input.c.page1.xmaw016"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xmaw_m.xmaw001
            LET g_qryparam.arg2 = g_xmaw_m.xmaw002
            LET g_qryparam.arg3 = g_xmaw_d[l_ac].xmaw015
            LET g_qryparam.arg4 = g_xmaw_d[l_ac].xmaw013 
            LET g_qryparam.arg5 = g_xmaw_d[l_ac].xmaw011       
            LET g_qryparam.arg6 = g_xmaw_d[l_ac].xmaw012                
            CALL q_xmaw016_2()  
 

            LET g_xmaw_d[l_ac].xmaw016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmaw_d[l_ac].xmaw016 TO xmaw016              #顯示到畫面上

            NEXT FIELD xmaw016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw033
            #add-point:ON ACTION controlp INFIELD xmaw033 name="input.c.page1.xmaw033"
            #應用 a07 樣板自動產生(Version:2)   

            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw033             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_xmaw_m.xmaw001
            LET g_qryparam.arg2 = g_xmaw_m.xmaw002
            LET g_qryparam.arg3 = g_xmaw_d[l_ac].xmaw013
            LET g_qryparam.arg4 = g_xmaw_d[l_ac].xmaw031 
            IF cl_null(g_qryparam.arg4) THEN                             #避免arg4為NULL找不到值
               LET g_qryparam.arg4 = ' '
            END IF            
            CALL q_xmaw033()   #呼叫開窗              
            LET g_xmaw_d[l_ac].xmaw033 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw033                       #顯示到畫面上
            CALL axmi129_xmaw033_ref()
            NEXT FIELD xmaw033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw034
            #add-point:ON ACTION controlp INFIELD xmaw034 name="input.c.page1.xmaw034"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmaw_d[l_ac].xmaw034             #給予default值
            LET g_qryparam.arg1 = g_xmaw_m.xmaw001
            LET g_qryparam.arg2 = g_xmaw_m.xmaw002
            LET g_qryparam.arg3 = g_xmaw_d[l_ac].xmaw013
            LET g_qryparam.arg4 = g_xmaw_d[l_ac].xmaw032  
            IF cl_null(g_qryparam.arg4) THEN                             #避免arg4為NULL找不到值
               LET g_qryparam.arg4 = ' '
            END IF            
            CALL q_xmaw034()   #呼叫開窗  
            LET g_xmaw_d[l_ac].xmaw034 = g_qryparam.return1              
            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw034
            CALL axmi129_xmaw034_ref()
            NEXT FIELD xmaw034                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw017
            #add-point:ON ACTION controlp INFIELD xmaw017 name="input.c.page1.xmaw017"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw018
            #add-point:ON ACTION controlp INFIELD xmaw018 name="input.c.page1.xmaw018"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw019
            #add-point:ON ACTION controlp INFIELD xmaw019 name="input.c.page1.xmaw019"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw020
            #add-point:ON ACTION controlp INFIELD xmaw020 name="input.c.page1.xmaw020"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw021
            #add-point:ON ACTION controlp INFIELD xmaw021 name="input.c.page1.xmaw021"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw022
            #add-point:ON ACTION controlp INFIELD xmaw022 name="input.c.page1.xmaw022"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw023
            #add-point:ON ACTION controlp INFIELD xmaw023 name="input.c.page1.xmaw023"
                                                                                                                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmaw100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmaw100
            #add-point:ON ACTION controlp INFIELD xmaw100 name="input.c.page1.xmaw100"
                                                                                                                        
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmaw_d[l_ac].* = g_xmaw_d_t.*
               CLOSE axmi129_bcl
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
               LET g_errparam.extend = g_xmaw_d[l_ac].xmaw011 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmaw_d[l_ac].* = g_xmaw_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_xmaw2_d[l_ac].xmawmodid = g_user 
LET g_xmaw2_d[l_ac].xmawmoddt = cl_get_current()
LET g_xmaw2_d[l_ac].xmawmodid_desc = cl_get_username(g_xmaw2_d[l_ac].xmawmodid)
            
               #add-point:單身修改前 name="input.body.b_update"
               #dorislai-20150626-add----(S)
               #料號、系列、產品分類至少要輸入一項 (如果都沒輸入的話應該報錯 )
               LET l_chk2 = TRUE      #讓錯誤訊息只出現一次的開關
                              
               IF cl_null(g_xmaw_d_o.xmaw011) AND cl_null(g_xmaw_d_o.xmaw031) AND 
                  cl_null(g_xmaw_d_o.xmaw032) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 'axm-00650'     #料件編號、系列、產品分類請擇一輸入 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 

                  LET l_chk2 = FALSE  
                  NEXT FIELD xmaw011 
               END IF 

               #如果有勾選「參考資料否」，則三個參考欄位至少要有輸入一個  
               IF g_xmaw_d_o.xmaw014 = 'Y' THEN 
                  IF cl_null(g_xmaw_d_o.xmaw015) AND cl_null(g_xmaw_d_o.xmaw033) AND 
                     cl_null(g_xmaw_d_o.xmaw034) THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'axm-00674' 
                     LET g_errparam.popup  = TRUE  
                     CALL cl_err() 

                     LET l_chk2 = FALSE
                     NEXT FIELD xmaw015  
                  END IF 
               END IF  
               IF l_cmd = 'a' THEN                
                  #如果新增時沒有走after insert的話，就不會再走insert了 
                  #所以這裡要補insert  
                  LET l_cnt = 0 
                  SELECT COUNT(*) INTO l_cnt 
                    FROM xmaw_t 
                   WHERE xmawent = g_enterprise 
                     AND xmaw001 = g_xmaw_m.xmaw001 
                     AND xmaw002 = g_xmaw_m.xmaw002 
                     AND xmaw011 = COALESCE(g_xmaw_d_o.xmaw011,' ') 
                     AND xmaw012 = COALESCE(g_xmaw_d_o.xmaw012,' ') 
                     AND xmaw013 = g_xmaw_d_o.xmaw013 
                     AND xmaw031 = COALESCE(g_xmaw_d_o.xmaw031,' ') 
                     AND xmaw032 = COALESCE(g_xmaw_d_o.xmaw032,' ') 
        
        
                  #如果不存在就要補新增 
                  IF cl_null(l_cnt) OR l_cnt = 0 THEN 
                  
                     IF cl_null(g_xmaw_d[l_ac].xmaw011) THEN 
                        LET g_xmaw_d[l_ac].xmaw011 = ' ' 
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw012) THEN 
                        LET g_xmaw_d[l_ac].xmaw012 = ' ' 
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw031) THEN 
                        LET g_xmaw_d[l_ac].xmaw031 = ' ' 
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw032) THEN 
                        LET g_xmaw_d[l_ac].xmaw032 = ' ' 
                     END IF 
                     
                     DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012, 
                                     g_xmaw_d[l_ac].xmaw031,g_xmaw_d[l_ac].xmaw032
                     INSERT INTO xmaw_t(xmawent,xmaw001,xmaw002,xmaw011,xmaw012, 
                                        xmaw013,xmaw031,xmaw032,xmawstus,xmaw014, 
                                        xmaw015,xmaw016,xmaw033,xmaw034,xmaw017, 
                                        xmaw018,xmaw019,xmaw020,xmaw021,xmaw022, 
                                        xmaw023,xmaw100,xmawownid,xmawowndp,xmawcrtid, 
                                        xmawcrtdp,xmawcrtdt,xmawmodid,xmawmoddt) 
                                 VALUES(g_enterprise,g_xmaw_m.xmaw001,g_xmaw_m.xmaw002, 
                                        g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012,
                                        g_xmaw_d[l_ac].xmaw013,g_xmaw_d[l_ac].xmaw031,
                                        g_xmaw_d[l_ac].xmaw032,g_xmaw_d[l_ac].xmawstus,
                                        g_xmaw_d[l_ac].xmaw014,g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016,
                                        g_xmaw_d[l_ac].xmaw033,g_xmaw_d[l_ac].xmaw034,g_xmaw_d[l_ac].xmaw017,
                                        g_xmaw_d[l_ac].xmaw018,g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020,
                                        g_xmaw_d[l_ac].xmaw021,g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023,
                                        g_xmaw_d[l_ac].xmaw100,g_xmaw2_d[l_ac].xmawownid,g_xmaw2_d[l_ac].xmawowndp,
                                        g_xmaw2_d[l_ac].xmawcrtid,g_xmaw2_d[l_ac].xmawcrtdp,
                                        g_xmaw2_d[l_ac].xmawcrtdt,g_xmaw2_d[l_ac].xmawmodid,
                                        g_xmaw2_d[l_ac].xmawmoddt)  
                                       
                     LET g_xmaw_d_t.xmaw013 = g_xmaw_d[l_ac].xmaw013
                     IF cl_null(g_xmaw_d[l_ac].xmaw011) THEN 
                        LET g_xmaw_d_t.xmaw011 = ' ' 
                     ELSE
                        LET g_xmaw_d_t.xmaw011 = g_xmaw_d[l_ac].xmaw011
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw012) THEN 
                        LET g_xmaw_d_t.xmaw012 = ' ' 
                     ELSE
                        LET g_xmaw_d_t.xmaw012 = g_xmaw_d[l_ac].xmaw012
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw031) THEN 
                        LET g_xmaw_d_t.xmaw031 = ' ' 
                     ELSE
                        LET g_xmaw_d_t.xmaw031 = g_xmaw_d[l_ac].xmaw031
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw032) THEN 
                        LET g_xmaw_d_t.xmaw032 = ' ' 
                     ELSE
                        LET g_xmaw_d_t.xmaw032 = g_xmaw_d[l_ac].xmaw032
                     END IF
                     
                     LET g_rec_b=g_rec_b+1
                     DISPLAY g_rec_b TO FORMONLY.cnt
                  END IF 
               ELSE
                  IF cl_null(g_xmaw_d[l_ac].xmaw011) THEN 
                     LET g_xmaw_d[l_ac].xmaw011 = ' ' 
                  END IF 
                  IF cl_null(g_xmaw_d[l_ac].xmaw012) THEN 
                     LET g_xmaw_d[l_ac].xmaw012 = ' ' 
                  END IF 
                  IF cl_null(g_xmaw_d[l_ac].xmaw031) THEN 
                     LET g_xmaw_d[l_ac].xmaw031 = ' ' 
                  END IF 
                  IF cl_null(g_xmaw_d[l_ac].xmaw032) THEN 
                     LET g_xmaw_d[l_ac].xmaw032 = ' ' 
                  END IF 
               END IF 
                                                    
               #dorislai-20150626-add----(E)
               #end add-point
         
               #將遮罩欄位還原
               CALL axmi129_xmaw_t_mask_restore('restore_mask_o')
         
               UPDATE xmaw_t SET (xmaw001,xmaw002,xmawstus,xmaw011,xmaw012,xmaw031,xmaw032,xmaw013,xmaw014, 
                   xmaw015,xmaw016,xmaw033,xmaw034,xmaw017,xmaw018,xmaw019,xmaw020,xmaw021,xmaw022,xmaw023, 
                   xmaw100,xmawownid,xmawowndp,xmawcrtid,xmawcrtdp,xmawcrtdt,xmawmodid,xmawmoddt) = (g_xmaw_m.xmaw001, 
                   g_xmaw_m.xmaw002,g_xmaw_d[l_ac].xmawstus,g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012, 
                   g_xmaw_d[l_ac].xmaw031,g_xmaw_d[l_ac].xmaw032,g_xmaw_d[l_ac].xmaw013,g_xmaw_d[l_ac].xmaw014, 
                   g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016,g_xmaw_d[l_ac].xmaw033,g_xmaw_d[l_ac].xmaw034, 
                   g_xmaw_d[l_ac].xmaw017,g_xmaw_d[l_ac].xmaw018,g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020, 
                   g_xmaw_d[l_ac].xmaw021,g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023,g_xmaw_d[l_ac].xmaw100, 
                   g_xmaw2_d[l_ac].xmawownid,g_xmaw2_d[l_ac].xmawowndp,g_xmaw2_d[l_ac].xmawcrtid,g_xmaw2_d[l_ac].xmawcrtdp, 
                   g_xmaw2_d[l_ac].xmawcrtdt,g_xmaw2_d[l_ac].xmawmodid,g_xmaw2_d[l_ac].xmawmoddt)
                WHERE xmawent = g_enterprise AND xmaw001 = g_xmaw_m.xmaw001 
                 AND xmaw002 = g_xmaw_m.xmaw002 
 
                 AND xmaw011 = g_xmaw_d_t.xmaw011 #項次   
                 AND xmaw012 = g_xmaw_d_t.xmaw012  
                 AND xmaw013 = g_xmaw_d_t.xmaw013  
                 AND xmaw031 = g_xmaw_d_t.xmaw031  
                 AND xmaw032 = g_xmaw_d_t.xmaw032  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
                                                                                                                                                                                      
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmaw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xmaw_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmaw_m.xmaw001
               LET gs_keys_bak[1] = g_xmaw001_t
               LET gs_keys[2] = g_xmaw_m.xmaw002
               LET gs_keys_bak[2] = g_xmaw002_t
               LET gs_keys[3] = g_xmaw_d[g_detail_idx].xmaw011
               LET gs_keys_bak[3] = g_xmaw_d_t.xmaw011
               LET gs_keys[4] = g_xmaw_d[g_detail_idx].xmaw012
               LET gs_keys_bak[4] = g_xmaw_d_t.xmaw012
               LET gs_keys[5] = g_xmaw_d[g_detail_idx].xmaw013
               LET gs_keys_bak[5] = g_xmaw_d_t.xmaw013
               LET gs_keys[6] = g_xmaw_d[g_detail_idx].xmaw031
               LET gs_keys_bak[6] = g_xmaw_d_t.xmaw031
               LET gs_keys[7] = g_xmaw_d[g_detail_idx].xmaw032
               LET gs_keys_bak[7] = g_xmaw_d_t.xmaw032
               CALL axmi129_update_b('xmaw_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xmaw_m),util.JSON.stringify(g_xmaw_d_t)
                     LET g_log2 = util.JSON.stringify(g_xmaw_m),util.JSON.stringify(g_xmaw_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmi129_xmaw_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xmaw_m.xmaw001
               LET ls_keys[ls_keys.getLength()+1] = g_xmaw_m.xmaw002
 
               LET ls_keys[ls_keys.getLength()+1] = g_xmaw_d_t.xmaw011
               LET ls_keys[ls_keys.getLength()+1] = g_xmaw_d_t.xmaw012
               LET ls_keys[ls_keys.getLength()+1] = g_xmaw_d_t.xmaw013
               LET ls_keys[ls_keys.getLength()+1] = g_xmaw_d_t.xmaw031
               LET ls_keys[ls_keys.getLength()+1] = g_xmaw_d_t.xmaw032
 
               CALL axmi129_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               #dorislai-20150626-modify----(S)
#               CALL axmi129_xmaw_upd(g_xmaw_m.xmaw001,g_xmaw_m.xmaw002,g_xmaw_d_t.xmaw011,g_xmaw_d_t.xmaw012,g_xmaw_d_t.xmaw013,g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020,g_xmaw_d[l_ac].xmaw021,g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023)
               CALL axmi129_xmaw_upd(g_xmaw_m.xmaw001,g_xmaw_m.xmaw002,g_xmaw_d_t.xmaw011,g_xmaw_d_t.xmaw012,g_xmaw_d_t.xmaw031,g_xmaw_d_t.xmaw032,g_xmaw_d_t.xmaw013,g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020,g_xmaw_d[l_ac].xmaw021,g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023)
               CALL axmi129_show()    #讓修改後的參考價格立即顯現
               #dorislai-20150626-modify----(E)
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            #dorislai-20150626-add----(S)
            #非刪除的情況且單位有輸入資料才需要檢查 
            IF (NOT l_del_chk) AND (NOT cl_null(g_xmaw_d_o.xmaw013)) THEN 
               #檢查三個key值欄位是否有輸入資料 
               IF cl_null(g_xmaw_d_o.xmaw011) AND cl_null(g_xmaw_d_o.xmaw031) AND 
                  cl_null(g_xmaw_d_o.xmaw032) THEN 
                  IF l_chk2 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = 'axm-00650'     #料件編號、系列、產品分類請擇一輸入 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                  END IF 
               
                  LET l_chk2 = TRUE 
                  NEXT FIELD xmaw011 
               END IF 

               #如果有勾選「參考資料否」，則三個參考欄位至少要有輸入一個  
               IF g_xmaw_d_o.xmaw014 = 'Y' THEN 
                  IF cl_null(g_xmaw_d_o.xmaw015) AND cl_null(g_xmaw_d_o.xmaw033) AND 
                     cl_null(g_xmaw_d_o.xmaw034) THEN 
                     IF l_chk2 THEN 
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = '' 
                        LET g_errparam.code   = 'axm-00674' 
                        LET g_errparam.popup  = TRUE  
                        CALL cl_err() 
                     END IF 

                     LET l_chk2 = TRUE
                     NEXT FIELD xmaw015  
                  END IF 
               END IF  

               IF l_cmd = 'a' THEN                
                  #如果新增時沒有走after insert的話，就不會再走insert了 
                  #所以這裡要補insert  
                  LET l_cnt = 0 
                  SELECT COUNT(*) INTO l_cnt 
                    FROM xmaw_t 
                   WHERE xmawent = g_enterprise 
                     AND xmaw001 = g_xmaw_m.xmaw001 
                     AND xmaw002 = g_xmaw_m.xmaw002 
                     AND xmaw011 = COALESCE(g_xmaw_d_o.xmaw011,' ') 
                     AND xmaw012 = COALESCE(g_xmaw_d_o.xmaw012,' ') 
                     AND xmaw013 = g_xmaw_d_o.xmaw013 
                     AND xmaw031 = COALESCE(g_xmaw_d_o.xmaw031,' ') 
                     AND xmaw032 = COALESCE(g_xmaw_d_o.xmaw032,' ') 

                  #如果不存在就要補新增 
                  IF cl_null(l_cnt) OR l_cnt = 0 THEN 
                  
                     IF cl_null(g_xmaw_d[l_ac].xmaw011) THEN 
                        LET g_xmaw_d[l_ac].xmaw011 = ' ' 
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw012) THEN 
                        LET g_xmaw_d[l_ac].xmaw012 = ' ' 
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw031) THEN 
                        LET g_xmaw_d[l_ac].xmaw031 = ' ' 
                     END IF 
                     IF cl_null(g_xmaw_d[l_ac].xmaw032) THEN 
                        LET g_xmaw_d[l_ac].xmaw032 = ' ' 
                     END IF 
                     
                     DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012, 
                                     g_xmaw_d[l_ac].xmaw031,g_xmaw_d[l_ac].xmaw032
                     INSERT INTO xmaw_t(xmawent,xmaw001,xmaw002,xmaw011,xmaw012, 
                                        xmaw013,xmaw031,xmaw032,xmawstus,xmaw014, 
                                        xmaw015,xmaw016,xmaw033,xmaw034,xmaw017, 
                                        xmaw018,xmaw019,xmaw020,xmaw021,xmaw022, 
                                        xmaw023,xmaw100,xmawownid,xmawowndp,xmawcrtid, 
                                        xmawcrtdp,xmawcrtdt,xmawmodid,xmawmoddt) 
                                 VALUES(g_enterprise,g_xmaw_m.xmaw001,g_xmaw_m.xmaw002, 
                                        g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012,
                                        g_xmaw_d[l_ac].xmaw013,g_xmaw_d[l_ac].xmaw031,
                                        g_xmaw_d[l_ac].xmaw032,g_xmaw_d[l_ac].xmawstus,
                                        g_xmaw_d[l_ac].xmaw014,g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016,
                                        g_xmaw_d[l_ac].xmaw033,g_xmaw_d[l_ac].xmaw034,g_xmaw_d[l_ac].xmaw017,
                                        g_xmaw_d[l_ac].xmaw018,g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020,
                                        g_xmaw_d[l_ac].xmaw021,g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023,
                                        g_xmaw_d[l_ac].xmaw100,g_xmaw2_d[l_ac].xmawownid,g_xmaw2_d[l_ac].xmawowndp,
                                        g_xmaw2_d[l_ac].xmawcrtid,g_xmaw2_d[l_ac].xmawcrtdp,
                                        g_xmaw2_d[l_ac].xmawcrtdt,g_xmaw2_d[l_ac].xmawmodid,
                                        g_xmaw2_d[l_ac].xmawmoddt)  

                     LET g_rec_b=g_rec_b+1
                     DISPLAY g_rec_b TO FORMONLY.cnt
                  END IF 
               END IF 
            END IF                                                                
            #dorislai-20150626-add----(E) 

            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axmi129_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmaw_d[l_ac].* = g_xmaw_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axmi129_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xmaw_d.getLength() = 0 THEN
               NEXT FIELD xmaw011
            END IF
            #add-point:input段after input  name="input.body.after_input"
                                                                                                                       
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmaw_d[li_reproduce_target].* = g_xmaw_d[li_reproduce].*
               LET g_xmaw2_d[li_reproduce_target].* = g_xmaw2_d[li_reproduce].*
 
               LET g_xmaw_d[li_reproduce_target].xmaw011 = NULL
               LET g_xmaw_d[li_reproduce_target].xmaw012 = NULL
               LET g_xmaw_d[li_reproduce_target].xmaw013 = NULL
               LET g_xmaw_d[li_reproduce_target].xmaw031 = NULL
               LET g_xmaw_d[li_reproduce_target].xmaw032 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmaw_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmaw_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_xmaw2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axmi129_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL axmi129_idx_chk()
            CALL axmi129_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為 name="input.body2.action"
                                                                                          
         #end add-point
         
      END DISPLAY
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
                                                            
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         #2015/07/16 by stellar add ----- (S)
         #因參照表號不能輸入，又在第一個欄位，故新增時，跳到第二個欄位輸入
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         IF p_cmd = 'a' THEN
            NEXT FIELD xmaw002
         END IF
         #2015/07/16 by stellar add ----- (E)                                                              
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xmaw001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xmawstus
               WHEN "s_detail2"
                  NEXT FIELD xmaw011_2
 
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
 
{<section id="axmi129.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axmi129_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
                              
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
                              
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axmi129_b_fill(g_wc2) #第一階單身填充
      CALL axmi129_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axmi129_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xmaw_m.xmaw001,g_xmaw_m.xmaw001_desc,g_xmaw_m.xmaw002,g_xmaw_m.xmaw002_desc
 
   CALL axmi129_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
                              
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axmi129_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   DEFINE l_success  LIKE type_t.num5                         
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmaw_m.xmaw001
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='15' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmaw_m.xmaw001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmaw_m.xmaw001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmaw_m.xmaw002
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmaw_m.xmaw002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmaw_m.xmaw002_desc

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xmaw_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw011
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmaw_d[l_ac].xmaw011_desc = '', g_rtn_fields[1] , ''
#            LET g_xmaw_d[l_ac].xmaw011_desc_desc = '', g_rtn_fields[2] , ''
#            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011_desc
#            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011_desc_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw013
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xmaw_d[l_ac].xmaw013_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw013_desc
#            CALL axmi129_xmaw015_ref()
            CALL s_feature_description(g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012)
                 RETURNING l_success,g_xmaw_d[l_ac].xmaw012_desc  
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xmaw2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
                                                            
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axmi129.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axmi129_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xmaw_t.xmaw001 
   DEFINE l_oldno     LIKE xmaw_t.xmaw001 
   DEFINE l_newno02     LIKE xmaw_t.xmaw002 
   DEFINE l_oldno02     LIKE xmaw_t.xmaw002 
 
   DEFINE l_master    RECORD LIKE xmaw_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xmaw_t.* #此變數樣板目前無使用
 
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
 
   IF g_xmaw_m.xmaw001 IS NULL
      OR g_xmaw_m.xmaw002 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xmaw001_t = g_xmaw_m.xmaw001
   LET g_xmaw002_t = g_xmaw_m.xmaw002
 
   
   LET g_xmaw_m.xmaw001 = ""
   LET g_xmaw_m.xmaw002 = ""
 
   LET g_master_insert = FALSE
   CALL axmi129_set_entry('a')
   CALL axmi129_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
        
   #end add-point
   
   #清空key欄位的desc
      LET g_xmaw_m.xmaw001_desc = ''
   DISPLAY BY NAME g_xmaw_m.xmaw001_desc
   LET g_xmaw_m.xmaw002_desc = ''
   DISPLAY BY NAME g_xmaw_m.xmaw002_desc
 
   
   CALL axmi129_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xmaw_m.* TO NULL
      INITIALIZE g_xmaw_d TO NULL
      INITIALIZE g_xmaw2_d TO NULL
 
      CALL axmi129_show()
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
   CALL axmi129_set_act_visible()
   CALL axmi129_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xmaw001_t = g_xmaw_m.xmaw001
   LET g_xmaw002_t = g_xmaw_m.xmaw002
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmawent = " ||g_enterprise|| " AND",
                      " xmaw001 = '", g_xmaw_m.xmaw001, "' "
                      ," AND xmaw002 = '", g_xmaw_m.xmaw002, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmi129_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axmi129_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
                              
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axmi129_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axmi129_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xmaw_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
                              
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axmi129_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
                              
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmaw_t
    WHERE xmawent = g_enterprise AND xmaw001 = g_xmaw001_t
    AND xmaw002 = g_xmaw002_t
 
       INTO TEMP axmi129_detail
   
   #將key修正為調整後   
   UPDATE axmi129_detail 
      #更新key欄位
      SET xmaw001 = g_xmaw_m.xmaw001
          , xmaw002 = g_xmaw_m.xmaw002
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , xmawownid = g_user 
       , xmawowndp = g_dept
       , xmawcrtid = g_user
       , xmawcrtdp = g_dept 
       , xmawcrtdt = ld_date
       , xmawmodid = g_user
       , xmawmoddt = ld_date
      #, xmawstus = "Y" 
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO xmaw_t SELECT * FROM axmi129_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   UPDATE xmaw_t SET xmawstus = 'Y'
    WHERE xmawent = g_enterprise
      AND xmaw001 = g_xmaw_m.xmaw001
      AND xmaw002 = g_xmaw_m.xmaw002       
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmi129_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
                              
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xmaw001_t = g_xmaw_m.xmaw001
   LET g_xmaw002_t = g_xmaw_m.xmaw002
 
   
   DROP TABLE axmi129_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axmi129_delete()
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
   
   IF g_xmaw_m.xmaw001 IS NULL
   OR g_xmaw_m.xmaw002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axmi129_cl USING g_enterprise,g_xmaw_m.xmaw001,g_xmaw_m.xmaw002
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmi129_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axmi129_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmi129_master_referesh USING g_xmaw_m.xmaw001,g_xmaw_m.xmaw002 INTO g_xmaw_m.xmaw001,g_xmaw_m.xmaw002, 
       g_xmaw_m.xmaw001_desc,g_xmaw_m.xmaw002_desc
   
   #遮罩相關處理
   LET g_xmaw_m_mask_o.* =  g_xmaw_m.*
   CALL axmi129_xmaw_t_mask()
   LET g_xmaw_m_mask_n.* =  g_xmaw_m.*
   
   CALL axmi129_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmi129_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
                                                            
      #end add-point
      
      DELETE FROM xmaw_t WHERE xmawent = g_enterprise AND xmaw001 = g_xmaw_m.xmaw001
                                                               AND xmaw002 = g_xmaw_m.xmaw002
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
                                                            
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmaw_t:",SQLERRMESSAGE 
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
      #   CLOSE axmi129_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xmaw_d.clear() 
      CALL g_xmaw2_d.clear()       
 
     
      CALL axmi129_ui_browser_refresh()  
      #CALL axmi129_ui_headershow()  
      #CALL axmi129_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axmi129_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axmi129_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axmi129_cl
 
   #功能已完成,通報訊息中心
   CALL axmi129_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axmi129.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmi129_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
                              
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xmaw_d.clear()
   CALL g_xmaw2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
                              
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xmawstus,xmaw011,xmaw012,xmaw031,xmaw032,xmaw013,xmaw014,xmaw015,xmaw016, 
       xmaw033,xmaw034,xmaw017,xmaw018,xmaw019,xmaw020,xmaw021,xmaw022,xmaw023,xmaw100,xmaw011,xmaw012, 
       xmaw013,xmawownid,xmawowndp,xmawcrtid,xmawcrtdp,xmawcrtdt,xmawmodid,xmawmoddt,t1.imaal003 ,t2.imaal004 , 
       t3.oocql004 ,t4.rtaxl003 ,t5.oocal003 ,t6.imaal003 ,t7.imaal004 ,t8.oocql004 ,t9.rtaxl003 ,t10.ooag011 , 
       t11.ooefl003 ,t12.ooag011 ,t13.ooefl003 ,t14.ooag011 FROM xmaw_t",   
               "",
               
                              " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmaw011 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmaw011 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2003' AND t3.oocql002=xmaw031 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=xmaw032 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=xmaw013 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t6 ON t6.imaalent="||g_enterprise||" AND t6.imaal001=xmaw015 AND t6.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t7 ON t7.imaalent="||g_enterprise||" AND t7.imaal001=xmaw015 AND t7.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='2003' AND t8.oocql002=xmaw033 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t9 ON t9.rtaxlent="||g_enterprise||" AND t9.rtaxl001=xmaw034 AND t9.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=xmawownid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=xmawowndp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=xmawcrtid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=xmawcrtdp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=xmawmodid  ",
 
               " WHERE xmawent= ? AND xmaw001=? AND xmaw002=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xmaw_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
                              
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axmi129_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xmaw_t.xmaw011,xmaw_t.xmaw012,xmaw_t.xmaw013,xmaw_t.xmaw031,xmaw_t.xmaw032"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmi129_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axmi129_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xmaw_m.xmaw001,g_xmaw_m.xmaw002   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xmaw_m.xmaw001,g_xmaw_m.xmaw002 INTO g_xmaw_d[l_ac].xmawstus, 
          g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012,g_xmaw_d[l_ac].xmaw031,g_xmaw_d[l_ac].xmaw032, 
          g_xmaw_d[l_ac].xmaw013,g_xmaw_d[l_ac].xmaw014,g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016, 
          g_xmaw_d[l_ac].xmaw033,g_xmaw_d[l_ac].xmaw034,g_xmaw_d[l_ac].xmaw017,g_xmaw_d[l_ac].xmaw018, 
          g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020,g_xmaw_d[l_ac].xmaw021,g_xmaw_d[l_ac].xmaw022, 
          g_xmaw_d[l_ac].xmaw023,g_xmaw_d[l_ac].xmaw100,g_xmaw2_d[l_ac].xmaw011,g_xmaw2_d[l_ac].xmaw012, 
          g_xmaw2_d[l_ac].xmaw013,g_xmaw2_d[l_ac].xmawownid,g_xmaw2_d[l_ac].xmawowndp,g_xmaw2_d[l_ac].xmawcrtid, 
          g_xmaw2_d[l_ac].xmawcrtdp,g_xmaw2_d[l_ac].xmawcrtdt,g_xmaw2_d[l_ac].xmawmodid,g_xmaw2_d[l_ac].xmawmoddt, 
          g_xmaw_d[l_ac].xmaw011_desc,g_xmaw_d[l_ac].xmaw011_desc_desc,g_xmaw_d[l_ac].xmaw031_desc,g_xmaw_d[l_ac].xmaw032_desc, 
          g_xmaw_d[l_ac].xmaw013_desc,g_xmaw_d[l_ac].xmaw015_desc,g_xmaw_d[l_ac].xmaw015_desc_desc,g_xmaw_d[l_ac].xmaw033_desc, 
          g_xmaw_d[l_ac].xmaw034_desc,g_xmaw2_d[l_ac].xmawownid_desc,g_xmaw2_d[l_ac].xmawowndp_desc, 
          g_xmaw2_d[l_ac].xmawcrtid_desc,g_xmaw2_d[l_ac].xmawcrtdp_desc,g_xmaw2_d[l_ac].xmawmodid_desc  
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
         LET g_xmaw2_d[l_ac].xmawownid_desc = cl_get_username(g_xmaw2_d[l_ac].xmawownid)
         LET g_xmaw2_d[l_ac].xmawowndp_desc = cl_get_deptname(g_xmaw2_d[l_ac].xmawowndp)
         LET g_xmaw2_d[l_ac].xmawcrtid_desc = cl_get_username(g_xmaw2_d[l_ac].xmawcrtid)
         LET g_xmaw2_d[l_ac].xmawcrtdp_desc = cl_get_deptname(g_xmaw2_d[l_ac].xmawcrtdp)
         LET g_xmaw2_d[l_ac].xmawmodid_desc = cl_get_username(g_xmaw2_d[l_ac].xmawmodid)                                                                                     
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
 
            CALL g_xmaw_d.deleteElement(g_xmaw_d.getLength())
      CALL g_xmaw2_d.deleteElement(g_xmaw2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   #dorislai-20150627-add----(S)
   DISPLAY g_xmaw_d.getLength()
   #dorislai-20150627-add----(E)
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmaw_d.getLength()
      LET g_xmaw_d_mask_o[l_ac].* =  g_xmaw_d[l_ac].*
      CALL axmi129_xmaw_t_mask()
      LET g_xmaw_d_mask_n[l_ac].* =  g_xmaw_d[l_ac].*
   END FOR
   
   LET g_xmaw2_d_mask_o.* =  g_xmaw2_d.*
   FOR l_ac = 1 TO g_xmaw2_d.getLength()
      LET g_xmaw2_d_mask_o[l_ac].* =  g_xmaw2_d[l_ac].*
      CALL axmi129_xmaw_t_mask()
      LET g_xmaw2_d_mask_n[l_ac].* =  g_xmaw2_d[l_ac].*
   END FOR
 
 
   FREE axmi129_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axmi129_idx_chk()
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
      IF g_detail_idx > g_xmaw_d.getLength() THEN
         LET g_detail_idx = g_xmaw_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xmaw_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmaw_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xmaw2_d.getLength() THEN
         LET g_detail_idx = g_xmaw2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmaw2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmaw2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmi129_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
                              
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xmaw_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
                              
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axmi129_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
                              
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
                              
   #end add-point
   
   DELETE FROM xmaw_t
    WHERE xmawent = g_enterprise AND xmaw001 = g_xmaw_m.xmaw001 AND
                              xmaw002 = g_xmaw_m.xmaw002 AND
 
          xmaw011 = g_xmaw_d_t.xmaw011
      AND xmaw012 = g_xmaw_d_t.xmaw012
      AND xmaw013 = g_xmaw_d_t.xmaw013
      AND xmaw031 = g_xmaw_d_t.xmaw031
      AND xmaw032 = g_xmaw_d_t.xmaw032
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
                              
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xmaw_t:",SQLERRMESSAGE 
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
 
{<section id="axmi129.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axmi129_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="axmi129.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axmi129_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="axmi129.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axmi129_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="axmi129.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axmi129_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xmaw_d[l_ac].xmaw011 = g_xmaw_d_t.xmaw011 
      AND g_xmaw_d[l_ac].xmaw012 = g_xmaw_d_t.xmaw012 
      AND g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013 
      AND g_xmaw_d[l_ac].xmaw031 = g_xmaw_d_t.xmaw031 
      AND g_xmaw_d[l_ac].xmaw032 = g_xmaw_d_t.xmaw032 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axmi129_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axmi129.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axmi129_lock_b(ps_table,ps_page)
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
   #CALL axmi129_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmi129.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axmi129_unlock_b(ps_table,ps_page)
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
 
{<section id="axmi129.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axmi129_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
                              
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xmaw001,xmaw002",TRUE)
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
 
{<section id="axmi129.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axmi129_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
                              
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xmaw001,xmaw002",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
                                                            
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_entry("xmaw001",FALSE)   #2015/07/16 by stellar add  
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmi129.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axmi129_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
                              
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("xmaw012,xmaw015,xmaw033,xmaw034,xmaw016,xmaw017,xmaw018,xmaw019,xmaw020,xmaw021,xmaw022,xmaw023",TRUE)
   #dorislai-20150625-add---(S)
   IF g_xmaw_d.getLength() >1 THEN   #資料不僅一筆時，開放勾選
      CALL cl_set_comp_entry("xmaw014",TRUE)
   END IF
   #dorislai-20150625-add---(E)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axmi129_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa005   LIKE imaa_t.imaa005
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   #dorislai-20150625-add----(S)
   IF g_xmaw_d.getLength() < 2 THEN  #資料僅一筆時，不開放勾選
      CALL cl_set_comp_entry("xmaw014",FALSE)
   END IF
   #dorislai-20150625-add----(E)
   IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
      #dorislai-20150625-modify----(S)
#      CALL cl_set_comp_entry("xmaw015,xmaw016,xmaw017,xmaw018",FALSE)
#      LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d[l_ac].xmaw011
#      LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d[l_ac].xmaw012
#      LET g_xmaw_d[l_ac].xmaw017 = ''
#      LET g_xmaw_d[l_ac].xmaw018 = ''
#      CALL axmi129_xmaw015_ref()
      CALL cl_set_comp_entry("xmaw015,xmaw033,xmaw034,xmaw016,xmaw017,xmaw018",FALSE)
      LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d[l_ac].xmaw011
      LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d[l_ac].xmaw012
      LET g_xmaw_d[l_ac].xmaw033 = g_xmaw_d[l_ac].xmaw031
      LET g_xmaw_d[l_ac].xmaw034 = g_xmaw_d[l_ac].xmaw032
      LET g_xmaw_d[l_ac].xmaw017 = ''
      LET g_xmaw_d[l_ac].xmaw018 = ''
      CALL axmi129_xmaw015_ref() 
      CALL axmi129_xmaw033_ref()
      CALL axmi129_xmaw034_ref()      
      #dorislai-20150625-modify----(E)      
   END IF
   IF g_xmaw_d[l_ac].xmaw014 = 'Y' THEN
      CALL cl_set_comp_entry("xmaw019,xmaw020,xmaw021,xmaw022,xmaw023",FALSE)
   END IF
   #料號   
   IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN
      SELECT imaa005 INTO l_imaa005 FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_xmaw_d[l_ac].xmaw011
      IF cl_null(l_imaa005) THEN
         CALL cl_set_comp_entry("xmaw012",FALSE) 
         #dorislai-20150628-mark---(S)
         #現在產品特徵必輸，所以不用特別塞空白
#         LET g_xmaw_d[l_ac].xmaw012 = ' '
#         LET g_xmaw_d[l_ac].xmaw012_desc = ' '
         #dorislai-20150628-mark---(E)
      END IF
   ELSE
      CALL cl_set_comp_entry("xmaw012",FALSE) 
      #dorislai-20150628-mark---(S)
      #在產品特徵必輸，所以不用特別塞空白
#       LET g_xmaw_d[l_ac].xmaw012 = ' '
#      LET g_xmaw_d[l_ac].xmaw012_desc = ' '
      #dorislai-20150628-mark---(E)

   END IF 
   #參考料號
   IF cl_null(g_xmaw_d[l_ac].xmaw015) THEN
      CALL cl_set_comp_entry("xmaw016",FALSE) 
      LET g_xmaw_d[l_ac].xmaw016 = ' '
   ELSE
      SELECT imaa005 INTO l_imaa005 FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = g_xmaw_d[l_ac].xmaw015
      IF cl_null(l_imaa005) THEN
         CALL cl_set_comp_entry("xmaw016",FALSE) 
         LET g_xmaw_d[l_ac].xmaw016 = ' '
      END IF      
   END IF
   IF NOT cl_null(g_xmaw_d[l_ac].xmaw017) THEN
      CALL cl_set_comp_entry("xmaw018",FALSE)
      LET g_xmaw_d[l_ac].xmaw018 = ''
   END IF
   IF NOT cl_null(g_xmaw_d[l_ac].xmaw018) THEN
      CALL cl_set_comp_entry("xmaw017",FALSE)
      LET g_xmaw_d[l_ac].xmaw017 = ''
   END IF    
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axmi129_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmi129.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axmi129_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmi129.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axmi129_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmi129.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axmi129_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmi129.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmi129_default_search()
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
      LET ls_wc = ls_wc, " xmaw001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmaw002 = '", g_argv[02], "' AND "
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
 
{<section id="axmi129.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axmi129_fill_chk(ps_idx)
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
 
{<section id="axmi129.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axmi129_modify_detail_chk(ps_record)
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
         LET ls_return = "xmawstus"
      WHEN "s_detail2"
         LET ls_return = "xmaw011_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
                                                            
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
                              
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axmi129.mask_functions" >}
&include "erp/axm/axmi129_mask.4gl"
 
{</section>}
 
{<section id="axmi129.state_change" >}
    
 
{</section>}
 
{<section id="axmi129.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmi129_set_pk_array()
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
   LET g_pk_array[1].values = g_xmaw_m.xmaw001
   LET g_pk_array[1].column = 'xmaw001'
   LET g_pk_array[2].values = g_xmaw_m.xmaw002
   LET g_pk_array[2].column = 'xmaw002'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmi129.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axmi129_msgcentre_notify(lc_state)
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
   CALL axmi129_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xmaw_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmi129.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 帶出參照表說明
# Usage..........: axmi129_xmaw001_ref()
# Date & Author..: 2014/02/10 By lixh
################################################################################
PRIVATE FUNCTION axmi129_xmaw001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_m.xmaw001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='15' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_m.xmaw001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmaw_m.xmaw001_desc
END FUNCTION
################################################################################
# Descriptions...: 帶出基礎幣別說明
# Usage..........: axmi129_xmaw002_ref()
# Date & Author..: 2014/02/10 By lixh
################################################################################
PRIVATE FUNCTION axmi129_xmaw002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_m.xmaw002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_m.xmaw002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmaw_m.xmaw002_desc
END FUNCTION
################################################################################
# Descriptions...: 帶出品名規格
# Usage..........: CALL axmi129_xmaw011_ref()
# Date & Author..: 2014/02/10 By lixh
################################################################################
PRIVATE FUNCTION axmi129_xmaw011_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw011
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_d[l_ac].xmaw011_desc = '', g_rtn_fields[1] , ''
   LET g_xmaw_d[l_ac].xmaw011_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011_desc
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011_desc_desc
END FUNCTION
################################################################################
# Descriptions...: 帶出單位名稱
# Usage..........: CALL axmi129_xmaw013_ref()
# Date & Author..: 2014/02/10 By lixh
################################################################################
PRIVATE FUNCTION axmi129_xmaw013_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw013
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmaw_d[l_ac].xmaw013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw013_desc
END FUNCTION
################################################################################
# Descriptions...: 價格不可低於標準成本
# Usage..........: CALL axmi129_over_xmaw019()
# Input parameter: p_price   銷售價格
# Date & Author..: 2014/02/11 By lixh
################################################################################
PRIVATE FUNCTION axmi129_over_xmaw019()
   IF g_xmaw_d[l_ac].xmaw020 < g_xmaw_d[l_ac].xmaw019 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00014'
      LET g_errparam.extend = g_xmaw_d[l_ac].xmaw020
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE,'0'
   END IF 

   IF g_xmaw_d[l_ac].xmaw021 < g_xmaw_d[l_ac].xmaw019 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00014'
      LET g_errparam.extend = g_xmaw_d[l_ac].xmaw021
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE,'1'
   END IF 
   
   IF g_xmaw_d[l_ac].xmaw022 < g_xmaw_d[l_ac].xmaw019 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00014'
      LET g_errparam.extend = g_xmaw_d[l_ac].xmaw022
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE,'2'
   END IF 

   IF g_xmaw_d[l_ac].xmaw023 < g_xmaw_d[l_ac].xmaw019 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00014'
      LET g_errparam.extend = g_xmaw_d[l_ac].xmaw023
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE,'3'
   END IF 
   
   RETURN TRUE,''
END FUNCTION
################################################################################
# Descriptions...: 抓取參考料號價格
# Usage..........: CALL axmi129_xmaw_price()
# Date & Author..: 2014/02/11 By lixh
################################################################################
PRIVATE FUNCTION axmi129_xmaw_price()
DEFINE    l_xmaw019     LIKE xmaw_t.xmaw019
DEFINE    l_xmaw020     LIKE xmaw_t.xmaw020
DEFINE    l_xmaw021     LIKE xmaw_t.xmaw021
DEFINE    l_xmaw022     LIKE xmaw_t.xmaw022
DEFINE    l_xmaw023     LIKE xmaw_t.xmaw023

   #dorislai-20150613-modify----(S)         
#   IF g_xmaw_d[l_ac].xmaw014 = 'Y' AND NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND NOT cl_null(g_xmaw_d[l_ac].xmaw015) AND g_xmaw_d[l_ac].xmaw016 IS NOT NULL 
#      AND (NOT cl_null(g_xmaw_d[l_ac].xmaw017) OR NOT cl_null(g_xmaw_d[l_ac].xmaw018)) THEN
#
#      SELECT xmaw019,xmaw020,xmaw021,xmaw022,xmaw023 INTO 
#             l_xmaw019,l_xmaw020,l_xmaw021,l_xmaw022,l_xmaw023
#        FROM xmaw_t       
#       WHERE xmawent = g_enterprise
#         AND xmaw001 = g_xmaw_m.xmaw001
#         AND xmaw002 = g_xmaw_m.xmaw002
#         AND xmaw011 = g_xmaw_d[l_ac].xmaw015
#         AND xmaw012 = g_xmaw_d[l_ac].xmaw016
#         AND xmaw013 = g_xmaw_d[l_ac].xmaw013
#      DISPLAY BY NAME g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020, g_xmaw_d[l_ac].xmaw021,
#                      g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023 
    IF g_xmaw_d[l_ac].xmaw014 = 'Y' AND NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND (NOT cl_null(g_xmaw_d[l_ac].xmaw017) OR NOT cl_null(g_xmaw_d[l_ac].xmaw018)) THEN
      IF cl_null(g_xmaw_d[l_ac].xmaw015) AND cl_null(g_xmaw_d[l_ac].xmaw033) AND cl_null(g_xmaw_d[l_ac].xmaw034) THEN
         RETURN
      END IF
      
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw015) AND g_xmaw_d[l_ac].xmaw016 IS NOT NULL THEN 
         SELECT xmaw019,xmaw020,xmaw021,xmaw022,xmaw023 INTO 
                l_xmaw019,l_xmaw020,l_xmaw021,l_xmaw022,l_xmaw023
           FROM xmaw_t       
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw011 = g_xmaw_d[l_ac].xmaw015
            AND xmaw012 = g_xmaw_d[l_ac].xmaw016
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
      END IF
      
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw033) THEN
         SELECT xmaw019,xmaw020,xmaw021,xmaw022,xmaw023 INTO 
                l_xmaw019,l_xmaw020,l_xmaw021,l_xmaw022,l_xmaw023
           FROM xmaw_t       
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw031 = g_xmaw_d[l_ac].xmaw033
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
      END IF
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw034) THEN
         SELECT xmaw019,xmaw020,xmaw021,xmaw022,xmaw023 INTO 
                l_xmaw019,l_xmaw020,l_xmaw021,l_xmaw022,l_xmaw023
           FROM xmaw_t       
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw032 = g_xmaw_d[l_ac].xmaw034
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
      END IF
      #dorislai-20150613-modify----(E)  
      IF g_xmaw_d[l_ac].xmaw017 > 0 THEN
         LET g_xmaw_d[l_ac].xmaw019 = l_xmaw019 + g_xmaw_d[l_ac].xmaw017 
         LET g_xmaw_d[l_ac].xmaw020 = l_xmaw020 + g_xmaw_d[l_ac].xmaw017 
         LET g_xmaw_d[l_ac].xmaw021 = l_xmaw021 + g_xmaw_d[l_ac].xmaw017 
         LET g_xmaw_d[l_ac].xmaw022 = l_xmaw022 + g_xmaw_d[l_ac].xmaw017 
         LET g_xmaw_d[l_ac].xmaw023 = l_xmaw023 + g_xmaw_d[l_ac].xmaw017 
      END IF
      IF g_xmaw_d[l_ac].xmaw018 > 0 THEN  
         LET g_xmaw_d[l_ac].xmaw019 = l_xmaw019 * (1+g_xmaw_d[l_ac].xmaw018/100)
         LET g_xmaw_d[l_ac].xmaw020 = l_xmaw020 * (1+g_xmaw_d[l_ac].xmaw018/100)
         LET g_xmaw_d[l_ac].xmaw021 = l_xmaw021 * (1+g_xmaw_d[l_ac].xmaw018/100)
         LET g_xmaw_d[l_ac].xmaw022 = l_xmaw022 * (1+g_xmaw_d[l_ac].xmaw018/100)
         LET g_xmaw_d[l_ac].xmaw023 = l_xmaw023 * (1+g_xmaw_d[l_ac].xmaw018/100)         
      END IF   
      IF g_xmaw_d[l_ac].xmaw017 = 0 AND g_xmaw_d[l_ac].xmaw018 = 0 THEN
         LET g_xmaw_d[l_ac].xmaw019 = l_xmaw019  
         LET g_xmaw_d[l_ac].xmaw020 = l_xmaw020  
         LET g_xmaw_d[l_ac].xmaw021 = l_xmaw021 
         LET g_xmaw_d[l_ac].xmaw022 = l_xmaw022  
         LET g_xmaw_d[l_ac].xmaw023 = l_xmaw023  
      END IF 
      #dorislai-20150613-modify----(S)        
      DISPLAY BY NAME g_xmaw_d[l_ac].xmaw019,g_xmaw_d[l_ac].xmaw020, g_xmaw_d[l_ac].xmaw021,
                      g_xmaw_d[l_ac].xmaw022,g_xmaw_d[l_ac].xmaw023
      #dorislai-20150613-modify----(E)  
      
   END IF  


  
   
END FUNCTION
################################################################################
# Descriptions...: 檢查參考料號是否存在本筆資料中
# Usage..........: CALL axmi129_xmaw015_chk()
# Return code....: 回传参数变量1   TRUE/FALSE
# Date & Author..: 2014/02/11 By lixh
################################################################################
PRIVATE FUNCTION axmi129_xmaw015_chk()
DEFINE   l_xmaw001       LIKE xmaw_t.xmaw001
DEFINE   l_xmawstus      LIKE xmaw_t.xmawstus
DEFINE   l_xmaw013       LIKE xmaw_t.xmaw013
DEFINE   l_xmaw015       LIKE xmaw_t.xmaw015
DEFINE   l_xmaw016       LIKE xmaw_t.xmaw016
DEFINE   l_sql           STRING

   IF g_xmaw_d[l_ac].xmaw014 = 'Y' AND NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND NOT cl_null(g_xmaw_d[l_ac].xmaw015) THEN 
   # IF g_xmaw_d[l_ac].xmaw014 = 'Y' THEN
      LET l_sql = " SELECT xmaw001,xmawstus FROM xmaw_t",
                  "  WHERE xmawent = '",g_enterprise,"'" ,
                  "    AND xmaw001 = '",g_xmaw_m.xmaw001,"'",
                  "    AND xmaw002 = '",g_xmaw_m.xmaw002,"'",
                  "    AND (xmaw011 != '",g_xmaw_d[l_ac].xmaw011,"'"," OR xmaw012 != '", g_xmaw_d[l_ac].xmaw012,"')"                    
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw015) THEN 
         LET l_sql = l_sql," AND xmaw011 = '",g_xmaw_d[l_ac].xmaw015,"'"
         IF g_xmaw_d[l_ac].xmaw016 IS NOT NULL THEN 
            LET l_sql = l_sql," AND xmaw012 = '",g_xmaw_d[l_ac].xmaw016,"'"
         END IF 
      END IF

      IF NOT cl_null(g_xmaw_d[l_ac].xmaw013) THEN 
         LET l_sql = l_sql," AND xmaw013 = '",g_xmaw_d[l_ac].xmaw013,"'"
      END IF  
      PREPARE axmi129_xmaw001 FROM l_sql
      EXECUTE axmi129_xmaw001 INTO l_xmaw001,l_xmawstus  
      FREE axmi129_xmaw001  
#     SELECT xmaw001,xmawstus INTO l_xmaw001,l_xmawstus FROM xmaw_t               
#         WHERE xmawent = g_enterprise
#           AND xmaw001 = g_xmaw_m.xmaw001
#           AND xmaw002 = g_xmaw_m.xmaw002
#           AND xmaw011 = g_xmaw_d[l_ac].xmaw015
#           AND xmaw012 = g_xmaw_d[l_ac].xmaw016
#           AND xmaw013 = g_xmaw_d[l_ac].xmaw013
#           AND (xmaw011 != g_xmaw_d[l_ac].xmaw011 OR xmaw012 != g_xmaw_d[l_ac].xmaw012)         
      IF cl_null(l_xmaw001) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00045'
         LET g_errparam.extend = g_xmaw_d[l_ac].xmaw015
         LET g_errparam.popup = TRUE
         CALL cl_err()    
         RETURN FALSE
      END IF
      IF l_xmawstus = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00320'
         LET g_errparam.extend = g_xmaw_d[l_ac].xmaw015
         LET g_errparam.popup = TRUE
         CALL cl_err()
     
         RETURN FALSE
      ELSE
         SELECT xmaw013,xmaw015,xmaw016 INTO l_xmaw013,l_xmaw015,l_xmaw016 FROM xmaw_t
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw011 = g_xmaw_d[l_ac].xmaw015
            AND xmaw012 = g_xmaw_d[l_ac].xmaw016
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw015 = g_xmaw_d[l_ac].xmaw011 AND l_xmaw016 = g_xmaw_d[l_ac].xmaw012 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00160'
            LET g_errparam.extend = g_xmaw_d[l_ac].xmaw015
            LET g_errparam.popup = TRUE
            CALL cl_err()     
            RETURN FALSE            
         END IF          
         RETURN TRUE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 整批產生銷售價格表
# Memo...........:
# Usage..........: CALL axmi129_auto_gene(l_type)
# Date & Author..: 2014/02/14 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_auto_gene(l_type)
   DEFINE   l_type            LIKE type_t.chr1
   DEFINE   g_xmaw001_s       LIKE xmaw_t.xmaw001
   DEFINE   g_xmaw002_s       LIKE xmaw_t.xmaw002 
   DEFINE   l_s_imaa001_t     LIKE imaa_t.imaa001
   DEFINE   l_e_imaa001_t     LIKE imaa_t.imaa001
   DEFINE   l_wc              STRING
   DEFINE   l_wc_1            STRING   

   #畫面開啟 (identifier)
   OPEN WINDOW w_axmi129_s01 WITH FORM cl_ap_formpath("axm","axmi129_s01")
   
   INITIALIZE g_xmaw_s.* TO NULL
   LET l_s_imaa001_t = NULL
   LET l_e_imaa001_t = NULL
   LET g_errshow = 1
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME l_wc ON s_imaa001,e_imaa001

         AFTER FIELD s_imaa001
            LET g_s_imaa001 = GET_FLDBUF(s_imaa001)                       

         ON ACTION controlp INFIELD s_imaa001

	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.arg1 = "ALL"
	        LET g_qryparam.reqry = FALSE
	        LET l_s_imaa001_t = g_s_imaa001
            CALL q_imaf001_8()                         #呼叫開窗
            LET g_s_imaa001 = g_qryparam.return1
            IF cl_null(g_s_imaa001) THEN 
               LET g_s_imaa001 = l_s_imaa001_t
            END IF    
            DISPLAY g_s_imaa001 TO s_imaa001  #顯示到畫面上

            NEXT FIELD s_imaa001

         AFTER FIELD e_imaa001
            LET g_e_imaa001 = GET_FLDBUF(e_imaa001)                          
           
         ON ACTION controlp INFIELD e_imaa001
	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.arg1 = "ALL"
	        LET g_qryparam.reqry = FALSE
	        LET l_e_imaa001_t = g_e_imaa001
            CALL q_imaf001_8()                         #呼叫開窗
            LET g_e_imaa001 = g_qryparam.return1
            IF cl_null(g_e_imaa001) THEN
               LET g_e_imaa001 = l_e_imaa001_t 
            END IF
            DISPLAY g_e_imaa001 TO e_imaa001  #顯示到畫面上

            NEXT FIELD e_imaa001
      END CONSTRUCT
      
      CONSTRUCT BY NAME l_wc_1 ON imaa003,imaf111

         AFTER FIELD imaa003

            

         ON ACTION controlp INFIELD imaa003

	    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上

            NEXT FIELD imaa003

         AFTER FIELD imaf111
         

           
         ON ACTION controlp INFIELD imaf111
	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
            CALL q_imcd111()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf111  #顯示到畫面上
            NEXT FIELD imaf111
            
      END CONSTRUCT      
      
      INPUT BY NAME g_xmaw_s.xmaw001,g_xmaw_s.xmaw002,g_xmaw_s.chk1,
                    g_xmaw_s.xmaw019_1,g_xmaw_s.xmaw019_rate,g_xmaw_s.xmaw019_w,g_xmaw_s.xmaw019_s,g_xmaw_s.xmaw019_r,g_xmaw_s.chk2,
                    g_xmaw_s.xmaw020_rate,g_xmaw_s.xmaw020_w,g_xmaw_s.xmaw020_s,g_xmaw_s.xmaw020_r,
                    g_xmaw_s.xmaw021_1,g_xmaw_s.xmaw021_rate,g_xmaw_s.xmaw021_w,g_xmaw_s.xmaw021_s,g_xmaw_s.xmaw021_r,
                    g_xmaw_s.xmaw022_1,g_xmaw_s.xmaw022_rate,g_xmaw_s.xmaw022_w,g_xmaw_s.xmaw022_s,g_xmaw_s.xmaw022_r,
                    g_xmaw_s.xmaw023_1,g_xmaw_s.xmaw023_rate,g_xmaw_s.xmaw023_w,g_xmaw_s.xmaw023_s,g_xmaw_s.xmaw023_r
                    
         ATTRIBUTE(WITHOUT DEFAULTS)     

         BEFORE INPUT
            INITIALIZE g_xmaw_s.* TO NULL 
            CALL cl_set_combo_scc('xmaw019_1','2075') 
            CALL cl_set_combo_scc_part('xmaw021_1','2076','1,2') 
            CALL cl_set_combo_scc_part('xmaw022_1','2076','1,2,3')
            CALL cl_set_combo_scc_part('xmaw023_1','2076','1,2,3,4')
            LET g_notneed_labeltag = TRUE
            CALL cl_set_combo_scc('xmaw019_w','2078')  
            CALL cl_set_combo_scc('xmaw020_w','2078')
            CALL cl_set_combo_scc('xmaw021_w','2078')
            CALL cl_set_combo_scc('xmaw022_w','2078')
            CALL cl_set_combo_scc('xmaw023_w','2078')
            LET g_notneed_labeltag = FALSE
            
            LET g_xmaw_s.xmaw019_1 = '1'
            LET g_xmaw_s.xmaw021_1 = '2'
            LET g_xmaw_s.xmaw022_1 = '3'
            LET g_xmaw_s.xmaw023_1 = '4'
            LET g_xmaw_s.chk1 = 'N'
            LET g_xmaw_s.chk2 = 'Y'
            IF l_type = 'a' THEN
               LET g_xmaw_s.xmaw001 = g_xmaw_m.xmaw001
               LET g_xmaw_s.xmaw002 = g_xmaw_m.xmaw002
               CALL axmi129_s_xmaw001_ref()
               CALL axmi129_s_xmaw002_ref()
               CALL cl_set_comp_entry("xmaw001,xmaw002",FALSE)  
            ELSE
               CALL cl_set_comp_entry("xmaw001,xmaw002",TRUE)            
            END IF 
                        

         AFTER FIELD xmaw001
            IF NOT cl_null(g_xmaw_s.xmaw001) AND NOT cl_null(g_xmaw_s.xmaw002) THEN
                  LET g_xmaw_s.xmaw001_desc = ''
                  CALL axmi129_xmaw001_ref_1(g_xmaw_s.xmaw001)               
            END IF

            IF NOT cl_null(g_xmaw_s.xmaw001) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmaw_s.xmaw001
                  #160318-00025#17  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="axm-00187:sub-01302|aooi085|",cl_get_progname("aooi085",g_lang,"2"),"|:EXEPROGaooi085"
                  #160318-00025#17  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooal002_15") THEN
                     LET g_xmaw_s.xmaw001 = g_xmaw001_s
                     CALL axmi129_xmaw001_ref_1(g_xmaw_s.xmaw001)
                     NEXT FIELD CURRENT
                  END IF
            END IF
            CALL axmi129_xmaw001_ref_1(g_xmaw_s.xmaw001)
            
         AFTER FIELD xmaw002
            IF NOT cl_null(g_xmaw_s.xmaw001) AND NOT cl_null(g_xmaw_s.xmaw002) THEN 
                  LET g_xmaw_s.xmaw002_desc = ''
                  CALL axmi129_xmaw002_ref_1(g_xmaw_s.xmaw002) 
            END IF

            IF NOT cl_null(g_xmaw_s.xmaw002) THEN
                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = 'ALL'
                  LET g_chkparam.arg1 = g_site   #add by lixh 20150323
                  LET g_chkparam.arg2 = g_xmaw_s.xmaw002
                  #160318-00025#17  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#17  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_xmaw_s.xmaw002 = g_xmaw002_s
                     CALL axmi129_xmaw002_ref_1(g_xmaw_s.xmaw002)
                     NEXT FIELD CURRENT
                  END IF
            END IF
            CALL axmi129_xmaw002_ref_1(g_xmaw_s.xmaw002)
            
         AFTER FIELD chk1   
         
         AFTER FIELD xmaw019_1
         
            IF NOT cl_null(g_xmaw_s.xmaw019_1) THEN 
            
               IF g_xmaw_s.xmaw019_1 = '1' THEN
               END IF
               IF g_xmaw_s.xmaw019_1 = '2' THEN
               END IF
               IF g_xmaw_s.xmaw019_1 = '3' THEN
                     
               END IF   
               
            END IF          
         AFTER FIELD xmaw019_rate
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw019_rate,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw019_rate
            END IF
            
         AFTER FIELD xmaw019_w

            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw019_w,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw019_w
            END IF
            
         AFTER FIELD xmaw019_s
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw019_s,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw019_s
            END IF
            IF NOT cl_null(g_xmaw_s.xmaw019_s) THEN
               LET g_xmaw_s.xmaw019_r = g_xmaw_s.xmaw019_s + 1
               IF g_xmaw_s.xmaw019_r =10 THEN 
                  LET g_xmaw_s.xmaw019_r = '' 
               END IF                              
               DISPLAY g_xmaw_s.xmaw019_r TO xmaw019_r
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw019_s,g_xmaw_s.xmaw019_r)  
            END IF            
            
         AFTER FIELD xmaw019_r
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw019_r,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw019_r
            END IF
            IF NOT cl_null(g_xmaw_s.xmaw019_r) THEN 
               LET g_xmaw_s.xmaw019_s = g_xmaw_s.xmaw019_r - 1
               IF g_xmaw_s.xmaw019_s = -1 THEN
                  LET g_xmaw_s.xmaw019_s = ''
               END IF
               DISPLAY g_xmaw_s.xmaw019_s TO xmaw019_s               
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw019_s,g_xmaw_s.xmaw019_r) 
            END IF               
            


         AFTER FIELD chk2
         
         AFTER FIELD xmaw020_rate
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw020_rate,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw020_rate
            END IF
            
         AFTER FIELD xmaw020_w

            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw020_w,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw020_w
            END IF
            
         AFTER FIELD xmaw020_s
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw020_s,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw020_s
            END IF
            IF NOT cl_null(g_xmaw_s.xmaw020_s) THEN
               LET g_xmaw_s.xmaw020_r = g_xmaw_s.xmaw020_s + 1
               IF g_xmaw_s.xmaw020_r =10 THEN 
                  LET g_xmaw_s.xmaw020_r = '' 
               END IF 
               DISPLAY g_xmaw_s.xmaw020_r TO xmaw020_r  
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw020_s,g_xmaw_s.xmaw020_r)               
            END IF
            
         AFTER FIELD xmaw020_r
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw020_r,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw020_r
            END IF       
            IF NOT cl_null(g_xmaw_s.xmaw020_r) THEN 
               LET g_xmaw_s.xmaw020_s = g_xmaw_s.xmaw020_r - 1
               IF g_xmaw_s.xmaw020_s = -1 THEN
                  LET g_xmaw_s.xmaw020_s = ''
               END IF
               DISPLAY g_xmaw_s.xmaw020_s TO xmaw020_s
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw020_s,g_xmaw_s.xmaw020_r)
            END IF 
            
         AFTER FIELD xmaw021_1
         
         AFTER FIELD xmaw021_rate
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw021_rate,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw021_rate
            END IF
            
         AFTER FIELD xmaw021_w

            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw021_w,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw021_w
            END IF
            
         AFTER FIELD xmaw021_s
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw021_s,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw021_s
            END IF
            IF NOT cl_null(g_xmaw_s.xmaw021_s) THEN
               LET g_xmaw_s.xmaw021_r = g_xmaw_s.xmaw021_s + 1
               IF g_xmaw_s.xmaw021_r =10 THEN 
                  LET g_xmaw_s.xmaw021_r = '' 
               END IF 
               DISPLAY g_xmaw_s.xmaw021_r TO xmaw021_r 
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw021_s,g_xmaw_s.xmaw021_r)               
            END IF             
            
         AFTER FIELD xmaw021_r
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw021_r,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw021_r
            END IF
            IF NOT cl_null(g_xmaw_s.xmaw021_r) THEN 
               LET g_xmaw_s.xmaw021_s = g_xmaw_s.xmaw021_r - 1
               IF g_xmaw_s.xmaw021_s = -1 THEN
                  LET g_xmaw_s.xmaw021_s = ''
               END IF
               DISPLAY g_xmaw_s.xmaw021_s TO xmaw021_s
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw021_s,g_xmaw_s.xmaw021_r)  
            END IF             
            
         AFTER FIELD xmaw022_1
         
         AFTER FIELD xmaw022_rate
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw022_rate,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw022_rate
            END IF
            
         AFTER FIELD xmaw022_w

            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw022_w,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw022_w
            END IF
            
         AFTER FIELD xmaw022_s
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw022_s,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw022_s
            END IF
            IF NOT cl_null(g_xmaw_s.xmaw022_s) THEN
               LET g_xmaw_s.xmaw022_r = g_xmaw_s.xmaw022_s + 1
               IF g_xmaw_s.xmaw022_r =10 THEN 
                  LET g_xmaw_s.xmaw022_r = '' 
               END IF  
               DISPLAY g_xmaw_s.xmaw022_r TO xmaw022_r 
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw022_s,g_xmaw_s.xmaw022_r)                 
            END IF            
            
         AFTER FIELD xmaw022_r
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw022_r,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw022_r
            END IF
            IF NOT cl_null(g_xmaw_s.xmaw022_r) THEN 
               LET g_xmaw_s.xmaw022_s = g_xmaw_s.xmaw022_r - 1
               IF g_xmaw_s.xmaw022_s = -1 THEN
                  LET g_xmaw_s.xmaw022_s = ''
               END IF
               DISPLAY g_xmaw_s.xmaw022_s TO xmaw022_s
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw022_s,g_xmaw_s.xmaw022_r)  
            END IF             
            
         AFTER FIELD xmaw023_1
         
         AFTER FIELD xmaw023_rate
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw023_rate,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw023_rate
            END IF
            
         AFTER FIELD xmaw023_w

            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw023_w,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xmaw023_w
            END IF
            
         AFTER FIELD xmaw023_s
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw023_s,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw023_s
            END IF
            IF NOT cl_null(g_xmaw_s.xmaw023_s) THEN
               LET g_xmaw_s.xmaw023_r = g_xmaw_s.xmaw023_s + 1
               IF g_xmaw_s.xmaw023_r =10 THEN 
                  LET g_xmaw_s.xmaw023_r = '' 
               END IF 
               DISPLAY g_xmaw_s.xmaw023_r TO xmaw023_r
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw023_s,g_xmaw_s.xmaw023_r)                 
            END IF            
            
         AFTER FIELD xmaw023_r
            IF NOT cl_ap_chk_Range(g_xmaw_s.xmaw023_r,"0","1","9","1","azz-00087",1) THEN
               NEXT FIELD xmaw023_r
            END IF 
            IF NOT cl_null(g_xmaw_s.xmaw023_r) THEN 
               LET g_xmaw_s.xmaw023_s = g_xmaw_s.xmaw023_r - 1
               IF g_xmaw_s.xmaw023_s = -1 THEN
                  LET g_xmaw_s.xmaw023_s = ''
               END IF
               DISPLAY g_xmaw_s.xmaw023_s TO xmaw023_s
               CALL axmi129_xmaw_desc(g_xmaw_s.xmaw023_s,g_xmaw_s.xmaw023_r) 
            END IF              


         ON ACTION controlp INFIELD xmaw001

	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	        LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmaw_s.xmaw001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "15" 

            CALL q_ooal002_0()                                     #呼叫開窗

            LET g_xmaw_s.xmaw001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmaw_s.xmaw001 TO xmaw001                    #顯示到畫面上

            NEXT FIELD xmaw001                                     #返回原欄位


         ON ACTION controlp INFIELD xmaw002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	        LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xmaw_s.xmaw002             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = 'ALL' 
            LET g_qryparam.arg1 = g_site   #add by lixh 20150323
            CALL q_ooaj002_1()                                     #呼叫開窗

            LET g_xmaw_s.xmaw002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmaw_s.xmaw002 TO xmaw002                    #顯示到畫面上

            NEXT FIELD xmaw002 
         END INPUT 
      
         ON ACTION accept
            ACCEPT DIALOG

         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG   
            
      END DIALOG 
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
      ELSE
         CALL axmi129_auto_gene_xmaw(l_wc_1)
         CALL axmi129_show()
      END IF
   
   #畫面關閉
   CLOSE WINDOW w_axmi129_s01
   
END FUNCTION
################################################################################
# Descriptions...: 更新單身資料
# Memo...........:
# Usage..........: CALL axmi129_xmaw_upd(p_xmaw001,p_xmaw002,p_xmaw011,p_xmaw012,p_xmaw013,p_xmaw019,p_xmaw020,p_xmaw021,p_xmaw022,p_xmaw023)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/02/26 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw_upd(p_xmaw001,p_xmaw002,p_xmaw011,p_xmaw012,p_xmaw031,p_xmaw032,p_xmaw013,p_xmaw019,p_xmaw020,p_xmaw021,p_xmaw022,p_xmaw023)
#dorislai-20150626-modify---(S)  
#PRIVATE FUNCTION axmi129_xmaw_upd(p_xmaw001,p_xmaw002,p_xmaw011,p_xmaw012,p_xmaw013,p_xmaw019,p_xmaw020,p_xmaw021,p_xmaw022,p_xmaw023)
#dorislai-20150626-modify---(E)  
DEFINE  p_xmaw001             LIKE xmaw_t.xmaw001
DEFINE  p_xmaw002             LIKE xmaw_t.xmaw002
DEFINE  p_xmaw011             LIKE xmaw_t.xmaw011
DEFINE  p_xmaw012             LIKE xmaw_t.xmaw012
#dorislai-20150626-add---(S)  
DEFINE  p_xmaw031             LIKE xmaw_t.xmaw031
DEFINE  p_xmaw032             LIKE xmaw_t.xmaw032
#dorislai-20150626-add---(E)  
DEFINE  p_xmaw013             LIKE xmaw_t.xmaw013
DEFINE  p_xmaw019             LIKE xmaw_t.xmaw019
DEFINE  p_xmaw020             LIKE xmaw_t.xmaw020
DEFINE  p_xmaw021             LIKE xmaw_t.xmaw021
DEFINE  p_xmaw022             LIKE xmaw_t.xmaw022
DEFINE  p_xmaw023             LIKE xmaw_t.xmaw023
DEFINE  l_sql                 STRING
DEFINE  sr                    DYNAMIC ARRAY OF RECORD
        xmaw011               LIKE xmaw_t.xmaw011,
        xmaw012               LIKE xmaw_t.xmaw012,
        #dorislai-20150626-add---(S)  
        xmaw031               LIKE xmaw_t.xmaw031,
        xmaw032               LIKE xmaw_t.xmaw032,
        #dorislai-20150626-add---(E)  
        xmaw013               LIKE xmaw_t.xmaw013,
        xmaw015               LIKE xmaw_t.xmaw015,
        xmaw016               LIKE xmaw_t.xmaw016,
        xmaw017               LIKE xmaw_t.xmaw017,
        xmaw018               LIKE xmaw_t.xmaw018
                              END RECORD
DEFINE l_ac                   LIKE type_t.num5
DEFINE l_i                    LIKE type_t.num5
DEFINE l_xmaw019              LIKE xmaw_t.xmaw019
DEFINE l_xmaw020              LIKE xmaw_t.xmaw020
DEFINE l_xmaw021              LIKE xmaw_t.xmaw021
DEFINE l_xmaw022              LIKE xmaw_t.xmaw022
DEFINE l_xmaw023              LIKE xmaw_t.xmaw023
   #dorislai-20150626-modify---(S)
   
#   LET l_sql =" SELECT xmaw011,xmaw012,xmaw013,xmaw015,xmaw016,xmaw017,xmaw018 FROM xmaw_t ",
#              "  WHERE xmawent='",g_enterprise,"' AND xmaw001='",p_xmaw001,"' AND xmaw002='",p_xmaw002,"'",
#              "    AND xmaw013='",p_xmaw013,"' AND xmaw015='",p_xmaw011,"' AND xmaw016='",p_xmaw012,"'",
#              "    AND (xmaw011 != '",p_xmaw011,"' OR xmaw012 != '",p_xmaw012,"')",
#              "    AND xmaw014 = 'Y'"
   LET l_sql =" SELECT xmaw011,xmaw012,xmaw031,xmaw032,xmaw013,xmaw015,xmaw016,xmaw017,xmaw018 FROM xmaw_t ",
              "  WHERE xmawent='",g_enterprise,"' AND xmaw001='",p_xmaw001,"' AND xmaw002='",p_xmaw002,"'",
              "    AND xmaw013='",p_xmaw013,"'    AND xmaw014 = 'Y'"
         
   IF NOT cl_null(p_xmaw011) THEN
      LET l_sql = l_sql clipped," AND xmaw015='",p_xmaw011,"'"
      IF NOT cl_null(p_xmaw012) THEN
         LET l_sql = l_sql clipped," AND xmaw016='",p_xmaw012,"'"
      END IF
   END IF
   IF NOT cl_null(p_xmaw031) THEN
      LET l_sql = l_sql clipped," AND xmaw033='",p_xmaw031,"'"
   END IF
   IF NOT cl_null(p_xmaw032) THEN
      LET l_sql = l_sql clipped," AND xmaw034='",p_xmaw032,"'"
   END IF
   #dorislai-20150626-modify----(E)
   PREPARE axmi129_xmaw_upd_pre FROM l_sql
   DECLARE axmi129_xmaw_upd_cs CURSOR FOR axmi129_xmaw_upd_pre
   LET l_ac = 1
   #161109-00085#11-s mod
#   FOREACH axmi129_xmaw_upd_cs INTO sr[l_ac].*   #161109-00085#11-s mark
   FOREACH axmi129_xmaw_upd_cs INTO sr[l_ac].xmaw011,sr[l_ac].xmaw012,sr[l_ac].xmaw031,sr[l_ac].xmaw032,sr[l_ac].xmaw013,
                                    sr[l_ac].xmaw015,sr[l_ac].xmaw016,sr[l_ac].xmaw017,sr[l_ac].xmaw018
   #161109-00085#11-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   IF l_ac = 1 THEN
      RETURN
   END IF 
   
   FOR l_i = 1 TO l_ac -1 
      IF NOT cl_null(sr[l_i].xmaw017) THEN
         LET l_xmaw019 = p_xmaw019 + sr[l_i].xmaw017
         LET l_xmaw020 = p_xmaw020 + sr[l_i].xmaw017
         LET l_xmaw021 = p_xmaw021 + sr[l_i].xmaw017      
         LET l_xmaw022 = p_xmaw022 + sr[l_i].xmaw017
         LET l_xmaw023 = p_xmaw023 + sr[l_i].xmaw017
      END IF 
      IF NOT cl_null(sr[l_i].xmaw018) THEN
         LET l_xmaw019 = p_xmaw019 * (1 + sr[l_i].xmaw018/100)
         LET l_xmaw020 = p_xmaw020 * (1 + sr[l_i].xmaw018/100)
         LET l_xmaw021 = p_xmaw021 * (1 + sr[l_i].xmaw018/100)
         LET l_xmaw022 = p_xmaw022 * (1 + sr[l_i].xmaw018/100)
         LET l_xmaw023 = p_xmaw023 * (1 + sr[l_i].xmaw018/100)
      END IF
      IF cl_null(l_xmaw019) THEN LET l_xmaw019 = 0 END IF
      IF cl_null(l_xmaw020) THEN LET l_xmaw020 = 0 END IF
      IF cl_null(l_xmaw021) THEN LET l_xmaw021 = 0 END IF
      IF cl_null(l_xmaw022) THEN LET l_xmaw022 = 0 END IF
      IF cl_null(l_xmaw023) THEN LET l_xmaw023 = 0 END IF
      #dorislai-20150626-modify---(S)   
#      UPDATE xmaw_t SET xmaw019 = l_xmaw019,
#                        xmaw020 = l_xmaw020,
#                        xmaw021 = l_xmaw021,
#                        xmaw022 = l_xmaw022,
#                        xmaw023 = l_xmaw023                                               
#       WHERE xmawent = g_enterprise 
#         AND xmaw001=p_xmaw001 
#         AND xmaw002=p_xmaw002
#         AND xmaw011=sr[l_i].xmaw011 
#         AND xmaw012=sr[l_i].xmaw012 
#         AND xmaw013=sr[l_i].xmaw013
      UPDATE xmaw_t SET xmaw019 = l_xmaw019,
                        xmaw020 = l_xmaw020,
                        xmaw021 = l_xmaw021,
                        xmaw022 = l_xmaw022,
                        xmaw023 = l_xmaw023                                               
       WHERE xmawent = g_enterprise 
         AND xmaw001=p_xmaw001 
         AND xmaw002=p_xmaw002
         AND xmaw011=sr[l_i].xmaw011 
         AND xmaw012=sr[l_i].xmaw012
         AND xmaw031=sr[l_i].xmaw031 
         AND xmaw032=sr[l_i].xmaw032         
         AND xmaw013=sr[l_i].xmaw013
      #dorislai-20150626-modify---(E) 
         
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd xmaw_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      #dorislai-20150626-modify---(S)
#      CALL axmi129_xmaw_upd(p_xmaw001,p_xmaw002,sr[l_i].xmaw011,sr[l_i].xmaw012,sr[l_i].xmaw013,l_xmaw019,l_xmaw020,l_xmaw021,l_xmaw022,l_xmaw023)

      CALL axmi129_xmaw_upd(p_xmaw001,p_xmaw002,sr[l_i].xmaw011,sr[l_i].xmaw012,sr[l_i].xmaw031,sr[l_i].xmaw032,sr[l_i].xmaw013,l_xmaw019,l_xmaw020,l_xmaw021,l_xmaw022,l_xmaw023)
      #dorislai-20150626-modify---(E)
   END FOR
END FUNCTION
################################################################################
# Descriptions...: 帶出品名規格
# Memo...........:
# Usage..........: CALL axmi129_xmaw015_ref()
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
################################################################################
PRIVATE FUNCTION axmi129_xmaw015_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw015
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xmaw_d[l_ac].xmaw015_desc = '', g_rtn_fields[1] , ''
            LET g_xmaw_d[l_ac].xmaw015_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw015_desc 
            DISPLAY BY NAME g_xmaw_d[l_ac].xmaw015_desc_desc
END FUNCTION
################################################################################
# Descriptions...: 整批產生xmaw_t的資料
# Memo...........:
# Usage..........: CALL axmi129_auto_gene_xmaw(p_wc)
# Input parameter: p_wc   查詢條件
# Date & Author..: 2014/02/17 By lixh
################################################################################
PRIVATE FUNCTION axmi129_auto_gene_xmaw(p_wc)
DEFINE    p_wc        STRING  
DEFINE    l_sql       STRING
DEFINE    l_imaa001   LIKE imaa_t.imaa001

#161109-00085#11-mod-s
#DEFINE    l_xmaw      RECORD LIKE xmaw_t.*   #161109-00085#11   mark
DEFINE    l_xmaw      RECORD  #銷售價格表檔
       xmawent LIKE xmaw_t.xmawent, #企業編號
       xmaw001 LIKE xmaw_t.xmaw001, #銷售價格參照表號
       xmaw002 LIKE xmaw_t.xmaw002, #基礎幣別
       xmaw011 LIKE xmaw_t.xmaw011, #料件編號
       xmaw012 LIKE xmaw_t.xmaw012, #產品特徵
       xmaw013 LIKE xmaw_t.xmaw013, #計價單位
       xmaw014 LIKE xmaw_t.xmaw014, #參考資料否
       xmaw015 LIKE xmaw_t.xmaw015, #參考料號
       xmaw016 LIKE xmaw_t.xmaw016, #參考料號產品特徵
       xmaw017 LIKE xmaw_t.xmaw017, #加金額
       xmaw018 LIKE xmaw_t.xmaw018, #加百分比
       xmaw019 LIKE xmaw_t.xmaw019, #標準成本
       xmaw020 LIKE xmaw_t.xmaw020, #銷售底價
       xmaw021 LIKE xmaw_t.xmaw021, #業務底價
       xmaw022 LIKE xmaw_t.xmaw022, #一般售價
       xmaw023 LIKE xmaw_t.xmaw023, #標準定價
       xmaw100 LIKE xmaw_t.xmaw100, #申請單號
       xmawstus LIKE xmaw_t.xmawstus, #資料狀態碼
       xmawownid LIKE xmaw_t.xmawownid, #資料所有者
       xmawowndp LIKE xmaw_t.xmawowndp, #資料所屬部門
       xmawcrtid LIKE xmaw_t.xmawcrtid, #資料建立者
       xmawcrtdp LIKE xmaw_t.xmawcrtdp, #資料建立部門
       xmawcrtdt LIKE xmaw_t.xmawcrtdt, #資料創建日
       xmawmodid LIKE xmaw_t.xmawmodid, #資料修改者
       xmawmoddt LIKE xmaw_t.xmawmoddt, #最近修改日
       xmaw031 LIKE xmaw_t.xmaw031, #系列
       xmaw032 LIKE xmaw_t.xmaw032, #產品分類
       xmaw033 LIKE xmaw_t.xmaw033, #參考系列
       xmaw034 LIKE xmaw_t.xmaw034 #參考產品分類
          END RECORD
#161109-00085#11-mod-e
DEFINE    l_xmaw001   LIKE xmaw_t.xmaw001
DEFINE    l_xmaw002   LIKE xmaw_t.xmaw002
DEFINE    l_xmaw011   LIKE xmaw_t.xmaw011
DEFINE    l_xmaw012   LIKE xmaw_t.xmaw012
DEFINE    l_xmaw013   LIKE xmaw_t.xmaw013
DEFINE    l_xmaw019   LIKE xmaw_t.xmaw019
DEFINE    l_xmaw020   LIKE xmaw_t.xmaw020
DEFINE    l_xmaw021   LIKE xmaw_t.xmaw021
DEFINE    l_xmaw022   LIKE xmaw_t.xmaw022 
DEFINE    l_xmaw023   LIKE xmaw_t.xmaw023
DEFINE    l_xmaw031   LIKE xmaw_t.xmaw031
DEFINE    l_xmaw032   LIKE xmaw_t.xmaw032
DEFINE    l_xmaw033   LIKE xmaw_t.xmaw033
DEFINE    l_xmaw034   LIKE xmaw_t.xmaw034
DEFINE    l_xmaw017_s LIKE xmaw_t.xmaw017 
DEFINE    l_xmaw018_s LIKE xmaw_t.xmaw018
DEFINE    l_xmaw019_s LIKE xmaw_t.xmaw019
DEFINE    l_xmaw020_s LIKE xmaw_t.xmaw020
DEFINE    l_xmaw021_s LIKE xmaw_t.xmaw021
DEFINE    l_xmaw022_s LIKE xmaw_t.xmaw022
DEFINE    l_xmaw023_s LIKE xmaw_t.xmaw023
DEFINE    m_xmaw019   LIKE xmaw_t.xmaw019
DEFINE    m_xmaw020   LIKE xmaw_t.xmaw020
DEFINE    m_xmaw021   LIKE xmaw_t.xmaw021
DEFINE    m_xmaw022   LIKE xmaw_t.xmaw022 
DEFINE    m_xmaw023   LIKE xmaw_t.xmaw023
DEFINE    l_cnt       LIKE type_t.num5
DEFINE    r_success   LIKE type_t.chr1
DEFINE    l_price021  LIKE xmaw_t.xmaw021
DEFINE    l_price022  LIKE xmaw_t.xmaw022
DEFINE    l_price023  LIKE xmaw_t.xmaw023
DEFINE    l_xccc003   LIKE xccc_t.xccc003   #add by lixh 20150521
DEFINE    l_success   LIKE type_t.chr1
DEFINE    r_flag      LIKE type_t.chr1
   LET r_flag = 'N'
   IF cl_null(p_wc) THEN LET p_wc = "1=1" END IF
   LET l_sql = " SELECT imaa001 FROM imaa_t,imaf_t",
               "  WHERE imaaent = imafent ",
               "    AND imaa001 = imaf001" , 
               "    AND imaaent = '",g_enterprise,"'",               
               "    AND imafsite = 'ALL'",
               "    AND imaa001 = imaf001",
               "    AND imaastus = 'Y'",
               "    AND ", p_wc  
   IF NOT cl_null(g_s_imaa001) AND NOT cl_null(g_e_imaa001) THEN               
      LET l_sql = l_sql," AND imaa001 BETWEEN '",g_s_imaa001,"'", " AND '",g_e_imaa001,"'"
   END IF          
   IF NOT cl_null(g_s_imaa001) AND cl_null(g_e_imaa001) THEN
      LET l_sql = l_sql," AND imaa001 = '",g_s_imaa001,"'"
   END IF     
   IF cl_null(g_s_imaa001) AND NOT cl_null(g_e_imaa001) THEN
      LET l_sql = l_sql," AND imaa001 = '",g_e_imaa001,"'"
   END IF 
   
   PREPARE axmi129_s01_pre FROM l_sql
   DECLARE axmi129_s01_cur CURSOR FOR axmi129_s01_pre
   LET r_success = 'Y'
   CALL s_transaction_begin()
   CALL cl_err_collect_init()   #add by lixh 21050623
   FOREACH axmi129_s01_cur INTO l_imaa001
      INITIALIZE g_chkparam.* TO NULL               
      LET g_chkparam.arg1 = l_imaa001
      #160318-00025#17  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
      LET g_chkparam.err_str[2] ="aim-00121:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
      #160318-00025#17  by 07900 --add-end
      #呼叫檢查存在的library
      IF NOT cl_chk_exist("v_imaf001_4") THEN
         CONTINUE FOREACH
      END IF   
      SELECT COUNT(xmaw001) INTO l_cnt FROM xmaw_t 
       WHERE xmawent = g_enterprise
         AND xmaw011 = l_imaa001
         AND xmaw001 = g_xmaw_s.xmaw001
         AND xmaw002 = g_xmaw_s.xmaw002
         
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0  AND g_xmaw_s.chk1 = 'Y' THEN
         CONTINUE FOREACH
      END IF 
      #add by lixh 20150521      
      IF g_xmaw_s.xmaw019_1 = '1' THEN   #產品標準成本檔
         SELECT DISTINCT xcat001 INTO l_xccc003 FROM xcat_t WHERE xcatent = g_enterprise AND xcat005='1' AND rownum=1
         CALL s_cost_price_get_item_cost(g_site,'','',l_xccc003,'','',l_imaa001,'','','','','') 
              RETURNING l_success,g_xmaw_s.xmaw019
         IF NOT l_success AND g_xmaw_s.chk2 = 'Y' THEN
            CONTINUE FOREACH
         ELSE  
            LET g_xmaw_s.xmaw019 = 0
         END IF            
      END IF
      
      IF g_xmaw_s.xmaw019_1 = '2' THEN   #上期成本單價
         #抓取任一月加權平均的成本類型編號
         SELECT DISTINCT xcat001 INTO l_xccc003 FROM xcat_t WHERE xcatent = g_enterprise AND xcat005='5' AND rownum=1
         CALL s_cost_price_get_item_cost(g_site,'','',l_xccc003,'','',l_imaa001,'','','','','') 
              RETURNING l_success,g_xmaw_s.xmaw019   
         IF NOT l_success AND g_xmaw_s.chk2 = 'Y' THEN
            CONTINUE FOREACH
         ELSE  
            LET g_xmaw_s.xmaw019 = 0
         END IF                
      END IF      
      #add by lixh 20150521
      IF g_xmaw_s.xmaw019_1 = '3' THEN   #最近採購價  #add by lixh 20150521
         SELECT imai021 INTO g_xmaw_s.xmaw019 FROM imai_t
          WHERE imaient = g_enterprise
            AND imai001 = l_imaa001 
            AND imai035 IN (SELECT MAX(imai035) FROM imai_t WHERE imaient = g_enterprise AND imai001 = l_imaa001) 
      
         IF SQLCA.sqlcode = 100 OR cl_null(g_xmaw_s.xmaw019) THEN
            IF g_xmaw_s.chk2 = 'Y' THEN
               CONTINUE FOREACH
            ELSE
               LET g_xmaw_s.xmaw019 = 0       
            END IF         
         END IF
      END IF   #add by lixh 20150521
      #順序不可顛倒
      CALL axmi129_get_price(g_xmaw_s.xmaw019,g_xmaw_s.xmaw019_rate,g_xmaw_s.xmaw019_w,g_xmaw_s.xmaw019_s,g_xmaw_s.xmaw019_r)
           RETURNING g_xmaw_s.xmaw019
      CALL axmi129_get_price(g_xmaw_s.xmaw019,g_xmaw_s.xmaw020_rate,g_xmaw_s.xmaw020_w,g_xmaw_s.xmaw020_s,g_xmaw_s.xmaw020_r)
           RETURNING g_xmaw_s.xmaw020  
      IF g_xmaw_s.xmaw021_1 = '1' THEN
         LET l_price021= g_xmaw_s.xmaw019         
      END IF
      IF g_xmaw_s.xmaw021_1 = '2' THEN
         LET l_price021= g_xmaw_s.xmaw020 
      END IF   
      CALL axmi129_get_price(l_price021,g_xmaw_s.xmaw021_rate,g_xmaw_s.xmaw021_w,g_xmaw_s.xmaw021_s,g_xmaw_s.xmaw021_r)
           RETURNING g_xmaw_s.xmaw021      
      IF g_xmaw_s.xmaw022_1 = '1' THEN
         LET l_price022= g_xmaw_s.xmaw019         
      END IF
      IF g_xmaw_s.xmaw022_1 = '2' THEN
         LET l_price022= g_xmaw_s.xmaw020 
      END IF  
      IF g_xmaw_s.xmaw022_1 = '3' THEN
         LET l_price022= g_xmaw_s.xmaw021
      END IF  
      CALL axmi129_get_price(l_price022,g_xmaw_s.xmaw022_rate,g_xmaw_s.xmaw022_w,g_xmaw_s.xmaw022_s,g_xmaw_s.xmaw022_r)
           RETURNING g_xmaw_s.xmaw022      

      IF g_xmaw_s.xmaw023_1 = '1' THEN
         LET l_price023= g_xmaw_s.xmaw019         
      END IF
      IF g_xmaw_s.xmaw023_1 = '2' THEN
         LET l_price023= g_xmaw_s.xmaw020 
      END IF  
      IF g_xmaw_s.xmaw023_1 = '3' THEN
         LET l_price023= g_xmaw_s.xmaw021
      END IF
      IF g_xmaw_s.xmaw023_1 = '4' THEN
         LET l_price023= g_xmaw_s.xmaw022
      END IF      
      CALL axmi129_get_price(l_price023,g_xmaw_s.xmaw023_rate,g_xmaw_s.xmaw023_w,g_xmaw_s.xmaw023_s,g_xmaw_s.xmaw023_r)
           RETURNING g_xmaw_s.xmaw023      
 
      IF l_cnt > 0  AND g_xmaw_s.chk1 = 'N' THEN  
         LET r_flag = 'Y'   #add by lixh 20150525
         UPDATE xmaw_t SET xmaw017 = '',
                           xmaw018 = '',
                           xmaw019 = g_xmaw_s.xmaw019,
                           xmaw020 = g_xmaw_s.xmaw020,
                           xmaw021 = g_xmaw_s.xmaw021,
                           xmaw022 = g_xmaw_s.xmaw022,
                           xmaw023 = g_xmaw_s.xmaw023
          WHERE xmawent = g_enterprise
            AND xmaw011 = l_imaa001
            AND xmaw001 = g_xmaw_s.xmaw001
            AND xmaw002 = g_xmaw_s.xmaw002
            
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
            LET r_success = 'N' 
         END IF  
         
         LET l_sql = " SELECT xmaw011,xmaw012,xmaw013 FROM xmaw_t ", 
                     "  WHERE xmawent = '",g_enterprise,"'",
                     "    AND xmaw011 = '",l_imaa001,"'",
                     "    AND xmaw001 = '",g_xmaw_s.xmaw001,"'",
                     "    AND xmaw002 = '",g_xmaw_s.xmaw002,"'"
         PREPARE axmi129_s01_pre01 FROM l_sql
         DECLARE axmi129_s01_cur01 CURSOR FOR axmi129_s01_pre01
         
         LET l_sql = " SELECT xmaw017,xmaw018,xmaw019,xmaw020,xmaw021,xmaw022,xmaw023 FROM xmaw_t FROM xmaw_t ",
                     "  WHERE xmawent = '",g_enterprise,"'",
                     "    AND xmaw001 = '",g_xmaw_s.xmaw001,"'",
                     "    AND xmaw002 = '",g_xmaw_s.xmaw002,"'",
                     "    AND xmaw013 = ? ",
                     "    AND xmaw015 = ? ",
                     "    AND xmaw016 = ? ",
                     #dorislai-20150626-add----(S)
                     "    AND xmaw033 = ? ",
                     "    AND xmaw034 = ? ",
                     #dorislai-20150626-end----(E)
                     "    AND (xmaw011 != ? OR xmaw012 != ?) " 
         PREPARE axmi129_s01_pre02 FROM l_sql
         DECLARE axmi129_s01_cur02 CURSOR FOR axmi129_s01_pre02
         #dorislai-2150626-modify----(S)
#         FOREACH axmi129_s01_cur01 INTO l_xmaw011,l_xmaw012,l_xmaw013
#            EXECUTE axmi129_s01_cur02 USING l_xmaw013,l_xmaw011,l_xmaw012 
#                                      INTO l_xmaw017_s,l_xmaw018_s,l_xmaw019_s,l_xmaw020_s,l_xmaw021_s,l_xmaw022_s,l_xmaw023_s
#               UPDATE xmaw_t SET xmaw014 = 'N',
#                                 xmaw015 = l_xmaw011,
#                                 xmaw016 = l_xmaw012
#                WHERE xmawent = g_enterprise
#                  AND xmaw011 = l_xmaw011
#                  AND xmaw012 = l_xmaw012
#                  AND xmaw013 = l_xmaw013
#                  AND xmaw001 = g_xmaw_s.xmaw001
#                  AND xmaw002 = g_xmaw_s.xmaw002                                      
#               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
#                  LET r_success = 'N' 
#               END IF                                        
#               CALL axmi129_xmaw_upd(g_xmaw_s.xmaw001,g_xmaw_s.xmaw002,l_xmaw011,l_xmaw012,l_xmaw013,l_xmaw019_s,l_xmaw020_s,l_xmaw021_s,l_xmaw022_s,l_xmaw023_s)
         FOREACH axmi129_s01_cur01 INTO l_xmaw011,l_xmaw012,l_xmaw031,l_xmaw032,l_xmaw013
            EXECUTE axmi129_s01_cur02 USING l_xmaw013,l_xmaw011,l_xmaw012,l_xmaw031,l_xmaw032
                                      INTO l_xmaw017_s,l_xmaw018_s,l_xmaw019_s,l_xmaw020_s,l_xmaw021_s,l_xmaw022_s,l_xmaw023_s
               UPDATE xmaw_t SET xmaw014 = 'N',
                                 xmaw015 = l_xmaw011,
                                 xmaw016 = l_xmaw012
                WHERE xmawent = g_enterprise
                  AND xmaw011 = l_xmaw011
                  AND xmaw012 = l_xmaw012
                  AND xmaw011 = l_xmaw031
                  AND xmaw012 = l_xmaw032
                  AND xmaw013 = l_xmaw013
                  AND xmaw001 = g_xmaw_s.xmaw001
                  AND xmaw002 = g_xmaw_s.xmaw002                                      
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
                  LET r_success = 'N' 
               END IF                                        
               CALL axmi129_xmaw_upd(g_xmaw_s.xmaw001,g_xmaw_s.xmaw002,l_xmaw011,l_xmaw012,l_xmaw031,l_xmaw032,l_xmaw013,l_xmaw019_s,l_xmaw020_s,l_xmaw021_s,l_xmaw022_s,l_xmaw023_s)
         #dorislai-2150626-modify----(E)                        
#                   IF NOT cl_null(l_xmaw017_s) THEN 
#                      LET m_xmaw019 = g_xmaw_s.xmaw019 + l_xmaw017_s
#                      LET m_xmaw020 = g_xmaw_s.xmaw020 + l_xmaw017_s
#                      LET m_xmaw021 = g_xmaw_s.xmaw021 + l_xmaw017_s
#                      LET m_xmaw022 = g_xmaw_s.xmaw022 + l_xmaw017_s
#                      LET m_xmaw023 = g_xmaw_s.xmaw023 + l_xmaw017_s
#                   END IF
#                   IF NOT cl_null(l_xmaw018_s) THEN 
#                      LET m_xmaw019 = g_xmaw_s.xmaw019 * (1+l_xmaw018_s/100)
#                      LET m_xmaw020 = g_xmaw_s.xmaw020 * (1+l_xmaw018_s/100)
#                      LET m_xmaw021 = g_xmaw_s.xmaw021 * (1+l_xmaw018_s/100)
#                      LET m_xmaw022 = g_xmaw_s.xmaw022 * (1+l_xmaw018_s/100)
#                      LET m_xmaw023 = g_xmaw_s.xmaw023 * (1+l_xmaw018_s/100)
#                   END IF    
#                   UPDATE xmaw_t SET xmaw019 = m_xmaw019,
#                                     xmaw020 = m_xmaw020,
#                                     xmaw021 = m_xmaw021,
#                                     xmaw022 = m_xmaw022,
#                                     xmaw023 = m_xmaw023
#                    WHERE xmawent = g_enterprise
#                      AND xmaw001 = l_xmaw001
#                      AND xmaw002 = l_xmaw001 
#                      AND xmaw011 = l_xmaw011_s
#                      AND xmaw012 = l_xmaw012_s
#                      AND xmaw013 = l_xmaw013
#             IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN 
#                LET r_success = 'N' 
#             END IF                        

         END FOREACH
         
      END IF  

      IF l_cnt = 0 THEN 
         LET r_flag = 'Y'   #add by lixh 20150525
         LET l_xmaw.xmaw001 = g_xmaw_s.xmaw001
         LET l_xmaw.xmaw002 = g_xmaw_s.xmaw002
         LET l_xmaw.xmaw011 = l_imaa001
         LET l_xmaw.xmaw012 = ' '
         LET l_xmaw.xmaw014 = 'N'
         LET l_xmaw.xmaw015 = l_imaa001
         LET l_xmaw.xmaw016 = ' '
         LET l_xmaw.xmaw017 = ''
         LET l_xmaw.xmaw018 = ''
         LET l_xmaw.xmaw019 = g_xmaw_s.xmaw019  
         LET l_xmaw.xmaw020 = g_xmaw_s.xmaw020
         LET l_xmaw.xmaw021 = g_xmaw_s.xmaw021
         LET l_xmaw.xmaw022 = g_xmaw_s.xmaw022
         LET l_xmaw.xmaw023 = g_xmaw_s.xmaw023
         LET l_xmaw.xmaw031 = ' '
         LET l_xmaw.xmaw032 = ' '
         LET l_xmaw.xmaw033 = ' '
         LET l_xmaw.xmaw034 = ' '
         LET l_xmaw.xmawstus = 'Y' 
       
         SELECT imaf113 INTO l_xmaw.xmaw013 FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = 'ALL'
            AND imaf001 = l_imaa001
         IF l_xmaw.xmaw013 IS NULL THEN
            LET l_xmaw.xmaw013 = ' '
         END IF         
         LET l_xmaw.xmawownid = g_user
         LET l_xmaw.xmawowndp = g_dept
         LET l_xmaw.xmawcrtid = g_user  
         LET l_xmaw.xmawcrtdp = g_dept
         LET l_xmaw.xmawcrtdt = cl_get_current()
         LET l_xmaw.xmawmodid = "" 
         LET l_xmaw.xmawmoddt = "" 
         LET l_xmaw.xmaw100 = ''
#         LET l_xmaw.xmaw024 = ' '
#         SELECT imaa009 INTO l_xmaw.xmaw025 FROM imaa_t
#          WHERE imaaent = g_enterprise
#            AND imaa001 = l_imaa001
         
         INSERT INTO xmaw_t
                           (xmawent,
                            xmaw001,xmaw002,
                            xmaw011,xmaw012,xmaw013,
                            xmawstus,xmaw014,xmaw015,xmaw016,xmaw017,xmaw018,xmaw019,xmaw020,xmaw021,xmaw022,xmaw023,xmaw031,
                            xmaw032,xmaw033,xmaw034,xmaw100,xmawownid,xmawowndp,xmawcrtid,xmawcrtdp,xmawcrtdt,xmawmodid,
                            xmawmoddt) 
                     VALUES(g_enterprise,
                            l_xmaw.xmaw001,l_xmaw.xmaw002,
                            l_xmaw.xmaw011,l_xmaw.xmaw012,l_xmaw.xmaw013,
                            l_xmaw.xmawstus,l_xmaw.xmaw014,l_xmaw.xmaw015,l_xmaw.xmaw016, 
                                l_xmaw.xmaw017,l_xmaw.xmaw018,l_xmaw.xmaw019, 
                                l_xmaw.xmaw020,l_xmaw.xmaw021,l_xmaw.xmaw022, 
                                l_xmaw.xmaw023,l_xmaw.xmaw031,l_xmaw.xmaw032,
                                l_xmaw.xmaw033,l_xmaw.xmaw034,l_xmaw.xmaw100, 
                                l_xmaw.xmawownid,l_xmaw.xmawowndp,l_xmaw.xmawcrtid, 
                                l_xmaw.xmawcrtdp,l_xmaw.xmawcrtdt,l_xmaw.xmawmodid, 
                                l_xmaw.xmawmoddt)
                                
         IF SQLCA.sqlcode THEN
            LET r_success = 'N'
            EXIT FOREACH
         END IF                                                               
      END IF
   END FOREACH  
   CALL cl_err_collect_show()     #add by lixh 20150623   
   IF r_success = 'Y' AND r_flag = 'Y' THEN      
      CALL s_transaction_end('Y','0')
     #提示
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00088'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL s_transaction_end('N','0')
     #提示 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00089'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF      
END FUNCTION
################################################################################
# Descriptions...: 檢查料號是否被其他資料參考
# Memo...........:
# Usage..........: CALL axmi129_xmaw011_chk()
# Date & Author..: 2014/02/26 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw011_chk()
DEFINE   l_cnt       LIKE type_t.num5

   LET l_cnt = 0
   IF NOT cl_null(g_xmaw_m.xmaw001) AND NOT cl_null(g_xmaw_m.xmaw002) AND NOT cl_null(g_xmaw_d[l_ac].xmaw011) 
      AND g_xmaw_d[l_ac].xmaw012 IS NOT NULL AND NOT cl_null(g_xmaw_d[l_ac].xmaw013) THEN
      SELECT COUNT(xmaw001) INTO l_cnt FROM xmaw_t
       WHERE xmawent = g_enterprise
         AND xmaw001 = g_xmaw_m.xmaw001
         AND xmaw002 = g_xmaw_m.xmaw002
         AND xmaw013 = g_xmaw_d_t.xmaw013
         AND xmaw015 = g_xmaw_d_t.xmaw011
         AND xmaw016 = g_xmaw_d_t.xmaw012
         AND (xmaw011 != g_xmaw_d_t.xmaw011 OR xmaw012 != g_xmaw_d_t.xmaw012)                 
         AND xmawstus = 'Y' 
         
      IF l_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00082'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_xmaw_d[l_ac].xmaw011 = g_xmaw_d_t.xmaw011
         LET g_xmaw_d[l_ac].xmaw012 = g_xmaw_d_t.xmaw012
         LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
         LET g_xmaw_d[l_ac].xmaw015 = g_xmaw_d_t.xmaw015
         LET g_xmaw_d[l_ac].xmaw016 = g_xmaw_d_t.xmaw016 
         CALL axmi129_xmaw011_ref()
         CALL axmi129_xmaw015_ref()
         CALL axmi129_xmaw013_ref()
         DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw012,g_xmaw_d[l_ac].xmaw013
         DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011_desc,g_xmaw_d[l_ac].xmaw011_desc_desc,g_xmaw_d[l_ac].xmaw013_desc   
         DISPLAY BY NAME g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw016
         RETURN FALSE
      END IF  
   END IF 
   RETURN TRUE   
END FUNCTION
################################################################################
# Descriptions...: 帶出參照表號說明
# Memo...........:
# Usage..........: CALL axmi129_s_xmaw001_ref()
#                  RETURNING 回传参数
# Date & Author..: 2014/03/05 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_s_xmaw001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_s.xmaw001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='15' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_s.xmaw001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmaw_s.xmaw001_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmi129_xmaw_desc(p_s,p_r)
# Input parameter: p_s            舍  
#                : p_r            入
# Date & Author..: 2014/03/04 By lixh者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw_desc(p_s,p_r)
DEFINE p_s                  LIKE type_t.num5
DEFINE p_r                  LIKE type_t.num5
DEFINE l_gzze003            LIKE gzze_t.gzze003
DEFINE l_gzze003_1          LIKE gzze_t.gzze003
DEFINE l_msg                STRING
      LET l_msg =''
      LET l_gzze003 = ''
      LET l_gzze003_1 = ''
      SELECT gzze003 INTO l_gzze003
        FROM gzze_t
       WHERE gzze001 = 'axm-00102'
         AND gzze002 = g_dlang
      SELECT gzze003 INTO l_gzze003_1
        FROM gzze_t
       WHERE gzze001 = 'axm-00103'
         AND gzze002 = g_dlang
      LET l_msg = l_gzze003,p_s,',',l_gzze003_1,p_r
      ERROR l_msg
END FUNCTION
################################################################################
# Descriptions...: 根據加減百分比、取位計算價格
# Memo...........:
# Usage..........: CALL axmi129_get_price(p_price,p_rate,p_w,p_s,p_r)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_get_price(p_price,p_rate,p_w,p_s,p_r)
   DEFINE   p_price      LIKE xmaw_t.xmaw019
   DEFINE   p_rate       LIKE xmaw_t.xmaw019
   DEFINE   p_w          LIKE gzcb_t.gzcb002
   DEFINE   p_r          LIKE type_t.num5
   DEFINE   p_s          LIKE type_t.num5
   DEFINE   l_price      LIKE xmaw_t.xmaw019 
   DEFINE   l_num        LIKE type_t.num20
   DEFINE   l_num1       LIKE xmaw_t.xmaw019 
   DEFINE   l_num_s      LIKE xmaw_t.xmaw019 
   DEFINE   l_num2       LIKE type_t.num20
   
   
   IF NOT cl_null(p_price) AND NOT cl_null(p_rate) AND NOT cl_null(p_w) THEN
      #add by lixh 20150603  #配合SCC碼調整
      SELECT gzcbl004 INTO p_w FROM gzcbl_t
       WHERE gzcbl001 = '2078'
         AND gzcbl002 = p_w
         AND gzcbl003 = g_lang   
      #add by lixh 20150603    
      IF cl_null(p_s) AND cl_null(p_r) THEN
         LET l_price = p_price * (1+p_rate/100)
         RETURN l_price
      END IF   
      LET l_num_s = p_price * (1+p_rate/100)/p_w
      CALL s_num_round(3,l_num_s,'') RETURNING l_num
      LET l_num1 = (p_price * (1+p_rate/100)/p_w - l_num)*10
      CALL s_num_round(3,l_num1,'') RETURNING l_num2 
      
      IF NOT cl_null(p_s) AND NOT cl_null(p_r) THEN
         IF l_num2 > = p_r THEN
            LET l_price = (l_num+1) * p_w
         ELSE
            LET l_price = l_num * p_w         
         END IF
      END IF


      IF p_s >= 0 AND cl_null(p_r) THEN
         LET l_price = l_num * p_w       
      END IF
      IF cl_null(p_s) AND p_r >= 0 THEN
         LET l_price = (l_num+1) * p_w
      END IF
   END IF
   RETURN l_price
   
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axmi129_s_xmaw002_ref()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_s_xmaw002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_s.xmaw002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_s.xmaw002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmaw_s.xmaw002_desc
END FUNCTION
################################################################################
# Descriptions...: axmi129_set_required_b()
# Memo...........:
# Usage..........: CALL axmi129_set_required_b()
# Date & Author..:2014/03/14 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_set_required_b()
   IF g_xmaw_d[l_ac].xmaw014 = 'Y' AND cl_null(g_xmaw_d[l_ac].xmaw017) AND cl_null(g_xmaw_d[l_ac].xmaw017) THEN   
      CALL cl_set_comp_required('xmaw017',TRUE)
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 檢查料號之間的參考關係是否形成無窮迴圈
# Memo...........:
# Usage..........: CALL axmi129_xmaw015_upd_chk(p_xmaw015,p_xmaw016)

# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw015_upd_chk(p_xmaw015,p_xmaw016)
   DEFINE   p_xmaw015      LIKE xmaw_t.xmaw015
   DEFINE   p_xmaw016      LIKE xmaw_t.xmaw016
   DEFINE   l_xmaw013      LIKE xmaw_t.xmaw013
   DEFINE   l_xmaw015      LIKE xmaw_t.xmaw015
   DEFINE   l_xmaw016      LIKE xmaw_t.xmaw016
   DEFINE   l_xmaw033      LIKE xmaw_t.xmaw033
   DEFINE   l_xmaw034      LIKE xmaw_t.xmaw034
   DEFINE   l_chk          LIKE type_t.num5

   IF p_xmaw015 IS NULL AND p_xmaw016 IS NULL THEN
      RETURN
   END IF   
     
   IF g_xmaw_d[l_ac].xmaw014 = 'Y' THEN
       #dorislai-20150627-modify----(S)
#      SELECT xmaw015,xmaw016 INTO l_xmaw015,l_xmaw016 FROM xmaw_t 
#       WHERE xmawent = g_enterprise
#         AND xmaw001 = g_xmaw_m.xmaw001
#         AND xmaw002 = g_xmaw_m.xmaw002
#         AND xmaw011 = p_xmaw015
#         AND xmaw012 = p_xmaw016
#         AND xmaw013 = g_xmaw_d[l_ac].xmaw013
#         AND xmaw014 = 'Y'
      LET l_chk = FALSE 
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN       #若料號有值
         SELECT xmaw013,xmaw015,xmaw016 INTO l_xmaw013,l_xmaw015,l_xmaw016 FROM xmaw_t 
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw011 = p_xmaw015
            AND xmaw012 = p_xmaw016
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw014 = 'Y'
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw015 = g_xmaw_d[l_ac].xmaw011 AND l_xmaw016 = g_xmaw_d[l_ac].xmaw012 THEN
            LET l_chk = TRUE
         END IF
      END IF
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN       #若系列有值
         SELECT xmaw013,xmaw033 INTO l_xmaw013,l_xmaw033 FROM xmaw_t 
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw011 = p_xmaw015
            AND xmaw012 = p_xmaw016
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw014 = 'Y'
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw033 = g_xmaw_d[l_ac].xmaw031 THEN       #若產品分類有值
            LET l_chk = TRUE
         END IF
      END IF
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN
         SELECT xmaw013,xmaw034 INTO l_xmaw013,l_xmaw034 FROM xmaw_t 
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw011 = p_xmaw015
            AND xmaw012 = p_xmaw016
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw014 = 'Y'
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw034 = g_xmaw_d[l_ac].xmaw032 THEN
            LET l_chk = TRUE
         END IF
      END IF  
#      IF l_xmaw015 = g_xmaw_d[l_ac].xmaw011 AND l_xmaw016 = g_xmaw_d[l_ac].xmaw012 THEN
      IF l_chk THEN
      #dorislai-20150627-modify----(E)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00160'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = 'N'
         RETURN  
      ELSE
         CALL axmi129_xmaw015_upd_chk(l_xmaw015,l_xmaw016)
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: axmi129_set_no_required_b()
# Memo...........:
# Usage..........: CALL axmi129_set_no_required_b()
# Date & Author..: 2014/03/14 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_set_no_required_b()
   CALL cl_set_comp_required('xmaw017,xmaw018',FALSE)
   CALL cl_set_comp_required("xmaw011,xmaw031,xmaw032",FALSE) 
END FUNCTION
################################################################################
# Descriptions...: 帶出參照表說明
# Usage..........: axmi129_xmaw001_ref(p_xmaw001)
# Input parameter: p_xmaw001  參考表號
# Date & Author..: 2014/02/10 By lixh
################################################################################
PRIVATE FUNCTION axmi129_xmaw001_ref_1(p_xmaw001)
DEFINE   p_xmaw001     LIKE xmaw_t.xmaw001
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xmaw001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='15' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_s.xmaw001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmaw_s.xmaw001_desc
END FUNCTION
################################################################################
# Descriptions...: 帶出基礎幣別說明
# Usage..........: axmi129_xmaw002_ref_1(p_xmaw002)
# Input parameter: p_xmaw002   基礎幣別
# Date & Author..: 2014/02/10 By lixh
################################################################################
PRIVATE FUNCTION axmi129_xmaw002_ref_1(p_xmaw002)
DEFINE   p_xmaw002     LIKE xmaw_t.xmaw002 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xmaw002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_s.xmaw002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmaw_s.xmaw002_desc
END FUNCTION

################################################################################
# Descriptions...: 默認帶出產品特徵
# Memo...........:
# Usage..........: CALL axmi129_auto_xmaw016()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_auto_xmaw016()
DEFINE  l_sql    STRING
   IF g_xmaw_d[l_ac].xmaw016 IS NOT NULL THEN
      RETURN
   END IF   
   LET l_sql = " SELECT DISTINCT xmaw012 FROM xmaw_t",
               "  WHERE xmawent = '",g_enterprise,"'",
               "    AND xmaw001 = '",g_xmaw_m.xmaw001,"'",
               "    AND xmaw002 = '",g_xmaw_m.xmaw002,"'",
               "    AND xmaw011 = '",g_xmaw_d[l_ac].xmaw015,"'",
               "    AND xmaw013 = '",g_xmaw_d[l_ac].xmaw013,"'",
               "    AND (xmaw011 != '",g_xmaw_d[l_ac].xmaw011,"'", " OR xmaw012 != '",g_xmaw_d[l_ac].xmaw012,"')"


   PREPARE axmi129_xmaw012 FROM l_sql
   DECLARE axmi129_cs CURSOR FOR axmi129_xmaw012    
 
   FOREACH axmi129_cs INTO g_xmaw_d[l_ac].xmaw016
      EXIT FOREACH
   END FOREACH
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw016
END FUNCTION

################################################################################
# Descriptions...: 清空料件編號相關欄位
# Memo...........:
# Usage..........: CALL axmi129_xmaw011_clear()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/09 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw011_clear()
   LET g_xmaw_d[l_ac].xmaw011 = ''            #清空料件編號
   LET g_xmaw_d[l_ac].xmaw011_desc = ''       #清空品名
   LET g_xmaw_d[l_ac].xmaw011_desc_desc = ''  #清空規格
   LET g_xmaw_d[l_ac].xmaw012 = ''            #清空產品特徵
   LET g_xmaw_d[l_ac].xmaw012_desc = ''       #清空產品特徵說明
   LET g_xmaw_d_o.xmaw011 = ''                #清空料號舊值
   CAll axmi129_set_no_entry_b("")
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw011,g_xmaw_d[l_ac].xmaw011_desc,g_xmaw_d[l_ac].xmaw011_desc_desc
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw012,g_xmaw_d[l_ac].xmaw012_desc
   IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN 
      LET g_xmaw_d[l_ac].xmaw015 = ''            #清空參考料件編號
      LET g_xmaw_d[l_ac].xmaw015_desc = ''       #清空參考品名
      LET g_xmaw_d[l_ac].xmaw015_desc_desc = ''  #清空參考規格
      LET g_xmaw_d[l_ac].xmaw016 = ''            #清空參考產品特徵
      DISPLAY BY NAME g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw015_desc,g_xmaw_d[l_ac].xmaw015_desc_desc
      DISPLAY BY NAME g_xmaw_d[l_ac].xmaw016
   END IF
END FUNCTION

################################################################################
# Descriptions...: 清空系列相關欄位
# Memo...........:
# Usage..........: CALL axmi129_xmaw031_clear()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/09 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw031_clear()
   LET g_xmaw_d[l_ac].xmaw031 = ''        #清空系列
   LET g_xmaw_d[l_ac].xmaw031_desc=''     #清空系列說明  
   LET g_xmaw_d_o.xmaw031 = ''            #清空系列舊值
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw031,g_xmaw_d[l_ac].xmaw031_desc
   IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
      LET g_xmaw_d[l_ac].xmaw033 = ''        #清空參考系列
      LET g_xmaw_d[l_ac].xmaw033_desc=''     #清空參考系列說明
      DISPLAY BY NAME g_xmaw_d[l_ac].xmaw033,g_xmaw_d[l_ac].xmaw033_desc
   END IF
END FUNCTION

################################################################################
# Descriptions...: 清空產品分類相關欄位
# Memo...........:
# Usage..........: CALL axmi129_xmaw032_clear()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/09 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw032_clear()
   LET g_xmaw_d[l_ac].xmaw032 = ''        #清空產品分類
   LET g_xmaw_d[l_ac].xmaw032_desc=''     #清空產品分類說明   
   LET g_xmaw_d_o.xmaw032 = ''            #清空產品分類舊值
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw032,g_xmaw_d[l_ac].xmaw032_desc
   IF g_xmaw_d[l_ac].xmaw014 = 'N' THEN
      LET g_xmaw_d[l_ac].xmaw034 = ''        #清空參考產品分類
      LET g_xmaw_d[l_ac].xmaw034_desc=''     #清空參考產品分類說明
      DISPLAY BY NAME g_xmaw_d[l_ac].xmaw034,g_xmaw_d[l_ac].xmaw034_desc
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 系列相關说明
# Memo...........:
# Usage..........: CALL axmi129_xmaw031_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/09 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw031_ref()
   #抓取系列說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw031
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql001='2003' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_d[l_ac].xmaw031_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw031_desc

END FUNCTION

################################################################################
# Descriptions...: 產品分類說明
# Memo...........:
# Usage..........: CALL axmi129_xmaw032_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/09 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw032_ref()
   #抓取產品分類說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw032
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_d[l_ac].xmaw032_desc =g_rtn_fields[1]
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw032_desc
END FUNCTION

################################################################################
# Descriptions...: 參考系列相關说明
# Memo...........:
# Usage..........: CALL axmi129_xmaw033_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/10 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw033_ref()
   #抓取參考系列說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw033
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql001='2003' AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_d[l_ac].xmaw033_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw033_desc

END FUNCTION

################################################################################
# Descriptions...: 參考產品分類說明
# Memo...........:
# Usage..........: CALL axmi129_xmaw034_ref()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/10 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw034_ref()
   #抓取參考產品分類說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw034
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmaw_d[l_ac].xmaw034_desc =g_rtn_fields[1]
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw034_desc
END FUNCTION

################################################################################
# Descriptions...: 清空參考系列相關欄位
# Memo...........:
# Usage..........: CALL axmi129_xmaw033_clear()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/11 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw033_clear()
   LET g_xmaw_d[l_ac].xmaw033 = ''        #清空參考系列
   LET g_xmaw_d[l_ac].xmaw033_desc=''     #清空參考系列說明
   LET g_xmaw_d_o.xmaw033 = ''            #清空參考系列舊值
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw033,g_xmaw_d[l_ac].xmaw033_desc
END FUNCTION

################################################################################
# Descriptions...: 清空參考產品分類相關欄位
# Memo...........:
# Usage..........: CALL axmi129_xmaw034_clear()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/09 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw034_clear()
   LET g_xmaw_d[l_ac].xmaw034 = ''        #清空參考產品分類
   LET g_xmaw_d[l_ac].xmaw034_desc=''     #清空參考產品分類說明
   LET g_xmaw_d_o.xmaw034 = ''            #清空參考產品分類舊值
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw034,g_xmaw_d[l_ac].xmaw034_desc
END FUNCTION

################################################################################
# Descriptions...: 清空參考料件編號相關欄位
# Memo...........:
# Usage..........: CALL axmi129_xmaw015_clear()
# Input parameter: 
# Return code....: 
# Date & Author..: 15/06/12 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw015_clear()
   LET g_xmaw_d[l_ac].xmaw015 = ''            #清空參考料件編號
   LET g_xmaw_d[l_ac].xmaw015_desc = ''       #清空參考品名
   LET g_xmaw_d[l_ac].xmaw015_desc_desc = ''  #清空參考規格
   LET g_xmaw_d[l_ac].xmaw016 = ''            #清空參考產品特徵
   LET g_xmaw_d_o.xmaw015 = ''                #清空參考料號舊值
   
   CAll axmi129_set_no_entry_b("")
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw015,g_xmaw_d[l_ac].xmaw015_desc,g_xmaw_d[l_ac].xmaw015_desc_desc
   DISPLAY BY NAME g_xmaw_d[l_ac].xmaw016
END FUNCTION

################################################################################
# Descriptions...: 檢查系列是否被其他資料參考
# Memo...........:
# Usage..........: CALL axmi129_xmaw031_chk()
# Date & Author..: 2014/06/13 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw031_chk()
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_msg       STRING
   LET l_cnt = 0
   IF NOT cl_null(g_xmaw_m.xmaw001) AND NOT cl_null(g_xmaw_m.xmaw002) AND NOT cl_null(g_xmaw_d[l_ac].xmaw031)  AND NOT cl_null(g_xmaw_d[l_ac].xmaw013) THEN
      SELECT COUNT(xmaw001) INTO l_cnt FROM xmaw_t
       WHERE xmawent = g_enterprise
         AND xmaw001 = g_xmaw_m.xmaw001
         AND xmaw002 = g_xmaw_m.xmaw002
         AND xmaw013 = g_xmaw_d_t.xmaw013
         AND xmaw033 = g_xmaw_d_t.xmaw031
         AND xmaw031 != g_xmaw_d_t.xmaw031                
         AND xmawstus = 'Y' 
         
      IF l_cnt > 0 THEN
         CALL cl_getmsg('axm-00648',g_lang) RETURNING l_msg
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00682'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_msg
         CALL cl_err()

         LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
         LET g_xmaw_d[l_ac].xmaw033 = g_xmaw_d_t.xmaw031   
         DISPLAY BY NAME g_xmaw_d[l_ac].xmaw013,g_xmaw_d[l_ac].xmaw013_desc
         DISPLAY BY NAME g_xmaw_d[l_ac].xmaw031,g_xmaw_d[l_ac].xmaw031_desc
         CALL axmi129_xmaw013_ref()
         CALL axmi129_xmaw031_ref()
         
         RETURN FALSE
      END IF  
   END IF 
   RETURN TRUE   

END FUNCTION

################################################################################
# Descriptions...: 檢查產品分類是否被其他資料參考
# Memo...........:
# Usage..........: CALL axmi129_xmaw032_chk()
# Return code....: 回傳TRUE或FALSE
# Date & Author..: 2014/06/13 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw032_chk()
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_msg       STRING
   LET l_cnt = 0
   
   IF NOT cl_null(g_xmaw_m.xmaw001) AND NOT cl_null(g_xmaw_m.xmaw002) AND NOT cl_null(g_xmaw_d[l_ac].xmaw032)  AND NOT cl_null(g_xmaw_d[l_ac].xmaw013) THEN
      SELECT COUNT(xmaw001) INTO l_cnt FROM xmaw_t
       WHERE xmawent = g_enterprise
         AND xmaw001 = g_xmaw_m.xmaw001
         AND xmaw002 = g_xmaw_m.xmaw002
         AND xmaw013 = g_xmaw_d_t.xmaw013
         AND xmaw034 = g_xmaw_d_t.xmaw032
         AND xmaw032 != g_xmaw_d_t.xmaw032                
         AND xmawstus = 'Y' 
         
      IF l_cnt > 0 THEN
         CALL cl_getmsg('axm-00649',g_lang) RETURNING l_msg
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00682'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_msg
         CALL cl_err()
         LET g_xmaw_d[l_ac].xmaw013 = g_xmaw_d_t.xmaw013
         LET g_xmaw_d[l_ac].xmaw034 = g_xmaw_d_t.xmaw032   
         DISPLAY BY NAME g_xmaw_d[l_ac].xmaw013,g_xmaw_d[l_ac].xmaw013_desc
         DISPLAY BY NAME g_xmaw_d[l_ac].xmaw032,g_xmaw_d[l_ac].xmaw032_desc
         CALL axmi129_xmaw013_ref()
         CALL axmi129_xmaw032_ref()

         RETURN FALSE
      END IF  
   END IF 
   RETURN TRUE

END FUNCTION

################################################################################
# Descriptions...: 檢查產品分類之間的參考關係是否形成無窮迴圈
# Memo...........:
# Usage..........: CALL axmi129_xmaw034_upd_chk()
#                  RETURNING TRUE/FALSE
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Date & Author..: 2015/06/13 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw034_upd_chk()
   DEFINE   l_xmaw013       LIKE xmaw_t.xmaw013
   DEFINE   l_xmaw015       LIKE xmaw_t.xmaw015
   DEFINE   l_xmaw016       LIKE xmaw_t.xmaw016
   DEFINE   l_xmaw033       LIKE xmaw_t.xmaw033
   DEFINE   l_xmaw034       LIKE xmaw_t.xmaw034
   DEFINE   l_chk           LIKE type_t.num5
   IF g_xmaw_d[l_ac].xmaw034 IS NULL THEN
      RETURN TRUE
   END IF 
   LET l_chk= FALSE
   IF g_xmaw_d[l_ac].xmaw014 = 'Y' THEN
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN        #若料號有值
         SELECT xmaw013,xmaw015,xmaw016 INTO l_xmaw013,l_xmaw015,l_xmaw016 FROM xmaw_t 
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw032 = g_xmaw_d[l_ac].xmaw034
            AND xmaw014 = 'Y'
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw015 = g_xmaw_d[l_ac].xmaw011 AND l_xmaw016 = g_xmaw_d[l_ac].xmaw012 THEN
            LET l_chk = TRUE
         END IF   
      END IF
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN        #若系列有值    
         SELECT xmaw013,xmaw033 INTO l_xmaw013,l_xmaw033 FROM xmaw_t
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw032 = g_xmaw_d[l_ac].xmaw034
            AND xmaw014 = 'Y'
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw033 = g_xmaw_d[l_ac].xmaw031 THEN
            LET l_chk = TRUE
         END IF   
      END IF
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN        #若產品分類有值
         SELECT xmaw013,xmaw034 INTO l_xmaw013,l_xmaw034 FROM xmaw_t
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw032 = g_xmaw_d[l_ac].xmaw034
            AND xmaw014 = 'Y'
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw034 = g_xmaw_d[l_ac].xmaw032 THEN
            LET l_chk = TRUE
         END IF
      END IF
     
      IF l_chk THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00684'
         LET g_errparam.extend = g_xmaw_d[l_ac].xmaw034
         LET g_errparam.popup = TRUE
         LET g_xmaw_d[l_ac].xmaw034 = ''
         CALL cl_err()   
         RETURN FALSE         
      END IF
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 檢查系列之間的參考關係是否形成無窮迴圈
# Memo...........:
# Usage..........: CALL axmi129_xmaw033_upd_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Date & Author..: 2015/06/13 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw033_upd_chk()
   DEFINE   l_xmaw013       LIKE xmaw_t.xmaw013
   DEFINE   l_xmaw015       LIKE xmaw_t.xmaw015
   DEFINE   l_xmaw016       LIKE xmaw_t.xmaw016
   DEFINE   l_xmaw033       LIKE xmaw_t.xmaw033
   DEFINE   l_xmaw034       LIKE xmaw_t.xmaw034
   DEFINE   l_chk           LIKE type_t.num5
   
   IF g_xmaw_d[l_ac].xmaw033 IS NULL THEN
      RETURN TRUE
   END IF 
   LET l_chk = FALSE
   IF g_xmaw_d[l_ac].xmaw014 = 'Y' THEN
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) THEN       #若料號有值
         SELECT xmaw013,xmaw015,xmaw016 INTO l_xmaw013,l_xmaw015,l_xmaw016 FROM xmaw_t 
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw031 = g_xmaw_d[l_ac].xmaw033
            AND xmaw014 = 'Y'
          IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw015 = g_xmaw_d[l_ac].xmaw011 AND l_xmaw016 = g_xmaw_d[l_ac].xmaw012 THEN
            LET l_chk = TRUE
         END IF 
      END IF
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN       #若系列有值
         SELECT xmaw013,xmaw033 INTO l_xmaw013,l_xmaw033 FROM xmaw_t
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw031 = g_xmaw_d[l_ac].xmaw033
            AND xmaw014 = 'Y'
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw033 = g_xmaw_d[l_ac].xmaw031 THEN
            LET l_chk = TRUE
         END IF
      END IF  
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN       #若產品分類有值
         SELECT xmaw013,xmaw034 INTO l_xmaw013,l_xmaw034 FROM xmaw_t
          WHERE xmawent = g_enterprise
            AND xmaw001 = g_xmaw_m.xmaw001
            AND xmaw002 = g_xmaw_m.xmaw002
            AND xmaw013 = g_xmaw_d[l_ac].xmaw013
            AND xmaw032 = g_xmaw_d[l_ac].xmaw033
            AND xmaw014 = 'Y'
         IF l_xmaw013 = g_xmaw_d[l_ac].xmaw013 AND l_xmaw034 = g_xmaw_d[l_ac].xmaw032 THEN
            LET l_chk = TRUE
         END IF
      END IF      
      
      IF l_chk THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00683'
         LET g_errparam.extend = g_xmaw_d[l_ac].xmaw033
         LET g_errparam.popup = TRUE
         LET g_xmaw_d[l_ac].xmaw033 = ''
         CALL cl_err()   
         RETURN FALSE         
      END IF
   END IF 
   RETURN TRUE   
END FUNCTION

################################################################################
# Descriptions...: 系列或產品分類的單位校驗
# Memo...........:
# Usage..........: CALL axmi129_xmaw031_xmaw032_chk_unit()
#                  RETURNING TRUE/FALSE
# Input parameter: 回傳 TRUE/FALSE
# Return code....: 
# Date & Author..: 2015-06-18 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw031_xmaw032_chk_unit()
   DEFINE  l_sql                 STRING                               #抓取sql語法
   DEFINE  l_chk                 LIKE  type_t.num5                    #判斷是否有抓到符合的值
   DEFINE  l_imaa001             LIKE  type_t.chr100                  #接收抓取到的料件編號值

   #先依欄位抓取sql語法
      #---用系列去抓料件編號
   IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN
      LET l_sql = "SELECT imaa001 FROM imaa_t ",
                  "WHERE imaaent = '"||g_enterprise||"' AND imaa127 = '"||g_xmaw_d[l_ac].xmaw031||"'",
                  "ORDER BY imaa001"
   END IF
      #----用產品分類去抓料件編號
   IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN
      LET l_sql = "SELECT imaa001 FROM imaa_t ",
                  "WHERE imaaent = '"||g_enterprise||"' AND imaa009 = '"||g_xmaw_d[l_ac].xmaw032||"'",
                  "ORDER BY imaa001"
   END IF
               
   
   PREPARE axmi129_get_imaa001_chk_pre FROM l_sql
   DECLARE axmi129_get_imaa001_chk_curs CURSOR FOR axmi129_get_imaa001_chk_pre
   LET l_imaa001 =''
   LET l_chk = FALSE  #判斷是否有抓到符合的值
   #一筆一筆比對是否有符合任一 料件編號中的可使用單位
   FOREACH axmi129_get_imaa001_chk_curs INTO l_imaa001 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmaw_d[l_ac].xmaw013
      #以COUNT來計算，並判斷是否有比對到符合的資料
      CALL ap_ref_array2(g_ref_fields,"SELECT COUNT(*) FROM imao_t WHERE imaoent='"||g_enterprise||"' AND imao002 = ? AND imao001 = '"||l_imaa001||"'","") RETURNING g_rtn_fields
      IF g_rtn_fields[1] > 0 THEN
         LET l_chk = TRUE 
         EXIT FOREACH
      END IF 
   END FOREACH
   FREE  axmi129_get_imaa001_chk_pre  #已使用完畢，釋放
   #若料件編號中無相對應的可使用單位，跳出錯誤訊息提示
   IF NOT l_chk THEN
      RETURN FALSE
   END IF 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 參考系列校驗
# Usage..........: CALL axmi129_xmaw033_chk()
#                  RETURNING TRUE/FALSE
# Return code....: 回傳  TRUE/FALSE
# Date & Author..: 2015/06/18 By dorislai
################################################################################
PRIVATE FUNCTION axmi129_xmaw033_chk()
   DEFINE   l_xmaw001       LIKE xmaw_t.xmaw001
   DEFINE   l_xmawstus      LIKE xmaw_t.xmawstus
   DEFINE   l_msg           STRING
   DEFINE   l_sql           STRING
 

   IF g_xmaw_d[l_ac].xmaw014 = 'Y' AND NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND NOT cl_null(g_xmaw_d[l_ac].xmaw033) THEN 
      #比對是否存在於幣別的項目資料中
      LET l_sql = " SELECT xmaw001,xmawstus FROM xmaw_t",
                  "  WHERE xmawent = '",g_enterprise,"'" ,
                  "    AND xmaw001 = '",g_xmaw_m.xmaw001,"'",
                  "    AND xmaw002 = '",g_xmaw_m.xmaw002,"'",
                  "    AND xmaw013 = '",g_xmaw_d[l_ac].xmaw013,"'",
                  "    AND xmaw031 = '",g_xmaw_d[l_ac].xmaw033,"'"                     
      IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) THEN
         LET l_sql = l_sql clipped," AND xmaw031 !='",g_xmaw_d[l_ac].xmaw031,"'"
      END IF                             

  
      PREPARE axmi129_xmaw033 FROM l_sql
      EXECUTE axmi129_xmaw033 INTO l_xmaw001,l_xmawstus  
      FREE  axmi129_xmaw033  #已使用完畢，釋放
      
      IF cl_null(l_xmaw001) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00679'               
         LET g_errparam.extend = g_xmaw_d[l_ac].xmaw015
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
      IF l_xmawstus = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00685'               
         LET g_errparam.extend = g_xmaw_d[l_ac].xmaw015
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 參考產品分類校驗
# Usage..........: CALL axmi129_xmaw034_chk()
#                  RETURNING TRUE/FALSE
# Return code....: 回傳  TRUE/FALSE
# Date & Author..: 2015/06/18 By dorislai
################################################################################
PRIVATE FUNCTION axmi129_xmaw034_chk()
   DEFINE   l_xmaw001       LIKE xmaw_t.xmaw001
   DEFINE   l_xmawstus      LIKE xmaw_t.xmawstus
   DEFINE   l_msg           STRING
   DEFINE   l_sql           STRING
 
 
  IF g_xmaw_d[l_ac].xmaw014 = 'Y' AND NOT cl_null(g_xmaw_d[l_ac].xmaw013) AND NOT cl_null(g_xmaw_d[l_ac].xmaw034) THEN 
     #比對是否存在於幣別的項目資料中
     
     LET l_sql = " SELECT xmaw001,xmawstus FROM xmaw_t",
                 "  WHERE xmawent = '",g_enterprise,"'" ,
                 "    AND xmaw001 = '",g_xmaw_m.xmaw001,"'",
                 "    AND xmaw002 = '",g_xmaw_m.xmaw002,"'",
                 "    AND xmaw013 = '",g_xmaw_d[l_ac].xmaw013,"'",
                 "    AND xmaw032 = '",g_xmaw_d[l_ac].xmaw034,"'"                     
     IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) THEN
        LET l_sql = l_sql clipped," AND xmaw032 !='",g_xmaw_d[l_ac].xmaw032,"'"
     END IF                             
   
     PREPARE axmi129_xmaw034 FROM l_sql
     EXECUTE axmi129_xmaw034 INTO l_xmaw001,l_xmawstus
     FREE  axmi129_xmaw034  #已使用完畢，釋放
     
     IF cl_null(l_xmaw001) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00680'              
         LET g_errparam.extend = g_xmaw_d[l_ac].xmaw015
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
      IF l_xmawstus = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00686'               
         LET g_errparam.extend = g_xmaw_d[l_ac].xmaw015
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 料號、系列、產品分類欄位重複性檢查
# Memo...........:
# Usage..........: CALL axmi129_xmaw_rep_chk(l_field_num)
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Return code....: 回傳 TRUE/FALSE
# Date & Author..: 2015-06-20 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw_rep_chk(p_field_num)
   DEFINE  l_cnt  LIKE  type_t.num5
   DEFINE  l_sql  STRING
   DEFINE  p_field_num STRING
   IF cl_null(g_xmaw_d[l_ac].xmaw011) AND cl_null(g_xmaw_d[l_ac].xmaw031) 
      AND cl_null(g_xmaw_d[l_ac].xmaw032) OR cl_null(g_xmaw_d[l_ac].xmaw013) THEN
      RETURN TRUE
   END IF
   
   LET l_cnt = 0
   LET l_sql = " SELECT COUNT(*) FROM xmaw_t",
               " WHERE xmawent = '",g_enterprise,"'",
               "   AND xmaw001 = '",g_xmaw_m.xmaw001,"'",
               "   AND xmaw002 = '",g_xmaw_m.xmaw002,"'",              
               "   AND xmaw013 = '",g_xmaw_d[l_ac].xmaw013,"'"

   IF NOT cl_null(g_xmaw_d[l_ac].xmaw011) AND p_field_num = 1 THEN    
         LET l_sql = l_sql clipped," AND xmaw011 = '",g_xmaw_d[l_ac].xmaw011,"'",
                                   " AND xmaw012 = '",g_xmaw_d[l_ac].xmaw012,"'"
   END IF
   IF NOT cl_null(g_xmaw_d[l_ac].xmaw031) AND p_field_num = 2 THEN
      LET l_sql = l_sql clipped," AND xmaw031 = '",g_xmaw_d[l_ac].xmaw031,"'"
   END IF
   IF NOT cl_null(g_xmaw_d[l_ac].xmaw032) AND p_field_num = 3 THEN
      LET l_sql = l_sql clipped," AND xmaw032 = '",g_xmaw_d[l_ac].xmaw032,"'"
   END IF
   PREPARE axmi129_xmaw_rep_chk FROM l_sql
   EXECUTE axmi129_xmaw_rep_chk INTO l_cnt 
   FREE    axmi129_xmaw_rep_chk  #已使用完畢，釋放
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'std-00004'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 檢查同表號+幣別是否有符合的資料可參考
# Memo...........:
# Usage..........: CALL axmi129_xmaw014_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Return code....: 回傳 TRUE/FALSE
# Date & Author..: 20150629 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axmi129_xmaw014_chk()
   DEFINE l_cnt  LIKE  type_t.num5
   IF g_xmaw_d[l_ac].xmaw014 = 'Y'  THEN
      LET l_cnt = 1
      SELECT COUNT(*) INTO l_cnt 
        FROM xmaw_t 
       WHERE xmawent = g_enterprise 
         AND xmaw001 = g_xmaw_m.xmaw001  
         AND xmaw002 = g_xmaw_m.xmaw002
         AND xmawstus = 'Y'
         AND xmaw013 = COALESCE(g_xmaw_d[l_ac].xmaw013,' ')
         AND xmaw014 = 'N'
         AND NOT (     xmaw011 = COALESCE(g_xmaw_d[l_ac].xmaw011,' ')  
                   AND xmaw012 = COALESCE(g_xmaw_d[l_ac].xmaw012,' ')  
                   AND xmaw031 = COALESCE(g_xmaw_d[l_ac].xmaw031,' ')  
                   AND xmaw032 = COALESCE(g_xmaw_d[l_ac].xmaw032,' ')) 
      IF cl_null(l_cnt) OR l_cnt = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00697'
         LET g_errparam.extend = ""
         LET g_errparam.replace[1] = g_xmaw_m.xmaw001
         LET g_errparam.replace[2] = g_xmaw_m.xmaw002
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
      RETURN TRUE
   END IF
END FUNCTION

 
{</section>}
 
